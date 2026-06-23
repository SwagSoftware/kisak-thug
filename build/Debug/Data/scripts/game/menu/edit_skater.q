in_cinematic_sequence=0
in_net_setup_flow=0

CASCURRENTCOLOR=[12 44 67 110]

// @script / launch_cas / kills some spawnedscripts and loads the CAS level
script launch_cas

	SetGameType freeskate
	SetCurrentGameType

	select_skater_get_current_skater_name
	if not (<current_skater> = custom)
		load_pro_skater { profile=0 skater=0 name=custom }
	endif

	if GotParam face
		if (has_accepted_dnas = 1)
			if not IsOnline
				GetPreferenceChecksum pref_type=network device_type
				switch <checksum>
					case device_sony_modem
					case device_usb_modem
					case device_broadband_usb_pppoe
					case device_broadband_pc_pppoe
						goto face_dnas_warning
				endswitch
			endif
			change goto_face_menu=1
		else
			goto face_dnas_warning
		endif
	endif

	if GotParam face2
		change goto_face_menu=2
	endif

	if LevelIs load_skateshop
		change entered_cas_from_main=1
	endif

	main_menu_play_level level=load_CAS
endscript

goto_cad=0
entered_cas_from_main=0

script launch_cad
	change goto_cad=1
	launch_cas
endscript

script change_level_to_cad
	change goto_cad=1
	change_level level=load_cas
endscript

// ********************************************
// 			Pre create-a-skater menu
// ********************************************
script launch_pre_cas_menu
	load_cas_textures_to_main_memory

	// GJ:  Need to set the camera
	// as soon as the cutscene ends
	// or else there will be a glitch
	// (don't spawnscript it, either,
	// cause there'd still be a glitch)
	set_cas_cam

	if ( goto_cad=1 )
		if (in_cad_cutscene_sequence = 1)
			create_cad_intro_message
		else
			create_deck_design_menu wait_for_skater=wait_for_skater
		endif
	else
		create_pre_cas_menu wait_for_skater=wait_for_skater
	endif
endscript

script create_Cad_intro_message
	// make sure deck faces right way
	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentskaterprofileindex>
	if (<stance> = goofy)
		change was_goofy=1
		SetSkaterProfileInfo player=<currentSkaterProfileIndex> params={ stance=regular }
		RefreshSkaterModel skater=0 profile=<currentSkaterProfileIndex>
	endif

	Skater:SwitchOnBoard
	skater:PlayAnim Anim=BoardPlacement BlendPeriod=0 cycle
	skater:Obj_MoveToNode name=cad_deck_spot orient
	Skater:Obj_ShadowOff

	Debounce X 0.3
	create_dialog_box { title="Create-A-Deck Unlocked"
		text="Now that you're a Pro, you'll need to design your own Pro deck graphic."
		just=[center center]

		buttons=[   { font=small text="Ok" 	pad_choose_script=Cad_intro_message_exit  }
		]
		text_dims=(300,0)
		delay_input
	}
	RunScriptOnScreenElement cad_camera id=dialog_box_anchor params={ wait_for_skater=wait_for_skater }
endscript

script Cad_intro_message_exit
	dialog_box_exit
	create_deck_design_menu wait_for_skater=wait_for_skater
endscript

script pre_cas_menu_exit
	dialog_box_exit

	change entered_cas_from_main=0

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 frame
	endif

	<new_menu_script> <...>
endscript

script play_first_cutscene
	;WaitForEvent type=level_done_loading
	;UnpauseGame
	;PauseMusic 0
	PlayCutscene name="cutscenes\Intro_01.cut" exitScript=launch_pre_cas_menu dont_unload_anims
endscript

script show_intro_2
	killskatercamanim all
	unpausegame
	PlayCutscene name="cutscenes\Intro_02.cut" exitScript=end_intro_2 dont_unload_anims
endscript

script end_intro_2
	printf "finished intros... going to NJ"

	DisplayLoadingScreen Blank  // to keep screen black during glitches
	load_cas_textures_to_main_memory unload

	SetGameType career
	SetCurrentGameType

	exit_cas level=load_nj
endscript

script debug_the_cas
	load_cas_textures_to_main_memory unload
	killskatercamanim all
	restore_start_key_binding
	create_pause_menu
endscript

script set_cas_cam
	if LevelIs load_cas
		if GotParam wait_for_skater
			wait 3 gameframe
		endif

		GoalManager_HidePoints
		GoalManager_HideGoalPoints

		KillSkaterCamAnim all
		PlaySkaterCamAnim play_hold name=CAS_intro_cam

		Skater:Obj_ShadowOn shadowtype=detailed
		skater:pausePhysics
		MakeSkaterGoto SkateShopAI Params={NOSFX CAS_Screen}
		Skater:Obj_MoveToNode orient name=cas_player_restart
		Skater:SwitchOffBoard
		;skater:remove_skater_from_world
	endif
endscript

script exit_cas level=load_skateshop
	;KillSkaterCamAnim all
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		load_cas_textures_to_main_memory unload
	endif

	change entered_cas_from_main=0

	if not ( return_to_level[0] = null )
		level = (return_to_level[0])

		// reset flag
		array=return_to_level
		SetArrayElement arrayname=array index=0 newvalue=null
	endif

	change_level level=<level> <...>
endscript

script cas_overwrite_warning title='Overwrite' callback=cas_reset_skater_and_goto_menu
	create_snazzy_dialog_box {
		title=<title>
		text='Warning !\nAny unsaved changes to your current STORY/SKATER will be lost.\nContinue ?'
		text_dims=(400,0)

		pad_back_script = create_pre_cas_menu

		buttons=[
			{ font=small text='No' pad_choose_script=create_pre_cas_menu}
			{
				font=small text='Yes'
				pad_choose_script=pre_cas_menu_exit
				pad_choose_params =
				{
					new_menu_script=<callback>
				}
			}
		]
	}
endscript

script cas_reset_skater_and_goto_menu
	ResetToDefaultProfile name=custom partial=partial

	set_default_temporary_profiles

	// GJ:  we've entered the create-a-skater
	// menu track, so make him the active skater
	// (or else the catchup functions won't work)
	load_pro_skater name=custom

	UnsetGlobalFlag flag=CAREER_STARTED

	skateshop_create_cas_menu came_from_main_menu
endscript

script career_post_load

	// set the camera mode
	if not IsXBox
		if GetGlobalFlag flag=SCREEN_MODE_STANDARD
			if GetGlobalFlag flag=SCREEN_MODE_WIDE
				screen_setup_letterbox
			else
				screen_setup_standard
			endif
		else
			if GetGlobalFlag flag=SCREEN_MODE_WIDE
				screen_setup_widescreen
			endif
		endif
	endif

	// resets the default appearance, when changing back and forth between male and female
	set_default_temporary_profiles
endscript

script cas_post_load

	// resets the default appearance, when changing back and forth between male and female
	set_default_temporary_profiles
endscript

script jump_to_edit_skater
	dialog_box_exit
	skateshop_create_cas_menu came_from_main_menu
endscript

// *****************************
//       CAS MENU
// *****************************

came_to_cas_menu_from_main_menu = 0

script skateshop_create_cas_menu
	if GotParam came_from_main_menu
		change came_to_cas_menu_from_main_menu = 1
		;load_pro_skater name=custom
	else
		change came_to_cas_menu_from_main_menu = 0
	endif
	launch_edit_skater_menu <...>

	Skater:SwitchOffBoard
	Skater:Obj_MoveToNode orient name=cas_player_restart
endscript

// **********************************************
//
//                Edit Skater
//
// **********************************************

// index values used for remembering what option you chose
edit_skater_menu_level_1_index = 0
edit_skater_menu_level_2_index = 0

script launch_edit_skater_menu

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	GoalManager_HidePoints
	GoalManager_HideGoalPoints

	MakeSkaterGoto SkateShopAI Params={NoSFX CAS_Screen}
	change cas_cam_angle=0
	set_cas_cam

	create_edit_skater_menu <...> animate
endscript


script check_if_board_options_enabled

	<retVal> = 1

	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentSkaterProfileIndex>

	// ignore the no_edit flag
	//	if GotParam no_edit
	//		<retVal> = 0
	//	endif

	if GotParam group
		if GotParam no_edit_groups
			GetArraySize <no_edit_groups>
			<index> = 0
			begin
				if ( <no_edit_groups>[<index>] = <group> )
					<retVal> = 0
					break
				endif
				<index> = ( <index> + 1 )
			repeat <array_size>
		endif
	endif

	return is_enabled = <retVal>

endscript

script check_if_group_editable

	<retVal> = 1

	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentSkaterProfileIndex>

	if GotParam no_edit
		<retVal> = 0
	endif

	if GotParam group
		if GotParam no_edit_groups
			GetArraySize <no_edit_groups>
			<index> = 0
			begin
				if ( <no_edit_groups>[<index>] = <group> )
					<retVal> = 0
					break
				endif
				<index> = ( <index> + 1 )
			repeat <array_size>
		endif
	endif

	// these cheats conflict with the normal
	// scaling menus, so disable the menus
	// if the cheat is active
	if GotParam not_with_scaling_cheats
		if GetGlobalFlag flag=CHEAT_GORILLA
			<retVal> = 0
		endif
		if GetGlobalFlag flag=CHEAT_KID
			<retVal> = 0
		endif
		if GetGlobalFlag flag=CHEAT_BIGHEAD
			<retVal> = 0
		endif
	endif

	return is_enabled = <retVal>

endscript

script check_if_part_editable

	<retVal>=0
	//this is for making sure an item (ie. tattoo) is in place to be edited
	if GotParam part
		GetCurrentSkaterProfileIndex
		if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=<part>
			if (<desc_id>=None)
				<retVal>=0
			else
				<retVal>=1
			endif
		else
			<is_enabled>=0
		endif
	endif

	return is_enabled = <retVal>

endscript

script check_if_part_logoable

	<retVal> = 0

	if GotParam parts
		GetArraySize <parts>
		<index> = 0
		begin
			GetCurrentSkaterProfileIndex
			if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=(<parts>[<index>])
				GetActualCASOptionStruct part=(<parts>[<index>]) desc_id=<desc_id>
				if GotParam supports_logo
					<retVal> = 1
					break
				else
					<retVal> = 0
					break
				endif
			endif

			<index> = ( <index> + 1 )
		repeat <array_size>
	endif

	return is_enabled = <retVal>

endscript

script check_if_part_back_logoable

	check_if_part_logoable <...>

	if ( <is_enabled> = 1 )
		if GotParam parts
			GetArraySize <parts>
			<index> = 0
			begin
				GetCurrentSkaterProfileIndex
				if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=(<parts>[<index>])
					GetActualCASOptionStruct part=(<parts>[<index>]) desc_id=<desc_id>
					if gotparam no_back_logo
						return is_enabled = 0
					endif
				endif
				<index> = ( <index> + 1 )
			repeat <array_size>
		endif
	endif

	return is_enabled = <is_enabled>

endscript

script check_if_item_accessible

	<retVal> = 1

	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentskaterprofileindex>

	GetActualCASOptionStruct part=<part> desc_id=<desc_id>

	if GotParam	lockout_flags
		GetArraySize <lockout_flags>
		<index> = 0
		begin
			if GotParam (<lockout_flags>[<index>])
				<retVal> = 0
				break
			endif
			<index> = ( <index> + 1 )
		repeat <array_size>
	endif

	return is_enabled = <retVal>

endscript

script check_if_part_colorable

	<retVal> = 0

	if GotParam extra_script
		<extra_script>

		if (<is_enabled> = 0)
			return is_enabled = <is_enabled>
		endif
	endif

	if GotParam parts
		GetArraySize <parts>
		<index> = 0
		begin
			GetCurrentSkaterProfileIndex
			if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=(<parts>[<index>])
				GetActualCASOptionStruct part=(<parts>[<index>]) desc_id=<desc_id>
				if GotParam no_color
					<retVal> = 0
					break
				else
					<retVal> = 1
					break
				endif
			endif

			<index> = ( <index> + 1 )
		repeat <array_size>
	endif

	return is_enabled = <retVal>

endscript

script check_if_sleeve_colorable
	check_if_part_colorable	<...>

	if ( <is_enabled> = 0 )
		return is_enabled = <is_enabled>
	endif

	// do extra check to make sure the part has a sleeve color on it
	if GotParam parts
		GetArraySize <parts>
		<index> = 0
		begin
			GetCurrentSkaterProfileIndex
			if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=(<parts>[<index>])
				GetActualCASOptionStruct part=(<parts>[<index>]) desc_id=<desc_id>
				if GotParam multicolor
					<retVal> = <multicolor>
					break
				else
					<retVal> = 0
					break
				endif
			endif

			<index> = ( <index> + 1 )
		repeat <array_size>
	endif

	return is_enabled = <retVal>

endscript

script check_option_is_enabled
	<ret_val> = 1
	<is_enabled> = 1
	if GotParam is_enabled_script
		<is_enabled_script>	<is_enabled_params>

		if ( <is_enabled> = 0 )
			<ret_val> = 0
		endif
	endif

	if IsTrue worst_case_cas_debug
		return is_enabled = 1
	endif

	return is_enabled = <ret_val>
endscript

script check_option_is_visible
	<ret_val> = 1

	if GotParam is_visible_script
		<is_visible_script>	<is_visible_params>
		if ( <is_enabled> = 0 )
			<ret_val> = 0
		endif
	endif

	if GotParam is_visible_script2
		<is_visible_script2> <is_visible_params2>
		if ( <is_enabled> = 0 )
			<ret_val> = 0
		endif
	endif

	if IsTrue worst_case_cas_debug
		return is_visible = 1
	endif

	return is_visible = <ret_val>
endscript

script edit_skater_create_options_menu pad_back_script=edit_skater_create_main_menu

	killspawnedscript name=cas_pull_back_camera
	change pulled_back=0

	if StructureContains structure=(<options_array>[0]) group_title
		title = ((<options_array>[0]).group_title)
	endif

	if StructureContains structure=(<options_array>[0]) cad_part
		cad_part = ((<options_array>[0]).cad_part)
	endif

	//title
	if GotParam title
		if not GotParam title_icon
			FormatText ChecksumName=title_icon "%i_edit_skater" i=(THEME_PREFIXES[current_theme_prefix])
		endif
		build_theme_sub_title title=<title> title_icon=<title_icon>
	endif

	if GotParam category
		change current_cas_category=<category>
	else
		change current_cas_category=0
	endif

	edit_skater_create_menu_block {
		tab_texture=tab2
		middle_texture=repeat_piece2
		bottom_texture=menu_bottom
	}

	if GotParam cam_anim
		if not (<cam_anim>=fullbody)
			create_helper_text generic_helper_text_cas_z
		else
			create_helper_text generic_helper_text_cas
		endif
	else
		if ((in_deck_design = 1) || (in_boardshop=1))
			create_helper_text generic_helper_text
		else
			create_helper_text generic_helper_text_cas
		endif
	endif

	if GotParam parent_index
		; <pad_back_params> = { current_index=<parent_index> }
		change edit_skater_menu_level_1_index = <parent_index>
	endif

	if ( in_deck_design = 1 )
		pad_back_script=edit_skater_create_main_deck_menu
	endif

	if ( in_boardshop = 1 )
		pad_back_script=boardshop_create_main_menu
	endif

	edit_skater_create_scrolling_menu {
		tab=tab2
		pad_back_script=<pad_back_script>
		pad_back_params=<pad_back_params>
	}

	// deck layer graphic
	if GotParam cad_part
		get_part_current_desc_id part=<cad_part>
		if GotParam current_desc_id
			get_logo_texture part=<cad_part> desc_id=<current_desc_id>

			if ScreenElementExists id=deck_layer_graphic
				DestroyScreenElement id=deck_layer_graphic
			endif

			if StructureContains structure=(<options_array>[0]) deck_scaling
				rot_angle=-90
				scale=(0.5,0.9)
			else
				rot_angle=0
				scale=1.0
			endif

			CreateScreenElement {
				type=SpriteElement
				parent=edit_skater_anchor_middle
				id=deck_layer_graphic

				texture=<texture>
				scale=<scale>
				rot_angle=<rot_angle>
				pos=(185,125)
				just=[center center]
				z_priority=5
			}
		endif
	endif

	category_menu_set_focus

	if GotParam options_array
		GetArraySize <options_array>
		<index> = 0

		begin
			RemoveParameter not_focusable
			RemoveParameter is_enabled_script
			RemoveParameter is_visible_script

			// make it not selectable if the menu item is not enabled
			check_option_is_enabled ( <options_array>[<index>] )
			if ( <is_enabled> = 0 )
				AddParams not_focusable=not_focusable
			endif

			check_option_is_visible ( <options_array>[<index>] )
			if not ( <is_visible> = 0 )
				edit_skater_menu_add_item {
					( <options_array>[<index>] )
					tab=tab2
					index=<index>
					options_array=<options_array>
					not_focusable=<not_focusable>
					cam_anim=<cam_anim>
					category=<category>
					should_add_reset_tattoos=<should_add_reset_tattoos>
					should_add_reset_scaling=<should_add_reset_scaling>
				}
			endif

			<index> = ( <index> + 1 )
		repeat <array_size>
		; ForEachIn <options_array> do=edit_skater_menu_add_item params={ options_array=<options_array> tab=tab2 }
	endif

	// temp addition of preset scale things
	//	if GotParam should_add_preset_bodyshapes
	//		edit_skater_add_bodyshapes_to_menu
	//	endif

	if GotParam should_add_reset_tattoos
		edit_skater_menu_add_item {
			text='Clear all tattoos'
			pad_choose_script=cas_reset_all_tattoos
			tab=tab2
		}
	endif

	if GotParam should_add_reset_scaling
		edit_skater_menu_add_item {
			text='Reset all'
			pad_choose_script=cas_reset_all_scaling
			tab=tab2
		}
	endif

	edit_skater_menu_add_item {
		text='Done'
		pad_choose_script=<pad_back_script>
		tab=tab2
	}

	if GotParam cam_anim
		KillSkaterCamAnim all
		;PlaySkaterCamAnim name=<cam_anim> play_hold
		cas_setup_rotating_camera cam_anim=<cam_anim>
	endif

	// if we came from level 1 we always want to start back at the beginning of the menu
	if not GotParam from_level_1
		FireEvent type=focus target=current_menu data={ grid_index=edit_skater_menu_level_2_index }
	else
		FireEvent type=focus target=current_menu
	endif
endscript

script edit_skater_create_cas_menu pad_back_script=edit_skater_create_options_menu

	killspawnedscript name=cas_pull_back_camera
	change pulled_back=0

	/*if GotParam show_logos
		;if ObjectExists id=edit_skater_anchor_middle
		;	DestroyScreenElement id=edit_skater_anchor_middle
		;endif

		create_dialog_box {
			title="Loading..."
			text="Please wait. Loading logos."
			;pos=(320,185)
			;just=[center center]
			;text_rgba=[88 105 112 128]
			;text_scale=1
		}
		wait 20 gameframes
		SetScreenElementLock off id=edit_skater_anchor
	endif*/

	//title
	if GotParam text
		if not GotParam title_icon
			FormatText ChecksumName=title_icon "%i_edit_skater" i=(THEME_PREFIXES[current_theme_prefix])
		endif
		GetUpperCaseString <text>
		build_theme_sub_title title=<UpperCaseString> title_icon=<title_icon>
	endif

	;PrintStruct <...>

	if GotParam cam_anim_sub
		if not (<cam_anim_sub>=fullbody)
			create_helper_text generic_helper_text_cas_z
		else
			create_helper_text generic_helper_text_cas
		endif
	else
		if GotParam cam_anim
			if not (<cam_anim>=fullbody)
				create_helper_text generic_helper_text_cas_z
			endif
		else
			if ((in_deck_design = 1) || (in_boardshop = 1))
				create_helper_text generic_helper_text
			else
				create_helper_text generic_helper_text_cas
			endif
		endif
	endif


	edit_skater_create_menu_block tab_texture=tab3 middle_texture=repeat_piece3 bottom_texture=menu_bottom


	if GotParam show_logos
		// extra box for logos
		edit_skater_create_menu_block {	tab_texture=tab1
			parent=edit_skater_anchor_middle
			scale=(0.5,1)
			pos=(560, 240)
			id=edit_skater_logo_anchor
			tab_id=edit_skater_logo_tab
			bottom_id=edit_skater_logo_bottom
			hide_line=hide_line
		}
		show_logos=show_logos
	endif
	<pad_back_params> = { options_array=<options_array> cam_anim=<cam_anim> should_add_reset_tattoos=<should_add_reset_tattoos> should_add_reset_scaling=<should_add_reset_scaling> }

	if GotParam cam_anim_sub
		KillSkaterCamAnim all
		;PlaySkaterCamAnim name=<cam_anim_sub> play_hold
		cas_setup_rotating_camera cam_anim=<cam_anim_sub>
	endif

	if GotParam cam_angle
		spawnscript cas_rotate_camera_to_angle params={ angle=<cam_angle> }
	endif

	// the child id is the id of the parent menu option the user chose to get here
	if GotParam parent_index
		;if GotParam pad_back_params
		;	<pad_back_params> = { ( <pad_back_params> + { current_index=<parent_index> } ) }
		;else
		;	<pad_back_params> = { current_index=<parent_index> }
		;endif
		change edit_skater_menu_level_2_index = <parent_index>
	endif

	edit_skater_create_scrolling_menu tab=tab3 pad_back_script=<pad_back_script> pad_back_params={ <pad_back_params> category=<category> }

	category_menu_set_focus

	// find part arrays that belong in this menu
	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentSkaterProfileIndex>

	GetArraySize master_editable_list
	<master_size> = <array_size>
	<index> = 0
	<current_submenu> = <submenu>
	begin
		RemoveParameter colormenu
		RemoveParameter posmenu
		RemoveParameter submenu
		RemoveParameter no_pos
		RemoveParameter no_rot
		RemoveParameter no_scale

		AddParams ( master_editable_list[<index>] )

		<shouldDisplayList> = 0
		if ( <is_male> = 1 )
			if GotParam male
				<shouldDisplayList> = ( <male> = 1 )
			endif
		else
			if GotParam female
				<shouldDisplayList> = ( <female> = 1 )
			endif
		endif

		if GotParam submenu
			if ( <submenu> = <current_submenu> )
				if not ( <shouldDisplayList> = 0 )

					GetArraySize <part>
					if not GotParam startlist
						<part_index> = 0
					else
						// cuts down lag on long lists
						<part_index> = <startlist>
					endif

					begin
						if ( <array_size> > <part_index> )
							edit_skater_possibly_add_cas_item {
								( <part>[<part_index>] )
								part=<part>
								desc_id=<desc_id>
								index=<index>
								show_logos=<show_logos>
								part_index=<part_index>
								startlist=<startlist>
								endlist=<endlist>
							}
						else
							break
						endif
						<part_index> = (<part_index> + 1)
					repeat <array_size>
				endif
			endif
		endif

		// add color menu, if necessary
		if GotParam colormenu
			if ( <colormenu> = <current_submenu> )
				if not ( <shouldDisplayList> = 0 )
					// hide the arrows
					if ScreenElementExists id=edit_skater_menu_up_arrow
						DoScreenElementMorph {
							id=edit_skater_menu_up_arrow
							scale=0
							relative_scale
						}
					endif
					if ScreenElementExists id=edit_skater_menu_down_arrow
						DoScreenElementMorph {
							id=edit_skater_menu_down_arrow
							scale=0
							relative_scale
						}
					endif
					colormenu_add_options_to_menu part=<part> from_cas
					if (<current_submenu> = skin_color_menu)
						cas_setup_rotating_camera name=fullbody play_hold
						create_helper_text generic_helper_text_color_menu
					else
						if GotParam cam_anim
							if not (<cam_anim>=fullbody)
								create_helper_text generic_helper_text_color_menu_z scale=0.9
							endif
						endif
					endif
				endif
			endif
		endif

		// add pos menu, if necessary
		if GotParam posmenu
			if ( <posmenu> = <current_submenu> )
				if not ( <shouldDisplayList> = 0 )
					// hide the arrows
					if ScreenElementExists id=edit_skater_menu_up_arrow
						DoScreenElementMorph {
							id=edit_skater_menu_up_arrow
							scale=0
							relative_scale
						}
					endif
					if ScreenElementExists id=edit_skater_menu_down_arrow
						DoScreenElementMorph {
							id=edit_skater_menu_down_arrow
							scale=0
							relative_scale
						}
					endif

					posmenu_add_options_to_menu part=<part> from_cas no_pos=<no_pos> no_rot=<no_rot> no_scale=<no_scale>
					if GotParam cam_anim
						if not (<cam_anim>=fullbody)
							if isNGC
								create_helper_text generic_helper_text_color_menu_reset_ngc
							else
								create_helper_text generic_helper_text_color_menu_reset
							endif
						endif
					endif

					// don't add done item to pos menus
					dialog_box_exit
					FireEvent type=focus target=current_menu
					return
				endif
			endif
		endif

		<index> = ( <index> + 1 )
	repeat <master_size>

	// add scaling elements, if necessary
	if GotParam should_add_scaling_options
		scalingmenu_add_options_to_menu part=<bone_group> <scaling_params>
		if isNGC
			create_helper_text generic_helper_text_color_menu_reset_ngc
		else
			create_helper_text generic_helper_text_color_menu_reset
		endif
		if GotParam cam_anim_sub
			if not (<cam_anim_sub>=fullbody)
				create_helper_text generic_helper_text_color_menu_z scale=0.9
			endif
		else
			create_helper_text generic_helper_text_color_menu scale=0.9
		endif
	endif

	edit_skater_menu_add_item {
		text='Done'
		tab=tab3
		text_pos=(0,0)
		dims=(10,33)
		;text_pos=(0,-5)
		pad_choose_script=<pad_back_script>
		pad_choose_params={
			options_array=<options_array>
			cam_anim=<cam_anim>
			should_add_reset_tattoos=<should_add_reset_tattoos>
			should_add_reset_scaling=<should_add_reset_scaling>
			category=<category>
		}
	}

	if (<current_submenu> = wheel_color_menu)
		doscreenelementmorph id=edit_skater_menu_down_arrow pos=(150,283) scale=1
		doscreenelementmorph id=edit_skater_menu_up_arrow pos=(150,132) scale=1
	endif
	dialog_box_exit
	FireEvent type=focus target=current_menu ; data={ grid_index=<index> }
endscript

script edit_skater_create_scrolling_menu dims=(256, 216) arrow_scale=1
	switch <tab>
		case tab2
			<menu_offset>=(134, 35)
			<up_arrow_offset>=(119, 5)
			<down_arrow_offset>=(119, -12)
		case tab3
			<menu_offset>=(143, 35)
			<up_arrow_offset>=(127, 5)
			<down_arrow_offset>=(127, -12)
			padding_scale=0.75
			dims=(256, 222)
		default
			<menu_offset>=(135, 35)
			<up_arrow_offset>=(120, 5)
			<down_arrow_offset>=(120, -12)
	endswitch

	if (( in_deck_design = 1 ) || ( in_boardshop = 1) )
		dims=(256, 125)
		if not (( <tab> = tab3 ) || (( in_boardshop = 1) && <tab>=tab2))
			arrow_scale=0
		else
			padding_scale=0.7
			arrow_scale=0.75
		endif
	endif

	// top category menu
	if not GotParam no_category_menu
		build_cas_category_menu
	endif

	// up arrow
	GetStackedScreenElementPos Y id=edit_skater_menu_tab offset=<up_arrow_offset>
	CreateScreenElement {
		type=SpriteElement
		parent=edit_skater_anchor_middle
		id=edit_skater_menu_up_arrow

		texture=up_arrow
		pos=<pos>
		just=[left top]
		z_priority=5
		scale=<arrow_scale>
	}
	// bottom arrow
	GetStackedScreenElementPos Y id=edit_skater_menu_block_bottom offset=<down_arrow_offset>
	CreateScreenElement {
		type=SpriteElement
		parent=edit_skater_anchor_middle
		id=edit_skater_menu_down_arrow

		texture=down_arrow
		pos=<pos>
		just=[left bottom]
		z_priority=5
		scale=<arrow_scale>
	}

	GetStackedScreenElementPos Y id=edit_skater_menu_tab offset=<menu_offset>
	CreateScreenElement {
		type=VScrollingMenu
		parent=edit_skater_anchor_middle
		id=edit_skater_scrollingmenu

		dims=<dims>
		pos=<pos>
		just=[left top]
	}

	CreateScreenElement {
		type=VMenu
		parent=edit_skater_scrollingmenu
		id=edit_skater_vmenu

		; pos=<pos>
		just=[left top]
		dont_allow_wrap
		padding_scale=<padding_scale>
		spacing_between=<spacing_between>

		event_handlers=[ { pad_up 		set_which_arrow params={ arrow=edit_skater_menu_up_arrow } }
			{ pad_down		set_which_arrow params={ arrow=edit_skater_menu_down_arrow } }
			{ pad_up 		generic_menu_up_or_down_sound params={ up } }
			{ pad_down		generic_menu_up_or_down_sound params={ down } }
			{ pad_back		generic_menu_pad_back_sound }	//this pad choose must come first or sound won't play
			{ pad_back 	<pad_back_script> params=<pad_back_params> }
			{ pad_space	toggle_cas_options_menu params={ } }
			{ pad_backspace	toggle_cas_options_menu params={ reverse } }
		]

	}

	// hook up rotate skater command if we're in the skateshop
	if LevelIs load_cas
		if ( in_deck_design = 0 )
			SetScreenElementProps {
				id=edit_skater_vmenu
				event_handlers=[ { pad_l1	cas_rotate_camera_left }
					{ pad_r1	cas_rotate_camera_right }
					;{ pad_l1	cas_rotate_skater_left }
					;{ pad_r1	cas_rotate_skater_right }
					{ pad_alt	spawn_cas_pull_back_camera }
				]
				replace_handlers
			}
		endif
	endif

	AssignAlias id=edit_skater_vmenu alias=current_menu
endscript


current_cas_category=0

script toggle_cas_options_menu
	if ( current_cas_category = 0 )
		return
	endif

	if not GotParam reverse
		if not ( current_cas_category = 6 )
			category = ( current_cas_category + 1 )
		else
			category = 1
		endif
	else
		if not ( current_cas_category = 1 )
			category = ( current_cas_category - 1 )
		else
			category = 6
		endif
	endif

	switch <category>
		case 1
			params={ options_array=edit_skater_head_options cam_anim=head from_level_1 }
		case 2
			params={ options_array=edit_skater_torso_options cam_anim=torso from_level_1 }
		case 3
			params={ options_array=edit_skater_leg_options cam_anim=legs from_level_1 }
		case 4
			params={ options_array=edit_skater_tattoo_options cam_anim=fullbody from_level_1 should_add_reset_tattoos=1 }
		case 5
			params={ options_array=edit_skater_scaling_options cam_anim=fullbody from_level_1 should_add_reset_scaling=1 }
		case 6
			params={ options_array=edit_skater_pad_options cam_anim=fullbody from_level_1 }
	endswitch

	PlaySound DE_MenuSelect vol=100

	if GotParam params
		edit_skater_create_options_menu { <params> category=<category> }
	endif
endscript

script get_current_skater_griptape_menu_enabled
	<retVal> = 1
	GetCurrentSkaterProfileIndex
	if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=board
		GetActualCASOptionStruct part=board desc_id=<desc_id>
		if GotParam	no_griptape
			<retVal> = 0
		endif
	endif
	return griptape_menu_enabled=<retVal>
endscript

script get_current_skater_use_jets
	<retVal> = 0
	GetCurrentSkaterProfileIndex
	if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=board
		GetActualCASOptionStruct part=board desc_id=<desc_id>
		if GotParam	use_jets
			<retVal> = 1
		endif
	endif
	return use_jets=<retVal>
endscript

script get_current_skater_name
	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentSkaterProfileIndex>
	return name=<name>
endscript

script get_current_skater_sponsors
	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentSkaterProfileIndex>
	return sponsors=<sponsors>
endscript

script get_skater_unlocked
	GetSkaterProfileInfoByName name=<name>

	if GotParam is_hidden
		if ( <is_hidden> = 0 )
			return is_unlocked=1
		else
			return is_unlocked=0
		endif
	else
		return is_unlocked=1
	endif

endscript

script get_is_neversoft_skater
	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentSkaterProfileIndex>
	if ( <is_pro> = 1 )
		return is_neversoft_skater=0
	else
		return is_neversoft_skater=<is_head_locked>
	endif
endscript

script get_has_weird_hat

	<retVal> = 0

	GetCurrentSkaterProfileIndex
	if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=hat
		GetActualCASOptionStruct part=hat desc_id=<desc_id>
		if GotParam is_weird_hat
			<retVal> = 1
		endif
	endif

	return has_weird_hat=<retVal>

endscript

script get_has_weird_head

	<retVal> = 0

	GetCurrentSkaterProfileIndex
	if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=skater_m_head
		GetActualCASOptionStruct part=skater_m_head desc_id=<desc_id>
		if GotParam is_weird_head
			<retVal> = 1
		endif
	endif

	return has_weird_head=<retVal>

endscript

script cas_item_is_visible
	<is_visible> = 1

	if GotParam hidden
		<is_visible> = 0
	endif

	if GotParam only_with
		get_current_skater_name
		GetArraySize <only_with>
		<index> = 0
		<is_visible> = 0
		begin
			if ChecksumEquals a=<name> b=(<only_with>[<index>])
				<is_visible> = 1
			endif
			<index> = ( <index> + 1 )
		repeat <array_size>
	endif

	if GotParam unlock_flag
		<is_visible> = 0
		if GetGlobalFlag flag=<unlock_flag>
			<is_visible> = 1
			<secret_color> = secret_color
		endif
	endif

	if GotParam sponsor
		get_current_skater_sponsors
		if GotParam sponsors
			GetArraySize <sponsors>

			if  ( <array_size> = 0 )
				// if no sponsors are listed,
				// then it's assumed that
				// he can access ALL sponsors
			else
				<is_visible> = 0
				<index> = 0
				begin
					if ChecksumEquals a=<sponsor> b=(<sponsors>[<index>])
						<is_visible> = 1
					endif
					<index> = ( <index> + 1 )
				repeat <array_size>
			endif
		endif
	endif

	if GotParam only_if_unlocked
		<is_visible> = 0
		get_skater_unlocked name=<only_if_unlocked>
		if ( <is_unlocked> = 1 )
			<is_visible> = 1
		endif
	endif

	if GotParam only_with_neversoft_skater
		<is_visible> = 0
		get_is_neversoft_skater
		if ( <is_neversoft_skater> = 1 )
			<is_visible> = 1
		endif
	endif

	if GotParam not_with_weird_head
		get_has_weird_head
		if ( <has_weird_head> = 1 )
			<is_visible> = 0
		endif
	endif

	if GotParam not_with_weird_hat
		get_has_weird_hat
		if ( <has_weird_hat> = 1 )
			<is_visible> = 0
		endif
	endif

	// don't try to do more than one of these
	// special flags at the same time,
	// or else it may not work...

	if IsTrue worst_case_cas_debug
		<is_visible> = 1
	endif

	return is_visible=<is_visible> secret_color=<secret_color>

endscript

script edit_skater_possibly_add_cas_item
	cas_item_is_visible <...>

	// is this item currently on the skater?
	get_part_current_desc_id part=<part>
	if GotParam current_desc_id
		if ( <desc_id> = <current_desc_id> )
			current_part=current_part
		endif
	endif

	if GotParam secret_color
		// show these items in a special color
		<rgba>=[32 32 255 128]
		focus_params={rgba=[32 32 255 255]}
		unfocus_params={rgba=[32 32 255 128]}
	endif

	if GotParam startlist
		if not ( (<part_index>+1) > <startlist> )
			return
		endif
	endif

	if GotParam endlist
		if not ( (<endlist>+1) > <part_index> )
			return
		endif
	endif

	if GotParam show_logos
		if GotParam with
			GetTextureFromPath path=<with>
			FormatText checksumname=texture_name "%t" t=<texture>
			texture=<texture_name>
		endif
	endif

	if ( <is_visible> = 1 )
		if not GotParam FrontEnd_Desc
			<frontend_desc>='Unknown'
		endif
		edit_skater_menu_add_item {
			text=<frontend_desc>
			tab=tab3
			pad_choose_script=cas_add_item
			pad_choose_params={ part=<part> desc_id=<desc_id> }
			focus_script=<focus_script>
			focus_params=<focus_params>
			unfocus_script=<unfocus_script>
			unfocus_params=<unfocus_params>
			index=<index>
			is_visible_script = check_if_item_accessible
			is_visible_params = { part=<part> desc_id=<desc_id> }
			//			is_enabled_script = check_if_item_accessible
			//  		is_enabled_params = { part=<part> desc_id=<desc_id> }
			rgba=<rgba>
			text_pos=(0,0)
			dims=(10,30)
			show_logos=<show_logos>
			texture=<texture>
			current_part=<current_part>
		}

		return cas_item_was_added = 1
	endif
endscript

script get_part_current_desc_id
	GetPlayerAppearancePart player=0 part=<part>
	return current_desc_id=<desc_id>
endscript

script edit_skater_icon_menu_add_item
	if GotParam child_texture
		if GotParam deck_icon
			focus_script=edit_skater_menu_focus_with_deck_icon
		else
			focus_script=edit_skater_menu_focus_with_icon
		endif
		unfocus_script=edit_skater_menu_unfocus_with_icon
	endif
	edit_skater_menu_add_item <...>
endscript

script edit_skater_menu_add_item { pad_choose_script=edit_skater_create_cas_menu
		focus_script=edit_skater_menu_focus
		unfocus_script=edit_skater_menu_unfocus
		tab=tab1
		font=small
		icon_scale=0
		;icon_pos=(-94, 0)
		icon_pos=(-120, 0)
		text_just=[center center]
		text_pos=(0, 0)
		dims=(10,25)
		bar_pos=(-4, 0)
	}


	printf <text>

	if not GotParam icon_rgba
		FormatText ChecksumName=icon_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	endif
	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	if GotParam current_part
		rgba=CASCURRENTCOLOR
		unfocus_params={ <unfocus_params> text_rgba=<rgba> }
	endif

	// abort early if the menu item is not visible...
	if GotParam is_visible_script
		<is_visible_script> <is_visible_params>
		if ( <is_enabled> = 0 )
			return
		endif
	endif

	// gray it out if the menu item is not editable...
	<is_enabled>=1
	if GotParam is_enabled_script
		<is_enabled_script>	<is_enabled_params>
		if ( <is_enabled> = 0 )
			AddParams not_focusable=not_focusable
		endif
	endif

	highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )

	// figure the right scale for the highlight bar
	switch <tab>
		case tab1
			<bar_scale>=(1.84, 0.7)
		case tab2
			<bar_scale>=(1.7, 0.7)
		case tab3
			if GotParam show_logos
				<bar_scale>=(2.55, 0.7)
				bar_pos=(60, 0)
				highlight_angle=(<highlight_angle> / 2 )
				dims=(10,50)
				focus_script=edit_skater_menu_logo_focus
				unfocus_script=edit_skater_menu_logo_unfocus
			else
				<bar_scale>=(1.5, 0.7)
			endif
			<font>=dialog
	endswitch

	SetScreenElementLock id=current_menu off

	FormatText checksumname=id "%i" i=<text>

	if not GotParam pad_choose_params
		<pad_choose_params> = { <...> id=<id> unfocus_script=<unfocus_script> unfocus_params=<unfocus_params> category=<category> }
	else
		<pad_choose_params> = { <pad_choose_params> id=<id> unfocus_script=<unfocus_script> unfocus_params=<unfocus_params> category=<category> }
	endif

	// create a container for this vmenu element
	if GotParam index
		if GotParam pad_choose_params
			<pad_choose_params> = ( <pad_choose_params> + { parent_index=<index> cam_anim=<cam_anim> show_logos=<show_logos> } )
		else
			<pad_choose_params> = { parent_index=<index> cam_anim=<cam_anim> show_logos=<show_logos> }
		endif
	else
		<pad_choose_params> = { <pad_choose_params> show_logos=<show_logos> }
	endif
	CreateScreenElement {
		type=ContainerElement ;TextElement
		parent=current_menu

		;font=small
		;text=" "
		dims=<dims>
		event_handlers=[ { focus		<focus_script> params=<focus_params> }
			{ unfocus		<unfocus_script> params=<unfocus_params> }
			{ pad_choose	generic_menu_pad_choose_sound } 	//this pad choose must come first or sound won't play
			{ pad_choose	<pad_choose_script> params=<pad_choose_params> }
			{ pad_start	<pad_choose_script> params=<pad_choose_params> }
		]
		id=<id>
		<not_focusable>
	}

	<parent_id> = <id>

	if GotParam index
		SetScreenElementProps {
			id=<parent_id>
			tags={ tag_grid_x=<index> }
		}
	endif

	// add the text
	if GotParam not_focusable
		;<rgba> = [60 60 60 85]
		alpha=0.6
	else
		alpha=1.0
	endif

	CreateScreenElement {
		type=TextElement
		parent=<parent_id>

		font=<font>
		text=<text>
		scale=0.9
		rgba=<rgba>
		alpha=<alpha>
		just=<text_just>
		pos=<text_pos>
		z_priority=9

		replace_handlers
		<not_focusable>
	}

	// highlight bar
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>

		pos=<bar_pos>
		scale=<bar_scale>
		texture=de_highlight_bar
		rgba=[128 128 128 0]
		rot_angle=<highlight_angle>
	}

	// add the icon if there is one
	if GotParam child_texture
		CreateScreenElement {
			type=SpriteElement
			parent=<parent_id>

			texture=<child_texture>
			pos=<icon_pos>
			rgba=<icon_rgba>
			scale=<icon_scale>
			id=<icon_id>
			z_priority=9
			just=[left center]
		}
	endif

	// add the logo if needed
	if ( <tab> = tab3 )
		if not ( <text> = 'None' )
			if GotParam show_logos

				if not GotParam texture
					printf "aaaaaaaaaaaaaahhhhhhhhhhhhhhhhhh"
					get_logo_texture part=( <pad_choose_params>.part ) desc_id=( <pad_choose_params>.desc_id )
				endif

				part = ( <pad_choose_params>.part )
				isadeck = ( (<part>[0]).is_a_deck )
				scaleitdown = ( (<part>[0]).scale_it_down )
				hatlogo = ( (<part>[0]).hat_logo )

				if GotParam isadeck
					scale=(0.5,0.925)
					rot_angle=-90
				else
					if GotParam scaleitdown
						scale=0.65
						rot_angle=0
					else
						if GotParam hatlogo
							rot_angle=-90
						else
							scale=1.2
							rot_angle=0
						endif
					endif
				endif

				CreateScreenElement {
					type=SpriteElement
					parent=<parent_id>

					texture=<texture>
					pos=(163,0)
					scale=<scale>
					alpha=0.3
					rot_angle=<rot_angle>
					z_priority=9
					just=[center center]
				}
			endif
		endif
	endif

	SetScreenElementLock id=current_menu on
endscript

// uses part and desc id to get texture to display in menu
script get_logo_texture
	GetArraySize <part>
	index=0
	begin
		if ( ((<part>[<index>]).desc_id) = <desc_id> )
			path = ( (<part>[<index>]).with )
			if GotParam path
				GetTextureFromPath path=<path>
				FormatText checksumname=texture_name "%t" t=<texture>
				return texture=<texture_name>
			else
				return
			endif
		endif
		index=(<index> + 1)
	repeat <array_size>
endscript


script edit_skater_info_add_item { pad_choose_script=nullscript
		pad_right_script=nullscript
		pad_left_script=nullscript
		focus_script=edit_skater_info_focus
		unfocus_script=edit_skater_info_unfocus
		tab=tab2
		text_pos=(78,8)
		left_arrow_pos =(90, 6)
		right_arrow_pos=(130, 6)
	}

	SetScreenElementLock id=current_menu off

	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		id=<item_id>

		event_handlers=[ { focus		<focus_script> 		params=<focus_params> }
			{ unfocus		<unfocus_script> 	params=<unfocus_params> }
			{ pad_choose	<pad_choose_script> params=<pad_choose_params> }
			{ pad_start	<pad_choose_script> params=<pad_choose_params> }
			{ pad_right	<pad_right_script>  params=<pad_right_params> }
			{ pad_left		<pad_left_script>   params=<pad_left_params> }
		]
		dims=(300, 30)
		<not_focusable>
	}

	<parent_id> = <id>

	if GotParam index
		SetScreenElementProps {
			id=<parent_id>
			tags={ tag_grid_x=<index> }
		}
	endif

	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	if GotParam top_row
		SetScreenElementProps { id=<parent_id>
			event_handlers=[ { pad_choose	generic_menu_pad_choose_sound }
				{ pad_choose	<pad_choose_script> params=<pad_choose_params> } ]
		} replace_handlers
	endif

	if GotParam no_bg
		SetScreenElementProps { id=<parent_id>
			event_handlers=[ { pad_choose	generic_menu_pad_choose_sound }
				{ pad_choose	<pad_choose_script> params=<pad_choose_params> } ]
		} replace_handlers
	endif

	// text
	CreateScreenElement {
		type=TextElement
		parent=<parent_id>

		font=testtitle
		text=<text>
		scale=0.9
		rgba=<rgba>
		just=[right center]
		pos=<text_pos>

		replace_handlers
		<not_focusable>
	}

	if not GotParam no_bg
		// add the bg sprite
		CreateScreenElement {
			type=SpriteElement
			parent=<parent_id>

			pos=(-50, -6)
			scale=(2.7,1)
			just=[left top]
			texture=edit_bar
			rgba=[128 128 128 60]
			alpha=0.5
			z_priority=4
		}

		// text value
		CreateScreenElement {
			type=TextElement
			parent=<parent_id>

			font=dialog
			text=<item_value_text>
			scale=.8
			rgba=<rgba>
			just=[left center]
			pos=(100,6)
			not_focusable=not_focusable
		}
		value_id=<id>

		truncate_string id=<id> max_width=195

		if not GotParam top_row
			// add the left arrow
			CreateScreenElement {
				type=SpriteElement
				parent=<parent_id>

				pos=<left_arrow_pos>
				scale=(0.6, 0.6)
				texture=left_arrow
				rgba=[128 128 128 0]
			}

			GetStackedScreenElementPos X id=<value_id> offset=(11,10)
			// add the right arrow
			CreateScreenElement {
				type=SpriteElement
				parent=<parent_id>

				pos=<pos>
				scale=(0.6, 0.6)
				texture=right_arrow
				rgba=[128 128 128 0]
			}
		endif

		// black box
		CreateScreenElement {
			type=SpriteElement
			parent=<parent_id>

			pos=(-50, -6)
			scale=(86.4,7)
			just=[left top]
			texture=black
			rgba=[0 0 0 128]
			alpha=0.0
			z_priority=4
		}
	endif
endscript


script edit_skater_create_menu_block {	tab_texture=tab1
		parent=edit_skater_anchor
		middle_texture=repeat_piece
		bottom_texture=menu_bottom
		scale=(0.95,1)
		parts=8
		pos=(320, 230)
		id=edit_skater_anchor_middle
		bottom_id=edit_skater_menu_block_bottom
	}
	if ObjectExists id=<id>
		DestroyScreenElement id=<id>
	endif

	FormatText ChecksumName=bg_piece_rgba "%i_BG_PARTS_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=<id>

		pos=<pos>
		dims=(640, 480)
	}
	anchor_id=<id>

	if (( in_deck_design = 1 ) || (in_boardshop = 1))
		parts=5
	endif

	edit_skater_menu_create_tab texture=<tab_texture> rgba=<bg_piece_rgba> scale=<scale> tab_id=<tab_id> parent=<anchor_id> hide_line=<hide_line>

	// main bg
	<piece_id> = edit_skater_menu_tab
	begin
		GetStackedScreenElementPos Y id=<piece_id>
		CreateScreenElement {
			parent=<anchor_id>
			type=SpriteElement

			texture=<middle_texture>
			rgba=<bg_piece_rgba>
			scale=<scale>
			pos=<pos>
			just=[left top]
		}
		piece_id=<id>
		// used by logo menus to hide red line down middle
		if GotParam hide_line
			CreateScreenElement {
				parent=<piece_id>
				type=SpriteElement

				texture=white2
				scale=(31.5,4);(61,8)
				pos=(0,0)
				rgba=[10 10 10 128]
				just=[left top]
			}
		endif
	repeat <parts>

	// middle end cap
	GetStackedScreenElementPos Y id=<piece_id>
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		id=<bottom_id>

		texture=<bottom_texture>
		scale=<scale>
		rgba=<bg_piece_rgba>
		pos=<pos>
		just=[left top]
	}
endscript

script edit_skater_menu_create_tab tab_id=edit_skater_menu_tab parent=edit_skater_anchor_middle
	CreateScreenElement {
		parent=<parent>
		type=SpriteElement
		id=<tab_id>

		texture=<texture>
		scale=<scale>
		rgba=<rgba>
		pos=(50,95)
		just=[left top]
	}
	// used by logo menus to hide red line down middle
	if GotParam hide_line
		CreateScreenElement {
			parent=<id>
			type=SpriteElement

			texture=white2;black
			scale=(31.5,4);(61,7)
			pos=(0,4)
			rgba=[10 10 10 128]
			just=[left top]
		}
	endif
endscript

script edit_skater_menu_exit
	// reset the index values so they don't come back
	// an hour later and wonder why it's highlighting some random item
	change edit_skater_menu_level_1_index = 0
	change edit_skater_menu_level_2_index = 0

	if(was_goofy = 1)
		GetCurrentSkaterProfileIndex
		GetSkaterProfileInfo player=<currentskaterprofileindex>
		change was_goofy=0
		SetSkaterProfileInfo player=<currentSkaterProfileIndex> params={ stance=goofy }
		RefreshSkaterModel skater=0 profile=<currentSkaterProfileIndex> no_board=no_board
	endif

	if ObjectExists id=edit_skater_anchor
		DestroyScreenElement id=edit_skater_anchor
		wait 1 frame
	endif
	MakeSkaterGoto SkateShopAI Params={}

	if GotParam to_secrets
		create_secrets_menu
	else
		if LevelIs load_cas
			create_pre_cas_menu
			/*if IsTrue came_to_cas_menu_from_main_menu
				launch_main_menu
			else
				// probably won't have this happening anymore!?
				Skater:Obj_MoveToNode name=TRG_SS_SkaterChoosing orient
				launch_ss_menu
			endif*/
		else
			GoalManager_ShowPoints
			if not GoalManager_HasActiveGoals
				GoalManager_ShowGoalPoints
			endif
			create_options_menu
		endif
	endif
endscript

script edit_skater_menu_focus_with_icon rgba=[128 128 128 50]
	GetTags

	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// make the sprites visible
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=<rgba>

	}
	RunScriptOnScreenElement id={ <id> child=2 } edit_skater_show_icon

	// text
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<text_rgba>
	}
endscript

script edit_skater_menu_unfocus_with_icon rgba=[128 128 128 0]
	GetTags

	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// make the sprites invisible
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=<rgba>
	}
	RunScriptOnScreenElement id={ <id> child=2 } edit_skater_hide_icon

	// text
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<text_rgba>
	}
endscript

script edit_skater_menu_focus_with_deck_icon rgba=[128 128 128 50]
	GetTags

	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// make the sprites visible
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=<rgba>

	}
	RunScriptOnScreenElement id={ <id> child=2 } edit_skater_show_deck_icon

	// text
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<text_rgba>
	}
endscript

script edit_skater_menu_logo_focus
	GetTags

	if ScreenElementExists id={ <id> child=2 }
		DoScreenElementMorph {
			id={ <id> child=2 }
			alpha=0.8
		}
	endif

	edit_skater_menu_focus <...>
endscript

script edit_skater_menu_logo_unfocus
	GetTags

	if ScreenElementExists id={ <id> child=2 }
		DoScreenElementMorph {
			id={ <id> child=2 }
			alpha=0.3
		}
	endif

	edit_skater_menu_unfocus <...>
endscript

script edit_skater_show_icon
	wait 3 gameframe
	DoMorph scale=(0,1) alpha=0
	DoMorph scale=(1,1) time=0.15 alpha=1.0 ;rot_angle=360
endscript

script edit_skater_show_deck_icon
	GetCurrentSkaterProfileIndex

	if GetPlayerAppearancePart profile=<currentSkaterProfileIndex> player=0 part=cad_graphic
		printstruct <...>
		if (<desc_id> = None)
			SetProps just=[left top]
			DoMorph scale=(1,0) alpha=0 rot_angle=-90 pos=(-120,25)
			wait 3 gameframe
			DoMorph scale=1 time=0.15 alpha=1.0
		else
			SetProps just=[left top]
			DoMorph scale=(0.3,0) alpha=0 rot_angle=-90 pos=(-120,10)
			wait 3 gameframe
			DoMorph scale=(0.3,0.4) time=0.15 alpha=1.0
		endif
	else
		SetProps just=[left top]
		DoMorph scale=(1,0) alpha=0 rot_angle=-90 pos=(-120,25)
		wait 3 gameframe
		DoMorph scale=1 time=0.15 alpha=1.0
	endif

endscript

script edit_skater_hide_icon
	DoMorph scale=0 relative_scale
endscript

script edit_skater_menu_focus rgba=[128 118 0 128]
	GetTags

	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// make the sprite visible
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=[128 128 128 50]
	}

	// text
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<text_rgba>
	}

	generic_menu_update_arrows {
		up_arrow_id = edit_skater_menu_up_arrow
		down_arrow_id = edit_skater_menu_down_arrow
	}

	edit_skater_vmenu:GetTags

	if GotParam arrow_id
		menu_vert_blink_arrow { id=<arrow_id> }
	endif
endscript

script edit_skater_menu_unfocus
	GetTags

	if not GotParam text_rgba
		FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	endif

	// turn off the sprite
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=[128 128 128 0]
	}

	// text
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<text_rgba>
	}
endscript

script edit_skater_info_focus
	GetTags

	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=bg_rgba "%i_BG_PARTS_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	if not GotParam no_bg
		//bg
		SetScreenElementProps { id={ <id> child=1 } rgba=<bg_rgba> }
		//text
		SetScreenElementProps { id={ <id> child=2 } rgba=<text_rgba> }
		SetScreenElementProps { id={ <id> child=0 } rgba=<text_rgba> }
		if not GotParam top_row
			//arrows
			SetScreenElementProps { id={ <id> child=3 } rgba=<text_rgba> }
			SetScreenElementProps { id={ <id> child=4 } rgba=<text_rgba> }
		endif
		// black box
		if ScreenElementExists id={ <id> child=5 }
			DoScreenElementMorph { id={ <id> child=5 } alpha=0.7 }
		else
			DoScreenElementMorph { id={ <id> child=3 } alpha=0.7 }
		endif
	else
		// item text
		SetScreenElementProps { id={ <id> child=0 } rgba=<text_rgba> }
	endif
endscript

script edit_skater_info_unfocus bg_rgba=[128 128 128 60]
	GetTags

	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	if not GotParam no_bg
		//bg
		SetScreenElementProps { id={ <id> child=1 } rgba=<bg_rgba> }
		//value text
		SetScreenElementProps { id={ <id> child=2 } rgba=<text_rgba> }
		if not GotParam top_row
			//arrows
			SetScreenElementProps { id={ <id> child=3 } rgba=[0 0 0 0] }
			SetScreenElementProps { id={ <id> child=4 } rgba=[0 0 0 0] }
		endif
		// black box
		if ScreenElementExists id={ <id> child=5 }
			DoScreenElementMorph { id={ <id> child=5 } alpha=0.0 }
		else
			DoScreenElementMorph { id={ <id> child=3 } alpha=0.0 }
		endif
	endif

	// item text
	SetScreenElementProps { id={ <id> child=0 } rgba=<text_rgba> }
endscript

// changes current part highlight when new part is selected
script change_current_part_highlight
	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// reset color of all menu items
	index=0
	begin
		if ScreenElementExists id={ current_menu child={ <index> child=0 } }
			SetScreenElementProps {	id={ current_menu child={ <index> child=0 } }
				rgba=<rgba>
			}
			SetScreenElementProps {	id={ current_menu child=<index> }
				event_handlers=[ 	{ unfocus	<unfocus_script> params={ <unfocus_params> text_rgba=<rgba> } } ]
				replace_handlers
			}
		else
			break
		endif
		index = ( <index> + 1 )
	repeat

	// update color of part just added
	SetScreenElementProps {	id={ <id> child=0 }
		rgba=CASCURRENTCOLOR
	}
	SetScreenElementProps {	id=<id>
		event_handlers=[ 	{ unfocus	<unfocus_script> params={ <unfocus_params> text_rgba=CASCURRENTCOLOR } } ]
		replace_handlers
	}
endscript
script build_cas_category_menu scale=0.5
	if ( in_deck_design = 1 )
		return
	endif

	if not LevelIs load_cas
		return
	endif

	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	CreateScreenElement {
		type=hmenu
		parent=edit_skater_anchor_middle
		id=category_anchor

		pos=(110,100)
		just=[left top]
		padding_scale=0.5
	}

	// head
	CreateScreenElement {
		type=SpriteElement
		parent=category_anchor

		texture=ED_head
		scale=<scale>
		just=[left center]
		rgba=<rgba>
	}

	// torso
	CreateScreenElement {
		type=SpriteElement
		parent=category_anchor

		texture=ED_torso
		scale=<scale>
		just=[left center]
		rgba=<rgba>
	}

	// leg
	CreateScreenElement {
		type=SpriteElement
		parent=category_anchor

		texture=ED_legs
		scale=<scale>
		just=[left center]
		rgba=<rgba>
	}

	// tattoo
	CreateScreenElement {
		type=SpriteElement
		parent=category_anchor

		texture=ED_tat
		scale=<scale>
		just=[left center]
		rgba=<rgba>
	}

	// scale
	CreateScreenElement {
		type=SpriteElement
		parent=category_anchor

		texture=ED_resize
		scale=<scale>
		just=[left center]
		rgba=<rgba>
	}

	// pad
	CreateScreenElement {
		type=SpriteElement
		parent=category_anchor

		texture=ED_pads
		scale=<scale>
		just=[left center]
		rgba=<rgba>
	}

	CreateScreenElement {
		type=ContainerElement
		parent=edit_skater_anchor_middle
		id=category_button_anchor

		pos=(110,100)
		dims=(300,10)
		just=[left top]
		internal_just=[center top]
	}

	// square
	CreateScreenElement {
		type=TextElement
		parent=category_button_anchor

		text="\m9"
		font=dialog
		just=[left center]
		pos=(-20,18)
		alpha=0.8
		z_priority=4
	}

	// circle
	CreateScreenElement {
		type=TextElement
		parent=category_button_anchor

		text="\m8"
		font=dialog
		just=[left center]
		pos=(158,18)
		alpha=0.8
		z_priority=4
	}
endscript

script category_menu_set_focus
	if ( in_deck_design = 1 )
		return
	endif

	if not LevelIs load_cas
		return
	endif

	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	index=0
	begin
		DoScreenElementMorph id={ category_anchor child=<index> } rgba=<off_rgba> scale=0.5
		index = ( <index> + 1 )
	repeat 6
	if not ( current_cas_category = 0 )
		child=(current_cas_category - 1)
		DoScreenElementMorph id={ category_anchor child=<child> } rgba=<on_rgba> scale=0.7
	endif
endscript


cas_cam_angle=0
cas_cam_target_x=0
cas_cam_target_y=0
cas_cam_target_z=0
cas_cam_pos_x=0
cas_cam_pos_y=0
cas_cam_pos_z=0

// set up rotating camera
script cas_setup_rotating_camera
	Skater:Obj_GetID

	default_target_vector=(-25,35,0) default_pos_vector=(0,30,85)

	if GotParam cam_anim
		switch <cam_anim>
			case Head
				target_vector=(-14,65,0) pos_vector=(0,0,35)
			case HeadTop
				target_vector=(-14,65,0) pos_vector=(0,20,25)
			case Torso
				target_vector=(-18,50,0) pos_vector=(0,0,45)
			case AdjTorso
				target_vector=(-14,50,0) pos_vector=(0,0,45)
			case Legs
				target_vector=(-17,20,0) pos_vector=(0,25,55)
			case LegTattoo
				target_vector=(-20,10,0) pos_vector=(0,15,45)
			case AdjLegTattoo
				target_vector=(-16,10,0) pos_vector=(0,15,45)
			case Feet
				target_vector=(-14,5,0) pos_vector=(0,10,45)
			case fullbody
				target_vector=<default_target_vector> pos_vector=<default_pos_vector>
			default
				target_vector=<default_target_vector> pos_vector=<default_pos_vector>
		endswitch
	else
		target_vector=<default_target_vector> pos_vector=<default_pos_vector>
	endif

	change cas_cam_target_x = ( <target_vector>.(1,0,0) )
	change cas_cam_target_y = ( <target_vector>.(0,1,0) )
	change cas_cam_target_z = ( <target_vector>.(0,0,1) )

	change cas_cam_pos_x = ( <pos_vector>.(1,0,0) )
	change cas_cam_pos_y = ( <pos_vector>.(0,1,0) )
	change cas_cam_pos_z = ( <pos_vector>.(0,0,1) )

	get_rotated_vector vector=<target_vector>
	t_off=<vector>
	get_rotated_vector vector=<pos_vector>
	p_off=<vector>

	KillSkaterCamAnim all
	PlaySkaterCamAnim { skater=0
		targetID=<objId>
		targetOffset=<t_off>
		positionOffset=<p_off>
		play_hold
		frames=1
		virtual_cam
	}
endscript

// rotate camera left
script cas_rotate_camera_left dif=3 button=L1
	Skater:Obj_GetID

	begin
		if ControllerPressed <button>
			change cas_cam_angle = ( cas_cam_angle + <dif> )
			if ( cas_cam_angle > 180 )
				change cas_cam_angle = ( cas_cam_angle - 360 )
			else
				if ( -180 > cas_cam_angle )
					change cas_cam_angle = ( cas_cam_angle + 360 )
				endif
			endif

			target_vector = ( cas_cam_target_x*(1,0,0) + cas_cam_target_y*(0,1,0) + cas_cam_target_z*(0,0,1) )
			pos_vector = ( cas_cam_pos_x*(1,0,0) + cas_cam_pos_y*(0,1,0) + cas_cam_pos_z*(0,0,1) )

			get_rotated_vector vector=<target_vector>
			t_off=<vector>
			get_rotated_vector vector=<pos_vector>

			;if not GotParam wobble_cam
			p_off=<vector>
			;else
			;	p_off = ( <vector>.(1,0,0)*(1,0,0) + (<vector>.(0,1,0)-(<vector>.(1,0,0)/4))*(0,1,0) + <vector>.(0,0,1)*(0,0,1) )
			;endif

			KillSkaterCamAnim all
			PlaySkaterCamAnim { skater=0
				targetID=<objId>
				targetOffset=<t_off>
				positionOffset=<p_off>
				play_hold
				frames=1
				virtual_cam
			}
		else
			break
		endif
		wait 1 gameframe
	repeat
endscript

// rotate camera right
script cas_rotate_camera_right dif=-3 button=R1
	cas_rotate_camera_left dif=<dif> button=<button> <...>
endscript

script cas_rotate_camera_to_angle dif=6 angle=0
	Skater:Obj_GetID

	begin
		if not ( cas_cam_angle = <angle> )
			if ( ( <angle> > cas_cam_angle ) && ( (cas_cam_angle+<dif>) > <angle> ) )
				change cas_cam_angle = <angle>
			else
				change cas_cam_angle = ( cas_cam_angle + <dif> )
			endif

			if ( cas_cam_angle > 180 )
				change cas_cam_angle = ( cas_cam_angle - 360 )
			else
				if ( -180 > cas_cam_angle )
					change cas_cam_angle = ( cas_cam_angle + 360 )
				endif
			endif

			target_vector = ( cas_cam_target_x*(1,0,0) + cas_cam_target_y*(0,1,0) + cas_cam_target_z*(0,0,1) )
			pos_vector = ( cas_cam_pos_x*(1,0,0) + cas_cam_pos_y*(0,1,0) + cas_cam_pos_z*(0,0,1) )

			get_rotated_vector vector=<target_vector>
			t_off=<vector>
			get_rotated_vector vector=<pos_vector>
			p_off=<vector>

			KillSkaterCamAnim all
			PlaySkaterCamAnim { skater=0
				targetID=<objId>
				targetOffset=<t_off>
				positionOffset=<p_off>
				play_hold
				frames=1
				virtual_cam
			}
		else
			break
		endif
		wait 1 gameframe
	repeat
endscript

// calculate vectors for new camera position
script get_rotated_vector
	x = ( <vector>.(1,0,0) )
	y = ( <vector>.(0,1,0) )
	z = ( <vector>.(0,0,1) )

	cos cas_cam_angle
	sin cas_cam_angle

	x2 = ( <x>*<cos> - <z>*<sin> )
	y2 = <y>
	z2 = ( <x>*<sin> + <z>*<cos> )

	vector = ( (1,0,0)*<x2> + (0,1,0)*<y2> + (0,0,1)*<z2> )

	return vector=<vector>
endscript

script spawn_cas_pull_back_camera
	if ( pulled_back=0 )
		killspawnedscript name=cas_pull_back_camera
		change pulled_back=0
		spawnscript cas_pull_back_camera
	endif
endscript

pulled_back=0

script cas_pull_back_camera
	printf "script cas_pull_back_camera"

	change pulled_back=1

	Skater:Obj_GetID
	target_vector=(-25,35,0) pos_vector=(0,30,85)

	get_rotated_vector vector=<target_vector>
	t_off=<vector>
	get_rotated_vector vector=<pos_vector>
	p_off=<vector>

	// copying current camera position
	// must add the zero to get the value of the global
	// and prevent infinite recursion trying to resolve two checksums store in each other
	cas_cam_target_x2 = ( cas_cam_target_x + 0 )
	cas_cam_target_y2 = ( cas_cam_target_y + 0 )
	cas_cam_target_z2 = ( cas_cam_target_z + 0 )

	cas_cam_pos_x2 = ( cas_cam_pos_x + 0 )
	cas_cam_pos_y2 = ( cas_cam_pos_y + 0 )
	cas_cam_pos_z2 = ( cas_cam_pos_z + 0 )

	// swapping in temp camera angle
	change cas_cam_target_x = ( <target_vector>.(1,0,0) )
	change cas_cam_target_y = ( <target_vector>.(0,1,0) )
	change cas_cam_target_z = ( <target_vector>.(0,0,1) )

	change cas_cam_pos_x = ( <pos_vector>.(1,0,0) )
	change cas_cam_pos_y = ( <pos_vector>.(0,1,0) )
	change cas_cam_pos_z = ( <pos_vector>.(0,0,1) )

	pulse_blur
	KillSkaterCamAnim all
	PlaySkaterCamAnim { skater=0
		targetID=<objId>
		targetOffset=<t_off>
		positionOffset=<p_off>
		play_hold
		frames=1
		virtual_cam
	}

	wait 0.3 seconds
	begin
		if isPS2
			if not ControllerPressed R2
				break
			endif
		endif
		if isXbox
			if not ControllerPressed black
				break
			endif
		endif
		if isNGC
			if not ControllerPressed Z
				break
			endif
		endif
		wait 1 gameframe
	repeat

	// restoring original camera position
	change cas_cam_target_x = <cas_cam_target_x2>
	change cas_cam_target_y = <cas_cam_target_y2>
	change cas_cam_target_z = <cas_cam_target_z2>

	change cas_cam_pos_x = <cas_cam_pos_x2>
	change cas_cam_pos_y = <cas_cam_pos_y2>
	change cas_cam_pos_z = <cas_cam_pos_z2>

	target_vector = ( cas_cam_target_x*(1,0,0) + cas_cam_target_y*(0,1,0) + cas_cam_target_z*(0,0,1) )
	pos_vector = ( cas_cam_pos_x*(1,0,0) + cas_cam_pos_y*(0,1,0) + cas_cam_pos_z*(0,0,1) )

	get_rotated_vector vector=<target_vector>
	t_off=<vector>
	get_rotated_vector vector=<pos_vector>
	p_off=<vector>

	pulse_blur
	KillSkaterCamAnim all
	PlaySkaterCamAnim { skater=0
		targetID=<objId>
		targetOffset=<t_off>
		positionOffset=<p_off>
		play_hold
		frames=1
		virtual_cam
	}
	wait 0.3 seconds
	change pulled_back=0

endscript

//////////////////////////////////////////////////////////////////////
// FACE MAPPING MENUS
/////////////////////////////////////////////////////////////////////

goto_face_menu=0
face_map_points_saved=0
script launch_face_menu
	load_cas_textures_to_main_memory

	create_face_map_menu downloaded_face=<downloaded_face> goto_face_map=<goto_face_map>
endscript

original_model_face_points = {
	left_eye = [ 49 54 ]
	right_eye = [ 79 54 ]
	nose = [ 64 75 ]
	lips = [ 64 89 ]
	width = 128
	height = 128
}


in_deck_design=0

///////////////////////////////////////////////////////////////////////
//	DECK DESIGN
//////////////////////////////////////////////////////////////////////


script create_deck_design_menu
	printf "script create_deck_design_menu"
	pulse_blur

	change goto_cad=0

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	SetScreenElementLock id=root_window off

	// container element
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=edit_skater_anchor

		pos=(320, 200)	// intentionally off center...
		dims=(640, 480)
	}
	AssignAlias id=edit_skater_anchor alias=current_menu_anchor

	kill_start_key_binding

	// top anchor
	CreateScreenElement {
		type=ContainerElement
		parent=edit_skater_anchor
		id=edit_skater_anchor_top

		pos=(320, 240)
		dims=(640, 480)
	}


	edit_skater_create_top_bar scale=(1, 1) parent=edit_skater_anchor_top text="DECK DESIGN"
	// create the first level menu by default
	edit_skater_create_main_deck_menu <...>

	if GotParam animate
		;RunScriptOnScreenElement id=edit_skater_anchor_top select_skater_menu_animate_top
		;RunScriptOnScreenElement id=edit_skater_anchor_middle select_skater_menu_animate_stats
	endif
endscript

was_goofy=0

script cad_camera
	change in_deck_design=1

	wait 4 gameframes

	GoalManager_HidePoints
	GoalManager_HideGoalPoints

	// if we just loaded the level we have to wait for the slow ass skater to catch up...
	if GotParam wait_for_skater
		skater:pausePhysics
		MakeSkaterGoto SkateShopAI Params={NOSFX CAS_Screen}

		skater:SwitchOnBoard
		skater:PlayAnim Anim=BoardPlacement BlendPeriod=0 cycle
		skater:Obj_MoveToNode name=cad_deck_spot orient
		skater:Obj_ShadowOff
	endif

	KillSkaterCamAnim all
	PlaySkaterCamAnim play_hold name=map_deck_intro_cam01 ;cas_default_cam

	if GotParam at_cad_menu
		FireEvent type=focus target=current_menu data={ grid_index=edit_skater_menu_level_1_index }
	endif
endscript

in_cad_cutscene_sequence=0



