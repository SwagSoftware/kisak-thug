/*****************************************************************************
**																			**
**			              Neversoft Entertainment			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		GEL (Game Engine Library)								**
**																			**
**	Module:			Main Loop (ML) 											**
**																			**
**	File name:		mainloop.cpp											**
**																			**
**	Created:		05/27/99	-	mjb										**
**																			**
**	Description:	Main loop and support code								**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <gel/mainloop.h>

#include <core/defines.h>
#include <core/singleton.h>
#include <core/task.h>

#include <gfx/nx.h>
#include <gfx/NxViewMan.h>
#include <sys/mem/memman.h>

#ifndef __PLAT_WN32__
    #include <sys/profiler.h>
#else
	#include <Core/Defines_IDA.h>
#endif

#include <gel/scripting/symboltable.h>

#ifdef	__PLAT_NGPS__
    #include <gel/collision/batchtricoll.h>
    #include <gel/soundfx/ngps/p_sfx.h>

    namespace NxPs2
    {
        void	WaitForRendering();
		void 	StuffAfterGSFinished();
    }
#endif

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

Dbg_DefineProject( GEL, "GEL Library" )

// lwss add
#ifdef __PLAT_WN32__
void Win32_ApplyInputs();
void Win32_ProcessMsgPump();
void Win32_GameNetUpdate();

void D3D_ResetTextures();
void D3D_ResetBuffers();
void D3D_ReleaseRenderSurfaces();

void D3D_ReCreateTextures();
void D3D_ReCreateBuffers();
void D3D_RecreateRenderSurfaces();
#endif
// lwss end

// blops add
#ifdef __PLAT_WN32__
extern "C" float g_render_interp_alpha;
extern "C" bool  g_render_interp_enabled;
#endif
// blops end

namespace Mdl
{
	void	Rail_DebugRender();			// for debugging
}

namespace Mlp
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

DefineSingletonClass( Manager, "Main Loop Manager" );

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/


/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/


/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

Manager::Manager( void )
{
	
	
	start_render_hook = NULL;
	end_render_hook = NULL;
	done = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Manager::~Manager( void )
{
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void		Manager::service_system( void )
{
	

#ifndef __PLAT_WN32__
#	ifdef __USE_PROFILER__
	Sys::CPUProfiler->PushContext( 255, 0, 0 );
#	endif // __USE_PROFILER__
#endif

	system_task_stack.Process (currently_profiling);

#ifndef __PLAT_WN32__
#	ifdef __USE_PROFILER__
	Sys::CPUProfiler->PopContext();
#	endif // __USE_PROFILER__
#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void		Manager::game_logic( void )
{
	
	
#ifndef __PLAT_WN32__
#	ifdef __USE_PROFILER__
	Sys::CPUProfiler->PushContext( 0, 255, 0 );
#	endif // __USE_PROFILER__
#endif

//	printf ("\nTiming Logic\n"); 
	logic_task_stack.Process(currently_profiling);

//	printf ("\nDumping Task List\n\n");	
//	logic_task_stack.Dump();

#ifndef __PLAT_WN32__
#	ifdef __USE_PROFILER__
	Sys::CPUProfiler->PopContext();
#	endif // __USE_PROFILER__
#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	void		Manager::render_frame( void )
{
	
	
//	printf ("############################## render_frame #############################\n");	
	

#ifndef __PLAT_WN32__
#	ifdef __USE_PROFILER__
	Sys::CPUProfiler->PushContext( 0, 0, 255 );
#	endif // __USE_PROFILER__
#endif

#	ifdef __PLAT_NGC__
	if( start_render_hook )
	{
		start_render_hook->Call();
	}
	if( !display_tasks_paused )
	{
		display_task_stack.Process( currently_profiling );
	}
#	else
	if (!display_tasks_paused)
	{
		// If paused don't call the start_render_hook
		// as this clears the none-visible frame buffer
		// which will result in a flash when display is unpaused
		if ( start_render_hook )			// set up for rendering
		{
			start_render_hook->Call();
		}

//		printf ("\nTiming render\n"); 
	
		display_task_stack.Process(currently_profiling);		// service rendering routines
	}
#	endif // __PLAT_NGC__
	
#ifndef __PLAT_WN32__
#	ifdef __USE_PROFILER__
	Sys::CPUProfiler->PopContext();
	Sys::CPUProfiler->PushContext( 255, 255, 0 );
#	endif // __USE_PROFILER__
#endif

	if ( end_render_hook )				// end rendering
	{
		end_render_hook->Call();
	}
#ifndef __PLAT_WN32__
#	ifdef __USE_PROFILER__
	Sys::CPUProfiler->PopContext();
#	endif // __USE_PROFILER__
#endif
}

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

void		Manager::MainLoop( void )
{
	bool old_flag = done;	// push the current done flag

	done = false;

// lwss add
#ifdef __PLAT_WN32__
	void* timeout;
	SystemParametersInfoA(SPI_GETSCREENSAVETIMEOUT, 0, &timeout, 0);
	LARGE_INTEGER frequency;
	QueryPerformanceFrequency(&frequency);

	int v3 = (frequency.QuadPart / 60) >> 32;
	DWORD v4 = (frequency.QuadPart / 60);

	LARGE_INTEGER perf;
	QueryPerformanceCounter(&perf);

	int v12 = 0;
	while (true)
	{
		// g_debugMeshSubmitCounter = 0; // optional

		if (timeout)
		{
			if (v12++ >= 200)
			{
				v12 = 0;
				SystemParametersInfoA(SPI_SETSCREENSAVETIMEOUT, (UINT)timeout, 0, 0); // KISAKTODO: check logic here...
			}
		}
		NxXbox::g_disableRendering = false;
		Win32_ApplyInputs();
		Win32_ProcessMsgPump();
		Win32_GameNetUpdate();

		if (g_isWindowInFocus)
		{
			break;
		}

		if (g_hasJustEnteredNetworkGame)
		{
			NxXbox::g_disableRendering = true;
			break;
		}

		do
		{
			Sleep(100u);
			Win32_ProcessMsgPump();
		} while (!g_isWindowInFocus);

		if (done)
		{
			done = old_flag;
			return;
		}
	}

#endif

	while ( !done )
	{
// lwss Add
#ifdef __PLAT_WN32__
		//if (g_windowJustWentOutOfFocus)
		//{
		//	if (D3DDevice_TestCooperativeLevel() != D3DERR_DEVICELOST)
		//	{
		//		D3D_ResetTextures();
		//		D3D_ResetBuffers();
		//		D3D_ReleaseRenderSurfaces();
		//		if (D3DDevice_Reset(&NxXbox::EngineGlobals.params) >= 0)
		//		{
		//			D3D_ReCreateTextures();
		//			D3D_ReCreateBuffers();
		//			D3D_RecreateRenderSurfaces();
		//			g_windowJustWentOutOfFocus = false;
		//		}
		//	}
		//	//NxXbox::g_disableRendering = true;
		//}

		// blops add
		static LONGLONG s_sim_accumulator = 0;	// QPC ticks of real time not yet consumed by a sim step
		const LONGLONG sim_ticks = frequency.QuadPart / 60;	// QPC ticks per fixed 1/60 s sim step

		LARGE_INTEGER perfcount;
		QueryPerformanceCounter(&perfcount);

		LONGLONG elapsed = perfcount.QuadPart - perf.QuadPart;	// real time since previous loop iteration
		perf.QuadPart = perfcount.QuadPart;
		if (elapsed < 0)
		{
			elapsed = 0;	// QPC went backwards (rare); skip this interval
		}
		s_sim_accumulator += elapsed;

		int num_sim_steps = (int)(s_sim_accumulator / sim_ticks);

		// Spiral-of-death guard: cap how many sim steps one render may drive. If we
		// fall further behind, drop the backlog and degrade to slow-mo rather than
		// spin forever (mirrors the old ~20-frame resync clamp).
		const int MAX_SIM_STEPS = 5;
		if (num_sim_steps > MAX_SIM_STEPS)
		{
			num_sim_steps = MAX_SIM_STEPS;
			s_sim_accumulator = 0;
		}
		else
		{
			s_sim_accumulator -= (LONGLONG)num_sim_steps * sim_ticks;
		}

		g_render_interp_alpha = g_render_interp_enabled
			? (float)( (double)s_sim_accumulator / (double)sim_ticks )
			: 1.0f;

		(void)v3;
		(void)v4;
		// blops: Moved Tmr::VBlank() into the sim-step, sim clock runs at 60hz regardless of render

#endif
// lwss end
		if (trigger_profiling)
		{
			printf ("\nProfiling.....Start of main loop\n\n");
			trigger_profiling--;
			currently_profiling = 1;
		}
		

//#ifndef __PLAT_WN32__

#ifdef	__PLAT_NGPS__		
// for profiling on the PS2, we do a bit of the code from sPreRender here
// so we can time the final waiting for GS		
#	ifdef __USE_PROFILER__
		Sys::CPUProfiler->PushContext( 0,0,255 );		// blue = wait for VU/DMA/GPU to finish
#	endif		
		NxPs2::WaitForRendering();		// PS2 Specific, wait for prior frame's DMA to finish	
		NxPs2::StuffAfterGSFinished();		// PS2 Specific, DMA altering stuff run after previous frame's DMA finished
#	ifdef __USE_PROFILER__
		Sys::CPUProfiler->PopContext(  );
		Sys::CPUProfiler->PushContext( 128,0,0 );		// red = wait for vblank
#	endif		
		int framerate = Script::GetInteger(0x3214c818/*"lock_framerate"*/);
		if (framerate)	// normal vsync
		{
			static uint64 next_vblanks= 0;
			// Still call VSync, as it updates some functions
			Tmr::VSync();
			while (Tmr::GetVblanks()<next_vblanks)
			{
				// just hanging until vblanks gets big enough
			}
			next_vblanks = Tmr::GetVblanks() + framerate;
		}
		else
		{
			Tmr::VSync1();
		}
#	ifdef __USE_PROFILER__
		Sys::CPUProfiler->PopContext(  );
#	endif		
#endif				
#ifndef	__PLAT_NGC__		
#	ifdef __USE_PROFILER__
		Sys::Profiler::sStartFrame();		  		
#	endif		
#endif		
#ifdef __PLAT_WN32__
		if (!NxXbox::g_disableRendering)
#endif
		{
			Nx::CEngine::sPreRender();			 			// start rendering previous frame's DMA list
		}

#ifdef	__PLAT_NGPS__		
		Sfx::CSpuManager::sUpdateStatus();				// Garrett: This should go into some system task, but I'll put it here for now
#endif

//		Sys::Profiler::sStartFrame();		  		
//#endif

#ifdef	__PLAT_NGC__		
#	ifdef __USE_PROFILER__
		Sys::Profiler::sStartFrame();		  		
#	endif		
#	endif		
					 
#ifdef __PLAT_WN32__
		for (int sim_step = 0; sim_step < num_sim_steps; ++sim_step)
		{
			Tmr::Vblank();
			Tmr::PreUpdateTimerInfo();
			// Snapshot each active camera's current pose BEFORE the sim advances it, so the
			// renderer can interpolate prev->current between steps (P1 camera interp).
			Nx::CViewportManager::sUpdateCameraInterpSnapshots();
			service_system();
			game_logic();
		}
#else
		service_system();

#if	defined(__PLAT_NGPS__) && defined(BATCH_TRI_COLLISION)
		// Enable VU0 collision
		bool got_vu0 = Nx::CBatchTriCollMan::sUseVU0Micro();
		Dbg_Assert(got_vu0);
#endif

 #ifdef	__PLAT_NGPS__		
//		snProfSetRange( -1, (void*)0, (void*)-1);
//		snProfSetFlagValue(0x01);
 #endif

		game_logic();		

 #ifdef	__PLAT_NGPS__		
//		snProfSetRange( 4, (void*)NULL, (void*)-1);
 #endif		


#if	defined(__PLAT_NGPS__) && defined(BATCH_TRI_COLLISION)
		// Disable VU0 collision
		if (got_vu0)
		{
			Nx::CBatchTriCollMan::sDisableVU0Micro();
		}
#endif
#endif // __PLAT_WN32__

//#ifndef __PLAT_WN32__
		// Display the memory contents, (if memview is active)
		//MemView_Display();
#	ifdef __USE_PROFILER__
		Sys::CPUProfiler->PushContext( 255, 255, 0 );  // yellow = render world
#	endif		

 #ifdef	__PLAT_NGPS__		
//		snProfSetRange( -1, (void*)0, (void*)-1);
//		snProfSetFlagValue(0x01);
 #endif
		
		Nx::CEngine::sRenderWorld();		
#ifdef	__PLAT_NGC__		
#ifdef		__USE_PROFILER__
		Sys::Render_Profiler();		
#endif
#endif
		// Mick: bit of a patch here, we need some better debug hooks
		//Mdl::Rail_DebugRender();
#	ifdef __USE_PROFILER__
			Sys::CPUProfiler->PushContext( 0, 0, 0 );	 	// Black (Under Yellow) = sPostRender
#	endif // __USE_PROFILER__
#ifdef __PLAT_WN32__
		if (!NxXbox::g_disableRendering)
#endif		
		{
			Nx::CEngine::sPostRender();		  // Previous frames profiler is rendered here
		}
#	ifdef __USE_PROFILER__
		Sys::CPUProfiler->PopContext(  );
#	endif		


	

#	ifdef __USE_PROFILER__
		Sys::CPUProfiler->PopContext(  );
#	endif		
		Tmr::OncePerRender();

#ifdef __PLAT_WN32__
		// blops add: debug info in window title
		{
			static int      s_title_frames = 0;		// render frames this window
			static int      s_title_steps  = 0;		// sim steps accumulated this window
			static LONGLONG s_title_last   = 0;		// QPC at last title update
			s_title_frames++;
			s_title_steps += num_sim_steps;
			if (s_title_last == 0)
			{
				s_title_last = perfcount.QuadPart;
			}
			LONGLONG title_elapsed = perfcount.QuadPart - s_title_last;
			if (title_elapsed >= frequency.QuadPart / 2)	// refresh ~2x/sec
			{
				double secs       = (double)title_elapsed / (double)frequency.QuadPart;
				double render_fps = s_title_frames / secs;
				double sim_hz     = s_title_steps  / secs;
				int    free_mb    = Mem::Available() / (1024 * 1024);	// main-region free (watch for per-frame leak)
				char title[160];
				sprintf(title, "Kisak Hawk's OpenGround  -  %.0f FPS  (sim %.0f Hz)  free %d MB", render_fps, sim_hz, free_mb);
				if (NxXbox::EngineGlobals.hWnd)
				{
					SetWindowTextA(NxXbox::EngineGlobals.hWnd, title);
				}
				s_title_frames = 0;
				s_title_steps  = 0;
				s_title_last   = perfcount.QuadPart;
			}
		}
#endif
 #ifdef	__PLAT_NGPS__
//		snProfSetRange( 4, (void*)NULL, (void*)-1);
 #endif
//#endif
		
		currently_profiling = false;

	}

	done = old_flag;
}

void Manager::ProfileTasks(int n)
{
	trigger_profiling = n;
	currently_profiling = 0;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		Manager::QuitLoop( void )
{
	

	Dbg_Notify( "Exiting..." );

	done = true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		Manager::DoGameLogic( void )
{
	game_logic();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Mlp

