LevelTestScripts=
[
    {TestScript=Sch_TestLevel Name="School"}
    {TestScript=Sf2_TestLevel Name="San Francisco 2"}
    {TestScript=Alc_TestLevel Name="Alcatraz"}
    {TestScript=Cnv_TestLevel Name="Carnival"}
    {TestScript=Jnk_TestLevel Name="Junkyard"}
    {TestScript=Kona_TestLevel Name="Kona"}
    {TestScript=Lon_TestLevel Name="London"}
    {TestScript=Zoo_TestLevel Name="Zoo"}
    {TestScript=Hoffman_TestLevel Name="Hoffman"}
]



script Sch_TestLevel
changelevel level=load_sch
// If this were not here then any wait command directly following the ChangeLevel
// would have to include the time taken for the level to load.
// Also it lets things generally settle down. 
wait 5 gameframes

if GotParam TestCommonGoals
    TestCommonGoals 
endif

endscript

script Sf2_TestLevel
changelevel level=load_sf2
wait 5 gameframes

if GotParam TestCommonGoals
    TestCommonGoals 
endif

endscript

script Alc_TestLevel
changelevel level=load_alc
wait 5 gameframes

if GotParam TestCommonGoals
    TestCommonGoals 
endif

endscript

script Cnv_TestLevel
changelevel level=load_cnv
wait 5 gameframes

if GotParam TestCommonGoals
    TestCommonGoals 
endif

endscript

script Jnk_TestLevel
changelevel level=load_jnk
wait 5 gameframes

if GotParam TestCommonGoals
    TestCommonGoals 
endif

endscript

script Lon_TestLevel
changelevel level=load_lon
wait 5 gameframes

if GotParam TestCommonGoals
    TestCommonGoals 
endif

endscript

script Zoo_TestLevel
changelevel level=load_zoo
wait 5 gameframes

if GotParam TestCommonGoals
    TestCommonGoals 
endif

endscript

script Kona_TestLevel
changelevel level=load_kon
wait 5 gameframes

if GotParam TestCommonGoals
    TestCommonGoals 
endif

endscript


script Hoffman_TestLevel
changelevel level=load_hof
wait 5 gameframes

if GotParam TestCommonGoals
    TestCommonGoals 
endif

endscript

script CleanupAnyMenus
wait 10 seconds

if ObjectExists id=stats_menu
    goal_stats_menu_exit
endif

if ObjectExists id=pro_challenge_anchor
    goal_pro_challenges_unlocked_reject
endif

if ObjectExists id=dialog_box_anchor
    goal_new_level_reject
endif

endscript

script TestCommonGoals
GoalManager_UnlockAllGoals
TestScoreGoal Type="HighScore"
CleanupAnyMenus
TestScoreGoal Type="ProScore"
CleanupAnyMenus
TestScoreGoal Type="SickScore"
CleanupAnyMenus
TestSkateLettersGoal
CleanupAnyMenus
TestRaceGoal
CleanupAnyMenus
TestCollectGoal
CleanupAnyMenus
TestComboGoal Type="AmateurComboLine"
CleanupAnyMenus
TestComboGoal Type="ProCombo"
CleanupAnyMenus
GoalManager_UnbeatAllGoals
wait 1 second
endscript


script TestLevels
DestroyAndRecreateMessageContainer

begin
    GetNextArrayElement LevelTestScripts
    ; Element may not exist if the array was empty.
    if GotParam Element 
        // Merge the element's parameters into this scripts parameters so that
        // we can access them via <,>
        AddParams <Element>
        
        // Run the script
        <TestScript>
    else
        break    
    endif
    // Wait a gameframe, so that it doesn't hang in the case of the array being empty.
    wait 1 gameframe    
repeat

begin
    GetNextArrayElement LevelTestScripts
    ; Element may not exist if the array was empty.
    if GotParam Element 
        // Merge the element's parameters into this scripts parameters so that
        // we can access them via <,>
        AddParams <Element>
        
        // Create a message and wait for it to disappear        
        FormatText TextName=MessageText "About to test %s ..." s=<Name>
        DisplayTestMessage Text=<MessageText>
        
        // Run the script
        <TestScript> TestCommonGoals
    endif
    // Wait a gameframe, so that it doesn't hang in the case of the array being empty.
    wait 1 gameframe    
repeat

begin
    GetRandomArrayElement LevelTestScripts
    ; Element may not exist if the array was empty.
    if GotParam Element 
        // Merge the element's parameters into this scripts parameters so that
        // we can access them via <,>
        AddParams <Element>
        
        // Run the script
        <TestScript>
    endif
    // Wait a gameframe, so that it doesn't hang in the case of the array being empty.
    wait 1 gameframe    
repeat

endscript

KenStylePos=(320,405)
script KenStyle
SetProps Scale=2 Pos=KenStylePos Just=[CENTER CENTER] rgba=[0,128,0,128]
DoMorph Time=0 Pos=KenStylePos Scale=0
DoMorph Time=0.2 Pos=KenStylePos Scale=1.2
Wait 2 seconds
FireEvent Type=KenStyleMessageDied
Die
endscript

script DestroyAndRecreateMessageContainer                                  
if ObjectExists Id=TestLevelMessagesContainer
    DestroyScreenElement Id=TestLevelMessagesContainer
endif
SetScreenElementLock Id=root_window Off
CreateScreenElement {
    Id=TestLevelMessagesContainer
    Parent=root_window
    Type=ContainerElement
    Pos=(320,240)
    Dims=(640,480)
}
endscript

script DisplayTestMessage
SetScreenElementLock Id=TestLevelMessagesContainer Off
CreateScreenElement {
    Parent=TestLevelMessagesContainer
    Type=TextElement
    Font=Small
    Text=<Text>
}    
RunScriptOnScreenElement Id=<Id> KenStyle
WaitForEvent Type=KenStyleMessageDied
endscript

script WaitForCameraAnimToFinish
begin
    if SkaterCamAnimFinished
        break
    endif
    wait 1 gameframe
repeat
endscript


script TestSkateLettersGoal
DisplayTestMessage Text="About to test letters goal ..."
GoalManager_CreateGoalName Goal_Type="Skate"
if GoalManager_ActivateGoal Name=<Goal_Id> DontAssert

    GoalManager_GetGoalParams Name=<Goal_Id>
    wait 1 gameframe
    ;WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
    wait 1 gameframe
    
    JumpSkaterToNode NodeName=<s_obj_id>
    wait 1 gameframe
    JumpSkaterToNode NodeName=<k_obj_id>
    wait 1 gameframe
    JumpSkaterToNode NodeName=<a_obj_id>
    wait 1 gameframe
    JumpSkaterToNode NodeName=<t_obj_id>
    wait 1 gameframe
    JumpSkaterToNode NodeName=<e_obj_id>
    wait 1 gameframe
    
    ;WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
else

    wait 1 seconds
    DisplayTestMessage Text="No SKATE letters goal to test ..."

endif

endscript


script TestRaceGoal
DisplayTestMessage Text="About to test race goal ..."
GoalManager_CreateGoalName Goal_Type="Race"
if GoalManager_ActivateGoal Name=<Goal_Id> DontAssert

    GoalManager_GetGoalParams Name=<Goal_Id>
    wait 1 gameframe
    //WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
    
    wait 1 gameframe
    
    begin
        GetNextArrayElement <race_waypoints>
        if not GotParam Element
            break
        endif
        
        AddParams <Element>
        JumpSkaterToNode NodeName=<Id>
            
        wait 1 gameframe
    repeat
    
    
    //WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
else

    wait 1 seconds
    DisplayTestMessage Text="No Race goal to test ..."

endif

endscript


script TestCollectGoal
DisplayTestMessage Text="About to test collect goal ..."
GoalManager_CreateGoalName Goal_Type="Collect"
if GoalManager_ActivateGoal Name=<Goal_Id> DontAssert

    GoalManager_GetGoalParams Name=<Goal_Id>
    wait 1 gameframe
    //WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
    
    wait 1 gameframe

    // Visit each node in a random order to make the test rigorous.
    PermuteArray Array=<goal_collect_objects> NewArrayName=PermutedArray   
    begin
        GetNextArrayElement <PermutedArray>
        if not GotParam Element
            break
        endif
        
        AddParams <Element>
        JumpSkaterToNode NodeName=<Id>
        
        // Sometimes scripted events may happen when a node is visited, so
        // make sure any camera move has had a chance to display.
        ;WaitForCameraAnimToFinish    
        ;wait 1 gameframe
        
        wait 2 seconds
        PlaySkaterCamAnim skater = 0 stop

    repeat
    
    
    ;WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
else

    wait 1 seconds
    DisplayTestMessage Text="No Collect goal to test ..."

endif

endscript


script TestComboGoal 
FormatText TextName=MessageText "About to test %s ..." s=<Type>
DisplayTestMessage Text=<MessageText>

GoalManager_CreateGoalName Goal_Type=<Type>

if GoalManager_ActivateGoal Name=<Goal_Id> DontAssert

    GoalManager_GetGoalParams Name=<Goal_Id>
    wait 1 gameframe
    //WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
    
    wait 1 gameframe
    
    JumpSkaterToNode NodeName=<c_obj_id> MoveUpABit 
    wait 1 gameframe
    JumpSkaterToNode NodeName=<o_obj_id> MoveUpABit
    wait 1 gameframe
    JumpSkaterToNode NodeName=<m_obj_id> MoveUpABit
    wait 1 gameframe
    JumpSkaterToNode NodeName=<b_obj_id> MoveUpABit
    wait 1 gameframe
    JumpSkaterToNode NodeName=<o2_obj_id> MoveUpABit
    wait 1 gameframe
    
    ;WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
else

    wait 1 seconds
    FormatText TextName=MessageText "No %s to test ..." s=<Type>
    DisplayTestMessage Text=<MessageText>

endif

endscript

script TestScoreGoal 
FormatText TextName=MessageText "About to test %s ..." s=<Type>
DisplayTestMessage Text=<MessageText>

GoalManager_CreateGoalName Goal_Type=<Type>
if GoalManager_ActivateGoal Name=<Goal_Id> DontAssert

    GoalManager_GetGoalParams Name=<Goal_Id>
    wait 1 gameframe
    //WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
    
    MakeSkaterGoto MakeSkaterGetScore Params={Score=<Score>}
    
    ;WaitForCameraAnimToFinish
    wait 2 seconds
    PlaySkaterCamAnim skater = 0 stop
    
    
else

    wait 1 seconds
    FormatText TextName=MessageText "No %s to test ..." s=<Type>
    DisplayTestMessage Text=<MessageText>

endif

endscript

script MakeSkaterGetScore
// Make sure we get enough points by doubling the required score.
SetTrickName 'Cheat Score'
SetTrickScore <Score>
Display
SetTrickName 'Cheat Score'
SetTrickScore <Score>
Display
ClearPanel_Landed
goto OnGroundAI
endscript

