#include <sys/timer.h>
#include <sys/file/filesys.h>
#include <core/macros.h>

#include <stdio.h>
#include <stdlib.h>
#include "nx_init.h"
#include "texture.h"
#include "scene.h"
#include "mesh.h"
#include "anim.h"
#include "render.h"
#include "billboard.h"
#include <Gfx/NxMiscFX.h>

namespace NxXbox
{

bool			s_meshScalingEnabled = false;
char*			s_pWeightIndices = NULL;
float*			s_pWeights = NULL;
Mth::Vector*	s_pBonePositions = NULL;
Mth::Vector*	s_pBoneScales = NULL;
int				s_currentVertIndex = 0;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SetMeshScalingParameters( Nx::SMeshScalingParameters* pParams )
{
	Dbg_Assert( pParams );

	s_meshScalingEnabled	= true;
	s_pWeights				= pParams->pWeights;
	s_pWeightIndices		= pParams->pWeightIndices;
	s_pBoneScales			= pParams->pBoneScales;
	s_pBonePositions		= pParams->pBonePositions;
	s_currentVertIndex		= 0;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void DisableMeshScaling( void )
{
	s_meshScalingEnabled	= false;
	s_pWeights				= NULL;
	s_pWeightIndices		= NULL;
	s_pBoneScales			= NULL;
	s_pBonePositions		= NULL;
	s_currentVertIndex		= 0;
}

	
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static inline Mth::Vector get_bone_scale( int bone_index )
{
	Mth::Vector returnVec( 1.0f, 1.0f, 1.0f, 1.0f );

	if( bone_index >= 29 && bone_index <= 33 )
	{
		// this only works with the thps5 skeleton, whose
		// head bones are between 29 and 33...
		// (eventually, we can remove the subtract 29
		// once the exporter is massaging the data correctly)
		returnVec = s_pBoneScales[ bone_index - 29 ];
		
		// Y & Z are reversed...  odd!
		Mth::Vector tempVec = returnVec;
		returnVec[Y] = tempVec[Z];
		returnVec[Z] = tempVec[Y];
	}
	else if( bone_index == -1 )
	{
		// implies that it's not weighted to a bone
		return returnVec;
	}
	else
	{
		// implies that it's weighted to the wrong bone
		return returnVec;
	}
	return returnVec;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static inline Mth::Vector get_bone_pos( int bone_index )
{
	Mth::Vector returnVec( 0.0f, 0.0f, 0.0f, 1.0f );
	
	if( bone_index >= 29 && bone_index <= 33 )
	{
		// this only works with the thps5 skeleton, whose
		// head bones are between 29 and 33...
		// (eventually, we can remove the subtract 29
		// once the exporter is massaging the data correctly)
		returnVec = s_pBonePositions[ bone_index - 29 ];
	}
	else if( bone_index == -1 )
	{
		// implies that it's not weighted to a bone
		return returnVec;
	}
	else
	{
		// implies that it's weighted to the wrong bone
		return returnVec;
	}
	returnVec[W] = 1.0f;

	return returnVec;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void ApplyMeshScaling( float* p_vertices, int num_verts )
{
	if( s_meshScalingEnabled )
	{
		for( int v = 0; v < num_verts; ++v, p_vertices += 3 )
		{
			float x = p_vertices[0];
			float y = p_vertices[1];
			float z = p_vertices[2];

    		Mth::Vector origPos( x, y, z, 1.0f );

			Mth::Vector bonePos0 = get_bone_pos( s_pWeightIndices[v * 3] );
			Mth::Vector bonePos1 = get_bone_pos( s_pWeightIndices[v * 3 + 1] );
			Mth::Vector bonePos2 = get_bone_pos( s_pWeightIndices[v * 3 + 2] );

			// Need to scale each vert relative to its parent bone.
			Mth::Vector localPos0 = origPos - bonePos0;
			Mth::Vector localPos1 = origPos - bonePos1;
			Mth::Vector localPos2 = origPos - bonePos2;

			localPos0.Scale( get_bone_scale( s_pWeightIndices[v * 3] ) );
			localPos1.Scale( get_bone_scale( s_pWeightIndices[v * 3 + 1] ) );
			localPos2.Scale( get_bone_scale( s_pWeightIndices[v * 3 + 2] ) );

			localPos0 += bonePos0;
			localPos1 += bonePos1;
			localPos2 += bonePos2;
			
			Mth::Vector scaledPos = ( localPos0 * s_pWeights[v * 3] ) +
									( localPos1 * s_pWeights[v * 3 + 1] ) +
									( localPos2 * s_pWeights[v * 3 + 2] );

			p_vertices[0] = scaledPos[X];
			p_vertices[1] = scaledPos[Y];
			p_vertices[2] = scaledPos[Z];
		}
	}
}

	
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sMesh::sMesh( void )
{
	m_flags							= 0;
	m_num_vertex_buffers			= 1;
	m_current_write_vertex_buffer	= 0;
	for( int vb = 0; vb < MAX_VERTEX_BUFFERS; ++vb )
	{
		mp_vertex_buffer[vb]		= NULL;
	}
	for( int ib = 0; ib < MAX_INDEX_BUFFERS; ++ib )
	{
		mp_index_buffer[ib]			= NULL;
		m_num_indices[ib]			= 0;
	}
	mp_vc_wibble_data				= NULL;
	mp_index_lod_data				= NULL;
	mp_billboard_data				= NULL;
	m_bone_index					= -1;
	mp_transform					= NULL;
	m_diffuse_offset				= 0;
	m_uv0_offset					= 0;
	m_normal_offset					= 0;
	m_vertex_stride					= 0;
	m_vertex_shader[0]				= 0;
	m_pixel_shader					= 0;

	Checksum = 0;

	p_rawdata = NULL;

	field_8C = 0;

	m_num_vertices_raw = 0;
	m_vertices_raw = NULL;

	m_num_vertice_edits = 0;
	m_vertice_edits_raw = NULL;

	SetActive( true );
	SetVisibility( 0xFF );

	m_lastRenderFrameCount = -1;
	m_lastRenderFlags = 0;
	m_biggest_index_used = -1;

	// Set default primitive type.
	m_primitive_type				= D3DPT_TRIANGLESTRIP;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: change logic for index buffers
sMesh::~sMesh( void )
{
	// Remove this mesh from the billboard manager if appropriate.
	if( m_flags & sMesh::MESH_FLAG_BILLBOARD )
	{
		BillboardManager.RemoveEntry( this );
	}

	//EngineGlobals.p_Device->BlockUntilIdle();

	if( mp_transform )
	{
		delete mp_transform;
	}
	
	if( !( m_flags & MESH_FLAG_IS_INSTANCE ))
	{
		for (int ib = 0; ib < MAX_INDEX_BUFFERS; ++ib)
		{
			//delete [] mp_index_buffer[ib];
			IndexBufferWrapper* p_buff = mp_index_buffer[ib];
			if (!p_buff)
			{
				continue;
			}
			p_buff->indexBuffer->Release();
			p_buff->indexBuffer = NULL;

			LinkedList* p_list = g_meshIndexBuffers;
			if (p_list)
			{
				while (p_list->data != p_buff)
				{
					p_list = (LinkedList*)p_list->next;
				}
			}

			// KISAKTODO: logic could be cleaned up here a bit
			if (p_list)
			{
				auto* prev = p_list->prev;
				if (prev)
				{
					prev->next = p_list->next;
				}
				else
				{
					g_meshIndexBuffers = (LinkedList*)p_list->next;
				}

				auto* next = p_list->next;
				if (next)
				{
					next->prev = p_list->prev;
				}
				p_list->data = NULL;
				p_list->prev = NULL;
				p_list->next = NULL;
				delete p_list;
			}

			if (p_buff->indexBuffer)
			{
				p_buff->indexBuffer->Release();
			}
			if (p_buff->rawdata)
			{
				free(p_buff->rawdata);
			}
			p_buff->len = 0;
			p_buff->d3dusage = 0;
			p_buff->d3dformat = (D3DFORMAT)0;
			p_buff->indexBuffer = NULL;
			p_buff->rawdata = NULL;
			p_buff->unk4 = NULL;
			delete p_buff;

			mp_index_buffer[ib] = NULL;
		}

		if( mp_vc_wibble_data )
		{
			delete mp_vc_wibble_data;
			mp_vc_wibble_data = NULL;
		}

		if( mp_index_lod_data )
		{
			delete mp_index_lod_data;
			mp_index_lod_data = NULL;
		}

		if( mp_billboard_data )
		{
			delete mp_billboard_data;
			mp_billboard_data = NULL;
		}

		delete this->p_rawdata;

		UINT					stride = 0;
		IDirect3DVertexBuffer9	*p_vb = NULL;
		UINT					offset = 0;
		D3DDevice_GetStreamSource( 0, &p_vb, &offset, &stride );
		if( p_vb )
		{
			// GetStreamSource() increments the reference count, so call Release() here.
			p_vb->Release();
		}

		// KISAKTODO: omitted some weird functions here. 
		for( uint32 i = 0; i < m_num_vertex_buffers; ++i )
		{
			if( mp_vertex_buffer[i] )
			{
				if( p_vb == mp_vertex_buffer[i]->vertexBuffer )
				{
					// We are deleting a vertex buffer that is set as the current stream source. This can result in
					// problems with the internal D3D reference counter, so clear this up first.
					D3DDevice_SetStreamSource( 0, NULL, 0, 0 );
				}
			
				uint8 *p_del = (uint8*)mp_vertex_buffer[i];
				delete p_del;
				mp_vertex_buffer[i]	= NULL;
			}
		}
	}

	if (this->m_vertice_edits_raw)
	{
		free(m_vertice_edits_raw);
	}
	if (this->m_vertices_raw)
	{
		free(m_vertices_raw);
	}
	memset(this, 0x00, sizeof(sMesh));
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::PushVertexShader( uint32 shader_id )
{
	for( uint32 i = sMesh::VERTEX_SHADER_STACK_SIZE - 1; i > 0; --i )
	{
		m_vertex_shader[i] = m_vertex_shader[i - 1];
	}
	m_vertex_shader[0] = shader_id;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::PopVertexShader( void )
{
	for( uint32 i = 0; i < sMesh::VERTEX_SHADER_STACK_SIZE - 1; ++i )
	{
		m_vertex_shader[i] = m_vertex_shader[i + 1];
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: Commented out. Seems unused.
//void sMesh::wibble_normals( void )
//{
//	if( m_flags & 0 )
//	{
//		// Angle in the range [-PI/16, PI/16], period is 1 second.
//		float time = (float)Tmr::GetTime() * 0.0005f;
//
//		BYTE		*p_byte;
//		float		*p_normal;
//		float		*p_pos;
//		mp_vertex_buffer[m_current_write_vertex_buffer]->Lock( 0, 0, (void**)&p_byte, 0);
//		p_pos		= (float*)( p_byte + 0 );
//		p_normal	= (float*)( p_byte + m_normal_offset );
//
//		for( uint32 i = 0; i < m_num_vertices; ++i )
//		{
//			float x				= p_pos[0] - m_sphere_center.x;
//			float z				= p_pos[2] - m_sphere_center.z;
//			
//			float time_offset_x	= time + (( x / m_sphere_radius ) * 0.5f );
//			float time_offset_z	= time + (( z / m_sphere_radius ) * 0.5f );
//
//			float angle_x		= ( Mth::PI * ( 1.0f / 64.0f ) * (float)fabs( sinf( time_offset_x * Mth::PI ))) - ( Mth::PI * ( 1.0f / 128.0f ));
//			float angle_z		= ( Mth::PI * ( 1.0f / 64.0f ) * (float)fabs( sinf( time_offset_z * Mth::PI ))) - ( Mth::PI * ( 1.0f / 129.0f ));
//			
//			Mth::Vector	n( sinf( angle_x ), cosf(( angle_x + angle_z ) * 0.5f ), sinf( angle_z ));
//			n.Normalize();
//			
//			p_normal[0]			= n[X];
//			p_normal[1]			= n[Y];
//			p_normal[2]			= n[Z];
//			
//			p_pos				= (float*)((BYTE*)p_pos + m_vertex_stride );
//			p_normal			= (float*)((BYTE*)p_normal + m_vertex_stride );
//		}
//	}
//}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: Rework for PC
void sMesh::wibble_vc( void )
{
	if( mp_vc_wibble_data )
	{
		VertexBufferWrapper* p_curr_buf = this->mp_vertex_buffer[this->m_current_write_vertex_buffer];

		char* p_locked_rawdata = NULL;
		p_curr_buf->vertexBuffer->Lock(0, 0, (void**)&p_locked_rawdata, D3DLOCK_DISCARD);

		D3DCOLOR* p_color_array = mp_material->mp_wibble_vc_colors;

		BYTE* v1 = p_curr_buf->GetRawData();
		size_t size = m_vertex_stride - m_diffuse_offset - 4;

		// Scan through each vertex, setting the new color.
		for (uint32 i = 0; i < m_num_vertices; ++i)
		{
			// An index of zero means no update for this vert.
			uint32 index = mp_vc_wibble_data[i];
			if (index)
			{
				memcpy(p_locked_rawdata, v1, m_diffuse_offset);
				DWORD* dPtr = (DWORD*)&p_locked_rawdata[m_diffuse_offset];
				*dPtr = *(DWORD*)(uintptr_t(p_color_array) + 4 * index - 4);
				memcpy(&p_locked_rawdata[m_diffuse_offset + 4], &v1[m_diffuse_offset + 4], size);
			}
			else
			{
				memcpy(p_locked_rawdata, v1, m_vertex_stride);
			}
			p_locked_rawdata += m_vertex_stride;
			v1 += m_vertex_stride;
		}

		p_curr_buf->vertexBuffer->Unlock();

		// Grab byte pointer to current 'write' vertex buffer.
		//BYTE		*p_byte;
		//D3DCOLOR	*p_color;
		//mp_vertex_buffer[m_current_write_vertex_buffer]->Lock( 0, 0, (void**)&p_byte, 0);
		//p_color = (D3DCOLOR*)( p_byte + m_diffuse_offset );
		//
		//D3DCOLOR *p_color_array	= mp_material->mp_wibble_vc_colors;
		//
		//// Scan through each vertex, setting the new color.
		//for( uint32 i = 0; i < m_num_vertices; ++i )
		//{
		//	// An index of zero means no update for this vert.
		//	uint32 index	= mp_vc_wibble_data[i];
		//	if( index > 0 )
		//	{
		//		*p_color	= p_color_array[index - 1];
		//	}
		//	p_color		= (D3DCOLOR*)((BYTE*)p_color + m_vertex_stride );
		//}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::CreateDuplicateVertexBuffers( int n )
{
	// Ensure this hasn't already been called.
	Dbg_Assert( mp_vertex_buffer[0] != NULL );
	Dbg_Assert( mp_vertex_buffer[1] == NULL );
	Dbg_Assert(( n > 0 ) && ( n < MAX_VERTEX_BUFFERS ));

	VertexBufferWrapper* buf0 = this->mp_vertex_buffer[0];
	buf0->lockOffset = 0;
	buf0->lockedSize = buf0->len;
	buf0->d3dlockFlags = 16;

	// Lock the source buffer.
	//BYTE *p_byte;
	//if( D3D_OK != mp_vertex_buffer[0]->Lock( 0, 0, (void**)&p_byte, D3DLOCK_READONLY))
	//{
//		exit( 0 );
//	}
	
	for( int i = 0; i < n; ++i )
	{
		mp_vertex_buffer[i + 1] = AllocateVertexBuffer( m_vertex_stride * m_num_vertices, 0, 0 );
		mp_vertex_buffer[i + 1]->lockOffset = 0;
		mp_vertex_buffer[i + 1]->lockedSize = mp_vertex_buffer[i + 1]->len;
		mp_vertex_buffer[i + 1]->d3dlockFlags = 0;

		memcpy(mp_vertex_buffer[i + 1]->GetRawData(), buf0->GetRawData(), this->m_vertex_stride * this->m_num_vertices);

		mp_vertex_buffer[i + 1]->Unlock();

		//// Lock the destination buffer and copy the contents of the original buffer into the new buffer.
		//BYTE *p_byte2;
		//if( D3D_OK != mp_vertex_buffer[i + 1]->Lock( 0, 0, (void**)&p_byte2, 0))
		//{
		//	exit( 0 );
		//}
		//CopyMemory( p_byte2, p_byte, m_vertex_stride * m_num_vertices );
	}

	buf0->Unlock();

	m_num_vertex_buffers = 1 + n;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::SetPosition( Mth::Vector &pos )
{
	// Create a transform if one doesn't exist yet.
	if( mp_transform == NULL )
	{
		mp_transform = new Mth::Matrix();
		mp_transform->Ident();
	}
	
	// Figure what we need to add to each vertex, based on current position.
	Mth::Vector offset(	pos[X] - mp_transform->GetPos()[X],
						pos[Y] - mp_transform->GetPos()[Y],
						pos[Z] - mp_transform->GetPos()[Z] );

	mp_transform->SetPos( pos );
	
	for( uint32 vb = 0; vb < m_num_vertex_buffers; ++vb )
	{
		BYTE *p_byte;
		mp_vertex_buffer[vb]->Lock( 0, 0, (void**)&p_byte, 0);

		for( uint32 v = 0; v < m_num_vertices; ++v )
		{
			((D3DVECTOR*)p_byte )->x += offset[X];
			((D3DVECTOR*)p_byte )->y += offset[Y];
			((D3DVECTOR*)p_byte )->z += offset[Z];
			p_byte += m_vertex_stride;
		}

		mp_vertex_buffer[vb]->Unlock(); // lwss add
	}

	// LWSS Add
	for (int i = 0; i < m_num_vertices_raw; i++)
	{
		BYTE* p_byte = (BYTE*)m_vertices_raw;

		((D3DVECTOR*)p_byte)->x += offset[X];
		((D3DVECTOR*)p_byte)->y += offset[Y];
		((D3DVECTOR*)p_byte)->z += offset[Z];

		p_byte += 12;
	}
	// LWSS End

	// We also need to adjust the bounding box and sphere information for this mesh.
	m_sphere_center.x += offset[X];
	m_sphere_center.y += offset[Y];
	m_sphere_center.z += offset[Z];
}
	

	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::GetPosition( Mth::Vector *p_pos )
{
	if( mp_transform == NULL )
	{
		p_pos->Set( 0.0f, 0.0f, 0.0f );
	}
	else
	{
		*p_pos = mp_transform->GetPos();
	}
}
	

	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::SetYRotation( Mth::ERot90 rot )
{
	if( rot > Mth::ROT_0 )
	{
		// Create a transform if one doesn't exist yet.
		if( mp_transform == NULL )
		{
			mp_transform = new Mth::Matrix();
			mp_transform->Ident();
		}

		for( uint32 vb = 0; vb < m_num_vertex_buffers; ++vb )
		{
			BYTE *p_byte;
			// LWSS: Change for PC
			//mp_vertex_buffer[vb]->Lock( 0, 0, (void**)&p_byte, 0 );
			p_byte = this->mp_vertex_buffer[vb]->GetRawData();
			this->mp_vertex_buffer[vb]->lockOffset = 0;
			this->mp_vertex_buffer[vb]->lockedSize = this->mp_vertex_buffer[vb]->len;
			this->mp_vertex_buffer[vb]->d3dlockFlags = 0;

			switch( rot )
			{
				case Mth::ROT_90:
				{
					for( uint32 v = 0; v < m_num_vertices; ++v )
					{
						float x = ((D3DVECTOR*)p_byte )->x - mp_transform->GetPos()[X];
						float z = ((D3DVECTOR*)p_byte )->z - mp_transform->GetPos()[Z];
						((D3DVECTOR*)p_byte )->x = z + mp_transform->GetPos()[X];
						((D3DVECTOR*)p_byte )->z = -x + mp_transform->GetPos()[Z];
						p_byte += m_vertex_stride;
					}

					// Adjust the bounding sphere information for this mesh.
					m_sphere_center.x	-= mp_transform->GetPos()[X];
					m_sphere_center.z	-= mp_transform->GetPos()[Z];
					float t				= m_sphere_center.x;
					m_sphere_center.x	= m_sphere_center.z + mp_transform->GetPos()[X];
					m_sphere_center.z	= -t + mp_transform->GetPos()[Z];
					break;
				}
				case Mth::ROT_180:
				{
					for( uint32 v = 0; v < m_num_vertices; ++v )
					{
						float x = ((D3DVECTOR*)p_byte )->x - mp_transform->GetPos()[X];
						float z = ((D3DVECTOR*)p_byte )->z - mp_transform->GetPos()[Z];
						((D3DVECTOR*)p_byte )->x = -x + mp_transform->GetPos()[X];
						((D3DVECTOR*)p_byte )->z = -z + mp_transform->GetPos()[Z];
						p_byte += m_vertex_stride;
					}

					// Adjust the bounding sphere information for this mesh.
					m_sphere_center.x	-= mp_transform->GetPos()[X];
					m_sphere_center.z	-= mp_transform->GetPos()[Z];
					m_sphere_center.x	= -m_sphere_center.x + mp_transform->GetPos()[X];
					m_sphere_center.z	= -m_sphere_center.z + mp_transform->GetPos()[Z];
					break;
				}
				case Mth::ROT_270:
				{
					for( uint32 v = 0; v < m_num_vertices; ++v )
					{
						float x = ((D3DVECTOR*)p_byte )->x - mp_transform->GetPos()[X];
						float z = ((D3DVECTOR*)p_byte )->z - mp_transform->GetPos()[Z];
						((D3DVECTOR*)p_byte )->x = -z + mp_transform->GetPos()[X];
						((D3DVECTOR*)p_byte )->z = x + mp_transform->GetPos()[Z];
						p_byte += m_vertex_stride;
					}

					// Adjust the bounding sphere information for this mesh.
					m_sphere_center.x	-= mp_transform->GetPos()[X];
					m_sphere_center.z	-= mp_transform->GetPos()[Z];
					float t				= m_sphere_center.x;
					m_sphere_center.x	= -m_sphere_center.z + mp_transform->GetPos()[X];
					m_sphere_center.z	= t + mp_transform->GetPos()[Z];
					break;
				}
			} // switch()

			mp_vertex_buffer[vb]->Unlock(); // lwss add
		}
	}
}




/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: 100% accurate
void sMesh::SwapVertexBuffers( void )
{
	if( m_num_vertex_buffers > 1 )
	{
		m_current_write_vertex_buffer = ( m_current_write_vertex_buffer + 1 ) % m_num_vertex_buffers;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: Looks good
void sMesh::HandleColorOverride( void )
{
	static float constants[16];

	Dbg_Assert( m_flags & sMesh::MESH_FLAG_MATERIAL_COLOR_OVERRIDE );

	// Re-jig the pixel shader constants for the material color override.
	CopyMemory( constants, EngineGlobals.pixel_shader_constants, sizeof( float ) * 16 );
			
	for( uint32 p = 0; p < mp_material->m_passes; ++p )
	{
		if( !( mp_material->m_flags[p] & MATFLAG_PASS_COLOR_LOCKED ))
		{
//			EngineGlobals.pixel_shader_constants[( p * 4 ) + 0]	*= m_material_color_override[0];
//			EngineGlobals.pixel_shader_constants[( p * 4 ) + 1]	*= m_material_color_override[1];
//			EngineGlobals.pixel_shader_constants[( p * 4 ) + 2]	*= m_material_color_override[2];
			EngineGlobals.pixel_shader_constants[( p * 4 ) + 0]	= m_material_color_override[0];
			EngineGlobals.pixel_shader_constants[( p * 4 ) + 1]	= m_material_color_override[1];
			EngineGlobals.pixel_shader_constants[( p * 4 ) + 2]	= m_material_color_override[2];
		}
	}
	EngineGlobals.upload_pixel_shader_constants = true;

	// Set the pixel shader (this will upload the new constants).
	set_pixel_shader( m_pixel_shader, mp_material->m_passes );

	// Restore the pixel shader constants and flag as needing a reload.
	CopyMemory( EngineGlobals.pixel_shader_constants, constants, sizeof( float ) * 16 );
	EngineGlobals.upload_pixel_shader_constants = true;
}

void sMesh::TransformVertexBuffer_CASE1(BYTE* a2)
{
	int v6; // ecx
	Mth::Matrix* v8; // [esp+14h] [ebp-10h]
	D3DXVECTOR3 tmp;

	BYTE* p_data = this->p_rawdata;
	v8 = NxXbox::pBoneTransforms;
	for (int a2a = 0; a2a < this->m_num_vertices; ++a2a)
	{
		const D3DXMATRIX* v5 = (D3DXMATRIX*)&NxXbox::pBoneTransforms[p_data[60]];
		XGVec3TransformCoord(&tmp, (D3DXVECTOR3*)p_data, v5);
		float* fPtr = (float*)a2;
		DWORD* dPtr = (DWORD*)a2;
		*fPtr = tmp.x;
		*(fPtr + 1) = tmp.y;
		*(fPtr + 2) = tmp.z;

		D3DXVec3TransformNormal(&tmp, (D3DXVECTOR3*)(p_data + 0xC), v5);
		v6 = 0;
		*(fPtr + 3) = tmp.x; // 0xC
		*(fPtr + 4) = tmp.y; // 0x10
		*(fPtr + 5) = tmp.z; // 0x14

		*(dPtr + 6) = *(DWORD*)(p_data + 0x18); // 0x18

		float* fArg = (float*)(a2 + 0x1C);
		float* fData = (float*)(p_data + 0x1C);
		if (2 * this->m_tex_coord_pass)
		{
			do
			{
				++v6;
				*fArg++ = *fData++;
			} while (v6 < (2 * this->m_tex_coord_pass));
		}

		p_data += 76;
		a2 += this->m_vertex_stride;
	}
}

void sMesh::TransformVertexBuffer_CASE2(BYTE* a2)
{
	Mth::Matrix* v11;

	D3DXVECTOR3 v13;
	D3DXVECTOR3 pOut;

	BYTE* p_data = this->p_rawdata;
	v11 = NxXbox::pBoneTransforms;

	for (int i = 0; i < this->m_num_vertices; ++i)
	{
		const D3DXMATRIX* v5 = (D3DXMATRIX*)&v11[p_data[60]];
		XGVec3TransformCoord(&v13, (D3DXVECTOR3*)p_data, v5);
		D3DXVec3TransformNormal(&pOut, (D3DXVECTOR3*)(p_data + 0xC), v5);

		float v6 = *(float*)(p_data + 0x40);

		if (v6 != 1.0f) // KISAKTODO: Use an epsilon damnnit!
		{
			*&v13.x = *&v13.x * v6;
			*&v13.y = *&v13.y * v6;
			*&v13.z = *&v13.z * v6;
			*&pOut.x = *&pOut.x * v6;
			*&pOut.y = *&pOut.y * v6;
			*&pOut.z = v6 * *&pOut.z;
			const D3DXMATRIX* v7 = (D3DXMATRIX*)&v11[p_data[61]];
			float a2a = *(float*)(p_data + 0x44);
			D3DXVECTOR3 v15;
			XGVec3TransformCoord(&v15, (D3DXVECTOR3*)p_data, v7);
			*&v13.x = *&v15.x * a2a + *&v13.x;
			*&v13.y = *&v15.y * a2a + *&v13.y;
			*&v13.z = a2a * *&v15.z + *&v13.z;
			D3DXVec3TransformNormal(&v15, (D3DXVECTOR3*)(p_data + 0xC), v7);
			*&pOut.x = *&v15.x * a2a + *&pOut.x;
			*&pOut.y = *&v15.y * a2a + *&pOut.y;
			*&pOut.z = a2a * *&v15.z + *&pOut.z;
		}

		float* fPtr = (float*)a2;
		DWORD* dPtr = (DWORD*)a2;

		*fPtr = v13.x; // 0
		*(fPtr + 1) = v13.y; // 4
		*(fPtr + 2) = v13.z; // 8

		*(fPtr + 3) = pOut.x; // 0xC
		*(fPtr + 4) = pOut.y; // 0x10
		*(fPtr + 5) = pOut.z; // 0x14

		*(dPtr + 6) = *(DWORD*)(p_data + 0x18); // 0x18

		int v8 = 0;
		float* v9 = (float*)(a2 + 0x1C);
		float* v10 = (float*)(p_data + 0x1C);
		if (2 * this->m_tex_coord_pass)
		{
			do
			{
				++v8;
				*v9++ = *v10++;
			} while (v8 < (2 * this->m_tex_coord_pass));
		}

		p_data += 76;
		a2 += this->m_vertex_stride;
	}
}

void sMesh::TransformVertexBuffer_CASE3(BYTE* a2)
{
	BYTE* p_data = this->p_rawdata; // ebp
	Mth::Matrix* pBoners = NxXbox::pBoneTransforms;

	for (int i = 0; i < this->m_num_vertices; ++i)
	{
		const D3DXMATRIX* v5 = (D3DXMATRIX*)&pBoners[p_data[60]];
		D3DXVECTOR3 v14;
		D3DXVECTOR3 pOut;
		XGVec3TransformCoord(&v14, (D3DXVECTOR3*)p_data, v5);
		D3DXVec3TransformNormal(&pOut, (D3DXVECTOR3*)(p_data + 0xC), v5);

		float v6 = *(float*)(p_data + 0x40);

		if (v6 != 1.0f) // KISAKTODO: Use an epsilon damnnit!
		{
			*&v14.x = *&v14.x * v6;
			*&v14.y = *&v14.y * v6;
			*&v14.z = *&v14.z * v6;
			*&pOut.x = *&pOut.x * v6;
			*&pOut.y = *&pOut.y * v6;
			*&pOut.z = v6 * *&pOut.z;
			D3DXMATRIX* v7 = (D3DXMATRIX*)&pBoners[p_data[61]];
			float a2b = *(float*)(p_data + 0x44);
			D3DXVECTOR3 v16;
			XGVec3TransformCoord(&v16, (D3DXVECTOR3*)p_data, v7);
			*&v14.x = *&v16.x * a2b + *&v14.x;
			*&v14.y = *&v16.y * a2b + *&v14.y;
			*&v14.z = a2b * *&v16.z + *&v14.z;
			D3DXVec3TransformNormal(&v16, (D3DXVECTOR3*)(p_data + 0xC), v7);
			*&pOut.x = *&v16.x * a2b + *&pOut.x;
			*&pOut.y = *&v16.y * a2b + *&pOut.y;
			*&pOut.z = a2b * *&v16.z + *&pOut.z;
			float a2a = *(float*)(p_data + 0x48);
			if (0.0f != a2a)
			{
				D3DXMATRIX* v8 = (D3DXMATRIX*)&pBoners[p_data[62]];
				XGVec3TransformCoord(&v16, (D3DXVECTOR3*)p_data, v8);
				*&v14.x = *&v16.x * a2a + *&v14.x;
				*&v14.y = *&v16.y * a2a + *&v14.y;
				*&v14.z = a2a * *&v16.z + *&v14.z;
				D3DXVec3TransformNormal(&v16, (D3DXVECTOR3*)(p_data + 0xC), v8);
				*&pOut.x = *&v16.x * a2a + *&pOut.x;
				*&pOut.y = *&v16.y * a2a + *&pOut.y;
				*&pOut.z = a2a * *&v16.z + *&pOut.z;
			}
		}

		float* fPtr = (float*)a2;
		DWORD* dPtr = (DWORD*)a2;

		*fPtr = v14.x;		// 0
		*(fPtr + 1) = v14.y;// 4
		*(fPtr + 2) = v14.z;// 8

		*(fPtr + 3) = pOut.x;// 0xC
		*(fPtr + 4) = pOut.y;// 0x10
		*(fPtr + 5) = pOut.z;// 0x14

		*(dPtr + 6) = *(DWORD*)(p_data + 0x18); // 0x18

		int itr = 0;
		float* v10 = (float*)(a2 + 0x1C);
		float* v11 = (float*)(p_data + 0x1C);
		if (2 * this->m_tex_coord_pass)
		{
			do
			{
				++itr;
				*v10++ = *v11++;
			} while (itr < 2 * this->m_tex_coord_pass);
		}

		p_data += 76;
		a2 += this->m_vertex_stride;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS major changes for PC -- Considering done for now...
void sMesh::Submit( void )
{
	DWORD	stage_zero_minfilter = 0;
	DWORD	zwrite = 0;
	
	D3DXMATRIX v50;
	D3DXMATRIX v51;

	if (!NxXbox::EngineGlobals.g_Registry_options_flag_2 || Checksum == -1)
	{
		goto DISABLE_FOG;
	}

	if (check_radius(&m_sphere_center, m_sphere_radius))
	{
		return;
	}

	if (NxXbox::EngineGlobals.g_Registry_options_flag_1_MSAA)
	{
		EngineGlobals.fog_start = 0.0f;
		EngineGlobals.fog_end = 0.0f;

		//v50._21 = EngineGlobals.far_plane - (EngineGlobals.far_plane - EngineGlobals.near_plane) * 0.25f;
		//v50._22 = EngineGlobals.far_plane;
		float start = EngineGlobals.far_plane - (EngineGlobals.far_plane - EngineGlobals.near_plane) * 0.25f;
		float end = EngineGlobals.far_plane;
		Nx::CFog::sEnableFog(true);
		v50._14 = v50._22;
		D3DDevice_SetRenderState(D3DRS_FOGSTART, start);
		D3DDevice_SetRenderState(D3DRS_FOGEND, end);
	}
	else
	{
DISABLE_FOG:
		Nx::CFog::sEnableFog(false);
	}

	// Pointless submitting a mesh with zero indices.
	//if( m_num_indices == 0 )
	if( m_num_indices[0] == 0 ) // lwss: thugbug??
		return;

	if (this->m_biggest_index_used != -1)
	{
		//STDMETHOD(SetTransform)(THIS_ D3DTRANSFORMSTATETYPE State, CONST D3DMATRIX * pMatrix) PURE;
		//STDMETHOD(GetTransform)(THIS_ D3DTRANSFORMSTATETYPE State, D3DMATRIX * pMatrix) PURE;
		D3DDevice_GetTransform((D3DTRANSFORMSTATETYPE)256, &v50);
		XGMatrixMultiply(&v51, (D3DXMATRIX*)&pBoneTransforms[this->m_biggest_index_used], &v50);
		D3DDevice_SetTransform((D3DTRANSFORMSTATETYPE)256, &v51);
	}

	if (LOBYTE(this->field_8C)) // KISAKTODO: find other ref's of field_8C and fix them.
	{
		NxXbox::set_render_state(RS_CULLMODE, D3DCULL_CCW);
	}

	// Deal with vertex color wibbling.
	wibble_vc();
	
	// Set vertex shader.
	set_vertex_shader( m_vertex_shader[0] );

	if (NxXbox::EngineGlobals.hasHLSLv101)
	{
		mp_material->Submit();

		if (m_flags & sMesh::MESH_FLAG_MATERIAL_COLOR_OVERRIDE)
		{
			HandleColorOverride();
		}
		else
		{
			// Just set the pixel shader.
			set_pixel_shader(m_pixel_shader, mp_material->m_passes);
		}
	}
	else
	{
		// sMaterial::Submit2() -- call the non-shader version of sMaterial submit (fk this)
	}

	// Deal with meshes that set no anisotropic filtering.
	if( m_flags & MESH_FLAG_NO_ANISOTROPIC )
	{
		D3DDevice_GetSamplerState(0, D3DSAMP_MINFILTER, &stage_zero_minfilter);
		//D3DDevice_GetTextureStageState( 0, D3DTSS_MINFILTER, &stage_zero_minfilter );
		if( stage_zero_minfilter != D3DTEXF_LINEAR )
		{
			//D3DDevice_SetTextureStageState( 0, D3DTSS_MINFILTER, D3DTEXF_LINEAR );
			D3DDevice_SetSamplerState(0, D3DSAMP_MINFILTER, D3DTEXF_LINEAR);
		}
	}
	
	// Deal with meshes that set no z-write.
	if( m_flags & MESH_FLAG_NO_ZWRITE )
	{
		D3DDevice_GetRenderState( D3DRS_ZWRITEENABLE, &zwrite );
		if( zwrite == TRUE )
		{
			D3DDevice_SetRenderState( D3DRS_ZWRITEENABLE, FALSE );
		}
	}
	
	// Get the vertex buffer to submit (which is the one we have potentially just been writing to).
	//IDirect3DVertexBuffer8*	p_submit_buffer = mp_vertex_buffer[m_current_write_vertex_buffer];
	//IDirect3DVertexBuffer9*	p_submit_buffer = mp_vertex_buffer[m_current_write_vertex_buffer];
	
	if (this->p_rawdata && (m_lastRenderFrameCount != g_globalFrameCounter || m_lastRenderFlags != renderFlags))
	{
		m_lastRenderFrameCount = g_globalFrameCounter;
		m_lastRenderFlags = renderFlags;

		void* pMem = NULL;
		mp_vertex_buffer[m_current_write_vertex_buffer]->Lock(0, 0, &pMem, D3DLOCK_DISCARD);

		switch (this->m_lastBiggestIndexUsed)
		{
		case 1:
			this->TransformVertexBuffer_CASE1((BYTE*)pMem);
			break;
		case 2:
			this->TransformVertexBuffer_CASE2((BYTE*)pMem);
			break;
		case 3:
			this->TransformVertexBuffer_CASE3((BYTE*)pMem);
			break;
		}

		mp_vertex_buffer[m_current_write_vertex_buffer]->Unlock();
	}

	// Swap multiple vertex buffers if present.
	SwapVertexBuffers();
	
	// Set the stream source.
	auto sss_res = D3DDevice_SetStreamSource( 0, mp_vertex_buffer[m_current_write_vertex_buffer]->vertexBuffer,
		mp_vertex_buffer[m_current_write_vertex_buffer]->streamOffset, m_vertex_stride );

	Dbg_Assert(sss_res == D3D_OK);

	int idx = 0;
	// See if we have index LOD data, in which case we need to figure distance and select the correct LOD.
	if( mp_index_lod_data )
	{
		// Figure distance from this mesh to the camera. This is *not* an efficient way to do it.
		frustum_check_sphere( &m_sphere_center, m_sphere_radius );
		float dist = get_bounding_sphere_nearest_z();
		for(; idx < MAX_INDEX_BUFFERS; ++idx )
		{
			if( mp_index_buffer[idx] == NULL )
			{
				// We have got to the end of the set without drawing anything. Just use the last valid index set.
				if( idx > 0 )
				{
					--idx;
					goto DRAW_SHIT;
					//D3DDevice_DrawIndexedVertices( m_primitive_type, m_num_indices[idx], mp_index_buffer[idx] );
				}
				else
				{
					Dbg_Assert( 0 );
				}
				break;
			}

			if( dist < mp_index_lod_data[idx] )
			{
				// This is the index set we want.
				goto DRAW_SHIT;
				//D3DDevice_DrawIndexedVertices( m_primitive_type, m_num_indices[idx], mp_index_buffer[idx] );
				break;
			}
		}
	}
	else
	{
		// Submit.
		//D3DDevice_DrawIndexedVertices( m_primitive_type, m_num_indices[0], mp_index_buffer[0] );
	}

DRAW_SHIT:
	Dbg_Assert(D3D_OK == D3DDevice_SetIndices(mp_index_buffer[idx]->indexBuffer));

#ifdef _DEBUG
	// lwss TEST -- Ensure none of the indexes in the indexbuffer are out of range
	for (int i = 0; i < mp_index_buffer[idx]->len / 2; i++)
	{
		uint16_t index = mp_index_buffer[idx]->rawdata[i];
		Dbg_Assert(index >= 0 && index <= m_num_vertices);
	}
	// Also check the length of the vertex buffer
	//for (int i = 0; i < mp_vertex_buffer[m_current_write_vertex_buffer]->len; i++)
	//{
	//	// Try reading... Otherwise segfault
	//	volatile BYTE byte = mp_vertex_buffer[m_current_write_vertex_buffer]->rawdata[i];
	//}
	// lwss end
#endif

	if (EngineGlobals.hasHLSLv101)
	{
		int prim_count = m_num_indices[idx] - 2;
		Dbg_Assert(D3D_OK == D3DDevice_DrawIndexedPrimitive(m_primitive_type, 0, 0, m_num_vertices, 0, prim_count));
	}
	else
	{
		// LWSS: Fk this
	}

	// Deal with meshes that set no anisotropic filtering.
	if( m_flags & MESH_FLAG_NO_ANISOTROPIC )
	{
		if( stage_zero_minfilter != D3DTEXF_LINEAR )
		{
			D3DDevice_SetSamplerState( 0, D3DSAMP_MINFILTER, stage_zero_minfilter );
		}
	}

	// Deal with meshes that set no z-write.
	if( m_flags & MESH_FLAG_NO_ZWRITE )
	{
		if( zwrite == TRUE )
		{
			D3DDevice_SetRenderState( D3DRS_ZWRITEENABLE, TRUE );
		}
	}

	if (this->m_biggest_index_used != -1)
	{
		// LWSS: This is a guess here... stack a bit hard to read.
		D3DDevice_SetTransform(D3DTS_WORLD, &v50);
	}

	Nx::CFog::sEnableFog(false);

	if (LOBYTE(this->field_8C)) // KISAKTODO: find other ref's of field_8C and fix them.
	{
		NxXbox::set_render_state(RS_CULLMODE, D3DCULL_CW);
	}

	//Sleep(1000);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sMesh *sMesh::Clone( bool instance )
{
	sMesh *p_clone = new sMesh();

	// Copy over basic details.
	CopyMemory( p_clone, this, sizeof( sMesh ));
	
	if( instance )
	{
		p_clone->m_flags |= MESH_FLAG_IS_INSTANCE;
	}
	else
	{
		// Build new vertex and index lists.
		p_clone->mp_vertex_buffer[0] = AllocateVertexBuffer( p_clone->m_vertex_stride * p_clone->m_num_vertices, 0, 0 );

		// LWSS: deep copy logic.
		this->mp_vertex_buffer[0]->lockOffset = 0;
		this->mp_vertex_buffer[0]->lockedSize = this->mp_vertex_buffer[0]->len;
		this->mp_vertex_buffer[0]->d3dlockFlags = D3DLOCK_READONLY;
		
		p_clone->mp_vertex_buffer[0]->lockOffset = 0;
		p_clone->mp_vertex_buffer[0]->lockedSize = p_clone->mp_vertex_buffer[0]->len;
		p_clone->mp_vertex_buffer[0]->d3dlockFlags = 0;

		memcpy(p_clone->mp_vertex_buffer[0]->GetRawData(), this->mp_vertex_buffer[0]->GetRawData(), p_clone->m_vertex_stride * p_clone->m_num_vertices);

		this->mp_vertex_buffer[0]->Unlock();
		p_clone->mp_vertex_buffer[0]->Unlock();

		//BYTE *p_byte_src, *p_byte_dest;
		//if( D3D_OK != mp_vertex_buffer[0]->Lock( 0, 0, (void**)&p_byte_src, D3DLOCK_READONLY ))
		//{
		//	return NULL;
		//}
		//if( D3D_OK != p_clone->mp_vertex_buffer[0]->Lock( 0, 0, (void**)&p_byte_dest, 0 ))
		//{
		//	return NULL;
		//}
		//
		//// Copy over vertex information.
		//CopyMemory( p_byte_dest, p_byte_src, p_clone->m_vertex_stride * p_clone->m_num_vertices );

		// Create index buffer(s) and copy over index information.
		for( int ib = 0; ib < MAX_INDEX_BUFFERS; ++ib )
		{
			if( p_clone->m_num_indices[ib] > 0 )
			{
				IndexBufferWrapper* newIndexBuffer = new IndexBufferWrapper(2 * p_clone->m_num_indices[ib], 0, D3DFMT_INDEX16);

				p_clone->mp_index_buffer[ib] = newIndexBuffer;

				memcpy(newIndexBuffer->rawdata, p_clone->mp_index_buffer[ib]->rawdata, 2 * p_clone->m_num_indices[ib]);

				void* v28;
				if (this->mp_index_buffer[ib]->indexBuffer->Lock(0, 0, &v28, 0) >= 0)
				{
					memcpy(v28, this->mp_index_buffer[ib]->rawdata, this->mp_index_buffer[ib]->len);
					this->mp_index_buffer[ib]->indexBuffer->Unlock();
				}

				void* v29;
				if (p_clone->mp_index_buffer[ib]->indexBuffer->Lock(0, 0, &v29, 0) >= 0)
				{
					memcpy(v29, p_clone->mp_index_buffer[ib]->rawdata, p_clone->mp_index_buffer[ib]->len);
					p_clone->mp_index_buffer[ib]->indexBuffer->Unlock();
				}
				//p_clone->mp_index_buffer[ib] = new uint16[p_clone->m_num_indices[ib]];
				//CopyMemory( p_clone->mp_index_buffer[ib], mp_index_buffer[ib], sizeof( uint16 ) * p_clone->m_num_indices[ib] );
			}
		}
		
		// LWSS: More 0x90~ fields...
		p_clone->m_lastBiggestIndexUsed = this->m_lastBiggestIndexUsed;
		p_clone->m_lastRenderFlags = this->m_lastRenderFlags;
		p_clone->m_lastRenderFrameCount = this->m_lastRenderFrameCount;
		p_clone->m_biggest_index_used = this->m_biggest_index_used;
		p_clone->m_tex_coord_pass = this->m_tex_coord_pass;

		if (this->p_rawdata)
		{
			size_t sz = (76 * this->m_num_vertices);
			BYTE* v18 = new BYTE[sz];
			p_clone->p_rawdata = v18;
			memcpy(v18, this->p_rawdata, 76 * this->m_num_vertices);
			p_clone->m_lastRenderFrameCount = -1;
		}

		// Handle duplicate vertex buffers if they exist.
		if( m_num_vertex_buffers > 1 )
		{
			p_clone->mp_vertex_buffer[1] = NULL;
			p_clone->CreateDuplicateVertexBuffers( m_num_vertex_buffers - 1 );
		}
	}
	if (this->m_num_vertices_raw)
	{
		void* v19 = malloc(6 * (this->m_num_vertices_raw + 1)); // LWSS: add +1, I've had it OOB write (1x).
		p_clone->m_vertice_edits_raw = v19;
		memcpy(v19, this->m_vertice_edits_raw, 6 * this->m_num_vertice_edits);
		void* v20 = malloc(12 * this->m_num_vertices_raw);
		p_clone->m_vertices_raw = (char*)v20;
		memcpy(v20, this->m_vertices_raw, 12 * this->m_num_vertices_raw);
	}
	return p_clone;
}


static void* Block;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
VertexBufferWrapper* sMesh::AllocateVertexBuffer( uint32 size, int d3dusage, int flags, const char* debug_name)
{
	// LWSS: change to wrapper
	//uint8					*p_vb		= new uint8[sizeof( IDirect3DVertexBuffer9 ) + size];
	//IDirect3DVertexBuffer9	*p_vb_ret	= (IDirect3DVertexBuffer9*)p_vb;
	//
	//XGSetVertexBufferHeader( 0, 0, 0, 0, p_vb_ret, 0 );
	//p_vb_ret->Register( p_vb + sizeof( IDirect3DVertexBuffer9 ));
	//
	//return p_vb_ret;

	return new VertexBufferWrapper(size, d3dusage, flags, debug_name);
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// LWSS: Should be ok, assuming rawdata is intact
void sMesh::Crunch( void )
{
	uint16 *p_indices = mp_index_buffer[0]->rawdata;

	uint32 i0 = p_indices[0];
	uint32 i1 = p_indices[1];

	uint32	invalid			= 0;
	uint32	total_invalid	= 0;
	bool	crunch			= false;

	for( uint32 i = 2; i < m_num_indices[0]; ++i )
	{
		uint32 i2 = p_indices[i];

		if(( i0 == i1 ) || ( i0 == i2 ) || ( i1 == i2 ))
		{
			++invalid;
		}
		else
		{
			if( invalid > 5 )
			{
				if(( invalid & 1 ) == 0 )
				{
//					printf( "Crunching %d indices (even)\n", invalid - 4 );

					// Ensure the leading and trailing degenerate indices are correct.
					p_indices[i - 3]		= p_indices[i - 2];
					p_indices[i - invalid]	= p_indices[i - invalid - 1];

					// With an even number of invalid entries, the wind order won't change during crunch.
					MoveMemory( p_indices + i - invalid + 1, p_indices + i - 3, sizeof( uint16 ) * ( m_num_indices[0] - i + 3 ));

					m_num_indices[0]	-= (uint16)( invalid - 4 );
					i					-= invalid - 4;
				}
				else
				{
//					printf( "Crunching %d indices (odd)\n", invalid - 5 );

					// Ensure the leading and trailing degenerate indices are correct.
					p_indices[i - 3]			= p_indices[i - 2];
					p_indices[i - invalid]		= p_indices[i - invalid - 1];
					p_indices[i - invalid + 1]	= p_indices[i - invalid];

					// With an odd number of invalid entries, the wind order will change during crunch, so use one extra index.
					MoveMemory( p_indices + i - invalid + 2, p_indices + i - 3, sizeof( uint16 ) * ( m_num_indices[0] - i + 3 ));
					m_num_indices[0]	-= (uint16)( invalid - 5 );
					i					-= invalid - 5;
				}
			}
			invalid = 0;
		}
		
		i0 = i1;
		i1 = i2;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::SetBillboardData( uint32 type, Mth::Vector & pivot_pos, Mth::Vector & pivot_axis )
{
	Dbg_Assert( mp_billboard_data == NULL );

	// Create the billboard data.
	mp_billboard_data					= new sBillboardData;

	// Determine the billboard type.
	if( type == 1 )
	{
		mp_billboard_data->m_type = sBillboardData::vBILLBOARD_TYPE_SCREEN_ALIGNED;
	}
	else if( type == 2 )
	{
		// Axial aligned. See if this is y axis.
		if( fabsf( Mth::DotProduct( pivot_axis, Mth::Vector( 0.0f, 1.0f, 0.0f ))) > 0.99f )
		{
			mp_billboard_data->m_type = sBillboardData::vBILLBOARD_TYPE_Y_AXIS_ALIGNED;
		}
		else
		{
			mp_billboard_data->m_type = sBillboardData::vBILLBOARD_TYPE_ARBITRARY_AXIS_ALIGNED;
		}
	}
	else
	{
		Dbg_Assert( 0 );
	}
	
	mp_billboard_data->m_pivot_pos		= pivot_pos;
	if( mp_billboard_data->m_type == sBillboardData::vBILLBOARD_TYPE_ARBITRARY_AXIS_ALIGNED )
	{
		mp_billboard_data->m_pivot_axis	= pivot_axis;
	}

	// We need to go through at a low level and rebuild the vertex buffer. In all cases the
	// mesh won't have been exported with normals, which we use for billboards to store the
	// pivot-relative position, so we need to recalculate the vertex stride.
	Dbg_Assert( m_normal_offset == 0 );
	Dbg_Assert( m_diffuse_offset > 0 );
	Dbg_Assert( m_uv0_offset > 0 );
	Dbg_Assert( m_num_vertices == 4 );
	Dbg_Assert( m_num_indices[0] == 4 );

	// Add size of normal to vertex size.
	int old_vertex_stride = m_vertex_stride;
	int new_vertex_stride = old_vertex_stride + ( sizeof( float ) * 3 );

	// LWSS: Rework vertex logic
	//IDirect3DVertexBuffer9*	p_old_buffer = mp_vertex_buffer[0];
	//IDirect3DVertexBuffer9*	p_new_buffer = AllocateVertexBuffer( new_vertex_stride * 4 );
	VertexBufferWrapper*	p_old_buffer = mp_vertex_buffer[0];
	void* p_old_buffer_rawdata = p_old_buffer->GetRawData(); 

	IndexBufferWrapper* index_buffer0 = this->mp_index_buffer[0];

	p_old_buffer->lockOffset = 0;
	p_old_buffer->lockedSize = p_old_buffer->len;
	p_old_buffer->d3dlockFlags = 16;

	// Lock old buffer (read) and new buffer (write).
	BYTE *p_old_vb_data = (BYTE*)p_old_buffer->GetRawData();
	//BYTE *p_new_vb_data;
	//p_old_buffer->Lock( 0, 0, (void**)&p_old_vb_data, D3DLOCK_READONLY);
	//p_new_buffer->Lock( 0, 0, (void**)&p_new_vb_data, 0 );

	// Calculate the normal of the billboard, using the first tri.
	float		*p_vert;
	uint16		indices[4];
	indices[0]			= mp_index_buffer[0]->rawdata[0];
	indices[1]			= mp_index_buffer[0]->rawdata[1];
	indices[2]			= mp_index_buffer[0]->rawdata[2];
	indices[3]			= mp_index_buffer[0]->rawdata[3];

	p_vert				= (float*)( p_old_vb_data + ( indices[0] * old_vertex_stride ));
	Mth::Vector v0( p_vert[0], p_vert[1], p_vert[2] );
	p_vert				= (float*)( p_old_vb_data + ( indices[1] * old_vertex_stride ));
	Mth::Vector v1( p_vert[0], p_vert[1], p_vert[2] );
	p_vert				= (float*)( p_old_vb_data + ( indices[2] * old_vertex_stride ));
	Mth::Vector v2( p_vert[0], p_vert[1], p_vert[2] );
	Mth::Vector	normal	= Mth::CrossProduct(( v1 - v0 ), ( v2 - v0 )).Normalize();

	void* Dst;
	if (index_buffer0->indexBuffer->Lock(0, 0, &Dst, 0) >= 0)
	{
		memcpy(Dst, index_buffer0->rawdata, index_buffer0->len);
		index_buffer0->indexBuffer->Unlock();
	}

	// Given the normal, calculate the local right and up (u and v) vectors, based on the billboard type.
	Mth::Vector u, v;

	switch( mp_billboard_data->m_type )
	{
		case sBillboardData::vBILLBOARD_TYPE_SCREEN_ALIGNED:
		case sBillboardData::vBILLBOARD_TYPE_Y_AXIS_ALIGNED:
		case sBillboardData::vBILLBOARD_TYPE_WORLD_ORIENTED:
		{
			// Use the world 'up' vector to generate the 'u' vector.
			u = Mth::CrossProduct( normal, Mth::Vector( 0.0f, 1.0f, 0.0f )).Normalize();

			// Use the 'u' vector and the normal vector to generate the 'v' vector.
			v = Mth::CrossProduct( u, normal ).Normalize();
			break;
		}
		case sBillboardData::vBILLBOARD_TYPE_ARBITRARY_AXIS_ALIGNED:
		{
			// Use the pivot axis and the normal vector to generate the 'u' vector.
			u = Mth::CrossProduct( normal, pivot_axis ).Normalize();

			// Use the 'u' vector and the normal vector to generate the 'v' vector.
			v = Mth::CrossProduct( u, normal ).Normalize();
			break;
		}
	}

	// KISAKTODO: ugh this logic is annoying to follow, should be pretty accurate
	for( int i = 0; i < 4; ++i )
	{
		float *p_pos = (float*)(p_old_vb_data + (i * old_vertex_stride));

		// The new position is actually the position of the pivot point for the billboard.
		//float *p_pos_old	= (float*)( p_old_vb_data + ( i * old_vertex_stride ));
		//float *p_pos_new	= (float*)( p_new_vb_data + ( i * new_vertex_stride ));
		//p_pos_new[0]		= pivot_pos[X];
		//p_pos_new[1]		= pivot_pos[Y];
		//p_pos_new[2]		= pivot_pos[Z];
	
		// Introduce normal (which is actually the position of the vertex relative to the pivot).
		//Mth::Vector pos_relative_to_pivot( p_pos_old[0] - pivot_pos[X], p_pos_old[1] - pivot_pos[Y], p_pos_old[2] - pivot_pos[Z] );
		Mth::Vector pos_relative_to_pivot(
			p_pos[0] - pivot_pos[X],
			p_pos[1] - pivot_pos[Y],
			p_pos[2] - pivot_pos[Z] 
		);
	
		//p_pos_new[3]		= Mth::DotProduct( pos_relative_to_pivot, u );
		//p_pos_new[4]		= Mth::DotProduct( pos_relative_to_pivot, v );
		//p_pos_new[5]		= Mth::DotProduct( pos_relative_to_pivot, normal );

		p_pos[0]		= Mth::DotProduct( pos_relative_to_pivot, u );
		p_pos[1]		= Mth::DotProduct( pos_relative_to_pivot, v );
		p_pos[2]		= Mth::DotProduct( pos_relative_to_pivot, normal );
	
		//// Copy color.
		//D3DCOLOR *p_col_old	= (D3DCOLOR*)( p_old_vb_data + ( i * old_vertex_stride ) + m_diffuse_offset );
		//D3DCOLOR *p_col_new	= (D3DCOLOR*)( p_new_vb_data + ( i * new_vertex_stride ) + m_diffuse_offset + ( sizeof( float ) * 3 ));
		//p_col_new[0]		= p_col_old[0];
		//
		//// Copy uv0...
		//float *p_uv0_old	= (float*)( p_old_vb_data + ( i * old_vertex_stride ) + m_uv0_offset );
		//float *p_uv0_new	= (float*)( p_new_vb_data + ( i * new_vertex_stride ) + m_uv0_offset + ( sizeof( float ) * 3 ));
		//p_uv0_new[0]		= p_uv0_old[0];
		//p_uv0_new[1]		= p_uv0_old[1];
	
		// ...and additional uv's if present.
		//if(( m_vertex_shader[0] & D3DFVF_TEXCOUNT_MASK ) > D3DFVF_TEX1 )
		//{
		//	p_uv0_new[2]		= p_uv0_old[2];
		//	p_uv0_new[3]		= p_uv0_old[3];
		//}
		//if(( m_vertex_shader[0] & D3DFVF_TEXCOUNT_MASK ) > D3DFVF_TEX2 )
		//{
		//	p_uv0_new[4]		= p_uv0_old[4];
		//	p_uv0_new[5]		= p_uv0_old[5];
		//}
		//if(( m_vertex_shader[0] & D3DFVF_TEXCOUNT_MASK ) > D3DFVF_TEX3 )
		//{
		//	p_uv0_new[6]		= p_uv0_old[6];
		//	p_uv0_new[7]		= p_uv0_old[7];
		//}
	}

	// Now fix up the mesh. Flag the mesh as being a billboard (stop the mesh being rendered by the regular pathway).
	m_flags |= sMesh::MESH_FLAG_BILLBOARD;

	p_old_buffer->Unlock();

	//// Switch vertex buffers, deleting the old one.
	//mp_vertex_buffer[0]	= p_new_buffer;
	//delete p_old_buffer;
	//
	//// Set the new vertex stride, diffuse and uv0 offset (and normal offset, just to be complete).
	//m_vertex_stride		= new_vertex_stride;
	//m_diffuse_offset	+= sizeof( float ) * 3;
	//m_uv0_offset		+= sizeof( float ) * 3;
	//m_normal_offset		= sizeof( float ) * 3;
	//
	//// Copy the new vertex buffer into existing buffered buffers if m_num_vertex_buffers > 1.
	//if( m_num_vertex_buffers > 1 )
	//{
	//	BYTE *p_buffer0;
	//	BYTE *p_bufferN;
	//	mp_vertex_buffer[0]->Lock( 0, 0, (void**)&p_buffer0, D3DLOCK_READONLY );
	//	for( int vb = 1; vb < m_num_vertex_buffers; ++vb )
	//	{
	//		delete mp_vertex_buffer[vb];
	//		mp_vertex_buffer[vb] = AllocateVertexBuffer( new_vertex_stride * 4 );
	//		mp_vertex_buffer[vb]->Lock( 0, 0, (void**)&p_bufferN, 0 );
	//		CopyMemory( p_bufferN, p_buffer0, new_vertex_stride * 4 );
	//	}
	//}
	//
	//// Set the new vertex shader.
	//m_vertex_shader[0]	= 999;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::SetBoundingData( Mth::Vector & sphere_center, float radius, Mth::Vector & bb_min, Mth::Vector & bb_max )
{
//	m_bbox.Set( bb_min, bb_max );

	m_sphere_center = D3DXVECTOR3( sphere_center[X], sphere_center[Y], sphere_center[Z] );
	m_sphere_radius = radius;
}

// LWSS ADD
void sMesh::RawVertexFuckery()
{
	if (this->m_num_vertices_raw || !this->m_num_indices[0])
	{
		return;
	}

	VertexBufferWrapper* p_vert0 = this->mp_vertex_buffer[0];
	p_vert0->lockOffset = 0;
	p_vert0->lockedSize = p_vert0->len;
	p_vert0->d3dlockFlags = 16;
	
	this->m_num_vertices_raw = this->m_num_vertices;
	this->m_vertices_raw = (char*)malloc(sizeof(D3DXVECTOR3) * m_num_vertices);
	
	DWORD* v10 = (DWORD*)(this->m_vertices_raw);
	BYTE* p_vert_rawdata = p_vert0->GetRawData();
	for (int i = 0; i < this->m_num_vertices; i++)
	{
		v10[0] = p_vert_rawdata[0];
		v10[1] = p_vert_rawdata[1];
		v10[2] = p_vert_rawdata[2];

		v10 += 3;
		p_vert_rawdata += this->m_vertex_stride;
	}
	this->mp_vertex_buffer[0]->Unlock();

	// lwss extra
	Dbg_Assert((this->m_num_indices[0] - 2) > 0);

	uint16* p_index_raw = this->mp_index_buffer[0]->rawdata;
	int num_edits = 0;
	uint16* workspace = (uint16*)malloc(6 * (this->m_num_indices[0] - 2));
	uint16* work = workspace;

	for (int i = 0; i < this->m_num_indices[0] - 2; i++)
	{
		uint16 raw0 = p_index_raw[0];
		uint16 raw1 = p_index_raw[1];
		if (raw0 != raw1)
		{
			uint16 raw2 = p_index_raw[2];
			if (raw1 != raw2 && raw2 != raw0)
			{
				uint16 new_raw0;
				if ((i & 1) != 0)
				{
					work[0] = raw1;
					new_raw0 = raw0;
				}
				else
				{
					work[0] = raw0;
					new_raw0 = raw1;
				}

				work[1] = new_raw0;
				work[2] = p_index_raw[2];
				work += 3;
				num_edits++;
			}
		}

		p_index_raw++;
	}

	void* p_mem = NULL;
	if (this->mp_index_buffer[0]->indexBuffer->Lock(0, 0, &p_mem, 0) >= 0)
	{
		memcpy(p_mem, this->mp_index_buffer[0]->rawdata, this->mp_index_buffer[0]->len);
		this->mp_index_buffer[0]->indexBuffer->Unlock();
	}
	if (num_edits)
	{
		void* edits = malloc(6 * num_edits);
		this->m_vertice_edits_raw = edits;
		memcpy(edits, workspace, 6 * num_edits);
		this->m_num_vertice_edits = num_edits;
	}

	free(workspace);
}

// LWSS ADD
void sMesh::sub_4B3A90(VertexMysteryMeat* p_meat)
{
	VertexBufferWrapper* buff0 = this->mp_vertex_buffer[0];
	if (buff0->vertexBuffer)
	{
		p_meat->streamOffset = p_meat->streamOffset; // ?? 
	}
	else
	{
		size_t len = buff0->len;
		buff0->vertexBuffer = p_meat->vertexBuffer;
		void* rawdata = buff0->GetRawData();
		buff0->streamOffset = p_meat->streamOffset;
		memcpy((char*)p_meat->lockedPtr + p_meat->streamOffset, rawdata, len);
		p_meat->vertexBuffer->AddRef();
		p_meat->streamOffset += (buff0->len + 31) & 0xFFFFFFE0;
	}
}

LinkedList* g_meshIndexBuffers = NULL;
LinkedList* g_meshVertexBuffers = NULL;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::Initialize(int				num_vertices,
	float* p_positions,
	float* p_normals,
	float* p_tex_coords,
	int				num_tc_sets,
	DWORD* p_colors,
	int				num_index_sets,			// How many sets of indices there are (usually 1 set)
	int* p_num_indices,			// Pointer to an array of ints containing number of indices per set
	uint16** pp_indices,			// Pointer to an array of pointers to the actual indices
	unsigned long	material_checksum,
	void* p_scene,
	uint16* p_matrix_indices,
	uint32* p_weights,
	char* p_vc_wibble_anims,
	VertexMysteryMeat* p_meat, // lwss add
	bool is_billboard, // lwss add
	const char* debug_name // lwss add
)
{
	// First thing to do is grab the material pointer for this mesh.
	mp_material = ((sScene*)p_scene)->GetMaterial(material_checksum);

	// LWSS: hack seen in PC binary.
	if (mp_material->m_reg_alpha[0] == vBLEND_MODE_BLEND_PREVIOUS_MASK || mp_material->m_reg_alpha[0] == vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK)
	{
		mp_material->m_reg_alpha[0] = 0;
	}

	if (mp_material == NULL)
	{
		Dbg_Assert(0);
		return;
	}

	if ((num_index_sets == 0) || (p_num_indices[0] == 0))
	{
		return;
	}

	uint16 min_index = (pp_indices[0])[0];
	uint16 max_index = (pp_indices[0])[0];
	for (int i = 0; i < p_num_indices[0]; ++i)
	{
		if ((pp_indices[0])[i] > max_index)
		{
			max_index = (pp_indices[0])[i];
		}
		else if ((pp_indices[0])[i] < min_index)
		{
			min_index = (pp_indices[0])[i];
		}
	}

	if (max_index >= num_vertices)
	{
		// Error!
		Dbg_Assert(0);
		return;
	}

	// Grab top-down heap memory for the mesh workspace buffer. This will need to be as big as the maximum vertex indexed.
	int16* p_mesh_workspace_array = new (Mem::Manager::sHandle().TopDownHeap()) int16[max_index + 1];

	// Setup workspace buffer.
	memset(p_mesh_workspace_array, 1, sizeof(int16) * (max_index + 1));
	for (int i = 0; i < p_num_indices[0]; ++i)
	{
		p_mesh_workspace_array[(pp_indices[0])[i]] = 0;
	}

	// Now figure the wasted space.
	int wasted_verts = 0;
	for (int i = min_index; i <= max_index; ++i)
	{
		if (p_mesh_workspace_array[i] != 0)
			++wasted_verts;
	}

	// Now figure the total number of vertices required for this mesh, to span the min->max indices.
	uint16 vertices_for_this_mesh = (max_index - min_index + 1) - wasted_verts;
	m_num_vertices = vertices_for_this_mesh;

	// Create the index buffer(s). (Should be 16byte aligned for best performance).
	for (int ib = 0; ib < num_index_sets; ++ib)
	{
		IndexBufferWrapper* pData = new IndexBufferWrapper(p_num_indices[ib] * sizeof(uint16), 0, D3DFMT_INDEX16, debug_name);

		//mp_index_buffer[ib]	= new uint16[p_num_indices[ib]];
		mp_index_buffer[ib] = pData;
		m_num_indices[ib] = p_num_indices[ib];
	}

	// Use the material flags to figure the vertex format.
	int vertex_size = 3 * sizeof(float);

	// Include weights (for weighted animation) if present.
	uint32 biggest_index_used = 0;
	if (p_weights)
	{
		Dbg_Assert(p_matrix_indices);

		// Calculate the biggest weight used.
		uint32* p_weight_read = p_weights + min_index;
		for (int v = min_index; v <= max_index; ++v)
		{
			if (p_mesh_workspace_array[v] == 0)
			{
				// This vertex is used.
				uint32 w2 = ((p_weight_read[0] >> 22) & 0x3FF);
				if (w2 > 0)
				{
					biggest_index_used = 2;
					break;
				}
				else
				{
					uint32 w1 = ((p_weight_read[0] >> 11) & 0x7FF);
					if (w1 > 0)
					{
						biggest_index_used = 1;
					}
				}
			}
			++p_weight_read;
		}
		vertex_size += sizeof(uint32);

		// lwss add
		m_lastBiggestIndexUsed = biggest_index_used + 1;
		if (!biggest_index_used)
		{
			uint16 index0 = p_matrix_indices[4 * min_index];
			uint16* p_index_read = p_matrix_indices + (min_index * 4);
			int v45 = min_index;
			// LWSS: logic here sucks and is heavily inferred

			if (min_index > max_index)
			{
				this->m_biggest_index_used = index0;
			}
			else
			{
				bool setshit = false;
				while (p_mesh_workspace_array[v45] || *p_index_read == index0)
				{
					v45++;
					p_index_read += 4;
					if (v45 > max_index)
					{
						this->m_biggest_index_used = index0;
						setshit = true;
						break;
					}
				}
				if (!setshit)
				{
					this->m_biggest_index_used = -1;
				}
			}
		}
		// lwss end
	}

	// Include indices (for weighted animation) if present.
	// LWSS: Remove from PC
	if (p_matrix_indices)
	{
		Dbg_Assert(p_weights);
		vertex_size += sizeof(uint16) * 4;
	}

	// Texture coordinates.
	uint32	tex_coord_pass = 0;
	bool	env_mapped = false;
	if (p_tex_coords)
	{
		for (uint32 pass = 0; pass < mp_material->m_passes; ++pass)
		{
			if (mp_material->m_flags[pass] & MATFLAG_ENVIRONMENT)
			{
				env_mapped = true;
			}

			// Only need UV's for this stage if it is *not* environment mapped.
			if ((mp_material->mp_tex[pass]) && (!(mp_material->m_flags[pass] & MATFLAG_ENVIRONMENT)))
			{
				// Will need uv for this pass and all before it.
				tex_coord_pass = pass + 1;
			}
		}
	}
	else
	{
		for (uint32 pass = 0; pass < mp_material->m_passes; ++pass)
		{
			if (mp_material->m_flags[pass] & MATFLAG_ENVIRONMENT)
			{
				env_mapped = true;
			}
		}
	}

	if (tex_coord_pass > 0)
	{
		vertex_size += 2 * sizeof(float) * tex_coord_pass;
	}

	// Assume no normals for now, unless weight information indicates an animating mesh.
	bool use_normals = false;
	//bool use_packed_normals = false;

	if (p_normals || p_weights || env_mapped)
	{
		// Need to include normals. They will be packed differently for weighted meshes.
		use_normals = true;
		vertex_size += sizeof(float) * 3;
		//if (p_weights)
		//{
		//	use_packed_normals = true;
		//	vertex_size += sizeof(uint32);
		//}
		//else
		//{
		//	vertex_size += sizeof(float) * 3;
		//}
	}

	bool use_colors = false;
	if (p_colors)
	{
		// The raw vertex data does contain vertex colors.
		vertex_size += sizeof(D3DCOLOR);
		use_colors = true;
	}


	// Create the vertex buffer.
	m_vertex_stride = vertex_size;

	// lwss add
	int vertex_wrapper_flags = 0;
	this->m_d3dusage = 0;
	if (p_weights && this->m_biggest_index_used == -1)
	{
		this->m_d3dusage = D3DUSAGE_DYNAMIC;
		vertex_wrapper_flags = 1;
	}

	int* wibble_ptr_thing = NULL;

	if (p_vc_wibble_anims)
	{
		wibble_ptr_thing = NULL;
		this->m_d3dusage = D3DUSAGE_DYNAMIC;
		vertex_wrapper_flags |= 2;
	}
	else
	{
		wibble_ptr_thing = (int*)p_meat;
	}

	if (is_billboard)
	{
		this->m_d3dusage = D3DUSAGE_DYNAMIC;
	}

	if (wibble_ptr_thing)
	{
		vertex_wrapper_flags |= 4;
	}

	// lwss end

	// One allocation for the header and the data buffer.	(KISAKTODO: lol no it's not)
	mp_vertex_buffer[0] = AllocateVertexBuffer(vertex_size * vertices_for_this_mesh, m_d3dusage, vertex_wrapper_flags, debug_name); // KISAKTODO: this probably needs changing...
	// lwss add

	if (wibble_ptr_thing)
	{
		wibble_ptr_thing[2] += (vertex_size * vertices_for_this_mesh + 31) & 0xFFFFFFE0;
	}

	BYTE* p_byte = NULL;

	if (p_weights && this->m_biggest_index_used == -1)
	{
		vertex_size = 76;
		size_t sz = vertex_size * this->m_num_vertices;
		this->p_rawdata = new BYTE[sz];
		memset(this->p_rawdata, 0x00, sz);
		p_byte = this->p_rawdata;
	}
	else
	{
		mp_vertex_buffer[0]->Lock(0, 0, (void**)&p_byte, 0);
	}
	// lwss end
	
	// Copy in vertex position data (for vertices that are used).
	uint32		byte_write_offset = 0;
	float* p_read = &p_positions[min_index * 3];
	//float* p_write = (float*)p_byte; // lwss: swap to rawdata
	float* p_write = (float*)p_byte;

	for (int v = min_index; v <= max_index; ++v)
	{
		if (p_mesh_workspace_array[v] == 0)
		{
			// This vertex is used.
			p_write[0] = p_read[0];
			p_write[1] = p_read[1];
			p_write[2] = p_read[2];
			p_write = (float*)((char*)p_write + vertex_size);
		}
		p_read += 3;
	}

	byte_write_offset += sizeof(float) * 3;
	m_vertex_shader[0] |= D3DFVF_XYZ;

	// Copy in normals data.
	if (use_normals)
	{
		Dbg_Assert(byte_write_offset == 12);
		m_normal_offset = (uint8)byte_write_offset;
		float* p_read = &p_normals[min_index * 3];
		float* p_write = (float*)((char*)p_byte + byte_write_offset);
		for (int v = min_index; v <= max_index; ++v)
		{
			if (p_mesh_workspace_array[v] == 0)
			{
				p_write[0] = p_read[0];
				p_write[1] = p_read[1];
				p_write[2] = p_read[2];
				p_write = (float*)((char*)p_write + vertex_size);
			}
			p_read += 3;
		}
		byte_write_offset += sizeof(float) * 3;
		m_vertex_shader[0] |= D3DFVF_NORMAL;
	}

	// Copy in vertex color data.
	if (use_colors)
	{
		m_diffuse_offset = (uint8)byte_write_offset;
		DWORD* p_col_read = &p_colors[min_index];
		DWORD* p_col_write = (DWORD*)((char*)p_byte + byte_write_offset);
		for (int v = min_index; v <= max_index; ++v)
		{
			if (p_mesh_workspace_array[v] == 0)
			{
				p_col_write[0] = p_col_read[0];
				p_col_write = (DWORD*)((char*)p_col_write + vertex_size);
			}
			p_col_read++;
		}
		byte_write_offset += sizeof(DWORD);
		m_vertex_shader[0] |= D3DFVF_DIFFUSE;
	}

	// Copy in vertex texture coordinate data.
	if ((tex_coord_pass > 0) && (p_tex_coords != NULL))
	{
		m_uv0_offset = (uint8)byte_write_offset;
		p_read = &p_tex_coords[min_index * 2 * num_tc_sets];
		p_write = (float*)((char*)p_byte + byte_write_offset);

		for (int v = min_index; v <= max_index; ++v)
		{
			if (p_mesh_workspace_array[v] == 0)
			{
				for (uint32 pass = 0; pass < tex_coord_pass; ++pass)
				{
					p_write[(pass * 2) + 0] = p_read[(pass * 2) + 0];
					p_write[(pass * 2) + 1] = p_read[(pass * 2) + 1];
				}
				p_write = (float*)((char*)p_write + vertex_size);
			}
			p_read = p_read + (num_tc_sets * 2);
		}
		byte_write_offset += sizeof(float) * 2 * tex_coord_pass;

		// LWSS: Simplified to a map below...
		switch (tex_coord_pass)
		{
		case 1:
		{
			m_vertex_shader[0] |= D3DFVF_TEX1 | D3DFVF_TEXCOORDSIZE2(0);
			break;
		}
		case 2:
		{
			m_vertex_shader[0] |= D3DFVF_TEX2 | D3DFVF_TEXCOORDSIZE2(0) | D3DFVF_TEXCOORDSIZE2(1);
			break;
		}
		case 3:
		{
			m_vertex_shader[0] |= D3DFVF_TEX3 | D3DFVF_TEXCOORDSIZE2(0) | D3DFVF_TEXCOORDSIZE2(1) | D3DFVF_TEXCOORDSIZE2(2);
			break;
		}
		case 4:
		{
			m_vertex_shader[0] |= D3DFVF_TEX4 | D3DFVF_TEXCOORDSIZE2(0) | D3DFVF_TEXCOORDSIZE2(1) | D3DFVF_TEXCOORDSIZE2(2) | D3DFVF_TEXCOORDSIZE2(3);
			break;
		}
		default:
		{
			Dbg_MsgAssert(0, ("Bad number of passes"));
			break;
		}
		}

		// lwss add
		//static const int g_tex_coord_map[5] = { 0, 0x100, 0x200, 0x300, 0x400 };
		//this->m_vertex_shader[0] |= g_tex_coord_map[tex_coord_pass];
		this->m_tex_coord_pass = tex_coord_pass;
		// lwss end
	}
	// lwss add (LINE: 549)
	if (p_weights && this->m_biggest_index_used == -1)
	{
		uint8* p_index_write = (uint8*)this->p_rawdata + 60;
		uint16* p_index_read = p_matrix_indices + min_index * 4;
		for (int v = min_index; v <= max_index; ++v)
		{
			if (p_mesh_workspace_array[v] == 0)
			{
				p_index_write[0] = (uint8)p_index_read[0];
				p_index_write[1] = (uint8)p_index_read[1];
				p_index_write[2] = (uint8)p_index_read[2];
				p_index_write[3] = (uint8)p_index_read[3];

				p_index_write = (uint8*)((char*)p_index_write + vertex_size);
			}
			p_index_read += 4;
		}
		byte_write_offset += sizeof(uint8) * 4;

		uint32* p_weight_read = p_weights + min_index;
		uint32* p_weight_write = (uint32*)((char*)p_byte + byte_write_offset);
		for (int v = min_index; v <= max_index; ++v)
		{
			if (p_mesh_workspace_array[v] == 0)
			{
				// This vertex is used.
				p_weight_write[0] = p_weight_read[0];
				p_weight_write = (uint32*)((char*)p_weight_write + vertex_size);
			}
			++p_weight_read;
		}
		byte_write_offset += sizeof(uint32);

		uint32* p_weights_read = &p_weights[min_index];
		//uint32* p_weights_write = (uint32 *)(this->p_rawdata + 68);
		//float* p_weights_write = (float*)(this->p_rawdata + 64);
		float* p_weights_write = (float*)(this->p_rawdata + 64);
		for (int v = min_index; v <= max_index; ++v)
		{
			if (p_mesh_workspace_array[v] == 0)
			{
				uint32 read0 = p_weights_read[0];
				int readbits = read0 & 0x7FF;
				if ((read0 & 0x400) != 0)
				{
					readbits -= 0x800;
				}
				p_weights_write[0] = (float)readbits / 1024.0f;
				readbits = (read0 >> 11) & 0x7FF;
				if (((read0 >> 11) & 0x400) != 0)
				{
					readbits -= 0x800;
				}
				p_weights_write[1] = (float)readbits / 1024.0f;
				readbits = (read0 >> 22);
				if ((readbits & 0x200) != 0)
				{
					readbits -= 0x400;
				}
				p_weights_write[2] = (float)readbits / 512.0f;

				p_weights_write = (float*)((char*)p_weights_write + vertex_size);
			}
			++p_weights_read;
		}
	}
	else
	{
		this->mp_vertex_buffer[0]->Unlock();
	}
	// lwss end

	// Create the vertex color wibble array if data is present.
	if( p_vc_wibble_anims )
	{
		mp_vc_wibble_data			= new char[m_num_vertices];
		int vc_wibble_data_offset	= 0;

		for( int v = min_index; v <= max_index; ++v )
		{
			if( p_mesh_workspace_array[v] == 0 )
			{
				mp_vc_wibble_data[vc_wibble_data_offset++] = p_vc_wibble_anims[v];
			}
		}
		// Double buffer the vertex buffer. (LWSS: Remove!)
		//CreateDuplicateVertexBuffers( 1 );
	}

	// Process the workspace array.
	int offset = 0;
	for( int v = 0; v <= max_index; ++v )
	{
		if( p_mesh_workspace_array[v] == 0 )
		{
			// This vertex is used.
			p_mesh_workspace_array[v] = offset;
		}
		else
		{
			// This vertex is not used. Update the offset for the next used vertex.
			--offset;
		}
	}
	
	// Copy in index data, normalising the indices for this vertex buffer (i.e. so the lowest index will reference
	// vertex 0 in the buffer built specifically for this mesh).
	for( int ib = 0; ib < num_index_sets; ++ib )
	{
		uint16_t* pIndexData = mp_index_buffer[ib]->rawdata;

		for( int i = 0; i < p_num_indices[ib]; ++i )
		{
			uint16 idx				= ( pp_indices[ib] )[i];

			//mp_index_buffer[ib][i]	= idx + p_mesh_workspace_array[idx];
			pIndexData[i]	= idx + p_mesh_workspace_array[idx];
		}

		mp_index_buffer[ib]->ApplyData();
	}
	
	// Can now remove the mesh workspace array.
	delete [] p_mesh_workspace_array;
	
	// Set the correct vertex shader if a weighted mesh.
	// The number of indices used will be one more than the biggest index used (given 0 base).
	//if( p_weights )
	//{
	//	m_vertex_shader[0] = GetVertexShader( use_colors, ( mp_material->m_flags[0] & MATFLAG_SPECULAR ) ? true : false, biggest_index_used + 1 );
	//}

	// Set the pixel shader regardless.
	if (EngineGlobals.hasHLSLv101)
		GetPixelShader(mp_material, &m_pixel_shader);
	else
		m_pixel_shader = NULL;

	if( num_index_sets > 1 )
	{
		mp_index_lod_data = new float[num_index_sets];
		for( int d = 0; d < num_index_sets; ++d )
		{
			float dist				= ( 15.0f + ( d * 10.0f )) * 12.0f;
			mp_index_lod_data[d]	= dist;
		}
	}

	// LWSS: wtf is this hack??
	if (m_num_vertices == 24 && m_num_indices[0] == 48 && mp_material->m_name_checksum == 0xFA2ED078)
	{
		D3DDevice_SetRenderState(D3DRS_LIGHTING, 0);
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sMesh::DrawBoundingSphere( void )
{
	// LWSS: Missing in retail build.
//#	ifdef __NOPT_ASSERT__
//	const uint32 NUM_SPHERE_POINTS	= 64;
//
//	static uint32 sphere_buffer[NUM_SPHERE_POINTS * 4];
//
//	D3DXMATRIX *p_matrix = (D3DXMATRIX*)&NxXbox::EngineGlobals.view_matrix;
//	Mth::Vector up( 0.0f, 1.0f, 0.0f );
//
//	// Get the 'right' vector as the cross product of camera 'at and world 'up'.
//	Mth::Vector at( p_matrix->m[0][2], p_matrix->m[1][2], p_matrix->m[2][2] );
//	Mth::Vector screen_right	= Mth::CrossProduct( at, up );
//	Mth::Vector screen_up		= Mth::CrossProduct( screen_right, at );
//
//	screen_right.Normalize();
//	screen_up.Normalize();
//
//	set_vertex_shader( D3DFVF_XYZ | D3DFVF_DIFFUSE );
//	set_pixel_shader( PixelShader5 );
//
//	int		index		= 0;
//	float	angle		= 0.0f;
//	float	angle_step	= ( Mth::PI * 2.0f ) / (float)NUM_SPHERE_POINTS;
//
//	// Draw the screen aligned sphere.
//	for( uint32 i = 0; i < NUM_SPHERE_POINTS; ++i, angle += angle_step )
//	{
//		float x = m_sphere_center.x + ( m_sphere_radius * cosf( angle ) * screen_right[X] ) + ( m_sphere_radius * sinf( angle ) * screen_up[X] );
//		float y = m_sphere_center.y + ( m_sphere_radius * cosf( angle ) * screen_right[Y] ) + ( m_sphere_radius * sinf( angle ) * screen_up[Y] );
//		float z = m_sphere_center.z + ( m_sphere_radius * cosf( angle ) * screen_right[Z] ) + ( m_sphere_radius * sinf( angle ) * screen_up[Z] );
//
//		sphere_buffer[index++]	= *((uint32*)&x );
//		sphere_buffer[index++]	= *((uint32*)&y );
//		sphere_buffer[index++]	= *((uint32*)&z );
//		sphere_buffer[index++]	= 0x80800000;
//	}
//	D3DDevice_DrawVerticesUP( D3DPT_LINELOOP, NUM_SPHERE_POINTS, sphere_buffer, sizeof( uint32 ) * 4 );
//
//	// Draw the xz plane sphere.
//	index		= 0;
//	angle		= 0.0f;
//	for( uint32 i = 0; i < NUM_SPHERE_POINTS; ++i, angle += angle_step )
//	{
//		float x = m_sphere_center.x + ( m_sphere_radius * cosf( angle ));
//		float y = m_sphere_center.y;
//		float z = m_sphere_center.z + ( m_sphere_radius * sinf( angle ));
//
//		sphere_buffer[index++]	= *((uint32*)&x );
//		sphere_buffer[index++]	= *((uint32*)&y );
//		sphere_buffer[index++]	= *((uint32*)&z );
//		sphere_buffer[index++]	= 0x80800000;
//	}
//	D3DDevice_DrawVerticesUP( D3DPT_LINELOOP, NUM_SPHERE_POINTS, sphere_buffer, sizeof( uint32 ) * 4 );
//#	endif
}





} // namespace NxXbox


