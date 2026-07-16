// Edit tricks menu!

// globals used for keeping track of what item you
// were focused on
edit_tricks_menu_1_index = 0
edit_tricks_menu_2_index = 0

loading_cat_from_edit_tricks=0

// main edit tricks menu
script create_edit_tricks_menu
	pulse_blur
	hide_current_goal
	if ScreenElementExists id=edit_tricks_menu_parts_anchor
		DestroyScreenElement id=edit_tricks_menu_parts_anchor
	endif
	
	change loading_cat_from_edit_tricks=0
	dialog_box_exit
    
	FormatText ChecksumName=title_icon "%i_trick" i=(THEME_PREFIXES[current_theme_prefix])
	<firefight_active> = 0
	if GoalManager_GoalExists name=firefight
		if GoalManager_GoalIsActive name=firefight
			<firefight_active> = 1
		endif
	endif
	if ( <firefight_active> = 1 )
		make_new_themed_sub_menu title="VIEW TRICKS" title_icon=<title_icon>
	else
		if GoalManager_HasActiveGoals
			make_new_themed_sub_menu title="VIEW TRICKS" title_icon=<title_icon>
		else
			<trick_attack_active> = 0
			if GoalManager_GoalExists name=trickattack
				if GoalManager_GoalIsActive name=trickattack
					<trick_attack_active> = 1
				endif
			endif
			if ( <trick_attack_active> = 1 )
				make_new_themed_sub_menu title="VIEW TRICKS" title_icon=<title_icon>
			else
				make_new_themed_sub_menu title="EDIT TRICKS" title_icon=<title_icon>
			endif
		endif
	endif	
	
	if not LevelIs load_skateshop
		PauseMusicAndStreams 1
		pause_menu_gradient on
	else
		;skater:remove_skater_from_world
	endif
	
    // TODO: temp event handlers for testing
	if GotParam from_ss_menu
		SetScreenElementProps {
			id=sub_menu
			event_handlers=[ { pad_back generic_menu_pad_back params={ callback=edit_tricks_menu_exit from_ss_menu } }
						     ;{ pad_back	generic_menu_pad_back_sound }
						   ]
			replace_handlers
		}
	else
		SetScreenElementProps {
			id=sub_menu
			event_handlers=[ { pad_back generic_menu_pad_back params={ callback=edit_tricks_menu_exit }}
							 ;{ pad_back	generic_menu_pad_back_sound }
						   ]
			replace_handlers
		}
	endif
	
	theme_menu_add_item {
		first_item
		text="Grab Tricks"
		pad_choose_script=create_edit_tricks_sub_menu
		pad_choose_params={ type=grab_tricks }
		centered=1
	}
	theme_menu_add_item {
		text="Flip Tricks"
		pad_choose_script=create_edit_tricks_sub_menu
		pad_choose_params={ type=flip_tricks }
		centered=1
	}
	theme_menu_add_item {
		text="Lip Tricks"
		pad_choose_script=create_edit_tricks_sub_menu
		pad_choose_params={ type=lip_tricks }
		centered=1
	}
	theme_menu_add_item {
		text="Special Tricks"
		pad_choose_script=create_edit_tricks_sub_menu
		pad_choose_params={ type=special_tricks }
		centered=1
	}
	if not InNetGame
		<has_active_goals> = 0
		if GoalManager_HasActiveGoals
			<has_active_goals> = 1
		else
			if GoalManager_GoalExists name=trickattack
				if GoalManager_GoalIsActive name=trickattack
					<has_active_goals> = 1
				endif
			endif
		endif
		if not ( <has_active_goals> = 1 )
			theme_menu_add_item {
				centered=1
				text="Load Created Trick"
				pad_choose_script=launch_load_cat_sequence2
				pad_choose_params={ }
			}
		endif
	endif
    if GotParam from_ss_menu
		theme_menu_add_item {
			text="Done"
			pad_choose_script=edit_tricks_menu_exit
			pad_choose_params={ from_ss_menu }
			last_item
			centered=1
			last_menu_item=1
		}
	else
		theme_menu_add_item {
			text="Done"
			pad_choose_script=edit_tricks_menu_exit
			last_item
			centered=1
			last_menu_item=1
		}
	endif
	
	finish_themed_sub_menu
    
	if LevelIs load_skateshop
		// rotating bg effect
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
	endif
endscript


// edit tricks submenu
script create_edit_tricks_sub_menu
	pulse_blur
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	

	GoalManager_HidePoints
	GoalManager_HideGoalPoints
	
	SetScreenElementLock id=root_window off
	
	// figure out some stuff based on the type
	switch <type>
	case grab_tricks
		<title>					= "GRAB TRICKS"
		<icon_texture>			= pa_grab
		<key_combo_array>		= edit_tricks_menu_grab_key_combos
		<trick_type>			= GrabTrick
		<vertical_bar_offset>	= (75, 17)
		<key_combo_highlight_bar_scale>	= (3.9, 0.7)
		<key_combo_highlight_bar_pos>=(140, -10)
		<key_combo_short_highlight_bar_scale> = (1, 0.7)
        <key_combo_short_highlight_bar_pos>=(-42, -10)
		<trick_highlight_bar_scale> = (2.9, 0.7)
		FormatText ChecksumName=title_icon "%i_grab" i=(THEME_PREFIXES[current_theme_prefix])
	case flip_tricks
		<title>					= "FLIP TRICKS"
		<icon_texture>			= pa_flip
		<key_combo_array>		= edit_tricks_menu_flip_key_combos
		<trick_type>			= FlipTrick
		<vertical_bar_offset>	= (75, 17)
		<key_combo_highlight_bar_scale>	= (3.9, 0.7)
		<key_combo_highlight_bar_pos>=(140, -10)
		<key_combo_short_highlight_bar_scale> = (1, 0.7)
        <key_combo_short_highlight_bar_pos>=(-42, -10)
		<trick_highlight_bar_scale> = (2.9, 0.7)
		FormatText ChecksumName=title_icon "%i_flip" i=(THEME_PREFIXES[current_theme_prefix])
	case lip_tricks
		<title>					= "LIP TRICKS"
		<icon_texture>			= pa_lip
		<key_combo_array>		= edit_tricks_menu_lip_key_combos
		<trick_type>			= LipMacro2
		<vertical_bar_offset>	= (75, 17)
		<key_combo_highlight_bar_scale>	= (3.9, 0.7)
		<key_combo_highlight_bar_pos>=(140, -10)
		<key_combo_short_highlight_bar_scale> = (1, 0.7)
		<key_combo_short_highlight_bar_pos>=(-42, -10)
		<trick_highlight_bar_scale> = (2.9, 0.7)
		FormatText ChecksumName=title_icon "%i_lip" i=(THEME_PREFIXES[current_theme_prefix])
	case special_tricks
		<title>					= "SPECIAL TRICKS"
		<icon_texture>			= pa_special
		<vertical_bar_offset>	= (30, 17)
		<trick_type>			= special_tricks
		FormatText ChecksumName=title_icon "%i_special" i=(THEME_PREFIXES[current_theme_prefix])
	endswitch

	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=edit_tricks_sub_menu_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	AssignAlias id=edit_tricks_sub_menu_anchor alias=current_menu_anchor
	
	<firefight_active> = 0
	if GoalManager_GoalExists name=firefight
		if GoalManager_GoalIsActive name=firefight
			<firefight_active> = 1
		endif
	endif
	if ( <firefight_active> = 1 )
		create_helper_text generic_helper_text_no_accept
	else
		if GoalManager_HasActiveGoals
			create_helper_text generic_helper_text_no_accept
		else
			<trick_attack_active> = 0
			if GoalManager_GoalExists name=trickattack
				if GoalManager_GoalIsActive name=trickattack
					<trick_attack_active> = 1
				endif
			endif
			if ( <trick_attack_active> = 1 )
				create_helper_text generic_helper_text_no_accept
			else
				create_helper_text generic_helper_text
			endif
		endif
	endif
	
    build_theme_sub_title title=<title> title_icon=<title_icon>
	
	
	if LevelIs load_skateshop
		// rotating bg effect
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
	endif
	
	
	CreateScreenElement {
		type=ContainerElement
		parent=edit_tricks_sub_menu_anchor
		id=edit_tricks_menu_parts_anchor
		
		dims=(640, 480)
		pos=(320, 840)
	}
    
	if LevelIs load_skateshop
		build_top_and_bottom_blocks
		make_mainmenu_3d_plane
		// define root position
		<root_pos> = (40, -2)
		// theme background
		theme_background width=6 pos=(320,63) num_parts=10.5 parent=edit_tricks_menu_parts_anchor
	else
		FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
		build_theme_box_icons icon_texture=<paused_icon>
		build_grunge_piece
		build_top_bar pos=(0, 62)
		// define root position
		<root_pos> = (40, 20)
		// theme background
		theme_background width=6 pos=(320,85) num_parts=10.5 parent=edit_tricks_menu_parts_anchor
	endif
	
	AssignAlias id=edit_tricks_menu_parts_anchor alias=current_menu_anchor
	
    // container taking the place of title that everything was anchored off
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu_anchor
		id=edit_tricks_sub_menu_title
        pos=( <root_pos> + (80,70) )
	}
	
	// throw in a bar for the double tap header info
	GetStackedScreenElementPos Y id=<id> offset=(-53, -5)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=black
		pos=<pos>
		just=[left top]
		
		scale=(126, 7)
		rgba=[0 0 0 128]
		z_priority=2
	}
	
    // first vmenu
	GetStackedScreenElementPos Y id=edit_tricks_sub_menu_title offset=(60, 42)
	CreateScreenElement {
		type=VMenu
		parent=current_menu_anchor
		id=edit_tricks_menu_1
		
		pos=<pos>
		just=[left top]
		event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=edit_tricks_sub_menu_exit }}
						 { pad_up 		generic_menu_up_or_down_sound params={ up } }
						 { pad_down		generic_menu_up_or_down_sound params={ down } }
						 { pad_back		generic_menu_pad_back_sound }
						 { focus		edit_tricks_menu_create_current_mapping_list params={ key_combo_array=<key_combo_array> type=<type> } }
						 { unfocus		edit_tricks_menu_destroy_current_mapping_list }
					   ]
		dont_allow_wrap
	}
	
	// vertical bar separating two menus
	// alphaed to zero for now...
	GetStackedScreenElementPos Y id=edit_tricks_sub_menu_title offset=<vertical_bar_offset>
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=edit_tricks_menu_vertical_bar
		
		texture=black
		rgba=[0 0 0 128]
		scale=(2, 70)
		pos=<pos>
		just=[left top]
		z_priority=4
	}
	<vertical_bar_id> = <id>
		
	// trick list scrolling menu
	GetStackedScreenElementPos X id=<vertical_bar_id> offset=(8, 24)
	CreateScreenElement {
		type=VScrollingMenu 
		parent=current_menu_anchor

		pos=<pos>
		just=[left top]
		dims=(400, 240)
		internal_just=[left top]
	}
	
	<vscrolling_menu_id> = <id>
	
	// trick list vmenu
	CreateScreenElement {
		type=VMenu
		parent=<vscrolling_menu_id>
		id=edit_tricks_menu_2
		
		pos=(0, 0)
		just=[left top]
		dont_allow_wrap
		
		event_handlers=[ { focus		edit_tricks_menu_show_on_focus }
						 { unfocus		edit_tricks_menu_hide_on_unfocus params=<unfocus_params> }
						 { pad_back		edit_tricks_menu_back_from_trick_list }
						 { pad_up 		set_which_arrow params={ arrow=edit_tricks_menu_up_arrow } }
						 { pad_down		set_which_arrow params={ arrow=edit_tricks_menu_down_arrow } }
						 { pad_up 		generic_menu_up_or_down_sound params={ up } }
						 { pad_down		generic_menu_up_or_down_sound params={ down } }
						 { pad_back		generic_menu_pad_back_sound }
                       ]
	}
	edit_tricks_menu_2:SetTags scrolling_parent=<vscrolling_menu_id>
		
	// branch off for special tricks menu
	if ( <trick_type> = special_tricks )
		create_special_tricks_menu
		return
	endif	
	
	// up arrow
	GetStackedScreenElementPos X id=<vertical_bar_id> offset=(48, 5)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=edit_tricks_menu_up_arrow
		
		texture=up_arrow
		pos=<pos>
		just=[left top]
		scale=.9
		rgba=[128 128 128 0]
		z_priority=3
	}
	// down arrow
	GetStackedScreenElementPos Y id=<id> offset=(0, 245)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=edit_tricks_menu_down_arrow
		
		texture=down_arrow
		pos=<pos>
		just=[left top]
		scale=.9
		rgba=[128 128 128 0]
		z_priority=4
	}
	
	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// key combo header info
	GetStackedScreenElementPos Y id=edit_tricks_sub_menu_title offset=(-7, -2)
	CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor
		
		font=dialog
		text="Combo"
		scale=.9
		pos=<pos>
		just=[left top]
		rgba=<text_rgba>
		z_priority=3
	}
	
	// double tap info text
	if ( <type> = lip_tricks )
		<tap_info_text> = "Trick"
	else
		<tap_info_text> = "Single tap / Double tap"
	endif
	
	GetStackedScreenElementPos X id=<vertical_bar_id> offset=(5, -18)
	CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor
		id=double_tap_info
		
		font=dialog
		text=<tap_info_text>
		rgba=<text_rgba>
		pos=<pos>
		scale=.9
		just=[left top]
		z_priority=3
	}
		
	// add the key combos
	if GotParam key_combo_array
		GetArraySize <key_combo_array>
		<index> = 0
		begin
			edit_tricks_sub_menu_add_key_combo {
				key_combo=( <key_combo_array>[<index>] )
				highlight_bar_scale=<key_combo_highlight_bar_scale>
				short_highlight_bar_scale=<key_combo_short_highlight_bar_scale>
				highlight_bar_pos=<key_combo_highlight_bar_pos>
				short_highlight_bar_pos=<key_combo_short_highlight_bar_pos>
			}
			<index> = ( <index> + 1 )
		repeat <array_size>
	endif
	
	// add the list of tricks
	if GotParam trick_type
		if GetConfigurableTricksFromType type=<trick_type> <special>
			
			if GotParam ConfigurableCats
				GetArraySize <ConfigurableCats>
				if ( <array_size> = 0 )
					RemoveParameter ConfigurableCats
				endif
			endif
			
			GetArraySize <ConfigurableTricks>
            <index> = 0	
			if ( <array_size> > 0 )
				begin
					<trick_name> = ( <ConfigurableTricks>[<index>] )
					
                    // check if this trick is locked
					if not TrickIsLocked trick=<trick_name>
						// check if this is the first or last item
						RemoveParameter extra_trick_string
						GetTrickDisplayText trick=<trick_name>
	
						if not ( <type> = lip_tricks )
							if GotParam extra_trick_string
								FormatText TextName=trick_display_text "%f / %s" f=<trick_display_text> s=<extra_trick_string>
							endif
						endif
						
						if ( <index> = ( <array_size> - 1 ) )
							if not GotParam ConfigurableCats
								edit_tricks_sub_menu_add_trick {
									text=<trick_display_text>
									trick=<trick_name>
									focus_params={ last_item highlight_bar_scale=<trick_highlight_bar_scale> }
									pad_choose_params = { new_trick=<trick_name> callback=edit_tricks_menu_back_from_trick_list }
								}
							else
								edit_tricks_sub_menu_add_trick {
									text=<trick_display_text>
									trick=<trick_name>
									focus_params={ highlight_bar_scale=<trick_highlight_bar_scale> }
									pad_choose_params = { new_trick=<trick_name> callback=edit_tricks_menu_back_from_trick_list }
								}
							endif
						else
							if ( <index> = 0 )
								edit_tricks_sub_menu_add_trick {
									text=<trick_display_text>
									trick=<trick_name>
									focus_params={ first_item highlight_bar_scale=<trick_highlight_bar_scale> }
									pad_choose_params = { new_trick=<trick_name> callback=edit_tricks_menu_back_from_trick_list }
								}
							else 
								edit_tricks_sub_menu_add_trick {
									text=<trick_display_text>
									trick=<trick_name>
									focus_params={ highlight_bar_scale=<trick_highlight_bar_scale> }
									pad_choose_params = { new_trick=<trick_name> callback=edit_tricks_menu_back_from_trick_list }
								}
							endif
						endif
						<index> = ( <index> + 1 )
					endif
				repeat <array_size>
				
				if GotParam configurableCats
					// created tricks
					GetArraySize <ConfigurableCats>
					
					if ( <array_size> > 0 )
						
						// add header
						edit_tricks_sub_menu_add_header {
									text="Created Tricks"
								}
					
						index=0
						begin
							
							<cat_num> = ( <ConfigurableCats>[<index>] )
							
							get_CAT_other_param_values trick_index=<cat_num>
							if GotParam name
								printf "name = %n" n=<name>
							else
								name="didn't get name"
							endif
							trick_display_text = <name>
							
							if ( <index> = ( <array_size> - 1 ) )
								edit_tricks_sub_menu_add_trick {
									text=<trick_display_text>
									trick=<trick_display_text>
									focus_params={ last_item highlight_bar_scale=<trick_highlight_bar_scale> }
									pad_choose_params = { new_trick=<cat_num> createdtrick callback=edit_tricks_menu_back_from_trick_list }
								}
							else
								edit_tricks_sub_menu_add_trick {
									text=<trick_display_text>
									trick=<trick_display_text>
									focus_params={ highlight_bar_scale=<trick_highlight_bar_scale> }
									pad_choose_params = { new_trick=<cat_num> createdtrick callback=edit_tricks_menu_back_from_trick_list }
								}
							endif
							<index> = ( <index> + 1 )
						repeat <array_size>
					endif
				endif
				
			endif
		endif		
		// force the menu to update
		SetScreenElementLock id=edit_tricks_menu_2 on
		SetScreenElementLock id=edit_tricks_menu_2 off
		FireEvent type=focus target=edit_tricks_menu_2
		FireEvent type=unfocus target=edit_tricks_menu_2
		edit_tricks_menu_back_from_trick_list
	endif
	
    DoScreenElementMorph id=edit_tricks_menu_parts_anchor pos=(320,240) time=0.2
	AssignAlias id=edit_tricks_sub_menu_anchor alias=current_menu_anchor
	FireEvent type=focus target=edit_tricks_menu_1
	
endscript


// special case for special tricks menu
script create_special_tricks_menu
	// fill the trick list menu
	special_tricks_menu_fill_trick_list
	FireEvent type=unfocus target=edit_tricks_menu_2
	
	// the first menu has a new focus handler
	SetScreenElementProps {
		id=edit_tricks_menu_1
		event_handlers=[ { focus	edit_tricks_menu_special_tricks_focus } ]
		replace_handlers
	}
	
	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentSkaterProfileIndex>
	<index> = 1
	begin
		special_tricks_menu_add_slot index=<index>
		<index> = ( <index> + 1 )
	repeat <max_specials>
	
	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// "Trick" header
	GetStackedScreenElementPos Y id=edit_tricks_sub_menu_title offset=(40, 0)
	CreateScreenElement {
		type=TextElement
		parent=edit_tricks_menu_parts_anchor
		
		font=dialog
		text="Trick"
		scale=.9
		pos=<pos>
		just=[left top]
		rgba=<text_rgba>
		z_priority=3
	}
	
	// "Combo" header
	GetStackedScreenElementPos X id=<id> offset=(260, 0)
	CreateScreenElement {
		type=TextElement
		parent=edit_tricks_menu_parts_anchor
		
		font=dialog
		text="Combo"
		scale=.9
		pos=<pos>
		just=[left top]
		rgba=<text_rgba>
		z_priority=3
	}		
	
	// up arrow
	GetStackedScreenElementPos X id=edit_tricks_menu_vertical_bar offset=(50, 5)
	CreateScreenElement {
		type=SpriteElement
		parent=edit_tricks_menu_parts_anchor
		id=edit_tricks_menu_up_arrow
		
		texture=up_arrow
		pos=<pos>
		just=[left top]
		scale=.9
		rgba=[128 128 128 0]
		z_priority=3
	}
	// down arrow
	GetStackedScreenElementPos Y id=<id> offset=(0, 247)
	CreateScreenElement {
		type=SpriteElement
		parent=edit_tricks_menu_parts_anchor
		id=edit_tricks_menu_down_arrow
		
		texture=down_arrow
		pos=<pos>
		just=[left top]
		scale=.9
		rgba=[128 128 128 0]
		z_priority=4
	}
	
	// vertical bar between second and third vmenu
	GetStackedScreenElementPos X id=edit_tricks_menu_vertical_bar offset=(280, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=edit_tricks_menu_parts_anchor
		id=special_tricks_menu_second_vertical_bar
		
		texture=black
		rgba=[0 0 0 128]
		scale=(2, 70)
		pos=<pos>
		just=[left top]
		z_priority=9
	}

	special_tricks_menu_create_menu_3
	
	DoScreenElementMorph id=edit_tricks_menu_parts_anchor pos=(320,240) time=0.2
	AssignAlias id=edit_tricks_sub_menu_anchor alias=current_menu_anchor
	FireEvent type=focus target=edit_tricks_menu_1
endscript

script special_tricks_menu_create_menu_3
	SetScreenElementLock id=current_menu_anchor off
	
	// kill the arrows
	if ObjectExists id=special_tricks_menu_key_combo_up_arrow
		DestroyScreenElement id=special_tricks_menu_key_combo_up_arrow
	endif
	if ObjectExists id=special_tricks_menu_key_combo_down_arrow
		DestroyScreenElement id=special_tricks_menu_key_combo_down_arrow
	endif
	
	// up arrow
	GetStackedScreenElementPos X id=special_tricks_menu_second_vertical_bar offset=(35, 5)
	CreateScreenElement {
		type=SpriteElement
		parent=edit_tricks_menu_parts_anchor
		id=special_tricks_menu_key_combo_up_arrow
		
		texture=up_arrow
		scale=.9
		pos=<pos>
		just=[left top]
		rgba=[128 128 128 0]
	}
	
	// third scrolling menu
	GetStackedScreenElementPos Y id=special_tricks_menu_key_combo_up_arrow offset=(65, 13)
	CreateScreenElement {
		type=VScrollingMenu
		parent=current_menu_anchor
		id=edit_tricks_menu_3_parent
		
		pos=<pos>
		just=[left top]
		dims=(300, 244)
		internal_just=[left top]
	}
	
	// third vmenu
	CreateScreenElement {
		type=VMenu
		parent=<id>
		id=edit_tricks_menu_3
		
		just=[left top]
		event_handlers=[ { focus		edit_tricks_menu_show_on_focus }
						 { unfocus		edit_tricks_menu_hide_on_unfocus }
						 { pad_back		special_tricks_menu_goto_trick_list }
						 { pad_up 		set_which_arrow params={ arrow=special_tricks_menu_key_combo_up_arrow } }
						 { pad_down		set_which_arrow params={ arrow=special_tricks_menu_key_combo_down_arrow} }
						 { pad_up 		generic_menu_up_or_down_sound params={ up } }
						 { pad_down		generic_menu_up_or_down_sound params={ down } }
						 { pad_back		generic_menu_pad_back_sound }
					   ]
		dont_allow_wrap
	}
	
	// down arrow
	GetStackedScreenElementPos Y id=special_tricks_menu_key_combo_up_arrow offset=(0, 245)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=special_tricks_menu_key_combo_down_arrow
		
		texture=down_arrow
		scale=.9
		pos=<pos>
		just=[left top]
		rgba=[128 128 128 0]
	}
endscript

// creates the list of special tricks currently assigned
script special_tricks_menu_create_current_mapping_list
	printf "special_tricks_menu_create_current_mapping_list"
    if ScreenElementExists id=special_tricks_current_mapping
		DestroyScreenElement id=special_tricks_current_mapping
	endif
	
	// make sure the third menu is hidden
	FireEvent type=unfocus target=edit_tricks_menu_3
	
	SetScreenElementLock id=edit_tricks_menu_parts_anchor off
	
	// create the vmenu to hold everything
	GetStackedScreenElementPos X id=edit_tricks_menu_vertical_bar offset=(0, 10)
	CreateScreenElement {
		type=VMenu
		parent=edit_tricks_menu_parts_anchor
		id=special_tricks_current_mapping
		
		pos=<pos>
		just=[left top]
	}	
	
	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentSkaterProfileIndex>
    <index> = 0
	begin
		special_tricks_menu_add_special_to_mapping index=<index>
		<index> = ( <index> + 1 )
	repeat <max_specials>
	
	edit_tricks_menu_assign_current_menu_alias
	
	// force the menu to update
	;SetScreenElementLock id=edit_tricks_menu_3 on
	;SetScreenElementLock id=edit_tricks_menu_3 off
	;FireEvent type=focus target=edit_tricks_menu_3
	;FireEvent type=unfocus target=edit_tricks_menu_3
endscript
		

// creates the list of tricks currently assigned to the buttons
script edit_tricks_menu_create_current_mapping_list
	if ObjectExists id=edit_tricks_menu_current_mapping
		DestroyScreenElement id=edit_tricks_menu_current_mapping
	endif
	
	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	SetScreenElementLock id=edit_tricks_menu_parts_anchor off
	
	// companion to first vmenu...displays current mapping
	GetStackedScreenElementPos X id=edit_tricks_menu_vertical_bar offset=(10, 27)
	CreateScreenElement {
		type=VMenu
		parent=edit_tricks_menu_parts_anchor
		id=edit_tricks_menu_current_mapping
		
		pos=<pos>
		just=[left top]
	}

	if GotParam key_combo_array
		GetArraySize <key_combo_array>
		<index> = 0
		begin			
			// get the currently bound trick and add to the mapping menu
			CreateScreenElement {
				type=ContainerElement
				parent=edit_tricks_menu_current_mapping
				
				dims=(100, 22)
				;pos=(0, 0)
				;just=[left top]
			}
			
            if GoalManager_GetTrickFromKeyCombo key_combo=( <key_combo_array>[<index>] )
				if not ( <type> = lip_tricks )
					if GotParam extra_trick_string
						FormatText TextName=trick_string "%f / %s" f=<trick_string> s=<extra_trick_string>
					endif
				endif
				
				if GotParam cat_num
					get_CAT_other_param_values trick_index=<cat_num>
					if GotParam name
						printf "name = %n" n=<name>
					else
						name="didn't get name"
					endif
					trick_string = <name>
				endif
				
                CreateScreenElement {
					type=TextElement
					parent=<id>
					
					font=small
					rgba=<text_rgba>
					text=<trick_string>
					pos=(-5, 0)
					scale=.75
					just=[left center]
				}
			endif
			;printstruct <...>
			<index> = ( <index> + 1 )
			RemoveParameter extra_trick_string
			RemoveParameter cat_num
		repeat <array_size>	
	endif
	
	edit_tricks_menu_assign_current_menu_alias
endscript	

script edit_tricks_menu_destroy_current_mapping_list
	if ObjectExists id=edit_tricks_menu_current_mapping
		DestroyScreenElement id=edit_tricks_menu_current_mapping
	endif
endscript

script special_tricks_menu_fill_trick_list
	ForEachIn special_trick_types do=special_tricks_menu_add_type
endscript

// ******************************************
//		add item scripts
// ******************************************

// utility for adding a menu item to the main edit tricks menu
script edit_tricks_menu_add_item { parent=current_menu
								   font=small
								   focus_script=edit_tricks_menu_focus
								   unfocus_script=edit_tricks_menu_unfocus
								   pad_choose_script=nullscript
 								   text_pos=(100, -8)
								   bg_scale=(64, 6)
								   bg_pos=(-30, -18)
								   dims=(100, 24)
								   ;rgba=[88 105 112 128]
								   text_just=[center center]
								 }
	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
								 
	// container for this menu item
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=<id>
		
		dims=<dims>
		event_handlers=[ { focus			<focus_script> 		params=<focus_params> }
						 { unfocus			<unfocus_script> 	params=<unfocus_params> }
						 { pad_choose		generic_menu_pad_choose_sound }
						 { pad_start		generic_menu_pad_choose_sound }
						 { pad_choose		<pad_choose_script>	params=<pad_choose_params> }
						 { pad_start		<pad_choose_script>	params=<pad_choose_params> }
					   ]
		<not_focusable>
	}
	<anchor_id> = <id>
	
    // text
	CreateScreenElement {	
		type=TextElement
		parent=<anchor_id>
		
		font=small
		text=<text>
		pos=<text_pos>
		just=<text_just>
		rgba=<rgba>
		z_priority=4
		scale=<text_scale>
	}
		
	// background
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		
		texture=black
		scale=<bg_scale>
		pos=<bg_pos>
		just=[left top]
		rgba=[0 0 0 85]
		z_priority=0
	}
	// end cap
	<cap_texture> = grungeframe_mid
	if GotParam first_item
		<cap_texture> = grungeframe_top
	else
		if GotParam last_item
			<cap_texture> = grungeframe_bot
		endif
	endif
	GetStackedScreenElementPos X id=<id> offset=(-15, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		
		texture=<cap_texture>
		pos=<pos>
		scale=(1, .75)
		rgba=[128 128 128 70]
		just=[left top]
		z_priority=-1
	}

	if GotParam add_deck_line	
        CreateScreenElement {
			type=SpriteElement
			parent=<anchor_id>
			
			texture=black
			pos=<text_pos>
			scale=(40, 0.25)
			rgba=[18 87 18 128]
			alpha=0
			just=[center top]
			z_priority=5
		}
	endif
endscript

// add a key combo to submenu
script edit_tricks_sub_menu_add_key_combo { pad_choose_script=edit_tricks_menu_goto_trick_list
											highlight_bar_scale=(1, 0.7)
											parent=edit_tricks_menu_1
										  }
	<firefight_active> = 0
	if GoalManager_GoalExists name=firefight
		if GoalManager_GoalIsActive name=firefight
			<firefight_active> = 1
		endif
	endif
	if ( <firefight_active> = 1 )
		pad_choose_script = nullscript
	endif

	if GoalManager_HasActiveGoals
		pad_choose_script = nullscript
	endif
	
	if GoalManager_GoalExists name=trickattack
		if GoalManager_GoalIsActive name=trickattack
			pad_choose_script = nullscript
		endif
	endif
	
	// set the focus params
	if not GotParam focus_params
		focus_params={  highlight_bar_scale=<highlight_bar_scale>
						highlight_bar_pos=<highlight_bar_pos>
					 }
	endif
	
	// unlock the menu just to be safe
	SetScreenElementLock id=<parent> off
	
	// anchor for this element
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		
		dims=(100, 22)
		event_handlers=[ { focus		edit_tricks_menu_key_combo_focus params=<focus_params> }
						 { unfocus		edit_tricks_menu_key_combo_unfocus }
					   ]
		tags={ tag_grid_x=<index> }
		<not_focusable>
	}
	<anchor_id> = <id>

	// set the pad choose params
	if not GotParam pad_choose_params
		pad_choose_params = {
			key_combo=<key_combo>
			index=<index>
			id=<anchor_id>
			highlight_script=edit_tricks_menu_key_combo_focus
			highlight_bar_scale=<short_highlight_bar_scale>
			highlight_bar_pos=<short_highlight_bar_pos>
		}
	endif
	
	// now that we know the id, we can set the pad_choose event
	SetScreenElementProps {
		id=<anchor_id>
		event_handlers= [ { pad_choose	<pad_choose_script> params=<pad_choose_params> }
						  { pad_start	<pad_choose_script> params=<pad_choose_params> }
						  { pad_choose	generic_menu_pad_choose_sound }
						]
	}
		
	if GotParam not_focusable
		<text_rgba> = [70 70 70 90]
	else
		<text_rgba> = [128 128 128 128]
	endif
	
	// key combo text
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small
		text=(goal_tetris_trick_text.<key_combo>)
		rgba=<text_rgba>
		scale=.7
		
		pos=(0, 0)
		just=[right center]
		z_priority=4
	}
endscript

// add a trick to the sub menu
script edit_tricks_sub_menu_add_trick pad_choose_script=edit_tricks_menu_bind_trick
	
	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// container
	CreateScreenElement {
		type=ContainerElement
		parent=edit_tricks_menu_2
		
		dims=(400, 24)
		event_handlers=[ { focus		edit_tricks_menu_focus params=<focus_params> }
						 { unfocus		edit_tricks_menu_unfocus params={ rgba=<text_rgba> } }
						 { pad_choose	<pad_choose_script> params=<pad_choose_params> }
						 { pad_start	<pad_choose_script> params=<pad_choose_params> }
						 { pad_choose	generic_menu_pad_choose_sound }
					   ]
	}
	<anchor_id> = <id>
	
	// text
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small
		text=<text>
		pos=(0, 0)
		just=[left top]
		rgba=<text_rgba>
		scale=.75
	}
endscript

script edit_tricks_sub_menu_add_header
	
	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// container
	CreateScreenElement {
		type=ContainerElement
		parent=edit_tricks_menu_2
		
		dims=(400, 24)
		not_focusable
	}
	<anchor_id> = <id>
	
	// text
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small
		text=<text>
		pos=(0, 0)
		just=[left top]
		rgba=<text_rgba>
		scale=.75
	}
	
	// box
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		
        texture=white2
		pos=(-10, 0)
		just=[left top]
		rgba=[0 0 0 100]
		scale=(46,2.25)
		z_priority=2
	}
endscript
	

// add a special trick num
script special_tricks_menu_add_slot { pad_choose_script=special_tricks_menu_goto_trick_list
									  highlight_bar_scale=(3.9, 0.7)
									  highlight_bar_pos=(-105, -18)
									}	
	<firefight_active> = 0
	if GoalManager_GoalExists name=firefight
		if GoalManager_GoalIsActive name=firefight
			<firefight_active> = 1
		endif
	endif
	if ( <firefight_active> = 1 )
		pad_choose_script = nullscript
	endif
	
	if GoalManager_HasActiveGoals
		pad_choose_script = nullscript
	endif
	
	if GoalManager_GoalExists name=trickattack
		if GoalManager_GoalIsActive name=trickattack
			pad_choose_Script = nullscript
		endif
	endif
	
	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// container for this element
	CreateScreenElement {
		type=ContainerElement
		parent=edit_tricks_menu_1
		dims=(40, 22)
		event_handlers=[ { focus		edit_tricks_menu_focus params={ highlight_bar_pos=<highlight_bar_pos> highlight_bar_scale=<highlight_bar_scale> first_item last_item no_arrows } }
						 { unfocus		edit_tricks_menu_unfocus params={ rgba=[90 90 90 100] } }
						 { pad_choose	<pad_choose_script> params={ highlight_script=edit_tricks_menu_focus highlight_bar_scale=(0.6, 0.7) highlight_bar_pos=<highlight_bar_pos> index=<index> } }
						 { pad_start	<pad_choose_script> params={ highlight_script=edit_tricks_menu_focus highlight_bar_scale=(0.6, 0.7) highlight_bar_pos=<highlight_bar_pos> index=<index> } }
						 { pad_choose	generic_menu_pad_choose_sound }
					   ]
		tags={ tag_grid_x=<index> }
	}
	<anchor_id> = <id>
	
	// index text
	FormatText TextName=slot_num "%s-" s=<index>
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small
		text=<slot_num>
		pos=(-60, -5)
		just=[center center]
		rgba=<unhighlight_color>
		z_priority=4
		scale=0.75
	}
	
	// highlight bar
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		texture=de_highlight_bar
		pos=(-105, -10)
		just=[center center]
		rgba=[128 128 128 0]
		scale=<highlight_bar_scale>
		z_priority=3
	}
	
	;DoScreenElementMorph id=<id> pos=(-105,-20) time=0
endscript

script special_tricks_menu_add_special_to_mapping
	printf "special_tricks_menu_add_special_to_mapping"
    GetSpecialTrickInfo index=<index>
    
	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// container
	CreateScreenElement {
		type=ContainerElement
		parent=special_tricks_current_mapping
		
		dims=(40, 22)
	}
	<anchor_id> = <id>
	
	if ( <special_trickname> = Unassigned )
		<trick_display_text> = "Unassigned"
	else
		if ( <isCat> = 1 )
			get_CAT_other_param_values trick_index=<special_trickname>
			if GotParam name
				printf "name = %n" n=<name>
			else
				name="didn't get name"
			endif
			trick_display_text = <name>
		else
			GetTrickDisplayText trick=<special_trickname>
		endif
	endif
	
	if ( <special_trickslot> = Unassigned )
		<special_trickslot_text> = ""
	else
		<special_trickslot_text> = ( goal_tetris_trick_text.<special_trickslot> )
	endif
	
	
	// trick name
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small
		scale=.75
		text=<trick_display_text>
		pos=(10, 0)
		just=[left top]
		rgba=<unhighlight_color>
	}
	
	// trick text
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small
		scale=.75
		text=<special_trickslot_text>
		pos=(320, 0)
		just=[left top]
	}
endscript

// adds a group of special tricks organized by type
script special_tricks_menu_add_type
	printf "special_tricks_menu_add_type"
    GetConfigurableTricksFromType type=<type> special
	
	SetScreenElementLock id=edit_tricks_menu_2 off
	
	// add the header
	// container
	CreateScreenElement {
		type=ContainerElement
		parent=edit_tricks_menu_2
		
		dims=(40, 24)
		not_focusable
	}
	<anchor_id> = <id>
	// text
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=dialog
		text=<Heading>
		rgba=[100 100 100 100]
		pos=(0, 0)
		scale=.9
		just=[left top]
		z_priority=2
	}
	// bg 
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		
		texture=black
		rgba=[0 0 0 128]
		scale=(71, 6)
		pos=(-10, 0)
		just=[left top]
		z_priority=1
	}
	
	if not GotParam add_cats
		GetArraySize <ConfigurableTricks>
		<index> = 0
		begin
			if ( ( <index> = 0 ) && ( <type> = FlipTrick ) )
				<first_item> = first_item
			else
				RemoveParameter first_item
				if ( ( <index> = ( <array_size> - 1 ) ) && ( <type> = Manual ) )
					;<last_item> = last_item
				else
					RemoveParameter last_item
				endif
			endif
			
			is_trick_locked trick=( <ConfigurableTricks>[<index>] )
            if ( <trick_is_locked> = 0 )
				special_tricks_menu_add_trick {
					trick=( <ConfigurableTricks>[<index>] )
					type=<type>
					first_item=<first_item>
					last_item=<last_item>
				}
			endif
			
			<index> = ( <index> + 1 )
		repeat <array_size>
	 else
		if GotParam configurableCats
			// created tricks
			GetArraySize <ConfigurableCats>
			
			if ( <array_size> > 0 )
				index=0
				begin
                    <cat_num> = ( <ConfigurableCats>[<index>] )
					
					get_CAT_other_param_values trick_index=<cat_num>
					if GotParam name
						printf "name = %n" n=<name>
					else
						name="didn't get name"
					endif
					trick_display_text = <name>
					
					if ( <index> = ( <array_size> - 1 ) )
						special_tricks_menu_add_trick {
							text=<trick_display_text>
							trick=<trick_display_text>
							type=CAT
							cat_num=<cat_num>
							last_item=last_item
							;focus_params={ last_item highlight_bar_scale=<trick_highlight_bar_scale> }
							;pad_choose_params = { new_trick=<cat_num> createdtrick callback=edit_tricks_menu_back_from_trick_list }
						}
					else
						special_tricks_menu_add_trick {
							text=<trick_display_text>
							trick=<trick_display_text>
							type=CAT
							cat_num=<cat_num>
							;focus_params={ highlight_bar_scale=<trick_highlight_bar_scale> }
							;pad_choose_params = { new_trick=<cat_num> createdtrick callback=edit_tricks_menu_back_from_trick_list }
						}
					endif
					<index> = ( <index> + 1 )
				repeat <array_size>
			endif
		endif
	endif
	
	// create a spacer before the next group
	CreateScreenElement {
		type=ContainerElement
		parent=edit_tricks_menu_2
		
		dims=(40, 24)
		not_focusable
	}
endscript

script is_trick_locked
	if not GotParam trick
		return
	endif
	
	skater = ((<trick>.Params).skater)
	
	if not GotParam skater
		return trick_is_locked = 0
	endif
	
	GetArraySize master_skater_list
	index=0
	begin
		name = ((master_skater_list[<index>]).name)
		if ( <name> = <skater> )
			flag = ((master_skater_list[<index>]).unlock_flag)
			break
		endif
		index=(<index> + 1)
	repeat <array_size>
	
	if GetGlobalFlag flag=<flag>
		return trick_is_locked = 0
	else
		return trick_is_locked = 1
	endif
endscript

// adds an idividual special trick to the list of all special tricks
script special_tricks_menu_add_trick
	// check if it's the first or last item
	if GotParam first_item
		focus_params={ first_item }
	else
		if GotParam last_item
			focus_params={ last_item }
		endif
	endif
	
	// container for this element
	
	// figure the id for this trick
	if not ( <type> = CAT )
		trick_name_string = ( <trick>.params.name )
	else
		trick_name_string = <text>
	endif
	;FormatText ChecksumName=trick_name_checksum "%s" s=<trick_name_string>
	;if ScreenElementExists id=<trick_name_checksum>
	;	return
	;endif
	; printstruct <...>
	CreateScreenElement {
		type=ContainerElement
		parent=edit_tricks_menu_2
		;id=<trick_name_checksum>
		
		dims=(40, 24)
	}
	<anchor_id> = <id>
	
	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
		
	// set the events
	SetScreenElementProps {
		id=<anchor_id>
		event_handlers=[ { focus		special_tricks_menu_focus params=<focus_params> }
						 { unfocus		special_tricks_menu_unfocus params={ rgba=[90 90 90 100] } }
						 { pad_choose	special_tricks_menu_select_trick params={ rgba=<highlight_color> highlight_bar_scale=(2.25, 0.7) trick=<trick> type=<type> id=<anchor_id> cat_num=<cat_num> } }
						 { pad_start	special_tricks_menu_select_trick params={ rgba=<highlight_color> highlight_bar_scale=(2.25, 0.7) trick=<trick> type=<type> id=<anchor_id> cat_num=<cat_num> } }
						 { pad_choose	generic_menu_pad_choose_sound }
					   ]
	}
	
    FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	if not ( <type> = CAT )
		GetTrickDisplayText trick=<trick>
	else
		trick_display_text=<text>
	endif
	// text
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small
		text=<trick_display_text>
		rgba=<unhighlight_color>
		pos=(0, 0)
		just=[left top]
		scale=.8
	}
endscript

// ******************************************
//	 animation and event handling scripts
// ******************************************

// focus script for main edit tricks menu
script edit_tricks_menu_focus highlight_bar_scale=(1, 0.7) highlight_bar_pos=(-10, -2)
	;printf "script edit_tricks_menu_focus"
	GetTags
	SetScreenElementLock id=<id> off
	
	KillSpawnedScript name=do_random_effect
	KillSpawnedScript name=text_twitch_effect2
	
	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// reusing this script in the board shop!
	if GotParam flagged_deck
		RunScriptOnScreenElement id={ <id> child=0 } do_scale_up params={ rgba=[99 121 6 128] }
		;SetScreenElementProps id={<id> child=0} rgba=<highlight_color>
	else
		RunScriptOnScreenElement id={ <id> child=0 } text_twitch_effect3
		SetScreenElementProps id={<id> child=0} rgba=<highlight_color>
	endif
	
	// highlight bar
	if ObjectExists id=edit_tricks_menu_highlight_bar
		DestroyScreenElement id=edit_tricks_menu_highlight_bar
	endif	
    
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// reduce angle for wider highlight bars
	highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )
	if ( <highlight_bar_scale>.(1,0) > 1 )
		highlight_angle=(<highlight_angle> / ( <highlight_bar_scale>.(1,0) ) )
	endif
    
	CreateScreenElement {
		type=SpriteElement
		parent=<id>
		id=edit_tricks_menu_highlight_bar
		
		texture=de_highlight_bar
		rgba=<bar_rgba>
		pos=<highlight_bar_pos>
		just=[left top]
		scale=<highlight_bar_scale>
		z_priority=3
		rot_angle=<highlight_angle>
	}
	
	if not GotParam no_arrows
		// update the up arrow
		if ObjectExists id=edit_tricks_menu_up_arrow
			if GotParam first_item
				SetScreenElementProps {
					id=edit_tricks_menu_up_arrow
					rgba=[128 128 128 0]
				}
			else
				SetScreenElementProps {
					id=edit_tricks_menu_up_arrow
					rgba=[128 128 128 85]
				}
			endif
		endif
		
		if ObjectExists id=edit_tricks_menu_down_arrow
			if GotParam last_item
				SetScreenElementProps {
					id=edit_tricks_menu_down_arrow
					rgba=[128 128 128 0]
				}
			else
				SetScreenElementProps {
					id=edit_tricks_menu_down_arrow
					rgba=[128 128 128 85]
				}
			endif
		endif
		
		//blinking arrows
		if ( ObjectExists id=edit_tricks_menu_up_arrow )
			AssignAlias id=edit_tricks_menu_2 alias=current_menu
			edit_tricks_menu_2:GetTags
			if GotParam arrow_id
				menu_vert_blink_arrow { id=<arrow_id> } 
			endif
		endif
	endif
endscript

// unfocus script for main edit tricks menu
script edit_tricks_menu_unfocus
	GetTags
	
	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	KillSpawnedScript name=text_twitch_effect3
	DoScreenElementMorph id={ <id> child=0 } scale=1 relative_scale
	
	// reusing this script in the board shop!
	if GotParam flagged_deck
		RunScriptOnScreenElement id={ <id> child=0 } do_scale_down params={ rgba=[25 83 67 128] no_sound }
		;SetScreenElementProps id={<id> child=0} rgba=<unhighlight_color>
	else
        ;RunScriptOnScreenElement id={ <id> child=0 } do_scale_down params={ rgba=<rgba> no_sound }
		SetScreenElementProps id={<id> child=0} rgba=<unhighlight_color>
	endif
	
	// highlight bar
	if ObjectExists id=edit_tricks_menu_highlight_bar
		DestroyScreenElement id=edit_tricks_menu_highlight_bar
	endif
endscript

script special_tricks_menu_focus highlight_bar_scale=(2.25, 0.7)
	GetTags
	
	// text effect
	RunScriptOnScreenElement id={ <id> child=0 } text_twitch_effect3
	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetScreenElementProps id={ <id> child=0 } rgba=<highlight_color>
	
	SetScreenElementLock id=<id> off
	
	// highlight bar
	highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )
	highlight_angle=(<highlight_angle> / ( <highlight_bar_scale>.(1,0) ) )
    
    FormatText ChecksumName=bar_color "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	CreateScreenElement {
		type=SpriteElement
		parent=<id>
		
		texture=de_highlight_bar
		pos=(135, 10)
		rgba=<bar_color>
		scale=<highlight_bar_scale>
		just=[center center]
		rot_angle=<highlight_angle>
	}
	
	// update the up arrow
	if ObjectExists id=edit_tricks_menu_up_arrow
		if GotParam first_item
			SetScreenElementProps {
				id=edit_tricks_menu_up_arrow
				rgba=[128 128 128 0]
			}
		else
			SetScreenElementProps {
				id=edit_tricks_menu_up_arrow
				rgba=[128 128 128 85]
			}
		endif
	endif
	
	if ObjectExists id=edit_tricks_menu_down_arrow
		if GotParam last_item
			SetScreenElementProps {
				id=edit_tricks_menu_down_arrow
				rgba=[128 128 128 0]
			}
		else
			SetScreenElementProps {
				id=edit_tricks_menu_down_arrow
				rgba=[128 128 128 85]
			}
		endif
	endif

	//blinking arrows
    if ScreenElementExists id=edit_tricks_menu_up_arrow
		AssignAlias id=edit_tricks_menu_2 alias=current_menu
		edit_tricks_menu_2:GetTags
		
		if GotParam first_item
			SetScreenElementProps id=<scrolling_parent> reset_window_top
		endif
		if GotParam last_item
			SetScreenElementProps id=<scrolling_parent> reset_window_bottom
		endif
					
		if not GotParam first_item
			if not GotParam last_item
				if GotParam arrow_id
					menu_vert_blink_arrow { id=<arrow_id> } 
				endif
			endif
		endif
	endif
endscript

script special_tricks_menu_unfocus
	GetTags
	
	// text
	KillSpawnedScript name=text_twitch_effect3
	DoScreenElementMorph id={ <id> child=0 } scale=1 relative_scale
	
	FormatText ChecksumName=unhighlight_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetScreenElementProps id={ <id> child=0 } rgba=<unhighlight_color>

	DestroyScreenElement id={ <id> child=1 }	
endscript

script edit_tricks_menu_key_combo_focus highlight_bar_pos=(-42, -10)
	GetTags
	
	FormatText ChecksumName=bar_color "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )
	highlight_angle=(<highlight_angle> / ( <highlight_bar_scale>.(1,0) ) )
    
	// text
	if GotParam rgba
		DoScreenElementMorph {
			id={ <id> child=0 }
			rgba=<rgba>
			;scale=1.2
			relative_scale
		}
	endif
	
	RunScriptOnScreenElement id={ <id> child=0 } text_twitch_effect2 params={ scale=1.2 scale2=1.25 }
	
    SetScreenElementLock id=<id> off
	// highlight bar
	CreateScreenElement {
		type=SpriteElement
		parent=<id>
		id=key_combo_highlight_bar
		
		texture=de_highlight_bar
		scale=<highlight_bar_scale>
		pos=<highlight_bar_pos>
		just=[center top]
		rgba=<bar_color>
		z_priority=3
		rot_angle=<highlight_angle>
	}
	
    // update the arrows if necessary
	if GotParam up_arrow_id
		if GotParam first_item
			SetScreenElementProps {
				id=<up_arrow_id>
				rgba=[128 128 128 0]
			}
		else
			SetScreenElementProps {
				id=<up_arrow_id>
				rgba=[128 128 128 85]
			}
		endif
	endif
	
	if GotParam down_arrow_id
		if GotParam last_item
			SetScreenElementProps {
				id=<down_arrow_id>
				rgba=[128 128 128 0]
			}
		else
			SetScreenElementProps {
				id=<down_arrow_id>
				rgba=[128 128 128 85]
			}
		endif
	endif
	
	//special blinking arrows
	if (ObjectExists id=special_tricks_menu_key_combo_up_arrow )
		AssignAlias id=edit_tricks_menu_3 alias=current_menu
		edit_tricks_menu_3:GetTags
			
		if GotParam arrow_id
			menu_vert_blink_arrow { id=<arrow_id> } 
		endif
	endif
    
endscript

script edit_tricks_menu_key_combo_unfocus
	GetTags
	
	KillSpawnedScript name=text_twitch_effect2
	
	DoScreenElementMorph {
		id={ <id> child=0 }
		scale=1
		relative_scale
	}
	
	// highlight bar
	if ObjectExists id=key_combo_highlight_bar
		DestroyScreenElement id=key_combo_highlight_bar
	endif
endscript

// moving forward from first menu to trick list
script edit_tricks_menu_goto_trick_list
	// unfocus the first menu
	FireEvent type=unfocus target=edit_tricks_menu_1
	
	// store the index of the last item in focus
	edit_tricks_menu_1_index = <index>

	// store the key combo
	if GotParam key_combo
		SetScreenElementProps {
			id=edit_tricks_menu_2
			tags={ new_key_combo=<key_combo> }
		}
	endif
	
	// make sure the item stays highlighted
	if GotParam highlight_script
		RunScriptOnScreenElement id=<id> <highlight_script> params={ highlight_bar_scale=<highlight_bar_scale> }
	endif
	
	// focus on the second menu
	FireEvent type=focus target=edit_tricks_menu_2
endscript

script edit_tricks_menu_special_tricks_focus
	special_tricks_menu_create_current_mapping_list
endscript

// this goes forward from the special trick mapping
// to the list of available tricks
script special_tricks_menu_goto_trick_list
	GetTags
	
    // kill any temp highlight bar (this will be present
	// if we're coming back from the third menu)
	if ObjectExists id=special_tricks_temp_trick_highlight_bar
		DestroyScreenElement id=special_tricks_temp_trick_highlight_bar
	endif
	if GotParam element_to_unfocus
		SetScreenElementProps {
			id=<element_to_unfocus>
			rgba=[90 90 90 100]
		}
	endif
	
	if ObjectExists id=special_tricks_current_mapping
		DestroyScreenElement id=special_tricks_current_mapping
	endif
	
	FireEvent type=unfocus target=edit_tricks_menu_1
	
	// store the index
	if GotParam index
		// decrement the index by 1 to get the array index
		SetScreenElementProps {
			id=edit_tricks_menu_2
			tags={ index=( <index> - 1 ) }
		}
	endif
	
	// make sure the item stays highlighted
	if GotParam highlight_script
		RunScriptOnScreenElement id=<id> <highlight_script> params={ highlight_bar_pos=<highlight_bar_pos> highlight_bar_scale=<highlight_bar_scale> }
	endif
	
	// force the vmenu to update
	SetScreenElementLock id=edit_tricks_menu_2 on
	SetScreenElementLock id=edit_tricks_menu_2 off
	
	// focus on the second menu	
	FireEvent type=unfocus target=edit_tricks_menu_3
	
	// figure the id of the trick we want
	if GotParam index
		GetSpecialTrickInfo index=( <index> - 1 )
		if ( <special_trickslot> = Unassigned )
			FireEvent type=focus target=edit_tricks_menu_2
		else
			if ( <isCat> = 1 )
                get_CAT_other_param_values trick_index=<special_trickname>
				if GotParam name
					printf "name = %n" n=<name>
				else
					name="didn't get name"
				endif
				special_trickname_string = <name>
			else
				<special_trickname_string> = ( (<special_trickname>).params.name )
			endif
			FormatText ChecksumName=special_trickname_checksum "%s" s=<special_trickname_string>
			FireEvent type=focus target=edit_tricks_menu_2 data={ child_id=<special_trickname_checksum> }
		endif
	else
		FireEvent type=focus target=edit_tricks_menu_2
 	endif
endscript

// pad_back from the trick list menu
script edit_tricks_menu_back_from_trick_list
	if ObjectExists id=key_combo_highlight_bar
		DestroyScreenElement id=key_combo_highlight_bar
	endif
	
	FireEvent type=unfocus target=edit_tricks_menu_2
	
	if ObjectExists id=edit_tricks_menu_1
		FireEvent type=focus target=edit_tricks_menu_1 data={ grid_index=edit_tricks_menu_1_index }
	endif
	
	// hide the arrows
	if ObjectExists id=edit_tricks_menu_up_arrow
		SetScreenElementProps {
			id=edit_tricks_menu_up_arrow
			rgba=[128 128 128 0]
		}
	endif
	if ObjectExists id=edit_tricks_menu_down_arrow
		SetScreenElementProps {
			id=edit_tricks_menu_down_arrow
			rgba=[128 128 128 0]
		}
	endif
endscript

// bind a trick to a new key combo
script edit_tricks_menu_bind_trick
	printf "edit_tricks_menu_bind_trick"
    
	if not GotParam new_key_combo
		edit_tricks_menu_2:GetTags
	endif
	
	// TODO: temp safety catch
	if not GotParam new_key_combo
		printf "no new_key_combo"
		return
	endif
	if not GotParam new_trick
		printf "no new_trick"
		return
	endif
	
	if InSplitScreenGame
		<update_mappings> = 0
	else
		<update_mappings> = 1
	endif
	
    if GotParam special	// trick is a special
			if GoalManager_GetTrickFromKeyCombo special key_combo=<new_key_combo>
				printf "special key combo already bound"
				// this key combo is mapped to another trick
				// unmap the old trick using this key combo
				BindTrickToKeyCombo {
					special
					index=<current_index>
					key_combo=Unassigned
					trick=Unassigned
					update_mappings=<update_mappings>
				}
			endif
			if GetKeyComboBoundToTrick special trick=<new_trick> cat_num=<new_trick>
				// this trick is mapped to another key combo
				// unbind the other one
				BindTrickToKeyCombo {
					special
					index=<current_index>
					key_combo=Unassigned
					trick=Unassigned
					update_mappings=<update_mappings>
				}
			endif
	else
			if not GotParam createdtrick	// new trick is not a CAT
				if GetKeyComboBoundToTrick trick=<new_trick> cat_num=<new_trick>
					printf "trick already bound 1"
					// this trick is mapped to another key combo
					if GoalManager_GetTrickFromKeyCombo key_combo=<new_key_combo>
						printf "rebinding 1"
						BindTrickToKeyCombo {
							key_combo=<current_key_combo>
							trick=<trick_checksum>
							trick=<cat_num>
							update_mappings=<update_mappings>
						}
					endif
				endif
			else
                if GetKeyComboBoundToTrick trick=<new_trick> cat_num=<new_trick>
					printf "trick already bound 2"			
					if GoalManager_GetTrickFromKeyCombo key_combo=<new_key_combo>
						printf "rebinding 2"
                        if GotParam trick_checksum
							BindTrickToKeyCombo {
								key_combo=<current_key_combo>
								trick=<trick_checksum>
								;trick=<new_trick>
								update_mappings=<update_mappings>
							}
						endif
					endif
				endif	
			endif
	endif
    
    if GotParam special
		if GotParam createdtrick
			printf "binding new special created trick"
            BindTrickToKeyCombo {
				special
				index=<index>
				key_combo=<new_key_combo>
				trick=<new_trick>
				update_mappings=<update_mappings>
				cat
			}
		else
			printf "binding new special trick"
			BindTrickToKeyCombo {
				special
				index=<index>
				key_combo=<new_key_combo>
				trick=<new_trick>
				update_mappings=<update_mappings>
			}
		endif
	else
		printf "binding new trick"
		BindTrickToKeyCombo {
			key_combo=<new_key_combo>
			trick=<new_trick>
			update_mappings=<update_mappings>
		}
	endif
	
	GetCurrentSkaterProfileIndex
	if InSplitScreenGame
		printf "in a split screen game"
	else
		UpdateTrickMappings skater=<currentSkaterProfileIndex>
	endif
	
    GoalManager_ReplaceTrickText all
	
    if GotParam callback
		<callback>
	endif
endscript


// selects a special trick to bind
script special_tricks_menu_select_trick
	printf "special_tricks_menu_select_trick"
    
	// unfocus the trick list
	FireEvent type=unfocus target=edit_tricks_menu_2
	
	// bring it back
	DoScreenElementMorph {
		id=edit_tricks_menu_2
		alpha=1
	}
	
	if GotParam id
		// make the text the highlight color
		FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
		SetScreenElementProps {
			id={ <id> child=0 }
			rgba=<highlight_color>
		}
		
		// remember the id of this element so we can unfocus it later
		SetScreenElementProps {
			id=edit_tricks_menu_3
			event_handlers=[ { pad_back		special_tricks_menu_goto_trick_list params={ element_to_unfocus=<id> } } ]
			replace_handlers
		}
		
		FormatText ChecksumName=bar_color "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
		highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )
		highlight_angle=(<highlight_angle> / ( <highlight_bar_scale>.(1,0) ) )
        
		// create a temp highlight bar
		CreateScreenElement {
			type=SpriteElement
			parent=<id>
			id=special_tricks_temp_trick_highlight_bar
			
			texture=de_highlight_bar
			pos=(-10, -1)
			rgba=<bar_color>
			scale=<highlight_bar_scale>
			just=[left top]
			rot_angle=<highlight_angle>
		}
	endif
	
	// clear out the key combo list
	DestroyScreenElement id=edit_tricks_menu_3_parent
	special_tricks_menu_create_menu_3
	
	// remember the trick
	edit_tricks_menu_3:SetTags trick=<trick>
	
	// bring up a list of valid key combos
	switch <type>
	case FlipTrick
	case GrabTrick
	case CAT
		<key_combo_array> = special_trick_air_key_combos
	case LipMacro2
		<key_combo_array> = special_trick_lip_key_combos
	case GrindTrick
		<key_combo_array> = special_trick_grind_key_combos
	case Manual
		<key_combo_array> = special_trick_manual_key_combos
	default
		printstruct <...>
		script_assert "Unknown type"		
	endswitch
	
	printf "type = %i" i=<type>
	if ( <type> = CAT )
		printf "type = cat"
		pad_choose_params={ createdtrick=createdtrick
							cat_num=<cat_num>
						  }							  
	else
		printf "type doesn't = cat"
		pad_choose_params={ }							  
	endif
	
	GetArraySize <key_combo_array>
	<key_combo_index> = 0
	begin
		if ( <key_combo_index> = 0 )
			<first_item> = first_item
		else
			if ( <key_combo_index> = ( <array_size> - 1 ) )
				<last_item> = last_item
			endif
		endif
		
		if GoalManager_GetTrickFromKeyCombo special key_combo=( <key_combo_array>[<key_combo_index>] )
            // get the index of the slot they're changing
			edit_tricks_menu_2:GetTags
			GetSpecialTrickInfo index=<index>
            if not ( <special_trickslot> = ( <key_combo_array>[<key_combo_index>] ) )
				<not_focusable> = not_focusable
			endif
		endif
		
        edit_tricks_sub_menu_add_key_combo {
			key_combo=( <key_combo_array>[<key_combo_index>] )
			parent=edit_tricks_menu_3
			pad_choose_script=special_tricks_menu_select_key_combo
			focus_params={ highlight_bar_scale=(1, 0.7)
						   up_arrow_id=special_tricks_menu_key_combo_up_arrow
						   down_arrow_id=special_tricks_menu_key_combo_down_arrow
						   key_combo=( <key_combo_array>[<key_combo_index>] )
						   <first_item>
						   <last_item>
						 }
			pad_choose_params={ <pad_choose_params>
								id=<anchor_id>
								highlight_script=edit_tricks_menu_key_combo_focus
								highlight_bar_scale=<short_highlight_bar_scale>
                                key_combo=( <key_combo_array>[<key_combo_index>] )
								index=<key_combo_index>
							  }
			not_focusable=<not_focusable>
		}
		
		RemoveParameter first_item
		RemoveParameter last_item
		RemoveParameter not_focusable
		
		<key_combo_index> = ( <key_combo_index> + 1 )
	repeat <array_size>
	
	SetScreenElementLock id=edit_tricks_menu_3 on
	SetScreenElementLock id=edit_tricks_menu_3_parent on
	FireEvent type=focus target=edit_tricks_menu_3
endscript

script special_tricks_menu_select_key_combo
	// get the index
	edit_tricks_menu_2:GetTags
	
	// get the trick
	edit_tricks_menu_3:GetTags
	
	printf "special_tricks_menu_select_key_combo"
	
	if not GotParam createdtrick
		edit_tricks_menu_bind_trick new_key_combo=<key_combo> new_trick=<trick> index=<index> special
	else
		edit_tricks_menu_bind_trick new_key_combo=<key_combo> new_trick=<cat_num> index=<index> special createdtrick
	endif
    
	special_tricks_menu_goto_trick_list
	edit_tricks_menu_back_from_trick_list
endscript

// focus shows the element
script edit_tricks_menu_show_on_focus
    GetTags
	DoMorph alpha=1
endscript

// hides the element
script edit_tricks_menu_hide_on_unfocus
	DoMorph alpha=0
	
	// hide all arrows
	if ObjectExists id=special_tricks_menu_key_combo_up_arrow
		SetScreenElementProps {
			id=special_tricks_menu_key_combo_up_arrow
			rgba=[128 128 128 0]
		}
	endif
	if ObjectExists id=special_tricks_menu_key_combo_down_arrow
		SetScreenElementProps {
			id=special_tricks_menu_key_combo_down_arrow
			rgba=[128 128 128 0]
		}
	endif
	if ObjectExists id=edit_tricks_menu_up_arrow
		SetScreenElementProps {
			id=edit_tricks_menu_up_arrow
			rgba=[128 128 128 0]
		}
	endif
	if ObjectExists id=edit_tricks_menu_down_arrow
		SetScreenElementProps {
			id=edit_tricks_menu_down_arrow
			rgba=[128 128 128 0]
		}
	endif
endscript

// makes the focused menu the current menu
script edit_tricks_menu_assign_current_menu_alias
	if not GotParam id
		GetTags
	endif
	AssignAlias id=<id> alias=current_menu
endscript

// ****************************************
//			exit scripts
// ****************************************

// exit main edit tricks menu
script edit_tricks_menu_exit
	if GotParam just_remove
		if ScreenElementExists id=current_menu_anchor
			DestroyScreenElement id=current_menu_anchor
		endif
		if ScreenElementExists id=edit_tricks_sub_menu_anchor
			DestroyScreenElement id=edit_tricks_sub_menu_anchor
		endif
		return
	endif
	
    if LevelIs Load_Skateshop
		skater:add_skater_to_world
		restore_start_key_binding
		MakeSkaterGoto SkaterSelectAI
        launch_ss_menu no_animate
	else
		restore_start_key_binding
		
		if inNetGame
			create_pause_menu
		else
			edit_skater_options_menu
		endif
			
	endif
endscript

// exit edit tricks submenu
script edit_tricks_sub_menu_exit
	if ObjectExists id=edit_tricks_sub_menu_anchor
		DestroyScreenElement id=edit_tricks_sub_menu_anchor
		wait 1 frame
	endif
	
	GoalManager_ShowPoints
	if not GoalManager_HasActiveGoals
		GoalManager_ShowGoalPoints
	endif
	
	create_edit_tricks_menu
endscript

// ****************************************
// 		trick key combo arrays
// ****************************************

edit_tricks_menu_grab_key_combos = [
	Air_CircleD
	Air_CircleDL
	Air_CircleDR
	Air_CircleL
	Air_CircleR
	Air_CircleU
	Air_CircleUL
	Air_CircleUR
	Air_D_D_Circle
	Air_L_L_Circle
	Air_R_R_Circle
	Air_U_U_Circle
]

edit_tricks_menu_lip_key_combos = [
	Lip_TriangleD
	Lip_TriangleDL
	Lip_TriangleDR
	Lip_TriangleL
	Lip_TriangleR
	Lip_TriangleU
	Lip_TriangleUL
	Lip_TriangleUR
]

edit_tricks_menu_flip_key_combos = [
	Air_SquareD
	Air_SquareDL
	Air_SquareDR
	Air_SquareL
	Air_SquareR
	Air_SquareU
	Air_SquareUL
	Air_SquareUR
	Air_D_D_Square
	Air_L_L_Square
	Air_R_R_Square
	Air_U_U_Square
]

special_trick_types = [
	{ type=FlipTrick	Heading="Air Tricks" }
	{ type=GrabTrick	Heading="Grab Tricks" }
	{ type=LipMacro2	Heading="Lip Tricks" }
	{ type=GrindTrick	Heading="Grind Tricks" }
	{ type=Manual		Heading="Manual Tricks" }
	{ type=GrabTrick	Heading="Created Tricks" add_cats }
]

special_trick_air_key_combos = [
	SpAir_D_L_Circle	
	SpAir_D_R_Circle	
	SpAir_D_U_Circle
	SpAir_L_D_Circle
	SpAir_L_R_Circle
	SpAir_L_U_Circle
	SpAir_R_D_Circle
	SpAir_R_L_Circle
	SpAir_R_U_Circle
	SpAir_U_D_Circle
	SpAir_U_L_Circle
	SpAir_U_R_Circle	
	SpAir_D_L_Square
	SpAir_D_R_Square
	SpAir_D_U_Square
	SpAir_L_D_Square
	SpAir_L_R_Square
	SpAir_L_U_Square
	SpAir_R_D_Square
	SpAir_R_L_Square
	SpAir_R_U_Square
	SpAir_U_D_Square
	SpAir_U_L_Square
	SpAir_U_R_Square
]
	
special_trick_grind_key_combos = [
	SpGrind_D_L_Triangle
	SpGrind_D_R_Triangle
	SpGrind_D_U_Triangle
	SpGrind_L_D_Triangle
	SpGrind_L_R_Triangle
	SpGrind_L_U_Triangle
	SpGrind_R_D_Triangle
	SpGrind_R_L_Triangle
	SpGrind_R_U_Triangle
	SpGrind_U_D_Triangle
	SpGrind_U_L_Triangle
	SpGrind_U_R_Triangle
]

special_trick_lip_key_combos = [
	SpLip_D_L_Triangle
	SpLip_D_R_Triangle
	SpLip_D_U_Triangle
	SpLip_L_D_Triangle
	SpLip_L_R_Triangle
	SpLip_L_U_Triangle
	SpLip_R_D_Triangle
	SpLip_R_L_Triangle
	SpLip_R_U_Triangle
	SpLip_U_D_Triangle
	SpLip_U_L_Triangle
	SpLip_U_R_Triangle
	SpLip_U_U_Triangle
]

special_trick_manual_key_combos = [
	SpMan_D_L_Triangle
	SpMan_D_R_Triangle
	SpMan_D_U_Triangle
	SpMan_L_D_Triangle
	SpMan_L_R_Triangle
	SpMan_L_U_Triangle
	SpMan_R_D_Triangle
	SpMan_R_L_Triangle
	SpMan_R_U_Triangle
	SpMan_U_D_Triangle
	SpMan_U_L_Triangle
	SpMan_U_R_Triangle
]
