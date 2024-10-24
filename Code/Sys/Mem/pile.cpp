/*****************************************************************************
**																			**
**			              Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		System Library											**
**																			**
**	Module:			Memory (Mem) 											**
**																			**
**	File name:		pile.cpp												**
**																			**
**	Created by:		03/20/00	-	mjb										**
**																			**
**	Description:	Pile class												**
**																			**
*****************************************************************************/

#ifdef KISAK_ORIGINAL_ALLOCATOR

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <core/defines.h>
#include "pile.h"
#include <sys\mem\region.h>

/*****************************************************************************
**							  DBG Information								**
*****************************************************************************/


namespace Mem
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

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

void*	Pile::allocate( size_t size, bool assert_on_fail )
{
	
		
#ifdef __PLAT_NGC__
	size = (uint)nAlignUpBy( size, 5 );
#else
	size = (uint)nAlignUpBy( size, 4 );
#endif
	
	BlockHeader* p_header = (BlockHeader*)mp_region->Allocate( this, size + BlockHeader::sSize, assert_on_fail );

	if ( p_header )
	{
		new ((void*)p_header) BlockHeader( this, size ); 

		Dbg_Code 
		(
			m_alloc_count++;
		)
	}
	else if ( assert_on_fail )
	{
		Dbg_MsgAssert ( false,( "Failed to allocate %d bytes", size ));
	}

	MemDbg_AllocateBlock ( p_header );	
	
	return (void*)((uint)p_header + BlockHeader::sSize);

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void	Pile::free( BlockHeader* pHeader )
{
	
	
	MemDbg_FreeBlock ( pHeader );	

	pHeader->~BlockHeader();

	Dbg_Code 
	(
		Dbg_MsgAssert(( m_alloc_count > 0 ),( "Internal Error - freed too many blocks!!" ));
		m_alloc_count--;
	)
}

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

Pile::Pile( Region* region, Direction dir )
: Allocator( region, dir, "Pile" )
{
	
	
	mp_base = mp_top;

	Dbg_Code
	(
		m_depth = 0;
	)
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Pile::~Pile( void )
{
	

	Dbg_Code
	(
		Dbg_MsgAssert(( m_depth == 0 ),( "Context Stack not empty (%d items)", m_depth ));
	
		// warn if there are still allocations.
		Dbg_MsgAssert(( m_alloc_count == 0 ),( "Pile still contains allocations" ));
	)

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void 	Pile::PushContext( void )
{
	

	void** p_top = (void**)mp_top;
	*p_top = mp_base;
	mp_base = p_top;
	mp_top = p_top + m_dir;
	
	Dbg_Code
	(
		m_depth++;
	)
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void	Pile::PopContext( void )
{
	
		
	Dbg_Code
	(
		Dbg_MsgAssert( m_depth > 0,( "Context stack underflow" ));
		m_depth--;
	)

	mp_top = mp_base;
	mp_base = *(void**)mp_top;
	mp_top = (void*)( (void**)(mp_top) + m_dir );

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Mem

#endif // KISAK_ORIGINAL_ALLOCATOR