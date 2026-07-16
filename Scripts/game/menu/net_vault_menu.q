// neversoft vault.

// *******************************
//	creation scripts
// *******************************

best_green=[40 128 40 120]

script create_downloads_menu
    dialog_box_exit
	
    FormatText ChecksumName=rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	build_top_and_bottom_blocks
	make_mainmenu_3d_plane
	
	SetScreenElementLock id=menu_parts_anchor off
	
	CreateScreenElement {
	   	type=ContainerElement
		parent=menu_parts_anchor
		id=downloads_anchor
		pos=(-5,800)
	}
	
    make_new_menu {	menu_id=downloads_menu 
				    vmenu_id=downloads_vmenu
					parent=downloads_anchor
					pos=(80,85)
				  }
				  
	// title
	CreateScreenElement {
				type=TextElement
				parent=downloads_anchor
                
				font=testtitle
				text="DOWNLOAD"
				scale=1.5
				pos=(170,86)
				just= [center top]
				rgba=[128 128 128 98]            
				not_focusable
			}
	// title bg
	CreateScreenElement {
				type=SpriteElement
				parent=downloads_anchor
                texture=regions
                scale=1
				pos=(39,82)
				just= [left top]
				rgba=<rgba>
				scale=(1.025,1)
				alpha=0.6
				not_focusable
                          }
	
    SetScreenElementProps { id=downloads_menu event_handlers=[ {pad_back generic_menu_pad_back params={ callback=back_from_downloads_menu}} ] }
						   
    // empty item to make room for title
	downloads_menu_add_item text="" not_focusable=not_focusable
						  
    downloads_menu_add_item {
		text="Parks"
		id=menu_down_parks
		pad_choose_script=download_content
		pad_choose_params={ type=parks }
	}
	
	downloads_menu_add_item {
		text="Skater/Story"
		id=menu_down_skaters
		pad_choose_script=download_content
		pad_choose_params={ type=skaters }
	}
	
	downloads_menu_add_item {
		text="Tricks"
		id=menu_down_tricks
		pad_choose_script=download_content
		pad_choose_params={ type=tricks }
	}
	
	downloads_menu_add_item {
		text="Goals"
		id=menu_down_goals
		pad_choose_script=download_content
		pad_choose_params={ type=goals }
		last_menu_item=last_menu_item
	}
    
    RunScriptOnScreenElement lobby_list_animate_in id=downloads_anchor params={ id=downloads_anchor }
    FireEvent type=unfocus target=sub_menu
	FireEvent type=focus target=downloads_menu
	AssignAlias id=menu_parts_anchor alias=current_menu_anchor
endscript

script downloads_menu_add_item parent=downloads_vmenu
    theme_menu_add_item { parent=<parent> centered <...> menu=2 middle_scale=(2.1,1) static_width highlight_bar_scale=(2.0,0.7) }
endscript

script back_from_downloads_menu
	FireEvent type=unfocus target=downloads_menu
	DestroyScreenElement id=downloads_anchor
    FireEvent type=focus target=sub_menu
endscript

script create_uploads_menu
    dialog_box_exit
	
    FormatText ChecksumName=rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	build_top_and_bottom_blocks
	make_mainmenu_3d_plane
	
	SetScreenElementLock id=menu_parts_anchor off
	
	CreateScreenElement {
	   	type=ContainerElement
		parent=menu_parts_anchor
		id=uploads_anchor
		pos=(-5,800)
	}
	
    make_new_menu {	menu_id=uploads_menu 
				    vmenu_id=uploads_vmenu
					parent=uploads_anchor
					pos=(80,85)
				  }
				  
	// title
	CreateScreenElement {
				type=TextElement
				parent=uploads_anchor
                
				font=testtitle
				text="UPLOAD"
				scale=1.5
				pos=(170,86)
				just= [center top]
				rgba=[128 128 128 98]            
				not_focusable
			}
	// title bg
	CreateScreenElement {
				type=SpriteElement
				parent=uploads_anchor
                texture=regions
                scale=1
				pos=(39,82)
				just= [left top]
				rgba=<rgba>
				scale=(1.025,1)
				alpha=0.6
				not_focusable
                          }
	
    SetScreenElementProps { id=uploads_menu event_handlers=[ {pad_back   generic_menu_pad_back params={ callback=back_from_uploads_menu}} ] }
						   
    // empty item to make room for title
	downloads_menu_add_item text="" not_focusable=not_focusable parent=uploads_vmenu
						  
    downloads_menu_add_item {
		parent=uploads_vmenu
		text="Parks"
		id=menu_down_parks
		pad_choose_script=launch_upload_file_sequence
		pad_choose_params={ type=park }
	}
	
	downloads_menu_add_item {
		parent=uploads_vmenu
		text="Skater/Story"
		id=menu_down_skaters
		pad_choose_script=launch_upload_file_sequence
		pad_choose_params={ type=optionsandpros }
	}
	
	downloads_menu_add_item {
		parent=uploads_vmenu
		text="Tricks"
		id=menu_down_tricks
		pad_choose_script=launch_upload_file_sequence
		pad_choose_params={ type=cat }
	}
	
	downloads_menu_add_item {
		parent=uploads_vmenu
		text="Goals"
		id=menu_down_goals
		pad_choose_script=launch_upload_file_sequence
		pad_choose_params={ type=CreatedGoals }
		last_menu_item=last_menu_item
	}
    
    RunScriptOnScreenElement lobby_list_animate_in id=uploads_anchor params={ id=uploads_anchor }
    FireEvent type=unfocus target=sub_menu
	FireEvent type=focus target=uploads_menu
	AssignAlias id=menu_parts_anchor alias=current_menu_anchor
endscript

script back_from_uploads_menu
	FireEvent type=unfocus target=uploads_menu
	DestroyScreenElement id=uploads_anchor
    FireEvent type=focus target=sub_menu
endscript

// @script | net_vault_menu_create |
// @parm string | category |
script net_vault_menu_create
    pulse_blur
    dialog_box_exit
	
    if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
    
	SetScreenElementLock id=root_window off
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
    
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=vault_bg_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	AssignAlias id=vault_bg_anchor alias=current_menu_anchor
	create_helper_text generic_helper_text_up_down_left_right
	
	if GotParam type
		switch <type>
			case parks
				title="PARK VAULT"
			case goals
				title="GOAL VAULT"
			case tricks
				title="TRICK VAULT"
			case skaters
				title="SKATER VAULT"
			default
				title="NEVERSOFT VAULT"
		endswitch
	else
		title="NEVERSOFT VAULT"
	endif
    
    FormatText ChecksumName=title_icon "%i_vault" i=(THEME_PREFIXES[current_theme_prefix])
    build_theme_sub_title title=<title> title_icon=<title_icon>
    
	build_top_and_bottom_blocks bot_z=15
	make_mainmenu_3d_plane
	
    // anchor for menu
	CreateScreenElement {
		type=ContainerElement
		parent=vault_bg_anchor
		id=vault_menu_anchor
		
		dims=(640, 480)
		pos=(320, 840)
	}
	AssignAlias id=vault_menu_anchor alias=current_menu_anchor
	
	theme_background width=7 pos=(320,63) num_parts=10 static=static dark_menu=dark_menu
	
	// black box
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        texture=white2
		scale=(71.3,8)
		pos=(35,63)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// sub title
	text = ""
	rgba=<on_rgba>
	star_alpha=0
	
	if GotParam category
		if ( <category> = "Best" )
			text = "Best of the Best"
			rgba=best_green
			star_alpha=1
		else
			text = <category>
		endif
	endif
	
	CreateScreenElement {
		type=textElement
		parent=current_menu_anchor
		id=net_vault_menu_category
		text=<text>
		scale=1.4
		font=small
		rgba=<rgba>
		pos=(63,85)
        just=[left center]
		z_priority=3
	}
	
	// left arrow
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        
		id=net_vault_menu_left_arrow
		texture=left_arrow
		scale=(1,1)
		pos=(60,83)
        just=[right center]
		alpha=0.5
		z_priority=3
	}
	
	// right arrow
	GetStackedScreenElementPos X id=net_vault_menu_category offset=(5, 13)
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        
		id=net_vault_menu_right_arrow
		texture=right_arrow
		scale=(1,1)
		pos=<pos>
        just=[left center]
		alpha=0.5
		z_priority=3
	}
	
    // neversoft logo
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        
        texture=neversoft
		scale=(1.75,1.3)
		pos=(305,55)
        just=[left top]
		alpha=0.3
		z_priority=3
	}
	
	// best star
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
		id=best_star
        
        texture=best
		scale=1
		pos=(535,63)
        just=[left top]
		rgba=best_green
		alpha=<star_alpha>
		z_priority=3
	}
	
	// scrolling menu
	CreateScreenElement {
		type=VScrollingMenu
		parent=current_menu_anchor
		id=net_vault_vscrollingmenu
		
		pos=(50, 130) 
		dims=(400, 180)
		just=[left top]
	}
    
	// vmenu
	CreateScreenElement {
		type=VMenu
		parent=net_vault_vscrollingmenu
		id=net_vault_vmenu
		
		pos=(0, 0)
		just=[left top]
		internal_just=[left top]
		event_handlers=[ { pad_back		generic_menu_pad_back_sound }
						 { pad_back		back_from_vault }
						 { pad_down		menu_vert_blink_arrow params={ id=down_arrow } }
						 { pad_up		menu_vert_blink_arrow params={ id=up_arrow } } 
						 { pad_up 		generic_menu_up_or_down_sound params={ up } }
						 { pad_down		generic_menu_up_or_down_sound params={ down } }
                         { pad_left		net_vault_menu_prev_category }
						 { pad_right	net_vault_menu_next_category }
					   ]
		dont_allow_wrap
	}
	AssignAlias id=net_vault_vmenu alias=current_menu
    
    // globe
	CreateScreenElement {
		type=spriteElement
		parent=vault_bg_anchor
		id=globe
		texture=globe
		scale=1.3
		pos=(320,560)
        just=[center center]
		alpha=0.3
		z_priority=-1
	}
	
	if GotParam type
		switch <type>
			case parks
				create_net_vault_parks_menu
			case goals
				create_net_vault_goals_menu
			case tricks
				create_net_vault_tricks_menu
			case skaters
				create_net_vault_skaters_menu
			default
				printf "bad type in net_vault_menu_create---------------------------------------"
				printstruct <...>
		endswitch
	endif
	
	FillVaultMenu
	
    RunScriptOnScreenElement id=net_vault_vscrollingmenu reset_vault_scrolling_menu
    
	RunScriptOnScreenElement id=globe rotate_internet_options_globe
    RunScriptOnScreenElement id=vault_menu_anchor online_stats_animate_in params={ id=vault_menu_anchor }
    
	FireEvent type=focus target=current_menu
endscript

script reset_vault_scrolling_menu
	wait 2 gameframes
	SetScreenElementProps id=net_vault_vscrollingmenu reset_window_top
endscript

script create_net_vault_parks_menu
    if ScreenElementExists id=net_vault_submenu_anchor
		DestroyScreenElement id=net_vault_submenu_anchor
	endif
	
	SetScreenElementLock off id=vault_menu_anchor
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=vault_menu_anchor
		id=net_vault_submenu_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	
	// Name
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Park Name"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(90,115)
        just=[left center]
	}
	
	// up arrow
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        
		id=up_arrow
		texture=up_arrow
		scale=1
		pos=(240,115)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// down arrow
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        
		id=down_arrow
		texture=down_arrow
		scale=1
		pos=(240,314)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// black line
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(260,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Creator
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Creator"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(265,115)
        just=[left center]
	}
	
    // black line
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(470,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Size
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Size"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(480,115)
        just=[left center]
	}
	
	// Description
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=description_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(320,324)
        just=[center top]
	}
	
	// Pieces
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=pieces_text
        text="pieces"
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(100,338)
        just=[center top]
	}
	
	// Gaps
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=gap_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(200,338)
        just=[center top]
	}
	
	// Goals
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=goal_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(300,338)
        just=[center top]
	}
	
	// Theme
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=theme_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(400,338)
        just=[left top]
	}
	
	// Tod
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=tod_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(500,338)
        just=[center top]
	}
	
    // black box
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(71.3,4)
		pos=(320,324)
        just=[center top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
endscript

script create_net_vault_skaters_menu
    if ScreenElementExists id=net_vault_submenu_anchor
		DestroyScreenElement id=net_vault_submenu_anchor
	endif
	
	SetScreenElementLock off id=vault_menu_anchor
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=vault_menu_anchor
		id=net_vault_submenu_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	
	// Name
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Skater Name"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(90,115)
        just=[left center]
	}
	
	// up arrow
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        
		id=up_arrow
		texture=up_arrow
		scale=1
		pos=(240,115)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// down arrow
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        
		id=down_arrow
		texture=down_arrow
		scale=1
		pos=(240,314)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// black line
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(260,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Creator
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Creator"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(265,115)
        just=[left center]
	}
	
    // black line
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(470,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Sex
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Sex"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(480,115)
        just=[left center]
	}
	
	// Description
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=description_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(320,324)
        just=[center top]
	}
	
	/*// Sex
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=sex_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(320,338)
        just=[center top]
	}*/
	
	// black box
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(71.3,4)
		pos=(320,324)
        just=[center top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
endscript

script create_net_vault_goals_menu
    if ScreenElementExists id=net_vault_submenu_anchor
		DestroyScreenElement id=net_vault_submenu_anchor
	endif
	
	SetScreenElementLock off id=vault_menu_anchor
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=vault_menu_anchor
		id=net_vault_submenu_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	
	// Name
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Goal List"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(90,115)
        just=[left center]
	}
	
	// up arrow
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        
		id=up_arrow
		texture=up_arrow
		scale=1
		pos=(240,115)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// down arrow
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        
		id=down_arrow
		texture=down_arrow
		scale=1
		pos=(240,314)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// black line
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(260,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Creator
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Creator"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(265,115)
        just=[left center]
	}
	
    // black line
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(470,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Num Goals
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Num Goals"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(480,115)
        just=[left center]
	}
	
	// Description
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=description_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(320,324)
        just=[center top]
	}
	
	/*// Goals
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=goal_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(320,338)
        just=[center top]
	}*/
	
	// black box
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(71.3,4)
		pos=(320,324)
        just=[center top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
endscript

script create_net_vault_tricks_menu
    if ScreenElementExists id=net_vault_submenu_anchor
		DestroyScreenElement id=net_vault_submenu_anchor
	endif
	
	SetScreenElementLock off id=vault_menu_anchor
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=vault_menu_anchor
		id=net_vault_submenu_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	
	// Name
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Trick Name"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(90,115)
        just=[left center]
	}
	
	// up arrow
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        
		id=up_arrow
		texture=up_arrow
		scale=1
		pos=(240,115)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// down arrow
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        
		id=down_arrow
		texture=down_arrow
		scale=1
		pos=(240,314)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// black line
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(260,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Creator
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Creator"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(265,115)
        just=[left center]
	}
	
    // black line
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(470,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Score
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
        text="Score"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(480,115)
        just=[left center]
	}
	
	// Description
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=description_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(320,324)
        just=[center top]
	}
	
	/*// Score
	CreateScreenElement {
		type=textElement
		parent=net_vault_submenu_anchor
		id=score_text
        text=""
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		pos=(320,338)
        just=[center top]
	}*/
	
	// black box
	CreateScreenElement {
		type=spriteElement
		parent=net_vault_submenu_anchor
        texture=white2
		scale=(71.3,4)
		pos=(320,324)
        just=[center top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
endscript


// *******************************
//	add item scripts
// *******************************

// @script | net_vault_menu_add_park | add a created park to the vault menu
// @parm string | name | the name of the park
// @parm string | creator | 
// @parm string | size | 
// @parm string | focus | 
// @parm int | downloads | number of downloads
// @parmopt structure | pad_choose_params | | 
script net_vault_menu_add_park
	printstruct <...>
	
	// add a container
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		
		dims=(400, 18)
		pos=(0, 0)
		event_handlers=[ { focus		net_vault_menu_focus params={ type=parks } }
						 { unfocus		net_vault_menu_unfocus params={ type=parks } }
						 { pad_choose	download_selected_file params={ type=parks <pad_choose_params> } }
						 { pad_choose	generic_menu_pad_choose_sound }
					   ]
	}
	<anchor_id> = <id>
	
	if GotParam description
		<anchor_id>:SetTags description=<description> num_gaps=<num_gaps> num_goals=<num_goals> num_pieces=<num_pieces> tod_script=<tod_script> theme=<theme>
	else
		<anchor_id>:SetTags description="Description goes here... oops!" num_gaps=<num_gaps> num_goals=<num_goals> num_pieces=<num_pieces> tod_script=<tod_script> theme=<theme>
	endif
	
	// name
	net_vault_menu_add_text anchor_id=<anchor_id> text=<name> pos=(0, 0)
	
	// creator
	net_vault_menu_add_text anchor_id=<anchor_id> text=<creator> pos=(220, 0)
	
	// size
	net_vault_menu_add_text anchor_id=<anchor_id> text=<size> pos=(445, 0)
	
	if GotParam focus
		// focus
		net_vault_menu_add_text anchor_id=<anchor_id> text=<focus> pos=(410, 0)
	endif
	if GotParam downloads
		// downloads
		FormatText TextName=downloads_string "%i" i=<downloads>
		net_vault_menu_add_text anchor_id=<anchor_id> text=<downloads_string> pos=(470, 0)
	endif
endscript

script net_vault_menu_add_goal
	// add a container
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		
		dims=(400, 18)
		pos=(0, 0)
		event_handlers=[ { focus		net_vault_menu_focus params={ type=goals } }
						 { unfocus		net_vault_menu_unfocus params={ type=goals } }
						 { pad_choose	download_selected_file params={ type=goals <pad_choose_params> } }
						 { pad_choose	generic_menu_pad_choose_sound }
					   ]
	}
	<anchor_id> = <id>
	
	if GotParam description
		<anchor_id>:SetTags description=<description> num_goals=<num_goals>
	else
		<anchor_id>:SetTags description="Description goes here... oops!" num_goals=<num_goals>
	endif
	
	// name
	net_vault_menu_add_text anchor_id=<anchor_id> text=<name> pos=(0, 0)
	
	// creator
	net_vault_menu_add_text anchor_id=<anchor_id> text=<creator> pos=(220, 0)
	
	// num goals
	FormatText textname=string "%i" i=<num_goals>
	net_vault_menu_add_text anchor_id=<anchor_id> text=<string> pos=(445, 0)
	
	if GotParam focus
		// focus
		net_vault_menu_add_text anchor_id=<anchor_id> text=<focus> pos=(410, 0)
	endif
	if GotParam downloads
		// downloads
		FormatText TextName=downloads_string "%i" i=<downloads>
		net_vault_menu_add_text anchor_id=<anchor_id> text=<downloads_string> pos=(470, 0)
	endif
endscript

script net_vault_menu_add_trick
	// add a container
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		
		dims=(400, 18)
		pos=(0, 0)
		event_handlers=[ { focus		net_vault_menu_focus params={ type=tricks } }
						 { unfocus		net_vault_menu_unfocus params={ type=tricks } }
						 { pad_choose	download_selected_file params={ type=tricks <pad_choose_params> } }
						 { pad_choose	generic_menu_pad_choose_sound }
					   ]
	}
	<anchor_id> = <id>
	
	if GotParam description
		<anchor_id>:SetTags description=<description> score=<score>
	else
		<anchor_id>:SetTags description="Description goes here... oops!" score=<score>
	endif
	
	// name
	net_vault_menu_add_text anchor_id=<anchor_id> text=<name> pos=(0, 0)
	
	// creator
	net_vault_menu_add_text anchor_id=<anchor_id> text=<creator> pos=(220, 0)
	
	// score
	FormatText textname=string "%i" i=<score>
	net_vault_menu_add_text anchor_id=<anchor_id> text=<string> pos=(445, 0)
	
	if GotParam focus
		// focus
		net_vault_menu_add_text anchor_id=<anchor_id> text=<focus> pos=(410, 0)
	endif
	if GotParam downloads
		// downloads
		FormatText TextName=downloads_string "%i" i=<downloads>
		net_vault_menu_add_text anchor_id=<anchor_id> text=<downloads_string> pos=(470, 0)
	endif
endscript

script net_vault_menu_add_skater
	printf "net_vault_menu_add_skater"
	// add a container
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		
		dims=(400, 18)
		pos=(0, 0)
		event_handlers=[ { focus		net_vault_menu_focus params={ type=skaters } }
						 { unfocus		net_vault_menu_unfocus params={ type=skaters } }
						 { pad_choose	download_selected_file params={ type=skaters <pad_choose_params> } }
						 { pad_choose	generic_menu_pad_choose_sound }
					   ]
	}
	<anchor_id> = <id>
	
	if GotParam description
		<anchor_id>:SetTags description=<description> is_male=<is_male>
	else
		<anchor_id>:SetTags description="Description goes here... oops!" is_male=<is_male>
	endif
	
	// name
	net_vault_menu_add_text anchor_id=<anchor_id> text=<name> pos=(0, 0)
	
	// creator
	net_vault_menu_add_text anchor_id=<anchor_id> text=<creator> pos=(220, 0)
	
	// size
	if ( <is_male> = 1 )
		string="Male"
	else
		string="Female"
	endif
	net_vault_menu_add_text anchor_id=<anchor_id> text=<string> pos=(445, 0)
	
	if GotParam focus
		// focus
		net_vault_menu_add_text anchor_id=<anchor_id> text=<focus> pos=(410, 0)
	endif
	if GotParam downloads
		// downloads
		FormatText TextName=downloads_string "%i" i=<downloads>
		net_vault_menu_add_text anchor_id=<anchor_id> text=<downloads_string> pos=(470, 0)
	endif
endscript

script net_vault_menu_add_text
	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// add a single text item to a container
	CreateScreenElement {
		type=TextElement
		parent=<anchor_id>
		
		font=dialog
		text=<text>
		pos=<pos>
		just=[left top]
		scale=0.8
		rgba=<rgba>
	}
endscript

// *******************************
//	event handling scripts
// *******************************

script net_vault_menu_focus
	GetTags
    FormatText ChecksumName=rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	net_vault_menu_change_text_color {
		id=<id>
		rgba=<rgba>
	}
	
	if GotParam description
		if ScreenElementExists id=description_text
			SetScreenElementProps id=description_text text=<description>
		endif
	endif
	
	if GotParam score
		if ScreenElementExists id=score_text
			FormatText textname=score_string "Score: %i" i=<score>
			SetScreenElementProps id=score_text text=<score_string>
		endif
	endif
	
	if GotParam num_goals
		if ScreenElementExists id=goal_text
			FormatText textname=string "Goals: %i" i=<num_goals>
			SetScreenElementProps id=goal_text text=<string>
		endif
	endif
	
	if GotParam is_male
		if ScreenElementExists id=sex_text
			if ( <is_male> = 1 )
				SetScreenElementProps id=sex_text text="Male"
			else
				SetScreenElementProps id=sex_text text="Female"
			endif
		endif
	endif
	
    if GotParam num_pieces
		if ScreenElementExists id=pieces_text
			FormatText textname=string "Pieces: %i" i=<num_pieces>
			SetScreenElementProps id=pieces_text text=<string>
		endif
	endif
	
	if GotParam num_gaps
		if ScreenElementExists id=gap_text
			FormatText textname=string "Gaps: %i" i=<num_gaps>
			SetScreenElementProps id=gap_text text=<string>
		endif
	endif
	
	if GotParam tod_script
		if ScreenElementExists id=tod_text
			switch <tod_script>
                case set_tod_day
					SetScreenElementProps id=tod_text text="Day"
				case set_tod_night
					SetScreenElementProps id=tod_text text="Night"
				case set_tod_morning
					SetScreenElementProps id=tod_text text="Morning"
				case set_tod_evening
					SetScreenElementProps id=tod_text text="Evening"
				case set_tod_rain
					SetScreenElementProps id=tod_text text="Rain"
				case set_tod_newrain
					SetScreenElementProps id=tod_text text="New Rain"
				case set_tod_snow
					SetScreenElementProps id=tod_text text="Snow"
				case default
					SetScreenElementProps id=tod_text text="Default"
			endswitch
		endif
	endif
	
	if GotParam theme
		if ScreenElementExists id=theme_text
			switch <theme>
				case 0
					SetScreenElementProps id=theme_text text="Suburbia"
				case 1
					SetScreenElementProps id=theme_text text="City Rooftop"
				case 2
					SetScreenElementProps id=theme_text text="Lost Island"
				case 3
					SetScreenElementProps id=theme_text text="Warehouse"
				case 4
					SetScreenElementProps id=theme_text text="Prison Yard"
			endswitch
		endif
	endif
	
	generic_menu_update_arrows menu_id=net_vault_vmenu up_arrow_id=net_vault_menu_up_arrow down_arrow_id=net_vault_menu_down_arrow
endscript

script net_vault_menu_change_text_color
	// update all the text elements
	<child> = 0
	begin
		if ScreenElementExists id={ <id> child=<child> }
			SetScreenElementProps id={ <id> child=<child> } rgba=<rgba>
            child = ( <child> + 1 )
		else
			break
		endif
	repeat
endscript

script net_vault_menu_unfocus
	GetTags
	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	net_vault_menu_change_text_color {
		id=<id>
		rgba=<rgba>
	}
endscript

script refresh_scrolling_menu
	SetScreenElementLock id=net_vault_vmenu on
	SetScreenElementLock id=net_vault_vmenu off
	SetScreenElementLock id=net_vault_vscrollingmenu on
	SetScreenElementLock id=net_vault_vscrollingmenu off
	FireEvent type=focus target=current_menu
endscript

script clear_vault_focus_info
	if ScreenElementExists id=description_text
		SetScreenElementProps id=description_text text=""
	endif
	
	if ScreenElementExists id=score_text
        SetScreenElementProps id=score_text text=""
	endif
	
	if ScreenElementExists id=goal_text
        SetScreenElementProps id=goal_text text=""
	endif
	
	if ScreenElementExists id=sex_text
        SetScreenElementProps id=sex_text text=""
	endif
	
	if ScreenElementExists id=gap_text
        SetScreenElementProps id=gap_text text=""
	endif
	
	if ScreenElementExists id=pieces_text
        SetScreenElementProps id=pieces_text text=""
	endif
	
	if ScreenElementExists id=theme_text
        SetScreenElementProps id=theme_text text=""
	endif
	
	if ScreenElementExists id=tod_text
        SetScreenElementProps id=tod_text text=""
	endif
endscript

script net_vault_menu_prev_category
	printf "********** net_vault_menu_prev_category"
	DestroyScreenElement id=net_vault_vmenu preserve_parent
	clear_vault_focus_info
	PrevVaultCategory
	FillVaultMenu

	// blink arrow
	menu_horiz_blink_arrow arrow_id=net_vault_menu_left_arrow
	
	net_vault_menu_refresh_category <...>
	
	refresh_scrolling_menu
endscript

script net_vault_menu_next_category
	printf "********** net_vault_menu_next_category"
	DestroyScreenElement id=net_vault_vmenu preserve_parent
	clear_vault_focus_info
	NextVaultCategory
	FillVaultMenu
	
	// blink arrow
	menu_horiz_blink_arrow arrow_id=net_vault_menu_right_arrow
	
	net_vault_menu_refresh_category <...>
	
	refresh_scrolling_menu
endscript

script net_vault_menu_refresh_category
    if ( <category> = "Best" )
		text = "Best of the Best"
		rgba=best_green
		star_alpha=1
	else
		text = <category>
		FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
		rgba=<on_rgba>
		star_alpha=0
	endif
    
	// category
	SetScreenElementProps {
		id=net_vault_menu_category		
		text=<text>
		rgba=<rgba>
	}

	// move the right arrow
	GetStackedScreenElementPos X id=net_vault_menu_category offset=(5, 13)
	SetScreenElementProps {
		id=net_vault_menu_right_arrow
		pos=<pos>
	}
	
	// star
	DoScreenElementMorph {
		id=best_star
        alpha=<star_alpha>
	}
	
	SetScreenElementProps{
		 id=net_vault_vmenu
		 event_handlers=[ { pad_left	net_vault_menu_prev_category }
						  { pad_right	net_vault_menu_next_category }
						] replace_handlers
	}
endscript

// *******************************
//	exit script
// *******************************

script back_from_vault
	net_vault_menu_exit
    create_internet_options
endscript

script net_vault_menu_exit
    FreeDirectoryListing
	SetScreenElementLock id=root_window off
	if ScreenElementExists id=vault_bg_anchor
		DestroyScreenElement id=vault_bg_anchor
	endif
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		wait 1 gameframe
		SetScreenElementLock id=root_window off
	endif

    //create_pause_menu
endscript

