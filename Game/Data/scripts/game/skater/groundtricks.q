
TRICK_PRELOAD_TIME = 160

// Added by Ken: Used in the GroundGone script in tricks.q to allow late-jumping of the no-comply
Jumptricks0 =
[    {Trigger={PressAndRelease,Up,X,300}     	 Scr=NoComply Params={Name='No Comply' Score=100}} ]


Jumptricks =
[    {Trigger={TapTwiceRelease,Up,X,500}  TrickSlot=JumpSlot } ]


Trick_Boneless = {Scr=Boneless Params={Name='Boneless' Anim=Boneless Score=250}}
Trick_Fastplant = {Scr=Boneless Params={Name='Fastplant' Anim=Fastplant Score=250}}
Trick_Beanplant = {Scr=Boneless Params={Name='Beanplant' Anim=Beanplant Score=250}}



GroundTricks=
[
	{Trigger={TripleInOrder,a=Down,b=Down,R1,333} 		Scr=ToggleSwitchRegular Params={PowerSlide} }

	{Trigger={PressAndRelease,Up,X,300}     	 	Scr=NoComply Params={Name='No Comply' Score=100}}

	{Trigger={TripleInOrder,a=L1,b=L1,Triangle,500} 	Scr=Props Params={string_id=props_string}}
	{Trigger={TripleInOrder,a=L1,b=L1,Square,500}   	Scr=Taunt Params={Anim=Taunt1 	string_id=your_daddy_string }}
	{Trigger={TripleInOrder,a=L1,b=L1,Circle,500}   	Scr=Taunt Params={Anim=Taunt2 	string_id=no_way_string}}
	{Trigger={TripleInOrder,a=L1,b=L1,X,500}   			Scr=Taunt Params={Anim=Taunt3 	string_id=get_some_string}}

	{Trigger={Press,R2,20}                   		Scr=ToggleSwitchRegular NGC_Trigger={Press,R1,20} }
	{Trigger={Press,L2,20}                   		Scr=ToggleNollieRegular NGC_Trigger={Press,L1,20} }
]

// During this transition, the skater is in the odd situation of being on the ground yet still in a combo.  If standard GroundTricks were used in this
// situation, the skater would be able to excape landing his tricks.
WalkToSkateTransition_GroundTricks=
[
	;{Trigger={Press,R2,20}                   		Scr=ToggleSwitchRegular }
	{Trigger={Press,L2,20}                   		Scr=WalkToSkateTransition_ToggleStance NGC_Trigger={Press,L1,20} }

	;{Trigger={TripleInOrder,a=Down,b=Down,R1,333} 		Scr=ToggleSwitchRegular Params={PowerSlide} }


	{Trigger={PressAndRelease,Up,X,300}     	 	Scr=NoComply Params={Name='No Comply' Score=100}}

	;{Trigger={TripleInOrder,a=L1,b=L1,Triangle,500} 	Scr=Props Params={string_id=props_string}}
	;{Trigger={TripleInOrder,a=L1,b=L1,Square,500}   	Scr=Taunt Params={Anim=Taunt1 	string_id=your_daddy_string }}
	;{Trigger={TripleInOrder,a=L1,b=L1,Circle,500}   	Scr=Taunt Params={Anim=Taunt2 	string_id=no_way_string}}
	;{Trigger={TripleInOrder,a=L1,b=L1,X,500}   			Scr=Taunt Params={Anim=Taunt3 	string_id=get_some_string}}
]

NoTricks=
[
]


Reverts=
[
	{Trigger={Press,R2,200}  TrickSlot=ExtraSlot1 NGC_Trigger={Press,R1,200} }
	{Trigger={Press,L2,200}  TrickSlot=ExtraSlot2 NGC_Trigger={Press,L1,200} }//Params={BSName='To Tail' FSName='To Tail' FSAnim=DropIn BSAnim=DropIn}}
]

// Refactored setting of reverts, so that we can just check the expert mode flag in one place
script SetExtraTricks_Reverts duration=20
	If not GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_REVERTS
		if not ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_REVERTS))
			SetExtraTricks tricks=Reverts duration=<duration>
		endif
	endif
endscript


script Revert FSName='FS Revert' BSName='BS Revert' FSAnim=RevertFS BSAnim=RevertBS
	OnExitRun ExitRevert

	ClearLipCombos   // If we come out of a Lip trick into a revert we need to shut this off
	KillExtraTricks
	SetTrickScore 100
	OnGroundExceptions NoEndRun
	LaunchStateChangeEvent State=Skater_InRevert
	if not GetGlobalFlag flag=CHEAT_HOVERBOARD
		Obj_SpawnScript CessTrail params={repeat_times=10}
		PlayCessSound
		Vibrate Actuator=0 Percent=80 Duration=.5
		Vibrate Actuator=1 Percent=80 Duration=.1
	endif
	ClearException Ollied
	SetSpecialFriction [0,0,5,10,15,25] Duration=0.667
	CanKickOff
	// SetSpecialFriction [20,110,115,120,130,150] Duration=0.667
	/*
	if not Obj_FlagSet FLAG_SKATER_REVERTCHEESE
		SetSpecialFriction [0,0,0,0,0,0,0,0] //[0,10,15,20,30,50]
		Obj_SetFlag FLAG_SKATER_REVERTCHEESE
	//	SetTags RevertCheese=0
	else
		printf "::::::::::::::::::::::::::::::: revert cheese!!!!"
		PlaySound SaberTwirl5
		SetSpecialFriction [0,10,20,30,40,40]
	//	RevertCheeseIncrement
	//	printf "::::::::::::::::::::::::::::::: revert cheese= %r" r=<revertcheese>
	//	If (<RevertCheese> > 2)
	//		SetRollingFriction 40
	//	endif
	endif
	*/
	SetQueueTricks NoTricks
	SetSkaterAirManualTricks
	;OnExceptionRun	LandOut
	NollieOff
	PressureOff
	;cess180_1
	If Obj_FlagSet FLAG_SKATER_REVERTFS
		Obj_ClearFlag FLAG_SKATER_REVERTFS
		PlayAnim Anim=<FSanim> // From=70
		SetTrickName <FSname>
	else
		If Obj_FlagSet FLAG_SKATER_REVERTBS
			Obj_ClearFlag FLAG_SKATER_REVERTBS
			PlayAnim Anim=<BSAnim> // From=70
			SetTrickName <BSName>
		else
			if LastSpinWas Frontside
				PlayAnim Anim=<FSanim> // From=70
				SetTrickName <FSname>
			else
				PlayAnim Anim=<BSAnim> // From=70
				SetTrickName <BSName>
			endif
		endif
	endif
	Display Blockspin
	FlipAfter
	BoardRotateAfter
	BlendPeriodOut 0.0
	Wait .1 seconds
	SetException Ex=Ollied	Scr=Ollie
	ResetLandedFromVert // needed so that if we ollie out of a revert, we can do a manual when we get to the land script
	WaitAnimFinished
	CanKickOn
	DoNextManualTrick FromAir

	OnGroundExceptions

	LandSkaterTricks

	ClearEventBuffer

	PlayAnim Anim=CrouchIdle BlendPeriod=0.3
	WaitAnimWhilstChecking AndManuals
	Goto OnGroundAI
Endscript

script ExitRevert
	CanKickOn
	SetTrickName ''
	SetTrickScore 0
	Display Blockspin
endscript

script RevertCheeseTimer
	Obj_SetFlag FLAG_SKATER_REVERTCHEESE
	Wait 25 seconds
	SetTags RevertCheese=0
	Obj_ClearFlag FLAG_SKATER_REVERTCHEESE
endscript

script RevertCheeseIncrement
	Gettags
	<revertcheese> = (<revertcheese> +1)
	SetTags RevertCheese=<RevertCheese>
	return revertcheese=<revertcheese>
endscript

////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////
script ToggleSwitchRegular
	OnGroundExceptions
	SetQueueTricks NoTricks
	ClearTrickQueues

	if not GoalManager_GoalShouldExpire
		SetException Ex=Ollied Scr=Ollie Params={NoDoNextTrick}
	endif

	NollieOff
	if not GetGlobalFlag flag=CHEAT_HOVERBOARD
		Obj_SpawnScript CessTrail params={delay=3}
		Vibrate Actuator=0 Percent=80 Duration=.5
		Vibrate Actuator=1 Percent=80 Duration=.1
	endif
	If GotParam Powerslide
		Rotate y=180 duration=.3 seconds
		if LeftPressed
			if Flipped
				PlayAnim Anim=FSPowerslide
			else
				PlayAnim Anim=BSPowerslide
			endif
		else
			if RightPressed
				if Flipped
					PlayAnim Anim=BSPowerslide
				else
					PlayAnim Anim=FSPowerslide
				endif
			else
				PlayAnim Anim=FSPowerslide
			endif
		endif
	else
		if LeftPressed
			if Flipped
				if not crouched
					PlayAnim Random (@Anim=CessSlide180_FS @Anim=CessSlide180_FS2)
				else
					PlayAnim Anim=CrouchCessSlide180_FS
				endif
			else
				if not crouched
					PlayAnim Anim=CessSlide180_BS
				else
					PlayAnim Anim=CrouchCessSlide180_BS
				endif
			endif
		else
			if RightPressed
				if Flipped
					if not crouched
						PlayAnim Anim=CessSlide180_BS
					else
						PlayAnim Anim=CrouchCessSlide180_BS
					endif
				else
					if not crouched
						PlayAnim Random (@Anim=CessSlide180_FS @Anim=CessSlide180_FS2)
					else
						PlayAnim Anim=CrouchCessSlide180_FS
					endif
				endif
			else
				if not crouched
					PlayAnim Random (@Anim=CessSlide180_FS @Anim=CessSlide180_FS2)
				else
					PlayAnim Anim=CrouchCessSlide180_FS
				endif
			endif
		endif
	endif

	; this is so that if you jump out after the board is half way
	; around, you still flip and get the effect of the cess
	WaitAnim 30 percent

	if not GetGlobalFlag flag=CHEAT_HOVERBOARD
		PlayCessSound ;cess180_1
	endif
	WaitAnim 35 percent
	SetSkaterGroundTricks
	FlipAfter
	BoardRotateAfter
	BlendperiodOut 0.0
	WaitAnimWhilstChecking AndManuals
	If not GotParam Powerslide
		if CanKick
			PlayAnim Anim=PushCycle Cycle BlendPeriod=0.0
		else
			if AnimFinished
				if not crouched
					PlayAnim Anim=Idle Cycle BlendPeriod=0.0
				else
					If not AnimEquals [CrouchCessSlide180_FS CrouchCessSlide180_BS]
						//this is only so that after the flip, when standing, we can blend to the crouch
						PlayAnim Anim=Idle Cycle BlendPeriod=0.0
						PlayAnim Anim=CrouchIdle Cycle BlendPeriod=0.2
					else
						PlayAnim Anim=CrouchIdle Cycle BlendPeriod=0.0
					endif
				endif
			endif
		endif
	else
		PlayAnim Anim=CrouchIdle Cycle BlendPeriod=0.0
	endif
	ClearTrickQueue
	goto OnGroundAI
endscript


script CessTrail repeat_times=20
	if SpeedGreaterThan 400
		if GotParam delay
			wait <delay> frames
		endif
		begin
			if not onground
				break
			else
				if IsXbox
					TextureSplat size=6 radius=0 bone=Bone_Board_Tail name="skidtrail" trail lifetime=15
					TextureSplat size=6 radius=0 bone=Bone_Board_Nose name="skidtrail" trail lifetime=15
				else
					TextureSplat size=6 radius=0 bone=Bone_Board_Tail name="skidtrail_ps2" trail lifetime=15
					TextureSplat size=6 radius=0 bone=Bone_Board_Nose name="skidtrail_ps2" trail lifetime=15
				endif
			endif
			wait 1 game frame
		repeat <repeat_times>
	endif
endscript
////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////
script ToggleNollieRegular
	OnGroundExceptions
	ClearTrickQueues

	ApplyStanceToggle

	if not InNollie
		if not InPressure
			// Normal Mode
			if not GoalManager_GoalShouldExpire
				SetException Ex=Ollied              Scr=Ollie
			endif
			if Crouched
				PlayAnim Anim=CrouchToNollie BlendPeriod=0.1 Backwards
			else
				PlayAnim Anim=SkatingToNollie BlendPeriod=0.1 Backwards
			endif
		else
			// Pressure Mode
			if not GoalManager_GoalShouldExpire
				SetException Ex=Ollied              Scr=Ollie
			endif
			if Crouched
				PlayAnim Anim=CrouchToPressure BlendPeriod=0.1
			else
				PlayAnim Anim=SkateToPressure BlendPeriod=0.1
			endif
		endif
	else
		// Nollie Mode
		if not GoalManager_GoalShouldExpire
			SetException Ex=Ollied              Scr=Nollie
		endif
		if Crouched
			PlayAnim Anim=CrouchToNollie BlendPeriod=0.1
		else
			PlayAnim Anim=SkatingToNollie BlendPeriod=0.1
		endif
	endif
	WaitAnimWhilstChecking AndManuals
	If InNollie
		Goto OnGroundNollieAI
	else
		Goto OnGroundAi
	endif
endscript

script ApplyStanceToggle
	if InNollie
		PressureOff
		NollieOff
	else
		if InPressure
			PressureOff
			NollieOn
		else
			NollieOff
			PressureOn
		endif
	endif
endscript



////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

script Nollie
	If GotParam NoDoNextTrick
	else
		DoNextTrick
	endif
	ClearTrickQueue
	ClearEventBuffer Buttons=Dpad OlderThan=TRICK_PRELOAD_TIME
	Jump
	InAirExceptions
	Vibrate Actuator=1 Percent=50 Duration=.05
	NollieOn
	PlayAnim Anim=Nollie  BlendPeriod=0.1
	if ProfileEquals stance=regular
		if Flipped
			SetTrickName 'Nollie'
			SetTrickScore 200
		else
			SetTrickName 'Fakie Ollie'
			SetTrickScore 200
		endif
	else
		if Flipped
			SetTrickName 'Fakie Ollie'
			SetTrickScore 200
		else
			SetTrickName 'Nollie'
			SetTrickScore 200
		endif
	endif
	Display
	BailOff
	WaitAnimWhilstChecking
	goto Airborne
endscript

script NollieNoDisplay OutSpeed=1
	StopBalanceTrick     // Added this as exceptions don't do it
	ClearTrickQueue
	ClearEventBuffer Buttons=Dpad OlderThan=TRICK_PRELOAD_TIME
	SetTrickName 'Nollie'
	SetTrickScore 100
	Display Deferred
	Jump
	InAirExceptions
	Vibrate Actuator=1 Percent=80 Duration=.05
	NollieOn
	If GotParam OutAnim
		PlayAnim Anim=<OutAnim> BlendPeriod=0.3 Speed=<OutSpeed>
	else
		PlayAnim Anim=Nollie  BlendPeriod=0.1
	endif
	If GotParam BoardRotate
		BlendPeriodOut 0
		BoardRotateAfter
	endif
	BailOff
	WaitAnimWhilstChecking
	goto Airborne
endscript

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////

Dpad=[Up Down Left Right Upright UpLeft DownRight DownLeft]


//////////////////////////// PRESSURE FLIP TEST
script  GetPressureState pressure=0 pressuretimer=0
	GetTags
	return Pressure=<pressure> PressureTimer=<pressuretimer>
endscript

script Ollie OutSpeed=1
	StopBalanceTrick     // Added this as exceptions don't do it
	StopSkitch
	If GotParam NoDoNextTrick
	else
		DoNextTrick    // We need to do a last check for any queued up jumptricks, like no complys, and run those if you really meant to do them.
	endif
	; Make sure no ground tricks that might have got queued up go off.
	; Without this, it is possible to get a nocomply if one presses up quickly
	; just before pressing x after landing.
	ClearTrickQueue
	// This kills any D-pad presses older than 100 ms, to prevent "turn" taps from
	// being interpreted as special trick taps, and should help minimize the ever so
	// annoying "specials by accident" bug
	ClearEventBuffer Buttons=Dpad OlderThan=TRICK_PRELOAD_TIME

	// The X tap which caused the ollie will not count towards wallplants.
	ClearEventBuffer Buttons=[ X ] OlderThan=0

	if not GotParam JumpSpeed
		Jump
	else
		Jump Speed=<JumpSpeed>
	endif
	InAirExceptions

	If InPressure
		SetTrickName 'Pressure'
		SetTrickScore 200
		Display
	endif
	If InNollie
		if ProfileEquals stance=regular
			if Flipped
				SetTrickName 'Nollie'
				SetTrickScore 200
			else
				SetTrickName 'Fakie Ollie'
				SetTrickScore 200
			endif
		else
			if Flipped
				SetTrickName 'Fakie Ollie'
				SetTrickScore 200
			else
				SetTrickName 'Nollie'
				SetTrickScore 200
			endif
		endif
		Display
	else
		SetTrickName 'Ollie'
		SetTrickScore 75
		Display Deferred
	endif

	Vibrate Actuator=1 Percent=50 Duration=.05
	If GotParam FromLip
		printf "came from lip=================="
		PlayAnim Anim=<OutAnim> BlendPeriod=0.0
		BlendperiodOut 0
	else
		If GotParam OutAnim								; this is so some tricks can force their outanim
			if GotParam SyncOutAnimToPreviousAnim
				PlayAnim Anim=<OutAnim> BlendPeriod=0.3 Speed=<OutSpeed> SyncToPreviousAnim
			else
				If GotParam NoBlend
					PlayAnim Anim=<OutAnim> BlendPeriod=0.0 Speed=<OutSpeed>
				else
					PlayAnim Anim=<OutAnim> BlendPeriod=0.3 Speed=<OutSpeed>
				endif
			endif
		else
			If InNollie
				PlayAnim Anim=Nollie  BlendPeriod=0.1
			else
				PlayAnim Anim=Ollie  BlendPeriod=0.0 NoRestart
			endif
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
	BailOff
	WaitAnimWhilstChecking
	goto Airborne
endscript


////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
script NoComply
	; Make sure no ground tricks that might have got queued up go off.
	ClearTrickQueue
	// This kills any D-pad presses older than 100 ms, to prevent "turn" taps from
	// being interpreted as special trick taps, and should help minimize the ever so
	// annoying "specials by accident" bug
	ClearEventBuffer Buttons=Dpad OlderThan=TRICK_PRELOAD_TIME
	Jump
	NollieOff
	PressureOff
	InAirExceptions
	Vibrate Actuator=1 Percent=80 Duration=.05
	SetTrickName <Name>
	SetTrickScore <Score>
	Display
	BailOff
	PlayAnim Anim=NoComply BlendPeriod=0.2
	WaitAnimWhilstChecking
	goto Airborne
endscript

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
script Beanplant
	; Make sure no ground tricks that might have got queued up go off.
	ClearTrickQueue
	// This kills any D-pad presses older than 100 ms, to prevent "turn" taps from
	// being interpreted as special trick taps, and should help minimize the ever so
	// annoying "specials by accident" bug
	ClearEventBuffer Buttons=Dpad OlderThan=TRICK_PRELOAD_TIME
	Jump BonelessHeight
	InAirExceptions
	Vibrate Actuator=1 Percent=80 Duration=.1
	PlaySound boneless09 pitch=85
	SetTrickName <Name>
	SetTrickScore <Score>
	Display
	PlayAnim Anim=Beanplant BlendPeriod=0.2
	WaitAnimWhilstChecking
	goto Airborne
endscript

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
script Fastplant
	; Make sure no ground tricks that might have got queued up go off.
	ClearTrickQueue
	// This kills any D-pad presses older than 100 ms, to prevent "turn" taps from
	// being interpreted as special trick taps, and should help minimize the ever so
	// annoying "specials by accident" bug
	ClearEventBuffer Buttons=Dpad OlderThan=TRICK_PRELOAD_TIME
	Jump BonelessHeight
	InAirExceptions
	Vibrate Actuator=1 Percent=80 Duration=.1
	SetTrickName <Name>
	SetTrickScore <Score>
	Display
	PlayAnim Anim=FastPlant BlendPeriod=0.2
	BailOff
	WaitAnimWhilstChecking
	goto Airborne
endscript

////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
script Boneless Anim=Boneless Name='Boneless' Score=250
	; Make sure no ground tricks that might have got queued up go off.
	ClearTrickQueue
	// This kills any D-pad presses older than 100 ms, to prevent "turn" taps from
	// being interpreted as special trick taps, and should help minimize the ever so
	// annoying "specials by accident" bug
	ClearEventBuffer Buttons=Dpad OlderThan=TRICK_PRELOAD_TIME
	Jump BonelessHeight
	NollieOff
	PressureOff
	InAirExceptions
	Vibrate Actuator=1 Percent=80 Duration=.1
	PlaySound boneless09 pitch=85
	SetTrickName <Name>
	SetTrickScore <Score>
	If not SkaterIsNamed vallely
		PlayAnim Anim=<Anim> BlendPeriod=0.2
	else
		PlayAnim Anim=_540Boneless BlendPeriod=0.1 Speed=1.25 from=10
		SetTrickScore 300
		SetTrickName "MikeV Boneless"
		FlipAfter
		BlendPeriodOut 0
	endif
	Display
	BailOff
	WaitAnimWhilstChecking
	goto Airborne
endscript

script BonelessWaitAnimWhilstChecking
	begin
		DoNextTrick
		if GotParam AndManuals
			DoNextManualTrick
		endif
		if AnimFinished
			break
		endif
		WaitOneGameFrame
		If OnGround
			Goto	Land
		endif
	repeat
endscript

script SendTauntMessage
	GetPreferenceString pref_type=taunt <string_id>
	SendChatMessage string=<ui_string>
endscript

script Taunt
	LandSkaterTricks
	ClearException Ollied
	PlayAnim	Anim=<anim>	Blendperiod=0.3
	//LaunchPanelMessage <PanelMessage>
	GetPreferenceString pref_type=taunt <string_id>
	//create_panel_block id=taunt_msg_id text=<ui_string>
	if InNetGame
		SendChatMessage string=<ui_string>
	endif
	// a little wait to make sure that we don't accidentally ollie on the X button taunt
	Wait 10 Game frame
	OnGroundExceptions
	If SpeedLessThan 1
		SetRollingFriction 100
		WaitAnimWhilstChecking AndManuals
		Goto Handbrake
	else
		WaitAnimWhilstChecking AndManuals
		Goto OnGroundAi
	endif
endscript


script Props
	LandSkaterTricks
	OnGroundExceptions
	PlayAnim	Random (@Anim=Prop @Anim=Cheer1)	Blendperiod=0.3
	GetPreferenceString pref_type=taunt <string_id>
	if InNetGame
		SendChatMessage string=<ui_string>
		// removed by SP as messages are overlapping and causing problems
		//else
		//	create_panel_block id=taunt_msg_id text=<ui_string>
	endif
	If SpeedLessThan 1
		SetRollingFriction 100
		WaitAnimWhilstChecking AndManuals
		Goto Handbrake
	else
		WaitAnimWhilstChecking AndManuals
		Goto OnGroundAi
	endif
endscript
/*
script Taunt1
	OnGroundExceptions
	PlayAnim	Anim=Taunt1	NoRestart Blendperiod=0.3
	GetPreferenceString pref_type=network <string_id>
	create_panel_block id=taunt_msg_id text=<ui_string>
	if InNetGame
		SendChatMessage string=<ui_string>
	endif
	WaitAnimWhilstChecking AndManuals
	Goto OnGroundAi
endscript

script Taunt2
	OnGroundExceptions
	PlayAnim	Anim=Taunt2	NoRestart Blendperiod=0.3
	GetPreferenceString pref_type=network <string_id>
	create_panel_block id=taunt_msg_id text=<ui_string>
	if InNetGame
		SendChatMessage string=<ui_string>
	endif
	WaitAnimWhilstChecking AndManuals
	Goto OnGroundAi
endscript

script Taunt3
	OnGroundExceptions
	ClearException Ollied
	PlayAnim	Anim=Taunt3	NoRestart Blendperiod=0.3
	GetPreferenceString pref_type=network <string_id>
	create_panel_block id=taunt_msg_id text=<ui_string>
	if InNetGame
		SendChatMessage string=<ui_string>
	endif
	WaitAnimWhilstChecking AndManuals
	Goto OnGroundAi
endscript
*/
script BitchSlap
	OnGroundExceptions
	PlayAnim	Anim=Slapright	NoRestart Blendperiod=0.3
	WaitAnimWhilstChecking AndManuals
	Goto OnGroundAi
endscript

////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Skitchin'!!!!
////////////////////////////////////////////////////////////////////////////////////////////////////////

script Skitch
	StopBalanceTrick     // Added this as exceptions don't do it
	ClearExceptions
	ResetLandedFromVert
	KillExtraTricks

	; Mick: we don't care if the ground is gone, as we trust the vehicle to drag us in a safe manner...
	; so, if you want, it can drag you through the air, or over water!

	;SetException Ex=GroundGone          Scr=GroundGone Params={NoBoneless}

	SetEventHandler Ex=MadeOtherSkaterBail	Scr=MadeOtherSkaterBail_Called
	SetException Ex=Ollied          	Scr=Ollie Params={<...>}
	;SetException Ex=FlailHitWall        Scr=FlailHitWall
	;SetException Ex=FlailLeft           Scr=FlailLeft
	;SetException Ex=FlailRight          Scr=FlailRight
	SetException Ex=OffMeterTop			Scr=SkitchOut      //<OffMeterTop> Params={<...>}
	SetException Ex=OffMeterBottom		Scr=SkitchOut      //<OffMeterBottom> Params={<...>}
	;SetException Ex=Carplant			Scr=CarPlant
	SetException Ex=CarBail				Scr=CarBail
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	LaunchStateChangeEvent State=Skater_Skitching
	// probably need a SkitchOut anim
	// OnExceptionRun ManualOut
	ClearTrickQueue
	SetQueueTricks NoTricks

	ClearManualTrick
	SetManualTricks NoTricks

	StartSkitch
	StartBalanceTrick
	PlayAnim Anim=SkitchInit
	WaitAnimFinished


	// Some defaults... should be passed in?
	PlaySound Hud_jumpgap
	SetTrickName "\c2Skitchin\C0"               // <Name>
	SetTrickScore 500                 // <Score>
	Display Blockspin
	DoBalanceTrick ButtonA=Right ButtonB=Left Type=Skitch Tweak=5
	PlayAnim Anim=SkitchRange wobble

	SetEventHandler Ex=SkitchLeft Scr=SkitchAnimLeft
	SetEventHandler Ex=SkitchRight Scr=SkitchAnimRight
	begin
		// temporary override of the speed limits
		// to allow us to keep whatever speed we got from skitching
		// the gravity=0 makes it so skating up slopes does not slow us down
		// (but skating down them still speeds you up)
		overridelimits max = 1750 friction = 0 time = 5 gravity = 0
		if AnimFinished
			PlayAnim Anim=SkitchRange wobble Norestart
		endif
		if held down
			Obj_SpawnScript NoBrake_Timer
			Goto SkitchOut
		endif
		Waitonegameframe
	repeat
endscript

script SkitchAnimLeft
	PlayAnim Anim=SkitchMoveLeft From=20 NoRestart Speed=2 BlendPeriod=0.1
endscript

script SkitchAnimRight
	PlayAnim Anim=SkitchMoveRight From=20 NoRestart Speed=2 BlendPeriod=0.1
endscript

script SkitchOut
	StopSkitch
	StopBalanceTrick
	PlayAnim Anim=SkitchInit Backwards
	OnGroundExceptions
	// don't let the player immediately reskitch to fix the problem where you lose
	// balance
	ClearException Skitched

	LandSkaterTricks

	WaitAnimFinished
	Goto OnGroundAi
endscript

script NoBrake_Timer
	// Since you release from a skitch by tapping down, we need to make sure not to
	// let the physics brake you for a short time, so that you will not lose your boost
	CanBrakeOff
	Wait .5 seconds
	CanBrakeOn
endscript


