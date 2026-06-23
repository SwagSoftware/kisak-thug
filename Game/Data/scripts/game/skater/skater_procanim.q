// A list of all the procedurally animated clothing bones
procedural_skater_bones = [

	left_top_trouser_cloth_zz
	left_low_trouser_cloth_zz
	right_top_trouser_cloth_zz
	right_low_trouser_cloth_zz

	left_top_sleeve_cloth_zz
	left_low_sleeve_cloth_zz
	right_top_sleeve_cloth_zz
	right_low_sleeve_cloth_zz

	mullet_cloth_zz
	breast_cloth_zz
	hood_cloth_zz
	shirt_tail_cloth_zz
]

trans_max_x=0.0
trans_max_y=0.0
trans_max_z=6.5
trans_min_x=0.0
trans_min_y=0.0
trans_min_z=0.0

rot_max_x=0.0
rot_max_y=0.0
rot_max_z=128.0
rot_min_x=0.0
rot_min_y=0.0
rot_min_z=-128.0

// speed and rotations are in 4096-notation


left_low_trouser_params = 	{
	bone=left_low_trouser_cloth_zz
	speed=10		z_min=0 z_max=5.5
	//	rot_speed=256	zrot_min=-100 zrot_max=100
}

right_low_trouser_params = 	{
	bone=right_low_trouser_cloth_zz
	speed=10 		z_min=0 z_max=5.5
	//	rot_speed=200	zrot_min=-100 zrot_max=100
}

left_top_trouser_params = 	{
	bone=left_top_trouser_cloth_zz
	speed=10 		z_min=-1 z_max=3
	//	rot_speed=200	zrot_min=-100 zrot_max=100
}

right_top_trouser_params = 	{
	bone=right_low_trouser_cloth_zz
	speed=10 		z_min=-1 z_max=3
	//	rot_speed=200	zrot_min=-100 zrot_max=100
}

left_top_sleeve_params = {
	bone=left_top_sleeve_cloth_zz
	speed=10		x_min=-2 x_max=1
}

right_top_sleeve_params = {
	bone=right_top_sleeve_cloth_zz
	speed=10		x_min=-2 x_max=1
}

left_low_sleeve_params = {
	bone=left_low_sleeve_cloth_zz
	speed=10		x_min=-2 x_max=.35
}

right_low_sleeve_params = {
	bone=right_low_sleeve_cloth_zz
	speed=10		x_min=-2 x_max=.35
}

hood_cloth_params =	{
	bone=hood_cloth_zz
	rot_speed=415 yrot_min=-25 yrot_max=25 xrot_min=0 xrot_max=55
}

mullet_cloth_params = {
	bone=mullet_cloth_zz
	speed=10		z_min=-.75 z_max=.75
	speed=10		yrot_min=-25 yrot_max=25 zrot_min=-10 zrot_max=10
}


script SpawnClothingLandScript
	ReplayRecordSimpleScriptCall scriptname=SpawnClothingLandScript skaterscript
	Obj_SpawnScript ClothingLand
endscript

script SpawnClothingLandScriptHalfMax
	ReplayRecordSimpleScriptCall scriptname=SpawnClothingLandScriptHalfMax skaterscript
	Obj_SpawnScript ClothingLand params={Boobscale=.5}
endscript

script ClothingLand
	// When we land we bounce some of the clothes
	// Three bounces, each successively less
	// Boobscale is used to turn down the max boob bounce and factor out airtime on a case by case basis
	SetBoneTransActive bone=breast_cloth_zz 1
	ClothingLandBounce max=5 breast=3 Boobscale=<Boobscale>
	wait .2666 seconds// 16 gameframes
	ClothingLandBounce max=2.5 breast=1.5 speed=171 Boobscale=<Boobscale>
	wait .2 seconds //12 gameframes
	ClothingLandBounce max=1 breast=.75 speed=256 Boobscale=<Boobscale>
	wait .1333 seconds // 8 gameframes
	SetBoneTransActive bone=breast_cloth_zz 0
endscript


script ClothingLandBounce speed=128 max=10
	// Find out how long we have been in the air so we can use it to modify our bounce
	GetAirtime
	Airtime = (<Airtime> * .5) // halve the strength of the airtime
	if (<Airtime> > 2)
		// Safety measure, in case the airtime gets out of control
		Airtime = 2
	endif
	//printf "Airtime=%f" f=<Airtime>

	if GotParam Boobscale
		// If we have this param, then we want a fixed boob wobble, as opposed to one scaled on airtime
		Breast=(<breast> * <Boobscale> )
	else
		Breast=(<breast>  * (<Airtime> + .25))
	endif

	// Safety measure, in case values get out of control
	if (<breast> > 3)
		breast=3
	endif

	SetBoneTransSpeed	x=<speed> 				y=<speed> 				z=<speed> 				bone=breast_cloth_zz
	SetBoneTransMin		x=(-1 * <breast> / 3) 	y=(-1 * <breast> / 3) 	z=(-1.5 * <breast>)  	bone=breast_cloth_zz
	SetBoneTransMax 	x=(<breast> / 3 )		y=(.5 * <breast> / 3) 	z=<breast> 	 			bone=breast_cloth_zz

	//printf "Breast bounce factor = %b" b=<breast>

endscript

/*script	WindyClothes changeinstate = 1 bone=shirt_tail_cloth_zz zconstraint=8 oldy=0 oldy2=0 oldy3=0 oldy4=0 oldy5=0

	// Initial setup for the bones and their values - only called once when the skater is created
	SetUpWindyBone left_low_trouser_params
	SetUpWindyBone right_low_trouser_params
	SetUpWindyBone left_top_trouser_params
	SetUpWindyBone right_top_trouser_params


	SetUpWindyBone left_top_sleeve_params
	SetUpWindyBone right_top_sleeve_params
	SetUpWindyBone left_low_sleeve_params
	SetUpWindyBone right_low_sleeve_params

	SetUpWindyBone mullet_cloth_params
	SetUpWindyBone hood_cloth_params

	// set the bone we want active, and set its constraints
	SetBoneTransActive bone=<bone> 1

	SetBoneTransSpeed	y=0	z=0 					bone=<bone>
	SetBoneTransMin		y=0 z=-2 					bone=<bone>
	// long story short - since the bones work of a sine curve, we're only going to go to
	// 680, and not all the way to 1024, so we need to scale the max values accordingly
//	SetBoneTransMax 	y=(2.5 * 1024 /680)	z=(7.5 * 1024 / 680)	bone=<bone>
	SetBoneTransMax 	y=0	z=7.5	bone=<bone>

	SetBoneScaleActive bone=<bone> 1
	SetBoneScaleSpeed	x=0    y=10	z=0 				bone=<bone>
	SetBoneScaleMin		x=1		y=1 	z=1 				bone=<bone>
	SetBoneScaleMax		x=1.25	y=1.5 	z=1 				bone=<bone>


	// Get the skater's Id
	Obj_GetId
	begin
		// maintain a list of the last several positions the pelvis was in, so that our
		// procedurally animated bone can lag behind
		//<oldy5>=<oldy4>
		//<oldy4>=<oldy3>
		//<oldy3>=<oldy2>
		<oldy2>=<oldy>
		<oldy>=<y>
		<objId>:Obj_GetBonePosition bone=Board_pelvis

		// printf "pelvis at %y"  y=<y>

		// Get the change in the pelvis over 2 frames from as far back as we care
		// This will generally return up to +20 if the skater is going up
		// and -20 if the skater is falling fast
		<deltay> =(<oldy2> - <oldy>)
		//printf "change in pelvis = %p " p=<deltay>

		// Normalize our -20 to 20 value into 0 to 680, for use by the SetBoneTransCurrent command
		// This is a bit of a hack - halfway up our curve is ~340

		<bonemove>=(680*((<deltay>+20)/40.0))
		//printf "bone z position on circle = %z" z=<bonemove>
		// Set the bone to this position
		if inair
			// if we just went into the air, turn on the extra cloths and start them moving
			if (<changeinstate> = 0)
				SetBoneActive left_low_trouser_params
				SetBoneActive right_low_trouser_params
				SetBoneActive left_top_trouser_params
				SetBoneActive right_top_trouser_params

				SetBoneActive left_top_sleeve_params
				SetBoneActive right_top_sleeve_params
				SetBoneActive left_low_sleeve_params
				SetBoneActive right_low_sleeve_params

				SetBoneActive mullet_cloth_params
				SetBoneActive hood_cloth_params

				changeinstate=1
			endif
			SetBoneScaleActive bone=<bone> 1
			// if we're in the air, we'll use the airtime to add some noise to the shirt translation
			GetAirtime
//			printf "Airtime=%a" a=<Airtime>
			noisefactor=randomrange(-50,50)
			noisefactor=(<noisefactor> * <airtime>)	  // scale down our noise based on how long we're in the air

		    if (<Airtime> >	.75)
				// If we've been in the air long enough, start adding in some noise
				SetBoneTransCurrent		z=(<bonemove>+<noisefactor>)	bone=<bone>
			else
				SetBoneTransCurrent		z=<bonemove>	bone=<bone>
			endif
		else
			// If we just landed on the ground, snap the clothes back to their "at rest" position
			if (<changeinstate> = 1)
				ShutDownWindyBone left_low_trouser_params
				ShutDownWindyBone right_low_trouser_params

				ShutDownWindyBone left_top_trouser_params
				ShutDownWindyBone right_top_trouser_params

				ShutDownWindyBone left_top_sleeve_params
				ShutDownWindyBone right_top_sleeve_params
				ShutDownWindyBone left_low_sleeve_params
				ShutDownWindyBone right_low_sleeve_params

				ShutDownWindyBone mullet_cloth_params
				ShutDownWindyBone hood_cloth_params

				changeinstate = 0
			endif
			SetBoneScaleActive bone=<bone> 0
			// if we're not in the air, use speed to make the shirt flutter
			//Obj_GetSpeed
			GetSpeed
			<speed> = (<speed> * .054)
			//printf "Speed = %s" s=<speed>
			// speed ranges from 0 to about 60
			if (<speed> > 20)
				groundnoise = randomrange(-50,50)
				bonemove = (200 + (<groundnoise> * (<speed> / 60)))
				//printf "Rotation value = %s" s=<bonemove>
				SetBoneTransCurrent  z=<bonemove>    bone=<bone>
			else
				SetBoneTransCurrent  z=200     bone=<bone>
			endif
		endif
		wait .03333 seconds //2 gameframes
	repeat
endscript


script SetUpWindyBone	{	bone=left_low_trouser_cloth_zz
						speed=1
						x_min=0 x_max=0			y_min=0 y_max=0			z_min=0 z_max=0
						rot_speed=0
						xrot_min=0 xrot_max=0   yrot_min=0 yrot_max=0   zrot_min=0 zrot_max=0
						}

	SetBoneTransSpeed	x=<speed> 		y=<speed>		z=<speed>  			bone=<bone>
	SetBoneTransMin		x=<x_min> 		y=<y_min>		z=<z_min> 			bone=<bone>
	SetBoneTransMax 	x=<x_max> 		y=<y_max>		z=<z_max>			bone=<bone>

	SetBoneRotSpeed 	x=<rot_speed> 	y=<rot_speed> 	z=<rot_speed> 		bone=<bone>
	SetBoneRotMin	 	x=<xrot_min> 	y=<yrot_min> 	z=<zrot_min> 		bone=<bone>
	SetBoneRotMax 		x=<xrot_max> 	y=<yrot_max> 	z=<zrot_max> 		bone=<bone>
endscript

script ShutDownWindyBone
	if GotParam x_min
		getrescaledtargetvalue 	min=<x_min> max=<x_max> target=0 sin_curve
		SetBoneTransCurrent  	x=<result>     bone=<bone>
	endif
	if GotParam y_min
		getrescaledtargetvalue 	min=<y_min> max=<y_max> target=0 sin_curve
		SetBoneTransCurrent  	y=<result>     bone=<bone>
	endif
	if GotParam z_min
		getrescaledtargetvalue 	min=<z_min> max=<z_max> target=0 sin_curve
		SetBoneTransCurrent  	z=<result>     bone=<bone>
	endif

	SetBoneTransActive bone=<bone> 0

	if GotParam xrot_min
		getrescaledtargetvalue 	min=<xrot_min> max=<xrot_max> target=0 sin_curve
		SetBoneRotCurrent  	x=<result>     bone=<bone>
	endif
	if GotParam yrot_min
		getrescaledtargetvalue 	min=<yrot_min> max=<yrot_max> target=0 sin_curve
		SetBoneRotCurrent  	y=<result>     bone=<bone>
	endif
	if GotParam zrot_min
		getrescaledtargetvalue 	min=<zrot_min> max=<zrot_max> target=0 sin_curve
		SetBoneRotCurrent  	z=<result>     bone=<bone>
	endif

	SetBoneRotActive bone=<bone> 0
endscript
*/

script SetBoneActive
	SetBoneTransActive bone=<bone> 1
	SetBoneRotActive bone=<bone> 1
endscript


script SetClothesInactive
	SetBoneTransActive bone=left_low_trouser_cloth_zz 0
	SetBoneTransActive bone=right_low_trouser_cloth_zz 0
	SetBoneTransActive bone=right_low_sleeve_cloth_zz 0
	SetBoneTransActive bone=left_low_sleeve_cloth_zz 0
	SetBoneTransActive bone=left_top_sleeve_cloth_zz 0
	SetBoneTransActive bone=right_top_sleeve_cloth_zz 0
endscript

script SetClothesActive
	SetBoneTransActive bone=left_low_trouser_cloth_zz 1
	SetBoneTransActive bone=right_low_trouser_cloth_zz 1
	SetBoneTransActive bone=right_low_sleeve_cloth_zz 1
	SetBoneTransActive bone=left_low_sleeve_cloth_zz 1
	SetBoneTransActive bone=left_top_sleeve_cloth_zz 1
	SetBoneTransActive bone=right_top_sleeve_cloth_zz 1
endscript


////////////////////////////////////////////////////////
//////////////// OLD SCRIPTS ///////////////////////////
////////////////////////////////////////////////////////

script	WindyShirt_Old
	SetClothesActive ShirtOnly
	//	SetBoneTransSpeed	x=32 	y=32 	z=randomrange(256,512) 	bone=shirt_tail_cloth_zz
	SetBoneTransMin		x=0.0 	y=0.0 	z=0.0 						bone=shirt_tail_cloth_zz
	SetBoneTransMax 	x=0.0 	y=0.0 	z=20 						bone=shirt_tail_cloth_zz
	WaitOnGround
	SetClothesInactive
endscript

script WindyPantsOn
	// Gary's test script - not really called
	SetBoneTransActive bone=left_low_trouser_cloth_zz 1
	SetBoneTransActive bone=right_low_trouser_cloth_zz 1
	SetBoneTransActive bone=shirt_tail_cloth_zz	1

	SetBoneTransSpeed	x=32 	y=0		z=32 		bone=left_low_trouser_cloth_zz
	SetBoneTransMin		x=0.0 	y=0.0	z=0.0 		bone=left_low_trouser_cloth_zz
	SetBoneTransMax 	x=0.0 	y=0.0	z=5.5 		bone=left_low_trouser_cloth_zz

	SetBoneRotSpeed 	x=32 	y=32	z=32 		bone=left_low_trouser_cloth_zz
	SetBoneRotMin	 	x=0 	y=0 	z=-128 		bone=left_low_trouser_cloth_zz
	SetBoneRotMax 		x=0 	y=0 	z=128 		bone=left_low_trouser_cloth_zz

	SetBoneTransSpeed	x=32 	y=32 	z=32 		bone=right_low_trouser_cloth_zz
	SetBoneTransMin		x=0.0 	y=0.0 	z=0.0 		bone=right_low_trouser_cloth_zz
	SetBoneTransMax 	x=0.0 	y=0.0 	z=5.5 		bone=right_low_trouser_cloth_zz

	SetBoneRotSpeed 	x=32 	y=32 	z=32 		bone=right_low_trouser_cloth_zz
	SetBoneRotMin	 	x=0 	y=0 	z=-128 		bone=right_low_trouser_cloth_zz
	SetBoneRotMax 		x=0 	y=0 	z=128 		bone=right_low_trouser_cloth_zz

	SetBoneTransSpeed	x=32 	y=32 	z=32 		bone=shirt_tail_cloth_zz
	SetBoneTransMin		x=0.0 	y=0.0 	z=0.0 		bone=shirt_tail_cloth_zz
	SetBoneTransMax 	x=0.0 	y=0.0 	z=5.5 		bone=shirt_tail_cloth_zz

	SetBoneRotSpeed 	x=32 	y=32 	z=32 		bone=shirt_tail_cloth_zz
	SetBoneRotMin	 	x=0 	y=0 	z=-128 		bone=shirt_tail_cloth_zz
	SetBoneRotMax 		x=0 	y=0 	z=128 		bone=shirt_tail_cloth_zz

	//	SetBoneTransCurrent	x=2048 	y=0		z=1024 		bone=left_low_trouser_cloth_zz
	//	SetBoneRotCurrent	x=2048 	y=0		z=3072 		bone=left_low_trouser_cloth_zz

endscript



