// GJ:  This file is for any low-level ped functions
// and data structures (utility scripts, CPed constructor
// data, etc.)  There should DEFINITELY be no high-level
// ped logic here.


//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script gameobj_add_components

	if GotParam animName
		CreateComponentFromStructure component=animation <...>
	endif

	if GotParam skeletonName
		CreateComponentFromStructure component=skeleton <...> skeleton=<skeletonName>
	endif

	<is_level_obj> = 0

	// level objects and bouncy objects create
	// their models using the sector name,
	// not the "model" name.
	if GotParam class
		if ChecksumEquals a=<class> b=LevelObject
			<is_level_obj> = 1
		endif
	endif

	if ( <is_level_obj> = 1 )
		CreateComponentFromStructure component=model <...>
	else
		// otherwise, it's a regular object
		if GotParam model
			if not StringEquals a=<model> b="none"
				CreateComponentFromStructure component=model <...>
			endif
		endif
	endif

	// GJ:  collision component should be added after
	// the model component, because we want to use
	// the same m_pos/m_matrix that we used for
	// displaying the model
	CreateComponentFromStructure component=collision <...>

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_add_components

	CreateComponentFromStructure component=avoid

	if NOT GotParam NoPedLogic
		CreateComponentFromStructure component=pedlogic	<...>
	endif

	CreateComponentFromStructure component=SkaterLoopingSound <...> volume_mult=0.2
	CreateComponentFromStructure component=SkaterSound <...> volume_mult=0.2

	if ( (InNetGame) || (LevelIs load_sk5ed) || (LevelIs load_sk5ed_gameplay) )
		GetAnimEventTableName animName=thps5_human
		CreateComponentFromStructure {
			component=animation
			<...>
			animName=animload_thps5_human
			animEventTableName=<animEventTableName>
		}
		CreateComponentFromStructure component=skeleton <...> skeletonName=thps5_human
	else
		if GotParam animName
			if not GotParam animEventTableName
				// get anim event table name based on the skeleton used
				// (by default it will use the PedAnimEventTable)
				GetAnimEventTableName animName=<animName>
			endif

			// to fix problems with the christ pose appearing
			// on the "view goals" menu, the following replaces
			// the ped's default animation with either the
			// male or female idle.
			if not GotParam defaultAnimName
				if ChecksumEquals a=<skeletonName> b=thps5_human
					// WStandIdle1 should always be loaded
					// in story mode, in parks, and in net games
					<defaultAnimName> = WStandIdle1
				endif
				if not ( have_loaded_net )
					if ChecksumEquals a=<skeletonName> b=Ped_Female
						// Ped_F_Idle1 might not be loaded, in parks or net games
						<defaultAnimName> = Ped_F_Idle1
					endif
				endif
			endif

			CreateComponentFromStructure component=animation animEventTableName=<animEventTableName> <...>
		endif

		if GotParam skeletonName
			CreateComponentFromStructure component=skeleton <...> skeleton=<skeletonName>
		endif
	endif

	// always create a model component
	CreateComponentFromStructure component=model

	// now that the model has been created, we can create the shadow
	if not GotParam ShadowOff
		CreateComponentFromStructure component=shadow <...> ShadowType=simple
	endif

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_init_model

	// handle some special case ped-loading:

	// in net games, we need to replace all the peds with the judge model
	// (because there's not enough memory to load up all the different ped models)
	if InNetGame
		Obj_InitModel model="Peds/Ped_Judge/Ped_Judge.skin" use_asset_manager=1
		return
	endif

	if ((LevelIs load_sk5ed) || (LevelIs load_sk5ed_gameplay))
		ChooseRandomCreatedGoalPedModel
		return
	endif

	// in career mode, if you're playing
	// with the same character that's supposed
	// to give you your goal, then replace
	// him with some generic ped...
	;	if IsCareerMode
	;        if GotParam pro_name
	;        	GetCurrentSkaterProfileIndex
	;        	GetSkaterProfileInfo player=<currentSkaterProfileIndex>
	;            if ChecksumEquals a=<pro_name> b=<name>
	;                Obj_InitModel model=generic_pro_name use_asset_manager=1    // global
	;                return
	;            endif
	;        endif
	;    endif

	// NOTE:  normally, we'd need to give it a texDictOffset so
	// that it doesn't conflict with the secret ped skaters...
	// however, since all the peds are preloaded in C,
	// the texDictOffset is ignored anyway...
	//	<texDictOffset> = 8

	// general cases (either profile or explicit model)
	if GotParam profile
		Obj_InitModelFromProfile /* texDictOffset=<texDictOffset> */ struct=<profile> use_asset_manager=1 buildscript=create_ped_model_from_appearance
	else
		if not GotParam model
			script_assert "no model name!"
		endif
		Obj_InitModel model=<model> use_asset_manager=1
	endif

	Obj_GetID
	RunScriptOnObject id=<objID> set_ped_anim_handlers

endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script ped_disable_bones
	Obj_SetBoneActive bone=Cloth_Cuff_L 	active=0
	Obj_SetBoneActive bone=Cloth_Cuff_R 	active=0
	Obj_SetBoneActive bone=Cloth_Hat		active=0
	Obj_SetBoneActive bone=Cloth_Shirt_L 	active=0
	Obj_SetBoneActive bone=Cloth_Shirt_C	active=0
	Obj_SetBoneActive bone=Cloth_Shirt_R 	active=0
	Obj_SetBoneActive bone=Cloth_Trouser_L	active=0
	Obj_SetBoneActive bone=Cloth_Trouser_R	active=0
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_Printf
	if IsTrue ped_debug
		printf <...>
	endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_PrintStruct
	if IsTrue ped_debug
		PrintStruct <...>
	endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_Assert
	// TODO:  Eventually, make this into a c-func,
	// and print out the script info/call stack

	if IsTrue ped_debug
		printf "SCRIPT ASSERT!"
		printf <...>
		begin
			; infinite loop
		repeat
	endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_PrintTags
	if IsTrue ped_debug
		GetTags
		PrintStruct <...>
	endif
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

/*

// GJ:  Some unused ped functions here...
// I'm not sure what they're used for...

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_Suicide
	Die
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_HeightCheck
	//LaunchConsoleMessage "Sticking to Ground"
	Obj_StickToGround On
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_NoHeightCheck
	//LaunchConsoleMessage "Not Sticking to Ground"
	Obj_StickToGround Off
	Obj_SetConstantHeight
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&										 		   &&
//&&												   &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

*/
