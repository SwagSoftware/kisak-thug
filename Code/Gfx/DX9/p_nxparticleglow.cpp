#include <core/defines.h>
#include "gfx/DX9/nx/render.h"

#include "gfx/DX9/p_nxparticleGlow.h"
#include "NX/nx_init.h"

#include <math.h>

extern IDirect3DPixelShader9* PixelShader1;

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleGlow::CXboxParticleGlow()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleGlow::CXboxParticleGlow( uint32 checksum, int max_particles, uint32 texture_checksum, uint32 blendmode_checksum, int fix, int num_segments, float split )
{
	m_checksum		= checksum;
	m_max_particles = max_particles;
	m_num_particles = 0;
	m_num_segments	= num_segments;
	m_split			= split;
	m_mid_time		= -1.0f;

	mp_particle_array = new CParticleEntry[max_particles];

	// Allocate vertex buffer.
	mp_vertices = new float[max_particles * 3];

	// Create the engine representation.
	mp_engine_particle = new NxXbox::sParticleSystem( max_particles, NxXbox::PARTICLE_TYPE_GLOW, texture_checksum, blendmode_checksum, fix, num_segments );

	// Default color.
	for ( int lp = 0; lp < 3; lp++ )
	{
		m_start_color[lp].r = 128;
		m_start_color[lp].g = 128;
		m_start_color[lp].b = 128;
		m_start_color[lp].a = 255;
		m_mid_color[lp].r = 128;
		m_mid_color[lp].g = 128;
		m_mid_color[lp].b = 128;
		m_mid_color[lp].a = 255;
		m_end_color[lp].r = 128;
		m_end_color[lp].g = 128;
		m_end_color[lp].b = 128;
		m_end_color[lp].a = 255;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleGlow::~CXboxParticleGlow()
{
	delete [] mp_particle_array;
	delete [] mp_vertices;
	delete mp_engine_particle;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleGlow::plat_get_position( int entry, int list, float * x, float * y, float * z )
{
	float* p_v = &mp_vertices[entry*3];
	*x = p_v[0];
	*y = p_v[1];
	*z = p_v[2];
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleGlow::plat_set_position( int entry, int list, float x, float y, float z )
{
	float* p_v = &mp_vertices[entry*3];
	p_v[0] = x;
	p_v[1] = y;
	p_v[2] = z;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleGlow::plat_add_position( int entry, int list, float x, float y, float z )
{
	float* p_v = &mp_vertices[entry*3];
	p_v[0] += x;
	p_v[1] += y;
	p_v[2] += z;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
int CXboxParticleGlow::plat_get_num_particle_colors( void ) { return 3; }
int CXboxParticleGlow::plat_get_num_vertex_lists( void ) { return 1; }
void CXboxParticleGlow::plat_set_sr( int entry, uint8 value ) { m_start_color[entry].r = value; }
void CXboxParticleGlow::plat_set_sg( int entry, uint8 value ) { m_start_color[entry].g = value; }
void CXboxParticleGlow::plat_set_sb( int entry, uint8 value ) { m_start_color[entry].b = value; }
void CXboxParticleGlow::plat_set_sa( int entry, uint8 value ) { m_start_color[entry].a = value; }
void CXboxParticleGlow::plat_set_mr( int entry, uint8 value ) { m_mid_color[entry].r = value; }
void CXboxParticleGlow::plat_set_mg( int entry, uint8 value ) { m_mid_color[entry].g = value; }
void CXboxParticleGlow::plat_set_mb( int entry, uint8 value ) { m_mid_color[entry].b = value; }
void CXboxParticleGlow::plat_set_ma( int entry, uint8 value ) { m_mid_color[entry].a = value; }
void CXboxParticleGlow::plat_set_er( int entry, uint8 value ) { m_end_color[entry].r = value; }
void CXboxParticleGlow::plat_set_eg( int entry, uint8 value ) { m_end_color[entry].g = value; }
void CXboxParticleGlow::plat_set_eb( int entry, uint8 value ) { m_end_color[entry].b = value; }
void CXboxParticleGlow::plat_set_ea( int entry, uint8 value ) { m_end_color[entry].a = value; }


static int LockVertexBuffer(int size, int n, IDirect3DVertexBuffer9** outVertexBuffer, int* outResult, unsigned int* outResult2)
{
	unsigned int v5; // eax
	int v6; // edx
	unsigned int v7; // esi

	v5 = (NxXbox::EngineGlobals.dword_7CEC7C + n - 1) / n;
	*outVertexBuffer = NxXbox::EngineGlobals.p_vertex_buffer;
	v6 = NxXbox::EngineGlobals.vertex_buffer_length;
	v7 = n * v5;
	if (n * v5 + n * size > NxXbox::EngineGlobals.vertex_buffer_length)
	{
		NxXbox::EngineGlobals.p_vertex_buffer->Lock(0, 0, (void**)&NxXbox::EngineGlobals.dword_7CEC78, D3DLOCK_DISCARD);
		NxXbox::EngineGlobals.dword_7CEC7C = 0;
		if (outResult2)
			*outResult2 = NxXbox::EngineGlobals.vertex_buffer_length / n;
		*outResult = 0;
		return NxXbox::EngineGlobals.dword_7CEC78;
	}
	else
	{
		*outResult = v5;
		NxXbox::EngineGlobals.dword_7CEC7C = n * v5;
		if (outResult2)
			*outResult2 = (v6 - v7) / n;
		NxXbox::EngineGlobals.p_vertex_buffer->Lock(0, 0, (void**)&NxXbox::EngineGlobals.dword_7CEC78, D3DLOCK_NOOVERWRITE);
		return NxXbox::EngineGlobals.dword_7CEC78 + v7;
	}
}

static int UnlockVertexBuffer(int size, int n)
{
	int result; // eax

	NxXbox::EngineGlobals.p_vertex_buffer->Unlock();
	result = n * size;
	NxXbox::EngineGlobals.dword_7CEC78 = 0;
	NxXbox::EngineGlobals.dword_7CEC7C = (n * size + NxXbox::EngineGlobals.dword_7CEC7C + 31) & 0xFFFFFFE0;
	return result;
}



void CXboxParticleGlow::plat_render( void )
{
	if( m_num_particles > 0 && !NxXbox::g_disableRendering )
	{
		// Used to figure the right and up vectors for creating screen-aligned particle quads.
		D3DXMATRIX *p_matrix = (D3DXMATRIX*)&NxXbox::EngineGlobals.view_matrix;

		// Concatenate p_matrix with the emmission angle to create the direction.
		Mth::Vector up( 0.0f, 1.0f, 0.0f, 0.0f );

		// Get the 'right' vector as the cross product of camera 'at and world 'up'.
		Mth::Vector at( p_matrix->m[0][2], p_matrix->m[1][2], p_matrix->m[2][2] );
		Mth::Vector screen_right	= Mth::CrossProduct( at, up );
		Mth::Vector screen_up		= Mth::CrossProduct( screen_right, at );

		screen_right.Normalize();
		screen_up.Normalize();

		// Submit particle material.
		mp_engine_particle->mp_material->Submit();

		// Set up correct vertex and pixel shader.
		NxXbox::set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE );
		NxXbox::set_pixel_shader( PixelShader1 );

		struct sGlowVert { float x, y, z; DWORD color; };

		// One segment = 3 triangles = 9 vertices. A particle has m_num_segments segments.
		// Build into a heap buffer sized for one full particle and draw per particle.
		int verts_per_particle	= m_num_segments * 9;
		sGlowVert* p_verts		= new sGlowVert[verts_per_particle];

		CParticleEntry	*p_particle	= mp_particle_array;
		float			*p_v		= mp_vertices;

		for( int lp = 0; lp < m_num_particles; lp++, p_particle++, p_v += 3 )
		{
			float terp	= p_particle->m_time / p_particle->m_life;
			float w		= p_particle->m_sw + ( ( p_particle->m_ew - p_particle->m_sw ) * terp );
			float h		= p_particle->m_sh + ( ( p_particle->m_eh - p_particle->m_sh ) * terp );

			Mth::Vector	pos( p_v[0] + m_pos[X], p_v[1] + m_pos[Y], p_v[2] + m_pos[Z] );
			Mth::Vector	ss_right, ss_up;
			Mth::Vector tmp0, tmp1, tmp2, tmp3;

			ss_right	= screen_right * w;
			ss_up		= screen_up * h;

			Image::RGBA color[3];
			Image::RGBA *p_col0;
			Image::RGBA *p_col1;

			// Local copy of terp so the per-particle base value is not clobbered.
			float col_terp = terp;

			if ( m_mid_time >= 0.0f )
			{
				if ( terp < m_mid_time )
				{
					p_col0 = m_start_color;
					p_col1 = m_mid_color;

					// Adjust interpolation for this half of the color blend.
					col_terp = terp / m_mid_time;
				}
				else
				{
					p_col0 = m_mid_color;
					p_col1 = m_end_color;

					// Adjust interpolation for this half of the color blend.
					col_terp = ( terp - m_mid_time ) / ( 1.0f - m_mid_time );
				}
			}
			else
			{
				// No mid color specified.
				p_col0 = m_start_color;
				p_col1 = m_end_color;
			}

			// Swap red and blue here (write straight to D3DCOLOR/ARGB ordered Image::RGBA).
			for( int c = 0; c < 3; c++ )
			{
				Image::RGBA start	= *p_col0++;
				Image::RGBA end		= *p_col1++;

				color[c].b = (uint8)( start.r + (uint8)(( ((float)( (int)end.r - (int)start.r )) * col_terp )) );
				color[c].g = (uint8)( start.g + (uint8)(( ((float)( (int)end.g - (int)start.g )) * col_terp )) );
				color[c].r = (uint8)( start.b + (uint8)(( ((float)( (int)end.b - (int)start.b )) * col_terp )) );
				color[c].a = (uint8)( start.a + (uint8)(( ((float)( (int)end.a - (int)start.a )) * col_terp )) );
			}

			DWORD dw_color0 = *((DWORD*)&color[0] );
			DWORD dw_color1 = *((DWORD*)&color[1] );
			DWORD dw_color2 = *((DWORD*)&color[2] );

			tmp0  = pos;
			tmp0 += ss_right * sinf( 0.0f ) * m_split;
			tmp0 += ss_up    * cosf( 0.0f ) * m_split;

			tmp2  = pos;
			tmp2 += ss_right * sinf( 0.0f );
			tmp2 += ss_up    * cosf( 0.0f );

			float radians_per_segment	= ( 2.0f * Mth::PI ) / (float)m_num_segments;

			sGlowVert* p_dst = p_verts;

			for( int lp2 = 0; lp2 < m_num_segments; lp2++ )
			{
				tmp1  = pos;
				tmp1 += ss_right * sinf( radians_per_segment * ( lp2 + 1 )) * m_split;
				tmp1 += ss_up    * cosf( radians_per_segment * ( lp2 + 1 )) * m_split;

				tmp3  = pos;
				tmp3 += ss_right * sinf( radians_per_segment * ( lp2 + 1 ));
				tmp3 += ss_up    * cosf( radians_per_segment * ( lp2 + 1 ));

				// Triangle zero.
				p_dst[0].x = pos[X];  p_dst[0].y = pos[Y];  p_dst[0].z = pos[Z];  p_dst[0].color = dw_color0;
				p_dst[1].x = tmp0[X]; p_dst[1].y = tmp0[Y]; p_dst[1].z = tmp0[Z]; p_dst[1].color = dw_color1;
				p_dst[2].x = tmp1[X]; p_dst[2].y = tmp1[Y]; p_dst[2].z = tmp1[Z]; p_dst[2].color = dw_color1;

				// Triangle one.
				p_dst[3].x = tmp0[X]; p_dst[3].y = tmp0[Y]; p_dst[3].z = tmp0[Z]; p_dst[3].color = dw_color1;
				p_dst[4].x = tmp1[X]; p_dst[4].y = tmp1[Y]; p_dst[4].z = tmp1[Z]; p_dst[4].color = dw_color1;
				p_dst[5].x = tmp2[X]; p_dst[5].y = tmp2[Y]; p_dst[5].z = tmp2[Z]; p_dst[5].color = dw_color2;

				// Triangle two.
				p_dst[6].x = tmp1[X]; p_dst[6].y = tmp1[Y]; p_dst[6].z = tmp1[Z]; p_dst[6].color = dw_color1;
				p_dst[7].x = tmp2[X]; p_dst[7].y = tmp2[Y]; p_dst[7].z = tmp2[Z]; p_dst[7].color = dw_color2;
				p_dst[8].x = tmp3[X]; p_dst[8].y = tmp3[Y]; p_dst[8].z = tmp3[Z]; p_dst[8].color = dw_color2;

				p_dst += 9;

				tmp0 = tmp1;
				tmp2 = tmp3;
			}

			// 3 triangles per segment.
			NxXbox::EngineGlobals.p_Device->DrawPrimitiveUP( D3DPT_TRIANGLELIST, m_num_segments * 3, p_verts, (UINT)sizeof( sGlowVert ) );
		}

		delete [] p_verts;
	}
}
} // Nx



