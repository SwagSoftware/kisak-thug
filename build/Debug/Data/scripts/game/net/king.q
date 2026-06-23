// start autoduck documentation
// @DOC goal_king
// @module goal_king | None
// @subindex Scripting Database
// @index script | goal_king

goal_king_genericParams = {
	goal_text = "Capture the crown and keep it away from others!"
	unlimited_time = 1
	score = 10000
	net

	init = goal_king_init
	activate = goal_king_activate
	deactivate = goal_king_deactivate
	;expire = goal_king_expire
	active = goal_king_active

	goal_description = "King of the Hill!"
}

script goal_king_init
endscript

script goal_king_activate
	if InSplitScreenGame
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
		switch <score>
			case 30000
				time_string="30 seconds"
			case 60000
				time_string="1 minute"
			case 120000
				time_string="2 minutes"
			case 300000
				time_string="5 minutes"
			case 600000
				time_string="10 minutes"
		endswitch
		if InTeamGame
			FormatText TextName=msg_text "\c3King of the Hill:\n\c0Hold the crown for \n%s to win." s=<time_string>
		else
			FormatText TextName=msg_text "\c3King of the Hill:\n\c0Hold the crown for \n%s to win." s=<time_string>
		endif
		create_panel_block id=mp_goal_text text=<msg_text> style=panel_message_goal final_pos=<msg_pos>
	endif

	SpawnCrown
	show_crown_arrow player_1 player_2 force_show
	ResetScore
endscript

script goal_king_active
	if AnySkaterTotalScoreAtLeast <score>
		if OnServer
			if CalculateFinalScores
				GoalManager_DeactivateGoal name=<goal_id>
				goal_king_finished
			endif
		else
			GoalManager_DeactivateGoal name=<goal_id>
			goal_king_finished
		endif
	endif
endscript


script goal_king_finished
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
	hide_crown_arrow player_1 player_2
	printf "goal_king_deactivate"
	if OnServer
		if InInternetMode
			ReportStats final
		endif
	endif
	create_rankings score_title_text="TIME"
endscript

script goal_king_deactivate
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
	hide_crown_arrow player_1 player_2
endscript

script king_done
	dialog_box_exit
	do_backend_retry
endscript

script AddGoal_King
	GoalManager_AddGoal name=king {
		params={ goal_king_genericParams
			<...>
		}
	}
endscript

script show_crown_arrow
	if Not GotParam force_show
		if Not GoalManager_GoalIsActive name=king
			return
		endif
	endif

	if InSplitScreenGame
		ScriptGetScreenMode
		switch <screen_mode>
			case split_vertical
				if GotParam player_1
					if Not ObjectExists id=crown_arrow
						Create3dArrowPointer id=crown_arrow name=crown_object pos=(395, 50) scale=0.02 model="HUD_Arrow"
					endif
				endif
				if GotParam player_2
					if Not ObjectExists id=crown_arrow_2
						Create3dArrowPointer id=crown_arrow_2 name=crown_object pos=(395, 50) scale=0.02 active_viewport=1 model="HUD_Arrow"
					endif
				endif
			case split_horizontal
				if GotParam player_1
					if Not ObjectExists id=crown_arrow
						Create3dArrowPointer id=crown_arrow name=crown_object pos=(320, 140) scale=0.02 model="HUD_Arrow"
					endif
				endif
				if GotParam player_2
					if Not ObjectExists id=crown_arrow_2
						Create3dArrowPointer id=crown_arrow_2 name=crown_object pos=(320, 140) scale=0.02 active_viewport=1 model="HUD_Arrow"
					endif
				endif
		endswitch
		;Create3dArrowPointer id=crown_arrow name=crown_object pos=(160, 50) scale=0.02 model="HUD_Arrow"
		;Create3dArrowPointer id=crown_arrow_2 name=crown_object pos=(480, 50) scale=0.02 model="HUD_Arrow"

	else
		if GotParam player_1
			if Not ObjectExists id=crown_arrow
				Create3dArrowPointer id=crown_arrow name=crown_object model="HUD_Arrow"
			endif
		endif
	endif
endscript

script hide_crown_arrow
	if GotParam player_1
		if ObjectExists id=crown_arrow
			DestroyScreenElement id=crown_arrow
		endif
	endif

	if GotParam player_2
		if ObjectExists id=crown_arrow_2
			DestroyScreenElement id=crown_arrow_2
		endif
	endif
endscript

script StartGoal_King
	if InSplitScreenGame
		SetScreenModeFromGameMode
	endif
	GoalManager_EditGoal name=king params = <...>
	GoalManager_ActivateGoal name=king
endscript
