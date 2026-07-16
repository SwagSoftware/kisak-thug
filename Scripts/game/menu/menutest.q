script create_menu_test_menu

	SetScreenElementLock id=root_window off 
    
    CreateScreenElement {
		type=ContainerElement
		parent=root_window 
		id=menu_test_menu
		
		font=small
		pos=(320,224) 
		just=[center center]
		scale=0
		dims=(200,400)
		focusable_child=menu_test_vmenu
    }
    
    CreateScreenElement {
		type=TextElement 
		parent=menu_test_menu
		
		font=small
		text="Test Stuff"
		scale=1.25
		pos=(100,70) 
		just=[center top]
		rgba=[32 32 144 128]
    }
    
    CreateScreenElement {
		type=VScrollingMenu
		parent=menu_test_menu
		id=the_scrolling_menu 
		
		just=[center top]
		pos=(100,90)
		dims=(200,80)
		internal_just=[center center]
    }
    
    CreateScreenElement {
		type=VMenu
		parent=the_scrolling_menu
		id=menu_test_vmenu 
		
		font=small
		just=[center top]
		pos=(100,0)
		dims=(200,170)
		internal_just=[center center]
		dont_allow_wrap
    }
	
	// assign current menu aliases
	AssignAlias id=menu_test_menu alias=current_menu_anchor
	AssignAlias id=menu_test_vmenu alias=current_menu
	
	// Define pad_back event - go back to the pause menu
	SetScreenElementProps { 
		id=menu_test_vmenu 
		event_handlers=[
			{pad_back       leave_menu_test_menu}
		]
	} 
	make_text_menu_item text="Sprite Test On" id=menu_sprite_test_on pad_choose_script=start_sprite_test focus_script=	make_text_sub_menu_item text="Focus here to assert" focus_script=menu_test_focus_position
	make_text_menu_item text="Sprite Test Off" id=menu_sprite_test_off pad_choose_script=stop_sprite_test
	make_text_menu_item text="Font Test" id=menu_font_test pad_choose_script=launch_font_test_menu
	make_text_menu_item text="Exit" id=menu_exit_test pad_choose_script=leave_menu_test_menu
	
	hookup_hmenu	    
		
	SetScreenElementProps {
		id=root_window
		event_handlers=[
			{pad_start			nullscript}
		]
		replace_handlers
	}
	
	LoadTexture "sht_volcom01"                           
	
	CreateScreenElement {
		type=TextElement
		id=blur_test_element
		parent=root_window
		
		font=small
		text="Vapor Trails"
		scale=2.0
		pos=(320, 250) 
		just=[center center]
		rgba=[128 128 128 128]
		blur_effect
		blur_rgba=[128 0 0 128]
	}	
	
	CreateScreenElement {
		type=TextElement
		id=dumb_monkey
		parent=root_window
		
		font=small
		text="O\m0\m1\m2\m3\m4\m5\m6ne\bcTwo\bc\m7Three\b1"
		scale=1.0
		pos=(25, 150) 
		just=[left center]
		rgba=[128 128 128 128]
	}	
	
	AssignAlias id=blur_test_element alias=blur_alias
	RunScriptOnScreenElement id=blur_alias do_blur_effect2
    
	RunScriptOnScreenElement id=menu_test_menu animate_in
	printf "create_menu_test_menu done"
	
	AddTextureToVram "bottom_mid"
	CreateScreenElement {
		type=SpriteElement
		parent=root_window
		id=bottom_mid_test
		
		texture=bottom_mid
		pos=(320, 400)
		scale=(15, 1)
		just=[center bottom]
	}
endscript

script menu_test_focus_position
	GetTags
	SetScreenElementLock id=<id> off
	CreateScreenElement {
		type=SpriteElement
		parent=<id>
		
		texture=GO_fail
	}
	SetScreenElementLock id=<id> off
endscript

script do_blur_effect
	;DoMorph time=0 blur_alpha_pair=(4.0,0.0) blur_bottom_scales=(1.0,1.0) blur_max_displacement=(0.0,0.0) scale=(.9,.9) alpha=.5 scale=(1.0,1.0)
	DoMorph time=0 blur_alpha_pair=(4.0,0.0) blur_bottom_scales=(1.0,1.0) blur_max_displacement=(0.0,0.0) scale=(.9,.9) scale=(1.0,1.0) relative_scale
	DoMorph time=.09 blur_alpha_pair=(0.0,0.0) blur_bottom_scales=(2.0,0) scale=(1.0,1.0) relative_scale
	DoMorph time=.09 blur_alpha_pair=(4.0,0.0) blur_bottom_scales=(1.0,1.0) scale=(1.0,1.0) relative_scale
	;DoMorph alpha=1.0
	;wait .6 seconds
	;DoMorph time=.2 pos=(320,280) blur_max_displacement=(0.0,60.0)
	;DoMorph time=.2 blur_max_displacement=(0.0,0.0)
	;wait .2 seconds
	;DoMorph time=.2 pos=(320,250) blur_max_displacement=(0.0,-60.0)
	;DoMorph time=.2 pos=(320,250) blur_max_displacement=(0.0,0.0)
	;wait .4 seconds
;repeat
endscript

script do_blur_effect_accept
	;DoMorph time=0 blur_alpha_pair=(4.0,0.0) blur_bottom_scales=(1.0,1.0) blur_max_displacement=(0.0,0.0) scale=(.9,.9) alpha=.125 scale=(1.0,1.0)
	DoMorph time=0 blur_alpha_pair=(4.0,0.0) blur_bottom_scales=(1.0,1.0) blur_max_displacement=(0.0,0.0) scale=(.9,.9) scale=(1.0,1.0) relative_scale
	DoMorph time=.07 blur_alpha_pair=(0.0,0.0) blur_bottom_scales=(3.5,0) scale=(1.0,1.0) relative_scale
	DoMorph time=.07 blur_alpha_pair=(4.0,0.0) blur_bottom_scales=(1.0,1.0) scale=(1.0,1.0) relative_scale
	;DoMorph alpha=1.0
endscript

script do_blur_effect_highlight
    DoMorph time=0 blur_alpha_pair=(4.0,0.0) blur_bottom_scales=(1.0,1.0) blur_max_displacement=(0.0,0.0) scale=(.9,.9) blur_top_alpha_mult=8.0 scale=(1.0,1.0) relative_scale
	DoMorph time=.07 blur_alpha_pair=(.2,.2) blur_bottom_scales=(2.6,0) scale=(1.0,1.0) relative_scale
    DoMorph time=.07 blur_alpha_pair=(4.0,0.0) blur_bottom_scales=(1.0,1.0) scale=(1.0,1.0) relative_scale
endscript





script do_blur_effect2
begin
	DoMorph time=0 blur_alpha_pair=(1.0,0.0) blur_bottom_scales=(1.0,1.0) blur_max_displacement=(0.0,0.0) alpha=.0625 scale=(2.0,2.0) relative_scale
	DoMorph time=.75 blur_alpha_pair=(.5,0.0) blur_bottom_scales=(3.0,3.0) scale=(2.0,2.0) relative_scale
	DoMorph time=.75 blur_alpha_pair=(1.0,0.0) blur_bottom_scales=(1.0,1.0) scale=(2.0,2.0) relative_scale
	wait .6 seconds
	DoMorph time=.5 pos=(320,320) blur_max_displacement=(0.0,70.0)
	DoMorph time=.5 blur_max_displacement=(0.0,0.0)
	wait .6 seconds
	DoMorph time=.5 pos=(320,250) blur_max_displacement=(0.0, -70.0)
	DoMorph time=.5 pos=(320,250) blur_max_displacement=(0.0,0.0) alpha=1.0
	wait .6 seconds
	SetProps no_blur_effect
	wait .6 seconds
	SetProps blur_effect
repeat
endscript




script leave_menu_test_menu
	DestroyScreenElement id=dumb_monkey
	DestroyScreenElement id=blur_test_element
	
	stop_sprite_test
	UnloadTexture "sht_volcom01"
		
	SetScreenElementProps {
		id=root_window
		event_handlers=[
			{pad_start			handle_start_pressed}
		]
		replace_handlers
	}
	
	GetTags
	printf "death or glory"
	DestroyScreenElement id=menu_test_menu
	printf "ack"
	create_debug_menu
	;RunScriptOnScreenElement id=<id> launch_pause_menu
	
	RemoveTextureFromVram "bottom_mid"
	DestroyScreenElement id=bottom_mid_test
endscript




script hookup_hmenu
	printf "hookup_hmenu"
	CreateScreenElement {
		type=hmenu
		id=test_h_menu
		parent=current_menu
		just=[center center]
		padding_scale=1.25
		spacing_between=30
	}
	
	CreateScreenElement {
		type=textelement 
		parent=test_h_menu 
		local_id = something_something
		text="do something"
		font=small
		rgba=[128 64 64 75]
		event_handlers=[
			{focus  	        do_scale_up}
			{unfocus    		do_scale_down}
		]
		not_focusable
	}
	
	CreateScreenElement {
		type=textelement 
		parent=test_h_menu 
		text="yes"
		font=small
		rgba=[128 128 128 75]
		event_handlers=[
			{focus  	        do_scale_up}
			{unfocus    		do_scale_down}
			{pad_choose			choose_h_menu_yes}
		]
	}
	
	CreateScreenElement {
		type=textelement 
		parent=test_h_menu 
		text="no"
		font=small
		rgba=[128 128 128 75]
		event_handlers=[
			{focus  	        do_scale_up}
			{unfocus    		do_scale_down}
			{pad_choose			choose_h_menu_no}
		]
	}
	
	SetScreenElementLock id=test_h_menu
	printf "hookup_hmenu done"
endscript




script choose_h_menu_yes
	SetScreenElementProps id={test_h_menu child=something_something} focusable
	SetScreenElementProps id=current_menu disable_pad_handling
endscript




script choose_h_menu_no
	SetScreenElementProps id={test_h_menu child=something_something} not_focusable
	SetScreenElementProps id=current_menu enable_pad_handling
endscript




script start_sprite_test
	if ObjectExists id=test_sprite
		// do nothing
	else
		SetScreenElementLock id=root_window off
		// create "test_sprite" element
		CreateScreenElement {
			id=test_sprite
			type=spriteelement
			parent=root_window
			
			scale=1.0
			pos=(610,30) 
			just=[right top]
			rgba=[128 128 128 128]
			texture=sht_volcom01
			debug_outline
		} 
		FireEvent type=focus target=current_menu
	endif
endscript




script stop_sprite_test
	if ObjectExists id=test_sprite
		SetScreenElementLock id=root_window off
		DestroyScreenElement id=test_sprite recurse
		FireEvent type=focus target=current_menu
	endif
endscript




script launch_font_test_menu
;	RunScriptOnScreenElement id=current_menu_anchor animate_out callback=font_test
endscript




; set one -- bottom of screen
script font_test font1=small font2=small_test_1 font3=small_test_2 

    CreateScreenElement {
    	type=ContainerElement 
    	parent=root_window 
        id=font_test_anchor1
		
        pos=(0,324) 
    	just=[left top]
        dims=(640,100)
        focusable_child=font_test_vmenu
    }
    
    make_new_menu menu_id=font_test_menu vmenu_id=font_test_vmenu menu_title="Font test"
    
    SetScreenElementProps { id=font_test_menu 
                                event_handlers=[ 
                                    {pad_back          exit_font_test}
                                ]
                          }

    make_text_sub_menu_item { text="Exit font test" 
                              id="eft" 
                              unfocus_script=do_scale_up 
                              pad_choose_script=exit_font_test
                            }
    
    CreateScreenElement {
    	type=textelement 
    	parent=font_test_anchor1
    	font=<font1>
    	text="Tony Hawks Pro Skater - original THPS3 font"
            scale=1.0
            rgba=[92 92 92 128]
            just=[left top]
    	pos=(15,0)
    }
    
    CreateScreenElement {
    	type=textelement 
    	parent=font_test_anchor1
    	font=<font2>
    	text="A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
            scale=1.0
            rgba=[92 92 92 0]
            just=[left top]
    	pos=(15,20)
    }
    
    CreateScreenElement {
    	type=textelement 
    	parent=font_test_anchor1
    	font=<font2>
    	text="a b c d e f g h i j k l m n o p q r s t u v w x y z"
            scale=1.0
            rgba=[92 92 92 0]
            just=[left top]
    	pos=(15,40)
        


    }
    
    CreateScreenElement {
    	type=textelement 
    	parent=font_test_anchor1
    	font=<font2>
    	text="0 1 2 3 4 5 6 7 8 9 . , - ! ? : ' + / ^ ® ( ) * @ `"
            scale=1.0
            rgba=[92 92 92 0]
            just=[left top]
    	pos=(15,60)
    }
    
    CreateScreenElement {
    	type=textelement 
    	parent=font_test_anchor1
    	font=<font2>
    	text=" ¡ ¢ £ ¤ ¥ ¦ § ¨ © ª « ¬ { _ # $ % & \ = < > ß Ä Ü"
            scale=1.0
            rgba=[92 92 92 0]
            just=[left top]
    	pos=(15,80)
    }
    
    ; set two -- top of screen
    
    CreateScreenElement {
		type=ContainerElement 
		parent=root_window 
		id=font_test_anchor2
		
		pos=(0,15) 
		just=[left top]
		dims=(640,100)
    }
    
    CreateScreenElement {
    	type=textelement 
    	parent=font_test_anchor2
    	font=<font3>
    	text="ABCD EFGHI JKL MNOPQR"
            scale=1.0
            rgba=[111 53 18 128]
            just=[left top]
    	pos=(15,200)
    }
    
    CreateScreenElement {
    	type=textelement 
    	parent=font_test_anchor2
    	font=<font3>
    	text="STUV WXYZa bcd efghij"
            scale=1.0
            rgba=[78 79 127 128]
            just=[left top]
    	pos=(15,220)
    }
    
    CreateScreenElement {
    	type=textelement 
    	parent=font_test_anchor2
    	font=<font3>
    	text="klmn opqrs tuv wxyz01"
            scale=1.0
            rgba=[118 110 14 128]
            just=[left top]
    	pos=(15,240)
  
    }

    RunScriptOnScreenElement id=font_test_menu animate_in                                    
                                  
    ; END FONT TEST STUFF FOR DANA
    ; ---------------------------------------------
endscript




script exit_font_test
    ; ---------------------------------------------
    ; FONT TEST STUFF FOR DANA
    SetScreenElementLock id=root_window off
    DestroyScreenElement id=font_test_anchor1 recurse
    DestroyScreenElement id=font_test_anchor2 recurse
    ; END FONT TEST STUFF FOR DANA
    ; ---------------------------------------------
    
    RunScriptOnScreenElement id=font_test_menu animate_out callback=create_pause_menu
endscript



// 3d screen element examples

script Create3dArrowPointer model="Arrow" angleX=42.5 pos=(320, 50) scale=0.03 active_viewport=0
	if GotParam ArrowId
		printf "Create3dArrowPointer now uses 'Id' instead of 'ArrowId'"
		goto abort
	endif    
	
	if ObjectExists Id=<Id>
		DestroyScreenElement Id=<Id>
	endif
	SetScreenElementLock Id=root_window Off
	
	CreateScreenElement {
		Parent=root_window
		Type=Element3d
		Id=<Id>
	   
		Model = <model>
		Pos=<pos>
		CameraZ=-6
		Scale=<scale>
		Tilt=<tilt>
		Active_Viewport=<active_viewport>
	   
		anglex=<angleX>
		NodeToPointTo=<Node>
		ObjectToPointTo=<Name>
	}    
endscript

script SetArrowNode
	RunScriptOnScreenElement Id=<Id> SetElement3dNode params={Node=<Node>}
endscript

script SetElement3dNode
	SetProps NodeToPointTo=<Node>
endscript

script FlyingLetters                 
	begin
		CreateTestElement3d Model="Letter_S" Pos=(100,100)
		CreateTestElement3d Model="Letter_K" Pos=(180,100)
		CreateTestElement3d Model="Letter_A" Pos=(260,100)
		CreateTestElement3d Model="Letter_T" Pos=(340,100)
		CreateTestElement3d Model="Letter_E" Pos=(420,100)
		wait 0.18 seconds
	repeat 100
endscript

script CreateTestElement3d
SetScreenElementLock Id=root_window Off
CreateScreenElement {
    Parent=root_window
    Type=Element3d
    
    
    Model = <Model>
    Pos=<Pos>
    CameraZ=-10
    Scale=0.03
    AngVelX=random(@-0.1 @-0.12 @-0.11 @0.11 @0.12 @0.1)
    AngVelY=random(@-0.1 @-0.12 @-0.11 @0.11 @0.12 @0.1)
    AngVelZ=random(@-0.1 @-0.12 @-0.11 @0.11 @0.12 @0.1)
}    
RunScriptOnScreenElement Id=<Id> TestElement3d params={pos=<Pos>}
endscript

script TestElement3d
	DoMorph Time=0 Pos=random(@(0,0) @(-100,240) @(740,240) @(740,580)) 
	DoMorph Time=.5 Pos=<Pos> 
	DoMorph Time=1 Pos=random(@(-200,0) @(-200,240) @(840,240) @(840,580))
	wait 1 seconds
	Die
endscript

