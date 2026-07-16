current_chapter=1

/////////////////////////////////////////////////////////////
// Chapter Menu

script launch_chapter_menu
	GoalManager_HidePoints
	GoalManager_HideGoalPoints
	
	create_chapter_menu load_em=1 no_fade <...>
	
    ;spawnscript fade_in_chap_menu
endscript

script fade_in_chap_menu
	wait 20 gameframes
	spawnscript fadetoblack params={ off id=fade_out_anchor }
endscript

script create_chapter_menu	
	change check_for_unplugged_controllers = 0
	GoalManager_GetCurrentChapterAndStage
    change current_chapter=( <currentChapter> + 1 )
	
	hide_current_goal
	
    if not GotParam no_fade
		spawnscript fadetoblack params={ on id=fade_out_anchor create_script=create_chapter_fade_piece alpha=1 time=0.4 }
	endif
	
	if ObjectExists id=current_menu_anchor
		;load_chapter_textures_to_main_memory
		DestroyScreenElement id=current_menu_anchor
		load_em=1
	endif
	
	hide_console_window
	
	wait 0.5 seconds
	if GotParam load_em
		load_chapter_textures_to_main_memory
	endif	
    
	;pause_menu_gradient off
	
    FormatText ChecksumName=highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=unhighlight_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
    
    SetScreenElementLock id=root_window off
	
	CreateScreenElement {
		type=ContainerElement
        parent=root_window
        id=chapter_menu_anchor
		pos=(320,240)
		dims=(640,480)
	}
	AssignAlias id=chapter_menu_anchor alias=current_menu_anchor 
    
    build_top_and_bottom_blocks static
	
    // bg
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=blue_bg
		
		texture=chapter_bg
		rgba=[10 38 52 128]
		just=[left top]
		pos=(0,100)
		scale = (5,3)
		z_priority=-3
		;alpha=0.5
	}
	
	// bg effect
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=moving_bg
		
		texture=bg_elements
		rgba=[128 128 128 20]
		just=[left top]
		pos=(0,70)
		scale = (10,4)
		z_priority=-2
		alpha=0
	}
	
    // rotating bg effect
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=rotating_bg_new
		
		texture=bg_vector_2
		rgba=[37 57 64 128]
		just=[center, center]
		pos=(210, 200)
		scale = (2.5, 2.5)
		z_priority=-1.5
		alpha=0
	}
	
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=rotating_bg_new_2
		
		texture=bg_vector_2
		rgba=[128 17 2 128]
		just=[center, center]
		pos=(210, 200)
		scale = (2.5, 2.5)
		z_priority=-1.0
		alpha=0
	}

	
	// text
    FormatText TextName=chap_text "CHAPTER %i: %l" i=current_chapter l=( (CHAPTER_LEVELS[(current_chapter-1)]).text )
	// chapter number
	CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor
		id=chap_number
		
		text=<chap_text>
		font=testtitle
		rgba=<highlight_rgba>
		just=[left top]
		pos=(25,22)
		scale=1.2
		z_priority=3
        alpha=.39
	}
    
	// bracket
	FormatText ChecksumName=bracket_texture "%i_sub_frame" i=(THEME_PREFIXES[current_theme_prefix])
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=chap_border
        texture=<bracket_texture>
		
		rgba=[ 128 128 128 0]	// made the bracket transparent cause the other theme pieces don't work well
		just=[left top]
		pos=(12,10)
		scale=(1.0, 1.35)
		z_priority=3
	}

	// chapter title
	CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor
		id=chap_title
		
		text=( CHAPTER_TITLES[(current_chapter - 1)] )
		font=testtitle
		rgba=[30 73 100 120]
		just=[center top]
		pos=(318,34)
		scale=1.75
        alpha=.3
		z_priority=2
	}
    
	CreateScreenElement {
		type=TextElement
		parent=current_menu_anchor
		id=chap_title2
		
		text=( CHAPTER_TITLES[(current_chapter - 1)] )
		font=testtitle
		rgba=[128 128 128 100]
		just=[center top]
		pos=(320,34)
		scale=1.75
                alpha=.15
		z_priority=2
	}
	// chapter description
	CreateScreenElement {
		type=TextBlockElement
		parent=current_menu_anchor
		id=chap_description
		
		text=( CHAPTER_DESCRIPTIONS[(current_chapter - 1)] )
        font=dialog
		rgba=[128 128 128 60]
		dims=(570,50)
		allow_expansion
		just=[left top]
		internal_just=[left top]
		pos=(45,58)
		internal_scale=0.8
		z_priority=3
		line_spacing=0.6
        alpha=.75
	}
        
    // BG SUPPORT RED LINES
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=streak_2
		rgba=<highlight_rgba>
		just=[left top]
		pos=(0,50)
		scale = (10, 0.35)
        alpha=0.3
		z_priority=3
        rot_angle=-4
	}
        
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=streak_2
		rgba=<highlight_rgba>
		just=[left top]
		pos=(0,54)
		scale = (100, 0.25)
		z_priority=2
        rot_angle=0
        alpha=.65
	}
        
      
    CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=streak_2
		rgba=<highlight_rgba>
		just=[left top]
		pos=(0,268)
		scale = (10, 0.35)
        alpha=0.3
		z_priority=.5
        rot_angle=6
	}
    
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=streak_2
		rgba=<highlight_rgba>
		just=[left top]
		pos=(0,348)
		scale = (10, 0.35)
        alpha=0.5
		z_priority=.5
        rot_angle=-4
	}
    
   

    FormatText checksumname=chapter_graphic "chap_graphic_%i" i=( (CHAPTER_LEVELS[(current_chapter-1)]).num )
	
	if LevelIs ( (CHAPTER_LEVELS[(current_chapter-1)]).checksum )
		alpha=0
	else
		alpha=1
	endif
	
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu_anchor
		id=graphic_anchor
		
		pos=(320,240)
		dims=(640,480)
		alpha=<alpha>
	}
	
	// black box
	CreateScreenElement {
		type=SpriteElement
		parent=graphic_anchor
        
		texture=white2
		rgba=[0 0 0 128]
		just=[left top]
		pos=(380,100)
		scale = (40,40)
		z_priority=-4
	}
	                                     
	// graphic
	CreateScreenElement {
		type=SpriteElement
		parent=graphic_anchor
		id=chapter_graphic1
		
		texture=<chapter_graphic>
		rgba=[128 128 128 55]
		just=[center center]
		pos=(510,225)
		scale = (2.0,2.0)
		z_priority=3
                
	}
            
	
	// graphic ghost
	CreateScreenElement {
		type=SpriteElement
		parent=graphic_anchor
		id=chapter_graphic2
		
		texture=<chapter_graphic>
		rgba=[128 128 128 15]
		just=[center center]
		pos=(505,245)
		scale = (2.4,2.4)
		z_priority=0
        alpha=.6
                
	}
	
	// graphic ( top right )
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=chapter_graphic3
		
		texture=<chapter_graphic>
		rgba=[50 34 34 0]   /* I turned the alpha to zero for now */
		just=[center center]
		pos=(570,50)
		scale = (1.2,0.75)
		z_priority=0
		rot_angle=0
	}
	
	
	build_chapter_goal_list_menu <...>
	
    if not GotParam no_pad_left_right
		if not GotParam select_sponsor
			if not GotParam select_team
				// chapter select bar
				build_chapter_box_menu
			endif
		endif
	endif
	
    //Animate the parts in
    killspawnedscript name=text_moving_bg
	spawnscript chap_moving_bg
	spawnscript chap_new_rotating_bg
	spawnscript chap_new_rotating_bg_2
	spawnscript chap_graphic_crossfade
    
	if not GotParam no_fade
		spawnscript fadetoblack params={ off id=fade_out_anchor }
	endif
	pause_menu_gradient off
	
	wait 20 gameframes
	
    if ScreenElementExists id=chap_scrolling_menu
		SetScreenElementProps id=chap_scrolling_menu reset_window_top
    endif
	
	pulse_blur start=200 speed=5
	killspawnedscript name=play_chap_sound
	spawnscript play_chap_sound
	if ScreenElementExists id=chap_menu
		DoScreenElementMorph id=chap_menu time=0.2 pos=(290,232)
		wait 0.2 seconds
	endif
    
	FireEvent type=focus target=chap_menu
	
	// Highlight the first unbeaten goal in current stage
	GoalManager_GetCurrentChapterAndStage
	change disable_menu_sounds=1
	if not (<currentStage> = 0)
		<index>=0
		begin
			GetArraySize CHAPTER_GOALS index1=<currentChapter> index2=<index>
			begin
				FireEvent type=pad_down target=chap_vmenu
			repeat <array_size>
			<index> = (<index>+1)
		repeat <currentStage>
	endif
	<index>=0
	GetArraySize CHAPTER_GOALS index1=<currentChapter> index2=<currentStage>
	if not (<array_size>=0)
		begin 
			Get3DArrayData ArrayName=CHAPTER_GOALS index1=<currentChapter> index2=<currentStage> index3=<index>
			if StructureContains structure=<val> goal_id
				<goal_id> = (<val>.goal_id)
				if GoalManager_HasWonGoal name=<goal_id>
					FireEvent type=pad_down target=chap_vmenu
				else
					break
				endif
			endif
			<index> = (<index>+1)
		repeat <array_size>
	endif
	change disable_menu_sounds=0
	change check_for_unplugged_controllers=1
endscript

script chapter_menu_exit
	wait .3 seconds //needed for update to finish
	KillSkaterCamAnim current
	
	KillSpawnedScript name=chap_moving_bg
	KillSpawnedScript name=spawnscrip chap_new_rotating_bg
	KillSpawnedScript name=spawnscrip chap_new_rotating_bg_2
	KillSpawnedScript name=chap_graphic_crossfade
    KillSpawnedScript name=fadetoblack
	
    if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	if ScreenElementExists id=fade_out_anchor
		DestroyScreenElement id=fade_out_anchor
	endif
    load_chapter_textures_to_main_memory unload
    
	kill_blur start=0
	
	unhide_key_combo_text
	
	if not GotParam exit
		create_pause_menu
	else
		exit_pause_menu
	endif
endscript

script build_chapter_goal_list_menu pos=(-40,105) ;pos=(160,105)
	printf "build_chapter_goal_list_menu"
	RemoveParameter id
	
	final_on=[40 128 40 120]
	final_off=[60 120 60 100]
    
	if ScreenElementExists id=chap_menu
		DestroyScreenElement id=chap_menu
	endif
	
    // scrolling menu for chapter 25 only!
	/*if ( current_chapter = 25 )
        type=VScrollingMenu
		scrolling_menu_id=chap_scrolling_menu
		dont_allow_wrap=dont_allow_wrap
		dims=(300,229)
		if GotParam select_team
			pos=(0,118)
		else
			pos=(-35, 58)
		endif
	endif*/
	
	if GotParam select_team
		<padding_scale> = 0.9
	endif
	
	make_new_menu {
		type=<type>
		pos=<pos>
		parent=chapter_menu_anchor
		just=[center center]
		internal_just=[left center]
		menu_id=chap_menu
		vmenu_id=chap_vmenu
		scrolling_menu_id=<scrolling_menu_id>
		type=<type>
		dims=<dims>
		dont_allow_wrap=<dont_allow_wrap>
		padding_scale=<padding_scale>
	}
    DoScreenElementMorph id=chap_menu time=0 pos=(290,620) //Hide menu off screen
    
    <set_pad_back_event> = 0
	if not GotParam no_pad_left_right
		if not GotParam select_sponsor
			if not GotParam select_team
				if not GotParam no_pad_back
					<set_pad_back_event> = 1
					SetScreenElementProps {
							id=chap_menu
							event_handlers=[
								{ pad_back	generic_menu_pad_back params={ callback=chapter_menu_exit  } }
							]
							replace_handlers
					}
				endif
	
				SetScreenElementProps {
						id=chap_menu
						event_handlers=[
							{ pad_l1		toggle_current_chapter params={ reverse no_pad_back=<no_pad_back> } }
							{ pad_r1		toggle_current_chapter params={  no_pad_back=<no_pad_back> } }
						]
						replace_handlers
				}
			
				SetScreenElementProps {
					id=chap_menu
					event_handlers = [ 	
						{ pad_left		toggle_current_chapter params={ reverse no_pad_back=<no_pad_back> } }
						{ pad_right		toggle_current_chapter params={ no_pad_back=<no_pad_back> } }
					]
					replace_handlers
				}
			endif
		endif
	endif
	
	if ( <set_pad_back_event> = 0 )
		kill_start_key_binding
		SetScreenElementProps {
			id=chap_menu
			event_handlers = [
				{ pad_back			generic_menu_buzzer_sound }
				;{ pad_start			generic_menu_buzzer_sound } //pausing would exit the chapter menu
			]
			replace_handlers
		}
	endif
	
	AssignAlias id=chapter_menu_anchor alias=current_menu_anchor
    
	if ( ( GotParam select_sponsor ) || ( GotParam select_team ) || ( GotParam no_pad_back ) )
		create_helper_text { helper_text_elements=[ 	{ text="\b7/\b4 = Select" }
														{ text="\m0 = Accept" }
												  ]
							 no_bar
						   }		
	else
		create_helper_text { helper_text_elements=[ 	{ text="\b7/\b4 = Select" }
														{ text="\m1 = Back" }
														{ text="\m0 = Accept" }
												  ]
							 no_bar
						   }
	endif
	
	if ( GotParam select_sponsor ) 
		if LevelIs load_boardshop
			;SpawnScript set_boardshop_cam
		endif
	endif
					   
    kill_start_key_binding
	
    // add menu items!
	GetArraySize (CHAPTER_GOALS[(current_chapter-1)])
	num_stages=<array_size>
	stage=0
	
	begin
		GetArraySize ((CHAPTER_GOALS[(current_chapter-1)])[<stage>])
		index=0
		begin
			<status> = 0
			chapter_menu_get_status {	
										goal_info=( ( ( CHAPTER_GOALS[( current_chapter - 1 )] )[<stage>] )[<index>] )
										stage=<stage>
									}
			
			focus_script=goal_focus
			unfocus_script=goal_unfocus
			
			focus_params={
				goal_id = ( ( ( ( CHAPTER_GOALS[( current_chapter - 1 )] )[<stage>] )[<index>]).goal_id )
				targetOffset = ( ( ( ( CHAPTER_GOALS[( current_chapter - 1 )] )[<stage>] )[<index>]).targetOffset )
				positionOffset = ( ( ( ( CHAPTER_GOALS[( current_chapter - 1 )] )[<stage>] )[<index>]).positionOffset )
				no_ped_cam = ( ( ( ( CHAPTER_GOALS[( current_chapter - 1 )] )[<stage>] )[<index>]).no_ped_cam )
			}
            
            switch <status>
				case 0 // incomplete
					RemoveParameter text_rgba
					GoalManager_GetCurrentChapterAndStage
					if (<currentChapter> > ( current_chapter - 1 ))
						text_alpha=0.5
					else
						if ((<currentChapter> = ( current_chapter - 1 )) && (<currentStage> > <stage>))
							text_alpha=0.5
						else
							RemoveParameter text_alpha
						endif 
					endif
				case 1 // complete
					RemoveParameter text_rgba
					text_alpha=0.5
					cross_it_out=cross_it_out
				case 2 // locked
					text_rgba=[50 50 50 100]
					highlighted_text_rgba=[0 0 0 0]
					RemoveParameter text_alpha
					not_focusable=not_focusable
				case 3 // final unlocked
					text_rgba=<final_off>
					highlighted_text_rgba=<final_on>
					RemoveParameter text_alpha
					focus_script=final_goal_focus
					unfocus_script=final_goal_unfocus
				case 4 // final complete
					text_rgba=<final_off>
					highlighted_text_rgba=<final_on>
					text_alpha=0.5
					cross_it_out=cross_it_out
				case 5 // final locked
					text_rgba=[50 50 50 100]
					highlighted_text_rgba=[0 0 0 0]
					RemoveParameter text_alpha
					not_focusable=not_focusable
			endswitch
			
			
			// hack to skip pros not in your team when looking at the team
			// menu but not selecting a new team
			<should_show_item> = 1
			if GotParam select_sponsor
				<sponsor_struct> = ( ( ( CHAPTER_GOALS[ ( current_chapter - 1 ) ] )[<stage>] )[<index>] )
				if StructureContains structure=<sponsor_struct> replay_videos
					pad_choose_script = select_sponsor_play_movies 
					pad_choose_params = { select_sponsor=select_sponsor }
				else
					pad_choose_script = select_sponsor_choose
					pad_choose_params = { sponsor=( <sponsor_struct>.sponsor )}
				endif
			else
				if GotParam select_team
					<pro_struct> = ( ( ( CHAPTER_GOALS[ ( current_chapter - 1 ) ] )[<stage>] )[<index>] )
					pad_choose_script = select_team_choose
					pad_choose_params = { pro=( <pro_struct>.pro ) }
					<id> = ( <pro_struct>.pro )
					value = 0
					check = check
				else					
					// don't let them highlight sponsors at the wrong time
					if ( current_chapter = 10 )
						not_focusable = not_focusable
						if ( ( <index> = (<array_size>-1) ) && ( <stage> = (<num_stages>-1) ) )
							RemoveParameter not_focusable
						endif
					endif
					
					if ( current_chapter = 25 )						
						not_focusable = not_focusable
						GoalManager_GetTeam
						<pro_struct> = ( ( ( CHAPTER_GOALS[ ( current_chapter - 1 ) ] )[<stage>] )[<index>] )
						if not StructureContains structure=<team> ( <pro_struct>.pro )
							<should_show_item> = 0
						endif							
					endif
	
					if ( ( current_chapter = 10 ) && ( ( <index> = (<array_size>-1) ) && ( <stage> = (<num_stages>-1) ) ) )
						pad_choose_script = select_sponsor_play_movies
						pad_choose_params = { select_sponsor=select_sponsor return_to_level}
					else
						if LevelIs ( (CHAPTER_LEVELS[( current_chapter-1 )]).checksum )
							pad_choose_script=chapter_menu_start_goal
							pad_choose_params={ goal_id=( ( ( ( CHAPTER_GOALS[( current_chapter-1 )] )[<stage>])[<index>] ).goal_id ) }
						else
							pad_choose_script=chapter_menu_change_level_and_start_goal
							if StructureContains structure=( ( ( CHAPTER_GOALS[( current_chapter-1 )] )[<stage>])[<index>] ) level
								if LevelIs ( ( ( ( CHAPTER_GOALS[( current_chapter-1 )] )[<stage>])[<index>] ).level )
									pad_choose_script=chapter_menu_start_goal
									pad_choose_params={ goal_id=( ( ( ( CHAPTER_GOALS[( current_chapter-1 )] )[<stage>])[<index>] ).goal_id ) }
								else
									pad_choose_params={	
										goal_id=( ( ( ( CHAPTER_GOALS[( current_chapter-1 )] )[<stage>])[<index>] ).goal_id )
										level=( ( ( ( CHAPTER_GOALS[( current_chapter-1 )] )[<stage>])[<index>] ).level )
									}
								endif
							else
								pad_choose_params={	
									goal_id=( ( ( ( CHAPTER_GOALS[( current_chapter-1 )] )[<stage>])[<index>] ).goal_id )
									level=( (CHAPTER_LEVELS[( current_chapter-1 )]).checksum )
								}
							endif
						endif
					endif
				endif
			endif
			
			if ( ( <index> = (<array_size>-1) ) && ( <stage> = (<num_stages>-1) ) )
				// final goal / last item
				if ( <should_show_item> = 1 )
					chapter_goal_add_item {	text=((((CHAPTER_GOALS[(current_chapter-1)])[<stage>])[<index>]).text)
											pad_choose_script=<pad_choose_script>
											pad_choose_params=<pad_choose_params>
											id=final_goal_item
											text_rgba=<text_rgba>
											text_alpha=<text_alpha>
											line_rgba=<text_rgba>
											last_menu_item=1
											highlighted_text_rgba=<highlighted_text_rgba>
											cross_it_out=<cross_it_out>
											focus_script=<focus_script>
											unfocus_script=<unfocus_script>
											focus_params=<focus_params>
											not_focusable=<not_focusable>
											<check>
											value=<value>
										}
				endif
				if ( <status> = 3 ) 
					// show final star
					GetStackedScreenElementPos X id={ final_goal_item child=0 } offset=(25,18)
					CreateScreenElement {
						type=SpriteElement
						parent=final_goal_item
						
						texture=final
						scale=(1.0,1.0)
						rgba=<text_rgba>
						alpha=<text_alpha>
						pos=<pos>
					}
					RemoveParameter id
				endif
			else
                if ( <should_show_item> = 1 )
					chapter_goal_add_item {	text=((((CHAPTER_GOALS[(current_chapter-1)])[<stage>])[<index>]).text)
											pad_choose_script=<pad_choose_script>
											pad_choose_params=<pad_choose_params>
											text_rgba=<text_rgba>
											text_alpha=<text_alpha>
											cross_it_out=<cross_it_out>
											focus_script=<focus_script>
											unfocus_script=<unfocus_script>
											focus_params=<focus_params>
											not_focusable=<not_focusable>
											id=<id>
											<check>
											value=<value>
										}
				endif
			endif
			RemoveParameter not_focusable
			RemoveParameter cross_it_out
			RemoveParameter focus_script
			RemoveParameter unfocus_script
			index = ( <index> + 1 )
		repeat <array_size>
		stage = ( <stage> + 1 )
	repeat <num_stages>
	
	if ( current_chapter = 25 )
		;SetScreenElementProps id=chap_scrolling_menu reset_window_top
		
		if GotParam select_team
			pad_choose_params = { new_team }
			not_focusable=not_focusable		
			
			chapter_goal_add_item {	
				text="Done"
				pad_choose_script=select_team_done
				pad_choose_params=<pad_choose_params>
				text_rgba=<text_rgba>
				text_alpha=<text_alpha>
				; cross_it_out=<cross_it_out>
				focus_script=<focus_script>
				unfocus_script=<unfocus_script>
				focus_params=<focus_params>
				not_focusable=<not_focusable>
				id=select_team_done_item
			}
		endif
	endif
	
	
	// status text
    FormatText ChecksumName=unhighlight_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
    CreateScreenElement {
		type=ContainerElement
		parent=chap_menu
		not_focusable
	}
	status_text_pos=(645,365)
    
	calculate_chapter_goals_to_continue
	if ( <goals_to_continue> > 0 )
		if (<goals_to_continue> = 1)
			FormatText textname=continue_text "Complete \c2%g\c0 more goal to continue..." g=<goals_to_continue>
		else
			FormatText textname=continue_text "Complete \c2%g\c0 more goals to continue..." g=<goals_to_continue>
		endif
	else
		continue_text=""
	endif
	
    CreateScreenElement {
		type=TextElement
		parent=<id>
		
        text=<continue_text>
		pos=<status_text_pos>
		font=small
		rgba=<unhighlight_rgba>
		just=[right center]
		scale=0.8
		z_priority=4
		
	}
endscript

script calculate_chapter_goals_to_continue
    // figure number of goals needed for this chapter
	GetArraySize (CHAPTER_NUM_GOALS_TO_COMPLETE[(current_chapter-1)])
	num_stages=<array_size>
	
	GoalManager_GetCurrentChapterAndStage
	
	goals_needed=0
	goals_beaten=0
	index=0
	
    // are we past this chapter?
	if ( <currentChapter> > (current_chapter - 1) )
		 return goals_to_continue=0
    endif
	
	GetArraySize (CHAPTER_NUM_GOALS_TO_COMPLETE[(current_chapter-1)])
    if ( <currentStage> > (<array_size>-1) )
		return goals_to_continue=0
	endif
    printf "current_chapter = %i currentChapter=%j currentStage=%k" i=current_chapter j=<currentChapter> k=<currentStage>
    
	goals_needed = ( ((CHAPTER_NUM_GOALS_TO_COMPLETE[(current_chapter-1)])[<currentStage>]) )
        
	// get number of goals beaten in this chapter
	GetArraySize ( ( CHAPTER_GOALS[( current_chapter - 1 )] )[<currentStage>] )
	index=0
	begin
		goal_info = ( ( ( CHAPTER_GOALS[( current_chapter - 1 )] )[<currentStage>] )[<index>] )
		goal_id = ( <goal_info>.goal_id )
		if GotParam goal_id
			if GoalManager_HasWonGoal name=<goal_id>
				goals_beaten = ( <goals_beaten> + 1 )
			endif
		else
			return goals_to_continue=0
		endif
		index = ( <index> + 1 )
	repeat <array_size>
    
	
	// return the difference
	goals_to_continue = ( <goals_needed> - <goals_beaten> )
	return goals_to_continue=<goals_to_continue>
endscript

script build_chapter_box_menu pos=(320,395) parent=current_menu_anchor
    if ScreenElementExists id=chap_box_menu
		DestroyScreenElement id=chap_box_menu
	endif
	 
	locked_color=[53 72 100 80]
	FormatText ChecksumName=unlocked_color "%i_SPEECH_BOX_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// anchor
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=chap_box_menu
		just=[center center]
		
		pos=(320, 229)
		dims=(640, 480)
	}
	
	// bg bar
	CreateScreenElement {
		type=SpriteElement
		parent=chap_box_menu
		
		texture=filmstripbar
		rgba=<unlocked_color>
		just=[center center]
		pos=<pos>
		scale=(20,1)
		z_priority=6
                alpha=.4
	}
	
	// left arrow
	CreateScreenElement {
		type=SpriteElement
		parent=chap_box_menu
		
		texture=left_arrow
		rgba=<unlocked_color>
		just=[right center]
		pos=(80,395)
		scale=(1.25,0.8)
		alpha=0.6
		z_priority=8
	}
	
	// right arrow
	CreateScreenElement {
		type=SpriteElement
		parent=chap_box_menu
		
		texture=right_arrow
		rgba=<unlocked_color>
		just=[left center]
		pos=(560,395)
		scale=(1.25,0.8)
		alpha=0.6
		z_priority=8
	}
	
	// L1
	CreateScreenElement {
		type=TextElement
		parent=chap_box_menu
		id=chap_l1
		
		text="\be"
		font=small
		;rgba=<unlocked_color>
		just=[right center]
		pos=(55,395)
		scale=.95
		alpha=0.5
		z_priority=7
	}
	
	// R1
	CreateScreenElement {
		type=TextElement
		parent=chap_box_menu
		id=chap_r1
		
		text="\bf"
		font=small
		;rgba=<unlocked_color>
		just=[left center]
		pos=(583,395)
		scale=.95
		alpha=0.5
		z_priority=7
	}
	
	// main hmenu to hold everything
	CreateScreenElement {
		type=HMenu
		id=chap_box_hmenu
		parent=chap_box_menu
		
		pos=<pos>
		just=[center center]
		spacing_between=-7
	}
	
	GetArraySize CHAPTER_STATUS
    chapter_index=0
	begin
		status = ( CHAPTER_STATUS[<chapter_index>] )
		
		switch <status>
			case 0
				dot_texture=chap_dot
				box_color=<locked_color>
                                
			case 1
				dot_texture=chap_dot
				box_color=<unlocked_color>
                                
			case 2
				dot_texture=chap_dot_done
				box_color=<unlocked_color>
                                
		endswitch
		
		if ( <chapter_index> = ( current_chapter - 1 ) )
			dot_texture=chap_dot_highlight
			box_color=<highlight_color>
                        
		endif
		
		CreateScreenElement {
			type=SpriteElement
			parent=chap_box_hmenu
			
			texture=<dot_texture>
			rgba=<box_color> 
			just=[center center]
			scale=(0.60,1.0)
			z_priority=7
		}
		if ( <chapter_index> = ( current_chapter - 1 ) )
			current_dot=<id>
		endif
		
		chapter_index = ( <chapter_index> + 1 )
	repeat <array_size>
	SpawnScript Chapter_menu_pad_Left_or_Right_Sound
	SpawnScript chapter_dot_effect params={ id=<current_dot> }
	
endscript

////////////////////////////////////////////
// add item / focus scripts

script chapter_goal_add_item
	scale=0.9
	;centered=1
	dark_menu=dark_menu
	no_bg=no_bg
	static_width=static_width
	highlight_bar_scale=(9,0.7)
	highlight_bar_pos=(190, -7)
	z_priority = 5 //make sure the text & highlight bar are above the chapter graphic
	text_just=[left center]
	
    if GotParam check
		theme_menu_add_checkbox_item <...> no_sound
	else
		theme_menu_add_item <...>
	endif
endscript

script goal_focus
    main_theme_focus <...>
	
    if not ( (current_chapter=10) || (current_chapter=25) || (current_chapter=26) )
        if LevelIs ( (CHAPTER_LEVELS[(current_chapter-1)]).checksum )
            chapter_menu_play_preview_cam <...>
		endif
	endif
endscript

script goal_unfocus
	main_theme_unfocus <...>
	
	GetTags
	if GotParam goal_id
		;chapter_menu_kill_preview_cam <...>
	endif
endscript

script final_goal_focus
        
	goal_focus <...>
	
	GetTags
	
	DoScreenElementMorph {
		id={ <id> child=4 }
		time=0.12
		rgba=<highlighted_text_rgba>
		scale=1.25
		rot_angle=360
		relative_scale
	}
endscript

script final_goal_unfocus
	goal_unfocus <...>
	
	GetTags
	DoScreenElementMorph {
		id={ <id> child=4 }
		time=0.2
		rgba=<text_rgba>
		alpha=<text_alpha>
		scale=1
		;rot_angle=0
		relative_scale
	}
	DoScreenElementMorph {
		id={ <id> child=4 }
		time=0
		rot_angle=0
	}
endscript

script chapter_menu_play_preview_cam
    KillSkaterCamAnim current
	menu_cam:unpause
	
	GoalManager_GetGoalParams name=<goal_id>
	
	if IsAlive name=<trigger_obj_id>
		if GotParam no_ped_cam
			// Use specified camera
			printf "using special camera"
            if GotParam positionOffset
				Menu_Cam:Obj_SetPosition Position=<positionOffset>
			else
				Menu_Cam:Obj_SetPosition Position=(0,100,0)
			endif
			Menu_Cam:Obj_SetOrientation Y=45
			SetActiveCamera id=Menu_Cam
			
            SetSkaterCamAnimShouldPause name=<goal_id> should_pause=0
			return
		else
			// use ped default camera
			printf "using default ped camera"
			<trigger_obj_id>:Obj_GetPosition
			Menu_Cam:Obj_SetPosition Position=( <pos> + (60,40,150) )
			Menu_Cam:Obj_SetOrientation Y=45 
			SetActiveCamera id=Menu_Cam
			
            SetSkaterCamAnimShouldPause name=<goal_id> should_pause=0
			return
		endif
	endif
    
	// use level camera
	if LevelIs load_nj
		Position=(-406.953491,263.012241,3691.416748)
		x=0.982204 Y=0.178771 z=0.057588
	endif
	
	if LevelIs load_ny
		Position=(116.953491,533.012241,91.416748)
		x=0.982204 Y=0.178771 z=0.057588
	endif
	
	if LevelIs load_fl
		Position=(216.953491,233.012241,2791.416748)
		x=0.982204 Y=0.178771 z=0.057588
	endif
	
	if LevelIs load_sd
		Position=(-3016.953491,433.012241,-3391.2416748)
		x=0.982204 Y=0.178771 z=0.057588
	endif
	
	if LevelIs load_hi
		Position=(616.953491,353.012241,7791.6416748)
		x=0.982204 Y=0.178771 z=0.057588
	endif
	
	if LevelIs load_vc
		Position=(616.953491,633.012241,2791.7416748)
		x=0.982204 Y=0.178771 z=0.057588
	endif
	
	if LevelIs load_sj
		Position=(116.953491,-493.012241,991.416748)
		x=0.982204 Y=0.178771 z=0.057588
	endif
	
	if LevelIs load_ru
		Position=(616.953491,933.012241,2791.8416748)
		x=0.982204 Y=0.178771 z=0.057588
	endif
	
	if LevelIs load_se
		Position=(616.953491,33.012241,2791.416748)
		x=0.982204 Y=0.178771 z=0.057588
	endif
	
	printf "using level camera"
    Menu_Cam:Obj_SetPosition Position=<position>
	Menu_Cam:Obj_SetOrientation x=<x> y=<y> z=<z>
    SetActiveCamera id=Menu_Cam
    
endscript

/*script chapter_menu_kill_preview_cam
	GetSkaterId
	KillSkaterCamAnim skater=<objId> name=<goal_id>
endscript*/

///////////////////////////////////////////////////////
// menu update scripts

script update_chapter_menu
	// menu
	build_chapter_goal_list_menu no_pad_back=<no_pad_back>
	
	// chapter select bar
	build_chapter_box_menu
	
    // text
    FormatText TextName=chap_text "CHAPTER %i: %l" i=current_chapter l=( (CHAPTER_LEVELS[(current_chapter-1)]).text )
	// chapter number
	SetScreenElementProps id=chap_number text=<chap_text>
    // chapter title
	if ObjectExists id=chap_title
		SetScreenElementProps id=chap_title text=( CHAPTER_TITLES[(current_chapter - 1)] )
		SetScreenElementProps id=chap_title2 text=( CHAPTER_TITLES[(current_chapter - 1)] )
	
	
		DoScreenElementMorph id=chap_title alpha=0 time=0
		DoScreenElementMorph id=chap_title2 alpha=0 time=0
		
		
		// chapter description
		DoScreenElementMorph id=chap_description alpha=0
		SetScreenElementProps id=chap_description text=( CHAPTER_DESCRIPTIONS[(current_chapter - 1)] )
	endif
	
	// chapter graphics
	FormatText checksumname=chapter_graphic "chap_graphic_%i" i=( (CHAPTER_LEVELS[(current_chapter-1)]).num )
	SetScreenElementProps id=chapter_graphic1 texture=<chapter_graphic>
	SetScreenElementProps id=chapter_graphic2 texture=<chapter_graphic>
	SetScreenElementProps id=chapter_graphic3 texture=<chapter_graphic>
	
	if LevelIs ( (CHAPTER_LEVELS[(current_chapter-1)]).checksum )
		DoScreenElementMorph id=graphic_anchor alpha=0
	else
    	DoScreenElementMorph id=graphic_anchor alpha=1
    endif
	
	if GotParam left
		menu_vert_blink_arrow id=chap_l1
	else
		if GotParam right
			menu_vert_blink_arrow id=chap_r1
		endif
	endif
	
	//Animate the parts in
    FireEvent type=focus target=chap_menu
	wait 20 gameframes
	
	pulse_blur start=200 speed=5
	
	if ObjectExists id=chap_title
		DoScreenElementMorph id=chap_title alpha=0.3 time=0.5
		DoScreenElementMorph id=chap_title2 alpha=0.15 time=0.75
	endif
	
    killspawnedscript name=play_chap_sound
    if ScreenElementExists id=chap_menu
		spawnscript play_chap_sound
		DoScreenElementMorph id=chap_menu time=0.2 pos=(290,232)
	endif
	
	if ScreenElementExists id=chap_description
		TerminateObjectsScripts id=chap_description use_proper_version
		RunScriptOnScreenElement id=chap_description DoMorph params={ alpha=1 time=0.5 }
	endif
endscript

script toggle_current_chapter
	if GotParam reverse
		if ( (current_chapter - 1) > 0 )
            change current_chapter=(current_chapter - 1)
            
			/*if (DEMO_BUILD)
				if ( (current_chapter = 4) || (current_chapter = 5) || (current_chapter = 6) )
					change current_chapter = 3
				endif
			endif */
			
            update_chapter_menu left no_pad_back=<no_pad_back>
		endif
	else
		GetArraySize CHAPTER_STATUS
		if ( <array_size> > current_chapter )
			if ( CHAPTER_STATUS[current_chapter] > 0 )
				change current_chapter=(current_chapter + 1)
				/*
				if (DEMO_BUILD)
					if ( (current_chapter = 4) || (current_chapter = 5) || (current_chapter = 6) )
						change current_chapter = 7
					endif
				endif
				*/
                update_chapter_menu	right no_pad_back=<no_pad_back>
			endif
		endif
	endif
endscript

///////////////////////////////////////////////////////
// event handling scripts

script chapter_menu_start_goal
	FireEvent type=unfocus target=chap_menu
	if GotParam goal_id
		change check_for_unplugged_controllers = 0
		chapter_menu_exit exit
		change check_for_unplugged_controllers = 0
		GoalManager_DeactivateAllGoals
		SetSfxReverb 0 mode = REV_MODE_CAVE
		goal_accept_trigger goal_id=<goal_id> force_start init
		; change check_for_unplugged_controllers = 1
	endif
;	GoalManager_ActivateGoal name=<goal_id>
endscript

script chapter_menu_change_level_and_start_goal
    
	// kill chapter menu spawn scripts
	KillSpawnedScript name=chap_moving_bg
	KillSpawnedScript name=spawnscrip chap_new_rotating_bg
	KillSpawnedScript name=spawnscrip chap_new_rotating_bg_2
	KillSpawnedScript name=chap_graphic_crossfade
    KillSpawnedScript name=fadetoblack
	
	// destroy menu
    if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	if ScreenElementExists id=fade_out_anchor
		DestroyScreenElement id=fade_out_anchor
	endif
    kill_blur start=0
	
	// unload chapter menu textures
	load_chapter_textures_to_main_memory unload
    
	// set flag to start goal in new level
	if GotParam goal_id
		array_name=change_level_goal_id
		SetArrayElement ArrayName=array_name index=0 newvalue=<goal_id>
	endif
	
	// change level to proper level
	GoalManager_DeactivateAllGoals
	change_level level=<level>
endscript

change_level_goal_id = [ null ]


//////////////////////////////////////////////////
// Effects

// this bastard keeps repeating! make it stop!
script play_chap_sound
	wait 12 gameframes
	StopSound ChapterMenuFlyUpSound
	wait 2 gameframes
	;PlaySound DE_MenuFlyUp id=ChapterMenuFlyUpSound vol=100
	PlaySound DE_PauseFlyIn id=ChapterMenuFlyUpSound pitch=300 vol=50
endscript

script chapter_dot_effect
	FormatText ChecksumName=text_color "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=twitch_color "%i_TEXT_TWITCH_VALUE" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	begin
        if not ScreenElementExists id=<id>
			break
		endif
		DoScreenElementMorph id=<id> time=.03 scale=1.075 relative_scale rgba=<twitch_color> alpha=1
        wait 2 gameframe
        if not ScreenElementExists id=<id>
			break
		endif
		DoScreenElementMorph id=<id> time=.01 scale=1 relative_scale rgba=<text_color> alpha=1
        wait 0.23 seconds
	repeat
endscript

script chap_graphic_crossfade
	begin
		DoScreenElementMorph id=chapter_graphic1 alpha=0.15 time=3.0
		DoScreenElementMorph id=chapter_graphic2 alpha=1.0 time=3.0
        wait 3 seconds
		DoScreenElementMorph id=chapter_graphic1 alpha=1.0 time=3.0
		DoScreenElementMorph id=chapter_graphic2 alpha=0.4 time=4.0
		wait 3 seconds
	repeat
endscript

script chap_moving_bg
    GetScreenElementDims id=moving_bg
    
	// calcualte the distance to scroll
	end_x = ( <width> - 640 )
	fade_in_x = (<end_x> / 20 )
	scroll_x = ( <end_x> - <fade_in_x> )
	
	end_pos = ( <end_x> * (-1,0) + (0,100) )
	fade_in_pos = ( <fade_in_x> * (-1,0) + (0,100) )
	scroll_pos = ( <scroll_x> * (-1,0) + (0,100) )
	
	begin
		// fade in (while scrolling)
		DoScreenElementMorph id=moving_bg alpha=1 time=0.5 pos=<fade_in_pos>
		wait 0.5 seconds
		
		// scroll it
		DoScreenElementMorph id=moving_bg time=9.0 pos=<scroll_pos>
        wait 8.5 seconds
		
		// fade out (still scrolling)
		DoScreenElementMorph id=moving_bg alpha=0 time=0.5 pos=<end_pos>
		wait 0.5 seconds
		
		// reset scroll
		DoScreenElementMorph id=moving_bg pos=(0,100) time=0
	repeat
endscript

// huge rotating vector piece
script chap_new_rotating_bg id=rotating_bg_new time=640.0 alpha1=0.275 alpha2=0.35 scale=2.0 rot_angle=5752
	if ScreenElementExists id=<id>
		GetScreenElementDims id=<id>
        DoScreenElementMorph id=<id> time=0 rot_angle=0 scale=<scale>
		wait 1 gameframe
		begin
			if ScreenElementExists id=<id>
				DoScreenElementMorph id=<id> alpha=<alpha2> time=(<time>/2) rot_angle=(<rot_angle>/2) scale=1.125 relative_scale
				wait (<time>/2) seconds
			else
				break
			endif
			
			if ScreenElementExists id=<id>
				DoScreenElementMorph id=<id> alpha=<alpha1> time=(<time>/2) rot_angle=<rot_angle> scale=1.0 relative_scale
				wait (<time>/2) seconds
			else
				break
			endif
		repeat
	endif
endscript  

 																  
// secondary rotating vector piece
script chap_new_rotating_bg_2 time=2000.0 id=rotating_bg_new_2 alpha1=0.28 alpha2=0.3 scale=2.2
    chap_new_rotating_bg <...>
endscript

script create_chapter_fade_piece
	SetScreenElementLock off id=root_window
	CreateScreenElement {
		type=ContainerElement
        parent=root_window
        id=fade_out_anchor
		pos=(320,240)
		dims=(640,480)
		alpha=0
	}
    
    build_top_and_bottom_blocks static double parent=fade_out_anchor top_z=1001 bot_z=1001 ;rgba=[10 10 10 128]
	
    CreateScreenElement {
		type=SpriteElement
		parent=fade_out_anchor
        
		texture=white2
		rgba=[0 0 0 40]
		just=[left top]
		pos=(0,0)
		scale = (84,60)
		z_priority=1000
	}
	
	CreateScreenElement {
		type=SpriteElement
		parent=fade_out_anchor
        
		texture=white2
		rgba=[0 0 0 70]
		just=[left top]
		pos=(0,0)
		scale = (84,60)
		z_priority=1010
	}
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// status 0=incomplete, 1=complete, 2=locked 3=final unlocked 4=final complete 5=final locked
script chapter_menu_get_status
	status = 0
	goal_id = ( <goal_info>.goal_id )
	
	// is goal locked?
	GoalManager_GetCurrentChapterAndStage
    if ( <currentchapter> > (current_chapter-1) )
		locked=0
	else
		if ( <currentchapter> = (current_chapter-1) )
			if ( (<currentStage> > <stage>) || (<currentStage> = <stage>) )
				locked=0
			else
				locked=1
			endif
		else
			locked=1
		endif
	endif
	
	/*// have they talked to this ped yet?
	if not GoalManager_HasSeenGoal name=<goal_id>
		locked=1
	endif*/
    
	// cheat
	if ( dont_lock_goals = 1 )
		locked=0
	endif
	
	// set proper status
    if GotParam goal_id
		if StructureContains final structure=<goal_info>
			if ( <locked> = 1 )
				<status> = 5
			else
				if GoalManager_HasWonGoal name=<goal_id>
					<status> = 4
				else
					<status> = 3
				endif
			endif
		else
			if ( <locked> = 1 )
				<status> = 2
			else
				if GoalManager_HasWonGoal name=<goal_id>
					<status> = 1
				else
					<status> = 0
				endif
			endif
		endif
	endif
	;printf "status = %i locked=%l" i=<status> l=<locked>
	return status=<status>
endscript

script create_chapter_intro_title chapter=18
	FormatText ChecksumName=rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	SetScreenElementLock off id=root_window
	
	// container
	CreateScreenElement {
		type=containerElement
		parent=root_window
		id=chapter_intro_title
		
		pos=(320,320)
		alpha=0
	}
	anchor_id=<id>
	
	// chapter
	FormatText textName=chapter_text "CHAPTER %i:" i=<chapter>
	CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		font=testtitle
		pos=(0,0)
		scale=1.5
		just=[center center]
		text=<chapter_text>
		rgba=[100 100 100 100]
	}
	GetScreenElementDims id=<id>
	widest=<width>
	
    // description
	CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		font=testtitle
		pos=(0,20)
		scale=1.5
		just=[center center]
		text=( CHAPTER_TITLES[(<chapter>-1)] )
		rgba=<rgba>
	}
    
	FormatText ChecksumName=bracket_texture "%i_sub_frame" i=(THEME_PREFIXES[current_theme_prefix])
	
	GetScreenElementDims id=<id>
	if ( <width> > <widest> )
		widest = <width>
	endif
	
	pos1=( (<widest>/2)*(1,0) + (-10,5) )
	pos2=( (<widest>/2)*(-1,0) + (14,14) )
	
    // right bracket
	;GetStackedScreenElementPos X id=<id> offset=(-10,5)
	CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
		
		texture=<bracket_texture>
		pos=<pos1>
        scale=(1,1)
        rot_angle=180
	}
	
    // left bracket
    CreateScreenElement {
		type=SpriteElement
		parent=<anchor_id>
        
		texture=<bracket_texture>
		pos=<pos2>
        scale=(1,1)
	}
	
	DoScreenElementMorph id=chapter_intro_title alpha=0.7 time=1.0
		
endscript

script hide_chaper_intro_title
	if ObjectExists id=chapter_intro_title
		DoScreenElementMorph id=chapter_intro_title time=0 scale=0
	endif
endscript

script unhide_chaper_intro_title
	if ObjectExists id=chapter_intro_title
		DoScreenElementMorph id=chapter_intro_title time=0 scale=1
	endif
endscript

//Spawnscript kill_chapter_intro_title 
script kill_chapter_intro_title time=1.0
	if ScreenElementExists id=chapter_intro_title
		DoScreenElementMorph id=chapter_intro_title alpha=0 time=<time>
		wait <time> seconds
		DestroyScreenElement id=chapter_intro_title
	endif
endscript

script Chapter_menu_pad_Left_or_Right_Sound
PlaySound MenuUp
endscript

