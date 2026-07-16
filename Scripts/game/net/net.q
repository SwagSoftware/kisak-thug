InNetOptionsFromNetPlay = 0
InNetOptionsFromFaceDownload = 0
has_accepted_dnas = 0

script launch_viewer
printf "launch_viewer is no longer needed ... you can remove it from your startup script"
endscript

script auto_launch_viewer
LoadFromMemoryCard Name="Network settings" Type=NetworkSettings
;GetPreferenceChecksum pref_type=network config_type
;switch <checksum>
;	case config_sony
;		LoadNetConfigs
;		GetPreferenceString pref_type=network config_type
;		ChooseNetConfig name=<ui_string>
;endswitch

UseNetworkPreferences
LaunchViewer
endscript


NO_NET_MODE	= 0
LAN_MODE 	= 1
INTERNET_MODE	= 2

HOST_MODE_SERVE = 0
HOST_MODE_AUTO_SERVE = 1
HOST_MODE_FCFS = 2

JOIN_MODE_PLAY = 0
JOIN_MODE_OBSERVE = 1

e3_level_info = [
	{ name = "College"			checksum = load_sch }
	{ name = "Zoo"				checksum = load_zoo }
]

level_info = [
	{ name = "College"	       	checksum = load_sch }
	{ name = "San Francisco"	checksum = load_sf2 }
    { name = "Alcatraz"			checksum = load_alc }
	{ name = "Shipyard"			checksum = load_jnk }
	{ name = "London"			checksum = load_lon }
	{ name = "Kona"				checksum = load_kon }
	{ name = "Zoo"				checksum = load_zoo }
	{ name = "Carnival"			checksum = load_cnv }
	{ name = "Chicago" 			checksum = load_hof }
	{ name = "Created Park"		checksum = load_sk5ed_gameplay }
]

num_players_info = [
	{ name = "2 Players"		checksum = num_2 num = 2}
	{ name = "3 Players"		checksum = num_3 num = 3}
	{ name = "4 Players"		checksum = num_4 num = 4 broadband_only }
	{ name = "5 Players"		checksum = num_5 num = 5 broadband_only }
	{ name = "6 Players"		checksum = num_6 num = 6 broadband_only }
	{ name = "7 Players"		checksum = num_7 num = 7 broadband_only }
	{ name = "8 Players"		checksum = num_8 num = 8 broadband_only }
]

net_game_type_info = [
	{ name = "Trick Attack"		description="Player with the highest score at the end of the time limit wins"	checksum = nettrickattack goal_script=StartGoal_TrickAttack icon="2p_attack"}
	{ name = "Score Challenge"	description="The first player to reach the\nset score wins"									checksum = netscorechallenge goal_script=StartGoal_ScoreChallenge icon="2p_score"}
	{ name = "Combo Mambo"		description="The player who busts the biggest combo during the time limit, wins"	checksum = netcombomambo goal_script=StartGoal_ComboMambo icon="2p_mambo"}
	{ name = "Slap!"			description="The player who slaps their opponents the most times, wins"		checksum = netslap goal_script=StartGoal_Slap icon="2p_slap"}
	{ name = "King of the Hill"	description="The player who holds the crown\nfor the set time wins"					checksum = netking goal_script=StartGoal_King icon="2p_koth"}
	{ name = "Graffiti"			description="The player who tags the most objects wins"								checksum = netgraffiti goal_script=StartGoal_Graffiti icon="2p_graffiti"}
	{ name = "Goal Attack"		description="First one to finish all the \nselected goals wins"					checksum = netgoalattack goal_script=StartGoal_GoalAttack icon="2p_goal"}
	{ name = "Capture the Flag" description="Capture another team's flag and return it to your base"	checksum = netctf goal_script=StartGoal_CTF icon="2p_flag"}
    { name = "FireFight"        description="Launch fireballs with\n either \b1\b7 or \b1\b4.\nLast man standing wins."	checksum = netfirefight goal_script=StartGoal_FireFight icon="2p_fire"}
	
]

net_game_type_info_demo = [
	{ name = "Trick Attack"		description="Player with the highest score at the end of the time limit wins"	checksum = nettrickattack goal_script=StartGoal_TrickAttack icon="2p_attack"}
//	{ name = "Score Challenge"	description="First one to reach set score wins"									checksum = netscorechallenge goal_script=StartGoal_ScoreChallenge}
//	{ name = "Combo Mambo"		description="The player who busts the biggest combo during the time limit, wins!"	checksum = netcombomambo goal_script=StartGoal_ComboMambo}
	{ name = "Slap!"			description="Player who slaps their opponent the most times within the time limit wins"	checksum = netslap goal_script=StartGoal_Slap icon="2p_slap"}
	{ name = "King of the Hill"	description="Player who holds the crown for the set time wins"					checksum = netking goal_script=StartGoal_King icon="2p_koth"}
	{ name = "Graffiti"			description="Player who tags the most objects wins"								checksum = netgraffiti goal_script=StartGoal_Graffiti icon="2p_graffiti"}
//	{ name = "Goal Attack"		description="First one to finish all the selected goals wins"					checksum = netgoalattack goal_script=StartGoal_GoalAttack }
//	{ name = "Capture the Flag" description="Capture another teams flag and get it to your base without losing your own flag!"	checksum = netctf goal_script=StartGoal_CTF team_only }   
]


mp_game_type_info = [
	{ name = "Trick Attack"		description="Player with the highest score at the end of the time limit wins"		checksum = trickattack goal_script=StartGoal_TrickAttack icon="2p_attack"}
	{ name = "Score Challenge"	description="First one to reach set score wins"										checksum = scorechallenge goal_script=StartGoal_ScoreChallenge icon="2p_score"}
	{ name = "Combo Mambo"		description="The player who busts the biggest combo during the time limit, wins!"	checksum = combomambo goal_script=StartGoal_ComboMambo icon="2p_mambo"}
	{ name = "Slap!"			description="Player who slaps their opponent the most times within the time limit wins"	checksum = slap goal_script=StartGoal_Slap icon="2p_slap"}
	{ name = "King of the Hill"	description="Player who holds the crown for the set time wins"						checksum = king goal_script=StartGoal_King icon="2p_koth"}
	{ name = "Graffiti"			description="Player who tags the most objects wins"									checksum = graffiti goal_script=StartGoal_Graffiti icon="2p_graffiti"}
	{ name = "Horse"			description="Pull off combos until someone spells horse"							checksum = horse goal_script=do_nothing icon="2p_horse"};StartGoal_Horse_Mp }
	{ name = "Free Skate"		description="Skate the level freely"												checksum = freeskate2p goal_script=StartFreeSkate icon="2p_free"}
    { name = "FireFight"		description="Launch fireballs with\n either \b1\b7 or \b1\b4.\nLast man standing wins."	checksum = firefight goal_script=StartGoal_FireFight icon="2p_fire"}
]

num_observers_info = [
	{ name = "No Observers"		checksum = num_0 }
	{ name = "1 Observer"		checksum = num_1 broadband_only }
]

net_goal_info = [
	{ name = "Story Mode"		checksum = goals_story }
	{ name = "Created"			checksum = goals_created }
]

skill_level_info = [
	{ name = "1: Baby Steps"	checksum = num_1 }
	{ name = "2: I Can Crawl!"	checksum = num_2 }
	{ name = "3: Hold My Own"	checksum = num_3 }
	{ name = "4: Let's Do This"	checksum = num_4 }
	{ name = "5: Bring It On!"	checksum = num_5 }
]

fireball_level_info = [
	{ name = "1 (easy)"	checksum = num_1 fireball_level=1 }
	{ name = "2" checksum = num_2 fireball_level=2 }
	{ name = "3"	checksum = num_3 fireball_level=3 }
	{ name = "4"	checksum = num_4 fireball_level=4 }
	{ name = "5 (hard)"	checksum = num_5 fireball_level=5 }
]

script sign_out
	SignOut
	create_pause_menu
endscript
	   
script go_to_xbox_dashboard
	GotoXboxDashboard
endscript 

script create_big_black_hiding_box
	// Hide the evil going on-screen with a huge black box
	unlock_root_window
    if ScreenElementExists id=big_black_box
	 DestroyScreenElement id=big_black_box
	endif
	
	CreateScreenElement {
		  type=SpriteElement
		  parent=root_window
		  id=big_black_box
		  
		  texture=black
		  pos=(320,240)
		  rgba=[0 0 0 128]
		  scale=(190, 190)
		  just=[center center]
		  z_priority=5001
	}
endscript

script quit_network_game
	if OnXbox
		DisplayLoadingScreen "loadscrn_generic" 17
	else
		create_big_black_hiding_box
	endif
	
	console_destroy
	SetScreenElementProps {
			id=root_window
			event_handlers=[
			{pad_start			handle_start_pressed}
			]
			replace_handlers							
		}
		
	if InInternetMode
        if OnServer
            ReportStats final
        endif
		if ProfileLoggedIn
			SetLobbyStatus
		endif
        CancelNatNegotiation
	endif
	
    if ObjectExists id=skater
        if Not IsObserving
            Skater:NetEnablePlayerInput
			
			// GJ:  if we were in the middle of a 
			// special trick, we'll need to destroy it...
			Skater:DestroyAllSpecialItems		
        endif
    endif
    
    if Not IsObserving
        ExitSurveyorMode
    endif
    
    ProximCleanup
	// Leave the server we're currently on. If we're the server, it will also shut our server down
	chosen_leave_server
	//DisplayLoadingScreen "loadscrn_generic" 17
    dialog_box_exit anchor_id=quit_dialog_anchor
	dialog_box_exit
    
	
	SetGameType career
    SetCurrentGameType
	SetStatOverride	// Put stats back at regular amounts
	
	// Now, create a local server
	setservermode on
	StartServer
	// Join our local server
	SetJoinMode	JOIN_MODE_PLAY
    
    // Hack to make sure the unloading mechanism still realizes it's in 'net mode'
    SetNetworkMode LAN_MODE
    JoinServer
   	// Wait until we have joined our local server
	begin
   		if JoinServerComplete
   			break
		else
			Wait 1	
		endif
	repeat
    
	//Skater:EnablePlayerInput
	// Load the skateshop
   	if InInternetMode
		SetQuietMode OFF
	endif
	
    // Ensure that we're in a simple game mode when we quit. Otherwise some scripts get
    // confused and think we're in 2p mode
    SetGameType NetLobby
	SetCurrentGameType
	level_select_change_level level=Load_skateshop no_levelUnload
    SetNetworkMode   
endscript

script spawned_chosen_host_game
    if IsXbox
		DisplayLoadingScreen "loadscrn_system_link_x"
	endif
	// get rid of the menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 frame
	endif
	
	// GJ KLUDGE FOR SK5:TT13382 - "System Link - Blank 
	// screen with skater on it when loading a level from shell"
	// need to display loading screen again, because
	// something just killed off a movie cam, which 
	// switches the main camera to the skater's
	// cam one frame later. 
    if IsXbox
		DisplayLoadingScreen "loadscrn_system_link_x"
	endif

    leave_front_end
    
	Cleanup preserve_skaters
	if Not IsXbox
		DisplayLoadingScreen "loadscrn_Online"
	endif
	FreeServerList	
	LeaveServer	// First, shutdown the current local server
	SetGameType NetLobby
	SetCurrentGameType
	InitSkaterHeaps
	SetServerMode
	StartServer	// Spawn a new network server
	SetJoinMode	JOIN_MODE_PLAY
	JoinServer
	begin
		if JoinServerComplete
			break
		else
			Wait 1	
		endif
	repeat
	
	ChangeLevel level=use_preferences
	exit_pause_menu
endscript

script chosen_host_game
	change in_server_options=0
	if InNetGame
		network_start_selected
	else
		if InSplitScreenGame
			ApplySplitScreenOptions
			;MakeSkaterGosub add_skater_to_world skater=0
			;MakeSkaterGosub add_skater_to_world skater=1
			chosen_start_game
		else
			change check_for_unplugged_controllers = 0
			change is_changing_levels = 1
			SpawnScript spawned_chosen_host_game NotSessionSpecific=1
		endif
	endif
endscript

script select_network_play
    PauseMusicAndStreams
    change_gamemode_net
	//if entering a net game, enforce the rule of normal difficulty
    GoalManager_SetDifficultyLevel 1
    do_network_setup error_script=back_from_startup_error_dialog success_script=net_setup_from_net_play_successful need_setup_script=create_net_startup_need_setup_dialog
endscript

script net_setup_from_net_play_successful
    dialog_box_exit
	PauseMusicAndStreams
	
    launch_select_skater_menu change_gamemode=change_gamemode_net
endscript

script do_network_setup
	SetMemThreadSafe
    UseNetworkPreferences
    SpawnScript test_network_setup params= <...>	// Tests the network setup. If it succeeds, it launches "create_network_select_menu"
endscript

script spoof_usb_adaptor_setup
    set_preferences_from_ui prefs=network field="device_type" string="USB Ethernet Adaptor" checksum=device_broadband_usb
endscript

script spoof_pcmcia_adaptor_setup
    set_preferences_from_ui prefs=network field="device_type" string="Ethernet (Network Adaptor for PS2)" checksum=device_broadband_pc
endscript

script test_network_setup
	
	if levelIs load_skateshop
		skater:hide
	endif
	PauseMusicAndStreams
    GetPreferenceChecksum pref_type=network device_type
	switch <checksum>
        case device_none
            <need_setup_script> text=net_status_need_to_setup <...>
            return
		case device_sony_modem
		case device_usb_modem
            GetPreferenceString pref_type=network dialup_number
            if( <ui_string> = "" )
                <need_setup_script> text=net_status_need_to_setup_dialup <...>
                return
            endif
        default
    endswitch
    
    if NeedToTestNetSetup
		PauseMusicAndStreams
        create_testing_network_settings_dialog
        Wait 1 Seconds
        TestNetSetup <...>
		pauseMusicAndStreams
    else
		
        <success_script> <...>
    endif
endscript

script launch_network_host_options_sub_menu
    ;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=<sub_menu_script>
	PrintStruct <...>
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	<sub_menu_script> <...>
endscript

script back_from_account_list_menu
	CancelLogon
	SetNetworkMode
	create_pause_menu
	;RunScriptOnScreenElement id=dialog_box_anchor menu_offscreen callback=create_pause_menu
endscript

script back_from_create_account_dialog
	dialog_box_exit
	back_from_account_list_menu
endscript

script back_from_wrong_pin_dialog
	dialog_box_exit
	ConnectToInternet
endscript

script launch_no_accounts_dialog
	create_dialog_box { title="NO ACCOUNTS FOUND" 
                        text="No accounts were found on your system. Would you like to create an account now?" 
                        buttons=[ { text="Yes" pad_choose_script=go_to_xbox_dashboard } 
                                  { text="No" pad_choose_script=back_from_create_account_dialog }
                                ]
                      }
endscript

script launch_auto_server_notification
	destroy_onscreen_keyboard
	create_error_box { title="Auto-Server" 
                        text="This server is in auto-server mode.  When at least two players are present, games will launch one-after-another." 
                        buttons=[ { text="ok" pad_choose_script=dialog_box_exit } 
                                ]
						no_animate
						delay_input
                      }
endscript

script launch_auto_server_explanation
	destroy_onscreen_keyboard
	create_error_box { title="Auto-Serve" 
                        text="You are in auto-server mode.  When at least two players have joined, a new game will start and new games will follow thereafter."
						buttons=[ { text="ok" pad_choose_script=dialog_box_exit } 
                                ]
						no_animate
						delay_input
                      }
endscript					  

script launch_fcfs_notification
	if( <checksum> = boolean_true )
		set_preferences_from_ui prefs=network field="player_collision" string="On" <...>
	else
		set_preferences_from_ui prefs=network field="player_collision" string="Off" <...>
	endif
	
	
	destroy_onscreen_keyboard
	force_close_rankings
	exit_pause_menu
	create_error_box { title="Host Notification" 
                        text="This server is in First Come First Serve mode.  You are the designated host.  You may change options and start games."
                        buttons=[ { text="ok" pad_choose_script=exit_async_dialog } 
                                ]
						no_animate
						delay_input
                      }
endscript

script fcfs_confirm
	DestroyScreenElement id=current_menu_anchor
    create_dialog_box { title="First Come First Serve" 
                        text="This option will make you a permanent observer and will allow the first joining player to choose game modes and change levels.  Are you sure?" 
						text_dims=(350,0)
                        buttons=[ { text="Yes" pad_choose_script=fcfs_selected } 
                                  { text="No" pad_choose_script=create_sit_out_menu }
                                ]
						no_animate
                      }
endscript

script auto_serve_confirm
	DestroyScreenElement id=current_menu_anchor
	create_dialog_box { title="Auto Serve" 
                        text="This option will make you a permanent observer. When at least two players have joined, a new game of the current game mode will start and new games will follow thereafter. Are you sure?"
                        buttons=[ { text="Yes" pad_choose_script=auto_serve_selected } 
                                  { text="No" pad_choose_script=create_sit_out_menu }
                                ]
						no_animate
                      }
endscript

script create_kick_ban_menu
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen
	DestroyScreenElement id=current_menu_anchor
	create_dialog_box { title=<name>
                        text="Remove Player?"
                        buttons=[ 	{ text="cancel" pad_choose_script=cancel_remove_player } 
									{ text="kick" pad_choose_script=kick_player_confirm pad_choose_params=<...> } 
									{ text="ban" pad_choose_script=ban_player_confirm pad_choose_params=<...> } 
                                ]
						no_animate
                      }
endscript

script create_player_options_dialog
	if GotParam allow_remove_homie
		DestroyScreenElement id=current_menu_anchor
		if OnServer
			create_dialog_box { title="Player Options"
								text=<name>
								pad_back_script = cancel_remove_player
								buttons=[ 	{ text="cancel" pad_choose_script=cancel_remove_player } 
											{ text="kick" pad_choose_script=kick_player_confirm pad_choose_params=<...> } 
									        { text="ban" pad_choose_script=ban_player_confirm pad_choose_params=<...> } 
											{ text="remove homie" pad_choose_script=remove_buddy pad_choose_params=<...> } 
										]
								no_animate
							  }
		else
			create_dialog_box { title="Player Options"
								text=<name>
								pad_back_script = cancel_remove_player
								buttons=[ 	{ text="cancel" pad_choose_script=cancel_remove_player } 
											{ text="remove homie" pad_choose_script=remove_buddy pad_choose_params=<...> } 
										]
								no_animate
							  }
		endif
	else
		if GotParam allow_add_homie
			DestroyScreenElement id=current_menu_anchor
			if OnServer
				create_dialog_box { title="Player Options"
								text=<name>
								pad_back_script = cancel_remove_player
								buttons=[ 	{ text="cancel" pad_choose_script=cancel_remove_player } 
											{ text="kick" pad_choose_script=kick_player_confirm pad_choose_params=<...> } 
									        { text="ban" pad_choose_script=ban_player_confirm pad_choose_params=<...> } 
											{ text="add homie" pad_choose_script=add_buddy pad_choose_params=<...> } 
										]
								no_animate
							  }
			else
				create_dialog_box { title="Player Options"
								text=<name>
								pad_back_script = cancel_remove_player
								buttons=[ 	{ text="cancel" pad_choose_script=cancel_remove_player } 
											{ text="add homie" pad_choose_script=add_buddy pad_choose_params=<...> } 
										]
								no_animate
							  }
			endif
		else
			if OnServer
				DestroyScreenElement id=current_menu_anchor
				create_dialog_box { title="Player Options"
							text=<name>
							pad_back_script = cancel_remove_player
							buttons=[ 	{ text="cancel" pad_choose_script=cancel_remove_player } 
										{ text="kick" pad_choose_script=kick_player_confirm pad_choose_params=<...> } 
									    { text="ban" pad_choose_script=ban_player_confirm pad_choose_params=<...> } 
									]
							no_animate
						  }
			endif
		endif
	endif
endscript


script launch_add_buddy
	DestroyScreenElement id=current_menu_anchor
	
	make_new_menu menu_id=add_buddy_menu vmenu_id=homie_vmenu menu_title="ADD HOMIE"
	// Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=add_buddy_menu event_handlers=[
                                            {pad_back generic_menu_pad_back params={ callback=create_pause_menu}}
                                         ]
                          } 
						  
	FillProspectiveBuddyList
	
	RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
endscript

script cancel_add_buddy
	dialog_box_exit
	printf "cancel_add_buddy"
	;lobby_player_list_menu:DoMorph time=0 scale=.65
	;lobby_player_list_title:DoMorph time=0 scale=.95
    actions_menu_anchor:DoMorph scale=1
	game_list_menu_anchor:DoMorph scale=1
	DoScreenElementMorph id=player_list_anchor time=0 scale=1
	DoScreenElementMorph id=chat_box_anchor time=0 scale=1
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=1
	endif
    FireEvent type=focus target=lobby_player_list_menu
	change current_lobby_focus=2
	change check_for_unplugged_controllers=1
	AssignAlias id=lobby_player_list_menu alias=current_menu
	SetScreenElementLock id=current_menu_anchor off
	create_helper_text generic_helper_text
	SetScreenElementLock id=current_menu_anchor on
endscript

script cant_add_buddy_prompt_1
	FireEvent type=unfocus target=lobby_player_list_menu
	change check_for_unplugged_controllers=0
	actions_menu_anchor:DoMorph scale=0
	game_list_menu_anchor:DoMorph scale=0
	DoScreenElementMorph id=player_list_anchor time=0 scale=0
	DoScreenElementMorph id=chat_box_anchor time=0 scale=0
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=0
	endif
	
	FormatText TextName=msg_text "This user does not have a Gamespy profile and therefore can not be tracked and added to your homie list."
	create_dialog_box { title="PLAYER NOT LOGGED IN" 
                        text=<msg_text>
						no_bg=no_bg
						text_dims=(300,0)
                        buttons=[   { text="ok" pad_choose_script=cancel_add_buddy } 
                                ]
                      }
endscript

script cant_add_buddy_prompt_3
	FireEvent type=unfocus target=lobby_player_list_menu
	change check_for_unplugged_controllers=0
	actions_menu_anchor:DoMorph scale=0
	game_list_menu_anchor:DoMorph scale=0
	DoScreenElementMorph id=player_list_anchor time=0 scale=0
	DoScreenElementMorph id=chat_box_anchor time=0 scale=0
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=0
	endif
	
	FormatText TextName=msg_text "Your homie list is full. You must remove some homies before adding new ones."
	create_dialog_box { title="HOMIE LIST FULL" 
                        text=<msg_text>
						no_bg=no_bg
                        buttons=[   { text="ok" pad_choose_script=cancel_add_buddy } 
                                ]
                      }
endscript

script cant_add_buddy_prompt_2
	FireEvent type=unfocus target=lobby_player_list_menu
	change check_for_unplugged_controllers=0
	actions_menu_anchor:DoMorph scale=0
	game_list_menu_anchor:DoMorph scale=0
	DoScreenElementMorph id=player_list_anchor time=0 scale=0
	DoScreenElementMorph id=chat_box_anchor time=0 scale=0
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=0
	endif
		
	FormatText TextName=msg_text "You must create a Gamespy profile before you can track users by adding them to your homie list."
	create_dialog_box { title="NO GAMESPY PROFILE" 
                        text=<msg_text>
						no_bg=no_bg
                        buttons=[   { text="ok" pad_choose_script=cancel_add_buddy } 
                                ]
                      }
endscript

script cant_add_self_to_buddy_prompt
	FireEvent type=unfocus target=lobby_player_list_menu
	change check_for_unplugged_controllers=0
	actions_menu_anchor:DoMorph scale=0
	game_list_menu_anchor:DoMorph scale=0
	DoScreenElementMorph id=player_list_anchor time=0 scale=0
	DoScreenElementMorph id=chat_box_anchor time=0 scale=0
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=0
	endif
		
	FormatText TextName=msg_text "You may not add yourself to your own homie list."
	create_dialog_box { title="MY OWN HOMIE" 
                        text=<msg_text>
						no_bg=no_bg
                        buttons=[   { text="ok" pad_choose_script=cancel_add_buddy } 
                                ]
                      }
endscript

script already_buddy_prompt
	FireEvent type=unfocus target=lobby_player_list_menu
	change check_for_unplugged_controllers=0
	actions_menu_anchor:DoMorph scale=0
	game_list_menu_anchor:DoMorph scale=0
	DoScreenElementMorph id=player_list_anchor time=0 scale=0
	DoScreenElementMorph id=chat_box_anchor time=0 scale=0
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=0
	endif
	
	FormatText TextName=msg_text "This user is already on your homie list."
	create_dialog_box { title="ALREADY YOUR HOMIE" 
                        text=<msg_text>
						no_bg=no_bg
                        buttons=[   { text="ok" pad_choose_script=cancel_add_buddy } 
                                ]
                      }
endscript

script add_buddy_prompt
    FireEvent type=unfocus target=lobby_player_list_menu
	change check_for_unplugged_controllers=0
	actions_menu_anchor:DoMorph scale=0
	game_list_menu_anchor:DoMorph scale=0
	DoScreenElementMorph id=player_list_anchor time=0 scale=0
	DoScreenElementMorph id=chat_box_anchor time=0 scale=0
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=0
	endif
	
    FormatText TextName=msg_text "Add %s to your homie list?" s=<net_name>
	create_dialog_box { title="ADD HOMIE" 
                        text=<msg_text>
						no_bg=no_bg
                        buttons=[ 	{ text="Yes" pad_choose_script=lobby_add_buddy pad_choose_params=<...> } 
									{ text="No" pad_choose_script=cancel_add_buddy } 
                                ]
                      }
endscript

script add_buddy
	if BuddyListFull
        dialog_box_exit
		create_buddy_list_full_dialog
	else
		AddBuddy <...>
        dialog_box_exit
		create_adding_buddy_dialog
	endif
endscript

script remove_buddy
	RemoveBuddy <...>
	dialog_box_exit
	create_removed_buddy_dialog
endscript

script lobby_add_buddy
	dialog_box_exit
	AddBuddy profile=<profile> nick=<net_name>
	if InNetGame
		create_dialog_box { title=net_status_msg
						text="Added homie"
						buttons=[ { text="close" pad_choose_script=cancel_add_buddy } 
                                ]
						}
	else
        FormatText TextName=msg_text "Adding %s to homie list..." s=<net_name>
		SendMessage text=<msg_text> system_message
		cancel_add_buddy
		if ScreenElementExists id=actions_menu
            FillPlayerList
			if ( current_lobby_focus = 2 )
                refocus_actions_menu
			endif
		endif
	endif
	
	;lobby_player_list_menu:DoMorph time=0 scale=.65
	;lobby_player_list_title:DoMorph time=0 scale=.95
    ;FireEvent type=focus target=lobby_player_list_menu
endscript

script create_adding_buddy_dialog
	if inNetGame
		dialog_box_exit
		exit_pause_menu
		create_console_message text="<system>: Adding homie.."
	else
		create_dialog_box { title=net_status_msg
						text="Adding homie..."
						buttons=[ { text="close" pad_choose_script=close_add_buddy } 
                                ]
						}
	endif
endscript

script create_buddy_list_full_dialog
	if inNetGame
		dialog_box_exit
		exit_pause_menu
		create_console_message text="<system>: Your homie list is full."
	else
		create_dialog_box { title=net_error_msg
							text="Your homie list is full. You must remove some homies before adding new ones."
							buttons=[ { text="close" pad_choose_script=close_add_buddy } 
									]
							}
	endif
endscript

script failed_add_buddy_already_buddy
	if InNetGame
		create_failed_add_buddy_dialog
	else
		SendMessage text="User already on homie list." system_message
	endif
endscript

script added_buddy
	// In the skateshop, only print the console message notification. If in-game, show a dialog
	if LevelIs load_skateshop
        FormatText TextName=msg_text "Added %s to homie list." s=<net_name>
		SendMessage text=<msg_text> system_message
	else
		create_added_buddy_dialog
	endif
endscript

script removed_buddy
	if ObjectExists id=<id>
		DestroyScreenElement id=<id>
	endif
endscript

script create_added_buddy_dialog
	;dialog_box_exit
	if inNetGame
		dialog_box_exit
		exit_pause_menu
		create_console_message text="<system>: Added homie."
	else
		if not ObjectExists id=dialog_box_anchor
			create_dialog_box { title=net_status_msg
								text="Added homie."
								buttons=[ { text="ok" pad_choose_script=accept_buddy_ok } 
										]
								}
		endif
	endif
endscript

script create_removed_buddy_dialog
	if inNetGame
		dialog_box_exit
		exit_pause_menu
		create_console_message text="<system>: Removed homie."
	else
		dialog_box_exit
		create_dialog_box { title=net_status_msg
							text="Removed homie."
							buttons=[ { text="ok" pad_choose_script=accept_buddy_ok } 
									]
							}
	endif
endscript



script create_failed_add_buddy_dialog
	destroy_onscreen_keyboard
	dialog_box_exit
	create_error_box { title=net_status_msg
						text="User was already your homie."
						buttons=[ { text="ok" pad_choose_script=accept_buddy_ok } 
                                ]
						}
endscript

script close_add_buddy
	dialog_box_exit
	create_pause_menu
endscript

script accept_buddy_ok
	dialog_box_exit
	create_pause_menu
endscript

script launch_quit_game_dialog
    dialog_box_exit
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	create_quit_game_dialog
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_quit_game_dialog
endscript

script create_quit_game_dialog
    	create_error_box { title="Quit Game"
                        text="Are you sure?"
                        anchor_id=quit_dialog_anchor
                        buttons=[  	{ text="Yes" pad_choose_script=quit_network_game } 
									{ text="No" pad_choose_script=quit_game_dialog_box_exit }
                                ]
						no_animate
                      }
endscript
	
script quit_game_dialog_box_exit
    	generic_menu_pad_back_sound
	exit_pause_menu
	dialog_box_exit anchor_id=quit_dialog_anchor
endscript

script launch_wrong_pin_dialog_box
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen
	DestroyScreenElement id=current_menu_anchor
	create_dialog_box { title="WRONG PIN" 
                        text="The PIN you have entered is incorrect." 
                        buttons=[ { text="ok" pad_choose_script=back_from_wrong_pin_dialog } 
                                ]
                      }
endscript

script select_xbox_multiplayer  
	//SetNetworkMode LAN_MODE
    ;create_network_select_games_menu play_cam
    change_gamemode_net
	launch_select_skater_menu
endscript
	
script launch_network_select_games_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	create_network_select_games_menu play_cam
    ;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_network_select_games_menu
endscript

script launch_remove_players_menu
	hide_current_goal
	DestroyScreenElement id=current_menu_anchor
	create_remove_players_menu
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_remove_players_menu
endscript

script launch_xbox_online_menu
	DestroyScreenElement id=current_menu_anchor
	create_xbox_online_menu
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_xbox_online_menu
endscript

script chose_xbox_online
	if AlreadySignedIn
		create_xbox_online_menu
	else
		chose_internet
	endif
endscript

script connected_to_internet
	PauseMusicAndStreams
    if Not AlreadyGotMotd
        DownloadMotd
    else
        if ObjectExists id=current_menu_anchor
            DestroyScreenElement id=current_menu_anchor
        endif
        if Not ProfileLogIn
            create_internet_options
        endif
    endif
endscript

script failed_internet_connection
	printf "script failed_internet_connection"
    create_ss_menu no_animate
endscript

script chose_internet
    SetNetworkMode INTERNET_MODE
    if OnXbox
		//create_account_list_menu
        ConnectToInternet
    else
        // If we are connected or can immediately connect to the internet, continue to the motd or lobby list
        // otherwise, let the code manage the flow for connecting to the internet
        if ConnectToInternet success=authenticate_client failure=failed_internet_connection
   			printf "connected to internet"
		else
   			if ObjectExists id=current_menu_anchor
				DestroyScreenElement id=current_menu_anchor
			endif
        endif
    endif
endscript

script confirm_observe
    generic_menu_pad_back_sound
	exit_pause_menu
	dialog_box_exit
	EnterObserverMode
endscript

script chose_observe
	//exit_pause_menu
    if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	create_dialog_box { title="Observer Mode"
						text="Are you sure you would like to observe this game? You will not be able to jump back in."
						buttons=[ 	{ text="Yes" pad_choose_script=confirm_observe } 
									{ text="No" pad_choose_script=back_from_dialog }
                                ]
						no_animate
					}
endscript

script launch_motd_wait_dialog

	dialog_box_exit
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	create_motd_wait_dialog
endscript

script launch_network_select_lan_games_menu
	KillSkaterCamAnim all
	
	Skater:reset_model_lights
	Skater:remove_skater_from_world
	
	KillSkaterCamAnim all
	PlaySkaterCamAnim skater=0 name=mainmenu_camera03 play_hold
	SetNetworkMode LAN_MODE
	launch_network_select_games_menu
endscript

script launch_network_host_options_menu
	dialog_box_exit
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	create_network_host_options_menu
endscript

in_server_options=0

script back_from_internet_host_options
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 frame
	endif
	
	change in_server_options=0
	
	if InNetGame
		create_pause_menu
	else
		launch_network_select_games_menu
	endif
endscript

in_net_lobby=0

script back_from_auth_error
	printf "script back_from_auth_error"
    dialog_box_exit
    create_ss_menu no_animate
endscript

script display_auth_error
    PauseMusicAndStreams
    dialog_box_exit
    FormatText textname=message "DNAS Error (%s)\n%e\n\n%f" s=<sub_code> e=<desc> f=<footer>
    create_dialog_box { title=net_error_msg
                        text=<message>
						text_dims=(500,0)
                        buttons=[   { text="OK" pad_choose_script=back_from_auth_error } 
                                ]
                      }
endscript

script spawn_dnas_authentication
    Wait 30 frames
    AuthenticateClient
endscript

script authenticate_client
    KillSkaterCamAnim all
	
	Skater:reset_model_lights
	Skater:remove_skater_from_world
	
	KillSkaterCamAnim all
	PlaySkaterCamAnim skater=0 name=mainmenu_camera03 play_hold
	
	PauseMusicAndStreams 1
 
    //show_disclaimer
	if CD
        skater:remove_skater_from_world
		create_dialog_box { title=net_status_msg
                            text=net_auth_msg
							logo=dnas
							no_icon=no_icon
							no_animate
                          }
        SpawnScript spawn_dnas_authentication
    else
        connected_to_internet        
    endif
endscript

current_lobby_focus=0

script host_chosen
	console_hide
	StopServerList
	FreeServerList
    launch_network_host_options_menu
endscript

script fcfs_selected
	dialog_box_exit
	SetHostMode HOST_MODE_FCFS
	exit_pause_menu
endscript

script auto_serve_selected
	dialog_box_exit
	
	GetPreferenceChecksum pref_type=network game_type		
	switch <checksum>
		case netgoalattack
			if Not GoalManager_GoalsAreSelected
				exit_pause_menu
				create_dialog_box { title="No Goals Selected"
							text= "You must select goals before starting the Goal Attack auto-server."
							buttons=[ { text="ok" pad_choose_script=back_from_dialog } 
									]
								}
				return
			endif
	endswitch
	SetHostMode HOST_MODE_AUTO_SERVE
	exit_pause_menu
	//launch_auto_server_explanation
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=launch_auto_server_explanation
endscript

script create_sit_out_menu
	dialog_box_exit
	FormatText ChecksumName=title_icon "%i_end" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="SIT OUT" title_icon=<title_icon>
	// Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=sub_menu event_handlers=[
                                            {pad_back   generic_menu_pad_back params={ callback=create_pause_menu}}
                                         ]
                          }
						  
	create_helper_text generic_helper_text						   
	
	/*CreateScreenElement {
				type=TextElement
				parent=current_menu_anchor
                
				font=testtitle
				text="SIT OUT"
				scale=1.4
				pos=(206,112)
				just= [left top]
				rgba=[128 128 128 98]            
				not_focusable
			}*/

	
	//spacer item
	;main_menu_add_item text="" pad_choose_script=null_script not_focusable=not_focusable
	
	theme_menu_add_item text="First Come, First Serve" id=menu_network_fcfs_select pad_choose_script=fcfs_confirm highlight_bar_scale=(1.15, 1.3) highlight_bar_pos=(97, -7) centered=1
    theme_menu_add_item text="Auto-Serve" id=menu_network_auto_serve_select pad_choose_script=auto_serve_confirm highlight_bar_scale=(1.15, 1.3) highlight_bar_pos=(97, -7) centered=1 last_menu_item=1
	
    ;RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
	finish_themed_sub_menu
endscript

script launch_network_sit_out_menu
	hide_current_goal
	DestroyScreenElement id=current_menu_anchor
	create_sit_out_menu
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_sit_out_menu
endscript 
	
script do_nothing
endscript

script create_motd_menu
	dialog_box_exit
	if IsPal
		create_dialog_box { title="MESSAGE" 
                        text=<message>
						text_dims=(600,0)
                        buttons=[ { text="ok" pad_choose_script=profile_connect } 
                                ]
                      }
	else
		create_dialog_box { title="MESSAGE" 
                        text=<message>
						sub_logo=esrb
						text_dims=(600,0)
                        buttons=[ { text="ok" pad_choose_script=profile_connect } 
                                ]
                      }
	endif
	
endscript

script create_motd_wait_dialog
	dialog_box_exit
	create_dialog_box { title=net_status_msg
                        text=net_status_checking_motd
						no_animate
                      }
endscript

script CreateMotdRetryDialog
	dialog_box_exit
	create_dialog_box { title=net_status_msg
                        text=<message>
						no_animate
                      }
endscript

script CreateMotdFailedDialog
	dialog_box_exit
	create_dialog_box { title=net_status_msg
                        text=net_status_motd_failed
						buttons=[ { text="ok" pad_choose_script=back_from_startup_error_dialog } 
						]
                      }
endscript

script StatsLoginFailedDialog
    dialog_box_exit
	create_dialog_box { title=net_error_msg
                        text=net_status_stats_login_failed
						buttons=[ { text="ok" pad_choose_script=back_from_profile_error } 
						]
                      }
endscript

script StatsRetrievalFailedDialog
    dialog_box_exit
	create_dialog_box { title=net_error_msg
                        text=net_status_stats_retrieval_failed
						buttons=[ { text="ok" pad_choose_script=back_from_profile_error } 
						]
                      }
endscript

script back_from_failed_buddy_login
    dialog_box_exit
    SetNetworkMode
	create_ss_menu no_animate
endscript

script CreateBuddyLoginFailedDialog
	dialog_box_exit
	create_dialog_box { title=net_error_msg
                        text=net_status_buddy_login_failed
						buttons=[ { text="ok" pad_choose_script=back_from_failed_buddy_login}//back_from_profile_error } 
						]
                      }
endscript 

script back_from_removed_dialog
	dialog_box_exit
	if EnteringNetGame
		cancel_join_server
	else
		quit_network_game
	endif
endscript

script CreateServerRemovedYouDialog
    HideLoadingScreen
    
    GoalManager_DeactivateAllGoals force_all
    GoalManager_UninitializeAllGoals
	GoalManager_SetCanStartGoal 0
	kill_net_panel_messages
	
    force_close_rankings dont_retry
    destroy_onscreen_keyboard
    dialog_box_exit
    exit_pause_menu
    if Not IsObserving
		skater:Vibrate off
	endif
    change check_for_unplugged_controllers=0
	create_error_box { title=net_notice_msg
                        text=net_message_server_removed_you
						buttons=[ { text="ok" pad_choose_script=back_from_removed_dialog } 
						]
						delay_input
                      }
endscript

script CreateServerMovedOnDialog
	HideLoadingScreen
	force_close_rankings dont_retry
	destroy_onscreen_keyboard
	dialog_box_exit
	exit_pause_menu	
	if Not IsObserving		
		skater:Vibrate off
	endif
	change check_for_unplugged_controllers=0
	create_error_box { title=net_notice_msg
                        text=net_message_server_moved_on
						buttons=[ { text="ok" pad_choose_script=back_from_removed_dialog } 
						]
						delay_input
                      }
endscript

script destroy_server_menu_children
	if ObjectExists id=server_list_menu
		SetScreenElementLock id=server_list_menu off 
		DestroyScreenElement id=server_list_menu recurse preserve_parent
		if GotParam refocus
			refocus_actions_menu
		endif
	endif
endscript

script destroy_server_desc_children
    SetScreenElementLock id=server_desc_menu off 
    DestroyScreenElement id=server_desc_menu recurse preserve_parent
	DestroyScreenElement id=server_player_menu recurse preserve_parent
    refocus_gamelist_menu
endscript

script destroy_lobby_user_list_children
//	SetScreenElementLock id=lobby_player_list_menu off 
	if ObjectExists id=lobby_player_list_menu
		prepare_lobby_user_list_for_new_children
		DestroyScreenElement id=lobby_player_list_menu recurse preserve_parent
	endif
endscript

script destroy_lobby_user
	if ObjectExists id=<user_id>
		DestroyScreenElement id=<user_id>
	endif
endscript

script destroy_lobby_server
	if ObjectExists id=<server_id>
		DestroyScreenElement id=<server_id>
	endif
endscript

script destroy_lobby_buddy_list_children
	if ObjectExists id=homie_vmenu
		prepare_lobby_buddy_list_for_new_children
		DestroyScreenElement id=homie_vmenu recurse preserve_parent
	endif
endscript

script add_no_servers_found_message
	if ObjectExists id=server_list_menu
		SetScreenElementLock id=server_list_menu off 
        if OnXbox
            main_menu_add_item text = "No Games Found" parent=server_list_menu id=menu_network_no_servers
        else
            main_menu_add_item text = "No Servers Found" parent=server_list_menu id=menu_network_no_servers
        endif
		if GotParam refocus
			refocus_actions_menu
		endif
	endif
endscript

script prepare_server_menu_for_new_children
	if ObjectExists id=server_list_menu
		SetScreenElementLock id=server_list_menu off 
	endif
endscript

script prepare_lobby_user_list_for_new_children
	if ObjectExists id=lobby_player_list_menu
		SetScreenElementLock id=lobby_player_list_menu off 
	endif
endscript

script prepare_lobby_buddy_list_for_new_children
	if ObjectExists id=homie_vmenu
		SetScreenElementLock id=homie_vmenu off 
	endif
endscript

script rejoin_lobby
    RejoinLobby
    create_joining_lobby_dialog
endscript

script choose_selected_lobby
    printf "---------------------- chose lobby ----------------------"
    ChooseLobby <...>
	DestroyScreenElement id=lobby_list_anchor
	DestroyScreenElement id=menu_parts_anchor
	create_joining_lobby_dialog
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_joining_lobby_dialog
	//launch_network_select_games_menu
endscript

script choose_selected_server
	console_hide
	;if InInternetMode
		;SetQuietMode
	;endif
    ChooseServer <...>
    ;exit_pause_menu
	DestroyScreenElement id=current_menu_anchor
endscript

script describe_selected_server
    DescribeServer <...>
endscript

script choose_selected_player
if OnXbox
	RemovePlayer <...>
else
	CreatePlayerOptions <...>
endif
	
endscript

script choose_selected_account
	ChooseAccount <...>
endscript

script cancel_remove_player
	CancelRemovePlayer
	dialog_box_exit
	create_pause_menu
endscript

script kick_player_confirm
    create_dialog_box { title=<name>
                        text="Kick player?"
                        buttons=[   { text="yes" pad_choose_script=kick_player } 
                                    { text="no" pad_choose_script=cancel_remove_player } 
                                ]
                      }
endscript

script kick_player
	KickPlayer
	dialog_box_exit
	create_pause_menu
endscript

script back_from_dialog
	dialog_box_exit
	create_pause_menu
endscript

script ban_player_confirm
    create_dialog_box { title=<name>
                        text="Ban player?"
                        buttons=[   { text="yes" pad_choose_script=ban_player } 
                                    { text="no" pad_choose_script=cancel_remove_player } 
                                ]
                      }
endscript
                                    
script ban_player
	BanPlayer
	dialog_box_exit
	create_pause_menu
endscript
									
script launch_pin_entry_menu
	DestroyScreenElement id=current_menu_anchor
	create_pin_entry_menu
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_pin_entry_menu
endscript

script launch_buddy_list
	DestroyScreenElement id=current_menu_anchor
	create_buddy_list_menu
	;RunScriptOnScreenElement id=main_menu_anchor menu_offscreen callback=create_buddy_list_menu
endscript

script launch_homie_list parent=root_window
	
	pulse_blur
	dialog_box_exit
	if ObjectExists id=console_message_vmenu
        DoScreenElementMorph id=console_message_vmenu time=0 scale=0
	endif 
	if InNetGame
		GoalManager_HidePoints
	endif
	if ( <parent> = root_window )
		if ObjectExists id=current_menu_anchor
			DestroyScreenElement id=current_menu_anchor
		endif
	endif
	
    SetScreenElementLock id=<parent> off
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
    
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=homie_bg_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	AssignAlias id=homie_bg_anchor alias=current_menu_anchor
	create_helper_text generic_helper_text
	
    FormatText ChecksumName=title_icon "%i_homie" i=(THEME_PREFIXES[current_theme_prefix])
    build_theme_sub_title title="HOMIE LIST" title_icon=<title_icon>
    
	if LevelIs load_skateshop
		build_top_and_bottom_blocks bot_z=15
		make_mainmenu_3d_plane
	else
		FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
		build_theme_box_icons icon_texture=<paused_icon>
		build_top_bar pos=(-400, 62)
		build_grunge_piece
	endif
	
    // anchor for menu
	CreateScreenElement {
		type=ContainerElement
		parent=homie_bg_anchor
		id=homie_menu_anchor
		
		dims=(640, 480)
		pos=(320, 840)
	}
	AssignAlias id=homie_menu_anchor alias=current_menu_anchor
	
	
	theme_background width=7 pos=(320,63) num_parts=10 static=static dark_menu=dark_menu
	
	
	
	// black box
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        texture=white2
		scale=(71.3,4)
		pos=(35,63)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	if LevelIs load_skateshop
		// mini map
		CreateScreenElement {
			type=spriteElement
			parent=homie_bg_anchor
			
			texture=homie
			scale=(1.8,1.3)
			pos=(380,67)
			just=[left bottom]
			alpha=0.5
			z_priority=5
		}
	
		// globe
		CreateScreenElement {
			type=spriteElement
			parent=homie_bg_anchor
			id=globe
			texture=globe
			scale=1.3
			pos=(320,560)
			just=[center center]
			alpha=0.3
			z_priority=-1
		}
	endif
	
    // Name
	CreateScreenElement {
		type=textElement
		parent=current_menu_anchor
        text="Name"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(90,83)
        just=[left center]
	}
	
	// up arrow
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        
		id=up_arrow
		texture=up_arrow
		scale=1
		pos=(260,83)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// down arrow
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        
		id=down_arrow
		texture=down_arrow
		scale=1
		pos=(260,345)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// black line
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        texture=white2
		scale=(0.8,32.3)
		pos=(275,95)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Status
	CreateScreenElement {
		type=textElement
		parent=current_menu_anchor
        text="Status"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(285,83)
        just=[left center]
	}
	
	// black line
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        texture=white2
		scale=(0.8,32.3)
		pos=(380,95)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Location
	CreateScreenElement {
		type=textElement
		parent=current_menu_anchor
        text="Location"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(390,83)
        just=[left center]
	}
	
	// Define pad_back event
	if InNetGame
		pad_back_script=back_to_pause_menu_from_buddy_list
	else
		;if ( in_net_lobby = 1 ) ;GotParam from_lobby
			pad_back_script=back_to_server_list_from_buddy_list
		;else
		;	pad_back_script=back_from_profile_options
		;endif
	endif
	
    /*make_new_menu { parent=homie_bg_anchor 
					type=VScrollingMenu 
					menu_id=buddy_list_menu 
					vmenu_id=lobby_buddy_list_menu 
					menu_title="" 
					event_handlers=<event_handlers>
					pos=(250,160)
					dims=(600, 284)
					padding_scale=.6
					pos=(90, 69)
					helper_text = generic_helper_text
					dont_allow_wrap=dont_allow_wrap
				}*/
				
	// scrolling vmenu
	CreateScreenElement {
		type=vscrollingmenu
		parent=current_menu_anchor
		id=homie_scrolling_menu
		
        just=[left top]
		dims=(600,240)
		pos=(100,103)
		;alpha=0
	}
	
	// vmenu
    CreateScreenElement {
		type=vmenu
		parent=homie_scrolling_menu
		id=homie_vmenu
		
		pos=(0,0)
		just=[left top]
		event_handlers=[ { pad_up 		generic_menu_up_or_down_sound params={ up } }
						 { pad_down		generic_menu_up_or_down_sound params={ down } }
						 { pad_back 	generic_menu_pad_back params={ callback=<pad_back_script>} }
					   ]
		dont_allow_wrap
	}
	
    // Fill Buddy List
	if HasBuddies					  
		if InGroupRoom
			FillBuddyList allow_remove allow_join
		else
			FillBuddyList allow_remove
		endif
		wait 2 gameframes
		SetScreenElementProps id=homie_scrolling_menu ;reset_window_bottom
	endif
	
    /*// Fill homie list for testing menu
	index=0
	begin
        FormatText textname=name "%ihomie%i" i=<index>
		homie_list_add_item { name=<name> status="online" location="no where" rank=4 }
		index=(<index> + 1)
	repeat 30
	wait 2 gameframes
	SetScreenElementProps id=homie_scrolling_menu reset_window_bottom*/
	
	AssignAlias id=homie_bg_anchor alias=current_menu_anchor
	
	// Rotate Globe
	if ScreenElementExists id=globe
		RunScriptOnScreenElement id=globe rotate_internet_options_globe
	endif
	
    if Not GotParam dont_animate_in
        RunScriptOnScreenElement id=homie_menu_anchor online_stats_animate_in params={ id=homie_menu_anchor }
		FireEvent type=focus target=homie_vmenu
	endif
	
	/*else
		if InNetGame
			create_dialog_box { 	title="No Homies"
									text="You currently have no homies."
									buttons=[ 	{ text="ok" pad_choose_script=back_from_dialog } 
											]
									}
		else
			if GotParam from_lobby
				create_dialog_box { 	title="No Homies"
									text="You currently have no homies."
									buttons=[ 	{ text="ok" pad_choose_script=back_to_server_list_from_buddy_list } 
											]
									}
			else
				create_dialog_box { 	title="No Homies"
									text="You currently have no homies."
									buttons=[ 	{ text="ok" pad_choose_script=back_from_profile_error } 
											]
									}
			endif
		endif
	endif*/
	
endscript

script homie_list_add_item name="" status="" location=""
    printf "homie_list_add_item"
	
    FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
    if ScreenElementExists id=homie_vmenu
		printf "homie_list_add_itemhomie_list_add_item"
	
		SetScreenElementLock id=homie_vmenu off
		
		// container for the element
		CreateScreenElement {
			type=ContainerElement
			parent=homie_vmenu
			id=<id>
					
			dims=(500, 15)
			pos=(0,0)
			event_handlers=[
				{ focus				online_stats_generic_focus }
				{ unfocus		 	online_stats_generic_unfocus }
				{ pad_choose		present_buddy_options params={ <pad_choose_params> } }
				{ pad_start 		present_buddy_options params={ <pad_choose_params> } }
				{ pad_choose		generic_menu_pad_choose_sound }
			]
		}
		anchor_id=<id>
		
        // highlight bar
		CreateScreenElement {
			type=spriteElement
			parent=<anchor_id>
			
			texture=DE_highlight_bar
			scale=(4.45,0.45)
			pos=(-65,0)
			just=[left center]
			rgba=<bar_rgba>
			alpha=0
			z_priority=2
		}
		
		// rank icon
		FormatText checksumname=rank_icon "rank_%i" i=<rank>
		CreateScreenElement {
			type=spriteElement
			parent=<anchor_id>
			
			texture=<rank_icon>
			scale=0.7
			pos=(-60,0)
			just=[left center]
		}
		
		// name
		CreateScreenElement {
			type=textElement
			parent=<anchor_id>
			
			text=<name>
			font=dialog
			scale=0.8
			pos=(-10,0)
			just=[left center]
			rgba=<off_rgba>
		}
		
		// status
		CreateScreenElement {
			type=textElement
			parent=<anchor_id>
			
			text=<status>
			font=dialog
			scale=0.8
			pos=(185,0)
			just=[left center]
			rgba=<off_rgba>
		}
		
		// location
		CreateScreenElement {
			type=textElement
			parent=<anchor_id>
			
			text=<location>
			font=dialog
			scale=0.8
			pos=(290,0)
			just=[left center]
			rgba=<off_rgba>
		}
		
        ;truncate_string id=<id> max_width=205
		
	endif
endscript

script back_to_pause_menu_from_buddy_list
	If ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	GoalManager_ShowPoints
	create_pause_menu
endscript

script show_nat_start_dialog
	PauseMusicAndStreams
    create_dialog_box { title=net_status_msg
                        text=net_status_locating
                        buttons=[ 
								{ text="cancel" pad_choose_script=cancel_join_server pad_choose_params={cancel_nn} } 
							]
                        }
endscript

script show_nat_timeout
    dialog_box_exit
	create_dialog_box { title=net_error_msg
                        text=net_status_nat_neg_failed
						buttons=[ { text="ok" pad_choose_script=cancel_join_server pad_choose_params={cancel_nn} }//back_to_server_list_from_buddy_list } 
						]
                      }
endscript


script present_buddy_options back_script=launch_homie_list remove_script=lobby_remove_buddy
	if GotParam in_lobby
		if ObjectExists id=current_menu_anchor
			DestroyScreenElement id=current_menu_anchor
		endif
        pad_back_params={ from_lobby }
	else
		DestroyScreenElement id=current_menu_anchor
    endif
	
	back_script=launch_homie_list
    nick=<name>
	
	if GotParam allow_join
		if GotParam allow_remove
			FormatText TextName=msg_text "%s : %t" s=<status> t=<location>
			create_dialog_box { title=<nick>
								text=<msg_text>
								buttons=[ 	{ text="back" pad_choose_script=<back_script> pad_choose_params=<pad_back_params> } 
											{ text="join" pad_choose_script=join_buddy pad_choose_params=<...> } 
											{ text="observe" pad_choose_script=observe_buddy pad_choose_params=<...> } 
											{ text="remove" pad_choose_script=<remove_script> pad_choose_params=<...> } 
										]
								}
		else
			FormatText TextName=msg_text "%s : %t" s=<status> t=<location>
			create_dialog_box { title=<nick>
								text=<msg_text>
								buttons=[ 	{ text="back" pad_choose_script=<back_script> pad_choose_params=<pad_back_params> } 
											{ text="join" pad_choose_script=join_buddy pad_choose_params=<...> } 
											{ text="observe" pad_choose_script=observe_buddy pad_choose_params=<...> } 
										]
								}
		endif
	else
		if GotParam allow_remove
			FormatText TextName=msg_text "%s : %t" s=<status> t=<location>
				create_dialog_box { title=<nick>
									text=<msg_text>
									buttons=[ 	{ text="back" pad_choose_script=<back_script> pad_choose_params=<pad_back_params> } 
												{ text="remove" pad_choose_script=<remove_script> pad_choose_params=<...> } 
											]
									}
		else
			FormatText TextName=msg_text "%s : %t" s=<status> t=<location>
			create_dialog_box { title=<nick>
								text=<msg_text>
								buttons=[ 	{ text="back" pad_choose_script=<back_script> pad_choose_params=<pad_back_params> } 
										]
								}
		endif
	endif
endscript

script join_buddy
	JoinBuddy <...>
endscript

script observe_buddy
	JoinBuddy <...> observe
endscript


script shell_remove_buddy
	RemoveBuddy <...>
	back_from_shell_buddy_options
endscript

script back_from_shell_buddy_options
	dialog_box_exit
	launch_homie_list
endscript

script net_chosen_join_server
    printf "******* In net_chosen_join_server *******"
    LeaveServer
    SetServerMode off
    if GotParam cookie
        if ObjectExists id=current_menu_anchor
    		DestroyScreenElement id=current_menu_anchor
    	endif
        show_nat_start_dialog
        if Not StartNatNegotiation <...>
            create_join_failed_dialog
        endif
    else
	    JoinServer <...>
    endif
	PlaySkaterCamAnim name=SS_MenuCam play_hold
	kill_start_key_binding
	;leave_front_end
	;exit_pause_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	change check_for_unplugged_controllers=0
endscript

script create_lobby_list_menu
    
	FormatText ChecksumName=rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	build_top_and_bottom_blocks
	make_mainmenu_3d_plane
	
	CreateScreenElement {
	   	type=ContainerElement
		parent=root_window
		id=lobby_list_anchor
		pos=(-5,800)
	}
	
    make_new_menu {	menu_id=lobby_list_menu 
				    parent=lobby_list_anchor
					type=vscrollingmenu 
					dims=(200,252) 
					pos=(80,132) 
					vmenu_id=lobby_list_vmenu 
					menu_title=""
					dont_allow_wrap=dont_allow_wrap
				  }
				  
	CreateScreenElement {
				type=TextElement
				parent=lobby_list_anchor
                
				font=testtitle
				text="REGIONS"
				scale=1.5
				pos=(92,86)
				just= [left top]
				rgba=[128 128 128 98]            
				not_focusable
			}
	CreateScreenElement {
				type=SpriteElement
				parent=lobby_list_anchor
                texture=regions
                scale=1
				pos=(39,82)
				just= [left top]
				rgba=<rgba>
				scale=(1.025,1)
				alpha=0.6
				not_focusable
			}
			
	CreateScreenElement {
				type=SpriteElement
				parent=lobby_list_anchor
				id=regions_up_arrow
                
				texture=up_arrow
                scale=1
				pos=(150,121)
				just= [left top]
				rgba=[128 128 128 98]            
				not_focusable
			}
			
	CreateScreenElement {
				type=SpriteElement
				parent=lobby_list_anchor
                id=regions_down_arrow
				
				texture=down_arrow
                scale=1
				pos=(150,336)
				just= [left top]
				rgba=[128 128 128 98]            
				not_focusable
			}
				  
	// theme background
	theme_background parent=lobby_list_anchor width=2.25 pos=(170,78) num_parts=10
				  
    SetScreenElementLock id=root_window off
	
    // Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=lobby_list_menu event_handlers=[ {pad_back generic_menu_pad_back params={ callback=back_from_regions_menu }} ] }
	SetScreenElementProps { id=lobby_list_vmenu event_handlers=[
                                            {pad_up     set_which_arrow params={ arrow=regions_up_arrow } }
											{pad_down   set_which_arrow params={ arrow=regions_down_arrow } }
                                         ]
                          } 
						  
	/*begin
	regions_menu_add_item text="parts unknown" focus_script=regions_menu_set_focus
	repeat 12*/
			  
	RunScriptOnScreenElement lobby_list_animate_in id=lobby_list_anchor
    FireEvent type=focus target=lobby_list_menu
endscript

script lobby_list_animate_in id=lobby_list_anchor
	DoScreenElementMorph id=<id> pos=(-5,0) time=0.3
endscript

script regions_menu_add_item
	FormatText checksumname=id "%i" i=<text>
    theme_menu_add_item { parent=lobby_list_vmenu centered <...> menu=2 no_bg=no_bg }
endscript

script regions_menu_set_focus
    generic_menu_update_arrows {
			up_arrow_id=regions_up_arrow
			down_arrow_id=regions_down_arrow
		}
	lobby_list_vmenu:GetTags
	if GotParam arrow_id
		menu_vert_blink_arrow { id=<arrow_id> } 
	endif
	main_theme_focus <...>
endscript

script create_pin_entry_menu
	make_new_menu menu_id=pin_entry_menu vmenu_id=pin_entry_vmenu menu_title="ENTER PIN"
    SetScreenElementLock id=root_window off 
    
    // Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=pin_entry_menu event_handlers=[
                                            {pad_back  generic_menu_pad_back params={ callback=do_nothing}}
                                         ]
                          } 
    
    RunScriptOnScreenElement id=main_menu_anchor menu_onscreen
endscript

script create_buddy_list_menu
	make_new_menu menu_title="Friend List"
    SetScreenElementLock id=root_window off 
    
    // Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=main_menu event_handlers=[
                                            {pad_back  generic_menu_pad_back params={ callback=launch_xbox_online_menu}}
                                         ]
                          } 
    
    RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
endscript

script back_from_regions_menu
	StopServerList
    FreeServerList
	LobbyDisconnect
    CancelNatNegotiation
	
    FireEvent type=unfocus target=lobby_list_menu
    FireEvent type=focus target=sub_menu
	AssignAlias id=menu_parts_anchor alias=current_menu_anchor
	
	DoScreenElementMorph id=lobby_list_anchor pos=(-5,800) time=0.3
	wait 0.3 seconds
    DestroyScreenElement id=lobby_list_anchor
endscript

script back_from_network_menu
    StopServerList
    FreeServerList
	DestroyScreenElement id=current_menu_anchor
	
    create_ss_menu no_animate
endscript

script back_from_multiplayer_menu
    StopServerList
    FreeServerList
    back_from_network_select_menu <...>
endscript

script select_host_option
    set_preferences_from_ui <...>
    select_host_option2
endscript
script select_host_option2
    launch_network_host_options_menu
endscript

script select_game_option
	if( <checksum> = netctf )
		if Not InTeamGame
			set_preferences_from_ui prefs=network field="team_mode" checksum=teams_two string="2"
			SetNumTeams 2
		endif
	endif
	set_preferences_from_ui <...>
	
	// These two options both set up the "target_score" variable, but use different sets of legal values. So, we need to initialize
	// the option with a setting that makes sense for each when you switch to either game mode
	switch <checksum>
		case netscorechallenge
		case scorechallenge
			set_preferences_from_ui prefs=<prefs> field="target_score" checksum=score_1000000 score=1000000 string="1,000,000 points"
		case netking
		case king
			set_preferences_from_ui prefs=<prefs> field="target_score" checksum=time_120 time=120 string="2 minutes"
		case netctf
			set_preferences_from_ui prefs=<prefs> field="target_score" checksum=score_5 score=5 string="5 captures"
	endswitch
	
	create_network_game_options_menu <...>
endscript

script select_team_mode_option
    printf "in select_team_mode_option"
	set_preferences_from_ui <...>
	if GameModeEquals is_lobby
        printf "in select_team_mode_option 2"
		GetPreferenceChecksum pref_type=network team_mode
		switch <checksum>
			case teams_none
                printf "SetNumTeams 0"
				SetNumTeams 0
			case teams_two
                printf "SetNumTeams 2"
				SetNumTeams 2
			case teams_three
                printf "SetNumTeams 3"
				SetNumTeams 3
			case teams_four
                printf "SetNumTeams 4"
				SetNumTeams 4
			default
		endswitch
	endif
    launch_network_host_options_menu
endscript

script create_host_options_goals_sub_menu pad_choose=select_host_option
    dialog_box_exit
	
	FormatText ChecksumName=title_icon "%i_online" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="GOALS" title_icon=<title_icon>
	
	if LevelIs load_skateshop
		// globe
		CreateScreenElement {
			type=spriteElement
			parent=menu_parts_anchor
			id=globe
			texture=globe
			scale=1
			pos=(550,240)
			just=[center center]
			alpha=0.2
			z_priority=-1
		}
		RunScriptOnScreenElement id=globe rotate_internet_options_globe
	endif
	
    // Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=sub_menu 
							event_handlers=[ { pad_back generic_menu_pad_back params={ callback=launch_network_host_options_menu} } ]
                          } 
    
    theme_menu_add_item {
		text="STORY MODE GOALS"
		pad_choose_script = <pad_choose>
		pad_choose_params={ prefs=network field="goals" string="STORY MODE" checksum=goals_story}
		centered=centered
	}
	
	// check for loaded goals for this level
	GetPreferenceChecksum pref_type=network level
	GoalEditor:GetNumEditedGoals level=<checksum>
    if (<NumGoals>=0)
		<not_focusable>=not_focusable
	endif
	
	theme_menu_add_item {
		text="USER CREATED GOALS"
		pad_choose_script = <pad_choose>
		pad_choose_params={ prefs=network field="goals" string="CREATED" checksum=goals_created}
		centered=centered
		<not_focusable>
	}

	theme_menu_add_item {
		text="LOAD CREATED GOALS"
		pad_choose_script=host_options_goals_sub_menu_exit
		pad_choose_params={ new_menu_script=launch_load_created_goals_from_host_goals_menu }
		centered=centered
		last_menu_item=last_menu_item
	}	
				
    finish_themed_sub_menu
endscript

script game_options_goals_sub_menu_return

	set_preferences_from_ui prefs=network field="goals" string="CREATED" checksum=goals_created
	
	if not LevelIs load_skateshop
		dialog_box_exit
		kill_start_key_binding
		create_dialog_box { title=net_warning_msg
						text=net_message_goals_next_level
						buttons=[ 
									{ text="ok" pad_choose_script=create_network_game_options_menu }  
								]
					  }
	else
		create_network_game_options_menu
	endif
	
endscript

script host_options_goals_sub_menu_return
	set_preferences_from_ui prefs=network field="goals" string="CREATED" checksum=goals_created
	
	if not LevelIs load_skateshop
		dialog_box_exit
		kill_start_key_binding
		create_dialog_box { title=net_warning_msg
						text=net_message_goals_next_level
						buttons=[ 
									{ text="ok" pad_choose_script=launch_network_host_options_menu }  
								]
					  }
	else
		launch_network_host_options_menu
	endif
	
	;launch_network_host_options_menu
endscript

script host_options_goals_sub_menu_exit
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	<new_menu_script> <...>
endscript

script create_host_options_sub_menu pad_choose=select_host_option
    
	FormatText ChecksumName=title_icon "%i_online" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title=<menu_title> title_icon=<title_icon>
	
	if LevelIs load_skateshop
		// globe
		CreateScreenElement {
			type=spriteElement
			parent=menu_parts_anchor
			id=globe
			texture=globe
			scale=1
			pos=(550,240)
			just=[center center]
			alpha=0.2
			z_priority=-1
		}
		RunScriptOnScreenElement id=globe rotate_internet_options_globe
	endif
	
    // Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=sub_menu 
							event_handlers=[ { pad_back generic_menu_pad_back params={ callback=launch_network_host_options_menu} } ]
                          } 
    
    RemoveParameter id
	
	if GotParam array
		GetArraySize <array>
		
		if GotParam max_index
			<array_size> = (<max_index>+1)
		endif
		
		<index> = 0
		begin
            name=((<array>[<index>]).name)
			if StructureContains structure=(<array>[<index>]) checksum
				checksum=((<array>[<index>]).checksum)
			endif
			if StructureContains structure=(<array>[<index>]) time
				time=((<array>[<index>]).time)
			endif
			
			if StructureContains structure=(<array>[<index>]) broadband_only
				orig_checksum = <checksum>
				GetPreferenceChecksum pref_type=network device_type
				switch <checksum>
					case device_sony_modem
					case device_usb_modem
						break
				endswitch										  
				checksum = <orig_checksum>
			endif
			
			pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> }
			
			//left justify skill level info
			if (<pref_field>="skill_level")
				<just>=[left center]
				RemoveParameter centered
				text_pos=(20,-5)
			else
				<just>=[center center]
			endif
			
			if ( <index> = 0 )
				theme_menu_add_item {
					<...>
					text=<name>
					pad_choose_script=<pad_choose>
                    pad_choose_params=<pad_choose_params>
					;centered = <centered>
					text_just=<just>
				}
			else
				if ( <index> = ( <array_size> - 1 ) )
					theme_menu_add_item {
						last_menu_item=last_menu_item
						<...>
						text=<name>
						pad_choose_script=<pad_choose>
						pad_choose_params=<pad_choose_params>
						;centered = <centered>
						text_just=<just>
					}
				else
					theme_menu_add_item {
						<...>
						text=<name>
						pad_choose_script=<pad_choose>
						pad_choose_params=<pad_choose_params>
						;centered = <centered>
						text_just=<just>
					}
				endif
			endif
			<index> = ( <index> + 1 )
		repeat <array_size>
	endif
			
    finish_themed_sub_menu
endscript

script create_game_options_sub_menu
	
	if InSplitScreenGame
		prefs=splitscreen
	else
		prefs=network
	endif

	FormatText ChecksumName=title_icon "%i_2_player" i=(THEME_PREFIXES[current_theme_prefix])

	;make_new_themed_sub_menu title=<menu_title> title_icon=<title_icon>
	PrintStruct <...>
	if ( <pref_field>="game_type" )
		make_new_menu menu_id=options_sub_menu vmenu_id=options_sub_vmenu pos=(230,620)
		// Define pad_back event - go back to the pause menu
		SetScreenElementProps { id=options_sub_menu event_handlers=[
												{pad_back   generic_menu_pad_back params={ callback= create_network_game_options_menu <...>} }
											 ]
							  } 
		
		generic_array_menu_desc_setup <...>
		
		//game_type_description_box
	else
		
		make_new_menu menu_id=options_sub_menu vmenu_id=options_sub_vmenu pos=(230,620)
		
		// Define pad_back event - go back to the pause menu
		SetScreenElementProps { id=options_sub_menu event_handlers=[
												{pad_back  generic_menu_pad_back params={ callback=create_network_game_options_menu <...>} }
											 ]
							  } 
							  
		generic_array_menu_setup <...> 
		
	endif
	
	build_theme_sub_title title=<menu_title> title_icon=<title_icon> right_bracket_z=-1 right_bracket_alpha=0.0
	
	FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
	build_theme_box_icons icon_texture=<paused_icon>

	build_grunge_piece
	
	build_top_bar pos=(-400, 62)
	
	create_helper_text generic_helper_text
	
	GoalManager_HideGoalPoints
	GoalManager_HidePoints
	
    //RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
	//RunScriptOnScreenElement id=current_menu_anchor animate_in
	 //Animate the parts in
	//PlaySound DE_MenuFlyUp vol=100
	//PlaySound DE_PauseFlyIn vol=100
	
    DoScreenElementMorph id=options_sub_vmenu time=0.2 pos=(230,85)
	
	if ( <pref_field>="game_type" )
		DoScreenElementMorph id=bg_box_vmenu time=0.2 pos=(320,85)
		DoScreenElementMorph id=item_bg_box time=0.2 pos=(320,304)
		DoScreenElementMorph id=item_description_text time=0.2 pos=(320,294)
		DoScreenElementMorph id=item_description_bar time=0.2 pos=(320,299)
	endif
	
	if ScreenElementExists id=top_bar_anchor
		DoScreenElementMorph id=top_bar_anchor time=0.2 pos=(0,62)
	endif
    
	FireEvent type=focus target=options_sub_menu
endscript

script set_host_option_preference
	GetTextElementString id=keyboard_current_string
    set_preferences_from_ui prefs=network <...>
	destroy_onscreen_keyboard
	create_network_host_options_menu
endscript

script host_options_back_from_keyboard
	destroy_onscreen_keyboard
	create_network_host_options_menu
endscript

script set_horse_option_preference
	GetTextElementString id=keyboard_current_string
    set_preferences_from_ui prefs=splitscreen <...>
	horse_word_back_from_keyboard
endscript

script horse_word_back_from_keyboard
	destroy_onscreen_keyboard
	create_network_game_options_menu end_run
endscript

script create_network_host_options_server_name_menu
	GetPreferenceString pref_type=network server_name
	DestroyScreenElement id=current_menu_anchor
	create_onscreen_keyboard allow_cancel keyboard_cancel_script=host_options_back_from_keyboard keyboard_done_script=set_host_option_preference keyboard_title="NAME"  field="server_name" text=<ui_string> min_length=1 max_length=15  
	;RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_onscreen_keyboard callback_params={allow_cancel keyboard_cancel_script=host_options_back_from_keyboard keyboard_done_script=set_host_option_preference keyboard_title="SERVER NAME" field="server_name" text=<ui_string> min_length=1 max_length=15}
endscript

script create_network_host_options_password_menu
	GetPreferenceString pref_type=network password
	DestroyScreenElement id=current_menu_anchor
	create_onscreen_keyboard password allow_cancel keyboard_cancel_script=host_options_back_from_keyboard keyboard_done_script=set_host_option_preference keyboard_title="PASSWORD"  field="password" text=<ui_string> min_length=0 max_length=9
endscript

script create_network_host_options_levels_menu
	if IsTrue bootstrap_build
		create_host_options_sub_menu menu_title="LEVEL" pref_type=network pref_field="level" array=e3_level_info call_script=select_host_option pos=(227, 112)
	else
		create_host_options_sub_menu menu_title="LEVEL" pref_type=network pref_field="level" array=level_info call_script=select_host_option pos=(227, 112) helper_text=generic_helper_text      
	endif
endscript

script create_network_host_options_goals_menu
    create_host_options_sub_menu menu_title="GOALS" pref_type=network pref_field="goals" array=net_goal_info pad_choose_script=select_host_option pos=(227, 112) helper_text=generic_helper_text <...> centered
endscript

script create_network_host_options_max_players_menu
    create_host_options_sub_menu menu_title="PLAYERS" pref_type=network pref_field="num_players" array=num_players_info pad_choose_script=select_host_option pos=(227, 112) helper_text=generic_helper_text <...> centered
endscript

script create_network_host_options_max_observers_menu
    create_host_options_sub_menu menu_title="OBSERVERS" pref_type=network pref_field="num_observers" array=num_observers_info pad_choose_script=select_host_option pos=(227, 112) helper_text=generic_helper_text centered
endscript

script create_network_host_options_player_collision_menu
    create_host_options_sub_menu menu_title="PLAYER COLLISION" pref_type=network pref_field="player_collision" array=on_off_types pad_choose_script=select_host_option helper_text=generic_helper_text centered
endscript

script create_network_host_options_team_menu
    printf "in create_network_host_options_team_menu"
    create_host_options_sub_menu menu_title="TEAMS" pref_type=network pref_field="team_mode" array=team_types pad_choose=select_team_mode_option pos=(227, 112) helper_text=generic_helper_text centered
endscript

script create_network_host_options_skill_level_menu
    create_host_options_sub_menu menu_title="SKILL LEVEL" pref_type=network pref_field="skill_level" array=skill_level_info pad_choose_script=select_host_option pos=(227, 112) helper_text=generic_helper_text centered
endscript

script create_mp_game_options_game_type_menu
	create_game_options_sub_menu menu_title="GAME TYPE" pref_type=splitscreen pref_field="game_type" array=mp_game_type_info call_script=select_game_option helper_text=generic_helper_text <...>
endscript

script create_network_game_options_game_type_menu
	if isTrue DEMO_BUILD    
		create_game_options_sub_menu menu_title="GAME TYPE" pref_type=network pref_field="game_type" array=net_game_type_info_DEMO call_script=select_game_option helper_text=generic_helper_text <...>
	else
		create_game_options_sub_menu menu_title="GAME TYPE" pref_type=network pref_field="game_type" array=net_game_type_info call_script=select_game_option helper_text=generic_helper_text <...>
    endif
endscript

script create_network_game_options_ctf_mode_menu
	create_game_options_sub_menu menu_title="MODE" pref_type=<prefs> pref_field="ctf_game_type" array=ctf_type call_script=select_game_option helper_text=generic_helper_text <...>
endscript 

script create_network_game_options_score_menu
	create_game_options_sub_menu menu_title="TARGET SCORE" pref_type=<prefs> pref_field="target_score" array=target_score_options call_script=select_game_option helper_text=generic_helper_text <...>
endscript 

script create_network_game_options_captures_menu
	create_game_options_sub_menu menu_title="CAPTURES" pref_type=<prefs> pref_field="target_score" array=capture_options call_script=select_game_option helper_text=generic_helper_text <...>
endscript 

script create_network_game_options_target_time_menu
	create_game_options_sub_menu menu_title="TIME LIMIT" pref_type=<prefs> pref_field="target_score" array=time_limit_options call_script=select_game_option helper_text=generic_helper_text <...>
endscript 

script create_network_game_options_time_menu
	create_game_options_sub_menu menu_title="TIME LIMIT" pref_type=network pref_field="time_limit" array=time_limit_options call_script=select_game_option helper_text=generic_helper_text <...>
endscript 

script create_network_game_options_friendly_fire_menu
    create_game_options_sub_menu menu_title="FRIENDLY FIRE" pref_type=network pref_field="friendly_fire" array=on_off_types call_script=select_game_option helper_text=generic_helper_text <...>
endscript 

script create_network_game_options_fireball_difficulty_menu
    create_game_options_sub_menu menu_title="FIREBALL DIFFICULTY" pref_type=network pref_field="fireball_difficulty" array=fireball_level_info call_script=select_game_option helper_text=generic_helper_text <...>
endscript 

script create_mp_game_options_stop_at_zero_menu
    create_game_options_sub_menu menu_title="STOP AT ZERO" pref_type=network pref_field="stop_at_zero" array=boolean_types call_script=select_game_option helper_text=generic_helper_text <...>
endscript 

script create_mp_game_options_time_menu
	create_game_options_sub_menu menu_title="TIME LIMIT" pref_type=splitscreen pref_field="time_limit" array=time_limit_options call_script=select_game_option helper_text=generic_helper_text <...>
endscript

script create_mp_game_options_horse_time_menu
	create_game_options_sub_menu menu_title="TIME LIMIT" pref_type=splitscreen pref_field="horse_time_limit" array=horse_time_limit_options call_script=select_game_option helper_text=generic_helper_text prefs=splitscreen <...>
endscript

horse_allowed_characters=[ 	"1" "2" "3" "4" "5" "6" "7" "8" "9" "0"
							"a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
							"k" "l" "m" "n" "o" "p" "q" "r" "s" "t"
							"u" "v" "w" "x" "y" "z"
							"A" "B" "C" "D" "E" "F" "G" "H" "I" "J"
							"K" "L" "M" "N" "O" "P" "Q" "R" "S" "T"
							"U" "V" "W" "X" "Y" "Z"
						  "." "," "!" "?" "-" "¦" "'" "+" "^" 
						  "#" "$" "*" "@" "`" "&" ":" "<" ">" 
						  "_" "-" "=" "(" ")" "/" 
						  "ß" "Ä" "Ü" "Ö" "à" "â" "ê" "è" "é" "ë" 
						  "ì" "î" "ï" "ô" "ò" "Ö" "ù" "û" "Ü" "ç" 
						  "œ" "ü" "ä" "ö" "¼" "½" "¾" "¢" "º" "®" 
						  "¡" "¿" "£" "¥" "§" "©" ]
						  
script create_mp_game_options_horse_word_menu
	GetPreferenceString pref_type=splitscreen horse_word
	create_onscreen_keyboard allowed_characters=horse_allowed_characters allow_cancel keyboard_cancel_script=horse_word_back_from_keyboard keyboard_done_script=set_horse_option_preference keyboard_title="HORSE WORD"  field="horse_word" text=<ui_string> min_length=1 max_length=15 ;pos=(320, 290)  
endscript 

script create_account_list_menu
    make_new_menu menu_id=account_list_menu vmenu_id=account_list_vmenu menu_title="CHOOSE AN ACCOUNT"
	SetScreenElementLock id=root_window off 
    // Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=account_list_menu event_handlers=[
                                            {pad_back  generic_menu_pad_back params={ callback=back_from_account_list_menu}}
                                         ]
                          } 
	RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
endscript

script create_network_game_options_menu
	dialog_box_exit
	pause_menu_gradient on
	hide_current_goal
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	if InSplitScreenGame
		prefs=splitscreen
	else
		prefs=network
	endif
	
	;GoalManager_ShowPoints
	hide_net_player_names on
	
	
	FormatText ChecksumName=title_icon "%i_2_player" i=(THEME_PREFIXES[current_theme_prefix])
   
	
    make_new_themed_sub_menu title="GAME OPTIONS" title_icon=<title_icon> right_bracket_alpha=0.0
	
	;make_new_menu menu_id=host_options_menu vmenu_id=host_options_vmenu menu_title="GAME OPTIONS" helper_text=generic_helper_text
	// Define pad_back event - go back to the pause menu
	
	if GotParam end_run
		SetScreenElementProps { id=sub_menu event_handlers=[
									{pad_back  generic_menu_pad_back params={ callback=create_end_run_menu}}
											]
							  } 
	else
		SetScreenElementProps { id=sub_menu event_handlers=[
									{pad_back  generic_menu_pad_back params={ callback=create_pause_menu}}
											]
							  } 							  
	endif
	
    // K: Commented this test out so that goal attack games can be done in parks, now that
    // parks can have created goals.
    /*
	if InNetGame
		if CustomParkMode just_using
			GetPreferenceChecksum pref_type=network game_type
			if( <checksum> = netgoalattack )
				set_preferences_from_ui prefs=network field="game_type" checksum=nettrickattack string="Trick Attack"
			endif
		endif
	endif
    */
	
    GetPreferenceString pref_type=<prefs> game_type
	if InNetGame
		theme_menu_add_item text = "Game Type:" extra_text=<ui_string> id=menu_network_host_options_game_type pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_network_game_options_game_type_menu}
	else
		if GotParam end_run
			theme_menu_add_item text = "Game Type:" extra_text=<ui_string> id=menu_network_host_options_game_type pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={end_run sub_menu_script=create_mp_game_options_game_type_menu}
		else
			theme_menu_add_item text = "Game Type:" extra_text=<ui_string>  id=menu_network_host_options_game_type pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_mp_game_options_game_type_menu}
		endif
	endif
	
	GetPreferenceChecksum pref_type=<prefs> game_type		
	switch <checksum>
		case netgoalattack
			theme_menu_add_item text="Choose Goals" centered=centered id=menu_network_host_options_choose_goals pad_choose_script=create_choose_goals_menu
			
			// Rulon (TT12477): Can't load created goals if you are a FCFS host
			if onServer
				theme_menu_add_item text="Load Created Goals" centered=centered pad_choose_script=host_options_goals_sub_menu_exit pad_choose_params={new_menu_script=launch_load_created_goals_from_game_options_menu from_game_options=from_game_options}
			endif
			
			if GoalManager_GoalsAreSelected
				theme_menu_add_item text = "Ready"  id=menu_network_host_options_ready pad_choose_script=chosen_host_game last_menu_item=1
			else
				theme_menu_add_item text = "Ready" id=menu_network_host_options_ready pad_choose_script=chosen_host_game not_focusable rgba=[80 80 80 128] last_menu_item=1
			endif
		case freeskate2p
			theme_menu_add_item text = "Ready"  id=menu_network_host_options_ready pad_choose_script=chosen_host_game last_menu_item=1
		case horse
		case nethorse
			GetPreferenceString pref_type=<prefs> horse_time_limit
			theme_menu_add_item text = "Time Limit:"  extra_text=<ui_string>  id=menu_network_host_options_time_limit pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={end_run sub_menu_script=create_mp_game_options_horse_time_menu}
			
			GetPreferenceString pref_type=<prefs> horse_word
			theme_menu_add_item text = "Horse Word:"   extra_text=<ui_string> id=menu_network_host_options_horse_word pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={end_run sub_menu_script=create_mp_game_options_horse_word_menu}
			
			
			
			theme_menu_add_item text = "Ready"  id=menu_network_host_options_ready pad_choose_script=chosen_host_game last_menu_item=1
		case scorechallenge
		case netscorechallenge	 
			GetPreferenceString pref_type=<prefs> target_score	
			if GotParam end_run
				theme_menu_add_item text = "Target Score:"   extra_text=<ui_string>  id=menu_network_host_options_target_score pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={end_run sub_menu_script=create_network_game_options_score_menu prefs=<prefs> }
			else
				theme_menu_add_item text = "Target Score:"  extra_text=<ui_string>  id=menu_network_host_options_target_score pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_network_game_options_score_menu prefs=<prefs> }
			endif

			theme_menu_add_item text = "Ready" id=menu_network_host_options_ready pad_choose_script=chosen_host_game last_menu_item=1
		case netctf
			GetPreferenceString pref_type=<prefs> ctf_game_type
            theme_menu_add_item text = "Mode:"   extra_text=<ui_string> id=menu_network_host_options_ctf_mode pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_network_game_options_ctf_mode_menu prefs=<prefs> }
            
            
            GetPreferenceChecksum pref_type=<prefs> ctf_game_type		
	        switch <checksum>
                case timed_ctf
					GetPreferenceString pref_type=<prefs> time_limit
                    
                    theme_menu_add_item text = "Time Limit:"   extra_text=<ui_string> id=menu_network_host_options_time_limit pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_network_game_options_time_menu}
                    
                case score_ctf
					GetPreferenceString pref_type=<prefs> target_score
                    
			        theme_menu_add_item text = "Captures:"  extra_text=<ui_string>  id=menu_network_host_options_target_score pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_network_game_options_captures_menu prefs=<prefs> }
                    
            endswitch            
			
		   
			
            GetPreferenceChecksum pref_type=<prefs> ctf_game_type		
	        switch <checksum>
                case timed_ctf
					GetPreferenceString pref_type=<prefs> stop_at_zero
                    theme_menu_add_item text = "Stop at Zero:"  extra_text=<ui_string>  id=menu_network_host_options_stop_at_zero pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_mp_game_options_stop_at_zero_menu}
                   
                    
            endswitch
                    
			theme_menu_add_item text = "Ready" id=menu_network_host_options_ready pad_choose_script=chosen_host_game last_menu_item=1
		case king
		case netking
			GetPreferenceString pref_type=<prefs> target_score
			if GotParam end_run
				theme_menu_add_item text = "Time Limit:"   extra_text=<ui_string> id=menu_network_host_options_target_score pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={end_run sub_menu_script=create_network_game_options_target_time_menu prefs=<prefs> }
			else
				theme_menu_add_item text = "Time Limit:"   extra_text=<ui_string> id=menu_network_host_options_target_score pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_network_game_options_target_time_menu prefs=<prefs> }
			endif
			
			theme_menu_add_item text = "Ready"   id=menu_network_host_options_ready pad_choose_script=chosen_host_game last_menu_item=1
        case firefight
        case netfirefight
            if InNetGame
			    GetPreferenceString pref_type=<prefs> friendly_fire
                theme_menu_add_item text = "Friendly Fire:"   extra_text=<ui_string> id=menu_network_host_options_friendly_fire pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_network_game_options_friendly_fire_menu prefs=<prefs> }
                
                GetPreferenceString pref_type=<prefs> fireball_difficulty
                theme_menu_add_item text = "Fireball Combo Level:"   extra_text=<ui_string> id=menu_network_host_options_fireball_difficulty pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_network_game_options_fireball_difficulty_menu prefs=<prefs> }
            endif
            theme_menu_add_item text = "Ready" id=menu_network_host_options_ready pad_choose_script=chosen_host_game last_menu_item=1
		default
			GetPreferenceString pref_type=<prefs> time_limit
			if InNetGame
				theme_menu_add_item text = "Time Limit:"   extra_text=<ui_string> id=menu_network_host_options_time_limit pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_network_game_options_time_menu}
			else
				if GotParam end_run
					theme_menu_add_item text = "Time Limit:"   extra_text=<ui_string> id=menu_network_host_options_time_limit pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={end_run sub_menu_script=create_mp_game_options_time_menu}
				else
					theme_menu_add_item text = "Time Limit:"   extra_text=<ui_string> id=menu_network_host_options_time_limit pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_mp_game_options_time_menu}
				endif
				
			endif
			
			
			
            if InNetGame
			GetPreferenceString pref_type=<prefs> stop_at_zero
                theme_menu_add_item text = "Stop at Zero:"   extra_text=<ui_string> id=menu_network_host_options_stop_at_zero pad_choose_script=launch_network_host_options_sub_menu pad_choose_params={sub_menu_script=create_mp_game_options_stop_at_zero_menu}
                
                
            endif
            
			theme_menu_add_item text = "Ready" id=menu_network_host_options_ready pad_choose_script=chosen_host_game last_menu_item=1
	endswitch
	
	GoalManager_HideGoalPoints
	GoalManager_HidePoints
    ;FireEvent type=focus target=current_menu
	finish_themed_sub_menu
endscript

script set_game_options_ready_focus
	menu_onscreen <...>
	FireEvent type=unfocus target=host_options_vmenu
	FireEvent type=focus target=host_options_vmenu data={child_id=menu_network_host_options_ready}
endscript

script create_network_host_options_menu
	change in_server_options=1
	
	dialog_box_exit
	if OnXbox
		title_text="HOST OPTIONS"
	else
		title_text="SERVER OPTIONS"
	endif
    
	if LevelIs load_skateshop
		Skater:remove_skater_from_world
		KillSkaterCamAnim all
		PlaySkaterCamAnim skater=0 name=mainmenu_camera03 play_hold
	else
		pause_menu_gradient on
	endif
	
	FormatText ChecksumName=title_icon "%i_online" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title=<title_text> title_icon=<title_icon> menu_id=host_options_menu vmenu_id=host_options_vmenu
    
	if LevelIs load_skateshop
		// globe
		CreateScreenElement {
			type=spriteElement
			parent=menu_parts_anchor
			id=globe
			texture=globe
			scale=1
			pos=(550,240)
			just=[center center]
			alpha=0.2
			z_priority=-1
		}
	endif
	
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps {
		id=host_options_vmenu
		event_handlers=[ { pad_back  generic_menu_pad_back params={ callback=back_from_internet_host_options }} ]
	}
	
    if InNetGame
		if OnServer
			actual_server = 1
		else
			actual_server = 0
		endif
	else
		actual_server = 1
	endif
	
    if( <actual_server> = 1 )
		GetPreferenceString pref_type=network server_name
		theme_menu_add_item {
			parent=host_options_vmenu
			text="Name:"
			extra_text=<ui_string>
			id=menu_network_host_options_server_name
			pad_choose_script=create_network_host_options_server_name_menu
			first_item
		} 
	endif
	; network_host_options_menu_add_item text = <ui_string> id=menu_network_host_options_server_name_string rgba=[80 80 80 128] scale=0.8 not_focusable
				  
	if Not InNetGame			  
		GetPreferenceString pref_type=network level
		theme_menu_add_item {
			parent=host_options_vmenu
			text="Level:"
			extra_text=<ui_string>
			id=menu_network_host_options_level
			;pad_choose_script=launch_network_host_options_sub_menu
			;pad_choose_params={ sub_menu_script=create_network_host_options_levels_menu }
			pad_choose_script=launch_level_select_menu	
			pad_choose_params={ from_server_options }
		}
		; network_host_options_menu_add_item text = <ui_string> id=menu_network_host_options_level_string rgba=[80 80 80 128] scale=0.8 not_focusable
	endif
	
	if isPS2
		if InNetGame
			if( <actual_server> = 1 )
				if GameModeEquals is_lobby
					if Not NetworkGamePending
						if Not ChangeLevelPending
							GetPreferenceString pref_type=network level  			
							// Created parks can only have created goals
							// check for loaded goals for this level
							GetPreferenceChecksum pref_type=network level
							if(<checksum> = load_sk5ed_gameplay)
								set_preferences_from_ui prefs=network field="goals" string=(((net_goal_info)[1]).name) checksum=(((net_goal_info)[1]).checksum)
								<not_focusable> = not_focusable
							else
								GoalEditor:GetNumEditedGoals level=<checksum>
								if (<NumGoals>=0)
									set_preferences_from_ui prefs=network field="goals" string=(((net_goal_info)[0]).name) checksum=(((net_goal_info)[0]).checksum)
								endif
							endif
							
							GetPreferenceString pref_type=network goals
							/*theme_menu_add_item {
								parent=host_options_vmenu
								text="Goals:"
								extra_text=<ui_string>
								<not_focusable>
								id=menu_network_host_options_goals
								pad_choose_script=create_host_options_goals_sub_menu
							}*/ 
							if not GoalManager_HasActiveGoals
								theme_menu_add_item {
									text="LOAD GOALS"
									pad_choose_script=host_options_goals_sub_menu_exit
									pad_choose_params={ new_menu_script=launch_load_created_goals_from_host_goals_menu }
									centered=centered
								}
							endif
						endif
					endif
				endif
			endif
		else
			if( <actual_server> = 1 )
				
				GetPreferenceString pref_type=network level
								
				// Created parks can only have created goals
				// check for loaded goals for this level
				GetPreferenceChecksum pref_type=network level
				if(<checksum> = load_sk5ed_gameplay)
					set_preferences_from_ui prefs=network field="goals" string=(((net_goal_info)[1]).name) checksum=(((net_goal_info)[1]).checksum)
					<not_focusable> = not_focusable
				else
					GoalEditor:GetNumEditedGoals level=<checksum>
					if (<NumGoals>=0)
						set_preferences_from_ui prefs=network field="goals" string=(((net_goal_info)[0]).name) checksum=(((net_goal_info)[0]).checksum)
					endif
				endif
				
				GetPreferenceString pref_type=network goals
				
				if not GoalManager_HasActiveGoals
					theme_menu_add_item {
						text="LOAD GOALS"
						pad_choose_script=host_options_goals_sub_menu_exit
						pad_choose_params={ new_menu_script=launch_load_created_goals_from_host_goals_menu }
						centered=centered
					}
				endif
			endif
		endif
	endif
	
	if OnServer
        if Not InNetGame
		
			<max_index> = 6
			//enforce max players if level is a custom park
			GetPreferenceString pref_type=network level
			if(<ui_string> = "Created Park")
				GetParkEditorMaxPlayers
				GetParkEditorMaxPlayers
				GetParkEditorMaxPlayers
				GetPreferenceChecksum pref_type=network num_players
				
				switch <checksum>
				case num_2
					<cur_max>=2
				case num_3
					<cur_max>=3
				case num_4
					<cur_max>=4
				case num_5
					<cur_max>=5
				case num_6
					<cur_max>=6
				case num_7
					<cur_max>=7
				case num_8
					<cur_max>=8
				endswitch
				
				<max_index> = (<MaxPlayers>-2)
		 
				if(<MaxPlayers> < 2)
					ScriptAssert "Too low max players for net game with created park"
				endif
				
				if((((num_players_info)[<max_index>]).num) < <cur_max>)
					set_preferences_from_ui prefs=network field="num_players" string=(((num_players_info)[<max_index>]).name) checksum=(((num_players_info)[<max_index>]).checksum)
                    		endif
			endif
		
			if (<max_index> = 0)
				GetPreferenceString pref_type=network num_players
				theme_menu_add_item {
					parent=host_options_vmenu
					text="Players:"
					extra_text=<ui_string>
					not_focusable = not_focusable
					id=menu_network_host_options_max_players
				}
			else
				GetPreferenceString pref_type=network num_players
				theme_menu_add_item {
					parent=host_options_vmenu
					text="Players:"
					extra_text=<ui_string>
					id=menu_network_host_options_max_players
					pad_choose_script=create_network_host_options_max_players_menu 
					pad_choose_params={max_index=<max_index>}
				}
			endif
    		; network_host_options_menu_add_item text = <ui_string> id=menu_network_host_options_max_players_string rgba=[80 80 80 128] scale=0.8 not_focusable
        endif
		
		if InInternetMode
			GetPreferenceChecksum pref_type=network device_type
			switch <checksum>
				case device_sony_modem
				case device_usb_modem
					NullScript
				default
			GetPreferenceString pref_type=network num_observers
			theme_menu_add_item {
				parent=host_options_vmenu
				text="Observers:"
				extra_text=<ui_string>
				id=menu_network_host_options_max_observers
				pad_choose_script=create_network_host_options_max_observers_menu
			}
			endswitch
				
		endif
		; network_host_options_menu_add_item text = <ui_string> id=menu_network_host_options_max_observers_string rgba=[80 80 80 128] scale=0.8 not_focusable
	endif
	
	if Not InNetGame
		GetPreferenceString pref_type=network team_mode
		theme_menu_add_item {
			parent=host_options_vmenu
			text="Teams:"
			extra_text=<ui_string>
			id=menu_network_host_options_player_team
			pad_choose_script=create_network_host_options_team_menu
		}
		; network_host_options_menu_add_item text = <ui_string> id=menu_network_host_options_player_team_string rgba=[80 80 80 128] scale=0.8 not_focusable
	else
		if GameModeEquals is_lobby
			if IsHost
				if OnServer
					GetPreferenceString pref_type=network team_mode
					theme_menu_add_item {
						parent=host_options_vmenu
						text="Teams:"
						extra_text=<ui_string>
						id=menu_network_host_options_player_team
						pad_choose_script=create_network_host_options_team_menu
					}
				else
					GetPreferenceString pref_type=network team_mode
					theme_menu_add_item {
						parent=host_options_vmenu
						text="Teams:"
						extra_text=<ui_string>
						id=menu_network_host_options_player_team
						pad_choose_script=create_network_host_options_team_menu
						first_item	
					}
				endif
			endif
		endif		
	endif
	
	if IsHost
		if GameModeEquals is_lobby
			if not ( <actual_server> = 1 )
				<last_menu_item> = last_menu_item
			endif
			GetPreferenceString pref_type=network player_collision
			theme_menu_add_item {
				parent=host_options_vmenu
				text="Collision:"
				extra_text=<ui_string>
				last_menu_item = <last_menu_item>
				id=menu_network_host_options_player_collision
				pad_choose_script=create_network_host_options_player_collision_menu
			}
			; network_host_options_menu_add_item text = <ui_string> id=menu_network_host_options_player_collision_string rgba=[80 80 80 128] scale=0.8 not_focusable
		endif
	endif
    
	if( <actual_server> = 1 )
		GetPreferenceString pref_type=network skill_level
		theme_menu_add_item {
			parent=host_options_vmenu
			text="Skill Level:"
			extra_text=<ui_string>
			id=menu_network_host_options_skill_level
			pad_choose_script=create_network_host_options_skill_level_menu
		}
		
        if GameModeEquals is_lobby
		GetPreferencePassword pref_type=network password
		theme_menu_add_item {
			parent=host_options_vmenu
			text="Password:"
			extra_text=<password_string>
			id=menu_network_host_options_password
			pad_choose_script=create_network_host_options_password_menu
		}
		; network_host_options_menu_add_item text = <ui_string> id=menu_network_host_options_skill_level_string rgba=[80 80 80 128] scale=0.8 not_focusable
		
        if InNetGame
			last_menu_item=last_menu_item
		endif
			
			if not isHost
				<not_focusables>=not_focusable
			endif
			printstruct<not_focusables>
			theme_menu_add_item {
				parent=host_options_vmenu
				text="Advanced"
				extra_text="Options" 
				id=menu_real_cheats 
				pad_choose_script=create_real_cheats_menu 
				pad_choose_params={ back_script=create_network_host_options_menu }
				last_menu_item=<last_menu_item>
				not_focusable=<not_focusables>
			}
	
		else
			GetPreferencePassword pref_type=network password
			if InNetGame
				last_menu_item=last_menu_item
			endif
			theme_menu_add_item {
				parent=host_options_vmenu
				text="Password:"
				extra_text=<password_string>
				id=menu_network_host_options_password
				pad_choose_script=create_network_host_options_password_menu
				last_menu_item=<last_menu_item>
// MICK:  Temp fix to stop the game crashing (permanent fix above)
//				last_menu_item=1
			}
        endif
	endif
		
	if Not InNetGame
        // Make the Ready option not selectable if the level is created park, but
        // the chosen number of players is more than the current park can handle.
        focusable={}
        GetPreferenceChecksum pref_type=network level
        if (<checksum>=load_sk5ed_gameplay)
            GetParkEditorMaxPlayers
            GetNetworkNumPlayers
            if (<num_players> > <MaxPlayers>)   
                focusable={not_focusable}
            endif    
        endif 
            
		theme_menu_add_item {
			parent=host_options_vmenu
			text="Ready"
			id=menu_network_host_options_ready
			pad_choose_script=chosen_host_game
			last_menu_item=last_menu_item
            <focusable>
		}
	endif
	
	if LevelIs load_skateshop
		RunScriptOnScreenElement id=globe rotate_internet_options_globe
	endif
	
    finish_themed_sub_menu menu=host_options_menu
	
	if not InNetGame
		RunScriptOnScreenElement id=current_menu_anchor set_ready_focus
	endif
endscript

script set_ready_focus
	;menu_onscreen <...>
	FireEvent type=unfocus target=host_options_vmenu
	FireEvent type=focus target=host_options_vmenu data={child_id=menu_network_host_options_ready}
endscript

script network_host_options_menu_add_item { parent=current_menu
											pad_choose_script=nullscript
                                            focus_script=theme_item_focus
											text="Default text"
											unfocus_script=theme_item_unfocus
											pad_choose_script=null_script
											pad_choose_sound=theme_menu_pad_choose_sound
											scale=1.0
											rgba=[88 105 112 118]
											dims=(300,18)
											just=[right center]
										  }	
    if GotParam not_focusable
		<rgba> = [60 60 60 75]
	else
		FormatText ChecksumName=text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
		<rgba> = <text_color>
	endif
    
	// container for this menu item
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>
		id=<id>
		
        dims=<dims>
		just=[center center]
		
		event_handlers=[
			{focus				<focus_script> params={text=<text>} }
			{unfocus			<unfocus_script>}
			{pad_start			<pad_choose_sound> }
			{pad_choose			<pad_choose_sound> }
			{pad_choose			<pad_choose_script> params=<pad_choose_params> }
			{pad_start			<pad_choose_script> params=<pad_choose_params> }
		]		
		<not_focusable>
	}
    container_id=<id>
	
	//text
	CreateScreenElement {
		type=TextElement
		parent=<id>
        
		font=small
		text=<text1>        
		rgba=<rgba>
		scale=<scale>
		pos=(190,10)
		just=[right center]
		
	}
    
	if not GotParam no_highlight_bar
		highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )
		
		// highlight bar
		CreateScreenElement {
			type=SpriteElement
			parent=<container_id>
			
			texture=DE_highlight_bar
			pos=(120,10)
			rgba=[0 0 0 0]
			just=[center center]
			scale = (6.3,0.7)
			z_priority=1
			rot_angle=<highlight_angle>
		}
	endif
	
	//text2
	CreateScreenElement {
		type=TextElement
		parent=<container_id>
        
		font=dialog
		text=<text2> 
		rgba=<rgba>
		scale=.83
		pos=(200,10)
		just=[left center]
		
	}
	
endscript

script network_host_options_menu_focus
	GetTags
	// make text1 white
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=[128 128 128 128]
	}

	// do jiggly thing on text2
	RunScriptOnScreenElement id={ <id> child=1 } do_scale_up params={ rgba=[128 118 0 128] }
	
	// bring up the highlight bar
	SetScreenElementProps {
		id={ <id> child=2 }
		rgba=[128 128 128 50]
	}
endscript

script network_host_options_menu_unfocus
	GetTags
	
	// make text1 off-white
	SetScreenElementProps {
		id={ <id> child=0 }
		rgba=[88 105 112 128]
	}

	// stop jiggly effects on text2
	RunScriptOnScreenElement id={ <id> child=1 } do_scale_down params={ rgba=[127 102 0 128] }
	
	// hide the highlight bar
	SetScreenElementProps {
		id={ <id> child=2 }
		rgba=[128 128 128 0]
	}
endscript

script chosen_start_game
	if InNetGame
		GetPreferenceChecksum pref_type=network game_type		
		if( <checksum> = netctf )
			if Not InTeamGame
				set_preferences_from_ui prefs=network field="team_mode" checksum=teams_two string="2"
				SetNumTeams 2
			endif
		endif
	else
		// Not sure why this call was here
		;UnpauseGame
	endif
	LoadPendingPlayers
    StartNetworkGame
    if InSplitScreenGame
        Skater:RunStarted
        Skater2:RunStarted
    endif
	if ObjectExists id=current_menu_anchor
		exit_pause_menu
	endif
endscript

script network_options_selected
	PauseMusicAndStreams
	hide_current_goal
    launch_network_host_options_menu
endscript

script network_game_options_selected
    create_network_game_options_menu <...>
endscript

script network_start_selected
    if OnServer
		chosen_start_game
	else
		FCFSRequestStartGame
		exit_pause_menu
	endif
endscript

script fcfc_end_game_selected
    ReportStats final
    do_backend_retry
endscript

script network_end_game_selected
	if GameIsOver
		// refresh the pause menu
		create_pause_menu
		return
	endif
	
	kill_all_panel_messages
	if InSplitScreenGame
		SetStatOverride		// Restore stats to regular amounts
		GoalManager_DeactivateAllGoals
		//MakeSkaterGosub add_skater_to_world skater=0
		//MakeSkaterGosub add_skater_to_world skater=1
		change_gamemode_freeskate_2p
		ClearTrickAndScoreText
		pause_trick_text
		create_end_run_menu
	else
        if InInternetMode
            if OnServer
                ReportStats final
            endif
        endif
		EndNetworkGame
	endif
endscript

script generic_array_menu_setup time=60
    add_item_script=theme_menu_add_centered_item ;main_menu_add_item
    
	if not ( <pref_field>="game_type" )
		if not ( <pref_field>="device_type" )
			//<add_item_script> text=<name> not_focusable=not_focusable
		endif
	endif
    
	GetArraySize <array>
	
	<array_size> = (<array_size>-1)
	
	begin
	GetNextArrayElement <array>
	; Element may not exist if the array was empty.
    if GotParam Element 
	    // Merge the element's parameters into this scripts parameters so that
	    // we can access them via <,>
		AddParams <Element>
		
		if ( <pref_field>="game_type" )
			focus_script=game_options_focus_script
			focus_params={ description=<description> }
			add_item_script=make_text_sub_menu_item
		endif
		
		
		
		if GotParam not_in_custom_parks
			if CustomParkMode just_using
				show_option=0
			else
				show_option=1
			endif
		else
			show_option=1
		endif

		if GotParam not_pal
			if IsPal
				show_option=0
			endif
		endif
		if not (<array_size>=0)
			if( <show_option> = 1 )
				if GotParam not_available
					theme_menu_add_item text=<name> id=<checksum> font=small centered=1 rgba=[80 80 80 128] pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> } not_focusable  highlight_bar_scale=<highlight_bar_scale> scale=<scale>
				else
					if GotParam team_only
						if InTeamGame
							theme_menu_add_item text=<name> id=<checksum> font=small centered=1 pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params=<focus_params> highlight_bar_scale=<highlight_bar_scale> scale=<scale>
							
						else
							theme_menu_add_item text=<name> id=<checksum> font=small centered=1 rgba=[80 80 80 128] pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> } not_focusable highlight_bar_scale=<highlight_bar_scale> scale=<scale>
							
						endif
					else
						theme_menu_add_item text=<name> id=<checksum> font=small centered=1 pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params=<focus_params> highlight_bar_scale=<highlight_bar_scale> scale=<scale>
						
					endif
				endif
			endif
		else
			if( <show_option> = 1 )
				if GotParam not_available
					theme_menu_add_item text=<name> id=<checksum> font=small centered=1 rgba=[80 80 80 128] pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> } not_focusable  highlight_bar_scale=<highlight_bar_scale> scale=<scale> last_menu_item=1
				  
				else
					if GotParam team_only
						if InTeamGame
							theme_menu_add_item text=<name> id=<checksum>  font=small centered=1 pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params=<focus_params> highlight_bar_scale=<highlight_bar_scale> scale=<scale> last_menu_item=1
							
						else
							theme_menu_add_item text=<name> id=<checksum> font=small centered=1 rgba=[80 80 80 128] pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> } not_focusable highlight_bar_scale=<highlight_bar_scale> scale=<scale> last_menu_item=1
						   
						endif
					else
						theme_menu_add_item text=<name> id=<checksum> font=small centered=1 pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params=<focus_params> highlight_bar_scale=<highlight_bar_scale> scale=<scale> last_menu_item=1
					   
					endif
				endif
			endif
		endif
		
		<array_size> = (<array_size>-1)
		RemoveParameter not_available
		RemoveParameter not_in_custom_parks
		RemoveParameter not_pal
	else
	    break
        endif
    repeat
	
endscript

script generic_array_menu_desc_setup time=60
    add_item_script=theme_menu_add_centered_item ;main_menu_add_item
    
	if not ( <pref_field>="game_type" )
		if not ( <pref_field>="device_type" )
			//<add_item_script> text=<name> not_focusable=not_focusable
		endif
	endif 
	
	GetArraySize <array>
	
	<array_size> = (<array_size>-1)
	theme_background parent=current_menu_anchor id=bg_box_vmenu width=3.5 pos=(320,625) num_parts=9.5 z_priority=1
	
	begin
	GetNextArrayElement <array>
	; Element may not exist if the array was empty.
    if GotParam Element 
	    // Merge the element's parameters into this scripts parameters so that
	    // we can access them via <,>
		AddParams <Element>
		
		if ( <pref_field>="game_type" )
			focus_script=game_options_focus_script
			focus_params={ description=<description> }
			add_item_script=make_text_sub_menu_item
		endif
		
		if GotParam not_in_custom_parks
			if CustomParkMode just_using
				show_option=0
			else
				show_option=1
			endif
		else
			show_option=1
		endif
		
		if GotParam not_pal
			if IsPal
				show_option=0
			endif
		endif
		
		FormatText ChecksumName=icon_2p <icon>
		
		if not (<array_size>=0)
			if( <show_option> = 1 )
				if GotParam not_available
					theme_menu_add_item text=<name> id=<checksum> text_pos=(115, -5) no_bg font=small rgba=[80 80 80 128] pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> } not_focusable  highlight_bar_scale=(2.7,0.8) scale=<scale>
					;make_text_sprite texture=<icon_2p> parent=<checksum>
				else
					if GotParam team_only
						if InTeamGame
							theme_menu_add_item text=<name> id=<checksum> text_pos=(115, -5) no_bg font=small pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params={<focus_params> id=<checksum> icon=<icon_2p> text=<name>}  unfocus_script=sprite_unfocus highlight_bar_scale=(2.7,0.8) scale=<scale>
						    ;make_text_sprite texture=<icon_2p> parent=<checksum>
						else
							theme_menu_add_item text=<name> id=<checksum> text_pos=(115, -5) no_bg font=small rgba=[80 80 80 128] pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> } not_focusable highlight_bar_scale=(2.7,0.8) scale=<scale>
						    ;make_text_sprite texture=<icon_2p> parent=<checksum>
						endif
					else
						theme_menu_add_item text=<name> id=<checksum> text_pos=(115, -5) no_bg font=small pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params={<focus_params> id=<checksum> icon=<icon_2p> text=<name>}  unfocus_script=sprite_unfocus highlight_bar_scale=(2.7,0.8) scale=<scale>
						;make_text_sprite texture=<icon_2p> parent=<checksum> scale=1.0
					endif
				endif
			   
			endif
		else
			if( <show_option> = 1 )
				if GotParam not_available
					theme_menu_add_item text=<name> id=<checksum> text_pos=(115, -5) no_bg font=small rgba=[80 80 80 128] pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> } not_focusable static_width=400 highlight_bar_scale=(2.7,0.8) scale=<scale> ;last_menu_item=1
					;make_text_sprite texture=<icon_2p> parent=<checksum>
				else
					if GotParam team_only
						if InTeamGame
							theme_menu_add_item text=<name> id=<checksum> text_pos=(115, -5)  no_bg font=small pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params={<focus_params> id=<checksum> icon=<icon_2p> text=<name>} unfocus_script=sprite_unfocus static_width=400 highlight_bar_scale=(2.7,0.8) scale=<scale> ;last_menu_item=1
						    ;make_text_sprite texture=<icon_2p> parent=<checksum>
						else
							theme_menu_add_item text=<name> id=<checksum> text_pos=(115, -5) no_bg font=small rgba=[80 80 80 128] pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> } not_focusable static_width=400 highlight_bar_scale=(2.7,0.8) scale=<scale> ;last_menu_item=1
						    ;make_text_sprite texture=<icon_2p> parent=<checksum>
						endif
					else
						theme_menu_add_item text=<name> id=<checksum> text_pos=(115, -5) no_bg font=small pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params={<focus_params> id=<checksum> icon=<icon_2p> text=<name>} unfocus_script=sprite_unfocus static_width=400 highlight_bar_scale=(2.7,0.8) scale=<scale> ;last_menu_item=1
					   ;make_text_sprite texture=<icon_2p> id=dfdfdf parent=asdf
					endif
				endif
			endif
		endif
		
		<array_size> = (<array_size>-1)
		RemoveParameter not_available
		RemoveParameter not_in_custom_parks
		RemoveParameter not_pal
	else
	    break
        endif
    repeat
	
	 //item description bg
    CreateScreenElement { 
		type=SpriteElement 
		parent=current_menu_anchor
		id=item_bg_box 	
		padding_scale=.5
		texture=black
        z_priority=0       
		scale=(82, 15)
		pos=(320,840)
		just=[center top]
		rgba=[0 0 0 200]	
	}
    
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	//item description split bar
	
    CreateScreenElement { 
		type=SpriteElement 
		parent=current_menu_anchor 	
		id=item_description_bar
		texture=white2
        scale=(40,0.5)
        pos=(320,854)
		just=[center top]
		rgba=<on_rgba>
	}
		
	CreateScreenElement { 
		type=textBlockElement 
		parent=current_menu_anchor 	
		id=item_description_text
		text=""
		font=small
		dims=(300,75)
        scale=1.0
		line_spacing=.6
        pos=(320,838)
		just=[center top]
		rgba=[80 80 80 50]
	}
	
	 ;theme_menu_add_item text="" not_focusable cross_it_out font=small no_bg pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params=<focus_params> highlight_bar_scale=<highlight_bar_scale> scale=<scale>
	 
	 ;theme_menu_add_item {
		;text="" dims=(420, 0) static_width pos=<pos> rgba=[50 50 50 100] font=dialog just=[center top] internal_just=[center top] no_bg scale=.8 dims=(420, 60) not_focusable allow_expansion text_id=item_description_text /*box_it_up*/ not_focusable font=small centered=1 pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string=<name> checksum=<checksum> time=<time> <...> } focus_script=<focus_script> focus_params=<focus_params> highlight_bar_scale=<highlight_bar_scale> scale=<scale> last_menu_item=1
   ; }
	
	wait 1 gameframe
	
endscript

script game_options_focus_script
	
	SetScreenElementProps id=item_description_text text=<description> line_spacing=0.8
	main_theme_focus <...>
	
	///////////////////////////////////////////////////////////
	theme_item_focus <...>
	
    GetTags
    
    FormatText ChecksumName=icon_color "%i_ICON_ON_VALUE" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
    
	if ( no_focus_sound = 1 )
		change no_focus_sound = 0
	else
		SpawnScript play_icon_spin_sound
	endif
	
	wait 3 gameframes
	
	if ObjectExists id=cur_2p_sprite
		DestroyScreenElement id=cur_2p_sprite
	endif
	
	SetScreenElementLock id=<id> off
	CreateScreenElement { 
		type=SpriteElement 
		parent=<id> 	
		id=cur_2p_sprite
		texture=<icon>
        ;scale=(40,0.5)
        pos=(140,-25)
		just=[center top]
		rgba=<icon_color>
	}
	
    DoScreenElementMorph id=cur_2p_sprite time=0 scale=(0,0) alpha=0.0
	DoScreenElementMorph id=cur_2p_sprite time=0.2 scale=(1.3,1.3) alpha=1.0
endscript

script game_type_description_box
	//item description bg
    CreateScreenElement { 
		type=SpriteElement 
		parent=current_menu_anchor
		id=item_bg_box 	
		
		texture=black
        z_priority=0       
		scale=(85, 12)
		pos=(160,350)
		just=[ left top ]
		rgba=[0 0 0 80]	
	}
    
	//item description side bar
	GetStackedScreenElementPos x id=item_bg_box offset=(1, 0)
    CreateScreenElement { 
		type=SpriteElement 
		parent=current_menu_anchor 	
		
		texture=goal_right
        z_priority=0       
		scale=(.85, .18)
        pos=<pos>
		just=[center top]
		rgba=[0 0 0 80]	
	}

	//item description white box
	/*GetStackedScreenElementPos x id=item_bg_box offset=(-170, 4)
	CreateScreenElement { 
		type=SpriteElement 
		parent=current_menu_anchor  	
		
		texture=stats_notch
		pos=<pos>
		z_priority=1
		scale=(21, 1.1)
		just=[center top]
		rgba=[100 100 100 40]	
	}*/
	
	
    //item description available text
    GetStackedScreenElementPos x id=item_bg_box offset=(-170, 2)
	CreateScreenElement {
		type=TextBlockElement
		parent=current_menu_anchor
		id=item_description_text
		
		dims=(420, 0)
        pos=<pos>
        rgba=[50 50 50 100]
		font=dialog
		just=[center top]
		internal_just=[center top]
        scale=.8
		text=""
		
		not_focusable
		allow_expansion
	}
	
	wait 1 gameframe
endscript

script end_network_game
	kill_all_panel_messages
	dialog_box_exit
    	do_backend_retry
endscript

script CreateServerQuitDialog
    printf "**** in CreateServerQuitDialog ****"
    HideLoadingScreen
	if Not LevelIs load_skateshop
        printf "**** Level was not the skateshop ****"
		GoalManager_DeactivateAllGoals force_all
        GoalManager_UninitializeAllGoals
		GoalManager_SetCanStartGoal 0
		kill_net_panel_messages
		destroy_onscreen_keyboard
		force_close_rankings dont_retry
		exit_pause_menu
		HideLoadingScreen
		if Not IsObserving
            if ObjectExists id=skater
			    skater:Vibrate off
            endif
			ExitSurveyorMode
		endif
        dialog_box_exit anchor_id=quit_dialog_anchor
		change check_for_unplugged_controllers=0
		create_error_box { title="Notice" 
							text="The host has quit. Select OK to leave this game."
							buttons=[ { text="ok" pad_choose_script=quit_network_game } 
									]
							delay_input
							delay_input_time=3000
						  }
    else
        printf "*** Level IS the skateshop ***"                          
	endif
endscript		 

script create_game_ended_dialog
	if Not LevelIs load_skateshop
		GoalManager_DeactivateAllGoals force_all
        GoalManager_UninitializeAllGoals
		GoalManager_SetCanStartGoal 0
		kill_net_panel_messages
		destroy_onscreen_keyboard
		force_close_rankings
		exit_pause_menu
		create_error_box { title="Notice" 
							text="The host has terminated the current game.  Select OK to go back to freeskate."
							buttons=[ { text="ok" pad_choose_script=end_network_game } 
									]
							delay_input
						  }
	endif
endscript        

script accept_lost_connection
	dialog_box_exit
	if EnteringNetGame
		cancel_join_server
	else
		quit_network_game
	endif
endscript

script CreateLostConnectionDialog
    HideLoadingScreen
	GoalManager_DeactivateAllGoals force_all
    GoalManager_UninitializeAllGoals
	GoalManager_SetCanStartGoal 0
	exit_pause_menu// menu_id=pause_menu
	destroy_onscreen_keyboard
	force_close_rankings dont_retry
	if InNetGame
		if LocalSkaterExists
			skater:Vibrate off
		endif
	endif
    if Not IsObserving
        ExitSurveyorMode
    endif
	
	dialog_box_exit
	dialog_box_exit anchor_id=link_lost_dialog_anchor
    dialog_box_exit anchor_id=quit_dialog_anchor
	change check_for_unplugged_controllers=0
	create_error_box { title="Notice" 
                        text="You have lost connection to the host. Select OK to leave this game."
                        buttons=[ { text="ok" pad_choose_script=accept_lost_connection } 
                                ]
						delay_input
                      }
endscript		 
		 
script BackToServerListFromJoinRefusedDialog
	dialog_box_exit
	create_network_select_games_menu
	;cancel_join_server
endscript		 

script CreateJoinRefusedDialog
	if InNetGame
		create_dialog_box { title=net_refused_msg
                        text=<reason>
                        buttons=[ { text="ok" pad_choose_script=dialog_box_exit } 
                                ]
                      }
	else
		if GotParam just_dialog
			create_dialog_box { title=net_refused_msg
                        text=<reason>
                        buttons=[ { text="ok" pad_choose_script=BackToServerListFromJoinRefusedDialog } 
                                ]
                      }
		else
			cancel_join_server show_refused_dialog <...>
		endif
	endif
endscript

script create_refused_dialog
	printf "******* in cancel_join_server 12"
	;cancel_join_server
	if InNetGame
		create_dialog_box { title=net_refused_msg
                        text=<reason>
                        buttons=[ { text="ok" pad_choose_script=dialog_box_exit } 
                                ]
                      }
	else
		create_dialog_box { title=net_refused_msg
                        text=<reason>
                        buttons=[ { text="ok" pad_choose_script=BackToServerListFromJoinRefusedDialog } 
                                ]
                      }
	endif
endscript		 		 

script reattempt_join_server
	ReattemptJoinServer
	PlaySkaterCamAnim name=SS_MenuCam play_hold
endscript

script cancel_join_server
	printf "******* in cancel_join_server"
    if GotParam cancel_nn
        CancelNatNegotiation
    endif
	destroy_onscreen_keyboard
	dialog_box_exit
	printf "******* in cancel_join_server 2"
	// We need to do this because "CancelJoinServer" eventually calls restart_local_server (below), which clears
	// the network mode.  We then need to set our previous network mode before going to the server list menu
	if InInternetMode
		printf "******* in cancel_join_server 3"
		CancelJoinServer
		restart_local_server
		SetNetworkMode INTERNET_MODE
	else
		printf "******* in cancel_join_server 4"
		CancelJoinServer
		printf "******* in cancel_join_server 5"
		restart_local_server
		printf "******* in cancel_join_server 6" 
		SetNetworkMode LAN_MODE
	endif
	
	printf "******* in cancel_join_server 7"
	if GotParam show_timeout
		printf "******* in cancel_join_server 8"
		create_join_timeout_dialog
	else
		if GotParam show_refused_dialog
			printf "******* in cancel_join_server 9"
			create_refused_dialog <...>
		else
			printf "******* in cancel_join_server 10"
			create_network_select_games_menu
		endif
	endif
	kill_start_key_binding	
	printf "******* in cancel_join_server 11"
	begin
		if LocalSkaterExists
			MakeSkaterGoto SkateshopAI Params={NoSFX}	
	    KillSkaterCamAnim all 
        	Skater:reset_model_lights
        	Skater:remove_skater_from_world
        	
        	KillSkaterCamAnim all
        	PlaySkaterCamAnim skater=0 name=mainmenu_camera03 play_hold
        	PlaySkaterCamAnim name=ss_menucam play_hold
			break
		else
			Wait 1	
		endif
	repeat
endscript

script CreateEnterPasswordControl
	dialog_box_exit
	create_onscreen_keyboard password allow_cancel keyboard_cancel_script=cancel_join_server keyboard_done_script=try_password keyboard_title="ENTER PASSWORD" text="" min_length=1 max_length=9
endscript

script try_password
	GetTextElementString id=keyboard_current_string
	destroy_onscreen_keyboard
	JoinWithPassword <...>
endscript

script CreateGameInProgressDialog
	dialog_box_exit
	kill_start_key_binding
	create_dialog_box { title=net_status_msg
					text=net_message_game_in_progress
					buttons=[ 
								{ text="ok" pad_choose_script=reattempt_join_server } 
								{ text="cancel" pad_choose_script=cancel_join_server } 
							]
				  }
endscript		 		 

script CreateConnectingDialog
	kill_start_key_binding
	PauseMusicAndStreams
	create_dialog_box { title=net_status_msg
					text=net_status_connecting
					no_animate
					buttons=[ 
								{ text="cancel" pad_choose_script=cancel_join_server } 
							]
				  }
endscript

script CreateJoiningDialog
    	dialog_box_exit
	kill_start_key_binding
	create_dialog_box { title=net_status_msg
					text=net_status_joining
					no_animate
					buttons=[ 
								{ text="cancel" pad_choose_script=cancel_join_server } 
							]
				  }
endscript
	
script CreateTryingPasswordDialog
	kill_start_key_binding
	PauseMusicAndStreams
	create_dialog_box { title=net_status_msg
					text=net_status_trying_password
					no_animate
					buttons=[ 
								{ text="cancel" pad_choose_script=cancel_join_server } 
							]
				  }
endscript

script wait_for_players
	dialog_box_exit
	create_net_panel_message text=net_message_game_will_start
endscript

script dont_wait_for_players
	dialog_box_exit
	DropPendingPlayers
endscript

script CreateWaitForPlayersDialog
	if ObjectExists id=pause_menu
		exit_pause_menu
	endif
	destroy_onscreen_keyboard
	create_error_box { title=net_status_msg
					text=net_message_waiting_for_players
					no_animate
					buttons=[ 
								{ text="Yes" pad_choose_script=wait_for_players } 
								{ text=" No " pad_choose_script=dont_wait_for_players } 
							]
					no_animate
					delay_input
				  }
endscript

script back_from_join_timeout
	dialog_box_exit
	create_network_select_games_menu
endscript

script ShowJoinTimeoutNotice
	cancel_join_server show_timeout
endscript

script create_join_timeout_dialog    
    dialog_box_exit
	create_dialog_box { title=net_status_msg
					text=net_status_join_timeout
					buttons=[ 
								{ text="ok" pad_choose_script=back_from_join_timeout } 
							]
				  }
endscript

script create_join_failed_dialog
	create_dialog_box { title=net_status_msg
					text=net_status_join_failed
					buttons=[ 
								{ text="ok" pad_choose_script=cancel_join_server }
							]
				  }
endscript

script exit_net_menus
	dialog_box_exit
	SetGameType career
    SetCurrentGameType
	create_main_menu
endscript

script create_link_unplugged_front_end_dialog
	back_from_multiplayer_menu no_menu
	create_dialog_box { title=net_status_msg
					text=net_error_unplugged_front_end
					buttons=[ 
								{ text="ok" pad_choose_script=exit_net_menus } 
							]
				  }
endscript

script link_unplugged_ok	
    dialog_box_exit anchor_id=quit_dialog_anchor no_pad_start
	dialog_box_exit anchor_id=link_lost_dialog_anchor no_pad_start
	
	<found_menu> = 0
	if ScreenElementExists id=current_menu_anchor
		<found_menu> = 1
		DoScreenElementMorph {
			id=current_menu_anchor
			scale=1
		}
		FireEvent type=focus target=current_menu_anchor
	endif
	
	if ScreenElementExists id=current_menu
		<found_menu> = 1
		FireEvent type=focus target=current_menu
	endif
	
	if not LevelIs load_skateshop
		if ( <found_menu> = 0 )
			if SkaterCamAnimFinished
				create_pause_menu
			else
				;UnPauseGame
			endif
		endif
	endif
endscript

script link_unplugged_quit
    	//link_unplugged_ok
    dialog_box_exit anchor_id=link_lost_dialog_anchor no_pad_start
	launch_quit_game_dialog
endscript

script create_link_unplugged_dialog
    if ScreenElementExists id=dialog_box_anchor
		return
	endif
    if ScreenElementExists id=quit_dialog_anchor
		return
	endif
    	if ScreenElementExists id=current_menu_anchor
		DoScreenElementMorph {
			id=current_menu_anchor
			scale=0
		}
		FireEvent type=unfocus target=current_menu_anchor
	endif
	
	if ScreenElementExists id=current_menu
		FireEvent type=unfocus target=current_menu
	endif

    	destroy_onscreen_keyboard
	create_error_box { title=net_error_msg
					anchor_id=link_lost_dialog_anchor
					text=net_error_unplugged
					buttons=[ 
								{ text="ok" pad_choose_script=link_unplugged_ok	 } 
								{ text="quit" pad_choose_script=link_unplugged_quit } 
							]
					no_animate
				  }
	kill_start_key_binding				  
endscript

script exit_async_dialog
	dialog_box_exit
	if GameIsOver
        	do_backend_retry
	endif
endscript

script CreateNotPostedDialog
	kill_all_panel_messages
	create_error_box { title=net_error_msg
					text=net_status_not_posted
					buttons=[ 
								{ text="ok" pad_choose_script=exit_async_dialog } 
							]
					no_animate
					delay_input
					z_priority=50
				  }
endscript
		 
script CreateGettingLobbyListDialog
	dialog_box_exit
	create_dialog_box { title=net_status_msg
						text=net_status_getting_lobbies
						no_animate
						pos=(150,250)
					}
endscript

script CreateFailedLobbyListDialog
	LobbyDisconnect
	dialog_box_exit
	create_dialog_box { title=net_status_msg
                        text=<message>
						buttons=[ 
								{ text="ok" pad_choose_script=cancel_gamespy_connection_failure_dialog } 
							]
							pos=(150,250)
                      }
endscript

script CreateJoinLobbyFailedDialog
	LobbyDisconnect
	dialog_box_exit
	create_dialog_box { title=net_status_msg
                        text="Failed to join lobby."
						buttons=[ 
								{ text="ok" pad_choose_script=create_internet_options } 
							]
                      }
endscript

script CreateConnectingChatDialog
	create_dialog_box { title=net_status_msg
						text=net_status_connecting_chat
					}
endscript

script create_joining_lobby_dialog
	create_dialog_box { title=net_status_msg
						text="Joining lobby..."
						no_animate
						}
endscript

script create_net_panel_message msg_time=2000
	create_panel_block id=net_panel_msg <...> pos=(320,150) rgba=[144 144 144 128] dims=(450, 0) z_priority=-10 time=<msg_time>
endscript							 

script kill_net_panel_messages
	console_clear
	if ObjectExists id=net_panel_msg
		DestroyScreenElement id=net_panel_msg
	endif
	
	if ObjectExists id=taunt_msg_id
		DestroyScreenElement id=taunt_msg_id
	endif
	
	if ScreenElementExists id=perfect
		DestroyScreenElement id=perfect
	endif
	
	if ScreenElementExists id=perfect2
		DestroyScreenElement id=perfect2
	endif

	if ScreenElementExists id=death_message
		DestroyScreenElement id=death_message
	endif
	
	// hide any speech boxes
	if ObjectExists id=speech_box_anchor
		DoScreenElementMorph id=speech_box_anchor scale=0
		; RunScriptOnScreenElement id=speech_box_anchor hide_screen_element
	endif
	if ScreenElementExists id=goal_start_dialog
		DestroyScreenElement id=goal_start_dialog
	endif
	if ObjectExists id=ped_speech_dialog
		DestroyScreenElement id=ped_speech_dialog
	endif
	if ObjectExists id=goal_retry_anchor
		DestroyScreenElement id=goal_retry_anchor
	endif
	
	if ObjectExists id=first_time_goal_info
		DestroyScreenElement id=first_time_goal_info
	endif
	
	if ObjectExists id=skater_hint
		DestroyScreenElement id=skater_hint
	endif
	
	GetArraySize goal_panel_message_ids
	<index> = 0
	begin
		if ScreenElementExists id=( goal_panel_message_ids[<index>] )
			DestroyScreenElement id=( goal_panel_message_ids[<index>] )
		endif
		<index> = ( <index> + 1 )
	repeat <array_size>
endscript

script cancel_connect_to_internet
	printf "script cancel_connect_to_internet"
	dialog_box_exit
	CancelConnectToInternet
endscript

script create_modem_state_dialog
	create_dialog_box { title=net_status_msg
						text=<text>
						no_animate
						buttons=[ 
								{ text="cancel" pad_choose_script=cancel_connect_to_internet } 
							]
						}
endscript

script create_modem_status_dialog
	create_dialog_box { title=net_status_msg
						text=<text>
						no_animate
					}
endscript

script create_modem_final_state_dialog
	create_dialog_box { title=net_status_msg
						text=<text>
						buttons=[ 
								{ text="ok" pad_choose_script=cancel_connect_to_internet } 
							]
						}
endscript

script cancel_gamespy_connection_failure_dialog
	printf "script cancel_gamespy_connection_failure_dialog"
	dialog_box_exit
    StatsLogOff
	ProfileLogOff
	console_destroy
	;create_network_select_menu
	create_ss_menu no_animate
	SetNetworkMode
endscript

script create_gamespy_connection_failure_dialog
	LobbyDisconnect
	create_dialog_box { title=net_error_msg
						text=net_status_gamespy_no_connect
						buttons=[ 
								{ text="ok" pad_choose_script=cancel_gamespy_connection_failure_dialog } 
							]
						}
endscript        

script lost_connection_to_gamespy
	printf "script lost_connection_to_gamespy"
	LobbyDisconnect
    if StatsLoggedIn
        StatsLogOff
    endif
    if ProfileLoggedIn
        ProfileLogOff
    endif
	if LevelIs load_skateshop
		//console_hide
		if ObjectExists id=console_message_vmenu
			DoScreenElementMorph id=console_message_vmenu alpha=0
		endif
		cancel_keyboard
		dialog_box_exit
		exit_pause_menu
		GoalManager_HidePoints
		GoalManager_HideGoalPoints
		create_dialog_box { title=net_error_msg
							text=net_status_gamespy_lost_connection
							buttons=[ 
									{ text="ok" pad_choose_script=cancel_gamespy_connection_failure_dialog };create_network_select_menu } 
								]
							}
	endif
endscript

script cancel_keyboard
    if ObjectExists id=keyboard_anchor
	    //DestroyScreenElement id=keyboard_anchor
        destroy_onscreen_keyboard
	else
		return
	endif
	
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu alpha=1
	endif
	
	create_network_select_games_menu <...>
endscript

script enter_kb_chat_message
	GetTextElementString id=keyboard_current_string
    cancel_keyboard focus_on_enter_message
	SendMessage text=<string>
endscript

script check_keyboard_focus
	KillSpawnedScript name=maybe_launch_lobby_keyboard
	spawnscript maybe_launch_lobby_keyboard
	main_menu_focus <...>
endscript

script maybe_launch_lobby_keyboard
	begin
        wait 1 gameframe
		if not ScreenElementExists id=actions_menu
			break
		endif
		LobbyCheckKeyboard
	repeat
endscript

script check_keyboard_unfocus
	KillSpawnedScript name=maybe_launch_lobby_keyboard
	main_menu_unfocus <...>
endscript

script lobby_enter_kb_chat
	FireEvent type=unfocus target=actions_menu
	create_onscreen_keyboard { 	allow_cancel
								no_buttons
								pos=(320, 530)
								keyboard_done_script=lobby_entered_chat_message
								display_text="ENTER MESSAGE: "
								keyboard_title=""
								min_length=1
								max_length=50
								keyboard_cancel_script=lobby_keyboard_cancel
							}
endscript

script lobby_entered_chat_message
	GetTextElementString id=keyboard_current_string
    SendMessage text=<string>
	destroy_onscreen_keyboard
	AssignAlias id=server_list_anchor alias=current_menu_anchor
    AssignAlias id=actions_menu alias=current_menu
	FireEvent type=focus target=actions_menu
endscript

script lobby_keyboard_cancel
	destroy_onscreen_keyboard
	AssignAlias id=server_list_anchor alias=current_menu_anchor
    AssignAlias id=actions_menu alias=current_menu
	FireEvent type=focus target=actions_menu
endscript

script create_lobby_onscreen_kb
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu alpha=0
	endif
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
    create_onscreen_keyboard {	allow_cancel
								in_net_lobby
								keyboard_cancel_script=cancel_keyboard
								keyboard_done_script=enter_kb_chat_message
								keyboard_title="ENTER CHAT MESSAGE"
								text=""
								max_length=40
								display_text_scale=.65
								display_text_offset=(0,5)
							 }
endscript

script add_multiplayer_mode_goals
	AddGoal_TrickAttack
	AddGoal_ComboMambo
	AddGoal_ScoreChallenge
	AddGoal_Graffiti
	AddGoal_Slap
	AddGoal_King
	AddGoal_Ctf
	AddGoal_Horse_Mp
	AddGoal_GoalAttack
    AddGoal_FireFight
endscript 

script create_score_menu
	if Not ObjectExists id=net_score_menu
		SetScreenElementLock id=root_window off 
		
		CreateScreenElement {
			type=ContainerElement 
			parent=root_window
			id=net_score_menu
			
			pos=(0, 0)
			just=[left top] 
			scale=0
			dims=(640, 480)
			//focusable_child=net_score_vmenu
		}
		
		CreateScreenElement {
			type=VMenu
			parent=net_score_menu
			id=net_score_vmenu
			
			just=[left top]
			pos=(45, 80)
			scale=.9
			padding_scale=1
			internal_scale=1
			internal_just=[left top]
		}

		<index> = 1
		begin
			FormatText ChecksumName=current_id "net_score_%i" i=<index>
			CreateScreenElement {
				type=TextElement
				parent=net_score_vmenu
				id=<current_id>
				font=dialog
				text=""
				scale=.9
				rgba=[128 128 128 98]            
				not_focusable
				z_priority=-5
			}
			<index> = ( <index> + 1 )
		repeat 8
		
		RunScriptOnScreenElement id=net_score_menu menu_onscreen params={preserve_menu_state}
	endif
endscript
		
script clear_scores
	if ObjectExists id=net_score_menu
		<index> = 1
		begin
			FormatText ChecksumName=current_id "net_score_%i" i=<index>
			SetScreenElementProps {
				id=<current_id>
				text=""
			}
			<index> = ( <index> + 1 )
		repeat 8
	endif
endscript
		
script update_score
	if GetGlobalFlag flag=NO_DISPLAY_NET_SCORES
		hide_net_scores
	else
		if ObjectExists id=current_menu_anchor //ie. inside pause menu
			if not ObjectExists id=kb_no_button_hdr //unhide them if the no button keyboard is up
				hide_net_scores
			else
				unhide_net_scores
			endif
		else
			unhide_net_scores
		endif
	endif
endscript

// This is called when you actually make it into a network game
script entered_network_game
	if InInternetMode
        LeaveLobby preserve_status
		SetQuietMode
	endif
	kill_net_panel_messages
	console_unhide
	//create_score_menu
	restore_start_key_binding

	If LocalSkaterExists
		// refresh the model, to turn off any cheats
		refresh_skater_model_for_cheats	
	endif

    // Clients will clear theirs when they receive the cheat list
    if OnServer
        ClearOmnigons
    else
        if InInternetMode
            CancelNatNegotiation
        endif
        DisplayLoadingScreen Freeze
    endif
	; change check_for_unplugged_controllers=1
	EnteredNetworkGame
endscript
		
script restart_local_server
	// Initialize, start and locally join the server.
	SetNetworkMode
    setservermode on
	SetJoinMode	JOIN_MODE_PLAY
	StartServer
    JoinServer <...>
endscript

script handle_keyboard_input
	if ObjectExists id=keyboard_anchor
		if GotParam got_enter
			if ScreenElementExists id=keyboard_done_button
				FireEvent type=pad_choose target=keyboard_done_button
			else
				FireEvent type=pad_choose target=keyboard_anchor
			endif
		else
			if GotParam got_backspace
				keyboard_handle_backspace
			else
				keyboard_button_pressed <...>
			endif
		endif
	endif
endscript

script back_from_profile_options
	FireEvent type=unfocus target=profile_options_menu
	DestroyScreenElement id=profile_options_anchor
    FireEvent type=focus target=sub_menu
endscript

script back_from_profile_error
	printf "script back_from_profile_error"
	dialog_box_exit
	create_internet_options
endscript

script profile_connect
	dialog_box_exit
	if Not ProfileLogIn
		create_internet_options
	endif
endscript

script launch_profile_menu
    dialog_box_exit
	
	if not ScreenElementExists id=menu_play_online
		create_internet_options
	endif
	
	create_profile_menu
endscript
						 

script launch_player_list_menu
	hide_current_goal
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	if InSplitScreenGame
		GoalManager_HidePoints
	endif
	
	
	FormatText ChecksumName=title_icon "%i_career_ops" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="PLAYER LIST" title_icon=<title_icon> dims=(200,237) pos=(229,80) right_bracket_z=1
	
   // Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=sub_menu event_handlers=[
                                            {pad_back  generic_menu_pad_back params={ callback=create_pause_menu}}
                                         ]
                          } 
	
	kill_start_key_binding
	
	;make_new_menu menu_id=buddy_list_menu vmenu_id=lobby_buddy_list_menu menu_title="PLAYER LIST"
	
	create_helper_text generic_helper_text
						
						
	;theme_menu_add_item text="Looooonggggggg Nnnnnnnaaaaammeeeeee" pad_choose_script=null_script centered no_bg first_item
	;theme_menu_add_item text="Stuff" pad_choose_script=null_script centered no_bg first_item
	;theme_menu_add_item text="Stuff" pad_choose_script=null_script centered no_bg last_item
	  
	FillPlayerListMenu
	
	theme_menu_add_item text=" " not_focusable centered 
	theme_menu_add_item text="Done" pad_choose_script=create_pause_menu centered last_menu_item=last_menu_item
	
	finish_themed_sub_menu ;bg_width=3.5 	
endscript

script update_buddy_status   
	if ObjectExists id=<id>
		SetScreenElementProps {
			id=<id>
			text=<text>
			status=<status>
			location=<location>
			}
	endif
endscript


script cancel_face_download
    destroy_onscreen_keyboard
    create_internet_options
endscript

script face_download_chosen cancel_script=cancel_face_download
    if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
    
    GetPreferenceString pref_type=network face_dl_key
    create_onscreen_keyboard {	allow_cancel
								keyboard_cancel_script=<cancel_script>
								keyboard_done_script=launch_face_download
								keyboard_title="ENTER PASSWORD"
								text=<ui_string>
								max_length=50
							 }
	
	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	if not GotParam no_help_box
		// text
		CreateScreenElement{
			type=textBlockElement
			parent=current_menu_anchor
			id=directions_text
			
			text="Enter the password that was e-mailed\nto you after submitting your picture."
			pos=(320,668)
			dims=(640,60)
			font=small
			scale=0.9
			rgba=<rgba>
			line_spacing=0.65
			z_priority=5
			just=[center center]
		}
		
		// box mid
		CreateScreenElement {
			type=spriteElement
			parent=current_menu_anchor
			id=directions_box
			texture=myf_box_mid
			pos=(320,670)
			scale=(12,1.2)
			just=[center center]
			rgba=<highlight_rgba>
			z_priority=5
		}
		
		DoScreenElementMorph id=directions_text time=.2 pos=(320,368)
		DoScreenElementMorph id=directions_box time=.2 pos=(320,370)
	endif
	
endscript

script face_dnas_warning
	dialog_box_exit
	body="Before you can download your face, you will need to select THUG Online Play\n from the Main Menu\nand authenticate your internet connection." //Rulon (TT12711): TCR C4-14 text change.
	if ObjectExists id=current_menu
		FireEvent type=unfocus target=current_menu				
	endif
	if LevelIs load_cas
		create_dialog_box { title="Warning!"
							text=<body>
							text_dims=(350,0)
							pos=(320,240)
							just=[center center]
							text_rgba=[88 105 112 128]
							;text_scale=1
							no_bg=no_bg
							;pad_back_script = no_xbox_autoload
							buttons=[ { font=small text="Continue Without Downloading" pad_choose_script=cont_wo_dl_face_dnas }
									{ font=small text="Return to Main Menu" pad_choose_script=goto_thug_online_face_dnas }
									]
						  }
	else
		create_dialog_box { title="Attention!"
							text=<body>
							text_dims=(350,0)
							pos=(320,240)
							just=[center center]
							text_rgba=[88 105 112 128]
							;text_scale=1
							no_bg=no_bg
							;pad_back_script = no_xbox_autoload
							buttons=[ 	{ font=small text="Ok" pad_choose_script=ok_face_dnas }
									]
						  }
	endif
endscript

script goto_thug_online_face_dnas
	change in_cinematic_sequence  = 0
	change entered_cas_from_main=0
	dialog_box_exit
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	load_cas_textures_to_main_memory unload
	change_level level=load_skateshop
endscript

script cont_wo_dl_face_dnas
	dialog_box_exit
	create_pre_cas_menu
endscript

script ok_face_dnas
	dialog_box_exit
	create_main_menu
endscript
                             
script launch_face_download
    GetTextElementString id=keyboard_current_string
    if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	select_skater_get_current_skater_name
	if not (<current_skater> = custom)
		load_pro_skater { profile=0 skater=0 name=custom }
	endif
	
    set_preferences_from_ui prefs=network field="face_dl_key" <...>
    printf "Downloading face"
    create_dialog_box { title="Downloading Face" text="Checking for file..." no_animate}
    DownloadFace <...>
endscript

script LaunchFaceDownloadCompleteDialog
    dialog_box_exit
    net_vault_menu_exit
    create_dialog_box { title="Download Complete"
						text="Press OK to go map your face."
						buttons=[   { text="OK" pad_choose_script=back_from_face_transfer_succeeded_dialog } 
                                ]
                      }
endscript

script download_content
	printf "retrieving directory listing"
    DestroyScreenElement id=current_menu_anchor
	create_dialog_box { title=net_status_msg
                        text="Retrieving directory listing..."
						no_animate
                      }
	DownloadDirectoryList <type>
endscript

script download_selected_file
	printf "Downloading content"
	GetTags
    GetTextElementString id={ <id> child=0 }
    SetScriptString string=<string>
	DestroyScreenElement id=current_menu_anchor
	create_dialog_box { title="Downloading File"
                        text=""
						no_animate
                      }
	DownloadFile <...>
endscript

script update_transfer_progress
	if ObjectExists id=dialog_box_text
		SetScreenElementProps {
			id=dialog_box_text
			text=<text>
			}
	endif
endscript

script back_from_transfer_dialog
    if GameModeEquals is_net
    	dialog_box_exit
    	create_internet_options
    else
        face_back_from_net_setup
    endif
endscript

script back_from_transfer_succeeded_dialog
	dialog_box_exit
	memcard_menus_cleanup
    create_internet_options
	change savevaultdata = 0
endscript

script LaunchFileNotFoundDialog
    net_vault_menu_exit
	dialog_box_exit
	create_dialog_box { title="File Not Found"
						text="Please verify that you have entered your key correctly and make sure that you have successfully emailed your face to: faces@thugonline.com."
						buttons=[ { text="ok" pad_choose_script=back_from_transfer_dialog } 
                                ]
                      }
endscript

script LaunchGeneralFileNotFoundDialog
    net_vault_menu_exit
	dialog_box_exit
	create_dialog_box { title="Server Error"
						text="Could not download the selected file. The server may be down. Please try again later."
						buttons=[ { text="ok" pad_choose_script=back_from_transfer_dialog } 
                                ]
                      }
endscript

script LaunchTransferFailedDialog
	net_vault_menu_exit
	dialog_box_exit
	create_dialog_box { title="Transfer Failed"
						text="Please check your network cables."
						buttons=[ { text="ok" pad_choose_script=back_from_transfer_dialog } 
                                ]
                      }
endscript


script LaunchDownloadCompleteDialog
	printf "script LaunchDownloadCompleteDialog"
	net_vault_menu_exit
	dialog_box_exit
	
	printstruct <...>
	
	if GotParam type
		switch <type>
			case parks
				text="Save downloaded park?"
				file_type=park
			case goals
				text="Save downloaded goals?"
				file_type=createdgoals
			case skaters
				text="Save downloaded skater?"
				file_type=optionsandpros
			case tricks
				text="Save downloaded trick?"
				file_type=cat
			default
				printf "save download: invalid type"
				return
		endswitch
	else
		printf "save download: missing type"
		return
	endif
    
	create_dialog_box { title="Download Complete"
						text=<text>
						buttons=[   { text="Yes" pad_choose_script=launch_download_save_sequence pad_choose_params={ file_type=<file_type> } } 
									{ text="No" pad_choose_script=back_from_transfer_succeeded_dialog } 
                                ]
                      }
endscript

script back_from_face_transfer_succeeded_dialog
	dialog_box_exit
    
    if GameModeEquals is_net
    	// exit network
        SpawnSecondControllerCheck	// following lines cause assert without this.
    	StatsLogOff
    	ProfileLogOff
    	
    	wait 1 gameframe
    	
    	if ScreenElementExists id=current_menu_anchor
    		DestroyScreenElement id=current_menu_anchor
    	endif
    	
    	// goto cas level
        launch_cas { face2 downloaded_face=downloaded_face }
    else
        face_back_from_net_setup
    endif
endscript

script StartFreeSkate
	MakeSkaterGosub add_skater_to_world skater=0
	MakeSkaterGosub add_skater_to_world skater=1
	SetGameType freeskate2p
	SetCurrentGameType
	SetScreenModeFromGameMode
endscript

script kill_all_panel_messages
	exit_pause_menu
    dialog_box_exit anchor_id=quit_dialog_anchor
	dialog_box_exit
	speech_box_exit
	force_close_rankings
	close_goals_menu
	kill_net_panel_messages
	destroy_onscreen_keyboard
	if ObjectExists id=perfect
		DestroyScreenElement id=perfect
	endif
	if ObjectExists id=perfect2
		DestroyScreenElement id=perfect2
	endif
	if ObjectExists id=death_message
		DestroyScreenElement id=death_message
	endif
	if ObjectExists id=leaving_message
		DestroyScreenElement id=leaving_message
	endif
	if ObjectExists id=goal_message
		DestroyScreenElement id=goal_message
	endif
endscript

script StartingNewNetGame
	;exit_pause_menu menu_id=pause_menu
	sound_options_exit just_remove
	edit_tricks_menu_exit just_remove
	kill_all_panel_messages
    if Not IsObserving
        Skater:RunStarted
    endif        
    ClearPowerups
    if Not IsObserving
        ExitSurveyorMode
    endif
endscript

script unlock_root_window
	SetScreenElementLock id=root_window off
endscript

script create_object_label
	SetScreenElementLock id=root_window off
	CreateScreenElement {
				id=<id>
				type=TextElement
				parent=root_window
				font=small
				text=""
				scale=1.0
				pos3D=(0,0,0)
				rgba=[128 128 0 128]            
			}
endscript

script update_object_label
	if not ObjectExists id=<id>
		create_object_label <...>
	endif
	
	SetScreenElementProps {
			id=<id>
			text=<text>
			pos3D=<pos3D>
		}
endscript

script destroy_object_label
	if ObjectExists id=<id>
		DestroyScreenElement id=<id>
	endif
endscript

script destroy_all_player_names
	if ObjectExists id=skater_name_0
		DestroyScreenElement id=skater_name_0
	endif
	if ObjectExists id=skater_name_1
		DestroyScreenElement id=skater_name_1
	endif
	if ObjectExists id=skater_name_2
		DestroyScreenElement id=skater_name_2
	endif
	if ObjectExists id=skater_name_3
		DestroyScreenElement id=skater_name_3
	endif
	if ObjectExists id=skater_name_4
		DestroyScreenElement id=skater_name_4
	endif
	if ObjectExists id=skater_name_5
		DestroyScreenElement id=skater_name_5
	endif
	if ObjectExists id=skater_name_6
		DestroyScreenElement id=skater_name_6
	endif
	if ObjectExists id=skater_name_7
		DestroyScreenElement id=skater_name_7
	endif
endscript

script hide_all_player_names
	if ObjectExists id=skater_name_0
		DoScreenElementMorph id=skater_name_0 scale=0
	endif
	if ObjectExists id=skater_name_1
		DoScreenElementMorph id=skater_name_1 scale=0
	endif
	if ObjectExists id=skater_name_2
		DoScreenElementMorph id=skater_name_2 scale=0
	endif
	if ObjectExists id=skater_name_3
		DoScreenElementMorph id=skater_name_3 scale=0
	endif
	if ObjectExists id=skater_name_4
		DoScreenElementMorph id=skater_name_4 scale=0
	endif
	if ObjectExists id=skater_name_5
		DoScreenElementMorph id=skater_name_5 scale=0
	endif
	if ObjectExists id=skater_name_6
		DoScreenElementMorph id=skater_name_6 scale=0
	endif
	if ObjectExists id=skater_name_7
		DoScreenElementMorph id=skater_name_7 scale=0
	endif
endscript

script unhide_all_player_names
	if ObjectExists id=skater_name_0
		DoScreenElementMorph id=skater_name_0 scale=1
	endif
	if ObjectExists id=skater_name_1
		DoScreenElementMorph id=skater_name_1 scale=1
	endif
	if ObjectExists id=skater_name_2
		DoScreenElementMorph id=skater_name_2 scale=1
	endif
	if ObjectExists id=skater_name_3
		DoScreenElementMorph id=skater_name_3 scale=1
	endif
	if ObjectExists id=skater_name_4
		DoScreenElementMorph id=skater_name_4 scale=1
	endif
	if ObjectExists id=skater_name_5
		DoScreenElementMorph id=skater_name_5 scale=1
	endif
	if ObjectExists id=skater_name_6
		DoScreenElementMorph id=skater_name_6 scale=1
	endif
	if ObjectExists id=skater_name_7
		DoScreenElementMorph id=skater_name_7 scale=1
	endif
endscript

script create_net_metrics
	SetScreenElementLock id=root_window off
	CreateScreenElement {
				id=net_metrics
				type=TextElement
				parent=root_window
				font=small
				text=""
				scale=1.0
				pos=(150,400)
				rgba=[128 128 0 128]            
			}
endscript

script update_net_metrics
	if not ObjectExists id=net_metrics
		create_net_metrics
	endif
	
	SetScreenElementProps {
			id=net_metrics
			text=<text>
		}
endscript

script notify_cheating
    create_net_panel_message msg_time=6000 text=net_message_server_cheating
endscript

script notify_client_cheating
    FormatText TextName=msg_text "Player %s is cheating!" s=<String0>
    //create_net_panel_message text=<msg_text> style=net_team_panel_message
    create_net_panel_message msg_time=6000 text="At least one player is cheating!" style=net_team_panel_message
endscript

script warn_all_same_team
    create_panel_message id=goal_message text="Warning: All players are on the same team" style=panel_message_generic_loss time=5000
endscript

script test_particle_script
    printf "In Test Particle Script"
endscript

judge_full_name="Judge"
