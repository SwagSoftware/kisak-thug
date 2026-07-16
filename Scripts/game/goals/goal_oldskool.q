//unlock old skool levels goals

Script initialize_oldskool_icons

	GetCurrentLevel
	
	// figure the level num
	switch <level>
	case load_nj
		<level_num> = 1
		FormatText ChecksumName=oldskool_icon "TRG_NJ_OLDSKOOL_ICON01" 
		<gFlag>=LEVEL_UNLOCKED_SC2
	case load_hi
		<level_num> = 5
		FormatText ChecksumName=oldskool_icon "TRG_HI_OLDSKOOL_ICON01"
		<gFlag>=LEVEL_UNLOCKED_VN
	case load_ru
		<level_num> = 8
		FormatText ChecksumName=oldskool_icon "TRG_RU_OLDSKOOL_ICON01" 
		<gFlag>=LEVEL_UNLOCKED_HN
	default
		return
	endswitch 
  
	if NodeExists <oldskool_icon>
		if IsAlive name=<oldskool_icon>
			if GameModeEquals is_career
				if GetGlobalFlag flag=<gFlag>
					kill name=<oldskool_icon>
				endif
			else
				kill name=<oldskool_icon>
			endif
		endif
	endif
 
Endscript

Script Oldskool_Icon
	Obj_SetException ex = SkaterInRadius scr = Oldskool_Icon_Got
	Obj_SetInnerRadius 10
	Obj_RotY speed=250
	Obj_Hover Amp=10 Freq=1
Endscript

Script Oldskool_Icon_Got
	Obj_ClearExceptions
	
	GetCurrentLevel
	
	// figure the level num
	switch <level>
	case load_nj
		unlocked_text ="Congratulations!\nYou've unlocked an old skool level:\n \c3School 2 from THPS2.\c0"
	case load_hi
		unlocked_text ="Congratulations!\nYou've unlocked an old skool level:\n \c3Venice from THPS2.\c0"
	case load_ru
		unlocked_text ="Congratulations!\nYou've unlocked an old skool level:\n \c3The Hangar from THPS2.\c0"
	endswitch
	
	PauseGame
	pause_rain
	PlayStream UnlockOldTHPSLevel priotity=StreamPriorityHighest
	
	create_snazzy_dialog_box {
    title="OLD SKOOL ICON!"
	title_font=testtitle
    text=<unlocked_text>
    text_dims=(350,0)
    
    buttons=[
                {
                    font=small text='Ok'
                    pad_choose_script=Oldskool_Icon_Got_Dlg_Exit
                    pad_choose_params = 
                    {
                   
                    }
                }
            ]
		style=special_dialog_style
	}
	
	if LevelIs load_nj
		SetGlobalFlag flag = LEVEL_UNLOCKED_SC2
	endif
	if LevelIs load_hi
		SetGlobalFlag flag = LEVEL_UNLOCKED_VN
	endif
	if LevelIs load_ru
		SetGlobalFlag flag = LEVEL_UNLOCKED_HN
	endif
	
	Die
Endscript

script Oldskool_Icon_Got_Dlg_Exit
	dialog_box_exit
	UnpauseGame
	unpause_rain
endscript
