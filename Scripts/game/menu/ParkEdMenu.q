// new

script parked_menu_blink_arrow
	RunScriptOnScreenElement id=<id> menu_blink_arrow
endscript

parked_helper_text_pos=(320, 405)


script parked_make_piece_menu {
        total_dims=(430, 60)
		separation=60
	}
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	//printf "=== parked_make_piece_menu"
	SetScreenElementLock Id=root_window Off
	
	if ObjectExists id=piece_menu_container
		DestroyScreenElement Id=piece_menu_container
	endif
	
    CreateScreenElement {
		parent=root_window
		id=piece_menu_container
		type=ContainerElement
		dims=(640, 480)
		pos=(320,240)
		just=[center center]
		event_handlers=[ 
			{parked_menu_left parked_scroll_sideways_sound params={  } }
			{parked_menu_right parked_scroll_sideways_sound params={  } }
			{parked_menu_left parked_menu_blink_arrow params={ id=piece_menu_left_arrow } }
			{parked_menu_right parked_menu_blink_arrow params={ id=piece_menu_right_arrow } }
		]
	}
	
	FormatText ChecksumName=paused_icon "%i_paused_icon" i=(THEME_PREFIXES[current_theme_prefix])
	build_theme_box_icons just_top icon_texture=<paused_icon> parent=piece_menu_container pos=(550,-5) scale=(1.8,2.3)
    build_grunge_piece parent=piece_menu_container rgba=[128 128 128 128]
    build_top_bar scale = (1.48,1.5) pos=(230, 73) parent=piece_menu_container
	CreateScreenElement {
		type=SpriteElement
		parent=piece_menu_container
        // Appended a 2 to avoid a clash
		id=right_bracket2
		
		pos=(575,123)
        texture=generic_sub_frame
        rgba=[128 128 128 128]
        scale = (1.5,1.1)
		alpha=0.8
        z_priority=1
		rot_angle=180
	}
	
	// this still needs to be here or helper text gets killed
    /*
	if isps2
		create_helper_text park_editor_helper_text parent=piece_menu_container helper_pos=parked_helper_text_pos scale=0.9
	else
		if isxbox
			create_helper_text park_editor_helper_text_xbox parent=piece_menu_container helper_pos=parked_helper_text_pos scale=0.9
		else
			create_helper_text park_editor_helper_text_ngc parent=piece_menu_container helper_pos=parked_helper_text_pos scale=0.9
		endif
	endif
    */
	
	// HScrolling Menu
    CreateScreenElement {
		Parent=piece_menu_container
		Type=HScrollingMenu
		Id=piece_menu_scrolling
		just=[left bottom]
		Pos=(235, 141)
		dims=<total_dims>
	
		internal_just=[center center]
		;scroll_speed=<separation>
		
		num_items_to_show=6
	}    
	
	// Hmenu
	CreateScreenElement {
		Parent=piece_menu_scrolling
		Type=HMenu
		Id=piece_menu_hmenu
	   
		just=[center top]
		Pos=(30, 0)
		dims=<total_dims>
	
		internal_just=[left center]
		regular_space_amount=<separation>
		disable_pad_handling
	}
	
    // text
	CreateScreenElement {
		type=TextElement
		parent=piece_menu_container
		id=piece_menu_name_text
		font=dialog
		text="Monkey Stew"
		just=[center center]
		pos=(417,84)
		rgba=<on_rgba>
		scale=0.85
	}		
	
	// left arrow
    CreateScreenElement {
		type=SpriteElement
		parent=piece_menu_container
		id=piece_menu_left_arrow
		texture=left_arrow
		just=[center center]
		pos=(240,83)
        scale=0.8
	}		
	
	// right arrow
	CreateScreenElement {
		type=SpriteElement
		parent=piece_menu_container
		id=piece_menu_right_arrow
		texture=right_arrow
		just=[center center]
		pos=(595,83)
	}	scale=0.8
	
    // 180 - 600
	// slider container
	CreateScreenElement {
		type=ContainerElement
		id=piece_slider_container
		parent=piece_menu_container
		dims=(320,50)
		just=[left top]
		pos=(230, 70)
	}
	
	// slider
	CreateScreenElement {
		type=SpriteElement
		id=piece_slider_orange
		parent=piece_slider_container
		dims=(4,4)
		scale=(26.0, 1.5)
		rgba=<on_rgba>
		alpha=1.0
		just=[left top]
		z_priority=5
	}
	
	// slider bg
	CreateScreenElement {
		type=SpriteElement
		id=piece_slider_gray
		parent=piece_slider_container
		dims=(4,4)
		scale=(95, 1.2)
		rgba=[31 31 31 128]
		alpha=1.0
		just=[left top]
		z_priority=4
	}

endscript




script parked_destroy_piece_menu
	//printf "=== parked_destroy_piece_menu"
	if ObjectExists id=piece_menu_container
		DestroyScreenElement Id=piece_menu_container
	endif
	//printf "kill it nowwwwwwww"
endscript




script parked_make_piece_menu_item {
		item_dims=(50, 50)
		item_midpoint=(30, 25)
	}
	//printf "=== parked_make_piece_menu_item"
	SetScreenElementLock Id=piece_menu_hmenu Off
	
	CreateScreenElement {
		Parent=piece_menu_hmenu
		Type=ContainerElement
		Id=<metapiece_id>
	   
		dims=<item_dims>
		just=[center center]

		event_handlers=[		
            {focus   parked_piece_focus_script}		
			{unfocus parked_piece_unfocus_script}		
		]
	}    
	
    FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	CreateScreenElement {
		type=SpriteElement
		parent=<metapiece_id>
		texture=parked_piece_frame
		scale=(0.859,0.859)
		alpha=0
		just=[center center]
		pos=<item_midpoint>
		rgba=<on_rgba>
	} 
	
    if GotParam ClipBoardIndex
        FormatText TextName=text "%d" d=<ClipBoardIndex>
    	CreateScreenElement {
    		Parent=<metapiece_id>
    		type=TextElement
    		font=dialog
    		text=<text>
    		just=[center center]
    		pos=(30,35)
    		scale=1
            }
    else    
        if GotParam EmptyClipBoard
        	CreateScreenElement {
        		Parent=<metapiece_id>
        		type=TextElement
        		font=dialog
        		text='None'
        		just=[center center]
        		pos=(30,35)
        		scale=1
                }
        else        
        	// test: create 3D menu element
        	CreateScreenElement {
        		Parent=<metapiece_id>
        		Type=Element3d
        	   
        		Sector=<sector>
        		Sectors=<sectors>
        		Pos=<item_midpoint>
        		dims=<item_dims>
        		just=[center center]
        		CameraZ=-6
        		Scale=0.85
        		//Tilt=<tilt>
        	   
        		anglex=.5
        		angley=.785
        		;AngVelY=.05
        		scale_to_screen_dims
        	} 
        endif    
    endif	
endscript




script parked_piece_focus_script
GetTags
DoScreenElementMorph {
	id={<id> child=1}
	scale=1.2
	time=.25
    
}
DoScreenElementMorph id={<id> child=0} scale=1.275 alpha=.55
endscript




script parked_piece_unfocus_script
;printf "=== parked_piece_unfocus_script"
GetTags
DoScreenElementMorph {
	id={<id> child=1}
	scale=.85
	time=.25
}
DoScreenElementMorph id={<id> child=0} scale=1.275 alpha=0
endscript




script parked_set_helper_text_mode
if not ObjectExists id=piece_menu_container
// cheap fix
AddParams failed
return
endif

// new helper text always kills current helper text
SetScreenElementLock id=piece_menu_container off
switch <mode>
case regular
    if isps2
		create_helper_text park_editor_helper_text parent=piece_menu_container helper_pos=parked_helper_text_pos scale=0.9
	else
		if isxbox
			create_helper_text park_editor_helper_text_xbox parent=piece_menu_container helper_pos=parked_helper_text_pos scale=0.9
		else
			create_helper_text park_editor_helper_text_ngc parent=piece_menu_container helper_pos=parked_helper_text_pos scale=0.9
		endif
	endif
    // Triangle=delete X=accept Square/Circle=Rotate L1/L2=Raise/Lower
	//printf "Regular helper text"

case gap_regular
    if isps2
		create_helper_text gap_regular_helper_text parent=piece_menu_container helper_pos=parked_helper_text_pos scale=0.9
	else
		if isxbox
			create_helper_text gap_regular_helper_text_xbox parent=piece_menu_container helper_pos=parked_helper_text_pos scale=0.9
		else
			create_helper_text gap_regular_helper_text_ngc parent=piece_menu_container helper_pos=parked_helper_text_pos scale=0.9
		endif
	endif
	// Triangle=remove gap X=place gap
	//printf "gap cursor helper text"

case gap_adjust
    if isps2
		create_helper_text gap_adjust_helper_text parent=piece_menu_container helper_pos=parked_helper_text_pos
	else
		if isxbox
			create_helper_text gap_adjust_helper_text_xbox parent=piece_menu_container helper_pos=parked_helper_text_pos
		else
			create_helper_text gap_adjust_helper_text_ngc parent=piece_menu_container helper_pos=parked_helper_text_pos
		endif
	endif
	// Triangle=remove gap Square/Circle=Rotate L1/L2=Adjust left edge R1/R2=Adjust right edge
	//printf "gap adjustment helper text"
	
case rail_placement
    helper_text=park_editor_helper_text
    RailEditor:GetEditingMode
	<scale>=0.9
    // TODO: Check what the buttons will be on XBox & NGC, maybe they'll be the same?    
    switch <mode>
        case FreeRoaming
            helper_text=rail_editor_free_roam_helper_text
			<scale> = 0.8
        case RailLayout
            helper_text=rail_editor_layout_helper_text
			<scale> = 0.9
        case Grab
            helper_text=rail_editor_grab_helper_text                
			<scale> = 0.9
    endswitch        

	if isXBox
		switch <mode>
        case FreeRoaming
            helper_text=rail_editor_free_roam_helper_text_xbox
			<scale> = 0.8
		case RailLayout
            helper_text=rail_editor_layout_helper_text_xbox
			<scale> = 0.9
        case Grab
            helper_text=rail_editor_grab_helper_text_xbox                
			<scale> = 0.9
		endswitch
	endif
	
	if isNGC
		switch <mode>
        case FreeRoaming
            helper_text=rail_editor_free_roam_helper_text_ngc
			<scale> = 0.8
        case RailLayout
            helper_text=rail_editor_layout_helper_text_ngc
			<scale> = 0.9
        case Grab
            helper_text=rail_editor_grab_helper_text_ngc                
			<scale> = 0.9
		endswitch
	endif
	
    create_helper_text <helper_text> parent=piece_menu_container helper_pos=parked_helper_text_pos scale=<scale>
    
default
      //printf "Nothing matches !!"
endswitch
SetScreenElementLock id=piece_menu_container on
endscript

script parked_make_set_menu {
		corner_pos=(10, 30)
		top_arrow_pos=(100, 8)
		bottom_arrow_pos=(100, 85)
		item_spacing=19
		menu_offset_from_top=(33,5)
	}
	;printf "=== parked_make_set_menu"
	
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	
	SetScreenElementLock Id=root_window Off
	if ObjectExists id=set_menu_container
		// do nothing   
	else
		make_new_menu {
			menu_id=set_menu_container
			
			;scrolling_menu_title_id=sbg_title
			;menu_title="i am title"
			
			type=VScrollingMenu
			scrolling_menu_id=set_menu_scrolling
			scrolling_menu_offset=(0, 0)		
			just=[left top]
			internal_just=[center center]
			pos=(150,40)
			dims=(150, 120)
			
			vmenu_id=set_menu_vertical
			regular_space_amount=<item_spacing>
			;padding_scale=.5
			internal_scale=0.5
			dont_allow_wrap=1
			num_items_to_show=5
			;scale=1.0
		}
		
		SetScreenElementProps {
			id=set_menu_container
			event_handlers=[ 
				{parked_menu_up generic_menu_up_or_down_sound params={ Up } }
				{parked_menu_down generic_menu_up_or_down_sound params={ Down } }
				{parked_menu_up parked_menu_blink_arrow params={ id=set_menu_up_arrow } }
				{parked_menu_down parked_menu_blink_arrow params={ id=set_menu_down_arrow } }
			]
		}
		
        // up arrow
		CreateScreenElement {
			type=SpriteElement
			parent=set_menu_container
			id=set_menu_up_arrow
			texture=up_arrow
			just=[center center]
			pos=(200,30)
			scale=0.8
		}		
		
		// down arrow
		CreateScreenElement {
			type=SpriteElement
			parent=set_menu_container
			id=set_menu_down_arrow
			texture=down_arrow
			just=[center center]
			pos=(200,138)
			scale=0.8
		}
		
		// bg
		theme_background {
			parent=set_menu_container
			id=set_bg
			width=1.15
			pos=(130,20)
			num_parts=3.00
			use_mm_parts=use_mm_parts
			bg_rgba=[60 60 60 128]
		}
		
	endif
	
	if not ObjectExists id=percent_bar
		// make percent bar
		CreateScreenElement {
			type=SpriteElement
			parent=root_window
			id=percent_bar
			just=[left top]
			pos=(20,410)
			rgba=[0 0 0 100]
			dims=(600,12)
		}		
	
		CreateScreenElement {
			type=SpriteElement
			parent=percent_bar
			id=percent_bar_colored_part
			just=[left top]
			pos=(0,0)
			rgba=<on_rgba>
			dims=(600,12)
		}		
	endif

    /*
	if not ObjectExists id=clipboard_percent_bar
		// make percent bar
		CreateScreenElement {
			type=SpriteElement
			parent=root_window
			id=clipboard_percent_bar
			just=[left top]
			pos=(20,410)
			rgba=[0 0 0 100]
			dims=(600,12)
		}		
	
		CreateScreenElement {
			type=SpriteElement
			parent=clipboard_percent_barF
			id=clipboard_percent_bar_colored_part
			just=[left top]
			pos=(0,0)
			rgba=<off_rgba>
			dims=(600,12)
		}		
	endif
    */
	SetScreenElementLock Id=root_window On
    wait .2 seconds
	;FireEvent Target=current_menu type=pad_up
	;SetScreenElementProps id=set_menu_scrolling unpause
	;SetScreenElementProps id=set_menu_vertical unpause
	
endscript


script parked_make_set_menu_item

	SetScreenElementLock Id=current_menu Off
	;printf "=== parked_make_set_menu_item"
	;make_text_sub_menu_item text=<set_name> scale=.75 no_choose_sound
	theme_menu_add_item text=<set_name> no_choose_sound no_bg no_highlight_bar=no_highlight_bar
	SetScreenElementLock Id=current_menu On

endscript




script parked_destroy_set_menu
	//printf "=== parked_destroy_set_menu"
	if ObjectExists id=set_menu_container
		DestroyScreenElement Id=set_menu_container
	endif
    
	if ObjectExists id=percent_bar
		DestroyScreenElement Id=percent_bar
	endif
    /*
	if ObjectExists id=clipboard_percent_bar
		DestroyScreenElement Id=clipboard_percent_bar
	endif
    */
endscript




script parked_lock_piece_and_set_menus
	;printf "=== parked_lock_piece_and_set_menus"
	SetScreenElementLock Id=piece_menu_hmenu on
	SetScreenElementLock Id=piece_menu_scrolling on
	SetScreenElementLock Id=set_menu_scrolling on
	SetScreenElementLock Id=set_menu_vertical on
	//FireEvent type=focus target=set_menu_scrolling
	//FireEvent type=focus target=set_menu_vertical
	FireEvent type=unfocus target={set_menu_vertical child=<last_set_number>}
	FireEvent type=focus target={set_menu_vertical child=<set_number>}
endscript

