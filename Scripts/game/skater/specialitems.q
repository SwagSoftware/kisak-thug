// Make sure the assets for these (MDL/SKIN/SKA)
// are loaded in startup.q!

pizzabox_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = PizzaBox
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a non-skinned prop
	//Model = "specialitems/pizzabox/pizzabox.mdl"
	

	// example to make a skinned, animated prop
	skeletonName = pizzabox
	animName = animload_si_pizza
	model = "specialitems/pizzabox/pizzabox.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = PizzaBox_Script
}

spraycan_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = SprayCan
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_generic
	animName = animload_si_generic
	model = "specialitems/spraycan/spraycan.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = SprayCan_Script
}

mpc_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = Mpc
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_generic
	animName = animload_si_generic
	model = "specialitems/mpc/mpc.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = mpc_Script
}

guitar_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = Guitar
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_generic
	animName = animload_si_generic
	model = "specialitems/guitar/guitar.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = guitar_Script
}

guitar_skateshop_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = Guitar
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_generic
	animName = animload_si_generic
	model = "specialitems/guitar/guitar.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = guitar_skateshop_Script
}



gun_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = Gun
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = gun
	animName = animload_si_gun
	model = "specialitems/gun/gun.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = Gun_Script
}

flag_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = flag
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = flag
	animName = animload_si_flag
	model = "specialitems/flag/flag.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = flag_Script
}

grapplehook_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = grapplehook
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = grapplehook
	animName = animload_SI_GrappleHook
	model = "specialitems/grapplehook/grapplehook.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = grapplehook_Script
}

basketball_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = basketball
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_generic
	animName = animload_si_generic
	model = "specialitems/basketball/basketball.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = Basketball_Script
}

bustedboard_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = bustedboard
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = bustedboard
	animName = animload_SI_BustedBoard
	model = "specialitems/bustedboard/bustedboard.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = bustedboard_Script
}

extraboard_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = extraboard
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_extraboard
	animName = animload_SI_ExtraBoard
	model = "specialitems/Extraboard/Extraboard.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = extraboard_Script
}

tongue_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = Tongue
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_tongue
	animName = animload_SI_tongue
	model = "specialitems/Tongue/SEC_Gene_Tongue.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = tongue_Script
}


bustedboard_jump_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = bustedboard
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = bustedboard
	animName = animload_SI_BustedBoard
	model = "specialitems/bustedboard/bustedboard.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = bustedboard_jump_Script
}


boombox_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = boombox
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_boombox
	animName = animload_si_boombox
	model = "specialitems/boombox/boombox.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = Boombox_Script
}

skull_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = skull
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_skull
	animName = animload_si_skull
	model = "specialitems/skull/head_skull.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = Skull_Script
}

bloodyguts_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = bloodyguts
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_generic
	animName = animload_si_generic
	model = "specialitems/bloodyguts/bloodyguts.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = Bloodyguts_Script
}

ferret_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = ferret
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = ferret
	animName = animload_si_ferret
	model = "specialitems/ferret/ferret.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = ferret_Script
}

pistol_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = pistol
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = pistol
	animName = animload_si_pistol
	model = "specialitems/pistol/pistol.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = pistol_Script
	CleanupScript = pistol_cleanup
}

hulahoop_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = hulahoop
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = si_generic
	animName = animload_si_generic
	model = "specialitems/hulahoop/hulahoop.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = hulahoop_Script
}

motoxbike_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = MotoxBike
	Class = GameObject
	Type = SpecialItem
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	
	// example to make a skinned, animated prop
	skeletonName = motoxbike
	animName = animload_motorx
	model = "specialitems/motorx/motorx.skin"

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = nullscript
}

script Bloodyguts_Script
	SpecialItem_SyncAnims Anim1=BloodyEddie_Init Anim2=BloodyEddie_Idle Anim3=BloodyEddie_Out   
endscript

script Tongue_Script
	SpecialItem_SyncAnims Anim1=LickItUp_Init Anim2=LickItUp_Idle Anim3=LickItUp_Out   
endscript

script ferret_Script
	SpecialItem_SyncAnims Anim1=Ferret_Init Anim2=Ferret_Idle   
endscript

script Pistol_Script
	SpecialItem_SyncAnims Anim1=JangoQuickDraw_Init Anim2=JangoQuickDraw_Idle Anim3=JangoQuickDraw_Out Particles2=jango_laser_emit update_script=laser_update   
endscript

script pistol_cleanup	
	GetTags	 //this allows us to find out the parent object that called this special item
	Obj_KillSpawnedScript id=prop_particles2_spawn
	MangleChecksums a=skatersplash b=<ParentId>
	EmptyParticleSystem name=<mangled_id>
	SetScript name=<mangled_id> emitscript=emit_skatersplash updatescript=skatersplash_update
	ParticlesOff name=<mangled_id>
	printf "TURN OFF SPECIAL PARTICLES"
endscript

script hulahoop_Script
	SpecialItem_SyncAnims Anim1=HulaHoopGrind_Init Anim2=HulaHoopGrind_Idle Anim3=HulaHoopGrind_out   
endscript

script Boombox_Script
	SpecialItem_SyncAnims Anim1=MuskaManual_Init Anim2=MuskaManual_Idle Anim3=MuskaManual_out   
endscript

script Skull_Script
	SpecialItem_SyncAnims Anim1=CrookedSkull_Init Anim2=CrookedSkull_Idle Anim3=CrookedSkull_out   
endscript


script bustedboard_Script
	SpecialItem_SyncAnims Anim1=DaffyBroken_Init Anim2=DaffyBroken_Range Anim3=DaffyBroken_Out TurnBoardOff   
endscript

script extraboard_Script
	SpecialItem_SyncAnims Anim1=YeahRight_Init Anim2=YeahRight_Idle Anim3=YeahRight_Out  
endscript

script bustedboard_jump_Script
	SpecialItem_SyncAnims Anim1=MightAsWellJump_Init Anim2=MightAsWellJump_Idle Anim3=MightAsWellJump_Out TurnBoardOff speed=1.75   
endscript

script Basketball_Script
//	printf "--------------->trigger bball"
	SpecialItem_SyncAnims Anim1=BasketballSlide_Init Anim2=BasketballSlide_Idle Anim3=BasketballSlide_Out   
endscript

script grapplehook_Script
	SpecialItem_SyncAnims Anim1=GrappleGrab_Init Speed=1.5 Anim2=GrappleGrab_Idle Anim3=GrappleGrab_Out  
endscript


script Flag_Script
	SpecialItem_SyncAnims Anim1=AmericanHeroGrind_Init Anim2=AmericanHeroGrind_Idle Anim3=AmericanHeroGrind_Out  
endscript


script Gun_Script
	SpecialItem_SyncAnims Anim1=Ped_PPGun_Idle Anim2=Ped_PPGun_Shoot   
endscript

script Guitar_Script
	SpecialItem_SyncAnims Anim1=Guitar_Init Anim2=Guitar_Idle   
endscript

script Guitar_Skateshop_Script
//	printf "GUITAR GOT CALLED"
	SpecialItem_SyncAnims Anim1=Idle_Caballero1 Cycle=cycle Anim2=Idle_Caballero2 DoNotTurnOff   
endscript


script mpc_Script
	SpecialItem_SyncAnims Anim1=MpcGrind_Init Anim2=MpcGrind_Idle   
endscript

script SprayCan_Script
	SpecialItem_SyncAnims Anim1=SprayPaint_Init Anim2=SprayPaint_Range wobble Anim3=SprayPaint_Out Particles=chad_sparks_emit  
endscript

script SprayCan_cleanup	
	GetTags	 //this allows us to find out the parent object that called this special item
	Obj_KillSpawnedScript id=prop_particles_spawn
	MangleChecksums a=skater_sparks_system b=<ParentId>
	MangleChecksums a=<mangled_id> b=Bone_Board_Tail
	SetScript name=<mangled_id> emitscript=skater_sparks_emit
endscript

script PizzaBox_Script
	SpecialItem_SyncAnims Anim1=ChompOnThis_Init Anim2=ChompOnThis_Idle Anim3=ChompOnThis_Out 
endscript

// this script is basically the "ai" for any special props/ietms pulled out during special tricks
// the item itself runs the script and "watches" its parent in an attempt t sync up
script SpecialItem_SyncAnims speed=1.0
	GetTags	 //this allows us to find out the parent object that called this special item
	// some special items have special particle systems too
	If GotParam Particles
		Obj_SpawnScript Prop_Particles id=prop_particles_spawn params={<...>}
	endif	
	If GotParam Particles2
		Obj_SpawnScript Prop_Particles2 id=prop_particles2_spawn params={<...>}
	endif	
	// flip the item if the parent skater is flipped
	if <ParentId>:Obj_AnimationFlipped
		Obj_Flip
	endif
	If GotParam TurnBoardOff
		<ParentId>:SwitchOffBoard
	endif			
	// now sit in a loop and watch the anims that the parent is playing. There is only
	// support for three anims, usually an _init an _idle and an _out
	begin
		if <ParentId>:AnimEquals <Anim1> 
			<ParentId>:Obj_GetAnimSpeed <Anim1>
			Obj_PlayAnim Anim=<Anim1> NoRestart <cycle> speed=<speed>   
		else
			if GotParam Anim2
				if <ParentId>:AnimEquals <Anim2> 
					if GotParam wobble
						<ParentId>:Obj_GetAnimSpeed <Anim2>
						Obj_PlayAnim Anim=<Anim2> wobble wobbleparams=grindwobble_params speed=<speed>
					else
//						printf "PLAYING ANIM 2"
						<ParentId>:Obj_GetAnimSpeed <Anim2>
						Obj_PlayAnim Anim=<Anim2> cycle norestart speed=<speed>
					endif
				else
					if GotParam Anim3
						if <ParentId>:AnimEquals <Anim3> 
							<ParentId>:Obj_GetAnimSpeed <Anim3>
							Obj_PlayAnim Anim=<Anim3> NoRestart speed=<speed>   
						else
							If Not GotParam DoNotTurnOff
								break
							endif	
						endif
					else
						If Not GotParam DoNotTurnOff
							break
						endif		
					endif			
				endif
			endif	
		endif	
		wait 1 game frame
	repeat
	printf "BREAKING LOOP AND CLEANING UP ITEMS"
	// if we turned no any special system, shut them down
	If GotParam Particles
		Obj_KillSpawnedScript id=prop_particles_spawn
		MangleChecksums a=skater_sparks_system b=<ParentId>
		MangleChecksums a=<mangled_id> b=Bone_Board_Tail
		SetScript name=<mangled_id> emitscript=skater_sparks_emit
	endif
	If GotParam Particles2
		Obj_KillSpawnedScript id=prop_particles2_spawn
		MangleChecksums a=skatersplash b=<ParentId>
		EmptyParticleSystem name=<mangled_id>
		SetScript name=<mangled_id> emitscript=emit_skatersplash updatescript=skatersplash_update
		ParticlesOff name=<mangled_id>
		printf "TURN OFF SPECIAL PARTICLES"
	endif
	
	If GotParam TurnBoardOff
		<ParentId>:SwitchOnBoard
	endif
	// now turn off the prop and we're done
	If Not GotParam DoNotTurnOff
		printf "3"
		<ParentId>:TurnOffSpecialItem
	endif
endscript 

script Prop_Particles particle_wait=80
	wait <particle_wait> frames	
	MangleChecksums a=skater_sparks_system b=<ParentId>
	MangleChecksums a=<mangled_id> b=Bone_Board_Tail
	SetScript name=<mangled_id> emitscript=<particles>
endscript

script Prop_Particles2 particle_wait=44
//	printstruct <...>
	wait <particle_wait> frames	 //play a laser blast for the init
	MangleChecksums a=skatersplash b=<ParentId>
	SetScript name=<mangled_id> emitscript=<particles2> updatescript=<update_script>
	ParticlesOn name=<mangled_id> 
endscript



script TurnOnSpecialItem
	CreateSpecialItem index=0 params=<specialitem_details> // they are animated with respect to the root...  ;bone=dummy_scale_zz
endscript

script TurnOffSpecialItem
	DestroyAllSpecialItems
endscript

