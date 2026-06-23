// @DOC goal_scorechallenge

goal_scorechallenge_genericParams = {
	goal_text = "You must score the most points to win!"
	unlimited_time = 1
	score = 1000000
	net

	init = goal_scorechallenge_init
	activate = goal_scorechallenge_activate
	active = goal_scorechallenge_active
	deactivate = goal_scorechallenge_deactivate

	goal_description = "Score Challenge!"
}

script goal_scorechallenge_init
endscript

script goal_scorechallenge_activate
	// make the time look cool
	;SetScreenElementProps {
	;	id=the_time
	;	alpha=1
	;}

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


	;create_panel_block id=current_goal text=<msg_text> style=panel_message_goal
	if InNetGame
		switch <score>
			case 100000
				score_string="100,000 pts"
			case 250000
				score_string="250,000 pts"
			case 500000
				score_string="500,000 pts"
			case 1000000
				score_string="1,000,000 pts"
			case 2000000
				score_string="2,000,000 pts"
			case 5000000
				score_string="5,000,000 pts"
			case 10000000
				score_string="10,000,000 pts"
			case 50000000
				score_string="50,000,000 pts"
			case 100000000
				score_string="100,000,000 pts"
		endswitch
		if InTeamGame
			FormatText TextName=msg_text "\c3Score \n\c3Challenge:\n\c0%s \nto win" s=<score_string>
		else
			FormatText TextName=msg_text "\c3Score \n\c3Challenge:\n\c0%s \nto win" s=<score_string>
		endif
		create_panel_block id=sc_goal_text text=<msg_text> style=panel_message_goal final_pos=<msg_pos>
	endif

	printf "************** ACTIVATING SCORECHALLENGE **********************"
	;RunScriptOnScreenElement id=the_time clock_morph
	ResetScore
	//goal_start goal_id=<goal_id>
endscript

script goal_scorechallenge_active
	if AnySkaterTotalScoreAtLeast <score>
		if OnServer
			if CalculateFinalScores
				GoalManager_DeactivateGoal name=<goal_id>
				goal_scorechallenge_finished
			endif
		else
			GoalManager_DeactivateGoal name=<goal_id>
			goal_scorechallenge_finished
		endif
	endif
endscript

script goal_scorechallenge_deactivate
	destroy_goal_panel_messages
	if ObjectExists id=sc_goal_text
		DestroyScreenElement id=sc_goal_text
	endif
endscript

script goal_scorechallenge_finished
	destroy_goal_panel_messages
	if ObjectExists id=sc_goal_text
		DestroyScreenElement id=sc_goal_text
	endif
	printf "goal_scorechallenge_deactivate"
	ResetScorePot
	if OnServer
		if InInternetMode
			ReportStats final
		endif
	endif
	create_rankings
endscript

script scorechallenge_done
	dialog_box_exit
	do_backend_retry
	;MakeSkaterGoto SkaterInit
endscript

script AddGoal_scorechallenge
	GoalManager_AddGoal name=scorechallenge {
		params={ goal_scorechallenge_genericParams
		}
	}
endscript

script StartGoal_scorechallenge
	if InSplitScreenGame
		SetScreenModeFromGameMode
	endif
	GoalManager_EditGoal name=scorechallenge params = <...>
	GoalManager_ActivateGoal name=scorechallenge
endscript

