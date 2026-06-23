//----------------------------------------
// ARTISTS' TWEAK VALUES

colormenu_bar_scale=(4.4, 2.0)
colormenu_bar_focus_rgba=[128 128 128 118]
colormenu_bar_unfocus_rgba=[40 40 40 118]
colormenu_bar_pos=(12.0, 0.0) //152
colormenu_text_pos=(-102.0, 0.0)
colormenu_spacing_between=25
colormenu_arrow_pos_up=(0, 7)
colormenu_arrow_pos_down=(0, -7)
colormenu_arrow_rgba=[128 128 128 128]
colormenu_arrow_scale=0.7
colormenu_wrap_arrow_left=-53.0
colormenu_wrap_arrow_right=80.0
colormenu_nowrap_arrow_left=-53.0
colormenu_nowrap_arrow_right=80.0
colormenu_hue_increment = 5
colormenu_saturation_increment = 3
colormenu_value_increment = 2
colormenu_min_saturation = 0.0
colormenu_max_saturation = 90.0
colormenu_min_value = 12.0
colormenu_max_value = 60.0

//----------------------------------------
// PROGRAMMERS ONLY BELOW HERE

script colormenu_focus rgba=[128 128 128 50]
	GetTags

	FormatText ChecksumName=highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	if GotParam from_caf

		// text
		DoScreenElementMorph {
			id={ <id> child=0 }
			rgba=<highlighted_text_rgba>
			scale=1.1
			relative_scale
		}

		// highlight bar
		SetScreenElementProps {
			id={ <id> child=5 }
			rgba=<bar_rgba>
		}
		RunScriptOnScreenElement id=<id> text_twitch_effect params={no_extra=no_extra}
	else
		RunScriptOnScreenElement id={ <id> child=0 } do_scale_up params={ rgba=<highlighted_text_rgba> }
	endif

	if GotParam pad_left_handler
		SetScreenElementProps {
			id=<id>
			event_handlers=[
				{ pad_left		<pad_left_handler> params=<handler_params> }
			]
			replace_handlers
		}
	endif
	if GotParam pad_right_handler
		SetScreenElementProps {
			id=<id>
			event_handlers=[
				{ pad_right		<pad_right_handler> params=<handler_params> }
			]
			replace_handlers
		}
	endif

	// focus the color bar
	SetScreenElementProps {
		id=<color_bar_id>
		rgba=colormenu_bar_focus_rgba
	}

	// show the arrows
	DoScreenElementMorph {
		id=<down_arrow_id>
		scale=colormenu_arrow_scale
	}
	DoScreenElementMorph {
		id=<up_arrow_id>
		scale=colormenu_arrow_scale
	}

	colormenu_refresh_arrows part=<part>

	generic_menu_update_arrows {
		up_arrow_id = edit_skater_menu_up_arrow
		down_arrow_id = edit_skater_menu_down_arrow
	}

	if ObjectExists id=edit_skater_vmenu
		edit_skater_vmenu:GetTags

		if GotParam arrow_id
			menu_vert_blink_arrow { id=<arrow_id> }
		endif
	endif

endscript

script colormenu_unfocus rgba=[128 128 128 0]
	GetTags

	if GotParam from_caf
		FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
		// de-highlight the item
		KillSpawnedScript name=text_twitch_effect

		// text
		DoScreenElementMorph {
			id={ <id> child=0 }
			rgba=<text_rgba>
			alpha=<text_alpha>
			scale=1
			relative_scale
		}


		// highlight bar
		SetScreenElementProps {
			id={ <id> child=5 }
			rgba=[128 128 128 0]
		}
	else
		RunScriptOnScreenElement id={ <id> child=0 } do_scale_down
	endif

	// unfocus the color bar
	SetScreenElementProps {
		id=<color_bar_id>
		rgba=colormenu_bar_unfocus_rgba
	}

	DoScreenElementMorph {
		id=<down_arrow_id>
		scale=0.0
	}
	DoScreenElementMorph {
		id=<up_arrow_id>
		scale=0.0
	}
endscript

script colormenu_get_default_color
	if not GotParam part
		script_assert "no part parameter"
	endif

	if not GotParam desc_id
		script_assert "no desc_id parameter"
	endif

	GetActualCASOptionStruct part=<part> desc_id=<desc_id>
	if GotParam default_h
		<h> = <default_h>
	else
		<h> = 0
	endif

	if GotParam default_s
		<s> = <default_s>
	else
		<s> = 50
	endif

	if GotParam default_v
		<v> = <default_v>
	else
		<v> = 50
	endif

	return h=<h> s=<s> v=<v>
endscript

script colormenu_get_hsv
	GetCurrentSkaterProfileIndex
	GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=<part>

	if not GotParam use_default_hsv
		<use_default_hsv> = 1
	endif

	if not GotParam h
		<h> = 0
	endif

	if not GotParam s
		<s> = 0
	endif

	if not GotParam v
		<v> = 0
	endif

	if ( <use_default_hsv> = 1 )
		colormenu_get_default_color part=<part> desc_id=<desc_id>
	endif

	return h=<h> s=<s> v=<v> use_default_hsv=<use_default_hsv>
endscript

script colormenu_set_hsv use_default_hsv=0
	GetCurrentSkaterProfileIndex
	printf "h=%h s=%s v=%v" h=<h> s=<s> v=<v>
	SetPlayerAppearanceColor player=<currentSkaterProfileIndex> part=<part> h=<h> s=<s> v=<v> use_default_hsv=<use_default_hsv>
endscript

script colormenu_refresh_arrows
	colormenu_get_hsv part=<part>

	/*
	if ( <s> > colormenu_max_saturation )
		<s> = colormenu_max_saturation
	endif
	if ( <s> < colormenu_min_saturation )
		<s> = colormenu_min_saturation
	endif
	if ( <v> > colormenu_max_value )
		<v> = colormenu_max_value
	endif
	if ( <v> < colormenu_min_value )
		<v> = colormenu_min_value
	endif
*/
	sliderbar_rescale_to_bar min=0.0 max=360.0 value=<h> left=colormenu_wrap_arrow_left right=colormenu_wrap_arrow_right
	SetScreenElementProps {
		id=hue_up_arrow
		pos=( (1,0) * <x_val> )
	}
	SetScreenElementProps {
		id=hue_down_arrow
		pos=( (1,0) * <x_val> )
	}

	sliderbar_rescale_to_bar min=colormenu_min_saturation max=colormenu_max_saturation value=<s> left=colormenu_nowrap_arrow_left right=colormenu_nowrap_arrow_right
	SetScreenElementProps {
		id=saturation_up_arrow
		pos=( (1,0) * <x_val> )
	}
	SetScreenElementProps {
		id=saturation_down_arrow
		pos=( (1,0) * <x_val> )
	}

	sliderbar_rescale_to_bar min=colormenu_min_value max=colormenu_max_value value=<v> left=colormenu_nowrap_arrow_left right=colormenu_nowrap_arrow_right
	SetScreenElementProps {
		id=value_up_arrow
		pos=( (1,0) * <x_val> )
	}
	SetScreenElementProps {
		id=value_down_arrow
		pos=( (1,0) * <x_val> )
	}
endscript

script colormenu_refresh_skaters
	GetCurrentSkaterProfileIndex
	RefreshSkaterColors skater=0 profile=<currentSkaterProfileIndex>

	/*
	// kludge to refresh the color of the separate trucks model in the boardshop...
	if LevelIs load_boardshop
		if IsAlive name=TRG_Deck_Main
			colormenu_get_hsv part=board
			if ( <use_default_hsv> = 1 )
				printf "clear color"
				printstruct <...>
				TRG_Deck_MainTrucks:Obj_ClearColor
				TRG_Deck_MainJets:Obj_ClearColor
			else
				printf "set color"
				TRG_Deck_MainTrucks:Obj_SetColor h=<h> s=<s> v=<v>
				TRG_Deck_MainJets:Obj_SetColor h=<h> s=<s> v=<v>
			endif
		endif
	endif*/
endscript

script colormenu_increment_hue
	printf "incrementing hue"

	colormenu_get_hsv part=<part>

	<h> = ( <h> + colormenu_hue_increment )
	if ( <h> > 359 )
		<h> = ( <h> - 360 )
	endif

	colormenu_set_hsv part=<part> h=<h> s=<s> v=<v>

	colormenu_refresh_arrows part=<part>
	colormenu_refresh_skaters
endscript

script colormenu_decrement_hue
	printf "decrementing hue"

	colormenu_get_hsv part=<part>

	<h> = ( <h> - colormenu_hue_increment )
	if ( <h> < 0 )
		<h> = ( <h> + 360 )
	endif

	colormenu_set_hsv part=<part> h=<h> s=<s> v=<v>

	colormenu_refresh_arrows part=<part>
	colormenu_refresh_skaters
endscript

script colormenu_increment_saturation
	printf "incrementing saturation"

	colormenu_get_hsv part=<part>

	<s> = ( <s> + colormenu_saturation_increment )
	if ( <s> > colormenu_max_saturation )
		<s> = colormenu_max_saturation
	endif

	colormenu_set_hsv part=<part> h=<h> s=<s> v=<v>

	colormenu_refresh_arrows part=<part>
	colormenu_refresh_skaters
endscript

script colormenu_decrement_saturation
	printf "decrementing saturation"

	colormenu_get_hsv part=<part>

	<s> = ( <s> - colormenu_saturation_increment )
	if ( <s> < colormenu_min_saturation )
		<s> = colormenu_min_saturation
	endif

	colormenu_set_hsv part=<part> h=<h> s=<s> v=<v>

	colormenu_refresh_arrows part=<part>
	colormenu_refresh_skaters
endscript

script colormenu_increment_value
	printf "incrementing value"

	colormenu_get_hsv part=<part>

	<v> = ( <v> + colormenu_value_increment )
	if ( <v> > colormenu_max_value )
		<v> = colormenu_max_value
	endif

	colormenu_set_hsv part=<part> h=<h> s=<s> v=<v>

	colormenu_refresh_arrows part=<part>
	colormenu_refresh_skaters
endscript

script colormenu_decrement_value
	printf "decrementing value"

	colormenu_get_hsv part=<part>

	<v> = ( <v> - colormenu_value_increment )
	if ( <v> < colormenu_min_value )
		<v> = colormenu_min_value
	endif

	colormenu_set_hsv part=<part> h=<h> s=<s> v=<v>

	colormenu_refresh_arrows part=<part>
	colormenu_refresh_skaters
endscript

script colormenu_reset_to_default
	GetCurrentSkaterProfileIndex
	GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=<part>

	// gets either (0,50,50), or the default color that's specified in the actual desc structure
	colormenu_get_default_color part=<part> desc_id=<desc_id>

	GetCurrentSkaterProfileIndex
	SetPlayerAppearanceColor player=<currentSkaterProfileIndex> part=<part> h=<h> s=<s> v=<v> use_default_hsv=1

	colormenu_refresh_arrows part=<part>
	colormenu_refresh_skaters
endscript

script colormenu_add_options_to_menu

	if not GotParam from_caf
		SetScreenElementProps {
			id=current_menu
			spacing_between = colormenu_spacing_between
		}
	endif

	if GotParam from_cas
		if ((in_deck_design =1) || (in_boardshop = 1))
			create_helper_text generic_helper_text_left_right_up_down
		else
			create_helper_text generic_helper_text_color_menu
		endif
	endif


	sliderbar_add_item {
		text='HUE'
		focus_script=colormenu_focus
		focus_params={
			pad_left_handler=colormenu_decrement_hue
			pad_right_handler=colormenu_increment_hue
			handler_params={part=<part>}
			up_arrow_id=hue_up_arrow
			down_arrow_id=hue_down_arrow
			part=<part>
			color_bar_id=hue_slider_bar
			from_caf=<from_caf>
		}
		unfocus_script=colormenu_unfocus
		unfocus_params={
			up_arrow_id=hue_up_arrow
			down_arrow_id=hue_down_arrow
			color_bar_id=hue_slider_bar
			from_caf=<from_caf>
		}
		pad_choose_script=nullscript
		child_texture=colorbar
		icon_id=hue_slider_bar
		icon_scale=colormenu_bar_scale
		icon_rgba=colormenu_bar_unfocus_rgba
		icon_pos=colormenu_bar_pos
		text_pos=colormenu_text_pos
		text_just=[left center]
		tab=tab3
		anchor_id=hue_anchor
		up_arrow_id=hue_up_arrow
		down_arrow_id=hue_down_arrow
		arrow_pos_up=colormenu_arrow_pos_up
		arrow_pos_down=colormenu_arrow_pos_down
		arrow_rgba=colormenu_arrow_rgba
		text_pos=<text_pos>
		icon_pos=<icon_pos>
		arrow_pos_up=<arrow_pos_up>
		arrow_pos_down=<arrow_pos_down>
		dims=<dims>
	}

	sliderbar_add_item {
		text='SAT.'
		focus_script=colormenu_focus
		focus_params={
			pad_left_handler=colormenu_decrement_saturation
			pad_right_handler=colormenu_increment_saturation
			handler_params={part=<part>}
			up_arrow_id=saturation_up_arrow
			down_arrow_id=saturation_down_arrow
			part=<part>
			color_bar_id=saturation_slider_bar
			from_caf=<from_caf>
		}
		unfocus_script=colormenu_unfocus
		unfocus_params={
			up_arrow_id=saturation_up_arrow
			down_arrow_id=saturation_down_arrow
			color_bar_id=saturation_slider_bar
			from_caf=<from_caf>
		}
		pad_choose_script=nullscript
		child_texture=bw_slider
		icon_id=saturation_slider_bar
		icon_scale=colormenu_bar_scale
		icon_rgba=colormenu_bar_unfocus_rgba
		icon_pos=colormenu_bar_pos
		text_pos=colormenu_text_pos
		text_just=[left center]
		tab=tab3
		anchor_id=saturation_anchor
		up_arrow_id=saturation_up_arrow
		down_arrow_id=saturation_down_arrow
		arrow_pos_up=colormenu_arrow_pos_up
		arrow_pos_down=colormenu_arrow_pos_down
		arrow_rgba=colormenu_arrow_rgba
		text_pos=<text_pos>
		icon_pos=<icon_pos>
		arrow_pos_up=<arrow_pos_up>
		arrow_pos_down=<arrow_pos_down>
		dims=<dims>
	}

	sliderbar_add_item {
		text='VAL.'
		focus_script=colormenu_focus
		focus_params={
			pad_left_handler=colormenu_decrement_value
			pad_right_handler=colormenu_increment_value
			handler_params={part=<part>}
			up_arrow_id=value_up_arrow
			down_arrow_id=value_down_arrow
			part=<part>
			color_bar_id=value_slider_bar
			from_caf=<from_caf>
		}
		unfocus_script=colormenu_unfocus
		unfocus_params={
			up_arrow_id=value_up_arrow
			down_arrow_id=value_down_arrow
			color_bar_id=value_slider_bar
			from_caf=<from_caf>
		}
		pad_choose_script=nullscript
		child_texture=bw_slider
		icon_id=value_slider_bar
		icon_scale=colormenu_bar_scale
		icon_rgba=colormenu_bar_unfocus_rgba
		icon_pos=colormenu_bar_pos
		text_pos=colormenu_text_pos
		text_just=[left center]
		tab=tab3
		anchor_id=value_anchor
		up_arrow_id=value_up_arrow
		down_arrow_id=value_down_arrow
		arrow_pos_up=colormenu_arrow_pos_up
		arrow_pos_down=colormenu_arrow_pos_down
		arrow_rgba=colormenu_arrow_rgba
		text_pos=<text_pos>
		icon_pos=<icon_pos>
		arrow_pos_up=<arrow_pos_up>
		arrow_pos_down=<arrow_pos_down>
		dims=<dims>
	}

	if not GotParam from_caf
		edit_skater_menu_add_item {
			text='Reset to default'
			pad_choose_script=colormenu_reset_to_default
			pad_choose_params={ part=<part> }
			tab=tab3
			dims=(10,30)
		}
	endif
endscript

//////////////////////////////////////////////////////////////////////////////
//	Pos Menu
//////////////////////////////////////////////////////////////////////////////

script posmenu_add_options_to_menu
	SetScreenElementProps {
		id=current_menu
		spacing_between = colormenu_spacing_between
		event_handlers=[
			{ pad_up		null_script}
			{ pad_down		null_script}
		]
		replace_handlers
	}

	material = ((<part>[0]).material)
	pass = ((<part>[0]).pass)

	if GotParam from_cas
		create_helper_text generic_helper_text_color_menu
	endif

	if not GotParam no_pos
		<add_pos> = add_pos
	else
		<add_pos> = <no_pos>
	endif

	if not GotParam no_rot
		<add_rot>=add_rot
	endif
	if not GotParam no_scale
		<add_scale>=add_scale
	endif

	posmenu_add_item {
		part=<part>
		material=<material>
		pass=<pass>
		add_pos = <add_pos>
		add_rot = <add_rot>
		add_scale = <add_scale>
	}
endscript

script posmenu_add_item {  pad_choose_script=null_script
		tab=tab3
		font=small
		icon_scale=0
		icon_pos=(22, 9)
		text_just=[left center]
		text_pos=(0, 0)
		dims=(0,40)
	}

	// abort early if the menu item is not enabled...
	// (later on, should gray it out instead)
	if GotParam is_enabled_script
		<is_enabled_script>
		if ( <success> = 0 )
			return
		endif
	endif

	focus_params = { material=<material> pass=<pass> part=<part> }

	// create a container for this vmenu element
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		id=pos_parts_anchor

		dims=<dims>
		event_handlers=[ { pad_choose	<pad_choose_script> params=<pad_choose_params> }
			{ pad_alt2		posmenu_reset_uv params={ part=<part> } }
			{ pad_up		null_script}
			{ pad_down		null_script}
		]
		<not_focusable>
		z_priority=10
	}

	if (in_deck_design = 1)
		if isNGC
			create_helper_text generic_helper_text_color_menu_reset_cad_ngc
		else
			create_helper_text generic_helper_text_color_menu_reset_cad
		endif
	else
		if isNGC
			create_helper_text generic_helper_text_color_menu_reset_ngc
		else
			create_helper_text generic_helper_text_color_menu_reset
		endif
	endif

	if GotParam add_pos
		posmenu_add_pos_item <...>
	endif

	if GotParam add_rot
		posmenu_add_rotation_item <...>
	endif

	if GotParam add_scale
		posmenu_add_scale_item <...>
	endif

	// not doing this in a focus script because using left analog up down
	// was causing repeated pad_up and pad_down events
	wait 1 gameframe
	posmenu_focus_all_parts <focus_params>
endscript

script posmenu_focus_all_parts
	edit_skater_posmenu_focus <...>
	edit_skater_scalemenu_focus <...>
	edit_skater_rotmenu_focus <...>
endscript

script posmenu_add_pos_item
	// create a container for this vmenu element
	CreateScreenElement {
		type=ContainerElement
		parent=pos_parts_anchor
		id=pos_anchor

		pos=(15,15)
		dims=<dims>
		z_priority=10
	}
	<parent_id> = <id>

	// what's this?
	if GotParam index
		SetScreenElementProps {
			id=<parent_id>
			tags={ tag_grid_x=<index> }
		}
	endif

	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=arrow_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// text
	CreateScreenElement {
		type=TextElement
		parent=<parent_id>

		font=<font>
		text="Pos"
		scale=0.9
		rgba=<rgba>
		just=<text_just>
		pos=(-110, 0)

		replace_handlers
		<not_focusable>
	}

	if isXbox
		text="Left Thumbstick"
		scale=0.67
	else
		if isNGC
			text="Control Stick"
			scale=0.67
		else
			text="Left Analog Stick"
			scale=0.67
		endif
	endif

	// left analog
	CreateScreenElement {
		type=TextElement
		parent=<parent_id>

		font=dialog
		text=<text>
		scale=<scale>
		rgba=<arrow_rgba>
		just=[left top]
		pos=(-110, -42)
	}


	// up arrow
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		id=pos_up_arrow

		texture=up_arrow
		rgba=<rgba>
		scale=1.0
		pos=(20,-30)
		z_priority=5
	}

	// down arrow
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		id=pos_down_arrow

		texture=down_arrow
		rgba=<rgba>
		scale=1.0
		pos=(20,30)
		z_priority=5
	}

	// left arrow
	if not (<add_pos>=use_uv_v_only)
		CreateScreenElement {
			type=SpriteElement
			parent=<parent_id>
			id=pos_left_arrow

			texture=left_arrow
			rgba=<rgba>
			scale=1.0
			pos=(-20,0)
			z_priority=5
		}
	endif

	// right arrow
	if not (<add_pos>=use_uv_v_only)
		CreateScreenElement {
			type=SpriteElement
			parent=<parent_id>
			id=pos_right_arrow

			texture=right_arrow
			rgba=<rgba>
			scale=1.0
			pos=(60,0)
			z_priority=5
		}
	endif

	// get logo
	get_part_current_desc_id part=<part>
	if GotParam current_desc_id
		get_logo_texture part=<part> desc_id=<current_desc_id>

		if ( in_deck_design = 1 )
			scale=1.0
		else
			scale=0.5
		endif

		// show logo
		CreateScreenElement {
			type=SpriteElement
			parent=<parent_id>
			id=pos_logo

			texture=<texture>
			scale=<scale>
			pos=(20,0)
			z_priority=5
		}
	endif
endscript

script swap_deck_layers part1=deck_layer3 part2=deck_layer1
	GetCurrentSkaterProfileIndex

	// get part 1 texture
	current_desc_id=None // default to none in case there is no current_desc_id
	get_part_current_desc_id part=<part1>
	texture1=<current_desc_id>
	// get part 1 uv
	swap_get_uv part=<part1>
	structure1=<structure>
	// get part 1 colors
	colormenu_get_hsv part=<part1> desc_id=<current_desc_id>
	h1=<h> s1=<s> v1=<v> use_default_hsv1=<use_default_hsv>
	;printstruct <...>

	// get part 2 texture
	current_desc_id=None // default to none in case there is no current_desc_id
	get_part_current_desc_id part=<part2>
	texture2=<current_desc_id>
	// get part 2 uv
	swap_get_uv part=<part2>
	structure2=<structure>
	// get part 2 colors
	colormenu_get_hsv part=<part2> desc_id=<current_desc_id>
	h2=<h> s2=<s> v2=<v> use_default_hsv2=<use_default_hsv>

	// set part 1 texture
	EditPlayerAppearance profile=<currentSkaterProfileIndex> target=SetPart targetParams={part=<part1> desc_id=<texture2>}
	// set part 1 uv
	SetPlayerAppearanceUV player=<currentSkaterProfileIndex> part=<part1> <structure2>
	// set part 1 colors
	colormenu_set_hsv part=<part1> h=<h2> s=<s2> v=<v2> use_default_hsv=<use_default_hsv2>

	// set part 2 texture
	EditPlayerAppearance profile=<currentSkaterProfileIndex> target=SetPart targetParams={part=<part2> desc_id=<texture1>}
	// set part 2 uv
	SetPlayerAppearanceUV player=<currentSkaterProfileIndex> part=<part2> <structure1>
	// set part 2 colors
	colormenu_set_hsv part=<part2> h=<h1> s=<s1> v=<v1> use_default_hsv=<use_default_hsv1>

	// refresh skater
	RefreshSkaterModel skater=0 profile=<currentSkaterProfileIndex>

	if GotParam callback
		<callback> <callback_params>
	endif
endscript

script posmenu_get_uv
	GetCurrentSkaterProfileIndex
	GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=<part>

	if not GotParam use_default_uv
		<use_default_uv> = 1
	endif

	if not GotParam uv_u
		<uv_u> = 0
	endif

	if not GotParam uv_v
		<uv_v> = 0
	endif

	if not GotParam uv_scale
		<uv_scale> = 100
	endif

	if not GotParam uv_rot
		<uv_rot> = 0
	endif

	if ( <use_default_uv> = 1 )
		<uv_u> = 0
		<uv_v> = 0
		<uv_scale> = 100
		<uv_rot> = 0
	endif

	return uv_u=<uv_u> uv_v=<uv_v> uv_scale=<uv_scale> uv_rot=<uv_rot> use_default_uv=<use_default_uv>
endscript

script swap_get_uv
	posmenu_get_uv <...>
	RemoveParameter part
	return structure={ <...> }
endscript

script posmenu_set_uv
	GetCurrentSkaterProfileIndex
	SetPlayerAppearanceUV player=<currentSkaterProfileIndex> part=<part> uv_u=<uv_u> uv_v=<uv_v> uv_scale=<uv_scale> uv_rot=<uv_rot> use_default_uv=0
endscript

script posmenu_maybe_reset_uv
	FireEvent type=unfocus target=current_menu
	create_error_box { title="Reset?"
		text="Are you sure you want to reset the adjustments to this item?"

		pad_back_script = dialog_box_exit
		buttons=[ 	{ font=small text="Yes" pad_choose_script=posmenu_reset_uv params={ part=<part> refocus } }
			{ font=small text="No"  pad_choose_script=dialog_box_exit }
		]
	}
	create_helper_text generic_helper_text
endscript

script posmenu_reset_uv
	if isNGC
		if not ControllerPressed L1
			return
		endif
	endif

	GetCurrentSkaterProfileIndex
	SetPlayerAppearanceUV player=<currentSkaterProfileIndex> part=<part> uv_u=0 uv_v=0 uv_scale=100 uv_rot=0 use_default_uv=1

	if ( in_deck_design = 0 )
		no_board=no_board
	endif

	RefreshSkaterModel skater=0 profile=<currentSkaterProfileIndex> no_board=<no_board>
	if GotParam refocus
		FireEvent type=focus target=current_menu
	endif
endscript

script adjust_cas_texture_pos uv_increment = 10
	if not GotParam pass
		return
	endif
	if not GotParam material
		return
	endif

	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	controller=0
	got_controller=0
	begin
		if ControllerBoundToSkater controller=<controller> skater=0
			got_controller=1
			break
		endif
		controller = ( <controller> + 1 )
	repeat	4

	if ( got_controller=0 )
		return
	endif

	begin
		GetAnalogueInfo controller=<controller>

		posmenu_get_uv part=<part>

		<oldU> = <uv_u>
		<oldV> = <uv_v>

		// arrows
		if ObjectExists id=pos_right_arrow
			if ( <leftx> > 0 )
				DoScreenElementMorph id=pos_right_arrow rgba=<on_rgba> scale=1.1
			else
				DoScreenElementMorph id=pos_right_arrow rgba=<off_rgba> scale=1
			endif
		endif

		if ObjectExists id=pos_left_arrow
			if ( 0 > <leftx> )
				DoScreenElementMorph id=pos_left_arrow rgba=<on_rgba> scale=1.1
			else
				DoScreenElementMorph id=pos_left_arrow rgba=<off_rgba> scale=1
			endif
		endif

		if ObjectExists id=pos_down_arrow
			if ( <lefty> > 0 )
				DoScreenElementMorph id=pos_down_arrow rgba=<on_rgba> scale=1.1
			else
				DoScreenElementMorph id=pos_down_arrow rgba=<off_rgba> scale=1
			endif
		endif

		if ObjectExists id=pos_up_arrow
			if ( 0 > <lefty> )
				DoScreenElementMorph id=pos_up_arrow rgba=<on_rgba> scale=1.1
			else
				DoScreenElementMorph id=pos_up_arrow rgba=<off_rgba> scale=1
			endif
		endif

		// deck tilt adjustment
		if not ( in_deck_design = 1 )
			temp = <lefty>
			lefty = (-1*<leftx>)
			leftx = (1*<temp>)
		endif

		// values
		// only adjust uv values that are enabled
		if ObjectExists id=pos_up_arrow
			if ( <leftx> > 0 )
				<uv_v> = ( <uv_v> + (<leftx>*<uv_increment>) )
			endif
		endif

		if ObjectExists id=pos_down_arrow
			if ( 0 > <leftx> )
				<uv_v> = ( <uv_v> + (<leftx>*<uv_increment>) )
			endif
		endif

		if ObjectExists id=pos_right_arrow
			if ( <lefty> > 0 )
				<uv_u> = ( <uv_u> + (<lefty>*<uv_increment>) )
			endif
		endif

		if ObjectExists id=pos_left_arrow
			if ( 0 > <lefty> )
				<uv_u> = ( <uv_u> + (<lefty>*<uv_increment>) )
			endif
		endif

		// limits
		if ( <uv_u> < -200 )
			<uv_u> = 200
		endif

		if ( <uv_u> > 200 )
			<uv_u> = -200
		endif

		if ( <uv_v> < -200 )
			<uv_v> = 200
		endif

		if ( <uv_v> > 200 )
			<uv_v> = -200
		endif

		//		printf "%u %v %x %y" uv_u=<uv_u> uv_v=<uv_v> x=<leftx> y=<lefty>

		// change UV (fast, but doesn't change it permanently in the CAS
		// and possibly suffers from accumulation errors)
		/*if not ( <leftx> = 0 )
			skater:Obj_SetUVOffset u=(-1*(<leftx>/100)) v=0 pass=<pass> material=<material>
		endif

		if not ( <lefty> = 0 )
			skater:Obj_SetUVOffset u=0 v=(<lefty>/100) pass=<pass> material=<material>
		endif
		*/

		// if the UV has changed, then change the model
		if not ( <oldU> = <uv_u> )
			posmenu_set_uv part=<part> <...>
			refresh_skater_uv
		else
			if not ( <oldV> = <uv_v> )
				posmenu_set_uv part=<part> <...>
				refresh_skater_uv
			endif
		endif

		if IsPs2
			wait 4 gameframe
		else
			wait 1 gameframe
		endif
	repeat
endscript

script refresh_skater_uv
	if IsPs2
		// ps2 requires rebuild of the entire skater model,
		// because it stores the UV changes in the geometry
		if ( in_deck_design = 0 )
			no_board=no_board
		endif
		GetCurrentSkaterProfileIndex
		RefreshSkaterModel skater=0 profile=<currentSkaterProfileIndex> no_board=<no_board>
	else
		// xbox and ngc just need to refresh the materials
		GetCurrentSkaterProfileIndex
		RefreshSkaterUV skater=0 profile=<currentSkaterProfileIndex>
	endif
endscript

script edit_skater_posmenu_focus
	if ScreenElementExists id=pos_up_arrow
		RunScriptOnScreenElement id=pos_up_arrow adjust_cas_texture_pos params={ pass=<pass> material=<material> part=<part> }
	endif
endscript

script edit_skater_posmenu_unfocus
	KillSpawnedScript name=adjust_cas_texture_pos
endscript

//////////////////////////////////////////////////////////////////////////////
//	Rotation Menu
//////////////////////////////////////////////////////////////////////////////

script posmenu_add_rotation_item {  pad_choose_script=null_script
		tab=tab3
		font=small
		icon_scale=0
		icon_pos=(22, 9)
		text_just=[left center]
		text_pos=(0, 0)
		dims=(0,40)
		anchor_id=rot_item_anchor
	}
	// abort early if the menu item is not enabled...
	// (later on, should gray it out instead)
	if GotParam is_enabled_script
		<is_enabled_script>
		if ( <success> = 0 )
			return
		endif
	endif

	CreateScreenElement {
		type=ContainerElement
		parent=pos_parts_anchor
		id=rot_anchor
		pos=(0,85)

		dims=<dims>
		z_priority=10
	}

	<parent_id> = <id>

	if GotParam index
		SetScreenElementProps {
			id=<parent_id>
			tags={ tag_grid_x=<index> }
		}
	endif

	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=arrow_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// text
	CreateScreenElement {
		type=TextElement
		parent=<parent_id>

		font=<font>
		text="Rot"
		scale=.9
		rgba=<rgba>
		just=<text_just>
		pos=(-95, 0)

		replace_handlers
		<not_focusable>
	}

	if isXbox
		text="Right Thumbstick"
		scale=0.67
	else
		if isNGC
			text="C-Stick"
			scale=0.67
		else
			text="Right Analog Stick"
			scale=0.67
		endif
	endif

	// right analog
	CreateScreenElement {
		type=TextElement
		parent=<parent_id>

		font=dialog
		text=<text>
		scale=<scale>
		rgba=<arrow_rgba>
		just=[left top]
		pos=(-95, -30)
	}

	// left arrow
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		id=rot_left_arrow

		texture=left_arrow
		rgba=<rgba>
		scale=1.0
		pos=(-33,0)
		z_priority=5
	}

	// right arrow
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		id=rot_right_arrow

		texture=right_arrow
		rgba=<rgba>
		scale=1.0
		pos=(75,0)
		z_priority=5
	}

	// show logo
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		id=rot_logo

		texture=rot_bar
		scale=(1.4,1.0)
		pos=(21,0)
		z_priority=5
	}
endscript

script adjust_cas_texture_rot rot_increment = 20
	if not GotParam pass
		return
	endif
	if not GotParam material
		return
	endif

	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	controller=0
	got_controller=0
	begin
		if ControllerBoundToSkater controller=<controller> skater=0
			got_controller=1
			break
		endif
		controller = ( <controller> + 1 )
	repeat	4

	if ( got_controller=0 )
		return
	endif

	begin
		GetAnalogueInfo controller=<controller>

		posmenu_get_uv part=<part>

		<oldRot> = <uv_rot>

		// arrows
		if ( <rightx> > 0 )
			DoScreenElementMorph id=rot_right_arrow rgba=<on_rgba> scale=1.1
			<uv_rot> = ( <uv_rot> + (<rightx>*<rot_increment>) )
		else
			DoScreenElementMorph id=rot_right_arrow rgba=<off_rgba> scale=1
		endif

		if ( 0 > <rightx> )
			DoScreenElementMorph id=rot_left_arrow rgba=<on_rgba> scale=1.1
			<uv_rot> = ( <uv_rot> + (<rightx>*<rot_increment>) )
		else
			DoScreenElementMorph id=rot_left_arrow rgba=<off_rgba> scale=1
		endif

		// arbitrary limits
		if ( <uv_rot> < 0 )
			<uv_rot> = ( <uv_rot> + 360 )
		endif

		if ( <uv_rot> > 360 )
			<uv_rot> = ( <uv_rot> - 360 )
		endif

		// if the UV has changed, then change the model
		if not ( <oldRot> = <uv_rot> )
			posmenu_set_uv part=<part> <...>
			refresh_skater_uv
		endif

		if IsPs2
			wait 4 gameframe
		else
			wait 1 gameframe
		endif
	repeat

endscript

script edit_skater_rotmenu_focus
	if ScreenElementExists id=rot_left_arrow
		RunScriptOnScreenElement id=rot_left_arrow adjust_cas_texture_rot params={ pass=<pass> material=<material> part=<part> }
	endif
endscript

script edit_skater_rotmenu_unfocus
	KillSpawnedScript name=adjust_cas_texture_rot
endscript

//////////////////////////////////////////////////////////////////////////////
//	Scale Menu
//////////////////////////////////////////////////////////////////////////////

script posmenu_add_scale_item {  pad_choose_script=null_script
		tab=tab3
		font=small
		icon_scale=0
		icon_pos=(22, 9)
		text_just=[left center]
		text_pos=(0, 0)
		dims=(0,40)
		anchor_id=scale_item_anchor
	}

	// abort early if the menu item is not enabled...
	// (later on, should gray it out instead)
	if GotParam is_enabled_script
		<is_enabled_script>
		if ( <success> = 0 )
			return
		endif
	endif

	if not GotParam add_rot
		pos=(0,90)
	else
		pos=(0,115)
	endif

	CreateScreenElement {
		type=ContainerElement
		parent=pos_parts_anchor
		id=scale_anchor
		pos=<pos>

		dims=<dims>
		z_priority=10
	}
	<parent_id> = <id>

	if GotParam index
		SetScreenElementProps {
			id=<parent_id>
			tags={ tag_grid_x=<index> }
		}
	endif

	// add the text
	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=arrow_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])


	//if the rotation item wasn't added, make sure the "right analog" text is still displayed

	if not GotParam add_rot
		// right analog
		if isXbox
			text="Right Thumbstick"
			scale=0.67
		else
			if isNGC
				text="C-Stick"
				scale=0.67
			else
				text="Right Analog Stick"
				scale=0.67
			endif
		endif
		CreateScreenElement {
			type=TextElement
			parent=<parent_id>

			font=dialog
			text=<text>
			scale=<scale>
			rgba=<arrow_rgba>
			just=[left top]
			pos=(-95, -30)
		}
	endif

	// text
	CreateScreenElement {
		type=TextElement
		parent=<parent_id>

		font=<font>
		text="Scale"
		scale=.9
		rgba=<rgba>
		just=<text_just>
		pos=(-95, 0)

		replace_handlers
		<not_focusable>
	}

	// down arrow
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		id=scale_down_arrow

		texture=down_arrow
		rgba=<rgba>
		scale=1.0
		pos=(-30,0)
		z_priority=5
	}

	// up arrow
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		id=scale_up_arrow

		texture=up_arrow
		rgba=<rgba>
		scale=1.0
		pos=(80,0)
		z_priority=5
	}

	// show logo
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		id=scale_logo

		texture=scale_bar
		scale=(1.4,1.0)
		pos=(21,0)
		z_priority=5
	}
endscript

script adjust_cas_texture_scale scale_increment=10
	if not GotParam pass
		return
	endif
	if not GotParam material
		return
	endif

	if StructureContains structure=(<part>[0]) scale_min
		scale_min=((<part>[0]).scale_min)
	else
		scale_min=200
	endif

	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	controller=0
	got_controller=0
	begin
		if ControllerBoundToSkater controller=<controller> skater=0
			got_controller=1
			break
		endif
		controller = ( <controller> + 1 )
	repeat	4

	if ( got_controller=0 )
		return
	endif

	begin
		GetAnalogueInfo controller=<controller>

		posmenu_get_uv part=<part>

		<oldScale> = <uv_scale>

		// GJ:  seems if you want a bigger image, you need smaller UV values...
		// is that right?

		// arrows
		if ( <righty> > 0 )
			DoScreenElementMorph id=scale_down_arrow rgba=<on_rgba> scale=1.1
			<uv_scale> = ( <uv_scale> + (<righty>*<scale_increment>) )
		else
			DoScreenElementMorph id=scale_down_arrow rgba=<off_rgba> scale=1
		endif

		if ( 0 > <righty> )
			DoScreenElementMorph id=scale_up_arrow rgba=<on_rgba> scale=1.1
			<uv_scale> = ( <uv_scale> + (<righty>*<scale_increment>) )
		else
			DoScreenElementMorph id=scale_up_arrow rgba=<off_rgba> scale=1
		endif

		// arbitrary limits
		if ( <uv_scale> < 50 )
			<uv_scale> = 50
		endif

		if ( <uv_scale> > <scale_min> )
			<uv_scale> = <scale_min>
		endif

		// if the UV has changed, then change the model
		if not ( <oldScale> = <uv_scale> )
			posmenu_set_uv part=<part> <...>
			refresh_skater_uv
		endif

		if IsPs2
			wait 4 gameframe
		else
			wait 1 gameframe
		endif
	repeat

endscript

script edit_skater_scalemenu_focus
	if ScreenElementExists id=scale_up_arrow
		RunScriptOnScreenElement id=scale_up_arrow adjust_cas_texture_scale params={ pass=<pass> material=<material> part=<part> }
	endif
endscript

script edit_skater_scalemenu_unfocus
	KillSpawnedScript name=adjust_cas_texture_scale
endscript



