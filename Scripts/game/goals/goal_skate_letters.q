// S-K-A-T-E letters!

// generic params for goal manager
Goal_SkateLetters_genericParams = {
    goal_text="Collect S-K-A-T-E"
	view_goals_text="Collect S-K-A-T-E"
    
    goal_flags=[
        got_S
        got_K
        got_A
        got_T
        got_E
    ]
    
    init = SkateLetters_Init
	uninit = goal_uninit
    active = SkateLetters_Active
    activate = SkateLetters_Activate
    deactivate = SkateLetters_Deactivate
    fail = SkateLetters_Fail
    success = SkateLetters_Win
    expire = SkateLetters_Expire

    trigger_obj_id = TRG_G_SKATE_Pro
    
    S_obj_id=TRG_Goal_Letter_S
    K_obj_id=TRG_Goal_Letter_K
    A_obj_id=TRG_Goal_Letter_A
    T_obj_id=TRG_Goal_Letter_T
    E_obj_id=TRG_Goal_Letter_E
    
    time = 120
    
    restart_node = TRG_G_SKATE_RestartNode
    start_pad_id = G_SKATE_StartPad
	
	record_type = score
}



script SkateLetters_Init
    // RunScriptOnObject id=<trigger_obj_id> ShowObject
    goal_init goal_id=<goal_id>
	; GoalManager_InitGoalTrigger name=<goal_id>
/*    
    Create_skate <...>
    <s_obj_id>:Obj_Invisible
    <k_obj_id>:Obj_Invisible
    <a_obj_id>:Obj_Invisible
    <t_obj_id>:Obj_Invisible
    <e_obj_id>:Obj_Invisible
*/
endscript


script SkateLetters_Activate        
    goal_start goal_id=<goal_id>
	
	Create_skate <...>
    
    RunScriptOnObject id=<s_obj_id> SkateLetter_InitLetter params={ goal_id=<goal_id> flag=got_S id=<s_obj_id> }
    RunScriptOnObject id=<k_obj_id> SkateLetter_InitLetter params={ goal_id=<goal_id> flag=got_K id=<k_obj_id> }
    RunScriptOnObject id=<a_obj_id> SkateLetter_InitLetter params={ goal_id=<goal_id> flag=got_A id=<a_obj_id> }
    RunScriptOnObject id=<t_obj_id> SkateLetter_InitLetter params={ goal_id=<goal_id> flag=got_T id=<t_obj_id> }
    RunScriptOnObject id=<e_obj_id> SkateLetter_InitLetter params={ goal_id=<goal_id> flag=got_E id=<e_obj_id> }
endscript


script SkateLetter_InitLetter
    // <id>:Obj_Visible
    
    Obj_ClearExceptions
    Obj_RotY speed = 200
    Obj_SetInnerRadius 8
    Obj_SetException ex=SkaterInRadius scr=SkateLetter_GotLetter params={ id=<id> goal_id=<goal_id> flag=<flag> }
endscript

script SkateLetter_GotLetter
    SpawnSkaterScript SkateLetter_GotLetter2 params={ goal_id=<goal_id> flag=<flag> id=<id> }
endscript

script SkateLetter_GotLetter2
    if not IsInBail
        <id>:Obj_ClearExceptions
        PlaySound goaldone vol=150
        
		KillLocal name=<id>
		// <id>:Obj_Invisible
    
        GoalManager_SetGoalFlag name=<goal_id> <flag> 1
        
        SkateLetter_HUDLetter flag=<flag>
    endif
endscript

script SkateLetters_Active
    if GoalManager_AllFlagsSet name=<goal_id>
        GoalManager_WinGoal name=<goal_id>
    endif
endscript


script SkateLetters_Fail
    kill_skate_messages
    
    goal_fail goal_id=<goal_id>
endscript

script SkateLetters_Deactivate    
    GoalManager_ResetGoalTrigger name=<goal_id>    

	goal_deactivate goal_id=<goal_id>

	goal_skate_kill_letters <...>
    
/*	
    <s_obj_id>:Obj_Invisible
    <s_obj_id>:Obj_ClearExceptions
    
    <k_obj_id>:Obj_Invisible
    <k_obj_id>:Obj_ClearExceptions
    
    <a_obj_id>:Obj_Invisible
    <a_obj_id>:Obj_ClearExceptions
    
    <t_obj_id>:Obj_Invisible
    <t_obj_id>:Obj_ClearExceptions
    
    <e_obj_id>:Obj_Invisible
    <e_obj_id>:Obj_ClearExceptions
*/    
    kill_skate_messages
endscript

script SkateLetters_Expire
    goal_expire goal_id=<goal_id>
    GoalManager_LoseGoal name=<goal_id>
endscript
    

script SkateLetters_Win
    goal_success goal_id=<goal_id>
    kill_skate_messages
//    GoalManager_RemoveGoal name=<goal_id>
endscript

// @script | SkateLetter_HUDLetter | creates panel message for each letter as you
// collect them
script SkateLetter_HUDLetter
    if ChecksumEquals a=<flag> b=got_S
        create_panel_message id=skate_letter_s text="S" style=panel_message_letterS
    else
        if ChecksumEquals a=<flag> b=got_K
            create_panel_message id=skate_letter_k text="K" style=panel_message_letterK
        else
            if ChecksumEquals a=<flag> b=got_a
                create_panel_message id=skate_letter_a text="A" style=panel_message_letterA
            else
                if ChecksumEquals a=<flag> b=got_t
                    create_panel_message id=skate_letter_t text="T" style=panel_message_letterT
                else
                    if ChecksumEquals a=<flag> b=got_e
                        create_panel_message id=skate_letter_e text="E" style=panel_message_letterE
                    endif
                endif
            endif
        endif
    endif
endscript

script goal_skate_hide_letters
	if ObjectExists id=skate_letter_s
		DoScreenElementMorph id=skate_letter_s time=0 alpha=0
	endif
	if ObjectExists id=skate_letter_k
		DoScreenElementMorph id=skate_letter_k time=0 alpha=0
	endif
	if ObjectExists id=skate_letter_a
		DoScreenElementMorph id=skate_letter_a time=0 alpha=0
	endif
	if ObjectExists id=skate_letter_t
		DoScreenElementMorph id=skate_letter_t time=0 alpha=0
	endif
	if ObjectExists id=skate_letter_e
		DoScreenElementMorph id=skate_letter_e time=0 alpha=0
	endif
endscript

script goal_skate_unhide_letters
	if ObjectExists id=skate_letter_s
		DoScreenElementMorph id=skate_letter_s time=0 alpha=1
	endif
	if ObjectExists id=skate_letter_k
		DoScreenElementMorph id=skate_letter_k time=0 alpha=1
	endif
	if ObjectExists id=skate_letter_a
		DoScreenElementMorph id=skate_letter_a time=0 alpha=1
	endif
	if ObjectExists id=skate_letter_t
		DoScreenElementMorph id=skate_letter_t time=0 alpha=1
	endif
	if ObjectExists id=skate_letter_e
		DoScreenElementMorph id=skate_letter_e time=0 alpha=1
	endif
endscript

// create remaining letters
Script Create_skate
    CreateLocal name = <s_obj_id>
    CreateLocal name = <k_obj_id>
    CreateLocal name = <a_obj_id>
    CreateLocal name = <t_obj_id>
    CreateLocal name = <e_obj_id>
    
    RunScriptOnObject id=<s_obj_id> bounce_skate_letter
    RunScriptOnObject id=<k_obj_id> bounce_skate_letter
    RunScriptOnObject id=<a_obj_id> bounce_skate_letter
    RunScriptOnObject id=<t_obj_id> bounce_skate_letter
    RunScriptOnObject id=<e_obj_id> bounce_skate_letter
Endscript

script goal_skate_kill_letters
    KillLocal name = <s_obj_id>
    KillLocal name = <k_obj_id>
    KillLocal name = <a_obj_id>
    KillLocal name = <t_obj_id>
    KillLocal name = <e_obj_id>
endscript


// ***********************************
//      SKATE letter helpers
// ***********************************


// kill all SKATE panel messages
script kill_skate_messages
    if ObjectExists id=skate_letter_s
        RunScriptOnScreenElement id=skate_letter_S kill_panel_message
    endif
    if ObjectExists id=skate_letter_K
        RunScriptOnScreenElement id=skate_letter_K kill_panel_message
    endif
    if ObjectExists id=skate_letter_A
        RunScriptOnScreenElement id=skate_letter_A kill_panel_message
    endif
    if ObjectExists id=skate_letter_T
        RunScriptOnScreenElement id=skate_letter_T kill_panel_message
    endif
    if ObjectExists id=skate_letter_E
        RunScriptOnScreenElement id=skate_letter_E kill_panel_message
    endif    
endscript


script bounce_skate_letter
   	Obj_Hover Amp=6 Freq=2
/*
    Begin
        Obj_MoveToRelPos (0,2,0) time=.1
        Obj_WaitMove
        Obj_MoveToRelPos (0,6,0) time=.1
        Obj_WaitMove
        Obj_MoveToRelPos (0,2,0) time=.1
        Obj_WaitMove
        Obj_MoveToRelPos (0,1,0) time=.1
        Obj_WaitMove
        Obj_MoveToRelPos (0,-2,0) time=.1
        Obj_WaitMove
        Obj_MoveToRelPos (0,-6,0) time=.1
        Obj_WaitMove
        Obj_MoveToRelPos (0,-2,0) time=.1
        Obj_WaitMove
        Obj_MoveToRelPos (0,-1,0) time=.1
        Obj_WaitMove
    Repeat
*/    
endscript

// **********************************
//      SKATE style scripts
// **********************************

script panel_message_letterS
    SetProps font=small just=[center center] rgba=[127 102 0 95]
    
    DoMorph time=.08 scale=.3  pos=(695,150)
    DoMorph time=.12 scale=3.5 pos=(610,150)
    DoMorph time=.14 scale=.6
    DoMorph time=.16 scale=1.8
    DoMorph time=.18 scale=.8
    DoMorph time=.20 scale=1.2
    
  endscript

script panel_message_letterK
    SetProps font=small just=[center center] rgba=[127 102 0 95]
    
    DoMorph time=.08 scale=.3  pos=(695,180)
    DoMorph time=.12 scale=3.5 pos=(610,180)
    DoMorph time=.14 scale=.6
    DoMorph time=.16 scale=1.8
    DoMorph time=.18 scale=.8
    DoMorph time=.20 scale=1.2
    
endscript

script panel_message_letterA
    SetProps font=small just=[center center] rgba=[127 102 0 95]
    
    DoMorph time=.08 scale=.3  pos=(695,210)
    DoMorph time=.12 scale=3.5 pos=(610,210)
    DoMorph time=.14 scale=.6
    DoMorph time=.16 scale=1.8
    DoMorph time=.18 scale=.8
    DoMorph time=.20 scale=1.2
    
endscript

script panel_message_letterT
    SetProps font=small just=[center center] rgba=[127 102 0 95]
    
    DoMorph time=.08 scale=.3  pos=(695,240)
    DoMorph time=.12 scale=3.5 pos=(610,240)
    DoMorph time=.14 scale=.6
    DoMorph time=.16 scale=1.8
    DoMorph time=.18 scale=.8
    DoMorph time=.20 scale=1.2
    
endscript

script panel_message_letterE
    SetProps font=small just=[center center] rgba=[127 102 0 95]
    
    DoMorph time=.08 scale=.3  pos=(695,270)
    DoMorph time=.12 scale=3.5 pos=(610,270)
    DoMorph time=.14 scale=.6
    DoMorph time=.16 scale=1.8
    DoMorph time=.18 scale=.8
    DoMorph time=.20 scale=1.2
    
endscript


// these are the trigger scripts...they need to be here because they're still 
// associated with the letter objects...we need to take those associations out
script Goal_Skate_Letter_S
endscript
script Goal_Skate_Letter_K
endscript
script Goal_Skate_Letter_A
endscript
script Goal_Skate_Letter_T
endscript
script Goal_Skate_Letter_E
endscript
