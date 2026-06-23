// Make sure the assets for these (MDL/SKIN/SKA)
// are loaded in startup.q!

bmx_collision_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = Bmx_Collision
	Class = GameObject
	Type = Ghost
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]

	// example to make a non-skinned prop
	Model = "none"

	/*
	// example to make a skinned, animated prop
	skeletonName = meerkat
	animName = animload_anl_meerkat
	model = "animals/anl_meerkat/anl_meerkat.skin"
*/

	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
	TriggerScript = Bmx_Collision_Script
}

Saw_Ghost_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = Saw_Ghost
	Class = GameObject
	Type = Ghost
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	// example to make a non-skinned prop
	Model = "none"
	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
}

Saw_Ghost2_details = {
	Position = (0.000000,0.000000,0.000000)
	Angles = (0.000000,0.000000,0.000000)
	Name = Saw_Ghost2
	Class = GameObject
	Type = Ghost
	CollisionMode = None
	IgnoredLights = [ 0, 1 ]
	// example to make a non-skinned prop
	Model = "none"
	SuspendDistance = 0
	lod_dist1 = 400
	lod_dist2 = 401
}


script Bmx_Collision_Script
	Obj_ClearExceptions
	Obj_SetInnerRadius 2
	Obj_SetException ex=SkaterInRadius scr=Bmx_Collision_Collide
	begin
		Obj_GetSpeed
		if (<speed> = 0)
		else
			//if (<speed> < 27 )
			if (<speed> < 29.9 )
				//printf "slow"
				SendFlag FLAG_TRICK_NOW name=TRG_BMX_Checker
			else
				//printf "fast"
				ClearFlag FLAG_TRICK_NOW name=TRG_BMX_Checker
			endif
		endif
		//printf "speed %s" s=<speed>
		wait 3 frames
	repeat
endscript


script Bmx_Collision_Collide
	Obj_ClearExceptions
	Obj_SetOuterRadius 5
	Obj_SetException ex=SkaterOutOfRadius scr=Bmx_Collision_Script
	printf "Bail now Bitch"
	Obj_PlayStream random (
		@rick_Collide01
		@rick_Collide02
		@rick_Collide03
		@rick_Collide04
		@rick_Collide05
		@rick_Collide06
		@rick_Collide07
		@rick_Collide08
	)
	MakeSkaterGoto PedKnockDown
endscript

/*
script ExampleScriptToTurnOnPizzaBox
	GetSkaterID skater=0
	<objID>:CreateSpecialItem index=0 params=pizzabox_details bone=bone_pelvis
	<objID>:CreateSpecialItem index=1 params=pizzabox_details bone=left_knee
endscript

script ExampleScriptToTurnOffPizzaBox
	GetSkaterID skater=0
	<objID>:DestroyAllSpecialItems
endscript
*/
