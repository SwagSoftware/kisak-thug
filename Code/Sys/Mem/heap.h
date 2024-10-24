/*****************************************************************************
**																			**
**			              Neversoft Entertainment	                        **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Sys Library												**
**																			**
**	Module:			Memory Manager (Mem)									**
**																			**
**	Created:		03/20/00	-	mjb										**
**																			**
**	File name:		core/sys/mem/heap.h										**
**																			**
*****************************************************************************/

#ifndef	__SYS_MEM_HEAP_H
#define	__SYS_MEM_HEAP_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#ifndef __CORE_DEFINES_H
#include <core/defines.h>
#endif
#include "alloc.h"

#ifdef KISAK_ORIGINAL_ALLOCATOR
/*****************************************************************************
**								   Defines									**
*****************************************************************************/

namespace Mem
{



/*****************************************************************************
**							     Type Defines								**
*****************************************************************************/

class Region;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
class  Heap : public  Allocator 			
{
	
	
	friend class Manager;

public :
		
								Heap( Region* region, Direction dir = vBOTTOM_UP, char* p_name = "unknown heap" );

	int							LargestFreeBlock();
	
private :
	
	virtual		void*			allocate( size_t size, bool assert_on_fail );
	virtual		void			free( BlockHeader* pHeader );

	virtual		int				available();
	virtual		void* 			reallocate_down( size_t new_size, void *pOld );
	virtual		void*			reallocate_up( size_t newSize, void *pOld );
	virtual		void*			reallocate_shrink( size_t newSize, void *pOld );
	
				
				BlockHeader*	next_addr( BlockHeader* pHeader );
};


/*****************************************************************************
**							 Private Declarations							**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							  Public Declarations							**
*****************************************************************************/

/*****************************************************************************
**							   Public Prototypes							**
*****************************************************************************/

/*****************************************************************************
**								Inline Functions							**
*****************************************************************************/

} // namespace Mem

#endif  // KISAK_ORIGINAL_ALLOCATOR
#endif  // __SYS_MEM_HEAP_H
