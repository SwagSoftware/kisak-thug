// LWSS: Created File for Win32 WinMain() and other related Windows Functionality

#include <core/defines.h>	

#include <Gfx/nx.h>

#include <windows.h>

#include <Gfx/DX9/NX/render.h>

// Temporarily in here
#include <dsound.h>
LPDIRECTSOUND8 ppDS8;
LPDIRECTINPUT8 g_directInput8 = nullptr;
// ^^

bool g_isWindowInFocus = false;
bool g_windowJustWentOutOfFocus = false;
bool g_windowHasBeenDisplayedEver = false;
bool gbQuit = false;
bool g_hasJustEnteredNetworkGame = false; // KISAKTODO: add more xrefs for this var

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

    // KISAKTODO: should probably remove the texture from the linkedlist here guys
    for (NxXbox::LinkedList* j = NxXbox::g_sTexturesList; j; j = j->next)
    {
        NxXbox::sTexture* data = (NxXbox::sTexture*)j->data;
        // KISAKTODO: sTexture class seems to have a DO_NOT_PURGE flag that's missing here.
        if (data->pD3DTexture)
        {
            //D3DSURFACE_DESC desc;
            //data->pD3DTexture->GetLevelDesc(0, &desc);
            ULONG rr = data->pD3DTexture->Release();
            //Dbg_Assert(rr == 0);
            data->pD3DTexture = NULL;
        }
        if (data->pD3DSurface)
        {
            ULONG rr = data->pD3DSurface->Release();
            //Dbg_Assert(rr == 0);
            data->pD3DSurface = NULL;
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

    // KISAKTODO: ugh
    //for (int i = 0; i < /*MAX_LOADED_SCENES*/4; i++)
    //{
    //    if (NxXbox::sp_loaded_scenes[i])
    //    {
    //        CXboxScene* pXboxScene = static_cast<CXboxScene*>(sp_loaded_scenes[i]);
    //
    //    }
    //}

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
    for (NxXbox::LinkedList* i = NxXbox::g_sTexturesList; i; i = i->next)
    {
        NxXbox::sTexture* data = (NxXbox::sTexture*)i->data;
        if (!data->pD3DTexture)
        {
            // KISAKTODO: flag for DO_NOT_PURGE here.
            D3DDevice_CreateTexture(data->BaseWidth, data->BaseHeight, 1, 0, D3DFMT_A8R8G8B8, D3DPOOL_DEFAULT, &data->pD3DTexture, NULL);

            if (data->pD3DTexture)
                data->pD3DTexture->GetSurfaceLevel(0, &data->pD3DSurface);
        }
    }

    NxXbox::pTextureProjectionDetailsTable->IterateStart();
    NxXbox::sTextureProjectionDetails* p_details = NxXbox::pTextureProjectionDetailsTable->IterateNext();
    while (p_details)
    {
        NxXbox::sTexture* p_texture = p_details->p_texture;
        if (p_texture)
        {
            D3DDevice_CreateTexture(p_texture->BaseWidth, p_texture->BaseHeight, p_texture->Levels, 1, D3DFMT_A8R8G8B8, D3DPOOL_DEFAULT, &p_texture->pD3DTexture, NULL);
            
            p_texture->pD3DTexture->GetSurfaceLevel(0, &p_texture->pD3DSurface);
        }
        p_details = NxXbox::pTextureProjectionDetailsTable->IterateNext();
    }
}
void D3D_ReCreateBuffers()
{
    // KISAKTODO: sp_loaded_scenes crap

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
    // KISAKTODO
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
            ShowWindow(NxXbox::EngineGlobals.hWnd, 3);
            g_isWindowInFocus = 1;
            result = 0;
        }
        else
        {
            ShowWindow(NxXbox::EngineGlobals.hWnd, 6);
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

BOOL __stdcall DirectInput_EnumDevicesCallbackA(LPCDIDEVICEINSTANCEA a1, LPVOID a2)
{
    // KISAKTODO
    return true;
}

int Win32_QueryRegistryForSettings(LPCSTR lpSubKey)
{
    // KISAKTODO: I dont really want this in the Registry...
    //NxXbox::EngineGlobals.g_Registry_options_flag_1_MSAA = 1;
    NxXbox::EngineGlobals.g_Registry_options_flag_2 = 1;

    NxXbox::EngineGlobals.g_Registry_distance_value = 100;
    //NxXbox::EngineGlobals.g_Registry_resolution_setting = 3;

    return 0;
}

static bool Win32_CreateDirectInput8(HINSTANCE inst, HWND hwnd, LPCSTR lpSubKey)
{
    if (!hwnd)
    {
        return false;
    }

    if (!g_directInput8)
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

        NxXbox::EngineGlobals.g_Registry_options_flag_1_MSAA = 0;
        NxXbox::EngineGlobals.g_Registry_options_flag_2 = 0;
        NxXbox::EngineGlobals.g_Registry_resolution_setting = 0;
        NxXbox::EngineGlobals.g_Registry_distance_value2 = 0;
        NxXbox::EngineGlobals.g_Registry_distance_value = 0;

        Win32_QueryRegistryForSettings(lpSubKey);
        
        //DirectInput8Create(inst, 0x800, IID_IDirectInput8, (void**)&g_directInput8, NULL);
        //g_directInput8->EnumDevices(0, DirectInput_EnumDevicesCallbackA, 0, 1);
        // InputWeirdFuckery();
    }

    return true;
}

// Defined in Sk/Main.cpp
int main(sint argc, char** argv);

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow)
{
    hEvent = CreateEventA(NULL, TRUE, FALSE, 0);

    g_downloadCompletionFunc = DownloadCompletionFunc;

    // LWSS: skipping gamespy + net backend search

    printf("The backend is not available\n");

    Win32_ParseCommandLineForNetplayOptions(lpCmdLine);

    Win32_CreateClassAndWindow("Kisak", "Kisak Hawk's OpenGround", 100, 100, 640, 480, Win32_WNDPROC, hInstance, 103, 1);
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