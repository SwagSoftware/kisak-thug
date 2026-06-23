//////////////////////////////////////////////////////////////////////
// game.q
//

script PauseMusicAndStreams
	//	printf "pausing music -----------------------"
	PauseMusic 1
	PauseStream 1
endscript

script UnPauseMusicAndStreams
	//	printf "---------------unpausing music-----------------------"
	PauseMusic 0
	PauseStream 0
endscript

script do_backend_retry
	;    LaunchEvent type=hide target=game_menu
	;    LaunchEvent type=hide target=end_run_menu
	;    SetReplayMode REPLAY_MODE_OFF           ; no replay (messes up timer)
	GoalManager_UninitializeAllGoals
	if InNetGame
		if Not IsObserving
			ExitSurveyorMode
			Skater:add_skater_to_world
		endif
		ResetProSetFlags
		if Not IsObserving
			Skater:RunStarted
		endif
		ClearPowerups
	endif
	SpawnScript do_screen_freeze
endscript

script do_screen_freeze
	kill_net_panel_messages
	PauseGame
	if InNetGame
		exit_pause_menu menu_id=pause_menu
		force_close_rankings
		destroy_onscreen_keyboard
		StartNetworkLobby
	else
		exit_pause_menu menu_id=pause_menu
		force_close_rankings
		SetGameType freeskate2p
		SetCurrentGameType
	endif
	Wait 2 gameframe
	//DisplayLoadingScreen "loadscrn_generic"
	unpausegame
	retry
endscript

script entered_chat_message
	GetTextElementString id=keyboard_current_string
	SendChatMessage string = <string>
	destroy_onscreen_keyboard
endscript

script menu_entered_chat_message
	entered_chat_message
	create_pause_menu
endscript

script cancel_chat_menu
	destroy_onscreen_keyboard
	create_pause_menu
endscript

script launch_chat_keyboard
	hide_current_goal
	DestroyScreenElement id=current_menu_anchor
	create_onscreen_keyboard allow_cancel icon=<icon> keyboard_cancel_script=cancel_chat_menu keyboard_done_script=menu_entered_chat_message keyboard_title="ENTER MESSAGE" min_length=0 max_length=50 text=""
endscript

script enter_kb_chat
	create_onscreen_keyboard allow_cancel no_buttons pos=(320, 260) keyboard_done_script=entered_chat_message display_text="ENTER MESSAGE: " keyboard_title="ENTER MESSAGE" min_length=1 max_length=35
endscript

script send_chat_message
	printf "Sending chat message..."
	SendChatMessage <...>
endscript

script PreRunQueuedScripts
	SetSlomo 100.0
endscript

script PostRunQueuedScripts
	SetSlomo 1
endscript


