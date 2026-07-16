//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script pedanim_init
	SetTags <...>
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_impressed_anim

	// gets the ped's object data
	GetTags
	
	GetArraySize <impressedAnims>
	GetRandomValue name=index integer a=0 b=( <array_size> - 1 )
	Obj_PlayAnim Anim=((<impressedAnims>)[<index>])
		
	if not gotparam no_block
		Obj_WaitAnimFinished
	endif
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_bored_anim

	// gets the ped's object data
	GetTags

	GetArraySize <boredAnims>
	GetRandomValue name=index integer a=0 b=( <array_size> - 1 )
	Obj_PlayAnim Anim=((<boredAnims>)[<index>])
	
	if not gotparam no_block
		Obj_WaitAnimFinished
	endif
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_wave_anim

	// gets the ped's object data
	GetTags

	// only play the wave from the idle1 anim
	if Obj_AnimEquals <Idle>
		Obj_PlayAnim Anim=<wave>
	
		if not gotparam no_block
			Obj_WaitAnimFinished
		endif
	endif

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_idle_anim

	// gets the ped's object data
	GetTags

	GetArraySize <idleAnims>
	GetRandomValue name=index integer a=0 b=( <array_size> - 1 )
	Obj_PlayAnim Anim=((<idleAnims>)[<index>])
	
	//ped_play_next_idle_anim

	if not gotparam no_block
		Obj_WaitAnimFinished
	endif
		
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_disgust_anim
	
	// gets the ped's object data
	GetTags

	GetArraySize <disgustAnims>
	GetRandomValue name=index integer a=0 b=( <array_size> - 1 )
	Obj_PlayAnim Anim=((<disgustAnims>)[<index>])
	
	if not gotparam no_block
		Obj_WaitAnimFinished
	endif
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_attack_anim
	
	// gets the ped's object data
	GetTags

	GetArraySize <attackAnims>
	GetRandomValue name=index integer a=0 b=( <array_size> - 1 )
	Obj_PlayAnim Anim=((<attackAnims>)[<index>])
	
	if not gotparam no_block
		Obj_WaitAnimFinished
	endif
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_falldown_anim
	
	// gets the ped's object data
	GetTags

	GetArraySize <fallDownAnims>
	GetRandomValue name=index integer a=0 b=( <array_size> - 1 )
	Obj_PlayAnim Anim=((<fallDownAnims>)[<index>])
	
	// remember which falldown animation, so that we can
	// get the appropriate getup animation
	SetTags fallDownAnimIndex=<index>

	if not gotparam no_block
		Obj_WaitAnimFinished
	endif
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_layidle_anim
	
	// gets the ped's object data
	GetTags

	// (assumes that a falldown anim was already played at some point)
	if not GotParam fallDownAnimIndex
		GetArraySize <layIdleAnims>
		GetRandomValue name=fallDownAnimIndex integer a=0 b=( <array_size> - 1 )	
	endif
	
	Obj_PlayAnim Anim=((<layIdleAnims>)[<fallDownAnimIndex>])

	if not gotparam no_block
		Obj_WaitAnimFinished
	endif

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_getup_anim
	
	// gets the ped's object data
	GetTags

	// (assumes that a falldown anim was already played at some point)
	if not GotParam fallDownAnimIndex
		GetArraySize <getupAnims>
		GetRandomValue name=fallDownAnimIndex integer a=0 b=( <array_size> - 1 )	
	endif
	
	Obj_PlayAnim Anim=((<getupAnims>)[<fallDownAnimIndex>])

	if not gotparam no_block
		Obj_WaitAnimFinished
	endif

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_knockdown_reaction_anim
	
	// gets the ped's object data
	GetTags

	GetArraySize <knockdownReactionAnims>
	GetRandomValue name=index integer a=0 b=( <array_size> - 1 )
	Obj_PlayAnim Anim=((<knockdownReactionAnims>)[<index>])
	
	if not gotparam no_block
		Obj_WaitAnimFinished
	endif
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_initialize_movement
	; printf "ped_initialize_movement"
	; Ped_SetLogicState idle 
	; Ped_SetLogicState generic
	// gets the ped's object data
	GetTags	

	if ( <is_moving_ped> = 1 )
		; printf "ped is moving"
		; printstruct <...>
		// Start following the path that it's linked to
		Obj_SetPathTurnDist 2.5 feet
		; Obj_PathHeading On
		if GotParam skater
			if not GotParam speed
				speed = 25
			endif
			Obj_SetPathVelocity <speed> fps
			Obj_SpawnScript ped_skater_idle
		else
			if not GotParam speed
				speed = RandomRange( 5, 10 )
			endif
			Obj_SetPathVelocity <speed> fps
			Obj_PlayAnim Anim=<IdleToWalk>
			Obj_WaitAnimFinished
			if GotParam WalkAnims
				GetRandomArrayElement <walkanims>
				<walk> = <element>
				SetTags walk=<walk>
			endif
			Obj_PlayAnim Anim=<Walk> Cycle UseAnimTags
			
			GetTags
			if GotParam animTags
				ped_adjust_speed_to_match_anim <animTags>
			endif
		endif
		
		if GotParam PathToFollow
			; Obj_FollowPath name = <PathToFollow>
		else
			; Obj_FollowPathLinked
		endif
		
		if GotParam PathToFollow
			; Obj_FollowPath name = <PathToFollow>
		else
			; Obj_FollowPathLinked
		endif
	else
		// stand still
//		ped_rotate_to_node_from_idle
		ped_standing_idle
		
		; Obj_PlayAnim Anim=<Idle> Cycle
	endif
	
	; ped_start_movement
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_start_movement
	; printf "ped_start_movement"
	; Ped_SetLogicState idle	
	; Ped_SetLogicState generic
	// gets the ped's object data
	GetTags	

	if ( <is_moving_ped> = 1 )
		; printf "is_moving_ped = 1"
		if not Obj_AnimEquals <Walk>
			// if not already walking...
			Obj_SetAnimCycleMode off
			Obj_WaitAnimFinished	
	
			ped_rotate_to_node_from_idle
		
			Obj_SetAnimCycleMode off
			
			; Obj_StartAlongPath
			Obj_PlayAnim Anim=<IdleToWalk>
			Obj_WaitAnimFinished
		else
			; printf "anim is already walk!"
		endif
		Obj_PlayAnim Anim=<Walk> Cycle
	else
		; printf "is_moving_ped = 0"
		// if stationary, don't move
//		ped_rotate_to_node_from_idle
		
		Obj_PlayAnim Anim=<Idle> Cycle
	endif	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_stop_movement
	; Ped_SetLogicState stop
	
	// gets the ped's object data
	GetTags
	
	<playing_walk_anim> = 0
	
	if Obj_AnimEquals <Walk>
		<playing_walk_anim> = 1
	endif
	
	if Obj_AnimEquals <WalkingWave>
		<playing_walk_anim> = 1
	endif

	if ( <playing_walk_anim> = 1 )
		
		// finish off the walk cycle
		Obj_SetAnimCycleMode off
		Obj_WaitAnimFinished
		
		// stop the ped
		; Obj_StopAlongPath
		; Obj_StopMoving
		
		// get him to the idle animation
		Obj_PlayAnim Anim=<WalkToIdle>
		Obj_WaitAnimFinished
	
	endif	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_rotate_to_skater_from_idle time=0.3

	// gets the ped's object data
	GetTags

	// do we need to rotate?
	if Obj_AngleToNearestSkaterGreaterThan 15

		// need to know which idle you're currently playing...
		if Obj_LookAtObject type=skater time=<time>
			Obj_PlayAnim Anim=<RotateFromIdle1>
//			ped_play_next_rotate_to_idle_anim
			Obj_WaitRotate
			Obj_SetAnimCycleMode off
			Obj_WaitAnimFinished
		endif

	endif

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_rotate_to_node_from_idle	time=0.3

	// gets the ped's object data
	GetTags

	// need to know which idle you're currently playing...
	if Obj_LookAtNodeLinked time=<time>
		Obj_PlayAnim Anim=<RotateFromIdle1>
//		ped_play_next_rotate_to_idle_anim
		Obj_WaitRotate
		Obj_SetAnimCycleMode off
		Obj_WaitAnimFinished
	endif

endscript

/*
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_next_rotate_to_idle_anim

	// gets the ped's object data
	GetTags

	<found> = 0

	if ( <found> = 0 )
		if Obj_AnimEquals <Idle2>
			Obj_PlayAnim Anim=<RotateFromIdle2>			
		endif
		
		if Obj_AnimEquals <IdleToIdle2>
			Obj_PlayAnim Anim=<RotateFromIdle2>			
		endif
	endif

	if ( <found> = 0 )
		if Obj_AnimEquals <Idle3>
			Obj_PlayAnim Anim=<RotateFromIdle3>			
		endif
		
		if Obj_AnimEquals <IdleToIdle3>
			Obj_PlayAnim Anim=<RotateFromIdle3>			
		endif
	endif

	if ( <found> = 0 )
		Obj_PlayAnim Anim=<RotateFromIdle1>
	endif
	
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_play_next_idle_anim

	// gets the ped's object data
	GetTags

	<found> = 0

	if ( <found> = 0 )
		if Obj_AnimEquals <Idle2>
			Random (
				@Obj_PlayAnim Anim=<Idle2>
				@Obj_PlayAnim Anim=<Idle2>
				@Obj_PlayAnim Anim=<Idle2>
				@Obj_PlayAnim Anim=<Idle2ToIdle>
			)
			<found> = 1	
		endif
	endif

	if ( <found> = 0 )
		if Obj_AnimEquals <Idle3>
			Random (
				@Obj_PlayAnim Anim=<Idle3>
				@Obj_PlayAnim Anim=<Idle3>
				@Obj_PlayAnim Anim=<Idle3>
				@Obj_PlayAnim Anim=<Idle3ToIdle>
			)
			<found> = 1	
		endif
	endif

	if ( <found> = 0 )
		if Obj_AnimEquals <Idle2ToIdle>
			Obj_PlayAnim Anim=<Idle>
			<found> = 1	
		endif
	endif

	if ( <found> = 0 )
		if Obj_AnimEquals <Idle3ToIdle>
			Obj_PlayAnim Anim=<Idle>
			<found> = 1	
		endif
	endif

	if ( <found> = 0 )
		if Obj_AnimEquals <IdleToIdle2>
			Obj_PlayAnim Anim=<Idle2>
			<found> = 1	
		endif
	endif

	if ( <found> = 0 )
		if Obj_AnimEquals <IdleToIdle3>
			Obj_PlayAnim Anim=<Idle3>
			<found> = 1	
		endif
	endif

	if ( <found> = 0 )
		if Obj_AnimEquals <Idle>
			Random (
				@Obj_PlayAnim Anim=<Idle>
				@Obj_PlayAnim Anim=<Idle>
				@Obj_PlayAnim Anim=<Idle>
				@Obj_PlayAnim Anim=<IdleToIdle2>
				@Obj_PlayAnim Anim=<IdleToIdle3>
			)
			<found> = 1	
		endif
	endif
	
	if ( <found> = 0 )
		Obj_PlayAnim Anim=<Idle>
	endif

endscript
*/

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_in_front_of_skater

	<retVal> = 0

	// check if the skater is in front of the ped...
	Obj_GetOrientationToObject Skater
	
	if ( <dotProd> < .5 )
		if ( <dotProd> > -.5 )
			<retVal> = 1
		endif
	endif
	
	return in_front=<retVal>

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_pass_ped
	; Ped_RememberNextWaypoint
	Obj_StopAlongPath
	Ped_SetLogicState pass_ped
endscript

script ped_pass_ped_finish
	Ped_SetLogicState idle
	Obj_SetPathVelocity <vel> ips
	Obj_StartAlongPath
	Obj_SetPathAcceleration 10000
	Obj_StoreNode
	Obj_FollowPathStored
	; Obj_FollowPathLinked
	; printf "vel = %f" f=<vel>
	; wait 1 frame
	; Obj_SetPathAcceleration 1
endscript

script ped_wait_to_pass_ped
	; printf "waiting to pass ped"
	; printstruct <...>
	Ped_SetLogicState waiting_to_pass_ped
	Obj_SetPathDeceleration 100
	Obj_SetPathVelocity <lead_ped_vel> ips
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

