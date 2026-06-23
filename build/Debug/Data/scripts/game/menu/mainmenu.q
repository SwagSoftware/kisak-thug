;/////////////////////////////////////////////////////////////////////////////////////////
;//
;//  Camera animation scripts
;//
;/////////////////////////////////////////////////////////////////////////////////////////
;
;script MainMenuCam
;PlaySkaterCamAnim skater = 0 name = "Cam_Default01" play_hold
;endscript
;
;script MainMenuToOptionsCamAnim
;PlaySkaterCamAnim skater = 0 name = "Cam_Options01_Anim" play_hold
;endscript
;
;script OptionsToMainMenuCamAnim
;MoveMenu Id=net_network_setup_menu x=45
;if IsTrue ReturnedFromLevelRecords
;    Change ReturnedFromLevelRecords=0
;else
;    PlaySkaterCamAnim skater = 0 name = "Cam_Options01_Back" play_hold
;endif
;endscript
;
;script MainMenuToPlayer1CamAnim
;PlaySkaterCamAnim skater = 0 name = "Cam_MainMenu01_Anim" play_hold
;EnableSkaterRotation
;SetCurrentSkaterProfile 0
;endscript
;
;script Player1ToMainMenuCamAnim
;PlaySkaterCamAnim skater = 0 name = "Cam_MainMenu01_BackAnim" play_hold
;ResetSkaterRotation
;DisableSkaterRotation
;endscript
;
;script LevelSelectToPlayer1CamAnim
;PlaySkaterCamAnim skater = 0 name = "Cam_LevelSelect01_BackAnim" play_hold
;endscript
;
;script Player1ToLevelSelectCamAnim
;PlaySkaterCamAnim skater = 0 name = "Cam_LevelSelect01_Anim" play_hold
;BuildCassetteMenu
;; Waits for the camera anim to finish, then enables the cassette menu.
;killspawnedscript name=WaitThenEnableCassettes
;SpawnScript WaitThenEnableCassettes Params=<...>
;endscript
;
;script Player1ToPlayer2CamAnim
;PlaySkaterCamAnim skater = 0 name = "Cam_MainMenu02_Anim" play_hold
;ResetSkaterRotation
;endscript
;
;script Player2ToPlayer1CamAnim
;PlaySkaterCamAnim skater = 0 name = "Cam_MainMenu02_BackAnim" play_hold
;ResetSkaterRotation
;endscript
;
;script Player2ToLevelSelectCamAnim
;PlaySkaterCamAnim skater = 0 name = "Cam_LevelSelect02_Anim" play_hold
;BuildCassetteMenu
;; Waits for the camera anim to finish, then enables the cassette menu.
;killspawnedscript name=WaitThenEnableCassettes
;SpawnScript WaitThenEnableCassettes
;DisableSkaterRotation
;endscript
;
;script LevelSelectToPlayer2CamAnim
;PlaySkaterCamAnim skater = 0 name = "Cam_LevelSelect02_BackAnim" play_hold
;ResetSkaterRotation
;EnableSkaterRotation
;endscript
;
;script Player1ToBoardshop
;Player1ToBoardShopCamAnim
;MakeSkaterGoto MoveToCounter Skater=0
;endscript
;
;script Player1ToChangeAppearance
;SetCurrentSkaterProfile 0
;endscript
;
;script ParkEditorLaunch
;SetFrontEndPad 0
;SetNetworkMode	// with no parameters clears network modes
;AutoLaunch level=custom_park game=parkeditor
;endscript
;
;script CareerMenuBack
;Player1ToMainMenuCamAnim
;endscript
;
;script UpdateParkNameInMenuTitles
;GetParkName
;SetMenuElementText id=cassette_menu_park_editor_menu_title <ParkName>
;SetMenuElementText id=cassette_menu_dummy_line <ParkName>
;endscript
;
;script _LoadParkFromDisc
;SwitchOffMenu Id=cassette_menu_parked_load_menu
;spawnscript LoadParkFromDisc Params=<...>
;endscript
;
;; Gets spawned so that it can display the simple menu's and have wait commands.
;script LoadParkFromDisc
;Message_LoadingParkFromDisc
;if ParkEditorCommand command=accessDisk file=<file> DoNotCleanupAndInitialize
;    Message_LoadSuccessful
;else
;    Message_LoadParkFromDiscFailed
;endif
;UpdateParkNameInMenuTitles
;wait .5 seconds
;SwitchToMenu DoNotMakeRoot menu=cassette_menu_park_editor_menu
;endscript
;
;
;// The y coord of the top of the goal info text, displayed when a cassette is selected using square or circle.
;GoalInfoTopY=60
;// The y separation of the goal info text lines.
;GoalInfoDY=35
;
;script CareerMenuShow
;
;; This just fixes a 1 frame glitch when going into the career menu ...
;if MenuIsShown pro_menu
;    ; CareerMenuShow also gets called whenever left/right are pressed in the pro_menu
;    ; In this case, don't pop the career_info off screen, otherwise it will stick when
;    ; scrolling through the pros.
;else
;    ; Otherwise, CareerMenuShow is being called when going into the career menu. In this
;    ; case, do pop the career_info off screen to prevent a glitch where it is seen for a frame.
;    ; Have to test for the pro_menu not being shown rather than the career menu being shown,
;    ; because the career menu will not have appeared yet, but will a frame later.
;    MakeMenuPopOffScreen Id=career_info Left
;endif
;
;; Show the career info menu
;FireMenuEvent Type=SHOW Id=career_info target=career_info
;; But, trouble is, the previous show event will switch on all the medals in the menu, but we only want to
;; show selected ones. So switch them all off again.
;; Call the C-function that writes the info into the menu elements.
;; It will also switch on the appropriate medals.
;UpdateCareerInfoMenu
;
;; MaybeWhizz needs to be spawned because it checks the pad, and if done in the same
;; frame the pad checks will always return true.
;; Spawning it delays it by a frame.
;SpawnScript MaybeWhizz
;endscript
;
;script MaybeWhizz
;; Only whizz on screen if neither left or right is being pressed. If they are pressed,
;; snap the menu to its final position.
;; This is because the CareerMenuShow script also gets run whenever a pro is changed, and
;; loading the pre file for the pro takes some time, so if this check was not done
;; holding down left or right would cause the menu to appear stuck half way on screen.
;; (TT2978)
;if ControllerPressed Left
;    movemenu Id=career_info x=45
;else
;    if ControllerPressed Right
;        movemenu Id=career_info x=45
;    else
;        MakeMenuZoomOn Id=career_info FromLeft
;    endif
;endif
;endscript
;
;script CareerMenuBackOut
;; Hide it so no processor time is wasted drawing it when it's off screen (necessary?)
;FireMenuEvent Type=HIDE Id=career_info target=career_info
;endscript
;
;
;script SetDefaultSliderPos
;if CurrentSkaterProfileIs 1
;    movemenu Id=slider_info x=295
;else
;    movemenu Id=slider_info x=45
;endif
;endscript
;
;; SliderShow is very similar to CareerMenuShow above, except it displays a different sliding
;; menu which does not show career info, but just the skater's name, trick style and stance.
;; This info gets displayed for the free skate, single session, network play and multiplayer menus.
;script SliderShow
;
;SetDefaultSliderPos
;
;if MenuIsShown pro_menu
;    ; SliderShow also gets called whenever left/right are pressed in the pro_menu
;    ; In this case, don't pop the slider_info off screen, otherwise it will stick when
;    ; scrolling through the pros.
;else
;    ; Otherwise, SliderShow is being called when going into the free skate, or single session etc menus.
;    ; In this case, do pop the career_info off screen to prevent a glitch where it is seen for a frame.
;    if CurrentSkaterProfileIs 1
;        MakeMenuPopOffScreen Id=slider_info Right
;    else
;        MakeMenuPopOffScreen Id=slider_info Left
;    endif
;endif
;
;FireMenuEvent Type=SHOW Id=slider_info target=slider_info
;; Call the C-function that writes the info into the menu elements.
;UpdateSliderInfoMenu
;
;SpawnScript SliderMaybeWhizz
;endscript
;
;script SliderMaybeWhizz
;if ControllerPressed Left
;    SetDefaultSliderPos
;else
;    if ControllerPressed Right
;        SetDefaultSliderPos
;    else
;        if CurrentSkaterProfileIs 1
;            ; I need this line for some reason, maybe a bug in MakeMenuZoomOn when zooming from right?
;            MakeMenuPopOffScreen Id=slider_info Right
;            MakeMenuZoomOn Id=slider_info FromRight
;        else
;            MakeMenuZoomOn Id=slider_info FromLeft
;        endif
;    endif
;endif
;endscript
;
;script SliderHide
;FireMenuEvent Type=HIDE Id=slider_info target=slider_info
;endscript
;
;// Total number of goals in the game.
;// Gets read by the c-code in ScriptUpdateCareerInfoMenu
;TotalGoals=54
;
