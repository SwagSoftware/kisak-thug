/* SP REMOVED FOR THUG
// WARNING: CHEESY HACK FOLLOWS
// This is for Bob's Pro Specific challenge
// Basically, we fake the gapped loop with an invisible skateable poly across the gap
// So the skater is still skating, but we change the scripts so it "feels" like you're in the air
// We do this because the physics are not designed for upside down skating


// This script is fired off by four single side trigger polygons on the loop
// Two are for jumping (and start a ways before the gap in the loop)
// And two are for landing on the far side
// They basically put the skater into or take him out of this weird upside down skating ai

script TwoWayLoopCheck
	If not InAir
		If Obj_FlagSet FLAG_SKATER_INLOOP
			printf "In the loop and so making you land"
			Obj_ClearFlag FLAG_SKATER_INLOOP
			// PlaySound SaberTwirl5
			//SetSlomo 1.0
			SetRollingFriction default
			//ClearSkaterCamOverride
			LockVelocityDirection Off
			If DoingTrick
				SetSlomo 1
				kill_blur
				MakeSkaterGoto Facesmash
			else
				SetlandedFromVert
				SetSlomo 1
				kill_blur
				MakeSkaterGoto Land
			endif
		else
			Obj_SetFlag FLAG_SKATER_INLOOP
			// printf "NOT In the loop and so making you go to LoopGapStart"
			//SetSlomo 1
			//SetSkaterCamOverride heading=1.5 tilt=-.2 time=.5
			//SetRollingFriction 10
			MakeSkaterGoto LoopGapStart
		endif
	endif

endscript

// This is the basic AI of the skater while he is on the invisible polygon

script LoopGapStart
//	printf "GOT HERE"
	OnGroundExceptions
	//ClearException	Ollied
	SetException 	Ex=Ollied	Scr=LoopGapOllie
	SetException	Ex=Landed	Scr=Land

	// If we leave the loop ai for any reason make sure to turn this of
	OnExceptionRun LoopGapOut
	LockVelocityDirection On	// This makes it so we can pseudo rotate like in the air,
								// otherwise when we turn we will skate off the poly
	// Give the skater air tricks
	SetSkaterAirTricks

	PlayAnim Anim=AirIdle Cycle NoRestart
	Begin
		DoNextTrick
		Obj_GetSpeed
		// printf "speed=%s" s=<speed>
		// if we go too slowly we will fall out of the loop
		If (<speed> < 25)
			 setstate air
			LockVelocityDirection Off
			// printf "TO SLOOOOOOOOOOOOOOW"
			create_panel_message text="Going too slow!!!" pos=(320, 200)
			Obj_ClearFlag FLAG_SKATER_INLOOP
			If not DoingTrick
				Goto Airborne
			endif
		endif
	Wait 1 game frame
	Repeat
endscript

script LoopGapOllie
	playJumpsound
	PlayAnim Anim=Ollie
	Goto LoopGapStart
endscript

// If we leave the loop ai for any reason make sure to turn this off

script LoopGapOut
	LockVelocityDirection Off
endscript



////////////////////////////////////////////////////////////
//	OLD LOOP STUFF FROM THPS3
////////////////////////////////////////////////////////////

Script Loop
    Name='Loop Balance' Score=1000 InitAnim=CrouchIdle FromAirAnim=ManualFromAir BalanceAnim=CrouchIdle OffMeterTop=ManualBail OffMeterBottom=ManualBail
ClearExceptions
If InAir
	Goto LoopOllie
endif
Obj_SetFlag FLAG_SKATER_INLOOP   // we're going to track you while you loop
OnExceptionRun	LoopException	 // if you do anythig beside keep on going, we're gonna clear the FLAG_SKATER_INLOOP flag
SetException	Ex=Ollied	Scr=LoopOllie
ClearLipCombos   // If we come out of a lip trick we want to make sure this is turned off
SetException Ex=GroundGone          Scr=LoopOllie
SetException Ex=MadeOtherSkaterBail	Scr=MadeOtherSkaterBail_Called
SetException Ex=OffMeterTop			Scr=NoseManualBail
SetException Ex=OffMeterBottom		Scr=ManualBail
SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
SetQueueTricks NoTricks ; Hmmm, this is to stop transitioning from manual <-> nosemanual when quickly pressing
                        ; up and down when balancing. Would one still want to be able to do boneless etc out of a manual though?
SetManualTricks NoTricks
StartBalanceTrick           ; Mick .. added this so code think you are in a manual for the "init" animation
Vibrate Actuator=1 Percent=25
SetRollingFriction 2
//DoBalanceTrick ButtonA=Up ButtonB=Down Type=Manual Tweak=10
PlayAnim Anim=Loop_Range wobble
SetTrickName <Name>
SetTrickScore 5000
Display	Blockspin
begin
If SpeedLessThan 400
	Obj_ClearFlag FLAG_SKATER_INLOOP
	If InSplitScreenGame
	else
		LaunchPanelMessage "&C1Not Enough Speed" properties=panelcombo
	endif
	LoopOllie
endif
WaitOneGameFrame
repeat
endscript

script LoopException
//	printf "clearing the loop flag ======================"
	Obj_ClearFlag FLAG_SKATER_INLOOP
endscript


script LoopOllie
	ClearExceptions
    Obj_ClearFlag FLAG_SKATER_INLOOP
    if AbsolutePitchGreaterThan 80      // only fudge it if leaning over a lot
        Move y=13            // Mick: move more away from the ground to prevent snappage
        SetSpeed 0             // Mick, reduce speed, to stop us popping through loop
    endif
    SetState Air
	InBail				;notify the SFX and net code
	ClearExceptions
	SetException 	Ex=SkaterCollideBail	Scr=SkaterCollideBail
	SetException	Ex=Landed	Scr=BackwardFaceSlam
	SetQueueTricks NoTricks
	DisablePlayerInput AllowCameraControl
	PlayAnim	Anim=StretchtoFlailingFall 	BlendPeriod=0.3
    ClearGapTricks
	ClearPanel_Bailed
    if AbsolutePitchGreaterThan 40
        SetSpeed 1             // Mick, reduce speed, to stop us popping through loop
	endif
    WaitAnim 90 percent
	SwitchOffBoard
	WaitAnimFinished
	PlayAnim	Anim=FlailingFall 	Cycle
endscript


Script LoopLand
	If Obj_FlagSet FLAG_SKATER_INLOOP
		StopBalanceTrick
		if InSplitScreenGame
		else
			LaunchPanelMessage "Loop Bonus!" properties=panelcombo
		endif
		PlaySound HUD_specialtrickAA Vol=500
		SetLandedFromVert
		Goto Land Params={RevertTime=30}
	else
		Goto LoopOllie
	endif
endscript
*/
