// start autoduck documentation
// @DOC goal_score
// @module goal_score | None
// @subindex Scripting Database
// @index script | goal_score
Goal_GenericScore_genericParams = {
    goal_text = "Get a High Score: 15,000 Points"
	view_goals_text = "High score"
    
    init = Score_init
	uninit = goal_uninit
    activate = Score_activate
    ; active = Score_Active
    deactivate = Score_Deactivate
    expire = Score_expire
    fail = Score_fail
    success = Score_success

    trigger_obj_id = TRG_G_GS_Pro
    
    restart_node = TRG_G_GS_RestartNode
    start_pad_id = G_GS_StartPad
    
    score = 15000
    
    time = 120
	
	already_displayed_win_message = 0
	win_message_text = "High Score: Complete!"
	record_type = time
	
	score_goal
}

Goal_HighScore_genericParams = {
    goal_text = "Get a High Score: 15,000 Points"
	view_goals_text = "High score"
    
    init = Score_init
	uninit = goal_uninit
    activate = Score_activate
    ; active = Score_Active
    deactivate = Score_Deactivate
    expire = Score_expire
    fail = Score_fail
    success = Score_success

    trigger_obj_id = TRG_G_HS_Pro
    
    restart_node = TRG_G_HS_RestartNode
    start_pad_id = G_HS_StartPad
    
    score = 15000
    
    time = 120
	
	already_displayed_win_message = 0
	win_message_text = "High Score: Complete!"
	record_type = time
	
	score_goal
}

Goal_ProScore_GenericParams = {
    goal_text = "Get a Pro Score: 20,000 Points"
	view_goals_text = "Pro score"
    init = Score_init
	uninit = goal_uninit
    activate = Score_activate
    ; active = Score_Active
    deactivate = Score_Deactivate
    expire = Score_expire
    fail = Score_fail
    success = Score_success   
    
    // add trigger object id here, and then comment in line 47
    trigger_obj_id = TRG_G_PS_Pro
    
    restart_node = TRG_G_PS_RestartNode
    start_pad_id = G_PS_StartPad
    
    score = 20000
    
    time = 120
	
	already_displayed_win_message = 0
	win_message_text = "Pro Score: Complete!"
	
	record_type = time
	
	score_goal
}

Goal_SickScore_GenericParams = {
    goal_text = "Get a Sick Score: 30,000 Points"
	view_goals_text = "Sick score"
    init = Score_init
	uninit = goal_uninit
    activate = Score_activate
    ; active = Score_Active
    deactivate = Score_Deactivate
    expire = Score_expire
    fail = Score_fail
    success = Score_success   
    
    trigger_obj_id = TRG_G_SS_Pro
    restart_node = TRG_G_SS_RestartNode
    start_pad_id = G_SS_StartPad
    
    score = 30000
    
    time = 120
	
	already_displayed_win_message = 0
	win_message_text = "Sick Score: Complete!"
	
	record_type = time
	
	score_goal
}


script Score_init
    ; GoalManager_InitGoalTrigger name=<goal_id>
	goal_init goal_id=<goal_id>
	
	// mandatory 2 minute run
	//GoalManager_EditGoal name=<goal_id> params={ time=120 }
   	
	; if GoalManager_GetGoalParam score name=<goal_id> type=integer
		; GoalManager_EditGoal name=<goal_id> params=<...>
	; endif
	; FormatText TextName=goal_text "Get %i points" i=<score>	
endscript


script score_activate
	goal_start goal_id=<goal_id>
endscript


/*script score_active
    // check the current score against the necessary score
	if SkaterTotalScoreGreaterThan <score>
		GoalManager_WinGoal name=<goal_id>
    endif
endscript*/

script score_success
    goal_success goal_id=<goal_id>
	
	if GotParam winning_score
		FormatText TextName=text "Score: %i" i=<winning_score>
		create_panel_message {
			id=goal_current_reward
			text=<text>
			style=goal_message_got_trickslot
			; params={ sound=AcquireReward }
		}
	endif
endscript

script score_deactivate
	GoalManager_ResetGoalTrigger name=<goal_id>
	goal_deactivate goal_id=<goal_id>
	GoalManager_EditGoal name=<goal_id> params={ already_displayed_win_message=0 }
	SpawnScript goal_score_wait_and_reset_score
endscript

script goal_score_wait_and_reset_score
	wait 1 frame
	ResetScore
endscript

script score_expire
	goal_expire goal_id=<goal_id>
	GoalManager_LoseGoal name=<goal_id>
endscript

script score_fail
    goal_fail goal_id=<goal_id>
endscript

// **************************************
// 			style scripts
// **************************************

script goal_score_win_message

SetProps rgba=[43 95 53 128] 
	DoMorph time=0 pos=(0, 284) scale=0 alpha=0
    ;DoMorph time=.5 
    DoMorph time=.2 pos=(321, 285) scale=1.9 alpha=1
    DoMorph time=.2 scale=.8
    DoMorph time=.2 scale=1.3
    DoMorph time=.1 scale=.9
    DoMorph time=.1 scale=1.0
    DoMorph pos=(321,285) time=.1 alpha=.6
    DoMorph pos=(319,283) time=.1 alpha=1
    DoMorph pos=(321,285) time=.1 alpha=.8
    DoMorph pos=(319,283) time=.1 alpha=1
    DoMorph pos=(321,285) time=.1 alpha=.5
    DoMorph pos=(319,283) time=.1 alpha=1
    DoMorph pos=(321,285) time=.1 alpha=.7
    DoMorph pos=(319,283) time=.1 alpha=1
    DoMorph pos=(321,285) time=.1 alpha=.9
    DoMorph pos=(319,283) time=.1 alpha=1
    DoMorph pos=(321,285) time=.1 alpha=.4
    DoMorph pos=(319,283) time=.1 alpha=1
    DoMorph pos=(321,285) time=.1 alpha=.6
    DoMorph pos=(319,283) time=.1 alpha=1
    DoMorph pos=(321,285) time=.1 alpha=.8
    DoMorph pos=(319,283) time=.1 alpha=1
    DoMorph pos=(321,285) time=.1 alpha=.7
    DoMorph pos=(319,283) time=.1 alpha=1
    DoMorph pos=(305,285) time=.2 alpha=1
    DoMorph pos=(305,285) time=.4 alpha=1
    DoMorph time=.2 alpha=0  pos=(600, 284) rgb=[50 50 50]  

	// play a sound?
	wait 1500
	Die
endscript
