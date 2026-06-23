///////////////////////////////////////////////////////////////////////////////
// p_NxScene.h

#ifndef	__GFX_P_NX_SCENE_H__
#define	__GFX_P_NX_SCENE_H__

#include "Gfx/Nx.h"
#include "gfx/DX9/nx/scene.h"

namespace Nx
{

/////////////////////////////////////////////////////////////////////////////////////
// Private classes
//
// Here's a machine specific implementation of the CScene
class	CXboxScene : public CScene
{
public:

								CXboxScene( int sector_table_size = 10 );
	NxXbox::sScene *			GetEngineScene() const						{ return mp_engine_scene; }
	void						SetEngineScene( NxXbox::sScene *p_scene )	{ mp_engine_scene = p_scene; }
	void						DestroySectorMeshes( void );

	// lwss add: device-Reset support. The scene owns one shared D3DPOOL_DEFAULT vertex
	// buffer that all of its meshes' wrappers point into. On a device Reset it must be
	// released and recreated; the per-mesh wrappers re-upload their slices from their
	// CPU shadow copies (see D3D_ReCreateBuffers / VertexBufferWrapper::ReInitD3DBuffer).
	void						ReleaseDeviceVertexBuffer( void );
	void						RecreateDeviceVertexBuffer( void );
	// lwss end

private:		// It's all private, as it is machine specific
#ifdef __PLAT_WN32__
	virtual void				plat_post_load(void* p_meat = NULL);
#else
	void						plat_post_load();
#endif
	virtual bool				plat_load_textures( const char *p_name );	// load textures 
	virtual bool				plat_load_collision( const char *p_name );	// load collision data
	virtual bool				plat_unload_add_scene( void );
	virtual	CSector	*			plat_create_sector();	 					// empty sector


	NxXbox::sScene				*mp_engine_scene; // 0x280
	// lwss add: new for PC
	IDirect3DVertexBuffer9* p_vertex_buffer;
	int p_vertex_buffer_len;
	// lwss end
};

} // Namespace Nx  			

#endif
