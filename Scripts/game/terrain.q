// different terrain types in skate3
// Note:: These should match with the tool terrain enum,
// in \gfx\nxflags.h!!!  (Just tell Steve if you need to
// add or remove a sound from here.)


script SetTerrainParticleProperties
    printf "SetTerrainParticleProperties STUBBED OUT"
endscript

// These definitions should no longer be used.  I set the values artificially high
// to catch any code that may still be using them.
TERRAIN_DEFAULT 		= 10000
TERRAIN_CONCSMOOTH		= 10001
TERRAIN_CONCROUGH		= 10002
TERRAIN_METALSMOOTH		= 10003
TERRAIN_MEATALSMOOTH    = 10003   ; patch for a typo which propogated around, and is difficult to fix everywhere
TERRAIN_METALROUGH		= 10004
TERRAIN_METALCORRUGATED	= 10005
TERRAIN_METALGRATING	= 10006
TERRAIN_METALTIN		= 10007
TERRAIN_WOOD			= 10008
TERRAIN_WOODMASONITE	= 10009
TERRAIN_WOODPLYWOOD		= 10010
TERRAIN_WOODFLIMSY		= 10011
TERRAIN_WOODSHINGLE		= 10012
TERRAIN_WOODPIER		= 10013
TERRAIN_BRICK			= 10014
TERRAIN_TILE			= 10015
TERRAIN_ASPHALT			= 10016
TERRAIN_ROCK			= 10017
TERRAIN_GRAVEL			= 10018
TERRAIN_SIDEWALK		= 10019
TERRAIN_GRASS			= 10020
TERRAIN_GRASSDRIED		= 10021
TERRAIN_DIRT			= 10022
TERRAIN_DIRTPACKED		= 10023
TERRAIN_WATER			= 10024
TERRAIN_ICE				= 10025
TERRAIN_SNOW			= 10026
TERRAIN_SAND			= 10027
TERRAIN_PLEXIGLASS		= 10028
TERRAIN_FIBERGLASS		= 10029
TERRAIN_CARPET			= 10030
TERRAIN_CONVEYOR		= 10031
TERRAIN_CHAINLINK		= 10032
TERRAIN_METALFUTURE     = 10033
TERRAIN_GENERIC1		= 10034
TERRAIN_GENERIC2		= 10035
TERRAIN_WHEELS  		= 10036 ; K: Used only by the skateboard wheels, as a means of identifying them so their color can be changed.
TERRAIN_WETCONC         = 10037
TERRAIN_METALFENCE      = 10038 ; Only loading bonk sound.
TERRAIN_GRINDTRAIN      = 10039
TERRAIN_GRINDROPE		= 10040	  ; Only loading grindrope sound.
TERRAIN_GRINDWIRE		= 10041
TERRAIN_GRINDCONC			= 10042
TERRAIN_GRINDROUNDMETALPOLE	= 10043
TERRAIN_GRINDCHAINLINK		= 10044
TERRAIN_GRINDMETAL			= 10045
TERRAIN_GRINDWOODRAILING	= 10046
TERRAIN_GRINDWOODLOG		= 10047
TERRAIN_GRINDWOOD			= 10048
TERRAIN_GRINDPLASTIC			= 10049
TERRAIN_GRINDELECTRICWIRE	= 10050
TERRAIN_GRINDCABLE			= 10051
TERRAIN_GRINDCHAIN			= 10052
TERRAIN_GRINDPLASTICBARRIER	= 10053
TERRAIN_GRINDNEONLIGHT		= 10054
TERRAIN_GRINDGLASSMONSTER	= 10055
TERRAIN_GRINDBANYONTREE		= 10056
TERRAIN_GRINDBRASSRAIL		= 10057
TERRAIN_GRINDCATWALK		= 10058
TERRAIN_GRINDTANKTURRET		= 10059

	  
;TERRAIN_CONCCRUSTY		= 10041
;TERRAIN_FLOAT			= 10042
;TERRAIN_GARBAGE			= 10043
;TERRAIN_GLASS			= 10044
;TERRAIN_BRICKLARGE		= 10045
;TERRAIN_LEAVES			= 10046
;TERRAIN_MUD				= 10047
;TERRAIN_SKYLIGHTS		= 10048
;TERRAIN_TINROOF			= 10049

/*script SetTerrainDefaults
// Setup the terrain sounds.  These can be overridded on a per level basis
SetTerrainDefault
SetTerrainConcSmooth
SetTerrainConcRough
SetTerrainMetalSmooth
SetTerrainMetalRough
SetTerrainMetalCorrugated
SetTerrainMetalGrating
SetTerrainMetalTin
SetTerrainWood
SetTerrainWoodMasonite
SetTerrainWoodPlywood
SetTerrainWoodFlimsy
SetTerrainWoodShingle
SetTerrainWoodPier
SetTerrainBrick
SetTerrainTile
SetTerrainAsphalt
SetTerrainRock
SetTerrainGravel
SetTerrainSidewalk
SetTerrainGrass
SetTerrainGrassDried
SetTerrainDirt
SetTerrainDirtPacked
SetTerrainWater
SetTerrainIce
SetTerrainSnow
SetTerrainSand
SetTerrainPlexiglass
SetTerrainFiberglass
SetTerrainCarpet
SetTerrainConveyor
SetTerrainChainlink
SetTerrainMetalFuture
SetTerrainGeneric1
SetTerrainGeneric2
SetTerrainWetConcrete
SetTerrainMetalFence
SetTerrainGrindTrain
SetTerrainGrindRope
SetTerrainGrindWire
SetTerrainConcCrusty
SetTerrainFloat
SetTerrainGarbage
SetTerrainGlass
SetTerrainBrickLarge
SetTerrainLeaves
SetTerrainMud
SetTerrainSkylights
SetTerrainTinRoof
endscript
   */



RollConcSmoothValues = { maxPitch = 120 minPitch = 30 }
RollConcRoughValues = { maxPitch = 120 minPitch = 10 }
OllieConcValues = { maxPitch = 105 minPitch = 98 maxVol = 175 minVol = 120 }
SlideConcValues = { maxPitch = 135 minPitch = 100 maxVol = 130 minVol = 80 }
LandConcValues = { maxVol = 135 minVol = 70 }
BonkConcValues = { maxVol = 140 minVol = 70 }

RollMetalSmoothValues = { maxPitch = 120 minPitch = 30 }
RollMetalRoughValues = { maxPitch = 120 minPitch = 30 maxVol = 100 minVol = 20 }
RollMetalCorrugatedValues = { maxPitch = 250 minPitch = 150 }
OllieMetalValues = { maxVol = 140 minVol = 70 }
LandMetalValues = { maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 40 }
BonkMetalValues = { maxVol = 100 minVol = 30 }

RollWoodValues = { maxPitch = 120 minPitch = 30 maxVol = 100 minVol = 20 }
RollWoodShingleValues = { maxPitch = 80 minPitch = 20 maxVol = 100 minVol = 20 }
OllieWoodValues = { maxVol = 120 minVol = 60 }
LandWoodValues = { maxVol = 120 minVol = 60 }
BonkWoodValues = { maxVol = 90 minVol = 30 }

script SetTerrainDefault
	LoadTerrainSounds terrain = TERRAIN_DEFAULT
endscript


script SetTerrainConcSmooth
	LoadTerrainSounds terrain = TERRAIN_CONCSMOOTH
endscript

script SetTerrainConcRough
	LoadTerrainSounds terrain = TERRAIN_CONCROUGH
endscript

script SetTerrainMetalSmooth
	LoadTerrainSounds terrain = TERRAIN_METALSMOOTH
endscript

script SetTerrainMetalRough
	LoadTerrainSounds terrain = TERRAIN_METALROUGH
endscript

script SetTerrainMetalCorrugated
	LoadTerrainSounds terrain = TERRAIN_METALCORRUGATED
endscript

script SetTerrainMetalGrating
	LoadTerrainSounds terrain = TERRAIN_METALGRATING
endscript

script SetTerrainMetalTin
	LoadTerrainSounds terrain = TERRAIN_METALTIN
endscript

script SetTerrainWood
	LoadTerrainSounds terrain = TERRAIN_WOOD
endscript

script SetTerrainWoodMasonite
	LoadTerrainSounds terrain = TERRAIN_WOODMASONITE
endscript

script SetTerrainWoodPlywood
	LoadTerrainSounds terrain = TERRAIN_WOODPLYWOOD
endscript

script SetTerrainWoodFlimsy
	LoadTerrainSounds terrain = TERRAIN_WOODFLIMSY
endscript

script SetTerrainWoodShingle
	LoadTerrainSounds terrain = TERRAIN_WOODSHINGLE
endscript

script SetTerrainWoodPier
	LoadTerrainSounds terrain = TERRAIN_WOODPIER
endscript

script SetTerrainBrick
	LoadTerrainSounds terrain = TERRAIN_BRICK
endscript

script SetTerrainTile
	LoadTerrainSounds terrain = TERRAIN_TILE
endscript

script SetTerrainAsphalt
	LoadTerrainSounds terrain = TERRAIN_ASPHALT
endscript

script SetTerrainRock
	LoadTerrainSounds terrain = TERRAIN_ROCK
endscript

script SetTerrainGravel
	LoadTerrainSounds terrain = TERRAIN_GRAVEL
endscript

script SetTerrainSidewalk
	LoadTerrainSounds terrain = TERRAIN_SIDEWALK
endscript

script SetTerrainGrass
	LoadTerrainSounds terrain = TERRAIN_GRASS
	SetTerrainParticleProperties {
	   Terrain = TERRAIN_GRASS num = 200 start_col = 0xff17272D end_col = 0x3789BA2A    emit_w = 2.0 emit_h = 2.1
       size = 6 aspect_ratio = 1 growth = 1.0 angle = -50.0 speed = 60.0 speed_range = 60.0 life = 0.9 grav = -0.5
       name = "Grass_1.png" }
endscript

script SetTerrainGrassDried
	LoadTerrainSounds terrain = TERRAIN_GRASSDRIED
	SetTerrainParticleProperties {
       Terrain = TERRAIN_GRASSDRIED num = 200 start_col = 0xff17272D end_col = 0x3789BA2A   emit_w = 2.0 emit_h = 2.1
       size = 6 aspect_ratio = 1 growth = 1.0 angle = -50.0 speed = 60.0 speed_range = 60.0 life = 0.9 grav = -0.5
       name = "Grass_1.png" }
endscript

script SetTerrainDirt
	LoadTerrainSounds terrain = TERRAIN_DIRT
	SetTerrainParticleProperties {
	   Terrain = TERRAIN_DIRT num = 20 start_col = 0x5a679EB2 end_col = 0x0067AAB2    emit_w = 1.0 emit_h = 1.0
       size = 25 aspect_ratio = 1.0 growth = 2.0 angle = 90.0 speed = 30.0 speed_range = 50.0 life = 0.6 grav = 0.5
       name = "breath.png" }
endscript

script SetTerrainDirtPacked
	LoadTerrainSounds terrain = TERRAIN_DIRTPACKED
	SetTerrainParticleProperties {
       Terrain = TERRAIN_DIRTPACKED num = 20 start_col = 0x5a679EB2 end_col = 0x0067AAB2    emit_w = 1.0 emit_h = 1.0
       size = 25 aspect_ratio = 1.0 growth = 2.0 angle = 90.0 speed = 30.0 speed_range = 50.0 life = 0.6 grav = 0.5
       name = "breath.png" }
endscript

script SetTerrainWater
	LoadTerrainSounds terrain = TERRAIN_WATER
;	SetTerrainParticleProperties {
;    	Terrain = TERRAIN_WATER num = 40 start_col = 0x5affb4b4 end_col = 0x00c8aaaa    emit_w = 1.0 emit_h = 1.0
;       size = 25 aspect_ratio = 1.0 growth = 2.0 angle = 90.0 speed = 30.0 speed_range = 50.0 life = 0.6 grav = 0.5
;       name = "breath.png" }
	SetTerrainParticleProperties {
       Terrain = TERRAIN_WATER num = 200 start_col = 0xc3E5CEA9 end_col = 0x09E5CEA9	emit_w = 2.0 emit_h = 5.0
       size = 3  aspect_ratio = 0.45 growth = 2.0 angle = 45.0 speed = 90.0 speed_range = 60.0 life = 0.6 grav = 0.0
       name = "breath.png" }
endscript

script SetTerrainIce
	LoadTerrainSounds terrain = TERRAIN_ICE
endscript

script SetTerrainSnow
	LoadTerrainSounds terrain = TERRAIN_SNOW
	SetTerrainParticleProperties {
	   Terrain = TERRAIN_SNOW num = 20 start_col = 0x5aF9E9E0 end_col = 0x0cF9E9E0    emit_w = 1.0 emit_h = 1.0
       size = 21 aspect_ratio = 0.7 growth = 2.0 angle = 60.0 speed = 30.0 speed_range = 50.0 life = 0.7 grav = 2
       name = "breath.png" }
endscript

script SetTerrainSand
	LoadTerrainSounds terrain = TERRAIN_SAND
	SetTerrainParticleProperties {
	   Terrain = TERRAIN_SAND num = 20 start_col = 0x5a679EB2 end_col = 0x0067AAB2    emit_w = 1.0 emit_h = 1.0
       size = 25 aspect_ratio = 1.0 growth = 2.0 angle = 90.0 speed = 30.0 speed_range = 50.0 life = 0.6 grav = 0.5
       name = "breath.png" }
endscript

script SetTerrainPlexiglass
	LoadTerrainSounds terrain = TERRAIN_PLEXIGLASS
endscript

script SetTerrainFiberglass
	LoadTerrainSounds terrain = TERRAIN_FIBERGLASS
endscript

script SetTerrainCarpet
	LoadTerrainSounds terrain = TERRAIN_CARPET
endscript

script SetTerrainConveyor
	LoadTerrainSounds terrain = TERRAIN_CONVEYOR
endscript

script SetTerrainChainlink
	LoadTerrainSounds terrain = TERRAIN_CHAINLINK
endscript

script SetTerrainMetalFuture
	LoadTerrainSounds terrain = TERRAIN_METALFUTURE
endscript

script SetTerrainGeneric1
	LoadTerrainSounds terrain = TERRAIN_GENERIC1
endscript

script SetTerrainGeneric2
	LoadTerrainSounds terrain = TERRAIN_GENERIC2
endscript

script SetTerrainWetConc
	LoadTerrainSounds terrain = TERRAIN_WETCONC
	SetTerrainParticleProperties {
       Terrain = TERRAIN_WATER num = 200 start_col = 0xc3E5CEA9 end_col = 0x09E5CEA9	emit_w = 2.0 emit_h = 5.0
       size = 3  aspect_ratio = 0.45 growth = 2.0 angle = 45.0 speed = 90.0 speed_range = 60.0 life = 0.6 grav = 0.0
       name = "breath.png" }
endscript

script SetTerrainMetalFence
	LoadTerrainSounds terrain = TERRAIN_METALFENCE
endscript

script SetTerrainConcCrusty
endscript

script SetTerrainFloat
endscript

script SetTerrainGarbage
endscript

script SetTerrainGlass
endscript

script SetTerrainBrickLarge
endscript

script SetTerrainLeaves
endscript

script SetTerrainMud
endscript

script SetTerrainSkylights
endscript

script SetTerrainTinRoof
endscript


//
//
//		**** GRIND TERRAINS ****
//
//

//Used only for grind sounds

script SetTerrainGrindTrain
	LoadTerrainSounds terrain = TERRAIN_GRINDTRAIN
endscript

script SetTerrainGrindRope
	LoadTerrainSounds terrain = TERRAIN_GRINDROPE
endscript

script SetTerrainGrindWire
	LoadTerrainSounds terrain = TERRAIN_GRINDWIRE
endscript

script SetTerrainGrindConc
	LoadTerrainSounds terrain = TERRAIN_GRINDCONC
endscript

script SetTerrainGrindRoundMetalPole
	LoadTerrainSounds terrain = TERRAIN_GRINDROUNDMETALPOLE
endscript

script SetTerrainGrindChainLink
	LoadTerrainSounds terrain = TERRAIN_GRINDCHAINLINK
endscript

script SetTerrainGrindMetal
	LoadTerrainSounds terrain = TERRAIN_GRINDMETAL
endscript

script SetTerrainGrindWoodRailing
	LoadTerrainSounds terrain = TERRAIN_GRINDWOODRAILING
endscript

script SetTerrainGrindWoodLog
	LoadTerrainSounds terrain = TERRAIN_GRINDWOODLOG
endscript

script SetTerrainGrindWood
	LoadTerrainSounds terrain = TERRAIN_GRINDWOOD
endscript

script SetTerrainGrindPlastic
	LoadTerrainSounds terrain = TERRAIN_GRINDPLASTIC
endscript

script SetTerrainGrindElectricWire
	LoadTerrainSounds terrain = TERRAIN_GRINDELECTRICWIRE
endscript

script SetTerrainGrindCable
	LoadTerrainSounds terrain = TERRAIN_GRINDCABLE
endscript

script SetTerrainGrindChain
	LoadTerrainSounds terrain = TERRAIN_GRINDCHAIN
endscript

script SetTerrainGrindPlasticBarrier
	LoadTerrainSounds terrain = TERRAIN_GRINDPLASTICBARRIER
endscript

script SetTerrainGrindNeonLight
	LoadTerrainSounds terrain = TERRAIN_GRINDNEONLIGHT
endscript

script SetTerrainGrindGlassMonster
	LoadTerrainSounds terrain = TERRAIN_GRINDGLASSMONSTER
endscript

script SetTerrainGrindBanyonTree
	LoadTerrainSounds terrain = TERRAIN_GRINDBANYONTREE
endscript

script SetTerrainGrindBrassRail
	LoadTerrainSounds terrain = TERRAIN_GRINDBRASSRAIL
endscript

script SetTerrainGrindCatwalk
	LoadTerrainSounds terrain = TERRAIN_GRINDCATWALK
endscript

script SetTerrainGrindTankTurret
	LoadTerrainSounds terrain = TERRAIN_GRINDTANKTURRET
endscript






//
//
// Terrain Structures
//
//

standard_terrain = [

//Default Terrain
//If a specific action is not listed in a terrain, then it will play the
//default sound for that action, which is in the structure below
  {	//Terrain:  Default
    Terrain = TERRAIN_DEFAULT
	SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollConcSmooth02"	maxPitch = 120 minPitch = 80 loadVol = 100 }
      TA_GRIND		= { sound = "Terrains\GrindMetal02"		maxPitch = 115  minPitch = 100   maxVol = 120    minVol = 20 }
      TA_OLLIE		= [
			{ soundAction = [
				{ chance = 1		sound = "Terrains\OllieConc19"		OllieConcValues }
				{ chance = 8		sound = "Terrains\OllieConc"		OllieConcValues }
				]
			}
	  ]
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 100 }
	  TA_GRINDJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_GRINDLAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalOn02"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
      TA_SLIDE		= { sound = "Terrains\SlideMetal02"		maxPitch = 140  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_SLIDELAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalOn02"	maxVol = 150    minVol = 100 maxpitch=120  minpitch=100 }
		}
	  ]
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }

  
  
  
  ;;;;;;;;;;;;;;; examples of complex sound settings!!!!!!!!!!!!!!!!!!!!!!
  
  
  
  ;;;;; note that these complex sound settings only work for triggered skater sounds:
  ;;;;; TA_OLLIE, TA_LAND, TA_BONK, TA_GRINDJUMP, TA_GRINDLAND, TA_SLIDEJUMP, TA_SLIDELAND, TA_REVERT
	  
  ;{
    ;Terrain = TERRAIN_DEFAULT
	;SoundActions = {
	
	  ;;;;;;;;;;;;;;; standard method	  
      ;TA_OLLIE		= { 		sound = "Terrains\OllieMetal"			OllieMetalValues }
	  
	  ;;;;;;;;;;;;;;; example of randomized sounds
	  ;TA_OLLIE		= [
	    ;{
			;soundAction = [
				;{ chance = 1		sound = "Terrains\GrindMetalOff"		maxVol = 100    minVol = 20 }
				;{ chance = 2		sound = "Terrains\OllieMetal"			OllieMetalValues }
				;{ chance = 1		sound = "Terrains\OllieConc"			OllieConcValues }
			;]
		;}
	  ;]
			
	  ;;;;;;;;;;;;;;; example of sounds chosen by skater velocity
 	  ;TA_OLLIE		= [
		;{
			;useUpTo = 30
			;soundAction = {	sound = "Terrains\OllieMetal"			OllieMetalValues }
		;}
		;{
			;useUpTo = 45
			;soundAction = {	sound = "Terrains\GrindMetalOff"		maxVol = 100    minVol = 20 }
		;}
		;{
			;soundAction = {	sound = "Terrains\OllieConc"			OllieConcValues }
		;}
	  ;]
	  
	  ;;;;;;;;;;;;;;; example combining randomized and velocity-chosen sounds
	  ;TA_OLLIE		= [
	    ;{
			;useUpTo = 20
			;soundAction = {	sound = "Terrains\GrindMetalOff"		maxVol = 100    minVol = 20 }
		;}
		;{
			;useUpTo = 50
			;soundAction = [
				;{ chance = 1	sound = "Terrains\LandConc"				maxVol = 100    minVol = 20 }
				;{ chance = 8	sound = "Terrains\LandMetal"			OllieMetalValues }
			;]
		;}
		;{
			;soundAction = [
				;{ chance = 1	sound = "Skater\RevertConc"				maxVol = 100    minVol = 20 }
				;{ chance = 2	sound = "Skater\RevertMetal"			OllieMetalValues }
				;{ chance = 1	sound = "Skater\RevertWood"				OllieConcValues }
			;]
		;}
	  ;]
	;}
  ;}
  
  ;;;;;;;;;;;;;;; end of examples


//
//
//   ***** CONCRETE/POURED/HARD SURFACES *****
//
//
  { //Terrain:  Concrete Smooth
    Terrain = TERRAIN_CONCSMOOTH
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollConcSmooth02"	maxPitch = 120 minPitch = 80 loadVol = 100 }
      TA_GRIND		= { sound = "Terrains\GrindConc04"		maxPitch = 90  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 70 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_GRINDLAND	= { sound = "Terrains\LandConc"			maxVol = 150    minVol = 100 loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideConc14"		SlideConcValues }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_SLIDELAND	= { sound = "Terrains\LandConc"			maxVol = 120    minVol = 80 loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
 
  { //Terrain:  Concrete Rough
    Terrain = TERRAIN_CONCROUGH
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollConcRough"	maxPitch = 120 minPitch = 50 loadVol = 70 } 
      TA_GRIND		= { sound = "Terrains\GrindConc04"		maxPitch = 90  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 70 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
	  TA_GRINDLAND	= { sound = "Terrains\LandConc"			maxVol = 150    minVol = 100 loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideConc14"		SlideConcValues }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_SLIDELAND	= { sound = "Terrains\LandConc"			maxVol = 120    minVol = 80 loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
  
  {	//Terrain:  Brick
    Terrain = TERRAIN_BRICK
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollBrick"		loadVol=80  maxPitch = 120  minPitch = 80   maxVol = 100    minVol = 20 } 
      TA_GRIND		= { sound = "Terrains\GrindConc04"		maxPitch = 90  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 70 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_GRINDLAND	= { sound = "Terrains\LandConc"			maxVol = 150    minVol = 100 loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideConc14"		SlideConcValues }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_SLIDELAND	= { sound = "Terrains\LandConc"			maxVol = 120    minVol = 80 loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
  
  { // Terrain:  Asphalt
    Terrain = TERRAIN_ASPHALT
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollAsphalt"		maxPitch = 120  minPitch = 80 }
      TA_GRIND		= { sound = "Terrains\GrindConc04"		maxPitch = 90  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 70 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_GRINDLAND	= { sound = "Terrains\LandConc"			maxVol = 150    minVol = 100 loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideConc14"		SlideConcValues }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_SLIDELAND	= { sound = "Terrains\LandConc"			maxVol = 120    minVol = 80 loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
  
  { // Terrain:  Sidewalk
    Terrain = TERRAIN_SIDEWALK
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollSidewalk"		loadVol=100  maxPitch = 90  minPitch = 50   maxVol = 100    minVol = 20 }
      TA_GRIND		= { sound = "Terrains\GrindConc04"		maxPitch = 90  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 70 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_GRINDLAND	= { sound = "Terrains\LandConc"			maxVol = 150    minVol = 100 loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideConc14"		SlideConcValues }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_SLIDELAND	= { sound = "Terrains\LandConc"			maxVol = 120    minVol = 80 loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
  
  {	//Terrain:  Wet Concrete
    Terrain = TERRAIN_WETCONC
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollWetConc_11"	loadVol=70 maxPitch = 120  minPitch = 50 }
	  TA_GRIND		= { sound = "Terrains\GrindConc04"		maxPitch = 90  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandWater"		LandConcValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 70 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_GRINDLAND	= { sound = "Terrains\LandConc"			maxVol = 150    minVol = 100 loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideConc14"		SlideConcValues }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_SLIDELAND	= { sound = "Terrains\LandConc"			maxVol = 120    minVol = 80 loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
      
    }
  }
  
 
  

//  
//
//   ***** METAL SURFACES *****
//
//
  {	//Terrain:  Metal Smooth	
    Terrain = TERRAIN_METALSMOOTH
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollMetalSmooth_11"	maxPitch = 120  minPitch = 50   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\OllieMetal"			loadVol=120 OllieMetalValues }
      TA_LAND		= { sound = "Terrains\LandMetal"			LandMetalValues }
      TA_BONK		= { sound = "Terrains\BonkMetal_11"			BonkMetalValues }
      TA_REVERT		= { sound = "Skater\RevertMetal" 			loadVol=200 }
    }
  }

  {	//Terrain:  Metal Rough
    Terrain = TERRAIN_METALROUGH
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollMetalRough_11"	maxPitch = 120  minPitch = 50   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\OllieMetal"			loadVol=120 OllieMetalValues }
      TA_LAND		= { sound = "Terrains\LandMetal"			LandMetalValues }
      TA_BONK		= { sound = "Terrains\BonkMetal_11"			BonkMetalValues }
      TA_REVERT		= { sound = "Skater\RevertMetal" 			loadVol=200 }
    }
  }
    
  {	//Terrain:  Metal Corrugated
    Terrain = TERRAIN_METALCORRUGATED
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollMetalCorrugated_11"	maxPitch = 120  minPitch = 50   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\OllieMetal"			loadVol=120 OllieMetalValues }
      TA_LAND		= { sound = "Terrains\LandMetal"			LandMetalValues }
      TA_BONK		= { sound = "Terrains\BonkMetal_11"			BonkMetalValues }
      TA_REVERT		= { sound = "Skater\RevertMetal" 			loadVol=200 }
    }
  }
                                                   
  {	//Terrain:  Metal Grating
    Terrain = TERRAIN_METALGRATING
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollMetalGrating"		maxPitch = 120  minPitch = 50   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\OllieMetal"			loadVol=120 OllieMetalValues }
      TA_LAND		= { sound = "Terrains\LandMetal"			LandMetalValues }
      TA_BONK		= { sound = "Terrains\BonkMetal_11"			BonkMetalValues }
      TA_REVERT		= { sound = "Skater\RevertMetal" 			loadVol=200 }
    }
  }
  
  {	//Terrain:  Metal Tin
    Terrain = TERRAIN_METALTIN
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollMetalTin"			maxPitch = 120  minPitch = 50   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\OllieMetal"			loadVol=120 OllieMetalValues }
      TA_LAND		= { sound = "Terrains\LandMetal"			LandMetalValues }
      TA_BONK		= { sound = "Terrains\BonkMetal_11"			BonkMetalValues }
      TA_REVERT		= { sound = "Skater\RevertMetal" 			loadVol=200 }
    }
  }

  


//  
//
//   ***** WOOD SURFACES *****
//
//
  {	//Terrain:  Wood
    Terrain = TERRAIN_WOOD
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollWood"			loadVol=50 maxPitch = 120  minPitch = 50   maxVol = 100    minVol = 20 }
      TA_GRIND		= { sound = "Terrains\GrindWood"		maxPitch = 100  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_LAND		= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\BonkWood"			BonkWoodValues loadVol = 100 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_GRINDLAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideWood"		pitch=110 loadVol=100 maxPitch = 100  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_SLIDELAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertWood"			loadVol = 150 }
    }
  }
  
  {	//Terrain:  Wood Masonite
    Terrain = TERRAIN_WOODMASONITE
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollWoodMasonite"			loadVol=50 maxPitch = 120  minPitch = 50   maxVol = 100    minVol = 20 } 
      TA_OLLIE		= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_LAND		= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\BonkWood"			BonkWoodValues loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertWood"			loadVol = 150 }
    }
  }
  
  {	//Terrain:  Wood Plywood
    Terrain = TERRAIN_WOODPLYWOOD
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollWoodPlywood_11"		loadVol=80 maxPitch = 120 minPitch = 80 maxVol = 100    minVol = 20 } 
      TA_OLLIE		= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_LAND		= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\BonkWood"			BonkWoodValues loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertWood"			loadVol = 150 }
    }
  }
  
  {	//Terrain:  Wood Flimsy
    Terrain = TERRAIN_WOODFLIMSY
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollWoodFlimsy"	loadVol=80 maxPitch = 120  minPitch = 80   maxVol = 100    minVol = 20 } 
      TA_OLLIE		= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_LAND		= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\BonkWood"			BonkWoodValues loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertWood"			loadVol = 150 }
    }
  }
    
  {	//Terrain:  Wood Shingle
    Terrain = TERRAIN_WOODSHINGLE
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollWoodShingle"	loadVol=80 maxPitch = 80  minPitch = 50   maxVol = 100    minVol = 20 } 
      TA_OLLIE		= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_LAND		= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\BonkWood"			BonkWoodValues loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertWood"			loadVol = 150 }
    }
  }
  
  {	//Terrain:  Wood Pier
    Terrain = TERRAIN_WOODPIER
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollWoodPier"		loadVol=80  maxPitch = 120  minPitch = 80   maxVol = 100    minVol = 20 } 
      TA_OLLIE		= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_LAND		= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_BONK		= { sound = "Terrains\BonkWood"			BonkWoodValues loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertWood"			loadVol = 150 }
    }
  }
  
  
  
  
//  
//
//   ***** NATURAL SURFACES *****
//
//  
  { // Terrain:  Rock
    Terrain = TERRAIN_ROCK
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollRock"			loadVol=200  maxPitch = 120  minPitch = 80 }
      TA_OLLIE		= { sound = "Terrains\OllieConc"		maxPitch = 100  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
  
  { // Terrain:  Gravel
    Terrain = TERRAIN_GRAVEL
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollGravel"		loadVol=200  maxPitch = 120  minPitch = 80 }
      TA_OLLIE		= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
  
  { //Terrain:  Grass
    Terrain = TERRAIN_GRASS
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollGrass"		maxPitch = 90	minPitch = 60	maxVol = 100	minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\LandDirt"			maxPitch = 100	minPitch = 100	maxVol = 100	minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandDirt"			maxPitch = 100	minPitch = 100	maxVol = 100	minVol = 20 }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
  
  { //Terrain:  Grass Dried
    Terrain = TERRAIN_GRASSDRIED
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollGrassDried"	maxPitch = 50  minPitch = 30   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\LandDirt"			maxPitch = 100	minPitch = 100	maxVol = 100	minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandDirt"			maxPitch = 100	minPitch = 100	maxVol = 100	minVol = 20 }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
  
  { //Terrain:  Dirt
    Terrain = TERRAIN_DIRT
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollDirt"			maxPitch = 100	minPitch = 60	maxVol = 100	minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\LandDirt"			maxPitch = 100	minPitch = 100	maxVol = 100	minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandDirt"			maxPitch = 100	minPitch = 100	maxVol = 100	minVol = 20 }
      TA_REVERT		= { sound = "Skater\RevertConc"			loadVol = 180 }
    }
  }
  
  { //Terrain:  Dirt Packed
    Terrain = TERRAIN_DIRTPACKED
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollDirtPacked"		loadVol=75  maxPitch = 100  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\OllieWood" }
      TA_LAND		= { sound = "Terrains\LandDirt"				maxPitch = 100	minPitch = 100	maxVol = 100	minVol = 20 }
      TA_REVERT		= { sound = "Skater\RevertConc"				loadVol = 180 }
    }
  }
  
  { //Terrain:  Water
    Terrain = TERRAIN_WATER
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollWater_11"			loadVol=150 maxPitch = 120  minPitch = 50 }
      TA_OLLIE		= { sound = "Terrains\OllieWater" 			OllieConcValues }
      TA_LAND		= { sound = "Terrains\LandWater"			LandConcValues }
    }
  }
  
  { //Terrain:  Ice
    Terrain = TERRAIN_ICE
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollIce"			loadVol=70  maxPitch = 100  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\LandDirt" 		maxPitch = 100	minPitch = 100	maxVol = 100	minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandDirt"			maxPitch = 100	minPitch = 100	maxVol = 100	minVol = 20 }
      TA_REVERT		= { sound = "Skater\RevertWood" 		loadVol=150 }
    }
  }
  
  { //Terrain:  Snow
    Terrain = TERRAIN_SNOW
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollSnow"			loadVol=70  maxPitch = 120  minPitch = 80   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\LandDirt" 		maxPitch = 100  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandDirt"			maxPitch = 100  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_REVERT		= { sound = "Skater\RevertConc" 		loadVol=180 }
    }
  }
  
  { //Terrain:  Sand
    Terrain = TERRAIN_SAND
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollSand"			loadVol=80  maxPitch = 120  minPitch = 80   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\LandDirt" 		maxPitch = 100  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_LAND		= { sound = "Terrains\LandDirt"			maxPitch = 100  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_REVERT		= { sound = "Skater\RevertConc" 		loadVol=180 }
    }
  }




//
//
//   ***** OTHER MISC. SURFACES ***** 
//
//
  {	//Terrain:  Tile
    Terrain = TERRAIN_TILE
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollTile"		loadVol=80  maxPitch = 120  minPitch = 80   maxVol = 100    minVol = 20 } 
      TA_OLLIE		= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues loadVol = 100 }
      TA_REVERT		= { sound = "Skater\RevertWood"			loadVol = 150 }
    }
  }
  
  { //Terrain:  Plexiglass
    Terrain = TERRAIN_PLEXIGLASS
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollPlexiglass"	loadVol=50  maxPitch = 120  minPitch = 80   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\OllieConc" 		OllieConcValues }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues }
      TA_REVERT		= { sound = "Skater\RevertGlass" 		loadVol=180 }
    }
  }
  
  { //Terrain:  Fiberglass
    Terrain = TERRAIN_FIBERGLASS
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollFiberglass"	loadVol=50  maxPitch = 120  minPitch = 80   maxVol = 100    minVol = 20 }
      TA_OLLIE		= { sound = "Terrains\OllieConc" 		OllieConcValues }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues }
      TA_REVERT		= { sound = "Skater\RevertGlass" 		loadVol=180 }
    }
  }
  
  { //Terrain:  Carpet
    Terrain = TERRAIN_CARPET
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollCarpet"		loadVol=100  RollConcSmoothValues }
      TA_OLLIE		= { sound = "Terrains\OllieConc" 		OllieConcValues }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues }
      TA_REVERT		= { sound = "Skater\RevertWood" 		loadVol=150 }
    }
  }
  
  { //Terrain:  Conveyor
    Terrain = TERRAIN_CONVEYOR
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollConveyor"		loadVol=70  RollConcSmoothValues }
      TA_OLLIE		= { sound = "Terrains\OllieConc" 		OllieConcValues }
      TA_LAND		= { sound = "Terrains\LandConc"			LandConcValues }
      TA_REVERT		= { sound = "Skater\RevertConc" 		loadVol=180 }
    }
  }
  
  { //Terrain:  Chain Link
	Terrain = TERRAIN_CHAINLINK
	SoundActions = {
	  TA_BONK		= { sound = "Terrains\BonkChainlink"	loadVol=100  maxPitch = 100	 minPitch = 100	maxVol = 100	minVol = 20	}
	  TA_GRIND		= { sound = "Terrains\GrindMetalPole22"		maxPitch = 108  minPitch = 90   maxVol = 120    minVol = 20 }
      TA_GRINDJUMP	= { sound = "Terrains\GrindMetalPoleOff21"	maxVol = 90 minVol = 70 }
	  TA_GRINDLAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindChainLinkOn22"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
	  
      TA_SLIDE		= { sound = "Terrains\SlideMetalPole22"		maxPitch = 140  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\GrindMetalPoleOff21"	maxVol = 90 minVol = 70 }
      TA_SLIDELAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindChainLinkOn22"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
	}
  }
  
  { //Terrain:  Metal Future
    Terrain = TERRAIN_METALFUTURE
    SoundActions = {
      TA_ROLL		= { sound = "Terrains\RollMetalFuture"			loadVol=700  RollMetalSmoothValues }
      TA_OLLIE		= { sound = "Terrains\OllieMetalFuture" 		OllieMetalValues }
      TA_LAND		= { sound = "Terrains\LandMetalFuture"			LandMetalValues }
      TA_REVERT		= { sound = "Skater\RevertMetal" 				loadVol=200 }
    }
  }
  
  { //Terrain:  Generic1
	Terrain = TERRAIN_GENERIC1
	SoundActions = {
	  TA_BONK		= { sound = "Terrains\BonkMetalOutdoor_11"	loadVol=100  BonkMetalValues }
  	}
  }
  
  { //Terrain:  Generic2
	Terrain = TERRAIN_GENERIC2
	SoundActions = {
	  
  	}
  }
  
  { //Terrain:  MetalFence
	Terrain = TERRAIN_METALFENCE
	SoundActions = {
	  TA_BONK		= { sound = "Terrains\BonkMetalFence"	loadVol=400  BonkMetalValues }
  	}
  }
  
  
  
  
  
  //
  //
  //	**** GRIND/SLIDE ONLY TERRAINS ****
  //
  //
  
  { //Terrain:  Grind Conc
	Terrain = TERRAIN_GRINDCONC
	SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindConc04"		maxPitch = 90  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_GRINDLAND	= { sound = "Terrains\LandConc"			maxVol = 150    minVol = 100 loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideConc14"		SlideConcValues }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieConc"		OllieConcValues }
      TA_SLIDELAND	= { sound = "Terrains\LandConc"			maxVol = 120    minVol = 80 loadVol = 100 }
	}
  }
  
  { //Terrain:  Grind Round Metal Pole
	Terrain = TERRAIN_GRINDROUNDMETALPOLE
	SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindMetalPole22"		maxPitch = 105  minPitch = 85   maxVol = 120    minVol = 50 }
      TA_GRINDJUMP	= { sound = "Terrains\GrindMetalPoleOff21"	maxVol = 90 minVol = 70 }
      TA_GRINDLAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalPoleOn21"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
      TA_SLIDE		= { sound = "Terrains\SlideMetalPole22"		maxPitch = 115  minPitch = 95   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\GrindMetalPoleOff21"	maxVol = 90 minVol = 70 }
      TA_SLIDELAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalPoleOn21"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
	}
  }
  
  { //Terrain:  Grind Chain Link
	Terrain = TERRAIN_GRINDCHAINLINK
	SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindMetalPole22"		maxPitch = 105  minPitch = 85   maxVol = 120    minVol = 50 }
      TA_GRINDJUMP	= { sound = "Terrains\GrindMetalPoleOff21"	maxVol = 90 minVol = 70 }
      TA_GRINDLAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindChainLinkOn22"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
      TA_SLIDE		= { sound = "Terrains\SlideMetalPole22"		maxPitch = 115  minPitch = 95   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\GrindMetalPoleOff21"	maxVol = 90 minVol = 70 }
      TA_SLIDELAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindChainLinkOn22"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
	}
  }
  
  { //Terrain:  Grind Metal (other)
	Terrain = TERRAIN_GRINDMETAL
	SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindMetal02"		maxPitch = 115  minPitch = 100   maxVol = 120    minVol = 20 }
	  TA_GRINDJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_GRINDLAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalOn02"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
      TA_SLIDE		= { sound = "Terrains\SlideMetal02"		maxPitch = 140  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_SLIDELAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalOn02"	maxVol = 150    minVol = 100 maxpitch=120  minpitch=100 }
		}
	  ]
	}
  }
  
  { //Terrain:  Grind Wood Railing
	Terrain = TERRAIN_GRINDWOODRAILING
	SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindWoodRailing"		maxPitch = 150  minPitch = 120   maxVol = 100    minVol = 50 }
	  TA_GRINDJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues  maxpitch = 140 minpitch = 130  }
      TA_GRINDLAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 maxpitch = 150 minpitch = 149}
      TA_SLIDE		= { sound = "Terrains\SlideWood"		loadVol=100 maxPitch = 120  minPitch = 90   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues maxpitch = 140 minpitch = 130}
      TA_SLIDELAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 maxpitch = 150 minpitch = 149}
	}
  }
  
  {	//Terrain:  Grind Wood Log
    Terrain = TERRAIN_GRINDWOODLOG
    SoundActions = {
      TA_GRIND		= { sound = "Terrains\GrindWood"		maxPitch = 100  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_GRINDLAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideWoodLog"		loadVol=100 maxPitch = 120  minPitch = 70   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_SLIDELAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
    }
  }
  
  { //Terrain:  Grind Wood
	Terrain = TERRAIN_GRINDWOOD
	SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindWood"		maxPitch = 100  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_GRINDLAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideWood"		pitch=110 loadVol=100 maxPitch = 100  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_SLIDELAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
	}
  }
  
  { //Terrain:  Grind Plastic
	Terrain = TERRAIN_GRINDPLASTIC
    SoundActions = {
      TA_GRIND		= { sound = "Terrains\GrindPlastic"		maxPitch = 120  minPitch = 90   maxVol = 100    minVol = 20 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues maxpitch = 130 minpitch = 120 }
      TA_GRINDLAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 maxpitch = 140 minpitch = 139 }
      TA_SLIDE		= { sound = "Terrains\SlidePlastic"		loadVol=100 maxPitch = 120  minPitch = 70   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues maxpitch = 130 minpitch = 120 }
      TA_SLIDELAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 maxpitch = 140 minpitch = 139 }
	}
  }
  
  {	//Terrain:  Grind Chain
    Terrain = TERRAIN_GRINDCHAIN
    SoundActions = {
		
	  TA_GRIND		= { sound = "Terrains\GrindChain"		maxPitch = 115  minPitch = 100   maxVol = 120    minVol = 20 }
	  TA_GRINDJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_GRINDLAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalOn02"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
      TA_SLIDE		= { sound = "Terrains\SlideMetal02"		maxPitch = 140  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_SLIDELAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalOn02"	maxVol = 150    minVol = 100 maxpitch=120  minpitch=100 }
		}
	  ]
      
    }
  }
  
  {	//Terrain:  Grind Electric Wire (in NJ)
    Terrain = TERRAIN_GRINDELECTRICWIRE
    SoundActions = {
      TA_GRIND		= { sound = "Terrains\GrindWireSpark"	maxPitch = 110  minPitch = 75  maxVol = 180    minVol = 80 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWireSpark"	maxVol = 180  minVol = 60 }
      TA_GRINDLAND	= { sound = "Terrains\LandWireSpark"	maxVol = 200	minVol = 100 }
      TA_SLIDE		= { sound = "Terrains\GrindWireSpark"	maxPitch = 120  minPitch = 80   maxVol = 150    minVol = 80 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWireSpark"	maxVol = 180  minVol = 60 }
      TA_SLIDELAND	= { sound = "Terrains\LandWireSpark"	maxVol = 150    minVol = 100 }
    }
  }
  
  {	//Terrain:  Grind Cable
    Terrain = TERRAIN_GRINDCABLE
    SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindCable"	maxPitch = 110  minPitch = 75  maxVol = 180    minVol = 80 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieMetal"	maxVol = 180  minVol = 60 }
      TA_GRINDLAND	= { sound = "Terrains\LandWire"	maxVol = 200	minVol = 100 }
      TA_SLIDE		= { sound = "Terrains\GrindCable"	maxPitch = 120  minPitch = 80   maxVol = 150    minVol = 80 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieMetal"	maxVol = 180  minVol = 60 }
      TA_SLIDELAND	= { sound = "Terrains\LandWire"	maxVol = 150    minVol = 100 }
      
    }
  }
  
  {	//Terrain:  Grind Plastic Construction Barrier (in NY)
    Terrain = TERRAIN_GRINDPLASTICBARRIER
    SoundActions = {
	
	//    !!!!current version is copy of grind plastic!!!!
      TA_GRIND		= { sound = "Terrains\GrindPlastic"		maxPitch = 120  minPitch = 90   maxVol = 100    minVol = 20 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues maxpitch = 130 minpitch = 120 }
      TA_GRINDLAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 maxpitch = 140 minpitch = 139 }
      TA_SLIDE		= { sound = "Terrains\SlidePlastic"		loadVol=100 maxPitch = 120  minPitch = 70   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues maxpitch = 130 minpitch = 120 }
      TA_SLIDELAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 maxpitch = 140 minpitch = 139 }
    }
  }
  
  {	//Terrain:  Grind Neon Light (in FL)
    Terrain = TERRAIN_GRINDNEONLIGHT
    SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindWireSpark"	maxPitch = 110  minPitch = 75  maxVol = 180    minVol = 80 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWireSpark"	maxVol = 180  minVol = 60 }
      TA_GRINDLAND	= { sound = "Terrains\LandWireSpark"	maxVol = 200	minVol = 100 }
      TA_SLIDE		= { sound = "Terrains\GrindWireSpark"	maxPitch = 120  minPitch = 80   maxVol = 150    minVol = 80 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWireSpark"	maxVol = 180  minVol = 60 }
      TA_SLIDELAND	= { sound = "Terrains\LandWireSpark"	maxVol = 150    minVol = 100 }
      
    }
  }
  
  {	//Terrain:  Grind Glass Monster (in SD)
    Terrain = TERRAIN_GRINDGLASSMONSTER
    SoundActions = {
	TA_GRIND		= { sound = "Terrains\GrindGlassMonster"		maxPitch = 120  minPitch = 90   maxVol = 100    minVol = 20 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues maxpitch = 130 minpitch = 120 }
      TA_GRINDLAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 maxpitch = 140 minpitch = 139 }
      TA_SLIDE		= { sound = "Terrains\GrindGlassMonster"		loadVol=100 maxPitch = 120  minPitch = 70   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues maxpitch = 130 minpitch = 120 }
      TA_SLIDELAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 maxpitch = 140 minpitch = 139 }
      
    }
  }
  
  {	//Terrain:  Grind Banyon Tree (in HI)
    Terrain = TERRAIN_GRINDBANYONTREE
    SoundActions = {
	
	//    !!!!current version is copy of grind woodlog!!!!
      TA_GRIND		= { sound = "Terrains\GrindBanyonTree"		maxPitch = 100  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_GRINDLAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\GrindBanyonTree"		loadVol=100 maxPitch = 120  minPitch = 70   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_SLIDELAND	= { sound = "Terrains\LandWood"			LandWoodValues loadVol = 100 }
    }
  }
  
  {	//Terrain:  Grind Brass Rail (in VC)
    Terrain = TERRAIN_GRINDBRASSRAIL
    SoundActions = {
	
	  TA_GRIND		= { sound = "Terrains\GrindMetalPole22"		maxPitch = 105  minPitch = 85   maxVol = 120    minVol = 50 }
      TA_GRINDJUMP	= { sound = "Terrains\GrindMetalPoleOff21"	maxVol = 90 minVol = 70 }
      TA_GRINDLAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalPoleOn21"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
      TA_SLIDE		= { sound = "Terrains\SlideMetalPole22"		maxPitch = 115  minPitch = 95   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\GrindMetalPoleOff21"	maxVol = 90 minVol = 70 }
      TA_SLIDELAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalPoleOn21"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
      
    }
  }
  
  {	//Terrain:  Grind Catwalk (in SJ)
    Terrain = TERRAIN_GRINDCATWALK
    SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindMetal02"		maxPitch = 115  minPitch = 100   maxVol = 120    minVol = 20 }
	  TA_GRINDJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_GRINDLAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalOn02"	maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
	  ]
      TA_SLIDE		= { sound = "Terrains\SlideMetal02"		maxPitch = 140  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_SLIDELAND		= [
		{
			useUpTo = 30
			soundAction = {	sound = "Terrains\GrindMetalOn08"  maxVol = 150    minVol = 100  maxpitch=120  minpitch=100 }
		}
		{
			soundAction = { sound = "Terrains\GrindMetalOn02"	maxVol = 150    minVol = 100 maxpitch=120  minpitch=100 }
		}
	  ]
      
    }
  }
  
  {	//Terrain:  Grind Tank Turret (in RU)
    Terrain = TERRAIN_GRINDTANKTURRET
    SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindTankTurret"		maxPitch = 115  minPitch = 100   maxVol = 120    minVol = 20 }
	  TA_GRINDJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_GRINDLAND	= { sound = "Terrains\LandTankTurret"		LandWoodValues loadVol = 100 }
      TA_SLIDE		= { sound = "Terrains\SlideMetal02"		maxPitch = 140  minPitch = 100   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\GrindMetalOff02"	maxVol = 90 minVol = 70 }
      TA_SLIDELAND	= { sound = "Terrains\LandTankTurret"		LandWoodValues loadVol = 100 }
      
    }
  }
  
  
  
  
  


  
  
  
  
  
  
  
  
  
  
  
  { //Terrain:  Grind Train
	Terrain = TERRAIN_GRINDTRAIN
	SoundActions = {
	  TA_GRIND		= { sound = "Terrains\GrindTrain"	loadVol=100 maxPitch = 100  minPitch = 60   maxVol = 200    minVol = 80 }
  	}
  }
  
  {	//Terrain:  Grind Rope
    Terrain = TERRAIN_GRINDROPE
    SoundActions = {
      TA_GRIND		= { sound = "Terrains\GrindRope"		loadVol=50  pitch=70  maxPitch = 100  minPitch = 60   maxVol = 200    minVol = 80 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWood"		OllieWoodValues }
      TA_GRINDLAND	= { sound = "Terrains\LandWood"			loadVol=80  maxVol = 100  minVol = 60 }
      TA_SLIDE		= { sound = "Terrains\GrindRope"		loadVol=50  maxPitch = 100  minPitch = 60   maxVol = 100    minVol = 20 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWood"		loadVol=80  OllieWoodValues }
      TA_SLIDELAND	= { sound = "Terrains\LandWood"			loadVol=80  maxVol = 120    minVol = 80 }
    }
  }
  
  {	//Terrain:  Grind Wire
    Terrain = TERRAIN_GRINDWIRE
    SoundActions = {
      TA_GRIND		= { sound = "Terrains\GrindWireSpark"	maxPitch = 110  minPitch = 75  maxVol = 150    minVol = 80 }
      TA_GRINDJUMP	= { sound = "Terrains\OllieWireSpark"	maxVol = 150  minVol = 60 }
      TA_GRINDLAND	= { sound = "Terrains\LandWireSpark"	maxVol = 175	minVol = 100 }
      TA_SLIDE		= { sound = "Terrains\GrindWireSpark"	maxPitch = 120  minPitch = 80   maxVol = 130    minVol = 80 }
      TA_SLIDEJUMP	= { sound = "Terrains\OllieWireSpark"	maxVol = 150  minVol = 60 }
      TA_SLIDELAND	= { sound = "Terrains\LandWireSpark"	maxVol = 130    minVol = 100 }
    }
  }
  
  
      
//  
//
//   ***** END of STANDARD Terrain Structure *****
//
//

]

			 
