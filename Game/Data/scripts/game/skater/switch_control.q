// This script is used to go from skating to Motocrossing, or vice versa

// Factored out the control so you only have to change the trigger for all three vehicles in one spot.  Hacky use of Alt_Trigger for Xbox only alternate
// trigger.
SwitchControl_Trigger={ Trigger={ PressTwoAnyOrder,L1,R1,400 } Xbox_Trigger={ Press,Black,10 } NGC_Trigger={ Press,Z,10 } Alt_Trigger={ Press,White,10 } }

;allow_other_movement_modes=1

CAVEMAN_SCORE=750
COMBO_RUNOUT_SCORE=50

// duration after caveman start during which landing causes a bail
CavemanBailDuration=0.3

// delay after a runout before run out is awarded; switching back to skating cancels run out award
// additionally, duration one must walk to earn caveman when switching to skating
RunOutTrickDelay=0.75

script RunTimerController_Reset
	RunTimer_GetRunTimerControllerId
	Obj_KillSpawnedScript Id=<RunTimerControllerId>
	Obj_SpawnScript RunTimerController_Start Id=<RunTimerControllerId> PauseWithObject

	RunTimer_GetRunTimerId
	Obj_KillSpawnedScript Id=(<RunTimerId> + 2)
	hide_run_timer id=<RunTimerId>
endscript

script RunTimerController_Start
	ClearExceptionGroup RunTimeController
	SetExceptionHandler Ex=ShowRunTimer Scr=RunTimerController_Displayed Group=RunTimeController
	Block
endscript

script RunTimerController_Displayed
	ClearExceptionGroup RunTimeController
	SetExceptionHandler Ex=HideRunTimer Scr=RunTimerController_Hidden Group=RunTimeController

	RunTimer_GetRunTimerId

	FadingSpawned=0

	SoundCounter=0
	SoundWait=4
	SoundType=0

	RunTimer_GetFactorComplete
	RotationAngle=(360 * <FactorComplete>)
	show_run_timer id=<RunTimerId> rot_angle=<RotationAngle>

	begin
		DoScreenElementMorph id={ <RunTimerId> child=0 } rot_angle=(180 - <RotationAngle>)

		hide_run_timer_piece id=<RunTimerId> rot_angle=<RotationAngle>

		if (<FadingSpawned> = 0)
			if (<RotationAngle> < 140)
				Obj_SpawnScript blink_run_timer Id=(<RunTimerId> + 2) Params={ id=<RunTimerId> } PauseWithObject
				FadingSpawned=1
			endif
		endif

		if (<SoundCounter> > <SoundWait>)
			if (<SoundType> = 0)
				if not GetGlobalFlag flag=SOUNDS_SPECIALSOUNDS_OFF
					PlaySound ClockTickDown
				endif
				SoundType=1
			else
				if not GetGlobalFlag flag=SOUNDS_SPECIALSOUNDS_OFF
					PlaySound ClockTickUp vol=150
				endif
				SoundType=0
			endif
			SoundCounter=0
		else
			SoundCounter=(<SoundCounter> + 1)
		endif


		if (<RotationAngle> < 270)
			if (<RotationAngle> < 180)
				if (<RotationAngle> < 90)
					SoundWait=1
				else
					SoundWait=2
				endif
			else
				SoundWait=3
			endif
		endif

		Wait 1 GameFrame

		RunTimer_GetFactorComplete
		RotationAngle=(360 * <FactorComplete>)
	repeat
endscript

script RunTimerController_Hidden
	ClearExceptionGroup RunTimeController
	SetExceptionHandler Ex=ShowRunTimer Scr=RunTimerController_Displayed Group=RunTimeController

	RunTimer_GetRunTimerId

	Obj_KillSpawnedScript Id=(<RunTimerId> + 2)

	soft_hide_run_timer id=<RunTimerId>

	Block
endscript

Script CleanUp_WalkingtoSkating
	AllowRailTricks

	// if not in an official transition animation, turn on the looping sounds
	GetTags
	if not GotParam AnimTags
		SkaterLoopingSound_TurnOn
	else
		if not StructureContains WalkToSkateTransition Structure=<AnimTags>
			SkaterLoopingSound_TurnOn
		endif
	endif

	// Need to handle the special case that a point rail grind transitioned us to skating.  This is an awkward case because we are transitioning out of
	// walking due to a Rail event, but will enter skating into Airborne instead of being pulled automatically into Grind by a grind trick.
	SetException Ex=PointRail Scr=PointRailWalkingToSkating
	SwitchToSkatingPhysics

	// Note that if we transition into a rail state during SwitchToSkatingPhysics, the grind trick will jump us to the Grind script
	// before SwitchToSkatingPhysics returns.

	if InAir
		SetQueueTricks NoTricks
		InAirExceptions NoSkateToWalkTricks
	else
		OnGroundExceptions
	endif
endscript

script PointRailWalkingToSkating
	// Need to handle any logic which must be run before entering Airborne.  PointRail will take us directly to Airborne.
	SetQueueTricks NoTricks
	Goto PointRail
endscript

// This key script that governs what anims are played and what you can do in the transition period between different control schemes
script Switch_OnGroundAI newscript=land
	// printstruct <...>
	/*
	If held Triangle  // claw guys don't want to switch if holding triangle
		return
	endif
	*/
	UnPausePhysics
	Unhide
	ClearExceptions
	ClearTrickQueues
	StopBalanceTrick
	NotInBail // make sure to allow grinding again


	if Driving
		ToggleUserControlledVehicleMode
	endif

	switch <newscript>
		case OnGroundAi
			;change use_bike_physics=0
			SetRollingFriction default
			DestroyAllSpecialItems
			SwitchOnBoard

			CleanUp_WalkingtoSkating

			if inair
				/*
			// Dan: A switch to skating through this path is never a player-controlled switch (just things like pre-goal state setup and such)
			// Thus, I don't think we need/want a trick or anim here.
			SetTrickName 'Unexpected Caveman'
			SettrickScore CAVEMAN_SCORE
			Display BlockSpin
			InAirExceptions
			PlayAnim Anim=JumpAirToAirIdle
			WaitAnimWhilstChecking
			*/
				Goto Airborne
			else
				/*
			OnGroundExceptions
			LandSkaterTricks
			PlayAnim Anim=WRuntoSkate
			WaitAnimWhilstChecking
			*/
				Goto OnGroundAi
			endif

		case Walking_onGroundAi
			DestroyAllSpecialItems
			SwitchOnBoard

			SwitchToWalkingPhysics

			AllowRailTricks
			;change use_bike_physics=0
			;change vehicle_mode=0

			if GotParam Restart
				Goto JustStoppedSkatingState Params={ Restart }
			else
				Goto JustStoppedSkatingState
			endif
			/*
	case Motox_ongroundAi
		change use_bike_physics=1
		change vehicle_mode=0
		CreateSpecialItem index=0 params=motoxbike_details
		SwitchOffBoard

		if inair
			Goto Motox_Airborne
		else
			Goto Motox_ongroundAi
		endif
*/
		case TransAm
			;change use_bike_physics=0
			Goto ToggleUserControlledVehicleMode Params={ <...> }
			// Wait 0.1 seconds
			// Goto TransAm_OnGround

		default
			ScriptAssert "Bad NewScript passed to Switch_OnGroundAi"
	endswitch


	//	SetRollingFriction 1000
	//	PlayAnim Anim=NewBrake
	//	WaitAnimFinished
	//	SetRollingFriction default
	//	wait 10 game frame

	//	ClearEventBuffer
endscript

// script TransAm_OnGround
// just a hack for now to keep the skater checking for the switch vehicles control, so you can switch out of the transam
//SetQueueTricks TransAmTricks
//begin
//  DoNextTrick
//	Wait 1 gameframe
//repeat
// endscript

/*
TransAmTricks = [
    {SwitchControl_Trigger    		Scr=CheckforSwitchVehicles }
]
*/

script CheckforSwitchVehicles newscript=OnGroundAi
	// printstruct <...>
	/*    if Held L2
            if IsTrue allow_other_movement_modes
                Goto Switch_OnGroundAI params={newscript=Motox_OnGroundAi}
            endif
        endif
     */

	/*
		If IsXbox
			if Held Black
				if IsTrue allow_other_movement_modes
					Goto Switch_OnGroundAI params={newscript=TransAm}
				endif
			endif
		else
			if IsPs2
				If Held R2
					if IsTrue allow_other_movement_modes
						Goto Switch_OnGroundAI params={newscript=TransAm}
					endif
				endif
			endif
 		endif
	*/

	if Walking
		Goto Switch_OnGroundAI params={newscript=OnGroundAi}
	else
		;if (use_bike_physics || vehicle_mode)
		;Goto Switch_OnGroundAI params={newscript=OnGroundAi}
		;else
		Goto Switch_OnGroundAI params={newscript=walking_ongroundai}
		;endif
	endif
endscript

/*
script SFX_TimerClockTicks
//script to run when timer shows up on screen
<RunoutClockTickSoundTime> = 12 ;.198
begin
	PlaySound ClockTickDown
	wait (<RunoutClockTickSoundTime>) gameframes ;seconds
	PlaySound ClockTickUp
	wait (<RunoutClockTickSoundTime>) gameframes ;seconds
repeat 4
begin
	PlaySound ClockTickDown
	wait (<RunoutClockTickSoundTime>) gameframes ;seconds
	PlaySound ClockTickUp
	wait (<RunoutClockTickSoundTime>) gameframes ;seconds
	<RunoutClockTickSoundTime>=(<RunoutClockTickSoundTime> - 1);.009)
repeat 12
endscript
*/
