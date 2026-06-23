////////////////////////////////////////////////////////////
// skutils.q - various useful stuff
// start autoduck documentation
// @DOC skutils
// @module skutils | None
// @subindex Scripting Database
// @index script | skutils

check_for_unplugged_controllers=0
TimeOfDayDebug=0

////////////////////////////////////////////////////////////
// For debugging.
////////////////////////////////////////////////////////////
script PrintState
	if InAir
		printf "In air"
	endif

	if OnGround
		printf "On ground"
	endif

	if OnWall
		printf "On wall"
	endif

	if OnLip
		printf "On lip"
	endif

	if OnRail
		printf "OnRail"
	endif

endscript

/////////////////////////////////////////////////////////////////
// script that is called on the skater whenever he scores a gap
/////////////////////////////////////////////////////////////////

script DefaultGapScript
	PlaySound HUD_jumpgap

	if Skating
		if OnGround
			LandGapsImmediately=1
		endif
	else
		if Walking
			LandGapsImmediately=1
		else
			if Driving
				LandGapsImmediately=1
			endif
		endif
	endif

	if GotParam LandGapsImmediately
		GetNumberOfNonGapTricks
		if ( <NumberOfNonGapTricks> = 0 )
			LandSkaterTricks
		endif
	endif
endscript


/////////////////////////////////////////////////////////////////
// Set all the skater's stats to the passed value.
/////////////////////////////////////////////////////////////////

script SetAllStats value = 3
	printf "Overriding Stats to %d" d=<value>
	SetStatOverride <value>
endscript

script ToggleMinMetrics
	ToggleMetricItem item = METRIC_TIME
	;ToggleMetricItem item = METRIC_ARENAUSAGE
	ToggleMetricItem item = METRIC_TOTALPOLYS
	;ToggleMetricItem item = METRIC_POLYSPROC
	ToggleMetricItem item = METRIC_VERTS
	ToggleMetricItem item = METRIC_RESOURCEALLOCS
	ToggleMetricItem item = METRIC_TEXTUREUPLOADS
	ToggleMetricItem item = METRIC_VU1
	ToggleMetricItem item = METRIC_DMA1
	ToggleMetricItem item = METRIC_DMA2
	;ToggleMetricItem item = METRIC_VBLANKS
	;ToggleMetricItem item = METRIC_DRAWTIME
	ToggleMetricItem item = METRIC_IHANDLERTIME
	ToggleMetricItem item = METRIC_SKYCACHE
	ToggleMetricItem item = METRIC_VIDEOMODE
	;ToggleMetricItem item = METRIC_VRAMUSAGE
	;ToggleMetricItem item = METRIC_MEMUSED
	ToggleMetricItem item = METRIC_MEMFREE
	ToggleMetricItem item = METRIC_REGIONINFO
endscript

script MaybePause Button=r1
	if held <Button>
		begin
		repeat 800000
	endif
endscript

////////////////////////////////////////////////////////////
// Waits one game frame. Used in begin-repeat loops to
// make them loop every frame instead of hanging.
////////////////////////////////////////////////////////////
script WaitOneGameFrame
	Wait 1 gameframes
endscript

////////////////////////////////////////////////////////////
// Waits for the current anim to finish.
////////////////////////////////////////////////////////////
script WaitAnimFinished
	// K: Changed it to use this function instead of polling, because it is
	// much faster and makes stepping through skater scripts in the script debugger
	// easier since you don't have to click through the loop.
	Obj_WaitAnimFinished
	/*begin
;MaybePause
if AnimFinished
    break
endif
WaitOneGameFrame
repeat*/
endscript

script WaitAnimWhilstChecking
	begin
		DoNextTrick
		if GotParam AndManuals
			DoNextManualTrick
		endif
		if AnimFinished
			break
		endif
		Wait 1 GameFrame
	repeat
endscript

script WaitWhilstChecking
	GetStartTime
	begin
		DoNextTrick
		if GotParam AndManuals
			DoNextManualTrick
		endif
		Wait 1 GameFrame

		GetElapsedTime StartTime=<StartTime>
		if (<ElapsedTime> > <Duration>)
			break
		endif
	repeat
endscript

////////////////////////////////////////////////////////////////
// Reverses the direction of the current animation
////////////////////////////////////////////////////////////////
script Reverse
	PlayAnim Anim=Current From=Current To=0
endscript

////////////////////////////////////////////////////////////
// Waits for a flag to be set.
////////////////////////////////////////////////////////////
script Obj_WaitForFlag
	begin
		if Obj_FlagSet <...>
			break
		endif
		WaitOneGameFrame
	repeat
endscript

////////////////////////////////////////////////////////////
// GJ:  Runs a function once per frame until it returns a
// non-zero success code.  This is useful in the skate loop
// because it simulates blocking the current script, while
// still calling the function that is needed to unblock it
////////////////////////////////////////////////////////////

script PollUntilFinished
	if GotParam Func
		begin
			if <func> <...>
				break
			endif
			wait 1 gameframe
		repeat
	else
		begin
			printf "AAAAAAAARGH !!!!  PollUntilFinished needs a Func parameter !"
			wait 1 gameframe
		repeat
	endif
endscript

////////////////////////////////////////////////////////////
// GJ:  Launches a level with the new network architecture
// gameflow (i.e. requests a level to be loaded, rather than
// loading it up immediately)
//
// Mick: Changed to just load it directly.  This function
// is only used at bootup, and on the final CD
// it will only be used to load up the skateshop
// see default_system_startup in startup.q for details as to
// how this is called
////////////////////////////////////////////////////////////

script autolaunch
	if gotparam game
		SetGameType <game>
	else
		SetGameType career
	endif
	SetCurrentGameType              // CFunc
	request_level   level=<level>
	cleanup_before_loading_level    // Script
	load_requested_level
	;gameflow StandardGameFlow
	;gameflow            StandardGameFlowToggleView
endscript

script change_level
	change is_changing_levels=1

	// This is to fix a bottom-up fragmentation bug when switching themes in the park editor
	// when the rail editor cursor is on screen. The cursor shadow was left behind, causing
	// excessive bottom-up fragmentation.
	if LevelIs load_sk5ed
		SwitchOffRailEditor
	endif

	ResetScore
	SetMusicLooping 0

	if Not IsObserving
		Skater:reset_model_lights
	endif
	if ObjectExists id=Skater2
		Skater2:reset_model_lights
	endif

	change check_for_unplugged_controllers=0

	// setup any script to run when the new level loads
	if GotParam next_level_script
		change next_level_script = <next_level_script>
	endif

	// TODO: these may need to be changed for net games
	// (using "Skater:" isn't always safe)
	if Not IsObserving
		skater:ClearPanel_Landed
	endif

	if not GotParam no_levelUnload
		printf "performing LevelUnload"
		GoalManager_LevelUnload
	endif

	ResetScore
	ResetScorePot
	hide_console_window

	GoalManager_LevelUnload
	GoalManager_DeactivateAllGoals
	if Not IsObserving
		Skater:StatsManager_DeactivateGoals
	endif
	ScreenElementSystemCleanup
	if not inNetGame
		hide_everything
	endif

	kill_blur
	//	if GotParam player_two      // Mick:  changed to use "InSplitScreenGame", as player_two parameter is not there for custom parks
	if InSplitScreenGame
		launch_two_player
	endif

	// GJ POSSIBLE FIX FOR SK5:TT11308:
	// "Story Mode - New Jersey - Missing textures before loading Manhattan"
	// There's a 1-frame lag between this point and the actual
	// starting of the level changing process, during which the
	// camera may show part of the level...  to fix, I'm going to
	// freeze the loading screen...	 the level-loading process
	// will display a correct LoadingScreen shortly afterwards,
	// so we don't have to worry about hiding this loading screen
	if IsXbox
		DisplayLoadingScreen freeze
	endif

	ChangeLevel <...>
endscript

script QuickScript
	printf "Running quickscript...."
	ReloadNodeArray
	// Also reload particle system textures, as we might have changed them
	if  ScriptExists LoadAllParticleTextures
		LoadAllParticleTextures
	endif
	Retry
endscript

script ReloadScene
	// When we Quickview designers want the game to remember where the skater was
	Skater:SetCustomRestart Set

	if gotparam scene
		if UnloadScene <...>
			Cleanup

			if not InNetGame
				AllocatePathManMemory
			endif

			FormatText ChecksumName=struct_name "level_%s" s=<scene>
			AddParams <struct_name>

			;set_level_lights <...>

			if gotparam sky
				LoadScene scene=<sky>
			endif
			LoadScene <...>

			if gotparam level_name
				SetLevelName        <level_name>
			else
				SetLevelName        <level>
			endif

			if gotparam qb
				LoadNodeArray <qb>
			endif
			if gotparam level_qb
				LoadQB <level_qb> LevelSpecific
			endif

			if gotparam level_sfx_qb
				LoadQB     <level_sfx_qb> LevelSpecific
			endif

			LoadTerrain
			if gotparam temp_script
				<temp_script>
			endif

			if Not InNetGame
				PushMemProfile  "Level Specific Anims"
				load_level_anims
				PopMemProfile
			endif

			PushMemProfile  "Level Cameras"
			LoadCameras
			PopMemProfile

			if ScriptExists LoadObjectAnims
				// not all levels have object anims, yet
				PushMemProfile  "Object Anims"
				LoadObjectAnims
				PopMemProfile
			endif

			// Also reload particle system textures, as we might have changed them
			if  ScriptExists LoadAllParticleTextures
				LoadAllParticleTextures
			endif

			if gotparam startup_script
				<startup_script>
			endif
			LoadCollision <...>
			ParseNodeArray

			if GotParam setup_script
				<setup_script>
			endif

			// Refresh poly count, etc, for on-screen statistics
			refresh_poly_count
			// Put it onscreen
			if (SHOWPOLYS_ONQUICKVIEW)
				if ( poly_count_on = 0 )
					show_poly_count
				endif
			endif

		else
			AutoLaunch level=<scene>
		endif
	else
		script_assert "No scene param specified for autolaunching"
	endif

	// When we Quickview designers want the game put the skater back to where he was at the start of Quickview
	Skater:SkipToCustomRestart
	// SP: For artists that are messing with the time of day in the lighting level,
	// they will want to apply their chosen light settings to the level geo
	// every time they reload it. Otherwise, if you set it to night, and quickview
	// the geo will set back to day. Until some bugs are fixed with level lighting,
	// only do this for those with this global set true
	If IsTrue TimeofDayDebug
		set_all_light_values level_only
	endif
endscript

script  AddToScene
	if gotparam add
	else
		add "update"
	endif

	if gotparam scene
		AddScene           scene= <scene> add= <add>
		AddCollision       scene= <scene> add= <add>
	else
		script_assert "No scene param specified for autolaunching"
	endif
endscript

script  LoadLevelGeometry
	if gotparam sky
		LoadScene scene = <sky>
	endif
	if gotparam level
		LoadScene scene = <level>
		LoadCollision scene = <level>
	endif
endscript

script QuickStart scene="default" sky="ru_sky"
	LoadScene           scene= <sky>
	LoadScene           scene= <scene>
	gameflow            StandardGameFlowToggleView
endscript



////////////////////////////////////////////////////////////
// GJ:  Verifies that a required param has been passed to
// a script function:
// Usage: VerifyParam param=menu_name func=attach_new_cas_color_menu <...>
////////////////////////////////////////////////////////////

script VerifyParam
	if gotparam <param>
	else
		printf "Required param not found in script function:"
		printf <param>
		printf <func>
		script_assert "Terminating..."
	endif
endscript

// Some equates

// Trigger types
TRIGGER_THROUGH		     = 0
TRIGGER_SKATE_OFF_EDGE   = 1
TRIGGER_JUMP_OFF         = 2
TRIGGER_LAND_ON          = 3
TRIGGER_SKATE_OFF        = 4
TRIGGER_SKATE_ONTO       = 5
TRIGGER_BONK             = 6
TRIGGER_LIP_ON           = 7
TRIGGER_LIP_OFF          = 8
TRIGGER_LIP_JUMP         = 9

// Skate gap flags

// If the skater enters this state during the gap, the gap is canceled.

CANCEL_GROUND =				0x00000001
CANCEL_AIR =              	0x00000002
CANCEL_RAIL =             	0x00000004
CANCEL_WALL =             	0x00000008
CANCEL_LIP =              	0x00000010
CANCEL_WALLPLANT =			0x00000020
CANCEL_MANUAL =				0x00000040
CANCEL_HANG =     	    	0x00000080
CANCEL_LADDER =	         	0x00000100

// The "Pure" version of the above, cancel on anything apart from one state.

PURE_GROUND   =             0x000001FE
PURE_AIR      =             0x000001FD
PURE_RAIL     =             0x000001FB
PURE_WALL     =             0x000001F7
PURE_LIP      =             0x000001EF
PURE_WALLPLANT =	        0x000001DF
PURE_MANUAL	  =		        0x000001BF
PURE_HANG	  =		        0x0000017F
PURE_LADDER	  =		        0x000000FF

// The skater must be in this state for at least one frame of the gap.

REQUIRE_GROUND =			0x00010000
REQUIRE_AIR =             	0x00020000
REQUIRE_RAIL =            	0x00040000
REQUIRE_WALL =           	0x00080000
REQUIRE_LIP =             	0x00100000
REQUIRE_WALLPLANT =			0x00200000
REQUIRE_MANUAL =			0x00400000
REQUIRE_HANG =	        	0x00800000
REQUIRE_LADDER =        	0x01000000

// Gap flags based on the player's physics mode.

CANCEL_SKATE =				0x00000200
CANCEL_WALK =  				0x00000400
CANCEL_DRIVE =				0x00000800
REQUIRE_SKATE =				0x02000000
REQUIRE_WALK =				0x04000000
REQUIRE_DRIVE =				0x08000000

/* Unused

script StartAirGap
StartGap <...> flags = [PURE_AIR]
endscript

script StartRailGap
StartGap <...> flags = [PURE_RAIL]
endscript

script StartManualGap
StartGap <...> flags = [PURE_MANUAL]
endscript

script StartWallGap
StartGap <...> flags = [PURE_WALL]
endscript

*/

/////////////////////////////////////////////////////////
// Career related scripts

// CareerRestartLevel - restart the current level
// this assumes that you have already called CareerStartLevel with the
// correct level number
script CareerRestartLevel
	CareerStartLevel level = -1
endscript

script  DefaultHiScoreScript
	//    LaunchpanelMessage "High Score!"
endscript

script DefaultProScoreScript
	//    LaunchpanelMessage "Pro Score!"
endscript

script DisablePause
	AllowPause off
endscript

script EnablePause
	AllowPause
endscript

/////////////////////////////////////////////////////////////////////////
// stuff for panel
script LaunchLocalMessage
	LaunchLocalPanelMessage message_prop_default <...>
endscript



mFD_SKATABLE			= 0x00001
mFD_NOT_SKATABLE		= 0x00002
mFD_WALL_RIDABLE		= 0x00004
mFD_VERT				= 0x00008
mFD_NON_COLLIDABLE		= 0x00010
mFD_DECAL				= 0x00020
mFD_TRIGGER				= 0x00040
mFD_CAMERA_COLLIDABLE	= 0x00080
mFD_NO_SKATER_SHADOW	= 0x00100
mFD_SKATER_SHADOW		= 0x00200
mFD_NO_SKATER_SHADOW_WALL=0x00400
mFD_UNDER_OK			= 0x00800
mFD_INVISIBLE			= 0x01000
mFD_CASFACEFLAGSEXIST   = 0x02000
mFD_PASS_1_DISABLED     = 0x04000
mFD_PASS_2_ENABLED      = 0x08000
mFD_PASS_3_ENABLED      = 0x10000
mFD_PASS_4_ENABLED      = 0x20000
mFD_RENDER_SEPARATE		= 0x40000
mFD_LIGHTMAPPED			= 0x00080000
mFD_NON_WALL_RIDABLE	= 0x00100000
mFD_NON_CAMERA_COLLIDABLE = 0x00200000
mFD_EXPORT_COLLISION	= 0x00400000




// things back to default
script  show_all
	DebugRenderIgnore
endscript

script show_vert
	DebugRenderIgnore ignore_0 = mFD_VERT
endscript

script show_wallride
	DebugRenderIgnore ignore_0 = mFD_WALL_RIDABLE
endscript

script show_wall_ridable
	DebugRenderIgnore ignore_0 = mFD_WALL_RIDABLE
endscript

script show_trigger
	DebugRenderIgnore ignore_0 = mFD_TRIGGER
endscript

script show_invisible
	DebugRenderIgnore ignore_0 = mFD_INVISIBLE
endscript

script show_triggers
	show_trigger
endscript


script show_CAMERA
	//DebugRenderIgnore ignore_0 = mFD_CAMERA_COLLIDE
	DebugRenderIgnore ignore_0 = mFD_NON_CAMERA_COLLIDABLE
endscript

script show_CAMERA_COLLIDE
	DebugRenderIgnore ignore_0 = mFD_CAMERA_COLLIDABLE
endscript

script show_skatable
	DebugRenderIgnore ignore_0 = mFD_SKATABLE
endscript

script show_not_skatable
	DebugRenderIgnore ignore_0 = mFD_not_SKATABLE
endscript

script show_no_skater_shadow
	DebugRenderIgnore ignore_0 = mFD_NO_SKATER_SHADOW
endscript

script show_skater_shadow
	DebugRenderIgnore ignore_0 = mFD_SKATER_SHADOW
endscript

script show_no_skater_shadow_wall
	DebugRenderIgnore ignore_0 = mFD_NO_SKATER_SHADOW_WALL
endscript

script show_non_collidable
	DebugRenderIgnore ignore_0 = mFD_NON_COLLIDABLE
endscript

script show_collidable
	DebugRenderIgnore ignore_1 = mFD_NON_COLLIDABLE
endscript



// when in screenshot mode, then advance one frame
// but keep the camera paused
script frame_advance
	spawnscript s_frame_advance
	toggleviewmode
	unpausegame
	unpauseskaters
endscript

// This script will not get run until the next frame
script s_frame_advance
	toggleviewmode
	toggleviewmode
	pausegame
	pauseskaters
endscript

script JumpSkaterToNode
	GoalManager_DeactivateAllMinigames
	MakeSkaterGoto JumpToNode Params={NodeName=<NodeName> <...>}
endscript

script JumpToNode
	// Test for node existence so that Obj_MoveToNode does not assert
	if NodeExists <nodename>
		StopBalanceTrick
		SetSpeed 0
		if GotParam MoveUpABit
			Move y=10
		endif
		Obj_MoveToNode name = <nodename> Orient NoReset
		Goto GroundGone
	endif
endscript

// This is a speculative function to try deleting all
// the screen elements, and re-creating those that are needed.

script ScreenElementSystemCleanup
	printf "************ CLEANING UP SYSTEM ***************"
	if ObjectExists id=root_window
		DestroyScreenElement id=root_window
		ScreenElementSystemInit
		// bind the start key
		SetScreenElementProps {
			id=root_window
			event_handlers=[
				{pad_start			handle_start_pressed}
			]
			replace_handlers
			tags={menu_state=off}
		}

		// root window is always in focus
		FireEvent type=focus target=root_window
		//        load_panel_stuff
		create_panel_stuff
	endif
endscript

// @script | CreateLocal | this is a placeholder script
// that simply calls create for now
script CreateLocal
	create <...>
endscript

// @script | KillLocal | this is a placeholder script
// that simply calls kill for now
script KillLocal
	kill <...>
endscript

// K: This script gets called by the c-code for element3d when an element detects
// that the parent object it is attached to (if it is attached to one) has died.
script KillElement3d
	// Wait a bit to be safe.
	wait 1 gameframe
	Die
endscript

// @script | attach_arrow_to_object | this will attach an arrow
// (or whatever model you specify) to a ped and bounce it up and down
// @parm name | object_id | the name of the ped
// @parmopt name | arrow_id | | the id to use.
// @parmopt string | model | "Arrow" | the model to use
script attach_arrow_to_object model="Arrow"
	SetScreenElementLock id=root_window off
	CreateScreenElement {
		parent=root_window
		type=Element3D
		id=<arrow_id>

		model=<model>
		HoverParams={ Amp=10 Freq=2 }
		AngVelY=0.16
		ParentParams={ name=<object_id> (0, 100, 0) IgnoreParentsYRotation }
	}
endscript


// @script | attach_arrow_to_node | this will attach an arrow
// (or whatever model you specify) to a ped and bounce it up and down
// @parm name | node | the name of the ped
// @parmopt name | arrow_id | | the id to use.
// @parmopt string | model | "Arrow" | the model to use
// @parmopt vector | offset | (0, 100, 0) | the offset from the parent
script attach_arrow_to_node model="GoalArrow" offset=(0, 100, 0)
	SetScreenElementLock id=root_window off
	printstruct <...>
	CreateScreenElement {
		parent=root_window
		type=Element3D
		id=<arrow_id>

		model=<model>
		HoverParams={ Amp=10 Freq=2 }
		AngVelY=0.16
		ParentParams={ node=<node> <offset> IgnoreParentsYRotation }
	}
endscript


// *****************************************************************
// 			Ped speech box stuff
// *****************************************************************

// @script | setup_ped_speech | sets all the necessary exceptions to make a ped
// act like a goal pro.  if the skater slows down/stops close to the
// ped, a speech box will appear.  hitting pad_choose will then run the
// specified script
// @parm name | ped_id | the name of the object to set exceptions on
// (it will actually work on any game object, but normally this will be the id
// of the ped
// @parm string | text | the text to show in the speech box
// @parmopt name | pad_choose_script | ped_speech_exit | once the speech
// box appears, this script will run when pad_choose is pressed
// @parmopt structure | pad_choose_params | | params passed to pad_choose_script
// @parmopt name | pad_back_script | |
// @parmopt structure | pad_back_params | |
// @parmopt name | pad_circle_script | |
// @parmopt structure | pad_circle_params | |
// @parmopt name | pad_square_script | |
// @parmopt structure | pad_square_params | |
// @parmopt name | cam_anim | | the name of a camera animation to play
// while the ped is talking
// @parmopt int | inner_radius | 8 | the radius the skater must cross
// before the ped will speak at all.
// @parmopt int | outer_radius | 24 | the radius the skater must leave
// after talking to the ped before the ped will reactivate (unless the no_repeat flag
// is set)
// @parmopt name | outer_raduis_script | | script to run when skater leaves outer radius
// @parmopt structure | outer_radius_params | | params passed to outer_radius_script
// @parmopt int | speed | 20 | the ped will not talk unless the skater is
// going less than this speed
// @parmopt name | activation_script | | script run when the speech box is created
// @parmopt name | activation_script_params | | params to be passed to activation_Script
// @flag no_repeat | normally the ped will reset itself after the skater triggers the speech box
// so they can do it all over again.  If this speech box is a one-time event, the no_repeat
// flag will prevent this.
// @parmopt string | display_name | Ped | the name of the ped - used for the speech box that
// comes up when the skater gets close
script setup_ped_speech {
		inner_radius=8
		outer_radius=24
		speed=20
		pad_choose_script=ped_speech_exit
	}
	<ped_id>:Obj_ClearException SkaterInRadius
	<ped_id>:Obj_ClearException SkaterOutOfRadius
	<ped_id>:Obj_SetInnerRadius <inner_radius>
	<ped_id>:Obj_SetException ex=SkaterInRadius scr=ped_speech_got_trigger params=<...>
endscript

script ped_speech_got_trigger
	if ObjectExists id=ped_speech_dialog
		<should_destroy> = 0
		;if not Skater:OnGround
		;	<should_destroy> = 1
		;endif

		if Skater:IsInBail
			<should_destroy> = 1
		endif

		if not GoalManager_CanStartGoal
			<should_destroy> = 1
		endif

		if GoalManager_IsInCompetition
			<should_destroy> = 1
		endif

		if ( <should_destroy> = 1 )
			DestroyScreenElement id=ped_speech_dialog
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

		// bail out if we're not allowed to talk
		// to anyone at the moment
		if not GoalManager_CanStartGoal
			return
		endif

		if GoalManager_IsInCompetition
			return
		endif

		if Skater:OnGround
			if not Skater:IsInBail
				; Obj_ClearException SkaterInRadius

				Obj_SetOuterRadius <outer_radius>
				Obj_SetException ex=SkaterOutOfRadius scr=ped_speech_refuse params=<...>

				// pro name for display
				if not GotParam display_name
					<display_name> = "Ped"
				endif
				FormatText TextName=accept_text "%s: \m5 to talk." s=<display_name>

				if ObjectExists id=ped_speech_dialog
					DestroyScreenElement id=ped_speech_dialog
				endif

				create_speech_box {
					anchor_id=ped_speech_dialog
					text=<accept_text>
					no_pad_choose
					no_pad_start
					pad_circle_script=ped_speech_accept
					pad_circle_params=<...>
					bg_rgba=[100 100 100 128]
					text_rgba=[128 128 128 128]
					pos=(320, 400)
					font=small
					z_priority=5
				}
			endif
		endif
	endif
endscript

script ped_speech_accept
	; PauseSkaters
	speech_box_exit

	// has the ped been destroyed?
	if not ObjectExists <ped_id>
		return
	endif

	DeBounce X time=.5
	If Skater:OnGround    // If the skater is on ground
		if not SkaterCurrentScorePotGreaterThan 0
			wait 5 frame  // wait to make sure the skater isn't starting a trick
			if Skater:OnGround  // make sure skater still on ground (no preloaded tricks)
				ped_speech_accept2 <...>
			else
				If Not Skater:RightPressed
					If Not Skater:LeftPressed
						If Not Skater:UpPressed
							If Not Skater:DownPressed
								ped_speech_accept2 <...>
							endif
						endif
					endif
				endif
			endif
		endif
	else
		// Otherwise, he might be in the air and trying to do a grab
		If Not Skater:RightPressed
			If Not Skater:LeftPressed
				If Not Skater:UpPressed
					If Not Skater:DownPressed
						ped_speech_accept2 <...>
					endif
				endif
			endif
		endif
	endif
endscript

script ped_speech_accept2
	if not GameModeEquals is_singlesession
		GoalManager_DeactivateAllGoals
	endif
	; MakeSkaterGoto EndOfRun params={ FromTaxiGuy }
	PauseSkaters
	<ped_id>:Obj_ClearException SkaterInRadius
	; <ped_id>:Obj_ClearException SkaterOutOfRadius

	if ObjectExists id=ped_speech_dialog
		DestroyScreenElement id=ped_speech_dialog
	endif

	if GotParam activation_script
		Skater:Obj_SpawnScript <activation_script> params=<activation_script_params>
	endif

	if GotParam cam_anim
		PlaySkaterCamAnim name=<cam_anim>
	endif

	create_speech_box <...>
endscript

script ped_speech_refuse
	Obj_ClearException SkaterOutOfRadius
	speech_box_exit anchor_id=ped_speech_dialog
	; MakeSkaterGoto SkaterInit
	ped_speech_reset <...>
endscript

script ped_speech_set_outer_trigger_radius
	Obj_ClearException SkaterInRadius
	Obj_SetOuterRadius <outer_radius>
	Obj_SetException ex=SkaterOutOfRadius scr=ped_speech_reset params=<...>
endscript

script ped_speech_reset
	if GotParam outer_radius_script
		<outer_radius_script> <outer_radius_params>
	endif
	if not GotParam no_repeat
		setup_ped_speech <...>
	endif
endscript

script ped_speech_exit
	UnPauseSkaters
	; MakeSkaterGoto SkaterInit
	speech_box_exit
endscript


// ********************************************
// 		Screen Element Stacking Utilities
// ********************************************
script GetStackedScreenElementPos
	if GotParam XY
		GetStackedScreenElementPosOnXY <...>
	else
		if GotParam X
			if GotParam Y
				GetStackedScreenElementPosOnXY <...>
			else
				GetStackedScreenElementPosOnX <...>
			endif
		else
			if GotParam Y
				GetStackedScreenElementPosOnY <...>
			else
				script_assert "GetStackedScreenElementPos called without an axis"
			endif
		endif
	endif
	return pos=<pos>
endscript

script GetStackedScreenElementPosOnX
	GetScreenElementPosition id=<id>
	GetScreenElementDims id=<id>
	<unit_pair> = (1, 0)
	if GotParam negative
		<unit_pair> = (-1, 0)
	endif
	if GotParam offset
		return pos = ( <ScreenElementPos> + ( <unit_pair> * <width> + <offset> ) )
	else
		return pos = ( <ScreenElementPos> + ( <unit_pair> * <width> ) )
	endif
endscript

script GetStackedScreenElementPosOnY
	GetScreenElementPosition id=<id>
	GetScreenElementDims id=<id>
	<unit_pair> = (0, 1)
	if GotParam negative
		<unit_pair> = (0, -1)
	endif
	if GotParam offset
		return pos = ( <ScreenElementPos> + ( <unit_pair> * <height> + <offset> ) )
	else
		return pos = ( <ScreenElementPos> + ( <unit_pair> * <height> ) )
	endif
endscript

script GetStackedScreenElementPosOnXY
	GetScreenElementPosition id=<id>
	GetScreenElementDims id=<id>
	<x_unit_pair> = (1, 0)
	<y_unit_pair> = (0, 1)
	if GotParam negative
		<x_unit_pair> = (-1, 0)
		<y_unit_pair> = (0, -1)
	endif
	if GotParam offset
		return pos = ( <ScreenElementPos> + ( <y_unit_pair> * <height> + <x_unit_pair> * <width> + <offset> ) )
	else
		return pos = ( <ScreenElementPos> + ( <y_unit_pair> * <height> + <x_unit_pair> * <width> ) )
	endif
endscript


// @script | kill_blur | kill any pulsing blur
// and set blur value to zero
script kill_blur
	if Not InSplitScreenGame
		KillSpawnedScript Name = pulse_blur_script_down
		KillSpawnedScript Name = pulse_blur_script_up
		SetScreenBlur <start>
	endif
endscript

// @script | pulse_blur | start the screen blur at a start value
// and change it to the end value at a specified speed
// This gives us a nice full screen effect, blurring and then back to normal (with default)
// you can get various effects by varying the parameters
// Screen blur values go from 0 (no blur) through 128 (50/50 previous frame plus this frame)
// to 255 (just the previous frame, which gets darkened to 50% in current PS2 implementation)
// @parm name | object_id | the name of the ped
// @parmopt int | start | 200 | Start Value for Blur range 0..255
// @parmopt int | end | 0 | End Value for Blur, range 0.255
// @parmopt int | speed | 4 | change in blur per frame as we go from start to end

script pulse_blur start=200 end = 0 speed = 4
	KillSpawnedScript Name = pulse_blur_script_down
	KillSpawnedScript Name = pulse_blur_script_up
	if (<start> > <end>)
		SpawnScript pulse_blur_script_down params=<...>
	else
		SpawnScript pulse_blur_script_up params=<...>
	endif
endscript

// @script | pulse_blur_script_down | Spawned script used by pulse_blur
script pulse_blur_script_down
	if GotParam force_pulse
		begin
			if (<start> < <end>)
				SetScreenBlur <end>
				break
			endif
			SetScreenBlur <start>
			<start> = (<start>-<speed>)
			wait 1 gameframe
		repeat
		Return
	endif
	if Not InSplitScreenGame
		begin
			if (<start> < <end>)
				SetScreenBlur <end>
				break
			endif
			SetScreenBlur <start>
			<start> = (<start>-<speed>)
			wait 1 gameframe
		repeat
	endif
endscript

// @script | pulse_blur_script_up | Spawned script used by pulse_blur
script pulse_blur_script_up
	if GotParam force_pulse
		begin
			if (<start> > <end>)
				SetScreenBlur <end>
				break
			endif
			SetScreenBlur <start>
			<start> = (<start>+<speed>)
			wait 1 gameframe
		repeat
		Return
	endif
	if Not InSplitScreenGame
		begin
			if (<start> > <end>)
				SetScreenBlur <end>
				break
			endif
			SetScreenBlur <start>
			<start> = (<start>+<speed>)
			wait 1 gameframe
		repeat
	endif
endscript

Script NullScript
Endscript


script BloodOff
endscript

script mark_first_input_received
	printf "mark_first_input_received"
	GetCurrentSkaterProfileIndex
	GetSkaterId
	; printf "profile index: %s" s=<currentSkaterProfileIndex>
	if GotParam device_num
		<controller_index> = <device_num>
		; printf "device_num: %i" i=<device_num>
	else
		<controller_index> = <controller>
		; printf "controller: %i" i=<controller>
	endif
	BindControllerToSkater skater_heap_index=<currentSkaterProfileIndex> controller=<controller_index>
	FirstInputReceived
	change check_for_unplugged_controllers = 1
endscript



// @script | lighting |  Set up various lighting parameters, including the fake scene lights
// @parmopt int | target | 0x808080 | IGNORED target color in BGR format IGNORED
// @parmopt float | percent | 0 | IGNORED percent to compress vertex colors towards this, so zero would have no effect IGNORED
// @parmopt float | lights | nothing | percent to apply fake lights by, for creating pools of light
// @parmopt int | color | nothing | ambient color to set the world to
// @parmopt	int | sky | color | ambient color to set the sky to.
// @parmopt	name | id | nothing | name or checksum of levellight node to affect
// @parmopt	name | prefix | TRG_LevelLight | porefix of levellight nodes to affect. By default calls will affect all nodes with the TRG_levellight prefix
// @parmopt name | lightgroup | nothing | name of light group for SceneColor and CompressVC, does not apply to FakeLights
script lighting target=0x808080 percent = 0
	// We always ned to start with a "CompressVC, to ensure the original vert colors are stored
	// Mick: Removed calls to CompressVC, as we don't use it, as it takes too much memory
	//    CompressVC target=<target> percent=<percent> lightgroup = <lightgroup>
	// Lights will have been reset by the above, so setting them is optional
	if GotParam lights
		If GotParam id
			FakeLights percent=<lights> id=<id> prefix=<prefix>
		else
			If GotParam Prefix
				FakeLights percent=<lights> prefix=<prefix>
			else
				FakeLights percent=<lights> prefix=TRG_LevelLight
			endif
		endif
	endif
	// color is independent, but we allow you to set it
	// here, to keep it all in one function
	if GotParam color
		if not GotParam sky
			<sky> = <color>
		endif
		SetSceneColor color=<color> sky=<sky> lightgroup = <lightgroup>
	endif
endscript

Script  DumpMetrics
	GetMetrics
	printf
	printf "Dumping Metrics Structure"
	PrintStruct <...>
endscript

// destroy and recreat an object
Script recreate
	if Objectexists id=<id>
		<id>:die
	endif
	create name=<id>
Endscript


dummy_metrics_struct = {
	mainscene=0
	skyscene=0
	metrics=0

	Sectors=0
	ColSectors=0
	Verts=0
	BasePolys=0
	TextureMemory=0

}


// This is just a test structure, used for when programmers want to programatically
// set up a model component
test_letter_a = {
	model = "gameobjects\skate\letter_a\letter_a.mdl"
}


// A ProximObj is created just for the purpose of running a script,
// which generally can play a positional sound
proximobj_composite_structure = [
	{ component = sound }
	{ component = stream }
]

gameobj_composite_structure = [
	{ component = suspend}
	{ component = motion}
	{ component = skaterproximity}
	{ component = sound }
	//    { component = lockobj }
]


// another one for the bouncy objects, while they are still kind of being made from code
bouncy_composite_structure = [
	{ component = suspend }
	{ component = rigidbody }
	{ component = model  }
	{ component = sound }
	//	{ component = input controller = 0}
]

// particle object definition
particle_composite_structure = [
	{ component = suspend }
	{ component = particle }
]

// moving particle object definition
moving_particle_composite_structure = [
	{ component = suspend }
	{ component = motion}
	{ component = particle }
]


// This is for camera's that watch the skater
skatercam_composite_structure = [
	{ component = cameralookaround }
	{ component = skatercamera }
	{ component = walkcamera }
	{ component = camera }
	;{ component = proximtrigger }
	{ component = input }
]

viewercam_composite_structure = [
	{ component = camera }
	;{ component = proximtrigger }
	// { component = model }
]

parkedcam_composite_structure = [
	{ component = camera }
]

menucam_composite_structure =
[
	{component = camera}
	;{component = proximtrigger ProximTriggerTarget = Skater}
]

explosion_composite_structure =
[
	{ component = suspend }
	{ component = particle }
]

fireball_composite_structure =
[
	//{ component = velocity vel=(0, 24, 0) }
	{ component = velocity }
	{ component = suspend }
	//{ component = model Model="fireball\\fireball.mdl" }
	{ component = collideanddie }
	//{ component = collision }
	{ component = particle }
]

server_fireball_composite_structure =
[
	//{ component = velocity vel=(0, 24, 0) }
	{ component = velocity }
	{ component = suspend }
	//{ component = model Model="fireball\\fireball.mdl" }
	{ component = projectilecollision }
	{ component = collideanddie }

	//{ component = collision }
	{ component = particle }
]

script Restore_skater_camera

	if IsObserving  // sometimes there's no skater, like in xbox when you join a game in observer mode
		SetActiveCamera Id=SkaterCam0
	else
		// this function is now called when autolaunching into
		// the skateshop (before the skater is created, and
		// before the levelIs name has been set), so we
		// don't want to check for Skater:Driving...
		if not LocalSkaterExists
			SetActiveCamera Id=SkaterCam0
		else
			if not Skater:Driving
				SetActiveCamera Id=SkaterCam0
			else
				SetActiveCamera Id=PlayerVehicleCamera
			endif
		endif
	endif

	// the skater cams potentially disabled the scaling on the skater
	// so we restore it here...  (don't touch it in the frontend levels
	// because the cas menus use skatercams to preview the scaling)
	if not LevelIs load_skateshop
		if not LevelIs load_cas
			if not LevelIs load_boardshop
				if not IsObserving  // sometimes there's no skater, like in xbox when you join a game in observer mode
					// this function is now called when autolaunching into
					// the skateshop (before the skater is created, and
					// before the levelIs name has been set), so we
					// don't want to check for Skater:Driving...
					if LocalSkaterExists
						Skater:Obj_EnableScaling
					endif
				endif
			endif
		endif
	endif
endscript

script disable_skater_scaling
	// GJ:  The camera may not be framed properly if the skater was
	// scaled up, so the following script will shut off the scaling on
	// the skater...   (don't touch it in the frontend levels
	// because the cas menus use skatercams to preview the scaling)
	if not LevelIs load_skateshop
		if not LevelIs load_cas
			if not LevelIs load_boardshop
				if not IsObserving  // sometimes there's no skater, like in xbox when you join a game in observer mode
					// GJ FIX FOR SK5:TT13313:  "Cheats-When playing kid
					// mode, you're the only one as kid and then switches"
					// (we don't want to turn off scaling if we've got the
					// cheat mode)
					if not GetGlobalFlag flag=CHEAT_KID
						Skater:Obj_DisableScaling
					endif
				endif
			endif
		endif
	endif
endscript

// Creates the camera used by the view-gaps menu
script create_menu_camera
	if not ObjectExists id=menu_cam
		// put it on the front end heap,
		// or else it will fragment memory
		// in the boardshop (because it
		// gets allocated after the unloadable
		// textures)
		MemPushContext FrontEndHeap
		printf "Creating camera on front end heap"
		CreateCompositeObject {
			Components=menucam_composite_structure
			Params={Name=menu_cam}
		}
		MemPopContext
	endif
endscript

// The following three scripts are temporary for single player
// need to actually have a function that will get the id of the current skater's camera
// and call the functions on that

script  SetSkaterCamOverride
	skatercam0:SC_SetSkaterCamOverride <...>
endscript

script  ClearSkaterCamOverride
	skatercam0:SC_ClearSkaterCamOverride <...>
endscript

script  ShakeCamera
	skatercam0:SC_ShakeCamera  <...>
endscript

script	empty_script
endscript

script HideSkaterAndMiscSkaterEffects
	KillAllTextureSplats
	skater:SparksOff

	// This has the effect of switching off the bail board
	Skater:SwitchOnBoard

	Skater:RemoveSkaterFromWorld
endscript

// The folowing scripts are temp version of old thngs that have been removed
// and may or may not be needed

script SwitchToMenu
	printf "SwitchToMenu"
endscript


script  ResetLookAround
	printf "ResetLookAround is not currently working....."
endscript

script toggle_framerate
	switch lock_framerate
		case 0
			change lock_framerate = 2
		case 1
			change lock_framerate = 2
		case 2
			change lock_framerate = 1		// just go between 1 and 2
	endswitch
endscript

// Given an object and an offset, this will return the world position offset from the object,
// taking into account the object's rotation.
// The position is returned as a vector called pos.
script CalcPosRelative ob=skater dx=0 dy=0 dz=0
	<ob>:Obj_GetPosition

	<ob>:Obj_GetOrientation
	unit_z=((1,0,0)*<x>+(0,1,0)*<y>+(0,0,1)*<z>)

	unit_x=((0,1,0)*<unit_z>)
	; TODO: Need to normalise unit_x now ...

	unit_y=(<unit_z>*<unit_x>)

	pos=(<pos>+<dx>*<unit_x>+<dy>*<unit_y>+<dz>*<unit_z>)
	return x=(<pos>.(1,0,0)) y=(<pos>.(0,1,0)) z=(<pos>.(0,0,1)) pos=<pos>
endscript

script Forced_Create
	if GotParam prefix
		kill prefix = <prefix>
		create prefix = <prefix>
	else
		if GotParam name
			if NodeExists <name>
				kill name = <name>
				create name = <name>
			else
				printf"### Forced_Create: %n does not exist" n = <name>
			endif
		else
			printf"### Forced_Create: Must specifiy a name or prefix"
		endif
	endif
endscript


////////////////////////////////////////

// Load the special tricks for the skater specified in the global skater_special_index
// left here for education purposes
script loadspecial
	//        load_special_anims LoadFunction = find_special_name
endscript

skater_special_index = 0

// This script is a "LoadFunction"  and will get passed descChecksum and name, like
// 		<LoadFunction> <...> name="anims\THPS5_skater_special\_2KickMadonnaFlip_Out.ska" descChecksum=_2KickMadonnaFlip_Out
//
// we can check the "descChecksum" against the
script find_special_name
	/*
	<orig_name>=<name>
    GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=skater_special_index
	<index> = 0
    if ( <max_specials> > 0 )
        begin
            GetSpecialTrickInfo index=<index>
            <trick> = <special_trickname>
            if StructureContains structure=<trick> params
                <paramx> = ( <trick>.params )

                if StructureContains structure=<paramx> anim
                    <anim> = ( <paramx>.anim )
                    if (<descChecksum> = <anim>)
                        printf "anim = %s" s=<orig_name>
                        //PrintStruct <special_trickname>
                    endif
                endif

                if StructureContains structure=<paramx> idle
                    <anim2> = ( <paramx>.idle )
                    if (<descChecksum> = <anim2>)
                        printf "Idle = %s" s=<orig_name>
                    endif
                endif

                if StructureContains structure=<paramx> OutAnim
                    <anim3> = ( <paramx>.OutAnim )
                    if (<descChecksum> = <anim3>)
                        printf "OutAnim = %s" s=<orig_name>
                    endif
                endif

                if StructureContains structure=<paramx> BackwardsAnim
                    <anim> = ( <paramx>.BackwardsAnim )
                    if (<descChecksum> = <anim>)
                        printf "BackwardsAnim = %s" s=<orig_name>
                    endif
                endif
            endif


            // after the usual anim names, we allow the designer to specify
            // some special anims in an array
            // this is useful for when the playing of a special anim is triggered by a
            // script that does not take the above format (anim, initanim, etc)
            // the special grinds use this exclusivly, as they have the "template" stuff
            // for FS/BS, and the anim names are deep within some later scripts
            if StructureContains structure=<trick> specialanims
                <specialanims> = ( <trick>.specialanims )
                // Iterate
                //PrintStruct <specialanims>

                GetArraySize <specialanims>
                <index2> = 0
                begin
                    if (<descChecksum> = (<specialanims>[<index2>]))
                        printf "Special Anim = %s" s=<orig_name>
                    else
                     //   printf "%a not %b" a=<descChecksum> b = (<specialanims>[<index>])
                    endif
                    <index2> = ( <index2> + 1 )
                repeat <array_size>
            endif

            <index> = ( <index> + 1)
        repeat <max_specials>
    endif
*/
endscript



// Scripts for loading and unloading permanent, uinloadable and net anims
// and keeping track of what is loaded

// each load script will ensure that the appropiate set of things are loaded before
// it does the load
// so we should never have to keep track of this externally

have_loaded_permanent = 0
have_loaded_unloadable = 0
have_loaded_net = 0

script do_load_permanent
	//	printf "**************************** do_load_permanent"

	if (have_loaded_permanent)
		// already loaded
	else
		if IsNGC
			// Note that the pre is put on the bottom up heap to prevent it creating a hole
			// above the anims on the top down heap when it is unloaded.
			LoadPreFile "anims.pre"
			PushMemProfile  "Permanent Anims"
			MemPushContext TopDownHeap
			load_permanent_anims
			MemPopContext
			PopMemProfile  //"Permanent Anims"
			UnloadPreFile "anims.pre"
		else
			do_unload_unloadable
			PushMemProfile  "Permanent Anims"
			MemPushContext TopDownHeap
			//  		printf "+++++++++++++++= LoadPipPre anims.pre"
			SetDefaultPermanent 1	  		// GJ TODO:  see GJ note below
			LoadPipPre "anims.pre"
			load_permanent_anims use_pip
			SetDefaultPermanent 0	  		// GJ TODO:  see GJ note below
			MemPopContext
			PopMemProfile  //"Permanent Anims"
		endif
		change	have_loaded_permanent=1
	endif
endscript

script	do_unload_permanent
	//	printf "**************************** do_unload_permanent"

	if not IsNGC
		if (have_loaded_permanent)
			load_permanent_anims LoadFunction=UnloadAnim
			printf " ------------------ UnloadPipPre anims.pre"
			if not UnloadPipPre "anims.pre"
				script_assert "couldn't unload pip pre"
			endif
			change	have_loaded_permanent=0
		endif
	endif
endscript

// load either the "loadable" or "net" anims based on game type
// if "net", then unload the "perm" anims first
// if "unloadable" then ensure the "perm" anims are actually loaded
script do_load_unloadable load_peds=1
	printf "**************************** do_load_unloadable"

	if InNetGame
		load_peds=0
	endif

	if (<load_peds> = 1)
		if (have_loaded_unloadable)
			// already loaded
		else
			if (have_loaded_net)
				do_unload_unloadable			// ensure the net anims are NOT loaded
			endif

			do_load_permanent				// ensure permanent anims are loaded first
			// Now load the anims back in.
			if IsNGC
				LoadPreFile "unloadableanims.pre"
				PushMemProfile  "Unloadable Anims"
				MemPushContext TopDownHeap
				load_unloadable_anims
				MemPopContext
				PopMemProfile  //"Unloadable Anims"
				UnloadPreFile "unloadableanims.pre"
			else
				PushMemProfile "Unloadable Anims"
				MemPushContext TopDownHeap
				//  			printf "++++++++++++++++ LoadPipPre unloadableanims.pre"
				LoadPipPre "unloadableanims.pre"
				SetDefaultPermanent 1	  		// GJ TODO:  I want the "load_unloadable_anims"
				// function to set this flag, but because
				// other functions call "load_unloadable_anims"
				// also, there's no good place to turn off the
				// flag (ideally, we would push the default
				// permanent state, and then pop it rather
				// than setting it explicitly to 1 and 0
				load_unloadable_anims use_pip
				SetDefaultPermanent 0
				MemPopContext
				PopMemProfile
			endif

			// invalidates all the CBonedAnimFrameData pointers inside NxQuickAnim
			RunScriptOnComponentType component=animation target=InvalidateCache params={}
			change	have_loaded_unloadable=1
		endif
	else
		if not IsNGC
			if (have_loaded_net)
				// already loaded
			else
				if (have_loaded_unloadable)
					do_unload_unloadable			// ensure the unloadable anims are NOT loaded
				endif
				do_unload_permanent				// ensure permanent anims unloaded
				// Now load the anims back in.
				PushMemProfile "Net Anims"
				MemPushContext TopDownHeap
				//  			printf "+++++++++++++++== LoadPipPre Netanims.pre"
				LoadPipPre "Netanims.pre"
				SetDefaultPermanent 1	  		// GJ TODO:  I want the "load_unloadable_anims"
				// function to set this flag, but because
				// other functions call "load_unloadable_anims"
				// also, there's no good place to turn off the
				// flag (ideally, we would push the default
				// permanent state, and then pop it rather
				// than setting it explicitly to 1 and 0
				load_net_anims use_pip
				SetDefaultPermanent 0
				// invalidates all the CBonedAnimFrameData pointers inside NxQuickAnim
				RunScriptOnComponentType component=animation target=InvalidateCache params={}
				MemPopContext
				PopMemProfile
				change	have_loaded_net=1
			endif
		endif
	endif
endscript

script	do_unload_unloadable
	//	printf "**************************** do_unload_unloadable"

	if not IsNGC
		if (have_loaded_unloadable)
			load_unloadable_anims LoadFunction=UnloadAnim
			//  		printf "---------------------- UnloadPipPre unloadableanims.pre"
			if not UnloadPipPre "unloadableanims.pre"
				script_assert "couldn't unload pip pre"
			endif
			change	have_loaded_unloadable = 0
		endif
		if (have_loaded_net)
			load_net_anims LoadFunction=UnloadAnim
			//  		printf "------------------------UnloadPipPre netanims.pre"
			if not UnloadPipPre "netanims.pre"
				script_assert "couldn't unload pip pre"
			endif
			change	have_loaded_net = 0
		endif
	endif
endscript

script what_is_loaded
	if (have_loaded_permanent)
		printf "PERMANENT"
	endif
	if (have_loaded_unloadable)
		printf "UNLOADABLE"
	endif
	if (have_loaded_net)
		printf "NET"
	endif
endscript

script fireball_death
	// Firefight_DeathFireball_Sound

	CreateCompositeObject {
		Components=explosion_composite_structure
		Params={
			pos=<pos>
			vel=<vel>
			orient_to_vel
			scale=<scale>
			//radius=<radius>
			LocalSpace
			UseStartPosition
			NoName
			SystemLifetime = 400

			NeverSuspend
			StartPosition = (0, 0, -50)
			BoxDimsStart = (20.220463,20.220463,20.220463)
			MidPosition = (0.654093,-0.767708,0.417743)
			BoxDimsMid = (74.374347,74.374347,74.374347)
			EndPosition = (-0.947293,-0.834141,-0.782787)
			BoxDimsEnd = (227.087860,227.087860,227.087860)
			Texture = dt_nj_flame02
			CreatedAtStart
			AbsentInNetGames
			UseMidPoint
			UseColorMidTime
			Type = NEWFLAT
			BlendMode = Add
			FixedAlpha = 128
			AlphaCutoff = 0
			//	UpdateScript = ?	// Undefined (Not in scripts.ini)
			MaxStreams = 2
			SuspendDistance = 0
			lod_dist1 = 400
			lod_dist2 = 401
			EmitRate = 30.0
			Lifetime = 0.3
			MidPointPCT = 50
			StartRadius = 20.0
			MidRadius = 100.0
			EndRadius = 6.0
			StartRadiusSpread = 0.0
			MidRadiusSpread = 0.0
			EndRadiusSpread = 10.0
			StartRGB = [255,111,54]
			StartAlpha = 129
			ColorMidTime = 50
			MidRGB = [135,35,0]
			MidAlpha = 133
			EndRGB = [0,0,0]
			EndAlpha = 51					 }
	}
	//printf "fireball death"
endscript

script ClientLaunchFireball
	if Not GameModeEquals is_firefight
		return
	endif



	TheParams={ owner_id = <owner_id>
		pos=( <x> * ( 1, 0, 0 ) + <y> * ( 0, 1, 0 ) + <z> * ( 0, 0, 1 ) )
		vel=( <scaled_x> * ( 1, 0, 0 ) + <scaled_y> * ( 0, 1, 0 ) + <scaled_z> * ( 0, 0, 1 ) )
		orient_to_vel
		scale=<scale>
		radius=<radius>
		LocalSpace
		UseStartPosition
		NoName
		SystemLifetime = 10000
		NeverSuspend
		death_script=fireball_death
		StartPosition = (0, 0, 0)
		BoxDimsStart = (3.339594,3.339594,3.339594)
		MidPosition = (-0.101934,2.326138,-75.072464)
		BoxDimsMid = (10.168470,10.168470,10.168470)
		EndPosition = (-1.168471,1.351739,-301.166504)
		BoxDimsEnd = (2.507714,2.507714,2.507714)
		Texture = dt_nj_flame02
		CreatedAtStart
		AbsentInNetGames
		UseMidPoint
		UseColorMidTime
		Type = NEWFLAT
		BlendMode = Add
		FixedAlpha = 128
		AlphaCutoff = 0
		//	UpdateScript = ?	// Undefined (Not in scripts.ini)
		MaxStreams = 2
		SuspendDistance = 0
		lod_dist1 = 400
		lod_dist2 = 401
		EmitRate = 30.0
		Lifetime = 0.75
		MidPointPCT = 50
		StartRadius = 20.0
		MidRadius = 20.0
		EndRadius = 5.0
		StartRadiusSpread = 0.0
		MidRadiusSpread = 0.0
		EndRadiusSpread = 10.0
		StartRGB = [54,97,255]
		StartAlpha = 129
		ColorMidTime = 50
		MidRGB = [135,35,0]
		MidAlpha = 27
		EndRGB = [0,0,0]
		EndAlpha = 0
	}


	if OnServer
		CreateCompositeObject {
			Components=server_fireball_composite_structure
			Params=<TheParams>
		}
	else
		CreateCompositeObject {
			Components=fireball_composite_structure
			Params=<TheParams>
		}
	endif

	// want this sound to emit from skaters as they are shooting
	// so that other clients will hear other skaters shooting,
	// just as they hear other skaters skating, etc..
	Obj_PlaySound FlamingFireBall01 vol=(130 + <scale>*15)  pitch=(190 - <scale>*7) dropoff = 140

endscript

script LaunchFireball vel_scale=1.0
	if Not GameModeEquals is_firefight
		return
	endif
	GetFireballLevel
	point_scale = 3
	switch <level>
		case 1
			point_scale = 1
		case 2
			point_scale = 5
		case 3
			point_scale = 25
		case 4
			point_scale = 100
		case 5
			point_scale = 250
	endswitch

	GetSkaterPosition
	scaled_vel = (<vel_scale>*5000.0)
	GetSkaterVelocity scale=<scaled_vel> <...>
	if CurrentScorePotGreaterThan ( 20000 * <point_scale> )
		radius = 400
		scale = 10.0
	else
		if CurrentScorePotGreaterThan ( 10000 * <point_scale> )
			radius = 200
			scale = 5.0
		else
			if CurrentScorePotGreaterThan ( 5000 * <point_scale> )
				radius = 100
				scale = 3.5
			else
				if CurrentScorePotGreaterThan ( 2500 * <point_scale> )
					radius = 75
					scale = 2.5
				else
					if CurrentScorePotGreaterThan ( 750 * <point_scale> )
						radius = 60
						scale = 2.0
					else
						if CurrentScorePotGreaterThan ( 250 * <point_scale> )
							radius = 45
							scale = 1.5
						else
							radius = 24
							scale = 1.0
						endif
					endif
				endif
			endif
		endif
	endif

	new_y = (<y>)
	<y> = <new_y>
	GetCurrentSkaterId
	if InNetGame
		BroadcastProjectile objID=<objID> type=fireball scale=<scale> radius=<radius> pos=( <x> * ( 1, 0, 0 ) + <new_y> * ( 0, 1, 0 ) + <z> * ( 0, 0, 1 ) ) vel=( <scaled_x> * ( 1, 0, 0 ) + <scaled_y> * ( 0, 1, 0 ) + <scaled_z> * ( 0, 0, 1 ) )
	endif

	GetCurrentSkaterID

	ClientLaunchFireball owner_id=<objID> <...>
endscript

script SetObjectColor_CurrentTOD
	switch current_tod
		case morning
			set_tod_morning
		case day
			set_tod_day
		case evening
			set_tod_evening
		case night
			set_tod_night
		default
			printf"NO TOD SET TO SWITCH BACK TO"
	endswitch
	/*if (current_tod = morning)
		set_tod_morning
	else
		if (current_tod = day)
			set_tod_day
		else
			if (current_tod = evening)
				set_tod_evening
			else
				if (current_tod = night)
					set_tod_night
				endif
			endif
		endif
	endif*/
	SetObjectColor <...> color = (lev_red+(lev_green*256)+(lev_blue*65536))
endscript

script KillCreateSponsorGeo
	GoalManager_GetSponsor

	if gotparam sponsor_kill_prefix
		kill prefix=<sponsor_kill_prefix>
	else
		printf " >>>>>>>> WARNING: NO GEO PREFIX SENT TO KillCreateSponsorGeo >>>>>>>>>>> "
		return
	endif
	// we have some geo that is there at the start, but replaced after you get a sponsor
	If GotParam nosponsor_prefix
		kill prefix=<nosponsor_prefix>
	endif
	//printf "sponsor = %s" s=<sponsor>
	switch <sponsor>
		case sponsor_birdhouse
			Printf "I'm on Birdhouse!"
			create prefix=<sponsor_birdhouse_prefix>
		case sponsor_element
			Printf "I'm on Element!"
			create prefix=<sponsor_element_prefix>
		case sponsor_flip
			Printf "I'm on Flip!"
			create prefix=<sponsor_flip_prefix>
		case sponsor_girl
			Printf "I'm on Girl!"
			create prefix=<sponsor_girl_prefix>
		case sponsor_zero
			Printf "I'm on Zero!"
			create prefix=<sponsor_zero_prefix>
		default
			// if we're not sponsored, but the coverup geo back in
			If GotParam nosponsor_prefix
				create prefix=<nosponsor_prefix>
			endif
	endswitch
endscript

script GetNetworkNumPlayers
	GetPreferenceChecksum pref_type=network num_players
	switch <checksum>
		case num_2
			return num_players=2
		case num_3
			return num_players=3
		case num_4
			return num_players=4
		case num_5
			return num_players=5
		case num_6
			return num_players=6
		case num_7
			return num_players=7
		case num_8
			return num_players=8
		default
			return num_players=1
	endswitch
endscript

