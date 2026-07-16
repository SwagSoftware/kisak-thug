// start autoduck documentation
// @DOC goal_horse
// @module goal_horse | None
// @subindex Scripting Database
// @index script | goal_horse

goal_horse_genericParams = {
    goal_text = "generic horse text"
	view_goals_text = "Horse goal"
    ;time = 120
    time = 3
    
    init = goal_horse_init
	uninit = goal_uninit
    activate = goal_horse_activate
    active = goal_horse_active
    success = goal_horse_success
    fail = goal_horse_fail
    deactivate = goal_horse_deactivate
    expire = goal_horse_expire
    
    trigger_obj_id = TRG_G_HORSE_Pro
    restart_node = TRG_G_HORSE_RestartNode
    start_pad_id = G_HORSE_StartPad
    
                                               
    goal_flags = [ got_1
                   got_2
                   got_3
                 ]
    
    horse_spots = [ { id=TRG_G_HORSE_Spot01 scr=sch_horse_spot01 flag=got_1 score=1000 time=10 text="spot 1" }
                    { id=TRG_G_HORSE_Spot02 scr=sch_horse_spot02 flag=got_2 score=2000 time=10 text="spot 2" }
                    { id=TRG_G_HORSE_Spot03 scr=sch_horse_spot03 flag=got_3 score=3000 time=10 text="spot 3" }
                  ]
				  
	;EndRunCalled = 0
	
	record_type = time
	
	should_check_trick = 0
	
	horse		// necessary horse flag
}
goal_horse2_genericParams = {
    goal_text = "generic horse2 text"
	view_goals_text = "Horse2 goal"
    ;time = 120
    time = 3
    
    init = goal_horse_init
	uninit = goal_uninit
    activate = goal_horse_activate
    active = goal_horse_active
    success = goal_horse_success
    fail = goal_horse_fail
    deactivate = goal_horse_deactivate
    expire = goal_horse_expire
    
    trigger_obj_id = TRG_G_HORSE2_Pro
    restart_node = TRG_G_HORSE2_RestartNode
    start_pad_id = G_HORSE2_StartPad
    
    goal_flags = [ got_1
                   got_2
                   got_3
                 ]
    
    horse_spots = [ { id=TRG_G_HORSE2_Spot01 scr=sch_horse2_spot01 flag=got_1 score=1000 time=10 text="spot 1" }
                    { id=TRG_G_HORSE2_Spot02 scr=sch_horse2_spot02 flag=got_2 score=2000 time=10 text="spot 2" }
                    { id=TRG_G_HORSE2_Spot03 scr=sch_horse2_spot03 flag=got_3 score=3000 time=10 text="spot 3" }
                  ]
				  
	;EndRunCalled = 0
	
	should_check_trick = 0
	
	record_type = time
	
	horse		// necessary horse flag
}

script goal_horse_init
    ; GoalManager_InitGoalTrigger name=<goal_id>
	goal_init goal_id=<goal_id>
	;ScreenElementSystemCleanup
endscript

script goal_horse_activate
    goal_start goal_id=<goal_id> dont_unpause=dont_unpause
	SetScoreAccumulation 0
	GoalManager_SetEndRunType name=<goal_id> Goal_EndOfRun
    GoalManager_NextHorseSpot name=<goal_id>
endscript

script goal_horse_next_spot
	GoalManager_EditGoal name=<goal_id> params={ should_check_trick = 0 }
	
	// move the skater to the new node if we need to 
	if not GotParam first_spot
		// printf "**** goal_horse_next_spot"
		;MakeSkaterGoto EndOfRun
		;oalManager_EditGoal name=<goal_id> params={ ;EndRunCalled = 1 }
		// Skater:DisablePlayerInput
		
		// Dan: It's not safe to just wait for the EndOfRunDone event after MakeSkaterGoto EndOfRun, as the skater can get pulled out of EndOfRun via a
		// kill plane and the like.  Normally, the wait is OK because the goal manager will keep trying to send the skater back to EndOfRun each frame.
		// Just not in this case.  We'll use SlowSkaterToStop instead.
		;WaitForEvent type=EndOfRunDone
		SlowSkaterToStop
		pause_trick_text
	
		;MakeSkaterGoto SkaterInit
		ResetSkaters Node_Name=<id>
		Wait 1 GameFrame
		PauseSkaters
	endif	
	
	if GotParam text
		create_speech_box text=<text> pad_choose_script=goal_horse_continue
	endif
	
	GoalManager_GetGoalParams name=<goal_id>
	if GotParam first_spot
		<cam_anim> = <start_cam_anim>
		goal_horse_next_spot2 <...>
	else		
		// move the trigger to the next spot
		if GotParam pro_node
			printf "moving pro"
			<trigger_obj_id>:Obj_MoveToNode name=<pro_node>
		endif
		<trigger_obj_id>:Obj_LookAtObject type=skater time=.05
		if GotParam cam_anim
			GetSkaterId
			PlaySkaterCamAnim skaterId=<ObjId> name=<cam_anim> skippable=1 play_hold
		endif
		
		create_speech_box {
			text="Press \m0 to continue"
			pos=(320, 400)
			pad_choose_script=goal_horse_next_spot2
			pad_choose_params=<...>
		}
	endif
endscript

script goal_horse_next_spot2
	; printf "goal_horse_next_spot2"
	; printstruct <...>
	DeBounce X time=.3
	GoalManager_PauseGoal name=<goal_id>
	
	GetSkaterId
	wait 1 gameframe	
	if GotParam first_spot
		if not GotParam quick_start
			WaitForEvent type=goal_cam_anim_post_start_done
			if not GoalManager_GoalIsActive name=<goal_id>
				return
			endif
		endif
	else
		if GotParam cam_anim
			begin
				if SkaterCamAnimFinished skaterId=<ObjId> name=<cam_anim>
					break
				endif
				wait 1 gameframe
			repeat
		endif
	endif
	
	unpause_trick_text
	speech_box_exit

	printf "unpausing"	
	FireEvent type=goal_horse_wait_done
	GoalManager_UnPauseGoal name=<goal_id>
	;GoalManager_EditGoal name=<goal_id> params={ EndRunCalled = 0 }
	UnPauseSkaters
	SpawnScript <scr>

	// show the next score total
	; wait 30 frame
	Skater:EnablePlayerInput
	
	// remember this score value and flag
	GoalManager_EditGoal name=<goal_id> params={ current_score=<score> }
	GoalManager_EditGoal name=<goal_id> params={ current_flag=<flag> }

	GoalManager_EditGoal name=<goal_id> params={ should_check_trick = 1 }
	; GoalManager_DisableEndOfRun name=<goal_id>
	GoalManager_SetShouldDeactivateOnExpire name=<goal_id> 0
	; GoalManager_GetGoalParams name=<goal_id>
	RunScriptOnObject id=<trigger_obj_id> goal_horse_set_trigger_exceptions params=<...>
endscript

script goal_horse_set_trigger_exceptions
    Obj_ClearExceptions
    ; Obj_SetException ex=SkaterLanded scr=goal_horse_check_score params={ goal_id=<goal_id> score=<score> flag=<flag> }
    Obj_SetException ex=SkaterBailed scr=goal_horse_skater_bailed params={ goal_id=<goal_id> }
endscript

/*script goal_horse_check_score
	printf "goal_horse_check_score"
    printstruct <...>
	Obj_ClearExceptions
    if SkaterLastScoreLandedGreaterThan <score>
        GoalManager_SetGoalFlag name=<goal_id> <flag> 1
        GoalManager_NextHorseSpot name=<goal_id>
    else
		printf "score no good!"
		GoalManager_LoseGoal name=<goal_id>
    endif
endscript
*/

script goal_horse_skater_bailed
    // disassociate with pro
	SpawnScript goal_horse_skater_bailed2 params={ goal_id=<goal_id> }
endscript
script goal_horse_skater_bailed2	
	GoalManager_LoseGoal name=<goal_id>
	GoalManager_EditGoal name=<goal_id> params={ should_check_trick = 0 }
endscript

script goal_horse_active
    if GoalManager_AllFlagsSet name=<goal_id>
        GoalManager_winGoal name=<goal_id>
    endif
endscript

script goal_horse_success
    goal_success goal_id=<goal_id>
endscript

script goal_horse_deactivate
	KillSpawnedScript name=goal_horse_next_spot
	KillSpawnedScript name=goal_horse_next_spot2
	KillSpawnedScript name=goal_horse_continue
	
	// Dan, TT12954.  If the skater deactivates the goal via a bail, his input is disabled by his bail scripts.
	// This line would re-inable his input, allowing for some very odd behavior.  So, I've removed it.  I no
	// longer think it is neccessary, as this goal no longer has any Skater:DisablePlayerInput calls.
    ;Skater:EnablePlayerInput
	
	// Dan: This will take care of itself now
	// do we have to get the skater out of endofrun?
	;if ( <EndRunCalled> = 1 )
		;MakeSkaterGoto SkaterInit
	;endif
	;GoalManager_EditGoal name=<goal_id> params={ EndRunCalled = 0 }
	
	KillSpawnedScript name=goal_horse_next_spot
	wait 1 frame
	if ObjectExists id=current_horse_spot
		DestroyScreenElement id=current_horse_spot
	endif
	
	<trigger_obj_id>:Obj_MoveToNode name=<trigger_obj_id>
	
	<trigger_obj_id>:Obj_ClearException SkaterLanded
	<trigger_obj_id>:Obj_ClearException SkaterBailed
    GoalManager_ResetGoalTrigger name=<goal_id>
	goal_deactivate goal_id=<goal_id>
endscript

script goal_horse_fail
    goal_fail goal_id=<goal_id>
endscript

script goal_horse_expire
	goal_expire goal_id=<goal_id>
	GoalManager_LoseGoal name=<goal_id>
endscript

script goal_horse_continue
	UnPauseSkaters
	speech_box_exit
endscript

// **************************************
// 		Style scripts
// **************************************
	
script panel_message_new_horse_spot blink_time=.05
/*	SetProps dims=(450,55) rgba=[128 128 128 80] just=[right top]
    DoMorph pos=(705,15) scale=1.3 time=1
    DoMorph pos=(705,15) scale=.6 time=1.1
    DoMorph pos=(705,15) scale=.8 time=1.11
    
    begin
        DoMorph alpha=0
        wait <blink_time> seconds
        DoMorph alpha=1
        wait <blink_time> seconds
    repeat 6
*/
	FormatText ChecksumName=text_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetProps just=[right top] rgba=<text_color>
	DoMorph pos=(445, 175)
	DoMorph pos=(445, 175) time=1.2
	DoMorph pos=(630, 63) scale=1.3 time=.1
    DoMorph pos=(630, 63) scale=.8 time=.11
    	
    begin
        DoMorph alpha=0
        wait <blink_time> seconds
        DoMorph alpha=1
        wait <blink_time> seconds
    repeat 6
endscript








goal_horse_mp_genericParams = {
    goal_text = "Complete the other players' tricks!"
    time = 10
	net
    
    init = goal_horse_mp_init
    activate = goal_horse_mp_activate
    deactivate = goal_horse_mp_deactivate
	expire = goal_horse_mp_expire
    
    goal_description = "Horse!"
}

script goal_horse_mp_init
	;ScreenElementSystemCleanup
endscript

script goal_horse_mp_activate
    // make the time look cool
;    SetScreenElementProps {
;		id=the_time
;		alpha=1
;	}
	RunScriptOnScreenElement id=the_time clock_morph
	;ScreenElementSystemCleanup
    //goal_start goal_id=<goal_id>
	ResetScore
endscript

script goal_horse_mp_deactivate
	;horse_end_run
	if ObjectExists id=horse_score_menu
		DestroyScreenElement id=horse_score_menu
	endif
	printf "DEACTIVATE HORSE"
endscript

script horse_mp_done
	dialog_box_exit
	do_backend_retry
    
endscript
							  
script goal_horse_mp_expire
	printf "EXPIRE HORSE"
	if ObjectExists id=goal_message
		DestroyScreenElement id=goal_message
	endif
	printf "goal_horse_mp_expire"
	;create_rankings score_title_text="RESULTS"
endscript

script AddGoal_Horse_Mp
    GoalManager_AddGoal name=horse_mp {
        params={ goal_horse_mp_genericParams }
    }
endscript

script StartGoal_Horse_Mp
	
    GoalManager_EditGoal name=horse_mp params = <...>
	GoalManager_ActivateGoal name=horse_mp
	create_horse_score_menu
endscript

script EndGoal_Horse_Mp
	GoalManager_DeactivateGoal name=horse_mp
	;DestroyScreenElement id=horse_score_menu
endscript

script create_horse_score_menu
	if Not ObjectExists id=horse_score_menu
		SetScreenElementLock id=root_window off 
		
		CreateScreenElement {
			type=ContainerElement 
			parent=root_window
			id=horse_score_menu
			
			font=dialog
			pos=(0, 30)
			just=[left top] 
			scale=0
			dims=(640, 480)
			//focusable_child=horse_score_vmenu
		}
		
		CreateScreenElement {
			type=VMenu
			parent=horse_score_menu
			id=horse_score_vmenu
			
			font=dialog
			just=[left top]
			pos=(45, 60)
			scale=.9
			padding_scale=.7
			internal_scale=1
			internal_just=[left top]
		}
        
            /*CreateScreenElement {
		    type=SpriteElement
		    parent=horse_score_menu
            id=horse_score_sidebar1
		    
		    texture=black
		    scale=(1, 17)
		    pos=(37, 39)
		    just=[left top]
		    rgba=[0 0 0 60]
	}*/
      
         /*CreateScreenElement {
		    type=SpriteElement
		    parent=horse_score_menu
            id=horse_blackbar1
		    
		    texture=options_bg
		    scale=(1.0, .5)
		    pos=(34, 57)
		    just=[left top]
		    rgba=[0 0 0 40]
            z_priority=-20
	}
    
           CreateScreenElement {
		    type=SpriteElement
		    parent=horse_score_menu
            id=horse_blackbar2
		    
		    texture=options_bg
		    scale=(1.0, .5)
		    pos=(34, 73)
		    just=[left top]
		    rgba=[0 0 0 40]
            z_priority=-20
	}
    
            CreateScreenElement {
		    type=SpriteElement
		    parent=horse_score_menu
            id=horse_scorebar1
		    
		    texture=black
		    scale=(57, 5)
		    pos=(38, 88)
		    just=[left top]
		    rgba=[127 102 0 10]
            z_priority=-20
	}*/
     
    


		<index> = 1
		begin
			FormatText ChecksumName=current_id "horse_score_%i" i=<index>
			CreateScreenElement {
				type=TextElement
				parent=horse_score_vmenu
				id=<current_id>
				font=dialog
				text=""
				scale=.9
				rgba=[108 112 120 128]            
				not_focusable
				z_priority=-5
			}
			<index> = ( <index> + 1 )
		repeat 3
		
		RunScriptOnScreenElement id=horse_score_menu menu_onscreen params={preserve_menu_state}
	endif
endscript

script update_horse_score
	if ObjectExists id=horse_score_menu
		SetScreenElementProps {
			id=<id>
			text=<text>
			}
	endif
endscript
