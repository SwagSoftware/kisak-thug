dont_unhide_loading_screen = 0

script Game_Update
	// This function gets run once-per-frame by the Skate module
	// It's great for running Update() functions
	// NOTE:  It is not affected by any pause logic!
	GoalManager_UpdateAllGoals
endscript

script WaitFrameLoop
	begin
		wait 1 gameframe
	repeat
endscript

// SetGameState used to be a CFunc, but is now a script command
// so it might be factored out laters
script SetGameState
	SetCurrentGameType              // CFunc
	cleanup_before_loading_level    // Script
	LaunchGame                      // CFunc
endscript


script load_requested_level
	GetCurrentLevel             // returns "level" checksum, like load_sch
	LoadLevel level=<level>
endscript


script InitializeGameFlow
	// if server flag has been set, then start the server (formerly GameFlow_StartServer)
	;	if OnServer
	;		printf "*** START SERVER HERE ***"
	;		SetServerMode
	;		StartServer
	;		JoinServer <...>
	;	endif

	load_requested_level
	StandardGameFlow
endscript

script ChangeLevelGameFlow
	// reset the game options window when you change levels
	change FirstTimeInSplitScreen = 1

	if Not IsObserving
		Skater:SetCustomRestart clear   // clear the local skater's custom restart whenever we change level
	endif
	load_requested_level

	// Dan, TT13290.  In split screen games at this point in game flow, the skaters exist but there are no corresponding
	// players.  As such, the trigger scripts of the restart nodes that this ResetSkaters call will send the skaters to
	// will cause asserts in certain situations.
	if not InSplitScreenGame
		ResetSkaters
	endif

	if InNetGame
		if Not GameModeEquals is_lobby
			SetGameType netlobby
			SetCurrentGameType
		endif
		if OnServer
			GetPreferenceChecksum pref_type=network team_mode
			// Override num_teams in the lobby mode definition with the current preference
			switch <checksum>
				case teams_none
					SetNumTeams 0
					printf "Team mode off"
				case teams_two
					SetNumTeams 2
					printf "2 Teams"
				case teams_three
					SetNumTeams 3
					printf "3 Teams"
				case teams_four
					SetNumTeams 4
					printf "4 Teams"
			endswitch
		endif
	endif
	// (formerly GameFlow_WaitForSkaters)
	begin
		if SkatersAreReady
			break
		endif
		wait 1 gameframe
	repeat

	SetScreenModeFromGameMode
	StandardGameFlow

endscript


script pause_game_flow
	printf "Pausing game flow"
	PauseGameFlow
	Wait 1 gameframe
endscript

script unpause_game_flow
	printf "Unpausing game flow"
	UnpauseGameFlow
endscript


script  GameFlow_Startup


	// We disable all pausing until we are actually playing the game
	DisablePause

	// unsetting all flags that are used to delay
	// goal completion messages in the case that multiple
	// goals are completed simultaneously
	//    UnSetWaitForGoalFlags

	// clear the screen mode to default
	;SetScreenMode one_camera

	if InSplitScreenGame
		// disable player 1 vibration
		if VibrationIsOn 0
			VibrationOff 0
			turn_vibration_back_on=1
		endif
		// disable player 2 vibration
		if VibrationIsOn 1
			VibrationOff 1
			turn_player2_vibration_back_on=1
		endif
	endif

	// (formerly GameFlow_WaitForSkaters)
	if InNetGame
		begin
			wait 1 gameframe
			if SkatersAreReady
				break
			endif
		repeat 120

		begin
			if SkatersAreReady
				dialog_box_exit
				break
			endif
			if Not SkatersAreReady
				if Not ScreenElementExists id=dialog_box_anchor
					if Not ScreenElementExists id=quit_dialog_anchor
						HideLoadingScreen
						exit_pause_menu
						create_dialog_box {  title=net_status_msg
							text=net_message_waiting
							buttons=[  	{ text="Quit" pad_choose_script=quit_network_game }
							]
							no_animate
						}
					endif
				endif
			endif
			wait 1 gameframe
		repeat
	else
		begin
			wait 1 gameframe
			if SkatersAreReady
				break
			endif
		repeat
	endif

	// restore player 1 vibration
	if GotParam turn_vibration_back_on
		wait 2 gameframes
		VibrationOn 0
	endif
	// restore player 2 vibration
	if GotParam turn_player2_vibration_back_on
		if not GotParam turn_vibration_back_on
			wait 2 gameframes
		endif
		VibrationOn 1
	endif

	// GJ: hide clock so it doesn't interfere
	// with the intro script...  the skaters
	// must exist by the time you get here
	// or else this function has no effect
	;HideClock
	RestartLevel

	// reset the skaters - turn their panels off
	InitializeSkaters
	KillMessages			//get rid of SKATE letters on the side of the screen and anything else
	PauseStream 0


	if InNetGame
		if GameModeEquals is_lobby
			if OnServer
				server_enter_free_skate
			else
				if IsHost
					server_enter_free_skate
				endif
				client_enter_free_skate
			endif

			if InInternetMode
				if OnServer
					PostGame
				endif
			endif
		endif
	endif

	if Not InNetGame
		ReinsertSkaters
	endif

	// applies the screen mode for this game mode
	SetScreenModeFromGameMode

	if InMultiplayerGame
		destroy_panel_stuff
		create_panel_stuff
	endif
	if GameModeEquals is_horse
		StartHorse
	endif

	// Clean up the replay stuff, and only reallocate if not in a net game,
	// since the net game needs more memory.
	// (don't allocate in any multiplayer game)
	DeallocateReplayMemory
	if Not InMultiPlayerGame
		if not CareerLevelIs LevelNum_Skateshop
			AllocateReplayMemory
			// K: This is a flag that gets set at the end of the run in single-session that
			// causes the replays to quit to the paused menu when they end,
			// if they got started during the end-of-run.
			// Must ensure this is off the rest of the time, so reset it before
			// the level starts.
			Change EndOfReplayShouldJumpToPauseMenu=0
			if NeedToLoadReplayBuffer
				if LoadReplayData
					view_loaded_replay
				else
					printf "Loading replay from mem card failed !!!"
					// If this happens, it will just start the level as usual.
				endif
			endif
		endif
	endif

	// K: This is to make the active camera be correct when autoloading into the park editor
	if CustomParkMode editing
		SetActiveCamera id=parked_cam
	endif

	// Create the camera used by the view-gaps menu
	create_menu_camera
endscript

dont_restore_start_key_binding = 0
show_career_startup_menu=1

script GameFlow_StartRun
	if Not LevelIs load_skateshop
		if GameModeEquals is_singlesession
			; printf "*********** SETTING END OF RUN TYPE ********"
			; StartGoal_TrickAttack time=120
			GoalManager_SetEndRunType name=TrickAttack EndOfRun
			GoalManager_EditGoal name=TrickAttack params={ time=120 restart_node=#"P1: Restart" }
			; SetScoreAccumulation 1
		endif
	endif

	// Clean that skater up and get rid of his scuffs
	if InSplitscreenGame
		GetSkaterId	skater=0
		<ObjId>:Obj_SpawnScript CleanUp_Scuffs
		GetSkaterId	skater=1
		<ObjId>:Obj_SpawnScript CleanUp_Scuffs
	else
		if Not IsObserving
			Skater:Obj_SpawnScript CleanUp_Scuffs
		endif
	endif
	// check the status of Pro trick Objects and turn them off if need be
	// see gamemenu.q

	if Not IsTrue Bootstrap_Build
		if Not InNetGame
			toggle_geo_nomenu toggle_comp_geo_params
		endif
	endif
	toggle_geo_nomenu toggle_proset1_params
	toggle_geo_nomenu toggle_proset2_params
	toggle_geo_nomenu toggle_proset3_params
	toggle_geo_nomenu toggle_proset4_params
	toggle_geo_nomenu toggle_proset5_params
	toggle_geo_nomenu toggle_proset6_params
	toggle_geo_nomenu toggle_proset7_params

	if not LevelIs load_cas
		PlaySkaterCamAnim skater = 0 stop
	endif

	// Skaters are ready to go. Put them at the restart and away we go
	DisablePause

	ResetSkaters
	if IsCareerMode
		UnSetGlobalFlag flag=PROMPT_FOR_SAVE
	Endif

	printf "starting a run....skip tracks and crank up the music"
	if GameModeEquals is_horse
	else					   //SP: skipping tracks in HORSE is annoying
		SkipMusicTrack
	endif
	if IsCareerMode
		// in the THPS4 Career mode we are going to try only playing music while in goals...
		if IsTrue ALWAYSPLAYMUSIC
			PauseMusic 0
		else
			PauseMusic 1
		endif
	else
		PauseMusic 0
	endif


	// GJ: starts game timer in certain modes (formerly GameMode_StartGameTimer)
	if GameModeEquals default_time_limit
		UnSetFlag flag = GOAL_MID_GOAL
		ResetClock
		;HideClock
	else
		;HideClock
	endif

	// print up the score to beat if horse
	if GameModeEquals is_horse
		horse_start_run
	endif

	// Bring us up to speed on the state of the world in network games
	if InNetGame
		if OnServer
		else
			LaunchQueuedScripts
			if IsObserving
				ShowAllObjects
				if GameModeEquals is_goal_attack
					GoalManager_InitializeAllSelectedGoals
				endif
			endif
		endif
	endif

	if LevelIs load_cas
		if ( in_cinematic_sequence = 1 )
			killskatercamanim all
			unpausegame
			change check_for_unplugged_controllers = 0
			play_first_cutscene
			return
		endif
	endif

	if not ( next_level_script = nullscript )
		if ( next_level_script = select_sponsor_select_after_movies )
			DisplayLoadingScreen blank
			change dont_unhide_loading_screen = 1
			change dont_restore_start_key_binding = 1
		endif
		SpawnScript next_level_script
		change next_level_script = nullscript
	endif

	<should_check_for_controllers> = 1
	if LevelIs load_nj
		if ( in_cinematic_sequence = 1 )
			<should_check_for_controllers> = 0
			change in_cinematic_sequence=0

			killskatercamanim all
			unpausegame
			SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_01V
			PlayCutscene name="cutscenes\NJ_01V.cut" exitScript=ChapterTitle_and_Restore_Start_Key dont_unload_anims
			return
		endif
	endif

	if ( <should_check_for_controllers> = 1 )
		// this script waits for the screen to draw properly
		// before telling the skate module to start checking for
		// unplugged controllers
		SpawnScript wait_and_check_for_unplugged_controllers
	endif

	if GameModeEquals is_career
		if not LevelIs load_skateshop
			if not LevelIs load_cas
				if not LevelIs load_boardshop
					//if not (DEMO_BUILD)
					Skater:StatsManager_ActivateGoals
					//endif
					if ( show_career_startup_menu = 1 )
						create_career_startup_menu
						spawnscript reset_show_career_startup_menu
						return
					else
						if not ( (change_level_goal_id[0]) = null )
							// start goal
							goal_accept_trigger goal_id=(change_level_goal_id[0]) force_start
							// reset flag
							array_name=change_level_goal_id
							SetArrayElement ArrayName=array_name index=0 newvalue=null
							return
						endif
					endif
				endif
			endif
		endif
	endif

	if not LevelIs load_skateshop
		if not ( dont_restore_start_key_binding = 1 )
			restore_start_key_binding
		endif
	endif

	if not LevelIs load_skateshop
		if not LevelIs load_cas
			if not LevelIs load_boardshop
				if ( launch_to_createatrick = 1 )
					if LevelIs load_nj
						Skater:Obj_MoveToNode name=TRG_G_CAT_RestartNode Orient NoReset
					endif
					PauseGame
					change inside_pause=1

					if MusicIsPaused
						change music_was_paused=1
					else
						change music_was_paused=0
					endif
					PauseMusicAndStreams 1

					pause_menu_gradient on
					create_pre_cat_menu from_mainmenu
					change launch_to_createatrick=0
					change check_for_unplugged_controllers=1
					return
				endif
			endif
		endif
	endif

	// If playing a created park apply the time-of-day lighting.
	// parked_set_tod will apply the lighting according to the park editor's
	// stored time-of-day state.
	// (It stores the name of the script to be passed in the tod_action parameter
	// to the script_change_tod script)
	if LevelIs load_sk5ed_gameplay
		parked_set_tod
	else
		// If in a multiplayer game, then we might actually have restarted a game
		// so we need to reset the TOD so sound boxes are re-created
		if InMultiplayerGame
			script_set_level_tod
		endif
	endif

endscript

// This is the main loop where we are actualy playing the game
script GameFlow_PlayRun
	// AlwaysDump can be set to 1 (in your startup)  so every time you run the code, you get a dump of
	// the memory usage
	// and only the first time
	if IsTrue   AlwaysDump
		DumpHeaps
		change  AlwaysDump = 0
	endif

	//Uh oh...SP put in another hack to make the "quick startup" menu appear...
	// better check out startup.q and make sure to rewrite this later.
	// this is only for proof of conceptness...

	if not LevelIs load_skateshop
		if not RunningReplay
			if ScreenElementExists id=controller_unplugged_dialog_anchor
				kill_start_key_binding
			else
				if ( show_career_startup_menu = 0 )
					if not ( dont_restore_start_key_binding = 1 )
						Restore_Start_Key_Binding  //allow the player to now pause the game
					endif
				endif
			endif
		endif
	endif

	// K: Fixes bug where pause menu was not working when in creategoals mode.
	if GameModeEquals is_creategoals
		Restore_Start_Key_Binding
	endif


	if isTrue bootstrap_build
		if CareerLevelis LevelNum_Sch
			if isTrue STARTGAME_FIRST_TIME
				create_startup_menu
			endif
		endif
	endif

	if InSplitScreenGame
		if IsTrue FirstTimeInSplitscreen
			PauseGame
		endif
	endif

	// need to wait one game frame so that the
	// next_level_script has a chance to start
	// (the next_level_script possibly plays a
	// cutscene, which will need to have started
	// by the time of the following if-test)
	wait 1 gameframe

	// if there's a cutscene playing, we'll need
	// to wait until the data is completely loaded
	// and the video has started playing, or else
	// the unsuspended objects can overflow the
	// DMA buffer on the first rendered frame
	if IsMovieQueued
		begin
			if HasMovieStarted
				break
			endif
			wait 1 gameframe
		repeat
	endif

	// this used to be "wait 3 gameframes",
	// but we moved one of them before
	// the preceding if-test to force
	// any cutscenes launched from the
	// next_level_script to start playing
	wait 2 gameframe

	change is_changing_levels=0

	if not ( dont_unhide_loading_screen = 1 )
		HideLoadingScreen
	endif

	if InSplitScreenGame

		SetActivecamera id=skatercam0 viewport=0
		SetActiveCamera id=skatercam1 viewport=1

		if IsTrue FirstTimeInSplitscreen
			// hide both skaters while the splitscreen menu is up
			// need to do this after ResetSkaters, 'cause
			// that's where we move to a new restart
			;			MakeSkaterGosub remove_skater_from_world skater=0
			;			MakeSkaterGosub remove_skater_from_world skater=1

			// we could theoretically go to a
			// splitscreen menu restart point here...

			;			SwitchToMenu menu=splitscreen_setup_menu
			;
			;			// pause the game flow until we "X" past the screen
			;			pause_game_flow

			ScreenElementSystemCleanup
			change FirstTimeInSplitscreen = 0
			PauseGame
			create_end_run_menu
		endif
	endif

	if InMultiplayerGame
		//UseBothPadsInFrontEnd
	else
		UseOnePadInFrontEnd
	endif

	EnableActuators
	EnablePause

	refresh_poly_count   // bit of a patch, but basically here so it will get run when we change levels

	begin
		// if eitwher the "End Run" was selected or end conditions were met
		if ShouldEndRun
			printf "************ SHOULD BREAK"
			break
		endif
		if GameModeEquals is_horse
			if FirstTrickStarted
				HideClock
				// force an end of run to occur at the end of the current combo
				GoalManager_ZeroGoalTimer name=horse_mp
				printf "************ TRICK STARTED"
				// now that the first trick has started,
				// break out of main loop, and wait for
				// player's last trick combo to end
				break
			endif
		endif
		wait 1 gameframe
		;if GetFlag flag=GameFlagChangeLevelToSuburbia
		;    UnSetFlag flag=GameFlagChangeLevelToSuburbia
		;    ChangeLevelToSuburbia
		;Endif
	repeat
endscript

script  GameFlow_WaitEnd
	printf "************ IN GAMEFLOW_WAITEND"
	begin
		if EndRunSelected
			break
		endif
		if IsCareerMode
			// New format for career mode
			// (Time limit applies to individual goals)
			if TimeUp
				TimeUpScript
			endif
		else
			if GameModeEquals is_singlesession
				break
			else
				if Not LevelIs load_skateshop
					;printf "waiting"
					// standard end run
					if AllSkatersAreIdle
						break
					endif
				endif
			endif
		endif
		wait 1 gameframe   ; we don't need to check these things every frame
		// Dan, TT13593: Yes we do.  This is the loop which will push the skaters into EndOfRun.
		// If it's not called every frame, they can easily escape in the ten frame window.
	repeat


	EnableActuators 0

	printf "About to disable"
	// the game might be paused already here (gameflow keeps running)
	// if it is paused, we want to wait until it is unpaused
	// however, the menu might not have come up
	// so we could disable pause, and then be in the menu (and paused)
	// The basic problem being that when the user pauses the game, it keeps going for one frame
	// so if it is the last frame of the game, it just drops into the following code, and the fact that
	// the game is paused has no effect, as that just stops objects moving and stuff
	// the end of run script will be spawned and run just fine behind the menu
	DisablePause
	wait 2 game frames          // give any menu a chance to come up
	// if the game is paused, we should unpause it.....
	if not GameModeEquals is_singlesession
		if not InSplitScreenGame
			UnpauseGame                 // unpause the game
		endif
	endif
	; DisablePause
	wait 2 game frames          // give any menu a chance to go away

	KillMessages
	KillSpawnedScript name=SK3_Killskater_Finish	    ; kill script that might be killing skater
endscript




script GameFlow_End

	printf "************** IN GAMEFLOW END************"
	// (formerly GameFlow_CalculateFinalScores)
	begin
		if CalculateFinalScores
			break
		endif
		wait 1 gameframe
	repeat


	if IsCareerMode
		//        Goal_CheckProVideoUnlock
		if GetGlobalFlag flag=SHOW_CREDITS
			UnSetGlobalFlag flag=SHOW_CREDITS
			if CD
				wait 1 gameframe
				ingame_play_movie  "movies\credits"  // play credits movie
			Endif
		Endif
		// Brad - don't call this here!
		; UpdateRecords
		; Statistics_screen
	else
		if IsCustomPark
			// No records in custom park
		else
			if GameModeEquals is_singlesession
				// Brad - don't call this here!
				; UpdateRecords
				; Statistics_screen
			endif
		endif
	endif

	// displays "stats" here, if we just got one
	if JustGotFlag flag=GOAL_STAT_POINT1
		printf "stat point"
		SwitchToMenu menu=stats_menu
		pause_game_flow
	else
		if JustGotFlag flag=GOAL_STAT_POINT2
			printf "stat point"
			SwitchToMenu menu=stats_menu
			pause_game_flow
		else
			if JustGotFlag flag=GOAL_STAT_POINT3
				printf "stat point"
				SwitchToMenu menu=stats_menu
				pause_game_flow
			else
				if JustGotFlag flag=GOAL_STAT_POINT4
					printf "stat point"
					SwitchToMenu menu=stats_menu
					pause_game_flow
				else
					if JustGotFlag flag=GOAL_STAT_POINT5
						printf "stat point"
						SwitchToMenu menu=stats_menu
						pause_game_flow
					endif
				endif
			endif
		endif
	endif

	// also reset the helper text
	;helper_select_choose_back_centered

	// displays ranking screen, if necessary (formerly GameFlow_PrintWinner)
	if GameModeEquals show_ranking_screen
		//helper_hide

		// make sure there's no panel messages going into
		// the winner screen...  otherwise, they don't
		// get reset properly when the next game starts...
		//KillMessages all_panels

		//SwitchToMenu menu=winner_screen
	endif

	if InNetGame
		if OnServer
			wait 5 gameframes
			LoadPendingPlayers
		endif
	endif

endscript


script StandardGameFlow

	printf "starting standard gameflow"
	GameFlow_Startup
	StandardGameFlowBody
endscript


script StandardGameFlowToggleView

	printf "starting standard gameflow"
	GameFlow_Startup
	ToggleViewMode
	StandardGameFlowBody
endscript


script StandardGameFlowBody
	begin
		GameFlow_StartRun
		GameFlow_PlayRun
		GameFlow_WaitEnd

		// do something similar for horse mode
		if GameModeEquals is_horse
			if EndRunSelected
				break
			endif

			horse_end_run

			if HorseEnded
				// someone lost the game
				break
			else
				// swap players
				InitializeSkaters
			endif
		else
			// non-horse, so we just break out, as we only want to play one round
			break
		endif
	repeat

	if GameModeEquals is_horse
		horse_uninit
	endif
	GameFlow_End
	// just stay in an idle loop (formerly GameFlow_Exit)
	WaitFrameLoop
endscript

script spawn_movie
	spawnscript play_movie_task params={<...>}
endscript


script play_movie_task
	playmovie_script <...>
endscript


// ShowAllObjects is called in Observer mode to do platform specfic
// visiblity (turning on all the objects in the level that would be turned off
// by proxmity nodes).  This was for Skate3, and might not be needed for skate4.
script ShowAllObjects
	;if CareerLevelIs LevelNum_Foundry
	;Endif
	;if CareerLevelIs LevelNum_Canada
	;    AJC_Script_Can_Network_Startup
	;Endif
	;if CareerLevelIs LevelNum_Suburbia
	;Endif
	;if CareerLevelIs LevelNum_SkaterIsland
	;Endif
	;if CareerLevelIs LevelNum_Airport
	;	CPF_AP_BeginAt_ShowAll
	;Endif
	;if CareerLevelIs LevelNum_Rio
	;Endif
	;if CareerLevelIs LevelNum_LA
	;Endif
	;if CareerLevelIs LevelNum_Tokyo
	;    JS_Tok_NetObserver
	;Endif
	;if CareerLevelIs LevelNum_Ship
	;    BDJ_SHP_NetObserverStartup
	;Endif
	;if LevelIs load_ware
	;	JKU_Ware_IsObserver
	;endif
endscript


script TimeUpScript
	//    ClearExceptions
	if IsCareerMode
		//        ResetAllOfTheGoals
	Endif
endscript

script ChapterTitle_and_Restore_Start_Key
	restore_start_key_binding
	if GameModeEquals is_career
		GoalManager_GetCurrentChapterAndStage
		If ((<currentchapter> = 0) & (<currentstage> = 0))
			ShownChapterTitle
		endif
	endif
endscript
