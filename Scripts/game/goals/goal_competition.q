// start autoduck documentation
// @DOC goal_competition
// @module goal_competition | None
// @subindex Scripting Database
// @index script | goal_competition


Goal_Comp_GenericParams = {
    goal_text="Competition test..."
	goal_description="3 Runs\nYou lose points for bailing\nBest two runs wins"
	view_goals_text="Medal the Competition"
    
    time=30
    
    init = goal_comp_init
	uninit = goal_uninit
    // active = goal_comp_active
    activate = goal_comp_activate
    deactivate = goal_comp_deactivate
    expire = goal_comp_expire
    // fail = goal_comp_fail
    success = goal_comp_success
    
    trigger_obj_id = TRG_G_JUDGE_COMP
    
    geo_prefix = "G_COMP_"
    
    restart_node = TRG_G_COMP_RestartNode
    start_pad_id = G_COMP_StartPad
	
	already_ended_run = 0
	competition
	record_type = score
}

Goal_Comp2_GenericParams = {
    goal_text="Competition2 test..."
	goal_description="3 Runs\nYou lose points for bailing\nBest two runs wins"
	view_goals_text="Medal the Competition"
    
    time=30
    
    init = goal_comp_init
	uninit = goal_uninit
    // active = goal_comp_active
    activate = goal_comp_activate
    deactivate = goal_comp_deactivate
    expire = goal_comp_expire
    // fail = goal_comp_fail
    success = goal_comp_success
    
    trigger_obj_id = TRG_G_JUDGE_COMP2
    
    geo_prefix = "G_COMP2_"
    
    restart_node = TRG_G_COMP2_RestartNode
    start_pad_id = G_COMP2_StartPad
		
	already_ended_run = 0
	competition
	record_type = score
}


script goal_comp_init
    // set up trigger
	; printf "Creating comp trigger"
	// create name=<trigger_obj_id>
    ; GoalManager_InitGoalTrigger name=<goal_id>
	goal_init goal_id=<goal_id>
endscript

script goal_comp_activate
	; printf "goal_comp_activate"
	GoalManager_EditGoal name=<goal_id> params={ already_ended_run = 0 }
	goal_start goal_id=<goal_id>
	
	// pause the comp for rules, movies.
	GoalManager_PauseCompetition name=<goal_id>
	
	if not CompetitionEnded
		EndCompetition
	endif
	
	if GotParam leader_board_names
		PermuteArray NewArrayName=leader_board_names Array=<leader_board_names>
	endif
	
	StartCompetition {
		gold=<gold>
		silver=<silver>
		bronze=<bronze>
		
		gold_score=<gold_score>
		silver_score=<silver_score>
		bronze_score=<bronze_score>
		
		bail=<bail>
		
		extra_params={ 
			leader_board_names=<leader_board_names>
			first_place_name=<first_place_name>
		}
	}
	
	SetScoreAccumulation 1
	StartCompetitionRun	
	Skater:RunStarted
	
   
	//create the nixon clock
	KillSpawnedScript name=KillNixonTimer
	wait .1 seconds
	
	if ObjectExists id=nixon_timer_box
		DestroyScreenElement id=nixon_timer_box
		wait .1 seconds
	endif
	
	CreateScreenElement {
		type=ContainerElement
		id=nixon_timer_box
		parent=root_window
		pos=(311,35)
	}
	
	CreateScreenElement {
		type=SpriteElement
		parent=nixon_timer_box
		id=nixon_timer_sprite
		texture=nixon
		scale=(1.7,1.7)
		just=[center center]
		z_priority=-2000
	}

	
	DoScreenElementMorph id=nixon_timer_sprite time=0 scale=(0,0) alpha=0
	DoScreenElementMorph id=nixon_timer_sprite time=0.3 scale=(0.725,0.725) alpha=1
	
endscript

script goal_comp_expire	
	;printf "goal_comp_expire"
	
	kill_start_key_binding
	
	GoalManager_GetGoalParams name=<goal_id>
	GoalManager_EditGoal name=<goal_id> params={ already_ended_run = 1 }
	
	pause_trick_text
	// deactivate goal for the time being
	GoalManager_PauseCompetition name=<goal_id>
	
	if not RoundIs 3
		GoalManager_SetGoalTimer name=<goal_id>
	endif
	
	SpawnSkaterScript goal_comp_expire2 params=<...>
endscript

script goal_comp_expire2
	root_window:SetTags giving_rewards=1
	root_window:SetTags showing_comp_results=1
	
;	MakeSkaterGoto EndOfRun params={ NoCamera }
	if ObjectExists id=goal_comp_out_of_bounds_warning
		DestroyScreenElement id=goal_comp_out_of_bounds_warning
	endif
	
	;ResetSkaters node_name=<restart_node>
	wait 1 frame
	PauseSkaters

	
	if RoundIs 3
		// show them the final results
		EndCompetitionRun
		
		WaitForEvent type=comp_continue
		
		goal_comp_show_results goal_id=<goal_id>
		WaitForEvent type=comp_continue
		;MakeSkaterGoto SkaterInit
		;EnablePlayerInput

		GoalManager_UnPauseCompetition name=<goal_id>
		GoalManager_DeactivateGoal name=<goal_id>
		
	else		
		// show them the scores
		EndCompetitionRun
		
		ResetScore

		WaitForEvent type=comp_continue
		
		if ObjectExists id=goal_comp_out_of_bounds_warning
			DestroyScreenElement id=goal_comp_out_of_bounds_warning
		endif
		if ObjectExists id=comp_root_anchor
			DestroyScreenElement id=comp_root_anchor
		endif
		; JumpSkaterToNode NodeName=<restart_node>
		
		ResetSkaters node_name=<restart_node>
		
		GoalManager_EditGoal name=<goal_id> params={ already_ended_run = 0 }
		
		; Obj_MoveToNode name = <restart_node> Orient;  Reset
		; Goto GroundGone

		
		// start a new run
		; printf "setting goal timer"
		; ResetSkaters node_name=<restart_node>
		; MakeSkaterGoto SkaterInit		
		;EnablePlayerInput
		SetScoreAccumulation 1
		StartCompetitionRun
    	; printf "Comp_expire2 attempt to debounce X"
		DeBounce X time=.3 clear=1
		wait 1 frame
		GoalManager_UnPauseCompetition name=<goal_id>
		RunStarted
	endif
	root_window:SetTags giving_rewards=0
	root_window:SetTags showing_comp_results=0
endscript

script goal_comp_deactivate
	KillSkaterCamAnim all
	KillSpawnedScript name=goal_comp_expire2
	KillSpawnedScript name=goal_comp_end_current_run
	EndCompetition
	
	GoalManager_ResetGoalTrigger name=<goal_id>
	
	goal_deactivate goal_id=<goal_id>	
	
	// destroy any screen elements, just in case
	if ObjectExists id=comp_root_anchor
		DestroyScreenElement id=comp_root_anchor
	endif
	if ObjectExists id=goal_comp_out_of_bounds_warning
		DestroyScreenElement id=goal_comp_out_of_bounds_warning
	endif
	if ObjectExists id=comp_leader_board_anchor
		DestroyScreenElement id=comp_leader_board_anchor
	endif
	if ObjectExists id=comp_scores_anchor
		DestroyScreenElement id=comp_scores_anchor
	endif
	unpause_trick_text
	
	KillSpawnedScript name=KillNixonTimer
	wait .1 seconds
	SpawnScript KillNixonTimer
	
	; if not GotParam quick_start
		; create name=<trigger_obj_id>
		; SpawnSkaterScript goal_comp_deactivate2 params=<...>
	; endif
		
	ResetSkaters node_name=<restart_node>
	MakeSkaterGoto HandBrake
	;MakeSkaterGoto SkaterInit
endscript

script KillNixonTimer
	if ObjectExists nixon_timer_box
		DoScreenElementMorph id=nixon_timer_sprite time=0.3 scale=(0,0) alpha=0
		// make the time look cool
		RunScriptOnScreenElement id=the_time clock_morph
	
		wait .5 seconds
		DestroyScreenElement id=nixon_timer_box
	endif
	KillSpawnedScript name=KillNixonTimer
endscript

/*script goal_comp_deactivate2
    // wait 1 gameframe and then check if active to make sure
	// they didn't start the goal from the view goals menu
	wait 1 gameframe
	if GoalManager_HasActiveGoals count_all
		return
	endif	
	
	ResetSkaters node_name=<restart_node>
	begin
		if EndOfRunDone
			printf "freeing skater"
			wait 1 gameframe
			; ResetCamera
			; KillSkaterCamAnim all
			MakeSkaterGoto SkaterInit
			break
		endif
		wait 1 gameframe
	repeat
	; KillSpawnedScript name=goal_comp_expire2
	
	;EndCompetitionRun
	;EndCompetition
	
	;SpawnSkaterScript goal_comp_enable_input
endscript*/

script goal_comp_leave_area
	if GoalManager_GoalIsActive name=<goal_id>
		create_panel_message id=goal_comp_out_of_bounds_warning text="You're out of the competition area!" style=goal_comp_out_of_bounds_text
		ResetScorePot UseBailStyle
		SetScoreAccumulation 0 freeze_score
	endif
endscript

script goal_comp_enter_area
	if GoalManager_GoalIsActive name=<goal_id>
		if ObjectExists id=goal_comp_out_of_bounds_warning
			DestroyScreenElement id=goal_comp_out_of_bounds_warning
		endif
		ResetScorePot
		SetScoreAccumulation 1
	endif
endscript

script goal_comp_enable_input
	EnablePlayerInput
endscript

script goal_comp_continue
	// UnPauseGame
	KillSpawnedScript name=goal_comp_show_run_scores
	KillSpawnedScript name=goal_comp_add_leader_board
	
	// give them the start key back
	SetScreenElementProps {
		id=root_window
		event_handlers=[ { pad_start	handle_start_pressed } ]
		replace_handlers
	}
	
	if ObjectExists id=comp_root_anchor
		DestroyScreenElement id=comp_root_anchor
	endif
	unpause_trick_text
	
	UnPauseSkaters
	; printf "Comp continue attempt to debounce X"
    DeBounce X time=.3 clear=1
	FireEvent type=comp_continue
	speech_box_exit
endscript

script goal_comp_success
	goal_success goal_id=<goal_id>
endscript

// ******************************************************
// 				Standings section
// ******************************************************

script goal_comp_show_run_scores
	// PauseGame
	
	; printf "goal_comp_show_run_scores"
	// container for the whole thing
	SetScreenElementLock id=root_window off	
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=comp_root_anchor
		
		dims=(640, 480)
		pos=(340, 250)
	}
	
	PauseSkaters
	
	// take the start key away completely for a bit
	SetScreenElementProps {
		id=root_window
		event_handlers=[ { pad_start	nullscript } ]
		replace_handlers
	}
	
	// create an anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=comp_root_anchor
		id=comp_scores_anchor
		
		pos=(330, 250)
		dims=(640, 480)
	}
	
	// create top piece (judge numbers and scores)
	CreateScreenElement {
		type=HMenu
		parent=comp_scores_anchor
		id=scores_hmenu
		
		pos=(400, 117)
		just=[right top]
		padding_scale=1.3
		regular_space_amount=40
	}
    
	// add the average score, but make it invisible for now
	FormatText TextName=score_text "%i" i=( <total_score> ) ; d=( <total_score> - ( <total_score> / 10 ) * 10 )
	CreateScreenElement {
		type=TextElement
		id=goal_comp_average_score
		scale=(1.0)
		parent=comp_scores_anchor
		
		pos=(460, 117)
		just=[right top]
		
		font=dialog
		text=<score_text>
		rgba=[0 0 0 0]
		not_focusable
		z_priority=10
	}

	
	CreateScreenElement {
		type=TextElement
		parent=comp_scores_anchor
		id=comp_scores_judges
		font=small
		text="Judges"
		rgba=[128 128 128 108]
		pos=(128, 98)
		just=[left top]
		scale=0.9		
	}
    
    CreateScreenElement {
		type=TextElement
		parent=comp_scores_anchor
		id=comp_scores_judge1
		font=small
		text="1"
		rgba=[88 105 112 128]
		pos=(215, 98)
		just=[left top]
		scale=0.9		
	}
    
     CreateScreenElement {
		type=TextElement
		parent=comp_scores_anchor
		id=comp_scores_judge2
		font=small
		text="2"
		rgba=[88 105 112 128]
		pos=(253, 98)
		just=[left top]
		scale=0.9		
	}
    
      CreateScreenElement {
		type=TextElement
		parent=comp_scores_anchor
		id=comp_scores_judge3
		font=small
		text="3"
		rgba=[88 105 112 128]
		pos=(293, 98)
		just=[left top]
		scale=0.9		
	}
    
	CreateScreenElement {
		type=TextElement
		parent=comp_scores_anchor
		id=comp_scores_judge4
		font=small
		text="4"
		rgba=[88 105 112 128]
		pos=(333, 98)
		just=[left top]
		scale=0.9		
	}
    
	CreateScreenElement {
		type=TextElement
		parent=comp_scores_anchor
		id=comp_scores_judge5
		font=small
		text="5"
		rgba=[88 105 112 128]
		pos=(374, 98)
		just=[left top]
		scale=0.9		
	}
    
	CreateScreenElement {
		type=TextElement
		parent=comp_scores_anchor
		id=comp_scores_average
		font=small
		text="Average"
		rgba=[128 128 128 108]
		pos=(414, 98)
		just=[left top]
		scale=0.9
        
	}
    	
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor
		texture=comp_tall_line
		pos=(115,92)
		scale=(1.2, .70)
		just=[center top]
		rgba=[128 128 128 110]
		
	}
    
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor
		texture=comp_tall_line
		pos=(200,92)
		scale=(1.2, .70)
		just=[center top]
		rgba=[128 128 128 110]		
	}
    
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor
		texture=comp_tall_line
		pos=(400,92)
		scale=(1.2, .70)
		just=[center top]
		rgba=[128 128 128 110]
	}
    
     CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor  	
		texture=comp_tall_line
		pos=(238,92)
		scale=(1.2, .70)
		just=[center top]
		rgba=[128 128 128 110]
	}
        
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor  	
		texture=comp_tall_line
		pos=(280,92)
		scale=(1.2, .70)
		just=[center top]
		rgba=[128 128 128 110]
	}
    
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor  	
		texture=comp_tall_line
		pos=(318,92)
		scale=(1.2, .70)
		just=[center top]
		rgba=[128 128 128 110]
	}
         
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor  	
		texture=comp_tall_line
		pos=(358,92)
		scale=(1.2, .70)
		just=[center top]
		rgba=[128 128 128 110]
	}
		
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor 	
		texture=comp_fill
		pos=(288, 91)
		scale=(58.5,1)
		just=[center top]
		rgba=[80 80 80 110]		
	}
	
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor 	
		texture=comp_end_cap
		pos=(484, 91)
		scale=(1.3 ,.98)
		just=[center top]
		rgba=[80 80 80 110]
		
	}
    
    CreateScreenElement { 
		type=SpriteElement 
		parent=comp_scores_anchor 	      
        texture=options_bg
		pos=(309,118)
		scale=(1.67,0.7)
		just=[center top]
		rgba=[15 15 15 80]
		
	}
	
	GetArraySize <scores>
	index=0
    
	;ForEachIn <scores> do=goal_comp_add_score_to_hmenu
    begin
		FormatText ChecksumName=score_id "score%i" i=<index>
		goal_comp_add_score_to_hmenu (<scores>[<index>]) id=<score_id>
		index = ( <index> + 1 )
	repeat<array_size>
	
	RunScriptOnScreenElement id=comp_scores_anchor goal_comp_animate_scores
	create_speech_box text="Press \m0 to continue" pos=(320, 400) pad_choose_script=goal_comp_skip_scores pad_choose_params={ scores=<scores> }
		
	WaitForEvent type=goal_comp_scores_done
	// show the average score
	SetScreenElementProps {
		id=goal_comp_average_score
		rgba=[117 14 14 100]
	}
endscript

script goal_comp_animate_scores
	//PlaySound AnimateIn
    DoMorph time=0 scale=1.0 alpha=0 pos=(305, 0)
    wait 1 frame   
    DoMorph time=.2 scale=1.0 alpha=1 pos=(305, 232)
endscript

script goal_comp_add_score_to_hmenu
	FormatText TextName=score_text "%i" i=( <score> ) ; d=( <score> - ( <score> / 10 ) * 10 )
	// printstruct <...>
	CreateScreenElement {
		type=TextElement
		parent=scores_hmenu
		
		font=dialog
		text=<score_text>
		not_focusable
	}
	
	// for the judges who will be ignored
	if not GotParam top_judge
		RunScriptOnScreenElement id=<id> goal_comp_fade_lower_score
	endif
endscript

// fade the lowest two scores out
script goal_comp_fade_lower_score
	wait 1 second
	DoMorph time=1.2 alpha=.3
	FireEvent type=goal_comp_scores_done
endscript

script goal_comp_skip_scores
	// printf "goal_comp_skip_scores"
    GetArraySize <scores>
	index=0
	begin
    FormatText ChecksumName=score_id "score%i" i=<index>
    if not StructureContains structure=(<scores>[<index>]) top_judge
		if ObjectExists id=<score_id>
			DoScreenElementMorph id=<score_id> alpha=.3   
		endif
	endif
	index = ( <index> + 1 )
	repeat<array_size>
	
	SetScreenElementProps {
		id=goal_comp_average_score
		rgba=[127 102 0 128]
	}
	
	if RoundIs 3
		;SpawnScript KillNixonTimer
	endif
	
    FireEvent type=goal_comp_scores_done
endscript

script goal_comp_end_current_run
	if ObjectExists id=current_menu_anchor
		exit_pause_menu
	endif
	
	if GoalManager_IsInCompetition
		GoalManager_EditGoal name=<goal_id> params={ already_ended_run = 1 }
		GoalManager_PauseCompetition name=<goal_id>
		
		// in case they jumped in the water right before ending the round
		KillSpawnedScript name=SK3_Killskater_Finish
		GoalManager_GetGoalParams name=<goal_id>
		ResetSkaters node_name=<restart_node>
		;MakeSkaterGoto SkaterInit
		goal_comp_expire goal_id=<goal_id>
	else
		printf "WARNING: you're not in a competition!!!"
	endif
endscript



// ****************************************************************
//				Leader board section
// ****************************************************************

script goal_comp_add_leader_board
	; printf "goal_comp_add_leader_board"
	// printstruct <...>
	
    WaitForEvent type=goal_comp_scores_done
	SpawnScript TemporarilyDisableInput params={ time=1500 }
    if ObjectExists id=speech_box_anchor
		SetScreenElementProps {
			id=speech_box_anchor
			event_handlers=[ { pad_choose goal_comp_continue } ]
			replace_handlers
		}
	endif
	wait 20 frame
	
	// make sure they haven't continued
	if not ObjectExists id=comp_root_anchor
		return
	endif 
	
    // take the start key away
	SetScreenElementProps {
		id=root_window
		event_handlers=[ { pad_start	goal_comp_continue } ]
		replace_handlers
	}
	
	// create leader board section
	SetScreenElementLock id=comp_root_anchor off
	CreateScreenElement {
		type=ContainerElement
		parent=comp_root_anchor
		id=comp_leader_board_anchor
		
		pos=(300, 232)
		dims=(640, 480)
	}
	
	// vmenu of skaters
	CreateScreenElement {
		type=VMenu
		parent=comp_leader_board_anchor
		id=comp_leader_board_vmenu
		pos=(208, 169)
		internal_just=[left center]
		just=[center top]
		z_priority=20 
	}
	
	// menu title
	CreateScreenElement {
		type=TextElement
		parent=comp_leader_board_vmenu
		id=comp_leader_board_vmenu_title
		font=testtitle
		text="STANDINGS"
		rgba=[128 128 128 75]
		just=[left top]
		scale=1.37
		not_focusable
	}


	// figure the round info
	if RoundIs 1
		FormatText TextName=round_info "(AFTER 1 ROUND)"
	else
		if RoundIs 2
			FormatText TextName=round_info "(AFTER 2 ROUNDS)"
		else
			FormatText TextName=round_info "(BEST 2 ROUNDS)"
		endif
	endif
	CreateScreenElement {
		type=TextElement
		parent=comp_leader_board_vmenu_title
		font=dialog
		text=<round_info>
		
		rgba=[117 14 14 90]
		pos=(264, 0)
        scale=.65
		just=[right top]
		not_focusable
	}
	
	if LevelIs load_FL
		CreateScreenElement { 
		type=SpriteElement 
		parent=comp_leader_board_anchor  	
		texture=spot_goals
		pos=(100,139)
		scale=(1.2)
		just=[center top]
		SetProps rgba=[128 128 128 110]
        z_priority=100		
		} 
	else
		if LevelIs load_SJ 
			CreateScreenElement { 
			type=SpriteElement 
			parent=comp_leader_board_anchor  	
			texture=scj_goals
			pos=(105,128)
			scale=(1.3)
			just=[center top]
			SetProps rgba=[128 128 128 110]
			z_priority=100		
			} 
		else
			if LevelIs load_HI
				FormatText ChecksumName=hi_goals_icon "5050_goals"
				CreateScreenElement { 
				type=SpriteElement 
				parent=comp_leader_board_anchor  	
				texture=<hi_goals_icon>
				pos=(106,132)
				scale=(1.2)
				just=[center top]
				SetProps rgba=[128 128 128 110]
				z_priority=100		
				} 
			else
				CreateScreenElement { 
				type=SpriteElement 
				parent=comp_leader_board_anchor  	
				texture=PA_goals
				pos=(100,132)
				scale=(1.2)
				just=[center top]
				SetProps rgba=[128 128 128 110]
				z_priority=100		
				} 
			endif
		endif
	endif
	 
		
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_leader_board_anchor  	
		texture=options_bg
		pos=(315,160)
		scale=(1.70,1.0)
		just=[center top]
		rgba=[80 80 80 128]
		
	}
   
	
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_leader_board_anchor  	
		texture=comp_hori_lines
		pos=(316,186)
		scale=(55.5, 0.96)
		just=[center top]
		rgba=[128 128 128 90]
		
	}
	
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_leader_board_anchor  	
		texture=comp_tall_line
		pos=(120,165)
		scale=(1.2, 2.25)
		just=[center top]
		rgba=[0 0 0 108]
		z_priority=30
	}
	
	CreateScreenElement { 
		type=SpriteElement 
		parent=comp_leader_board_anchor  	
		texture=comp_tall_line
		pos=(512,165)
		scale=(1.2, 2.25)
		just=[center top]
		rgba=[0 0 0 108]
		z_priority=30
	}

		
	ForEachIn <leader_board> do=goal_comp_add_leader_board_entry
	
	RunScriptOnScreenElement id=comp_leader_board_anchor goal_comp_animate_leaderboard
endscript

script goal_comp_animate_leaderboard
	DoMorph time=0 scale=0.0 alpha=0
    wait 20 frame 
	PlaySound BailSlap01 
    DoMorph time=.2 scale=1.0 alpha=1
endscript

script goal_comp_add_leader_board_entry
	// add skater name
	CreateScreenElement {
		type=TextElement
		parent=comp_leader_board_vmenu
		
		font=small
		text=<name>
		rgba=[128 128 128 128]
		not_focusable
		just=[left top]
	}

	// remember the id of this element
	<leader_board_name_id> = <id> 
		
	// add score
	FormatText TextName=score_text "%i" i=( <score> ) ; d=( <score> - ( <score> / 10 ) * 10 )
	CreateScreenElement {
		type=TextElement
		parent=<leader_board_name_id>
		
		font=dialog
		text=<score_text>
		pos=(320, 0)
		just=[right top]
	}
	
	// turn a different color if this is the player
	if GotParam player
		SetScreenElementProps {
			id=<leader_board_name_id>
			rgba=[127 102 0 128]
		}
		SetScreenElementProps {
			id=<id>
			rgba=[127 102 0 128]
		}		
	endif
endscript

script goal_comp_show_results	
	if PlaceIs 1
		create_speech_box text="You got gold!" no_pad_start pad_choose_script=nullscript style=goal_comp_speech_box_style
		GoalManager_WinGoal name=<goal_id>
	else 
		if PlaceIs 2
			create_speech_box text="You got silver!" no_pad_start pad_choose_script=nullscript style=goal_comp_speech_box_style
			GoalManager_WinGoal name=<goal_id>
		else
			if PlaceIs 3
				create_speech_box text="You got bronze!" no_pad_start pad_choose_script=nullscript style=goal_comp_speech_box_style
				GoalManager_WinGoal name=<goal_id>
			else
				create_speech_box text="You didn't get a medal" no_pad_start pad_choose_script=null_script style=goal_comp_speech_box_style
				GoalManager_LoseGoal name=<goal_id>
			endif
		endif
	endif
endscript

// ***************************************************
//			Style scripts
// ***************************************************

script goal_comp_out_of_bounds_text
	DoMorph time=0 pos=(320, 140)
endscript

script goal_comp_speech_box_style
	wait 2000
	Die
endscript
