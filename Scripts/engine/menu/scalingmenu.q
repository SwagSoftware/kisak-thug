//----------------------------------------
// ARTISTS' TWEAK VALUES

scalingmenu_bar_scale=(4.4, 2.0)
scalingmenu_bar_focus_rgba=[128 128 128 128]
scalingmenu_bar_unfocus_rgba=[40 40 40 128]
scalingmenu_bar_pos=(12.0, 0.0)
scalingmenu_text_pos=(-102.0, 0.0)
scalingmenu_spacing_between=25
scalingmenu_arrow_pos_up=(0, 7)
scalingmenu_arrow_pos_down=(0, -7)
scalingmenu_arrow_rgba=[128 128 128 128]
scalingmenu_arrow_scale=1.5
scalingmenu_arrow_left=-49.0
scalingmenu_arrow_right=76.0
scalingmenu_scale_increment = 1
scalingmenu_min_scale=0.0
scalingmenu_max_scale=100.0

// constraints for scaling
scalingmenu_constraints = [
	{ part = object_scaling 		male_min=90.0 male_max=120.0 female_min=90.0 female_max=120.0  }
    { part = headtop_bone_group     male_min=70.0 male_max=130.0 female_min=50.0 female_max=150.0  }
	{ part = head_bone_group 		male_min=85.0 male_max=115.0 female_min=95.0 female_max=110.0  }
    { part = nose_bone_group 		male_min=20.0 male_max=150.0 female_min=20.0 female_max=150.0  }
    { part = Jaw_bone_group 		male_min=60.0 male_max=130.0 female_min=95.0 female_max=110.0  }
	{ part = torso_bone_group 		male_min=90.0 male_max=110.0 female_min=90.0 female_max=150.0  }
	{ part = stomach_bone_group 	male_min=90.0 male_max=120.0 female_min=90.0 female_max=100.0  }
	{ part = upper_arm_bone_group 	male_min=90.0 male_max=120.0 female_min=90.0 female_max=120.0  }
	{ part = lower_arm_bone_group 	male_min=90.0 male_max=120.0 female_min=90.0 female_max=120.0  }
	{ part = hands_bone_group 		male_min=90.0 male_max=120.0 female_min=90.0 female_max=120.0  }
	{ part = upper_leg_bone_group 	male_min=90.0 male_max=120.0 female_min=90.0 female_max=120.0  }
	{ part = lower_leg_bone_group 	male_min=90.0 male_max=120.0 female_min=90.0 female_max=120.0  }
	{ part = feet_bone_group 		male_min=90.0 male_max=120.0 female_min=90.0 female_max=120.0  }
//	{ part = board_bone_group 		male_min=90.0 male_max=120.0 female_min=90.0 female_max=120.0  }
]

//----------------------------------------
// CAS ARTIST DEFINITIONS

// Bone groups define which	bones are
// affected by a particular menu slider
 headtop_bone_group = [
	Cloth_Hat
     ]
 Jaw_bone_group = [
	Bone_jaw
 ]
 Nose_bone_group = [
	Bone_brow
 ]
 head_bone_group = [
	Bone_head

// GJ:  don't scale these bones, or else you'll
// end up double-scaling them (that is,
// if you changed their scaling in the individual
// menus)
//		Bone_jaw
//		Cloth_hat
//		Bone_brow

// GJ:  don't scale the neck, because it screws
// up the cutscene head scaling	(not sure why,
// but it doesn't seem to make much visual
// difference, so i'm going to leave it for now)
//		Bone_neck
]                        
stomach_bone_group = [
	Bone_pelvis
	Bone_Stomach_Upper
        Bone_Stomach_Lower
        Cloth_Shirt_C
        Cloth_Shirt_L
        Cloth_Shirt_R
]

torso_bone_group = [
	Bone_Collar_L
	Bone_Collar_R	
	Bone_chest
	Cloth_breast	
]

upper_arm_bone_group = [
	Bone_bicep_L
	Bone_bicep_R

]

lower_arm_bone_group = [
	Bone_forearm_L
        Bone_wrist_L
	Cloth_Cuff_L

       	Bone_forearm_R
	Bone_wrist_R
	Cloth_Cuff_R
]

hands_bone_group = [
	Bone_palm_L	
	Bone_thumb_L
	Bone_forefinger_base_L
	Bone_forefinger_tip_L
	Bone_fingers_Base_L
        Bone_fingers_tip_L
        
        Bone_palm_R	
	Bone_thumb_R
	Bone_forefinger_base_R
	Bone_forefinger_tip_R
	Bone_fingers_Base_R
        Bone_fingers_tip_R
]

upper_leg_bone_group = [
        Bone_Thigh_L
        Bone_Thigh_R
]

lower_leg_bone_group = [
	Bone_knee_L
	Cloth_trouser_L
        Bone_knee_R
	Cloth_trouser_R
]

feet_bone_group = [
	Bone_ankle_L
	Bone_toe_L
      	Bone_ankle_R
	Bone_toe_R
]

board_bone_group = [
	Bone_Board_Root
	Bone_Board_Nose
        Bone_Trucks_Nose
	Bone_Board_Tail
        Bone_Trucks_Tail
]

// The following will probably be phased out...

skateshop_scaling_options = [
/*
	{
		text='Build'
		not_focusable=not_focusable
//		submenu=face_scale_menu
//		should_add_scaling_options
//		bone_group=head_bone_group
//		is_visible_script = currently_editing_custom	
//		is_enabled_script = check_if_group_editable
//		is_enabled_params = { group=head_items }
	}
*/
	{
		group_title="SCALE OPTIONS"
		text='Body'
		submenu=face_scale_menu
		should_add_scaling_options
		scaling_params = { affectXYZ }
		bone_group=object_scaling
		is_visible_script = currently_editing_custom	
	}
    {
		text='Head Top'
		submenu=face_scale_menu
		should_add_scaling_options
		scaling_params = { affectX affectY affectZ }
		bone_group=headtop_bone_group
		is_visible_script = currently_editing_custom	
		is_enabled_script = check_if_group_editable
		is_enabled_params = { group=head_items }
		cam_anim_sub=head
	}
	{
		text='Head'
		submenu=face_scale_menu
		should_add_scaling_options
		scaling_params = { affectX affectY affectZ }
		bone_group=head_bone_group
		is_visible_script = currently_editing_custom	
		is_enabled_script = check_if_group_editable
		is_enabled_params = { group=head_items }
		cam_anim_sub=head
	}
    {
    text='Nose'
    submenu=face_scale_menu
    should_add_scaling_options
    scaling_params = { affectX affectY affectZ }
    bone_group=nose_bone_group
    is_visible_script = currently_editing_custom	
    is_enabled_script = check_if_group_editable
    is_enabled_params = { group=head_items }
    cam_anim_sub=head
    }
    {
    text='jaw'
    submenu=face_scale_menu
    should_add_scaling_options
    scaling_params = { affectX affectY affectZ }
    bone_group=jaw_bone_group
    is_visible_script = currently_editing_custom	
    is_enabled_script = check_if_group_editable
    is_enabled_params = { group=head_items }
    cam_anim_sub=head
}

	{
		text='Chest'
		submenu=torso_scale_menu
	      //  scaling_params = { affectX affectY affectZ }
                scaling_params = { affectXY }
                is_visible_script = currently_editing_custom	
		should_add_scaling_options
		bone_group=torso_bone_group
		cam_anim_sub=adjtorso
	}
	{
		text='Waist'
		submenu=stomach_scale_menu
		scaling_params = { affectXY }
		is_visible_script = currently_editing_custom	
		should_add_scaling_options
		bone_group=stomach_bone_group
		cam_anim_sub=adjTorso
	}
	{
		text='Biceps'
		submenu=upper_arm_scale_menu
		scaling_params = { affectXY }
		is_visible_script = currently_editing_custom	
		should_add_scaling_options
		bone_group=upper_arm_bone_group
		cam_anim_sub=adjtorso
	}
	{
		text='Forearms'
		submenu=lower_arm_scale_menu
		scaling_params = { affectXY }
		is_visible_script = currently_editing_custom	
		should_add_scaling_options
		bone_group=lower_arm_bone_group
		cam_anim_sub=adjtorso
	}
	{
		text='Hands'
		submenu=hands_scale_menu
		scaling_params = { affectXY }
		is_visible_script = currently_editing_custom	
		should_add_scaling_options
		bone_group=hands_bone_group
		cam_anim_sub=legs
	}
	{
		text='Thighs'
		submenu=upper_leg_scale_menu
		scaling_params = { affectXY }
		is_visible_script = currently_editing_custom	
		should_add_scaling_options
		bone_group=upper_leg_bone_group
		cam_anim_sub=Legs
	}
	{
		text='Calves'
		submenu=lower_leg_scale_menu
		scaling_params = { affectXY }
		is_visible_script = currently_editing_custom	
		should_add_scaling_options
		bone_group=lower_leg_bone_group
		cam_anim_sub=Feet
	}
	{
		text='Feet'
		submenu=feet_scale_menu
		scaling_params = { affectXY }
		is_visible_script = currently_editing_custom	
		should_add_scaling_options
		bone_group=feet_bone_group
		cam_anim_sub=Feet
	}
]

//----------------------------------------
// PROGRAMMERS ONLY BELOW HERE

script scalingmenu_refresh_skaters
	GetCurrentSkaterProfileIndex
	RefreshSkaterScale skater=0 profile=<currentSkaterProfileIndex>
endscript

script scalingmenu_increment_uniform
	scalingmenu_increment affectX=1 affectY=1 affectZ=1 <...>
endscript

script scalingmenu_decrement_uniform				   
	scalingmenu_decrement affectX=1 affectY=1 affectZ=1 <...>
endscript

script scalingmenu_get_limits

	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentSkaterProfileIndex>
	
	GetArraySize scalingmenu_constraints
	<index> = 0
	begin
		if ChecksumEquals a=((scalingmenu_constraints[<index>]).part) b=<part>
			if ( <is_male> = 1 )
				<min> = ((scalingmenu_constraints[<index>]).male_min)
				<max> = ((scalingmenu_constraints[<index>]).male_max)
			else
				<min> = ((scalingmenu_constraints[<index>]).female_min)
				<max> = ((scalingmenu_constraints[<index>]).female_max)
			endif
			break
		endif
		<index> = ( <index> + 1 )
	repeat <array_size>
	   
	if not gotParam min
		<min>=90.0
	endif
	
	if not gotParam max
		<max>=150.0
	endif
 		   
	return min=<min> max=<max>
endscript

script scalingmenu_increment
	printf "incrementing scale"
	
	scalingmenu_get_xyz part=<part>
	
	scalingmenu_get_limits part=<part> <...>

	if GotParam affectX
		if ( <affectX> = 1 )
			<x> = ( <x> + scalingmenu_scale_increment )
			if ( <x> > <max> )
				<x> = <max>
			endif
		endif
	endif

	if GotParam affectY
		if ( <affectY> = 1 )
			<y> = ( <y> + scalingmenu_scale_increment )
			if ( <y> > <max> )
				<y> = <max>
			endif
		endif
	endif
	
	if GotParam affectZ
		if ( <affectZ> = 1 )
			<z> = ( <z> + scalingmenu_scale_increment )
			if ( <z> > <max> )
				<z> = <max>
			endif
		endif
	endif

	scalingmenu_set_xyz part=<part> x=<x> y=<y> z=<z>
	
	scalingmenu_refresh_arrows <...> <handler_params>
	scalingmenu_refresh_skaters
endscript

script scalingmenu_decrement
	printf "decrementing scale"
	
	scalingmenu_get_xyz part=<part>
	
	scalingmenu_get_limits part=<part> <...>

	if GotParam affectX
		if ( <affectX> = 1 )
			<x> = ( <x> - scalingmenu_scale_increment )
			if ( <x> < <min> )
				<x> = <min>
			endif
		endif
	endif

	if GotParam affectY
		if ( <affectY> = 1 )
			<y> = ( <y> - scalingmenu_scale_increment )
			if ( <y> < <min> )
				<y> = <min>
			endif
		endif
	endif
	
	if GotParam affectZ
		if ( <affectZ> = 1 )
			<z> = ( <z> - scalingmenu_scale_increment )
			if ( <z> < <min> )
				<z> = <min>
			endif
		endif
	endif

	scalingmenu_set_xyz part=<part> x=<x> y=<y> z=<z>
	
	scalingmenu_refresh_arrows <...> <handler_params>
	scalingmenu_refresh_skaters
endscript

script scalingmenu_reset_to_default
	<x> = 100
	<y> = 100
	<z> = 100
	GetCurrentSkaterProfileIndex
	SetPlayerAppearanceScale player=<currentSkaterProfileIndex> part=<part> x=<x> y=<y> z=<z> use_default_scale=1
// GJ: Don't need to refresh the arrows because they're invisible when unfocused anyway
// However, if we ever DID want to refresh the arrows, we would need to pass the correct
// handler params to the "scalingmenu_refresh_arrows" function.
//	scalingmenu_refresh_arrows part=<part> <handler_params>
	scalingmenu_refresh_skaters
endscript

script scalingmenu_get_xyz
	GetCurrentSkaterProfileIndex
	GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=<part>		
	
	if not GotParam use_default_scale
		<use_default_scale> = 1
	endif
	
	if not GotParam x
		<x> = 100
	endif
	
	if not GotParam y
		<y> = 100
	endif
	
	if not GotParam z
		<z> = 100
	endif
	
	if ( <use_default_scale> = 1 )
		<x> = 100
		<y> = 100
		<z> = 100
	endif

	return x=<x> y=<y> z=<z>
endscript

script scalingmenu_set_xyz
	GetCurrentSkaterProfileIndex
	SetPlayerAppearanceScale player=<currentSkaterProfileIndex> part=<part> x=<x> y=<y> z=<z> use_default_scale=0
endscript

script scalingmenu_refresh_arrows
	scalingmenu_get_xyz part=<part>

	<v> = 0
	
	if GotParam affectX
		if ( <affectX> = 1 )
			<v> = <x>
		endif
	endif
	
	if GotParam affectY
		if ( <affectY> = 1 )
			<v> = <y>
		endif
	endif
	 
	if GotParam affectZ
		if ( <affectZ> = 1 )
			<v> = <z>
		endif
	endif
	
	printf "%x %y %z" x=<x> y=<y> z=<z>
		
	scalingmenu_get_limits part=<part> <...>

	sliderbar_rescale_to_bar min=<min> max=<max> value=<v> left=scalingmenu_arrow_left right=scalingmenu_arrow_right	
	printf <x_val>
	SetScreenElementProps {
		id=<up_arrow_id>
		pos=( (1,0) * <x_val> )
	}
	SetScreenElementProps {
		id=<down_arrow_id>
		pos=( (1,0) * <x_val> )
	}
endscript

script scalingmenu_focus rgba=[128 128 128 50]
	GetTags	
	;RunScriptOnScreenElement id={ <id> child=0 } do_scale_up params={ rgba=[128 118 0 128] }
	main_theme_focus
	if GotParam pad_left_handler
		SetScreenElementProps {
			id=<id>
			event_handlers=[
								{ pad_left		<pad_left_handler> params=<handler_params> }
							]
			replace_handlers
		}
	endif
	if GotParam pad_right_handler
		SetScreenElementProps {
			id=<id>
			event_handlers=[
								{ pad_right		<pad_right_handler> params=<handler_params> }
							]
			replace_handlers
		}
	endif
	
	// focus the scaling bar
	SetScreenElementProps {
		id=<scaling_bar_id>
		rgba=scalingmenu_bar_focus_rgba
	}
	
	// show the arrows
	DoScreenElementMorph {
		id=<down_arrow_id>
		scale=scalingmenu_arrow_scale
	}
	DoScreenElementMorph {
		id=<up_arrow_id>
		scale=scalingmenu_arrow_scale
	}
	
	scalingmenu_refresh_arrows <...> <handler_params>
	
	// update the menu up/down arrows
	generic_menu_update_arrows {
		up_arrow_id = edit_skater_menu_up_arrow
		down_arrow_id = edit_skater_menu_down_arrow
	}
endscript

script scalingmenu_unfocus rgba=[128 128 128 0]
	GetTags	
	// de-highlight the item
	;RunScriptOnScreenElement id={ <id> child=0 } do_scale_down
	main_theme_unfocus
	// unfocus the scaling bar
	SetScreenElementProps {
		id=<scaling_bar_id>
		rgba=scalingmenu_bar_unfocus_rgba
	}
	
	DoScreenElementMorph {
		id=<down_arrow_id>
		scale=0.0
	}
	DoScreenElementMorph {
		id=<up_arrow_id>
		scale=0.0
	}
endscript

script scalingmenu_addslider text='XYZ'	affectX=0 affectY=0 affectZ=0 id=default_slider_bar
	
	MangleChecksums a=<id> b=up_arrow
	<up_arrow_id>=<mangled_id>
	
	MangleChecksums a=<id> b=down_arrow
	<down_arrow_id>=<mangled_id>
	
	MangleChecksums a=<id> b=slider_bar
	<slider_bar_id>=<mangled_id>

	MangleChecksums a=<id> b=anchor
	<anchor_id>=<mangled_id>
	
	sliderbar_add_item {
		text=<text>
		focus_script=scalingmenu_focus
		focus_params={ 
						pad_left_handler=scalingmenu_decrement_uniform
					 	pad_right_handler=scalingmenu_increment_uniform
						handler_params=<...>
						up_arrow_id=<up_arrow_id>
						down_arrow_id=<down_arrow_id>
						part=<part>
						scaling_bar_id=<slider_bar_id>
						affectX=<affectX>
						affectY=<affectY>
						affectZ=<affectZ> 
					 }
	    unfocus_script=scalingmenu_unfocus
		unfocus_params={
						up_arrow_id=<up_arrow_id>
						down_arrow_id=<down_arrow_id>
						scaling_bar_id=<slider_bar_id>
		}
		pad_choose_script=nullscript
		child_texture=scalebar
		icon_id=<slider_bar_id>
		icon_scale=scalingmenu_bar_scale
		icon_rgba=scalingmenu_bar_unfocus_rgba
		icon_pos=scalingmenu_bar_pos
		text_pos=scalingmenu_text_pos
		text_just=[left center]
		tab=tab3
		anchor_id=<anchor_id>
		up_arrow_id=<up_arrow_id>
		down_arrow_id=<down_arrow_id>
		arrow_pos_up=scalingmenu_arrow_pos_up
		arrow_pos_down=scalingmenu_arrow_pos_down
		arrow_rgba=scalingmenu_arrow_rgba
		up_arrow_texture=scale_up
		down_arrow_texture=scale_down
	}
endscript

script scalingmenu_add_options_to_menu

	SetScreenElementProps {
		id=current_menu
		spacing_between = scalingmenu_spacing_between
	}
  
	if GotParam affectX
		scalingmenu_addslider {
			text='X'
			affectX=1
			id=scalingmenu_x_slider
			part=<part>
			min=<min>
			max=<max>
		}
	endif
		
		
	if GotParam affectZ
		scalingmenu_addslider {
			text='Y'
			affectZ=1
			id=scalingmenu_z_slider
			part=<part>
			min=<min>
			max=<max>
		}
	endif
	
	if GotParam affectY
		scalingmenu_addslider {
			text='Z'
			affectY=1
			id=scalingmenu_y_slider
			part=<part>
			min=<min>
			max=<max>
		}
	endif 	
	
	if GotParam affectXY
		scalingmenu_addslider {
			text='XZ'
			affectX=1
			affectY=1
			id=scalingmenu_xyz_slider
			part=<part>
			min=<min>
			max=<max>
		}
	endif		
	
	if GotParam affectXYZ
		scalingmenu_addslider {
			text='XYZ'
			affectX=1
			affectY=1
			affectZ=1
			id=scalingmenu_xyz_slider
			part=<part>
			min=<min>
			max=<max>
		}
	endif		
	
	edit_skater_menu_add_item {
		text='Reset to default'
		pad_choose_script=scalingmenu_reset_to_default
		pad_choose_params={ part=<part> }
		tab=tab3
	}
	
	create_helper_text generic_helper_text_color_menu
endscript








//--------------------------------------------
// TODO:  Reimplement the following correctly

// e-z scaling to get preset shapes
script scalingmenu_add_bodyshapes_to_menu
    GetArraySize master_bodyshape_list
    <index> = 0
    begin
        edit_skater_menu_add_item {
            text=((master_bodyshape_list[<index>]).text)
			tab=tab2
            pad_choose_script=cas_apply_bodyshape
            pad_choose_params={field=body_shape value=((master_bodyshape_list[<index>]).scaling_table)}
        }
        <index> = (<index> + 1)
    repeat <array_size>
endscript
