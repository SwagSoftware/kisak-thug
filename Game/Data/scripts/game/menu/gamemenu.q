
// start autoduck documentation
// @DOC gamemenu
// @module gamemenu | None
// @subindex Scripting Database
// @index script | gamemenu

; ==========================================================================
;
; Initialization scripts
;
; ==========================================================================

ALWAYSPLAYMUSIC=1
HIDEHUD=0
DEVKIT_LEVELS=1

/*
	What meta_button_map... means:

	Given the tag '\mX' (where X = some digit, 0-9 or a-f) in a
	piece of text, look up X in the comments on the right side
	of the table. Grab Y, the digit on the left side, and
	replace '\mX' with '\bY'. That's what the code will do.

	Note: the Y values are listed in decimal. They will be
	converted to hexidecimal when the '\bY' tag is outputted
	(e.g. 10 = A).
*/

meta_button_map_ps2=[
	// These are samples -- you find better ones
	3	// 0: Go (maps to '\b3')
	0	// 1: Back
	0	// 2: Back2?
	1	// 3: Left spin
	2	// 4: Right spin
	2	// 5: Talk to ped/pro
	1	// 6: Bio info (select skater screen)
	1	// 7: quick start goal
	2	// 8: space (keyboard)
	1	// 9: backspace (keyboard)
	14	// a: switch skitch nodes (left)
	15	// b: switch skitch nodes (right)
	0	// c: decline betting guy bet
	1	// d: delete save game
	2	// e: preview music track (circle) (pad_option)
	16	// f: shift (L2)
	17	// g: shift (R2)
	2	// h: space
	1	// i: backspace
	17	// j: spin on/off in CAT (pad_alt)
	17	// k: revert
	17	// l: spine transfer / acid drop
	18	// m: switch to walking
	16	// n: pad_alt2
	16	// o: recenter camera when walking
	16	// p: Toggle Pressure/Nollie (L2)
	0	// q: Undefined (maps to '\b0')
	0	// r: Undefined (maps to '\b0')
	0	// s: Undefined (maps to '\b0')
	0	// t: Undefined (maps to '\b0')
	0	// u: Undefined (maps to '\b0')
	0	// v: Undefined (maps to '\b0')
]


meta_button_map_gamecube=[
	// These are samples -- you find better ones
	3	// 0: Go (maps to '\b3')
	1	// 1: Back
	0	// 2: Back2?
	1	// 3: Left spin
	2	// 4: Right spin
	2	// 5: Talk to ped/pro
	1	// 6: Bio info (select skater screen)
	1	// 7: Quick start goal
	2	// 8: space (keyboard)
	0	// 9: backspace (keyboard)
	14	// a: switch skitch nodes (left)
	15	// b: switch skitch nodes (right)
	1	// c: decline betting guy bet
	2	// d: delete save game
	2	// e: preview music track (X) (pad_option)
	14	// f: shift (L)
	15	// g: shift (R)
	0	// h: Undefined (maps to '\b0')
	0	// i: Undefined (maps to '\b0')
	9	// j: spin on/off in CAT (pad_alt)
	15	// k: revert
	18	// l: spine transfer / acid drop
	9	// m: switch to walking
	2	// n: pad_alt2
	14	// o: recenter camera when walking
	14	// p: Toggle Pressure/Nollie (L2)
	0	// q: Undefined (maps to '\b0')
	0	// r: Undefined (maps to '\b0')
	0	// s: Undefined (maps to '\b0')
	0	// t: Undefined (maps to '\b0')
	0	// u: Undefined (maps to '\b0')
	0	// v: Undefined (maps to '\b0')
]


meta_button_map_xbox=[
	// These are samples -- you find better ones
	3	// 0: Go (maps to '\b3')
	2	// 1: Back
	0	// 2: Back2?
	1	// 3: Left spin
	2	// 4: Right spin
	2	// 5: Talk to ped/pro
	1	// 6: Bio info (select skater screen)
	1	// 7: quick start goal
	0	// 8: space (keyboard)
	1	// 9: backspace (keyboard)
	14	// a: switch skitch nodes (left)
	15	// b: switch skitch nodes (right)
	2	// c: decline betting guy bet
	1	// d: delete save game
	1	// e: preview music track (X) (pad_option)
	14	// f: shift (L)
	15	// g: shift (R)
	0	// h: Undefined (maps to '\b0')
	0	// i: Undefined (maps to '\b0')
	17	// j: spin on/off in CAT (pad_alt)
	15	// k: revert
	18	// l: spine transfer / acid drop
	17	// m: switch to walking
	16	// n: pad_alt2
	14	// o: recenter camera when walking
	14	// p: Toggle Pressure/Nollie (L2)
	0	// q: Undefined (maps to '\b0')
	0	// r: Undefined (maps to '\b0')
	0	// s: Undefined (maps to '\b0')
	0	// t: Undefined (maps to '\b0')
	0	// u: Undefined (maps to '\b0')
	0	// v: Undefined (maps to '\b0')
]


smallfont_colors=[
	[128 128 128 100] // entry 1, white
	[102 26 8 100] // entry 2, red
	[17 64 116 100] // entry 3, blue
	[9 107 36 100] // entry 4, green
	[123 99 3 100] // entry 5 yellow
	[0 128 128 100] // entry 6
	[128 0 128 100] // entry 7
	[30 50 80 100] // entry 8
	[88 105 112 128] // entry 9, standard gray/white
]

dialogfont_colors=[
	[88 105 112 128] // entry 1, normal gray/white
	[102 26 8 100] // entry 2, red
	[17 64 116 100] // entry 3, blue
	[9 107 36 100] // entry 4 green
	[123 99 3 100] // entry 5 yellow
	[127 102 0 100] // entry 6, highlight yellow color
	[100 100 128 100] // entry 7, goal ped talking color
]

; This script is run once upon game initialization. It does setup for the pause menu.
script new_screen_element_test
	PushMemProfile  "Fonts and Bitmaps"

	ScreenElementSystemInit ; A script command that creates 'root_window', among other things

	LoadLevelPreFile    "panelsprites.pre"

	FormatText ChecksumName=font_colors "%i_FONT_COLORS" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// commented out for time-being
	// LoadFont "large"
	// LoadFont "title"
	LoadFont "testtitle" char_spacing=-4.5 space_spacing=13
	LoadFont "newtrickfont" char_spacing=-1 space_spacing=14 color_tab=newtrickfont_colors
	LoadFont "small" char_spacing=-3.1 space_spacing=12 color_tab=<font_colors>	;color_tab=smallfont_colors
	LoadFont "newtimerfont" char_spacing=0.5
	LoadFont "dialog" char_spacing=-3.0 space_spacing=12 color_tab=<font_colors> ;color_tab=dialogfont_colors
	LoadFont buttons_font

	// Load_all_textures
	load_textures_to_main_memory
	;create_panel_stuff
	UnLoadPreFile    "panelsprites.pre" dont_assert

	setup_main_button_event_mappings

	SetScreenElementProps {
		id=root_window

		; Indicates state of paused menu. 4 possible values:
		;	off 		-- menu not shown
		;	entering	-- menu currently doing 'entrance' animation
		;	on		-- menu onscreen, can be interacted with
		;	leaving		-- menu currently doing 'exit' animation
		tags={menu_state=off}
	}

	FireEvent type=focus target=root_window
	PopMemProfile  //"Fonts and Bitmaps"

	// load current theme sprites ( Doing it last because it will push and pop automatically )
	load_theme_textures_to_main_memory
	create_panel_stuff
endscript


script handle_pause_continue
	if GotParam pause_controller
		if not ( <pause_controller> = <device_num> )
			return
		endif
	endif
	exit_pause_menu
endscript

is_changing_levels=0

; run whenever 'start' is pressed
script handle_start_pressed
	; printf "handle_start_pressed"
	root_window:GetTags

	if ( is_changing_levels = 1 )
		return
	endif

	if LevelIs load_skateshop
		return
	endif

	if ChecksumEquals a=<menu_state> b=on
		// who paused the game?
		if GotParam pause_controller
			if not ( <pause_controller> = -1 )
				if not ( <device_num> = <pause_controller> )
					return
				endif
			endif
		endif

		; main menu fully onscreen, so make it go away
		if Not InNetGame
			UnpauseGame
		endif
		exit_pause_menu
		change inside_pause = 0
	endif
	if ChecksumEquals a=<menu_state> b=off
		change viewer_buttons_enabled = 0		// Mick:  When pausing the game, we don't want the viewer buttons active
		// don't let anyone else pause a one player game
		if not InMultiPlayerGame
			if not ControllerBoundToSkater controller=<device_num> skater=0
				return
			endif
		else
			if InSplitScreenGame
				if not ControllerboundToSkater controller=<device_num> skater=0
					if not ControllerBoundToSkater controller=<device_num> skater=1
						return
					endif
				endif
			endif
		endif

		// remember who paused the game
		SetTags pause_controller=<device_num>

		// remove any temp special tricks, in case they save
		possibly_remove_temp_special_trick

		// don't start a goal
		KillSpawnedScript name=goal_accept_trigger

		; main menu fully offscreen, so make it appear
		if Not InNetGame
			// don't pause during cams
			GetSkaterId
			if GetSkaterCamAnimParams skater=<objId>
				if ( <allow_pause> = 0 )
					return
				endif
			endif

			printf "-------------------- PAUSING GAME ----------------------"
			PauseGame
			GoalManager_PauseAllGoals
			wait 1 gameframe
			// Don't move these next two lines. Thanks!!
			pause_trick_text
			pause_balance_meter
			pause_run_timer
			kill_blur

			// hide any speech boxes
			if ObjectExists id=speech_box_anchor
				DoScreenElementMorph id=speech_box_anchor scale=0
				; RunScriptOnScreenElement id=speech_box_anchor hide_screen_element
			endif
			if ScreenElementExists id=goal_start_dialog
				DestroyScreenElement id=goal_start_dialog
			endif
			if ObjectExists id=ped_speech_dialog
				DestroyScreenElement id=ped_speech_dialog
			endif
			if ObjectExists id=goal_retry_anchor
				DestroyScreenElement id=goal_retry_anchor
			endif

			// hide goal hud stuff
			hide_goal_panel_messages
		endif
		create_pause_menu device_num=<device_num>
	endif
endscript

// @script | restore_start_key_binding | this restores the start key binding
// to handle_start_pressed if you've changed it
script restore_start_key_binding
	SetScreenElementProps {
		id=root_window
		event_handlers=[ { pad_start 		handle_start_pressed } ]
		replace_handlers
	}
endscript

// @script | kill_start_key_binding | this kills the start key binding
script kill_start_key_binding
	SetScreenElementProps {
		id=root_window
		event_handlers=[ { pad_start 		null_script } ]
		replace_handlers
	}
endscript


; ==========================================================================
;
; Creation scripts
;
; ==========================================================================
; Creates the components that make up the game menu, then runs a script to
; begin their 'entrance' animation
// @script | make_new_menu | Creates a new menu with id current_menu_anchor
// @parmopt string | menu_title | "Paused" | The title of this menu
// @parm name | menu_id | id of this menu
// @parm name | vmenu_id | id of the vmenu
// @parmopt vector | pos | (345,105) | position for this menu
// @parmopt vector | anchor_pos | (320,224) | position for the main menu anchor
// @parmopt float | padding_scale | 1.15 | padding scale for the vmenu elements
// @parmopt array | internal_just | [left top] | justification of elements within the
// menu
// @parmopt name | type | | You can specify a type of VScrollingMenu to create a scrolling
// menu rather than a regular vmenu
// @parmopt name | dont_allow_wrap | | set this equal to dont_allow_wrap to turn off wrapping
script make_new_ingame_menu
	make_new_menu <...>
endscript

script make_new_menu { menu_title=""
		padding_scale=1.15
		internal_scale=1
		pos=(230,109)
		dims=(200, 100)
		internal_just=[left top]
		parent=root_window
		just=[center center]
		scrolling_menu_offset=(0, 10)
	}

	<pos> = ( <pos> + (0,12) )

	SetScreenElementLock id=<parent> off

	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=<menu_id>

		font=small
		pos=(320, 240)
		scale=1
		dims=(640, 480)
		focusable_child=<vmenu_id>
	}

	switch <type>
		case VScrollingMenu
			if GotParam scrolling_menu_title_id
				CreateScreenElement {
					type=TextElement
					parent=<menu_id>
					id=<scrolling_menu_title_id>

					font=testtitle
					text=<menu_title>
					scale=1.4
					pos=<pos>
					just= [left top]
					rgba=MENU_TITLE_COLOR ;[128 128 128 98]
					not_focusable
				}


				GetStackedScreenElementPos Y id=<id> offset=<scrolling_menu_offset>
			endif

			CreateScreenElement {
				type=VScrollingMenu
				parent=<menu_id>

				id=<scrolling_menu_id>
				pos=<pos>
				just=[left top]
				dims=<dims>
				scale=<scale>
				internal_just=[left top]
				num_items_to_show=<num_items_to_show>
			}

			<vscrolling_menu_id> = <id>

			CreateScreenElement {
				type=VMenu
				parent=<vscrolling_menu_id>
				id=<vmenu_id>

				dims=<dims>

				dims=<dims>

				font=small
				just=[left top]
				pos=(0, 0)
				scale=<scale>
				regular_space_amount=<regular_space_amount>
				padding_scale=<padding_scale>
				internal_scale=<internal_scale>
				internal_just=<internal_just>
				<dont_allow_wrap>
				event_handlers=[ 	{ pad_up 		generic_menu_up_or_down_sound params={ up } }
					{ pad_down		generic_menu_up_or_down_sound params={ down } }
				]
			}
		default
			CreateScreenElement {
				type=VMenu
				parent=<menu_id>
				id=<vmenu_id>

				font=small
				just=[left top]
				pos=<pos>
				padding_scale=<padding_scale>
				internal_scale=<internal_scale>
				internal_just=<internal_just>
				<dont_allow_wrap>
				event_handlers=[ 	{ pad_up 		generic_menu_up_or_down_sound params={ up } }
					{ pad_down		generic_menu_up_or_down_sound params={ down } }
					// can't do this because the menu will get destroyed before the sound plays
					// have to add generic_menu_pad_back to each menu with
					// using a callback for the menu exit script
					;{ pad_back		generic_menu_pad_back_sound }
				]
			}

			if not GotParam no_menu_title
				CreateScreenElement {
					type=TextElement
					parent=<vmenu_id>

					font=testtitle
					text=<menu_title>
					scale=1.4
					;just= [left top]
					rgba=MENU_TITLE_COLOR ;[128 128 128 98]
					not_focusable
				}
			endif

	endswitch

	if not GotParam no_alias
		AssignAlias id=<menu_id> alias=current_menu_anchor
	endif
	AssignAlias id=<vmenu_id> alias=current_menu

	if GotParam helper_text
		create_helper_text <helper_text>
	endif
endscript


// @script | make_new_sprite_menu |
// @parmopt string | menu_title | | The title of the menu...leave blank for no title
// @parmopt name | menu_id | main_menu_anchor | the name of the parent of the menu
script make_new_sprite_menu menu_id=main_menu_anchor vmenu_id=main_menu pad_back_script=exit_pause_menu pos=(320,240) parent=root_window
	SetScreenElementLock id=root_window off

	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=<menu_id>

		font=small
		pos=<pos>
		just=[center center]
		scale=0
		; dims=(200,400)
		dims=(640, 480)
		focusable_child=<vmenu_id>
	}

	if GotParam menu_title
		CreateScreenElement {
			type=SpriteElement
			parent=<menu_id>

			texture=<menu_title>
			; scale=1
			pos=(330, 60)
			just=[left top]
			rgba=[128 128 128 70]
		}
	endif

	CreateScreenElement {
		type=VMenu
		parent=<menu_id>
		id=<vmenu_id>

		font=small
		just=[left top]
		pos=(120, 80)
		; dims=(200, 170)
		internal_just=[right top]
		event_handlers=[ { pad_back		generic_menu_pad_back_sound }
			{ pad_back		<pad_back_script> params=<pad_back_params> }
			{ pad_up 		generic_menu_up_or_down_sound params={ up } }
			{ pad_down		generic_menu_up_or_down_sound params={ down } }
		]
	}

	AssignAlias id=<menu_id> alias=current_menu_anchor
	AssignAlias id=<vmenu_id> alias=current_menu
endscript

// @script | make_new_pause_menu |
// @parmopt string | menu_title | | The title of the menu...leave blank for no title
// @parmopt name | menu_id | main_menu_anchor | the name of the parent of the menu
script make_new_pause_menu menu_id=main_menu_anchor vmenu_id=main_menu pad_back_script=exit_pause_menu pos=(320,240) parent=root_window
	SetScreenElementLock id=root_window off

	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=pause_menu_parts_anchor

		dims=(640, 480)
		pos=(320, 240)
	}

	CreateScreenElement {
		type=ContainerElement
		parent=pause_menu_parts_anchor
		id=<menu_id>

		font=small
		pos=<pos>
		just=[center center]
		scale=0
		; dims=(200,400)
		dims=(640, 480)
		focusable_child=<vmenu_id>
	}

	if GotParam menu_title
		CreateScreenElement {
			type=SpriteElement
			parent=<menu_id>

			texture=<menu_title>
			; scale=1
			pos=(330, 60)
			just=[left top]
			rgba=[128 128 128 70]
		}
	endif

	CreateScreenElement {
		type=VMenu
		parent=<menu_id>
		id=<vmenu_id>

		font=small
		just=[left top]
		pos=(120, 80)
		; dims=(200, 170)
		internal_just=[right top]
		event_handlers=[ { pad_back		generic_pause_exit_sound }
			{ pad_back		<pad_back_script> params=<pad_back_params> }
			{ pad_up 		generic_menu_up_or_down_sound params={ up } }
			{ pad_down		generic_menu_up_or_down_sound params={ down } }
		]
	}

	AssignAlias id=pause_menu_parts_anchor alias=current_menu_anchor
	AssignAlias id=<vmenu_id> alias=current_menu
endscript


// @script | set_menu_bg | called to set the background for the pause menu.
// this is a hack...just use it to set the pos and rgba for the bg...
script set_menu_bg parent=current_menu_anchor

	// if you change the number of slices, just change these two values
	// All slices must be the same size
	<number_of_slices> = 7
	<slice_height> = 32

	// scale to draw all the slices
	<slice_scale> = (1, 1.25)

	// adjust the slice height for the scale
	<slice_height> = ( ( (0, 1) . <slice_scale> ) * <slice_height> )

	CreateScreenElement {
		type=SpriteElement
		parent=<parent>

		texture=paused
		pos=(153, 69)
		just=[left top]
		rgba=[118 118 128 120]
	}

	// we're gonna try to use the least number of pieces
	GetStackedScreenElementPos X id=<id> offset=(-8, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=<parent>

		texture=SlicePause_1
		pos=<pos>
		just=[left top]
		scale=<paused_bar_scale>

	}

	// see if we can grab the dimensions of the current menu
	if ObjectExists id=current_menu
		SetScreenElementLock id=current_menu on // forces the size to update
		GetScreenElementDims id=current_menu

		// get the top corner of each so we can adjust for any offset
		// (the first piece does not line up directly with the top of the menu)
		GetScreenElementPosition id=<id>
		<top_of_first_slice> = ( <ScreenElementPos> . (0, 1) )
		GetScreenElementPosition id=current_menu
		<top_of_menu> = ( <ScreenElementPos> . (0, 1) )

		// subtract the height of the first slice
		<height> = ( <height> - <slice_height> )

		// now add any offset (this assumes the bar sticks up higher!)
		<height> = ( <height> + ( <top_of_menu> - <top_of_first_slice> ) )

		<draw_all> = 0
	else
		<height> = 400
		<draw_all> = 1
	endif

	<last_slice> = 1

	begin
		if ( <draw_all> = 0 )
			if ( ( <height> < 0 ) || ( <last_slice> = <number_of_slices> ) )
				break
			endif
		else
			if ( <last_slice> = <number_of_slices> )
				break
			endif
		endif

		<last_slice> = ( <last_slice> + 1 )
		FormatText ChecksumName=texture_name "SlicePause_%i" i=<last_slice>
		GetStackedScreenElementPos Y id=<id>
		CreateScreenElement {
			type=SpriteElement
			parent=<parent>

			texture=<texture_name>
			pos=<pos>
			just=[left top]
			scale=<slice_scale>
		}

		<height> = ( <height> - <slice_height> )
	repeat
endscript

script set_sub_bg { parent=current_menu_anchor
		pos=(326, 115)
		scale=(1.17, 1.1)
		just=[center top]
	}

	CreateScreenElement {
		type=SpriteElement
		parent=<parent>

		texture=options_bg
		draw_behind_parent
		pos=<pos>
		scale=<scale>
		just=<just>
		rgba=[128 128 128 128]
		z_priority=1
	}
endscript

script set_sub_bg_goal goal_mid_scale=(14.8, 1.33) pos=(250, 23) goal_end_scale=(1.0, 1.33)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=options_bg
		draw_behind_parent
		pos=<pos>
		scale=(1.1, 1)
		just=[center top]
		rgba=[128 128 128 128]
		z_priority=0
	}

	GetStackedScreenElementPos Y id=<id> offset=(5, -36)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=goal_left
		draw_behind_parent
		pos=<pos>
		scale=<goal_end_scale>
		just=[left top]
		rgba=[56 60 71 118]
		z_priority=0
	}


	GetStackedScreenElementPos X id=<id>
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=goal_mid
		draw_behind_parent
		pos=<pos>
		scale=<goal_mid_scale>
		just=[left top]
		rgba=[56 60 71 118]
		z_priority=0
	}

	GetStackedScreenElementPos X id=<id>
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=goal_right
		draw_behind_parent
		pos=<pos>
		scale=<goal_end_scale>
		just=[left top]
		rgba=[56 60 71 118]
		z_priority=0
	}
endscript

script create_icon pos=(176,115) parent=current_menu_anchor scale=(0.95,0.95) z_priority=5
	CreateScreenElement {
		type=SpriteElement
		parent=<parent>
		id=<id>

		pos=<pos>
		scale=<scale>
		just=[left top]
		rgba=icon_color ;[127 102 0 128]
		z_priority=<z_priority>
		texture=<texture>
	}
endscript

// @script | make_text_sprite | makes a sprite that's a child of a text element
// @parm name | parent | the name of the parent of this sprite
// @parm name | texture | the texture name
// @parmopt vector | pos | (-30,10) | the position vector...note that this is relative to the
// parent
// @parmopt array | just | [center center] | justification array
// @parmopt float | scale | .45 | amount to scale this sprite by
// @parmopt array | rgba | [128 128 128 50] | red, green, blue, alpha array
script make_text_sprite pos=(215,15) just=[center center] scale=.45

	if GotParam id
		CreateScreenElement {
			type=SpriteElement
			parent=<parent>
			id=<id>
			texture=<texture>
			pos=<pos>
			rgba=[0 0 0 0]
			just=<just>
			scale = <scale>
			z_priority=2
		}
	else
		CreateScreenElement {
			type=SpriteElement
			parent=<parent>
			texture=<texture>
			pos=<pos>
			rgba=[0 0 0 0]
			just=<just>
			scale = <scale>
			z_priority=2
		}
	endif

endscript

//********************************
//         Startup menu
//********************************
// @script | create_career_startup_menu | Creates the startup menu
script create_career_startup_menu
	Skater:PausePhysics
	Skater:RemoveSkaterFromWorld

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	unhide_root_window

	GoalManager_HideGoalPoints
	GoalManager_HidePoints

	pause_menu_gradient on

	PauseMusicAndStreams 1

	//Rulon (TT13359): Wait before hiding some peds as they may not have loaded yet.
	wait 1 seconds
	hide_dumb_peds

	// create menu
	make_new_menu {
		pos=(120, 150)
		internal_just=[center center]
		menu_id=startup_menu
		vmenu_id=startup_vmenu
		menu_title=""
	}

	build_top_and_bottom_blocks scale=(1.2,1)

	/*	if (DEMO_BUILD)
		story_text = "Start the Competition"
		pos1=(230,195)
		pos2=(435,195)
	else */
	story_text = "Continue Story"
	pos1=(270,205)
	pos2=(395,205)
	//	endif

	FormatText ChecksumName=bracket_texture "%i_sub_frame" i=(THEME_PREFIXES[current_theme_prefix])

	// left bracket
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=left_bracket

		texture=<bracket_texture>
		pos=<pos1>
		scale=(1,1)
		z_priority=1
	}

	// right bracket
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=right_bracket

		texture=<bracket_texture>
		pos=<pos2>
		scale=(1,1)
		z_priority=1
		rot_angle=180
	}

	create_helper_text generic_helper_text_no_back
	kill_start_key_binding

	make_main_menu_item {	text=<story_text>
		pad_choose_script=exit_career_startup_menu
		pad_choose_params={  }
		just=[center center]
		mark_first_input
	}

	//	if not (DEMO_BUILD)
	make_main_menu_item {	text="Main Menu"
		pad_choose_script=exit_career_startup_menu_to_mainmenu
		pad_choose_params={  }
		just=[center center]
	}
	//	endif

	FireEvent type=focus target=current_menu_anchor

endscript

script hide_dumb_peds

	<index> = 0
	GetCurrentLevel
	switch <level>
		case load_nj
			<index> = 0
		case load_ny
			<index> = 1
		case load_fl
			<index> = 2
		case load_sd
			<index> = 3
		case load_hi
			<index> = 4
		case load_vc
			<index> = 5
		case load_sj
			<index> = 6
		case load_ru
			<index> = 7
		case load_se
			<index> = 8
		default
			return
	endswitch

	<array> = (LEVEL_PEDS_HIDE[<index>])

	GetArraySize <array>

	if (<array_size> > 0)
		<index> = 0
		begin
			<id> = (<array>[<index>])

			if GotParam unhide
				if ObjectExists id=<id>
					if isAlive name=<id>
						<id>:Ped_StartMoving
						<id>:unhide
					endif
				endif
			else
				if ObjectExists id=<id>
					if isAlive name=<id>
						<id>:Ped_StopMoving
						<id>:hide
					endif
				endif
			endif

			<index> = (<index>+1)
		repeat <array_size>
	endif

endscript

script reset_show_career_startup_menu
	wait 1 second
	change show_career_startup_menu=0
endscript

script exit_career_startup_menu
	mark_first_input_received <...>
	DestroyScreenElement id=current_menu_anchor
	pause_menu_gradient off
	restore_start_key_binding

	PauseStream 0
	PauseMusic 0

	hide_dumb_peds unhide
	Skater:UnpausePhysics
	Skater:AddSkaterToWorld
	GoalManager_ShowPoints
	GoalManager_ShowGoalPoints
	GoalManager_GetCurrentChapterAndStage
	GetCurrentLevel
	If ( (<currentchapter> = 0) & (<currentstage> = 0) & (<level>=Load_NJ) )
		ShownChapterTitle
	endif
endscript

script exit_career_startup_menu_to_mainmenu
	change_level level=load_skateshop
endscript

script hide_everything
	DoScreenElementMorph id=root_window time=0 scale=0
endscript

script unhide_everything
	DoScreenElementMorph id=root_window time=0 scale=1
endscript

script hide_landing_msg
	if ObjectExists id=perfect
		DoScreenElementMorph id=perfect time=0 alpha=0
	endif
	if ObjectExists id=perfect2
		DoScreenElementMorph id=perfect2 time=0 alpha=0
	endif
endscript

script unhide_landing_msg
	if ObjectExists id=perfect
		DoScreenElementMorph id=perfect time=0 alpha=0.5
	endif
	if ObjectExists id=perfect2
		DoScreenElementMorph id=perfect2 time=0 alpha=0.5
	endif
endscript

script hide_3d_goal_arrow
	if ScreenElementExists id=DesignerCreated_3DArrowPointer
		DoScreenElementMorph id=DesignerCreated_3DArrowPointer pos=(320,-300)
	endif
	if ScreenElementExists id=race_arrow
		DoScreenElementMorph id=race_arrow pos=(320,-300)
	endif
	if ScreenElementExists id=ctf_arrow
		DoScreenElementMorph id=ctf_arrow pos=(320,-300)
	endif
endscript

script unhide_3d_goal_arrow
	if ScreenElementExists id=DesignerCreated_3DArrowPointer
		DoScreenElementMorph id=DesignerCreated_3DArrowPointer pos=(320,70)
	endif
	if ScreenElementExists id=race_arrow
		DoScreenElementMorph id=race_arrow pos=(320,70)
	endif
	if ScreenElementExists id=ctf_arrow
		DoScreenElementMorph id=ctf_arrow pos=(320,70)
	endif
endscript

script hide_net_scores
	if ObjectExists id=net_score_1
		DoScreenElementMorph id=net_score_1 time=0 scale=0
	endif
	if ObjectExists id=net_score_2
		DoScreenElementMorph id=net_score_2 time=0 scale=0
	endif
	if ObjectExists id=net_score_3
		DoScreenElementMorph id=net_score_3 time=0 scale=0
	endif
	if ObjectExists id=net_score_4
		DoScreenElementMorph id=net_score_4 time=0 scale=0
	endif
	if ObjectExists id=net_score_5
		DoScreenElementMorph id=net_score_5 time=0 scale=0
	endif
	if ObjectExists id=net_score_6
		DoScreenElementMorph id=net_score_6 time=0 scale=0
	endif
	if ObjectExists id=net_score_7
		DoScreenElementMorph id=net_score_7 time=0 scale=0
	endif
	if ObjectExists id=net_score_8
		DoScreenElementMorph id=net_score_8 time=0 scale=0
	endif
endscript

script unhide_net_scores
	if ObjectExists id=net_score_1
		DoScreenElementMorph id=net_score_1 time=0 scale=0.9
	endif
	if ObjectExists id=net_score_2
		DoScreenElementMorph id=net_score_2 time=0 scale=0.9
	endif
	if ObjectExists id=net_score_3
		DoScreenElementMorph id=net_score_3 time=0 scale=0.9
	endif
	if ObjectExists id=net_score_4
		DoScreenElementMorph id=net_score_4 time=0 scale=0.9
	endif
	if ObjectExists id=net_score_5
		DoScreenElementMorph id=net_score_5 time=0 scale=0.9
	endif
	if ObjectExists id=net_score_6
		DoScreenElementMorph id=net_score_6 time=0 scale=0.9
	endif
	if ObjectExists id=net_score_7
		DoScreenElementMorph id=net_score_7 time=0 scale=0.9
	endif
	if ObjectExists id=net_score_8
		DoScreenElementMorph id=net_score_8 time=0 scale=0.9
	endif
endscript

script hide_current_goal
	if ObjectExists id=current_goal
		DoScreenElementMorph id=current_goal time=0 scale=0
	endif
	if ObjectExists id=mp_goal_text
		DoScreenElementMorph id=mp_goal_text time=0 scale=0
	endif
	if ObjectExists id=sc_goal_text
		DoScreenElementMorph id=sc_goal_text time=0 scale=0
	endif
	if ObjectExists id=Eric_score
		DoScreenElementMorph id=Eric_score time=0 scale=0
	endif
	hide_key_combo_text
endscript

comp_texts = [Eric_Text Ron_Text Johnny_Text Chicken_Text Raven_Text final_scores goal_comp_out_of_bounds_warning]

script hide_comp_text

	GetArraySize comp_texts
	<index>=0
	begin
		<id> = (comp_texts[<index>])
		if ObjectExists id=<id>
			DoScreenElementMorph id=<id> time=0 scale=0
		endif
		<index> = (<index>+1)
	repeat <array_size>

endscript

script unhide_comp_text

	GetArraySize comp_texts
	<index>=0
	begin
		<id> = (comp_texts[<index>])
		if ObjectExists id=<id>
			DoScreenElementMorph id=<id> time=0 scale=1
		endif
		<index> = (<index>+1)
	repeat <array_size>
endscript

script unhide_current_goal
	if ObjectExists id=current_goal
		DoScreenElementMorph id=current_goal time=0 scale=.83
	endif
	if ObjectExists id=mp_goal_text
		DoScreenElementMorph id=mp_goal_text time=0 scale=.83
	endif
	if ObjectExists id=sc_goal_text
		DoScreenElementMorph id=sc_goal_text time=0 scale=.83
	endif
	if ObjectExists id=Eric_score
		DoScreenElementMorph id=Eric_score time=0 scale=.83
	endif
	unhide_key_combo_text
endscript

script hide_death_msg
	if ObjectExists id=death_message
		DoScreenElementMorph id=death_message time=0 scale=0
	endif
endscript

script unhide_death_msg
	if ObjectExists id=death_message
		DoScreenElementMorph id=death_message time=0 scale=1
	endif
endscript

script hide_tips
	if ObjectExists id=skater_hint
		DoScreenElementMorph id=skater_hint time=0 pos=(320,11050)
	endif
endscript

script unhide_tips
	if ObjectExists id=skater_hint
		DoScreenElementMorph id=skater_hint time=0 pos=(320,150)
	endif
endscript

script pause_rain
	if IsSoundPlaying TestLight01
		;Light_Rain_SFX_Off
		change Paused_Light_Rain=1
	endif

	if IsSoundPlaying TestMedium02
		;Heavy_Rain_SFX_Off
		change Paused_Heavy_Rain=1
	endif
endscript

script unpause_rain
	if not LevelIs load_skateshop
		if (Paused_Light_Rain = 1)
			;SpawnScript wait_and_start_rain params={type=1}
			if IsSoundPlaying TestLight01  // Mick:  Need to check if sound is playing, as the flag might have been set before a level change.
				if not GotParam dont_unpause_rain_sounds
					if (Inside_Light_Rain=1)
						SetSoundParams TestLight01 vol=(LightRainVolume * 0.1)
					else
						SetSoundParams TestLight01 vol=LightRainVolume
					endif
				endif
			endif
			change Paused_Light_Rain=0
		endif

		if (Paused_Heavy_Rain = 1)
			;SpawnScript wait_and_start_rain params={type=2}
			if IsSoundPlaying TestLight02
				if not GotParam dont_unpause_rain_sounds
					if (Inside_Heavy_Rain=1)
						SetSoundParams TestLight02 vol=(LightRainVolume * 0.1)
					else
						SetSoundParams TestLight02 vol=LightRainVolume
					endif
				endif
			endif
			if IsSoundPlaying TestMedium02
				if not GotParam dont_unpause_rain_sounds
					if (Inside_Heavy_Rain=1)
						SetSoundParams TestMedium02 vol=(MediumRainVolume * 0.1)
					else
						SetSoundParams TestMedium02 vol=MediumRainVolume
					endif
				endif
			endif
			change Paused_Heavy_Rain=0
		endif
	endif
endscript

//********************************
//         Pause menu
//********************************
// @script | create_pause_menu | Creates the main pause menu
script create_pause_menu

	dialog_box_exit

	if CustomParkMode editing
		SetParkEditorPauseMode pause
	endif

	if not GotParam no_sound
		;PlaySound MenuBack vol=50
	endif

	unhide_root_window

	if ( inside_pause = 1 )
		pulse_blur
	endif

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=0
	endif

	if ObjectExists id=first_time_goal_info
		DestroyScreenElement id=first_time_goal_info
	endif

	if ScreenElementExists id=cutscene_camera_hud_anchor
		change camera_hud_is_hidden=1
		DoScreenElementMorph id=cutscene_camera_hud_anchor alpha=0
	endif

	if ScreenElementExists id=nightvision_hud_anchor
		change nightvision_hud_is_hidden=1
		DoScreenElementMorph id=nightvision_hud_anchor alpha=0
	endif

	GoalManager_HideGoalPoints
	GoalManager_HidePoints
	hide_3d_goal_arrow
	hide_landing_msg
	hide_chaper_intro_title
	hide_console_window
	goal_skate_hide_letters
	hide_combo_letters
	hide_net_scores
	hide_stat_message
	hide_comp_text
	unhide_current_goal
	hide_tips
	pause_trick_text
	hide_death_msg
	pause_menu_gradient on

	if InNetGame
		if Not IsObserving
			Skater:NetDisablePlayerInput
		endif
	else
		// *** IF YOU MAKE BIG MENU CHANGES, PLEASE TAKE THIS INTO ACCOUNT ***
		// PARKED4:
		if CustomParkMode editing
			parked_setup_main_menu
			PauseMusicAndStreams 1
			build_pause_menu_parts
			return
		endif

		// PARKED4:
		if CustomParkMode testing
			parked_setup_test_play_menu
			PauseMusicAndStreams 1
			build_pause_menu_parts
			return
		endif

		if InSplitScreenGame
			create_mp_pause_menu
			PauseMusicAndStreams 1
			build_pause_menu_parts
			return
		endif
	endif

	if ( inside_pause = 0 )
		if MusicIsPaused
			change music_was_paused=1
		else
			change music_was_paused=0
		endif
	endif

	PauseMusicAndStreams 1

	pause_rain

	if ( in_cat_preview_mode = 1 )
		create_CAT_pause_menu
		return
	endif

	// set icons for current theme
	set_theme_icons

	if GotParam no_exit
		make_new_pause_menu menu_id=pause_menu vmenu_id=pause_vmenu pad_back_script=nullscript pos=(320,540)
	else
		make_new_pause_menu menu_id=pause_menu vmenu_id=pause_vmenu pad_back_script=handle_start_pressed pos=(320,540)
	endif

	/*SetScreenElementProps {	id=pause_vmenu
							event_handlers=[ 	;{ pad_up 		null_script }
												;{ pad_down 		null_script }
											]
							replace_handlers
						  }
	 */

	if Not GotParam no_exit
		create_helper_text generic_helper_text
	else
		create_helper_text generic_helper_text_no_back
	endif
	kill_start_key_binding

	add_music_track_text pos=(900,320)

	;if GoalManager_HasActiveGoals
	;    DoScreenElementMorph {
	;		id=the_time
	;		alpha=0
	;		remember_alpha
	;	}
	;endif

	if GameModeEquals is_singlesession
		make_sprite_menu_item text="Continue" id=menu_continue pad_choose_script=handle_pause_continue pad_choose_sound=generic_pause_exit_sound
		make_text_sprite texture=<continue_icon> parent=menu_continue
		SetScreenElementProps {
			id=menu_continue
			event_handlers = [
				{ focus	PlayHelperDesc params={ continue_helper_desc use_bg}}
				{ unfocus StopHelperDesc }
			]
		}

		if GoalManager_goalIsActive name=TrickAttack
			make_sprite_menu_item {
				text="Retry High Score Run"
				id = menu_retry_high_score_run
				pad_choose_script = menu_select
				pad_choose_params = { stop_streams menu_select_script = RetryCurrentGoal }
			}
			make_text_sprite texture=<retry_icon> parent=menu_retry_high_score_run
			SetScreenElementProps {
				id=menu_retry_high_score_run
				event_handlers = [
					{ focus	PlayHelperDesc params={ retry_hsr_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}

			make_sprite_menu_item {
				text = "End High Score Run"
				id = menu_end_high_score_run
				pad_choose_script = menu_select
				pad_choose_params = { menu_select_script = end_high_score_run }
			}
			make_text_sprite texture=<end_icon> parent=menu_end_high_score_run
			SetScreenElementProps {
				id=menu_end_high_score_run
				event_handlers = [
					{ focus	PlayHelperDesc params={ end_hsr_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		else
			make_sprite_menu_item {
				text = "Start High Score Run"
				id = menu_start_high_score_run
				pad_choose_script = menu_select
				pad_choose_params = { menu_select_script = TrickAttack_MenuStartRun }
			}
			make_text_sprite texture=<retry_icon> parent=menu_start_high_score_run
			SetScreenElementProps {
				id=menu_start_high_score_run
				event_handlers = [
					{ focus	PlayHelperDesc params={ start_hsr_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
			; SetScreenElementProps id=pause_vmenu event_handlers=[ {pad_back null_script} ] replace_handlers
			; create_helper_text generic_helper_text_no_back
		endif
	else
		if Not GotParam no_exit
			make_sprite_menu_item text="Continue" id=menu_continue pad_choose_script=handle_pause_continue pad_choose_sound=generic_pause_exit_sound
			make_text_sprite texture=<continue_icon> parent=menu_continue
			SetScreenElementProps {
				id=menu_continue
				event_handlers = [
					{ focus	PlayHelperDesc params={ continue_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		endif
	endif

	if Not GotParam NoCustomRestarts
		make_theme_menu_item {
			text="Set Restart"
			id=menu_set_custom
			pad_choose_script=menu_select
			pad_choose_params={ menu_select_script=set_custom_restart }
		}

		if Skater:SetCustomRestart
			make_theme_menu_item text="Goto Cust Restart" id=menu_skip_to_custom pad_choose_script=menu_select pad_choose_params={menu_select_script=skip_to_custom_restart}
		endif
	endif

	make_sprite_menu_item text="Goto Restart" id=menu_skip_to_restart pad_choose_script=launch_restart_menu
	make_text_sprite texture=<model_icon> parent=menu_skip_to_restart
	SetScreenElementProps {
		id=menu_skip_to_restart
		event_handlers = [
			{ focus	PlayHelperDesc params={ goto_restart_helper_desc use_bg}}
			{ unfocus StopHelperDesc }
		]
	}

	if GameModeEquals is_goal_attack
		if Not IsObserving
			if GoalManager_CanRetryGoal
				if GoalManager_GetLastGoalId
					if not GoalManager_HasWonGoal name=<goal_id>
						make_sprite_menu_item text="Retry Last Goal" id=menu_retry_goal pad_choose_script=menu_select pad_choose_params={ stop_vibration menu_select_script = RetryCurrentGoal }
						make_text_sprite texture=<retry_icon> parent=menu_retry_goal
						SetScreenElementProps {
							id=menu_retry_goal
							event_handlers = [
								{ focus	PlayHelperDesc params={ retry_goal_helper_desc use_bg}}
								{ unfocus StopHelperDesc }
							]
						}
					endif
				endif
			endif
			if GoalManager_HasActiveGoals
				make_sprite_menu_item text="End Current Goal" id=menu_end_current_goal pad_choose_script=menu_select pad_choose_params={menu_select_script=end_current_goal_run}
				make_text_sprite texture=<end_icon> parent=menu_end_current_goal
				SetScreenElementProps {
					id=menu_end_current_goal
					event_handlers = [
						{ focus	PlayHelperDesc params={ end_run_helper_desc use_bg } }
						{ unfocus StopHelperDesc }
					]
				}
			endif
		endif
		make_sprite_menu_item text="View Goals"  id=menu_view_goals pad_choose_script=create_view_selected_goals_menu pad_choose_params={ from_pause }
		make_text_sprite texture=<view_icon> parent=menu_view_goals
		SetScreenElementProps {
			id=menu_view_goals
			event_handlers = [
				{ focus	PlayHelperDesc params={ view_goal_cag_helper_desc use_bg}}
				{ unfocus StopHelperDesc }
			]
		}
	endif

	if GameModeEquals is_singlesession
		if ( GoalManager_HasActiveGoals )
			tricks_uneditable=1
		else
			if ( driving_parked_car=1 )
				tricks_uneditable=1
			else
				if GoalManager_goalIsActive name=TrickAttack
					tricks_uneditable=1
				endif
			endif
		endif

		if GotParam tricks_uneditable
			make_theme_menu_item {
				text="Create A Trick"
				id=menu_cat
				pad_choose_script=create_pre_cat_menu
				not_focusable=not_focusable
			}
		else
			make_sprite_menu_item {
				text="Create A Trick"
				id=menu_cat
				pad_choose_script=create_pre_cat_menu
			}
			make_text_sprite texture=<new_icon> parent=menu_cat
			SetScreenElementProps {
				id=menu_cat
				event_handlers = [
					{ focus	PlayHelperDesc params={ cat_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		endif
	endif

	// only show goal options in career mode
	if GameModeEquals is_career
		if GoalManager_IsInCompetition
			GoalManager_GetGoalParams name=<goal_id>
			if GotParam already_ended_run
				if ( <already_ended_run> = 0 )
					make_sprite_menu_item text="End Current Run" id=menu_end_run pad_choose_script=goal_comp_end_current_run
					make_text_sprite texture=<end_icon> parent=menu_end_run
					SetScreenElementProps {
						id=menu_end_run
						event_handlers = [
							{ focus	PlayHelperDesc params={ end_run_helper_desc use_bg}}
							{ unfocus StopHelperDesc }
						]
					}
				endif
			endif
		endif

		; if GoalManager_CanRestartStage
		; make_sprite_menu_item text="Retry Stage" id=menu_retry_stage pad_choose_script=menu_select pad_choose_params={ menu_select_script = goal_restart_stage }
		; make_text_sprite texture=<retry_icon> parent=menu_retry_stage
		; else
		if GoalManager_CanRetryGoal
			make_sprite_menu_item text="Retry Last Goal" id=menu_retry_goal pad_choose_script=menu_select pad_choose_params={ stop_vibration stop_streams menu_select_script=RetryCurrentGoal }
			make_text_sprite texture=<retry_icon> parent=menu_retry_goal
			SetScreenElementProps {
				id=menu_retry_goal
				event_handlers = [
					{ focus	PlayHelperDesc params={ retry_goal_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		endif
		; endif
		if GoalManager_HasActiveGoals
			make_sprite_menu_item text="End Current Goal" id=menu_end_current_goal pad_choose_script=menu_select pad_choose_params={menu_select_script=end_current_goal_run}
			make_text_sprite texture=<end_icon> parent=menu_end_current_goal
			SetScreenElementProps {
				id=menu_end_current_goal
				event_handlers = [
					{ focus	PlayHelperDesc params={ end_run_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		endif

		make_sprite_menu_item text="View Goals"  id=menu_chapters pad_choose_script=create_chapter_menu
		make_text_sprite texture=<view_icon> parent=menu_chapters
		SetScreenElementProps {
			id=menu_chapters
			event_handlers = [
				{ focus	PlayHelperDesc params={ view_goal_helper_desc use_bg}}
				{ unfocus StopHelperDesc }
			]
		}
	else
		/*if GameModeEquals is_singlesession
            make_sprite_menu_item text="Retry High Score" id=menu_retry_high_score pad_choose_script=change_gamemode_singlesession_menu
            make_text_sprite texture=<options_icon> parent=menu_retry_high_score
        endif*/

		if GameModeEquals is_creategoals
			if GoalManager_CanRetryGoal
				make_sprite_menu_item text="Retry Last Goal" id=menu_retry_goal pad_choose_script=menu_select pad_choose_params={ stop_vibration stop_streams menu_select_script=RetryCurrentGoal }
				make_text_sprite texture=<retry_icon> parent=menu_retry_goal
				SetScreenElementProps {
					id=menu_retry_goal
					event_handlers = [
						{ focus	PlayHelperDesc params={ retry_goal_helper_desc use_bg}}
						{ unfocus StopHelperDesc }
					]
				}
			endif
			if GoalManager_HasActiveGoals
				make_sprite_menu_item text="End Current Goal" id=menu_end_current_goal pad_choose_script=menu_select pad_choose_params={menu_select_script=end_current_goal_run}
				make_text_sprite texture=<end_icon> parent=menu_end_current_goal
				SetScreenElementProps {
					id=menu_end_current_goal
					event_handlers = [
						{ focus	PlayHelperDesc params={ end_run_helper_desc use_bg}}
						{ unfocus StopHelperDesc }
					]
				}
			endif

			make_sprite_menu_item text="View Goals"  id=menu_view_goals pad_choose_script=create_view_goals_menu
			make_text_sprite texture=<view_icon> parent=menu_view_goals
			SetScreenElementProps {
				id=menu_view_goals
				event_handlers = [
					{ focus	PlayHelperDesc params={ view_goal_cag_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}

			if not LevelIs load_sk5ed_gameplay
				make_sprite_menu_item text="Create A Goal" id=menu_create_a_goal pad_choose_script=create_existing_goals_menu
				make_text_sprite texture=<new_icon> parent=menu_create_a_goal
				SetScreenElementProps {
					id=menu_create_a_goal
					event_handlers = [
						{ focus	PlayHelperDesc params={ create_goal_helper_desc use_bg}}
						{ unfocus StopHelperDesc }
					]
				}
			endif
		endif
	endif

	//	if not (DEMO_BUILD)
	if GameModeEquals is_creategoals
		if not LevelIs load_sk5ed_gameplay
			make_sprite_menu_item text="Load goals" id=menu_load_goals pad_choose_script=prompt_launch_cag_pause_load
			make_text_sprite texture=<load_icon> parent=menu_load_goals
			SetScreenElementProps {
				id=menu_load_goals
				event_handlers = [
					{ focus	PlayHelperDesc params={ load_goal_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
			GoalEditor:GetNumEditedGoals ExcludeParkEditorGoals
			if (<NumGoals> = 0)
				no_edited_goals=1
			endif
			make_sprite_menu_item text="Save goals" id=menu_save_goals pad_choose_script=launch_pause_menu_save_created_goals not_focusable=<no_edited_goals>
			make_text_sprite texture=<save_icon> parent=menu_save_goals
			SetScreenElementProps {
				id=menu_save_goals
				event_handlers = [
					{ focus	PlayHelperDesc params={ save_goal_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		endif
	endif
	//	endif

	//    if not (DEMO_BUILD)
	if not InNetGame
		make_sprite_menu_item text="Change level" id=menu_level_select pad_choose_script=launch_level_select_menu
		make_text_sprite texture=<level_icon> parent=menu_level_select
		SetScreenElementProps {
			id=menu_level_select
			event_handlers = [
				{ focus	PlayHelperDesc params={ change_level_helper_desc use_bg}}
				{ unfocus StopHelperDesc }
			]
		}
	endif
	//	endif

	//	if not (DEMO_BUILD)
	if not InNetGame

		make_sprite_menu_item text="Edit Skater/Tricks" id=menu_cas pad_choose_script=edit_skater_options_menu
		make_text_sprite texture=<edit_skater_icon> parent=menu_cas
		SetScreenElementProps {
			id=menu_cas
			event_handlers = [
				{ focus	PlayHelperDesc params={ edit_skater_helper_desc use_bg}}
				{ unfocus StopHelperDesc }
			]
		}

	endif
	//	endif

	if InNetGame
		if IsHost
			if GameModeEquals is_lobby
				if Not NetworkGamePending
					if Not ChangeLevelPending
						make_sprite_menu_item text="Start Game" id=menu_network_start_select pad_choose_script=network_game_options_selected
						make_text_sprite texture=<retry_icon> parent=menu_network_start_select
						SetScreenElementProps {
							id=menu_network_start_select
							event_handlers = [
								{ focus	PlayHelperDesc params={ start_game_helper_desc use_bg}}
								{ unfocus StopHelperDesc }
							]
						}
					endif
				endif
			else
				make_sprite_menu_item text="End Current Game" id=menu_network_end_select pad_choose_script=network_end_game_selected
				make_text_sprite texture=<end_icon> parent=menu_network_end_select
				SetScreenElementProps {
					id=menu_network_end_select
					event_handlers = [
						{ focus	PlayHelperDesc params={ end_game_helper_desc use_bg}}
						{ unfocus StopHelperDesc }
					]
				}
			endif
		endif
	endif


	if InNetGame
		if OnServer
			if OnXbox
				make_sprite_menu_item text="Host Options" id=menu_network_server_opts_select pad_choose_script=network_options_selected
				SetScreenElementProps {
					id=menu_network_server_opts_select
					event_handlers = [
						{ focus	PlayHelperDesc params={ host_options_helper_desc use_bg}}
						{ unfocus StopHelperDesc }
					]
				}
			else
				make_sprite_menu_item text="Server Options" id=menu_network_server_opts_select pad_choose_script=network_options_selected
				SetScreenElementProps {
					id=menu_network_server_opts_select
					event_handlers = [
						{ focus	PlayHelperDesc params={ server_options_helper_desc use_bg}}
						{ unfocus StopHelperDesc }
					]
				}
			endif
			make_text_sprite texture=<online_icon> parent=menu_network_server_opts_select

		endif
		if IsHost
			if GameModeEquals is_lobby
				if Not OnServer
					if OnXbox
						make_sprite_menu_item text="Host Options" id=menu_network_server_opts_select pad_choose_script=network_options_selected
						SetScreenElementProps {
							id=menu_network_server_opts_select
							event_handlers = [
								{ focus	PlayHelperDesc params={ host_options_helper_desc use_bg}}
								{ unfocus StopHelperDesc }
							]
						}
					else
						make_sprite_menu_item text="Server Options" id=menu_network_server_opts_select pad_choose_script=network_options_selected
						SetScreenElementProps {
							id=menu_network_server_opts_select
							event_handlers = [
								{ focus	PlayHelperDesc params={ server_options_helper_desc use_bg}}
								{ unfocus StopHelperDesc }
							]
						}
					endif
					make_text_sprite texture=<online_icon> parent=menu_network_server_opts_select
				endif
			endif
		endif
	endif

	make_sprite_menu_item text="Options" id=menu_options pad_choose_script=create_options_menu
	make_text_sprite texture=<options_icon> parent=menu_options
	SetScreenElementProps {
		id=menu_options
		event_handlers = [
			{ focus	PlayHelperDesc params={ pause_options_helper_desc use_bg}}
			{ unfocus StopHelperDesc }
		]
	}

	if InNetGame
		if not isObserving
			<firefight_active> = 0
			if GoalManager_GoalExists name=firefight
				if GoalManager_GoalIsActive name=firefight
					<firefight_active> = 1
				endif
			endif
			if ( <firefight_active> = 1 )
				<trick_text> = "View Tricks"
				<trick_helper> = view_tricks_helper_desc
			else
				if Not GoalManager_HasActiveGoals
					<trick_text> = "Edit Tricks"
					<trick_helper> = edit_tricks_helper_desc
				else
					<trick_text> = "View Tricks"
					<trick_helper> = view_tricks_helper_desc
				endif
			endif
			FormatText ChecksumName=trick_icon "%i_trick" i=(THEME_PREFIXES[current_theme_prefix])
			make_sprite_menu_item text=<trick_text> id=menu_cas pad_choose_script=create_edit_tricks_menu
			make_text_sprite texture=<trick_icon> parent=menu_cas

			SetScreenElementProps {
				id=menu_cas
				event_handlers = [
					{ focus	PlayHelperDesc params={ <trick_helper> use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		endif
	endif

	FormatText ChecksumName=online_icon "%i_online" i=(THEME_PREFIXES[current_theme_prefix])

	if InNetGame
		if IsHost
			if GameModeEquals is_lobby
				if Not NetworkGamePending
					if Not ChangeLevelPending


						make_sprite_menu_item text="Change level" id=menu_level_select pad_choose_script=launch_level_select_menu pad_choose_params={ show_warning }
						make_text_sprite texture=<level_icon> parent=menu_level_select
						SetScreenElementProps {
							id=menu_level_select
							event_handlers = [
								{ focus	PlayHelperDesc params={ change_level_helper_desc use_bg}}
								{ unfocus StopHelperDesc }
							]
						}
					endif
				endif

			endif
		endif

		if Not OnXbox
			if IsTrue bootstrap_build
				make_sprite_menu_item text="Player List" id=menu_network_remove_select pad_choose_script=launch_remove_players_menu not_focusable=not_focusable
				make_text_sprite texture=<career_ops_icon> parent=menu_network_remove_select
				SetScreenElementProps {
					id=menu_network_remove_select
					event_handlers = [
						{ focus	PlayHelperDesc params={ player_list_helper_desc use_bg}}
						{ unfocus StopHelperDesc }
					]
				}
			else
				make_sprite_menu_item text="Player List" id=menu_network_player_list_select pad_choose_script=launch_player_list_menu
				make_text_sprite texture=<career_ops_icon> parent=menu_network_player_list_select
				SetScreenElementProps {
					id=menu_network_player_list_select
					event_handlers = [
						{ focus	PlayHelperDesc params={ player_list_helper_desc use_bg}}
						{ unfocus StopHelperDesc }
					]
				}

				if ProfileLoggedIn
					make_sprite_menu_item text="Homie List" id=menu_network_homie_list_select pad_choose_script=launch_homie_list
					make_text_sprite texture=<options_icon> parent=menu_network_homie_list_select
					SetScreenElementProps {
						id=menu_network_homie_list_select
						event_handlers = [
							{ focus	PlayHelperDesc params={ homie_list_helper_desc use_bg}}
							{ unfocus StopHelperDesc }
						]
					}
				endif
			endif
		endif

		;make_sprite_menu_item text="View Stats" id=menu_edit_stats pad_choose_script=create_stats_menu
		;make_text_sprite texture=<stats_icon> parent=menu_edit_stats
	else		// not a network game
		if not GameModeEquals is_creategoals
			make_sprite_menu_item text="Save Game" id=menu_save_game pad_choose_script=launch_pause_menu_save_game_sequence
			make_text_sprite texture=<save_icon> parent=menu_save_game
			SetScreenElementProps {
				id=menu_save_game
				event_handlers = [
					{ focus	PlayHelperDesc params={ save_game_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		endif
		;make_sprite_menu_item text="Instant Replay" id=menu_view_replay pad_choose_script=in_game_view_replay
		;make_text_sprite texture=<replay_icon> parent=menu_view_replay

		make_sprite_menu_item text="View Gaps" id=menu_skip_to_gap pad_choose_script=launch_gap_menu
		make_text_sprite texture=<gap_icon> parent=menu_skip_to_gap
		SetScreenElementProps {
			id=menu_skip_to_gap
			event_handlers = [
				{ focus	PlayHelperDesc params={ view_gaps_helper_desc use_bg}}
				{ unfocus StopHelperDesc }
			]
		}

		if GameModeEquals is_career
			GetCurrentSkaterProfileIndex
			GetSkaterProfileInfo player=<currentSkaterProfileIndex>
			if ( <name> = custom )
				make_sprite_menu_item text="View Stats" id=menu_edit_stats pad_choose_script=create_stats_menu
				make_text_sprite texture=<stats_icon> parent=menu_edit_stats
				SetScreenElementProps {
					id=menu_edit_stats
					event_handlers = [
						{ focus	PlayHelperDesc params={ view_stats_helper_desc use_bg}}
						{ unfocus StopHelperDesc }
					]
				}
			endif
		endif
		if not CD
			make_sprite_menu_item text="Goto Restart" id=menu_skip_to_restart pad_choose_script=launch_restart_menu
			make_text_sprite texture=<model_icon> parent=menu_skip_to_restart
			SetScreenElementProps {
				id=menu_skip_to_restart
				event_handlers = [
					{ focus	PlayHelperDesc params={ goto_restart_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		endif
	endif

	//    if not CD
	make_sprite_menu_item text="Debug Menu" id=debug_menu pad_choose_script = create_debug_menu
	make_text_sprite texture=<model_icon> parent=debug_menu

	make_sprite_menu_item text="Test Menu" id=test_menu pad_choose_script=create_test_menu
	make_text_sprite texture=<model_icon> parent=test_menu
	//	endif

	if InNetGame
		;if GameModeEquals is_goal_attack
		;	make_sprite_menu_item text="View Goals"  id=menu_view_goals pad_choose_script=create_view_selected_goals_menu
		;	make_text_sprite texture=<view_icon> parent=menu_view_goals
		;endif

		make_sprite_menu_item text="Chat Message" id=menu_chat pad_choose_script=launch_chat_keyboard
		make_text_sprite texture=<name_cat_icon> parent=menu_chat
		SetScreenElementProps {
			id=menu_chat
			event_handlers = [
				{ focus	PlayHelperDesc params={ chat_msg_helper_desc use_bg}}
				{ unfocus StopHelperDesc }
			]
		}

		if Not OnServer
			if Not IsObserving
				if InInternetMode
					if IsTrue bootstrap_build
						if not GoalManager_HasActiveGoals
							make_sprite_menu_item text="Observe" id=menu_network_observe_select pad_choose_script=chose_observe not_focusable=not_focusable
							make_text_sprite texture=<options_icon> parent=menu_network_observe_select
						endif
					else
						if not GoalManager_HasActiveGoals
							make_sprite_menu_item text="Observe" id=menu_network_observe_select pad_choose_script=chose_observe
							make_text_sprite texture=<options_icon> parent=menu_network_observe_select
						endif
					endif
					if ScreenElementExists id=menu_network_observe_select
						SetScreenElementProps {
							id=menu_network_observe_select
							event_handlers = [
								{ focus	PlayHelperDesc params={ observe_helper_desc use_bg}}
								{ unfocus StopHelperDesc }
							]
						}
					endif
				endif
			endif
		endif

		/*if OnServer
			if IsHost
				if GameModeEquals is_lobby
					GetPreferenceChecksum pref_type=network device_type
					switch <checksum>
						case device_sony_modem
						case device_usb_modem
							do_nothing
						default
							if InInternetMode
								if IsTrue bootstrap_build
									make_sprite_menu_item text="Sit Out" id=menu_network_sit_select pad_choose_script=launch_network_sit_out_menu not_focusable=not_focusable
									make_text_sprite texture=<end_icon> parent=menu_network_sit_select
								else
									make_sprite_menu_item text="Sit Out" id=menu_network_sit_select pad_choose_script=launch_network_sit_out_menu
									make_text_sprite texture=<end_icon> parent=menu_network_sit_select
								endif
								SetScreenElementProps {
								id=menu_network_sit_select
								event_handlers = [
									{ focus	PlayHelperDesc params={ sitout_helper_desc use_bg}}
									{ unfocus StopHelperDesc }
									]
								}
							endif
					endswitch
				endif
			endif
		endif*/
		make_sprite_menu_item text="Quit" id=menu_quit pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=launch_quit_game_dialog }
		make_text_sprite texture=<quit_icon> parent=menu_quit
		SetScreenElementProps {
			id=menu_quit
			event_handlers = [
				{ focus	PlayHelperDesc params={ quit_helper_desc use_bg}}
				{ unfocus StopHelperDesc }
			]
		}
	else
		if CustomParkMode testing
			printf "PARK EDITOR TEST PLAY MENU"
			make_sprite_menu_item text="Back to editor" id=menu_skateshop pad_choose_script=menu_confirm_quit pad_choose_params={yes_script=exit_test_play}
			make_text_sprite texture=<back_icon> parent=menu_skateshop
			SetScreenElementProps {
				id=menu_skateshop
				event_handlers = [
					{ focus	PlayHelperDesc params={ back_editor_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
		else
			//			if not (DEMO_BUILD)
			make_sprite_menu_item text="Quit" id=menu_skateshop pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=menu_confirm_quit }
			make_text_sprite texture=<quit_icon> parent=menu_skateshop
			SetScreenElementProps {
				id=menu_skateshop
				event_handlers = [
					{ focus	PlayHelperDesc params={ quit_helper_desc use_bg}}
					{ unfocus StopHelperDesc }
				]
			}
			//			endif
		endif
	endif

	kill_blur start=0
	build_pause_menu_parts show_deck=show_deck
endscript

script prompt_launch_cag_pause_load
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif


	create_dialog_box { title="Load Goals"
		text='Warning !\nAny unsaved changes to your current CREATED GOALS will be lost.\nContinue ?'
		pos=(320,240)
		text_dims = (400,0)
		just=[center center]
		text_rgba=[88 105 112 128]
		text_scale=1
		buttons=[ 	{ font=small text="Yes" pad_choose_script=launch_pause_menu_load_created_goals }
			{ font=small text="No"  pad_choose_script=no_launch_cag_pause_load }
		]
	}

endscript

script no_launch_cag_pause_load
	dialog_box_exit

	create_pause_menu
endscript

script edit_skater_options_menu

	hide_current_goal
	FormatText ChecksumName=title_icon "%i_edit_skater" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_option_menu title="EDIT SKATER" title_icon=<title_icon>

	pause_show_deck parent=current_menu_anchor no_slide

	if levelis load_skateshop
		pad_back_script = skateshop_practice_pause_menu
	else
		pad_back_script = create_pause_menu
	endif

	GoalManager_HideGoalPoints
	GoalManager_HidePoints
	unhide_root_window

	SetScreenElementProps { id=options_menu
		event_handlers=[
			{ pad_back     generic_menu_pad_back params={ callback=<pad_back_script> }}
		]
	}


	if ( GoalManager_HasActiveGoals )
		tricks_uneditable=1
	else
		if ( driving_parked_car=1 )
			tricks_uneditable=1
		else
			if GoalManager_goalIsActive name=TrickAttack
				tricks_uneditable=1
			endif
		endif
	endif

	if GotParam tricks_uneditable
		make_theme_menu_item {
			text="View Tricks"
			id=menu_edit_tricks
			pad_choose_script=create_edit_tricks_menu
		}
		if not GameModeEquals is_singlesession
			make_theme_menu_item {
				text="Create A Trick"
				id=menu_cat
				pad_choose_script=create_pre_cat_menu
				not_focusable=not_focusable
			}
		endif
	else
		make_theme_menu_item {
			text="Edit Tricks"
			id=menu_edit_tricks
			pad_choose_script=create_edit_tricks_menu
		}

		if not GameModeEquals is_singlesession
			make_theme_menu_item {
				text="Create A Trick"
				id=menu_cat
				pad_choose_script=create_pre_cat_menu
			}
		endif
	endif

	select_skater_get_current_skater_name
	if (<current_skater> = custom)
		if not LevelIs load_sk5ed_gameplay //Rulon: (TT13186) returning from cas_bedroom to sk5ed not supported
			make_theme_menu_item {
				text="Edit Appearance"
				id=menu_edit_appearance
				pad_choose_script=maybe_edit_skater
				pad_choose_params={ yes_script=pause_launch_level yes_params={level=load_cas} }
			}


			if ( ( GetGlobalFlag flag=BOARDSHOP_UNLOCKED ) || (all_levels_unlocked=1) )
				make_theme_menu_item {	text="Skateshop"
					id=menu_shop
					pad_choose_script= maybe_edit_skater
					pad_choose_params={ yes_script=pause_launch_level yes_params={level=load_boardshop} }
				}
			else
				if cd
					make_theme_menu_item {	text="Skateshop"
						id=menu_shop
						pad_choose_script=null_script
						not_focusable=not_focusable
					}
				endif
			endif
		endif
	endif


	build_top_bar pos=(-400,62)

	DoScreenElementMorph id=top_bar_anchor time=0.2 pos=(0,62)

	FireEvent type=focus target=current_menu_anchor
endscript

script maybe_edit_skater

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	wait 2 frames
	create_dialog_box { title="Edit Confirmation"
		text="Exit the current level to change options?"
		pos=(320,240)
		just=[center center]
		text_rgba=[88 105 112 128]
		text_scale=1
		;text_dims=(320,0)
		pad_back_script = no_edit_skater
		buttons=[ 	{ font=small text="Yes" pad_choose_script=<yes_script> pad_choose_params=<yes_params>}
			{ font=small text="No"  pad_choose_script=no_edit_skater }
		]
	}
endscript

script no_edit_skater
	dialog_box_exit
	wait 1 frame
	edit_skater_options_menu
endscript

music_was_paused = 0
inside_pause = 0

script create_mp_pause_menu
	SetButtonEventMappings unblock_menu_input
	make_new_pause_menu menu_id=pause_menu vmenu_id=pause_vmenu pad_back_script=handle_start_pressed pos=(320,540)

	kill_start_key_binding

	create_helper_text generic_helper_text
	set_theme_icons

	add_music_track_text pos=(900,350)

	; create pause menu items
	make_sprite_menu_item text="Continue" id=menu_continue pad_choose_script=handle_start_pressed
	make_text_sprite texture=<continue_icon> parent=menu_continue

	;	if GameModeEquals is_lobby
	;		make_sprite_menu_item text="Start Game" id=menu_network_start_select pad_choose_script=network_game_options_selected
	;		make_text_sprite texture=PA_network parent=menu_network_start_select
	;
	;		make_sprite_menu_item text="Change level" id=menu_level_select pad_choose_script=launch_level_select_menu
	;		make_text_sprite texture=DE_level parent=menu_level_select
	;	else
	make_sprite_menu_item text="End Current Game" id=menu_network_end_select pad_choose_script=network_end_game_selected
	make_text_sprite texture=<end_icon> parent=menu_network_end_select
	;	endif

	;	if GameModeEquals is_lobby
	;		if IsHost
	/*
	make_sprite_menu_item text="Pro Trick Objects" id=pro_trick_obj_menu pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=create_pro_trick_objects_menu }
	make_text_sprite texture=PA_pro parent=pro_trick_obj_menu
	*/
	;		endif

	make_sprite_menu_item text="Options" id=menu_mp_options pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=create_options_menu }
	make_text_sprite texture=<options_icon> parent=menu_mp_options

	make_sprite_menu_item text="Quit" id=menu_skateshop pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=menu_confirm_quit }
	make_text_sprite texture=<quit_icon> parent=menu_skateshop

	; now, do 'entrance' animation
	; (Note: Any number of scripts can be running concurrently upon	a single screen element,
	; so be wary about running the exact same script twice)

	;set_menu_bg
	RunScriptOnScreenElement id=pause_menu menu_onscreen
endscript

// @script | exit_pause_menu | Animates out of and destroys the pause menu
script exit_pause_menu menu_id=current_menu_anchor
	change check_for_unplugged_controllers = 0
	// UnLoad_pause_menu_textures <- taken out for now...don't load and unload textures within the level

	//PrintEventLog
	if ScreenElementExists id=current_menu_anchor
		FireEvent type=unfocus target=current_menu_anchor
	endif

	// Note: debouncing currently affects all skaters
	// should only affect the one that pressed the buttons....
	Debounce X time = 0.3       // debounce X, so we don't jump when exiting pause menu
	Debounce Triangle time = 0.3

	pause_menu_gradient off

	change inside_pause = 0
	change no_focus_sound = 1
	change viewer_buttons_enabled = 1	 // Mick, when exiting the pasue menu, turnf the viewer buttons on again


	GoalManager_ShowGoalPoints
	GoalManager_ShowPoints
	unhide_3d_goal_arrow
	unhide_landing_msg
	unhide_stat_message
	unhide_chaper_intro_title
	unhide_tips
	goal_skate_unhide_letters
	unhide_combo_letters
	unhide_death_msg
	unhide_comp_text

	unpause_trick_text

	if InNetGame
		if Not IsObserving
			if ObjectExists id=Skater  // Mick: patch for fake_net
				Skater:NetEnablePlayerInput
			endif
		endif
	endif

	UnpauseGame



	// add any temp special tricks
	possibly_add_temp_special_trick

	PauseStream 0


	if GoalManager_HasActiveGoals
		if ( music_was_paused = 0 )
			PauseMusic 0
		endif
	else
		if IsTrue ALWAYSPLAYMUSIC
			if ( music_was_paused = 0 )
				PauseMusic 0
			endif
		endif
	endif


	unpause_rain

	if not InNetGame
		unpause_trick_text
	endif


	Unpause_Balance_Meter
	unpause_run_timer


	// unhide any speech boxes
	if ObjectExists id=speech_box_anchor
		DoScreenElementMorph id=speech_box_anchor scale=1
		; RunScriptOnScreenElement id=speech_box_anchor unhide_screen_element
	endif
	if ObjectExists id=goal_start_dialog
		DoScreenElementMorph id=goal_start_dialog scale=1
		; RunScriptOnScreenElement id=goal_start_dialog unhide_screen_element
	endif
	if ObjectExists id=ped_speech_dialog
		DoScreenElementMorph id=ped_speech_dialog scale=1
		; RunScriptOnScreenElement id=ped_speech_dialog unhide_screen_element
	endif

	if ScreenElementExists id=cutscene_camera_hud_anchor
		if ( camera_hud_is_hidden = 1 )
			change camera_hud_is_hidden=0
			DoScreenElementMorph id=cutscene_camera_hud_anchor alpha=1
		endif
	endif

	if ScreenElementExists id=nightvision_hud_anchor
		if ( nightvision_hud_is_hidden = 1 )
			change nightvision_hud_is_hidden=0
			DoScreenElementMorph id=nightvision_hud_anchor alpha=1
		endif
	endif

	// unhide goal hud elements
	show_goal_panel_messages
	;if GoalManager_HasActiveGoals
	;    DoScreenElementMorph {
	;		id=the_time
	;		restore_alpha
	;	}
	;endif

	if not RunningReplay
		GoalManager_UnPauseAllGoals
	endif

	// GJ:  if we're in the viewer mode (either the level viewer
	// or the object viewer) this resets it so that the skater
	// cam has control...
	// Dan:  removed as it mucks up the vehicle/skater camera choice
	// SetViewMode 0

	// menu may have already been destroyed
	if ObjectExists id=<menu_id>
		DestroyScreenElement id=<menu_id>
	endif

	;	fadetoblack off

	// kill any cam started by a menu
	; KillSkaterCamAnim current
	kill_pause_menu_cams

	SetScreenElementProps id=root_window tags={ menu_state=off }

	if Not InMultiPlayerGame
		GoalManager_ShowPoints
		if not GoalManager_HasActiveGoals
			GoalManager_ShowGoalPoints
		else
			GoalManager_HideGoalPoints
		endif
	endif

	// PARKED4:
	if CustomParkMode editing
		if not GotParam DoNotSwitchEditorState
			SetParkEditorState state=edit
			SetParkEditorPauseMode unpause
		endif
	endif
	restore_start_key_binding

	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=1
	endif

	// should we hide the hud?
	if ( HIDEHUD = 1 )
		printf "hiding"
		hide_root_window
	endif

	if GetGlobalFlag flag=NO_DISPLAY_HUD
		GoalManager_HideGoalPoints
		GoalManager_HidePoints

		;if not InNetGame
		;pause_trick_text
		;endif

	endif


	if not GetGlobalFlag flag=NO_DISPLAY_CHATWINDOW
		unhide_console_window
	else
		hide_console_window
	endif

	if not GetGlobalFlag flag=NO_DISPLAY_NET_SCORES
		unhide_net_scores
	else
		hide_net_scores
	endif


	// Since UnpauseGame restores all vibrations, the individual vibrations must be
	// toggled on, then off to turn them off individually
	/*if not VibrationIsOn 0
		VibrationOn 0
		VibrationOff 0
	endif

	if not VibrationIsOn 1
		VibrationOn 1
		VibrationOff 1
	endif*/
	change check_for_unplugged_controllers = 1
endscript


script pause_launch_level
	Skater:StatsManager_Reset

	if ( (<level> = load_boardshop) || (<level> = load_cas) )
		temp=<level>
		GetCurrentLevel
		array=return_to_level
		SetArrayElement arrayname=array index=0 newvalue=<level>
		level=<temp>
	endif

	change_level <...>
endscript

// this script kills any cams that might have been played during
// the pause menu
script kill_pause_menu_cams
	kill_proset_cams
endscript

script set_custom_restart
	Skater:SetCustomRestart Set
endscript

script skip_to_custom_restart
	Skater:SkipToCustomRestart
endscript

// ************************************
//      Restart menu
// ************************************

// @script | skip_to_restart_menu | skeleton of skip to restart menu
// filled in by code
script launch_restart_menu
	RunScriptOnScreenElement id=current_menu_anchor animate_out callback=create_restart_menu
endscript


// @script | create_restart_menu |
script create_restart_menu
	hide_current_goal
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_scrolling_menu title="RESTART" title_icon=<title_icon> dims=(600,237) pos=(229,80) right_bracket_z=1

	SetScreenElementProps { id=sub_menu
		event_handlers=[
			{ pad_back           generic_menu_pad_back params={ callback=create_pause_menu } }
		]
	}

	create_helper_text generic_helper_text
	kill_start_key_binding

	AddRestartsToMenu initial_scale=1.0

	theme_menu_add_item text="Done" pad_choose_script=create_pause_menu no_bg last_item=last_item centered=centered

	finish_themed_scrolling_menu
endscript

script skip_to_selected_restart
	ResetSkaters <...>  // passing in "node_number"
	exit_pause_menu
endscript

// just preview the restart point without exiting the menu
// used by the "focus" command, so just scrolling up and down the restart points will
script preview_restart
	pulse_blur start =200 speed = 5
	ResetSkaters <...>  // passing in "node_number"
	SetProps rgba=[128 128 0 128]
	DoMorph time=.25 scale=1.0
endscript

script scale_down_restart
	//    SetProps rgba=[128 128 128 128]
	SetProps rgba=[88 105 112 128]
	DoMorph time=.25 scale=.8
endscript



// @script | launch_pause_menu | Used to return to the pause menu from a sub-menu.  Note that
// this script always returns to the main pause menu.  If you want to return to some other sub-menu,
// then you should create a similar script with a different callback value.
script launch_pause_menu cur_menu=current_menu_anchor
	//RunScriptOnScreenElement id=<cur_menu> animate_out params={menu_id=<cur_menu>} callback=create_pause_menu
	printf "why was this called?"
endscript

// ************************************
//		Quit to the skateshop
// ************************************


script menu_confirm_quit {
		yes_script=level_select_change_level_quit
		no_script=menu_quit_no
		back_script=menu_quit_no
		title="QUIT?"
		text="Are you sure?"
		text_dims=(200,0)
		params={ }
	}

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if not istrue bootstrap_build
		create_error_box { title=<title>
			text=<text>
			pos=(310 ,240)
			just=[center center]
			text_rgba=[88 105 112 128]

			text_dims=<text_dims>
			pad_back_script = <back_script>
			pad_back_params = <params>
			buttons=[ 	{ font=small text="Yes" pad_choose_script=<yes_script> pad_choose_params={ level=load_skateshop <params> } }
				{ font=small text="No"  pad_choose_script=<no_script> pad_choose_params=<params> }
			]
		}
		;create_helper_text generic_helper_text_left_right parent=dialog_box_anchor
	else
		create_error_box { title=<title>
			text="Exit Demo?"
			pos=(310 ,240)
			just=[center center]
			text_rgba=[88 105 112 128]


			pad_back_script = <back_script>
			buttons=[ 	{ font=small text="Yes" pad_choose_script=bootstrap_quit }
				{ font=small text="No"  pad_choose_script=<back_script> }
			]
		}
	endif
endscript

script menu_confirm_quit_park_editor {
		yes_script=launch_park_editor_save_park_sequence
		no_script=parked_quit
		back_script=menu_quit_no
		title="Save Park?"
	}

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if IsParkUnsaved
		if isxbox
			error_text="System Link Play may cause you to lose unsaved changes to this park. Save it now?"
		else
			if isngc
				error_text="Do you want to save your park before quitting?"
			else
				error_text="Playing online or downloading a new park will cause you to lose unsaved changes to this park. Save it now?"
			endif
		endif

		create_error_box { title=<title>
			text=<error_text>
			pos=(310 ,240)
			just=[center center]
			text_rgba=[88 105 112 128]


			pad_back_script = <back_script>
			buttons=[ 	{ font=small text="Yes" pad_choose_script=<yes_script> pad_choose_params={ level=load_skateshop } }
				{ font=small text="No"  pad_choose_script=<no_script>  pad_choose_params={ level=load_skateshop } }
			]
		}
		;create_helper_text generic_helper_text_left_right parent=dialog_box_anchor
	else
		<no_script> level=load_skateshop
	endif
endscript

// This script gets run with <level>=load_skateshop when "yes" is pressed in the
// above script
// we first quit any network game, and then do the passed change level
// (really we could ahve the "load_skateshop" in here....
script level_select_change_level_quit

	// Mick - display a blank screen when quitting
	// can't display a real loading screen at this point
	// as there is not enough memory to load it
	DisplayLoadingScreen blank

	GoalManager_DeactivateAllGoals
	GoalManager_LevelUnload

	MakeSkaterGoto SkaterInit
	SetButtonEventMappings block_menu_input

	//    quit_network_game

	// The rail sectors are cloned sectors, which get cleaned up by some lower level cleanup code
	// even if this were not called, but that would leave the rail editor with dangling pointers,
	// so call this so that it can nullify them.
	RailEditor:DestroyEditedRailSectors

	printf "leaving and destroying server"

	//	PARKED4:
	//	This fixes running out of memory when loading the loading screen.
	SetParkEditorState state=off

	;UnpauseGame	// tried it... seems ok to comment this out. Z
	chosen_leave_server

	SetGameType career
	SetCurrentGameType
	SetStatOverride	// Put stats back at regular amounts

	// Now, create a local server
	setservermode on
	StartServer
	// Join our local server
	SetJoinMode	JOIN_MODE_PLAY

	printf "attempting to join server"


	JoinServer
	printf "waiting"
	// Wait until we have joined our local server
	begin
		printf "waiting 1 frame"

		if JoinServerComplete
			break
		else
			Wait 1
		endif
		printf "still waiting"
	repeat

	printf "attempting to change level"

	level_select_change_level <...>


	SetButtonEventMappings unblock_menu_input

endscript


script menu_quit_no
	generic_menu_pad_back_sound
	dialog_box_exit
	;exit_pause_menu
	create_pause_menu
endscript

script menu_cash_no
	dialog_box_exit
	create_options_menu
endscript

script bootstrap_quit
	Dialog_Box_Exit
	SetButtonEventMappings block_menu_input
	Skater:DisablePlayerInput
	PauseGame
	Cleanup
	DisplayLoadingScreen "loadscrn_marketing"
	Wait 5 seconds
	exitdemo
endscript

// ************************************
//      Set pro skater menu
// ************************************

// @script | launch_set_pro_skater_menu | skeleton of set pro skater menu
// filled in by code
script launch_set_pro_skater_menu
	RunScriptOnScreenElement id=current_menu_anchor animate_out callback=create_set_pro_skater_menu
endscript

script make_select_set_pro_skater_line
	make_text_sub_menu_item text = <text> pad_choose_script=set_pro_skater pad_choose_params=<...>
endscript


// @script | create_set_pro_skater_menu |
script create_set_pro_skater_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	make_new_menu menu_id=set_pro_skater_menu vmenu_id=set_pro_skater_vmenu menu_title="PRO SKATERS"
	set_theme_icons

	// Define pad_back event
	if LevelIs load_skateshop
		KillSkaterCamAnim all
		PlaySkaterCamAnim name=SS_SkaterChoosing play_hold

		SetScreenElementProps {
			id=set_pro_skater_menu
			event_handlers = [ { pad_back		create_main_menu } ]
			replace_handlers
		}

		make_text_sub_menu_item { text="Continue"
			pad_choose_script=skateshop_transition
			pad_choose_params={ new_menu_script=launch_ss_menu }
		}

	else
		SetScreenElementProps {
			id=set_pro_skater_menu
			event_handlers = [ { pad_back		create_debug_menu } ]
			replace_handlers
		}
	endif
	add_set_pro_skater_to_menu

	RunScriptOnScreenElement id=current_menu_anchor animate_in params={ final_pos=(320, 134) }
endscript

script set_pro_skater
	printf "Set pro skater here"
	load_pro_skater { profile=0 skater=0 <...> }

	// in the skateshop we need to go to the next menu
	if LevelIs load_skateshop
		printf "we're in the skateshop"
		launch_ss_menu
	else
		exit_pause_menu
	endif
endscript


// ************************************
//      Change skater appearance menu
// ************************************

// @script | launch_change_skater_appearance_menu | skeleton of change skater appearance menu
// filled in by code
script launch_change_skater_appearance_menu
	RunScriptOnScreenElement id=current_menu_anchor animate_out callback=create_change_skater_appearance_menu
endscript

script make_select_change_skater_appearance_line
	make_text_sub_menu_item text = <text> pad_choose_script=change_skater_appearance pad_choose_params={<...>}
endscript


// @script | create_change_skater_appearance_menu |
script create_change_skater_appearance_menu

	make_new_menu menu_id=change_skater_appearance_menu vmenu_id=change_skater_appearance_vmenu menu_title="APPEARANCE"
	set_theme_icons
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps { id=change_skater_appearance_menu event_handlers=[
			{pad_back       create_pause_menu}
		]
	}
	add_change_skater_appearance_to_menu

	RunScriptOnScreenElement id=current_menu_anchor animate_in
endscript

script change_skater_appearance
	printf "Change skater appearance here"
	InitSkaterModel skater=0 <...>
	exit_pause_menu
	//    RunScriptOnScreenElement id=current_menu_anchor menu_offscreen
endscript


// ************************************
//     Debug Menu
// ************************************
//script create_pro_trick_objects_menu
//    RunScriptOnScreenElement id=main_menu_anchor menu_offscreen callback=create_pro_trick_objects_menu2
//endscript

script create_debug_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	pause_menu_gradient off

	make_new_menu {
		menu_id=debug_menu
		vmenu_id=debug_vmenu
		menu_title="DEBUG"
		type=VScrollingMenu
		dims=(200, 350)
		padding_scale=.95
		pos=(243,50)
	}
	SetScreenElementProps { id=debug_menu
		event_handlers=[
			{pad_back  generic_menu_pad_back params={ callback=create_pause_menu}}
		]
	}
	set_theme_icons

	// my funny scripts
	make_text_sub_menu_item text="Slalom Mode" id=menu_slalommode pad_choose_script = slalom_mode
	make_text_sub_menu_item text="Luge Mode" id=menu_lugemode pad_choose_script = luge_mode

	make_text_sub_menu_item text="Auto Rail Level" id=menu_autoraillevel pad_choose_script = autorail_level
	make_text_sub_menu_item text="Time Of Day" id=menu_timeofday pad_choose_script = launch_timeofday_menu
	make_text_sub_menu_item text="Lighting Tool" id=menu_lighting pad_choose_script = launch_lighting_tool


	// GJ:  there's a distinction between changing the appearance and changing the profile
	// changing appearance probably won't be that useful, so i'm going to comment it out
	// for now to reduce confusion.
	//	make_text_sub_menu_item text="Change Skater Appearance" id=menu_change_skater_appearance pad_choose_script = launch_change_skater_appearance_menu

	//    make_text_sub_menu_item text="Create-a-Skater" id=menu_create_a_skater pad_choose_script = launch_cas_menu
	make_text_sub_menu_item text="Set Pro Skater" id=menu_set_pro_skater pad_choose_script = create_set_pro_skater_menu
	make_text_sub_menu_item text="Max All Stats" id=menu_max_all_stats pad_choose_script = debug_menu_max_all_stats
	//    make_text_sub_menu_item text="Menu Test" id=menu_test pad_choose_script=launch_menu_test
	make_text_sub_menu_item text="Rail Display Toggle" pad_choose_script=toggle_rails
	make_text_sub_menu_item text="Bouncy Object Debug Display Toggle" pad_choose_script=toggle_rigidbody
	make_text_sub_menu_item text="Toggle Profiler" id=menu_profiler pad_choose_script=launch_toggle_profiler
	make_text_sub_menu_item text="Toggle Poly Count" id=menu_poly pad_choose_script=show_poly_count
	make_text_sub_menu_item text="Toggle Free Memory" id=menu_mem pad_choose_script=show_free_mem

	if CD // editor's day build
		make_text_sub_menu_item text="Start AutoTest" id=menu_start_autotest pad_choose_script=menu_start_autotest
		make_text_sub_menu_item text="Stop AutoTest" id=menu_stop_autotest pad_choose_script=menu_stop_autotest
	endif

	//    make_text_sub_menu_item text="Dump MemCard ScreenShots" id=menu_dumpshots pad_choose_script=launch_dumpshots

	make_text_sub_menu_item text="Wireframe Toggle" pad_choose_script=toggle_wireframe
	make_text_sub_menu_item text="Show Vert Polys" pad_choose_script=toggle_show_polys 		pad_choose_params={showscript=show_vert}
	make_text_sub_menu_item text="Show Wallride Polys" pad_choose_script=toggle_show_polys 	pad_choose_params={showscript=show_wallride}
	make_text_sub_menu_item text="Show Trigger Polys" pad_choose_script=toggle_show_polys 	pad_choose_params={showscript=show_trigger}
	make_text_sub_menu_item text="Show Camera Polys" pad_choose_script=toggle_show_polys 	pad_choose_params={showscript=show_camera_collide}
	make_text_sub_menu_item text="Show Not Skateable" pad_choose_script=toggle_show_polys 	pad_choose_params={showscript=show_not_skatable}
	make_text_sub_menu_item text="Show skater shadow" pad_choose_script=toggle_show_polys 	pad_choose_params={showscript=show_skater_shadow}
	make_text_sub_menu_item text="Show no skater shadow" pad_choose_script=toggle_show_polys 	pad_choose_params={showscript=show_no_skater_shadow}
	make_text_sub_menu_item text="Show no skater shadow wall" pad_choose_script=toggle_show_polys 	pad_choose_params={showscript=show_no_skater_shadow_wall}
	make_text_sub_menu_item text="CheckForHoles (Slow)" pad_choose_script=hole_check
	make_text_sub_menu_item text="Hide HUD" pad_choose_script=debug_menu_hide_hud

	make_text_sub_menu_item text="Done" id=menu_done pad_choose_script=create_pause_menu

	RunScriptOnScreenElement id=current_menu_anchor animate_in params={ final_pos=(320, 134) }
endscript

script debug_menu_hide_hud
	UnpauseGame
	exit_pause_menu
	hide_root_window
endscript


// Max out every skater stat via the global debug override (10 = max).
// Reversible: SetStatOverride with no value restores normal stats.
script debug_menu_max_all_stats
	SetStatOverride 10
	PlaySound menu03 vol=100
endscript

script create_test_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	pause_menu_gradient off
	dialog_box_exit

	make_new_menu {
		menu_id=debug_menu
		vmenu_id=debug_vmenu
		menu_title="TEST"
		type=VScrollingMenu
		dims=(200, 350)
		padding_scale=.95
		pos=(243,50)
	}
	SetScreenElementProps { id=debug_menu
		event_handlers=[
			{pad_back   	create_pause_menu}
		]
	}
	set_theme_icons

	// there are so many items in the following list, that it will overflow the script
	// compact pool...  from now on, the artists should use the humans/animals/cars
	// submenus
	//	make_text_sub_menu_item text="View Models" id=menu_view_models pad_choose_script = launch_view_models_menu
	make_text_sub_menu_item text="View Humans" id=menu_view_human_models pad_choose_script = launch_view_models_menu pad_choose_params={ model_set=human }
	make_text_sub_menu_item text="View Animals" id=menu_view_animal_models pad_choose_script = launch_view_models_menu pad_choose_params={ model_set=animal }
	make_text_sub_menu_item text="View Cars" id=menu_view_car_models pad_choose_script = launch_view_models_menu pad_choose_params={ model_set=car }

	make_text_sub_menu_item text="View Cutscenes" id=menu_view_cutscenes pad_choose_script = launch_view_cutscenes_menu
	make_text_sub_menu_item text="dialog box" id=menu_dialog pad_choose_script = create_test_dialog
	make_text_sub_menu_item text="Interface Themes" id=menu_themes pad_choose_script = swap_themes_menu
	make_text_sub_menu_item text="Scrolling Menu" id=menu_scroll pad_choose_script = test_scrolling_menu
	make_text_sub_menu_item text="Face Texture Test" id=menu_face_texture pad_choose_script = face_texture_test
	make_text_sub_menu_item text="View High Scores" id=menu_hs_displaye pad_choose_script = high_scores_menu_create pad_choose_params={ new_initials="ABC" }

	make_text_sub_menu_item text="Keyboard" pad_choose_script=launch_keyboard
	if CareerLevelis LevelNum_Sch
		make_text_sub_menu_item text="Screensaver" pad_choose_script=screensaver
	endif

	make_text_sub_menu_item text="Done" id=menu_done pad_choose_script=create_pause_menu

	RunScriptOnScreenElement id=current_menu_anchor animate_in params={ final_pos=(320, 134) }
endscript

script luge_mode
	Makeskatergoto ShoppingCart_Start params = { racemode = luge CarMode turn_friction = 0 startspeed = 20 accelerate_to = 800 }
	Skater:CanBrakeOff
endscript

script slalom_mode
	MakeSkaterGoTo ShoppingCart_Start Params = { racemode = slalom CarMode Turn_Friction = 0 StartSpeed = 20 Accelerate_To = 450 }
	Skater:CanBrakeOff
endscript

script autorail_level
	Autorail
endscript

script ScreenSaver
	spawnscript create_startup_menu
	exit_pause_menu
endscript

script  hole_check
	checkforholes
	create_pause_menu
endscript

script launch_toggle_profiler
	ToggleMetrics
	create_pause_menu
endscript

script launch_Dumpshots
	Dumpshots
	create_pause_menu
endscript


script toggle_rails
	ToggleRails
	pulse_item
endscript

script toggle_rigidbody
	ToggleRigidBodyDebug
	pulse_item
endscript

script toggle_wireframe
	togglerendermode
	show_all
	pulse_item
endscript

free_mem_on=0

script show_free_mem
	if ( free_mem_on = 0 )
		change free_mem_on=1

		;GoalManager_HidePoints
		DoScreenElementMorph {
			id=the_score_sprite
			scale=0
		}
		DoScreenElementMorph {
			id=the_score
			scale=0
		}
		DoScreenElementMorph {
			id=cash_goal_sprite
			scale=0
		}
		DoScreenElementMorph {
			id=goal_points_text
			scale=0
		}
		DoScreenElementMorph {
			id=cash_text
			scale=0
		}

		SetScreenElementLock id=root_window off

		if ObjectExists id=free_mem_anchor
			DestroyScreenElement id=free_mem_anchor
			wait .2 seconds
		endif

		CreateScreenElement {
			type=ContainerElement
			parent=root_window
			id=free_mem_anchor

			pos=(30,40)
			just=[center center]
			internal_just=[left center]
		}

		CreateScreenElement {
			type=TextElement
			parent=free_mem_anchor

			pos=(0,-15)
			text="Free Memory"
			font=dialog
			rgba=[60 60 100 100]
			just=[left center]
			scale=0.8
		}


		CreateScreenElement {
			type=TextElement
			parent=free_mem_anchor
			id=topdown_heap_text
			pos=(0,0)
			text=""
			font=dialog
			rgba=[58 108 58 100]
			just=[left center]
			scale=0.8
		}
		CreateScreenElement {
			type=TextElement
			parent=free_mem_anchor
			id=script_heap_text
			pos=(0,15)
			text=""
			font=dialog
			rgba=[58 108 58 100]
			just=[left center]
			scale=0.8
		}

		SetScreenElementLock id=root_window on

		SpawnScript RefreshFreeMemoryDisplay
	else
		change free_mem_on=0
		KillSpawnedScript name=RefreshFreeMemoryDisplay

		wait .2 seconds
		if ObjectExists id=free_mem_anchor
			DestroyScreenElement id=free_mem_anchor
		endif

		DoScreenElementMorph {
			id=the_score_sprite
			scale=1
		}
		DoScreenElementMorph {
			id=the_score
			scale=1
		}
		DoScreenElementMorph {
			id=cash_goal_sprite
			scale=1
		}
		DoScreenElementMorph {
			id=goal_points_text
			scale=1
		}
		DoScreenElementMorph {
			id=cash_text
			scale=1
		}
	endif
endscript

freemem_script_lowest = 999999999

freemem_main_lowest = 999999999

script RefreshFreeMemoryDisplay interval=1.0
	begin
		DisplayFreeMem
		wait <interval> seconds
	repeat
endscript

script UpdateDisplayFreeMemory
	if ObjectExists id=free_mem_anchor
		FormatText ChecksumName=context_name "Script"
		if( <id>=<context_name> )
			;		if(<free_mem> < freemem_script_lowest)
			;			change freemem_script_lowest = <free_mem>
			;		endif
			FormatText textname=script_heap  "Script: %m (%nK) low: %o (%pK)" m=<free_mem> n=(<free_mem>/1024) o=min_free_mem p=(<min_free_mem>/1024) UseCommas
			SetScreenElementProps id=script_heap_text text=<script_heap>
		endif
		FormatText ChecksumName=context_name "Top Down"
		if( <id>=<context_name> )
			;		if(<free_mem> < freemem_main_lowest)
			;			change freemem_main_lowest = <free_mem>
			;		endif
			FormatText textname=main_heap  "Main: %m (%nK) low: %o (%pK)" m=<free_mem> n=(<free_mem>/1024) o=min_free_mem p=(<min_free_mem>/1024) UseCommas
			SetScreenElementProps id=topdown_heap_text text=<main_heap>
		endif
	else
		KillSpawnedScript id=RefreshFreeMemoryDisplay
		change free_mem_on=0
	endif

endscript


script toggle_show_all
	show_all
endscript

script toggle_show_polys showscript=show_vert
	<showscript>
	//	show_wallride
	//	show_wall_ridable
	//	show_trigger
	//	show_camera
	//	show_skatable
	//	show_not_skatable
	//	show_no_skater_shadow
	//	show_skater_shadow
	//	show_non_collidable
	//	show_collidable
	pulse_item
endscript

script launch_keyboard
	DestroyScreenElement id=current_menu_anchor
	create_onscreen_keyboard
endscript



// *********************************************************************
//
//                       Level select menu
//
// *********************************************************************

// @script | launch_level_select_menu | In order to create a sub-menu, we
// have to destroy the current menu first.  This script just destroys
// the main menu and sets a callback to create the sub-menu.
script launch_level_select_menu
	change check_for_unplugged_controllers = 0
	hide_current_goal

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if ScreenElementExists id=main_menu_bg_anchor
		DestroyScreenElement id=main_menu_bg_anchor
	endif

	if not LevelIs load_skateshop
		;fadetoblack on id=blackbox alpha=1 z_priority=999 time=0.4
		fadetoblack on id=fade_out_anchor create_script=create_chapter_fade_piece alpha=1 time=0.4
		wait 0.5 seconds
	endif

	load_level_select_textures_to_main_memory

	;pause_menu_gradient off

	SetMenuPadMappings [ 	active
		use_as_first
	]

	create_level_select_menu <...>
	change check_for_unplugged_controllers = 1
endscript

// @script | create_level_select_menu |
script create_level_select_menu pad_back_script=level_select_menu_exit

	printf "create_level_select_menu PARAMETERS = "

	// gotta have this to show warning message when changing levels in net games
	if InNetGame
		show_warning=show_warning
	endif


	SetScreenElementLock id=root_window off
	pulse_blur

	FormatText ChecksumName=highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	if ( in_server_options = 1 )
		from_server_options=from_server_options
		;change_gamemode_net	// can't do this! If it's causing a problem, talk to Zac.
		net_pad_back = 0
		pad_back_script=network_level_select_pad_back  // Mick:  Fix for recursion on backing out of net level select menu
	else
		RemoveParameter from_server_options
	endif

	if not GotParam no_cam_anim
		;level_select_play_cam
	endif

	// anchor for entire menu
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=level_select_anchor

		dims=(640, 480)
		pos=(320, 240)
	}

	AssignAlias id=level_select_anchor alias=current_menu_anchor

	create_helper_text generic_helper_text

	kill_start_key_binding

	// points/goal points stuff
	GoalManager_HidePoints
	hide_current_goal

	// bg parts
	FormatText ChecksumName=title_icon "%i_level" i=(THEME_PREFIXES[current_theme_prefix])
	build_theme_sub_title title="LEVEL SELECT" title_icon=<title_icon> right_bracket_z=4 static

	FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
	build_theme_box_icons icon_texture=<paused_icon> static

	;build_grunge_piece

	build_top_bar pos=(-400, 62) z_priority=4 static

	build_top_and_bottom_blocks top_z=3 static
	build_level_select_map

	/*// red lines
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=streak_2
		rgba=<highlight_rgba>
		just=[left top]
		pos=(0,100)
		scale = (10, 0.45)
		z_priority=4
        alpha=.8
	}
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=streak_2
		rgba=<highlight_rgba>
		just=[left top]
		pos=(0,368)
		scale = (10, 0.55)
		z_priority=4
	}*/


	// middle bit
	level_select_create_menu_block pad_back_script=<pad_back_script> <...>
	if IsTrue Demo_Build
		ForEachIn e3_level_select_menu_level_info do=level_select_menu_add_item	params=<...>
	else
		RemoveParameter text
		RemoveParameter name
		ForEachIn level_select_menu_level_info do=level_select_menu_add_item params=<...>
	endif
	DoScreenElementMorph id=level_select_anchor_middle pos=(320,640)


	if GotParam from_server_options
		level_select_vmenu:SetTags from_server_options
	endif


	// focus and animate parts in
	FireEvent type=focus target=level_select_vmenu
	spawnscript chap_moving_bg
	SetButtonEventMappings block_menu_input
	wait 3 gameframes
	SetScreenElementProps id=level_select_scrolling_menu reset_window_top
	PlaySound DE_MenuFlyUp vol=100
	PlaySound DE_PauseFlyIn vol=100
	DoScreenElementMorph id=top_bar_anchor time=0.2 pos=(0,62)
	DoScreenElementMorph id=level_select_anchor_middle pos=(320,240) time=0.2
	DoScreenElementMorph id=level_select_map_anchor time=0.3 alpha=1.0
	if not LevelIs load_skateshop
		;spawnscript fadetoblack params={ off id=blackbox }
		spawnscript fadetoblack params={ off id=fade_out_anchor }
		pause_menu_gradient off
	endif
	wait 0.2 seconds
	SetButtonEventMappings unblock_menu_input
endscript

script level_select_create_menu_block
	if ObjectExists id=level_select_anchor_middle
		DestroyScreenElement id=level_select_anchor_middle
	endif

	// anchor for middle bit
	CreateScreenElement {
		type=ContainerElement
		parent=level_select_anchor
		id=level_select_anchor_middle

		dims=(640, 480)
		pos=(320, 240)
	}

	// menus
	CreateScreenElement {
		type=VScrollingMenu
		parent=level_select_anchor_middle
		id=level_select_scrolling_menu

		pos=(480,120)
		just=[left top]
		dims=(300,203)
	}

	// menu bg
	theme_background parent=level_select_scrolling_menu width=1.5 pos=(0,-15) num_parts=7.1 z_priority=1 dark_menu=dark_menu static=static

	// status text
	if not GameModeEquals is_career
		//dont display this if all levels are unlocked
		get_num_levels_unlocked
		if not (all_levels_unlocked=1)
			if not  (<num_unlocked>=12)
				FormatText ChecksumName=unhighlight_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
				GetStackedScreenElementPos X id=bg_box_vmenu
				CreateScreenElement {
					type=ContainerElement
					parent=bg_box_vmenu
					pos=<pos>
				}

				CreateScreenElement {
					type=TextBlockElement
					parent=<id>

					text="Play \c1Story Mode\c0 to unlock more levels!"
					dims=(300,0)
					allow_expansion
					pos=(0,-20)
					line_spacing=0.7
					font=dialog
					rgba=<unhighlight_rgba>
					just=[center top]
					scale=0.8
					z_priority=4
				}
			endif
		endif
	endif

	CreateScreenElement {
		type=VMenu
		parent=level_select_scrolling_menu
		id=level_select_vmenu

		just=[left top]
		internal_just=[left center]
		event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=<pad_back_script> <...> } }
			{ pad_up 		generic_menu_up_or_down_sound params={ up } }
			{ pad_down		generic_menu_up_or_down_sound params={ down } }
			{ pad_back		generic_menu_pad_back_sound }
		]
		padding_scale=.9
		replace_handlers
	}
	AssignAlias id=level_select_vmenu alias=current_menu

	if GameModeEquals is_career
		goals_title_rgba=[88 105 112 128]
	else
		goals_title_rgba=[0 0 0 0]
	endif

endscript

script get_num_levels_unlocked

	GetArraySize level_select_menu_level_info
	<num_unlocked> = 0
	<index> = 0
	begin
		// skip the custom park
		if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
			if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_TestLevel )
				if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_Default )
					if not StructureContains structure=( (level_Select_menu_level_info[<index>])) DEVKIT_ONLY
						<level_num> = ( (level_select_menu_level_info[<index>]).level_num )
						if GetGlobalFlag flag=( (level_select_menu_level_info[<index>]).flag )
							<num_unlocked> = (<num_unlocked>+1)
						endif
					endif
				endif
			endif
		endif
		<index> = ( <index> + 1 )
	repeat (<array_size>)

	return num_unlocked = <num_unlocked>
endscript


script level_select_menu_add_item highlight_bar_pos=(0, 10) highlight_bar_scale=(1.6,0.7) created_park_number=11
	//don't add created park in career mode
	if ( ( GameModeEquals is_career ) && ( <level_num> = <created_park_number> ) )
		return
	endif

	// don't add secret levels if first one isn't unlocked
	/*if ( <level_num> > 20 )
		if not GetGlobalFlag flag=LEVEL_UNLOCKED_SC
			if IntegerEquals a=all_levels_unlocked b=0
				return
			endif
		endif
	endif*/

	if CD
		if ( <level_num> = 30 ) // Default level
			return
		endif
	endif
	// There are some levels we only want in the list on a Devkit. DEVKIT_LEVELS will be true on a CD - see Startup.q
	if (DEVKIT_LEVELS = 0)
		if GotParam DEVKIT_ONLY
			return
		endif
	endif
	// K: Append the number of created goals won to the level name if in create-goals mode.
	if GameModeEquals is_creategoals
		CountNumCreatedGoalsWon level=<level>
		if (<num_goals>)
			FormatText TextName=Text "%s  %d/%e" s=<text> d=<num_goals_won> e=<num_goals>
		endif
	endif

	if ( in_server_options = 1 )
		GetPreferenceChecksum pref_type=network goals
		if(<checksum> = goals_created)
			CountNumCreatedGoalsWon level=<level>
			if (<num_goals>)
				FormatText TextName=Text "%s  (%e)" s=<text> e=<num_goals>
			endif
		endif
	else
		if inNetGame
			GetPreferenceChecksum pref_type=network goals
			if(<checksum> = goals_created)
				CountNumCreatedGoalsWon level=<level>
				if (<num_goals>)
					FormatText TextName=Text "%s  (%e)" s=<text> e=<num_goals>
				endif
			endif
		endif
	endif

	;printstruct<...>
	if ( (<level_num> = <created_park_number>) || (<level_num> = (<created_park_number>+4)) )
		/*if GameModeEquals is_career
			if not ( (GetGlobalFlag flag=LEVEL_UNLOCKED_SC) && (IntegerEquals a=all_levels_unlocked b=0) )
				return
			endif
		endif*/
		// create black line
		CreateScreenElement {
			type=ContainerElement
			parent=current_menu

			dims=(256, 22)
			not_focusable
		}
		CreateScreenElement {
			type=SpriteElement
			parent=<id>

			texture=black
			scale=(50,1)
			rgba=[0 0 0 80]
			pos=(0,10)
			just=[center center]
		}
	endif

	;printstruct <...>

	FormatText ChecksumName=unhighlighted_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// Don't allow fcfs to change to created parks
	;	if InNetGame
	;		if Not OnServer
	;			if( <level_num> = 10 )
	;				return
	;			endif
	;		endif
	;	endif

	// for cheating
	<can_afford_level> = 0
	<in_locked_group> = 0
	if IntegerEquals a=all_levels_unlocked b=1
		<rgba>=<unhighlighted_color>
		alpha=1.0
		if ( <level_num> = <created_park_number> )
			<pad_choose_script>=level_select_created_park_menu
		else
			if ( in_server_options = 1 )
				<pad_choose_script>=level_select_menu_exit
			else
				<pad_choose_script>=level_select_change_level
			endif
		endif
		<pad_choose_params>=<...>
		<locked> = 0
	else
		if GetGlobalFlag flag=<flag>
			printf <flag>
			<rgba>=<unhighlighted_color>
			alpha=1.0
			if ( <level_num> = <created_park_number> )
				<pad_choose_script>=level_select_created_park_menu
			else
				if ( in_server_options = 1 )
					<pad_choose_script>=level_select_menu_exit
				else
					<pad_choose_script>=level_select_change_level
				endif
			endif
			<pad_choose_params>=<...>
			<locked> = 0
		else
			<rgba>=[47 42 38 128]
			alpha=0.5
			not_focusable=not_focusable
			text="??????????"
			<pad_choose_script>=level_select_invalid_choice
			<locked> = 1
		endif
	endif   // if all levels unlocked

	// secret levels
	/*if ( <level_num> > <created_park_number> && 18 > <level_num> )
		rgba = [20 20 90 60]
		highlight_rgba = [20 20 90 100]
	endif

	// thps4 levels
	if ( <level_num> > 17 )
		rgba = [110 90 10 70]
		highlight_rgba = [110 90 10 100]
	endif*/

	// create anchor element for this item
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		id=<level>

		dims=(256, 20)
		event_handlers=[ { pad_choose		generic_menu_pad_choose_sound }
			{ pad_start		generic_menu_pad_choose_sound }
			{ pad_choose	<pad_choose_script> params=<pad_choose_params> }
			{ pad_start	<pad_choose_script> params=<pad_choose_params> }
			{ focus 	level_select_menu_focus params={ level_num=<level_num> text_alpha=<alpha> highlighted_text_rgba=<highlight_rgba> } }
			{ unfocus	level_select_menu_unfocus params={ level_num=<level_num> text_rgba=<rgba> text_alpha=<alpha> } }
		]
		replace_handlers
		<not_focusable>
	}

	;printf "alpha = %i" i=<alpha>
	// level name element
	CreateScreenElement {
		type=TextElement
		parent=<id>

		font=small
		just=[center top]
		text=<text>
		rgba=<rgba>
		alpha=<alpha>
		;scale=.9
		z_priority=4
	}

	// highlight bar
	highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )
	CreateScreenElement {
		type=SpriteElement
		parent=<level>

		texture=DE_highlight_bar
		pos=<highlight_bar_pos>
		rgba=[0 0 0 0]
		just=[center center]
		scale = <highlight_bar_scale>
		z_priority=2
		rot_angle=<highlight_angle>
	}


	if GotParam cross_it_out
		// line through text
		CreateScreenElement {
			type=SpriteElement
			parent=<anchor_id>

			texture=streak_2
			pos=<highlight_bar_pos>
			rgba=<line_rgba>
			just=[center center]
			scale = <highlight_bar_scale>
			z_priority=2
			rot_angle=<highlight_angle>
		}
	endif

endscript

script build_level_select_map map_rgba=[108 113 128 30] pos=(-30,240) map_scale=(1.0,1.1) ;map_scale=(1.9,1.9)

	if GotParam other_pos
		pos=(320,240)
	endif

	FormatText ChecksumName=color1 "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	color2=(<color1>) // must do this to resolve the global so that I can modify its value locally
	SetArrayElement arrayname=color2 index=3 newvalue=80

	dot_rgba=[128 128 128 128]
	secret_dot_rgba=[20 20 90 128]

	//bg
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=blue_bg

		texture=chapter_bg
		rgba=[17 36 47 128]
		just=[left top]
		pos=(0,100)
		scale = (6.5,3)
		z_priority=-5
	}

	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=black_bg

		texture=black
		rgba=[27 46 57 128]
		just=[left top]
		pos=(450,100)
		scale = (60,80)
		z_priority=-6
	}


	//map
	CreateScreenElement {
		type=containerElement
		parent=current_menu_anchor
		id=level_select_map_anchor

		pos=<pos>
		dims=(640,480)
		alpha=0
	}

	// bg effect
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor
		id=moving_bg

		texture=bg_elements
		rgba=<color2>
		just=[left top]
		pos=(0,70)
		scale = (8,4)
		z_priority=-4
	}

	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor
		id=map_piece_1

		texture=map_graphic_1
		rgba=<map_rgba>
		just=[left top]
		pos=(0,100)
		scale=<map_scale>
		z_priority=-3
	}
	GetStackedScreenElementPos X id=<id>
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor

		texture=map_graphic_2
		rgba=<map_rgba>
		just=[left top]
		pos=<pos>
		scale=<map_scale>
		z_priority=-3
	}
	GetStackedScreenElementPos X id=<id>
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor
		id=map_piece_3

		texture=map_graphic_3
		rgba=<map_rgba>
		just=[left top]
		pos=<pos>
		scale=<map_scale>
		z_priority=-3
	}
	GetStackedScreenElementPos Y id=<id>
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor

		texture=map_graphic_4
		rgba=<map_rgba>
		just=[left top]
		pos=<pos>
		scale=<map_scale>
		z_priority=-3
	}
	GetStackedScreenElementPos X id=<id> offset=(30,-20)
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor

		texture=map_graphic_6
		rgba=<map_rgba>
		just=[left top]
		pos=<pos>
		scale=<map_scale>
		z_priority=-3
	}
	GetStackedScreenElementPos X id=map_piece_3	offset=(30,50)
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor

		texture=map_graphic_5
		rgba=<map_rgba>
		just=[left top]
		pos=<pos>
		scale=<map_scale>
		z_priority=-3
	}
	GetStackedScreenElementPos X id=<id> offset=(0,-50)
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor

		texture=map_graphic_1
		rgba=<map_rgba>
		just=[left top]
		pos=<pos>
		scale=<map_scale>
		z_priority=-3
	}

	// New Jersey
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor
		id=dot_1

		texture=level_dot
		rgba=<dot_rgba>
		just=[center center]
		pos=(554, 190)
		scale=1
		z_priority=-2
	}

	// Manhattan
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_NY) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_2

			texture=level_dot
			rgba=<dot_rgba>
			just=[center center]
			pos=(540,200)
			scale=1
			z_priority=-1
		}
	endif

	// Tampa
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_FL) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_3

			texture=level_dot
			rgba=<dot_rgba>
			just=[center center]
			pos=(532,228)
			scale=1
			z_priority=-2
		}
	endif

	// San Diego
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_SD) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_4

			texture=level_dot
			rgba=<dot_rgba>
			just=[center center]
			pos=(472,223)
			scale=1
			z_priority=-2
		}
	endif

	// Hawaii
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_HI) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_5

			texture=level_dot
			rgba=<dot_rgba>
			just=[center center]
			pos=(405,220)
			scale=1
			z_priority=-2
		}
	endif

	// Vancouver
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_VC) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_6

			texture=level_dot
			rgba=<dot_rgba>
			just=[center center]
			pos=(455,173)
			scale=1
			z_priority=-2
		}
	endif

	// Moscow
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_RU) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_8

			texture=level_dot
			rgba=<dot_rgba>
			just=[center center]
			pos=(78,160) // Don't move me! I'm perfect!
			scale=1
			z_priority=-2
		}

		// Moscow copy - For other side of map!
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_82

			texture=level_dot
			rgba=<dot_rgba>
			just=[center center]
			pos=(813,160) // Me too!
			scale=1
			z_priority=-2
		}
	endif

	// Australia
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_AU) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_9

			texture=level_dot
			rgba=<dot_rgba>
			just=[center center]
			pos=(290,350)
			scale=1
			z_priority=-2
		}
	endif

	// Secret
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_SE) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_10

			texture=level_dot
			rgba=<dot_rgba>
			just=[center center]
			pos=(290,350)
			scale=1
			z_priority=-2
		}
	endif

	/*// School 1
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_SC) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_12

			texture=secret_level_dot
			rgba=<secret_dot_rgba>
			just=[center center]
			pos=(539,187)
			scale=1
			z_priority=-.5
		}
	endif

	// Downhill Jam
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_DJ) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_13

			texture=secret_level_dot
			rgba=<secret_dot_rgba>
			just=[center center]
			pos=(295,340)
			scale=1
			z_priority=-.5
		}
	endif

	// Philadelphia
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_PH) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_14

			texture=secret_level_dot
			rgba=<secret_dot_rgba>
			just=[center center]
			pos=(550,207)
			scale=1
			z_priority=-.5
		}
	endif*/

	// Venice
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_VN) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_16

			texture=secret_level_dot
			rgba=<secret_dot_rgba>
			just=[center center]
			pos=(467,213)
			scale=1
			z_priority=-.5
		}
	endif

	// Hanger
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_HN) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_17

			texture=secret_level_dot
			rgba=<secret_dot_rgba>
			just=[center center]

			pos=(492,183)
			scale=1
			z_priority=-.5
		}

	endif

	// School 2
	if ( (GetGlobalFlag flag=LEVEL_UNLOCKED_SC2) || (IntegerEquals a=all_levels_unlocked b=1) )
		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=dot_15

			texture=secret_level_dot
			rgba=<secret_dot_rgba>
			just=[center center]
			pos=(478,215)
			scale=1
			z_priority=-.5
		}
	endif
endscript

script level_select_scroll_map time=0.45 new_x=-30
	// Was slowing down map if you scroll between two pos with out letting it finish.
	// Added calculations to make sure the map always moves at the same speed.

	wait 4 gameframes

	if not ScreenElementExists id=level_select_map_anchor
		return
	endif

	if GotParam other_pos
		new_x=320
	endif
	GetScreenElementProps id=level_select_map_anchor
	// 350 pixels per 1.0 seconds
	one=1
	current_x=( <pos>.(1,0) )
	dif_x=(<new_x> - <current_x>)

	// absolute value of dif_x
	if ( 0 > <dif_x> )
		dif_x = ( -1 * <dif_x> )
	endif

	time = ( <time> * (<dif_x>/350) )

	if GotParam other_pos
		DoScreenElementMorph id=level_select_map_anchor pos=(320,240) time=<time>
	else
		DoScreenElementMorph id=level_select_map_anchor pos=(-30,240) time=<time>
	endif
endscript

script network_level_select_pad_back
	<net_pad_back> = 1
	level_select_menu_exit <...>
endscript

script level_select_menu_exit

	KillSpawnedScript name=level_select_scroll_map
	KillSpawnedScript name=chap_moving_bg
	KillSpawnedScript name=Level_Select_draw_line
	KillSpawnedScript name=Level_Select_star_effect
	; KillSkaterCamAnim name=SS_LevelSelect
	; KillSkaterCamAnim name=MapGuy_ViewCam
	; KillSkaterCamAnim current
	kill_level_select_cams
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		load_level_select_textures_to_main_memory unload
	endif

	if GotParam no_new_menu
		unhide_current_goal
		return
	endif

	if LevelIs load_skateshop
		GoalManager_HideGoalPoints
		if ( in_server_options = 1 )
			if ( <net_pad_back> = 0 )
				prefs=network
				field="level"
				string=<text>
				checksum=<level>
				select_host_option <...>
			endif
			if ObjectExists id=host_options_menu
				DestroyScreenElement id=host_options_menu
			endif
			KillSkaterCamAnim all
			PlaySkaterCamAnim name=SS_MenuCam play_hold
			create_network_host_options_menu
		else
			launch_ss_menu <...> no_animate
		endif
	else
		if GotParam end_run
			create_end_run_menu
		else
			GoalManager_ShowPoints
			if GoalManager_HasActiveGoals
				GoalManager_HideGoalPoints
				if ScreenElementExists id=current_goal
					DoScreenElementMorph {
						id=current_goal
						restore_alpha
					}
				endif
				if ScreenElementExists id=current_goal_key_combo_text
					DoScreenElementMorph {
						id=current_goal_key_combo_text
						restore_alpha
					}
				endif
			else
				GoalManager_ShowGoalPoints
			endif
			create_pause_menu
		endif
	endif
endscript

hidden_level_dot=0

script level_select_menu_focus
	GetTags

	GetScreenElementProps id=<id>
	menu_item_pos=<pos>

	KillSpawnedScript Level_Select_star_effect

	if ( (<level_num> = 8) || (<level_num> = 9) || (<level_num> = 10) || (<level_num> = 13) )
		KillSpawnedScript name=level_select_scroll_map
		spawnscript level_select_scroll_map params={ other_pos }
	else
		KillSpawnedScript name=level_select_scroll_map
		spawnscript level_select_scroll_map
	endif

	if ( <level_num> > 10 && 18 > <level_num> )
		star_rgba = [20 20 100 128]
	else
		FormatText ChecksumName=star_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	endif

	FormatText checksumname=current_level_dot_id "dot_%i" i=<level_num>
	// slam city jam
	if ( <level_num> = 7 )
		current_level_dot_id=dot_6
	endif

	// Moscow needs to update VC dot
	if ( <level_num> = 8 )
		DoScreenElementMorph id=dot_6 alpha=1 time=0.1
	endif

	// cleanup last star
	if ScreenElementExists id=selected_level_star
		KillSpawnedScript name=Level_Select_star_effect
		DestroyScreenElement id=selected_level_star
		if ScreenElementExists id=selected_level_star2
			DestroyScreenElement id=selected_level_star2
		endif
	endif
	if ScreenElementExists id=selected_level_line
		KillSpawnedScript name=Level_Select_draw_line
		DestroyScreenElement id=selected_level_line
	endif

	if ScreenElementExists id=<current_level_dot_id>
		GetScreenElementProps id=<current_level_dot_id>

		SetScreenElementLock off id=level_select_map_anchor

		CreateScreenElement {
			type=SpriteElement
			parent=level_select_map_anchor
			id=selected_level_star

			texture=level_selected_dot
			rgba=<star_rgba>
			just=[center center]
			pos=<pos>
			scale=0
			z_priority=0
		}

		DoScreenElementMorph id=<current_level_dot_id> alpha=0
		change hidden_level_dot=<level_num>
		DoScreenElementMorph id=selected_level_star scale=0.8 rot_angle=0 time=0.25
		SpawnScript Level_Select_draw_line params={ star_rgba=<star_rgba> menu_item_pos=<menu_item_pos> star_pos=<pos> }
		RunScriptOnScreenElement id=selected_level_star Level_Select_star_effect params={ star_rgba=<star_rgba> menu_item_pos=<menu_item_pos> star_pos=<pos> }
	endif

	main_theme_focus <...>
endscript

script Level_Select_draw_line
	if ScreenElementExists id=selected_level_line
		KillSpawnedScript name=Level_Select_draw_line
		DestroyScreenElement id=selected_level_line
	endif

	SetScreenElementLock off id=level_select_map_anchor
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor
		id=selected_level_line

		texture=streak_2
		rgba=<star_rgba>
		just=[left center]
		pos=(0,0)
		scale=1
		z_priority=3
		rot_angle=0
		alpha=0
	}

	wait 1 gameframe

	if not ScreenElementExists id=level_select_map_anchor
		return
	endif

	// line
	begin
		// get absolute pos of star
		GetScreenElementProps id=level_select_map_anchor
		map_anchor_pos=<pos>

		star_absolute_pos = (<star_pos> + <map_anchor_pos>)

		// get absolute pos of menu item
		GetScreenElementProps id=level_select_anchor_middle
		middle_anchor_pos=<pos>

		GetScreenElementProps id=level_select_scrolling_menu
		scrolling_menu_pos=<pos>

		GetScreenElementProps id=level_select_vmenu
		vmenu_pos=<pos>

		item_absolute_pos = ( <middle_anchor_pos> + <scrolling_menu_pos> + <vmenu_pos> + <menu_item_pos> )

		// relative pos of item to star
		relative_pos = ( <item_absolute_pos> - <star_absolute_pos> )

		rel_x = ( <relative_pos>.(1,0) )
		rel_y = ( <relative_pos>.(0,1) )

		if not ( <rel_x> = 0 )
			// angle of line
			atan ( <rel_y> / <rel_x> )
			line_angle = ( ( <atan> * 1 ) )

			// length of line
			sin ( <atan> )
			line_length = ( <rel_y> / <sin> )
			line_scale = ( ( <line_length> / 64 ) * (1,0) + (0,1) )

			// set the line to new props
			DoScreenElementMorph {
				id=selected_level_line

				pos=<star_pos>
				scale=<line_scale>
				rot_angle=<line_angle>
				alpha=0.6
			}
		endif

		wait 1 gameframe
	repeat
endscript

script level_select_star_effect
	// star
	wait 0.25 seconds
	SetScreenElementLock off id=level_select_map_anchor
	CreateScreenElement {
		type=SpriteElement
		parent=level_select_map_anchor
		id=selected_level_star2

		texture=level_selected_dot
		rgba=<star_rgba>
		just=[center center]
		pos=<star_pos>
		scale=0.8
		z_priority=0
		alpha=0.4
	}
	begin
		DoScreenElementMorph id=selected_level_star2 scale=3.0 alpha=0 time=0.5
		wait 0.5 seconds
		DoScreenElementMorph id=selected_level_star2 scale=0.8 alpha=0.4
		wait 0.5 seconds
	repeat
endscript

script level_select_menu_unfocus
	GetTags

	// restore hidden level dot
	FormatText checksumname=hidden_dot "dot_%i" i=hidden_level_dot
	if ScreenElementExists id=<hidden_dot>
		DoScreenElementMorph id=<hidden_dot> alpha=1 time=0.1
		change hidden_level_dot=0
	endif

	/*// cleanup last star
	if ScreenElementExists id=selected_level_star
        KillSpawnedScript name=Level_Select_star_effect
        DestroyScreenElement id=selected_level_star
		if ScreenElementExists id=selected_level_star2
			DestroyScreenElement id=selected_level_star2
		endif
	endif
	if ScreenElementExists id=selected_level_line
		KillSpawnedScript name=Level_Select_draw_line
		DestroyScreenElement id=selected_level_line
	endif*/

	main_theme_unfocus <...>
endscript

created_park_warning=0

script level_select_created_park_menu

	// create menu
	make_new_skateshop_menu {
		parent=level_select_anchor_middle
		pos=(620,125)
		internal_just=[left center]
		menu_id=created_park_menu
		vmenu_id=created_park_vmenu
		menu_title=""
	}
	// hide off screen
	DoScreenElementMorph id=created_park_menu pos=(520,240) time=0.1

	theme_background parent=created_park_menu id=created_park_bg width=1.5 pos=(710,106) num_parts=3 z_priority=1 dark_menu=dark_menu static=static

	kill_start_key_binding

	if GotParam show_warning
		change created_park_warning=1
	endif

	GetCustomParkName
	if ( <name> = "" )
		<name> = "unnamed park"
	endif

	// park name
	CreateScreenElement {
		type=TextElement
		parent=created_park_menu

		pos=(710, 110)
		font=dialog
		text=<name>
		just=[center top]
		scale=1
		rgba=[128 128 128 80]
		not_focusable
		z_priority=2
	}
	truncate_string id=<id> max_width=200

	// black box
	CreateScreenElement {
		type=SpriteElement
		parent=created_park_menu

		texture=black
		pos=(710, 109)
		rgba=[0 0 0 60]
		scale=(52,7)
		just=[center top]
		z_priority=2
	}

	// Define pad_back event - go back to the main menu
	SetScreenElementProps {
		id=created_park_vmenu
		event_handlers=[
			{ pad_back       generic_menu_pad_back_sound }
			{ pad_back       level_select_created_park_menu_exit params = {from_server_options=<from_server_options>}}
		]
		replace_handlers
	}

	;GetCurrentSkaterProfileIndex

	if GotParam from_server_options
		created_park_menu_add_item {  text='Play Park'
			id=created_park_play_park
			pad_choose_script=created_park_launch
			pad_choose_params={ from_server_options }
		}
	else
		created_park_menu_add_item {  text='Play Park'
			id=created_park_play_park
			pad_choose_script=created_park_launch
			pad_choose_params={  }
		}
	endif

	if GotParam from_server_options
		created_park_menu_add_item {  text='Load Park'
			id=created_park_load_park
			pad_choose_script=confirm_load_park
			pad_choose_params={ load_park from_server_options }
		}
	else
		created_park_menu_add_item {  text='Load Park'
			id=created_park_load_park
			pad_choose_script=confirm_load_park
			pad_choose_params={ load_park }
		}
	endif

	if GotParam from_server_options
		created_park_menu_add_item {  text='Pre-Made Parks'
			id=created_park_premade
			;not_focusable
			pad_choose_script=level_select_created_park_menu_exit
			pad_choose_params={ park_list from_server_options }
		}
	else
		created_park_menu_add_item {  text='Pre-Made Parks'
			id=created_park_premade
			;not_focusable
			pad_choose_script=level_select_created_park_menu_exit
			pad_choose_params={ park_list }
		}
	endif

	created_park_menu_add_item {  text='back'
		id=created_park_back
		pad_choose_script=level_select_created_park_menu_exit
		pad_choose_params={  }
	}


	FireEvent type=unfocus target=level_select_vmenu
	FireEvent type=focus target=created_park_vmenu
	SetButtonEventMappings block_menu_input
	DoScreenElementMorph id=created_park_menu pos=(320,240) time=0.15
	wait 0.1 seconds
	DoScreenElementMorph id=level_select_anchor_middle pos=(85,240) time=0.15
	SetButtonEventMappings unblock_menu_input
	SetScreenElementProps id=title_text text="CREATED PARKS"
endscript

script created_park_menu_add_item
	highlight_bar_scale=(1.6,0.7)
	centered=centered
	no_bg=no_bg
	theme_menu_add_item <...>
endscript

script created_park_launch

	if ( in_server_options = 1 )
		GetParkEditorMaxPlayers
		GetNetworkNumPlayers
		if inNetGame
			if (<num_players> > <MaxPlayers>)
				level_select_created_park_menu_exit from_server_options

				KillSpawnedScript name=level_select_scroll_map
				KillSpawnedScript name=chap_moving_bg
				KillSpawnedScript name=Level_Select_draw_line
				KillSpawnedScript name=Level_Select_star_effect

				if ObjectExists id=current_menu_anchor
					DestroyScreenElement id=current_menu_anchor
				endif

				load_level_select_textures_to_main_memory unload

				goto mcmess_ErrorbadParkMaxPlayers params={num_players=<num_players> MaxPlayers=<MaxPlayers> back_script=return_to_created_park_menu back_params={from_server_options}}
			endif
		endif
	endif

	GetParkEditorMaxPlayers
	GetNetworkNumPlayers
	if inNetGame
		if (<num_players> > <MaxPlayers>)
			level_select_created_park_menu_exit from_server_options

			KillSpawnedScript name=level_select_scroll_map
			KillSpawnedScript name=chap_moving_bg
			KillSpawnedScript name=Level_Select_draw_line
			KillSpawnedScript name=Level_Select_star_effect

			if ObjectExists id=current_menu_anchor
				DestroyScreenElement id=current_menu_anchor
			endif

			load_level_select_textures_to_main_memory unload

			goto mcmess_ErrorbadParkMaxPlayers params={num_players=<num_players> MaxPlayers=<MaxPlayers> back_script=return_to_created_park_menu back_params={from_server_options}}
		endif
	endif

	if ( in_server_options = 1 )
		level_select_created_park_menu_exit from_server_options
		level=load_sk5ed_gameplay
		string="Created Park"
		level_select_menu_exit from_server_options net_pad_back=0 <...>
		;chosen_host_game
	else
		;level_select_created_park_menu_exit
		if inNetGame ;(created_park_warning = 1)
			change created_park_warning=0
			level_select_change_level level=load_sk5ed_gameplay <...> show_warning
		else
			level_select_change_level level=load_sk5ed_gameplay <...>
		endif
	endif
endscript

script confirm_load_park
	level_select_created_park_menu_exit

	KillSpawnedScript name=level_select_scroll_map
	KillSpawnedScript name=chap_moving_bg
	KillSpawnedScript name=Level_Select_draw_line
	KillSpawnedScript name=Level_Select_star_effect

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	load_level_select_textures_to_main_memory unload



	if GotParam from_server_options
		;printf"===========================================================got from_server_options"
		change still_in_net_area = 1
		if IsParkUnsaved
			menu_confirm_quit { yes_script=launch_level_select_load_park_sequence
				title="Replace unsaved park?"
				text_dims=(330,0)
				back_script=return_to_created_park_menu
				no_script=return_to_created_park_menu
				params={ from_server_options }
			}
		else
			launch_level_select_load_park_sequence
		endif
	else
		;printf"===========================================================NO from_server_options"
		if IsParkUnsaved
			if levelIs load_skateshop
				no_animate=no_animate
			endif
			menu_confirm_quit { yes_script=launch_level_select_load_park_sequence
				title="Replace unsaved park?"
				text_dims=(330,0)
				no_animate=<no_animate>
				back_script=return_to_created_park_menu
				no_script=return_to_created_park_menu
			}
		else
			launch_level_select_load_park_sequence
		endif
	endif

	if levelIs load_skateshop
		skater:hide
		KillSkaterCamAnim all
		PlaySkaterCamAnim skater=0 name=mainmenu_camera03 play_hold
	endif
endscript

still_in_net_area = 0

script return_to_created_park_menu
	dialog_box_exit
	kill_start_key_binding
	launch_level_select_menu <...>
	level_select_created_park_menu <...>
endscript

script level_select_created_park_menu_exit
	if GotParam park_list
		level_select_created_park_list	<...>
	else
		SetButtonEventMappings block_menu_input
		DoScreenElementMorph id=level_select_anchor_middle pos=(320,240) time=0.2
		wait 0.2 seconds
		DoScreenElementMorph id=created_park_menu pos=(420,240) time=0.1
		wait 0.1 seconds
		SetScreenElementProps id=title_text text="LEVEL SELECT"
		SetButtonEventMappings unblock_menu_input
		if ObjectExists id=created_park_menu
			DestroyScreenElement id=created_park_menu
		endif
		if ObjectExists id=premade_park_menu //??? does this ever happen?
			DestroyScreenElement id=premade_park_menu
		endif
	endif

	if GotParam launch_level
		printf "launching created level"
		;level_select_change_level
	endif

	if GotParam load_park
		printf "launching created level"
	endif

	if not GotParam park_list
		AssignAlias id=level_select_anchor alias=current_menu_anchor
		FireEvent type=focus target=level_select_vmenu
	endif
endscript

script level_select_created_park_list
	printf "level_select_created_park_list"

	dialog_box_exit

	if ScreenElementExists id=level_select_anchor_middle
		// in regular level select menu
		dark_menu=dark_menu
		delta_pos=(0,0)
		parent=level_select_anchor_middle
	else
		// in park editor pause menus
		if ObjectExists id=current_menu_anchor
			DestroyScreenElement id=current_menu_anchor
		endif
		delta_pos=(-400,0)
		parent=root_window
	endif

	if GotParam in_park_editor
		FormatText ChecksumName=title_icon "%i_load" i=(THEME_PREFIXES[current_theme_prefix])
		make_new_themed_scrolling_menu title="PRE-MADE PARKS" title_icon=<title_icon>
	else
		// create menu
		make_new_skateshop_menu {
			parent=<parent>
			pos=( (620,100) + <delta_pos> )
			dims=(200, 191)
			internal_just=[left center]
			menu_id=premade_park_menu
			scrolling_menu_id=premade_park_scrolling_menu
			vmenu_id=premade_park_vmenu
			menu_title=""
			type=VScrollingMenu
			scrolling_menu_title_id=""
			dont_allow_wrap=dont_allow_wrap
			padding_scale=.9
		}
		if ScreenElementExists id=level_select_anchor_middle
			DoScreenElementMorph id=premade_park_menu pos=(320,640)
		endif
	endif



	kill_start_key_binding

	if not GotParam in_park_editor
		theme_background parent=premade_park_menu id=premade_park_bg width=1.5 pos=((710,106) + <delta_pos>) num_parts=7.5 z_priority=1 dark_menu=<dark_menu> static=static
	endif

	//blink arrows
	/*SetScreenElementProps {	id=premade_park_vmenu
							event_handlers=[
							 { pad_down	menu_vert_blink_arrow params={ id=park_menu_down_arrow } }
							 { pad_up	menu_vert_blink_arrow params={ id=park_menu_up_arrow } }
		                  	]
						  }*/

	if GotParam in_park_editor
		create_helper_text generic_helper_text
	endif

	/*CreateScreenElement {
		type=SpriteElement
		parent=premade_park_menu
		id=park_menu_up_arrow

		texture=up_arrow
		pos=( (710, 111) + <delta_pos> )
        rgba=[128 128 128 128]
        just=[center top]
		z_priority=4
	}

	CreateScreenElement {
		type=SpriteElement
		parent=premade_park_menu
		id=park_menu_down_arrow

		texture=down_arrow
		pos=( (710, 323) + <delta_pos> )
        rgba=[128 128 128 128]
        just=[center top]
	}  */

	if GotParam from_server_options
		pad_back_params={ from_server_options }
	else
		pad_back_params={ }
	endif

	// Define pad_back event - go back to the main menu
	if not GotParam in_park_editor
		SetScreenElementProps {
			id=premade_park_vmenu
			event_handlers=[ { pad_back    generic_menu_pad_back params={ callback=level_select_created_park_list_exit <pad_back_params> } }]
			replace_handlers
		}
	else
		SetScreenElementProps {
			id=sub_menu
			event_handlers=[ { pad_back    generic_menu_pad_back params={ callback=level_select_created_park_list_exit <...> } }]
			replace_handlers
		}
	endif

	GetArraySize premade_parks_info
	index=0
	begin
		created_park_menu_add_item {  text=( premade_parks_info[<index>].name )
			pad_choose_script=maybe_load_premade_park ;level_select_created_park_list_exit
			pad_choose_params={ <pad_back_params> slot=( premade_parks_info[<index>].slot ) max=( premade_parks_info[<index>].max ) }
		}
		<index> = ( <index> + 1 )
	repeat <array_size>

	;SetScreenElementProps id=premade_park_scrolling_menu reset_window_top

	if ScreenElementExists id=level_select_vmenu
		FireEvent type=unfocus target=level_select_vmenu
	endif
	if ScreenElementExists id=level_select_anchor_middle
		// in level select
		SetButtonEventMappings block_menu_input
		;DoScreenElementMorph id=level_select_anchor_middle pos=(85,240)
		DoScreenElementMorph id=premade_park_menu pos=(320,240) time=0.3
		wait 0.25 seconds
		DoScreenElementMorph id=created_park_menu pos=(320,0) time=0.15
		wait 0.05 seconds
		SetScreenElementProps id=title_text text="PRE-MADE PARKS"
		;DestroyScreenElement id=created_park_menu
		FireEvent type=unfocus target=created_park_vmenu
		FireEvent type=focus target=premade_park_vmenu
		SetButtonEventMappings unblock_menu_input
	endif

	if GotParam in_park_editor
		theme_menu_add_item text="Done" id=menu_done scale=1.0 pad_choose_script=create_pause_menu no_bg highlight_bar_scale=(1.7,0.8)
		finish_themed_scrolling_menu bg_width=1.5 time=0.2
	endif
endscript

script maybe_load_premade_park
	;printf "maybe_load_premade_park"
	GetNetworkNumPlayers
	if inNetGame
		if (<num_players> > <max>)
			level_select_created_park_menu_exit from_server_options

			KillSpawnedScript name=level_select_scroll_map
			KillSpawnedScript name=chap_moving_bg
			KillSpawnedScript name=Level_Select_draw_line
			KillSpawnedScript name=Level_Select_star_effect

			if ObjectExists id=current_menu_anchor
				DestroyScreenElement id=current_menu_anchor
			endif

			load_level_select_textures_to_main_memory unload

			goto mcmess_ErrorbadParkMaxPlayers params={num_players=<num_players> MaxPlayers=<max> back_script=return_to_created_park_menu back_params={from_server_options}}
		endif
	endif
	level_select_created_park_list_exit <...>
endscript

script level_select_created_park_list_exit
	// where are we?
	if ObjectExists id=level_select_anchor
		// in level select
		if not GotParam slot
			// animate menus on and off
			SetButtonEventMappings block_menu_input
			DoScreenElementMorph id=created_park_menu pos=(320,240) time=0.15
			wait 0.05 seconds
			DoScreenElementMorph id=premade_park_menu pos=(320,640) time=0.3
			wait 0.25 seconds
			SetScreenElementProps id=title_text text="CREATED PARKS"
			FireEvent type=focus target=created_park_vmenu
			SetButtonEventMappings unblock_menu_input

			AssignAlias id=level_select_anchor alias=current_menu_anchor
		endif
	else
		// in park editor
		in_park_ed=1
	endif

	if ObjectExists id=premade_park_menu
		DestroyScreenElement id=premade_park_menu
	endif

	if GotParam slot
		printf "loading from disk"
		if GotParam in_park_ed
			printf "in the park editor"
			parked_load_from_disk slot=<slot>
		else
			if GotParam from_server_options
				;spawnscript premade_park_wait_message
				;WaitForEvent type=showed_wait_message
				LoadParkFromDisk slot=<slot> block_rebuild
				;wait 3 seconds
				;dialog_box_exit
				;DoScreenElementMorph id=current_menu_anchor scale=1
				created_park_launch from_server_options
			else
				//get park off disk
				LoadParkFromDisk slot=<slot> block_rebuild
				//launch the level
				created_park_launch
			endif
		endif
	else
		if GotParam in_park_editor
			create_pause_menu;parked_setup_main_menu
		endif
	endif
endscript

script premade_park_wait_message
	DoScreenElementMorph id=current_menu_anchor scale=0

	create_error_box title="Loading..." text="Please wait while the pre-made park is loaded."
	FireEvent type=showed_wait_message target=system
endscript

script level_select_hide_info
	DoMorph scale=0
endscript

script level_select_animate_info
	DoMorph scale=1
	;	DoMorph pos={ (0, 150) relative } scale=1
	;	DoMorph time=.2 pos={ (0, -150) relative }
endscript

script level_select_play_cam
	kill_level_select_cams
	; UnPauseGame
	If 	LevelIs load_skateshop
		KillSkaterCamAnim all
		PlaySkaterCamAnim skater=0 name=SS_LevelSelect play_hold
	else
		PlaySkaterCamAnim skater=0 name=MapGuy_ViewCam play_hold
		SetSkaterCamAnimShouldPause name=MapGuy_ViewCam 0
	endif
	; PauseSkaters
	; waitonegameframe
endscript

// kills any cams that may have been played by the level select menu
script kill_level_select_cams
	KillSkaterCamAnim name=MapGuy_ViewCam
endscript


script really_change_level
	if OnServer
		change_level <...>
	else
		if IsHost
			FCFSRequestChangeLevel <...>
		endif
	endif
endscript

return_to_level = [ null ]

// @script | level_select_change_level | change to a new level.  Usually called from
// a menu item as a pad_choose_script
// @parm name | level | the level load script
script level_select_change_level
	//PlaySound GoToLoadLevel   //commented out and took out loadsound 03/11/03 by David Rowe

	GoalManager_ShowPoints
	if not GoalManager_HasActiveGoals
		GoalManager_ShowGoalPoints
	endif

	// changing levels from level select
	if ScreenElementExists id=level_select_anchor
		DestroyScreenElement id=level_select_anchor
		load_level_select_textures_to_main_memory unload
	endif

	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	// changing levels from created park
	if LevelIs load_sk5ed
		load_parked_textures_to_main_memory unload
	endif

	// Remove color buffer clears if leaving the front end.
	if LevelIs load_skateshop
		SetColorBufferClear clear=0
	endif

	// if leaving skateshop remove textures
	if LevelIs load_skateshop
		load_mainmenu_textures_to_main_memory unload
	endif

	if LevelIs Load_Sk5Ed_gameplay
		// The rail sectors are cloned sectors, which get cleaned up by some lower level cleanup code
		// even if this were not called, but that would leave the rail editor with dangling pointers,
		// so call this so that it can nullify them.
		// Passing the DoNotUpdateSuperSectors flag because calling UpdateSuperSectors would
		// make the whole park disappear beneath the skater during the pause before changing levels
		// in net games.
		RailEditor:DestroyEditedRailSectors DoNotUpdateSuperSectors
	endif

	kill_level_select_cams

	// set return to level. this is so when in career mode the player will return to
	// the last level they were in instead of being dumped back to the main menu
	if GameModeEquals is_career
		if not LevelIs load_skateshop
			if ( (<level> = load_boardshop) || (<level> = load_cas) )
				// GetCurrentLevel returns a level param, but we already have one of those, so I'm using a temp
				temp=<level>
				GetCurrentLevel
				array=return_to_level
				SetArrayElement arrayname=array index=0 newvalue=<level>
				level=<temp>
			endif
		endif
	endif

	// only check the current level on the CD
	if CD
		if IsCustomPark
			really_change_level <...>    // (Mick) if in park editor, always change level
		else
			if not LevelIs <level>
				really_change_level <...>
			else
				if GotParam chose_same_level_script
					<chose_same_level_script>
				else
					if GotParam end_run
						level_select_menu_exit end_run
						return
					endif
				endif
			endif
		endif
	else
		really_change_level <...>
	endif
	;restore_start_key_binding
	level_select_menu_exit no_new_menu
	exit_pause_menu
endscript

// @script | level_select_invalid_choice | This script is called when the player
// hits X on a level they can't afford.  It's here if you wanna play some sound
// or animation
script level_select_invalid_choice
	// play some sound or animation or something
	// printf "you can't afford this level"
endscript


script hide_main_menu_anchor
	DoMorph time=0 scale=0
endscript

script show_main_menu_anchor
	DoMorph time=0 scale=1
endscript

// global array for the level select menu

e3_level_select_menu_level_info = [
	{ text="New Jersey" 	level_num=1 points_to_unlock=0 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_NJ level=load_NJ taxi_id=Cab_sign_1_College }
	{ text="Manhattan" 			level_num=2  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_NY level=load_NY }
	{ text="Tampa" 				level_num=3  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_FL level=load_FL }
]

// Unlock the levels when the player has this many goal points
// If you add a level or change any level_nums let Zac know so that the level select menu can be updated!!!
level_select_menu_level_info = [
	{ text="New Jersey" 		level_num=1  points_to_unlock=0 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_NJ level=load_NJ }
	{ text="Manhattan" 			level_num=2  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_NY level=load_NY }
	{ text="Tampa" 				level_num=3  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_FL level=load_FL }
	{ text="San Diego" 			level_num=4  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_SD level=load_SD }
	{ text="Hawaii" 			level_num=5  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_HI level=load_HI }
	{ text="Vancouver" 			level_num=6  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_VC level=load_VC }
	{ text="Slam City Jam" 		level_num=7  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_SP level=load_SJ }
	{ text="Moscow" 			level_num=8  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_RU level=load_RU }
	;{ text="Australia" 		level_num=9  points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_AU level=load_AU }
	{ text="Hotter Than Hell" 	level_num=10 points_to_unlock=8 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_SE level=load_SE }
	;{ text="Your Mama's House" 	level_num=19 points_to_unlock=-1 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_NJ level=load_cas }
	;{ text="Peralta's Skateshop" level_num=20 points_to_unlock=-1 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_NJ level=load_boardshop }
	{ text="Created Park" 		level_num=11 points_to_unlock=0  num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_SCH level=load_sk5ed_gameplay }
	;{ text="Old Skool" 			level_num=12 points_to_unlock=-1 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_SC level=load_SC DEVKIT_ONLY}
	;{ text="Old Downhill Jam" 	level_num=13 points_to_unlock=-1 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_DJ level=load_DJ DEVKIT_ONLY}
	;{ text="Old Philly" 		level_num=14 points_to_unlock=-1 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_PH level=load_PH DEVKIT_ONLY}
	{ text="School II" 			level_num=15 points_to_unlock=0 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_SC2 level=load_SC2 }
	{ text="Venice" 			level_num=16 points_to_unlock=0 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_VN level=load_VN }
	{ text="Hangar" 			level_num=17 points_to_unlock=0 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_HN level=load_HN }
	{ text="THPS4 Alcatraz" 	level_num=22 points_to_unlock=0 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_NJ level=load_Alc }
	{ text="West Side" 			level_num=18 points_to_unlock=-1 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_SCH level=load_WWW DEVKIT_ONLY}

	;{ text="Old ???" 		    level_num=15 points_to_unlock=0 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_SC level=load_SC }
	;{ text="Old ???" 		    level_num=16 points_to_unlock=0 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_SC level=load_SC }
	;{ text="(College)" 			level_num=19 points_to_unlock=0 num_am_goals=16 num_goals=21 flag=LEVEL_UNLOCKED_SCH level=load_sch DEVKIT_ONLY}
	;{ text="(San Francisco)" 	level_num=18 points_to_unlock=8 num_am_goals=16 num_goals=21 flag=LEVEL_UNLOCKED_SF2 level=load_sf2 }
	;{ text="(Alcatraz)" 		level_num=19 points_to_unlock=8 num_am_goals=16 num_goals=21 flag=LEVEL_UNLOCKED_ALC level=load_alc }
	;{ text="(Kona)" 			level_num=20 points_to_unlock=8 num_am_goals=16 num_goals=21 flag=LEVEL_UNLOCKED_KON level=load_kon }
	;{ text="(Shipyard)" 		level_num=21 points_to_unlock=8 num_am_goals=16 num_goals=21 flag=LEVEL_UNLOCKED_JNK level=load_jnk }
	;{ text="(London)" 			level_num=20 points_to_unlock=8 num_am_goals=16 num_goals=21 flag=LEVEL_UNLOCKED_LON level=load_lon DEVKIT_ONLY}
	;{ text="(Zoo)" 				level_num=23 points_to_unlock=8 num_am_goals=16 num_goals=21 flag=LEVEL_UNLOCKED_ZOO level=load_zoo }
	;{ text="(Carnival)" 		level_num=24 points_to_unlock=-1 num_am_goals=14 num_goals=14 flag=LEVEL_UNLOCKED_CNV level=load_cnv }
	;{ text="(Chicago)" 			level_num=25 points_to_unlock=-1 num_am_goals=14 num_goals=14 flag=LEVEL_UNLOCKED_HOF level=load_motox }

	{ text="TestLevel" 		    level_num=21 points_to_unlock=-1 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_NJ level=load_TestLevel DEVKIT_ONLY}
	{ text="Default" 		    level_num=30 points_to_unlock=-1 num_am_goals=0 num_goals=0 flag=LEVEL_UNLOCKED_NJ level=load_Default DEVKIT_ONLY}
]


premade_parks_info = [
	{ name="Skatechupitchu"	 			slot=1 max=5 }
	{ name="Slacka-land"    	 			slot=2 max=6 }
	{ name="SP's Ville"    	 			slot=3 max=4 }
	{ name="AndyTHPS Park"    	 			slot=4 max=7 }
	{ name="Fontucky Speedway"    	 	   	slot=5 max=7 }
	{ name="Montana Undrgrnd"    	 		slot=6 max=8 }
	{ name="DDT Underground"    	 		slot=7 max=6 }
	{ name="Ji Land3"		    	 		slot=8 max=5 }
	{ name="Skate Mountain"	   	 		slot=9 max=7 }
]

// ********************************************************************
// Options menu
// ********************************************************************

// @script | create_options_menu | Creates the options menu
script create_options_menu
	hide_current_goal
	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_option_menu title="OPTIONS" title_icon=<title_icon>

	pause_show_deck parent=current_menu_anchor no_slide

	if levelis load_skateshop
		pad_back_script = skateshop_practice_pause_menu
	else
		pad_back_script = create_pause_menu
	endif

	GoalManager_HideGoalPoints
	GoalManager_HidePoints
	unhide_root_window

	SetScreenElementProps { id=options_menu
		event_handlers=[
			{ pad_back     generic_menu_pad_back params={ callback=<pad_back_script> }}
		]
	}


	if not (DEMO_BUILD)
		if GameModeEquals is_career
			make_theme_menu_item text="Game Progress" id=menu_game_progress pad_choose_script=game_progress_menu_create
		endif

		if GameModeEquals is_singlesession
			if not inSplitScreenGame
				if not inNetGame
					make_theme_menu_item text="High Scores" id=menu_high_scores pad_choose_script=high_scores_menu_create pad_choose_params={from_pause=from_pause}
				endif
			endif
		endif

		if Not InMultiPlayerGame
			// make_text_sub_menu_item text="Change Gamemode" id=menu_change_gamemode pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=launch_gamemode_menu }
			if isngc
				switch camera_angle
					case 0
						camera_text="Camera Angle: 1"
					case 1
						camera_text="Camera Angle: 2"
					case 2
						camera_text="Camera Angle: 3"
					case 3
						camera_text="Camera Angle: 4"
				endswitch

				make_theme_menu_item text=<camera_text> id=menu_camera pad_choose_script=toggle_camera_angle pad_choose_params={ }
			endif
			; make_theme_menu_item text="Edit Skater" id=menu_edit_skater pad_choose_script=launch_edit_skater_menu


			;make_theme_menu_item text="View Stats" id=menu_edit_stats pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=create_stats_menu }
			/*
			if GameModeEquals is_career
				if GoalManager_HasActiveGoals count_all
					/*make_theme_menu_item {
						text="Pro Trick Objects"
						pad_choose_script=generic_menu_pad_choose
						pad_choose_params={ callback=create_pro_trick_objects_menu }
						not_focusable
						rgba=[50 50 50 90]
					}*/
		else
			make_theme_menu_item {
				text="Pro Trick Objects"
				pad_choose_script=generic_menu_pad_choose
				pad_choose_params={ callback=create_pro_trick_objects_menu }
			}
		endif
	endif
	*/

	//if not ((isTrue Bootstrap_build) || (isTrue DEMO_BUILD))
	;make_theme_menu_item text="Change Skater" id=menu_change_skater pad_choose_script=launch_select_Skater_menu
	make_theme_menu_item text="Cheats" id=menu_real_cheats pad_choose_script=create_real_cheats_menu
	If not CD
		make_theme_menu_item text="Cheats: Debug" id=menu_cheats pad_choose_script=launch_cheats_menu
	endif
	//
else
	/*if not isObserving
				if not InSplitScreenGame
					if GoalManager_HasActiveGoals
						make_theme_menu_item {
							not_focusable
							rgba=[50 50 50 90]
							text="Edit Tricks"
							id=menu_edit_tricks
							pad_choose_script=create_edit_tricks_menu
						}
					else
						make_theme_menu_item {
							text="Edit Tricks"
							id=menu_edit_tricks
							pad_choose_script=create_edit_tricks_menu
						}
					endif
				endif
			endif*/

	if InNetGame
		if GameModeEquals is_lobby
			if GoalManager_HasActiveGoals count_all
				/*make_theme_menu_item {
							text="Pro Trick Objects"
							pad_choose_script=generic_menu_pad_choose
							pad_choose_params={ callback=create_pro_trick_objects_menu }
							not_focusable
							rgba=[50 50 50 90]
						}*/
			else
				/*make_theme_menu_item {
							text="Pro Trick Objects"
							pad_choose_script=generic_menu_pad_choose
							pad_choose_params={ callback=create_pro_trick_objects_menu }
						}*/
			endif
		endif
		if not ((isTrue Bootstrap_build) || (isTrue DEMO_BUILD))
			if not CD
				;make_theme_menu_item text="Change Skater" id=menu_change_skater pad_choose_script=launch_select_Skater_menu
				make_theme_menu_item text="Cheats: DO NOT TEST" id=menu_cheats pad_choose_script=launch_cheats_menu
			endif
			;make_theme_menu_item text="Cheats" id=menu_real_cheats pad_choose_script=create_real_cheats_menu
		endif
	else
		/*if GoalManager_HasActiveGoals
					make_theme_menu_item {
						text="Pro Trick Objects"
						pad_choose_script=generic_menu_pad_choose
						pad_choose_params={ callback=create_pro_trick_objects_menu }
						not_focusable
						rgba=[50 50 50 90]
					}
				else
					make_theme_menu_item {
						text="Pro Trick Objects"
						pad_choose_script=generic_menu_pad_choose
						pad_choose_params={ callback=create_pro_trick_objects_menu }
					}
				endif*/
	endif
endif
endif

	if IsXbox
		make_theme_menu_item text="Adjust Gamma" id=menu_gamma pad_choose_script=create_gamma_menu
	else
		make_theme_menu_item text="Screen Mode" id=menu_screen pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=create_screen_menu }
	endif
	make_theme_menu_item text="Sound Options" id=menu_sound_options pad_choose_script=launch_sound_options_menu pad_choose_params={ from_options }
	make_theme_menu_item text="Control Scheme" id=menu_control_scheme pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=create_control_scheme_menu }
	make_theme_menu_item text="Tweaks" id=menu_tweaks pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=create_tweaks_menu }

	if not InSplitScreenGame
		if not inNetGame
			make_theme_menu_item { text='Control Setup'
				id=options_controller
				pad_choose_script=create_controller_config_menu
				pad_choose_params={ controller_number=1 from_options }
				centered
				no_bg
			}
		endif
	endif

	make_theme_menu_item text="Display Options" id=menu_display_options pad_choose_script=launch_display_options_menu pad_choose_params={ from_options }

	//if not (DEMO_BUILD)
	if not InNetGame
		make_theme_menu_item text="Interface Themes" id=menu_themes pad_choose_script=swap_themes_menu pad_choose_params={ from_options=from_options }
	endif
	if InNetGame
		if InTeamGame
			GetPreferenceString pref_type=network score_display
			make_theme_menu_item text="Score Display Mode" id=menu_score_display pad_choose_script=create_options_score_display_menu
			make_theme_menu_item text=<ui_string> id=menu_score_display_str rgba=[80 80 80 128] not_focusable
		endif

		;GetPreferenceString pref_type=network show_names
		;FormatText TextName=PlayerName_toggle_text "Player Names: %s" s=<ui_string>
		;make_theme_menu_item text=<PlayerName_toggle_text> id=menu_toggle_names pad_choose_script=toggle_show_name_option

		GetPreferenceString pref_type=network auto_brake
		FormatText TextName=AutoBrake_toggle_text "Auto-Brake: %s" s=<ui_string>
		make_theme_menu_item text=<AutoBrake_toggle_text> id=menu_auto_brake pad_choose_script=toggle_auto_brake_option toggle_pos=(163,12)
	else
		if not ObjectExists id=menu_real_cheats
			make_theme_menu_item text="Cheats" id=menu_real_cheats pad_choose_script=create_real_cheats_menu
		endif
	endif
	//endif

	<show_cutscene_menu> = 1
	if Pal
		if IsNgc
			// This is a NGC/PAL temp patch to fix running out of memory
			// when exiting cutscenes, after the whole game has
			// been completed.  to fix, we remove the "watch cutscenes"
			// menu for NGC/PAL builds.
			<show_cutscene_menu> = 0
		endif
	endif

	if ( <show_cutscene_menu> = 1 )
		if GameModeEquals is_career
			has_cutscenes
			if (<does_have_cutscenes> = 1)
				make_theme_menu_item text="Watch Cutscenes" id=menu_watch_cutscenes pad_choose_script=create_watch_cutscenes_menu
			else
				make_theme_menu_item text="Watch Cutscenes" id=menu_watch_cutscenes not_focusable=not_focusable
			endif
		endif
	endif

	PrintStruct <...>
	if InNetGame
		if GameModeEquals is_lobby
			/*
			if IsHost
				make_theme_menu_item text="Pro Trick Objects" id=pro_trick_obj_menu pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=create_pro_trick_objects_menu }
			endif
			*/

			if IsObserving
				NoCustomRestarts=1
			else
				if not ObjectExists Id=Skater
					NoCustomRestarts=1
				else
					if Skater:Skating
						if Skater:OnLip
							NoCustomRestarts=1
						else
							if Skater:OnRail
								NoCustomRestarts=1
							endif
						endif
					else
						if Skater:Walking
							Skater:Walk_GetState
							if ( <State> = WALKING_HANG || <State> = WALKING_LADDER || <State> = WALKING_ANIMWAIT )
								NoCustomRestarts=1
							endif
						endif
					endif
				endif
			endif

			PrintStruct <...>
			if Not GotParam NoCustomRestarts
				make_theme_menu_item {
					text="Set Restart"
					id=menu_set_custom
					pad_choose_script=menu_select
					pad_choose_params={ menu_select_script=set_custom_restart }
				}

				if Skater:SetCustomRestart
					make_theme_menu_item text="Goto Cust Restart" id=menu_skip_to_custom pad_choose_script=menu_select pad_choose_params={menu_select_script=skip_to_custom_restart}
				endif
			endif
		endif
	else
		/*
		make_theme_menu_item text="Pro Trick Objects" id=pro_trick_obj_menu pad_choose_script=generic_menu_pad_choose pad_choose_params={ callback=create_pro_trick_objects_menu }
        */
		if GoalManager_HasActiveGoals count_all
			NoCustomRestarts=1
		else
			if Skater:PlayerInputIsDisabled
				NoCustomRestarts=1
			else
				if GameModeEquals is_createGoals
					NoCustomRestarts=1
				else
					if Skater:Skating
						if Skater:OnLip
							NoCustomRestarts=1
						else
							if Skater:OnRail
								NoCustomRestarts=1
							endif
						endif
					else
						if Skater:Walking
							Skater:Walk_GetState
							if ( <State> = WALKING_HANG || <State> = WALKING_LADDER || <State> = WALKING_ANIMWAIT )
								NoCustomRestarts=1
							endif
						endif
					endif
				endif
			endif
		endif

		if not GotParam NoCustomRestarts
			if not GameModeEquals is_creategoals
				make_theme_menu_item text="Set Restart" id=menu_set_custom pad_choose_script=menu_select pad_choose_params={menu_select_script=set_custom_restart}
			endif
			if Skater:SetCustomRestart
				make_theme_menu_item text="Goto Cust Restart" id=menu_skip_to_custom pad_choose_script=menu_select pad_choose_params={menu_select_script=skip_to_custom_restart}
			endif
		endif
	endif

	make_theme_menu_item text="Done" id=menu_done pad_choose_script=<pad_back_script> pad_choose_params={ no_sound }

	add_music_track_text

	build_top_bar pos=(-400,62)

	DoScreenElementMorph id=top_bar_anchor time=0.2 pos=(0,62)

	FireEvent type=focus target=current_menu_anchor
endscript

script options_menu_add_toggle_item {   focus_script=do_scale_up
		unfocus_script=do_scale_down
		pad_choose_script=nullscript
		font_face=small
		parent_menu_id=current_menu
		scale=1
		rgba=[50 50 50 90]
		toggle_pos=(195,12)
		on_off_text="On"
	}

	if GotParam not_focusable
		CreateScreenElement {
			type=textelement
			parent=<parent_menu_id>
			id=<id>

			text=<text>
			font=<font_face>
			rgba=[30 30 30 128]
			scale=<scale>
			dims=<dims>
			not_focusable
		}
	else
		CreateScreenElement {
			type=textelement
			parent=<parent_menu_id>
			id=<id>

			text=<text>
			font=<font_face>
			rgba=<rgba>
			scale=<scale>
			dims=<dims>
			event_handlers=[
				{focus              <focus_script> params=<focus_params>}
				{unfocus            <unfocus_script> params=<unfocus_params>}
				{pad_choose			generic_menu_pad_choose_sound }
				{pad_start			generic_menu_pad_choose_sound }
				{pad_choose         <pad_choose_script> params=<pad_choose_params>}
				{pad_start          <pad_choose_script> params=<pad_choose_params>}
			]
		}

		CreateScreenElement {
			type=textelement
			parent=<id>

			pos=<toggle_pos>
			text=<on_off_text>
			font=<font_face>
			rgba=<rgba>;[80 80 80 128]
			scale=<scale>
		}
	endif
endscript

camera_angle=0

script toggle_camera_angle
	switch camera_angle
		case 0
			change camera_angle=1
			SetScreenElementProps id={ menu_camera child=0 } text="Camera Angle: 2"
			ToggleSkaterCamMode  skater = 0
		case 1
			change camera_angle=2
			SetScreenElementProps id={ menu_camera child=0 } text="Camera Angle: 3"
			ToggleSkaterCamMode  skater = 0
		case 2
			change camera_angle=3
			SetScreenElementProps id={ menu_camera child=0 } text="Camera Angle: 4"
			ToggleSkaterCamMode  skater = 0
		case 3
			change camera_angle=0
			SetScreenElementProps id={ menu_camera child=0 } text="Camera Angle: 1"
			ToggleSkaterCamMode  skater = 0
	endswitch
endscript

script create_watch_cutscenes_menu back_script=create_options_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="CUTSCENES" title_icon=<title_icon> ;dims=(600,200) pos=(229,80) right_bracket_z=1

	SetScreenElementProps { id=sub_menu
		event_handlers=[
			{ pad_back           generic_menu_pad_back params={ callback=<back_script> } }
		]
	}

	add_viewed_cutscenes_to_menu

	theme_menu_add_item text="Done" pad_choose_script=generic_menu_pad_choose pad_choose_params={callback=<back_script>} centered last_menu_item=last_menu_item

	finish_themed_sub_menu

endscript

script has_cutscenes
	GetCurrentLevel
	// figure the level num
	switch <level>
		case load_nj
		case load_ny
		case load_fl
		case load_sd
		case load_hi
		case load_vc
		case load_sj
		case load_ru
			return does_have_cutscenes = 1
		default
			return does_have_cutscenes = 0
	endswitch

endscript

script add_viewed_cutscenes_to_menu


	GetCurrentLevel
	// figure the level num
	switch <level>
		case load_nj
			<cutscene_list> = cutscene_unlock_list_nj
		case load_ny
			<cutscene_list> = cutscene_unlock_list_ny
		case load_fl
			<cutscene_list> = cutscene_unlock_list_fl
		case load_sd
			<cutscene_list> = cutscene_unlock_list_sd
		case load_hi
			<cutscene_list> = cutscene_unlock_list_hi
		case load_vc
			<cutscene_list> = cutscene_unlock_list_vc
		case load_sj
			<cutscene_list> = cutscene_unlock_list_sj
		case load_ru
			<cutscene_list> = cutscene_unlock_list_ru
		default
			return
	endswitch

	GetArraySize <cutscene_list>

	<index>=0
	begin

		// Fix for SK5:TT14749:	 Story - Slam City Jam - Freeze - Premiere cutscene causes freeze
		// To fix, we remove the Premiere movie from the NGC version of the cutscene menu.
		if not IsNgc
			<skip_me> = 0
		else
			if StructureContains structure=(((<cutscene_list>)[<index>])) not_with_ngc
				<skip_me> = 1
			else
				<skip_me> = 0
			endif
		endif

		if GetGlobalFlag flag=(((<cutscene_list>)[<index>]).flag)
			if StructureContains structure=(((<cutscene_list>)[<index>])) name2
				if ( <skip_me> = 0 )
					theme_menu_add_item {
						text = (((<cutscene_list>)[<index>]).text)
						pad_choose_script=watch_cutscene
						pad_choose_params={name=(((<cutscene_list>)[<index>]).name) name2=(((<cutscene_list>)[<index>]).name2) tod_action=(((<cutscene_list>)[<index>]).tod_action) tod_action2=(((<cutscene_list>)[<index>]).tod_action2) tod_action3=(((<cutscene_list>)[<index>]).tod_action3)}
						centered
					}
				endif
			else
				if ( <skip_me> = 0 )
					theme_menu_add_item {
						text = (((<cutscene_list>)[<index>]).text)
						pad_choose_script=watch_cutscene
						pad_choose_params={name=(((<cutscene_list>)[<index>]).name) tod_action=(((<cutscene_list>)[<index>]).tod_action) tod_action2=(((<cutscene_list>)[<index>]).tod_action2)}
						centered
					}
				endif
			endif
		endif

		<index>=(<index>+1)
	repeat <array_size>

endscript

script watch_cutscene
	// need to do this before the cutscene begins
	// or else it will pause the game...
	Debounce X 2.5
	pause_menu_gradient off
	If GotParam Tod_Action
		script_change_tod tod_action=<Tod_Action>
	endif
	If GotParam Tod_Action2
		script_change_tod tod_action=<Tod_Action2>
	endif
	UnpauseGame
	Debounce X 2.5
	PauseMusic 0
	if not GotParam name2
		PlayCutscene <...> from_cutscene_menu dont_send_skater_to_hand_brake exitScript=watch_cutscene_done
	else
		PlayCutscene {
			name=<name>
			from_cutscene_menu
			dont_send_skater_to_hand_brake
			unload_anims=1
			reload_anims=0
			unload_goals=1
			reload_goals=0
			exitScript=spawn_next_cutscene
			exitParams={name=<name2> from_cutscene_menu dont_send_skater_to_hand_brake Tod_Action=<tod_action3> unload_anims=0 reload_anims=1 unload_goals=0 reload_goals=1 exitScript=watch_cutscene_done}
		}
	endif
	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen
endscript

script watch_cutscene_done
	// now that the cutscene is done, go back into the pause menu
	PauseGame
	PauseMusic 1
	Debounce X 0.5
	pause_menu_gradient on
	create_watch_cutscenes_menu
endscript

script create_real_cheats_menu back_script=create_options_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if InSplitScreenGame
		GoalManager_HidePoints
	endif

	/*make_new_menu {
		menu_id=cheats_menu
		vmenu_id=cheats_vmenu
		menu_title="CHEATS"
		pos=(230, 38)
	}*/

	FormatText ChecksumName=title_icon "%i_cheats" i=(THEME_PREFIXES[current_theme_prefix])

	if inNetGame
		make_new_themed_scrolling_menu title="ADVANCED OPTIONS" title_icon=<title_icon> dims=(600,237) pos=(229,80) right_bracket_z=1
	else
		make_new_themed_scrolling_menu title="CHEATS" title_icon=<title_icon> dims=(600,237) pos=(229,80) right_bracket_z=1
	endif

	SetScreenElementProps { id=sub_menu
		event_handlers=[
			{ pad_back           generic_menu_pad_back params={ callback=<back_script> } }
		]
	}

	create_helper_text generic_helper_text_toggle
	kill_start_key_binding

	if not inNetGame
		if GetGlobalFlag flag=CHEAT_UNLOCKED_1
			make_cheats_menu_item text="Cool Specials" cheat_flag=CHEAT_COOL_SPECIAL_TRICKS pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
		endif
	endif

	/*if GetGlobalFlag flag=CHEAT_UNLOCKED_2
		make_cheats_menu_item {
			text="Gorilla Mode"
			id=menu_gorilla
			cheat_flag=CHEAT_GORILLA
			pad_choose_script=toggle_cheat
			pad_choose_params={
				on_callback=refresh_skater_model_for_cheats
				off_callback=refresh_skater_model_for_cheats
			}
		}
	endif*/

	if not inNetGame
		if GetGlobalFlag flag=CHEAT_UNLOCKED_3
			make_cheats_menu_item {
				text="Kid Mode"
				cheat_flag=CHEAT_KID
				pad_choose_script=toggle_cheat
				pad_choose_params={
					on_callback=refresh_skater_model_for_cheats
					off_callback=refresh_skater_model_for_cheats
				}
			}
		endif
	endif

	/*if GetGlobalFlag flag=CHEAT_UNLOCKED_4
		make_cheats_menu_item {
			text="Big Head Mode"
			id=menu_bighead
			cheat_flag=CHEAT_BIGHEAD
			pad_choose_script=toggle_cheat
			pad_choose_params={
				on_callback=refresh_skater_model_for_cheats
				off_callback=refresh_skater_model_for_cheats
			}
		}
	endif*/

	if not inNetGame
		if GetGlobalFlag flag=CHEAT_UNLOCKED_5
			make_cheats_menu_item {
				text="RollerSkates"
				cheat_flag=CHEAT_HOVERBOARD
				pad_choose_script=toggle_cheat
				pad_choose_params={
					on_callback=refresh_skater_model_for_cheats
					off_callback=refresh_skater_model_for_cheats
				}
			}
		endif
	endif

	/*if GetGlobalFlag flag=CHEAT_UNLOCKED_6
		make_cheats_menu_item text="Slomo" cheat_flag=CHEAT_SLOMO pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
	endif*/

	// GJ:  disable for multiplayer games, as we were running
	// out of DMA memory on THPS4 in horizontal split screen games...
	/*if GetGlobalFlag flag=CHEAT_UNLOCKED_7
		if not InSplitScreenGame
			make_cheats_menu_item text="Disco Mode" cheat_flag=CHEAT_DISCO pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
		endif
	endif*/

	/*if GetGlobalFlag flag=CHEAT_UNLOCKED_8
		make_cheats_menu_item {
			text="Invisible"
			cheat_flag=CHEAT_INVISIBLE
			pad_choose_script=toggle_cheat
			pad_choose_params={
				on_callback=refresh_skater_model_for_cheats
				off_callback=refresh_skater_model_for_cheats
			}
		}
	endif*/

	/*if GetGlobalFlag flag=CHEAT_UNLOCKED_9
		make_cheats_menu_item text="Super Blood" cheat_flag=CHEAT_SUPER_BLOOD pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
	endif*/

	if GetGlobalFlag flag=CHEAT_UNLOCKED_10
		make_cheats_menu_item text="Flame" cheat_flag=CHEAT_FLAME pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
	endif

	/*if GetGlobalFlag flag=CHEAT_UNLOCKED_11
		make_cheats_menu_item text="Sim Mode" cheat_flag=CHEAT_SIM pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
	endif*/

	if not inNetGame
		if GetGlobalFlag flag=CHEAT_UNLOCKED_12
			make_cheats_menu_item text="Always Special" cheat_flag=CHEAT_ALWAYS_SPECIAL pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
		endif
	endif

	if not inNetGame
		if GetGlobalFlag flag=CHEAT_UNLOCKED_13
			make_cheats_menu_item text="Perfect Rail" cheat_flag=CHEAT_PERFECT_RAIL pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
		endif
	endif

	if not inNetGame
		if GetGlobalFlag flag=CHEAT_UNLOCKED_14
			make_cheats_menu_item text="Perfect Skitch" cheat_flag=CHEAT_PERFECT_SKITCH pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
		endif
	endif

	/*if GetGlobalFlag flag=CHEAT_UNLOCKED_15
		make_cheats_menu_item text="Stats 13" cheat_flag=CHEAT_STATS_13 pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
	endif*/

	if not inNetGame
		if GetGlobalFlag flag=CHEAT_UNLOCKED_16
			make_cheats_menu_item text="Perfect Manual" cheat_flag=CHEAT_PERFECT_MANUAL pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
		endif
	endif


	// Rulon (TT13127): Moon grav is too risky for net games
	if not inNetGame
		if GetGlobalFlag flag=CHEAT_UNLOCKED_17
			make_cheats_menu_item text="Moon Gravity" cheat_flag=CHEAT_MOON pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
		endif
	endif

	/*if GetGlobalFlag flag=CHEAT_UNLOCKED_18
		make_cheats_menu_item text="Matrix Mode" cheat_flag=CHEAT_MATRIX pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript }
	endif */

	if inNetGame
		if IsHost
			make_cheats_menu_item text="No Reverts" cheat_flag=FLAG_G_EXPERT_MODE_NO_REVERTS pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript reverse}

			make_cheats_menu_item text="No Walking" cheat_flag=FLAG_G_EXPERT_MODE_NO_WALKING pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript reverse}

			make_cheats_menu_item text="No Manuals" cheat_flag=FLAG_G_EXPERT_MODE_NO_MANUALS pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript reverse}

			make_cheats_menu_item text="No Bal. Meters" cheat_flag=NO_G_DISPLAY_BALANCE pad_choose_script=toggle_cheat pad_choose_params={ on_callback=nullscript off_callback=nullscript reverse}
		endif
	endif

	//create_icon pos=(176, 45) texture=<options_icon>

	//FireEvent type=focus target=current_menu_anchor

	;if inNetGame
	;theme_menu_add_item text="Done" id=menu_done scale=1.0 pad_choose_script=<back_script> no_bg highlight_bar_scale=(3.9,0.8)
	;finish_themed_scrolling_menu bg_width=6.0 time=0.2
	;else
	theme_menu_add_item text="Done" id=menu_done scale=1.0 pad_choose_script=<back_script> no_bg highlight_bar_scale=(2.8,0.8)
	finish_themed_scrolling_menu bg_width=4.0 time=0.2
	;endif

	set_theme_icons
endscript

script make_cheats_menu_item {   focus_script=do_scale_up
		unfocus_script=do_scale_down
		pad_choose_script=nullscript
		font_face=small
		parent_menu_id=current_menu
		scale=0.8
		dims=(350,14)
		rgba=[88 105 112 128]
	}

	pad_choose_params={ cheat_flag=<cheat_flag> <pad_choose_params> }

	if GotParam not_focusable
		CreateScreenElement {
			type=textelement
			parent=<parent_menu_id>
			id=<id>

			text=<text>
			font=<font_face>
			rgba=[30 30 30 128]
			scale=<scale>
			dims=<dims>
			not_focusable
		}
	else
		/*CreateScreenElement {
			type=textelement
			parent=<parent_menu_id>
			id=<id>

			text=<text>
			font=<font_face>
			rgba=<rgba>
			scale=<scale>
			dims=<dims>
			event_handlers=[
				{focus              <focus_script> params=<focus_params>}
				{unfocus            <unfocus_script> params=<unfocus_params>}
				{pad_choose			generic_menu_pad_choose_sound }
				{pad_choose         <pad_choose_script> params=<pad_choose_params>}
				{pad_start          <pad_choose_script> params=<pad_choose_params>}
			]
		}*/

		if ( GetGlobalFlag flag=<cheat_flag> )
			on_off_text="On"
		else
			on_off_text="Off"
		endif

		/*CreateScreenElement {
			type=textelement
			parent=<id>

			pos=(210,12)
			text=<on_off_text>
			font=<font_face>
			rgba=<rgba>
			scale=<scale>
		}*/
		;if inNetGame
		;theme_menu_add_item text=<text> id=<checksum> highlight_bar_scale=(3.9,0.8) extra_text=<on_off_text> no_bg pad_choose_script=<pad_choose_script> pad_choose_params=<pad_choose_params>
		;else
		theme_menu_add_item text=<text> id=<checksum> highlight_bar_scale=(2.8,0.8) extra_text=<on_off_text> no_bg pad_choose_script=<pad_choose_script> pad_choose_params=<pad_choose_params>
		;endif
	endif
endscript

script choose_boolean_option
	set_preferences_from_ui prefs=network <...>
	create_options_menu
endscript

script back_from_boolean_menus
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	create_options_menu
endscript

script create_options_score_display_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="SCORE DISPLAY MODE" title_icon=<title_icon> right_bracket_alpha=0.0


	SetScreenElementProps {
		id=current_menu
		event_handlers=[ { pad_back	generic_menu_pad_back params={ callback=back_from_boolean_menus }} ]
		replace_handlers
	}

	theme_menu_add_item text="Show Players" centered id=menu_players pad_choose_script=choose_boolean_option pad_choose_params={ field="score_display" checksum=score_players string="Show Players" }
	theme_menu_add_item text="Show Teams" centered id=menu_teams pad_choose_script=choose_boolean_option pad_choose_params={ field="score_display" checksum=score_teams string="Show Teams" }

	theme_menu_add_item text="Done" pad_choose_script=back_from_boolean_menus last_menu_item=last_menu_item

	finish_themed_sub_menu
endscript

script toggle_show_name_option
	GetTags
	GetPreferenceString pref_type=network show_names
	if ( <ui_string> = "Off" )
		text="On"
		set_preferences_from_ui prefs=network field="show_names" checksum=boolean_true string="On"
		SetScreenelementProps id={ <id> child=0 } text="Player Names: On"
	else
		text="Off"
		set_preferences_from_ui prefs=network field="show_names" checksum=boolean_false string="Off"
		SetScreenelementProps id={ <id> child=0 } text="Player Names: Off"
		destroy_all_player_names
	endif
endscript

script toggle_auto_brake_option
	GetTags
	GetPreferenceString pref_type=network auto_brake
	if ( <ui_string> = "Off" )
		text="On"
		set_preferences_from_ui prefs=network field="auto_brake" checksum=boolean_true string="On"
		SetScreenelementProps id={ <id> child=0 } text="Auto-Brake: On"
	else
		text="Off"
		set_preferences_from_ui prefs=network field="auto_brake" checksum=boolean_false string="Off"
		SetScreenelementProps id={ <id> child=0 } text="Auto-Brake: Off"
	endif
endscript

// ********************************************************************
// 					Gamma menu (Xbox only)
// ********************************************************************

script create_gamma_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])

	make_new_themed_sub_menu title="GAMMA" title_icon=<title_icon>

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back		create_options_menu } ]
		replace_handlers
	}

	set_theme_icons

	GetGammaValues

	FormatText TextName=red_text "%i" i=<red>
	FormatText TextName=green_text "%i" i=<green>
	FormatText TextName=blue_text "%i" i=<blue>

	theme_menu_add_item text="Red: " extra_text = <red_text> id=gamma_menu_red
	theme_menu_add_item text="Green: " extra_text = <green_text> id=gamma_menu_green
	theme_menu_add_item text="Blue: " extra_text = <blue_text> id=gamma_menu_blue
	theme_menu_add_item text="Done" id=gamma_menu_done pad_choose_script=create_options_menu last_menu_item=last_menu_item


	// set pad events
	// red
	SetScreenElementProps {
		id=gamma_menu_red
		event_handlers=[ { pad_left		gamma_menu_turn_down params={ color=red } }
			{ pad_right	gamma_menu_turn_up params={ color=red } }
		]
		replace_handlers
	}
	// green
	SetScreenElementProps {
		id=gamma_menu_green
		event_handlers=[ { pad_left		gamma_menu_turn_down params={ color=green } }
			{ pad_right	gamma_menu_turn_up params={ color=green } }
		]
		replace_handlers
	}
	// blue
	SetScreenElementProps {
		id=gamma_menu_blue
		event_handlers=[ { pad_left		gamma_menu_turn_down params={ color=blue } }
			{ pad_right	gamma_menu_turn_up params={ color=blue } }
		]
		replace_handlers
	}

	// create children
	;gamma_menu_create_child text=<red_text> parent=gamma_menu_red
	;gamma_menu_create_child text=<green_text> parent=gamma_menu_green
	;gamma_menu_create_child text=<blue_text> parent=gamma_menu_blue

	create_helper_text { helper_text_elements=[ { text="\b7/\b4=Select" }
			{ text="\b6/\b5=Adjust" }
			{ text="\m0=Accept" }
			{ text="\m1=Back" }
		]
	}
	finish_themed_sub_menu
	;RunScriptOnScreenElement id=current_menu_anchor animate_in
endscript

script gamma_menu_create_child
	SetScreenElementLock id=<parent> off
	CreateScreenElement {
		type=TextElement
		parent=<parent>

		text=<text>
		font=small
		just=[right top]
		pos=(150, 0)
	}
endscript

script gamma_menu_check_levels
	GetGammaValues
	; printstruct <...>
	FormatText TextName=red_text "%i" i=<red>
	FormatText TextName=green_text "%i" i=<green>
	FormatText TextName=blue_text "%i" i=<blue>

	// update children
	SetScreenElementLock id=gamma_menu_red off
	SetScreenElementLock id=gamma_menu_green off
	SetScreenElementLock id=gamma_menu_blue off
	SetScreenElementProps {
		id={ gamma_menu_red child=3 }
		text=<red_text>
	}
	SetScreenElementProps {
		id={ gamma_menu_green child=3 }
		text=<green_text>
	}
	SetScreenElementProps {
		id={ gamma_menu_blue child=3 }
		text=<blue_text>
	}
endscript

script gamma_menu_turn_up
	GetGammaValues
	switch <color>
		case red
			if not ( <red> > 99 )
				PlaySound MenuUp
			endif
		case blue
			if not ( <blue> > 99 )
				PlaySound MenuUp
			endif
		case green
			if not ( <green> > 99 )
				PlaySound MenuUp
			endif
	endswitch

	ApplyChangeGamma <...> change=.01
	wait 1 frame
	gamma_menu_check_levels
endscript

script gamma_menu_turn_down
	GetGammaValues
	switch <color>
		case red
			if not ( 1 > <red> )
				PlaySound MenuUp
			endif
		case blue
			if not ( 1 > <blue> )
				PlaySound MenuUp
			endif
		case green
			if not ( 1 > <green> )
				PlaySound MenuUp
			endif
	endswitch

	ApplyChangeGamma <...> change=-.01
	wait 1 frame
	gamma_menu_check_levels
endscript


script create_split_menu callback_script=create_options_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	FormatText ChecksumName=title_icon "%i_2_player" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="SCREEN SETUP" title_icon=<title_icon> right_bracket_alpha=0.0

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=<callback_script> } } ]
		replace_handlers
	}

	theme_menu_add_item text="Horizontal" pad_choose_script=generic_menu_pad_choose centered=centered pad_choose_params={ <...> callback=split_setup_horizontal }
	theme_menu_add_item text="Vertical" last_menu_item=1 centered=centered pad_choose_script=generic_menu_pad_choose pad_choose_params={ <...> callback=split_setup_vertical }

	GoalManager_HideGoalPoints
	GoalManager_HidePoints

	finish_themed_sub_menu
endscript

script create_screen_menu callback_script=create_options_menu

	FormatText ChecksumName=title_icon "%i_screen" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="SCREEN" title_icon=<title_icon>

	if LevelIs load_skateshop
		callback_script = create_setup_options_menu
	else
		callback_script = create_options_menu
	endif

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=<callback_script> } } ]
		replace_handlers
	}

	if LevelIs load_skateshop
		build_screen_menu_graphic
	endif

	if IsPS2
		theme_menu_add_item text="Standard" extra_text="4:3" pad_choose_script=change_screen_mode pad_choose_params={ standard callback=screen_setup_standard mm_bg }
		theme_menu_add_item text="Widescreen" extra_text="16:9" pad_choose_script=change_screen_mode pad_choose_params={ wide callback=screen_setup_widescreen mm_bg }
		theme_menu_add_item text="Letterbox" extra_text="16:9" pad_choose_script=change_screen_mode pad_choose_params={ letter callback=screen_setup_letterbox mm_bg }
	endif
	if IsNGC
		theme_menu_add_item text="Standard" extra_text="4:3" pad_choose_script=change_screen_mode pad_choose_params={ standard callback=screen_setup_standard mm_bg }
		theme_menu_add_item text="Widescreen" extra_text="16:9" pad_choose_script=change_screen_mode pad_choose_params={ wide callback=screen_setup_widescreen mm_bg }
		//		theme_menu_add_item text="Letterbox 16:9 (unsupported)" pad_choose_script=screen_setup_widescreen not_focusable
	endif
	if Not isTrue Bootstrap_Build
		; theme_menu_add_item id=screen_option_hide_hud text="Hide HUD" pad_choose_script=screen_setup_hide_hud
		; screen_option_update_hud_toggle
		theme_menu_add_item text="Done" id=screen_menu_done pad_choose_script=<callback_script> last_menu_item=1
	endif

	finish_themed_sub_menu

endscript

script change_screen_mode
	if LevelIs load_skateshop
		KillSpawnedScript name=morph_tv_scan_line

		if GotParam standard
			DoScreenElementMorph id=tv scale=(1,0.8)
			DoScreenElementMorph id=tv_thug_logo scale=(1,1)
			DoScreenElementMorph id=tv_black_bar alpha=0
			DoScreenElementMorph id=tv_black_bar2 alpha=0
		endif
		if GotParam wide
			DoScreenElementMorph id=tv scale=(1.53,0.8)
			DoScreenElementMorph id=tv_thug_logo scale=(1.53,1)
			DoScreenElementMorph id=tv_black_bar alpha=0
			DoScreenElementMorph id=tv_black_bar2 alpha=0
			scale=(32,0.25) scale2=(35,0.25)
			pos=(31,-53) pos2=(-3,38)
		endif
		if GotParam letter
			DoScreenElementMorph id=tv scale=(1,0.8)
			DoScreenElementMorph id=tv_thug_logo scale=(1.25,0.8)
			DoScreenElementMorph id=tv_black_bar alpha=1
			DoScreenElementMorph id=tv_black_bar2 alpha=1
		endif

		RunScriptOnScreenElement id=tv_white_line morph_tv_scan_line params={ scale=<scale> scale2=<scale2> pos=<pos> pos2=<pos2> }
	endif

	<callback> <...>
endscript

script build_screen_menu_graphic logo_scale=(1,1) alpha=0 tv_scale=(1,0.8)
	if ( current_screen_mode = widescreen_screen_mode )
		logo_scale=(1.53,1)
		tv_scale=(1.53,0.8)
	else
		if ( current_screen_mode = letterbox_screen_mode )
			logo_scale=(1.25,0.8)
			alpha=1
		endif
	endif

	CreateScreenElement {
		type=containerelement
		parent=current_menu_anchor
		pos=(470,220)
		scale=0.9
	}
	anchor_id=<id>

	// tv
	CreateScreenElement {
		type=spriteelement
		parent=<anchor_id>
		id=tv

		texture=sc_icon_1
		pos=(0,0)
		rot_angle=20
		just=[center center]
		scale=<tv_scale>
		alpha=0.3
	}

	// logo
	CreateScreenElement {
		type=spriteelement
		parent=<anchor_id>
		id=tv_thug_logo

		texture=sc_icon_2
		pos=(8,-12)
		rot_angle=20
		just=[center center]
		scale=<logo_scale>
		alpha=0.5
	}

	// black bars
	CreateScreenElement {
		type=spriteelement
		parent=<anchor_id>
		id=tv_black_bar

		texture=white2
		pos=(-56,-90)
		rot_angle=20
		scale=(23,2.5)
		rgba=[0 0 0 128]
		just=[left top]
		alpha=<alpha>
	}

	CreateScreenElement {
		type=spriteelement
		parent=<anchor_id>
		id=tv_black_bar2

		texture=white2
		pos=(-78,-5)
		rot_angle=20
		scale=(21,2.5)
		rgba=[0 0 0 128]
		just=[left top]
		alpha=<alpha>
	}

	if ( current_screen_mode = widescreen_screen_mode )
		scale=(32,0.25) scale2=(35,0.25)
		pos=(31,-53) pos2=(-3,38)
	endif

	// white line
	CreateScreenElement {
		type=spriteelement
		parent=<anchor_id>
		id=tv_white_line

		texture=white2
		pos=(28,-55)
		scale=<scale>;(22.8,0.5)
		;pos=(-6,40)
		;scale=(21,0.25)
		rot_angle=20
		just=[center top]
		alpha=0.1
		z_priority=5
	}

	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=so_rotating_bg

		texture=bg_vector_1
		rgba=[23 58 75 15]
		just=[center, center]
		pos=(210, 180)
		z_priority=-4
	}

	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=so_rotating_bg2

		texture=bg_vector_1
		rgba=[100 25 3 15]
		just=[center, center]
		pos=(210, 180)
		z_priority=-3
	}

	spawnscript chap_new_rotating_bg params={ id=so_rotating_bg scale=1.4 rot_angle=-5752 }
	spawnscript chap_new_rotating_bg_2 params={ id=so_rotating_bg2 scale=1.1 rot_angle=-5752 }

	RunScriptOnScreenElement id=tv_thug_logo tv_logo_twitch
	RunScriptOnScreenElement id=tv_white_line morph_tv_scan_line params={ scale=<scale> scale2=<scale2> pos=<pos> pos2=<pos2> }
endscript

script morph_tv_scan_line scale=(21,0.25) scale2=(22.8,0.25) pos=(28,-55) pos2=(-6,38)
	begin
		DoMorph pos=<pos>  scale=<scale2>
		DoMorph pos=<pos2> scale=<scale> time=1.5
	repeat
endscript

script tv_logo_twitch id=tv_thug_logo time=0.75
	begin
		DoScreenElementMorph id=<id> time=<time> scale=(1.01,0.999) alpha=0.45 relative_scale
		wait <time> seconds

		DoScreenElementMorph id=<id> time=<time> scale=1.0 alpha=0.5 relative_scale
		wait <time> seconds
	repeat
endscript

script screen_option_update_hud_toggle
	if ( HIDEHUD = 1 )
		FormatText TextName=text "HUD: off"
	else
		FormatText TextName=text "HUD: on"
	endif
	SetScreenElementProps {
		id=screen_option_hide_hud
		text=<texT>
	}
endscript

script screen_setup_hide_hud
	if ( HIDEHUD = 0 )
		change HIDEHUD = 1
	else
		change HIDEHUD = 0
	endif

	screen_option_update_hud_toggle
endscript

script split_setup_horizontal
	printf "changing split mode to horizontal"
	SetScreenMode split_horizontal
	ScreenElementSystemCleanup
	if GotParam end_run
		create_end_run_menu
	else
		create_pause_menu
	endif
	UpdateScore
	SetActivecamera id=skatercam0 viewport=0
	SetActiveCamera id=skatercam1 viewport=1
endscript

script split_setup_vertical
	printf "changing split mode to vertical"
	SetScreenMode split_vertical
	ScreenElementSystemCleanup
	if GotParam end_run
		create_end_run_menu
	else
		create_pause_menu
	endif
	UpdateScore
	SetActivecamera id=skatercam0 viewport=0
	SetActiveCamera id=skatercam1 viewport=1
endscript



// ********************************************************************
// Cheats menu
// ********************************************************************

script launch_cheats_menu
	RunScriptOnScreenElement id=current_menu_anchor animate_out callback=create_cheats_menu
endscript

script create_cheats_menu
	GoalManager_HidePoints
	GoalManager_HideGoalPoints

	make_new_menu {
		padding_scale=1
		menu_id=cheats_menu
		vmenu_id=cheats_vmenu
		menu_title="CHEATS"
		padding_scale=.9
		pos=(230, 40)
		helper_text=generic_helper_text
	}

	kill_start_key_binding

	SetScreenElementProps { id=cheats_menu
		event_handlers=[ { pad_back  create_options_menu } ]
	}
	make_text_sub_menu_item text="Time of Day" pad_choose_script=launch_timeofday_menu
	make_text_sub_menu_item text="View Cutscenes" pad_choose_script = launch_view_cutscenes_menu
	make_toggle_menu_item id=cheats_menu_level_lock text="Levels unlocked: " pad_choose_script=cheats_menu_change_level_lock
	;make_toggle_menu_item id=cheats_menu_stats_13 text="Stats 13: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_STATS_13 }
	;make_toggle_menu_item id=cheats_menu_perfect_rail text="Perfect rail: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_PERFECT_RAIL }
	;make_toggle_menu_item id=cheats_menu_perfect_manual text="Perfect manual: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_PERFECT_MANUAL }
	;make_toggle_menu_item id=cheats_menu_perfect_skitch text="Perfect Skitch: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_PERFECT_SKITCH }
	;make_toggle_menu_item id=cheats_menu_cool_special text="Cool Specials: " pad_choose_script=cheats_menu_change_cool_special

	; make_toggle_menu_item id=cheats_menu_snowboard text="Snowboard: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_SNOWBOARD }
	;make_toggle_menu_item id=cheats_menu_special text="Always Special: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_ALWAYS_SPECIAL }
	;make_toggle_menu_item id=cheats_menu_matrix text="Matrix: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_MATRIX }
	;make_toggle_menu_item id=cheats_menu_moon text="Moon: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_MOON }
	;make_toggle_menu_item id=cheats_menu_sim text="Sim mode: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_SIM }
	; make_toggle_menu_item id=cheats_menu_first text="First person: " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_FIRST_PERSON }
	; make_toggle_menu_item id=cheats_menu_number_12 text="Number 12 " pad_choose_script=cheats_menu_change_flag pad_choose_params={ flag=CHEAT_NUMBER12 }

	; make_text_sub_menu_item text="Set all stats to 5" pad_choose_script=cheats_menu_SetAllStats pad_choose_params={ value=5 }
	; make_text_sub_menu_item text="Set all stats to 8" pad_choose_script=cheats_menu_SetAllStats pad_choose_params={ value=8 }
	; make_text_sub_menu_item text="Set all stats to 10" pad_choose_script=cheats_menu_SetAllStats pad_choose_params={ value=10 }
	make_text_sub_menu_item text="Advance Stage" pad_choose_script=cheats_menu_advance_stage
	make_text_sub_menu_item text="Set Chapter/Stage" pad_choose_script=launch_chapter_stage_menu
	make_text_sub_menu_item text="100 Stat Points" pad_choose_script=cheats_menu_100_stat_points
	//make_text_sub_menu_item text="$5000 cash" pad_choose_script=cheats_menu_cash
	if GoalManager_HasActiveGoals
		make_text_sub_menu_item text="Beat current goal" pad_choose_script=cheats_menu_beat_current_goal
	endif
	make_text_sub_menu_item text="Unlock all chapters" pad_choose_script=unlock_all_chapters
	//make_text_sub_menu_item text="Unlock all goals" pad_choose_script=cheats_menu_UnlockAllGoals
	make_text_sub_menu_item text="Unlock all stats goals" pad_choose_script=cheats_menu_UnlockAllStatsGoals
	;make_text_sub_menu_item text="Unlock pro challenges" pad_choose_script=cheats_menu_UnlockProChallenges
	make_text_sub_menu_item text="Score 5 million points" pad_choose_script=cheats_menu_score5mil
	//	make_text_sub_menu_item text="Turn Pro" pad_choose_script=cheats_menu_turnPro
	make_text_sub_menu_item text="Mark all goals unbeaten" pad_choose_script=cheats_menu_UnBeatAllGoals
	make_text_sub_menu_item text="Set Difficulty Level" pad_choose_script=launch_cheats_menu_select_difficulty
	//	make_text_sub_menu_item text="Add 1 pro point" pad_choose_script=cheats_menu_addgoalpoint

	;RunScriptOnScreenElement id=cheats_menu_cool_special cheats_menu_check_cool_special
	RunScriptOnScreenElement id=cheats_menu_level_lock cheats_menu_check_level_lock
	;RunScriptOnScreenElement id=cheats_menu_stats_13 cheats_menu_check_flag params={ flag=CHEAT_STATS_13 }
	;RunScriptOnScreenElement id=cheats_menu_perfect_rail cheats_menu_check_flag params={ flag=CHEAT_PERFECT_RAIL }
	;RunScriptOnScreenElement id=cheats_menu_perfect_manual cheats_menu_check_flag params={ flag=CHEAT_PERFECT_MANUAL }
	; RunScriptOnScreenElement id=cheats_menu_snowboard cheats_menu_check_flag params={ flag=CHEAT_SNOWBOARD }
	;RunScriptOnScreenElement id=cheats_menu_special cheats_menu_check_flag params={ flag=CHEAT_ALWAYS_SPECIAL }
	;RunScriptOnScreenElement id=cheats_menu_matrix cheats_menu_check_flag params={ flag=CHEAT_MATRIX }
	;RunScriptOnScreenElement id=cheats_menu_moon cheats_menu_check_flag params={ flag=CHEAT_MOON }
	; RunScriptOnScreenElement id=cheats_menu_sim cheats_menu_check_flag params={ flag=CHEAT_SIM }
	; RunScriptOnScreenElement id=cheats_menu_first cheats_menu_check_flag params={ flag=CHEAT_FIRST_PERSON }
	; RunScriptOnScreenElement id=cheats_menu_number_12 cheats_menu_check_flag params={ flag=CHEAT_NUMBER12 }

	FireEvent type=focus target=cheats_menu
endscript

script cheats_menu_change_flag
	GetTags
	if GetGlobalFlag flag=<flag>
		UnSetGlobalFlag flag=<flag>
		toggle_menu_item_off id=<id>
	else
		SetGlobalFlag flag=<flag>
		toggle_menu_item_on id=<id>
	endif
endscript

script cheats_menu_check_flag
	GetTags
	if GetGlobalFlag flag=<flag>
		toggle_menu_item_on id=<id>
	else
		toggle_menu_item_off id=<id>
	endif
endscript

// level lock
script cheats_menu_check_level_lock
	GetTags
	if IntegerEquals a=all_levels_unlocked b=1
		toggle_menu_item_on id=<id>
	else
		toggle_menu_item_off id=<id>
	endif
endscript

script cheats_menu_change_level_lock
	GetTags
	if IntegerEquals a=all_levels_unlocked b=1
		toggle_menu_item_off id=<id>
		change all_levels_unlocked=0
	else
		if IntegerEquals a=all_levels_unlocked b=0
			toggle_menu_item_on id=<id>
			change all_levels_unlocked=1
		endif
	endif
	pulse_item
endscript

script cheats_menu_check_cool_special
	GetTags
	if IntegerEquals a=COOL_SPECIAL_TRICKS b=1
		toggle_menu_item_on id=<id>
	else
		toggle_menu_item_off id=<id>
	endif
endscript

script cheats_menu_change_cool_special
	GetTags
	if IntegerEquals a=COOL_SPECIAL_TRICKS b=1
		toggle_menu_item_off id=<id>
		change COOL_SPECIAL_TRICKS=0
	else
		if IntegerEquals a=COOL_SPECIAL_TRICKS b=0
			toggle_menu_item_on id=<id>
			change COOL_SPECIAL_TRICKS=1
		endif
	endif
	pulse_item
endscript


;script cheats_menu_SetAllStats
;	SetAllStats value=<value>
;	pulse_item
;endscript

script cheats_menu_100_stat_points
	AwardStatPoint 100
	pulse_item
endscript

script cheats_menu_UnlockAllGoals
	GoalManager_UnlockAllGoals
	//GoalManager_UnlockProSpecificChallenges
	pulse_item
endscript

script cheats_menu_UnlockAllStatsGoals
	skater:StatsManager_UnlockAmGoals
	skater:StatsManager_UnlockProGoals
	pulse_item
endscript

script cheats_menu_score5mil
	skater:SetTrickName "You cheat like Kurt"
	skater:SetTrickScore 5000000
	skater:display
endscript

script cheats_menu_turnPro
	GoalManager_TurnPro
endscript

script cheats_menu_UnBeatAllGoals
	GoalManager_UnBeatAllGoals
	GoalManager_UninitializeAllGoals
	GoalManager_InitializeAllGoals
endscript

script cheats_menu_addgoalpoint
	GoalManager_AddGoalPoint
endscript

script cheats_menu_unlockProChallenges
	GoalManager_UnlockProSpecificChallenges
endscript

script cheats_menu_cash
	GoalManager_AddCash 5000
endscript

script cheats_menu_beat_current_goal
	if GoalManager_GetActiveGoalId
		exit_pause_menu
		GoalManager_WinGoal name=<goal_id>
	endif
endscript

script cheats_menu_advance_stage
	exit_pause_menu
	GoalManager_DeactivateAllGoals
	GoalManager_GetCurrentChapterAndStage
	GoalManager_AdvanceStage force
	<stage_struct> = ( ( CHAPTER_COMPLETION_SCRIPTS[<currentChapter>] )[<currentStage>] )
	if StructureContains structure=<stage_struct> script_name
		<stage_script> = ( <stage_struct>.script_name )
	endif
	if StructureContains structure=<stage_struct> params
		<stage_script_params> = ( <stage_struct>.params )
	endif
	<stage_script> <stage_script_params> just_won_goal
	; printf "you just moved up a stage"
	; printf "we're in chapter %c, stage %s" c=<currentChapter> s=<currentStage>
endscript


script launch_cheats_menu_select_difficulty
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	make_new_menu {
		menu_id=cheats_select_difficulty_menu
		vmenu_id=cheats_select_difficulty_vmenu
		menu_title="SET DIFFICULTY"
		helper_text=generic_helper_text_left_right
	}

	make_text_sub_menu_item {
		text="Easy"
		id=cheats_difficulty_easy
		pad_choose_script=cheats_menu_set_difficulty
		pad_choose_params={ difficulty = 0 }
	}
	make_text_sub_menu_item {
		text="Normal"
		id=cheats_difficulty_normal
		pad_choose_script=cheats_menu_set_difficulty
		pad_choose_params={ difficulty = 1 }
	}
	make_text_sub_menu_item {
		text="Sick"
		id=cheats_difficulty_sick
		pad_choose_script=cheats_menu_set_difficulty
		pad_choose_params={ difficulty = 2 }
	}

	FireEvent type=focus target=cheats_select_difficulty_menu
endscript

script cheats_menu_set_difficulty
	GoalManager_SetDifficultyLevel <difficulty>
	GoalManager_UninitializeAllGoals
	GoalManager_InitializeAllGoals
	launch_cheats_menu
endscript

// ********************************************************************
// Chapter/Stage menu
// ********************************************************************

script launch_chapter_stage_menu
	RunScriptOnScreenElement id=current_menu_anchor animate_out callback=create_chapter_stage_menu
endscript

script create_chapter_stage_menu
	GoalManager_GetCurrentChapterAndStage
	SetScreenElementLock id=root_window off
	make_new_menu {
		menu_id=chapter_stage_menu
		vmenu_id=chapter_stage_vmenu
		menu_title="SET CHAPTER/STAGE"
		helper_text=generic_helper_text_left_right
	}

	// containers
	CreateScreenElement {
		type=ContainerElement
		parent=chapter_stage_vmenu
		id=chapter_stage_menu_chapter_container
		dims=(100, 20)
		event_handlers = [
			{ focus			chapter_stage_menu_focus }
			{ unfocus		chapter_stage_menu_unfocus }
			{ pad_right		chapter_stage_menu_change params={ chapter right } }
			{ pad_left		chapter_stage_menu_change params={ chapter left } }
		]
	}
	CreateScreenElement {
		type=ContainerElement
		parent=chapter_stage_vmenu
		id=chapter_stage_menu_stage_container
		dims=(100, 20)
		event_handlers = [
			{ focus			chapter_stage_menu_focus }
			{ unfocus		chapter_stage_menu_unfocus }
			{ pad_right		chapter_stage_menu_change params={ stage right } }
			{ pad_left		chapter_stage_menu_change params={ stage left } }
		]
	}

	// done button
	CreateScreenElement {
		type=TextElement
		parent=chapter_stage_vmenu
		font=small
		text="Done"
		event_handlers = [
			{ pad_choose	chapter_stage_menu_done }
			{ focus			do_scale_up }
			{ unfocus		do_scale_down }
		]
		rgba=[128 128 128 128]
	}

	// description text
	CreateScreenElement {
		type=TextElement
		parent=chapter_stage_menu_chapter_container
		font=small
		text="Chapter"
		just=[left top]
		rgba=[128 128 128 128]
	}
	CreateScreenElement {
		type=TextElement
		parent=chapter_stage_menu_stage_container
		font=small
		text="Stage"
		just=[left top]
		rgba=[128 128 128 128]
	}

	// chapter/stage numbers
	FormatText TextName=currentChapterText "%i" i=<currentChapter>
	CreateScreenElement {
		type=TextElement
		parent=chapter_stage_menu_chapter_container
		font=small
		text=<currentChapterText>
		just=[right top]
		rgba=[128 128 128 128]
		pos=(120, 0)
	}
	FormatText TextName=currentStageText "%i" i=<currentStage>
	CreateScreenElement {
		type=TextElement
		parent=chapter_stage_menu_stage_container
		font=small
		text=<currentStageText>
		just=[right top]
		rgba=[128 128 128 128]
		pos=(120, 0)
	}

	FireEvent type=focus target=chapter_stage_vmenu
endscript

script chapter_stage_menu_focus
	GetTags
	RunScriptOnScreenElement id={ <id> child=1 } do_scale_up
endscript

script chapter_stage_menu_unfocus
	GetTags
	RunScriptOnScreenElement id={ <id> child=1 } do_scale_down
endscript

script chapter_stage_menu_change
	GoalManager_GetCurrentChapterAndStage
	if GotParam left
		<change> = -1
	else
		<change> = 1
	endif

	if GotParam chapter
		<currentChapter> = ( <currentChapter> + <change> )
		if ( <currentChapter> < 0 )
			return
		else
			if ( <currentChapter> > 30 )
				return
			endif
		endif
	else
		<currentStage> = ( <currentStage> + <change> )
		if ( <currentStage> < 0 )
			return
		else
			if ( <currentStage> > 10 )
				return
			endif
		endif
	endif

	GoalManager_SetCurrentChapterAndStage chapter=<currentChapter> stage=<currentStage>

	GetTags
	if GotParam chapter
		FormatText TextName=chapterText "%i" i=<currentChapter>
		SetScreenElementProps {
			id={ <id> child=1 }
			text=<chapterText>
		}
	else
		FormatText TextName=stageText "%i" i=<currentStage>
		SetScreenElementProps {
			id={ <id> child=1 }
			text=<stageText>
		}
	endif
endscript

script chapter_stage_menu_done
	GoalManager_DeactivateAllGoals
	GoalManager_UninitializeAllGoals
	GoalManager_InitializeAllGoals
	launch_cheats_menu
endscript

/////////////////////////////////////////////////////
// CONTROL SCHEME (PS2 vs Xbox gameplay bindings)
// Sets the control_scheme global: 0 = Xbox (spine/acid = L2+R2), 1 = PS2 (single trigger + GrindRelease).
script create_control_scheme_menu callback_script=create_options_menu
	FormatText ChecksumName=title_icon "%i_control" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="CONTROL SCHEME" title_icon=<title_icon>

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=<callback_script> } } ]
		replace_handlers
	}

	theme_
	theme_menu_add_item text="Xbox" pad_choose_script=set_control_scheme pad_choose_params={ scheme=0 }
	theme_menu_add_item text="PS2"  pad_choose_script=set_control_scheme pad_choose_params={ scheme=1 }
	theme_menu_add_item text="Done" id=control_scheme_done pad_choose_script=<callback_script> last_menu_item=1

	finish_themed_sub_menu
endscript

script set_control_scheme
	change control_scheme = <scheme>
endscript

/////////////////////////////////////////////////////
// TWEAKS (optional behavior fixes)
script create_tweaks_menu callback_script=create_options_menu
	FormatText ChecksumName=title_icon "%i_control" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="TWEAKS" title_icon=<title_icon>

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=<callback_script> } } ]
		replace_handlers
	}

	// Keep the balance meter when switching balance sub-tricks (Manual<->NoseManual, Grind<->Slide).
	//theme_menu_add_item text="Keep Balance Meter: On"  pad_choose_script=set_tweak_keep_balance pad_choose_params={ val=1 }
	//theme_menu_add_item text="Keep Balance Meter: Off" pad_choose_script=set_tweak_keep_balance pad_choose_params={ val=0 }
	//make_toggle_menu_item id=balance_meter_fix text="Double tap balance fix:" pad_choose_script=set_tweak_keep_balance

	if (tweak_keep_balance = 1)
		value = 1
	else
		value = 0
	endif
	theme_menu_add_checkbox_item {
		id = tweakkeepbalance
		text = "Double tap balance fix"
		value = <value>
		pad_choose_script = set_tweak_keep_balance
	}

	if (tweak_wallplant_easy = 1)
		wp_value = 1
	else
		wp_value = 0
	endif
	theme_menu_add_checkbox_item {
		id = tweakwallplanteasy
		text = "Wallplant on X (no Down)"
		value = <wp_value>
		pad_choose_script = set_tweak_wallplant_easy
	}

	theme_menu_add_item text="Done" id=tweaks_done pad_choose_script=<callback_script> last_menu_item=1

	finish_themed_sub_menu

endscript

script set_tweak_keep_balance
	if (tweak_keep_balance = 1)
		change tweak_keep_balance = 0
		theme_set_checkbox value=0
	else
		change tweak_keep_balance = 1
		theme_set_checkbox value=1
	endif
endscript

script set_tweak_wallplant_easy
	if (tweak_wallplant_easy = 1)
		change tweak_wallplant_easy = 0
		theme_set_checkbox value=0
	else
		change tweak_wallplant_easy = 1
		theme_set_checkbox value=1
	endif
	// check_for_wallplant (C++) reads tweak_wallplant_easy directly to pick which trigger array
endscript

/////////////////////////////////////////////////////
// CONTROLLER CONFIG

script create_controller_config_menu

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		;wait 1 frame
	endif

	if GotParam controller_number
		if (<controller_number> = -1)
			FormatText TextName=menu_title "COMMON" n=<controller_number>
		else
			FormatText TextName=menu_title "PLAYER %n" n=<controller_number>
		endif

		helper_text = { helper_text_elements=[ { text="\b7/\b4 = Select" }
				{ text="\b6/\b5 = Adjust" }
				{ text="\m1 = Back" }
				{ text="\m0 = Accept" }
			]
		}
	else
		menu_title = "CONTROL SETUP"
		helper_text = { helper_text_elements=[ { text="\b7/\b4 = Select" }
				{ text="\m1 = Back" }
				{ text="\m0 = Accept" }
			]
		}
	endif

	FormatText ChecksumName=title_icon "%i_control" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title=<menu_title> title_icon=<title_icon>

	if LevelIs load_skateshop
		build_top_and_bottom_blocks
		make_mainmenu_3d_plane
		change joystick_pushed=0
		control_options_graphic
		SetScreenElementProps { id=sub_vmenu event_handlers=[
				{ pad_up       animate_joystick params={ dir=up } }
				{ pad_down     animate_joystick params={ dir=down } }
				;{ pad_left     animate_joystick params={ dir=left } }
				;{ pad_right    animate_joystick params={ dir=right } }
			]
		}
	endif

	kill_start_key_binding

	if isNGC
		<vibration_text> = "Rumble"
	else
		<vibration_text> = "Vibration"
	endif


	if GotParam from_options
		<from_options>=from_options
	endif

	if GotParam controller_number

		if GotParam from_options
			SetScreenElementProps { id=sub_menu
				event_handlers=[
					{pad_back           generic_menu_pad_back params={ callback=controller_config_exit from_options=<from_options>} }
				]
			}
		else
			SetScreenElementProps { id=sub_menu
				event_handlers=[
					{pad_back           generic_menu_pad_back params={ callback=create_controller_config_menu from_options=<from_options>} }
				]
			}
		endif

		if not (<controller_number> = -1)
			theme_menu_add_item {	text=<vibration_text>
				id=menu_vibration
				focus_script=controller_config_focus
				unfocus_script=controller_config_unfocus
				pad_choose_script=nullscript
			}
			theme_menu_add_item {	text="Autokick"
				id=menu_autokick
				focus_script=controller_config_focus
				unfocus_script=controller_config_unfocus
				pad_choose_script=nullscript
			}
			theme_menu_add_item {	text="180 Spin Taps" //don't take out extra space.. need it
				id=menu_spintaps
				focus_script=controller_config_focus
				unfocus_script=controller_config_unfocus
				pad_choose_script=nullscript

			}
		endif

		if (<controller_number> = 1)
			if not LevelIs load_skateshop

				if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_REVERTS))
					theme_menu_add_item {	text="No Reverts" //don't take out extra space.. need it
						id=menu_reverts
						focus_script=controller_config_focus
						unfocus_script=controller_config_unfocus
						pad_choose_script=nullscript
						not_focusable=not_focusable
					}
				else
					theme_menu_add_item {	text="No Reverts" //don't take out extra space.. need it
						id=menu_reverts
						focus_script=controller_config_focus
						unfocus_script=controller_config_unfocus
						pad_choose_script=nullscript
					}
				endif

				if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_MANUALS))
					theme_menu_add_item {	text="No Manuals" //don't take out extra space.. need it
						id=menu_manuals
						focus_script=controller_config_focus
						unfocus_script=controller_config_unfocus
						pad_choose_script=nullscript
						not_focusable=not_focusable
					}
				else
					theme_menu_add_item {	text="No Manuals" //don't take out extra space.. need it
						id=menu_manuals
						focus_script=controller_config_focus
						unfocus_script=controller_config_unfocus
						pad_choose_script=nullscript
					}
				endif

				if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING))
					theme_menu_add_item {	text="No Walking" //don't take out extra space.. need it
						id=menu_walking
						focus_script=controller_config_focus
						unfocus_script=controller_config_unfocus
						pad_choose_script=nullscript
						not_focusable=not_focusable
					}
				else
					theme_menu_add_item {	text="No Walking" //don't take out extra space.. need it
						id=menu_walking
						focus_script=controller_config_focus
						unfocus_script=controller_config_unfocus
						pad_choose_script=nullscript
					}
				endif
			endif
		endif

		if(<controller_number> = -1)
			if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_REVERTS))
				theme_menu_add_item {	text="No Reverts" //don't take out extra space.. need it
					id=menu_reverts
					focus_script=controller_config_focus
					unfocus_script=controller_config_unfocus
					pad_choose_script=nullscript
					not_focusable=not_focusable
				}
			else
				theme_menu_add_item {	text="No Reverts" //don't take out extra space.. need it
					id=menu_reverts
					focus_script=controller_config_focus
					unfocus_script=controller_config_unfocus
					pad_choose_script=nullscript
				}
			endif

			if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_MANUALS))
				theme_menu_add_item {	text="No Manuals" //don't take out extra space.. need it
					id=menu_manuals
					focus_script=controller_config_focus
					unfocus_script=controller_config_unfocus
					pad_choose_script=nullscript
					not_focusable=not_focusable
				}
			else
				theme_menu_add_item {	text="No Manuals" //don't take out extra space.. need it
					id=menu_manuals
					focus_script=controller_config_focus
					unfocus_script=controller_config_unfocus
					pad_choose_script=nullscript
				}
			endif

			if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING))
				theme_menu_add_item {	text="No Walking" //don't take out extra space.. need it
					id=menu_walking
					focus_script=controller_config_focus
					unfocus_script=controller_config_unfocus
					pad_choose_script=nullscript
					not_focusable=not_focusable
				}
			else
				theme_menu_add_item {	text="No Walking" //don't take out extra space.. need it
					id=menu_walking
					focus_script=controller_config_focus
					unfocus_script=controller_config_unfocus
					pad_choose_script=nullscript
				}
			endif
		endif

		if GotParam from_options
			theme_menu_add_item {	text="Done"
				id=menu_done
				pad_choose_script=generic_menu_pad_choose
				pad_choose_params={ callback=controller_config_exit from_options=<from_options>}
				last_menu_item=last_menu_item
			}
		else
			theme_menu_add_item {	text="Done"
				id=menu_done
				pad_choose_script=generic_menu_pad_choose
				pad_choose_params={ callback=create_controller_config_menu from_options=<from_options>}
				last_menu_item=last_menu_item
			}
		endif

		control_config_show_values controller_number=<controller_number>
	else
		SetScreenElementProps { id=sub_menu
			event_handlers=[
				{pad_back           generic_menu_pad_back params={ callback=controller_config_exit from_options=<from_options>} }
			]
		}

		theme_menu_add_item {	text="Player 1"
			id=menu_controller_1
			pad_choose_script=generic_menu_pad_choose
			pad_choose_params={ callback=create_controller_config_menu controller_number=1 from_options=<from_options> }
			centered
		}
		theme_menu_add_item {	text="Player 2"
			id=menu_controller_2
			pad_choose_script=generic_menu_pad_choose
			pad_choose_params={ callback=create_controller_config_menu controller_number=2 from_options=<from_options>}
			centered
		}
		theme_menu_add_item {	text="Common"
			id=menu_controller_x
			pad_choose_script=generic_menu_pad_choose
			pad_choose_params={ callback=create_controller_config_menu controller_number=-1 from_options=<from_options>}
			centered
		}
		/*		if isxbox
			main_menu_add_item {	text="Controller 3"
									id=menu_controller_3
									pad_choose_script=generic_menu_pad_choose
                                    pad_choose_params={ callback=create_controller_config_menu controller_number=3 }
								}
			main_menu_add_item {	text="Controller 4"
									id=menu_controller_4
									pad_choose_script=generic_menu_pad_choose
                                    pad_choose_params={ callback=create_controller_config_menu controller_number=4 }
								}
		endif
*/

		theme_menu_add_item {	text="Done"
			id=menu_done
			pad_choose_script=generic_menu_pad_choose
			pad_choose_params={ callback=controller_config_exit from_options=<from_options>}
			last_menu_item=last_menu_item
			centered
		}

	endif

	finish_themed_sub_menu
	create_helper_text <helper_text>
endscript


script controller_config_exit
	KillSpawnedScript name=chap_new_rotating_bg
	KillSpawnedScript name=chap_new_rotating_bg2
	KillSpawnedScript name=shake_projector

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if GotParam from_options
		create_options_menu
	else
		create_setup_options_menu
	endif
endscript

script control_change_values

	player = ( <controller_number> - 1 )

	if GotParam vibration
		KillSpawnedScript name=control_menu_vibrate_controller

		VibrateController port=<player> actuator=1 percent=0
		if VibrationIsOn <player>
			VibrationOff <player>
			SetScreenElementProps id=menu_vibration_value text="off"
		else
			VibrationOn <player>
			SetScreenElementProps id=menu_vibration_value text="on"
			SpawnScript control_menu_vibrate_controller params=<...>
		endif
	endif

	if GotParam autokick
		if AutokickIsOn <player>
			AutokickOff <player>
			SetScreenElementProps id=menu_autokick_value text="off"
		else
			AutokickOn <player>
			SetScreenElementProps id=menu_autokick_value text="on"
		endif
	endif

	if GotParam spintaps
		if SpinTapsAreOn <player>
			SpinTapsOff <player>
			SetScreenElementProps id=menu_spintaps_value text="off"
		else
			SpinTapsOn <player>
			SetScreenElementProps id=menu_spintaps_value text="on"
		endif
	endif

	if GotParam reverts
		if not (GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_REVERTS)
			SetGlobalFlag flag=FLAG_EXPERT_MODE_NO_REVERTS
			SetScreenElementProps id=menu_reverts_value text="on"
		else
			UnsetGlobalFlag flag=FLAG_EXPERT_MODE_NO_REVERTS
			SetScreenElementProps id=menu_reverts_value text="off"
		endif
	endif

	if GotParam manuals
		if not (GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_MANUALS)
			SetGlobalFlag flag=FLAG_EXPERT_MODE_NO_MANUALS
			SetScreenElementProps id=menu_manuals_value text="on"
		else
			UnsetGlobalFlag flag=FLAG_EXPERT_MODE_NO_MANUALS
			SetScreenElementProps id=menu_manuals_value text="off"
		endif
	endif

	if GotParam walking
		if not (GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_WALKING)
			SetGlobalFlag flag=FLAG_EXPERT_MODE_NO_WALKING
			SetScreenElementProps id=menu_walking_value text="on"
		else
			UnsetGlobalFlag flag=FLAG_EXPERT_MODE_NO_WALKING
			SetScreenElementProps id=menu_walking_value text="off"
		endif
	endif

	GetTags
	if  GotParam left
		RunScriptOnScreenElement id={ <id> child=5 } menu_blink_arrow
	else
		RunScriptOnScreenElement id={ <id> child=6 } menu_blink_arrow
	endif
	generic_menu_pad_choose_sound

	TemporarilyDisableInput time=100
endscript

script control_menu_vibrate_controller
	If ScreenElementExists id=joystick_anchor
		spawnscript shake_projector params={ id=joystick_anchor amplitude=5 time=0.05 }
	endif
	;GetCurrentSkaterProfileIndex

	// find proper controller to vibrate
	if levelIs load_skateshop
		VibrateController port=<player> actuator=1 percent=70
		wait 250
		VibrateController port=<player> actuator=1 percent=0
		KillSpawnedScript name=shake_projector
	else
		index=0
		begin
			if ControllerBoundToSkater controller=<index> skater=<player>
				VibrateController port=<index> actuator=1 percent=70
				wait 250
				VibrateController port=<index> actuator=1 percent=0
				KillSpawnedScript name=shake_projector

				break
			endif
			index= ( <index> + 1 )
		repeat 4
	endif

	If ScreenElementExists id=joystick_anchor
		DoScreenElementMorph id=joystick_anchor pos=(340,30) time=0.1
	endif
endscript

joystick_pushed=0

script control_config_show_values

	FormatText ChecksumName=text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	player = ( <controller_number> - 1 )

	if not (<controller_number> = -1)
		if VibrationIsOn <player>
			vibration_value="on"
		else
			vibration_value="off"
		endif

		if AutokickIsOn <player>
			autokick_value="on"
		else
			autokick_value="off"
		endif

		if SpinTapsAreOn <player>
			spintaps_value="on"
		else
			spintaps_value="off"
		endif
	endif

	if(<controller_number> = 1)
		if not Levelis load_skateshop
			if not (GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_REVERTS)
				reverts_value="off"
			else
				reverts_value="on"
			endif

			if not (GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_WALKING)
				walking_value="off"
			else
				walking_value="on"
			endif

			if not (GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_MANUALS)
				manuals_value="off"
			else
				manuals_value="on"
			endif
		endif
	endif

	if(<controller_number> = -1)

		if not (GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_REVERTS)
			reverts_value="off"
		else
			reverts_value="on"
		endif

		if not (GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_WALKING)
			walking_value="off"
		else
			walking_value="on"
		endif

		if not (GetGlobalFlag flag=FLAG_EXPERT_MODE_NO_MANUALS)
			manuals_value="off"
		else
			manuals_value="on"
		endif

	endif

	if not (<controller_number> = -1)
		CreateScreenElement {
			type=TextElement
			parent=menu_vibration
			id=menu_vibration_value

			font=small
			just=[center top]
			pos=(142, -17)
			text=<vibration_value>
			rgba=<text_color>
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_vibration

			texture=left_arrow
			rgba=[128 128 128 0]
			pos=(122, -17)
			just=[right top]
			scale=.75
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_vibration

			texture=right_arrow
			rgba=[128 128 128 0]
			pos=(162, -17)
			just=[left top]
			scale=.75
		}

		CreateScreenElement {
			type=TextElement
			parent=menu_autokick
			id=menu_autokick_value

			font=small
			just=[center top]
			pos=(142, -17)
			text=<autokick_value>
			rgba=<text_color>
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_autokick

			texture=left_arrow
			rgba=[128 128 128 0]
			pos=(122, -17)
			just=[right top]
			scale=.75
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_autokick

			texture=right_arrow
			rgba=[128 128 128 0]
			pos=(162, -17)
			just=[left top]
			scale=.75
		}

		CreateScreenElement {
			type=TextElement
			parent=menu_spintaps
			id=menu_spintaps_value

			font=small
			just=[center top]
			pos=(142, -17)
			text=<spintaps_value>
			rgba=<text_color>
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_spintaps

			texture=left_arrow
			rgba=[128 128 128 0]
			pos=(122, -17)
			just=[right top]
			scale=.75
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_spintaps

			texture=right_arrow
			rgba=[128 128 128 0]
			pos=(162, -17)
			just=[left top]
			scale=.75
		}
	endif
	if (<controller_number>=1)
		if not Levelis load_skateshop
			if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_REVERTS))
				<rgba>= [60 60 60 75]
			else
				<rgba> = <text_color>
			endif

			CreateScreenElement {
				type=TextElement
				parent=menu_reverts
				id=menu_reverts_value

				font=small
				just=[center top]
				pos=(142, -17)
				text=<reverts_value>
				rgba=<rgba>
			}

			CreateScreenElement {
				type=SpriteElement
				parent=menu_reverts

				texture=left_arrow
				rgba=[128 128 128 0]
				pos=(122, -17)
				just=[right top]
				scale=.75
			}

			CreateScreenElement {
				type=SpriteElement
				parent=menu_reverts

				texture=right_arrow
				rgba=[128 128 128 0]
				pos=(162, -17)
				just=[left top]
				scale=.75
			}

			if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_MANUALS))
				<rgba>= [60 60 60 75]
			else
				<rgba> = <text_color>
			endif
			CreateScreenElement {
				type=TextElement
				parent=menu_manuals
				id=menu_manuals_value

				font=small
				just=[center top]
				pos=(142, -17)
				text=<manuals_value>
				rgba=<rgba>
			}

			CreateScreenElement {
				type=SpriteElement
				parent=menu_manuals

				texture=left_arrow
				rgba=[128 128 128 0]
				pos=(122, -17)
				just=[right top]
				scale=.75
			}

			CreateScreenElement {
				type=SpriteElement
				parent=menu_manuals

				texture=right_arrow
				rgba=[128 128 128 0]
				pos=(162, -17)
				just=[left top]
				scale=.75
			}

			if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING))
				<rgba>= [60 60 60 75]
			else
				<rgba> = <text_color>
			endif

			CreateScreenElement {
				type=TextElement
				parent=menu_walking
				id=menu_walking_value
				font=small
				just=[center top]
				pos=(142, -17)
				text=<walking_value>
				rgba=<rgba>
			}

			CreateScreenElement {
				type=SpriteElement
				parent=menu_walking

				texture=left_arrow
				rgba=[128 128 128 0]
				pos=(122, -17)
				just=[right top]
				scale=.75
			}

			CreateScreenElement {
				type=SpriteElement
				parent=menu_walking

				texture=right_arrow
				rgba=[128 128 128 0]
				pos=(162, -17)
				just=[left top]
				scale=.75
			}
		endif
	endif

	if (<controller_number>=-1)
		if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_REVERTS))
			<rgba>= [60 60 60 75]
		else
			<rgba> = <text_color>
		endif

		CreateScreenElement {
			type=TextElement
			parent=menu_reverts
			id=menu_reverts_value

			font=small
			just=[center top]
			pos=(142, -17)
			text=<reverts_value>
			rgba=<rgba>
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_reverts

			texture=left_arrow
			rgba=[128 128 128 0]
			pos=(122, -17)
			just=[right top]
			scale=.75
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_reverts

			texture=right_arrow
			rgba=[128 128 128 0]
			pos=(162, -17)
			just=[left top]
			scale=.75
		}

		if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_MANUALS))
			<rgba>= [60 60 60 75]
		else
			<rgba> = <text_color>
		endif
		CreateScreenElement {
			type=TextElement
			parent=menu_manuals
			id=menu_manuals_value

			font=small
			just=[center top]
			pos=(142, -17)
			text=<manuals_value>
			rgba=<rgba>
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_manuals

			texture=left_arrow
			rgba=[128 128 128 0]
			pos=(122, -17)
			just=[right top]
			scale=.75
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_manuals

			texture=right_arrow
			rgba=[128 128 128 0]
			pos=(162, -17)
			just=[left top]
			scale=.75
		}

		if ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING))
			<rgba>= [60 60 60 75]
		else
			<rgba> = <text_color>
		endif

		CreateScreenElement {
			type=TextElement
			parent=menu_walking
			id=menu_walking_value
			font=small
			just=[center top]
			pos=(142, -17)
			text=<walking_value>
			rgba=<rgba>
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_walking

			texture=left_arrow
			rgba=[128 128 128 0]
			pos=(122, -17)
			just=[right top]
			scale=.75
		}

		CreateScreenElement {
			type=SpriteElement
			parent=menu_walking

			texture=right_arrow
			rgba=[128 128 128 0]
			pos=(162, -17)
			just=[left top]
			scale=.75
		}

	endif

	// also set the pad_left and pad_right events while we're at it
	if levelIs load_skateshop
		pad_left_2 = animate_joystick
		pad_right_2 = animate_joystick
	else
		pad_left_2 = null_script
		pad_right_2 = null_script
	endif

	if not (<controller_number> = -1)
		SetScreenElementProps {
			id=menu_vibration
			event_handlers=[ { pad_left		control_change_values params={ vibration controller_number=<controller_number> left} }
				{ pad_right	control_change_values params={ vibration controller_number=<controller_number>} }
				{ pad_left     <pad_left_2> params={ dir=left } }
				{ pad_right    <pad_right_2> params={ dir=right } }
			]
			replace_handlers
		}
		SetScreenElementProps {
			id=menu_autokick
			event_handlers=[ { pad_left		control_change_values params={ autokick controller_number=<controller_number> left } }
				{ pad_right	control_change_values params={ autokick controller_number=<controller_number>} }
				{ pad_left     <pad_left_2> params={ dir=left } }
				{ pad_right    <pad_right_2> params={ dir=right } }
			]
			replace_handlers
		}
		SetScreenElementProps {
			id=menu_spintaps
			event_handlers=[ { pad_left		control_change_values params={ spintaps controller_number=<controller_number> left } }
				{ pad_right	control_change_values params={ spintaps controller_number=<controller_number>} }
				{ pad_left     <pad_left_2> params={ dir=left } }
				{ pad_right    <pad_right_2> params={ dir=right } }
			]
			replace_handlers
		}
	endif

	if(<controller_number> = 1)
		if not LevelIs load_skateshop
			SetScreenElementProps {
				id=menu_reverts
				event_handlers=[ { pad_left		control_change_values params={ reverts controller_number=<controller_number> left} }
					{ pad_right	control_change_values params={ reverts controller_number=<controller_number>} }
					{ pad_left     <pad_left_2> params={ dir=left } }
					{ pad_right    <pad_right_2> params={ dir=right } }
				]
				replace_handlers
			}
			SetScreenElementProps {
				id=menu_walking
				event_handlers=[ { pad_left		control_change_values params={ walking controller_number=<controller_number> left } }
					{ pad_right	control_change_values params={ walking controller_number=<controller_number>} }
					{ pad_left     <pad_left_2> params={ dir=left } }
					{ pad_right    <pad_right_2> params={ dir=right } }
				]
				replace_handlers
			}
			SetScreenElementProps {
				id=menu_manuals
				event_handlers=[ { pad_left		control_change_values params={ manuals controller_number=<controller_number> left } }
					{ pad_right	control_change_values params={ manuals controller_number=<controller_number>} }
					{ pad_left     <pad_left_2> params={ dir=left } }
					{ pad_right    <pad_right_2> params={ dir=right } }
				]
				replace_handlers
			}
		endif
	endif

	if (<controller_number>=-1)
		SetScreenElementProps {
			id=menu_reverts
			event_handlers=[ { pad_left		control_change_values params={ reverts controller_number=<controller_number> left} }
				{ pad_right	control_change_values params={ reverts controller_number=<controller_number>} }
				{ pad_left     <pad_left_2> params={ dir=left } }
				{ pad_right    <pad_right_2> params={ dir=right } }
			]
			replace_handlers
		}
		SetScreenElementProps {
			id=menu_walking
			event_handlers=[ { pad_left		control_change_values params={ walking controller_number=<controller_number> left } }
				{ pad_right	control_change_values params={ walking controller_number=<controller_number>} }
				{ pad_left     <pad_left_2> params={ dir=left } }
				{ pad_right    <pad_right_2> params={ dir=right } }
			]
			replace_handlers
		}
		SetScreenElementProps {
			id=menu_manuals
			event_handlers=[ { pad_left		control_change_values params={ manuals controller_number=<controller_number> left } }
				{ pad_right	control_change_values params={ manuals controller_number=<controller_number>} }
				{ pad_left     <pad_left_2> params={ dir=left } }
				{ pad_right    <pad_right_2> params={ dir=right } }
			]
			replace_handlers
		}
	endif
endscript

script controller_config_focus
	GetTags

	FormatText ChecksumName=text_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=arrow_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	main_theme_focus <...>

	SetScreenElementProps { id={ <id> child=4 } rgba=<text_color> }
	SetScreenElementProps { id={ <id> child=5 } rgba=<arrow_color> }
	SetScreenElementProps { id={ <id> child=6 } rgba=<arrow_color> }
endscript

script controller_config_unfocus
	GetTags

	FormatText ChecksumName=text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	main_theme_unfocus <...>

	SetScreenElementProps { id={ <id> child=4 } rgba=<text_color> }
	SetScreenElementProps { id={ <id> child=5 } rgba=[128 128 128 0] }
	SetScreenElementProps { id={ <id> child=6 } rgba=[128 128 128 0] }
endscript

// ****************************************************************
//
//			View goals menu
//
// ****************************************************************

script create_view_goals_menu
	hide_current_goal
	GoalManager_HidePoints
	GoalManager_HideGoalPoints

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 gameframe
	endif

	SetScreenElementLock id=root_window off

	// anchor for the whole thing
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=view_goals_menu

		dims=(640, 480)
		pos=(320, 240)
	}
	AssignAlias id=view_goals_menu alias=current_menu_anchor

	create_helper_text helper_text_elements=[ { text="\b7/\b4 = Select" }
		{ text="\m1 = Back" }
		{ text="\m0 = Jump to Goal (if unlocked)" }
	]

	FormatText ChecksumName=title_icon "%i_gap" i=(THEME_PREFIXES[current_theme_prefix])
	build_theme_sub_title title="GOALS" title_icon=<title_icon>
	FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
	build_theme_box_icons icon_texture=<paused_icon>
	build_grunge_piece
	build_top_bar pos=(0, 62)

	// theme background
	theme_background width=6.35 pos=(320,85) num_parts=10.5

	<root_pos> = (80, 25)
	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=untext_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// black bar at the top
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=black
		pos=(57,87)
		just=[left top]
		rgba=[0 0 0 85]
		scale=(130, 5)
		z_priority=2
	}

	// "goal" header
	/*CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor

		font=dialog
		text="Goal"
		rgba=<text_rgba>
		scale=.9
		pos=(70,87)
		just=[left top]
		z_priority=3
	}*/

	// "record" header
	/*CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor

		font=dialog
		text="Record"
		rgba=<text_rgba>
		scale=.9
		pos=(470,87)
		just=[left top]
		z_priority=3
	}*/

	// up arrow
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=view_goals_menu_up_arrow

		texture=up_arrow
		pos=(320,88)
		just=[left top]
		rgba=[128 128 128 128]
		z_priority=3
	}

	// down arrow
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=view_goals_menu_down_arrow

		texture=down_arrow
		pos=(320,372)
		just=[left top]
		rgba=[128 128 128 128]
		z_priority=3
	}

	// black bar at the bottom
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=black
		pos=(57,370)
		just=[left top]
		rgba=[0 0 0 85]
		scale=(130,5)
		z_priority=2
	}


	// vertical bar between view goals text and record
	/*CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=black
		scale=(2, 70.5)
		rgba=[0 0 0 80]
		pos=(400,100)
		just=[left top]
	}*/

	// scrolling menu
	CreateScreenElement {
		type=VScrollingMenu
		parent=current_menu_anchor

		dims=(640, 264)
		pos=(80,110)
		just=[left top]
		internal_just=[center top]
	}

	// vmenu
	CreateScreenElement {
		type=VMenu
		parent=<id>
		id=view_goals_vmenu

		pos=(0, 0)
		just=[left top]
		internal_just=[left top]
		dont_allow_wrap

		event_handlers=[
			{ pad_down	menu_vert_blink_arrow params={ id=view_goals_menu_down_arrow } }
			{ pad_up	menu_vert_blink_arrow params={ id=view_goals_menu_up_arrow } }
			;{ pad_up 		set_which_arrow params={ arrow=view_gaps_menu_up_arrow } }
			;{ pad_down		set_which_arrow params={ arrow=view_gaps_menu_down_arrow } }
			{ pad_up 		generic_menu_up_or_down_sound params={ up } }
			{ pad_down		generic_menu_up_or_down_sound params={ down } }
			{ pad_back		generic_menu_pad_back_sound }
			{ pad_back	view_goals_menu_exit params={ callback=create_pause_menu } }
		]
	}
	AssignAlias id=view_goals_vmenu alias=current_menu

	GoalManager_AddViewGoalsList

	// test items
	/*index=20
	begin
		formattext checksumname=id "goal_%i" i=<index>
		view_goals_menu_add_item goal_id=<id> text="blah" bogus
		index=(<index>+1)
	repeat 20*/

	FireEvent type=focus target=view_goals_vmenu
endscript


// called from c
script view_goals_menu_add_item
	// container for the element
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		id=<goal_id>

		dims=(500, 24)
	}
	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	// view goals text
	CreateScreenElement {
		type=TextElement
		parent=<goal_id>
		rgba=<text_rgba>
		text=<text>
		font=dialog
		;scale=.75
		pos=(0, 0)
		just=[left top]
	}

	if GotParam bogus
		SetScreenElementProps {
			id=<goal_id>
			event_handlers=[
				{ focus				view_goals_menu_focus_beaten }
				{ unfocus		 	view_goals_menu_unfocus_beaten }
			]
		}

		return
	endif

	//highlight bar
	highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )

	CreateScreenElement {
		type=SpriteElement
		parent=<goal_id>
		texture=de_highlight_bar

		pos=(240, 10)
		just=[center center]
		rgba=[0 0 0 0]
		z_priority=3
		scale=(4.1,0.7)
		rot_angle=(<highlight_angle>/4)
	}

	/*if GoalManager_HasWonGoal name=<goal_id>
		if not GotParam win_record_string
			// no record type for this goal
			<win_record_string> = "N/A"
		endif
		// add the record text
		CreateScreenElement {
			type=TextElement
			parent=<goal_id>
			rgba=<text_rgba>
			font=small
			text=<win_record_string>
			; text="000,000,000"
			;scale=.7
			pos=(420, 0)
			just=[center top]
		}

		// add a tag so we know the win record is there
		<goal_id>:SetTags win_record
	endif*/

	CreateScreenElement {
		type=TextElement
		parent=<goal_id>
		rgba=<text_rgba>
		text=" "
		font=dialog
		;scale=.75
		pos=(0, 0)
		just=[left top]
	}

	// if the goal is beaten
	if GoalManager_HasWonGoal name=<goal_id>
		;view_goals_menu_set_color id=<goal_id> rgba=[25 83 67 128]

		// let them start a beaten goal
		SetScreenElementProps {
			id=<goal_id>
			event_handlers=[
				{ focus				view_goals_menu_focus_beaten }
				{ unfocus		 	view_goals_menu_unfocus_beaten }
				{ pad_choose		view_goals_menu_start_beaten_goal params={ goal_id=<goal_id> } }
				{ pad_start 		view_goals_menu_start_beaten_goal params={ goal_id=<goal_id> } }
				{ pad_choose		generic_menu_pad_choose_sound }
			]
		}

		// add the line
		GetScreenElementDims id={ <goal_id> child=0 }
		CreateScreenElement {
			type=SpriteElement
			parent={ <goal_id> child=1 }
			texture=white2

			pos=(2, 16)
			just=[left center]
			rgba=<highlighted_text_rgba>
			alpha=1
			z_priority=10
			scale=(15.5,0.15);( ( (1, 0) * ( <width> * 1.38 ) / 32 ) + (.3, .4) )

		}
	else
		// if the goal is unbeaten and locked
		if GoalManager_GoalIsLocked name=<goal_id>
			if IsTrue bootstrap_build
				<locked_text> = "NOT IN DEMO"
			else
				GoalManager_GetGoalParams name=<goal_id>
				if GotParam pro_goal
					; DestroyScreenElement id=<goal_id>
					; return
					<locked_text> = "Complete Pro Challenge to unlock"
				else
					<locked_text> = "Locked"
				endif
			endif

			view_goals_menu_set_color {
				id=<goal_id>
				rgba=<text_rgba>
				text=<locked_text>
			}

			SetScreenElementProps {
				id=<goal_id>
				event_handlers=[
					{ focus				view_goals_menu_focus_locked }
					{ unfocus			view_goals_menu_unfocus_locked }
					{ pad_choose		view_goals_menu_pad_choose_locked }
					{ pad_start 		view_goals_menu_pad_choose_locked }
				]
				replace_handlers
			}
		else   // the goal is unbeaten and unlocked
			if GoalManager_HasSeenGoal name=<goal_id>
				// they have seen this goal
				view_goals_menu_set_color {
					id=<goal_id>
					rgba=<text_rgba>
				}

				SetScreenElementProps {
					id=<goal_id>
					event_handlers=[
						{ focus				view_goals_menu_focus_unlocked params={ goal_id=<goal_id> } }
						{ unfocus		 	view_goals_menu_unfocus_unlocked params={ goal_id=<goal_id> } }
						{ pad_choose		view_goals_menu_start_goal params={ goal_id=<goal_id> } }
						{ pad_start 		view_goals_menu_start_goal params={ goal_id=<goal_id> } }
					]
					replace_handlers
				}
			else
				// they haven't seen this goal
				view_goals_menu_set_color {
					id=<goal_id>
					rgba=[42 42 38 128]
					text="??????????"
				}

				SetScreenElementProps {
					id=<goal_id>
					event_handlers=[
						{ focus				view_goals_menu_focus_locked params={ goal_id=<goal_id> } }
						{ unfocus			view_goals_menu_unfocus_locked params={ goal_id=<goal_id> } }
						{ pad_choose		view_goals_menu_pad_choose_locked }
						{ pad_start 		view_goals_menu_pad_choose_locked }
					]
					replace_handlers
				}
			endif
		endif
	endif
endscript

script view_goals_menu_set_color
	// set the main text
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<rgba>
		text=<text>
	}
	/*	if GotParam scale
		DoScreenElementMorph {
			id={ <id> child=0 }
			scale=<scale>
		}
	endif
*/
	// set the record if we have one
	<id>:GetTags
	if GotParam win_record
		SetScreenElementProps {
			id={ <id> child=1 }
			rgba=<rgba>
			scale=<scale>
		}
		/*		if GotParam scale
			DoScreenElementMorph {
				id={ <id> child=1 }
				scale=<scale>
			}
		endif
*/
	endif
endscript

script view_goals_menu_focus_locked
	generic_menu_update_arrows {
		menu_id=view_goals_vmenu
		up_arrow_id=view_goals_menu_up_arrow
		down_arrow_id=view_goals_menu_down_arrow
	}

	GetTags
	;view_goals_menu_set_color id=<id> rgba=[67 62 58 128] ; scale=.85
	;RunScriptOnScreenElement id={ <id> child=0 } do_random_effect
	main_theme_focus
	if GotParam goal_id
		view_goals_menu_play_preview_cam <...>
	endif
endscript

script view_goals_menu_unfocus_locked
	GetTags
	generic_menu_pad_up_down_sound

	;KillSpawnedScript name=do_random_effect
	;view_goals_menu_set_color id=<id> rgba=[47 42 38 128] ; scale=.75
	main_theme_unfocus
	if GotParam goal_id
		view_goals_menu_kill_preview_cam <...>
	endif
endscript

script view_goals_menu_focus_unlocked
	generic_menu_update_arrows {
		menu_id=view_goals_vmenu
		up_arrow_id=view_goals_menu_up_arrow
		down_arrow_id=view_goals_menu_down_arrow
	}

	GetTags
	;view_goals_menu_set_color id=<id> rgba=[127 102 0 128] ; scale=.85
	;RunScriptOnScreenElement id={ <id> child=0 } do_random_effect
	FormatText ChecksumName=highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// text
	DoScreenElementMorph {
		id={ <id> child=0 }
		rgba=<highlighted_text_rgba>
		scale=1.1
		relative_scale
	}
	// extra text
	if ScreenElementExists id={ <id> child=2 }
		DoScreenElementMorph {
			id={ <id> child=2 }
			rgba=<highlighted_text_rgba>
			scale=1.1
			relative_scale
		}
	endif
	// highlight bar
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=<bar_rgba>
	}

	if ScreenElementExists id=scrolling_menu_up_arrow
		if GotParam first_item
			DoScreenElementMorph id=scrolling_menu_up_arrow alpha = 0
		else
			DoScreenElementMorph id=scrolling_menu_up_arrow alpha = 1
		endif
	endif

	if ScreenElementExists id=scrolling_menu_down_arrow
		if GotParam last_item
			DoScreenElementMorph id=scrolling_menu_down_arrow alpha = 0
		else
			DoScreenElementMorph id=scrolling_menu_down_arrow alpha = 1
		endif
	endif

	RunScriptOnScreenElement id=<id> text_twitch_effect
	view_goals_menu_play_preview_cam <...>
endscript

script view_goals_menu_unfocus_unlocked
	GetTags
	generic_menu_pad_up_down_sound

	;KillSpawnedScript name=do_random_effect
	;view_goals_menu_set_color id=<id> rgba=[88 105 112 128] ; scale=.75
	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	KillSpawnedScript name=text_twitch_effect

	// text
	DoScreenElementMorph {
		id={ <id> child=0 }
		rgba=<text_rgba>
		alpha=<text_alpha>
		scale=1
	}

	// extra text
	if ScreenElementExists id={ <id> child=2 }
		DoScreenElementMorph {
			id={ <id> child=2 }
			rgba=<text_rgba>
			alpha=<text_alpha>
			scale=1
		}
	endif

	// highlight bar
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=[128 128 128 0]
	}
	view_goals_menu_kill_preview_cam <...>
endscript

script view_goals_menu_focus_beaten
	generic_menu_update_arrows {
		menu_id=view_goals_vmenu
		up_arrow_id=view_goals_menu_up_arrow
		down_arrow_id=view_goals_menu_down_arrow
	}

	GetTags
	;view_goals_menu_set_color id=<id> rgba=[99 121 6 128] ; scale=.85
	;RunScriptOnScreenElement id={ <id> child=0 } do_random_effect
	FormatText ChecksumName=highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// text
	DoScreenElementMorph {
		id={ <id> child=0 }
		rgba=<highlighted_text_rgba>
		scale=1.1
		relative_scale
	}
	// extra text
	if ScreenElementExists id={ <id> child=2 }
		DoScreenElementMorph {
			id={ <id> child=2 }
			rgba=<highlighted_text_rgba>
			scale=1.1
			relative_scale
		}
	endif
	// highlight bar
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=<bar_rgba>
	}

	if ScreenElementExists id=scrolling_menu_up_arrow
		if GotParam first_item
			DoScreenElementMorph id=scrolling_menu_up_arrow alpha = 0
		else
			DoScreenElementMorph id=scrolling_menu_up_arrow alpha = 1
		endif
	endif

	if ScreenElementExists id=scrolling_menu_down_arrow
		if GotParam last_item
			DoScreenElementMorph id=scrolling_menu_down_arrow alpha = 0
		else
			DoScreenElementMorph id=scrolling_menu_down_arrow alpha = 1
		endif
	endif

	RunScriptOnScreenElement id=<id> text_twitch_effect
endscript

script view_goals_menu_unfocus_beaten
	GetTags
	generic_menu_pad_up_down_sound
	;KillSpawnedScript name=do_random_effect
	;view_goals_menu_set_color id=<id> rgba=[25 83 67 128] ; scale=.75
	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	KillSpawnedScript name=text_twitch_effect

	// text
	DoScreenElementMorph {
		id={ <id> child=0 }
		rgba=<text_rgba>
		alpha=<text_alpha>
		scale=1
	}

	// extra text
	if ScreenElementExists id={ <id> child=2 }
		DoScreenElementMorph {
			id={ <id> child=2 }
			rgba=<text_rgba>
			alpha=<text_alpha>
			scale=1
		}
	endif

	// highlight bar
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=[128 128 128 0]
	}
endscript

script view_goals_menu_pad_choose_locked
	; printf "it's locked dumbass"
	// maybe play a sound or something?
endscript

script view_goals_menu_start_goal
	view_goals_menu_exit callback=exit_pause_menu
	GoalManager_DeactivateAllGoals
	goal_accept_trigger goal_id=<goal_id> force_start
	;	GoalManager_ActivateGoal name=<goal_id>
endscript

// called when the player selects a beaten
// goal from the view goals menu
script view_goals_menu_start_beaten_goal
	view_goals_menu_exit callback=exit_pause_menu
	GoalManager_DeactivateAllGoals
	; GoalManager_InitializeGoal name=<goal_id>
	goal_accept_trigger goal_id=<goal_id> force_start
endscript

script view_goals_menu_play_preview_cam
	;KillSkaterCamAnim current
	GoalManager_GetGoalParams name=<goal_id>

	if IsAlive name=<trigger_obj_id>

		if not ObjectExists id=Menu_Cam
			create_menu_camera
		else
			menu_cam:unpause
		endif

		<trigger_obj_id>:Obj_GetPosition
		Menu_Cam:Obj_SetPosition Position=( <pos> + (0,40,110) )
		Menu_Cam:Obj_SetOrientation Y=0

		<trigger_obj_id>:Obj_GetOrientation


		<trigger_obj_id>:Obj_SetOrientation Y=0


		SetActiveCamera id=Menu_Cam

		/*<trigger_obj_id>:Obj_GetID
		<targetId> = <objId>
		GetSkaterId
		PlaySkaterCamAnim { name=<goal_id>
							skater=<objId>
							targetID=<targetId>
							targetOffset=(0, 45, 0)
							positionOffset=(10, 10, 90)
							frames=120
							skippable=0
							virtual_cam
							play_hold
						  }*/


		SetSkaterCamAnimShouldPause name=<goal_id> should_pause=0

		// Rulon: Some peds were getting screwed up due to LOD.  Unpausing them lets the cycle through the idle anim
		// once and look more acceptable.

		<trigger_obj_id>:unpause
		wait 5 frames
		<trigger_obj_id>:pause

	endif

	// set a tag
	view_goals_vmenu:SetTags current_cam_anim=<goal_id>
endscript

script view_goals_menu_kill_preview_cam
	GetSkaterId
	KillSkaterCamAnim skater=<objId> name=<goal_id>
endscript

script view_goals_menu_exit
	if ScreenElementExists id=view_goals_vmenu
		view_goals_vmenu:GetTags
		if GotParam current_cam_anim
			GetSkaterId
			KillSkaterCamAnim skater=<objId> name=<current_cam_anim>
		endif
	endif

	; KillSkaterCamAnim all
	restore_skater_camera

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 gameframe
	endif
	GoalManager_ShowPoints
	if not GoalManager_HasActiveGoals
		GoalManager_ShowGoalPoints
	endif
	<callback>
endscript

// ****************************************************************
//
//			Edit Stats menu
//
// ****************************************************************

// @script | create_stats_menu | destroys any current menu and creates the
// edit stats menu
script create_stats_menu
	hide_current_goal
	helper_text = { helper_text_elements=[ 	{ text="\b7/\b4/\b6/\b5 = Select" }
			{ text="\m1 = Back" }
		]
	}


	FormatText ChecksumName=title_icon "%i_stats" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu {
		title="STATS"
		title_icon=<title_icon>
		pos=(60,97)
		skateshop_pos=(60,97)
		dims=(640,480)
		helper_text=<helper_text>
		no_menu_title=no_menu_title
	}

	FormatText ChecksumName=off_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=on_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// create second vmenu
	CreateScreenElement {
		type=VMenu
		parent=sub_menu
		id=sub_vmenu2

		font=small
		just=[left top]
		pos=(310,109)
		padding_scale=1.15
		internal_scale=1
		internal_just=[left top]
		event_handlers=[ 	{ pad_up 		generic_menu_up_or_down_sound params={ up } }
			{ pad_down		generic_menu_up_or_down_sound params={ down } }
			{ pad_back		generic_menu_pad_back params={ callback=stats_menu_exit }}
		]
	}


	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back    generic_menu_pad_back params={ callback= stats_menu_exit } }]
		replace_handlers
	}

	GetArraySize stat_names
	<index> = 0
	begin
		RemoveParameter pad_right_script
		RemoveParameter pad_left_script
		if ( <index> > ( (<array_size>/2) - 1 ) )
			parent=sub_vmenu2
			pad_left_script=focus_stats_vmenu
			child=( <index> - (<array_size>/2) )
		else
			parent=sub_vmenu
			pad_right_script=focus_stats_vmenu2
			child=<index>
		endif

		; printf "index = %i child = %c" i=<index> c=<child>

		stats_menu_add_item {	( stat_names[<index>] )
			index=<index>
			stats_parent=<parent>
			pad_right_script=<pad_right_script>
			pad_left_script=<pad_left_script>
			pad_right_params={ grid_index=( <child> ) }
			pad_left_params={ grid_index=( <child> ) }
		}

		SetScreenElementProps {
			id={ <parent> child=<child> }
			tags={ tag_grid_x=<child> }
		}
		<index> = ( <index> + 1 )
	repeat <array_size>


	// stat title
	FormatText textname=stat_title "%i:" i=( (stat_names[0]).string )
	CreateScreenElement {
		type=TextElement
		parent=sub_menu
		id=stat_title

		pos=(240,215)
		font=small
		just=[right top]
		scale=1.5
		text=<stat_title>
		rgba=<on_color>

		z_priority=4
	}

	// stat count
	CreateScreenElement {
		type=TextElement
		parent=sub_menu
		id=stat_count

		pos=(270,215)
		font=small
		just=[right top]
		scale=1.5
		text=""
		rgba=<on_color>

		z_priority=4
	}
	CreateScreenElement {
		type=TextElement
		parent=sub_menu

		pos=(270,215)
		font=small
		just=[left top]
		scale=1.5
		text="/10"
		rgba=<on_color>

		z_priority=4
	}

	// stat description
	CreateScreenElement {
		type=TextBlockElement
		parent=sub_menu
		id=stat_point_description

		dims=(280, 0)
		pos=(330,215)
		font=small
		just=[left top]
		scale=0.9
		text=( (stat_names[0]).description )
		line_spacing=0.7
		internal_just=[left top]
		rgba=<off_color>

		allow_expansion
		z_priority=4
	}

	// stat goals
	build_stat_goals_menu

	theme_background width=6.4 pos=(320,85) num_parts=10.5 parent=sub_menu

	// red line
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu

		texture=white2
		pos=(320,250)
		just=[center top]
		scale=(63.5,0.25)
		rgba=<on_color>
		alpha=.7
	}
	// second red line
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu

		texture=white2
		pos=(322,212)
		just=[center top]
		scale=(63.5,0.25)
		rgba=<on_color>
		alpha=.7
	}

	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu

		texture=black
		pos=(322,214)
		just=[center top]
		scale=(.55,9.5)
		rgba=<on_color>
		alpha=.7
	}

	// black box
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu

		texture=black
		pos=(320,214)
		just=[center top]
		scale=(132,44)
		rgba=[0 0 0 88]
		alpha=0.7
	}
	// black bar
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu

		texture=black
		pos=(320,212)
		just=[center top]
		scale=(128,9)
		rgba=[0 0 0 118]
		alpha=0.7
	}

	if not LevelIs load_skateshop

		finish_themed_sub_menu pos=(320,720)

		DoScreenElementMorph id=sub_menu time=0.0 pos=(320,720)
		DoScreenElementMorph id=sub_menu time=0.5 pos=(320,240)
	else
		skater:remove_skater_from_world
		PlaySound DE_MenuFlyUp vol=100
		DoScreenElementMorph id=sub_menu time=0.0 pos=(320,720)
		DoScreenElementMorph id=sub_menu time=0.5 pos=(320,218)

		FireEvent type=focus target=sub_menu
	endif
endscript

script update_stats_menu_count
	GetArraySize stats_goals

	index=0
	count=3		// starts at 3
	begin
		if ( ((stats_goals[<index>]).stattype) = <name>  )
			Skater:StatsManager_GetGoalStatus <index>
			if ( <status> = 1  )
				count=( <count> + 1 )
			endif
		endif
		index=( <index> + 1 )
	repeat <array_size>

	FormatText textname=text "%i" i=<count>
	SetScreenElementProps id=stat_count text=<text>
endscript

script build_stat_goals_menu stat_type=air
	FormatText ChecksumName=on_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	if ScreenElementExists id=stat_goal_menu
		DestroyScreenElement id=stat_goal_menu
	endif

	CreateScreenElement {
		type=VMenu
		parent=sub_menu
		id=stat_goal_menu

		font=dialog
		just=[center top]
		pos=(320,265)
		padding_scale=0.75
		internal_scale=1
		internal_just=[center top]
	}

	GetArraySize stats_goals
	index=0

	begin
		Skater:StatsManager_GetGoalStatus <index>

		if ( ( (stats_goals[<index>]).stattype ) = <stat_type> )
			switch <status>
				case 2
					text="Turn Am to Unlock"
					alpha=0.5
				case 3
					text="Turn Pro to Unlock"
					alpha=0.5
				default
					// have to piece together stat goal description because it changes with difficutly levels
					GoalManager_GetDifficultyLevel
					string=( (stats_goals[<index>]).text )
					value=( (stats_goals[<index>]).value[<difficulty_level>] )
					if StructureContains structure=(stats_goals[<index>]) value_string
						vstring=( (stats_goals[<index>]).value_string[<difficulty_level>] )
					endif

					if not StructureContains structure=(stats_goals[<index>]) no_commas
						FormatText textname=text <string> i=<value> s=<vstring> UseCommas
					else
						FormatText textname=text <string> i=<value> s=<vstring>
					endif
					alpha=1.0
			endswitch

			if ( <status> = 1 )
				rgba=[30 30 30 80]
			else
				rgba=<on_rgba>
			endif

			CreateScreenElement {
				type=ContainerElement
				parent=stat_goal_menu

				just=[center top]
				internal_just=[center center]
				dims=(0,20)
			}
			anchor_id=<id>

			CreateScreenElement {
				type=TextElement
				parent=<anchor_id>

				font=dialog
				just=[center top]
				scale=0.8
				text=<text>
				rgba=<rgba>
				z_priority=4
				alpha=<alpha>
			}

			GetScreenElementDims id=<id>

			;scale=( ((<width>/4)+20)*(1,0) + (0,0.5) )
			scale=(127,0.5)

			if ( <status> = 1 )
				CreateScreenElement {
					type=SpriteElement
					parent=<anchor_id>

					texture=black
					just=[center center]
					scale=<scale>
					pos=(0,10)
					rgba=<rgba>
					z_priority=5
					alpha=<alpha>
				}
			endif
		endif

		index = ( <index> + 1 )
	repeat <array_size>
endscript

script focus_stats_vmenu
	PlaySound MenuUp vol=100
	FireEvent type=unfocus target=sub_vmenu2
	FireEvent type=focus target=sub_vmenu data={ grid_index=<grid_index> }
endscript

script focus_stats_vmenu2
	PlaySound MenuUp vol=100
	FireEvent type=unfocus target=sub_vmenu
	FireEvent type=focus target=sub_vmenu2 data={ grid_index=<grid_index> }
endscript

script stats_menu_create_stats_block parent=current_menu scale=1 pos=(180, 147)

	// anchor for the stats block
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=stats_block_anchor

		pos=<pos>
		just=[left top]
		dims=(640, 480)
		scale=<scale>
	}
	<stats_parent> = <id>

	if GotParam on
		on=on
	endif

	GetArraySize stat_names
	<index> = 0
	begin
		stats_menu_add_item ( stat_names[<index>] ) <...> on=<on>
		<index> = ( <index> + 1 )
	repeat <array_size>

	<pos> = ( (0, 1) * ( 23 * ( <index> + 1 ) ) )
	<pos> = ( <pos> + (150, -12) )

	//bottom piece
	CreateScreenElement {
		type=ContainerElement
		parent=stats_block_anchor
		id=stats_bottom_anchor

		dims=(200, 20)
		pos=<pos>
		z_priority=10
	}

endscript


// @script | stats_menu_add_item | adds a stat to the list, complete with another row
// on the grid
script stats_menu_add_item z_priority=2	highlight_bar_scale=(3.1,0.7) highlight_bar_pos=(90, -7) pad_right_script=null_script pad_left_script=null_script
	FormatText ChecksumName=row_id "stats_menu_names_%n" n=<index>

	// figure the position for skater select!!!
	<pos> = ( (0, 1) * ( 23 * ( <index> + 1 ) ) )
	<pos> = ( <pos> + (150, -12) )


	// container for everything
	CreateScreenElement {
		type=ContainerElement
		parent=<stats_parent>
		id=<row_id>

		dims=(200, 20)
		pos=<pos>
		just=[center center]
		event_handlers=[
			{ focus			stats_menu_focus params={ name=<name> row_id=<row_id> string=<string> description=<description> } }
			{ unfocus		stats_menu_unfocus params={ name=<name> row_id=<row_id> } }
			{ pad_right		<pad_right_script> params=<pad_right_params> }
			{ pad_left		<pad_left_script> params=<pad_left_params> }
			;{ pad_choose 	stats_menu_fire_pad_down params={ target=<stats_parent> } }
			;{ pad_start 	stats_menu_fire_pad_down params={ target=<stats_parent> } }
			;{ pad_choose	generic_menu_pad_choose_sound }
			;{ pad_start		generic_menu_pad_choose_sound }
		]
	}
	<anchor_id> = <id>

	// The not_focusable flag is used to create a stat block for display
	// only (eg, for the skater select menu)
	if GotParam not_focusable
		SetScreenElementProps {
			id=<anchor_id>
			not_focusable
		}
	endif

	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// this is the name of the stat
	if GotParam short_string
		<string> = <short_string>
	endif

	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>

		rgba=<text_rgba>
		font=small
		text=<string>
		z_priority=<z_priority>
		just=[right center]
		pos=(95, -5)
	}

	if GotParam on
		FormatText ChecksumName=highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	else
		highlight_rgba=[50 50 50 128]
	endif

	build_stat_slider parent=<row_id> pos=(95,-5) on=<on>

	stats_menu_update_row <...> highlight_rgba=<highlight_rgba> bar_bg_rgba=[100 100 100 128]
endscript

script build_stat_slider

	root_pos=<pos>
	CreateScreenElement {
		type=SpriteElement
		parent=<parent>
		texture=framebody

		rgba=[128 128 128 100]
		scale=(3,1)
		pos=<root_pos>
		just=[left center]
		z_priority=1
	}
	body_id=<id>

	GetStackedScreenElementPos id=<body_id> X
	CreateScreenElement {
		type=SpriteElement
		parent=<parent>
		texture=framecap

		rgba=[128 128 128 100]
		scale=(1,1)
		pos=<pos>
		just=[left top]
		z_priority=1
	}

	CreateScreenElement {
		type=SpriteElement
		parent=<parent>
		texture=statbody

		rgba=[128 128 128 100]
		scale=(1,1)
		pos=( <root_pos> + (0,0) )
		just=[left center]
		z_priority=2
	}

	GetStackedScreenElementPos id=<body_id> X offset=(15,4)
	CreateScreenElement {
		type=SpriteElement
		parent=<parent>
		texture=statcap

		rgba=[128 128 128 100]
		scale=(1,1)
		pos=<pos>
		just=[left top]
		z_priority=2
	}
endscript

script stats_menu_fire_pad_down
	FireEvent type=pad_down target=<target>
endscript

stats_color_1 = [40 0 0 80]
stats_color_2 = [128 0 0 80]

script stats_menu_update_row highlight_rgba=[100 100 100 80] locked_highlight_rgba=[50 50 50 80] slider_rgba=[128 128 128 0]
	// get the value for this row
	if IsTrue gary_debug
		if GotParam skater_name
			script_assert "Get rid of skater name"
		endif
	endif

	// get current skater's stat
	GetStatValue <name>

	;printf "%s = %i" s=<name> i=<stat_value>

	// update applied stats section
	if ( <stat_value> > 0 )
		if ( <stat_value> > 9 )
			scale_value = 9
		else
			scale_value = <stat_value>
		endif
		scale=( <scale_value> * (0.385,0.0) + (0,1) )


		DoScreenElementMorph {
			id={ <row_id> child=1 }
			rgba=<bar_bg_rgba>
		}

		DoScreenElementMorph {
			id={ <row_id> child=2 }
			rgba=<bar_bg_rgba>
		}

		DoScreenElementMorph {
			id={ <row_id> child=3 }
			rgba=<highlight_rgba>
			scale=<scale>
		}

		GetStackedScreenElementPos X id={ <row_id> child=3 }
		if ( <stat_value> > 9 )
			// end cap
			DoScreenElementMorph {
				id={ <row_id> child=4 }
				rgba=<highlight_rgba>
				alpha=1.0
			}
		else
			// end cap
			DoScreenElementMorph {
				id={ <row_id> child=4 }
				alpha=0
			}
		endif
	endif

endscript

script stats_menu_get_original_stat_value
	<stat_name> = <name>
	if GotParam skater_name
		GetSkaterProfileInfoByName name=<skater_name>
	else
		GetCurrentSkaterProfileIndex
		GetSkaterProfileInfo player=<currentSkaterProfileIndex>
	endif

	// special case for custom skater...they can do whatever they want!
	if ( <name> = custom )
		return original_stat_value = 0
	endif

	// look for this name in the master skater list
	GetArraySize master_skater_list
	<index> = 0
	begin
		if ( ( (master_skater_list[<index>]).name ) = <name> )
			<original_stat_value> = ( (master_skater_list[<index>]).<stat_name> )
			break
		endif

		<index> = ( <index> + 1 )
	repeat <array_size>

	if not GotParam	original_stat_value
		script_assert "couldn't find the stat!"
	endif

	return original_stat_value=<original_stat_value>
endscript


script stats_menu_change_stat
	; printf "Change %n by %i" n=<name> i=<change>
	GetCurrentSkaterProfileIndex
	GetNumStatPointsAvailable player=<currentSkaterProfileIndex>

	GetStatValue <name>
	// make sure they aren't going over the max or under the min
	if ( <change> < 0 )
		if ( <stat_value> < 1 )
			return
		endif
	endif
	if ( <change> > 0 )
		if ( <stat_value> > 9 )
			return
		endif
	endif

	// make sure they have enough points
	if ( <points_available> < <change> )
		return
	endif

	// make sure they aren't trying to go below the original value
	stats_menu_get_original_stat_value name=<name>
	if ( ( <stat_value> + <change> ) < <original_stat_value> )
		return
	endif

	// play sound
	PlaySound menu03 vol=100

	AwardStatPoint ( <change> * -1 )
	GetNumStatPointsAvailable player=<currentSkaterProfileIndex>

	// update the number of points
	FormatText TextName=points_text "%i" i=<points_available>
	SetScreenElementProps {
		id=stat_points_available
		text=<points_text>
	}

	// change the profile property
	<stat_value> = ( <stat_value> + <change> )
	SetSkaterProfileProperty player=<currentSkaterProfileIndex> <name> <stat_value>
	if LevelIs load_skateshop
		UpdateSkaterStats player=0
	else
		UpdateSkaterStats player=<currentSkaterProfileIndex>
	endif

	FormatText ChecksumName=highlight_rgba "%i_STAT_ON" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=locked_highlight_rgba "%i_DEF_STAT_ON" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	stats_menu_update_row name=<name> row_id=<row_id> slider_rgba=[128 128 128 100] highlight_rgba=<highlight_rgba> locked_highlight_rgba=<locked_highlight_rgba>

	// update the other skater's stats
	if GotParam update_all_skaters
		<stat_name> = <name>
		GetSkaterProfileInfo player=<currentSkaterProfileIndex>
		ForEachSkaterProfile {
			do=stats_menu_change_other_skater_stats
			params={ change=<change>
				current_skater_name=<name>
				stat_name=<stat_name>
			}
		}
	endif
endscript

script stats_menu_focus
	FormatText ChecksumName=highlight_rgba "%i_STAT_ON" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	stats_menu_update_row {
		name=<name>
		row_id=<row_id>
		highlight_rgba=<highlight_rgba>
		;bar_bg_rgba=[100 100 100 128]
		bar_bg_rgba=<highlight_rgba>
	}

	stats_menu_done_focus <...>

endscript

script stats_menu_unfocus
	stats_menu_update_row name=<name> row_id=<row_id> highlight_rgba=[50 50 50 100] bar_bg_rgba=[100 100 100 128]

	stats_menu_done_unfocus <...>
endscript

script stats_menu_done_focus description=""
	GetTags

	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<text_rgba>
	}

	RunScriptOnScreenElement id=<id> text_twitch_effect params={ no_extra }

	if ObjectExists id=stat_title
		FormatText textname=stat_title "%i:" i=<string>
		SetScreenElementProps {
			id=stat_title
			text=<stat_title>
		}
	endif

	update_stats_menu_count name=<name>

	if ObjectExists id=stat_point_description
		SetScreenElementProps {
			id=stat_point_description
			text=<description>
		}
	endif

	build_stat_goals_menu stat_type=<name>

endscript

script stats_menu_done_unfocus
	GetTags

	KillSpawnedScript name=text_twitch_effect

	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<text_rgba>
	}


endscript

script stats_menu_change_other_skater_stats
	// don't update the current skater!
	if ( <current_skater_name> = <name> )
		return
	endif

	// don't take away stat points
	if ( <change> < 0 )
		return
	endif

	// make sure they have enough points
	if ( <change> > <points_available> )
		return
	endif

	// don't go over 10
	GetStatValue skater=<name> <stat_name>
	if ( <stat_value> = 10 )

		// find the first non-maxed stat
		GetArraySize stat_names
		<index> = 0
		begin
			<stat_name> = ( (stat_names[<index>]).name )
			GetStatValue skater=<name> <stat_name>
			if ( <stat_value> < 10 )
				break
			endif

			<index> = ( <index> + 1 )

			if ( <index> = <array_size> )
				// couldn't find one
				return
			endif

		repeat <array_size>
	endif

	// ok update the stat and the points available
	switch <stat_name>
		case air
			SetSkaterProfileInfoByName name=<name> params={ Air=( <stat_value> + <change> ) }
		case run
			SetSkaterProfileInfoByName name=<name> params={ run=( <stat_value> + <change> ) }
		case ollie
			SetSkaterProfileInfoByName name=<name> params={ ollie=( <stat_value> + <change> ) }
		case speed
			SetSkaterProfileInfoByName name=<name> params={ speed=( <stat_value> + <change> ) }
		case spin
			SetSkaterProfileInfoByName name=<name> params={ spin=( <stat_value> + <change> ) }
		case switch
			SetSkaterProfileInfoByName name=<name> params={ switch=( <stat_value> + <change> ) }
		case flip_speed
			SetSkaterProfileInfoByName name=<name> params={ flip_speed=( <stat_value> + <change> ) }
		case rail_balance
			SetSkaterProfileInfoByName name=<name> params={ rail_balance=( <stat_value> + <change> ) }
		case lip_balance
			SetSkaterProfileInfoByName name=<name> params={ lip_balance=( <stat_value> + <change> ) }
		case manual_balance
			SetSkaterProfileInfoByName name=<name> params={ manual_balance=( <stat_value> + <change> ) }
		default
			script_assert "bad stat name"
	endswitch

	; printf "points_available = %i" i=<points_available>
	; printf "change = %i" i=<change>
	<points_available> = ( <points_available> - <change> )
	; printf "points_available = %i" i=<points_available>

	if not SetSkaterProfileInfoByName name=<name> params={ points_available = <points_available> }
		printf "############### couldn't change points available!"
	endif
endscript

script stats_menu_exit
	if LevelIs load_skateshop
		skater:add_skater_to_world
		launch_ss_menu
	else
		create_pause_menu
	endif
endscript


// ****************************************************************
// Gamemode menu
// ****************************************************************
// @script | launch_gamemode_menu | Call to exit current menu and launch the
// gamemode selection menu
script launch_gamemode_menu
	RunScriptOnScreenElement id=current_menu_anchor animate_out callback=create_gamemode_menu
endscript

script create_gamemode_menu
	make_new_menu menu_id=gamemode_menu vmenu_id=gamemode_vmenu menu_title="GAMEMODE" helper_text=generic_helper_text

	SetScreenElementProps { id=gamemode_menu
		event_handlers=[
			{pad_back           create_options_menu}
		]
	}

	make_text_sub_menu_item text="Career Mode" id=gamemode_career_mode pad_choose_script=change_gamemode_career_menu
	make_text_sub_menu_item text="Single Session" id=gamemode_single_session pad_choose_script=change_gamemode_singlesession_menu
	make_text_sub_menu_item text="Free Skate" id=gamemode_free_skate pad_choose_script=change_gamemode_freeskate_menu
	make_text_sub_menu_item text="Quickstart 2P" id=gamemode_quickstart_2p
	make_text_sub_menu_item text="Quickstart Server" id=gamemode_quickstart_server
	make_text_sub_menu_item text="back" id=gamemode_back pad_choose_script=create_options_menu

	RunScriptOnScreenElement id=current_menu_anchor animate_in
endscript

script change_gamemode_career
	printf "********** CHANGING GAME MODE TO CAREER"
	SetGameType career
	SetCurrentGameType
endscript

script change_gamemode_net
	printf "********** CHANGING GAME MODE TO NET!!!"
	SetGameType net
	SetCurrentGameType
endscript

script change_gamemode_singlesession
	SetGameType singlesession
	SetCurrentGameType
endscript

script change_gamemode_freeskate_2p
	SetGameType freeskate2p
	SetCurrentGameType
endscript

script change_gamemode_freeskate
	SetGameType freeskate
	SetCurrentGameType
endscript

script change_gamemode_creategoals
	SetGameType creategoals
	SetCurrentGameType
endscript

script change_gamemode_career_menu
	exit_pause_menu
	SetGameType career
	SetCurrentGameType
	Retry
endscript

script change_gamemode_singlesession_menu
	;exit_pause_menu
	;kill_net_panel_messages
	kill_all_panel_messages
	SetGameType singlesession
	SetCurrentGameType
	GoalManager_DeactivateAllGoals
	// K: This is a flag that gets set at the end of the run in single-session that
	// causes the replays to quit to the paused menu when they end,
	// if they got started during the end-of-run.
	// Need to reset it to zero here because the session is just starting.
	Change EndOfReplayShouldJumpToPauseMenu=0
	Retry
endscript

script change_gamemode_freeskate_menu
	exit_pause_menu
	SetGameType freeskate
	SetCurrentGameType
	Retry
endscript


script menu_start_autotest
	SetTesterScript test_advance		// TestLevels
	Exit_Pause_Menu
endscript

script menu_stop_autotest
	KillTesterScript
	Exit_Pause_Menu
endscript

script fake_button
	FireEvent type=<type> source=system target=system data={controller=0 device_num=0}
endscript

// Mick:  Really simple: just press X a bunch of times, then "advance stage"
// need to be careful, so we don't advance stage while a promt is on screen
// as that tends to mess
script test_advance
	begin
		// Skip any multi-part cutscene
		<loops>=5
		begin
			wait 10 gameframes		// always use gameframes so actually processing time has elapse, ignoreing load time
			if IsMovieQueued
				printf "AUTOTEST: In Cutscene/Movie/Camanim"
				printf "AUTOTEST: Fake X"
				fake_button type=pad_x
				//				fake_button type=pad_down
				<loops> = 5
			else
				if not ScreenElementExists id=current_menu_anchor
					printf "AUTOTEST: Menu Gone"
					printf "AUTOTEST: Fake X and start"
					fake_button type=pad_x
					//					fake_button type=pad_start
					fake_button type=pad_down
					<loops> = (<loops>-1)
				else
					printf "AUTOTEST: Fake Start"
					fake_button type=pad_start
					fake_button type=pad_down
					<loops> = 5		// reset loops if there was a menu on screen
				endif
			endif
			if (<loops> = 0)
				break
			endif
		repeat

		printf "AUTOTEST: Advancing in 3 seconds"
		wait 150 gameframes		// wait long enough for stuff to leave the screen, using gameframes to get actual live time
		printf "AUTOTEST: Advance"
		cheats_menu_advance_stage
	repeat
endscript


script launch_menu_test
	RunScriptOnScreenElement id=current_menu_anchor animate_out callback=create_menu_test_menu
endscript

// @script | menu_select | calls the specified script, destroys the menu, etc
script menu_select menu_select_script=item_chosen
	;PlaySound MenuSelect vol=100
	if GotParam stop_streams
		StopStream
	endif
	if GotParam stop_vibration
		;Skater:Vibrate Off
	endif
	exit_pause_menu
	<menu_select_script>
endscript


// @script | item_chosen | This is just for testing purposes!  Don't use if you want
// something to actually happen
script item_chosen menu_id=current_menu_anchor
	printf "item_chosen"
	RunScriptOnScreenElement id=<menu_id> animate_out callback=create_pause_menu
endscript




// *************************************************************
// @script | make_text_sub_menu_item | Make a sub-menu item.
// The triangle event for a sub-menu item will be defined
// by the parent - so sub-menu items only define an x event
// @parmopt name | focus_script | do_scale_up |
// @parmopt name | unfocus_script | do_scale_down |
// @parmopt name | pad_choose_script | exit_pause_menu |
// @parmopt name | pad_choose_params | | params to be passed to pad_choose_script
// @parmopt name | pad_circle_script | | script to run if circle is pressed
// @parmopt name | pad_circle_params | | params to be passed to pad_circle_script
// @parmopt name | font_face | small |
script make_text_sub_menu_item { focus_script=do_scale_up
		unfocus_script=do_scale_down
		pad_choose_script=nullscript
		font_face=small
		parent_menu_id=current_menu
		scale=1
		rgba=[88 105 112 128]
	}

	if GotParam not_focusable
		CreateScreenElement {
			type=textelement
			parent=<parent_menu_id>
			id=<id>

			text=<text>
			font=<font_face>
			rgba=<rgba>
			scale=<scale>
			event_handlers=[
				{focus              <focus_script> params=<focus_params>}
				{unfocus            <unfocus_script> params=<unfocus_params>}
				{pad_choose              <pad_choose_script> params=<pad_choose_params>}
				{pad_start              <pad_choose_script> params=<pad_choose_params>}
			]
			not_focusable
		}
	else
		if GotParam no_choose_sound
			CreateScreenElement {
				type=textelement
				parent=<parent_menu_id>
				id=<id>

				text=<text>
				font=<font_face>
				rgba=<rgba>
				scale=<scale>
				event_handlers=[
					{focus              <focus_script> params=<focus_params>}
					{unfocus            <unfocus_script> params=<unfocus_params>}
					{pad_choose         <pad_choose_script> params=<pad_choose_params>}
					{pad_start          <pad_choose_script> params=<pad_choose_params>}
				]
			}
		else
			CreateScreenElement {
				type=textelement
				parent=<parent_menu_id>
				id=<id>

				text=<text>
				font=<font_face>
				rgba=<rgba>
				scale=<scale>
				event_handlers=[
					{focus              <focus_script> params=<focus_params>}
					{unfocus            <unfocus_script> params=<unfocus_params>}
					{pad_choose			generic_menu_pad_choose_sound }
					{pad_start			generic_menu_pad_choose_sound }
					{pad_choose         <pad_choose_script> params=<pad_choose_params>}
					{pad_start          <pad_choose_script> params=<pad_choose_params>}
				]
			}
		endif
	endif
	if GotParam pad_circle_script
		SetScreenElementProps { id=<id>
			event_handlers=[
				{pad_circle	<pad_circle_script> params=<pad_circle_params>}
			]
		}
	endif
endscript


// *****************************************************
// @script | make_text_menu_item | A handy helper script for
// creating text menu elements, gets run from menu creation scripts
// @parmopt name | focus_script | do_scale_up | Script to run when user
// focuses on this menu item.
// @parmopt name | unfocus_script | do_scale_down | Script to run when user
// changes focus away from this item (scrolls up or down to a different item).
// @parmopt name | pad_choose_script | item_chosen | Script to run when user presses
// the X button while highlighted on this item.
// @parmopt name | pad_choose_params |  | parameters passed to the pad_choose_script
// @parmopt name | pad_back_script | exit_pause_menu | Script to run when
// user presses the triangle button while highlighted on this item
// @parmopt name | font_face | small | Font face to use for this menu item.
script make_text_menu_item { focus_script=do_scale_up
		unfocus_script=do_scale_down
		pad_choose_script=item_chosen
		pad_back_script=exit_pause_menu
		font_face=small }

	CreateScreenElement {
		type=textelement parent=current_menu
		id=<id>
		text=<text>
		font=<font_face>
		rgba=[128 128 128 75]
		event_handlers=[
			{focus  	        <focus_script>}
			{unfocus    		<unfocus_script>}
			{pad_choose              <pad_choose_script> params=<pad_choose_params>}
			{pad_back       <pad_back_script>}
		]
	}
endscript

// *****************************************************
// @script | make_sprite_menu_item | A handy helper script for
// creating sprite menu elements, gets run from menu creation scripts
// @parmopt name | focus_script | sprite_focus | Script to run when user
// focuses on this menu item.
// @parmopt name | unfocus_script | sprite_unfocus | Script to run when user
// changes focus away from this item (scrolls up or down to a different item).
// @parmopt name | pad_choose_script | item_chosen | Script to run when user presses
// the X button while highlighted on this item.
// @parmopt name | pad_choose_params |  | parameters passed to the pad_choose_script
// @parmopt name | pad_back_script | exit_pause_menu | Script to run when
// user presses the triangle button while highlighted on this item
// @parm name | texture | the sprite texture file
script make_sprite_menu_item
	make_theme_menu_item <...> dims=(300,20.7) focus_script=sprite_focus unfocus_script=sprite_unfocus
	// The dims value is to make the line spacing match the options menu
endscript


// *****************************************************
// @script | make_sprite_sub_menu_item | A handy helper script for
// creating sprite sub-menu elements, gets run from menu creation scripts.
// These elements don't have a pad_back event, so the triangle event
// can be defined/inherited by the parent (main_menu)
// @parmopt name | focus_script | sprite_focus | Script to run when user
// focuses on this menu item.
// @parmopt name | unfocus_script | sprite_unfocus | Script to run when user
// changes focus away from this item (scrolls up or down to a different item).
// @parmopt name | pad_choose_script | item_chosen | Script to run when user presses
// the X button while highlighted on this item.
// @parmopt name | pad_choose_params |  | parameters passed to the pad_choose_script
// @parm name | texture | the sprite texture file
script make_sprite_sub_menu_item { focus_script=sprite_focus
		text="Default sprite text"
		unfocus_script=sprite_unfocus
		pad_choose_script=item_chosen
	}

	CreateScreenElement {
		type=textelement parent=current_menu
		rgba=[92 92 92 70]
		id=<id>
		font=small
		text=<text>
		scale=1.0
		pos=(320,240)
		just=[center center]

		event_handlers=[
			{ focus  	        <focus_script> params={text=<text>} }
			{ unfocus    		<unfocus_script> }
			{ pad_choose              <pad_choose_script> params=<pad_choose_params> }
		]
	}
endscript


// @script | make_toggle_menu_item | Attaches a toggle item to a menu item.
// Really just creates a text child of the menu item that can be changed
// independently of the item itself.
script make_toggle_menu_item { font=small
		child_pos={ (210,0) relative}
		rgba=[88 105 112 128]
		child_rgba=[88 105 112 128]
		just=[right top]
		child_just=[left top]
		; scale=1
		child_scale=1

		focus_script = do_scale_up
		unfocus_script = do_scale_down
		pad_choose_script = item_chosen
		toggle_text="off"
	}
	CreateScreenElement {
		type=TextElement
		parent=current_menu
		id=<id>
		font=<font>
		pos=<pos>
		rgba=<rgba>
		just=<just>
		text=<text>
		scale=<scale>
		event_handlers=[
			{focus              <focus_script> params=<focus_params>}
			{unfocus            <unfocus_script> params=<unfocus_params>}
			{pad_choose              <pad_choose_script> params=<pad_choose_params>}
			{pad_start              <pad_choose_script> params=<pad_choose_params>}
		]
	}

	CreateScreenElement {
		type=TextElement
		parent=<id>
		font=<font>
		pos=<child_pos>
		rgba=<child_rgba>
		just=<child_just>
		text=<toggle_text>
		scale=<child_scale>
	}
endscript


// @script | toggle_menu_item_on | assumes that the id passed is the id of
// an item with a single child, and changes the child from "off" to "on"
script toggle_menu_item_on {
		toggle_text="on"
	}
	SetScreenElementProps {
		id={ <id> child=0 }
		text=<toggle_text>
	}
endscript


// @script | toggle_menu_item_off | assumes that the id passed is the id of
// an item with a single child, and changes the child from "on" to "off"
script toggle_menu_item_off {
		toggle_text="off"
	}
	SetScreenElementProps {
		id={ <id> child=0 }
		text=<toggle_text>
	}
endscript

; ==========================================================================
;
; Animation scripts
;
; ==========================================================================

// @script | animate_in | Performs the menu's 'entrance' animation - gets run
// 'on' main_menu_anchor
script animate_in ; final_pos=(320, 224)
	//PlaySound AnimateIn vol=200
	SetButtonEventMappings block_menu_input
	SetScreenElementProps id=root_window tags={menu_state=entering}
	; SetProps just=[center center]

	DoMorph time=0 scale=0 alpha=0; pos=(20,224)
	FireEvent type=focus target=<menu_id>
	DoMorph time=.07 scale=1.1 alpha=.4; pos=<final_pos>
	DoMorph time=.07 scale=.95 alpha=1 ; pos=<final_pos>
	DoMorph time=.07 scale=1.0; pos=<final_pos>

	SetScreenElementProps id=root_window tags={menu_state=on}
	if not GotParam dont_unblock
		SetButtonEventMappings unblock_menu_input
	endif
endscript

// @script | menu_onscreen | make menu appear instantly
script menu_onscreen menu_id=current_menu_anchor
	// I NEED THIS FUNCTION TO BE INSTANT...put animations
	// in animate_in or make a new script...ask me for help
	// if you need it - brad

	DoMorph scale=1 time=0
	if GotParam pos
		DoMorph pos=<pos>
	endif
	SetProps just=[center center]
	GetTags
	if GotParam focus_child
		FireEvent type=focus target=<menu_id> data={ child_id=<focus_child> }
	else
		FireEvent type=focus target=<id>
	endif
	if Not GotParam preserve_menu_state
		SetScreenElementProps id=root_window tags={menu_state=on}
	endif
endscript


// @script | animate_out | Performs the menu's 'exit' animation - gets run
// 'on' current_menu_anchor
script animate_out menu_id=current_menu_anchor
	//PlaySound AnimateOut
	SetButtonEventMappings block_menu_input
	SetScreenElementProps id=root_window tags={menu_state=leaving}

	GetTags
	; FireEvent type=unfocus target=<id>
	SetProps just=[center center]
	DoMorph time=0 scale=1.0
	DoMorph time=.07 scale=1.3
	DoMorph time=.05 scale=1.4 alpha=.05
	DoMorph time=.15 scale=0.0  alpha=0
	SetScreenElementProps id=root_window tags={menu_state=off}

	SetScreenElementLock id=root_window off
	DestroyScreenElement id=<menu_id>
	SetButtonEventMappings unblock_menu_input
endscript


// @script | menu_offscreen | instantly destroy onscreen menu
script menu_offscreen
	// I NEED THIS FUNCTION TO BE INSTANT...put animations
	// in animate_out or make a new script...ask me for help
	// if you need it - brad

	SetScreenElementProps id=root_window tags={ menu_state=off }
	SetScreenElementLock id=root_window off

	GetTags
	FireEvent type=unfocus target=<id>
	DestroyScreenElement id=<id> recurse
endscript

; ==========================================================================
;
; Event handling scripts
;
; ==========================================================================

// @script | scale_sprite_up | used when a sprite comes into focus in a menu
script scale_sprite_up
	;DoMorph time=.1 scale=.95
	DoMorph time=0  scale=0 alpha=.5
	DoMorph time=.300  rot_angle=-360 scale=1 alpha=.85
endscript

// @script | scale_sprite_down | used when focus is taken away from a sprite in a menu
script scale_sprite_down
	;DoMorph time=.0 scale=0
	DoMorph time=0 rot_angle=0 scale=0
endscript

// @script | do_scale_up | Run on a text screen element in response to a focus event
script do_scale_up rgba=[127 102 0 100]
	GetTags
	SetProps rgba=<rgba>
	RunScriptOnScreenElement id=<id> do_random_effect params={ id=<id> }
	//    DoMorph time=.25 scale=1.0
endscript



// @script | do_scale_down | Run on a text screen element in response to an unfocus event
script do_scale_down rgba=[88 105 112 128]
	if not GotParam no_sound
		generic_menu_pad_up_down_sound
	endif

	; printf "do_scale_down"
	KillSpawnedScript name=do_random_effect
	SetProps no_blur_effect

	SetProps rgba=<rgba>
	//    DoMorph time=.25 scale=1.0
endscript

script do_random_effect
	GetTags
	SetTags random_effect_done = 0
	RunScriptOnScreenElement id=<id> do_random_effect2
	begin
		GetTags
		if ( <random_effect_done> = 1 )
			; printf "received event"
			SetTags random_effect_done = 0
			RunScriptOnScreenElement id=<id> do_random_effect2 params={
				id=<id>
				effect=Random(@2 @3 @5 @8 @2 @3 @5 @2 @3 @5 @2 @10 @3 @2 @3 @5 @2 @3 @8 @3 @5 @9 @2 @3 @5 @2 @3 @5 @6 @2 @3 @9 @5 @3 @2 @3 @5 @2 @3 @5 @2 @3 @5 @6 @7 @1)
			}
		endif
		// adjust this time to change the frequency of new effects...
		wait 10 frame
	repeat
endscript

script do_random_effect2
	; printf "%i" i=<id>
	switch <effect>
		case 1
			DoMorph time=.04 scale=(1.1,.95) alpha=.1 relative_scale
			DoMorph time=.04 scale=1 alpha=1 relative_scale
		case 2
			DoMorph time=.05 pos={(-.75, .5) relative}
			DoMorph time=.05 pos={(1.5, -1) relative}
			DoMorph time=.05 pos={(-.75, .5) relative}
		case 3
			DoMorph time=.05 alpha=.6
			DoMorph time=.05 alpha=1
		case 4
			SetProps blur_effect
			do_blur_effect_highlight
			SetProps no_blur_effect
		case 5
			DoMorph time=.05 pos={(-1.5, .5) relative}
			DoMorph time=.05 pos={(3, -1) relative}
			DoMorph time=.05 pos={(-1.5, .5) relative}
		case 6
			DoMorph time=.05 pos={(-.75, 1.5) relative}
			DoMorph time=.05 pos={(1.5, -3) relative}
			DoMorph time=.05 pos={(-.75, 1.5) relative}
		case 7
			SetProps blur_effect
			do_blur_effect_accept
			SetProps no_blur_effect
		case 8
			// DoMorph time=.05 scale=1
			DoMorph time=.05 scale=1.1 relative_scale
			DoMorph time=.05 scale=1 relative_scale
		case 9
			DoMorph time=.04 scale=(.95,.65) alpha=.8 relative_scale
			DoMorph time=.04 scale=1 alpha=1 relative_scale

		case 10
			DoMorph time=.05 pos={(-2, 0) relative}
			DoMorph time=.05 pos={(4, 0) relative}
			DoMorph time=.05 pos={(-2.0, 0) relative}
		default
			// this is the initial effect that runs when you first
			// focus on an element
			SetProps blur_effect
			do_blur_effect
			SetProps no_blur_effect
	endswitch
	; FireEvent type=<id>
	SetTags random_effect_done=1
Endscript

// @script | hide_root_window | hides the root window and its contents
script hide_root_window
	DoScreenElementMorph id=root_window scale=0
	; RunScriptOnScreenElement id=root_window hide_screen_element
	;SetScreenElementProps id=root_window scale=0
endscript
// @script | unhide_root_window | unhides the root window and its contents
script unhide_root_window
	DoScreenElementMorph id=root_window scale=1
	; RunScriptOnScreenElement id=root_window unhide_screen_element
endscript
/*
script hide_screen_element
	DoMorph scale=0
endscript

script unhide_screen_element
	DoMorph scale=1
endscript
*/

// *********************************************
//			generic arrow script
// *********************************************

// @script | generic_menu_update_arrows | updates the up/down
// arrows in a menu.  Turns the up arrow off when you're on the first
// item, etc.
// @parm name | up_arrow_id | the id of the up arrow screen element
// @parm name | down_arrow_id | the id of the down arrow screen element
// @parmopt name | menu_id | current_menu | the vmenu the arrows are in
script generic_menu_update_arrows menu_id=current_menu
	if not ObjectExists id=<up_arrow_id>
		; printf "WARNING: up arrow not found"
		return
	endif

	if not ObjectExists id=<down_arrow_id>
		; printf "WARNING: down arrow not found"
		return
	endif

	if MenuSelectedIndexIs id=<menu_id> first
		SetScreenElementProps {
			id=<up_arrow_id>
			rgba=[128 128 128 0]
		}
	else
		SetScreenElementProps {
			id=<up_arrow_id>
			rgba=[128 128 128 128]
		}
	endif
	if MenuSelectedIndexIs id=<menu_id> last
		SetScreenElementProps {
			id=<down_arrow_id>
			rgba=[128 128 128 0]
		}
	else
		SetScreenElementProps {
			id=<down_arrow_id>
			rgba=[128 128 128 128]
		}
	endif
endscript

// *********************************************
//			generic pad handlers
// *********************************************

script generic_menu_pad_back
	printf "generic_menu_pad_back Parameters = "
	;printstruct <...>
	generic_menu_pad_back_sound
	if GotParam callback
		<callback> <...>
	endif
endscript

script generic_menu_pad_choose
	//This is commented out because it is causing duplicate sounds
	;generic_menu_pad_choose_sound
	if GotParam callback
		<callback> <...>
	endif
endscript

// **********************************************
// 			generic sound scripts
// **********************************************

script generic_menu_buzzer_sound
	PlaySound GUI_Buzzer01 vol=100
endscript

// utility for going back from one menu to another
script generic_menu_pad_back_sound
	PlaySound DE_MenuBack vol=100
endscript

script generic_menu_pad_up_down_sound
	;PlaySound menu05 vol=50 ; pitch=RandomRange (0, 255)
endscript

script generic_menu_pad_choose_sound
	;printf "generic_menu_pad_choose_sound"
	PlaySound DE_MenuSelect vol=100
endscript

disable_menu_sounds=0

script generic_menu_up_or_down_sound menu_id=current_menu
	;if not ( (MenuSelectedIndexIs id=<menu_id> first) || (MenuSelectedIndexIs id=<menu_id> last) )
	if  (disable_menu_sounds=0)
		if GotParam up
			PlaySound MenuUp vol=100
		endif
		if GotParam down
			PlaySound MenuUp pitch= 87.62 vol=100
		endif
	endif
	;endif
endscript

script generic_menu_scroll_sideways_sound
	if (disable_menu_sounds=0)
		PlaySound MenuUp vol=100
	endif
endscript

script parked_scroll_sideways_sound
	PlaySound MenuUp vol=100
endscript

script generic_keyboard_sound
	;PlaySound MenuUp
endscript

script theme_menu_pad_choose_sound
	PlaySound DE_MenuSelect vol=100
endscript

script generic_pause_exit_sound
	PlaySound PauseExit
endscript

// for debugging. so you can see where a container is.
script show_container
	if not GotParam id
		printf "show_container missing param id"
		return
	endif

	GetScreenElementDims id=<id>

	scale=( (<width>/4) * (1,0) + (<height>/4) * (0,1) )

	CreateScreenElement {
		type=SpriteElement
		texture=black
		parent=<id>

		pos=(0,0)
		just=[left top]
		rgba=[0 128 0 128]
		scale=<scale>
		z_priority=-10
	}
endscript


/////////////////////////////////////////////
// Pause menu 3D deck
////////////////////////////////////////////

script pause_show_deck active_viewport=0 node=TRG_Restart01 parent=root_window
	kill_pause_deck
	if not ObjectExists id=skater
		return
	endif
	if IsObserving
		return
	endif

	if not ScreenElementExists id=<parent>
		printf "WARNING: pause_show_deck couldn't find parent %s" s=<parent>
		return
	endif
	SetScreenElementLock id=<parent> off

	if GotParam no_slide
		Pos=(360, 220)
	else
		Pos=(800, 220)
	endif

	GetSkaterId
	CreateScreenElement {
		Parent=<parent>
		Type=Element3d
		Id=pause_deck

		;model = "Levels\Skateshop\THPS4board_01\THPS4board_01.mdl"
		SkeletonName = thps5_human
		CloneModel = <objId>
		CloneModelGeoms = [ board ]
		TexDictOffset=20
		Pos=<pos>
		CameraZ=-6
		Scale=0.12
		Tilt=0
		PivotPoint = (0, 4.12, 0)
		Active_Viewport=<active_viewport>

		AngleOrderXYZ
		anglex=-1.57	// half PI
		angley=0
		anglez=0.4
	}

	spawnscript rotate_pause_deck <no_slide>
endscript

script kill_pause_deck
	if ObjectExists id=pause_deck
		KillSpawnedScript name=rotate_pause_deck
		DestroyScreenElement id=pause_deck
	endif
endscript

script rotate_pause_deck

	// Mick: (TT#2438)  If you "quit" the pause menu on the first frame, then it kills the pause_deck
	// yet this script will not have run yet, so we need the additional check here
	// to allow this script to die if the object does not exist
	if not ObjectExists id=pause_deck
		return			// a return will kill the script, as it's spawned
	endif


	rot_angle=0

	DoScreenElementMorph time=0.25 id=pause_deck pos=(360,220)
	;return

	begin
		if not ObjectExists id=pause_deck
			return
		endif
		SetScreenElementProps id=pause_deck angley=<rot_angle>
		rot_angle=( <rot_angle> + 0.0625 )
		wait 1 gameframes
	repeat
endscript

script pause_deck_sync_to_skater_graphic
	GetCurrentSkaterProfileIndex
	if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=deck_graphic
		GetActualCASOptionStruct part=deck_graphic desc_id=<desc_id>
		;pause_deck:Obj_ReplaceTexture src="DM_thps4_board01.png" dest=<with>
	endif
endscript

script pause_deck_sync_to_skater_griptape
	GetCurrentSkaterProfileIndex
	if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=griptape
		GetActualCASOptionStruct part=griptape desc_id=<desc_id>
		;pause_deck:Obj_ReplaceTexture src="cw_ss_generic_griptape_01.png" dest=<with>
	endif
endscript

script fadetoblack time=0.5 alpha=0.5 z_priority=0 rgba=[0 0 0 128] scale=(300,200) texture=black id=screenfader pos=(320,240)
	if GotParam on
		if not ScreenElementExists id=<id>
			SetScreenElementLock off id=root_window

			if not GotParam create_script
				CreateScreenElement {
					type=SpriteElement
					parent=root_window
					id=<id>

					texture=<texture>
					pos=<pos>
					rgba=<rgba>
					just=[center center]
					scale=<scale>
					alpha=0
					z_priority=<z_priority>
				}
			else
				<create_script>
			endif
			DoScreenElementMorph id=<id> time=<time> alpha=<alpha>
		endif
	endif

	if GotParam off
		if ScreenElementExists id=<id>
			DoScreenElementMorph id=<id> time=<time> alpha=0
			wait <time> seconds
			if ScreenElementExists id=<id>
				DestroyScreenElement id=<id>
			endif
		endif
	endif
endscript

boardshop_deck_price = 50
unlock_sponsor_boards = 0
in_boardshop=0

// @script / launch_boardshop / loads the boardshop level
script launch_boardshop

	SetGameType freeskate
	SetCurrentGameType

	// make sure its a custom skater
	DisplayLoadingScreen freeze

	select_skater_get_current_skater_name
	if not (<current_skater> = custom)
		load_pro_skater name=custom
	endif


	main_menu_play_level level=load_boardshop
endscript

entered_skateshop_through_door=0

// **************************************
// 		boardshop menu stuff
// **************************************

script set_boardshop_cam
	if not GotParam no_wait
		wait 3 gameframe
		GoalManager_HidePoints
	endif
	if LevelIs load_boardshop
		Skater:Obj_MoveToNode name=skateshop_player_restart orient
		MakeSkaterGoto SkateShopAI Params={NoSFX CAS_Screen}

		KillSkaterCamAnim all
		PlaySkaterCamAnim name=skateshop_startcam play_hold
	endif
endscript

script launch_boardshop_menu
	load_boardshop_textures_to_main_memory

	SetScreenElementLock id=root_window off

	pulse_blur

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if GotParam parent_index
		change edit_skater_menu_level_1_index = <parent_index>
	endif

	if ( unlock_sponsor_boards = 1 )
		unlock_sponsor_decks
	endif

	SpawnScript set_boardshop_cam

	boardshop_create_initial_menus
endscript

// 2p Game menu scripts

script create_end_run_menu
	dialog_box_exit

	SetGameType freeskate2p
	SetCurrentGameType

	PauseMusicAndStreams
	PauseGame
	pause_menu_gradient on
	kill_start_key_binding

	FormatText ChecksumName=title_icon "%i_2_player" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_option_menu title="2 PLAYERS" title_icon=<title_icon> right_bracket_alpha=0.0

	create_helper_text generic_helper_text_no_back

	set_theme_icons

	make_sprite_menu_item text="Start Game" id=menu_end_run_start_game pad_choose_script=create_network_game_options_menu pad_choose_params={end_run}
	make_text_sprite texture=<continue_icon> parent=menu_end_run_start_game

	make_sprite_menu_item text="Change Levels" id=menu_end_run_change_levels pad_choose_script=launch_level_select_menu pad_choose_params={end_run}
	make_text_sprite texture=<level_icon> parent=menu_end_run_change_levels

	make_sprite_menu_item text="Split Mode" id=menu_end_run_split_mode pad_choose_script=create_split_menu pad_choose_params={callback_script=create_end_run_menu end_run}
	make_text_sprite texture=<split_icon> parent=menu_end_run_split_mode

	make_sprite_menu_item text="Quit" id=menu_end_run_quit pad_choose_script=menu_confirm_quit pad_choose_params={no_script=create_end_run_menu back_script=create_end_run_menu } ;do_nothing}
	make_text_sprite texture=<quit_icon> parent=menu_end_run_quit

	build_top_bar pos=(0, 62)

	GoalManager_HideGoalPoints
	GoalManager_HidePoints

	FireEvent type=focus target=current_menu_anchor
endscript



