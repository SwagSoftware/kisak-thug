// GJ:  These functions were used in THPS3 for the peds'
// reactions to secret characters.  Because we've got an
// entirely new set of secret characters this time, these
// functions will need to be replaced completely.  I am
// including these in here, just as reference.

/*

// demoness state
PED_SHRUNK		  =5

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&															  &&
//&&															  &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_Fear_The_Cops
	Obj_PlayAnim anim=OfficerDick_Init
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=OfficerDick_Idle
	Obj_WaitAnimFinished
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&															  &&
//&&															  &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_Fight_Wolverine
	Obj_PlayAnim anim=Wolverine_Init
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=Wolverine_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=Wolverine_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=Wolverine_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=Wolverine_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=Wolverine_Idle
	Obj_WaitAnimFinished
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&															  &&
//&&															  &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_Dance_For_Private
	Obj_PlayAnim anim=PrivateCarrera_Init
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=PrivateCarrera_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=PrivateCarrera_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=PrivateCarrera_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=PrivateCarrera_Idle
	Obj_WaitAnimFinished
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&															  &&
//&&															  &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_Float_ForDarth
	Obj_PlayAnim anim=DarthMaul_Init
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=DarthMaul_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=DarthMaul_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=DarthMaul_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=DarthMaul_Out
	Obj_WaitAnimFinished
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&															  &&
//&&															  &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_Scale_From_Demoness
	Obj_PlayAnim anim=Demoness_Init
	if Obj_FlagSet PED_SHRUNK

	else
		Obj_SetFlag PED_SHRUNK
		Obj_ApplyScaling x=1 y=1 z=1
		wait 2 frames
		Obj_ApplyScaling x=.9 y=.9 z=.9
		wait 2 frames
		Obj_ApplyScaling x=.8 y=.8 z=.8
		wait 2 frames
		Obj_ApplyScaling x=.7 y=.7 z=.7
		wait 2 frames
		Obj_ApplyScaling x=.6 y=.6 z=.6
		wait 2 frames
		Obj_ApplyScaling x=.5 y=.5 z=.5
		wait 2 frames
		Obj_ApplyScaling x=.4 y=.4 z=.4
		wait 2 frames
		Obj_ApplyScaling x=.3 y=.3 z=.3
		wait 2 frames
		Obj_ApplyScaling x=.2 y=.2 z=.2
	Endif
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=Demoness_Idle
	Obj_WaitAnimFinished
	Obj_PlayAnim anim=Demoness_Idle
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&															  &&
//&&															  &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

script Ped_BurnForDemoness
	Obj_ClearExceptions
	Obj_PlayAnim Anim=<Idle> Cycle
	Obj_StopAlongPath
	Obj_ApplyScaling x=1 y=1 z=1
	wait 2 frames
	Obj_ApplyScaling x=.9 y=.9 z=.9
	wait 2 frames
	Obj_ApplyScaling x=.8 y=.8 z=.8
	wait 2 frames
	Obj_ApplyScaling x=.7 y=.7 z=.7
	wait 2 frames
	Obj_ApplyScaling x=.6 y=.6 z=.6
	wait 2 frames
	Obj_ApplyScaling x=.5 y=.5 z=.5
	wait 2 frames
	Obj_ApplyScaling x=.4 y=.4 z=.4
	wait 2 frames
	Obj_ApplyScaling x=.3 y=.3 z=.3
	wait 2 frames
	Obj_ApplyScaling x=.2 y=.2 z=.2
endscript

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
//&&															  &&
//&&															  &&
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

*/
