// list of the rewards for all goals in the game!

// Each entry is a structure, the name of which is the same as the name
// of the goal.  This structure can contain one or more of:

// reward_stat: flag, adds a single stat point
// reward_stat: int, adds that many stat points (has no effect if the reward_stat
// flag is present)
// reward_cash: int, adds that much cash

goal_rewards = {
	/*
	// ***************************************
	//		sch rewards
	// ***************************************
// first 7 reward stats
	sch_goal_highscore		= { reward_stat reward_cash = 250 }
	sch_goal_skate			= { reward_stat reward_cash = 250 }
	sch_goal_combo			= { reward_stat reward_cash = 250 }
	sch_goal_race3			= { reward_stat reward_cash = 250}
	sch_goal_tetris			= { reward_stat reward_cash = 250}
	sch_goal_collect		= { reward_stat reward_cash = 250}
	sch_goal_trickspot		= { reward_stat reward_cash = 250}
// extra stat goal in college for 100 stats total
	sch_goal_race			= { reward_stat reward_cash = 250}
// rest give cash or trickslot
	sch_goal_gaps3			= {  reward_cash = 250}
	sch_goal_gaps2			= {  reward_cash = 250}
	sch_goal_proscore		= {  reward_cash = 250}
	sch_goal_counter2		= {  reward_cash = 250}
	sch_goal_comp			= {  reward_cash = 250}
	sch_goal_special		= { reward_trickslot reward_cash = 250}
	sch_goal_countercombo	= {  reward_cash = 250}
	sch_goal_counter		= {  reward_cash = 250}
// pro goals
	sch_goal_kill			= { reward_cash = 500 }
	sch_goal_gaps			= { reward_cash = 500 }
	sch_goal_procombo		= { reward_cash = 500 }
	sch_goal_horse			= { reward_cash = 500 }
	sch_goal_sickscore		= { reward_cash = 500 }
// pro specific challenges
	sch_goal_counter3		= { reward_cash = 1200 }
	sch_goal_race2			= { reward_cash = 1200 }

	// ***************************************
	//		sf2 rewards
	// ***************************************
// first 7 reward stats
	SF2_Goal_HighScore 		= { reward_stat reward_cash = 250 }
	SF2_Goal_Skate			= { reward_stat reward_cash = 250}
	SF2_Goal_Combo			= { reward_stat reward_cash = 250}
	SF2_Goal_Collect		= { reward_stat reward_cash = 250}
	SF2_Goal_Trickspot		= { reward_stat reward_cash = 250}
	SF2_Goal_Counter		= { reward_stat reward_cash = 250}
	SF2_Goal_Gaps			= { reward_stat reward_cash = 250}
// rest give cash or trickslot
	SF2_Goal_Special		= { reward_trickslot reward_cash = 250 }
	SF2_Goal_Comp			= { reward_cash = 250 }
	SF2_Goal_ProScore		= { reward_cash = 250 }
	SF2_Goal_Gaps2			= { reward_cash = 250 }
	SF2_Goal_Race2			= { reward_cash = 250 }
	SF2_Goal_Race			= { reward_cash = 250 }
	SF2_Goal_Tetris			= { reward_cash = 250 }
	SF2_Goal_Counter2		= { reward_cash = 250 }
	SF2_Goal_Horse			= { reward_cash = 250 }

// pro goals
	SF2_Goal_SickScore		= { reward_cash = 500 }
	SF2_Goal_ProCombo		= { reward_cash = 500 }
	SF2_Goal_Counter3		= { reward_cash = 500 }
	SF2_Goal_CounterCombo	= { reward_cash = 500 } //manual the pad in both directions
	SF2_Goal_Gaps3			= { reward_cash = 500 }
// pro specific challenges
	SF2_Goal_Counter4		= { reward_cash = 1200 }
	SF2_Goal_Tetris2		= { reward_cash = 1200 }
	SF2_Goal_Gaps4          = { reward_cash = 1200 }

	// ***************************************
	//		alc rewards
	// ***************************************
// first 7 reward stats
	Alc_Goal_HighScore		= { reward_stat reward_cash = 250}
	Alc_Goal_Combo			= { reward_stat reward_cash = 250}
	Alc_Goal_Skate       	= { reward_stat reward_cash = 250}
	Alc_Goal_Gaps3       	= { reward_stat reward_cash = 250}
	Alc_Goal_Race2       	= { reward_stat reward_cash = 250}
	Alc_Goal_Counter2    	= { reward_stat reward_cash = 250}
	Alc_Goal_Race3       	= { reward_stat reward_cash = 250}
// rest give cash or trickslot
	Alc_Goal_Special     	= { reward_trickslot reward_cash = 250}
	Alc_Goal_Counter        = { reward_cash = 250 }
	Alc_Goal_Comp		    = { reward_cash = 250 }
	Alc_Goal_ProScore       = { reward_cash = 250 }
	Alc_Goal_Gaps           = { reward_cash = 250 }
	Alc_Goal_Gaps6           = { reward_cash = 250 } //target launch
	Alc_Goal_Counter4       = { reward_cash = 250 }
	Alc_Goal_Trickspot      = { reward_cash = 250 }
	Alc_Goal_Tetris         = { reward_cash = 250 }
// pro goals
	Alc_Goal_SickScore      = { reward_cash = 500 }
	Alc_Goal_ProCombo       = { reward_cash = 500 }
	Alc_Goal_Race           = { reward_cash = 500 }
	Alc_Goal_Gaps2          = { reward_cash = 500 }
	Alc_Goal_Tetris2        = { reward_cash = 500 }
// pro specific challenges
	Alc_Goal_Gaps4          = { reward_cash = 1200 }
	Alc_Goal_Trickspot2     = { reward_cash = 1200 }
	Alc_Goal_Gaps5          = { reward_cash = 1200 }

	// ***************************************
	//		kon rewards
	// ***************************************
// first 7 reward stats
    Kon_Goal_HighScore     = { reward_stat reward_cash = 250}
    Kon_Goal_Skate         = { reward_stat reward_cash = 250}
    Kon_Goal_Combo         = { reward_stat reward_cash = 250}
    Kon_Goal_Comp		   = { reward_stat reward_cash = 250}
    Kon_Goal_Collect       = { reward_stat reward_cash = 250}
    Kon_Goal_Tetris2        = { reward_stat reward_cash = 250}
    Kon_Goal_Race    		 = { reward_stat reward_cash = 250}
// rest give cash or trickslot
    Kon_Goal_Gaps4         = { reward_cash = 250 }
	Kon_Goal_Special       = { reward_trickslot reward_cash = 250}
    Kon_Goal_Horse         = { reward_cash = 250 }
    Kon_Goal_ProScore      = { reward_cash = 250 }
    Kon_Goal_Counter2      = { reward_cash = 250 }
    Kon_Goal_Comp2  	= { reward_cash = 250 }
	Kon_Goal_Gaps2         = { reward_cash = 250 }
	Kon_Goal_Gaps3         = { reward_cash = 250 }
	Kon_Goal_Highcombo         = { reward_cash = 250 }

//    Kon_Goal_TBD TBD TBD TBD
// pro goals
    Kon_Goal_SickScore     = { reward_cash = 500 }
    Kon_Goal_ProCombo      = { reward_cash = 500 }
    Kon_Goal_Tour       = { reward_cash = 500 }
	Kon_Goal_Tetris     = { reward_cash = 500 }
	Kon_Goal_Gaps       = { reward_cash = 500 }

////////////////////////////////
//  *** 2 PRO CHALLENGES ***  //
////////////////////////////////
    Kon_Goal_Gaps5     = { reward_cash = 1200 }    //Mullen's Pro Specific Challenge
    Kon_Goal_Counter   = { reward_cash = 1200 }    //Steve Caballero Pro specific challenge


	// ***************************************
	//		jnk rewards
	// ***************************************
// first 7 reward stats
	Jnk_Goal_HighScore     = { reward_stat reward_cash = 250}
	Jnk_Goal_Skate         = { reward_stat reward_cash = 250}
	Jnk_Goal_Combo         = { reward_stat reward_cash = 250}
	Jnk_Goal_Trickspot2    = { reward_stat reward_cash = 250}
	Jnk_Goal_Gaps3         = { reward_stat reward_cash = 250 }
	Jnk_Goal_Counter       = { reward_stat reward_cash = 250}
	Jnk_Goal_Counter2      = { reward_stat reward_cash = 250 }
	Jnk_Goal_Collect       = { reward_cash = 250}
	Jnk_Goal_Race          = { reward_cash = 250 }
	Jnk_Goal_Kill          = { reward_cash = 250 }

// rest give cash or trickslot
	Jnk_Goal_ProScore      = { reward_cash = 250 }
	Jnk_Goal_MedCombo  	   = { reward_cash = 250 }
	Jnk_Goal_Tetris        = { reward_cash = 250 }
	Jnk_Goal_Special     = { reward_trickslot reward_cash = 250}
//	Jnk_Goal_Trickspot     = { reward_trickslot reward_cash = 250}
	Jnk_Goal_Comp   		= { reward_cash = 250 }
	Jnk_Goal_Gaps2         = { reward_cash = 250 }
// pro goals
	Jnk_Goal_Gaps4         = { reward_cash = 500}
	Jnk_Goal_SickScore     = { reward_cash = 500 }
	Jnk_Goal_ProCombo      = { reward_cash = 500 }
	Jnk_Goal_Race2         = { reward_cash = 500 }
	Jnk_Goal_Gaps          = { reward_cash = 500 }
// pro specific challenges
	Jnk_Goal_Counter3 	   = { reward_cash = 1200 }
	Jnk_Goal_Gaps5	   = { reward_cash = 1200 }
	Jnk_Goal_Gaps6	   = { reward_cash = 1200 }

	// ***************************************
	//		lon rewards
	// ***************************************
// first 7 reward stats
	Lon_Goal_HighScore     = { reward_stat reward_cash = 250 }
    Lon_Goal_Skate         = { reward_stat reward_cash = 250 }
    Lon_Goal_Combo         = { reward_stat reward_cash = 250 }
    Lon_Goal_Trickspot4    = { reward_stat reward_cash = 250 }
    Lon_Goal_Collect       = { reward_stat reward_cash = 250 }
    Lon_Goal_HighCombo     = { reward_stat reward_cash = 250 }
	Lon_Goal_Trickspot2    = { reward_stat reward_cash = 250 }
// rest give cash or trickslot
    Lon_Goal_Trickspot     = { reward_cash = 250 }
    Lon_Goal_Trickspot3    = { reward_cash = 250 }
	Lon_Goal_Gaps2         = { reward_cash = 250 }
	Lon_Goal_ProScore      = { reward_cash = 250 }
    Lon_Goal_Special       = { reward_trickslot reward_cash = 250 }
	Lon_Goal_Gaps3         = { reward_cash = 250 }
    Lon_Goal_Tetris        = { reward_cash = 250 }
	Lon_Goal_Tetris2       = { reward_cash = 250 }
    Lon_Goal_Comp   = { reward_cash = 250 }
// pro goals
    Lon_Goal_SickScore     = { reward_cash = 500 }
    Lon_Goal_ProCombo      = { reward_cash = 500 }
    Lon_Goal_Horse		   = { reward_cash = 500 }
    Lon_Goal_Gaps          = { reward_cash = 500 }
	Lon_Goal_Kill          = { reward_cash = 500 }
// Pro Challenges
	Lon_Goal_Trickspot5    = { reward_cash = 1200 }

	// ***************************************
	//		zoo rewards
	// ***************************************
// first 7 reward stats
	Zoo_Goal_HighScore     = { reward_stat reward_cash = 250}
	Zoo_Goal_Skate         = { reward_stat reward_cash = 250}
	Zoo_Goal_Combo         = { reward_stat reward_cash = 250}
	Zoo_Goal_Trickspot     = { reward_stat reward_cash = 250}
	Zoo_Goal_Tetris        = { reward_stat reward_cash = 250}
	Zoo_Goal_HighCombo2    = { reward_stat reward_cash = 250}
	Zoo_Goal_Horse         = { reward_stat reward_cash = 250}
// rest give cash or trickslot
	Zoo_Goal_Race          = { reward_cash = 250 }
	Zoo_Goal_Collect2      = { reward_cash = 250 }
	Zoo_Goal_Trickspot3    = { reward_cash = 250 }
	Zoo_Goal_ProScore      = { reward_cash = 250 }
	Zoo_Goal_Comp   = { reward_cash = 250 }
	Zoo_Goal_Gaps          = { reward_cash = 250 }
	Zoo_Goal_Trickspot4    = { reward_cash = 250 }
	Zoo_Goal_Collect       = { reward_cash = 250 }
	Zoo_Goal_Special       = { reward_trickslot reward_cash = 250}
// pro goals
	Zoo_Goal_SickScore     = { reward_cash = 500 }
	Zoo_Goal_ProCombo      = { reward_cash = 500 }
	Zoo_Goal_Gaps2         = { reward_cash = 500 }
	Zoo_Goal_Trickspot2    = { reward_cash = 500 }
	Zoo_Goal_CounterCombo  = { reward_cash = 500 }
// pro specific challenges
	Zoo_Goal_Counter       = { reward_cash = 1200 }

	// ***************************************
	//		cnv rewards
	// ***************************************
	Cnv_Goal_HighScore     = { reward_cash = 250 }
	Cnv_Goal_Skate         = { reward_cash = 250 }
	Cnv_Goal_Combo         = { reward_cash = 250 }
	Cnv_Goal_Tetris        = { reward_cash = 250 }
	Cnv_Goal_Gaps          = { reward_cash = 250 }
	Cnv_Goal_HighCombo     = { reward_cash = 250 }
	Cnv_Goal_Race          = { reward_cash = 250 }
	Cnv_Goal_Comp   		= { reward_cash = 250 }
	Cnv_Goal_SickScore     = { reward_cash = 250 }
	Cnv_Goal_ProCombo      = { reward_cash = 250 }
	Cnv_Goal_Gaps2         = { reward_cash = 250 }
	Cnv_Goal_Trickspot2    = { reward_cash = 250 }
	Cnv_Goal_Special       = { reward_cash = 250 }
	Cnv_Goal_Collect       = { reward_cash = 250 }

	// ***************************************
	//		hof rewards
	// ***************************************
	Hof_Goal_HighScore     = { reward_cash = 250 }
	Hof_Goal_Skate         = { reward_cash = 250 }
	Hof_Goal_Combo         = { reward_cash = 250 }
	Hof_Goal_Race          = { reward_cash = 250 }
	Hof_Goal_Gaps          = { reward_cash = 250 }
    Hof_Goal_Collect       = { reward_cash = 250 }
	Hof_Goal_Collect2      = { reward_cash = 250 }
	Hof_Goal_SickScore     = { reward_cash = 250 }
	Hof_Goal_ProCombo      = { reward_cash = 250 }
	Hof_Goal_Tetris        = { reward_cash = 250 }
	Hof_Goal_CounterCombo  = { reward_cash = 250 }
	Hof_Goal_HighCombo     = { reward_cash = 250 }
    Hof_Goal_Special       = { reward_cash = 250 }
	Hof_Goal_Trickspot     = { reward_cash = 250 }

*/



}
