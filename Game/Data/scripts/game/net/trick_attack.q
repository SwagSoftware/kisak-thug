// @DOC goal_trickattack

goal_trickattack_genericParams = {
	goal_text = "You must score the most points to win!"
	time = 10
	net

	init = goal_trickattack_init
	activate = goal_trickattack_activate
	deactivate = goal_trickattack_deactivate
	expire = goal_trickattack_expire

	goal_description = "TrickAttack!"
}

script goal_trickattack_init
endscript

script goal_trickattack_activate
	// make the time look cool
	;SetScreenElementProps {
	;	id=the_time
	;	alpha=1
	;}
	ResetComboRecords
	if InTeamGame
		FormatText TextName=msg_text "\c2Trick Attack:\c0\nMost points wins"
	else
		FormatText TextName=msg_text "\c2Trick Attack:\c0\nMost points wins"
	endif
	if InSplitScreenGame
		MakeSkaterGosub add_skater_to_world skater=0
		MakeSkaterGosub add_skater_to_world skater=1
		ScriptGetScreenMode
		switch <screen_mode>
			case split_vertical
				msg_pos=(350,42)
			case split_horizontal
				msg_pos=(620,27)
		endswitch
	else
		msg_pos=(620,27)
	endif

	if InNetGame
		create_panel_block id=mp_goal_text text=<msg_text> style=panel_message_goal final_pos=<msg_pos>
	endif

	if GameModeEquals is_singlesession
		Skater:RunStarted
		SetScoreAccumulation 1
		SetScoreDegradation 1
	endif

	RunScriptOnScreenElement id=the_time clock_morph
	ResetScore
	//goal_start goal_id=<goal_id>
endscript

script goal_trickattack_deactivate
	//GoalManager_RemoveGoal name=<goal_id>
	; GoalManager_EditGoal name=<goal_id> params={ called_goal_trick_attack_high_score_menu = 0 }

	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif

	if GameModeEquals is_singlesession
		SetScoreAccumulation 0
		SetScoreDegradation 0

		// TT8872: Dont spawn the highscore menu if the goal was deactivated by quitting to main menu
		//  also, dont' destroy any dialog boxes to create the high scores menu.
		if not ObjectExists id=dialog_bg_anchor
			if not GotParam quick_start
				PauseGame
				root_window:SetTags menu_state=on
				SpawnScript goal_trick_attack_high_score_menu params={ restart_node=<restart_node> }
				; GoalManager_EditGoal name=<goal_id> params={ called_goal_trick_attack_high_score_menu = 1 }
			else
				ResetSkaters node=<restart_node>
			endif
		else
			ResetSkaters node=<restart_node>
		endif
	endif
endscript

script goal_trick_attack_high_score_menu
	// K: This flag gets set here so as to cause the replays to quit to the
	// paused menu when they end.
	// Need to set it here because the session has ended. If not set, at the
	// end of the replay it will quit to the skater in the game, and the skater
	// will be disabled due to the end of run. (TT7166)
	Change EndOfReplayShouldJumpToPauseMenu=1
	kill_start_key_binding
	PauseGame
	pause_trick_text

	if ScreenElementExists id=goal_start_dialog
		DestroyScreenElement id=goal_start_dialog
	endif

	UpdateRecords
	if NewRecord
		high_scores_menu_enter_initials restart_node=<restart_node>
		FireEvent type=focus target=keyboard_vmenu
	else
		high_scores_menu_create restart_node=<restart_node>
	endif
	ResetComboRecords
endscript

// script trickattack_done
// dialog_box_exit
// do_backend_retry
;MakeSkaterGoto SkaterInit
// endscript

script goal_trickattack_expire
	//MakeSkaterGoto SkaterInit
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif

	if not GameModeEquals is_singlesession
		if InSplitScreenGame
			create_rankings
		else
			if OnServer
				SpawnScript wait_then_create_rankings
			else
				create_rankings
			endif
		endif
	endif
endscript

script AddGoal_TrickAttack
	GoalManager_AddGoal name=trickattack {
		params={ goal_trickattack_genericParams
		}
	}
endscript

script StartGoal_TrickAttack
	if InSplitScreenGame
		SetScreenModeFromGameMode
	endif
	GoalManager_EditGoal name=trickattack params = <...>
	GoalManager_ActivateGoal name=trickattack
endscript

script TrickAttack_MenuStartRun
	GoalManager_ActivateGoal name=trickattack
	exit_pause_menu
endscript

script end_high_score_run
	change check_for_unplugged_controllers = 0
	exit_pause_menu
	GoalManager_DeactivateGoal name=trickattack
	; GoalManager_GetGoalParams name=trickattack
	change check_for_unplugged_controllers = 1
endscript
