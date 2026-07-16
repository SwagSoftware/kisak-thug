/*Panel_Positions=[
        ; one player -- centered at 320, 224
        {       score={ (18,21,0) }   				; x,y, and z values of element            
                timer={ (320,25,0) just=(0,-1) } 	; justification, 0,0=center, -1,-1=upper left
                switch_icon={ (600,22,0) just=(0, -1) }                    
                balance_icon={ (320,120,0) just=(0,0) }                    
                manual_icon={ (240,224,0) just=(0,0) }
                special_icon=(5,40)         
        }
        ; two players -- split vertically -- centered at 160, 224
        {       score={ (18,20,0) }
                timer={ (310,20,0) just=(1,-1) }     
                switch_icon={ (290,44,0) just=(0, -1) }                    
                balance_icon={ (160,130,0) just=(0,0) }                    
                manual_icon={ (80,224,0) just=(0,0) }                    
                special_icon=(5,40)                    
        }
        ; two players -- split horizontally -- centered at 320, 112
        {       score={ (18,20,0) }
                timer={ (320,20,0) just=(0,-1) }     
                switch_icon={ (610,16,0) just=(0, -1) }                    
                balance_icon={ (320,60,0) just=(0,0) }                    
                manual_icon={ (240,112,0) just=(0,0) }                    
                special_icon=(5,40)                    
        }
        ; three-four players
        {       score={ (18,12,0) }
                timer={ (310,10,0) just=(1,-1) }     
                switch_icon={ (290,44,0) just=(0,-1) }                    
                balance_icon={ (160,18,0) just=(0,0) }                    
                manual_icon={ (80,112,0) just=(0,0) }                    
                special_icon=(5,40)                    
        }
        ; horse -- centered at 320, 224 (should be the same as one player)
        {       score={ (18,21,0) }   				; x,y, and z values of element
                timer={ (320,25,0) just=(0,-1) } 	; justification, 0,0=center, -1,-1=upper left
                switch_icon={ (600,22,0) just=(0,-1) }
                balance_icon={ (320,120,0) just=(0,0) }
                manual_icon={ (240,224,0) just=(0,0) }
                special_icon=(5,79)
				horse1={ (18,21,0) just=(0,-1) }     ; only really needed for horse mode	
				horse2={ (18,40,0) just=(0,-1) }     ; only really needed for horse mode	
				score_to_beat={ (18,59,0) just=(0,-1) }     ; only really needed for horse mode	
        }
]



; relative to center of balance sprite
;Balance_Arrow_Positions=[
;        (0,-24)   ; centered
;        (10,-24)
;        (20,-22)
;        (30,-18)
;        (40,-13)
;        (50,-6)
;        (60,5)    ; fully right
;]



Balance_Circle_Position=(61,11)



Special_Segments_Position=(0,0)



Panel_Text_Console={		  				; debug console
        num_lines=5
        indent={(18, 18, 0)}
        drawer=textconsole        
}


Trick_Text_Properties={
        Positions=[
                // one panel 
				{
					pos={ (320,390,0) just=(0,1) }	; position is for big window, will be scaled for smaller ones
					dims=(600,70)				; dimensions of trick text window, width and height
                }
                // two panels -- split vertically 
                {
					pos={ (160,390,0) just=(0,1) }	; position is for big window, will be scaled for smaller ones
					dims=(280,70)				; dimensions of trick text window, width and height
				}
				// two panels -- split horizontally
                {
					pos={ (320,194,0) just=(0,1) }	; position is for big window, will be scaled for smaller ones
					dims=(600,40)				; dimensions of trick text window, width and height
				}
				// three or four panels -- split into quadrants
                {
					pos={ (160,166,0) just=(0,1) }	; position is for big window, will be scaled for smaller ones
					dims=(280,70)				; dimensions of trick text window, width and height
				}
                // horse panel -- same as one player
				{
					pos={ (320,390,0) just=(0,1) }	; position is for big window, will be scaled for smaller ones
					dims=(600,70)				; dimensions of trick text window, width and height
                }
        ]
        drawer=trick_font			; see FrontEnd.q for trick_font properties

        between_line_spacing=4
        text_duration=20			; in tenths of a second
        scale = 1.0 				; base scale (overrides the scale specified for the font)
		max_scale = 1.2				; text pulses up to this size when trick added
        min_scale = .7				; text pulses up from this size
        pulse_rate_up = .05			; affects how fast text pulses up (change to scale)
        pulse_rate_down = .02                   ; affects how fast text pulses down
        
        falling_color = {(180,25,0) alpha=90}
		gap_text_color={(32,92,128) alpha=128}
		special_text_color={(128,92,32) alpha=128}
        
        score_drawer=trick_score_font	; ditto for score font
		
		score_pos_split_h={ (320,409,0) just=(0,0) }
        score_pos={ (320,400,0) just=(0,-1) }
}


message_prop_default={
        font="small.fnt"
        just=(0,0)
        dims=(320,112)
        colors=[
                {(128,128,128) alpha=128}
                {(255,245,0) alpha=128}
                {(195,20,20) alpha=128}		
        ]
        key_points=[
                {pos=(320,224) alpha=0 scale=1.0 time=0}
                {alpha=128 time=1.0}
                {time=4.0}
                {alpha=0 time=5.0}
        ]
}

script display_score_1
launchpanelmessage "1 %s0 |  &c1%s1" s0=<String0> s1=<String1> properties=score_display1
//createbox base_pos = (12,65) box_w=150 box_h=150 id=scorebox 
endscript

script display_score_2
launchpanelmessage "2 %s0 |  &c1%s1" s0=<String0> s1=<String1> properties=score_display2 
endscript

script display_score_3
launchpanelmessage "3 %s0 |  &c1%s1" s0=<String0> s1=<String1> properties=score_display3
endscript

script display_score_4
launchpanelmessage "4 %s0 |  &c1%s1" s0=<String0> s1=<String1> properties=score_display4
endscript

score_default_box_props = { 
    box_color = { (40,40,40) alpha = 100} 
    box_pos_rel = (0,-1) 
    box_w = 270 
    box_h = 23 
} 


// IMPORTANT. If any of these change, you should also change the s_player_colors is skater.cpp to match
netscore_colors = [
				{(140,110,40) alpha=128}  	//0 score orange				
				{(50,80,128) alpha=128}    	//1 nice light blue 				
				{(140,30,30) alpha=128 }     //2 red player in graffiti P1				
				{(60,60,150) alpha=128 }     //3 score blue player in graffiti P2
				{(150,150,0) alpha=128 }   //4 yellow player in graffiti P3
				{(0,120,40) alpha=128 }	//5 green player in graffiti P4
				{(80,80,80) alpha=128}  	//6 default gray
				]

score_display1={
        font="small.fnt"
        just=(-1,0)
        dims=(100,112)
        colors = netscore_colors
		key_points=[
                {pos=(16,78) alpha=128 scale=.85 time=0}
				{time = 2.1}
        ]
}

score_display2={
        font="small.fnt"
        just=(-1, 0)
        dims=(100,112)
        colors = netscore_colors
		key_points=[
                {pos=(16,108) alpha=128 scale=.85 time=0}
				{time = 2.1}
        ]
}

score_display3={
        font="small.fnt"
        just=(-1, 0)
        dims=(100,112)
        colors = netscore_colors
        key_points=[
                {pos=(16,138) alpha=128 scale=.85 time=0}
				{time = 2.1}
        ]
}

score_display4={
        font="small.fnt"
        just=(-1, 0)
        dims=(100,112)
        colors = netscore_colors
        key_points=[
                {pos=(16,168) alpha=128 scale=.85 time=0}
				{time = 2.1}
        ]
}
*/
