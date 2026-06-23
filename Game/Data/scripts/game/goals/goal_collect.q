// start autoduck documentation
// @DOC goal_collect
// @module goal_collect | None
// @subindex Scripting Database
// @index script | goal_collect

// Collect/destroy/whatever x number of things

Goal_Collect_GenericParams= {
	goal_text = "Collect x things!"
	view_goals_text = "Generic collect text"
	goal_description = "Generic collect goal description"

	time = 120

	// script to run when goal is initialized
	init = goal_collect_init

	uninit = goal_uninit

	// this is run once each frame while the goal is active
	// it's used to check for completion of the goal
	active = goal_collect_active

	// runs when the goal is activated...creates geo, etc.
	activate = goal_collect_activate

	// when the goal is deactivated...
	deactivate = goal_collect_deactivate

	// when you run out of time - by default this will
	// also call the fail script
	expire = goal_collect_expire

	// scripts to run if you win or lose
	fail = goal_collect_fail
	success = goal_collect_success

	// name of the restart node...required for
	// "Retry Last Goal" menu item to work
	restart_node = TRG_G_COLLECT_RestartNode

	// This is the object that triggers the goal.
	// if no trigger object is specified, the goal
	// will be automatically activated, creating all the
	// geometry for the goal.  No indication that the goal
	// has started will be given.
	// Note that it's safe to use one of the goal objects
	// as the trigger; the goal won't try to create the
	// geometry twice.
	trigger_obj_id = TRG_G_COLLECT_Pro


	// you can specify a different object init script
	// this is for changing the exception of the object
	// The default is to set a SkaterInRadius exception
	// The script is run on each object when the goal is
	// activated, not when it is created
	goal_collect_object_init_script = set_goal_collect_exception


	// set up the goal flags...when all flags are set
	// the goal is won
	goal_flags=[
		got_1
		got_2
		got_3
		got_4
		got_5
	]

	// Each structure in the array contains the id
	// of the objects you have to hit, along with the
	// script to run on that object.  The flag is the name
	// of the flag to set when that object is collected.  Each
	// flag must be declared in the goal_flags array.
	// All objects will be created when the trigger is hit.
	// If the trigger is one of the objects, it's flag will be set but
	// ALL other steps (initializing, etc.) will be skipped.
	goal_collect_objects=[
		{ id=TRG_G_COLLECT_FratBoy01 scr=goal_collect_got_object flag=got_1 }
		{ id=TRG_G_COLLECT_FratBoy02 scr=goal_collect_got_object flag=got_2 }
		{ id=TRG_G_COLLECT_FratBoy03 scr=goal_collect_got_object flag=got_3 }
		{ id=TRG_G_COLLECT_FratBoy04 scr=goal_collect_got_object flag=got_4 }
		{ id=TRG_G_COLLECT_FratBoy05 scr=goal_collect_got_object flag=got_5 }
	]

	// start pad...destroyed the first time you beat a goal
	start_pad_id = G_COLLECT_StartPad

	wait_and_win_started = 0
	record_type = time
}


Goal_Collect2_GenericParams= {
	goal_text = "Collect2 x things!"
	view_goals_text = "Generic collect2 text"

	time = 120

	init = goal_collect_init
	uninit = goal_uninit
	active = goal_collect_active
	activate = goal_collect_activate
	deactivate = goal_collect_deactivate
	expire = goal_collect_expire
	fail = goal_collect_fail
	success = goal_collect_success

	restart_node = TRG_G_COLLECT2_RestartNode

	trigger_obj_id = TRG_G_COLLECT2_Pro

	goal_collect_object_init_script = set_goal_collect_exception

	goal_flags=[
		got_1
		got_2
		got_3
		got_4
		got_5
	]

	goal_collect_objects=[
		{ id=TRG_G_COLLECT2_FratBoy01 scr=goal_collect_got_object flag=got_1 }
		{ id=TRG_G_COLLECT2_FratBoy02 scr=goal_collect_got_object flag=got_2 }
		{ id=TRG_G_COLLECT2_FratBoy03 scr=goal_collect_got_object flag=got_3 }
		{ id=TRG_G_COLLECT2_FratBoy04 scr=goal_collect_got_object flag=got_4 }
		{ id=TRG_G_COLLECT2_FratBoy05 scr=goal_collect_got_object flag=got_5 }
	]

	start_pad_id = G_COLLECT2_StartPad

	wait_and_win_started = 0
	record_type = time
}

Goal_Collect3_GenericParams= {
	goal_text = "Collect3 x things!"
	view_goals_text = "Generic Collect3 text"

	time = 120

	init = goal_collect_init
	uninit = goal_uninit
	active = goal_collect_active
	activate = goal_collect_activate
	deactivate = goal_collect_deactivate
	expire = goal_collect_expire
	fail = goal_collect_fail
	success = goal_collect_success

	restart_node = TRG_G_Collect3_RestartNode

	trigger_obj_id = TRG_G_Collect3_Pro

	goal_collect_object_init_script = set_goal_collect_exception

	goal_flags=[
		got_1
		got_2
		got_3
		got_4
		got_5
	]

	goal_collect_objects=[
		{ id=TRG_G_Collect3_FratBoy01 scr=goal_collect_got_object flag=got_1 }
		{ id=TRG_G_Collect3_FratBoy02 scr=goal_collect_got_object flag=got_2 }
		{ id=TRG_G_Collect3_FratBoy03 scr=goal_collect_got_object flag=got_3 }
		{ id=TRG_G_Collect3_FratBoy04 scr=goal_collect_got_object flag=got_4 }
		{ id=TRG_G_Collect3_FratBoy05 scr=goal_collect_got_object flag=got_5 }
	]

	start_pad_id = G_Collect3_StartPad

	wait_and_win_started = 0
	record_type = time
}


Goal_Collect4_GenericParams= {
	goal_text = "Collect4 x things!"
	view_goals_text = "Generic Collect4 text"

	time = 120

	init = goal_collect_init
	uninit = goal_uninit
	active = goal_collect_active
	activate = goal_collect_activate
	deactivate = goal_collect_deactivate
	expire = goal_collect_expire
	fail = goal_collect_fail
	success = goal_collect_success

	restart_node = TRG_G_Collect4_RestartNode

	trigger_obj_id = TRG_G_Collect4_Pro

	goal_collect_object_init_script = set_goal_collect_exception

	goal_flags=[
		got_1
		got_2
		got_3
		got_4
		got_5
	]

	goal_collect_objects=[
		{ id=TRG_G_Collect4_FratBoy01 scr=goal_collect_got_object flag=got_1 }
		{ id=TRG_G_Collect4_FratBoy02 scr=goal_collect_got_object flag=got_2 }
		{ id=TRG_G_Collect4_FratBoy03 scr=goal_collect_got_object flag=got_3 }
		{ id=TRG_G_Collect4_FratBoy04 scr=goal_collect_got_object flag=got_4 }
		{ id=TRG_G_Collect4_FratBoy05 scr=goal_collect_got_object flag=got_5 }
	]

	start_pad_id = G_Collect4_StartPad

	wait_and_win_started = 0
	record_type = time
}

Goal_Collect5_GenericParams= {
	goal_text = "Collect5 x things!"
	view_goals_text = "Generic Collect5 text"

	time = 120

	init = goal_collect_init
	uninit = goal_uninit
	active = goal_collect_active
	activate = goal_collect_activate
	deactivate = goal_collect_deactivate
	expire = goal_collect_expire
	fail = goal_collect_fail
	success = goal_collect_success

	restart_node = TRG_G_Collect5_RestartNode

	trigger_obj_id = TRG_G_Collect5_Pro

	goal_collect_object_init_script = set_goal_collect_exception

	goal_flags=[
		got_1
		got_2
		got_3
		got_4
		got_5
	]

	goal_collect_objects=[
		{ id=TRG_G_Collect5_FratBoy01 scr=goal_collect_got_object flag=got_1 }
		{ id=TRG_G_Collect5_FratBoy02 scr=goal_collect_got_object flag=got_2 }
		{ id=TRG_G_Collect5_FratBoy03 scr=goal_collect_got_object flag=got_3 }
		{ id=TRG_G_Collect5_FratBoy04 scr=goal_collect_got_object flag=got_4 }
		{ id=TRG_G_Collect5_FratBoy05 scr=goal_collect_got_object flag=got_5 }
	]

	start_pad_id = G_Collect5_StartPad

	wait_and_win_started = 0
	record_type = time
}

Goal_Collect6_GenericParams= {
	goal_text = "Collect6 x things!"
	view_goals_text = "Generic Collect6 text"

	time = 120

	init = goal_collect_init
	uninit = goal_uninit
	active = goal_collect_active
	activate = goal_collect_activate
	deactivate = goal_collect_deactivate
	expire = goal_collect_expire
	fail = goal_collect_fail
	success = goal_collect_success

	restart_node = TRG_G_Collect6_RestartNode

	trigger_obj_id = TRG_G_Collect6_Pro

	goal_collect_object_init_script = set_goal_collect_exception

	goal_flags=[
		got_1
		got_2
		got_3
		got_4
		got_5
	]

	goal_collect_objects=[
		{ id=TRG_G_Collect4_FratBoy01 scr=goal_collect_got_object flag=got_1 }
		{ id=TRG_G_Collect4_FratBoy02 scr=goal_collect_got_object flag=got_2 }
		{ id=TRG_G_Collect4_FratBoy03 scr=goal_collect_got_object flag=got_3 }
		{ id=TRG_G_Collect4_FratBoy04 scr=goal_collect_got_object flag=got_4 }
		{ id=TRG_G_Collect4_FratBoy05 scr=goal_collect_got_object flag=got_5 }
	]

	start_pad_id = G_Collect4_StartPad

	wait_and_win_started = 0
	record_type = time
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_init
	; GoalManager_InitGoalTrigger name=<goal_id>
	goal_init goal_id=<goal_id>

	; ForEachIn <goal_collect_objects> do=goal_collect_create_object
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_create_object
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

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script init_goal_collect_object
	if GotParam id
		// init goal object - ignore the trigger object
		if ChecksumEquals a=<trigger_obj_id> b=<id>
			// set the trigger's flag
			GoalManager_SetGoalFlag name=<goal_id> <flag> 1
		else
			// initialize geo
			<id>:Obj_Visible
			RunScriptOnObject id=<id> <goal_collect_object_init_script> params=<...>
		endif
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script set_goal_collect_exception goal_collect_object_inner_radius=6
	Obj_ClearExceptions
	Obj_SetInnerRadius <goal_collect_object_inner_radius>
	Obj_SetException ex=SkaterInRadius scr=<scr> params={goal_id=<goal_id> flag=<flag>}
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_got_object
	Obj_ClearExceptions
	PlaySound GapSound vol=100
	GoalManager_SetGoalFlag name=<goal_id> <flag> 1
	GoalManager_GetGoalParams name=<goal_id>

	if not GoalManager_AllFlagsSet name=<goal_id>
		FormatText TextName=collect_text "%c of %n %t" c=<num_flags_set> t=<collect_type> n=<num_flags>
		create_panel_message text=<collect_text> style=goal_collect_text
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_text
	SetProps rgba=[128 128 128 128] pos=(320, 140)
	wait 1000
	Die
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_activate
	goal_start goal_id=<goal_id>
	SpawnScript goal_collect_wait_and_initialize_objects params=<...>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_wait_and_initialize_objects
	if not GotParam quick_start
		WaitForEvent type=goal_cam_anim_post_start_done

		if not GoalManager_GoalIsActive name=<goal_id>
			return
		endif
	endif

	// initialize goal objects
	GetArraySize <goal_collect_objects>
	<index> = 0
	begin
		init_goal_collect_object {
			( <goal_collect_objects>[<index>] )
			goal_id=<goal_id>
			trigger_obj_id = <trigger_obj_id>
			goal_collect_object_init_script = <goal_collect_object_init_script>
		}

		if GotParam create_collect_arrows
			goal_collect_add_arrow {
				( <goal_collect_objects>[<index>] )
				goal_name=<goal_name>
				index=<index>
			}
		endif
		if GotParam create_evil_collect_arrows
			goal_collect_add_arrow {
				( <goal_collect_objects>[<index>] )
				goal_name=<goal_name>
				index=<index>
				arrow_model = "evilarrow"
			}
		endif
		<index> = ( <index> + 1 )
	repeat <array_size>

	; ForEachIn <goal_collect_objects> do=init_goal_collect_object params=<...>

	// do specific init scripts
	begin
		if GetNextArrayElement <goal_collect_objects>
			goal_collect_run_init_script <element>
		else
			break
		endif
	repeat
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_run_init_script
	if GotParam init_script
		<init_script> <...>
	endif
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_active
	if GoalManager_AllFlagsSet name=<goal_id>
		/*if GotParam win_wait_time
			if ( <wait_and_win_started> = 0 )
				; printf "waiting %i ms" i=<win_wait_time>
				GoalManager_EditGoal name=<goal_id> params={ wait_and_win_started = 1 }
				SpawnScript goal_collect_wait_and_win params={ goal_id=<goal_id> win_wait_time=<win_wait_time> }
			endif
		else*/
		GoalManager_WinGoal name=<goal_id>
		; endif
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_Wait_and_win
	wait <win_wait_time>
	GoalManager_WinGoal name=<goal_id>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_success
	goal_success goal_id=<goal_id>

	//    GoalManager_RemoveGoal name=<goal_id>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_deactivate
	KillSpawnedScript name=goal_collect_wait_and_initialize_objects
	GoalManager_EditGoal name=<goal_id> params={ wait_and_win_started = 0 }

	if GotParam trigger_obj_id
		GoalManager_ResetGoalTrigger name=<goal_id>
	endif
	goal_deactivate goal_id=<goal_id>

	// ForEachIn <goal_collect_objects> do=goal_collect_clear_exceptions
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_clear_exceptions
	if GotParam id
		<id>:Obj_ClearExceptions
	endif
	// <id>:Obj_Invisible
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_expire
	goal_expire goal_id=<goal_id>
	GoalManager_LoseGoal name=<goal_id>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_fail
	goal_fail goal_id=<goal_id>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_reset_objects
	GoalManager_ResetGoalFlags name=<goal_id>

	GoalManager_GetGoalParams name=<goal_id>

	// initialize goal objects
	GetArraySize <goal_collect_objects>
	<index> = 0
	begin
		init_goal_collect_object ( <goal_collect_objects>[<index>] ) <...>
		<index> = ( <index> + 1 )
	repeat <array_size>

	if GotParam use_hud_counter
		goal_update_counter <...>
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_collect_add_arrow
	if not IsAlive name=<id>
		return
	endif

	if not GotParam arrow_height
		<arrow_height> = 100
	endif

	<arrow_pos> = ( (0, 1, 0) * <arrow_height> )

	// figure the arrow model to use
	if not GotParam arrow_model
		<arrow_model> = "goalarrow"
	endif

	// build unique arrow_id based on goal_name and the index of this
	// object in the collect objects array
	FormatText ChecksumName=arrow_id "%g_%i_arrow" g=<goal_name> i=<index>

	// kill any old arrow
	if ScreenElementExists id=<arrow_id>
		DestroyScreenElement id=<arrow_id>
	endif

	// make the new arrow
	SetScreenElementLock id=root_window off
	CreateScreenElement {
		parent=root_window
		type=Element3D
		id=<arrow_id>

		model=<arrow_model>
		HoverParams={ Amp=9.5 Freq=2.5 }
		AngVelY=0.16
		ParentParams={ name=<id> <arrow_pos> IgnoreParentsYRotation }
	}
endscript
