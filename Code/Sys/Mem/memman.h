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
**	File name:		core/sys/mem/memman.h									**
**																			**
*****************************************************************************/

#ifndef	__SYS_MEM_MEMMAN_H
#define	__SYS_MEM_MEMMAN_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#ifndef __CORE_DEFINES_H
#include <core/defines.h>
#endif
#include <core/singleton.h>
#include <core/list.h>


#include <sys\mem\region.h>
#include "heap.h"
#include "alloc.h"
//#ifndef __PLAT_XBOX__

#ifndef	__SYS_MEM_MEMPTR_H
#	include "memptr.h"
#endif
//#endif
#include "handle.h"

#if 0
#ifdef __PLAT_WN32__
#include "mem/wn32/p_memman.h"
#else
#ifdef __PLAT_NGPS__
#include "mem/ngps/p_memman.h"
#else
#ifdef __PLAT_NGC__
#include "mem/ngc/p_memman.h"
#else
#error Unsupported Platform
#endif
#endif
#endif
#endif

#ifndef KISAK_ORIGINAL_ALLOCATOR
// dummy stub classes
namespace Mem
{
	class  Record
	{
	public:
		Record(void) : m_count(0), m_peak(0) {}

		int		m_count;
		int		m_peak;

		Record& operator+=(int src){}
		Record& operator-=(int src){}

		const 	Record		operator++(int src){}
		const 	Record		operator--(int src){}
		Record& operator++(void){}
		Record& operator--(void){}

	};

	class Allocator
	{
	public:
		enum Direction
		{
			vBOTTOM_UP = +1,
			vTOP_DOWN = -1
		};
		class BlockHeader
		{
		public:
			static const uint sSize = 0x10;
			static BlockHeader* sRead(void* addy)
			{
				static BlockHeader head;
				return &head;
			}
			Allocator* mpAlloc;
			int fk;
		};
		Record			mUsedBlocks;
		Record			mFreeBlocks;
		Record			mUsedMem;
		Record			mFreeMem;
	};
	struct Region : public Allocator
	{
	public:
		int MemAvailable()
		{
			return INT_MAX / 2;
		}
		int dummy; 
	};
	struct AllocRegion : Region
	{
		AllocRegion(int wow)
		{
		}
		int fkyou;
	};
	struct Heap  : public Allocator
	{
		inline void PushContext()
		{
		}
		inline void PopContext()
		{
		}
		inline const char* GetName()
		{
			return "KISAKHEEP";
		}
		inline int LargestFreeBlock()
		{
			return 1;
		}
		int dummy;
		Region* mp_region;
	};
}
#endif

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

// redefine the standard memory library functions, so they give us errors


#define	NUM_PERM_SKATER_HEAPS	1
#define	NUM_SKATER_HEAPS		8
#define NUM_NAMED_HEAPS			4

#define		DEBUG_HEAP_SIZE				32767*1024		// 1K short of 32MB

		
namespace Pcs
{
	class Manager;
}

namespace Mem
{

/*****************************************************************************
**							     Type Defines								**
*****************************************************************************/
class CNamedHeapInfo
{
public:
	enum
	{
		vMAX_HEAP_NAME_LEN = 128
	};

	CNamedHeapInfo()
	{
		mp_region = NULL;
		mp_heap = NULL;
		m_name = 0;
		m_used = false;
	}

public:
	Region*		mp_region;
	Heap*		mp_heap;
	uint32		m_name;
	char		mp_heap_name[vMAX_HEAP_NAME_LEN];
	bool		m_used;
};

#ifdef KISAK_ORIGINAL_ALLOCATOR
extern Manager* sp_instance;

class Manager : public Spt::Class			
{
	
public:

	enum
	{
		vMAX_CONTEXT = 16,
		vMAX_HEAPS = 32
	};

	void						PushContext( Allocator* alloc );
	void						PopContext( void );

	void*						New( size_t size, bool assert_on_fail = true, Allocator* pAlloc = NULL );
	int							Available();
	void*						ReallocateDown( size_t newSize, void *pOld, Allocator* pAlloc = NULL );
	void*						ReallocateUp( size_t newSize, void *pOld, Allocator* pAlloc = NULL );
	void*						ReallocateShrink( size_t newSize, void *pOld, Allocator* pAlloc = NULL );
	void						Delete( void* pAddr );
	bool						Valid( void* pAddr );
	size_t						GetAllocSize( void* pAddr );
								
	Heap*						TopDownHeap( void ) 		{ return mp_top_heap; }
	Heap*						BottomUpHeap( void )  		{ return mp_bot_heap; }
	Heap*						FrontEndHeap( void ) 		{ return mp_frontend_heap; }
	Heap*						ScriptHeap( void ) 			{ return mp_script_heap; }
	Heap*						NetworkHeap( void ) 		{ return mp_network_heap; }
	Heap*						NetMiscHeap( void ) 		{ return mp_net_misc_heap; }
	Heap*						ProfilerHeap( void ) 		{ return mp_profiler_heap; }
	Heap*						DebugHeap( void ) 			{ return mp_debug_heap; }
	Heap*						SkaterHeap( int n ) 		{ return mp_skater_heap[n]; }
	Heap*						SkaterInfoHeap( ) 			{ return mp_skater_info_heap; }
	Heap*						SkaterGeomHeap( int n ) 	{ return mp_skater_geom_heap[n]; }
	Heap*						InternetTopDownHeap( void )	{ return mp_internet_top_heap; }
	Heap*						InternetBottomUpHeap( void ){ return mp_internet_bottom_heap; }
    Heap*						ThemeHeap( void )           { return mp_theme_heap; }
	Heap*						CutsceneTopDownHeap( void )	{ return mp_cutscene_top_heap; }
	Heap*						CutsceneBottomUpHeap( void ){ return mp_cutscene_bottom_heap; }
#ifdef __PLAT_NGC__
	Heap*						AudioHeap( void )			{ return mp_audio_heap; }
#endif	
	Heap*						NamedHeap( uint32 name, bool assertOnFail = true );

	void						RegisterPcsMemMan( Pcs::Manager* );

	/* Global versions for all memory allocations */
	void						PushMemoryMarker( uint32 uiID );
	void						PopMemoryMarker( uint32 uiID );

	static void					sSetUp( void );
	static void					sSetUpDebugHeap( void );
	
	static void					sCloseDown( void );
	static Manager&				sHandle( void );

	
	void 						InitOtherHeaps();
	void 						DeleteOtherHeaps();

	void						InitInternetHeap();
	void						DeleteInternetHeap();

	void						InitNetMiscHeap();
	void						DeleteNetMiscHeap();

	void						InitCutsceneHeap(int heap_size);
	void						DeleteCutsceneHeap();

	void						InitDebugHeap();

	void 						InitSkaterHeaps(int players);
	void 						DeleteSkaterHeaps();

	void						InitNamedHeap(uint32 name, uint32 size, const char* pHeapName);
	bool						DeleteNamedHeap(uint32 name, bool assertOnFail = true);
	
	const char*					GetHeapName( uint32 whichHeap );
	Heap *						GetHeap( uint32 whichHeap );

	Heap *						CreateHeap( Region* region, Mem::Allocator::Direction dir /*= Mem::Allocator::vBOTTOM_UP*/, char* p_name );//= "unknown heap" );
	void						RemoveHeap( Heap * pHeap); 
	Heap *						FirstHeap();
	Heap *						NextHeap(Heap * pHeap);
	

//	int 						GetContextNumber();
	char *						GetContextName();
	Allocator::Direction		GetContextDirection();
	Allocator*					GetContextAllocator();


								~Manager( void );
private :
								Manager( void );								   
																 
	Mem::Heap *					m_heap_list[vMAX_HEAPS]; 
	int							m_num_heaps;   							

	static char 				s_manager_buffer[];
	static char 				s_region_buffer[];
	static char 				s_debug_region_buffer[];
	static char 				s_script_region_buffer[];
	static char 				s_profiler_region_buffer[];
	static char 				s_debug_heap_buffer[];
	static char 				s_top_heap_buffer[];
	static char 				s_bot_heap_buffer[];
	static bool					s_initialized;
		
	class MemManContext
	{
	
		friend class Manager;
	
	private:
		Allocator*						mp_alloc;
	};


	Ptr< MemManContext > 		mp_context;

	// Mick: Contexts are now statically allocated off this 
	// array, rather than off the heap, as that was causing fragmentation
	// in rare but crash-worthy circumstances			
	MemManContext				m_contexts[vMAX_CONTEXT];
	int							m_pushed_context_count;


	Region*						mp_region;
	Heap*						mp_top_heap;
	Heap*						mp_bot_heap;
	
	Region*						mp_frontend_region;
	Heap*						mp_frontend_heap;

	Region*						mp_script_region;
	Heap*						mp_script_heap;

	Region*						mp_network_region;
	Heap*						mp_network_heap;

	Region*						mp_net_misc_region;
	Heap*						mp_net_misc_heap;

	Region*						mp_internet_region;
	Heap*						mp_internet_top_heap;
	Heap*						mp_internet_bottom_heap;

	Region*						mp_cutscene_region;
	Heap*						mp_cutscene_top_heap;
	Heap*						mp_cutscene_bottom_heap;

#ifdef __PLAT_NGC__
	Region*						mp_audio_region;
	Heap*						mp_audio_heap;
#endif		// __PLAT_NGC__

	Region*						mp_debug_region;
	Heap*						mp_debug_heap;

	Region*						mp_profiler_region;
	Heap*						mp_profiler_heap;

	Region*						mp_skater_region[NUM_SKATER_HEAPS];
	Heap*						mp_skater_heap[NUM_SKATER_HEAPS];
	
	Region*						mp_skater_geom_region[NUM_SKATER_HEAPS];
	Heap*						mp_skater_geom_heap[NUM_SKATER_HEAPS];

	CNamedHeapInfo				m_named_heap_info[NUM_NAMED_HEAPS];

	Region*						mp_skater_info_region;
	Heap*						mp_skater_info_heap;

    Region*						mp_theme_region;
	Heap*						mp_theme_heap;

	Pcs::Manager*				mp_process_man;
	uint						m_current_id;

protected:
	CNamedHeapInfo*				find_named_heap_info( uint32 name );
};
#else
class Manager : public Spt::Class
{

public:

	enum
	{
		vMAX_CONTEXT = 16,
		vMAX_HEAPS = 32
	};

	void						PushContext(Allocator* alloc)
	{}
	void						PopContext(void)
	{}

	inline void* New(size_t size, bool assert_on_fail = true, Allocator* pAlloc = NULL)
	{
		return ::malloc(size);
	}
	inline int							Available()
	{
		return INT_MAX / 2;
	}
	inline void* ReallocateDown(size_t newSize, void* pOld, Allocator* pAlloc = NULL)
	{
		return ::realloc(pOld, newSize);
	}
	inline void* ReallocateUp(size_t newSize, void* pOld, Allocator* pAlloc = NULL)
	{
		return ::realloc(pOld, newSize);
	}
	inline void* ReallocateShrink(size_t newSize, void* pOld, Allocator* pAlloc = NULL)
	{
		return ::realloc(pOld, newSize);
	}
	inline void						Delete(void* pAddr)
	{
		::free(pAddr);
	}
	inline bool						Valid(void* pAddr)
	{
		return false;
	}
	inline size_t						GetAllocSize(void* pAddr)
	{
#ifdef __PLAT_WN32__
		return _msize(pAddr);
#endif
	}

	Heap dummy;

	inline Heap* TopDownHeap(void) { return &dummy; }
	inline Heap* BottomUpHeap(void) { return &dummy; }
	inline Heap* FrontEndHeap(void) { return &dummy; }
	inline Heap* ScriptHeap(void) { return &dummy; }
	inline Heap* NetworkHeap(void) { return &dummy; }
	inline Heap* NetMiscHeap(void) { return &dummy; }
	inline Heap* ProfilerHeap(void) { return &dummy; }
	inline Heap* DebugHeap(void) { return &dummy; }
	inline Heap* SkaterHeap(int n) { return &dummy; }
	inline Heap* SkaterInfoHeap() { return &dummy; }
	inline Heap* SkaterGeomHeap(int n) { return &dummy; }
	inline Heap* InternetTopDownHeap(void) { return &dummy; }
	inline Heap* InternetBottomUpHeap(void) { return &dummy; }
	inline Heap* ThemeHeap(void) { return &dummy; }
	inline Heap* CutsceneTopDownHeap(void) { return &dummy; }
	inline Heap* CutsceneBottomUpHeap(void) { return &dummy; }
#ifdef __PLAT_NGC__
	Heap* AudioHeap(void) { return mp_audio_heap; }
#endif	
	inline Heap* NamedHeap(uint32 name, bool assertOnFail = true)
	{
		return NULL;
	}

	inline void						RegisterPcsMemMan(Pcs::Manager*)
	{}

	/* Global versions for all memory allocations */
	inline void						PushMemoryMarker(uint32 uiID)
	{}
	inline void						PopMemoryMarker(uint32 uiID)
	{}

	static void					sSetUp(void)
	{}
	static void					sSetUpDebugHeap(void)
	{}

	static void					sCloseDown(void)
	{}
	static Manager& sHandle(void);


	inline void 						InitOtherHeaps()
	{}
	inline void 						DeleteOtherHeaps()
	{}

	inline void						InitInternetHeap()
	{}
	inline void						DeleteInternetHeap()
	{}

	inline void						InitNetMiscHeap()
	{}
	inline void						DeleteNetMiscHeap()
	{}

	inline void						InitCutsceneHeap(int heap_size)
	{}
	inline void						DeleteCutsceneHeap()
	{}

	inline void						InitDebugHeap()
	{}

	inline void 						InitSkaterHeaps(int players)
	{}
	inline void 						DeleteSkaterHeaps()
	{}

	inline void						InitNamedHeap(uint32 name, uint32 size, const char* pHeapName)
	{}
	inline bool						DeleteNamedHeap(uint32 name, bool assertOnFail = true)
	{
		return true;
	}

	inline const char* GetHeapName(uint32 whichHeap)
	{
		return "KISAK";
	}
	inline Heap* GetHeap(uint32 whichHeap)
	{
		return &dummy;
	}

	inline Heap* CreateHeap(Region* region, Mem::Allocator::Direction dir /*= Mem::Allocator::vBOTTOM_UP*/, char* p_name)
	{
		return &dummy;
	}
	inline void						RemoveHeap(Heap* pHeap)
	{}
	inline Heap* FirstHeap()
	{
		return &dummy;
	}
	inline Heap* NextHeap(Heap* pHeap)
	{
		return &dummy;
	}


	//	int 						GetContextNumber();
	inline char* GetContextName()
	{
		return "KISAKCTX";
	}
	inline Allocator::Direction		GetContextDirection()
	{
		return (Allocator::Direction)0;
	}
	inline Allocator* GetContextAllocator()
	{
		return NULL;
	}


	~Manager(void)
	{
	}
	Manager(void)
	{
	}

	inline CNamedHeapInfo* find_named_heap_info(uint32 name)
	{
		return NULL;
	}

	//Ptr< MemManContext > 		mp_context;

	// Mick: Contexts are now statically allocated off this 
	// array, rather than off the heap, as that was causing fragmentation
	// in rare but crash-worthy circumstances			
	//MemManContext				m_contexts[vMAX_CONTEXT];
	int							m_pushed_context_count;


	Region* mp_region;
	Heap* mp_top_heap;
	Heap* mp_bot_heap;

	Region* mp_frontend_region;
	Heap* mp_frontend_heap;

	Region* mp_script_region;
	Heap* mp_script_heap;

	Region* mp_network_region;
	Heap* mp_network_heap;

	Region* mp_net_misc_region;
	Heap* mp_net_misc_heap;

	Region* mp_internet_region;
	Heap* mp_internet_top_heap;
	Heap* mp_internet_bottom_heap;

	Region* mp_cutscene_region;
	Heap* mp_cutscene_top_heap;
	Heap* mp_cutscene_bottom_heap;

#ifdef __PLAT_NGC__
	Region* mp_audio_region;
	Heap* mp_audio_heap;
#endif		// __PLAT_NGC__

	Region* mp_debug_region;
	Heap* mp_debug_heap;

	Region* mp_profiler_region;
	Heap* mp_profiler_heap;

	Region* mp_skater_region[NUM_SKATER_HEAPS];
	Heap* mp_skater_heap[NUM_SKATER_HEAPS];

	Region* mp_skater_geom_region[NUM_SKATER_HEAPS];
	Heap* mp_skater_geom_heap[NUM_SKATER_HEAPS];

	CNamedHeapInfo				m_named_heap_info[NUM_NAMED_HEAPS];

	Region* mp_skater_info_region;
	Heap* mp_skater_info_heap;

	Region* mp_theme_region;
	Heap* mp_theme_heap;

	Pcs::Manager* mp_process_man;
	uint						m_current_id;

};
extern "C"
{
	extern class Manager* sp_instance;
}
#endif

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


#ifdef KISAK_ORIGINAL_ALLOCATOR
extern "C"
{
int		Available();
void*	Malloc( size_t size );
void	Free( void* mem );
bool	Valid( void* pAddr );
size_t	GetAllocSize( void* pAddr );
void*	ReallocateDown( size_t newSize, void *pOld );
void*	ReallocateUp( size_t newSize, void *pOld );
void*	ReallocateShrink( size_t newSize, void *pOld );
void*	Realloc( void* mem, size_t newSize );
void*	Calloc( size_t numObj, size_t sizeObj );
}

void	PushMemProfile(char *p_type);
void	PopMemProfile();
void	DumpMemProfile(int level, char *p_type=NULL);
void	AllocMemProfile(Allocator::BlockHeader* p_block);
void	FreeMemProfile(Allocator::BlockHeader* p_block);

void	SetThreadSafe(bool safe);
bool	IsThreadSafe( void );
#else // KISAK_ORIGINAL_ALLOCATOR
extern "C"
{
	inline int		Available()
	{
		return INT_MAX / 2;
	}
	inline void* Malloc(size_t size)
	{
		return ::malloc(size);
	}
	inline void	Free(void* mem)
	{
		::free(mem);
	}
	inline bool	Valid(void* pAddr)
	{
		return false; 
	}
	inline size_t	GetAllocSize(void* pAddr)
	{
#ifdef __PLAT_WN32__
		return _msize(pAddr);
#endif
	}
	inline void* ReallocateDown(size_t newSize, void* pOld)
	{
		__debugbreak();
		return ::realloc(pOld, newSize);
	}
	inline void* ReallocateUp(size_t newSize, void* pOld)
	{
		__debugbreak();
		return ::realloc(pOld, newSize);
	}
	inline void* ReallocateShrink(size_t newSize, void* pOld)
	{
		__debugbreak();
		return ::realloc(pOld, newSize);
	}
	inline void* Realloc(void* mem, size_t newSize)
	{
		return ::realloc(mem, newSize);
	}
	inline void* Calloc(size_t numObj, size_t sizeObj)
	{
		return ::malloc(numObj * sizeObj);
	}
}

inline void	PushMemProfile(char* p_type)
{}
inline void	PopMemProfile()
{}
inline void	DumpMemProfile(int level, char* p_type = NULL)
{}
inline void	AllocMemProfile(Allocator::BlockHeader* p_block)
{}
inline void	FreeMemProfile(Allocator::BlockHeader* p_block)
{}
inline void	SetThreadSafe(bool safe)
{}
inline bool	IsThreadSafe(void)
{
	return false;
}

#endif // KISAK_ORIGINAL_ALLOCATOR 




/*****************************************************************************
**								Inline Functions							**
*****************************************************************************/

inline Manager&	Manager::sHandle( void )
{
	//Dbg_AssertType( sp_instance, Manager );
	if (!sp_instance)
	{
		Mem::Manager::sSetUp();
	}
	return *sp_instance;
}


} // namespace Mem


// Some debug functions
bool dump_open(const char *name);
void dump_printf(char *p);
void dump_close();
extern int dumping_printfs;



#endif  // __SYS_MEM_MEMMAN_H
