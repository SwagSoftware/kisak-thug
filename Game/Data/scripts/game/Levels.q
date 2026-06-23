; ====================================================
;
; Utility scripts
;
; ====================================================

// This is 0 by default so that levels can be reloaded without having to rebuild the pre.
// It gets set to 1 in default_system_startup in startup.q if CD is defined.
UsePreFilesForLevelLoading=0

fake_net		=	0		// Change this to 1 to pretend we are in a net game

AssertOnMissingScripts = 0
AssertOnMissingAssets = 0

// AlwaysDump is 0 by default.  If you cahnge it to 1 in your startup
// before an autolaunch, then it will always do a dumpheaps each time you run the code
AlwaysDump = 0

// Script to run once the new level is loaded.
// This is usually set when a cutscene script
// changes levels and the designer wants to
// run another script once the new level loads.
next_level_script = nullscript


script cleanup_before_loading_level
	; can't defer this until the level's actually loaded...
	; otherwise, we'll wipe out the front end's sprites
	; and such
	printf "*********************** cleanup_before_loading_level"
	Cleanup
	StopMusic
	PauseMusic
	ClearMusicTrackList
endscript

script PreLevelLoad
endscript

/*script DisplayProperLoadingScreen
// Your one stop shop for displaying loading screens
// All level load scripts call this with relevent Params
    if EnteringNetGame
        if OnServer
            if IsXbox
				DisplayLoadingScreen "loadscrn_system_link_x"
			else
				DisplayLoadingScreen "loadscrn_Online"
			endif
        else
            if IsXbox
				DisplayLoadingScreen "loadscrn_system_x"	// we're a client so show this screen
			else
	            DisplayLoadingScreen "loadscrn_Online2"		// we're a client so show this screen
			endif
        endif
    else
        if IsTrue FirstTimeFromSkateshop
            DisplayLoadingScreen "loadscrn_2player"
        else
            if GameModeEquals is_horse
                DisplayLoadingScreen "loadscrn_horse"
            else
                if GameModeEquals is_king
                    DisplayLoadingScreen "loadscrn_koth"
                else
                    if InSlapGame
                        DisplayLoadingScreen "loadscrn_slap"
                    else
                        if GameModeEquals should_modulate_color //Graffiti
                            DisplayLoadingScreen "loadscrn_Graffiti"
                        else
                            if GameModeEquals is_trick_attack //need to detect trick attack
                                DisplayLoadingScreen "loadscrn_trick_attack"
                            else
                                if InSplitScreenGame   // This should do for Free Skate, as all other games are accounted for
                                    DisplayLoadingScreen "loadscrn_2player"
                                else
                                    DisplayLoadingScreen <...>  // just whatever is passed
								endif
                            endif
                        endif
                    endif
                endif
            endif
        endif
    endif
endscript*/

script PostLevelLoad
endscript

script script_assert <...>
	printf "ASSERT MESSAGE:"
	ScriptAssert <...>
endscript

script request_level
	if gotparam level
		RequestLevel <level>
	else
		script_assert "request_level needs a level param"
	endif
endscript

script LoadLevel
	MemPushContext 0    ; Mick - Ensure loaded levels go on the game heap
	PreLevelLoad
	ScreenElementSystemCleanup
	LaunchLevel <...>
	PostLevelLoad
	MemPopContext
endscript


// if you change these, let me know - brad
LevelNum_NJ=1
LevelNum_NY=2
LevelNum_FL=3

LevelNum_SD=4
LevelNum_HI=5
LevelNum_VC=6

LevelNum_SJ=7
LevelNum_RU=8
LevelNum_AU=9
LevelNum_SE=10

LevelNum_Default=11

LevelNum_SC=12
LevelNum_DJ=13
LevelNum_PH=14
LevelNum_VN=16
LevelNum_HN=17
LevelNum_SC2=15

LevelNum_WWW=18

LevelNum_CAS=19
LevelNum_Boardshop=20
LevelNum_TestLevel=21

//LevelNum_Kon=9

// old levels
// THPS4
LevelNum_Skateshop=0
LevelNum_Sch=1
LevelNum_SF2=2
LevelNum_Alc=3
LevelNum_Kon=4
LevelNum_Jnk=5
LevelNum_Lon=6
LevelNum_Zoo=7
LevelNum_Cnv=8
LevelNum_Hof=9
LevelNum_Sk5ed=11

// THPS3
LevelNum_Airport=1
LevelNum_Canada=2
LevelNum_Rio=3
LevelNum_Suburbia=4
LevelNum_Foundry=5
LevelNum_SkaterIsland=6
LevelNum_LA=7
LevelNum_Tokyo=8
LevelNum_Ship=9
LevelNum_Oil=10
LevelNum_Tutorials=11
LevelNum_Warehouse=12
LevelNum_Burnside=13
LevelNum_Roswell=14
LevelNum_Rooftops=15

//Gaps in levels below will be taken into account when checking for all gaps
levels_with_gaps = [
	LevelNum_NJ
	LevelNum_NY
	LevelNum_FL
	LevelNum_SD
	LevelNum_HI
	LevelNum_VC
	LevelNum_SJ
	LevelNum_RU
	LevelNum_SE
	LevelNum_SC2
	LevelNum_VN
	LevelNum_HN
]


script  LoadLevelPreFile
	if istrue UsePreFilesForLevelLoading
		LoadPreFile <...>
	endif
endscript


script  set_level_lights fog_red=0 fog_blue=0 fog_green=0 fog_alpha=0 fog_dist=0
	printf "heading=%h" h=<heading_0>
	SetLightAmbientColor    r=<ambient_red> g=<ambient_green> b=<ambient_blue>
	SetLightDirection       index = 0 heading = <heading_0> pitch = <pitch_0>
	SetLightDiffuseColor    index = 0 r=<red_0> g=<green_0> b=<blue_0>
	SetLightDirection       index = 1 heading = <heading_1> pitch = <pitch_1>
	SetLightDiffuseColor    index = 1 r=<red_1> g=<green_1> b=<blue_1>

	SetDynamicLightModulationFactor ambient value=<ambient_mod_factor>
	SetDynamicLightModulationFactor directional=0 value=<mod_factor_0>
	SetDynamicLightModulationFactor directional=1 value=<mod_factor_1>

	// artists set their own fog for the default level, and every one is different
	// so don't specifically set the fog for it
	if GotParam load_script
		if not ( <load_script>  =  Load_Default)
			if not (<fog_dist> = 0)
				EnableFog
				SetFogColor r=<fog_red> b=<fog_blue> g=<fog_green> a=<fog_alpha>
				SetFogDistance distance=<fog_dist>
			else
				DisableFog
			endif
		endif
	endif
endscript

ANY_LEVEL_LOADED_YET = 0

// Generic script for doing the loading of a level
script load_level level_number=0
	if InNetGame
		if Not IsObserving
			ExitSurveyorMode
		endif
	endif

	// reset previous free memory minimums
	change freemem_script_lowest = 999999999
	change freemem_main_lowest = 999999999

	// THPS4-ported levels bundle level scripts (LoadCameras, load_level_anims, etc.) into their
	// node array that reference THPS4-only assets/commands. Make those non-fatal so the level
	// still loads; the viewer_mode block near the end of load_level restores the asserts.
	if gotparam thps4_port
		change AssertOnMissingScripts=0
		change AssertOnMissingAssets=0
	endif


	// We never want the "Unloadable" anims at this point
	// as we need the extra memory for loading PRE files and stuff
	do_unload_unloadable

	// If we are NOT in a net game, then we MUST have the "permanent" anims loaded
	// Unless it's a park editor level (which just has "net" anims)
	if NOT InNetGame
		if NOT gotparam park_editor
			do_load_permanent
		endif
	endif

	RememberLevelStructureNameForReplays level_structure_name=<structure_name>
	GoalManager_RememberLevelStructureName level_structure_name=<structure_name>

	if ( (cd)  || (isTrue TestMusicFromHost) )
		if gotparam ambient_track
			AddMusicTrack <ambient_track>
		endif
	endif

	// Make sure the player can't pause the game while we're loading the level.
	// Start key is rebound in gameflow.q
	kill_start_key_binding
	printf "replace_handlers to take away start key in load_level"
	set_level_lights <...>

	SetScoreAccumulation 0
	SetScoreDegradation 0

	/*	if GameModeEquals is_singlesession
		// if we're in single-session,
		// then we want to do classic
		// THPS3-style score degradation
		printf "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
		printf "setting score degradation to 1"
		printf "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
	else
		printf "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
		printf "setting score degradation to 0"
		printf "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
		SetScoreDegradation 0
	endif
*/
	// turn off disco cheat in two player
	if InSplitScreenGame
		UnSetGlobalFlag flag=CHEAT_DISCO
	endif

	// Compensate for accellerated x-box loading times
	if isXbox
		if GotParam loading_time_xbox
			<loading_time> = <loading_time_xbox>
		else
			<loading_time> = (<loading_time>*0.6)
		endif
	else
		if (ANY_LEVEL_LOADED_YET = 0)
			// Standard level loading time is longer at bootup than when just switching game modes
			<loading_time>=(<loading_time>+0)
			change ANY_LEVEL_LOADED_YET=1
		endif
	endif

	printf "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
	printf "@@@ LOADLEVEL"
	if isTrue Bootstrap_build
		DisplayLoadingScreen "loadscrn_demo_controls" 27
	else
		if gotparam loading_screen
			if EnteringNetGame
				if OnServer
					if IsXbox
						DisplayLoadingScreen "loadscrn_system_link_x" <loading_time>
					else
						DisplayLoadingScreen "loadscrn_Online" <loading_time>
						printf "@@@ AS SERVER"
					endif
				else
					printf "@@@ AS CLIENT"
					if IsXbox
						DisplayLoadingScreen "loadscrn_system_x" <loading_time>	// we're a client so show this screen
					else
						DisplayLoadingScreen "loadscrn_Online2" <loading_time>	// we're a client so show this screen
					endif
				endif
			else
				printf "@@@ NON NET GAME"
				if InSplitScreenGame   // This should do for Free Skate, as all other games are accounted for
					DisplayLoadingScreen "loadscrn_2player" <loading_time>
				else
					if (Display_Story_Peralta_LoadingScreen)
						// in story mode in a couple of instances we override the normal
						// loading screen for when you travel to the skateshop, and travel to Hawaii at game's end
						change Display_Story_Peralta_LoadingScreen = 0
						<loading_screen> = "loadscrn_peralta"
					endif

					if (Display_Story_Final_LoadingScreen)
						change Display_Story_Final_LoadingScreen = 0
						<loading_screen> = "loadscrn_final"
					endif

					if (Display_Story_Premiere_LoadingScreen)
						change Display_Story_Premiere_LoadingScreen = 0
						<loading_screen> = "loadscrn_premiere"
					endif

					if ( launch_to_createatrick = 1 )
						if IsXbox
							<loading_screen> = "loadscrn_trick_x"
						else
							if isNGC
								<loading_screen> = "loadscrn_trick_ngc"
							else
								<loading_screen> = "loadscrn_trick"
							endif
						endif
					endif

					DisplayLoadingScreen <loading_screen> <loading_time>

				endif
			endif
		else
			DisplayLoadingScreen "loadscrn_generic"
		endif
	endif

	exit_pause_menu
	CareerStartLevel    level = <level_number>

	if not InNetGame
		AllocatePathManMemory
	endif

	ResetLevelFlags  // clear out level flags 0-63 - see level_flags.q

	if ( <level_number> = LevelNum_SkateShop )
		// creates a new skateshop-specific heap, for skater preview parts
		//		MemInitHeap name="preview" size=1250000
	endif

	if gotparam scnpre
		if not InNetGame
			LoadLevelPreFile    <scnpre>
		else
			if gotparam park_editor
				LoadLevelPreFile    <scnpre>
			else
				LoadLevelPreFile	(<Level>+"scn_net.pre")
			endif
		endif
	endif

	if gotparam sky
		LoadScene           scene=<sky>
	endif

	// PARKED4:
	if gotparam park_editor
		LoadScene           scene=<level> is_dictionary
		if gotparam outer_shell
			LoadScene scene=<outer_shell> no_supersectors
		endif
	else
		if GotParam level
			if InNetgame
				LoadScene           scene=<level>  is_net
			else
				LoadScene           scene=<level>
			endif
		endif
	endif

	if gotparam level_name
		SetLevelName        <level_name>
	else
		SetLevelName        <level>
	endif

	if gotparam scnpre
		if not InNetGame
			UnloadPreFile       <scnpre> dont_assert
		else
			if gotparam park_editor
				UnloadPreFile       <scnpre> dont_assert
			else
				UnloadPreFile       (<Level>+"scn_net.pre") dont_assert
			endif
		endif
	endif



	if IsNgc
		if Not InMultiPlayerGame // No peds in 2P, or in Net games.
			if gotparam pedpre
				LoadPreFile <pedpre>	dont_assert
			endif
		endif
	endif

	// Non-PS2 platforms can load the level specific pre file here
	if NOT IsPS2
		if gotparam pre
			LoadLevelPreFile    <pre>
		endif
	endif

	// Load foreign language level pre for NGC.
	if  isngc
		if german
			LoadPreFile (<pre>+"d")	dont_assert
		else
			if french
				LoadPreFile (<pre>+"f")	dont_assert
			endif
		endif
	endif


	if gotparam qb

		if  isngc
			if german
				<qb>=(<qb>+"d")
			else
				if french
					<qb>=(<qb>+"f")
				endif
			endif
		endif

		if gotparam park_editor
			// PARKED4: don't want LoadNodeArray to call PreloadModels, so we pass in the park_editor flag
			LoadNodeArray <qb> park_editor
		else
			LoadNodeArray <qb>
		endif
	endif

	// Ps2 needs to load the level PRE file AFTER the nodearray, as no memory in net games
	if IsPS2
		if gotparam pre
			LoadLevelPreFile    <pre>
		endif
	endif

	// Preloading models is not done in LoadNodeArray any more, so we can
	// wait until the prefile has been loaded
	if gotparam park_editor
	else
		if gotparam qb
			PreloadModels
		endif
	endif


	if gotparam level_qb

		if  isngc
			if german
				<level_qb>=(<level_qb>+"d")
			else
				if french
					<level_qb>=(<level_qb>+"f")
				endif
			endif
		endif

		// K: This unload is just in case the level's _scripts.q file got qbr'd whilst in a different
		// level. This will prevent the LoadQB from asserting due to the file already being loaded.
		// (Jeff was occasionally getting that assert when going from SJ to VC)
		UnloadQB            <level_qb>

		LoadQB              <level_qb> LevelSpecific
	endif

	if gotparam level_sfx_qb

		if  isngc
			if german
				<level_sfx_qb>=(<level_sfx_qb>+"d")
			else
				if french
					<level_sfx_qb>=(<level_sfx_qb>+"f")
				endif
			endif
		endif

		LoadQB              <level_sfx_qb> LevelSpecific
	endif

	// Unload foreign language level pre for NGC.
	if  isngc
		if german
			UnloadPreFile (<pre>+"d")	dont_assert
		else
			if french
				UnloadPreFile (<pre>+"f")	dont_assert
			endif
		endif
	endif


	// chooses which parts are available
	// when randomizing ped parts;  this
	// needs to be done before the first
	// random ped is loaded, such as in
	// the goal creation scripts...
	if gotparam qb
		preselect_random_parts <...>
	endif

	if gotparam park_editor
		;LoadSound "Shared\Hits\BonklBush"
		/*
// Mick: Moved these to sk5ed_startup so they get into the pre file
		LoadSound "Shared\Hits\FallPungee_11"
		LoadSound "Shared\Water\FallWater"

        LoadSound "Shared\Auto\CarLoop"
        LoadSound "Vehicles\Vehicle_Tire_Loop"
        LoadSound "Terrains\BonkMetal_11"
		LoadSound "Weather\Weather_Rain_Light01"
		LoadSound "Weather\Weather_Rain_Medium01"
*/

		//    	LoadTerrain_parked // Loads sounds
		LoadTerrain // Mick:  We just call the one in the parked .qn, as we don't need a special one now
	else
		SetTerrainDefault       // Ensure we always load the default, even if nothing is specified
		if gotparam qb
			LoadTerrain // Loads sounds
		endif
	endif
	//	CC_Startup

	;	if CD
	;	else
	// this sets your stats to the value at which
	// your skater is assumed to be, by the time
	// he reaches this level.  it conflicts with
	// the normal stat point system, so we only enable
	// it when "UseLevelOverrideStats" is set to 1.
	if IsTrue UseLevelOverrideStats
		if  gotparam default_stats
			if ( bump_stats = 0 )
				SetAllStats value = <default_stats>
			endif
		endif
	endif
	;	endif



	if Not InNetGame
		if ScriptExists load_level_anims
			PushMemProfile  "Level Specific Anims"
			if gotparam thps4_port
				// THPS4-ported levels bundle their own load_level_anims into the node array
				// that uses THPS4's script API (undefined here) - skip it for those.
			else
				// THUG career levels (Manhattan/NY, NJ, FL, etc.) ship a load_level_anims
				// that loads pedestrian / level-specific animations. It MUST run or peds
				// fail in CreatePed with "Asset Not Found". (The earlier blanket comment-out
				// assumed this never ran for THUG levels - it runs for every ped level.)
				load_level_anims
			endif
			PopMemProfile
		endif
	endif

	if Not InNetGame
		if ScriptExists LoadCameras
			PushMemProfile  "Level Cameras"
			LoadCameras
			PopMemProfile
		endif
	endif

	if ScriptExists LoadObjectAnims
		// not all levels have object anims, yet
		PushMemProfile  "Object Anims"
		LoadObjectAnims
		PopMemProfile
	endif

	if  ScriptExists LoadAllParticleTextures
		// Nor do they necassarily have Particle Systems
		PushMemProfile  "Particle Textures"
		LoadAllParticleTextures
		PopMemProfile
	endif




	if gotparam extranetanimsscript   //and load extraanims in netgames, if this level has any
		if InNetgame
			Printf "                    WE'RE IN A NET GAME!!!!!!!!!!!!!"
			PushMemProfile  "Level Specific Anims"
			<extranetanimsscript>
			PopMemProfile
		endif
	endif

	if gotparam park_editor
	else
		if IsNgc
			if ( <level_number> = LevelNum_CAS )
			else
				if ( <level_number> = LevelNum_Skateshop )
				else
					if ( <level_number> = LevelNum_boardshop )
					else
						if gotparam startup_script
							<startup_script> // May load sounds
						endif
					endif
				endif
			endif
		else
			if gotparam startup_script
				<startup_script> // May load sounds
			endif
		endif
	endif

	if not IsNgc
		if gotparam pre
			UnloadPreFile       <pre> dont_assert
		endif
	endif

	if not IsNgc
		if Not InMultiPlayerGame // No peds in 2P, or in Net games.
			if gotparam pedpre
				LoadPreFile <pedpre>	dont_assert
			endif
		endif
	endif

	if Not InMultiPlayerGame // No peds in 2P, or in Net games.
		// loads up the level-specific ped parts
		if gotparam qb
			if not GotParam frontend_level
				if gotparam thps4_port
					// THPS4 node array references THPS4/generic peds (models\peds\...) we
					// haven't ported; peds aren't needed for free skate, so skip preload.
				else
					if gotparam park_editor
						PreloadPedestrians no_random
					else
						PreloadPedestrians
					endif
				endif
			endif
		endif
	endif

	// for the crown in multiplayer games
	if Not InNetGame
		if InMultiPlayerGame
			PreloadModel name="crown"
		endif
	endif

	if not IsNgc
		if Not InMultiPlayerGame // No peds in 2P, or in Net games.
			if gotparam pedpre
				UnloadPreFile <pedpre> dont_assert
			endif
		endif
	endif

	// load mainmenu sprites
	if ( <level_number> = LevelNum_Skateshop )
		load_mainmenu_textures_to_main_memory
	endif

	if gotparam park_editor
	else
		if IsNgc
			if gotparam startup_script
				if ( <level_number> = LevelNum_CAS )
					<startup_script> // May load sounds
				endif
				if ( <level_number> = LevelNum_skateshop )
					<startup_script> // May load sounds
				endif
				if ( <level_number> = LevelNum_boardshop )
					<startup_script> // May load sounds
				endif
			endif
		endif
	endif

	///////////////////////////////////////////////
	// start loading collision

	// if gotparam colpre
	//	LoadLevelPreFile    <colpre>
	// endif
	PushMemProfile  "Level Collision decompressed PIP + Supersectors"
	if istrue UsePreFilesForLevelLoading
		if GotParam colpre
			//			LoadPipPre <colpre> heap=topdown // load on top down heap, as it should be empty, and unfragmented

			// GJ:  I changed this to the bottomup heap, because the
			// permanent anims need to be the last thing on the topdown
			// heap in order to be unloaded/reloaded properly
			if not InNetGame
				LoadPipPre <colpre> heap=bottomup
			else
				if gotparam park_editor
					LoadPipPre <colpre> heap=bottomup
				else
					LoadPipPre (<Level>+"col_net.pre") heap=bottomup
				endif
			endif

		endif
	endif
	if InNetGame
		if gotparam park_editor
			LoadCollision       scene=<level>
		else
			LoadCollision       scene=<level> is_net
		endif
	else
		LoadCollision       scene=<level>
	endif

	// the park editor needs to load the collision for the shell
	if gotparam park_editor
		if gotparam outer_shell
			if istrue UsePreFilesForLevelLoading
				<extension>="col.pre"

				//        			LoadPipPre (<outer_shell>+<extension>) heap=topdown    // load on top down heap, as it should be empty, and unfragmented

				// GJ:  I changed this to the bottomup heap, because the
				// permanent anims need to be the last thing on the topdown
				// heap in order to be unloaded/reloaded properly
				LoadPipPre (<outer_shell>+<extension>) heap=bottomupheap
			endif
			LoadCollision       scene=<outer_shell>
		endif
	endif


	PopMemProfile

	// Note: Not unloading colpre here, because the collision data needs to stay for the
	// duration of the level.
	// The collision pre will get automatically unloaded by ScriptCleanup, because ScriptCleanup
	// will unload any pip-pre's which are not being used.
	// end loading collision
	//////////////////////////////////////////////////////////////

	if gotparam park_editor
		if gotparam startup_script
			<startup_script> // May load sounds
		endif
	else
		if gotparam qb
			ParseNodeArray
		endif
	endif

	// for debugging - automatically set the
	// chapter and stage when entering a level
	if ( auto_change_chapter_and_stage = 1 )
		GetCurrentLevel
		if StructureContains structure=LEVEL_CHAPTER_MAP <level>
			GoalManager_SetCurrentChapterAndStage chapter=( LEVEL_CHAPTER_MAP.<level> ) stage=0
		endif
	endif

	// now that the level, model, and collision assets
	// have been loaded, we're now free to do anything
	// having to do w/ creating goal-specific nodes,
	// turning on trigger planes, etc.
	if GotParam goals_script
		<goals_script>
	endif

	// K: Initialise any created goals for this level so that the goal peds are created.
	if GameModeEquals is_creategoals
		InitialiseCreatedGoals
	else
		// If it is a network game, register the created goals so that they can be used in
		// a goal attack game, but don't create the peds because they will get created
		// when the goal attack is started.
		if InNetGame
			InitialiseCreatedGoals DoNotCreateGoalPeds
		endif
	endif

	if GameModeEquals is_singlesession
		AddGoal_TrickAttack
	endif

	if GameModeEquals is_career
		if not ( <level_number> = 0 )
			SetGlobalFlag flag=CAREER_STARTED
			printf "CAREER_STARTED"
		endif
	endif

	// after the goals have been added, the goalmanager
	// needs to do some bookkeeping on them
	init_goal_manager

	if GotParam setup_script
		<setup_script>
	endif

	// SP: Used to only do this if not innetgame, but this then means that no daytime sound boxes and geo
	// are created in a netgame, so do the tod, but now script_change_tod will not do any fakelighting if we are in a net game
	if GotParam frontend_level
		// reset tod stuff... rain off etc
		script_reset_tod
	else
		// set the levels time of day to default to day, so that sound boxes are created
		script_change_tod tod_action = set_tod_startup
	endif

	///////////////////////////////////////////////////////////////////
	// Ensure that the correct set of animations are loaded
	// which means the "net" animations for a network game
	// and the "permanent" and "unloadable" anims for non-net games
	// K: This is not done for the park editor, because it causes top-down fragmentation on cleanup
	if not gotparam park_editor
		do_load_unloadable
	endif
	///////////////////////////////////////////////////////////////////

	// Load up the skaterparts after the anims...  otherwise,
	// it will cause fragmentation problems when switching levels
	if GotParam frontend_level
		if ( <frontend_level> = 1 )
			// create-a-skater artists don't use the prefile
			// so that they can re-export and re-load without
			// re-starting
			if IsNgc
				LoadPreFile "skaterparts.pre" use_bottom_up_heap
			else
				if not IsTrue cas_artist
					if ( <level_number> = LevelNum_Skateshop )
						// put the skaterparts on the topdown heap
						// in the skateshop, so that we can unload them
						// for playing movies (both from the movie and
						// from the attract mode)...  cutscenes
						// aren't played from the skateshop	anyway,
						// so it won't conflict with the unloading
						// of anims...
						LoadPreFile "skaterparts.pre"
					else
						// for any level where we're not going to
						// play FMV movies, we'll need to put it on
						// the bottomup heap so that it doesn't conflict
						// with the unloading of anims.  if there's
						// a situation where we eventually want both
						// cutscenes AND fmv movies, then we'll have
						// to change the cutscene code so that it
						// unloads/reloads the skaterparts as well...
						LoadPreFile "skaterparts.pre" use_bottom_up_heap
					endif
				endif
			endif
		endif
	endif

	// A PS2 Specific patch to use our spare memory (in 2P) as an extra DMA buffer
	// This will get released when "Cleanup" is called"
	// We need this as the split screen can end up rendering twice as much as
	// the normal screen, but luckily we have loads of spare memory
	// thanks to the cars and stuff we are not loading.
	// I'm unsure as to the implications this will have for memory restrictions
	// in the park editor
	// perhaps best to leave the park editor alone in split screen???????
	if InSplitScreenGame
		AllocateSplitScreenDMA
	endif

	UnPauseGame

	if gotparam viewer_mode
		gameflow StandardGameFlowToggleView
		change AssertOnMissingScripts=0
		change AssertOnMissingAssets=0
	else
		if gotparam thps4_port
			// keep missing-asset/script asserts off through gameplay - this level spawns
			// THPS4 GameObjects that reference assets/commands we don't ship.
			change AssertOnMissingScripts=0
			change AssertOnMissingAssets=0
		else
			change AssertOnMissingScripts=1
			change AssertOnMissingAssets=1
		endif
		gameflow StandardGameFlow
	endif

	if IsNgc
		if gotparam pre
			UnloadPreFile       <pre> dont_assert
		endif

		if Not InMultiPlayerGame // No peds in 2P, or in Net games.
			if gotparam pedpre
				UnloadPreFile <pedpre> dont_assert
			endif
		endif
	endif

endscript

script LoadTerrain_parked
	SetTerrainDefault
	SetTerrainConcSmooth
	SetTerrainConcRough
	SetTerrainMetalSmooth
	SetTerrainMetalRough
	SetTerrainMetalGrating
	SetTerrainWood
	SetTerrainWoodMasonite
	SetTerrainWoodPlywood
	SetTerrainWoodPier
	SetTerrainBrick
	SetTerrainTile
	SetTerrainAsphalt
	SetTerrainRock
	SetTerrainGravel
	SetTerrainSidewalk
	SetTerrainGrass
	SetTerrainDirt
	SetTerrainWater
	SetTerrainPlexiglass
	SetTerrainChainlink
	SetTerrainGrindwire
	SetTerrainGrindConc
	SetTerrainGrindMetal
	SetTerrainGrindWood
endscript




script init_goal_manager
	// all goals have been added, load any flags
	GoalManager_LevelLoad

	if InNetGame
		GoalManager_InitializeAllMinigames
		UnSetFlag flag=FLAG_PROSET1_GEO_ON
		UnSetFlag flag=FLAG_PROSET2_GEO_ON
		UnSetFlag flag=FLAG_PROSET3_GEO_ON
		UnSetFlag flag=FLAG_PROSET4_GEO_ON
		UnSetFlag flag=FLAG_PROSET5_GEO_ON
		UnSetFlag flag=FLAG_PROSET6_GEO_ON
		UnSetFlag flag=FLAG_PROSET7_GEO_ON
	else
		GoalManager_SetGoalChaptersAndStages
	endif
	GoalManager_UpdateFamilyTrees

	GoalManager_InitializeAllGoals

	// run the last stage script if we're in the right level
	GoalManager_GetCurrentChapterAndStage
	if GameModeEquals is_career
		GetCurrentLevel
		if ( ( ( CHAPTER_LEVELS[<currentChapter>] ).checksum ) = <level> )
			GoalManager_RunLastStageScript
		endif
	endif
	; GoalManager_ReplaceTrickText all
	GoalManager_SetCanStartGoal 1

	// BB: it's necessary to use CareerLevelIs here, rather
	// than LevelIs, which won't return the right value until after
	// this script is done
	if CareerLevelIs LevelNum_Skateshop
		// hide the points and goal points
		GoalManager_HideGoalPoints
		GoalManager_HidePoints
	else
		if Not InMultiPlayerGame
			GoalManager_ShowGoalPoints
		endif
		if not (in_cinematic_sequence)
			GoalManager_ShowPoints
		endif
	endif
endscript


; ====================================================
;
; Individual Level scripts
;
; ====================================================
script Load_Default
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_Default
endscript
script Load_EmptyDefault
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_EmptyDefault
endscript
script Load_NJ
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_NJ
endscript
script Load_NY
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_NY
endscript
script Load_FL
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_FL
endscript
script Load_Alc
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_Alc
endscript
script Load_SD
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_SD
endscript
script Load_HI
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_HI
endscript
script Load_VC
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_VC
endscript
script Load_SJ
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_SJ
endscript
script Load_RU
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_RU
endscript
script Load_AU
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_AU
endscript
script Load_SE
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_SE
endscript
script Load_TestLevel
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_TestLevel
endscript
script Load_SC
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_SC
endscript
script Load_DJ
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_DJ
endscript
script Load_PH
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_PH
endscript
script Load_VN
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_VN
endscript
script Load_hn
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_HN
endscript
script Load_sc2
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_SC2
endscript
script Load_WWW
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_WWW
endscript
script Load_Test
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level Level_Test
endscript
; =========================
;       Default
; =========================

Level_Default = {
	structure_name  =   Level_Default
	load_script     =   Load_Default
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Default"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic"
	loading_time    =   9.5
	Level           =   "Default"
	Sky             =   "Default_Sky"
	qb              =   "levels\Default\Default.qb"
	level_qb        =   "levels\Default\Default_scripts.qb"
	startup_script  =   Default_Startup
	goals_script	=	Default_goals
	setup_script	=	Default_setup
	default_stats   =   5
	level_number    =   LevelNum_Default
	viewer_mode     =   1
	//	extranetanimsscript= animload_skater_trolley

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0 = 50
	pitch_0 = 330
	red_0 = 130
	green_0 = 120
	blue_0 = 97
	mod_factor_0 = 1.400


	//direction_1      = (0.0, 1.0, 0.0)
	heading_1 = 240
	pitch_1 = 330
	red_1 = 58
	green_1 = 62
	blue_1 = 66
	mod_factor_1 = 0.400

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}


Level_EmptyDefault = {
	structure_name  =   Level_EmptyDefault
	load_script     =   Load_EmptyDefault
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Default"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic"
	loading_time    =   9.5
	Level           =   "Default"
	Sky             =   "NJ_Sky"
	default_stats   =   5
	level_number    =   LevelNum_Default
	viewer_mode     =   1
	//	extranetanimsscript= animload_skater_trolley

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 120.0
	pitch_0          = -127.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = -45.0
	pitch_1          = -110.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}


; =========================
;        NEW JERSEY
; =========================
Level_NJ = {
	structure_name  =   Level_NJ
	load_script     =   Load_NJ
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "New Jersey"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_jersey" /*"loadscrn_generic" */
	loading_time    =   15.5
	pre             =   "NJ.pre"
	scnpre          =   "NJscn.pre"
	Level           =   "NJ"
	Sky             =   "NJ_Sky"
	qb              =   "levels\NJ\NJ.qb"
	colpre          =   "NJcol.pre"
	pedpre       	=   "NJped.pre"
	level_qb        =   "levels\NJ\NJ_scripts.qb"
	level_sfx_qb    =   "levels\NJ\NJ_sfx.qb"
	startup_script  =   NJ_Startup
	goals_script	=	NJ_goals
	setup_script	=	NJ_setup
	//    default_stats   =   7       // for Lollapalooza
	default_stats   =   5     // normal stats
	level_number    =   LevelNum_NJ
	//	extranetanimsscript= animload_skater_trolley

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0 = 50
	pitch_0 = 330
	red_0 = 130
	green_0 = 120
	blue_0 = 97
	mod_factor_0 = 1.400


	//direction_1      = (0.0, 1.0, 0.0)
	heading_1 = 240
	pitch_1 = 330
	red_1 = 58
	green_1 = 62
	blue_1 = 66
	mod_factor_1 = 0.400

	//fog
	fog_red				=	0
	fog_blue			=	0
	fog_green			=	0
	fog_alpha			=	0
	fog_dist 			=	0

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6
}
; =========================
;        THPS4 ALCATRAZ (loose-file port test)
; =========================
// Loads loose THPS4 PC files from Data\levels\Alc\ (Alc.scn/.col/.tex/.qb/.Alc_scripts.qb).
// No pre fields -> loader falls through to disk. startup/goals/setup/level_number
// omitted on purpose: all are gotparam-gated, so they're skipped (THPS4 scripts differ).
Level_Alc = {
	structure_name  =   Level_Alc
	load_script     =   Load_Alc
	name            =   "THPS4 Alcatraz"
	loading_screen  =   "loadscrn_jersey"
	loading_time    =   15
	Level           =   "Alc"
	qb              =   "levels\Alc\Alc.qb"
	// level_qb (Alc_scripts.qb) intentionally omitted: the THPS4 level scripts use THPS4's
	// script API (e.g. load_level_anims referencing undefined commands) and aren't needed for
	// free skate - the node array carries geometry + restarts. Re-add once scripts are ported.
	thps4_port      =   1   // makes missing THPS4 assets/scripts non-fatal during load (see load_level)
	default_stats   =   5

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	heading_0 = 50
	pitch_0 = 330
	red_0 = 130
	green_0 = 120
	blue_0 = 97
	mod_factor_0 = 1.400

	heading_1 = 240
	pitch_1 = 330
	red_1 = 58
	green_1 = 62
	blue_1 = 66
	mod_factor_1 = 0.400

	fog_red				=	0
	fog_blue			=	0
	fog_green			=	0
	fog_alpha			=	0
	fog_dist 			=	0

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6
}
; =========================
;        MANHATTAN
; =========================
Level_NY = {
	structure_name  =   Level_NY
	load_script     =   Load_NY
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Manhattan"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_manhattan"
	loading_time    =   22
	pre             =   "NY.pre"
	scnpre          =   "NYscn.pre"
	Level           =   "NY"
	Sky             =   "NY_Sky"
	qb              =   "levels\NY\NY.qb"
	colpre          =   "NYcol.pre"
	pedpre       	=   "NYped.pre"
	level_qb        =   "levels\NY\NY_scripts.qb"
	level_sfx_qb    =   "levels\NY\NY_sfx.qb"
	startup_script  =   NY_Startup
	goals_script	=	NY_goals
	setup_script	=	NY_setup
	default_stats   =   6
	level_number    =   LevelNum_NY
	//	extranetanimsscript= animload_skater_trolley

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 330.0
	pitch_0          = 330.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 150.0
	pitch_1          = 330.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red				=	126
	fog_blue			=	227
	fog_green			=	169
	fog_alpha			=	45
	fog_dist			=	1000

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6
}
; =========================
;        SOUTH FLORIDA
; =========================
Level_FL = {
	structure_name  =   Level_FL
	load_script     =   Load_FL
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Florida"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_florida"
	loading_time    =   18
	pre             =   "FL.pre"
	scnpre          =   "FLscn.pre"
	Level           =   "FL"
	Sky             =   "FL_Sky"
	qb              =   "levels\FL\FL.qb"
	colpre          =   "FLcol.pre"
	pedpre       	=   "FLped.pre"
	level_qb        =   "levels\FL\FL_scripts.qb"
	level_sfx_qb    =   "levels\FL\FL_sfx.qb"
	startup_script  =   FL_Startup
	goals_script	=	FL_goals
	setup_script	=	FL_setup
	default_stats   =   6
	level_number    =   LevelNum_FL
	//	extranetanimsscript= animload_skater_trolley

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 50.0
	pitch_0          = 330.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 240.0
	pitch_1          = 330.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red				= 150
	fog_blue			= 255
	fog_green			= 150
	fog_alpha			=  20
	fog_dist			= 900

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6
}
; =========================
;        SAN DIEGO
; =========================
Level_SD = {
	structure_name  =   Level_SD
	load_script     =   Load_SD
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "San Diego"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_diego"
	loading_time    =   18
	pre             =   "SD.pre"
	scnpre          =   "SDscn.pre"
	Level           =   "SD"
	Sky             =   "SD_Sky"
	qb              =   "levels\SD\SD.qb"
	colpre          =   "SDcol.pre"
	pedpre       	=   "SDped.pre"
	level_qb        =   "levels\SD\SD_scripts.qb"
	level_sfx_qb    =   "levels\SD\SD_sfx.qb"
	startup_script  =   SD_Startup
	goals_script	=	SD_goals
	setup_script	=	SD_setup
	default_stats   =   7
	level_number    =   LevelNum_SD
	extranetanimsscript = animload_Ped_Driver

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 80.0
	pitch_0          = 330.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 280.0
	pitch_1          = 330.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red				=	0
	fog_blue			=	0
	fog_green			=	0
	fog_alpha			=	0
	fog_dist			=	0

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6

	// need at least 3 sets of legs, because
	// the Party Girls goal contains 3 distinct
	// females.
	num_f_legs		=	3

}
; =========================
;        HAWAII
; =========================
Level_HI = {
	structure_name  =   Level_HI
	load_script     =   Load_HI
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Hawaii"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_hawaii"
	loading_time    =   20
	pre             =   "HI.pre"
	scnpre          =   "HIscn.pre"
	Level           =   "HI"
	Sky             =   "HI_Sky"
	qb              =   "levels\HI\HI.qb"
	colpre          =   "HIcol.pre"
	pedpre       	=   "HIped.pre"
	level_qb        =   "levels\HI\HI_scripts.qb"
	level_sfx_qb    =   "levels\HI\HI_sfx.qb"
	startup_script  =   HI_Startup
	goals_script	=	HI_goals
	setup_script	=	HI_setup
	default_stats   =   7
	level_number    =   LevelNum_HI

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 320.0
	pitch_0          = 330.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 160.0
	pitch_1          = 330.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red				= 150
	fog_blue			= 235
	fog_green			= 170
	fog_alpha			=  38
	fog_dist			= 700

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6

	// need at least 3 sets of legs, because
	// the artists wanted only bikinis to
	// come up, which means we need one of
	// each skintone
	num_f_legs		=	3
}
; =========================
;        VANCOUVER
; =========================
Level_VC = {
	structure_name  =   Level_VC
	load_script     =   Load_VC
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Vancouver"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_vancouver"
	loading_time    =   19
	pre             =   "VC.pre"
	scnpre          =   "VCscn.pre"
	Level           =   "VC"
	Sky             =   "VC_Sky"
	qb              =   "levels\VC\VC.qb"
	colpre          =   "VCcol.pre"
	pedpre       	=   "VCped.pre"
	level_qb        =   "levels\VC\VC_scripts.qb"
	level_sfx_qb    =   "levels\VC\VC_sfx.qb"
	startup_script  =   VC_Startup
	goals_script	=	VC_goals
	setup_script	=	VC_setup
	default_stats   =   8
	level_number    =   LevelNum_VC
	extranetanimsscript = animload_Ped_Driver

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 200.0
	pitch_0          = 330.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 40.0
	pitch_1          = 330.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red  = 80
	fog_green  = 90
	fog_blue  = 120
	fog_alpha  = 30
	fog_dist  = 300.000

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6
}
; =========================
;        SLAM CITY JAM
; =========================
Level_SJ = {
	structure_name  =   Level_SJ
	load_script     =   Load_SJ
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Slam City Jam"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_slam"
	loading_time    =   12
	pre             =   "SJ.pre"
	scnpre          =   "SJscn.pre"
	Level           =   "SJ"
	//Sky             =   "SJ_Sky"
	qb              =   "levels\SJ\SJ.qb"
	colpre          =   "SJcol.pre"
	pedpre       	=   "SJped.pre"
	level_qb        =   "levels\SJ\SJ_scripts.qb"
	level_sfx_qb    =   "levels\SJ\SJ_sfx.qb"
	startup_script  =   SJ_Startup
	goals_script	=	SJ_goals
	setup_script	=	SJ_setup
	default_stats   =   8
	level_number    =   LevelNum_SJ

	ambient_red      = 58
	ambient_green    = 57
	ambient_blue     = 59
	ambient_mod_factor = 0.75

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 351
	pitch_0          = 303
	red_0            = 80
	green_0          = 63
	blue_0           = 59
	mod_factor_0     = 1.26

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 314
	pitch_1          = 272
	red_1            = 47
	green_1          = 50
	blue_1           = 52
	mod_factor_1     = 0.46

	//fog
	fog_red				=	27
	fog_blue			=	23
	fog_green			=	19
	fog_alpha			=	70
	fog_dist			=	705

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6
}
; =========================
;        MOSCOW
; =========================
Level_RU = {
	structure_name  =   Level_RU
	load_script     =   Load_RU
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Moscow"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_moscow"
	loading_time    =   14
	pre             =   "RU.pre"
	scnpre          =   "RUscn.pre"
	Level           =   "RU"
	Sky             =   "RU_Sky"
	qb              =   "levels\RU\RU.qb"
	colpre          =   "RUcol.pre"
	pedpre       	=   "RUped.pre"
	level_qb        =   "levels\RU\RU_scripts.qb"
	level_sfx_qb    =   "levels\RU\RU_sfx.qb"
	startup_script  =   RU_Startup
	goals_script	=	RU_goals
	setup_script	=	RU_setup
	default_stats   =   9
	level_number    =   LevelNum_RU

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 135.0
	pitch_0          = 330.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 300.0
	pitch_1          = 330.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red				=	140
	fog_blue			=	135
	fog_green			=	135
	fog_alpha			=	50
	fog_dist			=	500

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6
	num_f_legs=3
}
; =========================
;        AUSTRALIA
; =========================
Level_AU = {
	structure_name  =   Level_AU
	load_script     =   Load_AU
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Australia"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic"
	loading_time    =   9.5
	pre             =   "AU.pre"
	scnpre          =   "AUscn.pre"
	Level           =   "AU"
	Sky             =   "AU_Sky"
	qb              =   "levels\AU\AU.qb"
	colpre          =   "AUcol.pre"
	pedpre       	=   "AUped.pre"
	level_qb        =   "levels\AU\AU_scripts.qb"
	level_sfx_qb    =   "levels\AU\AU_sfx.qb"
	startup_script  =   AU_Startup
	goals_script	=	AU_goals
	setup_script	=	AU_setup
	default_stats   =   9
	level_number    =   LevelNum_AU

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 120.0
	pitch_0          = -127.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = -45.0
	pitch_1          = -110.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red				=	0
	fog_blue			=	0
	fog_green			=	0
	fog_alpha			=	0
	fog_dist			=	0

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6
}


; =========================
;        SECRET
; =========================
Level_SE = {
	structure_name  =   Level_SE
	load_script     =   Load_SE
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Hotter Than Hell"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_secret"
	loading_time    =   18
	pre             =   "SE.pre"
	scnpre          =   "SEscn.pre"
	Level           =   "SE"
	Sky             =   "SE_Sky"
	qb              =   "levels\SE\SE.qb"
	colpre          =   "SEcol.pre"
	pedpre       	=   "SEped.pre"
	level_qb        =   "levels\SE\SE_scripts.qb"
	level_sfx_qb    =   "levels\SE\SE_sfx.qb"
	startup_script  =   SE_Startup
	goals_script	=	SE_goals
	setup_script	=	SE_setup
	default_stats   =   10
	level_number    =   LevelNum_SE
	extranetanimsscript = animload_Ped_Baha

	ambient_red      = 44
	ambient_green    = 37
	ambient_blue     = 29
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 50.0
	pitch_0          = 360.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 270.0
	pitch_1          = 330.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red				=	0
	fog_blue			=	0
	fog_green			=	0
	fog_alpha			=	0
	fog_dist			=	0

	num_m_heads		=	8
	num_m_torsos	=	8
	num_m_legs		=	6
}


; =========================
;        TestLevel
; =========================
Level_TestLevel = {
	structure_name  =   Level_TestLevel
	load_script     =   Load_TestLevel
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "TestLevel"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic"
	loading_time    =   9.5
	pre             =   "TestLevel.pre"
	scnpre          =   "TestLevelscn.pre"
	Level           =   "TestLevel"
	Sky             =   "Green_Sky"
	qb              =   "levels\TestLevel\TestLevel.qb"
	colpre          =   "TestLevelcol.pre"
	pedpre       	=   "TestLevelped.pre"
	level_qb        =   "levels\TestLevel\TestLevel_scripts.qb"
	startup_script  =   TestLevel_Startup
	goals_script	=	TestLevel_goals
	setup_script	=	TestLevel_setup
	default_stats   =   10
	level_number    =   LevelNum_Default

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 120.0
	pitch_0          = -127.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = -45.0
	pitch_1          = -110.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red				=	0
	fog_blue			=	0
	fog_green			=	0
	fog_alpha			=	0
	fog_dist			=	0

	num_m_heads		=	10
	num_m_torsos	=	10
	num_m_legs		=	8
}


; =========================
;        OLD SCHOOL
; =========================
Level_SC = {

	structure_name  =   Level_SC
	load_script     =   Load_SC
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Old School"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic"
	loading_time    =   9.5
	loading_time_xbox    =   3
	pre             =   "SC.pre"
	scnpre          =   "SCscn.pre"
	Level           =   "SC"
	Sky             =   "SC_Sky"
	qb              =   "levels\SC\SC.qb"
	colpre          =   "SCcol.pre"
	pedpre       	=   "SCped.pre"
	level_qb        =   "levels\SC\SC_scripts.qb"
	startup_script  =   SC_Startup
	goals_script	=	SC_goals
	setup_script	=	SC_setup
	default_stats   =   5
	level_number    =   LevelNum_SC

	ambient_red = 89
	ambient_green = 79
	ambient_blue = 79
	ambient_mod_factor = 0.200

	heading_0 = 240
	pitch_0 = 190
	red_0 = 255
	green_0 = 255
	blue_0 = 255
	mod_factor_0 = 1.400

	heading_1 = 200
	pitch_1 = 190
	red_1 = 108
	green_1 = 78
	blue_1 = 78
	mod_factor_1 = 0.100


	fog_red  = 0
	fog_green  = 0
	fog_blue  = 0
	fog_alpha  = 0
	fog_dist  = 0

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}










; =========================
;        OLD Downhill Jam
; =========================
Level_DJ = {
	structure_name  =   Level_DJ
	load_script     =   Load_DJ
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Old Downhill Jam"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic"
	loading_time    =   9.5
	pre             =   "DJ.pre"
	scnpre          =   "DJscn.pre"
	Level           =   "DJ"
	Sky             =   "DJ_Sky"
	qb              =   "levels\DJ\DJ.qb"
	colpre          =   "DJcol.pre"
	pedpre       	=   "DJped.pre"
	level_qb        =   "levels\DJ\DJ_scripts.qb"
	startup_script  =   DJ_Startup
	goals_script	=	DJ_goals
	setup_script	=	DJ_setup
	default_stats   =   5
	level_number    =   LevelNum_DJ

	ambient_red = 89
	ambient_green = 79
	ambient_blue = 79
	ambient_mod_factor = 0.200

	heading_0 = 240
	pitch_0 = 190
	red_0 = 255
	green_0 = 255
	blue_0 = 255
	mod_factor_0 = 1.400

	heading_1 = 200
	pitch_1 = 190
	red_1 = 108
	green_1 = 78
	blue_1 = 78
	mod_factor_1 = 0.100

	fog_red  = 0
	fog_green  = 0
	fog_blue  = 0
	fog_alpha  = 0
	fog_dist  = 0

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}
; =========================
;        OLD PHILLY
; =========================
Level_PH = {
	structure_name  =   Level_PH
	load_script     =   Load_PH
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Old Philly"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic"
	loading_time    =   9.5
	pre             =   "PH.pre"
	scnpre          =   "PHscn.pre"
	Level           =   "PH"
	Sky             =   "PH_Sky"
	qb              =   "levels\PH\PH.qb"
	colpre          =   "PHcol.pre"
	pedpre       	=   "PHped.pre"
	level_qb        =   "levels\PH\PH_scripts.qb"
	startup_script  =   PH_Startup
	goals_script	=	PH_goals
	setup_script	=	PH_setup
	default_stats   =   5
	level_number    =   LevelNum_PH

	ambient_red = 89
	ambient_green = 79
	ambient_blue = 79
	ambient_mod_factor = 0.200

	heading_0 = 240
	pitch_0 = 190
	red_0 = 255
	green_0 = 255
	blue_0 = 255
	mod_factor_0 = 1.400

	heading_1 = 200
	pitch_1 = 190
	red_1 = 108
	green_1 = 78
	blue_1 = 78
	mod_factor_1 = 0.100


	fog_red  = 0
	fog_green  = 0
	fog_blue  = 0
	fog_alpha  = 0
	fog_dist  = 0

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}
; =========================
;        OLD Venice
; =========================
Level_VN = {
	structure_name  =   Level_VN
	load_script     =   Load_VN
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Old Venice"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_THPS2_ven"
	loading_time    =   7
	pre             =   "VN.pre"
	scnpre          =   "VNscn.pre"
	Level           =   "VN"
	Sky             =   "vn_Sky"
	qb              =   "levels\VN\VN.qb"
	colpre          =   "VNcol.pre"
	pedpre       	=   "VNped.pre"
	level_qb        =   "levels\VN\VN_scripts.qb"
	startup_script  =   VN_Startup
	goals_script	=	VN_goals
	setup_script	=	VN_setup
	default_stats   =   5
	level_number    =   LevelNum_VN

	ambient_red = 89
	ambient_green = 79
	ambient_blue = 79
	ambient_mod_factor = 0.200

	heading_0 = 240
	pitch_0 = 190
	red_0 = 255
	green_0 = 255
	blue_0 = 255
	mod_factor_0 = 1.400

	heading_1 = 200
	pitch_1 = 190
	red_1 = 108
	green_1 = 78
	blue_1 = 78
	mod_factor_1 = 0.100

	fog_red  = 0
	fog_green  = 0
	fog_blue  = 0
	fog_alpha  = 0
	fog_dist  = 0

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}

; =========================
;        OLD Hangar
; =========================
Level_HN = {
	structure_name  =   Level_HN
	load_script     =   Load_HN
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Old Hangar"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_THPS2_hang"
	loading_time    =   5.5
	loading_time_xbox    =   3.5
	pre             =   "HN.pre"
	scnpre          =   "HNscn.pre"
	Level           =   "HN"
	Sky             =   "HN_Sky"
	qb              =   "levels\HN\HN.qb"
	colpre          =   "HNcol.pre"
	pedpre       	=   "HNped.pre"
	level_qb        =   "levels\HN\HN_scripts.qb"
	startup_script  =   HN_Startup
	goals_script	=	HN_goals
	setup_script	=	HN_setup
	default_stats   =   5
	level_number    =   LevelNum_HN

	ambient_red = 89
	ambient_green = 79
	ambient_blue = 79
	ambient_mod_factor = 0.200

	heading_0 = 240
	pitch_0 = 190
	red_0 = 255
	green_0 = 255
	blue_0 = 255
	mod_factor_0 = 1.400

	heading_1 = 200
	pitch_1 = 190
	red_1 = 108
	green_1 = 78
	blue_1 = 78
	mod_factor_1 = 0.100

	fog_red  = 0
	fog_green  = 0
	fog_blue  = 0
	fog_alpha  = 0
	fog_dist  = 0

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}

; =========================
;        School 2
; =========================
Level_SC2 = {
	structure_name  =   Level_SC2
	load_script     =   Load_SC2
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "School II"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_THPS2_sch"
	loading_time    =   8.5
	pre             =   "SC2.pre"
	scnpre          =   "SC2scn.pre"
	Level           =   "SC2"
	Sky             =   "sc2_Sky"
	qb              =   "levels\SC2\SC2.qb"
	colpre          =   "SC2col.pre"
	pedpre       	=   "SC2ped.pre"
	level_qb        =   "levels\SC2\SC2_scripts.qb"
	startup_script  =   SC2_Startup
	goals_script	=	SC2_goals
	setup_script	=	SC2_setup
	default_stats   =   5
	level_number    =   LevelNum_SC2

	ambient_red      = 72
	ambient_green    = 72
	ambient_blue     = 72
	ambient_mod_factor = .2

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = -30
	pitch_0          = -60
	red_0            = 110
	green_0          = 110
	blue_0           = 105
	mod_factor_0     = .9

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 200
	pitch_1          = 33
	red_1            = 23
	green_1          = 24
	blue_1           = 30
	mod_factor_1     = .9

	fog_red  = 0
	fog_green  = 0
	fog_blue  = 0
	fog_alpha  = 0
	fog_dist  = 0

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}

; =========================
;        Wild Wild West
; =========================
Level_WWW = {
	structure_name  =   Level_WWW
	load_script     =   Load_WWW
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "West Side"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic"
	loading_time    =   9.5
	pre             =   "WWW.pre"
	scnpre          =   "WWWscn.pre"
	Level           =   "WWW"
	Sky             =   "WWW_Sky"
	qb              =   "levels\WWW\WWW.qb"
	colpre          =   "WWWcol.pre"
	pedpre       	=   "WWWped.pre"
	level_qb        =   "levels\WWW\WWW_scripts.qb"
	level_sfx_qb    =   "levels\WWW\WWW_sfx.qb"
	startup_script  =   WWW_Startup
	goals_script	=	WWW_goals
	setup_script	=	WWW_setup
	default_stats   =   5
	level_number    =   LevelNum_WWW

	ambient_red = 89
	ambient_green = 79
	ambient_blue = 79
	ambient_mod_factor = 0.200

	heading_0 = 240
	pitch_0 = 190
	red_0 = 255
	green_0 = 255
	blue_0 = 255
	mod_factor_0 = 1.400

	heading_1 = 200
	pitch_1 = 190
	red_1 = 108
	green_1 = 78
	blue_1 = 78
	mod_factor_1 = 0.100

	fog_red  = 0
	fog_green  = 0
	fog_blue  = 0
	fog_alpha  = 0
	fog_dist  = 0

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}


; =========================
;        TEST LEVEL
; =========================
Level_Test = {
	structure_name  =   Level_Test
	load_script     =   Load_Test
	// The replay code will put this name in the summary info that is displayed for mem card saves.
	name            =   "Manhattan"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic"
	loading_time    =   9.5
	pre             =   "Test.pre"
	scnpre          =   "Testscn.pre"
	Level           =   "Test"
	Sky             =   "NY_Sky"
	qb              =   "levels\Test\Test.qb"
	colpre          =   "Testcol.pre"
	pedpre       	=   "Testped.pre"
	level_qb        =   "levels\NY\NY_scripts.qb"
	startup_script  =   NY_Startup
	goals_script	=	NY_goals
	setup_script	=	NY_setup
	default_stats   =   6
	level_number    =   LevelNum_NY

	ambient_red      = 69
	ambient_green    = 72
	ambient_blue     = 79
	ambient_mod_factor = 0.3

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 120.0
	pitch_0          = -127.0
	red_0            = 130
	green_0          = 120
	blue_0           = 97
	mod_factor_0     = 1.4

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = -45.0
	pitch_1          = -110.0
	red_1            = 58
	green_1          = 62
	blue_1           = 66
	mod_factor_1     = 0.1

	//fog
	fog_red				=	0
	fog_blue			=	0
	fog_green			=	0
	fog_alpha			=	0
	fog_dist			=	0

	num_m_heads		=	4
	num_m_torsos	=	4
	num_m_legs		=	4
}


; =========================
;        SKATESHOP
; =========================
; -------------------------

script Load_SkateShop
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	;launch_the_void
	load_level level_Mainmenu
endscript

level_mainmenu = {
	structure_name  =   level_mainmenu
	load_script     =   Load_skateshop
	name            =   "Skateshop"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_generic";mainmenu"
	loading_time    =   7.5
	loading_time_xbox    =   3.5
	level_name		= 	"skateshop"
	pre             =   "mainmenu.pre";"skateshop.pre"
	scnpre          =   "mainmenuscn.pre";"skateshopscn.pre"
	Level           =   "mainmenu";"skateshop"
	;Sky             =   "skateshop_Sky"
	qb              =   "levels\mainmenu\mainmenu.qb";"levels\skateshop\skateshop.qb"
	colpre          =   "mainmenucol.pre";"skateshopcol.pre"
	;pedpre			=   "skateshopped.pre"
	level_qb        =   "levels\mainmenu\mainmenu_scripts.qb" ;"levels\skateshop\skateshop_scripts.qb"
	startup_script  =   mainmenu_startup ;launch_the_void
	;goals_script	=	skateshop_goals
	default_stats   =   8
	level_number    =   LevelNum_Skateshop
	frontend_level	=	1

	ambient_red      = 66
	ambient_green    = 67
	ambient_blue     = 68
	ambient_mod_factor = 0.0

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = -90.0
	pitch_0          = -10.0
	red_0            = 0;100
	green_0          = 0;97
	blue_0           = 0;92
	mod_factor_0     = 0.0

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = -120.0
	pitch_1          = 120.0
	red_1            = 0;37
	green_1          = 0;34
	blue_1           = 0;26
	mod_factor_1     = 0.0
}

script Load_CAS
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level level_cas
endscript

level_cas = {
	structure_name  =   level_cas
	load_script     =   load_cas
	name            =   "CAS"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_mainmenu"
	loading_time    =   14.5
	loading_time_xbox    =   4.5
	pre             =   "cas_bedroom.pre"
	scnpre          =   "cas_bedroomscn.pre"
	Level           =   "cas_bedroom"
	Sky             =   "CAS_bedroom_Sky"
	qb              =   "levels\cas_bedroom\cas_bedroom.qb"
	colpre          =   "cas_bedroomcol.pre"
	;pedpre			=   "skateshopped.pre"
	level_qb        =   "levels\cas_bedroom\cas_bedroom_scripts.qb"
	startup_script  =   cas_bedroom_startup
	;goals_script	=	skateshop_goals
	default_stats   =   8
	level_number    =   LevelNum_CAS
	frontend_level	=	1

	// Bedroom Default Lighting Values
	ambient_red      = 66
	ambient_green    = 67
	ambient_blue     = 68
	ambient_mod_factor = 0.0

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 220.0
	pitch_0          = 320.0
	red_0            = 45
	green_0          = 35
	blue_0           = 32
	mod_factor_0     = 0.0

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 10.0
	pitch_1          = 320.0
	red_1            = 32
	green_1          = 34
	blue_1           = 26
	mod_factor_1     = 0.0
	/*
	// SP: Old Bedroom lighting values prior to 8/21/03
	ambient_red      = 66
    ambient_green    = 67
    ambient_blue     = 68
    ambient_mod_factor = 0.0

    //direction_0      = (0.5, 0.8660254, 0.0)
    heading_0	     = -220.0
    pitch_0          = -40.0
    red_0            = 100
    green_0          = 97
    blue_0           = 92
    mod_factor_0     = 0.0

    //direction_1      = (0.0, 1.0, 0.0)
    heading_1	     = -180.0
    pitch_1          = 100.0
    red_1            = 37
    green_1          = 34
    blue_1           = 26
    mod_factor_1     = 0.0
*/
}

script load_boardshop
	// DO NOT ADD TO OR CHANGE THIS SCRIPT
	// IT MUST REMAIN ONE LINE LONG
	load_level level_boardshop
endscript

level_boardshop = {
	structure_name  =   level_boardshop
	load_script     =   load_boardshop
	name            =   "Boardshop"
	;ambient_track   =   "music\amb_skate"
	loading_screen  =   "loadscrn_boardshop"
	loading_time    =   7.5
	loading_time_xbox    =   3
	pre             =   "nj_skateshop.pre"
	scnpre          =   "nj_skateshopscn.pre"
	Level           =   "nj_skateshop"
	;Sky             =   "skateshop_Sky"
	qb              =   "levels\nj_skateshop\nj_skateshop.qb"
	colpre          =   "nj_skateshopcol.pre"
	;pedpre			=   "skateshopped.pre"
	level_qb        =   "levels\nj_skateshop\nj_skateshop_scripts.qb"
	startup_script  =   boardshop_startup
	;goals_script	=	skateshop_goals
	;default_stats   =   8
	level_number    =   LevelNum_boardshop
	frontend_level	=	1

	ambient_red      = 66
	ambient_green    = 67
	ambient_blue     = 68
	ambient_mod_factor = 0.0

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = -220.0
	pitch_0          = -40.0
	red_0            = 100
	green_0          = 97
	blue_0           = 92
	mod_factor_0     = 0.0

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = -180.0
	pitch_1          = 100.0
	red_1            = 37
	green_1          = 34
	blue_1           = 26
	mod_factor_1     = 0.0
}




; =========================
;        ART LEVEL
; =========================
; (Mick)  Is this used at all?  If not, then delete it
/*script Load_Default
    ;SetUpBasicLights
    LoadNodeArray "levels\Default\Default.qb"
    //SetClippingDistances near = 12 far = 22000

    ambient_red      = 255
    ambient_green    = 73
    ambient_blue     = 73
    ambient_mod_factor = .2

    //direction_0      = (0.5, 0.8660254, 0.0)
    heading_0	     = -30
    pitch_0          = -60
    red_0            = 110
    green_0          = 110
    blue_0           = 105
    mod_factor_0     = .8

    //direction_1      = (0.0, 1.0, 0.0)
    heading_1	     = 200
    pitch_1          = 33
    red_1            = 22
    green_1          = 23
    blue_1           = 30
    mod_factor_1     = .1

	//quickview
    //gameflow            StandardGameFlowToggleView
endscript*/


; =========================
;        Sk5Ed
; =========================
script GenerateLevelStructureNameFromTheme
	if (<theme> > 0)
		FormatText ChecksumName=structure_name "Level_sk5ed%d" d=(<theme>+1)
	else
		structure_name=Level_Sk5Ed
	endif
	return structure_name=<structure_name>
endscript

script Load_Sk5Ed
	GetEditorTheme
	load_parked_textures_to_main_memory

	GenerateLevelStructureNameFromTheme theme=<theme>

	if IsXbox
		load_level <structure_name>	loading_screen	= "loadscrn_editor_x"
	endif
	if IsNgc
		load_level <structure_name>	loading_screen	= "loadscrn_editor_ngc"
	endif
	if IsPS2
		load_level <structure_name>	loading_screen	= "loadscrn_editor"
	endif
endscript

script Load_Sk5Ed_gameplay
	GetEditorTheme
	if (<theme> > 0)
		FormatText ChecksumName=structure_name "Level_sk5ed%d" d=(<theme>+1)
	else
		structure_name=Level_Sk5Ed
	endif

	load_level <structure_name> startup_script = Sk5Ed_Startup_gameplay loading_screen = "loadscrn_created"
endscript

Level_sk5ed_defaults=
{
	park_editor
	load_script     =   Load_sk5ed
	name            =   "Created Park"
	loading_screen  =   "loadscrn_editor_play"
	loading_time    =   11
	loading_time_xbox    =   4.5
	startup_script  =   Sk5Ed_Startup
	goals_script	=	Sk5Ed_goals
	default_stats   =   10
	level_number    =   LevelNum_Sk5ed
	pre             =   "sk5ed.pre"
	Level           =   "sk5ed"
	Level_Name      =   "sk5ed"         // level name should be the smae for all themes
	colpre          =   "sk5edcol.pre"
	pedpre			=   "sk5edped.pre"
	level_qb        =   "levels\sk5ed\sk5ed_scripts.qb"
	qb              =   "levels\sk5ed\sk5ed.qb"
	extranetanimsscript = animload_Ped_Baha

	ambient_red      = 72
	ambient_green    = 72
	ambient_blue     = 72
	ambient_mod_factor = 0.5

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 90.0
	pitch_0          = -60.0
	red_0            = 75
	green_0          = 75
	blue_0           = 75
	mod_factor_0     = 0.7

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 0.0
	pitch_1          = -90.0
	red_1            = 0
	green_1          = 0
	blue_1           = 0
	mod_factor_1     = 1.0

	// Mick:  Need default fog values for TOD_day
	fog_red  = 0
	fog_green  = 0
	fog_blue  = 0
	fog_alpha  = 0
	fog_dist  = 0

}

Level_Sk5Ed = {
	Level_sk5ed_defaults
	structure_name  =   Level_Sk5Ed

	loading_time    =   8
	loading_time_xbox    =   4.5
	scnpre          =   "sk5edscn.pre"
	Sky             =   "sk5ed_Sky"
	outer_shell	    =   "sk5ed_shell"
	theme_name      =   "Suburbia"
}

Level_Sk5Ed2 = {
	Level_sk5ed_defaults
	structure_name  =   Level_Sk5Ed2

	loading_time    =   8
	scnpre          =   "sk5ed2scn.pre"
	Sky             =   "sk5ed2_Sky"
	outer_shell	    =   "sk5ed2_shell"
	theme_name      =   "City Rooftop"
}

Level_Sk5Ed3 = {
	Level_sk5ed_defaults
	structure_name  =   Level_Sk5Ed3

	loading_time    =   8
	scnpre          =   "sk5ed3scn.pre"
	Sky             =   "sk5ed3_Sky"
	outer_shell	    =   "sk5ed3_shell"
	theme_name      =   "Lost Island"
}

Level_Sk5Ed4 = {
	Level_sk5ed_defaults
	structure_name  =   Level_Sk5Ed4

	loading_time    =   8
	scnpre          =   "sk5ed4scn.pre"
	Sky             =   "sk5ed4_Sky"
	outer_shell	    =   "sk5ed4_shell"
	theme_name      =   "Warehouse"
}

Level_Sk5Ed5 = {
	Level_sk5ed_defaults
	structure_name  =   Level_Sk5Ed5

	loading_time    =   11
	scnpre          =   "sk5ed5scn.pre"
	Sky             =   "sk5ed5_Sky"
	outer_shell	    =   "sk5ed5_shell"
	theme_name      =   "Prison Yard"
}

