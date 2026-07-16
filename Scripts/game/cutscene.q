//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

//PreviousMusicLevel = 0
PreviousSfxLevel = 0

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script CutsceneFadeIn time=0.0
	printf "testing cutscene fade in..."
	
	// kill any fades that might currently be going on
	KillSpawnedScript name=FadeInCutscene

	// need to spawn the script, because it contains a wait   
	spawnscript FadeInCutscene params = { fadein_time=<time> }
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script CutsceneFadeOut time=0.0
	printf "testing cutscene fade out..."
		
	FadeOutCutscene fadeout_time=<time>
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script FadeInCutscene
	if not GotParam fadein_time
		script_assert "no fadein time"
	endif

	if not ( <fadein_time> = 0 )
		// start off black
		fadetoblack on time=0.0 alpha=1.0
		
		fadetoblack off time=<fadein_time>
	else
        fadetoblack off time=0.0
    endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script FadeOutCutscene
	// kill any fades that might currently be going on
	KillSpawnedScript name=FadeInCutscene

	if not GotParam fadeout_time
		script_assert "no fadeout time"
	endif

	fadetoblack on time=<fadeout_time> alpha=1.0
endscript

last_screen_mode = standard_screen_mode

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script CutsceneHideUI
	
	// this wipes out your current trick
	ResetScore

	pause_trick_text
	pause_Balance_Meter
	pause_run_timer

	// wipes out the console
	console_destroy

	if ScreenElementExists id=stat_completed_message
		DestroyScreenElement id=stat_completed_message
	endif
	
	speech_box_exit { anchor_id=goal_start_dialog no_pad_start }
	
	// kills death messages, if it exists
	// (really should destroy ALL panel messages,
	// but I don't really know how to do that)
	kill_panel_message_if_it_exists id=death_message
	kill_panel_message_if_it_exists id=first_time_goal_info
	kill_panel_message_if_it_exists id=goal_complete
	kill_panel_message_if_it_exists id=goalfail
	kill_panel_message_if_it_exists id=current_goal
	kill_panel_message_if_it_exists id=goal_complete
	kill_panel_message_if_it_exists id=goal_complete_sprite
	kill_panel_message_if_it_exists id=goal_complete_line2
	kill_panel_message_if_it_exists id=goal_current_reward
	kill_panel_message_if_it_exists id=perfect
	kill_panel_message_if_it_exists id=perfect2
	
    kill_blur

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script CutsceneUnhideUI

	unpause_trick_text
	unpause_Balance_Meter
	unpause_run_timer

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script cutscene_hide_objects
	GoalManager_HideAllGoalPeds 1
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script cutscene_unhide_objects
	GoalManager_HideAllGoalPeds 0
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script UnhideLoResHeads
	// this is called by the C-code if the player
	// is using one of the special-case heads
	// (the skull and the eyes), for which there
	// is no hi-res cutscene head model
	Skater:SwitchOnAtomic skater_m_head
	Skater:SwitchOnAtomic skater_f_head
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script PreCutscene
	UnPauseMusicAndStreams
	
	SetSfxReverb 0 mode = REV_MODE_CAVE
	KillSpawnedScript name=wait_and_check_for_unplugged_controllers
	change check_for_unplugged_controllers = 0
	
	//GetValueFromVolume cdvol
	//change PreviousMusicLevel = <value>
	GetValueFromVolume sfxvol
	change PreviousSfxLevel = <value>
	
	//change PreviousMusicLevel=(PreviousMusicLevel*10)
	change PreviousSfxLevel=(PreviousSfxLevel*10)
	
	StopMusic
	//SetMusicVolume 100
	SetMusicStreamVolume PreviousSfxLevel
	;StopAllSounds
	
	printf "***Changing Rain Sounds' volumes if playing!!!"
    if IsSoundPlaying TestLight01
		printf "****Light Rain sound 01 - setting sound params to zero"
		SetSoundParams TestLight01 vol=0
	endif
	
	if IsSoundPlaying TestLight02
		printf "****Light Rain sound 02 - setting sound params to zero"
		SetSoundParams TestLight02 vol=0
	endif
	
	if IsSoundPlaying TestMedium02
		printf "****Medium Rain sound 02 - setting sound params to zero"
		SetSoundParams TestMedium02 vol=0
	endif
	
	printf "***Pausing Rain Sounds with pause_rain!!!!"
	pause_rain
	printf "***Stopping all streams with StopStream!"
	StopStream
	Skater:SkaterLoopingSound_TurnOff
	printf "***Turned skater's looping sound off"
	RunScriptOnComponentType component=SkaterLoopingSound target=SkaterLoopingSound_TurnOff
	printf "***Running scr on all SkaterLoopingSound components - SkaterLoopingSound_TurnOff!!!"
	
		
	SetSfxVolume 0
	printf "***Set SFX Volume to Zero"

	// turns off vibration
	Skater:VibrateOff
	
	// Particle System setup and clean up
	// (in case you were in the middle of a grind)
	Skater:Obj_KillSpawnedScript name=BloodSmall
	Skater:Obj_KillSpawnedScript name=BloodSplat
	Skater:Obj_KillSpawnedScript name=SkaterBloodOn	
	Skater:ResetSkaterParticleSystems	
	
	CutsceneHideUI
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	// hides the panel
	GoalManager_HidePoints
	GoalManager_HideGoalPoints
	Skater:StatsManager_DeactivateGoals
	GoalManager_SetCanStartGoal 0
	
	if ( <unload_goals> = 1 )	
		GoalManager_UninitializeAllGoals	
	endif
	
	// pause the objects
	PauseObjects
	PauseSpawnedScripts

	if not GotParam use_lo_res_skater_head
		Skater:SwitchOffAtomic skater_m_head
		Skater:SwitchOffAtomic skater_f_head
	endif
	
	Skater:SwitchOnBoard
	Skater:Hide

    // kill any fades that might currently be going on
    KillSpawnedScript name=FadeInCutscene

    // ideally, we would remember the
	// old screen mode, but the following
	// just creates a reference to the
	// other global, so that it resolves
	// the checksum value at the time
	// current_screen_mode is queried, 
	// rather than right now.
//	change last_screen_mode = ( current_screen_mode )

	// TODO:  unload the anims only if
	// we don't have enough memory...

	// anims are not in main memory on the NGC anyway
	if ( <unload_anims> = 1 )
	
		if InPreFile "skaterparts.pre"
			UnloadPreFile "skaterparts.pre"
			cutscene_skaterparts_unloaded = 1
		endif

		// unload the permanent anims
		do_unload_unloadable
	endif
	
	if isNGC
		unload_current_theme
	endif
	
	SetSfxReverb 0 mode = REV_MODE_CAVE
	
//	dump_heaps
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script CutsceneStartVideo

	// hide the UI again (to kill off 
	// any messages that were created 
	// while the data was being
	// async loaded...  such as
	// "found gap"-type messages,
	// which i think are launched
	// a frame after the skater lands)
	CutsceneHideUI

	// start all cutscenes black (there seems to be
	// an exporter bug which puts the first key at 
	// time 1, not time 0), so there ends up being
	// a glitch
	cutscenefadeout time=0
	
	// set up letter box mode
	switch ( current_screen_mode )
		case standard_screen_mode
			// change to letterbox mode
			screen_setup_letterbox
			
			// remember last screen mode, so that i can restore
			change last_screen_mode = standard_screen_mode
	
		case widescreen_screen_mode
			// keep in widescreen mode			
			// 		screen_setup_widescreen
			// remember last screen mode, so that i can restore
			change last_screen_mode = widescreen_screen_mode
		
		case letterbox_screen_mode
			// keep in letterbox mode			
			// 		screen_setup_letterbox

			// remember last screen mode, so that i can restore
			change last_screen_mode = letterbox_screen_mode
								
		default
			printf "current screen mode = %d" d=current_screen_mode
			script_assert "Unrecognized screen mode"	
	endswitch
    //  added by Chad - for glitch covering
//    HideLoadingScreen   // in the cases where the loading screen was up to hide pauses and glithces
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

// used for reloading skaterparts after cutscenes
// (if necessary)
cutscene_skaterparts_unloaded = 0

script CutsceneKillObjects
	if IsArray CutsceneParticleTextures
		GetArraySize CutsceneParticleTextures	
		if ( <array_size> = 0 )
			printf "CutsceneParticleTextures array is empty!"
//			script_assert "CutsceneParticleTextures array is empty!"
		else
			<index> = 0
			begin
				<nameString> = ( CutsceneParticleTextures[<index>] )
				UnloadParticleTexture <nameString>
				<index> = ( <index> + 1 )
			repeat <array_size>
		endif			
	endif

	if IsArray CutsceneObjectNames
		GetArraySize CutsceneObjectNames	
		
		if ( <array_size> = 0 )
			printf "CutsceneObjectNames array is empty!"
//			script_assert "CutsceneObjectNames array is empty!"
		else
			<index> = 0
			begin
				<name> = ( CutsceneObjectNames[<index>] )
				if CompositeObjectExists name=<name>
					//printf "Killing object:"
					//printstruct <name>
					<name>:Die
				else
					//printstruct <...>
					//printf "Warning:  Couldn't find object"
				endif
				<index> = ( <index> + 1 )
			repeat <array_size>
		endif
	endif
	
	// make sure the memory is freed up
	// before continuing...
	FlushDeadObjects
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script PostCutscene
	SpawnScript wait_and_check_for_unplugged_controllers
	
	// At this point, memory needs to be clean,
	// or else we won't have enough memory
	// to load the anims back in (allow a
	// maximum of 500K of fragmentation)
	// GJ:  Removed it temporarily until
	// I can figure out why there's so
	// much fragmentation in the bedroom
	// and boardshop
//	DumpFragments 500000
	//SetMusicVolume PreviousMusicLevel
	SetSfxVolume PreviousSfxLevel
	SetSfxReverb 0 mode = REV_MODE_CAVE
	
	printf "*** turning skater looping sound ON!!!"
	Skater:SkaterLoopingSound_TurnOn
	printf "***Running scr on all SkaterLoopingSound components - SkaterLoopingSound_TurnOn!!!"
	RunScriptOnComponentType component=SkaterLoopingSound target=SkaterLoopingSound_TurnOn
	
	if isNGC
		reload_current_theme
	endif
	
	if ( <reload_anims> = 1 )
	
		if ( cutscene_skaterparts_unloaded = 1 )
			LoadPreFile "skaterparts.pre"
			change cutscene_skaterparts_unloaded = 0
		endif
		
		do_load_unloadable		
	endif

	// always turn off all fading, now that we're
	// going back to the regular game
	fadetoblack off time=0.0
	
	// kill special effects, in case the artist
	// forgot to do it in the individual
	// cutscene end scripts...
	kill_cutscene_camera_hud
	
	Skater:Unhide
	Skater:SwitchOnAtomic skater_m_head
	Skater:SwitchOnAtomic skater_f_head

	// reset skater to some known location
	if GotParam RestartNode
		ResetSkaters node_name=<RestartNode>
	endif
	
	// Dan: Patch: In truth, the skater should never be sent to handbrake unless he's been reset.  Thus, the MakeSkaterGoto HandBrake should be within
	// the if GotParam RestartNode block.
	if not GotParam dont_send_skater_to_hand_brake
		// reset skater to some known physics state
		MakeSkaterGoto HandBrake
	endif

  	// unpause the objects 
	UnpauseObjects	   
		
	// (also pause the spawned scripts too in case they refer to paused objects)
	// not sure how this works if the spawned scripts were already paused before
	// the cutscene...  maybe should push & pop the pause state of the cutscene? 		
	UnpauseSpawnedScripts
	
	CutsceneUnhideUI
	
	GoalManager_ShowPoints
	GoalManager_ShowGoalPoints
	GoalManager_SetCanStartGoal 1
	//if not (DEMO_BUILD)
		Skater:StatsManager_ActivateGoals
	//endif
	
	if ( <reload_goals> = 1 )	
		GoalManager_InitializeAllGoals
    Else
        //  added by Chad - for glitch covering
        //printf "DisplayLoadingScreen Blank"
        DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
	endif

	// restore old screen mode
	switch ( last_screen_mode )
		case standard_screen_mode
			screen_setup_standard
		case widescreen_screen_mode
			// do nothing; we're already in the correct screen mode				
		case letterbox_screen_mode
			// do nothing; we're already in the correct screen mode				
		default
			printf "last screen mode = %d" d=<last_screen_mode>
			script_assert "Unrecognized screen mode"	
	endswitch
	
	
	SetSfxReverb 0 mode = REV_MODE_CAVE
	printf "***UNpausing rain sounds!!!"
	unpause_rain <...>
			
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script cutsceneobj_add_components

    if GotParam skeletonName
        CreateComponentFromStructure component=skeleton <...> skeleton=<skeletonName>        
    endif

    CreateComponentFromStructure component=model <...> UseModelLights      
    
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script draw_cutscene_panel
    if ObjectExists id=vo_line1
		SetScreenElementProps { id=vo_line1 text=<line1> }
    else
		create_panel_message id=vo_line1 text=<line1> style=panel_message_viewobj_line params={ xy=(40,380) }
    endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script kill_cutscene_panel
    if ObjectExists id=vo_line1
        RunScriptOnScreenElement id=vo_line1 kill_panel_message
    endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script spawn_next_cutscene
	// for chaining together cutscenes
	PauseObjects
	spawnscript start_next_cutscene params={<...>}
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script start_next_cutscene
	// for chaining together cutscenes
	
	if GotParam Tod_Action
		DisplayLoadingScreen freeze
		script_change_tod tod_action=<Tod_Action>
	endif
	
	UnpauseObjects
	//HideLoadingScreen
	PlayCutscene name=<name> unload_anims=<unload_anims> reload_anims=<reload_anims> exitScript=<exitScript>
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

camera_hud_is_hidden=0

script show_cutscene_camera_hud mins=2 secs=16 frames=03
	if ScreenElementExists id=cutscene_camera_hud_anchor
		DestroyScreenElement id=cutscene_camera_hud_anchor
	endif
	
	if GotParam for_goal
		mins=0 secs=0 frames=0
		rec_alpha=0
		rec_pos=(500,90)
	else
		if GotParam play
			rec_alpha=0
		else
			rec_alpha=1
		endif
		rec_pos=(500,50)
	endif
	
	SetScreenElementLock off id=root_window
	
	CreateScreenElement {
		type=ContainerElement
		id=cutscene_camera_hud_anchor
		parent=root_window
		pos=(320,240)
		dims=(640,480)
	}
	
	// screen
	CreateScreenElement {
        type=SpriteElement
        parent=cutscene_camera_hud_anchor
		id=video_screen
		texture=videoscreen
		pos=(320,240)
        just=[center center]
		scale=(5,10)
        alpha=0.3
	}
	
	// line
	CreateScreenElement {
		type=SpriteElement
		id=camera_hud_line
        parent=cutscene_camera_hud_anchor
		texture=white2
		pos=(0,0)
        just=[left center]
		scale=(100,0.1)
        alpha=0.5
	}
	
	if GotParam play
		CreateScreenElement {
			type=TextElement
			parent=cutscene_camera_hud_anchor
			id=play
			pos=<rec_pos>
			text="PLAY"
			font=small
			just=[left top]
			scale=1.5
			rgba=[100 100 100 128]
			alpha=0.8
		}
	endif
	
    // REC
	CreateScreenElement {
		type=ContainerElement
		id=rec_anchor
		parent=cutscene_camera_hud_anchor
		pos=(320,240)
		dims=(640,480)
		alpha=<rec_alpha>
	}
	
	CreateScreenElement {
		type=TextElement
		parent=rec_anchor
		id=rec
		pos=<rec_pos>
		text="REC"
        font=small
		just=[left top]
		scale=1.5
		rgba=[100 0 0 128]
		alpha=0.8
	}
	GetStackedScreenElementPos X id=rec offset=(10,16)
    CreateScreenElement {
		type=SpriteElement
		id=rec_dot
        parent=rec_anchor
		texture=recdot
		pos=<pos>
        just=[left center]
		scale=1.5
        alpha=0.8
	}
	
    // Timer
	scale=1.5
	alpha=0.6
	font=dialog
	;rgba=[128 128 128 128]
	
	// mins
	CreateScreenElement {
		type=TextElement
		parent=cutscene_camera_hud_anchor
		id=mins2
		pos=(450,380)
        text="0"
        font=<font>
		just=[right top]
		scale=<scale>
        alpha=<alpha>
		rgba=<rgba>
	}
	GetStackedScreenElementPos X id=<id> offset=(23,0)
	CreateScreenElement {
		type=TextElement
        parent=cutscene_camera_hud_anchor
		id=mins
		pos=<pos>
        text="0"
        font=<font>
		just=[right top]
		scale=<scale>
        alpha=<alpha>
		rgba=<rgba>
	}
	GetStackedScreenElementPos X id=<id> offset=(5,-2)
	CreateScreenElement {
		type=TextElement
		parent=cutscene_camera_hud_anchor
		pos=<pos>
		text=":"
        font=<font>
		just=[left top]
		scale=<scale>
        alpha=<alpha>
		rgba=<rgba>
	}
	// secs
	GetStackedScreenElementPos X id=<id> offset=(23,2)
	CreateScreenElement {
		type=TextElement
		parent=cutscene_camera_hud_anchor
		id=secs2
		pos=<pos>
		text="0"
        font=<font>
		just=[right top]
		scale=<scale>
        alpha=<alpha>
		rgba=<rgba>
	}
	GetStackedScreenElementPos X id=<id> offset=(23,0)
	CreateScreenElement {
		type=TextElement
		parent=cutscene_camera_hud_anchor
		id=secs
		pos=<pos>
		text="0"
        font=<font>
		just=[right top]
		scale=<scale>
        alpha=<alpha>
		rgba=<rgba>
	}
    GetStackedScreenElementPos X id=<id> offset=(5,-2)
	CreateScreenElement {
		type=TextElement
		parent=cutscene_camera_hud_anchor
		pos=<pos>
		text=":"
        font=<font>
		just=[left top]
		scale=<scale>
        alpha=<alpha>
		rgba=<rgba>
	}
	// frames
	GetStackedScreenElementPos X id=<id> offset=(23,2)
	CreateScreenElement {
		type=TextElement
		parent=cutscene_camera_hud_anchor
		id=frames2
		pos=<pos>
		text="0"
        font=<font>
		just=[right top]
		scale=<scale>
        alpha=<alpha>
		rgba=<rgba>
	}
	GetStackedScreenElementPos X id=<id> offset=(23,0)
	CreateScreenElement {
		type=TextElement
		parent=cutscene_camera_hud_anchor
		id=frames
		pos=<pos>
		text="0"
        font=<font>
		just=[right top]
		scale=<scale>
        alpha=<alpha>
		rgba=<rgba>
	}
	
    mins2 = ( <mins> / 10 )
	mins1 = ( <mins> - ( <mins2> * 10 ) )
	
	secs2 = ( <secs> / 10 )
	secs1 = ( <secs> - ( <secs2> * 10 ) )
	
	frames2 = ( <frames> / 10 )
	frames1 = ( <frames> - ( <frames2> * 10 ) )
    
    FormatText textname=min_text "%m" m=<mins1>
	SetScreenElementProps id=mins text=<min_text>
    
	FormatText textname=min_text "%m" m=<mins2>
	SetScreenElementProps id=mins2 text=<min_text>
    
    FormatText textname=sec_text "%s" s=<secs1>
	SetScreenElementProps id=secs text=<sec_text>
	
	FormatText textname=sec_text "%s" s=<secs2>
	SetScreenElementProps id=secs2 text=<sec_text>
	
	FormatText textname=frame_text "%f" f=<frames1>
	SetScreenElementProps id=frames text=<frame_text>
	
	FormatText textname=frame_text "%f" f=<frames2>
	SetScreenElementProps id=frames2 text=<frame_text>
    
	// store values in tags
	mins:SetTags frames=<frames> secs=<secs> mins=<mins>
	
	if GotParam fade
		RunScriptOnScreenElement id=rec_dot cutscene_camera_hud_fade_in
	endif
    
	RunScriptOnScreenElement id=video_screen flicker_video_screen
    RunScriptOnScreenElement id=camera_hud_line morph_camera_hud_line
	RunScriptOnScreenElement id=rec_dot blink_rec_dot
	
	if not GotParam for_goal
		RunScriptOnScreenElement id=secs camera_hud_count ;params={ frames=<frames> secs=<secs> mins=<mins> }
	endif
endscript

script kill_cutscene_camera_hud
	if gotparam fade
		RunScriptOnScreenElement id=rec_dot fadetoblack params={ on time=0.5 alpha=1.0 z_priority=5 }
		RunScriptOnScreenElement id=rec_dot	really_kill_cutscene_camera_hud
	else
		if ScreenElementExists id=cutscene_camera_hud_anchor
			DestroyScreenElement id=cutscene_camera_hud_anchor
		endif
	endif
endscript

script cutscene_camera_hud_fade_in
	fadetoblack on time=0 alpha=1.0 z_priority=5
	wait 0.2 seconds
	fadetoblack off time=0.5
endscript

script really_kill_cutscene_camera_hud
	wait 0.7 seconds
	fadetoblack off time=0
	if ScreenElementExists id=cutscene_camera_hud_anchor
		DestroyScreenElement id=cutscene_camera_hud_anchor
	endif
endscript

script hide_cutscene_camera_hud
	if ScreenElementExists id=cutscene_camera_hud_anchor
		DoScreenElementMorph id=cutscene_camera_hud_anchor alpha=0
	endif
endscript

script unhide_cutscene_camera_hud
	if ScreenElementExists id=cutscene_camera_hud_anchor
		DoScreenElementMorph id=cutscene_camera_hud_anchor alpha=1
	endif
endscript

script blink_rec_dot
    begin
		DoScreenElementMorph id=rec_dot alpha=0.8
		wait 0.5 seconds
		DoScreenElementMorph id=rec_dot alpha=0
		wait 0.5 seconds
	repeat
endscript

script flicker_video_screen time=0.05
	begin
		DoScreenElementMorph id=video_screen alpha=0.3 time=<time>
		wait <time> seconds
		DoScreenElementMorph id=video_screen alpha=0.225 time=<time>
		wait <time> seconds
	repeat
endscript

script morph_camera_hud_line time=1.5
	begin
		DoScreenElementMorph id=camera_hud_line pos=(0,480) time=<time>
		wait <time> seconds
		DoScreenElementMorph id=camera_hud_line pos=(0,0)
	repeat
endscript

script camera_hud_count
    begin
		wait 2 gameframes
		camera_hud_count_one
	repeat
endscript

script camera_hud_count_one
    mins:GetTags
    
    frames = ( <frames> + 1 )
    
	if ( <frames> > 29 )
		frames=0
		secs=( <secs> + 1 )
		
		if ( <secs> > 59 )
			secs=0
			mins=( <mins> + 1 )
			
			mins2 = ( <mins> / 10 )
			mins1 = ( <mins> - ( <mins2> * 10 ) )
			
			FormatText textname=min_text "%m" m=<mins1>
			SetScreenElementProps id=mins text=<min_text>
			
			FormatText textname=min_text "%m" m=<mins2>
			SetScreenElementProps id=mins2 text=<min_text>
		endif
		
		secs2 = ( <secs> / 10 )
		secs1 = ( <secs> - ( <secs2> * 10 ) )
		
		FormatText textname=sec_text "%s" s=<secs1>
		SetScreenElementProps id=secs text=<sec_text>
		
		FormatText textname=sec_text "%s" s=<secs2>
		SetScreenElementProps id=secs2 text=<sec_text>
	endif
	
	frames2 = ( <frames> / 10 )
	frames1 = ( <frames> - ( <frames2> * 10 ) )
	
	FormatText textname=frame_text "%f" f=<frames1>
	SetScreenElementProps id=frames text=<frame_text>
	
	FormatText textname=frame_text "%f" f=<frames2>
	SetScreenElementProps id=frames2 text=<frame_text>
	
	// store values in tags
	mins:SetTags frames=<frames> secs=<secs> mins=<mins>
endscript

script camera_hud_breakup_frames
    if not ScreenElementExists id=mins
		return
	endif
	
	if ( <millisecs> > 60000 )
		mins = ( <millisecs> / 6000 )
		millisecs = ( <millisecs> - ( <mins> * 6000 ) )
	else
		mins=0
	endif
	
	if ( <millisecs> > 1000 )
		secs = ( <millisecs> / 1000 )
		millisecs = ( <millisecs> - ( <secs> * 1000 ) )
	else
		secs=0
	endif
	
	frames = ( <millisecs> / 17 )
	
	;printstruct <...>
	
	mins2 = ( <mins> / 10 )
	mins1 = ( <mins> - ( <mins2> * 10 ) )
	
	FormatText textname=min_text "%m" m=<mins1>
	SetScreenElementProps id=mins text=<min_text>
	
	FormatText textname=min_text "%m" m=<mins2>
	SetScreenElementProps id=mins2 text=<min_text>

	secs2 = ( <secs> / 10 )
	secs1 = ( <secs> - ( <secs2> * 10 ) )
	
	FormatText textname=sec_text "%s" s=<secs1>
	SetScreenElementProps id=secs text=<sec_text>
	
	FormatText textname=sec_text "%s" s=<secs2>
	SetScreenElementProps id=secs2 text=<sec_text>

	frames2 = ( <frames> / 10 )
	frames1 = ( <frames> - ( <frames2> * 10 ) )
	
	FormatText textname=frame_text "%f" f=<frames1>
	SetScreenElementProps id=frames text=<frame_text>
	
	FormatText textname=frame_text "%f" f=<frames2>
	SetScreenElementProps id=frames2 text=<frame_text>
	
endscript

// new hangover effect
script show_cutscene_hangover_hud 
	if ScreenElementExists id=cutscene_hangover_hud_anchor
		DestroyScreenElement id=cutscene_hangover_hud_anchor
	endif
	
	SetScreenElementLock off id=root_window
	
	CreateScreenElement {
		type=ContainerElement
		id=cutscene_hangover_hud_anchor
		parent=root_window
		pos=(320,240)
		dims=(640,480)
	}
	
	// screen
	CreateScreenElement {
        type=SpriteElement
        parent=cutscene_hangover_hud_anchor
		id=hangover_screen
		texture=hangoverscreen
		pos=(320,240)
        just=[center center]
		scale=(5,10)
        alpha=0.15
	}
endscript

script kill_cutscene_hangover_hud
    DestroyScreenElement id=cutscene_hangover_hud_anchor
endscript

script cutscene_hangover_hud_fade_in
    setscreenBlur 200
	fadetoblack on time=0 alpha=1.0 z_priority=5
    show_cutscene_hangover_hud 
	wait 0.2 seconds
	fadetoblack off time=0.5
endscript

script really_kill_cutscene_hangover_hud
	setscreenblur 0
	wait 0.7 seconds
	fadetoblack off time=0
    if ScreenElementExists id=cutscene_hangover_hud_anchor
		DestroyScreenElement id=cutscene_hangover_hud_anchor
	endif
endscript

script hide_cutscene_hangover_hud
    setscreenblur 0
	if ScreenElementExists id=cutscene_hangover_hud_anchor
		DoScreenElementMorph id=cutscene_hangover_hud_anchor alpha=0
	endif
endscript

script unhide_cutscene_hangover_hud
    setscreenBlur 200
	if ScreenElementExists id=cutscene_hangover_hud_anchor
		DoScreenElementMorph id=cutscene_hangover_hud_anchor alpha=1
	endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


//******* Custom Video Intro Screen stuff ******

script make_custom_video_intro    
	PlayStream Team_Movie_Intro
	show_universal_hud
	wait 3.5 seconds
	videointro_hud_fade_in
	show_videointro_hud
	wait 100 gameframe
	really_kill_videointro_hud
	kill_black2
	videointro_hud_fade_in2
	show_videointro_hud2
	wait 130 gameframe
	really_kill_videointro_hud2
	show_underground_hud
	kill_black
    wait 380 gameframe
	if ScreenElementExists id=underground_hud_anchor
       DestroyScreenElement id=underground_hud_anchor

	endif

endscript



// video intro
script show_videointro_hud 
	if ScreenElementExists id=videointro_hud_anchor
		DestroyScreenElement id=videointro_hud_anchor
	endif
	
	SetScreenElementLock off id=root_window
	
	CreateScreenElement {
		type=ContainerElement
		id=videointro_hud_anchor
		parent=root_window
		pos=(320,240)
		dims=(640,480)
	   // z_priority=100
	}
	
	// screen
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor
		id=videointro_black
		texture=black
		pos=(320,240)
        just=[center center]
		scale=(200,200)
		rgba=[0 0 0 128]
		z_priority=-5
        alpha=1
		z_priority=50000
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor
		id=videointro_screen
		texture=videoscreen
		pos=(320,240)
        just=[center center]
		scale=(5,10)
        alpha=.1
		z_priority=1395
		z_priority=50001
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor
		id=videowhite
		texture=videowhite
		pos=(320,240)
        just=[center center]
		scale=(7.6,8)
		rgba=[ 125 125 95 40]
        alpha=.4
		z_priority=1396
		z_priority=500012
		rot_angle=9
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor
		id=bg_icon
		texture=go_fail
		pos=(320,250)
        just=[center center]
		scale=(1.2, 1.2)
		rgba=[ 128 128 128 10]
		z_priority=500013
		rot_angle=5
	}

    CreateScreenElement {
		type=TextElement
		parent=videointro_hud_anchor
		id=peralta_name
		pos=(150, 190)
		text="Peralta Productions Presents"
        font=dialog
		just=[left, top]
		scale=1.1
		rgba=[ 128 128 128 100]
		z_priority=1397
		z_priority=50004
	} 

	RunScriptOnScreenElement id=videointro_screen flicker_videointro
	RunScriptOnScreenElement id=peralta_name flicker_textintro
	RunScriptOnScreenElement id=bg_icon flicker_skullintro
endscript

script videointro_hud_fade_in
	setscreenBlur 70
	fadetoblack on time=0 alpha=1.0 z_priority=10000
	make_black_in2
	wait 1.4 seconds
	show_videointro_hud
	make_black_out2 
	wait 0.2 seconds
	fadetoblack off time=0.5
endscript

script really_kill_videointro_hud
	setscreenblur 1
	make_black_out2
	//wait 0.7 seconds
	fadetoblack off time=.3
	if ScreenElementExists id=videointro_hud_anchor
		DestroyScreenElement id=videointro_hud_anchor
	endif
endscript

script flicker_textintro time=0.05
    begin
		DoScreenElementMorph id=peralta_name alpha=1 time=<time> pos=(150, 189) 
		wait <time> seconds
		DoScreenElementMorph id=peralta_name alpha=.7 time=<time> pos=(150, 190)
		wait <time> seconds
	repeat
endscript

script flicker_skullintro time=0.05
	begin
		DoScreenElementMorph id=bg_icon alpha=1 time=<time>  
		wait <time> seconds
		DoScreenElementMorph id=bg_icon alpha=.7 time=<time> 
		wait <time> seconds
	repeat
endscript

script flicker_videointro time=0.05
    begin
		DoScreenElementMorph id=videointro_screen alpha=0.07 time=<time> scale=(8.01,7)
		wait <time> seconds
		DoScreenElementMorph id=videointro_screen alpha=0.22 time=<time> scale=(8,7)
		wait <time> seconds
	repeat
endscript

// the second part

script show_videointro_hud2 
	if ScreenElementExists id=videointro_hud_anchor2
		DestroyScreenElement id=videointro_hud_anchor2
	endif
	
	SetScreenElementLock off id=root_window
	
	CreateScreenElement {
		type=ContainerElement
		id=videointro_hud_anchor2
		parent=root_window
		pos=(320,240)
		dims=(640,480)
		z_priority=50
	}
	
	// screen
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor2
		id=videointro_black2
		texture=black
		pos=(320,240)
        just=[center center]
		scale=(200,200)
		rgba=[0 0 0 128]
		z_priority=-5
        alpha=1
		z_priority=50000
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor2
		id=videointro_screen2
		texture=videoscreen
		pos=(320,240)
        just=[center center]
		scale=(5,10)
        alpha=.1
		z_priority=50001
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor2
		id=videowhite2
		texture=videowhite
		pos=(320,240)
        just=[center center]
		scale=(9,7.5)
		rgba=[ 12 42 68 70]
        alpha=.6
		z_priority=50007
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor2
		id=star1
		texture=PA_goals
		pos=(100,110)
        just=[center center]
		scale=(2, 2)
		rgba=[ 0 0 0 128]
        alpha=.8
		rot_angle=-3
		z_priority=50003
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor2
		id=star2
		texture=PA_goals
		pos=(480,310)
        just=[center center]
		scale=(2, 2)
		rgba=[ 0 0 0 128]
        alpha=.9
		rot_angle=-7
		z_priority=50004
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor2
		id=star3
		texture=PA_goals
		pos=(430,120)
        just=[center center]
		scale=(1.3, 1.3)
		rgba=[ 0 0 0 128]
        alpha=.8
		rot_angle=18
		z_priority=50004
	}


	GoalManager_GetTeam
    CreateScreenElement {
		type=TextElement
		parent=videointro_hud_anchor2
		id=team name
		pos=(310, 190)
        text=(<team>.team_name)
        font=small
		just=[center top]
		scale=2.2
		rgba=[ 128 77 0 100]
		z_priority=50008		
    }
	
	CreateScreenElement {
		type=TextElement
		parent=videointro_hud_anchor2
		id=a
		pos=(110, 120)
		text="A"
        font=dialog
		just=[left, top]
		scale=1.5
		rgba=[ 128 73 0 88]
		z_priority=50009
	}
	
	CreateScreenElement {
		type=TextElement
		parent=videointro_hud_anchor2
		id=videoname
		pos=(420, 245)
		text="VIDEO"
        font=dialog
		just=[left, top]
		scale=2.5
		rgba=[ 128 73 0 78]
		z_priority=50009
	}

	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor2
		id=videoborder2
		texture=videoborder
		pos=(320,210)
        just=[center center]
		rgba=[128 73 0 128]
		scale=(5.0,1.5)
		rot_angle=-3
        alpha=0.7
		z_priority=50007
		
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=videointro_hud_anchor2
		id=videoborder3
		texture=videoborder
		pos=(320,220)
        just=[center center]
		rgba=[ 0 0 0 128]
		scale=(6,2)
		rot_angle=4
        alpha=0.8
		z_priority=-8
		z_priority=50005
	}

	
	/*CreateScreenElement {
		type=TextElement
		parent=videointro_hud_anchor2
		id=skateteam
		pos=(420, 260)
		text="SKATETEAM"
        font=testtitle
		just=[center top]
		scale=1.6
		rgba=[ 128 73 0 128]
		z_priority=1
		z_priority=50008
    }*/
	  
    RunScriptOnScreenElement id=videointro_screen2 flicker_videointro2
endscript

script videointro_hud_fade_in2
        setscreenBlur 20
  	    fadetoblack on time=0 alpha=1.0 z_priority=100000
	    make_black_in
	    wait 0.025 seconds
        show_videointro_hud2
	    make_black_out 
	    wait 0.2 seconds
	    fadetoblack off time=0.2
endscript

script flicker_videointro2 time=0.095
	begin
		DoScreenElementMorph id=videointro_screen2 alpha=0.1 time=<time> rot_angle=0
		wait <time> seconds
		DoScreenElementMorph id=videointro_screen2 alpha=0.175 time=<time> rot_angle=360
		wait <time> seconds
	repeat
endscript

script really_kill_videointro_hud2
	setscreenblur 4
	if ScreenElementExists id=videointro_hud_anchor2
		DestroyScreenElement id=videointro_hud_anchor2
	endif
endscript

script make_black_in
   CreateScreenElement {
        type=SpriteElement
		parent=root_window
		id=videointro_black3
		texture=black
		pos=(320,240)
        just=[center center]
		scale=(200,200)
		rgba=[0 0 0 128]
		z_priority=-5
        alpha=0
		z_priority=4560040
	}
	
    DoScreenElementMorph id=videointro_black3 alpha=1 time=0 
endscript

script kill_black
       DestroyScreenElement id=videointro_black3
endscript

script make_black_out
       DoScreenElementMorph id=videointro_black3 alpha=0 time=0.5
endscript

script make_black_in2
   CreateScreenElement {
        type=SpriteElement
		parent=root_window
		id=videointro_black4
		texture=black
		pos=(320,240)
        just=[center center]
		scale=(200,200)
		rgba=[0 0 0 128]
		z_priority=-5
        alpha=0
		z_priority=160080
	}
	
    DoScreenElementMorph id=videointro_black4 alpha=1 time=0
endscript

script make_black_out2
	DoScreenElementMorph id=videointro_black4 alpha=0 time=0
endscript

script kill_black2
    DestroyScreenElement id=videointro_black4
endscript


//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


//******* Universal Leader Intro ******

// universal leader intro
script show_universal_hud 
	if ScreenElementExists id=universal_hud_anchor
		DestroyScreenElement id=universal_hud_anchor
	endif
	
	SetScreenElementLock off id=root_window
	
    CreateScreenElement {
		type=ContainerElement
		id=universal_hud_anchor
		parent=root_window
		pos=(320,240)
		dims=(640,480)
	   // z_priority=100
	}
	
	// screen
	CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=universal_black
		texture=white2
		pos=(0,0)
        just=[top left]
		scale=(100,100)
		rgba=[20 20 20 128]
		z_priority=-5
        alpha=1
		z_priority=50000
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=universalleft_screen
		texture=white2
		pos=(0,0)
        just=[top left]
		rgba=[110 110 110 128]
		scale=(40,100)
        alpha=1
		z_priority=1395
		z_priority=50001
	}
	
    CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=horizontal_black
		texture=white
		pos=(0,224)
        just=[top left]
		scale=(200,1)
		rgba=[10 10 10 128]
		z_priority=-5
        alpha=1
		z_priority=50002
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=horizontal_black2
		texture=white
		pos=(320,0)
        just=[top left]
		scale=(1,200)
		rgba=[10 10 10 128]
		z_priority=-5
        alpha=1
		z_priority=50002
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=universal_cirle2
		texture=hoop
		pos=(226,130)
        just=[top left]
		scale=(3, 3)
		rgba=[128 128 128 188]
		z_priority=-5
        alpha=.6
		z_priority=50003
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=universal_cirle
		texture=hoop
		pos=(161,70)
        just=[top left]
		scale=(5, 5)
		rgba=[10 10 10 58]
		z_priority=-5
        alpha=.6
		z_priority=60003
	}

	
	CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=videointro_screen_universal
		texture=videoscreen
		pos=(320,240)
        just=[center center]
		scale=(10,11)
		rgba=[ 40 40 40 128 ]
        alpha=.6
		z_priority=1395
		z_priority=60001
		rot_angle=90
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=universalwhite
		texture=videowhite
		pos=(320,240)
        just=[center center]
		scale=(7.6,8)
		rgba=[ 40 40 40 38]
        alpha=.8
		z_priority=1396
		z_priority=50002
		rot_angle=9
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=universal_grunge
		texture=hangoverscreen
		pos=(320,240)
		rgba= [ 30 30 30 90 ]
        just=[center center]
		scale=(5,10)
        alpha=0.15
		z_priority=500015
	}


	
	CreateScreenElement {
        type=SpriteElement
        parent=universal_hud_anchor
		id=videointro_screen_piepiece
		texture=piepiece
		pos=(320,220)
        just=[center center]
		scale=(6, 6)
        alpha=.3
		z_priority=1395
		z_priority=500010
	} 
 
	
	CreateScreenElement {
		type=TextElement
		parent=universal_hud_anchor
		id=number_3
		pos=(292, 170)
		text="4"
        font=small
		just=[left, top]
		scale=(4.1, 5.2)
		rgba=[ 60 60 60 98]
		alpha=0
		z_priority=500011
	}
	
	CreateScreenElement {
		type=TextElement
		parent=universal_hud_anchor
		id=number_2
		pos=(295, 170)
		text="3"
        font=small
		just=[left, top]
		scale=(4.1, 5.2)
		rgba=[ 60 60 60 98]
		alpha=0
		z_priority=500012
	} 
	
	CreateScreenElement {
		type=TextElement
		parent=universal_hud_anchor
		id=number_1
		pos=(297, 170)
		text="2"
        font=small
		just=[left, top]
		scale=(4.1, 5.2)
		rgba=[ 60 60 60 98]
		alpha=0
		z_priority=500013
	} 

 
	  RunScriptOnScreenElement id=videointro_screen_universal flicker_videointro3
	  RunScriptOnScreenElement id=videointro_screen_piepiece spin_piepiece_1
      RunScriptOnScreenElement id=number_3 show_number_3
endscript

		

script flicker_videointro3 time=0.05
    begin
	    wait .4 second
		DoScreenElementMorph id=videointro_screen_universal time=<time> scale=(11, 12) pos=(320,240)
		wait <time> seconds
		DoScreenElementMorph id=videointro_screen_universal time=<time> scale=(30, 12) pos=(330,240)
		wait <time> seconds
	repeat
endscript



script spin_piepiece_1 time=3.5
		DoScreenElementMorph id=videointro_screen_piepiece time=<time> rot_angle=0
		DoScreenElementMorph id=videointro_screen_piepiece time=<time> rot_angle=1080
		wait <time> seconds
		kill_universal_leader
		wait 2 second
endscript



script show_number_3
       DoScreenElementMorph id=number_3 alpha=0 time=0 //scale=0
	   DoScreenElementMorph id=number_3 alpha=1 time=.03 scale=(4.1, 5.2)
	   wait 1.1 seconds
	   DoScreenElementMorph id=number_3 alpha=0 time=0
	   RunScriptOnScreenElement id=number_2 show_number_2
 

endscript

script show_number_2
       DoScreenElementMorph id=number_2 alpha=0 time=0 //scale=0
	   DoScreenElementMorph id=number_2 alpha=1 time=.03 scale=(4.1, 5.2)
	   wait 1.1 seconds
	   DoScreenElementMorph id=number_2 alpha=0 time=0 
	   RunScriptOnScreenElement id=number_1 show_number_1

endscript

script show_number_1
       DoScreenElementMorph id=number_1 alpha=0 time=0 //scale=0
	   DoScreenElementMorph id=number_1 alpha=1 time=.03 scale=(4.1, 5.2)
	   wait 1.5 seconds
	   DoScreenElementMorph id=number_1 alpha=0 time=0 
endscript



script kill_universal_leader
	   setscreenblur 1
	   fadetoblack off time=.3
	if ScreenElementExists id=universal_hud_anchor
       DestroyScreenElement id=universal_hud_anchor
	   wait 2 second
	endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


//******* UNDERGROUND VIDEO ******

// Underground Video Intro Section
script show_underground_hud 
	if ScreenElementExists id=underground_hud_anchor
		DestroyScreenElement id=underground_hud_anchor
	endif
	
	SetScreenElementLock off id=root_window
	
    CreateScreenElement {
		type=ContainerElement
		id=underground_hud_anchor
		parent=root_window
		pos=(320,240)
		dims=(640,480)
		 }
		 
	CreateScreenElement {
        type=SpriteElement
        parent=underground_hud_anchor
		id=underground_black
		texture=white2
		pos=(-30,63)
        just=[top left]
		scale=(100,38.2)
		rgba=[2 8 12 128]
		z_priority=-5
        alpha=1
		//rot_angle=-3
		z_priority=1000000
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=underground_hud_anchor
		id=underground_black2
		texture=white2
		pos=(240,63)
        just=[center center]
		scale=(100,200)
		rgba=[0 0 0 128]
		z_priority=-5
        alpha=1
		//rot_angle=-3
		z_priority=100000000
	}


	CreateScreenElement {
        type=SpriteElement
        parent=underground_hud_anchor
		id=borderbg
		texture=videoborder
		pos=(00,43)
        just=[top left]
		scale=(10,3)
		rgba=[0 0 0 128]
		z_priority=-5
        alpha=.6
		//rot_angle=-3
		z_priority=1000001
	}
	
	
	CreateScreenElement {
		type=TextElement
		parent=underground_hud_anchor
		id=under_1
		pos=(52, 190)
		text="UNDERGROUND"
        font=testtitle
		just=[left, top]
		scale=(2)
		rgba=[114 23 13 128]
		alpha=0
		z_priority=10000003
	}
	
	CreateScreenElement {
		type=TextElement
		parent=underground_hud_anchor
		id=under_2
		pos=(52, 190)
		text="UNDERGROUND"
        font=testtitle
		just=[left, top]
		scale=(3)
		rgba=[ 60 60 60 98]
		alpha=0
		z_priority=10000003
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=underground_hud_anchor
		id=understar_1
		texture=PA_goals
		pos=(730,210)
        just=[center center]
		scale=(1.3, 1.3)
		rgba=[ 128 0 0 128]
        alpha=1
		rot_angle=18
		z_priority=10000001
	}
	
	CreateScreenElement {
        type=SpriteElement
        parent=underground_hud_anchor
		id=understar_2
		texture=PA_goals
		pos=(-250,210)
        just=[center center]
		scale=(1.3, 1.3)
		rgba=[ 128 0 0 128]
        alpha=1
		rot_angle=18
		z_priority=10000001
	}
	
	GetTeamNames
	
    CreateScreenElement {
		type=TextElement
		parent=underground_hud_anchor
		id=skater_name_1
		pos=(52, 70)
		text=<team_name1>
        font=small
		just=[left, top]
		scale=(1.3, 2)
		rgba=[ 80 80 80 98]
		//alpha=1
		z_priority=10000001
	}
	
	CreateScreenElement {
		type=TextElement
		parent=underground_hud_anchor
		id=skater_name_2
		pos=(-200, 270)
		text=<team_name2>
        font=small
		just=[left, top]
		scale=(1.6, 2.2)
		rgba=[ 80 80 80 98]
		//alpha=1
		z_priority=10000001
	}
	
	CreateScreenElement {
		type=TextElement
		parent=underground_hud_anchor
		id=skater_name_3
		pos=(300, 600)
		text=<team_name3>
        font=small
		just=[left, top]
		scale=(2.3, 3)
		rgba=[80 80 80 98]
		//alpha=1
		z_priority=10000001
	}
	
	CreateScreenElement {
		type=TextElement
		parent=underground_hud_anchor
		id=skater_name_4
		pos=(100, -600)
		text=<team_name4>
        font=small
		just=[left, top]
		scale=(1.3, 2)
		rgba=[ 80 80 80 98]
		//alpha=1
		z_priority=10000001
	}
	
	CreateScreenElement {
		type=TextElement
		parent=underground_hud_anchor
		id=skater_name_5
		pos=(320, 170)
		text=<team_name5>
        font=small
		just=[center, center]
		scale=(1.3, 2)
		rgba=[ 80 80 80 98]
		alpha=0
		z_priority=10000001
	}

	RunScriptOnScreenElement id=underground_black2 fadeinout
	build_top_and_bottom_blocks parent=underground_hud_anchor top_z=100000 bot_z=100000 
	RunScriptOnScreenElement id=under_1 underground_fly_in
	RunScriptOnScreenElement id=under_2 underground_fly_in2
	RunScriptOnScreenElement id=skater_name_1 skater_name_fly_1
	RunScriptOnScreenElement id=skater_name_2 skater_name_fly_2
	RunScriptOnScreenElement id=skater_name_3 skater_name_fly_3
	RunScriptOnScreenElement id=skater_name_4 skater_name_fly_4
	RunScriptOnScreenElement id=skater_name_5 skater_name_fly_5
	RunScriptOnScreenElement id=understar_1 star_fly_1
	RunScriptOnScreenElement id=understar_2 star_fly_2   
endscript

script underground_fly_in
       wait 1 second
       DoScreenElementMorph id=under_1 alpha=0 time=0 scale=8
	   DoScreenElementMorph id=under_1 alpha=.9 time=.3 scale=3
	   wait 4.5 second
	   DoScreenElementMorph id=under_1 alpha=0 scale=( 20, 3) time=.2 
endscript

script underground_fly_in2
	   wait 1 second
       DoScreenElementMorph id=under_2 alpha=0 time=0  pos=(700, 190)
	   DoScreenElementMorph id=under_2 alpha=.9 time=.4  pos=(52, 190)
	   wait 3.0 second
	   DoScreenElementMorph id=under_2 alpha=0 time=.2
endscript

script skater_name_fly_1
       DoScreenElementMorph id=skater_name_1 alpha=0 time=0  pos=(700, 70)
	   DoScreenElementMorph id=skater_name_1 alpha=.6 time=6.2 scale=(5, 5) pos=(-650, 70)

endscript

script skater_name_fly_2
       DoScreenElementMorph id=skater_name_2 alpha=0 time=0  pos=(-200, 270)
	   DoScreenElementMorph id=skater_name_2 alpha=.5 time=5.8  pos=(1000, 270)

endscript

script skater_name_fly_3
       DoScreenElementMorph id=skater_name_3 alpha=0 time=0  pos=(300, 600)
	   DoScreenElementMorph id=skater_name_3 alpha=.55 time=6.4  pos=(300, -600)

endscript

script skater_name_fly_4
       DoScreenElementMorph id=skater_name_4 alpha=0 time=0  pos=(100, -600)
	   DoScreenElementMorph id=skater_name_4 alpha=.4 time=6.2  scale=(4.8, 4.8) pos=(100, 600)

endscript

script skater_name_fly_5
       wait 2 second
       DoScreenElementMorph id=skater_name_5 alpha=.7 time=0 scale=9 pos=(320, 170)
	   DoScreenElementMorph id=skater_name_5 alpha=0 time=3.5 scale=0 pos=(320, 170)

endscript

script star_fly_1
       wait 1 second
       DoScreenElementMorph id=understar_1 alpha=.5 time=0  pos=(730, 210) rot_angle=0
	   DoScreenElementMorph id=understar_1 alpha=.95 time=2.8  scale=(2.3, 2.3) pos=(-250, 210)  rot_angle=720

endscript

script star_fly_2
       wait 1.5 second
       DoScreenElementMorph id=understar_2 alpha=.5 time=0  pos=(-250, 210) rot_angle=0
	   DoScreenElementMorph id=understar_2 alpha=.8 time=1.8  scale=(2.3, 2.3) pos=(720, 210)  rot_angle=-720
endscript

script fadeinout
       wait .6 second
	   DoScreenElementMorph id=underground_black2 alpha=0 time=0
       DoScreenElementMorph id=underground_black2 alpha=1 time=.2 
	   DoScreenElementMorph id=underground_black2 alpha=0 time=.1
	     
endscript

script GetTeamNames
    GoalManager_GetTeam
	
    GetArraySize master_skater_list
	index=0
	index2=0
	begin
		name = (master_skater_list[<index>].name)
		if StructureContains structure=<team> <name>
            switch <index2>
				case 0
					team_name1=(master_skater_list[<index>].display_name)
				case 1
					team_name2=(master_skater_list[<index>].display_name)
				case 2
					team_name3=(master_skater_list[<index>].display_name)
				case 3
					team_name4=(master_skater_list[<index>].display_name)
				case 4
					team_name5=(master_skater_list[<index>].display_name)
				default
					return
			endswitch
            index2 = (<index2> + 1)
		endif
		index = ( <index> + 1 )
	repeat <array_size>
	
	RemoveParameter name
	RemoveParameter team
	RemoveParameter num_team_members
	RemoveParameter index
	RemoveParameter index2
	RemoveParameter array_size
	
	;printstruct <...>
	return <...>
endscript

//// nightvision effect for Moscow Level

nightvision_hud_is_hidden=0

script nightvision_hud 
	if ScreenElementExists id=nightvision_hud_anchor
		DestroyScreenElement id=nightvision_hud_anchor
	endif
	
	SetScreenElementLock off id=root_window
	
	CreateScreenElement {
		type=ContainerElement
		id=nightvision_hud_anchor
		parent=root_window
		pos=(320,240)
		dims=(640,480)
	}
	
	// screen
	CreateScreenElement {
        type=SpriteElement
        parent=nightvision_hud_anchor
		id=nightvision_video_screen
		texture=videoscreen
		pos=(320,240)
        just=[center center]
		scale=(5,10)
        alpha=0.3
	}
	
	// line
	CreateScreenElement {
		type=SpriteElement
		id=nightvision_hud_line
        parent=nightvision_hud_anchor
		texture=white2
		pos=(0,0)
        just=[left center]
		scale=(100,0.1)
        alpha=0.5
	}
	
    RunScriptOnScreenElement id=nightvision_video_screen flicker_nightvision_video_screen 
	RunScriptOnScreenElement id=nightvision_hud_line morph_nightvision_hud_line
endscript

script kill_nightvision_hud
		if ScreenElementExists id=nightvision_hud_anchor
			DestroyScreenElement id=nightvision_hud_anchor
		endif
endscript

script nightvision_hud_fade_in
	fadetoblack on time=0 alpha=1.0 z_priority=5
	wait 0.2 seconds
	fadetoblack off time=0.5
endscript

script really_kill_flicker_nightvision_hud
	wait 0.7 seconds
	fadetoblack off time=0
	if ScreenElementExists id=nightvision_hud_anchor
		DestroyScreenElement id=nightvision_hud_anchor
	endif
endscript



script flicker_nightvision_video_screen time=0.05
	begin
		DoScreenElementMorph id=nightvision_video_screen alpha=0.3 time=<time>
		wait <time> seconds
		DoScreenElementMorph id=nightvision_video_screen alpha=0.225 time=<time>
		wait <time> seconds
	repeat
endscript

script morph_nightvision_hud_line time=1.5
	begin
		DoScreenElementMorph id=nightvision_hud_line pos=(0,480) time=<time>
		wait <time> seconds
		DoScreenElementMorph id=nightvision_hud_line pos=(0,0)
	repeat
endscript

script dont_use_level_lights
	if not gotparam model
		script_assert "no model name specified"
	endif	
	<model>:Obj_SetLightAmbientColor 	r=128 g=128 b=128	
	<model>:Obj_SetLightDiffuseColor    index=0 r=0 g=0 b=0
	<model>:Obj_SetLightDiffuseColor    index=1 r=0 g=0 b=0
//	direction shouldn't matter because there's no diffuse color   
//	<model>:Obj_SetLightDirection       index = 0 heading = 0 pitch = 350
//	<model>:Obj_SetLightDirection       index = 1 heading = 0 pitch = 200
	
	// DEBUGGING (trying to track down weird lighting in some cutscenes):
//	<model>:Obj_SetLightDiffuseColor    index=0 r=255 g=0 b=0
//	<model>:Obj_SetLightDiffuseColor    index=1 r=0 g=255 b=0   
//	<model>:Obj_SetLightDirection       index = 0 heading = 0 pitch = 350
//	<model>:Obj_SetLightDirection       index = 1 heading = 0 pitch = 200
endscript

