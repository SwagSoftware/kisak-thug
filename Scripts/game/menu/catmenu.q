// timeline item color values
rot_on_un = [22 72 111 70]
rot_off_un = [30 57 78 35]
rot_on_high = [22 72 111 128]
rot_off_high = [30 57 78 58]

grab_on_un = [7 123 65 70]
grab_off_un = [29 58 42 35]
grab_on_high = [7 123 65 128]
grab_off_high = [29 58 42 58]

flip_on_un = [127 123 45 70]
flip_off_un = [59 58 32 35]
flip_on_high = [127 123 45 128]
flip_off_high = [59 58 32 58]

spec_on_un = [127 3 5 70]
spec_off_un = [69 28 22 35]
spec_on_high = [127 3 5 128]
spec_off_high = [69 28 22 58]

misc_on_un = [127 3 125 70]
misc_off_un = [69 28 62 35]
misc_on_high = [127 3 125 128]
misc_off_high = [69 28 62 58]

gen_on_un = [127 63 5 70]
gen_off_un = [69 38 2 35]
gen_on_high = [127 63 5 128]
gen_off_high = [69 38 2 58]

new_item_un = [80 80 80 80]
new_item_high = [128 128 128 100]

idle_on_un = [10 10 10 80]
idle_off_un = [10 10 10 20]

timeline_arrow_high = [100 100 100 100]

MIN_CAT_TIME = 0.35

//////////////////////////////////////////////////////////////////////////////
// CREATE A TRICK MENU
//////////////////////////////////////////////////////////////////////////////

// initial createAtrick menu
script create_pre_cat_menu
	dialog_box_exit
	
    FormatText ChecksumName=title_icon "%i_new" i=(THEME_PREFIXES[current_theme_prefix])
    make_new_themed_sub_menu title="CREATE A TRICK" title_icon=<title_icon>
	
	if GotParam from_mainmenu
		// dummy item used to track if this menu is up
		CreateScreenElement{ type=containerElement id=pre_cat_menu_is_up dims=(0,0) pos=(0,0) parent=current_menu_anchor }
	endif
    
    theme_menu_add_item centered=1 text="Create New Trick" id=menu_new pad_choose_script=create_CAT_menu pad_choose_params={ new=1 }
    theme_menu_add_item centered=1 text="Edit Created Trick" id=menu_edit pad_choose_script=cat_edit_slot_menu pad_choose_params={ load=0 }
    theme_menu_add_item centered=1 text="Load Created Trick" id=menu_load pad_choose_script=launch_load_cat_sequence pad_choose_params={ }
	theme_menu_add_item centered=1 text="Pre-made Tricks" id=menu_premade pad_choose_script=cat_premade_menu pad_choose_params={ }
    
	if GameModeEquals is_singlesession
		theme_menu_add_item centered=1 text="Done" id=menu_exit pad_choose_script=create_pause_menu last_menu_item=1
		SetScreenElementProps {
			id=sub_menu
			event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=create_pause_menu } } ]
			replace_handlers
		}
	else
		theme_menu_add_item centered=1 text="Done" id=menu_exit pad_choose_script=edit_skater_options_menu last_menu_item=1
		SetScreenElementProps {
			id=sub_menu
			event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=edit_skater_options_menu } } ]
			replace_handlers
		}
	endif
	
	
    ;FireEvent type=focus target=current_menu_anchor
	
	finish_themed_sub_menu
endscript

script cat_launch_nj
	change_gamemode_singlesession
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
    endif
	load_mainmenu_textures_to_main_memory unload
	change_level level=load_nj
endscript

// cat pause menu
script create_CAT_pause_menu
    if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	if ScreenElementExists id=cat_menu_anchor
		DestroyScreenElement id=cat_menu_anchor
	endif
	
	if ObjectExists id=CAT_Skater
		CAT_Skater:TurnOffSpecialItem
		CAT_Skater:Die
		cat_rehide_skater_board
	endif
	
    if GotParam from_timeline
		generic_menu_pad_back_sound
		spawnscript cat_back_to_skater_cam
	endif
	
	KillSpawnedScript name=cat_perform_trick_loop
	if ( running_cat_demo = 1 )
		change running_cat_demo=0
	endif
	
	dialog_box_exit
    
	if ( in_cat_preview_mode = 1 )
        change in_cat_preview_mode = 0
		spawnscript remap_cat_preview_trick
	endif
	
	pause_menu_gradient on time=0
	
	kill_start_key_binding
	
	GoalManager_HidePoints
	GoalManager_HideGoalPoints
	
    pad_back_script=preview_cat
    
    make_new_pause_menu menu_id=pause_menu vmenu_id=pause_vmenu pos=(320,540) pad_back_script=<pad_back_script>
    
	get_CAT_other_param_values trick_index=0
	create_cat_pause_trick_info name=<name> parent=pause_menu
	calculate_cat_score get_values
	
	create_helper_text generic_helper_text
	
	FormatText ChecksumName=back_icon "%i_back" i=(THEME_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=preview_icon "%i_preview" i=(THEME_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=save_icon "%i_save_cat" i=(THEME_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=exit_icon "%i_quit" i=(THEME_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=name_trick_icon "%i_name_cat" i=(THEME_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=assign_trick_icon "%i_assign_cat" i=(THEME_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=load_trick_icon "%i_load_cat" i=(THEME_PREFIXES[current_theme_prefix])
	
    make_sprite_menu_item text="Back to Editor" id=menu_back pad_choose_script=create_CAT_menu pad_choose_params={ from_cat_pause }
	make_text_sprite texture=<back_icon> parent=menu_back
    
	make_sprite_menu_item text="Preview Trick" id=menu_preview pad_choose_script=preview_cat pad_choose_params={ }
	make_text_sprite texture=<preview_icon> parent=menu_preview
	
	make_sprite_menu_item text="Name Trick" id=menu_name pad_choose_script=launch_keyboard_from_cat_pause pad_choose_params={ }
	make_text_sprite texture=<name_trick_icon> parent=menu_name
	
    make_sprite_menu_item text="Save Trick" id=menu_save pad_choose_script=maybe_launch_save_cat_sequence pad_choose_params={ }
	make_text_sprite texture=<save_icon> parent=menu_save
	
	;make_sprite_menu_item text="Load Trick" id=menu_load pad_choose_script=launch_load_cat_sequence pad_choose_params={ }
	;make_text_sprite texture=<load_trick_icon> parent=menu_load
	
	;make_sprite_menu_item text="Create New Trick" id=menu_new pad_choose_script=create_CAT_menu pad_choose_params={ new=1 }
    ;make_text_sprite texture=<save_icon> parent=menu_new
	
    ;make_sprite_menu_item text="Assign Trick Slot" id=menu_assign pad_choose_script=cat_assign_slot_menu pad_choose_params={ }
    ;make_text_sprite texture=<assign_trick_icon> parent=menu_assign
    
	make_sprite_menu_item text="Done" id=menu_exit pad_choose_script=cat_exit_dialog pad_choose_params={ }
	make_text_sprite texture=<exit_icon> parent=menu_exit
	
	build_pause_menu_parts
endscript

in_cat_preview_mode = 0

// unpauses game and maps CAT currently being edited to left + square
script preview_cat
	calculate_cat_score get_time
	if ( MIN_CAT_TIME > <time> )
		if ScreenElementExists id=current_menu_anchor
			DestroyScreenElement id=current_menu_anchor
		endif
		create_dialog_box { title="Too Short!"
							text="Your Create-A-trick must be at least 0.4 seconds long."
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
                            
							pad_back_script = <back_script>
							buttons=[   { font=small text="Ok" pad_choose_script=create_CAT_pause_menu }
									]
						  }
	else
		cat_landable
		if ( <upsidedown> = 1 )
			if ScreenElementExists id=current_menu_anchor
				DestroyScreenElement id=current_menu_anchor
			endif
			create_dialog_box { title="Wrecked!"
							text="You can't land that trick!"
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
                            
							pad_back_script = <back_script>
							buttons=[   { font=small text="Ok" pad_choose_script=create_CAT_pause_menu }
									]
						  }
		else
			change in_cat_preview_mode = 1
			
			GoalManager_GetTrickFromKeyCombo Key_Combo=Air_SquareL
			if GotParam trick_checksum
				Skater:SetTags old_trick=<trick_checksum>
			else
				if GotParam cat_num
					Skater:SetTags old_trick=<cat_num>
				endif
			endif
			
			// temporarily assign trick
			BindTrickToKeyCombo {
					key_combo=Air_SquareL
					trick=0
					update_mappings=1
				}
			GetCurrentSkaterProfileIndex
			UpdateTrickMappings skater=<currentSkaterProfileIndex>
			
			exit_pause_menu
			
			// preview trick mapping text
			GoalManager_HideGoalPoints
			create_panel_block id=cat_preview_trick_mapping_text text="Preview Created Trick\n\b6 + \b1" style=panel_message_goal
		endif
	endif
endscript

// remaps kickflip to left + square after returning from preview mode
script remap_cat_preview_trick
	// destroy cat preview key combo text
	if ScreenElementExists id=cat_preview_trick_mapping_text
		DestroyScreenElement id=cat_preview_trick_mapping_text
	endif
	
	Skater:GetTags
    
    // assign trick back to kickflip
	BindTrickToKeyCombo {
			key_combo=Air_SquareL
			trick=<old_trick>
			update_mappings=1
		}
	GetCurrentSkaterProfileIndex
	UpdateTrickMappings skater=<currentSkaterProfileIndex>
endscript

script maybe_launch_save_cat_sequence
	calculate_cat_score get_time
	if ( MIN_CAT_TIME > <time> )
		if ScreenElementExists id=current_menu_anchor
			DestroyScreenElement id=current_menu_anchor
		endif
		create_dialog_box { title="Too Short!"
							text="Your Create-A-trick must be at least 0.4 seconds long."
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
                            
							pad_back_script = <back_script>
							buttons=[   { font=small text="Ok" pad_choose_script=create_CAT_pause_menu }
									]
						  }
	else
		cat_landable
		if ( <upsidedown> = 1 )
			if ScreenElementExists id=current_menu_anchor
				DestroyScreenElement id=current_menu_anchor
			endif
			create_dialog_box { title="Wrecked!"
							text="You can't land that trick!"
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
                            
							pad_back_script = <back_script>
							buttons=[   { font=small text="Ok" pad_choose_script=create_CAT_pause_menu }
									]
						  }
		else
			launch_save_cat_sequence
		endif
	endif
endscript

editing_cat=0

// list CAT slots for editing
script cat_edit_slot_menu
	dialog_box_exit
	
	FormatText ChecksumName=title_icon "%i_save_cat" i=(THEME_PREFIXES[current_theme_prefix])
    make_new_themed_option_menu title="EDIT TRICK" title_icon=<title_icon>
    
    SetScreenElementProps {
		id=options_menu
		event_handlers=[    { pad_back  create_pre_cat_menu }
					   ]
    }
	
	index=1
	added=0
	begin
		get_CAT_other_param_values trick_index=<index>
        if GotParam full
			if ( <full> = 1 )
				make_theme_menu_item text=<name> pad_choose_script=edit_cat_in_slot pad_choose_params={ slot=<index> }
				added = ( <added> + 1 )
			endif
		endif
		index = ( <index> + 1 )
	repeat ( MAX_CREATED_TRICKS - 1 )
	
    if ( <added> > 0 )
		FireEvent type=focus target=current_menu_anchor
	else
		DestroyScreenElement id=current_menu_anchor
		create_dialog_box { title="No Tricks"
						text="You have no tricks to edit."
						pos=(310 ,183)
						just=[center center]
						text_rgba=[88 105 112 128]
						;text_dims=(320,0)
						
						
                        buttons=[   { font=small text="Ok" 	pad_choose_script=create_pre_cat_menu }
							    ]
						;delay_input
					  }
	endif
endscript

script edit_cat_in_slot
	if not GotParam slot
		printf "CAT: missing slot param"
		return
	endif
	
	change editing_cat=<slot>
	;printf "edit slot = %i" i=<slot>
	
	get_CAT_param_values trick_index=<slot>
	;printstruct <...>
	SetCreateATrickParams {		skater=0
                                trick_index=0
                                other_params = { 	name=<name> 
													rotateafter=<rotateafter>
													can_spin=<can_spin>
													full=1
												}
								rotation_info=<rotation_info>
								animation_info=<animation_info>
						   }
	create_CAT_menu
endscript

// list CAT slot for assigning
script cat_assign_slot_menu
	dialog_box_exit
	
	FormatText ChecksumName=title_icon "%i_save_cat" i=(THEME_PREFIXES[current_theme_prefix])
    make_new_themed_option_menu title="OVERWRITE TRICK" title_icon=<title_icon>
	
	if LevelIs load_skateshop
		build_top_and_bottom_blocks
		make_mainmenu_3d_plane
	endif
    
    if ( loading_cat_from_edit_tricks = 0 )
		SetScreenElementProps {
			id=options_menu
			event_handlers=[    { pad_back  create_CAT_pause_menu }
						   ]
		}
	else
		SetScreenElementProps {
			id=options_menu
			event_handlers=[    { pad_back  create_edit_tricks_menu }
						   ]
		}
	endif
	
	index=1
	begin
		get_CAT_other_param_values trick_index=<index>
		make_theme_menu_item text=<name> pad_choose_script=assign_cat_to_slot pad_choose_params={ save_slot=<index> }
		index = ( <index> + 1 )
	repeat ( MAX_CREATED_TRICKS - 1 )
	
    FireEvent type=focus target=current_menu_anchor
endscript

// assigns currently loaded CAT to any of the current skater's avaiable cat slots. this then makes them available under edit tricks
script assign_cat_to_slot ;save_slot=1
	if not GotParam save_slot
		printf "CAT: missing save_slot param"
		return
	endif
	
	get_CAT_param_values trick_index=0
	;printstruct <...>
	SetCreateATrickParams {		skater=0
                                trick_index=<save_slot>
                                other_params = { 	name=<name> 
													rotateafter=<rotateafter>
													can_spin=<can_spin>
													full=1
												}
								rotation_info=<rotation_info>
								animation_info=<animation_info>
						   }
	if ( loading_cat_from_edit_tricks = 1 )
		create_edit_tricks_menu
	else
		back_to_options_menu_from_cat
	endif
endscript

// dialog box to confirm exiting CAT
script cat_exit_dialog back_script=return_to_cat_pause
    if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	calculate_cat_score get_time
	if ( MIN_CAT_TIME > <time> )
		create_dialog_box { title="Too Short!"
							text="Your Create-A-trick must be at least 0.4 seconds long. Do you want to go back to fix it or quit without saving?"
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
                            
							pad_back_script = <back_script>
							buttons=[   { font=small text="Go Back" pad_choose_script=<back_script> }
										{ font=small text="Quit" 	pad_choose_script=back_to_options_menu_from_cat }
									]
						  }
	else
		cat_landable
		if ( <upsidedown> = 1 )
			create_dialog_box { title="Wrecked!"
							text="You can't land that trick!"
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
                            
							pad_back_script = <back_script>
							buttons=[   { font=small text="Go Back" pad_choose_script=<back_script> }
										{ font=small text="Quit" 	pad_choose_script=back_to_options_menu_from_cat }
									]
						  }
		else
			create_dialog_box { title="Keep it?"
								text="Keep this Create-A-Trick? Once kept, a Created Trick can be permanently mapped to your skater from the Edit Tricks menu."
								pos=(310 ,240)
								just=[center center]
								text_rgba=[88 105 112 128]
								;text_dims=(320,0)
								
								
								pad_back_script = <back_script>
								buttons=[   { font=small text="No" 	pad_choose_script=back_to_options_menu_from_cat }
											{ font=small text="Yes" pad_choose_script=launch_keyboard_from_exit_cat }
										]
								;delay_input
							  }
		endif	
	endif
endscript

script auto_assign_cat_to_slot
	
	if ( editing_cat = 0 )
		// look for empty slot... slot 0 is editing slot!
		index=1
		begin
			get_CAT_other_param_values trick_index=<index>
			// is slot empty?
			if ( <full> = 0 )
				save_slot=<index>
				break
			endif
			index = ( <index> + 1 )
		repeat (MAX_CREATED_TRICKS-1)
	else
		save_slot = (editing_cat+0)
		change editing_cat=0
	endif
	
    if GotParam save_slot
		;printf "save_slot = %i" i=<save_slot>
		assign_cat_to_slot save_slot=<save_slot>
	else
	   	// all slots are full
		if ( loading_cat_from_edit_tricks = 0 )
            if isXbox
				create_dialog_box { title="Full"
							text="All your Create-A-trick slots are full. What do you want to do?"
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
							
							;pad_back_script = create_CAT_pause_menu
							buttons=[   { font=small text="Overwrite old trick" 	  pad_choose_script=cat_assign_slot_menu }
										{ font=small text="Save trick to Hard Drive"  pad_choose_script=launch_save_cat_sequence }
										{ font=small text="Exit without saving trick" pad_choose_script=back_to_options_menu_from_cat }
									]
						  }
			else
                create_dialog_box { title="Full"
							text="All your Create-A-trick slots are full. What do you want to do?"
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
							
                            buttons=[   { font=small text="Overwrite old trick" 	  pad_choose_script=cat_assign_slot_menu }
										{ font=small text="Save trick" pad_choose_script=launch_save_cat_sequence }
										{ font=small text="Exit without saving trick" pad_choose_script=back_to_options_menu_from_cat }
									]
						  }
			endif
		else
			;create_edit_tricks_menu
			;return
            create_dialog_box { title="Full"
						text="All your Create-A-trick slots are full. What do you want to do?"
						pos=(310 ,183)
						just=[center center]
						text_rgba=[88 105 112 128]
						
						buttons=[   { font=small text="Overwrite old trick" 	  pad_choose_script=cat_assign_slot_menu }
									{ font=small text="Exit without loading trick" pad_choose_script=create_edit_tricks_menu }
								]
					  }
		endif
	endif
endscript

// exit cat ( actually goes to precat menu instead of options now... )
script back_to_options_menu_from_cat
	pulse_blur speed=2 start=225
	dialog_box_exit
    if ObjectExists id=CAT_Cam
		CAT_Cam:Die
	endif
	if ObjectExists id=CAT_Skater
        CAT_Skater:TurnOffSpecialItem
		CAT_Skater:Die
		cat_rehide_skater_board
	endif
	if GameModeEquals is_career
		GoalManager_InitializeAllGoals
	endif
    ;edit_skater_options_menu
	create_pre_cat_menu
endscript

// back to cat pause
script return_to_cat_pause
	dialog_box_exit
    ;FireEvent type=focus target=pause_vmenu
	pulse_blur speed=2 start=225
	create_cat_pause_menu
endscript

script launch_keyboard_from_cat_pause
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	// get the current name
	get_CAT_param_values
	
	create_onscreen_keyboard {	allow_cancel
								keyboard_cancel_script=cat_cancel_keyboard
								keyboard_done_script=set_cat_trick_name
								keyboard_title="TRICK NAME"
								text=<name>
								allowed_characters=cat_allowed_characters
								min_length=1
							 }
endscript

cat_allowed_characters=[ 	"1" "2" "3" "4" "5" "6" "7" "8" "9" "0"
							"a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
							"k" "l" "m" "n" "o" "p" "q" "r" "s" "t"
							"u" "v" "w" "x" "y" "z"
							"A" "B" "C" "D" "E" "F" "G" "H" "I" "J"
							"K" "L" "M" "N" "O" "P" "Q" "R" "S" "T"
							"U" "V" "W" "X" "Y" "Z"
							"." "-" "@" "&" "$" "?" " " ]

script launch_keyboard_from_exit_cat
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	dialog_box_exit
	
	// get the current name
	get_CAT_param_values
	
	if ( ( <name> = "Created Trick" ) || ( <name> = "" ) )
		create_onscreen_keyboard {	keyboard_done_script=set_cat_trick_name_and_exit
									keyboard_title="TRICK NAME"
									text=<name>
									allowed_characters=cat_allowed_characters
									keyboard_cancel_script=cat_cancel_keyboard
									min_length=1
								 }
	else
		auto_assign_cat_to_slot
	endif
endscript

script cat_cancel_keyboard
	destroy_onscreen_keyboard
	create_CAT_pause_menu
endscript

// get string from keyboard and store it into create a trick class
script set_cat_trick_name
	get_CAT_other_param_values trick_index=0
    GetTextElementString id=keyboard_current_string
	set_new_CAT_param_values trick_index=0 name=<string> can_spin=<can_spin>
	destroy_onscreen_keyboard
    
	create_CAT_pause_menu
endscript

script set_cat_trick_name_and_exit
	get_CAT_other_param_values trick_index=0
    GetTextElementString id=keyboard_current_string
	set_new_CAT_param_values trick_index=0 name=<string> can_spin=<can_spin>
	destroy_onscreen_keyboard
    
	auto_assign_cat_to_slot
endscript

script cat_premade_menu
	dialog_box_exit
	
	FormatText ChecksumName=title_icon "%i_save_cat" i=(THEME_PREFIXES[current_theme_prefix])
    make_new_themed_option_menu title="PRE-MADE TRICKS" title_icon=<title_icon>
    
    SetScreenElementProps {
		id=options_menu
		event_handlers=[    { pad_back  create_pre_cat_menu }
					   ]
    }
	
	GetArraySize Premade_CATS
	index=0
    begin
        name = ( (Premade_CATS[<index>]).name )
		make_theme_menu_item text=<name> pad_choose_script=load_premade_cat pad_choose_params={ index=<index> }
        index = ( <index> + 1 )
	repeat <array_size>
	
    FireEvent type=focus target=current_menu_anchor
endscript

script load_premade_cat
	if not GotParam index
		printf "CAT: missing index param"
		return
	endif
	
    SetCreateATrickParams {		skater=0
                                trick_index=0
                                other_params = { 	name = ( (Premade_CATS[<index>]).name ) 
                                                    can_spin=( (Premade_CATS[<index>]).can_spin )
													full=1
												}
								rotation_info = ( (Premade_CATS[<index>]).rotation_info )
								animation_info = ( (Premade_CATS[<index>]).animation_info )
						   }
	
	if GotParam trickSlot
		BindTrickToKeyCombo {
			key_combo=<trickSlot>
			trick=0
			update_mappings=1
			special
			index=<special_trick_index>
			cat
		}
	else
		create_CAT_menu dont_focus_timeline=<dont_focus_timeline>
	endif
endscript

script load_default_premade_cat
	printf "load_default_premade_cat"
	if not GotParam index
		printf "CAT: missing index param"
		return
	endif
	
	if not GotParam save_slot
		printf "CAT: missing save_slot param"
		return
	endif
	
    SetCreateATrickParams {		skater=0
                                trick_index=<save_slot>
                                other_params = { 	name = ( (Premade_CATS[<index>]).name ) 
                                                    can_spin=( (Premade_CATS[<index>]).can_spin )
													full=1
												}
								rotation_info = ( (Premade_CATS[<index>]).rotation_info )
								animation_info = ( (Premade_CATS[<index>]).animation_info )
						   }
endscript

script spawn_add_premade_cats_to_skater
	SpawnScript add_premade_cats_to_skater params={}
endscript

script kill_load_premade_cats
	KillSpawnedScript name=add_premade_cats_to_skater
endscript

script add_premade_cats_to_skater
	// don't use save slot zero! it's the editing slot!
	load_default_premade_cat index=0 save_slot=1
	load_default_premade_cat index=5 save_slot=2
	load_default_premade_cat index=7 save_slot=3
	load_default_premade_cat index=6 save_slot=4
	load_default_premade_cat index=8 save_slot=5
endscript

// creates the main createAtrick menu that holds the timeline and all it's submenus
script create_CAT_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
    // if the skater (not the CatSkater) is currently performing a CAT, take care of it
	if ( cat_done=0 )
      Skater:created_trick_cleanup
	  MakeSkaterGoto AirBorne
	endif
	
	GoalManager_HidePoints
	GoalManager_HideGoalPoints
	end_current_goal_run
	
    SetScreenElementLock off id=root_window
	
    pause_menu_gradient off
	if GameModeEquals is_career
		GoalManager_UninitializeAllGoals
	endif
	spawnscript show_CAT_skater params={ dont_focus_timeline=<dont_focus_timeline> }
    
	CreateScreenElement{
		type=ContainerElement
		id=cat_menu_anchor
		pos=(320,240)
		dims=(640,480)
		parent=root_window
	}
	
	;FormatText ChecksumName=title_icon "%i_new" i=(THEME_PREFIXES[current_theme_prefix])
	;FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
    ;build_theme_sub_title title="" title_icon=<title_icon> parent=cat_menu_anchor
	
	;build_theme_box_icons icon_texture=<paused_icon> parent=cat_menu_anchor
    ;build_grunge_piece parent=cat_menu_anchor
    ;build_top_bar parent=cat_menu_anchor pos=(-250, 62)
	
	add_timeline_helper_text
    
	kill_start_key_binding
	
	create_cat_timeline <...>
	
    if ScreenElementExists id=timeline_vmenu
		if not GotParam dont_focus_timeline
			FireEvent type=focus target=timeline_vmenu
		endif
	endif
endscript

// back out to initial menu from timeline
script CAT_menu_exit
	if ScreenElementExists id=cat_menu_anchor
		DestroyScreenElement id=cat_menu_anchor
	endif
    create_pre_cat_menu
endscript

///////////////////////////////////////////////////
// Helper Text
//////////////////////////////////////////////////

script add_timeline_helper_text
	SetScreenElementLock id=cat_menu_anchor off
	create_helper_text { 	parent=cat_menu_anchor
							spacing_between=-6
							helper_text_elements=[  { text="\b7/\b4=Select" }
													{ text="\b6/\b5=Adjust" }
													{ text="\m1=Exit" }
													{ text="\m0=Edit" }
													{ text="\m8=Hide" }
													{ text="\m9=Delete" }
													{ text="\be/\bf=Order" }
												 ]
						}
endscript

script add_edit_cat_helper_text
	SetScreenElementLock id=cat_menu_anchor off
	create_helper_text { 	parent=cat_menu_anchor
							helper_text_elements=[  { text="\b7/\b4=Select" }
													{ text="\b6/\b5=Adjust" }
													{ text="\m1=Back" }
													{ text="\m0=Choose" }
													;{ text="\be/\bf=Rotate" }
												 ]
						}
endscript

script add_cat_generic_helper_text
	SetScreenElementLock id=cat_menu_anchor off
	create_helper_text { 	parent=cat_menu_anchor
							generic_helper_text
						}
endscript

///////////////////////////////////////////////////
//ROTATION MENUS
//////////////////////////////////////////////////

// extracts all the values from indexed rotation_info structure
script grab_all_rot_values
    return {
				on=( ( <rotation_info>[<rot_index>]).on )
				axis=( ( <rotation_info>[<rot_index>]).axis )
				deg=( ( <rotation_info>[<rot_index>]).deg )
				start=( ( <rotation_info>[<rot_index>]).start )
				dur=( ( <rotation_info>[<rot_index>]).dur )
				deg_dir=( ( <rotation_info>[<rot_index>]).deg_dir )
			}
endscript

// toggles rotations on / off. also makes unused rotations available when selecting to add a new rot.
script toggle_rot_on_off
	printf "script toggle_rot_on_off"
    ;GetCreateATrickRotations skater=0 trick_index=0
    ;grab_all_rot_values { rotation_info=<rotation_info> rot_index=<rot_index> }
	get_CAT_rot_values skater=0 trick_index=0 rot_index=<rot_index>
    
	if GotParam Delete
		// deleting rotation
        on=2 Axis=y Deg=360 Dur=1.0 start=0.0 deg_dir=1
	else
		if ( <on> = 0 )
			//rot is off... turn it on
			on = 1
			GetTags
			focus_id=<id>
			PlaySound copinghit3_11 pitch=60
		else
			if ( <on> = 2 )
				//rot is new... turn it on
				on = 1
				new_rot=1
			else	
				//rot is on... turn it off
				on = 0
				GetTags
				focus_id=<id>
				PlaySound copinghit3_11 pitch=60
			endif
		endif
	endif
    
    ;SetArrayElement ArrayName=rotation_info index=<rot_index> newvalue={ on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
    set_new_rot_values { rot_index=<rot_index> on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
	
    create_cat_timeline get_id=get_id rot_index=<rot_index>
	kill_start_key_binding
	
	if GotParam Delete
		focus_cat_timeline
		return
	endif
	
    if not GotParam new_rot
		FireEvent type=focus target=timeline_vmenu data={ child_id=<focus_id> }
		SetScreenElementProps id=timeline_scrolling_menu reset_window_top
	else
		FireEvent type=focus target=timeline_vmenu
		if ( <value> > 1 )
			begin
				FireEvent type=pad_down target=timeline_vmenu
			repeat (<value>-1)
		endif
		FireEvent type=pad_zac target={timeline_vmenu child=(<value>-1)}
		// need to scroll timeline back up
		SetScreenElementProps id=timeline_scrolling_menu reset_window_top
	endif
endscript

script toggle_can_spin
	PlaySound GUI_buzzer01 pitch=140
	get_CAT_other_param_values trick_index=0
	
	if ( <can_spin> = 0 )
		printf "turn spins on"
		can_spin = 1
	else
		printf "turn spins off"
		can_spin = 0
	endif
	
	set_new_CAT_param_values trick_index=0 name=<name> can_spin=<can_spin>
	calculate_cat_score get_values
endscript

// timeline sub menu for changing rotation values
script CAT_edit_rotation_menu parent=cat_menu_anchor trick_index=0
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
    ;get_CAT_param_values skater=0 trick_index=0
	;grab_all_rot_values { rotation_info=<rotation_info> rot_index=<rot_index> }
	get_CAT_rot_values skater=0 trick_index=0 rot_index=<rot_index>
	
    make_new_menu {
		parent=<parent>
		menu_id=edit_rot_menu
		vmenu_id=edit_rot_vmenu
        type=VMenu
		;dims=(200, 200)
		;padding_scale=.95
		pos=(115,80)
	}
	
	get_rot_name axis=<axis> deg_dir=<deg_dir>
	GetUpperCaseString <rot_name>
    
	FormatText ChecksumName=title_icon "%i_new" i=(THEME_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
    build_theme_sub_title title=<UpperCaseString> title_icon=<title_icon> max_width=360
    GetStackedScreenElementPos X id=right_bracket
	if ( <pos>.(1,0) > 280 )
		pos=( (<pos>.(1,0) + -530) * (1,0) + (0,62) )
	else
		pos=(-250,62)
	endif
    build_top_bar pos=<pos> just=[right top]
	
	create_timeline_fader_box parent=cat_menu_anchor
	
	SetScreenElementLock id=cat_menu_anchor off
	create_helper_text { 	parent=cat_menu_anchor
							helper_text_elements=[  { text="\b7/\b4=Select" }
													{ text="\b6/\b5=Adjust" }
													{ text="\m1=Back" }
												 ]
						}
	
	rot_values={ id=<id> timeline_id=<timeline_id> trick_index=<trick_index> rot_index=<rot_index> on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
	
    SetScreenElementProps {
		id=edit_rot_vmenu	
		event_handlers=[ 	
							{ pad_back   edit_rot_done_script params=<rot_values> }
					   ]
    }
	
    switch <axis>
		case x
			axis_text="Flip"
			if ( <deg_dir> = 0 )
				dir_text = "Front"
			else
				dir_text = "Back"
			endif
		case y
			axis_text="Spin"
			if ( <deg_dir> = 0 )
				dir_text = "Backside"
			else
				dir_text = "Frontside"
			endif
		case z
			axis_text="Roll"
			if ( <deg_dir> = 0 )
				dir_text = "Heel Side"
			else
				dir_text = "Toe Side"
			endif
	endswitch
	
	;FormatText textname=dur_text "%i secs" i=<dur> decimalplaces=1
    
	cat_menu_add_number_item 	text=<dir_text>	value=<axis_text> 	id=menu_axis 	pad_choose_script=null_script pad_right_script=increment_axis_value params=<rot_values> far_left
	cat_menu_add_number_item	text="degrees" 	value=<deg> 	id=menu_deg 	pad_right_script=increment_cat_rotation_angle_value params=<rot_values>
    cat_menu_add_number_item 	text="duration" value=<dur> decimalplaces=1 trailingtext=" secs" id=menu_dur pad_right_script=increment_cat_rot_time_value params={ <rot_values> change_dur } ;last_menu_item=1
	theme_menu_add_item 		text="done" id=menu_done pad_choose_script=edit_rot_done_script pad_choose_params=<rot_values> last_menu_item=1
	
    FireEvent type=unfocus target=timeline_vmenu
    FireEvent type=focus target=edit_rot_menu
	
	// keep timeline item highlighted
	text_rgba = [100 100 100 100]
	sprite_rgba = rot_on_high
    if ScreenElementExists id={ <timeline_id> child=0 }
		//bg
		DoScreenElementMorph time=0 id={ <timeline_id> child=0 } rgba=<sprite_rgba>
		//text
		DoScreenElementMorph time=0 id={ <timeline_id> child=1 } rgba=<text_rgba>
		;RunScriptOnScreenElement id={ <timeline_id> child=1 } text_twitch_effect2
	endif
	
	DoScreenElementMorph id=edit_rot_menu pos=(0,240)
	DoScreenElementMorph id=edit_rot_menu pos=(320,240) time=0.1
	
	DoScreenElementMorph id=timeline_info_anchor pos=(-350,240) time=0.2
endscript

// cycles through the axis values
script increment_axis_value
	generic_menu_scroll_sideways_sound
	;grab_all_rot_values { rotation_info=<rotation_info> rot_index=<rot_index> }
	
	if not GotParam reverse
		switch <axis>
			case x
                if ( <deg_dir> = 0 )
					axis=x
					deg_dir=1
				else
					axis=y
					deg_dir=0
				endif
			case y
                if ( <deg_dir> = 0 )
					axis=y
					deg_dir=1
				else
					axis=z
					deg_dir=0
				endif
			case z
                if ( <deg_dir> = 0 )
					axis=z
					deg_dir=1
				else
					axis=x
					deg_dir=0
				endif
			default
				printf "no match found"
		endswitch
	else
		switch <axis>
			case x
                if ( <deg_dir> = 1 )
					axis=x
					deg_dir=0
				else
					axis=z
					deg_dir=1
				endif
			case y
                if ( <deg_dir> = 1 )
					axis=y
					deg_dir=0
				else
					axis=x
					deg_dir=1
				endif
			case z
                if ( <deg_dir> = 1 )
					axis=z
					deg_dir=0
				else
					axis=y
					deg_dir=1
				endif
			default
				printf "no match found"
		endswitch
	endif
	
	switch <axis>
		case x
			axis_text="flip"
		case y
			axis_text="spin"
		case z
			axis_text="roll"
	endswitch
	
    ;SetArrayElement ArrayName=rotation_info index=<rot_index> newvalue={ on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
	
	;FormatText TextName=value_text "%i" i=<axis>
	SetScreenElementProps id={ menu_axis child=3 } text=<axis_text>
	
	// title update
	get_rot_name axis=<axis> deg_dir=<deg_dir>
	GetUpperCaseString <rot_name>
    
	FormatText ChecksumName=title_icon "%i_new" i=(THEME_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
    build_theme_sub_title title=<UpperCaseString> title_icon=<title_icon> max_width=360
	
    GetStackedScreenElementPos X id=right_bracket
	if ( <pos>.(1,0) > 280 )
		pos=( (<pos>.(1,0) + -530) * (1,0) + (0,62) )
	else
		pos=(-250,62)
	endif
    build_top_bar pos=<pos> just=[right top]
	// end of title update
    
    set_new_rot_values { rot_index=<rot_index> on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
    
	update_rot_direction_value <...>
	update_rot_increment_params <...>
	
    // update timeline item text
	get_rot_name axis=<axis> deg_dir=<deg_dir>
	SetScreenElementProps id={ <timeline_id> child=1 } text=<rot_name>
	SetScreenElementProps id={ <timeline_id> child={ 1 child=0 } } text=<rot_name>
    // truncate text
	max_width=( ( <dur> - 0.1 ) * 160 )
	truncate_string id={ <timeline_id> child=1 } max_width=<max_width>
	
	// arrows
	cat_update_right_arrow
	cat_update_left_arrow
	
endscript

// increments / decrements the rotation angle
script increment_cat_rotation_angle_value
	;printf "script increment_cat_rotation_angle_value"
	generic_menu_scroll_sideways_sound
    
	;grab_all_rot_values { rotation_info=<rotation_info> rot_index=<rot_index> }
	
	if GotParam reverse
		deg = ( <deg> - 180 )
		if ( 180 > <deg> )
			deg = 180
		endif
	else
		deg = ( <deg> + 180 )
		if ( <deg> > 1440 )
			deg = 1440
		endif
	endif
	
    ;SetArrayElement ArrayName=rotation_info index=<rot_index> newvalue={ on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
    
	FormatText TextName=value_text "%i" i=<deg>
	SetScreenElementProps id={ menu_deg child=3 } text=<value_text>
	
    set_new_rot_values { rot_index=<rot_index> on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
	
    cat_update_right_arrow
	;update_rot_direction_value <...>
    update_rot_increment_params <...>
endscript

// increment / decrements duration and start time values
script increment_cat_rot_time_value
	;printf "script increment_cat_rot_time_value"
	generic_menu_scroll_sideways_sound
	
	;grab_all_rot_values { rotation_info=<rotation_info> rot_index=<rot_index> }
	
	if GotParam change_dur
		time_value=<dur>
	else
		if GotParam change_start
			time_value=<start>
		else
			printf "Missing change_ param"
			return
		endif
	endif
	
    if GotParam reverse
		time_value = ( <time_value> - 0.1 )
	else
		time_value = ( <time_value> + 0.1 )
	endif
	
    if ( 0 > <time_value> )
		time_value = 0
	endif
	
	if GotParam change_dur
        ;SetArrayElement ArrayName=rotation_info index=<rot_index> newvalue={ on=<on> deg=<deg> axis=<axis> dur=<time_value> start=<start> deg_dir=<deg_dir> }
        if ( 0.1 > <time_value> )
			time_value = 0.1
		endif
        if ( ( <time_value> + <start> ) > 3.0 )
			time_value = ( 3.0 - <start> )
		endif
		
		dur=<time_value>
        
		FormatText TextName=value_text "%i secs" i=<time_value> decimalplaces=1
		SetScreenElementProps id={ menu_dur child=3 } text=<value_text>
		
		//update timeline
        update_scale_to_new_duration id=<timeline_id> duration=<time_value>
		//update score
        calculate_cat_score get_values;rotation_info=<rotation_info> animation_info=<animation_info>
		
		cat_update_right_arrow
	else
        ;SetArrayElement ArrayName=rotation_info index=<rot_index> newvalue={ on=<on> deg=<deg> axis=<axis> dur=<dur> start=<time_value> deg_dir=<deg_dir> }
		start=<time_value>
		
		FormatText TextName=value_text "%i secs" i=<time_value>
		SetScreenElementProps id={ menu_start child=3 } text=<value_text>
	endif
	
	RemoveParameter change_dur
	RemoveParameter change_start
	
    set_new_rot_values { rot_index=<rot_index> on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
	
    update_rot_increment_params <...>
endscript

script update_rot_direction_value
	switch <axis>
		case x
			axis_text="Flip"
			if ( <deg_dir> = 0 )
				dir_text = "Front"
			else
				dir_text = "Back"
			endif
		case y
			axis_text="Spin"
			if ( <deg_dir> = 0 )
				dir_text = "Backside";"clockwise"
			else
				dir_text = "Frontside";"counter clockwise"
			endif
		case z
			axis_text="Roll"
			if ( <deg_dir> = 0 )
				dir_text = "Heel Side"
			else
				dir_text = "Toe Side"
			endif
	endswitch
	
	SetScreenElementProps id={ menu_axis child=0 } text=<dir_text>
endscript

// updates the event handlers for edit rotations menu items when any of the values change.
script update_rot_increment_params
	RemoveParameter reverse
	;GetCreateATrickRotations skater=0 trick_index=<trick_index>
	
	rot_values={ id=<id> timeline_id=<timeline_id> trick_index=<trick_index> rot_index=<rot_index> on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
	
	SetScreenElementProps {
		id=edit_rot_vmenu	
		event_handlers=[ 	{ pad_back   edit_rot_done_script params=<rot_values> }
					   ]
		replace_handlers
    }
	
	SetScreenElementProps {	id=menu_axis
							event_handlers=[ { pad_right  increment_axis_value params=<rot_values> }
											 { pad_left   increment_axis_value params={<rot_values> reverse} }
										   ]
							replace_handlers
						  }
						  
    SetScreenElementProps {	id=menu_deg
							event_handlers=[ { pad_right  increment_cat_rotation_angle_value params=<rot_values> cat_edit_item }
											 { pad_left   increment_cat_rotation_angle_value params={<rot_values> cat_edit_item reverse} }
										   ]
							replace_handlers
						  }
						  
    SetScreenElementProps {	id=menu_dur
							event_handlers=[ { pad_right  increment_cat_rot_time_value params={ <rot_values> change_dur } }
											 { pad_left   increment_cat_rot_time_value params={ <rot_values> change_dur reverse} }
										   ]
							replace_handlers
						  }
						  
    SetScreenElementProps {	id=menu_done
							event_handlers=[ { pad_choose  edit_rot_done_script params=<rot_values> }
										   ]
							replace_handlers
						  }
endscript

// stores the new rotation values into the CAT class before returning to the timeline
script edit_rot_done_script
	;get_rot_name axis=<axis> deg_dir=<deg_dir>
	;SetScreenElementProps id={ <timeline_id> child=1 } text=<rot_name>
	
	generic_menu_pad_back_sound
	
	// animate menu out
	DoScreenElementMorph id=edit_rot_menu pos=(0,240) time=0.1
	DoScreenElementMorph id=timeline_info_anchor pos=(320,240) time=0.2
	wait 0.1 seconds
    
	if ScreenElementExists id=timeline_fader
		DestroyScreenElement id=timeline_fader
	endif
	
    ;set_new_rot_values <...>
	back_to_timeline
endscript

script get_rot_name
	switch <axis>
		case x
			axis_text="Flip"
			if ( <deg_dir> = 0 )
				dir_text = "Front"
			else
				dir_text = "Back"
			endif
		case y
			axis_text="Spin"
			if ( <deg_dir> = 0 )
				dir_text = "Backside"
			else
				dir_text = "Frontside"
			endif
		case z
			axis_text="Roll"
			if ( <deg_dir> = 0 )
				dir_text = "Heel Side"
			else
				dir_text = "Toe Side"
			endif
	endswitch
	
	FormatText textname=rot_name "%d %a" d=<dir_text> a=<axis_text>
	return rot_name=<rot_name>
endscript


/////////////////////////////////////////////////////////////////
// ANIMATION MENUS
////////////////////////////////////////////////////////////////

// timeline submenu that allows changing of various animation values
script CAT_edit_animation_menu parent=cat_menu_anchor trick_index=0
    
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
    if not GotParam no_new_values
		get_CAT_param_values skater=0 trick_index=0
	endif
    
	get_CAT_anim_values { skater=0 trick_index=0 anim_index=<anim_index> }
    
    make_new_menu {
		parent=<parent>
		menu_id=edit_anim_menu
		vmenu_id=edit_anim_vmenu
		type=VMenu
		pos=(85,70)
	}
	
    if not IsArray <trick>
		params=( <trick>.params )
	else
		params=( (<trick>[0]).params )
	endif
	
	anim_name =(<params>.Name)
    GetUpperCaseString <anim_name>
	
	FormatText ChecksumName=title_icon "%i_new" i=(THEME_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
    build_theme_sub_title title=<UpperCaseString> title_icon=<title_icon> parent=cat_menu_anchor max_width=360 pos=(55,68)
    GetStackedScreenElementPos X id=right_bracket
	if ( <pos>.(1,0) > 280 )
		pos=( (<pos>.(1,0) + -530) * (1,0) + (0,57) )
	else
		pos=(-250,57)
	endif
    build_top_bar pos=<pos> parent=cat_menu_anchor just=[right top]
	
    create_timeline_fader_box parent=cat_menu_anchor
	
	RemoveParameter parent
	
	add_edit_cat_helper_text
	
	anim_values={ id=<id> timeline_id=<timeline_id> trick_index=<trick_index> anim_index=<anim_index> on=<on> trick=<trick> anim=<anim> dur=<dur> percent=<percent> blend=<blend> from=<from> trickType=<trickType> idletime=<idletime> start=<start> order=<order> hold=<hold> backwards=<backwards> }
	
    SetScreenElementProps {
		id=edit_anim_vmenu	
		event_handlers=[ 	{ pad_back   edit_anim_done_script params={ <anim_values> } }
					   ]
    }
	
    switch <trickType>
		case 0
			type_checksum=fliptrick
			type_text="fliptrick"
		case 1
			type_checksum=grab
			type_text="grab"
		case 2
			type_checksum=special
			type_text="special"
		case 3
			type_checksum=misc
			type_text="other"
		case 4
			type_checksum=generic
			type_text="sound"
		default
			printf "CAT: bad trickType"
			return
	endswitch
    theme_menu_add_item text="choose" extra_text=<type_text> id=menu_trick pad_choose_script=CAT_trick_list_menu pad_choose_params={ <anim_values> type=<type_checksum> }
    
	// set new event handler for getting to trick list w/o extra sound
    SetScreenElementProps {
		id=menu_trick	
		event_handlers=[ 	{ pad_zac   CAT_trick_list_menu params={ <anim_values> type=<type_checksum> } }
					   ]
    }
	
	if ( <trickType> = 4 )
		// sounds
		;cat_menu_add_number_item not_focusable=not_focusable text="" value="" id=menu_dur pad_right_script=null_script params={ } last_menu_item=1
	else
		cat_menu_add_number_item 	text="duration" value=<dur> decimalplaces=1 trailingtext=" secs" id=menu_dur pad_right_script=increment_cat_anim_time_value params={ <anim_values> change_dur }
		;cat_menu_add_meter_item text="blend" value=<blend> id=menu_blend 	pad_choose_script=null_script pad_right_script=increment_cat_animation_blend_value params=<anim_values>
		cat_menu_add_meter_item text="start" value=<from>   id=menu_from 	pad_choose_script=null_script pad_right_script=increment_cat_animation_from_value params=<anim_values> 
		cat_menu_add_meter_item text="stop" value=<percent> id=menu_percent pad_choose_script=null_script pad_right_script=increment_cat_animation_percent_value params=<anim_values>
		
		trick_got_idle trick=<trick>
				
		if ( <got_idle> = 1 )
			if ( <hold> = 1 )
				hold_text = "yes"
			else
				hold_text = "no"
			endif
			
			cat_menu_add_number_item text="hold time" value=<idletime> decimalplaces=1 trailingtext=" secs" id=menu_idletime pad_right_script=increment_cat_anim_time_value params={ <anim_values> change_idle }
			cat_menu_add_number_item text="holdable" value=<hold_text> id=menu_hold pad_choose_script=null_script pad_right_script=increment_cat_animation_hold_value params=<anim_values> ;last_menu_item=1
		else
			if ( <backwards> = 1 )
				backwards_text = "on"
			else
				backwards_text = "off"
			endif
			
			cat_menu_add_number_item text="backwards" value=<backwards_text> id=menu_backwards pad_choose_script=null_script pad_right_script=increment_cat_animation_backwards_value params=<anim_values> ;last_menu_item=1
		endif
	endif
	
	theme_menu_add_item text="done" id=menu_done pad_choose_script=edit_anim_done_script pad_choose_params=<anim_values> last_menu_item=1

	FireEvent type=unfocus target=timeline_vmenu
	FireEvent type=focus target=edit_anim_menu
	
	// keep timeline item highlighted
	text_rgba = [100 100 100 100]
	switch <trickType>
		case 0
			sprite_rgba = flip_on_high
		case 1
			sprite_rgba = grab_on_high
		case 2
			sprite_rgba = spec_on_high
		case 3
			sprite_rgba = misc_on_high
		case 4
			sprite_rgba = gen_on_high
	endswitch
	
    if ScreenElementExists id={ <timeline_id> child=0 }
		//bg
		DoScreenElementMorph time=0 id={ <timeline_id> child=0 } rgba=<sprite_rgba>
		//text
		DoScreenElementMorph time=0 id={ <timeline_id> child=1 } rgba=<text_rgba>
		;RunScriptOnScreenElement id={ <timeline_id> child=1 } text_twitch_effect2
	endif
	
	if not GotParam no_animate
		// animate menu in
		DoScreenElementMorph id=edit_anim_menu pos=(0,240)
		GetScreenElementPosition id=top_bar_anchor
		pos=( <ScreenElementPos> - (320,0) )
		DoScreenElementMorph id=top_bar_anchor pos=<pos>
		GetScreenElementPosition id=submenu_title_anchor
		pos=( <ScreenElementPos> - (320,0) )
		DoScreenElementMorph id=submenu_title_anchor pos=<pos>
		
		if ( show_cat_trick_list = 0 )
			DoScreenElementMorph id=edit_anim_menu pos=(320,240) time=0.1
		endif
		GetScreenElementPosition id=top_bar_anchor
		pos=( <ScreenElementPos> + (320,0) )
		DoScreenElementMorph id=top_bar_anchor pos=<pos> time=0.1
		GetScreenElementPosition id=submenu_title_anchor
		pos=( <ScreenElementPos> + (320,0) )
		DoScreenElementMorph id=submenu_title_anchor pos=<pos> time=0.1
		
		DoScreenElementMorph id=timeline_info_anchor time=0.2 pos=(-350,240)
	endif
	
	if GotParam back_from_submenu
		 back_to_edit_anim
	endif
	
	if ( show_cat_trick_list = 1 )
        // fires special event to get into trick list w/o extra sound
		FireEvent type=pad_zac target={edit_anim_vmenu child=1}
	endif
	
endscript

// extracts all values from indexed animation_info structure
script grab_all_anim_values
	return {
				on=( ( <animation_info>[<anim_index>]).on )
				trick=( ( <animation_info>[<anim_index>]).trick )
				anim=( ( <animation_info>[<anim_index>]).anim )
				dur=( ( <animation_info>[<anim_index>]).dur )
				percent=( ( <animation_info>[<anim_index>]).percent )
				blend=( ( <animation_info>[<anim_index>]).blend )
				from=( ( <animation_info>[<anim_index>]).from )
				trickType=( ( <animation_info>[<anim_index>]).trickType )
				idletime=( ( <animation_info>[<anim_index>]).idletime )
				start=( ( <animation_info>[<anim_index>]).start )
				order=( ( <animation_info>[<anim_index>]).order )
				hold=( ( <animation_info>[<anim_index>]).hold )
				backwards=( ( <animation_info>[<anim_index>]).backwards )
			}
endscript

// lists available tricks
script CAT_trick_list_menu parent=edit_anim_menu type=grab
    
	// gotta have this to keep the previous menu
	// from firing events while this one is created
	FireEvent type=unfocus target=edit_anim_menu
	
    make_new_menu {
		parent=<parent>
		menu_id=trick_menu
		vmenu_id=trick_vmenu
		scrolling_menu_id=trick_scrolling_menu
		menu_title=<menu_title>
		type=VScrollingMenu
		dims=(200, 135)
		;padding_scale=.95
		pos=(480,110)
		no_alias
	}
	
	if ( show_cat_trick_list=0 )
		DoScreenElementMorph time=0 id=trick_menu pos=(540,233)
	
		SetScreenElementProps {
			id=trick_vmenu	
			event_handlers=[ 	{pad_back   back_to_edit_anim }
						   ]
		}
		add_cat_generic_helper_text
	else
		SetScreenElementLock id=cat_menu_anchor off
		create_helper_text { 	parent=cat_menu_anchor
								helper_text_elements=[ 	{ text="\b7/\b4 = Select" }
														{ text="\m0 = Accept" } 
													 ]
						   }
	endif
	
    switch <type>
		case grab
            add_trick_list_items array=cat_grab_tricks anim_index=<anim_index> timeline_id=<timeline_id>
		case fliptrick
			add_trick_list_items array=cat_flip_tricks anim_index=<anim_index> timeline_id=<timeline_id>
		case special
			add_trick_list_items array=cat_special_tricks anim_index=<anim_index> timeline_id=<timeline_id>
		case misc
			add_trick_list_items array=cat_misc_tricks anim_index=<anim_index> timeline_id=<timeline_id>
		case generic
            PauseStream 0
			add_trick_list_items array=cat_generic_tricks anim_index=<anim_index> timeline_id=<timeline_id> sounds=sounds
	endswitch
	
    FireEvent type=unfocus target=edit_anim_menu
	FireEvent type=focus target=trick_menu
	
	if ( show_cat_trick_list=0 )
		DoScreenElementMorph time=0.1 id=trick_menu pos=(235,233)
		wait 0.05 seconds
		DoScreenElementMorph time=0.1 id=edit_anim_menu pos=(30,240)
		wait 0.05 seconds
		DoScreenElementMorph time=0.05 id=edit_anim_menu pos=(-20,240)
		DoScreenElementMorph time=0.05 id=trick_menu pos=(285,233)
	else
		DoScreenElementMorph id=edit_anim_menu pos=(-20,240)
		DoScreenElementMorph id=trick_menu pos=(-20,233)
        DoScreenElementMorph time=0.15 id=trick_menu pos=(285,233)
		
        change show_cat_trick_list=0
	endif
endscript

// destroys edit anim submenu and restores focus
script back_to_edit_anim
    PauseStream 1
	
	if not GotParam no_focus
		generic_menu_pad_back_sound
	endif
	DoScreenElementMorph time=0.15 id=edit_anim_menu pos=(320,240)
	wait 0.15 seconds
    
	if ScreenElementExists id=trick_menu
		DoScreenElementMorph time=0.15 id=trick_menu pos=(580,240)
		wait 0.25 seconds
		DestroyScreenElement id=trick_menu
	endif
	
	if not GotParam no_focus
		add_edit_cat_helper_text
		FireEvent type=focus target=edit_anim_menu
	endif
endscript

// sets new trick value and returns to edit animation menu
script CAT_set_trick_struct
    get_CAT_anim_values skater=0 trick_index=0 anim_index=<anim_index>
    trick=<new_trick>
	
	// get trick's default duration
	calculate_anim_default_dur trick=<trick> anim_index=<anim_index>
	
	// rescale timeline bar to new duration
	trick_got_idle trick=<trick>
	if ( <got_idle> = 1 )
		idletime=0
		duration = ( <dur> + <idletime> )
		idle_start=( <dur> / 2 )
	else
		duration = <dur>
	endif
    update_scale_to_new_duration id=<timeline_id> duration=<duration> idletime=<idletime> idle_start=<idle_start>
	
	// save new values
	quick_set_anim_values <...>
	update_all_anim_positions
	
    calculate_cat_score get_values
    
	back_to_edit_anim no_focus
	RemoveParameter parent
	CAT_edit_animation_menu <...> no_new_values no_animate 
	
	// set timeline text value
    if not IsArray <trick>
		params=( <trick>.params )
	else
		params=( (<trick>[0]).params )
	endif
	anim_name =(<params>.Name)
    SetScreenElementProps id={ <timeline_id> child=1 } text=<anim_name>
	SetScreenElementProps id={ <timeline_id> child={ 1 child=0 } } text=<anim_name>
	// truncate text
	max_width=( ( <dur> - 0.1 ) * 160 )
	truncate_string id={ <timeline_id> child=1 } max_width=<max_width>
	
endscript

// toggles animation on / off. also used to make hidden animations available when choosing to add a "new" anim
script toggle_anim_on_off
    
	;GetCreateATrickAnimations skater=0 trick_index=0
    ;grab_all_anim_values { animation_info=<animation_info> anim_index=<anim_index> }
	get_CAT_anim_values skater=0 trick_index=0 anim_index=<anim_index>
	
    if GotParam Delete
		// deleting animation
		on = 2
	else
		if ( <on> = 0 )
			// anim is off... turn it on (unhide)
            // get length of trick
			calculate_cat_score get_time anims_only no_hidden
            // add length of hidden anim
			trick_got_idle trick=<trick>
			if ( <got_idle> = 1 )
				time = ( <time> + <start> + <dur> + <idletime> )
			else
				time = ( <time> + <start> + <dur> )
			endif
			// if total is less than or equal to 3 seconds,
			// unhide the anim
            if ( (3.0 > <time>) || (<time> = 3.0) )
				on = 1
				GetTags
				focus_id=<id>
                PlaySound copinghit3_11 pitch=60
			else
				generic_menu_buzzer_sound
				return
			endif
		else
			if ( <on> = 2 )
				// anim is new... turn it on
				on = 1
				new_anim=1
				
				change show_cat_trick_list=1
				
				switch <type>
					case fliptrick
						trickType=0
						trick=trick_kickflip
					case grab
						trickType=1
						trick=trick_indy
                    case special
						trickType=2
						trick=trick_the900
					case misc
						trickType=3
						trick=CATTrick_Handstand
					case generic
						trickType=4
						trick=CATSFX_StripClub
					default
						"what the hell kinda trick is that?"
				endswitch
			else	
				// anim is on... turn it off (hide)
				on = 0
				GetTags
				focus_id=<id>
				PlaySound copinghit3_11 pitch=60
			endif
		endif
	endif
	
	if GotParam new_anim
		// reset to default values
        idletime=0
        percent=1
		blend=CAT_BLEND
		from=0
		start=0
        
		calculate_anim_default_dur trick=<trick> anim_index=<anim_index>
	endif
	
    quick_set_anim_values <...>
	
	// make sure any new sounds are at the beginning
	if ( <trickType> = 4 )
		last_order=6
		begin
			increment_cat_animation_order_value { anim_index=<anim_index> reverse quick_sound_insert }
			if ( ( <order> = 0 ) || ( <order> = <last_order> ) )
				break
			endif
			last_order=<order>
		repeat
	endif
	
	create_cat_timeline { get_id=get_id anim_index=<anim_index> }
	kill_start_key_binding
	
	if GotParam Delete
		focus_cat_timeline
		return
	endif
	
    if not GotParam new_anim
        FireEvent type=focus target=timeline_vmenu data={ child_id=<focus_id> }
		SetScreenElementProps id=timeline_scrolling_menu reset_window_top
	else
        FireEvent type=focus target=timeline_vmenu
		if ( <value> > 1 )
			begin
				FireEvent type=pad_down target=timeline_vmenu
			repeat (<value>-1)
		endif
        FireEvent type=pad_zac target={timeline_vmenu child=(<value>-1)}
        // need to scroll timeline back up
		SetScreenElementProps id=timeline_scrolling_menu reset_window_top
	endif
endscript

show_cat_trick_list=0

// increments / decrements duration, idletime, of start time values
script increment_cat_anim_time_value
	printf "script increment_cat_anim_time_value"
	generic_menu_scroll_sideways_sound
	
	;grab_all_anim_values { animation_info=<animation_info> anim_index=<anim_index> }
	
	if GotParam change_dur
		printf "change_dur"
		time_value=<dur>
	else
		if GotParam change_idle
			printf "change_idle"
			time_value=<idletime>
		else
			if GotParam change_start
				printf "change_start"
				time_value=<start>
			else
				printf "Missing change_ param"
				return
			endif
		endif
	endif
	
    if GotParam reverse
		time_value = ( <time_value> - 0.1 )
	else
		calculate_cat_score get_time anims_only
        if ( <time> > 2.9 )
            PlaySound GUI_buzzer01 pitch=60
            return
		endif
        time_value = ( <time_value> + 0.1 )
	endif
	
    if ( 0 > <time_value> )
		time_value = 0.0
	endif
	if ( <time_value> > 3.0 )
		time_value = 3.0
	endif
	
    if GotParam change_dur
		// duration
        if ( 0.1 > <time_value> )
			time_value = 0.1
		endif
        
		dur=<time_value>
		
		FormatText TextName=value_text "%i secs" i=<time_value> decimalplaces=1
		SetScreenElementProps id={ menu_dur child=3 } text=<value_text>
		cat_update_right_arrow
		
		trick_got_idle trick=<trick>
		
		if ( <got_idle> = 1 )
			duration = ( <time_value> + <idletime> )
			idle_start=( <time_value> / 2 )
		else
			duration = <time_value>
		endif
		
        update_scale_to_new_duration id=<timeline_id> duration=<duration> idletime=<idletime> idle_start=<idle_start>
	else
		if GotParam change_start
			//start
            start=<time_value>
			
			FormatText TextName=value_text "%i secs" i=<time_value>
            SetScreenElementProps id={ menu_start child=3 } text=<value_text>
		else
			//idletime
			if ( <hold> = 1 )
				if ( <time_value> = 0 )
					hold = 0
				endif
			endif
            idletime=<time_value>
			
			FormatText TextName=value_text "%i secs" i=<time_value> decimalplaces=1
			SetScreenElementProps id={ menu_idletime child=3 } text=<value_text>
			cat_update_right_arrow
			
			if ( <hold> = 1 )
				hold_text = "yes"
			else
				hold_text = "no"
			endif
			SetScreenElementProps id={ menu_hold child=3 } text=<hold_text>
			// adjust right arrow
			GetStackedScreenElementPos X id={ menu_hold child=3 } offset=(3,2)
			DoScreenElementMorph id={ menu_hold child=5 } pos=<pos>
			
            trick_got_idle trick=<trick>
			
			if ( <got_idle> = 1 )
				duration = ( <time_value> + <dur> )
				idle_start=( <dur> / 2 )
			else
				printf "CAT: THIS SHOULD NEVER EVER HAPPEN"
				duration = <dur>
			endif
			
            update_scale_to_new_duration id=<timeline_id> duration=<duration> idletime=<time_value> idle_start=<idle_start>
		endif
	endif
	
	RemoveParameter change_dur
	RemoveParameter change_idle
	
    quick_set_anim_values <...>
	
	update_all_anim_positions
	calculate_cat_score get_values
	
    update_anim_increment_params <...>
	
endscript

// increments / decrements blend values
script increment_cat_animation_blend_value
	printf "script increment_cat_animation_blend_value"
	generic_menu_scroll_sideways_sound
    
	;grab_all_anim_values { animation_info=<animation_info> anim_index=<anim_index> }
	
	if GotParam reverse
		blend = ( <blend> - 0.01 )
	else
		blend = ( <blend> + 0.01 )
	endif
	
	if ( <blend> > 0.5 )
		blend = 0.5
	endif
	
	if ( 0 > <blend> )
		blend = 0.000
	endif
	
    ;update_animation_info_array <...>
    
	blend_int=(<blend>*100)
	CastToInteger blend_int
	FormatText TextName=value_text "%i \%" i=<blend_int>
	SetScreenElementProps id={ menu_blend child=3 } text=<value_text>
	
	// meter
	meter_scale = ( <blend> * (5,0) + (0,1) )
	DoScreenElementMorph id={ menu_blend child=6 } scale=<meter_scale>
    
    quick_set_anim_values <...>
	
	update_anim_increment_params <...>
endscript

// increments / decrements from values
script increment_cat_animation_from_value
	trick_got_idle trick=<trick>
	generic_menu_scroll_sideways_sound
	
	if GotParam reverse
		from = ( <from> - 0.01 )
	else
		from = ( <from> + 0.01 )
	endif
	
	if ( <got_idle> = 1 )
		if ( <from> > 0.5 )
			from = 0.5
		endif
	endif
	
	if (<from> > (<percent> - 0.2))
		from = ( <percent> - 0.2 )
	endif
	
	if ( 0 > <from> )
		from = 0
	endif
	
    from_int = (<from>*100)
	CastToInteger from_int
	FormatText TextName=value_text "%i \%" i=<from_int>
	SetScreenElementProps id={ menu_from child=3 } text=<value_text>
	
	// meter
	meter_scale = ( <from> * (5,0) + (0,1) )
	DoScreenElementMorph id={ menu_from child=6 } scale=<meter_scale>
	
    quick_set_anim_values <...>
	
	update_anim_increment_params <...>
endscript

// increments / decrements animation percent values
script increment_cat_animation_percent_value
	generic_menu_scroll_sideways_sound
	
	trick_got_idle trick=<trick>
    
	if GotParam reverse
		percent = ( <percent> - 0.01 )
	else
		percent = ( <percent> + 0.01 )
	endif
	
	if ( <percent> > 1 )
		percent = 1
	endif
	
	if ( <got_idle> = 1 )
		if ( 0.5 > <percent> )
			percent = 0.5
		endif
	endif
	
	if (<from> > (<percent> - 0.2))
		percent = ( <from> + 0.2 )
	endif
	
    percent_int = (<percent>*100)
    CastToInteger percent_int
	FormatText TextName=value_text "%i \%" i=<percent_int>
	SetScreenElementProps id={ menu_percent child=3 } text=<value_text>
	
	// meter
	meter_scale = ( <percent> * (5,0) + (0,1) )
	DoScreenElementMorph id={ menu_percent child=6 } scale=<meter_scale>
    
    quick_set_anim_values <...>
	
    update_anim_increment_params <...>
endscript

// increments / decrements animation order value and swaps values of preceeding or following anim.
script increment_cat_animation_order_value
	
	if not GotParam quick_sound_insert
		PlaySound DE_MenuSelect vol=100
	endif
	
	GetCreateATrickAnimations skater=0 trick_index=0
	grab_all_anim_values { animation_info=<animation_info> anim_index=<anim_index> }
	;get_CAT_anim_values skater=0 trick_index=0 anim_index=<anim_index>
	
	printf "initial order = %i" i=<order>
    
    if GotParam reverse
		if not ( <order> = 1 )
            new_order = ( <order> - 1 )
			//swap this order with the anim that has the order we want!
			GetArraySize <animation_info>
			
			index=0
			get_out=0
			begin
				begin
					criteria_met=0
					// find the anim with the order we want
					if ( ((<animation_info>[<index>]).order) = <new_order> )
                        // is that anim on?
						if ( ((<animation_info>[<index>]).on) = 1 )
							// sounds have to be first, so don't bump one of them over!
							if not ( ((<animation_info>[<index>]).trickType) = 4 )
								criteria_met = 1
							endif
						endif
						
						if ( <criteria_met> = 1 )
							;((<animation_info>[<index>]).order) = <order>	// Can't do it this way!!
							SetArrayElement {	ArrayName=animation_info
												index=<index>
												newvalue={ 	order=<order>
															on=((<animation_info>[<index>]).on)
															trick=((<animation_info>[<index>]).trick)
															anim=((<animation_info>[<index>]).anim)
															dur=((<animation_info>[<index>]).dur)
															percent=((<animation_info>[<index>]).percent)
															blend=((<animation_info>[<index>]).blend)
															from=((<animation_info>[<index>]).from)
															trickType=((<animation_info>[<index>]).trickType)
															idletime=((<animation_info>[<index>]).idletime)
															start=((<animation_info>[<index>]).start)
															hold=((<animation_info>[<index>]).hold)
															backwards=((<animation_info>[<index>]).backwards)
														}
											}
							get_out=1
							break
						else
							// anim wasn't on, so start the loop over again looking for the one before it this time
							if ( <new_order> > 1 )
								new_order=(<new_order> - 1 )
								break
							else
								return
							endif
						endif
					endif
					
					index = ( <index> + 1 )
					
					if ( <index> = <array_size> )
						printf "what the hell happened here?"
						return
					endif
				repeat <array_size>
				if ( <get_out> = 1 )
					break
				else
					index=0
				endif
			repeat <array_size>
			order=<new_order>
		else
			return
		endif
	else
		if not ( <order> = 6 )
			new_order = ( <order> + 1 )
			//swap this order with the anim that has the order we want!
			GetArraySize <animation_info>
			
			index=0
			get_out=0
			begin
				begin
					// find the anim with the order we want
					if ( ((<animation_info>[<index>]).order) = <new_order> )
						// is that anim on?
						if ( ((<animation_info>[<index>]).on) = 1 )
							;((<animation_info>[<index>]).order) = <order>	// Can't do it this way!!
							SetArrayElement {	ArrayName=animation_info
												index=<index>
												newvalue={ 	order=<order>
															on=((<animation_info>[<index>]).on)
															trick=((<animation_info>[<index>]).trick)
															anim=((<animation_info>[<index>]).anim)
															dur=((<animation_info>[<index>]).dur)
															percent=((<animation_info>[<index>]).percent)
															blend=((<animation_info>[<index>]).blend)
															from=((<animation_info>[<index>]).from)
															trickType=((<animation_info>[<index>]).trickType)
															idletime=((<animation_info>[<index>]).idletime)
															start=((<animation_info>[<index>]).start)
															hold=((<animation_info>[<index>]).hold)
															backwards=((<animation_info>[<index>]).backwards)
														}
											}
							get_out=1
							break
						else
							// anim wasn't on, so start the loop over again looking for the one after it this time
							if ( 6 > <new_order> )
								new_order=(<new_order> + 1 )
								break
							else
								return
							endif
						endif
					endif
					
					index = ( <index> + 1 )
					
					if ( <index> = <array_size> )
						printf "what the hell happened here?"
						return
					endif
				repeat <array_size>
				if ( <get_out> = 1 )
					break
				else
					index=0
				endif
			repeat <array_size>
			order=<new_order>
		else
			return
		endif
	endif
	
	printf "final order = %i" i=<order>
	
    update_animation_info_array <...>
    ;quick_set_anim_values <...>
    SetCreateATrickAnimations {	skater=0 trick_index=0 animation_info=<animation_info> }
	
	if GotParam quick_sound_insert
		return order=<order>
	endif
	
	update_all_anim_positions animation_info=<animation_info>
	
	;update_anim_increment_params <...>
endscript

// toggles anim hold on / off. if toggling on, makes sure no other anims have hold value on.
script increment_cat_animation_hold_value
	generic_menu_scroll_sideways_sound
	;printf "script increment_cat_animation_hold_value"
    
	GetCreateATrickAnimations skater=0 trick_index=0
	;grab_all_anim_values { animation_info=<animation_info> anim_index=<anim_index> }
	
    if ( <hold> = 1 )
		hold = 0
	else
		hold = 1
		//set all others to zero!
		GetArraySize <animation_info>
        index=0
		begin
            ;((<animation_info>[<index>]).hold) = 0	// Can't do it this way!!
			SetArrayElement ArrayName=animation_info index=<index> newvalue={ 	hold=0
			    																on=((<animation_info>[<index>]).on)
			    																trick=((<animation_info>[<index>]).trick)
			    																anim=((<animation_info>[<index>]).anim)
			    																dur=((<animation_info>[<index>]).dur)
																				percent=((<animation_info>[<index>]).percent)
																				blend=((<animation_info>[<index>]).blend)
																				from=((<animation_info>[<index>]).from)
																				trickType=((<animation_info>[<index>]).trickType)
																				idletime=((<animation_info>[<index>]).idletime)
																				start=((<animation_info>[<index>]).start)
																				order=((<animation_info>[<index>]).order)
																				backwards=((<animation_info>[<index>]).backwards)
																			}
			index = ( <index> + 1 )
		repeat <array_size>
	endif
	
	if ( <hold> = 1 )
		if ( <idletime> = 0 )
			idletime=0.1
            update_scale_to_new_duration {	id=<timeline_id>
											duration = ( <dur> + <idletime> )
											idletime=<idletime>
											idle_start=( <dur> / 2 )
										 }
		endif
	endif
	
    ;update_animation_info_array <...>
    
	if ( <hold> = 1 )
		hold_text = "yes"
	else
		hold_text = "no"
	endif
	;FormatText TextName=value_text "%i" i=<hold>
	FormatText TextName=idle_text "%i secs" i=<idletime> decimalplaces=1
	SetScreenElementProps id={ menu_hold child=3 } text=<hold_text>
	// adjust right arrow
	GetStackedScreenElementPos X id={ menu_hold child=3 } offset=(3,2)
	DoScreenElementMorph id={ menu_hold child=5 } pos=<pos>
	SetScreenElementProps id={ menu_idletime child=3 } text=<idle_text>
	
    quick_set_anim_values <...>
	
	update_anim_increment_params <...>
endscript

// toggles anim backwards on / off.
script increment_cat_animation_backwards_value
	generic_menu_scroll_sideways_sound

    GetCreateATrickAnimations skater=0 trick_index=0
    
    if ( <backwards> = 1 )
        backwards_text = "off"
		<backwards> = 0
	else
		backwards_text = "on"
		<backwards> = 1
	endif
	
    SetScreenElementProps id={ menu_backwards child=3 } text=<backwards_text>
    
    quick_set_anim_values <...>
    update_anim_increment_params <...>
endscript

// gets speed from trick array and uses it to calculate that tricks normal duration
script calculate_anim_default_dur
	if not IsArray <trick>
		params=( <trick>.params )
	else
		params=( (<trick>[0]).params )
	endif
	
	if StructureContains structure=<params> anim
		anim = (<params>.anim)
	else
		anim = (<params>.initanim)
	endif
    speed = (<params>.speed)
	BackwardsAnim = (<params>.BackwardsAnim)
	
	if not GotParam speed
		speed=1.0
	endif
	
    Skater:GetAnimLength anim=<anim>
	
	if GotParam BackwardsAnim
		length1 = <length>
		Skater:GetAnimLength anim=<BackwardsAnim>
	endif
	
	// Need to know if this trick has an idle
	trick_got_idle trick=<trick>
	if ( <got_idle> = 0 )
        dur = ( <length> / <speed> )
	else
		if GotParam BackwardsAnim
			dur = ( (<length1> / <speed>) + (<length> / <speed>) )
		else
			dur = ( ( <length> / <speed> ) * 2 )
		endif
	endif
	
	// sounds
    if StructureContains structure=<params> sound
		dur = 0.5
	endif
	
    // need to round off this value to the nearest tenth of a second
	printf "dur before = %i" i=<dur>
	dur = ( <dur> * 10.0 )
	dur = ( <dur> + 0.5 )
	CastToInteger dur
	dur = ( <dur> / 10.0 )
	printf "dur after = %i" i=<dur>
	
	if ( (<dur> = 0) || (0 > <dur>) )
		dur=0.1
	endif
    
	// timeline is only 3 secs long!
	if ( <dur> > 3 )
		dur = 3.0
	endif
	
	// get length of trick minus this anim
	calculate_cat_score get_time minus=<anim_index> anims_only
    // make sure new trick doesn't go off timeline
	if ( <dur> > ( 3.0 - <time> ) )
		dur = ( 3.0 - <time> )
	endif
	printf "dur after cut = %i" i=<dur>
    
	return dur=<dur>
endscript

// updates the event handlers for edit anim menu items when any of the values change.
script update_anim_increment_params
	RemoveParameter reverse
	;GetCreateATrickAnimations skater=0 trick_index=<trick_index>
	
	anim_values={ id=<id> timeline_id=<timeline_id> trick_index=<trick_index> anim_index=<anim_index> on=<on> trick=<trick> anim=<anim> dur=<dur> percent=<percent> blend=<blend> from=<from> trickType=<trickType> idletime=<idletime> start=<start> order=<order> hold=<hold> backwards=<backwards> }
	
	SetScreenElementProps {
		id=edit_anim_vmenu	
		event_handlers=[ 	{ pad_back   edit_anim_done_script params=<anim_values> }
					   ]
		replace_handlers
    }
	
	if ScreenElementExists id=menu_percent
		SetScreenElementProps {	id=menu_percent
							event_handlers=[ { pad_right  increment_cat_animation_percent_value params=<anim_values> }
											 { pad_left   increment_cat_animation_percent_value params={<anim_values> reverse} }
										   ]
							replace_handlers
						  }
	endif
						  
	if ScreenElementExists id=menu_blend
		SetScreenElementProps {	id=menu_blend
								event_handlers=[ { pad_right  increment_cat_animation_blend_value params=<anim_values> }
												 { pad_left   increment_cat_animation_blend_value params={<anim_values> reverse} }
											   ]
								replace_handlers
							  }
	endif
	
	if ScreenElementExists id=menu_from
		SetScreenElementProps {	id=menu_from
							event_handlers=[ { pad_right  increment_cat_animation_from_value params=<anim_values> }
											 { pad_left   increment_cat_animation_from_value params={<anim_values> reverse} }
										   ]
							replace_handlers
						  }
	endif
	
    SetScreenElementProps {	id=menu_dur
								event_handlers=[ { pad_right  increment_cat_anim_time_value params={ <anim_values> change_dur } }
												 { pad_left   increment_cat_anim_time_value params={ <anim_values> change_dur reverse} }
											   ]
								replace_handlers
							  }
	
	/*SetScreenElementProps {	id=menu_start
								event_handlers=[ { pad_right  increment_cat_anim_time_value params={ <anim_values> change_start } }
												 { pad_left   increment_cat_anim_time_value params={ <anim_values> change_start reverse} }
											   ]
								replace_handlers
							  }
	
	SetScreenElementProps {	id=menu_order
								event_handlers=[ { pad_right  increment_cat_animation_order_value params=<anim_values> }
												 { pad_left   increment_cat_animation_order_value params={ <anim_values> reverse} }
											   ]
								replace_handlers
							  }*/
							  							  
	if ScreenElementExists id=menu_idletime
		SetScreenElementProps {	id=menu_idletime
								event_handlers=[ { pad_right  increment_cat_anim_time_value params={ <anim_values> change_idle } }
												 { pad_left   increment_cat_anim_time_value params={ <anim_values> change_idle reverse} }
											   ]
								replace_handlers
							  }
	endif
	
	if ScreenElementExists id=menu_hold 
		SetScreenElementProps {	id=menu_hold
								event_handlers=[ { pad_right  increment_cat_animation_hold_value params=<anim_values> }
												 { pad_left   increment_cat_animation_hold_value params={ <anim_values> reverse} }
											   ]
								replace_handlers
							  }
	endif
	
	if ScreenElementExists id=menu_backwards 
		SetScreenElementProps {	id=menu_backwards
								event_handlers=[ { pad_right  increment_cat_animation_backwards_value params=<anim_values> }
												 { pad_left   increment_cat_animation_backwards_value params={ <anim_values> reverse} }
											   ]
								replace_handlers
							  }
	endif
							  
	/*
	if ScreenElementExists id=menu_trick
		SetScreenElementProps {	id=menu_trick
								event_handlers=[ { pad_right_script increment_cat_animation_trick_type_value params=<anim_values> }
											   ]
								replace_handlers
							  }
	endif
	
	if ScreenElementExists id=menu_anim
		SetScreenElementProps {	id=menu_anim
								event_handlers=[ { pad_right_script increment_cat_animation_trick_type_value params=<anim_values> }
											   ]
								replace_handlers
							  }
	endif
	*/
	
	if ScreenElementExists id=menu_done 
		SetScreenElementProps {	id=menu_done
								event_handlers=[ { pad_choose  edit_anim_done_script params=<anim_values> }
											   ]
								replace_handlers
							  }
	endif
endscript

// stores new anim values and returns to timeline
script edit_anim_done_script
    generic_menu_pad_back_sound
	
	quick_set_anim_values <...>
    
    // animate menu out
	DoScreenElementMorph id=edit_anim_menu pos=(0,240) time=0.1
	GetScreenElementPosition id=top_bar_anchor
	pos=( <ScreenElementPos> - (320,0) )
	DoScreenElementMorph id=top_bar_anchor pos=<pos> time=0.1
	GetScreenElementPosition id=submenu_title_anchor
	pos=( <ScreenElementPos> - (320,0) )
	DoScreenElementMorph id=submenu_title_anchor pos=<pos> time=0.1
	DoScreenElementMorph id=timeline_info_anchor time=0.2 pos=(320,240)
	wait 0.1 seconds
    
	if ScreenElementExists id=top_bar_anchor
		DestroyScreenElement id=top_bar_anchor
	endif
    if ScreenElementExists id=submenu_title_anchor
		DestroyScreenElement id=submenu_title_anchor
	endif
	if ScreenElementExists id=timeline_fader
		DestroyScreenElement id=timeline_fader
	endif
	
	back_to_timeline
endscript

script update_animation_info_array
	SetArrayElement ArrayName=animation_info index=<anim_index> newvalue={ on=<on> trick=<trick> anim=<anim> dur=<dur> percent=<percent> blend=<blend> from=<from> trickType=<trickType> idletime=<idletime> start=<start> order=<order> hold=<hold> backwards=<backwards> }
	return { animation_info=<animation_info> }
endscript

////////////////////////////////////////////////////////////////////////
// Timeline 
////////////////////////////////////////////////////////////////////////

script create_cat_timeline { pos=(23,260)
							 parent=cat_menu_anchor
							 internal_just=[left top]
							 just=[center center]
							 trick = 0
							 ;scrolling_menu_offset=(0, 10)
							}
	;printf"script create_cat_timeline"
	
	if ScreenElementExists id=timeline_anchor
		DestroyScreenElement id=timeline_anchor
	endif
	
	;kill_start_key_binding
	
    SetScreenElementLock id=<parent> off 
    
    CreateScreenElement {
		type=ContainerElement 
		parent=<parent>
		id=timeline_anchor
		
		just=[left top]
		internal_just=[left top]
        pos=<pos>
        dims=(640, 300)
		focusable_child=timeline_vmenu
	}
	
	CreateScreenElement {
	   type=VScrollingMenu 
	   parent=timeline_anchor
	   					
	   id=timeline_scrolling_menu
	   pos=(0,0)
	   just=[left top]
	   dims=(640,137)
       internal_just=[left top]
	   ;num_items_to_show=6
	}
	
    CreateScreenElement {
	   type=VMenu 
	   parent=timeline_scrolling_menu
	   id=timeline_vmenu 
	   		
       just=[left top]
	   pos=(0,0)
	   padding_scale=1.15
       internal_just=[left top]
	   dont_allow_wrap
	}
	
    SetScreenElementProps {
		id=timeline_vmenu
		event_handlers=[ { pad_back  create_CAT_pause_menu params={ from_timeline } }
						{ pad_start create_CAT_pause_menu params={ from_timeline } }
						{ pad_up 	generic_menu_up_or_down_sound params={ up } }
						{ pad_down	generic_menu_up_or_down_sound params={ down } }
						{ pad_alt	toggle_can_spin params={ } }
					  ]
	}
    
	if GotParam load
		;printf "getting loaded trick values"
		get_CAT_param_values trick_index=<load>
		SetCreateATrickParams {		skater=0
                                    trick_index=0
                                    other_params = { 	name=<name> 
														rotateafter=<rotateafter>
														full=1
														can_spin=<can_spin>
													}
									rotation_info=<rotation_info>
									animation_info=<animation_info>
							   }
    else
		if GotParam new		
			;printf "getting new trick values"
			get_new_cat_values
			SetCreateATrickParams {		skater=0
										trick_index=0
										other_params = { 	name=<name> 
															rotateafter=<rotateafter>
															full=1
															can_spin=1
														}
										rotation_info=<rotation_info>
										animation_info=<animation_info>
								   }
		endif
	endif
	
    RemoveParameter rotation_info
	RemoveParameter animation_info
	
	// Get CAT editable values
	;get_CAT_param_values trick_index=0
	
    index=0
	begin
		FormatText ChecksumName=row_id "timeline_row%i" i=<index>
        create_CAT_timeline_row row_id=<row_id> ;rotation_info=(<rotation_info>[<index>]) animation_info=(<animation_info>[<index>])
		index = ( <index> + 1 )
	repeat 13
	
	;wait 2 gameframes // must have  <--- that, before next line
	;SetScreenElementProps id=timeline_scrolling_menu reset_window_bottom
    
	if not ( (GotParam name) || (GotParam can_spin) )
		get_CAT_other_param_values trick_index=0
	endif
    
    create_timeline_trick_info {
		name=<name>
		can_spin=<can_spin>
	}
    
	CreateScreenElement {
		type=SpriteElement
		parent=timeline_anchor
		
		texture=cat_bar
		rgba=[128 128 128 68]
		just=[left top]
		scale = (75,1.1)
		pos=(0, -238)
		z_priority=-1
	}
    
	// timeline scrubber
	CreateScreenElement {
		type=SpriteElement
		parent=timeline_anchor
		id=timeline_scrubber
		
		texture=white2
		rgba=[60 60 60 100]
		just=[center top]
		pos=(0, -16)
		scale=(0.5,19)
		z_priority=101
		alpha=0
	}
	// timeline time values
	CreateScreenElement {
		type=TextElement
		parent=timeline_anchor
		
		text="0"
		font=dialog
		rgba=[100 100 100 50]
		just=[center center]
		pos=(0,-12)
		z_priority=1
	}
	CreateScreenElement {
		type=SpriteElement
		parent=timeline_anchor
		
		texture=black
		rgba=[0 0 0 50]
		just=[center top]
		pos=(0, -16)
		scale=(1,38)
		z_priority=-4
	}
    CreateScreenElement {
		type=SpriteElement
		parent=timeline_anchor
		
		texture=black
		rgba=[0 0 0 30]
		just=[center top]
		pos=(100, 0)
		scale=(1,34)
		z_priority=-4
	}
    CreateScreenElement {
		type=TextElement
		parent=timeline_anchor
		
		text="1"
		font=dialog
		rgba=[100 100 100 50]
		just=[center center]
		pos=(200,-12)
		z_priority=-1
	}
    CreateScreenElement {
		type=SpriteElement
		parent=timeline_anchor
		
		texture=black
		rgba=[0 0 0 50]
		just=[center top]
		pos=(200, -16)
		scale=(1,38)
		z_priority=-4
	}
	CreateScreenElement {
		type=SpriteElement
		parent=timeline_anchor
		
		texture=black
		rgba=[0 0 0 30]
		just=[center top]
		pos=(300, 0)
		scale=(1,34)
		z_priority=-4
	}
	CreateScreenElement {
		type=TextElement
		parent=timeline_anchor
		
		text="2"
		font=dialog
		rgba=[100 100 100 50]
		just=[center center]
		pos=(400,-12)
		z_priority=1
	}
	CreateScreenElement {
		type=SpriteElement
		parent=timeline_anchor
		
		texture=black
		rgba=[0 0 0 50]
		just=[center top]
		pos=(400, -16)
		scale=(1,38)
		z_priority=-4
	}
	CreateScreenElement {
		type=SpriteElement
		parent=timeline_anchor
		
		texture=black
		rgba=[0 0 0 30]
		just=[center top]
		pos=(500, 0)
		scale=(1,34)
		z_priority=-4
	}
	CreateScreenElement {
		type=TextElement
		parent=timeline_anchor
		
		text="3"
		font=dialog
		rgba=[100 100 100 50]
		just=[center center]
		pos=(600,-12)
		z_priority=1
	}
	CreateScreenElement {
		type=SpriteElement
		parent=timeline_anchor
		
		texture=black
		rgba=[0 0 0 50]
		just=[center top]
		pos=(600, -16)
		scale=(1,38)
		z_priority=-4
	}
	
    // Get the score value and num rots and anims and update the screen elements
	calculate_cat_score get_values
    
	fill_timeline { 
		get_id=<get_id>
		anim_index=<anim_index>
		rot_index=<rot_index>
		dont_focus_timeline=<dont_focus_timeline>
	}
	
	if GotParam return_val
		return value=<return_val>
	endif
	
endscript

script create_timeline_trick_info item_dims=(150,20)
	FormatText ChecksumName=hud_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	CreateScreenElement{
		type=ContainerElement
		id=timeline_info_anchor
		
		parent=timeline_anchor
        dims=(640,480)
		pos=(320,240)
	}
	anchor_id=timeline_info_anchor
	
	if ( <name> = "" )
		name = "CREATED TRICK"
	endif
	
    // name
	GetUpperCaseString <name>
	CreateScreenElement {
		type=TextElement
		parent=timeline_info_anchor
		id=cat_timeline_name
		
		text=<UpperCaseString>
		font=testtitle
		rgba=[100 100 100 50]
		just=[left top]
		pos=(20,-240)
		z_priority=1
		scale=1.3
	}
	
	// bar
	CreateScreenElement {
		type=SpriteElement
		parent=timeline_info_anchor
		
		texture=cat_bar
		rgba=[50 50 50 100]
		just=[left top]
		scale = (75,1.1)
		pos=(0, -218)
		z_priority=-1
	}
	
    // points
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		text="Points"
		font=small
		rgba=<hud_rgba>
		just=[left top]
		pos=(20, -219)
		alpha=0.8
		z_priority=1
	}
	GetStackedScreenElementPos id=<id> X offset=(5,-1)
    CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		id=cat_timeline_score			
		
		text=""
		font=dialog
		rgba=[100 100 100 50]
		just=[left top]
		pos=<pos>
		z_priority=1
	}
	
	// spin
    CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		text="Spin"
		font=small
		rgba=<hud_rgba>
		just=[left top]
		pos=(180, -219)
		alpha=0.8
		z_priority=1
	}
	GetStackedScreenElementPos id=<id> X offset=(0,0)
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		text="(\mj)"
		font=small
		rgba=<hud_rgba>
		just=[left top]
		pos=<pos>
		alpha=0.8
		z_priority=1
		scale=0.8
	}
	if ( <can_spin> = 1 )
		spin_text="on"
	else
		spin_text="off"
	endif											 
    GetStackedScreenElementPos id=<id> X offset=(5,-1)
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		id=cat_timeline_spin
		
		text=<spin_text>
		font=dialog
		rgba=[100 100 100 50]
		just=[left top]
		pos=<pos>
		z_priority=1
	}
	
    // rotations
    CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		text="Rotations"
		font=small
		rgba=<hud_rgba>
		just=[left top]
		pos=(310, -219)
		alpha=0.8
		z_priority=1
	}
    GetStackedScreenElementPos id=<id> X offset=(5,-1)
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		id=cat_rots_used
		
		text=""
		font=dialog
		rgba=[100 100 100 50]
		just=[left top]
		pos=<pos>
		z_priority=1
	}
	GetStackedScreenElementPos id=cat_rots_used X
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		id=cat_slash_rots
		
		text="/6"
		font=dialog
		rgba=[100 100 100 50]
		just=[left top]
		pos=<pos>
		z_priority=1
	}
	
	// anims
    CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		text="Tricks"
		font=small
		rgba=<hud_rgba>
		just=[left top]
		pos=(470, -219)
		alpha=0.8
		z_priority=1
	}
	GetStackedScreenElementPos id=<id> X offset=(5,-1)
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		id=cat_anims_used			
		
		text=""
		font=dialog
		rgba=[100 100 100 50]
		just=[left top]
		pos=<pos>
		z_priority=1
	}
	GetStackedScreenElementPos id=cat_anims_used X
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		id=cat_slash_anims
		
		text="/6"
		font=dialog
		rgba=[100 100 100 50]
		just=[left top]
		pos=<pos>
		z_priority=1
	}
	
endscript

script create_cat_pause_trick_info item_dims=(150,20) parent=current_menu_anchor
	FormatText ChecksumName=hud_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	CreateScreenElement{
		type=ContainerElement
		id=timeline_info_anchor
		
		parent=<parent>
        dims=(640,480)
		pos=(320,240)
	}
	anchor_id=timeline_info_anchor
	
	if ( <name> = "" )
		name = "CREATED TRICK"
	endif
	
    // name
	GetUpperCaseString <name>
	CreateScreenElement {
		type=TextElement
		parent=timeline_info_anchor
		id=cat_timeline_name
		
		text=<UpperCaseString>
		font=testtitle
		rgba=<hud_rgba>
		alpha=0.8
		just=[left top]
		pos=(40,5)
		z_priority=1
		scale=1.3
	}
	
    // points
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		text="Points"
		font=small
		rgba=<hud_rgba>
		just=[left top]
		pos=(40,25)
		alpha=0.8
		z_priority=1
	}
	GetStackedScreenElementPos id=<id> X offset=(5,-1)
    ;FormatText textname=score_text "%i" i=<points>
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		id=cat_timeline_score			
		
		text="";<score_text>
		font=dialog
		rgba=<hud_rgba>
		alpha=0.8
		just=[left top]
		pos=<pos>
		z_priority=1
	}
	
endscript

script focus_cat_menu
	FireEvent type=unfocus target=timeline_vmenu
	if ScreenElementExists id=createatrick_menu
		FireEvent type=focus target=createatrick_menu
	else
		create_CAT_trick_menu
	endif
endscript

script focus_cat_timeline
    if ScreenElementExists id=createatrick_menu
		FireEvent type=unfocus target=createatrick_menu
	endif
	FireEvent type=focus target=timeline_vmenu
    add_timeline_helper_text
endscript

script create_CAT_timeline_row { 	focus_script=dont_focus_timeline_item
									unfocus_script=null_script
									pad_choose_script=nullscript
								}
	;focus_params = {rotation_info=<rotation_info> animation_info=<animation_info>}
						
	CreateScreenElement {
			type=ContainerElement 
			parent=timeline_vmenu
			id=<row_id>
			
			internal_just=[left top]
            dims=(640, 20)
            event_handlers=[
				{focus              <focus_script> params=<focus_params>}
				{unfocus            <unfocus_script> params=<unfocus_params>}
			]
		}
		
		CreateScreenElement {
			type=SpriteElement
			parent=<row_id>
			
			texture=cat_bar
            rgba=[128 128 128 88]
			just=[left top]
			scale = (75,1.1)
            pos=(0, 0)
			z_priority=-5
		}
endscript

script dont_focus_timeline_item
	GetTags
	FireEvent Target=timeline_vmenu type=pad_up
endscript

script fill_timeline
	;printf "script fill_timeline"
    change timeline_has_no_items=1
	get_CAT_param_values trick_index=0
	
    // Rotations
    GetArraySize <rotation_info>
	
	total=0
	
	index = 0
	begin
		;FormatText textname=rot_name "rot %i" i = ( <index> + 1 )
		get_rot_name axis=(<rotation_info>[<index>].axis) deg_dir=(<rotation_info>[<index>].deg_dir)
		if ( <rotation_info>[<index>].on = 1 )
            make_cat_timeline_item 	{	type=rot
										rot_index=<index>
										text = <rot_name>
										time = ( <rotation_info>[<index>].start )
										duration = ( <rotation_info>[<index>].dur )
										pad_choose_script = CAT_edit_rotation_menu
										pad_choose_params = { rot_index=<index> trick_index=0 }
									}
			total=(<total> + 1)
		endif
		if ( <rotation_info>[<index>].on = 0 )
				make_cat_timeline_item 	{	type=rot
											rot_index=<index>
											off
											text = <rot_name>
											time = ( <rotation_info>[<index>].start )
											duration = ( <rotation_info>[<index>].dur )
											pad_choose_script = CAT_edit_rotation_menu
											pad_choose_params = { rot_index=<index> trick_index=0 }
										}
				total=(<total> + 1)
		endif
		
		if GotParam get_id
			if GotParam rot_index
				if ( <index> = <rot_index> )
					return_val = <total>
				endif
			endif
		endif
		
		index = ( <index> + 1 )
	repeat <array_size>
	
	
	// Animations
	GetArraySize <animation_info>
	
	get_anim_order animation_info=<animation_info> array_size=<array_size>
	
	index = 0
	count = 0
	time_passed = 0
	
    begin
        index = ( <anim_order>[<count>] )
		
        trick=((<animation_info>[<index>]).trick)
		if not IsArray <trick>
			params=( <trick>.params )
		else
			params=( (<trick>[0]).params )
		endif
		anim_name =(<params>.Name)
        
		FormatText checksumname=anim_id "anim%i" i = <index>
		
        trick_got_idle trick=( <animation_info>[<index>].trick )
        
		if ( <got_idle> = 1 )
			duration = ( <animation_info>[<index>].dur + <animation_info>[<index>].idletime )
			idletime=(<animation_info>[<index>].idletime)
			idle_start=( <animation_info>[<index>].dur / 2 )
		else
			duration = ( <animation_info>[<index>].dur )
		endif
        
		if ( <animation_info>[<index>].on = 1 )
            time_passed = ( <time_passed> + (<animation_info>[<index>].start) )
            make_cat_timeline_item 	{	type=anim
										id=<anim_id>
                                        anim_index=<index>
										text = <anim_name>
										time = <time_passed>
										duration = <duration>
										idletime=<idletime>
										idle_start=<idle_start>
										got_idle=<got_idle>
										pad_choose_script = CAT_edit_animation_menu
										pad_choose_params = { anim_index=<index> trick_index=0 }
										trickType=(<animation_info>[<index>].trickType)
									}
            if not ( <animation_info>[<index>].trickType = 4 )	// don't count sounds
				if ( <got_idle> = 1 )
					time_passed = ( <time_passed> + (<animation_info>[<index>].dur) + (<animation_info>[<index>].idletime) )
				else
					time_passed = ( <time_passed> + (<animation_info>[<index>].dur) )
				endif
			else
				time_passed = ( <time_passed> - (<animation_info>[<index>].start) )
			endif
			total=(<total> + 1)
		endif
		if ( <animation_info>[<index>].on = 0 )
				make_cat_timeline_item 	{	type=anim
											id=<anim_id>
											anim_index=<index>
											off
											text = <anim_name>
											time = <time_passed>
											duration = <duration>
											idletime=<idletime>
											idle_start=<idle_start>
											got_idle=<got_idle>
											pad_choose_script = CAT_edit_animation_menu
											pad_choose_params = { anim_index=<index> trick_index=0 }
											trickType=(<animation_info>[<index>].trickType)
										}
				total=(<total> + 1)
		endif
		
		if GotParam get_id
			if GotParam anim_index
				if ( <index> = <anim_index> )
					return_val = <total>
				endif
			endif
		endif
		
		count = ( <count> + 1 )
	repeat <array_size>
	
	// new item box
	make_cat_timeline_item 	{	type=new_item
								id=new_item_box
                                text = "New Rotation or Trick"
								time = 1
								duration = 1.0
								pad_choose_script = timeline_empty_item_focus
								pad_choose_params = { trick_index=0 }
								dont_focus_timeline=<dont_focus_timeline>
							}
	
	
    wait 2 gameframes // must have  <--- that, before next line
	if ScreenElementExists id=timeline_scrolling_menu
		SetScreenElementProps id=timeline_scrolling_menu reset_window_bottom
	endif
    
	if GotParam get_id
		return return_val=<return_val>
	endif
endscript

script get_anim_order
	count=1
	anim_order=[0,0,0,0,0,0]
    
	// Get the order of the anims
	begin
		index=0	
		begin
			if ( ((<animation_info>[<index>]).order) = <count> )
				;printf "count = %c index = %i" c=<count> i=<index>
				SetArrayElement ArrayName=anim_order index=(<count>-1) newvalue=<index>
				// This is what the line above does
				;anim_order[(<count>-1)] = <index>
				break
			endif
            index = ( <index> + 1 )
		repeat <array_size>
		count = ( <count> + 1 )
	repeat <array_size>
	
	return anim_order=<anim_order>
endscript

timeline_has_no_items=1

script make_cat_timeline_item text="text" time=0 duration=1
    
    row_num = 0
	change timeline_has_no_items=0
    
	begin
		FormatText checksumname=row_id "timeline_row%r" r=<row_num>
		if ScreenElementExists id={<row_id> child=1}
			row_num = ( <row_num> + 1 )
			if ( <row_num> > 12 )
				return
			endif
		else
			parent = <row_id>
			break
		endif
	repeat
	
	switch <type>
	case rot
		pad_right_script = slide_cat_rot_start_value
		pad_r1_script = null_script
		toggle_script = toggle_rot_on_off
		if not GotParam off
			sprite_rgba = rot_on_un
			idle_rgba = idle_on_un
		else
			sprite_rgba = rot_off_un
			idle_rgba = idle_off_un
		endif
	case anim
		pad_right_script = slide_cat_anim_start_value
		if ( <trickType> = 4 )
			pad_r1_script = null_script	// no order changing for sounds
		else
			pad_r1_script = increment_cat_animation_order_value
		endif
		toggle_script = toggle_anim_on_off
		if not GotParam off
            switch <trickType>
				case 0
					sprite_rgba = flip_on_un
				case 1
					sprite_rgba = grab_on_un
				case 2
					sprite_rgba = spec_on_un
				case 3
					sprite_rgba = misc_on_un
				case 4
					sprite_rgba = gen_on_un
			endswitch
            idle_rgba = idle_on_un
		else
            switch <trickType>
				case 0
					sprite_rgba = flip_off_un
				case 1
					sprite_rgba = grab_off_un
				case 2
					sprite_rgba = spec_off_un
				case 3
					sprite_rgba = misc_off_un
				case 4
					sprite_rgba = gen_off_un
			endswitch
			idle_rgba = idle_off_un
		endif
	case new_item
		// start demo loop
		if not GotParam dont_focus_timeline
			spawnscript spawn_cat_demo_loop
		endif
		
		pad_right_script = null_script
		pad_r1_script = null_script
		toggle_script = null_script
        sprite_rgba = new_item_un
	endswitch
	
	pos = ( (<time> * (200,0)) + (0,2) )
	
	CreateScreenElement {
	   type=ContainerElement 
	   parent=<parent>
	   id=<id>
       
	   just=[left top]
	   internal_just=[left top]
       dims=(100, 20)
	   pos=<pos>
	}
	
	anchor_id = <id>
	
    if not GotParam off
		SetScreenElementProps { id=<parent>
								event_handlers=[ { pad_choose cat_play_choose_sound params={ pad_choose_script=<pad_choose_script> <pad_choose_params> timeline_id=<anchor_id> } } 
												 // pad_zac is the same as pad_choose except it doesn't play a sound
												 { pad_zac 	<pad_choose_script> params={ <pad_choose_params> timeline_id=<anchor_id> } }
												 { pad_space cat_play_hide_sound params={ callback=<toggle_script> rot_index=<rot_index> anim_index=<anim_index> } }
												 { pad_backspace cat_play_delete_sound params={ callback=<toggle_script> Delete rot_index=<rot_index> anim_index=<anim_index> } } 
												 { pad_right  <pad_right_script> params={ rot_index=<rot_index> anim_index=<anim_index> } }
												 { pad_left   <pad_right_script> params={ rot_index=<rot_index> anim_index=<anim_index> reverse } }
												 { pad_r1  	  <pad_r1_script> params={ anim_index=<anim_index> } }
												 { pad_l1     <pad_r1_script> params={ anim_index=<anim_index> reverse } }
                                                 { focus      timeline_item_focus params={ type=<type> trickType=<trickType> rot_index=<rot_index> anim_index=<anim_index> } }
												 { unfocus    timeline_item_unfocus params={ type=<type> trickType=<trickType> } }
											   ] 
								replace_handlers
							  }
	
		text_rgba = [60 60 60 100]
	else
        SetScreenElementProps { id=<parent>
								event_handlers=[ ;{ pad_choose <pad_choose_script> params=<pad_choose_params> timeline_id=<anchor_id> } 
												 { pad_choose null_script } 
												 { pad_space cat_play_hide_sound params={ callback=<toggle_script> rot_index=<rot_index> anim_index=<anim_index> } }
												 { pad_backspace cat_play_delete_sound params={ callback=<toggle_script> Delete rot_index=<rot_index> anim_index=<anim_index> } }  
												 { pad_right  null_script params={ } }
												 { pad_left   null_script params={ reverse } }
                                                 { focus      timeline_item_focus   params={ type=<type> off trickType=<trickType> rot_index=<rot_index> anim_index=<anim_index> } }
												 { unfocus    timeline_item_unfocus params={ type=<type> off trickType=<trickType> } }
											   ] 
								replace_handlers
							  }
							  
		text_rgba = [60 60 60 100]
	endif
	
	scale = ( (<duration> * (12.5,0)) + (0,1) )
    
	// box
	CreateScreenElement {
	   type=SpriteElement
	   parent=<anchor_id>
	   
	   texture=cat_box
	   rgba=<sprite_rgba>
	   just=[left top]
	   scale = <scale>
       pos=(0, 0)
	   z_priority=1
	}
	bar_id=<id>
	
	//text
	if ( <type> = new_item )
		text_pos=(5,-2)
	else
		text_pos=(14,-2)
	endif
	CreateScreenElement {
			type=TextElement
			parent=<anchor_id>
            
			pos=<text_pos>
			font=dialog
			text=<text>
			just=[left top]
			scale=0.8
            rgba=<text_rgba>
			z_priority=3
	}
	text_id = <id>
    
	// truncate text
    if not ( <type> = new_item )
		max_width=( ( <duration> - 0.1 ) * 160 )
		truncate_string id=<text_id> max_width=<max_width>
	endif
	
	//arrows
	CreateScreenElement {
	   type=SpriteElement
	   parent=<anchor_id>
	   
	   texture=left_arrow
	   rgba=[0 0 0 0]
	   just=[left top]
	   scale = (0.75,0.5)
       pos=(0, 0)
	   z_priority=3
	}
	
	GetStackedScreenElementPos X id=<bar_id>
	CreateScreenElement {
	   type=SpriteElement
	   parent=<anchor_id>
	   
	   texture=right_arrow
	   rgba=[0 0 0 0]
	   just=[left top]
	   scale = (0.75,0.5)
       pos=(<pos> + (-12,0))
	   z_priority=3
	}
	
    //idletime box
	if ( <type> = anim )
		
		scale2=(0,0)
		pos=(0,0)
		
		if ( <got_idle> = 1 )
			if GotParam idle_start
				scale2 = ( (<idletime> * (12.5,0)) + (0,1) )
				pos= ( <idle_start> * (200,0) + (0,0) )
            endif
		endif
		
		CreateScreenElement {
		   type=SpriteElement
		   parent=<anchor_id>
		   
		   texture=cat_box
		   rgba=<idle_rgba>
		   just=[left top]
		   scale = <scale2>
		   pos=<pos>
		   z_priority=2
		}
	endif
	
	// create hidden text to retain values that are truncated
	CreateScreenElement {
			type=TextElement
			parent=<text_id>
            
            font=dialog
			text=<text>
            alpha=0
			scale=0
	}
    
endscript

script cat_play_choose_sound
	generic_menu_pad_choose_sound
	if GotParam pad_choose_script
		if not ( <pad_choose_script> = null_script )
			<pad_choose_script> <...>
		endif
	endif
endscript

script cat_play_hide_sound
	;PlaySound copinghit3_11 pitch=60
	if GotParam callback
		if not ( <callback> = null_script )
			<callback> <...>
		endif
	endif
endscript

script cat_play_delete_sound
    PlaySound GUI_buzzer01 pitch=60
    if GotParam callback
		if not ( <callback> = null_script )
			<callback> <...>
		endif
	endif
endscript

////////////////////////////////////////////////////////
// timeline focus scripts
////////////////////////////////////////////////////////

script timeline_item_focus
    GetTags
	
    if GotParam type
		switch <type>
		case rot
			if not GotParam off
				sprite_rgba = rot_on_high
				arrow_rgba = timeline_arrow_high
			else		   
				sprite_rgba = rot_off_high
				arrow_rgba=[0 0 0 0]
			endif
		case anim
			if not GotParam off
                switch <trickType>
					case 0
						sprite_rgba = flip_on_high
					case 1
						sprite_rgba = grab_on_high
					case 2
						sprite_rgba = spec_on_high
					case 3
						sprite_rgba = misc_on_high
					case 4
						sprite_rgba = gen_on_high
				endswitch
				arrow_rgba = timeline_arrow_high
			else
                switch <trickType>
					case 0
						sprite_rgba = flip_off_high
					case 1
						sprite_rgba = grab_off_high
					case 2
						sprite_rgba = spec_off_high
					case 3
						sprite_rgba = misc_off_high
					case 4
						sprite_rgba = gen_off_high
				endswitch
				arrow_rgba=[0 0 0 0]
			endif
		case new_item
			sprite_rgba = new_item_high
			arrow_rgba=[0 0 0 0]
		endswitch
		
		text_rgba = [100 100 100 100]
	endif
	
    if ScreenElementExists id={ <id> child={ 1 child=0 } }
        //bg
		DoScreenElementMorph time=0 id={ <id> child={ 1 child=0 } } rgba=<sprite_rgba>
		RunScriptOnScreenElement id={ <id> child={ 1 child=0 } } timeline_bar_focus_effect
		//text
		DoScreenElementMorph time=0 id={ <id> child={ 1 child=1 } } rgba=<text_rgba>
        RunScriptOnScreenElement id={ <id> child={ 1 child=1 } } text_twitch_effect2
		//arrows
		DoScreenElementMorph time=0 id={ <id> child={ 1 child=2 } } rgba=<arrow_rgba>
		DoScreenElementMorph time=0 id={ <id> child={ 1 child=3 } } rgba=<arrow_rgba>
	endif
endscript

script timeline_bar_focus_effect scale=(1,0.25) scale2=(1,1)
	GetTags
    wait 1 gameframe
	begin
        DoScreenElementMorph id=<id> time=0.3 alpha=0.5
        wait 0.5 seconds
		DoScreenElementMorph id=<id> time=0.3 alpha=1
        wait 0.5 seconds
	repeat
endscript

script timeline_item_unfocus
	GetTags
    KillSpawnedScript name=text_twitch_effect2
	KillSpawnedScript name=timeline_bar_focus_effect
	
	if GotParam type
		switch <type>
		case rot 
			pad_right_script = slide_cat_rot_start_value
			if not GotParam off
				sprite_rgba = rot_on_un
			else
				sprite_rgba = rot_off_un
			endif
		case anim
			pad_right_script = slide_cat_anim_start_value
			if not GotParam off
				switch <trickType>
					case 0
						sprite_rgba = flip_on_un
					case 1
						sprite_rgba = grab_on_un
					case 2
						sprite_rgba = spec_on_un
					case 3
						sprite_rgba = misc_on_un
					case 4
						sprite_rgba = gen_on_un
				endswitch
			else
				switch <trickType>
					case 0
						sprite_rgba = flip_off_un
					case 1
						sprite_rgba = grab_off_un
					case 2
						sprite_rgba = spec_off_un
					case 3
						sprite_rgba = misc_off_un
					case 4
						sprite_rgba = gen_off_un
				endswitch
			endif
		case new_item
			sprite_rgba = new_item_un
		endswitch
		
        text_rgba = [60 60 60 100]
	endif
	
    if ScreenElementExists id={ <id> child={ 1 child=0 } }
		//bg
		DoScreenElementMorph time=0 id={ <id> child={ 1 child=0 } } rgba=<sprite_rgba>
		//text
		DoScreenElementMorph time=0 id={ <id> child={ 1 child=1 } } rgba=<text_rgba>
		//arrows
		DoScreenElementMorph time=0 id={ <id> child={ 1 child=2 } } rgba=[0 0 0 0]
		DoScreenElementMorph time=0 id={ <id> child={ 1 child=3 } } rgba=[0 0 0 0]
	endif
endscript

script show_rot_highlight_info rot_index=0
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	;get_CAT_param_values skater=0 trick_index=0
	;grab_all_rot_values { rotation_info=<rotation_info> rot_index=<rot_index> }
	get_CAT_rot_values skater=0 trick_index=0 rot_index=<rot_index>
	
    ;FormatText textname=menu_title "ROT %i" i=( <rot_index> + 1 )
	get_rot_name axis=(<rotation_info>[<rot_index>].axis) deg_dir=(<rotation_info>[<rot_index>].deg_dir)
	GetUpperCaseString <rot_name>
	menu_title=<UpperCaseString>
	
	SetScreenElementProps id= { cat_menu_anchor child={ 0 child=1 } } text=<menu_title>
	GetStackedScreenElementPos X id= { cat_menu_anchor child={ 0 child=1 } }
	SetScreenElementProps id= { cat_menu_anchor child={ 0 child=2 } } pos=( <pos> + (-10,20) )
	
	make_new_menu {
		parent=cat_menu_anchor
		menu_id=rot_info_menu
		vmenu_id=rot_info_vmenu
		menu_title=""
		type=VMenu
		dims=(200, 200)
		pos=(115,80)
	}
	
    switch <axis>
		case x
			axis_text="Flip"
			if ( <deg_dir> = 0 )
				dir_text = "Front"
			else
				dir_text = "Back"
			endif
		case y
			axis_text="Spin"
			if ( <deg_dir> = 0 )
				dir_text = "Backside"
			else
				dir_text = "Frontside"
			endif
		case z
			axis_text="Roll"
			if ( <deg_dir> = 0 )
				dir_text = "Heel Side"
			else
				dir_text = "Toe Side"
			endif
	endswitch
	
	if ( <on> = 0 )
		<not_focusable>=not_focusable
	endif
	
	;FormatText textname=axis_text "%i" i=<axis>
	FormatText textname=deg_text "%i" i=<deg>
	theme_menu_add_item text=<dir_text>	extra_text=<axis_text> id=menu_axis middle_scale=(2,1) <not_focusable>
	;theme_menu_add_item text="direction" extra_text=<dir_text> id=menu_dir middle_scale=(2,1)
	theme_menu_add_item text="degrees" extra_text=<deg_text> id=menu_deg last_menu_item=1 static_width=1 middle_scale=(2,1) <not_focusable>

    	
endscript

script show_no_highlight_info
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
    SetScreenElementProps id= { cat_menu_anchor child={ 0 child=1 } } text="NEW?"
	GetStackedScreenElementPos X id= { cat_menu_anchor child={ 0 child=1 } }
	SetScreenElementProps id= { cat_menu_anchor child={ 0 child=2 } } pos=( <pos> + (-10,20) )
endscript

// triggers new anim or rot dialog box
script timeline_empty_item_focus back_script=cancel_new_anim_or_rot
	GetTags
	;focus_id=<id>
    
	if ( timeline_has_no_items=0 )
		;FireEvent target=timeline_vmenu type=pad_up
	else
		back_script=cancel_first_anim_or_rot
	endif
	FireEvent type=unfocus target=timeline_vmenu
	create_dialog_box { title="New"
						text="Add a new rotation or trick?"
						forced_pos=(320 ,75)
						just=[center center]
						text_rgba=[88 105 112 128]
						;text_dims=(320,0)
						
						
						pad_back_script = <back_script>
						buttons=[   { font=small text="Go Back" pad_choose_script=<back_script> }
                                    { font=small text="Rotation" pad_choose_script=cat_add_another_rot }
									{ font=small text="Grab" pad_choose_script=cat_add_another_anim pad_choose_params={ type=grab } }
									{ font=small text="Fliptrick" pad_choose_script=cat_add_another_anim pad_choose_params={ type=fliptrick } }
									{ font=small text="Special" pad_choose_script=cat_add_another_anim pad_choose_params={ type=special } }
									{ font=small text="Other" pad_choose_script=cat_add_another_anim pad_choose_params={ type=misc } }
									{ font=small text="Sound" pad_choose_script=cat_add_another_anim pad_choose_params={ type=generic } }
							    ]
						;delay_input
					  }
endscript

script cancel_new_anim_or_rot
	dialog_box_exit
	add_timeline_helper_text
	FireEvent type=focus target=timeline_vmenu
	kill_start_key_binding
endscript

script cancel_first_anim_or_rot
	dialog_box_exit
	;FireEvent type=focus target=createatrick_menu
	cat_menu_exit
endscript

////////////////////////////////////////////////
// Timeline dynamic updates
///////////////////////////////////////////////

script cat_add_another_anim
    dialog_box_exit
	
	// is there any room on the timeline for another anim?
	calculate_cat_score get_time anims_only
    if not ( 2.5 > <time> )
		create_dialog_box { title="Oops!"
						text="You don't have any room for another animation!"
						pos=(310 ,183)
						just=[center center]
						text_rgba=[88 105 112 128]
						;text_dims=(320,0)
						
                        buttons=[ { font=small text="Ok" pad_choose_script=cancel_new_anim_or_rot }
							    ]
						;delay_input
					  }
		return
	endif
	
	//find an unused anim
	find_unused_anim
	
    // have they reached the sound limit
	if ( ( <type> = generic ) && ( <num_sounds> > 2 ) )
		create_dialog_box { title="Oops!"
							text="You can only have 3 sounds."
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
                            
							buttons=[ { font=small text="Ok" pad_choose_script=cancel_new_anim_or_rot }
									]
						  }
	else
		if GotParam anim_index
			//turn it on and zero out other values
			toggle_anim_on_off anim_index=<anim_index> type=<type>
		else
			create_dialog_box { title="Oops!"
							text="You don't have any empty animation slots!"
							pos=(310 ,183)
							just=[center center]
							text_rgba=[88 105 112 128]
							;text_dims=(320,0)
							
							buttons=[ { font=small text="Ok" pad_choose_script=cancel_new_anim_or_rot }
									]
							;delay_input
						  }
		endif
	endif
endscript

script cat_add_another_rot
	printf "script cat_add_another_rot"
	dialog_box_exit
	//find an unused rot
	find_unused_rot
	
    if GotParam rot_index
		//turn it on and zero out other values
		toggle_rot_on_off rot_index=<rot_index>
		;spawnscript spawn_cat_demo_loop
	else
		create_dialog_box { title="Oops!"
						text="You don't have any empty rotation slots!"
						pos=(310 ,183)
						just=[center center]
						text_rgba=[88 105 112 128]
						;text_dims=(320,0)
						
						
						;pad_back_script = <back_script>
						buttons=[ { font=small text="Ok" pad_choose_script=cancel_new_anim_or_rot }
							    ]
						;delay_input
					  }
	endif
endscript

script slide_cat_rot_start_value
    PlaySound DE_MenuSelect vol=100
	GetTags
	
	;get_CAT_param_values skater=0 trick_index=0
    ;grab_all_rot_values { rotation_info=<rotation_info> rot_index=<rot_index> }
	get_CAT_rot_values skater=0 trick_index=0 rot_index=<rot_index>
	
    if GotParam reverse
		if not ( 0 > ( <start> - 0.1 ) )
			start = ( <start> - 0.1 )
		else
			start = 0
		endif
	else
		if not ( ( <start> + <dur> + 0.1 ) > 3.0 )
			start = ( <start> + 0.1 )
		endif
	endif
	
    //Update item position
	pos = ( (<start> * (200,0)) + (0,2) )
    DoScreenElementMorph time=0.1 id={ <id> child=1 } pos=<pos>
	
    set_new_rot_values { rot_index=<rot_index> on=<on> deg=<deg> axis=<axis> dur=<dur> start=<start> deg_dir=<deg_dir> }
	
	calculate_cat_score get_values
endscript

script slide_cat_anim_start_value
	if GotParam reverse
		PlaySound menu03 vol=90 pitch=90
	else
		PlaySound menu03 vol=80 pitch=120
	endif
    GetTags
	
	;get_CAT_param_values skater=0 trick_index=0
    ;grab_all_anim_values { animation_info=<animation_info> anim_index=<anim_index> }
	get_CAT_anim_values skater=0 trick_index=0 anim_index=<anim_index>
	
	if GotParam reverse
		if not ( 0 > ( <start> - 0.1 ) )
			start = ( <start> - 0.1 )
		else
			start = 0
		endif
	else
		calculate_cat_score get_time
        if ( 2.9 > <time> )
			trick_got_idle trick=<trick>
			
			if ( <got_idle> = 1 )
				if not ( ( <start> + <dur> + <idletime> + 0.1 ) > 3.0 )
					start = ( <start> + 0.1 )
				endif
			else
				if not ( ( <start> + <dur> + 0.1 ) > 3.0 )
					start = ( <start> + 0.1 )
				endif
			endif
		endif
	endif
	
    quick_set_anim_values <...>
	
	update_all_anim_positions ;changed_anim=<anim_index>
	calculate_cat_score get_values
endscript

script update_all_anim_positions
	printf "update_all_anim_positions"

	GetCreateATrickAnimations {	skater=0 trick_index=0 }
	
	//Update item position
	GetArraySize <animation_info>
	
	get_anim_order animation_info=<animation_info> array_size=<array_size>
    
    index = 0
	count = 0
	time_passed = 0
	
    begin
		printf "count = %c" c=<count>
        index = ( <anim_order>[<count>] )
        trick=((<animation_info>[<index>]).trick)
		if not IsArray <trick>
			params=( <trick>.params )
		else
			params=( (<trick>[0]).params )
		endif
		anim_name =(<params>.Name)
		
		FormatText checksumname=anim_id "anim%i" i = <index>
		
		// anim is on
		if ( <animation_info>[<index>].on = 1 )
            time_passed = ( <time_passed> + (<animation_info>[<index>].start) )
            
            pos = ( (<time_passed> * (200,0)) + (0,2) )
			if ScreenElementExists id=<anim_id>
				DoScreenElementMorph time=0 id=<anim_id> pos=<pos>
			else
				printf "can't move %i cause it doesn't exist!" i=<anim_id>
			endif
			
			trick_got_idle trick=<trick>
			
			if not ( ((<animation_info>[<index>]).trickType) = 4 ) // don't count sounds
				if ( <got_idle> = 1 )
					time_passed = ( <time_passed> + (<animation_info>[<index>].dur) + (<animation_info>[<index>].idletime) )
				else
					time_passed = ( <time_passed> + (<animation_info>[<index>].dur) )
				endif
			else
				time_passed = ( <time_passed> - (<animation_info>[<index>].start) )
			endif
			
			if ( <time_passed> > 3.0 )
				diff = ( <time_passed> - 3.0 )
                get_CAT_anim_values skater=0 trick_index=0 anim_index=<index>
				// start
				if ( <diff> > 0 )
					if ( <start> > 0 )
						if ( <start> > <diff> )
							time_passed = ( <time_passed> - <diff> )
							start = ( <start> - <diff> )
							diff = 0
						else
							time_passed = ( <time_passed> - <start> )
							diff = ( <diff> - <start> )
							start = 0
						endif
					endif
				endif
				//idle
				if ( <got_idle> = 1 )
					if ( <diff> > 0 )
						if ( <idle> > 0 )
							if ( <idle> > <diff> )
								time_passed = ( <time_passed> - <diff> )
								idle = ( <idle> - <diff> )
								diff = 0
							else
								time_passed = ( <time_passed> - <idle> )
								diff = ( <diff> - <idle> )
								idle = 0
							endif
						endif
					endif
				endif
				// dur
				if ( <diff> > 0 )
					if ( <dur> > 0.1 )
						if ( (<dur> - 0.1) > <diff> )
							time_passed = ( <time_passed> - <diff> )
							dur = ( <dur> - <diff> )
							diff = 0
						else
							// can't chop this anim anymore... try again on the next one.
                        endif
					endif
				endif
				set_new_anim_values { anim_index=<index> on=<on> trick=<trick> anim=<anim> dur=<dur> percent=<percent> blend=<blend> from=<from> trickType=<trickType> idletime=<idletime> start=<start> order=<order> hold=<hold> backwards=<backwards> }
			endif
		endif
		
		// anim is hidden
		if ( <animation_info>[<index>].on = 0 )
            // this anim is hidden
			if ( <time_passed> > 3 )
				printf "CAT: Does this ever happen????????????????????????????????????????????????????????????????????"
				ScriptAssert "Go tell Zac you got this message in CAT and tell him exactly what you were doing and what items were in your created trick."
				return
                /*get_CAT_anim_values skater=0 trick_index=0 anim_index=<index>
				if not ( 0 > ( <start> - 0.1 ) )
					start = ( <start> - 0.1 )
					set_new_anim_values { anim_index=<index> on=<on> trick=<trick> anim=<anim> dur=<dur> percent=<percent> blend=<blend> from=<from> trickType=<trickType> idletime=<idletime> start=<start> order=<order> hold=<hold> backwards=<backwards> }
					update_all_anim_positions rebuild_it
					return
				endif
				if not ( 0 > ( <dur> - 0.1 ) )
					dur = ( <dur> - 0.1 )
					set_new_anim_values { anim_index=<index> on=<on> trick=<trick> anim=<anim> dur=<dur> percent=<percent> blend=<blend> from=<from> trickType=<trickType> idletime=<idletime> start=<start> order=<order> hold=<hold> backwards=<backwards> }
					update_all_anim_positions rebuild_it
					return
				endif*/
			endif
		endif
		count = ( <count> + 1 )
	repeat <array_size>
	
	// rebuild menu if this script was called repeatedly
	if GotParam rebuild_it
		create_cat_timeline
	endif
	
endscript

script update_scale_to_new_duration
	printf "script update_scale_to_new_duration"
    
    scale = ( (<duration> * (12.5,0)) + (0,1) )
	
	if GotParam idle_start
		scale2 = ( (<idletime> * (12.5,0)) + (0,1) )
		ipos= ( <idle_start> * (200,0) + (0,1) )
	else
		scale2=(0,0)
		ipos=(0,0)
	endif
	
	// bar
	DoScreenElementMorph id={ <id> child=0 } scale=<scale>
	// arrow
	GetStackedScreenElementPos X id={ <id> child=0 }
    DoScreenElementMorph id={ <id> child=3 } pos=(<pos> + (-12,0))
	
	// idletime box
	if ScreenElementExists id={ <id> child=4 } 
		DoScreenElementMorph id={ <id> child=4 } pos=<ipos> scale=<scale2>
	endif
	
    // restore text
	GetTextElementString id={ <id> child={ 1 child=0 } }
	SetScreenElementProps id={ <id> child=1 } text=<string>
	
	// truncate text
	max_width=( ( <duration> - 0.1 ) * 160 )
	truncate_string id={ <id> child=1 } max_width=<max_width>
endscript

/*// Not being used right now... maybe delete later
script calculate_time_before_anim
    //total_time = ( <start> + dur and start of all preceeding anims )
    get_CAT_param_values skater=0 trick_index=0
	
	total_time = <start>
    GetArraySize <animation_info>
	index = 0
    begin
		if ( <this_order> > ((<animation_info>[<index>]).order) )
			if ( ((<animation_info>[<index>]).on) = 1 )
				total_time = ( <total_time> + ((<animation_info>[<index>]).start) + ((<animation_info>[<index>]).dur) )
			endif
		endif
		index = ( <index> + 1 )
	repeat <array_size>
    
    return total_time=<total_time>
endscript
*/
script find_unused_anim
	get_CAT_param_values skater=0 trick_index=0
	
	got_it=0
	num_sounds=0
	
	GetArraySize <animation_info>
	index = 0
    begin
		if ( <got_it> = 0 )
			if ( ((<animation_info>[<index>]).on) = 2 )
				anim_index=<index>
				got_it=1
			endif
		endif
		
		// is this a sound?
		if ( ((<animation_info>[<index>]).trickType) = 4 )
			// is this slot being used?
			if not ( ((<animation_info>[<index>]).on) = 2 )
				num_sounds = ( <num_sounds> + 1 )
			endif
		endif
		
		index = ( <index> + 1 )
	repeat <array_size>
    
	return { anim_index=<anim_index> num_sounds=<num_sounds> }
endscript

script find_unused_rot
	;get_CAT_param_values skater=0 trick_index=0
	GetCreateATrickRotations skater=0 trick_index=0
	
	GetArraySize <rotation_info>
	index = 0
    begin
		if ( ((<rotation_info>[<index>]).on) = 2 )
			return rot_index=<index>
		endif
		index = ( <index> + 1 )
	repeat <array_size>
    
endscript

script back_to_timeline
	;create_CAT_menu
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	focus_cat_timeline
endscript

script show_ingame_timeline
	create_cat_timeline trick=<trick> parent=root_window
endscript

// @script | calculate_cat_score | calculates the tricks score
script calculate_cat_score minus=99
    
	if ( (GotParam get_values) || (GotParam get_time) )
	   get_CAT_param_values trick_index=0 
	endif
	
	bailtime=0
	animtime=0
	
	num_rots=0
	num_anims=0
	
    if not GotParam anims_only
		// figuring when the last rotation will finish
		GetArraySize <rotation_info>
		index=0
		begin
            if ( ((<rotation_info>[<index>]).on) = 1 )
				Dur=((<rotation_info>[<index>]).Dur)
				start=((<rotation_info>[<index>]).start)
			
				if ( (<Dur> + <Start>) > <bailtime> )
					bailtime = (<Dur> + <Start>)
				endif
			endif
			if not ( ((<rotation_info>[<index>]).on) = 2 )
				num_rots=(<num_rots> + 1)
			endif
            index = ( <index> + 1 )
		repeat <array_size>
	else
		if not GotParam no_hidden
			include_hidden=include_hidden
		endif
	endif
	
	// calculate time to perform all anims that are on
    GetArraySize <animation_info>
    index=0
	begin
		if not ( <index> = <minus> )	// don't count the minus anim ( used for getting time for a trick minus a certain anim )
			if not ( ((<animation_info>[<index>]).trickType) = 4 )	// don't count sounds
				trick_got_idle trick=((<animation_info>[<index>]).trick)
				
				if ( ((<animation_info>[<index>]).on) = 1 )
					if ( <got_idle> = 1 )
						animtime = ( <animtime> + ((<animation_info>[<index>]).dur) + ((<animation_info>[<index>]).idletime) + ((<animation_info>[<index>]).start) )
					else
						animtime = ( <animtime> + ((<animation_info>[<index>]).dur) + ((<animation_info>[<index>]).start) )
					endif
				endif
				if GotParam include_hidden
					if ( ((<animation_info>[<index>]).on) = 0 )
						if ( <got_idle> = 1 )
							animtime = ( <animtime> + ((<animation_info>[<index>]).dur) + ((<animation_info>[<index>]).idletime) + ((<animation_info>[<index>]).start) )
						else
							animtime = ( <animtime> + ((<animation_info>[<index>]).dur) + ((<animation_info>[<index>]).start) )
						endif
					endif
				endif
				if not ( ((<animation_info>[<index>]).on) = 2 )
					num_anims=(<num_anims> + 1)
				endif
			endif
		endif
		index = ( <index> + 1 )
	repeat <array_size>
	
	// Calculate time to perform trick
	if ( <animtime> > <bailtime> )
		bailtime = <animtime>
	endif
	
	if not GotParam get_time
		cat_get_score_from_bailtime bailtime=<bailtime> can_spin=<can_spin>
		
        FormatText textname=score_text "%i" i=<score>
		if ScreenElementExists id=cat_timeline_score
			SetScreenElementProps id=cat_timeline_score text=<score_text>
		endif
        
		if ScreenElementExists id=cat_rots_used
			FormatText textname=rot_text "%i" i=<num_rots>
			SetScreenElementProps id=cat_rots_used text=<rot_text>
			GetStackedScreenElementPos id=cat_rots_used X
			SetScreenElementProps id=cat_slash_rots pos=<pos>
		endif
		
		if ScreenElementExists id=cat_anims_used
			FormatText textname=anim_text "%i" i=<num_anims>
			SetScreenElementProps id=cat_anims_used text=<anim_text>
			GetStackedScreenElementPos id=cat_anims_used X
			SetScreenElementProps id=cat_slash_anims pos=<pos>
		endif
		
		if ( <can_spin> = 1 )
			spin_text="on"
		else
			spin_text="off"
		endif
		
		if ScreenElementExists id=cat_timeline_spin
			SetScreenElementProps id=cat_timeline_spin text=<spin_text>
		endif
		
		if GotParam return_it
			return { score=<score> score_text=<score_text> }
		endif
	else
		return time=<bailtime>
	endif
endscript

script cat_get_score_from_bailtime
	// Calculating the score based on how long it takes
	if ( <bailtime> > 1.5 )
		score = ( (1333*(<bailtime>-1.5)) + 6000 )
	else
		if ( <bailtime> > 0.4 )
			score = ( (5880*(<bailtime>-0.5)*(<bailtime>-0.5)) + 120 )
		else
			if ( <bailtime> > 0.3 )
				score=100
			else
				score=0
			endif
		endif
	endif
	
	if ( ( 0 > <score> ) || ( <score> = 0 ) )
		score=0
	else
		// Score changes if the trick is spinable
		if ( <can_spin> = 1 )
			if ( <bailtime> > 1.5 )
				score = ( <score> / 4 )
			else
				if ( <bailtime> > 0.4 )
					score = ( <score> / ( 2.5*(<bailtime>-0.5) + 1.5 ) )
				else
					score=70
				endif
			endif
		endif
		CastToInteger score
		
		// make sure score is a multiple of 10
		mod = (<score> - (<score>/10)*10)
		if not ( <mod> = 0 )
			score = ( <score> + ( 10 - <mod> ) )
		endif
	endif
	
	// make sure scores are never over max
	if ( <score> > 8000 )
		score = 8000
	endif
	
	return score=<score>
endscript

// @script | cat_landable | checks x and z rotations to make sure skater is upright at end of trick
script cat_landable
    get_CAT_param_values trick_index=0 
	
	upsidedown=0
    
    GetArraySize <rotation_info>
	index=0
	begin
		// trick must be on!
		if ( ((<rotation_info>[<index>]).on) = 1 )
            // only check X and Z rotations
			if not ( ((<rotation_info>[<index>]).axis) = y )
                // get the angle
				degrees = ((<rotation_info>[<index>]).deg)
				// break it down to 180 or 360
				begin
					if ( <degrees> > 360 )
						degrees = ( <degrees> - 360 )
					else
						break
					endif
				repeat
				// toggle upsidedown
				if ( <degrees> = 180 )
					if ( <upsidedown> = 1 )
						upsidedown=0
					else
						upsidedown=1
					endif
				endif
			endif
		endif
        index = ( <index> + 1 )
	repeat <array_size>
    
	return upsidedown=<upsidedown>
endscript

skater_board_was_hidden = 0

script show_CAT_skater
    printf "script show_CAT_skater"
	
	if not ObjectExists id=CAT_Skater
		// make sure board is on when we copy the skater
        skater:AtomicIsHidden board
		if ( <hidden> = 1 )
			printf "skaters board was hidden"
			skater:SwitchOnAtomic Board
			change skater_board_was_hidden=1
		endif
        
		// create dummy skater object
        CreateCompositeObject {
			Components=
			 [
				 {component = motion}
				 
				 {component = Suspend NeverSuspend}
		
				 {component = skeleton
				  SkeletonName = THPS5_human
				  
				  // don't LOD the bones
				  max_bone_skip_lod = 0
				 }
		
				 {component = model
				  refObjectName = skater
				 }
		
				 {component = Animation
				  AnimName = animload_THPS5_human
				 }
				 
				 {component = SpecialItem}
				 
				 {component = SkaterFlipAndRotate}
			 ]
			Params={Name=CAT_Skater}
		}
		;CAT_Skater:Obj_InitModelFromProfile { struct=appearance_hawk use_asset_manager=0 texDictOffset=8 }
        
		;CAT_Skater:Obj_SetPosition Position=(0,-500,0)
		if LevelIs load_sj
			CAT_Skater:Move y=-1750
		else
			CAT_Skater:Move y=-750
		endif
        
	endif
	
	if not ObjectExists id=CAT_Cam
		// create camera
		CreateCompositeObject {
			 Components=
			 [
				 {component=camera}
			 ]
			 Params={Name=CAT_Cam}
		}
	endif
	CAT_Skater:Obj_GetPosition
	CAT_Cam:Obj_SetPosition Position=( <pos> + (150,5,50) )
	CAT_Cam:Obj_SetOrientation Y=90
    
    wait 1 gameframes
	SetActiveCamera id=CAT_Cam
	CAT_Skater:Obj_PlayAnim Anim=AirIdle playhold speed=0

    /*
	GetCurrentSkaterProfileIndex
	
	if ( ((master_skater_list[<currentSkaterProfileIndex>]).stance) = goofy )
		pos_off=(150,0,0)
	else
		pos_off=(-150,0,0)
	endif
	*/
	
    // bg
	make_mainmenu_3d_plane model="cat_bg\cat_bg.mdl" z_priority=-200 scale=(0.7,1.1) pos=(320,225) parent=cat_menu_anchor
	
	if ScreenElementExists id=timeline_vmenu
		if not GotParam dont_focus_timeline
			FireEvent type=focus target=timeline_vmenu
		endif
	endif
endscript

script cat_back_to_skater_cam
	
	// switch back to skater camera
	Restore_skater_camera
	
endscript

script cat_rehide_skater_board
	// turn skaters board back off if needed
	if ( skater_board_was_hidden = 1 )
		skater:SwitchOffAtomic Board
		change skater_board_was_hidden=0
	endif
endscript

running_cat_demo=0

script spawn_cat_demo_loop
	;printf "spawn_cat_demo_loop   running_cat_demo=%i" i=running_cat_demo
	;return
	if ( running_cat_demo = 0 )
		change running_cat_demo=1
		// make sure Cat_Skater exists
		begin
			if ObjectExists id=Cat_Skater
				break
			endif
			wait 1 gameframe
		repeat
		// make sure rotations from previous cats are released
		RunScriptOnObject id=Cat_Skater cancel_rotate_display
        wait 1 second
        KillSpawnedScript name=cat_perform_trick_loop
		RunScriptOnObject id=Cat_Skater cat_perform_trick_loop Params={ ObjId=Cat_Skater }
    endif
endscript

script cancel_rotate_display
	CancelRotateDisplay
endscript

script cat_perform_trick_loop
	printf "cat_perform_trick_loop"
    
	begin
        calculate_cat_score get_time
        if ScreenElementExists id=timeline_scrubber
			RunScriptOnScreenElement move_cat_scrubber id=timeline_scrubber params={ time=<time> id=timeline_scrubber }
		endif
		CreateATrick trick_index=0 demo_loop=demo_loop
		
		begin
			if ( cat_done = 1 )
				;WaitAnimFinished
				break
            endif
			wait 1 gameframe
		repeat
		
        Obj_PlayAnim anim=airidle cycle blend=0.3
		wait 0.5 seconds
		CancelRotateDisplay
		wait 0.3 seconds
		
        if ( running_cat_demo = 0 )
			printf "exiting cat_perform_trick_loop"
			break
		endif
	repeat
    
endscript

script move_cat_scrubber
    if ( <time> > 0 )
		end_pos = ( <time> * 200 )
		DoMorph alpha=1.0
		DoMorph pos=( <end_pos>*(1,0) + (0,-16) ) time=<time>
		if ScreenElementExists id=<id>
			DoMorph pos=(0,-16) alpha=0
		endif
	endif
endscript

script cat_menu_add_meter_item
	value_int = (<value>*100)
	CastToInteger value_int
	
	;theme_menu_add_item <...>
	cat_menu_add_number_item <...> right_arrow_pos=(190,-15) value=<value_int> percent
	
	anchor_id=<id>
	
	FormatText ChecksumName=meter_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=meter_bg_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	value_scale = ( <value> * (5,0) + (0,1) )
	
	// meter value
    CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		
		texture=cat_box
		scale=<value_scale>
		pos=(108,-6)
		just=[left center]
		rgba=<meter_rgba>
		z_priority=-1
	}
	
	// meter bg
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		
		texture=cat_box
		scale=(5,1)
		pos=(108,-6)
		just=[left center]
		rgba=<meter_bg_rgba>
		z_priority=-1
	}
    
endscript

script cat_menu_add_number_item
	if not GotParam pad_choose_script
		pad_choose_script=null_script
	endif
	
	theme_menu_add_number_item {	
									;text=<text>
									;value=<value>
									;id=<id>
									<...>
									cat_edit_item=cat_edit_item
									pad_choose_script=<pad_choose_script>
									;pad_right_script=<pad_right_script>
									;pad_right_params=<params>
									;pad_left_script=<pad_right_script>
									;pad_left_params=<params>
								}
endscript

script cat_update_right_arrow
	GetTags
    GetStackedScreenElementPos X id={ <id> child=3 } offset=(3,2)
	SetScreenElementProps { id={ <id> child=5 } pos=<pos> }
endscript

script cat_update_left_arrow
	GetTags
    GetScreenElementPosition id={ <id> child=0 }
    SetScreenElementProps { id={ <id> child=4 } pos=(<ScreenElementPos> + (0,2)) }
endscript

script create_timeline_fader_box parent=current_menu_anchor
	
	if ScreenElementExists id=timeline_fader
		return
	endif
	
	CreateScreenElement {
		type=SpriteElement
		parent=<parent>
		id=timeline_fader
		
		texture=white2
		scale=(78,17)
		pos=(0,258)
		just=[left top]
		rgba=[0 0 0 50]
		z_priority=100
	}
endscript

////////////////////////////////////////////////////////////////////
// add tricks to menus scripts
////////////////////////////////////////////////////////////////////

script add_trick_list_items array=cat_flip_tricks
	
	FormatText ChecksumName=bg_piece_rgba "%i_BG_PARTS_COLOR" i=(THEME_PREFIXES[current_theme_prefix])
    
	FormatText checksumname=mid_id "middle_piece_2_%i" i=middle_piece_id_num
    FormatText checksumname=left_id "left_piece_2_%i" i=middle_piece_id_num
    FormatText checksumname=right_id "right_piece_2_%i" i=middle_piece_id_num
	FormatText checksumname=top_id "box_top_anchor2"
	change middle_piece_id_num = ( middle_piece_id_num + 1 )
	
	theme_background parent=trick_menu id=bg_box_vmenu width=2.5 pos=(570,85) num_parts=5
	
    GetArraySize <array>
	index=0
	begin
        RemoveParameter first_item
		RemoveParameter last_item
		
		if ( <index> = 0 )
			first_item=first_item
		else
			if (<index> = (<array_size>-1))
				last_item=last_item
			endif
		endif
		
		trick=( <array>[<index>] )
        If IsArray <trick>
			text=( ((<trick>[0]).Params).name )
		else
			text=( (<trick>.Params).name )
		endif
		
		if not GotParam sounds
			focus_script=main_theme_focus
			unfocus_script=main_theme_unfocus
		else
			focus_script=cat_trick_list_sound_focus
			unfocus_script=cat_trick_list_sound_unfocus
			If IsArray <trick>
				stream=( ((<trick>[0]).Params).stream )
			else
				stream=( (<trick>.Params).stream )
			endif
			focus_params={ stream=<stream> }
		endif
		
		theme_menu_add_item {	parent=trick_vmenu
								centered=1
								no_bg=no_bg
								menu=2
								middle_scale=(2.5,1)
								text=<text>
								pad_choose_script=CAT_set_trick_struct
								pad_choose_params={ anim_index=<anim_index>
													timeline_id=<timeline_id>
													new_trick=<trick> }
								focus_script=<focus_script>
								unfocus_script=<unfocus_script>
								focus_params=<focus_params>
								first_item=<first_item>
								last_item=<last_item>
							}
		index=( <index> + 1 )
	repeat <array_size>
	
    FormatText checksumname=mid_id "middle_piece_2_%i" i=middle_piece_id_num
    FormatText checksumname=left_id "left_piece_2_%i" i=middle_piece_id_num
    FormatText checksumname=right_id "right_piece_2_%i" i=middle_piece_id_num
	change middle_piece_id_num = ( middle_piece_id_num + 1 )
	
	SetScreenElementProps {
		id=trick_vmenu
		event_handlers=[ { pad_up		menu_vert_blink_arrow params={ id=scrolling_menu_up_arrow rgba=<bg_piece_rgba> } }
						 { pad_down		menu_vert_blink_arrow params={ id=scrolling_menu_down_arrow rgba=<bg_piece_rgba> } }
					   ]
	}
	
    if ScreenElementExists id=bg_box_top
        CreateScreenElement {
			type=SpriteElement
			parent=bg_box_top
			id=scrolling_menu_up_arrow
			
			texture=up_arrow
			pos=(0,13)
			just=[center center]
			rgba=<bg_piece_rgba>
			scale = (0.8,1)
			z_priority=3
		}
		
		;GetScreenElementPosition id=trick_menu
		;DoScreenElementMorph id=trick_menu pos=( <ScreenElementPos> + (0,30))
	endif
	
	if ScreenElementExists id=bg_box_bottom
		CreateScreenElement {
			type=SpriteElement
			parent=bg_box_bottom
			id=scrolling_menu_down_arrow
			
			texture=down_arrow
			pos=(0,-5)
			just=[center center]
			rgba=<bg_piece_rgba>
			scale = (0.8,1)
			z_priority=3
		}
	endif
	
    wait 2 gameframes // must have  <--- that, before next line
	SetScreenElementProps id=trick_scrolling_menu reset_window_bottom
    
endscript

script cat_trick_list_sound_focus
    StopStream
	RunScriptOnScreenElement id=trick_vmenu cat_trick_list_spawned_sound params={ stream=<stream> }
	main_theme_focus <...>
endscript

script cat_trick_list_spawned_sound
    wait 10 gameframes
	PlayStream <stream> vol=100
endscript

script cat_trick_list_sound_unfocus
    KillSpawnedScript name=cat_trick_list_spawned_sound
	StopStream
	main_theme_unfocus <...>
endscript

cat_grab_tricks=[
                    Trick_Indy
					Trick_Melon
					Trick_Tailgrab
					Trick_Nosegrab
					Trick_Mute
					
					Trick_Airwalk
					Trick_IndyNoseBone
					Trick_Crossbone
					Trick_Benihana
					Trick_Stalefish
					Trick_Cannonball
					Trick_Japan
					Trick_Crail
					Trick_SaranWrap
					Trick_FSShifty
					Extra_BSShifty
					
					// Double Tap Grabs
					Trick_Madonna
					Trick_Judo
					Trick_OneFootJapan
					Trick_ChristAir
					Trick_Stiffy
					Trick_Rocket
					Trick_Method
					Trick_SackTap
					Extra_TuckKnee
					Trick_BetweenTheLegs
					Extra_CannonballFingerflip
					Trick_Stalefish_Layback
					Trick_CrookedCop
					Trick_DelMarIndy
					Trick_OneFootTailgrab
					Trick_Seatbelt
					
				]
				
cat_flip_tricks=[
					Trick_Kickflip
					Trick_Heelflip
					Trick_Impossible
                    Trick_FFImpossible
					Trick_PopShoveIt
					Trick_FSShoveIt
					Trick_Hardflip
					Trick_OllieNorth
                    Trick_FingerFlip
					
					Trick_VarialKickflip
					Extra_VarialKickflip
					Trick_VarialHeelflip
					Extra_VarialHeelflip					
					
					Trick_OldSkoolKickflip
					Trick_BigSpinFlip
					Trick_FSFlip
					Trick_BSFlip
					
					Trick_FSBigSpin
					Trick_BSBigSpin
					
					Trick_BackfootKickflip
					Extra_DBackfootHeelflip
					
					Trick_SalFlip
					Trick_180Varial
					Trick_360Varial
					DoubleKickflip
					TripleKickflip
					DoubleHeelflip
					TripleHeelflip
					Trick_OllieAirwalk
					Trick_HFVarialLien
					
					CATTrick_KickflipFS
					CATTrick_KickflipBS

					
					Extra_DoubleFingerFlip
					Extra_360Hardflip
					Trick_InwardHeelflip
					Extra_360InwardHeelflip
					DoubleImpossible
					TripleImpossible
					Extra360ShoveIt
					Extra540ShoveIt
					
					ExtraFS360ShoveIt
					ExtraFS540ShoveIt
					
					Trick_BackfootShoveIt
					 
					Extra_DBackfootKickflip
					Trick_BackfootHeelflip 
					
				]
				
cat_special_tricks=[
					
					trick_the900
                    Trick_BamBendAir
					Trick_FlyingSquirrel
					Trick_BreakIn
					Trick_Shifty360ShovitBSShifty
					Trick_flipflip
					Trick_540varielheelfliplien
					Trick_FSFlipOneFootTailGrab
					//Trick_SambaFlip
					Trick_Flamingo
                    Trick_360VarialMcTwist
					Trick_BarrelRoll
					Trick_Indy900       
					Trick_SitDownAir    
					Trick_ChompOnThis   
					Trick_GhettoBird
					Trick_BigSpinShifty
					//Trick_KFBackflip
					;Trick_MistyFlip    
					//Trick_FS540    
					Trick_McTwist
					Trick_2KickMadonnaFlip
					Trick_AssumePosition  
					Trick_AirCasperFlip
					;Trick_KickFlipOneFootTail						 
					Trick_540TailWhip
					Trick_Gazelle
					trick_SemiFlip
                    trick_FingerFlipAirWalk
					trick_Jackass
					trick_1234
					trick_DoubleKFIndy
					trick_540flip
					trick_NollieFlipUnderFlip
					trick_HardFlipBackFootFlip
					trick_KickFlipUnderFlip
					trick_QuadrupleHeelFlip
]

cat_misc_tricks=[
					CATTrick_Handstand
					CATTrick_Casper
					CATTrick_AntiCasper
					CATTrick_Truckstand
					CATTrick_SwitchFootPogo
					
					;CATTrick_SwitchFootPogoIdle
					CATTrick_GuitarSlide
					CATTrick_AmericanHero

					CATTrick_other01
					;CATTrick_other02
					CATTrick_other03
					CATTrick_other04
					CATTrick_other05
					CATTrick_other06
					CATTrick_other07
					CATTrick_other08
					CATTrick_other09
					CATTrick_other10
									
					CATTrick_other11
					CATTrick_other12
					CATTrick_other13
					CATTrick_other14
					CATTrick_other15
					CATTrick_other16
					CATTrick_other17
					CATTrick_other18
					CATTrick_other19					
]

cat_generic_tricks=[
					CATSFX_StripClub 
					CATSFX_Gator     
					CATSFX_Crack     
					CATSFX_Fire      
					CATSFX_Cops      
					CATSFX_Geek      
					CATSFX_Dog       
					CATSFX_Seal      
					CATSFX_Funk      
					CATSFX_Drum
					CATSFX_Fart
                    CATSFX_Burp
					CATSFX_Flush      
]

// required, SCR, Name, Anim
CATTrick_Handstand = {X Params={Name='HandStand' Anim=HandstandHandFlip_Init Idle=HandstandHandFlip_Range OutAnim=HandstandHandFlip_out } }
CATTrick_Casper = {X Params={Name='Casper' Anim=Casper_Init Idle=Casper_Range OutAnim=Casper_out BoardRotate } }
CATTrick_AntiCasper = {X Params={Name='Anti Casper' Anim=AntiCasper_Init Idle=AntiCasper_Range OutAnim=AntiCasper_out BoardRotate } }
CATTrick_Truckstand = {X Params={Name='Truckstand' Anim=Truckstand_Init Idle=Truckstand_Range OutAnim=Truckstand_Out } }
CATTrick_SwitchFootPogo = {X Params={Name='Switch Foot Pogo' Anim=Truckrun_Init Idle=TruckRun OutAnim=Truckrun_Out } }

CATTrick_SwitchFootPogoIdle = {X Params={Name='Pogo Idle' Anim=TruckRun}} 
CATTrick_KickflipFS = {X Params={Name='Kickflip to FS Grab' Anim=KickFlipBlendFS}}
CATTrick_KickflipBS = {X Params={Name='Kickflip to BS Grab' Anim=KickFlipBlendBS}}

CATTrick_GuitarSlide = {X Params={Name='The Faction' Anim=Guitar_Idle SpecialItem_details=Guitar_Details Stream=GuitarSlide}}
CATTrick_AmericanHero = {X Params={Name='American Tribute' Anim=AmericanHeroGrind_Idle SpecialItem_details=flag_Details SpecialSounds=Jamie_HeroSounds}}

CATSFX_StripClub 	= {X Params={sound Name='Strip Club' Anim=AirIdleCAT Stream=FLStripClub05 }} 

CATSFX_Burp 		= {X Params={sound Name='Chow Down' Anim=AirIdleCAT Stream=Burp01 }} 
CATSFX_Fart 		= {X Params={sound Name='Bronco Burrito' Anim=AirIdleCAT Stream=Fart01 }} 
CATSFX_Flush 		= {X Params={sound Name='Give it Gas' Anim=AirIdleCAT Stream=HI_WarpFlush }} 
CATSFX_Gator 		= {X Params={sound Name='Gators Attack' Anim=AirIdleCAT Stream=FL_AlligatorEatSkater }}
CATSFX_Fire 		= {X Params={sound Name='Fire Fire Fire!' Anim=AirIdleCAT Stream=NJ_PipeIgnite }} 
CATSFX_Cops 		= {X Params={sound Name='Officer D.' Anim=AirIdleCAT Stream=NY_PoliceChirp01 }} 
CATSFX_Geek 		= {X Params={sound Name='Geek It' Anim=AirIdleCAT Stream=SJ_HalComputer04 }} 
CATSFX_Dog 			= {X Params={sound Name='Sup Dawg' Anim=AirIdleCAT Stream=NJ_DogBark06 }} 
CATSFX_Seal 		= {X Params={sound Name='Arf Arf Arf' Anim=AirIdleCAT Stream=Sealbark }} 
CATSFX_Crack 		= {X Params={sound Name='Spook Me' Anim=AirIdleCAT Stream=NJ_NightCrackHouseOwl01 }} 
CATSFX_Funk 		= {X Params={sound Name='Da Funk' Anim=AirIdleCAT Stream=SD_MusicalInstrumentBass }} 
CATSFX_Drum 		= {X Params={sound Name='Drum Line' Anim=AirIdleCAT Stream=HI_CollectDrumShort03 }} 

CATTrick_other01 	= {X Params={Name='Slam Bam' Anim=FaceFall}} 
;CATTrick_other02 	= {X Params={Name='Karate Style' Anim=GetUpDarthMaul}} 
CATTrick_other03 	= {X Params={Name='Boneless' Anim=Boneless}} 
CATTrick_other04 	= {X Params={Name='Cheer 1' Anim=Cheer1}} 
CATTrick_other05 	= {X Params={Name='Cheer 2' Anim=Cheer2}} 
CATTrick_other06 	= {X Params={Name='Sketchy' Anim=SketchyLand}} 
CATTrick_other07 	= {X Params={Name='Slap' Anim=SlapAir}} 
CATTrick_other08 	= {X Params={Name='Taunt 1' Anim=Taunt1}} 
CATTrick_other09 	= {X Params={Name='Taunt 2' Anim=Taunt2}} 
CATTrick_other10 	= {X Params={Name='Taunt 3' Anim=Taunt3}} 

CATTrick_other11 	= {X Params={Name='Rail Flip' Anim=RailFlip}} 
CATTrick_other12 	= {X Params={Name='Casper Flip' Anim=CasperFlip}} 
CATTrick_other13 	= {X Params={Name='Half Cab Impossible' Anim=HalfCabImpossible }} 
CATTrick_other14 	= {X Params={Name='360 Fingerflip' Anim=_360FlipNoseManual}} 
CATTrick_other15 	= {X Params={Name='SpaceWalk' Anim=Spacewalk}} 
CATTrick_other16 	= {X Params={Name='Props' Anim=Prop}} 
CATTrick_other17 	= {X Params={Name='Nollie' Anim=Nollie}} 
CATTrick_other18 	= {X Params={Name='Ollie' Anim=Ollie}} 
CATTrick_other19 	= {X Params={Name='Drop It' Anim=RunOutDropIdle}} 
//Strip Tease - FLStripClub04
//The 13th - HI_ChopperCut01
//Crank It - NJ_RatchetCollect04
//Fixer Upper - NJ_SpeedBikeShop04
//Deflate - VC_AirBrakeRelease
// Retired Tricks
//					Trick_Bodywrap540
//					Trick_BackFootNosegrab
//                  Trick_BigSpinShifty
//					Trick_StaleFrontFlip
//					Trick_StaleBackFlip
//					Trick_FS540HeelFlip
//					Trick_JudoMadonna
//					Trick_KFSuperman
//					trick_BetweenLegsSlam
//					Trick_HeelFlipHandflip
