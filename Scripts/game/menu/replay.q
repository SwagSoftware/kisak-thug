EndOfReplayShouldJumpToPauseMenu=0
InGameReplay=0
/*

script view_loaded_replay
PauseGame
SetButtonEventMappings unblock_menu_input // Needed otherwise end-replay menu won't respond
Change InGameReplay=0
SetupReplayStartAndChooseKeyBindings
HideGameObjects
GoalManager_PauseAllGoals
KillSpawnedScript Name=WindyClothes
Skater:BloodParticlesOff
Skater:sparks_off
PlaybackReplay
endscript

script in_game_view_replay
Change InGameReplay=1
HideGameObjects

SaveSkateAndComboLetters

view_replay
endscript

script view_replay
exit_pause_menu
kill_blur
hide_goal_panel_messages
kill_combo_messages
kill_skate_messages
// Kill any death message, such as those that come up when you fall into the water.
if ScreenElementExists id=death_message
    DestroyScreenElement id=death_message
endif    
if ScreenElementExists id=leaving_message
    DestroyScreenElement id=leaving_message
endif    
// Kill any tetris trick lists so that they are not stuck on screen throughout the replay.
if ScreenElementExists id=tetris_menu_anchor
    DoScreenElementMorph id=tetris_menu_anchor scale=0
endif

// Switch off the scores at the top right and top left.
if ScreenElementExists id=the_score
    DoScreenElementMorph id=the_score scale=0 relative
endif
GoalManager_HideGoalPoints

KillSpawnedScript Name=WindyClothes
Skater:BloodParticlesOff
Skater:sparks_off
PauseGame

SetupReplayStartAndChooseKeyBindings
DeleteDummies
GoalManager_PauseAllGoals
Skater:SkaterSplashOff
Skater:UnHide
PlaybackReplay store
endscript

// The c-code runs this when the replay completes.
script EndOfReplay
; Just in case the last frame of the replay did a blur
kill_blur
; Just in case the replay ends with the skater in mid-splash
Skater:SkaterSplashOff

hide_goal_panel_messages
kill_combo_messages
kill_skate_messages
ClearTrickAndScoreText

// This is to stop the skater sparks from updating when the end-of-replay menu comes up.
PauseReplay

if istrue InGameReplay
    create_in_game_end_replay_menu
else
    create_end_loaded_replay_menu
endif    
endscript

script create_in_game_end_replay_menu

if ObjectExists id=current_menu_anchor
    DestroyScreenElement id=current_menu_anchor
endif

KillReplayStartAndChooseKeyBindings
make_new_sprite_menu menu_id=end_replay_menu vmenu_id=end_replay_vmenu pad_back_script=end_replay_continue

create_helper_text generic_helper_text

make_sprite_menu_item text="Continue Game" id=menu_continue pad_choose_script=end_replay_continue
make_text_sprite texture=DE_continue parent=menu_continue

make_sprite_menu_item text="View Replay" id=menu_view_replay pad_choose_script=view_replay
// TODO Need replay sprite ...
make_text_sprite texture=DE_Replay parent=menu_view_replay

;set_menu_bg
RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
endscript

script end_replay_continue
exit_pause_menu
UnPauseReplay
SwitchToReplayRecordMode
ClearTrickAndScoreText
DeleteDummies
ShowGameObjects
// Restore the goal timer
GoalManager_UnPauseAllGoals
// Restore any tetris trick names that might have been on screen before the replay was run.
if ScreenElementExists id=tetris_menu_anchor
    DoScreenElementMorph id=tetris_menu_anchor scale=1
endif
// Put the skate and combo letters back the way they were.
RestoreSkateAndComboLetters
// Put the scores at the top left and top right back the way they were.
if ScreenElementExists id=the_score
    DoScreenElementMorph id=the_score scale=1 relative
endif
GoalManager_ShowPoints
if not GoalManager_HasActiveGoals
    GoalManager_ShowGoalPoints
endif

UnPauseGame
if GameModeEquals is_singlesession
    // If we're going back to single session but the session has ended, go straight to
    // the pause menu, not back to the game, because the skater will be disabled.
    if IsTrue EndOfReplayShouldJumpToPauseMenu
        PauseGame
        create_pause_menu
    endif    
endif
endscript


script create_end_loaded_replay_menu

if ObjectExists id=current_menu_anchor
    DestroyScreenElement id=current_menu_anchor
endif

KillReplayStartAndChooseKeyBindings
make_new_sprite_menu menu_id=end_loaded_replay_menu vmenu_id=end_loaded_replay_vmenu pad_back_script=nullscript

create_helper_text generic_helper_text_no_back

// TODO Need replay sprite ...
make_sprite_menu_item text="View Replay" id=menu_view_replay pad_choose_script=view_replay
make_text_sprite texture=DE_Replay parent=menu_view_replay

// TODO Is there a quit sprite ?
make_sprite_menu_item text="Quit" id=menu_quit pad_choose_script=end_loaded_replay_quit
make_text_sprite texture=DE_Quit parent=menu_quit

;set_menu_bg

RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
endscript

script end_loaded_replay_quit
exit_pause_menu
SwitchToReplayRecordMode
ClearTrickAndScoreText
DeleteDummies
DeallocateReplayMemory
AllocateReplayMemory
ShowGameObjects

;level_select_change_level level=Load_skateshop no_levelUnload
level_select_change_level_quit level=Load_skateshop no_levelUnload
endscript

script KillReplayStartAndChooseKeyBindings
SetScreenElementProps {
    id=root_window
    event_handlers=[
                    {pad_start 		null_script}
                    {pad_choose		null_script}
                   ]
    replace_handlers
}
endscript

script SetupReplayStartAndChooseKeyBindings
SetScreenElementProps {
    id=root_window
    event_handlers=[
                    {pad_start 		interrupt_replay}
                   ]
    replace_handlers
}
endscript




script create_interrupt_replay_menu

if ObjectExists id=current_menu_anchor
    DestroyScreenElement id=current_menu_anchor
endif

KillReplayStartAndChooseKeyBindings
make_new_sprite_menu menu_id=interrupt_replay_menu vmenu_id=interrupt_replay_vmenu pad_back_script=interrupt_replay_continue

create_helper_text generic_helper_text

make_sprite_menu_item text="Continue Replay" id=menu_continue pad_choose_script=interrupt_replay_continue
make_text_sprite texture=DE_continue parent=menu_continue

make_sprite_menu_item text="Restart Replay" id=menu_restart pad_choose_script=interrupt_replay_restart
make_text_sprite texture=DE_Replay parent=menu_restart

make_sprite_menu_item text="Quit Replay" id=menu_quit pad_choose_script=interrupt_replay_quit
// TODO Need replay sprite ...
make_text_sprite texture=DE_Replay parent=menu_quit

;set_menu_bg
RunScriptOnScreenElement id=current_menu_anchor menu_onscreen
endscript

script interrupt_replay_continue
exit_pause_menu
PauseGame
SetupReplayStartAndChooseKeyBindings
UnPauseReplay
// Somehow the goal points get unhidden, (probably in exit_pause_menu)
// so turn them off again.
GoalManager_HideGoalPoints
endscript

script interrupt_replay_restart
exit_pause_menu
PauseGame
SetupReplayStartAndChooseKeyBindings
DeleteDummies
GoalManager_PauseAllGoals

// Somehow the goal points get unhidden, (probably in exit_pause_menu)
// so turn them off again.
GoalManager_HideGoalPoints
PlaybackReplay
endscript

script interrupt_replay_quit
; Just in case the last frame of the replay did a blur
kill_blur
; Just in case the replay ends with the skater in mid-splash
Skater:SkaterSplashOff

hide_goal_panel_messages
kill_combo_messages
kill_skate_messages

// Do the same cleanup/restoration as when the end-replay menu is quit.
goto end_replay_continue
endscript

script interrupt_replay
generic_menu_pad_choose_sound
PauseMusicAndStreams 1
ClearTrickAndScoreText
PauseReplay
kill_blur
create_interrupt_replay_menu
endscript




GotSkateLetterS=0
GotSkateLetterK=0
GotSkateLetterA=0
GotSkateLetterT=0
GotSkateLetterE=0
GotComboLetterC=0
GotComboLetterO=0
GotComboLetterM=0
GotComboLetterB=0
GotComboLetterO2=0

script SaveSkateAndComboLetters
Change GotSkateLetterS=0
Change GotSkateLetterK=0
Change GotSkateLetterA=0
Change GotSkateLetterT=0
Change GotSkateLetterE=0
Change GotComboLetterC=0
Change GotComboLetterO=0
Change GotComboLetterM=0
Change GotComboLetterB=0
Change GotComboLetterO2=0

if ObjectExists id=skate_letter_s
    Change GotSkateLetterS=1
endif

if ObjectExists id=skate_letter_k
    Change GotSkateLetterK=1
endif

if ObjectExists id=skate_letter_a
    Change GotSkateLetterA=1
endif

if ObjectExists id=skate_letter_t
    Change GotSkateLetterT=1
endif

if ObjectExists id=skate_letter_e
    Change GotSkateLetterE=1
endif

if ObjectExists id=combo_letter_c
    Change GotComboLetterC=1
endif

if ObjectExists id=combo_letter_o
    Change GotComboLetterO=1
endif

if ObjectExists id=combo_letter_m
    Change GotComboLetterM=1
endif

if ObjectExists id=combo_letter_b
    Change GotComboLetterB=1
endif

if ObjectExists id=combo_letter_o2
    Change GotComboLetterO2=1
endif

endscript

script RestoreSkateAndComboLetters
kill_skate_messages
kill_combo_messages

if IsTrue GotSkateLetterS
    SkateLetter_HUDLetter flag=got_s
endif    

if IsTrue GotSkateLetterK
    SkateLetter_HUDLetter flag=got_k
endif    

if IsTrue GotSkateLetterA
    SkateLetter_HUDLetter flag=got_a
endif    

if IsTrue GotSkateLetterT
    SkateLetter_HUDLetter flag=got_t
endif    

if IsTrue GotSkateLetterE
    SkateLetter_HUDLetter flag=got_e
endif    

if IsTrue GotComboLetterC
    ComboLetter_HUDLetter flag=got_c
endif    

if IsTrue GotComboLetterO
    ComboLetter_HUDLetter flag=got_o
endif    

if IsTrue GotComboLetterM
    ComboLetter_HUDLetter flag=got_m
endif    

if IsTrue GotComboLetterB
    ComboLetter_HUDLetter flag=got_b
endif    

if IsTrue GotComboLetterO2
    ComboLetter_HUDLetter flag=got_o2
endif    

endscript
*/

