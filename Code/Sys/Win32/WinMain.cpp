// LWSS: Created File for Win32 WinMain() and other related Windows Functionality

#include <core/defines.h>	

#include <Gfx/nx.h>

#include <windows.h>
#include <stdlib.h>		// atoi for the display launch-arg parser
#include <float.h>		// _controlfp_s for the NaN/Inf trap

#include <Gfx/DX9/NX/render.h>

// Temporarily in here
#include <dsound.h>
LPDIRECTSOUND8 ppDS8;
//LPDIRECTINPUT8 g_directInput8 = nullptr;
// ^^

bool g_isWindowInFocus = false;
bool g_windowJustWentOutOfFocus = false;
bool g_windowHasBeenDisplayedEver = false;
bool gbQuit = false;
bool g_hasJustEnteredNetworkGame = false; // KISAKTODO: add more xrefs for this var

namespace NxXbox { extern bool g_shadow_test; }
namespace Config { extern bool g_config_cd; }
extern bool g_loose_scripts;

// lwss add: runtime device-Reset support (apply resolution / graphics-settings
// changes without restarting the game). See D3D_ResetDevice() below.
namespace NxXbox
{
    UINT GetSelectedAdapter( void );
    void BuildPresentParams( UINT selected_adapter );
    void QueryRegistryAndSetGammaRamp( void );
}
namespace Nx
{
    void ResetSceneVertexBuffers( void );		// drop scene-owned shared VB refs (pre-Reset)
    void RecreateSceneVertexBuffers( void );	// recreate scene shared VBs + re-point wrappers (post-Reset)
}
// Set this true (from any thread / the WndProc) to have the render loop apply a
// device Reset between frames. Defined here, read in p_nx.cpp s_plat_pre_render.
extern "C" volatile bool g_pending_device_reset = false;
extern "C" void RequestDeviceReset( void ) { g_pending_device_reset = true; }
extern "C" bool g_vsync_enabled;	// defined elsewhere; needed by the debug hotkeys below
extern "C" unsigned long g_d3d_create_thread_id;	// DIAG: device-creation thread (defined in nx_init.cpp)

// DIAG: default-pool resource tracker. NO AddRef (the engine asserts refcount==0 on destroy, so
// we must not hold refs). Note() records the creation site by raw pointer; Forget() clears it on
// release. At Reset we print the sites still recorded = resources that never went through a known
// release path. We only print stored data (file:line) - never deref the pointer - so dangling is safe.
struct GfxTrackEntry { IUnknown* res; const char* file; int line; };
static const int GFXTRACK_MAX = 65536;
static GfxTrackEntry g_gfxTrack[GFXTRACK_MAX];
static int g_gfxTrackCount = 0;

void GfxTrack_Note( IUnknown* res, const char* file, int line )
{
    if (!res || g_gfxTrackCount >= GFXTRACK_MAX) return;
    g_gfxTrack[g_gfxTrackCount].res  = res;
    g_gfxTrack[g_gfxTrackCount].file = file;
    g_gfxTrack[g_gfxTrackCount].line = line;
    g_gfxTrackCount++;
}

void GfxTrack_Forget( IUnknown* res )
{
    if (!res) return;
    for (int i = g_gfxTrackCount - 1; i >= 0; --i)   // search back-to-front (most recent first)
    {
        if (g_gfxTrack[i].res == res)
        {
            g_gfxTrack[i].res = NULL;   // tombstone; leave slot (count not compacted)
            return;
        }
    }
}

void GfxTrack_ReportLeaks( void )
{
    // Aggregate surviving (un-forgotten) creations by site so the output is readable.
    int alive = 0;
    for (int i = 0; i < g_gfxTrackCount; i++)
    {
        if (!g_gfxTrack[i].res) continue;
        alive++;
        // Count how many at the same site, and tombstone them so each site prints once.
        int count = 0;
        const char* f = g_gfxTrack[i].file; int ln = g_gfxTrack[i].line;
        for (int j = i; j < g_gfxTrackCount; j++)
        {
            if (g_gfxTrack[j].res && g_gfxTrack[j].file == f && g_gfxTrack[j].line == ln)
            {
                g_gfxTrack[j].res = NULL;
                count++;
            }
        }
        printf("[gfx] default-pool created x%d at %s:%d\n", count, f, ln);
    }
    printf("[gfx] GfxTrack: %d default-pool resources created since boot (every creation site above)\n", alive);
    g_gfxTrackCount = 0;
}
// lwss end

BOOL(__cdecl* g_downloadCompletionFunc)(DWORD) = NULL;

static HANDLE hEvent = 0;

BOOL __cdecl DownloadCompletionFunc(DWORD a1)
{
    BOOL result = TRUE; // eax

    if (!a1)
    {
        printf("Download of content complete...\n");
        return SetEvent(hEvent);
    }
    return result;
}

void Win32_ProcessMsgPump()
{
    struct tagMSG Msg; // [esp+4h] [ebp-1Ch] BYREF

    while (PeekMessageA(&Msg, NxXbox::EngineGlobals.hWnd, 0, 0, 1u))
    {
        TranslateMessage(&Msg);
        DispatchMessageA(&Msg);
    }
}

void Win32_ApplyInputs()
{
    // KISAKTODO (This is keyboard Input)
}
void Win32_GameNetUpdate()
{
}


void D3D_ResetTextures()
{
    for (int i = 0; i < 8; i++)
    {
        D3DDevice_SetTexture(i, NULL);
    }

    // Only render-target textures need releasing for Reset(): they live in D3DPOOL_DEFAULT.
    // Ordinary textures are D3DPOOL_MANAGED (they survive Reset automatically) and keep NO
    // CPU copy here (texrawdata is freed after upload) - releasing them would permanently
    // blank every texture. Render targets are distinguished by a non-NULL pD3DSurface
    // (set in sTexture::SetRenderTarget); their contents are regenerated each frame, so
    // recreating them empty after Reset is fine. D3D_ReCreateTextures keys off pD3DTexture
    // being NULL, so leaving managed textures' pD3DTexture intact makes recreate skip them.
    // DIAG: count textures by pool. Any D3DPOOL_DEFAULT texture we DON'T release (because it has
    // no pD3DSurface) would silently block Reset. MANAGED (1)/SYSTEMMEM(2) survive Reset.
    {
        int tex_total = 0, tex_default = 0, tex_managed = 0, tex_other = 0, tex_default_nosurf = 0;
        for (NxXbox::LinkedList* j = NxXbox::g_sTexturesList; j; j = j->next)
        {
            NxXbox::sTexture* data = (NxXbox::sTexture*)j->data;
            if (!data || !data->pD3DTexture) continue;
            tex_total++;
            D3DSURFACE_DESC desc;
            if (data->pD3DTexture->GetLevelDesc(0, &desc) == D3D_OK)
            {
                if (desc.Pool == D3DPOOL_DEFAULT)
                {
                    tex_default++;
                    if (!data->pD3DSurface) tex_default_nosurf++;
                    if (tex_default <= 12)
                        printf("[gfx] DEFAULT-pool tex %dx%d usage=0x%X fmt=%d hasSurf=%d\n",
                            desc.Width, desc.Height, desc.Usage, (int)desc.Format, data->pD3DSurface ? 1 : 0);
                }
                else if (desc.Pool == D3DPOOL_MANAGED) tex_managed++;
                else tex_other++;
            }
        }
        printf("[gfx] DIAG textures live=%d  DEFAULT=%d (no-surface=%d)  MANAGED=%d  other=%d\n",
            tex_total, tex_default, tex_default_nosurf, tex_managed, tex_other);
    }

    int rt_count = 0;
    for (NxXbox::LinkedList* j = NxXbox::g_sTexturesList; j; j = j->next)
    {
        NxXbox::sTexture* data = (NxXbox::sTexture*)j->data;
        if (data->pD3DSurface)   // non-NULL => render target (D3DPOOL_DEFAULT)
        {
            ULONG rcs = data->pD3DSurface->Release();
            data->pD3DSurface = NULL;
            ULONG rct = 0;
            if (data->pD3DTexture)
            {
                rct = data->pD3DTexture->Release();
                data->pD3DTexture = NULL;
            }
            // DIAG: surface refcount should drop to its parent texture; texture should hit 0.
            printf("[gfx] render-target tex %dx%d release -> surf %lu tex %lu (tex expect 0)\n",
                data->BaseWidth, data->BaseHeight, rcs, rct);
            rt_count++;
        }
    }
    printf("[gfx] released %d render-target textures\n", rt_count);


    NxXbox::pTextureProjectionDetailsTable->IterateStart();
    NxXbox::sTextureProjectionDetails* p_details = NxXbox::pTextureProjectionDetailsTable->IterateNext();
    while (p_details)
    {
        NxXbox::sTexture* p_texture = p_details->p_texture;
        if (p_texture)
        {
            if (p_texture->pD3DSurface)
            {
                ULONG rr = p_texture->pD3DSurface->Release();
                Dbg_Assert(rr == 0);
            }
            if (p_texture->pD3DTexture)
            {
                ULONG rr = p_texture->pD3DTexture->Release();
                Dbg_Assert(rr == 0);
            }
        }
        p_details = NxXbox::pTextureProjectionDetailsTable->IterateNext();
    }
}
void D3D_ResetBuffers()
{
    D3DDevice_SetStreamSource(0, 0, 0, 0);
    D3DDevice_SetIndices(0);

    int vb_total = 0, vb_live = 0, vb_stuck = 0;
    for (NxXbox::LinkedList* vertItr = NxXbox::g_meshVertexBuffers; vertItr; vertItr = vertItr->next)
    {
        NxXbox::VertexBufferWrapper* data = (NxXbox::VertexBufferWrapper*)vertItr->data;
        if (data)
        {
            vb_total++;
            if (data->vertexBuffer)
            {
                vb_live++;
                ULONG rr = data->vertexBuffer->Release();
                // Independent wrappers (own buffer) must hit 0. Shared wrappers (FLAG_NO_CREATE,
                // pointing into a scene buffer) legitimately return >0 until the last ref.
                bool shared = (data->vertexWrapperCreationFlags & FLAG_NO_CREATE_VERTEX_BUFFER) != 0;
                if (rr != 0 && !shared)
                {
                    vb_stuck++;
                    if (vb_stuck <= 8)
                        printf("[gfx] STUCK vb wrapper '%s' refcount=%lu flags=0x%X len=%d\n",
                            data->debug_name[0] ? data->debug_name : "(noname)", rr, data->vertexWrapperCreationFlags, data->len);
                }
                data->vertexBuffer = NULL;
            }
        }
    }
    printf("[gfx] vertex wrappers: total=%d live=%d stuck(independent,refcount>0)=%d\n", vb_total, vb_live, vb_stuck);

    int ib_total = 0, ib_live = 0, ib_stuck = 0;
    for (NxXbox::LinkedList* indexItr = NxXbox::g_meshIndexBuffers; indexItr; indexItr = indexItr->next)
    {
        NxXbox::IndexBufferWrapper* data = (NxXbox::IndexBufferWrapper*)indexItr->data;
        if (data)
        {
            ib_total++;
            if (data->indexBuffer)
            {
                ib_live++;
                ULONG rr = data->indexBuffer->Release();
                if (rr != 0)
                {
                    ib_stuck++;
                    if (ib_stuck <= 8)
                        printf("[gfx] STUCK ib wrapper refcount=%lu len=%d\n", rr, data->len);
                }
                data->indexBuffer = NULL;
            }
        }
    }
    printf("[gfx] index wrappers: total=%d live=%d stuck(refcount>0)=%d\n", ib_total, ib_live, ib_stuck);

    // Now that every mesh wrapper has dropped its shared-buffer reference, drop the
    // scene-owned reference so each scene's D3DPOOL_DEFAULT vertex buffer is fully
    // released before Reset().
    Nx::ResetSceneVertexBuffers();
}
void D3D_ReleaseRenderSurfaces()
{
    // DIAG: each of these is the last reference we expect to hold; Release() should return 0.
    // A non-zero return marks a resource still referenced/bound -> Reset() fails (INVALIDCALL).
    NxXbox::EngineGlobals.p_RenderSurface = NULL;
    NxXbox::EngineGlobals.p_ZStencilSurface = NULL;

    if (NxXbox::EngineGlobals.p_BlurSurface_2)
        printf("[gfx] BlurSurface_2 release -> %lu\n", NxXbox::EngineGlobals.p_BlurSurface_2->Release());
    NxXbox::EngineGlobals.p_BlurSurface_2 = NULL;

    if (NxXbox::EngineGlobals.p_BlurSurface_3)
        printf("[gfx] BlurSurface_3 release -> %lu\n", NxXbox::EngineGlobals.p_BlurSurface_3->Release());
    NxXbox::EngineGlobals.p_BlurSurface_3 = NULL;

    if (NxXbox::EngineGlobals.p_BlurSurface_0)
        printf("[gfx] BlurSurface_0 release -> %lu\n", NxXbox::EngineGlobals.p_BlurSurface_0->Release());
    NxXbox::EngineGlobals.p_BlurSurface_0 = NULL;

    if (NxXbox::EngineGlobals.p_BlurSurface_1)
        printf("[gfx] BlurSurface_1 release -> %lu\n", NxXbox::EngineGlobals.p_BlurSurface_1->Release());
    NxXbox::EngineGlobals.p_BlurSurface_1 = NULL;

    // D3D_ReleaseVertexBuffer()
    if (NxXbox::EngineGlobals.p_vertex_buffer)
        printf("[gfx] scratch VB release -> %lu\n", NxXbox::EngineGlobals.p_vertex_buffer->Release());
    NxXbox::EngineGlobals.p_vertex_buffer = NULL;

    if (NxXbox::EngineGlobals.p_index_buffer)
        printf("[gfx] scratch IB release -> %lu\n", NxXbox::EngineGlobals.p_index_buffer->Release());
    NxXbox::EngineGlobals.p_index_buffer = NULL;
}
void D3D_ReCreateTextures()
{
    // Only the render targets released by D3D_ResetTextures have a NULL pD3DTexture here
    // (managed textures kept theirs). Recreate them as empty D3DPOOL_DEFAULT render targets;
    // their contents are regenerated each frame.
    for (NxXbox::LinkedList* i = NxXbox::g_sTexturesList; i; i = i->next)
    {
        NxXbox::sTexture* data = (NxXbox::sTexture*)i->data;
        if (!data->pD3DTexture)
        {
            D3DDevice_CreateTexture(data->BaseWidth, data->BaseHeight, 1, D3DUSAGE_RENDERTARGET, D3DFMT_A8R8G8B8, D3DPOOL_DEFAULT, &data->pD3DTexture, NULL);

            if (data->pD3DTexture)
                data->pD3DTexture->GetSurfaceLevel(0, &data->pD3DSurface);
        }
    }

    NxXbox::pTextureProjectionDetailsTable->IterateStart();
    NxXbox::sTextureProjectionDetails* p_details = NxXbox::pTextureProjectionDetailsTable->IterateNext();
    while (p_details)
    {
        NxXbox::sTexture* p_texture = p_details->p_texture;
        // Projection-target textures are also in g_sTexturesList, so the loop above already
        // recreated them; only handle any the loop missed.
        if (p_texture && !p_texture->pD3DTexture)
        {
            D3DDevice_CreateTexture(p_texture->BaseWidth, p_texture->BaseHeight, p_texture->Levels, D3DUSAGE_RENDERTARGET, D3DFMT_A8R8G8B8, D3DPOOL_DEFAULT, &p_texture->pD3DTexture, NULL);

            p_texture->pD3DTexture->GetSurfaceLevel(0, &p_texture->pD3DSurface);
        }
        p_details = NxXbox::pTextureProjectionDetailsTable->IterateNext();
    }
}
void D3D_ReCreateBuffers()
{
    // Recreate each loaded scene's shared vertex buffer and re-point the mesh
    // wrappers at it FIRST. The wrapper ReInitD3DBuffer() pass below then AddRef()s
    // the shared buffer and re-uploads each mesh's slice from its CPU shadow.
    Nx::RecreateSceneVertexBuffers();

    for (NxXbox::LinkedList* i = NxXbox::g_meshVertexBuffers; i; i = i->next)
    {
        if (i->data)
        {
            NxXbox::VertexBufferWrapper* v_data = (NxXbox::VertexBufferWrapper*)i->data;
            v_data->ReInitD3DBuffer();
        }
    }

    for (NxXbox::LinkedList* i = NxXbox::g_meshIndexBuffers; i; i = i->next)
    {
        if (i->data)
        {
            NxXbox::IndexBufferWrapper* i_data = (NxXbox::IndexBufferWrapper*)i->data;
            i_data->ReInitD3DBuffer();
        }
    }
}

namespace NxXbox
{
    void CreateVertexBufferPC(uint32 len);
    void CreateIndexBufferPC(uint32 len);

    void InitialiseRenderstates(void);
}

void D3D_RecreateRenderSurfaces()
{
    NxXbox::CreateVertexBufferPC(0x10000);
    NxXbox::CreateIndexBufferPC(0x1000);

#define params NxXbox::EngineGlobals.params

    D3DDevice_CreateTexture(
        params.BackBufferWidth, 
        params.BackBufferHeight, 
        1, 
        1, 
        params.BackBufferFormat, 
        D3DPOOL_DEFAULT, 
        &NxXbox::EngineGlobals.p_BlurSurface_2,
        NULL
    );

    D3DDevice_CreateDepthStencilSurface(
        params.BackBufferWidth, 
        params.BackBufferHeight, 
        params.AutoDepthStencilFormat, 
        D3DMULTISAMPLE_NONE, 
        0, 
        1, 
        &NxXbox::EngineGlobals.p_BlurSurface_3, 
        NULL
    );

    NxXbox::EngineGlobals.p_RenderSurface = NULL;
    NxXbox::EngineGlobals.p_ZStencilSurface = NULL;
    D3DDevice_GetRenderTarget(0, &NxXbox::EngineGlobals.p_RenderSurface);
    D3DDevice_GetDepthStencilSurface(&NxXbox::EngineGlobals.p_ZStencilSurface);

    if (NxXbox::EngineGlobals.p_RenderSurface)
        NxXbox::EngineGlobals.p_RenderSurface->Release();
    if (NxXbox::EngineGlobals.p_ZStencilSurface)
        NxXbox::EngineGlobals.p_ZStencilSurface->Release();

    D3DDevice_CreateTexture(
        params.BackBufferWidth, 
        params.BackBufferHeight,
        1,
        1, 
        params.BackBufferFormat,
        D3DPOOL_DEFAULT, 
        &NxXbox::EngineGlobals.p_BlurSurface_0, 
        NULL
    );

    D3DDevice_CreateDepthStencilSurface(
        params.BackBufferWidth, 
        params.BackBufferHeight, 
        params.AutoDepthStencilFormat, 
        D3DMULTISAMPLE_NONE, 
        0, 
        1,
        &NxXbox::EngineGlobals.p_BlurSurface_1, 
        NULL
    );

    NxXbox::InitialiseRenderstates();
#undef params
}

// lwss add: apply the current graphics settings to a live device via IDirect3DDevice9::Reset.
// Releases every D3DPOOL_DEFAULT resource (managed ones survive automatically), rebuilds the
// present params from EngineGlobals, Resets, then recreates everything. Must be called between
// frames (outside any BeginScene/EndScene pair) - see s_plat_pre_render in p_nx.cpp.
extern "C" bool D3D_ResetDevice( void )
{
    IDirect3DDevice9* dev = NxXbox::EngineGlobals.p_Device;
    if (dev == NULL)
        return false;

    // Remember the present params / window settings so we can roll back if Reset fails
    // (a failed Reset leaves the device in its previous state).
    D3DPRESENT_PARAMETERS saved_params = NxXbox::EngineGlobals.params;
    int  saved_w  = NxXbox::EngineGlobals.cmdline_width;
    int  saved_h  = NxXbox::EngineGlobals.cmdline_height;
    bool saved_fs = NxXbox::EngineGlobals.cmdline_fullscreen;

    // 0. Detach every default-pool resource from the device. A stream, texture, render
    //    target or depth-stencil left bound keeps an implicit reference and makes Reset()
    //    fail with D3DERR_INVALIDCALL - e.g. the shadow render-to-texture surface left bound.
    // DIAG: log what's actually bound as RT/depth at reset time BEFORE we touch anything.
    {
        IDirect3DSurface9* cur_rt = NULL;
        if (dev->GetRenderTarget(0, &cur_rt) == D3D_OK && cur_rt)
        {
            D3DSURFACE_DESC d; cur_rt->GetDesc(&d);
            printf("[gfx] DIAG bound RT before detach: %ux%u usage=0x%X pool=%d (backbuffer should be full-res)\n",
                d.Width, d.Height, d.Usage, (int)d.Pool);
            cur_rt->Release();
        }
        IDirect3DSurface9* cur_ds = NULL;
        if (dev->GetDepthStencilSurface(&cur_ds) == D3D_OK && cur_ds)
        {
            D3DSURFACE_DESC d; cur_ds->GetDesc(&d);
            printf("[gfx] DIAG bound depth before detach: %ux%u pool=%d\n", d.Width, d.Height, (int)d.Pool);
            cur_ds->Release();
        }
        else printf("[gfx] DIAG no depth bound before detach\n");
    }
    for (UINT s = 0; s < 8; ++s)
        dev->SetStreamSource(s, NULL, 0, 0);
    dev->SetIndices(NULL);
    for (DWORD t = 0; t < 16; ++t)
        dev->SetTexture(t, NULL);
    {
        // Clear the depth-stencil FIRST: SetRenderTarget fails if the bound depth is smaller than
        // the new RT (e.g. a 256x256 shadow depth still bound), which would leave the old RT bound.
        dev->SetDepthStencilSurface(NULL);
        IDirect3DSurface9* p_back = NULL;
        if (dev->GetBackBuffer(0, 0, D3DBACKBUFFER_TYPE_MONO, &p_back) == D3D_OK && p_back)
        {
            HRESULT srt = dev->SetRenderTarget(0, p_back);
            printf("[gfx] DIAG SetRenderTarget(backbuffer) -> 0x%08X (must be 0 to unbind a render-to-texture)\n", (unsigned)srt);
            p_back->Release();
        }
    }

    // 1. Release all default-pool resources.
    D3D_ResetTextures();            // g_sTexturesList + texture-projection render targets
    D3D_ResetBuffers();             // mesh vertex/index wrappers + scene shared vertex buffers
    D3D_ReleaseRenderSurfaces();    // blur surfaces + scratch vertex/index buffers

    // DIAG: name any default-pool resource the engine still holds (the Reset blocker) + drop tracker refs.
    GfxTrack_ReportLeaks();

    printf("[gfx] ---- release phase done ----\n");
    {
        HRESULT tcl = dev->TestCooperativeLevel();
        dev->AddRef();
        ULONG dev_rc = dev->Release();   // device refcount == 1 (ours) + living child resources
        printf("[gfx] DIAG TestCooperativeLevel=0x%08X  device refcount=%lu (1 + living resources)\n",
            (unsigned)tcl, dev_rc);
        // DIAG: is this native D3D9 or a translation layer (DXVK / dgVoodoo / D3D9On12)? That would
        // explain Reset rejecting everything. Also dump device creation behavior flags.
        if (NxXbox::EngineGlobals.p_d3d)
        {
            D3DADAPTER_IDENTIFIER9 id; ZeroMemory(&id, sizeof(id));
            if (NxXbox::EngineGlobals.p_d3d->GetAdapterIdentifier(NxXbox::GetSelectedAdapter(), 0, &id) == D3D_OK)
                printf("[gfx] DIAG adapter: '%s' driver='%s' (looks like a wrapper if it says DXVK/dgVoodoo/D3D9On12)\n",
                    id.Description, id.Driver);
        }
        {
            D3DDEVICE_CREATION_PARAMETERS cp; ZeroMemory(&cp, sizeof(cp));
            if (dev->GetCreationParameters(&cp) == D3D_OK)
                printf("[gfx] DIAG device creation: BehaviorFlags=0x%08X focusWnd=%p adapter=%u\n",
                    cp.BehaviorFlags, (void*)cp.hFocusWindow, cp.AdapterOrdinal);
        }
        printf("[gfx] DIAG thread: device created on %lu, reset running on %lu  (%s)\n",
            g_d3d_create_thread_id, GetCurrentThreadId(),
            g_d3d_create_thread_id == GetCurrentThreadId() ? "SAME" : "DIFFERENT - this breaks Reset!");
        // DIAG: Reset() fails with INVALIDCALL if the device is inside a BeginScene/EndScene block.
        // If EndScene() here returns D3D_OK, we WERE mid-scene when the reset fired - that's the bug.
        HRESULT es = dev->EndScene();
        printf("[gfx] DIAG EndScene() before reset -> 0x%08X  (0=we were mid-scene!)\n", (unsigned)es);

        // DIAG: a held reference to the implicit swap-chain / back buffer / auto depth-stencil
        // blocks Reset. GetX adds one ref; the printed count minus 1 is the EXTRA refs held
        // elsewhere. A back buffer with refs > its swap-chain baseline, or an auto depth with any
        // outstanding app ref, makes Reset fail with INVALIDCALL.
        {
            IDirect3DSurface9* bb = NULL;
            if (dev->GetBackBuffer(0, 0, D3DBACKBUFFER_TYPE_MONO, &bb) == D3D_OK && bb)
            {
                bb->AddRef(); ULONG rc = bb->Release();
                printf("[gfx] DIAG backbuffer refcount=%lu (after our GetBackBuffer +1)\n", rc);
                bb->Release();
            }
            IDirect3DSurface9* ds = NULL;
            if (dev->GetDepthStencilSurface(&ds) == D3D_OK && ds)
            {
                ds->AddRef(); ULONG rc = ds->Release();
                printf("[gfx] DIAG auto depth-stencil refcount=%lu (after our Get +1)\n", rc);
                ds->Release();
            }
            else
            {
                printf("[gfx] DIAG no depth-stencil currently set\n");
            }
            IDirect3DSwapChain9* sc = NULL;
            if (dev->GetSwapChain(0, &sc) == D3D_OK && sc)
            {
                sc->AddRef(); ULONG rc = sc->Release();
                printf("[gfx] DIAG swapchain(0) refcount=%lu\n", rc);
                sc->Release();
            }
            UINT nsc = dev->GetNumberOfSwapChains();
            printf("[gfx] DIAG number of swap chains=%u\n", nsc);
        }
        // DIAG PROBE B (runs FIRST - it's the ground-truth test): ask the swap chain for the device's
        // ACTUAL current present params and reset with those. Earlier F7 attempts left saved_params at a
        // different resolution than the device actually has, so this is the only true "unchanged" reset.
        // If even THIS fails, it's conclusively NOT our params struct - the device just won't Reset.
        HRESULT hrb = (HRESULT)0xDEADBEEF;
        D3DPRESENT_PARAMETERS scpp;
        ZeroMemory(&scpp, sizeof(scpp));
        IDirect3DSwapChain9* sc2 = NULL;
        HRESULT gsc = dev->GetSwapChain(0, &sc2);
        if (gsc == D3D_OK && sc2)
        {
            HRESULT gp = sc2->GetPresentParameters(&scpp);
            sc2->Release();
            printf("[gfx] DIAG swapchain params (gp=0x%08X): %dx%d windowed=%d fmt=%d swap=%d count=%d autoDS=%d dsFmt=%d pi=%u\n",
                (unsigned)gp, scpp.BackBufferWidth, scpp.BackBufferHeight, scpp.Windowed,
                (int)scpp.BackBufferFormat, (int)scpp.SwapEffect, scpp.BackBufferCount,
                scpp.EnableAutoDepthStencil, (int)scpp.AutoDepthStencilFormat, scpp.PresentationInterval);
            scpp.EnableAutoDepthStencil = TRUE;             // swap chain doesn't own the auto depth-stencil
            scpp.AutoDepthStencilFormat = D3DFMT_D24X8;
            scpp.hDeviceWindow = NxXbox::EngineGlobals.hWnd;
            hrb = D3DDevice_Reset(&scpp);
            printf("[gfx] DIAG ProbeB Reset(EXACT swapchain params, autoDS=ON) -> 0x%08X\n", (unsigned)hrb);

            if (hrb != D3D_OK)
            {
                // PROBE C: same params but WITHOUT the implicit auto depth-stencil. If this succeeds,
                // the runtime-owned auto depth-stencil is what blocks Reset (and we manage depth ourselves).
                D3DPRESENT_PARAMETERS nods = scpp;
                nods.EnableAutoDepthStencil = FALSE;
                nods.AutoDepthStencilFormat = D3DFMT_UNKNOWN;
                HRESULT hrc = D3DDevice_Reset(&nods);
                printf("[gfx] DIAG ProbeC Reset(EXACT params, autoDS=OFF) -> 0x%08X\n", (unsigned)hrc);

                // PROBE D: minimal params built from scratch (not from the swap chain), DISCARD/1 buffer.
                D3DPRESENT_PARAMETERS mini;
                ZeroMemory(&mini, sizeof(mini));
                mini.Windowed = TRUE;
                mini.SwapEffect = D3DSWAPEFFECT_DISCARD;
                mini.BackBufferFormat = D3DFMT_UNKNOWN;     // let the runtime pick the desktop format
                mini.BackBufferCount = 1;
                mini.hDeviceWindow = NxXbox::EngineGlobals.hWnd;
                mini.PresentationInterval = D3DPRESENT_INTERVAL_IMMEDIATE;
                HRESULT hrd = D3DDevice_Reset(&mini);
                printf("[gfx] DIAG ProbeD Reset(minimal windowed, fmt=UNKNOWN, no autoDS) -> 0x%08X\n", (unsigned)hrd);
            }
        }
        else
        {
            printf("[gfx] DIAG GetSwapChain failed gsc=0x%08X (cannot probe exact params)\n", (unsigned)gsc);
        }
    }
    fflush(stdout);

    // 2. Rebuild present params (resolution / AA / vsync / refresh / monitor) from settings,
    //    and move/restyle the window to match.
    UINT adapter = NxXbox::GetSelectedAdapter();
    NxXbox::BuildPresentParams(adapter);

    {
        D3DPRESENT_PARAMETERS& p = NxXbox::EngineGlobals.params;
        printf("[gfx] DIAG new params: %dx%d windowed=%d fmt=%d msaa=%d swap=%d ds=%d pi=%u hz=%u count=%u hwnd=%p\n",
            p.BackBufferWidth, p.BackBufferHeight, p.Windowed, (int)p.BackBufferFormat,
            (int)p.MultiSampleType, (int)p.SwapEffect, (int)p.AutoDepthStencilFormat,
            p.PresentationInterval, p.FullScreen_RefreshRateInHz, p.BackBufferCount, (void*)p.hDeviceWindow);
    }
    fflush(stdout);

    // 3. Reset, waiting out a still-lost device (e.g. window minimized) if necessary.
    HRESULT hr = D3DERR_DEVICELOST;
    for (int tries = 0; tries < 240; ++tries)
    {
        hr = D3DDevice_Reset(&NxXbox::EngineGlobals.params);
        if (hr != D3DERR_DEVICELOST)
            break;
        Sleep(50);  // device not yet resettable; wait and retry
    }

    // 4. If Reset failed, roll back to the previous mode. The device kept its old state,
    //    so we still recreate the resources we released, sized to the old params. The game
    //    keeps running at the previous resolution instead of crashing.
    bool ok = (hr == D3D_OK);
    if (!ok)
    {
        printf("[gfx] device Reset failed: hr=0x%08X - rolling back to %dx%d\n",
            (unsigned)hr, saved_params.BackBufferWidth, saved_params.BackBufferHeight);
        NxXbox::EngineGlobals.params           = saved_params;
        NxXbox::EngineGlobals.cmdline_width    = saved_w;
        NxXbox::EngineGlobals.cmdline_height   = saved_h;
        NxXbox::EngineGlobals.cmdline_fullscreen = saved_fs;
        // Put the window back to the old size/style so it matches the (unchanged) back buffer.
        NxXbox::BuildPresentParams(adapter);
    }

    // 5. Recreate everything we released.
    D3D_RecreateRenderSurfaces();   // scratch buffers + blur surfaces + render states
    D3D_ReCreateTextures();         // default-pool textures + projection render targets
    D3D_ReCreateBuffers();          // scene shared VBs (re-point) + per-mesh re-upload from shadows

    if (!ok)
        return false;

    // 6. Refresh resolution-derived metrics (the back buffer size may have changed).
#define params NxXbox::EngineGlobals.params
    NxXbox::EngineGlobals.backbuffer_width  = params.BackBufferWidth;
    NxXbox::EngineGlobals.backbuffer_height = params.BackBufferHeight;
    NxXbox::EngineGlobals.backbuffer_format = params.BackBufferFormat;
    NxXbox::EngineGlobals.zstencil_depth    = (params.AutoDepthStencilFormat != D3DFMT_D16) ? 32 : 16;
    NxXbox::EngineGlobals.screen_conv_x_multiplier = params.BackBufferWidth  / 640.0f;
    NxXbox::EngineGlobals.screen_conv_x_offset     = 0;
    NxXbox::EngineGlobals.screen_conv_y_multiplier = params.BackBufferHeight / 480.0f;
    NxXbox::EngineGlobals.screen_conv_y_offset     = (int)(NxXbox::EngineGlobals.screen_conv_y_multiplier * 16.0f);
#undef params

    // 6. The gamma ramp is cleared by Reset(); restore it.
    NxXbox::QueryRegistryAndSetGammaRamp();

    printf("[gfx] device Reset OK: %dx%d %s\n",
        NxXbox::EngineGlobals.backbuffer_width, NxXbox::EngineGlobals.backbuffer_height,
        NxXbox::EngineGlobals.params.Windowed ? "windowed" : "fullscreen");
    return true;
}

HWND __cdecl Win32_CreateClassAndWindow(
    LPCSTR lpClassName,
    LPCSTR lpWindowName,
    int X,
    int Y,
    int a5,
    int a6,
    LRESULT(__stdcall* dwExStyle)(HWND, UINT, WPARAM, LPARAM),
    HINSTANCE hInstance,
    int a9,
    DWORD dwStyle)
{
    int v10; // ebp
    int v11; // ebx
    int SystemMetrics; // esi
    int v13; // edi
    HWND result; // eax
    struct tagRECT Rect; // [esp+10h] [ebp-40h] BYREF
    WNDCLASSEXA v16; // [esp+20h] [ebp-30h] BYREF
    DWORD dwExStylea; // [esp+6Ch] [ebp+1Ch]
    DWORD dwStylea = 0; // [esp+78h] [ebp+28h]

    memset(&v16, 0, sizeof(v16));
    v16.lpfnWndProc = dwExStyle;
    v16.cbSize = 48;
    v16.style = 64;
    v16.hInstance = hInstance;
    v16.lpszClassName = lpClassName;
    if (a9)
        v16.hIcon = LoadIconA(hInstance, MAKEINTRESOURCEA(a9));
    v10 = X;
    v11 = Y;
    RegisterClassExA(&v16);
    dwExStylea = 0;
    //if (dwStyle)
    //{
    //    //dwStylea = WS_POPUP;
    //    dwExStylea = WS_EX_TOPMOST;
    //    v10 = 0;
    //    v11 = 0;
    //    SystemMetrics = GetSystemMetrics(0);
    //    v13 = GetSystemMetrics(1);
    //}
    //else
    {
        dwStylea = -2134376448;
        Rect.left = 0;
        Rect.top = 0;
        Rect.right = a5;
        Rect.bottom = a6;
        AdjustWindowRect(&Rect, 0x80C80000, 0);
        SystemMetrics = Rect.right - Rect.left;
        v13 = Rect.bottom - Rect.top;
        if (X == -1)
            v10 = (GetSystemMetrics(0) - SystemMetrics) / 2;
        if (Y == -1)
            v11 = (GetSystemMetrics(1) - v13) / 2;
    }
    SetLastError(0);
    result = CreateWindowExA(
        dwExStylea,
        lpClassName,
        lpWindowName,
        dwStylea,
        v10,
        v11,
        SystemMetrics,
        v13,
        0,
        0,
        hInstance,
        0);

    NxXbox::EngineGlobals.hWnd = result;

    return result;
}

void __stdcall Win32_ParseCommandLineForNetplayOptions(const char* a1)
{
    // KISAKTODO: not high priority atm
}

void Handle_WM_CHAR(WPARAM wParam, LPARAM lParam)
{
    // KISAKTODO
}
void Handle_WM_KEYDOWN(WPARAM wParam, LPARAM lParam)
{
    // lwss add: debug hotkeys for the runtime device-Reset path (precursor to the
    // in-game graphics menu). These just stage new settings into EngineGlobals and
    // request a Reset; s_plat_pre_render applies it between frames.
    //   F7 - cycle resolution    F8 - toggle windowed/fullscreen    F9 - toggle vsync
    switch (wParam)
    {
    case VK_F7:
    {
        static const int s_test_w[] = { 1280, 1600, 1920, 1024,  800 };
        static const int s_test_h[] = {  960,  900, 1080,  768,  600 };
        static int s_idx = 0;
        s_idx = (s_idx + 1) % (sizeof(s_test_w) / sizeof(s_test_w[0]));
        NxXbox::EngineGlobals.cmdline_width  = s_test_w[s_idx];
        NxXbox::EngineGlobals.cmdline_height = s_test_h[s_idx];
        printf("[gfx] hotkey: resolution -> %dx%d\n", s_test_w[s_idx], s_test_h[s_idx]);
        RequestDeviceReset();
        break;
    }
    case VK_F8:
        NxXbox::EngineGlobals.cmdline_fullscreen = !NxXbox::EngineGlobals.cmdline_fullscreen;
        printf("[gfx] hotkey: %s\n", NxXbox::EngineGlobals.cmdline_fullscreen ? "fullscreen" : "windowed");
        RequestDeviceReset();
        break;
    case VK_F9:
        g_vsync_enabled = !g_vsync_enabled;
        printf("[gfx] hotkey: vsync %s\n", g_vsync_enabled ? "on" : "off");
        RequestDeviceReset();
        break;
    default:
        break;
    }
    // lwss end
}

static bool            g_borderless_fullscreen = false;
static WINDOWPLACEMENT g_pre_fs_placement = { sizeof(WINDOWPLACEMENT) };
static LONG            g_pre_fs_style = 0;

void Win32_ToggleBorderlessFullscreen(void)
{
    HWND hWnd = NxXbox::EngineGlobals.hWnd;
    if (!hWnd)
        return;

    // Exclusive fullscreen (launched with -fullscreen) owns the swap chain; don't fight it.
    // (params.Windowed == !cmdline_fullscreen, and cmdline_fullscreen is what's visible here.)
    if (NxXbox::EngineGlobals.cmdline_fullscreen)
        return;

    if (!g_borderless_fullscreen)
    {
        MONITORINFO mi = { sizeof(MONITORINFO) };
        if (!GetWindowPlacement(hWnd, &g_pre_fs_placement) ||
            !GetMonitorInfoA(MonitorFromWindow(hWnd, MONITOR_DEFAULTTONEAREST), &mi))
        {
            return;
        }

        g_pre_fs_style = GetWindowLongA(hWnd, GWL_STYLE);
        SetWindowLongA(hWnd, GWL_STYLE, WS_POPUP | WS_VISIBLE);
        // HWND_TOP (not TOPMOST) so alt-tab still works normally.
        SetWindowPos(hWnd, HWND_TOP,
            mi.rcMonitor.left, mi.rcMonitor.top,
            mi.rcMonitor.right - mi.rcMonitor.left,
            mi.rcMonitor.bottom - mi.rcMonitor.top,
            SWP_NOOWNERZORDER | SWP_FRAMECHANGED);
        g_borderless_fullscreen = true;
    }
    else
    {
        // Restore the previous windowed style and placement.
        SetWindowLongA(hWnd, GWL_STYLE, g_pre_fs_style);
        SetWindowPlacement(hWnd, &g_pre_fs_placement);
        SetWindowPos(hWnd, NULL, 0, 0, 0, 0,
            SWP_NOMOVE | SWP_NOSIZE | SWP_NOZORDER | SWP_NOOWNERZORDER | SWP_FRAMECHANGED);
        g_borderless_fullscreen = false;
    }
}

LRESULT __stdcall Win32_WNDPROC(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
    LRESULT result; // eax

    if (uMsg > WM_KEYDOWN)
    {
        if (uMsg > 0x112)
        {
            if (uMsg == WM_POWERBROADCAST)
                return 0;
        }
        else
        {
            switch (uMsg)
            {
            case WM_SYSCOMMAND:
                if (wParam != 61696)
                    return DefWindowProcA(hWnd, 0x112u, wParam, lParam);
                return 0;
            case WM_CHAR:
                Handle_WM_CHAR(wParam, lParam);
                return 0;
            case WM_SYSKEYDOWN:
                if (wParam == VK_RETURN && !(lParam & (1 << 30)))   // Alt+Enter (bit 30 = key-repeat, ignore)
                {
                    Win32_ToggleBorderlessFullscreen();
                    return 0;
                }
                if (wParam == 121)
                    return 0;
                uMsg = 260;
                break;
            }
        }
        return DefWindowProcA(hWnd, uMsg, wParam, lParam);
    }
    if (uMsg == WM_KEYDOWN)
    {
        Handle_WM_KEYDOWN(wParam, lParam);
        return 0;
    }
    switch (uMsg)
    {
    case WM_DESTROY:
    case WM_CLOSE:
        PostQuitMessage(0);
        gbQuit = 1;
        result = 0;
        break;
    case WM_ACTIVATE:
        if (wParam == 1 || wParam == 2)         // activated via mouse OR keyboard
        {
            if (NxXbox::EngineGlobals.cmdline_fullscreen)
            {
                ShowWindow(NxXbox::EngineGlobals.hWnd, SW_MAXIMIZE);
            }
            g_isWindowInFocus = 1;
            result = 0;
        }
        else
        {

            if (NxXbox::EngineGlobals.cmdline_fullscreen)
            {
                ShowWindow(NxXbox::EngineGlobals.hWnd, SW_MINIMIZE);
            }
            g_isWindowInFocus = 0;
            g_windowJustWentOutOfFocus = 1;
            InvalidateRect(0, 0, 1);
            result = 0;
        }
        break;
    case WM_PAINT:
        ValidateRect(hWnd, 0);
        result = 0;
        break;
    default:
        return DefWindowProcA(hWnd, uMsg, wParam, lParam);
    }
    return result;
}

static void __stdcall Win32_CreateDirectSound8(HWND a1)
{
    DirectSoundCreate8(0, &ppDS8, 0);
    if (ppDS8)
        ppDS8->SetCooperativeLevel(a1, 2);
}

//BOOL __stdcall DirectInput_EnumDevicesCallbackA(/LPCDIDEVICEINSTANCEA a1, LPVOID a2)
//{
//    // KISAKTODO
//    return true;
//}

static bool g_cmdline_display_override = false;


extern "C" bool g_vsync_enabled;
extern "C" bool g_render_interp_enabled;
static bool g_cmdline_vsync_set  = false;	// true if vsync was set on the command line (INI won't override)
static bool g_cmdline_interp_set = false;	// true if interpolation was set on the command line
extern "C" int g_cmdline_refresh;
extern "C" int g_cmdline_monitor;


static void Win32_GetGraphicsIniPath(char* out, int size)
{
    char exe[MAX_PATH];
    GetModuleFileNameA(NULL, exe, MAX_PATH);
    char* slash = strrchr(exe, '\\');
    if (slash)
    {
        *(slash + 1) = 0;
    }
    else
    {
        exe[0] = 0;
    }
    _snprintf(out, size, "%sthug_gfx.ini", exe);
    out[size - 1] = 0;
}


void Win32_SaveGraphicsSettings(void)
{
    char ini[MAX_PATH];
    Win32_GetGraphicsIniPath(ini, sizeof(ini));

    char buf[32];
#define GFX_WRITE_INT(key, val) do { _snprintf(buf, sizeof(buf), "%d", (int)(val)); buf[sizeof(buf)-1]=0; WritePrivateProfileStringA("Graphics", key, buf, ini); } while (0)
    GFX_WRITE_INT("Width",        NxXbox::EngineGlobals.cmdline_width  > 0 ? NxXbox::EngineGlobals.cmdline_width  : 1280);
    GFX_WRITE_INT("Height",       NxXbox::EngineGlobals.cmdline_height > 0 ? NxXbox::EngineGlobals.cmdline_height : 960);
    GFX_WRITE_INT("Fullscreen",   NxXbox::EngineGlobals.cmdline_fullscreen ? 1 : 0);
    GFX_WRITE_INT("AntiAliasing", NxXbox::EngineGlobals.g_Registry_options_flag_1_MSAA);
    GFX_WRITE_INT("EffectDetail", NxXbox::EngineGlobals.g_Registry_options_flag_2);
    GFX_WRITE_INT("DrawDistance", NxXbox::EngineGlobals.g_Registry_distance_value);
    GFX_WRITE_INT("Vsync",         g_vsync_enabled ? 1 : 0);
    GFX_WRITE_INT("Interpolation", g_render_interp_enabled ? 1 : 0);	// render/sim decouple smoothing (high-refresh)
    GFX_WRITE_INT("Refresh",       g_cmdline_refresh);	// exclusive-fullscreen refresh Hz (0 = auto)
    GFX_WRITE_INT("Monitor",       g_cmdline_monitor);	// D3D adapter index (-1 = primary)
#undef GFX_WRITE_INT
}

// Load the graphics settings from the ini
int Win32_QueryRegistryForSettings(LPCSTR lpSubKey)
{
    char ini[MAX_PATH];
    Win32_GetGraphicsIniPath(ini, sizeof(ini));

    bool exists = (GetFileAttributesA(ini) != INVALID_FILE_ATTRIBUTES);


    NxXbox::EngineGlobals.g_Registry_options_flag_1_MSAA = GetPrivateProfileIntA("Graphics", "AntiAliasing", 0,   ini);
    NxXbox::EngineGlobals.g_Registry_options_flag_2      = GetPrivateProfileIntA("Graphics", "EffectDetail", 1,   ini);
    NxXbox::EngineGlobals.g_Registry_distance_value      = GetPrivateProfileIntA("Graphics", "DrawDistance", 100, ini);


    if (!g_cmdline_display_override)
    {
        NxXbox::EngineGlobals.cmdline_width      = GetPrivateProfileIntA("Graphics", "Width",      1280, ini);
        NxXbox::EngineGlobals.cmdline_height     = GetPrivateProfileIntA("Graphics", "Height",     960,  ini);
        NxXbox::EngineGlobals.cmdline_fullscreen = GetPrivateProfileIntA("Graphics", "Fullscreen", 0,    ini) != 0;
        g_cmdline_refresh                        = GetPrivateProfileIntA("Graphics", "Refresh",    0,    ini);  // exclusive-fs Hz (0=auto)
        g_cmdline_monitor                        = GetPrivateProfileIntA("Graphics", "Monitor",   -1,    ini);  // D3D adapter index (-1=primary)
    }

    // Render/sim decouple toggles. Defaults: Vsync on, Interpolation off (high-refresh users opt in).
    // Cmdline (-vsync/-novsync, -interp/-nointerp) wins over the INI.
    if (!g_cmdline_vsync_set)
        g_vsync_enabled = GetPrivateProfileIntA("Graphics", "Vsync", 1, ini) != 0;
    if (!g_cmdline_interp_set)
        g_render_interp_enabled = GetPrivateProfileIntA("Graphics", "Interpolation", 0, ini) != 0;

    if (!exists)
    {
        Win32_SaveGraphicsSettings();
    }

    printf("[gfx] %s: %dx%d@%dHz %s monitor=%d AA=%u Effects=%u DrawDist=%u Vsync=%s Interp=%s\n",
        ini,
        NxXbox::EngineGlobals.cmdline_width, NxXbox::EngineGlobals.cmdline_height, g_cmdline_refresh,
        NxXbox::EngineGlobals.cmdline_fullscreen ? "fullscreen" : "windowed",
        g_cmdline_monitor,
        NxXbox::EngineGlobals.g_Registry_options_flag_1_MSAA,
        NxXbox::EngineGlobals.g_Registry_options_flag_2,
        NxXbox::EngineGlobals.g_Registry_distance_value,
        g_vsync_enabled ? "on" : "off",
        g_render_interp_enabled ? "on" : "off");

    return 0;
}

static bool Win32_CreateDirectInput8(HINSTANCE inst, HWND hwnd, LPCSTR lpSubKey)
{
    if (!hwnd)
    {
        return false;
    }

   // if (!g_directInput8)
    {
        //dword_7D0CF8[0] = 0;
        //dword_7D0CFC = 0;
        //memset(byte_7D0AD8, 0, 544);
        //memset(byte_7D0E18, 0, 544);
        //dword_7D1038[0] = 0;
        //dword_7D103C = 0;
        //dword_7CEC98[0] = 0;
        //dword_7CEC9C = 0;
        //dword_7CECA0[0] = 0;
        //dword_7CECA4[0] = 0;
        //dword_7CECA8 = 0;
        //dword_7CECAC = 0;
        //memset(registry_k_setting_arr, -1, 0x260u);

        (void)lpSubKey;

        //DirectInput8Create(inst, 0x800, IID_IDirectInput8, (void**)&g_directInput8, NULL);
        //g_directInput8->EnumDevices(0, DirectInput_EnumDevicesCallbackA, 0, 1);
        // InputWeirdFuckery();
    }

    return true;
}

// Defined in Sk/Main.cpp
int main(sint argc, char** argv);

static void Win32_ParseDisplayArgs(int argc, char** argv)
{
    NxXbox::EngineGlobals.cmdline_width = 0;
    NxXbox::EngineGlobals.cmdline_height = 0;
    NxXbox::EngineGlobals.cmdline_fullscreen = false;

    for (int i = 1; i < argc; ++i)
    {
        const char* a = argv[i];
        if ((!stricmp(a, "-w") || !stricmp(a, "-width")) && (i + 1 < argc))
        {
            NxXbox::EngineGlobals.cmdline_width = atoi(argv[++i]);
            g_cmdline_display_override = true;
        }
        else if ((!stricmp(a, "-h") || !stricmp(a, "-height")) && (i + 1 < argc))
        {
            NxXbox::EngineGlobals.cmdline_height = atoi(argv[++i]);
            g_cmdline_display_override = true;
        }
        else if ((!stricmp(a, "-refresh") || !stricmp(a, "-hz") || !stricmp(a, "-refreshrate")) && (i + 1 < argc))
        {
            g_cmdline_refresh = atoi(argv[++i]);
            g_cmdline_display_override = true;
        }
        else if ((!stricmp(a, "-monitor") || !stricmp(a, "-adapter") || !stricmp(a, "-display")) && (i + 1 < argc))
        {
            g_cmdline_monitor = atoi(argv[++i]);
            g_cmdline_display_override = true;
        }
        else if (!stricmp(a, "-fullscreen") || !stricmp(a, "-fs"))
        {
            NxXbox::EngineGlobals.cmdline_fullscreen = true;
            g_cmdline_display_override = true;
        }
        else if (!stricmp(a, "-windowed") || !stricmp(a, "-window"))
        {
            NxXbox::EngineGlobals.cmdline_fullscreen = false;
            g_cmdline_display_override = true;
        }
        else if (!stricmp(a, "-novsync") || !stricmp(a, "-vsyncoff"))
        {
            g_vsync_enabled = false;
            g_cmdline_vsync_set = true;
        }
        else if (!stricmp(a, "-vsync"))
        {
            g_vsync_enabled = true;
            g_cmdline_vsync_set = true;
        }
        else if (!stricmp(a, "-interp") || !stricmp(a, "-interpolation") || !stricmp(a, "-smooth"))
        {
            g_render_interp_enabled = true;
            g_cmdline_interp_set = true;
        }
        else if (!stricmp(a, "-nointerp") || !stricmp(a, "-nosmooth"))
        {
            g_render_interp_enabled = false;
            g_cmdline_interp_set = true;
        }
        else
        {
            int w = 0, h = 0;
            if (sscanf(a, "%dx%d", &w, &h) == 2 && w > 0 && h > 0)
            {
                NxXbox::EngineGlobals.cmdline_width = w;
                NxXbox::EngineGlobals.cmdline_height = h;
                g_cmdline_display_override = true;
            }
        }
    }

    if (NxXbox::EngineGlobals.cmdline_width > 0 && NxXbox::EngineGlobals.cmdline_height > 0)
    {
        printf("[display] command-line resolution: %dx%d (%s)\n",
            NxXbox::EngineGlobals.cmdline_width, NxXbox::EngineGlobals.cmdline_height,
            NxXbox::EngineGlobals.cmdline_fullscreen ? "fullscreen" : "windowed");
    }
}

// Breaks on the instruction that creates a NaN/Inf instead of letting it propagate.
static LONG WINAPI Win32_FpTrapHandler(EXCEPTION_POINTERS* ep)
{
    DWORD code = ep->ExceptionRecord->ExceptionCode;
    if (code == STATUS_FLOAT_INVALID_OPERATION ||
        code == STATUS_FLOAT_DIVIDE_BY_ZERO ||
        code == STATUS_FLOAT_OVERFLOW)
    {
        void* addr = ep->ExceptionRecord->ExceptionAddress;
        _clearfp();		// clear sticky flags so the assert path doesn't re-trip
        unsigned int cur;
        _controlfp_s(&cur, _MCW_EM, _MCW_EM);	// re-mask everything while we report
        Dbg_MsgAssert(0, ("FP exception 0x%08lX at %p - NaN/Inf created here", code, addr));
    }
    return EXCEPTION_CONTINUE_SEARCH;
}

// Unmask invalid-op, divide-by-zero and overflow on this thread. Per-thread, opt-in via -fptrap.
static void Win32_EnableFloatTraps()
{
    AddVectoredExceptionHandler(1, Win32_FpTrapHandler);
    _clearfp();		// drop flags accumulated during startup
    unsigned int cur;
    _controlfp_s(&cur, _MCW_EM & ~(_EM_INVALID | _EM_ZERODIVIDE | _EM_OVERFLOW), _MCW_EM);
    printf("[fptrap] floating-point NaN/Inf trapping enabled\n");
}

static bool Win32_WantsFloatTraps(int argc, char** argv)
{
    for (int i = 1; i < argc; ++i)
    {
        if (!stricmp(argv[i], "-fptrap"))
            return true;
    }
    return false;
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow)
{
    hEvent = CreateEventA(NULL, TRUE, FALSE, 0);

    g_downloadCompletionFunc = DownloadCompletionFunc;

    // LWSS: skipping gamespy + net backend search

    printf("The backend is not available\n");

    Win32_ParseCommandLineForNetplayOptions(lpCmdLine);

    Win32_ParseDisplayArgs(__argc, __argv);

    NxXbox::EngineGlobals.g_Registry_options_flag_1_MSAA = 0;
    NxXbox::EngineGlobals.g_Registry_options_flag_2      = 0;
    NxXbox::EngineGlobals.g_Registry_resolution_setting  = 0;
    NxXbox::EngineGlobals.g_Registry_distance_value2     = 0;
    NxXbox::EngineGlobals.g_Registry_distance_value      = 0;
    Win32_QueryRegistryForSettings(NULL);

    int win_w = (NxXbox::EngineGlobals.cmdline_width  > 0) ? NxXbox::EngineGlobals.cmdline_width  : 1280;
    int win_h = (NxXbox::EngineGlobals.cmdline_height > 0) ? NxXbox::EngineGlobals.cmdline_height : 960;
    Win32_CreateClassAndWindow("Kisak", "Kisak Hawk's OpenGround", 100, 100, win_w, win_h, Win32_WNDPROC, hInstance, 103, 1);
    Win32_ProcessMsgPump();

    if (!NxXbox::EngineGlobals.hWnd)
    {
        return 0;
    }

#ifndef KISAK_EARLY_CURSOR_FIX
    if (g_windowHasBeenDisplayedEver)
    {
        ShowWindow(NxXbox::EngineGlobals.hWnd, SW_SHOWMINIMIZED);
    }
    else
    {
        ShowWindow(NxXbox::EngineGlobals.hWnd, SW_SHOWNORMAL);
    }
#endif
    
    srand(_time64(0));

    Win32_CreateDirectSound8(NxXbox::EngineGlobals.hWnd);
    Win32_CreateDirectInput8(hInstance, NxXbox::EngineGlobals.hWnd, "Software\\Activision\\Tony Hawk's Underground\\Settings");

    // Enabled after device init so startup/driver math doesn't trip it.
    if (Win32_WantsFloatTraps(__argc, __argv))
        Win32_EnableFloatTraps();

    for (int i = 1; i < __argc; ++i)
    {
        if (!stricmp(__argv[i], "-shadowtest"))
            NxXbox::g_shadow_test = true;
        if (!stricmp(__argv[i], "-nocd"))
            Config::g_config_cd = false;	// force non-CD startup path (dev boot)
        if (!stricmp(__argv[i], "-loosescripts"))
            g_loose_scripts = true;			// load raw .qb from Data\scripts\ instead of qb.pre
    }

    while (true)
    {
        // LWSS: Skipping keycode mapping for now. (KISAKTODO?)
        
        main(__argc, __argv); // MSVC-specific macros for this...
        //DestroyDirectSound8();
        //DestroyDirectInput();
        //CLoadScreen::sHide();
        //DestroyDirect3D();
        //InvalidateRect(0, 0, 1);
        //ShowWindow(EngineGlobals_hWnd, 2);// SW_SHOWMINIMIZED
        //sub_6206B0(g_rad);
        //_cexit();
        //Manager::sCloseDown();
        //_exit(0);
    }
}