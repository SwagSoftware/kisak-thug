/////////////////////////////////////////////////////////////////////////////
// p_NxLoadScreen.cpp - Xbox platform specific interface for the load screen
//
//

#include	"gfx\Nx.h"
#include	"gfx\NxLoadScreen.h"
#include	"gfx\DX9/p_NxTexture.h"
#include	"gfx\DX9/p_NxSprite.h"
#include	"gfx\DX9/NX\sprite.h"
#include	"gfx\DX9/NX\scene.h"
#include	"gfx\DX9/NX\render.h"
#include	"sys\config\config.h"

#include	"core\macros.h"

#include "NX/nx_init.h"

namespace	Nx
{


Nx::CXboxTexture	*sp_load_screen_texture;
Nx::CXboxSprite	*sp_load_screen_sprite;

static float		loadingBarTotalSeconds;
static float		loadingBarCurrentSeconds;
static float		loadingBarDeltaSeconds;
static int			loadingBarStartColor[3];		// r,g,b
static int			loadingBarEndColor[3];			// r,g,b
static uint32		loadingBarColors[1280][3];		// r,g,b
static bool			loadingBarColorsSet = false;
static int			loadingBarWidth;
static uint32		loadingBarBorderColor;


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Functions

#define USE_SPRITES 0

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS Add ++
static void DrawLoadScreenTexture()
{
	if (!sp_load_screen_texture)
	{
		return;
	}

	WaitForSingleObject(NxXbox::EngineGlobals.g_asyncRenderMutex, 0xFFFFFFFF);
	D3DDevice_SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_SELECTARG1);
	D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1);
	D3DDevice_SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
	D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE);

	DWORD minFilter;
	D3DDevice_GetSamplerState(0, D3DSAMP_MINFILTER, &minFilter);

	D3DDevice_SetSamplerState(0, D3DSAMP_MAGFILTER, D3DTEXF_LINEAR);
	D3DDevice_SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR);

	NxXbox::set_render_state(RS_UVADDRESSMODE0, 0x10001);

	D3DDevice_SetRenderState(D3DRS_LIGHTING, FALSE);

	NxXbox::set_pixel_shader(NULL);
	NxXbox::set_vertex_shader(D3DFVF_TEX1 | D3DFVF_XYZRHW);
	NxXbox::set_blend_mode(0);
	NxXbox::set_texture(0, 0);

	NxXbox::sTexture* p_texture = sp_load_screen_texture->GetEngineTexture();

	NxXbox::set_texture(0, p_texture->pD3DTexture);
	
	float vertexes[24];
	vertexes[0] = 0.0;
	vertexes[1] = 0.0;
	vertexes[2] = 0.0;
	vertexes[3] = 1.0;
	vertexes[5] = 1.0;
	vertexes[4] = 0.0;
	vertexes[13] = 0.0;
	vertexes[6] = 0.0;
	vertexes[7] = NxXbox::EngineGlobals.backbuffer_height;
	vertexes[8] = 0.0;
	vertexes[14] = 0.0;
	vertexes[11] = 0.0;
	vertexes[20] = 0.0;
	vertexes[9] = 1.0;
	vertexes[10] = 0.0;
	vertexes[15] = 1.0;
	vertexes[17] = 1.0;
	vertexes[21] = 1.0;
	vertexes[12] = NxXbox::EngineGlobals.backbuffer_width;
	vertexes[18] = vertexes[12];
	vertexes[16] = 1.0;
	vertexes[22] = 1.0;
	vertexes[19] = vertexes[7];
	vertexes[23] = 0.0;

	D3DDevice_DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, vertexes, 24);
	NxXbox::set_texture(0, 0);
	D3DDevice_SetSamplerState(0, D3DSAMP_MINFILTER, minFilter);

	ReleaseMutex(NxXbox::EngineGlobals.g_asyncRenderMutex);
}
// LWSS End
void CALLBACK loadingBarTimerCallback( UINT uTimerID, UINT uMsg, DWORD_PTR dwUser, DWORD_PTR dw1, DWORD_PTR dw2 )
{
	if( NxXbox::EngineGlobals.loadingbar_timer_event != 0 && NxXbox::EngineGlobals.loadingscreen_visible )
	{
		// LWSS: Changes for PC (Done!)
		WaitForSingleObject(NxXbox::EngineGlobals.g_asyncRenderMutex, 0xFFFFFFFF);
		D3DDevice_BeginScene(); 
		
		DrawLoadScreenTexture();

		float widthScale = NxXbox::EngineGlobals.backbuffer_width / 640.0f;
		float heightScale = NxXbox::EngineGlobals.backbuffer_height / 480.0f;

		loadingBarCurrentSeconds = loadingBarDeltaSeconds + loadingBarCurrentSeconds;
		float mult = loadingBarCurrentSeconds / loadingBarTotalSeconds;
		mult = (mult > 1.0f) ? 1.0f : mult;

		int halfWidthOffset = (NxXbox::EngineGlobals.backbuffer_width - loadingBarWidth) / 2;
		float fHalfWidthOffset = (float)halfWidthOffset;
		int v14 = (int)(fHalfWidthOffset - 5.0f * widthScale);
		int v24 = halfWidthOffset + (int)((double)loadingBarWidth * mult);
		int v20 = (int)((double)(v14 + loadingBarWidth) + widthScale * 10.0);
		int v12 = (float)(int)(420.0 * heightScale);

		float vertexes[20];
		LODWORD(vertexes[4]) = loadingBarBorderColor;
		LODWORD(vertexes[9]) = loadingBarBorderColor;
		vertexes[0] = v14;
		LODWORD(vertexes[14]) = loadingBarBorderColor;
		vertexes[1] = v12;
		vertexes[2] = 1.0;
		vertexes[3] = 1.0;
		vertexes[5] = v14;
		float widthScalea = (float)(int)(heightScale * 20.0 + v12);
		vertexes[6] = widthScalea;
		vertexes[7] = 1.0;
		vertexes[8] = 1.0;
		vertexes[10] = v20;
		vertexes[11] = v12;
		vertexes[12] = 1.0;
		vertexes[13] = 1.0;
		vertexes[15] = v20;
		vertexes[16] = widthScalea;
		vertexes[17] = 1.0;
		vertexes[18] = 1.0;
		LODWORD(vertexes[19]) = loadingBarBorderColor;

		NxXbox::set_texture(0, 0);
		D3DDevice_SetRenderState(D3DRS_ZENABLE, 0);
		NxXbox::set_vertex_shader(D3DFVF_DIFFUSE | D3DFVF_XYZRHW);
		D3DDevice_DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, vertexes, 20);

		vertexes[0] = fHalfWidthOffset;
		float v7 = heightScale * 5.0f;
		float v21 = v12 + v7;
		vertexes[1] = v21;
		vertexes[2] = 1.0;
		vertexes[3] = 1.0;
		vertexes[5] = fHalfWidthOffset;
		float v8 = widthScalea - v7;
		float v9 = v21;
		float v22 = v8;
		LODWORD(vertexes[4]) = (unsigned __int8)loadingBarStartColor[2] | (((unsigned __int8)loadingBarStartColor[1] | ((loadingBarStartColor[0] | 0xFFFFFF00) << 8)) << 8);
		vertexes[9] = vertexes[4];
		vertexes[6] = v22;
		float v10 = v22;
		vertexes[7] = 1.0;
		vertexes[8] = 1.0;
		float v23 = (float)(halfWidthOffset + loadingBarWidth);
		vertexes[10] = v23;
		vertexes[11] = v9;
		vertexes[12] = 1.0;
		vertexes[13] = 1.0;
		vertexes[15] = v23;
		vertexes[16] = v10;
		vertexes[17] = 1.0;
		//LODWORD(vertexes[14]) = (unsigned __int8)loadingBarStartColor[2] | (((unsigned __int8)loadingBarStartColor[1] | ((loadingBarStartColor[0] | 0xFFFFFF00) << 8)) << 8);
		LODWORD(vertexes[14]) = loadingBarBorderColor;
		vertexes[18] = 1.0;
		vertexes[19] = vertexes[14];
	
		D3DDevice_DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, vertexes, 20);

		vertexes[0] = v24;
		LODWORD(vertexes[4]) = loadingBarBorderColor;
		LODWORD(vertexes[9]) = loadingBarBorderColor;
		//vertexes[1] = mult;
		vertexes[1] = (420.0f * heightScale);
		LODWORD(vertexes[14]) = loadingBarBorderColor;
		LODWORD(vertexes[19]) = loadingBarBorderColor;
		vertexes[2] = 1.0;
		vertexes[3] = 1.0;
		vertexes[5] = v24;
		vertexes[6] = widthScalea;
		vertexes[7] = 1.0;
		vertexes[8] = 1.0;
		vertexes[10] = v20;
		//vertexes[11] = mult;
		vertexes[11] = (420.0f * heightScale);
		vertexes[12] = 1.0;
		vertexes[13] = 1.0;
		vertexes[15] = v20;
		vertexes[16] = widthScalea;
		vertexes[17] = 1.0;
		vertexes[18] = 1.0;

		D3DDevice_DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, vertexes, 20);
		D3DDevice_SetRenderState(D3DRS_ZENABLE, 1);
		D3DDevice_EndScene();
		D3DDevice_Present(0, 0, 0, 0);

		ReleaseMutex(NxXbox::EngineGlobals.g_asyncRenderMutex);
		// LWSS: Removed.
		//loadingBarCurrentSeconds += loadingBarDeltaSeconds;
		//float mult			= loadingBarCurrentSeconds / loadingBarTotalSeconds;
		//mult				= ( mult > 1.0f ) ? 1.0f : mult;
		//int bar_width		= (int)( loadingBarWidth * mult );
		//
		//// Get pointer to front buffer memory.
		//IDirect3DSurface8	*p_buffer;
		//D3DLOCKED_RECT		locked_rect;
		//NxXbox::EngineGlobals.p_Device->GetBackBuffer( -1, D3DBACKBUFFER_TYPE_MONO, &p_buffer );
		//p_buffer->LockRect( &locked_rect, NULL, D3DLOCK_TILED );
		//uint32 *p_screen = (uint32*)locked_rect.pBits;
		//
		//// ----------------------------------
		//// | ||||||||||||||||||||||          |
		//// ----------------------------------
		//// ^ ^                    ^          ^
		//// a b                    c			 d
		//// 
		//// a = surround start
		//// b = bar start
		//// c = bar end
		//// d = surround end
		//int bar_start			= ( 640 - loadingBarWidth ) / 2;
		//int surround_start		= bar_start - 5;
		//int bar_end				= bar_start + bar_width;
		//int surround_end		= surround_start + loadingBarWidth + 10;
		//
		//const int HDTV_OFFSET	= 48;	
		//
		//bar_start				= (int)SCREEN_CONV_X( bar_start );
		//surround_start			= (int)SCREEN_CONV_X( surround_start );
		//bar_end					= (int)SCREEN_CONV_X( bar_end );
		//surround_end			= (int)SCREEN_CONV_X( surround_end );
		//
		//if( NxXbox::EngineGlobals.backbuffer_width > 640 )
		//{
		//	bar_start			+= HDTV_OFFSET;
		//	surround_start		+= HDTV_OFFSET;
		//	bar_end				+= HDTV_OFFSET;
		//	surround_end		+= HDTV_OFFSET;
		//}
		//
		//int base_y				= (int)SCREEN_CONV_Y( 410 );
		//
		//for( int i = 0; i < 20; ++i )
		//{
		//	uint32 *p_loop = p_screen + (( base_y + i ) * NxXbox::EngineGlobals.backbuffer_width );
		//
		//	if(( i < 5 ) || ( i >= 15 ))
		//	{
		//		for( int j = surround_start; j < surround_end; ++j )
		//			p_loop[j] = loadingBarBorderColor;
		//	}
		//	else
		//	{
		//		for( int j = surround_start; j < ( surround_start + 5 ); ++j )
		//			p_loop[j] = loadingBarBorderColor;
		//
		//		for( int j = bar_end; j < surround_end; ++j )
		//			p_loop[j] = loadingBarBorderColor;
		//
		//		for( int j = bar_start; j < bar_end; ++j )			
		//		{
		//			uint32 idx			= ( j - bar_start >= 1279 ) ? 1279 : ( j - bar_start );
		//			uint32 write_value	= 0x80000000UL | ( loadingBarColors[idx][0] << 16 ) | ( loadingBarColors[idx][1] << 8 ) | ( loadingBarColors[idx][2] << 0 );
		//			p_loop[j]			= write_value;
		//		}
		//	}
		//}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static bool is_power_of_two( uint32 a )
{
	if( a == 0 )
	{
		return false;
	}
	return (( a & ( a - 1 )) == 0 );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: Done!
void CLoadScreen::s_plat_display(const char* filename, bool just_freeze, bool blank)
{
	// Wait for asyncronous rendering to finish.
	//NxXbox::EngineGlobals.p_Device->BlockUntilIdle();
	// LWSS: the PC here uses a mutex instead
	WaitForSingleObject(NxXbox::EngineGlobals.g_asyncRenderMutex, 0xFFFFFFFF);

	if( !just_freeze )
	{
		if( blank )
		{
			D3DDevice_Clear( 0, NULL, D3DCLEAR_TARGET, 0x00000000UL, 1.0f, 0 );
			// lwss: change for PC
			//D3DDevice_Swap( D3DSWAP_DEFAULT );
			D3DDevice_Present( 0, 0, 0, 0 );
		}
		else
		{
			// Engine stuff
			Dbg_Assert(!sp_load_screen_texture);
			Dbg_Assert(!sp_load_screen_sprite);

			sp_load_screen_texture = new CXboxTexture();

			if( !sp_load_screen_texture->LoadTexture( filename, true ))
			{
				Dbg_Error( "Can't load texture %s", filename );
				ReleaseMutex(NxXbox::EngineGlobals.g_asyncRenderMutex); // lwss add
				return;
			}

			D3DDevice_BeginScene();
			DrawLoadScreenTexture();
			D3DDevice_EndScene();
			D3DDevice_Present(0, 0, 0, 0);

			// LWSS: Moved into other function (reworked)
			//// Copy into frame buffer.
			//float x_offset		= 0.0f;
			//float y_offset		= 0.0f;
			//float x_scale		= 1.0f;
			//float y_scale		= 1.0f;
			//float alpha_level	= 1.0f;
			//
			//D3DDevice_SetTextureStageState( 0, D3DTSS_COLOROP, D3DTOP_SELECTARG1 );
			//D3DDevice_SetTextureStageState( 0, D3DTSS_ALPHAOP, D3DTOP_SELECTARG1 );
			//D3DDevice_SetTextureStageState( 0, D3DTSS_COLORARG1, D3DTA_TEXTURE );
			//D3DDevice_SetTextureStageState( 0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE );
			//
			//// Store the stage zero minfilter, since it may be anisotropic.
			//DWORD	stage_zero_minfilter;
			//D3DDevice_GetTextureStageState( 0, D3DTSS_MINFILTER, &stage_zero_minfilter );
			//
			//// Turn on texture filtering when scaling...
			//D3DDevice_SetTextureStageState( 0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR );
			//D3DDevice_SetTextureStageState( 0, D3DTSS_MINFILTER, D3DTEXF_LINEAR );
			//
			//// Turn on clamping so that the linear textures work
			//NxXbox::set_render_state( RS_UVADDRESSMODE0, 0x00010001UL );
			//
			//D3DDevice_SetRenderState( D3DRS_LIGHTING,				FALSE );
			//
			//// Use a default vertex shader
			//NxXbox::set_pixel_shader( 0 );
			//NxXbox::set_vertex_shader( D3DFVF_XYZRHW | D3DFVF_TEX1 );
			//NxXbox::set_blend_mode( NxXbox::vBLEND_MODE_DIFFUSE );
			//
			//// Select the texture (flush first, since the screen texture is linear).
			//NxXbox::set_texture( 0, NULL );
			//NxXbox::set_texture( 0, sp_load_screen_texture->GetEngineTexture()->pD3DTexture, sp_load_screen_texture->GetEngineTexture()->pD3DPalette );
			//
			//// Setup up the vertices.
			//typedef struct
			//{
			//	float	sx,sy,sz;
			//	float	rhw;
			//	float	tu,tv;
			//}
			//LOADSCREEN_VERT;
			//
			//// Get the width height from the texture itself, since we may be using a texture not designed especially
			//// for this screen dimension.
			//float tex_w = (float)sp_load_screen_texture->GetEngineTexture()->ActualWidth;
			//float tex_h = (float)sp_load_screen_texture->GetEngineTexture()->ActualHeight;
			//float scr_w = (float)NxXbox::EngineGlobals.backbuffer_width;
			//float scr_h = (float)NxXbox::EngineGlobals.backbuffer_height;
			//
			//LOADSCREEN_VERT	vertices[4];
			//
			//// The texture coordinate addressing will differ depending on whether this is a linear texture or not.
			//if( is_power_of_two( sp_load_screen_texture->GetEngineTexture()->ActualWidth ) &&
			//	is_power_of_two( sp_load_screen_texture->GetEngineTexture()->ActualHeight ))
			//{
			//	// Not a linear texture, will be swizzled, max uv is (1.0, 1.0).
			//	vertices[0].sx		= x_offset;
			//	vertices[0].sy		= y_offset;
			//	vertices[0].sz		= 0.0f;
			//	vertices[0].rhw		= 0.0f;
			//	vertices[0].tu		= 0.0f;
			//	vertices[0].tv		= 1.0f;
			//	vertices[1]			= vertices[0];
			//	vertices[1].sy		= y_offset + ( scr_h * y_scale );
			//	vertices[1].tv		= 0.0f;
			//	vertices[2]			= vertices[0];
			//	vertices[2].sx		= x_offset + ( scr_w * x_scale );
			//	vertices[2].tu		= 1.0f;
			//	vertices[3]			= vertices[2];
			//	vertices[3].sy		= vertices[1].sy;
			//	vertices[3].tv		= 0.0f;
			//}
			//else
			//{
			//	// Linear texture, won't be swizzled, max uv is (tex_w, tex_h).
			//	vertices[0].sx		= x_offset;
			//	vertices[0].sy		= y_offset;
			//	vertices[0].sz		= 0.0f;
			//	vertices[0].rhw		= 0.0f;
			//	vertices[0].tu		= -0.5f;
			//	vertices[0].tv		= tex_h - 0.5f;
			//	vertices[1]			= vertices[0];
			//	vertices[1].sy		= y_offset + ( scr_h * y_scale );
			//	vertices[1].tv		= -0.5f;
			//	vertices[2]			= vertices[0];
			//	vertices[2].sx		= x_offset + ( scr_w * x_scale );
			//	vertices[2].tu		= tex_w - 0.5f;
			//	vertices[3]			= vertices[2];
			//	vertices[3].sy		= vertices[1].sy;
			//	vertices[3].tv		= -0.5f;
			//}
			//
			//// Draw the vertices, and make sure they're displayed.
			//D3DDevice_DrawVerticesUP( D3DPT_TRIANGLESTRIP, 4, vertices, sizeof( LOADSCREEN_VERT ));
			//D3DDevice_Swap( D3DSWAP_DEFAULT );
			//
			//// Done with texture
			//delete sp_load_screen_texture;
			//sp_load_screen_texture = NULL;
			//
			//// Reflush linear texture out.
			//NxXbox::set_texture( 0, NULL );
			//
			//// Restore the stage zero minfilter.
			//D3DDevice_SetTextureStageState( 0, D3DTSS_MINFILTER, stage_zero_minfilter );
		}
	}

	// Indicate that the loading screen is visible, to stop any more rendering until it is hidden.
	NxXbox::EngineGlobals.loadingscreen_visible = true;
	ReleaseMutex(NxXbox::EngineGlobals.g_asyncRenderMutex);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CLoadScreen::s_plat_hide()
{
	WaitForSingleObject(NxXbox::EngineGlobals.g_asyncRenderMutex, 0xFFFFFFFF); // lwss add

	// Remove the loading bar.
	if( NxXbox::EngineGlobals.loadingbar_timer_event != 0 )
	{
		timeKillEvent( NxXbox::EngineGlobals.loadingbar_timer_event );
		NxXbox::EngineGlobals.loadingbar_timer_event = 0;
	}

	// lwss add
	if (sp_load_screen_texture)
	{
		delete sp_load_screen_texture;
	}
	sp_load_screen_texture = NULL;
	// lwss end

	// Indicate that the loading screen is no longer visible.
	NxXbox::EngineGlobals.loadingscreen_visible = false;

	ReleaseMutex(NxXbox::EngineGlobals.g_asyncRenderMutex); // lwss add
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CLoadScreen::s_plat_clear()
{
	// LWSS: add mutex code.
#ifdef __PLAT_WN32__
	WaitForSingleObject(NxXbox::EngineGlobals.g_asyncRenderMutex, 0xFFFFFFFF);
#endif
	if( sp_load_screen_sprite )
	{
		CEngine::sDestroySprite(sp_load_screen_sprite);
		sp_load_screen_sprite = NULL;
	}

	if( sp_load_screen_texture )
	{
		delete sp_load_screen_texture;
		sp_load_screen_texture = NULL;
	}
#ifdef __PLAT_WN32__
	ReleaseMutex(NxXbox::EngineGlobals.g_asyncRenderMutex);
#endif
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CLoadScreen::s_plat_start_loading_bar( float seconds )
{
	loadingBarTotalSeconds		= seconds * 0.6f;
	loadingBarCurrentSeconds	= 0.0f;
	loadingBarDeltaSeconds		= 0.03f;	// 30 milliseconds.
	
	s_plat_update_bar_properties();

	// Set up the timer event.
	if( NxXbox::EngineGlobals.loadingbar_timer_event == 0 )
	{
		// KISAKTODO: is the 1st param here 29?
		NxXbox::EngineGlobals.loadingbar_timer_event = timeSetEvent( (uint32)( loadingBarDeltaSeconds * 1000.0f ),	// Delay (ms).
																	 0,												// Ignored resolution (ms).
																	 loadingBarTimerCallback,						// Callback function.
																	 0,												// Callback data.
																	 TIME_PERIODIC | TIME_CALLBACK_FUNCTION );
		Dbg_Assert( NxXbox::EngineGlobals.loadingbar_timer_event != 0 );
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CLoadScreen::s_plat_update_bar_properties( void )
{
	loadingBarStartColor[0] = s_bar_start_color.r;
	loadingBarStartColor[1] = s_bar_start_color.g;
	loadingBarStartColor[2] = s_bar_start_color.b;

	loadingBarEndColor[0]	= s_bar_end_color.r;
	loadingBarEndColor[1]	= s_bar_end_color.g;
	loadingBarEndColor[2]	= s_bar_end_color.b;

	loadingBarWidth			= s_bar_width;
	loadingBarBorderColor	= 0x80000000 | ((uint32)s_bar_border_color.r << 16 ) | ((uint32)s_bar_border_color.g << 8 )  | (uint32)s_bar_border_color.b;

	// Build the interpolated color array.
	int last_color = (int)( loadingBarWidth * NxXbox::EngineGlobals.screen_conv_x_multiplier );
	for( int i = 0; i < last_color; ++i )
	{
		for( int c = 0; c < 3; ++c )
		{
			loadingBarColors[i][c] = loadingBarStartColor[c] + ((( loadingBarEndColor[c] - loadingBarStartColor[c] ) * i ) / last_color );
		}
	}
}


} 
 
