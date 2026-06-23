///////////////////////////////////////////////////////////////////////////////
// p_NxScene.cpp

#include 	"gfx/DX9/p_NxScene.h"
#include 	"gfx/DX9/p_NxSector.h"
#include 	"gfx/DX9/p_NxGeom.h"

namespace Nx
{


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxScene::CXboxScene( int sector_table_size ) : CScene( sector_table_size )
{
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxScene::DestroySectorMeshes( void )
{
	// Iterate through the list of sectors, removing each one in turn, and requesting the engine to
	// remove the meshes.
	mp_sector_table->IterateStart();
	CSector* pSector = mp_sector_table->IterateNext();
	while( pSector )
	{
		// Access platform dependent data.
		CXboxSector* pXboxSector = static_cast<CXboxSector *>(pSector);

		// Remove this mesh array from the engine.
//		pXboxSector->DestroyMeshArray();

		pSector = mp_sector_table->IterateNext();
	}
}



/////////////////////////////////////////////////////////////////////////////////////
// Private classes
//
// Here's a machine specific implementation of the CScene

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxScene::plat_post_load(void* p_meat)
{
	// LWSS add
	if (p_meat)
	{
		NxXbox::VertexMysteryMeat* meat = (NxXbox::VertexMysteryMeat*)p_meat;
		Dbg_Assert(D3D_OK == D3DDevice_CreateVertexBuffer(meat->length, 8, 0, D3DPOOL_DEFAULT, &meat->vertexBuffer, 0));
		meat->vertexBuffer->Lock(0, 0, &meat->lockedPtr, 0);
		meat->streamOffset = 0;
		this->p_vertex_buffer = meat->vertexBuffer;
		this->p_vertex_buffer_len = meat->length;
	}
	// LWSS end
	 
	
	// Now turn the temporary mesh lists into mesh arrays.
	mp_sector_table->IterateStart();
	CSector* pSector = mp_sector_table->IterateNext();
	while( pSector )
	{
		CXboxGeom *p_xbox_geom = static_cast<CXboxGeom*>(pSector->GetGeom());

		p_xbox_geom->CreateMeshArray((NxXbox::VertexMysteryMeat *)p_meat);

		// First time through we just want to count the meshes,
		p_xbox_geom->RegisterMeshArray( true );

		pSector = mp_sector_table->IterateNext();
	}

	// LWSS add
	if (p_meat)
	{
		NxXbox::VertexMysteryMeat* meat = (NxXbox::VertexMysteryMeat*)p_meat;
		meat->vertexBuffer->Unlock();
		meat->lockedPtr = NULL;
	}
	// LWSS end

	// Now we have counted all the meshes, tell the engine to create the arrays to hold them.
	GetEngineScene()->CreateMeshArrays();
	
	// Now go through and actually add the meshes.
	mp_sector_table->IterateStart();
	pSector = mp_sector_table->IterateNext();
	while( pSector )
	{
		// Access platform dependent data.
		CXboxGeom *p_xbox_geom = static_cast<CXboxGeom*>(pSector->GetGeom());

		p_xbox_geom->RegisterMeshArray( false );

		pSector = mp_sector_table->IterateNext();
	}

	// Now all meshes are registered, tell the engine to sort them.
	GetEngineScene()->SortMeshes();
}

/******************************************************************/
/*                                                                */
/* Device-Reset support.                                          */
/*                                                                */
/* The scene holds the final reference to its shared vertex       */
/* buffer (each mesh wrapper that points into it AddRef()'d a     */
/* copy). Those wrapper references are dropped first by            */
/* D3D_ResetBuffers; this drops the scene's own one so the        */
/* D3DPOOL_DEFAULT buffer is fully released before Reset().       */
/*                                                                */
/******************************************************************/
void CXboxScene::ReleaseDeviceVertexBuffer( void )
{
	if (p_vertex_buffer)
	{
		p_vertex_buffer->Release();
		p_vertex_buffer = NULL;
	}
}

/******************************************************************/
/*                                                                */
/* Recreate the shared buffer after Reset() and re-point every    */
/* mesh wrapper that shares it at the new buffer. The generic     */
/* ReInitD3DBuffer() pass (D3D_ReCreateBuffers) then AddRef()s    */
/* and re-uploads each mesh's slice from its CPU shadow, exactly  */
/* as sMesh::sub_4B3A90 does at load time. Must run BEFORE that   */
/* pass.                                                          */
/*                                                                */
/******************************************************************/
void CXboxScene::RecreateDeviceVertexBuffer( void )
{
	if (p_vertex_buffer_len <= 0)
		return;		// scene has no shared vertex buffer (e.g. instanced/cloned scenes)

	IDirect3DVertexBuffer9* p_new_buffer = NULL;
	HRESULT hr = D3DDevice_CreateVertexBuffer(p_vertex_buffer_len, D3DUSAGE_WRITEONLY, 0, D3DPOOL_DEFAULT, &p_new_buffer, 0);
	Dbg_Assert(hr == D3D_OK);
	if (hr != D3D_OK)
		return;

	p_vertex_buffer = p_new_buffer;

	NxXbox::sScene* p_engine = mp_engine_scene;
	if (p_engine)
	{
		for (int m = 0; m < p_engine->m_num_mesh_entries; m++)
		{
			NxXbox::sMesh* p_mesh = p_engine->m_meshes[m];
			if (!p_mesh)
				continue;

			NxXbox::VertexBufferWrapper* p_wrapper = p_mesh->mp_vertex_buffer[0];
			// Only wrappers that share the scene buffer (created without their own
			// buffer) need re-pointing; standalone wrappers recreate themselves.
			if (p_wrapper && (p_wrapper->vertexWrapperCreationFlags & FLAG_NO_CREATE_VERTEX_BUFFER))
			{
				p_wrapper->vertexBuffer = p_new_buffer;
			}
		}
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxScene::plat_load_textures(const char* p_name)
{
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxScene::plat_load_collision(const char* p_name)
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxScene::plat_unload_add_scene( void )
{
	// Not sure what this is supposed to do, but added for now to remove annoying stub output.
	return false;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// Create an empty sector
CSector	*CXboxScene::plat_create_sector()
{
	CXboxSector *p_xbox_sector	= new CXboxSector();
	return p_xbox_sector;
}



} // Namespace Nx  			
				
				
