// start autoduck documentation
// @DOC goal_tour
// @module goal_tour | None
// @subindex Scripting Database
// @index script | goal_tour

/* Dan: THUG: Not walking safe and unused, so I commented it out.  See me if you need to use it.

goal_tour_genericParams = {
    goal_text = "Generic tour text"
	view_goals_text = "Tour goal"
    time = 120

    init = goal_tour_init
	uninit = goal_uninit
    activate = goal_tour_activate
    active = goal_tour_active
    success = goal_tour_success
    fail = goal_tour_fail
    deactivate = goal_tour_deactivate
    expire = goal_tour_expire

    trigger_obj_id = TRG_G_TOUR_Pro
    restart_node = TRG_G_TOUR_RestartNode
    start_pad_id = G_TOUR_StartPad

    goal_flags = [ got_1
                   got_2
                   got_3
                 ]

    tour_spots = [ { id=TRG_G_TOUR_Spot01 flag=got_1 time=10 text="spot 1" }
                   { id=TRG_G_TOUR_Spot02 flag=got_2 time=10 text="spot 2" }
                   { id=TRG_G_TOUR_Spot03 flag=got_3 time=10 text="spot 3" }
                 ]

	EndRunCalled = 0

	record_type = score
}

script goal_tour_init
    ; GoalManager_InitGoalTrigger name=<goal_id>
	goal_init goal_id=<goal_id>
endscript

script goal_tour_activate
    goal_start goal_id=<goal_id> dont_unpause=dont_unpause
    GoalManager_NextTourSpot name=<goal_id>
endscript

script goal_tour_next_spot
	if not GotParam start_cam_anim
		<start_cam_anim> = <goal_id>
	endif

	// wait for the cam to end
	GetSkaterId
	if GotParam first_spot
		begin
			printf "looping"
			if SkaterCamAnimFinished skater=<ObjId> name=<start_cam_anim>
				; GoalManager_UnPauseGoal name=<goal_id>
				break
			endif
			wait 1 gameframe
		repeat
	endif

	printf "goal_tour_next_spot"
	printstruct <...>
	// move the skater to the new node if we need to
/*	if not GotParam first_spot
		MakeSkaterGoto EndOfRun
		GoalManager_EditGoal name=<goal_id> params={ EndRunCalled = 1 }
		Skater:DisablePlayerInput

		WaitForEvent type=EndOfRunDone

		MakeSkaterGoto SkaterInit
		ResetSkaters Node_Name=<id>
		wait 1 frame
		PauseSkaters
	endif
*/
ResetSkaters node_name=<id>
wait 1 gameframe

PauseSkaters

if GotParam text
	create_speech_box text=<text> pad_choose_script=goal_tour_continue
endif

if GotParam first_spot
	GoalManager_GetGoalParams name=<goal_id>
	<cam_anim> = <start_cam_anim>
	goal_tour_next_spot2 <...>
else
	GoalManager_GetGoalParams name=<goal_id>
	// move the trigger to the next spot
	if GotParam pro_node
		<trigger_obj_id>:Obj_MoveToNode name=<pro_node>
	endif
	<trigger_obj_id>:Obj_LookAtObject type=skater time=.05
	GetSkaterId
	if GotParam cam_anim
		PlaySkaterCamAnim skaterId=<ObjId> name=<cam_anim> skippable=1 play_hold
	endif
	create_speech_box {
		text="Press \m0 to continue"
		pos=(320, 400)
		pad_choose_script=goal_tour_next_spot2
		pad_choose_params=<...>
	}
endif
endscript

script goal_tour_next_spot2
	// wait for the cam anim to finish
	wait 1 gameframe
	GetSkaterId
	if GotParam cam_anim
		begin
			if SkaterCamAnimFinished skaterId=<objId> name=<cam_anim>
				printf "unpausing"
				GoalManager_UnPauseGoal name=<goal_id>
				break
			endif
			wait 1 gameframe
		repeat
	endif

	speech_box_exit

	FireEvent type=goal_horse_wait_done
	GoalManager_UnPauseGoal name=<goal_id>
	UnPauseSkaters
	GoalManager_EditGoal name=<goal_id> params={ EndRunCalled = 0 }
	GoalManager_GetGoalParams name=<goal_id>

	if GotParam scr
		SpawnScript <scr>
	endif

	// show the next score total
	; wait 30 frame
	Skater:EnablePlayerInput

	// remember this score value and flag
	GoalManager_EditGoal name=<goal_id> params={ current_flag=<flag> }
endscript

script goal_tour_active
	if GoalManager_AllFlagsSet name=<goal_id>
		GoalManager_winGoal name=<goal_id>
	endif
endscript

script goal_tour_success
	goal_success goal_id=<goal_id>
endscript

script goal_tour_deactivate
	KillSpawnedScript name=goal_tour_next_spot

	GetSkaterId
	KillSkaterCamAnim skater=<objId> name=<goal_id>

	Skater:EnablePlayerInput

	// do we have to get the skater out of endofrun?
	if ( <EndRunCalled> = 1 )
		MakeSkaterGoto SkaterInit
	endif
	GoalManager_EditGoal name=<goal_id> params={ EndRunCalled = 0 }

	if ObjectExists id=current_tour_spot
		DestroyScreenElement id=current_tour_spot
	endif

	<trigger_obj_id>:Obj_MoveToNode name=<trigger_obj_id>

	goal_deactivate goal_id=<goal_id>
	GoalManager_ResetGoalTrigger name=<goal_id>
endscript

script goal_tour_fail
	goal_fail goal_id=<goal_id>
endscript

script goal_tour_expire
	goal_expire goal_id=<goal_id>
	GoalManager_LoseGoal name=<goal_id>
endscript

script goal_tour_continue
	UnPauseSkaters
	speech_box_exit
endscript

// **************************************
// 		Style scripts
// **************************************

script panel_message_new_tour_spot blink_time=.05
	/*	SetProps dims=(450,55) rgba=[128 128 128 80] just=[right top]
    DoMorph pos=(705,15) scale=1.3 time=1
    DoMorph pos=(705,15) scale=.6 time=1.1
    DoMorph pos=(705,15) scale=.8 time=1.11

    begin
        DoMorph alpha=0
        wait <blink_time> seconds
        DoMorph alpha=1
        wait <blink_time> seconds
    repeat 6
*/
	SetProps just=[right top] rgba=[128 128 128 128]
	DoMorph pos=(445, 175)
	DoMorph pos=(445, 175) time=1.2
	DoMorph pos=(630, 55) scale=1.3 time=.1
	DoMorph pos=(630, 55) scale=.8 time=.11

	begin
		DoMorph alpha=0
		wait <blink_time> seconds
		DoMorph alpha=1
		wait <blink_time> seconds
	repeat 6
endscript
*/
