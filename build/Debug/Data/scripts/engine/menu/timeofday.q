// start autoduck documentation
// @DOC timeofday


// Questions on this file to SP

////////////////////////////////////////////////////
//               TIME OF DAY PRESETS               //
////////////////////////////////////////////////////
FakeLights_Night_on = 0
FakeLights_Evening_on = 0
Headlights_on = 0
Fog_on = 0
Rain_on = 0
Snow_on = 0
tod_skaterlights = tod_skaterlights_day

script set_tod_morning
	change current_tod = morning
	change tod_skaterlights = tod_skaterlights_morning

	change	lev_red = 64
	change	lev_green = 77
	change	lev_blue  = 81
	//change	vc_target = 51
	//change	vc_percent = 52

	change	FakeLights_Night_on = 0
	change	FakeLights_Evening_on = 0
	change  Headlights_on = 0

	change	fog_on  = 1
	change	fog_red  = 85
	change	fog_green  = 100
	change	fog_blue  = 105
	change	fog_alpha  = 108
	change	fog_dist  = 350

	change rain_on = 0
	change snow_on = 0
endscript

tod_skaterlights_morning =
{
	ambient_red = 41
	ambient_green = 42
	ambient_blue = 45
	ambient_mod_factor = 0.180

	heading_0 = 188
	pitch_0 = 351
	red_0 = 16
	green_0 = 19
	blue_0 = 29
	mod_factor_0 = 0.120

	heading_1 = 0
	pitch_1 = 0
	red_1 = 34
	green_1 = 42
	blue_1 = 49
	mod_factor_1 = 0.100
}

script set_tod_evening
	change current_tod = evening
	change tod_skaterlights = tod_skaterlights_evening

	change lev_red = 100
	change lev_green = 95
	change lev_blue  = 74

	fog_on  = 1
	change fog_red  = 100
	change fog_green  = 86
	change fog_blue  = 29
	change fog_alpha  = 30
	change fog_dist  = 960.000

	change sky_red  = 76
	change sky_green  = 66
	change sky_blue  = 50

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 1
	change  Headlights_on = 1
endscript

tod_skaterlights_evening =
{
	ambient_red = 39
	ambient_green = 38
	ambient_blue = 32
	ambient_mod_factor = 0.300

	heading_0 = 50.000
	pitch_0 = 330
	red_0 = 104
	green_0 = 101
	blue_0 = 60
	mod_factor_0 = .750

	heading_1 = 240
	pitch_1 = 330
	red_1 = 45
	green_1 = 42
	blue_1 = 38
	mod_factor_1 = 0.400
}


script set_tod_night
	change current_tod = night
	change tod_skaterlights = tod_skaterlights_night

	change lev_red = 50
	change lev_green = 65
	change lev_blue  = 75

	change fog_on  = 1
	change fog_red  = 5
	change fog_green  = 16
	change fog_blue  = 22
	change fog_alpha  = 63
	change fog_dist  = 513

	change sky_red  = 18
	change sky_green  = 22
	change sky_blue  = 24

	change FakeLights_Night_on = 1
	change FakeLights_Evening_on = 0
	change  Headlights_on = 1
endscript

tod_skaterlights_night =
{
	ambient_red = 26
	ambient_green = 36
	ambient_blue = 40
	ambient_mod_factor = 0.300

	heading_0 = 330.000
	pitch_0 = 330
	red_0 = 70
	green_0 = 100
	blue_0 = 106
	mod_factor_0 = .8

	heading_1 = 151
	pitch_1 = 330
	red_1 = 15
	green_1 = 30
	blue_1 = 30
	mod_factor_1 = 0.100
}

script set_tod_nj_fog
	change current_tod = day
	change tod_skaterlights = tod_skaterlights_fog_nj

	change lev_red = 85
	change lev_green = 95
	change lev_blue  = 98

	change fog_on  = 0
	change fog_red  = 50
	change fog_green  = 61
	change fog_blue  = 61
	change fog_alpha  = 100
	change fog_dist  = 471.5

	change sky_red  = 40
	change sky_green  = 47
	change sky_blue  = 45


	change rain_on = 1
	change rain_rate  = 12
	change rain_frames  = 26
	change rain_height  = 1050
	change rain_length  = 93

	change rain_blend = 5 //Unknown(0x18b98905)
	change rain_fixed = 13

	change rain_red  = 185
	change rain_green  = 180
	change rain_blue  = 185
	change rain_alpha  = 245

	change rain_red2  = 130
	change rain_green2  = 140
	change rain_blue2  = 90
	change rain_alpha2  = 255

	change splash_rate = 0.950
	change splash_life = 8
	change splash_size = 2
	change splash_blend = 1 //Unknown(0xa86285a1)
	change splash_fixed = 34

	change splash_red  = 244
	change splash_green  = 246
	change splash_blue  = 247
	change splash_alpha  = 46

	change snow_on = 0

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 0
	change  Headlights_on = 0
endscript

tod_skaterlights_fog_nj =
{
	ambient_red = 33
	ambient_green = 40
	ambient_blue = 54
	ambient_mod_factor = 0.300

	heading_0 = 50
	pitch_0 = 330
	red_0 = 130
	green_0 = 120
	blue_0 = 97
	mod_factor_0 = 1.4

	heading_1 = 240
	pitch_1 = 330
	red_1 = 58
	green_1 = 62
	blue_1 = 66
	mod_factor_1 = 0.400
}


script set_tod_nightvision //cheesy nightvision effect for RU
	change current_tod = nightvision
	change tod_skaterlights = tod_skaterlights_nightvision

	change lev_red = 0
	change lev_green = 180
	change lev_blue  = 0

	change fog_on  = 1
	change fog_red  = 0
	change fog_green  = 0
	change fog_blue  = 0
	change fog_alpha  = 63
	change fog_dist  = 513

	change sky_red  = 0
	change sky_green  = 0
	change sky_blue  = 0

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 0
	change  Headlights_on = 1
endscript

tod_skaterlights_nightvision =
{
	ambient_red = 0
	ambient_green = 180
	ambient_blue = 0
	ambient_mod_factor = 0.5

	heading_0 = 310
	pitch_0 = 335
	red_0 = 0
	green_0 = 47
	blue_0 = 0
	mod_factor_0 = 0.8

	heading_1 = 140
	pitch_1 = 344
	red_1 = 0
	green_1 = 22
	blue_1 = 0
	mod_factor_1 = 0.8
}


script set_tod_SCJ_Cutscene //cutscene lighting
	change current_tod = SCJ_Cutscene
	change tod_skaterlights = tod_skaterlights_SCJ_Cutscene


	change lev_red = 46
	change lev_green = 38
	change lev_blue  = 34

	change fog_on  = 0
	change rain_on  = 0

endscript

tod_skaterlights_SCJ_Cutscene = {
	ambient_red = 26
	ambient_green = 26
	ambient_blue = 30
	ambient_mod_factor = 0

	heading_0 = 220
	pitch_0 = 320
	red_0 = 100
	green_0 = 70
	blue_0 = 60
	mod_factor_0 = 0

	heading_1 = 120
	pitch_1 = 320
	red_1 = 15
	green_1 = 10
	blue_1 = 10
	mod_factor_1 = 0
}

script set_tod_KISS //cheesy nightvision effect for RU
	change current_tod = KISS
	change tod_skaterlights = tod_skaterlights_kiss

	change lev_red = 87
	change lev_green = 82
	change lev_blue  = 92

	change fog_on  = 1
	change fog_red  = 87
	change fog_green  = 82
	change fog_blue  = 92
	change fog_alpha  = 63
	change fog_dist  = 1000

	change sky_red  = 73
	change sky_green  = 67
	change sky_blue  = 95

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 0
	change  Headlights_on = 1
endscript

tod_skaterlights_KISS =
{
	ambient_red = 40
	ambient_green = 36
	ambient_blue = 43
	ambient_mod_factor = 0

	heading_0 = 190
	pitch_0 = 310
	red_0 = 30
	green_0 = 20
	blue_0 = 30
	mod_factor_0 = 0.030

	heading_1 = 40
	pitch_1 = 350
	red_1 = 51
	green_1 = 31
	blue_1 = 19
	mod_factor_1 = 0
}

script set_tod_nj_morning
	change current_tod = nj_morning
	change tod_skaterlights = tod_skaterlights_nj_morning

	change lev_red = 64
	change lev_green = 67
	change lev_blue  = 81

	change sky_red  = 50
	change sky_green  = 58
	change sky_blue  = 58

	change fog_on  = 1
	change fog_red  = 85
	change fog_green  = 100
	change fog_blue  = 105
	change fog_alpha  = 70
	change fog_dist  = 385

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 0
	change  Headlights_on = 0

endscript

tod_skaterlights_nj_morning =
{
	ambient_red = 51
	ambient_green = 52
	ambient_blue = 55
	ambient_mod_factor = 0

	heading_0 = 20
	pitch_0 = 120
	red_0 = 16
	green_0 = 19
	blue_0 = 29
	mod_factor_0 = 0.10

	heading_1 = 50
	pitch_1 = 320
	red_1 = 44
	green_1 = 42
	blue_1 = 79
	mod_factor_1 = 0.5
}

script set_tod_nj_evening
	change current_tod = nj_evening
	change tod_skaterlights = tod_skaterlights_nj_evening

	change lev_red = 102
	change lev_green = 82
	change lev_blue  = 64

	change sky_red  = 58
	change sky_green  = 48
	change sky_blue  = 38

	change fog_on  = 1
	change fog_red  = 70
	change fog_green  = 50
	change fog_blue  = 40
	change fog_alpha  = 70
	change fog_dist  = 491

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 0
	change  Headlights_on = 0

endscript

tod_skaterlights_nj_evening =
{
	ambient_red = 61
	ambient_green = 56
	ambient_blue = 49
	ambient_mod_factor = 0.6

	heading_0 = 320
	pitch_0 = 170
	red_0 = 50
	green_0 = 50
	blue_0 = 40
	mod_factor_0 = 0.30

	heading_1 = 50
	pitch_1 = 330
	red_1 = 70
	green_1 = 50
	blue_1 = 28
	mod_factor_1 = 0.5
}

script set_tod_nj_night
	change current_tod = nj_night
	change tod_skaterlights = tod_skaterlights_nj_night

	change lev_red = 50
	change lev_green = 65
	change lev_blue  = 75

	change sky_red  = 21
	change sky_green  = 25
	change sky_blue  = 26

	change fog_on  = 0
	change fog_red  = 5
	change fog_green  = 16
	change fog_blue  = 22
	change fog_alpha  = 63
	change fog_dist  = 513

	change FakeLights_Night_on = 1
	change FakeLights_Evening_on = 0
	change  Headlights_on = 1
	change rain_on = 1

endscript

tod_skaterlights_nj_night =
{
	ambient_red = 26
	ambient_green = 36
	ambient_blue = 40
	ambient_mod_factor = 0.3

	heading_0 = 50
	pitch_0 = 330
	red_0 = 70
	green_0 = 100
	blue_0 = 106
	mod_factor_0 = 1.40

	heading_1 = 240
	pitch_1 = 330
	red_1 = 15
	green_1 = 30
	blue_1 = 30
	mod_factor_1 = 0.4
}

// DEFAULT!!!!!!!!!!!!!!!! Taken from THPS4 College level

// SP: This special TOD is called in levels.q when a level is loaded. It handles turning on
// fixed skaterlights, and reseting everything back to normal

script set_tod_startup
	printf "##### SETTING LEVEL BACK TO DEFAULT, STARTUP TOD"
	change current_tod = day

	change tod_skaterlights = tod_skaterlights_day	// this is actually incorrect - default should get the original light values from levels.q...

	change lev_red = 128
	change lev_green = 128
	change lev_blue  = 128

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 0
	change headlights_on = 0

	change sky_red  = 128
	change sky_green  = 128
	change sky_blue  = 128

	change rain_on = 0
	change snow_on = 0
	change splash_rate = 0
	// default should get the original fog settings from levels.q...
	Get_fog_values_levelsq
	// let the script_change_tod script know not to adjust fog, or only to turn on the skaterlights
	return TurnOn_SkaterLevelLights=1
endscript

script set_tod_day
	set_tod_rainoff

	change current_tod = day
	change tod_skaterlights = tod_skaterlights_day
	// this is actually incorrect - default should get the original light values from levels.q...

	change lev_red = 128
	change lev_green = 128
	change lev_blue  = 128

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 0
	change  Headlights_on = 0

	change sky_red  = 128
	change sky_green  = 128
	change sky_blue  = 128

	change snow_on = 0
	change rain_on = 0

	Get_fog_values_levelsq
endscript

tod_skaterlights_day =
{
	ambient_red      = 50
	ambient_green    = 50
	ambient_blue     = 50
	ambient_mod_factor = .3

	//SP: now using the values from levels.q
	heading_0	     = 60
	pitch_0          = 330
	red_0            = 136
	green_0          = 120
	blue_0           = 110
	mod_factor_0     = .75

	// now using the values from levels.q
	heading_1	     = 245
	pitch_1          = 330
	red_1            = 72
	green_1          = 70
	blue_1           = 66
	mod_factor_1     = .75
}

/// DAYTIME LEVEL SPECIFIC FOGS RIGHT HERE

script Get_fog_values_levelsq
	GetCurrentLevel
	level_struct =  <level_structure>
	// Front_endlevels have no fog... So don't make this assumption
	if StructureContains structure=<level_struct> fog_red
		fog_red 	= (<level_struct>.fog_red)
		fog_blue 	= (<level_struct>.fog_blue)
		fog_green 	= (<level_struct>.fog_green)
		fog_alpha 	= (<level_struct>.fog_alpha)
		fog_dist 	= (<level_struct>.fog_dist)

		Set_fog_from_levelsq <...>
	endif
endscript
// This script will go and get the fog values defined in levels.q for a particular level and set them
// to the global fog settings
script Set_fog_from_levelsq
	if not (<fog_alpha> = 0)
		change fog_on = 1
		change fog_red		=	<fog_red>
		change fog_blue		=	<fog_blue>
		change fog_green	=	<fog_green>
		change fog_alpha	=	<fog_alpha>
		change fog_dist		=	<fog_dist>

	else
		change fog_on = 0
		change fog_alpha = 0
		change fog_dist = 1000
	endif
endscript

script Get_Skaterlight_direction_levelsq  level_struct=level_nj	heading_0 = 50 pitch_0 = 330 heading_1 = 240 pitch_1 = 330
	// SP: This script will go look in levels.q for the proper heading and pitch of the lights, and set those values for any
	// time of day switch
	GetCurrentLevel
	level_struct =  <level_structure>

	heading_0 	= (<level_struct>.heading_0)
	pitch_0 	= (<level_struct>.pitch_0)
	heading_1 	= (<level_struct>.heading_1)
	pitch_1 	= (<level_struct>.pitch_1)
	return heading_0=<heading_0> pitch_0=<pitch_0> heading_1=<heading_1> pitch_1=<pitch_1>
endscript


///////////////////////////////////////////

script set_tod_vc_evening
	change current_tod = evening
	change tod_skaterlights = tod_skaterlights_vc_evening

	change lev_red = 115
	change lev_green = 105
	change lev_blue  = 85

	change fog_on  = 1
	change fog_red  = 82
	change fog_green  = 78
	change fog_blue  = 63
	change fog_alpha  = 72
	change fog_dist  = 856.000

	change sky_red  = 88
	change sky_green  = 78
	change sky_blue  = 74

	change rain_on = 1
	change rain_rate  = 9
	change rain_frames  = 34
	change rain_height  = 1759
	change rain_length  = 89

	change rain_blend = 9
	change rain_fixed = 20

	change rain_red  = 0
	change rain_green  = 0
	change rain_blue  = 0
	change rain_alpha  = 0

	change rain_red2  = 0
	change rain_green2  = 0
	change rain_blue2  = 0
	change rain_alpha2  = 0

	change splash_rate = 1.000
	change splash_life = 5
	change splash_size = 3
	change splash_blend = 1
	change splash_fixed = 37

	change splash_red  = 255
	change splash_green  = 255
	change splash_blue  = 255
	change splash_alpha  = 255

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 1
	change Headlights_on = 0
endscript

tod_skaterlights_vc_evening =
{
	ambient_red = 50
	ambient_green = 50
	ambient_blue = 44
	ambient_mod_factor = 0.610

	heading_0 = 171.000
	pitch_0 = 300
	red_0 = 60
	green_0 = 53
	blue_0 = 39
	mod_factor_0 = 0.600

	heading_1 = 335
	pitch_1 = 304
	red_1 = 44
	green_1 = 46
	blue_1 = 50
	mod_factor_1 = 0.100
}

script set_tod_ru_day
	Set_tod_day
	change snow_on = 0
	change fog_on  = 1
	change fog_red  = 140
	change fog_green  = 135
	change fog_blue  = 135
	change fog_alpha  = 50
	change fog_dist  = 500.000
endscript

script set_tod_ru_day_snow
	Set_tod_day
	change fog_on  = 1
	change fog_red  = 140
	change fog_green  = 140
	change fog_blue  = 140
	change fog_alpha  = 122
	change fog_dist  = 500.000

	change snow_on = 1
	change snow_rate  = 5
	change snow_frames  = 194
	change snow_height  = 464
	change snow_size  = 3
	change snow_blend = 6
	change snow_fixed = 24
	change snow_red  = 128
	change snow_green  = 128
	change snow_blue  = 128
	change snow_alpha  = 128
endscript

script set_tod_ru_night
	set_tod_night
	change sky_red  = 11
	change sky_green  = 24
	change sky_blue  = 25

	change snow_on = 0
	change fog_on  = 1
	change fog_red  = 6
	change fog_green  = 20
	change fog_blue  = 22
	change fog_alpha  = 63
	change fog_dist  = 513
endscript

script set_tod_ru_night_snow
	set_tod_ru_night

	fog_on  = 1
	change fog_red  = 26
	change fog_green  = 43
	change fog_blue  = 48
	change fog_alpha  = 125
	change fog_dist  = 500.000

	change snow_on = 1
	change snow_rate  = 4
	change snow_frames  = 155
	change snow_height  = 464
	change snow_size  = 3
	change snow_blend = 6
	change snow_fixed = 22
	change snow_red  = 128
	change snow_green  = 128
	change snow_blue  = 128
	change snow_alpha  = 128
endscript

script set_tod_scj
	change current_tod = scj
	change tod_skaterlights = tod_skaterlights_scj

	change lev_red = 99
	change lev_green = 99
	change lev_blue  = 99

	change FakeLights_Night_on = 1
	change FakeLights_Evening_on = 0

	change sky_red  = 111
	change sky_green  = 60
	change sky_blue  = 38

	change fog_on  = 1
	change fog_red  = 27
	change fog_green  = 19
	change fog_blue  = 23
	change fog_alpha  = 70
	change fog_dist  = 705
endscript

tod_skaterlights_scj =
{
	ambient_red      = 58
	ambient_green    = 57
	ambient_blue     = 59
	ambient_mod_factor = .75

	//direction_0      = (0.5, 0.8660254, 0.0)
	heading_0	     = 351
	pitch_0          = 303
	red_0            = 80
	green_0          = 63
	blue_0           = 59
	mod_factor_0     = 1.26

	//direction_1      = (0.0, 1.0, 0.0)
	heading_1	     = 314
	pitch_1          = 272
	red_1            = 47
	green_1          = 50
	blue_1           = 52
	mod_factor_1     = .46
}


script set_tod_newrain
	change rain_on = 1
	change snow_on = 0
	change rain_rate  = 16
	change rain_frames  = 22
	change rain_height  = 1986
	change rain_length  = 74

	change rain_blend = 9 //9
	change rain_fixed = 80 //32

	change rain_red  = 5 //50
	change rain_green  = 5 //50
	change rain_blue  = 0 //50
	change rain_alpha  = 0 //10

	change rain_red2  = 55 //4
	change rain_green2  = 55 //15
	change rain_blue2  = 55 //35
	change rain_alpha2  = 45 //155

	change splash_rate = 1.000
	change splash_life = 18 //8
	change splash_size = 3 //4
	change splash_blend = 1 //6
	change splash_fixed = 64//20

	change splash_red  = 85 //255
	change splash_green  = 85 //255
	change splash_blue  = 85 //255
	change splash_alpha  = 125 //255
endscript

script set_tod_rainoff
	change rain_on = 0
	change snow_on = 0
	change splash_rate = 0
endscript

script set_tod_snow
	change rain_on = 0

	change fog_on = 1
	change fog_red  = 70
	change fog_green  = 70
	change fog_blue  = 70
	change fog_alpha  = 120
	change fog_dist  = 555.000

	change snow_on = 1
	change snow_rate  = 5
	change snow_frames  = 194
	change snow_height  = 464
	change snow_size  = 3

	change snow_blend = 6
	change snow_fixed = 24

	change snow_red  = 128
	change snow_green  = 128
	change snow_blue  = 128
	change snow_alpha  = 128
endscript



////////////////////////////////////////////////////
//               TIME OF DAY MENU                 //
////////////////////////////////////////////////////
script launch_timeofday_menu
	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	make_new_menu {
		menu_id=timeofday_menu
		vmenu_id=timeofday_vmenu
		menu_title="TIME OF DAY"
		type=VMenu
		dims=(200, 200)
		padding_scale=1.1
		pos=(210,50)
	}
	SetScreenElementProps { id=timeofday_menu
		event_handlers=[
			{ pad_back           create_debug_menu }
		]
	}


	make_text_sub_menu_item text="Day (levels.q)"		id=tod_day 		pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_day   }
	make_text_sub_menu_item text="Morning" 				id=tod_morn 	pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_morning   }
	make_text_sub_menu_item text="Evening" 				id=tod_even 	pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_evening   }
	make_text_sub_menu_item text="NJ Fog and Rain" 		id=tod_njfog 	pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_nj_fog  }
	make_text_sub_menu_item text="Night" 				id=tod_night 	pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_night  }
	make_text_sub_menu_item text="SCJ Indoor" 			id=tod_scj 		pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_scj }
	make_text_sub_menu_item text="VC Evening" 			id=tod_vc_evening pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_VC_evening  }

	make_text_sub_menu_item text="RU Day" 				id=tod_ru_day pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_ru_day  }

	make_text_sub_menu_item text="Rain" 				id=tod_rainon 	pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_rain }
	make_text_sub_menu_item text="New Rain" 			id=tod_rainon2 	pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_newrain }

	make_text_sub_menu_item text="Snow On" 				id=tod_snowon 	pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_snow }
	make_text_sub_menu_item text="Rain/Snow Off" 		id=tod_rainoff 	pad_choose_script=script_change_tod pad_choose_params={tod_action=set_tod_rainoff }

	//	make_text_sub_menu_item text="Day to Night: Off" id=toggle_tod_onoff 	pad_choose_script=Toggle_TOD_onoff

	set_sub_bg 	pos=(320,54)
	// check_tod_adjust_menu
	RunScriptOnScreenElement id=current_menu_anchor animate_in params={ final_pos=(320, 134) }
endscript


TOD_ENABLED = 1

// This script will set the skater lights, scene and sky color, and fog values based on the params it is fed
script script_change_tod

	if not GotParam dynamic_on
		KillSpawnedScript name=dynamic_tod // if we're changing dynamically, stop
	endif
	// printstruct <...>
	// Make all of the changes to the globals based on Chris Ward's set values at top of file
	if GotParam tod_action
		printf "##### calling time of day action script"
		<tod_action>

		//Rulon (TT12935): Rain wasn't being activated properly because an unsupported parameter called tod_action2 (for script_change_tod) was being used.  Added support for this.
		if GotParam tod_action2
			printf "##### calling time of day action 2 script"
			<tod_action2>
		endif

	endif


	If (TOD_ENABLED)
		// Get the name of the desired skaterlights structure into a paramter so we can call set_level_lights
		<skaterlights_target> = (tod_skaterlights)

		// levels all have different light directions, need to get these before we set the skaterlights
		Get_Skaterlight_direction_levelsq
		// SP: pass on 1) what we think the lights should be set to via the time of day, and 2) the proper light directions for this level (from levels.q)
		set_level_lights <skaterlights_target> <...>

		// convert the artists' RGB values into a checksum
		<setcolorz> = (lev_red+(lev_green*256)+(lev_blue*65536))

		<skycolor> =  (sky_red+(sky_green*256)+(sky_blue*65536))


		if NOT (show_all_trick_objects)
			SetSceneColor color=<setcolorz> sky=<skycolor> lightgroup=outdoor
			SetSceneColor color=<setcolorz> lightgroup=nolevellights
			SetSceneColor color=0x808081 lightgroup=indoor		// Mick:  Need to set indoor to something, or it gets set to outdoor
		endif

	endif
	if not GotParam Dont_Modify_Fog
		if (fog_on)
			EnableFog
			SetFogColor r=fog_red b=fog_blue g=fog_green a=fog_alpha
			SetFogDistance distance=fog_dist
		else
			DisableFog
		endif
	endif

	// turn on the rain
	If (rain_on)
		WeatherSetRainActive
		WeatherSetRainHeight rain_height
		WeatherSetRainFrames rain_frames
		WeatherSetRainLength rain_length
		WeatherSetRainRate rain_rate
		<raincolor> = (rain_red+(rain_green*256)+(rain_blue*65536)+(rain_alpha*16777216))
		<raincolor2> = (rain_red2+(rain_green2*256)+(rain_blue2*65536)+(rain_alpha2*16777216))
		get_rain_mode_string
		WeatherSetRainBlendMode <checksum> (rain_fixed+0)
		WeatherSetRainColor <raincolor> <raincolor2>

		GetCurrentLevel
		switch <level>
			case load_sk5ed
				;Wait 10 frames
				;Heavy_Rain_SFX_Off
				;wait 10 frames
				Heavy_Rain_SFX_On
			case load_sk5ed_gameplay
				Heavy_Rain_SFX_On
			case load_nj
				Heavy_Rain_SFX_On
			case load_ny
				Heavy_Rain_SFX_On
			case load_hi
				Heavy_Rain_SFX_On
			case load_vc
				Heavy_Rain_SFX_On
		endswitch
	else
		Heavy_Rain_SFX_Off
		//Light_Rain_SFX_Off
		WeatherSetRainRate 0
	endif

	// set up the splashes
	if (splash_rate = 0)
		WeatherSetSplashRate 0
	else
		<splashcolor> = (splash_red+(splash_green*256)+(splash_blue*65536)+(splash_alpha*16777216))
		WeatherSetSplashRate splash_rate
		WeatherSetSplashLife splash_life
		WeatherSetSplashSize splash_size
		get_rain_mode_string splash
		WeatherSetSplashBlendMode <checksum> (splash_fixed+0)
		WeatherSetRainColor <splashcolor>
	endif

	If (snow_on)
		WeatherSetSnowActive
		WeatherSetsnowHeight snow_height
		WeatherSetsnowFrames snow_frames
		WeatherSetsnowSize snow_size
		WeatherSetsnowRate snow_rate
		<snowcolor> = (snow_red+(snow_green*256)+(snow_blue*65536)+(snow_alpha*16777216))
		get_rain_mode_string snow
		WeatherSetSnowBlendMode <checksum> (snow_fixed+0)
		WeatherSetSnowColor <snowcolor>
	else
		WeatherSetSnowRate 0
	endif

	// handle killing and creating of geo and sound boxes within the level
	script_set_level_tod

	// Don't do ANYTHING with Fakelights in a netgame, as the Fakelights will make a big memory
	// allocation on the Front End heap (ask Mick), and we don't have this memory in netgames
	//printstruct <...>
	If Not InNetGame
		If Not GotParam dontchangelights //this next section of the time of day is slow as molasses, so sometime we don't want to change it
			// These lights should always be on, no matter what the time of day
			If GotParam TurnOn_SkaterLevelLights
				//only turn these guys on when the level is loaded, no other time
				printf "##### TURNING ON SKATER ONLY LEVEL LIGHTS THAT SHOULD ALWAYS BE THERE"
				FakeLights percent=100 time=0 prefix=TRG_Skater_levellight
			endif

			wait 1 gameframe

			if (FakeLights_Evening_on)
				printf"##### evening fakelights on"
				FakeLights percent=100 time=0 prefix=TRG_Evening_levellight
			else
				printf"##### evening fakelights off"
				FakeLights percent=0 time=0 prefix=TRG_Evening_levellight
			endif

			wait 1 gameframe

			if (FakeLights_Night_on)
				printf"##### night fakelights on"
				FakeLights percent=100 time=0 prefix=TRG_levellight
			else
				printf"##### night fakelights off"
				FakeLights percent=0 time=0 prefix=TRG_levellight
			endif

			if (Headlights_on)
				CarTOD_TurnOnHeadlights
			else
				CarTOD_TurnOffHeadlights
			endif
		endif
	endif

endscript

script script_reset_tod
	if not GotParam dynamic_on
		KillSpawnedScript name=dynamic_tod // if we're changing dynamically, stop
	endif

	change FakeLights_Night_on = 0
	change FakeLights_Evening_on = 0

	change rain_on = 0
	change snow_on = 0
	change splash_rate = 0
	/*
		change lev_red = 128
		change lev_green = 128
		change lev_blue  = 128

		change sky_red  = 128
		change sky_green  = 128
		change sky_blue  = 128

        // convert the artists' RGB values into a checksum
		<setcolorz> = (lev_red+(lev_green*256)+(lev_blue*65536))

		<skycolor> =  (sky_red+(sky_green*256)+(sky_blue*65536))

		// Set the scene lighting
		SetSceneColor color=<setcolorz> sky=<skycolor> lightgroup=outdoor
		SetSceneColor color=<setcolorz> lightgroup=nolevellights
		SetSceneColor color=0x808081 lightgroup=indoor		// Mick:  Need to set indoor to something, or it gets set to outdoor
		*/

	// turn off fog
	DisableFog

	// turn off the rain
	Heavy_Rain_SFX_Off
	//Light_Rain_SFX_Off
	WeatherSetRainRate 0
	WeatherSetSplashRate 0
	WeatherSetSnowRate 0

	printf"##### evening fakelights off"
	FakeLights percent=0 time=0 prefix=TRG_Evening_levellight

	wait 1 gameframe

	printf"##### night fakelights off"
	FakeLights percent=0 time=0 prefix=TRG_levellight

endscript

script script_set_level_tod
	// turn on geo if the TOD changes
	// Probably mostly used for turning on night light glows and such as this geo is only on during a specific tod
	switch current_tod
		case morning
			printf"### Morning NOW ###"
			create prefix = "MorningOn"
			kill prefix = "DefaultOn"
			kill prefix = "EveningOn"
			kill prefix = "NightOn"
		case day
			printf"### Day NOW ###"
			create prefix = "DefaultOn"
			kill prefix = "MorningOn"
			kill prefix = "EveningOn"
			kill prefix = "NightOn"
		case evening
			printf"### Evening NOW ###"
			create prefix = "EveningOn"
			kill prefix = "DefaultOn"
			kill prefix = "MorningOn"
			kill prefix = "NightOn"
		case night
			printf"### Night NOW ###"
			create prefix = "NightOn"
			kill prefix = "DefaultOn"
			kill prefix = "MorningOn"
			kill prefix = "EveningOn"
		default
			printf"### no tod set ###"
	endswitch

	// sound boxes
	if ( (current_tod = night) || (current_tod = nj_night) )
		printf " ++++++++++++++++++ setting NIGHT sound boxes +++++++++++++++++"
		kill prefix = "TRG_SFX_TrigBox_Day_"
		kill prefix = "TRG_SFX_TrigBox_Night_"
		create prefix =  "TRG_SFX_TrigBox_Night_"
	else
		printf " ++++++++++++++++++++++ setting day/morning/evening sound boxes +++++++++++++++++"
		kill prefix = "TRG_SFX_TrigBox_Day_"
		kill prefix = "TRG_SFX_TrigBox_Night_"
		create prefix =  "TRG_SFX_TrigBox_Day_"
	endif
	Veh_Generic_TOD <...>
	//TOD_Script <...>
endscript

// Factor for how quickly we shift from one set of params to the other - e.g. day to evening
// the smaller ther value the longer it takes
TOD_TOGGLE = 0
CURRENT_TOD = Day


// @script | instant_tod_change |
// this script will still work with the current_tod parameter, but it would be better to use one of these newer "actions", and pass them in like this:
//	tod_action=set_tod_day
//	tod_action=set_tod_morning
//	tod_action=set_tod_evening
//	tod_action=set_tod_evening_mediumfog
//	tod_action=set_tod_evening_heavyfog
//	tod_action=set_tod_night
//	tod_action=set_tod_rain
//	tod_action=set_tod_newrain
//	tod_action=set_tod_snow
//	tod_action=tod_rainoff
// @parmopt name | tod_action | set_tod_day | timeofday action to take
// @parmopt name | tod_action2 | | secondary timeofday action to take
// @parmopt flag | rainoff | | turn the rain off quickly

script instant_tod_change
	printf " ------------------------------------- calling instant_tod_change"
	If Not GotParam tod_action
		// this chunk maintains compatibility with an older script
		if GotParam current_tod
			Switch <current_tod>
				case morning
					<tod_action> = set_tod_morning
				case day
					<tod_action> = set_tod_day
				case night
					<tod_action> = set_tod_night
				case evening
					<tod_action> = set_tod_evening
				case nightvision
					<tod_action> = set_tod_nightvision
				case KISS
					<tod_action> = set_tod_KISS
				case SCJ_Cutscene
					<tod_action> = set_tod_SCJ_Cutscene
				default
					<tod_action> = set_tod_day
			endswitch
		endif
	endif
	//printstruct <...>
	script_change_tod tod_action = <tod_action>

	// allow the designers to call instant_tod with a second set of actions
	If GotParam tod_action2
		script_change_tod tod_action = <tod_action2>
	endif

	//if GotParam rainoff
	//	script_change_tod tod_action = set_tod_rainoff
	//endif
endscript

TOD_SPEED = .1

// @script | start_dynamic_tod |
// this script will spawn a script that interpolates between two sets of tod and changes the game every 10 frames. The tods are:
//	set_tod_day
//	set_tod_morning
//	set_tod_evening
//	set_tod_evening_mediumfog
//	set_tod_evening_heavyfog
//	set_tod_night
// example:  start_dynamic_tod  tod_start=set_tod_evening  tod_end=set_tod_night
// @parmopt name | tod_start | set_tod_evening | timeofday action to start changing from
// @parmopt name | tod_end | set_tod_night | time of day action to change to
// @parmopt float | tod_speed |0.025 | how fast the tod changes. Bigger is faster
script start_dynamic_tod
	KillSpawnedScript name=dynamic_tod
	SpawnScript dynamic_tod params={<...>}
endscript

script dynamic_tod tod_speed = 0.025 tod_start=set_tod_evening tod_end = set_tod_night
	//first put current values into parameters so we can interpolate
	script_change_tod tod_action=<tod_start> dynamic_on dontchangelights=<dontchangelights>
	tod_dynamic_start = {lev_red=(lev_red) lev_blue=(lev_blue) lev_green=(lev_green) sky_red=(sky_red) sky_green=(sky_green) sky_blue=(sky_blue)
		fog_red=(fog_red) fog_blue=(fog_blue) fog_green=(fog_green) fog_alpha=(fog_alpha) fog_dist =(fog_dist)
	}
	tod_dynamic_skaterlights_start = (tod_skaterlights) //store away our start values for skaterlights

	// call the targeted end time of day, get the globals to params for interpolation
	<tod_end> dynamic_on
	tod_dynamic_end = {lev_red = (lev_red) lev_blue = (lev_blue) lev_green = (lev_green) sky_red=(sky_red) sky_green=(sky_green) sky_blue=(sky_blue)
		fog_red=(fog_red) fog_blue=(fog_blue) fog_green=(fog_green) fog_alpha=(fog_alpha) fog_dist =(fog_dist)
	}
	tod_dynamic_skaterlights_end = (tod_skaterlights) //store away our start values for skaterlights

	Get_Skaterlight_direction_levelsq

	// This script will interpolate between two sets of TOD paramters
	// It will use the TOD_SPEED global variable to determine how quickly and smoothly
	// it interpolates fromone set of params to the other
	Proportion=0
	Diff=<TOD_SPEED>
	begin
		<Proportion>=(<Proportion>+<Diff>)
		if (<Proportion> > 1)
			break
		else
			//printstruct <...>
			InterpolateParameters a=<tod_dynamic_start> b=<tod_dynamic_end> Proportion=<Proportion> Ignore=[heading_0 heading_1 pitch_0 pitch_1 FakeLights_Night] //Angles=[pitch_0 pitch_1]
			//printstruct <...>
			set_tod_from_params <interpolated>

			InterpolateParameters a=<tod_dynamic_skaterlights_start> b=<tod_dynamic_skaterlights_end> Proportion=<Proportion> Ignore=[heading_0 heading_1 pitch_0 pitch_1]
			//printf "Proportion - %p" p=<Proportion>
			set_level_lights <interpolated> heading_0=<heading_0> heading_1=<heading_1> pitch_0=<pitch_0> pitch_1=<pitch_1>

			wait 10 gameframes
		endif
	repeat
	script_change_tod tod_action=<tod_end> dynamic_on dontchangelights=<dontchangelights>
endscript

script set_tod_from_params
	// printstruct <...>

	<setcolorz> = (<lev_red>+(<lev_green>*256)+(<lev_blue>*65536))
	<skycolor> =  (<sky_red>+(<sky_green>*256)+(<sky_blue>*65536))
	// Set the scene lighting
	SetSceneColor color=<setcolorz> lightgroup=outdoor //sky=<skycolor>

	SetSceneColor color=<setcolorz> lightgroup=nolevellights
	SetSceneColor color=0x808081 lightgroup=indoor		// Mick:  Need to set indoor to something, or it gets set to outdoor
	//	printstruct <...>
	EnableFog
	SetFogColor r=<fog_red> b=<fog_blue> g=<fog_green> a=<fog_alpha>
	SetFogDistance distance=<fog_dist>
endscript

/* DEPRECATED STUFF BELOW HERE

// Turn the TOD on and off from the menu by spawning the scripts
script Toggle_TOD_onoff
	killspawnedscript name=changetod
	killspawnedscript name=TOD_MasterTracker
	If (TOD_TOGGLE)
		change TOD_TOGGLE = 0
		SetScreenElementProps id=toggle_tod_onoff text="Day to Night: Off"
	else
		spawnscript TOD_MasterTracker
		change TOD_TOGGLE = 1
		SetScreenElementProps id=toggle_tod_onoff text="Day to Night: On"
	endif
endscript

 // make sure the TOD menu reflects the current state of the global variable, as set by the menu
script check_tod_adjust_menu
	If (TOD_TOGGLE)
		SetScreenElementProps id=toggle_tod_onoff text="Day to Night: On"
//		printf "TIME OF DAY ON ....................."
	else
		SetScreenElementProps id=toggle_tod_onoff text="Day to Night: Off"
//		printf "TIME OF DAY OFF ....................."
	endif
endscript


// This is the main spawned watcher script that waits between each phase of day
// and then feeds in params to be interpolated between
// It will always be running while TOD is active
script TOD_MasterTracker Current_TOD=morning
	//printstruct <...>
	switch <Current_TOD>
	case morning
		change CURRENT_TOD = morning
		script_change_tod tod_morning_params instant=<instant>
		script_set_level_tod tod_morning_params
		if not GotParam Stop_TOD
			Wait 5 seconds
			Interpolate_tod tod_from=tod_morning_params tod_to=tod_default_params
			Goto TOD_MasterTracker params={Current_Tod=day}
		endif
	case day
		change CURRENT_TOD = day
		script_change_tod tod_default_params instant=<instant>
		script_set_level_tod tod_default_params
		if not GotParam Stop_TOD
			Wait 30 seconds
			Interpolate_tod tod_from=tod_default_params tod_to=tod_evening_params
			Goto TOD_MasterTracker params={Current_Tod=evening}
		endif
	case evening
		change CURRENT_TOD = evening
		script_change_tod tod_evening_params instant=<instant>
		script_set_level_tod tod_evening_params
		if not GotParam Stop_TOD
			Wait 5 seconds
			Interpolate_tod tod_from=tod_evening_params tod_to=tod_night_params
			Goto TOD_MasterTracker params={Current_Tod=night}
		endif
	case night
		change CURRENT_TOD = night
		script_change_tod tod_night_params instant=<instant>
		script_set_level_tod tod_night_params
		/* cheesy lightning strike
		 begin
			script_change_tod tod_default_params
			wait 4 gameframes
			script_change_tod tod_night_params
			wait 4 gameframes
		repeat 3
		*/

if not GotParam Stop_TOD
	Wait 20 seconds
	Interpolate_tod tod_from=tod_night_params tod_to=tod_morning_params
	Goto TOD_MasterTracker params={Current_Tod=morning}
endif
endswitch
endscript

// @script | instant_tod_change |
// this script will make the cycling time of day jump to a certain time, and alternately shut down the changing tod
// @parmopt name | current_tod | morning | target time of day: either morning, day, evening, or night
// @parmopt name | stop_tod | not used | tells the cycling tod code to shut off and not cycle, use like this: stop_tod=1

script instant_tod_change current_tod=morning
	if not (<current_tod> = CURRENT_TOD)
		killspawnedscript name=changetod
		killspawnedscript name=TOD_MasterTracker
		//		spawnscript TOD_MasterTracker params={current_tod=<current_tod> Stop_tod=<Stop_tod> instant=1}
		If Not GotParam Stop_Tod
			if (<current_tod>=day)
				create prefix = "TRG_SFX_TrigBox_Day_"
				kill prefix = "TRG_SFX_TrigBox_Night_"
			endif
			if (<current_tod>=night)
				create prefix = "TRG_SFX_TrigBox_Night_"
				kill prefix = "TRG_SFX_TrigBox_Day_"
			endif
		endif
	endif
	If NOT GotParam NoSoundBoxEffect

	endif
endscript

// This script will interpolate between two sets of TOD paramters
// It will use the TOD_SPEED global variable to determine how quickly and smoothly
// it interpolates fromone set of params to the other
script Interpolate_tod tod_from=tod_default_params tod_to=tod_evening_params
	/*
	Proportion=0
	Diff=TOD_SPEED
	begin
		<Proportion>=(<Proportion>+<Diff>)
		if (<Proportion> > 1)
			break
		else
			//printstruct <...>
			InterpolateParameters a=<tod_from> b=<tod_to> Proportion=<Proportion> Ignore=[FakeLights_Night] Angles=[pitch_0 pitch_1]
			// DrawDirectionalLightLines heading=(<interpolated>.heading_0) pitch=(<interpolated>.pitch_0) r=255 g=0 b=0
			// Merging the calculated <interpolated> onto tod_default_params before passing it
			// so that any parameters in tod_default_params that did not get interpolated carry through.
			//printf <tod_from> <tod_to>
			//printstruct <interpolated>
			script_change_tod  <interpolated> FakeLights_Night=<FakeLights_Night>

			//printf "Proportion - %p" p=<Proportion>
			wait 10 gameframes
		endif
	repeat
*/
	printf "WARNING:    Interpolate_tod deprecated"
endscript



*/


