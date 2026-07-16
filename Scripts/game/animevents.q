// this lets you override the anim event table based on the skeleton name
script GetAnimEventTableName
	animEventTableName=PedAnimEventTable
	switch <animName>
		case animload_anl_dog
			<animEventTableName>=DogAnimEventTable
	endswitch
	return animEventTableName=<animEventTableName>
endscript 

// maybe these get merged as custom anim keys during the build process?

SkaterAnimEventTable = {   

//	example_walkslow = [
//    	{ time=0.5 	event=SoundEffect  params={ name=PEDSFX_FOOTSTEP } }
//		{ time=0.75 event=SoundEffect  params={ name=PEDSFX_FOOTSTEP } }
//		{ time=1.0 	event=SoundEffect  params={ name=PEDSFX_FOOTSTEP } }	
//	]
	
	
//
//    **** WALKS AND RUNS!! ****
//
//
	runfromidle = [
		{ time=0.02 event=FootstepScuffSoundEffect }
	]
	
	run = [
		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
	]
	
	runtoidle = [
		{ time=0.05 event=FootstepScuffSoundEffect }
		{ time=0.25 event=FootstepWalkSoundEffect }
	]
	
	run1 = [
		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
	]
	
	runjumpidle = [
		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
		{ time=0.66 event=FootstepRunSoundEffect }
		
	]
	
	runjumpland = [
		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
		{ time=0.66 event=FootstepRunSoundEffect }   
	]
	 
	bigjumplandtostand = [
		{ time=0.06 event=FootstepLandSoundEffect }
		{ time=1.4 event=FootstepScuffSoundEffect }   
	]
	
	bigjumplandtorun = [
		{ time=0.06 event=FootstepLandSoundEffect }
		{ time=0.30 event=FootstepScuffSoundEffect }
		{ time=0.7 event=FootstepRunSoundEffect }
	]
	
	
	hangontothetop = [
		{ time=1.1 event=FootstepWalkSoundEffect }
		{ time=1.7 event=FootstepWalkSoundEffect }
		{ time=2.1 event=FootstepScuffSoundEffect }
	]
	
	jumplandtorun = [
		{ time=0.12 event=FootstepLandSoundEffect }
	]
	
	jumplandtostand = [
		{ time=0.02 event=FootstepLandSoundEffect }
		{ time=0.5 event=FootstepScuffSoundEffect }
	]
	
	ladderclimb = [
		{ time=0.17 event=FootstepWalkSoundEffect }
		{ time=0.7 event=FootstepWalkSoundEffect }
	]
	
	ladderclimbfromstandidle = [
		{ time=0.02 event=FootstepScuffSoundEffect }
		{ time=0.5 event=FootstepWalkSoundEffect }
	]
	
	ladderontothetop = [
		{ time=0.3 event=FootstepWalkSoundEffect }
		{ time=0.8 event=FootstepWalkSoundEffect }
		{ time=1.4 event=FootstepScuffSoundEffect }
	]
	
	/*
	rundownstairs = [
		{ time=0.03 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
	]
	*/
	
	/*
	runleft = [
  		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
	]
	*/
	
	/*
	runright = [
  		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
	]
	*/
	
	runtojump = [
		{ time=0.02 event=FootstepJumpSoundEffect }
	]
	
	/*
	runupstairs = [
		{ time=0.03 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
	]
	*/
	
	/*
	runninghop = [
		{ time=0.03 event=FootstepRunSoundEffect }
		{ time=0.03 event=FootstepJumpSoundEffect }
		{ time=0.6 event=FootstepLandSoundEffect }
	]
	*/
	
	standtohang = [
		{ time=0.3 event=FootstepScuffSoundEffect }
	]
	
	standtojump = [
		{ time=0.03 event=FootstepJumpSoundEffect }
	]
	
	standturnleft = [
		{ time=0.02 event=FootstepScuffSoundEffect }
	]
	
	standturnright = [
		{ time=0.05 event=FootstepScuffSoundEffect }
	]
	
	newbraketurnleft = [
		{ time=0.01 event=FootstepScuffSoundEffect }
	]
	
	newbraketurnright = [
		{ time=0.01 event=FootstepScuffSoundEffect }
	]
	
	
	_180runskid = [
		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepScuffSoundEffect }
		{ time=0.85 event=FootstepWalkSoundEffect }
	]
	
	/*
	_180runskidleft = [
		{ time=0.25 event=FootstepScuffSoundEffect }
	]
	
	_180runskidright = [
		{ time=0.35 event=FootstepScuffSoundEffect }
	]
	*/
	
	skatetostand = [
		{ time=0.02 event=SoundEffect  params={ name=FlipTransitionUp01 } }
		{ time=0.42 event=FootstepRunSoundEffect }
		{ time=0.75 event=FootstepRunSoundEffect }
		{ time=1.3 event=FootstepWalkSoundEffect }
		{ time=1.5 event=FootstepScuffSoundEffect } 
	]
	
	skatetowalk = [
 		{ time=0.02 event=SoundEffect  params={ name=FlipTransitionUp01 } }
		{ time=0.42 event=FootstepRunSoundEffect }
		{ time=0.75 event=FootstepWalkSoundEffect }
    ]
	
	braketostand = [
		{ time=0.45 event=SoundEffect  params={ name=FlipTransitionUp01 } } 
	]
	
	slowskatetostand = [
		{ time=0.02 event=SoundEffect  params={ name=FlipTransitionUp01 } }
		{ time=0.30 event=FootstepRunSoundEffect }
		{ time=0.7 event=FootstepWalkSoundEffect }
		{ time=1.4 event=FootstepScuffSoundEffect }   
	]	
	
	walkslow = [
		{ time=0.02 event=FootstepWalkSoundEffect }
		{ time=0.52 event=FootstepWalkSoundEffect }		
	]

	grindnbarf_init = [
		{ time=1.0 event=GenericParticles params={ specialtrick_particles=barf_particles bone=Bone_Jaw dont_orient_toskater=1 StopEmitAt=.2}  }		
	]

	primohandstand_init = [
		{ time=0.5 event=GenericParticles params={ specialtrick_particles=fire_particles bone=Bone_Board_Root}  }		
	]

	// Gene Simmons fire breath
	flames_init = [
		{ time=0.1 event=GenericParticles params={ specialtrick_particles=firebreath_particles bone=Bone_Jaw StopEmitAt=0.4}  }		
		{ time=0.6 event=GenericParticles params={ specialtrick_particles=fire_particles bone=Bone_Board_Root }  }		
	]

	BlastGrind_Init = [					
		{ time=0.8 event=IronParticles   }			
	]
	
	bootburst_init = [
		{ time=0.5 event=GenericParticles params={ specialtrick_particles=fire_particles bone=Bone_Ankle_R dont_orient_toskater=1}  }		
	]
	
	/*
	walkregular = [
		{ time=0.02 event=FootstepWalkSoundEffect }
		{ time=0.47 event=FootstepWalkSoundEffect }
	]
	*/
	
	walkfast = [
		{ time=0.02 event=FootstepWalkSoundEffect }
		{ time=0.40 event=FootstepWalkSoundEffect }
	]
	
	fastrun = [
		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.33 event=FootstepRunSoundEffect }
	]
	
	wrun = [
		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
	]
	
	wruntoskate = [
		{ time=0.02 event=FootstepRunSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
		{ time=0.52 event=TurnOnSkaterLoopingSound }
		{ time=0.52 event=SoundEffect  params={ name=FlipTransitionDown01 } }
	]
	
	/*
	wruntostand = [
		{ time=0.02 event=FootstepWalkSoundEffect }
		{ time=0.29 event=FootstepScuffSoundEffect }
	
	]
	*/
	
	wskatetorun = [
		{ time=0.02 event=SoundEffect  params={ name=FlipTransitionUp01 } }
		{ time=0.42 event=FootstepRunSoundEffect }
		{ time=0.75 event=FootstepRunSoundEffect }
	
	]
	
	wstandtorun = [
		{ time=0.02 event=FootstepScuffSoundEffect }
	]
	
	wstandtowalk = [
		{ time=0.02 event=FootstepScuffSoundEffect }
	]
	
	wwalk = [
		{ time=0.02 event=FootstepWalkSoundEffect }
		{ time=0.52 event=FootstepWalkSoundEffect }
	]
	
	wwalktostand = [
		{ time=0.05 event=FootstepWalkSoundEffect }
		{ time=0.45 event=FootstepScuffSoundEffect }
	
	]
	
	/*
	walkdownstairs = [
		{ time=0.03 event=FootstepWalkSoundEffect }
		{ time=0.52 event=FootstepWalkSoundEffect }
	]
	
	walkupstairs = [
		{ time=0.02 event=FootstepWalkSoundEffect }
		{ time=0.52 event=FootstepWalkSoundEffect }
	]
	
	strafewalkright = [
		{ time=0.03 event=FootstepWalkSoundEffect }
		{ time=0.52 event=FootstepWalkSoundEffect }
	]
	
	strafewalkleft = [
		{ time=0.02 event=FootstepWalkSoundEffect }
		{ time=0.52 event=FootstepWalkSoundEffect }
	]
	
	strafehopleft = [
		{ time=0.07 event=FootstepWalkSoundEffect }
		{ time=0.53 event=FootstepWalkSoundEffect }   
	]
	
	strafehopright = [
		{ time=0.07 event=FootstepWalkSoundEffect }
		{ time=0.52 event=FootstepWalkSoundEffect }   
	]
	*/
	
	wallplant_ollie = [
		{ time=0.02 event=FootstepWalkSoundEffect }
	]
	
	wallplant_ollie2 = [
		{ time=0.02 event=FootstepLandSoundEffect }
	]
	
	wallplant_ollie3 = [
		{ time=0.02 event=FootstepWalkSoundEffect }
	]
	
	wallplant_ollie3_flip = [
		{ time=0.02 event=FootstepLandSoundEffect }
	]
	
	wallplant_out = [
		{ time=0.02 event=FootstepLandSoundEffect }
	]
	
	
	
	
	//Must turn on skater's looped sound
	jumpairto5050 = [
		{ time=0.22 event=SoundEffect  params={ name=FlipTransitionDown01 } }
		{ time=0.35 event=TerrainLandSound }
		{ time=0.38 event=TurnOnSkaterLoopingSound }
	]
	
	//Must turn on skater's looped sound
	jumpairtomanual = [
		{ time=0.30 event=SoundEffect  params={ name=FlipTransitionDown01 } }
		{ time=0.55 event=TurnOnSkaterLoopingSound }
	]
	







//
//    **** BAILS!! ****
//
//

	facesmash_resume = [
		{ time=0.9 event=FootstepScuffSoundEffect }
		{ time=0.94 event=FootstepScuffSoundEffect }
		{ time=1.4 event=FootstepWalkSoundEffect }
		{ time=1.5 event=FootstepWalkSoundEffect }
	]
	
	fallback = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.5 event=BailBodyFallSoundEffect }
		{ time=0.36 event=BailBodyPunchSoundEffect }
		{ time=0.4 event=BailSlapSoundEffect }
	]
	
	fallback_resume = [
		{ time=0.38 event=FootstepScuffSoundEffect }
		{ time=0.45 event=FootstepScuffSoundEffect }
		{ time=0.92 event=FootstepWalkSoundEffect }
		{ time=1.17 event=FootstepWalkSoundEffect }
	]
	
	slipbackwards = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.4 event=BailBodyFallSoundEffect }
		{ time=0.38 event=BailBodyPunchSoundEffect }
	]
	
	kneeslide = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.47 event=BailScrapeSoundEffect }
		{ time=0.43 event=BailBodyPunchSoundEffect }
	]
	
	nutterfallbackward = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.34 event=BailCrackSoundEffect }
		{ time=0.56 event=BailBodyPunchSoundEffect }
		{ time=0.6 event=BailBodyFallSoundEffect }
	]
	
	kneeslide_resume = [
		{ time=0.77 event=FootstepWalkSoundEffect }
		{ time=1.17 event=FootstepWalkSoundEffect }
	]
	
	slipforwards = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.35 event=BailBodyFallSoundEffect }
		{ time=0.58 event=BailBodyPunchSoundEffect }
		{ time=0.6 event=BailSlapSoundEffect }
	]
	
	fiftyfiftyfallbackward = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.4 event=BailBodyFallSoundEffect }
		{ time=0.38 event=BailBodyPunchSoundEffect }
		{ time=1.0 event=BailSlapSoundEffect }
	]
	
	fiftyfiftyfallforward = [
		{ time=0.01 event=BailBoardSoundEffect }
		//{ time=0.34 event=BailCrackSoundEffect }
		{ time=0.38 event=BailBodyPunchSoundEffect }
		{ time=0.36 event=BailScrapeSoundEffect }
		//{ time=0.6 event=BailBodyFallSoundEffect }
		{ time=1.15 event=FootstepLandSoundEffect }
		{ time=1.15 event=BailBodyFallSoundEffect }
	]
	
	nutterfallforward = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.3 event=BailCrackSoundEffect }
		{ time=0.56 event=BailBodyPunchSoundEffect }
		{ time=0.6 event=BailBodyFallSoundEffect }
	]
	
	backwardstest = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.3 event=FootstepRunSoundEffect }
		{ time=0.3 event=FootstepScuffSoundEffect }
		{ time=0.7 event=FootstepRunSoundEffect }
		{ time=0.7 event=FootstepScuffSoundEffect }
		{ time=1.25 event=BailBodyPunchSoundEffect }
		{ time=1.25 event=BailBodyFallSoundEffect }
		{ time=1.33 event=BailSlapSoundEffect }	
	]
	
	facefall = [
		{ time=0.01 event=BailBoardSoundEffect }
	
	]
	
	facefallsmallhit = [
		{ time=0.02 event=BailBodyPunchSoundEffect }
		{ time=0.06 event=BailSlapSoundEffect }
	
	]
	
	facefallbighit = [
		{ time=0.02 event=BailBodyPunchSoundEffect }
		{ time=0.06 event=BailSlapSoundEffect }
		{ time=0.02 event=BailBodyFallSoundEffect }
	
	]
	
	facefallresume = [
		{ time=1.0 event=FootstepWalkSoundEffect }
	]
	
	backwardfaceslam = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.38 event=BailBodyPunchSoundEffect }
		{ time=0.43 event=BailSlapSoundEffect }
        
	]
	
	getupbackwards = [
		
		{ time=0.3 event=FootstepScuffSoundEffect }
		{ time=0.37 event=FootstepScuffSoundEffect }
		{ time=0.87 event=FootstepRunSoundEffect }
		{ time=0.88 event=FootstepScuffSoundEffect }
		{ time=0.94 event=FootstepRunSoundEffect }
		{ time=1.4 event=FootstepWalkSoundEffect }
		{ time=1.8 event=FootstepWalkSoundEffect }
	]
	
	getupforwards = [
		{ time=0.15 event=FootstepScuffSoundEffect }
		{ time=0.5 event=FootstepRunSoundEffect }
		{ time=1.1 event=FootstepWalkSoundEffect }
		{ time=1.5 event=FootstepWalkSoundEffect }
	]
	
	getupfacing = [
		//{ time=0.15 event=FootstepScuffSoundEffect }
		{ time=0.7 event=FootstepScuffSoundEffect }
		{ time=1.2 event=FootstepWalkSoundEffect }
		{ time=1.5 event=FootstepWalkSoundEffect }
	]
	
	getupfacesmash = [
		{ time=0.95 event=FootstepRunSoundEffect }
		{ time=0.97 event=FootstepScuffSoundEffect }
		{ time=1.0 event=FootstepRunSoundEffect }
		{ time=1.4 event=FootstepWalkSoundEffect }
		{ time=1.6 event=FootstepWalkSoundEffect }
	]
	
	smackwall = [
		{ time=0.02 event=BailBodyPunchSoundEffect }
		{ time=0.04 event=BailSlapSoundEffect }   
	]
	
	smackwallfeet = [
		{ time=0.07 event=BailBodyPunchSoundEffect }
		{ time=0.01 event=FootstepRunSoundEffect }
		{ time=0.04 event=FootstepRunSoundEffect }
	]
	
	smackwallupright = [
		{ time=0.02 event=BailBodyPunchSoundEffect }
		{ time=0.04 event=BailSlapSoundEffect }
		{ time=0.5 event=BailBodyFallSoundEffect }
	]
	
	runout = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.30 event=BailBoardSoundEffect }
		{ time=0.18 event=FootstepRunSoundEffect }
		{ time=0.6 event=FootstepRunSoundEffect }
		{ time=0.97 event=FootstepScuffSoundEffect }
		{ time=1.5 event=FootstepWalkSoundEffect }
		{ time=2.1 event=FootstepWalkSoundEffect }
		{ time=2.48 event=FootstepWalkSoundEffect }
	]
	
	runoutquick = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.35 event=FootstepRunSoundEffect }
		{ time=0.45 event=FootstepRunSoundEffect }
		{ time=0.45 event=FootstepScuffSoundEffect }
		{ time=1.15 event=FootstepWalkSoundEffect }
		{ time=1.6 event=FootstepWalkSoundEffect }
		{ time=2.0 event=FootstepWalkSoundEffect }
	]
	
	landpartiallyonboard = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.3 event=BailBodyPunchSoundEffect }
		{ time=0.38 event=BailSlapSoundEffect }
		{ time=0.42 event=BailcrackSoundEffect }
		{ time=1.1 event=BailBodyFallSoundEffect }
		{ time=1.1 event=BailKneeStream }
		
		
	]
	
	runoutdrop = [
		
		{ time=0.05 event=FootstepRunSoundEffect }
		{ time=0.12 event=FootstepRunSoundEffect }
		{ time=0.12 event=FootstepScuffSoundEffect }
		{ time=1.5 event=FootstepWalkSoundEffect }
		{ time=1.9 event=FootstepWalkSoundEffect }   
	]
	
	headfirstsplat = [
		{ time=0.02 event=BailBodyPunchSoundEffect }
		{ time=0.09 event=BailSlapSoundEffect }
		{ time=0.5 event=BailBodyFallSoundEffect }
	]
	
	feetfirstsplat = [
		{ time=0.41 event=BailBodyPunchSoundEffect }
		{ time=0.48 event=BailSlapSoundEffect }
		{ time=0.02 event=BailBodyFallSoundEffect }
	]
	
	bigdrop = [
		{ time=0.1 event=FootstepLandSoundEffect }
		{ time=0.2 event=BailBodyPunchSoundEffect }
		{ time=0.29 event=FootstepScuffSoundEffect }
		{ time=0.8 event=BailBodyFallSoundEffect }
	]
	
	neckbreaker = [
		{ time=0.02 event=BailBodyPunchSoundEffect }
		{ time=0.07 event=BailSlapSoundEffect }
		{ time=0.09 event=BailCrackSoundEffect }
		{ time=0.7 event=BailBodyFallSoundEffect }   
	]
	
	getupdarthmaul = [
		{ time=1.0 event=FootstepLandSoundEffect }
		{ time=1.15 event=FootstepScuffSoundEffect }
		{ time=1.55 event=FootstepWalkSoundEffect }
		{ time=1.7 event=FootstepWalkSoundEffect }   
	]
	
	shoulders = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.41 event=BailBodyPunchSoundEffect }
		{ time=0.5  event=BailBodyFallSoundEffect }   
	]
	
	hips = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.38 event=BailBodyPunchSoundEffect }
		{ time=0.45  event=BailBodyFallSoundEffect }
	]
	
	rolling = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.35 event=BailBodyPunchSoundEffect }
		{ time=0.40 event=BailSlapSoundEffect }
		{ time=0.6 event=BailBodyFallSoundEffect }
		{ time=2.3 event=FootstepWalkSoundEffect }
		{ time=2.68 event=FootstepWalkSoundEffect }
	]
	
	getuphips = [
		{ time=0.45 event=FootstepScuffSoundEffect }
		{ time=1.0 event=FootstepWalkSoundEffect }
		{ time=1.5 event=FootstepWalkSoundEffect }
	]
	
	spasmodic = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.3 event=FootstepRunSoundEffect }
		{ time=0.3 event=FootstepScuffSoundEffect }
		{ time=0.57 event=FootstepRunSoundEffect }
		{ time=0.57 event=FootstepScuffSoundEffect }
		{ time=0.85 event=BailBodyPunchSoundEffect }
		{ time=0.85 event=BailBodyFallSoundEffect }
		{ time=0.94 event=BailSlapSoundEffect }  
	]
	
	getupspasmodic = [
		{ time=0.45 event=FootstepScuffSoundEffect }
		{ time=1.0 event=FootstepWalkSoundEffect }
		{ time=1.48 event=FootstepWalkSoundEffect }
	]
	
	tailslideout = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.12 event=BailBodyPunchSoundEffect }
		{ time=0.17 event=BailSlapSoundEffect }
		{ time=0.19 event=BailCrackSoundEffect }
		{ time=0.7 event=BailBodyFallSoundEffect }
	]
	
	getuptailslideout = [
		{ time=1.15 event=FootstepScuffSoundEffect }
		{ time=1.25 event=FootstepScuffSoundEffect }
		{ time=1.5 event=FootstepWalkSoundEffect }
		{ time=1.7 event=FootstepWalkSoundEffect }
	]
	
	splits = [
		{ time=0.08 event=BailBodyPunchSoundEffect }
		{ time=0.13 event=BailSlapSoundEffect }
		{ time=0.15 event=BailCrackSoundEffect }
		{ time=0.9 event=FootstepScuffSoundEffect }
		{ time=1.3 event=FootstepWalkSoundEffect }
	]
	
	anklebust1 = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.35 event=BailBodyPunchSoundEffect }
		{ time=0.42 event=BailSlapSoundEffect }
		{ time=0.48 event=BailCrackSoundEffect }
		{ time=1.05 event=BailBodyFallSoundEffect }
		{ time=1.2 event=BailAnkleStream }
	]
	
	anklebust2 = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.3 event=BailBodyPunchSoundEffect }
		{ time=0.37 event=BailSlapSoundEffect }
		{ time=0.43 event=BailCrackSoundEffect }
		{ time=0.95 event=BailBodyFallSoundEffect }
		{ time=1.1 event=BailAnkleStream }
	]
	
	faceplant = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.37 event=BailBodyPunchSoundEffect }
		{ time=0.44 event=BailSlapSoundEffect }
		{ time=2.0 event=FootstepScuffSoundEffect }
		{ time=2.6 event=FootstepWalkSoundEffect }
	]
	
	nsmissbackfoot = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.3 event=BailBodyPunchSoundEffect }
		{ time=0.37 event=BailSlapSoundEffect }
		{ time=0.42 event=BailCrackSoundEffect }
		{ time=0.7 event=BailBodyFallSoundEffect }
	]
	
	nsmissbackfoot_resume = [
		{ time=0.6 event=FootstepScuffSoundEffect }
		{ time=0.8 event=FootstepScuffSoundEffect }
		{ time=1.3 event=FootstepWalkSoundEffect }
		{ time=1.7 event=FootstepWalkSoundEffect }
	]
	
	anklebust3 = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.3 event=BailBodyPunchSoundEffect }
		{ time=0.37 event=BailSlapSoundEffect }
		{ time=0.43 event=BailCrackSoundEffect }
		{ time=0.7 event=BailScrapeSoundEffect }
		{ time=1.6 event=BailBodyFallSoundEffect }
		{ time=1.1 event=BailAnkleStream }
	]
	
	getupanklebust = [
		{ time=1.5 event=FootstepScuffSoundEffect }
		{ time=2.2 event=FootstepScuffSoundEffect }
		{ time=3.2 event=FootstepWalkSoundEffect }
		{ time=3.8 event=FootstepWalkSoundEffect }
	]
	
	boardsplit = [
		{ time=0.5 event=BailBodyPunchSoundEffect }
		{ time=0.10 event=BailSlapSoundEffect }
		//{ time=0.15 event=BailCrackSoundEffect }
		{ time=0.15 event=SoundEffect params = { name=BailCrack01 } }
		{ time=0.6 event=BailBodyFallSoundEffect }
		{ time=1.8 event=BailKickStream }
		{ time=2.02 event=FootstepScuffSoundEffect }
		{ time=2.15 event=FootstepScuffSoundEffect }
		{ time=2.6 event=SoundEffect params = { name=BailScrape01 } }
		{ time=2.6 event=SoundEffect params = { name=BailBodyPunch04_11 } }
		{ time=3.2 event=FootstepWalkSoundEffect }
		{ time=3.8 event=FootstepWalkSoundEffect }
		{ time=4.3 event=FootstepWalkSoundEffect }
		{ time=4.7 event=FootstepWalkSoundEffect }  
	]
	
	flailbail = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.48 event=BailBodyPunchSoundEffect }
		{ time=0.54 event=BailSlapSoundEffect }
		{ time=0.8 event=BailBodyFallSoundEffect }
	]
	
	flailgetup = [
		{ time=1.5 event=FootstepScuffSoundEffect }
		{ time=2.0 event=FootstepScuffSoundEffect }
		{ time=2.35 event=FootstepWalkSoundEffect }
		{ time=2.7 event=FootstepWalkSoundEffect }
	]
	
	headsmack = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.25 event=FootstepScuffSoundEffect }
		{ time=0.35 event=FootstepScuffSoundEffect }
		{ time=0.64 event=BailBodyPunchSoundEffect }
		{ time=0.7 event=BailSlapSoundEffect }
		{ time=0.55 event=BailBodyFallSoundEffect }
	]
	
	headgetup = [
		{ time=0.7 event=FootstepScuffSoundEffect }
		{ time=1.5 event=FootstepScuffSoundEffect }
		{ time=2.1 event=FootstepWalkSoundEffect }
		{ time=2.7 event=FootstepWalkSoundEffect }  
	]
	
	manualback = [
		{ time=0.02 event=BailBoardSoundEffect }
		{ time=0.52 event=BailBodyPunchSoundEffect }
		{ time=0.61 event=BailSlapSoundEffect }
		{ time=1.58 event=SoundEffect params = { name=BailBodyPunch02_11 } } 
	]
	
	manualgetup = [
		{ time=1.1 event=FootstepWalkSoundEffect }
		{ time=1.6 event=FootstepWalkSoundEffect }
		{ time=2.18 event=FootstepScuffSoundEffect }
		{ time=2.28 event=FootstepScuffSoundEffect }
		{ time=2.22 event=FootstepRunSoundEffect }
		{ time=2.32 event=FootstepRunSoundEffect }
	]
	
	manualforwards = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.38 event=BailBodyPunchSoundEffect }
		{ time=0.45 event=BailSlapSoundEffect }
		//{ time=0.35 event=BailBodyFallSoundEffect }
	]
	
	manual_fgetup = [
		{ time=0.7 event=FootstepWalkSoundEffect }
		{ time=1.5 event=FootstepRunSoundEffect }
		{ time=1.5 event=FootstepScuffSoundEffect }
		{ time=1.95 event=FootstepRunSoundEffect }
		{ time=2.32 event=FootstepWalkSoundEffect }
	]
	
	newanklebust = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.3 event=BailBodyPunchSoundEffect }
		{ time=0.37 event=BailSlapSoundEffect }
		{ time=0.43 event=BailCrackSoundEffect }
		{ time=1.3 event=BailBodyFallSoundEffect }
		{ time=1.2 event=BailAnkleStream }
	]
	
	nutsac = [
		{ time=0.2 event=BailBodyPunchSoundEffect }
		{ time=0.27 event=BailSlapSoundEffect }
		{ time=0.33 event=BailCrackSoundEffect }
		{ time=1.0 event=BailBodyFallSoundEffect }
	]
	
	nutsacgetup = [
		{ time=0.5 event=FootstepWalkSoundEffect }
		{ time=1.3 event=FootstepRunSoundEffect }
		{ time=1.6 event=FootstepScuffSoundEffect }
		{ time=1.8 event=FootstepWalkSoundEffect }
		{ time=3.1 event=FootstepWalkSoundEffect }
		{ time=3.5 event=FootstepWalkSoundEffect }
	]
	
	nutsacgetupquick = [
		{ time=1.1 event=FootstepWalkSoundEffect }
		{ time=1.5 event=FootstepScuffSoundEffect }
		{ time=2.4 event=FootstepRunSoundEffect }
		{ time=2.5 event=FootstepRunSoundEffect }
	]
	
	onefootbail = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.2 event=BailBodyPunchSoundEffect }
		{ time=0.27 event=BailSlapSoundEffect }
		{ time=0.33 event=BailCrackSoundEffect }
		{ time=1.0 event=BailBodyFallSoundEffect }
		{ time=1.95 event=BailBodyFallSoundEffect }
		{ time=1.1 event=BailKneeStream }
	]
	
	onefootgetup = [
		{ time=0.6 event=FootstepScuffSoundEffect }
		{ time=1.0 event=FootstepWalkSoundEffect }
		{ time=1.8 event=FootstepWalkSoundEffect }
		{ time=2.18 event=FootstepWalkSoundEffect }
		{ time=2.18 event=FootstepScuffSoundEffect }   
	]
	
	railbail = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.40 event=BailBodyPunchSoundEffect }
		{ time=0.48 event=BailSlapSoundEffect }
		{ time=0.6 event=BailBodyFallSoundEffect }
	]
	
	railbailgetup = [
		{ time=0.33 event=FootstepScuffSoundEffect }
		{ time=1.0 event=FootstepWalkSoundEffect }
		{ time=2.05 event=FootstepWalkSoundEffect }
		{ time=2.5 event=FootstepWalkSoundEffect }
	]
	
	railbailhitground = [
		{ time=0.02 event=BailBodyPunchSoundEffect }
		{ time=0.1 event=BailSlapSoundEffect }
	]
	
	rollingbail = [
		{ time=0.01 event=BailBoardSoundEffect }
		{ time=0.45 event=BailBodyPunchSoundEffect }
		{ time=0.53 event=BailSlapSoundEffect }
		{ time=0.96 event=BailScrapeSoundEffect }
		{ time=0.6 event=BailBodyFallSoundEffect }
		//{ time=2.0 event=BailHitGroundSoundEffect }
		
		
	]
	
	rollinggetup = [
		{ time=0.8 event=FootstepScuffSoundEffect }
		{ time=1.7 event=FootstepScuffSoundEffect }
		{ time=2.2 event=FootstepRunSoundEffect }
		{ time=2.33 event=FootstepRunSoundEffect }
	]
	
	walkingslap = [
		{ time=0.28 event=BailSlapSoundEffect }
		{ time=0.57 event=FootstepRunSoundEffect }
		{ time=0.9 event=FootstepWalkSoundEffect }	
	]
	
	walkingbail = [
		{ time=0.01 event=BailSlapSoundEffect }
		{ time=0.45 event=BailBoardSoundEffect }
		{ time=0.6 event=BailBodyFallSoundEffect }
	]
	
	walkingbailgetup = [
		{ time=0.7 event=FootstepScuffSoundEffect }
		{ time=1.2 event=FootstepScuffSoundEffect }
		{ time=1.6 event=FootstepWalkSoundEffect }
		{ time=1.9 event=FootstepWalkSoundEffect }
	]
	   
	
}

PedAnimEventTable = {
	
	// if there are too many of these events to fire off,
	// then we can split them up into separate anim event
	// tables for each ped type...

	Ped_Tombstone_Chisel1 = [
		{ time=0.02 event=Print  params={ string="Chisel1" } }
		{ time=0.30 event=TombstoneChiselSound }
		{ time=0.60 event=TombstoneChiselSound }
		{ time=0.90 event=TombstoneChiselSound }
			
 	]
	Ped_Tombstone_Inspect = [
 		{ time=0.02 event=Print  params={ string="Inspect" } }
		{ time=0.02 event=PedObjPlayStream  params={ name="TombstoneManInspect" } }
    ]
	Ped_Tombstone_WipeBrow = [
		{ time=0.02 event=Print  params={ string="Wipebrow" } }
		{ time=0.02 event=PedObjPlayStream  params={ name="TombstoneManWipeBrow" } }
	]
	Ped_Tombstone_Chisel2 = [
 		{ time=0.02 event=Print  params={ string="Chisel2" } }
		{ time=0.5 event=TombstoneChiselSound }
    ]
	Ped_Tombstone_Chisel3 = [
 		{ time=0.02 event=Print  params={ string="Chisel3" } }
		{ time=0.65 event=TombstoneChiselSound }
		{ time=0.86 event=TombstoneChiselSound }
		{ time=1.1 event=TombstoneChiselSound }
		{ time=1.35 event=TombstoneChiselSound }
    ]
	Ped_Tombstone_StandToKneel = [
 		{ time=0.02 event=Print  params={ string="StandToKneel" } }
		{ time=0.02 event=PedObjPlayStream  params={ name="TombstoneManStandToKneel" } }
    ]
	Ped_Tombstone_KneelChisel = [
 		{ time=0.02 event=Print  params={ string="KneelChisel" } }
		{ time=0.5 event=TombstoneChiselSound }
		{ time=1.0 event=TombstoneChiselSound }
		{ time=1.49 event=TombstoneChiselSound }
    ]
	Ped_Tombstone_KneelBadBack = [
 		{ time=0.02 event=Print  params={ string="KneelBadBack" } }
		{ time=0.02 event=PedObjPlayStream  params={ name="TombstoneManKneelBadBack" } }
    ]
	Ped_Tombstone_StandFromKneel = [
 		{ time=0.02 event=Print  params={ string="StandFromKneel" } }
		{ time=0.02 event=PedObjPlayStream  params={ name="TombstoneManStandFromKneel" } }
    ]
	Ped_Tombstone_StandToChisel = [
 		{ time=0.02 event=Print  params={ string="StandToChisel" } }
		{ time=0.02 event=PedObjPlayStream  params={ name="TombstoneManStandToChisel" } }
    ]
	Ped_Tombstone_StandFromChisel = [
 		{ time=0.02 event=Print  params={ string="StandFromChisel" } }
		{ time=0.02 event=PedObjPlayStream  params={ name="StandFromChisel" } }
    ]
	Ped_Tombstone_StandIdle = [
 		{ time=0.02 event=Print  params={ string="StandIdle" } }
    ]
	BarkIdle = [
		{ time=0.02 event=DogBarkStream }	
	]
	
	Ped_M_jumpback = [
		//{ time=0.2 event=FootstepScuffSoundEffect }
		{ time=0.58 event=FootstepScuffSoundEffect }
		{ time=0.85 event=FootstepRunSoundEffect }
		{ time=1.0 event=FootstepRunSoundEffect }
	]
	
	Ped_f_jumpback = [
		//{ time=0.2 event=FootstepScuffSoundEffect }
		{ time=0.1 event=FootstepScuffSoundEffect }
		{ time=0.5 event=FootstepRunSoundEffect }
		{ time=0.65 event=FootstepRunSoundEffect }
	]
	
	Ped_M_jumpforward = [
		//{ time=0.2 event=FootstepScuffSoundEffect }
		{ time=0.6 event=FootstepScuffSoundEffect }
		{ time=0.6 event=FootstepRunSoundEffect }
		{ time=1.1 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_jumpforward = [
		//{ time=0.2 event=FootstepScuffSoundEffect }
		{ time=0.4 event=FootstepScuffSoundEffect }
		{ time=0.40 event=FootstepRunSoundEffect }
		{ time=0.56 event=FootstepRunSoundEffect }
		{ time=1.7 event=FootstepWalkSoundEffect }
	]
	
	Ped_M_jumpleft = [
		//{ time=0.2 event=FootstepScuffSoundEffect }
		{ time=0.45 event=FootstepScuffSoundEffect }
		{ time=0.45 event=FootstepRunSoundEffect }
        { time=0.8 event=FootstepRunSoundEffect }
		{ time=1.3 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_jumpright = [
		//{ time=0.2 event=FootstepScuffSoundEffect }
		{ time=0.45 event=FootstepScuffSoundEffect }
		{ time=0.45 event=FootstepRunSoundEffect }
        { time=0.6 event=FootstepRunSoundEffect }
		{ time=1.3 event=FootstepWalkSoundEffect }
	]
	
	Ped_M_falldownA = [
		//{ time=0.2 event=FootstepScuffSoundEffect }
		//{ time=0.3 event=BailBodyPunchSoundEffect }
		//{ time=0.38 event=BailSlapSoundEffect }
		//{ time=0.42 event=BailcrackSoundEffect }
		{ time=0.45 event=BailBodyFallSoundEffect }
		{ time=0.70 event=BailBodyFallSoundEffect }	
	]
	
	Ped_M_falldownB = [
		//{ time=0.2 event=FootstepScuffSoundEffect }
		//{ time=0.3 event=BailBodyPunchSoundEffect }
		//{ time=0.38 event=BailSlapSoundEffect }
		//{ time=0.42 event=BailcrackSoundEffect }
		{ time=0.42 event=BailBodyFallSoundEffect }
		{ time=0.65 event=BailBodyFallSoundEffect }	
	]
	
	Ped_M_falldownC = [
		//{ time=0.2 event=FootstepScuffSoundEffect }
		//{ time=0.3 event=BailBodyPunchSoundEffect }
		//{ time=0.38 event=BailSlapSoundEffect }
		//{ time=0.42 event=BailcrackSoundEffect }
		{ time=0.3 event=BailBodyFallSoundEffect }
			
	]
	
	Ped_M_falldownD = [
		{ time=0.2 event=FootstepScuffSoundEffect }
		//{ time=0.3 event=BailBodyPunchSoundEffect }
		//{ time=0.38 event=BailSlapSoundEffect }
		//{ time=0.42 event=BailcrackSoundEffect }
		{ time=0.40 event=BailBodyFallSoundEffect }
			
	]
	
	Ped_M_falldownE = [
		{ time=0.2 event=FootstepScuffSoundEffect }
		//{ time=0.3 event=BailBodyPunchSoundEffect }
		//{ time=0.38 event=BailSlapSoundEffect }
		//{ time=0.42 event=BailcrackSoundEffect }
		{ time=0.35 event=BailBodyFallSoundEffect }
		{ time=0.55 event=BailBodyFallSoundEffect }		
	]
	
	Ped_M_Run = [
		{ time=0.12 event=FootstepRunSoundEffect }
		{ time=0.46 event=FootstepRunSoundEffect }
	]
	
	Ped_f_Run = [
		{ time=0.18 event=FootstepRunSoundEffect }
		{ time=0.6 event=FootstepRunSoundEffect }
	]
	
	Ped_M_runtoidle = [
		{ time=0.12 event=FootstepRunSoundEffect }
		{ time=0.46 event=FootstepRunSoundEffect }
		{ time=0.75 event=FootstepScuffSoundEffect }	
	]
	
	Ped_f_runtoidle1 = [
		{ time=0.12 event=FootstepRunSoundEffect }
		{ time=0.46 event=FootstepRunSoundEffect }
		{ time=0.12 event=FootstepScuffSoundEffect }	
	]
	
	Ped_f_runtoidle2 = [
		{ time=0.20 event=FootstepRunSoundEffect }
		{ time=0.46 event=FootstepRunSoundEffect }
		//{ time=0.12 event=FootstepScuffSoundEffect }	
	]
	
	Ped_M_Run1 = [
		{ time=0.12 event=FootstepRunSoundEffect }
		{ time=0.46 event=FootstepRunSoundEffect }
	]
	
	Ped_M_Run2 = [
		{ time=0.05 event=FootstepRunSoundEffect }
		{ time=0.38 event=FootstepRunSoundEffect }
	]
	
	Ped_M_Walk1 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.53 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_Walk = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.62 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_Walk2 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.62 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_Walk2toidle1 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_Walk3 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.7 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_Walk3toidle1 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_Walk4 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.43 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_Walk4toidle1 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
	]
	
	Ped_f_Walkingwave = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.62 event=FootstepWalkSoundEffect }
	]
	
	Ped_M_Walk3 = [
		{ time=0.08 event=FootstepWalkSoundEffect }
		{ time=0.55 event=FootstepWalkSoundEffect }
	]
	
	Ped_M_Walk4 = [
		{ time=0.05 event=FootstepWalkSoundEffect }
		{ time=0.40 event=FootstepWalkSoundEffect }
	]
	
	Ped_M_Walkcool = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.8 event=FootstepWalkSoundEffect }
	]
	
	Ped_M_Walktired = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.8 event=FootstepWalkSoundEffect }
	]
	
	Ped_M_Walk1toIdle = [
		{ time=0.40 event=FootstepScuffSoundEffect }
	]
	
	Ped_f_WalktoIdle1 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.60 event=FootstepScuffSoundEffect }
	]
	
	Ped_f_WalktoIdle2 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		//{ time=0.60 event=FootstepScuffSoundEffect }
	]
	
	Ped_M_Walk2 = [
		{ time=0.01 event=FootstepWalkSoundEffect }
		{ time=0.53 event=FootstepWalkSoundEffect }
	]
	
	Ped_M_Walk2toIdle = [
		{ time=0.40 event=FootstepScuffSoundEffect }
	]
	
	Ped_M_Run1toIdle = [
		{ time=0.3 event=FootstepScuffSoundEffect }
	]

	
	
	
	
}


DogAnimEventTable = {
	Run = [
		{ time=0.02 event=Print  params={ string="Dog Run" } }
    ]
	
	BarkIdle = [
		{ time=0.02 event=DogBarkStream }
    ]
	
	LiftLeg = [
		{ time=0.02 event=Print  params={ string="Dog Lift Leg" } }
    ]

}

script set_actual_skater_anim_handlers
	SetEventHandler ex=SoundEffect scr=HandleSoundEffectEvent group=anim
	SetEventHandler ex=FootstepWalkSoundEffect scr=HandleFootstepWalkSoundEffectEvent group=anim
	SetEventHandler ex=FootstepRunSoundEffect scr=HandleFootstepRunSoundEffectEvent group=anim
	SetEventHandler ex=FootstepScuffSoundEffect scr=HandleFootstepScuffSoundEffect group=anim
	SetEventHandler ex=FootstepJumpSoundEffect scr=HandleFootstepJumpSoundEffect group=anim
	SetEventHandler ex=FootstepLandSoundEffect scr=HandleFootstepLandSoundEffect group=anim
	SetEventHandler ex=BailBodyFallSoundEffect scr=HandleBailBodyFallSoundEffect group=anim
	SetEventHandler ex=BailBodyPunchSoundEffect scr=HandleBailBodyPunchSoundEffect group=anim
	SetEventHandler ex=BailCrackSoundEffect scr=HandleBailCrackSoundEffect group=anim
	SetEventHandler ex=BailSlapSoundEffect scr=HandleBailSlapSoundEffect group=anim
	SetEventHandler ex=BailScrapeSoundEffect scr=HandleBailScrapeSoundEffect group=anim
	SetEventHandler ex=BailBoardSoundEffect scr=HandleBailBoardSoundEffect group=anim
	SetEventHandler ex=BailHitGroundSoundEffect scr=HandleHitGroundSoundEffect group=anim
	SetEventHandler ex=TerrainLandSound scr=HandleTerrainLandSound group=anim
	SetEventHandler ex=TerrainBonkSound scr=HandleTerrainBonkSound group=anim
	SetEventHandler ex=TurnOnSkaterLoopingSound scr=HandleTurnOnSkaterLoopingSound group=anim
	SetEventHandler ex=BailKneeStream scr=HandleBailKneeStream group=anim
	SetEventHandler ex=BailAnkleStream scr=HandleBailAnkleStream group=anim
	SetEventHandler ex=BailKickStream scr=HandleBailKickStream group=anim	
	SetEventHandler ex=GenericParticles scr=Emit_SpecialTrickParticles group=anim
	SetEventHandler ex=IronParticles scr=IronParticles_emitfromHand group=anim
endscript

script set_actual_ped_anim_handlers
	SetEventHandler ex=Print scr=HandlePrintEvent group=anim
	SetEventHandler ex=TombstoneChiselSound scr=HandleTombstoneChiselSound group=anim
	SetEventHandler ex=TombstoneInspectStream scr=HandleTombstoneInspectStream group=anim
	SetEventHandler ex=PedObjPlayStream scr=HandlePedObjPlayStream group=anim
	SetEventHandler ex=DogBarkStream scr=HandleDogBarkStream group=anim
	
	SetEventHandler ex=FootstepWalkSoundEffect scr=HandlePedFootstepWalkSoundEffectEvent group=anim
	SetEventHandler ex=FootstepRunSoundEffect scr=HandlePedFootstepRunSoundEffectEvent group=anim
	SetEventHandler ex=FootstepScuffSoundEffect scr=HandlePedFootstepScuffSoundEffect group=anim
	SetEventHandler ex=FootstepJumpSoundEffect scr=HandlePedFootstepJumpSoundEffect group=anim
	SetEventHandler ex=FootstepLandSoundEffect scr=HandlePedFootstepLandSoundEffect group=anim
	SetEventHandler ex=BailBodyFallSoundEffect scr=HandlePedBailBodyFallSoundEffect group=anim
	SetEventHandler ex=BailBodyPunchSoundEffect scr=HandlePedBailBodyPunchSoundEffect group=anim
	SetEventHandler ex=BailCrackSoundEffect scr=HandlePedBailCrackSoundEffect group=anim
	SetEventHandler ex=BailSlapSoundEffect scr=HandlePedBailSlapSoundEffect group=anim
	SetEventHandler ex=BailScrapeSoundEffect scr=HandlePedBailScrapeSoundEffect group=anim
	SetEventHandler ex=BailBoardSoundEffect scr=HandlePedBailBoardSoundEffect group=anim
endscript

script IronParticles_emitfromHand specialtrick_particles=iron_particles
	If Flipped
		Emit_SpecialTrickParticles specialtrick_particles=<specialtrick_particles> bone=Bone_Wrist_L StopEmitAt= 0.12
	else
		Emit_SpecialTrickParticles specialtrick_particles=<specialtrick_particles> bone=Bone_Wrist_R StopEmitAt= 0.12
	endif
	Obj_PlaySound FlamingFireball01 vol=450
endscript

script set_skater_anim_handlers
	// clear old handlers
	ClearExceptionGroup anim
	
	// create new ones
	set_actual_skater_anim_handlers
endscript

script set_ped_anim_handlers
	// clear old handlers
	ClearExceptionGroup anim
		
	// create new ones
	set_actual_ped_anim_handlers
endscript

script set_viewerobj_anim_handlers
	// clear old handlers
	ClearExceptionGroup anim

	set_actual_skater_anim_handlers
	set_actual_ped_anim_handlers
endscript

// handlers

script HandlePrintEvent
	printf "Handling %s event" s=<string>
endscript

script HandlePedObjPlayStream
	printf <name>
	//Obj_PlayStream securityguard_far01  vol=200
	
endscript


script HandleTombstoneChiselSound
	//printf "***********************************YO*************"
	Obj_PlaySound NJ_TombstoneAnvilHit01  vol=randomrange(40, 75)  pitch=randomrange(95,102) 
endscript

script HandleTombstoneInspectStream
	//Obj_PlayStream tombstone_inspect
endscript

script HandleDogBarkStream
if Obj_Visible
	RandomNoRepeat (
		//@Obj_PlayStream NJ_DogBark01 vol=200 dropoff=500
		//@Obj_PlayStream NJ_DogBark02 vol=200 dropoff=500
		@Obj_PlayStream NJ_DogBark03 vol=130 dropoff=100
		@Obj_PlayStream NJ_DogBark04 vol=130 dropoff=100
		//@Obj_PlayStream NJ_DogBark05 vol=200 dropoff=500
		//@Obj_PlayStream NJ_DogBark06 vol=200 dropoff=500
	)
	wait 1 seconds
	RandomNoRepeat (
		@Obj_PlayStream NJ_DogBark01 vol=130 dropoff=100
		@Obj_PlayStream NJ_DogBark02 vol=130 dropoff=100
		//@Obj_PlayStream NJ_DogBark03 vol=200 dropoff=500
		//@Obj_PlayStream NJ_DogBark04 vol=200 dropoff=500
		@Obj_PlayStream NJ_DogBark05 vol=130 dropoff=100
		@Obj_PlayStream NJ_DogBark06 vol=130 dropoff=100
	)
endif
	 
endscript

script HandleBailKneeStream

if ProfileEquals is_custom
	if ProfileEquals is_male	
		// male knee bails
		RandomNoRepeat (
		@ PlayStream customm_knee01  vol=200
		@ PlayStream customm_knee02  vol=200
		@ PlayStream customm_knee03  vol=200
		@ PlayStream customm_knee04  vol=200
		@ PlayStream customm_knee05  vol=200
		@ PlayStream customm_knee06  vol=200
		)
	else
		// female knee bails
		RandomNoRepeat (
		@ PlayStream customf_knee01  vol=200
		@ PlayStream customf_knee02  vol=200
		@ PlayStream customf_knee03  vol=200
		@ PlayStream customf_knee04  vol=200
		@ PlayStream customf_knee05  vol=200
		@ PlayStream customf_knee06  vol=200
		)
	endif
endif

endscript
 
script HandleBailAnkleStream

if ProfileEquals is_custom
	if ProfileEquals is_male
		// male ankle bails
		RandomNoRepeat (
		@ PlayStream customm_ankle01  vol=200
		@ PlayStream customm_ankle02  vol=200
		@ PlayStream customm_ankle03  vol=200
		@ PlayStream customm_ankle04  vol=200
		@ PlayStream customm_ankle05  vol=200
		)
	else
		// female ankle bails
		RandomNoRepeat (
		@ PlayStream customf_ankle01  vol=200
		// @ PlayStream customf_ankle02  vol=200
		@ PlayStream customf_ankle03  vol=200
		@ PlayStream customf_ankle04  vol=200
		@ PlayStream customf_ankle05  vol=200
		)
	endif
endif

endscript

script HandleBailKickStream

if ProfileEquals is_custom
	if ProfileEquals is_male
		// male kick board bails
		RandomNoRepeat (
		@ PlayStream customm_kick01  vol=200
		@ PlayStream customm_kick02  vol=200
		@ PlayStream customm_kick03  vol=200
		@ PlayStream customm_kick04  vol=200
		)
	else
		// male kick board bails
		RandomNoRepeat (
		@ PlayStream customf_kick01  vol=200
		@ PlayStream customf_kick02  vol=200
		@ PlayStream customf_kick03  vol=200
		@ PlayStream customf_kick04  vol=200
		)
	endif
endif

endscript


script HandleTurnOnSkaterLoopingSound
	SkaterLoopingSound_TurnOn
endscript

script HandleTerrainLandSound
	PlayLandSound
endscript

script HandleTerrainBonkSound
	PlayBonkSound
endscript

	   
script HandleSoundEffectEvent
//	printf "Playing sound effect here"
	Obj_PlaySound <name>
endscript

script HandleHitGroundSoundEffect
	//Obj_PlaySound BailSlap02 pitch=200 vol=30
endscript


script HandleFootstepWalkSoundEffectEvent
	RandomNoRepeat (
		@Obj_PlaySound WalkStepConc01_11  pitch=RandomRange(97,102) vol=RandomRange(105, 120)
		//@Obj_PlaySound WalkStepConc02_11  pitch=RandomRange(97,102) vol=RandomRange(105, 120)
		@Obj_PlaySound WalkStepConc03_11  pitch=RandomRange(97,102) vol=RandomRange(105, 120)
		//@Obj_PlaySound WalkStepConc04_11  pitch=RandomRange(97,102) vol=RandomRange(105, 120)
		@Obj_PlaySound WalkStepConc05_11  pitch=RandomRange(97,102) vol=RandomRange(105, 120)
		)
endscript

script HandlePedFootstepWalkSoundEffectEvent
	RandomNoRepeat (
		@Obj_PlaySound WalkStepConc01_11  pitch=RandomRange(97,102) vol=RandomRange(30, 40)
		//@Obj_PlaySound WalkStepConc02_11  pitch=RandomRange(97,102) vol=RandomRange(105, 120)
		@Obj_PlaySound WalkStepConc03_11  pitch=RandomRange(97,102) vol=RandomRange(30, 40)
		//@Obj_PlaySound WalkStepConc04_11  pitch=RandomRange(97,102) vol=RandomRange(105, 120)
		@Obj_PlaySound WalkStepConc05_11  pitch=RandomRange(97,102) vol=RandomRange(30, 40)
		)
endscript

script HandleFootstepRunSoundEffectEvent
	RandomNoRepeat (
		@Obj_PlaySound RunStepConc01   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
		@Obj_PlaySound RunStepConc02   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
		@Obj_PlaySound RunStepConc03   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
		@Obj_PlaySound RunStepConc04   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
		@Obj_PlaySound RunStepConc05   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
	)
endscript

script HandlePedFootstepRunSoundEffectEvent
	RandomNoRepeat (
		@Obj_PlaySound RunStepConc01   pitch=RandomRange(97,102)  vol=RandomRange(30, 40)
		@Obj_PlaySound RunStepConc02   pitch=RandomRange(97,102)  vol=RandomRange(30, 40)
		@Obj_PlaySound RunStepConc03   pitch=RandomRange(97,102)  vol=RandomRange(30, 40)
		@Obj_PlaySound RunStepConc04   pitch=RandomRange(97,102)  vol=RandomRange(30, 40)
		@Obj_PlaySound RunStepConc05   pitch=RandomRange(97,102)  vol=RandomRange(30, 40)
	)
endscript

script HandleFootstepScuffSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound ScuffStepConc01  pitch=RandomRange(85,102)  vol=RandomRange(105, 120)
		@Obj_PlaySound ScuffStepConc02  pitch=RandomRange(85,102)  vol=RandomRange(105, 120)
	)
endscript

script HandlePedFootstepScuffSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound ScuffStepConc01  pitch=RandomRange(85,102)  vol=RandomRange(30, 40)
		@Obj_PlaySound ScuffStepConc02  pitch=RandomRange(85,102)  vol=RandomRange(30, 40)
	)
endscript

script HandleFootstepJumpSoundEffect
	Obj_PlaySound JumpStepConc01   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
	/*
	RandomNoRepeat (
		@Obj_PlaySound JumpStepConc01   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
		//@Obj_PlaySound JumpStepConc02   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
	)
	*/
endscript

script HandlePedFootstepJumpSoundEffect
	Obj_PlaySound JumpStepConc01   pitch=RandomRange(97,102)  vol=RandomRange(30, 40)
	/*
	RandomNoRepeat (
		@Obj_PlaySound JumpStepConc01   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
		//@Obj_PlaySound JumpStepConc02   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
	)
	*/
endscript

script HandleFootstepLandSoundEffect
	Obj_PlaySound LandStepConc02   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
	/*
	RandomNoRepeat (
		//@Obj_PlaySound LandStepConc01   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
		@Obj_PlaySound LandStepConc02   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
	)
	*/
endscript

script HandlePedFootstepLandSoundEffect
	Obj_PlaySound LandStepConc02   pitch=RandomRange(97,102)  vol=RandomRange(30, 40)
	/*
	RandomNoRepeat (
		//@Obj_PlaySound LandStepConc01   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
		@Obj_PlaySound LandStepConc02   pitch=RandomRange(97,102)  vol=RandomRange(105, 120)
	)
	*/
endscript

script HandleBailBodyFallSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound BailBodyFall01  pitch=RandomRange(95, 105)  vol=RandomRange(90, 100)
		@Obj_PlaySound BailBodyFall02  pitch=RandomRange(95, 105)  vol=RandomRange(90, 100)
		@Obj_PlaySound BailBodyFall03  pitch=RandomRange(95, 105)  vol=RandomRange(90, 100)
		@Obj_PlaySound BailBodyFall04  pitch=RandomRange(95, 105)  vol=RandomRange(90, 100)
		@Obj_PlaySound BailBodyFall05  pitch=RandomRange(95, 105)  vol=RandomRange(90, 100)
	)
endscript

script HandlePedBailBodyFallSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound BailBodyFall01  pitch=RandomRange(95, 105)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBodyFall02  pitch=RandomRange(95, 105)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBodyFall03  pitch=RandomRange(95, 105)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBodyFall04  pitch=RandomRange(95, 105)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBodyFall05  pitch=RandomRange(95, 105)  vol=RandomRange(40, 50)
	)
endscript

script HandleBailBodyPunchSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound BailBodyPunch01_11  pitch=RandomRange(80, 102)  vol=RandomRange(140, 150)
		@Obj_PlaySound BailBodyPunch02_11  pitch=RandomRange(80, 102)  vol=RandomRange(140, 150)
		@Obj_PlaySound BailBodyPunch03_11  pitch=RandomRange(80, 102)  vol=RandomRange(140, 150)
		@Obj_PlaySound BailBodyPunch04_11  pitch=RandomRange(80, 102)  vol=RandomRange(140, 150)
		@Obj_PlaySound BailBodyPunch05_11  pitch=RandomRange(80, 102)  vol=RandomRange(140, 150)
	)
endscript

script HandlePedBailBodyPunchSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound BailBodyPunch01_11  pitch=RandomRange(80, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBodyPunch02_11  pitch=RandomRange(80, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBodyPunch03_11  pitch=RandomRange(80, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBodyPunch04_11  pitch=RandomRange(80, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBodyPunch05_11  pitch=RandomRange(80, 102)  vol=RandomRange(40, 50)
	)
endscript

script HandleBailCrackSoundEffect
	Obj_PlaySound BailCrack01  pitch=RandomRange(100, 110)  vol=RandomRange(120, 130)
	//RandomNoRepeat (
	//	@Obj_PlaySound BailCrack01  pitch=RandomRange(100, 110)  vol=RandomRange(120, 130)
	//	@Obj_PlaySound BailCrack02  pitch=RandomRange(100, 110)  vol=RandomRange(120, 130)
	//	@Obj_PlaySound BailCrack03  pitch=RandomRange(100, 110)  vol=RandomRange(120, 130)
	//)
endscript

script HandlePedBailCrackSoundEffect
	Obj_PlaySound BailCrack01  pitch=RandomRange(100, 110)  vol=RandomRange(40, 50)
	//RandomNoRepeat (
	//	@Obj_PlaySound BailCrack01  pitch=RandomRange(100, 110)  vol=RandomRange(120, 130)
	//	@Obj_PlaySound BailCrack02  pitch=RandomRange(100, 110)  vol=RandomRange(120, 130)
	//	@Obj_PlaySound BailCrack03  pitch=RandomRange(100, 110)  vol=RandomRange(120, 130)
	//)
endscript

script HandleBailSlapSoundEffect
	printf "******playing bail slap sfx"
	RandomNoRepeat (
		@Obj_PlaySound BailSlap01  pitch=RandomRange(95, 115)  vol=RandomRange(140, 150)
		@Obj_PlaySound BailSlap02  pitch=RandomRange(95, 115)  vol=RandomRange(140, 150)
		@Obj_PlaySound BailSlap03  pitch=RandomRange(95, 115)  vol=RandomRange(140, 150)
	)
endscript

script HandlePedBailSlapSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound BailSlap01  pitch=RandomRange(95, 115)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailSlap02  pitch=RandomRange(95, 115)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailSlap03  pitch=RandomRange(95, 115)  vol=RandomRange(40, 50)
	)
endscript

script HandleBailScrapeSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound BailScrape01  pitch=RandomRange(95, 115)  vol=RandomRange(120, 130)
		@Obj_PlaySound BailScrape02  pitch=RandomRange(95, 115)  vol=RandomRange(120, 130)
		@Obj_PlaySound BailScrape03  pitch=RandomRange(95, 115)  vol=RandomRange(120, 130)
	)
endscript

script HandlePedBailScrapeSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound BailScrape01  pitch=RandomRange(95, 115)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailScrape02  pitch=RandomRange(95, 115)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailScrape03  pitch=RandomRange(95, 115)  vol=RandomRange(40, 50)
	)
endscript

script HandleBailBoardSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound BailBoard01  pitch=RandomRange(100, 102)  vol=RandomRange(115, 125)
		@Obj_PlaySound BailBoard02  pitch=RandomRange(100, 102)  vol=RandomRange(115, 125)
		@Obj_PlaySound BailBoard03  pitch=RandomRange(100, 102)  vol=RandomRange(115, 125)
		@Obj_PlaySound BailBoard04  pitch=RandomRange(100, 102)  vol=RandomRange(115, 125)
		@Obj_PlaySound BailBoard05  pitch=RandomRange(100, 102)  vol=RandomRange(115, 125)
	)
endscript

script HandlePedBailBoardSoundEffect
	RandomNoRepeat (
		@Obj_PlaySound BailBoard01  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBoard02  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBoard03  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBoard04  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
		@Obj_PlaySound BailBoard05  pitch=RandomRange(100, 102)  vol=RandomRange(40, 50)
	)
endscript







