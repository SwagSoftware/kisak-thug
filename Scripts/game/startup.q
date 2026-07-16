//////////////////////////////////////////////////////////////
// all scripts that are run at startup
// initilize any system level script structures (like the root window)
// and jump to the appropiate gameflow

lock_framerate  = 0             // change to 1 to lock to 60/30.  Leave as 0 for variable framerate, with tears
display_framerate_box = 1       // the little red and white box.  This is ignored on a CD build
show_filenames = 0				// set if we want to show the name of every file opened
output_tracking_lines = 0
rail_arrows = 0
show_all_trick_objects = 0		// change 1 to show all the trick obs at the start of the level

viewer_buttons_enabled = 1      // to allow us to more easily mask the viewer buttons from script

wireframe_skins = 0

DEMO_BUILD = 0	// Lock stuff out for OPM demo

auto_change_chapter_and_stage = 0  // automatically set chapter and stage when loading a level

SHOWPOLYS_ONQUICKVIEW = 1 // by default, when artists quickview, you will see the poly readout. Designers probably don't want this. 

// On the CD, this will autolaunch the skateshop

script load_permanent_prefiles
	LoadPreFile "permtex.pre"
	if not IsNgc
    	LoadPreFile "casfiles.pre"
    endif
	if IsNgc
        LoadPreFile "gcmemicons.pre"
    endif
endscript

script load_permanent_assets

    SetDefaultPermanent 1
    
	SetReferenceChecksum 0
    
    LoadPreFile "skeletons.pre"
	LoadPreFile "bits.pre"

	// load compress tables
	InitAnimCompressTable "anims\standardkeyq.bin" q48
	InitAnimCompressTable "anims\standardkeyt.bin" t48

   	PushMemProfile  "Audio Stream header"
    LoadStreamHeader "streams\streams"
	PopMemProfile
    
   	PushMemProfile  "Permanent Skeletons"
    skeletonload_all
	PopMemProfile	// "Permanent Skeletons"
    
    PushMemProfile  "Permanent Models"
	// if you're going to add more permanent assets
	// here, make sure add them to bits.pre in 
	// preall.bat as well;  otherwise, it will work
	// on the PS2, but not on the GC.
    LoadAsset "models\arrow\arrow.mdl"						   nocollision=1
    LoadAsset "models\HUD_arrow\HUD_arrow.mdl"                 nocollision=1
    LoadAsset "models\ped_shadow\ped_shadow.mdl"               nocollision=1
    LoadAsset "models\goalarrow\goalarrow.mdl"                 nocollision=1
    LoadAsset "models\cat_bg\cat_bg.mdl"                       nocollision=1
    LoadAsset "models\gameobjects\p1_cursor\p1_cursor.mdl"     nocollision=1
    LoadAsset "models\gameobjects\skate\letter_s\letter_s.mdl" nocollision=1
    LoadAsset "models\gameobjects\skate\letter_k\letter_k.mdl" nocollision=1
    LoadAsset "models\gameobjects\skate\letter_a\letter_a.mdl" nocollision=1
    LoadAsset "models\gameobjects\skate\letter_t\letter_t.mdl" nocollision=1
    LoadAsset "models\gameobjects\skate\letter_e\letter_e.mdl" nocollision=1
    LoadAsset "models\gameobjects\combo\goal_combo_c\goal_combo_c.mdl"  nocollision=1
    LoadAsset "models\gameobjects\combo\goal_combo_o\goal_combo_o.mdl"  nocollision=1
    LoadAsset "models\gameobjects\combo\goal_combo_m\goal_combo_m.mdl"  nocollision=1
    LoadAsset "models\gameobjects\combo\goal_combo_b\goal_combo_b.mdl"  nocollision=1
    
	// load special items (which are permanent) here
	load_special_items
	 
    PopMemProfile  //"Permanent Models"
    
    PushMemProfile  "Permanent Textures"
    // load permanent particle effect textures here
//    LoadParticleTexture "bits\wheel_01"  perm   ; temp blood	 NOT BEING USED AS FAR AS I CAN TELL - JA
    LoadParticleTexture "particles\dt_generic_particle01" perm   ; temp spark
    LoadParticleTexture "bits\particle_test02" perm  ; temp blood
	LoadParticleTexture "bits\blood_01"	perm 
	LoadParticleTexture "bits\splash"	perm 
	LoadParticleTexture "bits\snow"	perm 
	LoadParticleTexture "particles\dt_nj_flame02" perm    // Used for the fireball
	LoadParticleTexture "particles\dt_ironblast01" perm		// Used for Ironman - only 1k
	LoadParticleTexture "particles\dt_barf02" perm			// Used for the barf
	if isXbox
		LoadParticleTexture "bits\skidtrail" perm
    else	
		LoadParticleTexture "bits\skidtrail_ps2" perm 
	endif
	//LoadParticleTexture "bits\blood_02"
    ;LoadTexture "Miscellaneous/pedshadow"
    PopMemProfile  //"Permanent Textures"
    
    UnloadPreFile "skeletons.pre"
	UnloadPreFile "bits.pre"
	
    
	// The anims are loaded last, and are put on the top down heap. They are required
	// to be the last thing on the TD heap so that when building a park they can be
    // deleted to free up memory. (The park editor uses the memory between the BU and TD heaps)
	
    // The PS2 & Xbox systems load the permanent anims in pip PRE format,
    // which allows us to unload and reload all of the permanent anims
    // as a single block, without any additional overhead to load up the
    // PRE file, and without causing any fragmentation.  This comes
    // in handy for the park editor and for the cutscenes, which both
    // need to free up some memory w/o going through the normal
    // level cleanup process. One major assumption is that the animations 
    // will be the last thing on the top down heap.
    
    do_load_permanent
    
    // note that, because the anims.pre is permanently
    // loaded, we don't need to call the equivalent 
    // UnloadPipPre (ideally, there should be an
    // equivalent unload_permanent_assets function,
    // even if it wasn't ever called)

    do_load_unloadable
		
	SetDefaultPermanent 0
endscript

script load_special_items

    
	LoadAsset "models\specialitems\Flag\flag.skin" 
//	LoadAsset "models\specialitems\Grapplehook\grapplehook.skin" 
	LoadAsset "models\specialitems\bustedboard\bustedboard.skin" 
	LoadAsset "models\specialitems\pizzabox\pizzabox.skin" 
//	LoadAsset "models\specialitems\Pistol\Pistol.skin" 
	LoadAsset "models\specialitems\guitar\guitar.skin"
	LoadAsset "models\specialitems\extraboard\extraboard.skin" 
    LoadAsset "models\specialitems\BloodyGuts\BloodyGuts.skin" 
	LoadAsset "models\specialitems\spraycan\spraycan.skin"
	LoadAsset "models\specialitems\tongue\SEC_Gene_Tongue.skin" 
	LoadAsset "models\specialitems\boombox\boombox.skin"
	LoadAsset "models\specialitems\skull\head_skull.skin"   
	
endscript


// Retired Special Items
//  LoadAsset "models\specialitems\BoomBox\BoomBox.skin" 
//	LoadAsset "models\specialitems\ferret\ferret.skin" 
//  LoadAsset "models\specialitems\MotorX\MotorX.skin" 


// Note: Qcomp.exe and levelassetlister.exe look for this script in order to find out what
// anims to exclude from the level's pre file.
script load_permanent_anims LoadFunction=LoadAnim
    animload_thps5_human <...>
	load_special_item_anims <...>	
endscript

script load_unloadable_anims LoadFunction=LoadAnim
	animload_THPS5_human_unloadable <...>
endscript

script load_special_anims LoadFunction=LoadAnim
//	animload_THPS5_human_special <...>
endscript

script load_net_anims LoadFunction=LoadAnim
	animload_THPS5_human_net <...>
	load_special_item_anims <...>
endscript

script load_special_item_anims LoadFunction=LoadAnim
    animload_SI_flag <...>
    animload_SI_bustedboard <...>
    animload_SI_Pizza <...>
    animload_SI_boombox <...>
    animload_SI_Generic <...>
	animload_SI_Extraboard <...>
	animload_SI_Tongue <...>
	animload_SI_Skull <...>
endscript

// init_loading_bar is called to initialize the loading bar before it is displayed.
// This is called right before startup_loading_screen
script init_loading_bar
    SetLoadingBarPos         x=258 y=400
    SetLoadingBarSize        width=140 height=8
    SetLoadingBarStartColor  r=0   g=76  b=129
    SetLoadingBarEndColor    r=176 g=211 b=115
    SetLoadingBarBorder      width=5 height=5
    SetLoadingBarBorderColor r=40  g=40  b=40
endscript

// startup_loading_screen is called to display the loading screen.  This is done
// immediatly after the scripts are loaded
// to do it earlier would require a direct call from code.
script startup_loading_screen
	if not Bootstrap
		if IsPS2
		  if CD
               Displayloadingscreen blank
			   PlayMovie "movies\atvi"
			   PlayMovie "movies\nslogo"
			   PlayMovie "movies\intro"
		  endif
		endif
	endif
	if IsXbox
        if CD
            PlayMovie "movies\atvi"
            PlayMovie "movies\nslogo"
			PlayMovie "movies\intro"
        endif
    endif
	if IsNgc
        if CD
            PlayMovie "movies\atvi"
            PlayMovie "movies\nslogo"
			PlayMovie "movies\intro"
        endif
    endif
	if Bootstrap
		    DisplayLoadingScreen "loadscrn_demo"
	else		
		if IsXbox
		    DisplayLoadingScreen "loadscrn_x"
		endif
		if IsNgc
		    DisplayLoadingScreen "loadscrn_ngc"
		endif
		if IsPS2
// Mick:  On PS2, initial loading screen is now hardwired in main.cpp
//		    DisplayLoadingScreen "loadscrn"
		endif
	endif		

endscript

All_Levels_Unlocked=1
bootstrap_build=0
UseLevelOverrideStats=0

// default_system_startup is what gets the game running
// it is called as the last thing in the Skate module's 
// initialization funtion (v_start_cb)
// There is some script level initilization, setting up the menu framework,
// and then we need to autolaunch a level
// On CD, we automatically autolaunch the skateshop level
// but otherwise we just enable the viewer and cheats, and then
// (after returning from this script) we will call the users "startup" script
// in which we assume they have an "autolaunch" command
script  default_system_startup
    WriteDNASBinary
    
//    SetParkEditorState state=paused command=initialize
    change select_shift=0       // default select button to off
    
    PushMemProfile "script default_system_startup before autolaunch"
    // unlock the school
	SetGlobalFlag flag=LEVEL_UNLOCKED_SCH
	
	unlock_initial_boards

	// Temporarily in for Lollapalooza demo builds
	if CD	
		if isXbox
//			change DEMO_BUILD = 1
//			change allow_other_movement_modes = 0
		endif	
	endif	
	
    // Mick - We set the volumes here, to ensure any value passed in by the
    // bootstrap loader will take effect	
    SetSfxVolume 100
	SetMusicVolume 50
	SetRandomMode 1
	SetGlobalFlag flag=SOUNDS_SONGORDER_RANDOM
	
	if CD
        // Ensure that pre files get used when loading off CD
        Change UsePreFilesForLevelLoading=1
		// Ensure that we can't switch into the car on a QA burn
//		Change allow_other_movement_modes = 0
		Change DEVKIT_LEVELS = 0
		Change All_Levels_Unlocked = 0 		
//		change all_levels_unlocked = 0
    endif    

    // We always want pres to be used on GameCube.
	if IsNgc
        Change UsePreFilesForLevelLoading=1
    endif    

    // System level initilization here
    new_screen_element_test         // initialize menu framework
	SetScreenElementProps id=root_window event_handlers=[{pad_start nullscript}] replace_handlers
	printf "replace_handlers to take away start key in load_level" 
	// Initialize, start and locally join the server.
    setservermode on
	SetJoinMode	JOIN_MODE_PLAY
	StartServer
    JoinServer <...>
    
    // Ken: Create the GoalEditor composite object, which hangs around forever. It needs to stay around
    // between levels because it contains all the created goals & the players progress through them, and the
    // user may want to play a bit of story mode, then go back and play some created goals.
    CreateGoalEditor
    // Similarly, the rail editor (part of the park editor) needs to be permanent because the park
    // editor map stays in memory even after quitting and playing a different level, so the rails
    // need to be preserved too.
    CreateRailEditor
    
    
    PopMemProfile // "script default_system_startup"	
        
    if Bootstrap 
		change bootstrap_build = 1
		change STARTGAME_FIRST_TIME=1 // enables the startup menu
		change BUMP_STATS = 0
		change All_Levels_Unlocked=0	
		autolaunch level=load_sch game=career
	else
		if CD
    			// On the CD, we autolaunch the skateshop

				change BUMP_STATS = 1

				// autolaunching must generally be be the LAST thing here...
				// if you load perm stuff after autolaunching, then you get fragmentation
				;LoadFromMemoryCard Name="Network settings" Type=NetworkSettings
				if (DEMO_BUILD)
					autolaunch level=load_skateshop game=career
				else	
					launchviewer    // enables fly around mode and stuff. Enables any Select+.... buttons 
					autolaunch level=load_skateshop game=career
				endif	
		else
			cheat_select_shift
			// Non-cd stuff here, enable the viewer
			// and enable some cheats
			auto_launch_viewer   // enables fly around mode and stuff. Enables any Select+.... buttons, and loads the network setting asn sets up the net connection
			cheat_give_neversoft_skaters
            LaunchScriptDebugger   // (Mick) Always load the script debugger during development            
		endif
	  endif
// Don't be creating any permananet objects now!  You'll fragment the heap on CD builds      
   
endscript


script Call_Personal_StartUp_Script  
    
    if Gunslinger
        if ScriptExists  gun_startup
            gun_startup
        else
            default_gun_startup
        endif
    else
    
        if ScriptExists startup
            startup
        else
            printf "WARNING: Missing the startup script"
            // We want to do something here, so if the startup script is missing
            // then we still get something on screen
            Hideloadingscreen
            
           	CreateScreenElement {
    		parent=root_window
    		type=textelement
    		id=ns_rules
    		
    		text="Neversoft and Activision 2002"
    		font=newtrickfont
    		pos=(320,420)
    		rgba=[140 128 128 55]
    		Scale=0.6
    		just=[center center]
    		not_focusable
    	    }
    
    	
    	    RunScriptOnScreenElement id=ns_rules missing_startup	
          
        endif
    endif
endscript


// This script will get called if you don't have a script gun_startup of your own
script default_gun_startup
    GetCurrentSkaterProfileIndex 
	SetPlayerAppearance player=<currentSkaterProfileIndex> appearance_structure=appearance_custom_skater_male_09
	change show_career_startup_menu = 0
	autolaunch level=load_www game=career	
endscript


script missing_startup
    begin
    	SetProps text="Missing Script Startup"	
    	DoMorph time=0 alpha=0    
    	DoMorph time=.5 alpha=1	scale = 3
    	DoMorph time=.5 alpha=1	scale = 1
    	wait 5 seconds
        DoMorph time=.5 alpha=0  scale = 0.5
        DoMorph time=.5 alpha=0
	repeat
endscript


// SPs hack below. When we first boot the CD, we put up a cool little "quick start" menu
// ala GTA3. This gets called from GameFlow.q, Play_run script, temporarily. 
// Removed for E3
STARTGAME_FIRST_TIME=0

script create_startup_menu
    HideLoadingScreen
	GoalManager_HidePoints
	GoalManager_HideGoalPoints
	; make_new_menu menu_id=startup_menu vmenu_id=startup_vmenu menu_title=" " pos=(150, 100) internal_just=[center top]
	if ObjectExists id=current_menu_anchor
		Destroyscreenelement id=current_menu_anchor
		wait 1 game frame
	endif	
    
	KillSkaterCamAnim all
	PlaySkaterCamAnim name=SS_MenuCam play_hold
//	MakeSkaterGoto SkateshopAI	
	SetMemThreadSafe off
    
	// create menu
	make_new_skateshop_menu {
		pos=(205, 109)
		internal_just=[center center]
		menu_id=startup_menu
		vmenu_id=startup_vmenu
		menu_title=""
	}
	
	// icon
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=THPS4
		pos=(320, 132)
		scale=(1.4, 1)
		z_priority=2
	}
	
	// bg
	CreateScreenElement { 
		type=SpriteElement 
		parent=current_menu_anchor
		
		texture=options_bg
		draw_behind_parent
		;pos=<pos>
		pos=(321, 115)
		scale=(1.17,1.1)
		just=[center top]
		rgba=[128 128 128 128]
		z_priority=0
	}
	    
    CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=startup_menu_blue_bar  
		texture=stats_notch
		pos=(312, 369)
        rgba=[42 48 77 50]
		scale=(14.0, .2)
		just=[center top]
	}  
    
    CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=startup_menu_box_top
		
		texture=level_top_piece
		pos=(321, 145)
        rgba=[128 128 128 80]
		scale=<scale>
		just=[center top]
	} 
	// box middle
	begin
		GetStackedScreenElementPos Y id=<id>
		CreateScreenElement {
			type=SpriteElement
			parent=current_menu_anchor
			
			texture=level_repeat_mid
			pos=<pos>
			scale=<scale>
            rgba=[128 128 128 80]
			just=[left top]
		}
	repeat 5
	// box bottom
	GetStackedScreenElementPos Y id=<id>
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=level_bottom_piece
		pos=<pos>
        rgba=[128 128 128 80]
		scale=(.96, 1)
		just=[left top]
	}
	// box right
	GetStackedScreenElementPos X id=startup_menu_box_top offset=(-20, 0)
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		
		texture=goal_right
		scale=(.8, .5)
        rgba=[128 128 128 80]
		pos=<pos>
		just=[left top]
	}
	
    // add an empty menu item for spacing
	CreateScreenElement {
		type=TextElement
		parent=current_menu
		
		font=small
		text=""
		not_focusable
	}
	
	SetScreenElementProps {
		id=root_window
		event_handlers= [ { pad_start  continue_career } ] 
		replace_handlers
	}
	main_menu_add_item text="Start Game" pad_choose_script=continue_career
	main_menu_add_item {
		text="Controls"
		pad_choose_script=bootstrap_displayscreen
		pad_choose_params={ screen="loadscrn_demo_controls" }
	}
	main_menu_add_item {
		text="More Info"
		pad_choose_script=bootstrap_displayscreen
		pad_choose_params={ screen="loadscrn_marketing" }
	}
    
	printf "create_Startup_menu"
	RunScriptOnScreenElement id=startup_menu menu_onscreen
	printf "step2"
/*
    CreateScreenElement {
    	type=element3d
		parent=root_window
		id=thps4_logo
		model="logo"
        pos=(320,130)
		CameraZ=-10
		Scale=0.05
		AngVelY=-.01           
        not_focusable
		}		
*/	
	
	CreateScreenElement {
		parent=root_window
		type=textelement
		id=ns_rules
		
		text="Neversoft and Activision 2002"
		font=newtrickfont
		pos=(320,420)
		rgba=[140 128 128 55]
		Scale=0.6
		just=[center center]
		not_focusable
	}
	
	//RunScriptOnScreenElement id=ns_rules morph_ns_rules	
	startup_camera_playback
	change STARTGAME_FIRST_TIME=0
	printf "step3"
endscript

script Bootstrap_displayscreen screen="loadscrn_demo_controls"
	if ObjectExists id=startup_menu
		DestroyScreenElement id=startup_menu
	endif
	if ObjectExists id=ns_rules		
		DestroyScreenElement id=ns_rules
	endif	
	
	make_new_menu menu_id=screen_menu 	
	
	SetScreenElementProps {
		id=root_window
		event_handlers=[ { pad_start  exit_screen_menu } ]
		replace_handlers
	}
	SetScreenElementProps {
		id=screen_menu
		event_handlers=[ { pad_start  exit_screen_menu }
						 {pad_choose  exit_screen_menu }
						 {pad_back  exit_screen_menu }
						 {pad_circle  exit_screen_menu }
						 {pad_square  exit_screen_menu }
					   ]
		replace_handlers
	}
	
	FireEvent type=focus target=screen_menu
	DisplayLoadingScreen <screen>
endscript

script exit_screen_menu
	if ObjectExists id=screen_menu
		DestroyScreenElement id=screen_menu
	endif	
	HideLoadingScreen
	create_startup_menu
endscript

script startup_main_menu	
	SetScreenElementProps {
		id=root_window
		event_handlers=[ { pad_start  handle_start_pressed } ]
		replace_handlers
	}
	
//	DestroyScreenElement id=thps4_logo
	if ObjectExists id=ns_rules
		DestroyScreenElement id=ns_rules
	endif	
	level_select_change_level level=Load_skateshop
endscript

script startup_camera_playback
	KillSkaterCamAnim all
	UnPauseGame
	PauseSkaters	
	PlaySkaterCamAnim skater=0 name=sch_overview_camera loop
endscript

script continue_career	
	SetScreenElementProps {
		id=root_window
		event_handlers=[ { pad_start  handle_start_pressed } ]
		replace_handlers
	}
//	DestroyScreenElement id=thps4_logo
	if ObjectExists id=ns_rules
		DestroyScreenElement id=ns_rules	
	endif
	KillSkaterCamAnim all
	GoalManager_ShowPoints
	GoalManager_ShowGoalPoints

	MakeSkaterGoto StartSkating1
	UnPauseskaters
	skiptrack
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	SetScreenElementProps {
		id=root_window
		tags={ menu_state = off }
	}
endscript

script morph_ns_rules
	begin
	fadein_fadeout text="Copyright Neversoft 2002"
//	fadein_fadeout text="so do not steal our ideas"
//	fadein_fadeout text="unless you pay us lots of money"
	repeat
endscript

script fadein_fadeout text="you forgot the text"
	SetProps text=<text>	
	DoMorph time=0 alpha=0    
	DoMorph time=2 alpha=1	
	wait 5 seconds
    DoMorph time=2 alpha=0
    DoMorph time=2 alpha=0
endscript



