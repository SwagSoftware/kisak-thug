// car physics

accelCarRot = -1.0
decelCarRot = 3.0
speedCarRot = 0.125
accelCarRotFactor = 5.0

// use the car after you beat the car goal!

driving_parked_car=0

// @script | SetupDrivableCar | Sets up a car to be the trigger object for driving.
// @parm name | Id | NJ_Car_01 | The id of the object to act as the "goal ped" for the driving.
// @parm name | control_type | RallyCar | The name of the driving control type..
// @parm name | restart_node | NJ_Restart_01 | The name of the restart node the drivable car should start at.
// @parm name | exit_node | NJ_Restart_02 | The name of the restart node at which the skater should be placed after exiting the car.
script SetupDrivableCar
	// You can't drive parked cars when you enter a level in CAG mode.
	if GameModeEquals is_creategoals
		return
	endif
	
	RunScriptOnObject car_set_exceptions Id=<Id> Params={ <...>	}
endscript

script car_set_exceptions trigger_radius=16
	if ObjectExists id=goal_start_dialog
		speech_box_exit anchor_id=goal_start_dialog
	endif
	
	SetTags control_type=<control_type> restart_node=<restart_node> exit_node=<exit_node> destroy_car=<destroy_car> 
	
	ClearException SkaterOutOfRadius
    Obj_SetInnerRadius <trigger_radius>
    SetException ex=SkaterInRadius scr=car_inner_radius_handler
	Block
endscript

script car_inner_radius_handler
	GetSkaterId
	<skaterId> = <objId>
	
	Obj_GetId
	
    // K: This is to prevent the speech box appearing whilst in park editor edit mode.
    if CustomParkMode editing
        return
    endif    

	if ObjectExists id=goal_start_dialog
		// check if we should destroy it (the should_destroy param is used in case
		// we want to easily add more conditions later).
		<should_destroy> = 0
		;if not Skater:OnGround
		;	<should_destroy> = 1
		;endif
		if <SkaterId>:IsInBail
			<should_destroy> = 1
		endif
		
		if SkaterCurrentScorePotGreaterThan 0
			<should_destroy> = 1
		endif
		
		if not GoalManager_CanStartGoal
			<should_destroy> = 1
		endif
		
		if (in_cat_preview_mode = 1)
			<should_destroy> = 1
		endif
		
		if ( <should_destroy> = 1 )
			DestroyScreenElement id=goal_start_dialog
		endif
	else
		// bail out if the pause menu is up
		if ObjectExists id=root_window
			root_window:GetTags
			if GotParam menu_state
				if ( <menu_state> = on )
					return
				endif
			endif
		endif
		
		if (in_cat_preview_mode = 0)
			if GoalManager_CanStartGoal
				<skater_ready_for_goal> = 0
				if not <SkaterId>:Driving
					if <SkaterId>:OnGround
						<skater_ready_for_goal> = 1
					else
						if <SkaterId>:Walking
							<skater_ready_for_goal> = 1
						endif
					endif
				endif
				
				if ( <skater_ready_for_goal> = 1 )
					if not <SkaterId>:IsInBail
						if not SkaterCurrentScorePotGreaterThan 0
							<ObjId>:Obj_SetOuterRadius 20
							<ObjId>:SetException ex=SkaterOutOfRadius scr=car_refuse
							
							FormatText TextName=accept_text "Press \m5 to drive."
							create_speech_box {
								anchor_id=goal_start_dialog
								text=<accept_text>
								no_pad_choose
								no_pad_start
								pad_circle_script=car_accept
								pad_circle_params={ ObjId=<ObjId> }
								pad_square_script=<pad_square_script>
								pad_square_params=<pad_square_params>
								bg_rgba=[100 100 100 128]
								text_rgba=[128 128 128 128]
								font=small
								z_priority=5
							}
						endif
					endif
				endif
			endif
		endif
	endif
endscript

script car_refuse anchor_id=goal_start_dialog
	ClearException SkaterOutOfRadius
	speech_box_exit anchor_id=<anchor_id>
endscript

script car_accept anchor_id=goal_start_dialog
	ClearException SkaterInRadius
	speech_box_exit anchor_id=goal_start_dialog
	
	<ObjId>:car_begin_driving_run
endscript

script car_begin_driving_run
	if not GameModeEquals is_singlesession
		GoalManager_DeactivateAllGoals
	endif
	
	Obj_GetId
	
	// call the level's driving setup script checksum
	GoalManager_GetLevelPrefix
	FormatText ChecksumName=ReadyLevelScript "%l_KillVehicles" l=<level_prefix>
	if ScriptExists <ReadyLevelScript>
		<ReadyLevelScript> CalledByParkedCar ParkedCar=<ObjId>
	endif                                                              

    GetTags
	goal_initialize_skater control_type=<control_type> restart_node=<restart_node> Exitable
	
	if GotParam destroy_car
		kill name=<destroy_car>
	endif
	
	Change driving_parked_car=1
	
	SpawnScript car_wait_for_exit_request
	PlayerVehicle:SetTags ParkedCarId=<ObjId> ExitNode=<exit_node> DestroyCar=<destroy_car>
	
	if PlayerVehicle:Vehicle_HandbrakeActive
		create_panel_block id=current_goal text="\b3 = Accelerate\n\b1 = Brake/Reverse\n\b0 = Ditch" style=panel_message_goal
	else
		create_panel_block id=current_goal text="\b3 = Accelerate\n\b1 = Brake/Reverse\n\bf = Handbrake\n\b0 = Ditch" style=panel_message_goal
	endif
	
	Die
endscript

script car_wait_for_exit_request
	Wait 0.5 Seconds
	WaitForEvent Type=ExitVehicleRequest
	Goto handle_exit_vehicle_request
endscript

script handle_exit_vehicle_request
	PlayerVehicle:GetTags

	car_end_driving_run

	ResetSkaters node_name=<ExitNode>
	MakeSkaterGoto HandBrake
endscript

script car_end_driving_run
	// car_end_driving_run can be called from places besides car_wait_for_exit_request
	KillSpawnedScript Name=car_wait_for_exit_request

	if ObjectExists id=current_goal
		DestroyScreenElement id=current_goal
	endif
	
	PlayerVehicle:GetTags

	// call the level's driving shutdown script checksum
	GoalManager_GetLevelPrefix
	FormatText ChecksumName=RestoreLevelScript "%l_CreateVehicles" l=<level_prefix>
	if ScriptExists <RestoreLevelScript>
		<RestoreLevelScript> CalledByParkedCar ParkedCar=<ParkedCarId>
	endif
	
	Create Name=<ParkedCarId>
	
	if GotParam DestroyCar
		if NOT IsAlive name=<DestroyCar>
			create name=<DestroyCar>
		endif
	endif
	
	Change driving_parked_car=0
endscript
