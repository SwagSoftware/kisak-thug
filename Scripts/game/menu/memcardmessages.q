///////////////////////////////////////////////////////////////////////
//
//                      Memory card messages
//
/////////////////////////////////////////////////////////////////////////

// TODO: Need 'tm' character in font for gamecube messages.

script create_dialog_box_with_wait
	if(no_load=0)
		memcard_menus_cleanup
	else
		<no_bg>=no_bg
	endif
	create_snazzy_dialog_box { <...> no_animate }
    
    // Fix to TT13005: Disable controller unplugged detection during the pause
    change check_for_unplugged_controllers = 0 
	; Make sure the dialog box appears by waiting for a bit
	; 1 frame isn't enough, 2 is enough most of the time, but sometimes 3 are needed. I don't know why ...
    DisableReset // Fix to TT13686, save process not completing if reset button pressed quickly enough
	wait 20 gameframes
    EnableReset
    change check_for_unplugged_controllers = 1
endscript



script mcmess_CheckingCard
	GetPlatform
	switch <Platform>
		case ps2
		create_dialog_box_with_wait {
			title='Checking ...' 
			text='Checking memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1. Do not remove memory card (8MB) (for PlayStation®2), controller, or reset/switch off the console'
			add_loading_anim=add_loading_anim
		}
		case xbox
		create_dialog_box_with_wait {
			title='Checking ...' 
			text='Checking hard disk ...\nPlease do not turn off your Xbox console.'
			no_bg=<no_bg>
			add_loading_anim=add_loading_anim
		}
		case ngc
		create_dialog_box_with_wait {
			title='Accessing ...' 
			text='Accessing. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button.'
			add_loading_anim=add_loading_anim
		}
	endswitch
endscript

script mcmess_SavingData
GetPlatform
switch <Platform>
case ps2
create_dialog_box_with_wait {
    title='Saving ...' 
    text='Saving data. Do not remove memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1, controller, or reset/switch off the console.'
	add_loading_anim=add_loading_anim
}
case xbox
GetFileTypeName file_type=<FileType>
FormatText {
    TextName=text
    'Saving %f to hard disk ...\nPlease do not turn off your Xbox console.'
    f=<filetype_name>
    }

create_dialog_box_with_wait {
    title='Saving ...' 
    text_dims=(350,0)
    text=<text>
	add_loading_anim=add_loading_anim
}
case ngc
create_dialog_box_with_wait {
    title='Saving ...' 
    text_dims=(350,0)
    text='Saving data. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button.'
	add_loading_anim=add_loading_anim
}
endswitch
endscript

script mcmess_OverwritingData
GetPlatform
switch <Platform>
case ps2
create_dialog_box_with_wait {
    title='Overwriting ...' 
    text='Overwriting data. Do not remove memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1, controller, or reset/switch off console.'
	add_loading_anim=add_loading_anim
}
case xbox
GetFileTypeName file_type=<FileType>
FormatText {
    TextName=text
    'Overwriting %f to hard disk ...\nPlease do not turn off your Xbox console.'
    f=<filetype_name>
    }

create_dialog_box_with_wait {
    title='Overwriting ...' 
    text_dims=(350,0)
    text=<text>
	add_loading_anim=add_loading_anim
}
case ngc
create_dialog_box_with_wait {
    title='Overwriting ...' 
    text_dims=(350,0)
    text='Overwriting data. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button.'
	add_loading_anim=add_loading_anim
}
endswitch
endscript

script mcmess_LoadingData
	GetPlatform
	switch <Platform>
		case ps2
			create_dialog_box_with_wait {
				title='Loading ...' 
				text='Loading data. Do not remove memory card (8MB) (for PlayStation®2), controller, or reset/switch off the console.'
				add_loading_anim=add_loading_anim
			}
			no_animate=<no_animate>
		case xbox
			GetFileTypeName file_type=<FileType>
			FormatText {
				TextName=text
				'Loading %f from hard disk ...\nPlease do not turn off your Xbox console.'
				f=<filetype_name>
				}
				
			create_dialog_box_with_wait {
				title='Loading ...' 
				text_dims=(400,0)
				text=<text>
				add_loading_anim=add_loading_anim
			}
			no_animate=<no_animate>
		case ngc
			create_dialog_box_with_wait {
				title='Loading ...' 
				text_dims=(350,0)
				text='Loading data. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button.'
				add_loading_anim=add_loading_anim
			}
			no_animate=<no_animate>
	endswitch
endscript

script mcmess_DeletingFile
GetPlatform
switch <Platform>
case ps2
create_dialog_box_with_wait {
    title='Deleting ...' 
    text='Deleting data. Do not remove memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1, controller, or reset/switch off console.'
	add_loading_anim=add_loading_anim
}
case xbox
GetFileTypeName file_type=<FileType>
FormatText {
    TextName=text
    'Deleting %f from hard disk ...\nPlease do not turn off your Xbox console.'
    f=<filetype_name>
    }

create_dialog_box_with_wait {
    title='Deleting ...' 
    text_dims=(350,0)
    text=<text>
	add_loading_anim=add_loading_anim
}
case ngc
create_dialog_box_with_wait {
    title='Deleting ...' 
    text_dims=(350,0)
    text='Deleting data. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button.'
	add_loading_anim=add_loading_anim
}
endswitch
endscript

script mcmess_SaveSuccessful
create_memcard_success_dialog_box {
    title='Successful' 
    text='Save Successful'
}
endscript

script mcmess_OverwriteSuccessful
create_memcard_success_dialog_box {
    title='Successful' 
    text='Overwrite successful'
}
endscript

script mcmess_LoadSuccessful
create_memcard_success_dialog_box {
    title='Successful' 
    text='Load Successful'
}
endscript

script mcmess_FormattingCard
GetPlatform
switch <Platform>
case ps2
create_dialog_box_with_wait {
    title="Formatting..." 
text="Formatting memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1. Do not remove memory card (8MB) (for PlayStation®2), controller, or reset/switch off console."
add_loading_anim=add_loading_anim
}
case ngc
create_dialog_box_with_wait {
    text_dims=(400,0)
    title="Formatting..." 
    text="Formatting. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button."
	add_loading_anim=add_loading_anim
}
endswitch
endscript

script mcmess_FormatSuccessful

memcard_menus_cleanup

create_snazzy_dialog_box {
    title='Successful' 
    text='Format Successful'
    pad_back_script = RetryScript
    buttons=[ 
                {font=small text='OK' pad_choose_script=RetryScript}
            ]    
}

endscript

/////////////////////////////////////////////////////////////////////////
//
// Error messages. These all have an OK button.
// They should all be goto'd rather than called.
// They all start with mcmess_Error
//
/////////////////////////////////////////////////////////////////////////

script create_memcard_error_dialog_box 
memcard_menus_cleanup

create_error_box {
    <...>
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[ 
                {font=small text='Retry' pad_choose_script=RetryScript}
                {font=small text='Quit' pad_choose_script=reload_anims_then_run_abort_script}
            ]    
}
endscript

script create_memcard_success_dialog_box 
	memcard_menus_cleanup
	
	create_snazzy_dialog_box {
		<...>
		pad_back_script = DoneScript
		buttons=[ 
					{font=small text='OK' pad_choose_script=DoneScript pad_choose_params={ type=<type> } }
				]    
	}
endscript

script mcmess_FormatFailed
memcard_menus_cleanup

GetPlatform
switch <Platform>
case ps2
create_error_box {
    title='Warning !' 
    text='Format failed! Please check memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1 and try again.'
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[
                {font=small text='Retry' pad_choose_script=RetryScript}
                {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
            ]
}
case ngc
goto mcmess_DamagedCard
endswitch
endscript

script mcmess_ErrorSaveFailed
GetPlatform
switch <Platform>
case ps2
create_memcard_error_dialog_box {
    title='Warning !' 
    text=[
            'Save failed !\n'
            'Check memory card (8MB) '
            '(for PlayStation®2) in MEMORY CARD '
            'slot 1 and please try again.'
         ]   
}
case xbox
create_memcard_error_dialog_box {
    title='Warning !' 
    text='Failed trying to save.'
}
case ngc
//NOA req. 2.2
//mcmess_ErrorNotEnoughSpaceToSaveAllTypes no_manager

// TT13336, NGC saying 'not enough space to save all types' instead of 'save failed'
// Caused by the lines below being commented out and replaced with the line above 
// for some strange reason.
create_memcard_error_dialog_box {
    text_dims=(350,0)
    title='Warning !' 
    text='Save failed !\nCheck Nintendo GameCube Memory Card in Slot A and please try again !'
}
endswitch
endscript

script mcmess_ErrorOverwriteFailed
GetPlatform
switch <Platform>
case ps2
create_memcard_error_dialog_box {
    title='Warning !' 
    text=[
            'Overwrite failed !\n'
            'Check memory card (8MB) '
            '(for PlayStation®2) in memory card '
            'slot 1 and please try again!'
         ]   
}
case xbox
create_memcard_error_dialog_box {
    title='Warning !' 
    text='Failed trying to overwrite.'
}
case ngc
create_memcard_error_dialog_box {
    text_dims=(350,0)
    title='Warning !' 
    text='Overwrite failed !\nCheck Nintendo GameCube Memory Card in Slot A and please try again !'
}
endswitch
endscript

script mcmess_ErrorbadParkMaxPlayers back_script=reload_anims_then_run_abort_script back_params={}
FormatText {
    TextName=text
    'This park cannot run with %p players.\nThe maximum number of players for this park is %m'
    p=<num_players>
    m=<MaxPlayers>
    }
create_error_box {
    title='Warning !' 
    text=<text>   
    text_dims=(400,0)

    pad_back_script = <back_script>
    pad_back_params=<back_params>
    buttons=[
                {font=small text='OK' pad_choose_script=<back_script> pad_choose_params=<back_params>}
            ]
}
endscript

script mcmess_ErrorLoadFailed
GetPlatform
switch <Platform>
case ps2
if GotParam CorruptedData
    create_memcard_error_dialog_box {
        title='Warning !' 
        text=[
                'Load failed !\n'
                'The file data is damaged.\n'
                'Check memory card (8MB) '
                '(for PlayStation®2) in MEMORY CARD '
                'slot 1 and please try again!'
             ]   
    }
else    
    create_memcard_error_dialog_box {
        title='Warning !' 
        text=[
                'Load failed !\n'
                'Check memory card (8MB) '
                '(for PlayStation®2) in MEMORY CARD '
                'slot 1 and please try again.'
             ]   
    }
endif    
case xbox
GetFileTypeName file_type=<file_type>
FormatText TextName=text 'Unable to load %s. Press A to continue.' s=<filetype_name>
memcard_menus_cleanup

create_error_box {
    title='' 
    text=<text>
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[ 
                {font=small text='Continue' pad_choose_script=reload_anims_then_run_abort_script}
            ]    
}

case ngc
    create_error_box {
        text_dims=(350,0)
        title='Warning !' 
        text='The Memory Card in Slot A contains a corrupted file.'
        pad_back_script = reload_anims_then_run_abort_script
        buttons=[ 
                    {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                    {font=small text='Delete file' pad_choose_script=delete_bad_file pad_choose_params=<...>}
                ]    
    }

    CheckForCardRemoval menu_id=dialog_box_anchor
endswitch
endscript


script mcmess_NGCDeleteCorruptFile
memcard_menus_cleanup

create_error_box {
    text_dims=(350,0)
    title="Warning !"
    text="The Memory Card in Slot A contains a corrupted file."
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[
                { font=small text="Continue without Saving" pad_choose_script=reload_anims_then_run_abort_script}
                { font=small text="Retry" pad_choose_script=RetryScript}
                { font=small text="Delete Corrupted Data" pad_choose_script=NGC_delete_bad_file pad_choose_params = <...>  }
            ]
}
CheckForCardRemoval menu_id=dialog_box_anchor
endscript


script mcmess_ErrorNoCardInSlot
memcard_menus_cleanup

// Using a global instead of passing a param, because passing a param would require making
// sure that param gets passed on in about 60 different places, whereas with the global
// it just has to be set at 24 different places.
if (SavingOrLoading = Saving)
    ContinueText='Continue without saving'
else    
    // This should be 'continue without loading', but just in case there are errors
    // in the setting of SavingOrLoading, Scott would rather have it erroneously say
    // 'Continue without saving' when loaind than say 'Continue without loading' when saving.
    ContinueText='Continue'
endif
    
GetPlatform
switch <Platform>
case ps2
create_error_box {
    title='Warning !' 
    text=[
            'No memory card (8MB) (for PlayStation®2) '
            'in MEMORY CARD slot 1.  '
            'Please insert a memory card (8MB) (for PlayStation®2)'
         ]   
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[
                {font=small text='Retry' pad_choose_script=RetryScript}
                {font=small text=<ContinueText> pad_choose_script=reload_anims_then_run_abort_script}
            ]
}
case ngc
create_error_box {
    title='Warning !' 
    text='There is no Nintendo GameCube Memory Card in Slot A.'
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[
                {font=small text='Retry' pad_choose_script=RetryScript}
                {font=small text=<ContinueText> pad_choose_script=reload_anims_then_run_abort_script}
            ]
}
endswitch
endscript

script mcmess_ErrorNotEnoughRoomNoTHPSFilesExist SpaceRequired=0 SpaceAvailable=0

memcard_menus_cleanup


GetFileTypeName file_type=<FileType>

GetPlatform
switch <Platform>
case ps2
FormatText {
    TextName=text
    'Insufficient free space on memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1.\n%f requires %sKB of free space to save data.'
    s=<SpaceRequired>
    f=<filetype_name>
    }
    create_error_box {
        title='Warning !' 
        text=<text>   
        pad_back_script = reload_anims_then_run_abort_script
            buttons=[
                        {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                        {font=small text='Retry' pad_choose_script=RetryScript}
                        ; PS2 does not need the 'Manage Card' option.
                    ]
    }
case xbox    
FormatText {
    TextName=text
    'Your Xbox does not have enough free blocks to save.\nAt least %s blocks are needed to save the current %f.\nPlease free at least %n blocks.'
    s=<SpaceRequired>
    f=<filetype_name>
    n=(<SpaceRequired> - <SpaceAvailable>)
    }
    create_error_box {
        title='Warning !' 
        text=<text>   
        text_dims=(400,0)
        pad_back_script = reload_anims_then_run_abort_script
            buttons=[
                        {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                        ;{font=small text='Free More Blocks' pad_choose_script=QuitToDashboard}
                    ]
    }
case ngc
FormatText {
    TextName=text
    'There is not enough space on the Memory Card in Slot A. In order to save the current %t file 1 file and %b blocks are required. To manage the contents of your Memory Card, use the Memory Card Screen.'
    t=<filetype_name>
    b=<SpaceRequired>
    }
create_error_box {
    title='Warning !' 
    text=<text>   
    text_dims=(400,0)

    pad_back_script = reload_anims_then_run_abort_script
        buttons=[
                    {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                ]
}
endswitch
endscript


script mcmess_ErrorNotEnoughRoomButTHPSFilesExist SpaceRequired=0
memcard_menus_cleanup

GetFileTypeName file_type=<FileType>

GetPlatform
switch <Platform>
case ps2
FormatText {
    TextName=text
    'Insufficient space on memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1.\n%f requires %sKB of free space to save data.\nWould you like to overwrite previous %f data?'
    s=<SpaceRequired>
    f=<filetype_name>
    }
    create_error_box {
        title='Warning !' 
        text=<text>   
        text_dims=(450,0)
        pad_back_script = reload_anims_then_run_abort_script
            buttons=[
                        {font=small text='Continue' pad_choose_script=launch_files_menu pad_choose_params={DoNotShowNotEnoughRoomMessage Save FileType=<FileType>}}
                        {font=small text='Quit' pad_choose_script=reload_anims_then_run_abort_script}
                    ]
    }
case xbox    
FormatText {
    TextName=text
    'Your Xbox does not have enough free blocks to save.\nAt least %s blocks are needed to save the current %f.\nYou will need to either delete or overwrite existing saves.'
    s=<SpaceRequired>
    f=<filetype_name>
    }
    create_error_box {
        title='Warning !' 
        text=<text>   
        text_dims=(450,0)
        pad_back_script = reload_anims_then_run_abort_script
            buttons=[
                        {font=small text='Continue' pad_choose_script=launch_files_menu pad_choose_params={DoNotShowNotEnoughRoomMessage Save FileType=<FileType>}}
                        {font=small text='Quit' pad_choose_script=reload_anims_then_run_abort_script}
                    ]
    }
case ngc
if GotParam Overwrite
    <word>='overwrite'
else    
    <word>='save'
endif    
FormatText {
    TextName=text
    'There is not enough space on the Memory Card in Slot A. In order to %w the current %t file 1 file and %b blocks are required.\nYou will need to either delete or overwrite existing THUG files. To manage the contents of your Memory Card, use the Memory Card Screen.'
    w=<word>
    t=<filetype_name>
    b=<SpaceRequired>
    }
create_error_box {
    title='Warning !' 
    text=<text>   
    text_dims=(450,0)

    pad_back_script = reload_anims_then_run_abort_script
    buttons=[
                {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                {font=small text='Retry' pad_choose_script=RetryScript}
                {font=small text='Delete/Overwrite THUG files' pad_choose_script=launch_files_menu pad_choose_params={DoNotShowNotEnoughRoomMessage Save FileType=<FileType>}}
            ]
}
endswitch
endscript



script mcmess_ErrorDeleteFailed
if CardIsDamaged
    goto mcmess_DamagedCard        
endif
GetPlatform
switch <Platform>
case ps2
create_memcard_error_dialog_box {
    title='Delete failed !' 
	text='Delete Failed! Please check memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1 and please try again.'
    }
case xbox    
create_memcard_error_dialog_box {
    title='Delete failed !' 
	text='Unable to delete.'
    }
case ngc
create_memcard_error_dialog_box {
    text_dims=(350,0)
    title='Delete failed !' 
	text='Check Nintendo GameCube Memory Card in Slot A and please try again !'
    }
endswitch    
endscript    

script mcmess_NoFiles
GetFileTypeName file_type=<MenuFileType>

if ScreenElementExists id=current_menu_anchor
    DestroyScreenElement id=current_menu_anchor
endif

GetPlatform
switch <Platform>
case ps2
    FormatText {
        TextName=text
        'No THUG %n data present on memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1.'
        n=<filetype_name>
        }
    create_memcard_error_dialog_box {
        title="Warning !" 
        text=<text>
        }
case xbox
    FormatText {
        TextName=text
        'No THUG %n present on hard disk.'
        n=<filetype_name>
        }
    memcard_menus_cleanup
    
    create_error_box {
        title="No Saves" 
        text=<text>
        pad_back_script = reload_anims_then_run_abort_script
        buttons=[ 
                    {font=small text='Quit' pad_choose_script=reload_anims_then_run_abort_script}
                ]    
    }
    
case ngc
    FormatText {
        TextName=text
        'No THUG %n data present on Nintendo GameCube Memory Card in Slot A.'
        n=<filetype_name>
        }
    create_memcard_error_dialog_box {
        title="Warning !" 
        text=<text>
        }
endswitch    

endscript

script mcmess_ErrorNotFormatted QuitText='Continue without formatting' BackScript=reload_anims_then_run_abort_script
memcard_menus_cleanup

GetPlatform
switch <Platform>
case ps2
create_error_box {
    text_dims=(600,0)
    title='Warning !' 
    text='Memory card (8MB) (for PlayStation®2)\n in MEMORY CARD slot 1 is unformatted.'
            
    pad_back_script = <BackScript>
    font=dialog
	buttons=[
                {font=small text=<QuitText> pad_choose_script=reload_anims_then_run_abort_script}
                {font=small text='Retry' pad_choose_script=RetryScript}
                {font=small text='Format Memory Card (8MB) (for PlayStation®2)?' pad_choose_script=mcmess_FormatYesNo pad_choose_params={BackScript=<BackScript>} }
            ]
}
case ngc
if CardIsForeign
    create_error_box {
        text_dims=(590,0)
        title='Warning !' 
        // Changed the text to be as follows to comply with TT12248
        text='The Memory Card in Slot A is corrupted and needs to be formatted.'
                
        pad_back_script = <BackScript>
        buttons=[
                    {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                    {font=small text='Format Memory Card' pad_choose_script=mcmess_FormatYesNo pad_choose_params={BackScript=<BackScript>} }
                ]
    }
else    
    create_error_box {
        text_dims=(590,0)
        title='Warning !' 
        text='The Memory Card in Slot A is corrupted and needs to be formatted.\nDo you want to format?'
                
        pad_back_script = <BackScript>
        buttons=[
                    {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                    {font=small text='Format Memory Card' pad_choose_script=mcmess_FormatYesNo pad_choose_params={BackScript=<BackScript>} }
                ]
    }
endif    
endswitch

CheckForCardRemoval menu_id=dialog_box_anchor

endscript

script mcmess_ErrorNotFormattedNoFormatOption
memcard_menus_cleanup

GetPlatform
switch <Platform>
case ps2
create_error_box {
    title='Warning !' 
    text='Memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1 is unformatted.'
            
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[
                {font=small text='Continue' pad_choose_script=reload_anims_then_run_abort_script}
                {font=small text='Retry' pad_choose_script=RetryScript}
            ]
}
case ngc
// This is confusing now, because Nintendo do want the option to format when loading after all,
// so even though the script is called mcmess_ErrorNotFormattedNoFormatOption, 
// for the NGC it does have Format options.
if CardIsForeign
    create_error_box {
        text_dims=(350,0)
        title='Warning !' 
        // Changed the text to be as follows to comply with TT12248
        text='The Memory Card in Slot A is corrupted and needs to be formatted.'
                
        pad_back_script = <BackScript>
        buttons=[
                    {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                    {font=small text='Format Memory Card' pad_choose_script=mcmess_FormatYesNo pad_choose_params={BackScript=reload_anims_then_run_abort_script} }
                ]
    }
else    
    create_error_box {
        text_dims=(350,0)
        title='Warning !' 
        text='The Nintendo GameCube Memory Card in Slot A is corrupted and needs to be formatted.\nDo you want to format?'
                
        pad_back_script = <BackScript>
        buttons=[
                    {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                    {font=small text='Format Memory Card' pad_choose_script=mcmess_FormatYesNo pad_choose_params={BackScript=reload_anims_then_run_abort_script} }
                ]
    }
endif    
endswitch
CheckForCardRemoval menu_id=dialog_box_anchor
endscript

script mcmess_FormatYesNo BackScript=reload_anims_then_run_abort_script
memcard_menus_cleanup

GetPlatform
switch <Platform>
case ps2
create_snazzy_dialog_box {
    title='Format' 
    text='Are you sure you wish to format memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1?'
            
    pad_back_script = <BackScript>
    buttons=[
                {font=small text='No' pad_choose_script=reload_anims_then_run_abort_script}
                {font=small text='Yes' pad_choose_script=DoFormatCard}
            ]
}
case ngc
create_snazzy_dialog_box {
    title='Format' 
    text='All previously saved data on Memory Card in Slot A will be lost. Would you like to continue formatting?'
            
    pad_back_script = <BackScript>
    buttons=[
                {font=small text='No' pad_choose_script=reload_anims_then_run_abort_script}
                {font=small text='Yes' pad_choose_script=DoFormatCard}
            ]
}
endswitch
CheckForCardRemoval menu_id=dialog_box_anchor
endscript

script GetSaveSizes
GetMemCardSpaceRequired OptionsAndPros
<SaveSize_OptionsAndPros> = <SpaceRequired>

GetMemCardSpaceRequired NetworkSettings
<SaveSize_NetworkSettings> = <SpaceRequired>

GetMemCardSpaceRequired Park
<SaveSize_Park> = <SpaceRequired>

GetMemCardSpaceRequired Cat
<SaveSize_CreateATrick> = <SpaceRequired>

GetMemCardSpaceRequired CreatedGoals
<SaveSize_Goals> = <SpaceRequired>

return <...>
endscript

script mcmess_ErrorNotEnoughSpaceToSaveAllTypes
if(no_load=0)
	memcard_menus_cleanup
else
	<no_bg>=no_bg
endif

GetSaveSizes

GetPlatform
switch <Platform>
case ps2
FormatText {
    TextName=text
    'Insufficient free space on the memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1. At least %c KB of free space is required to save game data. An additional %n KB of free space is also required to play online. A further 94KB of free space is required to play online if you are using the network adaptor (Ethernet) (for PlayStation®2).\n\nStory/Skater requires %c KB\nNet settings requires %n KB\nPark requires %p KB\nTricks require %t KB\nGoals require %g KB'
    c=<SaveSize_OptionsAndPros>
    n=<SaveSize_NetworkSettings>
    p=<SaveSize_Park>
    t=<SaveSize_CreateATrick>
    g=<SaveSize_Goals>
	z=""
    }

    create_error_box {
        title='Warning !' 
        text=<text>
        text_dims=(580,0)
        pos_tweak=(0,-33)
        no_animate
                
        pad_back_script = reload_anims_then_run_abort_script
        buttons=[
                    {font=small text='Continue without saving all types of files' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                ]
    }
case xbox
GetMemCardSpaceAvailable
total_blocks_needed=(<SaveSize_OptionsAndPros>+<SaveSize_Park>+<SaveSize_CreateATrick>+<SaveSize_Goals>)

FormatText {
    TextName=text
    'Your Xbox does not have enough free blocks to save all types of THUG saves.\nPlease free at least %f blocks.\n\nStory/Skater requires %c blocks\nPark requires %p blocks\nTricks require %t blocks\nGoals require %g blocks'
    // Note that these are not in <,> because they are globals, not parameters.
    c=<SaveSize_OptionsAndPros> 
    p=<SaveSize_Park>           
    t=<SaveSize_CreateATrick>
    g=<SaveSize_Goals>
    f=(<total_blocks_needed>-<SpaceAvailable>)
    }

    create_error_box {
        title='' 
        text=<text>
        text_dims=(560,0)
        pos_tweak=(0,-15)
        no_animate
        no_bg=<no_bg>
        ;pad_back_script = reload_anims_then_run_abort_script
        buttons=[
                    {font=small text='Continue without saving all types of game saves' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Free More Blocks' pad_choose_script=QuitToDashboard pad_choose_params={total_blocks_needed=<total_blocks_needed>}}
                ]
    }
case ngc    
FormatText {
    TextName=text
    'The Memory Card in Slot A does not have sufficient space to save all types of THUG save files. Saved data may be loaded and overwritten.\nStory/Skater requires 1 file and %c blocks.\nPark requires 1 file and %p blocks.\nTricks require 1 file and %t blocks.\nGoals require 1 file and %g blocks.\nTo manage the contents of your Memory Card, use the Memory Card Screen.'
    c=<SaveSize_OptionsAndPros>
    p=<SaveSize_Park>           
    t=<SaveSize_CreateATrick>
    g=<SaveSize_Goals>
    }
	
	if GotParam no_manager
		create_error_box {
			title='Warning !' 
			text=<text>
			text_dims=(550,0)
			pos_tweak=(15,-17)
			no_animate
					
			pad_back_script = reload_anims_then_run_abort_script
			buttons=[
						{font=small text='Continue without saving all types of files' pad_choose_script=reload_anims_then_run_abort_script}
						{font=small text='Retry' pad_choose_script=RetryScript}
					]
		}
	else
		create_error_box {
			title='Warning !' 
			text=<text>
			text_dims=(550,0)
			pos_tweak=(15,-17)
			no_animate
					
			pad_back_script = reload_anims_then_run_abort_script
			buttons=[
						{font=small text='Continue without saving all types of files' pad_choose_script=reload_anims_then_run_abort_script}
						{font=small text='Retry' pad_choose_script=RetryScript}
						{font=small text='Manage Memory Card' pad_choose_script=QuitToDashboard}
					]
		}
	endif
/*FormatText {
    TextName=text
    'There is not enough free space on the Memory Card in slot A.  To save THUG, you need at least 4 files and %t blocks.'
    t=(<SaveSize_OptionsAndPros> + <SaveSize_Park> + <SaveSize_CreateATrick> + <SaveSize_Goals>)
    }

    create_error_box {
        title='Warning !' 
        text=<text>
        text_dims=(550,0)
        pos_tweak=(15,-17)
        no_animate
                
        pad_back_script = reload_anims_then_run_abort_script
        buttons=[
                    {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                    {font=small text='Manage Memory Card' pad_choose_script=QuitToDashboard}
                ]
    }*/
endswitch
endscript


script mcmess_ErrorNoCardOnBootup
memcard_menus_cleanup

GetSaveSizes

GetPlatform
switch <Platform>
case ps2
FormatText {
    TextName=text
    'No memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1.\nPlease insert a memory card (8MB) (for PlayStation®2) with at least %c KB free space. An additional %n KB of free space is required to play online. A further 94KB of free space is required to play online if you are using the network adaptor (Ethernet) (for PlayStation®2).\n\nStory/Skater requires %c KB\nNet settings requires %n KB\nPark requires %p KB\nTricks require %t KB\nGoals require %g KB'
    c=<SaveSize_OptionsAndPros>
    n=<SaveSize_NetworkSettings>
    p=<SaveSize_Park>
    t=<SaveSize_CreateATrick>
    g=<SaveSize_Goals>
	z=""
    }
    create_error_box {
        title='Warning !' 
        text=<text>
        text_dims=(560,0)
        pos_tweak=(0,-33)
        no_animate
        
        pad_back_script = generic_menu_pad_back 
		pad_back_params = {callback=reload_anims_then_run_abort_script}
        buttons=[
                    {font=small text='Continue without saving all types of game files' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                ]
    }
// No case for XBox, since it will always have a hard drive.    
case ngc    
FormatText {
    TextName=text
    'No Memory Card detected in Slot A.\n\nStory/Skater requires 1 file and %c blocks\nPark requires 1 file and %p blocks\nTricks require 1 file and %t blocks\nGoals require 1 file and %g blocks'
    c=<SaveSize_OptionsAndPros> 
    p=<SaveSize_Park>           
    t=<SaveSize_CreateATrick>
    g=<SaveSize_Goals>
    }

    create_error_box {
        title='Warning !' 
        text=<text>
        text_dims=(500,0)
        pos_tweak=(0,0)
        no_animate
                
        pad_back_script = generic_menu_pad_back 
		pad_back_params = {callback=reload_anims_then_run_abort_script}
        buttons=[
                    {font=small text='Continue without saving all types of files' pad_choose_script=reload_anims_then_run_abort_script}
                    {font=small text='Retry' pad_choose_script=RetryScript}
                ]
    }
endswitch
endscript

script mcmess_AutoLoadingCas filename=""
GetPlatform
switch <Platform>
case ps2
FormatText {
    TextName=text
    "Loading Create-A-Skater file '%s'. Do not remove memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1, reset, or switch off console."
    s=<filename>
    }
create_dialog_box_with_wait {
    title='Loading ...' 
    text=<text>
}
case xbox
FormatText {
    TextName=text
    "Loading Create-A-Skater '%s' from hard disk.\nPlease do not turn off your Xbox console."
    s=<filename>
    }
create_dialog_box_with_wait {
    title='Loading ...' 
    text_dims=(350,0)
    text=<text>
}
case ngc
FormatText {
    TextName=text
    "Loading Create-A-Skater file '%s'. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button."
    s=<filename>
    }
create_dialog_box_with_wait {
    title='Loading ...' 
    text_dims=(350,0)
    text=<text>
}
endswitch
endscript

script mcmess_AutoSavingCas filename=""
GetPlatform
switch <Platform>
case ps2
FormatText {
    TextName=text
    "Saving Create-A-Skater file '%s'. Do not remove memory card (8MB) (for PlayStation®2) in MEMORY CARD slot 1, reset, or switch off console."
    s=<filename>
    }
create_dialog_box_with_wait {
    title='Saving ...' 
    text=<text>
}
case xbox
FormatText {
    TextName=text
    "Saving Create-A-Skater '%s' to hard disk.\nPlease do not turn off your Xbox console."
    s=<filename>
    }
create_dialog_box_with_wait {
    title='Saving ...' 
    text_dims=(350,0)
    text=<text>
}
case ngc
FormatText {
    TextName=text
    "Saving Create-A-Skater file '%s'. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button."
    s=<filename>
    }
create_dialog_box_with_wait {
    title='Saving ...' 
    text_dims=(350,0)
    text=<text>
}
endswitch
endscript

script mcmess_PleaseEnterCasFilename
if isXbox
	create_dialog_box_with_wait {
    title='Warning ...' 
    text="Your Create-A-Skater has not been saved yet.\nPlease enter a name for your Create-A-Skater.\n"
}
else
	create_dialog_box_with_wait {
    title='Warning ...' 
    text="Your Create-A-Skater has not been saved yet.\nPlease enter a file name for your Create-A-Skater.\n"
}
endif
endscript

script mcmess_DamagedCard
memcard_menus_cleanup

create_error_box {
    title='Error'
    text='The Memory Card in Slot A is damaged and cannot be used.'
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[
                {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                {font=small text='Retry' pad_choose_script=RetryScript}
            ]
}
endscript

script mcmess_BadDevice
memcard_menus_cleanup

create_error_box {
    title='Error'
    text='Wrong device in Slot A. Please insert a Memory Card.'
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[
                {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                {font=small text='Retry' pad_choose_script=RetryScript}
            ]
}
endscript

script mcmess_BadSectorSize
memcard_menus_cleanup

create_error_box {
    title='Error'
    text='The Memory Card in Slot A is not compatible with the THUG save file.'
    pad_back_script = reload_anims_then_run_abort_script
    buttons=[
                {font=small text='Continue without saving' pad_choose_script=reload_anims_then_run_abort_script}
                {font=small text='Retry' pad_choose_script=RetryScript}
            ]
}
endscript

