#include <core/defines.h>
#include <gfx/DX9/nx/render.h>
#include "gfx/DX9/p_nxparticleflat.h"
#include "NX/nx_init.h"

extern IDirect3DPixelShader9* PixelShader0;

namespace NxXbox
{
	// render.h declares this at global scope, but it is actually defined inside
	// namespace NxXbox (render.cpp) - declare it here so the reference resolves.
	extern IDirect3DPixelShader9* pixel_shader_buffer_aPs11TexT0MulR0;
}

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleFlat::CXboxParticleFlat()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleFlat::CXboxParticleFlat( uint32 checksum, int max_particles, uint32 texture_checksum, uint32 blendmode_checksum, int fix, int num_segments, float split )
{
	m_checksum		= checksum;
	m_max_particles = max_particles;
	m_num_particles = 0;
	
	mp_particle_array = new CParticleEntry[max_particles];

	// Allocate vertex buffer.
	mp_vertices = new float[max_particles * 3];

	// Create the engine representation.
	mp_engine_particle = new NxXbox::sParticleSystem( max_particles, NxXbox::PARTICLE_TYPE_FLAT, texture_checksum, blendmode_checksum, fix );

	// Default color.
	m_start_color.r = m_start_color.g = m_start_color.b = 128;
	m_start_color.a = 255;
	m_mid_color.r = m_mid_color.g = m_mid_color.b = 128;
	m_mid_color.a = 255;
	m_end_color.r = m_end_color.g = m_end_color.b = 128;
	m_end_color.a = 255;

	m_mid_time = -1.0f;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleFlat::~CXboxParticleFlat()
{
	delete [] mp_particle_array;
	delete [] mp_vertices;
	delete mp_engine_particle;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleFlat::plat_get_position( int entry, int list, float * x, float * y, float * z )
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
void CXboxParticleFlat::plat_set_position( int entry, int list, float x, float y, float z )
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
void CXboxParticleFlat::plat_add_position( int entry, int list, float x, float y, float z )
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
int CXboxParticleFlat::plat_get_num_particle_colors( void ) { return 1; }
int CXboxParticleFlat::plat_get_num_vertex_lists( void ) { return 1; }

// Note these are r/b reversed for direct uploading to Xbox GPU.
void CXboxParticleFlat::plat_set_sr( int entry, uint8 value ) { m_start_color.b = value; }
void CXboxParticleFlat::plat_set_sg( int entry, uint8 value ) { m_start_color.g = value; }
void CXboxParticleFlat::plat_set_sb( int entry, uint8 value ) { m_start_color.r = value; }
void CXboxParticleFlat::plat_set_sa( int entry, uint8 value ) { m_start_color.a = value; }
void CXboxParticleFlat::plat_set_mr( int entry, uint8 value ) { m_mid_color.b = value; }
void CXboxParticleFlat::plat_set_mg( int entry, uint8 value ) { m_mid_color.g = value; }
void CXboxParticleFlat::plat_set_mb( int entry, uint8 value ) { m_mid_color.r = value; }
void CXboxParticleFlat::plat_set_ma( int entry, uint8 value ) { m_mid_color.a = value; }
void CXboxParticleFlat::plat_set_er( int entry, uint8 value ) { m_end_color.b = value; }
void CXboxParticleFlat::plat_set_eg( int entry, uint8 value ) { m_end_color.g = value; }
void CXboxParticleFlat::plat_set_eb( int entry, uint8 value ) { m_end_color.r = value; }
void CXboxParticleFlat::plat_set_ea( int entry, uint8 value ) { m_end_color.a = value; }


		
// LWSS Add
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
// LWSS End


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// Ported to DX9 from retail Windows_THUG.exe (CXboxParticleFlat::plat_render @ 0x4A1470).
void CXboxParticleFlat::plat_render( void )
{
	if( m_num_particles > 0 && !NxXbox::g_disableRendering )
	{
		// Screen-aligned right/up vectors derived from the view matrix.
		D3DXMATRIX *p_matrix = (D3DXMATRIX*)&NxXbox::EngineGlobals.view_matrix;
		Mth::Vector up( 0.0f, 1.0f, 0.0f );
		Mth::Vector at( p_matrix->m[0][2], p_matrix->m[1][2], p_matrix->m[2][2] );
		Mth::Vector screen_right	= Mth::CrossProduct( at, up );
		Mth::Vector screen_up		= Mth::CrossProduct( screen_right, at );
		screen_right.Normalize();
		screen_up.Normalize();

		mp_engine_particle->mp_material->Submit();
		NxXbox::set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_TEX1 );
		NxXbox::set_pixel_shader( NxXbox::pixel_shader_buffer_aPs11TexT0MulR0 );

		struct sFlatVert { float x, y, z; DWORD color; float u, v; };

		CParticleEntry	*p_particle	= mp_particle_array;
		float			*p_v		= mp_vertices;
		int				done		= 0;

		while( done < m_num_particles )
		{
			IDirect3DVertexBuffer9*	p_vb		= NULL;
			int						base_vertex	= 0;
			unsigned int			avail_verts	= 0;
			sFlatVert*				p_dst		= (sFlatVert*)LockVertexBuffer( 4 * ( m_num_particles - done ), (int)sizeof( sFlatVert ), &p_vb, &base_vertex, &avail_verts );

			int count = 0;
			while( done < m_num_particles )
			{
				// Stop if another quad (4 verts) will not fit in the locked range.
				if( ( count + 1 ) * 4 > (int)avail_verts )
				{
					break;
				}

				float terp	= p_particle->m_time / p_particle->m_life;
				float w		= p_particle->m_sw + (( p_particle->m_ew - p_particle->m_sw ) * terp );
				float h		= p_particle->m_sh + (( p_particle->m_eh - p_particle->m_sh ) * terp );

				Mth::Vector	pos( p_v[0] + m_pos[X], p_v[1] + m_pos[Y], p_v[2] + m_pos[Z] );
				Mth::Vector	ss_right	= screen_right * w;
				Mth::Vector	ss_up		= screen_up * h;

				// 3-key color interpolation (start -> mid -> end).
				Image::RGBA	*p_col0;
				Image::RGBA	*p_col1;
				float		col_terp;
				if( m_mid_time >= 0.0f )
				{
					if( terp < m_mid_time )
					{
						p_col0		= &m_start_color;
						p_col1		= &m_mid_color;
						col_terp	= ( m_mid_time > 0.0f ) ? ( terp / m_mid_time ) : 0.0f;
					}
					else
					{
						p_col0		= &m_mid_color;
						p_col1		= &m_end_color;
						col_terp	= ( terp - m_mid_time ) / ( 1.0f - m_mid_time );
					}
				}
				else
				{
					p_col0		= &m_start_color;
					p_col1		= &m_end_color;
					col_terp	= terp;
				}

				// Fixed-point lerp per channel (channels already stored in
				// D3DCOLOR/ARGB order by the plat_set_* setters).
				int f_terp = (int)( col_terp * 4096.0f );
				Image::RGBA color;
				color.r = (uint8)( ((((int)p_col0->r ) * 4096 ) + (((int)p_col1->r - (int)p_col0->r ) * f_terp )) / 4096 );
				color.g = (uint8)( ((((int)p_col0->g ) * 4096 ) + (((int)p_col1->g - (int)p_col0->g ) * f_terp )) / 4096 );
				color.b = (uint8)( ((((int)p_col0->b ) * 4096 ) + (((int)p_col1->b - (int)p_col0->b ) * f_terp )) / 4096 );
				color.a = (uint8)( ((((int)p_col0->a ) * 4096 ) + (((int)p_col1->a - (int)p_col0->a ) * f_terp )) / 4096 );
				DWORD dw_color = *((DWORD*)&color);

				// Four corners ordered to match the shared quad index buffer
				// pattern (0,1,2, 2,1,3): 0=TL 1=TR 2=BL 3=BR.
				Mth::Vector c;
				c = pos - ss_right + ss_up;	p_dst[0].x = c[X]; p_dst[0].y = c[Y]; p_dst[0].z = c[Z]; p_dst[0].color = dw_color; p_dst[0].u = 0.0f; p_dst[0].v = 0.0f;
				c = pos + ss_right + ss_up;	p_dst[1].x = c[X]; p_dst[1].y = c[Y]; p_dst[1].z = c[Z]; p_dst[1].color = dw_color; p_dst[1].u = 1.0f; p_dst[1].v = 0.0f;
				c = pos - ss_right - ss_up;	p_dst[2].x = c[X]; p_dst[2].y = c[Y]; p_dst[2].z = c[Z]; p_dst[2].color = dw_color; p_dst[2].u = 0.0f; p_dst[2].v = 1.0f;
				c = pos + ss_right - ss_up;	p_dst[3].x = c[X]; p_dst[3].y = c[Y]; p_dst[3].z = c[Z]; p_dst[3].color = dw_color; p_dst[3].u = 1.0f; p_dst[3].v = 1.0f;
				p_dst += 4;

				count++;
				done++;
				p_particle++;
				p_v += 3;
			}

			UnlockVertexBuffer( 4 * count, (int)sizeof( sFlatVert ) );

			if( count == 0 )
			{
				// Nothing fit this iteration; bail to avoid an infinite loop.
				break;
			}

			NxXbox::EngineGlobals.p_Device->SetStreamSource( 0, p_vb, 0, sizeof( sFlatVert ) );
			NxXbox::EngineGlobals.p_Device->SetIndices( NxXbox::EngineGlobals.p_index_buffer );
			NxXbox::EngineGlobals.p_Device->DrawIndexedPrimitive( D3DPT_TRIANGLELIST, base_vertex, 0, 4 * count, 0, 2 * count );
		}
	}

	// Parametric emit-rate handling.
	if( m_emit_rate > 0.0f )
	{
		m_emit_rate_fractional += ( m_emit_rate * ( 1.0f / 60.0f ));
		if( m_emit_rate_fractional >= 1.0f )
		{
			emit( (int)m_emit_rate_fractional );
			m_emit_rate_fractional -= (float)(int)m_emit_rate_fractional;
		}
	}
}
} // Nx