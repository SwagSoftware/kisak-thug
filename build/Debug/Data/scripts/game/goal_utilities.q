// start autoduck documentation
// @DOC goal_utilities
// @module goal_utilities | None
// @subindex Scripting Database
// @index script | goal_utilities

// this is the name of the generic pro model, for
// when you're playing as the same character as the
// regular goal ped pro
generic_pro_name = "peds/PedPros/PedPro_Neversoft/PedPro_Neversoft.skin"
generic_pro_first_name = "Neversoft"
generic_pro_full_name = "Neversoft Skater"

// global used to adjust volume when you go into the save game sequence
goal_want_to_save_volume = 0

// global to allow goal retry on select
goal_bind_retry_to_select = 0

// max number of allowed trickslots
max_number_of_special_trickslots = 11

// utility scripts for goal system

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// @script | goal_init |
script goal_init
	; printf "goal_init"
	; PrintScriptInfo
	GoalManager_GetGoalParams name=<goal_id>

	GoalManager_InitGoalTrigger name=<goal_id>

	if GotParam init_geo_prefix
		create prefix=<init_geo_prefix>
	else
		if GotParam init_geo_prefixes
			GetArraySize <init_geo_prefixes>
			<index> = 0
			begin
				create prefix=( <init_geo_prefixes>[<index>] )
				<index> = ( <index> + 1 )
			repeat <array_size>
		endif
	endif

	if GotParam init_script
		<init_script> <init_script_params>
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// @script | goal_check_chapter_flags |
script goal_check_chapter_flags
	GetArraySize CHAPTER_GOALS
	<chapter_goals_size> = <array_size>
	GetArraySize CHAPTER_NUM_GOALS_TO_COMPLETE
	if not ( <chapter_goals_size> = <array_size> )
		script_assert "chapter_goals and chapter_num_goals_to_complete are not the same size!"
	endif

	<chapter_goals_index> = 0
	begin
		// get chapter array
		<chapter_array> = ( CHAPTER_GOALS[<chapter_goals_index>] )
		GetArraySize <chapter_array>
		<chapter_array_size> = <array_size>
		<chapter_array_index> = 0

		begin
			// get stage array
			<stage_array> = ( <chapter_array>[<chapter_array_index>] )
			GetArraySize <stage_array>
			<stage_array_size> = <array_size>
			<stage_array_index> = 0
			<stage_total> = 0
			<stage_total_target> = ( ( CHAPTER_NUM_GOALS_TO_COMPLETE[<chapter_goals_index>] )[<chapter_array_index>] )
			begin
				// get goal id - not all id's have been assigned
				// yet, so fail gracefully
				<temp_struct> = ( <stage_array>[<stage_array_index>] )

				if StructureContains structure=<temp_struct> goal_id
					if GoalManager_GoalExists name=( <temp_struct>.goal_id )
						if GoalManager_HasWonGoal name=( <temp_struct>.goal_id )
							goal_check_chapter_flags_goal_beaten goal_id=( <temp_struct>.goal_id )
							<stage_total> = ( <stage_total> + 1 )
						endif
					endif
				endif

				<stage_array_index> = ( <stage_array_index> + 1 )
			repeat <stage_array_size>

			; printf "chapter_total = %t, chapter_total_target = %c" t=<chapter_total> c=<chapter_total_target>
			if ( <stage_total> > ( <stage_total_target> - 1 ) )
				// grab any completion struct
				goal_check_chapter_flags_stage_beaten {
					stage_array=<stage_array>
					completion_struct=( ( CHAPTER_COMPLETION_SCRIPTS[<chapter_goals_index>] )[<chapter_array_index>] )
				}
			endif
			<chapter_array_index> = ( <chapter_array_index> + 1 )
		repeat <chapter_array_size>

		<chapter_goals_index> = ( <chapter_goals_index> + 1 )
	repeat <chapter_goals_size>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_check_chapter_flags_goal_beaten
	GoalManager_GetGoalParams name=<goal_id>

	if GotParam some_shit
		// do something
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_check_chapter_flags_stage_beaten
	// uninitialize the goals
	GetArraySize <stage_array>
	<index> = 0
	begin
		<temp_struct> = ( <stage_array>[<index>] )
		if StructureContains structure=<temp_struct> goal_id
			; printf "uninitializing goal: %g" g=( <temp_struct>.goal_id )
			if GoalManager_GoalExists name=( <temp_struct>.goal_id )
				GoalManager_UninitializeGoal name=( <temp_struct>.goal_id ) affect_tree
			endif
		endif
		<index> = ( <index> + 1 )
	repeat <array_size>

	if GotParam completion_struct
		if StructureContains structure=<completion_struct> script_name
			<script_name> = ( <completion_struct>.script_name )
		endif
		if StructureContains structure=<completion_struct> params
			<script_params> = ( <completion_struct>.params )
		endif
		<script_name> <script_params>
	endif
endscript

cur_tod_cur_action = set_tod_day
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// @script | goal_start | displays goal text when a new goal is
// started.  checks the has_seen goal param to determine whether it should
// pause and display "New Goal" etc
script goal_start
	; printf "goal_start"
	; printstruct <...>

	GetCurrentLevel
	if ChecksumEquals a=<level> b=Load_Sk5Ed
		GoalManager_EditGoal name=<goal_id> params={testing_goal}
	endif

	ResetScore

	Skater:Vibrate Off

	// kill any splats
	KillAllTextureSplats

	// clean up any old panel messages
	destroy_goal_panel_messages

	// don't kill the trigger!
	; KillSpawnedScript name=goal_wait_and_kill_trigger
	KillSpawnedScript name=goal_wait_and_show_key_combo_text

	KillSpawnedScript name=SK3_Killskater_Finish use_proper_version

	GoalManager_GetGoalParams name=<goal_id>

	if not GotParam quick_start
		kill_start_key_binding
	endif

	if not IsAlive name=<trigger_obj_id>
		GoalManager_EditGoal name=<goal_id> params={ force_create_trigger = 1 }
		GoalManager_InitializeGoal name=<goal_id>
		GoalManager_EditGoal name=<goal_id> params={ force_create_trigger = 0 }
		GoalManager_GetGoalParams name=<goal_id>
	endif

	if InNetGame
		GoalManager_AnnounceGoalStarted name=<goal_id>
	endif

	// TODO: this is an e3 test...it might break stuff
	<trigger_obj_id>:Obj_ClearExceptions

	// clear any custom score record
	if GotParam custom_score_record
		GoalManager_EditGoal name=<goal_id> params={ custom_score_record=0 }
	endif

	// get rid of any goal start dialog
	if ObjectExists id=goal_start_dialog
		speech_box_exit anchor_id=goal_start_dialog
	endif

	if ObjectExists id=goal_retry_anchor
		DestroyScreenElement id=goal_retry_anchor
	endif

	// kill any ped arrow
	FormatText ChecksumName=arrow_id "%s_ped_arrow" s=<goal_name>
	if ScreenElementExists id=<arrow_id>
		DestroyScreenElement id=<arrow_id>
	endif

	KillSpawnedScript name=goal_init_after_end_of_run
	GetSkaterId
	KillSkaterCamAnim skaterId=<ObjId> all

	GoalManager_HideGoalPoints
	GoalManager_GetGoalParams name=<goal_id>

	// set parent goal tod
	if GameModeEquals is_career
		goal_get_chapter_stage_from_id id=<goal_id>

		if GotParam stage
			change cur_tod_cur_action = ((STAGE_TOD_SETTINGS[<chapter>])[<stage>])
		endif
	endif

	// create geo
	if GotParam geo_prefix
		goal_create_geo_prefix geo_prefix=<geo_prefix>
	else
		if GotParam geo_prefixes
			GetArraySize <geo_prefixes>
			<index> = 0
			begin
				goal_create_geo_prefix geo_prefix=( <geo_prefixes>[<index>] )
				<index> = ( <index> + 1 )
			repeat <array_size>
		endif
	endif

	// the goal manager will move the skater automatically
	// on restart
	Skater:RunStarted
	if GotParam quick_start
		goal_initialize_skater <...>
		DeBounce x time=0.3
	else
		if GotParam intro_node
			ResetSkaters Node_Name=<intro_node>
		else
			ResetSkaters Node_Name=<restart_node>
		endif
	endif

	// run custom start script
	if GotParam goal_intro_script
		<goal_intro_script> <goal_intro_script_params>
	endif

	// get the params in case the intro script changed something
	GoalManager_GetGoalParams name=<goal_id>

	/*
	if not GoalManager_HasSeenGoal name=<goal_id>
		create_panel_message id=new_goal_message text="New Goal" style=panel_message_new_goal
		create_panel_sprite id=new_goal_sprite texture=GO_new style=panel_sprite_new_goal
	endif
*/

	// create proset geo
	if Not InNetGame
		goal_create_proset_geom <...>
	endif

	// if its a created vehicle goal, run the appropriate level setup script
	if GotParam edited_goal
		if GotParam control_type
			if not ( ( <control_type> = Skate ) || ( <control_type> = Walk ) || ( <control_type> = WalkOnly ))
				GoalManager_GetLevelPrefix
				FormatText ChecksumName=ReadyLevelScript "%l_KillVehicles" l=<level_prefix>
				if ScriptExists <ReadyLevelScript>
					<ReadyLevelScript>
				endif
			endif
		endif
	endif

	SetScoreAccumulation 1
	SetScoreDegradation 1

	if (Inside_Light_Rain = 1)
		if IsSoundPlaying TestLight01
			SetSoundParams TestLight01 vol=LightRainVolume
		endif
		change Paused_Light_Rain=0
		change Inside_Light_Rain=0
	endif

	if (Inside_Heavy_Rain = 1)
		if IsSoundPlaying TestLight02
			SetSoundParams TestLight02 vol=LightRainVolume
		endif
		if IsSoundPlaying TestMedium02
			SetSoundParams TestMedium02 vol=MediumRainVolume
		endif
		change Paused_Heavy_Rain=0
		change Inside_Heavy_Rain=0
	endif

	// create triggers
	if GotParam trigger_prefix
		create prefix=<trigger_prefix>
	endif

	if GotParam quick_start

		if GotParam hide_goal_pro
			<trigger_obj_id>:Obj_Invisible
		endif

		// Start recording the goal attempt
		; StartRecordingAfresh

		// figure any type of hud elements necessary
		if GotParam use_hud_counter
			goal_create_counter goal_id=<goal_id> hud_counter_caption=<hud_counter_caption>
		endif

		if not GotParam dont_show_goal_text
			create_panel_block id=current_goal text=<goal_text> style=panel_message_goal
			if GotParam key_combo_text
				SpawnScript goal_wait_and_show_key_combo_text params={ text=<key_combo_text> }
			endif
		endif

		if GotParam goal_start_script
			<goal_start_script> <goal_start_script_params>
		endif
		if not goalmanager_haswongoal name=<goal_id>
			spawnscript goal_show_tips params={ goal_id=<goal_id> }
		endif

		goal_pro_stop_anim_scripts <...>
		/*		// move the ped to midgoal state
		if GotParam current_trigger_script
			KillSpawnedScript id=<current_trigger_script>
		endif
*/
		if not GotParam trigger_wait_script
			<trigger_wait_script> = GenericProWaiting
		endif
		; RunScriptOnObject id=<trigger_obj_id> <trigger_wait_script> params={ type="midgoal" goal_id=<goal_id> pro=<pro> }
		<trigger_obj_id>:Obj_SpawnScript <trigger_wait_script> params={ type="midgoal" goal_id=<goal_id> pro=<pro> }
		; GoalManager_EditGoal name=<goal_id> params={ current_trigger_script=<UniqueID> }

		FireEvent type=goal_cam_anim_post_start_done
	else

		if GameModeEquals is_career
			;destroy_goal_panel_messages all
			goal_get_chapter_stage_from_id id=<goal_id>

			if not GotParam always_initialize_goal

				if GotParam stage
					GoalManager_GetCurrentChapterAndStage

					tod_cur_action=((STAGE_TOD_SETTINGS[<currentChapter>])[<currentStage>])
					tod_req_action=((STAGE_TOD_SETTINGS[<chapter>])[<stage>])

					if not (<tod_cur_action> = <tod_req_action>)
						script_change_tod tod_action=<tod_req_action>
						change cur_tod_cur_action = <tod_req_action>
					endif
				else //we're in a subgoal - make sure tod carries over. ASSUMPTION: user cannot go directly to a subgoal
					GoalManager_GetCurrentChapterAndStage

					tod_cur_action=cur_tod_cur_action
					tod_req_action=((STAGE_TOD_SETTINGS[<currentChapter>])[<currentStage>])
					;printstruct <...>
					if not (<tod_cur_action> = <tod_req_action>)
						script_change_tod tod_action=<tod_cur_action>
					endif
				endif
			endif
		endif
		// pro isn't waiting anymore
		; if GotParam current_trigger_script
		; 	KillSpawnedScript id=<current_trigger_script>
		; endif
		goal_pro_stop_anim_scripts <...>
		if GotParam goal_start_trigger_script
			; RunScriptOnObject id=<trigger_obj_id> <goal_start_trigger_script> params={ goal_id=<goal_id> type="talking" pro=<pro>}
			<trigger_obj_id>:Obj_SpawnScript <goal_start_trigger_script> params={ goal_id=<goal_id> type="talking" pro=<pro>}
		else
			; RunScriptOnObject id=<trigger_obj_id> GenericProTalking params={ goal_id=<goal_id> type="talking" pro=<pro> }
			<trigger_obj_id>:Obj_SpawnScript GenericProTalking params={ goal_id=<goal_id> type="talking" pro=<pro> }
		endif

		; GoalManager_EditGoal name=<goal_id> params={ current_trigger_script=<UniqueID> }


		// start some music up while we're in a goal
		; SkipTrack
		; PauseMusic 1

		// play cam anim if present
		if not GotParam trigger_wait_script
			<trigger_wait_script> = GenericProWaiting
		endif

		if GotParam goal_start_movie_script
			<goal_start_movie_script> <goal_start_movie_script_params>
		endif

		if GotParam no_play_hold
			<no_play_hold> = no_play_hold
		endif

		SpawnScript goal_cam_anim_play id=new_goal_cam_anim params={ goal_id=<goal_id>
			next_trigger_script=<trigger_wait_script>
			type="midgoal"
			<no_play_hold>
			dont_unpause=<dont_unpause>
		}
	endif

	// set an outer radius for the goal if needed
	if GotParam kill_radius
		; RunScriptOnObject id=<restart_node> goal_set_kill_radius params=<...>
		<trigger_obj_id>:Obj_SetOuterRadius <kill_radius>
		<trigger_obj_id>:Obj_SetException ex=SkaterOutOfRadius scr=goal_crossed_kill_radius params={ goal_id=<goal_id> }
	endif

	// make the time look cool
	RunScriptOnScreenElement id=the_time clock_morph
endscript

script goal_get_chapter_stage_from_id

	chapter=0
	GetArraySize CHAPTER_GOALS
	num_chapters=<array_size>
	begin
		;GetArraySize (CHAPTER_GOALS[<chapter>])
		GetArraySize CHAPTER_GOALS index1=<chapter>
		num_stages=<array_size>

		stage=0
		begin
			;GetArraySize ( ( CHAPTER_GOALS[<chapter>] )[<stage>] )
			;Get2DArrayData ArrayName=CHAPTER_GOALS index1=<chapter> index2=<stage>
			;GetArraySize <val>
			GetArraySize CHAPTER_GOALS index1=<chapter> index2=<stage>
			index=0
			begin
				;goal_info = ( ( ( CHAPTER_GOALS[<chapter>] )[<stage>] )[<index>] )
				Get3DArrayData ArrayName=CHAPTER_GOALS index1=<chapter> index2=<stage> index3=<index>
				;goal_id = ( <goal_info>.goal_id )
				goal_id = ( <val>.goal_id )
				if GotParam goal_id
					if (<goal_id>=<id>)
						return stage=<stage> chapter=<chapter>
					endif
				endif
				index = ( <index> + 1 )
			repeat <array_size>
			stage = ( <stage> + 1 )
		repeat <num_stages>
		chapter = (<chapter> + 1)
	repeat <num_chapters>
endscript

script goal_create_geo_prefix
	create prefix=<geo_prefix>

	FormatText TextName=geo_trigger_prefix "TRG_%p" p=<geo_prefix>
	create prefix=<geo_trigger_prefix>

	// kill 'not' geo and prefix
	GoalManager_GetProsetNotPrefix <geo_prefix>
	kill prefix=<proset_not_prefix>
	FormatText TextName=geo_not_trigger_prefix "TRG_%p" p=<proset_not_prefix>
	; printf "%s" s=<geo_not_trigger_prefix>
	kill prefix=<geo_not_trigger_prefix>
endscript

script goal_kill_geo_prefix
	kill prefix=<geo_prefix>

	FormatText TextName=geo_trigger_prefix "TRG_%p" p=<geo_prefix>
	kill prefix=<geo_trigger_prefix>

	// kill 'not' geo and prefix
	GoalManager_GetProsetNotPrefix <geo_prefix>
	create prefix=<proset_not_prefix>
	FormatText TextName=geo_not_trigger_prefix "TRG_%p" p=<proset_not_prefix>
	; printf "%s" s=<geo_not_trigger_prefix>
	create prefix=<geo_not_trigger_prefix>
endscript

script goal_create_proset_geom
	if GotParam proset_prefix
		FormatText ChecksumName=proset_flag "FLAG_%pGEO_ON" p=<proset_prefix>
		SetFlag flag=<proset_flag>

		create prefix=<proset_prefix>
		FormatText TextName=proset_trigger_prefix "TRG_%p" p=<proset_prefix>
		create prefix=<proset_trigger_prefix>

		GoalManager_GetProsetNotPrefix <proset_prefix>
		kill prefix=<proset_not_prefix>
		FormatText TextName=proset_not_trigger_prefix "TRG_%p" p=<proset_not_prefix>
		kill prefix=<proset_not_trigger_prefix>
	endif
endscript

script goal_kill_proset_geom
	if GotParam proset_prefix
		FormatText ChecksumName=proset_flag "FLAG_%pGEO_ON" p=<proset_prefix>
		UnSetFlag flag=<proset_flag>

		kill prefix=<proset_prefix>
		FormatText TextName=proset_trigger_prefix "TRG_%p" p=<proset_prefix>
		kill prefix=<proset_trigger_prefix>

		GoalManager_GetProSetNotPrefix <proset_prefix>
		create prefix=<proset_not_prefix>
		FormatText TextName=proset_not_trigger_prefix "TRG_%p" p=<proset_not_prefix>
		create prefix=<proset_not_trigger_prefix>
	endif
endscript

/*
script goal_set_kill_radius
	printf "goal_set_kill_radius"
	Obj_SetOuterRadius <kill_radius>
	Obj_SetException ex=SkaterOutOfRadius scr=goal_crossed_kill_radius params={ goal_id=<goal_id> }
endscript
*/

script goal_crossed_kill_radius
	create_panel_message id=goal_message text="You left the goal area!" style=panel_message_generic_loss
	Obj_ClearException SkaterOutOfRadius
	GoalManager_LoseGoal name=<goal_id>
endscript

// @script | goal_expire | Displays generic "Out of time!" message
// and kills any current goal messages appearing on screen
script goal_expire
	destroy_goal_panel_messages

	; printf "goal_expire"
	create_panel_message id=goal_message text="Out of time!" style=panel_message_generic_loss

	if GoalManager_EndRunCalled name=<goal_id>
		if GoalManager_StartedEndOfRun name=<goal_id>
			SpawnSkaterScript goal_init_after_end_of_run params={ goal_id=<goal_id> }
		else
			GoalManager_ClearEndRun name=<goal_id>
		endif
	endif
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// @script | goal_success | Displays completion message and destroys other
// goal messages.  This script only shows messages and plays the goaldone sound,
// it does not take care of any geometry
// @parm string | goal_text | the goal message - usually this is part of your goal_params structure
// in your level specific params file (eg, Sch_goal_skate_params in level_goals_sch.q)
script goal_success goal_text="Default goal success text"
	; printf "goal_success - %s" s=<goal_id>
	// Stop recording while the movie plays
	SwitchToReplayIdleMode

	if not InNetGame
		kill_start_key_binding
	endif

	// destroy any hud stuff
	destroy_goal_panel_messages
	goal_destroy_counter

	GoalManager_GetGoalParams name=<goal_id>

	if not GotParam testing_goal
		// Tell the goal editor that a goal has been won.
		// (Won't do anything if the goal is not a created-goal)
		GoalEditor:FlagGoalAsWon goal_id=<goal_id>
	endif

	// start the outro script
	if GotParam goal_outro_script
		<goal_outro_script> <goal_outro_script_params>
	endif

	// they beat the goal so leave geo on
	;if GotParam geo_prefix
	;    create prefix=<geo_prefix>
	;endif

	if ObjectExists id=goal_message
		RunScriptOnScreenElement id=goal_message kill_panel_message
	endif

	// play ped anim
	; if GotParam current_trigger_script
	;     KillSpawnedScript id=<current_trigger_script>
	; endif
	goal_pro_stop_anim_scripts <...>
	if ObjectExists id=<trigger_obj_id>
		if GotParam trigger_success_script
			; RunScriptOnObject id=<trigger_obj_id> <trigger_success_script> params={ goal_id=<goal_id> pro=<pro> }
			<trigger_obj_id>:Obj_SpawnScript <trigger_success_script> params={ goal_id=<goal_id> pro=<pro> type="Success" }
		else
			; RunScriptOnObject id=<trigger_obj_id> GenericProSuccess params={ goal_id=<goal_id> pro=<pro> }
			<trigger_obj_id>:Obj_SpawnScript GenericProSuccess params={ goal_id=<goal_id> pro=<pro> type="Success" }
		endif
	endif
	; GoalManager_EditGoal name=<goal_id> params={ current_trigger_script=<UniqueID> }

	if not GotParam trigger_wait_script
		<trigger_wait_script> = GenericProWaiting
	endif

	// check if they already beat this goal before
	<already_beat_goal> = 0
	if GoalManager_HasWonGoal name=<goal_id>
		<already_beat_goal> = 1
	endif

	// award trickslot
	if not ( <already_beat_goal> = 1 )
		if GotParam reward_trickslot
			if not GotParam already_added_trickslot
				GoalManager_EditGoal name=<goal_id> params={ just_added_trickslot=1 }
				GetSkaterProfileInfoByName name=custom
				; printf "max_specials is %i" i=<max_specials>
				if ( <max_specials> < max_number_of_special_trickslots )
					AwardSpecialTrickslot
				endif
			endif
		endif
	endif

	SpawnScript goal_success_messages params=<...>

	if not InMultiplayerGame
		<played_success_movie> = 0
		if ( ( GotParam success_cam_anim ) || ( GotParam success_cam_anims ) )
			<played_success_movie> = 1
			change check_for_unplugged_controllers = 0
			SpawnScript goal_cam_anim_play params = { goal_id=<goal_id>
				just_won_goal=1
				gonna_show_message
				already_beat_goal=<already_beat_goal>
			}
		endif

		if ( <played_success_movie> = 0 )
			SpawnScript goal_success_no_anims params=<...>
		endif
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_success_no_anims
	; goal_cam_anim_pre_cleanup <...>
	; GoalManager_SetCanStartGoal 0
	// SpawnScript goal_cam_anim_mid_success params={ <...> gonna_show_message }

	; WaitForEvent type=goal_description_and_speech_continue

	goal_cam_anim_post_cleanup <...>

	goal_cam_anim_post_success dont_kill_messages <...>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_success_messages
	; printf "goal_success_messages"
	; printstruct <...>
	SpawnScript Goal_Success_Message_Sound
	if GotParam view_goals_text
		create_panel_block id=goal_complete text=<view_goals_text> style=panel_message_goalcomplete
	else
		create_panel_block id=goal_complete text=<goal_text> style=panel_message_goalcomplete
	endif
	;WaitForEvent type=panel_message_goalcomplete_done
	create_panel_sprite id=goal_complete_sprite texture=GO_done style=panel_sprite_goalcomplete
	;WaitForEvent type=panel_sprite_goalcomplete_done
	create_panel_message id=goal_complete_line2 text="Complete!" style=panel_message_goalcompleteline2

	if GotParam reward_trickslot
		if GotParam just_added_trickslot
			if ( <just_added_trickslot> = 1 )
				GoalManager_EditGoal name=<goal_id> params={ just_added_trickslot = 0 }
				goal_got_trickslot
			endif
		endif
	endif
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script already_in_goal
	create_panel_message id=goal_message text="Already in goal run" style=panel_message_goal
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_lose_next_frame
	wait 1 frame
	if GoalManager_GoalIsActive name=<goal_id>
		GoalManager_LoseGoal name=<goal_id>
	endif
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_fail
	; printf "goal_fail"

	destroy_goal_panel_messages

	PlaySound GoalFail vol=200

	; MakeSkaterGoto SkaterInit
	GoalManager_GetGoalParams name=<goal_id>

	if GotParam goal_fail_script
		<goal_fail_script> <goal_fail_script_params>
	endif

	create_panel_sprite id=goalfail_sprite texture=GO_fail style=panel_sprite_goalfail
	if GotParam view_goals_text
		create_panel_block dims=(640, 0) id=goalfail text=<view_goals_text> style=panel_message_goalfail
	else
		create_panel_block dims=(640, 0) id=goalfail text=<goal_text> style=panel_message_goalfail
	endif

	create_panel_message id=goalfailedline2 text="Failed!" style=panel_message_goalfailline2

	if isxbox
		retry_text="Press \b8 to retry goal"
	else
		retry_text="Press START (\b8) to retry goal"
	endif

	// put up a speech box telling them they can retry
	create_speech_box {
		anchor_id=goal_retry_anchor
		text=<retry_text>
		style=goal_fail_retry_box_style
		no_pad_start
		no_pad_choose
		z_priority=10
	}
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
script goal_fail_retry_box_style
	wait 4000
	Die
endscript


// @script | goal_uninit | this is called after deactivating goals
// that have parents.  They need to be uninitialized so the ped and any
// geo disappears
script goal_uninit
	; printf "goal_uninit"
	; PrintScriptInfo
	GoalManager_GetGoalParams name=<goal_id>

	goal_kill_proset_geom <...>

	if IsAlive name=<trigger_obj_id>
		; <trigger_obj_id>:Obj_StopStream
		GoalManager_StopLastStream name=<goal_id>
		GoalManager_UnloadLastFam name=<goal_id>
		kill name=<trigger_obj_id>
	endif

	if GotParam init_geo_prefix
		kill prefix=<init_geo_prefix>
	else
		if GotParam init_geo_prefixes
			GetArraySize <init_geo_prefixes>
			<index> = 0
			begin
				kill prefix=( <init_geo_prefixes>[<index>] )
				<index> = ( <index> + 1 )
			repeat <array_size>
		endif
	endif
endscript


// @script | goal_deactivate | executed whenever the goal ends - ie, success, fail,
// expire, and quit
script goal_deactivate
	//printf "***** goal_deactivate *****"

	if GameModeEquals is_goal_attack
		//printf "***** is goal attack *****"
		KillSpawnedScript name=goal_cam_anim_play
		KillSpawnedScript name=goal_cam_anim_play_single_element
		KillSpawnedScript name=TemporarilyDisableInput
		KillSkaterCamAnim all
		restore_skater_camera
		speech_box_exit anchor_id=goal_description_anchor no_pad_start
		Skater:NetEnablePlayerInput
		SetButtonEventMappings unblock_menu_input
		restore_start_key_binding
		if not GoalManager_CanStartGoal
			MakeSkaterGoto OnGroundAI
		endif
		GoalManager_SetCanStartGoal 1
	endif

	// kill any splats
	KillAllTextureSplats

	// don't kill the trigger yet!
	; KillSpawnedScript name=goal_wait_and_kill_trigger
	KillSpawnedScript name=goal_show_tips
	KillSpawnedScript name=goal_wait_and_show_key_combo_text

	// destroy hud stuff
	goal_destroy_counter

	if GoalManager_EndRunCalled name=<goal_id>
		if GoalManager_StartedEndOfRun name=<goal_id>
			SpawnSkaterScript goal_init_after_end_of_run params={ goal_id=<goal_id> }
		else
			GoalManager_ClearEndRun name=<goal_id>
		endif
	endif

	GoalManager_StopLastStream name=<goal_id>
	GoalManager_UnloadLastFam name=<goal_id>

	SetScoreAccumulation 0
	SetScoreDegradation 0

	GoalManager_GetGoalParams name=<goal_id>

	// hack for team select.  remember whether the last
	// start was a quick_start
	if GotParam quick_start
		GoalManager_EditGoal name=<goal_id> params={ last_start_was_quick_start = 1 }
	else
		GoalManager_EditGoal name=<goal_id> params={ last_start_was_quick_start = 0 }
	endif

	// kill intro script
	if GotParam goal_intro_script
		KillSpawnedScript name=goal_intro_script
	endif

	// run custom deactivate script
	if GotParam goal_deactivate_script
		<goal_deactivate_script> <goal_deactivate_script_params>
	endif

	// kill the current goal message(s)
	KillSpawnedScript name=goal_description_and_speech
	KillSpawnedScript name=goal_wait_for_cam_anim
	if ScreenElementExists id=current_goal
		DestroyScreenElement id=current_goal
	endif
	if ScreenElementExists id=current_goal_key_combo_text
		DestroyScreenElement id=current_goal_key_combo_text
	endif
	if ObjectExists id=current_goal_description
		DestroyScreenElement id=current_goal_description
	endif

	// stop the start stream if it's still going
	// GoalManager_StopCurrentStream name=<goal_id>
	;if IsAlive name=<trigger_obj_id>
	;	<trigger_obj_id>:Obj_StopStream
	;endif

	// reset trigger anims
	if not GotParam quick_start

		// reset the tod
		if GameModeEquals is_career
			goal_get_chapter_stage_from_id id=<goal_id>
			GoalManager_GetCurrentChapterAndStage
			<level> = ((CHAPTER_LEVELS[<currentChapter>]).checksum)
			;printstruct<...>

			if LevelIs <level>
				if GotParam stage

					tod_req_action=((STAGE_TOD_SETTINGS[<currentChapter>])[<currentStage>])
					tod_cur_action=((STAGE_TOD_SETTINGS[<chapter>])[<stage>])

					if not (<tod_cur_action> = <tod_req_action>)
						script_change_tod tod_action=<tod_req_action>
					endif
				else

					tod_req_action=((STAGE_TOD_SETTINGS[<currentChapter>])[<currentStage>])
					tod_cur_action=cur_tod_cur_action

					if not (<tod_cur_action> = <tod_req_action>)
						script_change_tod tod_action=<tod_req_action>
					endif
				endif
			endif
		endif

		if not GotParam just_won_goal
			; if GotParam current_trigger_script
			; 	KillSpawnedScript id=<current_trigger_script>
			; endif
			goal_pro_stop_anim_scripts <...>
			if GotParam trigger_wait_script
				; RunScriptOnObject id=<trigger_obj_id> <trigger_wait_script> params={ goal_id=<goal_id> pro=<pro> }
				<trigger_obj_id>:Obj_SpawnScript <trigger_wait_script> params={ goal_id=<goal_id> pro=<pro> }
			else
				; RunScriptOnObject id=<trigger_obj_id> GenericProWaiting params={ goal_id=<goal_id> type="wait" pro=<pro> }
				<trigger_obj_id>:Obj_SpawnScript GenericProWaiting params={ goal_id=<goal_id> type="wait" pro=<pro> }
			endif
			; GoalManager_EditGoal name=<goal_id> params={ current_trigger_script=<UniqueID> }
		endif
	endif

	// check if we need to get them out of a vehicle...
	if GotParam control_type
		; printf "moving skater to new OnGroundAI type"
		if not ( ( <control_type> = Skate ) || ( <control_type> = Walk ) || ( <control_type> = WalkOnly ))
			if GotParam exit_node
				ResetSkaters node_name=<exit_node>
			else
				ResetSkaters node_name=<restart_node>
			endif
			MakeSkaterGoto HandBrake

			// resetting the skater will unpause him
			if GameIsPaused
				Skater:Pause
			endif

			// if its a created vehicle goal, run the appropriate level cleanup script
			if GotParam edited_goal
				GoalManager_GetLevelPrefix
				FormatText ChecksumName=ReadyLevelScript "%l_CreateVehicles" l=<level_prefix>
				if ScriptExists <ReadyLevelScript>
					<ReadyLevelScript>
				endif
			endif
		endif

		if ( <control_type> = WalkOnly )
			Skater:ReturnBoardToSkater
		endif
	endif

	// kill the geo
	if GotParam geo_prefix
		goal_kill_geo_prefix geo_prefix=<geo_prefix>
	else
		if GotParam geo_prefixes
			GetArraySize <geo_prefixes>
			<index> = 0
			begin
				goal_kill_geo_prefix geo_prefix=( <geo_prefixes>[<index>] )
				<index> = ( <index> + 1 )
			repeat <array_size>
		endif
	endif
	if GotParam trigger_prefix
		kill prefix=<trigger_prefix>
	endif

	if not GotParam quick_start
		// show ped
		<trigger_obj_id>:Obj_Visible

		// change current_goal message
		GoalManager_ShowGoalPoints

		if not IsTrue ALWAYSPLAYMUSIC
			if not GoalManager_HasWonGoal name=<goal_id>
				PauseMusic 1
			endif
		endif
	endif 	// if not GotParam quick_start

	// recreate arrow if necessary
	if not GotParam just_won_goal
		if not GotParam quick_start
			if not GoalManager_HasWonGoal name=<goal_id>
				goal_add_ped_arrow goal_id=<goal_id>
			endif
		endif
	endif

	if GoalManager_HasWonGoal name=<goal_id>
		if not GotParam quick_start
			if GotParam just_won_goal
				; SpawnScript goal_wait_and_kill_trigger params={ trigger_obj_id=<trigger_obj_id> }
			else
				; kill name=<trigger_obj_id>
				GoalManager_UninitializeGoal name=<goal_id>
			endif
		endif
	endif

	//if the last goal was just completed - congrats
	if GotParam just_won_goal
		GoalManager_GetNumberOfGoalPoints total
		if (<goal_points> = total_num_goals)
			//Rulon (TT13184): Make sure this message doesn't popup when attempting goal attack goals after completing all story mode goals
			if not GetGlobalFlag flag=GOT_ALL_GOALS
				SetGlobalFlag flag=GOT_ALL_GOALS
				unlock_all_cheat_codes
				unlock_all_gameplay_cheat_codes
				SpawnScript GotAllGoalsMessage
			endif
		endif
	endif
endscript

script GotAllGoalsMessage

	dialog_box_exit
	PauseGame
	create_dialog_box { title="CONGRATULATIONS!"
		title_font=testtitle
		text="Way to go back and clean out the story goals. \n\nYou've unlocked \c3new cheats\c0 to help you take it further. Access them from the Pause menu under Options. Good luck!"
		pos=(320 ,240)
		just=[center center]
		text_rgba=[88 105 112 128]
		text_dims=(330,0)
		line_spacing=.85
		buttons=[ { font=small text="OK" pad_choose_script=EndGotAllMessgaes } ]
		delay_input
		pad_focus_script=text_twitch_effect
		style=special_dialog_style
	}
endscript

script EndGotAllMessgaes
	dialog_box_exit
	UnpauseGame
endscript

// @script | SetCurrentGoal | Sets the current goal number to the one specified
script SetCurrentGoal
	Obj_VarSet var=0 value=<value>
endscript


script goal_retry_select_handler
	if ( goal_bind_retry_to_select = 1 )
		if GoalManager_CanStartGoal
			RetryCurrentGoal
		endif
	endif
endscript

// @script | RetryCurrentGoal | Called from the menu.  Resets all of the goals
// and repositions the skater.
script RetryCurrentGoal
	; wait 1 frame
	if GoalManager_CanRetryGoal
		// check for any required tricks
		if GoalManager_GetLastGoalId
			if InNetGame
				if GoalManager_HasWonGoal name=<goal_id>
					return
				endif
			endif

			goal_check_for_required_tricks goal_id=<goal_id>

			if ( <found_unmapped_trick> = 1 )
				return
			endif
		endif

		; GoalManager_DeactivateAllGoals
		GoalManager_RestartLastGoal
	else
		; create_panel_message id=goal_message text="No Goal to retry" style=panel_message_goal
	endif
endscript

script goal_restart_stage
	GoalManager_RestartStage
endscript


// @script | end_current_goal_run | called from the pause menu.  Kills the current goal,
// but leaves the skater in place
script end_current_goal_run
	wait 1 gameframe
	if ObjectExists id=goal_message
		RunScriptOnScreenElement id=goal_message kill_panel_message
	endif

	// kill the current goal
	if GoalManager_HasActiveGoals
		; printf "deactivating current goal"
		GoalManager_DeactivateCurrentGoal
	endif
endscript

script ready_skater_for_early_end_current_goal
	// TT12697.  At the end of net goals, skaters are teleporting to restart nodes for no good reason.  This ready_skater_for_early_end_current_goal is
	// here only to reset skaters if a player exits a goal via the menu during an end of run.  The ResetSkaters prevent's the skater's script state from
	// being hosed by there being no reset after an end of run.
	if InNetGame
		// don't return for the internal goals of a goal attack game
		if GotParam Net
			return
		endif
	endif

	if InSplitScreenGame
		return
	endif

	if IsObserving
		return
	endif

	// Dan: Final sanity check for those border cases.
	if not ObjectExists Id=Skater
		return
	endif

	if Skater:IsInEndOfRun
		// Dan: If we're ending a goal in the middle of an end of run, we need to reset the skater.  End of runs hose the skater's script state by their
		// very nature, so the skater always needs to be reset after an end of run.
		ResetSkaters node_name=<restart_node>
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// global array of cam anim angles
goal_cam_anim_offsets = [
	{ targetOffset=(0.0, 46.8, 0.0) positionOffset=(9.6, 10.8, 75.6) }

	// Close up of Pro
	{ targetOffset=(1.2, 62.4, 0.0) positionOffset=(-2.4, 0.0, 26.4) }

	// Up shot of pro (He’s a giant! Shot)
	{ targetOffset=(3.6, 57.6, 0.0) positionOffset=(-7.2, -31.2, 70.8) }

	// Down shot of pro
	{ targetOffset=(8.4, 49.2, 1.2) positionOffset=(-8.4, 30, 63.6) }

	// Over the skaters right shoulder
	{ targetOffset=(-24.0, 58.8, 13.2) positionOffset=(51.6, -2.4, 91.2) }

	// Over the skaters left shoulder
	{ targetOffset=(30, 58.8, 20.4) positionOffset=(-56.4, -2.4, 85.2) }

	// Two shot left
	{ targetOffset=(30, 58.8, 20.4) positionOffset=(-56.4, -2.4, 85.2) }

	// Two shot right
	{ targetOffset=(-20.4, 43.2, 32.4) positionOffset=(100.8, 6, 63.6) }

	// Wide – would be better if used with a specific object
	// as the target. It doesn’t seem like it would be used
	// on the skater and pro talking very often
	{ targetOffset=(30, -14.4, 2.4) positionOffset=(-36.0, 148.8, 446.4) }

	// Wide right
	{ targetOffset=(12.0, -25.2, -9.6) positionOffset=(312, 159.6, 366) }

	// Wide left
	{ targetOffset=(7.2, 4.8, 21.6) positionOffset=(-420, 128.4, 129.6) }

]

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_cam_anim_play
	GoalManager_GetGoalParams name=<goal_id>

	goal_cam_anim_pre_cleanup <...>

	// *****************************************************
	// goal state specific pre cam
	if GotParam just_won_goal
		if GotParam success_cam_anim
			<anim> = <success_cam_anim>
		else
			if GotParam success_cam_anims
				<anims> = <success_cam_anims>
			else
				<virtual_cam> = virtual_cam
			endif
		endif

		goal_cam_anim_pre_success <...>
		just_won_goal=just_won_goal
	else
		if GotParam start_cam_anim
			<anim> = <start_cam_anim>
		else
			if GotParam start_cam_anims
				<anims> = <start_cam_anims>
			else
				<virtual_cam> = virtual_cam
			endif
		endif
		goal_cam_anim_pre_start <...>
	endif

	// *****************************************************
	// play anim(s)
	GetSkaterId
	<skaterId> = <objId>
	if not GotParam no_cam_anim
		if GotParam anims
			GetArraySize <anims>
			<index> = 0
			begin
				if ( <index> = ( <array_size> - 1 ) )
					<last_anim> = 1
				else
					<last_anim> = 0
				endif

				goal_cam_anim_play_single_element { ( <anims>[<index>] )
					goal_id=<goal_id>
					anim_index=<index>
					last_anim=<last_anim>
					<just_won_goal>
					cam_anim_index = <index>
				}
				<index> = ( <index> + 1 )
			repeat <array_size>
		else
			goal_cam_anim_play_single_element <...> last_anim=1 cam_anim_index=0
		endif
	endif

	goal_cam_anim_post_cleanup <...>

	// *****************************************************
	// goal state specific post cam cleanup
	if GotParam just_won_goal
		goal_cam_anim_post_success <...>
	else
		goal_cam_anim_post_start <...>
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_cam_anim_pre_cleanup
	// *****************************************************
	// generic pre cam cleanup
	GoalManager_PauseAllGoals

	GetValueFromVolume cdvol
	// don't mess with the music if they have it turned off
	if not InNetGame
		if ( <value> > 0 )
			<volume> = <value>
			SetMusicVolume 20
		endif
	endif

	// This is to prevent the skater from falling & getting letters during the intro,
	// since in a created goal the skater can be placed way up in the air.
	if GotParam edited_goal
		Skater:PausePhysics
	endif

	change check_for_unplugged_controllers = 0

	Skater:StatsManager_DeactivateGoals

	if InNetGame
		Skater:NetDisablePlayerInput
	else
		Skater:DisablePlayerInput
	endif

	GoalManager_SetCanStartGoal 0

	// force the pro to look at the skater
	if GotParam trigger_obj_id
		if IsAlive name=<trigger_obj_id>
			TerminateObjectsScripts id=<trigger_obj_id> script_name=GenericPro_LookAtSkater use_proper_version
			<trigger_obj_id>:Obj_StopRotating
			<trigger_obj_id>:Obj_LookAtObject type=skater AngleThreshold=15 speed=500 time=0
		endif
	endif

	pause_trick_text
	// hide the time
	if ScreenElementExists id=the_time
		SetScreenElementProps {
			id=the_time
			hide
		}
	endif

	// disable input (make sure to disable in this frame as well).
	SetButtonEventMappings block_menu_input
	GetSkaterId
	if InNetGame
		<ObjId>:NetDisablePlayerInput
	else
		<ObjId>:DisablePlayerInput
	endif
	kill_start_key_binding
	SpawnScript TemporarilyDisableInput
	return volume=<volume>
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_cam_anim_post_cleanup
	// *****************************************************
	// generic post cam cleanup

	change check_for_unplugged_controllers = 1

	restore_start_key_binding

	// For edited goals the skater physics is paused during the intro (to prevent the skater
	//  from falling & getting letters) so make sure he is unpaused again.
	if GotParam edited_goal
		Skater:UnPausePhysics
	endif

	if InNetGame
		Skater:NetEnablePlayerInput
	else
		Skater:EnablePlayerInput
	endif
	if not GotParam dont_unpause
		GoalManager_UnPauseAllGoals
	endif

	GoalManager_SetCanStartGoal

	//if not ( DEMO_BUILD )
	Skater:StatsManager_ActivateGoals
	//endif

	; restore_start_key_binding
	PauseMusic 0

	; SkipTrack
	if GotParam volume
		SetMusicVolume ( <volume> * 10 )
	endif

	if ObjectExists id=speech_box_anchor
		DestroyScreenElement id=speech_box_anchor
	endif

	if not Skater:Driving
		UnPauseSkaters
	endif
	unpause_trick_text
	// unhide the time
	if ScreenElementExists id=the_time
		SetScreenElementProps {
			id=the_time
			unhide
		}
	endif

	if GotParam trigger_obj_id
		if IsAlive name=<trigger_obj_id>
			; <trigger_obj_id>:Obj_StopStream
			GoalManager_StopLastStream name=<goal_id>
			GoalManager_UnloadLastFam name=<goal_id>
		endif
	endif

	// move trigger to next anim
	if GotParam next_trigger_script
		goal_pro_stop_anim_scripts <...>
		; RunScriptOnObject id=<trigger_obj_id> <next_trigger_script> params={ type=<type> goal_id=<goal_id> pro=<pro> }
		if ObjectExists id=<trigger_obj_id>
			<trigger_obj_id>:Obj_SpawnScript <next_trigger_script> params={ type=<type> goal_id=<goal_id> pro=<pro> }
		endif
		; GoalManager_EditGoal name=<goal_id> params={ current_trigger_script=<UniqueID> }
	endif

	restore_start_key_binding
	FireEvent type=goal_cam_anim_done

	if GotParam show_movie
		// show movie if beat pro challenge
		if ( <show_movie> = 1 )
			if GotParam movie_file
				ingame_play_movie <movie_file>
			endif
		endif
	endif
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_cam_anim_pre_success
	if Not InMultiplayerGame
		// disable input (make sure to disable in this frame as well).
		SetButtonEventMappings block_menu_input
		GetSkaterId
		<ObjId>:DisablePlayerInput
		SetScreenElementProps {
			id=root_window
			event_handlers=[ { pad_start		nullscript } ]
			replace_handlers
		}
		SpawnScript TemporarilyDisableInput

		// TODO: This assumes all skaters...needs to use the skater id
		PauseSkaters
	endif

	Skater:Obj_SetFlag FLAG_SKATER_INGOALINIT
	if GotParam success_node
		ResetSkaters node_name=<success_node>
	endif
	PauseSkaters
	if not GotParam dont_hide_skater
		Skater:RemoveSkaterFromWorld
	endif

	if GotParam success_movie_wait_frames
		wait <success_movie_wait_frames> gameframe
	endif

	// Set this to let the controller pulled logic know that we're in
	// a success movie.  This needs to be set outside the if block because
	// you won't always get rewards.
	root_window:SetTags giving_rewards = 1
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_cam_anim_mid_success
	GoalManager_GetGoalParams name=<goal_id>

	create_speech_box {
		text="Press \m0 to continue"
		pad_choose_script=goal_description_and_speech_continue
		pad_choose_params={ no_pad_start anim=<anim> }
		; no_pad_start
	}
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_cam_anim_post_success
	; printf "goal_cam_anim_post_success"
	Skater:Obj_ClearFlag FLAG_SKATER_INGOALINIT
	if not GotParam dont_hide_skater
		Skater:AddSkaterToWorld
	endif

	// give them input
	KillSpawnedScript name=TemporarilyDisableInput
	SetButtonEventMappings unblock_menu_input
	<ObjId>:EnablePlayerInput

	// we are done with the success movie.
	root_window:SetTags giving_rewards = 0

	if not GotParam dont_kill_messages
		KillSpawnedScript name=goal_success_messages
		if ScreenElementExists id=goal_complete_sprite
			DestroyScreenElement id=goal_complete_sprite
		endif
		if ScreenElementExists id=goal_complete
			DestroyScreenElement id=goal_complete
		endif
		if ScreenElementExists id=goal_complete_line2
			DestroyScreenElement id=goal_complete_line2
		endif
		if ScreenElementExists id=goal_new_record
			DestroyScreenElement id=goal_new_record
		endif
		if ScreenElementExists id=goal_current_reward
			DestroyScreenElement id=goal_current_reward
		endif
	endif

	// Give the player a window within which to pause the game and
	// choose to view the replay after beating a goal.
	; SpawnScript PauseThenStartRecording

	goal_uninit goal_id=<goal_id>

	// custom success script
	if GotParam goal_success_script
		<goal_success_script> <goal_success_params>
	endif

	// did they just beat all the goals?
	GoalManager_GetNumberOfGoalPoints total
	if ( <goal_points> = 129 )
		if not GetGlobalFlag flag=GOT_ALL_GOALS
			;SpawnScript show_all_goals_done_dlg
		endif
	endif

	// move forward through the chapters
	; goal_check_chapter_flags
	GoalManager_GetCurrentChapterAndStage
	if GoalManager_AdvanceStage	; just_won_goal_id=<goal_id>
		kill_start_key_binding

		if ControllerBoundToSkater controller=0 skater=0
			VibrateController port=0 actuator=0 percent=0
			VibrateController port=0 actuator=1 percent=0
		endif
		if ControllerBoundToSkater controller=1 skater=0
			VibrateController port=1 actuator=0 percent=0
			VibrateController port=1 actuator=1 percent=0
		endif
		if ( ( IsXbox ) || ( IsNGC ) )
			if ControllerBoundToSkater controller=2 skater=0
				VibrateController port=2 actuator=0 percent=0
				VibrateController port=2 actuator=1 percent=0
			endif
			if ControllerBoundToSkater controller=3 skater=0
				VibrateController port=3 actuator=0 percent=0
				VibrateController port=3 actuator=1 percent=0
			endif
		endif

		<stage_struct> = ( ( CHAPTER_COMPLETION_SCRIPTS[<currentChapter>] )[<currentStage>] )
		if StructureContains structure=<stage_struct> script_name
			<stage_script> = ( <stage_struct>.script_name )
		endif
		if StructureContains structure=<stage_struct> params
			<stage_script_params> = ( <stage_struct>.params )
		endif
		; goal_cam_anim_post_cleanup <...>
		; goal_cam_anim_post_success dont_kill_messages <...>
		SpawnScript <stage_script> params={ <stage_script_params> just_won_goal }

		// Only unlock the next chapter if the stage just completed was the final one
		;calculate_chapter_goals_to_continue
		;if ( <goals_to_continue> > 0 )
		GetArraySize CHAPTER_NUM_GOALS_TO_COMPLETE index1=<currentChapter>
		if (<currentStage> = (<array_size>-1)) //last stage in chapter
			goal_mark_chapter_complete currentChapter=<currentChapter>
		endif

		; printf "you just moved up a stage"
		; printf "we're in chapter %c, stage %s" c=<currentChapter> s=<currentStage>
	else
		goal_get_chapter_stage_from_id id=<goal_id>
		if ( ( GotParam chapter ) && ( GotParam stage ) )
			if ( ( <chapter> = 25 ) && ( <stage> = 0 ) )
				GoalManager_GetCurrentChapterAndStage
				if ( ( <currentChapter> = 25 ) && ( <currentStage> = 0 ) )
					DisplayLoadingScreen blank
					kill_start_key_binding
					select_sponsor_post_movies_cleanup

					// destroy skateshop menus
					if ScreenElementExists id=current_menu_anchor
						DestroyScreenElement id=current_menu_anchor
					endif
					// show chapter menu
					restore_skater_camera
					launch_chapter_menu
					HideLoadingScreen
				endif
			endif
		endif
	endif

	// special case for cat goal
	if GotParam create_a_trick
		goal_cat_create_menu goal_id=<goal_id>
	endif
endscript

script goal_mark_chapter_complete
	<status_array> = CHAPTER_STATUS
	SetArrayElement ArrayName=status_array Index=<currentChapter> NewValue=2
	GetArraySize <status_array>
	if ( <currentChapter> < ( <array_size> - 1 ) )
		SetArrayElement ArrayName=status_array Index=( <currentChapter> + 1 ) NewValue=1
	endif
endscript

script goal_stage_script_done
	restore_start_key_binding
endscript

script show_all_goals_done_dlg
	wait 2 seconds

	PauseGame

	SetGlobalFlag flag=GOT_ALL_GOALS
	goal_got_all_goals
	WaitForEvent type=goal_got_all_goals_done

	UnPauseGame

	KillSpawnedScript name=show_all_goals_done_dlg
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_cam_anim_pre_start
	; printf "goal_cam_anim_pre_start"
	MakeSkaterGoto Skater_GoalInit
	; PauseMusic 1

	KillSpawnedScript name=goal_description_and_speech
	KillSpawnedScript name=goal_description_and_speech2
	; SpawnScript goal_description_and_speech params=<...>

	; wait 1 gameframe
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_cam_anim_post_start
	if not GoalManager_GoalIsActive name=<goal_id>
		FireEvent type=goal_cam_anim_post_start_done
		return
	endif

	if GotParam use_hud_counter
		goal_create_counter goal_id=<goal_id> hud_counter_caption=<hud_counter_caption>
	endif

	goal_initialize_skater <...>

	if GotParam goal_start_script
		<goal_start_script> <goal_start_script_params>
	endif

	if GotParam hide_goal_pro
		<trigger_obj_id>:Obj_Invisible
	endif

	DeBounce X Time=0.3
	FireEvent type=goal_cam_anim_post_start_done
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script hide_loading_screen
	// used to restore game after the 1-frame glitch fix
	HideLoadingScreen
endscript

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_cam_anim_play_single_element
	; printf "goal_cam_anim_play_single_element"
	GoalManager_GetGoalParams name=<goal_id>

	GetSkaterId
	<skaterId> = <objId>

	if GotParam pre_anim_script
		<pre_anim_script> <pre_anim_script_params>
	endif

	if GotParam skater_node
		ResetSkaters node_name=<skater_node>
	endif

	if GotParam walk_into_frame
		if not GotParam walk_into_frame_distance
			<walk_into_frame_distance> = 120
		endif
		MakeskaterGoto skater_goalinit params={ Walk walk_distance=<walk_into_frame_distance> }
	endif

	if GotParam ped_node
		if GotParam trigger_obj_id
			<trigger_obj_id>:Obj_MoveToNode name=<ped_node> orient
		endif
	endif

	// force the pro to look at the skater
	if GotParam trigger_obj_id
		if IsAlive name=<trigger_obj_id>
			<trigger_obj_id>:Obj_StopRotating
			<trigger_obj_id>:Obj_LookAtObject type=skater AngleThreshold=15 speed=50600 time=0
		endif
	endif

	if GotParam ped_script
		if GotParam trigger_obj_id
			goal_pro_stop_anim_scripts <...>
			; RunScriptOnObject id=<trigger_obj_id> <ped_script> params={ goal_id=<goal_id> }
			<trigger_obj_id>:Obj_SpawnScript <ped_script> params={ goal_id=<goal_id> }
			; GoalManager_EditGoal name=<goal_id> params={ current_trigger_script=<UniqueID> }
		endif
	endif

	// setup params
	if not GotParam no_play_hold
		// tricky flags
		<play_hold> = play_hold
	endif

	if not GotParam skippable
		<skippable> = 1
	endif

	// make sure they can't skip the last movie
	if ( <last_anim> = 1 )
		if not GotParam just_won_goal
			<skippable> = 0
		endif
		<play_hold> = play_hold
	endif

	if GotParam virtual_cam
		// tricky flags
		<anim> = <goal_id>
		<virtual_cam> = virtual_cam

		// defaults
		if not GotParam targetId
			<trigger_obj_id>:Obj_GetID
			<targetId> = <objId>
		endif

		// get random cam angle if a target and position offset aren't specified
		if not ( ( GotParam targetOffset ) && ( GotParam positionOffset ) )
			GetRandomArrayElement goal_cam_anim_offsets
			<targetOffset> = ( <element>.targetOffset )
			<positionOffset> = ( <element>.positionOffset )
			; <targetOffset> = (0, 47, 0)
		endif

		if not GotParam frames
			<frames> = 120
		endif
	else
		if not GotParam anim
			printstruct <...>
			script_assert "No anim specified and no virtual_cam flag present"
		endif
	endif

	DisplayLoadingScreen freeze

	PlaySkaterCamAnim { name=<anim>
		skaterId=<skaterID>
		targetID=<targetId>
		targetOffset=<targetOffset>
		positionOffset=<positionOffset>
		frames=<frames>
		<play_hold>
		skippable=<skippable>
		<virtual_cam>
	}

	DeBounce X time=0.3

	// spawn goal_description scripts if needed
	if GotParam null_goal
		// ugh...
		if ( <last_anim> = 1 )
			<cam_anim_index> = -2
		endif
		<last_anim> = 0
		<skippable> = 1
	endif

	if ( ( GotParam edited_goal ) & ( GotParam just_won_goal ) )
		// ugh2...
		<last_anim>=0
		<skippable>=1
	endif

	<should_use_cam_anim_text> = 1
	if ( <last_anim> = 1 )
		if not GotParam just_won_goal
			<should_use_cam_anim_text> = 0
		endif
	endif

	if ( <should_use_cam_anim_text> = 0 )
		SpawnScript goal_description_and_speech params=<...>
	else
		if GotParam cam_anim_text
			if ( ( GotParam trigger_obj_id ) || ( GotParam speaker_obj_id ) )
				if GotParam just_won_goal
					GoalManager_PlayGoalWinStream {
						name=<goal_id>
						speaker_obj_id=<speaker_obj_id>
						speaker_name=<speaker_name>
						cam_anim_index=( <cam_anim_index> + 1 )
					}
				else
					GoalManager_PlayGoalStartStream {
						name=<goal_id>
						speaker_obj_id=<speaker_obj_id>
						speaker_name=<speaker_name>
						cam_anim_index=( <cam_anim_index> + 1 )
					}
				endif
			endif
		endif

		// check for anim specific speech text
		if GotParam cam_anim_text
			// build the display text, including speaker name and
			// continue prompt if appropriate
			<display_cam_anim_text> = ""
			if GotParam cam_anim_speaker_name
				FormatText TextName=display_cam_anim_text "\\ca%s :\\c0\\n" s=<cam_anim_speaker_name>
			else
				if GotParam full_name
					FormatText TextName=display_cam_anim_text "\\ca%s :\\c0\\n" s=<full_name>
				else
					if GotParam pro
						FormatText ChecksumName=pro_checksum "%s" s=<pro>
						if StructureContains structure=goal_pro_last_names <pro_checksum>
							<pro_last_name> = ( goal_pro_last_names.<pro_checksum> )
							FormatText TextName=pro_name_text "\\ca%s %l :\\c0\\n" s=<pro> l=<pro_last_name>
						endif
					endif
				endif
			endif

			// build single string from array of strings
			if IsArray <cam_anim_text>
				GetArraySize <cam_anim_text>
				<index> = 0
				begin
					FormatText TextName=display_cam_anim_text "%s%n" s=<display_cam_anim_text> n=( <cam_anim_text>[<index>] )
					<index> = ( <index> + 1 )
				repeat <array_size>
			else
				FormatText TextName=display_cam_anim_text "%s%n" s=<display_cam_anim_text> n=<cam_anim_text>
			endif

			// are they allowed to skip?
			if not ( <skippable> = 0 )
				// this seems backward, but if there's a text box, we want the text
				// box to handle the skipping.  So we set the cam anim unskippable,
				// and add a handler to the box that will kill the anim.  This way
				// the box can animate in before they're allowed to skip
				SetSkaterCamAnimSkippable skaterId=<skaterId> name=<anim> skippable=0

				FormatText TextName=display_cam_anim_text "%s\nPress \m0 to continue." s=<display_cam_anim_text>
				<pad_choose_script> = goal_description_and_speech_continue
				<pad_choose_params> = { no_pad_start anim=<anim> skippable=<skippable> }
			endif

			if ScreenElementExists id=speech_box_anchor
				DestroyScreenElement id=speech_box_anchor
			endif

			kill_start_key_binding
			create_speech_box {
				; no_pad_start
				anchor_id=goal_description_anchor
				text=<display_cam_anim_text>
				pos=<text_anchor_pos>
				style=speech_box_style
				bg_x_scale=1.3
				pad_choose_script=<pad_choose_script>
				pad_choose_params=<pad_choose_params>
			}
		else
			<pad_choose_script> = goal_description_and_speech_continue
			<pad_choose_params> = { no_pad_start anim=<anim> skippable=<skippable> }
			create_speech_box {
				; no_pad_start
				anchor_id=goal_description_anchor
				text="Press \m0 to continue."
				pos=<text_anchor_pos>
				style=speech_box_style
				bg_x_scale=1.3
				pad_choose_script=<pad_choose_script>
				pad_choose_params=<pad_choose_params>
			}
		endif
	endif

	begin
		if SkaterCamAnimFinished skaterId=<skaterId> name=<anim>
			; printf "skater cam %s finished"	s=<anim>
			if ScreenElementExists id=goal_description_anchor
				DestroyScreenElement id=goal_description_anchor
			endif

			GoalManager_StopLastStream name=<goal_id>
			/*if GotParam speaker_obj_id
				if not ( <speaker_obj_id> = skater )
					if IsAlive name=<speaker_obj_id>
						<speaker_obj_id>:Obj_StopStream
					endif
				else
					skater:Obj_StopStream
				endif
			endif
			if GotParam trigger_obj_id
				<trigger_obj_id>:Obj_StopStream
			endif*/

			GoalManager_UnloadLastFam name=<goal_id>

			DeBounce X time=.3
			break
		endif
		wait 1 gameframe
	repeat

	if GotParam post_anim_script
		<post_anim_script> goal_id=<goal_id> <post_anim_script_params>
	endif

	// GJ FIX FOR SK5:TT13229:
	// "fix to goal_utilities made goal intro cutscenes skip 2nd camera"
	// the following 'wait 1 gameframe' is needed so that X-button
	// presses don't skip 2 cameras in a row, but also causes a one
	// frame glitch between skatercams...  to fix, need to
	// freeze the screen again...  (ideally, we would change the
	// skipping code to fix, but it's too late to retest it all on THPS5)
	DisplayLoadingScreen freeze

	wait 1 gameframe

	// ... and restore it afterwards
	HideLoadingScreen
endscript


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

script goal_initialize_skater
	if not GotParam control_type
		NonVehicleControlType=1
	else
		if ( ( <control_type> = Skate ) || ( <control_type> = Walk ) || ( <control_type> = WalkOnly ) )
			NonVehicleControlType=1
		endif
	endif

	if GotParam NonVehicleControlType
		switch <control_type>
			case WalkOnly
				Skater:TakeBoardFromSkater
				ResetSkaters node_name=<restart_node> RestartWalking

			case Walk
				ResetSkaters node_name=<restart_node> RestartWalking

			case Skate
				ResetSkaters node_name=<restart_node>
				if GotParam start_skater_standing
					MakeSkaterGoto HandBrake
				endif

			default
				ResetSkaters node_name=<restart_node>
				if GotParam start_skater_standing
					MakeSkaterGoto HandBrake
				endif
		endswitch
	else
		GetVehicleSetup control_type=<control_type>
		if not GotParam Exitable
			if GotParam edited_goal
				MakeskaterGoto Switch_OnGroundAI Params={ NewScript=TransAm VehicleSetup=<VehicleSetup> edited_goal }
			else
				MakeskaterGoto Switch_OnGroundAI Params={ NewScript=TransAm VehicleSetup=<VehicleSetup> }
			endif
		else
			if GotParam edited_goal
				MakeskaterGoto Switch_OnGroundAI Params={ NewScript=TransAm VehicleSetup=<VehicleSetup> Exitable edited_goal }
			else
				MakeskaterGoto Switch_OnGroundAI Params={ NewScript=TransAm VehicleSetup=<VehicleSetup> Exitable }
			endif
		endif
		PlayerVehicle:Vehicle_MoveToRestart <restart_node>
		PlayerVehicleCamera:VehicleCamera_Reset
		SetActiveCamera Id=PlayerVehicleCamera

		// retarded CAGs might have their restart node a thousand feet in the air
		if GotParam edited_goal
			PlayerVehicle:Vehicle_Wake
		endif

		if GotParam goal_id
			GoalManager_SetEndRunType Name=<goal_id> None
		endif
	endif
endscript

// This is used to give the player a window within which to pause the game and
// choose to view the replay after beating a goal. This prevents the end of the replay
// having a second or two of normal skating at the end.
script PauseThenStartRecording
	; wait 2 seconds
	; StartRecordingAfresh
endscript

// @script | TemporarilyDisableInput | this script will
// wait the specified time and the enable player input.  It's
// used to ensure that players don't accidentally skip movies
// @parmopt int | time | 500 | amount of time to wait in milliseconds
script TemporarilyDisableInput time=1500
	SetButtonEventMappings block_menu_input
	; GetSkaterId
	; <ObjId>:DisablePlayerInput
	wait <time>
	SetButtonEventMappings unblock_menu_input
	; <ObjId>:EnablePlayerInput
endscript

script goal_wait_and_show_key_combo_text
	WaitForEvent type=panel_message_goal_done2

	SetScreenElementLock id=current_goal on
	SetScreenElementLock id=current_goal off
	SetScreenElementLock id=root_window off

	GetScreenElementPosition id=current_goal
	// offset
	<ScreenElementPos> = ( <ScreenElementPos> + (120, 0) )
	GetScreenElementDims id=current_goal

	if ScreenElementExists id=current_goal_key_combo_text
		DestroyScreenElement id=current_goal_key_combo_text
	endif

	CreateScreenElement {
		type=TextBlockElement
		parent=root_window
		id=current_goal_key_combo_text

		dims=(300, 0)
		allow_expansion
		z_priority=-5
		font=small
		scale=1
		rgba=[128 128 128 110]
		text=<text>
		; text="fggf gfdgf gf dgf fg dg gfdgfd gdgfdgf dgfd gfd"
		pos = ( <ScreenElementPos> + ( (0, 1) * <height> / .78 ) )
		; pos=( (120, 0) + ( (0, 1) * <height> / .78 ) )
		just=[center top]
		internal_just=[center top]
		scale=.75
	}
endscript

script hide_key_combo_text
	if ObjectExists id=current_goal_key_combo_text
		DoScreenElementMorph id=current_goal_key_combo_text time=0 scale=0
	endif
endscript

script unhide_key_combo_text
	if ObjectExists id=current_goal_key_combo_text
		DoScreenElementMorph id=current_goal_key_combo_text time=0 scale=0.75
	endif
endscript

script goal_description_and_speech
	; printf "goal_description_and_speech"
	GoalManager_GetGoalParams name=<goal_id>
	if ScreenElementExists id=current_goal
		DestroyScreenElement id=current_goal
	endif
	if ScreenElementExists id=current_goal_key_combo_text
		DestroyScreenElement id=current_Goal_key_combo_text
	endif

	if not GotParam null_goal
		SpawnScript goal_wait_for_cam_anim params=<...>
	endif

	// prepend the pro name
	<pro_name_text> = ""
	if GotParam cam_anim_speaker_name
		FormatText TextName=pro_name_text "\\ca%s :\\c0\\n" s=<cam_anim_speaker_name>
	else
		if GotParam full_name
			FormatText TextName=pro_name_text "\\ca%s :\\c0\\n" s=<full_name>
		else
			if GotParam pro
				FormatText ChecksumName=pro_checksum "%s" s=<pro>
				if StructureContains structure=goal_pro_last_names <pro_checksum>
					<pro_last_name> = ( goal_pro_last_names.<pro_checksum> )
					FormatText TextName=pro_name_text "\\ca%s %l :\\c0\\n" s=<pro> l=<pro_last_name>
				endif
			endif
		endif
	endif

	// build the new goal description
	if GotParam goal_description
		if IsArray <goal_description>
			GetArraySize <goal_description>
			<index> = 0
			begin
				FormatText TextName=pro_name_text "%s%n" s=<pro_name_text> n=( <goal_description>[<index>] )
				<index> = ( <index> + 1 )
			repeat <array_size>
		else
			FormatText TextName=pro_name_text "%s%n" s=<pro_name_text> n=<goal_description>
		endif

		FormatText TextName=pro_name_text "%s\nPress \m0 to continue." s=<pro_name_text>
	endif

	if not GotParam just_won_goal
		if GotParam goal_description
			GetSkaterId
			if not SkaterCamAnimFinished skaterId=<ObjId> name=<anim>
				if ObjectExists id=speech_box_anchor
					DestroyScreenElement id=speech_box_anchor
				endif
				create_speech_box {
					; no_pad_start
					anchor_id=goal_description_anchor
					text=<pro_name_text>
					pos=<text_anchor_pos>
					style=speech_box_style
					bg_x_scale=1.3
					pad_choose_script=goal_description_and_speech_continue
					pad_choose_params={ no_pad_start anim=<anim> skippable=0 }
				}
				goal_description_anchor:SetTags anim=<anim>

				AssignAlias id=goal_description_anchor alias=current_goal_description

				wait 60 frame
				// check the cam anim again, in case they skipped it by now
				if not SkaterCamAnimFinished skaterId=<ObjId> name=<anim>
					GoalManager_PlayGoalStartStream {
						name=<goal_id>
						speaker_obj_id=<speaker_obj_id>
						speaker_name=<speaker_name>
						; cam_anim_index=( <cam_anim_index> + 1 )
						last_anim
					}
				endif
			endif
		endif
	endif
endscript

// kills the skater cam and destroys the box
script goal_description_and_speech_continue
	; printf "goal_description_and_speech_continue"

	DeBounce X time=0.3

	<should_kill_anim> = 1
	/*	if GotParam skippable
		if not ( <skippable> = 0 )
			<should_kill_anim> = 0
		endif
	endif
*/
	if ( ( GotParam anim ) && ( <should_kill_anim> = 1 ) )
		GetSkaterId
		KillSkaterCamAnim skaterId=<ObjId> name=<anim>
	endif

	if GotParam no_pad_start
		speech_box_exit anchor_id=goal_description_anchor no_pad_start
	else
		speech_box_exit anchor_id=goal_description_anchor
	endif
	FireEvent type=goal_description_and_speech_continue
	; UnPauseGame
endscript

script goal_wait_for_cam_anim
	GetSkaterId
	begin
		if SkaterCamAnimFinished skaterId=<ObjId> name=<anim>
			// create on screen message
			spawnscript goal_show_tips params={ goal_id=<goal_id> }

			if not GotParam dont_show_goal_text
				create_panel_block id=current_goal text=<goal_text> style=panel_message_goal params=<...>

				if GotParam key_combo_text
					SpawnScript goal_wait_and_show_key_combo_text params={ text=<key_combo_text> }
				endif
			endif

			break
		endif
		wait 10 one_per_frame
	repeat
endscript

script goal_description_and_speech2	blink_time=.05
	SetProps just=[center top] internal_just=[center center] rgba=[128 128 128 128]

	DoMorph pos=(320,114) scale=0
	DoMorph pos=(320,114) scale=1.2 time=.1
	DoMorph pos=(320,114) scale=.8 time=.1
	DoMorph pos=(320,114) scale=1 time=.1
	DoMorph pos=(320,114) scale=.9 time=.05
	DoMorph pos=(321,116) time=.1
	DoMorph pos=(319,113) time=.1
	DoMorph pos=(321,115) time=.1
	DoMorph pos=(318,113) time=.1
	DoMorph pos=(321,115) time=.1
	DoMorph pos=(319,113) time=.1
	DoMorph pos=(321,117) time=.1
	DoMorph pos=(319,113) time=.1


	DoMorph pos=(320,120) scale=1.25 time=.1


	SetProps internal_just=[center top] rgba=[128 128 128 110] just=[right top]
	DoMorph pos=(625,15) scale=.78 time=.05

	RunScriptOnScreenElement id=current_goal blink_current_goal params={ blink_time=<blink_time> }
endscript

script blink_current_goal
	begin
		DoMorph alpha=0
		wait <blink_time> seconds
		DoMorph alpha=1
		wait <blink_time> seconds
	repeat 6
endscript

// **************************************
//      Trigger stuff
// **************************************
script GoalManager_InitGoalTrigger
	GoalManager_GetGoalParams name=<name>

	if not IsAlive name=<trigger_obj_id>
		create name=<trigger_obj_id>
	endif

	<trigger_obj_id>:SetTags goal_id=<goal_id>

	if not GotParam quick_start
		goal_add_ped_arrow goal_id=<goal_id>
	endif

	goal_pro_stop_anim_scripts <...>
	if GotParam trigger_wait_script
		; RunScriptOnObject id=<trigger_obj_id> <trigger_wait_script> params={ goal_id=<goal_id> pro=<pro> }
		<trigger_obj_id>:Obj_SpawnScript <trigger_wait_script> params={ goal_id=<goal_id> pro=<pro> }
	else
		; RunScriptOnObject id=<trigger_obj_id> GenericProWaiting params={ goal_id=<goal_id> type="wait" pro=<pro> }
		<trigger_obj_id>:Obj_SpawnScript GenericProWaiting params={ goal_id=<goal_id> type="wait" pro=<pro> }
	endif

	// store the current anim id
	; GoalManager_EditGoal name=<goal_id> params={ current_trigger_script=<UniqueID> }

	//    if GotParam start_pad_id
	//        if not ObjectExists id=<start_pad_id>
	//            create name = <start_pad_id>
	//        endif
	//    endif

	RunScriptOnObject id=<trigger_obj_id> goal_set_trigger_exceptions params={ goal_id=<goal_id> }
endscript

script goal_add_ped_arrow
	GoalManager_GetGoalParams name=<goal_id>

	if not IsAlive name=<trigger_obj_id>
		return
	endif

	if not GotParam goal_ped_arrow_height
		<goal_ped_arrow_height> = 100
	endif

	<goal_arrow_pos> = ( (0, 1, 0) * <goal_ped_arrow_height> )

	// figure the arrow model to use
	if GotParam trigger_arrow_model
		<arrow> = <trigger_arrow_model>
	else
		if GotParam always_initialize_goal
			<arrow> = "Special_Arrow"
		else
			<arrow> = "arrow"
		endif
	endif

	// kill any ped arrow
	FormatText ChecksumName=arrow_id "%s_ped_arrow" s=<goal_name>
	if ScreenElementExists id=<arrow_id>
		DestroyScreenElement id=<arrow_id>
	endif

	// make the new arrow
	SetScreenElementLock id=root_window off
	if not IsTrue no_arrows
		CreateScreenElement {
			parent=root_window
			type=Element3D
			id=<arrow_id>

			model=<arrow>
			HoverParams={ Amp=9.5 Freq=2.5 }
			AngVelY=0.16
			ParentParams={ name=<trigger_obj_id> <goal_arrow_pos> IgnoreParentsYRotation }
		}
	endif

	// remember the arrow id
	; GoalManager_EditGoal name=<goal_id> params={ ped_arrow_id=<id> }
endscript

script goal_ped_kill_arrow
	GoalManager_GetGoalParams name=<goal_id>
	FormatText ChecksumName=arrow_id "%s_ped_arrow" s=<goal_name>
	if ScreenElementExists id=<arrow_id>
		DestroyScreenElement id=<arrow_id>
	endif
endscript

script goal_set_trigger_exceptions trigger_radius=16 avoid_radius=3
	; printf "&&&&&&&&&&&&&&&&&& goal_set_trigger_exceptions"
	if ObjectExists id=goal_Start_dialog
		speech_box_exit anchor_id=goal_start_dialog
	endif
	Obj_ClearException SkaterOutOfRadius
	Obj_SetInnerRadius <trigger_radius>
	Obj_SetException ex=SkaterInRadius scr=goal_got_trigger params={ goal_id=<goal_id> }

	GoalManager_GetGoalParams name=<goal_id>
	if not GotParam dont_bounce_skater
		Obj_SetInnerAvoidRadius <avoid_radius>
		Obj_SetException ex=SkaterInAvoidRadius scr=goal_pro_bounce_skater params={ avoid_radius=<avoid_radius> goal_id=<goal_id> }
	endif
endscript

script goal_pro_bounce_skater speed=88
	; printf "goal_pro_bounce_skater"

	// make sure this isn't a non-local client
	GetSkaterId
	<skaterId> = <objId>
	if not <SkaterId>:IsLocalSkater
		return
	endif

	// bail out if we're driving
	if <SkaterId>:Driving
		return
	endif

	GetSkaterState

	Obj_ClearException SkaterInAvoidRadius
	GetTags
	SpawnScript goal_pro_wait_and_reset_avoid_exception params={ goal_id=<goal_id> trigger_obj_id=<id> }

	<should_bounce_skater> = 1
	if SkaterCurrentScorePotGreaterThan 0
		return
	endif

	if not ( <state> = Skater_OnGround )
		return
	endif

	// ignore if the ped is hidden
	if IsHidden
		return
	endif

	root_window:GetTags
	if GotParam giving_rewards
		if ( <giving_rewards> = 1 )
			return
		endif
	endif

	; GoalManager_GetGoalParams name=<goal_id>
	; RunScriptOnObject id=<trigger_obj_id> goal_pro_wait_and_reset_avoid_exception params={ goal_id=<goal_id> avoid_radius=<avoid_radius> }
	if Skater:SpeedGreaterThan 200
		if GotParam goal_id
			GoalManager_PlayGoalStream name=<goal_id> type="avoid" play_random
		endif
		return
	endif

	// don't fuck up race modes (luge, shopping cart, etc.)
	skater:GetTags
	if not ( <racemode> = none )
		return
	endif

	GetTags
	Skater:Obj_GetOrientationToObject <id>
	if ( <dotProd> < 0.0 )
		if ( <dotProd> > -.1 )
			<speed> = 500
			; MakeSkaterGoto PedKnockDown
			; return
			<heading> = 180
		else
			<heading> = 90.0
		endif
	else
		if ( <dotProd> < .1 )
			<speed> = 500
			; MakeSkaterGoto PedKnockDown
			; return
			<heading> = 180
		else
			<heading> = -90
		endif
	endif
	SkaterAvoidGoalPed heading=<heading> speed=<speed>

	if GotParam collision_exception_return_state
		goto <collision_exception_return_state>
	endif
endscript

script goal_pro_wait_and_reset_avoid_exception
	wait 20 gameframe
	; Obj_SetInnerAvoidRadius <avoid_radius>
	; <trigger_obj_id>:Obj_SetException ex=SkaterInAvoidRadius scr=goal_pro_bounce_skater params={ goal_id=<goal_id> }

	RunScriptOnObject {
		id=<trigger_obj_id>
		goal_trigger_reset_avoid_radius_exception
		params={ goal_id=<goal_id> }
	}
endscript

script goal_trigger_reset_avoid_radius_exception
	Obj_SetException ex=SkaterInAvoidRadius scr=goal_pro_bounce_skater params={ goal_id=<goal_id> }
endscript

script goal_got_trigger
	GetSkaterId
	<skaterId> = <objId>

	if GoalManager_HasWonGoal name=<goal_id>
		return
	endif

	if GoalManager_GoalIsActive name=<goal_id>
		return
	endif

	// K: This is to prevent the speech box appearing whilst in park editor edit mode.
	if CustomParkMode editing
		return
	endif

	if ObjectExists id=goal_start_dialog
		// check if we should destroy it (the should_destroy param is used in case
		// we want to easily add more conditions later).
		<should_destroy> = 0
		;if not Skater:OnGround
		;	<should_destroy> = 1
		;endif
		if <SkaterId>:IsInBail
			<should_destroy> = 1
		endif
		if SkaterCurrentScorePotGreaterThan 0
			<should_destroy> = 1
		endif
		if <SkaterId>:Driving
			<should_destroy> = 1
		endif

		if not GoalManager_CanStartGoal
			<should_destroy> = 1
		endif

		if ( <should_destroy> = 1 )
			DestroyScreenElement id=goal_start_dialog
		endif
	else
		// bail out if the pause menu is up
		if ObjectExists id=root_window
			root_window:GetTags
			if GotParam menu_state
				if ( <menu_state> = on )
					return
				endif
			endif
		endif

		if GoalManager_CanStartGoal name=<goal_id>
			<skater_ready_for_goal> = 0
			if not <SkaterId>:Driving
				if <SkaterId>:Skating
					if <SkaterId>:OnGround
						<skater_ready_for_goal> = 1
					endif
				else
					if <SkaterId>:Walk_Ground
						<skater_ready_for_goal> = 1
					endif
				endif
			endif

			if ( <skater_ready_for_goal> = 1 )
				if not <SkaterId>:IsInBail
					if not SkaterCurrentScorePotGreaterThan 0
						; Obj_ClearException SkaterInRadius
						GoalManager_GetGoalParams name=<goal_id>

						<trigger_obj_id>:Obj_SetOuterRadius 20
						<trigger_obj_id>:Obj_SetException ex=SkaterOutOfRadius scr=goal_trigger_refuse params={ goal_id=<goal_id> }

						// only quick start in net games
						if ( InNetGame )
							<quick_start_text> = "\n\m7 to quick start."
							<pad_square_script> = goal_accept_trigger
							<pad_square_params> = { goal_id=<goal_id> quick_start }
						else
							<quick_start_text> = ""
						endif

						if GotParam full_name
							FormatText TextName=accept_text "%f: \m5 to talk.%q" f=<full_name> q=<quick_start_text>
						else
							if GotParam pro
								FormatText ChecksumName=name_checksum "%s" s=<pro>
								<last_name> = ( goal_pro_last_names.<name_checksum> )
								if GotParam last_name
									FormatText TextName=accept_text "%s %l: \m5 to talk.%q" s=<pro> l=<last_name> q=<quick_start_text>
								else
									FormatText TextName=accept_text "%s: \m5 to talk.%q" s=<pro> q=<quick_start_text>
								endif
							else
								FormatText TextName=accept_text "\m5 to talk.%q" q=<quick_start_text>
							endif
						endif

						create_speech_box {
							anchor_id=goal_start_dialog
							text=<accept_text>
							no_pad_choose
							no_pad_start
							pad_circle_script=goal_accept_trigger
							pad_circle_params={ goal_id=<goal_id> }
							pad_square_script=<pad_square_script>
							pad_square_params=<pad_square_params>
							bg_rgba=[100 100 100 128]
							text_rgba=[128 128 128 128]
							font=small
							z_priority=5
						}
					endif
				endif
			endif
		endif
	endif
endscript

script goal_trigger_refuse anchor_id=goal_start_dialog
	Obj_ClearException SkaterOutOfRadius
	speech_box_exit anchor_id=<anchor_id>
	GoalManager_ResetGoalTrigger name=<goal_id>
endscript

script goal_accept_trigger
	DeBounce X time=.5
	speech_box_exit anchor_id=goal_start_dialog

	// check for any required tricks
	goal_check_for_required_tricks goal_id=<goal_id>

	if ( <found_unmapped_trick> = 1 )
		GoalManager_GetGoalParams name=<goal_id>
		if IsAlive name=<trigger_obj_id>
			<trigger_obj_id>:Obj_ClearException SkaterInRadius
		endif
		return
	endif

	if GotParam force_start
		if not GoalManager_GoalInitialized name=<goal_id>
			GoalManager_InitializeGoal name=<goal_id>
		endif
		GoalManager_ResetGoalTrigger name=<goal_id> no_new_exceptions
		if IsAlive name=<trigger_obj_id>
			<trigger_obj_id>:Obj_ClearException SkaterInRadius
		endif
		GoalManager_DeactivateAllGoals
		GoalManager_ActivateGoal name=<goal_id> <...>
		return
	endif

	if not SkaterCurrentScorePotGreaterThan 0
		if GoalManager_CanStartGoal name=<goal_id>
			GetSkaterId
			If <ObjId>:OnGround    // If the skater is on ground, start the goal
				; kill_start_key_binding
				; wait 5 frame  // wait to make sure the skater isn't starting a trick
				// make sure skater still on ground (no preloaded tricks)
				if SkaterCurrentScorePotLessThan 1
					if <ObjId>:OnGround
						GoalManager_GetGoalParams name=<goal_id>
						GoalManager_ResetGoalTrigger name=<goal_id> no_new_exceptions
						if IsAlive name=<trigger_obj_id>
							<trigger_obj_id>:Obj_ClearException SkaterInRadius
						endif
						GoalManager_DeactivateAllGoals
						if GotParam quick_start
							GoalManager_QuickStartGoal name=<goal_id>
						else
							GoalManager_ActivateGoal name=<goal_id> <...>
						endif
					else
						If Not <ObjId>:RightPressed
							If Not <ObjId>:LeftPressed
								If Not <ObjId>:UpPressed
									If Not <ObjId>:DownPressed
										GoalManager_GetGoalParams name=<goal_id>
										GoalManager_ResetGoalTrigger name=<goal_id> no_new_exceptions
										if IsAlive name=<trigger_obj_id>
											<trigger_obj_id>:Obj_ClearException SkaterInRadius
										endif
										GoalManager_DeactivateAllGoals
										if GotParam quick_start
											GoalManager_QuickStartGoal name=<goal_id>
										else
											GoalManager_ActivateGoal name=<goal_id> <...>
										endif
									endif
								endif
							endif
						endif
					endif
				endif
				; restore_start_key_binding
			else
				// Otherwise, he might be in the air and trying to do a grab
				// so don't activate the goal if any directions are being pressed
				// along with circle or square
				If Not <ObjId>:RightPressed
					If Not <ObjId>:LeftPressed
						If Not <ObjId>:UpPressed
							If Not <ObjId>:DownPressed
								GoalManager_GetGoalParams name=<goal_id>
								GoalManager_ResetGoalTrigger name=<goal_id> no_new_exceptions
								if IsAlive name=<trigger_obj_id>
									<trigger_obj_id>:Obj_ClearException SkaterInRadius
								endif
								GoalManager_DeactivateAllGoals
								if GotParam quick_start
									GoalManager_QuickStartGoal name=<goal_id>
								else
									GoalManager_ActivateGoal name=<goal_id> <...>
								endif
							endif
						endif
					endif
				endif
			endif
		endif
	endif
endscript


script GoalManager_ResetGoalTrigger
	if GotParam goal_id
		GoalManager_GetGoalParams name=<goal_id>
	else
		GoalManager_GetGoalParams name=<name>
	endif

	if IsAlive name=<trigger_obj_id>
		<trigger_obj_id>:Obj_ClearException SkaterInRadius

		if not GotParam no_new_exceptions
			if not GotParam just_won_goal
				RunScriptOnObject id=<trigger_obj_id> goal_set_trigger_exceptions params={ goal_id=<goal_id> }
			endif
		endif
	endif
endscript

// @script | goal_check_for_required_tricks | checks for any required tricks, and makes
// sure they are all mapped.
// @parm name | goal_id | the goal id
script goal_check_for_required_tricks
	<found_unmapped_trick> = 0

	GoalManager_GetGoalParams name=<goal_id>
	if GotParam required_tricks
		FormatText TextName=warning_string "You do not have all the tricks you will need to complete this goal. You will need to assign:"

		GetArraySize <required_tricks>
		<index> = 0
		begin
			if not GetKeyComboBoundToTrick trick=( <required_tricks>[<index>] )
				if not GetKeyComboBoundToTrick trick=( <required_tricks>[<index>] ) special
					// get the trick name
					<trick_name> = ( <required_tricks>[<index>] )
					<trick_params> = ( <trick_name>.params )
					<trick_string> = ( <trick_params>.name )
					if ( <found_unmapped_trick> = 0 )
						FormatText TextName=warning_string "%s\n%t" s=<warning_string> t=<trick_string>
					else
						FormatText TextName=warning_string "%s, %t" s=<warning_string> t=<trick_string>
					endif

					<found_unmapped_trick> = 1
				endif
			endif

			<index> = ( <index> + 1 )
		repeat <array_size>
	endif

	if ( <found_unmapped_trick> = 1 )
		PauseGame
		create_error_box { title="WARNING!"
			text=<warning_string>
			text_dims=(400, 0)
			bg_scale=1.2
			buttons=[ { text="Edit Tricks" pad_choose_script=goal_unmapped_tricks_box_accept }
				{ text="Skip this challenge" pad_choose_script=goal_unmapped_tricks_box_exit pad_choose_params={ goal_id=<goal_id> } }
			]
		}
	endif

	return found_unmapped_trick=<found_unmapped_trick>
endscript

script goal_unmapped_tricks_box_accept
	dialog_box_exit
	create_edit_tricks_menu
endscript

script goal_unmapped_tricks_box_exit
	GoalManager_ResetGoalTrigger name=<goal_id>

	dialog_box_exit
	UnPauseGame
endscript

// @script | goal_got_trickslot | Tell the player they got a new special trickslot
// this should only be called by the goal manager
script goal_got_trickslot
	create_panel_message {
		id=goal_current_reward
		text="You got a new special trick slot"
		style=goal_message_got_trickslot
		; params={ sound=AcquireReward }
	}
endscript

// @script | goal_got_cash | Tell the player they got some cash for beating the goal
// this should only be called by the goal manager
script goal_got_cash
	FormatText TextName=message "You got $%i!" i=<amount>
	create_panel_message {
		id=goal_current_reward
		text=<message>
		style=goal_message_got_stat
		params={ sound=cash }
	}
endscript

script goal_got_all_goals
	StopStream
	PlayStream FoundAllGaps vol=150

	// Give the player a bunch of cool stuff
	unlock_all_cheat_codes
	unlock_all_gameplay_cheat_codes
	StopStream
	PlayStream FoundAllGaps vol=150
	<text> = "Way to go back and clean out the story goals. \n\nYou've unlocked \c3new cheats\c0 to help you take it further. Access them from the Pause menu under Options. Good luck!"

	create_dialog_box { title="All Goals"
		text=<text>

		pos=(310 ,225)
		just=[center center]
		text_rgba=[88 105 112 128]
		text_dims=(400,0)

		buttons=[ { font=small text="OK" pad_choose_script=goal_got_all_goals_accept } ]
		delay_input
	}
endscript

script goal_got_all_goals_accept
	dialog_box_exit
	FireEvent type=goal_got_all_goals_done
endscript

// @script | goal_play_stream | plays the specified stream.  called from c
// by the goal manager.  Must be associated with a CPosObject to work properly
script goal_play_stream
	; printf "goal_play_stream"
	; printstruct <...>
	if GotParam streamId
		begin
			if PreLoadStreamDone <streamId>
				; printf "PreloadStreamDone"
				break
			endif
			wait 1 frame
		repeat
	endif

	if GotParam play_anim
		AddAnimController {
			type = partialAnim
			id = jawRotation
			animName = <stream_checksum>
			from = start
			to = end
			speed = 1.0
		}
	endif

	if GotParam streamId
		StartPreloadedStream {
			streamId = <streamId>
			volume = 190
		}
	else
		Obj_PlayStream {
			<stream_checksum>
			vol=120
			dropoff=300
			use_pos_info=<use_pos_info>
		}
	endif
	/*Obj_PlayStream {
		<stream_checksum>
		vol=150
		dropoff=400
		use_pos_info=<use_pos_info>
		priority=StreamPriorityHighest
	}*/
endscript


// **************************************
//		Run once when you turn pro
// **************************************

script goal_turn_pro
	create_panel_block text="You just turned pro\n"
endscript


script goal_init_after_end_of_run
	// they may have quit the game, in which case
	// the goal won't exist any more.
	if not GoalManager_GoalExists name=<goal_id>
		return
	endif

	GoalManager_GetGoalParams name=<goal_id>
	if GotParam competition
		return
	endif
	; printf "goal_init_after_end_of_run"
	GetSkaterId
	begin
		; printf "goal_init_after_end_of_run waiting"
		if GoalManager_GoalExists name=<goal_id>
			if GoalManager_FinishedEndOfRun name=<goal_id>
				GoalManager_ClearEndRun name=<goal_id>
				if <ObjId>:Skating
					MakeSkaterGoto OnGroundAI
				endif

				if InNetGame
					<ObjId>:NetEnablePlayerInput
				else
					<ObjId>:EnablePlayerInput
				endif
				break
			endif
		else
			break
		endif
		wait 1 frame
	repeat
endscript

// custom script for exiting stats menu during goal_success
// sequence.
script goal_stats_menu_exit
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		SetScreenElementProps {
			id=root_window
			tags={ menu_state=off }
		}
		wait 1 frame
	endif
	restore_start_key_binding
	goalmanager_showpoints
	goalmanager_showgoalpoints
	FireEvent type=goal_stats_menu_done
endscript

script goal_new_level_unlocked
	Debounce X time=.3
	FormatText TextName=dialog_box_text "You have enough goal points to go to a new level."

	PlayStream UnlockLevel vol=150
	create_snazzy_dialog_box { text=<dialog_box_text>
		title="Congratulations!"
		buttons=[ { text="Change Level" pad_choose_script=goal_new_level_accept }
			{ text="Keep Playing" pad_choose_script=goal_new_level_reject }
		]
	}
endscript

script goal_new_level_accept
	dialog_box_exit
	launch_level_select_menu chose_same_level_script=goal_new_level_reject pad_back_script=goal_new_level_reject no_cam_anim
endscript

script goal_new_level_reject
	dialog_box_exit
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	SetScreenElementProps {
		id=root_window
		tags={ menu_state=off }
	}
	FireEvent type=goal_new_level_unlocked_done

endscript

script goal_want_to_save
	GetValueFromVolume cdvol
	// don't mess with the music if they have it turned off
	/*if not InNetGame
		if ( <value> > 0 )
			change goal_want_to_save_volume = <value>
			SetMusicVolume 20
		else
			change goal_want_to_save_volume = 0
		endif
	endif*/

	root_window:SetTags menu_state=on
	hide_console_window
	pause_trick_text
	destroy_goal_panel_messages
	GoalManager_SetCanStartGoal 0
	pause_rain

	Debounce X time=.3
	PauseGame
	kill_start_key_binding
	FormatText TextName=dialog_box_text "Do you want to save now?"
	create_snazzy_dialog_box { text=<dialog_box_text>
		title=""
		buttons=[ { text="Yes" pad_choose_script=goal_save_accept }
			{ text="No" pad_choose_script=goal_save_reject }
		]
		pad_back_script=goal_save_reject
	}
	AssignAlias id=dialog_box_anchor alias=current_menu_anchor
	create_helper_text generic_helper_text
endscript

script goal_save_accept
	dialog_box_exit
	kill_start_key_binding
	launch_beat_goal_save_game_sequence pad_back_script=goal_save_reject no_cam_anim
endscript

script goal_save_reject
	UnpauseGame
	GoalManager_SetCanStartGoal 1
	restore_start_key_binding
	dialog_box_exit
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	SetScreenElementProps {
		id=root_window
		tags={ menu_state=off }
	}

	; SetMusicVolume ( goal_want_to_save_volume * 10 )

	root_window:SetTags menu_state=off
	unpause_rain
	unhide_console_window
	unpause_trick_text
	FireEvent type=goal_wait_for_save
endscript


// *************************************
//		counter HUD element
// *************************************

script goal_create_counter
	SetScreenElementLock id=root_window off

	goal_destroy_counter

	// container element for counter
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=goal_counter_anchor

		dims=(640, 480)
		pos=(305, 320)
	}

	<root_pos> = (550, 90)

	FormatText ChecksumName=rgba_off "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=rgba_on "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	// number collected
	CreateScreenElement {
		type=TextElement
		parent=goal_counter_anchor
		id=goal_counter_number_collected

		font=small
		text="0"
		pos=<root_pos>
		just=[center top]
		scale=.9
		rgba=<rgba_on>
	}

	// total number
	if GoalManager_GetNumberOfFlags name=<goal_id>
		<total_number> = <number_of_flags>
	else
		// is this a counter goal?
		GoalManager_GetGoalParams name=<goal_id>
		if GotParam number
			<total_number> = <number>
		else
			// is this a find gaps goal?
			if GotParam num_gaps_to_find
				<total_number> = <num_gaps_to_find>
			else
				script_assert "Couldn't find number param.  Are the params for the hud counter setup?"
			endif
		endif
	endif
	FormatText TextName=total_number "%i" i=<total_number>
	CreateScreenElement {
		type=TextElement
		parent=goal_counter_anchor
		id=goal_counter_number_total
		rgba=<rgba_off>
		font=small
		text=<total_number>
		pos=( <root_pos> + (47, 0) )
		just=[center top]
		scale=.9
	}

	FormatText ChecksumName=bg_rgba "%i_SPEECH_BOX_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	// bg
	CreateScreenElement {
		type=SpriteElement
		parent=goal_counter_anchor
		id=mini_score_hud_box
		texture=mini_score_hud
		pos=( <root_pos> - (25, 6) )
		just=[left top]
		scale=(1.47, 1)
		rgba=<bg_rgba>

	}

	// caption
	if GotParam hud_counter_caption
		GetStackedScreenElementPos Y id=<id> offset=(48, -12)
		CreateScreenElement {
			type=TextBlockElement
			parent=goal_counter_anchor
			id=goal_counter_caption

			font=small
			text=<hud_counter_caption>
			rgba=[128 128 128 108]
			pos=<pos>
			just=[center top]
			scale=.8
			line_spacing=0.6
			dims=(117.5, 0)
			allow_expansion
		}
	endif

	goal_update_counter <...>
endscript

script goal_update_counter
	GoalManager_GetNumberCollected name=<goal_id>

	if not ScreenElementExists id=goal_counter_number_collected
		return
	endif

	FormatText TextName=new_number_collected "%i" i=<number_collected>
	SetScreenElementProps {
		id=goal_counter_number_collected
		text=<new_number_collected>
	}

	GoalManager_GetGoalParams name=<goal_id>
	if GotParam hud_counter_caption
		if ScreenElementExists id=goal_counter_caption
			SetScreenElementProps {
				id=goal_counter_caption
				text=<hud_counter_caption>
			}
		endif
	endif

	KillSpawnedScript name=mini_hud_anim
	RunScriptOnScreenElement id=goal_counter_number_collected mini_hud_anim
endscript



script goal_destroy_counter
	if ObjectExists id=goal_counter_anchor
		DestroyScreenElement id=goal_counter_anchor
	endif
endscript


script mini_hud_anim
	DoMorph time=.08 scale=0  alpha=0
	DoMorph time=.12 scale=1.3  alpha=1
	DoMorph time=.14 scale=.7
	DoMorph time=.16 scale=.9
endscript

script goal_got_flag_sound
	PlaySound GoalMidGood vol=200
endscript

// *************************************************
//			   Generic goal hud stuff
// *************************************************

// list of goal related hud elements
goal_panel_message_ids = [
	goal_complete
	goal_complete_line2
	goal_complete_sprite
	current_goal
	goal_message
	goalfail
	goalfail_sprite
	goalfailedline2
	goal_tip
	new_goal_message
	new_goal_sprite
	tetris_menu_anchor
	current_horse_spot
	goal_counter_anchor
	goal_instruction1
	goal_film_update_message
	skater_hint
	death_message
	perfect
	perfect2
	goal_current_reward

	Eric_text
]

// @script | hide_goal_panel_messages |
script hide_goal_panel_messages
	GetArraySize goal_panel_message_ids
	<index> = 0
	begin
		if not ( ( goal_panel_message_ids[<index>] )=current_goal )
			hide_panel_message id=( goal_panel_message_ids[<index>] )
		endif
		<index> = ( <index> + 1 )
	repeat <array_size>
endscript

// @script | show_goal_panel_messages |
script show_goal_panel_messages
	GetArraySize goal_panel_message_ids
	<index> = 0
	begin
		show_panel_message id=( goal_panel_message_ids[<index>] )
		<index> = ( <index> + 1 )
	repeat <array_size>

endscript

// @script | destroy_goal_panel_messages |
script destroy_goal_panel_messages
	GetArraySize goal_panel_message_ids
	if GotParam all
		<index> = 0
	else
		<index> = 3
		<array_size> = ( <array_size> - 3 )
	endif

	if ( <index> < <array_size> )
		begin
			destroy_panel_message id=( goal_panel_message_ids[<index>] )
			<index> = ( <index> + 1 )
		repeat <array_size>
	endif
endscript

// @script | GoalManager_HidePoints | hides the points and the score
// sprite
script GoalManager_HidePoints

	DoScreenElementMorph {
		id=the_score_sprite
		alpha=0
	}
	DoScreenElementMorph {
		id=the_score
		alpha=0
	}
	if ScreenElementExists id=player2_panel_container
		DoScreenElementMorph id=player2_panel_container time=0 scale=0
	endif
endscript

// @script | GoalManager_ShowPoints | shows the points and the score
// sprite
script GoalManager_ShowPoints
	// PARKED4:
	if not GetGlobalFlag flag=NO_DISPLAY_HUD
		if CustomParkMode editing
			// do nothing
		else
			DoScreenElementMorph {
				id=the_score_sprite
				alpha=1
			}
			DoScreenElementMorph {
				id=the_score
				alpha=1
			}
			if ScreenElementExists id=player2_panel_container
				DoScreenElementMorph id=player2_panel_container time=0 scale=1
			endif
		endif
	endif
endscript

// @script | GoalManager_HideGoalPoints | hides the goal points and sprite
script GoalManager_HideGoalPoints
	DoScreenElementMorph {
		id=cash_goal_sprite
		alpha=0
	}
	DoScreenElementMorph {
		id=cash_text
		alpha=0
	}
	DoScreenElementMorph {
		id=goal_points_text
		alpha=0
	}
endscript

// @script | GoalManager_ShowGoalPoints | shows the goal points and sprite
script GoalManager_ShowGoalPoints
	// PARKED4:
	if CustomParkMode editing
		// do nothing
		return
	endif

	if InMultiplayerGame
		// do nothing
		return
	endif

	if GameModeEquals is_singlesession
		return
	endif

	if GameModeEquals is_freeskate
		return
	endif

	DoScreenElementMorph {
		id=cash_goal_sprite
		alpha=1
	}

	// cash text
	GoalManager_GetCash
	FormatText TextName=cash "%i" i=<cash>
	SetScreenElementProps {
		id=cash_text
		text=<cash>
	}
	DoScreenElementMorph {
		id=cash_text
		alpha=1
	}

	// goal points text
	GoalManager_GetNumberOfGoalPoints total
	FormatText TextName=goal_points "%i" i=<goal_points>
	SetScreenElementProps {
		id=goal_points_text
		text=<goal_points>
	}
	DoScreenElementMorph {
		id=goal_points_text
		alpha=1
	}
endscript

script goal_show_tips
	WaitForEvent type=panel_message_goal_done
	goalmanager_getgoalparams name=<goal_id>
	; printstruct <...>


	<tip_pos> = (320, 140)

	if not gotparam goal_tips
		return
	endif

	if not gotparam goal_tip_interval
		goal_tip_interval = 5 //default
	endif

	GoalManager_GetNumberOfTimesGoalStarted name=<goal_id>
	GetArraySize <goal_tips>

	//avoid divide by zero
	if ( <array_size> = 0 )
		return
	endif
	; printf "times_started = %j" j=<times_started>

	tips_index = ( <array_size> - 1 )
	current_multiple = ( <goal_tip_interval> * <array_size> )

	if ( <times_started> = 0 )
		return
	endif

	//Is times_started a multiple of goal_tip_interval?
	if not( ( ( <times_started> / <goal_tip_interval> ) * <goal_tip_interval> ) = <times_started> )
		return
	endif

	//mod times_started
	times_started = ( <times_started> - ( <times_started> / <current_multiple> ) * <current_multiple> )

	begin
		if ( ( ( <times_started> / <current_multiple> ) * <current_multiple> ) = <times_started> )
			// give them a tip!
			; printf "tips_index is %i" i=<tips_index>
			create_panel_block id=goal_tip text=( <goal_tips>[<tips_index>] ) pos=<tip_pos> style=panel_message_tips just=[center top]
			break
		else
			tips_index = ( <tips_index> - 1 )
			current_multiple = ( <current_multiple> - <goal_tip_interval> )
		endif
	repeat <array_size>
endscript

// *************************************
//		unmapped keys!
// *************************************

// this only happens if the fuckers unmap too
// many tricks
script goal_no_valid_key_combos
	create_panel_message text="You don't know enough tricks!  Come back when you've learned something."
	GoalManager_DeactivateGoal name=<goal_id>
endscript

// **************************************
//      Specific goal setup scripts
// **************************************

script AddGoal_Null
	if GotParam version
		FormatText TextName=goal_type "Null%v" v=<version>
	else
		<goal_type> = "Null"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>
	GoalManager_AddGoal name=<goal_id> params={ <...> null_goal unlocked_by_another }
endscript

script AddGoal_Combo
	if GotParam version
		FormatText TextName=goal_type "Combo%v" v=<version>

		if not GotParam letter_info
			FormatText ChecksumName=c_obj_id "TRG_Goal_COMBO_C%v" v=<version>
			FormatText ChecksumName=o_obj_id "TRG_Goal_COMBO_O%v" v=<version>
			FormatText ChecksumName=m_obj_id "TRG_Goal_COMBO_M%v" v=<version>
			FormatText ChecksumName=b_obj_id "TRG_Goal_COMBO_B%v" v=<version>
			FormatText ChecksumName=o2_obj_id "TRG_Goal_COMBO_O2%v" v=<version>

			letter_info = [
				{ obj_id=<c_obj_id> text="C" }
				{ obj_id=<o_obj_id> text="O" }
				{ obj_id=<m_obj_id> text="M" }
				{ obj_id=<b_obj_id> text="B" }
				{ obj_id=<o2_obj_id> text="O" }
			]
		endif

		FormatText ChecksumName=trigger_obj_id "TRG_G_COMBO%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_COMBO%v_RestartNode" v=<version>
	else
		<goal_type> = "Combo"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_amateurCOMBOline_genericParams
			<...>
		}
	}
endscript

script AddGoal_ProCombo
	GoalManager_CreateGoalName goal_type="ProCombo"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_ProComboLine_GenericParams
			<...>
		}
	}
endscript

script AddGoal_MedCombo
	GoalManager_CreateGoalName goal_type="MedCombo"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_MedComboLine_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Skate
	if GotParam version
		FormatText TextName=goal_type "Skate%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_SKATE%v_Pro" v=<version>

		FormatText ChecksumName=s_obj_id "TRG_Goal_Letter_S%v" v=<version>
		FormatText ChecksumName=k_obj_id "TRG_Goal_Letter_K%v" v=<version>
		FormatText ChecksumName=a_obj_id "TRG_Goal_Letter_A%v" v=<version>
		FormatText ChecksumName=t_obj_id "TRG_Goal_Letter_T%v" v=<version>
		FormatText ChecksumName=e_obj_id "TRG_Goal_Letter_E%v" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_SKATE%v_RestartNode" v=<version>
	else
		<goal_type> = "Skate"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_SkateLetters_genericParams
			<...>
		}
	}
endscript

script AddGoal_HighScore
	GoalManager_CreateGoalName goal_type="HighScore"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_HighScore_GenericParams
			<...>
		}
	}
endscript


script AddGoal_GenericScore
	if GotParam version
		FormatText TextName=goal_type "GenericScore%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_GS%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_GS%v_RestartNode" v=<version>
	else
		<goal_type> = "GenericScore"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_GenericScore_GenericParams
			<...>
		}
	}
endscript

script AddGoal_ProScore
	GoalManager_CreateGoalName goal_type="ProScore"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_ProScore_GenericParams
			<...>
		}
	}
endscript

script AddGoal_SickScore
	GoalManager_CreateGoalName goal_type="SickScore"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_SickScore_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Collect
	if GotParam version
		// goal type
		FormatText TextName=goal_type "Collect%v" v=<version>

		// restart node
		FormatText ChecksumName=restart_node "TRG_G_Collect%v_RestartNode" v=<version>

		// trigger obj
		FormatText ChecksumName=trigger_obj_id "TRG_G_Collect%v_Pro" v=<version>
	else
		<goal_type> = "Collect"
	endif

	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>
	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Collect_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Collect2
	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type="Collect2"
	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Collect2_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Collect3
	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type="Collect3"
	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Collect3_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Collect4
	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type="Collect4"
	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Collect4_GenericParams
			<...>
		}
	}
endscript


script AddGoal_Collect5
	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type="Collect5"
	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Collect5_GenericParams
			<...>
		}
	}
endscript


script AddGoal_Collect6
	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type="Collect6"
	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Collect6_GenericParams
			<...>
		}
	}
endscript

script AddGoal_UntimedCollect
	if GotParam version
		// goal type
		FormatText TextName=goal_type "UntimedCollect%v" v=<version>

		// restart node
		FormatText ChecksumName=restart_node "TRG_G_UntimedCollect%v_RestartNode" v=<version>

		// trigger obj
		FormatText ChecksumName=trigger_obj_id "TRG_G_UntimedCollect%v_Pro" v=<version>
	else
		<goal_type> = "UntimedCollect"
	endif

	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>
	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_UntimedCollect_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Film
	if GotParam version
		// goal type
		FormatText TextName=goal_type "Film%v" v=<version>

		// restart node
		FormatText ChecksumName=restart_node "TRG_G_Film%v_RestartNode" v=<version>

		// trigger obj
		FormatText ChecksumName=trigger_obj_id "TRG_G_Film%v_Pro" v=<version>
	else
		<goal_type> = "Film"
	endif

	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>
	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Film_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Competition
	if GotParam version
		FormatText TextName=goal_type "Comp%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_JUDGE_COMP%v" v=<version>

		FormatText TextName=geo_prefix "G_COMP%v" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_COMP%v_RestartNode" v=<version>
	else
		<goal_type> = "Comp"
	endif

	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Comp_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Competition2
	if GotParam career_only
		if InNetGame
			return
		endif
	endif

	GoalManager_CreateGoalName goal_type="Comp2"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Comp2_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Trickspot
	if GotParam version
		FormatText TextName=goal_type "Trickspot%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_TS%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_TS%v_RestartNode" v=<version>
	else
		<goal_type> = "Trickspot"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Trickspot_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Trickspot2
	GoalManager_CreateGoalName goal_type="Trickspot2"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Trickspot2_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Trickspot3
	GoalManager_CreateGoalName goal_type="Trickspot3"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Trickspot3_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Trickspot4
	GoalManager_CreateGoalName goal_type="Trickspot4"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Trickspot4_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Trickspot5
	GoalManager_CreateGoalName goal_type="Trickspot5"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Trickspot5_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Gaps
	if GotParam version
		FormatText TextName=goal_type "GAps%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_GAP%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_GAP%v_RestartNode" v=<version>
	else
		<goal_type> = "GAps"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Gaps_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Gaps2
	GoalManager_CreateGoalName goal_type="GAps2"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Gaps2_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Gaps3
	GoalManager_CreateGoalName goal_type="GAps3"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Gaps3_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Gaps4
	GoalManager_CreateGoalName goal_type="GAps4"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Gaps4_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Gaps5
	GoalManager_CreateGoalName goal_type="GAps5"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Gaps5_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Gaps6
	GoalManager_CreateGoalName goal_type="GAps6"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Gaps6_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Race
	if GotParam version
		FormatText TextName=goal_type "RAce%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_RACE%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_RACE%v_RestartNode" v=<version>
	else
		<goal_type> = "RAce"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Race_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Race2
	GoalManager_CreateGoalName goal_type="RAce2"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Race2_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Race3
	GoalManager_CreateGoalName goal_type="RAce3"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Race3_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Race4
	GoalManager_CreateGoalName goal_type="RAce4"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Race4_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Race5
	GoalManager_CreateGoalName goal_type="RAce5"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Race5_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Race6
	GoalManager_CreateGoalName goal_type="RAce6"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Race6_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Horse
	if GotParam version
		FormatText TextName=goal_type "HOrse%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_HORSE%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_HORSE%v_RestartNode" v=<version>
	else
		<goal_type> = "HOrse"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Horse_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Horse2
	GoalManager_CreateGoalName goal_type="HOrse2"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Horse2_GenericParams
			<...>
		}
	}
endscript

script AddGoal_HighCombo
	if GotParam version
		FormatText TextName=goal_type "HIghCombo%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_HIGHCOMBO%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_HIGHCOMBO%v_RestartNode" v=<version>
	else
		<goal_type> = "HIghCombo"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_HighCombo_GenericParams
			<...>
		}
	}
endscript

script AddGoal_HighCombo2
	GoalManager_CreateGoalName goal_type="HIghCombo2"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_HighCombo2_GenericParams
			<...>
		}
	}
endscript


script AddGoal_Kill
	if GotParam version
		FormatText TextName=goal_type "KIll%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_KILL%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_KILL%v_RestartNode" v=<version>
	else
		<goal_type> = "KIll"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Kill_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Special
	if GotParam version
		FormatText TextName=goal_type "SPecial%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_SPECIAL%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_SPECIAL%v_RestartNode" v=<version>
	else
		<goal_type> = "SPecial"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Special_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Tetris
	if GotParam version
		FormatText TextName=goal_type "TEtris%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_TETRIS%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_TETRIS%v_RestartNode" v=<version>
	else
		<goal_type> = "TEtris"
	endif

	GoalManager_CreateGoalname goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Tetris_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Tetris2
	GoalManager_CreateGoalname goal_type="TEtris2"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Tetris2_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Counter
	if GotParam version
		FormatText TextName=goal_type "COunter%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_COUNTER%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_COUNTER%v_RestartNode" v=<version>
	else
		<goal_type> = "COunter"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Counter_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Counter2
	GoalManager_CreateGoalName goal_type="COunter2"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Counter2_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Counter3
	GoalManager_CreateGoalName goal_type="COunter3"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Counter3_GenericParams
			<...>
		}
	}
endscript

script AddGoal_Counter4
	GoalManager_CreateGoalName goal_type="COunter4"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_Counter4_GenericParams
			<...>
		}
	}
endscript

script AddGoal_CounterCombo
	if GotParam version
		FormatText TextName=goal_type "COunterCombo%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_COUNTERCOMBO%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_COUNTERCOMBO%v_RestartNode" v=<version>
	else
		<goal_type> = "COunterCombo"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_CounterCombo_GenericParams
			<...>
		}
	}
endscript

script AddGoal_CounterCombo2
	GoalManager_CreateGoalName goal_type="COunterCombo2"

	GoalManager_AddGoal name=<goal_id> {
		params={ Goal_CounterCombo2_GenericParams
			<...>
		}
	}
endscript

script AddGoal_SkateTheLine
	GoalManager_CreateGoalName goal_type="SKateTheLine"

	GoalManager_AddGoal name=<goal_id> {
		params={ goal_SkateTheLine_genericparams
			<...>
		}
	}
endscript

/* Dan: THUG: Not walking safe and unused, so I commented it out.  See me if you need to use it.
script AddGoal_Tour
	if GotParam version
		FormatText TextName=goal_type "Tour%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_TOUR%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_TOUR%v_RestartNode" v=<version>
	else
		<goal_type> = "Tour"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ goal_tour_GenericParams
				 <...>
			   }
	}
endscript
*/

script AddGoal_FindGaps
	if GotParam version
		FormatText TextName=goal_type "FindGaps%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_FINDGAPS%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_FINDGAPS%v_RestartNode" v=<version>
	else
		<goal_type> = "FindGaps"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ goal_findGaps_GenericParams
			<...>
		}
	}
endscript

script AddGoal_CreateATrick
	if GotParam version
		FormatText TextName=goal_type "CAT%v" v=<version>

		FormatText ChecksumName=trigger_obj_id "TRG_G_CAT%v_Pro" v=<version>

		FormatText ChecksumName=restart_node "TRG_G_CAT%v_RestartNode" v=<version>
	else
		<goal_type> = "CAT"
	endif

	GoalManager_CreateGoalName goal_type=<goal_type>

	GoalManager_AddGoal name=<goal_id> {
		params={ goal_CAT_GenericParams
			<...>
		}
	}
endscript

script AddMinigame_TimedCombo
	GoalManager_CreateGoalName goal_type="minigame_TimedCombo"

	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_TimedCombo_GenericParams
			<...>
		}
	}
endscript

script AddMinigame_Fountain
	GoalManager_CreateGoalName goal_type="minigame_fountain"
	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_fountain_genericParams
			<...>
		}
	}
endscript

script AddMinigame_Fountain2
	GoalManager_CreateGoalName goal_type="minigame_fountain2"
	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_fountain2_genericParams
			<...>
		}
	}
endscript

script AddMinigame_Height
	GoalManager_CreateGoalName goal_type="minigame_height"

	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_Height_GenericParams
			<...>
		}
	}
endscript

script AddBettingGuy
	GoalManager_CreateGoalName goal_type="betting_guy"
	GoalManager_AddGoal name=<goal_id> {
		params={ betting_guy_GenericParams
			career_only
			<...>
		}
	}
endscript

script AddMinigame_trickspot
	GoalManager_CreateGoalName goal_type="minigame_trickspot"
	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_trickspot_genericParams
			<...>
		}
	}
endscript

script AddMinigame_Timer
	GoalManager_CreateGoalName goal_type="minigame_timer"
	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_timer_GenericParams
			<...>
		}
	}
endscript

script AddMinigame_Generic
	GoalManager_CreateGoalName goal_type="minigame_generic"
	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_generic_GenericParams
			<...>
		}
	}
endscript

script AddMinigame_Generic2
	GoalManager_CreateGoalName goal_type="minigame_generic2"
	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_generic2_GenericParams
			<...>
		}
	}
endscript

script AddMinigame_Generic3
	GoalManager_CreateGoalName goal_type="minigame_generic3"
	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_generic3_GenericParams
			<...>
		}
	}
endscript

script AddMinigame_Generic4
	GoalManager_CreateGoalName goal_type="minigame_generic4"
	GoalManager_AddGoal name=<goal_id> {
		params={ minigame_generic4_GenericParams
			<...>
		}
	}
endscript

// **************************************
//      Goal Style scripts
// **************************************

script panel_message_goalfail
	SetProps just=[center bottom] rgba=[128 30 12 108]
	RunScriptOnScreenElement id=<id> panel_message_wait_and_die params={ time=1800 }
	DoMorph pos=(320,149) time=0 scale=0 alpha=0
	DoMorph pos=(320,149) scale=1.8 time=.1 alpha=1
	DoMorph pos=(320,149) scale=.9 time=.15
	DoMorph pos=(320,149) scale=1.4 time=.17
	DoMorph pos=(320,149) scale=1.2 time=.18
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=0 time=.05 scale=(10, 0) rgba=[0 0 0 128]


endscript

script panel_sprite_goalfail time=1500
	SetProps just=[center center] rgba=[128 30 12 108]
	RunScriptOnScreenElement id=<id> panel_message_wait_and_die params={time=<time>}

	DoMorph time=0 scale=0  pos=(320,114) alpha=0
	DoMorph time=.35 scale=2.5 alpha=1
	DoMorph time=.5 scale=3.5 alpha=0

	;DoMorph time=0 scale=0  pos=(320,104)
	;DoMorph time=.1 scale=2.4
	;DoMorph time=.18 scale=.6
	;DoMorph time=.16 scale=1.2
	;DoMorph time=.14 scale=.8
	;DoMorph time=.12 scale=1


endscript

script panel_message_goalfailline2 time=1500
	SetProps font=dialog just=[center center] rgba=[128 30 12 108]
	RunScriptOnScreenElement id=<id> panel_message_wait_and_die params={ time=<time> }

	DoMorph pos=(320,157) time=0  alpha=0
	DoMorph pos=(320,157) scale=8 time=.1 alpha=1
	DoMorph pos=(320,157) scale=.9 time=.15
	DoMorph pos=(320,157) scale=1.8 time=.17
	DoMorph pos=(320,157) scale=1.2 time=.18
	DoMorph pos=(320,157) scale=1.5 time=.19
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=0 time=.05 scale=(10, 0) rgba=[0 0 0 128]


	;DoMorph pos=(320,137) scale=.2 alpha=0
	;DoMorph time=.1 scale=2.4 alpha=1
	;DoMorph time=.18 scale=.6
	;DoMorph time=.16 scale=1.2
	;DoMorph time=.14 scale=.8
	;DoMorph time=.12 scale=1.0
endscript


script panel_message_goalcomplete time=1500
	GetTags
	RunScriptOnScreenElement id=<id> panel_message_wait_and_die params={ time=<time> }
	SetProps just=[center bottom] rgba=[36 125 24 128]
	DoMorph time=0 scale=0  alpha=0
	DoMorph time=.1 scale=0 alpha=0
	DoMorph pos=(320,149) time=0  alpha=0 scale=6
	DoMorph pos=(320,149) scale=6 time=.1 alpha=1
	DoMorph pos=(320,149) scale=.9 time=.15
	DoMorph pos=(320,149) scale=1.6 time=.17
	DoMorph pos=(320,149) scale=1.1 time=.18
	DoMorph pos=(320,149) scale=1.3 time=.19
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=0 time=.05 scale=(10, 0) rgba=[0 0 0 128]



	;DoMorph time=0 pos=(320,302) scale=0 alpha=0
	;DoMorph time=.15 scale=1.8 alpha=1
	;DoMorph time=.1 scale=.9
	;DoMorph time=.1 scale=1.3
	;DoMorph time=.1 scale=1.0
	;DoMorph time=.1 scale=1.1
	;DoMorph time=.1 pos=(318,300)
	;DoMorph time=.1 pos=(322,300)
	;DoMorph time=.1 pos=(320,304)
	;DoMorph time=.1 pos=(318,300)
	;DoMorph time=.1 pos=(322,300)
	;DoMorph time=.1 pos=(318,300)
	;DoMorph time=.1 pos=(322,300)
	;DoMorph time=.2 pos=(320,302) scale=0 alpha=0

	;DoMorph pos=(320,560) scale=.5 rgba=[0 0 0 40] time=.5

	;FireEvent type=panel_message_goalcomplete_done
	;wait <time>
	;die
endscript

script panel_sprite_goalcomplete time=1500
	SetProps just=[center center] rgba=[36 125 24 128]

	DoMorph time=0 scale=0  pos=(320,114) alpha=0
	DoMorph time=.1 scale=0 alpha=0
	DoMorph time=.35 scale=2.5 alpha=1
	DoMorph time=.5 scale=3.5 alpha=0



	;DoMorph pos=(0, 330) scale=0 alpha=0  time=0
	;DoMorph pos=(264,330) scale=1 alpha=1 time=.1
	;wait 1 frame
	;DoMorph pos=(258,330) time=.1
	;wait 1 frame
	;DoMorph pos=(260,330) time=.1

	;DoMorph time=.1 alpha=.4
	;DoMorph time=.1 alpha=1
	;DoMorph time=.1 alpha=.4
	;DoMorph time=.1 alpha=1
	;DoMorph time=.1 alpha=.4
	;DoMorph time=.1 alpha=1
	;DoMorph time=.1 alpha=.4
	;DoMorph time=.1 alpha=1
	;DoMorph time=.1 alpha=.4
	;DoMorph time=.1 alpha=1
	;DoMorph time=.1 alpha=.4
	;DoMorph time=.1 alpha=1
	;DoMorph time=.1 alpha=.4
	;DoMorph time=.1 alpha=1

	;DoMorph pos=(0,330) scale=.5 alpha=0 time=.2

	FireEvent type=panel_sprite_goalcomplete_done
endscript

script panel_message_goalcompleteline2 time=1500
	SetProps font=dialog just=[center center] rgba=[36 125 24 128]
	DoMorph time=0 scale=0  alpha=0
	DoMorph time=.1 scale=0 alpha=0
	DoMorph pos=(320,157) scale=6 alpha=1 time=0
	DoMorph pos=(320,157) scale=.75 alpha=1 time=.1
	wait 1 frame
	DoMorph pos=(320,157) scale=1.6 alpha=1 time=.1
	wait 1 frame
	DoMorph pos=(320,157) scale=1.3 alpha=1 time=.1
	wait 1 frame
	SetProps blur_effect
	do_blur_effect
	SetProps no_blur_effect
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph alpha=0 time=.05 scale=(10, 0) rgba=[0 0 0 128]
	;DoMorph pos=(320,700) scale=0 alpha=0 time=.2
	Die
	FireEvent type=panel_message_goalcompleteline2_done
endscript

script panel_message_new_record
	SetProps font=dialog just=[center center] rgba=[125 123 7 128]
	DoMorph time=0 pos=(320, 204) scale=0 alpha=0
	DoMorph time=.5 alpha=1

	if GotParam sound
		PlaySound <sound> vol=150
	endif

	DoMorph time=.1 scale=2.5
	DoMorph time=.1 scale=1.5
	DoMorph time=.1 scale=2.0
	DoMorph time=.1 scale=1.4
	DoMorph pos=(321,205) time=.1
	DoMorph pos=(319,203) time=.1
	DoMorph pos=(321,205) time=.1
	DoMorph pos=(319,203) time=.1
	DoMorph time=.1 scale=1.8
	DoMorph time=.15 scale=0 alpha=0

	FireEvent type=panel_message_new_record_done
	Die
endscript

script panel_message_goal blink_time=.1 final_pos=(620,27)
	if Not GotParam dont_animate
		SetProps just=[center top] internal_just=[center center] rgba=[128 128 128 128]
		DoMorph pos=(320,120) scale=0 alpha=0

		DoMorph pos=(320,120) scale=1.1 time=.3	alpha=.35
		wait .2 second
	endif

	SetProps internal_just=[center top] rgba=[128 128 128 110] just=[right top]
	DoMorph pos=<final_pos> scale=.83 time=.09 alpha=1

	FireEvent type=panel_message_goal_done
	FireEvent type=panel_message_goal_done2
endscript

script panel_message_found_secret time=1500
	SetProps /*font=dialog*/ just=[center center] rgba=[115 116 13 128]
	DoMorph pos=(320,157) scale=6 alpha=0 time=0
	DoMorph pos=(320,157) scale=.75 alpha=1 time=.1
	wait 1 frame
	DoMorph pos=(320,157) scale=1.6 alpha=1 time=.1
	wait 1 frame
	DoMorph pos=(320,157) scale=1.3 alpha=1 time=.1
	wait 1 frame
	SetProps blur_effect
	do_blur_effect
	SetProps no_blur_effect
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph time=.1 alpha=.4
	DoMorph time=.1 alpha=1
	DoMorph alpha=0 time=.05 scale=(10, 0) rgba=[0 0 0 128]
	;DoMorph pos=(320,700) scale=0 alpha=0 time=.2
	Die
	FireEvent type=panel_message_found_secret_done
endscript

script panel_message_new_goal
	SetProps font=dialog just=[center center] rgba=[128 30 12 108]
	;DoMorph pos=(320,204) scale=1 time=0
	DoMorph pos=(320,184) time=0  alpha=0
	DoMorph pos=(320,184) scale=8 time=.1
	DoMorph pos=(320,184) scale=.9 time=.15 alpha=1
	DoMorph pos=(320,184) scale=1.6 time=.17
	DoMorph pos=(320,184) scale=1.2 time=.18
	DoMorph pos=(320,184) scale=1.4 time=.19
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=.5 time=.1
	DoMorph alpha=1.0 time=.1
	DoMorph alpha=0 time=.15 scale=(15, 0) rgba=[128 128 128 128]
	Die
endscript

script panel_sprite_new_goal time=1500
	SetProps just=[center center] rgba=[128 128 128 128]
	RunScriptOnScreenElement id=<id> panel_message_wait_and_die params={time=<time>}

	DoMorph time=0 scale=0  pos=(320,190) alpha=0
	DoMorph time=.3 scale=2.5 alpha=1
	DoMorph time=.4 scale=3.5 alpha=0
	;DoMorph time=.2 scale=.8
	;DoMorph time=.3 scale=1.4
	;DoMorph time=.4 scale=.8
	;DoMorph time=.5 scale=1
	wait 2 second
	DoMorph alpha=0 time=2
endscript

script panel_message_generic_loss
	SetProps just=[center center] rgba=[128 128 128 100]
	RunScriptOnScreenElement id=<id> panel_message_wait_and_die params={ time=1500 }
	DoMorph pos=(320,185) time=0 scale=0
	DoMorph time=.3 scale=1.3
	DoMorph time=.2 scale=1.0
	DoMorph pos=(319,184) time=.1
	DoMorph pos=(321,186) time=.1
	DoMorph pos=(319,184) time=.1
	DoMorph pos=(322,186) time=.1
	DoMorph pos=(319,184) time=.1
	DoMorph pos=(321,186) time=.1
	DoMorph pos=(319,182) time=.1
	DoMorph pos=(321,186) time=.1
	DoMorph pos=(319,184) time=.1
	DoMorph pos=(321,186) time=.1
	DoMorph pos=(318,184) time=.1
	DoMorph pos=(321,187) time=.1

endscript

;script panel_message_current_goal blink_time=.05
;	SetProps dims=(450,55) rgba=[128 128 128 80] just=[right top]
;    DoMorph pos=(705,15) scale=1.3 time=1
;    DoMorph pos=(705,15) scale=.6 time=1.1
;    DoMorph pos=(705,15) scale=.8 time=1.11
;
;    begin
;        DoMorph alpha=0
;        wait <blink_time> seconds
;        DoMorph alpha=1
;        wait <blink_time> seconds
;    repeat 6
; // DoMorph pos=(690,-10) scale=.7 time=0
;endscript

script panel_message_goal_description
	SetProps rgba=[128 128 128 128] just=[center center]
	DoMorph time=0 scale=1 pos=(320,120)
endscript

script panel_message_tips blink_time=.05
	SetProps just=[center top] internal_just=[center center] rgba=[127 102 0 100]
	DoMorph scale=0
	DoMorph scale=1.2 time=.1
	DoMorph scale=.8 time=.1
	DoMorph scale=1 time=.1
	DoMorph scale=.9 time=.1
	DoMorph pos={ ( 1, 2) relative } time=.1
	DoMorph pos={ (-2,-3) relative } time=.1
	DoMorph pos={ ( 2, 2) relative } time=.1
	DoMorph pos={ (-3,-2) relative } time=.1
	DoMorph pos={ ( 3, 2) relative } time=.1
	DoMorph pos={ (-2,-2) relative } time=.1
	DoMorph pos={ ( 2, 4) relative } time=.1
	DoMorph pos={ (-2,-4) relative } time=.1


	DoMorph pos={ ( 1, 7) relative } scale=1.25 time=.1


	SetProps internal_just=[center top] rgba=[127 102 0 90] just=[right top]
	/*if objectExists id=current_goal
        GetScreenElementDims id=current_goal
        pos = ( <pos> + ((0, 1) * <height>))
	endif*/
	DoMorph pos={ (155,-40) relative } scale=.78 time=.05


	begin
		DoMorph alpha=0
		wait <blink_time> seconds
		DoMorph alpha=1
		wait <blink_time> seconds
	repeat 6
endscript


Script clock_morph
	DoMorph scale=0 alpha=0 time=.1
	DoMorph scale=1.0 alpha=1 time=.3
endscript

script goal_message_got_trickslot
	SetProps rgba=[43 95 53 128]
	DoMorph time=0 pos=(320, 214) scale=0 alpha=0
	DoMorph time=.5 alpha=1
	if GotParam sound
		PlaySound <sound> vol=150
	endif
	DoMorph time=.1 scale=2.5
	DoMorph time=.1 scale=1.5
	DoMorph time=.1 scale=2.0
	DoMorph time=.1 scale=1.4
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph time=.1 scale=1.4
	DoMorph time=.15 scale=0 alpha=0
	/*    DoMorph pos=(321,265) time=.1
    DoMorph pos=(319,263) time=.1
    DoMorph pos=(321,265) time=.1
    DoMorph pos=(319,263) time=.1
    DoMorph pos=(321,265) time=.1
    DoMorph pos=(319,263) time=.1
    DoMorph pos=(321,265) time=.1
    DoMorph pos=(319,263) time=.1
    DoMorph pos=(321,265) time=.1
    DoMorph pos=(319,263) time=.1
    DoMorph pos=(321,265) time=.1
    DoMorph pos=(319,263) time=.1
    DoMorph pos=(321,265) time=.1
    DoMorph pos=(319,263) time=.1
	*/
	// DoMorph time=.5 alpha=0  pos=(320, 384) rgb=[50 50 50]
	Die
	FireEvent type=goal_got_reward_done
endscript

script goal_message_got_stat
	SetProps rgba=[43 95 53 128]
	DoMorph time=0 pos=(320, 214) scale=0 alpha=0
	; DoMorph time=1.3
	DoMorph time=.5 alpha=1
	if GotParam sound
		PlaySound <sound> vol=150
	endif
	DoMorph time=.1 scale=2.5
	DoMorph time=.1 scale=1.5
	DoMorph time=.1 scale=2.0
	DoMorph time=.1 scale=1.4
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph time=.1 scale=1.4
	DoMorph time=.15 scale=0 alpha=0

	/*    DoMorph pos=(321,225) time=.1
    DoMorph pos=(319,223) time=.1
    DoMorph pos=(321,225) time=.1
    DoMorph pos=(319,223) time=.1
    DoMorph pos=(321,225) time=.1
    DoMorph pos=(319,223) time=.1
    DoMorph pos=(321,225) time=.1
    DoMorph pos=(319,223) time=.1
    DoMorph pos=(321,225) time=.1
    DoMorph pos=(319,223) time=.1
    DoMorph pos=(321,225) time=.1
    DoMorph pos=(319,223) time=.1
    DoMorph pos=(321,225) time=.1
    DoMorph pos=(319,223) time=.1
*/
	// DoMorph time=.5 alpha=0  pos=(320, 384) rgb=[50 50 50]
	Die
	FireEvent type=goal_got_reward_done
endscript

script goal_message_stat_up
	SetProps rgba=[33 112 15 128]
	DoMorph time=0 pos=(320, 195) scale=0 alpha=0
	DoMorph time=.2 alpha=1
	if GotParam sound
		PlaySound <sound> vol=150
	endif
	DoMorph time=.1 scale=2.5
	DoMorph time=.1 scale=1.5
	DoMorph time=.1 scale=2.0
	DoMorph time=.1 scale=1.4
	DoMorph pos=(321,196) time=.1
	DoMorph pos=(319,194) time=.1
	DoMorph time=.1 scale=1.4
	DoMorph time=.15 scale=0 alpha=0
	Die
endscript

script goal_message_got_bigbucks
	SetProps rgba=[43 95 53 128]
	DoMorph time=0 pos=(320, 214) scale=0 alpha=0
	; DoMorph time=1.3
	DoMorph time=.5 alpha=1
	if GotParam sound
		PlaySound <sound> vol=150
	endif
	DoMorph time=.1 scale=1.7
	DoMorph time=.1 scale=.8
	DoMorph time=.1 scale=1.2
	DoMorph time=.1 scale=.9
	DoMorph time=.1 scale=1.0
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1

	DoMorph time=.1 scale=1.4
	DoMorph time=.15 scale=0 alpha=0

	Die
	FireEvent type=goal_got_reward_done
endscript

script goal_message_got_money
	SetProps rgba=[36 125 24 128]
	DoMorph time=0 pos=(320, 114) scale=0 alpha=0
	; DoMorph time=1.3
	DoMorph time=.1 alpha=1
	DoMorph time=.1 scale=1.7
	DoMorph time=.1 scale=.9
	DoMorph time=.1 scale=1.0
	DoMorph alpha=.4 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph time=.1 scale=1.4
	DoMorph time=.1 scale=0 alpha=0
	Die
	FireEvent type=goal_got_reward_done
endscript

script goal_message_got_money2
	SetProps rgba=[36 125 24 128]
	DoMorph time=0 pos=(320, 114) scale=0 alpha=0
	; DoMorph time=1.3
	DoMorph time=.1 alpha=1
	DoMorph time=.1 scale=1.7
	DoMorph time=.1 scale=.9
	DoMorph time=.1 scale=1.0
	DoMorph alpha=.4 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07 scale=1.0
	DoMorph time=.1 scale=1.4
	DoMorph time=.1 scale=0 alpha=0
	Die
	FireEvent type=goal_got_reward_done
endscript

script goal_got_goal_point
	SetProps rgba=[43 95 53 128]
	DoMorph time=0 pos=(320, 214) scale=0 alpha=0
	DoMorph time=.5 alpha=1
	DoMorph time=.1 scale=2.5
	DoMorph time=.1 scale=1.5
	DoMorph time=.1 scale=2.0
	DoMorph time=.1 scale=1.4
	DoMorph pos=(321,215) time=.1
	DoMorph pos=(319,213) time=.1
	DoMorph time=.5 alpha=0  pos=(320, 384) rgb=[50 50 50]
	Die
	FireEvent type=goal_got_goal_point_done
endscript

script panel_message_current_goal_key_combo
	SetProps just=[right top] rgba=[128 128 128 128]
	DoMorph pos=(445, 175)
	DoMorph pos=(445, 175) time=1.2
	DoMorph pos=(630, 63) scale=1.3 time=.1
	DoMorph pos=(630, 63) scale=.8 time=.11

	begin
		DoMorph alpha=0
		wait <blink_time> seconds
		DoMorph alpha=1
		wait <blink_time> seconds
	repeat 6
endscript


script goal_message_got_gap
	SetProps rgba=[20 98 114 108]
	DoMorph time=0 pos=(320, 74) scale=0 alpha=0
	; DoMorph time=1.3
	DoMorph time=.1 alpha=1
	DoMorph time=.1 scale=1.9
	DoMorph time=.1 scale=.9
	DoMorph time=.1 scale=1.2
	DoMorph time=.1 scale=.95
	DoMorph time=.1 scale=1.0
	DoMorph alpha=.4 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.3 time=.07
	DoMorph alpha=1 time=.07
	DoMorph alpha=.6 time=.07
	DoMorph alpha=1 time=.07 scale=1.0
	DoMorph time=.1 scale=1.7
	DoMorph time=.1 scale=0 alpha=0
	Die

endscript

// ********************************************************
//				Various constants
// ********************************************************

goal_pro_last_names = {
	tony 		= "Hawk"
	bam 		= "Margera"
	bucky		= "Lasek"
	chad		= "Muska"
	jamie		= "Thomas"
	rodney		= "Mullen"
	eric		= "Koston"
	rune		= "Glifberg"
	geoff		= "Rowley"
	andrew		= "Reynolds"
	steve		= "Caballero"
	elissa		= "Steamer"
	bob			= "Burnquist"
	kareem		= "Campbell"
	paul		= "Rodriguez"
	Arto		= "Saari"
	Mike		= "Vallely"

	Gene		= "Simmons"
	Iron		= "Iron Man"
	Creature		= "Creature"
	Ped			= "Pedestrian"
}

goal_pro_last_name_checksums = {
	tony 		= Hawk
	bam 		= Margera
	bucky		= Lasek
	chad		= Muska
	jamie		= Thomas
	rodney		= Mullen
	eric		= Koston
	rune		= Glifberg
	geoff		= Rowley
	andrew		= Reynolds
	steve		= Caballero
	elissa		= Steamer
	bob			= Burnquist
	kareem		= Campbell
	custom		= custom

	// these aren't really necessary, but are included for clarity
	jenna		= jameson
	jango		= fett
	eddie		= eddie
	mike		= vallely
}
