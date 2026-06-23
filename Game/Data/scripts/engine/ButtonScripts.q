// start autoduck documentation
// @DOC buttonscripts
// @module buttonscripts | None
// @subindex Scripting Database
// @index script | buttonscripts

select_shift        = 1                // defautl to 1, so we can QBR this file
memcard_screenshots = 0                // memorycard screenshots can be enabled here
control_scheme      = 1                // 0 = Xbox, 1 = PS2 (default; single-trigger acid drop + GrindRelease)
tweak_keep_balance  = 0                // 0 = original THUG (balance meter resets on Manual<->NoseManual / Grind<->Slide), 1 = keep meter
tweak_wallplant_easy = 0               // 0 = original THUG wallplant (Down + X), 1 = wallplant on just X

skater_cam_0_mode   = 2
skater_cam_1_mode   = 2

// @script | UserSelectSelect | pressed select
script UserSelectSelect
	// printf "You pressed Select"
	if not isngc
		if ObjectExists id = skatercam0
			switch skater_cam_0_mode
				case 1
					change skater_cam_0_mode = 2
				case 2
					change skater_cam_0_mode = 3
				case 3
					change skater_cam_0_mode = 4
				case 4
					change skater_cam_0_mode = 1
			endswitch
			skatercam0:sc_setmode mode=skater_cam_0_mode
		endif
	endif
endscript

// @script | UserSelectSelect2 | pressed select 2
script UserSelectSelect2
	//printf "You pressed Select 2"
	if not isngc
		if ObjectExists id = skatercam1
			switch skater_cam_1_mode
				case 1
					change skater_cam_1_mode = 2
				case 2
					change skater_cam_1_mode = 3
				case 3
					change skater_cam_1_mode = 4
				case 4
					change skater_cam_1_mode = 1
			endswitch
			skatercam1:sc_setmode mode=skater_cam_1_mode
		endif
	endif
endscript


view_mode      = 0
render_mode    = 0
wireframe_mode = 0

drop_in_car       = 0
drop_in_car_setup = MiniBajaCarSetup

//////////////////////////////////////////////////
// if select is acting as a shift button, then the following will be called

// @script | UserSelectTriangle | pressed triangle - select acting as shift
script UserSelectTriangle
	If NotCD

		//    ToggleRenderMode
		switch render_mode
			case 0
				change render_mode = 1
				show_wireframe_mode
			case 1
				change render_mode = 2
				show_wireframe_mode
			case 2
				change render_mode = 0
		endswitch
		setRenderMode mode = render_mode

	endif
endscript

// @script | UserSelectSquare | pressed square - select acting as shift
script UserSelectSquare
	If NotCD
		ScreenShot
	endif
endscript

// @script | UserSelectCircle | pressed circle - select acting as shift
script UserSelectCircle
	If NotCD

		if  (render_mode)
			switch wireframe_mode
				case 0
					change wireframe_mode = 1
				case 1
					change wireframe_mode = 2
				case 2
					change wireframe_mode = 3
				case 3
					change wireframe_mode = 4
				case 4
					change wireframe_mode = 5
				case 5
					change wireframe_mode = 6
				case 6
					change wireframe_mode = 0
			endswitch
			setwireframemode mode=wireframe_mode
			show_wireframe_mode
		else

			; Launch the game (formerly toggled the skater)
			;ReloadNodeArray
			;Retry

			if Skater:Driving
				ToggleUserControlledVehicleMode
			endif

			UnpauseSkaters 0

			if (drop_in_car = 0)
				;Drop the skater in front of the camera and switch to skate-around mode
				Skater:PlaceBeforeCamera
				; Move the Skater's camera to this position
				; Back to skating around
				Restore_skater_camera

				change view_mode = 0
				ToggleViewMode
				ToggleViewMode
				ToggleViewMode
			else
				// Added by Dan as quick hack for Darren
				MakeSkaterGoto Switch_OnGroundAI Params={ NewScript=TransAm VehicleSetup=drop_in_car_setup edited_goal }
				SetActiveCamera Id=viewer_cam
				PlayerVehicle:Vehicle_PlaceBeforeCamera

				change view_mode = 0
				ToggleViewMode
				ToggleViewMode
				ToggleViewMode

				SetActiveCamera Id=PlayerVehicleCamera
				Skater:PausePhysics
			endif
		endif
	endif
endscript

// @script | UserSelectStart | pressed start - select acting as shift
Script UserSelectStart
	; ResetEngine
	If NotCD

		change render_mode = 0
		setRenderMode mode = render_mode
		TogglePass pass=0
	endif

endscript

// @script | ToggleViewMode | Cycle through the view modes
script ToggleViewMode
	switch view_mode
		case 0
			change view_mode = 1
		case 1
			change view_mode = 2
		case 2
			change view_mode = 0
	endswitch
	SetViewMode view_mode
endscript


// @script | UserSelectX | pressed x - select acting as shift
script UserSelectX
	// reset the viewer angle back to default
	change viewer_rotation_angle=0
	ToggleViewMode
endscript

// @script | UserSelectL2 | pressed L2 - select acting as shift
// script UserSelectL2
// ToggleUserControlledVehicleMode
// endscript

viewer_rotation_angle=0

script  UserViewerX
	// angled view of exported geo
	// pressing X repeatedly will rotate about the Y axis in 90 degree increments
	if (viewer_rotation_angle=0)
		change viewer_rotation_angle=1
		CenterCamera scale=.5 y=-45
	else
		if (viewer_rotation_angle=1)
			CenterCamera scale=.5 y=-135
			change viewer_rotation_angle=2
		else
			if (viewer_rotation_angle=2)
				change viewer_rotation_angle=3
				CenterCamera scale=.5 y=-225
			else
				if (viewer_rotation_angle=3)
					change viewer_rotation_angle=0
					CenterCamera scale=.5 y=-315
				endif
			endif
		endif
	endif
	//printf "viewer_rotation_angle=%v" v=viewer_rotation_angle
endscript

script  UserViewerSquare
	// side view of exported geo
	// pressing square repeatedly will rotate about the Y axis in 90 degree increments
	// note, for simplicity, this shares the same global variables as the X button view angles
	if (viewer_rotation_angle=0)
		change viewer_rotation_angle=1
		CenterCamera  x = -10 y = -90 scale = 0.7
	else
		if (viewer_rotation_angle=1)
			CenterCamera  x = -10 y = -180 scale = 0.7
			change viewer_rotation_angle=2
		else
			if (viewer_rotation_angle=2)
				change viewer_rotation_angle=3
				CenterCamera  x = -10 y = -270 scale = 0.7
			else
				if (viewer_rotation_angle=3)
					change viewer_rotation_angle=0
					CenterCamera  x = -10 y = 0 scale = 0.7
				endif
			endif
		endif
	endif
endscript

Viewer_move_mode=0

script  UserViewerCircle
	// reset the viewer angle back to default
	change viewer_rotation_angle=0
	// toggle between fast, med, slow movement of geo
	Switch Viewer_move_mode
		case 0
			change viewer_move_mode = 1
			SetMovementVelocity 400
			SetRotateVelocity 	120
			create_panel_message id=viewermovemode text="Med cam" pos=(320,50)
		case 1
			change viewer_move_mode = 2
			SetMovementVelocity 6000
			SetRotateVelocity 	300
			create_panel_message id=viewermovemode text="Fast cam" pos=(320,50)
		case 2
			change viewer_move_mode = 0
			SetMovementVelocity 100
			SetRotateVelocity 	50
			create_panel_message id=viewermovemode text="Super Slow cam" pos=(320,50)
	endswitch
endscript

script  UserViewerTriangle
	// reset the viewer angle back to default
	change viewer_rotation_angle=0
	// top view of exported geo
	CenterCamera  X = -90 y = 0 scale=.7
endscript


script show_wireframe_mode
	switch wireframe_mode
		case 0
			wireframe_message text = "Wireframe : Face Flags"
		case 1
			wireframe_message text = "Wireframe : Poly Density"
		case 2
			wireframe_message text = "Wireframe : Low Poly Highlight"
		case 3
			wireframe_message text = "Wireframe : Unique object colors"
		case 4
			wireframe_message text = "Wireframe : Renderable Unique MESH colors"
		case 5
			wireframe_message text = "Wireframe : Renderable MESH vertex density"
		case 6
			wireframe_message text = "Wireframe : Occlusion Map"
	endswitch
endscript


script wireframe_message text="wireframe"
	Create_Panel_Message text=<text> id=wireframe_mess rgba=[200 128 128 128] pos=(20,340) just = [left center] scale =5 style=wireframe_style
endscript

script wireframe_style
	DoMorph time=0 scale=(1, 1)
	DoMorph time=3 scale=(1, 1)
	DoMorph time=1 alpha=0
	die
endscript





