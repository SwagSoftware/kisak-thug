; ==========================================================================
;
; Initialization scripts
;
; ==========================================================================



; This script is run once upon game initialization. It does setup for the pause menu.
;script new_screen_element_test

;ScreenElementSystemInit ; A script command that creates 'root_window', among other things

;LoadFont2 "small"
;LoadFont2 "small_test_1"
;LoadFont2 "small_test_2"
;LoadFont2 "small"


;SetScreenElementProps {
;        id=root_window
;        event_handlers=[
;		{pad_start			handle_start_pressed}
;	]
; Indicates state of paused menu. 4 possible values:
;	off 		-- menu not shown
;	entering	-- menu currently doing 'entrance' animation
;	on		-- menu onscreen, can be interacted with
;	leaving		-- menu currently doing 'exit' animation
;	tags={menu_state=off}
;}
; From here on, 'root_window' will always be in focus, allowing it to receive
;; button and pad events
;FireEvent type=focus target=root_window

;endscript




; run whenever 'start' is pressed
;script handle_start_pressed
;GetTags
;if ChecksumEquals a=<menu_state> b=on
;	; main menu fully onscreen, so make it go away
;	RunScriptOnScreenElement id=main_menu_anchor animate_out
;endif
;if ChecksumEquals a=<menu_state> b=off
;	; main menu fully offscreen, so make it appear
;	make_new_menu
;endif
;endscript
;
;


; ==========================================================================
;
; Creation scripts
;
; ==========================================================================

; Creates the components that make up the game menu, then runs a script to
; begin their 'entrance' animation
;script make_new_menu
;
;SetScreenElementLock id=root_window off
;
;CreateScreenElement {
;	type=ContainerElement parent=root_window
;        id=main_menu_anchor
;        pos=(320,224) just=[center center] scale=0
;        dims=(100,100)
;        focusable_child=main_menu
;}

;CreateScreenElement {
;	type=textelement parent=main_menu_anchor
;	font=small
;	text="Lovely Menu"
;        scale=1.25
;        rgba=[144 0 144 128]
;        just=[left top]
;}

;CreateScreenElement {
;        type=VMenu parent=main_menu_anchor
;        id=main_menu just=[left top]
;        pos=(0,20)
;}

;make_text_menu_item text="item one" id=menu_item1
;make_text_menu_item text="item two" id=menu_item2
;make_text_menu_item text="item three" id=menu_item3

; ---------------------------------------------
; FONT TEST STUFF FOR DANA

; set one -- bottom of screen

;CreateScreenElement {
;	type=ContainerElement
;	parent=root_window
;        id=font_test_anchor1
;        pos=(0,324)
;	just=[left top]
;        dims=(640,100)
;}

;CreateScreenElement {
;	type=textelement
;	parent=font_test_anchor1
;	font=small
;	text="Tony Hawks Pro Skater"
;        scale=1.0
;        rgba=[92 92 92 128]
;        just=[left top]
;	pos=(15,0)
;}

;CreateScreenElement {
;	type=textelement
;	parent=font_test_anchor1
;	font=small_test_1
;	text="A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
;        scale=1.0
;        rgba=[92 92 92 0]
;        just=[left top]
;	pos=(15,20)
;}

;CreateScreenElement {
;	type=textelement
;	parent=font_test_anchor1
;	font=small_test_1
;	text="a b c d e f g h i j k l m n o p q r s t u v w x y z"
;        scale=1.0
;        rgba=[92 92 92 0]
;        just=[left top]
;	pos=(15,40)
;}

;CreateScreenElement {
;	type=textelement
;	parent=font_test_anchor1
;	font=small_test_1
;	text="0 1 2 3 4 5 6 7 8 9 . , - ! ? : ' + / ^ ® ( ) * @ `"
;        scale=1.0
;        rgba=[92 92 92 0]
;        just=[left top]
;	pos=(15,60)
;}

;CreateScreenElement {
;	type=textelement
;	parent=font_test_anchor1
;	font=small_test_1
;;	text=" ¡ ¢ £ ¤ ¥ ¦ § ¨ © ª « ¬ { _ # $ % & \ = < > ß Ä Ü"
;        scale=1.0
;        rgba=[92 92 92 0]
;        just=[left top]
;	pos=(15,80)
;}

; set two -- top of screen

;CreateScreenElement {
;	type=ContainerElement
;	parent=root_window
;        id=font_test_anchor2
;        pos=(0,15)
;	just=[left top]
;        dims=(640,100)
;}

;CreateScreenElement {
;	type=textelement
;	parent=font_test_anchor2
;	font=small_test_2
;	text="ABCD EFGHI JKL MNOPQR"
;        scale=1.0
;        rgba=[92 92 92 128]
;        just=[left top]
;	pos=(15,240)
;}

;CreateScreenElement {
;	type=textelement
;	parent=font_test_anchor2
;	font=small_test_2
;	text="STUV WXYZa bcd efghij"
;        scale=1.0
;        rgba=[78 79 127 128]
;        just=[left top]
;	pos=(15,260)
;}

;CreateScreenElement {
;	type=textelement
;	parent=font_test_anchor2
;	font=small_test_2
;	text="klmn opqrs tuv wxyz01"
;        scale=1.0
;        rgba=[92 92 92 128]
;        just=[left top]
;	pos=(15,280)
;}

; END FONT TEST STUFF FOR DANA
; ---------------------------------------------

; now, do 'entrance' animation
; (Note: Any number of scripts can be running concurrently upon	a single screen element,
; so be wary about running the exact same script twice)
;RunScriptOnScreenElement id=main_menu_anchor animate_in
;endscript




; A handy helper script for creating text menu elements,
; gets run from above script
;script make_text_menu_item
;CreateScreenElement {
;	type=textelement parent=main_menu
;	id=<id>
;	font=small
;	text=<text>
;	rgba=[144 144 144 128]
;	event_handlers=[
;		{focus				do_scale_up}
;		{unfocus			do_scale_down}
;		{pad_x				item_chosen}
;	]
;}
;endscript




; ==========================================================================
;
; Animation scripts
;
; ==========================================================================

; performs the menu's 'entrance' animation
; gets run 'on' main_menu_anchor
;script animate_in
;SetScreenElementProps id=root_window tags={menu_state=entering}
; this SetProps call applies to main_menu_anchor, upon which
; this script will be run (though it would for any other
; element this script was run upon)
;;SetProps just=[left center]
;DoMorph time=0 scale=0.0 pos=(20,224)
; the script will pause for the .5 seconds it takes for the menu
; to change from scale=0.0 to scale=1.5
;DoMorph time=.5 scale=1.5
;DoMorph time=.35 scale=1.0
; focusing on main_menu_anchor will cause it to send a focus event to
; main_menu, which will then send a focus event to its selected child
; (this behavior is built into these elements)
;FireEvent type=focus target=main_menu_anchor
;SetScreenElementProps id=root_window tags={menu_state=on}
;endscript




; performs the menu's 'exit' animation
; gets run 'on' main_menu_anchor
;script animate_out
; ---------------------------------------------
; FONT TEST STUFF FOR DANA
;SetScreenElementLock id=root_window off
;DestroyScreenElement id=font_test_anchor1 recurse
;DestroyScreenElement id=font_test_anchor2 recurse
; END FONT TEST STUFF FOR DANA
; ---------------------------------------------
;SetScreenElementProps id=root_window tags={menu_state=leaving}
; see comment for focus above
;FireEvent type=unfocus target=main_menu
;SetProps just=[left center]
;DoMorph time=0 pos=(20,224) scale=1.0
; the next line is simply a test, of no practical value here
;FireEvent type=test_signal target=global
;DoMorph time=.35 scale=1.5
;DoMorph time=.5 scale=0.0
;SetScreenElementProps id=root_window tags={menu_state=off}
; Unlock the root menu. Unlocking a screen element allows you
; to add or remove children. Locking happens automatically
; on the next pass through game logic.
;SetScreenElementLock id=root_window off
; the 'recurse' keyword causes all the children (and their children, etc.)
; to be deleted, too.
; IMPORTANT: any commands that come after the next line won't be run,
; since the script will be deleted along with the screen element
; upon which it was run, instantly terminating its execution
;DestroyScreenElement id=main_menu_anchor recurse
;endscript




; ==========================================================================
;
; Event handling scripts
;
; ==========================================================================

; run on a text screen element in response to a focus event
; (see event handler table above)
;script do_scale_up
;SetProps rgba=[192 192 0 128]
;DoMorph time=.25 scale=1.5
;endscript



; run on a text screen element in response to an unfocus event
; (see event handler table above)
;script do_scale_down
;SetProps rgba=[144 144 144 128]
;DoMorph time=.25 scale=1.0
;endscript




;script item_chosen
; the 'callback' parameter specifies a secondary script to run as soon as the primary
; one terminates (or gets terminated, in this case)
;RunScriptOnScreenElement id=main_menu_anchor animate_out callback=make_new_menu
; next line is just a test, no practical value
;WaitForEvent type=test_signal
;endscript









