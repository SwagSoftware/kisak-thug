/*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; judges.q - handles display of the judges screen


judge_default_box_props = {
    box_color = { (40,40,40) alpha = 100}
    box_pos_rel = (-6,-1)
    box_w = 180
    box_h = 23
}                 


judge_default2_box_props = {
    box_color = { (0,0,0) alpha = 100}
    box_pos_rel = (0,-1)
    box_w = 110
    box_h = 30
}                 


judge_left_box_props = {
    judge_default_box_props
    box_w = 110
}      




judge_right_box_props = {
    judge_default_box_props
    box_w = 110     
}



judge_top_box_props  = {
    judge_default2_box_props
    box_w = 260
    box_h = 33
    
    box_pos_rel = (-6,-1)
}


judge_font_props={
    font="Small.fnt"
    just=(0,0)
    dims=(640,448)
    colors=[
        {(128,128,148) alpha=128}
    ]
 key_points=[
  {pos=(320,0) alpha=0 scale=1.25 time=0}
  {alpha=128 scale=1.25 time=1.4}
  {time=10000000}
    ]
}

judge_font2_props={
    font="title.fnt"
    just=(0,0)
    dims=(640,448)
    colors=[
        {(128,128,128) alpha=128}
    ]
 key_points=[
  {pos=(320,0) alpha=0 scale=1.0 time=0}
  {alpha=128 scale=1.0 time=1.4}
  {time=10000000}
    ]
}
 
  
judge_fade_props={
 judge_font_props
 key_points=[
  {pos=(320,0) alpha=128 scale=1.25 time=0}
  {alpha=8 scale=1.25 time=1.5}
  {time=1000000}
    ]
}

judge_fade={
    key_points=[
        {alpha = 192 time = 0.2}
        {alpha = 16 time = 1.0}
        {time = 1000000}        
    ]
}

judge_pulse={
    key_points=[
        {alpha = 200 scale = 1.35 time = .2}
        {alpha = 128 scale = 1.25 time = .4}
        {time = 1000000}
    ]
}

judge_pulsex={
    key_points=[
        {alpha = 200 time = .2}
        {alpha = 64 time = .4}
        {time = 1000000}
    ]
}



judge_clear={key_points=[ {alpha = 0 time = 0.2}]}

script clear_judge_line 
    ChangeLocalMessage  <...> judge_clear
endscript

script  new_judge_screen_gameflow
    PauseMusic 1 
    spawnskaterscript new_judge_screen_gameflow_task
endscript

script  KillLocalMessage
    ChangeLocalMessage  <...> {key_points=[ {alpha = 0 time = 0.2}]}
endscript

; either pulse or fade the two messsages specified
; depending on if it is one of the top three judges or not
; also waits 0.2 seconds
script judge_effect
    if IsTopJudge <judge>
        ChangeLocalMessage  id=<id1> judge_pulse
        ChangeLocalMessage  id=<id2> judge_pulse
    else
        ChangeLocalMessage  id=<id1> judge_fade
        ChangeLocalMessage  id=<id2> judge_fade
    endif    
    wait   0.2 seconds
endscript

// Note:  note quite as neat as it could be,  I need to tighten up on the repitition
script new_judge_screen_gameflow_task
    printf "here we are in new_judge_screen_gameflow_task"	
	
	// we're going to call a skater script that will put the skater in the proper spot
	// and play the right camera animation. But this is different for each level so:
			If CareerLevelIs LevelNum_Rio
				CompEndRun RioCompParams 
			EndIf
			If CareerLevelIs LevelNum_SkaterIsland 
				CompEndRun SICompParams
			EndIf
			If CareerLevelIs LevelNum_Tokyo 
				CompEndRun TokCompParams
			EndIf   
	if RoundIs 1
     // LaunchLocalMessage  id=judge_title_heat "Heat 1 Over", judge_font2_props, base_pos = (0,80), judge_top_box_props
    endif
    if RoundIs 2
     // LaunchLocalMessage  id=judge_title_heat "Heat 2 Over", judge_font2_props, base_pos = (0,80), judge_top_box_props
    endif
    if RoundIs 3
     // LaunchLocalMessage  id=judge_title_heat "Heat 3 Over", judge_font2_props, base_pos = (0,80), judge_top_box_props
    endif
    wait   0.2 seconds

    // LaunchLocalMessage  id=judge_title_judge "Judge" judge_font_props base_pos = (-20,120) just = (1,0) judge_left_box_props
    // LaunchLocalMessage  id=judge_title_score "Score" judge_font_props base_pos = (20,120) just = (-1,0) judge_left_box_props
    wait   0.2 seconds
    
    // LaunchLocalMessage  id=judge_line1 0 judge_font_props base_pos = (-20,160) just = (1,0) judge_left_box_props
    // LaunchLocalMessage  id=judge_line2 1 judge_font_props base_pos = (20,160) just = (-1,0) judge_left_box_props
    wait   0.2 seconds
    
    // LaunchLocalMessage  id=judge_line3 2 judge_font_props base_pos = (-20,185) just = (1,0) judge_left_box_props
    // LaunchLocalMessage  id=judge_line4 3 judge_font_props base_pos = (20,185) just = (-1,0) judge_left_box_props
    wait   0.2 seconds
    
    // LaunchLocalMessage  id=judge_line5 4 judge_font_props base_pos = (-20,210) just = (1,0) judge_left_box_props
    // LaunchLocalMessage  id=judge_line6 5 judge_font_props base_pos = (20,210) just = (-1,0) judge_left_box_props
    wait   0.2 seconds
    
    // LaunchLocalMessage  id=judge_line7 6 judge_font_props base_pos = (-20,235) just = (1,0) judge_left_box_props
    // LaunchLocalMessage  id=judge_line8 7 judge_font_props base_pos = (20,235) just = (-1,0) judge_left_box_props
    wait   0.2 seconds
    
    // LaunchLocalMessage  id=judge_line9 8 judge_font_props base_pos = (-20,260) just = (1,0) judge_left_box_props
    // LaunchLocalMessage  id=judge_line10 9 judge_font_props base_pos = (20,260) just = (-1,0) judge_left_box_props
    
    wait   0.5 seconds

// pulse and fade the high and low judges
    Judge_effect        id1 = judge_line1 id2=judge_line2 judge = 0
    Judge_effect        id1 = judge_line3 id2=judge_line4 judge = 1
    Judge_effect        id1 = judge_line5 id2=judge_line6 judge = 2
    Judge_effect        id1 = judge_line7 id2=judge_line8 judge = 3
    Judge_effect        id1 = judge_line9 id2=judge_line10 judge = 4


// display the total judge scores
    // LaunchLocalMessage  id=judge_line11 "Score" judge_font_props base_pos = (-20,330) just = (1,0) judge_left_box_props
    // LaunchLocalMessage  id=judge_line12 10 judge_font_props base_pos = (20,330) just = (-1,0) judge_left_box_props

    ChangeLocalMessage  id=judge_line11 judge_pulse
    ChangeLocalMessage  id=judge_line12 judge_pulse


    


//    LaunchLocalMessage  id=judge_press_x "Press ¬ to continue" judge_font_props base_pos = (0,380) just = (0,0)
    
//CR CR CR CR
// After we put up all the judges stuff then we wait for you to continue	
        // LaunchLocalMessage id=BottomInfo "Press ¬ to Continue" panel_message_XtoContinue
//        WaitForControllerPressedX
        // LaunchLocalMessage id=BottomInfo " " panel_message_XtoContinue
//	SpawnScript Comp_BlinkXContinue
//		Begin
//		    If Held X
//			Break
//		    EndIf
//		    Wait 1 GameFrames
//		Repeat
//	KillSpawnedScript Name = Comp_BlinkXContinue
	// Next we kill all these panel messages and move on to the next part of the game flow
//END CR END CR
    
    clear_judge_line  id=judge_title_heat  
    wait 0.04 seconds
    clear_judge_line  id=judge_title_judge  
    wait 0.04 seconds
    clear_judge_line  id=judge_title_score  
    wait 0.04 seconds
    clear_judge_line  id=judge_line1  
    wait 0.04 seconds
    clear_judge_line  id=judge_line2  
    wait 0.04 seconds
    clear_judge_line  id=judge_line3  
    wait 0.04 seconds
    clear_judge_line  id=judge_line4  
    wait 0.04 seconds
    clear_judge_line  id=judge_line5  
    wait 0.04 seconds
    clear_judge_line  id=judge_line6  
    wait 0.04 seconds
    clear_judge_line  id=judge_line7  
    wait 0.04 seconds
    clear_judge_line  id=judge_line8  
    wait 0.04 seconds
    clear_judge_line  id=judge_line9  
    wait 0.04 seconds
    clear_judge_line  id=judge_line10  
    wait 0.04 seconds       
    clear_judge_line  id=judge_line11  
    wait 0.04 seconds       
    clear_judge_line  id=judge_line12  
    wait 0.04 seconds       
    
    
    wait 0.25 seconds                   // enough time for final line to clear
    
    unpause_game_flow
endscript        


script Judge_BlinkXMessage
    begin    
        ChangeLocalMessage  id=judge_press_x judge_pulsex
        wait 2 seconds
    repeat
endscript
    
                   
script  leader_screen_gameflow
    spawnskaterscript leader_screen_gameflow_task
//CR CR CR CR
	If CareerLevelIs LevelNum_Rio
		CompEndRun_Leaders RioCompParams 
	EndIf
	If CareerLevelIs LevelNum_SkaterIsland 
		CompEndRun_Leaders SICompParams
	EndIf
	If CareerLevelIs LevelNum_Tokyo 
		CompEndRun_Leaders TokCompParams
	EndIf   
//END CR END CR
endscript


leader_default_box_props = {
    box_color = { (40,40,40) alpha = 100}
    box_pos_rel = (0,-1)
    box_w = 270
    box_h = 18
}


leader_box_1_props = {
    leader_default_box_props
    box_pos_rel = (-8,-1)
    box_w = 250     
	truncation_width = 240
}

leader_box_2_props = {
    leader_default_box_props
    box_pos_rel = (-4,-1)
    box_w = 68    
}




leader_top_box_props  = {
    leader_default_box_props
    box_w = 390
    box_pos_rel = (-8,-1)
}


leader_font_props={
    font="small.fnt"
    just=(0,0)
    dims=(640,448)
    colors=[
        {(128,128,128) alpha=128}    ; all other players
        {(128,128,0) alpha=128}      ; our skater line
        {(32,32,32) alpha=128}     ; low score, all other players
        {(32,32,0) alpha=128}      ; low score, our skater line
    ]
 key_points=[
  {pos=(0,0) alpha=0 scale=1.0 time=0}
  {alpha=128 time=1.4}
  {time=10000000}
    ]
}


;    LaunchLocalMessage  id=leader_1_1 12 leader_font_props base_pos = (50,100) just = (-1,0) leader_box_1_props
;    LaunchLocalMessage  id=leader_1_2 13 leader_font_props base_pos = (250,100) just = (-1,0) leader_box_2_props
;    LaunchLocalMessage  id=leader_1_3 14 leader_font_props base_pos = (350,100) just = (-1,0) leader_box_2_props
;    LaunchLocalMessage  id=leader_1_4 15 leader_font_props base_pos = (450,100) just = (-1,0) leader_box_2_props
;    LaunchLocalMessage  id=leader_1_5 16 leader_font_props base_pos = (550,100) just = (-1,0) leader_box_2_props

script leader_line
    // LaunchLocalMessage  id=<id1> <n1> leader_font_props base_x = 40  base_y = <line_y> just = (-1,0) leader_box_1_props
    // LaunchLocalMessage  id=<id2> <n2> leader_font_props base_x = 295 base_y = <line_y> just = (-1,0) leader_box_2_props
    // LaunchLocalMessage  id=<id3> <n3> leader_font_props base_x = 365 base_y = <line_y> just = (-1,0) leader_box_2_props
    // LaunchLocalMessage  id=<id4> <n4> leader_font_props base_x = 435 base_y = <line_y> just = (-1,0) leader_box_2_props
    // LaunchLocalMessage  id=<id5> <n5> leader_font_props base_x = 525 base_y = <line_y> just = (-1,0) leader_box_2_props
    wait   0.1 seconds
endscript


script leader_screen_gameflow_task
    printf "xx "

    leader_line   id1=lead_1_1 id2=lead_1_2 id3=lead_1_3 id4=lead_1_4 id5=lead_1_5 n1=12 n2=13 n3=14 n4=15 n5=16 line_y = 100
    leader_line   id1=lead_2_1 id2=lead_2_2 id3=lead_2_3 id4=lead_2_4 id5=lead_2_5 n1=17 n2=18 n3=19 n4=20 n5=21 line_y = 120
    leader_line   id1=lead_3_1 id2=lead_3_2 id3=lead_3_3 id4=lead_3_4 id5=lead_3_5 n1=22 n2=23 n3=24 n4=25 n5=26 line_y = 140
    leader_line   id1=lead_4_1 id2=lead_4_2 id3=lead_4_3 id4=lead_4_4 id5=lead_4_5 n1=27 n2=28 n3=29 n4=30 n5=31 line_y = 160
    leader_line   id1=lead_5_1 id2=lead_5_2 id3=lead_5_3 id4=lead_5_4 id5=lead_5_5 n1=32 n2=33 n3=34 n4=35 n5=36 line_y = 180
    leader_line   id1=lead_6_1 id2=lead_6_2 id3=lead_6_3 id4=lead_6_4 id5=lead_6_5 n1=37 n2=38 n3=39 n4=40 n5=41 line_y = 200
    leader_line   id1=lead_7_1 id2=lead_7_2 id3=lead_7_3 id4=lead_7_4 id5=lead_7_5 n1=42 n2=43 n3=44 n4=45 n5=46 line_y = 220
    leader_line   id1=lead_8_1 id2=lead_8_2 id3=lead_8_3 id4=lead_8_4 id5=lead_8_5 n1=47 n2=48 n3=49 n4=50 n5=51 line_y = 240
    
//CR CR CR CR
	If PlaceIs 1
		MakeSkaterGoTo SkaterJudgedAnims_Good
	Else
		If PlaceIs 2
			MakeSkaterGoTo SkaterJudgedAnims_Average
		Else
			If PlaceIs 3
				MakeSkaterGoTo SkaterJudgedAnims_Average
			Else
				MakeSkaterGoTo SkaterJudgedAnims_Poor
			EndIf
		EndIf
	EndIf
//END CR END CR
    
//    x_cont

//CR CR CR CR        
        // LaunchLocalMessage id=BottomInfo "Press ¬ to Continue" panel_message_XtoContinue
//        WaitForControllerPressedX
        // LaunchLocalMessage id=BottomInfo " " panel_message_XtoContinue
//	SpawnScript Comp_BlinkXContinue
//		Begin
//		    If Held X
//			Break
//		    EndIf
//		    Wait 1 GameFrames
//		Repeat
//	KillSpawnedScript Name = Comp_BlinkXContinue
//END CR END CR

    killlocalmessage id=lead_1_1
    killlocalmessage id=lead_1_2
    killlocalmessage id=lead_1_3
    killlocalmessage id=lead_1_4
    killlocalmessage id=lead_1_5

    wait 0.03 seconds

    killlocalmessage id=lead_2_1
    killlocalmessage id=lead_2_2
    killlocalmessage id=lead_2_3
    killlocalmessage id=lead_2_4
    killlocalmessage id=lead_2_5
    wait 0.03 seconds

    killlocalmessage id=lead_3_1
    killlocalmessage id=lead_3_2
    killlocalmessage id=lead_3_3
    killlocalmessage id=lead_3_4
    killlocalmessage id=lead_3_5
    wait 0.03 seconds

    killlocalmessage id=lead_4_1
    killlocalmessage id=lead_4_2
    killlocalmessage id=lead_4_3
    killlocalmessage id=lead_4_4
    killlocalmessage id=lead_4_5
    wait 0.03 seconds

    killlocalmessage id=lead_5_1
    killlocalmessage id=lead_5_2
    killlocalmessage id=lead_5_3
    killlocalmessage id=lead_5_4
    killlocalmessage id=lead_5_5
    wait 0.03 seconds

    killlocalmessage id=lead_6_1
    killlocalmessage id=lead_6_2
    killlocalmessage id=lead_6_3
    killlocalmessage id=lead_6_4
    killlocalmessage id=lead_6_5
    wait 0.03 seconds

    killlocalmessage id=lead_7_1
    killlocalmessage id=lead_7_2
    killlocalmessage id=lead_7_3
    killlocalmessage id=lead_7_4
    killlocalmessage id=lead_7_5
    wait 0.03 seconds

    killlocalmessage id=lead_8_1
    killlocalmessage id=lead_8_2
    killlocalmessage id=lead_8_3
    killlocalmessage id=lead_8_4
    killlocalmessage id=lead_8_5
    wait 0.03 seconds
    
    wait 0.3 seconds

//CR CR CR CR
	If CareerLevelIs LevelNum_Rio
		CompEndRun_LeadersDone RioCompParams 
	EndIf
	If CareerLevelIs LevelNum_SkaterIsland 
		CompEndRun_LeadersDone SICompParams
	EndIf
	If CareerLevelIs LevelNum_Tokyo 
		CompEndRun_LeadersDone TokCompParams
	EndIf   
	UnPause_Game_Flow
//END CR END CR
	
endscript

script  x_cont
    // LaunchLocalMessage  id=judge_press_x "Press ¬ to continue" judge_font_props base_pos = (0,380) just = (0,0)
    SpawnScript Judge_BlinkXMessage			
        Begin
            If Held X
                Break
            EndIf
            Wait 1 GameFrames
        Repeat
    KillSpawnedScript Name = Judge_BlinkXMessage
    unpause_game_flow
endscript


script placing_screen
;;    spawnskaterscript placing_task
       AttachToSkater                // start running the script on the skater
;;endscript
;;
;;Script Placing_Task
//CR CR CR CR
	If PlaceIs 1
		If CareerLevelIs LevelNum_Rio 
			CompEndSequence_1st RioCompParams
		EndIf
		If CareerLevelIs LevelNum_SkaterIsland 
			CompEndSequence_1st SICompParams
		EndIf
		If CareerLevelIs LevelNum_Tokyo 
			CompEndSequence_1st TokCompParams
		EndIf
	Else    
		If PlaceIs 2
			If CareerLevelIs LevelNum_Rio 
				CompEndSequence_2nd RioCompParams
			EndIf
			If CareerLevelIs LevelNum_SkaterIsland 
				CompEndSequence_2nd SICompParams
			EndIf
			If CareerLevelIs LevelNum_Tokyo 
				CompEndSequence_2nd TokCompParams
			EndIf
		Else
			If PlaceIs 3
				If CareerLevelIs LevelNum_Rio 
					CompEndSequence_3rd RioCompParams
				EndIf
				If CareerLevelIs LevelNum_SkaterIsland 
					CompEndSequence_3rd SICompParams
				EndIf
				If CareerLevelIs LevelNum_Tokyo 
					CompEndSequence_3rd TokCompParams
				EndIf
                        Else
				If CareerLevelIs LevelNum_Rio 
					CompEndSequence_Lose RioCompParams
				EndIf
				If CareerLevelIs LevelNum_SkaterIsland 
					CompEndSequence_Lose SICompParams
				EndIf
				If CareerLevelIs LevelNum_Tokyo 
					CompEndSequence_Lose TokCompParams
				EndIf
			EndIf
		EndIf
	EndIf
//        // LaunchLocalMessage id=BottomInfo "Press ¬ to Continue" panel_message_XtoContinue
//        WaitForControllerPressedX
//        LaunchLocalMessage id=BottomInfo " " panel_message_XtoContinue
//		SpawnScript Comp_BlinkXContinue
//			Begin
//			    If Held X
//				Break
//			    EndIf
//			    Wait 1 GameFrames
//			Repeat
 //   KillSpawnedScript Name = Comp_BlinkXContinue
    Kill Prefix = "TRG_Ped_End"
    Create Prefix = "TRG_Ped_Norm"
    AttachToSkater End          // unlink this script from the skater
    UnPause_Game_Flow	
//END CR END CR    
EndScript
    
    

*/
