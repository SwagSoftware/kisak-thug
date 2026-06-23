// start autoduck documentation
// @DOC camera
// @module camera | None
// @subindex Scripting Database
// @index script | camera

camera_fov             = 72.0           // standard view angle
widescreen_camera_fov  = 88.18          // 2*atan(tan(camera_fov/2) * 4/3) (88.18 with camera_fov of 72.0)
compact_camera_fov     = 80.0           // something inbetween

current_screen_mode = standard_screen_mode

script  screen_setup_standard
	SetScreen   Aspect = 1.3333333 Angle = camera_fov letterbox = 0
	UnSetGlobalFlag flag=SCREEN_MODE_WIDE
	SetGlobalFlag flag=SCREEN_MODE_STANDARD

	change current_screen_mode = standard_screen_mode
	printf "change to standard"

	if GotParam mm_bg
		if LevelIs load_skateshop
			make_mainmenu_3d_plane
		endif
	endif
endscript

script  screen_setup_widescreen
	SetScreen   Aspect = 1.7777777 Angle = widescreen_camera_fov  letterbox = 0
	UnSetGlobalFlag flag=SCREEN_MODE_STANDARD
	SetGlobalFlag flag=SCREEN_MODE_WIDE
	change current_screen_mode = widescreen_screen_mode
	printf "change to widescreen"

	if GotParam mm_bg
		if LevelIs load_skateshop
			make_mainmenu_3d_plane
		endif
	endif
endscript

script  screen_setup_letterbox
	SetScreen   Aspect = 1.7777777 Angle = widescreen_camera_fov  letterbox = 1
	SetGlobalFlag flag=SCREEN_MODE_STANDARD
	SetGlobalFlag flag=SCREEN_MODE_WIDE
	change current_screen_mode = letterbox_screen_mode
	printf "change to letterbox"

	if GotParam mm_bg
		if LevelIs load_skateshop
			make_mainmenu_3d_plane
		endif
	endif
endscript
