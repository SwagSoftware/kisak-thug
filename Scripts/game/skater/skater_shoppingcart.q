// start autoduck documentation
// @DOC skater_shoppingcart
// @module skater_shoppingcart | None
// @subindex Scripting Database
// @index script | skater_shoppingcart


// @script | ShoppingCart_Start | use makeskatergoto shoppingcart_start to put the skater in race mode; make sure to use makeskatergoto shoppingcart_start params={your_params} to use the optional commands below. Reset the skater out of shopping cart mode by using MakeSkaterGoto SkaterInit 
// @parm name | racemode | the racing mode to be in. Current choices are: shoppingcart, luge, and slalom
// @parmopt int | startspeed | 400 | The speed you want the skater to start at use Makeskatergoto ShoppingCart_Start Params={startspeed=x}
// @parmopt int | bailspeed | 0 | If the skater is rolling at a speed greater than this and hits a wall, make him bail. By default any collision will make the skater bail
// @parmopt name | Carmode |  | Send this flag if you want the skater to be able to brake and ato pply friction when turning
// @parmopt float | turn_friction | 4 | If in Car Mode, apply this rolling friction when we are turning. Default is 4.
// @parmopt float | accelerate_to | 800 | If in Car Mode, accelerate up to this speed when the player is doing nothing
// @parmopt float | acceleration | 10 | amount of speed to add to the skaters current speed per frame, if he is below the accelerate_to value

script ShoppingCart_Start startspeed=600 turn_friction=4 accelerate_to=800 acceleration=10.0
	
	// store any values that have been passed in for use by other shopping cart scripts
	// this is so if the designers want a custom accelerate_to speed, the other scripts in the
	// shooping cart ai loop will know about it and be able to retrieve it
	// much better, in theory than manually passing the parameters all over the scripts
	SetTags startspeed=<startspeed> turn_friction=<turn_friction> accelerate_to=<accelerate_to> bailspeed=<bailspeed> acceleration=<acceleration> racemode=<racemode>
	// printstruct <...>
	ClearExceptions
  
	SetException Ex=GroundGone          Scr=Cart_Airborne
	SetException Ex=FlailHitWall        Scr=Cart_Flail
	SetException Ex=FlailLeft           Scr=Cart_Flail
	SetException Ex=FlailRight          Scr=Cart_Flail
	
	if flipped  //to fix Rodney Mullen problem
		Flip
	endif		
	
	switch <racemode>
	case shoppingcart	
		CanBrakeOff
		ForceAutokickOff
		// get the geo in place
		printf "LOCKING CART"
		kill name=ago_ShoppingCart
		create name=ago_ShoppingCart
		ago_ShoppingCart:Obj_LockToObject ObjectName=skater (2,4,0) 			
	default	
		ClearSkaterCamOverride
		CanBrakeOn
		ForceAutoKickOn	
		// set an object Flag so we know we are in carmode while travelling through other ai scripts
		// in this mode
		Obj_SetFlag FLAG_SKATER_CARMODE 
	endswitch
	
	NoRailTricks	
	VibrateOff
	SwitchOnBoard
	Obj_KillSpawnedScript name=BailBoardControl
	ClearEventBuffer
	EnablePlayerInput    ;just in case...
	BailOff
	BashOff
	SetRollingFriction 0
	
	SetSpeed <startspeed>
	Blendperiodout 0

	PlayShoppingCartStartAnim
	Goto ShoppingCart_OnGround 
endscript

script PlayShoppingCartStartAnim
	GetTags
	switch <racemode>
	case shoppingcart
		SetSkaterCamOverride heading=2 tilt=-.2 time=0.000001	
		PlayAnim Anim=Trolley_PushFromStand BlendPeriod=0
		WaitAnimFinished
		ClearSkaterCamOverride
			PlayAnim Anim=Trolley_Push BlendPeriod=0 
			WaitAnimFinished
		PlayAnim Anim=Trolley_JumpIn BlendPeriod=0
		WaitAnimfinished
	case luge		
        PlayAnim Anim=Luge_Push
        WaitAnimFinished
	case slalom
		PlayAnim Anim=Slalom_Push
        WaitAnimFinished			
	endswitch
endscript


script ShoppingCart_OnGround 	    
	SetException Ex=Ollied              Scr=Cart_Ollie
	overridelimits max = 10000 friction = 0 time = 1000
//	CanSpin
//	AllowRailTricks
	SetSkaterCamLerpReductionTimer time = 0      // This puts the camera LERP back to the default value
//	Obj_ClearFlag FLAG_SKATER_MANUALCHEESE		// Clear the cheese out
//	If GotParam NoEndRun
//	else
//	CanKickOff	
	ResetLandedFromVert
	GetTags
	switch <racemode>
	case shoppingcart
		PlayAnim Anim=Trolley_Idle NoRestart Cycle
		ShoppingCart_OnGround_Loop	
	case luge	
		PlayAnim Anim=luge_Idle NoRestart Cycle	
		CarMode_OnGround_Loop
	case slalom	
		PlayAnim Anim=slalom_Idle NoRestart Cycle
		CarMode_OnGround_Loop
	endswitch
endscript

script ShoppingCart_OnGround_Loop
	Obj_StopSound ShoppingCartLoop 
	Obj_Playsound ShoppingCartLoop 
	begin
		if held left
			PlayAnim Anim=Trolley_IdleToLeanLeft NoRestart
		else
			if held right	
				PlayAnim Anim=Trolley_IdleToLeanRight NoRestart
			else 
				If AnimFinished
					PlayAnim Anim=Random(@Trolley_Idle @Trolley_Idle @Trolley_Idle @Trolley_Idle @Trolley_Idle @Trolley_Idle @Trolley_Idle @Trolley_LookLeft @Trolley_LookRight)
				endif		
			endif
		endif
		wait 1 game frame
	repeat
endscript

script CarMode_OnGround_Loop
	//retrieve any params the designers may have sent into ShopingCart_Start
	GetTags
	begin
		if held left
			SetRollingFriction <turn_friction>            
			switch <racemode>
			case luge
				PlayAnim Anim=Luge_IdleToLeanLeft NoRestart
			case slalom
				PlayAnim Anim=Slalom_IdleToLeanLeft NoRestart
			endswitch
		else
			if held right	
				SetRollingFriction <turn_friction> 			
				switch <racemode>
				case luge
					PlayAnim Anim=Luge_IdleToLeanRight NoRestart
				case slalom
					PlayAnim Anim=Slalom_IdleToLeanRight NoRestart
				endswitch
            else
				if held Down				
					switch <racemode>
					case luge
						PlayAnim Anim=Luge_Brake NoRestart
					endswitch
				else
					switch <racemode>
					case luge
						PlayAnim Anim=Luge_Idle Cycle NoRestart
					case slalom
						PlayAnim Anim=Slalom_Idle Cycle NoRestart
					endswitch
					
                    SetRollingFriction 0
					
					GetSpeed
						// printf "speed from skater = %g" g=<speed>
					
					if (<speed> < <accelerate_to>)
						speed=(<speed> + <acceleration>)					
						// printf "speed=%s" s=<speed>	
					endif
					SetSpeed <speed>
			   endif
			endif
		endif
		wait 1 game frame
	repeat
endscript

script Cart_Bail
	ClearExceptions
	GetTags
	if not LandedFromVert
		switch <racemode>
		case shoppingcart
		case luge
			Jump BonelessHeight
		endswitch	
	endif
	CanBrakeOn
	overridelimits max = 10000 friction = 0 time = 0
	RestoreAutoKick
	ClearSkaterCamOverride	
	// if we came from a flailing fall
	if GotParam BigAir
		Rolling
	endif
	switch <racemode>
	case shoppingcart
		PlaySound ShoppingCartBail
		kill name=ago_ShoppingCart
		Trolley_BailB	
	case slalom
		NoseManualBail
	default
		ManualBail
	endswitch
endscript

script Cart_Flail speed=0 bailspeed=0
	GetTags
	GetSpeed
	If (<speed>  > <bailspeed>)
		Goto Cart_Bail
	else
		switch <racemode>
		case luge
			PlayAnim Anim=Luge_Flail
        case slalom
			PlayAnim Anim=Slalom_Flail		
		endswitch
		WaitAnimFinished
        Goto ShoppingCart_OnGround
	endif		 
endscript

script Cart_Ollie
	ClearException Ollied
	GetTags
	switch <racemode>
	case shoppingcart	
		PlayAnim Anim=Trolley_Ollie
		Jump BonelessHeight
		PlaySound ShoppingCartOllie
	case luge
        PlayAnim Anim=Luge_Ollie
		Jump BonelessHeight
    case slalom	
        PlayAnim Anim=Slalom_Ollie
		Jump 
	endswitch	
	Goto Cart_Airborne
endscript

script Cart_Airborne
	// if on vert bail
	SetException Ex=Landed          Scr=Cart_Land
	SetState Air
	GetTags
	switch <racemode>
	case shoppingcart
		Obj_StopSound ShoppingCartLoop 
		If AnimEquals Trolley_Ollie
			WaitAnimFinished
		endif	 
		PlayAnim Anim=Trolley_AirIdle
		SetTrickName 'Cart Air'
	case luge
		If AnimEquals Luge_Ollie
			WaitAnimFinished
		endif	 
		PlayAnim Anim=Luge_AirIdle            
		SetTrickName 'Luge Hop'
	case slalom
		If AnimEquals Slalom_Ollie
			WaitAnimFinished
		endif	 
		PlayAnim Anim=Slalom_AirIdle  	
		SetTrickName 'Old School Ollie'
	endswitch	
	begin
		If AirTimeGreaterThan .5 seconds	
		ClearException Ollied
			break
		endif	
		wait 1 game frame	
	repeat
	SettrickScore 100
	Display
	// you go really fast in this mode, so if you get huge air
	// kick the board away, otherwise we look silly landing it
	if (<racemode> = slalom)
		begin
			If AirTimeGreaterThan 1.25 seconds
				PlayAnim	Anim=FlailingFall  Blendperiod=.3 Cycle
				SetException Ex=Landed 	Scr=Cart_bail params={BigAir}
				break
			endif
			wait 1 game frame
		repeat
	endif		
endscript

script Cart_Land
	//check for sideways landing
	GetTags
	SetState Ground
	If AbsolutePitchGreaterThan 60
		if PitchGreaterThan 60
			Goto Cart_Bail
		endif	
	endif  	
	if YawBetween (30,150) 			; this is when the skater is perpedicular to direction of travel
		Goto Cart_Bail
	endif
	if RollGreaterThan 50
		Goto Cart_Bail
	endif
	switch <racemode>
	case shoppingcart  
	case luge
		if LandedfromVert
			Goto Cart_Bail
		endif
	endswitch
	if backwards
		switch <racemode>
		case shoppingcart
		case luge
			Goto Cart_Bail
		case slalom
			Rotate
			Flip	
		endswitch
	endif	
	ClearPanel_Landed	
	switch <racemode>
	case shoppingcart
		SetException Ex=Ollied              Scr=Cart_Ollie
		PlaySound ShoppingCartLand		
		If AirTimeGreaterThan 1 seconds
			PlayAnim Anim=Trolley_Land
			WaitAnimFinished
		else
			If AirTimeGreaterThan .1 seconds
				PlayAnim Anim=Trolley_SmallLand	
				WaitAnimFinished
			endif
		endif
    case luge
        PlayAnim Anim=Luge_land        
	case slalom
        PlayAnim Anim=Slalom_land        		
	endswitch	
	SetException Ex=Ollied              Scr=Cart_Ollie
	WaitAnimFinished    
	Goto ShoppingCart_OnGround    		
endscript   

// @script | LugeBrake | use makeskatergoto LugeBrake to make the skater stop 
// @parmopt int | friction | 15 | How fast to stop him, higher value=quicker stop - use Makeskatergoto LugeBrake Params={friction=x}
script LugeBrake friction=15
	ClearExceptions
	DisablePlayerInput
	WaitOnGround
	SetRollingFriction <friction>
	PlayAnim Anim=Luge_Fullstop Blendperiod=0.3
	WaitAnimFinished
	SpeedCheckStop
	Wait 30 frames
	SpeedCheckStop
endscript

