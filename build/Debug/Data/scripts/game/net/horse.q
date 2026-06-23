// ****************************************************
// * SOUND EFFECTS
// ****************************************************

script PlayYouTieScoreSound
	PlaySound copinghit3_11
endscript

script PlayYouBeatScoreSound
	PlaySound GotStat04
endscript

script PlayYouGetLetterSound
	PlaySound HUDtrickslopC
endscript

script PlayYouLoseSound
	PlaySound GoalFail
endscript

script PlayNoScoreSetSound
	PlaySound GUI_buzzer01
endscript

script play_appropriate_horse_sound
	if HorseEnded
		PlayYouLoseSound
	endif
	if HorseStatusEquals GotLetter
		PlayYouGetLetterSound
	endif
	if HorseStatusEquals TieScore
		PlayYouTieScoreSound
	endif
	if HorseStatusEquals BeatScore
		PlayYouBeatScoreSound
	endif
	if HorseStatusEquals NoScoreSet
		PlayNoScoreSetSound
	endif
endscript

// ****************************************************
// * SOME HANDY PANEL-RELATED FUNCTIONS HERE
// ****************************************************

script WaitForPanelDone
	// remain in a loop until the panel messages are done
	begin
		if ControllerPressed X
			kill_horse_panel_messages
			break
		endif
		if ObjectExists id=Top
			wait 1 gameframe
		else
			if ObjectExists id=Bottom
				wait 1 gameframe
			else
				if ObjectExists id=TopFinal
					wait 1 gameframe
				else
					if ObjectExists id=BottomFinal
						wait 1 gameframe
					else
						break
					endif
				endif
			endif
		endif
	repeat
endscript

// this is in a wrapper so i can call it from code or script
script launch_panel_message
	LaunchPanelMessage <...>
endscript

// ****************************************************
// * HORSE PANEL PROPERTIES
// ****************************************************

// some useful structures...

// THPS4 note:  instead of storing the name checksum of a
// global structure, the message class should store the
// structure itself.  that would make this file a lot
// less complicated, bec. then we can build a structure
// dynamically by overriding its elements (i.e. take
// given structure, append player1color or player2color
// as appropriate, pass given structure to next function)

player1_horsecolor=[
	{(128,32,32) alpha=128}
]

player2_horsecolor=[
	{(32,32,128) alpha=128}
]

horse_top_key_points=[
	{pos=(320,204) alpha=0 scale=1.0 time=0}
	{alpha=128 time=2.0}
]

horse_middle_key_points=[
	{pos=(320,224) alpha=0 scale=1.0 time=0}
	{alpha=128 time=2.0}
]

horse_bottom_key_points=[
	{pos=(320,244) alpha=0 scale=1.0 time=0}
	{alpha=128 time=2.0}
]

horse_bottomfinal_key_points=[
	{pos=(340,300) alpha=0 scale=2.0 time=0}
	{alpha=128 time=5.0}
]
horse_topfinal_key_points=[
	{pos=(320,204) alpha=0 scale=1.0 time=0}
	{alpha=128 time=5.0}
]


player1_default_horseprop={
	font="title.fnt"
	just=(0,0)
	dims=(320,112)
	colors=player1_horsecolor
	key_points=horse_middle_key_points
	//	truncation_width = 600
}

player2_default_horseprop={
	font="title.fnt"
	just=(0,0)
	dims=(320,112)
	colors=player2_horsecolor
	key_points=horse_middle_key_points
	//	truncation_width = 600
}



// composite properties, built from above structures

player1_top_horseprop={
	player1_default_horseprop
	key_points=horse_top_key_points
}

player2_top_horseprop={
	player2_default_horseprop
	key_points=horse_top_key_points
}

player1_bottom_horseprop={
	player1_default_horseprop
	key_points=horse_bottom_key_points
}

player2_bottom_horseprop={
	player2_default_horseprop
	key_points=horse_bottom_key_points
}

player1_topfinal_horseprop={
	player1_default_horseprop
	key_points=horse_topfinal_key_points
}

player2_topfinal_horseprop={
	player2_default_horseprop
	key_points=horse_topfinal_key_points
}

player1_bottomfinal_horseprop={
	player1_default_horseprop
	key_points=horse_bottomfinal_key_points
}

player2_bottomfinal_horseprop={
	player2_default_horseprop
	key_points=horse_bottomfinal_key_points
}



horse_final_prop_default={
	font="title.fnt"
	just=(0,0)
	dims=(320,112)
	colors=[
		{(128,128,128) alpha=128}
		{(255,245,0) alpha=128}
		{(195,20,20) alpha=128}
	]
	key_points=[
		{pos=(320,224) alpha=0 scale=1.0 time=0}
		{alpha=128 time=5.0}
	]
}

// ****************************************************
// * HORSE LOGIC
// ****************************************************

script remove_skater_from_world
	printf "removing skater to the world"
	RemoveSkaterFromWorld
endscript

script add_skater_to_world
	printf "adding skater to the world"
	AddSkaterToWorld
	ResetLookAround
endscript



script print_horse_string
	if IsCurrentHorseSkater 0
		if GotParam Top
			ApplyToHorsePanelString {
				whichString=<whichString>
				callback=LaunchPanelMessage
				properties=player1_top_horseprop
				id=Top
			}
		else
			if GotParam Bottom
				ApplyToHorsePanelString {
					whichString=<whichString>
					callback=LaunchPanelMessage
					properties=player1_bottom_horseprop
					id=Bottom
				}

			else
				if GotParam Topfinal
					ApplyToHorsePanelString {
						whichString=<whichString>
						callback=LaunchPanelMessage
						properties=player1_topfinal_horseprop
						id=TopFinal
					}
				else
					if GotParam Bottomfinal
						ApplyToHorsePanelString {
							whichString=<whichString>
							callback=LaunchPanelMessage
							properties=player1_bottomfinal_horseprop
							id=BottomFinal
						}

					else
						ApplyToHorsePanelString {
							whichString=<whichString>
							callback=LaunchPanelMessage
							properties=player1_default_horseprop
							id=Top
						}
					endif
				endif
			endif
		endif
	else
		if GotParam Top
			ApplyToHorsePanelString {
				whichString=<whichString>
				callback=LaunchPanelMessage
				properties=player2_top_horseprop
				id=Top
			}
		else
			if GotParam Bottom
				ApplyToHorsePanelString {
					whichString=<whichString>
					callback=LaunchPanelMessage
					properties=player2_bottom_horseprop
					id=Bottom
				}
			else
				if GotParam Topfinal
					ApplyToHorsePanelString {
						whichString=<whichString>
						callback=LaunchPanelMessage
						properties=player2_topfinal_horseprop
						id=TopFinal
					}
				else
					if GotParam Bottomfinal
						ApplyToHorsePanelString {
							whichString=<whichString>
							callback=LaunchPanelMessage
							properties=player2_bottomfinal_horseprop
							id=BottomFinal
						}

					else
						ApplyToHorsePanelString {
							whichString=<whichString>
							callback=LaunchPanelMessage
							properties=player2_default_horseprop
							id=Top
						}
					endif
				endif
			endif
		endif
	endif
endscript

script horse_start_run
	kill_start_key_binding
	//	printf "entering horse_start_run"
	;	ScreenElementSystemCleanup
	// startup
	ClearTrickAndScoreText
	StartHorseRun
	ShowClock

	// disable the inactive player as appropriate
	disable_inactive_horse_player

	wait 1 gameframe
	// wait for any other messages to die down before we pause the game
	WaitForPanelDone

	// display a panel message synchronously in the gameflow
	printf "***** PAUSING GAME *****"
	exit_pause_menu
	kill_start_key_binding
	PauseGame
	print_horse_string { whichString=playerName			Top }
	print_horse_string { whichString=horseprerun	Bottom }

	WaitForPanelDone
	GetPreferenceChecksum pref_type=splitscreen horse_time_limit
	switch <checksum>
		case horse_time_10
			horse_time = 10
		case horse_time_20
			horse_time = 20
		case horse_time_30
			horse_time = 30
	endswitch
	StartGoal_Horse_Mp time=<horse_time>
	//	WaitForX
	printf "***** UNPAUSING GAME *****"
	if IsCurrentHorseSkater 0
		skater:ResetLookAround
		Skater:RunStarted
	else
		skater2:ResetLookAround
		Skater2:RunStarted
	endif
	horse_check_for_controller_unplugged_dialog
	UnpauseGame
	restore_start_key_binding

	GetHorseString whichString=panelString1
	update_horse_score id=horse_score_1 <...>
	GetHorseString whichString=panelString2
	update_horse_score id=horse_score_2 <...>
	GetHorseString whichString=horsePreRun
	update_horse_score id=horse_score_3 <...>

	// it takes 1 frame for the game to actually unpause
	wait 1 gameframe

	//	printf "exiting horse_start_run"
endscript

script disable_inactive_horse_player
	//	printf "entering disable_inactive_horse_player"

	if IsCurrentHorseSkater 0
		printf "unhiding skater 0"
		SetScreenMode horse1
		MakeSkaterGosub add_skater_to_world skater=0
		DoScreenElementMorph { id=player1_panel_container alpha=1 }
		printf "hiding skater 1"
		MakeSkaterGosub remove_skater_from_world skater=1
		DoScreenElementMorph { id=player2_panel_container alpha=0 }
		printf "*** done"
		printf "************** ABOUT TO DO CONTROLLER ENABLING 1"
		skater2:DisablePlayerInput
		skater2:PausePhysics
		skater:EnablePlayerInput
		skater:UnpausePhysics

		;PauseSkater 1
		;UnpauseSkater 0

		// only the first player can pause
		;SetFrontEndPad 0
	else
		if IsCurrentHorseSkater 1
			printf "unhiding skater 1"
			SetScreenMode horse2
			MakeSkaterGosub add_skater_to_world skater=1
			DoScreenElementMorph { id=player2_panel_container alpha=1 }
			printf "hiding skater 0"
			MakeSkaterGosub remove_skater_from_world skater=0
			DoScreenElementMorph { id=player1_panel_container alpha=0 }
			printf "*** done"

			;PauseSkater 0
			;UnpauseSkater 1
			printf "************** ABOUT TO DO CONTROLLER ENABLING 2"
			skater:DisablePlayerInput
			skater:PausePhysics
			skater2:EnablePlayerInput
			skater2:UnpausePhysics

			// only the second player can pause
			;SetFrontEndPad 1
		endif
	endif

	// just ensure cameras are set up as they would be in normal gameplay, so we don't
	// get the initial blue screen for P2
	SetActivecamera id=skatercam0 viewport=0
	SetActiveCamera id=skatercam1 viewport=1


	//	printf "exiting disable_inactive_horse_player"
endscript

script horse_end_run
	kill_start_key_binding
	//LoadSound "Shared\Animal\HorseWhinny"	 //commented out 03/11/03
	printf "entering horse_end_run"

	// this function updates the postrun menu
	EndHorseRun
	EndGoal_Horse_Mp

	// wait for any other messages to die down
	// before we pause the msgs
	WaitForPanelDone

	// display a panel message synchronously in the gameflow
	printf "***** PAUSING GAME *****"
	exit_pause_menu
	kill_start_key_binding
	PauseGame

	play_appropriate_horse_sound

	if HorseEnded
		printf "HORSE GAME DONE"
		print_horse_string { whichString=youarea		Topfinal }
		print_horse_string { whichString=finalword		Bottomfinal }
		wait 120 gameframes
		if ObjectExists id=horse_score_menu
			DestroyScreenElement id=horse_score_menu
		endif
		MakeSkaterGosub add_skater_to_world skater=0
		MakeSkaterGosub add_skater_to_world skater=1
	else
		print_horse_string { whichString=playerName		Top }
		print_horse_string { whichString=horsepostrun	Bottom }
	endif

	WaitForPanelDone
	SwitchHorsePlayers
	printf "***** UNPAUSING GAME *****"

	wait 1 gameframe

	printf "exiting horse_end_run"
	if HorseEnded
		restore_start_key_binding
		create_end_run_menu
	else
		horse_check_for_controller_unplugged_dialog
		UnpauseGame
	endif
endscript

script horse_uninit
	;MakeSkaterGosub add_skater_to_world skater=0
	;MakeSkaterGosub add_skater_to_world skater=1
	;UseBothPadsInFrontEnd
endscript

script kill_horse_panel_messages
	if ObjectExists id=Top
		DestroyScreenElement id=Top
	endif
	if ObjectExists id=Bottom
		DestroyScreenElement id=Bottom
	endif
	if ObjectExists id=TopFinal
		DestroyScreenElement id=TopFinal
	endif
	if ObjectExists id=BottomFinal
		DestroyScreenElement id=BottomFinal
	endif
endscript

script horse_check_for_controller_unplugged_dialog
	begin
		if not ScreenElementExists id=controller_unplugged_dialog_anchor
			root_window:GetTags
			if GotParam menu_state
				if ( <menu_state> = off )
					break
				endif
			else
				break
			endif
		endif
		wait 1 gameframe
	repeat
endscript


script create_horse_panel_message

	FormatText ChecksumName=text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	chaos1=Random(@1 @2)
	chaos2=Random(@3 @4)
	switch <id>
		case Top
			message_pos=(320,150)
			message_color=<text_rgba>
			<style>=play_horse_animation
		case Bottom
			message_pos=(320,180)
			message_color=[108 112 120 128]
			<style>=play_horse_animation2
		case TopFinal
			message_pos=(320,150)
			message_color=<text_rgba>
			<style>=play_horse_animation_final_1
		case BottomFinal
			message_pos=(320,180)
			message_color=<text_rgba>
			<style>=play_horse_animation_final_2
		default
	endswitch
	create_panel_block <...> style=<style> pos=<message_pos> rgba=<message_color> dims=(450, 0) z_priority=10 // time = 3000
endscript


script play_horse_animation

	switch <chaos1>

		case 1

			DoMorph time=0 scale=0 alpha=0 pos=(320, 0)
			DoMorph time=.3 scale=1.2 alpha=1 pos=(320, 130)
			DoMorph time=.1 pos=(321, 133)
			DoMorph time=.1 pos=(319, 129)
			DoMorph time=.1 pos=(322, 131)
			DoMorph time=.1 pos=(318, 127)
			DoMorph time=.1 pos=(321, 131)
			DoMorph time=.1 pos=(317, 129)
			DoMorph time=.1 pos=(323, 130)
			DoMorph time=.1 pos=(319, 129)
			DoMorph time=.1 pos=(319, 129)
			DoMorph time=.1 pos=(322, 131)
			DoMorph time=.1 pos=(318, 127)
			DoMorph time=.1 pos=(321, 131)
			DoMorph time=.1 pos=(317, 129)
			DoMorph time=.1 pos=(323, 130)
			DoMorph time=.1 pos=(319, 129)
			DoMorph time=.15 scale=0 alpha=0
			Die



		case 2


			DoMorph time=0 scale=0 alpha=0 pos=(320, 500)
			DoMorph time=.2
			DoMorph time=.3 scale=1.2 alpha=1 pos=(320, 130)
			DoMorph time=.1 pos=(321, 133)
			DoMorph time=.1 pos=(319, 129)
			DoMorph time=.1 pos=(322, 131)
			DoMorph time=.1 pos=(318, 127)
			DoMorph time=.1 pos=(321, 131)
			DoMorph time=.1 pos=(317, 129)
			DoMorph time=.1 pos=(323, 130)
			DoMorph time=.1 pos=(319, 129)
			DoMorph time=.1 pos=(319, 129)
			DoMorph time=.1 pos=(322, 131)
			DoMorph time=.1 pos=(318, 127)
			DoMorph time=.1 pos=(321, 131)
			DoMorph time=.1 pos=(317, 129)
			DoMorph time=.1 pos=(323, 130)
			DoMorph time=.1 pos=(319, 129)
			DoMorph time=.15 scale=4 alpha=0
			Die

	endswitch

endscript



script play_horse_animation2

	switch <chaos2>

		case 3

			DoMorph time=0 scale=0 alpha=0 pos=(0, 150)
			DoMorph time=.3
			DoMorph time=.1 scale=1 alpha=1 pos=(320, 150)
			DoMorph time=.1 pos=(321, 153)
			DoMorph time=.1 pos=(319, 149)
			DoMorph time=.1 pos=(322, 151)
			DoMorph time=.1 pos=(318, 147)
			DoMorph time=.1 pos=(321, 151)
			DoMorph time=.1 pos=(317, 149)
			DoMorph time=.1 pos=(323, 150)
			DoMorph time=.1 pos=(319, 149)
			DoMorph time=.1 pos=(321, 153)
			DoMorph time=.1 pos=(319, 149)
			DoMorph time=.1 pos=(322, 151)
			DoMorph time=.1 pos=(318, 147)
			DoMorph time=.1 pos=(321, 151)
			DoMorph time=.1 pos=(317, 149)
			DoMorph time=.1 pos=(323, 150)
			DoMorph time=.1 pos=(319, 149)
			SetProps blur_effect
			do_blur_effect
			SetProps no_blur_effect
			DoMorph time=.15 pos=(640, 150) alpha=0
			Die



		case 4


			DoMorph time=0 scale=0 alpha=0 pos=(700, 150)
			DoMorph time=.3
			DoMorph time=.1 scale=1 alpha=1 pos=(320, 150)
			DoMorph time=.1 pos=(321, 153)
			DoMorph time=.1 pos=(319, 149)
			DoMorph time=.1 pos=(322, 151)
			DoMorph time=.1 pos=(318, 147)
			DoMorph time=.1 pos=(321, 151)
			DoMorph time=.1 pos=(317, 149)
			DoMorph time=.1 pos=(323, 150)
			DoMorph time=.1 pos=(319, 149)
			DoMorph time=.1 pos=(321, 153)
			DoMorph time=.1 pos=(319, 149)
			DoMorph time=.1 pos=(322, 151)
			DoMorph time=.1 pos=(318, 147)
			DoMorph time=.1 pos=(321, 151)
			DoMorph time=.1 pos=(317, 149)
			DoMorph time=.1 pos=(323, 150)
			DoMorph time=.1 pos=(319, 149)
			SetProps blur_effect
			do_blur_effect
			SetProps no_blur_effect
			DoMorph time=.15 scale=4 alpha=0
			Die

	endswitch

endscript


script play_horse_animation_final_1

	DoMorph time=0 scale=0 alpha=0 pos=(320, 130)
	DoMorph time=.3 scale=1.2 alpha=1 pos=(320, 130)
	DoMorph time=.1 pos=(321, 133)
	DoMorph time=.1 pos=(319, 129)
	DoMorph time=.1 pos=(322, 131)
	DoMorph time=.1 pos=(318, 127)
	DoMorph time=.1 pos=(321, 131)
	DoMorph time=.1 pos=(317, 129)
	DoMorph time=.1 pos=(323, 130)
	DoMorph time=.1 pos=(319, 129)
	DoMorph time=.1 pos=(322, 131)
	DoMorph time=.1 pos=(318, 127)
	DoMorph time=.1 pos=(321, 131)
	DoMorph time=.1 pos=(317, 129)
	DoMorph time=.1 pos=(323, 130)
	DoMorph time=.1 pos=(319, 129)
	DoMorph time=.2 scale=0 alpha=0 pos=(319, 500)
	Die

endscript


script play_horse_animation_final_2

	DoMorph time=0 scale=0 alpha=0 pos=(320, 170)
	DoMorph time=.2 scale=1.9 alpha=1 pos=(320, 150)
	DoMorph time=.22 scale=1.2
	DoMorph time=.23 scale=1.5
	DoMorph time=.32 scale=1.3
	DoMorph time=.1 pos=(321, 153)
	DoMorph time=.1 pos=(319, 149)
	DoMorph time=.1 pos=(322, 151)
	DoMorph time=.1 pos=(318, 147)
	DoMorph time=.1 pos=(321, 151)
	DoMorph time=.1 pos=(317, 149)
	DoMorph time=.1 pos=(323, 150)
	DoMorph time=.1 pos=(319, 149)
	DoMorph time=.1 pos=(322, 151)
	DoMorph time=.1 pos=(318, 147)
	SetProps blur_effect
	do_blur_effect
	SetProps no_blur_effect
	DoMorph time=.4 scale=6 alpha=0 pos=(320, 150)
	Die

endscript



