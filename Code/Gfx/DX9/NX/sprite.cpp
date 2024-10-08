#include <string.h>
#include <core/defines.h>
#include <core/macros.h>
#include <core/debug.h>
#include <sys/config/config.h>
#include <sys/file/filesys.h>
#include "nx_init.h"
#include "scene.h"
#include "render.h"
#include "sprite.h"

extern IDirect3DPixelShader9* PixelShader4;
extern IDirect3DPixelShader9* PixelShader5;

namespace NxXbox
{


/******************************************************************/
/*                                                                */
/* SDraw2D														  */
/*                                                                */
/******************************************************************/

SDraw2D *SDraw2D::sp_2D_draw_list = NULL;


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
SDraw2D::SDraw2D( float pri, bool hide )
{
	m_hidden	= hide;
	m_pri		= pri;
	m_zvalue	= 0.0f;

	mp_next = NULL;

	// add to draw list
	if( !m_hidden )
	{
		InsertDrawList();
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
SDraw2D::~SDraw2D()
{
	// Try removing from draw list
	RemoveDrawList();
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::SetPriority( float pri )
{
	if( m_pri != pri )
	{
		m_pri = pri;

		// By removing and re-inserting, we re-sort the list
		if( !m_hidden )
		{
			RemoveDrawList();
			InsertDrawList();
		}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::SetZValue( float z )
{
	m_zvalue = z;

	if( z > 0.0f )
	{
		// Set the priority to zero so it will always draw before everything else.
		SetPriority( 0.0f );
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::SetHidden( bool hide )
{
	if (m_hidden != hide)
	{
		m_hidden = hide;
		if (hide)
		{
			RemoveDrawList();
		} else {
			InsertDrawList();
		}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::DrawAll( void )
{
	static uint32 z_test_required = 0;
	
	set_blend_mode( vBLEND_MODE_BLEND );
	set_render_state( RS_UVADDRESSMODE0, 0x10001UL );
	set_render_state( RS_ZBIAS, 0 );

	// Set the alpha cutoff value.
	set_render_state( RS_ALPHACUTOFF, 1 );

	set_render_state( RS_ZWRITEENABLE,	0 );
	set_texture( 1, NULL );
	set_texture( 2, NULL );
	set_texture( 3, NULL );

	// lwss: removed for PC
	//if( EngineGlobals.color_sign[0] != ( D3DTSIGN_RUNSIGNED | D3DTSIGN_GUNSIGNED | D3DTSIGN_BUNSIGNED ))
	//{
	//	EngineGlobals.color_sign[0] = ( D3DTSIGN_RUNSIGNED | D3DTSIGN_GUNSIGNED | D3DTSIGN_BUNSIGNED );
	//	D3DDevice_SetTextureStageState( 0, D3DTSS_COLORSIGN, D3DTSIGN_RUNSIGNED | D3DTSIGN_GUNSIGNED | D3DTSIGN_BUNSIGNED );
	//}

	// Unfortunately, now that we have 3D text, we may need to enable the z test for some strings.
	set_render_state( RS_ZTESTENABLE,	z_test_required );

	SDraw2D *pDraw	= sp_2D_draw_list;
	uint32	z_test	= 0;

	// lwss: Add for PC
	D3DDevice_SetTextureStageState(0, D3DTSS_TEXCOORDINDEX, 0);
	D3DDevice_SetTextureStageState(0, D3DTSS_TEXTURETRANSFORMFLAGS, 0);
	// lwss end

	while( pDraw )
	{
		if (!pDraw->m_hidden)
		{
			pDraw->BeginDraw();
			pDraw->Draw();
			pDraw->EndDraw();

			if(( z_test == 0 ) && ( pDraw->GetZValue() > 0.0f ))
			{
				// There is at least one peice of text with nonzero z, so we need to z test.
				z_test = 1;
			}
		}
		pDraw = pDraw->mp_next;
	}

	z_test_required = z_test;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::InsertDrawList( void )
{
	if( !sp_2D_draw_list || ( m_pri <= sp_2D_draw_list->m_pri ))
	{
		// Empty or start of list.
		mp_next			= sp_2D_draw_list;
		sp_2D_draw_list	= this;
	}
	else
	{
		SDraw2D *p_cur	= sp_2D_draw_list;
	
		// Find where to insert.
		while( p_cur->mp_next )
		{
			if( m_pri <= p_cur->mp_next->m_pri )
				break;

			p_cur		= p_cur->mp_next;
		}

		// Insert at this point.
		mp_next			= p_cur->mp_next;
		p_cur->mp_next	= this;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::RemoveDrawList( void )
{
	// Take out from draw list
	if (sp_2D_draw_list == this)
	{
		sp_2D_draw_list = mp_next;
	} 
	else if (sp_2D_draw_list)
	{
		SDraw2D *p_cur = sp_2D_draw_list;

		while(p_cur->mp_next)
		{
			if (p_cur->mp_next == this)
			{
				p_cur->mp_next = mp_next;
				break;
			}

			p_cur = p_cur->mp_next;
		}
	}
}

	

typedef struct
{
	float		x, y, z;
	float		rhw;
	D3DCOLOR	col;
	float		u, v;
}
sSpriteVert;


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sSprite::sSprite( float pri ) : SDraw2D( pri, true )
{
	mp_texture = NULL;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sSprite::~sSprite()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sSprite::BeginDraw( void )
{
	set_vertex_shader( D3DFVF_XYZRHW | D3DFVF_DIFFUSE | D3DFVF_TEX1 | D3DFVF_TEXCOORDSIZE2( 0 )); // 0x144
	set_pixel_shader(0);

	if( mp_texture )
	{
		// lwss: change for pc
		//set_pixel_shader( PixelShader4 );
		D3DDevice_SetTextureStageState(0, D3DTSS_COLOROP, 5);
		D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAOP, 5);
		set_texture(0, mp_texture->pD3DTexture);
	}
	else
	{
		//set_pixel_shader( PixelShader5 );
		D3DDevice_SetTextureStageState(0, D3DTSS_COLOROP, 3);
		D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAOP, 3);
		set_texture( 0, NULL );
	}

	D3DDevice_SetTextureStageState(0, D3DTSS_COLORARG2, 1);
	D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAARG2, 1);
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sSprite::Draw(void)
{
	// Sprites are based on .img files, which in turn are converted from .png files, which are upside down,
	// so reverse the v components of the texture coordinates.
	float u0 = 0.0f;
	float v0 = 1.0f;
	float u1, v1;

	float verts[28];

	if (mp_texture)
	{
		u1 = (float)mp_texture->ActualWidth / (float)mp_texture->BaseWidth;
		v1 = 1.0f - ((float)mp_texture->ActualHeight / (float)mp_texture->BaseHeight);
	}
	else
	{
		u1 = 1.0f;
		v1 = 0.0f;
	}

	// Check for flip.
	float abs_scale_x = m_scale_x;
	float abs_scale_y = m_scale_y;

	// lwss: changes here... (yes I know what a fking epsilon is)
	if (abs_scale_x == 0.0f || abs_scale_y == 0.0f)
	{
		return;
	}

	if( abs_scale_x < 0.0f )
	{
		u0 = u1;
		u1 = 0.0f;
		abs_scale_x = -abs_scale_x;
	}
	if( abs_scale_y < 0.0f )
	{
		v0 = v1;
		v1 = 1.0f;
		abs_scale_y = -abs_scale_y;
	}

	float x0 = -( m_xhot * abs_scale_x );
	float y0 = -( m_yhot * abs_scale_y );
	float x1 = x0 + (m_width * abs_scale_x);
	float y1 = y0 + (m_height * abs_scale_y);
	uint32 v8 = this->m_rgba & 0xFF00FF00 | BYTE2(this->m_rgba) | ((unsigned __int8)this->m_rgba << 16);
	float v36 = abs_scale_x * (double)(unsigned __int16)this->m_width + x0;
	float v9 = abs_scale_y * (double)(unsigned __int16)this->m_height + y0;

	//DWORD	current_color	= ( m_rgba & 0xFF00FF00 ) | (( m_rgba & 0xFF ) << 16 ) | (( m_rgba & 0xFF0000 ) >> 16 );
	float v11;
	float v10;
	// lwss: add extra if()
	if (this->m_rgba & 0xFF000000 | (BYTE2(this->m_rgba) | ((unsigned __int8)this->m_rgba << 16)) & 0xFF000000)
	{
		// KISAKTODO: logic cleanup
		if (m_rot == 0.0f)
		{
			float posX = x0 + m_xpos;
			float posY = y0 + m_ypos;
			float posX2 = v36 + m_xpos;
			float posY2 = v9 + m_ypos;


			float calculatedX;
			float calculatedX2;
			float calculatedY;
			float calculatedY2;

			if (posX > 0.0f || posX2 < 640.0f)
			{
				calculatedX = posX * NxXbox::EngineGlobals.screen_conv_x_multiplier + NxXbox::EngineGlobals.screen_conv_x_offset;
				calculatedX2 = NxXbox::EngineGlobals.screen_conv_x_offset + posX2 * EngineGlobals.screen_conv_x_multiplier;
				v11 = 0.0f;
				v10 = 1.0f;
			}
			else
			{
				v11 = 0.0f;
				v10 = 1.0f;
				calculatedX = 0.0f;
				calculatedX2 = EngineGlobals.backbuffer_width;
			}

			if (posY > v11 || posY2 < 480.0f)
			{
				calculatedY = posY * NxXbox::EngineGlobals.screen_conv_y_multiplier + NxXbox::EngineGlobals.screen_conv_y_offset;
				calculatedY2 = NxXbox::EngineGlobals.screen_conv_y_offset + posY2 * NxXbox::EngineGlobals.screen_conv_y_multiplier;
			}
			else
			{
				calculatedY = v11;
				calculatedY2 = NxXbox::EngineGlobals.backbuffer_height;
			}
			verts[0] = calculatedX;
			verts[1] = calculatedY;
			verts[7] = calculatedX;
			verts[8] = calculatedY2;
			verts[14] = calculatedX2;
			verts[21] = calculatedX2;
			verts[15] = calculatedY;
			verts[22] = calculatedY2;
		}
		else
		{
			Mth::Vector p0( x0, y0, 0.0f, 0.0f );
			Mth::Vector p1( x1, y0, 0.0f, 0.0f );
			Mth::Vector p2( x0, y1, 0.0f, 0.0f );
			Mth::Vector p3( x1, y1, 0.0f, 0.0f );
			
			p0.RotateZ( m_rot );
			p1.RotateZ( m_rot );
			p2.RotateZ( m_rot );
			p3.RotateZ( m_rot );

			p0[X]	= SCREEN_CONV_X( p0[X] + m_xpos );
			p0[Y]	= SCREEN_CONV_Y( p0[Y] + m_ypos );
			p1[X]	= SCREEN_CONV_X( p1[X] + m_xpos );
			p1[Y]	= SCREEN_CONV_Y( p1[Y] + m_ypos );
			p2[X]	= SCREEN_CONV_X( p2[X] + m_xpos );
			p2[Y]	= SCREEN_CONV_Y( p2[Y] + m_ypos );
			p3[X]	= SCREEN_CONV_X( p3[X] + m_xpos );
			p3[Y]	= SCREEN_CONV_Y( p3[Y] + m_ypos );

			v10 = 1.0f;
			v11 = 0.0f;
		}

		verts[2] = v11;
		verts[4] = v8;
		verts[3] = v10;
		verts[18] = v8;
		verts[11] = v8;
		verts[5] = u0;
		verts[25] = v8;
		verts[6] = v0;
		verts[16] = v11;
		verts[17] = v10;
		verts[19] = u1;
		verts[20] = v0;
		verts[9] = v11;
		verts[10] = v10;
		verts[12] = u0;
		verts[13] = v1;
		verts[23] = verts[9];
		verts[24] = v10;
		verts[26] = u1;
		verts[27] = v1;

		//STDMETHOD(DrawIndexedPrimitiveUP)(THIS_ D3DPRIMITIVETYPE PrimitiveType, UINT MinVertexIndex, UINT NumVertices, 
		// UINT PrimitiveCount, CONST void* pIndexData, D3DFORMAT IndexDataFormat, CONST void* pVertexStreamZeroData,
		// UINT VertexStreamZeroStride) PURE;
		set_vertex_shader(D3DFVF_TEX1 | D3DFVF_DIFFUSE | D3DFVF_XYZRHW);
		D3DDevice_SetTextureStageState(0, D3DTSS_COLOROP, 5);
		D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAOP, 5);

		static uint16 s_index_data[] = { 0, 1, 2, 1, 3, 2, 0, 0xC2DC };
		if (!g_disableRendering)
		{
			D3DDevice_DrawIndexedPrimitiveUP(D3DPT_TRIANGLELIST, 0, 4, 2, s_index_data, D3DFMT_INDEX16, verts, 28);
		}
	}

	//if( m_rot != 0.0f )
	//{
	//	Mth::Vector p0( x0, y0, 0.0f, 0.0f );
	//	Mth::Vector p1( x1, y0, 0.0f, 0.0f );
	//	Mth::Vector p2( x0, y1, 0.0f, 0.0f );
	//	Mth::Vector p3( x1, y1, 0.0f, 0.0f );
	//
	//	p0.RotateZ( m_rot );
	//	p1.RotateZ( m_rot );
	//	p2.RotateZ( m_rot );
	//	p3.RotateZ( m_rot );
	//
	//	p0[X]	= SCREEN_CONV_X( p0[X] + m_xpos );
	//	p0[Y]	= SCREEN_CONV_Y( p0[Y] + m_ypos );
	//	p1[X]	= SCREEN_CONV_X( p1[X] + m_xpos );
	//	p1[Y]	= SCREEN_CONV_Y( p1[Y] + m_ypos );
	//	p2[X]	= SCREEN_CONV_X( p2[X] + m_xpos );
	//	p2[Y]	= SCREEN_CONV_Y( p2[Y] + m_ypos );
	//	p3[X]	= SCREEN_CONV_X( p3[X] + m_xpos );
	//	p3[Y]	= SCREEN_CONV_Y( p3[Y] + m_ypos );
	//
	//	// Now grab the push buffer space required.
	//	p_push			= D3DDevice_BeginPush( 34 );
	//	p_push[0]		= D3DPUSH_ENCODE( D3DPUSH_SET_BEGIN_END, 1 );
	//	p_push[1]		= D3DPT_QUADLIST;
	//	p_push[2]		= D3DPUSH_ENCODE( D3DPUSH_NOINCREMENT_FLAG | D3DPUSH_INLINE_ARRAY, 28 );
	//
	//	// Vertex0.
	//	p_push[3]		= *((uint32*)&p0[X] ); 
	//	p_push[4]		= *((uint32*)&p0[Y] );
	//	p_push[5]		= 0;
	//	p_push[6]		= 0;
	//	p_push[7]		= current_color;
	//	p_push[8]		= *((uint32*)&u0 );
	//	p_push[9]		= *((uint32*)&v0 );
	//
	//	// Vertex1.
	//	p_push[10]		= *((uint32*)&p2[X] ); 
	//	p_push[11]		= *((uint32*)&p2[Y] );
	//	p_push[12]		= 0;
	//	p_push[13]		= 0;
	//	p_push[14]		= current_color;
	//	p_push[15]		= *((uint32*)&u0 );
	//	p_push[16]		= *((uint32*)&v1 );
	//
	//	// Vertex2.
	//	p_push[17]		= *((uint32*)&p3[X] ); 
	//	p_push[18]		= *((uint32*)&p3[Y] );
	//	p_push[19]		= 0;
	//	p_push[20]		= 0;
	//	p_push[21]		= current_color;
	//	p_push[22]		= *((uint32*)&u1 );
	//	p_push[23]		= *((uint32*)&v1 );
	//
	//	// Vertex3.
	//	p_push[24]		= *((uint32*)&p1[X] ); 
	//	p_push[25]		= *((uint32*)&p1[Y] );
	//	p_push[26]		= 0;
	//	p_push[27]		= 0;
	//	p_push[28]		= current_color;
	//	p_push[29]		= *((uint32*)&u1 );
	//	p_push[30]		= *((uint32*)&v0 );
	//}
	//else
	//{
	//	x0 += m_xpos;
	//	y0 += m_ypos;
	//	x1 += m_xpos;
	//	y1 += m_ypos;
	//
	//	// Nasty hack - if the sprite is intended to cover the screen from top to bottom or left to right,
	//	// bypass the addtional offset added by SCREEN_CONV.
	//	if(( x0 <= 0.0f ) && ( x1 >= 640.0f ))
	//	{
	//		x0 = 0.0f;
	//		x1 = (float)NxXbox::EngineGlobals.backbuffer_width;
	//	}
	//	else
	//	{
	//		x0 = SCREEN_CONV_X( x0 );
	//		x1 = SCREEN_CONV_X( x1 );
	//	}
	//
	//	if(( y0 <= 0.0f ) && ( y1 >= 480.0f ))
	//	{
	//		y0 = 0.0f;
	//		y1 = (float)NxXbox::EngineGlobals.backbuffer_height;
	//	}
	//	else
	//	{
	//		y0 = SCREEN_CONV_Y( y0 );
	//		y1 = SCREEN_CONV_Y( y1 );
	//	}
	//
	//
	//	// Now grab the push buffer space required.
	//	p_push			= D3DDevice_BeginPush( 34 );
	//	p_push[0]		= D3DPUSH_ENCODE( D3DPUSH_SET_BEGIN_END, 1 );
	//	p_push[1]		= D3DPT_QUADLIST;
	//	p_push[2]		= D3DPUSH_ENCODE( D3DPUSH_NOINCREMENT_FLAG | D3DPUSH_INLINE_ARRAY, 28 );
	//
	//	// Vertex0.
	//	p_push[3]		= *((uint32*)&x0 ); 
	//	p_push[4]		= *((uint32*)&y0 );
	//	p_push[5]		= 0;
	//	p_push[6]		= 0;
	//	p_push[7]		= current_color;
	//	p_push[8]		= *((uint32*)&u0 );
	//	p_push[9]		= *((uint32*)&v0 );
	//
	//	// Vertex1.
	//	p_push[10]		= *((uint32*)&x0 ); 
	//	p_push[11]		= *((uint32*)&y1 );
	//	p_push[12]		= 0;
	//	p_push[13]		= 0;
	//	p_push[14]		= current_color;
	//	p_push[15]		= *((uint32*)&u0 );
	//	p_push[16]		= *((uint32*)&v1 );
	//
	//	// Vertex2.
	//	p_push[17]		= *((uint32*)&x1 ); 
	//	p_push[18]		= *((uint32*)&y1 );
	//	p_push[19]		= 0;
	//	p_push[20]		= 0;
	//	p_push[21]		= current_color;
	//	p_push[22]		= *((uint32*)&u1 );
	//	p_push[23]		= *((uint32*)&v1 );
	//
	//	// Vertex3.
	//	p_push[24]		= *((uint32*)&x1 ); 
	//	p_push[25]		= *((uint32*)&y0 );
	//	p_push[26]		= 0;
	//	p_push[27]		= 0;
	//	p_push[28]		= current_color;
	//	p_push[29]		= *((uint32*)&u1 );
	//	p_push[30]		= *((uint32*)&v0 );
	//}
	//
	//// End of vertex data for this sprite.
	//p_push[31] = D3DPUSH_ENCODE( D3DPUSH_SET_BEGIN_END, 1 );
	//p_push[32] = 0;
	//p_push += 33;
	//D3DDevice_EndPush( p_push );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sSprite::EndDraw( void )
{
	// Vertices have been submitted - nothing more to do.
	// LWSS: add more to do
	D3DDevice_SetTextureStageState(0, D3DTSS_COLOROP, 4);
	D3DDevice_SetTextureStageState(0, D3DTSS_ALPHAOP, 4);
}



} // namespace NxXbox

