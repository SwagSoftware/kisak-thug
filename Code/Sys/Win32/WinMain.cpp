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
    for (NxXbox::LinkedList* j = NxXbox::g_sTexturesList; j; j = j->next)
    {
        NxXbox::sTexture* data = (NxXbox::sTexture*)j->data;
        if (data->pD3DSurface)   // non-NULL => render target (D3DPOOL_DEFAULT)
        {
            data->pD3DSurface->Release();
            data->pD3DSurface = NULL;
            if (data->pD3DTexture)
            {
                data->pD3DTexture->Release();
                data->pD3DTexture = NULL;
            }
        }
    }


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

    for (NxXbox::LinkedList* vertItr = NxXbox::g_meshVertexBuffers; vertItr; vertItr = vertItr->next)
    {
        NxXbox::VertexBufferWrapper* data = (NxXbox::VertexBufferWrapper*)vertItr->data;
        if (data)
        {
            if (data->vertexBuffer)
            {
                data->vertexBuffer->Release();
                data->vertexBuffer = NULL;
            }
            // vertItr->data->vertexBuffer = v2;
        }
    }

    for (NxXbox::LinkedList* indexItr = NxXbox::g_meshIndexBuffers; indexItr; indexItr = indexItr->next)
    {
        NxXbox::IndexBufferWrapper* data = (NxXbox::IndexBufferWrapper*)indexItr->data;
        if (data)
        {
            if (data->indexBuffer)
            {
                data->indexBuffer->Release();
                data->indexBuffer = NULL;
            }
        }
    }

    // Now that every mesh wrapper has dropped its shared-buffer reference, drop the
    // scene-owned reference so each scene's D3DPOOL_DEFAULT vertex buffer is fully
    // released before Reset().
    Nx::ResetSceneVertexBuffers();
}
void D3D_ReleaseRenderSurfaces()
{
    NxXbox::EngineGlobals.p_RenderSurface = NULL;
    NxXbox::EngineGlobals.p_ZStencilSurface = NULL;

    if (NxXbox::EngineGlobals.p_BlurSurface_2)
    {
        NxXbox::EngineGlobals.p_BlurSurface_2->Release();
    }
    NxXbox::EngineGlobals.p_BlurSurface_2 = NULL;

    if (NxXbox::EngineGlobals.p_BlurSurface_3)
    {
        NxXbox::EngineGlobals.p_BlurSurface_3->Release();
    }
    NxXbox::EngineGlobals.p_BlurSurface_3 = NULL;

    if (NxXbox::EngineGlobals.p_BlurSurface_0)
    {
        NxXbox::EngineGlobals.p_BlurSurface_0->Release();
    }
    NxXbox::EngineGlobals.p_BlurSurface_0 = NULL;

    if (NxXbox::EngineGlobals.p_BlurSurface_1)
    {
        NxXbox::EngineGlobals.p_BlurSurface_1->Release();
    }
    NxXbox::EngineGlobals.p_BlurSurface_1 = NULL;

    // D3D_ReleaseVertexBuffer()
    if (NxXbox::EngineGlobals.p_vertex_buffer)
    {
        NxXbox::EngineGlobals.p_vertex_buffer->Release();
    }
    NxXbox::EngineGlobals.p_vertex_buffer = NULL;

    if (NxXbox::EngineGlobals.p_index_buffer)
    {
        NxXbox::EngineGlobals.p_index_buffer->Release();
    }
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

    D3DDevice_GetRenderTarget(0, &NxXbox::EngineGlobals.p_RenderSurface);
    D3DDevice_GetDepthStencilSurface(&NxXbox::EngineGlobals.p_ZStencilSurface);

    NxXbox::EngineGlobals.p_RenderSurface->Release();
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
    if (NxXbox::EngineGlobals.p_Device == NULL)
        return false;

    // 1. Release all default-pool resources.
    D3D_ResetTextures();            // g_sTexturesList + texture-projection render targets
    D3D_ResetBuffers();             // mesh vertex/index wrappers + scene shared vertex buffers
    D3D_ReleaseRenderSurfaces();    // blur surfaces + scratch vertex/index buffers

    // 2. Rebuild present params (resolution / AA / vsync / refresh / monitor) from settings,
    //    and move/restyle the window to match.
    UINT adapter = NxXbox::GetSelectedAdapter();
    NxXbox::BuildPresentParams(adapter);

    // 3. Reset, waiting out a still-lost device (e.g. window minimized) if necessary.
    HRESULT hr = D3DERR_DEVICELOST;
    for (int tries = 0; tries < 240; ++tries)
    {
        hr = D3DDevice_Reset(&NxXbox::EngineGlobals.params);
        if (hr != D3DERR_DEVICELOST)
            break;
        Sleep(50);  // device not yet resettable; wait and retry
    }

    if (hr != D3D_OK)
    {
        // D3DERR_INVALIDCALL here means a default-pool resource is still alive (leak),
        // or the requested mode is unsupported. Leave the (now lost) device be; the caller
        // keeps running and can retry. Surface it loudly in debug.
        printf("[gfx] device Reset failed: hr=0x%08X\n", (unsigned)hr);
        Dbg_Assert(0);
        return false;
    }

    // 4. Recreate everything we released.
    D3D_RecreateRenderSurfaces();   // scratch buffers + blur surfaces + render states
    D3D_ReCreateTextures();         // default-pool textures + projection render targets
    D3D_ReCreateBuffers();          // scene shared VBs (re-point) + per-mesh re-upload from shadows

    // 5. Refresh resolution-derived metrics (the back buffer size may have changed).
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