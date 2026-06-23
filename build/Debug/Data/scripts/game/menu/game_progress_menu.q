// Game progress menu

script game_progress_menu_create
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	// hide the points
	GoalManager_HidePoints
	GoalManager_HideGoalPoints

	if not LevelIs load_skateshop
		PauseMusicAndStreams 1
	else
		skater:remove_skater_from_world
	endif


	SetScreenElementLock id=root_window off

	// anchor for the whole thing
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=progress_anchor

		dims=(640, 480)
		pos=(320, 240)
	}
	AssignAlias id=progress_anchor alias=current_menu_anchor
	create_helper_text { helper_text_elements=[ { text="\b7/\b4 = Select" }
			{ text="\m1 = Back" }
		]
	}

	kill_start_key_binding

	FormatText ChecksumName=title_icon "%i_pro" i=(THEME_PREFIXES[current_theme_prefix])
	build_theme_sub_title title="GAME PROGRESS" title_icon=<title_icon>
	FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])

	if LevelIs load_skateshop
		build_top_and_bottom_blocks
		make_mainmenu_3d_plane
	else
		build_theme_box_icons icon_texture=<paused_icon>
		build_grunge_piece
		build_top_bar pos=(0, 62)
	endif

	// anchor for the whole thing
	CreateScreenElement {
		type=ContainerElement
		parent=progress_anchor
		id=progress_menu

		dims=(640, 480)
		pos=(320, 640)
	}
	AssignAlias id=progress_menu alias=current_menu_anchor

	// theme background
	theme_background width=6.35 pos=(320,85) num_parts=10.5

	<root_pos> = (80, 25)
	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=icon_color "%i_ICON_ON_VALUE" i=(THEME_COLOR_PREFIXES[current_theme_prefix])



	// up arrow
	GetStackedScreenElementPos X id=<id> offset=(115, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=view_progress_menu_up_arrow

		texture=up_arrow
		rgba=[128 128 128 85]
		pos=(300,90)
		just=[left top]
		z_priority=3
	}


	// vertical bar between score and name
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor

		texture=black
		scale=(2, 75)
		pos=(380,90)
		just=[left top]
		rgba=[0 0 0 128]
	}


	// down arrow
	GetStackedScreenElementPos Y id=view_progress_menu_up_arrow	offset=(0, 260)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=view_progress_menu_down_arrow

		texture=down_arrow
		rgba=[128 128 128 85]
		pos=<pos>
		just=[left top]
		z_priority=3
	}

	// scrolling menu
	;GetStackedScreenElementPos Y id=view_progress_menu_top_bar offset=(20, 5)
	CreateScreenElement {
		type=VScrollingMenu
		parent=current_menu_anchor
		id=vs1
		dims=(640, 245)
		pos=(54,110)
		just=[left top]
		internal_just=[center top]
	}

	// vmenu
	CreateScreenElement {
		type=VMenu
		parent=<id>
		id=progress_vmenu

		pos=(0, 0)
		just=[left top]
		internal_just=[left top]
		dont_allow_wrap

		event_handlers=[
			{ pad_up 		menu_vert_blink_arrow params={ id=view_progress_menu_up_arrow rgba=<text_rgba> }}
			{ pad_down		menu_vert_blink_arrow params={ id=view_progress_menu_down_arrow rgba=<text_rgba> }}
			{ pad_up 		generic_menu_up_or_down_sound params={ up } }
			{ pad_down		generic_menu_up_or_down_sound params={ down } }
			;{ pad_back		generic_menu_pad_back_sound }
		]
	}
	AssignAlias id=progress_vmenu alias=current_menu


	// Define pad_back event - go back to the pause menu
	SetScreenElementProps {
		id=current_menu
		event_handlers=[ { pad_back   generic_menu_pad_back params={ callback=game_progress_menu_exit} } ]
	}


	//Add the Goals completed section
	GoalManager_GetNumberOfGoalPoints total
	FormatText TextName=goal_points "%i / %j" i=<goal_points> j=total_num_goals
	progress_menu_add_item id1=progress_vmenu left_col_text=" GOALS COMPLETED:" right_col_text=<goal_points>
	progress_menu_add_item id1=progress_vmenu seperator

	//Add the story mode completed section
	GetCompletionStatusText mode=SKATER_UNLOCKED_IRONMAN
	progress_menu_add_item id1=progress_vmenu left_col_text=" BEGINNER STORY MODE SECRET:" right_col_text=<completion_status>
	GetCompletionStatusText mode=SKATER_UNLOCKED_KISSDUDE
	progress_menu_add_item id1=progress_vmenu left_col_text=" NORMAL STORY MODE SECRET:" right_col_text=<completion_status>
	GetCompletionStatusText mode=SKATER_UNLOCKED_CREATURE
	progress_menu_add_item id1=progress_vmenu left_col_text=" SICK STORY MODE SECRET:" right_col_text=<completion_status>
	progress_menu_add_item id1=progress_vmenu seperator

	//Add the Secret Tape section (NOTE: pending secret tape query)
	GetArraySize level_select_menu_level_info
	<index> = 0
	begin
		// skip the custom park
		if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
			<level_num> = ( (level_select_menu_level_info[<index>]).level_num )
			GetLevelNumTapeCollected level=<level_num>
			if GetGlobalFlag flag=( (level_select_menu_level_info[<index>]).flag )
				FormatText TextName=level_text " %s SECRET TAPE:" s=( (level_select_menu_level_info[<index>]).text )
			else
				if (all_levels_unlocked=1)
					FormatText TextName=level_text " %s SECRET TAPE:" s=( (level_select_menu_level_info[<index>]).text )
				else
					FormatText TextName=level_text " %s SECRET TAPE:" s="??????"
				endif
			endif
			progress_menu_add_item id1=progress_vmenu left_col_text=<level_text> check_box=<collected>
		endif
		<index> = ( <index> + 1 )
	repeat 9
	progress_menu_add_item id1=progress_vmenu seperator

	//Add the Old Skool Leel section
	GetCompletionStatus mode=LEVEL_UNLOCKED_SC2
	if ((GetGlobalFlag flag=LEVEL_UNLOCKED_NJ)|| (all_levels_unlocked=1))
		progress_menu_add_item id1=progress_vmenu left_col_text=" NEW JERSEY OLD SKOOL LEVEL:" check_box=<completion_status>
	else
		progress_menu_add_item id1=progress_vmenu left_col_text=" ?????? SKOOL LEVEL:" check_box=<completion_status>
	endif
	GetCompletionStatus mode=LEVEL_UNLOCKED_VN
	if ((GetGlobalFlag flag=LEVEL_UNLOCKED_HI)|| (all_levels_unlocked=1))
		progress_menu_add_item id1=progress_vmenu left_col_text=" HAWAII OLD SKOOL LEVEL:" check_box=<completion_status>
	else
		progress_menu_add_item id1=progress_vmenu left_col_text=" ?????? OLD SKOOL LEVEL:" check_box=<completion_status>
	endif
	GetCompletionStatus mode=LEVEL_UNLOCKED_HN
	if ((GetGlobalFlag flag=LEVEL_UNLOCKED_RU)|| (all_levels_unlocked=1))
		progress_menu_add_item id1=progress_vmenu left_col_text=" MOSCOW OLD SKOOL LEVEL:" check_box=<completion_status>
	else
		progress_menu_add_item id1=progress_vmenu left_col_text=" ?????? OLD SKOOL LEVEL:" check_box=<completion_status>
	endif
	progress_menu_add_item id1=progress_vmenu seperator

	//Add the Gaps completed section
	GetArraySize level_select_menu_level_info
	<index> = 0
	begin
		// skip the custom park
		if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
			if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_TestLevel )
				if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_Default )
					if not StructureContains structure=( (level_Select_menu_level_info[<index>])) DEVKIT_ONLY
						<level_num> = ( (level_select_menu_level_info[<index>]).level_num )
						GetLevelGapTotals level=<level_num>
						if ( <num_gaps> = 0 )
							<gaps_text> = "0 / ??"
						else
							FormatText TextName=gaps_text "%i / %j" i=<num_collected_gaps> j=<num_gaps>
						endif

						if GetGlobalFlag flag=( (level_select_menu_level_info[<index>]).flag )
							FormatText TextName=level_text " %s GAPS:" s=( (level_select_menu_level_info[<index>]).text )
						else
							if (all_levels_unlocked=1)
								FormatText TextName=level_text " %s GAPS:" s=( (level_select_menu_level_info[<index>]).text )
							else
								FormatText TextName=level_text " %s GAPS:" s="??????"
							endif
						endif
						progress_menu_add_item id1=progress_vmenu left_col_text=<level_text> right_col_text=<gaps_text>
					endif
				endif
			endif
		endif
		<index> = ( <index> + 1 )
	repeat (<array_size>)

	if LevelIs load_skateshop
		DoScreenElementMorph id=current_menu_anchor pos=(320,218) time=0.2
	else
		DoScreenElementMorph id=current_menu_anchor pos=(320,240) time=0.2
	endif

	DoScreenElementMorph id=progress_vmenu time=.2 pos=(0,-200)
	FireEvent type=focus target=current_menu
endscript

script GetCompletionStatus
	if(GetGlobalFlag flag=<mode>)
		<completion_status> = 1
	else
		<completion_status> = 0
	endif

	return completion_status=<completion_status>
endscript

script GetCompletionStatusText
	if(GetGlobalFlag flag=<mode>)
		switch <mode>
			case SKATER_UNLOCKED_IRONMAN
				<completion_status> = "DONE: IRON MAN"
			case SKATER_UNLOCKED_KISSDUDE
				<completion_status> = "DONE: GENE"
			case SKATER_UNLOCKED_CREATURE
				<completion_status> = "DONE: T.H.U.D."
		endswitch
	else
		<completion_status> = "NOT FINISHED"
	endif

	return completion_status=<completion_status>
endscript

script progress_menu_add_item choose_script=nullscript left_col_text="" right_col_text=""

	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	<anchor_id1> = <id1>

	if GotParam seperator

		// container for this element
		CreateScreenElement {
			type=ContainerElement
			parent=<id1>
			pos=(65,10)
			dims=(200, 20)
			not_focusable
		}
		<anchor_id1>=<id>

		CreateScreenElement {
			type=SpriteElement
			parent=<anchor_id1>
			texture=black
			scale=(132, 3.3)
			pos=(4,0)
			just=[left top]
			rgba=[0 0 0 90]
			not_focusable
		}


	else
		if GotParam check_box
			FormatText ChecksumName=check_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
			FormatText ChecksumName=checkmark_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

			// container for this element
			CreateScreenElement {
				type=ContainerElement
				parent=<id1>
				pos=(65,10)
				dims=(200, 25)
				event_handlers=[
					{ focus			progress_menu_focus params={checkbox_item=checkbox_item}}
					{ unfocus		progress_menu_unfocus params={checkbox_item=checkbox_item}}

				]
			}
			<anchor_id1>=<id>

			// name
			CreateScreenElement {
				type=TextElement
				parent=<anchor_id1>

				font=small;dialog
				text=<left_col_text>
				pos=(10,0)
				just=[left top]
				rgba=<off_rgba>
				scale=1.0
			}

			// check box
			CreateScreenElement {
				type=SpriteElement
				parent=<anchor_id1>

				texture=checkbox
				pos=((420, 0)+(0,5))
				just=[center top]
				scale=0.55
				rgba=<check_rgba>
				z_priority=5
			}

			if (<check_box>=1)
				// check mark
				CreateScreenElement {
					type=SpriteElement
					parent=<id>

					texture=checkmark
					pos=(25, -7)
					just=[center top]
					rgba=<checkmark_rgba>
					z_priority=6
					scale=1.4
				}
			else
				// check mark
				CreateScreenElement {
					type=SpriteElement
					parent=<id>

					texture=checkmark
					pos=(25, -7)
					just=[center top]
					rgba=[0 0 0 0]
					z_priority=6
					scale=1.4
				}
			endif
			//highlight bar
			highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )

			CreateScreenElement {
				type=SpriteElement
				parent=<anchor_id1>
				texture=de_highlight_bar

				pos=(262, 10)
				just=[center center]
				rgba=[0 0 0 0]
				z_priority=3
				scale=(4.1,0.7)
				rot_angle=(<highlight_angle>/4)
			}

		else
			// container for this element
			CreateScreenElement {
				type=ContainerElement
				parent=<id1>
				pos=(65,10)
				dims=(200, 25)
				event_handlers=[
					{ focus			progress_menu_focus }
					{ unfocus		progress_menu_unfocus  }

				]
			}
			<anchor_id1>=<id>

			// name
			CreateScreenElement {
				type=TextElement
				parent=<anchor_id1>

				font=small;dialog
				text=<left_col_text>
				pos=(10,0)
				just=[left top]
				rgba=<off_rgba>
				scale=1.0
			}

			CreateScreenElement {
				type=TextElement
				parent=<anchor_id1>

				font=small
				text=<right_col_text>
				pos=(420, 0)
				just=[center top]
				rgba=<off_rgba>
				scale=1.0
			}

			//highlight bar
			highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )

			CreateScreenElement {
				type=SpriteElement
				parent=<anchor_id1>
				texture=de_highlight_bar

				pos=(262, 10)
				just=[center center]
				rgba=[0 0 0 0]
				z_priority=3
				scale=(4.1,0.7)
				rot_angle=(<highlight_angle>/4)
			}
		endif
	endif
endscript

script progress_menu_focus
	GetTags
	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	RunScriptOnScreenElement id={<id> child=0} text_twitch_effect2
	DoScreenElementMorph {
		id={<id> child=0}
		rgba=<text_rgba>
	}

	if GotParam checkbox_item
		// highlight bar
		FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
		SetScreenElementProps {
			id={ <id> child=2 }
			rgba=<bar_rgba>
		}
	else
		RunScriptOnScreenElement id={<id> child=1} text_twitch_effect2
		DoScreenElementMorph {
			id={<id> child=1}
			rgba=<text_rgba>
		}

		// highlight bar
		FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
		SetScreenElementProps {
			id={ <id> child=2 }
			rgba=<bar_rgba>
		}
	endif
endscript

script progress_menu_unfocus
	GetTags
	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	KillSpawnedScript name=text_twitch_effect2

	DoScreenElementMorph {
		id={<id> child=0}
		rgba=<text_rgba>
	}

	if GotParam checkbox_item
		// highlight bar
		SetScreenElementProps {
			id={ <id> child=2 }
			rgba=[0 0 0 0]
		}
	else
		DoScreenElementMorph {
			id={<id> child=1}
			rgba=<text_rgba>
		}

		// highlight bar
		SetScreenElementProps {
			id={ <id> child=2 }
			rgba=[0 0 0 0]
		}
	endif
endscript

// this fills the game progress menu with all kinds of shit
/*script game_progress_menu_fill
	// total goals
	GoalManager_GetNumberOfGoalPoints total
	FormatText TextName=goal_points "%i / 190" i=<goal_points>
	game_progress_menu_add_section_header {
		; icon=pa_shop
		first_column_text="TOTAL GOALS:"
		second_column_text=<goal_points>
		second_column_rgba=[88 105 112 128]
		second_column_scale=.9
	}

	// total cash
	GoalManager_GetCash total
	FormatText TextName=cash "$%i" i=<cash>
	game_progress_menu_add_section_header {
		first_column_text="TOTAL CASH:"
		second_column_text=<cash>
		second_column_rgba=[88 105 112 128]
		second_column_scale=.9
	}

	// goals organized by level
	game_progress_menu_add_section_header {
		create_bg
		;icon=DE_view
		first_column_text="GOALS"
		not_focusable=not_focusable
		; second_column_text=""
	}

	GetArraySize level_select_menu_level_info
	<index> = 0
	begin
		// skip the custom park
		if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
			// get the number of goals beaten and the total number
			<level_num> = ( (level_select_menu_level_info[<index>]).level_num )
			GoalManager_NumGoalsBeatenInLevel <level_num>
			<total_goals> = ( (level_select_menu_level_info[<index>]).num_goals )
			FormatText TextName=goals_beaten_text "%i/%j" i=<num_beaten> j=<total_goals>

			<level_text> = ( (level_select_menu_level_info[<index>]).text )
			game_progress_menu_add_item {
				first_column_text=<level_text>
				second_column_text=<goals_beaten_text>
			}
		endif

		<index> = ( <index> + 1 )
	repeat <array_size>

	// pro challenges
	game_progress_menu_add_section_header {
		create_bg
		;icon=pa_special
		first_column_text="PRO CHALLENGE"
		not_focusable=not_focusable
		; second_column_text=""
	}

	GetArraySize master_skater_list
	<index> = 0
	begin
		// only pros have pro challenges.
		if not StructureContains structure=( master_skater_list[<index>] ) is_secret
			<skater_display_name> = ( (master_skater_list[<index>]).display_name )
			<skater_name> = ( (master_skater_list[<index>]).name )

			printf "looking for skater %s" s=<skater_name>
			if GoalManager_SkaterHasBeatenProSpecificChallenge skater=<skater_name>
				<beaten_text> = "Complete"
			else
				<beaten_text> = "Not Finished"
			endif

			game_progress_menu_add_item {
				first_column_text=<skater_display_name>
				second_column_text=<beaten_text>
			}
		endif
		<index> = ( <index> + 1 )
	repeat <array_size>


	// gaps
	game_progress_menu_add_section_header {
		create_bg
		;icon=DE_gap
		first_column_text="GAPS"
		not_focusable=not_focusable
		; second_column_text=""
	}

	GetArraySize level_select_menu_level_info
	<index> = 0
	begin
		// skip the custom park
		if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
			// get the number of goals beaten and the total number
			<level_num> = ( (level_select_menu_level_info[<index>]).level_num )
			GetLevelGapTotals level=<level_num>
			if ( <num_gaps> = 0 )
				<gaps_text> = "0/??"
			else
				FormatText TextName=gaps_text "%i/%j" i=<num_collected_gaps> j=<num_gaps>
			endif

			<level_text> = ( (level_select_menu_level_info[<index>]).text )

			game_progress_menu_add_item {
				first_column_text=<level_text>
				second_column_text=<gaps_text>
			}
		endif

		<index> = ( <index> + 1 )
	repeat <array_size>

	// cash
	game_progress_menu_add_section_header {
		create_bg
		;icon=pa_shop
		first_column_text="CASH ICONS"
		not_focusable=not_focusable
		; second_column_text=""
	}

	GetArraySize level_select_menu_level_info
	<index> = 0
	begin
		// skip the custom park
		if not ( ( (level_Select_menu_level_info[<index>]).level ) = load_sk5ed_gameplay )
			// get the number of goals beaten and the total number
			<level_num> = ( (level_select_menu_level_info[<index>]).level_num )

			<num_collected> = 0
			<flag_number> = 64
			begin
				if GetFlag flag=<flag_number> level=<level_num>
					<num_collected> = ( <num_collected> + 1 )
				endif

				<flag_number> = ( <flag_number> + 1 )
			repeat 25

			<level_text> = ( (level_select_menu_level_info[<index>]).text )

            FormatText TextName=cash_text "%i/25" i=<num_collected>
			game_progress_menu_add_item {
				first_column_text=<level_text>
				second_column_text=<cash_text>
			}
		endif

		<index> = ( <index> + 1 )
	repeat <array_size>
endscript*/


// ************************************
//		add item scripts
// ************************************

/*script game_progress_menu_add_section_header { first_column_rgba=[127 102 0 128]
											   first_column_scale=.8
											   second_column_rgba=[127 102 0 128]
											   second_column_scale=.8
											 }
	// container
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu

		dims=(400, 20)

		event_handlers=[ { focus	game_progress_menu_focus }
						 { unfocus	game_progress_menu_unfocus params={ first_column_rgba=<first_column_rgba> } }
					   ]

		<not_focusable>
	}
	<anchor_id> = <id>

	if GotParam create_bg
		// bg
		CreateScreenElement {
			type=SpriteElement
			parent=<anchor_id>

			texture=black
			rgba=[0 0 0 80]
			pos=(0, 0)
			just=[left top]
			scale=(98, 5)
			z_priority=1
		}
	endif

	// icon
	if GotParam icon
		CreateScreenElement {
			type=SpriteElement
			parent=<anchor_id>

			texture=<icon>
			pos=(3, -7)
			just=[left top]
			rgba=[80 80 80 128]
			scale=.8
			z_priority=2
		}
	endif

	// First column text
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>

		font=dialog
		text=<first_column_text>
		pos=(50, 0)
		just=[left top]
		rgba=<first_column_rgba>
		scale=<first_column_scale>
		z_priority=2
	}

	// second column text
	if GotParam second_column_text
		CreateScreenElement {
			type=TextElement
			parent=<anchor_id>

			font=dialog
			text=<second_column_text>
			pos=(315, 0)
			just=[center top]
			rgba=<second_column_rgba>
			scale=<second_column_scale>
			z_priority=2
		}
	endif
endscript

script game_progress_menu_add_item
	// container for this element
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu

		dims=(400, 20)

		event_handlers=[ { focus	game_progress_menu_focus }
						 { unfocus	game_progress_menu_unfocus }
					   ]
	}
	<anchor_id> = <id>

	// text
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>

		font=dialog
		text=<first_column_text>
		pos=(50, 0)
		just=[left top]
		rgba=[88 105 112 128]
		scale=.9
		z_priority=1
	}
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>

		font=dialog
		text=<second_column_text>
		pos=(315, 0)
		just=[center top]
		rgba=[88 105 112 128]
		scale=.9
		z_priority=1
	}
endscript


// ************************************
//		event handling scripts
// ************************************

script game_progress_menu_focus
	GetTags
	SetScreenElementLock id=<id> off

	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=[127 102 0 128]
	}

	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=[127 102 0 128]
	}

	// create a highlight bar
	CreateScreenElement {
		type=SpriteElement
		parent=<id>

		texture=de_highlight_bar
		pos=(0, 0)
		just=[left top]
		scale=(1.5, 1.2)
		rgba=[128 128 128 80]
		z_priority=0
	}

	// update the arrows
	generic_menu_update_arrows {
		menu_id=game_progress_vmenu
		up_arrow_id=game_progress_menu_up_arrow
		down_arrow_id=game_progress_menu_down_arrow
	}

	// blinking arrows!
	game_progress_vmenu:GetTags
	if GotParam arrow_id
		menu_vert_blink_arrow { id=<arrow_id> }
	endif
endscript

script game_progress_menu_unfocus first_column_rgba=[88 105 112 128]
	GetTags
	SetScreenElementLock id=<id> off

	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<first_column_rgba>
	}

	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=[88 105 112 128]
	}

	// destroy highlight bar
	if ScreenElementExists id={ <id> child=2 }
		DestroyScreenElement id={ <id> child=2 }
	endif
endscript*/


// ************************************
//		exit script
// ************************************

script game_progress_menu_exit
	if ObjectExists id=progress_anchor
		DestroyScreenElement id=progress_anchor
		wait 1 gameframe
	endif

	if ObjectExists id=box_icon
		DestroyScreenElement id=box_icon
		wait 1 gameframe
	endif

	if ObjectExists id=box_icon_2
		DestroyScreenElement id=box_icon_2
		wait 1 gameframe
	endif

	if ObjectExists id=grunge_anchor
		DestroyScreenElement id=grunge_anchor
		wait 1 gameframe
	endif

	if LevelIs load_skateshop
		;create_ss_menu
		create_setup_options_menu
	else
		create_options_menu
	endif
endscript


