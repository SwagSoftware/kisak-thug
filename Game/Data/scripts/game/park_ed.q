; *****************************************************
; *
; * UTILITY SCRIPTS
; *
; *****************************************************

// These globals used to be in sk5ed_scripts.q, but that was causing problems when doing a quick export from
// MAX due to the globals getting reloaded, so moved them here as a quick fix.
park_side_to_move=0
ThemeIndicesA=[1,2,3,4,5,6,7,8,9,10,16,17,19,21,23,24] // The premade parks for theme 1
ThemeIndicesB=[11,12,13,14,15,18,20,22,25] // The premade parks for theme 2


script DoParkGeneration

	setgametype creategoals

	MemPushContext 0    ; Mick - Ensure loaded levels go on the game heap
	PreLevelLoad
	if GameModeEquals is_parkeditor
		if IsXbox
			DisplayLoadingScreen "loadscrn_editor_x"
		endif
		if IsNgc
			DisplayLoadingScreen "loadscrn_editor_ngc"
		endif
		if IsPS2
			DisplayLoadingScreen "loadscrn_editor"
		endif
	else
		if IsXbox
			DisplayLoadingScreen "loadscrn_editor_x"
		endif
		if IsNgc
			DisplayLoadingScreen "loadscrn_editor_ngc"
		endif
		if IsPS2
			DisplayLoadingScreen "loadscrn_editor_play"
		endif
	endif
	LaunchLevel Level=custom_park
	printf "Ryan: finished 'LaunchLevel' call"
	PostLevelLoad
	ResetCamera         ; Mick - temp patch to when demoing, the camera will reset between levels
	MemPopContext

	SetBackgroundColor { r=0, g=0, b=0, alpha=0 }
	//SetBSPAmbientColor { r=0, g=0, b=0, alpha=0 }
	//SetDFFAmbientColor { r=84, g=84, b=84, alpha=0 }
	SetClippingDistances near = 12 far = 22000
	LaunchConsoleMessage "Stats at 10" 2

	//Place Piece:  GUI_placeblock1
	//Erase Piece: GUI_removeblock1
	//Change Set: select1
	//Change Piece: selct2b (this is always in SRAM)
	//GUI_buzzer01

	LoadPreFile "parked_sounds.pre"
	LoadSound "ParkEd\GUI_placeblock1"
	LoadSound "ParkEd\GUI_removeblock1"
	LoadSound "ParkEd\select1"
	LoadSound "Shared\Menu\GUI_buzzer01"
	UnloadPreFile "parked_sounds.pre"

	;setcurrentgametype	; removes freeskate
	;setgamestate on
	;LaunchMenuScreen screen=game_menu not_active
endscript




script Ed_DropinSkater
	printf "Ed_DropinSkater"
	ParkEditorCommand command=SetCustomParkPlay on
	;SkipMusicTrack
	;UnPauseMusicAndStreams
endscript




script Ed_RunCommand
	// Added by SP: on a retry, we need to get the music going again
	;If GotParam MusicAndStreams
	;	printf "Unpausing...................."
	;	UnPauseMusicAndStreams
	;	SkipMusicTrack
	;endif
	ParkEditorCommand <...>
endscript




// total hack
script Ed_ThemeSwitch
	change_level level=custom_park game=parkeditor
endscript



script PlayEdPlaceSound
	PlaySound GUI_placeblock1 vol=60
	printf "Play Place Sound"
endscript




script PlayEdEraseSound
	PlaySound GUI_removeblock1 vol=60
	//	printf "Play Erase Sound"
endscript




script PlayEdChangeSetSound
	PlaySound select1 vol=60
	//	printf "Play Change Set Sound"
endscript




script PlayEdChangePieceSound
	PlaySound select2b vol=60
	//	printf "Play Change Piece Sound"
endscript




script PlayEdBuzzSound
	PlaySound GUI_buzzer01 vol=60
	//	printf "Play Buzzer Sound"
endscript

script PlayRaiseGroundSound
	PlaySound MenuUp pitch=35
endscript

script PlayLowerGroundSound
	PlaySound MenuUp pitch=24
endscript

script PlayRotatePieceSound
	PlaySound menu03 pitch=55
endscript

