#include <core/defines.h>
#include "gfx/DX9/nx/render.h"

#include "gfx/DX9/p_nxparticleGlowRibbonTrail.h"

extern IDirect3DPixelShader9* PixelShader1;

namespace NxXbox
{
	// render.h declares this at global scope, but it is actually defined inside
	// namespace NxXbox (render.cpp) - declare it here so the reference resolves.
	extern IDirect3DPixelShader9* pixel_shader_buffer_aPs11MulX2R0Rgb;
}

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CXboxParticleGlowRibbonTrail::CXboxParticleGlowRibbonTrail()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleGlowRibbonTrail::CXboxParticleGlowRibbonTrail( uint32 checksum, int max_particles, uint32 texture_checksum, uint32 blendmode_checksum, int fix, int num_segments, float split, int history )
{
	m_checksum		= checksum;
	m_max_particles	= max_particles;
	m_num_particles	= 0;
	m_mid_time		= -1.0f;
	m_num_segments	= num_segments;
	m_segment_step	= 360.0f / m_num_segments;
	m_history		= history;
	m_split			= split;

	mp_particle_array = new CParticleEntry[max_particles];

	// Allocate vertex buffer.
	mp_vertices = new float*[( history + 1)];
	for( int lp = 0; lp < ( history + 1 ); lp++ )
	{
		mp_vertices[lp] = new float[max_particles * 3];
	}
	m_num_vertex_buffers = history + 1;

	// Create the engine representation.
	mp_engine_particle = new NxXbox::sParticleSystem( max_particles, NxXbox::PARTICLE_TYPE_GLOWRIBBONTRAIL, texture_checksum, blendmode_checksum, fix, num_segments, history );

	// Default color.
	m_start_color = new Image::RGBA[m_num_vertex_buffers + 3];
	m_mid_color = new Image::RGBA[m_num_vertex_buffers + 3];
	m_end_color = new Image::RGBA[m_num_vertex_buffers + 3];
	for ( int lp = 0; lp < ( m_num_vertex_buffers + 3 ); lp++ )
	{
		m_start_color[lp].r = 128;
		m_start_color[lp].g = 128;
		m_start_color[lp].b = 128;
		m_start_color[lp].a = 128;
		m_mid_color[lp].r = 128;
		m_mid_color[lp].g = 128;
		m_mid_color[lp].b = 128;
		m_mid_color[lp].a = 128;
		m_end_color[lp].r = 128;
		m_end_color[lp].g = 128;
		m_end_color[lp].b = 128;
		m_end_color[lp].a = 128;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleGlowRibbonTrail::~CXboxParticleGlowRibbonTrail()
{
	delete [] mp_particle_array;
	for ( int lp = 0; lp < m_num_vertex_buffers; lp++ )
	{
		delete [] mp_vertices[lp];
	}
	delete [] mp_vertices;
	delete [] m_start_color;
	delete [] m_mid_color;
	delete [] m_end_color;
	delete mp_engine_particle;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleGlowRibbonTrail::plat_get_position( int entry, int list, float * x, float * y, float * z )
{
	float* p_v = &mp_vertices[list][entry*3];
	*x = p_v[0];
	*y = p_v[1];
	*z = p_v[2];
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleGlowRibbonTrail::plat_set_position( int entry, int list, float x, float y, float z )
{
	float* p_v = &mp_vertices[list][entry*3];
	p_v[0] = x;
	p_v[1] = y;
	p_v[2] = z;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleGlowRibbonTrail::plat_add_position( int entry, int list, float x, float y, float z )
{
	float* p_v = &mp_vertices[list][entry*3];
	p_v[0] += x;
	p_v[1] += y;
	p_v[2] += z;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
int CXboxParticleGlowRibbonTrail::plat_get_num_particle_colors( void ) { return m_num_vertex_buffers + 3; }
int CXboxParticleGlowRibbonTrail::plat_get_num_vertex_lists( void ) { return m_num_vertex_buffers; }
void CXboxParticleGlowRibbonTrail::plat_set_sr( int entry, uint8 value ) { m_start_color[entry].r = value; }
void CXboxParticleGlowRibbonTrail::plat_set_sg( int entry, uint8 value ) { m_start_color[entry].g = value; }
void CXboxParticleGlowRibbonTrail::plat_set_sb( int entry, uint8 value ) { m_start_color[entry].b = value; }
void CXboxParticleGlowRibbonTrail::plat_set_sa( int entry, uint8 value ) { m_start_color[entry].a = value >> 1; }
void CXboxParticleGlowRibbonTrail::plat_set_mr( int entry, uint8 value ) { m_mid_color[entry].r = value; }
void CXboxParticleGlowRibbonTrail::plat_set_mg( int entry, uint8 value ) { m_mid_color[entry].g = value; }
void CXboxParticleGlowRibbonTrail::plat_set_mb( int entry, uint8 value ) { m_mid_color[entry].b = value; }
void CXboxParticleGlowRibbonTrail::plat_set_ma( int entry, uint8 value ) { m_mid_color[entry].a = value >> 1; }
void CXboxParticleGlowRibbonTrail::plat_set_er( int entry, uint8 value ) { m_end_color[entry].r = value; }
void CXboxParticleGlowRibbonTrail::plat_set_eg( int entry, uint8 value ) { m_end_color[entry].g = value; }
void CXboxParticleGlowRibbonTrail::plat_set_eb( int entry, uint8 value ) { m_end_color[entry].b = value; }
void CXboxParticleGlowRibbonTrail::plat_set_ea( int entry, uint8 value ) { m_end_color[entry].a = value >> 1; }



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// Ported to DX9 using the retail THUG.exe
void CXboxParticleGlowRibbonTrail::plat_render( void )
{
	if( m_num_particles > 0 && !NxXbox::g_disableRendering )
	{
		// Non-textured vertex: position + DIFFUSE color (FVF XYZ|DIFFUSE, stride 16).
		struct sGRTVert { float x, y, z; DWORD color; };

		// Screen-aligned right/up vectors derived from the view matrix.
		D3DXMATRIX *p_matrix = (D3DXMATRIX*)&NxXbox::EngineGlobals.view_matrix;
		Mth::Vector up( 0.0f, 1.0f, 0.0f, 0.0f );
		Mth::Vector at( p_matrix->m[0][2], p_matrix->m[1][2], p_matrix->m[2][2] );
		Mth::Vector screen_right	= Mth::CrossProduct( at, up );
		Mth::Vector screen_up		= Mth::CrossProduct( screen_right, at );

		// Verts per particle: glow segments + trail-strip quads.
		int verts_per_particle = ( 9 * m_num_segments ) + ( 6 * ( m_num_vertex_buffers - 1 ));
		if( verts_per_particle <= 0 )
		{
			return;
		}

		enum { SCRATCH_VERTS = 64 * 1024 };
		static sGRTVert s_verts[SCRATCH_VERTS];

		int max_particles_this_pass = SCRATCH_VERTS / verts_per_particle;

		// Submit particle material and set up shaders.
		mp_engine_particle->mp_material->Submit();
		NxXbox::set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE );
		NxXbox::set_pixel_shader( NxXbox::pixel_shader_buffer_aPs11MulX2R0Rgb );

		Image::RGBA color[3];
		Image::RGBA *p_col0;
		Image::RGBA *p_col1;

		int lp = 0;
		CParticleEntry *p_particle = mp_particle_array;

		while( lp < m_num_particles )
		{
			sGRTVert *p_dst = s_verts;
			int count = 0;

			while( lp < m_num_particles && count < max_particles_this_pass )
			{
				// Interpolator: terp = m_time / m_life.
				float terp = p_particle->m_time / p_particle->m_life;

				// Trail head/next positions (lists 0 and 1).
				Mth::Vector pos[2];
				float *p_v;
				p_v = &mp_vertices[0][lp*3];
				pos[0].Set( p_v[0] + m_pos[X], p_v[1] + m_pos[Y], p_v[2] + m_pos[Z] );
				p_v = &mp_vertices[1][lp*3];
				pos[1].Set( p_v[0] + m_pos[X], p_v[1] + m_pos[Y], p_v[2] + m_pos[Z] );

				Mth::Vector part_vec = pos[1] - pos[0];
				Mth::Vector perp_vec = Mth::CrossProduct( part_vec, at );
				perp_vec.Normalize();

				float w = p_particle->m_sw + (( p_particle->m_ew - p_particle->m_sw ) * terp );
				float h = p_particle->m_sh + (( p_particle->m_eh - p_particle->m_sh ) * terp );

				Mth::Vector tmp[4];

				float trail_terp = terp;
				if( m_mid_time >= 0.0f )
				{
					if( trail_terp < m_mid_time )
					{
						p_col0		= &m_start_color[3];
						p_col1		= &m_mid_color[3];
						trail_terp	= trail_terp / m_mid_time;
					}
					else
					{
						p_col0		= &m_mid_color[3];
						p_col1		= &m_end_color[3];
						trail_terp	= ( trail_terp - m_mid_time ) / ( 1.0f - m_mid_time );
					}
				}
				else
				{
					p_col0 = &m_start_color[3];
					p_col1 = &m_end_color[3];
				}

				// Fixed-point lerp; R/B swapped for DIFFUSE/ARGB order.
				int f_terp = (int)( trail_terp * 4096.0f );

				{
					Image::RGBA start = *p_col0++;
					Image::RGBA end   = *p_col1++;
					color[0].b = (uint8)( ((((int)start.r ) * 4096 ) + (((int)end.r - (int)start.r ) * f_terp )) / 4096 );
					color[0].g = (uint8)( ((((int)start.g ) * 4096 ) + (((int)end.g - (int)start.g ) * f_terp )) / 4096 );
					color[0].r = (uint8)( ((((int)start.b ) * 4096 ) + (((int)end.b - (int)start.b ) * f_terp )) / 4096 );
					color[0].a = (uint8)( ((((int)start.a ) * 4096 ) + (((int)end.a - (int)start.a ) * f_terp )) / 4096 );
				}

				tmp[0] = pos[0] + ( perp_vec * w * m_split );
				tmp[1] = pos[0] - ( perp_vec * w * m_split );

				for( int c = 1; c < m_num_vertex_buffers; c++ )
				{
					Image::RGBA start = *p_col0++;
					Image::RGBA end   = *p_col1++;
					color[1].b = (uint8)( ((((int)start.r ) * 4096 ) + (((int)end.r - (int)start.r ) * f_terp )) / 4096 );
					color[1].g = (uint8)( ((((int)start.g ) * 4096 ) + (((int)end.g - (int)start.g ) * f_terp )) / 4096 );
					color[1].r = (uint8)( ((((int)start.b ) * 4096 ) + (((int)end.b - (int)start.b ) * f_terp )) / 4096 );
					color[1].a = (uint8)( ((((int)start.a ) * 4096 ) + (((int)end.a - (int)start.a ) * f_terp )) / 4096 );

					if( c > 1 )
					{
						p_v = &mp_vertices[c][lp*3];
						pos[1].Set( p_v[0] + m_pos[X], p_v[1] + m_pos[Y], p_v[2] + m_pos[Z] );
						part_vec = pos[1] - pos[0];
						perp_vec = Mth::CrossProduct( part_vec, at );
						perp_vec.Normalize();
					}

					tmp[2] = pos[1] + ( perp_vec * w * m_split );
					tmp[3] = pos[1] - ( perp_vec * w * m_split );

					DWORD dw0 = *((DWORD*)&color[0]);
					DWORD dw1 = *((DWORD*)&color[1]);

					// First tri: tmp[0], tmp[1], tmp[2].
					p_dst[0].x = tmp[0][X]; p_dst[0].y = tmp[0][Y]; p_dst[0].z = tmp[0][Z]; p_dst[0].color = dw0;
					p_dst[1].x = tmp[1][X]; p_dst[1].y = tmp[1][Y]; p_dst[1].z = tmp[1][Z]; p_dst[1].color = dw0;
					p_dst[2].x = tmp[2][X]; p_dst[2].y = tmp[2][Y]; p_dst[2].z = tmp[2][Z]; p_dst[2].color = dw1;
					// Second tri: tmp[1], tmp[3], tmp[2].
					p_dst[3].x = tmp[1][X]; p_dst[3].y = tmp[1][Y]; p_dst[3].z = tmp[1][Z]; p_dst[3].color = dw0;
					p_dst[4].x = tmp[3][X]; p_dst[4].y = tmp[3][Y]; p_dst[4].z = tmp[3][Z]; p_dst[4].color = dw1;
					p_dst[5].x = tmp[2][X]; p_dst[5].y = tmp[2][Y]; p_dst[5].z = tmp[2][Z]; p_dst[5].color = dw1;
					p_dst += 6;

					color[0] = color[1];
					pos[0]   = pos[1];
					tmp[0]   = tmp[2];
					tmp[1]   = tmp[3];
				}

				// Now draw the glow.
				p_v = &mp_vertices[0][lp*3];
				pos[0].Set( p_v[0] + m_pos[X], p_v[1] + m_pos[Y], p_v[2] + m_pos[Z] );

				Mth::Vector ss_right = screen_right * w;
				Mth::Vector ss_up    = screen_up * h;

				// Glow color: 3-key blend using color arrays [0..2].
				if( m_mid_time >= 0.0f )
				{
					if( trail_terp < m_mid_time )
					{
						p_col0 = m_start_color;
						p_col1 = m_mid_color;
					}
					else
					{
						p_col0 = m_mid_color;
						p_col1 = m_end_color;
					}
				}
				else
				{
					p_col0 = m_start_color;
					p_col1 = m_end_color;
				}

				for( int c = 0; c < 3; c++ )
				{
					Image::RGBA start = *p_col0++;
					Image::RGBA end   = *p_col1++;
					color[c].b = (uint8)( ((((int)start.r ) * 4096 ) + (((int)end.r - (int)start.r ) * f_terp )) / 4096 );
					color[c].g = (uint8)( ((((int)start.g ) * 4096 ) + (((int)end.g - (int)start.g ) * f_terp )) / 4096 );
					color[c].r = (uint8)( ((((int)start.b ) * 4096 ) + (((int)end.b - (int)start.b ) * f_terp )) / 4096 );
					color[c].a = (uint8)( ((((int)start.a ) * 4096 ) + (((int)end.a - (int)start.a ) * f_terp )) / 4096 );
				}

				DWORD g0 = *((DWORD*)&color[0]);
				DWORD g1 = *((DWORD*)&color[1]);
				DWORD g2 = *((DWORD*)&color[2]);

				// sin(0)=0, cos(0)=1 -> optimise the first iteration.
				tmp[0]  = pos[0];
				tmp[0] += ss_right * 0.0f * m_split;
				tmp[0] += ss_up    * 1.0f * m_split;

				tmp[2]  = pos[0];
				tmp[2] += ss_right * 0.0f;
				tmp[2] += ss_up    * 1.0f;

				for( int lp2 = 0; lp2 < m_num_segments; lp2++ )
				{
					float rt	= sinf( Mth::DegToRad( m_segment_step * ( lp2 + 1 )));
					float upc	= cosf( Mth::DegToRad( m_segment_step * ( lp2 + 1 )));

					tmp[1]  = pos[0];
					tmp[1] += ss_right * rt * m_split;
					tmp[1] += ss_up    * upc * m_split;

					tmp[3]  = pos[0];
					tmp[3] += ss_right * rt;
					tmp[3] += ss_up    * upc;

					// First tri: pos[0], tmp[0], tmp[1].
					p_dst[0].x = pos[0][X]; p_dst[0].y = pos[0][Y]; p_dst[0].z = pos[0][Z]; p_dst[0].color = g0;
					p_dst[1].x = tmp[0][X]; p_dst[1].y = tmp[0][Y]; p_dst[1].z = tmp[0][Z]; p_dst[1].color = g1;
					p_dst[2].x = tmp[1][X]; p_dst[2].y = tmp[1][Y]; p_dst[2].z = tmp[1][Z]; p_dst[2].color = g1;
					// Second tri: tmp[0], tmp[1], tmp[2].
					p_dst[3].x = tmp[0][X]; p_dst[3].y = tmp[0][Y]; p_dst[3].z = tmp[0][Z]; p_dst[3].color = g1;
					p_dst[4].x = tmp[1][X]; p_dst[4].y = tmp[1][Y]; p_dst[4].z = tmp[1][Z]; p_dst[4].color = g1;
					p_dst[5].x = tmp[2][X]; p_dst[5].y = tmp[2][Y]; p_dst[5].z = tmp[2][Z]; p_dst[5].color = g2;
					// Third tri: tmp[1], tmp[2], tmp[3].
					p_dst[6].x = tmp[1][X]; p_dst[6].y = tmp[1][Y]; p_dst[6].z = tmp[1][Z]; p_dst[6].color = g1;
					p_dst[7].x = tmp[2][X]; p_dst[7].y = tmp[2][Y]; p_dst[7].z = tmp[2][Z]; p_dst[7].color = g2;
					p_dst[8].x = tmp[3][X]; p_dst[8].y = tmp[3][Y]; p_dst[8].z = tmp[3][Z]; p_dst[8].color = g2;
					p_dst += 9;

					tmp[0] = tmp[1];
					tmp[2] = tmp[3];
				}

				count++;
				lp++;
				p_particle++;
			}

			if( count == 0 )
			{
				// Particle too big for the scratch buffer; bail.
				break;
			}

			int num_verts = count * verts_per_particle;
			NxXbox::EngineGlobals.p_Device->DrawPrimitiveUP( D3DPT_TRIANGLELIST, num_verts / 3, s_verts, (int)sizeof( sGRTVert ) );
		}
	}
}
} // Nx


