
script Basketball Shotcounter=10 ShotsMade=0 	
	Skiptrack
	If Flipped
		Flip
	endif	
	ClearExceptions
	DisablePlayerInput
	SetRollingFriction 1000
	PlayAnim Anim=Ped_BP_DribbleInPlace Cycle 
	Create_Speech_box { text=[ "Basketballer:\n 'sup dog. I bet you fitty bucks you can't make 8 shots in 10 tries. "
							   "Hold \b3 to shoot, release \b3 at the very top of your jump to bust a 3 pointer. \n"
							   "Press \b1 at any time to wuss out, punk."
							 ]
						pos=(320, 240)
					  }
	begin		
		if Held X
			GotoPreserveParams Basketball_OnGround
		endif
		if Held Square
			speech_box_exit
			Goto SkaterInit
		endif
		WaitOneGameFrame	
	repeat	
endscript

script Basketball_OnGround
	ClearTrickQueue
	ClearEventBuffer
	SetRollingFriction 1000 
	if not GotParam ShotCounter
		Shotcounter=10
	endif	
	If ( <shotcounter> < 1	)
		If ( <shotsmade> < 9 )
			Goto Basketball_PlayAgain  
		else
			Goto Basketball_YouWin
		endif
	endif
	begin
		PlayAnim Anim=Ped_BP_DribbleInPlace Cycle NoRestart
		if Held X
			GotoPreserveParams Basketball_InAir
		endif
		if Held Square
			Goto OnGroundAi
		endif
		WaitOneGameFrame	
	repeat	
endscript	

script Basketball_InAir 
		ClearExceptions
		PlayAnim Anim=Ped_BP_ShootBall To=80
		begin
			if released x
				<ShotCounter> = ( <ShotCounter> - 1 )		
				Update_ShotCounter <...>
				Trick_MissShot
				WaitAnimFinished
				GotoPreserveParams Basketball_OnGround				
			endif	 
			Wait 1 Frame
		repeat 20
		begin
			if released x
				Trick_MakeShot
				<ShotsMade> = (<ShotsMade> + 1)
				<ShotCounter> = ( <ShotCounter> - 1 )		
				Update_ShotCounter <...>	
				WaitAnimFinished
				GotoPreserveParams Basketball_OnGround			
			endif	 
			Wait 1 Frame
		repeat 3
		begin
			if released x
				<ShotCounter> = ( <ShotCounter> - 1 )		
				Update_ShotCounter <...>				
				Trick_MissShot
				WaitAnimFinished
				GotoPreserveParams Basketball_OnGround
			endif	 
			Wait 1 Frame
		repeat 20  	
		WaitAnimFinished
		<ShotCounter> = ( <ShotCounter> - 1 )		
		Update_ShotCounter <...>		
		Trick_DidNotShoot
		begin
			if released x
				GotoPreserveParams Basketball_OnGround 
			else
				PlayAnim Anim=Ped_BP_DribbleInPlace cycle norestart
			endif
		WaitOneGameFrame
		repeat	
endscript

Script Update_ShotCounter
		<TotalShots>= (10 - <shotcounter> )
		FormatText TextName=Baskets_scored "%m for %s" s=<TotalShots> m=<ShotsMade>
		Create_panel_message id=shotcounter pos=(80,240) text=<Baskets_scored>
endscript

Script Trick_MakeShot
	Create_panel_message text=" " id=bball time=1	
	Wait 1 frame	
	Create_panel_message rgba=[32 144 32 100] pos=(320,80) id=bball Random (@text="Nice!" @text="He shoots he scores!" @text="Bucket!" @text="Nice!" @text="Swish!") 
endscript

Script Trick_MissShot
	Create_panel_message text=" " id=bball time=1	
	Wait 1 frame	
	Create_panel_message id=bball pos=(320,80) Random (@text="Airball!" @text="CLANG!" @text="Weak..." @text="Brick!") 	
endscript 

script Trick_DidNotShoot
	Create_panel_message text=" " id=bball time=1	
	Wait 1 frame	
	Create_panel_message id=bball pos=(320,80) text="Release X to shoot, moron!"	
endscript

script BasketBall_PlayAgain
	<Shotcounter>=10
	<ShotsMade>=0
	PlayAnim Anim=Ped_M_Disgust
	WaitAnimFinished
	PlayAnim  Anim=Ped_BP_DribbleInPlace Cycle 
	Create_Speech_box {text=[ "Basketballer:\n Man, get your sorry ass out of here."
								" If you still got game, press \b3 to go again, or else press "
								"\b1 to get lost."]
				  pos=(320, 240)}
	Debounce X	
	begin		
		if Held X
			GotoPreserveParams Basketball_OnGround
		endif
		if Held Square
			speech_box_exit			
			Goto OnGroundAi
		endif
		WaitOneGameFrame	
	repeat	
endscript

script BasketBall_YouWin
	<Shotcounter>=10
	<ShotsMade>=0
	PlayAnim Anim=Ped_M_Cheering
	WaitAnimFinished
	PlayAnim  Anim=Ped_BP_DribbleInPlace Cycle 
	Create_Speech_box {text=[ "Basketballer:\n Daaaaaamn. You was raisin' up sumthin' righteous. Here's fitty - "
							"press \b3 to go again or \b1 to bolt."]
				  pos=(320, 240)}
	GoalMAnager_AddCash 50
	PlaySound cash Vol=130 
	Debounce X
	begin		
		if Held X
			GotoPreserveParams Basketball_OnGround
		endif
		if Held Square
			speech_box_exit
			Goto OnGroundAi
		endif
		WaitOneGameFrame	
	repeat	
endscript

script	Kill_Speech_Box
	if ObjectExists id=speech_box_anchor
		DestroyScreenElement id=speech_box_anchor
	endif
endscript



script WaitOnGroundWhilstChecking
begin
DoNextTrick
if OnGround
    break
endif   
WaitOneGameFrame
repeat
endscript

script WaitFramesWhilstChecking Frames=60
begin
	DoNextTrick
	Wait 1 Frame
repeat <frames>
endscript

	 
script Basketball2
//	SetSlomo .5
//	PlaySkaterCamAnim name=MG_BBall play_hold
	PlaySkaterCamAnim name=MG_BBallTop play_hold
    SwitchOffBoard
	Obj_VarSet var=0 value=4
	printf "blah blah blah"
    kill prefix="TRG_Ped_BB_"
    create name=TRG_PedBB_MG_D
    create name=MG_BB_Box
	Skiptrack
	If Flipped
		Flip
	endif	
    Obj_SetFlag OBJFLAG_BBALL_IDLE
	ClearExceptions
    SpawnSkaterScript MG_BB_Anims
	DisablePlayerInput
	SetRollingFriction 1000
    if NOT IsAlive name=TRG_MG_BB_AnimControl
        create name=TRG_MG_BB_AnimControl
    Endif
    SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE
	Create_Speech_box {text=[ "Basketballer:\n So the little skateboarder thinks he can hold his own?! "
       				  "Hold \b3 to shoot, release \b3 when it looks like the shot is on. \n"
				  "Press \b1 at any time to wuss out, punk."]
				  pos=(320, 240)}
Begin    
	PlayAnim Anim=Ped_BP_DribbleInPlace Cycle 
    wait 30 frames
    Begin
        if Held X
            if IsAlive name=TRG_MG_BBall_GameBall
            Else
                ClearFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE
                ClearFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_RUN
                SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING
                Rotate duration=10 frame node=TRG_MG_BBall_GameBall 
                Obj_PlayAnim Anim=Ped_BP_ShootBall
                Create name=TRG_MG_BBall_GameBall
                PlaySound sch_tennis_11
                SpawnSkaterScript MG_BBall_TakeShot
                begin
                if QueryFlag OBJFLAG_BBALL_SHOOTING name=TRG_MG_BB_AnimControl
                    Break
                Endif
                wait 1 frame
                repeat
            Endif
        Endif
        if Held Left
            if Obj_VarEq var=0 value=1
                MG_BB_RunToLeft node=TRG_MG_BB_MoveTo01
            Endif
            if Obj_VarEq var=0 value=2
                MG_BB_RunToLeft node=TRG_MG_BB_MoveTo02
            Endif
            if Obj_VarEq var=0 value=3
                MG_BB_RunToLeft node=TRG_MG_BB_MoveTo03
            Endif
            if Obj_VarEq var=0 value=4
                MG_BB_RunToLeft node=TRG_MG_BB_MoveTo04
            Endif
            if Obj_VarEq var=0 value=5
                MG_BB_RunToLeft node=TRG_MG_BB_MoveTo05
            Endif
            if Obj_VarEq var=0 value=6
                MG_BB_RunToLeft node=TRG_MG_BB_MoveTo06
            Endif
            if Obj_VarEq var=0 value=7
                MG_BB_RunToLeft node=TRG_MG_BB_MoveTo07
            Endif
            if Obj_VarEq var=0 value=8
                MG_BB_RunToLeft node=TRG_MG_BB_MoveTo07
            Endif
        Endif
        if Held Right
            if Obj_VarEq var=0 value=1
                MG_BB_RunToRight node=TRG_MG_BB_MoveTo02
            Endif
            if Obj_VarEq var=0 value=2
                MG_BB_RunToRight node=TRG_MG_BB_MoveTo03
            Endif
            if Obj_VarEq var=0 value=3
                MG_BB_RunToRight node=TRG_MG_BB_MoveTo04
            Endif
            if Obj_VarEq var=0 value=4
                MG_BB_RunToRight node=TRG_MG_BB_MoveTo05
            Endif
            if Obj_VarEq var=0 value=5
                MG_BB_RunToRight node=TRG_MG_BB_MoveTo06
            Endif
            if Obj_VarEq var=0 value=6
                MG_BB_RunToRight node=TRG_MG_BB_MoveTo07
            Endif
            if Obj_VarEq var=0 value=7
                MG_BB_RunToRight node=TRG_MG_BB_MoveTo08
            Endif
            if Obj_VarEq var=0 value=8
                MG_BB_RunToRight node=TRG_MG_BB_MoveTo08
            Endif
        Endif
        if Held Square
            kill prefix="TRG_MG_BB_AnimControl"
            kill prefix="TRG_PedBB_MG_D"
            kill prefix="MG_BB_Box"
        	PlaySkaterCamAnim skater=0 stop
        	SetRollingFriction 1 
            Enableplayerinput
            create prefix="TRG_Ped_BB_"
            MakeSkaterGoto SkaterInit
			speech_box_exit
            Break
        Endif
        wait 1 frame
    Repeat
    Obj_WaitAnimFinished
Repeat
endscript	

Script Sch_MG_BBallShootCheck
Obj_ClearFlag OBJFLAG_BBALL_TOOKSHOT
begin
Obj_MoveToRelPos (0,5,0)
wait 1 frame
create_panel_message id=bball_shot text="early"
if Obj_FlagSet OBJFLAG_BBALL_TOOKSHOT
    Obj_ClearFlag OBJFLAG_BBALL_TOOKSHOT
    Goto Sch_MG_BBallShotEarly
endif
repeat 22
begin
Obj_MoveToRelPos (0,5,0)
wait 1 frame
create_panel_message id=bball_shot text="!!!!NOW!!!!!"
if Obj_FlagSet OBJFLAG_BBALL_TOOKSHOT
    Obj_ClearFlag OBJFLAG_BBALL_TOOKSHOT
    Goto Sch_MG_BBallShotOn
endif
repeat 5
begin
Obj_MoveToRelPos (0,5,0)
wait 1 frame
create_panel_message id=bball_shot text="late"
if Obj_FlagSet OBJFLAG_BBALL_TOOKSHOT
    Obj_ClearFlag OBJFLAG_BBALL_TOOKSHOT
    Goto Sch_MG_BBallShotLate
endif
repeat 7
create_panel_message id=bball_shot text=" "
Goto Sch_MG_BBallShotLate
SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE
ClearFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING
Die
endscript

Script Sch_MG_BBallShotEarly
create_panel_message id=bball_shot text="EARLY"
SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE
ClearFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING
die
Endscript

Script Sch_MG_BBallShotOn
create_panel_message id=bball_shot text="RIGHT ON!"
SpawnSkaterScript Sch_BB_Sound_BallMake id=MG_BBallSound
SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE
ClearFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING
die
Endscript

Script Sch_MG_BBallShotLate
create_panel_message id=bball_shot text="LATE"
SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE
ClearFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING
die
Endscript

Script MG_BBall_TakeShot
begin
if Released X
    if IsAlive name=TRG_MG_BBall_GameBall
        SendFlag name=TRG_MG_BBall_GameBall OBJFLAG_BBALL_TOOKSHOT
        Break
    endif
endif
wait 1 frame
repeat 50
Endscript

Script MG_BB_RunToLeft node=TRG_MG_BB_MoveTo01
Rotate duration=3 frame node=<node> 
Move z=5
SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_MOVING
Obj_GetDistToNode <node>
if (<dist> < 50)
    printf "Obj_VarDec"
    Obj_VarDec var=0
    MG_BB_CehckVarSendFlag
Endif
Endscript
Script MG_BB_RunToRight node=TRG_MG_BB_MoveTo08
Rotate duration=2 frame node=<node> 
Move z=5
SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_MOVING
Obj_GetDistToNode <node>
if (<dist> < 50)
    printf "Obj_VarInc"
    Obj_VarInc var=0
    MG_BB_CehckVarSendFlag
Endif
Endscript

Script MG_BB_ClearFlags
ClearFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV1
ClearFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV2
ClearFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV3
ClearFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV4
ClearFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV5
ClearFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV6
ClearFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV7
ClearFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV8
Endscript

Script MG_BB_CehckVarSendFlag
    if Obj_VarEQ var=0 value=0
        Obj_VarSet var=0 value=1
        MG_BB_ClearFlags
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV1
    Endif
    if Obj_VarEQ var=0 value=1
        MG_BB_ClearFlags
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV1
    Endif
    if Obj_VarEQ var=0 value=2
        MG_BB_ClearFlags
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV2
    Endif
    if Obj_VarEQ var=0 value=3
        MG_BB_ClearFlags
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV3
    Endif
    if Obj_VarEQ var=0 value=4
        MG_BB_ClearFlags
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV4
    Endif
    if Obj_VarEQ var=0 value=5
        MG_BB_ClearFlags
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV5
    Endif
    if Obj_VarEQ var=0 value=6
        MG_BB_ClearFlags
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV6
    Endif
    if Obj_VarEQ var=0 value=7
        MG_BB_ClearFlags
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV7
    Endif
    if Obj_VarEQ var=0 value=8
        MG_BB_ClearFlags
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV8
    Endif
    if Obj_VarEQ var=0 value=9
        MG_BB_ClearFlags
        Obj_VarSet var=0 value=8
        SendFlag name=TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV8
    Endif
Endscript

Script Sch_MG_BB_GotToNav01
printf "got to nave 01"
Endscript

Script MG_BB_AnimControl
begin
printf "MG BB anim controller"
wait 1 second
repeat
Endscript

Script MG_BB_AnimsEnd
if IsAlive name=TRG_MG_BB_AnimControl
    ClearFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_MOVING
Endif
wait 1 frame
Goto MG_BB_Anims
Endscript
Script MG_BB_SetIdle
if IsAlive name=TRG_MG_BB_AnimControl
    ClearFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_RUN
    SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE
Endif
Endscript    
Script MG_BB_SetRun
if IsAlive name=TRG_MG_BB_AnimControl
    SendFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_RUN
    ClearFlag name=TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE
Endif
Endscript    
Script MG_BB_Anims
//printf "MG_BB_Anims is alive"
wait 1 frame
begin
if IsAlive name=TRG_MG_BB_AnimControl
if QueryFlag OBJFLAG_BBALL_SHOOTING name=TRG_MG_BB_AnimControl
Else
if QueryFlag OBJFLAG_BBALL_IDLE name=TRG_MG_BB_AnimControl
    if QueryFlag OBJFLAG_BBALL_MOVING name=TRG_MG_BB_AnimControl
        PlayAnim Anim=Ped_BP_DribbleRunFromIdle Speed=5 Norestart Blendperiod=0.3
        WaitAnimFinished
        MG_BB_SetRun
        Goto MG_BB_AnimsEnd
    Else
        Rotate duration=10 frame node=TRG_MG_BBall_GameBall 
        PlayAnim Anim=Ped_BP_DribbleInPlace Cycle NoRestart 
        MG_BB_SetIdle
        Goto MG_BB_AnimsEnd
    Endif
Endif
if QueryFlag OBJFLAG_BBALL_RUN name=TRG_MG_BB_AnimControl
//If AnimEquals Ped_BP_DribbleRunFromIdle
    if QueryFlag OBJFLAG_BBALL_MOVING name=TRG_MG_BB_AnimControl
        PlayAnim Anim=Ped_BP_DribbleRun Cycle NoRestart
        MG_BB_SetRun
        Goto MG_BB_AnimsEnd
     Else
        Rotate duration=10 frame node=TRG_MG_BBall_GameBall 
        PlayAnim Anim=Ped_BP_DribbleRunToIdle Speed=5 Norestart Blendperiod=0.3
        WaitAnimFinished
        MG_BB_SetIdle
        Goto MG_BB_AnimsEnd
     Endif
Endif
Endif
Endif
wait 1 frame
repeat
Endscript

script MG_BB_Defense_Goal
Obj_StickToGround distAbove = 3 distBelow = 6
Obj_SetPathTurnDist 2.5 feet
Obj_StickToGround off
Obj_SetConstantHeight
Obj_PathHeading On
Obj_SetPathVelocity 30 fps
Obj_SetPathAcceleration 45 fpsps
Obj_SetPathDeceleration 45 fpsps
Begin
Obj_PlayAnim Anim=Ped_BP_GuardPlayer Cycle
Begin
if Obj_FlagSet OBJFLAG_BBALL_MOVETONAV1
    Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV1
    wait Random (@10 frames @20 frames @30 frames)
    Sch_BB_RunToNav Sch_BBall_Nav=TRG_Ped_BB_Blocker01
    Obj_LookAtNode name=TRG_MG_BB_MoveTo01
    Break
Endif
if Obj_FlagSet OBJFLAG_BBALL_MOVETONAV2
    Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV2
    wait Random (@10 frames @20 frames @30 frames)
    Sch_BB_RunToNav Sch_BBall_Nav=TRG_Ped_BB_Blocker02
    Obj_LookAtNode name=TRG_MG_BB_MoveTo02
    Break
Endif
if Obj_FlagSet OBJFLAG_BBALL_MOVETONAV3
    Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV3
    wait Random (@10 frames @20 frames @30 frames)
    Sch_BB_RunToNav Sch_BBall_Nav=TRG_Ped_BB_Blocker03
    Obj_LookAtNode name=TRG_MG_BB_MoveTo03
    Break
Endif
if Obj_FlagSet OBJFLAG_BBALL_MOVETONAV4
    Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV4
    wait Random (@10 frames @20 frames @30 frames)
    Sch_BB_RunToNav Sch_BBall_Nav=TRG_Ped_BB_Blocker04
    Obj_LookAtNode name=TRG_MG_BB_MoveTo04
    Break
Endif
if Obj_FlagSet OBJFLAG_BBALL_MOVETONAV5
    Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV5
    wait Random (@10 frames @20 frames @30 frames)
    Sch_BB_RunToNav Sch_BBall_Nav=TRG_Ped_BB_Blocker05
    Obj_LookAtNode name=TRG_MG_BB_MoveTo05
    Break
Endif
if Obj_FlagSet OBJFLAG_BBALL_MOVETONAV6
    Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV6
    wait Random (@10 frames @20 frames @30 frames)
    Sch_BB_RunToNav Sch_BBall_Nav=TRG_Ped_BB_Blocker06
    Obj_LookAtNode name=TRG_MG_BB_MoveTo06
    Break
Endif
if Obj_FlagSet OBJFLAG_BBALL_MOVETONAV7
    Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV7
    wait Random (@10 frames @20 frames @30 frames)
    Sch_BB_RunToNav Sch_BBall_Nav=TRG_Ped_BB_Blocker07
    Obj_LookAtNode name=TRG_MG_BB_MoveTo07
    Break
Endif
if Obj_FlagSet OBJFLAG_BBALL_MOVETONAV8
    Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV8
    wait Random (@10 frames @20 frames @30 frames)
    Sch_BB_RunToNav Sch_BBall_Nav=TRG_Ped_BB_Blocker08
    Obj_LookAtNode name=TRG_MG_BB_MoveTo08
    Break
Endif
wait 1 frame
Repeat
Repeat
Endscript

OBJFLAG_BBALL_TOOKSHOT=0
OBJFLAG_BBALL_MOVETONAV1=1
OBJFLAG_BBALL_MOVETONAV2=2
OBJFLAG_BBALL_MOVETONAV3=3
OBJFLAG_BBALL_MOVETONAV4=4
OBJFLAG_BBALL_MOVETONAV5=5
OBJFLAG_BBALL_MOVETONAV6=6
OBJFLAG_BBALL_MOVETONAV7=7
OBJFLAG_BBALL_MOVETONAV8=8
OBJFLAG_BBALL_MOVING=9
OBJFLAG_BBALL_IDLE=10
OBJFLAG_BBALL_RUN=12
OBJFLAG_BBALL_SHOOTING=13

