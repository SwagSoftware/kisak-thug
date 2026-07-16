// X - Postive = front flip 	Negative = back flip
// Y - Postive = backside spin 	Negative = frontside spin
// Z - Postive = heelside roll 	Negative = toeside roll

MAX_CREATED_TRICKS=11	// 0 is the editing slot, so there are really only 10!
CAT_BLEND=0.15

// avoid using globals in CAT because both players
// in a 2 player game could be running these scripts at the same time

// this is ok as a global because it is only used in the editor
cat_done=1
demo_flipped_cat_skater=0

// these values are used to initialize default CATs
Default_CAT_other_info = { name="" full=0 can_spin=1 }
		
Default_CAT_rotation_info = [
	{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 } ;off_x=0 off_y=30 off_z=0 }
	{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
	{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
	{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
	{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
	{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
Default_CAT_animation_info = [
    { on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=1 hold=0 backwards=0 }
	{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=2 hold=0 backwards=0 }
	{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
	{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
	{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
	{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
						
/*
// NoSpin
// RevertFS RevertBS
// Anim
// BoardRotate
// FlipAfter
// RotateAfter
// SpinSlack
// GrindSlack
// TrickSlack
*/

// @script | get_new_cat_values | returns the default createAtrick values for making a new trick
script get_new_cat_values
	printf "script get_new_cat_values"
	name=""
	full=1
	can_spin=1
	
	rotation_info=( Default_CAT_rotation_info )
	animation_info=( Default_CAT_animation_info )
    return <...>
endscript

// @script | CreateATrick | plays a created trick in game
script CreateATrick
    printf "CreateATrick"
	GetCurrentSkaterProfileIndex
	
	change cat_done=0
	
    CAT_SetHoldTime 0.0 skater=<currentSkaterProfileIndex>
    CAT_SetAnimsDone 1 skater=<currentSkaterProfileIndex>
    CAT_SetRotsDone 1 skater=<currentSkaterProfileIndex>
	
	OnExitRun created_trick_cleanup
	
    ;Initialize_CAT_Class_Tricks
    
    // Get all the params for this Create A Trick
	get_CAT_param_values skater=0 trick_index=<trick_index>
	
	// if this is running on the skater
	if GotParam demo_loop
		CAT_Skater:Obj_EnableAnimBlending enabled=1
        CAT_Skater:Obj_SetOrientation Y=0
	else
		// Clear any jump tricks that might have got queued up.
		// Note this does not clear everything in the trick queue, just tricks from
		// the arrays specified.
		ClearTricksFrom Jumptricks Jumptricks0 Jumptricks
		;CheckForOllie	//all trick scripts should do an immediate check for an ollie, see script for more comments 
		KillExtraTricks
		;ClearManualTrick		// if a manual got queued up before this trick, cancel it
		;ClearExtraGrindTrick	// ditto for special grinds
		Bailon
		
		if GotParam FromGroundGone
			// we came from GroundGone, so allow late ollies
			SetEventHandler Ex=Ollied Scr=TrickOllie
		else
			// no ollies allowed while in air
			ClearException Ollied
		endif
	endif
	
	// kill any left over rotations from previous CAT
	// this messes up when playing two created tricks back to back
	;CancelRotateDisplay
    
	no_rotations=1
	bailtime=0
	animtime=0
	
    //Rotations
	GetArraySize <rotation_info>
    index=0
	
    // are there any rotations in the trick?
	begin
		if ( ((<rotation_info>[<index>]).on) = 1 )
            no_rotations=0
            CAT_SetRotsDone 0 skater=<currentSkaterProfileIndex>
			break
		endif
		index = ( <index> + 1 )
	repeat <array_size>
	
	// Turn off spin
	if ( <can_spin> = 0 )
		if not GotParam demo_loop
			NoSpin
		endif
	endif
	
	index=0
	if ( <no_rotations> = 0 )
		
		// calculate when the last rotation will finish
		begin
			if ( ((<rotation_info>[<index>]).on) = 1 )
				Dur=((<rotation_info>[<index>]).Dur)
				start=((<rotation_info>[<index>]).start)
				
                if ( (<Dur> + <Start>) > <bailtime> )
					bailtime = (<Dur> + <Start>)
					last_rot = <index>
				endif
			endif
			index = ( <index> + 1 )
		repeat <array_size>
		
		index=0
		// spawn all the rotations
		begin
			if ( ((<rotation_info>[<index>]).on) = 1 )
				Dur=((<rotation_info>[<index>]).Dur)
				start=((<rotation_info>[<index>]).start)
				
				if ( <index> = <last_rot> )
					last=1
				endif
				
				spawn_rotation_script { Axis=((<rotation_info>[<index>]).Axis)
										Deg=((<rotation_info>[<index>]).Deg)
										Dur=((<rotation_info>[<index>]).Dur)
										start=((<rotation_info>[<index>]).start)
										off_x=((<rotation_info>[<index>]).off_x)
										off_y=((<rotation_info>[<index>]).off_y)
										off_z=((<rotation_info>[<index>]).off_z)
										deg_dir=((<rotation_info>[<index>]).deg_dir)
										last=<last>
										demo_loop=<demo_loop>
									  }
			endif
			RemoveParameter last
			index = ( <index> + 1 )
		repeat <array_size>
	endif
	
    // Handle animations
	GetArraySize <animation_info>
    
    index=0
    CAT_SetNumAnims 0 skater=<currentSkaterProfileIndex>
    // Count the anims that are ON
	begin
		if ( ((<animation_info>[<index>]).on) = 1 )
            GetCurrentSkaterProfileIndex
			CAT_GetNumAnims skater=<currentSkaterProfileIndex>
			CAT_SetNumAnims ( <num_animations_on> + 1 ) skater=<currentSkaterProfileIndex>
		endif
		index = ( <index> + 1 )
	repeat <array_size>
	
    count=1
	anim_order=[0,0,0,0,0,0]
    
	// Get the order of the anims
	begin
		index=0	
		begin
			if ( ((<animation_info>[<index>]).order) = <count> )
				SetArrayElement ArrayName=anim_order index=(<count>-1) newvalue=<index>
                ;anim_order[(<count>-1)] = <index>  // This is what the line above does
				break
			endif
            index = ( <index> + 1 )
		repeat <array_size>
		count = ( <count> + 1 )
	repeat <array_size>
	
    // spawn the script that plays all the anims
	GetCurrentSkaterProfileIndex
    CAT_GetNumAnims skater=<currentSkaterProfileIndex>
	if ( <num_animations_on> > 0 )
        CAT_SetAnimsDone 0 skater=<currentSkaterProfileIndex>
		Obj_Spawnscript spawned_trick_anim Params={	animation_info=<animation_info>
													array_size=<array_size>
													anim_order=<anim_order>
													demo_loop=<demo_loop>
												  }
	endif
	
    // calculate time to perform all anims that are on
    index=0
	begin
		if ( ((<animation_info>[<index>]).on) = 1 )
			if not ( ((<animation_info>[<index>]).trickType) = 4 ) // don't count sounds
				trick_got_idle trick=((<animation_info>[<index>]).trick)
				if ( <got_idle> = 1 )
					animtime = ( <animtime> + ((<animation_info>[<index>]).dur) + ((<animation_info>[<index>]).idletime) + ((<animation_info>[<index>]).start) )
				else
					animtime = ( <animtime> + ((<animation_info>[<index>]).dur) + ((<animation_info>[<index>]).start) )
				endif
			endif
		endif
		index = ( <index> + 1 )
	repeat <array_size>
	
    // total trick time is whichever is longer
	if ( <animtime> > <bailtime> )
		bailtime = <animtime>
	endif
    CAT_SetBailDone 0 skater=<currentSkaterProfileIndex>
	Obj_Spawnscript  waitforbailoff Params={ time=<bailtime> }
    
    // Some tricks require us to force the direction of the revert in order to look good
    /*If GotParam RevertFS
    	Obj_SetFlag FLAG_SKATER_REVERTFS
    endif	
    If GotParam RevertBS
    	Obj_SetFlag FLAG_SKATER_REVERTBS
    endif*/
    
	// Display trick text and update score
	if not GotParam demo_loop
		Obj_Spawnscript cat_update_trick_string params={ name=<name> bailtime=<bailtime> can_spin=<can_spin> }
	endif
	
    begin
		// if we're allowing late ollies during the trick
		if GotParam FromGroundGone
			// check each frame to see if the late ollie window has passed
			if AirTimeGreaterThan Skater_Late_Jump_Slop
				// stop listening for late ollies
				ClearException Ollied
				RemoveParameter FromGroundGone
			endif
		endif
		
		CAT_GetBailDone skater=<currentSkaterProfileIndex>
        if ( <bailtimescriptdone> = 1 )
            break
		endif
		wait 1 gameframe
	repeat
	
	// if we've gotten this far and are still listening for late ollies, definitely stop listening
	if GotParam FromGroundGone
		ClearException Ollied
	endif
	
	if not GotParam demo_loop
		Bailoff
		CanSpin
		DoNextTrick
	endif
	
    begin
		CAT_GetAnimsDone skater=<currentSkaterProfileIndex>
		if ( <cat_animations_done> = 1 )
			break
		endif
		wait 1 gameframe
	repeat
	
	begin
		CAT_GetRotsDone skater=<currentSkaterProfileIndex>
		if ( <cat_rotations_done> = 1 )
			break
		endif
		wait 1 gameframe
	repeat

    printf "FINISHED CREATEATRICK"
	change cat_done=1
		
    if GotParam demo_loop
		if ( demo_flipped_cat_skater = 1 )
			Obj_Flip
			change demo_flipped_cat_skater=0
		endif
		return
	endif
	
    goto Airborne
    
endscript

/////////////////////////////////////////////////////////////////////////////////////////////////
//  ROTATION SCRIPTS
/////////////////////////////////////////////////////////////////////////////////////////////////

// @script | spawn_rotation_script | spawned for each rotation in a CAT so that simultaneous rotations can be performed
script spawn_rotation_script axis=x
    GetCurrentSkaterProfileIndex
	CAT_SetTotalY 0 skater=<currentSkaterProfileIndex>
	CAT_SetTotalX 0 skater=<currentSkaterProfileIndex>
	CAT_SetTotalZ 0 skater=<currentSkaterProfileIndex>
	
    if ( <Axis> = x )
        Obj_Spawnscript RotateOnAxis PauseWithObject Params={ 	Axis=<Axis> 
																Dur=<Dur> 
																start_val=<start> 
																StartAngle = 0 
																EndAngle = <Deg>
																off_x=<off_x> 
																off_y=<off_y>
																off_z=<off_z>
																last=<last>
																deg_dir=<deg_dir>
																demo_loop=<demo_loop>
															}
	else
		StartAngle = 0
		EndAngle = <Deg>
		if not GotParam demo_loop
			if flipped
				EndAngle = (-1 * <Deg>)
			endif
		endif
		Obj_Spawnscript RotateOnAxis PauseWithObject Params={ 	Axis=<Axis> 
																Dur=<Dur> 
																start_val=<start> 
																StartAngle = <StartAngle> 
																EndAngle = <EndAngle> 
																off_x=<off_x> 
																off_y=<off_y>
																off_z=<off_z>
																last=<last>
																deg_dir=<deg_dir>
																demo_loop=<demo_loop>
															}
	endif
endscript

// @script | RotateOnAxis | performs skater rotation on given axis
script RotateOnAxis { off_x=0 off_y=30 off_z=0 axis=x }
        GetCurrentSkaterProfileIndex
		
		if GotParam start_val
			wait <start_val> seconds
		endif
        
		RotationOffset = ( ((1,0,0) * <off_x>) + ((0,1,0) * <off_y>) + ((0,0,1) * <off_z>) )
        if ( <deg_dir> = 1 )
			endangle = ( <endangle> * -1 )
		endif
		
		RotateDisplay { <Axis>
						Duration = <Dur> seconds
						;StartAngle = <startangle>
						EndAngle = <endangle> 
						SinePower = 1
						RotationOffset = <RotationOffset>
						HoldOnLastAngle
					  }
		
		// figure out if the skater needs to be flipped at the end of the trick
		CAT_GetTotalX skater=<currentSkaterProfileIndex>
		CAT_GetTotalY skater=<currentSkaterProfileIndex>
		CAT_GetTotalZ skater=<currentSkaterProfileIndex>
		
        switch <axis>
			case x
				// X Axis
                total_X_angle=( <total_X_angle> + <endangle> )
				CAT_SetTotalX <total_X_angle> skater=<currentSkaterProfileIndex>
			case y
				// Y Axis
                total_Y_angle=( <total_Y_angle> + <endangle> )
				CAT_SetTotalY <total_Y_angle> skater=<currentSkaterProfileIndex>
			case z
				// Z Axis
				total_Z_angle=( <total_Z_angle> + <endangle> )
				CAT_SetTotalZ <total_Z_angle> skater=<currentSkaterProfileIndex>
			default
				// axis should always be x y or z
				printf "CAT: Bad Axis value"
				return
		endswitch
		
		mod_x = ( <total_X_angle> - (<total_X_angle>/360)*360)
        mod_y = ( <total_Y_angle> - (<total_Y_angle>/360)*360)
		mod_z = ( <total_Z_angle> - (<total_Z_angle>/360)*360)
				
		if not ( <mod_y> = 0 )
			flip_skater = 1
		else
			flip_skater = 0
		endif
		
		if not ( <mod_x> = 0 )
			if not ( <mod_z> = 0 )
				if ( <flip_skater> = 1 )
					flip_skater = 0
				else
					flip_skater = 1
				endif
			endif
        endif
		
        if ( <flip_skater> = 1 )
			CAT_SetFlipSkater 1 skater=<currentSkaterProfileIndex>
		else
			CAT_SetFlipSkater 0 skater=<currentSkaterProfileIndex>
		endif
        // finished flip calculations
		
		if GotParam last
			wait <dur> seconds
            if not GotParam demo_loop
                if ( <flip_skater> = 1 )
					CAT_SetFlipSkater 0 skater=<currentSkaterProfileIndex>
                    rotate y=180
				endif
                CancelRotateDisplay
			endif
            CAT_SetRotsDone 1 skater=<currentSkaterProfileIndex>
		endif
endscript

/////////////////////////////////////////////////////////////////////////////////////////////////
//  ANIMATION SCRIPT
/////////////////////////////////////////////////////////////////////////////////////////////////

// @script | spawned_trick_anim | plays all of the CAT anims
script spawned_trick_anim
    
	index=0
	tweak_grab=99
	anims_played_this_trick=0
	have_played_real_anim=0
	
	GetCurrentSkaterProfileIndex
	
	// Find grab to be held
	begin
		if ( ((<animation_info>[<index>]).on) = 1 )
			;if ( ((<animation_info>[<index>]).trickType) = 1 )
				if ( ((<animation_info>[<index>]).hold) = 1 )
                    tweak_grab = <index>
				endif
			;endif
		endif
		index = ( <index> + 1 )
	repeat <array_size>
	
	index=0
	count=0
    
    begin
        index = ( <anim_order>[<count>] )
        if ( ((<animation_info>[<index>]).on) = 1 )
			Blend=((<animation_info>[<index>]).blend)
			From=((<animation_info>[<index>]).from)
            Dur=((<animation_info>[<index>]).dur)
			start=((<animation_info>[<index>]).start)
			trickType=((<animation_info>[<index>]).trickType)
            trick=((<animation_info>[<index>]).trick)
			idletime=((<animation_info>[<index>]).idletime)
			<backwards>=((<animation_info>[<index>]).backwards)
			
			trick_got_idle trick=<trick>
			
			// special item
			if not IsArray <trick>
				SpecialItem_details = ( <trick>.Params.SpecialItem_details )
				SpecialSounds = ( <trick>.Params.SpecialSounds )
				Stream = ( <trick>.Params.Stream )
			else
				SpecialItem_details = ( (<trick>[0]).Params.SpecialItem_details )
				SpecialSounds = ( (<trick>[0]).Params.SpecialSounds )
				Stream = ( (<trick>[0]).Params.Stream )
			endif
			
            TurnOffSpecialItem
            
			if ( <trickType> = 4 ) // don't have to do much for sounds
				if not GotParam demo_loop
					Obj_Spawnscript spawned_cat_sound_script params={ start=<start> stream=<stream> }
				endif
                anims_played_this_trick = ( <anims_played_this_trick> + 1 )
				
				GetCurrentSkaterProfileIndex
				CAT_GetNumAnims skater=<currentSkaterProfileIndex>
				printf "	played %p / %o anims" p=<anims_played_this_trick> o=<num_animations_on>
				if ( <anims_played_this_trick> = <num_animations_on> )
                    Obj_Spawnscript are_cat_anims_done params={ no_wait flip_skater=<flip_skater> demo_loop=<demo_loop> }
					return
				endif
			else
				if ( <got_idle> = 1 )
					if not IsArray <trick>
						anim = (<trick>.Params.anim)
						idle = (<trick>.Params.idle)
						if StructureContains structure=(<trick>.Params) outanim
							outanim = (<trick>.Params.outanim)
						endif
					else
						anim = ((<trick>[0]).Params.anim)
						idle = ((<trick>[0]).Params.idle)
						if StructureContains structure=((<trick>[0]).Params) outanim
							outanim = ((<trick>[0]).Params.outanim)
						endif
					endif
					
					// calculate the speed
					if GotParam outanim
						GetAnimLength anim=<outanim>
						out_length=<length>
					endif
					GetAnimLength anim=<anim>
					if not GotParam out_length
						out_length=<length>
					endif
					total_length=(<length>+<out_length>)
                    
                    Percent=((<animation_info>[<index>]).percent)
					if ( <percent> > 1 )
						percent = 1
					endif
					
					// convert to and from values from percentages to 60ths of a second
					from_seconds =  ( <from> * (<total_length>/2.0) * 60 )
					to_seconds =  ( <percent> * (<total_length>/2.0) * 60 )
					
					// adjust speed for new durations
					// speed = in anim, speed2 = out anim
                    
					in_ratio = ( <length>/<total_length> )
					out_ratio = ( 1.0 - <in_ratio> )
					
					if ( ( <in_ratio> = 0 ) || ( <out_ratio> = 0 ) )
						printf "CAT: bad ratio"
						return
					endif
					
					speed = ( ( <length> * (1.0-<from>) ) / (<in_ratio>*<dur>) )
					speed2 = ( ( <out_length> * <percent> ) / (<out_ratio>*<dur>) )
                    
                    if ( 0 > <to_seconds> )
						to_seconds = 0
					endif
					
					blend_seconds = ( <blend> * <speed> )
					
					if not ( <start> = 0 )
						;Obj_PlayAnim { Anim=Airidle cycle }
						wait <start> seconds
					endif
					
					if GotParam SpecialItem_details
						printf "I have a special item"
						TurnOnSpecialItem SpecialItem_details=<SpecialItem_details>
					endif
					if not GotParam demo_loop
						if GotParam SpecialSounds
							Obj_SpawnScript <SpecialSounds> //spawn a script to play special trick streams
						endif		
						
						if GotParam Stream
							Obj_PlayStream <stream> vol=250
						endif
					endif
					
					// In Anim
					if not ( <speed> = 0 )
						if not ( <have_played_real_anim> = 0 )
							Obj_PlayAnim { Anim=<anim> Speed=<speed> From=<from_seconds> }
						else
							Obj_PlayAnim { Anim=<anim> Speed=<speed> From=<from_seconds> blendperiodpercent=0 }
						endif
					endif
					
					// Params for grab out anim
					if not IsArray <trick>
						Out_Params = ( <trick>.Params )
					else
						Out_Params = ( (<trick>[0]).Params )
					endif
					
					/*If GotParam ExtraTricks
						// Set up the "tweak" grab for this grab
						SetExtraTricks tricks=<extratricks> duration=15
					endif*/
					
					if not ( <speed> = 0 )
						// Wait for in anim to finish
						WaitAnimFinished
					endif
					
					//Idle Anim
					if not ( <idletime> = 0 )
						// play idle and wait the specified idle time
						Obj_PlayAnim Anim=<idle> cycle xblendperiodpercent=0
						wait <idletime> seconds
						
						if ( <index> = <tweak_grab> )
							// grab with holdable idle
							// continue waiting until button is released
							if not GotParam demo_loop
								begin
									// checking for square and circle since trick could be mapped to either
									If Released Circle
										If Released Square
											break
										endif
									endif 
									
									// increment the score while holding grab
									CAT_GetHoldTime skater=<currentSkaterProfileIndex>
									CAT_SetHoldTime ( <cat_hold_time> + (1.0/60.0) ) skater=<currentSkaterProfileIndex>
									WaitOneGameFrame
									TweakTrick GRABTWEAK_MEDIUM
								repeat
								CAT_GetHoldTime skater=<currentSkaterProfileIndex>
								printf "	cat_hold_time = %c" c=<cat_hold_time>
							endif
						endif
					endif
					
					// Out Anim
					CATReleased_SquareOrCircle <Out_Params> speed=<speed2> To=<to_seconds> blend=(100*<blend>) ;blend=(<speed2>*<blend>)
				else
					// fliptrick
                    if not IsArray <trick>
						anim = (<trick>.Params.anim)
					else
						anim = ((<trick>[0]).Params.anim)
					endif
					
					if not GotParam anim
						if StructureContains structure=(<trick>.Params) initanim
							anim = (<trick>.Params.initanim)
						else
							printf "back trick... no anim"
							return
						endif
					endif
					
                    Percent=((<animation_info>[<index>]).percent)
					if ( <percent> > 1 )
						percent = 1
					endif
					
					GetAnimLength anim=<anim>
					
					from_seconds = ( <from> * <length> * 60 )
					to_seconds = ( <percent> * <length> * 60 )
					total_percent = ( <percent> - <from> )
					if not ( <dur> = 0 )
						speed = ( ((<length> * <total_percent>)) / <dur> )
					else
						speed = 1
					endif
					
					if ( 0 > <speed> )
						speed = ( <speed> * -1 )
					endif
					
					if ( <backwards> = 1 )
						temp=<to_seconds>
						to_seconds=<from_seconds>
						from_seconds=<temp>
					endif
					
                    if not ( <start> = 0 )
						wait <start> seconds
					endif
					
					if GotParam SpecialItem_details
						printf "I have a special item"
						TurnOnSpecialItem SpecialItem_details=<SpecialItem_details>
					endif
					if not GotParam demo_loop
						if GotParam SpecialSounds
							Obj_SpawnScript <SpecialSounds> //spawn a script to play special trick streams
						endif		
						
						if GotParam Stream
							Obj_PlayStream <stream> vol=250
						endif
					endif
					
					;blend_seconds = ( <blend> * <speed> )
					
					// is this the first anim in the trick
					if ( <have_played_real_anim> = 0 )
                        blendperiodpercent=0
					else
                        blendperiodpercent=(<blend>*100)
					endif
					
                    if not ( <speed> = 0 )
                        Obj_PlayAnim { Anim=<anim> Speed=<speed> blendperiodpercent=<blendperiodpercent> From=<from_seconds> To=<to_seconds> }
					endif
				endif
				
				// set flag for fliptricks where the board ends up 180 off
				if IsArray <trick>
					trick_params = ((<trick>[0]).Params)
				else
					trick_params = (<trick>.Params)
				endif
				
				if StructureContains BoardRotate structure=<trick_params>
					BlendperiodOut 0
					if not GotParam demo_loop
						BoardRotateAfter
					endif
				endif
				
				if StructureContains RotateAfter structure=<trick_params>
					printf "skater should flip"
					BlendperiodOut 0
					;RotateAfter
					flip_skater=1
				endif
				
				If StructureContains FlipAfter structure=<trick_params>
					BlendperiodOut 0	
                    if not GotParam demo_loop
						Flip
					else
                        Obj_Flip
						if ( demo_flipped_cat_skater = 0 )
							change demo_flipped_cat_skater=1
						else
							change demo_flipped_cat_skater=0
						endif
					endif
				endif
				
				anims_played_this_trick = ( <anims_played_this_trick> + 1 )
				have_played_real_anim=1
				// Check if this is the last anim
				GetCurrentSkaterProfileIndex
				CAT_GetNumAnims skater=<currentSkaterProfileIndex>
				printf "	played %p / %o anims" p=<anims_played_this_trick> o=<num_animations_on>
				if not ( <anims_played_this_trick> = <num_animations_on> )
					if not GotParam speed2 ;( <got_idle> = 0 )
						// fliptricks
						if not ( <speed> = 0 )
							WaitAnimFinished
						endif
					else
						// grabs
						if not ( <speed2> = 0 )
							WaitAnimFinished
						endif
					endif
					
					if GotParam flip_skater
						// rotate the skater
						if not GotParam demo_loop
							rotate y=180
						else
							Obj_SetOrientation Y=180
						endif
						RemoveParameter flip_skater
					endif
				endif
			endif // sounds
		endif		
		
		RemoveParameter anim
		RemoveParameter outanim
        RemoveParameter out_length
		RemoveParameter in_ratio
		RemoveParameter out_ratio
		RemoveParameter percent
		RemoveParameter speed2
		
		RemoveParameter SpecialItem_details
		RemoveParameter SpecialSounds
		RemoveParameter Stream
		
		count = ( <count> + 1 )
	repeat <array_size>
	
	
	// At this point the last anim in the trick should be playing...
	Obj_Spawnscript are_cat_anims_done params={ flip_skater=<flip_skater> demo_loop=<demo_loop> }
	
    printf "	finished CAT anim"
	
endscript

script are_cat_anims_done
    if not GotParam no_wait
		WaitAnimFinished
	endif
    TurnOffSpecialItem
	if GotParam flip_skater
		if not GotParam demo_loop
			rotate y=180
		else
            // do nothing.. it's the end of the trick.
		endif
	endif
    GetCurrentSkaterProfileIndex
	CAT_SetAnimsDone 1 skater=<currentSkaterProfileIndex>
endscript

script trick_got_idle
	// Determine if trick has an idle anim
	if IsArray <trick>
		if StructureContains structure=((<trick>[0]).Params) idle
			got_idle=1
		else
			got_idle=0
		endif
	else				
		if StructureContains structure=(<trick>.Params) idle
			got_idle=1
		else
			got_idle=0
		endif
	endif
	
	return got_idle=<got_idle>
endscript

script CATReleased_SquareOrCircle from=0
	printf "		script CATReleased_SquareOrCircle"
    if ( <speed> = 0 )
		return
	endif
	
	//check to see if there's a specific OutAnim
	If GotParam OutAnim
		printf "			OutAnim"
        Obj_PlayAnim Anim=<OutAnim> BlendPeriodPercent=<blend> speed=<speed> From=<from> To=<to>
	else
		If GotParam BackwardsAnim
			printf "			BackwardsAnim"
			Obj_PlayAnim Anim=<BackwardsAnim> Backwards BlendPeriodPercent=<blend> speed=<speed> From=<from> To=<to>
		else    
			If AnimEquals Airwalk
				printf "			Airwalk"
				//check to see if we've hit the idle, if not, reverse playback otherwise... 
				Obj_PlayAnim Anim=<Anim> From=Current To=0 BlendPeriodPercent=<blend> speed=<speed>
			else					
				//we need to start playing the in anim backwards right away
				printf "			Other"
				Obj_PlayAnim Anim=<Anim> Backwards speed=<speed> From=<from> To=<to> BlendPeriodPercent=<blend>
			endif
		endif
	endif
endscript

/////////////////////////////////////////
// SOUNDS?
////////////////////////////////////////

script spawned_cat_sound_script
	if not ( <start> = 0 )
		wait <start> seconds
	endif
    if GotParam Stream
		Obj_PlayStream <stream> vol=250
	endif
endscript


/////////////////////////////////////////////////////////////////////////////////////////////////
//  MISC CAT SCRIPTS
/////////////////////////////////////////////////////////////////////////////////////////////////

// @script | waitforbailoff | used to trigger bailoff 
// after trick is 80% complete

script waitforbailoff ;bail_point=0.333
    time_passed=0.000
    
	// turn of bailing for last 20% of trick
	bail_point = ( <time> * 0.2 )
	time=( <time> - <bail_point> )
	GetCurrentSkaterProfileIndex
	
	CAT_GetHoldTime skater=<currentSkaterProfileIndex>
	printf "	cat_hold_time=%c time=%t bail_point=%b" c=<cat_hold_time> t=<time> b=<bail_point>
	
	begin
		if ( ( <time_passed> > (<time> + <cat_hold_time>) ) || ( <time_passed> = (<time> + <cat_hold_time>) ) )
			break
		endif
		WaitOneGameFrame
		time_passed = ( <time_passed> + (1.0/60.0) )
		CAT_GetHoldTime skater=<currentSkaterProfileIndex>
	repeat
	
	printf "	time_passed = %t" t=<time_passed>
    CAT_SetBailDone 1 skater=<currentSkaterProfileIndex>
endscript

script cat_update_trick_string
	Wait 15 gameframes
	
	; FormatText textname=NameText "\c3%i\c0" i=<Name>
	if ( <name> = "" )
		name="Created Trick"
	endif
	SetTrickName <Name>
	
    cat_get_score_from_bailtime bailtime=<bailtime> can_spin=<can_spin>
    
	SetTrickScore <Score>
	Display cat
	// if we're in the middle of an extra trick play some sound and lights
	// not really useful at the moment...
	LaunchSpecialMessage
endscript

// @script | created_trick_cleanup | kills spawned scripts when skater bails
script created_trick_cleanup
    ;printf "CLEANING UP CAT"
    KillSpawnedScript name=CreateATrick
	change cat_done=1
    KillSpawnedScript name=RotateOnAxis
	KillSpawnedScript name=spawned_trick_anim
	KillSpawnedScript name=spawned_cat_sound_script
	KillSpawnedScript name=waitforbailoff
	KillSpawnedScript name=cat_update_trick_string
	
	// Kill Rotations, but make sure skater lands facing the right direction
	CancelRotateDisplay
	CAT_GetFlipSkater skater=<currentSkaterProfileIndex>
    if ( <cat_flip_skater_180> = 1 )
        CAT_SetFlipSkater 0 skater=<currentSkaterProfileIndex>
		rotate y=180
	endif
	
    TurnOffSpecialItem
    CanSpin
	
	if ScreenElementExists id=timeline_anchor
		DestroyScreenElement id=timeline_anchor
	endif
	
endscript

// debbuger thing
script checkbailon
	if BailIsOn
		printf "BAIL IS ON"
	else
		printf "BAIL IS OFF"
	endif
endscript


/////////////////////////////////////////////////////////////////////////////////////////////////
// C CLASS ACCESS FUNCTIONS
/////////////////////////////////////////////////////////////////////////////////////////////////

script set_new_rot_values trick_index=0
	printf "script set_new_rot_values"
	
	GetCreateATrickRotations skater=0 trick_index=<trick_index>
	SetArrayElement ArrayName=rotation_info index=<rot_index> newvalue={ on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
    SetCreateATrickRotations {	trick_index=<trick_index>
								rotation_info=<rotation_info>
							 }
endscript

script quick_set_anim_values
	set_new_anim_values { anim_index=<anim_index> on=<on> trick=<trick> anim=<anim> dur=<dur> percent=<percent> blend=<blend> from=<from> trickType=<trickType> idletime=<idletime> start=<start> order=<order> hold=<hold> backwards=<backwards> }
endscript

script set_new_anim_values trick_index=0
	printf "script set_new_anim_values"
	
	GetCreateATrickAnimations trick_index=<trick_index>
	SetArrayElement ArrayName=animation_info index=<anim_index> newvalue={ on=<on> trick=<trick> dur=<dur> percent=<percent> blend=<blend> from=<from> trickType=<trickType> idletime=<idletime> start=<start> order=<order> hold=<hold> backwards=<backwards> }
    SetCreateATrickAnimations { 
								trick_index=<trick_index>
								animation_info=<animation_info>
							  }
endscript

script set_new_CAT_param_values
	printf "script set_new_CAT_param_values"
    
    other_params = { name=<name> can_spin=<can_spin> full=<full> }
	
	SetCreateATrickOtherParams {    trick_index=<trick_index>
									other_params=<other_params>
							   }
endscript

script get_CAT_param_values trick_index=0
	printf "script get_CAT_param_values"
    
    if GetCreateATrickParams { trick_index=<trick_index> }
		Name = ( <other_params>.name )
		can_spin = ( <other_params>.can_spin )
		full = ( <other_params>.full )
		
		return <...>
	endif
endscript

script get_CAT_rot_values trick_index=0 rot_index=0
	printf "script get_CAT_rot_values"
    
    if GetCreateATrickRotations { trick_index=<trick_index> }
		return (<rotation_info>[<rot_index>])
	endif
endscript

script get_CAT_anim_values trick_index=0 anim_index=0
	printf "script get_CAT_anim_values"
    
    if GetCreateATrickAnimations {  trick_index=<trick_index> }
		return (<animation_info>[<anim_index>])
	endif
endscript

script get_CAT_other_param_values
	printf "script get_CAT_other_param_values"
    
    if GetCreateATrickOtherParams { trick_index=<trick_index> }
		Name = ( <other_params>.name )
		can_spin = ( <other_params>.can_spin )
		full = ( <other_params>.full )
		return <...>
	endif
endscript

script print_out_cat index=0
	get_CAT_param_values trick_index=<index>
	printstruct <...>
endscript

script print_out_cat2 index=1
	get_CAT_other_param_values trick_index=<index>
	printstruct <...>
endscript

////////////////////////////////////////////////////////////////////////////
// Premade CATS
// on=0 is hidden
// on=1 is enabled
// on=2 is disabled
// from = 0-100%
// percent (to) = 0-100%
// TrickType: 0=fliptrick 1=grab 2=special 3=other    
Premade_CATS = 	[
					{ 	name="Bender Flip"
						can_spin=1
						full=1
						
						rotation_info = [
											{ on=1 Axis=z Deg=360 Dur=1.1 start=CAT_BLEND deg_dir=0 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
					   animation_info = [
											{ on=1 trick=Trick_FlyingSquirrel dur=1.6 blend=CAT_BLEND from=0 percent=1 trickType=2 idletime=0 start=0 order=1 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=2 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
					}
					
					{ 	name="Nut Buster"
						can_spin=1
						full=1
						
						rotation_info = [
											{ on=1 deg=360 axis=z dur=1.0 start=0.0 deg_dir=0 }
											{ on=1 deg=180 axis=y dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 deg=360 axis=y dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 deg=360 axis=y dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 deg=360 axis=y dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 deg=360 axis=y dur=1.0 start=0.0 deg_dir=1 }
										]                                        
					   animation_info = [
											{ on=1 trick=Trick_SackTap dur=0.899999 percent=1.0 blend=CAT_BLEND from=0.5 trickType=1 idletime=0.1 start=0 order=1 hold=1 backwards=0 }
											{ on=2 trick=Trick_SackTap dur=0.500000 percent=1.0 blend=CAT_BLEND from=0.5 trickType=1 idletime=0 start=0 order=2 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]                                   
					}
					
					{ 	name="Soul Skating"
						can_spin=0
						full=1
						
						rotation_info = [
											{ on=1 Axis=y Deg=720 Dur=1.3 start=0.0 deg_dir=0 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
					   animation_info = [
											{ on=1 trick=Trick_Seatbelt dur=0.3 blend=CAT_BLEND from=0 percent=0.5 trickType=1 idletime=0.4 start=0 order=2 hold=0 backwards=0 }
											{ on=1 trick=Extra360ShoveIt dur=0.6 blend=CAT_BLEND from=0.26 percent=1 trickType=0 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=1 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
					}
					
					{ 	name="Heelflip Barrel"
						can_spin=0
						full=1
						
						rotation_info = [
											{ on=1 Axis=z Deg=180 Dur=1.0 start=0.0 deg_dir=0 }
											{ on=1 Axis=z Deg=180 Dur=0.5 start=0.8 deg_dir=0 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
					   animation_info = [
											{ on=1 trick=trick_QuadrupleHeelFlip dur=0.8 blend=CAT_BLEND from=0 percent=1 trickType=2 idletime=0 start=0 order=1 hold=0 backwards=0 }
											{ on=1 trick=Trick_Heelflip dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=0 idletime=0 start=0 order=2 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
					}
					
					{ 	name="Layback Casper"
						can_spin=1
						full=1
						
						rotation_info = [
											{ on=1 Axis=x Deg=180 Dur=1.5 start=0.0 deg_dir=1 }
											{ on=1 Axis=x Deg=180 Dur=0.5 start=1.0 deg_dir=0 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
					   animation_info = [
											{ on=1 trick=Trick_AirCasperFlip dur=1.1 blend=CAT_BLEND from=0 percent=1 trickType=2 idletime=0.4 start=0 order=1 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=2 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
					}
					
					{ 	name="360 BodyVarial Kickflip"
						can_spin=0
						full=1
						
						rotation_info = [
											{ on=1 Axis=y Deg=360 Dur=0.6 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
					   animation_info = [
											{ on=1 trick=Extra_VarialKickflip dur=0.6 blend=CAT_BLEND from=0 percent=1 trickType=0 idletime=0 start=0 order=1 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=2 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
					}
					
					{ 	name="Double Barrel"
						can_spin=1
						full=1
						
						rotation_info = [
											{ on=1 Axis=z Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
					   animation_info = [
											{ on=1 trick=Trick_BarrelRoll dur=1.1 blend=CAT_BLEND from=0 percent=1 trickType=2 idletime=0 start=0 order=1 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=2 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
					}
					
					{ 	name="Kickflip Method"
						can_spin=1
						full=1
						
						rotation_info = [
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
					   animation_info = [
											{ on=1 trick=CATTrick_KickflipBS dur=0.3 blend=CAT_BLEND from=0 percent=1 trickType=0 idletime=0 start=0 order=1 hold=0 backwards=0 }
											{ on=1 trick=Trick_Method dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0.1 start=0 order=2 hold=1 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
					}
					
					{ 	name="Flamingo Twist"
						can_spin=0
						full=1
						
						rotation_info = [
											{ on=1 Axis=y Deg=360 Dur=0.7 start=0.2 deg_dir=0 }
											{ on=1 Axis=y Deg=360 Dur=0.6 start=0.9 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
					   animation_info = [
											{ on=1 trick=Trick_Flamingo dur=1.5 blend=CAT_BLEND from=0 percent=1 trickType=2 idletime=0 start=0 order=1 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=2 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
					}
					
					{ 	name="Misty In Back Out"
						can_spin=0
						full=1
						
						rotation_info = [
											{ on=1 Axis=z Deg=360 Dur=0.8 start=0.0 deg_dir=1 }
											{ on=1 Axis=y Deg=180 Dur=0.8 start=0.0 deg_dir=1 }
											{ on=1 Axis=z Deg=360 Dur=0.6 start=0.6 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
											{ on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1 }
										]
										
					   animation_info = [
											{ on=1 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0.7 start=0 order=1 hold=1 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=2 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=3 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=4 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=5 hold=0 backwards=0 }
											{ on=2 trick=trick_indy dur=0.5 blend=CAT_BLEND from=0 percent=1 trickType=1 idletime=0 start=0 order=6 hold=0 backwards=0 }
										]
					}
]