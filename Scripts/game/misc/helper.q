/*script helper_set_positions y=410 x1=45 w1=100 x2=160 w2=100 x3=270 w3=80
MoveMenu Id=helper_menu_1 x=<x1> y=<y> w=<w1>
MoveMenu Id=helper_menu_2 x=<x2> y=<y> w=<w2>
MoveMenu Id=helper_menu_3 x=<x3> y=<y> w=<w3>
MoveMenu Id=helper_menu_4 x=<x4> y=<y> w=<w4>
endscript

script helper_show
FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
FireMenuEvent Type=SHOW Id=helper_menu_3 target=helper_menu_3
endscript

script helper_hide
FireMenuEvent Type=HIDE Id=helper_menu_1 target=helper_menu_1
FireMenuEvent Type=HIDE Id=helper_menu_2 target=helper_menu_2
FireMenuEvent Type=HIDE Id=helper_menu_3 target=helper_menu_3
FireMenuEvent Type=HIDE Id=helper_menu_4 target=helper_menu_4
endscript

script helper_park_editor_building
helper_hide
helper_show
helper_set_positions x1=45 x2=220 x3=400 
SetMenuElementText Id=helper_menu_1 "L1/L2 Raise/Lower"
SetMenuElementText Id=helper_menu_2 "D-Pad change piece"
SetMenuElementText Id=helper_menu_3 "м place piece"
FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
MoveMenu Id=helper_menu_4 x=515 y=410 w=80
SetMenuElementText Id=helper_menu_4 "к erase"

FireMenuEvent Type=SHOW Id=helper_menu_5 target=helper_menu_5
MoveMenu Id=helper_menu_5 x=565 y=75 w=80
SetMenuElementText Id=helper_menu_5 "full"

FireMenuEvent Type=SHOW Id=helper_menu_6 target=helper_menu_6
MoveMenu Id=helper_menu_6 x=565 y=390 w=80
SetMenuElementText Id=helper_menu_6 "empty"
endscript

script helper_select_choose_back
helper_show
helper_set_positions <...>
SetMenuElementText Id=helper_menu_1 "бе Select"
SetMenuElementText Id=helper_menu_2 "м Accept"
SetMenuElementText Id=helper_menu_3 "к Back"
endscript

; Used by the mem-card files menu, when being used for saving.
script helper_select_choose_back_delete
helper_show
helper_set_positions x1=122 x2=237 x3=347
SetMenuElementText Id=helper_menu_1 "бе Select"
SetMenuElementText Id=helper_menu_2 "м Accept"
SetMenuElementText Id=helper_menu_3 "к Back"

FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
MoveMenu Id=helper_menu_4 x=450 y=410 w=80
SetMenuElementText Id=helper_menu_4 "й Delete"
endscript

script helper_select_choose_rotate_back x1=67 x2=192 x3=345 x4=480
// added by SP
printf "launching helper text helper_select_choose_rotate_back ------------------"
helper_show
helper_set_positions <...> 
SetMenuElementText Id=helper_menu_1 "бе Select"
SetMenuElementText Id=helper_menu_2 "м Accept"
SetMenuElementText Id=helper_menu_3 "й/л Rotate Skater"
FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
SetMenuElementText Id=helper_menu_4 "к Back"
//square tri circle x = йклм
// This helper script is called in many different places
// But if called by the pre_cas_main_menu (a member of SelectChooseBackRotateMenus)
// Then we wait for it to disappear and return to the helper scanner 
if MenuIsShown SelectChooseBackRotateMenus
	WaitForMenuToDisappear SelectChooseBackRotateMenus
endif 
endscript


script helper_select_lr_choose_back_centered
helper_show
helper_set_positions x1=25 x2=120 x3=452 x4=230
SetMenuElementText Id=helper_menu_1 "м Accept" 
SetMenuElementText Id=helper_menu_2 "к Back"
SetMenuElementText Id=helper_menu_3 "з Change Skater г"
FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
SetMenuElementText Id=helper_menu_4 "й/л Rotate Skater" 
endscript


script helper_select_toggle_back
helper_show
helper_set_positions x1=100 x2=270 x3=430
SetMenuElementText Id=helper_menu_1 "бе Select"
SetMenuElementText Id=helper_menu_2 "м Toggle/Accept"
SetMenuElementText Id=helper_menu_3 "к Back"
endscript

script helper_leftrightselect_choose_back
helper_show
helper_set_positions <...>
SetMenuElementText Id=helper_menu_1 "зг Select"
SetMenuElementText Id=helper_menu_2 "м Accept"
SetMenuElementText Id=helper_menu_3 "к Back"
endscript

script helper_level_select
helper_hide
helper_show
helper_set_positions x1=170 x2=285 x3=395
SetMenuElementText Id=helper_menu_1 "зг Select"
SetMenuElementText Id=helper_menu_2 "м Accept"
SetMenuElementText Id=helper_menu_3 "к Back"
if TestRequestedGameType Career
else
	helper_set_positions x1=70 x2=190 x3=450 x4=290
	FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
	SetMenuElementText Id=helper_menu_4 "бе Records"  //зг
endif
//FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
//MoveMenu Id=helper_menu_4 x=495 y=410 w=80
//SetMenuElementText Id=helper_menu_4 "й goals"
endscript

script helper_pro_leftright
FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
MoveMenu Id=helper_menu_4 x=465 y=410 w=80
SetMenuElementText Id=helper_menu_4 "з Change Skater г"

endscript

; This is not called from the spawned script, but is called from Skater_RecordsDisplay
; in optionsmenu.q
; This is because the level records are not drawn as a single menu, so can't be checked
; for using MenuIsShown
script helper_level_records
helper_hide
FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
SetMenuElementText Id=helper_menu_1 "зе Select бг"
SetMenuElementText Id=helper_menu_2 "к Back"
helper_set_positions x1=130 x2=350
endscript

// This is for when the 'please insert card' message is on screen.
script helper_please_insert_card
helper_hide
FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
SetMenuElementText Id=helper_menu_1 "к Back"
MoveMenu Id=helper_menu_1 x=270 y=410
endscript

// This script is for when the left-side menu is selected
// (The button combos)
script helper_on_trick_right_menu
	helper_hide
	FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
	FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
	FireMenuEvent Type=SHOW Id=helper_menu_3 target=helper_menu_3
	SetMenuElementText Id=helper_menu_1 "бе Select"
	SetMenuElementText Id=helper_menu_2 "м Choose Button Combo"
	SetMenuElementText Id=helper_menu_3 "к Back"
	helper_set_positions x1=80 x2=270 x3=450
	if InFrontEnd
		WaitForMenuToDisappear trick_right_menu
	endif
endscript

// This script is for when the right-side menu is selected
// (The available tricks)
script helper_on_trick_available_menu
	printf "helper_on_trick_available_menu"
	helper_hide
	FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
	FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
	FireMenuEvent Type=SHOW Id=helper_menu_3 target=helper_menu_3
	SetMenuElementText Id=helper_menu_1 "бе Select"
	SetMenuElementText Id=helper_menu_2 "м Choose Trick"
	SetMenuElementText Id=helper_menu_3 "к Back"
//	helper_set_positions x1=130 x2=350 x3=420
	if InFrontEnd
		WaitForMenuToDisappear trick_available_menu
	endif
endscript

// This script is for when the main page of the specials menu is visible
script helper_on_special_trickname_menu
	printf "helper_on_special_trickname_menu"
	helper_hide
	FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
	FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
	FireMenuEvent Type=SHOW Id=helper_menu_3 target=helper_menu_3
	FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
	SetMenuElementText Id=helper_menu_1 "бе Select"
	SetMenuElementText Id=helper_menu_2 "м Choose Trick Slot"
	SetMenuElementText Id=helper_menu_3 "й Unassign Trick"
	SetMenuElementText Id=helper_menu_4 "к Back"
	helper_set_positions x1=25 x2=180 x3=380 x4=480
	if InFrontEnd
		WaitForMenuToDisappear special_trickname_menu
	endif
endscript

// This script is for when the second page of the specials menu is visible
// (choosing a special trick)
script helper_on_available_specials_menu
	helper_hide
	FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
	FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
	FireMenuEvent Type=SHOW Id=helper_menu_3 target=helper_menu_3
	SetMenuElementText Id=helper_menu_1 "бе Select"
	SetMenuElementText Id=helper_menu_2 "м Choose Special Trick"
	SetMenuElementText Id=helper_menu_3 "к Back"
	helper_set_positions x1=80 x2=270 x3=450
	if InFrontEnd
		WaitForMenuToDisappear available_specials_menu callback=check_for_trickslots_menu
	endif
endscript

// This script allows us to break out of the available specials
// menu...  I couldn't wait for the menu to disappear, because
// it's possible to go to another menu while the available
// specials is still visible, and for some reason the
// WaitForMenuToDeselect didn't work as I had expected...
script check_for_trickslots_menu
	if MenuIsShown available_trickslots_menu
		goto helper_on_available_trickslots_menu
	endif
endscript

// This script is for when the third page of the specials menu is visible
// (choosing a button combo)
script helper_on_available_trickslots_menu
	helper_hide
	FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
	FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
	FireMenuEvent Type=SHOW Id=helper_menu_3 target=helper_menu_3
	SetMenuElementText Id=helper_menu_1 "бе Select"
	SetMenuElementText Id=helper_menu_2 "м Choose Button Combo"
	SetMenuElementText Id=helper_menu_3 "к Back"
	helper_set_positions x1=80 x2=270 x3=450
	if InFrontEnd
		WaitForMenuToDisappear available_trickslots_menu
	endif
endscript

SelectChooseBackMenus=
[
    pre_trick_menu
]

SelectChooseBackRotateMenus =
[
    pre_cas_main_menu
    career_menu
    single_session_menu
    free_skate_menu
    player_one_menu
	net_type_menu	
	create_new_warning
]


SelectChooseBackCenteredMenus =
[
	palmer_warning
	net_pppoe_setup_menu
	net_broadband_setup_menu
	net_device_type_menu
	net_dialup_setup_menu
	net_advanced_menu
	net_dialup_authentication_control
	net_options_use_defaults_menu
	options_main_menu
    net_network_setup_menu
    cdsound_menu
    cdso_menu
    movies_menu
    controller_config_menu
]

CasSelectChooseBackMenus=
[
    cas_push_menu
    cas_stance_menu
    cas_sex_menu
    heads_menu
    hair_menu
    jaws_menu
    hats_menu
    hat_logos_menu
    glasses_menu
    torsos_menu
    front_logos_menu
    back_logos_menu
    backpacks_menu
    accessories_menu
    legs_menu
    socks_menu
    shoes_menu
    helmets_menu
    helmet_logos_menu
    elbowpads_menu
    kneepads_menu
]

CasChangeBackMenus=
[
    cas_age_menu
    cas_height_menu
    cas_weight_menu
    hair_hsv_menu
    hats_hsv_menu
    jaws_hsv_menu
    torsos_hsv_menu
    backpacks_hsv_menu
    legs_hsv_menu
    helmets_hsv_menu
    elbowpads_hsv_menu
    kneepads_hsv_menu
]

SelectChooseBackChangeMenus=
[
]

// need to special case the in-game keyboard controls,
// because they don't use the helper scanner
// function
KeyboardControlMenus=
[
	cas_name_keyboard_control			// frontend only
	cas_hometown_keyboard_control		// frontend only
	cheat_keyboard_control				// frontend only
	net_password_control				// frontend only
	net_ip_address_control				// frontend only
	net_gateway_control					// frontend only
	net_network_id_control				// frontend only
	net_server_name_control				// frontend only
	net_dialup_number_control			// frontend only
	net_dialup_username_control			// frontend only
	net_dialup_password_control			// frontend only
	net_subnet_control					// frontend only
	net_dns_control						// frontend only
	net_dns_control2					// frontend only
	net_host_name_control				// frontend only
	net_domain_name_control				// frontend only

	// also uses the helper_scanner:
	gapname_keyboard_control			// parkeditor only

	// doesn't use the helper_scanner...  instead,
	// there's a showeventhandler in the keyboard control
//	chat_message_control				// ingame only
//	kb_chat_message_control				// ingame only
//	horse_keyboard_control				// ingame only
//	initials_keyboard_control			// ingame only
//	opts_net_password_control			// ingame only
//	opts_net_server_name_control		// ingame only

	mem_card_keyboard_control			
	park_editor_keyboard_control		
    
    sfx_menu
]

// You're not allowed to go back from these menus
// so you only get select/accept choices
KeyboardControlLinearMenus=
[
	enter_password_control				// frontend only
]

ToggleChooseBackMenus=
[
    controller_config_1
    controller_config_2
    playlist_menu
]

script helper_scanner
helper_hide

begin
    ;printf random (@"Scanner" @" Scanner")
    if MenuIsSelected rr
        goto helper_on_server_list
    endif
    
    if MenuIsShown cassette_menu
        goto helper_on_cassette_menu
    endif    

    if MenuIsShown SelectChooseBackMenus
        goto helper_on_main_menu
    endif 
	
    if MenuIsShown frontend_menu
        goto helper_on_fe_menu
    endif 	   

    if MenuIsShown SelectChooseBackRotateMenus
        goto helper_select_choose_rotate_back
    endif 
    
	if MenuIsShown SelectChooseBackCenteredMenus
        goto helper_on_main_menu_centered
    endif

    if istrue MemCardYesNoMenuVisible
        goto helper_on_mem_card_yes_no
    endif
    
    if istrue AutoLoadRetryContinueVisible
        goto helper_on_autoload_retry_continue
    endif
        
    if MenuIsShown memcard_files_menu
        goto helper_on_mem_card_files_menu
    endif
            
	if MenuIsShown pro_menu 
        goto helper_on_pro_menu
    endif

	if MenuIsShown KeyboardControlMenus
		goto helper_on_keyboard_control
	endif

	if MenuIsShown KeyboardControlLinearMenus
		goto helper_on_keyboard_control_linear
	endif

    if MenuIsShown cas_menu_container
        if MenuIsShown CasSelectChooseBackMenus
            goto helper_on_cas_select_choose_back
        endif    
    
        if MenuIsShown CasChangeBackMenus
            helper_on_cas_change_back
            WaitForMenuToDisappear CasChangeBackMenus
        endif    
    
        if MenuIsShown cas_stats_menu
            if MenuIsSelected cas_left_container
            else
                helper_on_cas_select_change_back
                WaitForMenuToSelect cas_left_container
            endif    
        endif
        
        if MenuIsShown cas_multi_menu
            goto helper_on_cas_select_choose_back_4_arrows
        endif    
    endif
        
    if MenuIsShown SelectChooseBackChangeMenus
        goto helper_on_career_menu
    endif    

    if MenuIsShown ToggleChooseBackMenus
        goto helper_on_controller_config_menus
    endif    

    if MenuIsShown player_two_menu
        goto helper_on_player_two_menu
    endif    
    
    if MenuIsShown boardshop_menu
        goto helper_on_boardshop_menu
    endif

    if MenuIsShown wheel_color_menu        
        goto helper_on_wheel_color_menu
    endif
    
    if MenuIsShown deck_menu
        goto helper_on_deck_menu
    endif

	if MenuIsSelected trick_menu_container
		if MenuIsShown trick_right_menu
			goto helper_on_trick_right_menu
		endif

		if MenuIsShown trick_available_menu
			goto helper_on_trick_available_menu
		endif

		if MenuIsShown special_trickname_menu
//			printf "going to helper_on_special_trickname_menu"
			goto helper_on_special_trickname_menu
		endif

		if MenuIsShown available_specials_menu
//			printf "going to helper_on_available_trickslots_menu"
			goto helper_on_available_specials_menu
		endif
    endif

    if MenuIsShown ParkEditorMenus
        goto helper_on_park_editor_select_choose_back_centered
    endif    

    wait 1 gameframe
repeat
endscript

script helper_on_cassette_menu
begin
    if SkaterCamAnimHeld skater=0
        helper_level_select
        break
    endif
    wait 1 gameframe
repeat
begin
    if MenuIsShown cassette_menu
        if SkaterCamAnimHeld skater=0
        else
            goto helper_scanner
        endif    
    else
        goto helper_scanner
    endif    
    wait 1 gameframe
repeat
        
endscript

script WaitForMenuToDisappear
begin

	// GJ:  handle any special-cases here
	// such as the weird menu-switching
	// in the special trick editor
	if GotParam callback
		<callback>
	endif

    ;printf Random(@"WaitForMenuToDisappear" @" WaitForMenuToDisappear")
    if MenuIsShown <...>
    else
        goto helper_scanner
    endif
    wait 1 gameframe
repeat
endscript

script WaitForMenuToSelect
begin
    if MenuIsSelected <...>
        goto helper_scanner
    endif
    wait 1 gameframe
repeat
endscript

script WaitForMenuToDeSelect
begin
    if MenuIsSelected <...>
    else
        goto helper_scanner    
    endif
    wait 1 gameframe
repeat
endscript

script helper_on_main_menu
helper_hide

// If it's the player 2 trick menu, move the helper text over to the right, because
// the menu will be on the right.
if MenuIsShown pre_trick_menu
    if CurrentSkaterProfileIs 1
        helper_select_choose_back x1=295 x2=410 x3=520
    else
        helper_select_choose_back
    endif
else
    helper_select_choose_back
endif        

WaitForMenuToDisappear SelectChooseBackMenus
endscript

script helper_on_fe_menu
helper_hide
FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
helper_set_positions x1=80 x2=210
SetMenuElementText Id=helper_menu_1 "бе Select"
SetMenuElementText Id=helper_menu_2 "м Accept"
WaitForMenuToDisappear frontend_menu
endscript


script helper_on_pro_menu
helper_select_lr_choose_back_centered  
WaitForMenuToDisappear Pro_menu
endscript

script helper_select_choose_back_centered
	helper_hide
	helper_select_choose_back x1=167 x2=282 x3=392
endscript

script helper_on_main_menu_centered
helper_select_choose_back x1=167 x2=282 x3=392
WaitForMenuToDisappear SelectChooseBackCenteredMenus
endscript

// Displays the helper text for the mem card yes/no menus.
script helper_on_mem_card_yes_no
helper_select_choose_back x1=167 x2=282 x3=392
begin
    ; Checking whether any of lines 4,5 or 6 is selected is the only way
    ; I could find to determine whether the yes/no menu is visible.
    ; Cannot check if simple_menu is shown, because the next mem card message will
    ; be a simple_menu too.
    ; Checking 8,9 too, for format yes/no (in memcardmessages.q)
    if MenuIsSelected [ken_line4 ken_line5 ken_line6 ken_line8 ken_line9]
    else
        change MemCardYesNoMenuVisible=0
        goto helper_scanner
    endif
    wait 1 gameframe
repeat
endscript

script helper_on_autoload_retry_continue
helper_select_choose_back x1=187 x2=332
FireMenuEvent Type=HIDE Id=helper_menu_3 target=helper_menu_3
begin
    ; Checking 10,11, for autoload-retry/continue (in mainmenu.q)
    if MenuIsSelected [ken_line10 ken_line11]
    else
        change AutoLoadRetryContinueVisible=0
        goto helper_scanner
    endif
    wait 1 gameframe
repeat
endscript


script helper_on_mem_card_files_menu
if FilesMenuIsSave
    helper_select_choose_back_delete
else
    helper_select_choose_back x1=167 x2=282 x3=392
endif
WaitForMenuToDisappear memcard_files_menu
endscript

// need to add rotate here
script helper_on_cas_select_choose_back
helper_select_choose_rotate_back x1=67 x2=192 x3=345
WaitForMenuToDisappear CasSelectChooseBackMenus
endscript

script helper_on_cas_select_choose_back_4_arrows
helper_select_choose_Rotate_back 
SetMenuElementText Id=helper_menu_1 "безг Select"
begin
    if MenuIsShown CasSelectChooseBackMenus
        goto helper_scanner
    else
        if MenuIsShown CasChangeBackMenus
            goto helper_scanner
        else
            if MenuIsShown cas_stats_menu
                if MenuIsSelected cas_left_container
                else
                    goto helper_scanner
                endif
            endif        
        
            if MenuIsShown cas_multi_menu
            else
                goto helper_scanner
            endif
        endif        
    endif 
    wait 1 gameframe
repeat
endscript

script helper_on_cas_change_back
FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
helper_set_positions
MoveMenu Id=helper_menu_1 x=90
MoveMenu Id=helper_menu_2 x=260
SetMenuElementText Id=helper_menu_1 "з Change г"
SetMenuElementText Id=helper_menu_2 "к Back"
endscript

script helper_on_cas_select_change_back
FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
FireMenuEvent Type=SHOW Id=helper_menu_3 target=helper_menu_3
helper_set_positions
MoveMenu Id=helper_menu_1 x=90
MoveMenu Id=helper_menu_2 x=221
MoveMenu Id=helper_menu_3 x=335
SetMenuElementText Id=helper_menu_1 "бе Select"
SetMenuElementText Id=helper_menu_2 "з Change г"
SetMenuElementText Id=helper_menu_3 "к Back"
endscript

script helper_on_cas_select_change_accept
FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
FireMenuEvent Type=SHOW Id=helper_menu_3 target=helper_menu_3
helper_set_positions x1=167 x2=282 x3=392
SetMenuElementText Id=helper_menu_1 "бе Select"
SetMenuElementText Id=helper_menu_2 "з Change г"
SetMenuElementText Id=helper_menu_3 "м Accept"
endscript

script helper_on_cas_select_change_accept_back
FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2
FireMenuEvent Type=SHOW Id=helper_menu_3 target=helper_menu_3
FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
helper_set_positions
MoveMenu Id=helper_menu_1 x=90
MoveMenu Id=helper_menu_2 x=221
MoveMenu Id=helper_menu_3 x=335
MoveMenu Id=helper_menu_4 x=400
SetMenuElementText Id=helper_menu_1 "бе Select"
SetMenuElementText Id=helper_menu_2 "з Change г"
SetMenuElementText Id=helper_menu_3 "м Accept"
SetMenuElementText Id=helper_menu_4 "к Back"
endscript

script helper_on_career_menu
helper_select_choose_back
//helper_pro_leftright
WaitForMenuToDisappear SelectChooseBackChangeMenus
endscript

script helper_on_player_two_menu
helper_select_choose_rotate_back 
WaitForMenuToDisappear player_two_menu
endscript

script helper_on_controller_config_menus
helper_select_toggle_back
WaitForMenuToDisappear ToggleChooseBackMenus
endscript

script helper_on_boardshop_menu
begin
    if SkaterCamAnimHeld skater=0
        helper_select_choose_back
        break
    endif
    wait 1 gameframe
repeat

helper_set_positions x1=221 x2=360 x3=470 y=390
WaitForMenuToDisappear boardshop_menu
endscript

script helper_on_deck_menu
helper_show
helper_set_positions x1=221 x2=360 x3=470 y=390
SetMenuElementText Id=helper_menu_1 "згбе Select"
SetMenuElementText Id=helper_menu_2 "м Accept"
SetMenuElementText Id=helper_menu_3 "к Back"
WaitForMenuToDisappear deck_menu
endscript

script helper_on_wheel_color_menu
helper_show

helper_set_positions x1=221 x4=335 x3=470 x2=50 y=390
SetMenuElementText Id=helper_menu_1 "бе Select"
SetMenuElementText Id=helper_menu_2 "зг Change"
SetMenuElementText Id=helper_menu_3 "к Back"
FireMenuEvent Type=SHOW Id=helper_menu_4 target=helper_menu_4
SetMenuElementText Id=helper_menu_4 "м Accept" 
WaitForMenuToDisappear wheel_color_menu
endscript

script helper_on_server_list
helper_hide

if InInternetMode
	FireMenuEvent Type=SHOW Id=helper_menu_1 target=helper_menu_1
endif
FireMenuEvent Type=SHOW Id=helper_menu_2 target=helper_menu_2

if InInternetMode
	helper_set_positions x1=445 x2=525 y=400
else
	helper_set_positions x2=470 y=400
endif

if InInternetMode
	SetMenuElementText Id=helper_menu_1 "зг Sort"
endif
SetMenuElementText Id=helper_menu_2 "к Back"
WaitForMenuToDeSelect rr
endscript

/////////////////////////////////////////////////////////////////////////////////////////
//
//                          Park editor helper text stuff
//
/////////////////////////////////////////////////////////////////////////////////////////

; 1,2,3 and 4 use the helper_text text drawer.
; These are the coords of the text for the default helper ('move' mode)
ParkEditorHelper1x=20  ParkEditorHelper1y=410
ParkEditorHelper2x=190 ParkEditorHelper2y=410
ParkEditorHelper3x=375 ParkEditorHelper3y=410
ParkEditorHelper4x=515 ParkEditorHelper4y=410
; 5 & 6 use the small_helper text drawer, and are used for the Empty and Full indicators.
ParkEditorHelper5x=580 ParkEditorHelper5y=115
ParkEditorHelper6x=560 ParkEditorHelper6y=390

; Gap move helper stuff ...

; Coords of the 'select piece to gap from' text
ParkEditorHelper0x=220
ParkEditorHelper0y=385
ParkEditorGapMoveText1="Select Piece to Gap from"
ParkEditorGapMoveText2="Select Piece to Gap to"
; x coord of the 'erase gap', which was a bit too far to the right.
; The others use the ParkEditorHelper1x,ParkEditorHelper2x,ParkEditorHelper3x defined above.
ParkEditorGapMoveHelper4x=490

; Gap adjust helper stuff ...
ParkEditorGapAdjustHelper1x=25
ParkEditorGapAdjustHelper2x=145
ParkEditorGapAdjustHelper3x=295
ParkEditorGapAdjustHelper4x=490
ParkEditorGapAdjustHelpery=410 ; They all share this y
ParkEditorGapAdjustText="╜/╛/┐/║ Scale Gap"

; This gets called when a menu is shown.
script helper_park_editor
; Make sure that the scanner script exists & is running.
KillSpawnedScript Id=helper_scanner
SpawnScript helper_scanner Id=helper_scanner
endscript

ParkEditorMenus=
[
parked_main_menu
parked_load_menu
parked_save_menu
parked_clear_menu
parked_theme_menu
parked_gap_menu
parked_gap_score_menu
parked_test_menu
parked_yesno_menu1
parked_yesno_menu2
parked_yesno_menu3
parked_yesno_menu4
]

script helper_on_park_editor_select_choose_back_centered
// bookmark
helper_select_choose_back x1=210 x2=330
FireMenuEvent Type=HIDE Id=helper_menu_3 target=helper_menu_3
if EditingPark
    ; Only draw the full/empty indicators if editing, not if test-skating.
    DrawFullEmpty
endif  

WaitForMenuToDisappear ParkEditorMenus
endscript

script DrawFullEmpty
; Tweak the positions of the Full & Empty indicators to match those as drawn by the C-code.
FireMenuEvent Type=SHOW Id=helper_menu_5 target=helper_menu_5   ; Full
MoveMenu Id=helper_menu_5 x=578 y=112

FireMenuEvent Type=SHOW Id=helper_menu_6 target=helper_menu_6   ; Empty
MoveMenu Id=helper_menu_6 x=558 y=387
endscript*/
