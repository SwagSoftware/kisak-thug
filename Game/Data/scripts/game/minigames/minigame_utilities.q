// minigame stuff



;script create_minigame_message
;	SetScreenElementLock id=root_window off
;
;	if ObjectExists id=
;

script minigame_init
	GoalManager_GetGoalParams name=<goal_id>
	if GotParam init_script
		SpawnScript <init_script> params={ <init_script_params> goal_id=<goal_id> }
	endif
endscript

script minigame_activate
	GoalManager_GetGoalParams name=<goal_id>
	// run custom activate script
	if GotParam activate_script
		SpawnScript <activate_script> params={ <activate_script_params> goal_id=<goal_id> }
	endif
endscript


script minigame_deactivate
	GoalManager_GetGoalParams name=<goal_id>
	minigame_hide_timer
	if GotParam deactivate_script
		SpawnScript <deactivate_script> params={ <deactivate_script_params> goal_id=<goal_id> }
	endif
endscript

script minigame_hide_timer
	SetScreenElementProps {
		id=minigame_timer
		text=""
	}
endscript

script minigame_got_cash
	FormatText TextName=message "You got $%i!" i=<amount>
	create_panel_message id=goal_current_reward text=<message> style=goal_message_got_stat params={ sound=cash }
endscript

script minigame_cash_depleted
	create_panel_message {
		id=goal_current_reward
		text="You've collected all the cash for this minigame"
		style=goal_message_got_stat
		params={ sound=cash }
	}
endscript

// *********************************************
//			Style scripts
// *********************************************
