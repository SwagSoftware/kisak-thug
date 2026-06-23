// start autoduck documentation
// @DOC skater_misc
// @module skater_misc | None
// @subindex Scripting Database
// @index script | skater_misc

script TurnBackAround movetonode=TRG_TurnAround01 text="Whooah, easy bub. You don't have enough goal points to go to the next level. Beat some more goals, then come see me again."
	if InNetGame
		<text>="Sorry bub, taxi's busted. \n Don't you have a game to play anyway?"
	endif
	if isTrue Bootstrap_Build
		<text>="Sorry, the taxi's out of service for the demo. Maybe if you buy the real game, I can afford to get it fixed."
	endif
	// End any skitching
	StopSkitch

	MakeSkaterGoto EndOfRun Params={FromTaxiGuy}
	pause_trick_text
	pause_balance_meter
	if not InNetGame
		GoalManager_PauseAllGoals
	endif
	create_speech_box 	{ pos=(320, 300)
		text=<text>
		pad_choose_script=TurnBackAround_Finish
	}
endscript


script TurnBackAround_Finish
	unpause_trick_text
	unpause_balance_meter
	if not InNetGame
		GoalManager_UnPauseAllGoals
	endif
	Skater:SK3_Killskater nodename=TRG_TurnAround01 nomessage
endscript





// @script | GetSkaterState | Reports what the skater is doing by returning a state parameter, that will be equal to one of the following:
// skater_InAir
// skater_OnGround
// skater_InGrab
// skater_InFlip
// skater_InManual
// skater_OnRail
// skater_InBail
// Use like this:
//     GetSkaterState
//     if (state=skater_InAir)
//			printf "We're in the air...........!"
//		endif

script GetSkaterState
	skater:GetTags
	return state=<state>
endscript






// OLD HACKY CRAP RETIRED FROM THE GAME HA HA HA
/*

script TurnBackAround3
	speech_box_exit
	MakeSkaterGoto TurnBackAround4
endscript

script TurnBackAround4
	ClearExceptions
	DisablePlayerInput
	SetSpeed 0
	CanKickOff
	Rotate Duration=.8 second node=TRG_TurnAround01
	if flipped
		PlayAnim Anim=TurnRightIdle
	else
		PlayAnim Anim=TurnLeftIdle
	endif
	wait .8 second

	PlayAnim Anim=PushCycle cycle

	SetRollingFriction default
	ForceAutokickOn
	CanKickOn
	stuckcounter=0
	begin
		Rotate Duration=.1 second node=TRG_TurnAround01
		Obj_GetDistToNode TRG_TurnAround01
//		printf "dist=%f" f=<dist>
		if ( <dist> < 50 )
			break
		endif
		if ( <dist> > 2000 )
			speech_box_exit
			printf "distance greater than 1000"
			break
		endif
		// make sure that we don't get stuck in this loop too long, as that would be annoying
		// if we get stuck, just jump the skater and he should get unstuck
		stuckcounter=(<stuckcounter> + 1)
//		printf "stuckcounter=%s" s=<stuckcounter>
		if (<stuckcounter> > 200)
			jump
			PlayAnim Anim=Ollie
			//Rotate y=30 Duration=.1
			stuckcounter=100
			break
		endif
		wait 1 gameframe
	repeat

	RestoreAutokick
	EnablePlayerInput
	unpause_trick_text
	unpause_balance_meter
	GoalManager_UnPauseAllGoals
//	ClearSkaterCamOverride
	MakeSkaterGoto OnGroundAi
endscript
*/

