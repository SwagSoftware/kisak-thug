

MusicVolume = 60  // global default music volume -- 0 to 100 percent.
MusicStreamVolume = 100  // global default music stream volume (cutscenes) -- 0 to 100 percent.

// These sounds and music files
// are permanently loaded in memory on startup...
// Don't forget the FLAG_PERM on all of these!

script LoadPermSounds
LoadPermSFX
LoadPermSongs
endscript

script LoadPermSFX
LoadPreFile "skater_sounds.pre"





//
//			**** FOLEY AND BAIL SOUNDS ****
//
//
//OLD Foley and Bail Sounds - Pre Skate5
//LoadSound "Skater\bail04" FLAG_PERM  vol = 50        // sound bail04 = 8k
//LoadSound "Skater\bail05" FLAG_PERM  vol = 50        // sound bail05 = 8k
//LoadSound "Skater\bodysmackA" FLAG_PERM  vol = 50    // sound bodysmackA = 4k
//LoadSound "Skater\headsmackB" FLAG_PERM              // sound headsmackB = 3k

//LoadSound "Skater\boardbail01" FLAG_PERM  vol = 50       // sound boardbail01  =  23k  
//LoadSound "Skater\boardbail02" FLAG_PERM  vol = 50       // sound boardbail02  =  22k  
LoadSound "Skater\foleymove01" FLAG_PERM  vol = 50       // sound foleymove01  =  16k  
//LoadSound "Skater\foleyslide04" FLAG_PERM  vol = 50      // sound foleyslide04 =  14    

LoadSound "Skater\hitblood01" FLAG_PERM  vol = 50        // sound hitblood01   =  7  
LoadSound "Skater\hitblood02" FLAG_PERM  vol = 50        // sound hitblood02   =  6
LoadSound "Skater\hitblood03" FLAG_PERM  vol =50  
//LoadSound "Skater\hitblood04" FLAG_PERM  vol = 50        // sound hitblood04   =  10  
//LoadSound "Skater\hitblood05" FLAG_PERM  vol = 50        // sound hitblood05   =  4  
 
//LoadSound "Skater\bitchslap2" FLAG_PERM            // sound bitchslap2 = 7k  
//LoadSound "Skater\hitface01" FLAG_PERM  vol = 50         // sound  hitface01   =  5  
//LoadSound "Skater\hitface02" FLAG_PERM  vol = 50         // sound  hitface02   =  6  

//LoadSound "Skater\bail_knee1" FLAG_PERM            // sound bail_knee1 = 55k    
//LoadSound "Skater\bail_backward1" FLAG_PERM        // sound bail_backward1 = 39k  
//LoadSound "Skater\Bailrunoutflip" FLAG_PERM        // sound Bailrunoutflip = 28k
//LoadSound "Skater\Nosemanualbail" FLAG_PERM        // sound Nosemanualbail = 24k

//LoadSound "Skater\hitbody02" FLAG_PERM
//LoadSound "Skater\hitbody03" FLAG_PERM  vol = 50         // sound  hitbody03   =  9  
//LoadSound "Skater\hitbody04" FLAG_PERM  vol = 50         // sound  hitbody04   =  6






//
//		**** NEW BAIL SOUNDS (as of 04/29/03) ****
//
//
LoadSound "Skater\Bails\BailBodyPunch01_11" FLAG_PERM vol=100   
LoadSound "Skater\Bails\BailBodyPunch02_11" FLAG_PERM vol=100   
LoadSound "Skater\Bails\BailBodyPunch03_11" FLAG_PERM vol=100   
LoadSound "Skater\Bails\BailBodyPunch04_11" FLAG_PERM vol=100   
LoadSound "Skater\Bails\BailBodyPunch05_11" FLAG_PERM vol=100

LoadSound "Skater\Bails\BailBodyFall01" FLAG_PERM vol=100      
LoadSound "Skater\Bails\BailBodyFall02" FLAG_PERM vol=100      
LoadSound "Skater\Bails\BailBodyFall03" FLAG_PERM vol=100      
LoadSound "Skater\Bails\BailBodyFall04" FLAG_PERM vol=100      
LoadSound "Skater\Bails\BailBodyFall05" FLAG_PERM vol=100

LoadSound "Skater\Bails\BailCrack01" FLAG_PERM vol=100            
//LoadSound "Skater\Bails\BailCrack02" FLAG_PERM vol=100            
//LoadSound "Skater\Bails\BailCrack03" FLAG_PERM vol=100

LoadSound "Skater\Bails\BailSlap01" FLAG_PERM vol=100                        
LoadSound "Skater\Bails\BailSlap02" FLAG_PERM vol=100                        
LoadSound "Skater\Bails\BailSlap03" FLAG_PERM vol=100

LoadSound "Skater\Bails\BailScrape01" FLAG_PERM vol=100                                                
LoadSound "Skater\Bails\BailScrape02" FLAG_PERM vol=100                                                
LoadSound "Skater\Bails\BailScrape03" FLAG_PERM vol=100

LoadSound "Skater\Bails\BailBoard01" FLAG_PERM vol=100                                                
LoadSound "Skater\Bails\BailBoard02" FLAG_PERM vol=100
LoadSound "Skater\Bails\BailBoard03" FLAG_PERM vol=100
LoadSound "Skater\Bails\BailBoard04" FLAG_PERM vol=100
LoadSound "Skater\Bails\BailBoard05" FLAG_PERM vol=100



//
//		**** WALKING SOUNDS	****
//
//

LoadSound "Skater\Walking\WalkStepConc01_11" FLAG_PERM  vol=100
//LoadSound "Skater\Walking\WalkStepConc02_11" FLAG_PERM  vol=100
LoadSound "Skater\Walking\WalkStepConc03_11" FLAG_PERM  vol=100
//LoadSound "Skater\Walking\WalkStepConc04_11" FLAG_PERM  vol=100
LoadSound "Skater\Walking\WalkStepConc05_11" FLAG_PERM  vol=100

LoadSound "Skater\Walking\RunStepConc01" FLAG_PERM  vol=100
LoadSound "Skater\Walking\RunStepConc02" FLAG_PERM  vol=100
LoadSound "Skater\Walking\RunStepConc03" FLAG_PERM  vol=100
LoadSound "Skater\Walking\RunStepConc04" FLAG_PERM  vol=100
LoadSound "Skater\Walking\RunStepConc05" FLAG_PERM  vol=100

LoadSound "Skater\Walking\ScuffStepConc01" FLAG_PERM  vol=100
LoadSound "Skater\Walking\ScuffStepConc02" FLAG_PERM  vol=100

LoadSound "Skater\Walking\JumpStepConc01" FLAG_PERM  vol=100
//LoadSound "Skater\Walking\JumpStepConc02" FLAG_PERM  vol=100

//LoadSound "Skater\Walking\LandStepConc01" FLAG_PERM  vol=100
LoadSound "Skater\Walking\LandStepConc02" FLAG_PERM  vol=100











//
//		**** MENU SOUNDS ****
//
//
LoadSound "Shared\Menu\menu03" FLAG_PERM  NOREVERB
//LoadSound "Shared\Menu\GUI_type02" FLAG_PERM vol=100
LoadSound "Shared\Menu\PauseExit" FLAG_PERM vol=100  NOREVERB
LoadSound "Shared\Menu\GUI_buzzer01" FLAG_PERM vol=100  NOREVERB

//LoadSound "Shared\Menu\MenuDown" FLAG_PERM
LoadSound "Shared\Menu\MenuUp" FLAG_PERM  NOREVERB      

//LoadSound "Shared\Menu\GoToLoadLevel" FLAG_PERM    
//LoadSound "Shared\Goals\AcquireAward" FLAG_PERM






//
//	**** UI THEME SPECIFIC MENU SOUNDS ****
//
//
LoadSound "Shared\Menu\DE_IconTurnZoom" FLAG_PERM  NOREVERB
LoadSound "Shared\Menu\DE_MenuFlyUp" FLAG_PERM  NOREVERB
LoadSound "Shared\Menu\DE_MenuSelect" FLAG_PERM  NOREVERB
LoadSound "Shared\Menu\DE_PauseFlyIn" FLAG_PERM  NOREVERB
LoadSound "Shared\Menu\DE_MenuBack" FLAG_PERM  NOREVERB


           

           

//
//			**** BOARD Sounds ****
//
//
LoadSound "Skater\boneless09" FLAG_PERM              // sound boneless09 = 8k          
LoadSound "Skater\copinghit3_11" FLAG_PERM vol=100	
         
           
           




//
//			**** GOAL SOUNDS ****
//
//           
LoadSound "Shared\Menu\timeoutA" FLAG_PERM vol=50  NOREVERB
LoadSound "Shared\Goals\GapSound" FLAG_PERM vol = 100 dropoff = 0  NOREVERB   
LoadSound "Shared\Goals\GoalDone" FLAG_PERM vol = 100 dropoff = 0  NOREVERB
LoadSound "Shared\Goals\TetrisAway" FLAG_PERM  NOREVERB

LoadSound "Shared\Goals\GoalGood02" FLAG_PERM  NOREVERB
LoadSound "Shared\Goals\GoalFail" FLAG_PERM  NOREVERB
LoadSound "Shared\Goals\GoalMidGood" FLAG_PERM  NOREVERB
//LoadSound "Shared\Goals\Cash" FLAG_PERM vol = 100 dropoff = 150  NOREVERB

LoadSound "Shared\Goals\ExtraTrick" FLAG_PERM  NOREVERB
LoadSound "Shared\Goals\PerfectLanding" FLAG_PERM  NOREVERB
LoadSound "Shared\Goals\HUDtrickslopC" FLAG_PERM  NOREVERB
LoadSound "Shared\Goals\HUD_jumpgap" FLAG_PERM  NOREVERB        // sound HUD_jumpgap = 2k
LoadSound "Shared\Goals\HUD_specialtrickAA" FLAG_PERM  NOREVERB // sound HUD_specialtrickAA = 9k

LoadSound "Shared\Goals\LandCombo01" FLAG_PERM  NOREVERB
LoadSound "Shared\Goals\GotStat04"  FLAG_PERM  NOREVERB           
        
 

   


//
//		**** OTHERS ****
//
//

//LoadSound "Skater\laserfire" FLAG_PERM

//
//  Changes by David Rowe on 09/02/03
//  unloaded clap sounds - aren't used
//  loaded boardbounce sound
//
//LoadSound "Skater\clap01" FLAG_PERM
//LoadSound "Skater\clap02" FLAG_PERM
//LoadSound "Skater\clap03" FLAG_PERM
LoadSound "Skater\BoardBounce01" FLAG_PERM
//
// changes on 09/02/03 end here


LoadSound "Shared\Misc\FlipTransitionUp01" FLAG_PERM
LoadSound "Shared\Misc\FlipTransitionDown01" FLAG_PERM
LoadSound "Shared\Goals\ClockTickUp" FLAG_PERM  NOREVERB
LoadSound "Shared\Goals\ClockTickDown" FLAG_PERM  NOREVERB

LoadSound "Shared\Goals\FlamingFireBall01" FLAG_PERM








UnloadPreFile "skater_sounds.pre"
endscript

locked_track1=33
locked_track2=34

script LoadPermSongs
	if ( (isTrue TestMusicFromHost) || (CD) ) 
		LoadMusicHeader "music\music"
		
		GetArraySize playlist_tracks
		index=0
		begin
			path=( (playlist_tracks[<index>]).path )
			FormatText textname=tracktitle "%b: %t" b=( (playlist_tracks[<index>]).band ) t=( (playlist_tracks[<index>]).track_title )
			AddMusicTrack <path> FLAG_PERM TrackTitle=<tracktitle>
			index = ( <index> + 1 )
		repeat <array_size>
		
		// turn off Kiss songs
		if not GetGlobalFlag flag=KISS_SONGS_UNLOCKED
			ChangeTrackState locked_track1 off
			ChangeTrackState locked_track2 off
		endif
	endif
endscript

// Array of tracks for playlist
// genres - punk=0 hiphop=1 rock/other=2
playlist_tracks = [
    
	//MAKE SURE YOU KEEP THESE IN ALPHABETICAL ORDER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
	{ band="Aceyalone"				track_title="Rapps on Deck" 			genre=1		path="music\vag\songs\Aceyalone"	}
	;{ band="Bluecollar Special" 	track_title="Don’t Wait" 				genre=0		path="music\vag\songs\BlueCollar"  	}
	{ band="Alkaline Trio" 			track_title="Armageddon" 				genre=0		path="music\vag\songs\Alkaline"	}
	{ band="Anacron" 				track_title="A Prototype" 				genre=1 	path="music\vag\songs\Anacron"	}
	{ band="Angry Amputees" 		track_title="She Said" 					genre=0 	path="music\vag\songs\AngryAmp"	}
	{ band="Assorted Jelly Beans" 	track_title="Rebel Yell" 				genre=0 	path="music\vag\songs\Assorted"	}
	{ band="Authority Zero" 		track_title="Everyday" 					genre=2 	path="music\vag\songs\AuthorityZ"	}
	{ band="Bad Religion" 			track_title="Big Bang" 					genre=0 	path="music\vag\songs\BadReligion"	}
	{ band="Blind Iris" 			track_title="Drive" 					genre=2 	path="music\vag\songs\BlindIris"	}
	{ band="Blue Collar Special" 	track_title="Don't Wait" 				genre=0 	path="music\vag\songs\BlueCollar"	}
	{ band="Bracket" 				track_title="2 Rak 005" 				genre=0 	path="music\vag\songs\Bracket"	}
	{ band="Busdriver" 				track_title="Imaginary Places" 			genre=1 	path="music\vag\songs\Busdriver" 	}
	{ band="CamaroSmith" 			track_title="It's Alright" 				genre=2 	path="music\vag\songs\CamaroSmith"  }
	{ band="Cannibal Ox" 			track_title="Iron Galaxy" 				genre=1 	path="music\vag\songs\Cannibal"  }
	{ band="Clutch" 				track_title="Impetus" 					genre=2 	path="music\vag\songs\Clutch"  }
	{ band="Crash and Burn" 		track_title="Crazy and Stupid" 			genre=2 	path="music\vag\songs\CrashBurn"  }
	{ band="Dan the Automator" 		track_title="A Better Tomorrow" 		genre=1 	path="music\vag\songs\DanAuto"  }
	{ band="Deltron 3030" 			track_title="Positive Contact" 			genre=1 	path="music\vag\songs\Deltron"  }
	{ band="DJ Qbert" 				track_title="Cosmic Assassins" 			genre=1 	path="music\vag\songs\DJQbert"   	}
	{ band="Dropkick Murphys" 		track_title="Time To Go" 				genre=0 	path="music\vag\songs\DropkickM"   	}
	{ band="Electric Frankenstein" 	track_title="Annies Grave" 				genre=2 	path="music\vag\songs\ElectricF"   	}
	{ band="Entombed" 				track_title="To Ride, Shoot, Speak..." 	genre=2 	path="music\vag\songs\Entombed"   	}
	{ band="Five Horse Johnson" 	track_title="Mississippi King" 			genre=2 	path="music\vag\songs\FiveHorse"   	}
	{ band="Flamethrower" 			track_title="I Want it All" 			genre=0 	path="music\vag\songs\FlameThrower"	}
	{ band="Frog One" 				track_title="Blah Blah" 				genre=1 	path="music\vag\songs\FrogOne"	}
	{ band="Fu Manchu" 				track_title="California Crossing" 		genre=2 	path="music\vag\songs\FuManchu" 	}
	{ band="GBH" 					track_title="Crush 'Em" 				genre=0		path="music\vag\songs\GBH" 	}
	{ band="High on Fire" 			track_title="Hung, Drawn and Quartered" genre=2 	path="music\vag\songs\HighFire" 	}
	{ band="Hot Water Music" 		track_title="Remedy" 					genre=2 	path="music\vag\songs\HotWater" 	}
    { band="In Flames" 				track_title="Embody the Invisible" 		genre=2 	path="music\vag\songs\InFlames"  	}
	{ band="J-Live" 				track_title="Braggin' Writes Revisited" genre=1		path="music\vag\songs\JLive"  	}
	{ band="Jane's Addiction" 		track_title="Suffer Some" 				genre=2 	path="music\vag\songs\JanesA"    	}
	{ band="Juggaknots" 			track_title="The Circle Pt. 1" 			genre=1 	path="music\vag\songs\Juggaknots"    	}
	{ band="Jurassic 5" 			track_title="A Day at the Races" 		genre=1 	path="music\vag\songs\Jurassic"    	}
	{ band="Kiss" 					track_title="God of Thunder" 			genre=2 	path="music\vag\songs\KissThunder"	}
	{ band="Kiss" 					track_title="Lick It Up" 				genre=2 	path="music\vag\songs\KissLick"	}
	{ band="Kiss" 					track_title="Rock-N-Roll All Night" 	genre=2 	path="music\vag\songs\KissRockNRoll"	}
	{ band="Lamont" 				track_title="Hotwire" 					genre=2 	path="music\vag\songs\Lamont"    	}
	{ band="L A Symphony" 			track_title="King Kong" 				genre=1	 	path="music\vag\songs\LASymph"	}
	{ band="Living Legends" 		track_title="War Games" 				genre=1	 	path="music\vag\songs\LivingL"	}
	{ band="Mastodon" 				track_title="Crusher Destroyer" 		genre=2 	path="music\vag\songs\Mastadon"	}
	{ band="Mike V and the Rats" 	track_title="The Days" 					genre=0 	path="music\vag\songs\MikeV"        }
	{ band="Mr Complex" 			track_title="Underground Up" 			genre=1 	path="music\vag\songs\MrComplex"        }
	{ band="Mr Dibbs" 				track_title="Skin Therapy" 				genre=1 	path="music\vag\songs\MrDibbs"        }
	{ band="Mr Lif" 				track_title="Phantom" 					genre=1 	path="music\vag\songs\MrLif"        }
	{ band="Murs" 					track_title="Transitions as a Ridah" 	genre=1 	path="music\vag\songs\Murs"         }
	{ band="NAS" 					track_title="The World is Yours" 		genre=1 	path="music\vag\songs\NAS"         }
	{ band="Nine Pound Hammer" 		track_title="Run Fat Boy Run" 			genre=2 	path="music\vag\songs\NinePound"         }
	{ band="NOFX" 				   	track_title="Separation of Church and Skate" genre=0 path="music\vag\songs\NOFX"   }
	{ band="Orange Goblin" 			track_title="Your World Will Hate This" genre=2 	path="music\vag\songs\OrangeG"   }
	{ band="Paint It Black" 		track_title="Womb Envy" 				genre=0 	path="music\vag\songs\PaintBlack"   }
	{ band="P.U.T.S." 				track_title="The Next Step II" 			genre=1 	path="music\vag\songs\PeopleStairs"   }
	{ band="Q.O.T.S.A." 			track_title="Millionaire" 				genre=2 	path="music\vag\songs\Queens"   }
	{ band="Quasimoto" 				track_title="Low Class Conspiracy" 		genre=1 	path="music\vag\songs\Quasimoto"   }
	{ band="RA the Ruggedman" 		track_title="King of the Underground" 	genre=1 	path="music\vag\songs\Ruggedman"   }
	{ band="Refused" 				track_title="New Noise" 				genre=0 	path="music\vag\songs\Refused"   }
	{ band="Rise Against" 			track_title="Like the Angels" 			genre=0 	path="music\vag\songs\RiseAgainst"   }
	{ band="Rubber City Rebels" 	track_title="(I Wanna) Pierce My Brain" genre=0 	path="music\vag\songs\RubberCity"   }
	{ band="SoD" 					track_title="Milk" 						genre=2 	path="music\vag\songs\StormDeath"   }
	{ band="Solace" 				track_title="Indolence" 				genre=2 	path="music\vag\songs\Solace"   }
	{ band="Smoke Blow" 			track_title="Circle of Fear" 			genre=2 	path="music\vag\songs\SmokeBlow"	}
	{ band="Social Distortion" 		track_title="Mommy's Little Monster" 	genre=0 	path="music\vag\songs\SocialD"  }
	{ band="Stiff Little Fingers" 	track_title="Suspect Device" 			genre=0 	path="music\vag\songs\Stiff"  }
	{ band="Strike Anywhere" 		track_title="Refusal" 					genre=0 	path="music\vag\songs\StrikeA"  }
	{ band="Sublime" 				track_title="Seed" 						genre=0 	path="music\vag\songs\Sublime"  }
	{ band="Superjoint Ritual" 		track_title="It Takes No Guts" 			genre=2 	path="music\vag\songs\Superjoint"  }
	{ band="Supernatural" 			track_title="Internationally Known" 	genre=1 	path="music\vag\songs\Supernatural"  }
	{ band="The Adicts" 			track_title="Viva La Revolution" 		genre=0 	path="music\vag\songs\TheAdicts"	}
	{ band="The Browns" 			track_title="American Werewolf in Calgary" genre=0 	path="music\vag\songs\TheBrowns"	}
	{ band="The Clash" 				track_title="White Riot" 				genre=0 	path="music\vag\songs\TheClash"	}
	{ band="The Explosion" 			track_title="No Revolution" 			genre=2 	path="music\vag\songs\TheExplosion"	}
	{ band="The Hellacopters" 		track_title="(Gotta Get Some Action) Now!" genre=2 	path="music\vag\songs\Hellacopters" }
	{ band="The Herbaliser" 		track_title="It Ain't Nuttin'" 			genre=1 	path="music\vag\songs\TheHerb" }
	{ band="The Hookers" 			track_title="The Legend of Black Thunder" genre=2 	path="music\vag\songs\TheHookers" 	}
	{ band="The Midnight Evils" 	track_title="Loaded and Lonely" 		genre=0 	path="music\vag\songs\MidnightE"	}
	{ band="Transplants" 			track_title="California Babylon" 		genre=0 	path="music\vag\songs\Transplants"	}
	{ band="Unida" 					track_title="Black Woman" 				genre=2 	path="music\vag\songs\Unida"	}
	{ band="Wildchild" 				track_title="Secondary Protocol" 		genre=1 	path="music\vag\songs\Wildchild"	}
    
]


//These definitions of priorities for streams
StreamPriorityLow = 10
StreamPriorityLowMid = 30
StreamPriorityMid = 50
StreamPriorityMidHigh = 70
StreamPriorityHigh = 90
StreamPriorityHighest = 100

script stat_goal_appear
PlaySound menu03 pitch=50  volL=160 volR=80 //vol=120
wait .089 seconds
PlaySound menu03 pitch=62.996  volL=160 volR=80 //vol=120
wait .089 seconds
PlaySound menu03 pitch=74.915  volL=160 volR=80 //vol=120
wait .089 seconds
PlaySound menu03 pitch=100  volL=160 volR=80 //vol=120
endscript


script stat_goal_success
PlaySound GotStat04 vol=150
endscript


script found_gap_success_sound
PlaySound DE_PauseFlyIn  pitch=200
wait 1.8 seconds
found_gap_away_sound
endscript

script found_gap_away_sound
PlaySound DE_PauseFlyIn  pitch=180 vol=80
endscript



script LandPointsSound

PlaySound LandCombo01 vol=250
PlaySound DE_IconTurnZoom vol=100
PlaySound DE_MenuFlyup

/*
PlaySound DE_IconTurnZoom vol=200
wait .2 seconds
PlaySound BailSlap01 vol=50
*/

endscript

Paused_Light_Rain=0
Paused_Heavy_Rain=0

Inside_Light_Rain=0
Inside_Heavy_Rain=0

LightRainVolume = 100
MediumRainVolume = 66

script Light_Rain_SFX_On

if not IsSoundPlaying TestLight01
	if not IsSoundPlaying TestLight02
		printf "*********TURNING LIGHT RAIN SFX ON - DO NOT TURN ON AGAIN BEFORE STOPPING!********"
		PlaySound Weather_Rain_Light01 vol=LightRainVolume id=TestLight01
		change Inside_Light_Rain=0
	endif
endif
endscript

script Light_Rain_SFX_Off
printf "*********STOPPING LIGHT RAIN SFX OFF!********"
//eventually fade it out
StopSound TestLight01
change Paused_Light_Rain=0

endscript

script Heavy_Rain_SFX_On
printf "*********TURNING LIGHT and MEDIUM RAIN SFX ON - DO NOT TURN ON AGAIN BEFORE STOPPING!********"
if not IsSoundPlaying TestLight02
	if not IsSoundPlaying TestLight01
		printf "*********TURNING LIGHT RAIN SFX ON - DO NOT TURN ON AGAIN BEFORE STOPPING!********"
		PlaySound Weather_Rain_Light01 vol=LightRainVolume id=TestLight02
		
		change Inside_Heavy_Rain=0
	endif
endif
if not IsSoundPlaying TestMedium02
	printf "*********TURNING MEDIUM RAIN SFX ON - DO NOT TURN ON AGAIN BEFORE STOPPING!********"
	PlaySound Weather_Rain_Medium01 vol=MediumRainVolume id=TestMedium02  
endif
endscript

script Heavy_Rain_SFX_Off
printf "*********STOPPING HEAVY RAIN SFX OFF!********"
//eventually fade it out
StopSound TestLight02
StopSound TestMedium02
change Paused_Light_Rain=0
endscript

script wait_and_start_rain 
	switch <type>
	case 1
		begin
			wait 1
			if not IsSoundPlaying TestLight01
				Break 
			endif
		repeat
		Light_Rain_SFX_On 
		change Paused_Light_Rain=0
	case 2
		begin
			wait 1
			if not IsSoundPlaying TestLight02
				Break 
			endif
		repeat
		begin
			wait 1
			if not IsSoundPlaying TestMedium02
				Break 
			endif
		repeat
		Heavy_Rain_SFX_On
		change Paused_Heavy_Rain=0
	endswitch
 printf <type>
KillSpawnedScript type=wait_and_start_rain
endscript

script Ped_Skater_Grind_Bail_Sound
	Temp_Ped_Fall_Sound
	wait .5 seconds
	RandomNoRepeat (
		@Obj_PlaySound BailBoard01  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBoard02  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBoard03  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBoard04  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBoard05  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
	)
	RandomNoRepeat (
		@Obj_PlaySound BailBodyFall01  pitch=RandomRange(95, 105)  vol=RandomRange(60, 80)
		@Obj_PlaySound BailBodyFall02  pitch=RandomRange(95, 105)  vol=RandomRange(60, 80)
		@Obj_PlaySound BailBodyFall03  pitch=RandomRange(95, 105)  vol=RandomRange(60, 80)
		@Obj_PlaySound BailBodyFall04  pitch=RandomRange(95, 105)  vol=RandomRange(60, 80)
		@Obj_PlaySound BailBodyFall05  pitch=RandomRange(95, 105)  vol=RandomRange(60, 80)
	)
endscript

script Firefight_LaunchFireball_Sound
	//Obj_PlaySound FlamingFireBall01 vol=150  pitch=randomnorepeat(@100 @130 @150)
endscript

script Firefight_DeathFireball_Sound
	printf "******MIGHT PLAY FIREBALL DEATH STREAM HERE!********"
	//Obj_PlayStream 

endscript





script Temp_Ped_Fall_Sound
	RandomNoRepeat (
		@Obj_PlaySound BailBodyPunch01_11  pitch=RandomRange(80, 102)  vol=RandomRange(100, 120)
		@Obj_PlaySound BailBodyPunch02_11  pitch=RandomRange(80, 102)  vol=RandomRange(100, 120)
		@Obj_PlaySound BailBodyPunch03_11  pitch=RandomRange(80, 102)  vol=RandomRange(100, 120)
		@Obj_PlaySound BailBodyPunch04_11  pitch=RandomRange(80, 102)  vol=RandomRange(100, 120)
		@Obj_PlaySound BailBodyPunch05_11  pitch=RandomRange(80, 102)  vol=RandomRange(100, 120)
	)
	
	RandomNoRepeat (
		@Obj_PlaySound BailSlap01  pitch=RandomRange(95, 115)  vol=RandomRange(100, 120)
		@Obj_PlaySound BailSlap02  pitch=RandomRange(95, 115)  vol=RandomRange(100, 120)
		@Obj_PlaySound BailSlap03  pitch=RandomRange(95, 115)  vol=RandomRange(100, 120)
	)
endscript

script Goal_Success_Message_Sound
PlaySound GoalGood02 vol=250
PlayStream GoalSuccessStream priority=StreamPriorityHighest
endscript 


// Sounds the skater plays during Special tricks and for spot effect
//Jamie_JumpSoundsArray = (@jamie_special02 @jamie_special03 @jamie_special05 @jamie_special07)



// SCript for playing Might Aswell Jump Stream
// script SpecialSounds frames=10
//	printf "got launched"
//	Wait <frames> frames
//	If AnimEquals MightAsWellJump_Init
  //  	PlayStream Random<Jamie_JumpSoundsArray>
//	endif
// endscript


script Jamie_JumpSounds
	Wait 10 frames
	if ProfileEquals is_named=thomas
		If AnimEquals MightAsWellJump_Init
			PlayStream Random(@jamie_special01 @jamie_special02 @jamie_special03 @jamie_special04 ) vol=300
		endif
	endif
	Wait 20 frames
	Obj_PlaySound Random(@BailSlap02 @BailSlap03)  //changed from bitchslap2 04/30/03 by David Rowe
endscript	

script Jamie_HeroSounds
	printf "got launched"
	Wait 1 frames
	//if ProfileEquals is_named=thomas
		PlayStream Random(@thomas_special05 @thomas_special06 )
	//endif
endscript

