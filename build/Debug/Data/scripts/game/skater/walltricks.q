////////////////////////////////////////////////////////////
// Wallrides and Stuff
////////////////////////////////////////////////////////////

script WallRide
	ClearExceptions
	SetException Ex=Landed      		Scr=Land Params={NoBlend IgnoreAirTime}
	SetException Ex=Ollied      		Scr=Wallie
	SetException Ex=GroundGone			Scr=WallrideEnd
	SetException Ex=PointRail			Scr=PointRail
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	LaunchStateChangeEvent State=Skater_OnWall
	Vibrate Actuator=1 Percent=40
	; Move the character up the wall about 3 feet, to make the wallride feel better
	Obj_ClearFlag FLAG_SKATER_MANUALCHEESE
	If GotParam Left
		move x=36
	else
		move x=-36
	endif

	if BailIsOn
		SetState	Air
		Goto Shoulders
	endif

	BailOff
	SetQueueTricks WallRideTricks
	NollieOff
	PressureOff
	SetTrickScore 200
	PlayCessSound    ;eventually need to move the playing off this sound a few frames later

	; determine which type of wallride - BS or FS
	; if BS_Wallride is set, its BS; if not, its FS
	if GotParam Left
		if Flipped
			if not IsFlipAfterSet
				BS_Wallride=1
			endif
		else
			if IsFlipAfterSet
				BS_Wallride=1
			endif
		endif
	else
		if not Flipped
			if not IsFlipAfterSet
				BS_Wallride=1
			endif
		else
			if IsFlipAfterSet
				BS_Wallride=1
			endif
		endif
	endif

	if GotParam BS_Wallride
		SetTrickName 'BS Wallride'
		PlayAnim Anim=WallRideBackTrans BlendPeriod=0.0
		WaitAnimFinished
		PlayAnim Anim=WallRideBackLoop BlendPeriod=0.1 Cycle
	else
		SetTrickName 'FS Wallride'
		PlayAnim Anim=WallRideFrontTrans BlendPeriod=0.0
		WaitAnimFinished
		PlayAnim Anim=WallRideFrontLoop BlendPeriod=0.1 Cycle
	endif

	/*
	if GotParam Left
		if Flipped
			SetTrickName 'BS Wallride'
			PlayAnim Anim=WallRideBackTrans BlendPeriod=0.0
			WaitAnimFinished
			PlayAnim Anim=WallRideBackLoop BlendPeriod=0.1 Cycle
		else
			SetTrickName 'FS Wallride'
			PlayAnim Anim=WallRideFrontTrans BlendPeriod=0.0
			WaitAnimFinished
			PlayAnim Anim=WallRideFrontLoop BlendPeriod=0.1 Cycle
		endif
	else
		if Flipped
			SetTrickName 'FS Wallride'
			PlayAnim Anim=WallRideFrontTrans BlendPeriod=0.0
			WaitAnimFinished
			PlayAnim Anim=WallRideFrontLoop BlendPeriod=0.1 Cycle
		else
			SetTrickName 'BS Wallride'
			PlayAnim Anim=WallRideBackTrans BlendPeriod=0.0
			WaitAnimFinished
			PlayAnim Anim=WallRideBackLoop BlendPeriod=0.1 Cycle
		endif
	endif
	*/

	Display
	begin
		TweakTrick 25
		wait 1 frame
		DoNextTrick
	repeat
endscript

// Triggered when you wallride off a wall

script WallRideEnd
	BlendPeriodOut 0
	SetException Ex=Landed      		Scr=Land
	ClearExceptions
	if Inair
		Goto Airborne
	endif
endscript

// Triggered when you're in a wallride and press X to ollie out of it

script Wallie
	DoNextTrick
	Vibrate Actuator=1 Percent=50 Duration=.1
	PlayAnim Anim=Ollie  BlendPeriod=0.0
	SetTrickName 'Wallie'
	SettrickScore 250
	InAirExceptions
	Display
	Jump
	WaitAnimWhilstChecking
	goto Airborne BlendPeriod=0
endscript

WallRideTricks =
[    {Trigger={TapTwiceRelease,Up,X,500}  Scr=Trick_WallPlant } ]

script Trick_WallPlant
	InAirExceptions
	Vibrate Actuator=1 Percent=50 Duration=.1
	PlayAnim Anim=Boneless  BlendPeriod=0.0
	SetTrickName 'WalliePlant'
	SettrickScore 500
	Display
	Jump BonelessHeight
	WaitAnimWhilstChecking
	goto Airborne BlendPeriod=0
endscript

WALLPLANT_WINDOW=450
Wallplant_Trick=
[
	{ InOrder,X,Down,WALLPLANT_WINDOW }
	{ InOrder,X,DownLeft,WALLPLANT_WINDOW }
	{ InOrder,X,DownRight,WALLPLANT_WINDOW }
	{ InOrder,Down,X,WALLPLANT_WINDOW }
	{ InOrder,DownLeft,X,WALLPLANT_WINDOW }
	{ InOrder,DownRight,X,WALLPLANT_WINDOW }
]

// Tweak: "Wallplant on X (no Down)". The engine forbids change() on an Array-typed global (it would
// reallocate and fragment), so we can't swap Wallplant_Trick at runtime. Instead keep BOTH arrays
// static and let check_for_wallplant (C++) pick based on the tweak_wallplant_easy flag.
Wallplant_Trick_Easy =
[
	{ Tap,X,WALLPLANT_WINDOW }
]

Post_Wallplant_No_Ollie_Window=100
Post_Wallplant_Allow_Ollie_Window=250
WallplantOllie=
[
	{ Trigger={ Tap,X,Post_Wallplant_Allow_Ollie_Window } Scr=Ollie Params={ JumpSpeed=200 } }
]

// skater gotos here if he wall plants
script Air_Wallplant
	if BailIsOn
		SetState Air
		Goto Shoulders
	endif

	PressureOff
	NollieOff

	InAirExceptions
	ClearException Ollied

	LaunchStateChangeEvent State=Skater_InWallplant

	Vibrate Actuator=1 Percent=100 Duration=0.1


	SetTrickName ""
	SetTrickScore 0
	Display Blockspin

	PlayAnim Anim=Wallplant_Ollie3 BlendPeriod=0
	SetTrickName 'Wallplant'
	SetTrickScore 750
	Display

	GetStartTime
	begin
		GetElapsedTime StartTime=<StartTime>
		if (<ElapsedTime> > Post_Wallplant_No_Ollie_Window)
			break
		endif
		DoNextTrick
		Wait 1 GameFrame
	repeat

	ClearEventBuffer Buttons=[ X ] OlderThan=0
	SetSkaterAirTricks AllowWallplantOllie

	GetStartTime
	begin
		GetElapsedTime StartTime=<StartTime>
		if (<ElapsedTime> > Post_Wallplant_Allow_Ollie_Window)
			break
		endif
		DoNextTrick
		Wait 1 GameFrame
	repeat

	SetSkaterAirTricks
	WaitAnimWhilstChecking

	Goto Airborne
endscript

// skater gotos here if he wall pushes
script Ground_Wallpush
	Init_Wallpush

	if Crouched
		PlayAnim Anim=Wallplant_Crouched BlendPeriod=0
	else
		PlayAnim Anim=Wallplant_Standing BlendPeriod=0
	endif
	BlendPeriodOut 0
	BoardRotateAfter
	FlipAfter

	SetTrickName 'Wallpush'
	SetTrickScore 10
	Display BlockSpin

	WaitWhilstChecking AndManuals Duration=Physics_Disallow_Rewallpush_Duration

	LandSkaterTricks
	WaitAnimWhilstChecking AndManuals

	// KLUDGE: play a one-frame animation to allow blending into crouch animations
	if AnimEquals Wallplant_Standing
		if Crouched
			PlayAnim Anim=Idle
			DoNextTrick
			DoNextManualTrick
			Wait 1 GameFrame
		endif
	endif

	Goto OnGroundAi
endscript

script Manual_CancelWallpushEvent
	CancelWallpush
endscript

Wallpush_Trick = { Name='Wallpush' Score=10 NoBlend FlipAfter Anim=Wallplant_NoseManual BalanceAnim=Manual_Range BalanceAnim2=Manual_Range2 BalanceAnim3=Manual_Range3 OffMeterTop=ManualBail OffMeterBottom=ManualLand ExtraTricks2=ManualBranches ExtraTricks=FlatlandBranches AllowWallpush }
NoseWallpush_Trick = { Name='Wallpush' Score=10 NoBlend FlipAfter Anim=Wallplant_Manual BalanceAnim=NoseManual_Range BalanceAnim2=NoseManual_Range Nollie OffMeterTop=ManualLand OffMeterBottom=NoseManualBail ExtraTricks2=NoseManualBranches ExtraTricks=FlatlandBranches AllowWallpush }

script Manual_Wallpush
	Init_Wallpush

	// trigger the manual trick explicitly
	BlendPeriodOut 0
	if GotParam ToNoseManual
		Goto ManualLink Params={ NoseWallpush_Trick }
	else
		Goto ManualLink Params={ Wallpush_Trick }
	endif
endscript

script Init_Wallpush
	BroadcastEvent Type=SkaterWallpush
	Vibrate Actuator=1 Percent=50 Duration=0.15
endscript


// Currently not making the player bail - THPS2 was a bit harsh

// script WallRideBail
// printf "Wall ride bail"
// endscript



