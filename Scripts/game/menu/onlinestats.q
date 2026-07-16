script download_stats
    printf "download stats."
    if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
    if NeedToRetrieveTopStats
        RetrieveTopStats file=0
		dialog_box_exit
        create_dialog_box { title=net_status_msg
						text="Retrieving stats."
						no_animate
                        }
    else
        create_online_stats_menu
    endif
endscript

script download_more_stats
    RetrieveTopStats
endscript

script StatsRetrievalFailed
    printf "transfer failed."
    dialog_box_exit
    create_dialog_box { title="Transfer Failed"
						text="Could not retrieve stats. Try again later or check your network cables."
						buttons=[ { text="ok" pad_choose_script=online_stats_exit } 
                                ]
                      }
endscript

script stats_retrieval_complete
    //FillStatsArrays
    create_online_stats_menu
endscript

script create_online_stats_menu
	dialog_box_exit
	pulse_blur
	
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
		id=stats_bg_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	AssignAlias id=stats_bg_anchor alias=current_menu_anchor
	create_helper_text generic_helper_text_up_down_left_right
	
    FormatText ChecksumName=title_icon "%i_online" i=(THEME_PREFIXES[current_theme_prefix])
    build_theme_sub_title title="ONLINE STATS" title_icon=<title_icon>
    
	build_top_and_bottom_blocks bot_z=15
	make_mainmenu_3d_plane
	
    // anchor for menu
	CreateScreenElement {
		type=ContainerElement
		parent=stats_bg_anchor
		id=stats_menu_anchor
		
		dims=(640, 480)
		pos=(320, 840)
	}
	AssignAlias id=stats_menu_anchor alias=current_menu_anchor
	
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
	CreateScreenElement {
		type=textElement
		parent=current_menu_anchor
		id=subtitle
		text=""
		scale=1.4
		font=small
		rgba=<on_rgba>
		pos=(170,85)
        just=[center center]
		z_priority=30
	}
	
	// left arrow
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        
		id=left_arrow
		texture=left_arrow
		scale=(1,1)
		pos=(60,83)
        just=[right center]
		alpha=0.5
		z_priority=30
	}
	
	// right arrow
	CreateScreenElement {
		type=spriteElement
		parent=current_menu_anchor
        
		id=right_arrow
		texture=right_arrow
		scale=(1,1)
		pos=(280,83)
        just=[left center]
		alpha=0.5
		z_priority=3
	}
	
	// time text
	CreateScreenElement {
		type=textElement
		parent=stats_bg_anchor
		id=timetext
		text=""
		scale=1.2
		font=small
		rgba=<off_rgba>
		pos=(465,67)
        just=[center bottom]
		z_priority=5
	}
	
	// mini map
	CreateScreenElement {
		type=spriteElement
		parent=stats_bg_anchor
        
        texture=mini_map
		scale=(1.8,1.3)
		pos=(380,67)
        just=[left bottom]
		alpha=0.5
		z_priority=5
	}
	
	CreateScreenElement {
		type=HMenu
		parent=current_menu_anchor
		id=top_hmenu
		
		pos=(300,62)
		just=[left top]
		padding_scale=0.75
        event_handlers=[ { pad_back		generic_menu_pad_back params={ callback=online_stats_exit }}
						 { pad_left 	generic_menu_up_or_down_sound params={ up } }
						 { pad_right	generic_menu_up_or_down_sound params={ down } }
						 ;{ pad_back		generic_menu_pad_back_sound }
					   ]
	}
	
    GetArraySize online_stats_categories
	index=0
	begin
		online_stats_hmenu_add_item index=<index>
		index = ( <index> + 1 )
	repeat <array_size>
	
    
    // globe
	CreateScreenElement {
		type=spriteElement
		parent=stats_bg_anchor
		id=globe
		texture=globe
		scale=1.3
		pos=(320,560)
        just=[center center]
		alpha=0.3
		z_priority=-1
	}
	
	RunScriptOnScreenElement id=globe rotate_internet_options_globe
    RunScriptOnScreenElement id=stats_menu_anchor online_stats_animate_in
    FireEvent type=focus target=top_hmenu
endscript

script online_stats_animate_in id=stats_menu_anchor
	wait 2 gameframes
	PlaySound DE_MenuFlyUp vol=100
	
	if LevelIs load_skateshop
		DoScreenElementMorph id=<id> time=0.2 pos=(320,240)
	else
		if ScreenElementExists id=top_bar_anchor
			DoScreenElementMorph id=top_bar_anchor time=0.2 pos=(0,62)
		endif
	
		DoScreenElementMorph id=<id> time=0.2 pos=(320,265)
	endif
  
endscript

script online_stats_exit
	KillSpawnedScript name=create_online_stat_scores_menu
	KillSpawnedScript name=create_online_stat_players_menu
	KillSpawnedScript name=create_online_stat_personal_menu
	
	if ScreenElementExists id=stats_bg_anchor
		DestroyScreenElement id=stats_bg_anchor
	endif
	create_internet_options
endscript

script online_stats_hmenu_add_item
	icon = ( online_stats_categories[<index>].icon )
	text = ( online_stats_categories[<index>].text )
	time = ( online_stats_categories[<index>].time )
	array = ( online_stats_categories[<index>].array )
	menu_type = ( online_stats_categories[<index>].menu_type )
	
	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	CreateScreenElement {
		type=SpriteElement
		parent=top_hmenu
		texture=<icon>
		rgba=<rgba>
		scale=0.7
		z_priority=3
		event_handlers=[ { focus	online_stats_hmenu_focus params={ text=<text> menu_type=<menu_type> time=<time> array=<array> warned=no} }
						 { unfocus	online_stats_hmenu_unfocus } 
					   ]
	}
endscript

script online_stats_hmenu_focus
	GetTags
	FormatText ChecksumName=rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetScreenElementProps id=<id> rgba=<rgba>
	SetScreenElementProps id=subtitle text=<text>
	
	
	GetTextElementString id=timetext
	// time text
	if ( <time> = all )
		if not ( <string> = "all time" )
			RunScriptOnScreenElement online_stats_swap_time_text id=timetext params={ text="all time" }
		endif
	endif
    if ( <time> = week )
		if not ( <string> = "recent" )
			RunScriptOnScreenElement online_stats_swap_time_text id=timetext params={ text="recent" }
		endif
	endif
	
	KillSpawnedScript name=create_online_stat_scores_menu
	KillSpawnedScript name=create_online_stat_players_menu
	KillSpawnedScript name=create_online_stat_personal_menu
	
	// menu
    if ( <menu_type> = scores )
		SpawnScript create_online_stat_scores_menu params={ array=<array> }
	endif
    if ( <menu_type> = players )
		SpawnScript create_online_stat_players_menu params={ array=<array> }
	endif
    if ( <menu_type> = personal )
		// Show a warning if they're not logged on to Gamespy
		if not ProfileLoggedIn
			if(<warned>=no)
				FireEvent type=Unfocus target=top_hmenu
				create_dialog_box { title="No Stats"
							text="You are not logged into GameSpy.\n You must be logged into GameSpy in order to record stats."
							buttons=[ { text="ok" pad_choose_script=ok_no_personal_stats} 
									]
							text_dims=(380,0)
							no_bg
							pad_left_script=dialog_box_exit 
							pad_right_script=dialog_box_exit
						  }
				SetTags warned=yes
			endif
		endif
		
		// Get name and rank
        GetRank
        GetPreferenceString pref_type=network network_id
		SpawnScript create_online_stat_personal_menu params={ array=<array> name=<ui_string> rank=<rank> }
	endif
endscript

script ok_no_personal_stats
	dialog_box_exit
	
	wait 2 frames
	FireEvent type=focus target=top_hmenu

endscript

script online_stats_swap_time_text time=0.2
	DoScreenElementMorph id=timetext scale=(0,1) relative_scale time=<time>
	wait (<time> + 0.1) seconds
	SetScreenElementProps id=timetext text=<text>
	DoScreenElementMorph id=timetext scale=(1,1) relative_scale time=<time>
endscript

script online_stats_hmenu_unfocus
	GetTags
	FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetScreenElementProps id=<id> rgba=<rgba>
endscript

online_stats_categories = [ 
	{ text="Best Scores" icon=stat_scores menu_type=scores time=week array=high_scores_array_monthly }
	{ text="Best Combos" icon=stat_combos menu_type=scores time=week array=best_combos_array_monthly }
    { text="Top Players" icon=stat_players menu_type=players time=all array=top_players_array }
    { text="Best Scores" icon=stat_scores menu_type=scores time=all array=high_scores_array_all_time }
	{ text="Best Combos" icon=stat_combos menu_type=scores time=all array=best_combos_array_all_time }
    { text="Personal Stats" icon=stat_personal menu_type=personal time=all array=personal_stats_array }
]

high_scores_array_all_time = []
best_combos_array_all_time = []
high_scores_array_monthly = []
best_combos_array_monthly = []
top_players_array = []
personal_stats_array = []
/*best_scores_array = [
	{ name="WWWWWWWWWWWWWWW" level="NYC" date="12/25/03" score=1234567890 rating=216 rank=1 }
    { name="ProSkater" level="NYC" date="12/25/03" score=123456789 rating=216 rank=1 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=12345678 rating=216 rank=2 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1234567 rating=216 rank=3 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=123456 rating=216 rank=4 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=12345 rating=216 rank=5 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1234 rating=216 rank=6 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=123 rating=216 rank=7 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=12 rating=216 rank=8 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1 rating=216 rank=9 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1234567 rating=216 rank=10 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1234567 rating=216 rank=9 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1234567 rating=216 rank=8 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1234567 rating=216 rank=7 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1234567 rating=216 rank=6 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1234567 rating=216 rank=5 }
	{ name="ProSkater" level="NYC" date="12/25/03" score=1234567 rating=216 rank=4 }
	{ name="WWWWWWWWWWWWWWW" level="NYC" date="12/25/03" score=1234567 rating=216 rank=3 }
]*/

script create_online_stat_scores_menu
	if ScreenElementExists id=online_stats_submenu_anchor
		DestroyScreenElement id=online_stats_submenu_anchor
	endif
	
	wait 5 gameframes
	
	SetScreenElementLock off id=stats_menu_anchor
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=stats_menu_anchor
		id=online_stats_submenu_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	
	// Name
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Name"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(90,115)
        just=[left center]
	}
	
	// up arrow
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        
		id=up_arrow
		texture=up_arrow
		scale=1
		pos=(260,115)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// down arrow
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        
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
		parent=online_stats_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(320,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Level
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Level"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(325,115)
        just=[left center]
	}
	
	// black line
	/*CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(380,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}*/
	
	// Date
	/*CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Date"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(390,115)
        just=[left center]
	}*/
	
	// black line
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(450,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Score
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Score"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(480,115)
        just=[left center]
	}
	
	// scrolling vmenu
	CreateScreenElement {
		type=vscrollingmenu
		parent=online_stats_submenu_anchor
		id=bottom_scrolling_menu
		
        just=[left top]
		dims=(600,210)
		pos=(100,135)
		alpha=0
	}
	
	// vmenu
    CreateScreenElement {
		type=vmenu
		parent=bottom_scrolling_menu
		id=bottom_vmenu
		
		pos=(0,0)
		just=[left top]
		event_handlers=[ { pad_up 		generic_menu_up_or_down_sound params={ up } }
						 { pad_down		generic_menu_up_or_down_sound params={ down } }
						 ;{ pad_back 	back_to_online_stats_top_hmenu }
					   ]
		dont_allow_wrap
	}
	
    FillStatsArrays array=<array>
    /*GetArraySize <array>
	index=0
	begin
		name = ( (<array>[<index>]).name )
		level = ( (<array>[<index>]).level )
		date = ( (<array>[<index>]).date )
		score = ( (<array>[<index>]).score )
		rank = ( (<array>[<index>]).rank )
		add_stat_score_menu_item name=<name> level=<level> date=<date> score=<score> rank=<rank>
		;add_stat_header_menu_item text="Level: New Jersey"
        index = ( <index> + 1 )
	repeat <array_size>*/
	
	wait 2 gameframes
	pulse_blur
	SetScreenElementProps id=bottom_scrolling_menu reset_window_top
	DoScreenElementMorph id=bottom_scrolling_menu alpha=1
	
	FireEvent type=focus target=bottom_vmenu		
endscript

script add_stat_score_menu_item
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	CreateScreenElement {
		type=ContainerElement
		parent=bottom_vmenu
		dims=(400,15)
		event_handlers=[ { focus 		online_stats_generic_focus }
						 { unfocus		online_stats_generic_unfocus }
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
	
	// level
	CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		text=<level>
		font=dialog
		scale=0.8
		pos=(235,0)
		just=[left center]
		rgba=<off_rgba>
	}
	
	// date
	/*CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		text=<date>
		font=dialog
		scale=0.8
		pos=(290,0)
		just=[left center]
		rgba=<off_rgba>
	}*/
	
	// score
    FormatText textname=score_text "%i" i=<score> UseCommas
	CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		text=<score_text>
		font=dialog
		scale=0.8
		pos=(490,0)
		just=[right center]
		rgba=<off_rgba>
	}
	
endscript

script add_stat_header_menu_item
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
    
	CreateScreenElement {
		type=ContainerElement
		parent=bottom_vmenu
		dims=(400,15)
		;not_focusable
	}
	anchor_id=<id>
	
	// highlight bar
    CreateScreenElement {
		type=spriteElement
		parent=<anchor_id>
		
		texture=white2
        scale=(70,2)
		pos=(-55,0)
		just=[left center]
		rgba=[0 0 0 128]
        z_priority=2
	}
	
    // text
	CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		text=<text>
		font=dialog
		scale=0.8
		pos=(-10,0)
		just=[left center]
		rgba=<on_rgba>
	}
	
endscript

script online_stats_generic_focus
	GetTags
    
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// highlight bar
	DoScreenElementMorph id={ <id> child=0 } alpha=1
	
	index=2	// skip 0=highlight bar 1=icon
	begin
		if ScreenElementExists id={ <id> child=<index> }
			SetScreenElementProps id={ <id> child=<index> } rgba=<on_rgba>
		else
			break
		endif
		index = ( <index> + 1 )
	repeat
endscript

script online_stats_generic_unfocus
	GetTags
	
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// highlight bar
	DoScreenElementMorph id={ <id> child=0 } alpha=0
	
	index=2	// skip 0=highlight bar 1=icon
	begin
		if ScreenElementExists id={ <id> child=<index> }
			SetScreenElementProps id={ <id> child=<index> } rgba=<off_rgba>
		else
			break
		endif
		index = ( <index> + 1 )
	repeat
endscript

script create_online_stat_players_menu
	if ScreenElementExists id=online_stats_submenu_anchor
		DestroyScreenElement id=online_stats_submenu_anchor
	endif
	
	wait 5 gameframes
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	SetScreenElementLock off id=stats_menu_anchor
	
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=stats_menu_anchor
		id=online_stats_submenu_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	
	// Name
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Name"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(90,115)
        just=[left center]
	}
	
	// up arrow
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        
		id=up_arrow
		texture=up_arrow
		scale=1
		pos=(260,115)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// down arrow
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        
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
		parent=online_stats_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(320,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Rating
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Rating"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(330,115)
        just=[left center]
	}
	
	// black line
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(405,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Highest Score
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Highest Score"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(415,115)
        just=[left center]
	}
	
	// scrolling vmenu
	CreateScreenElement {
		type=vscrollingmenu
		parent=online_stats_submenu_anchor
		id=bottom_scrolling_menu
		
        just=[left top]
		dims=(600,210)
		pos=(100,135)
		alpha=0
	}
	
	// vmenu
    CreateScreenElement {
		type=vmenu
		parent=bottom_scrolling_menu
		id=bottom_vmenu
		
		pos=(0,0)
		just=[left top]
		event_handlers=[ { pad_up 		generic_menu_up_or_down_sound params={ up } }
						 { pad_down		generic_menu_up_or_down_sound params={ down } }
						 ;{ pad_back 	back_to_online_stats_top_hmenu }
					   ]
		dont_allow_wrap
	}
	
    FillStatsArrays array=<array>
    /*GetArraySize <array>
	index=0
	begin
		name = ( (<array>[<index>]).name )
        rating = ( (<array>[<index>]).rating )
		score = ( (<array>[<index>]).score )
		rank = ( (<array>[<index>]).rank )
		add_stat_player_menu_item name=<name> rating=<rating> score=<score> rank=<rank>
        index = ( <index> + 1 )
	repeat <array_size>*/
	
	wait 2 gameframes
	pulse_blur
	SetScreenElementProps id=bottom_scrolling_menu reset_window_top
	DoScreenElementMorph id=bottom_scrolling_menu alpha=1
	
	FireEvent type=focus target=bottom_vmenu
endscript

script add_stat_player_menu_item
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	CreateScreenElement {
		type=ContainerElement
		parent=bottom_vmenu
		dims=(400,15)
		event_handlers=[ { focus 		online_stats_generic_focus }
						 { unfocus		online_stats_generic_unfocus }
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
	
	// rating
	FormatText textname=rating_text "%i" i=<rating>
	CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		text=<rating_text>
		font=dialog
		scale=0.8
		pos=(295,0)
		just=[right center]
		rgba=<off_rgba>
	}
	
    // score
	FormatText textname=score_text "%i" i=<score> UseCommas
	CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		text=<score_text>
		font=dialog
		scale=0.8
		pos=(490,0)
		just=[right center]
		rgba=<off_rgba>
	}
	
endscript

script create_online_stat_personal_menu name_text=""
	if ScreenElementExists id=online_stats_submenu_anchor
		DestroyScreenElement id=online_stats_submenu_anchor
	endif
	
	wait 5 gameframes
	
	SetScreenElementLock off id=stats_menu_anchor
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	// anchor for everything
	CreateScreenElement {
		type=ContainerElement
		parent=stats_menu_anchor
		id=online_stats_submenu_anchor
		
		dims=(640, 480)
		pos=(320, 240)
	}
	
	// More Black...
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        texture=white2
		scale=(71.3,4)
		pos=(35,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// red line
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        texture=white2
		scale=(71.3,0.1)
		pos=(35,132)
        just=[left top]
		rgba=<on_rgba>
        z_priority=3
	}
	
	// Name
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Name:"
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		alpha=0.5
		pos=(50,115)
        just=[left center]
	}
    CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        id=name_value
		text=<name>
		scale=1
		font=dialog
		rgba=<off_rgba>
		pos=(105,115)
        just=[left center]
	}
	
	if not GotParam rank
		rank=0
	endif
	FormatText textName=rank_text "%i" i=<rank>
	
	// Rating
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Rating:"
		scale=0.8
		font=dialog
		rgba=<off_rgba>
		alpha=0.5
		pos=(300,115)
        just=[left center]
	}
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
		id=rating_value
        text=<rank_text>
		scale=1
		font=dialog
		rgba=<off_rgba>
		pos=(380,115)
        just=[right center]
	}
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="/10"
		scale=1
		font=dialog
		rgba=<off_rgba>
		pos=(415,115)
        just=[right center]
	}
	
	// Rank Icon
    FormatText checksumname=rank_icon "rank_%i" i=<rank>
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
		id=rating_icon
		
		texture=<rank_icon>
        scale=0.8
		pos=(425,115)
		just=[left center]
	}
	
	// Score
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Score"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(180,145)
        just=[left center]
	}
	
	// up arrow
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        
		id=up_arrow
		texture=up_arrow
		scale=1
		pos=(260,145)
        just=[center center]
		alpha=0.5
		z_priority=3
	}
	
	// down arrow
	CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        
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
		parent=online_stats_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(320,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}
	
	// Level
	CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Level"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(330,145)
        just=[left center]
	}
	
    // black line
	/*CreateScreenElement {
		type=spriteElement
		parent=online_stats_submenu_anchor
        texture=white2
		scale=(0.8,28.3)
		pos=(480,127)
        just=[left top]
		rgba=[0 0 0 128]
		alpha=0.8
		z_priority=2
	}*/
	
	// Date
	/*CreateScreenElement {
		type=textElement
		parent=online_stats_submenu_anchor
        text="Date"
		scale=1
		font=dialog
		rgba=<on_rgba>
		pos=(490,145)
        just=[left center]
	}*/
	
    // scrolling vmenu
	CreateScreenElement {
		type=vscrollingmenu
		parent=online_stats_submenu_anchor
		id=bottom_scrolling_menu
		
        just=[left top]
		dims=(600,180)
		pos=(100,165)
		alpha=0
	}
	
	// vmenu
    CreateScreenElement {
		type=vmenu
		parent=bottom_scrolling_menu
		id=bottom_vmenu
		
		pos=(0,0)
		just=[left top]
		event_handlers=[ { pad_up 		generic_menu_up_or_down_sound params={ up } }
						 { pad_down		generic_menu_up_or_down_sound params={ down } }
					   ]
		dont_allow_wrap
	}
	
    FillStatsArrays array=<array>
    /*GetArraySize <array>
	index=0
	begin
        score = ( (<array>[<index>]).score )
		rank = ( (<array>[<index>]).rank )
		date = ( (<array>[<index>]).date )
		level = ( (<array>[<index>]).level )
		if ( <index> = 0 )
			add_stat_header_menu_item text="High Scores"
		endif
		if ( <index> = 11 )
			add_stat_header_menu_item text="Best Combos"
		endif
		add_stat_personal_menu_item date=<date> level=<level> score=<score> rank=<rank>
        index = ( <index> + 1 )
	repeat <array_size>*/
	
	wait 2 gameframes
	pulse_blur
	SetScreenElementProps id=bottom_scrolling_menu reset_window_top
	DoScreenElementMorph id=bottom_scrolling_menu alpha=1
	
	FireEvent type=focus target=bottom_vmenu
endscript

script add_stat_personal_menu_item
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	CreateScreenElement {
		type=ContainerElement
		parent=bottom_vmenu
		dims=(400,15)
		event_handlers=[ { focus 		online_stats_generic_focus }
						 { unfocus		online_stats_generic_unfocus }
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
	;FormatText checksumname=rank_icon "rank_%i" i=<rank>
	CreateScreenElement {
		type=spriteElement
		parent=<anchor_id>
		
		texture=black;<rank_icon>
        scale=0.0
		pos=(-60,0)
		just=[left center]
	}
	
    // score
	FormatText textname=score_text "%i" i=<score> UseCommas
	CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		text=<score_text>
		font=dialog
		scale=0.8
		pos=(200,0)
		just=[right center]
		rgba=<off_rgba>
	}
	
	// level
	CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		text=<level>
		font=dialog
		scale=0.8
		pos=(235,0)
		just=[left center]
		rgba=<off_rgba>
	}
	
	// date
	/*CreateScreenElement {
		type=textElement
		parent=<anchor_id>
		
		text=<date>
		font=dialog
		scale=0.8
		pos=(390,0)
		just=[left center]
		rgba=<off_rgba>
	}*/
endscript

stats_level_names = [
    { text="New Jersey" level=load_NJ }
    { text="Manhattan" 	level=load_NY }
    { text="Tampa" 		level=load_FL }
    { text="San Diego" 	level=load_SD }
    { text="Hawaii" 	level=load_HI }
    { text="Vancouver" 	level=load_VC }
    { text="SCJ" 		level=load_SJ }
    { text="Moscow" 	level=load_RU }
    { text="Hotter than Hell" 	level=load_SE }
    { text="Your House" 	level=load_cas }
	{ text="Peralta's Skateshop" level=load_boardshop }
	{ text="Created Park" 		level=load_sk5ed_gameplay }
    { text="School" 			level=load_SC }
    { text="Downhill Jam" 	level=load_DJ }
    { text="Philly" 		level=load_PH }
    { text="Venice" 		level=load_VN }
    { text="Hangar" 		level=load_HN }
    { text="School II" 		level=load_SC2 }
    { text="West Side" 			level=load_WWW }
]
