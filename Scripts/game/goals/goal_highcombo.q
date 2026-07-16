// start autoduck documentation
// @DOC goal_highcombo
// @module goal_highcombo | None
// @subindex Scripting Database
// @index script | goal_highcombo

goal_highcombo_genericParams = {
    goal_text = "generic highcombo text"
	view_goals_text = "High combo"
    time = 120
    
    init = goal_highcombo_init
	uninit = goal_uninit
    activate = goal_highcombo_activate
	; active = goal_highcombo_active
    success = goal_highcombo_success
    fail = goal_highcombo_fail
    deactivate = goal_highcombo_deactivate
    expire = goal_highcombo_expire
    
    trigger_obj_id = TRG_G_HIGHCOMBO_Pro
    restart_node = TRG_G_HIGHCOMBO_RestartNode
    start_pad_id = G_HIGHCOMBO_StartPad
    
    exception_set = 0
	
	score = 10000
	
	record_type = score
	
	high_combo
}

goal_highcombo2_genericParams = {
    goal_text = "generic highcombo2 text"
	view_goals_text = "Highcombo2 goal"
    time = 120
    
    init = goal_highcombo_init
	uninit = goal_uninit
    activate = goal_highcombo_activate
	; active = goal_highcombo_active
    success = goal_highcombo_success
    fail = goal_highcombo_fail
    deactivate = goal_highcombo_deactivate
    expire = goal_highcombo_expire
    
    trigger_obj_id = TRG_G_HIGHCOMBO2_Pro
    restart_node = TRG_G_HIGHCOMBO2_RestartNode
    start_pad_id = G_HIGHCOMBO2_StartPad
    
    exception_set = 0
	
	score = 10000
	
	record_type = score
	
	high_combo
}


script goal_highcombo_init
	goal_init goal_id=<goal_id>
endscript

script goal_highcombo_activate
    goal_start goal_id=<goal_id>
	SetScoreAccumulation 0
endscript

script goal_highcombo_check_score
	GoalManager_GetGoalParams name=<goal_id>
	if ( <last_score_landed> > <score> )
        GoalManager_WinGoal name=<goal_id>
	endif
endscript

script goal_highcombo_success
    goal_success goal_id=<goal_id>
endscript

script goal_highcombo_deactivate
    GoalManager_ResetGoalTrigger name=<goal_id>
	goal_deactivate goal_id=<goal_id>
endscript

script goal_highcombo_fail
    goal_fail goal_id=<goal_id>
endscript

script goal_highcombo_expire
    goal_expire goal_id=<goal_id>
	GoalManager_LoseGoal name=<goal_id>
endscript
