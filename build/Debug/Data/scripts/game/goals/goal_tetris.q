// start autoduck documentation
// @DOC goal_tetris
// @module goal_tetris | None
// @subindex Scripting Database
// @index script | goal_tetris

goal_tetris_faded_trick_alpha = 0.4
goal_tetris_unfaded_trick_alpha = 1.0

goal_tetris_genericParams = {
	goal_text = "Skate-Tricks"
	view_goals_text = "Skate-Tricks"
	time = 120

	init = goal_tetris_init
	uninit = goal_uninit
	activate = goal_tetris_activate
	success = goal_tetris_success
	fail = goal_tetris_fail
	deactivate = goal_tetris_deactivate
	expire = goal_tetris_expire

	trigger_obj_id = TRG_G_TETRIS_Pro
	start_pad_id = G_TETRIS_StartPad
	restart_node = TRG_G_TETRIS_RestartNode

	trick_time = 3000
	max_tricks = 15
	acceleration_interval = 5
	acceleration_percent  = .1
	time_to_stop_adding_tricks = 5

	tetris           // necessary tetris flag

	record_type = score
}

goal_tetris2_genericParams = {
	goal_text = "Skate-Tricks2"
	view_goals_text = "Skate-Tricks2"
	time = 120

	init = goal_tetris_init
	uninit = goal_uninit
	activate = goal_tetris_activate
	success = goal_tetris_success
	fail = goal_tetris_fail
	deactivate = goal_tetris_deactivate
	expire = goal_tetris_expire

	trigger_obj_id = TRG_G_TETRIS2_Pro
	start_pad_id = G_TETRIS2_StartPad
	restart_node = TRG_G_TETRIS2_RestartNode

	trick_time = 3000
	max_tricks = 15
	acceleration_interval = 5
	acceleration_percent  = .1
	time_to_stop_adding_tricks = 5

	tetris           // necessary tetris flag

	record_type = score
}


script goal_tetris_init
	; GoalManager_InitGoalTrigger name=<goal_id>
	goal_init goal_id=<goal_id>
endscript

script goal_tetris_activate
	// set a flag so we can wait for the start of the goal
	if not GotParam quick_start
		GoalManager_EditGoal name=<goal_id> params={ wait_to_add_tricks=1 }
		SpawnScript goal_tetris_wait_and_add_tricks params=<...>
	endif

	goal_start goal_id=<goal_id>
	if GotParam single_combo
		SetScoreAccumulation 0
	endif
	create_tetris_menu
endscript

script goal_tetris_wait_and_add_tricks
	WaitForEvent type=goal_cam_anim_post_start_done
	if not GoalManager_GoalIsActive name=<goal_id>
		return
	endif
	GoalManager_EditGoal name=<goal_id> params={ wait_to_add_tricks=0 }
endscript

script goal_tetris_success
	goal_success goal_id=<goal_id>
endscript

script goal_tetris_fail
	goal_fail goal_id=<goal_id>
endscript


script goal_tetris_deactivate
	goal_deactivate goal_id=<goal_id>
	GoalManager_ResetGoalTrigger name=<goal_id>

	if ObjectExists id=tetris_menu_anchor
		RunScriptOnScreenElement id=tetris_menu_anchor menu_offscreen params={ menu_id=tetris_menu_anchor }
	endif
endscript

script goal_tetris_expire
	goal_expire goal_id=<goal_id>
	GoalManager_LoseGoal name=<goal_id>
endscript

script create_tetris_menu
	SetScreenElementLock id=root_window off

	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=tetris_menu_anchor

		font=small
		pos=(320,218)
		just=[center center]
		scale=1
		dims=(640,480)
	}

	CreateScreenElement {
		type=VMenu
		parent=tetris_menu_anchor
		id=tetris_tricks_menu

		font=small
		padding_scale = .95
		just=[right bottom]
		pos=(615,370)
		;dims=(200,170)
		internal_just=[right center]
		scale = 1
		;autospace = 10
	}
endscript

script goal_tetris_remove_trick
	GetTags
	DoMorph time=0 scale=.7
	; SetProps rgba=[144 32 32 85]
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=[144 32 32 85]
	}
	if not GotParam tricktris
		DoMorph scale=0 time=.5 scale=0
	endif
	Die
endscript

script goal_tetris_add_trick
	GetTags
	goal_tetris_move_button_text <...>
	DoMorph time=0 scale=0

	; SetProps rgba=[127 102 0 75]
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=[127 102 0 75]
	}
	DoMorph time=.3 scale=.8
	DoMorph time=.2 scale=.6
	DoMorph time=.1 scale=.7
	SetProps rgba=[128 128 128 75]
endscript

script goal_tetris_add_red_trick
	GetTags
	goal_tetris_move_button_text <...>
	DoMorph time=0 scale=0
	; SetProps rgba=[144 32 32 75]
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=[144 32 32 75]
	}
	DoMorph time=.3 scale=.8
	DoMorph time=.2 scale=.6
	DoMorph time=.1 scale=.7
endscript

script goal_tetris_move_button_text
	GetTags
	// move trick text
	SetScreenElementProps {
		id={ <id> child=0 }
		just=[right top]
	}
	SetScreenElementProps {
		id={ <id> child=0 }
		pos=(100, 0)
		; just=[left top]
	}

	// move key combo if it exists
	if not GotParam no_key_combo
		GetScreenElementPosition id={ <id> child=0 }
		SetScreenElementProps {
			id={ <id> child=1 }
			just=[right top]
		}
		SetScreenElementProps {
			id={ <id> child=1 }
			pos=( <ScreenElementPos> - (10, 0) )
			; pos=(-50, 11)
			; just=[right top]
		}
	endif
endscript


script goal_tetris_turn_trick_red
	; SetProps rgba=[144 32 32 85]
	GetTags
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=[144 32 32 85]
	}
endscript

script goal_tetris_turn_trick_white
	; SetProps rgba=[128 128 128 75]
	GetTags
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=[127 102 0 75]
	}
endscript

script goal_tetris_reset_trick_container
	TerminateObjectsScripts id=<id>

	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=[127 102 0 75]
	}

	DoScreenElementMorph {
		id=<id>
		scale=.7
	}
endscript

script goal_tetris_play_trick_removed_sound
	wait .10 seconds
	PlaySound TetrisAway  vol=125 pitch=125
endscript


// ***********************************************
//		Text mapping for all trick commands
// ***********************************************

goal_tetris_trick_text = {
	Air_CircleD				= "\b4 + \b2"
	Air_CircleDL			= "\bc + \b2"
	Air_CircleDR			= "\ba + \b2"
	Air_CircleL				= "\b6 + \b2"
	Air_CircleR				= "\b5 + \b2"
	Air_CircleU				= "\b7 + \b2"
	Air_CircleUL			= "\bb + \b2"
	Air_CircleUR			= "\bd + \b2"
	Air_D_D_Circle			= "\b4 \b4 + \b2"
	Air_D_D_Square			= "\b4 \b4 + \b1"
	Air_L_L_Circle			= "\b6 \b6 + \b2"
	Air_L_L_Square			= "\b6 \b6 + \b1"
	Air_R_R_Circle			= "\b5 \b5 + \b2"
	Air_R_R_Square			= "\b5 \b5 + \b1"
	Air_SquareD				= "\b4 + \b1"
	Air_SquareDL			= "\bc + \b1"
	Air_SquareDR			= "\ba + \b1"
	Air_SquareL				= "\b6 + \b1"
	Air_SquareR				= "\b5 + \b1"
	Air_SquareU				= "\b7 + \b1"
	Air_SquareUL			= "\bb + \b1"
	Air_SquareUR			= "\bd + \b1"
	Air_U_U_Circle			= "\b7 \b7 + \b2"
	Air_U_U_Square			= "\b7 \b7 + \b1"
	;	ExtraSlot1
	;	ExtraSlot2
	;	JumpSlot
	Lip_TriangleD			= "\b4 + \b0"
	Lip_TriangleDL			= "\bc + \b0"
	Lip_TriangleDR			= "\ba + \b0"
	Lip_TriangleL			= "\b6 + \b0"
	Lip_TriangleR			= "\b5 + \b0"
	Lip_TriangleU			= "\b7 + \b0"
	Lip_TriangleUL			= "\bb + \b0"
	Lip_TriangleUR		 	= "\bd + \b0"
	SpAir_D_L_Circle		= "\b4 \b6 + \b2"
	SpAir_D_L_Square		= "\b4 \b6 + \b1"
	SpAir_D_R_Circle		= "\b4 \b5 + \b2"
	SpAir_D_R_Square		= "\b4 \b5 + \b1"
	SpAir_D_U_Circle		= "\b4 \b7 + \b2"
	SpAir_D_U_Square		= "\b4 \b7 + \b1"
	SpAir_L_D_Circle		= "\b6 \b4 + \b2"
	SpAir_L_D_Square		= "\b6 \b4 + \b1"
	SpAir_L_R_Circle		= "\b6 \b5 + \b2"
	SpAir_L_R_Square		= "\b6 \b5 + \b1"
	SpAir_L_U_Circle		= "\b6 \b7 + \b2"
	SpAir_L_U_Square		= "\b6 \b7 + \b1"
	SpAir_R_D_Circle		= "\b5 \b4 + \b2"
	SpAir_R_D_Square		= "\b5 \b4 + \b1"
	SpAir_R_L_Circle		= "\b5 \b6 + \b2"
	SpAir_R_L_Square		= "\b5 \b6 + \b1"
	SpAir_R_U_Circle		= "\b5 \b7 + \b2"
	SpAir_R_U_Square		= "\b5 \b7 + \b1"
	SpAir_U_D_Circle		= "\b7 \b4 + \b2"
	SpAir_U_D_Square		= "\b7 \b4 + \b1"
	SpAir_U_L_Circle		= "\b7 \b6 + \b2"
	SpAir_U_L_Square		= "\b7 \b6 + \b1"
	SpAir_U_R_Circle		= "\b7 \b5 + \b2"
	SpAir_U_R_Square		= "\b7 \b5 + \b1"
	SpGrind_D_L_Triangle	= "\b4 \b6 + \b0"
	SpGrind_D_R_Triangle	= "\b4 \b5 + \b0"
	SpGrind_D_U_Triangle	= "\b4 \b7 + \b0"
	SpGrind_L_D_Triangle	= "\b6 \b4 + \b0"
	SpGrind_L_R_Triangle	= "\b6 \b5 + \b0"
	SpGrind_L_U_Triangle	= "\b6 \b7 + \b0"
	SpGrind_R_D_Triangle	= "\b5 \b4 + \b0"
	SpGrind_R_L_Triangle	= "\b5 \b6 + \b0"
	SpGrind_R_U_Triangle	= "\b5 \b7 + \b0"
	SpGrind_U_D_Triangle	= "\b7 \b4 + \b0"
	SpGrind_U_L_Triangle	= "\b7 \b6 + \b0"
	SpGrind_U_R_Triangle	= "\b7 \b5 + \b0"
	SpLip_D_L_Triangle		= "\b4 \b6 + \b0"
	SpLip_D_R_Triangle		= "\b4 \b5 + \b0"
	SpLip_D_U_Triangle		= "\b4 \b7 + \b0"
	SpLip_L_D_Triangle		= "\b6 \b4 + \b0"
	SpLip_L_R_Triangle		= "\b6 \b5 + \b0"
	SpLip_L_U_Triangle		= "\b6 \b7 + \b0"
	SpLip_R_D_Triangle		= "\b5 \b4 + \b0"
	SpLip_R_L_Triangle		= "\b5 \b6 + \b0"
	SpLip_R_U_Triangle		= "\b5 \b7 + \b0"
	SpLip_U_D_Triangle		= "\b7 \b4 + \b0"
	SpLip_U_L_Triangle		= "\b7 \b6 + \b0"
	SpLip_U_R_Triangle		= "\b7 \b5 + \b0"
	SpLip_U_U_Triangle		= "\b7 \b7 + \b0"
	SpMan_D_L_Triangle		= "\b4 \b6 + \b0"
	SpMan_D_R_Triangle		= "\b4 \b5 + \b0"
	SpMan_D_U_Triangle		= "\b4 \b7 + \b0"
	SpMan_L_D_Triangle		= "\b6 \b4 + \b0"
	SpMan_L_R_Triangle		= "\b6 \b5 + \b0"
	SpMan_L_U_Triangle		= "\b6 \b7 + \b0"
	SpMan_R_D_Triangle		= "\b5 \b4 + \b0"
	SpMan_R_L_Triangle		= "\b5 \b6 + \b0"
	SpMan_R_U_Triangle		= "\b5 \b7 + \b0"
	SpMan_U_D_Triangle		= "\b7 \b4 + \b0"
	SpMan_U_L_Triangle		= "\b7 \b6 + \b0"
	SpMan_U_R_Triangle		= "\b7 \b5 + \b0"

	Extra_SquareSquareL		= "\b6 + \b1 + \b1"
}

goal_tetris_trick_text_double_tap = {
	Air_CircleD				= "\b4 + \b2 + \b2"
	Air_CircleDL			= "\bc + \b2 + \b2"
	Air_CircleDR			= "\ba + \b2 + \b2"
	Air_CircleL				= "\b6 + \b2 + \b2"
	Air_CircleR				= "\b5 + \b2 + \b2"
	Air_CircleU				= "\b7 + \b2 + \b2"
	Air_CircleUL			= "\bb + \b2 + \b2"
	Air_CircleUR			= "\bd + \b2 + \b2"
	Air_SquareD				= "\b4 + \b1 + \b1"
	Air_SquareDL			= "\bc + \b1 + \b1"
	Air_SquareDR			= "\ba + \b1 + \b1"
	Air_SquareL				= "\b6 + \b1 + \b1"
	Air_SquareR				= "\b5 + \b1 + \b1"
	Air_SquareU				= "\b7 + \b1 + \b1"
	Air_SquareUL			= "\bb + \b1 + \b1"
	Air_SquareUR			= "\bd + \b1 + \b1"
}
