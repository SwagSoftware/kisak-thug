number_of_console_lines = 6

script create_console
	if not ObjectExists id=console_message_vmenu
		SetScreenElementLock id=root_window off
		
        if LevelIs load_skateshop
			pos=(50, 240)
		else
			pos=(20, 265)
		endif
		
		CreateScreenElement {
			type=VMenu 
			parent=root_window
			id=console_message_vmenu
		
			padding_scale=.65
					
			font=dialog
			just=[left top]
            ;rgba=(128 128 128 90)
			internal_just=[left center]
			pos=<pos>
			z_priority=0
		}
		
		;begin
		;	create_console_message
		;repeat number_of_console_lines
	endif
endscript

script create_console_message text="Default console message" rgba=[113 121 127 80]
if not GetGlobalFlag flag=NO_DISPLAY_CHATWINDOW

	if not ObjectExists id=console_message_vmenu
		create_console
	endif
	
	SetScreenElementLock id=console_message_vmenu off
	if ScreenElementExists id={ console_message_vmenu child=( number_of_console_lines - 1 ) }
		DestroyScreenElement id={ console_message_vmenu child=0 }
	endif
	
	if LevelIs load_skateshop
        // in network lobby
		dims=(750,10)
		pos=(50, 240)
		change number_of_console_lines=7
		max_chat_height=150
	else
		// in game
		dims=(750,10)
		pos=(20, 265)
		change number_of_console_lines=6
		max_chat_height=96
	endif
	
	if GotParam join
		rgba=[0 80 0 80]
	else
		if GotParam left
			rgba=[80 0 0 80]
		endif
	endif
    
    SetScreenElementProps id=console_message_vmenu pos=<pos>
	
	CreateScreenElement {
		type=TextBlockElement
		parent=console_message_vmenu
		font=dialog
		text=<text>
		internal_just=[left top]
		rgba=<rgba>
		scale=0.8
		not_focusable
		dims=<dims>
		allow_expansion
		z_priority=5
	}
	
	begin			
		total_height=0
		index=number_of_console_lines
		begin
		if ScreenElementExists id={ console_message_vmenu child=( number_of_console_lines - <index> ) }
			GetScreenElementDims id={ console_message_vmenu child=( number_of_console_lines - <index> ) }
			<total_height>= ( <total_height> + <height> )
			<index>=(<index> - 1)
		else
			;printf "chat box height = %t" t=<total_height>
			break
		endif
		repeat
					
		if ( <total_height> > <max_chat_height> )
			DestroyScreenElement id={ console_message_vmenu child=0 }
		else
			break
		endif
	repeat
	
	if GotParam wait_and_die
		RunScriptOnScreenElement id=<id> console_message_wait_and_die params={ time=<time> }
		return
	endif
	
    if not LevelIs load_skateshop
		if not GotParam dont_die
			RunScriptOnScreenElement id=<id> console_message_wait_and_die
		endif
    endif
endif
endscript

script hide_console_window
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=0
	endif
endscript

script unhide_console_window
	if ObjectExists id=console_message_vmenu
		DoScreenElementMorph id=console_message_vmenu time=0 scale=1
	endif
endscript

script console_left_justify
	if ObjectExists id=console_message_vmenu
		SetScreenElementLock id=console_message_vmenu off
		SetScreenElementProps {
			id=console_message_vmenu
			just=[left top]
			internal_just=[left center]
		}
		// the just has to be set BEFORE the position is changed
		SetScreenElementProps {
			id=console_message_vmenu
			pos=(20, 265)
		}
	endif
endscript

script console_right_justify
	if ObjectExists id=console_message_vmenu
		SetScreenElementLock id=console_message_vmenu off
		SetScreenElementProps {
			id=console_message_vmenu
			just=[right top]
			internal_just=[right center]
		}
		// the just has to be set BEFORE the position is changed
		SetScreenElementProps {
			id=console_message_vmenu
			pos=(620, 265)
		}
	endif
endscript

// @script | console_hide | hides the console
script console_hide
	if ObjectExists id=console_message_vmenu
		RunScriptOnScreenElement id=console_message_vmenu console_hide2
	endif
endscript

script console_hide2
	DoMorph scale=0
endscript

// @script | console_unhide | brings the console back
script console_unhide
	if ObjectExists id=console_message_vmenu
		RunScriptOnScreenElement id=console_message_vmenu console_unhide2
	endif
endscript
script console_unhide2
	DoMorph scale=1
endscript

// @script | console_clear |
script console_clear
	if ScreenElementExists id=console_message_vmenu
		DestroyScreenElement id=console_message_vmenu preserve_parent
	endif
endscript


// @script | console_destroy | 
script console_destroy
	if ObjectExists id=console_message_vmenu
		DestroyScreenElement id=console_message_vmenu
	endif
endscript

script console_message_wait_and_die time=30
    wait <time> seconds
	DoMorph time=.5 alpha=0
	Die
endscript
