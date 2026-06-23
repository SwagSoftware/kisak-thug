; This is just so the code doesn't assert if one of the movies that isn't in yet is selected.
script playmovie_script_temp
endscript

script PlayAllMovies
	playmovie_script "movies\THPS3"
	if GetGlobalFlag flag=MOVIE_UNLOCKED_PRO_BAILS1
		playmovie_script "movies\bails01"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_HAWK
		playmovie_script "movies\tony"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_CABALLERO
		playmovie_script "movies\cab"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_CAMPBELL
		playmovie_script "movies\kareem"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_GLIFBERG
		playmovie_script "movies\rune"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_KOSTON
		playmovie_script "movies\koston"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_LASEK
		playmovie_script "movies\bucky"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_MARGERA
		playmovie_script "movies\bam"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_MULLEN
		playmovie_script "movies\mullen"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_MUSKA
		playmovie_script "movies\muska"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_REYNOLDS
		playmovie_script "movies\andrew"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_ROWLEY
		playmovie_script "movies\rowley"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_STEAMER
		playmovie_script "movies\elissa"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_THOMAS
		playmovie_script "movies\thomas"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_CAS
		playmovie_script "movies\bails02"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_JEDIKNIGHT
		playmovie_script "movies\NSbails"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_WOLVERINE
		playmovie_script "movies\NSmakes"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_DICK
		playmovie_script "movies\proret"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_CARRERA
		playmovie_script "movies\kflip"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_BUM
		playmovie_script "movies\friends"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_SLATER
		playmovie_script "movies\slater"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_DEMONESS
		playmovie_script "movies\nsret"
	Endif
	if GetGlobalFlag flag=MOVIE_UNLOCKED_Eyeball
		playmovie_script "movies\day"
	Endif
endscript


script playmovie_script

	// playmovie_script is a wrapper around
	// playmovie that unloads the anims and/or
	// skaterparts to free up memory, and reloads
	// them back in	afterwards

	<anims_unloaded> = 0
	<pre_unloaded> = 0

	// if in front end, need to unload skaterparts
	if LevelIs load_skateshop
		// must pause objects to prevent any animations
		// being played while the anims are unloaded
		PauseObjects

		<anims_unloaded> = 1
		printf "Unloading anims here"
		do_unload_permanent
		do_unload_unloadable

		if InPreFile "skaterparts.pre"
			UnloadPreFile "skaterparts.pre"
			<pre_unloaded> = 1
		endif
	endif

	//	DumpHeaps

	mempushcontext 0
	playmovie <...>

	//Rulon (TT12855): Unloading movies while in the mainmenu area should display a loading screen (TCR C1-7).
	if isXbox
		<time>=6.0
	else
		<time>=4.5
	endif

	if LevelIs load_skateshop
		DisplayLoadingScreen "loadscrn_generic" <time>
	endif

	mempopcontext

	if ( <anims_unloaded> = 1 )
		printf "Reloading anims here"
		do_load_unloadable

		// now that the anims have been reloaded,
		// the objects are ready to play their
		// anims again
		UnpauseObjects

	endif

	// reload skaterparts after anims, or else there will be fragmentation when changing levels
	if ( <pre_unloaded> = 1 )
		// should always get reloaded onto the top down heap so that we can unload it again
		// w/o conflicting with the anims
		if not LevelIs load_skateshop
			script_assert "Can only unload skaterparts/play movies from skateshop (mainmenu) level"
		endif
		LoadPreFile "skaterparts.pre"
	endif

	if LevelIs load_skateshop
		HideLoadingScreen
	endif
endscript

script cleanup_play_movie
	goalmanager_levelunload
	cleanup preserve_skaters                ; unload all level, except for skaters
	KillMessages                            ; clean up any messages on screen
	DisablePause                            ; make sure to not let them pause mid movie
	;    SetReplayMode REPLAY_MODE_OFF           ; no replay (messes up timer)
	mempushcontext 0
	playmovie <...>
	mempopcontext
endscript


// ingame_play_movie - kills everyhting except the skater, plays a movies, then continues
script ingame_play_movie
	cleanup_play_movie <...>
	mempushcontext 0
	DisplayLoadingScreen "loadscrn_generic"
	mempopcontext

	if not GotParam level
		GetCurrentLevel
	endif

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif
	change_level level=<level>
	restore_start_key_binding
endscript


