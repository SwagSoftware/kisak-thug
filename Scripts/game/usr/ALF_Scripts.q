script ALF_Placeholder
// you can remove this script when you start editing this file.  It is here for testing only
endscript

/* script ALF_PedTemp
begin
Obj_CycleAnim Anim=Idle
repeat
endscript */

script ALF_Ped_Generic
Obj_ClearExceptions
//****
Obj_SetException ex = SkaterInRadius scr = ALF_Ped_BailWhenSkaterClose
Obj_SetInnerRadius 5
//****
wait random(@5 frames @10 frames @15 frames)
begin
Obj_CycleAnim anim = Ped_M_Idle1 numcycles = random(@2 @4 @7 @9)
Obj_CycleAnim anim = Ped_M_Idle1toIdle2
Obj_CycleAnim anim = Ped_M_Idle2 numcycles = random(@1 @2 @3)
Obj_CycleAnim anim = Ped_M_Idle2toIdle3
Obj_CycleAnim anim = Ped_M_Idle3 numcycles = random(@1 @2 @3)
Obj_CycleAnim anim = Ped_M_Idle3toIdle1	
repeat
endscript

//**************

script ALF_Ped_BailWhenSkaterClose
Obj_ClearExceptions

//sound bail04 is not loaded anymore
//playsound bail04
//commented out by david rowe 04/29/03
	 
//Obj_CycleAnim anim = Ped_M_HitBySkater
//Obj_CycleAnim anim = Ped_M_FalldownA
random (
   @Obj_CycleAnim anim = Ped_M_FalldownA
   Obj_PlayAnim anim = Ped_M_LayIdleA cycle
   SetTags Bail = A
   @Obj_CycleAnim anim = Ped_M_FalldownB
   Obj_PlayAnim anim = Ped_M_LayIdleB cycle
   SetTags Bail = B
   @Obj_CycleAnim anim = Ped_M_FalldownC
   Obj_PlayAnim anim = Ped_M_LayIdleC cycle
   SetTags Bail = C
   @Obj_CycleAnim anim = Ped_M_FalldownD
   Obj_PlayAnim anim = Ped_M_LayIdleD cycle
   SetTags Bail = D
   @Obj_CycleAnim anim = Ped_M_FalldownE
   Obj_PlayAnim anim = Ped_M_LayIdleE cycle
   SetTags Bail = E )
Obj_SetException ex = SkaterOutOfRadius scr = ALF_Ped_GetUpFromBail
Obj_SetOuterRadius 10
endscript

script ALF_Ped_GetUpFromBail
Obj_ClearExceptions
//Obj_CycleAnim anim = Ped_M_GetUpA
GetTags
Obj_SetAnimCycleMode Off
Obj_WaitAnimFinished
Switch <Bail>
   case A
   Obj_CycleAnim anim = Ped_M_GetUpA
   case B
   Obj_CycleAnim anim = Ped_M_GetUpB
   case C
   Obj_CycleAnim anim = Ped_M_GetUpC
   case D
   Obj_CycleAnim anim = Ped_M_GetUpD
   case E
   Obj_CycleAnim anim = Ped_M_GetUpE
   default
   EndSwitch
goto ALF_Ped_Generic
endscript


