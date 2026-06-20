#include <core/defines.h>
#include <gfx/DX9/nx/render.h>

#include "gfx/DX9/p_nxparticleSmoothStar.h"
#include "NX/nx_init.h"

#include <math.h>

extern IDirect3DPixelShader9* PixelShader1;

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleSmoothStar::CXboxParticleSmoothStar()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleSmoothStar::CXboxParticleSmoothStar( uint32 checksum, int max_particles, uint32 texture_checksum, uint32 blendmode_checksum, int fix, int num_segments, float split )
{
	m_checksum			= checksum;
	m_max_particles		= max_particles;
	m_num_particles		= 0;
	m_num_segments		= num_segments;
	m_split				= split;

	mp_particle_array	= new CParticleEntry[max_particles];

	// Allocate vertex buffer.
	mp_vertices = new float[max_particles * 3];

	// Create the engine representation.
	mp_engine_particle = new NxXbox::sParticleSystem( max_particles, NxXbox::PARTICLE_TYPE_SMOOTHSTAR, texture_checksum, blendmode_checksum, fix, num_segments );

	// Default color.
	for ( int lp = 0; lp < 3; lp++ )
	{
		m_SmoothStart_color[lp].r = m_SmoothStart_color[lp].g = m_SmoothStart_color[lp].b = 128;
		m_SmoothStart_color[lp].a = 255;
		m_mid_color[lp].r = m_mid_color[lp].g = m_mid_color[lp].b = 128;
		m_mid_color[lp].a = 255;
		m_end_color[lp].r = m_end_color[lp].g = m_end_color[lp].b = 128;
		m_end_color[lp].a = 255;
	}

	m_mid_time = -1.0f;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleSmoothStar::~CXboxParticleSmoothStar()
{
	delete [] mp_particle_array;
	delete [] mp_vertices;
	delete mp_engine_particle;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleSmoothStar::plat_get_position( int entry, int list, float * x, float * y, float * z )
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
void CXboxParticleSmoothStar::plat_set_position( int entry, int list, float x, float y, float z )
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
void CXboxParticleSmoothStar::plat_add_position( int entry, int list, float x, float y, float z )
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
	
int CXboxParticleSmoothStar::plat_get_num_particle_colors( void ) { return 3; }
int CXboxParticleSmoothStar::plat_get_num_vertex_lists( void ) { return 1; }
void CXboxParticleSmoothStar::plat_set_sr( int entry, uint8 value ) { m_SmoothStart_color[entry].r = value; }
void CXboxParticleSmoothStar::plat_set_sg( int entry, uint8 value ) { m_SmoothStart_color[entry].g = value; }
void CXboxParticleSmoothStar::plat_set_sb( int entry, uint8 value ) { m_SmoothStart_color[entry].b = value; }
void CXboxParticleSmoothStar::plat_set_sa( int entry, uint8 value ) { m_SmoothStart_color[entry].a = value; }
void CXboxParticleSmoothStar::plat_set_mr( int entry, uint8 value ) { m_mid_color[entry].r = value; }
void CXboxParticleSmoothStar::plat_set_mg( int entry, uint8 value ) { m_mid_color[entry].g = value; }
void CXboxParticleSmoothStar::plat_set_mb( int entry, uint8 value ) { m_mid_color[entry].b = value; }
void CXboxParticleSmoothStar::plat_set_ma( int entry, uint8 value ) { m_mid_color[entry].a = value; }
void CXboxParticleSmoothStar::plat_set_er( int entry, uint8 value ) { m_end_color[entry].r = value; }
void CXboxParticleSmoothStar::plat_set_eg( int entry, uint8 value ) { m_end_color[entry].g = value; }
void CXboxParticleSmoothStar::plat_set_eb( int entry, uint8 value ) { m_end_color[entry].b = value; }
void CXboxParticleSmoothStar::plat_set_ea( int entry, uint8 value ) { m_end_color[entry].a = value; }


		
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// Ported to DX9 from the Xbox CXboxParticleSmoothStar::plat_render.
void CXboxParticleSmoothStar::plat_render( void )
{
	if( m_num_particles > 0 && !NxXbox::g_disableRendering )
	{
		// Used to figure the right and up vectors for creating screen-aligned particle quads.
		D3DXMATRIX *p_matrix = (D3DXMATRIX*)&NxXbox::EngineGlobals.view_matrix;

		// Concatenate p_matrix with the emmission angle to create the direction.
		Mth::Vector up( 0.0f, 1.0f, 0.0f, 0.0f );

		// Get the 'right' vector as the cross product of camera 'at' and world 'up'.
		Mth::Vector at( p_matrix->m[0][2], p_matrix->m[1][2], p_matrix->m[2][2] );
		Mth::Vector screen_right	= Mth::CrossProduct( at, up );
		Mth::Vector screen_up		= Mth::CrossProduct( screen_right, at );

		screen_right.Normalize();
		screen_up.Normalize();

		// Submit particle material.
		mp_engine_particle->mp_material->Submit();

		// Set up correct vertex and pixel shader (XYZ + diffuse, no texture coords).
		NxXbox::set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE );
		NxXbox::set_pixel_shader( PixelShader1 );

		struct sStarVert { float x, y, z; DWORD color; };

		// Each segment is two Xbox quads => 4 triangles => 12 triangle-list verts.
		// Build into a fixed CPU buffer and flush in batches to bound stack/UP size.
		const int kVertsPerSegment	= 12;
		const int kMaxBatchVerts	= 4080;	// multiple of 12, comfortably small.
		static sStarVert s_verts[kMaxBatchVerts];

		int batch_verts = 0;

		CParticleEntry	*p_particle	= mp_particle_array;
		float			*p_v		= mp_vertices;

		for( int lp = 0; lp < m_num_particles; lp++, p_particle++, p_v += 3 )
		{
			float terp	= p_particle->m_time / p_particle->m_life;
			float w		= p_particle->m_sw + ( ( p_particle->m_ew - p_particle->m_sw ) * terp );
			float h		= p_particle->m_sh + ( ( p_particle->m_eh - p_particle->m_sh ) * terp );

			Mth::Vector	pos( p_v[0] + m_pos[X], p_v[1] + m_pos[Y], p_v[2] + m_pos[Z] );
			Mth::Vector	ss_right, ss_up;
			Mth::Vector tmp[4];

			Image::RGBA color[3];
			Image::RGBA *p_col0;
			Image::RGBA *p_col1;

			if( m_mid_time >= 0.0f )
			{
				if( terp < m_mid_time )
				{
					p_col0 = m_SmoothStart_color;
					p_col1 = m_mid_color;

					// Adjust interpolation for this half of the color blend.
					terp = terp / m_mid_time;
				}
				else
				{
					p_col0 = m_mid_color;
					p_col1 = m_end_color;

					// Adjust interpolation for this half of the color blend.
					terp = ( terp - m_mid_time ) / ( 1.0f - m_mid_time );
				}
			}
			else
			{
				// No mid color specified.
				p_col0 = m_SmoothStart_color;
				p_col1 = m_end_color;
			}

			// Swap red and blue here during interpolation (so the DWORD reads back
			// as D3DCOLOR / ARGB when written straight into the diffuse field).
			for( int c = 0; c < 3; c++ )
			{
				Image::RGBA SmoothStart = *p_col0++;
				Image::RGBA end = *p_col1++;

				color[c].b = (uint8)( SmoothStart.r + (uint8)(( ((float)( end.r - SmoothStart.r )) * terp )) );
				color[c].g = (uint8)( SmoothStart.g + (uint8)(( ((float)( end.g - SmoothStart.g )) * terp )) );
				color[c].r = (uint8)( SmoothStart.b + (uint8)(( ((float)( end.b - SmoothStart.b )) * terp )) );
				color[c].a = (uint8)( SmoothStart.a + (uint8)(( ((float)( end.a - SmoothStart.a )) * terp )) );
			}

			DWORD dw_color0 = *((DWORD*)&color[0]);
			DWORD dw_color1 = *((DWORD*)&color[1]);
			DWORD dw_color2 = *((DWORD*)&color[2]);

			ss_right	= screen_right * w;
			ss_up		= screen_up * h;

			tmp[1]  = pos;
			tmp[1] += ss_right * sinf( Mth::DegToRad( 0.0f ) ) * m_split;
			tmp[1] += ss_up    * cosf( Mth::DegToRad( 0.0f ) ) * m_split;

			for( int lp2 = 0; lp2 < m_num_segments; lp2++ )
			{
				// Flush the batch if the next segment would not fit.
				if( batch_verts + kVertsPerSegment > kMaxBatchVerts )
				{
					NxXbox::EngineGlobals.p_Device->DrawPrimitiveUP( D3DPT_TRIANGLELIST, batch_verts / 3, s_verts, sizeof( sStarVert ) );
					batch_verts = 0;
				}

				tmp[0]  = pos;
				tmp[0] += ss_right * sinf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments*2) ) * ( ( lp2 * 2 ) + 1 ) ) ) ) * m_split;
				tmp[0] += ss_up    * cosf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments*2) ) * ( ( lp2 * 2 ) + 1 ) ) ) ) * m_split;

				tmp[3]  = pos;
				tmp[3] += ss_right * sinf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments*2) ) * ( ( lp2 * 2 ) + 2 ) ) ) ) * m_split;
				tmp[3] += ss_up    * cosf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments*2) ) * ( ( lp2 * 2 ) + 2 ) ) ) ) * m_split;

				tmp[2]  = pos;
				tmp[2] += ss_right * sinf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments*2) ) * ( ( lp2 * 2 ) + 1 ) ) ) );
				tmp[2] += ss_up    * cosf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments*2) ) * ( ( lp2 * 2 ) + 1 ) ) ) );

				sStarVert* p_dst = &s_verts[batch_verts];

				// First Xbox quad corners (QUADLIST order):
				//   q0 = tmp[0] (color1), q1 = pos (color0), q2 = tmp[3] (color2), q3 = tmp[2] (color2)
				// Triangles (q0,q1,q2) and (q0,q2,q3).
				p_dst[0].x = tmp[0][X]; p_dst[0].y = tmp[0][Y]; p_dst[0].z = tmp[0][Z]; p_dst[0].color = dw_color1;
				p_dst[1].x = pos[X];    p_dst[1].y = pos[Y];    p_dst[1].z = pos[Z];    p_dst[1].color = dw_color0;
				p_dst[2].x = tmp[3][X]; p_dst[2].y = tmp[3][Y]; p_dst[2].z = tmp[3][Z]; p_dst[2].color = dw_color2;

				p_dst[3].x = tmp[0][X]; p_dst[3].y = tmp[0][Y]; p_dst[3].z = tmp[0][Z]; p_dst[3].color = dw_color1;
				p_dst[4].x = tmp[3][X]; p_dst[4].y = tmp[3][Y]; p_dst[4].z = tmp[3][Z]; p_dst[4].color = dw_color2;
				p_dst[5].x = tmp[2][X]; p_dst[5].y = tmp[2][Y]; p_dst[5].z = tmp[2][Z]; p_dst[5].color = dw_color2;

				// Second Xbox quad corners (QUADLIST order):
				//   q0 = tmp[0] (color1), q1 = pos (color0), q2 = tmp[1] (color2), q3 = tmp[2] (color2)
				// Triangles (q0,q1,q2) and (q0,q2,q3).
				p_dst[6].x = tmp[0][X]; p_dst[6].y = tmp[0][Y]; p_dst[6].z = tmp[0][Z]; p_dst[6].color = dw_color1;
				p_dst[7].x = pos[X];    p_dst[7].y = pos[Y];    p_dst[7].z = pos[Z];    p_dst[7].color = dw_color0;
				p_dst[8].x = tmp[1][X]; p_dst[8].y = tmp[1][Y]; p_dst[8].z = tmp[1][Z]; p_dst[8].color = dw_color2;

				p_dst[9].x  = tmp[0][X]; p_dst[9].y  = tmp[0][Y]; p_dst[9].z  = tmp[0][Z]; p_dst[9].color  = dw_color1;
				p_dst[10].x = tmp[1][X]; p_dst[10].y = tmp[1][Y]; p_dst[10].z = tmp[1][Z]; p_dst[10].color = dw_color2;
				p_dst[11].x = tmp[2][X]; p_dst[11].y = tmp[2][Y]; p_dst[11].z = tmp[2][Z]; p_dst[11].color = dw_color2;

				batch_verts += kVertsPerSegment;

				tmp[1] = tmp[3];
			}
		}

		if( batch_verts > 0 )
		{
			NxXbox::EngineGlobals.p_Device->DrawPrimitiveUP( D3DPT_TRIANGLELIST, batch_verts / 3, s_verts, sizeof( sStarVert ) );
		}
	}
}
} // Nx



