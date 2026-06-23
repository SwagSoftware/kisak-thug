// start autoduck documentation
// @DOC goal_ctf
// @module goal_ctf | None
// @subindex Scripting Database
// @index script | goal_ctf

goal_ctf_genericParams = {
	goal_text = "Capture the other team's flag and return it to your base!"
	;unlimited_time
	time = 30
	score = 1
	net

	init = goal_ctf_init
	activate = goal_ctf_activate
	deactivate = goal_ctf_deactivate
	active = goal_ctf_active

	goal_description = "Capture the Flag!"
}

script goal_ctf_init
endscript

script goal_ctf_activate
	GetNumTeams
	create_team_flags <...>

	PrintStruct <...>
	if( <unlimited_time> = 1 )
		if( <score> = 1 )
			FormatText TextName=msg_text "\c3Capture the Flag:\n\c0First to %s capture wins" s=<score>
		else
			FormatText TextName=msg_text "\c3Capture the Flag:\n\c0First to %s captures wins" s=<score>
		endif
	else
		FormatText TextName=msg_text "\c3Capture the Flag:\n\c0Most captures wins"
	endif

	if InNetGame
		create_panel_block id=mp_goal_text text=<msg_text> style=panel_message_goal
	endif

	ResetScore


	if( <unlimited_time> = 0 )
		RunScriptOnScreenElement id=the_time clock_morph
	endif

	StartCTFGame
endscript

script goal_ctf_active
	if( <unlimited_time> = 1 )
		if AnySkaterTotalScoreAtLeast <score>
			if OnServer
				if CalculateFinalScores
					GoalManager_DeactivateGoal name=<goal_id>
				endif
			else
				GoalManager_DeactivateGoal name=<goal_id>
			endif
		endif
	endif
endscript

script goal_ctf_deactivate
	printf "*************** goal_ctf_deactivate"
	if ObjectExists id=mp_goal_text
		DestroyScreenElement id=mp_goal_text
	endif
	destroy_ctf_panel_message
	hide_ctf_arrow
	Kill_Team_Flags
	EndCTFGame
	if OnServer
		if InInternetMode
			ReportStats final
		endif
	endif
	create_rankings score_title_text="CAPTURES"
endscript

script ctf_done
	dialog_box_exit
	do_backend_retry
endscript

script Addgoal_ctf
	GoalManager_AddGoal name=ctf {
		params={ goal_ctf_genericParams
			<...>
		}
	}
endscript

script show_ctf_arrow
	if IsObserving
		return
	endif
	if GoalManager_GoalIsActive name=ctf
		printf "***** SHOWING CTF ARROW"
		if ObjectExists id=ctf_arrow
			printf "***** HIDING IT FIRST"
			hide_ctf_arrow
		endif

		switch <team>
			case 0
				printf "***** target is red"
				target=TRG_CTF_Red
			case 1
				printf "***** target is blue"
				target=TRG_CTF_Blue
			case 2
				printf "***** target is green"
				target=TRG_CTF_Green
			case 3
				printf "***** target is yellow"
				target=TRG_CTF_Yellow
		endswitch
		printf "***** creating...."
		Create3dArrowPointer id=ctf_arrow name=<target> model="HUD_Arrow"
	endif
endscript

script hide_ctf_arrow
	if ObjectExists id=ctf_arrow
		DestroyScreenElement id=ctf_arrow
	endif
endscript

script Startgoal_ctf
	GoalManager_EditGoal name=ctf params = <...>
	GoalManager_ActivateGoal name=ctf
endscript

script took_flag_other
	printf "******* took flag other"
	FormatText TextName=msg_text "%s has taken the %w flag." s=<String0> w=<String1>
	create_net_panel_message text=<msg_text> style=net_team_panel_message
endscript

script took_flag_you
	printf "******* took flag you"
	create_ctf_panel_message msg_text="Return the flag to your base!"
	FormatText TextName=msg_text "You have taken the %s flag. Return it to your base!" s=<String0>
	create_net_panel_message text=<msg_text> style=net_team_panel_message
endscript

script took_flag_yours
	printf "******* took flag yours"
	FormatText TextName=msg_text "%s has taken your flag! Hunt him down!" s=<String0>
	create_net_panel_message text=<msg_text> style=net_team_panel_message
endscript

script stole_flag_other
	printf "******* stole flag other"
	FormatText TextName=msg_text "%s has stolen the %w flag." s=<String0> w=<String1>
	create_net_panel_message text=<msg_text> style=net_team_panel_message
endscript

script stole_flag_you
	printf "******* stole flag you"
	FormatText TextName=msg_text "You have stolen the %s flag. Return it to your base!" s=<String0>
	create_net_panel_message text=<msg_text> style=net_team_panel_message
endscript

script stole_flag_from_you
	printf "******* stole flag from you"
	destroy_ctf_panel_message
	FormatText TextName=msg_text "%s has stolen the %w flag from you!" s=<String0> w=<String1>
	create_net_panel_message text=<msg_text> style=net_team_panel_message
endscript

script relocate_flag
	switch <team>
		case 0
			flag_name=TRG_CTF_Red
		case 1
			flag_name=TRG_CTF_Blue
		case 2
			flag_name=TRG_CTF_Green
		case 3
			flag_name=TRG_CTF_Yellow
	endswitch

	if NodeExists <flag_name>
		;kill name = <flag_name>
		//printf "******** IN RELOCATE *************"
		if IsAlive name=<flag_name>
			//if ObjectExists id=<flag_name>
			//printf "******** KILLING *************"
			<flag_name>:Die
		endif
	endif
	//printf "******** CREATING *************"
	create name = <flag_name>

	if OnServer
		<flag_name>:Obj_SetException ex = AnySkaterInRadius scr = CTF_Team_Flag_Trigger params = {<...>}
	endif
endscript

script captured_your_flag
	printf "******* captured your flag"
	FormatText TextName=msg_text "%s has captured your flag.!" s=<String0>
	create_net_panel_message text=<msg_text> style=net_team_panel_message

	relocate_flag <...>
endscript

script captured_flag_other
	printf "******* captured flag other"
	FormatText TextName=msg_text "%s has captured the %w flag." s=<String0> w=<String1>
	create_net_panel_message text=<msg_text> style=net_team_panel_message

	relocate_flag <...>
endscript

script captured_flag_you
	printf "******* captured flag you"
	destroy_ctf_panel_message
	FormatText TextName=msg_text "You have captured the %s flag." s=<String0>
	create_net_panel_message text=<msg_text> style=net_team_panel_message

	relocate_flag <...>
endscript

script retrieved_flag_you
	printf "******* retrieved flag you"
	FormatText TextName=msg_text "You retrieved the %s flag!" s=<String0>
	create_net_panel_message text=<msg_text> style=net_team_panel_message

	relocate_flag <...>
endscript

script retrieved_flag_other
	printf "******* retrieved flag other"
	FormatText TextName=msg_text "%s retrieved the %w flag." s=<String0> w=<String1>
	create_net_panel_message text=<msg_text> style=net_team_panel_message

	relocate_flag <...>
endscript

script flag_returned
	printf "******* flag returned"
	FormatText TextName=msg_text "The %s has returned to its base." s=<String0>
	create_net_panel_message text=<msg_text> style=net_team_panel_message

	relocate_flag <...>
endscript

script create_ctf_panel_message
	create_panel_block id=current_ctf_message text=<msg_text> style=panel_message_goal final_pos=(620,80) dont_animate
endscript

script destroy_ctf_panel_message
	if ObjectExists id=current_ctf_message
		DestroyScreenElement id=current_ctf_message
	endif
endscript

