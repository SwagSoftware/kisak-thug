// new ped stuff

ped_walker_idle_states = [ "BHP", "RHP", "BAX", "LGH" ]
ped_walker_deceleration = 1
ped_walker_min_square_distance_to_dead_end = 1000
ped_max_y_distance_to_ignore = 36

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_walker_stop
	Obj_SetPathMinStopVel 1
	Obj_SetPathDeceleration ped_walker_deceleration
	Obj_StopAlongPath
	Obj_WaitStop
	Ped_StopMoving
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_walker_switch_idle_state
	GetTags

	GetRandomArrayElement ped_walker_idle_states
	<new_state> = <element>

	if GotParam obj_idle_state
		if not ( <new_state> = <obj_idle_state> )
			// we need to play a transition
			FormatText ChecksumName=transition_anim "%f_2_%t" f=<obj_idle_state> t=<new_state>
			PlayAnimWithPartialAnimIfExists anim=<transition_anim>
			Obj_WaitAnimFinished
		endif
	endif
	SetTags obj_idle_state = <new_state>

	// call new state script
	// I suppose we could rely on naming convention for these too, but
	// that seemed sketchy
	switch <new_state>
		case "BHP"
			ped_walker_bhp
		case "RHP"
			ped_walker_rhp
		case "BAX"
			ped_walker_bax
		case "LGH"
			ped_walker_lgh
		default
			script_assert "Found unknown ped walker state"
	endswitch
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_walker_get_up
	; printf "ped_walker_get_up"
	Ped_SetLogicState generic
	GetTags
	PlayAnimWithPartialAnimIfExists Anim=<Walk> Cycle UseAnimTags
	if GotParam animTags
		ped_adjust_speed_to_match_anim <animTags>
	endif
	Ped_StartMoving
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_walker_hit_dead_end
	; printf "ped_walker_hit_dead_end"
	Ped_StopMoving
	PlayAnimWithPartialAnimIfExists anim=Ped_M_LookAtWatch
	Obj_WaitAnimFinished
	Ped_GetCurrentNodeNames
	ped_standing_look_at_skater	node_name=<node_to>
	GetTags
	PlayAnimWithPartialAnimIfExists Anim=<Walk> Cycle UseAnimTags

	GetTags
	if GotParam animTags
		ped_adjust_speed_to_match_anim <animTags>
	endif

	Ped_StartMoving
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_walker_bhp
	Random( @Obj_CycleAnim  anim=BHP_Breathe
		@Obj_CycleAnim  anim=BHP_Breathe NumCycles=Random(@1 @2)
		@Obj_CycleAnim  anim=BHP_Scratch
		@Obj_CycleAnim  anim=BHP_Point
		@Obj_CycleAnim  anim=BHP_LookBack
	)
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_walker_rhp
	Random( @Obj_CycleAnim  anim=RHP_Breathe  NumCycles=Random(@1 @2)
		@OBJ_Playstream KenHelp1
		Obj_CycleAnim  anim=RHP_TalkTest
		@Obj_CycleAnim  anim=RHP_FootTap  NumCycles=Random(@1 @2 @3)
		@Obj_CycleAnim  anim=RHP_Handsmack
	)
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_walker_bax
	Random( @Obj_CycleAnim  anim=BAX_Breathe NumCycles=Random(@1 @2)
		@Obj_CycleAnim  anim=BAX_Nod NumCycles=Random(@1 @2)
	)
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_walker_lgh
	Random( @Obj_CycleAnim  anim=LGH_GutBuster NumCycles=Random(@1 @2)
		@Obj_CycleAnim  anim=LGH_KneeSlapper speed=.75
		Obj_CycleAnim  anim=LGH_GutBuster
		@Obj_CycleAnim  anim=LGH_Pointing
		Obj_CycleAnim  anim=LGH_GutBuster
		@Obj_CycleAnim  anim=LGH_Giggle
		Obj_CycleAnim  anim=LGH_GutBuster
		@Obj_CycleAnim  anim=LGH_Wave
		Obj_CycleAnim  anim=LGH_GutBuster
		@Obj_CycleAnim  anim=LGH_Wave
		Obj_CycleAnim  anim=LGH_GutBuster
	)
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_standing_idle
	GetTags
	begin
		if GotParam standing_anims
			; if Obj_ObjectInRadius radius=120 feet type=skater
			GetArraySize <standing_anims>
			CreateIndexArray <array_size>
			PermuteArray NewArrayName=random_index_array Array=<index_array>
			begin
				; if Obj_ObjectInRadius radius=120 feet type=skater
				if GetNextArrayElement <random_index_array> index=<index>
					; GenericPro_LookAtSkater pro=<pro>
					; GenericPro_PlayAnim_and_vo type=<type> ( <standing_anims>[<element>] )
					if not ( <should_look_at_skater> = 0 )
						ped_standing_look_at_skater
					endif
					ped_standing_play_anim_set ( <standing_anims>[<element>] )
					// WaitForEvent type=pro_anim_cycle_done
				else
					RemoveParameter index
					break
				endif
				; endif
				wait 1 frame
			repeat
			; endif
			wait 30 frame
		endif
	repeat
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_standing_look_at_node
	<time_to_rotate> = 1
	GetTags

	Obj_StopRotating
	if GotParam turning_anims
		if StructureContains structure=<turning_anims> pre_rotate
			<pre_rotate> = ( <turning_anims>.pre_rotate )
		endif
		if StructureContains structure=<turning_anims> rotate_anim
			<rotate_anim> = ( <turning_anims>.rotate_anim )
		endif
		if StructureContains structure=<turning_anims> post_rotate
			<post_rotate> = ( <turning_anims>.post_rotate )
		endif
	endif

	if not GotParam rotate_anim
		if GotParam chick
			<rotate_anim> = Ped_F_RotateLFromIdle1
		else
			<rotate_anim> = Ped_M_Idle1TurnL
		endif
	endif

	; printf "Ready: %o %t %h" o=<pre_rotate> t=<rotate_anim> h=<post_rotate>

	if GotParam pre_rotate
		PlayAnimWithPartialAnimIfExists anim=<pre_rotate>
		Obj_WaitAnimFinished
	endif

	//  rotate and play anim
	Obj_LookAtNode name=<node_name> time=<time_to_rotate>
	PlayAnimWithPartialAnimIfExists anim=<rotate_anim>
	wait <time_to_rotate> seconds
	; Obj_WaitAnimFinished

	// is there a post_rotate anim we should play?
	if GotParam post_rotate
		PlayAnimWithPartialAnimIfExists anim=<post_rotate>
		Obj_WaitAnimFinished
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_standing_look_at_skater
	<time_to_rotate> = 1
	GetTags

	Obj_StopRotating
	// do we need to rotate?
	if Obj_AngleToNearestSkaterGreaterThan 15
		// are there custom turning anims?

		if GotParam turning_anims
			if StructureContains structure=<turning_anims> pre_rotate
				<pre_rotate> = ( <turning_anims>.pre_rotate )
			endif
			if StructureContains structure=<turning_anims> rotate_anim
				<rotate_anim> = ( <turning_anims>.rotate_anim )
			endif
			if StructureContains structure=<turning_anims> post_rotate
				<post_rotate> = ( <turning_anims>.post_rotate )
			endif
		endif

		if not GotParam rotate_anim
			if GotParam chick
				<rotate_anim> = Ped_F_RotateLFromIdle1
			else
				<rotate_anim> = Ped_M_Idle1TurnL
			endif
		endif

		; printf "Ready: %o %t %h" o=<pre_rotate> t=<rotate_anim> h=<post_rotate>

		if GotParam pre_rotate
			PlayAnimWithPartialAnimIfExists anim=<pre_rotate>
			Obj_WaitAnimFinished
		endif

		//  rotate and play anim
		Obj_LookAtObject type=skater time=<time_to_rotate> ; AngleThreshold=15
		PlayAnimWithPartialAnimIfExists anim=<rotate_anim>
		wait <time_to_rotate> seconds
		; Obj_WaitAnimFinished

		// is there a post_rotate anim we should play?
		if GotParam post_rotate
			PlayAnimWithPartialAnimIfExists anim=<post_rotate>
			Obj_WaitAnimFinished
		endif
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_standing_play_anim_set
	begin
		if GetNextArrayElement <anims> index=<index>
			if StructureContains structure=<element> ped_speed
				Obj_SetPathVelocity ( <element>.ped_speed ) fps
			endif

			if StructureContains structure=<element> speed
				<speed> = ( <element>.speed )
			else
				if StructureContains structure=<element> random_speed_high
					if StructureContains structure=<element> random_speed_low
						GetRandomValue {
							name=speed
							resolution=0.1
							a=( <element>.random_speed_low )
							b=( <element>.random_speed_high )
						}
					endif
				endif
			endif
			if StructureContains structure=<element> flip
				Obj_flip
			endif

			if StructureContains structure=<element> anim
				// printf "got anim in element struct"
				PlayAnimWithPartialAnimIfExists <element> speed=<speed> UseAnimTags

				GetTags
				if GotParam animTags
					ped_adjust_speed_to_match_anim <animTags>
				endif

				if StructureContains structure=<element> script_name
					ped_run_script <element>
				endif
			else
				if StructureContains structure=<element> script_name
					ped_run_script <element>
				else
					; GenericPro_LookAtSkater pro=<pro>
					PlayAnimWithPartialAnimIfExists anim=<element> speed=<speed> UseAnimTags

					GetTags
					if GotParam animTags
						ped_adjust_speed_to_match_anim <animTags>
					endif

				endif
			endif
			Obj_WaitAnimFinished
		else
			return
		endif
		wait 1 frame
	repeat
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_run_script
	<script_name> <script_params>
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script ped_adjust_speed_to_match_anim
	if GotParam movementSpeed
		Obj_SetPathVelocity <movementSpeed> ips
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script invalidate_anim_cache
	RunScriptOnComponentType component=animation target=InvalidateCache params={}
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

