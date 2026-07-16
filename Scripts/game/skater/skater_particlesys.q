script InitSkaterParticles
    // create separate particle systems for each bone that can spurt blood:    
    Obj_GetId
    MangleChecksums a=skater_blood_system b=<objId>
    MangleChecksums a=<mangled_id> b=Bone_Head
    
    if not ParticleExists <mangled_id>
        CreateParticleSystem params={ objId=<objId> bone=Bone_Head name=<mangled_id> } name=<mangled_id> max=25 emitscript=skater_blood_emit updatescript=skater_blood_update texture=particle_test02 blendmode=blend perm=1
//        CreateParticleSystem params={ objId=<objId> bone=Bone_Head name=<mangled_id> } name=<mangled_id> max=25 emitscript=skater_blood_emit  texture=particle_test02 blendmode=blend perm=1
    endif
    
    // create a particle system for the board, so it can emit sparks        
    Obj_GetId
    MangleChecksums a=skater_sparks_system b=<objId>
    MangleChecksums a=<mangled_id> b=Bone_Board_Tail
    if not ParticleExists <mangled_id>
//        CreateParticleSystem params={ objId=<objId> bone=Bone_Board_Tail name=<mangled_id> } name=<mangled_id> max=50 emitscript=skater_sparks_emit updatescript=skater_sparks_update blendmode=add texture=particle_test01 
        CreateParticleSystem params={ objId=<objId> bone=Bone_Board_Tail name=<mangled_id> } name=<mangled_id> max=40 emitscript=skater_sparks_emit updatescript=skater_sparks_update blendmode=blend  type=GlowRibbontrail history=2  perm=1
    
	endif

	Obj_GetID   
    MangleChecksums a=skatersplash b=<objId>
	if not ParticleExists name=<mangled_id> 
        if InMultiPlayerGame
		    // subsequent players get 30
            //CreateParticleSystem params={objid=<objid>  bone=Bone_Pelvis name=<mangled_id>} name=<mangled_id> max=30 emitscript=emit_skatersplash updatescript=skatersplash_update blendmode=blend type=Glow  perm=1 segments=5
            CreateParticleSystem params={objid=<objid>  bone=Bone_Pelvis name=<mangled_id>} name=<mangled_id> max=30 emitscript=emit_skatersplash blendmode=blend type=Glow  perm=1 segments=5
		else
            // First player created gets 80 particles
            //CreateParticleSystem params={objid=<objid>  bone=Bone_Pelvis name=<mangled_id>} name=<mangled_id> max=80 emitscript=emit_skatersplash updatescript=skatersplash_update blendmode=blend type=Glow  perm=1 segments=5
            CreateParticleSystem params={objid=<objid>  bone=Bone_Pelvis name=<mangled_id>} name=<mangled_id> max=80 emitscript=emit_skatersplash blendmode=blend type=Glow  perm=1 segments=5
        endif
		Skatersplashoff
	endif

endscript

script DestroySkaterParticles

    Obj_GetId
    MangleChecksums a=skater_blood_system b=<objId>
    MangleChecksums a=<mangled_id> b=Bone_Head
    DestroyParticleSystem name=<mangled_id>
    
    Obj_GetId
    MangleChecksums a=skater_sparks_system b=<objId>
    MangleChecksums a=<mangled_id> b=Bone_Board_Tail
    DestroyParticleSystem name=<mangled_id>
	
    Obj_GetId
    MangleChecksums a=skatersplash b=<objId>
	DestroyParticleSystem name=<mangled_id>
	    
endscript

script ResetSkaterParticleSystems
    CleanUp_SpecialTrickParticles
	
	BloodParticlesOff	
	SkaterSplashOff	
    SparksOff
	
	Obj_GetId
    MangleChecksums a=skater_blood_system b=<objId>
    MangleChecksums a=<mangled_id> b=Bone_Head
    SetScript name=<mangled_id> emitscript=skater_blood_emit //updatescript=skater_blood_update
    
    Obj_GetId
    MangleChecksums a=skater_sparks_system b=<objId>
    MangleChecksums a=<mangled_id> b=Bone_Board_Tail
    SetScript name=<mangled_id> emitscript=skater_sparks_emit updatescript=skater_sparks_update
	
    Obj_GetId
    MangleChecksums a=skatersplash b=<objId>
    // Mick: There is no need for the skatersplash_update, as the emit script sets the position
    SetScript name=<mangled_id> emitscript=emit_skatersplash //updatescript=skatersplash_update
endscript

script skater_blood_emit
	setlife min=.25 max=1
    setanglespread spread=0.1
    setspeedrange min=4 max=8
//	setemittarget target=(0,1,0)
    setforce force=(0.0,-0.5,0.0)
    setparticlesize sw=2 sh=2 ew=2 eh=2
    setcolor corner=0  sr=100 sg=00 sb=00 sa=255  er=80 eg=0 eb=0 ea=0
    setcolor corner=1  sr=100 sg=00 sb=00 sa=255  er=80 eg=0 eb=0 ea=0
    setcolor corner=2  sr=100 sg=00 sb=00 sa=255  er=80 eg=0 eb=0 ea=0
    setcolor corner=3  sr=100 sg=00 sb=00 sa=255  er=80 eg=0 eb=0 ea=0
    begin
        if ShouldEmitParticles name=<name>
            emit num=1
        endif
        wait 1 gameframe
    repeat
endscript

script skater_blood_emit_super
	setlife min=.25 max=1
    setanglespread spread=0.3
    setspeedrange min=4 max=10
//	setemittarget target=(0,1,0)
    setforce force=(0.0,-0.5,0.0)
    setparticlesize sw=2 sh=2 ew=6 eh=6
    setcolor corner=0  sr=50 sg=00 sb=00 sa=255  er=50 eg=0 eb=0 ea=0
    setcolor corner=1  sr=50 sg=00 sb=00 sa=255  er=50 eg=0 eb=0 ea=0
    setcolor corner=2  sr=50 sg=00 sb=00 sa=255  er=50 eg=0 eb=0 ea=0
    setcolor corner=3  sr=50 sg=00 sb=00 sa=255  er=50 eg=0 eb=0 ea=0
    begin
        if ShouldEmitParticles name=<name>
            emit num=1
        endif
        wait 1 gameframe
    repeat
endscript


/* With lines
script skater_sparks_emit
    setlife min=.4 max=.6
    setanglespread spread=.25
    setspeedrange min=2 max=3
    setforce force=(0.0,-0.1,0)
    setparticlesize sw=3 sh=3 //ew=3 eh=2//sh=.25 ew=1 eh=.25
	setcolor corner=0 sr=255 sg=255 sb=64 sa=128  
	setcolor corner=1 sr=255 sg=255 sb=64 sa=64     
	setcolor corner=2 sr=255 sg=255 sb=64 sa=0 
	begin
		if ShouldEmitParticles name=<name>
				emit num=1
        endif
        wait 1 gameframe
    repeat
endscript
*/

// Glow Ribbontrail sparks
script skater_sparks_emit
    setlife min=.25 max=.3
    setanglespread spread=.25
    setspeedrange min=4 max=8
    setforce force=(0.0,-0.3,0)
    setparticlesize sw=1.25 sh=1.25 ew=.75 eh=.75//sh=.25 ew=1 eh=.25
	setcolor corner=0 sr=255 sg=255 sb=255 sa=255	 ma=255   	er=255 eg=255 eb=255 ea=0  
	setcolor corner=1 sr=255 sg=255 sb=64 sa=128	 ma=128		er=255 eg=64 eb=64 ea=0  
    setcolor corner=2 sr=255 sg=64 sb=64 sa=0 		ma=0		er=255 eg=64 eb=64 ea=0
    //the trails
	setcolor corner=3 sr=255 sg=255 sb=64 sa=80		ma=80		er=255 eg=128 eb=64 ea=0 //ea=255
	setcolor corner=4 sr=255 sg=255 sb=64 sa=64		ma=64		er=255 eg=128 eb=64 ea=0 //ea=255
	setcolor corner=5 sr=255 sg=255 sb=64 sa=0		ma=0 		er=255 eg=128 eb=64 ea=0//ea=255
//	setcolor corner=6 sr=255 sg=255 sb=255 sa=30 //ea=255
//	setcolor corner=7 sr=255 sg=255 sb=255 sa=20 //ea=255
//	setcolor corner=8 sr=255 sg=255 sb=255 sa=10 //ea=255
//	setcolor corner=9 sr=255 sg=255 sb=255 sa=0 //ea=255
	begin
		if ShouldEmitParticles name=<name>
				emit num=randomrange(1,2)
        endif
        wait 1 gameframe
    repeat
endscript

// Glow Ribbontrail sparks
script skater_elec_sparks_emit
    setlife min=.25 max=.3
    setanglespread spread=.25
    setspeedrange min=4 max=8
    setforce force=(0.0,-0.3,0)
    setparticlesize sw=1.25 sh=1.25 ew=.75 eh=.75//sh=.25 ew=1 eh=.25
	setcolor corner=0 sr=255 sg=255 sb=255 sa=255	 ma=255   	er=255 eg=255 eb=255 ea=0  
	setcolor corner=1 sr=124 sg=255 sb=255 sa=128	 ma=128		er=124 eg=64 eb=255 ea=0  
    setcolor corner=2 sr=124 sg=64 sb=255 sa=0 		ma=0		er=124 eg=64 eb=255 ea=0
    //the trails
	setcolor corner=3 sr=124 sg=255 sb=255 sa=80		ma=80		er=124 eg=128 eb=255 ea=0 //ea=255
	setcolor corner=4 sr=124 sg=255 sb=255 sa=64		ma=64		er=124 eg=128 eb=255 ea=0 //ea=255
	setcolor corner=5 sr=124 sg=255 sb=255 sa=0		ma=0 		er=124 eg=128 eb=255 ea=0//ea=255
//	setcolor corner=6 sr=255 sg=255 sb=255 sa=30 //ea=255
//	setcolor corner=7 sr=255 sg=255 sb=255 sa=20 //ea=255
//	setcolor corner=8 sr=255 sg=255 sb=255 sa=10 //ea=255
//	setcolor corner=9 sr=255 sg=255 sb=255 sa=0 //ea=255
	begin
		if ShouldEmitParticles name=<name>
				emit num=randomrange(1,2)
        endif
        wait 1 gameframe
    repeat
endscript


script skater_flames_emit
    setlife min=.25 max=.3
    setanglespread spread=.25
    setspeedrange min=4 max=8
    setforce force=(0.0,-0.3,0)
    setparticlesize sw=4 sh=4 ew=4 eh=4//sh=.25 ew=1 eh=.25
	setcolor corner=0 sr=255 sg=255 sb=255 sa=255	 ma=255   	er=255 eg=255 eb=255 ea=0  
	setcolor corner=1 sr=255 sg=255 sb=64 sa=128	 ma=128		er=255 eg=64 eb=64 ea=0  
    setcolor corner=2 sr=255 sg=64 sb=64 sa=0 		ma=0		er=255 eg=64 eb=64 ea=0
    //the trails
	setcolor corner=3 sr=255 sg=255 sb=64 sa=80		ma=80		er=255 eg=128 eb=64 ea=0 //ea=255
	setcolor corner=4 sr=255 sg=255 sb=64 sa=64		ma=64		er=255 eg=128 eb=64 ea=0 //ea=255
	setcolor corner=5 sr=255 sg=255 sb=64 sa=0		ma=0 		er=255 eg=128 eb=64 ea=0//ea=255
//	setcolor corner=6 sr=255 sg=255 sb=255 sa=30 //ea=255
//	setcolor corner=7 sr=255 sg=255 sb=255 sa=20 //ea=255
//	setcolor corner=8 sr=255 sg=255 sb=255 sa=10 //ea=255
//	setcolor corner=9 sr=255 sg=255 sb=255 sa=0 //ea=255
	begin
		if ShouldEmitParticles name=<name>
				emit num=randomrange(2,4)
        endif
        wait 1 gameframe
    repeat
endscript
/*
// Old system with a simple texture and additive blend mode
script skater_sparks_emit
    setlife min=.4 max=.6
    setanglespread spread=.25
    setspeedrange min=2 max=3
    setforce force=(0.0,-0.1,0)
    setparticlesize sw=3 sh=2 ew=3 eh=2//sh=.25 ew=1 eh=.25
	setcolor corner=0 sr=230 sg=230 sb=64 sa=128  er=0 eg=0 eb=0 ea=0
	setcolor corner=1 sr=230 sg=230 sb=64 sa=0  er=0 eg=0 eb=0 ea=0
    begin
		if ShouldEmitParticles name=<name>
				emit num=1
        endif
        wait 1 gameframe
    repeat
endscript

*/
script sparks_on bone=Bone_Board_Tail
    //printf " ->->->->->->->->->->->-> SPARKS ON!!!!"
	Obj_GetId
    MangleChecksums a=skater_sparks_system b=<objId>
    MangleChecksums a=<mangled_id> b=<bone>	
	;If InNetgame
		// no cheats in netgames
		;set_spark_script name=<mangled_id>
	;else	
		If not GetGlobalFlag Flag=CHEAT_FLAME
			set_spark_script name=<mangled_id>
		else
			SetScript name=<mangled_id> emitscript=skater_flames_emit
		endif	
    ;endif
	ParticlesOn name=<mangled_id>
endscript

script set_spark_script
	GetTerrain
	if ( ( <Terrain> = 41 ) || ( <Terrain> = 50 ) || ( <Terrain> = 54 ) )
		SetScript name=<Name> emitscript=skater_elec_sparks_emit
	else
		SetScript name=<Name> emitscript=skater_sparks_emit
	endif
endscript

script sparks_off bone=Bone_Board_Tail
    Obj_GetId
    MangleChecksums a=skater_sparks_system b=<objId>
    MangleChecksums a=<mangled_id> b=<bone>
    ParticlesOff name=<mangled_id>
endscript

script TurnOffSkaterSparks
//    sparks_off bone=Bone_Board_Root
//    sparks_off bone=Bone_Board_Nose
    sparks_off bone=Bone_Board_Tail
endscript

script SkaterBloodOn num=10
    VerifyParam param=name func=SkaterBloodOn <...>
	If not GetGlobalFlag Flag=CHEAT_SUPER_BLOOD
		SetScript name=<name> emitscript=skater_blood_emit
	else
		SetScript name=<name> emitscript=skater_blood_emit_super
	endif	    
	begin
		ParticlesOn name=<name>
        wait 1 gameframe
    repeat <num>
    ParticlesOff name=<name>
endscript

script SkaterBloodOff
//    printf "Skater blood off!"
    VerifyParam param=name func=SkaterBloodOff <...>
    ParticlesOff name=<name>
endscript

script BloodParticlesOn bone=Bone_Head
    ;ReplayRecordSimpleScriptCall scriptname=BloodParticlesOn skaterscript
//    printf "Blood particles on!"
    Obj_GetId
    MangleChecksums a=skater_blood_system b=<objId>
    MangleChecksums a=<mangled_id> b=<bone>
    Obj_SpawnScript SkaterBloodOn params = { name=<mangled_id> num=<num> }
endscript

script BloodParticlesOff bone=Bone_Head
    ;ReplayRecordSimpleScriptCall scriptname=BloodParticlesOff skaterscript
	Obj_GetId
	MangleChecksums a=skater_blood_system b=<objId>
    MangleChecksums a=<mangled_id> b=Bone_Head    
	SkaterBloodOff name=<mangled_id>
	EmptyParticleSystem name=<mangled_id>
	// should also kill any spawned scripts that have blood particles on?
endscript

script skater_blood_update
	// for now, set up a maximum amount of time that we will keep updating the particle system position
//	extra_update_time=0
//	extra_update_limit=40
	begin
        // get the orientation of the skater, so that
        // the particles will project forth from him
//        if ShouldEmitParticles name=<name>  
//				printf "emit particles"			
				<objId>:Obj_GetBonePosition bone=<bone>
				setpos x=<x> y=<y> z=<z>
/*		else
			if (<extra_update_time> < <extra_update_limit>)
				<objId>:Obj_GetBonePosition bone=<bone>
				setpos x=<x> y=<y> z=<z>
				<extra_update_time> = (<extra_update_time> + 1)
			else
				printf "reset extra_update_limit"
				<extra_update_time>=0	
			endif
		endif		 	
*/	
	wait 1 gameframe
	repeat
endscript

script SetSparksTruckFromNollie
	if InNollie
		SetFrontTruckSparks
	else
		SetRearTruckSparks
	endif
endscript


script skater_sparks_update bone_front=Bone_Board_Nose bone_back=Bone_Board_Tail Nosegrind=0
    begin
        // get the orientation of the skater, so that
        // the particles will project forth from him
        if ShouldEmitParticles name=<name>  
			<objId>:Obj_GetOrientation
			RotateVector x=<x> y=<y> z=<z> ry=180 // rx=45
//			<y>=(<y>+.8)
			SetEmitTarget x=<x> y=.5 z=<z>
			
			If <objId>:FrontTruckSparks
				if <objId>:BoardIsRotated
					<objId>:Obj_GetBonePosition bone=<bone_back>
				else
					<objId>:Obj_GetBonePosition bone=<bone_front>	
				endif
			else	
				if <objId>:BoardIsRotated
					<objId>:Obj_GetBonePosition bone=<bone_front>
				else
					<objId>:Obj_GetBonePosition bone=<bone_back>	
				endif
			endif
			
//			if not IsTrue GAMEPAUSED			
//			printf "Spark Pos = %q %w %e" q=<x> w=<y> e=<z>			
//			endif
//			<z>=(<z>+10.0)
			// the bones origins are high, up in the skateboard, so drop down a bit
			<y>=(<y>-2.0)			
			setpos x=<x> y=<y> z=<z>
		endif	
		wait 1 gameframe

//		else
//			break
//		endif		
    repeat
endscript


script skatersplash_update bone=Bone_Pelvis
	begin
        // get the orientation of the skater, so that
        // the particles will project forth from him  	
				<objId>:Obj_GetBonePosition bone=<bone>
				setpos x=<x> y=<y> z=<z>
	wait 1 gameframe
	repeat
endscript


script SkaterSplashOff
    ;ReplayRecordSimpleScriptCall scriptname=SkaterSplashOff skaterscript
    Obj_GetId
    MangleChecksums a=skatersplash b=<objId>	
	ParticlesOff name=<mangled_id>
	EmptyParticleSystem name=<mangled_id>
endscript

script SkaterSplashOn
    ;ReplayRecordSimpleScriptCall scriptname=SkaterSplashOn skaterscript
    Obj_GetId
  	MangleChecksums a=skatersplash b=<objId>	
	SetScript name=<mangled_id> emitscript=emit_skatersplash	
	ParticlesOn name=<mangled_id>
endscript

script emit_skatersplash 
//	printstruct <...>
	
	setlife min=.25 max=.25
	setanglespread spread=0.4
	setspeedrange min=1.0 max=10.0
	setemitrange width=4.0 height=4.0
	setforce force=(0.0,-0.3,0)
	setemittarget target=(0.0,1.0,0.0)
	setparticlesize sw=3.0 sh=6.0 ew=.1 eh=.2
	
	setcolor corner=0 sr=255 sg=255 sb=255 sa=64	 ma=64   	er=255 eg=255 eb=255 ea=0 midtime=-1  
	setcolor corner=1 sr=255 sg=255 sb=255 sa=32	 ma=32		er=255 eg=255 eb=255 ea=0 midtime=-1  
    setcolor corner=2 sr=255 sg=255 sb=255 sa=0 	 ma=0		er=255 eg=255 eb=255 ea=0 midtime=-1
	SetCircularEmit circular=0
	
	begin
		if ShouldEmitParticles name=<name>
			<objId>:Obj_GetBonePosition bone=Bone_Bone_Pelvis    
			setpos x=<x> y=<y> z=<z>			
			emit num=50
		endif
		wait 1 game frame
	repeat
endscript

script emit_jumpjets 
//	printstruct <...>
	
	setlife min=.3 max=.4
	setanglespread spread=0.2
	setspeedrange min=3.0 max=10.0
	setemitrange width=2.0 height=2.0
	setforce force=(0.0,-0.3,0)
	setemittarget target=(0.0,-1.0,0.0)
	setparticlesize sw=10.0 sh=15.0 ew=1 eh=1.0
	
	setcolor corner=0 sr=255 sg=255 sb=255 sa=255	 ma=255   	er=255 eg=255 eb=255 ea=0  
	setcolor corner=1 sr=255 sg=255 sb=64 sa=128	 ma=128		er=255 eg=64 eb=64 ea=0  
    setcolor corner=2 sr=255 sg=64 sb=64 sa=0 		ma=0		er=255 eg=64 eb=64 ea=0
      
	SetCircularEmit circular=0
	
	begin
        if ShouldEmitParticles name=<name>
//			<objId>:Obj_GetBonePosition bone=Bone_Pelvis    
//			setpos x=<x> y=<y> z=<z>			
			emit num=5
		endif
		wait 1 game frame
	repeat 
endscript

script update_jumpjets
	begin
        // get the orientation of the skater, so that
        // the particles will project forth from him  	
				<objId>:Obj_GetBonePosition bone=Bone_Pelvis
				setpos x=<x> y=<y> z=<z>
	wait 1 gameframe
	repeat
endscript

/*
script update_jumpjets
	begin
  		<objId>:Obj_GetOrientation
		// printf "z=%z" z=<z>
		RotateVector x=<x> y=<y> z=<z> ry=180 // rx=45
		SetEmitTarget x=<x> y=-1 z=<z> //<z>
      
		// get the orientation of the skater, so that
        // the particles will project forth from him  	
				<objId>:Obj_GetBonePosition bone=mullet_cloth_zz
				x=(<x>+10)
				setpos x=<x> y=<y> z=<z>
	printf "here"			
	wait 1 gameframe
	repeat
endscript
*/ 
 
script chad_sparks_emit
    setlife min=.2 max=.3
    setanglespread spread=.15
    setspeedrange min=4 max=8
    setforce force=(0.0,-0.3,0)
    setparticlesize sw=1 sh=1 ew=2 eh=2 //sh=.25 ew=1 eh=.25
	setcolor corner=0 sr=128 sg=0 sb=200 sa=240	 	ma=240   	er=128 eg=0 eb=240 ea=0  
	setcolor corner=1 sr=128 sg=0 sb=200 sa=128	 	ma=128		er=128 eg=0 eb=200 ea=0  
    setcolor corner=2 sr=128 sg=0 sb=200 sa=0 		ma=0		er=128 eg=0 eb=64 ea=0
    //the trails
	setcolor corner=3 sr=0 sg=0 sb=128 sa=80		ma=80		er=0 eg=0 eb=64 ea=0 //ea=255
	setcolor corner=4 sr=0 sg=0 sb=128 sa=64		ma=64		er=0 eg=0 eb=64 ea=0 //ea=255
	setcolor corner=5 sr=0 sg=0 sb=128 sa=0			ma=0 		er=0 eg=0 eb=64 ea=0//ea=255
	begin
		
		if ShouldEmitParticles name=<name>
				emit num=5
        endif
        wait 1 gameframe
    repeat
endscript

script jango_laser_emit
    setlife min=.5 max=.5
    setanglespread spread=0
    setspeedrange min=8 max=8
    setforce force=(0.0,0.0,0.0)
    setparticlesize sw=2 sh=2 ew=12 eh=12 //sh=.25 ew=1 eh=.25
	setcolor corner=0 sr=255 sg=200 sb=200 sa=255	 ma=255   	er=255 eg=200 eb=200 ea=0  
	setcolor corner=1 sr=255 sg=64 sb=64 sa=128	 ma=128		er=255 eg=64 eb=64 ea=0  
    setcolor corner=2 sr=255 sg=64 sb=64 sa=0 		ma=0		er=255 eg=64 eb=64 ea=0
   	
	emit num=5
	//Playsound laserfire  //unloaded sound from skater_sfx.q - DavidR
	
	begin
		if ShouldEmitParticles name=<name>
			emit num=5
			//Playsound laserfire  // unloaded sound from skater_sfx.q
		endif
        wait 76 frames
    repeat
endscript


script laser_update 
//	printstruct <...>
	begin
		<objId>:Obj_GetOrientation
		// printf "z=%z" z=<z>
		RotateVector x=<x> y=<y> z=<z> ry=180 // rx=45
		SetEmitTarget x=<x> y=.4 z=<z> //<z>
		<objId>:Obj_GetBonePosition bone=Bone_Board_Tail	
		<y>=(<y>+10)
		setpos x=<x> y=<y> z=<z>
	wait 1 gameframe
	repeat
endscript



///////////////////////////////////////////////////////////////////////////////////
//////////////// Special Trick New Style Particles  //////////////////////////////
/////////////////////////////////////////////////////////////////////////////////





skater_particle_composite_structure = 
[
    { component = suspend }
    { component = particle }
	{ component = lockobj}

]

Script CleanUp_SpecialTrickParticles
	Obj_GetId
	MangleChecksums A=<ObjId> B=SpecialTrickParticles
	particle_id=<mangled_id>
	
	if ObjectExists id=<particle_id>
		<particle_id>:Die
	endif
endscript

// This script is used to fire off new particle systems attached to the skater
script Emit_SpecialTrickParticles Bone=Bone_head specialtrick_particles=barf_particles
	//GetSkaterPosition
    //GetSkaterVelocity scale=2000.0
	Obj_GetId
	//id = poo
	MangleChecksums A=<ObjId> B=SpecialTrickParticles
	particle_id=<mangled_id>
	if ObjectExists id=<particle_id>
		<particle_id>:Die
	endif
	
	//printstruct <...>
	wait 1 game frame
	printf "about to create .........................."
	
	if not GotParam dont_orient_toskater
		GetSkaterVelocity	
		vel=( <vel_x> * ( 1, 0, 0 ) + <vel_y> * ( 0, 1, 0 ) + <vel_z> * ( 0, 0, 1 ) )	
		CreateCompositeObject {
			Components=skater_particle_composite_structure
			   Params={ 
					Name = <particle_id>
					LocalSpace
					vel=<vel>
					orient_to_vel
					<specialtrick_particles> 
					 }}
	else
		printf "Here?"
		CreateCompositeObject {
			Components=skater_particle_composite_structure
			   Params={ 
					Name = <particle_id>
					LocalSpace
					<specialtrick_particles> 
					 }}
	endif				 
		
	<particle_id>:Obj_LockToObject Bone=<bone> Id=<ObjId>  
	if GotParam StopEmitAt
		Wait <StopEmitAt> seconds
		if ObjectExists id=<particle_id>
			<particle_id>:SetEmitRate 0
		endif
	endif	
endscript

fire_particles = 
{
	Class = ParticleObject
	Type = Default
	BoxDimsStart = (20.419441,20.246090,0.351075)
	MidPosition = (-0.002134,-10.852689,-0.058679)
	BoxDimsMid = (6.278898,6.278898,6.278898)
	EndPosition = (-0.015868,-40.335335,-0.058680)
	BoxDimsEnd = (14.713875,14.713875,14.713875)
	Texture = dt_generic_particle01
	CreatedAtStart
	AbsentInNetGames
	UseMidPoint
	UseColorMidTime
	Type = NEWFLAT
	BlendMode = Add
	FixedAlpha = 128
	AlphaCutoff = 1
//	UpdateScript = ?	// Undefined (Not in scripts.ini)
	MaxStreams = 2
	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	EmitRate = 160.0
	Lifetime = 0.4
	MidPointPCT = 50
	StartRadius = 7.0
	MidRadius = 5.0
	EndRadius = 3.5
	StartRadiusSpread = 1.0
	MidRadiusSpread = 1.0
	EndRadiusSpread = 1.0
	StartRGB = [150,72,25]
	StartAlpha = 85
	ColorMidTime = 50
	MidRGB = [150,67,18]
	MidAlpha = 85
	EndRGB = [150,67,18]
	EndAlpha = 0
} 

barf_particles = 
{
 Class = ParticleObject
 Type = Default
	BoxDimsStart = (1.401378,1.401378,1.401378)
	MidPosition = (-0.009090,-17.076101,-0.034920)
	BoxDimsMid = (4.443864,4.443864,4.443864)
	EndPosition = (-0.064480,-64.399330,-0.034921)
	BoxDimsEnd = (6.667320,6.667320,6.667320)
	Texture = dt_barf02
	CreatedAtStart
	AbsentInNetGames
	UseMidPoint
	UseColorMidTime
	Type = NEWFLAT
	BlendMode = Blend
	FixedAlpha = 128
	AlphaCutoff = 1
//	UpdateScript = ?	// Undefined (Not in scripts.ini)
	MaxStreams = 2
	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	EmitRate = 100.0
	Lifetime = .3	
	MidPointPCT = 50
	StartRadius = 1.0
	MidRadius = 2.0
	EndRadius = 3.0
	StartRadiusSpread = 1.0
	MidRadiusSpread = 1.0
	EndRadiusSpread = 1.0
	StartRGB = [105,111,96]
	StartAlpha = 122
	ColorMidTime = 50
	MidRGB = [105,111,96]
	MidAlpha = 160
	EndRGB = [105,111,96]
	EndAlpha = 50

}








	
// Added for Jamie Thomas special trick (flames from NJ pipe)
firebreath_particles =	
{
	Class = ParticleObject
	Type = Default
	BoxDimsStart = (.7,.7,.7)
	MidPosition = (-0.002138,10.166236,-0.058679)
	BoxDimsMid = (4.542354,4.542354,4.542354)
	EndPosition = (-0.015876,38.125256,-0.058676)
	BoxDimsEnd = (9.063875,9.063875,9.063875)
	Texture = dt_generic_particle01
	CreatedAtStart
	AbsentInNetGames
	UseMidPoint
	UseColorMidTime
	Type = NEWFLAT
	BlendMode = Add
	FixedAlpha = 128
	AlphaCutoff = 1
//	UpdateScript = ?	// Undefined (Not in scripts.ini)
	MaxStreams = 2
	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	EmitRate = 250.0
	Lifetime = 0.2
	MidPointPCT = 50
	StartRadius = 4.0
	MidRadius = 4.0
	EndRadius = 6.0
	StartRadiusSpread = 1.0
	MidRadiusSpread = 1.0
	EndRadiusSpread = 1.0
	StartRGB = [150,93,59]
	StartAlpha = 82
	ColorMidTime = 50
	MidRGB = [150,67,18]
	MidAlpha = 109
	EndRGB = [150,67,18]
	EndAlpha = 0
}

iron_particles =	

{
	Class = ParticleObject
	Type = Default
	BoxDimsStart = (0.184903,0.184903,0.184903)
	MidPosition = (0.000028,0.035150,550.596313)
	BoxDimsMid = (0.388124,0.388124,0.388124)
	EndPosition = (-0.004006,1.283962,1078.809570)
	BoxDimsEnd = (0.389736,0.389736,0.389736)
	Texture = dt_ironblast01
	CreatedAtStart
	AbsentInNetGames
	UseMidPoint
	UseColorMidTime
	Type = NEWFLAT
	BlendMode = Add
	FixedAlpha = 128
	AlphaCutoff = 1
//	UpdateScript = ?	// Undefined (Not in scripts.ini)
	MaxStreams = 2
	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	EmitRate = 1500.0
	Lifetime = .1
	MidPointPCT = 50
	StartRadius = 6.0
	MidRadius = 6.0
	EndRadius = 6.0
	StartRadiusSpread = 0.0
	MidRadiusSpread = 0.0
	EndRadiusSpread = 0.0
	StartRGB = [150,93,59]
	StartAlpha = 105
	ColorMidTime = 50
	MidRGB = [150,67,18]
	MidAlpha = 122
	EndRGB = [150,67,18]
	EndAlpha = 0
}
   
