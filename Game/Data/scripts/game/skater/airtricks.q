// This contains slot and trick definitions for all airborne tricks

// start autoduck documentation
// @DOC airtricks
// @module airtricks | None
// @subindex Scripting Database
// @index script | airtricks

//This is the special airtricks array, which is scanned by the code when we are in the air and Special
SpecialTricks =
[

	{Trigger={TripleInOrder,Up,Right,Square,400}  	TrickSlot=SpAir_U_R_Square }
	{Trigger={TripleInOrder,Up,Down,Square,400}  	TrickSlot=SpAir_U_D_Square }
	{Trigger={TripleInOrder,Up,Left,Square,400}  	TrickSlot=SpAir_U_L_Square }
	{Trigger={TripleInOrder,Right,Up,Square,400}  	TrickSlot=SpAir_R_U_Square }
	{Trigger={TripleInOrder,Right,Down,Square,400}  TrickSlot=SpAir_R_D_Square }
	{Trigger={TripleInOrder,Right,Left,Square,400}  TrickSlot=SpAir_R_L_Square }
	{Trigger={TripleInOrder,Down,Up,Square,400}  	TrickSlot=SpAir_D_U_Square }
	{Trigger={TripleInOrder,Down,Right,Square,400}  TrickSlot=SpAir_D_R_Square }
	{Trigger={TripleInOrder,Down,Left,Square,400}  	TrickSlot=SpAir_D_L_Square }
	{Trigger={TripleInOrder,Left,Up,Square,400}  	TrickSlot=SpAir_L_U_Square }
	{Trigger={TripleInOrder,Left,Right,Square,400}  TrickSlot=SpAir_L_R_Square }
	{Trigger={TripleInOrder,Left,Down,Square,400}  	TrickSlot=SpAir_L_D_Square }

	{Trigger={TripleInOrder,Up,Right,Circle,400}  	TrickSlot=SpAir_U_R_Circle }
	{Trigger={TripleInOrder,Up,Down,Circle,400}  	TrickSlot=SpAir_U_D_Circle }
	{Trigger={TripleInOrder,Up,Left,Circle,400}  	TrickSlot=SpAir_U_L_Circle }
	{Trigger={TripleInOrder,Right,Up,Circle,400}  	TrickSlot=SpAir_R_U_Circle }
	{Trigger={TripleInOrder,Right,Down,Circle,400}  TrickSlot=SpAir_R_D_Circle }
	{Trigger={TripleInOrder,Right,Left,Circle,400}  TrickSlot=SpAir_R_L_Circle }
	{Trigger={TripleInOrder,Down,Up,Circle,400}  	TrickSlot=SpAir_D_U_Circle }
	{Trigger={TripleInOrder,Down,Right,Circle,400}  TrickSlot=SpAir_D_R_Circle }
	{Trigger={TripleInOrder,Down,Left,Circle,400}  	TrickSlot=SpAir_D_L_Circle }
	{Trigger={TripleInOrder,Left,Up,Circle,400}  	TrickSlot=SpAir_L_U_Circle }
	{Trigger={TripleInOrder,Left,Right,Circle,400}  TrickSlot=SpAir_L_R_Circle }
	{Trigger={TripleInOrder,Left,Down,Circle,400}  	TrickSlot=SpAir_L_D_Circle }

]

// Tweak point definitions
GRABTWEAK_SMALL = 15
GRABTWEAK_MEDIUM = 20
GRABTWEAK_LARGE = 25
GRABTWEAK_EXTRALARGE = 40
GRABTWEAK_SPECIAL = 30

// Special trick definitions. These are assigned to slots in Protricks.q



Trick_BamBendAir = 	{Scr=GrabTrick Params={Name='Bam Bend Air' Speed=1.3 Score=1300 Anim=BamBendAir_Init Idle=BamBendAir_Idle trickslack=100 IsSpecial } }
Trick_FlyingSquirrel = 	{Scr=GrabTrick Params={Name='Flying Squirrel' Speed=1.3 Score=1500 Anim=FlyingSquirrel_Init Idle=FlyingSquirrel_Idle IsSpecial } }
Trick_Shifty360ShovitBSShifty = 	{Scr=GrabTrick Params={Name='Shifty Shifty' Speed=2.0 Score=2000 Anim=Shifty360ShovitBSShifty_Init ForceInit Idle=Shifty360ShovitBSShifty_Idle Idle OutAnim=Shifty360ShovitBSShifty_Out trickslack=100 IsSpecial boardrotate } }
Trick_flipflip = 	{Scr=FlipTrick Params={Name='Rodeo Wrap' Score=1600 Anim=flipflip ForceInit IsSpecial BoardRotate trickslack=20 RotateAfter NoSpin Speed=1.2 maxspeed=1.3  } }
Trick_540varielheelfliplien = 	{Scr=FlipTrick Params={Name='360 Varial Heelflip Lien' Score=1500 Anim=_540varielheelfliplien Speed=1.3 IsSpecial BoardRotate trickslack=20 Speed=1.2 maxspeed=1.3 } }
Trick_LickItUp = 	{Scr=GrabTrick Params={Name='Lick It Up' Speed=1.3 Score=1500 Anim=LickItUp_Init Idle=LickItUp_Idle Idle OutAnim=LickItUp_Out trickslack=100 SpecialItem_details=tongue_details Skater=Gene IsSpecial } }
Trick_3DSwimAir = 	{Scr=GrabTrick Params={Name='Swimmer' Skater=Creature Speed=1.3 Score=1500 Anim=_3DSwimAir_Init Idle=_3DSwimAir_Idle Idle OutAnim=_3DSwimAir_Out trickslack=100 IsSpecial } }
Trick_BootBurst = 	{Scr=GrabTrick Params={Name='Boot Burst' Skater=Iron_Man Score=2000 speed=1.3 Anim=bootburst_Init Idle=bootburst_Idle Idle OutAnim=bootburst_Out trickslack=100 IsSpecial } }

Trick_FSFlipOneFootTailGrab  = 	{Scr=GrabTrick Params={Name='360 Flip Tail Grab' Score=1600 Anim=FSFlipOneFootTailGrab_Init ForceInit InitSpeed= 1.5 Idle=FSFlipOneFootTailGrab_Idle Idle OutAnim=FSFlipOneFootTailGrab_Out IsSpecial trickslack=10 } }


//Trick_Sunbathin = 	{Scr=GrabTrick Params={Name='Sunbathing' Score=1000 skater=JENNA Anim=Sunbathin_Init Idle=Sunbathin_Idle  BackwardsAnim=Sunbathin_Init speed=1.0 IsSpecial } }
//Trick_BloodyEddie = 	{Scr=GrabTrick Params={Name='Bloody Eddie' Score=1300 Anim=BloodyEddie_Init skater=eddie Idle=BloodyEddie_Idle  OutAnim=BloodyEddie_Out speed=1.2 Bloodframe=45 SpecialItem_details=bloodyguts_details GutsSound IsSpecial } }
//Trick_Sunbathin = 	{Scr=GrabTrick Params={Name='Sunbathing' Score=1000 skater=JENNA Anim=Sunbathin_Init Idle=Sunbathin_Idle  BackwardsAnim=Sunbathin_Init speed=1.0 IsSpecial } }
Trick_Flamingo = 	{Scr=GrabTrick Params={Name='Flamingo' Score=1500 Anim=Flamingo_Init Idle=Flamingo_Idle OutAnim=Flamingo_Out speed=1.2 IsSpecial } }
//Trick_StageDive = 	{Scr=GrabTrick Params={Name='Stage Dive!' Score=1000 skater=eddie Anim=StageDive_Init Idle=StageDive_Idle OutAnim=StageDive_Out Stream=StageDive speed=1.0 IsSpecial } }
//Trick_JumpJets = {Scr=GrabTrick Params={Name='Jango Jump Jet' Score=500 OnlyWith skater=JANGO Anim=JangoJumpJet_init Idle=JangoJumpJet_idle BackwardsAnim=JangoJumpJet_init ForceInit JumpJets Stream=JangoJetpack Emitscript=Jango_Jumpjet_emit IsSpecial Speed=1.0 } }
//Trick_GrappleGrab = {Scr=GrabTrick Params={Name='Grapple Grab' Score=1200 skater=JANGO Anim=GrappleGrab_init Idle=GrappleGrab_idle OutAnim=GrappleGrab_Out ForceInit IsSpecial Speed=1.5 Stream=GrappleGrab SpecialItem_details=GrappleHook_details} }

Trick_SambaFlip = {Scr=GrabTrick Params={Name='Samba Flip' Score=1600 Anim=SambaFlip Idle=Indy_Idle BackwardsAnim=Indy trickslack=10 ForceInit IsSpecial Speed=1.4 } }

Trick_360VarialMcTwist = {Scr=FlipTrick Params={Name='360 Varial McTwist' Score=5750 Anim=_360VarialMcTwist BoardRotate IsSpecial RevertBS NoSpin trickslack=10 RotateAfter Speed=1.3 MaxSpeed=1.1 Spinslack=20} }
Trick_BarrelRoll = {Scr=FlipTrick Params={Name='Barrel Roll' Score=5000 Anim=BarrelRoll  IsSpecial   NoSpin trickslack=10 BoardRotate Speed=1.0 MaxSpeed=1.1 Spinslack=10} }

Trick_Indy900 = 		{Scr=FlipTrick Params={Name='Indy 900' Score=11000 Anim=Indy900  IsSpecial BoardRotate trickslack=20 RotateAfter NoSpin Speed=1.3 maxspeed=1.4 } }
Trick_SitDownAir = 		{Scr=GrabTrick Params={Name='Sit Down Air' Score=1200 Anim=SitDownAir_Init Idle=SitDownAir_Idle IsSpecial WaitPercent=80} }
Trick_ChompOnThis = 	{Scr=GrabTrick Params={Name='Chomp On This' Score=1000 Anim=ChompOnThis_Init Idle=ChompOnThis_Idle OutAnim=ChompOnThis_Out IsSpecial MaxSpeed=.9 ForceInit Stream=ChompOnThis SpecialItem_details=PizzaBox_details Speed=.9} }
Trick_GhettoBird = 		{Scr=FlipTrick Params={Name='360 Ghetto Bird' Score=3500 Anim=GhettoBird2 IsSpecial BoardRotate trickslack=20  NoSpin Speed=1.0 } }
Trick_BreakIn  = 	    {Scr=FlipTrick Params={Name='Back Spin Air' Score=3000 Anim=BreakIn_Init Boardrotate trickslack=20 RotateAfter  Speed=1.8 IsSpecial } }
Trick_BigSpinShifty = 	{Scr=GrabTrick Params={Name='BigSpin Shifty' Score=1650 speed=1.2 Anim=FSBigSpinShifty_Init Idle=FSBigSpinShifty_Idle OutAnim=FSBigSpinShifty_Out IsSpecial ForceInit FlipAfter } }
//Trick_HTeethSweeperAir = {Scr=FlipTrick Params={Name='360 Ghetto Bird' Score=3500 Anim=GhettoBird2 IsSpecial BoardRotate trickslack=20  NoSpin Speed=1.0 } }


Trick_The900 = 			{Scr=FlipTrick Params={Name='The 900' Score=9000 Anim=The900 IsSpecial BoardRotate trickslack=20 RotateAfter NoSpin Speed=1.3 maxspeed=1.4 } }
Trick_KFBackflip = 		{Scr=FlipTrick Params={Name='Kickflip Backflip' Score=3000 Anim=KickFlipBodyBackFlip IsSpecial Speed=1.0 NoSpin Trickslack=15 Spinslack=25} }
//Trick_MistyFlip = 		{Scr=FlipTrick Params={Name='Misty Flip' Score=5000 Anim=MistyFlip IsSpecial Speed=1.2 NoSpin Trickslack=15 Spinslack=30} }
Trick_FS540 = 			{Scr=FlipTrick Params={Name='FS 540' Score=5500 Anim=FS540 BoardRotate IsSpecial trickslack=10 RevertBS RotateAfter NoSpin Speed=.9 Spinslack=40 } }
Trick_McTwist = 		{Scr=FlipTrick Params={Name='McTwist' Score=5000 Anim=McTwist BoardRotate IsSpecial RevertBS NoSpin trickslack=10 RotateAfter Speed=1.0 MaxSpeed=1.1 Spinslack=20 } }


Trick_2KickMadonnaFlip = {Scr=GrabTrick Params={Name='Double Kickflip Madonna' Score=2250 Anim=_2KickMadonnaFlip_Init Idle=Madonna_Idle OutAnim=_2KickMadonnaFlip_Out IsSpecial ForceInit Trickslack=15 Speed=1.15 } }
Trick_AssumePosition = 	{Scr=GrabTrick Params={Name='Assume The Position II' Score=1000 Anim=AssumePosition_Init Idle=AssumePosition_Idle IsSpecial speed=.8 ForceInit TrickSlack=10} }
Trick_AirCasperFlip  =  {Scr=GrabTrick Params={Name='Casper Flip 360 Flip' Score=2500 Anim=AirCasperFlip_Init Idle=AirCasperFlip_Idle OutAnim=AirCasperFlip_Out IsSpecial Speed=1.1 ForceInit TrickSlack=20} }
//Trick_KickFlipOneFootTail = {Scr=GrabTrick Params={Name='Kickflip One Foot Tail' Score=1100 Anim=KickFlipOneFootTail_Init Idle=KickFlipOneFootTail_Range OutAnim=KickFlipOneFootTail_Out IsSpecial ForceInit Trickslack=15 } }


Trick_540TailWhip = 	{Scr=FlipTrick Params={Name='540 TailWhip' Score=2500 Anim=_540TailWhip IsSpecial BoardRotate speed=1.1 MaxSpeed=1.2 trickslack=15 } }
Trick_Gazelle = 		{Scr=FlipTrick Params={Name='Gazelle Underflip' Score=3500 Anim=GazelleUnderflip IsSpecial BoardRotate trickslack=20 NoSpin } }

// RETIRED TRICKS
//Trick_MaulSpinGrab =	{Scr=GrabTrick Params={Name='Dark Jedi' Score=1300 Anim=DarkJedi_init Idle=DarkJedi_Idle OutAnim=DarkJedi_Out IsSpecial ForceInit } }
//Trick_MaulForceGrab =	{Scr=GrabTrick Params={Name='Force Grab' UnlockFlag=SKATER_UNLOCKED_MAUL Score=1300 Anim=MaulForceGrab_Init Idle=MaulForceGrab_Idle OutAnim=MaulForceGrab_Out IsSpecial ForceInit } }
//Trick_RodeoClown = 	{Scr=GrabTrick Params={Name='Rodeo Clown' UnlockFlag=SKATER_UNLOCKED_SLATER Score=1500 Anim=RodeoClown_Init Idle=RodeoClown_Idle OutAnim=RodeoClown_Out NoSpin IsSpecial ForceInit Rotate x=-360 duration=1} }
//Trick_SuperHandClap = {Scr=GrabTrick Params={Name='Super Hand Clap' UnlockFlag=SKATER_UNLOCKED_EYEBALL Score=1000 Anim=Eyeball_Init Idle=Eyeball_Idle IsSpecial ForceInit } }
//Trick_Salute = 		{Scr=GrabTrick Params={Name='Salute' Score=1300 Anim=Salute_Init Idle=Salute_Idle IsSpecial ForceInit Speed=1.1} }
//Trick_WorkForFood = 	{Scr=GrabTrick Params={Name='Panhandling' UnlockFlag=SKATER_UNLOCKED_BUM OnlyWith=Ollie Score=2000 Anim=WorkForFood_Init Idle=WorkForFood_Idle IsSpecial ForceInit } }
//Trick_ACAir = 		{Scr=GrabTrick Params={Name='AC Air' UnlockFlag=SKATER_UNLOCKED_DEMONESS Score=666 Anim=ACAir_Init Idle=ACAir_Idle OutAnim=ACAir_Out IsSpecial ForceInit } }
//Trick_PizzaGuy =  	{Scr=GrabTrick Params={Name='Pizza Guy' Score=1500 Anim=PizzaGuy_Init Idle=PizzaGuy_Idle OutAnim=PizzaGuy_Out IsSpecial ForceInit BoardRotate Speed=1.0 TrickSlack=20} }
//Trick_Berzerker =		{Scr=FlipTrick Params={Name='The Berzerker' UnlockFlag=SKATER_UNLOCKED_WOLVERINE OnlyWith=Wolverine Score=2500 Anim=Berzerker IsSpecial speed=1.1 trickslack=50 grindslack=50 } }
//Trick_ClawPunch =		{Scr=FlipTrick Params={Name='Claw Punch' UnlockFlag=SKATER_UNLOCKED_WOLVERINE OnlyWith=Wolverine OnlyWith=Wolverine Score=3000 Anim=ClawPunch IsSpecial speed=1.0 trickslack=20 } }
//Trick_Layout = 		{Scr=FlipTrick Params={Name='Handspring Layout' UnlockFlag=SKATER_UNLOCKED_CARRERA Score=3000 Anim=Maul IsSpecial Speed=1.0 Trickslack=30 Spinslack=25} }
//Trick_BetweenLegsSlam = {Scr=FlipTrick Params={Name='Slamma Jamma' Score=1750 Anim=BetweenLegsSlam IsSpecial trickslack=20 Speed=1.0} }
//Trick_Bodywrap540 = 	{Scr=FlipTrick Params={Name='Bodywrap 540' Score=4500 Anim=Bodywrap540 BoardRotate IsSpecial trickslack=10 RevertBS RotateAfter NoSpin Speed=1.0 MaxSpeed=1.1 Spinslack=20 } }
//Trick_FS540HeelFlip =   {Scr=FlipTrick Params={Name='FS 540 HeelFlip' Score=4500 Anim=FS540HeelFlip BoardRotate IsSpecial Speed=1.2 RevertBS RotateAfter NoSpin Trickslack=15 Spinslack=20} }
//Trick_HeelFlipHandflip = 	{Scr=FlipTrick Params={Name='Heelflip Handflip' speed=.9 Score=1200 Anim=HeelflipHandflip MaxSpeed=1.1 IsSpecial trickslack=20 } }
//Trick_StaleFrontFlip = 	{Scr=FlipTrick Params={Name='Stalefish FrontFlip' Score=4500 Anim=StalefishFrontFlip IsSpecial Speed=1.1 NoSpin Trickslack=15 Spinslack=30} }
//Trick_StaleBackFlip = 	{Scr=FlipTrick Params={Name='Stalefish BackFlip' Score=4500 Anim=StalefishBackFlip IsSpecial Speed=1.1 NoSpin Trickslack=15 Spinslack=30} }
//Trick_BackFootNosegrab = {Scr=GrabTrick Params={Name='Backfoot Flip Nosegrab' Score=1200 Anim=BackFootNosegrab_init Idle=BackFootNosegrab_idle OutAnim=BackFootNosegrab_Out ForceInit IsSpecial Speed=1.0 } }
//Trick_JudoMadonna =     {Scr=GrabTrick Params={Name='Judo Madonna' Score=1600 Anim=JudoMadonna_Init Idle=Madonna_Idle BackwardsAnim=Madonna IsSpecial ForceInit Trickslack=10 } }
//Trick_KFSuperman = 		{Scr=GrabTrick Params={Name='Kickflip Superman' Score=1500 Anim=KFSupermanGrab_Init Idle=KFSupermanGrab_Range OutAnim=KFSupermanGrab_Out IsSpecial ForceInit } }
//Trick_MightAsWellJump = {Scr=GrabTrick Params={Name='Might As Well Jump' Speed=1.75 Score=1750 Anim=MightAsWellJump_Init Idle=MightAsWellJump_Idle OutAnim=MightAsWellJump_Out IsSpecial ForceInit SpecialSounds=Jamie_JumpSounds SpecialItem_details=bustedboard_jump_details TrickSlack=20} }
//Trick_360Flip = 		{Scr=FlipTrick Params={Name='360 Flip' Score=500 Anim=_360Flip Nollie=Nollie360Flip} }
//Trick_Varial = 			{Scr=FlipTrick Params={Name='Varial' Score=900 Anim=BigVarial BoardRotate trickslack=25 } }




HIGHSPEED=1.0

Trick_SemiFlip = 		{Scr=FlipTrick Params={Name='Semi Flip' Score=1150 Anim=SemiFlip BoardRotate IsSpecial Speed=1.1 Trickslack=20} }
Trick_FingerFlipAirWalk = {Scr=FlipTrick Params={Name='Fingerflip Airwalk' Score=1500 Anim=FingerFlipAirWalk IsSpecial BoardRotate Speed=1.0 Trickslack=30 HoldFrame=40 } }
Trick_Jackass = 		{Scr=FlipTrick Params={Name='The Jackass' Score=1600 Anim=Jackass IsSpecial Speed=1 MaxSpeed=1.2 Trickslack=20 BloodFrame=1 } }
Trick_1234 =            {Scr=FlipTrick Params={Name='1-2-3-4' Score=1600 Anim=_1234 IsSpecial Speed=.8 Trickslack=20  } }
Trick_DoubleKFindy = 	{Scr=FlipTrick Params={Name='Double Kickflip Varial Indy' Score=1200 Anim=DoubleKFVarialIndy MaxSpeed=1.2 Trickslack=20 IsSpecial BoardRotate HoldFrame=15} }
Trick_540Flip = 		{Scr=FlipTrick Params={Name='540 Flip' Score=1450 Anim=_540flip BoardRotate IsSpecial Speed=1.1 MaxSpeed=1.2 Trickslack=20} }
Trick_NollieFlipUnderflip = {Scr=FlipTrick Params={Name='Nollie Flip Underflip' Score=1150 Anim=NollieFlipUnderFlip IsSpecial trickslack=10 Speed=1.0 MaxSpeed=1.3} }
Trick_HardFlipBackFootFlip = {Scr=FlipTrick Params={Name='Hardflip Late Flip' Score=1500 Anim=HardFlipBackFootFlip IsSpecial trickslack=15 Speed=1.0 BoardRotate} }
Trick_KickFlipUnderFlip = {Scr=FlipTrick Params={Name='Kickflip Underflip' Score=1000 Anim=KickFlipUnderFlip IsSpecial trickslack=10 MaxSpeed=1.3 Speed=1.1} }
Trick_QuadrupleHeelFlip = {Scr=FlipTrick Params={Name='Quad Heelflip' Score=1400 Anim=QuadrupleHeelFlip IsSpecial trickslack=10 Speed=1.0} }


//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
// New trick mapping stuff ...

// Definitions of the regular tricks. Prefixed with Trick_, just so as not to get a name clash with the script or anim called 'Revert' or whatever

Trick_OldSkoolKickflip = {Scr=FlipTrick Params={Name='Old Sk00l Kickflip' Score=300 Speed=1.2 Anim=KickFlipOldSkool FlipAfter Nollie=NollieKickflip ExtraTricks=DoubleKickflip} }

Trick_BigSpinFlip = {Scr=FlipTrick Params={Name='Bigspin Flip' Score=500 Anim=BigSpinFlip BoardRotate FlipAfter Speed=1.5 maxspeed=1.5 ExtraTricks=Extra_VarialKickflip} }

Trick_FSFlip = 	{Scr=FlipTrick Params={Name='FS Flip' Score=500 Anim=FSFlip BoardRotate FlipAfter maxspeed=1.5 ExtraTricks=Extra_VarialKickflip} }

Trick_BSFlip = 	{Scr=FlipTrick Params={Name='BS Flip' Score=500 Anim=BSFlip BoardRotate FlipAfter maxspeed=1.5 ExtraTricks=Extra_VarialKickflip} } //ExtraTricks=ExtraBigSpinFlip

Trick_FSBigSpin = {Scr=FlipTrick Params={Name='BS Bigspin' Score=500 Anim=FSBigSpin speed=1.2 FlipAfter maxspeed=2 ExtraTricks=Extra540ShoveIt} }

Trick_BSBigSpin = {Scr=FlipTrick Params={Name='FS Bigspin' Score=500 Anim=BSBigSpin speed=1.4 FlipAfter maxspeed=2 ExtraTricks=ExtraFS540ShoveIt} }


Trick_BackfootShoveIt = {Scr=FlipTrick Params={Name='Back Foot Shove-It' Score=150 Anim=NollieBSShoveIt Nollie=PopShoveIt ExtraTricks=Extra_360BackfootShoveIt BoardRotate} }
Extra_360BackfootShoveIt =[{Trigger={Press,Square,300}	Scr=FlipTrick Params={Name='360 Back Foot Shove-It' Score=500 Anim=NollieBS360ShoveIt IsExtra  UseCurrent } }	]

Trick_VarialKickflip = 	{Scr=FlipTrick Params={Name='Varial Kickflip' Score=300 Anim=VarialKickflip BoardRotate Nollie=NollieVarialKickflip ExtraTricks=Extra_VarialKickflip} }
Extra_VarialKickflip =	[{Trigger={Press,Square,300}Scr=FlipTrick Params={Name='360 Flip' Score=550 speed=0.9 Anim=_360Flip Nollie=Nollie360Flip IsExtra UseCurrent} }	]

Trick_VarialHeelflip = 	{Scr=FlipTrick Params={Name='Varial Heelflip' Score=300 Anim=VarialHeelflip BoardRotate Nollie=NollieVarialHeelflip ExtraTricks=Extra_VarialHeelflip} }
Extra_VarialHeelflip =	[{Trigger={Press,Square,300}   Scr=FlipTrick Params={Name='360 Heelflip' Score=500 Anim=laserflip speed=1.3 trickslack=20 IsExtra UseCurrent} }	]

Trick_Hardflip = 		{Scr=FlipTrick Params={Name='Hardflip' Score=300 Anim=Hardflip BoardRotate Nollie=NollieHardflip ExtraTricks=Extra_360Hardflip} }
Extra_360Hardflip = 	[{Trigger_Extra_Flip Params={Name='360 Hardflip' Score=500 Anim=_360Hardflip IsExtra Trickslack=20 Speed=1.1 UseCurrent} }]

Trick_InwardHeelflip = 	{Scr=FlipTrick Params={Name='Inward Heelflip' Score=350 Anim=InwardHeelflip BoardRotate Nollie=NollieInwardFlip Trickslack=15 ExtraTricks=Extra_360InwardHeelflip} }
Extra_360InwardHeelflip = [{Trigger_Extra_Flip Params={Name='360 Inward Heelflip' Score=500 Anim=_360InwardHeelFlip IsExtra trickslack=15 Speed=1.0 UseCurrent } }]

Trick_Impossible = 		{Scr=FlipTrick Params={Name='Impossible' Score=100 Anim=Impossible Nollie=NollieImpossible ExtraTricks=DoubleImpossible } }
DoubleImpossible =[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='Double Impossible' Score=500 Anim=DoubleImpossible ExtraTricks=TripleImpossible Trickslack=15 Speed=1.2 IsExtra UseCurrent} }  ]
TripleImpossible =[ {Trigger={Press,Square,300} Scr=FlipTrick Params={Name='Triple Impossible' Score=1000 Anim=TripleImpossible IsExtra UseCurrent Speed=1.2 Trickslack=15} }  ]

Trick_PopShoveIt = 		{Scr=FlipTrick Params={Name='Pop Shove-It' Score=100 Anim=PopShoveItBS BoardRotate Nollie=NollieBSShoveIt ExtraTricks=Extra360ShoveIt } }
Extra360ShoveIt = [{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='360 Shove-It' Score=500 Anim=_360ShoveIt Nollie=NollieBS360ShoveIt ExtraTricks=Extra540ShoveIt IsExtra UseCurrent } }	]
Extra540ShoveIt = [{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='540 Shove-It' Score=1000 Anim=_540ShoveIt IsExtra BoardRotate UseCurrent } }	]

Trick_FSShoveIt = 		{Scr=FlipTrick Params={Name='FS Shove-It' Score=100 Anim=PopShoveIt Nollie=NollieFSShoveIt BoardRotate ExtraTricks=ExtraFS360ShoveIt } }
ExtraFS360ShoveIt =[{Trigger={Press,Square,300}	Scr=FlipTrick Params={Name='360 FS Shove-It' Score=500 Anim=FS360ShoveIt Nollie=Nollie360ShoveIt ExtraTricks=ExtraFS540ShoveIt IsExtra  UseCurrent } }	]
ExtraFS540ShoveIt = [{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='540 FS Shove-It' Score=1000 Anim=FS540ShoveIt IsExtra BoardRotate UseCurrent } }	]

Trick_BackfootKickflip = {Scr=FlipTrick Params={Name='Back Foot Kickflip' Score=150 speed=.95 Anim=NollieKickflip Nollie=Kickflip ExtraTricks=Extra_DBackfootKickflip} }
Extra_DBackfootKickflip =[{Trigger={Press,Square,300}	Scr=FlipTrick Params={Name='Double Back Foot Flip' Score=550 speed=.9 trickslack=15 Anim=DoubleNollieKickflip IsExtra  UseCurrent } }	]

Trick_BackfootHeelflip = {Scr=FlipTrick Params={Name='Back Foot Heelflip' Score=150 speed=.95 Anim=NollieHeelflip Nollie=Heelflip ExtraTricks=Extra_DBackfootHeelflip} }
Extra_DBackfootHeelflip =[{Trigger={Press,Square,300}	Scr=FlipTrick Params={Name='Double Back Foot Heelflip' Score=550 speed=.9 trickslack=15 Anim=DoubleNollieHeelflip IsExtra  UseCurrent } }	]


Trick_Kickflip = 		{Scr=FlipTrick Params={Name='Kickflip' Score=100 Anim=Kickflip Nollie=NollieKickflip ExtraTricks=DoubleKickflip} }
DoubleKickflip =		[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='Double Kickflip' Score=500 Anim=DoubleKickflip Nollie=DoubleNollieKickflip ExtraTricks=TripleKickflip IsExtra Trickslack=15 UseCurrent} }	]
TripleKickflip =		[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='Triple Kickflip' Score=1000 Anim=TripleKickflip IsExtra Speed=1 UseCurrent} }	]

Trick_Heelflip = 		{Scr=FlipTrick Params={Name='Heelflip' Score=100 Anim=Heelflip Nollie=NollieHeelflip ExtraTricks=DoubleHeelflip } }
DoubleHeelflip =		[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='Double Heelflip' Score=500 Anim=DoubleHeelflip Nollie=DoubleNollieHeelflip ExtraTricks=TripleHeelflip Trickslack=15 IsExtra UseCurrent} }	]
TripleHeelflip =		[ {Trigger={Press,Square,300} Scr=FlipTrick Params={Name='Triple Heelflip' Score=1000 Anim=TripleHeelflip IsExtra UseCurrent} }	]

//commented out some tricks that are not in the game to save some memory

//Trick_KFIndy = 			{Scr=FlipGrabBlendFS Params={Name='Kickflip to Indy' Score=750 Anim=Kickflip IsExtra } }
//Trick_KFMelon = 		{Scr=FlipGrabBlendBS Params={Name='Kickflip to Melon' Score=750 Anim=Heelflip IsExtra } }

Trick_OllieAirwalk = 	{Scr=FlipTrick Params={Name='Ollie Airwalk' Score=500 speed=1.0 Anim=OllieAirwalk ExtraTricks=Extra_OllieAirwalk } }
Extra_OllieAirwalk = 	[{Trigger_Extra_Flip Params={Name='Ollie Airwalk Late Shove-it' Score=1050 Anim=OllieAirWalkShoveIt BoardRotate speed=1.0 IsExtra UseCurrent} }]

Trick_OllieNorth = 		{Scr=FlipTrick Params={Name='Ollie North' Score=169 Anim=OllieNorth Speed=1.0 Trickslack=15 ExtraTricks=Extra_OllieNorth HoldFrame=15} }
Extra_OllieNorth = 		[{Trigger_Extra_Flip Params={Name='Ollie North Back Foot Flip' Score=1050 Anim=OllieNorthBackFootFlip speed=1.0 IsExtra UseCurrent } }]

Trick_FFImpossible = 	{Scr=FlipTrick Params={Name='Front Foot Impossible' Score=525 Anim=FrontFootImposs Trickslack=25 speed=1 Extratricks=Extra_FFImpossible} }
Extra_FFImpossible = 	[{Trigger_Extra_Flip Params={Name='Dbl. FF Impossible' Score=1075 Anim=doublefrontfootimposs UseCurrent speed=.9 Trickslack=25 IsExtra } }]


Trick_HFVarialLien = 	{Scr=FlipTrick Params={Name='Heelflip Varial Lien' Score=800 Anim=HeelflipVarialLien BoardRotate trickslack=15 } }

Trick_Fingerflip = 		{Scr=FlipTrick Params={Name='Fingerflip' Score=700 Anim=FingerFlipVert trickslack=25 Speed=1.1 Extratricks=Extra_DoubleFingerflip } }
Extra_DoubleFingerflip = [{Trigger_Extra_Flip Params={Name='Double Fingerflip' Score=1000 Anim=DoubleFingerFlipVert speed=1.1 Trickslack=25 IsExtra UseCurrent} }]

Trick_SalFlip = 		{Scr=FlipTrick Params={Name='Sal Flip' Score=900 Anim=SalFlip trickslack=25 Extratricks=Extra_DoubleSalFlip speed=1.25} }
Extra_DoubleSalFlip = 	[{Trigger_Extra_Flip Params={Name='360 Sal Flip' Score=1150 Anim=DoubleSalFlip BoardRotate trickslack=25 speed=1.25 UseCurrent} }]


Trick_180Varial = 		{Scr=FlipTrick Params={Name='180 Varial' Score=700 Anim=_180Varial BoardRotate speed=1.15 trickslack=25 Extratricks=Trick_360Varial} }
Trick_360Varial = 		[{Trigger_Extra_Flip Params={Name='360 Varial' Score=900 Anim=_360Varial speed=.9 trickslack=25 BoardRotate IsExtra UseCurrent} }]

//// BASIC GRABS //////////////////////////
Trick_Japan = 			{Scr=GrabTrick Params={Name='Japan' Score=350 Anim=JapanAir Idle=JapanAir_Idle ExtraTricks=Trick_OneFootJapan } }
Trick_OneFootJapan = 	[{Trigger_Extra_Grab Params={Name='One Foot Japan' Score=800 TweakTrick=GRABTWEAK_LARGE Anim=OneFootJapan Speed=1.3 Idle=OneFootJapan_Idle waitpercent=70 IsExtra} }]

Trick_Crail = 			{Scr=GrabTrick Params={Name='Crail Grab' Score=350 Anim=Crail Idle=Crail_Idle  ExtraTricks=Extra_TuckKnee} }
Extra_TuckKnee = 		[{Trigger_Extra_Grab Params={Name='TuckKnee' Score=400 Anim=TuckKnee IsExtra Idle=TuckKnee_Idle } }]

Trick_SaranWrap = 		{Scr=GrabTrick Params={Name='Wrap Around' Score=450 TweakTrick=GRABTWEAK_LARGE Anim=SaranWrap Idle=SaranWrap_Idle OutAnim=SaranWrap_Out ExtraTricks=Trick_BetweenTheLegs} }
Trick_BetweenTheLegs = 	[{Trigger_Extra_Grab Params={Name='Body Wrap' Score=600 TweakTrick=GRABTWEAK_LARGE Anim=BetweenTheLegs_In Idle=BetweenTheLegs_Idle OutAnim=BetweenTheLegs_Out Speed=1.2 IsExtra} }]

Trick_Cannonball = 		{Scr=GrabTrick Params={Name='Cannonball' Score=250 TweakTrick=GRABTWEAK_SMALL Anim=Cannonball Idle=Cannonball_Idle Speed=.75 ExtraTricks=Extra_CannonballFingerflip} }  //ExtraTricks=Trick_ShiftyCannonball
Extra_CannonballFingerflip = [{Trigger_Extra_Grab Params={Name='Fingerflip Cannonball' Score=500 TweakTrick=GRABTWEAK_SMALL Anim=Cannonballfingerflip BackwardsAnim=Cannonball Idle=Cannonball_Idle Speed=1.4 IsExtra } } ]

Trick_Stalefish = 		{Scr=GrabTrick Params={Name='Stalefish' Score=350 Anim=Stalefish Idle=Stalefish_Idle ExtraTricks=Trick_Stalefish_Layback } }
Trick_Stalefish_Layback = [{Trigger_Extra_Grab Params={Name='Stalefish Tweak' Score=400 Anim=Stalefish_Layback Idle=Stalefish_Layback_Idle IsExtra } }]

Trick_Benihana = 		{Scr=GrabTrick Params={Name='Benihana' Score=300 Anim=Benihana Idle=Benihana_Idle OutAnim=Benihana_Out Extratricks=BenihanaFingerflip ForceInit ExtraTricks=Trick_Sacktap} }
Trick_SackTap =         [{Trigger_Extra_Grab Params={Name='Sacktap' Score=1500 Anim=Sacktap_Init Idle=Sacktap_Range OutAnim=Sacktap_out Speed=1.5 ForceInit Trickslack=20 IsExtra} }]

Trick_Crossbone = 		{Scr=GrabTrick Params={Name='Crossbone' Score=425 Anim=Crossbone Idle=Crossbone_Idle ExtraTricks=Trick_CrookedCop} }
Trick_CrookedCop = 		[{Trigger_Extra_Grab Params={Name='CrookedCop' Score=550 Anim=CrookedCop Idle=CrookedCop_Idle IsExtra} }]

Trick_Airwalk = 		{Scr=GrabTrick Params={Name='Airwalk' Score=450 Anim=Airwalk Idle=Airwalk_Idle2 ExtraTricks=Trick_ChristAir } }
Trick_ChristAir = 		[{Trigger_Extra_Grab Params={Name='Christ Air' Score=550 Anim=ChristAir_Init Idle=ChristAir_Idle OutAnim=ChristAir_Out ForceInit IsExtra } }]

Trick_IndyNosebone = 	{Scr=GrabTrick Params={Name='Indy Nosebone' Score=350 Anim=Nosebone Idle=Nosebone_Idle ExtraTricks=Trick_DelMarIndy} }
Trick_DelMarIndy = 		[{Trigger_Extra_Grab Params={Name='Del Mar Indy' Score=400 Anim=IndyDelMar Idle=IndyDelMar_Idle IsExtra} }]
//Trick_NosebonePoker = 	[{Trigger_Extra_Grab Params={Name='Nosebone Poker' Score=450 Anim=IndyNBPoker_Init Idle=IndyNBPoker_Idle Speed=1.2 IsExtra} }]

Trick_Tailgrab = 		{Scr=GrabTrick Params={Name='Tailgrab' Score=300 Anim=Tailgrab Idle=Tailgrab_Idle ExtraTricks=Trick_OneFootTailgrab} }
Trick_OneFootTailgrab = [{Trigger_Extra_Grab Params={Name='One Foot Tailgrab' Score=500 Anim=OneFootTailgrab Idle=OneFootTailgrab_Idle IsExtra } }]

Trick_Madonna = 		{Scr=GrabTrick Params={Name='Madonna' Score=750 TweakTrick=GRABTWEAK_EXTRALARGE Anim=Madonna Idle=Madonna_Idle waitpercent=70 ExtraTricks=Trick_Judo } }
Trick_Judo = 			[{Trigger_Extra_Grab Params={Name='Judo' Score=1150 TweakTrick=50 Anim=JudoGrab Idle=JudoGrab_Idle speed=1.0 IsExtra} }]

Trick_FSShifty = 		{Scr=GrabTrick Params={Name='FS Shifty' Score=500 Anim=Shifty Idle=Shifty_Idle ExtraTricks=Extra_BSShifty} }
Extra_BSShifty = 		[{Trigger_Extra_Grab Params={Name='BS Shifty' Score=800 Anim=BSShifty Idle=BSShifty_Idle IsExtra} }]

Trick_Melon = 			{Scr=GrabTrick Params={Name='Melon' Score=300 Anim=MelonGrab Idle=MelonGrab_Idle ExtraTricks=Trick_Method } }
Trick_Method = 			[{Trigger_Extra_Grab Params={Name='Method' Score=400 Anim = Method Idle=Method_Idle speed=1.2 IsExtra}}]

Trick_Nosegrab = 		{Scr=GrabTrick Params={Name='Nosegrab' Score=300 Anim=Nosegrab Idle=Nosegrab_Idle ExtraTricks=Trick_Rocket} }
Trick_Rocket = 			[{Trigger_Extra_Grab Params={Name='Rocket Air' Score=400 Anim=RocketAir Idle=RocketAir_Idle IsExtra} }]

Trick_Mute = 			{Scr=GrabTrick Params={Name='Mute' Score=350 Anim=MuteGrab Idle=MuteGrab_Idle ExtraTricks=Trick_Seatbelt} }
Trick_Seatbelt = 		[{Trigger_Extra_Grab Params={Name='Seatbelt Air' Score=500 Anim=Seatbelt Idle=SeatBelt_Idle Speed=.6 IsExtra} }]

Trick_Indy = 			{Scr=GrabTrick Params={Name='Indy' Score=300 Anim=Indy Idle=Indy_Idle ExtraTricks=Trick_Stiffy } }
Trick_Stiffy = 			[{Trigger_Extra_Grab Params={Name='Stiffy' Score=500 Anim=Stiffy Idle=Stiffy_Idle Speed=1.25 ForceInit IsExtra} }]

//Trick_Roastbeef = 		{Scr=GrabTrick Params={Name='RoastBeef' Score=300 Anim=Roastbeef Idle=Roastbeef_Idle } }

// Trick for Firefight
FireballF = 		{Scr=FlipTrick Params={Name='\c4Fire!\c0' Score=100 Anim=Heelflip Skew_Angle=0.0 Fireball ExtraTricks=DoubleFireballF} }
DoubleFireballF =	[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='\c4Double Fire!\c0' Score=500 Anim=DoubleHeelflip Skew_Angle=-5.0 Fireball ExtraTricks=TripleFireballF IsExtra Trickslack=15 UseCurrent} }	]
TripleFireballF =	[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='\c4Triple Fire!\c0' Score=1000 Anim=TripleHeelflip Skew_Angle=5.0 Fireball ExtraTricks=QuadFireballF IsExtra UseCurrent} }	]
QuadFireballF =		[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='\c4Quad Fire!\c0' Score=2000 Anim=QuadrupleHeelFlip Skew_Angle=10.0 Fireball IsExtra Speed=1 UseCurrent} }	]

FireballB = 		{Scr=FlipTrick Params={Name='\c4Reverse Fire!\c0' Score=100 Anim=Heelflip skew_angle=180.0 vel_scale=0.5 Fireball ExtraTricks=DoubleFireballB } }
DoubleFireballB = 	[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='\c4Double Reverse Fire!\c0' Score=500 skew_angle=185.0 vel_scale=0.5 Fireball Anim=DoubleHeelflip  ExtraTricks=TripleFireballB IsExtra UseCurrent } }	]
TripleFireballB = 	[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='\c4Triple Reverse Fire!\c0' Score=1000 skew_angle=175.0 vel_scale=0.5 Fireball Anim=TripleHeelflip ExtraTricks=QuadFireballB IsExtra  UseCurrent } }	]
QuadFireballB = 	[{Trigger={Press,Square,300} Scr=FlipTrick Params={Name='\c4Quad Reverse Fire!\c0' Score=2000 skew_angle=190.0 vel_scale=0.5 Fireball Anim=QuadrupleHeelFlip IsExtra UseCurrent } }	]

// See groundtricks.q
Trick_Revert = {Scr=Revert}

//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\

AirTricks=
[

	// An Old test
	//	{Trigger={HoldTwoAndPress,Circle,R2,left,500}     	Trickslot=Air_L_R2_Circle }
	//    {Trigger={HoldTwoAndPress,Circle,R2,right,500}   	Trickslot=Air_R_R2_Circle }
	//	{Trigger={HoldTwoAndPress,Circle,R2,up,500}     	Trickslot=Air_U_R2_Circle }
	//    {Trigger={HoldTwoAndPress,Circle,R2,down,500}   	Trickslot=Air_D_R2_Circle }

	// Now, the trick is referred to via its trick slot.

	{Trigger={TripleInOrder,a=Left,b=Left,Square,300}     	Trickslot=Air_L_L_Square }
	{Trigger={TripleInOrder,a=Right,b=Right,Square,300}   	Trickslot=Air_R_R_Square }
	{Trigger={TripleInOrder,a=Up,b=Up,Square,300}     		Trickslot=Air_U_U_Square }
	{Trigger={TripleInOrder,a=Down,b=Down,Square,300}   	Trickslot=Air_D_D_Square }

	{Trigger={AirTrickLogic,Square,UpLeft,500}    		TrickSlot=Air_SquareUL }
	{Trigger={AirTrickLogic,Square,UpRight,500}   		TrickSlot=Air_SquareUR }
	{Trigger={AirTrickLogic,Square,DownLeft,500}  		TrickSlot=Air_SquareDL }
	{Trigger={AirTrickLogic,Square,DownRight,500} 		TrickSlot=Air_SquareDR }
	{Trigger={AirTrickLogic,Square,Up,500}  			TrickSlot=Air_SquareU }
	{Trigger={AirTrickLogic,Square,Down,500}    		TrickSlot=Air_SquareD }
	{Trigger={AirTrickLogic,Square,Left,500}        	TrickSlot=Air_SquareL }
	{Trigger={AirTrickLogic,Square,Right,500}   		TrickSlot=Air_SquareR }

	{Trigger={TripleInOrder,a=Left,b=Left,Circle,300}     	Trickslot=Air_L_L_Circle }
	{Trigger={TripleInOrder,a=Right,b=Right,Circle,300}   	Trickslot=Air_R_R_Circle }
	{Trigger={TripleInOrder,a=Up,b=Up,Circle,300}     		Trickslot=Air_U_U_Circle }
	{Trigger={TripleInOrder,a=Down,b=Down,Circle,300}   	Trickslot=Air_D_D_Circle }

	{Trigger={AirTrickLogic,Circle,UpLeft,500}    		TrickSlot=Air_CircleUL }
	{Trigger={AirTrickLogic,Circle,UpRight,500}   		TrickSlot=Air_CircleUR }
	{Trigger={AirTrickLogic,Circle,DownLeft,500}   		TrickSlot=Air_CircleDL }
	{Trigger={AirTrickLogic,Circle,DownRight,500}  		TrickSlot=Air_CircleDR }
	{Trigger={AirTrickLogic,Circle,Up,500}   			TrickSlot=Air_CircleU }
	{Trigger={AirTrickLogic,Circle,Down,500}    		TrickSlot=Air_CircleD }
	{Trigger={AirTrickLogic,Circle,Right,500}  			TrickSlot=Air_CircleR }
	{Trigger={AirTrickLogic,Circle,Left,500}    		TrickSlot=Air_CircleL }

	//	{Trigger={PressTwo,Down,Triangle,200}    					Scr=ToTail }
]
// Issues - don't do this if not on vert
// Rotation is whack
// Need to Play BodyJar based on triggering orientation

script ToTail
	If Not InVertAir
		// if we triggered a totail by accident in midair, give those events back and return
		// this is easier then never enabling the ToTail in the first place, and tracking when you
		// enter and exit VertAir
		RestoreEvents UsedBy=Regular Duration=200
		Goto AirBorne
	endif
	OnExitRun ToTail_Cleanup
	NoRailTricks
	//NoSpin
	PlayAnim Anim=ToTail_In Speed=1.25
	begin
		If Released Triangle
			If AnimEquals ToTail_Idle
				PlayAnim Anim=ToTail_Out
			else
				PlayAnim Anim=ToTail_In From=Current To=Start
			endif
			break
		else
			If AnimEquals ToTail_In
				If AnimFinished
					PlayAnim Anim=ToTail_Idle Cycle
				endif
			endif
		endif
		/*
		If LandedfromVert
			Printf "Yahhooo"
		else
			printf "No"
		endif
		*/
		If Held R1
			Rotate x=5 Duration=.1
		endif
		/*
		if YawBetween (0,90) //was (0,5)
			printf "0,90"
			CanSpin
		else
			NoSpin
		endif
 		if YawBetween (180,360) //was (0,5)
			printf "180,360"
		endif
		*/
		//printf "Skater Ort = %q %w %e" q=<x> w=<y> e=<z>
		DoNextTrick
		Wait 1 game frame
	repeat
	WaitAnimWhilstChecking
	Goto Airborne
endscript

script ToTail_Cleanup
	printf "Cleanup"
	AllowRailTricks
	CanSpin
Endscript

SkateToWalkTricks = [

	{SwitchControl_Trigger    					Scr=CheckforSwitchVehicles }
]


////////// Extra Tricks //////////
Trigger_Extra_Grab_Tweak = {Trigger={ExtraGrabTrickLogic,Circle,300} Scr=GrabTrick}

Trigger_Extra_Grab = {Trigger={Press,Circle,300} 	Scr=GrabTrick}
Trigger_Extra_Flip = {Trigger={Press,Square,300}	Scr=FlipTrick }


KickflipExtras =
[    {Trigger={Press,Square,300}   	Scr=FlipTrick Params={Name='Double Kickflip' Score=500 Anim=DoubleKickflip ExtraTricks=TripleKickflip Speed=1 IsExtra UseCurrent} }
	; KickflipToIndy =
	{Trigger={Press,Circle,300}    	Scr=FlipGrabBlend Params={Name='Kickflip to Indy' Score=400 Anim1=KickFlipBlendFS Anim2=Indy IsExtra} }
	; KickflipToNosegrab =
	{Trigger={AirTrickLogic,Circle,Up,300}    		Scr=FlipGrabBlend Params={Name='Kickflip to Crail' Score=400 Anim1=KickFlipBlendFS Anim2=Crail IsExtra GrabStart=5 Speed=1} }
]

BenihanaFingerflip =
[     {Trigger={AirTrickLogic,Square,Up,500}   		Scr=Fliptrick Params={Name='Beni Fingerflip' Score=1000 Anim=BenihanaFingerFlip IsExtra} } ]



; This script used to trigger common tricks like the kickflip. All
; parameters are fed in through the Airtricks array located at the
; top of the file.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
// @script | FlipTrick | This script used to trigger common tricks like the kickflip.
// All parameters are fed in through the Airtricks array located at the
// top of the file
// @parm array | Airtricks | This array is located at the top of airtricks.q
// @parmopt float | speed | 1.0 |
// @parmopt int | trickslack | 10 |
// @parmopt int | grindslack | 25 |

COOL_SPECIAL_TRICKS=0

script FlipTrick speed=1.0 trickslack=10 grindslack=25 flip_stat_mod=1.0
	if GotParam Fireball
		if GameModeEquals is_firefight
			if HasPowerup fireball
				LaunchFireball Skew_Angle=<Skew_Angle> vel_scale=<vel_scale>
			endif
		endif
	endif
	// printstruct <...>
	LaunchStateChangeEvent State=Skater_InAir
	LaunchSubStateEntryEvent SubState=Flip
	OnExitRun ExitFlipTrick

	If GotParam FullScreenEffect
		<FullScreenEffect>
		OnExitRun ExitFliptrick_FullScreenEffect
	endif

	GetScriptedStat Skater_Flip_Speed_Stat      // returns <stat_value>
	// printf "flip speed stat=%s" s=<stat_value>
	speed = ( <speed> * <stat_value>  )
	// cap our anim speed at 1.4
	if GotParam MaxSpeed
		if (<speed> > <maxspeed>)
			<speed> = <maxspeed>
		endif
	else
		if (<speed> > 1.3)
			speed=1.3
		endif
	endif
	//	printf "anim Speed = %F" f=<speed>
	; Clear any jump tricks that might have got queued up.
	; Note this does not clear everything in the trick queue, just tricks from
	; the arrays specified.
	ClearTricksFrom Jumptricks Jumptricks0 Jumptricks

	if GotParam FromGroundGone
		SetEventHandler Ex=Ollied Scr=TrickOllie
	else
		ClearException Ollied
	endif
	//SetEventHandler 	Ex=Ollied 	Scr=CalledOllie  // check for an ollie release after we start a trick, so we get a full jump - taken out because it allowed extra ollies when just x > kickflip > x

	/* No longer needed
	CheckForOllie	;all trick scripts should do an immediate check for an ollie, see script for more comments
	If GotParam Ollie
		Jump
	endif
	*/

	KillExtraTricks
	//ClearManualTrick		; if a manual got queued up before this trick, cancel it
	//ClearExtraGrindTrick	; ditto for special grinds
	BailOn

	// If we ever setup double tap tricks for Pressure Flips, this may need to go after the Extratrick window
	// 15 frames in, where Nollieoff is
	If InPressure
		PressureOff
		SetSkaterAirTricks
	endif

	If GotParam NoSpin
		NoSpin
	Endif
	// Some tricks require us to force the direction of the revert in order to look good
	If GotParam RevertFS
		Obj_SetFlag FLAG_SKATER_REVERTFS
	endif
	If GotParam RevertBS
		Obj_SetFlag FLAG_SKATER_REVERTBS
		//    printf "============setting revert BS"
	endif

	If InNollie
		If GotParam	Nollie
			If GotParam IsExtra
				PlayAnim Anim=<Nollie> From=Current BlendPeriod=0.2 speed=<speed>	; ideally, all nollie tricks should be like this...
			else
				PlayAnim Anim=<Nollie> BlendPeriod=0.2 speed=<speed>	; ideally, all nollie tricks should be like this...
			endif
		else
			If GotParam IsExtra
				PlayAnim Anim=<Anim> From=Current BlendPeriod=0.2 speed=<speed>		; this is if we are in Nollie, but don't have a specific nollie animation
			else
				PlayAnim Anim=<Anim> BlendPeriod=0.2 speed=<speed>		; this is if we are in Nollie, but don't have a specific nollie animation
			endif
		endif
	else
		; If this is an extra trick with smooth branching, we want to play from the current frame
		If GotParam UseCurrent
			printf "USING THE CURRENT FRAME"
			PlayAnim Anim=<Anim> From=Current BlendPeriod=0.2 speed=<speed>
		else
			PlayAnim Anim=<Anim> BlendPeriod=0.2 speed=<speed>
		endif
	endif
	// Start checking for Shiftys
	// Obj_SpawnScript Shifty_Check 			  //RotateDisplay y StartAngle=-90 EndAngle=0 duration=.25 seconds

	If not GotParam HoldFrame
		If GotParam BoardRotate					; if this trick is a shove-it type trick - rotate board after and no blending
			BlendperiodOut 0
			BoardRotateAfter
		endif
		If GotParam RotateAfter
			BlendperiodOut 0
			RotateAfter
		endif
		// if, at the end of the anim, you end up
		// switch, we need to tell the code
		If GotParam FlipAfter
			BlendperiodOut 0
			FlipAfter
		endif
	endif

	; if this trick has an extratrick - a branching, hidden combo - set it active
	If GotParam ExtraTricks
		SetExtraTricks tricks=<extratricks> duration=14 // only set the duration 1 frame less than the wait, otherwise you can get the trick to display
		// and then get an extratrick off again
	endif

	if GotParam FromGroundGone
		// if we came from GroundGone, allow a late ollie during these 15 frames, or until airtime exceeds the late ollie window
		WaitFramesLateOllie Frames=15
		ClearException Ollied
		if not (<Frames> = 0)
			Wait <Frames> Frames
		endif
	else
		Wait 15 Frames
	endif

	NollieOff	// delay a Nollie off until here, as you might have started a Nollie Kickflip and if you break to a Doubel Nollie Kickflip, you need
	//to stay in Nollie

	/*	GetAirTimeLeft
	// if we're just about to land, stick "late" on the trick and double its points
	if ( <AirTimeLeft> < .1 )
		FormatText TextName=formatted_trick 'Late %s' s=<Name>
		name = <formatted_trick>
		score = (<score> * 2)
	endif

	GetSpin
	if LastSpinWas Frontside
		if (<spin> > 45)
			Create_panel_message text="FS"
		endif
	endif
	if LastSpinWas Backside
		if (<spin> > 45)
			Create_panel_message text="BS"
		endif
	endif
*/
	SetTrickName <Name>
	SetTrickScore <Score>
	Display
	; if we're in the middle of an extra trick play some sound and lights
	If GotParam IsExtra
		LaunchExtraMessage
	endif
	If GotParam IsSpecial
		LaunchSpecialMessage Cool
	endif
	If GotParam BloodFrame
		Wait <Bloodframe> frames
		If GotParam GutsSound
			Playsound Random (@hitblood01 @hitblood02 @hitblood03)
		else
			Obj_PlaySound Random(@BailSlap01 @BailSlap02 @BailSlap03)  //changed from bitchslap2 04/30/03 by David Rowe
		endif
		Bloodsplat
		Obj_SpawnScript BloodJackAss
		Wait 1 frame
		PlaySound BailSlap02  //changed from headsmackB 04/30/03 by David Rowe
	endif
	//Printf "just cleared grindslack"							; means after this point we can combo into a grind without bailing

	If GotParam SpinSlack
		WaitAnim <spinslack> frames fromend
		Canspin
	endif

	If GotParam HoldFrame
		HoldAbleFlipTrick <...>
	endif

	If GotParam GrindSlack
		WaitAnim <grindslack> frames fromend
	endif
	Bailoff
	WaitAnim <trickslack> frames fromend
	if GotParam IsSpecial
		EndSpecial
	endif
	CanSpin
	DoNextTrick
	WaitAnimWhilstChecking
	goto Airborne
endscript

script HoldAbleFliptrick
	WaitAnim <HoldFrame> frames fromend
	begin
		If Released Circle
			If Released Square
				break
			endif
		endif
		PlayAnim Anim=<Anim> From=Current To=Current Blendperiod=0.0
		WaitOneGameFrame
		TweakTrick	GRABTWEAK_MEDIUM
	repeat
	PlayAnim Anim=<Anim> From=Current
	If GotParam BoardRotate					; if this trick is a shove-it type trick - rotate board after and no blending
		BlendperiodOut 0
		BoardRotateAfter
	endif
	If GotParam RotateAfter
		BlendperiodOut 0
		RotateAfter
	endif
	If GotParam FlipAfter
		BlendperiodOut 0
		FlipAfter
	endif
endscript

Script Shifty_Check
	Wait 10 frames
	if held Triangle
		/*AddAnimController {
					type=partialanim
					AnimName=Partial_Shifty
					//From=<partialAnimTime>
					//To=End
					//Cycle
					Speed=.1
					//seconds		// time is in seconds, not frames
				} */
		//RotateDisplay y StartAngle=0 EndAngle=-90 duration=.25 seconds
		Rotate y=-75 Duration = .2 seconds
		//Obj_Rotate time = .2 relative = ( 0, -75, 0 )
		Wait .2 seconds
		begin
			Wait 1 frame
			TweakTrick 10
			if released Square
				break
			endif
		repeat
		Rotate y=75 Duration = .2 seconds
		DoNextTrick
	endif
endscript

script ExitFlipTrick
	//KillSpawnedScript name=Shifty_Check
	LaunchSubStateExitEvent SubState=Flip
	CleanUp_SpecialTrickParticles
endscript

script ExitFlipTrick_FullScreenEffect
	Exit_FullscreenEffect
	ExitFlipTrick
endscript


// @script | CheckForOllie |
// If the ollied exception is set, then it must be due to the late-jump stuff setting it
// in the GroundGone script.
// Change the exception to call CalledOllie instead of jumping to the regular Ollie script,
// so that if the exception occurs just before the grab trick we'll still get a jump,
// but it will return and complete the trick. When some people play they do a tricky sequence:
// they actually press the trick just before they release X to jump. When the events come out of
// order like this, then the ollie exception actually kills the trick. So we need to check and
// handle this situation. The solution: all air tricks must "CheckForOllie"

;script CheckForOllie
; Mick removed because of changes in the ordering of things
; it is no longer possible to "miss" an exception, if it was triggered, then it
; was executed, so checking for it makes no sense.
;	if GotException Ollied
;		SetException Ex=Ollied Scr=CalledOllie CallInsteadOfGoto
;	endif
;endscript

/*
// SP: tiniest amount of slop allowed, for people who roll their hands from X to circle
// if this is too big, then you will be able to jump > grab > jump again. So be careful
Skater_Late_Ollie_Slop = 100

// @script | CalledOllie | Used when ollie is called in the air.
// If the ollie was called within the time specified by Skater_Late_Jump_Slop
// then the jump is performed, otherwise not.
script CalledOllie
	if AirTimeGreaterThan Skater_Late_Ollie_Slop
		ClearException	Ollied
	else
	//	printf "called Ollie"
	//	create_panel_message text="Late Ollie"
		Jump
		ClearException	Ollied
	endif
endscript
*/


// @script | GrabTrick |
// This script used to trigger common grabs like the nosebone. All
// parameters are fed in through the Airtricks array located at the
// top of the file.
// @parm array | Airtricks | specified at the top of airtricks.q
// @parmopt float | speed | 1.0 |
// @parmopt int | x | -180 |
// @parmopt float | duration | 1.0 |
// @parmopt flag | GrabTweak | GRABTWEAK_MEDIUM |

script GrabTrick Speed=1.0 x=-180 duration=1.0 GrabTweak=GRABTWEAK_MEDIUM waitpercent=60 button=circle
	; Clear any jump tricks that might have got queued up.
	; Note this does not clear everything in the trick queue, just tricks from
	; the arrays specified.
	ClearTricksFrom Jumptricks Jumptricks0 Jumptricks
	// CheckForOllie	;no longer needed
	KillExtraTricks
	//ClearManualTrick		; if a manual got queued up before this trick, cancel it
	ClearExtraGrindTrick	; ditto for special grinds
	//SetEventHandler 	Ex=Ollied 	Scr=CalledOllie  // check for an ollie release after we start a trick, so we get a full jump - taken out because it allowed extra ollies when just x > kickflip > x

	if GotParam FromGroundGone
		SetEventHandler Ex=Ollied Scr=TrickOllie
	else
		ClearException Ollied
	endif

	BailOn

	LaunchStateChangeEvent State=Skater_InAir
	LaunchSubStateEntryEvent SubState=Grab
	OnExitRun ExitGrabTrick

	If GotParam FullScreenEffect
		<FullScreenEffect>
		OnExitRun ExitGrab_FullScreenEffect
	endif

	if GotParam SpecialSounds
		Obj_SpawnScript <SpecialSounds> //spawn a script to play special trick streams
	endif

	If GotParam ExtraTricks
		// Set up the "tweak" grab for this grab
		SetExtraTricks tricks=<extratricks> duration=15
	endif

	if GotParam SpecialItem_details
		TurnOnSpecialItem SpecialItem_details=<SpecialItem_details>
	endif

	if GotParam IsExtra
		PlayAnim Anim=<Anim> BlendPeriod=0.3 from=current to=end speed=<speed>
	else
		PlayAnim Anim=<Anim> BlendPeriod=0.3 speed=<speed>
	endif

	// a little routine to give Jango Fett a super boost
	if GotParam JumpJets
		Obj_KillSpawnedScript name=JumpJets
		Obj_SpawnScript JumpJets
	endif

	// streams
	If GotParam Stream
		Obj_PlayStream <stream>
	endif

	// in grab script
	If GotParam BloodFrame
		Wait <Bloodframe> frames
		If GotParam GutsSound
			Playsound Random (@hitblood01 @hitblood02 @hitblood03)
		else
			Obj_PlaySound Random(@BailSlap01 @BailSlap02 @BailSlap03)  //changed from bitchslap2 04/30/03 by David Rowe
		endif
		Bloodsplat
		Obj_SpawnScript BloodJackAss
		Wait 1 frame
		PlaySound BailSlap02  //changed from headsmackB 04/30/03 by David Rowe
	endif

	if GotParam FromGroundGone
		// if we came from GroundGone, allow a late ollie during these 15 frames, or until airtime exceeds the late ollie window
		WaitFramesLateOllie Frames=15
		ClearException Ollied
	endif

	WaitAnim 50 percent

	SetTrickName <Name>
	SetTrickScore <Score>
	Display
	If GotParam IsSpecial
		LaunchSpecialMessage Cool
	endif
	If GotParam IsExtra
		LaunchExtraMessage
	endif

	If GotParam ForceInit
		WaitAnimFinished
	else
		WaitAnim <waitpercent> percent
	endif

	// SP: For grabtricks bound to Square combos, do a check and rebind the holding button to be square if so
	If not Held Circle
		If Held Square
			Button = Square
		endif
	endif

	begin
		If Released <button>
			break
		endif
		If AnimFinished
			PlayAnim Anim=<idle> cycle speed=<speed>
			break
		endif
		WaitOneGameFrame
	repeat
	;any of the above ifs TRUE jump to here
	//printf "Killing Extra Tricks........................"
	//KillExtraTricks
	begin
		// Spin Test
		// if held Down
		//	RotateDisplay x StartAngle = 0.0, EndAngle = -360.0 Duration=.75 second
		//	break
		// endif

		If Released <button>
			IfReleased_SquareOrCircle <...>
			break
		endif

		WaitOneGameFrame
		If GotParam IsSpecial
			TweakTrick GRABTWEAK_SPECIAL
		else
			TweakTrick	<GrabTweak>
		endif
	repeat
	If GotParam BoardRotate					; if this trick is a shove-it type trick - rotate board after and no blending
		BlendperiodOut 0
		BoardRotateAfter
	endif
	;WaitAnimFinishedWhilstChecking AirTricks
	;PlayAnim Anim=<Anim> BlendPeriod=0.3 Backwards
	;WaitAnim 20 frames fromstart
	If GotParam TrickSlack
		WaitAnim <TrickSlack> frames fromend
	endif
	BailOff
	If GotParam IsSpecial
		EndSpecial
	endif

	If GotParam FlipAfter
		FlipAfter
		BlendperiodOut 0
	endif

	If GotParam RotateAfter
		BlendperiodOut 0
		RotateAfter
	endif

	WaitAnimWhilstChecking
	goto Airborne
endscript

script ExitGrabTrick
	LaunchSubStateExitEvent SubState=Grab
	CleanUp_SpecialTrickParticles
endscript

script ExitGrab_FullScreenEffect
	Exit_FullscreenEffect
	ExitGrabTrick
endscript

script IfReleased_SquareOrCircle
	If GotParam OutAnim					;check to see if there's a specific OutAnim
		Obj_PlayAnim Anim=<OutAnim> BlendPeriod=0.2 speed=<speed>
	else
		If GotParam BackwardsAnim
			Obj_PlayAnim Anim=<BackwardsAnim> Backwards BlendPeriod=0.2 speed=<speed>
		else
			If AnimEquals Airwalk ; check to see if we've hit the idle, if not, reverse playback otherwise...
				Obj_PlayAnim Anim=<Anim> From=Current To=0 BlendPeriod=0.2 speed=<speed>
			else								; we need to start playing the in anim backwards right away
				Obj_PlayAnim Anim=<Anim> Backwards BlendPeriod=0.2 speed=<speed>
			endif
		endif
	endif
	// To Tail Test v2
	/*
		If Held R1
			NoSpin
			AddAnimController {
					type=partialanim
					AnimName=Partial_ToTail_In
					//From=<partialAnimTime>
					//To=End
					//Cycle
					//Speed=.1
					//seconds		// time is in seconds, not frames
					}
		endif */
endscript


script JumpJets
	ReplayRecordSimpleScriptCall scriptname=_ReplayJumpJets skaterscript

	Obj_GetID
	MangleChecksums a=skatersplash b=<objId>

	if not Obj_FlagSet FLAG_SKATER_JUMPJETSON
		If not InNetGame
			if not GameModeEquals Is_SingleSession
				begin
					Skater:Jump
					Wait 1 game frame
				repeat 2

				Obj_SpawnScript JumpJetTracker params={<...>}
			endif
		endif
	endif
	EmptyParticleSystem name=<mangled_id>
	SetScript name=<mangled_id> emitscript=emit_jumpjets //updatescript=update_jumpjets
	ParticlesOn name=<mangled_id>
	wait .5 second
	ParticlesOff name=<mangled_id>
	Wait .5 seconds
	SetScript name=<mangled_id> emitscript=emit_skatersplash //updatescript=skatersplash_update

endscript

script JumpJetTracker
	//	set a timer so we can't keep jumping and boosting up into the sky infinitely
	Obj_SetFlag FLAG_SKATER_JUMPJETSON
	Wait 2 seconds
	Obj_ClearFlag FLAG_SKATER_JUMPJETSON
endscript


script _ReplayJumpJets
	// Need to spawn because the replay code will run this script to completion.
	SpawnSkaterScript ReplayJumpJets
endscript

script ReplayJumpJets
	Obj_GetID
	MangleChecksums a=skatersplash b=<objId>

	EmptyParticleSystem name=<mangled_id>
	SetScript name=<mangled_id> emitscript=emit_jumpjets //updatescript=update_jumpjets
	ParticlesOn name=<mangled_id>
	wait .5 second
	ParticlesOff name=<mangled_id>
	Wait .5 seconds
	SetScript name=<mangled_id> emitscript=emit_skatersplash //updatescript=skatersplash_update
endscript


/*
// @script | FlipGrabBlendFS | Blend a flip trick into a grab trick - frontside version
// @parmopt string | name | 'Kickflip to Indy' | trick name
script	FlipGrabBlendFS name='Kickflip to Indy'
	if GotParam FromGroundGone
		SetEventHandler Ex=Ollied Scr=TrickOllie
	else
		ClearException Ollied
	endif

	;CheckforOllie
	//ClearManualTrick		; if a manual got queued up before this trick, cancel it
	ClearExtraGrindTrick	; ditto for special grinds
	KillExtraTricks
	If GotParam IsExtra
		LaunchExtraMessage
	endif
	PlayAnim Anim=KickFlipBlendFS BlendPeriod=0.3 from=current
	SetTrickName <name>

	if GotParam FromGroundGone
		// if we came from GroundGone, allow a late ollie during these 15 frames, or until airtime exceeds the late ollie window
		WaitFramesLateOllie Frames=15
		ClearException Ollied
		if not (<Frames> = 0)
			Wait <Frames> Frames
		endif
	else
		Wait 15 Frames
	endif

	Display
	Wait 5 Frames
	PlayAnim Anim=Indy From=10 To=End BlendPeriod=0.3  Speed=1.5
	WaitAnim 10 frames fromend
	DoNextTrick
	WaitAnimFinished
	Reverse
	;PlayAnim Anim=Indy From=End To=0 BlendPeriod=0.3
	;WaitAnim 25 frames fromstart
	WaitAnimWhilstChecking
endscript


// @script | FlipGrabBlendBS | Blend a flip trick into a grab trick - backside version
// @parmopt string | name | 'Kickflip to Melon' | trick name
script	FlipGrabBlendBS	name='Kickflip to Melon'
	if GotParam FromGroundGone
		SetEventHandler Ex=Ollied Scr=TrickOllie
	else
		ClearException Ollied
	endif

	;CheckForOllie	; no longer needed
	//ClearManualTrick		; if a manual got queued up before this trick, cancel it
	ClearExtraGrindTrick	; ditto for special grinds
	KillExtraTricks
	If GotParam IsExtra
		LaunchExtraMessage
	endif
	;PlayAnim Anim=Kickflip
	;Wait 15 frames
	PlayAnim Anim=KickFlipBlendBS BlendPeriod=0.3
	SetTrickName <name>

	if GotParam FromGroundGone
		// if we came from GroundGone, allow a late ollie during these 15 frames, or until airtime exceeds the late ollie window
		WaitFramesLateOllie Frames=15
		ClearException Ollied
		if not (<Frames> = 0)
			Wait <Frames> Frames
		endif
	else
		Wait 15 Frames
	endif

	Display
	Wait 10 frames
	PlayAnim Anim=MelonGrab From=20 To=End BlendPeriod=0.3 Speed=1.4
	WaitAnimFinished
	Reverse
	DoNextTrick
	;PlayAnim Anim=Indy From=End To=0 BlendPeriod=0.3
	;WaitAnim 25 frames fromstart
	WaitAnimWhilstChecking
endscript

// @script | FlipGrabBlend | Blend flip trick to grab - generic version blending two animations
// @parmopt int | Grabstart | 10 |
// @parmopt float | GrabSpeed | 1.5 |
// @parm name | anim1 | First animation
// @parm name | anim2 | Second animation
script	FlipGrabBlend Grabstart=10 GrabSpeed=1.5
	if GotParam FromGroundGone
		SetEventHandler Ex=Ollied Scr=TrickOllie
	else
		ClearException Ollied
	endif

	;CheckForOllie	; no longer needed
	ClearManualTrick		; if a manual got queued up before this trick, cancel it
	ClearExtraGrindTrick	; ditto for special grinds
	KillExtraTricks
	If GotParam IsExtra
		LaunchExtraMessage
	endif
	PlayAnim Anim=<anim1> BlendPeriod=0.3 from=current
	SetTrickName <name>
	SetTrickScore <score>
	Display

	if GotParam FromGroundGone
		// if we came from GroundGone, allow a late ollie during these 15 frames, or until airtime exceeds the late ollie window
		WaitFramesLateOllie Frames=15
		ClearException Ollied
		if not (<Frames> = 0)
			Wait <Frames> Frames
		endif
	else
		Wait 15 Frames
	endif

	PlayAnim Anim=<anim2> From=<GrabStart> To=End BlendPeriod=0.3  Speed=<GrabSpeed>
	//WaitAnim 10 frames fromend
	DoNextTrick
	WaitAnimFinished
	Reverse
	;PlayAnim Anim=Indy From=End To=0 BlendPeriod=0.3
	;WaitAnim 25 frames fromstart
	WaitAnimWhilstChecking
endscript
*/

///////////////////////////////////////////
//    OLD THPS3 SECRET CHARACTER STUFF
//////////////////////////////////////////
/*
script secret_character_check
	If AnimEquals DarkJedi_init
		SpawnSkaterScript MaulSFX
	endif
	If AnimEquals MaulForceGrab_Init
		PlaySound SaberTwirl5 pitch=70
	endif
	If AnimEquals WorkForFood_Init
		SpawnSkaterScript Ollie_Signage
	endif
endscript


// @script | Eyeball_SFX | Used to play sound for eyeball man
Script Eyeball_SFX
begin
    If AnimEquals Eyeball_idle
        If frameis 2
            PlaySound bitchslap2 pitch=120
        endif
    else
        break
    endif
WaitOneGameFrame
repeat
endscript

// @script | MaulSFX | Used to play saber twirling sound for maul
script MaulSFX
Playsound SaberTwirl5
Wait 10
Playsound SaberTwirl5
Wait 10
Playsound SaberTwirl5
Wait 100
Playsound SaberTwirl5
Wait 600
PlaySound SaberHit1
endscript

// @script | MaulSFX2 | Used to play saber hit sound for maul
script MaulSFX2
PlaySound SaberHit1 pitch=90
endscript

// @script | Ollie_Signage | special character animation
script Ollie_Signage
	SwitchOnAtomic special_item
	begin
		If AnimEquals WorkForFood_Init
		else
			If AnimEquals WorkForFood_Idle
			else
				break
			endif
		endif
	WaitOneGameFrame
	repeat
	SwitchOffAtomic special_item
endscript
*/

