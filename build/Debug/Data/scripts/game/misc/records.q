/*statistics_title_props = {
	Font = "title.fnt"
	Just = (0,0)
	Dims = (600,112)
	Colors = [ {(128,128,128) Alpha = 128} ]
	Key_Points = 	[
			{Pos = (320,50)	Alpha = 128	Scale = 1.24	Time = 0}
			{Time = 1000000000}
			]
}


statistics_default_box_props = {
    box_color = { (40,40,40) alpha = 100}
    box_pos_rel = (0,-1)
    box_w = 270
    box_h = 18
}


statistics_box_1_props = {
    statistics_default_box_props
    box_pos_rel = (-8,-1)
    box_w = 180
}

statistics_box_2_props = {
    statistics_default_box_props
    box_pos_rel = (-4,-1)
    box_w = 268
}





statistics_top_box_props  = {
    statistics_default_box_props
    box_w = 390
    box_pos_rel = (-8,-1)
}


statistics_font_props={
    font="small.fnt"
    just=(0,0)
    dims=(640,448)
    colors=[
        {(128,128,128) alpha=128}
        {(128,128,0) alpha=128}
    ]
 key_points=[
  {pos=(0,0) alpha=0 scale=1.0 time=0}
  {alpha=128 time=0}            // time = 1.4
  {time=10000000}
    ]
}



statistics_left_x = 100
statistics_mid_x =  300
statistics_combo_x =  60

statistics_box_3_props = {
    statistics_default_box_props
    box_pos_rel = (-4,-1)
    box_w = 550
}



script statistics_line
    // LaunchLocalMessage  id=<id1> <n1> statistics_font_props base_x = 40  base_y = <line_y> just = (-1,0) statistics_box_1_props
    // LaunchLocalMessage  id=<id2> <n2> statistics_font_props base_x = 300 base_y = <line_y> just = (-1,0) statistics_box_2_props
    // LaunchLocalMessage  id=<id3> <n3> statistics_font_props base_x = 365 base_y = <line_y> just = (-1,0) statistics_box_2_props
;    LaunchLocalMessage  id=<id4> <n4> statistics_font_props base_x = 435 base_y = <line_y> just = (-1,0) statistics_box_2_props
;    LaunchLocalMessage  id=<id5> <n5> statistics_font_props base_x = 525 base_y = <line_y> just = (-1,0) statistics_box_2_props
    wait   0.1 seconds
endscript


script statistics_display
    // LaunchLocalMessage  id = StatisticsTitle "Statistics" statistics_title_props

    // LaunchLocalMessage id = rec01 "Total Score:" statistics_font_props base_x = statistics_left_x base_y = 100 just = (-1,0) statistics_box_1_props
    // LaunchLocalMessage  id = rec02 0 statistics_font_props  base_x = statistics_mid_x  base_y = 100 just = (-1,0) statistics_box_2_props

    // LaunchLocalMessage id = rec11 "High Score:" statistics_font_props base_x = statistics_left_x base_y = 120 just = (-1,0) statistics_box_1_props
    // LaunchLocalMessage  id = rec12 1 statistics_font_props  base_x = statistics_mid_x            base_y = 120 just = (-1,0) statistics_box_2_props

    // LaunchLocalMessage id = rec21 "Longest Grind:" statistics_font_props base_x = statistics_left_x  base_y = 140 just = (-1,0) statistics_box_1_props
    // LaunchLocalMessage  id = rec22 2 statistics_font_props  base_x = statistics_mid_x                base_y = 140 just = (-1,0) statistics_box_2_props

    // LaunchLocalMessage id = rec31 "Longest Manual:" statistics_font_props base_x = statistics_left_x base_y = 160 just = (-1,0) statistics_box_1_props
    // LaunchLocalMessage  id = rec32 3 statistics_font_props  base_x = statistics_mid_x                base_y = 160 just = (-1,0) statistics_box_2_props

    // LaunchLocalMessage id = rec41 "Longest Lip:" statistics_font_props base_x = statistics_left_x    base_y = 180 just = (-1,0) statistics_box_1_props
    // LaunchLocalMessage  id = rec42 4 statistics_font_props  base_x = statistics_mid_x                base_y = 180 just = (-1,0) statistics_box_2_props


    // LaunchLocalMessage id = rec51 "Longest Combo:" statistics_font_props base_x = statistics_left_x base_y = 200 just = (-1,0) statistics_box_1_props
    // LaunchLocalMessage  id = rec52 5 statistics_font_props  base_x = statistics_mid_x                base_y = 200 just = (-1,0) statistics_box_2_props

    // LaunchLocalMessage id = rec61 "Best Combo:" statistics_font_props base_x = statistics_left_x    base_y = 220 just = (-1,0) statistics_box_1_props
    // LaunchLocalMessage  id = rec62 6 statistics_font_props  base_x = statistics_mid_x                base_y = 220 just = (-1,0) statistics_box_2_props


    // LaunchLocalMessage  id = rec71 7 statistics_font_props  base_x = statistics_combo_x  base_y = 240 just = (-1,0) statistics_box_3_props
    // LaunchLocalMessage  id = rec81 8 statistics_font_props  base_x = statistics_combo_x  base_y = 260 just = (-1,0) statistics_box_3_props
    // LaunchLocalMessage  id = rec91 9 statistics_font_props  base_x = statistics_combo_x  base_y = 280 just = (-1,0) statistics_box_3_props
    // LaunchLocalMessage  id = rec101 10 statistics_font_props  base_x = statistics_combo_x  base_y = 300 just = (-1,0) statistics_box_3_props
    // LaunchLocalMessage  id = rec111 11 statistics_font_props  base_x = statistics_combo_x  base_y = 320 just = (-1,0) statistics_box_3_props
    // LaunchLocalMessage  id = rec121 12 statistics_font_props  base_x = statistics_combo_x  base_y = 340 just = (-1,0) statistics_box_3_props

//    statistics_line   id1=lead_1_1 id2=lead_1_2 id3=lead_1_3 id4=lead_1_4 id5=lead_1_5 n1=0 n2=1 n3=2 line_y = 100
//    statistics_line   id1=lead_2_1 id2=lead_2_2 id3=lead_2_3 id4=lead_2_4 id5=lead_2_5 n1=3 n2=4 n3=5 line_y = 120
endscript


record_font_props={
    statistics_font_props
    just = (-1,0)
}

record_title_props={
    statistics_title_props
}



records_col_1 = 90
records_col_2 = 180
records_col_3 = 285

combo_col_1 = 370
combo_col_2 = 460
combo_col_3 = 565

line_col_1 = 130
line_col_2 = 385
line_col_3 = 515



records_col_4 = 380

record_box_0_props = {
    statistics_default_box_props
    box_pos_rel = (-8,-1)
    box_w = 200
}


record_box_1_props = {
    statistics_default_box_props
    box_pos_rel = (-8,-1)
    box_w = 40
}

record_box_2_props = {
    statistics_default_box_props
    box_pos_rel = (-4,-1)
    box_w = 50
}

record_box_3_props = {
    record_box_2_props
    box_w = 100
}

record_box_4_props = {
    statistics_default_box_props
    record_box_2_props
    box_w = 55
}

record_box_5_props = {
    statistics_default_box_props
    record_box_2_props
    box_w = 55
}


script record_table_line
    // LaunchLocalMessage  id = <id1> <rank> record_font_props   base_x = records_col_1   just = (-1,0) record_box_1_props  <...>
    // LaunchLocalMessage  id = <id2> <n3>  record_font_props   base_x = records_col_2   just = (1,0) record_box_2_props  <...>
    // LaunchLocalMessage  id = <id3> <n1>  record_font_props   base_x = records_col_3   just = (1,0) record_box_3_props  <...>
//    launchlocalMessage  id = <id4> <n3>  record_font_props   base_x = records_col_4   just = (-1,0) record_box_3_props  <...>
endscript

script combo_table_line
    // LaunchLocalMessage  id = <id1> <rank> record_font_props   base_x = combo_col_1   just = (-1,0) record_box_1_props  <...>
    // LaunchLocalMessage  id = <id2> <n3>  record_font_props   base_x = combo_col_2   just = (1,0) record_box_2_props  <...>
    // LaunchLocalMessage  id = <id3> <n1>  record_font_props   base_x = combo_col_3   just = (1,0) record_box_3_props  <...>
//    launchlocalMessage  id = <id4> <n3>  record_font_props   base_x = records_col_4   just = (-1,0) record_box_3_props  <...>
endscript

script record_line x_col_1=line_col_1 x_col_2=line_col_2 x_col_3=line_col_3
    // LaunchLocalMessage  id = <id1> <text> record_font_props   base_x = <x_col_1>   just = (-1,0) record_box_0_props  <...>
    // LaunchLocalMessage  id = <id2> <n3>  record_font_props    base_x = <x_col_2>   just = (1,0) record_box_2_props  <...>
    // LaunchLocalMessage  id = <id3> <n1>  record_font_props    base_x = <x_col_3>   just = (1,0) record_box_3_props  <...> box_w = 125
//    launchlocalMessage  id = <id4> <n3>  record_font_props   base_x = records_col_4   just = (-1,0) record_box_3_props  <...>
endscript




script records_display x_col_1=line_col_1 x_col_2=line_col_2 x_col_3=line_col_3 Heading="Level Records"
    // LaunchLocalMessage  id = StatisticsTitle <Heading> record_title_props
    // LaunchLocalMessage id = rec01 "High Scores" record_font_props base_x = records_col_1 base_y = 100 just = (-1,0) record_box_0_props

    record_table_line   rank = "1st" id1 = r11 id2=r20 id3=r21 id4=r22 n1 = 20 n2 = 21 n3 = 22  base_y = 120
    record_table_line   rank = "2nd" id1 = r12 id2=r23 id3=r24 id4=r25 n1 = 23 n2 = 24 n3 = 25  base_y = 140
    record_table_line   rank = "3rd" id1 = r13 id2=r26 id3=r27 id4=r28 n1 = 26 n2 = 27 n3 = 28  base_y = 160
    record_table_line   rank = "4th" id1 = r14 id2=r29 id3=r30 id4=r31 n1 = 29 n2 = 30 n3 = 31  base_y = 180
    record_table_line   rank = "5th" id1 = r15 id2=r32 id3=r33 id4=r34 n1 = 32 n2 = 33 n3 = 34  base_y = 200

    // LaunchLocalMessage id = com01 "Best Combos" record_font_props base_x = combo_col_1 base_y = 100 just = (-1,0) record_box_0_props

    combo_table_line   rank = "1st" id1 = c11 id2=c20 id3=c21 id4=c22 n1 = 35 n2 = 36 n3 = 37  base_y = 120
    combo_table_line   rank = "2nd" id1 = c12 id2=c23 id3=c24 id4=c25 n1 = 38 n2 = 39 n3 = 40  base_y = 140
    combo_table_line   rank = "3rd" id1 = c13 id2=c26 id3=c27 id4=c28 n1 = 41 n2 = 42 n3 = 43  base_y = 160
    combo_table_line   rank = "4th" id1 = c14 id2=c29 id3=c30 id4=c31 n1 = 44 n2 = 45 n3 = 46  base_y = 180
    combo_table_line   rank = "5th" id1 = c15 id2=c32 id3=c33 id4=c34 n1 = 47 n2 = 48 n3 = 49  base_y = 200


    record_line   text = "Longest Grind:"  id1 = x15 id2=x32 id3=x37 id4=x34 n1 = 50 n2 = 51 n3 = 52  base_y = 240 x_col_1=<x_col_1> x_col_2=<x_col_2> x_col_3=<x_col_3>
    record_line   text = "Longest Manual:" id1 = x16 id2=x33 id3=x38 id4=x34 n1 = 53 n2 = 54 n3 = 55  base_y = 260 x_col_1=<x_col_1> x_col_2=<x_col_2> x_col_3=<x_col_3>
    record_line   text = "Longest Lip:"    id1 = x17 id2=x34 id3=x39 id4=x34 n1 = 56 n2 = 57 n3 = 58  base_y = 280 x_col_1=<x_col_1> x_col_2=<x_col_2> x_col_3=<x_col_3>
    record_line   text = "Longest Combo:"  id1 = x18 id2=x35 id3=x3a id4=x34 n1 = 59 n2 = 60 n3 = 61  base_y = 300 x_col_1=<x_col_1> x_col_2=<x_col_2> x_col_3=<x_col_3>
//    record_line   text = "Best Combo:"     id1 = x19 id2=x36 id3=x3b id4=x34 n1 = 62 n2 = 63 n3 = 64  base_y = 320


endscript



script  X_to_continue
		SpawnScript Comp_BlinkXContinue
			Begin
			    If Held X
				Break
			    EndIf
			    Wait 1 GameFrames
			Repeat
		KillSpawnedScript Name = Comp_BlinkXContinue
endscript

script stats_screen_task
        	debounce X time = 1.0
            statistics_display
            // LaunchLocalMessage id=BottomInfo "Press ¬ to Continue" panel_message_XtoContinue
//            WaitForControllerPressedX
            // LaunchLocalMessage id=BottomInfo " " panel_message_XtoContinue
//            x_to_continue
            unpausegameflow
endscript


script records_screen_task
        	debounce X time = 1.0
            records_display
            // LaunchLocalMessage id=BottomInfo "Press ¬ to Continue" panel_message_XtoContinue
//            WaitForControllerPressedX
            // LaunchLocalMessage id=BottomInfo " " panel_message_XtoContinue
//            x_to_continue
            unpausegameflow
endscript


script create_initials_keyboard
    DestroyElement id=initials_keyboard_control;
	CreateAndAttachMenu {
		type=keyboardcontrol id=initials_keyboard_control x=160.0 y=56.0 w=320.0 h=336.0
		just_center_x
		just_center_y
		num_columns = 13
		alphanumeric_charset
		min_chars = 1
		max_chars = 3
        kill_on_close
        default_to_accept
		title_string = "New Record.  Enter Initials"
		default_string = ""

		eventhandlers = [
			{
				type = showeventhandler
				target = "start_initials"
				params = { prefs=records field="initials" }
			}
			{
				type = contentschangedeventhandler
				target = "end_initials"
				params = { prefs=records field="initials" }
			}
			{
				type = showeventhandler
				target = "helper_on_keyboard_control_linear"
			}
		]

		parent=contain1
	}
endscript


script start_initials
    GetInitialsString
    printf <string>
    LaunchEvent type=SetContents target = initials_keyboard_control <...>
endscript

script end_initials
    printf "new initials"
    printf <string>
    SetInitialsString  string = <string>
    unpause_game_flow
endscript


script destroy_initials_keyboard

    DestroyElement id=initials_keyboard_control
endscript


script  new_record_screen
    create_initials_keyboard
    SwitchToMenu menu=initials_keyboard_control
    pause_game_flow
    // enter initials, then return to here...
    SwitchOffMenu id=initials_keyboard_control
endscript





script  statistics_screen
        printf ".......................statistics_screen"
        PauseGame
        KillMessages
        GetRecordText
        spawnskaterscript stats_screen_task
        pause_game_flow
        UnPauseGame

        KillMessages

        if NewRecord
            new_record_screen
            UpdateInitials
        endif


        Records_screen      // tacked on as a test

        KillMessages
endscript


script records_screen
        KillMessages
        GetRecordText
        PauseGame

        spawnskaterscript records_screen_task

        pause_game_flow
        UnPauseGame



        KillMessages
endscript


script records_test
        getrecordtext
        begin
            killmessages
            printf "hmm"
            records_display
            wait 1 gameframe
            wait .5 seconds
        repeat
endscript
*/
