viewer_ip = "0.0.0.0"
XBOX_VIEWER_IP = "0.0.0.0"
ScreenShotMode = 1
test_appearance =
{
	skater_m_hair = { desc_id=#"medium 1" }
}

test_appearance_full_skater =
{
	body = { desc_id=#"MaleBody" }
	skater_m_head = { desc_id=#"Light Skin 2" }
	skater_m_hair = { desc_id=#"medium 1" }
	skater_m_torso = { desc_id=#"Baseball-T"}
	front_logo = { desc_id=#"neversoft" }
	back_logo = { desc_id=#"THUG" }
	skater_m_legs = { desc_id=#"brown" }
	shoes = { desc_id=#"50s Shoe" }
	accessories = { desc_id=#"Wrist Bands" h=50 s=0 v=16 use_default_hsv = 0}
	board = { desc_id=#"Default" }
	griptape = { desc_id=#"Generic 9" }
	//	headtop_bone_group = { use_default_scale=0 x=200 y=200 z=200 }
	//	nose_bone_group = { use_default_scale=0 x=120 y=120 z=120 }
	//	jaw_bone_group = { use_default_scale=0 x=60 y=60 z=60 }
}
script startup
	// Dev boot: drop into the skateshop front-end (main menu) instead of a level. Set a valid
	// skater appearance and skip the career startup menu. This is the same front-end the retail
	// CD build autolaunches (see default_system_startup in startup.q).
	GetCurrentSkaterProfileIndex
	SetPlayerAppearance player=<currentSkaterProfileIndex> appearance_structure=test_appearance_full_skater
	change show_career_startup_menu = 0
	Change UsePreFilesForLevelLoading=1
	dev_unlock_all_levels

	autolaunch level=load_skateshop game=career

	// Previous dev boot: straight into NY (Manhattan) free skate.
	//autolaunch level=load_NY game=freeskate

	//chc_create_test_object
endscript

// Dev: unlock every level. all_levels_unlocked=1 is the master the menus OR on; the per-level
// flags cover career/goal code that checks them directly.
script dev_unlock_all_levels
	change all_levels_unlocked = 1
	SetGlobalFlag flag = LEVEL_UNLOCKED_SCH
	SetGlobalFlag flag = LEVEL_UNLOCKED_NJ
	SetGlobalFlag flag = LEVEL_UNLOCKED_NY
	SetGlobalFlag flag = LEVEL_UNLOCKED_FL
	SetGlobalFlag flag = LEVEL_UNLOCKED_SD
	SetGlobalFlag flag = LEVEL_UNLOCKED_HI
	SetGlobalFlag flag = LEVEL_UNLOCKED_VC
	SetGlobalFlag flag = LEVEL_UNLOCKED_RU
	SetGlobalFlag flag = LEVEL_UNLOCKED_AU
	SetGlobalFlag flag = LEVEL_UNLOCKED_SE
	SetGlobalFlag flag = LEVEL_UNLOCKED_SC
	SetGlobalFlag flag = LEVEL_UNLOCKED_SC2
	SetGlobalFlag flag = LEVEL_UNLOCKED_DJ
	SetGlobalFlag flag = LEVEL_UNLOCKED_PH
	SetGlobalFlag flag = LEVEL_UNLOCKED_VN
	SetGlobalFlag flag = LEVEL_UNLOCKED_HN
	SetGlobalFlag flag = LEVEL_UNLOCKED_ALC
	SetGlobalFlag flag = LEVEL_UNLOCKED_CNV
	SetGlobalFlag flag = LEVEL_UNLOCKED_HOF
	SetGlobalFlag flag = LEVEL_UNLOCKED_JNK
	SetGlobalFlag flag = LEVEL_UNLOCKED_KON
	SetGlobalFlag flag = LEVEL_UNLOCKED_LON
	SetGlobalFlag flag = LEVEL_UNLOCKED_SF2
	SetGlobalFlag flag = LEVEL_UNLOCKED_SP
	SetGlobalFlag flag = LEVEL_UNLOCKED_TD
	SetGlobalFlag flag = LEVEL_UNLOCKED_SHIP
	SetGlobalFlag flag = LEVEL_UNLOCKED_ZOO
	// Burnside/Roswell/Warehouse have no LEVEL_UNLOCKED_ flag; all_levels_unlocked=1 covers them.
endscript

script chc_create_test_object
	CreateCompositeObject {
		Components=
		[
			{component = model
				model = "gameobjects\skate\letter_a\letter_a.mdl"
			}
		]
		Params={
			pos=(-0.2, 0, 0)
			StartPosition = (-0.2, 0, 0)
		}
	}

	CreateCompositeObject {
		Components=
		[
			{component = camera}
		]
		Params={
			pos=(-68.9838715, -0.164858431, 107.828812)
			StartPosition = (-68.9838715, -0.164858431, 107.828812)
		}
	}
endscript
