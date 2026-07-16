// high scores menu!
// 
// enter new initials before moving on!
script high_scores_menu_enter_initials
	SetScreenElementLock id=root_window off
	
	PauseGame
	
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	kill_start_key_binding
	
	GoalManager_HidePoints

	GetInitialsString
	
	create_onscreen_keyboard {
		text=<string>
		no_back=no_back
		keyboard_done_script=high_scores_menu_entered_initials
		<...>
		keyboard_title="ENTER INITIALS"
		min_length=1
		max_length=3
	}
endscript

script high_scores_menu_entered_initials
	GetTextElementString id=keyboard_current_string
	
	SetInitialsString string=<string>
	UpdateInitials
	
	destroy_onscreen_keyboard
	high_scores_menu_create new_initials=<string> restart_node=<restart_node>
endscript

// ***********************************
//	menu creation scripts
// ***********************************

script high_scores_menu_create
	SetScreenElementLock id=root_window off
	
	if not GotParam from_options
		PauseGame
	endif
	
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	if ObjectExists id=menu_parts_anchor
		DestroyScreenElement id=menu_parts_anchor
	endif
	
	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu {
		menu_id=high_scores_records_menu
		title="HIGH SCORES"
		title_icon=<title_icon>
		just=[center center]
	}
	AssignAlias id=high_scores_records_menu alias=sub_menu
	kill_start_key_binding
	
	FormatText ChecksumName=on_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=on_icon_color "%i_ICON_ON_VALUE" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	if GotParam from_options
		theme_background parent=sub_menu id=bg_box_vmenu width=5 pos=(320,60) num_parts=11 z_priority=1
        SetScreenElementProps { id=sub_menu
			event_handlers=[ { pad_choose	null_script }
							 { pad_start	null_script }
							 { pad_back		generic_menu_pad_back params={ callback=high_scores_menu_exit from_options } }
							 { pad_left		high_scores_change_level params={ level=<level> level_name=<level_name> minus } }
							 { pad_right	high_scores_change_level params={ level=<level> level_name=<level_name> } }
						   ]
			replace_handlers
		}
		create_helper_text { helper_text_elements=[ { text="\b6/\b5 = Select" }
													{ text="\m1 = Back" }
												  ]
						   }
		
		//top black bar
		CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		
		texture=black
		rgba=[0 0 0 128]
		scale=(110, 6)
		pos=(320,60)
		just=[center top]
		z_priority=1.1
		}
		
		// level
		CreateScreenElement {
			type=TextElement
			parent=sub_menu
			
			font=Dialog
			rgba=<off_color>
			text=<level_name>
			scale=.95
			pos=(320, 63)
			just=[center top]
			
			z_priority=5
		}
		GetScreenElementPosition id=<id>
		GetScreenElementDims id=<id>
		
		// left arrow
		CreateScreenElement {
			type=SpriteElement
			parent=sub_menu
			id=high_scores_left_arrow
			
			texture=left_arrow
			scale=(.7, .6)
			pos=( <ScreenElementPos> - (5, -3) )
			just=[right top]
			rgba=<on_color>
			
			z_priority=5
		}
		
		// right arrow
		CreateScreenElement {
			type=SpriteElement
			parent=sub_menu
			id=high_scores_right_arrow
			
			texture=right_arrow
			scale=(.7, .6)
			pos=( <ScreenElementPos> + <width>*(1,0) + (5,4) )
			just=[left top]
			rgba=<on_color>
			
			z_priority=5
		}
	
		// define a root position
		<root_pos> = (100, 50)
	else
		pause_menu_gradient on  
		theme_background parent=sub_menu id=bg_box_vmenu width=5 pos=(320,85) num_parts=10 z_priority=1
		
		if GotParam from_pause
			SetScreenElementProps { id=sub_menu
				event_handlers=[ { pad_choose	null_script }
								 { pad_back		high_scores_menu_exit params={ from_pause=from_pause } }
								 { pad_start   	null_script }
							   ]
				replace_handlers
			}
		
			create_helper_text  helper_text_elements=[ { text="\m1 = Back" }]
		else
			SetScreenElementProps { id=sub_menu
				event_handlers=[ { pad_choose	high_scores_menu_exit params={ restart_node=<restart_node> } }
								 { pad_start	high_scores_menu_exit params={ restart_node=<restart_node> } }
							   ]
				replace_handlers
			}
			create_helper_text  helper_text_elements=[ { text="\m0 = Continue" } ]
		endif
		
		LoadTexture no_vram_alloc "MainmenuSprites/stat_scores"
		LoadTexture no_vram_alloc "MainmenuSprites/stat_combos"
	
		// define a root position
		<root_pos> = (100, 53)
	endif
		
	//top black bar
		CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		
		texture=black
		rgba=[0 0 0 128]
		scale=(110, 6)
		pos=( <root_pos> + (0, 34) )
		just=[left top]
		z_priority=1.1
		}
	  
	//best high scores header  
	CreateScreenElement {
			type=TextElement
			parent=sub_menu
			
			font=Dialog
			rgba=<on_color>
			text="5 BEST HIGH SCORES"
			scale=1.0
			pos=(<root_pos> + (21, 34))
			just=[left top]
			
			z_priority=5
		}
		
	// start stacking with the icon
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		id=high_scores_menu_icon
		
		texture=black
		pos=<root_pos>
		just=[left top]
		rgba=[127 102 0 128]
		z_priority=2
	}
	
    // line at top of main area
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		
		texture=black
		rgba=[0 0 0 0]
		scale=(97, 1)
		pos=( <root_pos> + (35, 57) )
		just=[left top]
	}
	
	// 5 best high scores icon
	FormatText ChecksumName=stat_scores_icon "stat_scores"
	<five_best_icon_scale> = (1.52, 1.2)
	GetStackedScreenElementPos Y id=<id> offset=(-10, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		id=high_scores_menu_scores_icon
		
		texture=<stat_scores_icon>
		scale=<five_best_icon_scale>
		pos=<pos>
        rgba=<on_icon_color>
		just=[left top]
		z_priority=1
	}
    
	//place/initial divider
		CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		
		texture=black
		rgba=[0 0 0 128]
		scale=(3, 45)
		pos=( <pos> + (140, -4) )
		just=[left top]
		z_priority=1.1
		}
	//initial/score divider
		CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		
		texture=black
		rgba=[0 0 0 128]
		scale=(3, 67)
		pos=( <pos> + (205, -4) )
		just=[left top]
		z_priority=1.1
		}
		
	// horizontal bar between areas
	GetStackedScreenElementPos Y id=high_scores_menu_scores_icon offset=(-4, 1)
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		
		texture=black
		rgba=[0 0 0 128]
		scale=(110, 6)
		pos=(<pos> + (-23,0))
		just=[left top]
		z_priority=1.1
	}
	
	//best combos scores header  
	CreateScreenElement {
			type=TextElement
			parent=sub_menu
			
			font=Dialog
			rgba=<on_color>
			text="5 BEST COMBO SCORES"
			scale=1.0
			pos=(<pos> + (0,0))
			just=[left top]
			
			z_priority=5
		}
	
	// 5 best combos icon
	FormatText ChecksumName=stat_comboss_icon "stat_combos"
	GetStackedScreenElementPos Y id=<id> offset=(2, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		id=high_scores_menu_combos_icon
		
		texture=<stat_comboss_icon>
		scale=<five_best_icon_scale>
        rgba=<on_icon_color>
		pos=(<pos> + (0,0))
		just=[left top]
		z_priority=1
	}		
	
	// bar at the bottom of the 5 best area
	GetStackedScreenElementPos Y id=high_scores_menu_combos_icon offset=(0, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=sub_menu
		id=high_scores_menu_lower_yellow_bar
		
		texture=black
		rgba=<on_color>
		scale=(108, .5)
		pos=(<pos> + (-22,0))
		just=[left top]
	}
	
	// vmenu to hold 5 best high scores
	GetStackedScreenElementPos X id=high_scores_menu_scores_icon offset=(10, -3)
	CreateScreenElement {
		type=VMenu
		parent=sub_menu
		id=high_scores_menu_five_best_high_scores_vmenu
		
		pos=<pos>
		just=[left top]
		internal_just=[left top]
	}
	
	
	// vmenu to hold 5 best combos
	GetStackedScreenElementPos X id=high_scores_menu_combos_icon offset=(10, -3)
	CreateScreenElement {
		type=VMenu
		parent=sub_menu
		id=high_scores_menu_five_best_combos_vmenu
		
		pos=<pos>
		just=[left top]
		internal_just=[left top]
	}

	// vmenu to hold longest trick info
	GetStackedScreenElementPos Y id=high_scores_menu_lower_yellow_bar offset=(0, 0)
	CreateScreenElement {
		type=VMenu
		parent=sub_menu
		id=high_scores_menu_longest_tricks_vmenu
		
		pos=(<pos>+(6,0))
		just=[left top]
		internal_just=[left top]
		z_priority=3
	}
	
	high_scores_menu_fill_menus level=<level> new_initials=<new_initials>
	
	if GotParam no_animate
		finish_themed_sub_menu time=0.0
	else
		finish_themed_sub_menu
	endif
endscript


script high_scores_menu_add_pro_icons
	<alpha> = 70.0
	<floating_point_alpha> = ( ( <alpha> / 128.0 ) * 1.0 )
	
	begin
		if GotParam id
			GetStackedScreenElementPos X id=<id> offset=(10, 0)
		endif
		
		CreateScreenElement {
			type=SpriteElement
			parent=current_menu_anchor
			
			texture=black;pro_thomas
			rgba=[128 128 128 100]
			alpha=<floating_point_alpha>
			scale=.65
			pos=<pos>
			just=[left top]
			z_priority=2
		}
		
		<alpha> = ( <alpha> - 20 )
		<floating_point_alpha> = ( ( <alpha> / 128.0 ) * 1.0 )
	repeat 4
endscript


script high_scores_menu_exit
	
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 gameframe
	endif
	
	if ObjectExists id=menu_parts_anchor
		DestroyScreenElement id=menu_parts_anchor
	endif
	
	if GotParam from_pause
		UnloadTexture  "MainmenuSprites/stat_scores"
		UnloadTexture  "MainmenuSprites/stat_combos"
		goto create_options_menu
	endif
	
	restore_start_key_binding
	
	if GotParam from_options
        create_setup_options_menu
	else
		UnloadTexture  "MainmenuSprites/stat_scores"
		UnloadTexture  "MainmenuSprites/stat_combos"
		GoalManager_ShowPoints
		
		// TT5784: Needed to re-enable vibration after exiting high score menu
		if VibrationIsOn 0
			VibrationOff 0
			VibrationOn 0
		else
			VibrationOff 0
		endif
		
		if GotParam restart_node
			exit_pause_menu
			ResetSkaters node_name=<restart_node>
		else
			create_pause_menu no_exit
		endif
	endif
endscript

script high_scores_change_level
	
	GetArraySize level_select_menu_level_info
	
	<index>=0
	begin
	// skip the custom park
		if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
			if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_TestLevel )
				if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_Default )
					if not StructureContains structure=((level_Select_menu_level_info)[<index>]) DEVKIT_ONLY
						if (<level> =  ( (level_select_menu_level_info[<index>]).level_num ))
							break
						endif
					endif
				endif
			endif
		endif
	<index> = ( <index> + 1 )
	repeat (<array_size>)
   
	if GotParam minus
		
			
		<index> = (<index>-1)
		
		printf <index>
		<to_repeat>=<index>
		if (<index> > -1)
			begin
			// skip the custom park
				if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
					if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_TestLevel )
						if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_Default )
							if not StructureContains structure=((level_Select_menu_level_info)[<index>]) DEVKIT_ONLY
								 if StructureContains structure= ((level_Select_menu_level_info)[<index>]) flag
									if GetGlobalFlag flag=(((level_Select_menu_level_info)[<index>]).flag)
										<level> = ( (level_select_menu_level_info[<index>]).level_num )
										break
									else
										if (all_levels_unlocked=1)
											<level> = ( (level_select_menu_level_info[<index>]).level_num )
											break
										endif
									endif
								endif
							endif
						endif
					endif
				endif
			<level> = ( (level_select_menu_level_info[0]).level_num )
			<index> = ( <index> - 1 )
			repeat <to_repeat>
		else
			<index> = (<array_size>-4)
			begin
			// skip the custom park
				if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
					if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_TestLevel )
						if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_Default )
							if not StructureContains structure=((level_Select_menu_level_info)[<index>]) DEVKIT_ONLY
								 if StructureContains structure= ((level_Select_menu_level_info)[<index>]) flag
									if GetGlobalFlag flag=(((level_Select_menu_level_info)[<index>]).flag)
										<level> = ( (level_select_menu_level_info[<index>]).level_num )
										break
									else
										if (all_levels_unlocked=1)
											<level> = ( (level_select_menu_level_info[<index>]).level_num )
											break
										endif
									endif
								endif
							endif
						endif
					endif
				endif
			<level> = ( (level_select_menu_level_info[(<array_size>-4)]).level_num )
			<index> = ( <index> - 1 )
			repeat <to_repeat>
		endif
	
	else		
		
		<index> = (<index>+1)
		if (<index> < (<array_size>-2))
			<times> = (<array_size>-<index>-1)
			begin
			// skip the custom park
				
				if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
					if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_TestLevel )
						if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_Default )
							if not StructureContains structure=((level_Select_menu_level_info)[<index>]) DEVKIT_ONLY
								if StructureContains structure= ((level_Select_menu_level_info)[<index>]) flag
									if GetGlobalFlag flag=(((level_Select_menu_level_info)[<index>]).flag)
										<level> = ( (level_select_menu_level_info[<index>]).level_num )
										break
									else
										if (all_levels_unlocked=1)
											<level> = ( (level_select_menu_level_info[<index>]).level_num )
											break
										endif
									endif
								endif
							endif
						endif
					endif
				endif
			<level> = 1
			<index> = ( <index> + 1 )
			repeat (<times>)
		else
			<level> = 1
		endif
	
	endif
	
	GetArraySize level_select_menu_level_info
	<index> = 0
	begin
		if ( ( (level_select_menu_level_info[<index>]).level_num ) = <level> )
			<level_name> = ( (level_select_menu_level_info[<index>]).text )
			break
		endif
		<index> = ( <index> + 1 )
	repeat <array_size>
	
	PlaySound MenuUp
	
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 gameframe
	endif
	; printf "level records for level %l" l=<level>
	high_scores_menu_create level=<level> level_name=<level_name> from_options no_animate
	if Gotparam minus
		RunScriptOnScreenElement id=high_scores_left_arrow menu_blink_arrow
	else
		RunScriptOnScreenElement id=high_scores_right_arrow menu_blink_arrow
    endif
endscript

// ***********************************
//	add item scripts
// ***********************************

script high_scores_menu_fill_menus
	// get the records
	GetLevelRecords level=<level>
	;printstruct <...>
	GetArraySize ( <highscores>.RecordTable )
	<index> = 0
	begin
		high_scores_menu_add_five_best_item {
			parent=high_scores_menu_five_best_high_scores_vmenu
			place=( <index> + 1 )
			initials=( ((<highscores>.RecordTable)[<index>]).initials )
			score=( ((<highscores>.RecordTable)[<index>]).value )
			
			new_initials=<new_initials>
		}
		
		<index> = ( <index> + 1 )
	repeat <array_size>	

	GetArraySize ( <bestcombos>.RecordTable )
	<index> = 0
	begin
		high_scores_menu_add_five_best_item {
			parent=high_scores_menu_five_best_combos_vmenu
			place=( <index> + 1 )
			initials=( ((<bestcombos>.RecordTable)[<index>]).initials )
			score=( ((<bestcombos>.RecordTable)[<index>]).value )
			
			new_initials=<new_initials>
		}
		
		<index> = ( <index> + 1 )
	repeat <array_size>	

	<c> = '.'
	
	if German
		<c>=','
	endif
	if French
		<c>=','
	endif
	
	FormatText TextName=score "%i%c%f sec." i=( ( <longestgrind>.value / 100 ) ) c=<c> f=( ( <longestgrind>.value ) - ( ( <longestgrind>.value / 100 ) * 100 ) )
	high_scores_menu_add_longest_trick_item {
		header="Longest grind:"
		initials=( <longestgrind>.initials )
		score=<score>
		
		new_initials=<new_initials>
	}
	
	FormatText TextName=score "%i%c%f sec." i=( ( <longestmanual>.value / 100 ) ) c=<c> f=( ( <longestmanual>.value ) - ( ( <longestmanual>.value / 100 ) * 100 ) )
	high_scores_menu_add_longest_trick_item {
		header="Longest manual:"
		initials=( <longestmanual>.initials )
		score=<score>
		
		new_initials=<new_initials>
	}
	
	FormatText TextName=score "%i%c%f sec." i=( ( <longestliptrick>.value / 100 ) ) c=<c> f=( ( <longestliptrick>.value ) - ( ( <longestliptrick>.value / 100 ) * 100 ) )	
	high_scores_menu_add_longest_trick_item {
		header="Longest lip:"
		initials=( <longestliptrick>.initials )
		score=<score>
		
		new_initials=<new_initials>
	}
	
	FormatText TextName=score "%i tricks" i=( <longestcombo>.value )
	high_scores_menu_add_longest_trick_item {
		header="Longest combo:"
		initials=( <longestcombo>.initials )
		score=<score>
		
		new_initials=<new_initials>
	}
endscript

script high_scores_menu_add_five_best_item
	SetScreenElementLock id=<parent> off
	
	FormatText ChecksumName=on_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	<scale> = .85
	
	// get place and score strings
	FormatText TextName=place_string "%i)" i=<place>
	FormatText TextName=score_string "%i" i=<score> UseCommas
	
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		
		dims=(400, 15)
		just=[left top]
	}
	<anchor_id> = <id>
	
	// place
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=dialog
		text=<place_string>
		rgba=<off_color>
		scale=<scale>
		pos=(19, 0)
		just=[center top]
	}
	
	// initials
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=dialog
		text=<initials>
		rgba=<off_color>
		scale=<scale>
		pos=(71, 0)
		just=[center top]
	}
	
	// score
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=dialog
		text=<score_string>
		pos=(250, 0)
		rgba=<off_color>
		scale=<scale>
		just=[right top]
	}
	
	if ( GotParam new_initials )
		if ( <new_initials> = <initials> )
			GetScreenElementPosition {
				id={ <anchor_id> child=1 }
			}
			//select bar
			CreateScreenElement {
			type=SpriteElement
			parent=<anchor_id>
			
			texture=black
			rgba=[0 0 0 50]
			scale=(110, 3.7)
			
			pos=( <ScreenElementPos> + (-185, 2) )
			just=[left top]
			z_priority=1.1
			}
		
			SetScreenElementProps {
				id={ <anchor_id> child=0 }
				rgba=<on_color>
			}
			SetScreenElementProps {
				id={ <anchor_id> child=1 }
				rgba=<on_color>
			}
			SetScreenElementProps {
				id={ <anchor_id> child=2 }
				rgba=<on_color>
			}
		endif
	endif
endscript

script high_scores_menu_add_longest_trick_item
	SetScreenElementLock id=high_scores_menu_longest_tricks_vmenu off

	<scale> = .85
	FormatText ChecksumName=on_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	// get place and score strings
	FormatText TextName=score_string "%i" i=<score>
	
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=high_scores_menu_longest_tricks_vmenu
		
		dims=(400, 16.5)
		just=[left top]
	}
	<anchor_id> = <id>
	
	// header
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=dialog
		text=<header>
		rgba=<on_color>
		scale=<scale>
		pos=(12, 0)
		just=[left top]
	}
	
	// initials
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=dialog
		text=<initials>
		rgba=<off_color>
		scale=<scale>
		pos=(195, 0)
		just=[center top]
	}
	
	// score
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=dialog
		text=<score_string>
		pos=(320, 0)
		rgba=<off_color>
		scale=<scale>
		just=[center top]
	}
	
	if ( GotParam new_initials )
		if ( <new_initials> = <initials> )
			GetScreenElementPosition {
				id={ <anchor_id> child=1 }
			}
			//select bar
			CreateScreenElement {
			type=SpriteElement
			parent=<anchor_id>
			
			texture=black
			rgba=[0 0 0 50]
			scale=(110, 4.1)
			pos=( <ScreenElementPos> + (-185, 0) )
			just=[left top]
			z_priority=1.1
			}
			SetScreenElementProps {
				id={ <anchor_id> child=1 }
				rgba=<on_color>
			}
			SetScreenElementProps {
				id={ <anchor_id> child=2 }
				rgba=<on_color>
			}
		endif
	endif	
endscript

