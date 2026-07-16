
// special mapguy...
MapGuy_GenericParams={
    trigger_obj_id = TRG_MapGuy
}

script AddMapGuy
    MapGuy_InitTrigger MapGuy_GenericParams <...>
endscript

script MapGuy_InitTrigger  
    if not ObjectExists id=<trigger_obj_id>
        create name = <trigger_obj_id>
    endif

    if GotParam trigger_wait_script
        RunScriptOnObject id=<trigger_obj_id> <trigger_wait_script>
    else
        RunScriptOnObject id=<trigger_obj_id> GenericProWaiting
    endif
	
	attach_arrow_to_object object_id=<trigger_obj_id>
    
    RunScriptOnObject id=<trigger_obj_id> mapguy_set_exceptions params=<...>
endscript

script mapguy_set_exceptions trigger_radius=8
    Obj_ClearExceptions
    Obj_SetInnerRadius <trigger_radius>
    Obj_SetException ex=SkaterInRadius scr=mapguy_got_trigger params=<...>
endscript

script mapguy_got_trigger
    if SkaterSpeedLessThan 20
        if SkaterIsBraking
            PauseSkaters
            Obj_ClearExceptions
            Obj_SetOuterRadius 20
            Obj_SetException ex=SkaterOutOfRadius scr=mapguy_set_exceptions params=<...>
            
            if ObjectExists id=current_menu_anchor
                DestroyScreenElement id=current_menu_anchor
            endif
            create_level_select_menu
            
            SetScreenElementProps { id=level_select_menu
                                    event_handlers=[
                                        {pad_back   mapguy_exit params=<...>}
                                    ]
                                    replace_handlers
                                  }
                                  
            SetScreenElementProps { id=root_window
                                    event_handlers=[
                                        {pad_start      mapguy_exit params=<...>}
                                    ]
                                    replace_handlers
                                  }
        endif
    endif       
endscript

// *********************************************
//      Pressed triangle on map guy
// *********************************************

script mapguy_exit
    KillSkaterCamAnim all
    SetScreenElementProps { id=root_window
                            replace_handlers
                            event_handlers=[
                                {pad_start      handle_start_pressed}
                            ]
                          }    
    UnPauseSkaters
    exit_pause_menu
endscript


// ***************************************
//      Pressed start while on mapguy
// ***************************************

script mapguy_start
    SetScreenElementProps { id=root_window
                            replace_handlers
                            event_handlers=[
                                {pad_start      handle_start_pressed}
                            ]
                          }
    UnPauseSkaters
    <trigger_obj_id>:Obj_ClearExceptions
    <trigger_obj_id>:Obj_SetOuterRadius 20
    <trigger_obj_id>:Obj_SetException ex=SkaterOutOfRadius scr=mapguy_set_exceptions params=<...>
    exit_pause_menu
endscript

