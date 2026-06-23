// start autoduck documentation
// @DOC keyboard
// @module keyboard | None
// @subindex Scripting Database
// @index script | keyboard

keyboard_current_charset = alphanumeric_lower
keyboard_text_scale=(.95, .55)
keyboard_button_scale=(1, 1.6)
keyboard_caps_lock=0
keyboard_text_block_width=360

// @script | create_onscreen_keyboard |
// @parmopt string | keyboard_title | "KEYBOARD" | the title to display
// @parmopt name | keyboard_done_script | | the script to run
// when the user hits the "done" button
// @flag allow_cancel | this will create the "cancel" button and bind triangle
// to it as a shortcut
// @parmopt name | keyboard_cancel_script | keyboard_cancel | the script to
// run when the user hits the "cancel" button
// @parmopt int | max_length | | the maximum allowable length for this string
// @flag password | if present, the display string will be asterisks, hiding the
// actual string from view
script create_onscreen_keyboard { keyboard_title="KEYBOARD"
		keyboard_cancel_script=keyboard_cancel
		pos=(320, 240)
		max_length=20
		display_text="_"
		text=""
		display_text_scale=.85
		display_text_offset=(0,0)
	}

	change keyboard_toggling_char_set = 0
	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	destroy_onscreen_keyboard

	SetScreenElementLock id=root_window off

	if GotParam no_buttons
		// parent container
		CreateScreenElement {
			type=ContainerElement
			parent=root_window
			id=keyboard_anchor

			pos=<pos>
			dims=(640, 480)
			z_priority=15
		}
	else
		// background container
		CreateScreenElement {
			type=ContainerElement
			parent=root_window
			id=keyboard_bg_anchor

			pos=<pos>
			dims=(640, 480)
		}
		// parent container
		CreateScreenElement {
			type=ContainerElement
			parent=keyboard_bg_anchor
			id=keyboard_anchor
			focusable_child=keyboard_vmenu

			pos=<pos>
			dims=(640, 480)
		}
	endif
	AssignAlias id=keyboard_anchor alias=current_menu_anchor

	if GotParam password
		keyboard_anchor:SetTags password
	endif

	if not GotParam no_buttons
		if GotParam allow_cancel
			create_helper_text { helper_text_elements=[  { text="\b7/\b4/\b6/\b5=Select" }
					{ text="\m1=Cancel" }
					{ text="\m0=Accept" }
					{ text="\mf/\mg=Character Set" }
				]
				helper_pos=<helper_pos>
				parent=keyboard_bg_anchor
			}
		else
			create_helper_text { helper_text_elements=[  { text="\b7/\b4/\b6/\b5=Select" }
					{ text="\m0=Accept" }
					{ text="\mf/\mg=Character Set" }
				]
				helper_pos=<helper_pos>
				parent=keyboard_bg_anchor
			}
		endif
	endif


	; printstruct <...>
	<org_text> = <text>
	FormatText TextName=text "%s_" s=<text>
	;FormatText TextName=display_text "%s_" s=<display_text>

	// create tabs (Alphabet, Symbols, etc.)

	if GotParam no_buttons
		// set a tag so we know where to put the cursor
		keyboard_anchor:SetTags no_buttons

		SetScreenElementProps {
			id=keyboard_anchor
			event_handlers=[ { pad_choose	keyboard_done params=<...> }
				{ pad_back		generic_menu_pad_back params={ callback=<keyboard_cancel_script> <keyboard_cancel_params> }}
			]
		}

		CreateScreenElement {
			type=TextElement
			parent=keyboard_anchor
			font=testtitle
			id=kb_no_button_hdr
			text=<display_text>
			pos=(320,65)
			just=[center top]
			z_priority=15
		}

		if GotParam text_block
			CreateScreenElement {
				type=TextBlockElement
				parent=keyboard_anchor
				id=keyboard_display_string
				allow_expansion
				font=dialog
				just=[center top]
				text="_"
				internal_just=[center center]
				not_focusable
				pos=(320, 85)
				dims=( (1, 0) * keyboard_text_block_width + (0, 10) )
			}
		else
			// create text element
			CreateScreenElement {
				type=TextElement
				parent=keyboard_anchor
				id=keyboard_display_string

				font=dialog
				just=[center top]
				text="_"
				not_focusable
				pos=(320, 85)
			}
		endif

		printf "*** 9"
		// replace the start string with astersisks if it's a password
		if GotParam password
			GetTextElementLength id=keyboard_display_string
			SetScreenElementProps id=keyboard_display_string text=""
			if ( <length> > 1 )
				begin
					TextElementConcatenate id=keyboard_display_string "*"
				repeat (<length>-1)
				TextElementConcatenate id=keyboard_display_string "_"
			endif
		endif

		CreateScreenElement {
			type=TextBlockElement
			parent=keyboard_anchor
			id=keyboard_current_string

			font=dialog
			just=[center top]
			text=<org_text>
			not_focusable
			pos=(320, 85)
			dims=( (1, 0) * keyboard_text_block_width + (0, 10) )
			allow_expansion
			scale=0
		}

		if GotParam allowed_characters
			keyboard_current_string:SetTags allowed_characters=<allowed_characters>
		endif

		// check max_length and truncate the initial string if necessary
		if GotParam max_length
			if ( <max_length> < 1 )
				script_assert "create_onscreen_keyboard called with bad max_length"
			endif

			begin
				GetTextElementLength id=keyboard_current_string
				if ( <length> > <max_length> )
					TextElementBackspace id=keyboard_current_string
					TextElementBackspace id=keyboard_display_string
				else
					break
				endif
			repeat
		endif

		FireEvent type=focus target=keyboard_anchor
	else
		// create the background
		if GotParam text_block
			theme_dialog_background {	parent=keyboard_anchor
				width=3.5
				pos=(320,85)
				num_parts=7.5
				z_priority=1
				top_height=2.55
				no_icon=no_icon
			}
		else
			theme_dialog_background {	parent=keyboard_anchor
				width=3.5
				pos=(320,85)
				num_parts=6
				z_priority=1
				top_height=1
				no_icon=no_icon
			}
		endif


		if not GotParam no_buttons
			if LevelIs load_skateshop
				build_top_and_bottom_blocks parent=keyboard_bg_anchor bot_z=10

				if GotParam in_ss
					make_mainmenu_3d_plane {
						parent=keyboard_bg_anchor
						model="mainmenu_bg\mainmenu_bg.mdl"
						scale=(1.25,1.25)
						pos=(360,217)
					}

					// building
					CreateScreenElement {
						type=SpriteElement
						parent=keyboard_bg_anchor
						id=mm_building

						texture=ss_sidewall
						;rgba=[100 100 100 50]
						;just=[left top]
						just=[center center]
						;pos=(0,64)
						;scale = (1.2, 1.2)
						scale=(2.0,1.8)
						pos=(-40,195)
						z_priority=-3
						alpha=1
					}
					make_mainmenu_clouds parent=keyboard_bg_anchor
				else
					make_mainmenu_3d_plane parent=keyboard_bg_anchor
					if GotParam in_net_lobby
						if not ScreenElementExists id=globe
							// globe
							CreateScreenElement {
								type=spriteElement
								parent=keyboard_bg_anchor
								id=globe
								texture=globe
								scale=1
								pos=(550,240)
								just=[center center]
								alpha=0.2
								z_priority=-1
							}
							RunScriptOnScreenElement id=globe rotate_internet_options_globe
						endif
					endif
					if GotParam in_profile_options
						// globe
						CreateScreenElement {
							type=spriteElement
							parent=keyboard_bg_anchor
							id=globe
							texture=globe
							scale=1.3
							pos=(320,560)
							just=[center center]
							alpha=0.3
							z_priority=-1
						}
						RunScriptOnScreenElement id=globe rotate_internet_options_globe
					endif
				endif
			else
				pause_menu_gradient on
			endif
		endif

		if (<keyboard_title>="ENTER CHEAT")
			FormatText ChecksumName=title_icon "%i_cheats" i=(THEME_PREFIXES[current_theme_prefix]) parent=keyboard_bg_anchor
		else
			if (<keyboard_title>="ENTER MESSAGE")
				FormatText ChecksumName=title_icon "%i_name_cat" i=(THEME_PREFIXES[current_theme_prefix]) parent=keyboard_bg_anchor
			else
				FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix]) parent=keyboard_bg_anchor
			endif
		endif

		build_theme_sub_title title=<keyboard_title> title_icon=<title_icon> parent=keyboard_bg_anchor
		if not LevelIs load_skateshop
			FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
			build_theme_box_icons icon_texture=<paused_icon> parent=keyboard_bg_anchor
			build_grunge_piece parent=keyboard_bg_anchor
			build_top_bar pos=(0, 62) parent=keyboard_bg_anchor
		endif

		// vmenu to hold all the keys
		if GotParam text_block
			CreateScreenElement {
				type=VMenu
				parent=keyboard_anchor
				id=keyboard_vmenu

				pos=(320, 247)
				internal_just=[center top]
				regular_space_amount=30

				event_handlers=[ { pad_L2			keyboard_handle_L2 params={ max_length=<max_length> } }
					{ pad_R2			keyboard_handle_R2 params={ max_length=<max_length> } }
					{ pad_L1			keyboard_handle_L2 params={ max_length=<max_length> } }
					{ pad_R1			keyboard_handle_R2 params={ max_length=<max_length> } }
					{ pad_up			keyboard_change_key_sound }
					{ pad_down			keyboard_change_key_sound }
					;{ pad_back		generic_menu_pad_back params={ callback=<keyboard_cancel_script> <keyboard_cancel_params> }}
				]
			}

			if not GotParam no_back
				SetScreenElementProps {
					id=keyboard_vmenu
					event_handlers=[
						{ pad_back		generic_menu_pad_back params={ callback=<keyboard_cancel_script> <keyboard_cancel_params> }}
					]
				}
			else
				kill_start_key_binding
			endif

		else
			CreateScreenElement {
				type=VMenu
				parent=keyboard_anchor
				id=keyboard_vmenu

				pos=(320, 197)
				internal_just=[center top]
				regular_space_amount=30

				event_handlers=[ { pad_L2			keyboard_handle_L2 params={ max_length=<max_length> } }
					{ pad_R2			keyboard_handle_R2 params={ max_length=<max_length> } }
					{ pad_L1			keyboard_handle_L2 params={ max_length=<max_length> } }
					{ pad_R1			keyboard_handle_R2 params={ max_length=<max_length> } }
					{ pad_up			keyboard_change_key_sound }
					{ pad_down			keyboard_change_key_sound }
					;{ pad_back		generic_menu_pad_back params={ callback=<keyboard_cancel_script> <keyboard_cancel_params> }}
				]
			}

			if not GotParam no_back
				SetScreenElementProps {
					id=keyboard_vmenu
					event_handlers=[
						{ pad_back		generic_menu_pad_back params={ callback=<keyboard_cancel_script> <keyboard_cancel_params> }}
					]
				}
			else
				kill_start_key_binding
			endif
		endif


		SetScreenElementProps { id=keyboard_vmenu
			event_handlers=[	{ pad_backspace		keyboard_handle_backspace }
				{ pad_space		    keyboard_handle_space params={ max_length=<max_length> } }
				;{ pad_back		generic_menu_pad_back params={ callback=<keyboard_cancel_script> <keyboard_cancel_params> }}
			]
		}

		if not GotParam no_back
			SetScreenElementProps {
				id=keyboard_vmenu
				event_handlers=[
					{ pad_back		generic_menu_pad_back params={ callback=<keyboard_cancel_script> <keyboard_cancel_params> }}
				]
			}
		else
			kill_start_key_binding
		endif

		if GotParam text_block
			keyboard_anchor:SetTags text_block
			// need this
			CreateScreenElement {
				type=ContainerElement
				parent=keyboard_vmenu
				internal_just=[center center]
				dims=(10, 20)
				not_focusable
			}

			// text block
			CreateScreenElement {
				type=TextBlockElement
				parent=keyboard_anchor
				id=keyboard_display_string

				font=dialog
				just=[center top]
				internal_just=[left center]
				text=<text>
				not_focusable
				pos=(320, 90)
				dims=( (1, 0) * keyboard_text_block_width + (20, 400) )
				allow_expansion
				line_spacing = 0.86
				scale=0.85
				rgba=<unhighlight_color>
			}
		else
			CreateScreenElement {
				type=ContainerElement
				parent=keyboard_vmenu
				id=keyboard_display_string_container

				dims=(10, 20)
				not_focusable
			}

			// create text element
			CreateScreenElement {
				type=TextElement
				parent=<id>
				id=keyboard_display_string
				pos=((-139, 7) + <display_text_offset>)
				font=dialog
				just=[left top]
				text=<text>
				scale=<display_text_scale>
				not_focusable
				rgba=<unhighlight_color>
			}
		endif

		// replace the start string with astersisks if it's a password
		if GotParam password
			GetTextElementLength id=keyboard_display_string
			SetScreenElementProps id=keyboard_display_string text=""
			if ( <length> > 1 )
				begin
					TextElementConcatenate id=keyboard_display_string "*"
				repeat (<length>-1)
				TextElementConcatenate id=keyboard_display_string "_"
			endif
		endif


		// dummy text element used to store actual string
		// this way the display string can be different, eg
		// we are entering a password and want to display asterisks
		if GotParam text_block
			CreateScreenElement {
				type=TextBlockElement
				parent=keyboard_anchor
				id=keyboard_current_string

				font=dialog
				just=[center top]
				text=<org_text>
				not_focusable
				pos=(320, 85)
				dims=( (1, 0) * keyboard_text_block_width + (0, 20) )
				allow_expansion
				scale=0
			}
		else
			CreateScreenElement {
				type=TextElement
				parent=keyboard_anchor
				id=keyboard_current_string

				font=dialog
				just=[center top]
				text=<org_text>
				not_focusable
				pos=(320, 85)
				scale=0
			}
		endif

		if GotParam allowed_characters
			keyboard_current_string:SetTags allowed_characters=<allowed_characters>
		endif

		// check max_length and truncate the initial string if necessary
		if GotParam max_length
			if ( <max_length> < 1 )
				script_assert "create_onscreen_keyboard called with bad max_length"
			endif

			begin
				GetTextElementLength id=keyboard_current_string
				if ( <length> > <max_length> )
					TextElementBackspace id=keyboard_current_string
					TextElementBackspace id=keyboard_display_string
				else
					break
				endif
			repeat
		endif

		CreateScreenElement {
			type=SpriteElement
			parent=keyboard_anchor
			id=keyboard_options_bg

			texture=options_bg
			scale=(1.0, 1.0)
			rgba=[0 0 0 0]
			just=[center center]
			pos=(267, 80)
		}

		// create new character set guide
		keyboard_character_set_guide

		// create the key elements (grey boxes)
		keyboard_create_key_sprites <...>

		// by default start out in lower case alphanumeric char set
		keyboard_change_charset charset=alphanumeric_charset_lower max_length=<max_length>
		change keyboard_current_charset=alphanumeric_lower

		FireEvent type=focus target=keyboard_vmenu

		DoScreenElementMorph id=keyboard_anchor pos=(320,600)
		DoScreenElementMorph id=keyboard_anchor pos=(320,240) time=0.3
	endif

	if Not GotParam no_buttons
		AssignAlias id=keyboard_bg_anchor alias=current_menu_anchor
	endif

	;keyboard_update_cursor
	StartKeyboardHandler max_length=<max_length>
endscript

script keyboard_character_set_guide
	CreateScreenElement {
		type=ContainerElement
		parent=keyboard_vmenu
		id=char_guide_anchor
		not_focusable
	}

	guide_box_rgba = [35 35 35 80]

	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	CreateScreenElement {
		type=TextElement
		parent=char_guide_anchor
		id=char_guide_l2

		font=dialog
		rgba=[128 128 128 100]
		just=[left top]
		text='\mf'
		not_focusable
		pos=(-160, -6)
		scale=(.7, .8)
		z_priority=5
	}
	CreateScreenElement {
		type=SpriteElement
		parent=char_guide_anchor
		id=char_guide_left_arrow

		texture=left_arrow
		scale=(.75, .65)
		rgba=<highlight_color>
		just=[left top]
		pos=(-140, -4)
		z_priority=5
	}
	CreateScreenElement {
		type=TextElement
		parent=char_guide_anchor
		id=char_guide_symbols

		font=small
		rgba=<unhighlight_color>
		just=[left top]
		text='SYMBOLS'
		not_focusable
		pos=(-127, -3)
		scale=.78
		z_priority=5
	}
	CreateScreenElement {
		type=TextElement
		parent=char_guide_anchor
		id=char_guide_allcaps

		font=small
		rgba=<unhighlight_color>
		just=[left top]
		text=' ALL-CAPS'
		not_focusable
		pos=(-62, -3)
		scale=.78
		z_priority=5
	}

	CreateScreenElement {
		type=TextElement
		parent=char_guide_anchor
		id=char_guide_lower

		font=small
		rgba=<highlight_color>
		just=[left top]
		text='  LOWER'
		not_focusable
		pos=(5, -3)
		scale=.78
		z_priority=5
	}
	CreateScreenElement {
		type=TextElement
		parent=char_guide_anchor
		id=char_guide_foreign

		font=small
		rgba=<unhighlight_color>
		just=[left top]
		text='FOREIGN'
		not_focusable
		pos=(72, -3)
		scale=.78
		z_priority=5
	}
	CreateScreenElement {
		type=SpriteElement
		parent=char_guide_anchor
		id=char_guide_right_arrow

		texture=right_arrow
		scale=(.75, .65)
		rgba=<highlight_color>
		just=[left top]
		pos=(130, -4)
		z_priority=5
	}
	CreateScreenElement {
		type=TextElement
		parent=char_guide_anchor
		id=char_guide_r2

		font=dialog
		rgba=[128 128 128 100]
		just=[left top]
		text='\mg'
		not_focusable
		pos=(140, -6)
		scale=(.7, .8)
		z_priority=5
	}
endscript

script keyboard_create_key_sprites
	// create rows
	keyboard_add_hmenu id=keyboard_row_1
	keyboard_add_hmenu id=keyboard_row_2
	keyboard_add_hmenu id=keyboard_row_3
	keyboard_add_hmenu id=keyboard_row_4
	keyboard_add_hmenu id=keyboard_row_5
	keyboard_add_hmenu id=keyboard_row_6

	// now add generic buttons
	keyboard_add_generic_buttons_to_hmenu hmenu_id=keyboard_row_1 number_of_buttons=10
	keyboard_add_generic_buttons_to_hmenu hmenu_id=keyboard_row_2 number_of_buttons=10
	keyboard_add_generic_buttons_to_hmenu hmenu_id=keyboard_row_3 number_of_buttons=10
	keyboard_add_generic_buttons_to_hmenu hmenu_id=keyboard_row_4 number_of_buttons=6

	// backspace button
	keyboard_add_special_button {
		hmenu_id=keyboard_row_4
		pad_choose_script=keyboard_handle_backspace
		text="Backspace"
		pad_button_text="\m9"
		text_pos=(124, 8)
		pad_button_pos=(25, 8)
		text_scale=(.85, .55)
		width=128
		grid_x=6
	}

	// shift button
	keyboard_add_special_button {
		hmenu_id=keyboard_row_5
		pad_choose_script=keyboard_handle_shift
		pad_choose_params={ max_length=<max_length> }
		text="Shift"
		text_id=shift_text
		text_pos=(47, 2)
		width=96
		grid_x=0
	}

	// caps lock
	keyboard_add_special_button {
		hmenu_id=keyboard_row_5
		pad_choose_script=keyboard_handle_caps
		pad_choose_params={ max_length=<max_length> }
		text="Caps Lk"
		text_id=caps_lock_text
		text_pos=(47, 2)
		text_scale=(.95, .55)
		width=96
		grid_x=3
	}

	// space bar
	keyboard_add_special_button {
		hmenu_id=keyboard_row_5
		pad_choose_script=keyboard_handle_space
		pad_choose_params={ max_length=<max_length> }
		text="Space"
		pad_button_text="\m8"
		text_pos=(95, 8) //worthless
		pad_button_pos=(40, 8) //move this!
		width=128
		grid_x=6
	}

	// done button
	keyboard_add_special_button {
		hmenu_id=keyboard_row_6
		pad_choose_script=keyboard_done pad_choose_params=<...>
		button_id=keyboard_done_button
		text="Done"
		text_pos=(62, 2)
		width=128
		grid_x=0
	}

	// optional cancel button
	if GotParam allow_cancel
		SetScreenElementProps {
			id=keyboard_vmenu
			event_handlers= [ { pad_back	generic_menu_pad_back params={ callback=<keyboard_cancel_script> <keyboard_cancel_params> }} ]
			replace_handlers
		}

		keyboard_add_special_button {
			hmenu_id=keyboard_row_6
			pad_choose_script= generic_menu_pad_back params<keyboard_cancel_script>
			pad_choose_params={ callback=<keyboard_cancel_script> <keyboard_cancel_params> }
			text="Cancel"
			pad_button_text="\m1"
			text_pos=(106, 8)
			pad_button_pos=(37, 8)
			width=128
			grid_x=6
		}

	endif
endscript

// @script | keyboard_change_charset | use this script to change
// the charset of the onscreen keyboard
// @parm name | charset | the name of the charset you wish to load (they're
// all in keyboard.q)
script keyboard_change_charset
	begin
		if GetNextArrayElement <charset> index=<index>
			keyboard_change_key_row row=<element> row_number=<index> max_length=<max_length>
		else
			break
		endif
	repeat
endscript

script keyboard_change_key_row
	// figure the hmenu we want (quicker than doing it for each key)
	FormatText ChecksumName=hmenu_id "keyboard_row_%i" i=( <row_number> + 1 )

	begin
		if GetNextArrayElement <row> index=<index>
			// change the text
			SetScreenElementProps {
				id={ <hmenu_id> child={ <index> child=0 } }
				text=<element>

				replace_handlers
			}
			SetScreenElementProps {
				id={ <hmenu_id> child=<index>}
				// this tag is used when the user flips
				// between rows, to preserve column
				tags={tag_grid_x=<index>}
			}

			keyboard_set_button_events {
				hmenu_id=<hmenu_id>
				index=<index>
				text=<element>
				max_length=<max_length>
			}
		else
			break
		endif
	repeat
endscript

script destroy_onscreen_keyboard
	KillSpawnedScript name=keyboard_key_focus
	if ObjectExists id=keyboard_anchor
		DestroyScreenElement id=keyboard_anchor
	endif
	if ObjectExists id=keyboard_bg_anchor
		DestroyScreenElement id=keyboard_bg_anchor
	endif

	StopKeyboardHandler
	change keyboard_caps_lock=0

	// keyboard textures
	RemoveTextureFromVram "generic_key" no_assert
	RemoveTextureFromVram "key_left" no_assert
	RemoveTextureFromVram "key_middle" no_assert
	RemoveTextureFromVram "key_right" no_assert
	RemoveTextureFromVram "PA_fonts" no_assert
	RemoveTextureFromVram "goal_right" no_assert
	RemoveTextureFromVram "goal_left" no_assert
	RemoveTextureFromVram "right_arrow" no_assert
	RemoveTextureFromVram "left_arrow" no_assert
endscript

// ***************************************************
//					creation scripts
// ***************************************************

script keyboard_add_hmenu
	CreateScreenElement {
		type=Hmenu
		parent=keyboard_vmenu
		id=<id>

		internal_just=[left center]
		event_handlers=[ { pad_left			keyboard_change_key_sound }
			{ pad_right		keyboard_change_key_sound }
		]
	}
endscript

script keyboard_add_generic_buttons_to_hmenu
	FormatText ChecksumName=button_rgba "%i_KEY_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	begin
		CreateScreenElement {
			type=SpriteElement
			parent=<hmenu_id>
			rgba=<button_rgba>
			texture=generic_key
			scale=keyboard_button_scale
		}
		keyboard_create_dummy_text id=<id>
		; keyboard_set_button_events id=<id>
	repeat <number_of_buttons>
endscript

script keyboard_set_button_events
	if GotParam id
		if ObjectExists id=<id>
			SetScreenElementProps {
				id=<id>
				event_handlers=[ { focus		keyboard_button_focus }
					{ unfocus		keyboard_button_unfocus }
					{ pad_choose		keyboard_button_pressed params={ text=<text> max_length=<max_length> } }
					{ pad_start 		keyboard_button_pressed params={ text=<text> max_length=<max_length> } }
				]
				replace_handlers
			}
		endif
	else
		if ObjectExists id=<hmenu_id>
			if ObjectExists id={ <hmenu_id> child=<index> }
				SetScreenElementProps {
					id={ <hmenu_id> child=<index> }
					event_handlers=[ { focus		keyboard_button_focus }
						{ unfocus		keyboard_button_unfocus }
						{ pad_choose		keyboard_button_pressed params={ text=<text> max_length=<max_length> } }
						{ pad_start 		keyboard_button_pressed params={ text=<text> max_length=<max_length> } }
					]
					replace_handlers
				}
			endif
		endif
	endif
endscript

script keyboard_create_dummy_text
	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	CreateScreenElement {
		type=TextElement
		parent=<id>

		rgba=<unhighlight_color>;[88 105 112 128]
		just=[center center]
		pos=(17, 8)
		scale=keyboard_text_scale
		event_handlers=[ { focus		keyboard_text_focus }
			{ unfocus		keyboard_text_unfocus }
		]
		font=dialog
	}
endscript

script keyboard_add_special_button { text_pos=(121, 8)
		text_scale=keyboard_text_scale
		pad_button_pos=(33, 8)
		button_scale=keyboard_button_scale
		width=32
	}
	FormatText ChecksumName=button_rgba "%i_KEY_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	CreateScreenElement {
		type=ContainerElement
		id=<button_id>
		parent=<hmenu_id>
		;scale=button_scale
		tags={tag_grid_x=<grid_x> tag_txt_offset=(2+ ( <width> - 16 ) / 4 )}
		dims=((1,0)*<width> + (0,35))
		internal_just=[center center]
	}

	<parent_id> = <id>

	// create the left side
	<root_pos>=(5,18)
	CreateScreenElement {
		type=SpriteElement
		;id=<button_id>
		parent=<parent_id>
		scale=<button_scale>
		texture=key_left
		rgba=<button_rgba>
		;tags={tag_grid_x=<grid_x>}
		pos=<root_pos>
	}
	// store the id
	<button_id> = <id>

	// create the middle bit
	<iterations> = ( ( <width> - 16 ) / 4 )
	<dx> = 4
	begin

		CreateScreenElement {
			type=SpriteElement
			parent=<parent_id>
			texture=key_middle
			scale=(keyboard_button_scale + (0.1,0))
			rgba=<button_rgba>
			pos=((1,0)*<dx> + <root_pos>)
			not_focusable
		}
		<dx> = (<dx>+4)
	repeat <iterations>

	// create the right side
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		scale=<button_scale>
		texture=key_right
		rgba=<button_rgba>
		not_focusable
		pos=((1,0)*<dx> + <root_pos>)
	}

	// TODO: this is a temp hack...the text needs to be the special backspace char
	if ( (<text>="space") || (<text>="backspace") )
		SetScreenElementProps {
			id=<parent_id>
			event_handlers=[ { focus		keyboard_button_focus }
				{ unfocus 		keyboard_button_unfocus }
				{ pad_choose	<pad_choose_script> params=<pad_choose_params>}
				{ pad_start 	<pad_choose_script> params=<pad_choose_params>}
			]
			replace_handlers
		}
	else
		SetScreenElementProps {
			id=<parent_id>
			event_handlers=[ { focus		keyboard_button_focus }
				{ unfocus 		keyboard_button_unfocus }
				{ pad_choose	generic_keyboard_sound }
				{ pad_start 	generic_keyboard_sound }
				{ pad_choose	<pad_choose_script> params=<pad_choose_params>}
				{ pad_start 	<pad_choose_script> params=<pad_choose_params>}
			]
			replace_handlers
		}
	endif


	// add the button
	if GotParam pad_button_text
		CreateScreenElement {
			type=TextElement
			parent=<parent_id>
			z_priority=10
			scale=(<text_scale>+(0,.2))
			font=small
			text=<pad_button_text>
			pos=(<pad_button_pos>+(0,10))
			just=[right center]
		}
	endif

	// add the text
	if GotParam pad_button_text
		GetStackedScreenElementPos X id=<id> offset=(3, 0)
		<text_pos> = <pos>
		; <text_pos> = ( <pad_button_pos> + (3, 0) )
		<text_just> = [left top]
	else
		GetScreenElementPosition id=<button_id>
		;<text_pos> = ( (1, 0) * ( <width> / 2 ) )
		<text_pos> = (<text_pos>+(0,8))
		<text_just> = [center top]
	endif

	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	CreateScreenElement {
		type=TextElement
		parent=<parent_id>
		z_priority=10
		font=dialog
		id=<text_id>
		text=<text>  // replace this with meta char!
		pos=<text_pos>
		; scale=( (1, 0) / ( ( <width> - 16 ) / 4 ) + (0, .625) )
		scale=(<text_scale> + (0,.2))
		just=<text_just>
		rgba=<unhighlight_color>
		;rgba=[0 0 0 90]
		event_handlers=[ { focus		keyboard_text_focus }
			{ unfocus		keyboard_text_unfocus }
		]
	}
endscript

// ************************************************
//			event handler scripts
// ************************************************

script keyboard_button_focus
	GetTags
	//probably not the best way to do this, but the only way without figuring out
	<txt_offset>=0
	if GotParam tag_txt_offset
		<txt_offset>=<tag_txt_offset>
	endif

	if ScreenElementExists id={ <id> child=(<txt_offset>+1) }
		RunScriptOnScreenElement id={ <id> child=(<txt_offset>+1) } keyboard_text_focus
		SpawnScript keyboard_key_focus params={ id=<id> org_scale=(1.0,1.05)}
	else
		if GotParam tag_txt_offset
			RunScriptOnScreenElement id={ <id> child=<txt_offset> } keyboard_text_focus
			SpawnScript keyboard_key_focus params={ id=<id> org_scale=(1.0,1.05)}
		else
			RunScriptOnScreenElement id={ <id> child=<txt_offset> } keyboard_text_focus
			SpawnScript keyboard_key_focus params={id=<id> org_scale=(1.0,1.6)}
		endif
	endif
	;FireEvent type=focus id={ <id> child=0 }
endscript

script keyboard_button_unfocus
	GetTags

	<txt_offset>=0
	if GotParam tag_txt_offset
		<txt_offset>=<tag_txt_offset>
	endif

	if ScreenElementExists id={ <id> child=(<txt_offset>+1) }
		RunScriptOnScreenElement id={ <id> child=(<txt_offset>+1) } keyboard_text_unfocus
		KillSpawnedScript name=keyboard_key_focus
		DoScreenElementMorph id=<id>  time=0 scale=(1.0,1.0)
	else
		if GotParam tag_txt_offset
			RunScriptOnScreenElement id={ <id> child=<txt_offset> } keyboard_text_unfocus
			KillSpawnedScript name=keyboard_key_focus
			DoScreenElementMorph id=<id>  time=0 scale=(1.0,1.0)
		else
			RunScriptOnScreenElement id={ <id> child=<txt_offset> } keyboard_text_unfocus
			KillSpawnedScript name=keyboard_key_focus
			DoScreenElementMorph id=<id> time=0 scale=(1.0,1.6)
		endif
	endif
	/*if ( keyboard_caps_lock = 1 )
		SetScreenElementProps id=caps_lock_text rgba=[42 111 52 128]
	else
		SetScreenElementProps id=caps_lock_text rgba=[88 105 112 128]
	endif*/
	;FireEvent type=unfocus id={ <id> child=0 }
endscript

script keyboard_key_focus
	begin

		if ObjectExists id=<id>
			DoScreenElementMorph id=<id> time=.03 scale=(<org_scale>*1.05)
		endif
		wait .2 second

		if ObjectExists id=<id>
			DoScreenElementMorph id=<id> time=.03 scale=(<org_scale>*0.95)
		endif
		wait .2 second

	repeat
endscript


script keyboard_text_focus
	;do_scale_up
	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetProps rgba=<highlight_color>
endscript

script keyboard_text_unfocus
	;do_scale_down
	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetProps rgba=<unhighlight_color>
endscript

script keyboard_button_pressed
	// convert escaped backslash just for the allowed
	// character test
	if ( <text> = "\\\\" )
		<text> = "\\"
	endif

	if ( <text> = "\\" )
		PlaySound GUI_Buzzer01
		return
	endif

	// The '%' can screw up sprintf's later - forget it.
	if ( <text> = "%" )
		PlaySound GUI_Buzzer01
		return
	endif

	// check the max length of the string
	if GotParam max_length
		GetTextElementLength id=keyboard_current_string
		if ( <length> > ( <max_length> - 1 ) )
			// play a sound or something...this is the max length of the string
			; printf "You've reached the max length of %i" i=<length>
			PlaySound GUI_Buzzer01
			return
		endif
	endif

	// check for allowed characters and play sound
	keyboard_current_string:GetTags

	if GotParam allowed_characters
		if ArrayContains array=<allowed_characters> contains=<text>
			PlaySound MenuUp
		else
			PlaySound GUI_Buzzer01
			return
		endif
	else
		PlaySound MenuUp
	endif

	// escape backslash for display
	if ( <text> = "\\" )
		<text> = "\\\\"
	endif

	GetScreenElementDims id=keyboard_display_string
	if (<height> > 40)
		<last_line> = last_line
	endif

	// add the text to the string
	if TextElementConcatenate id=keyboard_current_string <text> enforce_max_width <last_line>
		keyboard_anchor:GetTags
		if GotParam password
			TextElementBackspace id=keyboard_display_string
			FormatText Textname=text_w_cursor "%s_" s="*"
			TextElementConcatenate id=keyboard_display_string <text_w_cursor> enforce_max_width <last_line>
		else
			TextElementBackspace id=keyboard_display_string
			FormatText Textname=text_w_cursor "%s_" s=<text>
			TextElementConcatenate id=keyboard_display_string <text_w_cursor> enforce_max_width <last_line>
		endif


		// keep string inside keyboard
		GetScreenElementDims id=keyboard_display_string
		if GotParam no_buttons
			max_string_width=550
		else
			max_string_width=300
		endif

		if ScreenElementExists id=keyboard_display_string_container
			if ( <width> > <max_string_width> )
				TextElementBackspace id=keyboard_display_string
				TextElementBackspace id=keyboard_display_string
				TextElementBackspace id=keyboard_current_string
				;printf "string reached end of keyboard!"
				PlaySound GUI_Buzzer01
			endif
		else
			// text block
			printf "%s %t" s=<height> t=<width>
			if ( <height> > 80 )
				TextElementBackspace id=keyboard_display_string
				TextElementBackspace id=keyboard_current_string
				if not (<text> = " ")
					TextElementBackspace id=keyboard_display_string
					TextElementConcatenate id=keyboard_display_string " " enforce_max_width <last_line>
				endif
				printf "string reached end of keyboard!"
				PlaySound GUI_Buzzer01
			endif
		endif

		switch keyboard_current_charset
			case alphanumeric_lower
				if IsTrue keyboard_caps_lock
					keyboard_change_charset charset=alphanumeric_charset_upper max_length=<max_length>
					change keyboard_current_charset=alphanumeric_upper
				endif
			case alphanumeric_upper
				if not IsTrue keyboard_caps_lock
					keyboard_change_charset charset=alphanumeric_charset_lower max_length=<max_length>
					change keyboard_current_charset=alphanumeric_lower
				endif
		endswitch
	else
		// string was too long...play a sound of something
		printf "string too long!"
	endif

	;keyboard_update_cursor
endscript

keyboard_toggling_char_set=0

script keyboard_handle_L2

	// this is needed to prevent it from triggering twice on xbox
	if ( keyboard_toggling_char_set = 1 )
		return
	endif
	change keyboard_toggling_char_set = 1

	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	switch keyboard_current_charset
		case alphanumeric_lower
			keyboard_change_charset charset=alphanumeric_charset_upper max_length=<max_length>
			change keyboard_current_charset=alphanumeric_upper
			reset_char_guides
			SetScreenElementProps id=char_guide_allcaps rgba=<highlight_color>
			change keyboard_caps_lock=1
		case alphanumeric_upper
			keyboard_change_charset charset=punctuation_charset max_length=<max_length>
			change keyboard_current_charset=punctuation_charset
			reset_char_guides
			SetScreenElementProps id=char_guide_symbols rgba=<highlight_color>
		case punctuation_charset
			keyboard_change_charset charset=foreign_charset max_length=<max_length>
			change keyboard_current_charset=foreign_charset
			reset_char_guides
			SetScreenElementProps id=char_guide_foreign rgba=<highlight_color>
		case foreign_charset
			keyboard_change_charset charset=alphanumeric_charset_lower max_length=<max_length>
			change keyboard_current_charset=alphanumeric_lower
			reset_char_guides
			SetScreenElementProps id=char_guide_lower rgba=<highlight_color>
	endswitch
	RunScriptOnScreenElement menu_blink_arrow id=char_guide_left_arrow
	PlaySound MenuUp
	wait 0.3 seconds
	change keyboard_toggling_char_set = 0
endscript

script keyboard_handle_R2

	// this is needed to prevent it from triggering twice on xbox
	if ( keyboard_toggling_char_set = 1 )
		return
	endif
	change keyboard_toggling_char_set = 1

	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	switch keyboard_current_charset
		case alphanumeric_lower
			keyboard_change_charset charset=foreign_charset max_length=<max_length>
			change keyboard_current_charset=foreign_charset
			reset_char_guides
			SetScreenElementProps id=char_guide_foreign rgba=<highlight_color>
		case alphanumeric_upper
			keyboard_change_charset charset=alphanumeric_charset_lower max_length=<max_length>
			change keyboard_current_charset=alphanumeric_lower
			reset_char_guides
			SetScreenElementProps id=char_guide_lower rgba=<highlight_color>
		case punctuation_charset
			keyboard_change_charset charset=alphanumeric_charset_upper max_length=<max_length>
			change keyboard_current_charset=alphanumeric_upper
			reset_char_guides
			SetScreenElementProps id=char_guide_allcaps rgba=<highlight_color>
			change keyboard_caps_lock=1
		case foreign_charset
			keyboard_change_charset charset=punctuation_charset max_length=<max_length>
			change keyboard_current_charset=punctuation_charset
			reset_char_guides
			SetScreenElementProps id=char_guide_symbols rgba=<highlight_color>
	endswitch
	RunScriptOnScreenElement menu_blink_arrow id=char_guide_right_arrow
	PlaySound MenuUp
	wait 0.3 seconds
	change keyboard_toggling_char_set = 0
endscript

script reset_char_guides
	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	SetScreenElementProps id=char_guide_allcaps rgba=<unhighlight_color>
	SetScreenElementProps id=char_guide_lower	rgba=<unhighlight_color>
	SetScreenElementProps id=char_guide_symbols rgba=<unhighlight_color>
	SetScreenElementProps id=char_guide_foreign rgba=<unhighlight_color>
	change keyboard_caps_lock=0
endscript

script keyboard_handle_shift
	PlaySound MenuUp
	switch keyboard_current_charset
		case alphanumeric_lower
			keyboard_change_charset charset=alphanumeric_charset_upper max_length=<max_length>
			change keyboard_current_charset=alphanumeric_upper
		case alphanumeric_upper
			keyboard_change_charset charset=alphanumeric_charset_lower max_length=<max_length>
			change keyboard_current_charset=alphanumeric_lower
	endswitch
endscript

script keyboard_handle_backspace
	PlaySound menu03 vol=60 pitch=55
	TextElementBackspace id=keyboard_display_string
	TextElementBackspace id=keyboard_display_string
	TextElementConcatenate id=keyboard_display_string "_"
	if not TextElementBackspace id=keyboard_current_string
		// the string is empty...maybe play a sound or something?
	endif
	;keyboard_update_cursor
endscript

script keyboard_handle_space
	keyboard_button_pressed text=" " max_length=<max_length>
endscript

script keyboard_handle_caps
	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	PlaySound MenuUp
	switch keyboard_current_charset
		case alphanumeric_upper
			keyboard_change_charset charset=alphanumeric_charset_lower max_length=<max_length>
			change keyboard_current_charset=alphanumeric_lower
			reset_char_guides
			SetScreenElementProps id=char_guide_lower rgba=<highlight_color>
			change keyboard_caps_lock=0
		case alphanumeric_lower
			keyboard_change_charset charset=alphanumeric_charset_upper max_length=<max_length>
			change keyboard_current_charset=alphanumeric_upper
			reset_char_guides
			SetScreenElementProps id=char_guide_allcaps rgba=<highlight_color>
			change keyboard_caps_lock=1
		case punctuation_charset
			keyboard_change_charset charset=alphanumeric_charset_upper max_length=<max_length>
			change keyboard_current_charset=alphanumeric_upper
			reset_char_guides
			SetScreenElementProps id=char_guide_allcaps rgba=<highlight_color>
			change keyboard_caps_lock=1
		case foreign_charset
			keyboard_change_charset charset=alphanumeric_charset_upper max_length=<max_length>
			change keyboard_current_charset=alphanumeric_upper
			reset_char_guides
			SetScreenElementProps id=char_guide_allcaps rgba=<highlight_color>
			change keyboard_caps_lock=1
		default
			// play a sound or something?
	endswitch
endscript

script keyboard_done
	generic_menu_pad_choose_sound
	;TextElementBackspace id=keyboard_display_string

	SetButtonEventMappings unblock_menu_input
	if GotParam min_length
		GetTextElementLength id=keyboard_current_string
		if ( <length> < <min_length> )
			// do something to let them know...a sound or something
			printf "Not enough characters"
			return
		endif
	endif

	change keyboard_current_charset=alphanumeric_lower
	change keyboard_caps_lock=0

	if GotParam keyboard_done_script
		printf "calling done script"
		GotoPreserveParams <keyboard_done_script>
	else
		GetTextElementString id=keyboard_current_string
		if GotParam string
			printf "%s" s=<string>
		endif
		destroy_onscreen_keyboard
		exit_pause_menu
	endif
endscript

script keyboard_cancel
	destroy_onscreen_keyboard
	exit_pause_menu
endscript

// ************************************************
//			Character arrays
// ************************************************

alphanumeric_charset_lower=[ [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ]
	[ "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" ]
	[ "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" ]
	[ "u" "v" "w" "x" "y" "z" ]
]

alphanumeric_charset_upper=[ [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ]
	[ "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" ]
	[ "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" ]
	[ "U" "V" "W" "X" "Y" "Z" ]
]

punctuation_charset=[ [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ]
	[ "." "," "!" "?" "-" "¦" "'" "+" "/" "^" ]
	[ "#" "$" "{" "*" "@" "`" "&" ":" "<" ">" ]
	[ "_" "-" "¡" "=" "(" ")" ]
]

foreign_charset=[ [	"ß" "Ä" "Ü" "Ö" "à" "â" "ê" "è" "é" "ë" ]
	[ "ì" "î" "ï" "ô" "ò" "Ö" "ù" "û" "Ü" "ç" ]
	[ "œ" "ü" "ä" "ö" "á" "ó" "ú" "í" "ñ" "®" ]
	[ "¡" "¿" "ä" "ü" "É" "©" ]
]



// *************************************************
// 				Old shit
// *************************************************
standard_charset = {
	alphanumeric_charset
	allow_punctuation
	allow_spaces
}

// gapnames don't allow full punctuation
// (such as the "(", ")", "@", "_"
gapname_charset = {
	alphanumeric_charset
	allow_basic_punctuation
	allow_spaces
}

ip_charset = {
	ip_control
	allow_numbers
	allow_period
}

alphanumeric_charset = {
	allow_numbers
	allow_uppercase
	allow_lowercase
	allow_foreign
}

horse_charset = {
	allow_numbers
	allow_uppercase
	allow_lowercase
	; don't allow foreign characters, because it needs to be displayed in title font
}

//==========================================
// long string utilities
//==========================================

script truncate_string max_width=100
	//calculate width of extra "..."
	GetScreenElementDims id=<id>
	if ( <max_width> > <width> )
		return
	endif

	GetTextElementLength id=<id>
	if ( 2 > <length> )
		printf "too short... can't truncate text"
		return
	endif

	// figure width of "..."
	initial_width = <width>
	printf "initial width = %w max width = %m" w=<width> m=<max_width>
	TextElementConcatenate id=<id> "..."
	GetScreenElementDims id=<id>
	extra_width = ( <width> - <initial_width> )

	//remove "..."
	TextElementBackspace id=<id>
	TextElementBackspace id=<id>
	TextElementBackspace id=<id>

	// start truncating one character at a time
	begin
		GetScreenElementDims id=<id>
		if ( (<width> + <extra_width>) > <max_width> )
			TextElementBackspace id=<id>
		else
			break
		endif

		GetTextElementLength id=<id>
		if ( 0 = <length> )
			return
		endif
	repeat

	// add the "..." again
	TextElementConcatenate id=<id> "..."
	GetScreenElementDims id=<id>
	printf "final width = %w" w=<width>
endscript

script keyboard_change_key_sound
	PlaySound menu03 vol=40
endscript

// *****************************************
//	blinking cursor
// *****************************************

script keyboard_update_cursor scale=(1.3, 1.0)
	// kill any cursor
	if ScreenElementExists id=keyboard_cursor
		DestroyScreenElement id=keyboard_cursor
	endif

	// get the right position
	keyboard_anchor:GetTags
	if GotParam no_buttons
		GetStackedScreenElementPos X id=keyboard_display_string offset=(0, 0)
	else
		if GotParam text_block
			GetStackedScreenElementPos X Y id=keyboard_display_string offset=(100000, 0)
			scale=(.8,.5)
		else
			GetStackedScreenElementPos X id=keyboard_display_string offset=(310, 79)
		endif
	endif
	CreateScreenElement {
		type=TextElement
		parent=keyboard_anchor
		id=keyboard_cursor

		font=small
		text="_"
		scale=<scale>
		pos=<pos>
		just=[left top]
		rgba=[128 128 128 128]
		z_priority=3
	}
	RunScriptOnScreenElement id=keyboard_cursor keyboard_blink_cursor
endscript

script keyboard_blink_cursor wait_time=.15
	begin
		DoMorph time=<wait_time>
		DoMorph alpha=0
		DoMorph time=<wait_time>
		DoMorph alpha=1
	repeat
endscript
