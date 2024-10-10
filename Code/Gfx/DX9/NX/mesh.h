#ifndef __MESH_H
#define __MESH_H

#include <core\math.h>
#include <core\math\geometry.h>
#include <gfx\nx.h>
#include "material.h"

namespace NxXbox
{

struct sCASData
{
	uint32	mask;
	uint32	data0;
	uint32	data1;
	uint32	start_index = 0;
};
	


struct sBillboardData
{
	enum EBillboardType
	{
		vBILLBOARD_TYPE_SCREEN_ALIGNED			= 0,
		vBILLBOARD_TYPE_Y_AXIS_ALIGNED			= 1,		// Specialised case of arbitrary axial alignment.
		vBILLBOARD_TYPE_ARBITRARY_AXIS_ALIGNED	= 2,
		vBILLBOARD_TYPE_WORLD_ORIENTED			= 3
	};
	
	EBillboardType	m_type;
	Mth::Vector		m_pivot_pos;
	Mth::Vector		m_pivot_axis;							// Normalised axis of rotation, valid only for type ARBITRARY_AXIS_ALIGNED.
};


// LWSS: Add
// KISAKTODO: This is probably an engine class
struct LinkedList
{
	void* data;
	LinkedList* prev;
	LinkedList* next;
};

extern LinkedList* g_meshIndexBuffers;
extern LinkedList* g_meshVertexBuffers;

struct IndexBufferWrapper
{
	int len; // 0
	int d3dusage; // 4
	D3DFORMAT d3dformat; // 8
	IDirect3DIndexBuffer9* indexBuffer; // +0xC
	uint16* rawdata; // 10
	void* unk4; // 14
	void* unk5; // 18
	char debug_name[64];// lwss add

	IndexBufferWrapper(size_t size, int arg_d3dusage, D3DFORMAT arg_d3dformat, const char* p_debug_name = NULL)
	{
		if (p_debug_name)
		{
			strncpy(this->debug_name, p_debug_name, 63);
		}
		else
		{
			memset((void*)debug_name, 0x00, 64);
		}

		this->indexBuffer = 0;
		D3DDevice_CreateIndexBuffer(
			size,
			arg_d3dusage | D3DUSAGE_WRITEONLY,
			arg_d3dformat,
			D3DPOOL_DEFAULT,
			&this->indexBuffer,
			0);
		this->len = size;
		this->d3dusage = arg_d3dusage;
		this->d3dformat = arg_d3dformat;
		this->rawdata = (uint16*)malloc(size);
		unk4 = NULL;
		unk5 = NULL;

		LinkedList* v5; // eax
		LinkedList* v6; // ecx
		bool v7; // zf
		v5 = new LinkedList;
		v6 = g_meshIndexBuffers;
		v7 = g_meshIndexBuffers == 0;
		v5->data = this;
		v5->next = v6;
		v5->prev = 0;
		g_meshIndexBuffers = v5;
		if (!v7)
			v6->prev = v5;
	}

	void ReInitD3DBuffer()
	{
		if (!this->indexBuffer)
		{
			D3DDevice_CreateIndexBuffer(this->len, this->d3dusage | D3DUSAGE_WRITEONLY, this->d3dformat, D3DPOOL_DEFAULT, &this->indexBuffer, NULL);
			
			void* mem = NULL;
			if (this->indexBuffer->Lock(0, 0, &mem, 0) >= 0)
			{
				memcpy(mem, this->rawdata, this->len);
				this->indexBuffer->Unlock();
			}
		}
		else
		{
			Dbg_Assert(0);
		}
	}

	// Copies the Data from rawdata into the D3D Index Buffer
	int ApplyData()
	{
		void* dst;
		if (this->indexBuffer->Lock(0, 0, &dst, 0) >= 0)
		{
			memcpy(dst, this->rawdata, this->len);
			this->indexBuffer->Unlock();
		}
		return 0;
	}

	void DeleteFromGlobalList()
	{
		LinkedList* itr; // eax
		LinkedList* prev; // ecx
		LinkedList* next; // ecx

		itr = g_meshIndexBuffers;
		if (g_meshIndexBuffers)
		{
			while (itr->data != this)
			{
				itr = itr->next;
				if (!itr)
					return;
			}
			prev = itr->prev;
			if (prev)
				prev->next = itr->next;
			else
				g_meshIndexBuffers = itr->next;
			next = itr->next;
			if (next)
				next->prev = itr->prev;
			itr->data = 0;
			itr->prev = 0;
			itr->next = 0;
			delete itr;
		}
	}

	~IndexBufferWrapper()
	{
		// LWSS: uhh original seems to have a bug here??
		if (indexBuffer)
		{
			indexBuffer->Release();
			indexBuffer = NULL;
		}

		DeleteFromGlobalList();

		if (rawdata)
		{
			free(rawdata);
		}

		len = 0;
		d3dusage = 0;
		d3dformat = (D3DFORMAT)0;
		indexBuffer = NULL;
		rawdata = NULL;
		this->unk4 = 0;
		//free(this);
	}
}; // size: 24

// Related to Billboards
struct VertexMysteryMeat
{
	IDirect3DVertexBuffer9* vertexBuffer;
	int streamOffset;
	int length;
	void* lockedPtr;
};

#define FLAG_NO_ALLOC_RAWDATABUFFER 1
#define FLAG_NO_CREATE_VERTEX_BUFFER 4
struct VertexBufferWrapper
{
	int len; // 0
	int d3dusageFlags; // 4
	IDirect3DVertexBuffer9* vertexBuffer; // 8
	BYTE* rawdata; // +0xC
	int lockOffset; // +0x10
	int lockedSize; // +0x14
	int d3dlockFlags; // starts out -1, updated when Lock()'ing the vertexbuffer // 0x18
	int vertexWrapperCreationFlags; // 0x1C
	int streamOffset; // 0x20
	char debug_name[64]; // lwss add

	VertexBufferWrapper(size_t len, int d3dusage, int flags, const char* p_debug_name = NULL)
	{
		if (p_debug_name)
		{
			strncpy(this->debug_name, p_debug_name, 63);
		}
		else
		{
			memset((void*)this->debug_name, 0x00, 64);
		}
		this->vertexBuffer = NULL;
		if ((flags & FLAG_NO_CREATE_VERTEX_BUFFER) == 0)
		{
			D3DDevice_CreateVertexBuffer(len, d3dusage | D3DUSAGE_WRITEONLY, 0, D3DPOOL_DEFAULT, &this->vertexBuffer, NULL);
		}
		this->len = len;
		this->d3dusageFlags = d3dusage;

		if ((flags & FLAG_NO_ALLOC_RAWDATABUFFER) == 0)
		{
			this->rawdata = (BYTE*)malloc(len);
		}
		else
		{
			this->rawdata = NULL;
		}

		this->vertexWrapperCreationFlags = flags;
		this->streamOffset = 0;
		this->d3dlockFlags = -1;
		this->lockedSize = 0;
		this->lockOffset = 0;

		bool hasGlobal = g_meshVertexBuffers != NULL;
		LinkedList* global = g_meshVertexBuffers;

		LinkedList* newEntry = new LinkedList;
		newEntry->data = this;
		newEntry->next = g_meshVertexBuffers;
		newEntry->prev = NULL;

		g_meshVertexBuffers = newEntry;
		if (hasGlobal)
		{
			global->prev = newEntry;
		}
	}
	void ReInitD3DBuffer()
	{
		if ((this->vertexWrapperCreationFlags & FLAG_NO_CREATE_VERTEX_BUFFER) != 0)
		{
			this->vertexBuffer->AddRef();
		}
		else
		{
			D3DDevice_CreateVertexBuffer(this->len, this->d3dusageFlags | D3DUSAGE_WRITEONLY, 0, D3DPOOL_DEFAULT, &this->vertexBuffer, NULL);
		}

		if ((this->vertexWrapperCreationFlags & FLAG_NO_ALLOC_RAWDATABUFFER) == 0)
		{
			int offset = 0;
			if ((this->vertexWrapperCreationFlags & FLAG_NO_CREATE_VERTEX_BUFFER) != 0)
			{
				offset = this->streamOffset;
			}

			void* mem = NULL;
			if (this->vertexBuffer->Lock(offset, this->len, &mem, NULL) >= 0)
			{
				memcpy(mem, this->rawdata, this->len);
				this->vertexBuffer->Unlock();
			}
		}
	}

	void DeleteFromGlobalList()
	{
		LinkedList* itr; // eax
		LinkedList* prev; // ecx
		LinkedList* next; // ecx

		itr = g_meshVertexBuffers;
		if (g_meshVertexBuffers)
		{
			while (itr->data != this)
			{
				itr = itr->next;
				if (!itr)
					return;
			}
			prev = itr->prev;
			if (prev)
				prev->next = itr->next;
			else
				g_meshVertexBuffers = itr->next;
			next = itr->next;
			if (next)
				next->prev = itr->prev;
			itr->data = 0;
			itr->prev = 0;
			itr->next = 0;
			free(itr);
		}
	}
	~VertexBufferWrapper()
	{
		// LWSS: uhh original seems to have a bug here??
		if (this->vertexBuffer)
		{
			this->vertexBuffer->Release();
		}
		this->vertexBuffer = NULL;

		DeleteFromGlobalList();

		if (this->rawdata)
		{
			free(this->rawdata);
		}

		this->len = 0;
		this->d3dusageFlags = 0;
		this->vertexBuffer = 0;
		this->rawdata = 0;
		this->lockOffset = 0;
		this->lockedSize = 0;
		this->d3dlockFlags = 0;
		this->vertexWrapperCreationFlags = 0;
		this->streamOffset = 0;
		free(this);
	}

	// LWSS add so I can add conditional breakpoints.
	BYTE* GetRawData()
	{
		Dbg_Assert((vertexWrapperCreationFlags & FLAG_NO_ALLOC_RAWDATABUFFER) == 0); // LWSS: you can't manipulate the RawData if there's no buffer copy. Instead call Lock()/Unlock() and get the pointer from Dx9.
		return rawdata;
	}


	HRESULT Lock(UINT arglockOffset, UINT sizeToLock, void** ppbData, DWORD lockFlags)
	{
		Dbg_Assert(sizeToLock <= this->len);
		Dbg_Assert(d3dlockFlags == -1 || lockFlags == D3DLOCK_READONLY);
		*ppbData = (arglockOffset + (char*)this->rawdata);
		this->lockOffset = arglockOffset;
		this->lockedSize = sizeToLock;
		if (!sizeToLock)
		{
			this->lockedSize = this->len;
		}
		this->d3dlockFlags = lockFlags;

		if ( (lockFlags & D3DLOCK_DISCARD) || (vertexWrapperCreationFlags & FLAG_NO_ALLOC_RAWDATABUFFER) )
		{
			Dbg_Assert((d3dusageFlags & D3DUSAGE_DYNAMIC) != 0); // lwss: dumbass, you can't use without dynamic

			HRESULT err = this->vertexBuffer->Lock(lockOffset, sizeToLock, ppbData, lockFlags);
			Dbg_Assert(err == D3D_OK);
			return err;
		}
		else
		{
			return 0;
		}
	}

	// Also applies data
	void Unlock()
	{
		void* v2; // [esp+4h] [ebp-4h] BYREF

		if ((this->vertexWrapperCreationFlags & FLAG_NO_CREATE_VERTEX_BUFFER) != 0 && !this->vertexBuffer)
		{
			this->d3dlockFlags = -1;
			return;
		}
		if ((this->d3dlockFlags & D3DLOCK_READONLY) == 0)
		{
			if ( (this->d3dlockFlags & D3DLOCK_DISCARD) || (vertexWrapperCreationFlags & FLAG_NO_ALLOC_RAWDATABUFFER) )
			{
				this->d3dlockFlags = -1;
				this->vertexBuffer->Unlock();
				return;
			}

			if ((this->vertexWrapperCreationFlags & FLAG_NO_CREATE_VERTEX_BUFFER) != 0)
				this->lockOffset += this->streamOffset;

			if (this->vertexBuffer->Lock(
				this->lockOffset,
				this->lockedSize,
				&v2,
				this->d3dlockFlags) >= 0)
			{
				memcpy(v2, this->rawdata, this->lockedSize);
				Dbg_Assert(this->vertexBuffer->Unlock() == D3D_OK);
			}
			else
			{
				Dbg_Assert(0);
			}
		}
		this->d3dlockFlags = -1;
	}
}; // Size: 0x24

// LWSS End

struct sMesh
{
public:

	static const uint32	VERTEX_SHADER_STACK_SIZE	= 2;
	static const uint32	MAX_VERTEX_BUFFERS			= 3;
	static const uint32	MAX_INDEX_BUFFERS			= 8;		// Multiple index buffers are used for triangle-decimated LOD's.
	
	enum EMeshFlags
	{
		MESH_FLAG_IS_INSTANCE				= 0x01,
		MESH_FLAG_NO_SKATER_SHADOW			= 0x02,
		MESH_FLAG_MATERIAL_COLOR_OVERRIDE	= 0x04,
		MESH_FLAG_VERTEX_COLOR_WIBBLE		= 0x08,
		MESH_FLAG_BILLBOARD					= 0x10,		// This mesh is a billboard.
		MESH_FLAG_HAS_TRANSFORM				= 0x20,
		MESH_FLAG_ACTIVE					= 0x40,
		MESH_FLAG_NO_ANISOTROPIC			= 0x80,		// No texture 0 anisotropic filtering for this mesh.
		MESH_FLAG_NO_ZWRITE					= 0x100,	// No zwrite for this mesh.
		MESH_FLAG_SHADOW_VOLUME				= 0x200,	// This mesh represents a single shadow volume.
		MESH_FLAG_BUMPED_WATER				= 0x400,
		MESH_FLAG_UNLIT						= 0x20000	// This corresponds to the material unlit flag during the scene conversion process.
	};

					sMesh( void );
					~sMesh( void );

	// Functions
	void			wibble_vc( void );
	//void			wibble_normals( void ); // LWSS: Commented out. Seems unused.
	uint32			GetChecksum()	const			{ return Checksum; }
	uint32			GetFlags()		const			{ return m_flags; }
	void			SetActive( bool active )		{ if( active ) m_flags |= MESH_FLAG_ACTIVE; else m_flags &= ~MESH_FLAG_ACTIVE; }
	void			SetVisibility( uint8 mask )		{ m_visibility_mask	= mask; }
	void			SetPosition( Mth::Vector &pos );
	void			GetPosition( Mth::Vector *p_pos );
	void			SetYRotation( Mth::ERot90 rot );
	sMesh			*Clone( bool instance = false );
	void			SetBoneIndex( int8 idx )		{ m_bone_index = idx; }
	int8			GetBoneIndex( void )			{ return m_bone_index; }
	void			SetBillboardData( uint32 type, Mth::Vector & pivot_pos, Mth::Vector & pivot_axis );
	void			SetBoundingData( Mth::Vector & sphere_center, float radius, Mth::Vector & bb_min, Mth::Vector & bb_max );

	// lwss add
	void			RawVertexFuckery();
	void			sub_4B3A90(NxXbox::VertexMysteryMeat* p_meat);

	// Grabs memory chunk and builds vertex buffer from heap memory, rather than getting DX to do it.
	static VertexBufferWrapper *AllocateVertexBuffer(uint32 size, int d3dusage, int a3, const char* debug_name = NULL); // lwss: add debug_name

	void SetVertexBufferWrapper(int idx, VertexBufferWrapper* wrapper)
	{
		mp_vertex_buffer[idx] = wrapper;
	}

	// All-purpose mesh instancing code, used for static geometry and animating weighted meshes.
	void			Initialize( int				num_vertices,
								float			*p_positions,
								float			*p_normals,
								float			*p_tex_coords,
								int				num_tc_sets,
								DWORD			*p_colors,
								int				num_index_sets,			// How many sets of indices there are (usually 1 set)
								int				*p_num_indices,			// Pointer to an array of ints containing number of indices per set
								uint16			**pp_indices,			// Pointer to an array of pointers to the actual indices
								unsigned long	material_checksum,
								void			*p_scene,
								uint16			*p_matrix_indices	= NULL,
								uint32			*p_weights			= NULL,
								char			*p_vc_wibble_anims	= NULL,
								VertexMysteryMeat* p_meat = NULL,
								bool			is_billboard = false,
								const char* debug_name = NULL);

	void			Submit( void );
	void			HandleColorOverride( void );
	void			CreateDuplicateVertexBuffers( int n );
	void			SwapVertexBuffers( void );
	void			PushVertexShader( uint32 shader_id );
	void			PopVertexShader( void );
	void			Crunch( void );

	// Debug functions, will be empty stub for Final build.
	void			DrawBoundingSphere( void );

	// lwss add
	void TransformVertexBuffer_CASE1(BYTE* p_data);
	void TransformVertexBuffer_CASE2(BYTE* p_data);
	void TransformVertexBuffer_CASE3(BYTE* p_data);
	// lwss end

	// Members. Order is important here since details required for fast mesh rejection need to be in top 32 bytes of structure.
	uint32					m_flags;
	D3DXVECTOR3				m_sphere_center;
	float					m_sphere_radius;
	sMaterial				*mp_material; // 0x14 (+20)

	uint8					m_vertex_stride; // (+24) 0x18
	uint8					m_current_write_vertex_buffer; // 0x19
	uint8					m_num_vertex_buffers; // 0x1A
	uint8					m_visibility_mask; // 0x20
	uint8					m_diffuse_offset;		// 0x1C Offset into vertex format for diffuse color component. 
	uint8					m_normal_offset;		// 0x1D Offset into vertex format for normal component. 
	uint8					m_uv0_offset;			// 0x1E Offset into vertex format for uv0 component. 
	int8					m_bone_index; 

	uint16					m_load_order;
	uint16					m_num_vertices; // 0x22
	uint16					m_num_indices[MAX_INDEX_BUFFERS]; // (+36 0x24)

	uint32					Checksum = 0; // (+52)
	uint32					m_vertex_shader[VERTEX_SHADER_STACK_SIZE]; // (+56)
	//uint32					m_pixel_shader;
	IDirect3DPixelShader9*  m_pixel_shader; // +64 - 0x40

	float					*mp_index_lod_data;	// +68 0x44	// List of distances (squared) for which a particular index list should be used.
															// NULL for meshes that only have one set of index data.

	sBillboardData			*mp_billboard_data; // 72 0x48				// Data defining billboard properties. NULL for non-billboard meshes.

	D3DPRIMITIVETYPE		m_primitive_type; // 76 0x4C
	IndexBufferWrapper*		mp_index_buffer[MAX_INDEX_BUFFERS]; // +80 (0x50)
	//IDirect3DVertexBuffer8*	mp_vertex_buffer[MAX_VERTEX_BUFFERS];

	int						m_d3dusage; // 0x70

	float					m_bounding_sphere_nearest_z;	// Used for dynamic sorting during front-back block sorting.
	float					m_material_color_override[3]; // 0x78 / 0x7C / 0x80
	char					*mp_vc_wibble_data; // 132 0x84
	Mth::Matrix				*mp_transform; // 136 0x88

	int field_8C = 0;

	BYTE* p_rawdata;
	int m_biggest_index_used = -1;
	int m_lastRenderFrameCount = -1;
	int m_lastRenderFlags = 0;


	int m_tex_coord_pass = 0;
    int m_lastBiggestIndexUsed = 0;
    int m_num_vertices_raw; // set to m_num_vertices
    char* m_vertices_raw;
    int  m_num_vertice_edits;
    void* m_vertice_edits_raw;
    int field_B8;
    int field_BC;
    int field_C0;
    int field_C4;

	VertexBufferWrapper* mp_vertex_buffer[MAX_VERTEX_BUFFERS]; // 200 (0xC8)
};


void SetMeshScalingParameters( Nx::SMeshScalingParameters* pParams );
void DisableMeshScaling( void );
void ApplyMeshScaling( float* p_vertices, int num_verts );


} // namespace NxXbox

#endif // __MESH_H

