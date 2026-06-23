// @DOC goal_firefight

goal_firefight_genericParams = {
	goal_text = "You must eliminate all other players!"
	unlimited_time = 1
	net

	init = goal_firefight_init
	activate = goal_firefight_activate
	active = goal_firefight_active
	deactivate = goal_firefight_deactivate
	expire = goal_firefight_expire

	goal_description = "FireFight!"
}

script goal_firefight_init
endscript

script goal_firefight_activate
	if InTeamGame
		FormatText TextName=msg_text "\c2FireFight! \n\c0The last team standing wins.\n\b1\b7 or \b1\b4\nto shoot"
	else
		FormatText TextName=msg_text "\c2FireFight! \n\c0The last player standing wins.\n\b1\b7 or \b1\b4\nto shoot"
	endif

	if Not IsObserving
		skater:pickeduppowerup fireball
		bind_fireball_tricks
	endif
	if InSplitScreenGame
		skater2:pickeduppowerup fireball
		bind_fireball_tricks_player_2
		MakeSkaterGosub add_skater_to_world skater=0
		MakeSkaterGosub add_skater_to_world skater=1
		ScriptGetScreenMode
		switch <screen_mode>
			case split_vertical
				msg_pos=(350,42)
			case split_horizontal
				msg_pos=(620,27)
		endswitch
	else
		msg_pos=(620,27)
	endif

	if InNetGame
		create_panel_block id=mp_goal_text text=<msg_text> style=panel_message_goal final_pos=<msg_pos>
	endif
	ResetScore
	;	SetScreenElementProps {
	;		id=the_time
	;		alpha=1
	;	}
endscript

script goal_firefight_active
	if OnlyOneSkaterLeft
		if OnServer
			if CalculateFinalScores
				GoalManager_DeactivateGoal name=<goal_id>
				goal_firefight_finished
			endif
		else
			GoalManager_DeactivateGoal name=<goal_id>
			goal_firefight_finished
		endif
	endif
endscript

script goal_firefight_finished
	ClearPowerups
	if Not IsObserving
		unbind_fireball_tricks
	endif
	if InSplitScreenGame
		unbind_fireball_tricks_player_2
	endif

	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
	printf "goal_firefight_deactivate"
	if OnServer
		if InInternetMode
			ReportStats final
		endif
	endif
	create_rankings score_title_text="HEALTH"
endscript

script goal_firefight_deactivate
	ClearPowerups
	if Not IsObserving
		unbind_fireball_tricks
	endif
	if InSplitScreenGame
		unbind_fireball_tricks_player_2
	endif
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
endscript

script firefight_done
	dialog_box_exit
	do_backend_retry
endscript

script goal_firefight_expire
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
	printf "goal_firefight_expire"
	//create_rankings score_title_text="firefightS"
	if OnServer
		SpawnScript wait_then_create_rankings params={score_title_text="Health"}
	else
		create_rankings score_title_text="Health"
	endif
endscript

script AddGoal_firefight
	GoalManager_AddGoal name=firefight {
		params={ goal_firefight_genericParams
			<...>
		}
	}
endscript

script StartGoal_firefight
	if InSplitScreenGame
		SetScreenModeFromGameMode
	endif
	GoalManager_EditGoal name=firefight params = <...>
	GoalManager_ActivateGoal name=firefight
endscript

script announce_elimination
	printf "announcing elimination!!!!"
	FormatText TextName=msg_text "%s has been eliminated!" s=<Name>
	create_net_panel_message msg_time=2000 text=<msg_text>
endscript

script bind_fireball_tricks
	GoalManager_GetTrickFromKeyCombo key_combo=Air_SquareU
	skater:SetTags old_fireballf_checksum=<trick_checksum>

	BindTrickToKeyCombo {
		key_combo=Air_SquareU
		trick=FireballF
		update_mappings=1
	}

	UpdateTrickMappings skater=0
	GoalManager_GetTrickFromKeyCombo key_combo=Air_SquareD
	skater:SetTags old_fireballb_checksum=<trick_checksum>
	BindTrickToKeyCombo {
		key_combo=Air_SquareD
		trick=FireballB
		update_mappings=1
	}

	UpdateTrickMappings skater=0
endscript

script bind_fireball_tricks_player_2
	SetCurrentSkaterProfile 1
	GoalManager_GetTrickFromKeyCombo key_combo=Air_SquareU
	skater2:SetTags old_fireballf_checksum=<trick_checksum>

	BindTrickToKeyCombo {
		key_combo=Air_SquareU
		trick=FireballF
		update_mappings=1
	}

	UpdateTrickMappings skater=1
	GoalManager_GetTrickFromKeyCombo key_combo=Air_SquareD
	skater2:SetTags old_fireballb_checksum=<trick_checksum>
	BindTrickToKeyCombo {
		key_combo=Air_SquareD
		trick=FireballB
		update_mappings=1
	}

	UpdateTrickMappings skater=1
	SetCurrentSkaterProfile 0
endscript

script unbind_fireball_tricks
	Skater:GetTags
	if GotParam old_fireballf_checksum
		BindTrickToKeyCombo {
			key_combo = Air_SquareU
			trick = <old_fireballf_checksum>
			update_mappings=1
		}
	endif
	UpdateTrickMappings skater=0
	if GotParam old_fireballb_checksum
		BindTrickToKeyCombo {
			key_combo = Air_SquareD
			trick = <old_fireballb_checksum>
			update_mappings=1
		}
	endif
	UpdateTrickMappings skater=0
endscript

script unbind_fireball_tricks_player_2
	SetCurrentSkaterProfile 1
	Skater2:GetTags
	if GotParam old_fireballf_checksum
		BindTrickToKeyCombo {
			key_combo = Air_SquareU
			trick = <old_fireballf_checksum>
			update_mappings=2
		}
	endif
	UpdateTrickMappings skater=1
	if GotParam old_fireballb_checksum
		BindTrickToKeyCombo {
			key_combo = Air_SquareD
			trick = <old_fireballb_checksum>
			update_mappings=2
		}
	endif
	UpdateTrickMappings skater=1
	SetCurrentSkaterProfile 0
endscript
