// start autoduck documentation
// @DOC sk4_scripts
// @module sk4_scripts | None
// @subindex Scripting Database
// @index script | sk4_scripts

//for testing
script ScottKills
	sk3_killskater deathsound=boneless09 message1="poopoo" message2="waaaaa" message3="yowsers" message4="Cheesy Peasey likes ass" r=0 g=255 b=0
endscript
// @script | SK3_KillSkater |
// The generic killing skater script called by levels
// @parm name | nodename | The name of the node you want the skater to be sent to, or else the linked node is used
// @parmopt string | NoMessage |  | If this flag is present, no panel messages will be sent
// @parmopt string | Message1 | "You suck!" | If you want the panel to print up a message when killing, pass it 4 messages
// @parmopt string | Message2 | "Dont do drugs!" | If you want the panel to print up a message when killing.
// @parmopt string | Message3 | "Nice one!" | If you want the panel to print up a message when killing.
// @parmopt string | Message4 | "Loser!" | If you want the panel to print up a message when killing.
// @parmopt string | DeathSound | hitbody02 | The sound to play when you hit the plane.


script SK3_KillSkater
	if Obj_FlagNotSet FLAG_SKATER_KILLING	//We only want to kill you once
		Obj_SetFlag FLAG_SKATER_KILLING
		InBail
		If GotParam DeathSound
			PlaySound <DeathSound>
		else
			//PlaySound hitbody02 pitch=90 vol=150
			//PlaySound bail_knee1 pitch=90 vol=50
			PlaySound BailBodyPunch01_11
			PlaySound BailSlap01
			PlaySound BailBodyFall01
		endif
		If Not GotParam NoMessage
			if not GetGlobalFlag flag=NO_DISPLAY_HUD
				if Not InSplitScreenGame
					If GotParam Message1
						Create_Panel_Message  style=panel_message_death id=death_message text=random (
							@<message1>
							@<message2>
							@<message3>
							@<message4>)
					else
						if Driving
							Create_Panel_Message  style=panel_message_death id=death_message text=random (
								@"Don't drink and drive!"
								@"Learn to drive!"
								@*2 "Out of bounds!" )
						else
							Create_Panel_Message  style=panel_message_death id=death_message text=random (
								@"You suck!"
								@"Don't do drugs!"
								@"Stay in school!"
								@"This is your brain on drugs!"
								@"Nice one!"
								@"Good one!"
								@"Hmmmmm..."
								@"Loser!"
								@"Who loaned you that board?"
								@*4 "Out of bounds!" )
						endif
					endif
				endif
			endif
		endif
		SK3_Killskater_Finish <...>
	endif
endscript

script SK3_KillSkater_Water
	if Obj_FlagNotSet FLAG_SKATER_KILLING	//We only want to kill you once
		Obj_SetFlag FLAG_SKATER_KILLING
		If GotParam DeathSound
			PlaySound <DeathSound>
		else
			PlaySound FallWater
		endif
		if Not InSplitScreenGame
			if not GetGlobalFlag flag=NO_DISPLAY_HUD
				If GotParam Message1
					Create_Panel_Message  style=panel_message_death id=death_message text=random (
						@<message1>
						@<message2>
						@<message3>
						@<message4>)
				else
					Create_Panel_Message  style=panel_message_death id=death_message text=random (
						@"All wet"
						@"You big drip!"
						@"WATER... BAAAD!"
						@"No swimming"
						@"You're drowning!"
						@"You're hosed!")
				endif
			endif
		endif
		SK3_Killskater_Finish water r=100 g=100 b=200 <...>
	endif
endscript

script SK3_KillSkater_Pungee
	if Obj_FlagNotSet FLAG_SKATER_KILLING	//We only want to kill you once
		Obj_SetFlag FLAG_SKATER_KILLING
		PlaySound FallPungee_11
		if Not InSplitScreenGame
			if not GetGlobalFlag flag=NO_DISPLAY_HUD
				if not GotParam Lava
					Create_Panel_Message  style=panel_message_death id=death_message text=random (
						@"You got shafted"
						@"Who built that?!"
						@"Serve, set, spike!"
						@"Shish kabob?"
						@"Don't build this at home!" )
				else
					Create_Panel_Message  style=panel_message_death id=death_message text=random (
						@"Toasted toes!"
						@"Burnt to a crisp!"
						@"Grilled to perfection!"
						@"Ouch!"
						@"Death by hot lava!" )
				endif
			endif
		endif
		SK3_Killskater_Finish r=150 g=50 b=50 <...>
	endif
endscript


script SK4_Hide_Death_Message
	if ObjectExists id=death_message
		SetScreenElementProps id=death_message rgba=[0 0 0 0]
	endif
endscript

// This handles the general killing of the skater, reseting him
// and flashing the screen

script SK3_Killskater_Finish r=255 g=255 b=255
	if not Driving
		// we used to (THPS4) kill the skater's exceptions straight away; now we do it through this event
		Obj_GetID
		LaunchEvent type=KillingSkater target=<objId>
		// ClearException
	endif

	DisablePlayerInput
	If GotParam Bail
		if Skating
			MakeSkaterGoto Killskater_Bail //break the skater out of his current anim and play this one
		endif
	endif
	pulse_blur start =0 end=255 speed = 4
	// makes the screen flash a color
	//DoFlash {duration = .25
	//	start_r = <r> start_g = <g> start_b = <b> start_a = 0
	//	end_r = <r> end_g = <g> end_b = <b> end_a = 100}
	If GotParam Water
		SkaterSplashOn
		PausePhysics
		Hide
		if ObjectExists Id=PlayerVehicle
			PlayerVehicle:Hide
		endif
		wait .1 seconds
	else
		Wait .25 seconds
	endif

	ClearTrickQueues

	Wait 1 gameframe	// After clearing the tricks, we need to wait a frame to let the OnGroundexceptions re-queue the tricks
	BlendPeriodOut 0

	ClearEventBuffer
	BailSkaterTricks

	if not Driving
		if GotParam Nodename
			;	Obj_MoveToNode name = <nodename> Orient
			;	MakeskaterGoto SkaterInit
			KillSkater node=<nodename>  // More consistent.  Pass the node into the KillSkater command
		else
			KillSkater			// W/o the wait, the cleartrickqueues comes in after the restart, and disables manuals...
		endif
	else
		PlayerVehicle:Vehicle_MoveToRestart <nodename>
		PlayerVehicleCamera:VehicleCamera_Reset
		PlayerVehicle:Unhide
		if PlayerVehicle:Vehicle_IsSkaterVisible
			Unhide
		endif
	endif

	// If we die while a speech box (i.e. taxi guy) is up, get rid of it
	if InNetGame
		// Don't kill rankings screen 'press X to continue' message
		if GameModeEquals is_goal_attack
			if Not GameIsOver
				speech_box_exit
			endif
		endif
	else
		speech_box_exit
	endif

	ResetSkaterParticleSystems

	pulse_blur start =255 end=0 speed = 4
	Wait .75 seconds
	NotInBail

	Obj_ClearFlag FLAG_SKATER_KILLING

	// lose any horse goal
	if GoalManager_HasActiveGoals
		if GoalManager_GetActiveGoalId
			GoalManager_GetGoalParams name=<goal_id>
			if GotParam horse
				GoalManager_LoseGoal name=<goal_id>
			endif
		endif
	endif
endscript

script Panel_Message_Death
	Domorph pos=(320,80) alpha=0  scale=0
	Domorph alpha=1 time=.25 scale=1.3
	Domorph time=.15 scale=1
	wait 2 seconds
	Domorph scale=1.3 time=.15
	Domorph alpha=0 time=.25 scale=0
	Die
endscript

script Killskater_Bail
	PlayAnim Anim=SlipForwards BlendPeriod=0.3
endscript

// This script is only left in for compatibility with old script commands
script SK3_TeleportToNode
	TeleportSkaterToNode <...>
endscript

// @script | TeleportSkaterToNode |
// This is a modification of the Killskater script to use for teleporting the skater,
// and not killing him, and allowing him to continue his combo (elevators, etc.)
// @parm name | nodename | The name of the node you want the skater to be teleported to
// @parmopt string | Message1 | "On the Move!" | If you want the panel to print up a message when teleporting.
// @parmopt int | r | 255 | You can make the screen flash a color if you like.
// @parmopt int | g | 255 | You can make the screen flash a color if you like.
// @parmopt int | b | 255 | You can make the screen flash a color if you like.
script TeleportSkaterToNode r=255 g=255 b=255
	If GotParam Message1
		LaunchPanelMessage  properties=panel_message_death random (
			@<message1>)
	else
		LaunchPanelMessage  properties = panel_message_death "On the Move!"
	endif
	/* makes the screen flash a color
	DoFlash {duration = .25
		start_r = <r> start_g = <g> start_b = <b> start_a = 0
		end_r = <r> end_g = <g> end_b = <b> end_a = 100}
	*/
	If GotParam nodename
		printf "Got the nodename ...................."
		if skating
			If OnRail

				// Clear any trick that might rely on us still being on a rail
				ClearEventBuffer
				ClearTrickQueue
				KillExtraTricks
				ClearExtraGrindTrick
				StopBalanceTrick
				MakeSkaterGoto GroundGone

			endif
		endif
		Obj_MoveToNode name = <nodename> Orient NoReset
	else
		LaunchPanelMessage  properties=panel_message_death "ERROR! Please pass in nodename="
	endif
	Wait .25 seconds
	/*	DoFlash {duration = .75
		start_r = <r> start_g = <g> start_b = <b> start_a = 100
		end_r = <r> end_g = <g> end_b = <b> end_a = 0}

	Wait .75 seconds */
endscript

script PrepareSkaterForMove
	if Skating
		SetState AIR
		CleanUpSpecialItems
		StopBalanceTrick
		MakeSkaterGoto GroundGone
		LandSkaterTricks           // This would have triggered RunHasEnded, putting us in an inifinite loop
		ClearEventBuffer
	endif
endscript

/*
panel_message_death = {
	font = "small.fnt"
	just = (0,0)
	dims = (320,80)
	colors = [
		{ (110,20,20) alpha = 255 }
		{ (110,20,20) alpha = 255 } ]
	key_points=[
		{pos=(330,110) alpha=0 scale=4 time=0}
//        {pos=(330,80) alpha=50 scale=1.5 time=.2}
//		{pos=(330,80) alpha=80 scale=1.2 time=.3}
		{scale=1.2 alpha=90 time=.4}
		{time=2}
		{scale=0 alpha=0 time=2.5} ]
}
*/

//Raise the skater out of the cutscene
Script TeleportSkaterUp dist=2000
	Skater:SparksOff
	Skater:Move y=<dist>
	//MakeSkaterGoto MoveSkaterZ params={dist=<dist>}
EndScript

//Lower the skater back into the cutscene
Script TeleportSkaterDown dist=-2000
	Skater:SparksOff
	Skater:Move y=<dist>
	//MakeSkaterGoto MoveSkaterZ params={dist=<dist>}
EndScript

Script MoveSkaterZ dist=0
	SparksOff
	Move y=<dist>
EndScript

//********** CAR STUFF **********

FLAG_TRAFFICLIGHT_GREEN		 = 0
FLAG_TRAFFICLIGHT_YELLOW	 = 1
FLAG_TRAFFICLIGHT_RED		 = 2
FLAG_CAR_GENERIC_STOPPED	 = 3
FLAG_CAR_GENERIC_NOSOUND	 = 4
FLAG_CAR_SOUND_FRANTICSTOP	 = 5
FLAG_CAR_SKITCH				 = 7
FLAG_CAR_TYPE_BUS			 = 30
FLAG_CAR_GENERIC_STOPPED_SKATER	 = 8

script SK4_TrafficLight01
	Obj_SetFlag FLAG_TRAFFICLIGHT_GREEN
	create name = <Green>
	wait randomrange ( 5000, 12000 )
	begin
		Obj_SetFlag FLAG_TRAFFICLIGHT_YELLOW
		Obj_ClearFlag FLAG_TRAFFICLIGHT_GREEN
		kill name = <Green>
		create name = <Yellow>
		wait 3000
		Obj_SetFlag FLAG_TRAFFICLIGHT_RED
		Obj_ClearFlag FLAG_TRAFFICLIGHT_YELLOW
		kill name = <Yellow>
		create name = <Red>
		wait randomrange ( 9000, 15000 )
		Obj_SetFlag FLAG_TRAFFICLIGHT_GREEN
		Obj_ClearFlag FLAG_TRAFFICLIGHT_RED
		kill name = <Red>
		create name = <Green>
		wait randomrange ( 7000, 12000 )
	repeat
endscript

script Car_Generic01 TurnDist = 20 DefaultSpeed = 40 ForwardOffset = 5 SkitchSpeed = 60 CarLoopSFX = CarLoop
	SetTags DefaultSpeed = <DefaultSpeed> Tag_TurnDist = <TurnDist> CarLoopSFX = <CarLoopSFX>
	GetTags
	;// printstruct <...>
	; Obj_SetGroundOffset .1
	Obj_SetPathTurnDist <Tag_TurnDist>
	Obj_FollowPathLinked
	Obj_SetPathAcceleration 10 mphps
	Obj_SetPathDeceleration 10 mphps
	Obj_SetPathMinStopVel 5
	Obj_SetPathVelocity <DefaultSpeed> mph
	if NOT GotParam AllowSlow
		if (<DefaultSpeed> < 20) // Make sure that speed is not set too slow
			printf"### CAR SPEED TOO SLOW! CHANGING TO 20mph ###"
			printstruct <DefaultSpeed>
			<DefaultSpeed> = 20
			printstruct <DefaultSpeed>
		endif
	endif
	if GotParam Bus
		Obj_SetFlag FLAG_CAR_TYPE_BUS
	endif
	if GotParam SkaterDebugBox
		<SkaterDebugBox> = debug
	endif
	if GotParam CarDebugBox
		<CarDebugBox> = debug
	endif
	if GotParam NoSound // If passed NoSound, dont play any sounds
		Obj_SetFlag FLAG_CAR_GENERIC_NOSOUND
	else
		Obj_PlaySound <CarLoopSFX>
	endif
	if GotParam NoSkater // If passed NoSkater, dont check for skater
	else
		Obj_SpawnScript Car_CheckForSkater01 params = <...>
	endif
	Obj_SpawnScript Car_CheckForOtherCar01 params = <...>
endscript

Car_CheckForSkater_Pause=1
script Car_CheckForSkater01
	// K: These params are created here for speed, rather than creating them each time round the loop.
	// Also using type=skater rather than type=[skater] to prevent creation of an array, which is slow.
	if GotParam bus
		SkaterCheckOffset = ( 0, 0, 28 )
	else
		if GotParam truck
			SkaterCheckOffset = ( 0, 0, 16 )
		else
			if GotParam atv
				SkaterCheckOffset = ( 0, 0, 3 )
			else
				SkaterCheckOffset = ( 0, 0, 5.5 )
			endif
		endif
	endif
	p1={dist = (<DefaultSpeed>*1.5) width = 15 height = 25 type = skater offset = <SkaterCheckOffset> <SkaterDebugBox>}
	p2={dist = (<DefaultSpeed>*1.5) width = 15 height = 20 type = skater offset = <SkaterCheckOffset> <SkaterDebugBox>}
	// K: This causes each car to wait a different amount of time before starting the loop,
	// so that the 'wait 10 gameframes' are not all in sync, which causes spikes on the profiler.
	Change Car_CheckForSkater_Pause=(Car_CheckForSkater_Pause+1)
	if (Car_CheckForSkater_Pause>10)
		Change Car_CheckForSkater_Pause=1
	endif
	wait Car_CheckForSkater_Pause gameframes
	begin
		wait 10 gameframes
		if LocalSkaterExists
			if Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED  // only check for the skater if the car is moving
				if Obj_ObjectInRect <p1>
					//printf "*********** Killing CarAccelSound *********"
					KillSpawnedScript id=CarAccelSound
					Obj_AdjustSound <CarLoopSFX> volumePercent = 50 volumeStep = 1.5 pitchPercent = 40 pitchStep = 1.5
					Car_Sound_FranticStop01
					Obj_StopAlongPath 8
					Obj_SetFlag FLAG_CAR_GENERIC_STOPPED_SKATER  // the car has stopped for the skater so don't start no matter what (even if a car it had stopped for has moved)
					begin  // check every second to see if the skater has moved from infront of the car
						wait 90 gameframes
						if Obj_ObjectInRect <p2>
							KillSpawnedScript id=CarAccelSound
							wait 60 gameframes
							Car_Sound_RandomHonk01
						else
							//Obj_AdjustSound <CarLoopSFX> volumePercent = 100 volumeStep = 0.7 pitchPercent = 80 pitchStep = 0.7
							//printf "************Starting CarAccelSound *************"
							SpawnSound Car_Sound_Accel01 id=CarAccelSound
							Obj_StartAlongPath
							Obj_ClearFlag FLAG_CAR_GENERIC_STOPPED_SKATER
							break
						endif
					repeat
				else
					// K: Change to be SkitchRange rather than [SkitchRange] to prevent
					// creation of an array parameter, which is slow.
					// if Skater: animequals  SkitchRange  // If the skater is skitching, speed up
					if Skater:Skitching  // If the skater is skitching, speed up
						Obj_GetSpeed
						if Obj_FlagNotSet FLAG_CAR_SKITCH  // Only set the speed if it hasn't been set already
							Obj_SetFlag FLAG_CAR_SKITCH
							if Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND
								Obj_playsound  LA_Skid_11
							endif
							Obj_SetPathVelocity <SkitchSpeed> mph
						endif
					else
						if Obj_FlagSet FLAG_CAR_SKITCH  // If the skitch flag is set, but the skater isn't in the skitch anim, go back to normal speed
							// printf"### speed back to normal####"
							Obj_ClearFlag FLAG_CAR_SKITCH
							if NOT GotParam NoSkitchStop
								// stop and wait after you stop skitcing
								Obj_SetFlag FLAG_CAR_GENERIC_STOPPED
								Obj_StopAlongPath 15 feet
								wait 1 second
								Obj_ClearFlag FLAG_CAR_GENERIC_STOPPED
								Obj_StartAlongPath
							endif
							Obj_SetPathVelocity <DefaultSpeed> mph
						endif
					endif
				endif
			endif
		endif
	repeat
endscript

Car_CheckForOtherCar_Pause=1
script Car_CheckForOtherCar01
	// K: These params are created here for speed, rather than creating them each time round the loop.
	// Also using type=skater rather than type=[skater] to prevent creation of an array, which is slow.
	p1={dist = (<DefaultSpeed>*1.5) width = 20 height = 20  offset = ( 0, 0, 5 ) <CarDebugBox>}
	p2={dist = <DefaultSpeed> width = 20 height = 20  offset = ( 0, 0, 5 ) <CarDebugBox>}
	// K: This causes each car to wait a different amount of time before starting the loop,
	// so that the 'wait 10 gameframes' are not all in sync, which causes spikes on the profiler.
	Change Car_CheckForOtherCar_Pause=(Car_CheckForOtherCar_Pause+1)
	if (Car_CheckForOtherCar_Pause>10)
		Change Car_CheckForOtherCar_Pause=1
	endif
	wait Car_CheckForOtherCar_Pause gameframes
	begin
		wait 10 gameframes
		if Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED
			CarGeneric_GetNextObjOnPath_Decel <...>
			GetTags
			Obj_GetNextObjOnPath Range = <LookAheadCheckDist_Decel>
			if GotParam Ob
				Obj_SpawnScript Car_DecelForOtherCar01 params = <...>
				if IsAlive name = <Ob>
					CarGeneric_GetNextObjOnPath_Stop <...>
					GetTags
					Obj_GetNextObjOnPath Range = <LookAheadCheckDist>
				endif
				if GotParam Ob
					Car_StopForOtherCar01 <...>
				endif
			endif
		endif
	repeat
endscript

script Car_StopForOtherCar01
	KillSpawnedScript id=CarAccelSound
	Obj_SetFlag FLAG_CAR_GENERIC_STOPPED
	Obj_StopAlongPath 7
	GetTags
	if Obj_FlagSet FLAG_CAR_TYPE_BUS
		printf"### distance ahead bus looked before stopping = %d" d = <LookAheadCheckDist>
	endif
	Car_Sound_Stop01
	//Car_InchUpAfterStop
	begin
		// Randomly honk if the car has stopped for another car.  Likely that it has stopped
		// for a car that has stopped for a light or the skater
		Car_Sound_RandomHonk01
		if IsAlive name = <Ob>
			CarGeneric_GetNextObjOnPath_Stop <...>
			GetTags
			Obj_GetNextObjOnPath Range = <LookAheadCheckDist>
		endif
		// if not Car_ObjectInRect dist = 50 width = 50 height = 20 offset = ( 0, 0, 0 )
		if not GotParam Ob
			if Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED_SKATER
				Car_StartForOtherCar01 <...>
				break
			endif
		endif
		wait 60 gameframes
	repeat
endscript

script Car_StartForOtherCar01
	SpawnSound Car_Sound_Accel01 id=CarAccelSound
	Obj_ClearFlag FLAG_CAR_GENERIC_STOPPED
	wait 20 gameframes  // give the car twice the time in the stop for skater loop to make sure the skater is not in the way
	if Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED_SKATER
		Obj_SetPathVelocity 30 mph
		Obj_StartAlongPath
	endif
endscript

script CarGeneric_GetNextObjOnPath_Decel // for decelling
	LookAheadCheckDist_Decel = 45  // default distance to look ahead for another car
	if GotParam bus
		LookAheadCheckDist_Decel = ( <LookAheadCheckDist_Decel> + 20 )  // look further ahead if you are a bus as buses are longer
	else
		if GotParam truck
			LookAheadCheckDist_Decel = ( <LookAheadCheckDist_Decel> + 10 )  // look further ahead if you are a bus as buses are longer
		endif
	endif
	SetTags LookAheadCheckDist_Decel = <LookAheadCheckDist_Decel>
endscript

script CarGeneric_GetNextObjOnPath_Stop  // for stopping
	LookAheadCheckDist = 37  // default distance to look ahead for another car
	if GotParam bus
		LookAheadCheckDist = ( <LookAheadCheckDist> + 20 )  // look further ahead if you are a bus as buses are longer
	else
		if GotParam truck
			LookAheadCheckDist_Decel = ( <LookAheadCheckDist_Decel> + 10 )  // look further ahead if you are a bus as buses are longer
		endif
	endif
	if Queryflag name = <Ob> FLAG_CAR_TYPE_BUS
		LookAheadCheckDist = ( <LookAheadCheckDist> + 10 )  //  look further ahead if the obuject infront of you is a bus
	endif
	SetTags LookAheadCheckDist = <LookAheadCheckDist>
endscript

script Car_Sound_Accel01
	//printf "************Starting CarAccelSound *************"
	GetTags
	if Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND
		//printf "********** 1st gear **************"
		Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 0.75  pitchPercent = randomrange(83, 87) pitchStep = randomrange(0.6, 0.9)
		wait randomrange(0.9, 1.5) seconds
		//printf "********** adjusting down **************"
		Obj_AdjustSound <CarLoopSFX> volumePercent = 60 volumeStep = 3 pitchPercent = randomrange(48, 52) pitchStep = randomrange (4, 5.5)
		wait randomrange (.15, .4) seconds


		GetTags
		if Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED
			//printf "********** 2nd gear **************"
			Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 0.5 pitchPercent = randomrange(77, 81) pitchStep = randomrange(0.4, 0.6)
			wait randomrange (1.2, 1.9) seconds
			//printf "********** adjusting down **************"
			Obj_AdjustSound <CarLoopSFX> volumePercent = 55 volumeStep = 4 pitchPercent = randomrange(42, 47) pitchStep = randomrange (0.4, 0.5)
			wait randomrange (.15, .4) seconds
		endif

		GetTags
		if Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED
			//printf "********** 3rd gear **************"
			Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 0.4 pitchPercent = 73 pitchStep = 0.4
			wait 2.0 seconds
			//printf "********** adjusting down **************"
			Obj_AdjustSound <CarLoopSFX> volumePercent = 50 volumeStep = 5 pitchPercent = 45 pitchStep = 5
			wait randomrange (.15, .4) seconds
		endif

		GetTags
		if Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED
			//printf "********** 4th gear **************"
			Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 0.3 pitchPercent = 60 pitchStep = 0.3
		endif

	endif
endscript

script Car_Sound_Decel01
	//printf "************Killing CarAccelSound *************"
	KillSpawnedScript id=CarAccelSound
	GetTags
	if Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND
		Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 2 pitchPercent = randomrange (40, 50) pitchStep = 1
		wait 1 second
		Obj_PlaySound CarBrakeSqueal vol = randomrange ( 5, 20 ) pitch = randomrange ( 80, 100 )
	endif
endscript

script Car_Sound_Stop01
	KillSpawnedScript id=CarAccelSound
	GetTags
	if Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND
		Obj_AdjustSound <CarLoopSFX> volumePercent = 50 volumeStep = 1.5 pitchPercent = 30 pitchStep = 1.5
		Obj_PlaySound CarBrakeSqueal vol = randomrange ( 40, 50 ) pitch = 80
	endif
endscript

script Car_Sound_FranticStop01
	KillSpawnedScript id=CarAccelSound
	GetTags
	if Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND
		if Obj_FlagNotSet FLAG_CAR_SOUND_FRANTICSTOP
			Obj_PlaySound LA_Skid_11 vol = randomrange ( 30, 60 )
			random ( @ @ @
				Obj_PlaySound CarHorn_11 vol = randomrange ( 30, 70 ) pitch = randomrange (80, 100) )
		endif
	endif
	Obj_SpawnScript Car_Counter_FranticStop01
endscript

script Car_Counter_FranticStop01  //  Keep the car from playing multiple franticstops when doing independent skater and turning checking
	Obj_SetFlag FLAG_CAR_SOUND_FRANTICSTOP
	KillSpawnedScript id=CarAccelSound
	Wait 120 gameframes
	Obj_ClearFlag FLAG_CAR_SOUND_FRANTICSTOP
endscript

script Car_Sound_RandomHonk01
	if Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND
		random ( @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @ @
			@Obj_PlaySound CarHorn_11 vol = randomrange ( 30, 70 ) pitch = randomrange (80, 100) )
	endif
endscript


script Car_PickRandomPath
	Obj_FollowPath name = random ( @<Path1> @<Path2> )
endscript

script Car_Accel01
	if Obj_FlagSet FLAG_CAR_SKITCH  // Don't adjust speed if skitching
	else
		GetTags
		GetRandomValue name = AccelSpeed a = (<DefaultSpeed>*0.9) b = (<DefaultSpeed>*1.2)
		Obj_SetPathVelocity <AccelSpeed> mph
		SpawnSound Car_Sound_Accel01 id=CarAccelSound
		if GotParam printstruct
			printf"##### ACCEL #####"
			printstruct <...>
		endif
	endif
	if GotParam StickToGround
		Obj_StickToGround on DistAbove = 2 DistBelow = 2
	else
		if GotParam NoStickToGround
			Obj_StickToGround off
		endif
	endif
endscript

script Car_AccelAfterDecelForCar01
	if Obj_FlagSet FLAG_CAR_SKITCH  // Don't adjust speed if skitching
	else
		GetTags
		GetRandomValue name = AccelSpeed a = (<DefaultSpeed>*0.9) b = (<DefaultSpeed>*1.2)
		Obj_SetPathVelocity <AccelSpeed> mph
		SpawnSound Car_Sound_Accel01 id=CarAccelSound
	endif
endscript

script Car_Decel01
	if Obj_FlagSet FLAG_CAR_SKITCH  // Don't adjust speed if skitching
	else
		KillSpawnedScript id=CarAccelSound
		GetTags
		GetRandomValue name = DecelSpeed a = (<DefaultSpeed>*0.6) b = (<DefaultSpeed>*0.7)
		Obj_SetPathVelocity <DecelSpeed> mph
		if GotParam printstruct
			printf"##### DECEL #####"
			printstruct <...>
		endif
	endif
endscript

script Car_DecelForTurn01
	if Obj_FlagSet FLAG_CAR_SKITCH  // Don't adjust speed if skitching
	else
		KillSpawnedScript id=CarAccelSound
		SetTags Tag_TurnDist = <TurnDist>
		GetTags
		GetRandomValue name = DecelSpeed a = (<DefaultSpeed>*0.6) b = (<DefaultSpeed>*0.7)
		if (<DecelSpeed> < 20)
			<DecelSpeed> = 20
		endif
		Obj_SetPathVelocity <DecelSpeed> mph
		Obj_SetPathTurnDist <Tag_TurnDist>
		Car_Sound_Decel01
		if GotParam printstruct
			printf"##### DECEL FOR TURN #####"
			printstruct <...>
		endif
	endif
endscript

script Car_DecelTrafficLight01
	// make car ignore light if the skater or another car are in the way when it gets to the light
	if Obj_ObjectNotInRect dist = 50 type = [ skater, car ]
		if QueryFlag name = <LightNode> FLAG_TRAFFICLIGHT_GREEN
			goto Car_DecelForTurn01 params = <...>
		endif
		if QueryFlag name = <LightNode> FLAG_TRAFFICLIGHT_YELLOW
			random (
				@goto Car_BlowYellow01 params = <...>
				@goto Car_BlowYellow01 params = <...>
				@goto Car_BlowYellow01 params = <...>
				@goto Car_Stop01 params = <...> )
		endif
		if QueryFlag name = <LightNode>  FLAG_TRAFFICLIGHT_RED
			goto Car_Stop01 params = <...>
		endif
	else
		;	launchconsolemessage"want to decel for light but car in the way"
	endif
endscript

script Car_DecelForOtherCar01
	KillSpawnedScript id=CarAccelSound
	Car_Decel01 <...>
	wait 120 gameframes
	Car_AccelAfterDecelForCar01 <...>
endscript

script Car_Start01
	// Wait for a bit after the light turns green as it looks more real
	wait randomrange ( 800, 1200 )
	Obj_ClearFlag FLAG_CAR_GENERIC_STOPPED
	Obj_StartAlongPath
	SpawnSound Car_Sound_Accel01 id=CarAccelSound
endscript

script Car_Stop01
	KillSpawnedScript id=CarAccelSound
	Obj_StopAlongPath randomrange ( 25, 30 ) feet
	Obj_SetFlag FLAG_CAR_GENERIC_STOPPED

	Car_Sound_Stop01
	begin
		wait 20 gameframes
		if QueryFlag name = <LightNode>  FLAG_TRAFFICLIGHT_GREEN
			Car_Start01
			break
		endif
	repeat
endscript

script Car_BlowYellow01
	GetTags
	Obj_SetPathVelocity 50 mph
	if Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND
		Obj_AdjustSound <CarLoopSFX> volumePercent = 130 volumeStep = 4 pitchPercent = 130 pitchStep = 4
		Obj_PlaySound LA_Skid_11 Vol=100
	endif
endscript

script Car_InchUpAfterStop
	if Obj_ObjectNotInRect dist = 35 width = 50 height = 40 type = [ car, skater ] offset = ( 0, 0, 0 )
		Obj_StartAlongPath
		wait 1 gameframes
		Obj_StopAlongPath 20
		if Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND
			Obj_PlaySound CarBrakeSqueal vol = 30 pitch = 80
		endif
	endif
endscript

//********** PED STUFF **********

script Ped_Generic01
	Obj_FollowPathLinked
	Obj_RandomPathMode On
	Obj_SetPathAcceleration 10
	Obj_SetPathDeceleration 10
	;if GotParam NoAvoidSkater
	;else
	;	printf"spawning avoidskater"
	;	Obj_SpawnScript Ped_CheckForAvoidSkater params = { scriptToCallWhenFinished = Ped_BackOnPath01 }
	;endif
endscript

script Ped_StopAtNode01
	Obj_SetAnimCycleMode off
	Obj_WaitAnimFinished
	Obj_PlayAnim anim = WalkToIdle
	wait 2 gameframes
	Obj_StopAlongPath
	Obj_WaitAnimFinished
endscript

script Ped_BackOnPath01
	printf"backonpath"
	Obj_StartAlongPath
	Obj_FollowPathStored
endscript

script Ped_WalkToNextNode01
	random (
		@Obj_SetPathVelocity 4
		Obj_StartAlongPath
		Obj_CycleAnim anim = IdleToWalk
		Obj_PlayAnim anim = Walk1 cycle
		@Obj_SetPathVelocity 4
		Obj_StartAlongPath
		Obj_CycleAnim anim = IdleToWalk
		Obj_PlayAnim anim = Walk2 cycle )
	;begin
	;	wait 10 gameframes
	;	if QueryFlag name = <LightNode> FLAG_TRAFFICLIGHT_GREEN
	;		Obj_CycleAnim anim = WalkToRun
	;		Obj_PlayAnim anim = Run cycle
	;		Obj_SetPathVelocity 10
	;		break
	;	endif
	;repeat
endscript

script Ped_Crosswalk01
	Ped_StopAtNode01
	;Obj_SpawnScript Ped_CheckForAvoidSkater params = { scriptToCallWhenFinished = Ped_Crosswalk01 } ID = ID_PED_CheckForAvoidSkaterCrosswalk
	begin
		// checking for yellow light becuase the ped is often in the middle
		// of an anim and does not immediately realize the state of the light
		if QueryFlag name = <LightNode> FLAG_TRAFFICLIGHT_YELLOW
			Obj_PlayAnim anim = Idle cycle
			begin
				if QueryFlag name = <LightNode> FLAG_TRAFFICLIGHT_RED
					Obj_SetAnimCycleMode off
					Obj_WaitAnimFinished
					wait randomrange ( 0, 300 )
					;Obj_KillSpawnedScript ID = ID_PED_CheckForAvoidSkaterCrosswalk
					goto Ped_WalkToNextNode01 ;params = { LightNode = <LightNode> }
				endif
				wait 30 gameframes
			repeat
		else
			Ped_Idle01
		endif
	repeat
endscript

script Ped_RandomWaitAtNode01
	Ped_StopAtNode01
	Obj_CycleAnim anim = Idle
	begin
		random (
			@Ped_Idle01
			@goto Ped_WalkToNextNode01 )
	repeat
endscript

script Ped_Idle01
	random (
		@Obj_CycleAnim anim = ScratchChin
		@Obj_CycleAnim anim = LookAtWatch
		@Obj_CycleAnim anim = LookLeftRight
		@Obj_CycleAnim anim = LookRight
		@Obj_CycleAnim anim = LookLeftDown
		@Obj_CycleAnim anim = Talk
		@Obj_CycleAnim anim = Talk2
		@Obj_CycleAnim anim = Idle
		@Obj_CycleAnim anim = Idle
		@Obj_CycleAnim anim = Idle
		@Obj_CycleAnim anim = Idle
		@Obj_CycleAnim anim = IdleToIdle2
		Obj_CycleAnim anim = Idle2
		Obj_CycleAnim anim = Idle2ToIdle
		@Obj_CycleAnim anim = IdleToIdle3
		Obj_CycleAnim anim = Idle3
		Obj_CycleAnim anim = Idle3ToIdle )
endscript

script Team_Flag
	Obj_SetInnerRadius 10
	if GameModeEquals is_lobby
		Obj_SetException ex = SkaterInRadius scr = Team_Flag_Trigger params = {<...>}
	else
		if GameModeEquals is_ctf
			if OnServer
				Obj_SetException ex = AnySkaterInRadius scr = CTF_Team_Flag_Trigger params = {<...>}
			endif
		endif
	endif

endscript

script Team_Flag_Trigger
	GetNumTeams
	if GotParam blue
		JoinTeam blue
		kill name = TRG_Flag_Red
		kill name = TRG_Flag_Green
		kill name = TRG_Flag_Yellow
		create name = TRG_Flag_Red
		switch <num_teams>
			case 3
				create name = TRG_Flag_Green
			case 4
				create name = TRG_Flag_Green
				create name = TRG_Flag_Yellow
		endswitch
		Die
	endif
	if GotParam red
		JoinTeam red
		kill name = TRG_Flag_Blue
		kill name = TRG_Flag_Green
		kill name = TRG_Flag_Yellow
		create name = TRG_Flag_Blue
		switch <num_teams>
			case 3
				create name = TRG_Flag_Green
			case 4
				create name = TRG_Flag_Green
				create name = TRG_Flag_Yellow
		endswitch
		Die
	endif
	if GotParam green
		JoinTeam green
		kill name = TRG_Flag_Blue
		kill name = TRG_Flag_Red
		kill name = TRG_Flag_Yellow
		create name = TRG_Flag_Blue
		create name = TRG_Flag_Red
		switch <num_teams>
			case 4
				create name = TRG_Flag_Yellow
		endswitch
		Die
	endif
	if GotParam yellow
		JoinTeam yellow
		kill name = TRG_Flag_Blue
		kill name = TRG_Flag_Red
		kill name = TRG_Flag_Green
		create name = TRG_Flag_Blue
		create name = TRG_Flag_Red
		create name = TRG_Flag_Green
		Die
	endif
endscript

script CTF_Team_Base_Trigger
	if GotParam red
		GetCollidingPlayerAndTeam exclude_team=0 radius=10
		if( <player> = -1 )
		else
			if( <team> = 0 )
				if PlayerHasFlag <...>
					if TeamFlagTaken <...>
						DisplayFlagBaseWarning
					endif
				endif
			endif
		endif
	endif
	if GotParam blue
		GetCollidingPlayerAndTeam exclude_team=1 radius=10
		if( <player> = -1 )
		else
			if( <team> = 1 )
				if PlayerHasFlag <...>
					if TeamFlagTaken <...>
						DisplayFlagBaseWarning
					endif
				endif
			endif
		endif
	endif
	if GotParam green
		GetCollidingPlayerAndTeam exclude_team=2 radius=10
		if( <player> = -1 )
		else
			if( <team> = 2 )
				if PlayerHasFlag <...>
					if TeamFlagTaken <...>
						DisplayFlagBaseWarning
					endif
				endif
			endif
		endif
	endif
	if GotParam yellow
		GetCollidingPlayerAndTeam exclude_team=3 radius=10
		if( <player> = -1 )
		else
			if( <team> = 3 )
				if PlayerHasFlag <...>
					if TeamFlagTaken <...>
						DisplayFlagBaseWarning
					endif
				endif
			endif
		endif
	endif
endscript

script display_flag_base_warning
	create_net_panel_message msg_time=2000 text=net_message_flag_base_warning
endscript

script CTF_Team_Flag_Trigger
	if JustStartedNetGame
		return
	endif
	if GotParam red
		GetCollidingPlayerAndTeam exclude_team=0 radius=10
		if( <player> = -1 )
		else
			if( <team> = 0 )
				PlayerCapturedFlag flag_team=0 <...>
			else
				PlayerTookFlag flag_team=0 <...>
				Obj_ClearExceptions
			endif
		endif
	endif
	if GotParam blue
		GetCollidingPlayerAndTeam exclude_team=1 radius=10
		if( <player> = -1 )
		else
			if( <team> = 1 )
				PlayerCapturedFlag flag_team=1 <...>
			else
				PlayerTookFlag flag_team=1 <...>
				Obj_ClearExceptions
			endif
		endif
	endif
	if GotParam green
		GetCollidingPlayerAndTeam exclude_team=2 radius=10
		if( <player> = -1 )
		else
			if( <team> = 2 )
				PlayerCapturedFlag flag_team=2 <...>
			else
				PlayerTookFlag flag_team=2 <...>
				Obj_ClearExceptions
			endif
		endif
	endif
	if GotParam yellow
		GetCollidingPlayerAndTeam exclude_team=3 radius=10
		if( <player> = -1 )
		else
			if( <team> = 3 )
				PlayerCapturedFlag flag_team=3 <...>
			else
				PlayerTookFlag flag_team=3 <...>
				Obj_ClearExceptions
			endif
		endif
	endif
endscript

script Kill_Team_Flags
	if NodeExists TRG_Flag_Red
		kill name = TRG_Flag_Red
	endif
	if NodeExists TRG_Flag_Blue
		kill name = TRG_Flag_Blue
	endif
	if NodeExists TRG_Flag_Green
		kill name = TRG_Flag_Green
	endif
	if NodeExists TRG_Flag_Yellow
		kill name = TRG_Flag_Yellow
	endif

	if NodeExists TRG_Flag_Red_Base
		kill name = TRG_Flag_Red_Base
	endif
	if NodeExists TRG_Flag_Blue_Base
		kill name = TRG_Flag_Blue_Base
	endif
	if NodeExists TRG_Flag_Green_Base
		kill name = TRG_Flag_Green_Base
	endif
	if NodeExists TRG_Flag_Yellow_Base
		kill name = TRG_Flag_Yellow_Base
	endif

	if NodeExists TRG_CTF_Red
		kill name = TRG_CTF_Red
	endif
	if NodeExists TRG_CTF_Red_Base
		kill name = TRG_CTF_Red_Base
	endif
	if NodeExists TRG_CTF_Blue
		kill name = TRG_CTF_Blue
	endif
	if NodeExists TRG_CTF_Blue_Base
		kill name = TRG_CTF_Blue_Base
	endif
	if NodeExists TRG_CTF_Green
		kill name = TRG_CTF_Green
	endif
	if NodeExists TRG_CTF_Green_Base
		kill name = TRG_CTF_Green_Base
	endif
	if NodeExists TRG_CTF_Yellow
		kill name = TRG_CTF_Yellow
	endif
	if NodeExists TRG_CTF_Yellow_Base
		kill name = TRG_CTF_Yellow_Base
	endif
endscript

script Create_Team_Flags
	if GameModeEquals is_lobby
		switch <num_teams>
			case 1
				if NodeExists TRG_Flag_Red
					create name = TRG_Flag_Red
				endif
				if NodeExists TRG_Flag_Red_Base
					create name = TRG_Flag_Red_Base
				endif
			case 2
				if NodeExists TRG_Flag_Red
					create name = TRG_Flag_Red
				endif
				if NodeExists TRG_Flag_Blue
					create name = TRG_Flag_Blue
				endif
				if NodeExists TRG_Flag_Red_Base
					create name = TRG_Flag_Red_Base
				endif
				if NodeExists TRG_Flag_Blue_Base
					create name = TRG_Flag_Blue_Base
				endif
			case 3
				if NodeExists TRG_Flag_Red
					create name = TRG_Flag_Red
				endif
				if NodeExists TRG_Flag_Blue
					create name = TRG_Flag_Blue
				endif
				if NodeExists TRG_Flag_Green
					create name = TRG_Flag_Green
				endif
				if NodeExists TRG_Flag_Red_Base
					create name = TRG_Flag_Red_Base
				endif
				if NodeExists TRG_Flag_Blue_Base
					create name = TRG_Flag_Blue_Base
				endif
				if NodeExists TRG_Flag_Green_Base
					create name = TRG_Flag_Green_Base
				endif
			case 4
				if NodeExists TRG_Flag_Red
					create name = TRG_Flag_Red
				endif
				if NodeExists TRG_Flag_Blue
					create name = TRG_Flag_Blue
				endif
				if NodeExists TRG_Flag_Green
					create name = TRG_Flag_Green
				endif
				if NodeExists TRG_Flag_Yellow
					create name = TRG_Flag_Yellow
				endif
				if NodeExists TRG_Flag_Red_Base
					create name = TRG_Flag_Red_Base
				endif
				if NodeExists TRG_Flag_Blue_Base
					create name = TRG_Flag_Blue_Base
				endif
				if NodeExists TRG_Flag_Green_Base
					create name = TRG_Flag_Green_Base
				endif
				if NodeExists TRG_Flag_Yellow_Base
					create name = TRG_Flag_Yellow_Base
				endif
		endswitch
	else
		GetNumPlayersOnTeam team=0
		if( <num_members> = 0 )
		else
			if NodeExists TRG_CTF_Red
				create name = TRG_CTF_Red
			endif
			if NodeExists TRG_CTF_Red_Base
				create name = TRG_CTF_Red_Base
			endif
		endif

		GetNumPlayersOnTeam team=1
		if( <num_members> = 0 )
		else
			if NodeExists TRG_CTF_Blue
				create name = TRG_CTF_Blue
			endif
			if NodeExists TRG_CTF_Blue_Base
				create name = TRG_CTF_Blue_Base
			endif
		endif

		GetNumPlayersOnTeam team=2
		if( <num_members> = 0 )
		else
			if NodeExists TRG_CTF_Green
				create name = TRG_CTF_Green
			endif
			if NodeExists TRG_CTF_Green_Base
				create name = TRG_CTF_Green_Base
			endif
		endif

		GetNumPlayersOnTeam team=3
		if( <num_members> = 0 )
		else
			if NodeExists TRG_CTF_Yellow
				create name = TRG_CTF_Yellow
			endif
			if NodeExists TRG_CTF_Yellow_Base
				create name = TRG_CTF_Yellow_Base
			endif
		endif
	endif
endscript

script Team_Flag_Base
	// Obj_SetBoundingSphere 100000
	Obj_SetInnerRadius 10
	Obj_SetException ex = SkaterInRadius scr = CTF_Team_Base_Trigger params = {<...>}
endscript

script BouncyShadow_Kill
	FormatText TextName = ShadowName "%o_shadow" o = <ObjectName>
	printf<shadowname>
	kill prefix = <ShadowName>
endscript

script Pigeon_Generic
	Obj_ShadowOff
	if GotParam perched
		Pigeon_Generic_Idle_Perched
	else
		Pigeon_Generic_Idle
	endif
endscript

script Pigeon_Generic_Idle_Perched
	Obj_ClearExceptions
	Obj_SetInnerRadius 15
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterNear_Perched
	SpawnSound NY_SFX_PigeonIdle
	begin
		Obj_CycleAnim anim  = idle NumCycles = randomrange (1, 3)
		Obj_CycleAnim anim  = preen
	repeat
endscript

script Pigeon_Generic_SkaterNear_Perched
	Obj_ClearExceptions
	SpawnSound NY_SFX_PigeonFlyUp
	Obj_CycleAnim anim  = FlyHop
	goto Pigeon_Generic_Idle_Perched
endscript

script Pigeon_Generic_Idle
	Obj_ClearExceptions
	Obj_SetInnerRadius 15
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterNear
	SpawnSound NY_SFX_PigeonIdle
	begin
		Obj_CycleAnim anim  = idle NumCycles = randomrange (1, 3)
		Obj_CycleAnim anim  = peckfromidle
		begin
			Obj_RotY speed = 25
			Obj_CycleAnim anim  = peck
			Obj_StopRotating
		repeat NumCycles randomrange (1, 5)
		Obj_CycleAnim anim  = pecktoidle
		Obj_CycleAnim anim  = idle
		Obj_CycleAnim anim  = preen
	repeat
endscript

script Pigeon_Generic_SkaterNear
	Obj_ClearExceptions
	Obj_GetRandomLink
	Obj_MoveToLink speed = 8 LinkNum = <link>
	Obj_LookAtNodeLinked time = .2 LinkNum = <link>
	Obj_SetInnerRadius 5
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterReallyNear
	Obj_PlayAnim anim  = run cycle
	Obj_WaitMove
	Obj_SetAnimCycleMode Off
	Obj_WaitAnimFinished
	Obj_CycleAnim anim  = runtoidle
	Obj_SetInnerRadius 15
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterNear
	goto Pigeon_Generic_Idle
endscript

script Pigeon_Generic_SkaterReallyNear
	Obj_ClearExceptions
	SpawnSound NY_SFX_PigeonFlyUp
	Obj_CycleAnim anim  = FlyHop
	Obj_WaitMove
	Obj_SetInnerRadius 15
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterNear
	goto Pigeon_Generic_Idle
endscript

script COMBO_Letter
endscript

script SKATE_Letter
endscript

script Gap_Gen_Rail2Rail
	Gap_Gen_RailHop <...>
endscript

script Gap_Gen_Ledge2Ledge
	Gap_Gen_LedgeHop <...>
endscript

script Gap_Gen_Wire2Wire
	Gap_Gen_WireHop <...>
endscript

script Gap_Gen_Bench2Bench
	Gap_Gen_BenchHop <...>
endscript

script Gap_Gen_Rail2Ledge
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Rail 2 Ledge" score = 50 <...>
	endif
endscript

script Gap_Gen_Rail2Wire
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Rail 2 Wire" score = 50 <...>
	endif
endscript

script Gap_Gen_Rail2Bench
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Rail 2 Bench" score = 50 <...>
	endif
endscript

script Gap_Gen_Ledge2Rail
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Ledge 2 Rail" score = 50 <...>
	endif
endscript

script Gap_Gen_Ledge2Wire
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Ledge 2 Wire" score = 50 <...>
	endif
endscript

script Gap_Gen_Ledge2Bench
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Ledge 2 Bench" score = 50 <...>
	endif
endscript

script Gap_Gen_Wire2Rail
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Wire 2 Rail" score = 50 <...>
	endif
endscript

script Gap_Gen_Wire2Ledge
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Wire 2 Ledge" score = 50 <...>
	endif
endscript

script Gap_Gen_Bench2Rail
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Bench 2 Rail" score = 50 <...>
	endif
endscript

script Gap_Gen_Bench2Ledge
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Bench 2 Ledge" score = 50 <...>
	endif
endscript

script Gap_Gen_WireHop
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Wire hop" score = 25 <...>
	endif
endscript

script Gap_Gen_BenchHop
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Bench hop" score = 25 <...>
	endif
endscript

script Gap_Gen_RailHop
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Rail hop" score = 25 <...>
	endif
endscript

script Gap_Gen_LedgeHop
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Ledge hop" score = 25 <...>
	endif
endscript

script Gap_Gen_AcrossTheStreet
	if GotParam Start
		Gap_Gen_Rail <...>
	else
		Gap_Gen_End GapID = <GapID> text = "Across the street" score = 50 <...>
	endif
endscript

script Gap_Gen_HighLip
	if GotParam Start
		StartGap {
			GapID = <GapID>
			flags = [REQUIRE_LIP CANCEL_GROUND CANCEL_WALL CANCEL_MANUAL CANCEL_RAIL CANCEL_WALLPLANT CANCEL_HANG CANCEL_LADDER]
			<...> }
	else
		wait 1 frame
		Gap_Gen_End GapID = <GapID> text = "High lip" score = 100 <...>
	endif
endscript

script Gap_Gen_RampTransfer
	if GotParam Start
		StartGap {
			GapID = <GapID>
			flags = PURE_AIR
			<...> }
	else
		Gap_Gen_End GapID = <GapID> text = "Ramp Transfer" score = 100 <...>
	endif
endscript

script Gap_Gen_Rail
	if GotParam Start
		StartGap {
			GapID = <GapID>
			flags = [CANCEL_GROUND CANCEL_MANUAL CANCEL_WALL CANCEL_RAIL CANCEL_LIP CANCEL_WALLPLANT CANCEL_HANG CANCEL_LADDER]
			<...> }
	else
		if GotParam End
			Gap_Gen_End GapID = <GapID> text = <text> score = <score> <...>
		else
			printf"### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID>
		endif
	endif
endscript

script Gap_Gen_Lip
	if GotParam Start
		StartGap {
			GapID = <GapID>
			flags = [REQUIRE_LIP CANCEL_GROUND CANCEL_WALL CANCEL_MANUAL CANCEL_RAIL CANCEL_WALLPLANT CANCEL_HANG CANCEL_LADDER]
			<...> }
	else
		if GotParam End
			wait 1 frame
			EndGap {
				GapID = <GapID>
				text = <text>
				score = <score> }
			//gapscript = Gap_Gen_Print }
		else
			printf"### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID>
		endif
	endif
endscript

script Gap_Gen_Transfer
	if GotParam Start
		StartGap {
			GapID = <GapID>
			flags = PURE_AIR
			<...> }
	else
		if GotParam End
			Gap_Gen_End GapID = <GapID> text = <text> score = <score> <...>
		else
			printf"### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID>
		endif
	endif
endscript

script Gap_Gen_PureAir
	if GotParam Start
		StartGap {
			GapID = <GapID>
			flags = PURE_AIR
			<...> }
	else
		if GotParam End
			Gap_Gen_End GapID = <GapID> text = <text> score = <score> <...>
		else
			printf"### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID>
		endif
	endif
endscript

script Gap_Gen_Manual
	if GotParam Start
		StartGap {
			GapID = <GapID>
			flags = PURE_MANUAL
			<...> }
	else
		if GotParam End
			Gap_Gen_End GapID = <GapID> text = <text> score = <score> <...>
		else
			printf"### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID>
		endif
	endif
endscript

script Gap_Gen_End
	if GotParam End
		EndGap {
			GapID = <GapID>
			text = <text>
			score = <score>
			<...> }
		//gapscript = Gap_Gen_Print }
	else
		printf"### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID>
	endif
endscript

script Gap_Gen_Print
	printf"fuck = %g" g = <GapID>
endscript

script Collect_Hover
	Obj_RotY speed=150
	Obj_Hover Amp=10 Freq=1
endscript

Script SK5_WinCurrentGoal
	SpawnScript SK5_WinCurrentGoal_Spawned
endscript

Script SK5_WinCurrentGoal_Spawned
	if GoalManager_GetActiveGoalId
		//exit_pause_menu
		GoalManager_WinGoal name=<goal_id>
	endif
Endscript

Script SK5_LoseCurrentGoal
	SpawnScript SK5_LoseCurrentGoal_Spawned
Endscript

Script SK5_LoseCurrentGoal_Spawned
	if GoalManager_GetActiveGoalId
		//exit_pause_menu
		GoalManager_LoseGoal name=<goal_id>
	endif
Endscript

Script SK5_AdvanceStage
	GoalManager_DeactivateAllGoals
	GoalManager_GetCurrentChapterAndStage
	GoalManager_AdvanceStage force
	<stage_struct> = ( ( CHAPTER_COMPLETION_SCRIPTS[<currentChapter>] )[<currentStage>] )
	if StructureContains structure=<stage_struct> script_name
		<stage_script> = ( <stage_struct>.script_name )
	endif
	if StructureContains structure=<stage_struct> params
		<stage_script_params> = ( <stage_struct>.params )
	endif
	<stage_script> <stage_script_params> just_won_goal
Endscript

Script SK5_AdvanceStage_Debug
	GoalManager_DeactivateAllGoals
	GoalManager_GetCurrentChapterAndStage
	GoalManager_AdvanceStage force
	<stage_struct> = ( ( CHAPTER_COMPLETION_SCRIPTS[<currentChapter>] )[<currentStage>] )
	if StructureContains structure=<stage_struct> script_name
		<stage_script> = ( <stage_struct>.script_name )
	endif
	if StructureContains structure=<stage_struct> params
		<stage_script_params> = ( <stage_struct>.params )
	endif
	<stage_script> <stage_script_params>
Endscript

// start autoduck documentation
// @DOC ShatterAndDie
// @module ShatterAndDie | None
// @subindex Scripting Database
// @index script | ShatterAndDie

// @script | ShatterAndDie | use to shatter an geometry into pieces and kill the geometry as well
// @parmopt name | name |  | name of the geometry to shatter and kill
// @parmopt int | area | 1000 | How the object is to be divided up - uses the object face area divided by this number to get the # of pieces
// @parmopt float | variance | 4 | hmmm...
// @parmopt float | vel_x | 30 | Initial X direction velocity
// @parmopt float | vel_y | 30 | Initial Y direction velocity
// @parmopt float | vel_z | 30 | Initial Z direction velocity
// @parmopt float | spread | 1 | uh...

Script ShatterAndDie area = 1000 variance = 4.6 vel_x = Random (@0.0 @30 @-30) vel_y = Random (@10 @30 @50)  vel_z = Random (@0 @30 @-30) spread = 1.0
	kill name=<name>
	Shatter name=<name> area=<area> variance=<variance> vel_x=<vel_x> vel_y=<vel_y> vel_z=<vel_z> spread=<spread>
Endscript

Script Generic_LeavingGameAreaMessage
	if Not InSplitScreenGame
		create_panel_message id=leaving_message text="Leaving Game Area"
	endif
Endscript

script WAT_Grid u = 0 framerate = 8 grid_size = 4
	grid_size = ( <grid_size> + 0.0 )
	offset = ( 1.0 / <grid_size> )
	max_offset = ( 1 - <offset> )
	v = <max_offset>
	if GotParam RandomOffset
		range_cap = ( <grid_size> - 1 )
		CastToInteger range_cap
		GetRandomValue name = random_offset a = 0 b = <range_cap> integer
		u = ( <offset> * <random_offset> )
		GetRandomValue name = random_offset a = 0 b = <range_cap> integer
		v = ( <offset> * <random_offset> )
	endif
	begin
		SetUVWibbleOffsets 	sector = <object> u_off = <u>, v_off = <v>
		if NOT ( <v> = 0 )
			v = ( <v> - <offset> )
		else
			v = <max_offset>
			u = ( <u> + <offset> )
			if ( <u> = 1 )
				u = 0
			endif
		endif
		wait <framerate> frames
	repeat
endscript

Script SetupProTeam
	GoalManager_SetTeamMember pro=lasek
	GoalManager_SetTeamMember pro=hawk
	GoalManager_SetTeamMember pro=mullen
	GoalManager_SetTeamMember pro=margera
	GoalManager_SetTeamMember pro=reynolds
Endscript

script CarTOD_TurnOffHeadlights
	printf"### turning off headlights"
	RunScriptOnComponentType component=model target=Obj_ReplaceTexture params = {
		src="JKU_LightCircle_Transparent.png" dest="textures/cars/JKU_LightCircle_Transparent"
	}
	RunScriptOnComponentType component=model target=Obj_ReplaceTexture params = {
		src="JKU_HeadlightGlow_Transparent.png" dest="textures/cars/JKU_HeadlightGlow_Transparent"
	}
endscript

script CarTOD_TurnOnHeadlights
	printf"### turning on headlights"
	RunScriptOnComponentType component=model target=Obj_ReplaceTexture params = {
		src="JKU_LightCircle_Transparent.png" dest="textures/cars/JKU_LightCircle"
	}
	RunScriptOnComponentType component=model target=Obj_ReplaceTexture params = {
		src="JKU_HeadlightGlow_Transparent.png" dest="textures/cars/JKU_HeadlightGlow"
	}
endscript

Script PlayKISS_Movie
	SetGlobalFlag flag=MOVIE_UNLOCKED_KISS
	wait 100 frames
	PauseSkaters
	PlaySkaterCamAnim skater=0 {virtual_cam
		targetid=world
		targetOffset=(9207.8, 252.1, 192.3)
		positionOffset=(-789.7, 450.3, 92.9)
		frames=1200
		skippable=0
		play_hold
	}
	create_dialog_box { title="CONGRATULATIONS!"
		title_font=testtitle
		text="   KISS movie Unlocked!  Collect K-I-S-S again and they'll put on a show for you!"

		pos=(320 ,240)
		just=[center center]
		text_rgba=[88 105 112 128]
		text_dims=(330,0)
		line_spacing=.85
		buttons=[ { font=small text="OK" pad_choose_script=KissMovie_unlock_accept } ]
		delay_input
		pad_focus_script=text_twitch_effect
		style=special_dialog_style
	}

	WaitForEvent type=KissMovie_unlock_accept_done
	ingame_play_movie "movies\kiss" level=load_se
endscript


