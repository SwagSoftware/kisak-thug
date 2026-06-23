/*

; ****************************************************************************
; A sample script that sends out messages that pop up in the game window, or
; messages that appear in either text console
; ****************************************************************************

script firemessages

; goes on the left side
;LaunchConsoleMessage "scrolling console message"
;; goes on the right side
;LaunchConsoleMessage "fixed console message" 0
;; goes on the right side
;LaunchConsoleMessage "some other info" 1
;LaunchPanelMessage "Pop up message"
;
;Wait 10 seconds
;LaunchConsoleMessage "ship it"
;; you can also pass an array of strings
;LaunchPanelMessage ["AAAA BBBB CCCC DDDD" "EEEE FFFF GGGG HHHH" "IIII JJJJ KKKK LLLL" "MMMM NNNN OOOO PPPP"]
;
;Wait 10 seconds
;LaunchConsoleMessage "Skate Nam"
;LaunchPanelMessage "Cat Scratch Fever"
;
;Wait 10 seconds
;LaunchConsoleMessage "another message"
;LaunchPanelMessage "Collect &c1five&c0 children| and bring them to the truck" properties=panel_message_prop1
;
//LaunchPanelMessage "hello one" properties=panel_message_prop1
//Wait 2 seconds
//LaunchPanelMessage "hello two" properties=panel_message_prop1
//Wait 2 seconds
//LaunchPanelMessage "hello three" properties=panelcombo

//Wait 30 seconds

endscript



panel_message_prop1={
        font="large.fnt"
        just=(0,0)
        dims=(320,112)
        colors=[
                {(128,128,128) alpha=128}
                {(0,128,128) alpha=150}
                {(128,128,0) alpha=150}
        ]
        key_points=[
                {pos=(820,224) alpha=0 scale=.5 time=0}
                {pos=(320,224) alpha=128 time=.5}
                {scale=1 time=1}
                {time=6}
                {scale=.5 time=6.5}
                {pos=(820,224) alpha=0 time=7}
        ]
}

// dammit, you wanted control, you GET control :)
panelcombo={
        font="small.fnt"
        just=(0,0)
        dims=(5,5)
        colors=[
                {(255,245,0) alpha=128}
				{(110,20,20) alpha = 255 }
		]
        key_points=[
				{pos=(100,250) alpha=0 scale=0 time=0}
				{scale=1.05 alpha=90 time=.5}
                {time=1}
                {alpha=0 time=2}
        ]
}

panelcombo_scale =
{
	key_points=[
				{pos=(100,250) alpha=0 scale=0 time=0}
				{scale=1 alpha=90 time=.5}
                {time=1}
                {alpha=0 scale=2 time=1.25}
			]
}

panelcombo2={
        font="small.fnt"
        just=(0,0)
        dims=(5,5)
        colors=[
                {(255,245,0) alpha=128}
				{(110,20,20) alpha = 255 }
		]
        key_points=[
				{pos=(100,280) alpha=0 scale=0 time=0}
				{scale=1 alpha=90 time=.5}
                {time=1}
                {alpha=0 scale=1 time=2}
        ]
}


*/
