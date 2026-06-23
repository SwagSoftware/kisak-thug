// don't pull out the damn controller!

controller_unplugged_frame_count = 45

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script controller_unplugged
	; printf "controller_unplugged"
	GetSkaterId
	// don't do anything while a skater cam anim is playing
	if not LevelIs load_skateshop
		if not LevelIs load_boardshop
			if not LevelIs load_cas
				if not SkaterCamAnimFinished skater=<objId>
					return
				endif
			endif
		endif
	endif

	if GotParam leaving_net_game
		PauseGame
		PauseMusicAndStreams
	endif

	// make sure we don't do this twice
	KillSpawnedScript name=wait_and_check_for_unplugged_controllers
	change check_for_unplugged_controllers = 0
	SpawnScript create_controller_unplugged_dialog params=<...>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script create_controller_unplugged_dialog
	; printf "create_controller_unplugged_dialog"
	; printstruct <...>
	// hide the root window and block all events
	SetScreenElementProps {
		id=root_window
		block_events
		hide
	}

	<showing_comp_results> = 0
	root_window:GetTags

	// pause game
	<front_end_paused> = 0
	if GameIsPaused
		<front_end_paused> = 1
	endif
	if not GotParam leaving_net_game
		if ( ( LevelIs load_skateshop ) || ( LevelIs load_boardshop ) || ( LevelIs load_cas ) )
			GoalManager_DeactivateAllGoals
			GoalManager_UninitializeAllGoals
			PauseGame
			PauseMusicAndStreams 1
		else
			if ( <showing_comp_results> = 0 )
				GoalManager_PauseAllGoals
				PauseGame
				PauseMusicAndStreams 1
			else
				PauseGame
				PauseMusicAndStreams 1
				SetButtonEventMappings unblock_menu_input
			endif
		endif
	endif

	wait 1 frame

	// create a new root window
	CreateScreenElement {
		type=WindowElement
		id=unplugged_root_window
	}

	unplugged_root_window:SetTags front_end_paused=<front_end_paused>
	unplugged_root_window:SetTags menu_state=<menu_state>
	unplugged_root_window:SetTags showing_comp_results=<showing_comp_results>

	// cover the screen with a big, black box
	CreateScreenElement {
		type=SpriteElement
		parent=unplugged_root_window
		texture=white2
		pos=(0, 0)
		just=[left top]
		rgba=[0 0 0 128]
		scale=(80, 60)
		z_priority=999
	}
	// container for message
	CreateScreenElement {
		type=ContainerElement
		parent=unplugged_root_window
		id=controller_unplugged_dialog_anchor
		pos=(320, 240)
		dims=(640, 480)
		z_priority=1000
	}
	<anchor_id> = <id>

	// figure text for message
	pad_choose_script = controller_refresh
	if GotParam leaving_net_game
		FormatText TextName=text "Controller disconnected. Please reconnect the controller to port %i and press START to return to the main menu." i=( <device_num> + 1 )
		unplugged_root_window:SetTags leaving_net_game
	else
		if IsNGC
			FormatText TextName=text "Please reconnect the controller to Controller Socket %i and press START to continue." i=( <device_num> + 1 )
		else
			if IsPs2
				FormatText TextName=text "Please insert a controller into controller port %i and press START to continue." i=( <device_num> + 1 )
			else
				FormatText TextName=text "Please reconnect the controller to port %i and press START to continue." i=( <device_num> + 1 )
			endif
		endif
	endif

	// text block
	<text_block_pos> = (320, 200)
	CreateScreenElement {
		type=TextBlockElement
		parent=<anchor_id>
		pos=<text_block_pos>
		dims=(300, 0)
		allow_expansion
		just=[center center]
		font=small
		text=<text>
		z_priority=1000
	}

	// "ok" button
	GetScreenElementDims id=<id>
	<button_pos> = ( <text_block_pos> + ( <height> * (0, 1) ) )
	CreateScreenElement {
		parent=<anchor_id>
		type=TextElement
		font=small
		text="OK"
		pos=<button_pos>
		just=[center top]
		rgba=[128 128 128 128]
		z_priority=1000
		event_handlers=[
			{ focus do_scale_up }
			{ unfocus do_scale_down }
			{ pad_choose <pad_choose_script> params={ original_device_num = <device_num> } }
			{ pad_start <pad_choose_script> params={ original_device_num = <device_num> } }
		]
	}
	FireEvent type=focus target=<id>

	// reset the root screen element, so the new root window
	// is updated, and the old one is ignored
	SetRootScreenElement id=unplugged_root_window
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script controller_refresh
	; printf "controller_refresh"
	if ( <original_device_num> = <device_num> )
		controller_reconnected device_num=<device_num>

		if CustomParkMode editing
			if not istrue in_create_a_goal
				if not ScreenElementExists id=dialog_box_anchor
					if not ScreenElementExists id=files_menu
						if not ScreenElementExists id=keyboard_anchor
							if not ObjectExists id=park_resize_cam
								parked_continue_editing
								ResetAbortAndDoneScripts
							endif
						endif
					endif
				endif
			endif
		else
			// If in the middle of a mem card save/load sequence, abort it.
			// Part of fix to TT11597, other bit was in mem_card_message_pause in memcard.q,
			// making the check card loop bail out if the controller-pulled menu is up.
			if not (AbortScript = DefaultAbortScript)
				goto reload_anims_then_run_abort_script
			endif
		endif
	endif
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script controller_reconnected
	; printf "controller_reconnected"
	; change check_for_unplugged_controllers = 1

	if not GotParam leaving_net_game
		if not LevelIs load_skateshop
			if not LevelIs load_boardshop
				if not LevelIs load_cas
					if not istrue in_create_a_goal
						if not CustomParkMode editing
							if not ScreenElementExists id=timeline_vmenu
								Restore_skater_camera
							endif
						endif
					endif
				endif
			endif
		endif
	endif

	SetRootScreenElement id=root_window
	SetScreenElementProps {
		id=root_window
		unblock_events
		unhide
	}

	// see if we need to create the pause menu
	if not GotParam leaving_net_game
		if ScreenElementExists id=pre_cat_menu_is_up
			UnpauseGame
			if LevelIs load_nj
				Skater:Obj_MoveToNode name=TRG_G_CAT_RestartNode Orient NoReset
			endif
			PauseGame
			create_pre_cat_menu
		else
			if istrue in_create_a_goal
				if istrue goal_editor_placement_mode
					Debounce X time=0.2 clear=1
					GoalEditor:UnPause
					if ObjectExists id=GoalEditorCursor
						GoalEditorCursor:UnPause
					endif
				endif
			else
				unplugged_root_window:GetTags
				if ( <front_end_paused> = 0 )
					UnPauseGame
					UnPauseMusicAndStreams
				endif
				if not ( ( LevelIs load_skateshop ) || ( LevelIs load_boardshop ) || ( LevelIs load_cas ) )
					if ( <showing_comp_results> = 1 )
						// uh...
					else
						if not CustomParkMode editing
							if ( <menu_state> = off )
								FireEvent {
									type = pad_start
									target = root_window
									data = { device_num = <device_num> }
								}
							endif
						endif
					endif
				endif
			endif
		endif
	endif

	if ScreenElementExists id=unplugged_root_window
		DestroyScreenElement {
			id=unplugged_root_window
		}
	endif

	// BB - hack for high scores menu, which won't cooperate
	if ScreenElementExists id=high_scores_records_menu
		FireEvent type=focus target=high_scores_records_menu
	endif

	if GotParam leaving_net_game
		printf "quitting network game!!!!!!!!!!!!!!!!!!!"
		UnPauseGame
		quit_network_game
	else
		SpawnScript wait_and_check_for_unplugged_controllers
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script controller_pulled_disconnect_message
	GoalManager_DeactivateAllGoals force_all
	GoalManager_UninitializeAllGoals
	GoalManager_SetCanStartGoal 0
	exit_pause_menu // menu_id=pause_menu
	destroy_onscreen_keyboard
	force_close_rankings dont_retry

	if InNetGame
		if LocalSkaterExists
			skater:Vibrate off
		endif
	endif

	if Not IsObserving
		ExitSurveyorMode
	endif

	dialog_box_exit
	dialog_box_exit anchor_id=link_lost_dialog_anchor
	create_error_box {
		title="Notice"
		text="Controller disconnected. Select OK to leave this game."
		buttons=[ { text="ok" pad_choose_script=accept_lost_connection } ]
		delay_input
	}
endscript

/********************************************************/
/*					Old shit!							*/
/*														*/
/********************************************************/

// ****************************************
// 	disconnected controller stuff
// ****************************************

script wait_and_check_for_unplugged_controllers time=50
	wait <time>
	change check_for_unplugged_controllers=1
endscript
