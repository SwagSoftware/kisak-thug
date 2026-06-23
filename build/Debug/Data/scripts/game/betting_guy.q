// betting guy

/*betting_guy_GenericParams = {
	goal_text = "Generic betting guy text"

	init = betting_guy_init
	; active = betting_guy_active
	; activate = betting_guy_activate
	; deactivate = betting_guy_deactivate
	; expire = betting_guy_expire
	success = betting_guy_success
	fail = betting_guy_fail

	betting_guy_id = TRG_MG_BettingGuy01
	trigger_obj_id = TRG_MG_BettingGuy01

	pro="BettingGuy"

	betting_guy
}

script betting_guy_init
	printf "betting_guy_init"
	if not ObjectExists id=<betting_guy_id>
		create name=<betting_guy_id>
	endif
    ; <betting_guy_id>:Obj_Invisible
	GoalManager_MoveBettingGuyNow
	betting_guy_change_ai goal_id=<goal_id> type="wait"
endscript

script betting_guy_change_ai
	GoalManager_GetGoalParams name=<goal_id>

	if GotParam current_trigger_script
		KillSpawnedScript id=<current_trigger_script>
	endif

	// may need to support more types later...
	switch <type>
	case "talking"
		<ai> = GenericProTalking
	default
		<ai> = GenericProWaiting
	endswitch

	RunScriptOnObject id=<betting_guy_id> <ai> params={ type=<type> goal_id=<goal_id> }
	GoalManager_EditGoal name=<goal_id> params={ current_trigger_script=<UniqueID> }
endscript

;script betting_guy_active
;endscript

;script betting_guy_activate
;endscript

;script betting_guy_deactivate
;endscript

;script betting_guy_expire
;endscript

script betting_guy_success
	printf "betting_guy_success"
	create_speech_box text="You won the bet!" style=betting_guy_speech_box pad_choose_script=nullscript no_pad_start no_pad_choose
	betting_guy_change_ai goal_id=<goal_id> type="wait"
	; GoalManager_GetGoalParams name=<current_minigame>
	; printstruct <...>
endscript

script betting_guy_fail
	printf "Betting_guy_fail"
	create_speech_box text="You lost the bet!" style=betting_guy_speech_box pad_choose_script=nullscript no_pad_start no_pad_choose
	betting_guy_change_ai goal_id=<goal_id> type="wait"
endscript

script betting_guy_move_to_node
	printf "moving betting guy"
	GoalManager_GetGoalParams name=<goal_id>
	<betting_guy_id>:Obj_Visible
	<betting_guy_id>:Obj_MoveToNode name=<new_node>
	RunScriptOnObject id=<betting_guy_id> betting_guy_init_trigger params={ goal_id=<goal_id> }
endscript

// ********************************************
// 		trigger crap...similar to goal pros
// ********************************************

script betting_guy_init_trigger
	GoalManager_GetGoalParams name=<goal_id>

	if GotParam current_challenge
		FormatText TextName=bet_text "I bet you %a bucks you can't %t %c %u in %n tries. \m0 to accept, \mc to decline." a=<bet_amount> t=<bet_action> c=<current_challenge> u=<bet_unit> n=<num_tries>
	else
		FormatText TextName=bet_text "I bet you %a bucks you can't %t %l in %n tries.  \m0 to accept, \mc to decline." a=<bet_amount> t=<bet_action> l=<location> n=<num_tries>
	endif
	setup_ped_speech {
		ped_id=<betting_guy_id>
		text=<bet_text>
		pad_choose_script=betting_guy_accept
		pad_choose_params={ betting_guy_id=<betting_guy_id> goal_id=<goal_id> }
		pad_back_script=betting_guy_refuse
		pad_back_params={ betting_guy_id=<betting_guy_id> goal_id=<goal_id> }
		activation_script=betting_guy_offer
		activation_script_params={ goal_id=<goal_id> }
		no_repeat
	}
endscript

script betting_guy_offer
	// change his ai
	betting_guy_change_ai goal_id=<goal_id> type="talking"

	GoalManager_BetOffered
endscript

script betting_guy_accept
	<betting_guy_id>:Obj_ClearExceptions
	GoalManager_BetAccepted

	// TODO: move the guy to some new state/anims
	betting_guy_change_ai goal_id=<goal_id> new_script=GenericProWaiting type="midgoal"

	; UnPauseSkaters
	MakeSkaterGoto SkaterInit
	speech_box_exit
endscript

script betting_guy_refuse
	<betting_guy_id>:Obj_ClearExceptions
	GoalManager_BetRefused

	// TODO: move the guy to some new state/anims
	betting_guy_change_ai goal_id=<goal_id> type="wait"

	; UnPauseSkaters
	MakeSkaterGoto SkaterInit
	speech_box_exit
endscript

script betting_guy_wait_for_land
	printf"betting_guy_wait_for_land"
	Obj_SetException ex=SkaterLanded scr=betting_guy_end_attempt params={ goal_id=<goal_id> }
	Obj_SetException ex=SkaterBailed scr=betting_guy_end_attempt params={ goal_id=<goal_id> }
endscript

script betting_guy_end_attempt
	Obj_ClearException SkaterLanded
	Obj_ClearException SkateBailed
	printf "ending attempt"
	wait 1 frame
	GoalManager_EndBetAttempt name=<goal_id>
endscript

// **************************************************
//			style scripts
// **************************************************

script betting_guy_speech_box
	DoMorph time=0 scale=1
	// play a sound?
	wait 1500
	Die
endscript*/
