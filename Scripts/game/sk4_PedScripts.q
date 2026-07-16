// This file is intended for only the highest-level of logic
// for the peds.  Consider this the ped's "main loop".  The
// main loop calls various subfunctions, based on its state.
// Each subfunction should be in its own file.

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_SetDefaults	
	// set the defaults here
	SetTags collision_mode=ignore
	SetTags talking_mode=friendly
	SetTags is_moving_ped=1
	SetTags is_goal_ped=0
	SetTags talking_radius=30
	SetTags collision_exception_return_state=Ped_IdleState
  	SetTags pissed=0
	SetTags should_look_at_skater=1
	
	if GotParam skater
		pedanim_init default_male_skater_anim_assets <...>
		if not GotParam brake_idle_anims
			SetTags brake_idle_anims = ped_skater_brake_idle_anims
		endif
	else
		if GotParam chick
			<anim_assets> = default_female_anim_assets
			<standing_anims> = female_goal_wait
		else
			<anim_assets> = default_male_anim_assets
			<standing_anims> = generic_ped_anims_wait
		endif
		
		if GotParam stand
			pedanim_init <anim_assets> standing_anims=<standing_anims> <...>
			SetTags collision_exception_return_state=ped_standing_idle
		else
			pedanim_init <anim_assets> <...>
		endif
	endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script CPF_PedGeneric
	printf "Please rename all instances of 'CPF_PedGeneric' to 'Ped_InitAI'"
	Ped_InitAI <...>
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_InitAI
	SK4_PedScript <...>
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

// (defaults in capital letters)

// collision_mode = { FRIENDLY, Mean }
// (the ped's attitude when you are near them)

// talking_mode = { IGNORE, Avoid, Fall, Knock }
// (the ped's reaction when you hit them)

script SK4_PedScript
	// reset all parameters to default
	Ped_SetDefaults <...>
	
	SetTags <...>
	
	// looks for certain shortcut keywords,
	// and sets the parameters as appropriate
	if GotParam Avoid
		SetTags collision_mode=avoid
	endif
	
	if GotParam Fall
		SetTags collision_mode=fall
	endif
	
	// BEGIN gunslinger stuff
	if GotParam shot
		SetTags collision_mode=shot
	endif
	// END gunslinger stuff
	
	if GotParam Knock
		SetTags collision_mode=knock
	endif
	
	if GotParam bump
		SetTags collision_mode=bump
	endif
	
	if GotParam Ignore
		SetTags collision_mode=ignore
	endif
		
	if GotParam Friendly
		SetTags talking_mode=friendly
	endif
	
	if GotParam Mean
		SetTags talking_mode=mean
	endif
	
	if GotParam Chick
		pedanim_init default_female_anim_assets
	endif
	
	if GotParam NoMove
		SetTags is_moving_ped=0
	endif
	
	if GotParam GoalPed
		SetTags is_goal_ped=1
	
		// for goal peds, it will be something different...
//		SetTags collision_exception_return_state=Ped_IdleState
	endif
	
	if GotParam stand
		SetTags is_standing_ped=1
		SetTags is_moving_ped=0
	endif

	ped_initialize_collision_exceptions

	// Setting up parameters
	Obj_StickToGround distAbove=3 distBelow=6
	Obj_StickToGround off
	
	ped_initialize_movement <...>
	
	if not GotParam stand
		Ped_InitPath
		SetTags collision_exception_return_state=ped_walker_get_up
	endif
	
	if GotParam skater
		Ped_SetIsSkater 1
		Ped_SetLogicState generic_skater
	else
		if GotParam stand
			Ped_SetLogicState generic_standing
			ped_standing_idle
		else
			Ped_SetLogicState generic
			goto Ped_IdleState
		endif
	endif
endscript
