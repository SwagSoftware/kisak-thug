#include <core/defines.h>
#include "gfx/DX9/nx/render.h"
#include <gfx/NxTexMan.h>
#include <gfx/DX9/p_nxtexture.h>
#include "gfx/DX9/nx/mesh.h"
#include "gfx/DX9/p_nxparticleSmooth.h"
#include "NX/nx_init.h"

extern IDirect3DPixelShader9* PixelShader0;

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleSmooth::CXboxParticleSmooth()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleSmooth::CXboxParticleSmooth( uint32 checksum, int max_particles, uint32 texture_checksum, uint32 blendmode_checksum, int fix, int num_segments, float split )
{
	m_checksum		= checksum;
	m_max_particles = max_particles;
	m_num_particles = 0;
	m_mid_time		= -1.0f;

	mp_particle_array = new CParticleEntry[max_particles];

	// Allocate vertex buffer.
	mp_vertices = new float[max_particles * 3];

	// Create the engine representation.
	mp_engine_particle = new NxXbox::sParticleSystem( max_particles, NxXbox::PARTICLE_TYPE_SMOOTH, texture_checksum, blendmode_checksum, fix );

	// Default color.
	for ( int lp = 0; lp < 2; lp++ )
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
CXboxParticleSmooth::~CXboxParticleSmooth()
{
	delete [] mp_particle_array;
	delete [] mp_vertices;
	delete mp_engine_particle;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleSmooth::plat_get_position( int entry, int list, float * x, float * y, float * z )
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
void CXboxParticleSmooth::plat_set_position( int entry, int list, float x, float y, float z )
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
void CXboxParticleSmooth::plat_add_position( int entry, int list, float x, float y, float z )
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
int CXboxParticleSmooth::plat_get_num_particle_colors( void ) { return 2; }
int CXboxParticleSmooth::plat_get_num_vertex_lists( void ) { return 1; }
void CXboxParticleSmooth::plat_set_sr( int entry, uint8 value ) { m_start_color[entry].r = value; }
void CXboxParticleSmooth::plat_set_sg( int entry, uint8 value ) { m_start_color[entry].g = value; }
void CXboxParticleSmooth::plat_set_sb( int entry, uint8 value ) { m_start_color[entry].b = value; }
void CXboxParticleSmooth::plat_set_sa( int entry, uint8 value ) { m_start_color[entry].a = value; }
void CXboxParticleSmooth::plat_set_mr( int entry, uint8 value ) { m_mid_color[entry].r = value; }
void CXboxParticleSmooth::plat_set_mg( int entry, uint8 value ) { m_mid_color[entry].g = value; }
void CXboxParticleSmooth::plat_set_mb( int entry, uint8 value ) { m_mid_color[entry].b = value; }
void CXboxParticleSmooth::plat_set_ma( int entry, uint8 value ) { m_mid_color[entry].a = value; }
void CXboxParticleSmooth::plat_set_er( int entry, uint8 value ) { m_end_color[entry].r = value; }
void CXboxParticleSmooth::plat_set_eg( int entry, uint8 value ) { m_end_color[entry].g = value; }
void CXboxParticleSmooth::plat_set_eb( int entry, uint8 value ) { m_end_color[entry].b = value; }
void CXboxParticleSmooth::plat_set_ea( int entry, uint8 value ) { m_end_color[entry].a = value; }


		
// dynamic-VB helpers (copied from p_nxparticleflat.cpp)
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
// Ported to DX9 from the Xbox CXboxParticleSmooth::plat_render.
void CXboxParticleSmooth::plat_render( void )
{
	if( m_num_particles > 0 && !NxXbox::g_disableRendering )
	{
		// Screen-aligned right/up vectors derived from the view matrix.
		D3DXMATRIX *p_matrix = (D3DXMATRIX*)&NxXbox::EngineGlobals.view_matrix;
		Mth::Vector up( 0.0f, 1.0f, 0.0f, 0.0f );
		Mth::Vector at( p_matrix->m[0][2], p_matrix->m[1][2], p_matrix->m[2][2] );
		Mth::Vector screen_right	= Mth::CrossProduct( at, up );
		Mth::Vector screen_up		= Mth::CrossProduct( screen_right, at );
		screen_right.Normalize();
		screen_up.Normalize();

		mp_engine_particle->mp_material->Submit();
		NxXbox::set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_TEX1 );
		NxXbox::set_pixel_shader( PixelShader0 );

		struct sSmoothVert { float x, y, z; DWORD color; float u, v; };

		// 12 verts per particle (4 triangles). Build a batch into a local buffer
		// then draw it with DrawPrimitiveUP. Batch so the stack array stays small.
		const int		kVertsPerParticle	= 12;
		const int		kMaxBatch			= 256;	// particles per DrawPrimitiveUP
		static sSmoothVert	verts[kMaxBatch * kVertsPerParticle];

		CParticleEntry	*p_particle	= mp_particle_array;
		float			*p_v		= mp_vertices;
		int				done		= 0;

		while( done < m_num_particles )
		{
			int batch = m_num_particles - done;
			if( batch > kMaxBatch )
			{
				batch = kMaxBatch;
			}

			sSmoothVert* p_dst = verts;

			for( int i = 0; i < batch; i++, done++, p_particle++, p_v += 3 )
			{
				float terp	= p_particle->m_time / p_particle->m_life;
				float w		= p_particle->m_sw + (( p_particle->m_ew - p_particle->m_sw ) * terp );
				float h		= p_particle->m_sh + (( p_particle->m_eh - p_particle->m_sh ) * terp );

				Mth::Vector	pos( p_v[0] + m_pos[X], p_v[1] + m_pos[Y], p_v[2] + m_pos[Z] );
				Mth::Vector	ss_right	= screen_right * w;
				Mth::Vector	ss_up		= screen_up * h;

				// Four rim corners (Xbox order: TL, TR, BR, BL).
				Mth::Vector tmp[4];
				tmp[0] = pos - ss_right + ss_up;
				tmp[1] = pos + ss_right + ss_up;
				tmp[2] = pos + ss_right - ss_up;
				tmp[3] = pos - ss_right - ss_up;

				// 3-key color interpolation (start -> mid -> end), two corner colors.
				Image::RGBA color[2];
				Image::RGBA *p_col0;
				Image::RGBA *p_col1;

				if( m_mid_time >= 0.0f )
				{
					if( terp < m_mid_time )
					{
						p_col0	= m_start_color;
						p_col1	= m_mid_color;
						terp	= terp / m_mid_time;
					}
					else
					{
						p_col0	= m_mid_color;
						p_col1	= m_end_color;
						terp	= ( terp - m_mid_time ) / ( 1.0f - m_mid_time );
					}
				}
				else
				{
					p_col0	= m_start_color;
					p_col1	= m_end_color;
				}

				for( int c = 0; c < 2; c++ )
				{
					Image::RGBA start	= *p_col0++;
					Image::RGBA end		= *p_col1++;

					color[c].r = (uint8)( start.r + (uint8)(( (float)( end.r - start.r ) ) * terp ));
					color[c].g = (uint8)( start.g + (uint8)(( (float)( end.g - start.g ) ) * terp ));
					color[c].b = (uint8)( start.b + (uint8)(( (float)( end.b - start.b ) ) * terp ));
					color[c].a = (uint8)( start.a + (uint8)(( (float)( end.a - start.a ) ) * terp ));
				}

				// Smooth setters store native RGBA; swap R/B for DIFFUSE (ARGB).
				DWORD dw_centre	= ((DWORD)color[0].a << 24) | ((DWORD)color[0].r << 16) | ((DWORD)color[0].g << 8) | (DWORD)color[0].b;
				DWORD dw_rim	= ((DWORD)color[1].a << 24) | ((DWORD)color[1].r << 16) | ((DWORD)color[1].g << 8) | (DWORD)color[1].b;

				// 4 triangles: centre (UV 0,0) + two consecutive rim corners.
				const float rim_u[4] = { 0.0f, 1.0f, 1.0f, 0.0f };
				const float rim_v[4] = { 0.0f, 0.0f, 1.0f, 1.0f };
				const int   tri_a[4] = { 0, 1, 2, 3 };
				const int   tri_b[4] = { 1, 2, 3, 0 };

				for( int t = 0; t < 4; t++ )
				{
					// Centre vertex.
					p_dst[0].x = pos[X]; p_dst[0].y = pos[Y]; p_dst[0].z = pos[Z];
					p_dst[0].color = dw_centre; p_dst[0].u = 0.0f; p_dst[0].v = 0.0f;

					// First rim corner.
					int a = tri_a[t];
					p_dst[1].x = tmp[a][X]; p_dst[1].y = tmp[a][Y]; p_dst[1].z = tmp[a][Z];
					p_dst[1].color = dw_rim; p_dst[1].u = rim_u[a]; p_dst[1].v = rim_v[a];

					// Second rim corner.
					int b = tri_b[t];
					p_dst[2].x = tmp[b][X]; p_dst[2].y = tmp[b][Y]; p_dst[2].z = tmp[b][Z];
					p_dst[2].color = dw_rim; p_dst[2].u = rim_u[b]; p_dst[2].v = rim_v[b];

					p_dst += 3;
				}
			}

			NxXbox::EngineGlobals.p_Device->DrawPrimitiveUP( D3DPT_TRIANGLELIST, batch * 4, verts, (UINT)sizeof( sSmoothVert ) );
		}
	}
}
} // Nx



