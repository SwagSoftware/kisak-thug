// start autoduck documentation
// @DOC goal_combomambo
// @module goal_combomambo | None
// @subindex Scripting Database
// @index script | goal_combomambo

goal_combomambo_genericParams = {
    goal_text = "You must score the most points to win!"
    time = 10
	net
    
    init = goal_combomambo_init
    activate = goal_combomambo_activate
    deactivate = goal_combomambo_deactivate
	expire = goal_combomambo_expire
    
    goal_description = "Combo Mambo!"
}

script goal_combomambo_init
endscript

script goal_combomambo_activate
	if InTeamGame
		FormatText TextName=msg_text "\c4Combo Mambo:\n\c0Highest-scoring combo wins."
	else
		FormatText TextName=msg_text "\c4Combo Mambo:\n\c0Highest-scoring combo wins."
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
	RunScriptOnScreenElement id=the_time clock_morph
	ResetScore
    //goal_start goal_id=<goal_id>
endscript

script goal_combomambo_deactivate
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
    ; MakeSkaterGoto SkaterInit
    //GoalManager_RemoveGoal name=<goal_id>
endscript

script combomambo_done
	dialog_box_exit
	do_backend_retry
	;MakeSkaterGoto SkaterInit
endscript
							  
script goal_combomambo_expire
	//MakeSkaterGoto SkaterInit
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
	printf "goal_combomambo_expire"

	if GameModeEquals is_singlesession
		UpdateRecords
		high_scores_menu_create
		ResetComboRecords
	else
		if OnServer
			SpawnScript wait_then_create_rankings params={score_title_text="BEST COMBO" }
		else
			create_rankings score_title_text="BEST COMBO" 
		endif
	endif
endscript

script AddGoal_combomambo
	GoalManager_AddGoal name=combomambo {
        params={ goal_combomambo_genericParams
               }
    }
endscript

script StartGoal_combomambo
	if InSplitScreenGame
		SetScreenModeFromGameMode
	endif
    GoalManager_EditGoal name=combomambo params = <...>
	GoalManager_ActivateGoal name=combomambo
endscript

