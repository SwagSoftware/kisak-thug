// True when ped, restart and letter positions are being placed.
// Referenced by the controller unplugging scripts.
goal_editor_placement_mode=0

// True throughout the create-a-goal menu sequence.
// Referenced by the controller unplugging scripts.
in_create_a_goal=0

script set_in_create_a_goal
	Change in_create_a_goal=1
endscript

script reset_in_create_a_goal
	Change in_create_a_goal=0
endscript

script my_exit_pause_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	pause_menu_gradient off

	SetScreenElementProps id=root_window tags={ menu_state=off }

	if CustomParkMode editing
		if not GotParam DoNotSwitchEditorState
			SetParkEditorState state=edit
			SetParkEditorPauseMode unpause
		endif
	endif

	restore_start_key_binding
endscript

script parked_create_a_goal
	change check_for_unplugged_controllers = 0
	SwitchOffRailEditor
	DisassociateFromObject
	my_exit_pause_menu
	SetParkEditorPauseMode pause
	PauseSkaters
	HideSkaterAndMiscSkaterEffects

	kill_start_key_binding

	create_existing_goals_menu
	change check_for_unplugged_controllers = 1
endscript

script existing_goals_menu_back
	reset_in_create_a_goal

	if CustomParkMode editing
		// This is so that pressing triangle switches back to edit mode in the park editor, to
		// be consistent with other menus. (TT2112)
		goto generic_menu_pad_back params={ callback=exit_pause_menu }
	else
		goto generic_menu_pad_back params={ callback=create_pause_menu }
	endif
endscript

script create_existing_goals_menu
	if not GameModeEquals is_creategoals
		ScriptAssert "Game mode is not CreateGoals !"
	endif
	hide_current_goal
	dialog_box_exit ; To remove any reamining dialog boxes, eg the delete-goal yes/no
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	set_in_create_a_goal

	array_size=0

	GetCurrentLevel
	// The goal editor always has PE goals registered under Load_Sk5Ed, so map Load_Sk5Ed_gameplay to that
	if ChecksumEquals a=<level> b=Load_Sk5Ed_gameplay
		level=Load_Sk5Ed
	endif

	GoalEditor:GetEditedGoalsInfo Level=<Level>
	if GotParam EditedGoalsInfo
		GetArraySize <EditedGoalsInfo>
	endif

	pause_menu_gradient on
	FormatText ChecksumName=title_icon "%i_sound" i=(THEME_PREFIXES[current_theme_prefix])

	// Make the max lines visible be 8. After that the menu will start to scroll.
	num_lines=(<array_size>+1) // +1 for the Create New Goal entry.
	if (<num_lines> > 8)
		num_lines=8
	endif
	make_new_themed_scrolling_menu title="CREATED GOALS" title_icon=<title_icon> dims=((300,0)+(0,1)*23*<num_lines>)

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=existing_goals_menu_back }} ]
		replace_handlers
	}

	// Add the Create New Goal entry.
	if (<array_size> = 0)
		params={last_item}
	else
		params={}
	endif
	if GoalEditor:MaxEditedGoalsReached Level=<Level>
		// TODO Modify to inform user that max goals has been reached ?
		params=(<params>+{not_focusable=not_focusable})
	endif
	theme_menu_add_item {
		first_item
		text="Create new goal"
		pad_choose_script=create_goal_type_select_menu
		centered=1
		no_bg
		<params>
	}

	// Then add each of the existing goals
	if (<array_size> > 0)
		i=0
		begin
			params = {
				text=((<EditedGoalsInfo>[<i>]).view_goals_text)
				pad_choose_script=select_created_goal
				pad_choose_params={goal_id=((<EditedGoalsInfo>[<i>]).goal_id)}
				centered
				no_bg
				no_sound
			}

			if (<i>=(<array_size>-1))
				params=(<params>+{last_item})
			endif

			theme_menu_add_item <params>
			i=(<i>+1)
		repeat <array_size>
	endif

	finish_themed_scrolling_menu

endscript

script select_created_goal
	end_current_goal_run

	GoalEditor:SetCurrentEditorGoal goal_id=<goal_id>

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	create_edit_goal_menu go_back_to_goal_list_menu
endscript

script load_goals
	;if ObjectExists id=current_menu_anchor
	;	DestroyScreenElement id=current_menu_anchor
	;endif
	printf "TODO"
endscript

script save_goals
	;if ObjectExists id=current_menu_anchor
	;	DestroyScreenElement id=current_menu_anchor
	;endif
	printf "TODO"
endscript

// Info for the different goal types used when generating menus that list the types.
// Used by the create_goal_type_select_menu script below.
goals_menu_info=
[
	{
		name="SKATE letters"
		type=skate
	}
	{
		name="COMBO letters"
		type=combo
	}
	{
		name="High Score"
		type=HighScore
	}
	{
		name="High Combo"
		type=HighCombo
	}
	{
		name="Skate-Tricks"
		type=Skatetris
	}
	{
		name="Combo Skate-Tricks"
		type=ComboSkatetris
	}
	{
		name="Tricktris"
		type=TrickTris
	}
	{
		name="Gap"
		type=gap
	}
]

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Goal type selection menu

script create_goal_type_select_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	destroy_goal_panel_messages

	set_in_create_a_goal

	FormatText ChecksumName=title_icon "%i_trick" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="SELECT GOAL TYPE" title_icon=<title_icon>

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ {pad_back generic_menu_pad_back params={ callback=create_existing_goals_menu }}
			;{ pad_back	generic_menu_pad_back_sound }
		]
		replace_handlers
	}

	CreateGapList
	if (<array_size> = 0)
		no_gaps=1
	endif
	// Remove the GapList array just to reduce the chance of a component overflow
	// (all we need is the num_gaps_got)
	RemoveParameter GapList



	GetArraySize goals_menu_info
	i=0
	begin
		if (<i>=0)
			first_item=first_item
		else
			RemoveParameter first_item
		endif

		not_focusable=(goals_menu_info[<i>].not_focusable)

		if (goals_menu_info[<i>].type=Gap)
			if CustomParkMode editing
				// The gap option is always active when editing a park ...
				// unless there are no gaps.
				if GotParam no_gaps
					not_focusable=not_focusable
				endif
			else
				// Lo-light the gap option if they haven't got any of the gaps yet.
				if (<num_gaps_got>=0)
					not_focusable=not_focusable
				endif
			endif
		endif

		theme_menu_add_item {
			<first_item>
			not_focusable=<not_focusable>
			text=(goals_menu_info[<i>].name)
			pad_choose_script=goal_editor_set_type
			pad_choose_params={type=(goals_menu_info[<i>].type)}
			centered=1
		}
		i=(<i>+1)
	repeat <array_size>

	theme_menu_add_item {
		text="Done"
		pad_choose_script=create_existing_goals_menu
		last_item
		centered=1
		last_menu_item=1
	}

	finish_themed_sub_menu
endscript

script edit_goal_pad_start
	generic_menu_pad_choose_sound
	GoalEditor:Suspend

	set_in_create_a_goal

	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if GoalEditor:GoalHasAllPositionsSet
		text="Quit editing goal?"
	else
		text="Quit editing and erase goal?"
	endif

	create_dialog_box { title="Quit"
		text=<text>

		pos=(310 ,240)
		just=[center center]
		text_rgba=[88 105 112 128]

		pad_back_script = edit_goal_continue
		pad_back_params = {make_sound}

		buttons=
		[
			{ font=small text="No" pad_choose_script=edit_goal_continue }
			{ font=small text="Yes" pad_choose_script=edit_goal_quit }
		]
	}
endscript

script edit_goal_continue
	if GotParam make_sound
		generic_menu_pad_back_sound
	endif

	dialog_box_exit
	SetScreenElementProps {
		id=root_window
		replace_handlers
		event_handlers=
		[
			{
				pad_start
				edit_goal_pad_start
			}
		]
	}
	create_cag_helper_text
	Debounce X time=0.2 clear=1
	Debounce Triangle time=0.2 clear=1
	GoalEditor:Unsuspend
endscript

script edit_goal_quit
	GoalEditor:RefreshGoalCursorPosition
	dialog_box_exit
	Change goal_editor_placement_mode=0

	if GoalEditor:GoalHasAllPositionsSet
		create_edit_goal_menu go_back_to_goal_list_menu
	else
		edit_goal_menu_back
	endif
endscript

script goal_editor_set_type

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	pause_menu_gradient off

	// In case they were running a created goal, end it, to prevent any confusion
	// due to adding a new goal to the goal manager when it is in the middle of running one.
	end_current_goal_run

	;UnPauseGame
	;PauseSkater 0
	HideSkaterAndMiscSkaterEffects
	destroy_goal_panel_messages

	SetScreenElementProps {
		id=root_window
		replace_handlers
		event_handlers=
		[
			{
				pad_start
				edit_goal_pad_start
			}
		]
	}

	delete_goal_editor_marker_objects

	if GoalEditor:FindUnfinishedGoal type=<type>
		GoalEditor:EditGoal
	else
		goal_name=""
		// TODO Get these from the array used for generating the select goal menu ...
		switch <type>
			case Skate
				goal_name="Skate letters"
			case Combo
				goal_name="Combo letters"
			case HighScore
				goal_name="High Score"
			case HighCombo
				goal_name="High Combo"
			case Skatetris
				goal_name="Skate-Tricks"
			case ComboSkatetris
				goal_name="Combo Skate-Tricks"
			case Tricktris
				goal_name="Tricktris"
			case Gap
				goal_name="Gaps"
		endswitch

		if GoalEditor:GoalExists goal_name=<goal_name>
			// Append a suffix to distinguish multiple default names.
			suffix=2
			begin
				FormatText TextName=new_name "%s %d" s=<goal_name> d=<suffix>
				if not GoalEditor:GoalExists goal_name=<new_name>
					break
				endif
				suffix=(<suffix>+1)
			repeat
			goal_name=<new_name>
		endif

		GoalEditor:NewEditorGoal
		GoalEditor:SetEditorGoalType type=<type>
		GoalEditor:SetEditorGoalName name=<goal_name>
	endif

	Debounce X time=0.2 clear=1
	Debounce Triangle time=0.2 clear=1
	GoalEditor:Unpause
	GoalEditor:Unsuspend
	GoalEditor:Unhide
	Change goal_editor_placement_mode=1

	if CustomParkMode editing
		GetParkEditorCursorPos
		RebuildParkNodeArray
	else
		// Note: Using the skater's last ground position rather than his current position,
		// because he might have just bailed by falling into water, which would cause the
		// cursor to become stuck.
		skater:GetLastGroundPos
	endif
	GoalEditor:EditorCam_Initialise position=<pos>
	SetActiveCamera id=GoalEditor

	create_cag_helper_text PedPosition
endscript

// This also gets called from the c-code when transitioning to and from the ped position
script create_cag_helper_text
	if GotParam PedPosition
		<cag_helper_text>=cag_helper_text_no_back

		if IsXBox
			<cag_helper_text>=cag_helper_text_no_back_xbox
		endif
		if IsNGC
			<cag_helper_text>=cag_helper_text_no_back_ngc
		endif
	else
		<cag_helper_text>=cag_helper_text

		if IsXBox
			<cag_helper_text>=cag_helper_text_xbox
		endif
		if IsNGC
			<cag_helper_text>=cag_helper_text_ngc
		endif
	endif

	SetScreenElementLock id=root_window off
	create_helper_text <cag_helper_text> parent=root_window
	SetScreenElementLock id=root_window off
endscript

///////////////////////////////////////////////////////////////////////////////////////////////////////////
script create_edit_goal_menu
	GoalManager_HidePoints
	GoalManager_HideGoalPoints
	destroy_goal_panel_messages
	SetParkEditorPauseMode pause
	;PauseGame
	pause_menu_gradient on

	set_in_create_a_goal

	// If editing a gap goal and they have no gaps selected yet, go straight to the
	// gap select menu.
	;if (<goal_type> = Gap)
	;    if not GotParam Gaps
	;        goto create_gap_select_menu
	;    endif
	;endif

	FormatText ChecksumName=title_icon "%i_trick" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="EDIT GOAL" title_icon=<title_icon> pos=(235,80)

	GoalEditor:GetCurrentEditedGoalInfo

	if GotParam go_back_to_goal_list_menu
		back_params={go_back_to_goal_list_menu}
	else
		back_params={}
	endif

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back generic_menu_pad_back params={ callback=edit_goal_menu_back params=<back_params>}}
			;{ pad_back	generic_menu_pad_back_sound }
		]
		replace_handlers
	}

	switch <goal_type>
		case HighScore
			high_score_text="Set High Score"
		case HighCombo
			high_score_text="Set High Combo Score"
	endswitch

	switch <goal_type>
		case HighScore
		case HighCombo
			theme_menu_add_number_item {
				text=<high_score_text>
				id=goal_score
				min=1000
				max=10000000
				step=1000
				value=<score>
				pad_left_script=goal_update_score
				pad_right_script=goal_update_score
				first_item
				text_pos=(75, -5)
			}
		case SkateTris
			theme_menu_add_item {
				text="Edit Skate-Tricks"
				pad_choose_script=create_edit_skatetris_menu pad_choose_params=<back_params>
				first_item
				text_pos=(75, -5)
			}
		case ComboSkateTris
			theme_menu_add_item {
				text="   Edit Combo Skate-Tricks"
				pad_choose_script=create_edit_skatetris_menu pad_choose_params=<back_params>
				first_item
				text_pos=(75, -5)
			}
		case TrickTris
			theme_menu_add_item {
				text="Edit Tricktris"
				pad_choose_script=create_edit_skatetris_menu pad_choose_params=<back_params>
				first_item
				text_pos=(75, -5)
			}
		case Gap
			RemoveParameter not_focusable
			CreateGapList
			if (<array_size> = 0)
				extra_text="Error! Gaps deleted"
				not_focusable=1
			else
				if GotParam Gaps
					GetArraySize <Gaps>
					FormatText TextName=extra_text "%d gaps chosen" d=<array_size>
				else
					extra_text="No gaps chosen"
				endif
			endif

			theme_menu_add_item {
				text="Pick gaps"
				not_focusable=<not_focusable>
				extra_text=<extra_text>
				pad_choose_script=create_gap_select_menu
				first_item
				text_pos=(75, -5)
			}
			theme_menu_add_item {
				text="Required Trick"
				extra_text=<required_trick_name>
				pad_choose_script=input_required_trick_name
				text_pos=(75, -5)
			}
	endswitch

	theme_menu_add_item {
		text="Edit positions"
		pad_choose_script=edit_goal
		text_pos=(75, -5)
	}

	theme_menu_add_number_item {
		text="Set Time Limit"
		id=goal_time
		min=15
		max=3600
		step=5
		value=<time_limit>
		text_pos=(75, -5)
		pad_left_script=goal_update_time_limit
		pad_right_script=goal_update_time_limit
	}
	theme_menu_add_item {
		text="Name Goal"
		extra_text=<view_goals_text>
		text_pos=(75, -5)
		pad_choose_script=name_goal
	}
	theme_menu_add_item {
		text="Name Ped"
		extra_text=<ped_name>
		text_pos=(75, -5)
		pad_choose_script=name_goal_ped
	}
	theme_menu_add_item {
		text="Set Goal Text"
		text_pos=(75, -5)
		pad_choose_script=set_goal_text
	}

	theme_menu_add_item {
		text="Edit Win Message"
		text_pos=(75, -5)
		pad_choose_script=edit_goal_win_message
	}
	theme_menu_add_number_item {
		text="Control"
		text_pos=(75, -5)
		id=goal_control
		value=3
	}

	update_control_text control_type=<control_type>

	SetScreenElementProps {
		id=goal_control
		event_handlers=[
			{pad_left goal_update_control params={dir=-1}}
			{pad_right goal_update_control}
		]
		replace_handlers
	}

	theme_menu_add_item {
		text="Delete Goal"
		text_pos=(75, -5)
		pad_choose_script=delete_goal
		no_sound
	}
	if not CustomParkMode editing
		// Make it not testable if it is a gap goal and no gaps have
		// been set because such a goal will succeed straight away and sometimes
		// leave the ped doing his success anim with the player unable to exit.
		RemoveParameter not_focusable
		if (<goal_type>=gap)
			if not GotParam Gaps
				not_focusable=not_focusable
			endif
		endif

		theme_menu_add_item {
			text="Test Goal"
			text_pos=(75, -5)
			pad_choose_script=test_goal
			not_focusable=<not_focusable>
		}
	endif
	theme_menu_add_item {
		text="Done"
		pad_choose_script=edit_goal_menu_back
		no_sound
		last_item
		text_pos=(75, -5)
		last_menu_item=1
	}

	finish_themed_sub_menu

	create_helper_text generic_helper_text_up_down_adjust
endscript

script generate_control_name
	switch <control_type>
		case JunkerCar
			return control_text="Muscle Car"
		case RallyCar
			return control_text="Rally Car"
		case ImpalaCar
			return control_text="Trashed Car"
		case TaxiCar
			return control_text="Taxi Car"
		case PoliceCar
			return control_text="Police Car"
		case ElCaminoCar
			return control_text="Surfer Car"
		case LadaCar
			return control_text="Russian Car"
		case MiniBajaCar
			return control_text="Mini Baja Car"
		case LimoCar
			return control_text="Limousine"
		case LeafBlower
			return control_text="Leaf Blower Car"
		case WalkOnly
			return control_text="Walk Only"
		case Walk
			return control_text="Walk"
		case Skate
			return control_text="Skate"
		case SecurityCart
			return control_text="Security Cart"
		case GardnersCart
			return control_text="Gardener\'s Cart"
		case Blimp
			return control_text="Blimp"
		default
			return control_text="Update goal_editor_menu.q !!"
	endswitch
endscript

script update_control_text
	generate_control_name control_type=<control_type>
	SetScreenElementProps { id={ goal_control child=3 } text=<control_text> }
	GetStackedScreenElementPos X id={ goal_control child=3 } offset=(3,2)
	SetScreenElementProps { id={ goal_control child=5 } pos=<pos> }
endscript


control_types_basic=[Skate Walk WalkOnly]

control_types_NJ=[Skate Walk WalkOnly RallyCar]
control_types_NY=[Skate Walk WalkOnly ImpalaCar]
control_types_FL=[Skate Walk WalkOnly PoliceCar]
control_types_SD=[Skate Walk WalkOnly GardnersCart SecurityCart]
control_types_HI=[Skate Walk WalkOnly ElCaminoCar]
control_types_VC=[Skate Walk WalkOnly LeafBlower LimoCar]
control_types_SJ=[Skate Walk WalkOnly]
control_types_RU=[Skate Walk WalkOnly LadaCar]
control_types_SE=[Skate Walk WalkOnly minibajacar]
control_types_Sk5Ed=[Skate Walk WalkOnly minibajacar JunkerCar]

script goal_update_control dir=1
	GoalEditor:GetCurrentEditedGoalInfo

	switch <goal_type>
		case Skate
		case Gap
		case HighScore
			GetCurrentLevel
			switch <Level>
				case Load_NJ
					control_types=control_types_NJ
				case Load_NY
					control_types=control_types_NY
				case Load_FL
					control_types=control_types_FL
				case Load_SD
					control_types=control_types_SD
				case Load_HI
					control_types=control_types_HI
				case Load_VC
					control_types=control_types_VC
				case Load_SJ
					control_types=control_types_SJ
				case Load_RU
					control_types=control_types_RU
				case Load_SE
					control_types=control_types_SE
				case Load_Sk5Ed
				case Load_Sk5Ed_gameplay
					control_types=control_types_Sk5Ed
				default
					control_types=control_types_basic
			endswitch
		default
			control_types=control_types_basic
	endswitch

	GetArraySize <control_types>
	i=0
	begin
		if ChecksumEquals a=(<control_types>[<i>]) b=<control_type>
			break
		endif
		i=(<i>+1)
	repeat <array_size>

	if not (<i> < <array_size>)
		printf "Control type %s not found in list of available types!" s=<control_type>
		return
	endif

	i=(<i>+<dir>)
	if not (<i> < <array_size>)
		i=0
	endif
	if (<i> < 0)
		i=(<array_size>-1)
	endif

	control_type=(<control_types>[<i>])
	GoalEditor:SetGoalControlType <control_type>
	update_control_text control_type=<control_type>
endscript

script edit_goal_menu_back
	edit_goal_menu_exit no_exit_pause

	generic_menu_pad_choose_sound

	if CustomParkMode editing
		parked_continue_editing
	else
		create_existing_goals_menu
	endif
endscript

script create_gap_select_menu

	CreateGapList
	num_menu_lines=<array_size>
	if (<num_menu_lines> > 10)
		num_menu_lines=10
	endif
	if (<num_menu_lines> = 0)
		// A safeguard so that the loop cannot be sent a zero count
		return
	endif

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	FormatText ChecksumName=title_icon "%i_trick" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_scrolling_menu title="SELECT GAPS" title_icon=<title_icon> dims=((300,0)+(0,1)*23*<num_menu_lines>)


	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back create_edit_goal_menu}
			{ pad_back	generic_menu_pad_back_sound }
		]
		replace_handlers
	}


	if (<array_size> > 0)
		i=0
		begin
			params={}
			if (<i>=0)
				params={first_item}
			endif
			if (<i>=<array_size>-1)
				params=(<params>+{last_item})
			endif

			if CustomParkMode editing
				// The gaps are always focusable in park editing mode, since they already
				// know where the gap is.
			else
				if (<GapList>[<i>].times = 0)
					params=(<params>+{not_focusable=not_focusable})
				endif
			endif

			if GoalEditor:EditedGoalGotGap gap_number=<i>
				value=1
			else
				value=0
			endif

			FormatText ChecksumName=id "check%d" d=<i>


			theme_menu_add_checkbox_item {
				value=<value>
				id=<id>
				text=(<GapList>[<i>].gap_name)
				pad_choose_script=toggle_gap_on_off
				pad_choose_params={gap_number=<i>}

				focus_script=gap_select_menu_focus
				focus_params=(<GapList>[<i>])

				<params>
				no_bg=no_bg
			}


			i=(<i>+1)
		repeat <array_size>
	endif

	finish_themed_scrolling_menu wide_menu

endscript

script toggle_gap_on_off
	if GoalEditor:EditedGoalGotGap gap_number=<gap_number>
		GoalEditor:EditedGoalRemoveGap gap_number=<gap_number>
		theme_set_checkbox value=0
	else
		GoalEditor:EditedGoalAddGap gap_number=<gap_number>
		theme_set_checkbox value=1
	endif
endscript

script gap_select_menu_focus
	if not CustomParkMode editing
		gap_menu_focus_show_gap <...>
	endif
	theme_checkbox_focus
endscript

script create_edit_skatetris_menu

	// If no combo sets have been chosen, go straight to the combo sets menu
	count_chosen_combo_sets
	if (<num_chosen_combo_sets> = 0)
		gotopreserveparams create_key_combos_menu
	endif

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	GoalEditor:GetCurrentEditedGoalInfo

	FormatText ChecksumName=title_icon "%i_trick" i=(THEME_PREFIXES[current_theme_prefix])
	switch <goal_type>
		case ComboSkatetris
			make_new_themed_sub_menu title="COMBO SKATE-TRICKS" title_icon=<title_icon>
		case Tricktris
			make_new_themed_sub_menu title="EDIT TRICKTRIS" title_icon=<title_icon>
		default
			make_new_themed_sub_menu title="EDIT SKATE-TRICKS" title_icon=<title_icon>
	endswitch

	if GotParam go_back_to_goal_list_menu
		back_params={go_back_to_goal_list_menu}
	else
		back_params={}
	endif

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back create_edit_goal_menu params=<back_params>}
			{ pad_back	generic_menu_pad_back_sound }
		]
		replace_handlers
	}

	theme_menu_add_item {
		first_item
		text="Key combos"
		pad_choose_script=create_key_combos_menu
		pad_choose_params=<back_params>
		centered=1
	}

	theme_menu_add_number_item {
		text="Spin"
		id=goal_spin
		min=0
		max=900
		step=180
		avoid=180 ; 180 is not allowed, since cannot do it on vert
		value=<spin>
		pad_left_script=goal_update_spin
		pad_right_script=goal_update_spin
	}
	// Refresh to ensure that 0 gets converted to "Off"
	goal_update_spin value=<spin>

	switch <goal_type>
		case ComboSkatetris
			if GotParam single_combo
				value=1
				params={}
				NoSkatetrisParams=1
			else
				value=0
				params={on}
			endif
			theme_menu_add_checkbox_item {
				value=<value>
				id=SingleCombo
				text="Single Combo"
				pad_choose_script=change_single_combo pad_choose_params=<params>
			}

			// Ensure that combo size cannot be set to higher than max tricks, otherwise
			// the goal will fail straight away. (TT3852)
			if not GotParam NoSkatetrisParams
				max=<max_tricks>
			else
				max=15
			endif
			if (<combo_size> > <max>)
				combo_size=<max>
				GoalEditor:SetGoalSpecificParams combo_size=<max>
			endif

			theme_menu_add_number_item {
				text="Combo size"
				id=goal_combo_size
				min=1
				max=<max>
				step=1
				value=<combo_size>
				pad_left_script=goal_update_combo_size
				pad_right_script=goal_update_combo_size
			}
		case TrickTris
			theme_menu_add_number_item {
				text="Block size"
				id=goal_block_size
				min=1
				max=15
				step=1
				value=<tricktris_block_size>
				pad_left_script=goal_update_tricktris_block_size
				pad_right_script=goal_update_tricktris_block_size
			}
			theme_menu_add_number_item {
				text="Total to win"
				id=goal_total_to_win
				min=1
				max=1000
				step=1
				value=<tricktris_total_to_win>
				pad_left_script=goal_update_tricktris_total_to_win
				pad_right_script=goal_update_tricktris_total_to_win
			}
			NoSkatetrisParams=1
	endswitch

	if not GotParam NoSkatetrisParams
		theme_menu_add_number_item {
			text="Acceleration interval"
			id=goal_acceleration_interval
			min=1
			max=10
			step=1
			value=<acceleration_interval>
			pad_left_script=goal_update_acceleration_interval
			pad_right_script=goal_update_acceleration_interval
		}

		// Adding 0.01 because sometimes the float can be fractionally below an integer, causing
		// CastToInteger to round down.
		percent=(<acceleration_percent> * 100 + 0.01)
		CastToInteger percent
		theme_menu_add_number_item {
			text="Acceleration percent"
			id=goal_acceleration_percent
			min=1
			max=100
			step=1
			value=<percent>
			pad_left_script=goal_update_acceleration_percent
			pad_right_script=goal_update_acceleration_percent
		}

		theme_menu_add_number_item {
			text="Trick time"
			id=goal_trick_time
			min=5
			max=3000
			step=5
			value=<trick_time>
			pad_left_script=goal_update_trick_time
			pad_right_script=goal_update_trick_time
		}

		theme_menu_add_number_item {
			text="Time to stop adding tricks"
			id=goal_time_to_stop_adding_tricks
			min=5
			max=<time_limit>
			step=5
			value=<time_to_stop_adding_tricks>
			pad_left_script=goal_update_time_to_stop_adding_tricks
			pad_right_script=goal_update_time_to_stop_adding_tricks
		}

		theme_menu_add_number_item {
			text="Max tricks"
			id=goal_max_tricks
			min=1
			max=15
			step=1
			value=<max_tricks>
			pad_left_script=goal_update_max_tricks
			pad_right_script=goal_update_max_tricks
		}
	endif

	theme_menu_add_item {
		text="Done"
		pad_choose_script=create_edit_goal_menu
		pad_choose_params=<back_params>
		last_menu_item=1
	}

	finish_themed_sub_menu

	create_helper_text generic_helper_text_up_down_adjust
endscript

script edit_skatetris_cancel_keyboard
	destroy_onscreen_keyboard
	create_edit_skatetris_menu
endscript

script count_chosen_combo_sets
	GetArraySize cag_skatetris_key_combos
	num_chosen_combo_sets=0

	if (<array_size> > 0)
		i=0
		begin
			if GoalEditor:GetKeyComboSet set_index=<i>
				num_chosen_combo_sets=(<num_chosen_combo_sets>+1)
			endif
			i=(<i>+1)
		repeat <array_size>
	endif

	return num_chosen_combo_sets=<num_chosen_combo_sets>
endscript

script update_combo_sets_done_focusability
	count_chosen_combo_sets
	if (<num_chosen_combo_sets> > 0)
		SetScreenElementProps { id=combo_sets_done child=0 focusable}

		FormatText ChecksumName=off_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

		SetScreenElementProps { id={combo_sets_done child=0} rgba=<off_color>}
	else
		SetScreenElementProps { id=combo_sets_done child=0 not_focusable}
		SetScreenElementProps { id={combo_sets_done child=0} rgba=[64,64,64,64]}
	endif
endscript

script create_key_combos_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	FormatText ChecksumName=title_icon "%i_trick" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="SELECT KEY COMBOS" title_icon=<title_icon>

	if GotParam go_back_to_goal_list_menu
		back_params={go_back_to_goal_list_menu}
	else
		back_params={}
	endif

	SetScreenElementProps {
		id=sub_menu
		event_handlers=[ { pad_back create_edit_goal_menu params=<back_params>}
			{ pad_back	generic_menu_pad_back_sound }
		]
		replace_handlers
	}

	GetArraySize cag_skatetris_key_combos
	if (<array_size> > 0)
		i=0
		begin
			params={}
			if (<i>=0)
				params={first_item}
			endif

			if GoalEditor:GetKeyComboSet set_index=<i>
				value=1
			else
				value=0
			endif

			FormatText ChecksumName=id "check%d" d=<i>

			theme_menu_add_checkbox_item {
				value=<value>
				id=<id>
				text=(cag_skatetris_key_combos[<i>].text)
				pad_choose_script=toggle_keycombo_set_on_off
				pad_choose_params={set_index=<i>}
				<params>
			}


			i=(<i>+1)
		repeat <array_size>
	endif

	theme_menu_add_item {
		text="Done"
		id=combo_sets_done
		pad_choose_script=create_edit_skatetris_menu
		pad_choose_params=<back_params>
		last_menu_item=1
	}
	update_combo_sets_done_focusability

	finish_themed_sub_menu
endscript

script toggle_keycombo_set_on_off

	if GoalEditor:GetKeyComboSet set_index=<set_index>
		GoalEditor:RemoveKeyComboSet set_index=<set_index>
		theme_set_checkbox value=0
	else
		GoalEditor:AddKeyComboSet set_index=<set_index>
		theme_set_checkbox value=1
	endif

	update_combo_sets_done_focusability
endscript

script remove_key_combo_set
	GoalEditor:RemoveKeyComboSet set_index=<set_index>

	if GotParam go_back_to_goal_list_menu
		goto create_key_combos_menu params={go_back_to_goal_list_menu}
	else
		goto create_key_combos_menu
	endif
endscript

script goal_update_spin
	GoalEditor:SetGoalSpecificParams spin=<value>
	if (<value>=0)
		// Display 'Off' instead of 0 (TT3699)
		SetScreenElementProps { id={ goal_spin child=3 } text="Off" }
		// Refresh the right arrow position
		goal_spin:theme_menu_update_number_item_right_arrow
	endif
endscript

script change_single_combo
	if GotParam On
		GoalEditor:SetGoalSpecificParams single_combo
	else
		GoalEditor:RemoveGoalSpecificFlag single_combo

	endif
	create_edit_skatetris_menu

	if not GotParam On
		// They may have modified the combo size, so update max tricks
		GoalEditor:GetCurrentEditedGoalInfo
		validate_max_tricks max_tricks=<max_tricks> combo_size=<combo_size>
	endif

endscript

script goal_update_combo_size
	GoalEditor:SetGoalSpecificParams combo_size=<value>

	// If the combo size changes, check that any max_tricks value is within limits
	// otherwise the list of tricks will be able to scroll up and obscure the title text.
	GoalEditor:GetCurrentEditedGoalInfo
	if not GotParam single_combo
		if GotParam max_tricks
			validate_max_tricks max_tricks=<max_tricks> combo_size=<combo_size>
		endif
	endif
endscript

script validate_max_tricks
	RemoveParameter update_required

	begin
		blocks=(<max_tricks> / <combo_size>)
		if (<blocks>-1+<blocks>*<combo_size> < 17)
			break
		endif
		update_required=1
		max_tricks=(<max_tricks>-1)
	repeat 20 ; 20 is just to ensure no infinite loop

	// The update_required flag is important to prevent an infinite loop of events, since modifying the
	// max_tricks menu element will cause it to check and maybe modify the combo_size menu element too.
	if GotParam update_required
		// Important to set this before firing the event, to prevent an infinite event loop caused by the
		// other menu element's check using the old value.
		GoalEditor:SetGoalSpecificParams max_tricks=<max_tricks>
		// Update the value as displayed in the menu by firing a pad_left event with params containing the new value.
		// It would also work if a pad_right was fired, since both call the same script.
		FireEvent target=goal_max_tricks type=pad_left data={value=<max_tricks> NoStep}
	endif
endscript

script goal_update_tricktris_block_size
	GoalEditor:SetGoalSpecificParams tricktris_block_size=<value>
endscript

script goal_update_tricktris_total_to_win
	GoalEditor:SetGoalSpecificParams tricktris_total_to_win=<value>
endscript

script goal_update_acceleration_interval
	GoalEditor:SetGoalSpecificParams acceleration_interval=<value>
endscript

script goal_update_acceleration_percent
	GoalEditor:SetGoalSpecificParams acceleration_percent=(<value>/100.0)
endscript

script goal_update_trick_time
	GoalEditor:SetGoalSpecificParams trick_time=<value>
endscript

script goal_update_time_to_stop_adding_tricks
	GoalEditor:SetGoalSpecificParams time_to_stop_adding_tricks=<value>
endscript

script goal_update_max_tricks
	GoalEditor:SetGoalSpecificParams max_tricks=<value>

	// If the max_tricks changes, check that any combo_size value is within limits
	// otherwise the list of tricks will be able to scroll up and obscure the title text.
	GoalEditor:GetCurrentEditedGoalInfo
	if GotParam combo_size
		// First, update the max value allowed on the combo size element to be max tricks,
		// and adjust the existing combo size to be no bigger than max tricks. (TT3852)
		FireEvent target=goal_combo_size type=pad_left data={max=<value> NoStep}
		if (<combo_size> > <value>)
			combo_size=<value>
			GoalEditor:SetGoalSpecificParams combo_size=<combo_size>
			FireEvent target=goal_combo_size type=pad_left data={value=<combo_size> NoStep}
		endif

		// No adjust the combo size so that the number of tricks listed will never go off the top of the screen
		RemoveParameter update_required

		begin
			blocks=(<max_tricks> / <combo_size>)
			if (<blocks>-1+<blocks>*<combo_size> < 17)
				break
			endif
			update_required=1
			combo_size=(<combo_size>+1)
		repeat 20 ; 20 is just to ensure no infinite loop

		// The update_required flag is important to prevent an infinite loop of events, since modifying the
		// combo_size menu element will cause it to check and maybe modify the max_tricks menu element too.
		if GotParam update_required
			// Important to set this before firing the event, to prevent an infinite event loop caused by the
			// other menu element's check using the old value.
			GoalEditor:SetGoalSpecificParams combo_size=<combo_size>
			// Update the value as displayed in the menu by firing a pad_left event with params containing the new value.
			// It would also work if a pad_right was fired, since both call the same script.
			FireEvent target=goal_combo_size type=pad_left data={value=<combo_size> NoStep}
		endif
	endif
endscript



script input_required_trick_name
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	GoalEditor:GetCurrentEditedGoalInfo
	create_onscreen_keyboard {	allow_cancel
		; Don't make this bigger than MAX_GAP_TRICK_NAME_CHARS
		; (defined in goaleditorcomponent.h) or the code will assert.
		max_length=50
		keyboard_cancel_script=cag_cancel_keyboard
		keyboard_done_script=set_required_trick_name
		keyboard_title="REQUIRED TRICK"
		text=<required_trick_name>
	}
endscript

script set_required_trick_name
	GetTextElementString id=keyboard_current_string
	GoalEditor:SetGoalSpecificParams required_trick_name=<string>
	cag_cancel_keyboard
endscript


script test_goal
	edit_goal_menu_exit
	UnpauseGame
	Skater:Vibrate Off

	GoalManager_ShowPoints
	GoalManager_ShowGoalPoints

	GoalEditor:GetCurrentEditedGoalId
	GoalManager_EditGoal name=<goal_id> params={testing_goal}
	GoalManager_ActivateGoal name=<goal_id>
endscript

script edit_goal
	edit_goal_menu_exit DoNotSwitchEditorState NoDeactivate

	destroy_goal_panel_messages
	PauseGame


	delete_goal_editor_marker_objects

	SetActiveCamera id=GoalEditor
	set_in_create_a_goal

	pause_trick_text

	// In case they were running a created goal, end it, to prevent confusion if they
	// have chosen to edit the currently running goal.
	end_current_goal_run

	if LevelIs load_sk5ed
		// Make sure the rail editor is switched off and the park editor is paused (TT4955 and TT3048)
		SwitchOffRailEditor
		SetParkEditorPauseMode pause
	endif

	PauseSkater 0
	HideSkaterAndMiscSkaterEffects


	Debounce X time=0.2 clear=1
	Debounce Triangle time=0.2 clear=1
	GoalEditor:Unpause
	GoalEditor:Unsuspend
	GoalEditor:Unhide

	Change goal_editor_placement_mode=1

	SetScreenElementProps {
		id=root_window
		replace_handlers
		event_handlers=
		[
			{
				pad_start
				edit_goal_pad_start
			}
		]
	}

	// Fix to TT4145, where the goal start box would stay on screen during editing of a goal
	// if the ped had been placed near the skater.
	if ObjectExists id=goal_start_dialog
		DestroyScreenElement id=goal_start_dialog
	endif

	// Remove the goal from the goal manager before editing to make the old goal ped
	// disappear.
	GoalEditor:GetCurrentEditedGoalId
	if GoalManager_GoalExists name=<goal_id>
		GoalManager_RemoveGoal name=<goal_id>
	endif

	GoalEditor:EditGoal

	SetActiveCamera id=GoalEditor

	create_cag_helper_text PedPosition
endscript

script name_goal
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	GoalEditor:GetCurrentEditedGoalInfo
	create_onscreen_keyboard {	allow_cancel
		; Don't make this bigger than GOAL_NAME_BUFFER_SIZE-1
		; (defined in goaleditorcomponent.h) or the code will assert.
		max_length=16
		min_length=1
		keyboard_cancel_script=cag_cancel_keyboard
		keyboard_done_script=set_cag_goal_name
		keyboard_title="GOAL NAME"
		text=<view_goals_text>
	}
endscript

script cag_cancel_keyboard
	destroy_onscreen_keyboard
	create_edit_goal_menu
endscript

script set_cag_goal_name
	GetTextElementString id=keyboard_current_string
	GoalEditor:SetEditorGoalName name=<string>
	cag_cancel_keyboard
endscript

script name_goal_ped
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	GoalEditor:GetCurrentEditedGoalInfo
	create_onscreen_keyboard {	allow_cancel
		; Don't make this bigger than PED_NAME_BUFFER_SIZE-1
		; (defined in goaleditorcomponent.h) or the code will assert.
		max_length=16
		keyboard_cancel_script=cag_cancel_keyboard
		keyboard_done_script=set_cag_ped_name
		keyboard_title="PED NAME"
		text=<ped_name>
	}
endscript

script set_cag_ped_name
	GetTextElementString id=keyboard_current_string
	GoalEditor:SetEditorPedName name=<string>
	cag_cancel_keyboard
endscript

script set_goal_text
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	GoalEditor:GetCurrentEditedGoalInfo
	create_onscreen_keyboard {	allow_cancel
		text_block
		; Don't make this bigger than GOAL_DESCRIPTION_BUFFER_SIZE-1
		; (defined in goaleditorcomponent.h) or the code will assert.
		max_length=99
		keyboard_cancel_script=cag_cancel_keyboard
		keyboard_done_script=set_cag_goal_text
		keyboard_title="GOAL TEXT"
		text=<goal_description>
	}
endscript

script set_cag_goal_text
	GetTextElementString id=keyboard_current_string
	GoalEditor:SetEditorGoalDescription text=<string>
	cag_cancel_keyboard
endscript


script goal_update_score
	GoalEditor:SetGoalScore <value>
endscript

script goal_update_time_limit
	GoalEditor:SetGoalTimeLimit <value>
endscript

script edit_goal_win_message
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	GoalEditor:GetCurrentEditedGoalInfo
	create_onscreen_keyboard {	allow_cancel
		text_block
		; Don't make this bigger than GOAL_WIN_MESSAGE_BUFFER_SIZE-1
		; (defined in goaleditorcomponent.h) or the code will assert.
		max_length=99
		keyboard_cancel_script=cag_cancel_keyboard
		keyboard_done_script=set_goal_win_message
		keyboard_title="WIN MESSAGE"
		text=<win_message>
	}
endscript

script set_goal_win_message
	GetTextElementString id=keyboard_current_string
	GoalEditor:SetEditorGoalWinMessage text=<string>
	cag_cancel_keyboard
endscript


script delete_goal

	edit_goal_menu_exit no_exit_pause
	generic_menu_pad_choose_sound
	set_in_create_a_goal

	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	GoalEditor:GetCurrentEditedGoalInfo
	FormatText TextName=text "Are you sure you want to delete the goal %s ?" s=<view_goals_text>

	create_dialog_box { title="Delete Goal"
		text=<text>

		pos=(310 ,183)
		just=[center center]
		text_rgba=[88 105 112 128]

		buttons=
		[
			{ font=small text="No" pad_choose_script=delete_created_goal_dont_accept }
			{ font=small text="Yes" pad_choose_script=delete_created_goal_accept }
		]
	}
endscript

script delete_created_goal_accept
	change check_for_unplugged_controllers = 0
	GoalEditor:RemovedCreatedGoal
	create_existing_goals_menu
	change check_for_unplugged_controllers = 1
endscript

script delete_created_goal_dont_accept
	dialog_box_exit
	create_edit_goal_menu
endscript

script edit_goal_menu_exit
	reset_in_create_a_goal
	Skater:Vibrate Off

	if GotParam no_exit_pause
	else
		if GotParam DoNotSwitchEditorState
			my_exit_pause_menu DoNotSwitchEditorState
		else
			my_exit_pause_menu
		endif
		end_current_goal_run
	endif


	if not GotParam NoDeactivate
		DeactivateGoalEditor
	endif

	GoalEditor:GetCurrentEditedGoalInfo

	// Remove goal from goal manager first, if it is there already.
	if GoalManager_GoalExists name=<goal_id>
		GoalManager_RemoveGoal name=<goal_id>
	endif

	// Then add the new edited version, unless the goal type is gap and no gaps have been chosen,
	// because otherwise if such a goal is activated it will succeed straight away and someimtes
	// leave the ped doing his success anim with the player unable to exit.

	if not GoalEditor:GoalHasAllPositionsSet
		GoalEditor:RemovedCreatedGoal
		DontAddTheGoal=1
	endif

	if (<goal_type>=gap)
		if not GotParam Gaps
			DontAddTheGoal=1
		endif
	endif

	if not GotParam DontAddTheGoal
		// Since the goal has been edited, tell the goal editor it is unbeaten.
		GoalEditor:AddEditedGoalToGoalManager MarkUnbeaten
	endif

	if IsAlive name=<pro_name>
		<pro_name>:Die
	endif

	if not GotParam DontAddTheGoal
		GoalEditor:WriteEditedGoalNodePositions
		GoalManager_InitializeGoal name=<goal_id>
	endif

	if GotParam no_exit_pause
		PauseSkater 0
		// Re pause the game to force the goal-ped that was just created by GoalManager_InitializeGoal
		// to be paused. (Fixes TT3858, where the peds dialog box would pop up)
		unpausegame
		PauseGame
	endif
endscript

script delete_goal_editor_marker_objects
	i=0
	begin
		FormatText ChecksumName=object "GoalEditorMarkerObject%d" d=<i>

		if ObjectExists id=<object>
			<object>:Die
		endif
		i=(<i>+1)
	repeat 7
endscript

script DeactivateGoalEditor
	GoalEditor:Hide
	GoalEditor:Suspend

	if ObjectExists id=helper_text_anchor
		DestroyScreenElement id=helper_text_anchor
	endif

	delete_goal_editor_marker_objects

	if CustomParkMode editing
		SetActiveCamera id=parked_cam
	else
		SetActiveCamera id=skatercam0
		UnPauseSkater 0
		Skater:AddSkaterToWorld
	endif

endscript

// This script gets run by the c-code in goaleditorcomponent.cpp after the last letter is placed.
script goal_editor_finished_placing_letters
	Change goal_editor_placement_mode=0
	GoalEditor:Hide
	GoalEditor:Suspend

	create_edit_goal_menu
endscript

