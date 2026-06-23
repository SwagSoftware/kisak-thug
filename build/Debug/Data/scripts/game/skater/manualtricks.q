
// The special manual trick array and it's trick slots

MANUAL_DISPLAY_WAIT=25	// number of frames we wait before displaying (awarding) a manual trick - currently as long as half the manual init
ROTATEY_TRIGGER_TIME=300 //amount in millseconds we look backwards for an R2 press to satisfy a spinning manual
TRIGGER_MANUAL_BRANCHFLIP = {InOrder,a=Square,b=Square,200}
SpecialManualTricks=
[
	//{Trigger={TripleInorder,Up,a=Triangle,b=Triangle,700} Duration=1000  	Trick_Pogo}
	//{Trigger={TripleInorder,Up,a=Circle,b=Circle,700} Duration=1000  	Trick_Handstand}
	{Trigger={TripleInOrder,Up,Right,Triangle,400}	Duration=700  	TrickSlot=SpMan_U_R_Triangle }
	{Trigger={TripleInOrder,Up,Down,Triangle,400}	Duration=700  	TrickSlot=SpMan_U_D_Triangle }
	{Trigger={TripleInOrder,Up,Left,Triangle,400}	Duration=700  	TrickSlot=SpMan_U_L_Triangle }
	{Trigger={TripleInOrder,Right,Up,Triangle,400}	Duration=700  	TrickSlot=SpMan_R_U_Triangle }
	{Trigger={TripleInOrder,Right,Down,Triangle,400} Duration=700   TrickSlot=SpMan_R_D_Triangle }
	{Trigger={TripleInOrder,Right,Left,Triangle,400} Duration=700   TrickSlot=SpMan_R_L_Triangle }
	{Trigger={TripleInOrder,Down,Up,Triangle,400}	Duration=700  	TrickSlot=SpMan_D_U_Triangle }
	{Trigger={TripleInOrder,Down,Right,Triangle,400} Duration=700   TrickSlot=SpMan_D_R_Triangle }
	{Trigger={TripleInOrder,Down,Left,Triangle,400}	Duration=700  	TrickSlot=SpMan_D_L_Triangle }
	{Trigger={TripleInOrder,Left,Up,Triangle,400}	Duration=700  	TrickSlot=SpMan_L_U_Triangle }
	{Trigger={TripleInOrder,Left,Right,Triangle,400} Duration=700   TrickSlot=SpMan_L_R_Triangle }
	{Trigger={TripleInOrder,Left,Down,Triangle,400}	Duration=700  	TrickSlot=SpMan_L_D_Triangle }

	//	{Trigger={InOrder,Up,Down,700}           Scr=Manual Params={Name='Manual' 		Score=100 InitAnim=Manual 		FromAirAnim=ManualFromAir		BalanceAnim=Manual_Range 				OffMeterTop=ManualBail OffMeterBottom=ManualLand } }
	//    {Trigger={InOrder,Down,Up,700}           Scr=Manual Params={Name='Nose Manual' Score=100 InitAnim=Nosemanual 	FromAirAnim=NoseManualFromAir	BalanceAnim=NoseManual_Range Nollie OffMeterTop=ManualLand OffMeterBottom=NoseManualBail } }
]

// Special Manual Trick Definitions



// THUG Specials
Trick_SlamSpinner = {Scr=Manual Params={Name='Slam Spinner' Score=3500 InitAnim=SlamSpinner FromWalkAnim=SlamSpinner FromAirAnim=SlamSpinner BalanceAnim=Manual_Range OffMeterTop=ManualLand OffMeterBottom=ManualBail ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches IsSpecial ExtraWaitPercent=40  } }
Trick_YeahRight = {Scr=Manual Params={Name='Yeah Right' Score=3100 InitAnim=YeahRight_Init FromWalkAnim=YeahRight_init FromAirAnim=YeahRight_init balanceIdle=yeahright_idle OffMeterTop=ManualBail OffMeterBottom=ManualBail ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches OutAnim=YeahRight_Out IsSpecial ExtraWaitPercent=40 OutAnimOnOllie specialitem_details=extraboard_details } }



// Not Finished
Trick_HeadStandManual = {Scr=Manual Params={Name='Head Balancer' Score=3100 InitAnim=HeadStandManual_Init FromAirAnim=HeadStandManual_init balanceAnim=HeadStandManual_range OffMeterTop=ManualBail OffMeterBottom=ManualBail ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches OutAnim=HeadStandManual_Out IsSpecial ExtraWaitPercent=40  } }
Trick_MixItUp = {Scr=Manual Params={Name='Mix It Up' Score=3000 InitAnim=MixItUp_Init FromAirAnim=MixItUp_init balanceidle=MixItUp_Idle Speed=1.2 OffMeterTop=ManualBail OffMeterBottom=ManualBail ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches OutAnim=MixItUp_Out OutAnimOnOllie IsSpecial ExtraWaitPercent=40 } }
Trick_KickflipSwitch = {Scr=Manual Params={Name='Flip 2 Switch' Score=3000 InitAnim=KickflipSwitchOnefootManual_Init FromAirAnim=KickflipSwitchOnefootManual_init balanceanim=KickflipSwitchOnefootManual_range OffMeterTop=ManualBail OffMeterBottom=ManualBail ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches OutAnim=KickflipSwitchOnefootManual_Out OutAnimOnOllie IsSpecial FlipAfter ExtraWaitPercent=30 } }
Trick_MuskaManual = {Scr=Manual Params={Name='Muska Manual' Score=3100 InitAnim=MuskaManual_Init FromAirAnim=MuskaManual_Init Stream=GhettoBlastin balanceidle=MuskaManual_Idle OffMeterTop=ManualBail OffMeterBottom=ManualBail ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches OutAnim=MuskaManual_Out OutAnimOnOllie IsSpecial ExtraWaitPercent=40 specialitem_details=boombox_details } }
//Trick_PogoHandstand = {Scr=Manual Params={Name='Pogo Handstand' Score=1500 InitAnim=PogoHandstand_Init FromAirAnim=PogoHandstand_init balanceidle=PogoHandstand_idle OffMeterTop=ManualBail OffMeterBottom=ManualBail ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches OutAnim=PogoHandstand_Out OutAnimOnOllie IsSpecial ExtraWaitPercent=40 } }
Trick_HandStandCasper = {Scr=Manual Params={Name='Casper Handstand' Score=2250 InitAnim=HandstandCasper_Init FromAirAnim=HandstandCasper_init balanceAnim=HandstandCasper_range OffMeterTop=ManualBail OffMeterBottom=ManualBail ExtraTricks=HandstandBranches OutAnim=HandstandCasper_Out OutAnimOnOllie IsSpecial ExtraWaitPercent=40 } }
Trick_Scanning = {Scr=Manual Params={Name='The Scanner' Skater=Iron_Man Score=3000 InitAnim=Scanning_Init FullScreenEffect=IronManEffect FromAirAnim=Scanning_init balanceIdle=Scanning_Idle OffMeterTop=ManualBail OffMeterBottom=ManualBail ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches OutAnim=Scanning_Out OutAnimOnOllie IsSpecial ExtraWaitPercent=40 } }


Trick_HoHoStreetPlant = {Scr=Manual Params={Name='Ho Ho Street Plant' Score=2750 InitAnim=HoHoStreetPlant_init FromAirAnim=HoHoStreetPlant_init BalanceIdle=HoHoStreetPlant_idle  OutAnim=HoHoStreetPlant_out OutAnimOnOllie OffMeterTop=NoseManualBail OffMeterBottom=NoseManualBail ExtraTricks=FlatLandBranches IsSpecial FlipAfter NoBlend} }
Trick_NoComplyLate360 = {Scr=Manual Params={Name='No Comply 360 Shove-It' Score=2400 InitAnim=NoComplyLate360 FromAirAnim=NoComplyLate360 BalanceAnim=Manual_Range OffMeterTop=ManualBail OffMeterBottom=ManualLand ExtraTricks=ManualBranches IsSpecial NoBlend ExtraTricks=FlatLandBranches ExtraWaitPercent=40} }
Trick_RustySlide = {Scr=Manual Params={Name='Rusty Slide Manual' Score=2300 InitAnim=RustySlide_Init FromAirAnim=RustySlide_Init BalanceAnim=Primo_Range OutAnim=RustySlide_out OffMeterTop=NoseManualBail OffMeterBottom=ManualBail Friction=0.5 IsSpecial BoardRotate ExtraTricks=FlatlandBranches ExtraTricks2=ToRail_Branches FlipGraphic NoBlend} }

Trick_Sproing = {Scr=Manual Params={Name='Sproing' Score=3150 InitAnim=Sproing FromAirAnim=Sproing BalanceAnim=Manual_Range OffMeterTop=ManualBail OffMeterBottom=ManualLand ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches IsSpecial SproingFlip ExtraWaitPercent=40 } }
Trick_ReemoSlide = {Scr=Manual Params={Name='Reemo Slide' Score=3200 InitAnim=ReemoSlide_Init FromAirAnim=ReemoSlide_Init BalanceAnim=ReemoSlide_Range OutAnim=ReemoSlide_out OffMeterTop=NoseManualBail OffMeterBottom=ManualBail Friction=1 IsSpecial BoardRotate ExtraTricks=FlatlandBranches} }
Trick_PrimoSlide = {Scr=Manual Params={Name='Primo' Score=2500 InitAnim=Primo_Init FromAirAnim=Primo_Init BalanceAnim=Primo_Range OutAnim=Primo_out OffMeterTop=NoseManualBail OffMeterBottom=ManualBail Friction=0.35 IsSpecial ExtraTricks=FlatlandBranches ExtraTricks2=ToRail_Branches} }
Trick_OneFootOneWheel = {Scr=Manual Params={Name='One Wheel Nosemanual' Score=2325 InitAnim=OneFootOneWheel_Init FromAirAnim=OneFootOneWheel_Init BalanceAnim=OneFootOneWheel_Range OutAnim=OneFootOneWheel_Init OffMeterTop=ManualLand OffMeterBottom=NoseManualBail Friction=0.35 IsSpecial Nollie ExtraTricks2=NoseManualBranches ExtraTricks=FlatLandBranches PutDownAnim=PutDownOneWheel} }
Trick_DanceParty = {Scr=Manual Params={Name='Ahhh yeahhh!' Score=4000 InitAnim=DanceParty_Init FromAirAnim=DanceParty_Init BalanceIdle=DanceParty_Idle OffMeterTop=ManualBail OffMeterBottom=NoseManualBail Friction=20 IsSpecial  ExtraTricks=FlatlandBranches } }

//RETIRED TRICKS
//Trick_ClawDrag = {Scr=Manual Params={Name='The Claw Drag' UnlockFlag=SKATER_UNLOCKED_WOLVERINE OnlyWith=Wolverine Score=1000 Sparks InitAnim=Clawdrag_Init FromAirAnim=Clawdrag_Init BalanceIdle=Clawdrag_Idle OffMeterTop=ManualBail OffMeterBottom=NoseManualBail IsSpecial ExtraTricks=FlatlandBranches } }
//Trick_ZZZZManual = {Scr=Manual Params={Name='ZZZZ Manual' UnlockFlag=SKATER_UNLOCKED_BUM Score=1400 InitAnim=ZZZZManual_init FromAirAnim=ZZZZManual_init BalanceIdle=ZZZZManual_idle OffMeterTop=ManualBail OffMeterBottom=NoseManualBail Friction=0.5 IsSpecial  ExtraTricks=FlatlandBranches } }
//Trick_NinjaManual = {Scr=Manual Params={Name='Sith Saber Spin' UnlockFlag=SKATER_UNLOCKED_MAUL OnlyWith=Maul Score=1400 FlipFrame=24 InitAnim=MaulNinjaManual_Init FromAirAnim=MaulNinjaManual_Init BalanceIdle=MaulNinjaManual_Idle OffMeterTop=ManualBail OffMeterBottom=NoseManualBail Friction=0.5 IsSpecial BlendPeriod=0.0 ExtraTricks=FlatlandBranches } }
//Trick_VisitingHome = {Scr=Manual Params={Name='Visiting Home' Score=2000 UnlockFlag=SKATER_UNLOCKED_DEMONESS OnlyWith=Demoness InitAnim=VisitingHome_Init FromAirAnim=VisitingHome_Init BalanceIdle=VisitingHome_Idle OutAnim=VisitingHome_Out OffMeterTop=NoseManualBail OffMeterBottom=NoseManualBail IsSpecial WaitOnOlliePercent=1} }
//Trick_DuckDive = {Scr=Manual Params={Name='Duck Dive Shark Attack' UnlockFlag=SKATER_UNLOCKED_SLATER Score=1400 InitAnim=DuckDive_Init FromAirAnim=DuckDive_Init BalanceIdle=DuckDive_Idle OutAnim=DuckDive_Out OffMeterTop=ManualBail OffMeterBottom=NoseManualBail IsSpecial  WaitOnOlliePercent=0} }
//Trick_WorkForFoodManual = {Scr=Manual Params={Name='Can Ya Spare a Dime?' UnlockFlag=SKATER_UNLOCKED_BUM OnlyWith=Ollie Score=1500 InitAnim=WorkForFood_Init FromAirAnim=WorkForFood_Init BalanceIdle=WorkForFood_Idle OffMeterTop=ManualBail OffMeterBottom=NoseManualBail Friction=0.5 IsSpecial ExtraTricks=FlatlandBranches } }
//Trick_4thofJuly = {Scr=Manual Params={Name='One Wheel Fireworks Show' Score=1500 InitAnim=_4thofJuly_init FromAirAnim=_4thofJuly_init BalanceIdle=_4thofJuly_idle OffMeterTop=ManualBail OffMeterBottom=ManualLand ExtraTricks2=ManualBranches ExtraTricks=FlatLandBranches IsSpecial CheckCheese SpawnScript=Fireworks } }
//Trick_HandstandDoubleFlip = {Scr=Manual Params={Name='HandStand Double Flip' Score=1400 InitAnim=HandstandHandFlip_Init FromAirAnim=HandstandHandFlip_Init BalanceAnim=HandstandHandFlip_Range OutAnim=HandStandDoubleFlip OffMeterTop=NoseManualBail OffMeterBottom=ManualBail Friction=0.5 IsSpecial WaitOnOlliePercent=40 ExtraTricks=FlatlandBranches ExtraTricks2=HandstandBranches} }
//Trick_LazyAss = {Scr=Manual Params={Name='Lazy Ass Manual' Score=1500 InitAnim=LazyAss_Init FromAirAnim=LazyAss_Init BalanceIdle=LazyAss_Idle OutAnim=LazyAss_Out OffMeterTop=ManualBail OffMeterBottom=NoseManualBail Friction=0.5 IsSpecial WaitOnOlliePercent=10 ExtraTricks=FlatlandBranches  } }
//Trick_SplitsManual = {Scr=Manual Params={Name='Banana Board Splits' Score=1500 skater=jenna InitAnim=SplitsManual_init FromAirAnim=SplitsManual_init BalanceIdle=SplitsManual_idle  OutAnim=SplitsManual_out OutAnimOnOllie OffMeterTop=NoseManualBail OffMeterBottom=ManualBail ExtraTricks=FlatLandBranches IsSpecial spawnscript=yeahrightslide} }
//Trick_HandStand50Flip = {Scr=Manual Params={Name='HandStand 360 Hand Flip' Score=1400 InitAnim=HandStand50Flip_Init FromAirAnim=HandStand50Flip_Init BalanceAnim=HandStand50Flip_Range OutAnim=HandStand50Flip_Out OffMeterTop=ManualBail OffMeterBottom=NoseManualBail Friction=0.5 IsSpecial WaitOnOlliePercent=20 ExtraTricks=FlatlandBranches } }

// The regular triggers for standard manuals

AIR_MANUAL_DURATION = 1000
AIR_MANUAL_TIMING = 400

ManualTricks=
[
	/*	{Trigger={TripleInOrderSloppy,UpLeft,a=Triangle,b=Triangle,AIR_MANUAL_TIMING}		Duration=AIR_MANUAL_DURATION Trick_Pogo }
	{Trigger={TripleInOrderSloppy,UpRight,a=Triangle,b=Triangle,AIR_MANUAL_TIMING}		Duration=AIR_MANUAL_DURATION Trick_HandStand }
	{Trigger={TripleInOrderSloppy,DownRight,a=Triangle,b=Triangle,AIR_MANUAL_TIMING}	Duration=AIR_MANUAL_DURATION Trick_Truckstand }
	{Trigger={TripleInOrderSloppy,DownLeft,a=Triangle,b=Triangle,AIR_MANUAL_TIMING}		Duration=AIR_MANUAL_DURATION Trick_Casper }
	{Trigger={TripleInOrderSloppy,Left,a=Triangle,b=Triangle,AIR_MANUAL_TIMING}			Duration=AIR_MANUAL_DURATION Trick_AntiCasper }
	{Trigger={TripleInOrderSloppy,Right,a=Triangle,b=Triangle,AIR_MANUAL_TIMING}		Duration=AIR_MANUAL_DURATION Trick_ToRail }
	{Trigger={TripleInOrderSloppy,Up,a=Triangle,b=Triangle,AIR_MANUAL_TIMING}			Duration=AIR_MANUAL_DURATION Trick_SwitchFootPogo }
	{Trigger={TripleInOrderSloppy,Down,a=Triangle,b=Triangle,AIR_MANUAL_TIMING}	   	 	Duration=AIR_MANUAL_DURATION Trick_OneFootManual }
*/
	{Trigger={InOrder,Up,Down,400} Duration=700						Trick_Manual  }
	{Trigger={InOrder,Down,Up,400} Duration=700  					Trick_NoseManual}
]

/*
AirManualTricks=
[
	{Trigger={InOrder,Up,Down,400} Duration=700		Scr=AirManual  }
    {Trigger={InOrder,Down,Up,400} Duration=700  	Scr=AirManual Params={NoseManual}}
]
*/


GroundManualTricks=
[
	// Special array with tighter triggering for when you are on the ground
	{Trigger={InOrder,Up,Down,220}		Trick_Manual }
	{Trigger={InOrder,Down,Up,220}		Trick_NoseManual }
]

// Standard manual definitions
Trick_Manual = {Scr=Manual Params={Name='Manual' Score=100 InitAnim=Manual FromAirAnim=ManualFromAir FromWalkAnim=JumpAirToManual BalanceAnim=Manual_Range BalanceAnim2=Manual_Range2 BalanceAnim3=Manual_Range3 OffMeterTop=ManualLand OffMeterBottom=ManualBail  ExtraTricks2=ManualBranches ExtraTricks=FlatlandBranches CheckCheese AllowWallpush}}
Trick_NoseManual = {Scr=Manual Params={Name='Nose Manual' Score=100 InitAnim=Nosemanual FromAirAnim=NoseManualFromAir FromWalkAnim=JumpAirToNoseManual BalanceAnim=NoseManual_Range BalanceAnim2=NoseManual_Range2 Nollie OffMeterTop=NoseManualBail OffMeterBottom=ManualLand  ExtraTricks2=NoseManualBranches ExtraTricks=FlatlandBranches CheckCheese AllowWallpush}}

Trick_OneFootNosemanual = {Scr=Manual Params={Name='One Foot Nose Manual' Score=1050 InitAnim=OneFootNosemanual_Init FromAirAnim=OneFootNosemanual_Init BalanceAnim=OneFootNoseManual_Range Nollie OffMeterTop=NoseManualBail OffMeterBottom=ManualLand  IsExtra ExtraTricks=NoseManualBranches ExtraTricks2=FlatlandBranches}}
Trick_OneFootManual = {Scr=Manual Params={Name='One Foot Manual' Score=1050 InitAnim=OneFootManual_init FromAirAnim=OneFootManual_init BalanceAnim=OneFootManual_Range OffMeterTop=ManualLand  OffMeterBottom=ManualBail ExtraTricks=ManualBranches ExtraTricks2=FlatlandBranches IsExtra}}

//SpacewalkFromManual Spacewalk SpacewalkToManual

Trick_Spacewalk = {Scr=Manual Params={Name='Spacewalk' Score=1200 InitAnim=Manual FromAirAnim=ManualFromAir FromWalkAnim=JumpAirToManual BalanceIdle=Spacewalk OffMeterTop=ManualLand OffMeterBottom=ManualBail  ExtraTricks2=ManualBranches ExtraTricks=FlatlandBranches AllowWallpush ExtraSpeedBoost=250}}

Trick_Handstand = {Scr=Manual Params={Name='HandStand' Score=1100 InitAnim=HandstandHandFlip_Init FromAirAnim=HandstandHandFlip_Init BalanceAnim=HandstandHandFlip_Range OutAnim=HandstandHandFlip_out OffMeterTop=ManualLand OffMeterBottom=ManualBail Friction=0.5 WaitOnOlliePercent=10 ExtraTricks=FlatlandBranches ExtraTricks2=HandstandBranches} }
Trick_Casper = {Scr=Manual Params={Name='Casper' Score=1100 InitAnim=Casper_Init FromAirAnim=Casper_Init BalanceAnim=Casper_Range OutAnim=Casper_out OffMeterTop=ManualLand OffMeterBottom=NoseManualBail Friction=0.5 BoardRotate ExtraTricks=FlatlandBranches ExtraTricks2=CasperBranches} }
Trick_AntiCasper = {Scr=Manual Params={Name='Anti Casper' Score=1100 InitAnim=AntiCasper_Init FromAirAnim=AntiCasper_Init BalanceAnim=AntiCasper_Range OutAnim=AntiCasper_out OffMeterTop=ManualBail OffMeterBottom=ManualLand Friction=0.5 BoardRotate Nollie ExtraTricks=FlatlandBranches ExtraTricks2=AntiCasperBranches} }
Trick_Truckstand = {Scr=Manual Params={Name='Truckstand' Score=800 InitAnim=Truckstand_Init FromAirAnim=Truckstand_Init BalanceAnim=Truckstand_Range OutAnim=Truckstand_Out OffMeterTop=ManualLand OffMeterBottom=ManualBail Friction=1.5 ExtraTricks=FlatlandBranches ExtraTricks2=TruckstandBranches} }
Trick_SwitchFootPogo = {Scr=Manual Params={Name='Switch Foot Pogo' Score=800 InitAnim=Truckrun_Init FromAirAnim=Truckrun_Init BalanceIdle=TruckRun OutAnim=Truckrun_Out OffMeterTop=ManualLand OffMeterBottom=ManualBail Friction=1 ExtraTricks=FlatlandBranches ExtraTricks2=SwitchFootPogo_Branches} }
Trick_Pogo = {Scr=Manual Params={Name='Pogo' Score=750 InitAnim=Pogo_Init FromAirAnim=Pogo_Init BalanceIdle=Pogo_Bounce OutAnim=Pogo_Out OutSpeed=1.5 OffMeterTop=ManualLand OffMeterBottom=ManualBail Friction=1.5 ExtraTricks=FlatlandBranches BoardRotate ExtraTricks2=PogoBranches BounceBoobs} }
Trick_ToRail = {Scr=Manual Params={Name='To Rail' Score=1050 InitAnim=Primo_Init FromAirAnim=Primo_Init BalanceAnim=Primo_Range OutAnim=Primo_out OffMeterTop=NoseManualBail OffMeterBottom=ManualLand Friction=1.0 ExtraTricks=FlatlandBranches Extratricks2=ToRail_Branches IsExtra} }

// Extra tricks for manuals
Trick_Gturn = { Scr=ManualLink Params={Name='Nose Pivot' Score=250 Anim=GTurn BalanceAnim=Manual FlipAfter BalanceAnim=Manual_Range Trickslack=0 PlayCessSound extrapercent=100 ExtraTricks=FlatlandBranches ExtraTricks2=ManualBranches  TimeAdd = 1 SpeedMult = 1.0 OffMeterTop=ManualBail OffMeterBottom=ManualLand AllowWallpush} }
Trick_Gturn2 = {Scr=ManualLink Params={Name='Pivot' Score=250 Anim=GTurn2 BalanceAnim=Manual FlipAfter BalanceAnim=NoseManual_Range Trickslack=0 PlayCessSound extrapercent=100 ExtraTricks=FlatlandBranches ExtraTricks2=NoseManualBranches Nollie  TimeAdd = 1 SpeedMult = 1.0 OffMeterTop=ManualLand OffMeterBottom=NoseManualBail AllowWallpush} }

Trick_HalfCabImpossible = {Scr=ManualLink Params={Name='Half Cab Impossible' Score=750 Anim=HalfCabImpossible BalanceAnim=Manual FlipAfter BoardFlipAfter BalanceAnim=Manual_Range Trickslack=0 extrapercent=100 ExtraTricks=FlatlandBranches ExtraTricks2=ManualBranches  TimeAdd = 0 SpeedMult = 1.0 OffMeterTop=ManualBail IsExtra OffMeterBottom=ManualLand} }

Trick_360FlipNoseManual = {Scr=ManualLink Params={Name='360 Fingerflip' Score=750 Anim=_360FlipNosemanual BalanceAnim=NoseManual BalanceAnim=NoseManual_Range Trickslack=0 extrapercent=100 ExtraTricks=FlatlandBranches ExtraTricks2=NoseManualBranches  TimeAdd = 0 SpeedMult = 1.0 OffMeterTop=ManualLand OffMeterBottom=NoseManualBail} }


//Extra branch tricks for flatland combos
Trick_PogoFlip = { Scr=ManualLink Params={Name='Wrap Around' Score=500 Anim=Pogo_Kickfoot BalanceIdle=Pogo_Bounce speed=1.5 OutAnim=Pogo_Out OutSpeed=1.5 Extratricks=FlatLandBranches Extratricks2=PogoBranches Parent='Pogo' ExtraPercent=100 Trickslack=0 IsExtra } }

SwitchFootPogo_Branches =
[  	{Trigger=TRIGGER_MANUAL_BRANCHFLIP  		Scr=ManualLink Params={Name='Half Wrap Truck Transfer' Score=500 Anim=TruckRunFlip BalanceIdle=TruckRun Extratricks=FlatLandBranches ExtraTricks2=SwitchFootPogo_Branches Parent='Switch Foot Pogo' BoardFlipAfter ExtraPercent=100 Trickslack=0 IsExtra } }
	{Trigger={Press,R2,ROTATEY_TRIGGER_TIME}  	Scr=SwitchFootPogo_Setup Params={Name='Switch Foot Pogo Spin' } NGC_Trigger={Press,R1,ROTATEY_TRIGGER_TIME}}
	{Trigger={Press,L2,ROTATEY_TRIGGER_TIME}  	Scr=SwitchFootPogo_Setup Params={Name='Switch Foot Pogo Spin' spin_with_L2=1} NGC_Trigger={Press,L1,ROTATEY_TRIGGER_TIME}}
]

script SwitchFootPogo_Setup
	Manuallink Name='Switch Foot Pogo Spin' Score=100 RotateY BalanceIdle=TruckRun OutAnim=Truckrun_Out ExtraTricks=FlatlandBranches Extratricks2=SwitchFootPogo_Branches Parent='Switch Foot Pogo' Trickslack=0 IsExtra spin_with_L2=<spin_with_L2>
endscript

ToRail_Branches =
[  	{Trigger=TRIGGER_MANUAL_BRANCHFLIP  	Scr=ManualLink Params={Name='Rail Flip' Score=500 Anim=RailFlip BalanceAnim=Primo_range Extratricks=FlatLandBranches Extratricks2=ToRail_Branches Parent='To Rail' Trickslack=0 ExtraPercent=100 IsExtra } }]

CasperBranches =
[  	{Trigger=TRIGGER_MANUAL_BRANCHFLIP  		Scr=ManualLink Params={Name='Casper Flip' Score=500 Extrapercent=100 Anim=CasperFlip speed=.85 BalanceAnim=Casper_range OutAnim=Casper_out Extratricks=FlatLandBranches BoardFlipAfter Extratricks2=CasperBranches Parent='Casper' Trickslack=0 BoardRotate=1 ExtraPercent=100 IsExtra} }
	{Trigger={Press,R2,ROTATEY_TRIGGER_TIME}  	Scr=CasperSpin_Setup Params={Name='Casper Spin' } NGC_Trigger={Press,R1,ROTATEY_TRIGGER_TIME}}
	{Trigger={Press,L2,ROTATEY_TRIGGER_TIME}  	Scr=CasperSpin_Setup Params={spin_with_L2=1 Name='Casper Spin' } NGC_Trigger={Press,R1,ROTATEY_TRIGGER_TIME}}
]

script CasperSpin_Setup
	ManualLink Name='Casper Spin' Score=100 RotateY BalanceAnim=Casper_range OutAnim=Casper_out Extratricks=FlatLandBranches Extratricks2=CasperBranches Parent='Casper'  Trickslack=0 BoardRotate=1 IsExtra spin_with_L2=<spin_with_L2>
endscript

AntiCasperBranches =
[  	{Trigger=TRIGGER_MANUAL_BRANCHFLIP  		Scr=ManualLink Params={Name='Anti Casper Flip' Score=500 Extrapercent=100 Anim=AntiCasperFlip Speed=.7 BalanceAnim=AntiCasper_range OutAnim=AntiCasper_out Extratricks=FlatLandBranches Extratricks2=AntiCasperBranches Parent='Anti Casper' ExtraPercent=100 Trickslack=0 BoardRotate=1 IsExtra} }
	{Trigger={Press,R2,ROTATEY_TRIGGER_TIME}  	Scr=AntiCasperSpin_Setup Params={Name='Anti Casper Spin' } NGC_Trigger={Press,R1,ROTATEY_TRIGGER_TIME}}
	{Trigger={Press,L2,ROTATEY_TRIGGER_TIME}  	Scr=AntiCasperSpin_Setup Params={spin_with_L2=1 Name='Anti Casper Spin' } NGC_Trigger={Press,R1,ROTATEY_TRIGGER_TIME}}
]

script AntiCasperSpin_Setup
	ManualLink Name='Anti Casper Spin' Score=100 RotateY BalanceAnim=AntiCasper_range OutAnim=AntiCasper_out Extratricks=FlatLandBranches Extratricks2=AntiCasperBranches Parent='Anti Casper' Trickslack=0 BoardRotate=1 IsExtra spin_with_L2=<spin_with_L2>
endscript


TruckstandBranches =
[  	{Trigger=TRIGGER_MANUAL_BRANCHFLIP  				Scr=ManualLink Params={Name='Truckstand Flip' Score=500 Anim=Truckstand_Flip BalanceAnim=Truckstand_range OutAnim=Truckstand_Out ExtraTricks=FlatlandBranches Extratricks2=TruckStandBranches Parent='TruckStand' ExtraPercent=100 Trickslack=0 IsExtra } }
	{Trigger={Inorder,a=Circle,b=Circle,400}  			Scr=ManualLink Params={Name='Pogo to Hair Flip' Score=1500 Anim=Sweet BalanceAnim=Truckstand_range OutAnim=Truckstand_Out ExtraTricks2=FlatlandBranches Extratricks=TruckStandBranches Parent='TruckStand' Trickslack=0 IsExtra } }
	{Trigger={Press,R2,ROTATEY_TRIGGER_TIME}  			Scr=TruckSpin_Setup Params={Name='TruckSpin'  }  NGC_Trigger={Press,R1,ROTATEY_TRIGGER_TIME}}
	{Trigger={Press,L2,ROTATEY_TRIGGER_TIME}  			Scr=TruckSpin_Setup Params= {spin_with_L2=1 Name='TruckSpin' } NGC_Trigger={Press,R1,ROTATEY_TRIGGER_TIME}}
]

script TruckSpin_Setup
	ManualLink Name='TruckSpin' Score=100 RotateY BalanceAnim=Truckstand_range OutAnim=Truckstand_Out ExtraTricks=FlatlandBranches Extratricks2=TruckStandBranches Parent='TruckStand' Trickslack=0 IsExtra spin_with_L2=<spin_with_L2>
endscript

HandstandBranches =
[  	{Trigger=TRIGGER_MANUAL_BRANCHFLIP  Scr=ManualLink Params={Name='Handflip' Score=500 Anim=HStandFliptoHStand BalanceAnim=HandstandHandFlip_Range OutAnim=HandstandHandFlip_out ExtraTricks=FlatlandBranches Extratricks2=HandStandBranches Parent='HandStand' ExtraPercent=100 Trickslack=0 IsExtra } }]


FlatLandBranches =
[
	{Trigger={InOrder,square,circle,300}  			Trick_AntiCasper}
	{Trigger={InOrder,square,circle,300}  			Trick_NoseManual}
	{Trigger={InOrder,square,Triangle,300}  		Trick_Casper}
	{Trigger={InOrder,square,Triangle,300}  		Trick_Manual}
	{Trigger={InOrder,circle,square,300}  			Trick_ToRail}
	{Trigger={InOrder,circle,square,300}  			Trick_Manual}
	{Trigger={InOrder,circle,triangle,300} 			Trick_OneFootManual }
	{Trigger={InOrder,circle,triangle,300} 			Trick_OneFootNosemanual }
	{Trigger={TripleInOrder,left,right,Square, 500} Trick_Spacewalk}
	{Trigger={InOrder,a=circle,b=circle,300} 		Trick_Handstand}
	{Trigger={InOrder,a=triangle,b=triangle, 300} 	Trick_Pogo}
	{Trigger={InOrder,a=triangle,b=triangle, 300} 	Trick_Manual }
	{Trigger={InOrder,triangle,square,300} 			Trick_Truckstand}
	{Trigger={InOrder,triangle,square,300} 			Trick_ Manual}
	{Trigger={InOrder,triangle,circle,300}  		Trick_SwitchFootPogo}
	{Trigger={InOrder,triangle,circle,300}  		Trick_Manual}
	{Trigger={InOrder,a=circle,b=circle,300} 		Trick_Manual}
]

script PogoSpin_Setup
	ManualLink Name='Pogo Spin' Score=100 RotateY BalanceIdle=Pogo_Bounce OutAnim=Pogo_Out ExtraTricks=FlatlandBranches Extratricks2=PogoBranches Parent='Pogo' Trickslack=0 IsExtra spin_with_L2=<spin_with_L2>
endscript

PogoBranches =
[
	{Trigger=TRIGGER_MANUAL_BRANCHFLIP    		Trick_PogoFlip }
	{Trigger={Press,R2,ROTATEY_TRIGGER_TIME}  	Scr=PogoSpin_Setup Params= {Name='Pogo Spin' } NGC_Trigger={Press,R1,ROTATEY_TRIGGER_TIME}}
	{Trigger={Press,L2,ROTATEY_TRIGGER_TIME}  	Scr=PogoSpin_Setup Params= {spin_with_L2=1 Name='Pogo Spin' } NGC_Trigger={Press,R1,ROTATEY_TRIGGER_TIME}}
]

NoseManualBranches =
[		{Trigger={Press,R2,200}                     	Trick_Gturn		NGC_Trigger={Press,R1,200}}
	{Trigger=TRIGGER_MANUAL_BRANCHFLIP 				Trick_HalfCabImpossible }
	{Trigger={InOrder,circle,triangle,300} 			Trick_OneFootNosemanual }
]

ManualBranches =
[		{Trigger={Press,R2,200}  						Trick_Gturn2	NGC_Trigger={Press,R1,200}}
	{Trigger=TRIGGER_MANUAL_BRANCHFLIP 				Trick_360FlipNoseManual }
	{Trigger={InOrder,circle,triangle,300} 			Trick_OneFootManual }
]

////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////

// @script | WalkAir_Manual | When a manual trick is done while walking, the script comes here first.
Script WalkAir_Manual
	InAirExceptions

	RemoveParameter FromWalk
	SetException Ex=Landed Scr=Manual Params={ SkipInitAnim <...> }

	KillExtraTricks
	ClearTrickQueue
	SetQueueTricks NoTricks

	if GotParam FromWalkAnim
		PlayAnim Anim=<FromWalkAnim>
	else
		if GotParam Nollie
			PlayAnim Anim=JumpAirToNoseManual
		else
			PlayAnim Anim=JumpAirToManual
		endif
	endif
	Block
endscript

script Manual BlendPeriod=0.3 Speed=1.0
	if GotParam FromWalk
		// When coming from walking, wait for the skater to land before going into the manual trick.
		Goto WalkAir_Manual Params={ <...> }
	endif
	KillExtraTricks
	//printstruct <...>
	SetTrickName ""
	SetTrickScore 0
	Display Blockspin
	If LandedFromVert
		Goto Land
	endif
	ClearLipCombos   // If we come out of a lip trick we want to make sure this is turned off
	ClearExceptions
	ResetLandedFromVert

	SetException Ex=GroundGone          	Scr=GroundGone Params={NoBoneless}
	SetEventHandler Ex=MadeOtherSkaterBail	Scr=MadeOtherSkaterBail_Called
	If GotParam	Nollie
		SetException Ex=Ollied          Scr=NollieNoDisplay Params={<...>}
		NollieOn
	else
		NollieOff
		SetException Ex=Ollied          Scr=Ollie Params={<...>}
	endif
	SetException Ex=FlailHitWall        Scr=FlailHitWall
	SetException Ex=FlailLeft           Scr=FlailLeft
	SetException Ex=FlailRight          Scr=FlailRight
	SetException Ex=OffMeterTop			Scr=<OffMeterBottom> Params={<...>}
	SetException Ex=OffMeterBottom		Scr=<OffMeterTop>  Params={<...>}
	SetException Ex=Carplant			Scr=CarPlant
	SetException Ex=CarBail				Scr=CarBail
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	SetException Ex=Skitched            Scr=Skitch    // allowing transition from manual to skitch
	OnExceptionRun CheckForNewTrick_ManualOut
	LaunchStateChangeEvent State=Skater_InManual
	// Clear out any grabtricks
	ClearTrickQueue
	If not GetGlobalFlag Flag=FLAG_EXPERT_MODE_NO_WALKING
		if not ((inNetGame) && (GetGlobalFlag flag=FLAG_G_EXPERT_MODE_NO_WALKING))
			SetQueueTricks SkateToWalkTricks
		else
			SetQueueTricks NoTricks
		endif
	else
		SetQueueTricks NoTricks
	endif

	if GotParam AllowWallpush
		if GotParam Nollie
			SetException Ex=WallPush	Scr=Manual_Wallpush
		else
			SetException Ex=WallPush	Scr=Manual_Wallpush		Params={ ToNoseManual }
		endif
	else
		SetEventHandler Ex=WallPush		Scr=Manual_CancelWallpushEvent
	endif


	SpawnClothingLandScriptHalfMax // when we start a manual link trick, wobble the boobs at 50% of the max

	; If re-entering this script by doing a special manual out of the initial manual, then don't
	; check for special manuals again, otherwise the yellow text will get cancelled and it will be possible
	; to special-manual out of the special-manual making it glitch.
	if gotparam isspecial
		SetManualTricks NoTricks
	else
		if gotparam isextra
			SetManualTricks NoTricks
		else
			If (EXPERT_MODE_NO_MANUALS = 0)
				SetManualTricks NoTricks Special=SpecialManualTricks
			else
				SetManualTricks NoTricks
			endif
		endif
	endif

	if GotParam SpecialItem_details
		TurnOnSpecialItem SpecialItem_details=<SpecialItem_details>
	endif

	StartBalanceTrick           ; Mick .. added this so code think you are in a manual for the "init" animation

	If not IsNGC
		Vibrate Actuator=1 Percent=25
		OnexitRun KillManualVibration
	endif

	if GotParam FullScreenEffect
		<FullScreenEffect>
		OnExitRun Exit_FullScreenEffect
	endif

	if GotParam Stream
		Obj_PlayStream <stream> //vol=250
	endif

	If GotParam Friction
		SetRollingFriction <friction>
	else
		SetRollingFriction default
	endif
	If GotParam IsSpecial
		If GotParam Nollie
			DoBalanceTrick ButtonA=Up ButtonB=Down Type=NoseManual Tweak=5 //ClearCheese
		else
			DoBalanceTrick ButtonA=Up ButtonB=Down Type=Manual Tweak=5 //ClearCheese
		endif
	else
		If GotParam Nollie
			DoBalanceTrick ButtonA=Up ButtonB=Down Type=NoseManual Tweak=1 //ClearCheese
		else
			DoBalanceTrick ButtonA=Up ButtonB=Down Type=Manual Tweak=1 //ClearCheese
		endif
	endif

	;if not GotParam SkipInitAnim
	If GotParam FromAir
		If backwards
			FlipAndRotate
			printf "PLAYING FLIPPED FROM MANUAL SCRIPT ======================================="
			PlayAnim Anim=<FromAirAnim>   BlendPeriod=0.0 Speed=<Speed>
		else
			PlayAnim Anim=<FromAirAnim>   BlendPeriod=0.0 Speed=<Speed>
		endif
	else
		printf " PLAYING INIT ANIM >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		PlayAnim Anim=<InitAnim>   BlendPeriod=0.3 Speed=<Speed>
	endif
	;endif


	// Time to fight the manual cheesers
	if Obj_FlagSet FLAG_SKATER_MANUALCHEESE
		if AirTimeLessThan 1 second
			if GotParam CheckCheese
				// find out what the cheese value currently stored is
				GetManualCheese
				// increment it
				ManualCheese=(<ManualCheese> + 1)
				// store it back in the skater
				SetTags ManualCheese=<ManualCheese>
				printf "::::::::::::::::::::Cheese= %c" c=<manualcheese>
				// if cheesy enough, mess with the balance
				if (<ManualCheese> > 1)
					// create_panel_message text= "MESSING WITH BALANCE TO FIGHT CHEESERS"
					//If Not CD
					//	PlaySound SaberTwirl5
					//endif
					AdjustBalance TimeAdd = 2 SpeedMult = 2 LeanMult = 1.2
				endif
			endif
		endif
	else
		Obj_SetFlag FLAG_SKATER_MANUALCHEESE
		SetTags ManualCheese=0
	endif
	//If Speedgreaterthan 300
	//	printf "SPEED LARGE SO CLERAING CHEESE FLAG"
	//	Obj_ClearFlag FLAG_SKATER_MANUALCHEESE
	//endif

	If GotParam Extratricks2
		SetExtraTricks <extratricks2> <extratricks> ignore=<name>
	else
		If GotParam ExtraTricks
			SetExtraTricks <extratricks> ignore=<name>
		endif
	endif

	if GotParam CheckCheese
		If GotParam IsExtra
			WaitAnim MANUAL_DISPLAY_WAIT frames //Wait a little longer on Manuals triggered as extratricks, so you can't just tap triangle and get a bunch of multipliers
		else
			WaitAnim 13 frames //13 frames should match the feel of THPS3
		endif
	else
		WaitAnim MANUAL_DISPLAY_WAIT frames //all other freestyle tricks wait a bit longer, to stop button mashing cheese
	endif

	If Gotparam ExtraWaitPercent
		WaitAnim <ExtraWaitPercent> percent
	endif

	; If not currently in a special manual, do a quick check to see if any got triggered during the
	; first part of the init anim.
	; The if's probably are not necessary because the special manual array would not even be being checked
	; but they're just for safety.
	if gotparam isspecial
	else
		if gotparam isextra
		else
			donextmanualtrick
		endif
	endif

	SetTrickName <Name>
	SetTrickScore <Score>
	Display	Blockspin

	If GotParam IsSpecial
		LaunchSpecialMessage
	endif
	If GotParam IsExtra
		LaunchExtraMessage
	endif

	WaitAnimFinished

	If GotParam ExtraSpeedBoost
		SpacewalkBoost ExtraSpeedBoost = <ExtraSpeedBoost>
	endif


	if GotParam FlipGraphic
		BoardRotate
	endif

	//WaitAnim 50 percent

	If GotParam SproingFlip //patch for the Sproing move only...
		BlendPeriodOut 0
		FlipAfter
	endif
	If GotParam NoBlend //tricks involving a 180 spin can not blend or the board will snap back
		BlendperiodOut 0
	endif

	If GotParam BalanceIdle
		PlayAnim Anim=<BalanceIdle> cycle BlendPeriod=<BlendPeriod> Speed=<Speed>
	else
		If GotParam BalanceAnim3
			PlayAnim Random(@Anim=<BalanceAnim> @Anim=<BalanceAnim2> @Anim=<BalanceAnim3>) wobble  wobbleparams=Manual_wobble_params Speed=<Speed>
		else
			If GotParam BalanceAnim2
				PlayAnim Random(@Anim=<BalanceAnim> @Anim=<BalanceAnim2>) wobble  wobbleparams=Manual_wobble_params Speed=<Speed>
			else
				PlayAnim Anim=<BalanceAnim> wobble  wobbleparams=Manual_wobble_params Speed=<Speed>
			endif
		endif
	endif
	// special effects scripts for during the _range or _idle anims
	if GotParam SpawnScript
		Obj_KillSpawnedScript name=<spawnscript>
		Obj_SpawnScript <spawnscript>
	endif

	WaitWhilstChecking_ForPressure <...>
endscript

script SpacewalkBoost ExtraSpeedBoost=200
	GetSpeed
	if (<speed> < <ExtraSpeedBoost>)
		SetSpeed <ExtraSpeedBoost>
	endif
	Printf "Speed=%s" s=<speed>
endscript


Script WaitWhilstChecking_ForPressure
	if not IsNGC
		Button=L2
	else
		Button=L1
	endif
	begin
		// Do a check to see if we want to toggle into nollie or pressure flip modes
		If held <Button>
			If GotParam Nollie
				Toggle_Nollie_Pressure_States Nollie
			else
				Toggle_Nollie_Pressure_States
			endif
			begin
				if released <Button>
					break
				endif
				DoNextTrick
				Wait 1 game frame
			repeat
		endif
		DoNextTrick
		Wait 1 game frame
	repeat
endscript

Script Toggle_Nollie_Pressure_States
	If InNollie
		NollieOff
		PressureOn
		// give the user the benefit of the extra multiplier for actually switching to this state
		SetException Ex=Ollied          Scr=Ollie Params={<...>}
	else
		If InPressure
			PressureOff
			If GotParam Nollie  //this is a nosemanual
				NollieOn
				SetException Ex=Ollied          Scr=NollieNoDisplay Params={<...>}
			else
				NollieOff
			endif
		else
			PressureOn
		endif
	endif
endscript

Script CheckForNewTrick_ManualOut
	printf "give the events back!!!!!!!"
	RestoreEvents UsedBy=Extra Duration=100
	ManualOut
endscript

script KillManualVibration
	Vibrate Actuator=1 Percent=0
endscript

Manual_wobble_params = {
	WobbleAmpA  = { (0.05,0.05) STATS_MANUAL } ; was .04 amplitudes get added together to make the range
	WobbleAmpB  = { (0.04,0.04) STATS_MANUAL } ; was .03
	WobbleK1    = { (0.0022,0.0022) STATS_MANUAL }  ; frequency 1
	WobbleK2    = { (0.0017,0.0017) STATS_MANUAL }	 ; frequency 2 - the more different from K1, the more randomness
	SpazFactor  = { (1.0,1.0) STATS_MANUAL }	 ; amount the Amps are multiplied by at the ends of the meter
}


script ManualOut
	If GotParam MadeOtherSkaterBail // This is exception is Called, so don't kill the tricks as we
	else
		KillExtraTricks
	endif

	SetTrickName ''
	SetTrickScore 0
	Display Blockspin
endscript


script ManualLand
	VibrateOff
	SetException Ex=RunHasEnded Scr=EndOfRun
	SetException Ex=GoalHasEnded Scr=Goal_EndOfRun
	if GoalManager_GoalShouldExpire
		ClearException Ollied
	endif

	LandSkaterTricks

	ClearEventBuffer
	ClearTrickQueue
	KillExtraTricks

	If GotParam PutDownAnim
		PlayAnim Anim=<PutDownAnim> BlendPeriod=0.2
	else
		If GotParam Nollie	  //if we got the Nollie flag, this is a Nosemanual type trick
			PlayAnim Anim=PutDownNosemanual BlendPeriod=0.2
		else
			PlayAnim Anim=PutDownManual BlendPeriod=0.2
		endif
	endif

	// If GotParam BoardRotate
	// BlendPeriodOut 0
	// BoardRotateAfter
	// endif

	StopBalanceTrick     // Added this as exceptions don't do it
	WaitAnimWhilstChecking
	Goto	OnGroundAi
endscript



// When manuals have an extra flip trick hidden in them, they call this script
// it basically plays the extra anim and then returns back into manual mode

Script ManualLink grindslack=25 trickslack=10 displaypercent=50 TimeAdd = 0 SpeedMult = 1 speed=1.0
	SpawnClothingLandScriptHalfMax  // when we start a manual link trick, wobble the boobs at 50% of the max

	If not IsNGC
		Vibrate Actuator=1 Percent=25
		OnexitRun KillManualVibration
	endif
	// SP: removed on 8/20/03; couldn't see how this was helping except in people who rail flip many times, but that anim is slow now, so whay have this?
	// there was also a bug in that the manual name was not getting reset, so if you ended a combo with a manual, then did the same one to start a new combo
	// you would get the balance degradation applied
	//GetManualName //returns just a single tag, ManualName - don't want to pollute parameters with all the tags
	/*If (<ManualName> = <name>)
		create_panel_message text="SAME MANUAL BITCH"
		printf "=========================##############################TRYING TO DO THE SAME MANUAL TWICE IN A ROW!!!!"
	    //AdjustBalance TimeAdd=2 SpeedMult = 1.25
	endif	*/
	If GotParam RodneyOnly
		If ProfileEquals is_named = mullen
		else
			Goto ManualLink Params={Name='Truck Spin' Score=1000 Anim=Truckstand_Init BalanceAnim=Truckstand_range OutAnim=Truckstand_Out ExtraTricks=FlatlandBranches Extratricks2=TruckStandBranches Trickslack=0 IsExtra }
		endif
	endif
	If GotParam	Nollie
		NollieOn
		SetException Ex=Ollied          Scr=NollieNoDisplay //Params={<...>}
	else
		NollieOff
		SetException Ex=Ollied          Scr=Ollie Params={Anim=<Anim> OutAnim=<OutAnim> BoardRotate=<BoardRotate> BoardFlipAfter=<BoardFlipAfter> FlipAfter=<FlipAfter> NoBlend=<NoBlend>}
	endif
	If GotParam OffMeterTop
		SetException Ex=OffMeterTop			Scr=<OffMeterTop> Params={<...>}
		SetException Ex=OffMeterBottom		Scr=<OffMeterBottom> Params={<...>}
	endif

	if GotParam AllowWallpush
		if GotParam Nollie
			SetException Ex=WallPush	Scr=Manual_Wallpush
		else
			SetException Ex=WallPush	Scr=Manual_Wallpush		Params={ ToNoseManual }
		endif
	else
		SetEventHandler Ex=WallPush		Scr=Manual_CancelWallpushEvent
	endif

	KillExtraTricks
	OnExceptionRun ManualOut
	BailOn
	SetTrickName <Name>
	SetTrickScore <Score>
	; if this trick has an extratrick - a branching, hidden combo - set it active
	//Printstruct <...>
	AdjustBalance TimeAdd = <TimeAdd> SpeedMult = <SpeedMult>
	// Play the anim
	If GotParam Anim
		PlayAnim Anim=<Anim> BlendPeriod=0.3 speed=<speed>
	endif

	If GotParam RotateY
		If flipped
			If GotParam spin_with_L2
				RotateDisplay y Duration = .75 seconds StartAngle = 0.0 EndAngle = 360.0 SinePower = 0 RotationOffset = (0,30,0)
			else
				RotateDisplay y Duration = .75 seconds StartAngle = 0.0 EndAngle = -360.0 SinePower = 0 RotationOffset = (0,30,0)
			endif
		else
			If GotParam spin_with_L2
				RotateDisplay y Duration = .75 seconds StartAngle = 0.0 EndAngle = 360.0 SinePower = 0 RotationOffset = (0,30,0)
			else
				RotateDisplay y Duration = .75 seconds StartAngle = 0.0 EndAngle = -360.0 SinePower = 0 RotationOffset = (0,30,0)
			endif
		endif
		//SetExtraTricks <extratricks2> <extratricks> ignore=<name>
		wait .70 seconds
		PlayManualBalanceAnim <...>
	endif

	If GotParam Anim
		// don't wait for spin type tricks - they have their own wait built in
		Wait 5 frames
	endif
	If GotParam PlayCessSound
		PlaySound foleymove01 pitch=110 vol=100
	endif
	; if we're in the middle of an extra trick play some sound and lights
	If GotParam IsExtra
		If not GotParam RotateY
			If not GotParam PlayCessSound
				LaunchExtraMessage
			endif
		endif
	endif
	If GotParam IsSpecial
		LaunchSpecialMessage
	endif

	If Not GotParam RotateY
		WaitAnim MANUAL_DISPLAY_WAIT frames
	endif

	If GotParam NoDisplay  // Keep G-turns3 and 4 from displaying and scoring
	else
		if GotParam RotateY
			Display AddSpin=360
		else
			Display Blockspin
			// SetTags ManualName=<name> //used to have this after the endif, but it made spinning manuals too hard to balance
		endif
	endif

	If GotParam ExtraPercent
		printf "waiting an extrapercent"
		WaitAnim <ExtraPercent> percent
	endif
	printf "Setting extra tricks active"
	SetManualExtraTricks <...>

	If GotParam FlipAfter
		FlipAfter
		BlendPeriodOut 0
		BoardRotateAfter
	endif
	If GotParam BoardFlipAfter
		BlendPeriodOut 0
		BoardRotateAfter
	endif
	If GotParam Anim
		WaitAnim <extrapercent> percent
	endif
	WaitAnim <grindslack> frames fromend
	Bailoff							; means after this point we can combo into a grind without bailing
	WaitAnim <trickslack> frames fromend
	WaitAnimFinished
	PlayManualBalanceAnim <...>
	WaitWhilstChecking_ForPressure <...>
endscript

script PlayManualBalanceAnim
	If GotParam BalanceIdle
		PlayAnim Anim=<BalanceIdle> cycle
	else
		// single frame from the middle of the wobble anim to absorb flip/rotates and allow us to blend to the wobble position
		// Dan: this wasn't required in THPS4; why?
		PlayAnim Anim=<BalanceAnim> cycle from=middle to=middle
		DoNextTrick
		Wait 1 GameFrame

		PlayAnim Anim=<BalanceAnim> wobble blendperiod=0.3
	endif
endscript

script SetManualExtraTricks Parent='none'
	If GotParam Extratricks2
		SetExtraTricks <extratricks2> <extratricks> Ignore=<parent>
	else
		If GotParam ExtraTricks
			If GotParam NoDisplay
				SetExtraTricks tricks=<extratricks>
			else
				SetExtraTricks tricks=<extratricks> //ignore=<name>
			endif
		endif
	endif
endscript

script GetManualName ManualName='none'
	GetTags
	return ManualName=<ManualName>
endscript

script GetManualCheese
	Gettags
	Return ManualCheese=<ManualCheese>
endscript

/*
script Fireworks
	Obj_GetID
	MangleChecksums a=skatersplash b=<objId>
	SetScript name=<mangled_id> emitscript=emit_fireworks updatescript=fireworks_update
	EmptyParticleSystem name=<mangled_id>
	Obj_PlayStream WheelFireworks

	begin
	if AnimEquals _4thofJuly_idle
		if FrameIs 38
			ParticlesOn name=<mangled_id>
			wait .1 seconds
			ParticlesOff name=<mangled_id>
		endif
		if FrameIs 100
			ParticlesOn name=<mangled_id>
			wait .1 seconds
			ParticlesOff name=<mangled_id>
		endif
	else
		break
	endif
	wait 1 game frame
	repeat
	Wait .25 seconds
	SetScript name=<mangled_id> emitscript=emit_skatersplash updatescript=skatersplash_update
endscript

script emit_fireworks
//	printstruct <...>

	setlife min=.1 max=.3
	setanglespread spread=0.75
	setspeedrange min=.5 max=2.5
	setemitrange width=2.0 height=2.0
	setforce force=(0.0,-0.1,0)
	setemittarget target=(0.0,1.0,0.0)
	setparticlesize sw=1.0 sh=1.0 ew=1 eh=1.0

	setcolor corner=0 sr=255 sg=255 sb=255 sa=255	 ma=255   	er=255 eg=255 eb=255 ea=0
	setcolor corner=1 sr=255 sg=255 sb=64 sa=128	 ma=128		er=255 eg=64 eb=64 ea=0
    setcolor corner=2 sr=255 sg=64 sb=64 sa=0 		ma=0		er=255 eg=64 eb=64 ea=0

	SetCircularEmit circular=0

	begin
        if ShouldEmitParticles name=<name>
			emit num=15
		endif
		wait 1 game frame
	repeat
endscript

script fireworks_update
	begin
        // get the orientation of the skater, so that
        // the particles will project forth from him
		<objId>:Obj_GetBonePosition bone=Bone_head
		//RandomOffset=RandomRange(1,100)
		//x=(<x>+<RandomOffset>)
		y=(<y>+10)
		//z=(<z>+<RandomOffset>)
		setpos x=<x> y=<y> z=<z>
		wait 1 gameframe
	repeat
endscript


////////////////////////////////////////////////////////////////////
//     OLD THPS3 HACKS for special tricks from that game
////////////////////////////////////////////////////////////////////

script SpecialManualFX
	If AnimEquals VisitingHome_Idle
		SwitchOnAtomic special_item
		SwitchOffAtomic skin
		SwitchOffBoard
		begin
			//	fire BloodParticlesOn name="LA_DT_spray01_32.png" start_col=0xAA000099 end_col=0x0000FFFF num=150 emit_w=1.0  emit_h=1.0 angle=50 size=7.0  bone=bone_head growth=0 time=1  speed=50  grav=0  life=1
		BloodParticlesOn name="breath.png" start_col=0x5500FFFF end_col=0x00000099 blend_mode = 0x48 num=25 emit_w=1.0  emit_h=1.0 angle=10 size=40.0  bone=Bone_Fingers_Tip_R growth=0 time=5  speed=40  grav=0  life=3
		BloodParticlesOn name="breath.png" start_col=0x55303030 end_col=0x00474747 num=25 emit_w=2.0  emit_h=2.0 angle=20 size=20.0  bone=Bone_Fingers_Tip_L growth=1.5 time=5  speed=50  grav=0  life=3
			//	smoke BloodParticlesOn name="LA_DT_spray01_32.png" start_col=0xFF303030 end_col=0x00474747 num=50 emit_w=2.0  emit_h=2.0 angle=30 size=10.0  bone=Bone_Board_Root growth=4 time=100  speed=50  grav=0  life=1
		Wait .5 second
		repeat
	endif
	If GotParam Sparks
		begin
		ClawSparks
		Wait .5 frames
		repeat
	endif
	If AnimEquals LazyAss_Idle
		begin
		If frameis 20
			PlaySound bitchslap2
		endif
		Wait 1 Frame
		repeat
	endif
	if AnimEquals MaulNinjaManual_Idle
	begin
		If Flipped
			PlayAnim Anim=CessSlide180_FS
			PlayCessSound
			WaitAnimFinished
			Flip
			PlayAnim Anim=<BalanceIdle> cycle BlendPeriod=<BlendPeriod>
		endif
		If Frameis 1
			PlaySound sabertwirl5
		endif
		Wait 1 Frame
	repeat
	endif
endscript

script ClawSparks
	If ProfileEquals is_named = wolverine
		//	fire BloodParticlesOn name="LA_DT_spray01_32.png" start_col=0xAA000099 end_col=0x0000FFFF num=150 emit_w=1.0  emit_h=1.0 angle=50 size=7.0  bone=Bone_Head growth=0 time=1  speed=50  grav=0  life=1
		BloodParticlesOn name="Grass_1.png" start_col = 0xff00FFFF end_col = 0x880000FF blend_mode = 0x44 num=10 emit_w=2.0  emit_h=2.1 angle=-50 size=1.0  bone=Bone_Fingers_Tip_L growth=3 time=.25  speed=150  grav=0  life=.25
		BloodParticlesOn name="Grass_1.png" start_col = 0xff00FFFF end_col = 0x880000FF blend_mode = 0x44 num=10 emit_w=2.0  emit_h=2.1 angle=-50 size=1.0  bone=Bone_Fingers_Tip_R growth=3 time=.25  speed=150  grav=0  life=.25
		//	smoke BloodParticlesOn name="LA_DT_spray01_32.png" start_col=0xFF303030 end_col=0x00474747 num=50 emit_w=2.0  emit_h=2.0 angle=30 size=10.0  bone=Bone_Board_Root growth=4 time=100  speed=50  grav=0  life=1
	endif
//    Terrain = TERRAIN_GRASS num = 200 start_col = 0xff679EB2 end_col = 0x374C9511    emit_w = 2.0 emit_h = 2.1
//       size = 4 aspect_ratio = 1 growth = 1.0 angle = -50.0 speed = 60.0 speed_range = 60.0 life = 0.9 grav = -0.5
//       name = "Grass_1.png" }
endscript
*/