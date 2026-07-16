dialup_authentication_types = [
	{ name = "Yes" checksum = yes }
	{ name = "No" checksum = no }
]


device_types = [
	{ name = "None"					checksum = device_none }
	{ name = "Ethernet (Network Adaptor for PS2)"	checksum = device_broadband_pc }
	{ name = "Ethernet (Network Adaptor for PS2) (PPPoE)"	checksum = device_broadband_pc_pppoe }
	{ name = "USB Ethernet Adaptor"	checksum = device_broadband_usb }
	{ name = "USB Ethernet Adaptor (PPPoE)"	checksum = device_broadband_usb_pppoe }
	{ name = "Modem (Network Adaptor for PS2)"	checksum = device_sony_modem }
	{ name = "USB Modem"	checksum = device_usb_modem }
]

device_types_pal = [
	{ name = "None"					checksum = device_none }
	{ name = "network adaptor (for PlayStation®2)"	checksum = device_broadband_pc }
	{ name = "network adaptor (for PlayStation®2) (PPPoE)"	checksum = device_broadband_pc_pppoe }
	{ name = "USB Ethernet Adaptor"	checksum = device_broadband_usb }
	{ name = "USB Ethernet Adaptor (PPPoE)"	checksum = device_broadband_usb_pppoe }
]

broadband_types = [
	{ name = "Auto-Detect (DHCP)"	checksum = ip_dhcp }
	{ name = "Static IP Address"	checksum = ip_static }
]

boolean_types = [
	{ name = "Yes"			checksum = boolean_true }
	{ name = "No"			checksum = boolean_false }
]

on_off_types = [
	{ name = "On"			checksum = boolean_true }
	{ name = "Off"			checksum = boolean_false }
]

team_types = [
	{ name = "None"			checksum = teams_none }
	{ name = "2"			checksum = teams_two }
	{ name = "3"			checksum = teams_three }
	{ name = "4"			checksum = teams_four }
	
]

config_types = [
	{ name = "Your Network Configuration Files"		checksum = config_sony }
	{ name = "Manual Settings"					checksum = config_manual }
]

score_players = [
	{ name = "Show Players"		checksum = score_players }
	{ name = "Show Teams"		checksum = score_teams }
]

ctf_type = [
    { name = "Use Time Limit"       checksum = timed_ctf }
    { name = "Use Capture Limit"    checksum = score_ctf }
]


default_master_servers = [
	{ name = "205.147.4.17"	}
	{ name = "63.241.179.8" }
	{ name = "205.147.28.3"	}
]

// Ken: These used to be in default_network_preferences, but then they were required to 
// be saved out with the career file when saving to mem card, rather than with the net settings,
// so I separated them out into this structure. (See TT6068)
// Note, to access these from script, one now needs to do "GetPreferenceString pref_type=taunt your_daddy_string"
// rather than the old "GetPreferenceString pref_type=network your_daddy_string"
default_taunt_preferences=
{
	no_way_string = { ui_string = "No Way" }
	your_daddy_string = { ui_string = "Who's your daddy?" }
	props_string = { ui_string = "Props" }
	get_some_string = { ui_string = "Come Get Some" }
}

default_network_preferences = {
	game_type = { ui_string = "Trick Attack" checksum = nettrickattack }
	num_players = { ui_string = "8 Players" checksum = num_8 value = 8 }
	num_observers = { ui_string = "No Observers" checksum = num_0 value = 0 }
	player_collision = { ui_string = "Off" checksum = boolean_false }
    friendly_fire = { ui_string = "Off" checksum = boolean_false }
	team_mode = {ui_string = "None" checksum = teams_none }
	password = { ui_string = "" }
	level = { ui_string = "New Jersey" checksum = load_nj }
	goals = { ui_string = "Story Mode" checksum = goals_story }
	server_name = { ui_string = "Neversoft" }
	network_id = { ui_string = "ProSkater" }
	ip_address = { ui_string = "192.168.0.10" }
	gateway = { ui_string = "192.168.0.1" }
	subnet_mask = { ui_string = "255.255.255.0" }
	auto_dns = { ui_string ="Yes" checksum = boolean_true }
	dns_server = { ui_string = "192.168.0.1" }
	dns_server2 = { ui_string = "192.168.0.2" }
	;dns_server = { ui_string = "0.0.0.0" }
	;dns_server2 = { ui_string = "0.0.0.0" }
	device_type = { ui_string = "None" checksum = device_none }
	;device_type = { ui_string =; "Ethernet (Network Adaptor for PS2)" checksum = device_broadband_pc }
	broadband_type = { ui_string = "Auto-Detect (DHCP)" checksum = ip_dhcp }
	;dialup_number = { ui_string = "94834492" }	// Standard earthlink
	;dialup_number={ui_string="95180010" }	// AOL	// 94834265
	dialup_number={ui_string="" }
	//dialup_username = { ui_string = "neversoft" }
	//dialup_password = { ui_string = "thps123" }
	//dialup_username = { ui_string = "nsthps4" }
	//dialup_password = { ui_string = "loganj" }
	dialup_username = { ui_string = "" }
	dialup_password = { ui_string = "" }
	time_limit = { ui_string = "2 minutes" checksum = time_120 time = 120 }
	target_score = { ui_string = "1,000,000 points" checksum = score_1000000 score = 1000000 }
	host_name = { ui_string = "" }
	domain_name = { ui_string = "" }
	dialup_authentication = { ui_string = "Yes" checksum = boolean_true }
	skill_level = { ui_string = "3: Hold My Own" checksum = num_3 }
	use_default_master_servers = { ui_string ="Yes" checksum = boolean_true }
	master_server1 = { ui_string = "0.0.0.0" }
	master_server2 = { ui_string = "0.0.0.0" }
	dialup_number2 = { ui_string = "" }	// Standard earthlink
	dialup_number3 = { ui_string = "" }	// Standard earthlink
    signed_disclaimer = { ui_string = "No" checksum = boolean_false }
	profile_email = { ui_string = "" } 
	profile_password = { ui_string = "" }
	profile_password_confirm = { ui_string = "" }
	profile_success = { ui_string = "No" checksum = boolean_false }
	profile_warning_shown = { ui_string = "No" checksum = boolean_false }
	config_type = { ui_string = "Manual Settings" checksum = config_manual }
	unique_id = { ui_string = "123456789" }
	auto_brake = { ui_string = "On" checksum = boolean_true }
	show_names = { ui_string = "On" checksum = boolean_true }
	score_display = { ui_string = "Show Players" checksum = score_players }
    ctf_game_type = { ui_string = "Use Time Limit" checksum = timed_ctf }
    stop_at_zero = { ui_string = "No" checksum = boolean_false }
    face_dl_key = { ui_string = "" }
    fireball_difficulty = { ui_string = "3" checksum = num_3 fireball_level=3 }
    
	buddy_array = []
}

script launch_network_options_menu
	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_network_options_menu
endscript

script back_from_net_options_menu
    go_to_sub_menu = 0
	PauseMusicAndStreams
	if IsTrue InNetOptionsFromNetPlay
        printf "********************* InNetOptionsFromNetPlay *******************"
        go_to_sub_menu = 1
    else
        if IsTrue InNetOptionsFromFaceDownload
            printf "********************* InNetOptionsFromFaceDownload *******************"
            go_to_sub_menu = 1
        endif
    endif
    
    if( <go_to_sub_menu> = 1 )
		GetPreferenceChecksum pref_type=network device_type
	
		switch <checksum>
			case device_sony_modem
			case device_usb_modem
				GetPreferenceString pref_type=network dialup_number
				if( <ui_string> = "" )
                    if IsTrue InNetOptionsFromNetPlay
					    create_main_menu
                    else
                        face_back_from_net_setup
                    endif
				else
					FormatText TextName=msg_text "***** NOT EMPTY, WAS %s *****"  s=<ui_string>
					printf <msg_text>
					if ObjectExists id=current_menu_anchor
						DestroyScreenElement id=current_menu_anchor
					endif
                    if IsTrue InNetOptionsFromNetPlay
                        do_network_setup error_script=back_from_startup_error_dialog success_script=net_setup_from_net_play_successful need_setup_script=create_net_startup_need_setup_dialog
                    else
                        do_network_setup error_script=face_back_from_net_setup success_script=create_face_download_menu_from_net_setup need_setup_script=face_create_net_startup_need_setup_dialog
                    endif
				endif
			case device_none
				if IsTrue InNetOptionsFromNetPlay
                    create_main_menu
                else
                    face_back_from_net_setup
                endif
			default
				if ObjectExists id=current_menu_anchor
					DestroyScreenElement id=current_menu_anchor
				endif
                
                if IsTrue InNetOptionsFromNetPlay
                    do_network_setup error_script=back_from_startup_error_dialog success_script=net_setup_from_net_play_successful need_setup_script=create_net_startup_need_setup_dialog
                else
                    do_network_setup error_script=face_back_from_net_setup success_script=create_face_download_menu_from_net_setup need_setup_script=face_create_net_startup_need_setup_dialog
                endif
		endswitch
        change InNetOptionsFromNetPlay = 0
        change InNetOptionsFromFaceDownload = 0
		UnpauseMusicAndStreams
	else		
		launch_setup_options_menu	
		UnpauseMusicAndStreams
	endif
endscript

script create_network_options_menu
	
	
	KillSpawnedScript chap_new_rotating_bg
	KillSpawnedScript chap_new_rotating_bg_2
	
	GetPreferenceString pref_type=network unique_id
	if( <ui_string> = "123456789" )				 
		SetUniqueId
	endif
	
	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="NETWORK OPTIONS" title_icon=<title_icon>
    UnpauseMusicAndStreams
	if levelis load_skateshop
		build_top_and_bottom_blocks
		make_mainmenu_3d_plane
	endif
		
	create_helper_text=generic_helper_text pos=(225,109)
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps { id=sub_vmenu event_handlers=[
											{pad_back       generic_menu_pad_back params={ callback=back_from_net_options_menu}}
										 ]
						  } 
	
	theme_menu_add_item text = "Network Configuration" id=network_option_configuration pad_choose_script=maybe_change_current_net_settings highlight_bar_scale=(1.3, 1.3) centered
    GetPreferenceChecksum pref_type=network config_type
    	GetPreferenceString pref_type=network config_type
    	theme_menu_add_item text = <ui_string> font=dialog id=network_option_configuration_string rgba=[80 80 80 128] scale=0.8 not_focusable=not_focusable centered
  	switch <checksum>
	    case config_sony
			if IsPal
				theme_menu_add_item text = "Choose Configuration" id=network_option_load_config pad_choose_script=maybe_launch_load_net_config highlight_bar_scale=(1.3, 1.3) centered
			else
				theme_menu_add_item text = "Choose Combination" id=network_option_load_config pad_choose_script=maybe_launch_load_net_config highlight_bar_scale=(1.3, 1.3) centered
			endif
		case config_manual
		    theme_menu_add_item text = "Settings..." id=network_option_manual_setup pad_choose_script=launch_manual_net_setup centered
    endswitch
    
	theme_menu_add_item text = "Save Settings" id=network_option_save pad_choose_script=launch_save_network_settings centered
	theme_menu_add_item text = "Load Settings" id=network_option_load pad_choose_script=maybe_load_net_settings centered
	theme_menu_add_item text = "Done" id=network_option_done pad_choose_script=generic_menu_pad_choose pad_choose_params={callback=back_from_net_options_menu} centered last_menu_item=last_menu_item
	
    	// black box behind text
        CreateScreenElement {
    		type=SpriteElement
    		parent=network_option_configuration_string
            
    		texture=black
    		pos=(90,-15)
            rgba=[0 0 0 50]
    		scale=(75,5)
    		just=[center top]
    		z_priority=5
    	}
    	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
		id=bg_star
		
		texture=NE_star
		pos=(0,315)
		just=[left center]
		alpha=.15
		z_priority=-2
		scale=(1.0,1.3)
	}

	finish_themed_sub_menu
	
	if levelis load_skateshop
		CreateScreenElement {
			type=SpriteElement
			parent=current_menu_anchor
			id=so_rotating_bg
			
			texture=bg_vector_1
			rgba=[23 58 75 15]
			just=[center, center]
			pos=(210, 180)
			z_priority=-4
		}
		
		CreateScreenElement {
			type=SpriteElement
			parent=current_menu_anchor
			id=so_rotating_bg2
			
			texture=bg_vector_1
			rgba=[100 25 3 15]
			just=[center, center]
			pos=(210, 180)
			z_priority=-3
		}
		
		spawnscript chap_new_rotating_bg params={ id=so_rotating_bg scale=1.4 rot_angle=-5752 }
		spawnscript chap_new_rotating_bg_2 params={ id=so_rotating_bg2 scale=1.1 rot_angle=-5752 }
	endif
	
endscript

script maybe_load_net_settings
	if CanChangeDevices
		launch_load_network_settings
	else
		RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_net_load_refused_dialog
	endif
endscript

script maybe_change_current_net_settings
	if CanChangeDevices
		launch_configuration_choices_menu
	else
		RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_net_load_refused_dialog
	endif
endscript

script launch_configuration_choices_menu
    DestroyScreenElement id=current_menu_anchor
	
	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="NETWORK CONFIGURATION" title_icon=<title_icon> title_scale=1.7 skateshop_pos=(200,55)
    
    build_top_and_bottom_blocks
	make_mainmenu_3d_plane
	 
	create_helper_text=generic_helper_text 
	
	SetScreenElementProps id=sub_vmenu event_handlers=[ { pad_back		launch_network_options_menu } ]
	
	theme_menu_add_item text = "Your Network Configuration Files" id=network_config_load_config pad_choose_script=choose_sony_combination centered
	theme_menu_add_item text = "Manual Settings" id=network_option_manual_setup pad_choose_script=choose_manual_setup last_menu_item=last_menu_item centered
	
   CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
		id=bg_star
		
		texture=NE_star
		pos=(0,315)
		just=[left center]
		alpha=.15
		z_priority=-2
		scale=(1.0,1.3)
	}
	
    finish_themed_sub_menu
	
CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=so_rotating_bg
		
		texture=bg_vector_1
		rgba=[23 58 75 20]
		just=[center, center]
		pos=(210, 180)
		z_priority=-4
	}
	
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=so_rotating_bg2
		
		texture=bg_vector_1
		rgba=[100 25 3 20]
		just=[center, center]
		pos=(210, 180)
		z_priority=-3
	}
	
	spawnscript chap_new_rotating_bg params={ id=so_rotating_bg scale=1.4 rot_angle=-5752 }
	spawnscript chap_new_rotating_bg_2 params={ id=so_rotating_bg2 scale=1.1 rot_angle=-5752 }
endscript

script choose_sony_combination
	;set_preferences_from_ui prefs=network field="config_type" string="Sony Network Combination" checksum=config_sony
	launch_load_net_config
endscript

script choose_manual_setup
	GetPreferenceChecksum pref_type=network config_type
	switch <checksum>
		case config_sony
			clear_net_options
	endswitch
	set_preferences_from_ui prefs=network field="config_type" string="Manual Settings" checksum=config_manual
	launch_manual_net_setup
endscript

script clear_net_options	   
    set_preferences_from_ui prefs=network field="dialup_number" string=""
	set_preferences_from_ui prefs=network field="dialup_username" string=""
	set_preferences_from_ui prefs=network field="dialup_password" string=""
    set_preferences_from_ui prefs=network field="broadband_type" string="Auto-Detect (DHCP)" checksum = ip_dhcp
    set_preferences_from_ui prefs=network field="ip_address" string="192.168.0.10"
    set_preferences_from_ui prefs=network field="gateway" string="192.168.0.1"
    set_preferences_from_ui prefs=network field="subnet_mask" string="255.255.255.0"
    set_preferences_from_ui prefs=network field="dns_server" string="0.0.0.0"
    set_preferences_from_ui prefs=network field="dns_server2" string="0.0.0.0"
    set_preferences_from_ui prefs=network field="auto_dns" string="Yes" checksum = boolean_true
    set_preferences_from_ui prefs=network field="host_name" string=""
    set_preferences_from_ui prefs=network field="domain_name" string=""
    set_preferences_from_ui prefs=network field="dialup_authentication" string="Yes" checksum = boolean_true
endscript 

script maybe_launch_load_net_config
    if CanChangeDevices
		launch_load_net_config
	else
		RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_net_load_refused_dialog
	endif
endscript

script launch_load_net_config
	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=_CreationOptionsLoadNetConfig
endscript

script _CreationOptionsLoadNetConfig
SpawnScript CreationOptionsLoadNetConfig
endscript

script back_from_load_net_config
    memcard_menus_cleanup
	dialog_box_exit
	create_network_options_menu
endscript

script CreationOptionsLoadNetConfig


Change RetryScript=CreationOptionsLoadNetConfig
Change AbortScript=back_from_load_net_config
Change SavingOrLoading=Loading
check_card

/*
//SwitchOffMenu Id=net_network_setup_menu

//DisplayMessage MessageScript=Message_CheckingCard PauseLength=MemCardMessageShortPause
//SwitchToMenu DoNotMakeRoot menu=net_network_setup_menu
	create_dialog_box { title="Status" 
                        text="Checking for memory card"
                      }

if CardIsInSlot
else
	printf "No memory card found....."
	GotoPreserveParams PleaseInsertCard Params={ReturnScript=CreationOptionsLoadNetConfig AbortScript=create_network_options_menu}
endif
*/

    if LoadNetConfigs
		dialog_box_exit
		if NoNetConfigFiles
			create_error_box { title="None Found" 
								text="To create, edit or delete Your Network Configuration files please use the Network Access Disc."
								buttons=[ { text="ok" pad_choose_script=back_from_load_net_config } 
								]
							  }
			
		else
			create_load_net_config_menu
		endif    
	else
		dialog_box_exit
        if GotParam corrupt
            create_error_box { title=net_error_msg
    								text="This Your Network Configuration file is corrupt and cannot be used."
    								buttons=[ { text="ok" pad_choose_script=back_from_load_net_config } 
    								]
    							  }
        else
    		create_error_box { title=net_error_msg
    								text="Your Network Configuration file was created on another console and cannot be used."
    								buttons=[ { text="ok" pad_choose_script=back_from_load_net_config } 
    								]
    							  }
        endif
	endif
	
endscript

script choose_net_config
	ChooseNetConfig <...>
	launch_network_options_menu
endscript

script create_load_net_config_menu

	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])

	make_new_themed_sub_menu title="LOAD NETWORK CONFIGURATION" title_icon=<title_icon> title_scale=1.4 skateshop_pos=(230,55)
    
    build_top_and_bottom_blocks
	make_mainmenu_3d_plane
	
	create_helper_text=generic_helper_text
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps { id=sub_vmenu event_handlers=[
											{pad_back       launch_network_options_menu}
										 ]
						  } 
						  
	/*make_new_menu menu_id=network_options_load_config_menu vmenu_id=network_options_load_config_vmenu menu_title="LOAD CONFIG" pos=(120,109)
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps { id=network_options_load_config_vmenu event_handlers=[
											{pad_back       launch_network_options_menu}
										 ]
						  }*/ 
	
	FillNetConfigList
	//RunScriptOnScreenElement id=current_menu_anchor animate_in
	
	theme_menu_add_item text = "Cancel" scale=0.8 focus_script=main_theme_focus_noscale unfocus_script=main_theme_unfocus_noscale id=network_option_connection_done pad_choose_script=generic_menu_pad_choose pad_choose_params={callback=launch_network_options_menu} last_menu_item=last_menu_item centered
	
    finish_themed_sub_menu
	
endscript


script launch_manual_net_setup
	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_manual_net_setup
endscript

script create_manual_net_setup
	
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	if levelis load_skateshop
		make_new_themed_sub_menu title="NETWORK SETUP" title_icon=<title_icon>
	else
		make_new_themed_sub_menu title="NETWORK SETUP" title_icon=<title_icon> skateshop_pos=(135,55)
	endif
    
    if levelis load_skateshop
		build_top_and_bottom_blocks
		make_mainmenu_3d_plane
	endif
	
	create_helper_text=generic_helper_text
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps { id=sub_vmenu event_handlers=[
											{pad_back       launch_network_options_menu}
										 ]
						  } 
	
	GetPreferenceString pref_type=network network_id
	theme_menu_add_item text = "Online Player Name" id=network_option_player_name pad_choose_script=launch_onscreen_keyboard_from_setup_menu pad_choose_params={field="network_id" text=<ui_string> title="NETWORK PLAYER NAME" min_length=1 max_length=15} centered
	theme_menu_add_item text = <ui_string> font=dialog id=network_option_player_name_string rgba=[80 80 80 128] scale=0.8 not_focusable=not_focusable centered
	
    GetPreferenceChecksum pref_type=network device_type
	if ( <checksum> = device_none )
		GetPreferenceString pref_type=network device_type
		theme_menu_add_item text = "Hardware Setup" id=network_option_hardware_setup pad_choose_script=launch_hardware_setup centered
		theme_menu_add_item text = <ui_string> font=dialog id=network_option_hardware_setup_string rgba=[80 80 80 128] scale=0.7 not_focusable=not_focusable centered 
	else
		GetPreferenceString pref_type=network device_type
		theme_menu_add_item text = "Hardware Setup" id=network_option_hardware_setup pad_choose_script=launch_hardware_setup centered
		theme_menu_add_item text = <ui_string> font=dialog id=network_option_hardware_setup_string rgba=[80 80 80 128] scale=0.7 not_focusable=not_focusable centered
		
		GetPreferenceChecksum pref_type=network device_type
		theme_menu_add_item text = "Connection Settings" id=network_option_connection_settings pad_choose_script=launch_connection_settings centered
	endif
	
	theme_menu_add_item text = "Done" id=network_option_connection_done pad_choose_script=generic_menu_pad_choose pad_choose_params={callback=launch_network_options_menu} last_menu_item=last_menu_item centered
	
   if levelis load_skateshop
	   CreateScreenElement {
			type=spriteElement
			parent=current_menu_anchor
			id=bg_star
			
			texture=NE_star
			pos=(0,315)
			just=[left center]
			alpha=.15
			z_priority=-2
			scale=(1.0,1.3)
		}
		
		CreateScreenElement {
			type=SpriteElement
			parent=current_menu_anchor
			id=so_rotating_bg
			
			texture=bg_vector_1
			rgba=[23 58 75 15]
			just=[center, center]
			pos=(210, 180)
			z_priority=-4
		}
		
		CreateScreenElement {
			type=SpriteElement
			parent=current_menu_anchor
			id=so_rotating_bg2
			
			texture=bg_vector_1
			rgba=[100 25 3 15]
			just=[center, center]
			pos=(210, 180)
			z_priority=-3
		}
		
		spawnscript chap_new_rotating_bg params={ id=so_rotating_bg scale=1.4 rot_angle=-5752 }
		spawnscript chap_new_rotating_bg_2 params={ id=so_rotating_bg2 scale=1.1 rot_angle=-5752 }
	endif
	
	finish_themed_sub_menu
endscript

;script launch_save_network_settings
;	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=NetworkSetupMenuSave
;endscript

;script launch_load_network_settings
;	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=NetworkSetupMenuLoad
;endscript

script launch_onscreen_keyboard_from_setup_menu
    ;DestroyScreenElement id=current_menu_anchor
	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=pre_create_setup_onscreen_keyboard  callback_params={allow_cancel keyboard_cancel_script=net_setup_back_from_keyboard keyboard_done_script=set_connection_preference keyboard_title=<title> <...>}
endscript

script launch_onscreen_keyboard_from_ss_menu
	pulse_blur
    ;DestroyScreenElement id=current_menu_anchor
    create_onscreen_keyboard  { in_ss allow_cancel keyboard_cancel_script=ss_menu_back_from_keyboard keyboard_done_script=ss_set_connection_preference keyboard_title=<title> <...>}
endscript

script pre_create_setup_onscreen_keyboard
	create_onscreen_keyboard <...>
endscript

script launch_phone_entry
	launch_onscreen_keyboard <...> allowed_characters=[ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" "-" "," "*" "#" ]
endscript

script launch_email_keyboard
	//launch_onscreen_keyboard <...> allowed_characters=[ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" "." "@" "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q"]
	launch_onscreen_keyboard_from_profile_menu <...> allowed_characters=[ 	"1" "2" "3" "4" "5" "6" "7" "8" "9" "0"
																			"a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
																			"k" "l" "m" "n" "o" "p" "q" "r" "s" "t"
																			"u" "v" "w" "x" "y" "z"
																			"A" "B" "C" "D" "E" "F" "G" "H" "I" "J"
																			"K" "L" "M" "N" "O" "P" "Q" "R" "S" "T"
																			"U" "V" "W" "X" "Y" "Z"
																			"." "-" "_" "@" ]
endscript

script launch_ip_entry
	launch_onscreen_keyboard <...> allowed_characters=[ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" "."]
endscript

script launch_onscreen_keyboard
	;DestroyScreenElement id=current_menu_anchor
	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=pre_create_setup_onscreen_keyboard callback_params={allow_cancel keyboard_cancel_script=net_options_back_from_keyboard keyboard_done_script=set_manual_connection_preference keyboard_title=<title> <...>}
endscript

script back_from_hardware_setup_refused_dialog
	dialog_box_exit
	create_manual_net_setup
endscript

script back_from_load_refused_dialog
	dialog_box_exit
	create_network_options_menu
endscript

script launch_hardware_setup_refused_dialog
    RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_hardware_setup_refused_dialog
endscript

script create_hardware_setup_refused_dialog
	create_dialog_box { title=net_notice_msg
							text=net_error_cant_change_device
							buttons=[ { text="ok" pad_choose_script=back_from_hardware_setup_refused_dialog } 
                                ]
                      }
endscript 		

script create_net_load_refused_dialog
	create_dialog_box { title=net_notice_msg
							text=net_error_cant_load_settings
							buttons=[ { text="ok" pad_choose_script=back_from_load_refused_dialog } 
                                ]
                      }
endscript 

script launch_hardware_setup
    if CanChangeDevices
        RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_hardware_setup_menu
    else
        RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_hardware_setup_refused_dialog
        
    endif
endscript

script launch_connection_settings
	if ObjectExists id=current_menu_anchor
		RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_connection_settings
	else
        dialog_box_exit
		create_connection_settings
	endif
endscript

script create_connection_settings
	GetPreferenceChecksum pref_type=network device_type
	
	switch <checksum>
		case device_broadband_pc
		case device_broadband_usb
			create_ethernet_connection_settings_menu
		case device_broadband_pc_pppoe
		case device_broadband_usb_pppoe
			create_pppoe_connection_settings_menu
		default
			create_modem_connection_settings_menu
	endswitch
endscript

script launch_connection_type_sub_menu
	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_connection_type_sub_menu
endscript

script launch_connection_auto_dns_sub_menu
    if GotParam always_allow
        RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_connection_auto_dns_sub_menu
    else
        if CanChangeDevices
    		RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_connection_auto_dns_sub_menu
    	else
    		RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_hardware_setup_refused_dialog
    	endif
    endif
endscript

script launch_connection_use_auth_sub_menu
	RunScriptOnScreenElement id=current_menu_anchor menu_offscreen callback=create_connection_use_auth_sub_menu
endscript

script create_hardware_setup_menu
	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="HARDWARE SETUP" title_icon=<title_icon> skateshop_pos=(180,55)
    
	
	if levelis load_skateshop
		build_top_and_bottom_blocks
		make_mainmenu_3d_plane
	endif
	
	
    // Define pad_back event - go back to the pause menu
	SetScreenElementProps { id=sub_vmenu event_handlers=[
											{pad_back       launch_manual_net_setup}
										 ]
						  } 
	create_hardware_setup_device_sub_menu
	
	create_helper_text generic_helper_text
	
	if levelis load_skateshop
		createScreenElement { type=textElement parent=sub_menu font=dialog rgba=[60 60 60 100] text="* Most DSL users should select PPPoE devices" scale=0.7 pos=(250,250) }
	else
		createScreenElement { type=textElement parent=sub_menu font=dialog rgba=[60 60 60 100] text="* Most DSL users should select PPPoE devices" scale=0.7 pos=(250,275) }
	endif
	
	finish_themed_sub_menu
endscript

script create_ethernet_connection_settings_menu
    
	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="NETWORK SETUP" title_icon=<title_icon> skateshop_pos=(110,55)
    
    if levelis load_skateshop
		build_top_and_bottom_blocks
		make_mainmenu_3d_plane
	endif
	
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps { id=sub_vmenu event_handlers=[
											{pad_back       launch_manual_net_setup}
										 ]
						  }
	create_helper_text generic_helper_text						 

    GetPreferenceString pref_type=network broadband_type
	theme_menu_add_centered_item text = "Type" id=network_connection_type pad_choose_script=launch_connection_type_sub_menu 
	theme_menu_add_centered_item text = <ui_string> id=network_connection_connection_type_string rgba=[80 80 80 128] scale=0.8 not_focusable=not_focusable box_it_up=box_it_up
	
	GetPreferenceChecksum pref_type=network broadband_type
	if( <checksum> = ip_static )
		GetPreferenceString pref_type=network ip_address
		theme_menu_add_centered_item text = "IP Address" id=network_connection_ip pad_choose_script=launch_ip_entry pad_choose_params={field="ip_address" text=<ui_string> title="IP ADDRESS" min_length=7 max_length=15} 
		theme_menu_add_centered_item text = <ui_string> id=network_connection_ip_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
		
		GetPreferenceString pref_type=network gateway
		theme_menu_add_centered_item text = "Gateway" id=network_connection_gateway pad_choose_script=launch_ip_entry pad_choose_params={field="gateway" text=<ui_string> title="GATEWAY" min_length=7 max_length=15} 
		theme_menu_add_centered_item text = <ui_string> id=network_connection_gateway_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
		
		GetPreferenceString pref_type=network subnet_mask
		theme_menu_add_centered_item text = "Subnet Mask" id=network_connection_subnet pad_choose_script=launch_ip_entry pad_choose_params={field="subnet_mask" text=<ui_string> title="SUBNET MASK" min_length=7 max_length=15} 
		theme_menu_add_centered_item text = <ui_string> id=network_connection_subnet_mask_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
	else
		GetPreferenceString pref_type=network host_name
		theme_menu_add_centered_item text = "* Hostname" id=network_connection_hostname pad_choose_script=launch_onscreen_keyboard pad_choose_params={field="host_name" text=<ui_string> title="HOSTNAME" min_length=0 max_length=31} 
		theme_menu_add_centered_item text = <ui_string> id=network_connection_hostname_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
		
		GetPreferenceString pref_type=network auto_dns
		theme_menu_add_centered_item text = "Auto-Obtain DNS Servers?" id=network_connection_auto_dns pad_choose_script=launch_connection_auto_dns_sub_menu pad_choose_params={always_allow}
		theme_menu_add_centered_item text = <ui_string> id=network_connection_connection_auto_dns_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
	endif
	
	GetPreferenceChecksum pref_type=network auto_dns
	if( <checksum> = boolean_false )
		GetPreferenceString pref_type=network dns_server
		theme_menu_add_centered_item text = "DNS Server 1" id=network_connection_dns_1 pad_choose_script=launch_ip_entry pad_choose_params={field = "dns_server" text=<ui_string> title="DNS SERVER 1" min_length=7 max_length=15} 
		theme_menu_add_centered_item text = <ui_string> id=network_connection_dns1_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
		GetPreferenceString pref_type=network dns_server2
		theme_menu_add_centered_item text = "DNS Server 2" id=network_connection_dns_2 pad_choose_script=launch_ip_entry pad_choose_params={field = "dns_server2" text=<ui_string> title = "DNS SERVER 2" min_length=7 max_length=15} 
		theme_menu_add_centered_item text = <ui_string> id=network_connection_dns2_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
        
	endif
	
	GetPreferenceChecksum pref_type=network broadband_type
	if( <checksum> = ip_dhcp )
		;theme_menu_add_centered_item text="" not_focusable=not_focusable scale=0.7
		theme_menu_add_centered_item text = "* Required by some ISPs" id=hostname_footnote not_focusable=not_focusable rgba=[80 80 80 128] scale=0.7 
	endif
	
	theme_menu_add_centered_item text="Done" pad_choose_script=generic_menu_pad_choose pad_choose_params={callback=launch_manual_net_setup} last_menu_item=last_menu_item
	
	finish_themed_sub_menu
	
	if levelis load_skateshop
		CreateScreenElement {
			type=SpriteElement
			parent=current_menu_anchor
			id=so_rotating_bg
			
			texture=bg_vector_1
			rgba=[23 58 75 15]
			just=[center, center]
			pos=(210, 180)
			z_priority=-4
		}
		
		CreateScreenElement {
			type=SpriteElement
			parent=current_menu_anchor
			id=so_rotating_bg2
			
			texture=bg_vector_1
			rgba=[100 25 3 15]
			just=[center, center]
			pos=(210, 180)
			z_priority=-3
		}
		
		spawnscript chap_new_rotating_bg params={ id=so_rotating_bg scale=1.4 rot_angle=-5752 }
		spawnscript chap_new_rotating_bg_2 params={ id=so_rotating_bg2 scale=1.1 rot_angle=-5752 }
	endif
endscript

script create_pppoe_connection_settings_menu
	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="CONNECTION SETTINGS" title_icon=<title_icon> skateshop_pos=(110,55)
    
    build_top_and_bottom_blocks
	make_mainmenu_3d_plane
	
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps { id=sub_vmenu event_handlers=[
											{pad_back       launch_manual_net_setup}
										 ]
						  }
	create_helper_text generic_helper_text
						  
    GetPreferenceString pref_type=network dialup_username
	theme_menu_add_centered_item text = "Username" id=network_connection_username pad_choose_script=launch_onscreen_keyboard pad_choose_params={field="dialup_username" text=<ui_string> title="USERNAME" min_length=1 max_length=47} 
	theme_menu_add_centered_item text = <ui_string> id=network_connection_connection_username_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
	
	GetPreferenceString pref_type=network dialup_password
	GetPreferencePassword pref_type=network dialup_password
	theme_menu_add_centered_item text = "Password" id=network_connection_password pad_choose_script=launch_onscreen_keyboard pad_choose_params={field="dialup_password" text=<ui_string> title="PASSWORD" min_length=1 max_length=47 password} 
	theme_menu_add_centered_item text = <password_string> id=network_connection_password_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
	
	GetPreferenceChecksum pref_type=network auto_dns
	GetPreferenceString pref_type=network auto_dns
	theme_menu_add_centered_item text = "Auto-Obtain DNS Servers?" id=network_connection_auto_dns pad_choose_script=launch_connection_auto_dns_sub_menu pad_choose_params={always_allow}
	theme_menu_add_centered_item text = <ui_string> id=network_connection_connection_auto_dns_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
	
    if( <checksum> = boolean_false )
		GetPreferenceString pref_type=network dns_server
        theme_menu_add_centered_item text = "DNS Server 1" id=network_connection_dns_1 pad_choose_script=launch_onscreen_keyboard pad_choose_params={field = "dns_server" text=<ui_string> title="DNS SERVER 1" min_length=7 max_length=15} 
        theme_menu_add_centered_item text = <ui_string> id=network_connection_dns1_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
        
    	GetPreferenceString pref_type=network dns_server2
        theme_menu_add_centered_item text = "DNS Server 2" id=network_connection_dns_2 pad_choose_script=launch_onscreen_keyboard pad_choose_params={field = "dns_server2" text=<ui_string> title = "DNS SERVER 2" min_length=7 max_length=15} 
        theme_menu_add_centered_item text = <ui_string> id=network_connection_dns2_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
    endif
	
	theme_menu_add_centered_item text="" not_focusable=not_focusable last_menu_item=last_menu_item
	finish_themed_sub_menu
	
CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=so_rotating_bg
		
		texture=bg_vector_1
		rgba=[23 58 75 15]
		just=[center, center]
		pos=(210, 180)
		z_priority=-4
	}
	
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=so_rotating_bg2
		
		texture=bg_vector_1
		rgba=[100 25 3 15]
		just=[center, center]
		pos=(210, 180)
		z_priority=-3
	}
	
	spawnscript chap_new_rotating_bg params={ id=so_rotating_bg scale=1.4 rot_angle=-5752 }
	spawnscript chap_new_rotating_bg_2 params={ id=so_rotating_bg2 scale=1.1 rot_angle=-5752 }
endscript

script create_modem_connection_settings_menu
	FormatText ChecksumName=title_icon "%i_options" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="CONNECTION SETTINGS" title_icon=<title_icon> skateshop_pos=(110,55)
    
    build_top_and_bottom_blocks
	make_mainmenu_3d_plane
	
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps { id=sub_vmenu event_handlers=[
											{pad_back       launch_manual_net_setup}
										 ]
						  }
	create_helper_text generic_helper_text
	
	GetPreferenceChecksum pref_type=network auto_dns
	if( <checksum> = boolean_false )
		scale=1.0
	else
		scale=0.8
	endif
						  
    GetPreferenceString pref_type=network dialup_number
	theme_menu_add_centered_item text = "ISP Phone Number" id=network_connection_isp_phone pad_choose_script=launch_phone_entry pad_choose_params={field="dialup_number" text=<ui_string> title="ISP PHONE NUMBER" min_length=7 max_length=20} 
	theme_menu_add_centered_item text = <ui_string> id=network_connection_connection_isp_phone_string rgba=[80 80 80 128] scale=<scale> font=dialog not_focusable=not_focusable box_it_up=box_it_up
	
	;GetPreferenceString pref_type=network dialup_number2
	;theme_menu_add_centered_item text = "ISP Phone Number 2" id=network_connection_isp2_phone pad_choose_script=launch_phone_entry pad_choose_params={field="dialup_number2" text=<ui_string> title="ISP PHONE NUMBER 2" min_length=7 max_length=20} highlight_bar_scale=(1.62, 1.3) scale=0.5
	;theme_menu_add_centered_item text = <ui_string> id=network_connection_connection_isp2_phone_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
	
	;GetPreferenceString pref_type=network dialup_number3
	;theme_menu_add_centered_item text = "ISP Phone Number 3" id=network_connection_isp3_phone pad_choose_script=launch_phone_entry pad_choose_params={field="dialup_number3" text=<ui_string> title="ISP PHONE NUMBER 3" min_length=7 max_length=20} highlight_bar_scale=(1.62, 1.3)
	;theme_menu_add_centered_item text = <ui_string> id=network_connection_connection_isp3_phone_string rgba=[80 80 80 128] scale=0.8 font=dialog not_focusable=not_focusable box_it_up=box_it_up
	
	GetPreferenceString pref_type=network dialup_username
	theme_menu_add_centered_item text = "Username" id=network_connection_username pad_choose_script=launch_onscreen_keyboard pad_choose_params={field="dialup_username" text=<ui_string> title="USERNAME" min_length=1 max_length=36} 
	theme_menu_add_centered_item text = <ui_string> id=network_connection_connection_username_string rgba=[80 80 80 128] scale=<scale> font=dialog not_focusable=not_focusable box_it_up=box_it_up
	
	GetPreferenceString pref_type=network dialup_password
	GetPreferencePassword pref_type=network dialup_password
	theme_menu_add_centered_item text = "Password" id=network_connection_password pad_choose_script=launch_onscreen_keyboard pad_choose_params={field="dialup_password" text=<ui_string> title="PASSWORD" min_length=1 max_length=36 password} 
	theme_menu_add_centered_item text = <password_string> id=network_connection_password_string rgba=[80 80 80 128] scale=<scale> font=dialog not_focusable=not_focusable box_it_up=box_it_up
    
	GetPreferenceChecksum pref_type=network dialup_authentication
	GetPreferenceString pref_type=network dialup_authentication
	theme_menu_add_centered_item text = "Use Authentication?" id=network_connection_use_auth pad_choose_script=launch_connection_use_auth_sub_menu 
	theme_menu_add_centered_item text = <ui_string> id=network_connection_use_auth_string rgba=[80 80 80 128] scale=<scale> font=dialog not_focusable=not_focusable box_it_up=box_it_up
	
	GetPreferenceString pref_type=network auto_dns
	theme_menu_add_centered_item text = "Auto-Obtain DNS Servers?" id=network_connection_auto_dns pad_choose_script=launch_connection_auto_dns_sub_menu
	theme_menu_add_centered_item text = <ui_string> id=network_connection_connection_auto_dns_string rgba=[80 80 80 128] scale=<scale> font=dialog not_focusable=not_focusable box_it_up=box_it_up
    
	GetPreferenceChecksum pref_type=network auto_dns
	if( <checksum> = boolean_false )
		GetPreferenceString pref_type=network dns_server
        if CanChangeDevices
        	theme_menu_add_centered_item text = "DNS Server 1" id=network_connection_dns_1 pad_choose_script=launch_ip_entry pad_choose_params={field = "dns_server" text=<ui_string> title="DNS SERVER 1" min_length=7 max_length=15}
        else
            theme_menu_add_centered_item text = "DNS Server 1" id=network_connection_dns_1 pad_choose_script=launch_hardware_setup_refused_dialog
        endif
        	theme_menu_add_centered_item text = <ui_string> id=network_connection_dns1_string rgba=[80 80 80 128] scale=<scale> font=dialog not_focusable=not_focusable box_it_up=box_it_up
        
        	GetPreferenceString pref_type=network dns_server2
        if CanChangeDevices
        	theme_menu_add_centered_item text = "DNS Server 2" id=network_connection_dns_2 pad_choose_script=launch_ip_entry pad_choose_params={field = "dns_server2" text=<ui_string> title = "DNS SERVER 2" min_length=7 max_length=15}
        else
            theme_menu_add_centered_item text = "DNS Server 2" id=network_connection_dns_2 pad_choose_script=launch_hardware_setup_refused_dialog
        endif
        	theme_menu_add_centered_item text = <ui_string> id=network_connection_dns2_string rgba=[80 80 80 128] scale=<scale> font=dialog not_focusable=not_focusable box_it_up=box_it_up
		
		DoScreenElementMorph id=sub_vmenu scale=0.85 pos=(100,60)
	endif
		
    theme_menu_add_centered_item text="" not_focusable=not_focusable last_menu_item=last_menu_item
	finish_themed_sub_menu
	
CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=so_rotating_bg
		
		texture=bg_vector_1
		rgba=[23 58 75 15]
		just=[center, center]
		pos=(210, 180)
		z_priority=-4
	}
	
	CreateScreenElement {
		type=SpriteElement
		parent=current_menu_anchor
		id=so_rotating_bg2
		
		texture=bg_vector_1
		rgba=[100 25 3 15]
		just=[center, center]
		pos=(210, 180)
		z_priority=-3
	}
	
	spawnscript chap_new_rotating_bg params={ id=so_rotating_bg scale=1.4 rot_angle=-5752 }
	spawnscript chap_new_rotating_bg_2 params={ id=so_rotating_bg2 scale=1.1 rot_angle=-5752 }
endscript

script select_connection_option
    set_preferences_from_ui <...>
	if( <checksum> = ip_static )
		set_preferences_from_ui prefs=<prefs> field="auto_dns" checksum=boolean_false string="No"
	else
		if( <checksum> = ip_dhcp )
			set_preferences_from_ui prefs=<prefs> field="auto_dns" checksum=boolean_true string="Yes"
		endif
	endif
    launch_connection_settings
endscript

script select_hardware_option
    set_preferences_from_ui <...>
    launch_manual_net_setup
endscript

script create_hardware_setup_sub_menu
    generic_array_menu_setup <...>
endscript

script create_connection_setup_sub_menu
    make_new_menu menu_id=connection_setup_sub_menu vmenu_id=conection_setup_sub_vmenu <...>
    // Define pad_back event - go back to the pause menu
    SetScreenElementProps { id=connection_setup_sub_menu event_handlers=[
                                            {pad_back       launch_connection_settings }
                                         ]
                          } 
    generic_array_menu_setup <...>
    
    RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
endscript


script create_hardware_setup_device_sub_menu
	;RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
	if IsPal
		create_hardware_setup_sub_menu pref_type=network pref_field="device_type" array=device_types_pal call_script=select_hardware_option highlight_bar_scale=<highlight_bar_scale> scale=<scale>
	else
		create_hardware_setup_sub_menu pref_type=network pref_field="device_type" array=device_types call_script=select_hardware_option highlight_bar_scale=<highlight_bar_scale> scale=<scale>
	endif
endscript

script create_connection_type_sub_menu
    ;create_connection_setup_sub_menu menu_title="TYPE" pref_type=network pref_field="broadband_type" array=broadband_types call_script=select_connection_option
	menu_title="Connection Type"
	pref_type=network 
	pref_field="broadband_type" 
	array=broadband_types 
	call_script=select_connection_option
	
	create_dialog_box {	title=<menu_title>
						text="Which type of connection do you use?"
                        buttons=[  { text="Auto-Detect (DHCP)" pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string="Auto-Detect (DHCP)" checksum=ip_dhcp <...> } }
								   { text="Static IP Address" pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string="Static IP Address" checksum=ip_static <...> } } 
								]
					  }
endscript

script create_connection_auto_dns_sub_menu
	;create_connection_setup_sub_menu menu_title="AUTO OBTAIN DNS SERVERS?" pref_type=network pref_field="auto_dns" array=boolean_types call_script=select_connection_option pos=(80,109)
	menu_title="DNS Servers"
	pref_type=network
	pref_field="auto_dns" 
	array=boolean_types 
	call_script=select_connection_option 
    
	create_dialog_box {	title=<menu_title>
						text="Do you want to auto obtain DNS servers?"
                        buttons=[  { text="Yes" pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string="Yes" checksum=boolean_true <...> } }
								   { text="No" pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string="No" checksum=boolean_false <...> } } 
								]
					  }
endscript

script create_connection_use_auth_sub_menu
	;create_connection_setup_sub_menu menu_title="USE AUTHENTICATION?" pref_type=network pref_field="dialup_authentication" array=boolean_types call_script=select_connection_option
	menu_title="Authentication" 
	pref_type=network 
	pref_field="dialup_authentication" 
	array=boolean_types 
	call_script=select_connection_option
	
	create_dialog_box {	title=<menu_title>
						text="Use authentication?"
                        buttons=[  { text="Yes" pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string="Yes" checksum=boolean_true <...> } }
								   { text="No" pad_choose_script=<call_script> pad_choose_params={ prefs=<pref_type> field=<pref_field> string="No" checksum=boolean_false <...> } } 
								]
					  }
endscript        

script set_connection_preference
	GetTextElementString id=keyboard_current_string
    set_preferences_from_ui prefs=network <...>
	destroy_onscreen_keyboard
    create_manual_net_setup 
endscript

script ss_set_connection_preference
	GetTextElementString id=keyboard_current_string
    set_preferences_from_ui prefs=network <...>
	destroy_onscreen_keyboard
    launch_ss_menu
endscript

script set_manual_connection_preference
	GetTextElementString id=keyboard_current_string
    set_preferences_from_ui prefs=network <...>
	destroy_onscreen_keyboard
    create_connection_settings
endscript

script net_options_back_from_keyboard
	destroy_onscreen_keyboard
	create_connection_settings
endscript

script net_setup_back_from_keyboard
	destroy_onscreen_keyboard
	create_manual_net_setup
endscript

script ss_menu_back_from_keyboard
	destroy_onscreen_keyboard
	launch_ss_menu no_animate
endscript

script back_from_startup_error_dialog
    UnPauseMusicAndStreams
    printf "**** in back_from_startup_error_dialog"
	dialog_box_exit
	
	if ObjectExists id=select_skater_anchor
		DestroyScreenElement id=select_skater_anchor
		restore_start_key_binding
	endif
	
    Skater:Obj_MoveToNode name=trg_playerrestart Orient NoReset
	Skater:CancelRotateDisplay
	
	create_main_menu
endscript

script create_net_startup_error_dialog
    create_dialog_box { title=net_error_msg
						text=<text>
                        buttons=[ { text="ok" pad_choose_script=<error_script> }
                                ]
                      }
endscript

script go_to_connection_setup_from_dialog
	dialog_box_exit
	change InNetOptionsFromNetPlay = 1
    change InNetOptionsFromFaceDownload = 0
	create_network_options_menu
endscript

script create_net_startup_need_setup_dialog

	
	
    printf "**** in create_net_startup_need_setup_dialog"
	create_dialog_box { title=net_status_msg
						text=<text>
                        buttons=[ { text=" Yes " pad_choose_script=go_to_connection_setup_from_dialog } 
									{ text=" No " pad_choose_script=<error_script> }// back_from_startup_error_dialog } 
                                ]
                      }
endscript

script create_testing_network_settings_dialog
	create_dialog_box { title=net_status_msg
						text=net_status_testing_settings
                      }
endscript
