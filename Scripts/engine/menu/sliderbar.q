script sliderbar_rescale_to_bar
	<target1> = ( ( <value> - <min> ) / ( <max> - <min> ) )
	<target2> = ( <right> - <left> )
	<target3> = ( <target1> * <target2> )
	<rescaled_value> = ( <target3> + <left> )
	return x_val = <rescaled_value>
endscript

script sliderbar_add_item { pad_choose_script=edit_skater_create_cas_menu
								   focus_script=edit_skater_menu_focus
								   unfocus_script=edit_skater_menu_unfocus
								   tab=tab1
								   font=small
								   icon_rgba=[127 102 0 128]
								   icon_scale=0
								   icon_pos=(22, 9)
								   text_just=[center center]
								   text_pos=(0, 0)
								   arrow_pos_up=(0, 8)
								   arrow_pos_down=(0, -8)
								   arrow_rgba=[128 128 128 128]
								   up_arrow_texture=up_arrow
								   down_arrow_texture=down_arrow
								   
								   dims=(0,20)
								}

	// abort early if the menu item is not enabled...
	// (later on, should gray it out instead)								
	if GotParam is_enabled_script
		<is_enabled_script>
		if ( <success> = 0 )
			return
		endif
	endif
	
	
	// figure the right scale for the highlight bar
	switch <tab>
	case tab1
		<bar_scale>=(.92, 1.2)
	case tab2
		<bar_scale>=(.85, 1.2)
	case tab3
		<bar_scale>=(.78, 1.2)
		<font>=dialog 
	endswitch	
	
	SetScreenElementLock id=current_menu off	
	
	if not GotParam pad_choose_params
		<pad_choose_params> = <...>
	endif
	
	// create a container for this vmenu element
	if GotParam index
		if GotParam pad_choose_params
			<pad_choose_params> = ( <pad_choose_params> + { parent_index=<index> } )
		else
			<pad_choose_params> = { parent_index=<index> }
		endif
	endif
	CreateScreenElement {
		type=ContainerElement
		parent=current_menu
		id=<anchor_id>
		
		//font=small
		//text=" "
		
		dims=<dims>
		
		event_handlers=[ { focus		<focus_script> params=<focus_params> }
						 { unfocus		<unfocus_script> params=<unfocus_params> }
						 { pad_choose	<pad_choose_script> params=<pad_choose_params> }
					   ]
		<not_focusable>
		z_priority=300
	}
	
	<parent_id> = <id>
	
	if GotParam index
		SetScreenElementProps {
			id=<parent_id>
			tags={ tag_grid_x=<index> }
		}
	endif
		
	// add the text
	if GotParam not_focusable
		<rgba> = [60 60 60 85]
	else
		FormatText ChecksumName=rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	endif
	
	CreateScreenElement {
		type=TextElement
		parent=<parent_id>
		
		font=<font>
		text=<text>
		scale=.9
		rgba=<rgba>
		just=<text_just>
		pos=<text_pos>
		
		replace_handlers
		<not_focusable>
	}
	
	// highlight bar
	 highlight_angle=RandomNoRepeat(@2 @-2 @3 @-3 @3.5 @-3 @5 @-4 @2.5 @-4.5 )
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		;id=<bar_id>
		
		texture=DE_highlight_bar
		pos=(-25, -7)
		rgba=[0 0 0 0]
		just=[center center]
		scale = (1.9,0.7)
		z_priority=(3-1)
		rot_angle=<highlight_angle>
	}
	
	// add the bg sprite
	CreateScreenElement {
		type=SpriteElement
		parent=<parent_id>
		
		pos=(-4, 0)
		scale=<bar_scale>
		texture=highlight_bar
		rgba=[128 128 128 0]
	}
	
	// add top and bottom arrows
	CreateScreenElement {
		type=ContainerElement
		parent=<anchor_id>
				
		just=[center bottom]
		dims={200,200}
		pos=<arrow_pos_down>
	}
   
	CreateScreenElement {
		type=SpriteElement
		parent=<id>
		id=<down_arrow_id>
				
		texture=<down_arrow_texture>
		rgba=<arrow_rgba>
		scale=0.0
	}
	
	CreateScreenElement {
		type=ContainerElement
		parent=<anchor_id>
						
		just=[center top]
		dims={200,200}
		pos=<arrow_pos_up>
	}

	CreateScreenElement {
		type=SpriteElement
		parent=<id>
		id=<up_arrow_id>
				
		texture=<up_arrow_texture>
		rgba=<arrow_rgba>
		scale=0.0
	}
		
	// add the icon if there is one
	if GotParam child_texture
		CreateScreenElement {
			type=SpriteElement
			parent=<parent_id>
			
			texture=<child_texture>
			pos=<icon_pos>
			rgba=<icon_rgba>
			scale=<icon_scale>
			id=<icon_id>
		}
	endif

	SetScreenElementLock id=current_menu on
  
endscript


