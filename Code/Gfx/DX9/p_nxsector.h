#ifndef	__GFX_P_NX_SECTOR_H__
#define	__GFX_P_NX_SECTOR_H__

#include 	<core/allmath.h>
#include 	<core\math\geometry.h>
#include 	"gfx\NxSector.h"
#include 	"gfx\Image\ImageBasic.h"

#include 	"gfx\DX9/p_nxscene.h"
#include 	"gfx\DX9/nx\mesh.h"

namespace Nx
{

/////////////////////////////////////////////////////////////////////////////////////
// Private classes
//
// Here's a machine specific implementation of the CSector
class CXboxSector : public CSector
{
public:
									CXboxSector();

	bool							LoadFromFile( void* p_file, NxXbox::VertexMysteryMeat* p_meat, const char* debug_name = NULL); // lwss: add debug name
	bool							LoadFromMemory( void **p_mem );

	NxXbox::sScene					*GenerateScene( void );
	
	private:						// It's all private, as it is machine specific
	virtual void					plat_set_color( Image::RGBA rgba );
	virtual void					plat_clear_color( void );
	virtual void					plat_set_visibility( uint32 mask );
	virtual void					plat_set_active( bool on );
	virtual void					plat_set_world_position( const Mth::Vector& pos );
	virtual const Mth::CBBox		&plat_get_bounding_box( void ) const;
	virtual const Mth::Vector		&plat_get_world_position( void ) const;
	virtual void					plat_set_shatter( bool on );
	virtual CSector					*plat_clone( bool instance, CScene *p_scene = NULL );

	int								m_flags; // 0x2C

	Mth::Vector						m_pos_offset;

	Image::RGBA						m_rgba;

// lwss Add
private:
	bool Load_Internal(void*& p_stream, bool is_file, NxXbox::VertexMysteryMeat* p_meat = NULL, const char* debug_name = NULL);
// lwss end
};

} // Namespace Nx  			

#endif