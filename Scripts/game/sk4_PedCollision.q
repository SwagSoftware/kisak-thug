// This file contains all the collision-related 
// ped script functions

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_initialize_collision_exceptions
	// gets the ped's object data
	GetTags

	// depending on the ped's "collision_mode",
	// this will attach an appropriate exception
	// script when the skater comes within range
	switch <collision_mode>
		case fall
			Obj_SetInnerAvoidRadius 4
			Obj_SetException {
				ex=SkaterInAvoidRadius 
				scr=Ped_FallDownState 
			}
		case knock
			Obj_SetInnerAvoidRadius 2
			Obj_SetException { 
				ex=SkaterInAvoidRadius 
				scr=Ped_KnockDownState
			}
		case avoid
			Obj_SetInnerAvoidRadius 8
			Obj_SetException {
				ex=SkaterInAvoidRadius 
				scr=AVOIDSTATE_STOP
			}
		case bump
			Obj_SetInnerAvoidRadius 2
			Obj_SetException {
				ex=SkaterInAvoidRadius
				scr=goal_pro_bounce_skater
			}
		case ignore//	default	(doesn't work on the same line)
			// do not add avoid exception
			Obj_ClearException SkaterInAvoidRadius
		case shot
			Obj_SetInnerAvoidRadius 8
			Obj_SetException {
				ex=SkaterInAvoidRadius
				scr=Ped_ShotState
			}
	endswitch

	/*
	// for testing out a certain ped state
	if IsTrue ped_debug
		Obj_SetInnerAvoidRadius 2
		Obj_SetException { 
			ex=SkaterInAvoidRadius 
			scr=ped_debug_collision_scr
		}
	endif
	*/
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_return_to_precollision_state
	// gets the ped's object data
	GetTags

	SetTags pissed=0

	ped_initialize_collision_exceptions
	
	// go back to idle state (or whatever state, for goal peds)
	goto <collision_exception_return_state>
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script AVOIDSTATE_STOP
	Ped_SetLogicState avoid
	
	// clear the exception for SkaterInAvoidRadius
	Obj_ClearException SkaterInAvoidRadius

	Obj_SetInnerAvoidRadius 4
	Obj_SetException {
		ex=SkaterInAvoidRadius 
		scr=AVOIDSTATE_INIT
	}

	// see if he should immediately avoid
	wait 1 gameframe
	ped_stop_movement
	
	begin
		ped_rotate_to_skater_from_idle
			
		Random (
			@ped_play_idle_anim
			@ped_play_idle_anim
			@ped_play_idle_anim
			@ped_play_wave_anim
		)
		
		Obj_GetDistanceToObject Skater 
		if ( <objectDistance> > 12.0 )
			ped_initialize_movement
			goto ped_return_to_precollision_state
		endif		
	repeat
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script AVOIDSTATE_INIT
	// clear the exception for SkaterInAvoidRadius
	Obj_ClearException SkaterInAvoidRadius

	// reset the pissed state
	SetTags pissed=0

	// remember p1:  the point to which he's currently walking
	Ped_RememberNextWaypoint
	
	// remember p0:  the point where he currently is  
	Ped_RememberCurrentPosition
	
	Obj_StorePos
	
	// remember his old stick-to-ground	state
	Ped_RememberStickToGround

	// this point (p0) is important for
	// knowing where he is allowed to jump;
	// this vector (p1,p0) is also important
	// for knowing when it's safe to stop
	// avoiding the skater
	
	goto AVOIDSTATE_JUMP
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script AVOIDSTATE_JUMP
	// clear the exception for SkaterInAvoidRadius
	// (do it here because we're either coming
	// from the INIT or the LAND state)
	Obj_ClearException SkaterInAvoidRadius

	// gets the ped's object data
	GetTags

	// make the ped just a little more
	// pissed each time you harass him
	SetTags pissed=( <pissed> + 1 )
	
	// stop any current path traversal	
	; Obj_StopMoving
	; Obj_StopAlongPath

	// call on the c-code to avoid the skater
	if not Ped_SelectAvoidPoint <AvoidAnims>
		// couldn't find a good place to jump to
		if not GotParam stand
			goto AVOIDSTATE_KNOCKDOWN
		endif
	endif
			
	begin
		Ped_MoveTowardsAvoidPoint
		
		// in case you're jumping up/down a slope
		Obj_StickToGround
		
		if Ped_AvoidPointReached
			break
		endif
		wait 1 gameframe
	repeat
	
	goto AVOIDSTATE_LAND
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script AVOIDSTATE_LAND

	// gets the ped's object data
	GetTags

	// set a max pissed count
	// (TODO:  should be overrideable!)
	<maxPissedCount> = RandomRange(2,4)

	// if we get pissed off enough,
	// make the next avoid state
	// make the guy knock him down
	if ( <pissed> > <maxPissedCount> )
		Obj_SetInnerAvoidRadius 4
		Obj_SetException {
			ex=SkaterInAvoidRadius 
			scr=AVOIDSTATE_KNOCKDOWN
		}
	else
		Obj_SetInnerAvoidRadius 4
		Obj_SetException {
			ex=SkaterInAvoidRadius 
			scr=AVOIDSTATE_JUMP
		}	
	endif

	// start walking back,
	// if the skater has moved away
	if SkaterSpeedLessThan 1
		<stopped> = 1
	else
		<stopped> = 0
	endif

	begin
		
		Obj_GetDistanceToObject Skater
		if ( <objectDistance> > 6.0 )
			<stopped> = 0
		endif
	
		if ( <stopped> = 1 )
			// turn to the skater
			ped_rotate_to_skater_from_idle
			
			Random (
				@ped_play_disgust_anim
				@ped_play_idle_anim
				@ped_play_idle_anim
			)
							
		else
			// turn to the node
			if ( <is_moving_ped> = 1 )
				ped_rotate_to_node_from_idle
			endif

			; ped_initialize_movement
		
			break
		endif
	
	repeat

	begin
/*
		// if we're within N units of
		// the closest point on
		// (p0, p1)
		if Ped_BackOnOriginalPath dist=240.0
			break
		endif
*/
		// if the skater is far enough away
		// (10 feet), then return to idle
		Obj_GetDistanceToObject Skater 
		if ( <objectDistance> > 20.0 )
			printf "returning to idle"
			break
		endif
					
		wait 1 gameframe
	repeat

	// start walking again
	ped_initialize_movement
		
	// restore stick to ground,
	// before going to the idle mode
	Ped_RestoreStickToGround
	
	// go back to idle state
	goto ped_return_to_precollision_state

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script AVOIDSTATE_KNOCKDOWN
	// clear the exception, until it is completely handled
	Obj_ClearException SkaterInAvoidRadius
		
	// stop any current path traversal	
	; Obj_StopMoving
	; Obj_StopAlongPath

	// turn to the skater
	ped_rotate_to_skater_from_idle

	// play a random attack animation
	ped_play_attack_anim no_block

	// wait long enough for the animation 
	// to look like it would affect the
	// skater...
	wait 10 gameframes
	
	// check if the skater is in front of the ped...
	Obj_GetOrientationToObject Skater
		
	if ( <dotProd> < .5 )
		if ( <dotProd> > -.5 )
			// if skater is still within striking distance...
			Obj_GetDistanceToObject Skater 
			if ( <objectDistance> < 6.0 )
				// find out how much to rotate the skater
				Obj_GetId
				Skater:Obj_GetOrientationToObject <objId>
				
				//printf "orientation = %o supplement = %p" o=<orientation> p=( 180.0 - <orientation> )
				Skater:Rotate y=( 180.0 - <orientation> )

				// knock down the skater
				MakeSkaterGoto PedKnockDown
	
				//Obj_PlaySound bail04 Vol=200
				//Obj_PlaySound bail05 Vol=200
	
				// wait until the attack animation is done
				Obj_WaitAnimFinished
			endif
		endif
	endif

	// start walking again
	GetTags
	if not GotParam stand
		ped_initialize_movement
	endif

	// restore stick to ground,
	// before going to the idle mode
	Ped_RestoreStickToGround
	
	// go back to idle state
	goto ped_return_to_precollision_state
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_FallDownState
	Obj_GetId	
	// kill any dead end scripts
	TerminateObjectsScripts id=<objId> script_name=ped_walker_hit_dead_end use_proper_version
	TerminateObjectsScripts id=<objId> script_name=ped_adjust_speed_to_match_anim use_proper_version
	TerminateObjectsScripts id=<objId> script_name=ped_standing_look_at_skater use_proper_version
	TerminateObjectsScripts id=<objId> script_name=ped_skater_start_moving use_proper_version
	
	Ped_SetLogicState fall
	
	TerminateObjectsScripts id=<objId> script_name=ped_standing_idle use_proper_version

	// gets the ped's object data
	GetTags

	// clear the exception, until it is completely handled
	Obj_ClearException SkaterInAvoidRadius
		
	// if skater is not going fast enough
	if SkaterSpeedLessThan 1
		// Obj_StorePos
		goto Ped_DisgustState
	endif

	// if they get pissed enough, 
	// they'll knock you down anyway
	<pissed> = ( <pissed> + 1 )
	if ( <pissed> > 3 )
		SetTags pissed=<pissed>
		goto Ped_KnockDownState
	endif

	// play related sound effects	
	//Obj_PlaySound bail04 Vol=100
    
	// stop any current path traversal	
	; Obj_StopMoving
	; Obj_StopAlongPath
	
	// temp fall down sound.
	Temp_Ped_Fall_Sound
	
	// play a random falldown animation
	ped_play_falldown_anim
	
	
	Obj_SetOuterAvoidRadius 10
	Obj_SetException {
		ex=SkaterOutOfAvoidRadius 
		scr=Ped_GetUpState
	}
	
	begin
		Wait Random (@10 @60 @90) frames
		
		ped_play_layidle_anim
	repeat
		
	// should never get here...
	goto Ped_GetUpState

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_ShotState
	Ped_SetLogicState shot
	
	Obj_GetId	
	TerminateObjectsScripts id=<objId> script_name=ped_standing_idle use_proper_version

	// gets the ped's object data
	GetTags

	// clear the exception, until it is completely handled
	Obj_ClearException SkaterInAvoidRadius
		
	// play related sound effects	
	//Obj_PlaySound bail04 Vol=100

	// stop any current path traversal	
	; Obj_StopMoving
	; Obj_StopAlongPath
	
	// play a random falldown animation
	ped_play_falldown_anim
	
	Obj_SetOuterAvoidRadius 10
	Obj_SetException {
		ex=SkaterOutOfAvoidRadius 
		scr=Ped_GetUpState
	}
	
	begin
		Wait Random (@10 @60 @90) frames
		
		ped_play_layidle_anim
	repeat
		
	// should never get here...
	goto Ped_GetUpState

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_GetUpState

	// gets the ped's object data
	GetTags
	
	// clear the exception, until it is completely handled
	Obj_ClearException SkaterOutOfAvoidRadius

	// turn the collision back on...
	ped_initialize_collision_exceptions

	// get up
	ped_play_getup_anim

	goto Ped_DisgustState

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_DisgustState
	GetTags
	
	// get angry at skater
	if not ( <should_look_at_skater> = 0 )
		ped_rotate_to_skater_from_idle
	endif
	ped_play_disgust_anim

	if not GotParam stand
		// ... and then follow the path
		ped_initialize_movement
	endif
	
	// go back to idle state
	goto ped_return_to_precollision_state

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_KnockDownState
	Ped_StopMoving
	// gets the ped's object data
	GetTags
	
	// clear the exception, until it is completely handled
	Obj_ClearException SkaterInAvoidRadius

	Obj_LookAtObject type=skater time=0.05
	
	// stop any current path traversal	
	; Obj_StopMoving
	; Obj_StopAlongPath
	
	// play a random attack animation
	ped_play_attack_anim no_block
	
	// wait long enough for the animation 
	// to look like it would affect the
	// skater...
	wait 10 gameframes

	if GoalManager_CanStartGoal
		// knock down the skater
		MakeSkaterGoto PedKnockDown
	endif
	
	//Obj_PlaySound bail04 Vol=200
	//Obj_PlaySound bail05 Vol=200
	
	// wait until the attack animation is done
	Obj_WaitAnimFinished
	
	ped_rotate_to_skater_from_idle // time=0.05
		
	// ... and then follow the path
	; ped_initialize_movement
	
	// go back to idle state
	goto Ped_DisgustState
	; goto ped_return_to_precollision_state

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_AvoidState

	// gets the ped's object data
	GetTags
	
	// clear the exception, until it is completely handled
	Obj_ClearException SkaterInAvoidRadius

	if SkaterSpeedLessThan 1
		Goto Ped_DisgustState
	endif
	
	if SkaterSpeedGreaterThan 700
		Goto Ped_FallDownState
	endif
	
//	Obj_StopMovingAndRotating
//	Obj_PlayAnim Anim=<Idle> Cycle
//	Goto Ped_AvoidSkater
	
	// if they get pissed enough, 
	// they'll knock you down anyway
	<pissed> = ( <pissed> + 1 )
	if ( <pissed> > 3 )
		goto Ped_KnockDownState
	endif
	
	// need to remember where you started
	// for the c-code to work properly
	Obj_StorePos
	Obj_StoreNode
	
	// stop any current path traversal	
	; Obj_StopMoving
	; Obj_StopAlongPath
	
	// call on the c-code to avoid the skater
	Ped_SelectAvoidPoint <AvoidAnims>
			
	begin
		Ped_MoveTowardsAvoidPoint
		if Ped_AvoidPointReached
			break
		endif
		wait 1 gameframe
	repeat
	
	Obj_PlayAnim anim=<idle> cycle

	// when the avoiding is complete,
	// get angry at the skater
	ped_rotate_to_skater_from_idle
	ped_play_disgust_anim

	// ... and then follow the path
	ped_initialize_movement
	
	// go back to idle state
	goto ped_return_to_precollision_state

endscript

script Ped_BumpSkaterState	
	// gets the ped's object data
	GetTags
	
	// clear the exception, until it is completely handled
	Obj_ClearException SkaterInAvoidRadius

	Obj_GetID
	<index> = 0
	begin	
   		printf "Ped_BumpSkaterState %d %e" d=<objID> e=<index>
		<index> = ( <index> + 1 )
	repeat 10

	// go back to idle state
	goto ped_return_to_precollision_state

	GetSkaterState
	if not ( <state>=skater_OnGround )
		return
	endif
	
	// ignore if the ped is hidden
	if IsHidden
		return
	endif
	
	root_window:GetTags
	if GotParam giving_rewards
		if ( <giving_rewards> = 1 )
			return
		endif
	endif
	
	Obj_ClearException SkaterInAvoidRadius
	Obj_SpawnScript goal_pro_wait_and_reset_avoid_exception params={ goal_id=<goal_id> avoid_radius=<avoid_radius> }
	if Skater:SpeedGreaterThan 200
		if GotParam goal_id
			GoalManager_PlayGoalStream name=<goal_id> type="avoid" play_random
		endif
		return
	endif
	
	// don't fuck up race modes (luge, shopping cart, etc.)
	skater:GetTags
	if not ( <racemode> = none )
		return
	endif

	GetTags
	Skater:Obj_GetOrientationToObject <id>
	if ( <dotProd> < 0.0 )
		if ( <dotProd> > -.1 )
			<speed> = 500
			; MakeSkaterGoto PedKnockDown			
			; return
			<heading> = 180
		else
			<heading> = 90.0
		endif
	else
		if ( <dotProd> < .1 )
			<speed> = 500
			; MakeSkaterGoto PedKnockDown
			; return
			<heading> = 180
		else
			<heading> = -90
		endif
	endif
	SkaterAvoidGoalPed heading=<heading> speed=<speed>
endscript


/*

// TEMPLATE FOR NEW PED STATES

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_ThreatenSkaterState

	// gets the ped's object data
	GetTags
	
	// clear the exception, until it is completely handled
	Obj_ClearException SkaterInAvoidRadius

	Obj_GetID

	<index> = 0

	begin	
   		printf "Ped_ThreatenSkaterState %d %e" d=<objID> e=<index>
		<index> = ( <index> + 1 )
	repeat 10

	// go back to idle state
	goto ped_return_to_precollision_state

endscript
*/


