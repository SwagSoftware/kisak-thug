Display_Story_Peralta_LoadingScreen = 0
Display_Story_Final_LoadingScreen = 0
Display_Story_Premiere_LoadingScreen = 0

// A place to keep all the info about the chapters

CHAPTER_STATUS=[
	// 0=locked, 1=unlocked, 2=complete
	1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
]

CHAPTER_NUM_GOALS_TO_COMPLETE = [
	//New Jersey
    [ 1, 3, 1 ]
	[ 3, 1 ]
	[ 1, 1, 1, 1 ]
	//New York
    [ 4 ]
	[ 2, 1, 1 ]
	[ 2 ]
	//Tampa
	[ 3, 1 ]
    [ 4, 1 ]
	[ 2, 1 ]
	//Choose your Sponsor
    [ 1 ]
    //San Diego
	[ 3, 1 ]
	[ 3, 1 ]
	[ 3, 1 ]
	//Hawaii
    [ 3, 1 ]
	[ 5, 1 ]
	[ 1, 1 ]
	//Vancouver
    [ 7, 1 ]
	//Slam City Jam
    [ 3, 1 ]
	//Vancouver
	[ 1, 1 ]
	//Moscow
    [ 2, 1 ]
	[ 4, 1 ]
	[ 3, 1 ]
	//New Jersey
    [ 1, 1 ]
	//Get the Pros by filming
    [ 2 ]
	//Choose your Pros
    [ 1 ]
	//Movie Challenges
    [ 5 ]
	//New Jersey
    [ 1 ]
]

total_num_goals = 129//????? 121 normal + 8 secret

STAGE_TOD_SETTINGS = [
	//New Jersey
    [ set_tod_day, set_tod_day, set_tod_day ]
	[ set_tod_nj_evening, set_tod_nj_night ]
	[ set_tod_nj_morning, set_tod_day, set_tod_day, set_tod_nj_fog ]
	//New York
    [ set_tod_day ]
	[ set_tod_night, set_tod_night, set_tod_night ]
	[ set_tod_day ]
	//Tampa
	[ set_tod_day, set_tod_day ]
	
    [ set_tod_day, set_tod_day ]
	[ set_tod_day, set_tod_day ]
	//Choose your Sponsor
    [ set_tod_day ]
    //San Diego
	[ set_tod_day, set_tod_day ]
	[ set_tod_day, set_tod_day ]
	[ set_tod_day, set_tod_day ]
	//Hawaii
    [ set_tod_day, set_tod_day ]
	[ set_tod_day, set_tod_day ]
	[ set_tod_day, set_tod_day ]
	//Vancouver
    [ set_tod_day, set_tod_vc_evening ]
	//Slam City Jam
    [ set_tod_day, set_tod_day ]
	//Vancouver
	[ set_tod_vc_evening, set_tod_vc_evening ]
	//Moscow
    [ set_tod_ru_day, set_tod_ru_day ]
	[ set_tod_ru_day_snow, set_tod_ru_day_snow ]
	[ set_tod_ru_night, set_tod_ru_night ]
	//New Jersey
    [ set_tod_day, set_tod_day ]
	//Get the Pros by filming
    [ set_tod_day ]
	//Choose your Pros
    [ set_tod_day ]
	//Movie Challenges
    [ set_tod_day ]
	//New Jersey
    [ set_tod_evening ]
]

CHAPTER_COMPLETION_SCRIPTS = [
	//New Jersey
	[ { script_name=NJ_StageSwitch_0_to_1_1 }, { script_name=NJ_StageSwitch_1_1_to_1_2 }, { script_name=NJ_StageSwitch_1_2_to_2_1 } ]
	[ { script_name=NJ_StageSwitch_2_1_to_2_2 }, { script_name=NJ_StageSwitch_2_2_to_3_1 } ]
	[ { script_name=NJ_StageSwitch_3_1_to_3_2 }, { script_name=NJ_StageSwitch_3_2_to_3_3 }, { script_name=NJ_StageSwitch_3_3_to_3_4 }, { script_name=NJ_StageSwitch_GoingToNY  } ]
	//New York
	[ { script_name=NY_StageSwitch_1_1_to_2_1 } ]
	[ { script_name=NY_StageSwitch_2_1_to_2_2 }, { script_name=NY_StageSwitch_2_2_to_2_3 }, { script_name=NY_StageSwitch_2_3_to_3_1 } ]
	[ { script_name=NY_StageSwitch_GoingToFL } ]
	//Tampa
	[ { script_name=FL_StageSwitch_1_1_to_1_2 }, { script_name=FL_StageSwitch_1_2_to_2_1 } ]
	[ { script_name=FL_StageSwitch_2_1_to_2_2 }, { script_name=FL_StageSwitch_2_2_to_3_1 } ]
	[ { script_name=FL_StageSwitch_3_1_to_3_2 }, { script_name=FL_StageSwitch_GoingToSponsor } ]
	//Sponsor Challenges
	[ { script_name=boardshop_do_nothing_script } ]
	//San Diego
	[ { script_name=SD_StageSwitch_1_1_to_1_2 }, { script_name=SD_StageSwitch_1_2_to_2_1 } ]
	[ { script_name=SD_StageSwitch_2_1_to_2_2 }, { script_name=SD_StageSwitch_2_2_to_3_1 } ]
	[ { script_name=SD_StageSwitch_3_1_to_3_2 }, { script_name=SD_StageSwitch_GoingToHI } ]
	//Hawaii
	[ { script_name=HI_StageSwitch_1_1_to_1_2 }, { script_name=HI_StageSwitch_1_2_to_2_1 } ]
	[ { script_name=HI_StageSwitch_2_1_to_2_2 }, { script_name=HI_StageSwitch_2_2_to_3_1 } ]
	[ { script_name=HI_StageSwitch_3_1_to_3_2 }, { script_name=HI_StageSwitch_GoingToVC } ]
	//Vancouver
	[ { script_name=VC_StageSwitch_1_1_to_1_2 }, { script_name=VC_StageSwitch_GoingToSJ } ]
	//Slam City Jam
	[ { script_name=SJ_StageSwitch_1_1_to_1_2 }, { script_name=SJ_StageSwitch_GoingToVC } ]
	//Vancouver
	[ { script_name=VC_StageSwitch_2_1_to_2_2 }, { script_name=VC_StageSwitch_GoingToRU } ]
	//Moscow
	[ { script_name=RU_StageSwitch_1_1_to_1_2 }, { script_name=RU_StageSwitch_1_2_to_2_1 } ]
	[ { script_name=RU_StageSwitch_2_1_to_2_2 }, { script_name=RU_StageSwitch_2_2_to_3_1 } ]
	[ { script_name=RU_StageSwitch_3_1_to_3_2 }, { script_name=RU_StageSwitch_GoingToNJ } ]
	// New Jersey - why you skate
	[ { script_name=NJ_StageSwitch_FindYourself }, { script_name=NJ_StageSwitch_GoingToPros } ]
	//Get film to get Pros interested
	[ { script_name=Pros_StageSwitch_ChooseYourPro } ]
	// Pick your team
	[ { script_name=UnlockTeamDecks } ]
	// Movie Challenges
	[ { script_name=Movies_StageSwitch_GoingToEric } ]
	// New Jersey
	[ { script_name=Eric_StageSwitch_GoingToGameOver } ]
]

LEVEL_PEDS_HIDE = [

//New Jersey
	[ TRG_G_Special_Pro TRG_Ped_Walking TRG_Ped_Walking01 TRG_Ped_Walking02 TRG_Ped_Walking03 TRG_Ped_Walking04 TRG_Ped_Walking05 ]
	
//New York
	[ ]
	
//Tampa
	[ ]
	
//San Diego
	[ ]
	
//Hawaii
	[ ]
	
//Vancouver
	[ ]
	
//Slam City Jam
	[ ]
	
//Moscow
	[ ]
	
//Hotter Than Hell
	[ ]
]

dont_lock_goals=0

script unlock_all_chapters
	GetArraySize CHAPTER_STATUS
	index=0
	begin
        ;change CHAPTER_STATUS=[<index>]=1
		// The following two lines do what the line above would do...
		chapter_status2=CHAPTER_STATUS
        SetArrayElement arrayname=chapter_status2 index=<index> newvalue=1
		index=(<index> + 1)
	repeat <array_size>
	
	change dont_lock_goals=1
	
endscript

CHAPTER_LEVELS=[
	{ text="NEW JERSEY" checksum=load_nj num=1 }// 1
	{ text="NEW JERSEY" checksum=load_nj num=1 }// 2
	{ text="NEW JERSEY" checksum=load_nj num=1 }// 3
	{ text="MANHATTAN" checksum=load_ny num=2 }// 4
	{ text="MANHATTAN" checksum=load_ny num=2 }// 5
	{ text="MANHATTAN" checksum=load_ny num=2 }// 6
	{ text="TAMPA" checksum=load_fl num=3 }// 7
	{ text="TAMPA" checksum=load_fl num=3 }// 8
	{ text="TAMPA" checksum=load_fl num=3 }// 9
	{ text="SPONSOR PICK" checksum=everywhere num=10 }// 10
	{ text="SAN DIEGO" checksum=load_sd num=4 }// 11
	{ text="SAN DIEGO" checksum=load_sd num=4 }// 12
	{ text="SAN DIEGO" checksum=load_sd num=4 }// 13
	{ text="HAWAII" checksum=load_hi num=5 }// 14
	{ text="HAWAII" checksum=load_hi num=5 }// 15
	{ text="HAWAII" checksum=load_hi num=5 }// 16
	{ text="VANCOUVER" checksum=load_vc num=6 }// 17
	{ text="SLAM CITY JAM" checksum=load_sj num=7 }// 18
	{ text="VANCOUVER" checksum=load_vc num=6 }// 19
	{ text="MOSCOW" checksum=load_ru num=8 }// 20
	{ text="MOSCOW" checksum=load_ru num=8 }// 21
	{ text="MOSCOW" checksum=load_ru num=8 }// 22
	{ text="NEW JERSEY" checksum=load_nj num=1 }// 23
	{ text="NEW JERSEY" checksum=load_nj num=1 }// 24
	{ text="TEAM PICK" checksum=everywhere num=25 }// 25
	{ text="EVERYWHERE" checksum=everywhere num=26 }// 26
	{ text="NEW JERSEY" checksum=load_nj num=1 }// 27
]

// for debugging - auto set of chapter and stage
// when loading a level
LEVEL_CHAPTER_MAP = {
	load_nj = 0
	load_ny = 3
	load_fl = 6
	load_sd = 10
	load_hi = 13
	load_vc = 16
	load_sj = 17
	load_ru = 19
}

CHAPTER_TITLES=[	
	"HOMETOWN HIJINKS",	;1
	"IMPRESSING THE LOCALS",	;2
	"GETTING OUTTA DODGE",	;3
	"SKATE THE BIG APPLE",	;4
	"SKATING WITH THE LOCALS",	;5
	"FAVORS FOR A RIDE",	;6
	"WITH SYRUP OR JELLY",	;7
	"GREASE THE PROS",	;8
	"KILL THE COMP",	;9
	"JOIN A TEAM",	;10
	"PROVE YOURSELF WORTHY",	;11
	"PARTY! PARTY! PARTY!",	;12
	"DEMO TIME",	;13
	"GET LEI'D",	;14
	"FIND THE ULTIMATE SPOT",	;15
	"GET THE SHOT",	;16
	"LAST MINUTE TASKS",	;17
	"DESTROY THE SLAM CITY JAM",	;18
	"IT'S GOTTA BE THE SHOES",	;19
	"WELCOME TO RUSSIA",	;20
	"TIME TO SKATE COMRADE",	;21
	"GOODBYE SWEET MOSCOW",	;22
	"KEEPIN IT REAL",	;23
	"SPREADIN' THE NEWS",	;24
	"PICK YOUR TEAM MEMBERS"	;25
	"THE VIDEO TO END ALL"	;26
	"SHOWDOWN IN NEW JERSEY"	;27
]
				
CHAPTER_DESCRIPTIONS=[
	"Clear your head and have some fun skating your hometown.",	;1
	"Get in tight with the local skateshop and its riders...",	;2
	"Eric is in deep with the local dealers! Gotta find a way to get you guys outta there!",	;3
	"Out of that dump of a hometown and in the big city! Time to hit some of those great skate spots.",	;4
	"Time to shoot your own skate video to send off to Mr. Peralta. Get the locals' help.",	;5
	"Mr. Peralta thinks you guys might actually have a chance in Tampa.  Do some errands for him and he'll let you borrow his car to get down there!",	;6
	"The Tampa Cops are holding Eric and they won't let him go unless you run their errands.",	;7
	"This sucks! Got all the way down here and they won't let you enter the contest... maybe some of the pros that are in town can lend a hand...",	;8
	"Time to lay down the law - if you can kill this competition, you might just make a name for yourself.",	;9
	"Too many choices! Time to join a real team. Check out the team videos then choose a team...",	;10
	"Damn! A team skater! Well, better get to know the rest of your team - probably wouldn't hurt to start gettin' some press too...",	;11
	"Your first ad! Time to celebrate - but you hafta get the party favors...",	;12
	"Your first team demo - but where is everyone? Get all your guys to the demo and show the kids what you can do!",	;13
	"Go Explore! Just don't get into any trouble like those crazy Brady kids!",	;14
	"Gotta find the perfect spot.",	;15
	"The perfect spot. The video killer. Sack up and get the footage.",	;16
	"The premiere is right around the corner and the video isn't even done! Help out getting it finished!",	;17
	"What the F&@*! Your part was gone from the video! Well, only one thing to do... destroy EVERYONE in the competition!",	;18
	"Not gonna stop now - get that shoe sponsor!",	;19
	"Welcome to Russia, comrade. Skate. Explore. Enjoy... and remember, prostitution is legal here.",	;20
	"You gotta job to do - Time to show these Ruskies what you can do!",	;21
	"Screw this super spy stuff, time to get out of Mother Russia",	;22
	"Too much crap - go have some fun!",	;23
	"The other pros are gonna want to have a good reason to join... time to go do some sick stuff!!"	;24
	"Pick Your Pros."	;25
	"You've got the team - time to do the video!"	;26
	"You've always known that you were better - time to prove it!"	;27
]


// status 0=incomplete, 1=complete, 2=final locked 3=final unlocked 4=final complete
CHAPTER_GOALS =[
	// 1 New Jersey
	[	
		// stage 0
		[	
            { text="Help Eric"  goal_id=NJ_Goal_Collect5 /*targetOffset=(-7883.8, -1664.6, -2418.0) positionOffset=(386.3, 65.7, 2931.4)*/ }
		// stage 1
		]
		[	
            { text="Walk Charles"  goal_id=NJ_Goal_Gaps4  }
            { text="Eric's challenge"  goal_id=NJ_Goal_trickspot4  }   //Eric Challenge 1/3
			{ text="Get in tight with the Street Warriors"  goal_id=nj_goal_race6  }
            { text="Flyer for the Muska demo"  goal_id=nj_goal_Counter2  }
		]
		// stage 2
		[	{ text="IMPRESS MUSKA" final goal_id=nj_goal_proscore  }
		]
	]
	// 2 New Jersey
	[ 	
		// stage 1
		[
			//{ text="High Wire Grind Line"  }
			//{ text="Put up Skateshop Flyers"  goal_id=nj_goal_ counter2}
			{ text="Impress Shawn"  goal_id=nj_goal_Trickspot2  }
			{ text="Demo the New Playground Setup"  goal_id=nj_goal_highscore  }
			{ text="Impress Joey"  goal_id=nj_goal_trickspot6 no_ped_cam=no_ped_cam targetOffset=(-61.483078,19.809824,2241.037842) positionOffset=(-54.835625,21.698126,2240.750488) }
            { text="Do Chris' Best Lines"  goal_id=nj_goal_race3  no_ped_cam=no_ped_cam targetOffset=(-2671.176514,99.138863,2742.920654) positionOffset=(-2659.801025,78.299088,2773.374268) }
		]
		// stage 2
		[	{ text="Get the stolen items back from the Dealers" final goal_id=nj_goal_collect  }
		]
	]
	// 3 New Jersey
	[ 	
		// stage 1
		[	
            { text="Get the Scrapmetal for the Tombstone Maker"  goal_id=nj_goal_collect4  }
            //{ text="CLEAR THE BRIDGE" final goal_id=nj_goal_gaps } 
            
        ]
		// stage 2
		[
            { text="Get access to the Train Station"  goal_id=nj_goal_Counter3  }
// this has been moved here until it's fixed... needs to be done before 2nd half is open
		]
		// stage 3
		[	{ text="Impress the bratty kid"  goal_id=nj_goal_GenericScore2  }
			{ text="Catch Ollie's house"  goal_id=nj_goal_Collect2  }
    	]
		// stage 4
        [   { text="Rescue Eric!" final goal_id=nj_goal_race  }]
	    ]
	// 4 New York
	[ 	
		// stage 1
		[
			{ text="High Score"  goal_id=NY_Goal_Highscore }
			{ text="Hold-grind combos"  goal_id=NY_Goal_Tetris }
			{ text="Help the student"  goal_id=NY_Goal_Collect }
			{ text="Kill 5 famous skatespots"  goal_id=NY_Goal_GenericScore }
			{ text="Nut Vendors Unite!"  goal_id=NY_Goal_Race }
		]
	]
	// 5 New York
	[ 	
		// stage 1
		[
			{ text="Film the local"  goal_id=NY_Goal_Film }
			{ text="Hit the killer banks line"  goal_id=NY_Goal_Race2 }
			{ text="Crash and burn the car"  goal_id=NY_Goal_Gaps3 }
		]
		// stage 2
		[
			{ text="Help the local skater" goal_id=NY_Goal_Race3 }
		]
		// stage 3
		[
			{ text="Gap the burning taxi" final goal_id=NY_Goal_Tetris2 }
		]
	]
	// 6 New York
	[ 	
		// stage 1
		[
			{ text="Help Stacy's relative" goal_id=NY_Goal_GenericScore6 no_ped_cam=no_ped_cam targetOffset=(-3579.072998,61.082024,-4978.129883) positionOffset=(-3579.736572,59.386021,-4962.237793) }
			{ text="Old school skating techniques" goal_id=NY_Goal_Counter }
			{ text="Find the stolen skateshop goods" goal_id=NY_Goal_Collect2 }
		]
	]
	// 7 Tampa
	[ 	
		// stage 1
		[
			{ text="Remove all of the Stickers"  goal_id=FL_Goal_Gaps2}
			{ text="Get the best donuts"  goal_id=FL_Goal_Collect}
			{ text="The Skateboarding Bandit"  goal_id=FL_Goal_Collect2}
			{ text="Help the Private Eye"  goal_id=FL_Goal_Counter}
		]
        // stage 2
	    [
            { text="Revenge!!!" final goal_id=FL_Goal_Gaps3}
		]
	]
	// 8 Tampa
	[ 	
		// stage 1
		[
			{ text="Party boat Skate-Tricks"  goal_id=FL_Goal_Tetris no_ped_cam=no_ped_cam targetOffset=(3950.109619,89.720802,4601.570313) positionOffset=(4110.023926,3.506023,4738.771484) }
			{ text="Wallplant Combo"  goal_id=FL_Goal_Gaps no_ped_cam=no_ped_cam targetOffset=(5021.475098,253.925919,-1781.831055) positionOffset=(5261.799805,255.691864,-1783.794922) }
			{ text="Beat Andrew's best combos"  goal_id=FL_Goal_Horse}
			{ text="Bowl Grind"  goal_id=FL_Goal_Gaps4}
            { text="Prove yourself"  goal_id=FL_Goal_Counter3}
		]
		// stage 2
        [	
            { text="Impress Tony Hawk" final goal_id=FL_Goal_Tetris2}
		]
	]
	// 9 Tampa
	[ 	
		// stage 1
		[
			{ text="Place in street contest"  goal_id=FL_Goal_Comp}
			{ text="Place in vert contest"  goal_id=FL_Goal_Comp2}
			{ text="Get onto the roof of SPoT"  goal_id=FL_Goal_Trickspot}
		]
		// stage 2
        [	
			{ text="Win best trick contest" final goal_id=FL_Goal_Trickspot3}
		]
	]
	// 10 Sponsor Challenges
	[ 	
		// stage 1
		[
			{ text="Join Birdhouse" sponsor=sponsor_birdhouse }
			{ text="Join Element" sponsor=sponsor_element }
			{ text="Join Flip" sponsor=sponsor_flip }
			{ text="Join Girl" sponsor=sponsor_girl }
			{ text="Join Zero" sponsor=sponsor_zero }
			{ text="View Sponsor Videos Again" replay_videos }
		]
	]
	// 11 San Diego
	[ 	
		// stage 1
		[
			{ Text = "Flip the Big Stairs" Goal_ID = SD_Goal_Gaps }
			{ Text = "Daredevil High Line" Goal_ID = SD_Goal_Collect }
			{ Text = "Air Out the Atrium"  Goal_ID = SD_Goal_Gaps5 }
			{ Text = "Rooftop Technician"  Goal_ID = SD_Goal_Gaps9 }
		]
		// stage 2
        [	
			{ Text = "See a Man About a Horse" final Goal_ID = SD_Goal_Tetris }
		]
	]
	// 12 San Diego
    [
		// stage 1
		[
			{ Text = "Let's Get This Party Started"  Goal_ID = SD_Goal_Gaps11 }
			{ Text = "No Band...No Party. Bummer!"   Goal_ID = SD_Goal_Collect2 }
			{ Text = "No One Likes a Dude Festival"  Goal_ID = SD_Goal_Race2 }
			{ Text = "Acid Drop the Two Towers" Goal_ID = SD_Goal_Gaps10 }		
		]
		// stage 2
        [	
			{ Text = "All We Need Is a System and Some Rims" final Goal_ID = SD_Goal_Race }
		]
    ]
    // 13 San Diego
	[ 	
		// stage 1
		[
			{ Text = "Get Your Gear Back From the Fuzz"   Goal_ID = SD_Goal_Gaps12 }
			{ Text = "Round Up the Posse For the Demo"    Goal_ID = SD_Goal_Collect3 }
			{ Text = "3 Is No Crowd. Find More Kids"      Goal_ID = SD_Goal_HighCombo }
			{ Text = "The Kids Love Those Free Stickers!" Goal_ID = SD_Goal_Counter3 }
		]
		// stage 2
        [	
			{ Text = "Tear It Up at the Demo" final Goal_ID = SD_Goal_Tetris2 }
		]
	]
	// 14 Hawaii
	[ 	
		// stage 1
		[
			{ text="Wedding Guest"  goal_id=HI_Goal_Trickspot3}
			{ text="Get Lei'd"  goal_id=HI_Goal_Collect}
			{ text="Pineapple Killer"  goal_id=HI_Goal_Collect2}
			{ text="Speak Hawaiian"  goal_id=HI_Goal_Collect3}
		]
		// stage 2
        [	
			{ text="Drain the pool" final goal_id=HI_Goal_Counter2}
		]
	]
	// 15 Hawaii
	[ 	
		// stage 1
		[
			{ text="Impress the girls"  goal_id=HI_Goal_Counter}
			{ text="Luau Competition"  goal_id=HI_Goal_Comp}
            { text="Wallows combo bowls"  goal_id=HI_Goal_Trickspot2 no_ped_cam=no_ped_cam targetOffset=(-698.987610,-96.814255,-5766.193359) positionOffset=(-828.288086,5.862293,-5488.194824) }
			{ text="High Lines"  goal_id=HI_Goal_Gaps2}
			{ text="Off The Walls"  goal_id=HI_Goal_Gaps3}
            { text="Kill Wallows"  goal_id=HI_Goal_Kill}
			{ text="Island Liptrick Tour" goal_id=HI_Goal_Trickspot4 }
		]
		// stage 2
        [	
			{ text="Climb the Hotel" final goal_id=HI_Goal_Trickspot no_ped_cam=no_ped_cam targetOffset=(-698.987610,-96.814255,-5766.193359) positionOffset=(204.385635,71.194283,808.885193) } 
		]
	]
	// 16 Hawaii
	[ 	
		// stage 1
		[
			{ text="Hotel Hopper"  goal_id=HI_Goal_Gaps}
		]
		// stage 2
        [	
			{ text="Craziest Footage ever" final goal_id=HI_Goal_GenericScore no_ped_cam=no_ped_cam targetOffset=(0,0,0) positionOffset=(715.812683,1578.234009,1303.227173) }
		]
	]
	// 17 Vancouver
	[ 	
		// stage 1
		[
			{ text="Skate Tom's Part"  goal_id=VC_Goal_trickspot}
			{ text="Filming a Line"  goal_id=VC_Goal_Film}
			{ text="Bust some Flatland"  goal_id=VC_Goal_tetris no_ped_cam=no_ped_cam targetOffset=(3544.235107,-101.282143,3230.424072) positionOffset=(3376.247559,-100.684654,3225.953125) }
			{ text="Race the Blowcart"  goal_id=VC_Goal_Race2}
			{ text="Party dregs"  goal_id=VC_Goal_Collect2}
			{ text="Slam City Fan"  goal_id=VC_Goal_Collect3 no_ped_cam=no_ped_cam targetOffset=(5236.550781,269.436249,-2739.857910) positionOffset=(5380.483887,318.547791,-2272.217529) }
			{ text="Ralphie got busted"  goal_id=VC_Goal_Race no_ped_cam=no_ped_cam targetOffset=(3667.598877,149.485931,1785.011841) positionOffset=(3669.565186,147.346176,1784.603516) }
			{ text="Impress the reporter"  goal_id=VC_Goal_HighScore}
			{ text="Return the Guest Passes"  goal_id=VC_Goal_Collect}
		]
		// stage 2
        [	
			{ text="Pick up everyone in the limo" final goal_id=VC_Goal_Race4}
		]
	]
	// 18 Slam City Jam
	[ 	
		// stage 1
		[
			{ text="Blimp"  goal_id=SJ_Goal_Collect2}
			{ text="Learn the hip transfers" goal_id=SJ_Goal_TrickSpot  }
			{ text="Destroy the Vert Contest"  goal_id=SJ_Goal_Comp no_ped_cam=no_ped_cam targetOffset=(-2232.448731,-234.960449,-226.102196) positionOffset=(-1799.229858,-1249.161621,-17.248917) }
			{ text="Destroy the Street Contest"  goal_id=SJ_Goal_Comp2}
      ]
		// stage 2
        [	
			{ text="Best of Show" final goal_id=SJ_Goal_TrickSpot4}
		]
	]
	// 19 Vancouver part 2
	[ 	
		// stage 1
		[
			{ text="ADIO - Show off your skills"  goal_id=VC_Goal_Gaps}
			{ text="Vans - whoop it up for the crowds"  goal_id=VC_Goal_Counter5}
			{ text="Circa - Pass the test"  goal_id=VC_Goal_Collect5}
			{ text="Es - Kill the score spots."  goal_id=VC_Goal_Horse}
		]
		// stage 2
        [	
			{ text="Get the Moscow trip" final goal_id=VC_Goal_Collect4}
		]
	]
	// 20 Moscow
	[ 	
		// stage 1
		[
			{ text="Serve the people"  Goal_id=RU_Goal_Tetris2 no_ped_cam=no_ped_cam targetOffset=(3950.109619,89.720802,4601.570313) positionOffset=(4110.023926,170.506023,4738.771484) }
			{ text="Blind Big Brother"  Goal_id=RU_Goal_race2}
            { text="Ready for Battle"  Goal_id=RU_Goal_trickspot no_ped_cam=no_ped_cam targetOffset=(3950.109619,89.720802,4601.570313) positionOffset=(-1619.007690,27.397347,-413.568787) }
		]
		// stage 2
		[	
			{ text="Over the Wall" final Goal_id=RU_Goal_Gaps} 
		]
	]
	// 21 Moscow
	[ 	
		// stage 1
		[
			{ text="Manuals for Muskovites"  Goal_id=RU_Goal_Tetris}
			{ text="Ratings stunts"  Goal_id=RU_Goal_Proscore}
			{ text="Circus Act"  Goal_id=RU_Goal_Gaps2}
			{ text="Gap hunting"  Goal_id=RU_Goal_Findgaps}
			{ text="Warm up"  Goal_id=RU_Goal_highscore}
		]
		// stage 2
		[	
			{ text="Double Dome" final Goal_id=RU_goal_GenericScore2} 
			//{ text="Double Dome" final Goal_id=RU_goal_GS2}
		]
	]
	// 22 Moscow
	[ 	
		// stage 1
		[
			//{ text="Bust Tricks"  Goal_id=RU_Goal_Tetris3}        //made child of serve the people
			{ text="Anonymous caller"  Goal_id=RU_Goal_race3 no_ped_cam=no_ped_cam targetOffset=(1099.666382,-102.664177,2106.471680) positionOffset=(1304.352783,-20.629097,3007.781250) }
			{ text="Party Favors"  Goal_id=RU_Goal_Race6}
			{ text="Hangover Cure" Goal_id=RU_Goal_Race5 no_ped_cam=no_ped_cam targetOffset=(0,0,0) positionOffset=(-1359.085571,517.379242,-3747.739014) }
		]
		// stage 2
        [
            { text="Straight outta Moscow"  final Goal_id=RU_Goal_race4}  
		]
	]
	// 23 New Jersey
	[ 	
		// stage 1
		[
			{ text="Create - a - Trick"  goal_id=nj_goal_CAT}			
		]
        // stage 2
		[
            { text="Combo the Entire City"  goal_id=nj_goal_Counter4}
		]
	]
	// 24 Get the Pros by filming
	[	
		// stage 1
		[
            { text="Do ALL of the Tricks"  goal_id=nj_goal_tetris2}
			{ text="Score Big"  goal_id=nj_goal_GenericScore4 no_ped_cam=no_ped_cam targetOffset=(0,0,0) positionOffset=(-3945.866699,97.833771,2937.328857) }
//			{ text="Bust the Dealers"  }

		]
	]
	// 25 Select the Pros
	[	
		[
			{ text="BOB BURNQUIST" pro=burnquist movie=MOVIE_UNLOCKED_BURNQUIST}
			{ text="TONY HAWK" pro=hawk movie=MOVIE_UNLOCKED_HAWK}
			{ text="ERIC KOSTON" pro=koston movie=MOVIE_UNLOCKED_KOSTON}
			{ text="BUCKY LASEK" pro=lasek movie=MOVIE_UNLOCKED_LASEK}
			{ text="BAM MARGERA" pro=margera movie=MOVIE_UNLOCKED_MARGERA}
			{ text="RODNEY MULLEN" pro=mullen movie=MOVIE_UNLOCKED_MULLEN}
			{ text="CHAD MUSKA" pro=muska movie=MOVIE_UNLOCKED_MUSKA}
			{ text="ANDREW REYNOLDS" pro=reynolds movie=MOVIE_UNLOCKED_REYNOLDS}
			{ text="PAUL RODRIGUEZ" pro=rodriguez movie=MOVIE_UNLOCKED_RODRIGUEZ}
			{ text="GEOFF ROWLEY" pro=rowley movie=MOVIE_UNLOCKED_ROWLEY}
			{ text="ARTO SAARI" pro=saari movie=MOVIE_UNLOCKED_SAARI}
			{ text="JAMIE THOMAS" pro=thomas movie=MOVIE_UNLOCKED_THOMAS}
			{ text="MIKE VALLELY" pro=vallely movie=MOVIE_UNLOCKED_VALLELEY}
		]
	]
	// 26 Movie Goals
	[ 	
		// stage 1
		[
			{ text="Jersey Spine Trickspot Challenge" goal_id=NJ_Goal_Tetris5 level=load_nj }
			{ text="Big Apple Spot Challenge" goal_id=NY_Goal_Collect3 level=load_ny }
			{ text="Florida THPS Challenge" goal_id=FL_Goal_Horse2 level=load_fl }
			{ text="San Diego Transfer Challenge" goal_id=SD_Goal_Gaps13 level=load_sd }
			{ text="Hawaii Huge Spine Challenge" goal_id=HI_Goal_Gaps5 level=load_hi }
			{ text="Vancouver Spine Transfer Challenge" goal_id=VC_Goal_Gaps8 level=load_vc }
			{ text="Slamma Jamma" goal_id=SJ_Goal_Collect level=load_sj } // hit all the spots
			{ text="Moscow's Lost Tapes" goal_id=RU_goal_Collect2 level=load_ru } // Grind challenge
		]
	]
	// 27 New Jersey
	[ 	
		// stage 1
		[ { text="Tear Up Eric's Best Line"  goal_id=nj_goal_Counter5} ]
	]
]

Script ShownChapterTitle
    SpawnScript ShownChapterTitle_Spawned
Endscript

Script ShownChapterTitle_Spawned //=0
    kill_chapter_intro_title
    GoalManager_GetCurrentChapterAndStage
    ShowChapter=(<currentchapter>+1)
    create_chapter_intro_title chapter=<ShowChapter>
    wait 2.0 seconds
    kill_chapter_intro_title
Endscript

Script NJ_StageSwitch_0_to_1_1
//SpawnScript NJ_StageSwitch_1_1_to_1_2_Spawned
    printf "NJ_StageSwitch_0_to_1_1"
    //instant_tod_change tod_action=set_tod_newrain
    If NOT IsAlive name =TRGP_killskater_gap
        create prefix = "TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
    NJ_VallelyChecker
    NJ_Race6_CreateFluff
    NJ_Goal_Gaps4_DogChecker
	goal_stage_script_done
Endscript

Script NJ_StageSwitch_1_1_to_1_2
    SpawnScript NJ_StageSwitch_1_1_to_1_2_Spawned params=<...>
    If NOT IsAlive name =TRGP_killskater_gap
        create prefix = "TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
    NJ_Race6_KillFluff
	goal_stage_script_done
Endscript

Script NJ_StageSwitch_1_1_to_1_2_Spawned
	printf "Chapter1 - Going from Stage1 to Stage2"
    kill prefix="TRG_PS_G_Ped_"
    NJ_Goal_Gaps4_DogChecker
    //instant_tod_change tod_action=set_tod_rainoff
    If NOT IsAlive name =TRGP_killskater_gap
        create prefix = "TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
    NJ_StageSwitch_1_1_to_1_2_WeatherChange
    if GotParam just_won_goal		
		
		//unlock cutscenes
		NJ_Car_Drivable
        SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_02
		SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_02A
		kill prefix = "TRG_G_Counter2_Eric"
		create prefix = "TRG_G_Counter2_Eric"
        spawnscript NJ_StageSwitch_1_1_to_1_2_Spawned_PedAI id=spawnedpedai
        
		// BAD SAVE TRANSITION - NEED SKATERCAM TO STAY UP DURING goal_want_to_save
		goal_cam_anim_play goal_id=NJ_Goal_Null5 		
        PlaySkaterCamAnim use_last_camera  // PATCH: retain the last cam anim so that the save prompt appears over it and not at the skater,s random location
		//hide_everything //nothing will be in front of this damn cutscene
   		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
		WaitForEvent type=goal_wait_for_save
     	killskatercamanim all
		
		killspawnedscript id=spawnedpedai
		kill prefix = "TRG_G_Counter2_Eric"
		//hide_everything //nothing will be in front of this damn cutscene
		
		PlayCutscene {
			name="cutscenes\NJ_02.cut"
			unload_anims=1
			reload_anims=0
			unload_goals=1
			reload_goals=0
			RestartNode=TRG_G_PS_RestartNode
			exitScript=spawn_next_cutscene
			exitParams={name="cutscenes\nj_02a.cut" unload_anims=0 reload_anims=1 unload_goals=0 reload_goals=1 exitScript=unhide_everything RestartNode=TRG_G_PS_RestartNode ExitParams={<...>}}
		}
	else
		goal_stage_script_done
	endif
    //Skater:Killskater node=TRG_G_PS_RestartNode
Endscript

Script NJ_StageSwitch_1_1_to_1_2_Spawned_PedAI
    TRG_G_Counter2_Eric: Ped_InitAI stand
Endscript

Script NJ_StageSwitch_1_1_to_1_2_WeatherChange
    //instant_tod_change current_tod=day stop_tod=1
    DisableFog
Endscript

Script NJ_StageSwitch_1_2_to_2_1
    printf "Chapter1 - Going to Chapter2"
    if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_02B
		//hide_everything //nothing will be in front of this damn cutscene
        PlayCutscene name="cutscenes\NJ_02b.cut" exitScript=NJ_StageSwitch_1_2_to_2_1_WeatherChange RestartNode=TRG_G_PS_RestartNode ExitParams={<...>}
    else
        spawnscript NJ_StageSwitch_1_2_to_2_1_WeatherChange params = <...>
		goal_stage_script_done
    endif
    If NOT IsAlive name =TRGP_killskater_gap
        create prefix = "TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
    create prefix = "ProSet1_"
    //Skater:Killskater node=TRG_G_PS_RestartNode
Endscript

Script NJ_StageSwitch_1_2_to_2_1_WeatherChange
    // change deck to Muska's
	unhide_everything
    change_deck_to_muska
    //instant_tod_change current_tod=nj_evening stop_tod=1
    script_change_tod tod_action=set_tod_nj_evening
    //start_dynamic_tod tod_start = set_tod_day   tod_end = set_tod_evening
	//EnableFog
    //SetFogColor r=118 b=68 g=108 a=100
    //SetFogDistance distance=600
    if GotParam just_won_goal
        Spawnscript NJ_Chapter2_Test
    endif
Endscript

Script NJ_Chapter2_Test
    PauseSkaters
    create name = TRG_G_Null_Pro
    goal_cam_anim_play goal_id=NJ_Goal_Null
    kill name = TRG_G_Null_Pro 
    Skater: killskater RestartWalking node=TRG_G_Null_RestartNode 
    UnPauseSkaters
    goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
    WaitForEvent type=goal_wait_for_save
    ShownChapterTitle
Endscript

script change_deck_to_muska
    GetCurrentSkaterProfileIndex
	// deck
    EditPlayerAppearance profile=<currentSkaterProfileIndex> target=SetPart targetParams={part=deck_graphic desc_id = #"PR Deck 17" }
	// griptape
	FormatText checksumName=grip_id "Generic 2"
	EditPlayerAppearance profile=<currentSkaterProfileIndex> target=SetPart targetParams={part=griptape desc_id=<grip_id> } 
	// wheel color
	SetPlayerAppearanceColor player=<currentSkaterProfileIndex> part=board h=50 s=0 v=0 use_default_hsv=1
	// refresh skater
	RefreshSkaterModel skater=<currentSkaterProfileIndex> profile=<currentSkaterProfileIndex>
	RefreshSkaterColors skater=<currentSkaterProfileIndex> profile=<currentSkaterProfileIndex>
endscript

script change_clothes male_part=skater_m_torso part_id=#"Birdhouse Team" 
	
	GetCurrentSkaterProfileIndex
	GetSkaterProfileInfo player=<currentskaterprofileindex>
	if (<is_male> = 1)
		EditPlayerAppearance profile=<currentSkaterProfileIndex> target=SetPart targetParams={part=<male_part> desc_id=<part_id> }
		EditPlayerAppearance profile=<currentSkaterProfileIndex> target=ClearPart targetParams={ part=front_logo }
		EditPlayerAppearance profile=<currentSkaterProfileIndex> target=ClearPart targetParams={ part=back_logo }
        GoalManager_GetCurrentChapterAndStage
        if ( <currentchapter> = 19 )
            EditPlayerAppearance profile=<currentSkaterProfileIndex> target=ClearPart targetParams={ part=skater_m_backpack }
        endif
        RefreshSkaterModel skater=<currentSkaterProfileIndex> profile=<currentSkaterProfileIndex>
	endif
endscript

Script NJ_StageSwitch_2_1_to_2_2
    printf "Chapter2 - Going from Stage1 to Stage2"
    kill prefix = "TRG_Ped_Walk"
    kill prefix = "TRG_Veh"
    kill prefix = "TRG_Chpt3_Veh_DrugDealer"
    kill prefix = "TRG_SFX_TrigBox_CarFire01"
    NJ_FlyChecker    
    //start_dynamic_tod tod_start=set_tod_nj_fog tod_end=set_tod_night tod_speed=.06
//    script_change_tod tod_action=set_tod_nj_fog
    script_change_tod tod_action=set_tod_nj_night tod_action2=set_tod_newrain
//    instant_tod_change tod_action=set_tod_nj_night tod_action2=set_tod_newrain
    //start_dynamic_tod tod_start = set_tod_evening   tod_end = set_tod_night
	create prefix = "TRG_Chpt3_Veh_DrugDealer"
    If NOT IsAlive name =TRGP_killskater_gap
        create prefix = "TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
    if GotParam just_won_goal
        SpawnScript NJ_StageSwitch_2_1_to_2_2_Spawned params = <...>
	else
		goal_stage_script_done
    endif
Endscript

Script NJ_StageSwitch_2_1_to_2_2_Spawned
    wait 1 frame
    Skater:Killskater node=TRG_G_COLLECT_RestartNode
    GoalManager_ActivateGoal name=NJ_Goal_Collect
Endscript

Script NJ_StageSwitch_2_2_to_3_1
    printf "Chapter2 - Going to Chapter3"
    // At E3 don't show NJ_03 because it isn't finished enough
    ;kill name = FO_Flies_01
    TRG_G_Collect4_Pro: Obj_PlayAnim anim=Ped_M_Idle1
    If NOT IsAlive name =TRGP_killskater_gap
        create prefix = "TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
    NJ_FlyChecker
    SpawnScript NJ_StageSwitch_2_2_to_3_1_Spawned params = <...>
Endscript

Script NJ_StageSwitch_2_2_to_3_1_Spawned
    printf "===================================== NJ_StageSwitch_2_2_to_3_1_Spawned reached"
    //kill prefix = "fireA"
    kill prefix = "TRG_SFX_TrigBox_CarFire01"
    kill prefix = "TRG_Ped_Dealer"
    kill prefix = "TRG_Ped_Crackhead"
    If NOT IsAlive name =fireA01
        create prefix = "fireA"
    endif
    If NOT IsAlive name =TRG_Chpt3_Veh_DrugDealer
        create prefix = "TRG_Chpt3_Veh_DrugDealer"
    endif
    if GotParam just_won_goal
        create name = TRG_G_Null2_Pro
        Skater:KillSkater RestartWalking Node=TRG_G_Null2_RestartNode
        TRG_G_Null2_Pro: SwitchOffAtomic ped_board
        kill prefix = "fireA"
        goal_cam_anim_play goal_id=NJ_Goal_Null2
        DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
        Skater:KillSkater RestartWalking Node=TRG_G_Collect4_IntroNode
        kill name = TRG_G_Null2_Pro
        //wait 3 seconds
    endif
    create prefix = "TRG_Ped_Crackhead"
    create prefix = "TRG_Ped_Dealer"
    ;create prefix = "TRG_SFX_TrigBox_CarFire01"
    script_change_tod tod_action=set_tod_nj_morning tod_action2=set_tod_day
//    instant_tod_change current_tod=nj_morning rainoff
    kill prefix = "TRG_Ped_Walk"
    kill prefix = "TRG_Veh"
    if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_03
        PlayCutscene name="cutscenes\NJ_03.cut" exitScript=NJ_StageSwitch_2_2_to_3_1_WeatherChange RestartNode=TRG_G_Collect4_IntroNode ExitParams={<...>}
    else
        goal_stage_script_done
		Spawnscript NJ_StageSwitch_2_2_to_3_1_WeatherChange params = <...>
    endif
    If NOT IsAlive name =TRGP_killskater_gap
        create prefix = "TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
    //Skater:Killskater node=TRG_G_Collect4_IntroNode
Endscript

Script NJ_StageSwitch_2_2_to_3_1_WeatherChange
    If Not IsAlive Name = TRG_Ped_Walking05
        create prefix = "TRG_Ped_Walk"
    Endif
    If Not IsAlive name= TRG_Veh_Car_03
        create name = TRG_Veh_Car_03
    Endif
    ;If Not IsAlive name= TRG_Veh_Car_04  //Removed because it clips through burning SUV
    ;    create name = TRG_Veh_Car_04
    ;Endif
    create prefix = "ProSet1_"
    EnableFog    4
    //start_dynamic_tod tod_start=set_tod_day tod_end=set_tod_morning tod_speed=.06
    script_change_tod tod_action=set_tod_nj_morning
//    instant_tod_change current_tod=nj_morning rainoff
    if GotParam just_won_goal
    PlaySkaterCamAnim skater=0 {virtual_cam
                        targetid=world                                                  
                        targetOffset=(-5332.7, -1993.9, -8017.1)                        
                        positionOffset=(-3759.9, 134.7, 1626.3)                         
                        frames=100
                        skippable=1
                        play_hold
                        }
        goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
        Spawnscript NJ_Chapter3_Test
    endif
Endscript

Script NJ_Chapter3_Test
    WaitForEvent type=goal_wait_for_save
    PlaySkaterCamAnim skater=0 stop
    ShownChapterTitle
Endscript

Script NJ_StageSwitch_3_1_to_3_2
    //create_panel_message id=goal_muska text="Chapter3 - Going from Stage1 to Stage2"
    //set_tod_day
    WeatherSetRainRate 0.0
    printf "Chapter3 - Going from Stage1 to Stage2"
    kill prefix = "Veh_PoliceCar_NJ_"
    kill prefix = "NJ_G_NOT_BridgeQP_"
    ;kill prefix = "NJ_G_NOT_BridgeQP_06"
    kill prefix = "fireA"
    kill prefix = "TRG_SFX_TrigBox_CarFire01"
    kill prefix = "TRG_Chpt3_Veh_DrugDealer"
    create prefix = "ProSet1_"
    ;create prefix = "PRTCL_CarSmoke"
    create prefix = "fireA"
    create prefix = "TRG_SFX_TrigBox_CarFire01"
    create prefix = "TRG_Chpt3_Veh_DrugDealer"
    If IsAlive name=TRGP_killskater_gap
        kill prefix ="TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
    SpawnScript NJ_StageSwitch_3_1_to_3_2_Spawned params = <...>
Endscript

Script NJ_StageSwitch_3_1_to_3_2_Spawned
    //instant_tod_change current_tod=day stop_tod=1
    start_dynamic_tod tod_start=set_tod_nj_morning tod_end=set_tod_day tod_speed=.06 dontchangelights=1
    if GotParam just_won_goal
        create prefix = "TRG_G_Null4_Vehicle0"
        //playstream police_nj_Goal_Null4_lip vol=200
        goal_cam_anim_play goal_id=NJ_Goal_Null4
        kill prefix = "TRG_G_Null4_Vehicle0"
        Skater:Killskater node=TRG_StageSwitch_31to32_RestartNode
	else
		goal_stage_script_done
    endif
Endscript

Script NJ_StageSwitch_3_2_to_3_3
    ;Kill prefix = "PRTCL_CarSmoke"
    //create_panel_message id=goal_muska text="Chapter3 - Going from Stage2 to Stage3"
    printf "Chapter3 - Going from Stage2 to Stage3"
    EnableFog
    start_dynamic_tod tod_start=set_tod_day tod_end=set_tod_nj_evening tod_speed=.06 dontchangelights=1
    //instant_tod_change current_tod=evening stop_tod=1
    SetFogColor r=118 b=68 g=108 a=100
    SetFogDistance distance=600
    create prefix = "ProSet1_"
    kill prefix = "Veh_PoliceCar_NJ_"
    kill prefix = "NJ_G_NOT_BridgeQP_"
    ;kill prefix = "NJ_G_NOT_BridgeQP_06"
    kill prefix = "fireA"
    kill prefix = "TRG_SFX_TrigBox_CarFire01"
    kill prefix = "TRG_Chpt3_Veh_DrugDealer"
    create prefix = "fireA"
    create prefix = "TRG_SFX_TrigBox_CarFire01"
    create prefix = "TRG_Chpt3_Veh_DrugDealer"
    NJ_UnlockTrainStation
    If IsAlive name=TRGP_killskater_gap
        kill prefix ="TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
    //Spawnscript NJ_Chapter3_3_Test
	goal_stage_script_done
Endscript

Script NJ_StageSwitch_3_3_to_3_4
	//create_panel_message id=goal_muska text="Chapter3 - Going from Stage2 to Stage3"
    printf "Chapter3 - Going from Stage3 to Stage4"
    EnableFog
    script_change_tod tod_action=set_tod_nj_fog
//    instant_tod_change current_tod=evening stop_tod=1
    SetFogColor r=118 b=68 g=108 a=100
    SetFogDistance distance=600
    create prefix = "ProSet1_"
    kill prefix = "Veh_PoliceCar_NJ_"
    kill prefix = "NJ_G_NOT_BridgeQP_"
    ;kill prefix = "NJ_G_NOT_BridgeQP_06"
    kill prefix = "fireA"
    kill prefix = "TRG_SFX_TrigBox_CarFire01"
    kill prefix = "TRG_Chpt3_Veh_DrugDealer"
    NJ_UnlockTrainStation
    if GotParam just_won_goal
        SpawnScript NJ_StageSwitch_3_3_to_3_4_Spawned params = <...>
	else
		goal_stage_script_done
    Endif
    If IsAlive name=TRGP_killskater_gap
        kill prefix ="TRGP_killskater_gap" // disable the kill skater plane on the bridge
    Endif
Endscript

Script NJ_StageSwitch_3_3_to_3_4_Spawned
    wait 1 frame
    GoalManager_ActivateGoal name=NJ_Goal_Race
Endscript

Script NJ_Load_Skateshop
	printf "loading skateshop"
	change entered_skateshop_through_door=1
	change_level level=load_boardshop
Endscript

Script NJ_StageSwitch_GoingToNY
    //create_panel_message id=goal_muska text="Going to New York"
    printf "Going to New York"
//    Spawnscript NJ_StageSwitch_GoingToNY_Spawned params = <...>
//Endscript
//
//Script NJ_StageSwitch_GoingToNY_Spawned
	
	//unlock ny as a selectable level
	SetGlobalFlag flag=LEVEL_UNLOCKED_NY
	
    if GotParam just_won_goal
        NJ_Goal_Race7_Outro
        goal_cam_anim_play goal_id=NJ_Goal_Null3
		SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_04
        DisableFog     
		PlayCutscene name="cutscenes\NJ_04.cut" dont_unpause_rain_sounds exitScript=NJ_StageSwitch_GoingToNY_LevelChange ExitParams={<...>}
    else
        Spawnscript NJ_StageSwitch_GoingToNY_LevelChange params = <...>
    endif
Endscript

Script NJ_StageSwitch_GoingToNY_LevelChange
    //printf "================ NJ_StageSwitch_GoingToNY_LevelChange"
	//printstruct <...> 
	if GotParam just_won_goal
        change_level level=load_NY next_level_script=NY_Intro_play_cutscene
    endif
Endscript

script NY_Intro_play_cutscene
	SetGlobalFlag flag=VIEWED_CUTSCENE_NY_01V
	PlayCutscene name="cutscenes\NY_01v.cut" exitScript=NY_IntroSave
endscript

Script NY_IntroSave
	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	SpawnScript NY_IntroSave_Spawned params = <...>
Endscript

Script NY_IntroSave_Spawned
	WaitForEvent type=goal_wait_for_save
    ShownChapterTitle
Endscript

Script NY_StageSwitch_1_1_to_2_1
	// After beating the first set of goals in NY, this is run, setting the game to night, and playing the NY Skaters cutscene
	if GotParam just_won_goal
//		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	endif
	SpawnScript NY_StageSwitch_1_1_to_2_1_Spawned params = <...>
Endscript

Script NY_StageSwitch_1_1_to_2_1_Spawned
	printf "Chapter Stage Switching Script - running NY_StageSwitch_1_1_to_2_1"
	if GotParam just_won_goal
		NY_Null2_PreScript
        start_dynamic_tod tod_start=set_tod_day tod_end=set_tod_night dontchangelights=1
        // BAD SAVE TRANSITION
		goal_cam_anim_play goal_id=NY_Goal_Null2 	
        PlaySkaterCamAnim use_last_camera  // PATCH: retain the last cam anim so that the save prompt appears over it and not at the skater,s random location
        goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
    	WaitForEvent type=goal_wait_for_save
        killskatercamanim all
		DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
		kill name = TRG_G_Null_Eric
		skater: hide	
	endif
	//script_change_tod tod_action = set_tod_newrain
	script_change_tod tod_action = set_tod_night stop_tod=1 
	if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_NY_02
		//wait 10 frames
        PlayCutscene name="cutscenes\NY_02.cut" exitscript=NY_StageSwitch_1_1_to_2_1_Spawned_Spawned restartnode=TRG_G_HS_Pro
	else
		goal_stage_script_done
	endif	
Endscript

Script NY_StageSwitch_1_1_to_2_1_Spawned_Spawned
	// GJ:  cutscenes stop all sound effects, so this is a patch
	// to restart the rain sound effects after the NY_02.cut
	// cutscene is finished...  (on the next project, perhaps the cutscene 
	// manager can remember which sounds it has stopped, and restore 
	// them at the end of the cutscene)
    
    // FROM CHAD: this stuff here is a hack to blank the screen on restart to kill a bug
    // we were getting DMA asserts when returning to the level so we blank the screen for a second
    DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
	//skater: killskater node = TRG_G_HS_Pro
    script_change_tod tod_action = set_tod_newrain
	;script_change_tod tod_action = set_tod_night stop_tod=1 
    kill_start_key_binding
	wait .1 seconds
	skater: unhide
    HideLoadingScreen
    restore_start_key_binding
    ShownChapterTitle
Endscript

Script NY_StageSwitch_2_1_to_2_2
	printf "Chapter Stage Switching Script - running NY_StageSwitch_2_1_to_2_2"
	script_change_tod tod_action = set_tod_rainoff
    SpawnScript NY_StageSwitch_2_1_to_2_2_Spawned params = <...>
Endscript

Script NY_StageSwitch_2_1_to_2_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=NY_Goal_Race3
	else
		goal_stage_script_done
    endif
Endscript

Script NY_StageSwitch_2_2_to_2_3
	printf "Chapter Stage Switching Script - running NY_StageSwitch_2_2_to_2_3"
	goal_stage_script_done
Endscript

Script NY_StageSwitch_2_3_to_3_1
	printf "Chapter Stage Switching Script - running NY_StageSwitch_2_3_to_3_1"
	if GotParam just_won_goal
        DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
		change Display_Story_Peralta_LoadingScreen = 1
		change_level level=load_boardshop next_level_script=NY03_CutscenePlay
	else
		goal_stage_script_done
	endif
endscript

Script NY03_CutscenePlay
// Mick:  Took out at Scott's Behest ....
//	instant_tod_change current_tod=day 
	Change_Clothes male_part=skater_m_torso part_id=#"Peralta Team"
	PlayCutscene name="cutscenes\NY_03.cut" exitScript=NY03_SkateshopUnlocked
endscript

script NY03_SkateshopUnlocked	
	//DestroyScreenElement id=current_menu_anchor
		// set flag
		array=return_to_level
		SetArrayElement arrayname=array index=0 newvalue=load_ny
		change in_ny03_sequence=1
		// unlock boardshop
		SetGlobalFlag flag=BOARDSHOP_UNLOCKED
		create_dialog_box { title="Skateshop Unlocked"
						text="Free gear from Peralta is now available in the Skateshop. You can now return to the Skateshop from the Edit Skater menu."
							just=[center center]
							
						buttons=[   { font=small text="Ok" 	pad_choose_script=NY03_EnterBoardshop }
									]
						text_dims= (300,0)
							;delay_input
						  }
Endscript

Script NY03_EnterBoardshop
	dialog_box_exit
	boardshop_create_main_menu
	//change_level level=load_NY next_level_script=NULLSCRIPT
Endscript

in_ny03_sequence=0

Script NY03_back_from_boardshop
	change in_ny03_sequence=0
	change check_for_unplugged_controllers=1
	// save
	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	SpawnScript NY03_Save_Spawned params = <...>
Endscript

Script NY03_Save_Spawned
	WaitForEvent type=goal_wait_for_save
    ShownChapterTitle
Endscript

Script NY_StageSwitch_GoingToFL
	printf "Chapter Stage Switching Script - running NY_StageSwitch_GoingToFL"
	
	//unlock fl as a selectable level
	SetGlobalFlag flag=LEVEL_UNLOCKED_FL
	
	//instant_tod_change current_tod=morning stop_tod=1
    Spawnscript NY_StageSwitch_GoingToFL_Spawned params=<...>
Endscript

Script NY_StageSwitch_GoingToFL_Spawned
    if GotParam just_won_goal
        NY_Null_PreScript
		create name = TRG_G_Null_Eric
        goal_cam_anim_play goal_id=NY_Goal_Null
        DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
		kill name = TRG_G_Null_Eric
		Ny_StageSwitch_GoingToFL_LevelChange
	else
		goal_stage_script_done
	endif
Endscript

Script Ny_StageSwitch_GoingToFL_LevelChange
	change_level level=load_FL next_level_script=FL_IntroCutscene
Endscript

Script FL_IntroCutscene
	SetGlobalFlag flag=VIEWED_CUTSCENE_FL_01
	PlayCutscene name="cutscenes\FL_01.cut" exitScript=FL_IntroCutsceneSave
Endscript

Script FL_IntroCutsceneSave
	//If (DEMO_BUILD)
		// If this is the Gamepro demo, after the intro cutscene, we need to skip NY and make Stage 6 active
		//GoalManager_SetCurrentChapterAndStage chapter=6 stage=0
		//GoalManager_UninitializeAllGoals
		//GoalManager_InitializeAllGoals
	//else
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
		SpawnScript FL_IntroSave_Spawned params = <...>
	//endif	
Endscript

Script FL_IntroSave_Spawned
	WaitForEvent type=goal_wait_for_save
    ShownChapterTitle
Endscript

Script FL_StageSwitch_1_1_to_1_2
	printf "Chapter Stage Switching Script - running FL_StageSwitch_1_1_to_1_2"
    SpawnScript FL_StageSwitch_1_1_to_1_2_Spawned params = <...>
Endscript

Script FL_StageSwitch_1_1_to_1_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=FL_Goal_Gaps3
	else
		goal_stage_script_done
    endif
Endscript

Script FL_StageSwitch_1_2_to_2_1
	printf "Chapter Stage Switching Script - running FL_StageSwitch_1_2_to_2_1"
    if GotParam just_won_goal
    	FL_GOAL_RACE_Outro
        // BAD SAVE TRANSITION
		goal_cam_anim_play goal_id=FL_Goal_Null
        PlaySkaterCamAnim use_last_camera  // PATCH: retain the last cam anim so that the save prompt appears over it and not at the skater,s random location
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
    	SpawnScript FL_StageSwitch_1_2_to_2_1Save_Spawned params = <...>
    else
    	instant_tod_change current_tod=day stop_tod=1
		if Not IsAlive name=FL_Spot_Fence_Entrance_door_Closed
    		Create name=FL_Spot_Fence_Entrance_door_Closed
    	endif
    	Kill name=FL_Spot_Fence_Entrance_door_Open
		goal_stage_script_done
    endif
Endscript

Script FL_StageSwitch_1_2_to_2_1Save_Spawned
	WaitForEvent type=goal_wait_for_save
    KillSkaterCamAnim All
	DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
	//**** Open the gate
	Kill name=FL_Spot_Fence_Entrance_door_Closed
	Create name=FL_Spot_Fence_Entrance_door_Open
	instant_tod_change current_tod=day stop_tod=1
	SetGlobalFlag flag=VIEWED_CUTSCENE_FL_02
	PlayCutscene name="cutscenes\FL_02.cut" exitScript=FL_StageSwitch_1_2_to_2_1exitScript RestartNode=TRG_G_TS_RestartNode
Endscript

Script FL_StageSwitch_1_2_to_2_1exitScript
    ShownChapterTitle
	if Not IsAlive name=FL_Spot_Fence_Entrance_door_Closed
		Create name=FL_Spot_Fence_Entrance_door_Closed
	endif
	Kill name=FL_Spot_Fence_Entrance_door_Open
endscript

Script FL_StageSwitch_2_1_to_2_2
	printf "Chapter Stage Switching Script - running FL_StageSwitch_2_1_to_2_2"
    SpawnScript FL_StageSwitch_2_1_to_2_2_Spawned params = <...>
Endscript

Script FL_StageSwitch_2_1_to_2_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=FL_Goal_Tetris2
	else
		goal_stage_script_done
    endif
Endscript

Script FL_StageSwitch_2_2_to_3_1
	printf "Chapter Stage Switching Script - running FL_StageSwitch_2_2_to_3_1"
    if GotParam just_won_goal
    	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
    	SpawnScript FL_StageSwitch_2_2_to_3_1Save_Spawned params = <...>
	else
		goal_stage_script_done
    endif
Endscript

Script FL_StageSwitch_2_2_to_3_1Save_Spawned
	WaitForEvent type=goal_wait_for_save
	instant_tod_change current_tod=day stop_tod=1
	SetGlobalFlag flag=VIEWED_CUTSCENE_FL_03
	PlayCutscene name="cutscenes\FL_03.cut" exitScript=FL_StageSwitch_2_2_to_3_1exitScript RestartNode=TRG_Restart_Inside_SPoT
Endscript

script  FL_StageSwitch_2_2_to_3_1exitScript
    ShownChapterTitle
	//**** Kill the gate giving access to SPoT
	Kill name=FL_Spot_Fence_Entrance_door_Closed
	Kill name=FL_Spot_Fence_Entrance_SIgn01
	Kill name=FL_Spot_Fence_Entrance01
	Kill name=FL_Spot_Fence_Entrance02
	Kill name=FL_Skylight
	if Not IsAlive name=FL_Skylight_Breakable
		Create name=FL_Skylight_Breakable
	endif
endscript

Script FL_StageSwitch_3_1_to_3_2
	printf "Chapter Stage Switching Script - running FL_StageSwitch_3_1_to_3_2"
    SpawnScript FL_StageSwitch_3_1_to_3_2_Spawned params = <...>
Endscript

Script FL_StageSwitch_3_1_to_3_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=FL_Goal_Trickspot3
	else
		goal_stage_script_done
    endif
Endscript

Script FL_StageSwitch_GoingToSponsor
	printf "Chapter Stage Switching Script - running FL_StageSwitch_GoingToSponsor"
    // IMPORTANT!!! Do not ever let the player save after beating this stage but before selecting a Sponsor. They
	// must be forced to select a sponsor, otherwise they could select one, not save, reload, and never get to choose
	// a sponsor
	if GotParam just_won_goal
        DisplayLoadingScreen Blank  // to keep screen black during glitches
		SetGlobalFlag flag=VIEWED_CUTSCENE_FL_04
    	PlayCutscene name="cutscenes\FL_04.cut" exitScript=Sponsor_Challenge_Pre_Movie_Info ExitParams={<...>}
    else
        spawnscript Sponsor_Challenge_Chapter_Menu params = <...>
    endif
Endscript

script Sponsor_Challenge_Pre_Movie_Info
	// After the win Tampa Am cutscene, we need to tell the player that videos are coming up...
	pausegame
	create_dialog_box { title="Congrats: You're an Am!"
						text="All the major deck companies are after you. Time to check out some videos to see which sponsor best fits your style. The choice is yours!"
						just=[center center]
                        
                        buttons=[   { font=small text="Ok" 	pad_choose_script=Sponsor_Challenge_Chapter_Menu }
							    ]
						text_dims=(340,0)
					  }	
endscript

script Sponsor_Challenge_Chapter_Menu
    if not (DEMO_BUILD)
    	SpawnScript Sponsor_Challenge_Chapter_Menu2 params = <...>
    else
    	goal_stage_script_done
		SpawnScript FL_DEMO_BUILD_END params = <...>
    Endif
Endscript

script FL_DEMO_BUILD_END
    begin
        create_panel_message id=goal_complete_line2 text="DEMO BUILD" style=panel_message_goalcompleteline2
        wait 3 seconds
    repeat 5
endscript

script Sponsor_Challenge_Chapter_Menu2
	wait 1 frame
/*	// launch_chapter_menu
	GoalManager_DeactivateAllGoals
	GoalManager_GetCurrentChapterAndStage
	GoalManager_AdvanceStage force
	<stage_struct> = ( ( CHAPTER_COMPLETION_SCRIPTS[<currentChapter>] )[<currentStage>] )
	if StructureContains structure=<stage_struct> script_name
		<stage_script> = ( <stage_struct>.script_name )
	endif
	if StructureContains structure=<stage_struct> params
		<stage_script_params> = ( <stage_struct>.params )
	endif
	<stage_script> <stage_script_params>
*/
	//unlock sd as a selectable level
	SetGlobalFlag flag=LEVEL_UNLOCKED_SD
	// Make the "am" stat goal unlocked
	Skater:StatsManager_UnlockAmGoals

	select_sponsor_play_movies select_sponsor
	/*// test w/o movies
	change_level {
		level=load_boardshop
		next_level_script=select_sponsor_select_after_movies
	}*/
endscript

script boardshop_do_nothing_script
	// don't put anything in here... ever... ok? ZD
endscript

Script SD_IntroCutscene
	printf "SD_IntroCutscene"
	SetGlobalFlag flag=VIEWED_CUTSCENE_SD_01
    PlayCutscene name="cutscenes\SD_01.cut" exitScript=SD_intro_save
endscript

script SD_intro_save
	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	SpawnScript SD_IntroSave_Spawned params = <...>
Endscript

Script SD_IntroSave_Spawned
	WaitForEvent type=goal_wait_for_save
    ShownChapterTitle
    kill prefix = "TRG_TeamMember_Ped"
    create prefix = "TRG_TeamMember_Ped"
Endscript

Script SD_StageSwitch_1_1_to_1_2
	printf "Chapter Stage Switching Script - running SD_StageSwitch_1_1_to_1_2"
    kill prefix = "TRG_TeamMember_Ped"
    create prefix = "TRG_TeamMember_Ped"
    SpawnScript SD_StageSwitch_1_1_to_1_2_Spawned params = <...>
Endscript

Script SD_StageSwitch_1_1_to_1_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=SD_Goal_Tetris
	else
		goal_stage_script_done
    endif
Endscript

Script SD_StageSwitch_1_2_to_2_1
	printf "Chapter Stage Switching Script - running SD_StageSwitch_1_2_to_2_1"
    if GotParam just_won_goal
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	endif
	SpawnScript SD_StageSwitch_1_2_to_2_1Save_Spawned params = <...>
Endscript

Script SD_StageSwitch_1_2_to_2_1Save_Spawned	
    if GotParam just_won_goal
		WaitForEvent type=goal_wait_for_save
	endif
	//script_change_tod tod_action=set_tod_morning	
    if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_SD_02
		PlayCutscene name="cutscenes\SD_02.cut" exitscript=SD_StageSwitch_1_2_to_2_1Save_Spawned_Spawned restartnode=TRG_G_Race_IntroNode
	else
        goal_stage_script_done
		SD_StageSwitch_1_2_to_2_1Save_Spawned_Spawned
    endif	
Endscript

Script SD_StageSwitch_1_2_to_2_1Save_Spawned_Spawned
    ShownChapterTitle
	//script_change_tod tod_action=set_tod_morning	
    kill prefix = "TRG_TeamMember_Ped"
    kill Prefix	= "TRG_Ped_Party"		;Party peds
    Create Prefix	= "TRG_Ped_Party"		;Party peds
Endscript

Script SD_StageSwitch_2_1_to_2_2
	printf "Chapter Stage Switching Script - running SD_StageSwitch_2_1_to_2_2"
    kill Prefix	= "TRG_Ped_Party"		;Party peds
    Create Prefix	= "TRG_Ped_Party"		;Party peds
    SpawnScript SD_StageSwitch_2_1_to_2_2_Spawned params = <...>
Endscript

Script SD_StageSwitch_2_1_to_2_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=SD_Goal_Race
	else
		goal_stage_script_done
    endif
Endscript

Script SD_StageSwitch_2_2_to_3_1
	printf "Chapter Stage Switching Script - running SD_StageSwitch_2_2_to_3_1"    
    if GotParam just_won_goal
        SD_Null2_PreScript
        // BAD SAVE TRANSITION
		goal_cam_anim_play goal_id=SD_Goal_Null2		
        PlaySkaterCamAnim use_last_camera  // PATCH: retain the last cam anim so that the save prompt appears over it and not at the skater,s random location
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	endif
    kill Prefix	= "TRG_Ped_Party"		;Party peds
    kill Prefix = "TRG_Demo"
    Kill Prefix = "TRG_No_Demo"
    Create Prefix = "TRG_Demo_ledge"
    Create Prefix = "TRG_Demo_Rail"
    Create Prefix = "Geo_Demo"
	SpawnScript SD_StageSwitch_2_2_to_3_1Save_Spawned params = <...>
Endscript

Script SD_StageSwitch_2_2_to_3_1Save_Spawned
    if GotParam just_won_goal
		WaitForEvent type=goal_wait_for_save
		DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
        KillSkaterCamAnim All // we are holding the cam anim through the save process; kill it here	
	endif
    if GotParam just_won_goal
    	instant_tod_change current_tod=day stop_tod=1
		SetGlobalFlag flag=VIEWED_CUTSCENE_SD_03
		PlayCutscene name="cutscenes\SD_03.cut" exitScript=ShownChapterTitle restartnode=TRG_G_Race_IntroNode
	else
		goal_stage_script_done
	endif
Endscript

Script SD_StageSwitch_3_1_to_3_2
	printf "Chapter Stage Switching Script - running SD_StageSwitch_3_1_to_3_2"
	Create Prefix = "Geo_Demo"
	kill Prefix = "TRG_Demo"	
    Kill Prefix = "TRG_No_Demo"
    Create Prefix = "TRG_Demo_ledge"
    Create Prefix = "TRG_Demo_Rail"
    Create Prefix = "TRG_Demo_Ped"
    SpawnScript SD_StageSwitch_3_1_to_3_2_Spawned params = <...>
Endscript

Script SD_StageSwitch_3_1_to_3_2_Spawned
	if GotParam just_won_goal
		wait 1 frame
        goal_cam_anim_play goal_id=SD_Goal_Null3
		GoalManager_ActivateGoal name=SD_Goal_Tetris2
	else
		goal_stage_script_done
	endif
Endscript

Script SD_StageSwitch_GoingToHI
	printf "Chapter Stage Switching Script - running SD_StageSwitch_GoingToHI"
	
	//unlock HI as a selectable level
	SetGlobalFlag flag=LEVEL_UNLOCKED_HI
    kill Prefix = "TRG_Demo"
    SpawnScript SD_StageSwitch_GoingToHI_Spawned params = <...>
Endscript
	
Script SD_StageSwitch_GoingToHI_Spawned
	if GotParam just_won_goal
        SD_Null_PreScript
        goal_cam_anim_play goal_id=SD_Goal_Null
		SetGlobalFlag flag=VIEWED_CUTSCENE_HI_01
		PlayCutscene name="cutscenes\HI_01.cut" exitScript=SD_StageSwitch_GoingToHI_LevelChange
	else
		goal_stage_script_done
	endif
Endscript

Script SD_StageSwitch_GoingToHI_LevelChange
    change_level level=load_HI next_level_script=HI_IntroCutscene
Endscript

Script HI_IntroCutscene
	SetGlobalFlag flag=VIEWED_CUTSCENE_HI_02V
    DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
	PlayCutscene name="cutscenes\HI_02v.cut" exitScript=HI_intro_save_game
endscript

script HI_intro_save_game
	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	SpawnScript HI_intro_save_game2 params = <...>
endscript

script HI_intro_save_game2
	WaitForEvent type=goal_wait_for_save
	ShownChapterTitle
    /*SetGlobalFlag flag=CAS_PARTS_UNLOCKED_1
	create_dialog_box { title="Unlocked"
						text="New clothes available!"
						just=[center center]
                        
                        buttons=[   { font=small text="Ok" 	pad_choose_script=dialog_box_exit }
							    ]
						;delay_input
					  }	*/
Endscript

Script HI_StageSwitch_1_1_to_1_2
	printf "Chapter Stage Switching Script - running HI_StageSwitch_1_1_to_1_2"
    SpawnScript HI_StageSwitch_1_1_to_1_2_Spawned params = <...>
Endscript

Script HI_StageSwitch_1_1_to_1_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=HI_Goal_Counter2
	else
		goal_stage_script_done
    endif
Endscript

Script HI_StageSwitch_1_2_to_2_1
	printf "Chapter Stage Switching Script - running HI_StageSwitch_1_2_to_2_1"
    SpawnScript HI_StageSwitch_1_2_to_2_1_Spawn params = <...>
Endscript

Script HI_StageSwitch_1_2_to_2_1_Spawn
    if GotParam just_won_goal
        skater:hide
        goal_cam_anim_play goal_id=HI_Goal_Null        
        PlaySkaterCamAnim use_last_camera  // PATCH: retain the last cam anim so that the save prompt appears over it and not at the skater,s random location
		skater:unhide
		// BAD SAVE TRANSITION
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	endif
    SpawnScript HI_StageSwitch_1_2_to_2_1Save_Spawned params = <...>
Endscript

Script HI_StageSwitch_1_2_to_2_1Save_Spawned
    if GotParam just_won_goal
		WaitForEvent type=goal_wait_for_save
		KillSkaterCamAnim All
	endif
	//instant_tod_change current_tod=morning stop_tod=1
	
    if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_HI_03
		PlayCutscene name="cutscenes\HI_03.cut" exitscript=ShownChapterTitle restartnode=TRG_Restart_Boardwalk
	else
		goal_stage_script_done
	endif
Endscript

Script HI_StageSwitch_2_1_to_2_2
	printf "Chapter Stage Switching Script - running HI_StageSwitch_2_1_to_2_2"
    SpawnScript HI_StageSwitch_2_1_to_2_2_Spawned params = <...>
Endscript

Script HI_StageSwitch_2_1_to_2_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=HI_Goal_Trickspot
	else
		goal_stage_script_done
    endif
Endscript

Script HI_StageSwitch_2_2_to_3_1
	printf "Chapter Stage Switching Script - running HI_StageSwitch_2_2_to_3_1"
    if GotParam just_won_goal
		PlaySkaterCamAnim use_last_camera
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	endif
	SpawnScript HI_StageSwitch_2_2_to_3_1Save_Spawned params = <...>
Endscript

Script HI_StageSwitch_2_2_to_3_1Save_Spawned
    if GotParam just_won_goal
		WaitForEvent type=goal_wait_for_save
		KillSkaterCamAnim All
	endif
	//instant_tod_change current_tod=evening stop_tod=1
	
    if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_HI_04
		PlayCutscene name="cutscenes\HI_04.cut" exitscript=ShownChapterTitle RestartNode=TRG_G_GS_RestartNode
	else
		goal_stage_script_done
	endif
Endscript

Script HI_StageSwitch_3_1_to_3_2
	printf "Chapter Stage Switching Script - running HI_StageSwitch_3_1_to_3_2"
    SpawnScript HI_StageSwitch_3_1_to_3_2_Spawned params = <...>
Endscript

Script HI_StageSwitch_3_1_to_3_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=HI_Goal_GenericScore
	else
		goal_stage_script_done
    endif
Endscript

Script HI_StageSwitch_GoingToVC
	printf "Chapter Stage Switching Script - running HI_StageSwitch_GoingToVC"
	
	//unlock vc as a selectable level
	SetGlobalFlag flag=LEVEL_UNLOCKED_VC
	
	instant_tod_change current_tod=day stop_tod=1
	if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_HI_05
        PlayCutscene name="cutscenes\HI_05.cut" exitScript=HI_StageSwitch_GoingToVC_LevelChange
	else
		goal_stage_script_done
	endif
Endscript

Script HI_StageSwitch_GoingToVC_LevelChange
    change_level level=load_VC next_level_script=VC_IntroCutscene
Endscript

Script VC_IntroCutscene
	SetGlobalFlag flag=VIEWED_CUTSCENE_VC_01V
    PlayCutscene name="cutscenes\VC_01V.cut" exitScript=VC_IntroCutsceneSave
Endscript

Script VC_IntroCutsceneSave
	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	SpawnScript VC_IntroCutsceneSave_Spawned
Endscript

Script VC_IntroCutsceneSave_Spawned
	WaitForEvent type=goal_wait_for_save
    ShownChapterTitle
Endscript

Script VC_StageSwitch_1_1_to_1_2
	printf "Chapter Stage Switching Script - running VC_StageSwitch_1_1_to_1_2"
	SpawnScript VC_StageSwitch_1_1_to_1_2_Spawned params = <...>
Endscript

Script VC_StageSwitch_1_1_to_1_2_Spawned
    script_change_tod tod_action=set_tod_night
    if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=VC_Goal_Race4
	else
		goal_stage_script_done
    Endif
Endscript

Script VC_StageSwitch_GoingToSJ
	printf "Chapter Stage Switching Script - running VC_StageSwitch_GoingToSJ"
	
	//unlock slam city jam as a selectable level
	SetGlobalFlag flag=LEVEL_UNLOCKED_SP
	
	if GotParam just_won_goal
        // change level to Slam City Jam
        DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
		change Display_Story_Premiere_LoadingScreen = 1
		change_level level=load_SJ next_level_script=VC_StageSwitch_GoingToSJ_play_firstcutscene
	else
		goal_stage_script_done
	endif
Endscript

script VC_StageSwitch_GoingToSJ_play_firstcutscene
	script_change_tod tod_action = set_tod_night tod_action2 = set_tod_rainoff
	PlayCutscene {
		name="cutscenes\SJ_01A.cut"
		unload_anims=1
		reload_anims=0
		unload_goals=1
		reload_goals=0
		exitScript=spawn_next_cutscene
		exitParams={name="cutscenes\sj_01b.cut" unload_anims=0 reload_anims=1 unload_goals=0 reload_goals=1 exitScript=VC_StageSwitch_GoingToSJ_save ExitParams={<...>}}
	} 
endscript

/*
script VC_StageSwitch_GoingToSJ_play_cutscene
	// Play cutscene SJ_01
	SetGlobalFlag flag=VIEWED_CUTSCENE_SJ_01
	PlayCutscene {
		name="cutscenes\SJ_01A.cut"
		unload_anims=0
		reload_anims=1
		unload_goals=0
		reload_goals=1
		exitScript=spawn_next_cutscene
		exitParams={name="cutscenes\sj_01b.cut" unload_anims=0 reload_anims=1 unload_goals=0 reload_goals=1 exitScript=VC_StageSwitch_GoingToSJ_save ExitParams={<...>}}
	} 	
endscript
*/
Script VC_StageSwitch_GoingToSJ_save
	script_change_tod tod_action = set_tod_day tod_action2 = set_tod_rainoff
	SetGlobalFlag flag=VIEWED_CUTSCENE_SJ_01
	// save
	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	SpawnScript VC_GoingToSJSave_Spawned params = <...>
Endscript

Script VC_GoingToSJSave_Spawned
	// wait for save
	WaitForEvent type=goal_wait_for_save
    ShownChapterTitle
Endscript

Script SJ_StageSwitch_1_1_to_1_2
	printf "Chapter Stage Switching Script - running SJ_StageSwitch_1_1_to_1_2"
    if GotParam just_won_goal
        SpawnScript SJ_StageSwitch_1_1_to_1_2_Spawned
	else
		goal_stage_script_done
    endif
Endscript

Script SJ_StageSwitch_1_1_to_1_2_Spawned
    wait 1 frame
    GoalManager_ActivateGoal name=SJ_Goal_Trickspot4
Endscript

Script SJ_StageSwitch_GoingToVC
	printf "Chapter Stage Switching Script - running SJ_StageSwitch_GoingToVC"
    if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_SJ_02
		PlayCutscene name="cutscenes\SJ_02.cut" exitScript=SJ_StageSwitch_GoingToVC_LevelChange
	else
		goal_stage_script_done
	endif
Endscript

Script SJ_StageSwitch_GoingToVC_LevelChange
    SetGlobalFlag flag=CAS_PARTS_UNLOCKED_2
    // Make sure we unlock the Pro stat goals
	Skater:StatsManager_UnlockProGoals
	change in_cad_cutscene_sequence=1
	
	//unlock cad
	SetGlobalFlag flag=CAD_UNLOCKED
	change_level_to_cad
Endscript

script cad_exit_to_vc
	change in_cad_cutscene_sequence=0
    if ScreenElementExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
    load_cas_textures_to_main_memory unload
    GoalManager_SetCurrentChapterAndStage chapter=18 stage=0
	change_level level=load_VC next_level_script=VC_IntroCutscene1_9
endscript

script VC_IntroCutscene1_9
	VC_IntroCutscene2 just_came_from_cad
endscript

Script VC_IntroCutscene2
	printf "VC_IntroCutscene2"
	;GoalManager_SetCurrentChapterAndStage chapter=18 stage=0
    if GotParam just_came_from_cad
		;instant_tod_change current_tod=morning stop_tod=1
		script_change_tod tod_action= set_tod_vc_evening
		change in_deck_design = 0 // let the game know we are no longer in the CAD menus
		SpawnScript VC_IntroCutscene2Save_Spawned params = <...>
	endif
Endscript

Script VC_IntroCutscene2Save_Spawned
	printf "VC_IntroCutscene2Save_Spawned"
    VC_Goal_Null_CreatePed
    goal_cam_anim_play goal_id=VC_Goal_Null
    PlaySkaterCamAnim use_last_camera  // PATCH: retain the last cam anim so that the save prompt appears over it and not at the skater,s random location
	VC_Goal_Null_KillPed
    // BAD SAVE TRANSITION
	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	WaitForEvent type=goal_wait_for_save
	KillskaterCamAnim All
	// this null goal has replaced VC_02. In it, New Pro explains how to get a shoe sponsor
	;PlayCutscene name="cutscenes\VC_02.cut"
    instant_tod_change tod_action=set_tod_newrain
    ShownChapterTitle
Endscript

Script VC_Goal_Null_CreatePed
    Create name = TRG_G_Null_Ped
    Skater:KillSkater RestartWalking Node=TRG_G_Null_IntroNode
Endscript

Script VC_Goal_Null_KillPed
    Kill name = TRG_G_Null_Ped
    //Skater:KillSkater RestartWalking Node=TRG_G_Null_IntroNode
Endscript

Script VC_StageSwitch_2_1_to_2_2
	printf "Chapter Stage Switching Script - running VC_StageSwitch_2_1_to_2_2"
    if GotParam just_won_goal
        SpawnScript VC_StageSwitch_2_1_to_2_2_Spawned params = <...>
	else
		goal_stage_script_done
    endif
Endscript

Script VC_StageSwitch_2_1_to_2_2_Spawned
    wait 1 frame
    instant_tod_change current_tod=evening stop_tod=1
    GoalManager_ActivateGoal name=VC_Goal_Collect4
Endscript

Script VC_StageSwitch_GoingToRU
	printf "Chapter Stage Switching Script - running VC_StageSwitch_GoingToRU"
	
	//unlock ru as a selectable level
	SetGlobalFlag flag=LEVEL_UNLOCKED_RU
    If GotParam just_won_goal
        PauseSkaters
        DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
		change_level level=load_RU next_level_script=RU_play_intro_cutscene
	else
		goal_stage_script_done
	endif
	/*
	SetGlobalFlag flag=CAS_PARTS_UNLOCKED_3
	if GotParam just_won_goal
		pausegame
		create_dialog_box { title="Unlocked"
						text="New clothes available!"
						just=[center center]
                        
                        buttons=[   { font=small text="Ok" 	pad_choose_script=VC_StageSwitch_GoingToRU2 }
							    ]
						;delay_input
					  }
	endif */  
endscript

Script VC_StageSwitch_GoingToRU2
	//dialog_box_exit
    // change_level level=load_RU next_level_script=RU_play_intro_cutscene
    
Endscript

script RU_play_intro_cutscene
	SetGlobalFlag flag=VIEWED_CUTSCENE_RU_01V
	script_change_tod tod_action= set_tod_ru_day
	PlayCutscene name="cutscenes\RU_01v.cut" exitscript=VC_StageSwitch_GoingToRU_LevelChangeSave_Spawned
endscript

Script VC_StageSwitch_GoingToRU_LevelChangeSave_Spawned
	change_clothes male_part=skater_m_torso part_id=#"Russian Coat"
	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	SpawnScript RU_waitforsave
Endscript

script RU_waitforsave
    WaitForEvent type=goal_wait_for_save
    ShownChapterTitle
endscript

Script RU_StageSwitch_1_1_to_1_2
	printf "Chapter Stage Switching Script - running RU_StageSwitch_1_1_to_1_2"
    SpawnScript RU_StageSwitch_1_1_to_1_2_Spawned params = <...>
Endscript

Script RU_StageSwitch_1_1_to_1_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=RU_Goal_Gaps
	else
		goal_stage_script_done
    endif
Endscript

Script RU_StageSwitch_1_2_to_2_1
	printf "Chapter Stage Switching Script - running RU_StageSwitch_1_2_to_2_1"
	if GotParam just_won_goal
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	endif
	SpawnScript RU_StageSwitch_1_2_to_2_1Save_Spawned params = <...>
Endscript

Script RU_StageSwitch_1_2_to_2_1Save_Spawned
	if GotParam just_won_goal
		WaitForEvent type=goal_wait_for_save
			DisplayLoadingScreen blank
	endif
	script_change_tod tod_action= set_tod_ru_day_snow
	
	if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_RU_02
		PlayCutscene name="cutscenes\RU_02.cut" exitscript=ShownChapterTitle
	else
		goal_stage_script_done
	endif
Endscript

Script RU_StageSwitch_2_1_to_2_2
	printf "Chapter Stage Switching Script - running RU_StageSwitch_2_1_to_2_2"
    SpawnScript RU_StageSwitch_2_1_to_2_2_Spawned params = <...>
Endscript

Script RU_StageSwitch_2_1_to_2_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=RU_goal_GenericScore2
	else
		goal_stage_script_done
    endif
Endscript

Script RU_StageSwitch_2_2_to_3_1
	printf "Chapter Stage Switching Script - running RU_StageSwitch_2_2_to_3_1"
	SpawnScript RU_StageSwitch_2_2_to_3_1_Spawned params = <...>
Endscript
    
Script RU_StageSwitch_2_2_to_3_1_Spawned
	if GotParam just_won_goal
        PauseSkaters
        kill prefix = "TRG_G_GS2_Pro"
        create name = TRG_G_GS2_Pro
        spawnscript RU_StageSwitch_2_2_to_3_1_Spawned_Eric
        //Skater: killskater RestartWalking node=TRG_G_Gap_observer_eric 
        skater: hide
		goal_cam_anim_play goal_id=RU_Goal_Null        
        PlaySkaterCamAnim use_last_camera  // PATCH: retain the last cam anim so that the save prompt appears over it and not at the skater,s random location
		skater: unhide
        kill prefix = "TRG_G_GS2_Pro"
        UnPauseSkaters
		// Bad Save Transition
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	endif
	SpawnScript RU_StageSwitch_2_2_to_3_1Save_Spawned params = <...>
Endscript

Script RU_StageSwitch_2_2_to_3_1_Spawned_Eric
    TRG_G_GS2_Pro: Ped_InitAI Stand
Endscript

Script RU_StageSwitch_2_2_to_3_1Save_Spawned
	if GotParam just_won_goal
		WaitForEvent type=goal_wait_for_save
        DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
		KillSkaterCamAnim All
	endif	
	script_change_tod tod_action= set_tod_ru_night
	
	if GotParam just_won_goal
		SetGlobalFlag flag=VIEWED_CUTSCENE_RU_03
		PlayCutscene {
					name="cutscenes\RU_03.cut"
					unload_anims=1
					reload_anims=0
					unload_goals=1
					reload_goals=0
					exitScript=spawn_next_cutscene
					exitParams={name="cutscenes\RU_03B.cut" unload_anims=0 reload_anims=1 unload_goals=0 reload_goals=1 exitScript=RU_StageSwitch_2_2_to_3_1Save_Spawned_Spawned ExitParams={<...>}}
				}
	else
		goal_stage_script_done
	endif
Endscript

Script RU_StageSwitch_2_2_to_3_1Save_Spawned_Spawned
    // theme change
	set_current_theme theme_num=3 story_swap
	script_change_tod tod_action= set_tod_ru_night
    Spawnscript RU_StageSwitch_2_2_to_3_1Save_Spawned_Spawned_Spawned
Endscript

Script RU_StageSwitch_2_2_to_3_1Save_Spawned_Spawned_Spawned
    //wait 1 frame
    PauseSkaters
    kill prefix = "TRG_G_TS_Crew15"
    create name = TRG_G_TS_Crew15
    goal_cam_anim_play goal_id=RU_Goal_Null2
    kill prefix = "TRG_G_TS_Crew15"
    UnPauseSkaters
    skater: KillSkater node=TRG_G_Tetris2_Pro
    ShownChapterTitle
Endscript

Script RU_StageSwitch_3_1_to_3_2
	script_change_tod tod_action= set_tod_ru_night
    SpawnScript RU_StageSwitch_3_1_to_3_2_Spawned params = <...>
Endscript

Script RU_StageSwitch_3_1_to_3_2_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=RU_Goal_race4
	else
		goal_stage_script_done
    endif
Endscript

Script RU_StageSwitch_GoingToNJ
	printf "Chapter Stage Switching Script - running RU_StageSwitch_GoingToNJ"
	if GotParam just_won_goal
		Spawnscript RU_StageSwitch_GoingToNJ_LevelChange params = <...>
	else
		goal_stage_script_done
	endif
Endscript

Script RU_StageSwitch_GoingToNJ_LevelChange
	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	WaitForEvent type=goal_wait_for_save
    DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
	change_level level=load_NJ next_level_script=NJ_IntroCutscene
Endscript

Script NJ_IntroCutscene
    DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
	Change_Clothes male_part=skater_m_torso part_id=#"Peralta Team"
//	goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	SpawnScript NJ_IntroCutsceneSave_Spawned params = <...>
Endscript

Script NJ_IntroCutsceneSave_Spawned
//	WaitForEvent type=goal_wait_for_save
    kill prefix = "Veh_PoliceCar_NJ_"
    kill prefix = "NJ_G_NOT_BridgeQP_05"
    kill prefix = "NJ_G_NOT_BridgeQP_06"
    kill prefix = "TRGP_killskater_gap" // disable the goal specific kill skater plane on the bridge
	SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_05
        PlayCutscene {
			name="cutscenes\NJ_05.cut"
			unload_anims=1
			reload_anims=0
			unload_goals=1
			reload_goals=0
			RestartNode=TRG_G_PS_RestartNode
			exitScript=spawn_next_cutscene
			exitParams={name="cutscenes\nj_05b.cut" unload_anims=0 reload_anims=1 unload_goals=0 reload_goals=1 exitScript=ShownChapterTitle RestartNode=TRG_G_PS_RestartNode ExitParams={<...>}}
		} 
	//PlayCutscene name="cutscenes\NJ_05.cut" exitscript=NJ_IntroCutsceneSave_Spawned_FromMovie
Endscript

Script NJ_IntroCutsceneSave_Spawned_FromMovie
	PlayCutscene name="cutscenes\NJ_05b.cut" exitscript=ShownChapterTitle
Endscript

Script NJ_StageSwitch_FindYourself
	printf "Chapter Stage Switching Script - running NJ_StageSwitch_FindYourself"
	//if GotParam just_won_goal
        //kill_start_key_binding
    //endif
    //SpawnScript NJ_StageSwitch_FindYourself_Spawned params = <...>
	goal_stage_script_done
Endscript

Script NJ_StageSwitch_FindYourself_Spawned
	if GotParam just_won_goal
        wait 1 frame
        GoalManager_ActivateGoal name=nj_goal_Counter4
    endif
Endscript

Script NJ_StageSwitch_GoingToPros
	printf "Chapter Stage Switching Script - running NJ_StageSwitch_GoingToPros"
	// After you come back to NJ after Russia, and beat the intro goals, then this is run to set up more
	// goals to impress the kids
	if GotParam just_won_goal
		PlaySkaterCamAnim use_last_camera  // keep success cam onscreen during save prompt otherwise we see the character in flames
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
		SpawnScript NJ_StageSwitch_GoingToProsSave_Spawned params = <...>
	else
		goal_stage_script_done
	endif	
Endscript

Script NJ_StageSwitch_GoingToProsSave_Spawned
	WaitForEvent type=goal_wait_for_save
	SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_06
    DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
	KillSkaterCamAnim All
	PlayCutscene name="cutscenes\NJ_06.cut" exitScript=NJ_StageSwitch_GoingToChoosePro_Spawned
Endscript

Script NJ_StageSwitch_GoingToChoosePro_Spawned
    Spawnscript NJ_StageSwitch_GoingToChoosePro_Spawned_Spawned
Endscript
Script NJ_StageSwitch_GoingToChoosePro_Spawned_Spawned
    NJ_Goal_Null9_MoveSkater
    goal_cam_anim_play goal_id = NJ_Goal_Null9
    ShownChapterTitle
Endscript

Script Pros_StageSwitch_ChooseYourPro
	printf "Chapter Stage Switching Script - running Pros_StageSwitch_ChooseYourPro"
    create name = TRG_G_Special_Stand
    TRG_G_Special_Stand: Obj_MoveToNode name = TRG_G_Counter5_Pro orient
    skater: Obj_MoveToNode name = TRG_G_Counter5_IntroNode orient
	goal_cam_anim_play goal_id = NJ_Goal_Null6
    kill name = TRG_G_Special_Stand
	// This stage occurs after beating return to NJ goals round 2, and will send you back to the boardshop to select your team of pros
	// IMPORTANT!!!! we can not save here because we need to force the player to select team members before they can save again
	// If we don't, and they turn of their console, they could reload the game and would have no goals to beat, and no team
	//goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	SpawnScript Pros_StageSwitch_ChooseYourPro_Spawned params = <...>
Endscript
	
Script Pros_StageSwitch_ChooseYourPro_Spawned
    //WaitForEvent type=goal_wait_for_save
    kill_start_key_binding
    select_sponsor_post_movies_cleanup
	create_chapter_menu select_team	load_em=1
Endscript

Script UnlockTeamDecks
    unlock_all_sponsor_decks
	create_dialog_box { title="Unlocked"
						text="New decks available in Skateshop!"
						just=[center center]
                        
                        buttons=[   { font=small text="Ok" 	pad_choose_script=dialog_box_exit }
							    ]
						;delay_input
					  }
Endscript

Script Movies_StageSwitch_GoingToEric
	printf "Chapter Stage Switching Script - running Movies_StageSwitch_GoingToEric"
	if GotParam just_won_goal
		goal_want_to_save       //      SAVING!!!!!!!!!!!!!!!!
	endif
	SpawnScript Movies_StageSwitch_GoingToEricSave_Spawned params = <...>
Endscript

Script Movies_StageSwitch_GoingToEricSave_Spawned
	if GotParam just_won_goal
    	WaitForEvent type=goal_wait_for_save
        // Pause everything as we are about to launch your team video with footage from all the pros.
    	kill_start_key_binding
		script_change_tod tod_action= set_tod_evening
		PauseGame
		PauseMusic
		make_custom_video_intro
	    select_sponsor_play_movies show_team_movies
	endif
    kill prefix = "Veh_PoliceCar_NJ_"
    kill prefix = "NJ_G_NOT_BridgeQP_05"
    kill prefix = "NJ_G_NOT_BridgeQP_06"
    kill prefix = "TRGP_killskater_gap" // disable the goal specific kill skater plane on the bridge
    //ShownChapterTitle
	if GotParam just_won_goal
        kill_start_key_binding
	else
		goal_stage_script_done
    endif
    SpawnScript Movies_StageSwitch_GoingToEricSave_Spawned_Spawned params = <...>
Endscript

Script Movies_StageSwitch_GoingToEricSave_Spawned_Spawned
    script_change_tod tod_action= set_tod_evening
Endscript
    
Script Movies_StageSwitch_GoingToEricSave_FromMovie
    if NOT (GetGlobalFlag flag=LEVEL_UNLOCKED_SE)
        wait 1 frame
        script_change_tod tod_action= set_tod_evening
        GoalManager_ActivateGoal name=nj_goal_Counter5
    endif
Endscript

Script Eric_StageSwitch_GoingToGameOver
	printf "Chapter Stage Switching Script - running Eric_StageSwitch_GoingToGameOver"
    DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
	SetGlobalFlag flag=VIEWED_CUTSCENE_NJ_10
    if NOT (GetGlobalFlag flag=LEVEL_UNLOCKED_SE)
	    PlayCutscene name="cutscenes\NJ_10.cut" exitScript=Eric_StageSwitch_GoingToGameOver_AfterMovie
    Else
        SpawnScript Eric_StageSwitch_GoingToGameOver_AfterMovie params = <...>
    endif
Endscript
	
Script Eric_StageSwitch_GoingToGameOver_AfterMovie
    //After beating Eric's final goal, load Hawaii
	change Display_Story_Final_LoadingScreen = 1
	change_level level=load_Hi next_level_script=HI_Endgame_play_cutscene
endscript	
	
Script HI_Endgame_play_cutscene
	// Play the lost videotape
    DisplayLoadingScreen Blank  // to keep screen black during back to back movie plays
	SetGlobalFlag flag=VIEWED_CUTSCENE_FINAL
	PlayCutscene name="cutscenes\final.cut" exitScript=HI_Endgame_show_messages
endscript

Script HI_Endgame_show_messages
	//Brad says, Exitscripts get run in the same frame as the end of the cutscene, so if they need
	// to have waiting in them, they need to spawn the new script
	SpawnScript HI_Endgame_show_messages_spawned 
endscript

Script HI_Endgame_show_messages_spawned	
	//Show final messages here, allow player to save, roll credits
	PauseGame
	StopStream
	PlayStream FoundAllGaps vol=150	
	
	GoalManager_GetDifficultyLevel

	switch <difficulty_level>
	case 0
		if GetGlobalFlag flag=DIFFICULTY_MODE_TOO_EASY
			<text> = "You've unlocked:\n\c5- The Secret Level\n\c5- Additional Pro Movies\n"
			SetGlobalFlag flag=GAME_COMPLETED_TOO_EASY
		else
			<text> = "You've unlocked:\n\c5- The Secret Level\n\c5- Additional Pro Movies\n\c5- Secret Skater: \c2Iron Man\n\n\c0Marvel, Iron Man and Marvel characters: TM & (c) 2003 Marvel Characters, Inc. All rights reserved."
			SetGlobalFlag flag=GAME_COMPLETED_BEGINNER
			SetGlobalFlag flag=SKATER_UNLOCKED_IRONMAN
		endif
	case 1
		<text> = "You've unlocked:\n\c5- The Secret Level\n\c5- Additional Pro Movies\n\c5- Secret Skaters: \c2Iron Man\n\c5and \c2Gene Simmons\n\n\c0Marvel, Iron Man and Marvel characters: TM & (c) 2003 Marvel Characters, Inc. All rights reserved."
		SetGlobalFlag flag=GAME_COMPLETED_NORMAL
		SetGlobalFlag flag=SKATER_UNLOCKED_IRONMAN
		SetGlobalFlag flag=SKATER_UNLOCKED_KISSDUDE
	case 2
		<text> = "You've unlocked:\n\c5- The Secret Level\n\c5- Additional Pro Movies\n\c5- Secret Skaters: \c2Iron Man,\n\c2Gene Simmons,\n \c5and \c2T.H.U.D.\n\n\c0Marvel, Iron Man and Marvel characters: TM & (c) 2003 Marvel Characters, Inc. All rights reserved."
		SetGlobalFlag flag=GAME_COMPLETED_SICK
		SetGlobalFlag flag=SKATER_UNLOCKED_IRONMAN
		SetGlobalFlag flag=SKATER_UNLOCKED_KISSDUDE
		SetGlobalFlag flag=SKATER_UNLOCKED_CREATURE
	default
		<text> = "You've unlocked:\n- Nothing for having a incorrect difficulty level"
	endswitch
	
	//unlock secret selectable level
	SetGlobalFlag flag=LEVEL_UNLOCKED_SE
	
	unlock_team_movies
	
	create_dialog_box { title="CONGRATULATIONS!"
						title_font=testtitle
						text=<text>
						
						pos=(320 ,240)
						just=[center center]
						text_rgba=[88 105 112 128]
						text_dims=(330,0)
						line_spacing=.85
						buttons=[ { font=small text="OK" pad_choose_script=eric_unlock_accept } ]
						delay_input
						pad_focus_script=text_twitch_effect
						style=special_dialog_style
					  }
	
	WaitForEvent type=eric_unlock_accept_done
	;UnpauseGame
	
	
	//show save game prompt
	goal_want_to_save
	WaitForEvent type=goal_wait_for_save
	
	ingame_play_movie "movies\credits" level=load_skateshop
	//exit to main menu
	
	;Load_SkateShop
Endscript

script unlock_team_movies
	GoalManager_GetTeam
	
	<index>=0
	GetArraySize CHAPTER_GOALS index1=24 index2=0
	begin
		Get3DArrayData ArrayName=CHAPTER_GOALS index1=24 index2=0 index3=<index>

		// Rulon(TT13282): Unlock all pro moveies - not just ones for your team
		;if StructureContains structure=<team> ( <val>.pro )
			SetGlobalFlag flag=( <val>.movie )
		;endif
		<index> = (<index>+1)
	repeat <array_size>
endscript

script eric_unlock_accept
	end_special_dialog_style
	wait .2 seconds
	dialog_box_exit
	FireEvent type=eric_unlock_accept_done
endscript

script secret_level_unlock_cas_parts
	/*SetGlobalFlag flag=CAS_PARTS_UNLOCKED_6
	create_dialog_box { title="Unlocked"
						text="New clothes available!"
						just=[center center]
                        
                        buttons=[   { font=small text="Ok" 	pad_choose_script=dialog_box_exit }
							    ]
						;delay_input
					  }	*/
endscript


