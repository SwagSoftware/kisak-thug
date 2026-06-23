minigame_trickspot_genericParams = {
	init = minigame_trickspot_init
	; activate = minigame_fountain_activate
	; deactivate = minigame_bet_deactivate

	number_collected = 1
	minigame_record = 0

	trigger_obj_id = TRG_MG_RoundCounter02

	no_restart		// so goal manager doesn't look for a restart node
	minigame		// necessary flag


	betting_game
	trickspot
	betting_guy_node = TRG_MG_BettingNav01
	location = "the stairs"
	bet_easy = {
		key_combos = [
			Air_SquareU
			Air_SquareD
			Air_SquareL
			Air_SquareR
		]

		bet_amount=100
		tries=5
	}
	bet_medium = {
		key_combos = [
			Air_SquareUL
			Air_SquareUR
			Air_SquareDL
			Air_SquareDR
		]

		bet_amount=250
		tries=3
	}
	bet_hard = {
		key_combos = [
			Air_CircleUL
			Air_CircleUR
			Air_CircleDL
			Air_CircleDR
			Air_CircleU
			Air_CircleD
			Air_CircleL
			Air_CircleR
		]
		bet_amount=1000
		tries=2
	}
}

script minigame_trickspot_init
	// whatever
endscript


Script MG_Bet_InsideArea
	if GoalManager_BetIsActive name=sch_goal_minigame_trickspot
		GoalManager_StartBetAttempt name=sch_goal_minigame_trickspot
		GoalManager_GetGoalParams name=sch_goal_betting_guy
		StartGap GapID=StairMinigame flags=[cancel_ground] TrickText=<bet_action> trickscript = sch_goal_minigame_trickspot_got
	endif
	;printf "entering bet area"
	;if NOT OnGround //InAir
	;SendFlag prefix="TRG_MG_BettingGuy" OBJ_FLAG_BETSTART
	;endif
Endscript

Script MG_Bet_OutsideArea
	EndGap GapId=StairMinigame
	// don't end the attempt until they land or bail
	// printf "MG_Bet_OutsideArea"
	if GoalManager_BetIsActive name=sch_goal_minigame_trickspot
		RunScriptOnObject id=TRG_MG_BettingGuy01 betting_guy_wait_for_land params={ goal_id=sch_goal_minigame_trickspot }
	endif
	// GoalManager_EndBetAttempt name=sch_goal_minigame_trickspot
	;printf "leaving bet area"
	;SendFlag prefix="TRG_MG_BettingGuy" OBJ_FLAG_BETEND
Endscript

script sch_goal_minigame_trickspot_got
	printf "you got it"
	GoalManager_WinGoal name=sch_goal_betting_guy
endscript

// ****************************************************************
//						old shit
// ****************************************************************
// ----------------------setting up parameters----------------------

OBJ_FLAG_BETSTART = 0
OBJ_FLAG_BETEND = 1
OBJ_FLAG_BETWON = 2

DefaultBettingParams = {
	Bet_Clusters = [ { id=Sch_KillSpot01 flag=got_1}
		{ id=Sch_KillSpot02 flag=got_2}
	]
	BetAmount = 50
	TrickName = "kickflip"
	TOName = "the stairs behind me"
	NumTries = 3
}

// ----------------------scripts----------------------

Script MG_Betting_Guy DefaultBettingParams
	Obj_ClearExceptions
	Obj_SetException ex = SkaterInRadius scr = MG_Betting_Guy_Skater_Far params={<...>}
	Obj_SetInnerRadius 100
Endscript

Script MG_Betting_Guy_Skater_Far
	Obj_ClearExceptions
	Obj_SetException ex = SkaterInRadius scr = MG_Betting_Guy_CheckForBet params={<...>}
	Obj_SetInnerRadius 10
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_GotoNextLocation params={<...>}
	Obj_SetOuterRadius 950
Endscript

Script MG_Betting_Guy_CheckForBet
	Obj_ClearExceptions
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_Skater_Far params={<...>}
	Obj_SetOuterRadius 10
	Playstream RandomNoRepeat (@Andrew_Near01 @Andrew_Near02 @Andrew_Near03 @Andrew_Near04 @Andrew_NearTony01)
	begin
		if SkaterSpeedLessThan 1
			GotoPreserveParams MG_Betting_Guy_BetSkater
		endif
		wait 1 frame
	repeat
Endscript

Script MG_Betting_Guy_GotoNextLocation
	//SendFlag name=TRG_MG_BettingGuy OBJFLAG_BETTER_GONE
	Die
Endscript

Script MG_Betting_Guy_BetSkater
	Obj_ClearFlag OBJ_FLAG_BETSTART
	Obj_ClearFlag OBJ_FLAG_BETEND
	Obj_ClearFlag OBJ_FLAG_BETWON
	Obj_ClearExceptions
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_Skater_Far params={<...>}
	Obj_SetOuterRadius 15
	GetNodeName
	wait 1 frame
	MakeSkaterGoto MG_Betting_Sakter_AI params={ BettingGuyNode=<nodename>}
	FormatText TextName=b_d1 "%a dollars says you can't %b" a=<BetAmount> b=<TrickName>
	FormatText TextName=b_d2 "%z %c in %d tries!" c=<TOName> d=<NumTries> z=<b_d1>
	FormatText TextName=bet_description "%y\n----------\n Press Square to Decline\nor\nPress Circle to Accept" y=<b_d2>
	create_speech_box text=<bet_description> style=speech_box_style
	begin
		if Obj_FlagSet OBJ_FLAG_BETSTART
			Obj_ClearFlag OBJ_FLAG_BETSTART
			GotoPreserveParams MG_Betting_Guy_CheckingForTrick
		Endif
		if Obj_FlagSet OBJ_FLAG_BETEND
			Obj_ClearFlag OBJ_FLAG_BETEND
			Break
		Endif
		wait 1 frame
	repeat
	GotoPreserveParams MG_Betting_Guy_Skater_Far
	//GotoPreserveParams MG_Betting_Guy_IgnoreSkater
	//die
Endscript

Script MG_Betting_Guy_CheckingForTrick
	Playstream RandomNoRepeat (@Andrew_Support01 @Andrew_Support02)
	Obj_ClearExceptions
	create prefix="TRGP_MG_Bet01"
	wait 1 frame
	Obj_ClearFlag OBJ_FLAG_BETSTART
	begin
		printf "checking area entrance"
		begin
			if Obj_FlagSet OBJ_FLAG_BETSTART
				Obj_ClearFlag OBJ_FLAG_BETSTART
				Break
			Endif
			if SkaterCurrentScorePotGreaterThan 0
				break
			endif
			wait 1 frame
		repeat
		printf "checking trickstring"
		Obj_ClearFlag OBJ_FLAG_BETEND
		SpawnSkaterScript SkaterStartBetGap params={ TrickToDo=<TrickName>}
		begin
			wait 1 frame
			if Obj_FlagSet OBJ_FLAG_BETEND
				Obj_ClearFlag OBJ_FLAG_BETEND
				Break
			Endif
		repeat
		printf "out of area"
		//if NOT SkaterCurrentScorePotGreaterThan 0
		//<NumTries>=(<NumTries>+1)
		//Else
		SpawnSkaterScript SkaterEndBetGap params={ TrickToDo=<TrickName>}
		wait 2 frames
		begin
			if NOT SkaterCurrentScorePotGreaterThan 0
				break
			endif
			wait 10 frame
		repeat
		if Obj_FlagSet OBJ_FLAG_BETWON
			GotoPreserveParams MG_Betting_Guy_PaySkater
		Endif
		RandomNoRepeat (
			@create_speech_box text="Not Quite..." style=speech_box_style
			@create_speech_box text="Not even!" style=speech_box_style
			@create_speech_box text="Try again..." style=speech_box_style
			@create_speech_box text="Not Even Close!" style=speech_box_style
		)
		//Endif
	repeat <NumTries>
	printf "out of tries"
	Obj_ClearFlag OBJ_FLAG_BETSTART
	Obj_ClearFlag OBJ_FLAG_BETEND
	GotoPreserveParams MG_Betting_Guy_Skater_Far
Endscript

Script MG_Betting_Guy_IgnoreSkater
	Obj_ClearExceptions
	Obj_SetException ex = SkaterInRadius scr = MG_Betting_Guy_IgnoreSkaterNear params={<...>}
	Obj_SetInnerRadius 10
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_GotoNextLocation params={<...>}
	Obj_SetOuterRadius 250
Endscript

Script MG_Betting_Guy_IgnoreSkaterNear
	Obj_ClearExceptions
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_IgnoreSkater params={<...>}
	Obj_SetOuterRadius 50
	RandomNoRepeat (
		@create_speech_box text="Whatever, Dude..." style=speech_box_style
		@create_speech_box text="Wimp..." style=speech_box_style
		@create_speech_box text="Go fuck yourself..." style=speech_box_style
		@create_speech_box text="Fuck off..." style=speech_box_style
	)
Endscript

Script MG_Betting_Guy_PaySkater
	begin
		Playsound hud_jumpgap
		wait 10 frames
	repeat 10
	Playstream RandomNoRepeat (@Andrew_Success03 @Andrew_Success06 @Andrew_Success07)
	PlaySound cash Vol=130
	GoalManager_AddCash <BetAmount>
	//GoalManager_AddCash 1
	GotoPreserveParams MG_Betting_Guy_Skater_Far
Endscript

Script MG_Betting_Sakter_AI BettingGuyNode=TRG_MB_BettingGuy01
	ClearTrickQueue
	ClearEventBuffer
	SetRollingFriction 1000
	//Obj_MoveToNode Name=TRG_SkaterWait01 orient
	DisablePlayerInput
	wait 10 frames
	begin
		If Held Circle
			SendFlag Name = <BettingGuyNode> OBJ_FLAG_BETSTART
			break
		endif
		If Held Square
			SendFlag Name = <BettingGuyNode> OBJ_FLAG_BETEND
			break
		endif
		wait 1 frame
	repeat
	wait 10 frames
	speech_box_exit
	SetRollingFriction 1
	Enableplayerinput
	MakeSkaterGoto OnGroundAi
endscript

Script MG_BetGotGap
	RandomNoRepeat (
		@create_speech_box text="Way to go..." style=speech_box_style
		@create_speech_box text="You did it!" style=speech_box_style
	)
	SendFlag prefix="TRG_MG_BettingGuy" OBJ_FLAG_BETWON
Endscript

Script SkaterStartBetGap
	printf <TrickToDo>
	StartGap GapID=BetGap flags=[cancel_ground] TrickText=<TrickToDo> trickscript = MG_BetGotGap
	//StartGap GapID=BetGap flags=[cancel_ground] trickscript = MG_BetGotGap
Endscript
Script SkaterEndBetGap
	EndGap GapId=BetGap text="Bet Gap" score=50
Endscript


