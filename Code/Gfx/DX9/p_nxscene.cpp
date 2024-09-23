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
void CXboxScene::plat_post_load(NxXbox::VertexMysteryMeat* p_meat)
{
	// LWSS add
	if (p_meat)
	{
		if (D3D_OK != D3DDevice_CreateVertexBuffer(p_meat->length, 8, 0, D3DPOOL_DEFAULT, &p_meat->vertexBuffer, 0))
		{
			__debugbreak();
		}
		p_meat->vertexBuffer->Lock(0, 0, &p_meat->lockedPtr, 0);
		p_meat->streamOffset = 0;
		this->p_vertex_buffer = p_meat->vertexBuffer;
		this->p_vertex_buffer_len = p_meat->length;
	}
	// LWSS end
	 
	
	// Now turn the temporary mesh lists into mesh arrays.
	mp_sector_table->IterateStart();
	CSector* pSector = mp_sector_table->IterateNext();
	while( pSector )
	{
		CXboxGeom *p_xbox_geom = static_cast<CXboxGeom*>(pSector->GetGeom());

		p_xbox_geom->CreateMeshArray(p_meat);

		// First time through we just want to count the meshes,
		p_xbox_geom->RegisterMeshArray( true );

		pSector = mp_sector_table->IterateNext();
	}

	// LWSS add
	if (p_meat)
	{
		p_meat->vertexBuffer->Unlock();
		p_meat->lockedPtr = NULL;
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
				
				
