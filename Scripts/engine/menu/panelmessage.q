// ***************************************************************8
//          general purpose panel message scripts
// ****************************************************************

// start autoduck documentation
// @DOC panelmessage
// @module panelmessage | None
// @subindex Scripting Database
// @index script | panelmessage

// Added by Ken for use by replay code, so that it can delete any existing
// panel message before starting the replay. (TT7498)
// Called from the c-code in replay.cpp
script kill_panel_message_if_it_exists
	if ScreenElementExists id=<id>
		DestroyScreenElement id=<id>
	endif
endscript

// @script | create_panel_message | Cretates a text item and
// displays it on the screen for the time specified. 
// @parmopt name | id | | you can specify an id if you want to refer to
// the screen element later
// @parmopt string | text | "Default panel message" | text to display
// @parmopt vector | pos | (10,200) | (x y) position vector
// @parmopt array | rgba | [144 32 32 128] | red, green, blue, alpha
// @parmopt int | time | 1500 | time to display message in milliseconds
// @parmopt name | style |  | script used to control the look (Domorphs and whatnot) of this message
script create_panel_message{ text="Default panel message"
                             pos=(320, 70) 
                             rgba=[144 32 32 100]
                             font_face=small
                             time=1500
							 z_priority=-5
                             just=[center center]
                           }    

	// destroy any panel message with this id.
	if GotParam id
        kill_panel_message_if_it_exists id=<id>
	endif
		
	SetScreenElementLock id=root_window off
	CreateScreenElement {
		type=textelement
		parent=root_window
		id=<id>
		
		font=<font_face>			
		text=<text>
		scale=1
		pos=<pos> 
		just=<just>
		rgba=<rgba>
		z_priority=<z_priority>
		
		not_focusable
	}

    // K: Need to do this after CreateScreenElement so that an id definitely gets passed.
    // The replay code remembers the id of the last panel message recorded so that it
    // can be deleted at the start of the replay.
    RecordPanelMessage <...>
    
    if GotParam style
		if GotParam params
            RunScriptOnScreenElement id=<id> <style> params=<params>
        else
            RunScriptOnScreenElement id=<id> <style> params=<...>
        endif
    else 
		RunScriptOnScreenElement id=<id> panel_message_wait_and_die params={time=<time>}
    endif
endscript


// @script | create_panel_sprite | Cretates a text item and
// displays it on the screen for the time specified. 
// @parmopt name | id | | you can specify an id if you want to refer to 
// the screen element later
// @parmopt name | texture |  | sprite texture (must be loaded already)
// @parmopt vector | pos | (10,200) | (x y) position vector
// @parmopt array | rgba | [144 32 32 128] | red, green, blue, alpha
// @parmopt int | time | 1500 | time to display message in milliseconds
script create_panel_sprite{  pos=(320,60) 
                             rgba=[128 128 128 100]
							 z_priority=-5
                          }    
    
    // create named panel message
    if GotParam id    
        // destroy any panel message with this id.
        if ObjectExists id=<id>
            RunScriptOnScreenElement id=<id> kill_panel_message
        endif
	endif
        
	SetScreenElementLock id=root_window off
	CreateScreenElement {
		type=spriteelement parent=root_window
		texture=<texture>
		id=<id>
		scale=1
		pos=<pos> 
		just=[center center]
		rgba=<rgba>
		z_priority=<z_priority>
	}
    
    if GotParam style
        if GotParam params
            RunScriptOnScreenElement id=<id> <style> params=<params>
        else
            RunScriptOnScreenElement id=<id> <style> params=<...>
        endif
    else 
        if GotParam time
            RunScriptOnScreenElement id=<id> panel_message_wait_and_die params={time=<time>}
        endif
    endif
endscript

// @script | create_panel_block | Cretates a text block item and
// displays it on the screen for the time specified. 
// @parmopt name | id | | you can specify an id if you want to refer to
// the screen element later
// @parmopt string | message_text | "Default panel message" | text to display
// @parmopt vector | pos | (10,200) | (x y) position vector
// @parmopt array | rgba | [144 32 32 128] | red, green, blue, alpha
// @parmopt int | time | 1500 | time to display message in milliseconds
// @parmopt array | just | [center center] | justification of the block
// @parmopt array | internal_just | [center center] | justification of the text within the block
script create_panel_block{ text="Default panel message"
                             pos=(320,60) 
                             dims=(250,0)
                             rgba=[144 32 32 100]
                             font_face=small
                             time=2000
                             just=[center center]
							 internal_just=[center center]
							 z_priority=-5
                           }    
    
    // create named panel block
    SetScreenElementLock id=root_window off
	if GotParam id            
		if ObjectExists id=<id>
			DestroyScreenElement id=<id>
		endif
	endif

	CreateScreenElement {
		type=TextBlockElement
		parent=root_window
		id=<id>
		
		font=<font_face>            
		text=<text>
		dims=<dims>            
		pos=<pos> 
		just=<just>
		internal_just=<internal_just>
		line_spacing=<line_spacing>
		rgba=<rgba>
		
		allow_expansion
		z_priority=<z_priority>
	}
        
    if GotParam style
        if GotParam params
            RunScriptOnScreenElement id=<id> <style> params=<params>
        else
            RunScriptOnScreenElement id=<id> <style> params=<...>
        endif
    else 
        RunScriptOnScreenElement id=<id> panel_message_wait_and_die params={ time=<time> }
    endif
endscript


// @script | panel_message_wait_and_die | 
script panel_message_wait_and_die time=1500
    wait <time>
    Die
endscript


// @script | kill_panel_message | kills message instantly.
// call only with RunScriptOnScreenElement
script kill_panel_message
    Die
endscript

// generic utility used by hide_goal_panel_messages
script hide_panel_message
	if ObjectExists id=<id>
		SetScreenElementProps {
			id=<id>
			hide
		}
	endif
endscript

// generic utility used by show_goal_panel_messages
script show_panel_message
	if ObjectExists id=<id>
		SetScreenElementProps {
			id=<id>
			unhide
		}
	endif
endscript

// generic utility used by destroy_goal_panel_messages
script destroy_panel_message
	if ObjectExists id=<id>
		<id>:Die
	endif
endscript



// *********************************************************
//          style scripts
// *********************************************************


script panel_message_landing time=1200
    SetProps font=newtrickfont just=[center top] rgba=[144 32 32 75]
    DoMorph time=0 pos=(80,240) scale=0    
	DoMorph time=.5  scale=.7 alpha=1.0
    wait <time>
	DoMorph time=.25 alpha=0.0 scale=0 // pos=(-100,240)   
	die
endscript

script panel_message_loading
    SetProps font=small just=[center center] rgba=[128 200 128 70]
  
    DoMorph pos=(320,224) scale=5 time=0
    wait 5
    Die
endscript


