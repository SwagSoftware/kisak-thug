#include <core/defines.h>
#include "gfx/DX9/nx/render.h"

#include "gfx/DX9/p_nxparticleLine.h"

extern IDirect3DPixelShader9* PixelShader1;

namespace Nx
{

// dynamic-VB helpers (copied from p_nxparticleflat.cpp)
// Flat port template (p_nxparticleflat.cpp). Not used by this LINELIST type
// (which draws via DrawPrimitiveUP), but retained for template consistency.
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
CXboxParticleLine::CXboxParticleLine()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleLine::CXboxParticleLine( uint32 checksum, int max_particles, uint32 texture_checksum, uint32 blendmode_checksum, int fix, int num_segments, float split )
{
	m_checksum		= checksum;
	m_max_particles	= max_particles;
	m_num_particles	= 0;

	mp_particle_array = new CParticleEntry[max_particles];

	// Allocate vertex buffer.
	mp_vertices[0] = new float[max_particles * 3];
	mp_vertices[1] = new float[max_particles * 3];		// 2nd buffer to keep history.

	// Create the engine representation.
	mp_engine_particle	= new NxXbox::sParticleSystem( max_particles, NxXbox::PARTICLE_TYPE_LINE, texture_checksum, blendmode_checksum, fix );

	// Default color.
	for ( int lp = 0; lp < 2; lp++ )
	{
		m_start_color[lp].r = m_start_color[lp].g = m_start_color[lp].b = 128;
		m_start_color[lp].a = 255;
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
CXboxParticleLine::~CXboxParticleLine()
{
	delete [] mp_particle_array;
	delete [] mp_vertices[0];
	delete [] mp_vertices[1];

	delete mp_engine_particle;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleLine::plat_get_position( int entry, int list, float * x, float * y, float * z )
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
void CXboxParticleLine::plat_set_position( int entry, int list, float x, float y, float z )
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
void CXboxParticleLine::plat_add_position( int entry, int list, float x, float y, float z )
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
int CXboxParticleLine::plat_get_num_particle_colors( void ) { return 2; }
int CXboxParticleLine::plat_get_num_vertex_lists( void ) { return 2; }
void CXboxParticleLine::plat_set_sr( int entry, uint8 value ) { m_start_color[entry].r = value; }
void CXboxParticleLine::plat_set_sg( int entry, uint8 value ) { m_start_color[entry].g = value; }
void CXboxParticleLine::plat_set_sb( int entry, uint8 value ) { m_start_color[entry].b = value; }
void CXboxParticleLine::plat_set_sa( int entry, uint8 value ) { m_start_color[entry].a = value; }
void CXboxParticleLine::plat_set_mr( int entry, uint8 value ) { m_mid_color[entry].r = value; }
void CXboxParticleLine::plat_set_mg( int entry, uint8 value ) { m_mid_color[entry].g = value; }
void CXboxParticleLine::plat_set_mb( int entry, uint8 value ) { m_mid_color[entry].b = value; }
void CXboxParticleLine::plat_set_ma( int entry, uint8 value ) { m_mid_color[entry].a = value; }
void CXboxParticleLine::plat_set_er( int entry, uint8 value ) { m_end_color[entry].r = value; }
void CXboxParticleLine::plat_set_eg( int entry, uint8 value ) { m_end_color[entry].g = value; }
void CXboxParticleLine::plat_set_eb( int entry, uint8 value ) { m_end_color[entry].b = value; }
void CXboxParticleLine::plat_set_ea( int entry, uint8 value ) { m_end_color[entry].a = value; }



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// Ported to DX9 from the Xbox source (CXboxParticleLine::plat_render).
void CXboxParticleLine::plat_render( void )
{
	if( m_num_particles > 0 && !NxXbox::g_disableRendering )
	{
		// Non-textured line vertex: position + DIFFUSE color (FVF XYZ|DIFFUSE, stride 16).
		struct sLineVert { float x, y, z; DWORD color; };

		// 2 verts per particle (one line segment). Fixed CPU scratch buffer
		// (drained immediately by the DrawPrimitiveUP below, so a single
		// shared static is safe). Clamp the count to the buffer capacity.
		enum { MAX_LINE_PARTICLES = 4096 };
		static sLineVert s_verts[2 * MAX_LINE_PARTICLES];

		int num_particles = m_num_particles;
		if( num_particles > MAX_LINE_PARTICLES )
		{
			num_particles = MAX_LINE_PARTICLES;
		}

		// Submit particle material.
		mp_engine_particle->mp_material->Submit();

		// Set up correct vertex and pixel shader.
		NxXbox::set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE );
		NxXbox::set_pixel_shader( PixelShader1 );

		CParticleEntry	*p_particle	= mp_particle_array;
		float			*p_v0		= mp_vertices[0];
		float			*p_v1		= mp_vertices[1];
		sLineVert		*p_dst		= s_verts;

		for( int lp = 0; lp < num_particles; lp++, p_particle++, p_v0 += 3, p_v1 += 3 )
		{
			float terp = p_particle->m_time / p_particle->m_life;

			Mth::Vector	pos0( p_v0[0] + m_pos[X], p_v0[1] + m_pos[Y], p_v0[2] + m_pos[Z] );
			Mth::Vector	pos1( p_v1[0] + m_pos[X], p_v1[1] + m_pos[Y], p_v1[2] + m_pos[Z] );

			Image::RGBA color[2];
			Image::RGBA *p_col0[2];
			Image::RGBA *p_col1[2];

			if( m_mid_time >= 0.0f )
			{
				if( terp < m_mid_time )
				{
					p_col0[0] = &m_start_color[0];
					p_col1[0] = &m_mid_color[0];
					p_col0[1] = &m_start_color[1];
					p_col1[1] = &m_mid_color[1];

					// Adjust interpolation for this half of the color blend.
					terp = terp / m_mid_time;
				}
				else
				{
					p_col0[0] = &m_mid_color[0];
					p_col1[0] = &m_end_color[0];
					p_col0[1] = &m_mid_color[1];
					p_col1[1] = &m_end_color[1];

					// Adjust interpolation for this half of the color blend.
					terp = ( terp - m_mid_time ) / ( 1.0f - m_mid_time );
				}
			}
			else
			{
				// No mid color specified.
				p_col0[0] = &m_start_color[0];
				p_col1[0] = &m_end_color[0];
				p_col0[1] = &m_start_color[1];
				p_col1[1] = &m_end_color[1];
			}

			// Swap red and blue here (colors are stored unswapped by the
			// plat_set_* setters; the DIFFUSE DWORD wants ARGB order).
			for( int c = 0; c < 2; ++c )
			{
				Image::RGBA start	= *( p_col0[c] );
				Image::RGBA end		= *( p_col1[c] );
				color[c].b = (uint8)( start.r + (uint8)(( ((float)( (int)end.r - (int)start.r )) * terp )) );
				color[c].g = (uint8)( start.g + (uint8)(( ((float)( (int)end.g - (int)start.g )) * terp )) );
				color[c].r = (uint8)( start.b + (uint8)(( ((float)( (int)end.b - (int)start.b )) * terp )) );
				color[c].a = (uint8)( start.a + (uint8)(( ((float)( (int)end.a - (int)start.a )) * terp )) );
			}

			// Line segment: vert 0 uses list-0 position and color[0],
			// vert 1 uses list-1 position and color[1].
			p_dst[0].x = pos0[X]; p_dst[0].y = pos0[Y]; p_dst[0].z = pos0[Z]; p_dst[0].color = *((DWORD*)&color[0]);
			p_dst[1].x = pos1[X]; p_dst[1].y = pos1[Y]; p_dst[1].z = pos1[Z]; p_dst[1].color = *((DWORD*)&color[1]);
			p_dst += 2;
		}

		// Draw all line segments in one call (primitive count == particle count).
		NxXbox::EngineGlobals.p_Device->DrawPrimitiveUP( D3DPT_LINELIST, num_particles, s_verts, (int)sizeof( sLineVert ) );
	}
}
} // Nx


