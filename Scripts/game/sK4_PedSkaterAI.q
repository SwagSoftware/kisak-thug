Script Play_BMX_Anim
Random (
@ // BS Stall
TRG_BMX_Rider:Obj_PlayAnim anim=BS_Stall
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_BS_Stall
@ // Backflip
TRG_BMX_Rider:Obj_PlayAnim anim=Backflip
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_Backflip
@ // _180LateTurn
TRG_BMX_Rider:Obj_PlayAnim anim=_180LateTurn
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_180LateTurn
@ // OneFooter
TRG_BMX_Rider:Obj_PlayAnim anim=OneFooter
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_OneFooter
@ // _540
TRG_BMX_Rider:Obj_PlayAnim anim=_540
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_540
)
/**************************************************
//	rem area  	 								  
Random (
@ // BS Stall
TRG_BMX_Rider:Obj_PlayAnim anim=BS_Stall
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_BS_Stall
@ // Backflip
TRG_BMX_Rider:Obj_PlayAnim anim=Backflip
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_Backflip
@ // _180LateTurn
TRG_BMX_Rider:Obj_PlayAnim anim=_180LateTurn
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_180LateTurn
@ // OneFooter
TRG_BMX_Rider:Obj_PlayAnim anim=OneFooter
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_OneFooter
@ // _540
TRG_BMX_Rider:Obj_PlayAnim anim=_540
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_540
)

 // BS Stall
TRG_BMX_Rider:Obj_PlayAnim anim=_540
TRG_BMX_Bike:Obj_PlayAnim anim=BMX_540


**************************************************/
Endscript

Script AI_BMX_Rider
begin
Play_BMX_Anim
Obj_WaitAnimFinished
TRG_BMX_Rider: Obj_Rotate absolute=(0, -90, 0)
TRG_BMX_Bike: Obj_Rotate absolute=(0, -90, 0)
Play_BMX_Anim
Obj_WaitAnimFinished
TRG_BMX_Rider: Obj_Rotate absolute=(0, 90, 0)
TRG_BMX_Bike: Obj_Rotate absolute=(0, 90, 0)
repeat
Endscript
Script AI_BMX_Bike
Endscript


Script Skateshop_PedProInitialSetup
/*
printf " bogus initial setup for location check for dropin"
begin
Obj_MoveToNode name=<Path>
Obj_Flip
Obj_PlayAnim Anim=StandIdleFromPedIdle
Obj_WaitAnimFinished
Obj_MoveToNode name=<dropin> 
Obj_Flip
Obj_PlayAnim Anim=DropIn
Obj_Rotate relative=(90,0,0)//X angle=90 speed=1000000
Obj_WaitAnimFinished
Obj_Rotate relative=(-90,0,0)//X angle=90 speed=1000000
Repeat
*/
//printf "setting up ped pro"
GetNodeName
Obj_SetPathVelocity 55 fps
Obj_SetPathAcceleration 55 fpsps
Obj_PathHeading Off
Obj_SpawnScript  Skateshop_PedProDistanceCheck
Obj_MoveToNode name=<nodename> orient
Endscript

Script Skateshop_PedProStartRun
//If Flipped
//	Flip
//endif	
//printf "starting run"
//Obj_PlayAnim Anim=StandIdleFromPedIdle
//Obj_WaitAnimFinished
//Obj_Flip
if NOT LevelIs load_skateshop
	Obj_PlayAnim Anim=StandIdleFromPedIdle
	Obj_WaitAnimFinished
	Obj_MoveToNode name=<Path> time=.81 second
	Obj_PlayAnim Anim=DropIn_Ped
	Obj_SetPathAcceleration 43 fpsps
	Obj_FollowPath name=<dropin>
	Skateshop_PedProPlayLandSound
	Obj_Rotate relative=(90,0,0)//X angle=90 speed=1000000
else	
	Obj_PlayAnim Anim=StandIdleFromPedIdle
	Obj_WaitAnimFinished
	Obj_PlayAnim Anim=DropInApproach
	Obj_WaitAnimFinished
	Skateshop_PedProPlayLandSound
	Obj_PlayAnim Anim=<DropInAnim>
	Obj_WaitAnimFinished
	Obj_SetPathAcceleration 43000 fpsps
	Obj_MoveToNode name=<start> //orient
	Obj_Flip
	Obj_FollowPath name=<start>
endif
Obj_SpawnScript Skateshop_PedProIncreaseAcceleration
Obj_WaitAnimFinished
wait 1 frame
Obj_PlayAnim Anim=Crouchidle Cycle
Obj_WaitMove
Endscript

Script Skateshop_PedProIncreaseAcceleration
wait 1 second
Obj_SetPathAcceleration 555 fpsps
Endscript

Script Skateshop_PedProCrossBottom 
Skateshop_PedProNormalBottom Path=<Path>
//Random (@Skateshop_PedProNormalBottom @Skateshop_PedProNormalBottom @Skateshop_PedProNormalBottom @Skateshop_PedProNormalBottom @Skateshop_PedProManualBottom) Path=<Path>
Endscript
Script Skateshop_PedProNormalBottom
Obj_PlayAnim Anim=Random (@CrouchedLand @SketchyCrouchLand speed=1.4)
Obj_FollowPath name=<Path>
Obj_WaitAnimFinished
Obj_PlayAnim Anim=Crouchidle Cycle
Obj_WaitMove
Endscript
Script Skateshop_PedProManualBottom
Obj_PlayAnim Anim=RevertFS speed=1.4
Obj_FollowPath name=<Path>
Obj_Playsound RevertWood pitch=random (@90 @100 @110)
Obj_WaitAnimFinished
Obj_PlayAnim Anim=Manual
Obj_WaitAnimFinished
Obj_PlayAnim Anim=Manual_Range from=40 to=1 
Obj_WaitMove
Endscript

Script Skateshop_PedProTransfer
Obj_MoveToNode name=<Path4> speed=10
Skateshop_PedProDoJumpTrick
Skateshop_PedProNormalBottom Path=<Path4>
Skateshop_PedProDoJumpTrick
Skateshop_PedProNormalBottom Path=<Path3>
Obj_MoveToNode name=<Path2> speed=10
Skateshop_PedProDoJumpTrick
Endscript

Script Skateshop_PedProGrind
Obj_Playsound GrindMetalOn
Obj_MoveToNode name=<Path4> speed=10
Obj_PlayAnim Anim=Init_FiftyFifty from=20 to=end
Skateshop_PedProRotateDown
Obj_WaitRotate
//Obj_Playsound GrindMetal
Obj_RotY angle=90 speed=800
Obj_WaitMove
Obj_StopSound
Obj_Playsound GrindMetalOff
Obj_RotY angle=90 speed=800
Skateshop_PedProRotateDown
Skateshop_PedProManualBottom Path=<Path4>
Skateshop_PedProDoJumpTrick
Skateshop_PedProManualBottom Path=<Path3>
Obj_Playsound GrindMetalOn
Obj_MoveToNode name=<Path2> speed=10
Obj_PlayAnim Anim=Init_FiftyFifty from=20 to=end
Skateshop_PedProRotateDown
Obj_WaitRotate
//Obj_Playsound GrindMetal
Obj_RotY angle=-90 speed=800
Obj_WaitMove
Obj_StopSound
Obj_Playsound GrindMetalOff
Obj_RotY angle=-90 speed=800
Skateshop_PedProRotateDown
Endscript

Script Skateshop_PedProDoTrick
Obj_ShadowOff
Random (@ @ @ @ @ @Skateshop_PedPlayProCongrats)
Random
(
@Skateshop_PedProDoJumpTrick
@Skateshop_PedProDoJumpTrick
@Skateshop_PedProDoJumpTrick
@Skateshop_PedProDoLipTrick path=<Path>
)
Skateshop_PedProPlayLandSound
//Obj_Playsound random (@landWood @landWood2 @landWood3)   pitch=random (@90 @100 @110)
Obj_ShadowOn
Endscript

Script Skateshop_PedProPlayLandSound
if LevelIs load_skateshop
	if NOT ScreenElementExists id=kill_skating_sounds_anchor 
		Obj_Playsound random (@landWood @landWood2 @landWood3)  pitch=random (@90 @100 @110)
	endif
endif
Endscript
Script Skateshop_PedProDoLipTrick
Random (
@ // Mute_Invert
Obj_PlayAnim Anim=MuteInvert_Init
Obj_WaitAnimFinished
Obj_PlayAnim Anim=MuteInvert_Range from=20 to=end
Obj_WaitAnimFinished
Obj_PlayAnim Anim=MuteInvert_Out
@  // OneFootInvert
Obj_PlayAnim Anim=OneFootInvert_Init
Obj_WaitAnimFinished
Obj_PlayAnim Anim=OneFootInvert_Range from=20 to=end
Obj_WaitAnimFinished
Obj_PlayAnim Anim=OneFootInvert_Out
@  // BSFootplant
Obj_PlayAnim Anim=BSFootplant_Init
Obj_WaitAnimFinished
Obj_PlayAnim Anim=BSFootplant_Range from=20 to=end
Obj_WaitAnimFinished
Obj_PlayAnim Anim=BSFootplant_Out
@  // NoseTailStall
Obj_PlayAnim Anim=NoseTailStall_Init
if NOT ScreenElementExists id=kill_skating_sounds_anchor 
	Obj_Playsound copinghit3_11 pitch=random (@90 @100 @110)
endif
Obj_WaitAnimFinished
Obj_PlayAnim Anim=NoseTailStall_Range from=20 to=end
Obj_WaitAnimFinished
Obj_PlayAnim Anim=NoseTailStall_Out
@  // FS180Noseblunt
Obj_PlayAnim Anim=FS180Noseblunt_Init
Obj_WaitAnimFinished
if NOT ScreenElementExists id=kill_skating_sounds_anchor 
	Obj_Playsound copinghit3_11 pitch=random (@90 @100 @110)
endif
Obj_PlayAnim Anim=FS180Noseblunt_Range from=20 to=end
Obj_WaitAnimFinished
Obj_PlayAnim Anim=FS180Noseblunt_Out
)
wait 25 frames
Obj_SetPathAcceleration 55 fpsps
Obj_FollowPath name=<Path>
Obj_WaitAnimFinished
Obj_SetPathAcceleration 555 fpsps
Obj_Flip
Obj_Rotate relative=(0,180,0) //Y angle=180 speed=20000
Endscript

Script Skateshop_PedProDoJumpTrick
Random (
@Obj_RotY angle=180 speed=180
@Obj_RotY angle=180 speed=180
@Obj_RotY angle=180 speed=180
@Obj_RotY angle=180 speed=180
@Obj_RotY angle=180 speed=180
@Obj_RotY angle=180 speed=180
@Obj_RotY angle=540 speed=400
@Obj_RotY angle=900 speed=700
@Obj_RotY angle=-180 speed=180
@Obj_RotY angle=-180 speed=180
@Obj_RotY angle=-180 speed=180
@Obj_RotY angle=-180 speed=180
@Obj_RotY angle=-180 speed=180
@Obj_RotY angle=-180 speed=180
@Obj_RotY angle=-540 speed=400
@Obj_RotY angle=-900 speed=700
)
if LevelIs load_skateshop
	if NOT ScreenElementExists id=kill_skating_sounds_anchor 
		Obj_Playsound random (@OllieWood @OllieWood2 @OllieWood3)   pitch=random (@90 @100 @110)
	endif
endif
Obj_PlayAnim Anim=Random (@FastPlant @NoComply @BeanPlant) speed=1.5
Obj_Jump gravity=-400 speed=350
Obj_WaitAnimFinished
Random (
@ // quick flips
begin
Obj_PlayAnim Anim=Random (@Impossible @HeelFlip @KickFlip @HardFlip @VarialKickFlip @VarialHeelFlip) speed=1.5
Obj_WaitAnimFinished
repeat 3
@ // NoseGrab
Obj_PlayAnim Anim=NoseGrab
Obj_WaitAnimFinished
Obj_PlayAnim Anim=NoseGrab backwards
@ // Method
Obj_PlayAnim Anim=Method
Obj_WaitAnimFinished
Obj_PlayAnim Anim=Method backwards
@ // Benihana
Obj_PlayAnim Anim=Benihana
Obj_WaitAnimFinished
Obj_PlayAnim Anim=Benihana backwards
@ // RocketAir
Obj_PlayAnim Anim=RocketAir
Obj_WaitAnimFinished
Obj_PlayAnim Anim=RocketAir backwards
@ // JapanAir
Obj_PlayAnim Anim=JapanAir
Obj_WaitAnimFinished
Obj_PlayAnim Anim=JapanAir backwards
@ // Stiffy
Obj_PlayAnim Anim=Stiffy
Obj_WaitAnimFinished
Obj_PlayAnim Anim=Stiffy backwards
@ // CrossBone
Obj_PlayAnim Anim=CrossBone
Obj_WaitAnimFinished
Obj_PlayAnim Anim=CrossBone backwards
@ // IndyDelMar
Obj_PlayAnim Anim=IndyDelMar
Obj_WaitAnimFinished
Obj_PlayAnim Anim=IndyDelMar backwards
@ // CannonBall
Obj_PlayAnim Anim=CannonBall
Obj_WaitAnimFinished
Obj_PlayAnim Anim=CannonBall backwards
@ // CrookedCop
Obj_PlayAnim Anim=CrookedCop
Obj_WaitAnimFinished
Obj_PlayAnim Anim=CrookedCop backwards
@ // OneFootJapan
Obj_PlayAnim Anim=OneFootJapan
Obj_WaitAnimFinished
Obj_PlayAnim Anim=OneFootJapan backwards
)
Obj_WaitJumpFinished
Endscript

Script Skateshop_PedProEndRun
//printf "ending run"
GetNodeName
Obj_PlayAnim Anim=ExitHalfPipe
Obj_Rotate relative=(90,0,0)
wait 15 frames
Obj_MoveToNode name=<NodeName> speed=10
Obj_WaitAnimFinished
Obj_Flip
Obj_LookAtNode name=<Node> time=1
Obj_PlayAnim Anim=StandIdleRotate cycle
Wait 1 seconds
Obj_MoveToNode name=<NodeName> orient
Obj_PlayAnim Anim=StandIdleToPedIdle
Obj_WaitAnimFinished
Obj_SetPathAcceleration 55 fpsps
Endscript

Script Skateshop_PedProRotateUp speed=400
Obj_WaitRotate
Obj_RotX angle=-90 speed=400
Endscript
Script Skateshop_PedProRotateDown
Obj_WaitRotate
Obj_RotX angle=90 speed=400
Endscript

Script Skateshop_PedPlayProCongrats
//printf "playing VO"
if NOT ScreenElementExists id=select_skater_anchor
//printf "playing congrats VO"
//if NOT GoalManager_GoalExists name=sch_goal_tetris
	if LevelIs load_skateshop
		Obj_Playstream RandomNoRepeat (
			@andrew_success08
			@andrew_success10
			@chad_success01
			@chad_success05
			@chad_success12
			@chad_success45
			@elissa_success08
			@elissa_success09
			@elissa_success13
			@elissa_success27
			@eric_success02
			@eric_success21
			@eric_success28
			@geoff_success09
			@geoff_success20
			@geoff_success22
			@jamie_success18
			@jamie_success22
			@jamie_success28
			@jamie_success29
			@steve_success04
			@tony_success03
			@tony_success04
			@tony_success12
			@tony_success19
		)
	endif
endif
Endscript

Script Skateshop_PedProDistanceCheck
begin
//    if Obj_ObjectInRect height = 20 distance = 10 width = 10 type = skater debug offset = ( 0, 20, 0 )
//        printf "skater over me"
//    Endif
    wait 1 frame
    if Obj_ObjectInRadius radius = 3 feet type = skater
//        printf "playing hit VO"
//	if NOT GoalManager_GoalExists name=sch_goal_tetris
	if LevelIs load_skateshop
		if NOT ScreenElementExists id=select_skater_anchor
			PlayStream RandomNoRepeat (
				@Bucky_Avoid01
				@Bucky_Avoid02
				@Bucky_Avoid03
				@Bucky_Avoid04
				@Bucky_Avoid05
				@Bucky_Avoid06
				@Bucky_Avoid07
				@Bucky_Avoid08
				@Bucky_Avoid09
				@Rodney_Avoid01
				@Rodney_Avoid02
				@Rodney_Avoid03
				@Rodney_Avoid04
				@Steve_Avoid01
				@Steve_Avoid02
				@Steve_Avoid03
				@Steve_Avoid04
				@Steve_Avoid05
				@Steve_Avoid06
				@Steve_Avoid07
				@Steve_Avoid08
				@Steve_Avoid09
				@Steve_Avoid010
				@Steve_Avoid011
				@Steve_Avoid012
				@Steve_Avoid013
				@Steve_Avoid014
				@Steve_Avoid015
				@Tony_Avoid01
				@Tony_Avoid02
				@Tony_Avoid03
				@Tony_Avoid04
				@Tony_Avoid05
				@Tony_Avoid06
				@Tony_Avoid07
				@Tony_Avoid08
				@Tony_Avoid09
				@Tony_Avoid010
				) volume=random (@30 @50 @90) dropoff=500
			wait 5 seconds
			endif
		endif
	endif
repeat
Endscript

Script Ped_AI_Skater path=TRG_Ped_AI_SkaterNav01
GetNodeName
Obj_SetPathVelocity 35 fps
Obj_SetPathAcceleration 55 fpsps
Obj_PathHeading On
Obj_StickToGround distAbove = 3 distBelow = 16
Obj_SetPathTurnDist 10 feet
//Obj_SpawnScript  Skateshop_PedProDistanceCheck
Obj_MoveToNode name=<nodename> orient
//printf "starting run"
//Obj_MoveToNode name=<Path> time=.81 second
Obj_SetPathAcceleration 43 fpsps
Obj_FollowPathLinked
//Obj_FollowPath name=<path>
Obj_PlayAnim Anim=Crouchidle Cycle
Endscript

Script ai_printf
	if IsTrue ai_debug
		printf <...>
	endif
endscript

Script Ped_AI_Skater_GroundTrick
ai_printf "AI skater doing ground trick"
Ped_AI_Skater_FlipTrick
Ped_AI_Skater_Land
Obj_PlayAnim Anim=Crouchidle Cycle
Endscript

Script Ped_AI_Skater_JumpTo
ai_printf "AI skater jumping up"
Obj_StickToGround off
Obj_Playsound OllieConc   pitch=random (@90 @100 @110)
Obj_PlayAnim Anim=Random (@Ollie @FastPlant @NoComply @BeanPlant) speed=1.5
Obj_WaitAnimFinished
Obj_PlayAnim Anim=AirIdle Cycle
Endscript

Script Ped_AI_Skater_StartGrind
ai_printf "AI skater starting grind"
Obj_SetPathVelocity 45 fps
Obj_Playsound GrindMetalOn pitch=random (@90 @100 @110)
Random (
@Ped_AI_Skater_Grind init=Init_FiftyFifty range=FiftyFifty_Range
@Ped_AI_Skater_Grind init=Init_TailSlide range=TailSlide_Range
)
Endscript

Script Ped_AI_Skater_Grind
Obj_PlayAnim Anim=<init>
Obj_WaitAnimFinished
Obj_PlayAnim Anim=<range> from=40 to=20
Obj_WaitAnimFinished
begin
ai_printf "AI skater grinding"
Obj_PlayAnim Anim=<range> from=20 to=60
Obj_WaitAnimFinished
Obj_PlayAnim Anim=<range> from=60 to=20
Obj_WaitAnimFinished
repeat
Endscript

Script Ped_AI_Skater_StartManual
ai_printf "AI skater starting manual"
Obj_SetPathVelocity 25 fps
Obj_StickToGround on
Random (
@Ped_AI_Skater_Manual init=Manual range=Manual_Range
@Ped_AI_Skater_Manual init=NoseManual range=NoseManual_Range
)
Endscript

Script Ped_AI_Skater_Manual
Obj_PlayAnim Anim=<init>
Obj_WaitAnimFinished
Obj_PlayAnim Anim=<range> from=40 to=20
Obj_WaitAnimFinished
begin
ai_printf "AI skater Manualing"
Obj_PlayAnim Anim=<range> from=20 to=60
Obj_WaitAnimFinished
Obj_PlayAnim Anim=<range> from=60 to=20
Obj_WaitAnimFinished
repeat
Endscript

Script Ped_AI_Skater_FlipTrick
ai_printf "AI skater doing grind hop trick"
Obj_PathHeading Off
Obj_Playsound OllieConc   pitch=random (@90 @100 @110)
Random (
@
@Obj_RotY angle=360 speed=360
@Obj_RotY angle=-360 speed=360
)
Obj_PlayAnim Anim=Random (@Ollie @FastPlant @NoComply @BeanPlant) speed=1.5
Obj_Jump gravity=-420 speed=200
Obj_WaitAnimFinished
ai_printf "AI skater doing grind hop trick2"
Obj_PlayAnim Anim=Random (@Impossible @HeelFlip @KickFlip @HardFlip @VarialKickFlip @VarialHeelFlip) speed=1.5
Obj_WaitAnimFinished
Obj_WaitJumpFinished
Obj_PathHeading On
Endscript

Script Ped_AI_Skater_Land
ai_printf "AI skater landing"
Obj_Playsound LandConc pitch=random (@90 @100 @110)
Obj_SetPathVelocity 35 fps
Obj_StickToGround on
Obj_PathHeading On
Obj_PlayAnim Anim=Random (@CrouchedLand @SketchyCrouchLand speed=1.4)
Obj_WaitJumpFinished
Obj_PlayAnim Anim=Crouchidle Cycle
Endscript

Script Ped_AI_Skater_GrindHopTrickGrind
Obj_Playsound GrindMetalOff pitch=random (@90 @100 @110)
Ped_AI_Skater_FlipTrick
Ped_AI_Skater_StartGrind
Endscript
Script Ped_AI_Skater_GrindHopTrickManual
Obj_Playsound GrindMetalOff
Ped_AI_Skater_FlipTrick
Ped_AI_Skater_Land
Ped_AI_Skater_StartManual
Endscript

Script Ped_AI_Skater_ManualHopTrickManual
Ped_AI_Skater_FlipTrick
Ped_AI_Skater_Land
Ped_AI_Skater_StartManual
Endscript

/*
Use the following in SwitchObjScript to get the AI skater to do stuff...

Ped_AI_Skater_GroundTrick
Ped_AI_Skater_StartManual
Ped_AI_Skater_JumpTo
Ped_AI_Skater_StartGrind
Ped_AI_Skater_GrindHopTrickGrind
Ped_AI_Skater_GrindHopTrickManual





*/
