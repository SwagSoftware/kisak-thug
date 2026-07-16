// ped skater stuff!

// Globals
ped_skater_min_square_distance_to_waypoint = 3
ped_skater_min_square_distance_to_skater = 144
ped_skater_min_square_distance_to_crouch_for_jump = 14400
ped_skater_fade_target_bias_max_distance_square = 7056
ped_skater_stick_dist_below = 24.0
ped_skater_stick_dist_above = 18.0
ped_skater_jump_col_dist_above = 12
ped_skater_jump_col_dist_below = 12
ped_skater_vert_jump_speed_slop = 1
ped_skater_bail_deceleration = 9
ped_skater_stop_deceleration = 10
ped_skater_min_180_spin_time = 0.3
ped_skater_vert_rotation_time_slop = 1.1
ped_skater_spine_rotation_slop = 60

// if the jump height is too small to jump to the next
// node, the skater will automatically jump the necessary
// distance plus this slop.  eg, if the skater is 60 inches
// below the next node, he'll jump 60 + slop to get there.
ped_skater_jump_to_next_node_height_slop = 12

ped_skater_jump_speed = 280
ped_skater_jump_gravity = -700

ped_skater_grind_anims = [
	{ InitAnim=Init_BSBoardslide Anim=BSBoardslide_range OutAnim=BSBoardslide_Out BailAnim=NutterFallForward  GetUpAnim=GetUpForwards }
	{ InitAnim=Init_FiftyFifty Anim=FiftyFifty_range BailAnim=FiftyFiftyFallForward GetUpAnim=GetUpFacing }
    { InitAnim=Init_FSCrooked Anim=FSCrooked_range BailAnim=FiftyFiftyFallForward GetUpAnim=GetUpFacing }
	{ InitAnim=Init_FSOvercrook Anim=FSOvercrook_range BailAnim=FiftyFiftyFallForward GetUpAnim=GetUpFacing }
	{ InitAnim=Init_FSSmith Anim=FSSmith_range BailAnim=NutterFallForward  GetUpAnim=GetUpForwards }
	{ InitAnim=Init_BSSmith Anim=BSSmith_range BailAnim=NutterFallForward  GetUpAnim=GetUpForwards }
	{ InitAnim=Init_FSFeeble Anim=FSFeeble_range BailAnim=NutterFallForward  GetUpAnim=GetUpForwards }
	{ InitAnim=Init_Nosegrind Anim=Nosegrind_range BailAnim=FiftyFiftyFallForward GetUpAnim=GetUpFacing }
	{ InitAnim=Init_Tailgrind Anim=Tailgrind_range BailAnim=FiftyFiftyFallForward GetUpAnim=GetUpFacing }
]

// these anims will play when the skater is stopped
ped_skater_brake_idle_anims = [
	NewBrakeIdle
	NewBrakeIdle
	NewBrakeIdle
	NewBrakeIdle
	NewBrakeIdle
	NewBrakeIdle
	NewBrakeIdle
	NewBrakeIdle2
	NewBrakeIdle3
	NewBrakeIdle4
	NewBrakeIdle5
	NewBrakeIdle6
	NewBrakeIdle7
	NewBrakeIdle8
]

// list of all scripts that should be killed when a new action starts
ped_skater_action_scripts = [
	ped_skater_idle
	ped_skater_grind
	ped_skater_grind_off
	ped_skater_grab_trick
	ped_skater_lip_trick
	ped_skater_land
	ped_skater_manual
	ped_skater_manual_down
	ped_skater_jump
	ped_skater_vert_jump
	ped_skater_roll_off
	ped_skater_crouch_for_jump
	ped_skater_flip_trick
	ped_skater_wait_and_stop_grab_anim
	ped_skater_stop
]


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_crouch_for_jump
	Obj_PlayAnim anim=Crouch
	Obj_WaitAnimFinished anim=CrouchIdle cycle
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_jump
	// turn off shadow
	Obj_ShadowOff
	
	if not GotParam jumpSpeed
		<jumpSpeed> = ped_skater_jump_speed
	endif
	
	Ped_PlayJumpSound
	if GotParam land_height
		Obj_Jump { speed=<jumpSpeed>
				   gravity=ped_skater_jump_gravity
				   heading=<heading>
				   land_height=<land_height>
				 }
	else
		Obj_Jump speed=<jumpSpeed> gravity=ped_skater_jump_gravity
	endif
	Obj_SpawnScript ped_skater_play_midair_anim params={ anim=Ollie }
	; Obj_PlayAnim anim=Ollie
	; Obj_WaitAnimFinished
	; Obj_PlayAnim anim=AirIdle cycle
	Obj_WaitJumpFinished
	Obj_GetID
	TerminateObjectsScripts id=<objId> script_name=ped_skater_play_midair_anim use_proper_version
	Ped_PlayLandSound
	
	if GotParam land_height
		if GotParam should_land
			ped_skater_land
		endif
		Ped_StartMoving
		
		// force the ped to hit the waypoint
		// Depending on the action at this node, it could kill
		// this script.
		Ped_HitWaypoint		
	else
		ped_skater_land
	endif	
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_vert_jump
	// turn off shadow
	Obj_ShadowOff
	
	Ped_StopMoving
	
	if not GotParam jumpSpeed
		<jumpSpeed> = ped_skater_jump_speed
	endif
	
	Obj_PlayAnim anim=Ollie
	Ped_PlayJumpSound
	Obj_Jump heading=<heading> speed=( <jumpSpeed> * ped_skater_vert_jump_speed_slop ) gravity=ped_skater_jump_gravity
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=AirIdle cycle
	Obj_WaitJumpFinished
	Ped_PlayLandSound
	
	// should we flip?
	if GotParam should_flip
		Obj_Flip
	endif
	
	Ped_StartMoving
	ped_skater_land anim=CrouchedLandTurn
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_roll_off
	// turn off shadow
	Obj_ShadowOff
	
	Ped_GetCurrentVelocity
	Ped_StopMoving
	Obj_Jump use_current_heading speed=<velocity> gravity=ped_skater_jump_gravity
	Obj_WaitJumpFinished
	Ped_PlayLandSound

	Ped_StartMoving
	ped_skater_land small
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_grind
	// turn off shadow
	Obj_ShadowOff
	
	if not GotParam range_anim
		GetRandomArrayElement ped_skater_grind_anims
		// { InitAnim=Init_BSBoardslide Anim=BSBoardslide_range OutAnim=BSBoardslide_Out BailAnim=Nutter }
		<range_anim> = ( <element>.anim )
		<init_anim> = ( <element>.InitAnim )
		<bail_anim> = ( <element>.BailAnim )
		<get_up_anim> = ( <element>.GetUpAnim )
		if StructureContains structure=<element>  OutAnim		
			<out_anim> = ( <element>.OutAnim )
		endif
	endif
	SetTags {
		grind_init_anim = <init_anim>
		grind_range_anim = <range_anim>
		grind_out_anim = <out_anim>
		grind_bail_anim = <bail_anim>
		grind_get_up_anim = <get_up_anim>
	}
	
	Obj_PlayAnim anim=<init_anim>
	Obj_WaitAnimFinished
	; Obj_PlayAnim anim=<range_anim> wobble autoWobble autoWobbleIncremenet=0.1
	; Ped_GetAnimLength anim=<range_anim>
	<wobble_to> = Random( @Start @End )
	Obj_PlayAnim Anim=<range_anim> PingPong From=Current To=<wobble_to> Speed=.9 BlendPeriod=0.1
	; Ped_StartWobble
	; Obj_WaitAnimFinished
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_grind_off
	GetTags
	
	Obj_EnableAnimBlending enabled=1
	
	// play out anim
	if GotParam grind_out_anim
		Obj_PlayAnim anim=<grind_out_anim>
	else
		Obj_PlayAnim anim=<grind_init_anim> backwards
	endif
	ped_skater_roll_off <...>
	; Obj_WaitAnimFinished
	; Obj_PlayAnim anim=CrouchBumpDown
	; Obj_WaitAnimFinished
	; Obj_PlayAnim anim=Idle BlendPeriod=0.3
	; Obj_PlayAnim anim=Crouch
	; Obj_PlayAnim anim=PushCycle cycle
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_grab_trick
	// turn off shadow
	Obj_ShadowOff
	
	if not GotParam jumpSpeed
		<jumpSpeed> = ped_skater_jump_speed
	endif
	
	if GotParam is_vert
		Ped_StopMoving
	endif
	
	// TODO: assert if params aren't present
	if not GotParam anim
		GetConfigurableTricksFromType type=GrabTrick
		GetRandomArrayElement <ConfigurableTricks>
		<trick_params> = ( <Element>.Params )
		<anim> = ( <trick_params>.Anim )
		<idle_anim> = ( <trick_params>.Idle )
		if StructureContains structure=<trick_params> OutAnim
			<out_anim> = ( <trick_params>.OutAnim )
		endif			
	endif
	
	// jump
	Ped_PlayJumpSound
	if GotParam is_vert
		Obj_Jump heading=<heading> speed=<jumpSpeed> gravity=ped_skater_jump_gravity
	else
		if ( <is_jumping> = 0 )
			Obj_Jump speed=<jumpSpeed> gravity=ped_skater_jump_gravity
		endif
	endif
	
	Obj_PlayAnim anim=<anim>
	Obj_SpawnScript ped_skater_wait_and_stop_grab_anim params=<...>
	; Obj_Rotate rotate_display relative=(0, 180, 0) time=<jumpTime>
	Obj_WaitJumpFinished
	Ped_PlayLandSound
	Obj_GetId
	TerminateObjectsScripts use_proper_version id=<objId> script_name=ped_skater_wait_and_stop_grab_anim
	
	if GotParam is_vert
		// should we flip?
		if GotParam should_flip
			Obj_Flip
		endif

		Ped_StartMoving
		<land_anim> = CrouchedLandTurn
	else
		<land_anim> = Land
	endif
	ped_skater_land anim=<land_anim>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_wait_and_stop_grab_anim
	if GotParam jumpTime
		wait ( <jumpTime> * .5 ) seconds
		; printf "anim = %s" s=<anim>
		if GotParam out_anim
			Obj_PlayAnim anim=<out_anim>
			Obj_WaitAnimFinished
		else
			Obj_PlayAnim anim=<anim> backwards
			Obj_WaitAnimFinished
		endif
		Obj_PlayAnim anim=AirIdle cycle
	endif
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_stop
	Ped_StoreMaxVelocity
	
	if not GotParam deceleration
		<deceleration> = ped_skater_stop_deceleration
	endif
	
	Obj_SetPathDeceleration <deceleration>
	Obj_SetPathVelocity	0
	; Obj_PlayAnim anim=brake
	; Obj_WaitAnimFinished
	begin
		Ped_GetCurrentVelocity
		if ( <velocity> = 0 )
			Ped_StopMoving
			break
		endif
		wait 1 frame
	repeat
	
	// get off board
	Obj_PlayAnim anim=NewBrake
	Obj_WaitAnimFinished
	
	if GotParam RandomStopTime
		<StopTime> = RandomRange( 1, 30 )
	endif
	
	if GotParam StopTime
		if ( <StopTime> > 0 )
			Obj_SpawnScript ped_skater_wait_and_start_moving params={ StopTime=<StopTime> }
		endif
	endif
	
	// play idle animations
	GetTags
	begin
		GetRandomArrayElement <brake_idle_anims>
		Obj_PlayAnim anim=<element>
		Obj_WaitAnimFinished
	repeat
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_wait_and_start_moving
	wait <StopTime> seconds
	
	// kill the stop script and wait for the anim to finish
	Obj_GetId
	TerminateObjectsScripts use_proper_version id=<objId> script_name=ped_skater_stop
	Obj_WaitAnimFinished

	Ped_StartMoving
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// IMPORTANT: This should not be called directly.  Use the Ped_StartMoving
// member function instead
script ped_skater_start_moving
	Ped_GetOriginalMaxVelocity
	GetTags
	if GotParam ped_skater_acceleration
		Obj_SetPathAcceleration <ped_skater_acceleration>
	endif
	Obj_SetPathVelocity <original_max_velocity> ips
	
	Obj_PlayAnim anim=NewBrakeIdleToIdle
	Obj_WaitAnimFinished
	ped_skater_idle
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_manual
	// turn shadow on
	Obj_ShadowOn
	
	switch <ManualType>
		case Manual
			SetTags manual_out_anim=PutDownManual
			init_anim=Manual
			range_anim=Manual_range
		case Handstand
			SetTags manual_out_anim=RustySlide_Out
			init_anim=RustySlide_Init
			range_anim=Primo_Range
		default
			SetTags manual_out_anim=PutDownManual
			init_anim=Manual
			range_anim=Manual_range
	endswitch
	
	Obj_PlayAnim anim=<init_anim>
	Obj_WaitAnimFinished
	Obj_PlayAnim Anim=<range_anim> PingPong From=Start To=End Speed=1.1 BlendPeriod=0.1
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_manual_down
	// turn shadow on
	Obj_ShadowOn
	
	GetTags
	if not GotParam manual_out_anim
		<anim> = PutDownManual
	endif
	
	Obj_PlayAnim anim=<manual_out_anim>
	Obj_WaitAnimFinished
	ped_skater_idle
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_manual_bail
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_lip_trick
	// turn off shadow
	Obj_ShadowOff
	
	Ped_SetLogicState lip_trick
	Ped_StopMoving
	Obj_EnableAnimBlending enabled=1
	
	if not GotParam anim
		GetConfigurableTricksFromType type=LipMacro2
		GetRandomArrayElement <ConfigurableTricks>
		<trick_params> = ( <Element>.Params )
		<init_anim> = ( <trick_params>.InitAnim )
		<anim> = ( <trick_params>.Anim )
		<out_anim> = ( <trick_params>.OutAnim )
	endif
	
	Obj_PlayAnim anim=<init_anim>	
	Obj_WaitAnimFinished
	
	if not GotParam HoldLipTime
		<HoldLipTime> = RandomRange( 1, 3 )
	endif
	
	// play lip anim
	Obj_PlayAnim anim=<anim> PingPong from=current to=Start speed=.9
	Wait <HoldLipTime> seconds
	
	// play out anim	
	Obj_PlayAnim anim=<out_anim>
	if not StructureContains structure=<trick_params> FlipAfter
		Obj_Flip
	endif
	
	Obj_WaitAnimFinished
	Obj_EnableAnimBlending enabled=0
	
	Ped_StartMoving
	Ped_SetLogicState generic_skater
	ped_skater_land	
	; printf "ped_skater_lip_trick done"
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_flip_trick
	// turn off shadow
	Obj_ShadowOff
	
	if GotParam is_vert
		Ped_StopMoving
	endif
	
	if ( <is_jumping> = 0 )
		Obj_PlayAnim anim=Ollie
		if GotParam is_vert
			<jumpSpeed> = ( <jumpSpeed> * ped_skater_vert_jump_speed_slop )
		endif
		
		Ped_PlayJumpSound
		if GotParam land_height
			Obj_Jump { speed=<jumpSpeed>
					   gravity=ped_skater_jump_gravity
					   heading=<heading>
					   land_height=<land_height>
			}
		else
			Obj_Jump {
				speed=<jumpSpeed>
				heading=<heading>
				gravity=ped_skater_jump_gravity
			}
		endif

		; Obj_WaitAnimFinished
		wait 8 frame
	endif
	
	// pick a random trick
	if not GotParam anim
		GetConfigurableTricksFromType type=FlipTrick
		GetRandomArrayElement <ConfigurableTricks>
		<trick_params> = ( <Element>.Params )
		<anim> = ( <trick_params>.Anim )
	endif
	
	
	Obj_GetId
	Obj_SpawnScript ped_skater_play_midair_anim params={ anim=<anim> }
	; Obj_PlayAnim anim=<anim>
	; Obj_WaitAnimFinished
	; Obj_PlayAnim anim=AirIdle
	Obj_WaitJumpFinished
	TerminateObjectsScripts id=<objId> script_name=ped_skater_play_midair_anim use_proper_version
	Ped_PlayLandSound
	
	if GotParam is_vert
		Ped_StartMoving
		<land_anim> = CrouchedLandTurn
	else
		<land_anim> = Land
	endif
	
	if GotParam land_height
		Ped_StartMoving
		Obj_SpawnScript ped_skater_land anim=<land_anim>
		Ped_HitWaypoint
	else
		ped_skater_land anim=<land_anim>
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_play_midair_anim
	Obj_PlayAnim anim=<anim>
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=AirIdle cycle
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_land
	// turn on shadow
	Obj_ShadowOn
	
	if not GotParam anim
		<anim> = Land
	endif
	
	; Obj_EnableAnimBlending enabled=1
	
	Obj_PlayAnim anim=<anim> BlendPeriod=.3
	Obj_WaitAnimFinished
	ped_skater_idle
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_idle
	begin
		if Ped_NearVertNode
			<anim_struct> = Random( @*10{ anim=Idle } @{ init_anim=Crouch anim=CrouchIdle out_anim=CrouchIdleToIdle cycle=10 } )
		else
			<anim_struct> = Random( @*5{ anim=Idle } @*10{ anim=PushIdle } @{ init_anim=Crouch anim=CrouchIdle out_anim=CrouchIdleToIdle cycle=10 } )
		endif
		
		RemoveParameter init_anim
		RemoveParameter anim
		RemoveParameter cycle
		RemoveParameter out_anim
		if StructureContains structure=<anim_struct> init_anim
			<init_anim> = ( <anim_struct>.init_anim )
		endif
		<anim> = ( <anim_struct>.anim )
		if StructureContains structure=<anim_struct> cycle
			<cycle> = ( <anim_struct>.cycle )
		else
			<cycle> = 1
		endif
		if StructureContains structure=<anim_struct> out_anim
			<out_anim> = ( <anim_struct>.out_anim )
		endif
		
		// play init anim
		if ( GotParam init_anim )
			Obj_PlayAnim anim=<init_anim>
			Obj_WaitAnimFinished
		endif
		
		// cycle idle anim
		begin
			Obj_PlayAnim anim=<anim>
			Obj_WaitAnimFinished
		repeat <cycle>
		
		// play out anim
		if GotParam out_anim
			Obj_PlayAnim anim=<out_anim>
			Obj_WaitAnimFinished
		endif
	repeat
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_generic_bail
	GetTags
	if not GotParam grind_bail_anim
		<grind_bail_anim> = FaceFall
		<grind_get_up_anim> = GetUpFaceSmash
	endif
	
	; <grind_get_up_anim> = NSMissBackFoot_Resume
	; <grind_bail_anim> = NSMissBackFoot
	; <grind_bail_anim> = FiftyFiftyFallForward
	; <grind_get_up_anim> = GetUpFacing	
	
	Ped_SetIsBailing 1
	
	// store current max velocity
	Ped_StoreMaxVelocity
	
	// decelerate
	Obj_SetPathDeceleration ped_skater_bail_deceleration
	Obj_SetPathVelocity 0
	
	// play bail anim
	Obj_PlayAnim Anim=<grind_bail_anim> NoRestart BlendPeriod=0.3
	// play sound?
	// ...
	
	Obj_WaitAnimFinished
	
	// play get up anim
	Obj_PlayAnim Anim=<grind_get_up_anim>  BlendPeriod=0.1
	Obj_WaitAnimFinished
	
	// start moving again
	Ped_GetOriginalMaxVelocity
	Obj_SetPathVelocity <original_max_velocity> ips
	Ped_SetIsBailing 0
	Obj_SpawnScript ped_skater_idle
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_grind_bail
	// TODO: this needs to move the ped to the nearest bail node
	GetTags
	if not GotParam grind_bail_anim
		<grind_bail_anim> = FiftyFiftyFallForward
		<grind_get_up_anim> = GetUpFacing
	endif
	Ped_SetIsBailing grind 1
	
	// check if we're in a filming goal, which we'll need to fail
	if GoalManager_GetActiveGoalId
		GoalManager_GetGoalParams name=<goal_id>
		if GotParam film
			Obj_GetID
			printstruct <...>
			if ( <film_target> = <objId> )
				SpawnScript goal_film_bailed_skater params={ goal_id=<goal_id> }
			endif
		endif
	endif

	SpawnSound Ped_Skater_Grind_Bail_Sound
	ped_skater_generic_bail <...>
	Ped_SetIsBailing grind 0
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_skater_stop_actions
	// IMPORTANT:  this script is called from c using RunScript, and
	// must execute within a frame
	Obj_GetId
	
	GetArraySize ped_skater_action_scripts
	<index> = 0
	begin
		TerminateObjectsScripts use_proper_version id=<objId> script_name=( ped_skater_action_scripts[<index>] )
		<index> = ( <index> + 1 )
	repeat <array_size>
endscript
