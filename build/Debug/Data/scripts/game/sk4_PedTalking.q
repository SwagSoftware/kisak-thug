// Basic reaction to skater

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_IdleState
	; printf "Ped_IdleState"
	; printstruct <...>

	// gets the ped's object data
	GetTags

	ped_start_movement

	; Ped_SetLogicState Idle
	Ped_SetLogicState generic
	/*
	begin
		// if the skater is close, then
		// react to the skater
		Obj_GetDistanceToObject Skater
		if ( <objectDistance> < <talking_radius> )
	    	goto Ped_ReactionState
		endif

		wait 1 gameframe
	repeat
*/
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_ReactionState
	; printf "Ped_ReactionState"
	Ped_SetLogicState none

	// gets the ped's object data
	GetTags

	; printstruct <...>

	switch <talking_mode>
		case friendly
			<should_wave> = 1
			<should_stop> = 0
		default
			<should_wave> = 0
			<should_stop> = 1
	endswitch

	if ( <should_stop> = 1 )
		ped_stop_movement
	endif

	begin

		if ( <is_moving_ped> = 1 )
			if ( <should_wave> = 1 )
				ped_walking_wave
			else
				ped_wave
			endif
		else
			ped_wave
		endif

		// if the skater is close, then
		// react to the skater
		Obj_GetDistanceToObject Skater
		if ( <objectDistance> > <talking_radius> )
			goto Ped_IdleState
		endif

		wait 1 gameframe
	repeat
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_walking_wave
	// gets the ped's object data
	GetTags

	// check to see where the skater is
	// in relation to the ped
	ped_in_front_of_skater

	if ( <in_front> )
		Random(
			@Obj_PlayAnim Anim=<WalkingWave>
			@Obj_PlayAnim Anim=<Walk>
			@Obj_PlayAnim Anim=<Walk>
			@Obj_PlayAnim Anim=<Walk>
			@Obj_PlayAnim Anim=<Walk>
		)
	else
		Obj_PlayAnim Anim=<Walk>
	endif

	Obj_WaitAnimFinished
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_wave
	// gets the ped's object data
	GetTags

	ped_rotate_to_skater_from_idle

	switch <talking_mode>
		case friendly
			Obj_PlayAnim Anim=<Wave>
			Obj_WaitAnimFinished
		case mean
			ped_play_disgust_anim
	endswitch
endscript

