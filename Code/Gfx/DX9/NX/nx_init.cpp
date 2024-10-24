//#include <xtl.h>

// Include the following two files for detailed timing data collection.
//#include <xbdm.h>
//#include <d3d8perf.h>

#include "sys/config/config.h"
#include "nx_init.h"
#include "anim.h"
#include "chars.h"
#include "scene.h"
#include "render.h"
#include "instance.h"
#include "gamma.h"
#include "grass.h"

namespace NxXbox
{

sEngineGlobals	EngineGlobals{ 0 };
bool g_disableRendering = false;
int g_globalFrameCounter = 0;
int renderFlags = 0;


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void InitialiseRenderstates( void )
{
	// lwss add
	XGMatrixIdentity(&EngineGlobals.world_matrix);
	XGMatrixIdentity(&EngineGlobals.view_matrix);
	XGMatrixIdentity(&EngineGlobals.projection_matrix);
	// lwss end

	D3DDevice_SetRenderState( D3DRS_LOCALVIEWER,		FALSE );
	EngineGlobals.is_d3drs_localviewer_on = false; // lwss add
	D3DDevice_SetRenderState( D3DRS_COLORVERTEX,		FALSE );

	EngineGlobals.lighting_enabled		= false;
	D3DDevice_SetRenderState( D3DRS_LIGHTING,			FALSE );

	EngineGlobals.specular_enabled		= 0;
	D3DDevice_SetRenderState( D3DRS_SPECULARENABLE,		FALSE );
	
	EngineGlobals.cull_mode				= D3DCULL_CW;
	D3DDevice_SetRenderState( D3DRS_CULLMODE,			D3DCULL_CW );

	EngineGlobals.allow_envmapping		= true;

	EngineGlobals.dither_enable			= TRUE;
	D3DDevice_SetRenderState( D3DRS_DITHERENABLE,		TRUE );

	EngineGlobals.z_test_enabled		= TRUE;
	D3DDevice_SetRenderState( D3DRS_ZFUNC,				D3DCMP_LESSEQUAL );

	EngineGlobals.z_write_enabled		= TRUE;
	D3DDevice_SetRenderState( D3DRS_ZWRITEENABLE,		TRUE );
	
	EngineGlobals.alpha_blend_enable	= 1;
	D3DDevice_SetRenderState( D3DRS_ALPHABLENDENABLE,	TRUE );

	EngineGlobals.alpha_test_enable		= 1;
	D3DDevice_SetRenderState( D3DRS_ALPHATESTENABLE,	TRUE );

	D3DDevice_SetRenderState( D3DRS_ALPHAFUNC,			D3DCMP_GREATEREQUAL );

	EngineGlobals.alpha_ref				= 0;
	D3DDevice_SetRenderState( D3DRS_ALPHAREF,			0x00 );

	for( int stage = 0; stage < 4; ++stage )
	{
		EngineGlobals.uv_addressing[stage]		= 0x00000000UL;
		EngineGlobals.mip_map_lod_bias[stage]	= 0x00000000UL;
		EngineGlobals.p_texture[stage]			= NULL;
		EngineGlobals.min_mag_filter[stage]		= 0x00010000UL;
		EngineGlobals.color_sign[stage]			= 0x00000000UL;

		// LWSS: SetTextureStageState is old and only effects the Fixed-Function-Pipeline(FFP)
		// So these need to be `SetSamplerState` instead.
		//D3DDevice_SetTextureStageState( stage, D3DTSS_MAGFILTER,		D3DTEXF_LINEAR );
		//D3DDevice_SetTextureStageState( stage, D3DTSS_MIPFILTER,		D3DTEXF_LINEAR );

		D3DDevice_SetSamplerState(stage, D3DSAMP_MAGFILTER, D3DTEXF_LINEAR);
		D3DDevice_SetSamplerState(stage, D3DSAMP_MIPFILTER, D3DTEXF_LINEAR);

		if (stage)
		{
			D3DDevice_SetSamplerState(stage, D3DSAMP_MINFILTER, D3DTEXF_LINEAR);
		}
		else if (EngineGlobals.backbuffer_height <= 480)
		{
			D3DDevice_SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_ANISOTROPIC);

			DWORD maxAnisotropy = 3;
			if (EngineGlobals.devicecaps_max_anisotopy < 3)
			{
				maxAnisotropy = EngineGlobals.devicecaps_max_anisotopy;
			}
			
			D3DDevice_SetSamplerState(0, D3DSAMP_MAXANISOTROPY, maxAnisotropy);
		}
		else
		{
			D3DDevice_SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR);
		}

		D3DDevice_SetSamplerState(stage, D3DSAMP_ADDRESSU, D3DTADDRESS_WRAP);
		D3DDevice_SetSamplerState(stage, D3DSAMP_ADDRESSV, D3DTADDRESS_WRAP);

		//if( stage == 0 )
		//{
		//	// If we are running in 720p or 1080i mode, need max pixel pushing power - avoid anisotropic filtering.
		//	// MSM PERFCHANGE
		//	if( EngineGlobals.backbuffer_height > 480 )
		//	{
		//		D3DDevice_SetTextureStageState( stage, D3DTSS_MINFILTER,		D3DTEXF_LINEAR );
		//	}
		//	else
		//	{
		//		D3DDevice_SetTextureStageState( stage, D3DTSS_MINFILTER,		D3DTEXF_ANISOTROPIC );
		//		D3DDevice_SetTextureStageState( stage, D3DTSS_MAXANISOTROPY, 3 );
		//	}
		//}
		//else
		//{
		//	D3DDevice_SetTextureStageState( stage, D3DTSS_MINFILTER,		D3DTEXF_LINEAR );
		//}
		//D3DDevice_SetTextureStageState( stage, D3DTSS_ADDRESSU,			D3DTADDRESS_WRAP );
		//D3DDevice_SetTextureStageState( stage, D3DTSS_ADDRESSV,			D3DTADDRESS_WRAP );
	}

	// Set up material for specular properties for fixed function pipeline.
	//D3DMATERIAL8	test_mat;
	//ZeroMemory( &test_mat, sizeof( D3DMATERIAL8 ));
	D3DMATERIAL9	test_mat;
	ZeroMemory( &test_mat, sizeof( D3DMATERIAL9 ));

	D3DDevice_SetMaterial( &test_mat );

	D3DDevice_SetRenderState( D3DRS_DIFFUSEMATERIALSOURCE,	D3DMCS_COLOR1 );
    D3DDevice_SetRenderState( D3DRS_SPECULARMATERIALSOURCE, D3DMCS_MATERIAL );
    D3DDevice_SetRenderState( D3DRS_AMBIENTMATERIALSOURCE,	D3DMCS_COLOR1 );
    D3DDevice_SetRenderState( D3DRS_EMISSIVEMATERIALSOURCE,	D3DMCS_MATERIAL );

	// Set these up so they will get reset first time through.
	EngineGlobals.blend_mode_value			= 0xDEADBABE;
	EngineGlobals.blend_op					= 0xDEADBABE;
	EngineGlobals.src_blend					= 0xDEADBABE;
	EngineGlobals.dest_blend				= 0xDEADBABE;

	EngineGlobals.screenshot_name[0]		= 0;
	
	// Build the required vertex shaders.
	CreateWeightedMeshVertexShaders();

	// Build required pixel shaders.
	create_pixel_shaders();

	// Set pixel shader constants.
	EngineGlobals.pixel_shader_constants[16]	= 0.0f;
	EngineGlobals.pixel_shader_constants[17]	= 0.5f;
	EngineGlobals.pixel_shader_constants[18]	= 0.0f;	// Fog denisty.
	EngineGlobals.pixel_shader_constants[19]	= 0.5f;	// Constant 0.5

	EngineGlobals.pixel_shader_override			= 0;
	EngineGlobals.pixel_shader_id				= 0;
	EngineGlobals.vertex_shader_id				= 0; // lwss: add
	EngineGlobals.upload_pixel_shader_constants = false;
	EngineGlobals.is_orthographic				= false;
	EngineGlobals.custom_pipeline_enabled		= false;
	EngineGlobals.vertex_shader_override		= 0;
	EngineGlobals.texture_stage_override		= 0;
	EngineGlobals.material_override				= 0;
	EngineGlobals.blend_mode_override			= 0;

	EngineGlobals.clear_color_buffer			= true;
	EngineGlobals.clear_color					= 0x00506070;
	EngineGlobals.letterbox_active				= false;

	// Set default directional lights
	EngineGlobals.directional_light_color[0]	= -0.5f;		// Dir0
	EngineGlobals.directional_light_color[1]	= -0.8660254f;
	EngineGlobals.directional_light_color[2]	= 0.0f;
	EngineGlobals.directional_light_color[3]	= 0.0f;
	EngineGlobals.directional_light_color[4]	= 0.586f;		// Col0
	EngineGlobals.directional_light_color[5]	= 0.586f;
	EngineGlobals.directional_light_color[6]	= 0.586f;
	EngineGlobals.directional_light_color[7]	= 1.0f;
	
	EngineGlobals.directional_light_color[8]	= 1.0f;			// Dir1
	EngineGlobals.directional_light_color[9]	= 0.0f;
	EngineGlobals.directional_light_color[10]	= 0.0f;
	EngineGlobals.directional_light_color[11]	= 0.0f;
	EngineGlobals.directional_light_color[12]	= 0.0f;			// Col1
	EngineGlobals.directional_light_color[13]	= 0.0f;
	EngineGlobals.directional_light_color[14]	= 0.0f;
	EngineGlobals.directional_light_color[15]	= 1.0f;
	
	EngineGlobals.directional_light_color[16]	= 1.0f;			// Dir2
	EngineGlobals.directional_light_color[17]	= 0.0f;
	EngineGlobals.directional_light_color[18]	= 0.0f;
	EngineGlobals.directional_light_color[19]	= 0.0f;
	EngineGlobals.directional_light_color[20]	= 0.0f;			// Col2
	EngineGlobals.directional_light_color[21]	= 0.0f;
	EngineGlobals.directional_light_color[22]	= 0.0f;
	EngineGlobals.directional_light_color[23]	= 1.0f;

	// Set default ambient light.
	EngineGlobals.ambient_light_color[0]		= 0.5865f;
	EngineGlobals.ambient_light_color[1]		= 0.5865f;
	EngineGlobals.ambient_light_color[2]		= 0.5865f;
	EngineGlobals.ambient_light_color[3]		= 1.0f;
 
	EngineGlobals.fog_enabled					= false;
	EngineGlobals.fog_color						= 0x00000000UL;
	EngineGlobals.fog_start						= FEET_TO_INCHES( -20.0f );
	EngineGlobals.fog_end						= FEET_TO_INCHES( -2050.0f );
	
	// LWSS: Change D3D calls here for PC
	D3DDevice_SetRenderState(D3DRS_RANGEFOGENABLE, 1);
	D3DDevice_SetRenderState(D3DRS_FOGENABLE, EngineGlobals.fog_enabled);
	D3DDevice_SetRenderState(D3DRS_FOGTABLEMODE, 0);
	D3DDevice_SetRenderState(D3DRS_FOGVERTEXMODE, 3);
	D3DDevice_SetRenderState(D3DRS_FOGCOLOR, EngineGlobals.fog_color);

	/*
	D3DDevice_SetRenderState( D3DRS_FOGENABLE,		EngineGlobals.fog_enabled );
	D3DDevice_SetRenderState( D3DRS_FOGTABLEMODE,	D3DFOG_LINEAR );
//	D3DDevice_SetRenderState( D3DRS_FOGTABLEMODE,	D3DFOG_EXP );
//	D3DDevice_SetRenderState( D3DRS_FOGSTART,		*((DWORD*)( &EngineGlobals.fog_start )));
//	D3DDevice_SetRenderState( D3DRS_FOGEND,			*((DWORD*)( &EngineGlobals.fog_end )));
	D3DDevice_SetRenderState( D3DRS_FOGCOLOR,		EngineGlobals.fog_color );
	*/

	// LWSS: extra bits for PC
	if (EngineGlobals.g_Registry_options_flag_1_MSAA)
	{
		D3DDevice_SetRenderState(D3DRS_MULTISAMPLEANTIALIAS, 1);
	}

	D3DDevice_SetVertexShader(0);
	D3DDevice_SetPixelShader(0);

	EngineGlobals.use_all_blur_flags = 1;
	EngineGlobals.z_bias = 0;

	D3DDevice_SetRenderState(D3DRS_DEPTHBIAS, 0);
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// lwss add
void CreateVertexBufferPC(uint32 len)
{
	D3DDevice_CreateVertexBuffer(len, 520, 0, D3DPOOL_DEFAULT, &EngineGlobals.p_vertex_buffer, 0);
	EngineGlobals.vertex_buffer_length = len;
}

void CreateIndexBufferPC(uint32 len)
{
	uint16* indexData = NULL;
	D3DDevice_CreateIndexBuffer(12 * len, 8, D3DFMT_INDEX16, D3DPOOL_DEFAULT, &EngineGlobals.p_index_buffer, 0);

	// Locks a range of index data and obtains a pointer to the index buffer memory.
	EngineGlobals.p_index_buffer->Lock(0, 0, (void**)&indexData, 0);
	if (len)
	{
		int i = len;
		int val = 0;
		do
		{
			indexData[0] = val;
			indexData[1] = val + 1;
			indexData[2] = val + 2;
			indexData[3] = val + 3;
			indexData[4] = val + 4;
			indexData[5] = val + 5;
			indexData += 6;
			val += 4;
			i--;
		} while (i);
	}

	EngineGlobals.p_index_buffer->Unlock();
}

void QueryRegistryAndSetGammaRamp()
{
	byte r[4];
	byte g[4];
	byte b[4];

	*(float*)r = 0.14f;
	*(float*)g = 0.13f;
	*(float*)b = 0.12f;

	DWORD cbData;
	HKEY result;
	if (!RegOpenKeyExA(HKEY_CURRENT_USER, "Software\\Activision\\Tony Hawk's Underground\\Settings\\Gamma", 0, 0X20019, &result))
	{
		cbData = 4;
		RegQueryValueExA(result, "R", 0, 0, r, &cbData);
	}

	SetGammaNormalized(*(float*)r, *(float*)g, *(float*)b);
}
// lwss end

// LWSS: Somewhat Heavily Reworked this function for PC port.
// LWSS: Should be Done
void InitialiseEngine( void )
{
	// Setup default values for the screen conversion macro.
	EngineGlobals.screen_conv_x_multiplier	= 640.0f / 640.0f;
	EngineGlobals.screen_conv_y_multiplier	= 480.0f / 480.0f;
	EngineGlobals.loadingbar_timer_event = 0;
	EngineGlobals.screen_conv_x_offset		= 0;
	EngineGlobals.screen_conv_y_offset		= 16;	
	EngineGlobals.letterbox_active = false;
	
	if (EngineGlobals.g_windowHasBeenDisplayedEver)
	{
		ShowWindow(EngineGlobals.hWnd, SW_SHOWMAXIMIZED);
	}

	//EngineGlobals.p_d3d = Direct3DCreate8(220);
	//EngineGlobals.p_d3d = Direct3DCreate9(D3D_SDK_VERSION);
	EngineGlobals.p_d3d = Direct3DCreate9(32);

	Dbg_Assert(EngineGlobals.p_d3d != NULL);

	D3DDISPLAYMODE displayMode;
	Dbg_Assert(EngineGlobals.p_d3d->GetAdapterDisplayMode(0, &displayMode) == D3D_OK);

#define params NxXbox::EngineGlobals.params

	ZeroMemory( &params, sizeof( D3DPRESENT_PARAMETERS ));

	//params.Windowed = FALSE;
	params.Windowed = TRUE;
	params.hDeviceWindow = EngineGlobals.hWnd;

	int graphicsLevel = 3 - EngineGlobals.g_Registry_resolution_setting;
	if (graphicsLevel > 3)
		graphicsLevel = 3;

	static const int heights[] = { 1024, 768, 600, 480 };
	static const int widths[] = { 1280, 1024, 800, 640 };

	static int s_engineResolutionWidth = widths[graphicsLevel];
	static int s_engineResolutionHeight = heights[graphicsLevel];

#ifndef KISAK_EARLY_CURSOR_FIX
	SetWindowPos(EngineGlobals.hWnd, 0, 0, 0, s_engineResolutionWidth, s_engineResolutionHeight, SWP_NOZORDER);
#endif

	params.BackBufferWidth = s_engineResolutionWidth;
	params.BackBufferHeight = s_engineResolutionHeight;
	params.BackBufferCount = 1;
	params.EnableAutoDepthStencil = TRUE;
	params.MultiSampleType = D3DMULTISAMPLE_NONE;
	params.SwapEffect = D3DSWAPEFFECT_DISCARD;

	if (EngineGlobals.g_Registry_options_flag_1_MSAA)
	{
		params.MultiSampleType = D3DMULTISAMPLE_2_SAMPLES;
		params.SwapEffect = D3DSWAPEFFECT_DISCARD;
	}

	params.AutoDepthStencilFormat = D3DFMT_D24X8;
	params.FullScreen_RefreshRateInHz = 0;
	params.BackBufferFormat = params.Windowed ? displayMode.Format : D3DFMT_X8R8G8B8;

	int attempts = 0;
TRY_THE_FUCK_AGAIN:
	attempts++;
	auto createDeviceErr = NxXbox::EngineGlobals.p_d3d->CreateDevice(D3DADAPTER_DEFAULT,
		D3DDEVTYPE_HAL,
		EngineGlobals.hWnd,
		//D3DCREATE_HARDWARE_VERTEXPROCESSING,	// Note: may want to consider adding the PUREDEVICE flag here also.
		D3DCREATE_HARDWARE_VERTEXPROCESSING | D3DCREATE_MULTITHREADED,	// Note: may want to consider adding the PUREDEVICE flag here also.
		&params,
		&EngineGlobals.p_Device);
		
		//Direct3D_CreateDevice(D3DADAPTER_DEFAULT,
		//D3DDEVTYPE_HAL,
		//NULL,
		////D3DCREATE_HARDWARE_VERTEXPROCESSING,	// Note: may want to consider adding the PUREDEVICE flag here also.
		//D3DCREATE_HARDWARE_VERTEXPROCESSING | D3DCREATE_MULTITHREADED,	// Note: may want to consider adding the PUREDEVICE flag here also.
		//&params,
		//&EngineGlobals.p_Device);

	if( D3D_OK != createDeviceErr)
	{
		Sleep(200); 
		if (attempts < 4)
		{
			params.BackBufferWidth = widths[attempts];
			params.BackBufferHeight = heights[attempts];
			s_engineResolutionWidth = widths[attempts];
			s_engineResolutionHeight = heights[attempts];
			goto TRY_THE_FUCK_AGAIN;
		}
		else
		{
			// YOUR FUCKED
			Dbg_Assert(0);
		}
		// Failed to start up engine. Bad!
		switch (createDeviceErr)
		{
		case D3DERR_DEVICELOST:
			Dbg_Assert(0);
			break;
		case D3DERR_INVALIDCALL:
			Dbg_Assert(0);
			break;
		case D3DERR_NOTAVAILABLE:
			Dbg_Assert(0);
			break;
		case D3DERR_OUTOFVIDEOMEMORY:
			Dbg_Assert(0);
			break;
		}
		exit( 0 );
	}

	// LWSS: omitted some crappy retry code for the d3d create here.

	EngineGlobals.screen_conv_x_multiplier = params.BackBufferWidth / 640.0;
	EngineGlobals.screen_conv_x_offset = 0;
	EngineGlobals.screen_conv_y_multiplier = params.BackBufferHeight / 480.0f;
	EngineGlobals.screen_conv_y_offset = (int)(EngineGlobals.screen_conv_y_multiplier * 16.0f);

	D3DXCreateTexture(EngineGlobals.p_Device, params.BackBufferWidth, params.BackBufferHeight, 1, 1, params.BackBufferFormat, D3DPOOL_DEFAULT, &EngineGlobals.p_BlurSurface_2);

	D3DDevice_CreateDepthStencilSurface(params.BackBufferWidth, params.BackBufferHeight, params.AutoDepthStencilFormat, D3DMULTISAMPLE_NONE, 0, 1, &EngineGlobals.p_BlurSurface_3, 0);
	D3DDevice_GetRenderTarget(0, &EngineGlobals.p_RenderSurface);
	D3DDevice_GetDepthStencilSurface(&EngineGlobals.p_ZStencilSurface);

	EngineGlobals.p_RenderSurface->Release();
	EngineGlobals.p_ZStencilSurface->Release();

	//D3DDevice_CreateTexture(params.BackBufferWidth, params.BackBufferHeight, 1, 1, params.BackBufferFormat, D3DPOOL_DEFAULT, &EngineGlobals.p_BlurSurface_0, 0);
	D3DDevice_CreateTexture(params.BackBufferWidth, params.BackBufferHeight, 1, 1, params.BackBufferFormat, D3DPOOL_MANAGED, &EngineGlobals.p_BlurSurface_0, 0);
	D3DDevice_CreateDepthStencilSurface(params.BackBufferWidth, params.BackBufferHeight, params.AutoDepthStencilFormat, D3DMULTISAMPLE_NONE, 0, 1, &EngineGlobals.p_BlurSurface_1, 0);

	D3DCAPS9 deviceCaps;
	D3DDevice_GetDeviceCaps(&deviceCaps);

	if (LOWORD(deviceCaps.PixelShaderVersion) > 0x101)
	{
		EngineGlobals.hasHLSLv101 = true;
	}

	EngineGlobals.devicecaps_max_anisotopy = deviceCaps.MaxAnisotropy;
	if (deviceCaps.TextureAddressCaps & D3DPTADDRESSCAPS_BORDER)
	{
		EngineGlobals.has_D3DPTADDRESSCAPS_BORDER = true;
	}

	EngineGlobals.dontConvertBlendModes = true;

	if ((deviceCaps.SrcBlendCaps & 0x2000 == 0) || (deviceCaps.DestBlendCaps & 0x2000 == 0))
	{
		EngineGlobals.dontConvertBlendModes = false;
	}

	EngineGlobals.backbuffer_width = params.BackBufferWidth;
	EngineGlobals.zstencil_depth = params.AutoDepthStencilFormat != D3DFMT_D16 ? 32 : 16;
	EngineGlobals.backbuffer_height = params.BackBufferHeight;
	EngineGlobals.backbuffer_format = params.BackBufferFormat;

	if (EngineGlobals.p_BlurSurface_2)
	{
		IDirect3DSurface9* surfaceLevel;
		EngineGlobals.p_BlurSurface_2->GetSurfaceLevel(0, &surfaceLevel);

		D3DSURFACE_DESC desc;
		surfaceLevel->GetDesc(&desc);
		surfaceLevel->Release();

		EngineGlobals.blurbuffer_format = desc.Format;
	}

	InitialiseRenderstates();

	if (!params.Windowed)
	{
		while (ShowCursor(0) > 0)
		{
		}
	}

	QueryRegistryAndSetGammaRamp();

	EngineGlobals.p_memory_resident_font = NULL;

	CreateVertexBufferPC(0x10000u);
	CreateIndexBufferPC(0x1000u);
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void FatalFileError( uint32 error )
{
	static char*	p_error_message_english[2]	= {	"There's a problem with the disc you're using.",
													"It may be dirty or damaged." };
	static char*	p_error_message_french[2]	= {	"Le disque utilis� pr�sente une anomalie.",
													"Il est peut-�tre sale ou endommag�." };
	static char*	p_error_message_german[2]	= {	"Bei der benutzten CD ist ein Problem aufgetreten.",
													"M�glicherweise ist sie verschmutzt oder besch�digt." };
	// Turn off the loading bar if it is active.
	if( EngineGlobals.loadingbar_timer_event != 0 )
	{
		timeKillEvent( EngineGlobals.loadingbar_timer_event );
		EngineGlobals.loadingbar_timer_event = 0;
	}

	// Ensure the graphics device has been initialised at this point.
	if( EngineGlobals.p_Device == NULL )
	{
		InitialiseEngine();
	}

	// Wait for any rendering to complete.
	//EngineGlobals.p_Device->BlockUntilIdle();

	char*	p_error_message[2];
	switch( Config::GetLanguage())
	{
		case Config::LANGUAGE_FRENCH:
		{
			p_error_message[0] = p_error_message_french[0];
			p_error_message[1] = p_error_message_french[1];
			break;
		}
		case Config::LANGUAGE_GERMAN:
		{
			p_error_message[0] = p_error_message_german[0];
			p_error_message[1] = p_error_message_german[1];
			break;
		}
		default:
		{
			p_error_message[0] = p_error_message_english[0];
			p_error_message[1] = p_error_message_english[1];
			break;
		}

	}

	// Set up the text string used for the error message.
	SText error_text;
	error_text.mp_font		= (SFont*)EngineGlobals.p_memory_resident_font;
	error_text.m_xpos		= 48.0f;
	error_text.m_ypos		= 128.0f;
	error_text.m_xscale		= 0.8f;
	error_text.m_yscale		= 1.0f;
	error_text.m_rgba		= 0x80808080;
	error_text.mp_next		= NULL;

	set_texture( 1, NULL );
	set_texture( 2, NULL );
	set_texture( 3, NULL );

	// Want an infinite loop here.
	while( true )
	{
		// lwss add
		//D3DDevice_Swap( D3DSWAP_DEFAULT );

		// Now that the swap instruction has been pushed, clear the buffer for next frame.
		//D3DDevice_Clear( 0, NULL, D3DCLEAR_TARGET | D3DCLEAR_ZBUFFER | D3DCLEAR_STENCIL, 0x00000000, 1.0f, 0 );
		D3DDevice_Present(0, 0, 0, 0); 
		D3DDevice_Clear( 0, NULL, D3DCLEAR_TARGET | D3DCLEAR_ZBUFFER, 0, 1.0f, 0 );

		// lwss end
		set_blend_mode( vBLEND_MODE_BLEND );
		set_texture( 0, NULL );

		set_render_state( RS_UVADDRESSMODE0,	0x00010001UL );
		set_render_state( RS_ZBIAS,				0 );
		set_render_state( RS_ALPHACUTOFF,		1 );
		set_render_state( RS_ZWRITEENABLE,		0 );

		//D3DDevice_SetTextureStageState( 0, D3DTSS_COLORSIGN, D3DTSIGN_RUNSIGNED | D3DTSIGN_GUNSIGNED | D3DTSIGN_BUNSIGNED );
		D3DDevice_SetTextureStageState( 0, D3DTSS_TEXTURETRANSFORMFLAGS, D3DTTFF_DISABLE );
		D3DDevice_SetTextureStageState( 0, D3DTSS_TEXCOORDINDEX, D3DTSS_TCI_PASSTHRU | 0 );

		error_text.mp_string	= p_error_message[0];
		error_text.m_ypos		= error_text.m_ypos - 16.0f;
		error_text.BeginDraw();
		error_text.Draw();
		error_text.EndDraw();

		error_text.mp_string	= p_error_message[1];
		error_text.m_ypos		= error_text.m_ypos + 16.0f;
		error_text.BeginDraw();
		error_text.Draw();
		error_text.EndDraw();
	}
}



} // namespace NxXbox

