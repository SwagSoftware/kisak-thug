// start autoduck documentation
// @DOC memcard
// @module memcard | None
// @subindex Scripting Database
// @index script | memcard

// Version numbers for various memory card formats
// (Whenever the format of one of these file types has changed such that
// an old save will not load, increment its version number.)
VERSION_OPTIONSANDPROS = 31
VERSION_NETWORKSETTINGS = 9
VERSION_CAS = 19
VERSION_CAT = 1
VERSION_PARK = 5
VERSION_REPLAY = 30
VERSION_CREATEDGOALS = 3

// Foreign Language Sku Product Codes
// ENG - SLES-51130
// FRE - SLES-51131
// GER - SLES-51132

// This is defined as a global so that the c-code can read it too.
MAX_MEMCARD_FILENAME_LENGTH=15

// These are the fixed save sizes for each save type.
// They can be any number of bytes, they don't have to be a multiple of anything.
// These are the same for all platforms.
// The code will assert if the required size exceeds these values.
// The total space used on the card for the different platforms will depend on the
// platform's block size, & how it stores its icons etc.
// These should be kept as close to the minimum required as possible.
SaveSize_OptionsAndPros=90000 // As of 8/29/2002, max required space = 37675 (GJ 5/12/03: added 20K for face texture data)
SaveSize_NetworkSettings=1100
SaveSize_Cat=34000 // TODO Tweak this
SaveSize_Park=35000
SaveSize_Replay=300000
SaveSize_CreatedGoals=100000 // TODO Tweak this

; These are the extra space required, in K, for the icon.sys and .ico files.
; These are used when displaying the total space required for a particular save.
; To calculate, take the size of the .ico file, divide by 1024, round up to the
; next integer, then add 1 because the icon.sys file is 964 bytes, so needs 1K.
/* PS2 Only */  CATIconSpaceRequired=14
/* PS2 Only */  ParkIconSpaceRequired=13
/* PS2 Only */  OptionsProsIconSpaceRequired=14
/* PS2 Only */  NetworkSettingsIconSpaceRequired=15
/* PS2 Only */  CreatedGoalsIconSpaceRequired=14

// Old! No longer used, replays are no more.
/* PS2 Only */  ReplayIconSpaceRequired=19

BadVersionNumber='BAD VERSION!'
DamagedFile='DAMAGED!'
NGCDamagedFile='CORRUPT FILE!'

SavingOrLoading=Saving

///////////////////////////////////////////////////////////////////////////
// Utility scripts
///////////////////////////////////////////////////////////////////////////

// Passed in a file type as a checksum, this will generate a string name called filetype_name
script GetFileTypeName
	switch <file_type>
		case OptionsAndPros
			return filetype_name='STORY/SKATER'
		case NetworkSettings
			if IsXBox
				return filetype_name='SYSTEM LINK SETTINGS'
			else
				return filetype_name='NETWORK SETTINGS'
			endif
		case Cas
			return filetype_name='SKATER'
		case CAT
			return filetype_name='TRICK'
		case Park
			return filetype_name='PARK'
		case Replay
			return filetype_name='REPLAY'
		case CreatedGoals
			return filetype_name='GOALS'
		default
			return filetype_name=''
	endswitch
endscript

// Quits to the platform's shell. Run by the 'Manage Card' option.
script QuitToDashboard
	GetPlatform

	switch <Platform>
		case PS2
			// This should work, but just seems to crash on my dev kit?
			ResetPS2

		case XBox
			GotoXboxDashboard memory total_blocks_needed=<total_blocks_needed>

		case NGC
			ResetToIPL

	endswitch
endscript

///////////////////////////////////////////////////////////////////////////
// Destroy scripts
///////////////////////////////////////////////////////////////////////////

script destroy_pause_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 gameframe
	endif
	kill_start_key_binding
endscript

script destroy_main_menu
	;KillSpawnedScript name=Skateshop_Slideshow
	;KillSkaterCamAnim all

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 gameframe
	endif
endscript

script destroy_files_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 frame
	endif
endscript

script destroy_net_settings_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 gameframe
	endif
	// No textures to remove for this one.
endscript

script destroy_internet_options_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 gameframe
	endif
endscript

script destroy_level_select
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 frame
	endif
endscript

script ResetAbortAndDoneScripts
	Change DoneScript=DefaultDoneScript
	Change AbortScript=DefaultAbortScript
	Change RetryScript=DefaultRetryScript
	Change SavingOrLoading=Saving
endscript

///////////////////////////////////////////////////////////////////////////
// DoneScript stuff
///////////////////////////////////////////////////////////////////////////
DoneScript=DefaultDoneScript

script DefaultDoneScript
	printf "DefaultDoneScript called !!!"
endscript

///////////////////////////////////////////////////////////////////////////
// AbortScript stuff
///////////////////////////////////////////////////////////////////////////

// The AbortScript gets run whenever a particular save/load sequence is quit out of,
// or finishes, or goes to an error message.
// The AbortScript will cleanup by removing all memcard menu specific textures, and
// then go back to the previous menu.
AbortScript=DefaultAbortScript

script DefaultAbortScript
	printf "DefaultAbortScript called !!!"
endscript

// All the AbortScript's call this first.
script memcard_menus_cleanup
	EnableReset // Only has an effect on GameCube
	dialog_box_exit no_pad_start
	destroy_files_menu
	destroy_onscreen_keyboard
	if not ( LevelIs load_skateshop )
		;GoalManager_ShowPoints
		if not GoalManager_HasActiveGoals
			;GoalManager_ShowGoalPoints
		endif
	endif
	//TT2597: remove any gradiant from cutscenes
	pause_menu_gradient off
endscript

///////////////////////////////////////////////////////////////////////////
// AbortScripts
//
// The Change command is used to change the value of AbortScript to one
// of these whenever a memcard load/save sequence is entered.
// That way the memcard scripts can just goto AbortScript whenever they need
// to abort, rather than having to pass some 'previous menu' parameter around,
// which gets rather messy.
// Hoorah for global variables!
//
///////////////////////////////////////////////////////////////////////////

script back_to_main_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	create_main_menu
	// Would be nice to be able to highlight the load option here.
endscript

script back_to_main_menu2
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	launch_main_menu
endscript

script career_autoload_launch_current_level
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	;KillSkaterCamAnim current
	;RefreshSkaterModel profile=0 skater=0

	if not GetGlobalFlag flag=SOUNDS_SONGORDER_RANDOM
		PlaySongsInOrder
	else
		PlaySongsRandomly
	endif

	GoalManager_GetCurrentChapterAndStage
	if not ( (<currentChapter>=9) || (<currentChapter>=24) || (<currentChapter>=25) )
		level=( (CHAPTER_LEVELS[<currentChapter>]).checksum )
	else
		level=load_nj
	endif

	load_mainmenu_textures_to_main_memory unload

	change_level level=<level>
endscript

script back_to_pre_cas_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	create_pre_cas_menu
endscript

script back_to_pause_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	restore_start_key_binding
	if ( save_successful = 1 )
		printf "save complete ========================="
		parked_quit level=load_skateshop
	else
		printf "save aborted ========================="
		create_pause_menu
	endif
	change save_successful=2
endscript

script back_to_end_replay_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	create_in_game_end_replay_menu
endscript

script back_to_net_settings_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	;create_manual_net_setup
	create_network_options_menu
endscript

script back_to_beat_goal
	memcard_menus_cleanup
	GoalManager_ShowPoints
	ResetAbortAndDoneScripts
	goal_save_reject
endscript

script back_to_select_skater
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	launch_select_skater_menu
endscript

script back_to_options_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	create_setup_options_menu
	; Would be nice to be able to highlight the load option here.
endscript

script back_to_career_options_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts

	Skater:Unhide
	create_career_options_menu
	; Would be nice to be able to highlight the load option here.
endscript

script back_to_created_park_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	if (still_in_net_area = 1)
		back_to_net_host_options
	else
		/*if LevelIs load_sk5ed_gameplay
			if (created_park_warning = 1)
					change created_park_warning=0
					level_select_change_level level=load_sk5ed_gameplay <...> show_warning
			else
					level_select_change_level level=load_sk5ed_gameplay <...>
			endif
		else*/
		return_to_created_park_menu
		;endif
	endif
	; Would be nice to be able to highlight the load option here.
endscript

script load_loaded_created_park
	dialog_box_exit
	// Zac: (TT 13606) Now checking max players when loading park. Need to force level change if loading
	// a created park in net game. Otherwise, any new players will be sent to wrong park.
	if LevelIs load_sk5ed_gameplay
		if inNetGame
			level_select_change_level level=load_sk5ed_gameplay <...> show_warning
			return
		endif
	endif
	return_to_created_park_menu
endscript

script back_to_net_host_options
	prefs=network
	field="level"
	string="Created Park"
	checksum=load_sk5ed_gameplay
	select_host_option <...>

	change still_in_net_area = 0

	;KillSkaterCamAnim all
	;PlaySkaterCamAnim name=SS_MenuCam play_hold
	if ObjectExists id=host_options_menu
		DestroyScreenElement id=host_options_menu
	endif
	create_network_host_options_menu
endscript

script back_to_internet_options_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	if ( load_successful = 1 )
		get_upload_description type=<type> filename=<filename>
	else
		create_internet_options
	endif
	change load_successful=2
	change loadforupload = 0
endscript

script back_to_cat_pause
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	create_CAT_pause_menu
endscript

script back_to_pre_cat_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	create_pre_CAT_menu
endscript

script back_to_edit_cat_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	create_CAT_menu load=0
endscript

script finish_loading_cat
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	auto_assign_cat_to_slot
endscript

script back_to_edit_tricks_menu
	memcard_menus_cleanup
	ResetAbortAndDoneScripts
	create_edit_tricks_menu
endscript

///////////////////////////////////////////////////////////////////////////
// RetryScript stuff
///////////////////////////////////////////////////////////////////////////

// The RetryScript gets run whenever the 'Retry' option in a retry/quit menu is run.
RetryScript=DefaultRetryScript

script DefaultRetryScript
	printf "DefaultRetryScript called !!!"
endscript

///////////////////////////////////////////////////////////////////////////
//
// "Checking Card" message stuff
//
///////////////////////////////////////////////////////////////////////////

script mem_card_message_pause
	DisableReset // Only has an effect on GameCube

	if not GotParam NoTimerReset
		ResetTimer
	endif

	change check_for_unplugged_controllers = 0

	; This is used to only do a CardIsInSlot every few frames, because it is too slow to do every frame.
	<CardCheckCounter>=0

	begin
		// Part of fix to TT11597, where pulling controller at various places during saving a goal
		// could cause soft freeze.
		// Note: As a new fix to TT5997, I disabled controller unplugging altogether during this script,
		// so in theory the controller_unplugged_dialog_anchor should never exist.
		// But do the check anyway just to be sure.
		if not CustomParkMode editing
			if ScreenElementExists id=controller_unplugged_dialog_anchor
				// Ensure the flag is set back to 1 whenever this script is exited.
				change check_for_unplugged_controllers = 1
				goto NullScript
			endif
		endif

		; XBox does not need to check for card removal, cos we're only ever using the hard disk.
		; But CardIsInSlot will always return true for XBox, so it doesn't matter that we're still doing
		; this check.

		if not GotParam NoCardRemovalCheck
			; The 10 may need to be different for other platforms, some are faster at doing CardIsInSlot
			if (<CardCheckCounter>=10)
				DisableReset // Only has an effect on GameCube
				if not CardIsInSlot
					change check_for_unplugged_controllers = 1
					goto mcmess_ErrorNoCardInSlot
				endif
				<CardCheckCounter>=0
			else
				<CardCheckCounter>=(<CardCheckCounter>+1)
			endif
		endif

		if TimeGreaterThan 3
			break
		endif

		wait 1 gameframe
	repeat
	change check_for_unplugged_controllers = 1
endscript


// @script | check_card | Checks the memory card.
// @parm name | FileType | The type of file, so that it knows how much space will be needed on the
// card. Valid values are OptionsAndPros, Cas, Park, Replay, NetworkSettings
// @flag Save | Indicates that a save is being done, & hence do a space-available check.
script check_card
	;DisableReset // Only has an effect on GameCube

	if not CardIsInSlot
		goto mcmess_ErrorNoCardInSlot
	endif

	if BadDevice
		goto mcmess_BadDevice
	endif
	if CardIsDamaged
		goto mcmess_DamagedCard
	endif

	if not SectorSizeOK
		if CardIsDamaged
			goto mcmess_DamagedCard
		else
			goto mcmess_BadSectorSize
		endif
	endif

	if not CardIsFormatted
		if CardIsDamaged
			goto mcmess_DamagedCard
		else
			if GotParam Save
				goto mcmess_ErrorNotFormatted
			else
				goto mcmess_ErrorNotFormattedNoFormatOption
			endif
		endif
	endif

	// XBox hard disk is so fast we don't need the checking card message ...
	if not IsXBox
		mcmess_CheckingCard
		mem_card_message_pause
		Dialog_Box_Exit no_pad_start
	endif
endscript

StopCheckingForCardRemoval=0
script CheckForCardRemoval
	;DisableReset // Only has an effect on GameCube

	Change StopCheckingForCardRemoval=0
	<CardCheckCounter>=0
	begin
		; XBox does not need to check for card removal, cos we're only ever using the hard disk.
		; But CardIsInSlot will always return true for XBox, so it doesn't matter that we're still doing
		; this check.

		; The 10 may need to be different for other platforms, some are faster at doing CardIsInSlot
		if (<CardCheckCounter>=10)
			;printf random(@"Checking card ..." @" Checking card ...")

			;DisableReset // Only has an effect on GameCube
			if not CardIsInSlot
				goto mcmess_ErrorNoCardInSlot
			endif
			<CardCheckCounter>=0
		else
			<CardCheckCounter>=(<CardCheckCounter>+1)
		endif

		if not ObjectExists id=<menu_id>
			;printf "Breaking due to menu %d not existing" d=<menu_id>
			break
		endif

		if istrue StopCheckingForCardRemoval
			;printf "Breaking due to StopCheckingForCardRemoval"
			break
		endif

		wait 1 gameframe
	repeat
endscript

///////////////////////////////////////////////////////////////////////////
//
// Formatting stuff
//
///////////////////////////////////////////////////////////////////////////

script DoFormatCard
	// This is so that the 'no card' error message does not pop up if the card is removed
	// during formatting, since removing the card will already bring up the format failed message.
	// (TT4309)
	KillSpawnedScript Name=CheckForCardRemoval

	;DisableReset // Only has an effect on GameCube

	// Removed this safeguard for NGC due to TT6975, which requires that a card be able to be formatted
	// if a file will not load.
	if not IsNGC
		// This is just a safeguard to ensure it never formats an already formatted card.
		if CardIsFormatted
			goto DoneScript
		endif
	endif

	; Call ResetTimer so that the time taken by FormatCard gets
	; incorporated into the 3 second message pause rather than added to it.
	; Actually, it seems to always take more than 3 seconds, but what the heck.
	ResetTimer
	mcmess_FormattingCard


	DisableReset // Only has an effect on GameCube
	if FormatCard
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck
		goto mcmess_FormatSuccessful
	else
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck
		goto mcmess_FormatFailed
	endif
endscript

//////////////////////////////////////////////////////////////////////////////////////////////////
//
//                                          Files menu
//
//////////////////////////////////////////////////////////////////////////////////////////////////

// @script | launch_files_menu | Removes the current menu and creates the memcard files menu
// @parmopt name | FileType | 0 | The file type to list. Can be OptionsAndPros, Park, Replay or Cas
// If omitted, all file types will be listed.
// @flag Save | Indicates that a save is being done. If omitted it implies a load is being done.
script launch_files_menu
	memcard_menus_cleanup
	create_files_menu <...>
endscript

// @script | create_files_menu | Creates the memcard files menu
// @parmopt name | FileType | 0 | The file type to list. Can be OptionsAndPros, Park, Replay or Cas
// If omitted, all file types will be listed.
// @flag Save | Indicates that a save is being done. If omitted it implies a load is being done.
script create_files_menu pos_tweak=(-20,-45)

	// As a safeguard, do not create the files menu if in pard-editor editing mode and
	// the controller unplugged message is up, since there is not enough VRAM.
	if CustomParkMode editing
		if ScreenElementExists id=controller_unplugged_dialog_anchor
			return
		endif
	endif

	;DisableReset // Only has an effect on GameCube

	// Free up lots of memory by unloading the skater anims.
	if GotParam Save
		UnloadAnimsAndCreateMemCardPools
	endif


	if GotParam Save
		Change SavingOrLoading=Saving
	else
		Change SavingOrLoading=Loading
	endif

	if not CardIsInSlot
		goto mcmess_ErrorNoCardInSlot
	endif

	SetScreenElementLock id=root_window off

	GoalManager_HidePoints
	GoalManager_HideGoalPoints

	// create the menu

	if GotParam Save
		menu_title='SAVE'
		helper_text={ helper_text_elements=[ { text="\b7/\b4 = Select" }
				{ text="\m1 = Back" }
				{ text="\m0 = Accept" }
				{ text="\md = Delete" }
			]
		}
	else
		menu_title='LOAD'
		helper_text={ helper_text_elements=[ { text="\b7/\b4 = Select" }
				{ text="\m1 = Back" }
				{ text="\m0 = Accept" }
			]
		}
	endif

	if LevelIs load_skateshop
		pos=(55, 40)
		bg_pos=(318, 67)
		top_bar_pos=(60,80)
	else
		pos=(55, 60)
		bg_pos=(318, 87)
		top_bar_pos=(60,100)
	endif

	make_new_menu { menu_title=""
		padding_scale=1
		menu_id=files_menu
		vmenu_id=files_vmenu
		pos=<pos>
		dims=(500, 192)			// the y dimension needs to be a multiple of 24
		; internal_just=[left top]
		; parent=root_window
		just=[center top]
		type=VScrollingMenu
		scrolling_menu_id=files_scrolling_menu
		scrolling_menu_title_id=files_scrolling_menu_title
		scrolling_menu_offset=(0, 32)		// to make room for the top bar
		dont_allow_wrap=dont_allow_wrap
		helper_text = <helper_text>
	}

	// back event
	SetScreenElementProps {
		id=current_menu
		event_handlers=[ { pad_back	generic_menu_pad_back params={ callback=reload_anims_then_run_abort_script} }
			{ pad_down menu_vert_blink_arrow params={ id=files_menu_down_arrow } }
			{ pad_up	menu_vert_blink_arrow params={ id=files_menu_up_arrow } }
		]
	}



	// background for menu
	theme_background width=6.5 pos=<bg_pos> num_parts=10 z_priority=1 static=static

	// icon for title
	if GotParam save
		FormatText ChecksumName=title_icon "%i_save" i=(THEME_PREFIXES[current_theme_prefix])
	else
		FormatText ChecksumName=title_icon "%i_load" i=(THEME_PREFIXES[current_theme_prefix])
	endif
	build_theme_sub_title title=<menu_title> title_icon=<title_icon>

	if LevelIs load_skateshop
		build_top_and_bottom_blocks
		// bg
		CreateScreenElement {
			type=SpriteElement
			parent=current_menu_anchor
			id=blue_bg

			texture=mm_bg_2
			rgba=[10 38 52 128]
			just=[left top]
			pos=(0,50)
			scale = (5,3)
			z_priority=-3
		}
	else
		build_top_bar ;pos=(-400, 62)
		FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
		build_theme_box_icons icon_texture=<paused_icon>
		build_grunge_piece
	endif

	files_menu_add_top_bar pos=<top_bar_pos>

	// Create all the bits

	if GotParam Save
		GetMemCardDirectoryListing
		GetMemCardSpaceAvailable
		GetMemCardSpaceRequired <FileType>

		// A temporary flag used by the next 'if' to avoid having to duplicate a
		// call to files_menu_add_item
		RemoveParameter add_createnew_option


		if (<TotalTHPS4FilesOnCard> = 0)
			if ( (<SpaceAvailable> < <SpaceRequired>) | (<FilesLeft> < 1) )
				// If there are no THPS4 files on the card, and there is not enough space available
				// to save the current file type, then go straight to an error message.
				// No point in going to the files menu because the user won't be able to delete
				// or replace any files, cos there won't be any.
				goto mcmess_ErrorNotEnoughRoomNoTHPSFilesExist Params={
					FileType=<FileType>
					SpaceRequired=<SpaceRequired>
					SpaceAvailable=<SpaceAvailable>
				}
			else
				// There are no THPS4 files on the card, and there is space to save,
				// so add the 'create new' option.
				<add_createnew_option>=1
			endif
		else

			// There are THPS4 saves on the card, so we definitely want to go to the files menu.
			if ( (<SpaceAvailable> < <SpaceRequired>) | (<FilesLeft> < 1) )
				// but there is not enough space available to create a new save,
				// so do not add the 'create new' option.

				if not GotParam DoNotShowNotEnoughRoomMessage
					goto mcmess_ErrorNotEnoughRoomButTHPSFilesExist params={FileType=<FileType> SpaceRequired=<SpaceRequired>}
				endif
			else
				if not GotParam FilesLimitReached
					// Only add the 'create new' option if the max number of files has not been reached.
					<add_createnew_option>=1
				endif
			endif
		endif

		if GotParam add_createnew_option
			files_menu_add_item { file_type=<FileType>
				// Highly sophisticated method of positioning text!
				filename='              Create new'
				file_size=''
				pad_choose_script=CreateNew
				font=small
				icon_alpha=0.0
			}
			// Now that we know that there will be enough room to save a file, only list files
			// of the same type.
			// First, remove the existing directory listing parameter. This would get removed anyway when
			// GetMemCardDirectoryListing adds the new one, but it could be large so remove it early to
			// reduce the risk of a memory overflow.

			// If there is not enough room to save, the original directory listing consisting of all
			// file types will be used, hence allowing other files to be deleted.
			RemoveParameter DirectoryListing
			GetMemCardDirectoryListing FileType=<FileType>
		endif
		// Remove the temporary flag just to keep the parameter list tidy.
		RemoveParameter add_createnew_option

	else
		GetMemCardDirectoryListing FileType=<FileType>
	endif

	if GotParam DirectoryListing
		if GotParam Save
			ForEachIn <DirectoryListing> Do=files_menu_add_item Params={pad_choose_script=OKToOverwrite MenuFileType=<FileType> Save}
		else
			ForEachIn <DirectoryListing> Do=files_menu_add_item Params={pad_choose_script=Load}
		endif
	else
		if not GotParam Save
			// This is a load menu, but there ain't no files, so go to the 'No files' message
			goto mcmess_NoFiles Params={MenuFileType=<FileType>}
		endif
	endif

	// Remove the large DirectoryListing array now to save space, because otherwise it
	// will get duplicated when passing <...>, which causes the component pool to run
	// out of space in the shipyard.
	RemoveParameter DirectoryListing
	files_menu_add_bottom_bar <...>

	// don't pop this up if the controller pulled dialog is up
	if ScreenElementExists id=controller_unplugged_dialog_anchor
		DoScreenElementMorph id=current_menu_anchor scale=0
	else
		FireEvent type=focus target=files_vmenu
	endif
	wait 2 gameframe
	if ScreenElementExists id=files_scrolling_menu
		SetScreenElementProps id=files_scrolling_menu reset_window_top
	endif

	CheckForCardRemoval menu_id=files_menu
endscript

// @script | files_menu_add_item | utility for adding a menu item to the
// files menu
// @parm string | filename |
// @parm string | file_size |
// @parm name | file_type | one of: OptionsAndPros, park, replay, or cas
script files_menu_add_item pad_choose_script=nullscript font=dialog icon_alpha=1.0

	SwitchToTempPoolsIfTheyExist
	FormatText ChecksumName=unhighlight_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	if IsNGC
		// Runs out of memory on NGC when there are a large number of entries in
		// the menu, so use the topdown heap.
		heap=topdown
	else
		heap=default
	endif
	// Actually, use the bottom up for all platforms, to prevent running out of space
	// on the front end heap.
	heap=bottomup

	// container for this element
	if IsNGC
		CreateScreenElement {
			type=ContainerElement
			parent=current_menu

			dims=(550, 24)
			event_handlers=[ { focus		files_menu_focus }
				{ unfocus		files_menu_unfocus }
				{ pad_choose	<pad_choose_script> }
				;{ pad_choose	generic_menu_pad_choose_sound }
				{ pad_start    <pad_choose_script> }
				// For the GameCube use pad_circle instead of pad_square,
				// since square will map to B, which is already being used for 'back'
				{ pad_circle   files_menu_delete }
			]
			heap=<heap>
		}
	else
		CreateScreenElement {
			type=ContainerElement
			parent=current_menu

			dims=(550, 24)
			event_handlers=[ { focus		files_menu_focus }
				{ unfocus		files_menu_unfocus }
				{ pad_choose	<pad_choose_script> }
				;{ pad_choose	generic_menu_pad_choose_sound }
				{ pad_start	<pad_choose_script> }
				{ pad_square   files_menu_delete }
			]
			heap=<heap>
		}
	endif
	<container_id> = <id>

	if gotparam total_file_size
		// Rulon: Europe uses different date formatting and doesn't know about am/pm
		// Todo: Ideally this data should be formatted based on individual PS2 prefs.
		if isPal
			FormatText textname=date "%d/%m/%y" m=<month> d=<day> y=<year>
			if ( 10 > <minutes> )
				mzero="0"
			else
				mzero=""
			endif

			FormatText textname=time "%h:%z%m" h=<hour> m=<minutes> z=<mzero>
		else
			FormatText textname=date "%m/%d/%y" m=<month> d=<day> y=<year>
			if ( 10 > <minutes> )
				mzero="0"
			else
				mzero=""
			endif
			if ( <hour> < 12 )
				ampm="am"
			else
				ampm="pm"
				hour= ( <hour> - 12 )
			endif
			if (<hour> = 0)
				hour=12
			endif

			FormatText textname=time "%h:%z%m%a" h=<hour> m=<minutes> z=<mzero> a=<ampm> ;s=<seconds>
		endif
	endif

	// Remove the date/time components to save space, since when adding the max of
	// 75 files the number of components used can get very close to the limit,
	// especially in the shipyard.
	RemoveParameter Year
	RemoveParameter Month
	RemoveParameter Day
	RemoveParameter Hour
	RemoveParameter Minutes
	RemoveParameter Seconds
	// Store the parameters in the tags.
	// The event handler scripts all do a GetTags first so as to get these parameters.
	// It used to be that each of the event handlers had a params=<...>, but that was
	// using up too many components.
	<container_id>:SetTags <...>


	if IsXBox
		if GotParam Corrupt
			GetFileTypeName file_type=<file_type>
			FormatText TextName=filename 'DAMAGED %s' s=<filetype_name>
		endif
	endif

	// filename
	CreateScreenElement {
		type=TextElement
		parent=<container_id>
		scale=.73
		font=<font>
		text=<filename>
		pos=(45, 0)
		just=[left center]
		rgba=<unhighlight_rgba>
		z_priority=6
		heap=<heap>
	}

	// size
	if gotparam total_file_size
		GetPlatform
		switch <Platform>
			case ps2
				FormatText TextName=file_size_text '%d KB' d=<total_file_size>
			case xbox
				FormatText TextName=file_size_text '%d blocks' d=<total_file_size>
			case ngc
				FormatText TextName=file_size_text '%d blocks' d=<total_file_size>
		endswitch
	else
		// Gets here for the 'Create New' line
		<file_size_text>=""
	endif

	CreateScreenElement {
		type=TextElement
		parent=<container_id>
		scale=.73
		font=small
		text=<file_size_text>
		pos=(325, 2)
		just=[right center]
		rgba=<unhighlight_rgba>
		z_priority=6
		heap=<heap>
	}

	// figure icon texture
	switch <file_type>
		case OptionsAndPros
			<file_type_icon> = mem_career
		case NetworkSettings
			<file_type_icon> = mem_net
		case park
			<file_type_icon> = mem_park
		case replay
			<file_type_icon> = mem_replay
		case cas
			<file_type_icon> = mem_skater
		case cat
			<file_type_icon> = mem_tricks
		case CreatedGoals
			<file_type_icon> = mem_goals
		default
			// TODO: assert or use a default texture?
			<file_type_icon> = mem_bad
			// script_assert "Unknown file type"
	endswitch

	// icon
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>
		scale=.73
		texture=<file_type_icon>
		pos=(25, 0)
		just=[center center]
		rgba=[50 50 50 128]
		scale=.72
		z_priority=1
		alpha=<icon_alpha>
		heap=<heap>
	}

	highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )

	// highlight bar
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>

		texture=de_highlight_bar
		pos=(264, 0)
		just=[center center]
		scale=(4.2, 0.7)
		rgba=[128 128 128 0]
		rot_angle=(<highlight_angle>/4)
		heap=<heap>
	}

	// date
	CreateScreenElement {
		type=TextElement
		parent=<container_id>
		scale=.73
		font=small
		text=<date>
		pos=(430, 2)
		just=[right center]
		rgba=<unhighlight_rgba>
		z_priority=6
		heap=<heap>
	}

	// time
	CreateScreenElement {
		type=TextElement
		parent=<container_id>
		scale=.73
		font=small
		text=<time>
		pos=(500, 2)
		just=[right center]
		rgba=<unhighlight_rgba>
		z_priority=6
		heap=<heap>
	}

	SwitchToRegularPools

endscript

script files_menu_add_top_bar
	// container
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu_anchor

		dims=(550, 24)
		pos=<pos>
		just=[left top]
	}
	<container_id> = <id>

	// arrow
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>
		id=files_menu_up_arrow

		texture=up_arrow
		pos=(250, 0)
		just=[center center]
		z_priority=3
	}

	// black bar
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>

		texture=black
		pos=(0,0)
		just=[left center]
		scale=(130, 6)
		rgba=[0 0 0 60]
	}
endscript

script files_menu_add_bottom_bar text_scale=1.0

	FormatText ChecksumName=highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=unhighlight_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// container
	GetStackedScreenElementPos Y id=files_scrolling_menu offset=(0,15)
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu_anchor

		;dims=(550, 24)
		pos=<pos>
		just=[left top]
		not_focusable
	}
	<container_id> = <id>

	// down arrow
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>
		id=files_menu_down_arrow

		texture=down_arrow
		pos=(250, -15)
		just=[left bottom]
	}

	// black bar
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>

		texture=black
		scale=(130, 6)
		pos=(3, 0)
		just=[left center]
		rgba=[0 0 0 60]
	}
	bar_id=<id>

	// file info section
	GetStackedScreenElementPos Y id=<container_id>
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu_anchor

		dims=(550, 24)
		pos=<pos>
		just=[left top]
	}
	<info_section_id> = <id>

	// This text element gets its text set by the files_menu_focus script.
	CreateScreenElement {
		type=TextElement
		parent=<id>
		id=files_menu_file_info

		font=small
		text=''
		pos=(20, 0)
		scale=<text_scale>
		rgba=<highlight_rgba>
		just=[left center]
	}

	// space available/needed
	GetStackedScreenElementPos Y id=<info_section_id>
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu_anchor

		dims=(550, 24)
		pos=<pos>
		just=[left top]
	}
	<mem_info_id> = <id>

	GetPlatform

	// Generate the text strings for displaying at the bottom.
	if GotParam Save
		GetMemCardSpaceRequired <FileType>
		switch <Platform>
			case XBox
			case Ngc
				FormatText {
					TextName=LeftText
					'Needed: %n blocks'
					n=<SpaceRequired>
				}
			case ps2
				FormatText {
					TextName=LeftText
					'Needed: %n KB'
					n=<SpaceRequired>
				}
		endswitch
	endif

	;DisableReset // Only has an effect on GameCube
	GetMemCardSpaceAvailable
	switch <Platform>
		case XBox
			if (<SpaceAvailable> > 49999)
				MiddleText='Free: 50000+'
			else
				FormatText {
					TextName=MiddleText
					'Free: %f blocks'
					f=<SpaceAvailable>
				}
			endif
		case Ngc
			FormatText {
				TextName=MiddleText
				'Free: %f blocks'
				f=<SpaceAvailable>
			}
		case ps2
			if (<SpaceAvailable> < 3)
				displayed_space_available=0
			else
				displayed_space_available=(<SpaceAvailable>-2) // -2 so as to match the browser screen
			endif

			FormatText {
				TextName=MiddleText
				'Free: %f KB'
				f=<displayed_space_available>
			}
	endswitch

	GetMaxTHPS4FilesAllowed
	FormatText {
		TextName=RightText
		;'Files: %t/%m'
		// Rulon (TT11585): TCR C4-8 changed "files" to "saves" because "files" is too close to PC terminology.
		'Saves: %t/%m'
		// Note: The TotalTHPS4FilesOnCard parameter was not generated by GetMaxTHPS4FilesAllowed,
		// it was in the parameters passed in to this script.
		t=<TotalTHPS4FilesOnCard>
		// This parameter was generated by GetMaxTHPS4FilesAllowed though.
		m=<MaxTHPS4FilesAllowed>
	}


	// Add the left text element, the 'Blocks Needed' text.
	// This is only meaningful if saving though, so only add it if we've got the Save flag.
	if GotParam Save
		CreateScreenElement {
			type=TextElement
			parent=<mem_info_id>

			font=small
			pos=(20,-9)
			just=[left top]
			rgba=<unhighlight_rgba>
			scale=<text_scale>
			text=<LeftText>
		}
	endif

	GetStackedScreenElementPos X id=<id> offset=(20, 0)
	// Middle text element
	CreateScreenElement {
		type=TextElement
		parent=<mem_info_id>

		font=small
		pos=<pos>
		just=[left top]
		rgba=<unhighlight_rgba>
		scale=<text_scale>
		text=<MiddleText>
	}

	GetStackedScreenElementPos X id=<id> offset=(20, 0)
	// Right text element
	CreateScreenElement {
		type=TextElement
		parent=<mem_info_id>

		font=small
		pos=<pos>
		just=[left top]
		rgba=<unhighlight_rgba>
		scale=<text_scale>
		text=<RightText>
	}

	GetStackedScreenElementPos Y id=<bar_id> offset=(1, -22)
	// red (sometimes) bg bar
	CreateScreenElement {
		type=SpriteElement
		parent=<mem_info_id>

		texture=white2
		scale=(64.5, 3)
		pos=<pos>
		just=[left top]
		rgba=<highlight_rgba>
		alpha=0.25
	}

endscript

// focus script for files menu
script files_menu_focus
	GetTags

	FormatText ChecksumName=highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	<files_menu_file_info_text>=''

	// If the element is one of the files in the directory listing,
	// as opposed to say the 'Create New' option, then the summary info will
	// already be in the parameters of this script.
	// If we are on the 'Create New' option the parameters will not be there, so in that
	// case call GetSummaryInfo which will get the summary info for the file that will
	// would get created by Create New if it were selected.
	//
	// (This is handy cos it gives the player a quick way of checking their current progress,
	// they can just pop into the files menu to see)
	//
	if not GotParam Index // Only directory listing entries will have an Index
		// Must be on the Create New option, so grab the current summary info
		GetSummaryInfo <file_type> VaultData=savevaultdata
	endif

	if not ( (GotParam BadVersion) | (GotParam Corrupt) )
		switch <file_type>
			case OptionsAndPros
				// It is a career file, so generate the string containing the summary info.
				GetArraySize CHAPTER_GOALS
				if GotParam CurrentChapter
					c=(<CurrentChapter>+1) // +1 cos CurrentChapter starts at 0
					// Need this cos CurrentChapter gets incremented again when the whole of story
					// mode is completed.
					if (<c> > <array_size>)
						c=<array_size>
					endif
				else
					c="?" // Just to prevent an assert in case CurrentChapter is missing for old saves
				endif

				FormatText {
					TextName=files_menu_file_info_text
					'\c3STORY: Chapter %c of %t'
					c=<c>
					t=<array_size>
				}
			case NetworkSettings
				FormatText {
					TextName=files_menu_file_info_text
					'\c3NETWORK SETTINGS: %i'
					i=<network_id>
				}
			case Cas
				// TODO
				<files_menu_file_info_text>='\c3Create-a-Skater'
			case Park
				if not GotParam MaxPlayers
					MaxPlayers=1
				endif

				colour='\c3' ; Blue
				if InNetGame
					GetNetworkNumPlayers
					if (<num_players> > <MaxPlayers>)
						colour='\c2' ; Red
					endif
				endif

				if (<MaxPlayers>=1)
					FormatText {
						TextName=files_menu_file_info_text
						'%cPark for one player'
						c=<colour>
						d=<MaxPlayers>
					}
				else
					FormatText {
						TextName=files_menu_file_info_text
						'%cPark for up to %d players'
						c=<colour>
						d=<MaxPlayers>
					}
				endif
			case Replay
				FormatText {
					TextName=files_menu_file_info_text
					'\c3Replay: %l'
					l=<LevelName>
				}
			case CreatedGoals
				// TODO
				FormatText {
					TextName=files_menu_file_info_text
					'\c3%i created goals'
					i=<num_edited_goals>
				}
			case cat
				/*FormatText {
                TextName=files_menu_file_info_text
                '\c3NAME: %i'
                i=<name>
                }*/
		endswitch
	endif

	SetScreenElementProps {
		id=files_menu_file_info
		text=<files_menu_file_info_text>
	}

	// we need to change the first four children
	// filename, size, icon, and highlight bar
	GetTags

	// filename text

	RunScriptOnScreenElement id={ <id> child=0 } text_twitch_effect2
	RunScriptOnScreenElement id={ <id> child=1 } text_twitch_effect2
	RunScriptOnScreenElement id={ <id> child=4 } text_twitch_effect2
	RunScriptOnScreenElement id={ <id> child=5 } text_twitch_effect2

	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<highlight_rgba>
	}

	// size
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=<highlight_rgba>
	}

	// icon
	SetScreenElementProps {
		id={ <id> child=2 }
		rgba=<highlight_rgba> ;[128 128 128 100]
		z_priority=7
	}
	DoScreenElementMorph {
		id={ <id> child=2 }
		scale=1
	}

	// highlight bar
	SetScreenElementProps {
		id={ <id> child=3 }
		rgba=<bar_rgba>
	}

	//date
	SetScreenElementProps {
		id={ <id> child=4 }
		rgba=<highlight_rgba>
	}
	//time
	SetScreenElementProps {
		id={ <id> child=5 }
		rgba=<highlight_rgba>
	}

	// update the arrows
	GetScreenElementDims id=files_vmenu
	if ( <height> > 216 )
		SetScreenElementProps {
			id=files_menu_up_arrow
			rgba=[128 128 128 0]
		}
		SetScreenElementProps {
			id=files_menu_down_arrow
			rgba=[128 128 128 0]
		}
	else
		generic_menu_update_arrows {
			menu_id=files_vmenu
			up_arrow_id=files_menu_up_arrow
			down_arrow_id=files_menu_down_arrow
		}
	endif
endscript

// unfocus script for files menu
script files_menu_unfocus
	// we need to change the first four children
	// filename, size, icon, and highlight bar

	FormatText ChecksumName=unhighlight_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	GetTags

	KillSpawnedScript name=text_twitch_effect2

	DoScreenElementMorph {
		id={ <id> child=0 }
		scale=0.73
	}
	DoScreenElementMorph {
		id={ <id> child=1 }
		scale=0.73
	}
	DoScreenElementMorph {
		id={ <id> child=2 }
		scale=0.73
	}
	/*DoScreenElementMorph {
		id={ <id> child=3 }
		scale=0.75
	}*/
	DoScreenElementMorph {
		id={ <id> child=4 }
		scale=0.73
	}
	DoScreenElementMorph {
		id={ <id> child=5 }
		scale=0.73
	}

	// filename text
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=<unhighlight_rgba>
	}

	// size
	SetScreenElementProps {
		id={ <id> child=1 }
		rgba=<unhighlight_rgba>
	}

	// icon
	SetScreenElementProps {
		id={ <id> child=2 }
		rgba=[50 50 50 128]
		z_priority=6
	}
	DoScreenElementMorph {
		id={ <id> child=2 }
		scale=.72
	}

	// highlight bar
	SetScreenElementProps {
		id={ <id> child=3 }
		rgba=[128 128 128 0]
	}

	//date
	SetScreenElementProps {
		id={ <id> child=4 }
		rgba=<unhighlight_rgba>
	}
	//time
	SetScreenElementProps {
		id={ <id> child=5 }
		rgba=<unhighlight_rgba>
	}
endscript

///////////////////////////////////////////////////////////////////////////
//
// Deletion scripts
//
///////////////////////////////////////////////////////////////////////////

script files_menu_delete
	GetTags

	if GotParam Index
		if GotParam Save
			memcard_menus_cleanup

			GetFileTypeName file_type=<file_type>

			if isXbox
				FormatText {
					TextName=DeleteText
					'Delete the %t\n\'%s\' ?'
					t=<filetype_name>
					s=<filename>
				}
			else
				FormatText {
					TextName=DeleteText
					'Delete the %t file\n\'%s\' ?'
					t=<filetype_name>
					s=<filename>
				}
			endif


			create_snazzy_dialog_box {
				title='Delete'
				text=<DeleteText>

				pad_back_script = launch_files_menu
				pad_back_params = {FileType=<MenuFileType> Save}

				buttons=[
					{ font=small text='No' pad_choose_script=launch_files_menu pad_choose_params = {FileType=<MenuFileType> Save}}
					{ font=small text='Yes' pad_choose_script=delete_file pad_choose_params = <...>  }
				]
			}

			CheckForCardRemoval menu_id=dialog_box_anchor

		endif
	endif
endscript

script delete_file
	memcard_menus_cleanup

	Change StopCheckingForCardRemoval=1

	; Call ResetTimer so that the time taken by DeleteMemCardFile gets
	; incorporated into the 3 second message pause rather than added to it.
	ResetTimer
	mcmess_DeletingFile FileType=<file_type>
	DisableReset // Only has an effect on GameCube

	// Note: The xbox_directory_name will only exist when run on XBox.
	if DeleteMemCardFile CardFileName=<actual_file_name> XBoxDirectoryName=<xbox_directory_name>
		// Wait for the full 3 seconds to be up.
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck
		EnableReset // Only has an effect on GameCube

		create_snazzy_dialog_box {
			title='Deleted'
			text='Delete successful'

			pad_back_script = launch_files_menu
			pad_back_params = {FileType=<MenuFileType> Save}

			buttons=[
				{ font=small text='OK' pad_choose_script=launch_files_menu pad_choose_params = {FileType=<MenuFileType> Save}}
			]
		}

		// Check for card removal while the dialog box is up.
		CheckForCardRemoval menu_id=dialog_box_anchor
	else
		// Wait for the full 3 seconds to be up.
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck

		// Some sort of strange error caused the delete to fail.
		goto mcmess_ErrorDeleteFailed
	endif
endscript


script delete_bad_file
	memcard_menus_cleanup

	; Call ResetTimer so that the time taken by DeleteMemCardFile gets
	; incorporated into the 3 second message pause rather than added to it.
	ResetTimer
	mcmess_DeletingFile FileType=<file_type>

	DisableReset // Only has an effect on GameCube

	// Note: The xbox_directory_name will only exist when run on XBox.
	if DeleteMemCardFile {
			CardFileName=<actual_file_name>
			XBoxDirectoryName=<xbox_directory_name>
			UserFileName=<filename>
			Type=<file_type>
		}

		EnableReset // Only has an effect on GameCube
		// Wait for the full 3 seconds to be up.
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck

		if GotParam GoBackToFilesMenu
			create_snazzy_dialog_box {
				title='Deleted'
				text='Delete successful'

				pad_back_script = launch_files_menu
				pad_back_params = {FileType=<MenuFileType>}

				buttons=[
					{ font=small text='OK' pad_choose_script=launch_files_menu pad_choose_params = {FileType=<file_type>}}
				]
			}
		else
			create_snazzy_dialog_box {
				title='Deleted'
				text='Delete successful'

				pad_back_script = AbortScript

				buttons=[
					{ font=small text='OK' pad_choose_script=AbortScript }
				]
			}
		endif

		// Check for card removal while the dialog box is up.
		CheckForCardRemoval menu_id=dialog_box_anchor
	else
		// Wait for the full 3 seconds to be up.
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck

		// Some sort of strange error caused the delete to fail.
		goto mcmess_ErrorDeleteFailed
	endif
endscript


// This is similar to the above, but always goes back to the 'save' files menu.
// Had to throw this script in at the end of the project cos I got a bug saying
// that the files listed as corrupt need to be selectable, in which case they
// need to get deleted.
script NGC_delete_bad_file
	memcard_menus_cleanup

	; Call ResetTimer so that the time taken by DeleteMemCardFile gets
	; incorporated into the 3 second message pause rather than added to it.
	ResetTimer
	mcmess_DeletingFile

	DisableReset // Only has an effect on GameCube

	if DeleteMemCardFile {
			CardFileName=<actual_file_name>
			UserFileName=<filename>
			Type=<file_type>
		}
		EnableReset // Only has an effect on GameCube
		// Wait for the full 3 seconds to be up.
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck

		create_snazzy_dialog_box {
			title='File'
			text='Delete successful'

			pad_back_script = launch_files_menu
			pad_back_params = {FileType=<MenuFileType> Save}

			buttons=[
				{ font=small text='OK' pad_choose_script=launch_files_menu pad_choose_params = {FileType=<MenuFileType> Save}}
			]
		}

		// Check for card removal while the dialog box is up.
		CheckForCardRemoval menu_id=dialog_box_anchor
	else
		// Wait for the full 3 seconds to be up.
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck

		// Some sort of strange error caused the delete to fail.
		goto mcmess_ErrorDeleteFailed
	endif
endscript



///////////////////////////////////////////////////////////////////////////
//
// Overwrite scripts
//
///////////////////////////////////////////////////////////////////////////

script OKToOverwrite
	if GotParam NoGetTags
	else
		GetTags
	endif

	// Notes:
	// <MenuFileType> is the type of the file being saved.
	// <file_type> is the type of the file being overwritten.
	// <total_file_size> is the size of the file being overwritten.
	// <filename> is the name of the file being overwritten.

	// Don't allow overwriting of a damaged file, because it's file name is unknown,
	// hence cannot be used for the new file.
	if ( (GotParam BadVersion) | (GotParam Corrupt) )
		if IsNGC
			goto mcmess_NGCDeleteCorruptFile params=<...>
		endif

		// Maybe play a sound effect ?
		return
	endif

	DisableReset // Only has an effect on GameCube

	// Do not go ahead and delete the selected file if there will not
	// be enough space afterwards to save the new file.
	// Go to an error message instead.
	GetMemCardSpaceRequired <MenuFileType>
	GetMemCardSpaceAvailable

	EnableReset // Only has an effect on GameCube

	if ( <SpaceRequired> > <SpaceAvailable>+<total_file_size> )
		goto mcmess_ErrorNotEnoughRoomButTHPSFilesExist Params={
			Overwrite
			FileType=<MenuFileType>
			SpaceRequired=<SpaceRequired>
			SpaceAvailable=(<SpaceAvailable>+<total_file_size>)
		}
	endif

	memcard_menus_cleanup

	GetFileTypeName file_type=<file_type>

	if isXbox
		FormatText {
			TextName=OverwriteText
			'OK to overwrite the existing %t\n\'%s\' ?'
			t=<filetype_name>
			s=<filename>
		}
	else
		FormatText {
			TextName=OverwriteText
			'OK to overwrite the existing %t file\n\'%s\' ?'
			t=<filetype_name>
			s=<filename>
		}
	endif


	create_snazzy_dialog_box {
		title='Overwrite'
		text=<OverwriteText>

		pad_back_script = launch_files_menu
		pad_back_params = {FileType=<MenuFileType> Save}

		buttons=[
			{ font=small text='No' pad_choose_script=launch_files_menu pad_choose_params = {FileType=<MenuFileType> Save}}
			{
				font=small text='Yes'
				pad_choose_script=DeleteOldSaveNew
				pad_choose_params =
				{
					filename=<filename>
					old_file_type=<file_type>
					new_file_type=<MenuFileType>
					actual_file_name=<actual_file_name>
				}
			}
		]
	}

	CheckForCardRemoval menu_id=dialog_box_anchor
endscript

script DeleteOldSaveNew
	Save {
		filename=<filename>
		file_type=<new_file_type>
		total_file_size=<total_file_size>
		Overwrite={CardFileName=<actual_file_name> UserFileName=<filename> Type=<old_file_type>}
	}
endscript

///////////////////////////////////////////////////////////////////////////
//
// Save scripts
//
///////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////
//  Network Setting


script retry_launch_save_network_settings
	memcard_menus_cleanup
	goto launch_save_network_settings
endscript

script launch_save_network_settings
	destroy_net_settings_menu
	// Need to do this because when the net settings menu is on screen the main menu
	// textures are still in VRAM, so there won't be enough room for the files menu textures.
	// Going back to the main menu will reload its textures so its OK to remove them here.

	Change RetryScript=retry_launch_save_network_settings
	Change AbortScript=back_to_net_settings_menu
	Change DoneScript=back_to_net_settings_menu
	Change SavingOrLoading=Saving
	check_card FileType=NetworkSettings Save
	launch_files_menu Save FileType=NetworkSettings
endscript

script retry_launch_save_internet_settings
	memcard_menus_cleanup
	goto launch_save_internet_settings
endscript

script launch_save_internet_settings
	destroy_internet_options_menu

	Change RetryScript=retry_launch_save_internet_settings
	Change AbortScript=back_to_internet_options_menu
	Change DoneScript=back_to_internet_options_menu
	Change SavingOrLoading=Saving
	check_card FileType=NetworkSettings Save
	launch_files_menu Save FileType=NetworkSettings
endscript

//////////////////////////////////////////////////////////////
//  Game

script retry_launch_pause_menu_save_game_sequence
	memcard_menus_cleanup
	goto launch_pause_menu_save_game_sequence
endscript

script launch_pause_menu_save_game_sequence
	destroy_pause_menu

	Change RetryScript=retry_launch_pause_menu_save_game_sequence
	Change AbortScript=back_to_pause_menu
	Change DoneScript=back_to_pause_menu
	Change SavingOrLoading=Saving
	check_card FileType=OptionsAndPros Save
	;MaybeSaveCustomSkater
	launch_files_menu Save FileType=OptionsAndPros
endscript

//////////////////////////////////////////////////////////////
//  Replay

script retry_launch_end_replay_menu_save_replay_sequence
	memcard_menus_cleanup
	goto launch_end_replay_menu_save_replay_sequence
endscript

script launch_end_replay_menu_save_replay_sequence
	destroy_pause_menu

	Change RetryScript=retry_launch_end_replay_menu_save_replay_sequence
	Change AbortScript=back_to_end_replay_menu
	Change DoneScript=back_to_end_replay_menu
	Change SavingOrLoading=Saving
	check_card FileType=Replay Save
	launch_files_menu Save FileType=Replay
endscript

//////////////////////////////////////////////////////////////
//  Park

save_successful=2

script retry_launch_pause_menu_save_park_sequence
	memcard_menus_cleanup
	goto launch_pause_menu_save_park_sequence
endscript

script launch_pause_menu_save_park_sequence
	destroy_pause_menu

	Change RetryScript=retry_launch_pause_menu_save_park_sequence
	Change AbortScript=back_to_pause_menu
	Change DoneScript=back_to_pause_menu
	Change SavingOrLoading=Saving
	check_card FileType=Park Save
	launch_files_menu Save FileType=Park
endscript

script retry_launch_park_editor_save_park_sequence
	memcard_menus_cleanup
	goto launch_park_editor_save_park_sequence
endscript

script launch_park_editor_save_park_sequence
	destroy_pause_menu

	Change RetryScript=retry_launch_park_editor_save_park_sequence
	Change AbortScript=back_to_pause_menu
	Change DoneScript=back_to_pause_menu
	Change SavingOrLoading=Saving
	change save_successful=0
	check_card FileType=Park Save
	launch_files_menu Save FileType=Park
endscript

// (Mick: I've stuck the "load" script here, as it's so similar to the above)

script retry_launch_pause_menu_load_park_sequence
	memcard_menus_cleanup
	goto launch_pause_menu_load_park_sequence
endscript

script launch_pause_menu_load_park_sequence
	destroy_pause_menu

	Change RetryScript=retry_launch_pause_menu_load_park_sequence
	Change AbortScript=back_to_pause_menu
	Change DoneScript=back_to_pause_menu
	Change SavingOrLoading=Loading
	check_card FileType=Park Load
	launch_files_menu Load FileType=Park
endscript

script retry_launch_level_select_load_park_sequence
	memcard_menus_cleanup
	goto launch_level_select_load_park_sequence
endscript

script launch_level_select_load_park_sequence
	destroy_level_select

	Change RetryScript=retry_launch_level_select_load_park_sequence
	Change AbortScript=back_to_created_park_menu
	Change DoneScript=load_loaded_created_park;back_to_created_park_menu
	Change SavingOrLoading=Loading

	check_card FileType=Park Load
	launch_files_menu Load FileType=Park
endscript

load_successful = 2
loadforupload = 0

script retry_launch_upload_file_sequence_cat
	memcard_menus_cleanup
	goto launch_upload_file_sequence params={ type=cat }
endscript

script retry_launch_upload_file_sequence_cas
	memcard_menus_cleanup
	goto launch_upload_file_sequence params={ type=optionsandpros }
endscript

script retry_launch_upload_file_sequence_cag
	memcard_menus_cleanup
	goto launch_upload_file_sequence params={ type=createdgoals }
endscript

script retry_launch_upload_file_sequence_cap
	memcard_menus_cleanup
	goto launch_upload_file_sequence params={ type=park }
endscript

script launch_upload_file_sequence
	change load_successful = 0

	switch <type>
		case cat
			change loadforupload = 1
			Change RetryScript=retry_launch_upload_file_sequence_cat
		case optionsandpros
			change loadforupload = 1
			Change RetryScript=retry_launch_upload_file_sequence_cas
		case createdgoals
			change loadforupload = 1
			Change RetryScript=retry_launch_upload_file_sequence_cag
		case park
			change loadforupload = 1
			Change RetryScript=retry_launch_upload_file_sequence_cap
	endswitch

	Change AbortScript=back_to_internet_options_menu
	Change DoneScript=back_to_internet_options_menu
	Change SavingOrLoading=Loading

	check_card FileType=<type> Load
	launch_files_menu Load FileType=<type>
endscript

savevaultdata = 0

script retry_launch_download_save_sequence_cat
	memcard_menus_cleanup
	goto launch_download_save_sequence params={ file_type=cat }
endscript

script retry_launch_download_save_sequence_cas
	memcard_menus_cleanup
	goto launch_download_save_sequence params={ file_type=optionsandpros }
endscript

script retry_launch_download_save_sequence_cag
	memcard_menus_cleanup
	goto launch_download_save_sequence params={ file_type=createdgoals }
endscript

script retry_launch_download_save_sequence_cap
	memcard_menus_cleanup
	goto launch_download_save_sequence params={ file_type=park }
endscript

script launch_download_save_sequence
	if not GotParam file_type
		printf "missing param file_type"
		return
	endif

	switch <file_type>
		case cat
			Change RetryScript=retry_launch_download_save_sequence_cat
			change savevaultdata = 1
		case optionsandpros
			Change RetryScript=retry_launch_download_save_sequence_cas
			change savevaultdata = 1
		case createdgoals
			Change RetryScript=retry_launch_download_save_sequence_cag
			change savevaultdata = 1
		case park
			Change RetryScript=retry_launch_download_save_sequence_cap
			change savevaultdata = 1
		default
			printf "bad file_type"
	endswitch
	Change AbortScript=back_from_transfer_succeeded_dialog
	Change DoneScript=back_from_transfer_succeeded_dialog
	Change SavingOrLoading=Saving

	check_card FileType=<file_type> Save
	launch_files_menu Save FileType=<file_type>
endscript

//////////////////////////////////////////////////////////////
//  CAS

script retry_launch_save_cas_sequence
	memcard_menus_cleanup
	goto launch_save_cas_sequence
endscript

script launch_save_cas_sequence
	destroy_main_menu
	PlaySkaterCamAnim name=SS_menucam_credits play_hold

	Change RetryScript=retry_launch_save_cas_sequence
	Change AbortScript=back_to_pre_cas_menu
	Change DoneScript=back_to_pre_cas_menu
	Change SavingOrLoading=Saving
	check_card FileType=OptionsAndPros Save
	launch_files_menu Save FileType=OptionsAndPros
endscript

///////////////////////////////////////////////////////////////
//	CAT

script retry_launch_save_cat_sequence
	memcard_menus_cleanup
	goto launch_save_cat_sequence
endscript

script launch_save_cat_sequence
	if ScreenElementExists id=<curren_menu_anchor>
		DestroyScreenElement  id=<curren_menu_anchor>
	endif

	Change RetryScript=retry_launch_save_cat_sequence
	Change AbortScript=back_to_cat_pause
	Change DoneScript=back_to_cat_pause
	Change SavingOrLoading=Saving
	check_card FileType=CAT Save
	launch_files_menu Save FileType=CAT
endscript

///////////////////////////////////////////////////////////////
//	OPTIONS

script retry_launch_options_menu_save_game_sequence
	memcard_menus_cleanup
	goto launch_options_menu_save_game_sequence
endscript

script launch_options_menu_save_game_sequence
	destroy_main_menu
	;PlaySkaterCamAnim name=SS_menucam_options play_hold

	Change RetryScript=retry_launch_options_menu_save_game_sequence
	Change AbortScript=back_to_options_menu
	Change DoneScript=back_to_options_menu
	Change SavingOrLoading=Saving
	check_card Save FileType=OptionsAndPros
	;MaybeSaveCustomSkater
	launch_files_menu Save FileType=OptionsAndPros
endscript

//////////////////////////////////////////////////////////////
//  Game (after beating goal)

script retry_launch_beat_goal_save_game_sequence
	memcard_menus_cleanup
	goto launch_beat_goal_save_game_sequence
endscript

script launch_beat_goal_save_game_sequence
	Change RetryScript=retry_launch_beat_goal_save_game_sequence
	Change AbortScript=back_to_beat_goal
	Change DoneScript=back_to_beat_goal
	Change SavingOrLoading=Saving
	check_card FileType=OptionsAndPros Save
	;MaybeSaveCustomSkater
	launch_files_menu Save FileType=OptionsAndPros
endscript


// Given filename and file_type, this will append a number to filename such that
// filename no longer clashes with any existing mem card file. It will then put filename
// into the calling scripts parameters.
script AppendDigitsToFilenameUntilNoClash max_chars=15
	// Pause the music cos this could take a while.
	// MemCardFileExists itself does not pause then unpause the music, cos that
	// could cause stuttering as it gets called repeatedly here.
	if not IsXBox
		PauseMusic 1
		PauseStream 1
	endif
	<newfilename>=<filename>
	<i>=2
	begin
		DisableReset // Only has an effect on GameCube
		if not MemCardFileExists Name=<newfilename> Type=<file_type>
			// Note: The -1 means restore the pause status to whatever it was before
			// PauseMusic 1 was called, ie don't switch the music on if it was not on before.
			if not IsXBox
				PauseMusic -1
				PauseStream -1
			endif
			return filename=<newfilename>
			break
		endif
		AppendSuffix NewTextName=newfilename Text=<filename> Suffix=<i> MaxChars=<max_chars>
		<i>=(<i>+1)
	repeat
	// Should never get here, but unpause just in case.
	if not IsXBox
		PauseMusic -1
		PauseStream -1
	endif
endscript

// This brings up the name entry screen.
script CreateNew
	GetTags

	memcard_menus_cleanup

	switch <file_type>
		case OptionsAndPros
			GetCustomSkaterName
			<filename>=<display_name>
		case NetworkSettings
			if IsXBox
				<filename>='Sys Lnk Set'
			else
				<filename>='Net settings'
			endif
		case CAT
			get_CAT_other_param_values trick_index=0
			<filename>=<name>
			allowed_characters=cat_allowed_characters
		case Park
			GetCustomParkName
			<filename>=<name>
		case Replay
			<filename>='Replay'
		case CreatedGoals
			<filename>='Created Goals'
		default
			<filename>='Dooby Doo'
	endswitch

	if ( savevaultdata = 1 )
		GetScriptString
		filename=<string>
	endif

	// Stick numbers after the filename until it does not clash with any existing file.
	// Required by XBox.
	AppendDigitsToFilenameUntilNoClash file_type=<file_type> filename=<filename> max_chars=MAX_MEMCARD_FILENAME_LENGTH


	create_onscreen_keyboard {
		allow_cancel
		keyboard_cancel_script=launch_files_menu
		keyboard_cancel_params={FileType=<file_type> Save}
		keyboard_done_script=CreateNew_Done
		keyboard_title='SAVE NAME'
		;field="network_id"
		text=<filename>
		;title="Ken Test"
		min_length=1
		max_length=MAX_MEMCARD_FILENAME_LENGTH
		// All these params will get passed on to keyboard_done_script
		FileType=<file_type>
		allowed_characters=<allowed_characters>
	}

	CheckForCardRemoval menu_id=keyboard_anchor
endscript

// This is run when the Done option is chosen on the name entry screen.
script CreateNew_Done
	GetTextElementString id=keyboard_current_string
	memcard_menus_cleanup

	if ( savevaultdata = 0 )
		switch <FileType>
			case Optionsandpros
				SetCustomSkaterFilename <String>
			case Park
				SetCustomParkName name=<String>
				SetParkName <String>
			case CAT
				// if the CAT is unnamed, store string as it's name
				get_CAT_other_param_values trick_index=0
				if ( <name> = "" )
					set_new_CAT_param_values trick_index=0 name=<string> can_spin=<can_spin>
				endif
		endswitch
	endif

	check_card FileType=<FileType> Save

	DisableReset // Only has an effect on GameCube
	if MemCardFileExists Name=<String> Type=<FileType>
		OKToOverwrite NoGetTags filename=<String> file_type=<FileType> MenuFileType=<FileType> total_file_size=<total_file_size>
	else
		Save filename=<String> file_type=<FileType>
	endif
endscript

// @script | Save | This saves a file to the mem card and displays the appropriate messages.
// It goes straight to the 'Saving Data' message.
// @parm name | file_type | The type of file. Valid values are OptionsAndPros, Cas, Park, Replay, NetworkSettings
// @parm string | filename | The name of the file.
script Save
	memcard_menus_cleanup

	if ( savevaultdata = 0 )
		// Just to ensure that the park name does get set.
		switch <file_type>
			case Park
				SetCustomParkName name=<filename>
				SetParkName <filename>
			case optionsandpros
				SetCustomSkaterFilename <filename>
		endswitch
	endif

	DisableReset // Only has an effect on GameCube

	; Call ResetTimer so that the time taken by SaveToMemoryCard gets
	; incorporated into the 3 second message pause rather than added to it.
	ResetTimer
	if GotParam Overwrite
		Change StopCheckingForCardRemoval=1 // This is to prevent two error messages
		mcmess_OverwritingData FileType=<file_type>
		Change StopCheckingForCardRemoval=0

		if not DeleteMemCardFile CardFileName=(<Overwrite>.CardFileName) UserFileName=(<Overwrite>.UserFileName) Type=(<Overwrite>.Type)
			RemoveMemCardPoolsAndLoadAnims
			goto mcmess_ErrorOverwriteFailed
		endif

		// Need to check if the new file exists, because of the following possible case:
		// The user has a network settings file called foo, and a career file called foo.
		// They choose to save a career, and they choose to overwrite the network settings foo.
		// It deletes the network settings foo, but now it is about to overwrite the old career foo.
		// This check will catch that and prompt the user again whether they want to overwrite the career foo.
		if MemCardFileExists Name=<filename> Type=<file_type>
			goto OKToOverwrite params={NoGetTags filename=<filename> file_type=<file_type> MenuFileType=<file_type> total_file_size=<total_file_size>}
		endif
	else
		mcmess_SavingData FileType=<file_type>
	endif

	DisableReset // Only has an effect on GameCube
	if SaveToMemoryCard Name=<filename> Type=<file_type> SaveVaultData=savevaultdata
		RemoveMemCardPoolsAndLoadAnims

		; NoTimerReset flag used here so that the time taken by SaveToMemoryCard gets
		; incorporated into the 3 second pause rather than added to it.
		; Also triangle is not allowed to abort here so that the user is definitely notified that
		; the save was successful.
		; Also there is no need to give an error if the card is removed now, cos the save worked fine.
		mem_card_message_pause NoTimerReset NoCardRemovalCheck

		if ( save_successful = 0 )
			change save_successful=1
			goto AbortScript params={ type=<file_type> }
		else
			if GotParam Overwrite
				goto mcmess_OverwriteSuccessful params={ type=<file_type> }
			else
				goto mcmess_SaveSuccessful params={ type=<file_type> }
			endif
		endif
	else
		RemoveMemCardPoolsAndLoadAnims

		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck
		if GotParam Overwrite
			goto mcmess_ErrorOverwriteFailed
		else
			goto mcmess_ErrorSaveFailed
		endif
	endif
endscript


script PostAutoSaveCas
	Change DoneScript=AbortScript
	Change SavingOrLoading=Saving
	launch_files_menu Save FileType=OptionsAndPros
endscript


///////////////////////////////////////////////////////////////////////////
//
// Load scripts
//
///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// Autoload stuff
///////////////////////////////////////////////////////////////////////////

// A flag for preventing the autoload sequence from running every time the
// skateshop is entered, just the first time.
DoAutoload=1
no_load=0
most_recent_save_exists=0
attempted_xbox_autoload = 0
//Flag is set if entering skateshop to "spend cash"
goto_secret_shop = 0

script maybe_auto_load_from_memory_card

	if (DoAutoload=0)
		// This is not the first time into the skateshop, so check whether we need
		// to go to the network menu.
		change show_career_startup_menu=0
		SpawnScript wait_and_pause_skater params={time=1}
		if ConnectedToPeer
			SetNetworkMode INTERNET_MODE
			change_gamemode_net
			SetQuietMode OFF
			;load_mainmenu_textures_to_main_memory
			//create_network_select_games_menu
			rejoin_lobby
			kill_start_key_binding
		else
			launch_main_menu
		endif
	else
		// This is the first time into the skateshop, so run the auto load sequence.
		// It's very important to clear the auto load flag here, otherwise it will
		// autoload every time the skateshop is entered, overwriting the current game progress.
		Change DoAutoload=0

		// Fix to TT9344, XBox trc states that it must not go to the autoload sequence if
		// no pads are plugged in. It must go to the main menu so that the demos can run.
		if IsXBox
			if not GotParam force_autoload
				// Need to wait a bit for the pads to be acquired, otherwise it will think they are not
				// plugged in.
				// I found that waiting too long, eg 5 frames, made the 'checking card' message appear on
				// top of the loading screen for some reason.
				// Waiting 1 frame is not long enough for the pads to be acquired.
				// 2 frames worked, but I made it 3 just to make sure the pads have got acquired.
				wait 3 gameframes
				if not PadsPluggedIn
					goto back_to_main_menu2
				endif
				SpawnScript wait_and_pause_skater
				goto back_to_main_menu2
			else
				SpawnScript wait_and_pause_skater params={time=1}
				CheckForCardOnBootup
			endif
		else
			SpawnScript wait_and_pause_skater
			CheckForCardOnBootup
		endif
	endif
endscript

script CheckForCardOnBootup
	ResetAbortAndDoneScripts

	DisableReset // Only has an effect on GameCube

	if CardIsInSlot
		if BadDevice
			Change RetryScript=CheckForCardOnBootup
			Change AbortScript=back_to_main_menu2
			goto mcmess_BadDevice
		else
			if SectorSizeOK
				goto auto_load
			else
				Change RetryScript=CheckForCardOnBootup
				Change AbortScript=back_to_main_menu2
				if CardIsDamaged
					goto mcmess_DamagedCard
				else
					goto mcmess_BadSectorSize
				endif
			endif
		endif
	else
		Change RetryScript=CheckForCardOnBootup
		Change AbortScript=back_to_main_menu2
		goto mcmess_ErrorNoCardOnBootup
	endif
endscript

script auto_load
	if(no_load=0)
		memcard_menus_cleanup
	endif
	Change AbortScript=back_to_main_menu2
	Change DoneScript=back_to_main_menu2
	Change RetryScript=auto_load
	Change SavingOrLoading=Loading

	// Keep the music quiet till the autoload has completed.
	StopMusic
	DisableReset // Only has an effect on GameCube

	if not CardIsInSlot
		goto mcmess_ErrorNoCardOnBootup
	endif

	ResetTimer
	mcmess_CheckingCard

	DisableReset // Only has an effect on GameCube

	if BadDevice
		mem_card_message_pause NoTimerReset NoCardRemovalCheck
		goto mcmess_BadDevice
	endif

	if CardIsDamaged
		mem_card_message_pause NoTimerReset NoCardRemovalCheck
		goto mcmess_DamagedCard
	endif

	if not SectorSizeOK
		if CardIsDamaged
			mem_card_message_pause NoTimerReset NoCardRemovalCheck
			goto mcmess_DamagedCard
		else
			mem_card_message_pause NoTimerReset NoCardRemovalCheck
			goto mcmess_BadSectorSize
		endif
	endif


	DisableReset // Only has an effect on GameCube
	if not CardIsFormatted
		if CardIsDamaged
			goto mcmess_DamagedCard
		else
			if IsPS2
				;mem_card_message_pause NoTimerReset; NoCardRemovalCheck
				; TT4305: Unformatted cards should not be detected on startup, so just go straight to the menu.
				change show_career_startup_menu=0
				RemoveMemCardPoolsAndLoadAnims
				KillSpawnedScript name=wait_and_pause_skater
				goto back_to_main_menu2
			else
				mem_card_message_pause NoTimerReset NoCardRemovalCheck
				goto mcmess_ErrorNotFormatted params={QuitText='Continue without formatting' BackScript=NullScript}
			endif
		endif
	endif

	if (no_load = 0)
		DisableReset // Only has an effect on GameCube
		GetMemCardDirectoryListing
		GetMostRecentSave <DirectoryListing> NetworkSettings
		mem_card_message_pause NoTimerReset NoCardRemovalCheck
		if not CardIsInSlot
			goto mcmess_ErrorNoCardOnBootup
		endif
	endif

	<did_load>=0

	if GotParam MostRecentSave

		change most_recent_save_exists=1

		ResetTimer
		mcmess_LoadingData FileType=NetworkSettings

		DisableReset // Only has an effect on GameCube
		if LoadFromMemoryCard Name=(<MostRecentSave>.filename) Type=NetworkSettings
			GetPreferenceChecksum pref_type=network config_type
			switch <checksum>
				case config_sony
					LoadNetConfigs
					GetPreferenceString pref_type=network config_type
					ChooseNetConfig name=<ui_string>
			endswitch
		else
			mem_card_message_pause NoTimerReset NoCardRemovalCheck
			goto mcmess_ErrorLoadFailed Params={
				<...> // Pass on any CorruptedData flag
				// Pass on the name and type so that in
				// the case of the GameCube the bad file
				// can be deleted.
				filename=(<MostRecentSave>.filename)
				actual_file_name=(<MostRecentSave>.actual_file_name)
				file_type=NetworkSettings
			}
		endif
		<did_load>=1
	endif

	DisableReset // Only has an effect on GameCube
	GetMostRecentSave <DirectoryListing> OptionsAndPros
	if GotParam MostRecentSave
		if (<did_load> = 0)
			ResetTimer
			mcmess_LoadingData FileType=OptionsAndPros
		endif

		SetSectionsToApplyWhenLoading All

		DisableReset // Only has an effect on GameCube
		if not LoadFromMemoryCard Name=(<MostRecentSave>.filename) Type=OptionsAndPros
			mem_card_message_pause NoTimerReset NoCardRemovalCheck
			goto mcmess_ErrorLoadFailed Params={
				<...> // Pass on any CorruptedData flag
				// Pass on the name and type so that in
				// the case of the GameCube the bad file
				// can be deleted.
				filename=(<MostRecentSave>.filename)
				actual_file_name=(<MostRecentSave>.actual_file_name)
				file_type=OptionsAndPros
			}
		endif

		<did_load>=1
	endif

	if (<did_load>=1)
		mem_card_message_pause NoTimerReset
	endif

	;MaybeLoadCustomSkater

	DisableReset // Only has an effect on GameCube
	GetMemCardSpaceAvailable

	GetSaveSizes
	if IsPS2
		if IsPAL
			<TotalSpaceRequired>=<SaveSize_OptionsAndPros>
		else
			<TotalSpaceRequired>=(<SaveSize_OptionsAndPros>+
				<SaveSize_Park>+
				<SaveSize_CreateATrick>+
				<SaveSize_Goals>+
				<SaveSize_NetworkSettings>)
		endif
	else
		<TotalSpaceRequired>=(<SaveSize_OptionsAndPros>+
			<SaveSize_Park>+
			<SaveSize_CreateATrick>+
			<SaveSize_Goals>)
	endif

	// For NGC, check number of files available too.
	// FilesLeft is a param returned by GetMemCardSpaceAvailable. For PS2 and XBox it returns 1000000
	// Need 4 files, for skater, park, trick, goals.
	if ( <FilesLeft> < 4 )
		mem_card_message_pause XSkips NoTimerReset
		goto mcmess_ErrorNotEnoughSpaceToSaveAllTypes
	endif

	if (<SpaceAvailable> < <TotalSpaceRequired>)
		mem_card_message_pause XSkips NoTimerReset
		goto mcmess_ErrorNotEnoughSpaceToSaveAllTypes
	endif

	build_top_and_bottom_blocks parent=root_window
	make_mainmenu_3d_plane parent=root_window

	if GotParam LastGameMode
		if ( <LastGameMode> = career )
			// if last saved in main menu don't change levels
			if GotParam LastLevelLoadScript
				if not ( <LastLevelLoadScript> = load_skateshop )
					// automatically load the last level they were in!
					career_autoload_launch_current_level level=<LastLevelLoadScript>
					return
				endif
			endif
		endif
	endif

	change show_career_startup_menu=0
	goto back_to_main_menu2
endscript

///////////////////////////////////////////////////////////////////////////

script retry_launch_pause_menu_save_created_goals
	memcard_menus_cleanup
	goto launch_pause_menu_save_created_goals
endscript

script launch_pause_menu_save_created_goals
	memcard_menus_cleanup
	Change RetryScript=retry_launch_pause_menu_save_created_goals
	Change AbortScript=back_to_pause_menu
	Change DoneScript=back_to_pause_menu
	Change SavingOrLoading=Saving
	check_card FileType=CreatedGoals Save
	launch_files_menu Save FileType=CreatedGoals
endscript


DoInitialiseCreatedGoalsAfterLoading=0

script retry_launch_pause_menu_load_created_goals
	memcard_menus_cleanup
	goto launch_pause_menu_load_created_goals
endscript

script launch_pause_menu_load_created_goals
	destroy_pause_menu

	Change RetryScript=retry_launch_pause_menu_load_created_goals
	Change AbortScript=back_to_pause_menu
	Change DoneScript=back_to_pause_menu
	Change SavingOrLoading=Loading
	// This is when goals are loaded in-game, so need to initialise them after loading
	// so that the peds appear.
	Change DoInitialiseCreatedGoalsAfterLoading=1
	check_card FileType=CreatedGoals
	launch_files_menu FileType=CreatedGoals
endscript


script launch_load_created_goals_from_select_goals_menu
	change check_for_unplugged_controllers = 0
	memcard_menus_cleanup
	Change RetryScript=launch_load_created_goals_from_select_goals_menu
	Change AbortScript=create_select_goals_menu
	Change DoneScript=create_select_goals_menu
	Change SavingOrLoading=Loading
	// This is when goals are loaded from the main menu, so must not initialise the
	// goals in that case because no level is loaded.
	Change DoInitialiseCreatedGoalsAfterLoading=0
	check_card FileType=CreatedGoals
	launch_files_menu FileType=CreatedGoals
	change check_for_unplugged_controllers = 1
endscript

script launch_load_created_goals_from_host_goals_menu
	memcard_menus_cleanup
	Change RetryScript=launch_load_created_goals_from_host_goals_menu
	Change AbortScript=launch_network_host_options_menu
	Change DoneScript=host_options_goals_sub_menu_return
	Change SavingOrLoading=Loading
	// This is when goals are loaded from the main menu, so must not initialise the
	// goals in that case because no level is loaded.
	Change DoInitialiseCreatedGoalsAfterLoading=0
	check_card FileType=CreatedGoals
	launch_files_menu FileType=CreatedGoals
endscript

script launch_load_created_goals_from_game_options_menu
	memcard_menus_cleanup
	Change RetryScript=launch_load_created_goals_from_game_options_menu
	Change AbortScript=create_network_game_options_menu
	Change DoneScript=game_options_goals_sub_menu_return
	Change SavingOrLoading=Loading
	// This is when goals are loaded from the main menu, so must not initialise the
	// goals in that case because no level is loaded.
	Change DoInitialiseCreatedGoalsAfterLoading=0
	check_card FileType=CreatedGoals
	launch_files_menu FileType=CreatedGoals
endscript

script retry_launch_load_network_settings
	memcard_menus_cleanup
	goto launch_load_network_settings
endscript

script launch_load_network_settings
	destroy_net_settings_menu
	// Need to do this because when the net settings menu is on screen the main menu
	// textures are still in VRAM, so there won't be enough room for the files menu textures.
	// Going back to the main menu will reload its textures so its OK to remove them here.

	Change RetryScript=retry_launch_load_network_settings
	Change AbortScript=back_to_net_settings_menu
	Change DoneScript=back_to_net_settings_menu
	Change SavingOrLoading=Loading
	check_card FileType=NetworkSettings
	launch_files_menu FileType=NetworkSettings
endscript

script retry_launch_options_menu_load_game_sequence
	memcard_menus_cleanup
	goto launch_options_menu_load_game_sequence
endscript

script retry_launch_career_menu_load_game_sequence
	memcard_menus_cleanup
	goto launch_career_menu_load_game_sequence
endscript

script launch_career_menu_load_game_sequence
	dialog_box_exit
	destroy_main_menu
	;PlaySkaterCamAnim name=SS_menucam_options play_hold

	Skater:Hide

	Change RetryScript=retry_launch_career_menu_load_game_sequence
	Change AbortScript=back_to_career_options_menu
	Change DoneScript=back_to_career_options_menu

	Change SavingOrLoading=Loading
	SetSectionsToApplyWhenLoading All
	check_card FileType=OptionsAndPros
	launch_files_menu FileType=OptionsAndPros
endscript

script launch_options_menu_load_game_sequence
	destroy_main_menu
	;PlaySkaterCamAnim name=SS_menucam_options play_hold

	Change RetryScript=retry_launch_options_menu_load_game_sequence
	Change AbortScript=back_to_options_menu
	Change DoneScript=back_to_options_menu

	Change SavingOrLoading=Loading
	SetSectionsToApplyWhenLoading All
	check_card FileType=OptionsAndPros
	launch_files_menu FileType=OptionsAndPros
endscript


script retry_launch_options_menu_load_replay_sequence
	memcard_menus_cleanup
	goto launch_options_menu_load_replay_sequence
endscript

script launch_options_menu_load_replay_sequence
	destroy_main_menu
	;PlaySkaterCamAnim name=SS_menucam_options play_hold

	Change RetryScript=retry_launch_options_menu_load_replay_sequence
	Change AbortScript=back_to_options_menu
	Change DoneScript=back_to_options_menu
	Change SavingOrLoading=Loading
	check_card FileType=Replay
	launch_files_menu FileType=Replay
endscript

script retry_launch_load_cas_sequence
	memcard_menus_cleanup
	goto launch_load_cas_sequence
endscript

script launch_load_cas_sequence
	destroy_main_menu

	Change AbortScript=back_to_pre_cas_menu
	Change DoneScript=jump_to_edit_skater
	Change RetryScript=retry_launch_load_cas_sequence
	Change SavingOrLoading=Loading
	SetSectionsToApplyWhenLoading All ;ApplyCustomSkater
	check_card FileType=OptionsAndPros
	launch_files_menu FileType=OptionsAndPros
endscript

script retry_launch_load_cas_from_select_sequence
	memcard_menus_cleanup
	goto launch_load_cas_from_select_sequence
endscript

script launch_load_cas_from_select_sequence
	change check_for_unplugged_controllers = 0
	destroy_main_menu
	dialog_box_exit
	KillSkaterCamAnim all
	PlaySkaterCamAnim { name=mainmenu_camera02
		skater=0
		targetID=<objId>
		targetOffset=<targetOffset>
		positionOffset=<positionOffset>
		play_hold
		frames=1
	}

	Change AbortScript=back_to_select_skater
	Change DoneScript=back_to_select_skater

	Change RetryScript=retry_launch_load_cas_from_select_sequence
	Change SavingOrLoading=Loading

	// Only apply story if
	GetCurrentSkaterProfileIndex
	if ( <currentSkaterProfileIndex> = 0 )
		SetSectionsToApplyWhenLoading All
	else
		SetSectionsToApplyWhenLoading ApplyCustomSkater
	endif

	check_card FileType=OptionsAndPros
	launch_files_menu FileType=OptionsAndPros
	change check_for_unplugged_controllers = 1
endscript

script retry_launch_load_cat_sequence
	memcard_menus_cleanup
	goto launch_load_cat_sequence
endscript

script launch_load_cat_sequence
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	Change AbortScript=back_to_pre_cat_menu
	Change DoneScript=back_to_edit_cat_menu
	Change RetryScript=retry_launch_load_cat_sequence
	Change SavingOrLoading=Loading
	check_card FileType=CAT
	launch_files_menu FileType=CAT
endscript

script retry_launch_load_cat_sequence2
	memcard_menus_cleanup
	goto launch_load_cat_sequence2
endscript

script launch_load_cat_sequence2
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	change loading_cat_from_edit_tricks=1

	Change AbortScript=back_to_edit_tricks_menu
	Change DoneScript=finish_loading_cat
	Change RetryScript=retry_launch_load_cat_sequence2
	Change SavingOrLoading=Loading
	check_card FileType=CAT
	launch_files_menu FileType=CAT
endscript

// @script | Load | This loads a file from  the mem card and displays the appropriate messages.
// @parm name | file_type | The type of file. Valid values are OptionsAndPros, Cas, Park, Replay, NetworkSettings
// @parm string | filename | The name of the file.
script Load
	GetTags

	if InNetGame
		if (<file_type> = Park)
			if not GotParam MaxPlayers
				// Just to prevent an expression evaluator assert for old park files
				MaxPlayers=1
			endif
			GetNetworkNumPlayers
			if inNetGame
				if (<num_players> > <MaxPlayers>)
					memcard_menus_cleanup
					goto mcmess_ErrorbadParkMaxPlayers Params=<...>
				endif
			endif
		endif
	endif

	if ( (GotParam BadVersion) | (GotParam Corrupt) )
		if IsNGC
			memcard_menus_cleanup
			// On the GameCube, delete the bad file.
			// Pass on <...> so that filename and file_type & actual_file_name get passed on.
			goto mcmess_ErrorLoadFailed Params={<...> CorruptedData GoBackToFilesMenu}
		else
			// Maybe play a sound effect ?
			return
		endif
	endif

	memcard_menus_cleanup

	//play the accept sound now since it gets cut off otherwise
	generic_menu_pad_choose_sound
	; Call ResetTimer so that the time taken by LoadFromMemoryCard gets
	; incorporated into the 3 second message pause rather than added to it.
	ResetTimer
	mcmess_LoadingData FileType=<file_type>

	DisableReset // Only has an effect on GameCube
	if LoadFromMemoryCard Name=<filename> Type=<file_type> LoadForUpload=loadforupload
		// sometimes this message gets destroyed so, making sure it stays
		change check_for_unplugged_controllers = 0
		mcmess_LoadingData FileType=<file_type> no_animate=no_animate

		; NoTimerReset flag used here so that the time taken by LoadFromMemoryCard gets
		; incorporated into the 3 second pause rather than added to it.
		; Also triangle is not allowed to abort here so that the user is definitely notified that
		; the load was successful.
		; Also there is no need to give an error if the card is removed now, cos the load worked fine.
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck

		if ( load_successful = 0 )
			change load_successful=1
			change check_for_unplugged_controllers = 1
			goto AbortScript params={ type=<file_type> filename=<filename> }
		else
			change check_for_unplugged_controllers = 1
			if (<file_type> = Park)
				if InNetGame
					goto DoneScript type=<file_type>
				endif
			endif
			goto mcmess_LoadSuccessful params={ type=<file_type> filename=<filename> }
		endif
	else
		mem_card_message_pause XSkips NoTimerReset NoCardRemovalCheck
		// Pass on <...> because mcmess_ErrorLoadFailed needs to check for the presence of the
		// CorruptedData flag, and in the case of the GameCube will need to delete the bad file so
		// it also needs filename and file_type
		goto mcmess_ErrorLoadFailed Params={<...> GoBackToFilesMenu}
	endif
endscript

// This get run from the c-code of LoadFromMemoryCard once the file has successfully loaded, so long
// as LoadForUpload was not passed as true.
// It is passed in the parameters that were passed to LoadFromMemoryCard
script post_load_from_memory_card

	if not gotparam type
		printstruct <...>
		script_assert "Expected to find parameter 'type'!"
	endif

	switch <type>
		case OptionsAndPros
			career_post_load

			if LoadedCustomSkater
				// need to refresh the custom skater
				load_pro_skater name=custom
				cas_post_load
			endif

			// Refresh the saved current theme
			printf current_theme_prefix
		case Park
			SetCustomParkName name=<name>
			SetParkName <name>
			if CustomParkMode editing
				// If editing, initialise the created goals so that the peds appear, and such that any old
				// ones disappear (old ones not disappearing was causing TT13961)
				InitialiseCreatedGoals
			endif

		case CreatedGoals
			end_current_goal_run
			if istrue DoInitialiseCreatedGoalsAfterLoading
				InitialiseCreatedGoals
			endif
	endswitch

endscript

script UnloadAnimsAndCreateMemCardPools
	if not LevelIs load_skateshop
		if not LevelIs load_sk5ed
			do_unload_unloadable
			if IsNGC
				// Don't create the pools here on NGC.
				// They get created within the SaveToMemoryCard function instead, since they use
				// the render buffer and must not exist when any rendering may occur.
			else
				CreateTemporaryMemCardPools
			endif
		endif
	endif
endscript

script RemoveMemCardPoolsAndLoadAnims
	if not LevelIs load_skateshop
		if not LevelIs load_sk5ed
			if not IsNGC
				RemoveTemporaryMemCardPools
			endif
			do_load_unloadable
		endif
	endif
endscript

script reload_anims_then_run_abort_script
	// This is needed because the files menu may have used the special pools for
	// it's parameters, so it needs to be deleted before the pools get deleted, otherwise they will assert.
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	RemoveMemCardPoolsAndLoadAnims
	goto Abortscript
endscript

