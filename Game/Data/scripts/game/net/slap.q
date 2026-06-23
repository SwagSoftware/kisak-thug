// @DOC goal_slap

goal_slap_genericParams = {
	goal_text = "You must slap the most players to win!"
	time = 10
	net

	init = goal_slap_init
	activate = goal_slap_activate
	deactivate = goal_slap_deactivate
	expire = goal_slap_expire

	goal_description = "Slap!"
}

script goal_slap_init
endscript

script goal_slap_activate
	if InTeamGame
		FormatText TextName=msg_text "\c2Slap! \n\c0The team with the most slaps wins."
	else
		FormatText TextName=msg_text "\c2Slap! \n\c0The player with the most slaps wins."
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
	// make the time look cool
	RunScriptOnScreenElement id=the_time clock_morph
	ResetScore
	;	SetScreenElementProps {
	;		id=the_time
	;		alpha=1
	;	}
endscript

script goal_slap_deactivate
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
endscript

script slap_done
	dialog_box_exit
	do_backend_retry
endscript

script goal_slap_expire
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
	printf "goal_slap_expire"
	//create_rankings score_title_text="SLAPS"
	if OnServer
		SpawnScript wait_then_create_rankings params={score_title_text="SLAPS"}
	else
		create_rankings score_title_text="SLAPS"
	endif
endscript

script AddGoal_Slap
	GoalManager_AddGoal name=slap {
		params={ goal_slap_genericParams
			<...>
		}
	}
endscript

script StartGoal_Slap
	if InSplitScreenGame
		SetScreenModeFromGameMode
	endif
	GoalManager_EditGoal name=slap params = <...>
	GoalManager_ActivateGoal name=slap
endscript
