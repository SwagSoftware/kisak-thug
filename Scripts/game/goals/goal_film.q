// film the skater!

Goal_Film_GenericParams = {
    goal_text = "Find X things!"
	view_goals_text = "Generic find things text"
    
    init = goal_film_init
	uninit = goal_uninit
    active = goal_film_active
    activate = goal_film_activate
    deactivate = goal_film_deactivate
    expire = goal_film_expire
    fail = goal_film_fail
    success = goal_film_success
    
    restart_node = TRG_G_FILM_RestartNode
    
    trigger_obj_id = TRG_G_FILM_Pro
    
	record_type = none
	
	time = 120
	max_distance_to_target = 120
	time_on_camera = 0
	
	Film
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_film_init
	goal_init goal_id=<goal_id>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_film_activate
	goal_start goal_id=<goal_id>

	// change camera angle and lock camera
	if GotParam virtual_cam_params
		GetSkaterId
		PlaySkaterCamAnim {
			name=goal_film_virtual_cam
			skaterId=<objId>
			targetID=<objId>
			targetOffset=( <virtual_cam_params>.targetOffset )
			positionOffset=( <virtual_cam_params>.positionOffset )
			play_hold
			frames=1
			skippable=0
			virtual_cam
			allow_pause=1
		}
	endif
	
    if GotParam total_time_required
		if GotParam quick_start
			GoalManager_StartFilming name=<goal_id>
			goal_film_add_arrow_and_timer goal_id=<goal_id>
		else
			SpawnScript goal_film_wait_and_start_filming params={ goal_id=<goal_id> }
		endif
	endif
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_film_wait_and_start_filming
	WaitForEvent type=goal_cam_anim_post_start_done
	if not GoalManager_GoalIsActive name=<goal_id>
		return
	endif
    GoalManager_StartFilming name=<goal_id>
	goal_film_add_arrow_and_timer goal_id=<goal_id>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_film_add_arrow_and_timer
	if ScreenElementExists id=DesignerCreated_3DArrowPointer
		DestroyScreenElement id=DesignerCreated_3DArrowPointer
	endif
	GoalManager_GetGoalParams name=<goal_id>
	
	show_cutscene_camera_hud for_goal
	
	Create3dArrowPointer {
		id=DesignerCreated_3DArrowPointer
		model="HUD_arrow"
		pos=(320, 70)
		scale=0.025
		Tilt=7
		name=<film_target>
	}
	
	if ScreenElementExists id=goal_film_update_message
		DestroyScreenElement id=goal_film_update_message
	endif
	SetScreenElementLock id=root_window off
	CreateScreenElement {
		parent=root_window
		type=TextElement
		font=small
		text="Time: 0"
		id=goal_film_update_message
		pos=(320, 240)
		just=[center center]
		z_priority=-1000
		alpha=0
	}
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_film_active
	FormatText TextName=text "Time: %i" i=<time_on_camera>
	if ScreenElementExists id=goal_film_update_message
		SetScreenElementProps {
			id=goal_film_update_message
			text=<text>
		}
	else
	endif
	
	if ( <time_on_camera> > <last_time_on_camera> )
        camera_hud_breakup_frames millisecs=<time_on_camera>
		if ScreenElementExists id=rec_anchor
			DoScreenElementMorph id=rec_anchor alpha=1
		endif
	else
		if ScreenElementExists id=rec_anchor
			DoScreenElementMorph id=rec_anchor alpha=0
		endif
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_film_deactivate
	// restore camera angle and control
	if GotParam virtual_cam_params
		KillSkaterCamAnim name=goal_film_virtual_cam
	endif
	
	if ScreenElementExists id=goal_film_update_message
		DestroyScreenElement id=goal_film_update_message
	endif
	
	if ScreenElementExists id=DesignerCreated_3DArrowPointer
		DestroyScreenElement id=DesignerCreated_3DArrowPointer
	endif
	
    kill_cutscene_camera_hud
	
	GoalManager_ResetGoalTrigger name=<goal_id>
	goal_deactivate goal_id=<goal_id>
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_film_expire
	goal_expire goal_id=<goal_id>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_film_fail
	goal_fail goal_id=<goal_id>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_film_bailed_skater
	// called when you make the skater you're filming bail
	GoalManager_LoseGoal name=<goal_id>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_film_success
	goal_success goal_id=<goal_id>
endscript
