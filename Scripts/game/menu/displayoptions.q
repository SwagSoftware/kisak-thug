// ********************************************************************
// Display Options menu
// ********************************************************************

// @script | launch_displyy_options_menu | 
script launch_display_options_menu
    if GotParam from_options
		create_display_options_menu from_options
	else
		create_display_options_menu
	endif
endscript

// @script | display_options_menu | 
script create_display_options_menu
	
	FormatText ChecksumName=title_icon "%i_special" i=(THEME_PREFIXES[current_theme_prefix])
	make_new_themed_sub_menu title="DISPLAY OPTIONS" title_icon=<title_icon>
	
	
    create_helper_text { helper_text_elements=[ 	{ text="\b7/\b4 = Select" }
													{ text="\m1 = Back" }
													{ text="\m0 = Accept" }
											  ]
					   }
					   
    SetScreenElementProps { id=sub_menu
								event_handlers=[
									{pad_back           generic_menu_pad_back params={ callback=display_options_exit } }
								]
							  }
	
	if GetGlobalFlag flag=NO_DISPLAY_HUD
		hud_text="Off"
	else
		hud_text="On"
	endif
	
	theme_menu_add_item { 	text="Score/Special Meter:"
							extra_text=<hud_text>
							id=menu_display_hud 
                            pad_choose_script=toggle_display_hud 
	        			}
	
	if GetGlobalFlag flag=NO_DISPLAY_TRICKSTRING
		hud_text="Off"
	else
		hud_text="On"
	endif
	theme_menu_add_item {	text="Trick String:" 
								extra_text=<hud_text>
								id=menu_display_trickstring 
								pad_choose_script=toggle_display_trickstring
							}
	
	if GetGlobalFlag flag=NO_DISPLAY_BASESCORE
		hud_text="Off"
	else
		hud_text="On"
	endif						
	theme_menu_add_item {	text="Base Score:" 
								extra_text=<hud_text>
								id=menu_display_basescore 
								pad_choose_script=toggle_display_basescore
							}
	
	if GetGlobalFlag flag=NO_DISPLAY_CHATWINDOW
		hud_text="Off"
	else
		hud_text="On"
	endif
	
	if InNetGame						
		theme_menu_add_item {	text="Chat Window:" 
									extra_text=<hud_text>
									id=menu_display_chatwindow 
									pad_choose_script=toggle_display_chatwindow
								}
	else
		theme_menu_add_item {	text="Console Window:" 
								extra_text=<hud_text>
								id=menu_display_chatwindow 
								pad_choose_script=toggle_display_chatwindow
							}
	endif
						
	if GetGlobalFlag flag=NO_DISPLAY_BALANCE
		hud_text="Off"
	else
		hud_text="On"
	endif
	
	if inNetGame
		if GetGlobalFlag flag=NO_G_DISPLAY_BALANCE
			theme_menu_add_item {	text="Balance Meters:" 
									extra_text=<hud_text>
									id=menu_display_balance 
									pad_choose_script=toggle_display_balance
									not_focusable=not_focusable
								}
		else
			theme_menu_add_item {	text="Balance Meters:" 
									extra_text=<hud_text>
									id=menu_display_balance 
									pad_choose_script=toggle_display_balance
								}
		endif
	else
		theme_menu_add_item {	text="Balance Meters:" 
									extra_text=<hud_text>
									id=menu_display_balance 
									pad_choose_script=toggle_display_balance
								}
	endif
	
	
	
	if InNetGame							
		/*GetPreferenceString pref_type=network show_names
		theme_menu_add_item {	text="Names Above Heads:" 
									extra_text=<ui_string>
									id=menu_display_net_names 
									pad_choose_script=toggle_display_net_names
								}*/
								
		
		if GetGlobalFlag flag=NO_DISPLAY_NET_SCORES
			hud_text="Off"
		else
			hud_text="On"
		endif
		theme_menu_add_item {	text="Names and Scores:" 
									extra_text=<hud_text>
									id=menu_display_net_scores 
									pad_choose_script=toggle_display_net_scores
								}
	endif
							

   ; change widest_menu_item_width=185
	if GotParam from_options
		theme_menu_add_item text="Done" id=menu_done pad_choose_script=display_options_exit pad_choose_params={ from_options } last_menu_item=1
    else
		theme_menu_add_item text="Done" id=menu_done pad_choose_script=display_options_exit last_menu_item=1
	endif
	
	finish_themed_sub_menu
    
endscript

script toggle_display_hud
	if not GetGlobalFlag flag=NO_DISPLAY_HUD
		SetScreenElementProps id={ menu_display_hud child=3 } text="Off"
		;DoScreenElementMorph id=0xa4db8a4b pos=(0,0)
		SetGlobalFlag flag=NO_DISPLAY_HUD
		
	else
		SetScreenElementProps id={ menu_display_hud child=3 } text="On"
		UnsetGlobalFlag flag=NO_DISPLAY_HUD
	endif
endscript

script toggle_display_trickstring
	if not GetGlobalFlag flag=NO_DISPLAY_TRICKSTRING
		SetScreenElementProps id={ menu_display_trickstring child=3 } text="Off"
		;DoScreenElementMorph id=0xa4db8a4b pos=(0,0)
		SetGlobalFlag flag=NO_DISPLAY_TRICKSTRING
	else
		SetScreenElementProps id={ menu_display_trickstring child=3 } text="On"
		UnsetGlobalFlag flag=NO_DISPLAY_TRICKSTRING
	endif
endscript

script toggle_display_basescore
	if not GetGlobalFlag flag=NO_DISPLAY_BASESCORE
		SetScreenElementProps id={ menu_display_basescore child=3 } text="Off"
		;DoScreenElementMorph id=0xa4db8a4b pos=(0,0)
		SetGlobalFlag flag=NO_DISPLAY_BASESCORE
	else
		SetScreenElementProps id={ menu_display_basescore child=3 } text="On"
		UnsetGlobalFlag flag=NO_DISPLAY_BASESCORE
	endif
endscript

script toggle_display_chatwindow
	if not GetGlobalFlag flag=NO_DISPLAY_CHATWINDOW
		SetScreenElementProps id={ menu_display_chatwindow child=3 } text="Off"
		;DoScreenElementMorph id=0xa4db8a4b pos=(0,0)
		SetGlobalFlag flag=NO_DISPLAY_CHATWINDOW
	else
		SetScreenElementProps id={ menu_display_chatwindow child=3 } text="On"
		UnsetGlobalFlag flag=NO_DISPLAY_CHATWINDOW
	endif
endscript

script toggle_display_balance
	if not GetGlobalFlag flag=NO_DISPLAY_BALANCE
		SetScreenElementProps id={ menu_display_balance child=3 } text="Off"
        SetGlobalFlag flag=NO_DISPLAY_BALANCE
	else
		SetScreenElementProps id={ menu_display_balance child=3 } text="On"
		UnsetGlobalFlag flag=NO_DISPLAY_BALANCE
	endif
endscript

script toggle_display_net_names
	GetPreferenceString pref_type=network show_names
	if ( <ui_string> = "Off" )
		SetScreenElementProps id={ menu_display_net_names child=3 } text="On"
		set_preferences_from_ui prefs=network field="show_names" checksum=boolean_true string="On"
		;unhide_all_player_names
	else
		SetScreenElementProps id={ menu_display_net_names child=3 } text="Off"
		set_preferences_from_ui prefs=network field="show_names" checksum=boolean_false string="Off"
		;hide_all_player_names
	endif
endscript

script toggle_display_net_scores
	if not GetGlobalFlag flag=NO_DISPLAY_NET_SCORES
		SetScreenElementProps id={ menu_display_net_scores child=3 } text="Off"
        SetGlobalFlag flag=NO_DISPLAY_NET_SCORES
	else
		SetScreenElementProps id={ menu_display_net_scores child=3 } text="On"
		UnsetGlobalFlag flag=NO_DISPLAY_NET_SCORES
	endif
endscript

script display_options_exit
	
	if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	
	if not LevelIs load_skateshop
        create_options_menu
	else
		create_setup_options_menu
	endif
endscript
