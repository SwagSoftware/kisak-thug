///////////////////////////////////////////////////////////////////////////
// Cheats.q - the cheat menu, and commands for toggling cheats


CHEAT_SUPER_BLOOD               = CHEAT_ON_1      ; = 185
CHEAT_ALWAYS_SPECIAL            = CHEAT_ON_2      ; = 186
CHEAT_PERFECT_RAIL              = CHEAT_ON_3      ; = 187
CHEAT_STATS_13                  = CHEAT_ON_4      ; = 188
CHEAT_COOL_SPECIAL_TRICKS       = CHEAT_ON_5      ; = 189
CHEAT_MATRIX                    = CHEAT_ON_6      ; = 190
CHEAT_PERFECT_MANUAL            = CHEAT_ON_7      ; = 191
CHEAT_KID		                = CHEAT_ON_8      ; = 192
CHEAT_MOON                      = CHEAT_ON_9      ; = 193
CHEAT_SIM                       = CHEAT_ON_10     ; = 194
CHEAT_GORILLA                   = CHEAT_ON_11     ; = 195
CHEAT_PERFECT_SKITCH            = CHEAT_ON_12     ; = 196
CHEAT_BIGHEAD					= CHEAT_ON_13     ; = 197
CHEAT_HOVERBOARD				= CHEAT_ON_14     ; = 198
CHEAT_SLOMO						= CHEAT_ON_15     ; = 199
CHEAT_DISCO						= CHEAT_ON_16     ; = 183 
CHEAT_INVISIBLE					= CHEAT_ON_17     ; = 184
CHEAT_FLAME						= CHEAT_ON_18     ; = 403
CHEAT_INLINE					= CHEAT_ON_19     ; = 404

script client_toggle_cheat
    if GotParam on
        SetGlobalFlag flag=<cheat_flag>
    else
        UnSetGlobalFlag flag=<cheat_flag>
    endif
       
endscript

script toggle_cheat
    if InNetGame
        if OnServer
			if ( GetGlobalFlag flag=<cheat_flag> )
				BroadcastOmnigon <...> off
			else
				BroadcastOmnigon <...> on
			endif
        endif
    endif
    
    if InNetGame
        if NOT OmnigonAllowed <...>
            return
        endif
    endif
    
    // Meant to throw off hackers who may have modified BroadcastOmnigon to return immediately
    if InNetGame
        if Not LastBroadcastedOmnigonWas <...>
            return
        endif
    endif
    
    // Meant to throw off hackers who may have modified this function to always
    // return true
    if LastBroadcastedOmnigonWas cheat_flag=CHEAT_MADE_UP
        return
    endif
    
    GetTags
	
    if ( GetGlobalFlag flag=<cheat_flag> )
		SetScreenelementProps id={ <id> child=3 } text="Off"
		UnSetGlobalFlag flag=<cheat_flag>
		if GotParam off_callback
			<off_callback> <...>
		endif
	else
		SetScreenelementProps id={ <id> child=3 } text="On"
		SetGlobalFlag flag=<cheat_flag>
        if ( <cheat_flag>=CHEAT_BIGHEAD )
			if ScreenElementExists id=menu_gorilla
				SetScreenelementProps id={ menu_gorilla child=3 } text="Off"
				UnSetGlobalFlag flag=CHEAT_GORILLA
			endif
		endif
        if ( <cheat_flag>=CHEAT_GORILLA )
			if ScreenElementExists id=menu_bighead
				SetScreenelementProps id={ menu_bighead child=0 } text="Off"
				UnSetGlobalFlag flag=CHEAT_BIGHEAD
			endif
		endif
		
		if GotParam on_callback
			<on_callback> <...>
		endif
	endif
endscript


script unlock_all_cheat_codes
    setGlobalFlag flag = CHEAT_UNLOCKED_1
    ;setGlobalFlag flag = CHEAT_UNLOCKED_2
    setGlobalFlag flag = CHEAT_UNLOCKED_3
    ;setGlobalFlag flag = CHEAT_UNLOCKED_4
	setGlobalFlag flag = CHEAT_UNLOCKED_5    
	;setGlobalFlag flag = CHEAT_UNLOCKED_6
    ;setGlobalFlag flag = CHEAT_UNLOCKED_7
    ;setGlobalFlag flag = CHEAT_UNLOCKED_8    
	;setGlobalFlag flag = CHEAT_UNLOCKED_9
    setGlobalFlag flag = CHEAT_UNLOCKED_10
    ;setGlobalFlag flag = CHEAT_UNLOCKED_11
endscript

script  unlock_all_gameplay_cheat_codes
	setGlobalFlag flag = CHEAT_UNLOCKED_12     
	setGlobalFlag flag = CHEAT_UNLOCKED_13
	setGlobalFlag flag = CHEAT_UNLOCKED_14
	;setGlobalFlag flag = CHEAT_UNLOCKED_15
	setGlobalFlag flag = CHEAT_UNLOCKED_16
	setGlobalFlag flag = CHEAT_UNLOCKED_17
	;setGlobalFlag flag = CHEAT_UNLOCKED_18
endscript	

script unlock_all_sponsors
	SetGlobalFlag flag=BOARDS_UNLOCKED_BIRDHOUSE
	SetGlobalFlag flag=BOARDS_UNLOCKED_ELEMENT
	SetGlobalFlag flag=BOARDS_UNLOCKED_FLIP
	SetGlobalFlag flag=BOARDS_UNLOCKED_GIRL
	SetGlobalFlag flag=BOARDS_UNLOCKED_ZERO
	
	setGlobalFlag flag = MOVIE_UNLOCKED_ELEMENT
   setGlobalFlag flag = MOVIE_UNLOCKED_GIRL
   setGlobalFlag flag = MOVIE_UNLOCKED_FLIP
   setGlobalFlag flag = MOVIE_UNLOCKED_BIRDHOUSE
   setGlobalFlag flag = MOVIE_UNLOCKED_ZERO
endscript

script unlock_all_cheats
	unlock_all_cheat_codes
	unlock_all_gameplay_cheat_codes	
	cheat_unlockmovies
	cheat_reallygivelevels
	cheat_give_skaters
	SetGlobalFlag flag=CAREER_STARTED
	unlock_all_chapters	
	unlock_all_sponsors	
	unlock_all_cutscenes
	
	cheat_unlock_pedgroup1
	cheat_unlock_pedgroup2
	cheat_unlock_pedgroup3
	cheat_unlock_pedgroup4
	cheat_unlock_pedgroup5
	cheat_unlock_pedgroup6
	cheat_unlock_pedgroup7
	cheat_unlock_pedgroup8
	cheat_unlock_pedgroup9	   
;	cheat_give_jenna
endscript

script  cheat_give_skaters
	SetGlobalFlag flag=SKATER_UNLOCKED_IRONMAN
	SetGlobalFlag flag=SKATER_UNLOCKED_KISSDUDE
	SetGlobalFlag flag=SKATER_UNLOCKED_CREATURE
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=GOT_ALL_GAPS
;	UnlockSkater name=jango
;	UnlockSkater name=eddie
;	UnlockSkater name=vallely  
endscript

script cheat_give_im
	SetGlobalFlag flag=SKATER_UNLOCKED_IRONMAN
endscript

script cheat_give_kiss
	SetGlobalFlag flag=SKATER_UNLOCKED_KISSDUDE
endscript

script cheat_give_thud
	SetGlobalFlag flag=SKATER_UNLOCKED_CREATURE
endscript

//Eric, Stacy, Todd
script cheat_unlock_pedgroup1
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDGROUP1
endscript

//Bum, Addict, Dealer
script cheat_unlock_pedgroup2
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDGROUP2
endscript

//Chef, Construction Worker, Man Cop
script cheat_unlock_pedgroup3
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDGROUP3
endscript

//Security, Street Warrior, Headstone
script cheat_unlock_pedgroup4
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDGROUP4
endscript

//Business, Trooper, Factory Worker
script cheat_unlock_pedgroup5
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDGROUP5
endscript

//Desk Clerk, Doorman, Gardener
script cheat_unlock_pedgroup6
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDGROUP6
endscript

//DJ Qbert, Team Filmer, Leaf Blower
script cheat_unlock_pedgroup7
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDGROUP7
endscript

//KGB, Tank Guard
script cheat_unlock_pedgroup8
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDGROUP8
endscript

//Paul, Peter, Ace
script cheat_unlock_pedgroup9
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDS
	SetGlobalFlag flag=SKATER_UNLOCKED_PEDGROUP9
endscript

script cheat_give_jenna
;	UnlockSkater name=jenna
endscript


script cheat_togglemetrics
	Togglemetrics
endscript

script cheat_togglememmetrics
    ToggleMemMetrics
endscript

script cheat_unlockmovies

// PROS
	setGlobalFlag flag = MOVIE_UNLOCKED_HAWK      
	setGlobalFlag flag = MOVIE_UNLOCKED_CABALLERO 
	setGlobalFlag flag = MOVIE_UNLOCKED_CAMPBELL  
	setGlobalFlag flag = MOVIE_UNLOCKED_GLIFBERG  
	setGlobalFlag flag = MOVIE_UNLOCKED_KOSTON    
	setGlobalFlag flag = MOVIE_UNLOCKED_LASEK     
	setGlobalFlag flag = MOVIE_UNLOCKED_MARGERA   
	setGlobalFlag flag = MOVIE_UNLOCKED_MULLEN    
	setGlobalFlag flag = MOVIE_UNLOCKED_MUSKA     
	setGlobalFlag flag = MOVIE_UNLOCKED_REYNOLDS  
	setGlobalFlag flag = MOVIE_UNLOCKED_ROWLEY    
	setGlobalFlag flag = MOVIE_UNLOCKED_STEAMER   
	setGlobalFlag flag = MOVIE_UNLOCKED_THOMAS    
	setGlobalFlag flag = MOVIE_UNLOCKED_BURNQUIST 											  
	setGlobalFlag flag = MOVIE_UNLOCKED_VALLELEY 
	setGlobalFlag flag = MOVIE_UNLOCKED_RODRIGUEZ
	setGlobalFlag flag = MOVIE_UNLOCKED_SAARI  
	
// SECRET CHARACTERS	  
	;setGlobalFlag flag = MOVIE_UNLOCKED_JENGO     
	;setGlobalFlag flag = MOVIE_UNLOCKED_EDDIE     
	setGlobalFlag flag = MOVIE_UNLOCKED_CAS  
	
// TEASERS
   setGlobalFlag flag = MOVIE_UNLOCKED_ELEMENT
   setGlobalFlag flag = MOVIE_UNLOCKED_GIRL
   setGlobalFlag flag = MOVIE_UNLOCKED_FLIP
   setGlobalFlag flag = MOVIE_UNLOCKED_BIRDHOUSE
   setGlobalFlag flag = MOVIE_UNLOCKED_ZERO


		
	setGlobalFlag flag = MOVIE_UNLOCKED_HOMIES1   
	setGlobalFlag flag = MOVIE_UNLOCKED_KISS   
	setGlobalFlag flag = MOVIE_UNLOCKED_OUTTAKES  
	setGlobalFlag flag = MOVIE_UNLOCKED_BAILS2
	setGlobalFlag flag = MOVIE_UNLOCKED_KONA
endscript

script unlock_all_cutscenes1
	<index> = 250
	begin
		SetGlobalFlag flag=<index>
		<index> = (<index>+1)
	repeat 36
endscript

script cheat_xxx
    printf "Cheat without a cheatscript"
endscript

script cheat_give_neversoft_skaters
	// tells the CAS keyboard controls to be
	// on the lookout for neversoft skaters
	change give_neversoft_skaters = 1
endscript

script cheat_select_shift
	// tells the CAS keyboard controls to be
	// on the lookout for neversoft skaters
	change select_shift = 1
endscript

script cheat_playsound_good
	PlaySound CheatGood
endscript

script cheat_playsound_bad
	printf "******************Playing Cheat Bad Sound*****************"
	PlaySound CheatBad
endscript

script cheat_toggle_net_metrics
	ToggleNetMetrics
endscript

script cheat_reset
	ResetPS2
endscript

script cheat_resethd
	ResetHD
endscript

script cheat_reallygivelevels
  printf "unlocking levels"
	SetGlobalFlag flag=LEVEL_UNLOCKED_NJ
	SetGlobalFlag flag=LEVEL_UNLOCKED_NY 
	SetGlobalFlag flag=LEVEL_UNLOCKED_FL 
	SetGlobalFlag flag=LEVEL_UNLOCKED_SD 
	SetGlobalFlag flag=LEVEL_UNLOCKED_HI 
	SetGlobalFlag flag=LEVEL_UNLOCKED_VC 
	SetGlobalFlag flag=LEVEL_UNLOCKED_SP 
	SetGlobalFlag flag=LEVEL_UNLOCKED_RU 
	SetGlobalFlag flag= LEVEL_UNLOCKED_SE
	SetGlobalFlag flag= LEVEL_UNLOCKED_SC2
	SetGlobalFlag flag= LEVEL_UNLOCKED_VN
	SetGlobalFlag flag= LEVEL_UNLOCKED_HN
	SetGlobalFlag flag= LEVEL_UNLOCKED_VN
	SetGlobalFlag flag= LEVEL_UNLOCKED_HN
	
	SetGlobalFlag flag=CAD_UNLOCKED 
	SetGlobalFlag flag=BOARDSHOP_UNLOCKED 
endscript

script cheat_enable_screenshots
    printf "screenshots"
    change select_shift = 1;
    change memcard_screenshots = 1
endscript

script cheat_unlock_always_special
	SetGlobalFlag flag=CHEAT_UNLOCKED_12
endscript

script cheat_unlock_perfect_rail
	SetGlobalFlag flag=CHEAT_UNLOCKED_13
endscript

script cheat_unlock_perfect_skitch
	SetGlobalFlag flag=CHEAT_UNLOCKED_14
endscript

/*script cheat_unlock_stats_13
	SetGlobalFlag flag=CHEAT_UNLOCKED_15
endscript*/

script cheat_unlock_perfect_manual
	SetGlobalFlag flag=CHEAT_UNLOCKED_16
endscript

script cheat_unlock_moon_grav
	SetGlobalFlag flag=CHEAT_UNLOCKED_17
endscript

/*script cheat_unlock_matrix
	SetGlobalFlag flag=CHEAT_UNLOCKED_18
endscript*/

script cheat_unlock_inline
	if ( GetGlobalFlag flag=CHEAT_ON_19 )
		UnSetGlobalFlag flag=CHEAT_ON_19
	else
		SetGlobalFlag flag=CHEAT_ON_19
	endif
endscript

// (see actual cheat scripts above)

