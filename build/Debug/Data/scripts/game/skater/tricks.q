;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CONDITIONS
;
; Any       IsZero
; Skater    LeftPressed
; Skater    RightPressed
; Skater    Crouched
; Skater    Flipped
; Skater    AnimFinished
; Skater    AnimEquals
; Skater    LoopingAnim
; Skater    JumpTriggered
; Skater    OnGround
; Skater    InAir
; Skater    OnWall
; Skater    OnLip
; Skater    OnRail
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FUNCTIONS
;
; Skater    SetException
; Skater    ClearExceptions
; Skater    PlayAnim
; Skater    WaitAnim
; Any       Wait
; Any       JumpToScript
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SCRIPTS
; Skater    PrintState
; Any       goto
; Any       WaitOneGameFrame
; Skater    WaitAnimFinished
; Any       WaitForever
;
ExcludeFromSkaterDebug=
[
	waitonegameframe
	waitanimfinished
	waitanimwhilstchecking
	WaitWhilstChecking
	just_coasting
	DoCrouch_slope
	SetClothesInactive
	SetClothesActive
	ShutDownWindyBone
	PlayLeftRightTennisAnim
	PlayBrakeAnim
	CessBrake
	CheckforSwitchVehicles
	cheese_jump
	PlayTurnAnimOrTurnIdle
	SetException
	SetEventHandler
	ClearException
	ClearOnExceptionRun
	ClearExceptionGroup
	WaitWalking
	WaitAnimWalking
	WaitWalkingFrame
	WaitAnimWalkingFrame
	PlaySpeedChosenAnim
	RunSpeedChosenAnim
	CycleSpeedChosenAnim
	hide_run_timer_piece
	SetExceptionHandler
	PlayWalkAnim
	CheckForNetBrake
]

/////////// ANIM ARRAYS - CHOOSE RANDOMLY FROM THESE SETS TO PLAY IN GAME ////////////////
CrouchIdles = [CrouchIdle CrouchIdle CrouchIdle2 CrouchIdle2 CrouchIdle4 CrouchIdle4 CrouchLookDown CrouchLookLeft CrouchLookRight CrouchShiftFoot CrouchIdleAdjustFeet]
CrouchTurnRightIdles = [CrouchTurnRightIdle CrouchTurnRightIdle2]
CrouchTurnLeftIdles = [CrouchTurnLeftIdle CrouchTurnLeftIdle2]
CrouchTurnRightAnims = [CrouchTurnRight CrouchTurnRight2]
CrouchTurnLeftAnims = [CrouchTurnLeft CrouchTurnLeft2]
TurnRightIdles = [TurnRightIdle ]
TurnLeftIdles = [TurnLeftIdle ]
TurnRightAnims = [TurnRight ]
TurnLeftAnims = [TurnLeft ]

// Expert mode global flags
EXPERT_MODE_NO_REVERTS = 0
EXPERT_MODE_NO_WALKING = 0
EXPERT_MODE_NO_MANUALS = 0
//if GetGlobalFlag flag=EXPERT_MODE_NO_REVERTS

// this is the amount of slop, in degrees, allowed for the player
// to get a perfect landing bonus
perfect_landing_slop = 5

script DumpSkaterEventHandlerTable
	PrintEventHandlerTable
endscript

// skater's exceptions must be cleared while he is being killed
script KillingSkater
	ClearExceptions
	ClearExceptionGroup Group=RunTimerEvents
	ClearExceptionGroup Group=WalkingEndRunEvents
endscript

// This is the script that gets run when the skater is first created, and when reset by a retry, or
// on completion of a goal
// If the skater gets in some unbeknownst state, and you want to make sure he is completely
// reset and cleared out in every way; send him here
script SkaterInit
	// Printf "+++==+++ SkaterInit +++==+++"
	ClearAllExceptionGroups

	if not GotParam no_board
		SwitchOnBoard
	else
		SwitchOffBoard
	endif

	; Do any init stuff here.
	Obj_StopStream

	Unhide
	UnpausePhysics
	NotInBail
	BashOff
	NollieOff
	PressureOff
	//SkaterBloodOff
	NotifyBailDone
	Obj_KillSpawnedScript name=BailBoardControl
	SetSkaterCamLerpReductionTimer time = 0      // This puts the camera LERP back to the default value
	ClearLipCombos
	AllowRailTricks
	Obj_KillSpawnedScript name=SetUpLipCombo
	ClearTrickQueues
	//SetQueueTricks NoTricks

	StatsManager_Reset

	ResetLandedFromVert
	BlendperiodOut 0

	// Exit Pressure Mode
	PressureOff

	;change use_bike_physics=0
	// clean up the Transam
	if Driving
		if (driving_parked_car = 1)
			if not GotParam InCleanup
				car_end_driving_run
			endif
		endif
		ToggleUserControlledVehicleMode
	endif

	InitializeStateChangeEvent
	SetTags racemode=none

	// in case we get respawned and time has already run out on us...
	if Not GotParam NoEndRun
		SetException Ex=RunHasEnded Scr=EndOfRun
		SetException Ex=GoalHasEnded Scr=Goal_EndOfRun
	endif
	StopBalanceTrick
	if	Skitching
		StopSkitch
		setstate ground
	endif
	//SwitchOffAtomic special_item

	SetEventHandler Ex=KillingSkater Scr=KillingSkater Group=KillingSkaterGroup
	SetEventHandler Ex=DumpSkaterEventHandlerTable Scr=DumpSkaterEventHandlerTable Group=DebugSkaterGroup

	VibrateOff
	ClearSkaterFlags		//any temp flags should be reset
	// SetExceptionThatPreservesBalanceTrick MadeOtherSkaterBail  // member function no longer exsists
	// Get the procedural shirt going - see skater_procanim.q
	// Obj_KillSpawnedScript name=WindyClothes
	// Obj_SpawnScript WindyClothes
	// it's possible we were in the middle of something when the boobs were active
	// and we switched levels, so make sure they are inactive
	SetBoneTransActive bone=breast_cloth_zz 0
	If Not GotParam NoAnims
		if not ( in_cinematic_sequence = 1 )
			PlayAnim Anim=Idle
		endif
	endif

	// SetBalanceTrickParams no longer exists, the params can now be set using the BalanceParams
	// parameter in the call to DoBalanceTrick
	//SetBalanceTrickParams ManualParams

	//Particle System setup and clean up
	Obj_KillSpawnedScript name=BloodSmall
	Obj_KillSpawnedScript name=BloodSplat
	Obj_KillSpawnedScript name=SkaterBloodOn

	RunTimerController_Reset

	ResetSkaterParticleSystems

	// Loop physics clean up
	LockVelocityDirection Off
	// shopping cart clean up
	CanBrakeOn
	RestoreAutoKick
	OverrideLimits End
	CleanUpExtraProps
	// We could have used a menu to jump out of a cool special trick, so clean up
	SetSlomo 1
	kill_blur
	KillExtraTricks

	created_trick_cleanup

	//Reset the camera, in case we were tweaking with it when we got reset (like in a dropin)
	ClearSkaterCamOverride
	LandSkaterTricks

	// GJ:  Set up anim event handlers
	set_skater_anim_handlers

	// Now go to the regular AI, if for some reason the C-code or restart script doesn't tell us
	// what to do
	if GotParam ReturnControl
		return
	endif

	if IsBoardMissing
		Walk=1
	endif

	if not GotParam Walk
		Goto Switch_OnGroundAi Params={ NewScript=OnGroundAi Restart }
	else
		Goto Switch_OnGroundAi Params={ NewScript=Walking_OnGroundAi Restart }
	endif
endscript


script CleanUpExtraProps
	if GameModeEquals is_career
		if levelis load_alc
			// here's a funny patch. you must use kill prefix in this case. Why? because kill name=
			// will assert if this is called when the node doesn't exist - like when you are changing
			// levels after playing an in level movie....But kill prefix is a nice warm fuzzy
			// command that doesn't care if the node is there or not.
			kill prefix="ago_ShoppingCart"
		endif
	endif
endscript

; This is the script that gets run when a client skater is first created, and when reset by a retry.
script ClientSkaterInit
	; Do any init stuff here.
	SwitchOffAtomic special_item
endscript

/*
script SkaterRetryScript
	SkaterInit
endscript
*/

// These are the general case ground exceptions, called all over the skater's scripts, and used
// whenever he is in a normal ground state.

script OnGroundExceptions
	// If not GotParam NoClear
	ClearExceptions
	// endif
	SetException Ex=GroundGone          Scr=GroundGone
	SetException Ex=Ollied              Scr=Ollie
	SetException Ex=FlailHitWall        Scr=FlailHitWall
	SetException Ex=FlailLeft           Scr=FlailLeft
	SetException Ex=FlailRight          Scr=FlailRight
	SetException Ex=Carplant			Scr=CarPlant
	SetException Ex=CarBail				Scr=CarBail
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	SetException Ex=Skitched            Scr=Skitch
	SetException Ex=MadeOtherSkaterBail	Scr=MadeOtherSkaterBail
	SetException Ex=WallPush			Scr=Ground_WallPush
	If not GotParam NoEndRun
		SetException Ex=RunHasEnded Scr=EndOfRun
		SetException Ex=GoalHasEnded Scr=Goal_EndOfRun

		if GoalManager_GoalShouldExpire
			// Printf "OnGroundExceptions: GoalManager_GoalExpired returned true - killing ollies"
			ClearException Ollied
			ClearException GroundGone
			ClearException WallPush
			// else
			// Printf "OnGroundExceptions: GoalManager_GoalExpired returned false - allowing ollies"
		endif
	endif

	// Set up Trick for on Ground states

	SetSkaterGroundTricks

	LaunchStateChangeEvent State=Skater_OnGround
	// Safety commands to make sure we
	VibrateOff
	SwitchOnBoard
	EnablePlayerInput    ;just in case...
	BailOff
	BashOff
	SetRollingFriction default
	CanSpin
	AllowRailTricks
	SetSkaterCamLerpReductionTimer time = 0      // This puts the camera LERP back to the default value
	Obj_ClearFlag FLAG_SKATER_MANUALCHEESE		// Clear the cheese out
	BloodParticlesOff
	If not GotParam NoEndRun
		ResetLandedFromVert
	endif
endscript

script SetSkaterGroundTricks
	if inNetGame
		if not GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING
			if not GetGlobalFlag Flag=FLAG_EXPERT_MODE_NO_WALKING
				SetQueueTricks Jumptricks GroundTricks SkateToWalkTricks
			else
				SetQueueTricks Jumptricks GroundTricks
			endif
		else
			SetQueueTricks Jumptricks GroundTricks
		endif
	else
		if not GetGlobalFlag Flag=FLAG_EXPERT_MODE_NO_WALKING
			SetQueueTricks Jumptricks GroundTricks SkateToWalkTricks
		else
			SetQueueTricks Jumptricks GroundTricks
		endif
	endif

	/*if not GetGlobalFlag Flag=FLAG_EXPERT_MODE_NO_WALKING
		if not ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING))
			SetQueueTricks Jumptricks GroundTricks SkateToWalkTricks
		endif
	else
		SetQueueTricks Jumptricks GroundTricks
	endif*/
	SetExtraGrindTricks special=SpecialGrindTricks GrindTricks
	if not GetGlobalFlag Flag=FLAG_EXPERT_MODE_NO_MANUALS
		if not ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_MANUALS))
			SetManualTricks special=SpecialManualTricks GroundManualTricks
		endif
	endif
endscript
// The general case inair exceptions, called all over the script. These are the allowed exceptions
// whenever the skater is in the air, or doing an air trick

script InAirExceptions
	ClearExceptions
	SetException Ex=Landed      		Scr=Land
	SetException Ex=WallRideLeft     	Scr=WallRide Params={Left}
	SetException Ex=WallRideRight    	Scr=WallRide Params={Right}
	SetException Ex=WallPlant			Scr=Air_WallPlant
	SetException Ex=PointRail			Scr=PointRail
	// SetException Ex=WallRideBail    	Scr=WallRideBail
	SetEventHandler Ex=Carplant			Scr=CarPlant  // in case you are in a trick
	SetException Ex=CarBail				Scr=CarBail
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	SetEventHandler Ex=MadeOtherSkaterBail	Scr=MadeOtherSkaterBailAir

	SetSkaterAirTricks

	// Safety functions
	LaunchStateChangeEvent State=Skater_InAir
	if not GotParam AllowVibration
		VibrateOff
	endif
	EnablePlayerInput    ;just in case...
	BailOff
	BashOff
	SetRollingFriction	default
	SetState Air
	CanSpin
	OverrideCancelGround Off   // make sure that we have reset this flag properly
	//KillSpawnedScript name=WindyShirt
	//SpawnSkaterScript WindyShirt
endscript

script SetSkaterAirManualTricks
	If not GetGlobalFlag Flag=FLAG_EXPERT_MODE_NO_MANUALS
		if not ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_MANUALS))
			SetManualTricks special=SpecialManualTricks Manualtricks
		endif
	endif
endscript

script SetSkaterAirTricks
	If InPressure
		if not GotParam NoSkateToWalkTricks
			If ((GetGlobalFlag Flag=FLAG_EXPERT_MODE_NO_WALKING) || ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING)))
				if not GotParam AllowWallplantOllie
					SetQueueTricks special=SpecialTricks PressureTricks2 AirTricks
				else
					SetQueueTricks special=SpecialTricks PressureTricks2 AirTricks WallplantOllie
				endif
			else
				if not GotParam AllowWallplantOllie
					SetQueueTricks special=SpecialTricks PressureTricks2 AirTricks SkateToWalkTricks
				else
					SetQueueTricks special=SpecialTricks PressureTricks2 AirTricks SkateToWalkTricks WallplantOllie
				endif
			endif
		else
			if not GotParam AllowWallplantOllie
				SetQueueTricks special=SpecialTricks PressureTricks2 AirTricks
			else
				SetQueueTricks special=SpecialTricks PressureTricks2 AirTricks WallplantOllie
			endif
		endif
	else
		if not GotParam NoSkateToWalkTricks
			if ((GetGlobalFlag Flag=FLAG_EXPERT_MODE_NO_WALKING) || ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING)))
				if not GotParam AllowWallplantOllie
					SetQueueTricks special=SpecialTricks AirTricks
				else
					SetQueueTricks special=SpecialTricks AirTricks WallplantOllie
				endif
			else
				if not GotParam AllowWallplantOllie
					SetQueueTricks special=SpecialTricks AirTricks SkateToWalkTricks
				else
					SetQueueTricks special=SpecialTricks AirTricks SkateToWalkTricks WallplantOllie
				endif
			endif
		else
			if not GotParam AllowWallplantOllie
				SetQueueTricks special=SpecialTricks AirTricks
			else
				SetQueueTricks special=SpecialTricks AirTricks WallplantOllie
			endif
		endif
	endif
	SetExtraGrindTricks special=SpecialGrindTricks GrindTricks
	SetSkaterAirManualTricks
endscript


script ClearTrickQueues
	ClearTrickQueue
	ClearManualTrick
	ClearExtraGrindTrick
endscript

////////////////////////////////////////////////////////////
// The basic ground AI
////////////////////////////////////////////////////////////
script OnGroundAI Coasting=0 Pushes=0 PressureTimer=0
	// SetState Ground will clear trigger status, so only do this if we are in another state
	if not OnGround
		SetState Ground ; Set the physics to be ground physics, in case coming here from bailing off a rail.
	endif
	OnGroundExceptions

	NollieOff
	begin
		//CheckforSwitchVehicles newscript=Motox_OnGroundAi
		GetSlope
		if LeftPressed
			if Crouched
				If Flipped
					PlayTurnAnimOrTurnIdle TurnIdles=CrouchTurnRightIdles TurnAnims=CrouchTurnRightAnims
				else
					PlayTurnAnimOrTurnIdle TurnIdles=CrouchTurnLeftIdles TurnAnims=CrouchTurnLeftAnims
				endif
			else  //Pressing left and not crouched
				If Flipped
					PlayTurnAnimOrTurnIdle TurnIdles=TurnRightIdles TurnAnims=TurnRightAnims
				else
					PlayTurnAnimOrTurnIdle TurnIdles=TurnLeftIdles TurnAnims=TurnLeftAnims
				endif
			endif
		else
			if RightPressed
				if Crouched
					If	Flipped
						PlayTurnAnimOrTurnIdle TurnIdles=CrouchTurnLeftIdles TurnAnims=CrouchTurnLeftAnims
					else
						PlayTurnAnimOrTurnIdle TurnIdles=CrouchTurnRightIdles TurnAnims=CrouchTurnRightAnims
					endif
				else
					if Flipped
						PlayTurnAnimOrTurnIdle TurnIdles=TurnLeftIdles TurnAnims=TurnLeftAnims
					else
						PlayTurnAnimOrTurnIdle TurnIdles=TurnRightIdles TurnAnims=TurnRightAnims
					endif
				endif
			else
				// no direction pressed
				if Crouched
					DoCrouch_Slope Slope=<Slope> ChangeInSlope=<ChangeInSlope>
				else
					// not crouched
					if Braking
						if	SpeedLessThan	1
							PlayBrakeAnim
							if HeldLongerThan Button=down 2 second
								Goto HandBrake
							endif
						else
							if HeldLongerThan Button=down .2 second
								CessBrake
							else
								PlayBrakeAnim
							endif
						endif
					else
						// not braking
						if (<slope> > PUSH_IF_SLOPE)
							//					printf "GOING UPHILL >>>>>>>>>>>>>>>>>>>>>>>>"
							if AutoKickIsOff
								OnGround_AutoKickOff_UpHill
							else
								// Autokick is on and we CanKick
								if ShouldMongo
									if AnimEquals MongoPushCycle
										PlayAnim Anim=MongoPushCycle Cycle NoRestart
									else
										PlayAnim Anim=MongoPush NoRestart
										WaitAnimFinished
										PlayAnim Anim=MongoPushCycle Cycle NoRestart
									endif
								else
									Just_Coasting
								endif
							endif
						else
							// just cruising along on flat ground
							If AutoKickIsOff
								OnGround_AutoKickOff_Flat
							else
								//autokick is on
								Just_Coasting
							endif
						endif
					endif
				endif
			endif
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

crouch_wobble_params={
	WobbleAmpA  = { (10.1,10.1) STATS_RAILBALANCE } ; was .04 amplitudes get added together to make the range
	WobbleAmpB  = { (10.1,10.1) STATS_RAILBALANCE } ; was .03
	WobbleK1    = { (20,20) STATS_RAILBALANCE }  ; frequency 1
	WobbleK2    = { (10,10) STATS_RAILBALANCE }	 ; frequency 2 - the more different from K1, the more randomness
	SpazFactor  = { (1,1) STATS_RAILBALANCE }	 ; amount the Amps are multiplied by at the ends of the meter
}

script PlayTurnAnimOrTurnIdle
	// If we passed in an array of anims, then use this bit of script
	// which will look at all of the anims passed in and then choose one
	// to play
	// first see if we are playing an idle, in which case do nothing, as they just cycle
	if not AnimEquals <TurnIdles>
		// Then see if we are in a turning anim...If not, pick a random one to play
		If not AnimEquals <Turnanims>
			GetRandomArrayElement <TurnAnims>
			//				printf "I have chosen the anim %a" a=<element>
			PlayAnim Anim=<Element> NoRestart
			// Store the index of the random turn anim so we can use this info to play the correspoding turn idle, below
			SetTags TurnAnimIndex=<index>
			//				printf "Turnidle index1 = %t" t=<index>
		endif
		// Lastly, check to see if the turn anim is finished, and if it is, play a random idle
		if AnimFinished
			GetTags
			index = <TurnAnimIndex>
			PlayAnim Anim=(<TurnIdles>[<index>]) Cycle NoRestart
		endif
	endif
endscript

script DoCrouch_Slope
	//    printf "Slope=%s" s=<Slope>
	//	printf "ChangeInSlope=%c" c=<ChangeInSlope>
	If ((<ChangeInSlope> > 5) || (<ChangeInSlope> < -5))
		If AnimEquals [CrouchBumpUp CrouchBumpDown]
			If AnimFinished
				If (<ChangeInSlope> > 5)
					PlayAnim Anim=CrouchBumpUp Blendperiod=.3
				else
					PlayAnim Anim=CrouchBumpDown Blendperiod=.3
				endif
			endif
		else
			If (<ChangeInSlope> > 5)
				PlayAnim Anim=CrouchBumpUp Blendperiod=.3
			else
				PlayAnim Anim=CrouchBumpDown Blendperiod=.3
			endif
		endif
	else
		// we're cruising on the flat, so let's randomize the crouch anims
		// first check to see if we've come to a stop, and have just released down
		// if so, push off
		If SpeedLessThan 100
			If Released Down
				if not AutoKickIsOff
					PlayAnim Anim=CrouchPush1 NoRestart
				endif
			endif
		endif
		If  AutoKickIsOff
			If SpeedLessThan 600
				If Held Square
					PlayAnim Anim=CrouchPush1 NoRestart
				endif
			endif
		endif
		If Not AnimEquals CrouchIdles CrouchPush1 CrouchBumpUp CrouchBumpDown
			// so we don't interrupt lands and bump up and bump downs
			GetRandomArrayElement CrouchIdles
			PlayAnim Anim=<Element> NoRestart
		else
			If Animfinished
				GetRandomArrayElement CrouchIdles
				PlayAnim Anim=<Element> NoRestart
			endif
		endif
	endif
endscript


SLOPE_CUTOFF=40

PUSH_IF_SLOPE=2

script Just_Coasting
	//	printf "STARTING COASTING"
	GetSlope 	        // it seems faster to recalculate than to pass it in....
	if (<slope> > PUSH_IF_SLOPE)
		if AnimEquals [MongoPushCycle PushCycle PushCycleArms1 PushCycleArms2 PushCycleArms3 PushCycleArms4 PushCycleArms5]
			if AnimFinished
				//				Printf "CAN KICK"
				DoAPush
			endif
		else
			PlayAnim Anim=Idle NoRestart
		endif
	else
		// Not sloped enough
		// If we got a Random push and its still going, do nothing
		// Else, roll the dice again and either do another push, or stop...
		if AnimEquals [MongoPushCycle PushCycle PushCycleArms1 PushCycleArms2 PushCycleArms3 PushCycleArms4 PushCycleArms5]
			If AnimFinished
				RandomPush=RandomRange(1,2)
				If (<RandomPush> < 2)
					DoAPush
				else
					PlayAnim Anim=Idle NoRestart
				endif
			endif
		else
			// if we're idling, roll the dice for a random push
			If AnimEquals Idle
				If AnimFinished
					RandomPush=RandomRange(1,3)
					If (<RandomPush> < 2)
						//                      printf "GOT RANDOM PUSH!"
						DoAPush
					else
						PlayAnim Anim=Idle
						//        					Printf "Stuck here???"
					endif
				endif
				// If none of the above it means we came from another anim (turning, landing etc.)
				// so start plying the idle
			else
				PlayAnim Anim=Idle NoRestart
			endif
		endif
	endif
	//	WaitOneGameFrame
	//	Goto OnGroundAi
endscript

Script DoAPush
	//	printf "Doing a Push"
	If ShouldMongo
		PlayAnim Random(@Anim=MongoPushCycle @Anim=Idle) NoRestart
	else
		if AnimEquals [PushCycle PushCycleArms1 PushCycleArms2 PushCycleArms3 PushCycleArms4 PushCycleArms5]
			if AnimFinished
				PlayAnim Random (@Anim=PushCycle @Anim=PushCycleArms1 @Anim=PushCycleArms2 @Anim=PushCycleArms3 @Anim=PushCycleArms4 @Anim=PushCycleArms5) NoRestart
			endif
		else
			PlayAnim Random (@Anim=PushCycle @Anim=PushCycleArms1 @Anim=PushCycleArms2 @Anim=PushCycleArms3 @Anim=PushCycleArms4 @Anim=PushCycleArms5) NoRestart
		endif
	endif
endscript

script CheckforNetBrake
	If InNetGame
		GetPreferenceChecksum pref_type=network auto_brake
		if( <checksum> = boolean_true )
			if ScreenElementExists id=current_menu_anchor
				Goto NetBrake
			endif
			if ScreenElementExists id=dialog_box_anchor
				Goto NetBrake
			endif
			if ScreenElementExists id=quit_dialog_anchor
				Goto NetBrake
			endif
			if ScreenElementExists id=controller_unplugged_dialog_anchor
				Goto NetBrake
			endif
		endif
	endif
endscript

// This handles the playing of the braking anim
script PlayBrakeAnim
	If ShouldMongo
		PlayAnim Anim=SlowDownBrake_Mongo NoRestart
	else
		PlayAnim Anim=SlowDownBrake NoRestart
	endif
endscript

script CessBrake
	ClearEventBuffer
	If SpeedGreaterThan 300
		PlayAnim Anim=CessSlide180_FS  From=Start To=28 Speed=1.2
		WaitAnim Frame 5
		PlayCessSound
		WaitAnim Frame 25
		PlayAnim Anim=CessSlide180_FS  From=27 To=Start Speed=1.2
		WaitAnimFinished
	endif
	PlayBrakeAnim
endscript

script SlalomBrake
	BigBrake
endscript

script BigBrake
	ClearExceptions
	DisablePlayerInput
	WaitOnGround
	SetRollingFriction 20
	StopSkitch
	StopBalanceTrick
	Cessbrake
	wait 1 second
	goto SkaterInit
endscript

script OnGround_AutoKickOff_UpHill
	// if no autokick, then don't loop that anims
	if ShouldMongo
		if Held Square
			PlayAnim Anim=MongoPush NoRestart
			WaitAnimFinished
			PlayAnim Anim=MongoPushCycle NoRestart
			WaitAnimFinished
		endif
		PlayAnim Anim=Idle Cycle NoRestart
	else
		if Held Square
			PlayAnim Random (@Anim=PushCycle @Anim=PushCycleArms1 @Anim=PushCycleArms2 @Anim=PushCycleArms3 @Anim=PushCycleArms4 @Anim=PushCycleArms5) NoRestart
			WaitAnimFinished
		endif
		PlayAnim Anim=Idle Cycle NoRestart
	endif
endscript

script OnGround_AutoKickOff_Flat
	if held square
		if ShouldMongo
			PlayAnim Anim=MongoPushCycle Cycle NoRestart
		else
			PlayAnim Random (@Anim=PushCycle @Anim=PushCycleArms1 @Anim=PushCycleArms2 @Anim=PushCycleArms3 @Anim=PushCycleArms4 @Anim=PushCycleArms5) NoRestart
			WaitAnimFinished
			PlayAnim Anim=Idle Cycle NoRestart
		endif
	else
		if AnimEquals [PushCycle MongoPushCycle MongoPush]
		else
			PlayAnim Anim=Idle Cycle NoRestart
		endif
	endif
endscript



// This script does a little check to see if you're in a net game and if the menu is up
// if so, we're gonna slow you down and bring you to a halt.

script NetBrake
	SetRollingFriction 20
	OnExceptionRun NetBrake_out
	CessBrake
	begin
		If SpeedLessThan 5
			HandBrake
			if ShouldMongo
				PlayAnim Anim=MongoBrakeIdle Cycle NoRestart
			else
				PlayAnim Anim=BrakeIdle Cycle NoRestart
			endif
		endif
		;If MenuOnScreen
		if ObjectExists id=current_menu_anchor
			WaitOneGameFrame
		else
			if ObjectExists id=dialog_box_anchor
				WaitOneGameFrame
			else
				if ObjectExists id=controller_unplugged_dialog_anchor
					WaitOneGameFrame
				else
					break
				endif
			endif
		endif
	repeat
	SetRollingFriction default
	;wait 1 second

	If SpeedLessThan 5
		Goto Handbrake
	else
		If InNollie
			Goto OnGroundNollieAI
		else
			goto OnGroundAI
		endif
	endif
endscript

script NetBrake_out
	SetRollingFriction default
endscript


// If you brake long enough you will come to a full stop
// this is the script to handle that.

script HandBrake
	ClearEventBuffer
	OnExceptionRun BrakeDone
	SetRollingFriction 100
	If ShouldMongo
		PlayAnim Anim=NewBrake_Mongo
	else
		PlayAnim Anim=NewBrake
	endif
	begin
		DoNextTrick
		If AnimFinished
			break
		endif
		If Crouched
			break
		endif
		Wait 1 game frame
	repeat

	If ShouldMongo
		flip
		BlendPeriodOut 0.2
	endif
	begin
		if AutoKickIsOff
			if held square      // we accelerate with square if no autokick
				WaitOneGameFrame
				break
			endif
		else
			if held up          // normally we acc all the time
				break           // so break out with up or crouching (x)
			endif
			if crouched
				break
			endif
		endif

		if Rightpressed
			if Flipped
				PlayAnim Anim=NewBrakeTurnLeft Cycle NoRestart
			else
				PlayAnim Anim=NewBrakeTurnRight Cycle NoRestart
			endif
		else
			if Leftpressed
				if Flipped
					PlayAnim Anim=NewBrakeTurnRight Cycle NoRestart
				else
					PlayAnim Anim=NewBrakeTurnLeft Cycle NoRestart
				endif
			else
				//		if ShouldMongo
				//			PlayAnim Anim=MongoBrakeIdle Cycle NoRestart
				//		else
				if AnimEquals [NewBrakeIdle NewBrakeIdle3 NewBrakeIdle5 NewBrakeIdle6 NewBrakeIdle7 NewBrakeIdle8 ]
					If AnimFinished
						PlayBrakeIdle
					endif
				else
					PlayBrakeIdle
				endif
				//		endif
			endif
		endif
		WaitOneGameFrame
		DoNextTrick
		DoNextManualTrick
	repeat
	PlayAnim Anim=NewBrakeIdleToIdle
	Wait .25 seconds
	SetRollingFriction default
	WaitAnimWhilstChecking
	;wait 1 second
	If InNollie
		Goto OnGroundNollieAI
	else
		goto OnGroundAI
	endif
endscript

script PlayBrakeIdle
	PlayAnim RandomNoRepeat (@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle2
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle3
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle4
		@Anim=NewBrakeIdle5
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle6
		@Anim=NewBrakeIdle7
		@Anim=NewBrakeIdle8
		@Anim=NewBrakeIdle
		@Anim=NewBrakeIdle)
endscript

script Brakedone
	SetRollingFriction default
endscript

////////////////////////////////////////////////////////////
// The basic ground AI when in Nollie position
////////////////////////////////////////////////////////////

script OnGroundNollieAI
	SetState Ground ; Set the physics to be ground physics, in case coming here from bailing off a rail.
	OnGroundExceptions
	if not GoalManager_GoalShouldExpire
		SetException Ex=Ollied              Scr=Nollie
	endif
	NollieOn
	begin
		if LeftPressed
			if Crouched
				if Flipped
					PlayAnim Anim=NollieCrouchTurnRight NoRestart
				else
					PlayAnim Anim=NollieCrouchTurnLeft NoRestart
				endif
			else
				if Flipped
					PlayAnim Anim=NollieSkatingTurnRight NoRestart
				else
					PlayAnim Anim=NollieSkatingTurnLeft NoRestart
				endif
			endif
		else
			if RightPressed
				if Crouched
					if Flipped
						PlayAnim Anim=NollieCrouchTurnLeft NoRestart
					else
						PlayAnim Anim=NollieCrouchTurnRight NoRestart
					endif
				else
					if Flipped
						PlayAnim Anim=NollieSkatingTurnLeft NoRestart
					else
						PlayAnim Anim=NollieSkatingTurnRight NoRestart
					endif
				endif
			else
				if Crouched
					PlayAnim Anim=NollieCrouchIdle Cycle NoRestart
				else
					if Braking
						if	SpeedLessThan	1
							PlayAnim Anim=NollieSkatingIdle Norestart
							if HeldLongerThan Button=down 2 second
								Goto HandBrake
							endif
						else
							if HeldLongerThan Button=down .2 second
								CessBrake
							else
								PlayBrakeAnim
							endif
						endif
					else
						if CanKick
							if AutoKickIsOff
								// No cycle if no autokick
								if ShouldMongo
									if AnimEquals MongoPushCycle
										PlayAnim Anim=MongoPushCycle NoRestart
									else
										PlayAnim Anim=MongoPush NoRestart
										WaitAnimFinished
										PlayAnim Anim=MongoPushCycle NoRestart
									endif
								else
									PlayAnim Anim=PushCycle  NoRestart
								endif
							else
								if ShouldMongo
									if AnimEquals MongoPushCycle
										PlayAnim Anim=MongoPushCycle Cycle NoRestart
									else
										PlayAnim Anim=MongoPush NoRestart
										WaitAnimFinished
										PlayAnim Anim=MongoPushCycle Cycle NoRestart
									endif
								else
									PlayAnim Anim=PushCycle Cycle NoRestart
								endif
							endif
						else
							if AnimFinished
								PlayAnim Anim=NollieSkatingIdle Cycle NoRestart
							endif
						endif
					endif
				endif
			endif
		endif
		DoNextTrick
		DoNextManualTrick
		CheckforNetBrake
		WaitOneGameFrame
	repeat
endscript
////////////////////////////////////////////////////////////
// Flails are used when you collide with a wall when going fast
////////////////////////////////////////////////////////////

script FlailExceptions
	//NollieOff     		; you'll be able to stay in Nollie when going over bumps
	//RemoveXEvents
	SetException Ex=CarBail				Scr=CarBail
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	SetException Ex=RunHasEnded			Scr=EndOfRun
	SetException Ex=GoalHasEnded		Scr=Goal_EndOfRun
	if GoalManager_GoalShouldExpire
		ClearException Ollied
		ClearException GroundGone
		ClearException WallPush
	endif

	ClearTrickQueue
	ClearManualTrick
	ClearEventBuffer

	LandSkaterTricks
	SpawnClothingLandScript
endscript

script FlailHitWall
	Goto FlailLeft
endscript


script FlailLeft
	StopBalanceTrick     // Added this as exceptions don't do it
	FlailExceptions
	FlailVibrate
	if Crouched
		If SpeedGreaterThan 400
			PlayAnim Random(@Anim=FlailLeftCrouched_small @Anim=FlailLeftCrouched2) Blendperiod=.03
		else
			PlayAnim Random(@Anim=FlailLeftCrouched2 @Anim=FlailLeftCrouched3) Blendperiod=.03
		endif
	else
		PlayAnim Random (@Anim=FlailLeft @Anim=FlailLeft2) Blendperiod=.03
	endif
	WaitAnimWhilstChecking
	If InNollie
		Goto OnGroundNollieAI
	else
		goto OnGroundAI
	endif
endscript

script FlailRight
	StopBalanceTrick     // Added this as exceptions don't do it
	FlailExceptions
	FlailVibrate
	if Crouched
		If SpeedGreaterThan 400
			PlayAnim Random(@Anim=FlailRightCrouched_small @Anim=FlailRightCrouched2) Blendperiod=.03
		else
			PlayAnim Random(@Anim=FlailRightCrouched2 @Anim=FlailRightCrouched3) Blendperiod=.03
		endif
	else
		PlayAnim Random (@Anim=FlailRight @Anim=FlailRight2) Blendperiod=.03
	endif
	WaitAnimWhilstChecking
	If InNollie
		Goto OnGroundNollieAI
	else
		goto OnGroundAI
	endif
endscript

script FlailVibrate
	if 	SpeedGreaterThan 600
		Vibrate Actuator=1 Percent=80 Duration=.25
	else
		Vibrate Actuator=1 Percent=50 Duration=.15
	endif
endscript

/////////////////////////////////////////////////////////////////////
// Groundgone handles the case where the skater skates off an edge
// we've added checks in this script for "late ollies" - ollies
// im which the user was a little late on the press, and actually
// triggered the jump after he left the surface.
/////////////////////////////////////////////////////////////////////

script GroundGone
	InAirExceptions
	StopBalanceTrick     // Added this as exceptions don't do it
	; Late jumping:
	; Allow the player to still be able to jump for the time being ...

	SetException Ex=Ollied Scr=Ollie
	; and also to still be able to do ground tricks such as the no-comply.
	ClearTricksFrom GroundTricks //so we don't get any switch anims queued on the ground
	If GotParam NoBoneless  // No Bonelessing when late jumping from manuals...
		SetSkaterAirTricks
	else
		If ((GetGlobalFlag Flag=FLAG_EXPERT_MODE_NO_WALKING) || ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING)))
			;if not ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING))
			SetQueueTricks special=SpecialTricks AirTricks JumpTricks JumpTricks0
			;endif
		else
			SetQueueTricks special=SpecialTricks AirTricks JumpTricks JumpTricks0 SkateToWalkTricks
		endif
	endif

	if Crouched
		PlayAnim Anim=Crouch2InAir
	else
		PlayAnim Anim=Idle2InAir
	endif

	WaitAnimWhilstCheckingLateOllie
	SetSkaterAirTricks
	ClearException Ollied

	goto Airborne
endscript

; This loop was cut and pasted from WaitAnimWhilstChecking, then the
; airtime check added.
script WaitAnimWhilstCheckingLateOllie
	begin
		; If the player has been airborne for longer than a certain time after the
		; ground went, disable the ollie and ground tricks.
		if AirTimeGreaterThan Skater_Late_Jump_Slop
			return
		endif
		DoNextTrick TrickParams={ FromGroundGone }
		if AnimFinished
			return
		endif
		Wait 1 GameFrame
	repeat
endscript

script WaitFramesLateOllie
	begin
		if (<Frames> = 0)
			return Frames=0
		endif
		if AirTimeGreaterThan Skater_Late_Jump_Slop
			return Frames=<Frames>
		endif
		Frames=(<Frames> - 1)
		Wait 1 GameFrame
	repeat
endscript

// handles late ollie exceptions as an event for trick scripts
script TrickOllie
	Jump
endscript

////////////////////////////////////////////////////////////
// The script controlling you when you are in the air and not tricking
////////////////////////////////////////////////////////////
AirAnimParams={Hold BlendPeriod=0.3 NoRestart}

script Airborne BlendPeriod=0.3
	// Bit of a hack for Bob's loop in the Zoo
	If Obj_FlagSet FLAG_SKATER_INLOOP
		Goto LoopGapStart
	endif
	InAirExceptions <...>
	begin
		DoNextTrick
		GetAirTimeLeft
		// printf "Airtimeleft=%f" f=<Airtimeleft>

		if ( <AirTimeLeft> < 0.4 )
			PlayAnim	Anim=StretchLegsInit BlendPeriod=<BlendPeriod> NoRestart
			break
		else
			if LeftPressed
				if Flipped
					PlayAnim Anim=AirTurnRight AirAnimParams
				else
					PlayAnim Anim=AirTurnLeft AirAnimParams
				endif
			else
				if RightPressed
					if Flipped
						PlayAnim Anim=AirTurnLeft AirAnimParams
					else
						PlayAnim Anim=AirTurnRight AirAnimParams
					endif
				else
					if Held R2
						PlayAnim	Anim=SpineTransfer 	BlendPeriod=0.3 NoRestart
					else
						if Held L2
							PlayAnim	Anim=SpineTransfer 	BlendPeriod=0.3 NoRestart
						else
							PlayAnim Anim=AirIdle Cycle BlendPeriod=<BlendPeriod> NoRestart
						endif
					endif
				endif
			endif
		endif
		WaitOneGameFrame
	repeat
	WaitAnimWhilstChecking
	begin
		DoNextTrick
		WaitOneGameFrame
	repeat
	//PlayAnim	Anim=StretchIdle	BlendPeriod=0.1	Cycle
endscript

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The big one: the landing. The Land script has two main parts. The first part handles
// checks for you angle and orientation to make sure you are in an ok position to land
// The second part (land2) handles playing the landing animation playback, and clearing
// the panel if you don't manual or revert.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

script Land
	; first we check to see if you are ok to land
	SetSkaterCamLerpReductionTimer time = 0      // This puts the camera LERP back to the default value
	easy_no_bail = 0
	If GetGlobalFlag Flag=DIFFICULTY_MODE_TOO_EASY
		if NOT InNetGame
			<easy_no_bail> = 1
		endif
	endif

	if ( <easy_no_bail> = 1)
		// no bailing at all in TOO EASY mode
		ClearTrickQueue
		KillExtraTricks
	else
		GoalManager_GetDifficultyLevel
		// easier landing angles for easy mode
		if  (<difficulty_level> = 0)
			if SpeedGreaterThan 500   			; no angle checks if you're going slow
				if YawBetween (80,100) 			; this is when the skater is perpedicular to direction of travel
					Goto YawBail
				endif
				;if RollGreaterThan 45
				;	LaunchConsoleMessage "Roll Bail"
				;	Goto DoingTrickBail
				;endif
			endif
		else
			//Normal difficulty landing angles
			if SpeedGreaterThan 500   			; no angle checks if you're going slow
				if YawBetween (60,120) 			; this is when the skater is perpedicular to direction of travel
					Goto YawBail
				endif
				;if RollGreaterThan 45
				;	LaunchConsoleMessage "Roll Bail"
				;	Goto DoingTrickBail
				;endif
			endif
		endif
		// Other bail checks that are the same in Easy, Normal, and Sik modes
		If AbsolutePitchGreaterThan 60
			if PitchGreaterThan 60
				//	LaunchConsoleMessage "Pitch Bail"
				Goto PitchBail
			endif
		endif
		// because you can sometimes come out of a spine transfer at less than fully vertical, we check here to
		// insure that you always bail if you land on flat ground out of vert air
		if LandedFromSpine
			GetMatrixNormal
			if (<y> > 0.95)
				Printf "Bailing due to landing from spine onto flat ground"
				Goto PitchBail
			endif
		endif
		if RollGreaterThan 50
			//	LaunchConsoleMessage "Roll Bail"
			Goto DoingTrickBail
		endif
		if DoingTrick
			printf "DOING A TRICK"
			Goto DoingTrickBail
		endif
	endif
	// Used when going from wallride to ground.
	if GotParam NoBlend
		BlendPeriodOut 0
	endif


	if GotParam ReturnBacktoLipLand
	else
		if GotParam IgnoreAirTime
			Goto Land2 Params={IgnoreAirTime}
		else
			if AirTimeLessThan .2 seconds
				;looks good - start the landing
				Goto Land2 Params={LittleAir}
			else
				GotoPreserveParams Land2 		//Some scripts may pass on RevertTime and we need to send this down to Land2
			endif
		endif
	endif
endscript


script Land2 RevertTime=5
	DoPerfectCheck
	AllowRailtricks
	NollieOff
	PressureOff
	ClearLipCombos


	;;; now let's check to see if you have a manual queued up
	;;; but you won't get it off if you came from Vert
	If LandedFromVert
		//	printf ">>>>>>>>>>>> LandedFromVert"
		OverrideCancelGround //although we're in the land script, we haven't landed yet, so don't cancel combo gaps just yet...
		Obj_ClearFlag FLAG_SKATER_MANUALCHEESE

		// Dan: only set the revert as a special trick if we're above a threshold velocity; this prevents the exploit were you revert continuously in one
		// place
		GetSpeed
		if ( <Speed> > 250 )
			SetExtraTricks_Reverts duration=<RevertTime>
		endif

		// TAIL TAP TEST
		if AnimEquals [ToTail_In ToTail_Idle ToTail_Out]
			SetTrickName "To Tail"
			SetTrickScore 500
			Display
			//GetTerrain
			CopingHit Terrain=3
		endif
	else
		//If we activated the Airmanual, just run it here
		/*			printstruct <...>
			If GotParam Queued_Trick_NoseManual
				Scriptname = (Trick_NoseManual.Scr)
				<Scriptname> (Trick_NoseManual.Params) FromAir
			endif
			If GotParam Queued_Trick_Manual
				Scriptname = (Trick_Manual.Scr)
				<Scriptname> (Trick_Manual.Params) FromAir
			else   */
		//				printf "aaaaaaaaaaaaaaaaaaaaaaaaaaa"
		DoNextManualTrick FromAir
		//endif
	endif

	Vibrate Actuator=1 Percent=80 Duration=.1

	; start playing some anims
	GetAirtime
	SpawnClothingLandScript  // Make the clothes ruffle
	if Crouched
		if GotParam LittleAir
			PlayAnim Anim=CrouchBumpDown
		else
			if Backwards
				FlipAndRotate
				PlayAnim RandomNoRepeat (@Anim=CrouchedLandTurn @Anim=CrouchedLandTurn1 @Anim=CrouchedLandTurn2 @Anim=CrouchedLandTurn3 @Anim=StretchLegsLand ) BlendPeriod=0.0
				BoardRotate
			else
				if 	YawBetween (45,60)
					if AirTimeGreaterThan .75 second
						PlayAnim Random (@Anim=SketchyCrouchLand @Anim=SketchyLand1) BlendPeriod=0.1
						If InSplitScreenGame
						else
							LaunchPanelMessage "&C1Sketchy" properties=panelcombo
						endif
					else
						PlayLandAnim <...>
					endif
				else
					PlayLandAnim <...>
				endif
			endif
		endif
	else
		if GotParam LittleAir
			PlayAnim Anim=IdleBump
		else
			if Backwards
				FlipAndRotate
				PlayAnim Random (@Anim=CrouchedLandTurn @Anim=CrouchedLandTurn1 @Anim=CrouchedLandTurn2 @Anim=CrouchedLandTurn3) BlendPeriod=0
				BoardRotate
			else
				if 	YawBetween (45,60)
					if AirTimeGreaterThan .5 second	  //was .75
						PlayAnim Random (@Anim=SketchyLand @Anim=SketchyLand1) BlendPeriod=0.1
						If InSplitScreenGame
						else
							LaunchPanelMessage "&C1Sketchy" properties=panelcombo
						endif
					else
						PlayLandAnim <...>
					endif
				else
					PlayLandAnim <...>
				endif

			endif
		endif
	endif
	;;; again we're gonna check to see if you just queued up a manual
	;;; but you won't get it off if you came from Vert
	ClearTrickQueue
	// if you queued some jump trick, like a boneless,
	// in the air, we get rid of the X event so as not to get any by accident
	// this was the phantom boneless bug
	//if Not Obj_FlagSet FLAG_SKATER_HAMMER_MODE
	// in Hammer mode we don't want these things, as they will cause you to defeat the hammer mechanic
	ClearEventBuffer buttons=[X]
	SetSkaterAirManualTricks
	//endif

	OnGroundExceptions NoEndRun
	OnExceptionRun LandSkaterTricks

	// if the goal has expired, we can't allow you to ollie during the revert/manual window
	// otherwise, you will be able to escape the goal end run exception via ollie
	if GoalManager_GoalShouldExpire
		// Printf "First Land2: GoalManager_GoalExpired returned true - killing ollies"
		ClearException Ollied
		ClearException GroundGone
		ClearException WallPush
		// else
		// Printf "First Land2: GoalManager_GoalExpired returned false - allowing ollies"
	endif

	If GotParam NoReverts
	else
		If LandedFromVert
			ResetLandedFromVert
			begin
				wait 1
			repeat <RevertTime>
		else
			//		if Obj_FlagSet FLAG_SKATER_HAMMER_MODE
			//			HammerCheck
			//		else
			begin
				DoNextManualTrick FromAir
				wait 1
			repeat 10
			//		endif
		endif
	endif

	;;; because if you don't, we're gonna end you combo and
	;;; clear the panel

	LandSkaterTricks

	//ClearEventBuffer   // this was added to try to fix the Phantom Boneless bug. But that was fixed above...So removing this
	//printf "clearing the event buffer loser....."
	OnGroundExceptions

	CheckforNetBrake
	WaitAnimWhilstChecking AndManuals
	goto OnGroundAI
endscript

Script PlayLandAnim
	// Pete and Jim
	// delete out all of the anims you don't want to look at from the structure below,
	// to force a particular land anim to play all of the time.
	If GotParam IgnoreAirTime
		PlayAnim RandomNoRepeat (@Anim=CrouchedLand @Anim=CrouchedLand1 @Anim=CrouchedLand2 @Anim=CrouchedLand3 @Anim=StretchLegsLand) BlendPeriod=0.1
	else
		If AirtimeLessThan .5 seconds
			//    PRINTF "tiny landing"
			PlayAnim Anim=CrouchBumpDown
		else
			If AirtimeLessThan .75 seconds
				//        printf "SMALL LAND"
				PlayAnim RandomNoRepeat (@Anim=CrouchedLand1_small @Anim=CrouchedLand2_small @Anim=CrouchedLand3_small) BlendPeriod=0.1
			else
				PlayAnim RandomNoRepeat (@Anim=CrouchedLand @Anim=CrouchedLand1 @Anim=CrouchedLand2 @Anim=CrouchedLand3 @Anim=StretchLegsLand) BlendPeriod=0.1
			endif
		endif
	endif
endscript

script LandSkaterTricks
	//***Possible sound for when land a big score
	//*** this will not trigger when scoring after a revert or a manual
	if currentscorepotgreaterthan 1500
		SpawnScript LandPointsSound
	endif
	CheckGapTricks
	ClearGapTricks NotInSameFrame
	ClearPanel_Landed
	ClearManualTrick
	OverrideCancelGround Off
	ResetSpin
	Obj_ClearFlag FLAG_SKATER_REVERTCHEESE
endscript

script BailSkaterTricks
	ClearGapTricks
	ClearPanel_Bailed
endscript

script DoPerfectCheck
	if CurrentScorePotGreaterThan 1
		if YawBetween (0,5) //was (0,5)
			AwardPerfect
		endif
		If YawBetween (175,180)	//(175,180)
			AwardPerfect
		endif
		if YawBetween (45,60)
			AwardSloppy
		endif
		if YawBetween (120,135)
			AwardSloppy
		endif
	endif
endscript

script AwardPerfect
	GetSpin
	//		printf "Spin=%s" s=<spin>
	If (<spin> > 359.0)
		if Not InSplitscreenGame
			Create_Panel_Message text="Perfect Landing!" id=perfect rgba=[50 150 50 128] pos=(110,340) style=perfect_style
			Create_Panel_Message text="+1000 Points" id=perfect2 rgba=[40 140 40 100] pos=(110,360) style=perfect_style
		else
			PerfectSloppy_2p text="Perfect!" rgb=[50 150 50 128]
		endif
		SetTrickName ''
		SetTrickScore 1000
		Display Blockspin NoDegrade
		Obj_SpawnScript PlayPerfectSound Params={sound=PerfectLanding wait=.2 pitch=80}
	endif
endscript

script AwardSloppy
	if CurrentScorePotGreaterThan 750
		GetSpin
		//		printf "Spin=%s" s=<spin>
		If (<spin> > 359.0)
			if Not InSplitscreenGame
				Create_Panel_Message text="Sloppy Landing" id=perfect rgba=[200 50 50 128] pos=(110,340) style=sloppy_style
				Create_Panel_Message text="-500 Points" id=perfect2 rgba=[107 51 27 100] pos=(110,360) style=sloppy_style
			else
				PerfectSloppy_2p text="Sloppy!" rgb=[200 50 50 128]
			endif
			SetTrickName ''
			SetTrickScore -500
			Display Blockspin NoDegrade
			Obj_SpawnScript PlayPerfectSound Params={sound=HUDtrickslopC pitch=150 wait=.12}
		endif
	endif
endscript

script PlayPerfectSound
	Wait <wait> seconds
	Playsound <sound> pitch=<pitch>
endscript

script PerfectSloppy_2p
	ScriptGetScreenMode
	GetSkaterNumber
	switch <screen_mode>
		case split_vertical
			switch <skaternumber>
				case 0
					Create_Panel_Message text=<text> id=perfect rgba=<rgb> pos=(70,340) style=perfect_style
				case 1
					Create_Panel_Message text=<text> id=perfect_p2 rgba=<rgb> pos=(370,340) style=perfect_style
			endswitch
		case split_horizontal
			switch <skaternumber>
				case 0
					Create_Panel_Message text=<text> id=perfect rgba=<rgb> pos=(70,154) style=perfect_style
				case 1
					Create_Panel_Message text=<text> id=perfect_p2 rgba=<rgb> pos=(70,375) style=perfect_style
			endswitch
	endswitch
endscript

script perfect_style
	DoMorph time=0 scale=(0, 0)
	DoMorph time=.1 scale=(.95, .95)
	DoMorph time=.1 scale=(.75, .75)
	DoMorph time=.1 scale=(.8, .8)
	DoMorph time=.05 alpha=0
	DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=0
	DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=0
	DoMorph time=.05 alpha=1
	DoMorph time=1.2 alpha=0
	die
endscript

script sloppy_style
	DoMorph time=0 scale=(0, 0)
	DoMorph time=.1 scale=(.8, .8)
	DoMorph time=.02 alpha=0
	DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=0
	DoMorph time=.03 alpha=1
	DoMorph time=.05 alpha=0
	DoMorph time=.05 alpha=1
	DoMorph time=.04 alpha=0
	DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=0
	DoMorph time=.02 alpha=1
	DoMorph time=1 alpha=0
	die
endscript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;UTILITY SCRIPTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

script WaitOnGround
	begin
		If OnGround
			break
		endif
		WaitOneGameFrame
	repeat
endscript


script VibrateOff
	Vibrate off
endscript

// logic determining if we should end a run while walking
script EndOfRun_WalkingEvent
	if CurrentScorePotGreaterThan 0
		return
	endif
	MakeSkaterGoto EndOfRun
endscript

// logic determining if we should end a goal while walking
script Goal_EndOfRun_WalkingEvent
	if CurrentScorePotGreaterThan 0
		return
	endif
	Goal_EndofRun
endscript

// called by goal scripts to slow the skater to a stop before resetting him
script SlowSkaterToStop
	MakeSkaterGoto EndOfRun
	WaitForEvent Type=EndofRunDone
endscript

; EndOfRun (Added by Gary)
; This script gets run when time has run out (or some other
; end condition is met), and after the skater has completed
; his last trick.  It should make the skater
; brake to a stop.

script EndOfRun
	ClearExceptions             // Clear exception first, so we don't re-trigger the RunHasEnded exception
	if Walking
		ClearAllWalkingExceptions
	endif
	EndOfRunStarted

	CleanUpSpecialItems
	StopBalanceTrick

	LandSkaterTricks           // This would have triggered RunHasEnded, putting us in an inifinite loop

	ClearEventBuffer
	// let peds and other things know that our run it about to end completely
	LaunchStateChangeEvent State=Skater_EndOfRun

	SetException Ex=LostGame Scr=LostGame
	DisablePlayerInput AllowCameraControl

	if Skating
		SetState GROUND

		If Not GotParam NoBrake
			SetException Ex=SkaterCollideBail	Scr=EndBail
			WaitOnGround
			SetRollingFriction 19
			Wait 10 frames
			WaitOnGround
			If SpeedGreaterThan 250
				PlayCessSound
				PlayAnim Anim=CessSlide180_FS
				WaitAnim 50 percent
				PlayAnim Anim=CessSlide180_FS From=Current To=0
				Obj_WaitAnimFinished
			else
				PlayAnim Anim=brake BlendPeriod=0.3
				Obj_WaitAnimFinished
			endif
			PlayAnim Anim=BrakeIdle BlendPeriod=0.3 cycle
			begin
				SetRollingFriction 19
				If SpeedLessThan 40
					If OnGround
						break
					endif
				endif
				WaitOneGameFrame
			repeat
		endif
	else
		if Walking
			if not GotParam NoBrake
				if Walk_Ground
					Walk_ScaleAnimSpeed Off
					if SpeedGreaterThan ( walk_parameters.max_slow_walk_speed )
						PlayAnim Anim=_180RunSkid NoRestart BlendPeriod=0.0
						Obj_WaitAnimFinished
					endif
					PlayAnim Anim=WStand NoRestart Cycle BlendPeriod=0.3
				endif
			endif
		endif
	endif

	If InNetGame
		SetException Ex=WonGame Scr=WonGame
		SetException Ex=LostGame Scr=LostGame
	Endif
	Wait 1 seconds
	//		Leave this out until ResetCamera is working again - brad
	// if not GotParam FromTaxiGuy
	// if IsCareerMode
	//			SetSkaterCamOverride heading=3 tilt=-.2 time=2
	// endif
	// endif

	// Let the GoalManager know we are done, and stopped with out combo
	FireEvent type=EndofRunDone

	if not GotParam FromTaxiGuy
		EndOfRunDone
	endif

	If InNetGame
		If NOT GameIsOver
			if NOT GameModeEquals is_king
				if Not GameModeEquals is_score_challenge
					If Not GotParam FromTaxiGuy
						if Not GameModeEquals is_goal_attack
							wait 1 seconds
							if GameModeEquals is_firefight
								if Not IsObserving
									Skater:remove_skater_from_world
								endif
								create_panel_message id=goal_message text="You've been eliminated!" style=panel_message_generic_loss time=5000
							else
								create_panel_message id=goal_message text="Waiting for others to finish. Press \m0 to observe" style=panel_message_generic_loss time=2000
							endif
							if Not IsObserving
								EnterSurveyorMode
							endif
						endif
					endif
				endif
			endif
		endif
	endif
endscript

script Goal_EndOfRun
	ClearExceptions
	ClearExceptionGroup WalkingEndRunEvents
	Goal_EndOfRunStarted

	;if Skating
	;SetState GROUND
	;endif

	CleanUpSpecialItems
	StopBalanceTrick

	LandSkaterTricks

	ClearEventBuffer

	// Let the GoalManager know we are done, and stopped with out combo
	FireEvent type=EndofRunDone

	if not GotParam FromTaxiGuy
		Goal_EndOfRunDone
	endif
	If InNetGame
		If GameIsOver
		else
			if GameModeEquals is_king
			else
				If Not GotParam FromTaxiGuy
					if Not GameModeEquals is_goal_attack
						create_panel_message id=goal_message text="Waiting for other players to finish their runs..." style=panel_message_generic_loss
					endif
				endif
			endif
		endif
	endif
endscript

script ForceEndOfRun
	VibrateOff
	MakeSkaterGoto EndOfRun
endscript

Script WonGame
	if Skating
		PlayAnim	Random (@Anim=Prop @Anim=Cheer1)	Blendperiod=0.3
		EndofRunDone
		WaitAnimFinished
		If ShouldMongo
			PlayAnim Anim=MongoBrakeIdle Cycle
		else
			PlayAnim Anim=BrakeIdle Cycle
		endif
	else
		EndofRunDone
	endif
Endscript

Script LostGame
	if Skating
		PlayAnim Anim=BrakeDefeat
		WaitAnimFinished
		EndofRunDone
		If ShouldMongo
			PlayAnim Anim=MongoBrakeIdle Cycle
		else
			PlayAnim Anim=BrakeIdle Cycle
		endif
		WaitAnimFinished
	else
		EndofRunDone
	endif
Endscript


script EndBail
	EndOfRunDone
	ClearExceptions
	InBail				;notify the SFX and net code
	TurnToFaceVelocity			;otherwise we shoot off at odd angles when landing this way
	VibrateOff
	//PlaySound Random (@BoardBail01 @BoardBail02)	//sound unloaded 04/30/03 by David Rowe
	PlayAnim Anim=SlipForwards	NoRestart BlendPeriod=0.3
	Wait 10 frames
	SwitchOffBoard
	Wait 10 frame
	//PlaySound Random (@HitBody03 @HitBody04)
	Wait 10 frames
	SetRollingFriction 18
	Vibrate Actuator=1 Percent=100 Duration=.2

	if not GetGlobalFlag flag=BLOOD_OFF
		Obj_Spawnscript BloodSmall
	endif

	WaitAnim 25 percent fromend
	//PlaySound FoleyMove01 vol = 50
	WaitAnimFinished
	//Obj_Spawnscript BloodPool
	PlayAnim Anim=GetUpForwards  BlendPeriod=0.1
	SetRollingFriction 20
	Wait 50 frames
	SwitchOnBoard
	BoardRotate normal
	WaitAnimFinished
	NotifyBailDone
	NotInBail			;notify the SFX and net code
	Goto EndOfRun
endscript

// Triggered when you jump onto a car

script CarPlant
	StopBalanceTrick     // Added this as exceptions don't do it  (unlikely to be used here, but better safe)
	ClearExceptions
	InAirExceptions
	ClearException Carplant
	PlaySound GrindMetalOn random (@pitch=80 @pitch=90 @pitch=85)
	Obj_Spawnscript CarSparks
	DoCarPlantBoost				//Jump up in the air
	SetTrickName "Car Plant"
	SetTrickScore 400
	Display
	if DoingTrick
	else
		PlayAnim Anim=Beanplant BlendPeriod=0.3
		WaitAnimWhilstChecking
		Goto Airborne
	endif
endscript


script CarSparks
	SetSparksTruckFromNollie
	SparksOn
	Wait .333 seconds //20 gameframes
	SetException 	Ex=Carplant 	Scr=Carplant
	Wait 3 seconds // 180 gameframes
	SparksOff
endscript


script FreezeSkater
	SwitchOnBoard
	ClearExceptions
	SetQueueTricks NoTricks
	DisablePlayerInput
	SetRollingFriction 10000
	PlayAnim	Anim=StandIdle cycle
endscript

script CarBail
	StopBalanceTrick     // Added this as exceptions don't do it
	InBail				;notify the SFX and net code
	Obj_Spawnscript BloodCar
	PlaySound BonkMetal_11
	Playsound Random (@hitblood01 @hitblood02 @hitblood03)
	goto NoseManualBail
endscript


script FlailingFall
	InBail				;notify the SFX and net code
	ClearExceptions
	SetQueueTricks NoTricks
	DisablePlayerInput AllowCameraControl
	PlayAnim	Anim=StretchtoFlailingFall 	BlendPeriod=0.3
	BailSkaterTricks
	WaitAnim 90 percent
	SwitchOffBoard
	WaitAnimFinished
	PlayAnim	Anim=FlailingFall 	Cycle
	;	WaitOnGround
	;	Obj_Spawnscript BloodCar
	;	Obj_Spawnscript BloodCar
endscript



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; RESTART/RESPAWN SKATER SCRIPTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

script DropIn DropInAnim=DropIn
	printf "DropIn"

	if GameModeEquals is_horse
		printf "**** IN DROPIN ****"
		GetCurrentSkaterID
		KenTest1
		printstruct <...>
		if Not IsCurrentHorseSkater <objId>
			printf "**** WASN'T CURRENT HORSE PLAYER ****"
			return
		endif
	endif

	;SetState Lip
	ResetSkaterParticleSystems
	PausePhysics
	RestartSkaterExceptions
	SetSkaterCamOverride heading=0 tilt=-.75 time=0.000001 zoom=5   // first attempt at a fix
	OnExitRun DropIn_Cleanup
	//	SetSkaterCamOverride heading=0 tilt=-.99 time=0.000001 zoom=30	// second attempt
	SetRollingFriction 10000
	DisablePlayerInput
	PlayAnim	Anim=<DropInAnim> 	BlendPeriod=0.0
	// WaitAnim 1 percent
	//SetSkaterCamOverride heading=0 tilt=0 time=2 zoom=5
	WaitAnim 60 percent
	ClearSkaterCamOverride
	WaitAnim 85 percent

	UnPausePhysics
	SetState Ground
	SetRollingFriction	0
	WaitAnimFinished
	EnablePlayerInput
	OnGroundExceptions
	WaitOneGameFrame // We need this so that if you get respawned after the time limit, the game will detect
	// an EndofRun exception and end your run
	SetLandedFromVert
	Goto Land
endscript

script DropIn_Cleanup
	ClearSkaterCamOverride
	EnablePlayerInput
	SetRollingFriction default
endscript

script ZoomIn
	Skater:SetSkaterCamOverride heading=0  time=0.00001 zoom=1.04
endscript

script ZoomOut
	Skater:ClearSkaterCamOverride
endscript


Script StartSkating1
	//	SetSkaterCamOverride heading=2.5 tilt=-.5 time=0.000000001
	;	SetSkaterCamOverride heading=.000001 tilt=-.5 time=0.000000001
	RestartSkaterExceptions
	SetRollingFriction default
	DisablePlayerInput AllowCameraControl
	If ProfileEquals is_named=mullen
		SetRollingFriction 10000
		PlayAnim	Anim=MullenStart 	BlendPeriod=0.0
		WaitAnim 40 percent
		PlaySound boneless09 pitch=110
		PlayBonkSound
		BlendPeriodOut 0
		WaitAnim 60 percent
		SetRollingFriction default
	else
		if Not Flipped
			Flip
		endif
		if AutoKickIsOff
			If ShouldMongo
				PlayAnim Anim=MongoBrakeIdle
			else
				PlayAnim Anim=BrakeIdle
			endif
		else
			PlayAnim	Anim=StartSkating1 	BlendPeriod=0.0
			WaitAnim 75 percent
		endif
	endif
	//	SetSkaterCamOverride heading=0 tilt=0 time=1
	ClearSkaterCamOverride
	EnablePlayerInput
	OnGroundExceptions
	WaitAnimFinished
	Goto OnGroundAI
endscript



script PedProps name="Ped Props" score=500
	If InSplitScreenGame
	else
		LaunchPanelMessage "Spectator Bonus" Properties=Panelcombo2
	endif
	if not GetGlobalFlag flag=SOUNDS_SPECIALSOUNDS_OFF
		PlaySound ExtraTrick Vol=100
	endif
	SetTrickName	<name>
	SetTrickScore	<score>
	Display BlockSpin
	WaitOneGameFrame
	if Onground
		If DoingTrick
		else
			LandSkaterTricks
		endif
	endif
Endscript


script RestartSkaterExceptions
	AllowRailTricks
	BoardRotate Normal
	ClearExceptions
	; Dan:  Really don't allow bails here, or else the skater will get jacked, yo!
	; TT5923, TT12698.  If two skater respawn at the same node with collision on,
	; the collision loser's script state is hosed.
	;	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	; GJ:  Don't allow bails here, or else the camera will get jacked, yo!
	;	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	ClearTrickQueue
	SetQueueTricks NoTricks
	ClearManualTrick
	ClearEventBuffer
	SwitchOnBoard
	; next line is needed for attaching particle systems
	; to the skater
	; Obj_Spawnscript CanadaBreath
	//	SetException  Ex=RunHasEnded Scr=EndOfRun
endscript


script LaunchSpecialMessage text="Special Trick" vol=100 pitch=100
	If InMultiplayergame
		if not GetGlobalFlag flag=SOUNDS_SPECIALSOUNDS_OFF
			PlaySound HUD_specialtrickAA Vol=<vol> pitch=<pitch>
		endif
	else
		If ( GetGlobalFlag flag=CHEAT_COOL_SPECIAL_TRICKS )
			if GotParam Cool
				SetSlomo .6
				pulse_blur start =0 end=150 speed = 10
				if not GetGlobalFlag flag=SOUNDS_SPECIALSOUNDS_OFF
					PlaySound HUD_specialtrickAA vol=200 pitch=75
				endif
				OnExceptionRun KillSpecial
			else
				if not GetGlobalFlag flag=SOUNDS_SPECIALSOUNDS_OFF
					PlaySound HUD_specialtrickAA Vol=<vol> pitch=<pitch>
				endif
			endif
		else
			if not GetGlobalFlag flag=SOUNDS_SPECIALSOUNDS_OFF
				PlaySound HUD_specialtrickAA Vol=<vol> pitch=<pitch>
			endif
		endif
	endif
endscript

script EndSpecial
	If ( GetGlobalFlag flag=CHEAT_COOL_SPECIAL_TRICKS )
		pulse_blur start=150 end=0 time=10
		SetSlomo 1
	endif
endscript

script KillSpecial
	kill_blur
	SetSlomo 1
endscript

script LaunchExtraMessage text="Hidden Combo!"
	if not GetGlobalFlag flag=SOUNDS_SPECIALSOUNDS_OFF
		PlaySound extratrick Vol=80
	endif
endscript




// ------------ Chad's Stuff --------------

script PedKnockDown
	if ObjectExists id=speech_box_anchor
		DestroyScreenElement id=speech_box_anchor
	endif
	if ObjectExists id=goal_start_dialog
		DestroyScreenElement id=goal_start_dialog
	endif
	Obj_Spawnscript BloodSmall

	if Skating
		SetRollingFriction 0
		StopBalanceTrick
		if OnLip
			StopBalanceTrick
			SetState Air
			Move z=1
			Move y=1
		endif
		if Gotparam Jump
			SetSpeed -150
			wait 1 game frame
			Jump
			FlipAndRotate
			GotoRandomScript [Faceplant Facesmash NoseManualBail ManualBail Hipper TailslideOut]
		endif
		if backwards
			GotoRandomScript [BackwardFaceSlam Shoulders]
		else
			if Onrail
				Goto FiftyFiftyFall
			else
				GotoRandomScript [Faceplant LandPartiallyOnBoard Facesmash NoseManualBail ManualBail Hipper Spasmodic TailslideOut]
			endif
		endif
	else
		Goto WalkBailState
	endif
endscript


script SkaterAvoidGoalPed
	if GotParam heading
		Skater:Rotate y=<heading>
	endif

	if not Skater:SpeedGreaterThan 100
		Skater:SetSpeed <speed>
	endif

	; printf "Avoiding goal ped"
	SetException Ex=CarBail				Scr=CarBail
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	Skater:FlailVibrate
	Skater:NollieOff
	Skater:StopBalanceTrick
	Skater:Obj_PlaySound Random(@BailSlap03)  //changed from bitchslap2 04/30/03 by David Rowe

	// don't jump walker from his animation scripts
	if not Skater:Walking
		MakeSkaterGoto FlailHitWall
	endif
endscript

script SkaterBreakGlass
	SetException Ex=CarBail				Scr=CarBail
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	FlailVibrate
	NollieOff
	PressureOff
	StopBalanceTrick
	if AnimEquals [CrouchIdle SkateIdle Land MongoPushCycle PushCycle]
		Goto FlailHitWall
	endif
	If AnimEquals [runout runoutquick Smackwallupright]
		Goto Bailsmack Params={SmackAnim=Smackwallupright}
	endif
	If InAir
		Goto Airborne
	else
		If IsInBail
			//		PrintStruct
			If AnimEquals [Smackwallfeet NutterFallBackward FiftyFiftyFallBackward BackwardsTest BackwardFaceSlam SmackWallFeet SlipBackwards]
				Goto BailSmack Params={SmackAnim=Smackwallfeet}
			else
				Goto BailSmack Params={<...>}
			endif
		endif
		Goto OnGroundAI
	endif
endscript


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;     SPINES AND STAIRS		;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TRANSFER_POINTS=250
ACID_DROP_POINTS=250
ACID_BOMB_POINTS=350

// used for spines
// IMPORTANT! This script is spawned on the skater - he is not forced into it via an
// exception, so don't put in any wait functions
script  SkaterAwardTransfer name="Spine Transfer"
	SetTrickName <name>
	SetTrickScore TRANSFER_POINTS
	Display NoDegrade

	LaunchSubStateEntryEvent SubState=Transfer

	// PlaySound HUD_jumpgap
	// If not (use_bike_physics)
	if not DoingTrick
		GetTags
		if  (<racemode>= none)
			setstate air
			InAirExceptions
			PlayAnim Anim=SpineTransfer
		endif
	endif
	// endif
endscript

script  SkaterAwardHipTransfer
	SkaterAwardTransfer name="Hip Transfer"
endscript



// used for acid drops
// IMPORTANT! This script is spawned on the skater - he is not forced into it via an
// exception, so don't put in any wait functions
script  SkaterAcidDropTriggered
	LaunchSubStateEntryEvent SubState=AcidDrop

	// award an acid drop
	SetTrickName 'Acid Drop'
	if (<DropHeight> < 350)
		SetTrickScore ACID_DROP_POINTS
	else
		SetTrickScore ACID_BOMB_POINTS
	endif
	Display NoDegrade
endscript

/*
script WalkUpStairs
	Goto OnGroundAi
endscript

script WalkUpStairs_old z=1 stairs=30 bottomnode=TRG_StairwalkBottom01 topnode=TRG_StairwalkTop01
	DisablePlayerInput
	ClearExceptions
	SetException Ex=FlailHitWall        Scr=FlailHitWall
	SetException Ex=FlailLeft           Scr=FlailLeft
	SetException Ex=FlailRight          Scr=FlailRight
	change Skater_First_Forward_Collision_Height = 50
//	PlayAnim Anim=StandIdle Blendperiod=0.3
//	WaitAnimFinished

	Rotate Duration=.5 second node=<topnode>

	SetSkaterCamOverride heading=1.5 tilt=-.2 time=.5
	PlayAnim Anim=StairRun_Init Blendperiod=0.3
	begin
		Obj_GetDistToNode <topnode>
		if ( <dist> < 50 )
			PlayAnim Anim=StairRun_Init Blendperiod=0.1 backwards norestart
			WaitAnimFinished
			break
		endif
		if ( <dist> < 50 )
			break
		endif
		wait 1 gameframe
		If AnimFinished
			PlayAnim Anim=StairRun Blendperiod=0.0 cycle
			Printf "RUNNING UP STAIRS NOW"
		endif
	repeat
	change Skater_First_Forward_Collision_Height = 8
	ClearSkaterCamOverride
	MakeSkaterGoto OnGroundAi
endscript
 */
script PlayAnim_InLoop
	if AnimEquals <Anim>
		if Not AnimFinished <anim>
			PlayAnim Anim=<anim>  NoRestart
		else
			PlayAnim Anim=<cycle> cycle Norestart
		endif
	else
		PlayAnim Anim=<cycle> cycle Norestart
	endif
endscript
///////////////////////////////////////////////////////
// For debugging only
///////////////////////////////////////////////////////
script MakeSkaterFly
	MakeSkaterGoto	FlyAi
endscript


script FlyAi move=8
	ClearExceptions
	SetQueueTricks NoTricks
	setspeed 0
	SetState Air
	setrollingFriction 1000
	NoRailTricks
	begin
		If Held R2
			Jump
			Wait 8 frames
		endif
		if held L1
			break
		endif
		if held L2
			if held Square
				move x=18
			endif
			if Held Circle
				move x=-18
			endif
			if held Triangle
				move z=18
			endif
			if held X
				move z=-18
			endif
		else
			if held Square
				move x=6
			endif
			if Held Circle
				move x=-6
			endif
			if held Triangle
				move z=8
			endif
			if held X
				move z=-8
			endif
		endif
		waitonegameframe
	repeat
	AllowRailTricks
	MakeSkaterGoto OngroundAI
endscript
/*
// Hammer Check is an alternative to the revert and manual loop
// It checks to see if you pressed X in a small window right before
// and after you land. If you have not, you bail
script HammerCheck Hammertime=100
	SetQueueTricks Notricks
	ClearException Ollied
	if AirtimeGreaterThan .1 seconds
		GetTags
		// printstruct <...>
		SetExtraTricks tricks=Hammer duration=<hammertime>
		Wait <hammertime>
		create_panel_message text="Didn't Hammer!!!" id=hammer_message
		Goto DoingTrickBail
	endif
endscript


Hammer=
[
	{Trigger={Press,X,50}  scr=HammerGood }
]

script HammerGood
			create_panel_message text="Hammer" rgba=[0 128 0 128] id=hammer_message
			Obj_ClearFlag FLAG_SKATER_HAMMER_MODE
			SetTrickScore 1000
			SetTrickName '\c3Dropped the Hammer\c0'
			Display Blockspin
			Goto Land2
endscript

*/
