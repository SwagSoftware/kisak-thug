/*
script Motox_OnGroundExceptions
	If not GotParam NoClear
		ClearExceptions
	endif
	If not GotParam NoEndRun
		SetException Ex=RunHasEnded Scr=EndOfRun
		SetException Ex=GoalHasEnded Scr=Goal_EndOfRun
	endif	
	SetException Ex=GroundGone          Scr=Motox_Airborne
	SetException Ex=Ollied              Scr=Motox_Ollie
//	SetException Ex=FlailHitWall        Scr=FlailHitWall
//	SetException Ex=FlailLeft           Scr=FlailLeft
//	SetException Ex=FlailRight          Scr=FlailRight
//	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail    
//	SetException Ex=Skitched            Scr=Skitch
//	SetException Ex=MadeOtherSkaterBail	Scr=MadeOtherSkaterBail
	// Set up Trick for on Ground states
	SetQueueTricks NoTricks 
//	SetExtraGrindTricks special=SpecialGrindTricks GrindTricks	
	SetManualTricks Motox_GroundWheelieTricks
//	SetTags state=skater_onground 	
	// Safety commands to make sure we 
	NollieOff
	VibrateOff
	SwitchOffBoard
	EnablePlayerInput    ;just in case...
	BailOff
	BashOff
	SetRollingFriction default
	CanSpin
	NoRailTricks
	//AllowRailTricks
	SetSkaterCamLerpReductionTimer time = 0      // This puts the camera LERP back to the default value
	Obj_ClearFlag FLAG_SKATER_MANUALCHEESE		// Clear the cheese out
	BloodParticlesOff  
	If not GotParam NoEndRun
		ResetLandedFromVert
	endif	
endscript

script Motox_InAirExceptions
	ClearExceptions
	SetException Ex=Landed      		Scr=Motox_Land
/*	SetException Ex=WallRideLeft     	Scr=WallRide Params={Left}
	SetException Ex=WallRideRight    	Scr=WallRide Params={Right}
	SetException Ex=WallRideBail    	Scr=WallRideBail
	SetException Ex=Carplant			Scr=CarPlant	CallInsteadofGoto  // in case you are in a trick    	
	SetException Ex=CarBail				Scr=CarBail    
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	SetException Ex=MadeOtherSkaterBail	Scr=MadeOtherSkaterBailAir CallInsteadOfGoto
*/	
	//Set up tricks that are available in the air
	SetQueueTricks Motox_AirTricks	
	
//	SetExtraGrindTricks special=SpecialGrindTricks GrindTricks
//	ClearTrickQueues
	SetManualTricks  Motox_WheelieTricks 
	// Safety functions
	LaunchStateChangeEvent State=Skater_InAir
	NoRailTricks
	VibrateOff
	EnablePlayerInput    ;just in case...
	BailOff
	BashOff
	SetRollingFriction	default
	SetState Air
	CanSpin
	OverrideCancelGround Off   // make sure that we have reset this flag properly
endscript


script Motox_OnGroundAI Coasting=0 Pushes=0 direction = 0
  	ClearPanel_Landed
//	SetSpeed 800
	// SetState Ground will clear trigger status, so only do this if we are in another state
	if not OnGround
		SetState Ground ; Set the physics to be ground physics, in case coming here from bailing off a rail.
	endif
	Motox_OnGroundExceptions	
	MotoxBike:Obj_EnableAnimBlending enabled=1
	begin	
		// CheckforSwitchVehicles newscript=OnGroundAi   
		GetSlope 	
		GetSpeed
		if LeftPressed
				PlayAnim Anim=Ped_MotorX_TurnLeft NoRestart BlendPeriod=0.3
				MotoxBike:Obj_PlayAnim Anim=MotorX_TurnLeft NoRestart BlendPeriod=0.3
				direction = 1
				if held r1 				
					Skid
				endif	   		
        else
			if RightPressed
				PlayAnim Anim=Ped_MotorX_TurnRight  NoRestart BlendPeriod=0.3				  
				MotoxBike:Obj_PlayAnim Anim=MotorX_TurnRight NoRestart BlendPeriod=.3  
				direction = 2
				if held r1
					Skid
				endif			
			else
				switch <direction>
				case 1
					PlayAnim Anim=Ped_MotorX_TurnLeft From=Current To=Start  BlendPeriod=0.3
					MotoxBike:Obj_PlayAnim Anim=MotorX_TurnLeft From=Current To=Start  BlendPeriod=0.3
				case 2
					PlayAnim Anim=Ped_MotorX_TurnRight  From=Current To=Start  BlendPeriod=0.3				  
					MotoxBike:Obj_PlayAnim Anim=MotorX_TurnRight From=Current To=Start  BlendPeriod=.3  		
				default
					PlayAnim Anim=Ped_MotorX_Idle Cycle BlendPeriod=0.3  
					MotoxBike:Obj_PlayAnim Anim=MotorX_Idle Cycle BlendPeriod=.3     
				endswitch
			endif
		endif
		
		//Check for Acceleration
		If Held X 
			If (<speed> < 500)
				Skid
			endif	
		endif
		
		// Check for Braking
		if Held Square
			DoBrake	Amount=30
		endif
		                                   
		DoNextTrick
		DoNextManualTrick
		WaitOneGameFrame
		If InNetgame
			CheckforNetBrake 		   
		endif
		//printf "Coasting= %f" f=<Coasting>
		//printf "Pushes= %f" f=<Pushes>
	repeat
endscript

Script DoBrake Amount=10
	GetSpeed
	If (<speed> > <amount>)
		SetSpeed (<speed> - <amount>)
		Skid
	else
		SetSpeed 0	
	endif
endscript

script Skid
	if isPs2
		if (use_bike_physics)
			TextureSplat size=6 radius=0 forward=42 name="skidtrail_ps2" trail lifetime=45	
			TextureSplat size=6 radius=0 forward=-17 name="skidtrail_ps2" trail lifetime=45	
		else
			TextureSplat size=6 radius=0 bone=Bone_Board_Tail name="skidtrail_ps2" trail lifetime=45	
		endif
	endif	
endscript

script Motox_Ollie OutSpeed=1
	StopSkitch
	If GotParam NoDoNextTrick
	else
		DoNextTrick    // We need to do a last check for any queued up jumptricks, like no complys, and run those if you really meant to do them.
	endif	  
	SetTrickName 'Bunnyhop'
	SetTrickScore 100
	Display //Deferred
	
	; Make sure no ground tricks that might have got queued up go off.
	; Without this, it is possible to get a nocomply if one presses up quickly
	; just before pressing x after landing.
	ClearTrickQueue
	// This kills any D-pad presses older than 100 ms, to prevent "turn" taps from
	// being interpreted as special trick taps, and should help minimize the ever so
	// annoying "specials by accident" bug
	ClearEventBuffer Buttons=Dpad OlderThan=TRICK_PRELOAD_TIME             
	Jump BonelessHeight
	Motox_InAirExceptions
	Vibrate Actuator=1 Percent=50 Duration=.05
	/*If GotParam FromLip
		printf "came from lip=================="
		PlayAnim Anim=<OutAnim> BlendPeriod=0.0
		BlendperiodOut 0
	else    
		If GotParam OutAnim								; this is so some tricks can force their outanim
			PlayAnim Anim=<OutAnim> BlendPeriod=0.3 Speed=<OutSpeed>
		else	
			PlayAnim Anim=Ollie  BlendPeriod=0.0 NoRestart
		endif
	endif    
	If GotParam BoardRotate
		BlendPeriodOut 0
		BoardRotateAfter
	endif
	If GotParam RotateAfter
		RotateAfter
	endif 
	If GotParam FlipAfter
		printf "=========flipping the skater in Ollie"
		FlipAfter
	endif	
	If GotParam NoBlend
		BlendPeriodOut 0
	endif	  
	If GotParam WaitOnOlliePercent
		BailOn
	//	begin
		WaitAnim <WaitOnOlliePercent> percent
	//	repeat
	endif 
	*/  
	BailOff
	PlayAnim Anim=Ped_MotorX_Jump	
	MotoxBike:Obj_PlayAnim Anim=MotorX_Jump BlendPeriod=.3  
	WaitAnimWhilstChecking
	goto Motox_Airborne
endscript

script  Motox_Airborne
	Motox_InAirExceptions
	SetException Ex=Ollied Scr=Motox_Ollie
	PlayAnim Anim=Ped_MotorX_AirIdle Cycle NoRestart BlendPeriod=0.3
	MotoxBike:Obj_PlayAnim Anim=MotorX_AirIdle Cycle NoRestart BlendPeriod=.3
	begin
		; If the player has been airborne for longer than a certain time after the
		; ground went, disable the ollie and ground tricks.
		if AirTimeGreaterThan Skater_Late_Jump_Slop
			ClearException Ollied
		endif 
		DoNextTrick 
		WaitOneGameFrame
	repeat	
endscript


script Motox_Land
	//check for sideways landing
	SetState Ground
/*	If AbsolutePitchGreaterThan 60
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
*/	
	if backwards
	endif	
	ClearPanel_Landed	
	If Flipped
		Flip
	endif			
	DoNextManualTrick
	ClearTrickQueue
	Motox_OnGroundExceptions
	PlayAnim Anim=Ped_MotorX_Land NoRestart BlendPeriod=0.1
	MotoxBike:Obj_PlayAnim Anim=MotorX_Land NoRestart BlendPeriod=0.1
    begin
		DoNextManualTrick
		Wait 1 gameframe
	repeat 10
	Goto Motox_OnGroundai    		
endscript

Motox_WheelieTricks=
[
	{Trigger={InOrder,Up,Down,400} Duration=700		Scr=Motox_Wheelie  }
    {Trigger={InOrder,Down,Up,400} Duration=700  	Scr=Motox_Wheelie}
]


Motox_GroundWheelieTricks=
[
// Special array with tighter triggering for when you are on the ground		
	{Trigger={InOrder,Up,Down,220}		Scr=Motox_Wheelie }
    {Trigger={InOrder,Down,Up,220}		Scr=Motox_Wheelie }   
]


script Motox_Wheelie BlendPeriod=0.3 OffMeterTop=Motox_onGroundAi OffMeterBottom=Motox_onGroundAi  
	SetTrickName ""
	SetTrickScore 0
	Display Blockspin
	ClearExceptions
	ResetLandedFromVert
	KillExtraTricks
	SetException Ex=GroundGone          Scr=Motox_AirBorne
	SetException Ex=Ollied          	Scr=Motox_Ollie
//	SetException Ex=FlailHitWall        Scr=FlailHitWall
//	SetException Ex=FlailLeft           Scr=FlailLeft
//	SetException Ex=FlailRight          Scr=FlailRight
//	SetException Ex=OffMeterTop			Scr=<OffMeterTop> Params={<...>}
//	SetException Ex=OffMeterBottom		Scr=<OffMeterBottom> Params={<...>}
	OnExceptionRun CheckForNewTrick_ManualOut
//	SetTags state=skater_inmanual
	SetQueueTricks NoTricks ; Hmmm, this is to stop transitioning from manual <-> nosemanual when quickly pressing
							; up and down when balancing. Would one still want to be able to do boneless etc out of a manual though?
	
    SpawnClothingLandScriptHalfMax // when we start a manual link trick, wobble the boobs at 50% of the max
	
	; If re-entering this script by doing a special manual out of the initial manual, then don't
	; check for special manuals again, otherwise the yellow text will get cancelled and it will be possible
	; to special-manual out of the special-manual making it glitch.
	if gotparam isspecial
		SetManualTricks NoTricks
	else
		if gotparam isextra
			SetManualTricks NoTricks
		else    
			SetManualTricks NoTricks Special=SpecialManualTricks
		endif    
	endif    
	
	StartBalanceTrick           ; Mick .. added this so code think you are in a manual for the "init" animation
	
	If not IsNGC
		Vibrate Actuator=1 Percent=25                      
	endif
	  
	If GotParam IsSpecial
			DoBalanceTrick ButtonA=Up ButtonB=Down Type=Manual Tweak=5
	else  
			DoBalanceTrick ButtonA=Up ButtonB=Down Type=Manual Tweak=1
	endif	 
	
	//PlayAnim Anim=<InitAnim>   BlendPeriod=0.3
	// Time to fight the manual cheesers
	
	// Original manual had lots of cheese fighting  
	
	WaitAnim MANUAL_DISPLAY_WAIT frames //all other freestyle tricks wait a bit longer, to stop button mashing cheese  
	
	SetTrickName "Wheelie"
	SetTrickScore 1000
	Display	Blockspin
	
	If GotParam IsSpecial
		LaunchSpecialMessage
	endif 
	If GotParam IsExtra
		LaunchExtraMessage
	endif	
	
	//WaitAnimFinished	
		
	; If not currently in a special manual, do a quick check to see if any got triggered during the
	; first part of the init anim.
	; The if's probably are not necessary because the special manual array would not even be being checked
	; but they're just for safety.
	if gotparam isspecial
	else
		if gotparam isextra
		else
			donextmanualtrick
		endif    
	endif
	PlayAnim Anim=Ped_MotorX_Wheelie  //wobble  wobbleparams=Manual_wobble_params  
	MotoxBike:Obj_PlayAnim Anim=MotorX_Wheelie //wobble  wobbleparams=Manual_wobble_params   
endscript


Motox_AirTricks=
[
    // Now, the trick is referred to via its trick slot.
	  
    {Trigger={AirTrickLogic,Circle,Up,500}   			Scr=Motox_Flip }	    
	{Trigger={AirTrickLogic,Circle,Down,500}    		Scr=Motox_Flip }
    {SwitchControl_Trigger    					Scr=CheckforSwitchVehicles }
//  {Trigger={AirTrickLogic,Circle,Right,500}  			TrickSlot=Air_CircleR }
//    {Trigger={AirTrickLogic,Circle,Left,500}    		TrickSlot=Air_CircleL }


]

script Motox_Flip
	// printstruct <...>
	LaunchStateChangeEvent State=Skater_InAir
  
//	printf "anim Speed = %F" f=<speed>
	; Clear any jump tricks that might have got queued up.
	; Note this does not clear everything in the trick queue, just tricks from
	; the arrays specified.	
	ClearTricksFrom Jumptricks Jumptricks0 Jumptricks
	// CheckForOllie	;no longer needed
	KillExtraTricks
	//ClearManualTrick		; if a manual got queued up before this trick, cancel it
	//ClearExtraGrindTrick	; ditto for special grinds
	BailOn
	NoSpin  
	RotateDisplay Y Duration = 1 seconds StartAngle = 0.0 EndAngle = -360.0 SinePower = 1 RotationOffset = (0,90,0)
	SetTrickName <Name>
	SetTrickScore <Score>
	Display
	; if we're in the middle of an extra trick play some sound and lights
	If GotParam IsExtra
		LaunchExtraMessage
	endif
	If GotParam IsSpecial
		LaunchSpecialMessage Cool 
	endif	 	

	SetTrickName "360 Spin"
	SetTrickScore 500
	Display
	
	Wait 1 Second
	Bailoff
	DoNextTrick
	CanSpin
	goto Motox_Airborne
endscript 
*/
