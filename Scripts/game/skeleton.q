// This file lists all the skeletons that will be used in the game.
// A skeleton defines the bone names and the bone hierarchy that is
// to be used by a model.  There should be no duplicate skeletons in
// this list.  That is, the male and female ped skeletons should
// both use the "human" skeleton because they have the same bone names
// and hierarchy, even though the positions of the bones themselves
// are different.  (This may change later, as the skeleton may
// end up containing "the neutral pose".)

// to add a new animal, add the animation script name to 
// "allanims.qn", and the skeleton name to "skeletonload_all"

script skeletonload_all
	// Manually add all the skeletons that we will be supporting here
	// Perhaps this script can be auto-generated somehow based on
	// the contents of data/skeletons?  (it might screw up our dependencies,
	// forcing qb.pre to be rebuilt every time;  maybe we could do
	// something similar to the TrickLister?)

    LoadSkeleton	name="skeletons/anl_horse.ske"		horse             animName=animload_anl_horse
	
    LoadSkeleton	name="skeletons/human.ske"		human           animName=animload_human
    LoadSkeleton	name="skeletons/MonsterPed.ske"		monsterped           animName=animload_monsterped
	LoadSkeleton	name="skeletons/eric_head.ske"		eric_head       animName=animload_eric_head
    LoadSkeleton	name="skeletons/Head_Peralta.ske"       Head_Peralta    animName=animload_Head_Peralta 
    LoadSkeleton	name="skeletons/Head_Trooper.ske"       Head_Trooper    animName=animload_Head_Trooper 
    LoadSkeleton	name="skeletons/muska_head.ske"		muska_head      animName=animload_Muska_head
    LoadSkeleton	name="skeletons/Lasek_Head.ske"		Lasek_Head      animName=animload_Lasek_head
    LoadSkeleton	name="skeletons/Magera_Head.ske"	Magera_Head     animName=animload_Magera_head
    LoadSkeleton	name="skeletons/Mullen_Head.ske"	Mullen_Head     animName=animload_Mullen_head
    LoadSkeleton	name="skeletons/Rowley_Head.ske"	Rowley_Head     animName=animload_Rowley_head
    LoadSkeleton	name="skeletons/Vallely_Head.ske"	Vallely_Head    animName=animload_Vallely_Head
    LoadSkeleton	name="skeletons/manager_head.ske"	manager_head    animName=animload_Manager_head
	LoadSkeleton	name="skeletons/Head_cas_male01.ske"	Head_cas_male01 
	LoadSkeleton	name="skeletons/Hawk_Head.ske"          Hawk_Head 
	LoadSkeleton	name="skeletons/THPS5_human.ske"	THPS5_human     animName=animload_THPS5_human
	LoadSkeleton	name="skeletons/Ped_Female.ske"	        Ped_Female      animName=animload_Ped_Female
	LoadSkeleton	name="skeletons/anl_chicken.ske"	chicken         animName=animload_anl_chicken
	LoadSkeleton	name="skeletons/anl_cockatoo.ske"	cockatoo        animName=animload_anl_cockatoo
	LoadSkeleton	name="skeletons/anl_cow.ske"		cow             animName=animload_anl_cow
	LoadSkeleton	name="skeletons/anl_dog.ske"		dog             animName=animload_anl_dog
	LoadSkeleton	name="skeletons/anl_elephant.ske"	elephant        animName=animload_anl_elephant
	LoadSkeleton	name="skeletons/anl_goat.ske"		goat            animName=animload_anl_goat
	LoadSkeleton	name="skeletons/anl_gator.ske"		gator           animName=animload_anl_gator
	LoadSkeleton	name="skeletons/anl_giraffe.ske"	giraffe         animName=animload_anl_giraffe
	LoadSkeleton	name="skeletons/anl_gorilla.ske"	gorilla         animName=animload_anl_gorilla
	LoadSkeleton	name="skeletons/anl_hippo.ske"		hippo           animName=animload_anl_hippo
	LoadSkeleton	name="skeletons/anl_lion.ske"		lion            animName=animload_anl_lion
	LoadSkeleton	name="skeletons/anl_meerkat.ske"	meerkat         animName=animload_anl_meerkat
	LoadSkeleton	name="skeletons/anl_monkey.ske"		monkey          animName=animload_anl_monkey
	LoadSkeleton	name="skeletons/anl_penguin.ske"	penguin         animName=animload_anl_penguin
	LoadSkeleton	name="skeletons/anl_pig.ske"		pig             animName=animload_anl_pig
	LoadSkeleton	name="skeletons/anl_pigeon.ske"		pigeon          animName=animload_anl_pigeon
	LoadSkeleton	name="skeletons/anl_rat.ske"		rat             animName=animload_anl_rat
	LoadSkeleton	name="skeletons/anl_rhino.ske"		rhino           animName=animload_anl_rhino
	LoadSkeleton	name="skeletons/anl_seagull.ske"   	seagull         animName=animload_anl_seagull
	LoadSkeleton	name="skeletons/anl_seal.ske"		seal	        animName=animload_anl_seal
	LoadSkeleton	name="skeletons/anl_shark.ske"		shark           animName=animload_anl_shark
	LoadSkeleton	name="skeletons/ped_f.ske"		ped_f           animName=animload_ped_f
	LoadSkeleton	name="skeletons/bmx.ske"		bmx             animName=animload_bmx  
	LoadSkeleton	name="skeletons/car.ske"		car           
	LoadSkeleton	name="skeletons/car_6.ske"		car_6           
	LoadSkeleton	name="skeletons/si_pizza.ske"		pizzabox        animName=animload_pizzabox
	LoadSkeleton	name="skeletons/si_generic.ske"		si_generic      animName=animload_si_generic
	LoadSkeleton	name="skeletons/si_gun.ske"		gun             animName=animload_si_gun
	LoadSkeleton	name="skeletons/si_Flag.ske"		flag            animName=animload_si_flag
	LoadSkeleton	name="skeletons/si_bustedboard.ske"	bustedboard     animName=animload_si_bustedboard
	LoadSkeleton	name="skeletons/si_grapplehook.ske"	grapplehook     animName=animload_si_grapplehook
	LoadSkeleton	name="skeletons/si_extraboard.ske"	si_extraboard      animName=animload_si_extraboard
	LoadSkeleton	name="skeletons/si_tongue.ske"	si_tongue      animName=animload_si_tongue
	LoadSkeleton	name="skeletons/si_boombox.ske"	si_boombox      animName=animload_si_boombox
	LoadSkeleton	name="skeletons/si_skull.ske"	si_skull      animName=animload_si_skull
        LoadSkeleton	name="skeletons/si_ferret.ske"	        ferret          animName=animload_si_ferret
        LoadSkeleton	name="skeletons/si_pistol.ske"	        pistol          animName=animload_si_pistol
        LoadSkeleton	name="skeletons/motorx.ske"	    	motoxbike       animName=animload_motorX
        LoadSkeleton	name="skeletons/test_facial.ske"	test_facial     animName=animload_test_facial
        LoadSkeleton	name="skeletons/test_skater_m.ske"	test_skater_m   animName=animload_test_skater_m
        LoadSkeleton	name="skeletons/treetest.ske"	        treetest        animName=animload_treetest
        LoadSkeleton	name="skeletons/treetest2.ske"	        treetest2       animName=animload_treetest2
        LoadSkeleton	name="skeletons/treetest3.ske"	        treetest3       

endscript


DoNotAssertOnMissingAnims = 1
skater_asset_info = {
    skater_skeleton = THPS5_human
    skater_anims = animload_THPS5_human
}


BoneSkipLODInfo=
{
	THPS5_human=
    [
        {
			// LOD Level0 active within 0 feet of camera (i.e. never active).
			// LOD Level0 exists so the skater can be set to never skip any bones.
            LODDistance=0.0

			// No bones skipped in Level0.
        }

        {
			// LOD Level1 active within 30 feet of camera (i.e. never active).
			// LOD Level1 exists so the pedestrians never have to process the clothing bones.
            LODDistance=30.0

			// These bones will be skipped for Level1 and all levels beyond (Level2, Level3 etc.)
            SkipBones=
            [
				Cloth_Cuff_L
				Cloth_Cuff_R
				// Cloth_Hat (no longer considered a skip bone, as it's used for head scaling)
				Cloth_Breast
				Cloth_Shirt_L
				Cloth_Shirt_C
				Cloth_Shirt_R
				Cloth_Trouser_L
				Cloth_Trouser_R
			]
        }

        {
			// LOD Level2 active within 50 feet of camera.
            LODDistance=50.0

			// These bones will be skipped for Level2 and all levels beyond.
            SkipBones=
            [
				Bone_PonyTail_1
				Bone_PonyTail_2
				Bone_Thumb_L
				Bone_Thumb_R
				Bone_Forefinger_Base_L
				Bone_Forefinger_Base_R
				Bone_Forefinger_Tip_L
				Bone_Forefinger_Tip_R
				Bone_Fingers_Tip_L
				Bone_Fingers_Tip_R
				Bone_Brow
			]
        }

        {
			// LOD Level3 active within 150 feet of camera.
            LODDistance=150.0

			// These bones will be skipped for Level3 and all levels beyond.
            SkipBones=
            [
				Bone_Fingers_Base_L
				Bone_Fingers_Base_R
				Bone_Toe_L
				Bone_Toe_R
				Bone_Jaw
			]
        }

        {
			// LOD Level4 active within 1000 feet of camera.
            LODDistance=1000.0

			// These bones will be skipped for Level4 and all levels beyond.
            SkipBones=
            [
				Bone_Palm_L
				Bone_Palm_R
				Bone_Wrist_L
				Bone_Wrist_R 
				Bone_Ankle_L
				Bone_Ankle_R
			]
        }
        
		// Tried these and they are too bovious
		// Bone_Head
		// Bone_Neck
		// Bone_Collar_L
		// Bone_Collar_R 
		// Bone_Bicep_L 
		// Bone_Bicep_R
		// Bone_Forearm_L
		// Bone_Forearm_R
		// Bone_Pelvis 
		// Bone_Stomach_Lower
		// Bone_Stomach_Upper
    ]
    
    // Etc ...
}
