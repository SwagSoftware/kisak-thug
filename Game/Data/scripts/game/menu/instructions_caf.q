//instructions for face mapping

facemapping_instructions_steps = [
	{ step=1 text= ["Take a digital photo of your face.\n"
			"Make sure it's front-on, with flat lighting."]
		pos=(390, 320)
		enter_script=show_pic_example
		exit_script=hide_pic_example }
	{ step=2 text=["Email it to faces@thugonline.com\n "
			"You'll get an e-mail reply with your password."]
		pos=(390, 295) }
	{ step=3 text=["From the menu here,\n "
			"Start with 'Download Face'."]
		pos=(390, 270)
		last_instruction=last_instruction }
]

facemapping_instructions_steps_phone = [
	{ step=1 text= ["Make sure your phone has a camera feature,\n"
			"and the ability to send and receive e-mail or multimedia messages."]
		pos=(390, 320)
		enter_script=show_pic_phone
		exit_script=hide_pic_phone }
	{ step=2 text= ["Take a digital photo of yourself using a phone.\n"
			"Make sure it's front-on, with flat lighting."]
		pos=(390, 320)
		enter_script=show_pic_example
		exit_script=hide_pic_example }
	{ step=3 text=["Email it to faces@thugonline.com\n "
			"You'll get an e-mail reply with your password."]
		pos=(390, 295) }
	{ step=4 text=["From the menu here,\n "
			"Start with 'Download Face'."]
		pos=(390, 270)
		last_instruction=last_instruction }
]

script PlayInstructionSet end_target=sub_menu start_index=0

	GetArraySize <instruction_set>

	FireEvent type=unfocus target=<end_target>


	create_helper_text { helper_text_elements=[	{ text="\m1=Back" }
			{ text="\m0=Continue" }] }

	if not (<start_index> = -1)
		<index>=<start_index>

		CreateInstructionBlock {
			instruction_set=<instruction_set>
			instruction=((<instruction_set>[<index>]))
		}
		WaitForEvent type=instructions_done

	endif

	wait .2 seconds

	FireEvent type=focus target=<end_target>
	create_helper_text generic_helper_text

	if GotParam exit_script
		<exit_script> <exit_params>
	endif
endscript

script exit_caf_instructions
	if GotParam from_phone
		<times> = 1
	else
		<times> = 2
	endif
	change disable_menu_sounds=1
	begin
		FireEvent type=pad_down target=sub_vmenu
		create_helper_text generic_helper_text_cas
	repeat <times>
	change disable_menu_sounds=0
endscript

script CreateInstructionBlock
	step_num_map=["A" "A" "B" "C" "D" "E" "F" "G"]
	FormatText textName=title_text "Step %c:" c=((<step_num_map>[((<instruction>).step)]))

	create_instruction_box {
		no_pad_start
		title_text=<title_text>
		text=((<instruction>).text)
		style=speech_box_style
		pos=((<instruction>).pos)
		z_priority=20
		instruction_set=<instruction_set>
		instruction_step=((<instruction>).step)
		last_instruction=((<instruction>).last_instruction)
		enter_script=((<instruction>).enter_script)
		exit_script = ((<instruction>).exit_script)

	}

endscript

script exit_instruction_block
	speech_box_exit anchor_id=<anchor_id>
endscript

script InstructionBlockForward

	if GotParam exit_script
		if not (<exit_script> = None)
			<exit_script>
		endif
	endif

	exit_instruction_block anchor_id=<anchor_id>

	<index>=<current_step>
	<end>=((<instruction_set>[(<index>-1)]).last_instruction)
	if not GotParam end
		<current_step> = (<current_step>+1)

		CreateInstructionBlock {
			instruction_set=<instruction_set>
			instruction=((<instruction_set>[<index>]))
		}
	else
		FireEvent type=instructions_done
	endif
endscript

script InstructionBlockBack

	if GotParam exit_script
		if not (<exit_script> = None)
			<exit_script>
		endif
	endif

	exit_instruction_block anchor_id=<anchor_id>

	if(<current_step> > 1)
		<current_step> = (<current_step> - 1)
		<index>=(<current_step>-1)

		CreateInstructionBlock {
			instruction_set=<instruction_set>
			instruction=((<instruction_set>[<index>]))
		}

	else
		FireEvent type=instructions_done
	endif

endscript

script create_instruction_box { pos=(320, 340)
		;bg_rgba=[100 100 100 90]
		text_rgba=[128 128 128 128]
		anchor_id=speech_box_anchor
		scale=1
		pad_choose_script=InstructionBlockForward
		pad_choose_params={ anchor_id=<anchor_id> }
		pad_back_script=InstructionBlockBack
		pad_back_params={ anchor_id=<anchor_id> }
		parent=root_window
		font=dialog
		bg_x_scale=1
		pause_input_time=1000
	}
	FormatText ChecksumName=bg_rgba "%i_SPEECH_BOX_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	if ObjectExists id=<anchor_id>
		DestroyScreenElement id=<anchor_id>
	endif

	SetScreenElementLock id=root_window off
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=<anchor_id>
		pos=<pos>
		dims=(640, 480)
		scale=<scale>
		z_priority=<z_priority>
	}

	// set the other button events if we got them
	if not GotParam no_pad_choose
		SetScreenElementProps {
			id=<anchor_id>
			event_handlers=[ { pad_choose	<pad_choose_script> params={current_step=<instruction_step> instruction_set=<instruction_set> exit_script=<exit_script> instruction_last=<instruction_last> <pad_choose_params> } } ]
			replace_handlers
		}
	endif
	if GotParam pad_back_script
		SetScreenElementProps {
			id=<anchor_id>
			event_handlers=[ { pad_back		generic_menu_pad_back params={callback=<pad_back_script> current_step=<instruction_step> instruction_set=<instruction_set> anchor_id=<anchor_id> exit_script=<exit_script> <pad_back_params> } } ]
			replace_handlers
		}
	endif

	// steal the start key unless we're not supposed to
	if not GotParam no_pad_start
		SetScreenElementProps {
			id=root_window
			event_handlers=[ { pad_start 		<pad_choose_script> params={current_step=<instruction_step> instruction_set=<instruction_set> exit_script=<exit_script> instruction_last=<instruction_last> <pad_choose_params> }  } ]
			replace_handlers
		}
	endif

	// bottom element
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>

		pos=<pos>
		just=[center bottom]
		texture=dialog_frame_b
		scale=( (1, 0) * <bg_x_scale> + (0, 1) )
		rgba=<bg_rgba>
	}

	//title text
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>

		font=dialog
		;dims=( (249, 0) * <bg_x_scale> )
		pos=(320, 240)
		just=[center top]
		text=<title_text>
		internal_scale=.85
		internal_just=[center bottom]
		rgba=<off_rgba>
		scale=1.5

		allow_expansion
	}
	<title_textblock> = <id>
	GetScreenElementDims id=<title_textblock>
	<title_height>=<height>

	// text
	CreateScreenElement {
		type=TextBlockElement
		parent=<anchor_id>

		shadow
		shadow_offs=(1, 1)
		shadow_rgba=[10 10 10 100]
		font=<font>
		dims=( (249, 0) * <bg_x_scale> )
		pos=(0, 0)
		just=[center top]
		text=<text>
		internal_scale=.85
		internal_just=[center bottom]
		rgba=<text_rgba>
		scale=1

		allow_expansion
	}
	<speech_text> = <id>

	GetScreenElementDims id=<speech_text>

	// move the text up
	SetScreenElementProps {
		id=<speech_text>
		pos=( <pos> - (0, 16) - ( (0, 1) * <height> ) )
	}

	GetScreenElementPosition id=<speech_text>
	// move the title text up
	SetScreenElementProps {
		id=<title_textblock>
		pos=( <pos> - (0,1)*(<height>+<title_height>) - (0, 16))
	}

	// speech text bg
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>

		texture=dialog_middle
		pos=( <pos> - (0, 16) )
		scale=( ( (1, 0) * <bg_x_scale> ) + (0, 1)*(<height>+<title_height>)/16 )
		just=[center bottom]
		rgba=<bg_rgba>
	}

	// top element
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>

		pos=( <pos> - (0, 16) - (0, 1)*(<height>+<title_height>) )
		just=[center bottom]
		texture=dialog_frame
		scale=( (1, 0) * <bg_x_scale> + (0, 1) )
		rgba=<bg_rgba>
	}

	if GotParam style
		RunScriptOnScreenElement id=<anchor_id> <style> params=<...>
	endif

	if GotParam enter_script
		<enter_script> parent=<anchor_id> <...>
	endif

	FireEvent type=focus target=<anchor_id>

	if GotParam pause_input
		SpawnScript TemporarilyDisableInput params={ time=<pause_input_time> }
	endif

endscript

script DrawInstructionLine

	if ScreenElementExists id=instruction_line
		KillSpawnedScript name=DrawInstructionLine
		DestroyScreenElement id=instruction_line
	endif

	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetScreenElementLock off id=<parent>
	CreateScreenElement {
		type=SpriteElement
		parent=<parent>
		id=instruction_line

		texture=streak_2
		rgba=<on_rgba>
		just=[left center]
		pos=(0,0)
		scale=1
		z_priority=30
		rot_angle=0
		alpha=0
	}

	wait 1 gameframe

	// line
	begin
		// get absolute pos of star
		;GetScreenElementProps id=level_select_map_anchor
		;map_anchor_pos=<pos>

		;star_absolute_pos = (<star_pos> + <map_anchor_pos>)

		// get absolute pos of menu item
		;GetScreenElementProps id=level_select_anchor_middle
		;middle_anchor_pos=<pos>

		;GetScreenElementProps id=level_select_scrolling_menu
		;scrolling_menu_pos=<pos>

		;GetScreenElementProps id=level_select_vmenu
		;vmenu_pos=<pos>

		;item_absolute_pos = ( <middle_anchor_pos> + <scrolling_menu_pos> + <vmenu_pos> + <menu_item_pos> )

		// relative pos of item to star
		;relative_pos = ( <item_absolute_pos> - <star_absolute_pos> )
		relative_pos = ( <to> - <from> )

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
				id=instruction_line

				pos=<to>
				scale=<line_scale>
				rot_angle=<line_angle>
				alpha=0.6
			}
		endif

		wait 1 gameframe
	repeat
endscript

script show_pic_example parent=speech_box_anchor

	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	//pic container
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=pic_anchor
		pos=(<pos> + (180,260) )
		dims=(640, 480)
		z_priority=20
	}

	get_default_face_texture_name
	<head_test>=<textureName>

	//	FormatText ChecksumName=head_test "CS_NSN_facemap_male"

	//pic frame
	CreateScreenElement {
		type=SpriteElement
		parent=pic_anchor
		pos=(0, 0)
		texture=white2
		scale=12.5
		rgba=<on_rgba>
	}

	//pic
	CreateScreenElement {
		type=SpriteElement
		parent=pic_anchor
		pos=(0, 0)
		texture=cas_texture_from_profile;<head_test>
		scale=0.75
		z_priority=30
		;rgba=<on_rgba>
	}

	GetScreenElementPosition id=pic_anchor
	;SpawnScript DrawInstructionLine params={from=<ScreenElementPos> to=(<pos> + (150,250) ) parent=pic_anchor}

endscript

script hide_pic_example

	if ObjectExists id=pic_anchor
		DestroyScreenElement id=pic_anchor
	endif

endscript

script show_pic_phone parent=speech_box_anchor

	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	//pic container
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=pic_anchor
		pos=(<pos> + (242,240) )
		dims=(640, 480)
		z_priority=20
	}

	FormatText ChecksumName=phone "nokia_phone"


	//pic
	CreateScreenElement {
		type=SpriteElement
		parent=pic_anchor
		pos=(0, 0)
		texture=<phone>
		scale=1.1
		z_priority=29
		rot_angle=-15
		rgba=<on_rgba>
	}

	//pic
	CreateScreenElement {
		type=SpriteElement
		parent=pic_anchor
		pos=(0, 0)
		texture=<phone>
		scale=1.0
		z_priority=30
		rot_angle=-15
		;rgba=<on_rgba>
	}

	GetScreenElementPosition id=pic_anchor
	;SpawnScript DrawInstructionLine params={from=<ScreenElementPos> to=(<pos> + (150,250) ) parent=pic_anchor}

endscript

script hide_pic_phone

	if ObjectExists id=pic_anchor
		DestroyScreenElement id=pic_anchor
	endif

endscript
