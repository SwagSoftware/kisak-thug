// start autoduck documentation
// @DOC goal_graffiti
// @module goal_graffiti | None
// @subindex Scripting Database
// @index script | goal_graffiti

goal_graffiti_genericParams = {
	goal_text = "You must tag more objects to win!"
	time = 10
	net

	init = goal_graffiti_init
	activate = goal_graffiti_activate
	deactivate = goal_graffiti_deactivate
	expire = goal_graffiti_expire

	goal_description = "Graffiti!"
}

script goal_graffiti_init
endscript

script goal_graffiti_activate
	if InTeamGame
		FormatText TextName=msg_text "\c4Graffiti:\n\c0The team with the most tags wins."
	else
		FormatText TextName=msg_text "\c4Graffiti:\n\c0The player with the most tags wins."
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

script goal_graffiti_deactivate
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
endscript

script graffiti_done
	dialog_box_exit
	do_backend_retry
endscript

script goal_graffiti_expire
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
	if ObjectExists id=goal_message
		DestroyScreenElement id=goal_message
	endif
	printf "goal_graffiti_expire"
	//create_rankings score_title_text="TAGS"
	if OnServer
		SpawnScript wait_then_create_rankings params={score_title_text="TAGS"}
	else
		create_rankings score_title_text="TAGS"
	endif
endscript

script AddGoal_Graffiti
	GoalManager_AddGoal name=graffiti {
		params={ goal_graffiti_genericParams
			<...>
		}
	}
endscript

script StartGoal_Graffiti
	if InSplitScreenGame
		SetScreenModeFromGameMode
	endif
	GoalManager_EditGoal name=graffiti params = <...>
	GoalManager_ActivateGoal name=graffiti
endscript
