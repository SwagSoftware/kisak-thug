/*****************************************************************************
**																			**
**			              Neversoft Entertainment.			                **
**																		   	**
**				   Copyright (C) 2000 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Skate5													**
**																			**
**	Module:			Gfx			 											**
**																			**
**	File name:		p_NxNewParticle.cpp										**
**																			**
**	Created by:		3/25/03	-	SPG											**
**																			**
**	Description:	Xbox new parametric particle system						**
*****************************************************************************/

#include <core/defines.h>

#include <gfx/DX9/p_nxnewparticle.h>

#include <gfx/NxTexMan.h>
#include <gfx/DX9/p_nxtexture.h>
#include <gfx/DX9/nx/nx_init.h>
#include <gfx/DX9/nx/render.h>

namespace NxXbox
{
	// Defined inside namespace NxXbox in render.cpp; render.h declares it global.
	extern IDirect3DPixelShader9* pixel_shader_buffer_aPs11TexT0MulR0;
}


/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

namespace Nx
{


/*****************************************************************************
**								  Externals									**
*****************************************************************************/

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

/*****************************************************************************
**								Private Types								**
*****************************************************************************/

/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

static int rand_seed;
static int rand_a	= 314159265;
static int rand_b	= 178453311;


/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							  Private Functions								**
*****************************************************************************/



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static void seed_particle_rnd( int s, int a, int b )
{
	rand_seed		= s;
	rand_a			= a;
	rand_b			= b;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static inline int particle_rnd( int n )
{
	rand_seed	= rand_seed * rand_a + rand_b;
	rand_a		= ( rand_a ^ rand_seed ) + ( rand_seed >> 4 );
	rand_b		+= ( rand_seed >> 3 ) - 0x10101010L;
	return (int)(( rand_seed & 0xffff ) * n ) >> 16;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CParticleStream::AdvanceSeed( int num_places )
{
	// Seed the random number generator back to the current seed.
	seed_particle_rnd( m_rand_seed, m_rand_a, m_rand_b );

	// Each particle will call the random function four times.
	for( int i = 0; i < ( num_places * 4 ); i++ )
	{
		rand_seed	= rand_seed * rand_a + rand_b;
		rand_a		= ( rand_a ^ rand_seed ) + ( rand_seed >> 4 );
		rand_b		+= ( rand_seed >> 3 ) - 0x10101010L;
	}

	m_rand_seed = rand_seed;
	m_rand_a	= rand_a;
	m_rand_b	= rand_b;
}
	
	
	
inline DWORD FtoDW( FLOAT f ) { return *((DWORD*)&f); }

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static int LockVertexBuffer(int size, int n, IDirect3DVertexBuffer9** outVertexBuffer, int* outResult, unsigned int* outResult2)
{
	unsigned int v5;
	int v6;
	unsigned int v7;

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
	int result;
	NxXbox::EngineGlobals.p_vertex_buffer->Unlock();
	result = n * size;
	NxXbox::EngineGlobals.dword_7CEC78 = 0;
	NxXbox::EngineGlobals.dword_7CEC7C = (n * size + NxXbox::EngineGlobals.dword_7CEC7C + 31) & 0xFFFFFFE0;
	return result;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// blops: Ported to DX9 from retail THUG.exe

void CXboxNewParticle::plat_render( void )
{
	CParticleStream*	p_stream;
	int					i;

	// Process the streams.
	if( m_params.m_EmitRate && ( !m_emitting || ( m_params.m_EmitRate != mp_newest_stream->m_rate )))
	{
		if( m_num_streams < m_max_streams )
		{
			m_num_streams++;
			mp_newest_stream++;
			if( mp_newest_stream == mp_stream + m_max_streams )
				mp_newest_stream = mp_stream;

			mp_newest_stream->m_rate			= m_params.m_EmitRate;
			mp_newest_stream->m_interval		= 1.0f / m_params.m_EmitRate;
			mp_newest_stream->m_oldest_age		= 0.0f;
			mp_newest_stream->m_num_particles	= 0;
			mp_newest_stream->m_rand_seed		= rand();
			mp_newest_stream->m_rand_a			= 314159265;
			mp_newest_stream->m_rand_b			= 178453311;
			m_emitting = true;
		}
		else
		{
			m_emitting = false;
		}
	}
	else
	{
		m_emitting = m_params.m_EmitRate;
	}

	if( !m_num_streams )
		return;

	// Age all streams.
	for( i = 0, p_stream = mp_oldest_stream; i < m_num_streams; ++i )
	{
		p_stream->m_oldest_age += 1.0f / 60.0f;
		p_stream++;
		if( p_stream == mp_stream + m_max_streams )
			p_stream = mp_stream;
	}

	// Births into newest stream.
	if( m_emitting )
		mp_newest_stream->m_num_particles = (int)( mp_newest_stream->m_oldest_age * mp_newest_stream->m_rate + 1.0f );

	// Deaths from oldest stream.
	if( mp_oldest_stream->m_oldest_age > m_params.m_Lifetime )
	{
		int particles_dead = (int)(( mp_oldest_stream->m_oldest_age - m_params.m_Lifetime ) * mp_oldest_stream->m_rate + 1.0f );
		mp_oldest_stream->m_num_particles -= particles_dead;
		if( mp_oldest_stream->m_num_particles > 0 || ( m_num_streams == 1 && m_emitting ))
		{
			mp_oldest_stream->m_oldest_age -= (float)particles_dead * mp_oldest_stream->m_interval;
			mp_oldest_stream->AdvanceSeed( particles_dead );
		}
		else
		{
			m_num_streams--;
			mp_oldest_stream++;
			if( mp_oldest_stream == mp_stream + m_max_streams )
				mp_oldest_stream = mp_stream;
			if( !m_num_streams )
				return;
		}
	}

	// Cull against the frustum for non-dynamic systems.
	if( !m_params.m_LocalCoord )
	{
		D3DXVECTOR3 center( m_bsphere[X], m_bsphere[Y], m_bsphere[Z] );
		if( !NxXbox::frustum_check_sphere( &center, m_bsphere[W] ))
			return;
	}

	// Swap the r and b color components in the params (so they pack as D3DCOLOR ARGB).
	for( i = 0; i < vNUM_BOXES; ++i )
	{
		uint8 swap = m_params.m_Color[i].r;
		m_params.m_Color[i].r	= m_params.m_Color[i].b;
		m_params.m_Color[i].b	= swap;
	}

	// Screen-aligned right/up vectors.
	D3DXMATRIX *p_matrix = (D3DXMATRIX*)&NxXbox::EngineGlobals.view_matrix;
	Mth::Vector up( 0.0f, 1.0f, 0.0f );
	Mth::Vector at( p_matrix->m[0][2], p_matrix->m[1][2], p_matrix->m[2][2] );
	Mth::Vector screen_right	= Mth::CrossProduct( at, up );
	Mth::Vector screen_up		= Mth::CrossProduct( screen_right, at );
	screen_right.Normalize();
	screen_up.Normalize();

	mp_material->Submit();
	NxXbox::set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_TEX1 );
	NxXbox::set_pixel_shader( NxXbox::pixel_shader_buffer_aPs11TexT0MulR0 );

	float midpoint_time = m_params.m_Lifetime * ( m_params.m_ColorMidpointPct * 0.01f );

	struct sNewVert { float x, y, z; DWORD color; float u, v; };

	// Render each stream's particles as CPU-generated screen-aligned quads.
	for( i = 0, p_stream = mp_oldest_stream; i < m_num_streams; i++, p_stream++ )
	{
		if( p_stream == mp_stream + m_max_streams )
			p_stream = mp_stream;

		int num = p_stream->m_num_particles;
		if( num <= 0 )
			continue;

		// Seed the random number generator for this stream.
		seed_particle_rnd( p_stream->m_rand_seed, p_stream->m_rand_a, p_stream->m_rand_b );

		int done = 0;
		while( done < num )
		{
			IDirect3DVertexBuffer9*	p_vb		= NULL;
			int						base_vertex	= 0;
			unsigned int			avail_verts	= 0;
			sNewVert*				p_dst		= (sNewVert*)LockVertexBuffer( 4 * ( num - done ), (int)sizeof( sNewVert ), &p_vb, &base_vertex, &avail_verts );

			int count = 0;
			while( done < num )
			{
				if( ( count + 1 ) * 4 > (int)avail_verts )
					break;

				// Age of this particle (oldest first), then 4 random spread values in [1,2).
				float t  = p_stream->m_oldest_age - (float)done * p_stream->m_interval;
				float t2 = t * t;
				float r0 = 1.0f + ( (float)particle_rnd( 16384 ) / 16384.0f );
				float r1 = 1.0f + ( (float)particle_rnd( 16384 ) / 16384.0f );
				float r2 = 1.0f + ( (float)particle_rnd( 16384 ) / 16384.0f );
				float r3 = 1.0f + ( (float)particle_rnd( 16384 ) / 16384.0f );

				// pos = (p0 + t*p1 + t2*p2) + (s0 + t*s1 + t2*s2) componentwise-scaled by r.
				float px   = ( m_p0[X] + t * m_p1[X] + t2 * m_p2[X] ) + ( m_s0[X] + t * m_s1[X] + t2 * m_s2[X] ) * r0;
				float py   = ( m_p0[Y] + t * m_p1[Y] + t2 * m_p2[Y] ) + ( m_s0[Y] + t * m_s1[Y] + t2 * m_s2[Y] ) * r1;
				float pz   = ( m_p0[Z] + t * m_p1[Z] + t2 * m_p2[Z] ) + ( m_s0[Z] + t * m_s1[Z] + t2 * m_s2[Z] ) * r2;
				float size = ( m_p0[W] + t * m_p1[W] + t2 * m_p2[W] ) + ( m_s0[W] + t * m_s1[W] + t2 * m_s2[W] ) * r3;

				// 3-key color interpolation.
				float		col_terp;
				Image::RGBA	col0, col1;
				if( m_params.m_UseMidcolor )
				{
					if( t > midpoint_time )
					{
						col_terp = ( m_params.m_Lifetime > midpoint_time ) ? (( t - midpoint_time ) / ( m_params.m_Lifetime - midpoint_time )) : 0.0f;
						col0 = m_params.m_Color[1];
						col1 = m_params.m_Color[2];
					}
					else
					{
						col_terp = ( midpoint_time > 0.0f ) ? ( t / midpoint_time ) : 0.0f;
						col0 = m_params.m_Color[0];
						col1 = m_params.m_Color[1];
					}
				}
				else
				{
					col_terp = ( m_params.m_Lifetime > 0.0f ) ? ( t / m_params.m_Lifetime ) : 0.0f;
					col0 = m_params.m_Color[0];
					col1 = m_params.m_Color[2];
				}
				if( col_terp < 0.0f ) col_terp = 0.0f;
				if( col_terp > 1.0f ) col_terp = 1.0f;

				int f_terp = (int)( col_terp * 4096.0f );
				Image::RGBA color;
				color.r = (uint8)( ((((int)col0.r ) * 4096 ) + (((int)col1.r - (int)col0.r ) * f_terp )) / 4096 );
				color.g = (uint8)( ((((int)col0.g ) * 4096 ) + (((int)col1.g - (int)col0.g ) * f_terp )) / 4096 );
				color.b = (uint8)( ((((int)col0.b ) * 4096 ) + (((int)col1.b - (int)col0.b ) * f_terp )) / 4096 );
				color.a = (uint8)( ((((int)col0.a ) * 4096 ) + (((int)col1.a - (int)col0.a ) * f_terp )) / 4096 );
				DWORD dw_color = *((DWORD*)&color);

				// Four corners (TL,TR,BL,BR) to match the shared quad index buffer.
				Mth::Vector pos( px, py, pz );
				Mth::Vector ss_right	= screen_right * size;
				Mth::Vector ss_up		= screen_up * size;
				Mth::Vector c;
				c = pos - ss_right + ss_up;	p_dst[0].x = c[X]; p_dst[0].y = c[Y]; p_dst[0].z = c[Z]; p_dst[0].color = dw_color; p_dst[0].u = 0.0f; p_dst[0].v = 0.0f;
				c = pos + ss_right + ss_up;	p_dst[1].x = c[X]; p_dst[1].y = c[Y]; p_dst[1].z = c[Z]; p_dst[1].color = dw_color; p_dst[1].u = 1.0f; p_dst[1].v = 0.0f;
				c = pos - ss_right - ss_up;	p_dst[2].x = c[X]; p_dst[2].y = c[Y]; p_dst[2].z = c[Z]; p_dst[2].color = dw_color; p_dst[2].u = 0.0f; p_dst[2].v = 1.0f;
				c = pos + ss_right - ss_up;	p_dst[3].x = c[X]; p_dst[3].y = c[Y]; p_dst[3].z = c[Z]; p_dst[3].color = dw_color; p_dst[3].u = 1.0f; p_dst[3].v = 1.0f;
				p_dst += 4;

				count++;
				done++;
			}

			UnlockVertexBuffer( 4 * count, (int)sizeof( sNewVert ) );

			if( count == 0 )
				break;

			NxXbox::EngineGlobals.p_Device->SetStreamSource( 0, p_vb, 0, sizeof( sNewVert ) );
			NxXbox::EngineGlobals.p_Device->SetIndices( NxXbox::EngineGlobals.p_index_buffer );
			NxXbox::EngineGlobals.p_Device->DrawIndexedPrimitive( D3DPT_TRIANGLELIST, base_vertex, 0, 4 * count, 0, 2 * count );
		}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxNewParticle::update_position( void )
{
	// Convert 3-point -> PVA format
	float t1 = m_params.m_Lifetime * m_params.m_MidpointPct * 0.01f;
	float t2 = m_params.m_Lifetime;
	Mth::Vector u, a_;

	Mth::Vector x0	= m_params.m_BoxPos[0];
	x0[3]			= m_params.m_Radius[0];
	Mth::Vector x1	= m_params.m_BoxPos[1];
	x1[3]			= m_params.m_Radius[1];
	Mth::Vector x2	= m_params.m_BoxPos[2];
	x2[3]			= m_params.m_Radius[2];

	if( m_params.m_UseMidpoint )
	{
		u  = ( t2 * t2 * ( x1 - x0 ) - t1 * t1 * ( x2 - x0 )) / ( t1 * t2 * ( t2 - t1 ));
		a_ = ( t1 * ( x2 - x0 ) - t2 * ( x1 - x0 )) / ( t1 * t2 * ( t2 - t1 ));
	}
	else
	{
		u  = ( x2 - x0 ) / t2;
		a_.Set( 0, 0, 0, 0 );
	}

	m_p0 = x0 - 1.5f * m_s0;
	m_p1 = u  - 1.5f * m_s1;
	m_p2 = a_ - 1.5f * m_s2;
	m_p0[3] = x0[3] - 1.5f * m_s0[3];
	m_p1[3] = u[3]  - 1.5f * m_s1[3];
	m_p2[3] = a_[3] - 1.5f * m_s2[3];
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxNewParticle::plat_update( void )
{
	if( m_params.m_LocalCoord )
	{
		update_position();
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxNewParticle::plat_build( void )
{
	// Reduce emit rate selectively to improve performance.
	m_params.m_EmitRate	= m_params.m_EmitRate * 0.5f;

	// Initialise streams.
	m_max_streams		= 5;
	m_num_streams		= 0;

	mp_stream			= new CParticleStream[m_max_streams]; 
	mp_newest_stream	= mp_stream + m_max_streams - 1;
	mp_oldest_stream	= mp_stream;
	m_emitting			= false;

	// Create a (semi-transparent) material used to render the mesh.
	mp_material			= new NxXbox::sMaterial;
	ZeroMemory( mp_material, sizeof( NxXbox::sMaterial ));

	mp_material->m_flags[0]		= MATFLAG_TRANSPARENT | MATFLAG_TEXTURED;
	mp_material->m_passes		= 1;
	mp_material->m_alpha_cutoff	= 1;
	mp_material->m_no_bfc		= true;
	mp_material->m_color[0][0]	= 0.5f;
	mp_material->m_color[0][1]	= 0.5f;
	mp_material->m_color[0][2]	= 0.5f;
	mp_material->m_color[0][3]	= m_params.m_FixedAlpha * ( 1.0f /  128.0f );
	mp_material->m_reg_alpha[0]	= NxXbox::GetBlendMode( m_params.m_BlendMode );

	// Get texture.
	Nx::CTexture*		p_texture;
	Nx::CXboxTexture*	p_xbox_texture;
	mp_material->mp_tex[0]	= NULL;
	p_texture				= Nx::CTexDictManager::sp_particle_tex_dict->GetTexture( m_params.m_Texture );
	p_xbox_texture			= static_cast<Nx::CXboxTexture*>( p_texture );
	if( p_xbox_texture )
	{
		mp_material->mp_tex[0] = p_xbox_texture->GetEngineTexture();
	}

	// Convert 3-point -> PVA format.
	float t1 = m_params.m_Lifetime * m_params.m_MidpointPct * 0.01f;
	float t2 = m_params.m_Lifetime;
	Mth::Vector x0,x1,x2,u,a_;

	x0    = m_params.m_BoxDims[0];
	x0[3] = m_params.m_RadiusSpread[0];
	x1    = m_params.m_BoxDims[1];
	x1[3] = m_params.m_RadiusSpread[1];
	x2    = m_params.m_BoxDims[2];
	x2[3] = m_params.m_RadiusSpread[2];

	if( m_params.m_UseMidpoint )
	{
		u  = ( t2 * t2 * ( x1 - x0 ) - t1 * t1 * ( x2 - x0 )) / ( t1 * t2 * ( t2 - t1 ));
		a_ = ( t1 * ( x2 - x0 ) - t2 * ( x1 - x0 )) / ( t1 * t2 * ( t2 - t1 ));
	}
	else
	{
		u  = ( x2 - x0 ) / t2;
		a_.Set( 0.0f, 0.0f, 0.0f, 0.0f );
	}

	m_s0 = x0;
	m_s1 = u;
	m_s2 = a_;

	x0    = m_params.m_BoxPos[0];
	x0[3] = m_params.m_Radius[0];
	x1    = m_params.m_BoxPos[1];
	x1[3] = m_params.m_Radius[1];
	x2    = m_params.m_BoxPos[2];
	x2[3] = m_params.m_Radius[2];

	if( m_params.m_UseMidpoint )
	{
		u  =  ( t2 * t2 * ( x1 - x0 ) - t1 * t1 * ( x2 - x0 )) / ( t1 * t2 * ( t2 - t1 ));
		a_ =  ( t1 * ( x2 - x0 ) - t2 * ( x1 - x0 )) / ( t1 * t2 * ( t2 - t1 ));
	}
	else
	{
		u  = ( x2 - x0 ) / t2;
		a_.Set( 0.0f, 0.0f, 0.0f, 0.0f );
	}

	m_p0	= x0 - 1.5f * m_s0;
	m_p1	= u  - 1.5f * m_s1;
	m_p2	= a_ - 1.5f * m_s2;
	m_p0[3]	= x0[3] - 1.5f * m_s0[3];
	m_p1[3]	= u[3]  - 1.5f * m_s1[3];
	m_p2[3]	= a_[3] - 1.5f * m_s2[3];

	update_position();

	// Color.
	if( m_params.m_UseMidcolor )
	{
		float q0 = 100.0f / ( m_params.m_Lifetime * m_params.m_ColorMidpointPct );
		float q1 = 100.0f / ( m_params.m_Lifetime * ( 100.0f - m_params.m_ColorMidpointPct ));

//		m_systemDmaData.m_c0[0] = ((float)m_params.m_Color[1].r - (float)m_params.m_Color[0].r) * q0;
//		m_systemDmaData.m_c0[1] = ((float)m_params.m_Color[1].g - (float)m_params.m_Color[0].g) * q0;
//		m_systemDmaData.m_c0[2] = ((float)m_params.m_Color[1].b - (float)m_params.m_Color[0].b) * q0;
//		m_systemDmaData.m_c0[3] = ((float)m_params.m_Color[1].a - (float)m_params.m_Color[0].a) * q0;

//		m_systemDmaData.m_c1[0] = (float)m_params.m_Color[1].r;
//		m_systemDmaData.m_c1[1] = (float)m_params.m_Color[1].g;
//		m_systemDmaData.m_c1[2] = (float)m_params.m_Color[1].b;
//		m_systemDmaData.m_c1[3] = (float)m_params.m_Color[1].a;

//		m_systemDmaData.m_c2[0] = ((float)m_params.m_Color[2].r - (float)m_params.m_Color[1].r) * q1;
//		m_systemDmaData.m_c2[1] = ((float)m_params.m_Color[2].g - (float)m_params.m_Color[1].g) * q1;
//		m_systemDmaData.m_c2[2] = ((float)m_params.m_Color[2].b - (float)m_params.m_Color[1].b) * q1;
//		m_systemDmaData.m_c2[3] = ((float)m_params.m_Color[2].a - (float)m_params.m_Color[1].a) * q1;
	}
	else // else suppress mid-colour
	{
		float q = 1.0f / m_params.m_Lifetime;

//		m_systemDmaData.m_c1[0] = (float)m_params.m_Color[0].r;
//		m_systemDmaData.m_c1[1] = (float)m_params.m_Color[0].g;
//		m_systemDmaData.m_c1[2] = (float)m_params.m_Color[0].b;
//		m_systemDmaData.m_c1[3] = (float)m_params.m_Color[0].a;

//		m_systemDmaData.m_c2[0] = ((float)m_params.m_Color[2].r - (float)m_params.m_Color[0].r) * q;
//		m_systemDmaData.m_c2[1] = ((float)m_params.m_Color[2].g - (float)m_params.m_Color[0].g) * q;
//		m_systemDmaData.m_c2[2] = ((float)m_params.m_Color[2].b - (float)m_params.m_Color[0].b) * q;
//		m_systemDmaData.m_c2[3] = ((float)m_params.m_Color[2].a - (float)m_params.m_Color[0].a) * q;
	}

	// Rotation matrix.
	m_rotation.Identity();
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxNewParticle::plat_destroy( void )
{
	if( mp_stream )
	{
		delete [] mp_stream;
	}

	if( mp_material )
	{
		delete mp_material;
	}
}



/*****************************************************************************
**							  Public Functions								**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Nx




