// gap menu


// ************************************
//      Gap menu  
// ************************************

// @script | skip_to_gap_menu | skeleton of skip to gap menu
// filled in by code
script launch_gap_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	create_gap_menu <...>
endscript
                       
// @script | create_gap_menu |                                                             
script create_gap_menu back_script=gap_menu_exit_to_pause_menu choose_script=nullscript
	
	GoalManager_HidePoints
	GoalManager_HideGoalPoints	
	hide_current_goal
	SetScreenElementLock id=root_window off
	
	// anchor for the whole thing
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=gap_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	AssignAlias id=gap_anchor alias=current_menu_anchor
	create_helper_text { helper_text_elements=[ { text="\b7/\b4 = Select" }
											    { text="\m1 = Back" }
											  ]
					   }
	
	kill_start_key_binding
	
	FormatText ChecksumName=title_icon "%i_gap" i=(THEME_PREFIXES[current_theme_prefix])
	build_theme_sub_title title="GAP CHECKLIST" title_icon=<title_icon>
    FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
	build_theme_box_icons icon_texture=<paused_icon>
    build_grunge_piece
    build_top_bar pos=(0, 62)
	
	// anchor for the whole thing
	CreateScreenElement {
		type=ContainerElement
		parent=gap_anchor
		id=gap_menu
		
		dims=(640, 480)
		pos=(320, 640)
	}
	AssignAlias id=gap_menu alias=current_menu_anchor
    
    // theme background
	theme_background width=6.35 pos=(320,85) num_parts=10.5
	
	<root_pos> = (80, 25)
	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
    // top bar
	;GetStackedScreenElementPos Y id=<id> offset=(-15, -4)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=view_gaps_menu_top_bar
		
		texture=black
		rgba=[0 0 0 85]
		scale=(130, 7)
		pos=(65,87)
		just=[left top]
		z_priority=2
	}
	
	// score header
	GetStackedScreenElementPos Y id=<id> offset=(6, -25)
	CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor
		
		font=dialog
		text="Score"
		rgba=<text_rgba>
		scale=1
		pos=<pos>
		just=[left top]
		z_priority=3
	}
	
	// name header
	GetStackedScreenElementPos X id=<id> offset=(15, 0)
	CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor
		
		font=dialog
		text="Name"
		rgba=<text_rgba>
		pos=<pos>
		just=[left top]
		scale=1
		z_priority=3
	}
	
	// up arrow
	GetStackedScreenElementPos X id=<id> offset=(115, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=view_gaps_menu_up_arrow
		
		texture=up_arrow
		rgba=[128 128 128 85]
		pos=<pos>
		just=[left top]
		z_priority=3
	}
	
	// times header
	GetStackedScreenElementPos X id=<id> offset=(168, 0)
	CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor
		
		font=dialog
		text="Times"
		rgba=<text_rgba>
		pos=<pos>
		just=[left top]
		scale=1
		z_priority=3
	}
	
	// vertical bar between score and name
	GetStackedScreenElementPos Y id=view_gaps_menu_top_bar offset=(60, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=black
		scale=(2, 68)
		pos=<pos>
		just=[left top]
		rgba=[0 0 0 0]
	}
	
	// vertical bar between name and times
	GetStackedScreenElementPos X id=<id> offset=(355, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=black
		scale=(2, 68)
		pos=<pos>
		just=[left top]
		rgba=[0 0 0 0]
	}
	
	// bottom bar
	GetStackedScreenElementPos Y id=view_gaps_menu_top_bar offset=(0, 250)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=black
		rgba=[0 0 0 0]
		scale=(124, 6)
		pos=<pos>
		just=[left top]
		z_priority=2
	}
	
	// down arrow
	GetStackedScreenElementPos Y id=view_gaps_menu_up_arrow	offset=(0, 260)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=view_gaps_menu_down_arrow
		
		texture=down_arrow
		rgba=[128 128 128 85]
		pos=<pos>
		just=[left top]
		z_priority=3
	}		
	
	// scrolling menu
	GetStackedScreenElementPos Y id=view_gaps_menu_top_bar offset=(20, 5)
	CreateScreenElement {
		type=VScrollingMenu
		parent=current_menu_anchor
		
		dims=(640, 245)
		pos=<pos>
		just=[left top]
		internal_just=[center top]
	}
	
	// vmenu
	CreateScreenElement {
		type=VMenu
		parent=<id>
		id=gap_vmenu
		
		pos=(0, 0)
		just=[left top]
		internal_just=[left top]
		dont_allow_wrap
		
		event_handlers=[
			{ pad_up 		set_which_arrow params={ arrow=view_gaps_menu_up_arrow } }
			{ pad_down		set_which_arrow params={ arrow=view_gaps_menu_down_arrow } }
			{ pad_up 		generic_menu_up_or_down_sound params={ up } }
			{ pad_down		generic_menu_up_or_down_sound params={ down } }
			{ pad_back		generic_menu_pad_back_sound }
		]
	}
	AssignAlias id=gap_vmenu alias=current_menu
	
    // Define pad_back event - go back to the pause menu
    SetScreenElementProps { 
		id=current_menu
		event_handlers=[ { pad_back    generic_menu_pad_back params={ callback=<back_script>} } ]
	} 
						  
    AddGapsToMenu initial_scale=.8 choose_script=<choose_script>
    DoScreenElementMorph id=current_menu_anchor pos=(320,240) time=0.2
	FireEvent type=focus target=current_menu
endscript

script gap_menu_add_item choose_script=nullscript
	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=text_rgba2 "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

    //printf "Score=%d Name=%s" d=<gap_score> s=<gap_name>
    	
	// build the focus params
	if GotParam first_item
		focus_params={ first_item }
	else
		if GotParam last_item
			focus_params={ last_item }
		endif
	endif
	
	// container for this element
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		
		dims=(200, 20)
		event_handlers=[ { focus		gap_menu_focus params={ <focus_params> times=<times> } }
						 { unfocus		gap_menu_unfocus params={ times=<times> } }
                         
                         { focus		gap_menu_focus_show_gap params=<...>}
                         
						 { pad_choose	<choose_script> params={gap_number=<gap_number> times=<times>} }
					   ]
	}
	<anchor_id> = <id>

	// make it green if they've gotten it once
	if ( <times> > 0 )
		rgba=<text_rgba>
		alpha=1.0
	else
		rgba=<text_rgba>
		alpha=0.4
	endif

	
	// score
	FormatText TextName=gap_score "%i" i=<gap_score>
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small
		text=<gap_score>
		pos=(13, 0)
		just=[center top]
		rgba=<rgba>
		alpha=<alpha>
		scale=.8
	}
	
	// name
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small;dialog
		text=<gap_name>
		pos=(55, 0)
		just=[left top]
		rgba=<rgba>
		alpha=<alpha>
		scale=.8
	}

	/*if ( <times> > 0 )
		// add the line
		GetScreenElementDims id=<id>
		CreateScreenElement {
			type=SpriteElement
			parent=<id>
			texture=goal_line
			
			pos=(-8, 13)
			just=[left center]
			rgba=[128 128 128 128]
			z_priority=10
			scale=( ( (1, 0) * ( <width> * 1.25 ) / 32 ) + (.3, .4) )
		}
	endif*/
	
	// times
	// clamp it just to be safe
	if ( <times> > 99999 )
		<times> = 99999
	endif

	FormatText TextName=times "%i" i=<times>
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=small
		text=<times>
		pos=(444, 0)
		just=[center top]
		rgba=<rgba>
		alpha=<alpha>
		scale=.8
	}
	
    //highlight bar
    highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )
	
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		texture=de_highlight_bar
		
		pos=(232, 10)
		just=[center center]
		rgba=[0 0 0 0]
		z_priority=3
		scale=(4.1,0.7)
		rot_angle=(<highlight_angle>/4)
	}
endscript

script gap_menu_focus_show_gap
if (<times> > 0)
    // If the gap has been got, setup the camera the look at the gap.

    menu_cam:UnPause
    
    // Use the position of the skater at the start of the gap attempt, but move up a bit so
    // as not to be too close to the ground.
    menu_cam:Obj_SetPosition position=(<skater_start_pos>+(0,80,0))

    // The skater dir has to be flipped in sign before use by the camera.
    // Also tweak the y so as to make the camera look down a bit, otherwise for some
    // gaps such as the high-wire gaps in New Jersey the camera ends up just looking at the sky.
    dir_x=(<skater_start_dir>.(-1,0,0))
    dir_y=0.1
    dir_z=(<skater_start_dir>.(0,0,-1))
    // Construct a vector out of the tweaked components.
    dir=( <dir_x>*(1,0,0) + <dir_y>*(0,1,0) + <dir_z>*(0,0,1) )
    // Note: No need to normalize dir, Obj_SetOrientation will do that.
    menu_cam:Obj_SetOrientation dir=<dir>
            
    SetActiveCamera id=menu_cam
else
    // Make sure the normal skater cam is used for gaps that have not been got yet.
    restore_skater_camera
endif

endscript

script skip_to_selected_gap
// Not doing anything, but in therey we could do something if we select a gap?
// maybe display some detailed records?  

//    ResetSkaters <...>  // passing in "node_number"
//    exit_pause_menu
endscript

// just preview the gap point without exiting the menu
// used by the "focus" command, so just scrolling up and down the gap points will 
script preview_gap
// Note - Not doing anything here, but in theory you could rememeber the position
// of the skater when he landed the gap, and display a "screenshot"
// by temporarily moving the camera there

//    pulse_blur start =200 speed = 5
//    ResetSkaters <...>  // passing in "node_number"
    SetProps rgba=[127 102 0 100]
    DoMorph time=.1 scale=.85
    GetTags
	
endscript

script gap_menu_focus
	GetTags
	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	if ( <times> > 0 )
		rgba=<text_rgba>;[99 121 6 128]
	else
		rgba=<text_rgba>
	endif
	
	// score
	RunScriptOnScreenElement id={ <id> child=0 } text_twitch_effect2
	DoScreenElementMorph {
		id={ <id> child=0 }
		rgba=<rgba>
		scale=1.0
	}
	
	// name
	RunScriptOnScreenElement id={ <id> child=1 } text_twitch_effect2
	DoScreenElementMorph {
		id={ <id> child=1 }
		rgba=<rgba>
		scale=1.0
	}
	
	// times
	RunScriptOnScreenElement id={ <id> child=2 } text_twitch_effect2
	DoScreenElementMorph {
		id={ <id> child=2 }
		rgba=<rgba>
		scale=1.0
	}
	
	// highlight bar
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetScreenElementProps {
		id={ <id> child=3 }
		rgba=<bar_rgba>
	}
	
	// update the arrows
	if GotParam first_item
		SetScreenElementProps {
			id=view_gaps_menu_up_arrow
			rgba=[128 128 128 0]
		}
	else
		SetScreenElementProps {
			id=view_gaps_menu_up_arrow
			rgba=[128 128 128 85]
		}
	endif
	
	if GotParam last_item
		SetScreenElementProps {
			id=view_gaps_menu_down_arrow
			rgba=[128 128 128 0]
		}
	else
		SetScreenElementProps {
			id=view_gaps_menu_down_arrow
			rgba=[128 128 128 85]
		}
	endif
	
	//blinking arrow stuff
	gap_vmenu:GetTags
		
	if GotParam arrow_id
		menu_vert_blink_arrow { id=<arrow_id> } 
	endif
endscript

script gap_menu_unfocus
	GetTags
	FormatText ChecksumName=text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	KillSpawnedScript name=text_twitch_effect2
	
	if ( <times> > 0 )
		rgba=<text_rgba>;[25 83 67 128]
	else
		rgba=<text_rgba>
	endif
	
	// score
	DoScreenElementMorph {
		id={ <id> child=0 }
		rgba=<rgba>
		scale=0.8
	}
	
	// name
	DoScreenElementMorph {
		id={ <id> child=1 }
		rgba=<rgba>
		scale=0.8
	}
	
	// times
	DoScreenElementMorph {
		id={ <id> child=2 }
		rgba=<rgba>
		scale=0.8
	}
	
	// highlight bar
	SetScreenElementProps {
		id={ <id> child=3 }
		rgba=[0 0 0 0]
	}
endscript

script gap_menu_exit_to_pause_menu
	GoalManager_ShowPoints
	if not GoalManager_HasActiveGoals
		GoalManager_ShowGoalPoints
	endif
	
    // Make sure we switch back to the normal skater cam because it might have been switched
    // to the menu_cam for viewing a gap.
    restore_skater_camera
    
	restore_start_key_binding
    AssignAlias id=gap_anchor alias=current_menu_anchor
	create_pause_menu
endscript

// ************************************
//      Got all gaps screen  
// ************************************

script got_all_gaps_screen_create

	GetCurrentLevel
	switch <level>
	case load_skateshop
	case load_cas
	case load_boardshop
	case load_sk5ed
	case load_sk5ed_gameplay
		return
	endswitch
	
	if GetGlobalFlag flag=GOT_ALL_GAPS
		//return
	endif
	SetGlobalFlag flag=GOT_ALL_GAPS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	
	if not InNetGame
		PauseGame
	endif
	StopStream
	PlayStream FoundAllGaps vol=150	

	create_dialog_box { title="Holy Crap! All Gaps!"
						text="Did you use a strategy guide? Online cheat site? No? You found them legit? Well hell, you should come hang with us. Just don't knock your own teeth out. \n\nYou've unlocked:\n\c3- 26 selectable skaters!\n (ok, so they're just pedestrians, but hey, they're pretty damn cool)."
						pos=(310 ,240)
						just=[center center]
						text_rgba=[88 105 112 128]
						;text_dims=(320,0)
						text_dims=(330,0)
						style=special_dialog_style
						pad_back_script = <back_script>
						buttons=[ { font=small text="OK" pad_choose_script=got_all_gaps_screen_exit } ]
						delay_input
					  }
endscript

script got_all_gaps_screen_exit
	dialog_box_exit
    UnPauseGame
endscript

//////////////////////////////////////////////////////////////////////////////////////////////////


/*script got_gap_for_first_time
	FormatText TextName=text "Found gap: %s" s=<gap_text>
	create_console_message text=<text> wait_and_die time=2
endscript*/



script got_gap_for_first_time
	
	printf <gap_text>
	if GotParam multiple_new_gaps
		FormatText TextName=text "Found Gaps:" 
		
		SetScreenElementProps id=first_time_goal_info_title text=<text>
		
		if (<multiple_new_gaps> < 9)  //cap the new gaps display at 9
			CreateScreenElement {
				type=TextElement
				parent=first_time_goal_info
				
				font=small         
				text=<gap_text>           
				pos=((0,20) * <multiple_new_gaps>)
				just=[center center]
				internal_just=[center center]
				line_spacing=.8
				rgba=[20 98 114 108]
				
				allow_expansion
				z_priority=-5
			}
		else
			if (<multiple_new_gaps> = 9) //if they get 9 or more, just display a single "..."
				CreateScreenElement {
				type=TextElement
				parent=first_time_goal_info
				
				font=small         
				text="..."           
				pos=((0,20) * <multiple_new_gaps>)
				just=[center center]
				internal_just=[center center]
				line_spacing=.8
				rgba=[20 98 114 108]
				
				allow_expansion
				z_priority=-5
			}
			endif
		endif
	else
		// create named panel block
		SetScreenElementLock id=root_window off
					
		if ObjectExists id=first_time_goal_info
			DestroyScreenElement id=first_time_goal_info
		else
			SpawnSound found_gap_success_sound
		endif
	   
	
		CreateScreenElement {
			type= ContainerElement
			parent=root_window
			id=first_time_goal_info
			pos=(320,0)
			dims=(0,0)
			just=[center center]
			internal_just=[center center]
		}
		
		CreateScreenElement {
			type=TextElement
			parent=first_time_goal_info
			id=first_time_goal_info_title
			
			font=small         
			text="Found Gap: "      
			pos=(0,0) 
			just=[center center]
			internal_just=[center center]
			line_spacing=.8
			rgba=[20 98 114 108]
			
			allow_expansion
			z_priority=-5
		}
		
		CreateScreenElement {
			type=TextElement
			parent=first_time_goal_info
			
			font=small         
			text=<gap_text>           
			pos=(0,20) 
			just=[center center]
			internal_just=[center center]
			line_spacing=.8
			rgba=[20 98 114 108]
			
			allow_expansion
			z_priority=-5
		}
		
		RunScriptOnScreenElement id=first_time_goal_info goal_message_got_gap params=<...>
	endif
	
	;create_panel_block text=<text> style=goal_message_got_gap id=first_time_goal_info line_spacing=0.8
       
endscript

