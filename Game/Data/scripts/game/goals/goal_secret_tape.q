// Find the secret tape!


Script initialize_secret_tapes

	GetCurrentLevel

	// figure the level num
	switch <level>
		case load_skateshop
			<level_num> = 0
		case load_nj
			<level_num> = 1
			FormatText ChecksumName=tape_icon "TRG_NJ_SECRET_TAPE01"
			<gFlag> = GOT_SECRET_TAPE_NJ
		case load_ny
			<level_num> = 2
			FormatText ChecksumName=tape_icon "TRG_NY_SECRET_TAPE01"
			<gFlag> = GOT_SECRET_TAPE_NY
		case load_fl
			<level_num> = 3
			FormatText ChecksumName=tape_icon "TRG_FL_SECRET_TAPE01"
			<gFlag> = GOT_SECRET_TAPE_FL
		case load_sd
			<level_num> = 4
			FormatText ChecksumName=tape_icon "TRG_SD_SECRET_TAPE01"
			<gFlag> = GOT_SECRET_TAPE_SD
		case load_hi
			<level_num> = 5
			FormatText ChecksumName=tape_icon "TRG_HI_SECRET_TAPE01"
			<gFlag> = GOT_SECRET_TAPE_HI
		case load_vc
			<level_num> = 6
			FormatText ChecksumName=tape_icon "TRG_VC_SECRET_TAPE01"
			<gFlag> = GOT_SECRET_TAPE_VC
		case load_sj
			<level_num> = 7
			FormatText ChecksumName=tape_icon "TRG_SJ_SECRET_TAPE01"
			<gFlag> = GOT_SECRET_TAPE_SJ
		case load_ru
			<level_num> = 8
			FormatText ChecksumName=tape_icon "TRG_RU_SECRET_TAPE01"
			<gFlag> = GOT_SECRET_TAPE_RU
		case load_se
			<level_num> = 9
			FormatText ChecksumName=tape_icon "TRG_SE_SECRET_TAPE01"
			<gFlag> = GOT_SECRET_TAPE_SE
		default
			return
	endswitch

	if NodeExists <tape_icon>
		if IsAlive name=<tape_icon>
			if GameModeEquals is_career
				if GetGLobalFlag flag=<gFlag>
					kill name=<tape_icon>
				endif
			else
				kill name=<tape_icon>
			endif
		endif
	endif

Endscript

Script Secret_Tape
	Obj_SetException ex = SkaterInRadius scr = Secret_Tape_Got
	Obj_SetInnerRadius 10
	Obj_RotY speed=250
	Obj_Hover Amp=10 Freq=1
Endscript

Script Secret_Tape_Got
	Obj_ClearExceptions
	;Obj_ClearExceptions
	PlayStream UnlockOldTHPSLevel priority=StreamPriorityHighest
	create_panel_block id=goal_complete text="Secret Tape Found!" style=panel_message_found_secret
	//WaitForEvent type=panel_message_goalcomplete_done
	;create_panel_sprite id=goal_complete_sprite texture=GO_done style=panel_message_found_secret
	;WaitForEvent type=panel_sprite_goalcomplete_done
	;create_panel_message id=goal_complete_line2 text="Collected!" style=panel_message_goalcompleteline2


	GetCurrentLevel
	switch <level>
		case load_nj
			SetGlobalFlag flag = GOT_SECRET_TAPE_NJ
		case load_ny
			SetGlobalFlag flag = GOT_SECRET_TAPE_NY
		case load_fl
			SetGlobalFlag flag = GOT_SECRET_TAPE_FL
		case load_sd
			SetGlobalFlag flag = GOT_SECRET_TAPE_SD
		case load_hi
			SetGlobalFlag flag = GOT_SECRET_TAPE_HI
		case load_vc
			SetGlobalFlag flag = GOT_SECRET_TAPE_VC
		case load_sj
			SetGlobalFlag flag = GOT_SECRET_TAPE_SJ
		case load_ru
			SetGlobalFlag flag = GOT_SECRET_TAPE_RU
		case load_se
			SetGlobalFlag flag = GOT_SECRET_TAPE_SE
	endswitch

	GetTotalTapesCollected

	//see if a movie should be played
	switch <secret_tape_total>
		case 3
			//play Bails movie
			SetGlobalFlag flag=MOVIE_UNLOCKED_CAS
			SpawnScript secret_tape_play_movie params={movie_file="movies\probail1" name="Bails 1"}
		case 6
			//play Bails 2 movie
			SetGlobalFlag flag=MOVIE_UNLOCKED_BAILS2
			SpawnScript secret_tape_play_movie params={movie_file="movies\probail2" name="Bails 2"}
		case 9
			//play Neversoft movie
			SetGlobalFlag flag=MOVIE_UNLOCKED_HOMIES1
			SpawnScript secret_tape_play_movie params={movie_file="movies\homiesp1" name="Always Hard"}
	endswitch

	Die
Endscript

script GetTotalTapesCollected
	<secret_tape_total>=0
	if GetGlobalFlag flag=GOT_SECRET_TAPE_NJ
		<secret_tape_total>=(<secret_tape_total>+1)
	endif

	if GetGlobalFlag flag=GOT_SECRET_TAPE_NY
		<secret_tape_total>=(<secret_tape_total>+1)
	endif
	if GetGlobalFlag flag=GOT_SECRET_TAPE_FL
		<secret_tape_total>=(<secret_tape_total>+1)
	endif
	if GetGlobalFlag flag=GOT_SECRET_TAPE_SD
		<secret_tape_total>=(<secret_tape_total>+1)
	endif
	if GetGlobalFlag flag=GOT_SECRET_TAPE_HI
		<secret_tape_total>=(<secret_tape_total>+1)
	endif
	if GetGlobalFlag flag=GOT_SECRET_TAPE_VC
		<secret_tape_total>=(<secret_tape_total>+1)
	endif
	if GetGlobalFlag flag=GOT_SECRET_TAPE_SJ
		<secret_tape_total>=(<secret_tape_total>+1)
	endif
	if GetGlobalFlag flag=GOT_SECRET_TAPE_RU
		<secret_tape_total>=(<secret_tape_total>+1)
	endif
	if GetGlobalFlag flag=GOT_SECRET_TAPE_SE
		<secret_tape_total>=(<secret_tape_total>+1)
	endif
	return secret_tape_total=<secret_tape_total>
endscript

script secret_tape_play_movie
	printf "secret_tape_play_movie"

	if not GotParam movie_file
		printf "secret_tape_play_movie MISSING PARAM movie_file!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	endif

	wait 2 seconds
	PauseGame
	pause_rain
	FormatText TextName=text "You've unlocked the %s video.\nWatch it now?" s=<name>
	create_dialog_box { title="Movie Unlocked"
		text=<text>
		pos=(310 ,240)
		just=[center center]
		text_rgba=[88 105 112 128]
		;text_dims=(320,0)
		text_dims=(330,0)
		;style=special_dialog_style
		pad_back_script = <back_script>
		buttons=[
			{ font=small text="Yes" pad_choose_script=really_watch_secret_tape_movie pad_choose_params={<...>}}
			{ font=small text="No" pad_choose_script=back_to_game_from_secret_tape } ]
		delay_input
	}

endscript

script really_watch_secret_tape_movie
	;wait 3 seconds

	dialog_box_exit
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif


	do_unload_unloadable
	goalmanager_levelunload
	cleanup preserve_skaters                ; unload all level, except for skaters
	KillMessages
	mempushcontext 0
	playmovie <movie_file>
	mempopcontext



	do_load_unloadable
	mempushcontext 0
	DisplayLoadingScreen "loadscrn_generic"
	mempopcontext
	GetCurrentLevel             ; returns level = load_????    (e.g. load_rio)

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	change_level level=<level>
	restore_start_key_binding
endscript

script back_to_game_from_secret_tape
	dialog_box_exit
	UnPauseGame
	unpause_rain
endscript

script GetLevelNumTapeCollected

	switch <level>
		case 1
			<flag>=GOT_SECRET_TAPE_NJ
		case 2
			<flag>=GOT_SECRET_TAPE_NY
		case 3
			<flag>=GOT_SECRET_TAPE_FL
		case 4
			<flag>=GOT_SECRET_TAPE_SD
		case 5
			<flag>=GOT_SECRET_TAPE_HI
		case 6
			<flag>=GOT_SECRET_TAPE_VC
		case 7
			<flag>=GOT_SECRET_TAPE_SJ
		case 8
			<flag>=GOT_SECRET_TAPE_RU
		case 10
			<flag>=GOT_SECRET_TAPE_SE
	endswitch

	<collected>=0
	if (GetGlobalFlag flag=<flag>)
		<collected>=1
	endif

	return collected=<collected>
endscript
