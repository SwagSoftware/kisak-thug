script CreateGoalEditor
CreateCompositeObject {
    Components=
    [
        {component = camera}
        {component = input controller=0}        
        // Note: Best if the editorcamera component is created before the goaleditor component,
        // otherwise the shadow will lag a frame.
        {component = editorcamera max_radius=2000}
        {component = goaleditor}        
    ]
    Params={Name=GoalEditor permanent}
}
GoalEditor:Hide
GoalEditor:Suspend
endscript

script InitialiseCreatedGoals
// First remove any existing created-goals from the goal manager.
GoalEditor:GetMaxGoalsPerLevel
i=0
begin
    FormatText ChecksumName=goal_id "CreatedGoal%d" d=<i>
    if GoalManager_GoalExists name=<goal_id>
        GoalManager_RemoveGoal name=<goal_id>
    endif    
    i=(<i>+1)
repeat <max_goals>    


GetCurrentLevel
// The goal editor always has PE goals registered under Load_Sk5Ed, so map Load_Sk5Ed_gameplay to that
if ChecksumEquals a=<level> b=Load_Sk5Ed_gameplay
    level=Load_Sk5Ed
endif    
GoalEditor:GetEditedGoalsInfo Level=<Level>
if gotparam EditedGoalsInfo
    GetArraySize <EditedGoalsInfo>
    if (<array_size>=0)
        return
    endif    
    
    i=0
    begin
        goal_id=(<EditedGoalsInfo>[<i>].goal_id)
        pro_name=(<EditedGoalsInfo>[<i>].pro_name)
        
        GoalEditor:AddEditedGoalToGoalManager goal_id=<goal_id>
        GoalEditor:WriteEditedGoalNodePositions goal_id=<goal_id>
        
        i=(<i>+1)
    repeat <array_size>    
    
    // Sometimes we may not want to create the peds, for example when starting a network game,
    // where the peds only get created when a goal attack game is started.
    if not GotParam DoNotCreateGoalPeds
        GoalManager_InitializeAllGoals
    endif    
endif    
endscript

script ChooseRandomCreatedGoalPedModel
    Random(
           @Obj_InitModelFromProfile struct=ped_bender use_asset_manager=1 texDictOffset=0
           @Obj_InitModelFromProfile struct=ped_skeezo use_asset_manager=1 texDictOffset=0
          )
endscript

script goal_editor_destroy_cursor
    if ObjectExists id=GoalEditorCursor
        GoalEditorCursor:Die
        if IsNGC
            FinishRendering
        endif    
    endif    
endscript

script goal_editor_create_cursor
    goal_editor_destroy_cursor
    
    switch <Type>
        case Ped
    		CreateCompositeObject {
                Components=
                [
                    // The motion component is only needed to ensure the display matrix is updated, otherwise
                    // the orientation will not be able to be set using Obj_SetOrientation
                    {component = motion}
                    {component = Suspend NeverSuspend}
                    {component = skeleton SkeletonName = THPS5_human}
                    {component = model}
                    {component = Animation AnimName = animload_THPS5_human}
                ]
    			Params={Name=GoalEditorCursor}
    		}
            
            if ((LevelIs load_sk5ed) || (LevelIs load_sk5ed_gameplay))
                GoalEditorCursor:ChooseRandomCreatedGoalPedModel
            else    
                GoalEditorCursor:Obj_InitModelFromProfile {
                                struct=random_male_profile
                                use_asset_manager=1
                                texDictOffset=0 }
            endif
            
            GoalEditorCursor:Obj_SpawnScript cursor_ped_script    
        default
            CreateCompositeObject {
                Components=
                [
                    // The motion component is only needed to ensure the display matrix is updated, otherwise
                    // the orientation will not be able to be set using Obj_SetOrientation
                    {component = motion}
                    {component = model Model = <Model>}
                ]
                Params={Name=GoalEditorCursor}
            }
    endswitch                
endscript

script goal_editor_update_cursor_position
    if ObjectExists id=GoalEditorCursor
        GoalEditorCursor:Obj_SetPosition Position=<pos>
        
        angle=(<angle>*180/3.141592654)
        GoalEditorCursor:Obj_SetOrientation y=<angle>
    endif    
endscript

script cursor_ped_script
    begin
        if ((LevelIs load_sk5ed) || (LevelIs load_sk5ed_gameplay))
            // Only certain anims are loaded when in the park editor
            Random (
            @Obj_PlayAnim Anim=Cheer1
            @*10 Obj_PlayAnim Anim=NewBrakeIdle
            )
        else
            Random (
            @Obj_PlayAnim Anim=Ped_M_Cheering
            @Obj_PlayAnim Anim=Ped_M_ThumbUp
            @Obj_PlayAnim Anim=Ped_M_Clap
            )
        endif    
        Obj_WaitAnimFinished
    repeat
endscript

script goal_editor_delete_marker_object 
    if ObjectExists id=<Name>
        <Name>:Die
    endif    
endscript

script goal_editor_create_marker_object
    goal_editor_delete_marker_object Name=<Name>

    switch <Type>
        case Letter
            CreateCompositeObject {
                Components=
                [
                    {component = motion} // Needed for the hover
                    {component = model Model = <Model>}
                ]
                Params={Name=<Name>}
            }
        
            <Name>:Obj_SetPosition Position=<pos>
            <Name>:Obj_Hover Amp=6 Freq=2
            <Name>:Obj_RotY speed = 200
        case Ped
    		CreateCompositeObject {
                Components=
                [
                    // The motion component is only needed to ensure the display matrix is updated, otherwise
                    // the orientation will not be able to be set using Obj_SetOrientation
                    {component = motion}
                    {component = Suspend NeverSuspend}
                    {component = skeleton SkeletonName = THPS5_human}
                    {component = model}
                    {component = Animation AnimName = animload_THPS5_human}
                ]
    			Params={Name=<Name>}
    		}
            if ((LevelIs load_sk5ed) || (LevelIs load_sk5ed_gameplay))
                <Name>:ChooseRandomCreatedGoalPedModel
            else
                <Name>:Obj_InitModelFromProfile {
                                        struct=random_male_profile
                                        use_asset_manager=1
                                        texDictOffset=0 }            
            endif    
            
            <Name>:Obj_SetPosition Position=<pos>
            <Name>:RotateDisplay StartAngle=<Angle> EndAngle=<Angle> Y HoldOnLastAngle
            <Name>:Obj_SpawnScript cursor_ped_script    

        default    
            CreateCompositeObject {
                Components=
                [
                    // The motion component is only needed to ensure the display matrix is updated, otherwise
                    // the orientation will not be able to be set using Obj_SetOrientation
                    {component = motion}
                    {component = model Model = <Model>}
                ]
                Params={Name=<Name>}
            }
        
            <Name>:Obj_SetPosition Position=<pos>
            <Name>:RotateDisplay StartAngle=<Angle> EndAngle=<Angle> Y HoldOnLastAngle
    endswitch        
endscript

script goal_editor_refresh_goal_object_position
    if ObjectExists id=<Name>
        <Name>:Obj_SetPosition Position=<pos>
    endif    
endscript

// These don't do anything yet cos the sounds aren't loaded, 
// I guess all levels will need to load the  corresponding park editor sounds? Eg GUI_placeblock1
script goal_editor_play_placement_success_sound
generic_menu_pad_choose_sound
endscript

script goal_editor_play_placement_fail_sound
generic_menu_buzzer_sound
endscript

script goal_editor_play_backup_success_sound
generic_menu_pad_back_sound
endscript

script goal_editor_play_backup_fail_sound
generic_menu_buzzer_sound
endscript

EditorCam_TurnSpeed=0.04
EditorCam_TiltSpeed=0.03
EditorCam_TiltMin=0.5
EditorCam_TiltMax=1.5707
EditorCam_InOutSpeed=.03
EditorCam_MoveSpeedMin=5
EditorCam_MoveSpeedMax=25
EditorCam_UpDownSpeedMin=1
EditorCam_UpDownSpeedMax=16
EditorCam_MaxHeight=1000

// Offsets used when doing collision checks for the cursor. If a ground collision is not found
// for the first offset, the second higher offset is tried.
EditorCam_CursorCollisionFirstUpOffset=100
EditorCam_CursorCollisionSecondUpOffset=10000
EditorCam_CursorCollisionDownOffset=-10000

EditorCam_YCatchUpFactor=0.05

EditedGoal_ExtraParams_Combo=
{
    goal_type="CreatedCombo"
    pro="Kenzo"
    no_stream // Means CGoalPed::PlayGoalStartStream() will not attempt to play a stream
    full_name="Created Goal"
    goal_description="Get the C-O-M-B-O letters in one combo"
}

EditedGoal_ExtraParams_Skate=
{
    goal_type="CreatedSkate"
    pro="Kenzo"
    no_stream // Means CGoalPed::PlayGoalStartStream() will not attempt to play a stream
    full_name="Created Goal"
    goal_description="Collect the S-K-A-T-E letters"
}

EditedGoal_ExtraParams_HighScore=
{
    goal_text = "High Score"
    goal_type="CreatedHighScore"
    pro="Kenzo"
    no_stream // Means CGoalPed::PlayGoalStartStream() will not attempt to play a stream
    full_name="Created Goal"
    goal_description="Get a high score"
}

edited_high_score_goal_text="Get a High Score: %d Points"

EditedGoal_ExtraParams_HighCombo=
{
    goal_text = "High Combo"
    goal_type="CreatedHighCombo"
    pro="Kenzo"
    no_stream // Means CGoalPed::PlayGoalStartStream() will not attempt to play a stream
    full_name="Created Goal"
    goal_description="Get a high combo"
}
edited_high_combo_goal_text="Get a High Combo: %d Points"

EditedGoal_ExtraParams_SkateTris=
{
    goal_text = "Skate-Tricks"
    goal_type="CreatedSkate-Tricks"
    pro="Kenzo"
    no_stream // Means CGoalPed::PlayGoalStartStream() will not attempt to play a stream
    full_name="Created Goal"
    goal_description="Nail the tricks as they come up."
    view_goals_text="Skate-Tricks"
}

EditedGoal_ExtraParams_ComboSkateTris=
{
    goal_text = "Combo Skate-Tricks"
    goal_type="CreatedComboSkate-Tricks"
    pro="Kenzo"
    no_stream // Means CGoalPed::PlayGoalStartStream() will not attempt to play a stream
    full_name="Created Goal"
    goal_description="Nail the combos as they come up."
    view_goals_text="Combo Skate-Tricks"
}

EditedGoal_ExtraParams_TrickTris=
{
    goal_text = "TrickTris"
    goal_type="CreatedComboTrickTris"
    pro="Kenzo"
    no_stream // Means CGoalPed::PlayGoalStartStream() will not attempt to play a stream
    full_name="Created Goal"
    goal_description="Nail the tricks as they come up."
    view_goals_text="Tricktris"
}

EditedGoal_ExtraParams_Gap=
{
    goal_text = "Gaps goal"
    goal_type="CreatedGap"
    pro="Kenzo"
    no_stream // Means CGoalPed::PlayGoalStartStream() will not attempt to play a stream
    full_name="Created Goal"
    goal_description="See if you can get this gap."
    
    goal_flags = [got_1]
}

cag_skatetris_key_combos=
[
     {
        text="Basic Flip Tricks"
        key_combos=
        [
            Air_SquareU
            Air_SquareD
            Air_SquareL
            Air_SquareR
        ]
    }
    {
        text="Diagonal Flip Tricks"
        key_combos=
        [
            Air_SquareUL
            Air_SquareUR
            Air_SquareDL
            Air_SquareDR
        ]
    }    
	{
        text="Double Tap Basic Flips"
        key_combos=
        [
            {key_combo=Air_SquareD num_taps=2}
            {key_combo=Air_SquareU num_taps=2}
            {key_combo=Air_SquareL num_taps=2}
            {key_combo=Air_SquareR num_taps=2}
        ]
    }
	{
        text="Double Tap Diagonal Flips"
        key_combos=
        [
            {key_combo=Air_SquareUL num_taps=2}
            {key_combo=Air_SquareUR num_taps=2}
            {key_combo=Air_SquareDL num_taps=2}
            {key_combo=Air_SquareDR num_taps=2}
        ]
    }
	{
        text="Basic Grab Tricks"
        key_combos=
        [
            Air_CircleU
            Air_CircleD
            Air_CircleL
            Air_CircleR
        ]
    }
	{
        text="Diagonal Grab Tricks"
        key_combos=
        [
            Air_CircleUL
            Air_CircleUR
            Air_CircleDL
            Air_CircleDR
        ]
    }
	{
        text="Double Tap Basic Grabs"
        key_combos=
        [
            {key_combo=Air_CircleD num_taps=2}
            {key_combo=Air_CircleU num_taps=2}
            {key_combo=Air_CircleL num_taps=2}
            {key_combo=Air_CircleR num_taps=2}
        ]
    }
	{
        text="Double Tap Diagonal Grabs"
        key_combos=
        [
            {key_combo=Air_CircleUL num_taps=2}
            {key_combo=Air_CircleUR num_taps=2}
            {key_combo=Air_CircleDL num_taps=2}
            {key_combo=Air_CircleDR num_taps=2}
        ]
    }

   /*{
	text="Freestyle Tricks"
	key_combos=
	[
		{ trick="Pogo" key_combo="\b0 + \b0" text="Pogo" }
		{ trick="Truckstand" key_combo="\b0 + \b1" text="Truckstand" }
		{ trick="To Rail" key_combo="\b2 + \b1" text="To Rail" }
		{ trick="Switch Foot Pogo" key_combo="\b0 + \b2" text="Switch Foot Pogo" }
		{ trick="Casper" key_combo="\b1 + \b0" text="Casper" }
		{ trick="Anti Casper" key_combo="\b1 + \b2" text="Anti Casper" }
		{ trick="Handstand" key_combo="\b2 + \b2" text="Handstand" }
	]
	} */

]

// If for some reason no combo sets have been chosen by the time the c-code has
// to add the goal, it will use this array to prevent an assert.
emergency_key_combos = [
    Air_CircleU
    Air_CircleD
    Air_CircleL
    Air_CircleR
    Air_CircleUL
    Air_CircleUR
    Air_CircleDL
    Air_CircleDR
    Air_SquareU
    Air_SquareD
    Air_SquareL
    Air_SquareR
    Air_SquareUL
    Air_SquareUR
    Air_SquareDL
    Air_SquareDR
]



EditorCam_CursorCollisionEnableDistMax=3000
EditorCam_CameraCatchUpFactor=0.3

GoalEditor_LetterHeight=27
GoalEditor_DefaultMinDistBetweenPositions=50
GoalEditor_MinDistBetweenLetters=GoalEditor_DefaultMinDistBetweenPositions ; REMOVE, this was just to avoid having to make a new elf
GoalEditor_MinDistBetweenLettersandSkater=100

// These are templates for the nodes that get added to the NodeArray by the goal editor code just after
// the NodeArray is loaded.
EditedGoal_Pro_Node=
{
	Pos = (0,0,0)
	Angles = (0.000000,0,0.000000)
    // The Name parameter gets added by the c code.
	Class = Pedestrian
	Type = Ped_From_Profile
	;AbsentInNetGames
	SkeletonName = THPS5_human
	AnimName = animload_THPS5_human
	
	// can't use the Ped_M_Idle1, because it's
	// not present in net or park games...
	// instead, use the skater's stand anim
	DefaultAnimName = WStandIdle1
	
	profile = random_male_profile
	SuspendDistance = 3000
	lod_dist1 = 200
	lod_dist2 = 400
}

EditedGoal_Restart_Node=
{
	Pos = (0,0,0)
	Angles = (0.000000,0,0.000000)
    // The Name parameter gets added by the c code.
	Class = Restart
	Type = Player1
	CreatedAtStart
	RestartName = "Edited goal: Restart"
	restart_types = [ Player1 ]
}

EditedGoal_Letter_Node=
{
	Pos = (0,0,0)
	Angles = (0.000000,0,0.000000)
    // The Name, Type and Model parameters get added by the c code.
	Class = GameObject
	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
}

EditedGoal_success_cam_anims=
[
    {
        // Note: The c code inserts the cam_anim_text parameter based on the Win Message text.
        // It also inserts the TargetID parameter.
        virtual_cam
        targetOffset=(1.2, 62.4, 0.0) positionOffset=(-2.4, 0.0, 26.4)
        frames=120
        skippable=1
        play_hold
    }
]

// This is called from level_select_menu_add_item in gamemenu.q
script CountNumCreatedGoalsWon
GoalEditor:GetEditedGoalsInfo Level=<level>

num_goals=0
num_goals_won=0
if gotparam EditedGoalsInfo
    GetArraySize <EditedGoalsInfo>
    if gotparam array_size
        if (<array_size> > 0)
            begin	
                if (<EditedGoalsInfo>[<num_goals>].won_goal)
                    num_goals_won=(<num_goals_won>+1) 
                endif    
                num_goals=(<num_goals>+1)
            repeat <array_size>    
        endif
    endif    
endif

return num_goals=<num_goals> num_goals_won=<num_goals_won>
endscript


