// sponsor selection scripts

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script select_sponsor_play_movies
	// play all of the sponsor deck videos
	;printstruct<...>
	// pre-movie cleanup
	if ScreenElementExists id=chapter_menu_anchor
		chapter_menu_exit exit
	endif

	GetCurrentLevel
	<oldLevel> = <level>

	goalmanager_levelunload
	cleanup preserve_skaters                ; unload all level, except for skaters
	KillMessages                            ; clean up any messages on screen
	DisablePause                            ; make sure to not let them pause mid movie
	mempushcontext 0
	DisplayLoadingScreen "loadscrn_generic"
	mempopcontext

	// play movies
	if GotParam select_sponsor
		movies = [
			"teasers\bird"
			"teasers\element"
			"teasers\flip"
			"teasers\girl"
			"teasers\zero"
		]
	else
		if GotParam show_team_movies
			GoalManager_GetTeam
			printstruct <team>
		endif
	endif
	<index> = 0

	if GotParam select_sponsor
		GetArraySize <movies>
	else
		GetArraySize pro_team_members
	endif

	if not ( <array_size> > 0 )
		printf "wtf?"
		return
	else
		begin
			if GotParam select_sponsor
				// playmovie_script is a wrapper around
				// playmovie that unloads the anims to
				// free up memory and reloads them back in
				playmovie_script ( <movies>[<index>] )
			else
				// figure the movie name
				if StructureContains structure=<team> ( ( pro_team_members[<index>] ).pro )
					<movie_name> = ( "movies\\" + ( ( pro_team_members[<index>] ).movie_text ) )
					; printf "figured movie name %s" s=<movie_name>

					// playmovie_script is a wrapper around
					// playmovie that unloads the anims to
					// free up memory and reloads them back in
					playmovie_script <movie_name>
				endif
			endif
			<index> = ( <index> + 1 )
		repeat <array_size>
	endif

	// post movie cleanup
	mempushcontext 0
	DisplayLoadingScreen "loadscrn_generic"
	mempopcontext
	GetCurrentLevel             ; returns level = load_????    (e.g. load_rio)
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if GotParam show_team_movies
		<next_level_script>=select_team_movies_done
		level=load_nj
	else
		if GotParam select_sponsor
			<next_level_script>=select_sponsor_select_after_movies
			level=load_boardshop
		else
			<next_level_script>=select_sponsor_movies_done
		endif
	endif

	if GotParam return_to_level
		change_level {
			level=<oldLevel>
			next_level_script=select_sponsor_movies_done
		}
	else
		change_level {
			level=<level>
			next_level_script=<next_level_script>
		}
	endif

endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script select_sponsor_choose
	// remember sponsor
	GoalManager_SetSponsor <sponsor>

	chapter_menu_exit exit
	pauseGame
	GoalManager_HidePoints
	GoalManager_HideGoalPoints

	unpausegame
	SpawnScript set_boardshop_cam

	// set the theme
	GoalManager_GetSponsor
	switch <sponsor>
		case sponsor_birdhouse
			theme_num = 6
			<team_name> = "Birdhouse"
			Change_Clothes part_id=#"Birdhouse Team"
		case sponsor_element
			theme_num = 7
			<team_name> = "Element"
			Change_Clothes part_id=#"Element Team"
		case sponsor_flip
			theme_num = 8
			<team_name> = "Flip"
			Change_Clothes part_id=#"Flip Team"
		case sponsor_girl
			theme_num = 9
			<team_name> = "Girl"
			Change_Clothes part_id=#"Girl Team"
		case sponsor_zero
			theme_num = 10
			<team_name> = "Zero"
			Change_Clothes part_id=#"Zero Team"
		default
			printstruct <...>
			script_assert "wtf?"
	endswitch
	// make spiffy text for the dialog box below that references your actual team name
	FormatText TextName=DialogBox_Text "Welcome to %t! Gear up, and then you'll be flown out to San Diego to meet the rest of your team." t=<team_name>
	// back to the game
	set_current_theme theme_num=<theme_num> new_sponsor

	// do something!
	change unlock_sponsor_boards = 1

	create_dialog_box { title="New Decks Unlocked"
		text=<DialogBox_Text>
		just=[center center]

		buttons=[   { font=small text="Ok" 	pad_choose_script=select_sponsor_choose2 }
		]
		text_dims=(250,0)
	}
endscript

script select_sponsor_choose2
	GoalManager_GetCurrentChapterAndStage
	GoalManager_AdvanceStage force
	goal_mark_chapter_complete currentChapter=<currentChapter>
	dialog_box_exit
	launch_boardshop_menu
	; SD_IntroCutscene
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script select_sponsor_post_movies_cleanup
	PauseGame
	PauseSkaters
	; wait 1 gameframe
	// Don't move these next two lines. Thanks!!
	pause_trick_text
	pause_balance_meter
	pause_run_timer
	kill_blur

	// hide any speech boxes
	if ObjectExists id=speech_box_anchor
		DoScreenElementMorph id=speech_box_anchor scale=0
	endif
	if ScreenElementExists id=goal_start_dialog
		DestroyScreenElement id=goal_start_dialog
	endif
	if ObjectExists id=ped_speech_dialog
		DestroyScreenElement id=ped_speech_dialog
	endif
	if ObjectExists id=goal_retry_anchor
		DestroyScreenElement id=goal_retry_anchor
	endif

	GoalManager_HidePoints
	// hide goal hud stuff
	hide_goal_panel_messages
	GoalManager_PauseAllGoals
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script select_sponsor_select_after_movies
	select_sponsor_post_movies_cleanup

	// destroy skateshop menus
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	load_boardshop_textures_to_main_memory unload

	// show chapter menu with names of teams
	// and "play movies again" option
	restore_skater_camera
	launch_chapter_menu select_sponsor
	change dont_restore_start_key_binding = 0
	HideLoadingScreen
	change dont_unhide_loading_screen = 0
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script select_sponsor_movies_done
	; select_sponsor_post_movies_cleanup

	// show normal chapter menu
	; launch_chapter_menu
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script Sponsor_StageSwitch_SponsorChosen
	chapter_menu_exit exit

	// user selected team, load sd
	Sponsor_StageSwitch_GoingToSD_LevelChange
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script Sponsor_StageSwitch_GoingToSD_LevelChange
	instant_tod_change current_tod=day stop_tod=1
	change_level level=load_SD next_level_script=SD_IntroCutscene
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/*                    Select Team stuff!!!!!!                     */
/*                                                                */
/*                                                                */
/*                                                                */
/******************************************************************/

script select_team_choose
	GetTags
	if not GotParam value
		<value> = 0
	endif

	// make sure they haven't already picked five
	GoalManager_GetTeam
	if ( ( <num_team_members> = 5 ) && ( <value> = 0 ) )
		; printf "you've already got five!"
		generic_menu_buzzer_sound
		return
	else
		generic_menu_pad_choose_sound
	endif

	// don't let them say done until they pick five!
	if ( <num_team_members> < 5 )
		SetScreenElementProps id=select_team_done_item not_focusable rgba = [60 60 60 75]
		DoScreenElementMorph id={select_team_done_item child=0} rgba = [60 60 60 75]
	endif

	if ( <value> = 0 )
		DoScreenElementMorph id={ <id> child=4 } alpha=1
		<value> = 1
		GoalManager_SetTeamMember pro=<pro>
	else
		DoScreenElementMorph id={ <id> child=4 } alpha=0
		<value> = 0
		printf "removing pro %s" s=<pro>
		GoalManager_SetTeamMember pro=<pro> remove
	endif
	SetTags value=<value>
	GoalManager_GetTeam
	// don't let them say done until they pick five!
	if ( <num_team_members> < 5 )
		SetScreenElementProps id=select_team_done_item not_focusable
		DoScreenElementMorph id={select_team_done_item child=0} rgba = [60 60 60 75]
	endif

	if ( <num_team_members> = 5 )
		select_team_chosen_five
	endif
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script select_team_chosen_five
	FireEvent type=unfocus target=chap_vmenu
	SetScreenElementProps id=select_team_done_item focusable
	FireEvent type=focus target=chap_vmenu data={ child_id=select_team_done_item }
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script select_team_done
	//mark chapter 25 complete
	FireEvent type=unfocus target=chap_menu
	goal_mark_chapter_complete currentChapter=24

	if GotParam new_team
		chapter_menu_exit exit
		pauseGame
		hide_console_window
		GoalManager_HidePoints
		GoalManager_HideGoalPoints
		create_onscreen_keyboard {
			keyboard_done_script=team_selected_store_name
			keyboard_title="TEAM NAME"
			text=""
			min_length=1
			max_length=15
			no_back
		}
	else
		chapter_menu_exit
	endif
endscript

script team_selected_store_name
	GetTextElementString id=keyboard_current_string
	GoalManager_SetTeamName <string>
	destroy_onscreen_keyboard
	dialog_box_exit
	set_current_theme theme_num=5 story_swap
	team_selected_change_level
	// SP: removed by SP - this message is no longer needed. I am not sure what the next 2 lines do, but they caused a crash
	// when I removed the dialog box. Somebody should check that this is safe
	//pause_menu_gradient off
	//pause_menu_gradient on

	/*SetGlobalFlag flag=CAS_PARTS_UNLOCKED_5
	create_dialog_box { title="Unlocked"
						text="New clothes available!"
						just=[center center]

                        buttons=[   { font=small text="Ok" 	pad_choose_script=team_selected_change_level }
							    ]
						;delay_input
					  }	 	*/
endscript

script team_selected_change_level
	change_level level=load_boardshop next_level_script=select_team_play_cutscene
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script select_team_play_cutscene
	GoalManager_AdvanceStage force
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	load_boardshop_textures_to_main_memory unload
	PlayCutscene name="cutscenes\NJ_07.cut" exitScript=select_team_cutscene_done
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script select_team_cutscene_done
	SpawnScript select_team_cutscene_done2
endscript

script select_team_cutscene_done2
	launch_chapter_menu no_pad_back=1 no_pad_left_right
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/


script select_team_movies_done
	// There currently is no final cutscene, so checking this in for testing:
	UnPauseGame
	if NOT (GetGlobalFlag flag=LEVEL_UNLOCKED_SE)
		SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_09
		PlayCutscene name="cutscenes\NJ_09.cut" exitScript=Movies_StageSwitch_GoingToEricSave_FromMovie
	else
		SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_09_ALT
		PlayCutscene name="cutscenes\NJ_09_ALT.cut" exitScript=select_team_movies_done_Alt_ending
	endif
	//	PlayCutscene name="cutscenes\fINAL.cut" exitScript=NULLSCRIPT
endscript

script select_team_movies_done_Alt_ending
	goal_mark_chapter_complete currentChapter=26
	SK5_AdvanceStage
endscript