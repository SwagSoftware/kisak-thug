;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Grind Macro	1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Ken addition for making the skater skate in when losing balance from a grind.
script SkateInOrBail moveleft=1 moveright=-1 movey=-5
	GetTags
	// we can't let you re-rail after you roll into a transition, as you could keep a combo going without a revert
	NoRailTricks
	StopBalanceTrick
	KillExtraTricks
	SetExtraTricks NoTricks
	//Printstruct <...>
	OnGroundExceptions NoEndRun
	ClearException GroundGone
	OnExceptionRun SkateInOrBail_Out
	SetQueueTricks NoTricks
	ClearManualTrick
	If GotParam Fallingright
		Goto SkateIn_Right Params={<...>}
	endif
	If GotParam FallingLeft
		Goto SkateIn_Left Params={<...>}
	endif
	// we got here by the triggering of R2
	If GotParam GrindRelease
		If Held Right
			Goto SkateIn_Right Params={<...>}
		endif
		If Held Left
			Goto SkateIn_Left Params={<...>}
		endif
		If SkateInAble Left
			Goto SkateIn_Left Params={<...>}
		else
			Goto SkateIn_Right Params={<...>}
		endif
	endif

	printf "Missing a FallingLeft or FallingRight ?"
	if GotParam GrindBail
		goto <GrindBail>
	else
		goto FiftyFiftyFall
	endif

endscript

script SkateIn_Right
	if SkateInAble Right
		printf "SkateInable RIGHT >>>>>>>>>>>>>>>>>>>>>>>>"
		SetLandedFromVert
		SetState ground
		Move y=-5
		Move x=-1
		OrientToNormal

		Rotate y=-30 Duration=.2 seconds
		OnGroundExceptions NoEndRun
		ClearException GroundGone

		// make sure to set up OnExceptionRun AFTER all clearexception calls, as those will also clear OnExceptionRuns
		OnExceptionRun SkateInOrBail_Out
		SetQueueTricks NoTricks
		SetManualTricks NoTricks
		SetExtraTricks_Reverts
		If GotParam OutAnim
			PlayAnim Anim=<outanim> BlendPeriod=0.3
		else
			PlayAnim Anim=<initanim> Backwards BlendPeriod=0.3
		endif
		WaitAnimWhilstChecking
		//		WaitOneGameFrame
		goto SkateInLand
	else
		Move y=<movey>
		Move x=<moveright>
		SkateIn_Bail <...>
	endif
endscript

script SkateIn_Left
	if SkateInAble Left
		SetLandedFromVert
		printf "SkateInable LEFT >>>>>>>>>>>>>>>>>>>>>>>>"
		SetState Ground
		Move x=1
		Move y=-5
		OrientToNormal

		Rotate y=30 Duration=.2 seconds
		setstate ground
		OnGroundExceptions NoEndRun
		ClearException GroundGone

		// make sure to set up OnExceptionRun AFTER all clearexception calls, as those will also clear OnExceptionRuns
		OnExceptionRun SkateInOrBail_Out
		SetQueueTricks NoTricks
		SetManualTricks NoTricks
		SetExtraTricks_Reverts
		If GotParam OutAnim
			PlayAnim Anim=<outanim> BlendPeriod=0.3
		else
			PlayAnim Anim=<initanim> Backwards BlendPeriod=0.3
		endif
		WaitAnimWhilstChecking
		goto SkateInLand
	else
		printf "Not skateinable left >>>>>>>>>>>>>>>>>>>>>>>>"
		Move y=<movey>
		Move x=<moveright>
		SkateIn_Bail <...>
	endif
endscript

Script SkateIn_Bail
	// In Too Easy mode, you will not bail
	if GetGlobalFlag Flag=DIFFICULTY_MODE_TOO_EASY
		if NOT InNetGame
			OffRail <...>
			return
		endif
	endif

	if GotParam GrindBail
		goto <GrindBail>
	else
		goto FiftyFiftyFall
	endif

endscript

script SkateInLand
	OnExceptionRun	SkateInLandOut
	NollieOff
	PressureOff
	;;; now let's check to see if you have a manual queued up
	;;; but you won't get it off if you came from Vert
	Vibrate Actuator=1 Percent=80 Duration=.1
	; start playing some anims
	if Crouched
		PlayAnim Anim=CrouchedLand BlendPeriod=0.1
	else
		PlayAnim Anim=Land BlendPeriod=0.1
	endif
	//ClearTrickQueue  removed by SP post THPS4, I can't see why we need this and it is clearing out
	// manuals that are queued up super quickly at the start of SkateInOrBail
	OnExceptionRun SkateInLandOut
	;;; because if you don't, we're gonna end you combo and
	;;; clear the panel
	OnGroundExceptions NoEndRun
	// Calling OngroundExceptions will allow us to do manuals, which means unless we disable the manuals
	// you will be able to drop into a ramp and then pop into a manual to continue your combo
	// This is bad; we want to force a linking revert, so manuals must be disabled as long as the run can not
	// end (as long as _NoEndRun is active)
	SetManualTricks NoTricks
	WaitAnim 10 percent

	LandSkaterTricks
	OnGroundExceptions
	CheckforNetBrake
	AllowRailtricks
	WaitAnimWhilstChecking AndManuals
	goto OnGroundAI
endscript

script SkateInLandOut
	AllowRailtricks
	LandSkaterTricks
endscript


script SkateInOrBail_Out
	printf " =================================== LAND =================================="
	LandSkaterTricks
endscript

Extra_FS_Grinds =
[
	{Trigger={InOrder,a=Triangle,b=Triangle,300}  	Scr=Trick_5050_FS Params={Name='FS 50-50' IsExtra=yes}}
	{Trigger={InOrder,Triangle,Square,300}  	Scr=Trick_NoseSlide_FS Params={Name='FS Noseslide' IsExtra=yes}}
	{Trigger={InOrder,Triangle,Circle,300}  	Scr=Trick_Nosegrind_FS Params={Name='FS Nosegrind' IsExtra=yes}}

	{Trigger={InOrder,a=Circle,b=Circle,300} 		Scr=Trick_Crooked_FS  Params={Name='FS Crooked' IsExtra=yes}}
	{Trigger={InOrder,Circle,Square,300} 		Scr=Trick_Bluntslide_FS Params={Name='FS Bluntslide' IsExtra=yes}}
	{Trigger={InOrder,Circle,Triangle,300} 		Scr=Trick_NoseBluntSlide_FS Params={Name='FS Nosebluntslide' IsExtra=yes}}

	{Trigger={InOrder,a=Square,b=Square,300} 		Scr=Trick_Smith_FS Params={Name='FS Smith' IsExtra=yes}}
	{Trigger={InOrder,Square,Circle,300} 		Scr=Trick_5_0_FS Params={Name='FS 5-0' IsExtra=yes}}
	{Trigger={InOrder,Square,Triangle,300} 		Scr=Trick_Tailslide_FS Params={Name='FS Tailslide' IsExtra=yes}}
]

Extra_BS_Grinds =

[
	{Trigger={InOrder,a=Triangle,b=Triangle,300}  	Scr=Trick_5050_BS Params={Name='BS 50-50' IsExtra=yes}}
	{Trigger={InOrder,Triangle,Square,300}  	Scr=Trick_NoseSlide_BS Params={Name='BS Noseslide' IsExtra=yes}}
	{Trigger={InOrder,Triangle,Circle,300}  	Scr=Trick_Nosegrind_BS Params={'BS Nosegrind' IsExtra=yes}}

	{Trigger={InOrder,a=Circle,b=Circle,300} 		Scr=Trick_Crooked_BS Params={Name='BS Crooked' IsExtra=yes}}
	{Trigger={InOrder,Circle,Square,300} 		Scr=Trick_Bluntslide_BS Params={Name='BS Bluntslide' IsExtra=yes}}
	{Trigger={InOrder,Circle,Triangle,300} 		Scr=Trick_NoseBluntSlide_BS Params={Name='BS Nosebluntslide' IsExtra=yes}}

	{Trigger={InOrder,Square,Triangle,300} 		Scr=Trick_Tailslide_BS Params={Name='BS Tailslide' IsExtra=yes}}
	{Trigger={InOrder,a=Square,b=Square,300} 		Scr=Trick_Smith_BS Params={Name='BS Smith' IsExtra=yes}}
	{Trigger={InOrder,Square,Circle,300} 		Scr=Trick_5_0_BS Params={Name='BS 5-0' IsExtra=yes}}

]


GrindRelease =
[
	//	{Trigger={AirTrickLogic,Up,R2,500}      	Scr=SkateInOrBail Params={fallingleft grindbail=Airborne moveright=-5 movey=5}}
	//	{Trigger={AirTrickLogic,Down,R2,500}      	Scr=SkateInOrBail Params={fallingright grindbail=Airborne moveright=-5 movey=5}}
	//	{Trigger={Press,L2,100} 	    Scr=SkateInOrBail Params={fallingleft grindbail=Airborne moveleft=5 movey=5}}
	{Trigger={Press,R2,100}      	Scr=SkateInOrBail Params={grindrelease grindbail=Airborne moveright=-5 movey=5} }
]

//NewLipTest = [{Trigger={InOrder,Triangle,Triangle,200}       Scr=NewLipHalt Params={Name='Blunt to Fakie' CopingHit=5 Score=500 InitAnim=BluntToFakie_init Anim=BluntToFakie_range OutAnim=BluntToFakie_out BoardRotate ExtraTricks=LipTrickExtras}}]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GRIND MACRO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GRINDTAP_TIME = 1000
GRINDTAP_SCORE = 400
GRINDTAP_TWEAK = 25
// xxx
GrindTaps_FS = [

	{Trigger={TripleInOrderSloppy,UpRight,b=Triangle,c=Triangle,GRINDTAP_TIME}      	Scr=Trick_CrailSlide_FS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,DownRight,b=Triangle,c=Triangle,GRINDTAP_TIME}      	Scr=Trick_Darkslide_FS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,DownLeft,b=Triangle,c=Triangle,GRINDTAP_TIME}   		Scr=Trick_DoubleBluntSlide2 Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,UpLeft,b=Triangle,c=Triangle,GRINDTAP_TIME}      		Scr=Trick_HangTenNoseGrind_FS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,Up,b=Triangle,c=Triangle,GRINDTAP_TIME}      			Scr=Trick_NosegrindPivot_FS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,Right,b=Triangle,c=Triangle,GRINDTAP_TIME}      		Scr=Trick_Salad_FS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,Left,b=Triangle,c=Triangle,GRINDTAP_TIME}      		Scr=Trick_Hurricane_FS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,Down,b=Triangle,c=Triangle,GRINDTAP_TIME}      		Scr=Trick_GrindOverturn_FS  Params={IsExtra=1}}
]

GrindTaps_BS = [

	{Trigger={TripleInOrderSloppy,UpRight,b=Triangle,c=Triangle,GRINDTAP_TIME}      	Scr=Trick_CrailSlide_BS Params={IsExtra=1} }
	{Trigger={TripleInOrderSloppy,DownRight,b=Triangle,c=Triangle,GRINDTAP_TIME}      	Scr=Trick_Darkslide_BS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,DownLeft,b=Triangle,c=Triangle,GRINDTAP_TIME}   		Scr=Trick_DoubleBluntSlide2 Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,UpLeft,b=Triangle,c=Triangle,GRINDTAP_TIME}      		Scr=Trick_HangTenNoseGrind_BS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,Up,b=Triangle,c=Triangle,GRINDTAP_TIME}      			Scr=Trick_NosegrindPivot_BS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,Right,b=Triangle,c=Triangle,GRINDTAP_TIME}      		Scr=Trick_Salad_BS Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,Down,b=Triangle,c=Triangle,GRINDTAP_TIME}      		Scr=Trick_GrindOverturn_BS  Params={IsExtra=1}}
	{Trigger={TripleInOrderSloppy,Left,b=Triangle,c=Triangle,GRINDTAP_TIME}      		Scr=Trick_Hurricane_BS Params={IsExtra=1}}
]


script Grind GrindTweak=7 boardscuff=0 InitSpeed = 1.0
	if not GetGlobalFlag Flag=DIFFICULTY_MODE_TOO_EASY
		if BailIsOn
			SetState	Air
			Goto DoingTrickBail
		endif
	endif
	// Duplicate it for Net games
	if InNetGame
		if BailIsOn
			SetState	Air
			Goto DoingTrickBail
		endif
	endif


	BailOff

	LaunchStateChangeEvent State=Skater_OnRail
	KillExtraTricks
	//	printstruct <...>
	//Use the extratricks parameter to determine whether we are FS or BS
	if ChecksumEquals a=<Extratricks> b=Extra_BS_Grinds
		//create_panel_message text="THIS IS BS"
		SetExtraTricks GrindTaps_BS
	else
		SetExtraTricks GrindTaps_FS
	endif
	SetTags Outanim=<OutAnim> InitAnim=<InitAnim> InitSpeed=<InitSpeed> Anim=<Anim>// needed by SkateInOrBail
	//Block spin from affecting any future tricks, if the player jumps out quickly
	SetTrickName ""
	SetTrickScore 0
	Display Blockspin

	Obj_ClearFlag FLAG_SKATER_MANUALCHEESE
	Obj_ClearFlag FLAG_SKATER_REVERTCHEESE
	if GotParam SpecialItem_details
		TurnOnSpecialItem SpecialItem_details=<SpecialItem_details>
	endif

	If GotParam SwitchBoardOff
		SwitchoffBoard
	endif
	// get rid of any special trick particles and always turn the board on
	OnExitRun Exit_Grind

	if GotParam SpecialSounds
		Obj_SpawnScript <SpecialSounds> //spawn a script to play special trick streams
	endif

	if GotParam Stream
		Obj_PlayStream <stream> //vol=250
	endif

	Vibrate Actuator=1 Percent=50 Duration=.25
	Vibrate Actuator=0 Percent=50
	ClearExceptions
	if GotParam Nollie
		SetException Ex=Ollied      Scr=NollieNoDisplay
		NollieOn					; need to set it on here because even if you fall off the rail, we want a Nollie Heelflip
	else
		If GotParam OutAnimOnOllie
			SetException Ex=Ollied      Scr=Ollie Params={<...>}
		else
			SetException Ex=Ollied      Scr=Ollie
		endif
		NollieOff
	endif
	PressureOff

	if IsGrind <Type>
		if GotParam FrontTruckSparks
			SetFrontTruckSparks
		else
			if GotParam RearTruckSparks
				SetRearTruckSparks
			else
				SetSparksTruckFromNollie
			endif
		endif
		SparksOn
	else
		// if this is a slide, we need to increment our boardscuffing tag parameter
		// and then call DoBoardScuff to see if we should swap in a new texture
		GetBoardScuff
		<boardscuff> = (<boardscuff> + 1)
		SetTags boardscuff=<boardscuff>
		DoBoardScuff boardscuff=<boardscuff>
		// printstruct <...>
		SparksOff
	endif

	SetException Ex=OffRail     	Scr=OffRail Params={KissedRail InitAnim=<InitAnim> InitSpeed=<InitSpeed> OutAnim=<OutAnim> BoardRotate=<BoardRotate> OutAnimBackwards=<OutAnimBackwards>}
	SetException Ex=Landed      	Scr=Land
	SetException Ex=OffMeterTop		Scr=SkateInOrBail Params={<...> FallingLeft}
	SetException Ex=OffMeterBottom	Scr=SkateInOrBail Params={<...> FallingRight}
	SetException Ex=SkaterCollideBail Scr=SkaterCollideBail
	SetEventHandler Ex=MadeOtherSkaterBail	Scr=MadeOtherSkaterBail_Called
	// If we're in the early part of a grind set up this little insignificant trick
	// we'll overwrite it later in the script with the real trick name, if the player
	// grinds that long
	OnExceptionRun					Grind_Kissed

	ClearTrickQueue
	ClearManualTrick   // else if you tap out a special manual before grinding, it'll go off if you fall of the rail
	ClearExtraGrindTrick
	SetQueueTricks	NoTricks
	SetManualTricks NoTricks
	SetRailSound	<Type>
	If GotParam IsSpecial
		SetGrindTweak	36
		//	printf "setting grindtweak to 36............."
	else
		If GotParam IsATap
			SetGrindTweak GRINDTAP_TWEAK
		else
			SetGrindTweak	<Grindtweak>
		endif
	endif
	If GotParam IsExtra
		LaunchExtraMessage
		//AdjustBalance SpeedMult = 1.25 //TimeAdd = 1.0
	endif
	If GotParam Profile  // for the ghetto blaster and other props
		If ProfileEquals is_named = <Profile>
			SwitchOnAtomic special_item
			SwitchOffAtomic	special_item_2
		endif
	endif

	if GotParam FullScreenEffect
		<FullScreenEffect>
		OnExitRun Exit_FullScreenEffect
	endif

	// Wait to play the init it we're coming from walking.  We'll basically add JumpAirTo5050 onto the front of the init
	If not AnimEquals JumpAirTo5050
		If GotParam NoBlend
			PlayAnim Anim=<InitAnim>  BlendPeriod=0.0 Speed=<InitSpeed>
			;	BlendPeriodOut 0
			;	printf "No blending xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
		else
			// printstruct <...>
			PlayAnim Anim=<InitAnim>  BlendPeriod=0.3 Speed=<InitSpeed>	    ;TEMP CHANGE
		Endif
	Endif

	; Ken: Added new parameter DoFlipCheck. This ensures that the skater's anim moves in the
	; correct direction when he is flipped. Needed here because the anims move sideways,
	; but not needed by manuals.

	// DoBalanceTrick assumes this is a "new" grind every time it is called.
	// So if this is an extra trick, DoBalance might have been just called, so make sure
	// to clear the cheese or else you will bail right away
	If GotParam IsATap
		//printf "IS EXTRA >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		DoBalanceTrick ButtonA=right ButtonB=left Type=<Type> DoFlipCheck ClearCheese
	else
		DoBalanceTrick ButtonA=right ButtonB=left Type=<Type> DoFlipCheck
	endif
	// The magic number. If the player jumps out before this number of frames
	// then they will get no trick (unless the skate off the rail, then they get kissed the rail
	// Basically, the minimum amount of time you must grind before we "count" that grind
	Wait 15 frames

	// don't set the Grindrelease feature too early in the grind script, or if you press and hold
	// R2 and triangle you will release and regrind the same rail, and then bail form the cheese
	If (control_scheme = 1)
		SetExtraTricks GrindRelease //PS2 scheme: R2 drops off the rail (GrindRelease)
	endif

	Wait 1 frame

	If GotParam IsSpecial
		LaunchSpecialMessage text="Special Grind"
	endif
	; this next part clears the kissed the rail
	; and also makes sure that when we finish a
	; grind we clear manual events so that we
	; don't queue them up by accident
	SetException Ex=OffRail     	Scr=OffRail Params={InitAnim=<InitAnim> InitSpeed=<InitSpeed> OutAnim=<OutAnim> BoardRotate=<BoardRotate> OutAnimBackwards=<OutAnimBackwards>}
	OnExceptionRun		Normal_Grind
	SetTrickName <Name>
	SetTrickScore <Score>
	Display BlockSpin
	//WaitAnim 30 percent
	//If GotParam OutAnimOnOllie
	//WaitAnim 30 percent
	// Any grind trick that needs to flip the skater or rotate the board needs to wait
	// ~30% of the way before passing these flags on to OffRail and Ollie
	//	SetException Ex=OffRail     	Scr=OffRail Params={<...>}
	//	SetException Ex=Ollied      Scr=Ollie Params={<...>}
	//endif

	// If we came from walking, play the grind's init anim now.
	If AnimEquals JumpAirTo5050
		WaitAnimFinished
		PlayAnim Anim=<InitAnim>  BlendPeriod=0.3 Speed=<InitSpeed>
	Endif
	WaitAnimFinished

	If GotParam FlipAfterInit
		Flip
		PlayBonkSound
		BoardRotate
		BlendperiodOut 0
	endif
	If GotParam Idle
		PlayAnim Anim=<Anim> Cycle NoRestart
	else
		if GotParam Anim3
			if GotParam Anim2
				PlayAnim Random(@Anim=<Anim> @Anim=<Anim2> @Anim=<Anim3>) wobble  wobbleparams=grindwobble_params
			else
				ScriptAssert "Script Assert: Added Anim3 to a grind without a valid anim2...check grindscripts.q Problem Anim = %a" a=<Anim>
			endif
		else
			If GotParam Anim2
				PlayAnim Random(@Anim=<Anim> @Anim=<Anim2>) wobble  wobbleparams=grindwobble_params
			else
				PlayAnim Anim=<Anim> Wobble wobbleparams=grindwobble_params
			endif
		endif
	endif

	If GotParam FlipBeforeOutAnim
		BlendPeriodOut 0.0
		FlipAfter
	endif

	// These grind _init anims are so short, that they will allow you to
	// do an extragrind too early in the grind, and that will apply cheese
	// and make you bail
	If AnimEquals [FiftyFifty_Range NoseGrind_Range TailGrind_Range]
		Wait .25 seconds
	endif

	If GotParam Extratricks
		if (control_scheme = 1)
			SetExtraTricks <Extratricks> ignore=<name> GrindRelease
		else
			SetExtraTricks <Extratricks> ignore=<name>
		endif
	else
		if (control_scheme = 1)
			SetExtraTricks GrindRelease
		endif
	endif

	If GotParam ScreenShake
		Grind_ScreenShake screenshake=<screenshake>
	endif

	If GotParam specialtrick_particles
		printf "Going to emit particles ........................."
		Emit_SpecialTrickParticles specialitem_particles=<specialitem_particles>
	endif
	WaitWhilstChecking_ForPressure <...>
endscript

// A General cleanup script for all Full screen effects triggered during special tricks
// currently this script will cleanup manuals and grinds properly
script Exit_FullScreenEffect
	//return level to normal
	<skaterlights_target> = (tod_skaterlights)
	//printstruct <...>
	set_level_lights <skaterlights_target>
	SetFogColor r=fog_red b=fog_blue g=fog_green a=fog_alpha
	SetFogDistance distance=fog_dist
	// when called during manuals
	KillManualVibration
	end_oldtime_effects
	// when called during grinds
	Exit_Grind
endscript

script Exit_Grind
	SwitchOnBoard
	CleanUp_SpecialTrickParticles
endscript

script CreatureScaryGrindEffect
	start_oldtime_effects
endscript

script JamieThomasEffect2
	printf "calling JT effect"
	set_level_lights {
		ambient_red      = 10
		ambient_green    = 10
		ambient_blue     = 10
		ambient_mod_factor = .3

		//SP: now using the values from levels.q
		heading_0	     = 60
		pitch_0          = 10
		red_0            = 10
		green_0          = 10
		blue_0           = 10
		mod_factor_0     = 10

		// now using the values from levels.q
		heading_1	     = 245
		pitch_1          = 330
		red_1            = 10
		green_1          = 10
		blue_1           = 10
		mod_factor_1     = .75 }
	Obj_UpdateBrightness
endscript

script IronManEffect
	EnableFog
	SetFogColor r=200 b=0 g=0 a=100
	SetFogDistance distance=400
	set_level_lights tod_skaterlights_nightvision
endscript

script GetBoardScuff ManualName='none'
	GetTags
	return boardscuff=<boardscuff>
endscript

script Grind_ScreenShake screenshake=60
	If AnimEquals [ElbowSmash_Idle FlipKickDad]
		begin
			wait 1 frame

			If FrameIs <screenshake>
				printf " THIS IS THE RIGHT SPOT"
				BloodSplat
				PlaySound BailSlap03
				ShakeCamera {
					duration = 0.5
					vert_amp = 9.0
					horiz_amp = 3.0
					vert_vel = 10.27
					horiz_vel = 5.92
				}
			endif
		repeat
	endif
endscript

grindwobble_params = {

	WobbleAmpA  = { (0.1,0.1) STATS_RAILBALANCE } ; was .04 amplitudes get added together to make the range
	WobbleAmpB  = { (0.04,0.04) STATS_RAILBALANCE } ; was .03
	WobbleK1    = { (0.0022,0.0022) STATS_RAILBALANCE }  ; frequency 1
	WobbleK2    = { (0.0017,0.0017) STATS_RAILBALANCE }	 ; frequency 2 - the more different from K1, the more randomness
	SpazFactor  = { (1.5,1.5) STATS_RAILBALANCE }	 ; amount the Amps are multiplied by at the ends of the meter

}

Script Grind_Kissed
	If GotParam MadeOtherSkaterBail // This is exception is Called, so don't kill the tricks as we
	else
		KillExtraTricks
	endif
	Obj_KillSpawnedScript name=CheckForShuffle
	Obj_Spawnscript CheckForShuffle
	; Mick:  ExceptionTriggered no longer works with the new exception system
	; as exceptions are executed immediately, and there is no "triggered" flag
	;if ExceptionTriggered OffRail
	;	Display BlockSpin
	;endif
Endscript

script CheckForShuffle
	SetException Ex=SkaterEnterRail Scr=Awardshuffle
	wait 15 frames
endscript

script Awardshuffle
	SetTrickName ''
	SetTrickScore 100
	Display Blockspin NoDegrade
	if Not InSplitscreenGame
		Create_Panel_Message text="Shuffle Bonus" id=perfect rgba=[50 120 200 128] pos=(110,340) style=perfect_style
		Create_Panel_Message text="+100 Points" id=perfect2 rgba=[50 120 200 100] pos=(110,360) style=perfect_style
	else
		PerfectSloppy_2p text="Shuffle!" rgb=[50 120 50 128]
	endif
endscript

script AwardBonk
	SetTrickName ''
	SetTrickScore 100
	Display Blockspin NoDegrade
	if Not InSplitscreenGame
		Create_Panel_Message text="BONK!" id=perfect rgba=[50 120 200 128] pos=(110,340) style=perfect_style
		Create_Panel_Message text="+100 Points" id=perfect2 rgba=[50 120 200 100] pos=(110,360) style=perfect_style
	else
		PerfectSloppy_2p text="BONK!" rgb=[50 120 50 128]
	endif
endscript

script AwardButtslap
	SetTrickName ''
	SetTrickScore 100
	Display Blockspin NoDegrade
	FormatText TextName=buttslap_text "%ix BUTTSLAP" i=<Multiplier>
	if Not InSplitscreenGame
		Create_Panel_Message text=<buttslap_text> id=perfect rgba=[50 120 200 128] pos=(110,340) style=perfect_style
		Create_Panel_Message text="+100 Points" id=perfect2 rgba=[50 120 200 100] pos=(110,360) style=perfect_style
	else
		PerfectSloppy_2p text=<buttslap_text> rgb=[50 120 50 128]
	endif
endscript

Script Normal_Grind
	If GotParam MadeOtherSkaterBail // This is exception is Called, so don't kill the tricks as we
	else
		KillExtraTricks
	endif
	SwitchOffAtomic special_item
	SwitchOnAtomic special_item_2
	//ClearTrickQueues
	//ClearEventBuffer // ensures that balance taps get killed out of the buffer and don't cause special tricks
Endscript


Script OffRail InitSpeed = 1.0

	if GotParam KissedRail
		SetTrickScore					50
		SetTrickName					"Kissed the Rail"
		Display BlockSpin
	endif

	StopBalanceTrick     // Added this as exceptions don't do it
	KillExtraTricks
	Vibrate Actuator=0 Percent=0
	SetState Air
	SetException Ex=Landed      		Scr=Land
	SetException Ex=WallRideLeft     	Scr=WallRide Params={Left}
	SetException Ex=WallRideRight    	Scr=WallRide Params={Right}
	DoNextTrick
	If GotParam EarlyOut
		PlayAnim Anim=<EarlyOut> BlendPeriod=0.1 Backwards
	else
		If GotParam OutAnim
			If GotParam OutAnimBackwards
				printf "Playing OutAnim Backwards"
				PlayAnim Anim=<OutAnim> Backwards BlendPeriod=0.1 Speed=<InitSpeed>
			else
				PlayAnim Anim=<OutAnim> BlendPeriod=0.1 Speed=<InitSpeed>
			endif
		else
			PlayAnim Anim=<InitAnim> BlendPeriod=0.1 Backwards Speed=<InitSpeed>
		endif
	endif
	If GotParam BoardRotate
		printf "Setting blendperiod out.................."

		BlendPeriodOut 0
		BoardRotateAfter
	endif
	If GotParam FlipAfter
		printf "flipping.................."
		FlipAfter
	endif
	WaitAnimFinished
	goto Airborne
endscript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SPECIAL GRIND DEFINITIONS --- Those not covered by grindtable.q
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;START GRIND DEFINITIONS --- START GRIND DEFINITIONS ---  START GRIND DEFINITIONS ---
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

script Trick_5050_BS Name='BS 50-50'
	Grind 	{Name=<Name> Score=100 InitAnim=Init_FiftyFifty Anim=FiftyFifty2_range Anim2=FiftyFifty_range Anim3=FiftyFifty3_range Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_5050_FS Name='FS 50-50'
	Grind 	{Name=<Name> Score=100 InitAnim=Init_FiftyFifty Anim=FiftyFifty2_range Anim2=FiftyFifty_range Anim3=FiftyFifty3_range Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_5050_BS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_5050_BS Params={NoBlend=yes}
endscript

script Trick_5050_FS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_5050_FS Params={NoBlend=yes}
endscript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
script Trick_Boardslide_FS Name='FS Boardslide'
	Rotate
	Grind 	{Name=<Name> Score=200 GrindTweak=14 InitAnim=Init_FSBoardslide Anim=FSBoardslide_range OutAnim=FSBoardslide_Out Type=Slide NoBlend=yes
		GrindBail=Nutter ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Boardslide_BS Name='BS Boardslide'
	Grind 	{Name=<Name> Score=200 GrindTweak=14 InitAnim=Init_BSBoardslide Anim=BSBoardslide_range OutAnim=BSBoardslide_Out Type=Slide NoBlend=yes
		GrindBail=Nutter ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Lipslide_FS Name='FS Lipslide'
	Grind 	{Name=<Name> Score=200 GrindTweak=14 InitAnim=Init_FSLipslide Anim=BSBoardslide_range OutAnim=BSBoardslide_Out Type=Slide NoBlend=yes
		GrindBail=Nutter ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Lipslide_BS Name='BS Lipslide'
	Rotate
	Grind 	{Name=<Name> Score=200 GrindTweak=14 InitAnim=Init_BSLipslide Anim=FSBoardslide_range OutAnim=FSBoardslide_Out Type=Slide NoBlend=yes
		GrindBail=Nutter ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
script Trick_Tailslide_FS
	If BadLedge
		Goto Trick_NoseSlide_BS_ok Params={IsExtra=<IsExtra> NoBlend=<NoBlend>}
	else
		Goto Trick_Tailslide_FS_ok Params={IsExtra=<IsExtra> NoBlend=<NoBlend>}
	endif
endscript

script Trick_Tailslide_FS_ok Name='FS Tailslide'
	Grind 	{Name=<Name>  Score=150 GrindTweak=11 InitAnim=Init_FSTailslide InitSpeed = 1.5 Anim=FSTailslide_range OutAnim=FSTailslide_Out Type=Slide NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Tailslide_BS
	If BadLedge
		Goto Trick_NoseSlide_FS_ok Params={IsExtra=<IsExtra> NoBlend=<NoBlend>}
	else
		Goto Trick_Tailslide_BS_ok Params={IsExtra=<IsExtra> NoBlend=<NoBlend>}
	endif
endscript

Script Trick_Tailslide_BS_ok Name='BS Tailslide'
	Grind 	{Name=<Name>  Score=150 GrindTweak=11 InitAnim=Init_Tailslide InitSpeed = 1.5 Anim=Tailslide_range OutAnim=BSTailslide_Out Type=Slide NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Tailslide_FS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_Tailslide_BS Params={NoBlend=yes}    ;but call it a Noseslide eventually...
endscript

script Trick_Tailslide_BS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_Tailslide_FS Params={NoBlend=yes}     ;but call it a Noseslide eventually...						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Noseslide_FS
	If BadLedge
		Goto Trick_TailSlide_BS_ok Params={IsExtra=<IsExtra> NoBlend=<NoBlend>}
	else
		Goto Trick_Noseslide_FS_ok Params={IsExtra=<IsExtra> NoBlend=<NoBlend>}
	endif
endscript

script Trick_Noseslide_FS_ok Name='FS Noseslide'
	Grind 	{Name=<Name> Score=150 GrindTweak=11 InitAnim=Init_FSNoseslide InitSpeed = 1.5 Anim=FSNoseslide_range Type=Slide Nollie=yes OutAnim=FSNoseSlide_Out NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Noseslide_BS
	If BadLedge
		Goto Trick_TailSlide_FS_ok Params={IsExtra=<IsExtra> NoBlend=<NoBlend>}
	else
		Goto Trick_Noseslide_BS_ok Params={IsExtra=<IsExtra> NoBlend=<NoBlend>}
	endif
endscript

script Trick_Noseslide_BS_ok Name='BS Noseslide'
	Grind 	{Name=<Name>  Score=150 GrindTweak=11 InitAnim=Init_Noseslide InitSpeed = 1.5 Anim=Noseslide_range OutAnim=BSNoseslide_Out Type=Slide Nollie=yes NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Noseslide_FS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_Noseslide_BS Params={NoBlend=yes}			;;;;;;;;;; Call it a Tailslide eventually
endscript

script Trick_Noseslide_BS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_NoseSlide_FS Params={NoBlend=yes}			 ;;;;;;;;;; Call it a Tailslide eventually
endscript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
script Trick_NoseGrind_FS Name='FS Nosegrind'
	Grind 	{Name=<Name>  Score=100 InitAnim=Init_Nosegrind InitSpeed = 1.5 Anim=Nosegrind_range Type=Grind Nollie=yes NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_NoseGrind_BS Name='BS Nosegrind'
	Grind 	{Name=<Name>  Score=100 InitAnim=Init_Nosegrind InitSpeed = 1.5 Anim=Nosegrind_range Type=Grind Nollie=yes NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_NoseGrind_BS_180
	;LaunchConsoleMessage "Nosegrind Fakie"
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_5_0_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NAME IS WRONG
endscript

script Trick_NoseGrind_FS_180
	;LaunchConsoleMessage "Nosegrind Fakie"
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_5_0_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NAME IS WRONG
endscript


script Trick_5_0_FS	Name='FS 5-0'
	Grind 	{Name=<Name>  Score=100 InitAnim=Init_Tailgrind InitSpeed = 1.5 Anim=Tailgrind_range Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_5_0_BS	Name='BS 5-0'
	Grind 	{Name=<Name>  Score=100 InitAnim=Init_Tailgrind InitSpeed = 1.5 Anim=Tailgrind_range Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_5_0_FS_180
	;LaunchConsoleMessage "5 0 Fakie"
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_Nosegrind_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT NAMED CORRECTLY
endscript

script Trick_5_0_BS_180
	;LaunchConsoleMessage "5 0 Fakie"
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_Nosegrind_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT NAMED CORRECTLY
endscript


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
script Trick_Crooked_FS	Name='FS Crooked'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=Init_FSCrooked InitSpeed = 1.5 Anim=FSCrooked_range Type=Grind Nollie=yes NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Crooked_FS_rot
	rotate
	Goto Trick_Crooked_FS
endscript

script Trick_Crooked_BS	Name='BS Crooked'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=Init_BSCrooked InitSpeed = 1.5 Anim=BSCrooked_range Type=Grind Nollie=yes NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Crooked_FS_180
	if backwards
		printf "I'm backwards............"
	endif

	FlipandRotate
	BoardRotateAfter
	;LaunchConsoleMessage "Crooked FS 180"
	Goto Trick_Crooked_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Crooked_BS_180
	FlipandRotate
	BoardRotateAfter
	;LaunchConsoleMessage "Crooked BS 180"
	Goto Trick_Crooked_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_NGCRook_FS_rot
	rotate
	printf "fixed it bitches................................"
	goto Trick_NGCRook_FS
endscript

script Trick_NGCRook_FS	Name='FS Overcrook'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=Init_FSOvercrook InitSpeed = 1.5 Anim=FSOvercrook_range Type=Grind Nollie=yes NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_NGCrook_BS Name='BS Overcrook'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=Init_BSOvercrook InitSpeed = 1.5 Anim=BSOvercrook_range Type=Grind Nollie=yes NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_NGCRook_FS_180
	;LaunchConsoleMessage "NGCrook FS 180"
	FlipandRotate
	Goto Trick_NGCrook_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_NGCrook_BS_180
	;LaunchConsoleMessage "NGCrook BS 180"
	FlipandRotate
	Goto Trick_NGCrook_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
script Trick_Smith_FS Name='FS Smith'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=Init_FSSmith InitSpeed = 1.5 Anim=FSSmith_range Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Smith_FS_rot
	rotate
	Goto Trick_Smith_FS
endscript

script Trick_Smith_BS Name='BS Smith'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=Init_BSSmith InitSpeed = 1.5 Anim=BSSmith_range Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Smith_FS_180
	;LaunchConsoleMessage "Smith FS 180"
	FlipAndRotate
	Goto Trick_Smith_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Smith_BS_180
	;LaunchConsoleMessage "Smith BS 180"
	FlipAndRotate
	Goto Trick_Smith_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Feeble_FS Name='FS Feeble'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=Init_FSFeeble InitSpeed = 1.5 Anim=FSFeeble_range Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Feeble_FS_rot
	rotate
	Goto Trick_Feeble_FS
Endscript

script Trick_Feeble_BS Name='BS Feeble'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=Init_BSFeeble InitSpeed = 1.5 Anim=BSFeeble_range Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Feeble_FS_180
	;LaunchConsoleMessage "Feeble FS 180"
	FlipAndRotate
	Goto Trick_Feeble_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Feeble_BS_180
	;LaunchConsoleMessage "Feeble BS 180"
	FlipAndRotate
	Goto Trick_Feeble_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript


script Trick_Bluntslide_BS Name='BS Bluntslide'
	Grind 	{Name=<Name> Score=250 GrindTweak=18 InitAnim=Init_BSBluntSlide InitSpeed = 1.5 Anim=BSBluntSlide_range Type=Slide NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Bluntslide_FS Name='FS Bluntslide'
	Grind 	{Name=<Name>  Score=250 GrindTweak=18 InitAnim=Init_FSBluntSlide InitSpeed = 1.5 Anim=FSBluntSlide_range Type=Slide NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Nosebluntslide_BS Name='BS Nosebluntslide'
	Grind 	{Name=<Name>  Score=250 GrindTweak=18 InitAnim=Init_BSNoseblunt InitSpeed = 1.5 Anim=BSNoseblunt_range Type=Slide NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra> Nollie=yes }
endscript

script Trick_Nosebluntslide_FS Name='FS Nosebluntslide'
	Grind 	{Name=<Name> Score=250 GrindTweak=18 InitAnim=Init_FSNoseblunt InitSpeed = 1.5 Anim=FSNoseblunt_range Type=Slide NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall Nollie=yes IsExtra=<IsExtra> ExtraTricks=Extra_FS_Grinds}
endscript


script Trick_Bluntslide_BS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_Bluntslide_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Bluntslide_FS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Bluntslide_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Nosebluntslide_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Nosebluntslide_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Nosebluntslide_FS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Nosebluntslide_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SPECIAL GRIND TRICKS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




/////////////////////////////////////////////////////////////////////////////////
//
// THUG SPECIAL GRINDS
//
/////////////////////////////////////////////////////////////////////////////////

script Trick_Shortbus2
	Grind 	{Name='Stupid Grind' Score=400 InitAnim=Shortbus_Init Anim=Shortbus_idle Idle OutAnim=Shortbus_Out Type=Grind NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails Nollie=yes IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Shortbus2_180
	Rotate
	BoardRotateAfter
	Goto Trick_Shortbus2 Params={NoBlend=yes}
endscript

script Trick_RodneyGrind2
	Grind 	{Name='Rodney Primo' Score=400 InitAnim=RodneyGrind_Init Anim=RodneyGrind_range OutAnim=RodneyGrind_Out Type=Grind BoardRotate=yes
		GrindBail=BackwardsGrindBails Nollie=yes IsSpecial InitSpeed= .7 OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_GrindNBarf2
	Grind 	{Name='Grind N Barf' InitSpeed=1.5 Score=400 InitAnim=GrindNBarf_Init Anim=GrindNBarf_range OutAnim=GrindNBarf_Out Type=Grind BoardRotate=yes
		GrindBail=BackwardsGrindBails Nollie=yes IsSpecial OutAnimOnOllie stream=DryHeaveSpecial ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>} //specialtrick_particles=barf_particles
endscript

script Trick_RowleyDarkSlideHandStand2
	Grind {Name='Darkslide Handstand' Score=800 InitAnim=RowleyDarkSlideHandStand_Init Anim=RowleyDarkSlideHandStand_range OutAnim=RowleyDarkSlideHandStand_Out Type=Slide NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_RowleyDarkSlideHandStand2_180
	Rotate
	BoardRotateAfter
	Goto Trick_RowleyDarkSlideHandStand2 Params={NoBlend=yes}
endscript

Script Trick_PrimoHandStand2
	Grind {Name='Primo Handstand' Score=800 InitAnim=PrimoHandStand_Init Anim=PrimoHandStand_range OutAnim=PrimoHandStand_Out Type=Slide NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie stream=nj_pipeignite ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>} //FullScreenEffect=JamieThomasEffect2
endscript

script Trick_PrimoHandStand2_180
	Rotate
	BoardRotateAfter
	Goto Trick_PrimoHandStand2 Params={NoBlend=yes}
endscript

Script Trick_OneFootDarkSlide2
	Grind {Name='One Foot Darkslide' Score=800 InitAnim=OneFootDarkSlide_Init Anim=OneFootDarkSlide_range OutAnim=OneFootDarkSlide_Out Type=Slide NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_OneFootDarkslide2_180
	Rotate
	BoardRotateAfter
	Goto Trick_OneFootDarkSlide2 Params={NoBlend=yes}
endscript


script Trick_FiftyFiftySwitcheroo2
	Grind 	{Name='5050 Switcheroo' Score=400 InitAnim=FiftyFiftySwitcheroo_Init Anim=FiftyFiftySwitcheroo_Idle Idle Type=Grind
		GrindBail=BackwardsGrindBails IsSpecial speed=3 ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_YeaRightSlide2
	Grind 	{Name='Yeah Right Slide' Score=400 InitAnim=YeaRightSlide_Init Anim=YeaRightSlide_range OutAnim=YeaRightSlide_Out Type=Slide
		GrindBail=BackwardsGrindBails IsSpecial ExtraTricks=Extra_BS_Grinds OutAnimOnOllie SwitchBoardOff IsExtra=<IsExtra>}
	spawnscript offboard
endscript

script OffBoard BoardOffFrame=5
	Wait <BoardOffFrame> frames
	SwitchOffBoard
endscript

script Trick_YeaRightSlide2_180
	Rotate
	BoardRotateAfter
	Goto Trick_YeaRightSlide2 Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

Script Trick_HCNHDF2
	Grind {Name='Crooks DarkSlide' Score=800 InitAnim=HCNHDF_Init Anim=HCNHDF_range OutAnim=HCNHDF_Out  initspeed= 1.5 Type=Slide NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_HCNHDF2_180
	Rotate
	BoardRotateAfter
	Goto Trick_HCNHDF2 Params={NoBlend=yes}
endscript

Script Trick_FSNollie360FlipCrook2
	Grind {Name='Nollie 360flip Crook' Score=800 InitAnim=FSNollie360FlipCrook_Init Anim=FSNollie360FlipCrook_range OutAnim=FSNollie360FlipCrook_Out Type=Grind NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_FSNollie360FlipCrook2_180
	Rotate
	BoardRotateAfter
	Goto Trick_FSNollie360FlipCrook2 Params={NoBlend=yes}
endscript

Script Trick_MoonwalkGrind2
	Grind {Name='Moonwalk Five-O' Score=800 InitAnim=Moonwalkgrind_Init Anim=Moonwalkgrind_idle Idle OutAnim=Moonwalkgrind_Out Type=Grind NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_MoonwalkGrind2_180
	Rotate
	BoardRotateAfter
	Goto Trick_MoonwalkGrind2 Params={NoBlend=yes}
endscript

Script Trick_Thinkaboutitgrind2
	Grind {Name='Levitate Grind' Score=800 InitAnim=Thinkaboutitgrind_Init Anim=Thinkaboutitgrind_idle Idle OutAnim=Thinkaboutitgrind_Out Type=Grind NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Thinkaboutitgrind2_180
	Rotate
	BoardRotateAfter
	Goto Trick_ThinkAboutItgrind2 Params={NoBlend=yes}
endscript

Script Trick_360ShovitNoseGrind2
	Grind {Name='360 Shovit NoseGrind' Score=800 InitAnim=_360ShovitNoseGrind_Init Anim=_360ShovitNoseGrind_range InitSpeed= 2.0 OutAnim=_360ShovitNoseGrind_Out Type=Grind NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_360ShovitNoseGrind2_180
	Rotate
	BoardRotateAfter
	Goto Trick_360ShovitNoseGrind2 Params={NoBlend=yes}
endscript

Script Trick_Flames2
	Grind {Name='Fire Fire Fire' Score=800 InitAnim=Flames_Init Anim=Flames_Idle Idle OutAnim=Flames_Out Type=Slide NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Flames2_180
	Rotate
	BoardRotateAfter
	Goto Trick_Flames2 Params={NoBlend=yes}
endscript


Script Trick_BlastGrind2
	Grind {Name='Fire Blaster' Score=800 InitSpeed = 1.5 InitAnim=BlastGrind_Init Anim=BlastGrind_Idle Idle OutAnim=BlastGrind_Out Type=Grind NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_BlastGrind2_180
	Rotate
	BoardRotateAfter
	Goto Trick_BlastGrind2 Params={NoBlend=yes}
endscript

Script Trick_3DScaryGrind2
	Grind {Name='Scary Grind' Score=800 InitAnim=_3DScaryGrind_Init Anim=_3DScaryGrind_Range OutAnim=_3DScaryGrind_Out Stream=ClassicMonster01 Type=Grind NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie FullscreenEffect=CreatureScaryGrindEffect ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_3DScaryGrind2_180
	Rotate
	BoardRotateAfter
	Goto Trick_3DScaryGrind2 Params={NoBlend=yes}
endscript

Script Trick_CrookedSkull2
	Grind {Name='Skull Grind' Score=800 InitAnim=CrookedSkull_Init Anim=CrookedSkull_Idle Idle OutAnim=CrokkedSkull_Out Type=Grind NoBlend=Yes
		GrindBail=BackwardsGrindBails IsSpecial OutAnimOnOllie Nollie=yes ExtraTricks=Extra_BS_Grinds SpecialItem_details=skull_details IsExtra=<IsExtra>}
endscript

script Trick_CrookedSkull2_180
	Rotate
	BoardRotateAfter
	Goto Trick_CrookedSkull2 Params={NoBlend=yes}
endscript




/// DOUBLE TAP GRINDS /////////////////////////////////////////////////


script Trick_Hurricane_BS
	Grind 	{Name='BS Hurricane' Score=GRINDTAP_SCORE InitAnim=BSHurricaneGrind_Init InitSpeed = 1.5 Anim=BSHurricaneGrind_Range OutAnim=Init_Tailgrind OutAnimBackwards=1 Type=Grind RearTruckSparks NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails Nollie=yes FlipBeforeOutAnim OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_Hurricane_FS
	Grind 	{Name='FS Hurricane' Score=GRINDTAP_SCORE InitAnim=FSHurricaneGrind_Init InitSpeed = 1.5 Anim=FSHurricaneGrind_Range OutAnim=Nollie Type=Grind NoBlend=Noblend
		GrindBail=FiftyFiftyFall FlipBeforeOutAnim OutAnimOnOllie  ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}	  //OutAnim=FSHurricaneGrind_Out
endscript

script Trick_Hurricane_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Hurricane_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Hurricane_FS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Hurricane_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript


script Trick_Darkslide_BS
	Grind 	{Name='BS Darkslide' Score=GRINDTAP_SCORE InitAnim=Darkslide_Init InitSpeed = 1.5 Anim=Darkslide_Range OutAnim=Darkslide_Out Type=Slide NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails OutAnimOnOllie BoardRotate=yes ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_Darkslide_FS
	Grind 	{Name='FS Darkslide' Score=GRINDTAP_SCORE InitAnim=FSDarkSlide_Init InitSpeed = 1.5 Anim=FSDarkSlide_Range OutAnim=FSDarkSlide_Out Type=Slide NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall OutAnimOnOllie BoardRotate=yes ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_Darkslide_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Darkslide_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Darkslide_FS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Darkslide_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Coffin_BS
	Grind 	{Name='BS Coffin' Score=500 InitAnim=CoffinGrind_Init Anim=CoffinGrind_Range OutAnim=CoffinGrind_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Coffin_FS
	Grind 	{Name='FS Coffin' Score=500 InitAnim=CoffinGrind_Init Anim=CoffinGrind_Range OutAnim=CoffinGrind_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra> }
endscript

script Trick_Coffin_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Coffin_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Coffin_FS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Coffin_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_fandangle_BS
	Grind 	{Name='BS Fandangle' Score=500 InitAnim=fandangle_Init Anim=fandangle_Range OutAnim=Fandangle_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial ExtraTricks=Extra_BS_Grinds OutAnimOnOllie BoardRotate=yes ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_fandangle_FS
	Grind 	{Name='FS Fandangle' Score=500 InitAnim=fandangle_Init Anim=fandangle_Range OutAnim=fandangle_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial ExtraTricks=Extra_FS_Grinds OutAnimOnOllie BoardRotate=yes ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_fandangle_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_fandangle_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_fandangle_FS_180
	Rotate
	BoardRotateAfter
	Goto Trick_fandangle_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_CrailSlide_BS
	Grind 	{Name='BS Crail Slide' Score=GRINDTAP_SCORE InitAnim=CrailSlide_Init Anim=CrailSlide_Range OutAnim=CrailSlide_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_CrailSlide_FS
	Grind 	{Name='FS Crail Slide' Score=GRINDTAP_SCORE InitAnim=CrailSlide_Init Anim=CrailSlide_Range OutAnim=CrailSlide_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_FS_Grinds OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_CrailSlide_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_CrailSlide_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_CrailSlide_FS_180
	Rotate
	BoardRotateAfter
	Goto Trick_CrailSlide_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_GrindOverturn_BS
	Grind 	{Name='BS 5-0 Overturn' Score=GRINDTAP_SCORE InitAnim=GrindOverturn_Init Anim=GrindOverturn_Range OutAnim=Init_Nosegrind OutAnimBackwards=1 Type=Grind RearTruckSparks NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall FlipBeforeOutAnim ExtraTricks=Extra_BS_Grinds Nollie=1 ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_GrindOverturn_FS
	Grind 	{Name='FS 5-0 Overturn' Score=GRINDTAP_SCORE InitAnim=GrindOverturn_Init Anim=GrindOverturn_Range OutAnim=Init_Nosegrind OutAnimBackwards=1 Type=Grind RearTruckSparks NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall FlipBeforeOutAnim ExtraTricks=Extra_FS_Grinds Nollie=1 ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_GrindOverturn_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_GrindOverturn_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_GrindOverturn_FS_180
	Rotate
	BoardRotateAfter
	Goto Trick_GrindOverturn_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript


script Trick_HangTenNoseGrind_BS
	Grind 	{Name='Hang Ten Nosegrind' Score=GRINDTAP_SCORE InitAnim=HangTenNoseGrind_Init InitSpeed = 1.5 Anim=HangTenNoseGrind_Range OutAnim=HangTenNoseGrind_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds Nollie ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_HangTenNoseGrind_FS
	Grind 	{Name='Hang Ten Nosegrind' Score=GRINDTAP_SCORE InitAnim=HangTenNoseGrind_Init InitSpeed = 1.5 Anim=HangTenNoseGrind_Range OutAnim=HangTenNoseGrind_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_FS_Grinds Nollie ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_HangTenNoseGrind_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_HangTenNoseGrind_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_HangTenNoseGrind_FS_180
	Rotate
	BoardRotateAfter
	Goto Trick_HangTenNoseGrind_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript


script Trick_RowleyDarkSlide_BS
	Grind 	{Name='Rowley Darkslide' Score=500 InitAnim=RowleyDarkSlide_Init Anim=RowleyDarkSlide_Range OutAnim=RowleyDarkSlide_out Type=Slide NoBlend=<Noblend>
		GrindBail=Nutter IsSpecial OutAnimOnOllie BoardRotate=yes ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_RowleyDarkSlide_FS
	Goto Trick_RowleyDarkSlide_BS
endscript

script Trick_RowleyDarkSlide_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_RowleyDarkSlide_BS Params={NoBlend=yes}
endscript

script Trick_RowleyDarkSlide_FS_180
	Goto Trick_RowleyDarkSlide_BS_180
endscript

script Trick_BigHitter_BS ExtraTricks=Extra_BS_Grinds
	Grind 	{Name='Big Hitter II' Score=500 InitAnim=BigHitter_Init Anim=BigHitter_Range OutAnim=BigHitter_out Type=Slide NoBlend=<Noblend>
		GrindBail=Nutter IsSpecial ExtraTricks=<Extratricks> OutAnimOnOllie}
endscript

script Trick_BigHitter_FS
	Goto Trick_BigHitter_BS Params={ExtraTricks=Extra_FS_Grinds}
endscript

script Trick_BigHitter_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_BigHitter_BS Params={NoBlend=yes}
endscript

script Trick_BigHitter_FS_180
	Goto Trick_BigHitter_BS_180
endscript

script Trick_NosegrindPivot_BS
	Grind 	{Name='Nosegrind to Pivot' Score=GRINDTAP_SCORE InitAnim=NosegrindPivot_Init InitSpeed = 1.75 Anim=NosegrindPivot_Range OutAnim=Init_TailGrind OutAnimBackwards=1 Type=Grind FrontTruckSparks NoBlend=Noblend
		GrindBail=FiftyFiftyFall BoardRotate=yes FlipBeforeOutAnim EarlyOut=Init_Tailgrind ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_NosegrindPivot_FS
	Goto Trick_NosegrindPivot_BS Params={IsExtra=IsExtra}
endscript

script Trick_NosegrindPivot_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_NosegrindPivot_BS Params={NoBlend=yes}
endscript

script Trick_NosegrindPivot_FS_180
	Goto Trick_NosegrindPivot_BS_180
endscript

/*

script Trick_Handstand5050_BS
Grind 	{Name='Handstand 50-50' Score=500 InitAnim=Handstand5050Grind_Init Anim=Handstand5050Grind_Range OutAnim=Handstand5050Grind_out Type=Grind NoBlend=<Noblend>
		GrindBail=NoseManualBail2 IsSpecial OutAnimOnOllie ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Handstand5050_FS
	Goto Trick_Handstand5050_BS
endscript

script Trick_Handstand5050_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Handstand5050_BS Params={NoBlend=yes}
endscript

script Trick_Handstand5050_FS_180
	Goto Trick_Handstand5050_BS_180
endscript


script Trick_LaidBack_BS
Grind 	{Name='Layback BS Smith' Score=500 InitAnim=FSFeebleLayback_Init Anim=FSFeebleLayback_Range OutAnim=FSFeebleLayback_Out Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter IsSpecial ExtraTricks=<Extratricks> OutAnimOnOllie Profile=Thomas ExtraTricks=Extra_BS_Grinds}
endscript

script Trick_LaidBack_FS
Grind 	{Name='Layback FS Feeble' Score=500 InitAnim=FSFeebleLayback_Init Anim=FSFeebleLayback_Range OutAnim=FSFeebleLayback_Out Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter IsSpecial ExtraTricks=<Extratricks> OutAnimOnOllie Profile=Thomas ExtraTricks=Extra_FS_Grinds}
endscript

script Trick_LaidBack_BS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_LaidBack_FS Params={NoBlend=yes}
endscript

script Trick_LaidBack_FS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_LaidBack_BS Params={NoBlend=yes}
endscript

script Trick_HumanDart_BS
Grind 	{Name='The Human Dart' Score=500 InitAnim=HumanDart_Init Anim=HumanDart_Range OutAnim=HumanDart_Out Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter IsSpecial OutAnimOnOllie ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_HumanDart_FS ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>
	Goto Trick_HumanDart_BS
endscript

script Trick_HumanDart_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_HumanDart_BS Params={NoBlend=yes}
endscript

script Trick_HumanDart_FS_180
	Goto Trick_HumanDart_BS_180
endscript

*/

script Trick_TailblockSlide_BS
	Grind 	{Name='Tailblock Slide' Score=500 InitAnim=TailblockSlide_Init Anim=TailblockSlide_Range OutAnim=TailblockSlide_Init Type=Slide NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=<Extratricks> IsSpecial ExtraTricks=Extra_BS_Grinds}
endscript

script Trick_TailblockSlide_FS
	Goto Trick_TailblockSlide_BS Params={ExtraTricks=Extra_FS_Grinds}
endscript

script Trick_TailblockSlide_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_TailblockSlide_BS Params={NoBlend=yes}
endscript

script Trick_TailblockSlide_FS_180
	Goto Trick_TailblockSlide_BS_180
endscript

script Trick_DrunkGrind_BS
	Grind 	{Name='S.U.I Grind' Score=500 InitAnim=DrunkGrind_Init Anim=DrunkGrind_Idle Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter IsSpecial OutAnimOnOllie ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_Salad_FS Name='FS Salad'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=FSSaladGrind_Init InitSpeed = 1.5 Anim=FSSaladGrind_range Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_FS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_Salad_BS Name='BS Salad'
	Grind 	{Name=<Name>  Score=125 GrindTweak=9 InitAnim=BSSaladGrind_Init InitSpeed = 1.5 Anim=BSSaladGrind_range Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_BS_Grinds IsATap IsExtra=<IsExtra>}
endscript

script Trick_Salad_FS_180
	;LaunchConsoleMessage "Salad FS 180"
	FlipAndRotate
	Goto Trick_Salad_BS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_Salad_BS_180
	;LaunchConsoleMessage "Salad BS 180"
	FlipAndRotate
	Goto Trick_Salad_FS Params={NoBlend=yes}						;;;;;;;;;; TRICK NOT DONE YET
endscript

script Trick_NoseSlideLipSlide_FS
	If BadLedge
		Goto Trick_NoseSlideLipSlide_BS_ok
	else
		Goto Trick_NoseSlideLipSlide_FS_ok
	endif
endscript

script Trick_NoseSlideLipSlide_FS_ok Name='FS Noseslide LipSlide'
	Grind 	{Name=<Name> Score=GRINDTAP_SCORE InitAnim=FSNoseSlideLipSlide Anim=BSBoardslide_range Type=Slide Nollie=yes NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_FS_Grinds IsSpecial IsExtra=<IsExtra>}
endscript

script Trick_NoseSlideLipSlide_BS
	If BadLedge
		Goto Trick_NoseSlideLipSlide_FS_ok
	else
		Goto Trick_NoseSlideLipSlide_BS_ok
	endif
endscript

script Trick_NoseSlideLipSlide_BS_ok Name='BS NoseSlide LipSlide'
	Grind 	{Name=<Name>  Score=GRINDTAP_SCORE InitAnim=BSNoseSlideLipSlide Anim=FSBoardslide_range  Type=Slide Nollie=yes NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall ExtraTricks=Extra_BS_Grinds IsSpecial IsExtra=<IsExtra>}
endscript

script Trick_NoseSlideLipSlide_FS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_NoseSlideLipSlide_BS Params={NoBlend=yes}			;;;;;;;;;; Call it a Tailslide eventually
endscript

script Trick_NoseSlideLipSlide_BS_180
	FlipAndRotate
	BoardRotateAfter
	Goto Trick_NoseSlideLipSlide_FS Params={NoBlend=yes}			 ;;;;;;;;;; Call it a Tailslide eventually
endscript


/*
script Trick_BoomBox_FS
	Goto Trick_BoomBox_BS
endscript

script Trick_BoomBox_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_BoomBox_BS Params={NoBlend=yes}
endscript

script Trick_BoomBox_FS_180
	Goto Trick_BoomBox_BS_180
endscript
*/


script Trick_CrookedBigSpin_BS
	Grind 	{Name='Crook BigSpinFlip Switch FS Crook' Score=500 Special_item InitAnim=CrookBigSpinFlipCrook Anim=FSCrooked_range OutAnim=Init_FSCrooked OutAnimBackwards Type=Grind NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails IsSpecial FlipAfterInit ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_CrookedBigSpin_FS
	Goto Trick_CrookedBigSpin_BS Params={NoBlend=yes Name='Overcrook BigSpinFlip Overcrook'}
endscript

script Trick_CrookedBigSpin_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_CrookedBigSpin_BS Params={NoBlend=yes}
endscript

script Trick_CrookedBigSpin_FS_180
	Goto Trick_CrookedBigSpin_BS_180
endscript

script Trick_FlipKickDad2
	Grind 	{Name='Flip Kick Dad' Score=500 InitAnim=FlipKickDad_Init Anim=FlipKickDad  Stream=FlipKickD Type=Grind NoBlend=<Noblend> Idle
		GrindBail=FiftyFiftyFall ScreenShake=45 IsSpecial ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra> }
endscript

script Trick_FlipKickDad2_180
	Rotate
	BoardRotateAfter
	Goto Trick_FlipKickDad2 Params={NoBlend=yes}
endscript

script Trick_50Fingerflip2
	Grind 	{Name='5-0 Fingerflip Nosegrind' Score=500 InitAnim=TailGrindFingerFlip Anim=Nosegrind_range Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial ExtraTricks=Extra_BS_Grinds }
endscript

script Trick_50Fingerflip2_180
	BackwardsGrind grind=Trick_50Fingerflip2
endscript

/*
script Trick_FroggyGrind2
Grind 	{Name='Froggy Grind' Score=500 InitAnim=FroggyGrind_Init Anim=FroggyGrind_Idle Idle OutAnim=FroggyGrind_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial ExtraTricks=Extra_FS_Grinds OutAnimOnOllie }
endscript

script Trick_FroggyGrind2_180
    BackwardsGrind grind=Trick_FroggyGrind2
endscript


script Trick_CartWheelto50502
Grind 	{Name='Cartwheel 50-50' Score=500 InitAnim=CartwheelTo5050 Anim=FiftyFifty_range Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial ExtraTricks=Extra_FS_Grinds }
endscript

script Trick_CartWheelto50502_180
    BackwardsGrind grind=Trick_CartWheelto50502
endscript

script Trick_MPCGrind2
Grind 	{Name='Muska Beatz' Score=500 InitAnim=MPCGrind_Init Anim=MPCGrind_Idle Idle Type=Slide NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails ExtraTricks=Extra_FS_Grinds Stream=MuskaBeatz SpecialItem_details=MPC_Details IsSpecial ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>}
endscript

script Trick_MPCGrind2_180
    BackwardsGrind grind=Trick_MPCGrind2
endscript

script Trick_FalconSlide2
Grind 	{Name='Falcon Slide' Score=500 InitAnim=FalconSlide_Init Anim=FalconSlide_Idle Idle OutAnim=FalconSlide_out Type=Slide
		GrindBail=FiftyFiftyFall IsSpecial OutAnimOnOllie ExtraTricks=Extra_FS_Grinds}
endscript

script Trick_FalconSlide2_180
    BackwardsGrind grind=Trick_FalconSlide2
endscript


*/

script Trick_SprayPaintGrind2
	Grind 	{Name='Ghetto Tag Grind' Score=500 InitAnim=SprayPaint_Init Anim=SprayPaint_Range OutAnim=SprayPaint_Out Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial ExtraTricks=Extra_FS_Grinds OutAnimOnOllie Stream=GhettoTagGrind SpecialItem_details=SprayCan_Details }
endscript

script Trick_SprayPaintGrind2_180
	BackwardsGrind grind=Trick_SprayPaintGrind2
endscript

script Trick_DaffyBrokenGrind2
	Grind 	{Name='Daffy Grind' Score=500 InitAnim=DaffyBroken_Init Anim=DaffyBroken_Range Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial ExtraTricks=Extra_FS_Grinds specialitem_details=bustedboard_details}
endscript

script Trick_DaffyBrokenGrind2_180
	BackwardsGrind grind=Trick_DaffyBrokenGrind2
endscript

script Trick_GuitarSlide2
	Grind 	{Name='Faction Guitar Slide' Score=500 InitAnim=Guitar_Init Anim=Guitar_Idle Idle Type=Slide NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails ExtraTricks=Extra_FS_Grinds Stream=GuitarSlide SpecialItem_details=Guitar_Details IsSpecial }
endscript

script Trick_GuitarSlide2_180
	BackwardsGrind grind=Trick_GuitarSlide2
endscript

script Trick_AmericanHero2
	Grind 	{Name='American Tribute' Score=500 InitAnim=AmericanHeroGrind_Init Anim=AmericanHeroGrind_Idle OutAnim=AmericanHeroGrind_out Idle Type=Grind NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails ExtraTricks=Extra_FS_Grinds IsSpecial  SpecialItem_details=flag_Details SpecialSounds=Jamie_HeroSounds} //SpecialItem_details=Guitar_Details
endscript

script Trick_AmericanHero2_180
	BackwardsGrind grind=Trick_AmericanHero2
endscript

script Trick_BballSlide2_180
	BackwardsGrind grind=Trick_BballSlide2
endscript

script Trick_DoubleBluntSlide2
	Grind 	{Name='Double Blunt Slide' Score=GRINDTAP_SCORE InitAnim=DoubleBlunt_Init InitSpeed = 1.5 Anim=DoubleBlunt_Idle Idle Type=Slide NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails ExtraTricks=Extra_FS_Grinds IsATap IsExtra=<IsExtra>} //SpecialItem_details=Guitar_Details
endscript

script Trick_DoubleBluntSlide2_180
	BackwardsGrind grind=Trick_DoubleBluntSlide2
endscript


script Trick_ElbowSmash2 //ExtraTricks=Extra_BS_Grinds IsExtra=<IsExtra>
	Grind 	{Name='Elbow Smash' Score=500 InitAnim=ElbowSmash_Init Anim=ElbowSmash_Idle Idle  OutAnim=Elbowsmash_out OutAnimOnOllie Type=Slide NoBlend=<Noblend> Idle
		GrindBail=FiftyFiftyFall ScreenShake=60 IsSpecial }
endscript

script Trick_ElbowSmash2_180
	Rotate
	BoardRotateAfter
	Goto Trick_ElbowSmash2 Params={NoBlend=yes}
endscript



/*
script Trick_BoomBox_BS
Grind 	{Name='Ghetto Blastin' Score=500 InitAnim=BoomBox_Init Anim=BoomBox_Idle Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial Stream=GhettoBlastin specialitem_details=boombox_details ExtraTricks=Extra_FS_Grinds IsExtra=<IsExtra>}
endscript


script Trick_BballSlide2
 Grind 	{Name='B-Ballin Slide' Score=500 InitAnim=BasketballSlide_Init Anim=BasketballSlide_Idle OutAnim=BasketballSlide_out OutAnimOnOllie Idle Type=Slide NoBlend=<Noblend>  	GrindBail=BackwardsGrindBails ExtraTricks=Extra_FS_Grinds IsSpecial Stream=BballinSlide SpecialItem_details=basketball_details} //SpecialItem_details=Guitar_Details
endscript

script Trick_QuickDraw2
Grind 	{Name='Quick Draw' Score=500 InitAnim=JangoQuickDraw_Init Anim=JangoQuickDraw_Idle Idle  OutAnim=JangoQuickDraw_out OutAnimOnOllie Type=Grind NoBlend=<Noblend> Idle
		GrindBail=FiftyFiftyFall ScreenShake IsSpecial SpecialItem_details=pistol_details }
endscript

script Trick_QuickDraw2_180
	Rotate
	BoardRotateAfter
	Goto Trick_QuickDraw2 Params={NoBlend=yes}
endscript

script Trick_HulaHoop2
Grind 	{Name='Hula Hoopin' Score=500 InitAnim=HulaHoopGrind_Init Anim=HulaHoopGrind_Idle Idle OutAnim=HulaHoopGrind_out Type=Grind NoBlend=<Noblend> Idle OutAnimOnOllie
		GrindBail=FiftyFiftyFall IsSpecial SpecialItem_details=Hulahoop_details }
endscript

script Trick_HulaHoop2_180
	Rotate
	BoardRotateAfter
	Goto Trick_HulaHoop2 Params={NoBlend=yes}
endscript


script Trick_RockOutGrind2
Grind 	{Name='Headbangers Unite!' Score=500 InitAnim=RockOutGrind_Init Anim=RockOutGrind_Idle Idle Type=Grind NoBlend=<Noblend> Idle
		GrindBail=BackwardsGrindBails Stream=EddieGuitar IsSpecial  }
endscript

script Trick_RockOutGrind2_180
	Rotate
	BoardRotateAfter
	Goto Trick_RockOutGrind2 Params={NoBlend=yes}
endscript

script Trick_RocketTailslide_FS Name='FS Rocket Tailslide'
Grind 	{Name=<Name>  Score=500 InitAnim=RocketFS_Init Anim=RocketFS_Range Type=Slide NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_FS_Grinds IsSpecial IsExtra=<IsExtra>}
endscript

script Trick_RocketTailslide_BS Name='BS Rocket Tailslide'
Grind 	{Name=<Name>  Score=500 InitAnim=Rocket_Init Anim=Rocket_Range Type=Slide NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_BS_Grinds IsSpecial IsExtra=<IsExtra>}
endscript

script Trick_RocketTailslide_FS_180
FlipAndRotate
Goto Trick_RocketTailslide_BS Params={NoBlend=yes}
endscript

script Trick_RocketTailslide_BS_180
FlipAndRotate
Goto Trick_RocketTailslide_FS Params={NoBlend=yes}
endscript

script Trick_FerretFight2
Grind 	{Name='Ferret Fight' Score=500 InitAnim=Ferret_Init Anim=Ferret_Idle Idle Type=Grind NoBlend=<Noblend>
		GrindBail=BackwardsGrindBails OutAnimOnOllie ExtraTricks=Extra_FS_Grinds IsSpecial Stream=FerretFight SpecialItem_details=Ferret_details} //SpecialItem_details=Guitar_Details
endscript
*/

script Trick_OneFootSmith_FS  Name='FS One Foot Smith'
	Grind 	{Name=<Name>  Score=500 InitAnim=SmithFS_Init Anim=SmithFS_Range Type=Slide NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_FS_Grinds IsSpecial IsExtra=<IsExtra>}
endscript

//SmithFS_Init SmithFS_Range Smith_Init Smith_Range

script Trick_OneFootSmith_BS Name='BS One Foot Smith'
	Grind 	{Name=<Name>  Score=500 InitAnim=Smith_Init Anim=Smith_Range Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter ExtraTricks=Extra_BS_Grinds IsSpecial IsExtra=<IsExtra>}
endscript

script Trick_OneFootSmith_FS_180
	FlipAndRotate
	Goto Trick_OneFootSmith_BS Params={NoBlend=yes}
endscript

script Trick_OneFootSmith_BS_180
	FlipAndRotate
	Goto Trick_OneFootSmith_FS Params={NoBlend=yes}
endscript


//////////////////////////////////////////////

script BackwardsGrind
	Rotate
	BoardRotateAfter
	Goto <grind> Params={NoBlend=yes}
endscript


//////////////////////////////////////////////
// Point Rail Tricks; single frame grind which can occur in air or wallride state and leaves one in air state

script PointRail
	Vibrate Actuator=0 Percent=50 Duration=0.1
	Obj_SpawnScript PointRailSparks

	BroadcastEvent Type=SkaterPointRail

	// display the trick
	SetTrickName 'Kissed the Rail'
	SetTrickScore 50
	Display

	// go to air state
	Goto Airborne Params={ AllowVibration }
endscript

// Dan: this is definitely the easiest way of doing this; yet, is it a satisfactory method? will work as long as you don't grind within a fifth of a second
script PointRailSparks
	SetRearTruckSparks
	SparksOn RailNotRequired
	Wait 0.2 Seconds
	SparksOff
endscript


// RETIRED TRICKS
/*
script Trick_DrunkGrind_FS
	Goto Trick_DrunkGrind_BS
endscript

script Trick_DrunkGrind_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_DrunkGrind_BS Params={NoBlend=yes}
endscript

script Trick_DrunkGrind_FS_180
	Goto Trick_DrunkGrind_BS_180
endscript

script Trick_MaulRollGrind_BS
Grind 	{Name='Dark Jedi Grind' Score=500 InitAnim=MaulRollGrind_Init Anim=MaulRollGrind_Idle Idle Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter IsSpecial }
endscript

script Trick_MaulRollGrind_FS
	Goto Trick_MaulRollGrind_BS
endscript

script Trick_MaulRollGrind_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_MaulRollGrind_BS Params={NoBlend=yes}
endscript

script Trick_MaulRollGrind_FS_180
	Goto Trick_MaulRollGrind_BS_180
endscript

script Trick_PaddleGrind_BS
Grind 	{Name='Paddle Out Grind' Score=500 InitAnim=PaddleGrind_Init Anim=PaddleGrind_Idle Idle Type=Grind NoBlend=<Noblend>
		GrindBail=Nutter IsSpecial }
endscript

script Trick_PaddleGrind_FS
	Goto Trick_PaddleGrind_BS
endscript

script Trick_PaddleGrind_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_PaddleGrind_BS Params={NoBlend=yes}
endscript

script Trick_PaddleGrind_FS_180
	Goto Trick_PaddleGrind_BS_180
endscript
script Trick_Sobriety_BS
Grind 	{Name='Sobriety Grind' Score=500 InitAnim=Sobriety_Init Anim=Sobriety_Range Type=Grind NoBlend=<Noblend>
		GrindBail=FiftyFiftyFall IsSpecial }
endscript

script Trick_Sobriety_FS
	Goto Trick_Sobriety_BS
endscript

script Trick_Sobriety_BS_180
	Rotate
	BoardRotateAfter
	Goto Trick_Sobriety_BS Params={NoBlend=yes}
endscript

script Trick_Sobriety_FS_180
	Goto Trick_Sobriety_BS_180
endscript


*/


