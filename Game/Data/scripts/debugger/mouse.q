// This script gets called whenever a vMSG_ID_DBG_MOUSE_POSITION message is received by the game code
// from the script debugger.
script UpdateDebuggerMousePosition
	if not ScreenElementExists id=mouse_cursor
		SetScreenElementLock id=root_window off
		CreateScreenElement {
			type=SpriteElement
			parent=root_window
			id=mouse_cursor
			texture=mouse_cursor
			rgba=[128 128 128 85]
			just=[left top]
			z_priority=3000001
		}
	endif

	SetScreenElementProps id=mouse_cursor pos=((1,0)*<x> + (0,1)*<y>)
endscript

// This gets called when the mouse is moved from the game screen back to the PC screen,
// which will be when the game receives a vMSG_ID_DBG_MOUSE_OFF_SCREEN message.
script DestroyMouseCursor
	if ScreenElementExists id=mouse_cursor
		DestroyScreenElement id=mouse_cursor
	endif
	DestroyMouseText
endscript

script DestroyMouseText
	if ScreenElementExists id=mouse_text
		DestroyScreenElement id=mouse_text
	endif
endscript

script SetMouseText
	if not ScreenElementExists id=mouse_text
		SetScreenElementLock id=root_window off
		CreateScreenElement {
			id=mouse_text
			parent=root_window
			type=TextElement
			just=[center bottom]
			pos=(0,0)
			font=small
			scale=1
			text=""
		}
	endif

	SetScreenElementProps id=mouse_text text=<text> pos=((1,0)*<x> + (0,1)*<y> - (0,4))
endscript

script MouseClickEffect
	DoMorph id=mouse_text scale=1.1 time=0
	wait 2 gameframes
	DoMorph id=mouse_text scale=1 time=0
endscript

script DoMouseClickEffect
	if ScreenElementExists id=mouse_text
		RunScriptOnScreenElement id=mouse_text MouseClickEffect
	endif
endscript

