#include <core/defines.h>
#include <gfx/DX9/nx/render.h>
#include "gfx/DX9/p_NxParticleShaded.h"

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
CXboxParticleShaded::CXboxParticleShaded()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleShaded::CXboxParticleShaded( uint32 checksum, int max_particles, uint32 texture_checksum, uint32 blendmode_checksum, int fix )
{
	m_checksum		= checksum;
	m_max_particles = max_particles;
	m_num_particles = 0;
	m_mid_time		= -1.0f;

	mp_particle_array = new CParticleEntry[max_particles];

	// Allocate vertex buffer.
	mp_vertices		= new float[max_particles * 3];

	// Create the engine representation.
	mp_engine_particle = new NxXbox::sParticleSystem( max_particles, NxXbox::PARTICLE_TYPE_SHADED, texture_checksum, blendmode_checksum, fix );

	// Default color.
	for( int c = 0; c < 4; ++c )
	{
		m_start_color[c].r = 128;
		m_start_color[c].g = 128;
		m_start_color[c].b = 128;
		m_start_color[c].a = 255;

		m_mid_color[c].r = 128;
		m_mid_color[c].g = 128;
		m_mid_color[c].b = 128;
		m_mid_color[c].a = 255;

		m_end_color[c].r = 128;
		m_end_color[c].g = 128;
		m_end_color[c].b = 128;
		m_end_color[c].a = 255;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxParticleShaded::~CXboxParticleShaded()
{
	delete [] mp_particle_array;
	delete [] mp_vertices;
	delete mp_engine_particle;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleShaded::plat_get_position( int entry, int list, float * x, float * y, float * z )
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
void CXboxParticleShaded::plat_set_position( int entry, int list, float x, float y, float z )
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
void CXboxParticleShaded::plat_add_position( int entry, int list, float x, float y, float z )
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
int CXboxParticleShaded::plat_get_num_particle_colors( void )
{
	return 4;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxParticleShaded::plat_set_sr( int entry, uint8 value ) { m_start_color[entry].r = value; }
void CXboxParticleShaded::plat_set_sg( int entry, uint8 value ) { m_start_color[entry].g = value; }
void CXboxParticleShaded::plat_set_sb( int entry, uint8 value ) { m_start_color[entry].b = value; }
void CXboxParticleShaded::plat_set_sa( int entry, uint8 value ) { m_start_color[entry].a = value; }
void CXboxParticleShaded::plat_set_mr( int entry, uint8 value ) { m_mid_color[entry].r = value; }
void CXboxParticleShaded::plat_set_mg( int entry, uint8 value ) { m_mid_color[entry].g = value; }
void CXboxParticleShaded::plat_set_mb( int entry, uint8 value ) { m_mid_color[entry].b = value; }
void CXboxParticleShaded::plat_set_ma( int entry, uint8 value ) { m_mid_color[entry].a = value; }
void CXboxParticleShaded::plat_set_er( int entry, uint8 value ) { m_end_color[entry].r = value; }
void CXboxParticleShaded::plat_set_eg( int entry, uint8 value ) { m_end_color[entry].g = value; }
void CXboxParticleShaded::plat_set_eb( int entry, uint8 value ) { m_end_color[entry].b = value; }
void CXboxParticleShaded::plat_set_ea( int entry, uint8 value ) { m_end_color[entry].a = value; }



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
// Ported to DX9 from the Xbox CXboxParticleShaded::plat_render.
void CXboxParticleShaded::plat_render( void )
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

		struct sShadedVert { float x, y, z; DWORD color; float u, v; };

		CParticleEntry	*p_particle	= mp_particle_array;
		float			*p_v		= mp_vertices;
		int				done		= 0;

		while( done < m_num_particles )
		{
			IDirect3DVertexBuffer9*	p_vb		= NULL;
			int						base_vertex	= 0;
			unsigned int			avail_verts	= 0;
			sShadedVert*			p_dst		= (sShadedVert*)LockVertexBuffer( 4 * ( m_num_particles - done ), (int)sizeof( sShadedVert ), &p_vb, &base_vertex, &avail_verts );

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

				// 3-key per-corner color interpolation (start -> mid -> end).
				Image::RGBA	color[4];
				Image::RGBA	*p_col0;
				Image::RGBA	*p_col1;
				float		col_terp;
				if( m_mid_time >= 0.0f )
				{
					if( terp < m_mid_time )
					{
						p_col0		= m_start_color;
						p_col1		= m_mid_color;
						col_terp	= terp / m_mid_time;
					}
					else
					{
						p_col0		= m_mid_color;
						p_col1		= m_end_color;
						col_terp	= ( terp - m_mid_time ) / ( 1.0f - m_mid_time );
					}
				}
				else
				{
					p_col0		= m_start_color;
					p_col1		= m_end_color;
					col_terp	= terp;
				}

				// Per-corner color; swap R/B for DIFFUSE (ARGB).
				for( int c = 0; c < 4; c++ )
				{
					Image::RGBA start = p_col0[c];
					Image::RGBA end   = p_col1[c];
					color[c].b = (uint8)( start.r + (uint8)(( ((float)( (int)end.r - (int)start.r )) * col_terp )) );
					color[c].g = (uint8)( start.g + (uint8)(( ((float)( (int)end.g - (int)start.g )) * col_terp )) );
					color[c].r = (uint8)( start.b + (uint8)(( ((float)( (int)end.b - (int)start.b )) * col_terp )) );
					color[c].a = (uint8)( start.a + (uint8)(( ((float)( (int)end.a - (int)start.a )) * col_terp )) );
				}

				// Four corners ordered to match the shared quad index buffer
				// pattern (0,1,2, 2,1,3): TL,TR,BL,BR. Xbox QUADLIST order was
				// TL,TR,BR,BL = color[0],color[1],color[2],color[3]; remap so BL
				// uses color[3] and BR uses color[2].
				DWORD dw_tl = *((DWORD*)&color[0]);	// TL
				DWORD dw_tr = *((DWORD*)&color[1]);	// TR
				DWORD dw_br = *((DWORD*)&color[2]);	// BR
				DWORD dw_bl = *((DWORD*)&color[3]);	// BL

				Mth::Vector c;
				c = pos - ss_right + ss_up;	p_dst[0].x = c[X]; p_dst[0].y = c[Y]; p_dst[0].z = c[Z]; p_dst[0].color = dw_tl; p_dst[0].u = 0.0f; p_dst[0].v = 0.0f;	// TL
				c = pos + ss_right + ss_up;	p_dst[1].x = c[X]; p_dst[1].y = c[Y]; p_dst[1].z = c[Z]; p_dst[1].color = dw_tr; p_dst[1].u = 1.0f; p_dst[1].v = 0.0f;	// TR
				c = pos - ss_right - ss_up;	p_dst[2].x = c[X]; p_dst[2].y = c[Y]; p_dst[2].z = c[Z]; p_dst[2].color = dw_bl; p_dst[2].u = 0.0f; p_dst[2].v = 1.0f;	// BL
				c = pos + ss_right - ss_up;	p_dst[3].x = c[X]; p_dst[3].y = c[Y]; p_dst[3].z = c[Z]; p_dst[3].color = dw_br; p_dst[3].u = 1.0f; p_dst[3].v = 1.0f;	// BR
				p_dst += 4;

				count++;
				done++;
				p_particle++;
				p_v += 3;
			}

			UnlockVertexBuffer( 4 * count, (int)sizeof( sShadedVert ) );

			if( count == 0 )
			{
				// Nothing fit this iteration; bail to avoid an infinite loop.
				break;
			}

			NxXbox::EngineGlobals.p_Device->SetStreamSource( 0, p_vb, 0, sizeof( sShadedVert ) );
			NxXbox::EngineGlobals.p_Device->SetIndices( NxXbox::EngineGlobals.p_index_buffer );
			NxXbox::EngineGlobals.p_Device->DrawIndexedPrimitive( D3DPT_TRIANGLELIST, base_vertex, 0, 4 * count, 0, 2 * count );
		}
	}
}

} // Nx

				


