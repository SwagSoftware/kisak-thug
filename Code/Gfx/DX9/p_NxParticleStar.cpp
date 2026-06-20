#include <core/defines.h>
#include "gfx/DX9/nx/render.h"

#include "gfx/DX9/p_nxparticleStar.h"
#include "NX/nx_init.h"

extern IDirect3DPixelShader9* PixelShader1;

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleStar::CXboxParticleStar()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleStar::CXboxParticleStar( uint32 checksum, int max_particles, uint32 texture_checksum, uint32 blendmode_checksum, int fix, int num_segments, float split )
{
	m_checksum		= checksum;
	m_max_particles	= max_particles;
	m_num_particles	= 0;
	m_mid_time		= -1.0f;
	m_num_segments	= num_segments;
	m_split			= split;

	mp_particle_array = new CParticleEntry[max_particles];

	// Allocate vertex buffer.
	mp_vertices = new float[max_particles * 3];

	// Create the engine representation.
	mp_engine_particle = new NxXbox::sParticleSystem( max_particles, NxXbox::PARTICLE_TYPE_STAR, texture_checksum, blendmode_checksum, fix, num_segments );

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
CXboxParticleStar::~CXboxParticleStar()
{
	delete [] mp_particle_array;
	delete [] mp_vertices;
	delete mp_engine_particle;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleStar::plat_get_position( int entry, int list, float * x, float * y, float * z )
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
void CXboxParticleStar::plat_set_position( int entry, int list, float x, float y, float z )
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
void CXboxParticleStar::plat_add_position( int entry, int list, float x, float y, float z )
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
int CXboxParticleStar::plat_get_num_particle_colors( void ) { return 3; }
int CXboxParticleStar::plat_get_num_vertex_lists( void ) { return 1; }
void CXboxParticleStar::plat_set_sr( int entry, uint8 value ) { m_start_color[entry].r = value; }
void CXboxParticleStar::plat_set_sg( int entry, uint8 value ) { m_start_color[entry].g = value; }
void CXboxParticleStar::plat_set_sb( int entry, uint8 value ) { m_start_color[entry].b = value; }
void CXboxParticleStar::plat_set_sa( int entry, uint8 value ) { m_start_color[entry].a = value; }
void CXboxParticleStar::plat_set_mr( int entry, uint8 value ) { m_mid_color[entry].r = value; }
void CXboxParticleStar::plat_set_mg( int entry, uint8 value ) { m_mid_color[entry].g = value; }
void CXboxParticleStar::plat_set_mb( int entry, uint8 value ) { m_mid_color[entry].b = value; }
void CXboxParticleStar::plat_set_ma( int entry, uint8 value ) { m_mid_color[entry].a = value; }
void CXboxParticleStar::plat_set_er( int entry, uint8 value ) { m_end_color[entry].r = value; }
void CXboxParticleStar::plat_set_eg( int entry, uint8 value ) { m_end_color[entry].g = value; }
void CXboxParticleStar::plat_set_eb( int entry, uint8 value ) { m_end_color[entry].b = value; }
void CXboxParticleStar::plat_set_ea( int entry, uint8 value ) { m_end_color[entry].a = value; }


		
// dynamic-VB helpers (copied from p_nxparticleflat.cpp)
// p_nxparticleflat.cpp port. The Star type does not use these (it draws a
// CPU-built triangle list via DrawPrimitiveUP), but they are kept here to match
// the proven template structure.
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
// end helpers


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CXboxParticleStar::plat_render( void )
{
	// Draw the particles.
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

		// Set up correct vertex and pixel shader.  Star is NON-TEXTURED: XYZ|DIFFUSE.
		NxXbox::set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE );
		NxXbox::set_pixel_shader( PixelShader1 );

		struct sStarVert { float x, y, z; DWORD color; };

		// Each segment is a quad (the Xbox QUADLIST entry) expanded into 2
		// triangles = 6 verts. m_num_segments segments per particle.
		const int verts_per_particle = m_num_segments * 6;

		// Reusable scratch for one particle's worth of triangle-list verts.
		// Allocated once, sized to the worst case for this system.
		static sStarVert*	s_p_verts		= NULL;
		static int			s_verts_capacity = 0;
		if( verts_per_particle > s_verts_capacity )
		{
			delete [] s_p_verts;
			s_p_verts		 = new sStarVert[verts_per_particle];
			s_verts_capacity = verts_per_particle;
		}

		CParticleEntry	*p_particle	= mp_particle_array;
		float			*p_v		= mp_vertices;

		for( int lp = 0; lp < m_num_particles; lp++, p_particle++, p_v += 3 )
		{
			float terp	= p_particle->m_time / p_particle->m_life;
			float w		= p_particle->m_sw + ( ( p_particle->m_ew - p_particle->m_sw ) * terp );
			float h		= p_particle->m_sh + ( ( p_particle->m_eh - p_particle->m_sh ) * terp );

			Mth::Vector	pos( p_v[0] + m_pos[X], p_v[1] + m_pos[Y], p_v[2] + m_pos[Z] );
			Mth::Vector	ss_right, ss_up;
			Mth::Vector tmp[3];

			ss_right	= screen_right * w;
			ss_up		= screen_up * h;

			Image::RGBA color[3];
			Image::RGBA *p_col0;
			Image::RGBA *p_col1;

			if( m_mid_time >= 0.0f )
			{
				if( terp < m_mid_time )
				{
					p_col0 = m_start_color;
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
				p_col0 = m_start_color;
				p_col1 = m_end_color;
			}

			for( int c = 0; c < 3; c++ )
			{
				Image::RGBA start = *p_col0++;
				Image::RGBA end = *p_col1++;

				// Swap red and blue here (D3DCOLOR/ARGB order for the DIFFUSE field).
				color[c].b = start.r + (uint8)(( ((float)( end.r - start.r )) * terp ));
				color[c].g = start.g + (uint8)(( ((float)( end.g - start.g )) * terp ));
				color[c].r = start.b + (uint8)(( ((float)( end.b - start.b )) * terp ));
				color[c].a = start.a + (uint8)(( ((float)( end.a - start.a )) * terp ));
			}

			DWORD dw_color0 = *((DWORD*)&color[0]);
			DWORD dw_color1 = *((DWORD*)&color[1]);
			DWORD dw_color2 = *((DWORD*)&color[2]);

			tmp[0]  = pos;
			tmp[0] += ss_right * sinf( Mth::DegToRad( 0.0f ) ) * m_split;
			tmp[0] += ss_up    * cosf( Mth::DegToRad( 0.0f ) ) * m_split;

			sStarVert* p_dst = s_p_verts;

			for( int lp2 = 0; lp2 < m_num_segments; lp2++ )
			{
				tmp[1]  = pos;
				tmp[1] += ss_right * sinf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments) ) * ( lp2 + 1 ) ) ) ) * m_split;
				tmp[1] += ss_up    * cosf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments) ) * ( lp2 + 1 ) ) ) ) * m_split;

				tmp[2]  = pos;
				tmp[2] += ss_right * sinf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments*2) ) * ( ( lp2 * 2 ) + 1 ) ) ) );
				tmp[2] += ss_up    * cosf( Mth::DegToRad( ( ( 360.0f / ((float)m_num_segments*2) ) * ( ( lp2 * 2 ) + 1 ) ) ) );

				// Xbox QUADLIST corner order for this segment:
				//   v0 = pos     (color[0])
				//   v1 = tmp[0]  (color[1])
				//   v2 = tmp[2]  (color[2])
				//   v3 = tmp[1]  (color[1])
				// Quad-list triangulation: (v0,v1,v2) and (v0,v2,v3).
				sStarVert v0; v0.x = pos[X];    v0.y = pos[Y];    v0.z = pos[Z];    v0.color = dw_color0;
				sStarVert v1; v1.x = tmp[0][X]; v1.y = tmp[0][Y]; v1.z = tmp[0][Z]; v1.color = dw_color1;
				sStarVert v2; v2.x = tmp[2][X]; v2.y = tmp[2][Y]; v2.z = tmp[2][Z]; v2.color = dw_color2;
				sStarVert v3; v3.x = tmp[1][X]; v3.y = tmp[1][Y]; v3.z = tmp[1][Z]; v3.color = dw_color1;

				p_dst[0] = v0; p_dst[1] = v1; p_dst[2] = v2;
				p_dst[3] = v0; p_dst[4] = v2; p_dst[5] = v3;
				p_dst += 6;

				tmp[0] = tmp[1];
			}

			// Draw this particle's star as one non-indexed triangle list.
			NxXbox::EngineGlobals.p_Device->DrawPrimitiveUP( D3DPT_TRIANGLELIST, m_num_segments * 2, s_p_verts, (UINT)sizeof( sStarVert ) );
		}
	}
}
} // Nx



