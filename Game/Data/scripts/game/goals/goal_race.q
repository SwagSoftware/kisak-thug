// start autoduck documentation
// @DOC goal_race
// @module goal_race | None
// @subindex Scripting Database
// @index script | goal_race

Goal_Race_GenericParams = {
	race

	goal_text = "generic race text"
	view_goals_text = "Race goal"
	time = 120

	init = goal_race_init
	uninit = goal_uninit
	activate = goal_race_activate
	active = goal_race_active
	deactivate = goal_race_deactivate
	expire = goal_race_expire
	success = goal_race_success
	fail = goal_race_fail

	trigger_obj_id = TRG_G_RACE_Pro

	start_pad_id = G_RACE_StartPad

	restart_node = TRG_G_RACE_RestartNode

	goal_flags = [ got_1
		got_2
		got_3
		got_4
	]

	race_waypoints = [ { id=TRG_G_RACE_RaceNav01 scr=sch_race_waypoint_1 flag=got_1 }
		{ id=TRG_G_RACE_RaceNav02 scr=sch_race_waypoint_2 flag=got_2 }
		{ id=TRG_G_RACE_RaceNav03 scr=sch_race_waypoint_3 flag=got_3 }
		{ id=TRG_G_RACE_RaceNav04 scr=sch_race_waypoint_4 flag=got_4 }
	]

	record_type = score
}

Goal_Race2_GenericParams = {
	race

	goal_text = "generic race2 text"
	view_goals_text = "Race2 goal"
	time = 120

	init = goal_race_init
	uninit = goal_uninit
	activate = goal_race_activate
	active = goal_race_active
	deactivate = goal_race_deactivate
	expire = goal_race_expire
	success = goal_race_success
	fail = goal_race_fail

	trigger_obj_id = TRG_G_RACE2_Pro

	start_pad_id = G_RACE2_StartPad

	restart_node = TRG_G_RACE2_RestartNode

	goal_flags = [ got_1
		got_2
		got_3
		got_4
	]

	race_waypoints = [ { id=TRG_G_RACE2_RaceNav01 scr=sch_race2_waypoint_1 flag=got_1 }
		{ id=TRG_G_RACE2_RaceNav02 scr=sch_race2_waypoint_2 flag=got_2 }
		{ id=TRG_G_RACE2_RaceNav03 scr=sch_race2_waypoint_3 flag=got_3 }
		{ id=TRG_G_RACE2_RaceNav04 scr=sch_race2_waypoint_4 flag=got_4 }
	]

	record_type = score
}

Goal_Race3_GenericParams = {
	race

	goal_text = "generic race3 text"
	view_goals_text = "Race3 goal"
	time = 120

	init = goal_race_init
	uninit = goal_uninit
	activate = goal_race_activate
	active = goal_race_active
	deactivate = goal_race_deactivate
	expire = goal_race_expire
	success = goal_race_success
	fail = goal_race_fail

	trigger_obj_id = TRG_G_RACE3_Pro

	start_pad_id = G_RACE3_StartPad

	restart_node = TRG_G_RACE3_RestartNode

	goal_flags = [ got_1
		got_2
		got_3
		got_4
	]

	race_waypoints = [ { id=TRG_G_RACE3_RaceNav01 scr=sch_race3_waypoint_1 flag=got_1 }
		{ id=TRG_G_RACE3_RaceNav02 scr=sch_race3_waypoint_2 flag=got_2 }
		{ id=TRG_G_RACE3_RaceNav03 scr=sch_race3_waypoint_3 flag=got_3 }
		{ id=TRG_G_RACE3_RaceNav04 scr=sch_race3_waypoint_4 flag=got_4 }
	]
	record_type = score
}

Goal_Race4_GenericParams = {
	race

	goal_text = "generic race4 text"
	view_goals_text = "Race4 goal"
	time = 120

	init = goal_race_init
	uninit = goal_uninit
	activate = goal_race_activate
	active = goal_race_active
	deactivate = goal_race_deactivate
	expire = goal_race_expire
	success = goal_race_success
	fail = goal_race_fail

	trigger_obj_id = TRG_G_RACE4_Pro

	start_pad_id = G_RACE4_StartPad

	restart_node = TRG_G_RACE4_RestartNode

	goal_flags = [ got_1
		got_2
		got_3
		got_4
	]

	race_waypoints = [ { id=TRG_G_RACE4_RaceNav01 scr=sch_race4_waypoint_1 flag=got_1 }
		{ id=TRG_G_RACE4_RaceNav02 scr=sch_race4_waypoint_2 flag=got_2 }
		{ id=TRG_G_RACE4_RaceNav03 scr=sch_race4_waypoint_3 flag=got_3 }
		{ id=TRG_G_RACE4_RaceNav04 scr=sch_race4_waypoint_4 flag=got_4 }
	]

	record_type = score
}

Goal_Race5_GenericParams = {
	race

	goal_text = "generic Race5 text"
	view_goals_text = "Race5 goal"
	time = 120

	init = goal_race_init
	uninit = goal_uninit
	activate = goal_race_activate
	active = goal_race_active
	deactivate = goal_race_deactivate
	expire = goal_race_expire
	success = goal_race_success
	fail = goal_race_fail

	trigger_obj_id = TRG_G_Race5_Pro

	start_pad_id = G_Race5_StartPad

	restart_node = TRG_G_Race5_RestartNode

	goal_flags = [ got_1
		got_2
		got_3
		got_4
	]

	race_waypoints = [ { id=TRG_G_Race5_RaceNav01 scr=sch_Race5_waypoint_1 flag=got_1 }
		{ id=TRG_G_Race5_RaceNav02 scr=sch_Race5_waypoint_2 flag=got_2 }
		{ id=TRG_G_Race5_RaceNav03 scr=sch_Race5_waypoint_3 flag=got_3 }
		{ id=TRG_G_Race5_RaceNav04 scr=sch_Race5_waypoint_4 flag=got_4 }
	]

	record_type = score
}

Goal_Race6_GenericParams = {
	race

	goal_text = "generic Race6 text"
	view_goals_text = "Race6 goal"
	time = 120

	init = goal_race_init
	uninit = goal_uninit
	activate = goal_race_activate
	active = goal_race_active
	deactivate = goal_race_deactivate
	expire = goal_race_expire
	success = goal_race_success
	fail = goal_race_fail

	trigger_obj_id = TRG_G_Race6_Pro

	start_pad_id = G_Race6_StartPad

	restart_node = TRG_G_Race6_RestartNode

	goal_flags = [ got_1
		got_2
		got_3
		got_4
	]

	race_waypoints = [ { id=TRG_G_Race6_RaceNav01 scr=sch_Race6_waypoint_1 flag=got_1 }
		{ id=TRG_G_Race6_RaceNav02 scr=sch_Race6_waypoint_2 flag=got_2 }
		{ id=TRG_G_Race6_RaceNav03 scr=sch_Race6_waypoint_3 flag=got_3 }
		{ id=TRG_G_Race6_RaceNav04 scr=sch_Race6_waypoint_4 flag=got_4 }
	]

	record_type = score
}


script goal_race_init
	// nasty hack to get the arrow to appear once the race starts,
	// rather than when the goal starts

	; GoalManager_InitGoalTrigger name=<goal_id>
	goal_init goal_id=<goal_id>

	ForEachIn <race_waypoints> do=goal_race_create_waypoint
endscript

script goal_race_create_waypoint
	/*	if GotParam id
		create name=<id>
		<id>:Obj_Invisible
	endif
	if GotParam prefix
		create prefix=<prefix>
		Invisible prefix=<prefix>
	endif
*/
endscript

script goal_race_clear_exceptions
	// <id>:Obj_Invisible
	if GotParam id
		<id>:Obj_ClearExceptions
	endif
endscript

script goal_race_activate
	goal_start goal_id=<goal_id>

	; GoalManager_DisableEndOfRun name=<goal_id>

	// create first waypoint
	GoalManager_NextRaceWaypoint name=<goal_id>
endscript

script goal_race_active
	if GoalManager_AllFlagsSet name=<goal_id>
		GoalManager_WinGoal name=<goal_id>
	endif
endscript

script goal_race_success
	goal_success goal_id=<goal_id>
	//    GoalManager_RemoveGoal name=<goal_id>
endscript

script goal_race_deactivate
	KillSpawnedScript name=goal_race_next_waypoint
	GoalManager_ResetGoalTrigger name=<goal_id>
	goal_deactivate goal_id=<goal_id>
	if ObjectExists id=race_arrow
		DestroyScreenElement id=race_arrow
	endif

	// ForEachIn <race_waypoints> do=goal_race_clear_exceptions
endscript

script goal_race_expire
	goal_expire goal_id=<goal_id>
	GoalManager_LoseGoal name=<goal_id>
endscript

script goal_race_fail
	goal_fail goal_id=<goal_id>
endscript

// ***************************************
//      Helper scripts
// ***************************************
script goal_race_next_waypoint
	; printf "goal_race_next_waypoint"
	// whoa there...
	wait 1 gameframe
	GoalManager_GetGoalParams name=<goal_id>

	GetSkaterId
	if GotParam id
		RunScriptOnObject id=<id> goal_race_init_waypoint params={ radius=<radius> flag=<flag> goal_id=<goal_id> }
	endif
	if ObjectExists id=race_arrow
		SetScreenElementProps {
			id=race_arrow
			NodeToPointTo=<id>
		}
	else
		if GotParam first_waypoint
			if not GotParam quick_start
				WaitForEvent type=goal_cam_anim_post_start_done
			endif
			if not GoalManager_GoalIsActive name=<goal_id>
				return
			endif
		endif

		Create3dArrowPointer {
			id=race_arrow
			node=<id>
			model="HUD_arrow"
			pos=(320, 70)
			scale=0.025
			Tilt=7
		}
	endif

	/*	if GotParam first_waypoint
		// wait for the speech box to go away (special case for first spot)
		begin
			if SkaterCamAnimFinished skaterId=<ObjId> name=<start_cam_anim>
				; printf "the cam anim is finished"
				break
			endif
			wait 1 frame
		repeat
	endif
*/
	/*	begin
		wait 1 frame
		If ObjectExists id=current_goal
			DestroyScreenElement id=current_goal
			break
		else
			break
		endif
	repeat
	wait 1 frame
*/
	; printstruct <...>
	if GotParam scr
		SpawnScript <scr> params={ <params> }
	endif
endscript

script goal_race_init_waypoint
	; printf "goal_race_init_waypoint"
	Obj_ClearExceptions
	if not GotParam radius
		<radius> = 16
	endif
	Obj_SetInnerRadius <radius>
	// Obj_Visible
	Obj_SetException ex=SkaterInRadius scr=goal_race_got_waypoint params={ flag=<flag> goal_id=<goal_id> }
endscript

script goal_race_got_waypoint
	Obj_ClearExceptions
	// Obj_Invisible
	GoalManager_SetGoalFlag name=<goal_id> <flag> 1
	GoalManager_NextRaceWaypoint name=<goal_id>
endscript

/*
script goal_race_text_update
	SetProps just=[center bottom] rgba=[128 128 128 128]
	DoMorph pos=(320,214) time=0
	DoMorph pos=(320,214) scale=0 time=.05
	DoMorph pos=(320,214) scale=1 time=.2
	DoMorph pos=(320,214) scale=1.1 time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1

	DoMorph pos=(320,214) scale=1.45 time=.1
	DoMorph pos=(320,214) scale=1.46 time=.1

	SetProps internal_just=[center top] dims=(450,55) rgba=[128 128 128 110] just=[right top]

	DoMorph pos=(680, 180) just=[right top] scale=.85 time=.1

	begin
		DoMorph alpha=0
		wait <blink_time> seconds
		DoMorph alpha=1
		wait <blink_time> seconds
	repeat 5
endscript
*/
