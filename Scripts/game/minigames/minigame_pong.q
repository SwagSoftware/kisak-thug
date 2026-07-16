/*


OBJFLAG_FIRSTMOVE = 31
script Pong_OnGround boundscheck=0
	PlaySkaterCamAnim name=MG_Pong play_hold allow_pause=1
    kill name=TRG_Ped_Playa05
    kill name=TRG_Ped_Playa06
    kill name=TRG_AI_TennisBall
//    SwitchOffBoard
	Obj_VarSet var=0 value=4
	SetRollingFriction 1000
	printf "blah blah blah"
	Skiptrack
	If Flipped
		Flip
	endif	
    if NOT IsAlive name=TRG_MG_TP_AnimControl
        create name=TRG_MG_TP_AnimControl
    Endif
    Obj_SetFlag OBJFLAG_BBALL_IDLE
	ClearExceptions
//    SpawnSkaterScript MG_TP_Anims id=MG_TP_Spawnscript
	// Make sure the skater isn't in some weird state
	SkaterInit ReturnControl
	DisablePlayerInput
	Obj_MoveToNode Name = TRG_MG_PongNav01 orient
    wait 1 frame
	create name=TRG_Ped_TennisPlayer
//    create name=MG_TP_Box
    SendFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_IDLE
    create_speech_box {
		text=[
			"Tennis:\n"
			"Use \b6 and \b5\nto move left and right\n"
			"Use \b3 to Serve / Swing\n"
			"Use \b6 and \b5 while swinging to aim the ball\n"
			"The closer you are to the ball when you press \b3, the faster the return."
//			"Press \m1 to Quit\n"
			]
		style=speech_box_style
		pad_square_script=speech_box_exit
		pad_square_script=speech_box_exit
	}
	create_panel_block id=current_goal text="\n\n\nPress \m1 to Quit" style=panel_message_goal
	Goto Pong_Playing
endscript	

script Pong_Playing boundscheck=0
// The "main loop" for the skater while he is playing Tennis
// we just go around and around and play anims, and move the skater about
PlayAnim Anim=Ped_TP_SkaterIdle Cycle 
boundscheck=0
begin
    wait 30 frames
    Begin
//        printf "bounding value=%b" b=<boundscheck>
        //running shoot
		If AnimEquals Ped_TP_SkaterRunningHit
			if IsAlive name=TRG_MG_TP_AnimControl
				if QueryFlag OBJFLAG_TENNIS_FLIPPED name=TRG_MG_TP_AnimControl
					if Held Left
						if not (<boundscheck> > 40)
							Move x=3
							boundscheck=(<boundscheck>+1)	  
						endif	
					endif	
					else
					if Held Right
						if not (<boundscheck> < -40)
							Move x=-3
							boundscheck=(<boundscheck>-1)	  
						endif	
					endif
				endif
			endif
		endif
		if Held Left
            // we just track some simple variables to keep you "contained"
			// if you get at the outer edges - no more moving
			if IsAlive name=TRG_MG_TP_AnimControl
				if NOT QueryFlag OBJFLAG_BBALL_SHOOTING name=TRG_MG_TP_AnimControl
					if not (<boundscheck> > 40)
						Move x=3
						boundscheck=(<boundscheck>+1)	  
					endif	
					if IsAlive name=TRG_MG_TP_AnimControl
						SendFlag name=TRG_MG_TP_AnimControl OBJFLAG_TENNIS_FLIPPED
						SendFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_MOVING		
					endif
					PlayLeftRightTennisAnim	left
				endif
			endif
		else	
			if Held Right
//				printf "going right"
				if IsAlive name=TRG_MG_TP_AnimControl
					if NOT QueryFlag OBJFLAG_BBALL_SHOOTING name=TRG_MG_TP_AnimControl
						if not (<boundscheck> < -40)
							Move x=-3
							boundscheck=(<boundscheck>-1)	  
						endif
						if IsAlive name=TRG_MG_TP_AnimControl
							ClearFlag name=TRG_MG_TP_AnimControl OBJFLAG_TENNIS_FLIPPED
							SendFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_MOVING			
						endif
					PlayLeftRightTennisAnim right
					endif
				endif
			else
				// We're not holding left or right
				// But we're hitting, so wait until that anim is done, and then go back to idle
				if AnimEquals [Ped_TP_StandingHit Ped_TP_RunStopHit Ped_TP_SkaterRunningHit]	
					If Animfinished	[Ped_TP_StandingHit Ped_TP_RunStopHit Ped_TP_SkaterRunningHit] 
						PlayAnim Anim=Ped_TP_SkaterIdle Cycle Norestart
					endif	 				   
				else	
						PlayAnim Anim=Ped_TP_SkaterIdle Cycle Norestart Blendperiod=.3
				endif
			Endif
		endif	
        if IsXbox      
			if Held Circle
				SpawnScript SCH_MG_EndGame
				Break
			Endif
		else	// GameCube or PS2 version
			if IsNGC
				if Held Square
					SpawnScript SCH_MG_EndGame
					Break
				Endif
			else	// PS2 version
				if Held triangle
					SpawnScript SCH_MG_EndGame
					Break
				Endif
			endif	
		endif	
        if Held X
            if IsAlive name=TRG_MG_TennisBall
				if NOT QueryFlag OBJFLAG_BBALL_SHOOTING name=TRG_MG_TP_AnimControl
					SendFlag name=TRG_MG_TennisBall OBJFLAG_TENNIS_SWING
				Endif
            Else
                wait 30 frames
                boundscheck=0
				Create name=TRG_MG_TennisBall
            Endif
        Endif
        wait 1 frame
    Repeat
    Obj_WaitAnimFinished
Repeat
endscript

// A script used by the left and right movement to both flip the skater
// and play the correct anims
script PlayLeftRightTennisAnim
	if GotParam Left
		If Not Flipped
			Flip
		endif
	else
		if GotParam right
			if flipped
				flip
			endif	
		endif
	endif			
	If AnimEquals Ped_TP_SkaterIdle
		PlayAnim Anim=Ped_TP_RunFromIdle NoRestart speed=2
	endif
	If AnimEquals Ped_TP_RunFromIdle	
		If AnimFinished Ped_TP_RunFromIdle
			PlayAnim Anim=Ped_TP_SkaterRun Cycle NoRestart
		endif
	endif
	
	if AnimEquals [Ped_TP_RunStopHit Ped_TP_StandingHit ]
		if AnimFinished [Ped_TP_RunStopHit Ped_TP_StandingHit]					
			PlayAnim Anim=Ped_TP_RunFromIdle NoRestart speed=1
		endif
	endif
	if AnimEquals Ped_TP_SkaterRunningHit
		If AnimFinished Ped_TP_SkaterRunningHit
			PlayAnim Anim=Ped_TP_SkaterRun Cycle NoRestart
		endif
	endif	
endscript

script AnimEqualAndDonePlay 
	If AnimEquals <anim>
		If AnimFinished <anim>
			if GotParam anim2
				PlayAnim Anim=<anim2> <...>
			endif
		endif
	endif
endscript		

 
Script MG_TP_PlayerServe
wait 15 frames
PlayAnim Anim=Ped_TP_StandingHit speed=1
Endscript	

// On a serve, reset the player, move him to center, and then
// play the serve animation
Script MG_ResetPlayer
	if NOT TRG_MG_TP_AnimControl: Obj_FlagSet OBJFLAG_FIRSTMOVE
		TRG_MG_TP_AnimControl: Obj_SetFlag OBJFLAG_FIRSTMOVE
	else
		pulse_blur start =255 speed = 10
	endif
	Obj_MoveToNode name=TRG_MG_PongNav01 orient
	PlayAnim Anim=Ped_TP_SkaterServe speed=1.5
	WaitAnimFinished
	Goto Pong_Playing
Endscript

Script MG_TennisBall
	// Move the tennis ball offscreen so it's hidden 
	Obj_MoveToNode name=TRG_MG_Bball_GameBall
	// Get the skater into position and start his anims
	MakeSkaterGoto MG_ResetPlayer
	// Then wait until the service moment, and then let the ball rip
	Wait .86 seconds
	PlaySound sch_tennis_11
	//Obj_RotX speed=430
	Obj_MoveToNode name=TRG_MG_PongNav01
	if IsAlive name=TRG_Ped_TennisPlayer
	Random (
	@Obj_MoveToNode name=TRG_MG_TennisBallNavBall01 time=1.5
	SendFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_NAV1
	@Obj_MoveToNode name=TRG_MG_TennisBallNavBall02 time=1.5
	SendFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_NAV2
	@Obj_MoveToNode name=TRG_MG_TennisBallNavBall03 time=1.5
	SendFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_NAV3
	)
	endif
	Obj_Jump gravity=-420 speed=200
	Obj_WaitJumpFinished
	Obj_PlaySound random (@tennisballbounce_11 @tennisballbounce2_11) pitch = 100 vol=50
	Obj_Jump gravity=-420 speed=150
Endscript

Script MG_TennisBallHitBack
//Obj_WaitMove
//Obj_SetException ex = SkaterInRadius scr = MG_TennisBallHit
//Obj_SetInnerRadius 5
printf " hiback sound"
//PlaySound sch_tennis_11 pitch = Random (@95 @100 @105)
Random (
@Obj_MoveToNode name=TRG_MG_TennisBallNavFriendly01 time=(randomrange (9,11)/10.0)
@Obj_MoveToNode name=TRG_MG_TennisBallNavFriendly01 time=(randomrange (9,11)/10.0)
@Obj_MoveToNode name=TRG_MG_TennisBallNavFriendly02 time=(randomrange (9,12)/10.0)
@Obj_MoveToNode name=TRG_MG_TennisBallNavFriendly03 time=(randomrange (9,14)/10.0)
@Obj_MoveToNode name=TRG_MG_TennisBallNavFriendly04 time=(randomrange (9,14)/10.0)
@Obj_MoveToNode name=TRG_MG_TennisBallNavFriendly05 time=(randomrange (9,12)/10.0)
@Obj_MoveToNode name=TRG_MG_TennisBallNavFriendly06 time=(randomrange (9,11)/10.0)
@Obj_MoveToNode name=TRG_MG_TennisBallNavFriendly06 time=(randomrange (9,11)/10.0)
)
//Obj_Jump gravity=-420 speed=200
//Obj_WaitJumpFinished
//Obj_PlaySound random (@tennisballbounce_11 @tennisballbounce2_11) pitch = 100 vol=50
//Obj_Jump gravity=-420 speed=10
begin
if IsAlive name=TRG_MG_TP_AnimControl
//if Obj_ObjectInRect dist = 10 width = 7 height = 9 type = skater offset = ( -30, 0, -4 ) debug
//endif
	if Obj_FlagSet OBJFLAG_TENNIS_SWING
		Obj_ClearFlag OBJFLAG_TENNIS_SWING
		SpawnSkaterScript MG_TP_TakeShot id=MG_TP_Spawnscript
		SendFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_SHOOTING
	//	wait 3 frames
		if skater:held left
			printf "skater is going left"
			ballcheckslow={dist = 7 width = 7 height = 19 type = skater offset = ( 3, 0, -5 ) } //debug}
			ballcheckmed ={dist = 7 width = 4 height = 19 type = skater offset = ( 1, 0, -5 ) } //debug}
			ballcheckfast={dist = 7 width = 1 height = 19 type = skater offset = ( 1, 0, -5 ) } //debug}
			else
			if skater:held right
				printf "skater is going right"
				ballcheckslow={dist = 7 width = 7 height = 19 type = skater offset = ( -3, 0, -5 ) } //debug}
				ballcheckmed ={dist = 7 width = 4 height = 19 type = skater offset = ( -1, 0, -5 ) } //debug}
				ballcheckfast={dist = 7 width = 1 height = 19 type = skater offset = ( -1, 0, -5 ) } //debug}
				else
				printf "skater is standing"
				ballcheckslow={dist = 7 width = 7 height = 19 type = skater offset = ( 0, 0, -4 ) } //debug}
				ballcheckmed ={dist = 7 width = 4 height = 19 type = skater offset = ( 0, 0, -4 ) } //debug}
				ballcheckfast={dist = 7 width = 1 height = 19 type = skater offset = ( 0, 0, -4 ) } //debug}
			Endif
		Endif
				begin
		if Obj_ObjectInRect <ballcheckfast>
			create_panel_message text="Fast"
			PlaySound sch_tennis_11 pitch = 105
			MG_TennisBallHit TB_speed=80
			Else
			if Obj_ObjectInRect <ballcheckmed>
		        create_panel_message text="Med"
				PlaySound sch_tennis_11 pitch = 100
				MG_TennisBallHit TB_speed=50
				Else
				if Obj_ObjectInRect <ballcheckslow>
			        create_panel_message text="Slow"
					PlaySound sch_tennis_11 pitch = 90
					MG_TennisBallHit TB_speed=30
				Endif
			Endif
		Endif
				wait 1 frame
				repeat 10
	Endif
endif
wait 1 frame
Repeat
Obj_WaitMove
Die
Endscript

Script MG_TP_TakeShot
printf "-----------------TAKING THE SHOT-------------------"
if IsAlive name=TRG_MG_TP_AnimControl
	ClearFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_IDLE
	ClearFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_RUN
	SendFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_SHOOTING
endif
if QueryFlag OBJFLAG_BBALL_MOVING name=TRG_MG_TP_AnimControl
    if held right 
		PlayAnim Anim=Ped_TP_SkaterRunningHit speed=2 from=10 to=40
	else	
		if held left
		PlayAnim Anim=Ped_TP_SkaterRunningHit speed=2 from=10 to=40
		else
			PlayAnim Anim=Ped_TP_StandingHit speed=2 from=10 to=50
		endif	
	endif	
Else
    PlayAnim Anim=Ped_TP_StandingHit speed=2
Endif
WaitAnimFinished
if IsAlive name=TRG_MG_TP_AnimControl
	ClearFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_SHOOTING
	ClearFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_MOVING
	SendFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_IDLE
endif
Endscript
Script MG_TennisBallDieWin
if IsAlive name=TRG_Ped_TennisPlayer
	if QueryFlag OBJFLAG_TENNIS_THERE name=TRG_Ped_TennisPlayer
	//    SendFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_RETURN
		SendFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_SWING
		ClearFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_THERE
	MG_TennisBallHitBack
	Else
		SendFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_LOSE
		PlaySound GoalDone
		SendException SCH_MG_TP_WIN Name = TRG_MG_TP_AnimControl
	//    create_panel_message text="Won"
		Die
	Endif
endif
Die
Endscript
Script MG_TennisBallDieLose
wait 10 frames
if IsAlive name=TRG_MG_TP_AnimControl
	SendException SCH_MG_TP_LOSE Name = TRG_MG_TP_AnimControl
	PlaySound GoalFail
	//create_panel_message text="Lost"
endif
Die
Endscript

script Pong_CheckDPad
if IsAlive name=TRG_MG_TennisBall
    if Held Left
        SendFlag name=TRG_MG_TennisBall OBJFLAG_TENNIS_UP
    Endif
    if Held Right
        SendFlag name=TRG_MG_TennisBall OBJFLAG_TENNIS_DOWN
    Endif
Endif
Endscript

Script MG_TennisBallHit TB_speed=20
Obj_ClearFlag OBJFLAG_TENNIS_UP
Obj_ClearFlag OBJFLAG_TENNIS_DOWN
Obj_ClearExceptions
SpawnSkaterScript Pong_CheckDPad
wait 1 frame
if IsAlive name=TRG_Ped_TennisPlayer
	if Obj_FlagSet OBJFLAG_TENNIS_UP
		Obj_MoveToNode name=TRG_MG_TennisBallNavBall01 speed=<TB_speed>
		SendFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_NAV1
		Else
		if Obj_FlagSet OBJFLAG_TENNIS_DOWN
			Obj_MoveToNode name=TRG_MG_TennisBallNavBall03 speed=<TB_speed>
			SendFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_NAV3
		Else
			Obj_MoveToNode name=TRG_MG_TennisBallNavBall02 speed=<TB_speed>
			SendFlag name=TRG_Ped_TennisPlayer OBJFLAG_TENNIS_NAV2
		Endif
	Endif
Endif
Obj_Jump gravity=-420 speed=100
Obj_WaitJumpFinished
Obj_PlaySound random (@tennisballbounce_11 @tennisballbounce2_11) pitch = 100 vol=50
Obj_Jump gravity=-420 speed=100
Obj_WaitMove
Goto MG_TennisBallHitBack
Endscript

Script MG_TennisPlayer
Obj_PlayAnim Anim=Ped_TP_Idle Cycle
begin
wait 1 frame

if Obj_FlagSet OBJFLAG_TENNIS_SWING
    Obj_ClearFlag OBJFLAG_TENNIS_SWING
    Obj_SetFlag OBJFLAG_TENNIS_RETURN
        Obj_PlayAnim Anim=Ped_TP_StandingHit speed=2
        wait 4 frames
		printf " hiback sound from AI"
        Playsound sch_tennis_11 pitch=random (@95 @100 @105)
Endif

if Obj_FlagSet OBJFLAG_TENNIS_RETURN
printf "return"
    Obj_ClearFlag OBJFLAG_TENNIS_RETURN
//    Obj_Flip
    Sch_MG_Tennis_RunToNav Sch_Tennis_Nav=TRG_MG_TennisBallNavEnemy02 GotoNav=OBJFLAG_TENNIS_NAV2 CurrentNav=OBJFLAG_CURRENT_NAV2
Endif
if Obj_FlagSet OBJFLAG_TENNIS_LOSE
printf "lose"
    Obj_ClearFlag OBJFLAG_TENNIS_LOSE
    Sch_MG_Tennis_RunToNav Sch_Tennis_Nav=TRG_MG_TennisBallNavEnemy02 GotoNav=OBJFLAG_TENNIS_NAV2 CurrentNav=OBJFLAG_CURRENT_NAV2
Endif
if Obj_FlagSet OBJFLAG_TENNIS_NAV1
printf "nav1"
    Sch_MG_Tennis_RunToNav Sch_Tennis_Nav=TRG_MG_TennisBallNavEnemy01 GotoNav=OBJFLAG_TENNIS_NAV1 CurrentNav=OBJFLAG_CURRENT_NAV1
Endif
if Obj_FlagSet OBJFLAG_TENNIS_NAV2
printf "nav2"
    Sch_MG_Tennis_RunToNav Sch_Tennis_Nav=TRG_MG_TennisBallNavEnemy02 GotoNav=OBJFLAG_TENNIS_NAV2 CurrentNav=OBJFLAG_CURRENT_NAV2
Endif
if Obj_FlagSet OBJFLAG_TENNIS_NAV3
printf "nav3"
    Sch_MG_Tennis_RunToNav Sch_Tennis_Nav=TRG_MG_TennisBallNavEnemy03 GotoNav=OBJFLAG_TENNIS_NAV3 CurrentNav=OBJFLAG_CURRENT_NAV3
Endif
repeat
Endscript

script Sch_MG_Tennis_RunToNav Sch_Tennis_Nav=TRG_MG_TennisBallNavEnemy02 GotoNav=OBJFLAG_TENNIS_NAV1 CurrentNav=OBJFLAG_CURRENT_NAV1
//Obj_KillSpawnedScript id=MG_TP_Anim
Sch_TP_CheckForFlipMG
Obj_ClearFlag <GotoNav>
Obj_ClearFlag OBJFLAG_TENNIS_THERE
Obj_GetDistToNode <Sch_Tennis_Nav>
if (<dist> < 5)
    printf "already there"
    Obj_PlayAnim Anim=Ped_TP_Idle Cycle
    Obj_SetFlag OBJFLAG_TENNIS_THERE
Else
Obj_MoveToNode name=<Sch_Tennis_Nav> time=.75 second
//Obj_PlayAnim Anim=Ped_TP_RunFromIdle
//Obj_WaitAnimFinished
Obj_PlayAnim Anim=Ped_TP_Run Cycle
Endif
//    Obj_ClearFlag OBJFLAG_TENNIS_THERE
//    if Obj_FlagSet OBJFLAG_TENNIS_RETURN
//        Obj_ClearFlag OBJFLAG_TENNIS_RETURN
//    Else
//if Obj_FlagSet OBJFLAG_TENNIS_RETURN
//    Obj_ClearFlag OBJFLAG_TENNIS_RETURN
//Else        
//if Obj_FlagSet OBJFLAG_TENNIS_LOSE
//Else    
//begin    
//   if Obj_FlagSet OBJFLAG_TENNIS_SWING
//        Obj_ClearFlag OBJFLAG_TENNIS_SWING
//        Obj_ClearFlag OBJFLAG_TENNIS_LOSE
//    Else        
//        Obj_PlayAnim Anim=Ped_TP_StandingHit
//        wait 15 frames
//        Obj_Playsound sch_tennis_11 pitch=random (@95 @100 @105)
//        Obj_SetFlag OBJFLAG_TENNIS_RETURN
//        break
//        Obj_WaitAnimFinished
//        Obj_SetFlag OBJFLAG_TENNIS_RETURN
//        Obj_ClearFlag OBJFLAG_TENNIS_LOSE
//   Endif
//wait 1 frame
//repeat
//Endif
//Obj_SetFlag <CurrentNav>
//Obj_PlayAnim Anim=Ped_TP_Idle Cycle
Endscript


Script MG_TennisPlayer_There
printf "got to node"
//Obj_SpawnScript MG_TennisPlayerStopRunning id=MG_TP_Anim
//if Obj_FlagSet OBJFLAG_TENNIS_LOSE
//    Obj_ClearFlag OBJFLAG_TENNIS_LOSE
//    Obj_ClearFlag OBJFLAG_TENNIS_RETURN
//Else    
//if Obj_FlagSet OBJFLAG_TENNIS_RETURN
//    Obj_ClearFlag OBJFLAG_TENNIS_RETURN
//Else    
//printf "setting flag OBJFLAG_TENNIS_THERE"
//Obj_PlayAnim Anim=Ped_TP_RunToIdle speed=2
//Obj_WaitAnimFinished
Obj_PlayAnim Anim=Ped_TP_Idle Cycle
Obj_SetFlag OBJFLAG_TENNIS_THERE
//Endif
//Endif
Endscript

Script MG_TennisPlayerStopRunning
Obj_PlayAnim Anim=Ped_TP_RunToIdle speed=2
Obj_WaitAnimFinished
Obj_PlayAnim Anim=Ped_TP_Idle Cycle
Endscript

Script Sch_TP_CheckForFlipMG
printf "checking for flip"
if Obj_FlagSet OBJFLAG_TENNIS_NAV1
    Sch_TP_UNFlipTheTennisPlayer
endif	
if Obj_FlagSet OBJFLAG_TENNIS_NAV3
    Sch_TP_FlipTheTennisPlayer
Endif
if Obj_FlagSet OBJFLAG_TENNIS_NAV2
    printf "at nav2"
    if Obj_FlagSet OBJFLAG_CURRENT_NAV1
        Sch_TP_FlipTheTennisPlayer
    endif	
    if Obj_FlagSet OBJFLAG_CURRENT_NAV3
        Sch_TP_UNFlipTheTennisPlayer
    endif	
    printf "done with nav2"
endif	
Obj_ClearFlag OBJFLAG_CURRENT_NAV1
Obj_ClearFlag OBJFLAG_CURRENT_NAV2
Obj_ClearFlag OBJFLAG_CURRENT_NAV3
printf "doone checking for flip"
Endscript
Script MG_TP_AnimsEnd
if IsAlive name=TRG_MG_TP_AnimControl
    ClearFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_MOVING
Endif
wait 1 frame
Goto MG_TP_Anims
Endscript
Script MG_TP_SetIdle
if IsAlive name=TRG_MG_TP_AnimControl
    ClearFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_RUN
    SendFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_IDLE
Endif
Endscript    
Script MG_TP_SetRun
if IsAlive name=TRG_MG_TP_AnimControl
    SendFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_RUN
    ClearFlag name=TRG_MG_TP_AnimControl OBJFLAG_BBALL_IDLE
Endif
Endscript    
Script MG_TP_Anims
wait 1 frame
begin
if IsAlive name=TRG_MG_TP_AnimControl
	//printf "MG_TP_Anims is alive"
	if QueryFlag OBJFLAG_BBALL_SHOOTING name=TRG_MG_TP_AnimControl
		//printf "SHOOTING!!!"
		Else
		//printf "Not Shooting"
		if QueryFlag OBJFLAG_BBALL_IDLE name=TRG_MG_TP_AnimControl
		//    printf "Idling"
			if QueryFlag OBJFLAG_BBALL_MOVING name=TRG_MG_TP_AnimControl
				MG_TP_CheckForFlipping
				//        printf "Run From Idle"
				PlayAnim Anim=Ped_TP_RunFromIdle Speed=5 Norestart Blendperiod=0.3
				WaitAnimFinished
				MG_TP_SetRun
				Goto MG_TP_AnimsEnd
				Else
				//        printf "Idle Anim"
				PlayAnim Anim=Ped_TP_Idle Cycle NoRestart 
				MG_TP_SetIdle
				Goto MG_TP_AnimsEnd
			Endif
		Endif
		if QueryFlag OBJFLAG_BBALL_RUN name=TRG_MG_TP_AnimControl
			//    printf "Running"
			//If AnimEquals Ped_TP_RunFromIdle
			if QueryFlag OBJFLAG_BBALL_MOVING name=TRG_MG_TP_AnimControl
				//        printf "Run Anim"
				MG_TP_CheckForFlipping
				PlayAnim Anim=Ped_TP_Run Cycle NoRestart
				MG_TP_SetRun
				Goto MG_TP_AnimsEnd
				Else
				//        printf "Idle to Run"
				PlayAnim Anim=Ped_TP_RunToIdle Speed=5 Norestart Blendperiod=0.3
				WaitAnimFinished
				MG_TP_SetIdle
				Goto MG_TP_AnimsEnd
			Endif
		Endif
	Endif
Endif
wait 1 frame
repeat
Endscript

Script MG_TP_CheckForFlipping
if IsAlive name=TRG_MG_TP_AnimControl
	if QueryFlag OBJFLAG_TENNIS_FLIPPED name=TRG_MG_TP_AnimControl
		If Flipped
		Else
			Flip
		endif	
	Else
		If Flipped
			Flip
		endif	
	endif	
endif
Endscript


Script Sch_MG_Tennis_Judge
Obj_VarSet var=0 value=0
Obj_VarSet var=1 value=0
Obj_SetException Ex = SCH_MG_TP_WIN Scr = Sch_MG_Tennis_JudgeWin
Obj_SetException Ex = SCH_MG_TP_LOSE Scr = Sch_MG_Tennis_JudgeLose
Endscript
Script Sch_MG_Tennis_JudgeWin
//	create_panel_message id=goal_message text="You Won!" style=panel_message_generic_loss
Playstream Random (@stadiumcheers @stadiumcheers2) vol=random (@50 @60 @70) dropoff=400
    if Obj_VarEQ var=0 value=40
		Obj_VarSet var=0 value=50
	endif
    if Obj_VarEQ var=0 value=30
		Obj_VarSet var=0 value=40
	endif
    if Obj_VarEQ var=0 value=15
		Obj_VarSet var=0 value=30
	endif
    if Obj_VarEQ var=0 value=0
		Obj_VarSet var=0 value=15
	endif
	Sch_MG_Tennis_JudgeShowScore <...>
Endscript
Script Sch_MG_Tennis_JudgeLose
//	create_panel_message id=goal_message text="You Lost!" style=panel_message_generic_loss
    if Obj_VarEQ var=1 value=40
		Obj_VarSet var=1 value=50
	endif
    if Obj_VarEQ var=1 value=30
		Obj_VarSet var=1 value=40
	endif
    if Obj_VarEQ var=1 value=15
		Obj_VarSet var=1 value=30
	endif
    if Obj_VarEQ var=1 value=0
		Obj_VarSet var=1 value=15
	endif
	Sch_MG_Tennis_JudgeShowScore <...>
Endscript
Script Sch_MG_Tennis_JudgeShowScore
    Obj_VarGet var=0 name=PlayerScore
    Obj_VarGet var=1 name=AIScore
    FormatText TextName=Foo "You: %q    Bjorn: %r" q=<PlayerScore> r=<AIScore>
	create_panel_message id=MiniGame1 text=<Foo> style=panel_message_generic_loss
    if Obj_VarEQ var=0 value=50
		//Makeskatergoto SkaterInit
		PauseSkaters
		Obj_VarSet var=0 value=0
		Obj_VarSet var=1 value=0
		create_panel_message id=MiniGame1 text=" " style=panel_message_generic_loss
//		GoalMAnager_AddCash 1000
		//GoalManager_AwardMinigameCash  100
		GoalManager_AwardMinigameCash name=sch_goal_minigame_generic 500
		wait 1 seconds
		stopstream
		PlaySound GoalGood
		wait .5 seconds
		wait 1 frame
		create_speech_box {
			text=[
				"Bjorn:\n'Zut Alors! - You have beaten me... ME!\n"
				"You must play me again - I must be given another chance!'\n-\n"
				"Press \b3 to Accept\nPress \m1 to Decline"
				]
			style=speech_box_style
			pad_back_script=SCH_MG_EndGame
			pad_choose_script=SCH_MG_RestartGame
		}
		pauseskaters
		wait 1 second
		Playstream tennis_win
		begin 
		wait 100 frames
		repeat
	endif
    if Obj_VarEQ var=1 value=50
		PauseSkaters
		Obj_VarSet var=0 value=0
		Obj_VarSet var=1 value=0
		create_panel_message id=MiniGame1 text=" " style=panel_message_generic_loss
		stopstream
		wait 1 frame
//		PlaySound GoalFail
		create_speech_box {
			text=[
				"Bjorn:\n'You foolish skater-person... I laugh at you -\n ha-ha-ha-ha!'\n"
				"Play Again?\n"
				"Press \b3 to Accept\nPress \m1 to Decline"
				]
			style=speech_box_style
			pad_back_script=SCH_MG_EndGame
			pad_choose_script=SCH_MG_RestartGame
		}
		PauseSkaters
		wait 1 second
		Playstream tennis_lose
		begin 
		wait 1 frames
		repeat
	endif
Endscript

Script SCH_MG_RestartGame
			wait 1 second
			UnPauseSkaters
			speech_box_exit
			TRG_MG_TP_AnimControl: Sch_MG_Tennis_Judge
Endscript




minigame_generic_GenericParams={
	activate = minigame_generic_activate
	deactivate = minigame_generic_deactivate
	cash_limit = 500
	minigame
}
script minigame_generic_activate
	minigame_activate goal_id=<goal_id>
endscript
script minigame_generic_deactivate
	minigame_deactivate goal_id=<goal_id>
endscript
minigame_generic2_GenericParams={
	activate = minigame_generic2_activate
	deactivate = minigame_generic2_deactivate
	cash_limit = 500
	minigame
}
script minigame_generic2_activate
	minigame_activate goal_id=<goal_id>
endscript
script minigame_generic2_deactivate
	minigame_deactivate goal_id=<goal_id>
endscript
minigame_generic3_GenericParams={
	activate = minigame_generic3_activate
	deactivate = minigame_generic3_deactivate
	cash_limit = 500
	minigame
}
script minigame_generic3_activate
	minigame_activate goal_id=<goal_id>
endscript
script minigame_generic3_deactivate
	minigame_deactivate goal_id=<goal_id>
endscript

minigame_generic4_GenericParams={
	activate = minigame_generic4_activate
	deactivate = minigame_generic4_deactivate
	cash_limit = 300
	minigame
}
script minigame_generic4_activate
	minigame_activate goal_id=<goal_id>
endscript

script minigame_generic4_deactivate
	minigame_deactivate goal_id=<goal_id>
endscript
*/
