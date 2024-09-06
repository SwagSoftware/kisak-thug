/*****************************************************************************
**																			**
**			              Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		SYS Library												**
**																			**
**	Module:			Timer (TMR)			 									**
**																			**
**	File name:		ngps/p_timer.cpp										**
**																			**
**	Created by:		09/25/00	-	dc										**
**																			**
**	Description:	XBox System Timer										**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <windows.h>
#include <mmsystem.h>
#include <time.h>
#include <sys/timer.h>
#include <Sys/Config/config.h>

/*****************************************************************************
**							  DBG Information								**
*****************************************************************************/

int g_timerInfoCurrentRenderBuffer = 0;

namespace Tmr 
{
	static volatile uint64	s_count;

#define	vSMOOTH_N  4	

	static volatile uint64	s_vblank = 0;
	static volatile uint64	s_total_vblanks = 0;
	static float			s_slomo = 1.0f;
	static uint64			s_render_frame = 0;
	static uint64			s_stored_vblank = 0;
	static volatile bool	s_vsync_handler_installed = false;
	static volatile bool	s_swap_handler_installed = false;

	static clock_t			high_count;
	static clock_t			start_count;
	static __int64			high_count_high_precision;
	static __int64			start_count_high_precision;

	static uint64 GetGameVblanks();

	struct STimerInfo
	{
		float	render_length;
		double	uncapped_render_length;
		int		render_buffer[vSMOOTH_N];
		uint64	render_vblank;
		uint64	render_last_vblank;
		int		render_index;
	};

	static STimerInfo gTimerInfo;
	static STimerInfo gStoredTimerInfo;
	static float xrate = 60.0f;

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

//static clock_t			start_count;

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************

Manager::Manager ( void )
{
	Dbg_MemberFunction;
	
	// Set the start count.
	start_count = timeGetTime();	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************

Manager::~Manager ( void )
{
	Dbg_MemberFunction;    
}

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/
 
Time GetTime ( void )
{
#ifdef KISAK_ORIGINAL_TIMECODE
	return timeGetTime(); 
#endif
	return (Time)(1000.0 / xrate * (double)(unsigned int)s_vblank);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
 
MicroSeconds GetTimeInUSeconds( void )
{
	return timeGetTime() * 1000;
}

float FrameLength()
{
#ifdef KISAK_ORIGINAL_TIMECODE
	return 16;
#endif
	return s_slomo * (1.0f / 60.f);
}

//static void __cdecl s_vsync_handler(D3DVBLANKDATA* pData)
//{
//	// inc vblanks    
//	s_vblank++;
//	s_total_vblanks++;
//}

static void InitTimerInfo(void)
{
	static bool xrate_set = false;

	if (!xrate_set)
	{
		xrate = (float)Config::FPS();
		xrate_set = true;
	}

	gTimerInfo.render_length = 0.01666666f;		// defualt to 1/60th
	gTimerInfo.uncapped_render_length = 0.01666666f;		// defualt to 1/60th
	for (int i = 0; i < vSMOOTH_N; i++)
	{
		gTimerInfo.render_buffer[i] = 1;
	}
	gTimerInfo.render_vblank = 0;
	gTimerInfo.render_last_vblank = 0;
	gTimerInfo.render_index = 0;

	gStoredTimerInfo = gTimerInfo;

	s_stored_vblank = 0;
	s_vblank = 0;
}

__int64 __declspec(naked) __stdcall getCycles(void)
{
	_asm
	{
		rdtsc
		ret
	}
}
void Init(void)
{
	InitTimerInfo();

	s_count = 0;
	start_count = clock();
	high_count = (clock_t)0;
	start_count_high_precision = getCycles();
	high_count_high_precision = (__int64)0;
}

void SetSlomo(float slomo)
{
	s_slomo = slomo;
}

void VSync(void)
{
	uint64 now = GetVblanks();
	while (now == GetVblanks());
}

double UncappedFrameLength()
{
	return gTimerInfo.uncapped_render_length / xrate;
}
// lwss add
void PreUpdateTimerInfo()
{
	gTimerInfo.render_last_vblank = gTimerInfo.render_vblank;
	gTimerInfo.render_index = gTimerInfo.render_last_vblank;
	//++qword_7CC878; // KISAKTODO: figure this
	gTimerInfo.render_last_vblank = s_vblank;
	gTimerInfo.render_buffer[++g_timerInfoCurrentRenderBuffer] = s_vblank - gTimerInfo.render_last_vblank;

	//if (g_timerInfoCurrentRenderBuffer >= 4)
	//{
	//	g_timerInfoCurrentRenderBuffer = 0;
	//}
	g_timerInfoCurrentRenderBuffer = g_timerInfoCurrentRenderBuffer % 4;
}
// lwss end
void OncePerRender(void)
{
#	ifdef STOPWATCH_STUFF
	Script::IncrementStopwatchFrameIndices();
	Script::DumpFunctionTimes();
	Script::ResetFunctionCounts();
#	endif

	int total = 0;
	int uncapped_total = 0;

	for (int i = 0; i < vSMOOTH_N; ++i)
	{
		int diff = gTimerInfo.render_buffer[i];
		uncapped_total += diff;

		// Handle very bad values.
		if (diff > 10 || diff < 0)
		{
			diff = 1;
		}

		// Clamp to 4.
		if (diff > 4)
		{
			diff = 4;
		}
		total += diff;
	}

	gTimerInfo.render_length = (float)total / (float)vSMOOTH_N;

	if (gTimerInfo.render_length < 1.0f)
	{
		gTimerInfo.render_length = 1.0f;
	}

	gTimerInfo.uncapped_render_length = (double)uncapped_total / (double)vSMOOTH_N;
}

void DeInit(void)
{
}

// when pausing the game, call this to store the current state of OncePerRender( ) (only essential in replay mode)
void StoreTimerInfo(void)
{
}

void RecallTimerInfo(void)
{
}


void Vblank(void)
{
	s_total_vblanks++;
	s_vblank++;
}

uint64 GetVblanks(void)
{
	return s_total_vblanks;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Tmr
