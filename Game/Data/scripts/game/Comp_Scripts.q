
/*
DefaultCompParams = {
}
RioScoreParams = {
}

Script CompIntroSequence DefaultCompParams
Endscript

Script CompIntroSequence2 DefaultCompParams
EndScript


Script Comp_RunStart_Params_Pass
EndScript


Script Comp_Wait_RunStart_setup
endscript

Script Comp_Wait_RunStart DefaultCompParams
EndScript


Script SkaterWaitForRunIn
EndScript


Script SkaterWaitForPushIn
4//TEMP UNTIL I CAN GET IDLES FOR THE PUSH IN ANIM
	FreezeSkaterTemp
	Obj_MoveToNode Name = <CompWaypointStart> orient
	Obj_PlayAnim Anim = StandIdle Cycle
EndScript


Script SkaterWaitForDropIn1
	FreezeSkaterTemp Lip
	Obj_MoveToNode Name = <CompWaypointStart>
	Obj_PlayAnim Anim = Dropin_Idle Cycle
	SetState Lip
EndScript


Script SkaterWaitForDropIn2
	FreezeSkaterTemp Lip
	Obj_MoveToNode Name = <CompWaypointStart>
	Obj_PlayAnim Anim = Dropin2_Idle Cycle
	SetState Lip
EndScript


// SP: This little script is a temporary hack
// really, we need a command to do all this by unhooking the
// skater from the physics


script FreezeSkaterTemp
	ClearExceptions
	VibrateOff
	DisablePlayerInput  AllowCameraControl
	SwitchOnBoard
	SetSpeed 0
	If GotParam Lip
		printf "lip state.............."
		SetState Lip
	else
		SetState Ground
	endif
	SetRollingFriction 10000
    SetSkaterCamOverride
    PausePhysics
	CleanUpSpecialItems
endscript


Script CompEndRun DefaultCompParams
	<Comp_CamJudged_Script>
//	Printf "Launched pre judge cam script"
	PlaySkaterCamAnim Skater = 0 Name = <CameraJudgeFlyBy> Play_Hold
	MakeSkaterGoto SkaterJudgedAnims_Idle
	<Comp_CamJudgedHold_Script>
EndScript


Script CompEndRun_Leaders DefaultCompParams
       	MakeSkaterGoto SkaterJudgedAnims_Idle
//	   Printf "LaunchING post judge cam ... pre skater react cam script"
       <Comp_CamJudgedChange_Script>
//       CJR_Rio_Judge_CleanUp
//       Printf "LaunchED post judge cam ... pre skater react cam script"
       PlaySkaterCamAnim Skater = 0 Name = <CameraSkaterJudged> Play_Hold
EndScript


Script CompEndRun_LeadersDone DefaultCompParams
       <Comp_CamJudgedEnd_Script>
EndScript


Script SkaterJudgedAnims_Idle
	Obj_MoveToNode Name = Waypoint_Skater_Judged orient
	FreezeSkaterTemp
		Begin
                        Obj_CycleAnim Anim = SitIdle NumCycles = Random	(
									@1
									@2
									@3
									)
			Obj_CycleAnim Anim = Random	(
							@SitLeftRight
							@SitLeftRight
							)
			Wait 1 GameFrames
		Repeat
EndScript


Script SkaterJudgedAnims_Poor
	Obj_CycleAnim Anim = Random	(
					@SitShake
					@SitHands
					)
	SkaterJudgedAnims_Idle
EndScript


Script SkaterJudgedAnims_Average
	Obj_CycleAnim Anim = Random	(
					@SitNod
					@SitFist
					)
	SkaterJudgedAnims_Idle
EndScript


Script SkaterJudgedAnims_Good
	Obj_CycleAnim Anim = Random	(
					@SitNod
					@SitFist
					)
	SkaterJudgedAnims_Idle
EndScript


Script SkaterLoseAnims
	Obj_MoveToNode Name = Waypoint_Skater_Judged orient
	FreezeSkaterTemp
		Begin
                        Obj_CycleAnim Anim = SitIdle NumCycles = Random	(
									@1
									@2
                                                                        )
			Obj_CycleAnim Anim = Random	(
							@SitShake
							@SitHands
							)
                        Obj_CycleAnim Anim = SitIdle
			Obj_CycleAnim Anim = Random	(
							@SitLeftRight
							@SitLeftRight
							)
			Wait 1 GameFrames
		Repeat
EndScript


Script CompEndSequence DefaultCompParams
EndScript


Script CompEndSequence_1st DefaultCompParams
	If IsCareerMode
        PauseStream 0
		DisablePlayerInput
		Kill Prefix = <CompNormalPeds>
		Create Prefix = <CompEndPeds>
		MakeSkaterGoTo Player_1st_Idle
		<Comp_CamEndCrowd_Script>
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Crowd>
		Wait 30 Gameframes
		LaunchPanelMessage "Final Results" Properties = Panel_Message_CompRule
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
			Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraCompRules_Crowd>
					LaunchPanelMessage "" Properties = Panel_Message_CompRule
					Break
				Endif
				Wait 1 gameframe
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Win>
		Wait 30 GameFrames
		LaunchPanelMessage "1st Place" Properties = Panel_Message_CompSkaterPlace
		SpawnScript PlayerReaction_1st_Skippable
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
                        Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraCompEnd_Win>
					LaunchPanelMessage "" Properties = Panel_Message_CompSkaterPlace
					LaunchPanelMessage "" Properties = Panel_Message_CompSkaterName
					Break
				Endif
				Wait 1 Gameframes
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Final>
		KillSpawnedScript Name = PlayerReaction_1st_Skippable
		SetFlag Flag = COMP_FLAG_1ST_PLACE_GO
		Wait 30 GameFrames
                LaunchPanelMessage "Congratulations! | You Won The GOLD Medal!" Properties = Panel_Message_CompCongrats
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
			Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraCompEnd_Final>
					Break
				EndIf
				Wait 1 GameFrames
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Hold> Play_Hold
		UnSetFlag Flag = COMP_FLAG_1ST_PLACE_GO
        // LaunchLocalMessage id=BottomInfo "Press ¬ to Continue" panel_message_XtoContinue
//        WaitForControllerPressedX
        // LaunchLocalMessage id=BottomInfo " " panel_message_XtoContinue
//		SpawnScript Comp_BlinkXContinue
//			Begin
//			    If Held X
//				Break
//			    EndIf
//			    Wait 1 GameFrames
//			Repeat
		If GetGoal Goal = GOAL_GOLD
		Else
//            printf "Setting gold medal"
			SetGoal	Goal = GOAL_GOLD
            SetGlobalFlag flag=PROMPT_FOR_SAVE
            SetGlobalFlag flag=SKATESHOP_JUST_GOT_MEDAL_GOLD
		EndIf
//		EndRun_CheckForLevelsOpen
//		KillSpawnedScript Name = Comp_BlinkXContinue
                LaunchPanelMessage "" Properties = Panel_Message_CompCongrats
//        printf "Check for movie unlock"
//        if GetGoal goal=GOAL_GOLD
        if JustGotGoal goal=GOAL_GOLD
            if CareerLevelIs LevelNum_Rio
                SetGlobalFlag flag=GOT_GOLD_RIO
//                Goal_CheckProVideoUnlock
//                Goal_UnlockingSecrets
            Endif
            if CareerLevelIs LevelNum_SkaterIsland
                SetGlobalFlag flag=GOT_GOLD_SI
//                Goal_CheckProVideoUnlock
//                Goal_UnlockingSecrets
            Endif
            if CareerLevelIs LevelNum_Tokyo
                SetGlobalFlag flag=GOT_GOLD_TOKYO
//                Goal_CheckProVideoUnlock
//                Goal_UnlockingSecrets
            Endif
    	EndIf
		UnPause_Game_Flow
	EndIf
EndScript


Script CompEndSequence_2nd DefaultCompParams
	If IsCareerMode
        PauseStream 0
		DisablePlayerInput
		Kill Prefix = <CompNormalPeds>
		Create Prefix = <CompEndPeds>
		MakeSkaterGoTo Player_2nd_Idle
		<Comp_CamEndCrowd_Script>
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Crowd>
		Wait 30 Gameframes
		LaunchPanelMessage "Final Results" Properties = Panel_Message_CompRule
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
			Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraCompRules_Crowd>
					LaunchPanelMessage "" Properties = Panel_Message_CompRule
					Break
				Endif
				Wait 1 gameframe
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Win>
		Wait 30 Gameframes
		LaunchPanelMessage "2nd Place" Properties = Panel_Message_CompSkaterPlace
		SpawnScript PlayerReaction_2nd_Skippable
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
			Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraCompEnd_Win>
					LaunchPanelMessage "" Properties = Panel_Message_CompSkaterPlace
					LaunchPanelMessage "" Properties = Panel_Message_CompSkaterName
					Break
				EndIf
				Wait 1 GameFrames
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Final>
		KillSpawnedScript Name = PlayerReaction_2nd_Skippable
		SetFlag Flag = COMP_FLAG_2ND_PLACE_GO
		Wait 30 GameFrames
		LaunchPanelMessage "Congratulations! | You Won The SILVER Medal!" Properties = Panel_Message_CompCongrats
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
			Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraCompEnd_Final>
					Break
				EndIf
				Wait 1 GameFrames
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Hold> Play_Hold
		UnSetFlag Flag = COMP_FLAG_2ND_PLACE_GO
        // LaunchLocalMessage id=BottomInfo "Press ¬ to Continue" panel_message_XtoContinue
//        WaitForControllerPressedX
        // LaunchLocalMessage id=BottomInfo " " panel_message_XtoContinue
//                SpawnScript Comp_BlinkXContinue
//			Begin
//			    If Held X
//				Break
//			    EndIf
//			    Wait 1 GameFrames
//			Repeat
		If GetGoal Goal = GOAL_GOLD
		Else
    		If GetGoal Goal = GOAL_SILVER
//                printf "already have silver"
                SetGoal Goal = GOAL_SILVER
    		Else
//                printf "Setting silver medal - prompt save"
                SetGlobalFlag flag=PROMPT_FOR_SAVE
                SetGoal Goal = GOAL_SILVER
                SetGlobalFlag flag=SKATESHOP_JUST_GOT_MEDAL_SILVER
            EndIf
        EndIf
//		EndRun_CheckForLevelsOpen
//		KillSpawnedScript Name = Comp_BlinkXContinue
                LaunchPanelMessage "" Properties = Panel_Message_CompCongrats
		UnPause_Game_Flow
	EndIf
EndScript


Script CompEndSequence_3rd DefaultCompParams
	If IsCareerMode
        PauseStream 0
		DisablePlayerInput
		Kill Prefix = <CompNormalPeds>
		Create Prefix = <CompEndPeds>
		MakeSkaterGoTo Player_3rd_Idle
		<Comp_CamEndCrowd_Script>
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Crowd>
		Wait 30 Gameframes
		LaunchPanelMessage "Final Results" Properties = Panel_Message_CompRule
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
			Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraCompRules_Crowd>
					LaunchPanelMessage "" Properties = Panel_Message_CompRule
					Break
				Endif
				Wait 1 gameframe
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Win>
		Wait 30 Gameframes
		LaunchPanelMessage "3rd Place" Properties = Panel_Message_CompSkaterPlace
		SpawnScript PlayerReaction_3rd_Skippable
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
			Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraCompEnd_Win>
					LaunchPanelMessage "" Properties = Panel_Message_CompSkaterPlace
					LaunchPanelMessage "" Properties = Panel_Message_CompSkaterName
					Break
				EndIf
				Wait 1 GameFrames
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Final>
		KillSpawnedScript Name = PlayerReaction_3rd_Skippable
		SetFlag Flag = COMP_FLAG_3RD_PLACE_GO
		Wait 30 GameFrames
		LaunchPanelMessage "Congratulations! | You Won The BRONZE Medal!" Properties = Panel_Message_CompCongrats
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
			Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraCompEnd_Final>
					Break
				EndIf
				Wait 1 GameFrames
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Hold> Play_Hold
		UnSetFlag Flag = COMP_FLAG_3RD_PLACE_GO
        // LaunchLocalMessage id=BottomInfo "Press ¬ to Continue" panel_message_XtoContinue
//        WaitForControllerPressedX
        // LaunchLocalMessage id=BottomInfo " " panel_message_XtoContinue
//                SpawnScript Comp_BlinkXContinue
//			Begin
//			    If Held X
//				Break
//			    EndIf
//			    Wait 1 GameFrames
//			Repeat
		If GetGoal Goal = GOAL_GOLD
		Else
            If GetGoal Goal = GOAL_SILVER
			Else
                If GetGoal Goal = GOAL_BRONZE
//                    printf "already got a Bronze"
		    		SetGoal Goal = GOAL_BRONZE
	    		Else
//                    printf "Setting Bronze medal - prompt save"
                    SetGlobalFlag flag=PROMPT_FOR_SAVE
		    		SetGoal Goal = GOAL_BRONZE
                    SetGlobalFlag flag=SKATESHOP_JUST_GOT_MEDAL_BRONZE
    			EndIf
			EndIf
		EndIf
//		EndRun_CheckForLevelsOpen
//		KillSpawnedScript Name = Comp_BlinkXContinue
                LaunchPanelMessage "" Properties = Panel_Message_CompCongrats
		UnPause_Game_Flow
	EndIf
EndScript


Script CompEndSequence_Lose DefaultCompParams
	If IsCareerMode
        PauseStream 0
		DisablePlayerInput
		Kill Prefix = <CompNormalPeds>
		Create Prefix = <CompEndPeds>
		<Comp_CamEndCrowd_Script>
		PlaySkaterCamAnim Skater = 0 Name = <CameraCompEnd_Crowd>
		Wait 30 Gameframes
		LaunchPanelMessage "Final Results" Properties = Panel_Message_CompRule
		SetSkaterCamAnimSkippable Skater = 0 Skippable = 1
			Begin
				If SkaterCamAnimFinished Skater = 0 Name = <CameraComp1Rules_Crowd>
					LaunchPanelMessage "" Properties = Panel_Message_RunNumber
					Break
				Endif
				Wait 1 gameframe
			Repeat
		PlaySkaterCamAnim Skater = 0 Name = <CameraSkaterJudged> Play_Hold
		MakeSkaterGoto SkaterLoseAnims
		LaunchPanelMessage "" Properties = Panel_Message_CompRule
                Wait 1 Seconds
		LaunchPanelMessage "You Did Not Place.|                   | Maybe next time." Properties = Panel_Message_CompCongrats
        // LaunchLocalMessage id=BottomInfo "Press ¬ to Continue" panel_message_XtoContinue
//        WaitForControllerPressedX
        // LaunchLocalMessage id=BottomInfo " " panel_message_XtoContinue
//                SpawnScript Comp_BlinkXContinue
//			Begin
//			    If Held X
//				Break
//			    EndIf
//			    Wait 1 GameFrames
//			Repeat
//		EndRun_CheckForLevelsOpen
//		KillSpawnedScript Name = Comp_BlinkXContinue
//        LaunchConsoleMessage "Done with Comp results"
		wait 1 frame
        LaunchPanelMessage "" Properties = Panel_Message_CompCongrats
		UnPause_Game_Flow
	EndIf
EndScript


Script Player_1st_Idle
	Obj_MoveToNode Name = Waypoint_Skater_1st  orient
	FreezeSkaterTemp
		Begin
                        If GetFlag Flag = COMP_FLAG_1ST_PLACE_GO
				UnSetFlag Flag = COMP_FLAG_1ST_PLACE_GO
				Break
			EndIf
                        Obj_CycleAnim Anim = StandIdle NumCycles = Random (@1 @2)
                        If GetFlag Flag = COMP_FLAG_1ST_PLACE_GO
				UnSetFlag Flag = COMP_FLAG_1ST_PLACE_GO
				Break
			EndIf
			Obj_CycleAnim Anim = Random	(
							@StandCheckBoard
							@StandLeftRight
							@StandShoulder
							)
			Wait 1 GameFrames
		Repeat
	Player_1st_React
EndScript


Script Player_1st_React
	Obj_CycleAnim Anim = StandFist
	Obj_CycleAnim Anim = Random	(
					@StandRaiseBoard
					@Stand2Hands
					)
        UnSetFlag Flag = COMP_FLAG_1ST_PLACE_GO
	GoTo Player_1st_Idle
EndScript


Script Ped_1st_Idle
	Begin
		If GetFlag Flag = COMP_FLAG_1ST_PLACE_GO
			UnSetFlag Flag = COMP_FLAG_1ST_PLACE_GO
			Break
		EndIf
		Obj_CycleAnim Anim = StandIdle NumCycles = Random (@1 @2)
		If GetFlag Flag = COMP_FLAG_1ST_PLACE_GO
			UnSetFlag Flag = COMP_FLAG_1ST_PLACE_GO
			Break
		EndIf
		Obj_CycleAnim Anim = Random	(
						@StandCheckBoard
						@StandLeftRight
						@StandShoulder
						)
		Wait 1 GameFrames
	Repeat
	Ped_1st_React
EndScript


Script Ped_1st_React
	Obj_CycleAnim Anim = StandFist
	Obj_CycleAnim Anim = Random	(
					@StandRaiseBoard
					@Stand2Hands
					)
        UnSetFlag Flag = COMP_FLAG_1ST_PLACE_GO
EndScript


Script Player_2nd_Idle
	Obj_MoveToNode Name = Waypoint_Skater_1st  orient
	FreezeSkaterTemp
		Begin
                        If GetFlag Flag = COMP_FLAG_2ND_PLACE_GO
				UnSetFlag Flag = COMP_FLAG_2ND_PLACE_GO
				Break
			EndIf
                        Obj_CycleAnim Anim = BoardIdle NumCycles = Random (@1 @2)
                        If GetFlag Flag = COMP_FLAG_2ND_PLACE_GO
				UnSetFlag Flag = COMP_FLAG_2ND_PLACE_GO
				Break
			EndIf
			Obj_CycleAnim Anim = Random	(
							@BoardShrug
							@BoardClap
							)
			Wait 1 GameFrames
		Repeat
	Player_2nd_React
EndScript


Script Player_2nd_React
	Obj_CycleAnim Anim = BoardClap
	Obj_CycleAnim Anim = Random	(
					@BoardWave
					@BoardPump
					)
        UnSetFlag Flag = COMP_FLAG_2ND_PLACE_GO
	GoTo Player_2nd_Idle
EndScript


Script Ped_2nd_Idle
	Begin
                If GetFlag Flag = COMP_FLAG_2ND_PLACE_GO
			UnSetFlag Flag = COMP_FLAG_2ND_PLACE_GO
			Break
		EndIf
                Obj_CycleAnim Anim = BoardIdle NumCycles = Random (@1 @2)
                If GetFlag Flag = COMP_FLAG_2ND_PLACE_GO
			UnSetFlag Flag = COMP_FLAG_2ND_PLACE_GO
			Break
		EndIf
		Obj_CycleAnim Anim = Random	(
						@BoardShrug
						@BoardClap
						)
		Wait 1 GameFrames
	Repeat
	Ped_2nd_React
EndScript


Script Ped_2nd_React
	Obj_CycleAnim Anim = BoardClap
	Obj_CycleAnim Anim = Random	(
					@BoardWave
					@BoardPump
					)
        UnSetFlag Flag = COMP_FLAG_2ND_PLACE_GO
EndScript


Script Player_3rd_Idle
	Obj_MoveToNode Name = Waypoint_Skater_1st  orient
	FreezeSkaterTemp
		Begin
                        If GetFlag Flag = COMP_FLAG_3RD_PLACE_GO
				UnSetFlag Flag = COMP_FLAG_3RD_PLACE_GO
				Break
			EndIf
                        Obj_CycleAnim Anim = BoardIdle NumCycles = Random (@1 @2)
                        If GetFlag Flag = COMP_FLAG_3RD_PLACE_GO
				UnSetFlag Flag = COMP_FLAG_3RD_PLACE_GO
				Break
			EndIf
			Obj_CycleAnim Anim = Random	(
							@BoardShrug
							@BoardClap
							)
			Wait 1 GameFrames
		Repeat
	Player_3rd_React
EndScript


Script Player_3rd_React
	Obj_CycleAnim Anim = BoardClap
	Obj_CycleAnim Anim = Random	(
					@BoardWave
					@BoardPump
					)
        UnSetFlag Flag = COMP_FLAG_3RD_PLACE_GO
	GoTo Player_3rd_Idle
EndScript


Script Ped_3rd_Idle
	Begin
                If GetFlag Flag = COMP_FLAG_3RD_PLACE_GO
			UnSetFlag Flag = COMP_FLAG_3RD_PLACE_GO
			Break
		EndIf
                Obj_CycleAnim Anim = BoardIdle NumCycles = Random (@1 @2)
                If GetFlag Flag = COMP_FLAG_3RD_PLACE_GO
			UnSetFlag Flag = COMP_FLAG_3RD_PLACE_GO
			Break
		EndIf
		Obj_CycleAnim Anim = Random	(
						@BoardShrug
						@BoardClap
						)
		Wait 1 GameFrames
	Repeat
	Ped_3rd_React
EndScript


Script Ped_3rd_React
	Obj_CycleAnim Anim = BoardClap
	Obj_CycleAnim Anim = Random	(
					@BoardWave
					@BoardPump
					)
        UnSetFlag Flag = COMP_FLAG_3RD_PLACE_GO
EndScript


Script Ped_Skater_End
	Begin
                Obj_CycleAnim Anim = BoardIdle NumCycles = Random (@1 @2 @3)
		Obj_CycleAnim Anim = Random	(
						@BoardClap
						@BoardWave
						@BoardPump
						)
		Wait 1 GameFrames
	Repeat
EndScript


Script Ped_Skater_End2
	Begin
                Obj_CycleAnim Anim = StandIdle NumCycles = Random (@1 @2 @3)
		Obj_CycleAnim Anim = Random	(
						@StandCheckBoard
						@StandLeftRight
						@StandShoulder
						)
		Wait 1 GameFrames
	Repeat
EndScript


Script PlayerReaction_1st_Skippable
	Wait 55 GameFrames
	SpawnScript Print_Skater_Place_Name
	SetFlag Flag = COMP_FLAG_1ST_PLACE_GO
EndScript


Script PlayerReaction_2nd_Skippable
	Wait 55 GameFrames
	SpawnScript Print_Skater_Place_Name
	SetFlag Flag = COMP_FLAG_2ND_PLACE_GO
EndScript


Script PlayerReaction_3rd_Skippable
	Wait 55 GameFrames
	SpawnScript Print_Skater_Place_Name
	SetFlag Flag = COMP_FLAG_3RD_PLACE_GO
EndScript


//
//-------Various Peds--------
//


Script Comp_PedEnd_Norm
    Begin
      Obj_PlayAnim Anim = Idle
      Wait Random	(
			@.25 Seconds
			@.5 Seconds
			@.75 Seconds
			@1 Seconds
			)
      Obj_CycleAnim Anim = Random	(
					@Cheering
					@Clap
					@ShakeFist
					@Wave
					@ThinManCheering
					)
    Repeat
Endscript


Script Comp_PedEnd_Pro
	Begin
		Obj_CycleAnim Anim = StandIdle NumCycles = 2
		Obj_CycleAnim Anim = Random	(
						@StandLeftRight
						@StandCheckBoard
						@StandShoulder
						)
		Wait 1 Gameframes
	Repeat
EndScript


//
//-------Misc. Scripts--------
//


Script Comp_BlinkXContinue
	Begin
		LaunchPanelMessage "Press ¬ To Continue" Properties = Panel_Message_XMessage
		Wait 1.25 Seconds
	Repeat
EndScript


Script Comp_BlinkXStartRun
	Begin
		LaunchPanelMessage "Press ¬ To Start Run" Properties = Panel_Message_XMessage
		Wait 1.25 Seconds
	Repeat
EndScript


Script Print_Skater_Place_Name
		LaunchPanelMessage 52 Properties = Panel_Message_CompSkaterName
endscript

//
//-------Message Font Setups--------
//


Panel_Message_CompRule = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,224)	Alpha = 0	Scale = 0	Time = 0}
			{Pos = (320,224)	Alpha = 64	Scale = .5	Time = .15}
			{Pos = (320,224)	Alpha = 128	Scale = 1	Time = .25}
			{Time = 2.5}
			]
}


Panel_Message_RunNumber = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,224)	Alpha = 0	Scale = 0	Time = 0}
			{Pos = (320,224)	Alpha = 64	Scale = .5	Time = .15}
			{Pos = (320,224)	Alpha = 128	Scale = 1	Time = .25}
			{Time = 1.5}
			{Pos = (320,224)	Alpha = 128	Time = 0}
			{Pos = (320,224)	Alpha = 64	Time = .15}
			{Pos = (320,224)	Alpha = 0	Time = .25}
			]
}


Panel_Message_CompTitle = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,110)	Alpha = 128	Scale = 1.35	Time = 0}
			{Time = 25}
			{Alpha = 128	Time = .0}
			{Alpha = 64	Time = .5}
			{Alpha = 0	Time = 1}
			]
}


Panel_Message_CompSkaterPlace = {
	Font = "large.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,230)	Alpha = 0	Scale = 0	Time = 0}
			{Pos = (320,230)	Alpha = 64	Scale = .75	Time = .15}
			{Pos = (320,230)	Alpha = 128	Scale = 1.25	Time = .25}
			{Time = 10}
			{Alpha = 128	Time = 0}
			{Alpha = 64	Time = .15}
			{Alpha = 0	Time = .25}
			]
}


Panel_Message_CompSkaterName = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,260)	Alpha = 0	Scale = 0	Time = 0}
			{Pos = (320,260)	Alpha = 64	Scale = .75	Time = .15}
			{Pos = (320,260)	Alpha = 128	Scale = 1.25	Time = .25}
			{Time = 10}
			{Alpha = 128	Time = 0}
			{Alpha = 64	Time = .15}
			{Alpha = 0	Time = .25}
			]
}


Panel_Message_CompRule_List01 = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,170)	Alpha = 0	Scale = 0	Time = 0}
			{Alpha = 64	Scale = .25	Time = .25}
			{Alpha = 128	Scale = .65	Time = .5}
			{Time = 4.5}
			{Alpha = 128	Time = 0}
			{Alpha = 64	Time = .25}
			{Alpha = 0	Time = .5}
			]
}


Panel_Message_CompRule_List02 = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,200)	Alpha = 0	Scale = 0	Time = 0}
			{Alpha = 64	Scale = .25	Time = .25}
			{Alpha = 128	Scale = .65	Time = .5}
			{Time = 4.5}
			{Alpha = 128	Time = 0}
			{Alpha = 64	Time = .25}
			{Alpha = 0	Time = .5}
			]
}


Panel_Message_CompRule_List03 = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,230)	Alpha = 0	Scale = 0	Time = 0}
			{Alpha = 64	Scale = .25	Time = .25}
			{Alpha = 128	Scale = .65	Time = .5}
			{Time = 4.5}
			{Alpha = 128	Time = 0}
			{Alpha = 64	Time = .25}
			{Alpha = 0	Time = .5}
			]
}


Panel_Message_CompRule_List04 = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,270)	Alpha = 0	Scale = 0	Time = 0}
			{Alpha = 64	Scale = .25	Time = .25}
			{Alpha = 128	Scale = .65	Time = .5}
			{Time = 4.5}
			{Alpha = 128	Time = 0}
			{Alpha = 64	Time = .25}
			{Alpha = 0	Time = .5}
			]
}


Panel_Message_CompRule_List05 = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,310)	Alpha = 0	Scale = 0	Time = 0}
			{Alpha = 64	Scale = .25	Time = .25}
			{Alpha = 128	Scale = .65	Time = .5}
			{Time = 4.5}
			{Alpha = 128	Time = 0}
			{Alpha = 64	Time = .25}
			{Alpha = 0	Time = .5}
			]
}


Panel_Message_XMessage = {
	Font = "large.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points =	[
			{Pos = (330,410) Alpha = 128 Scale = 1.25 Time = 0}
			{Time = .75}
			{Alpha = 0 Time = 0}
			]
}


Panel_Message_CompCongrats = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,224)	Alpha = 0	Scale = 0	Time = 0}
			{Pos = (320,224)	Alpha = 64	Scale = .75	Time = .15}
			{Pos = (320,224)	Alpha = 128	Scale = 1.15	Time = .25}
			{Time = 10}
			{Alpha = 128	Time = .25}
			{Alpha = 64	Time = .15}
			{Alpha = 0	Time = 0}
			]
}
*/
