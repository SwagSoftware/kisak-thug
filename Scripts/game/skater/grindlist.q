;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The grind tricks.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SpecialGrindTricks =
[
{Trigger={TripleInOrder,Up,Right,Triangle,400}      Duration=400   TrickSlot=SpGrind_U_R_Triangle }
{Trigger={TripleInOrder,Up,Down,Triangle,400}       Duration=400   TrickSlot=SpGrind_U_D_Triangle }
{Trigger={TripleInOrder,Up,Left,Triangle,400}       Duration=400   TrickSlot=SpGrind_U_L_Triangle }
{Trigger={TripleInOrder,Right,Up,Triangle,400}      Duration=400   TrickSlot=SpGrind_R_U_Triangle }
{Trigger={TripleInOrder,Right,Down,Triangle,400}    Duration=400   TrickSlot=SpGrind_R_D_Triangle }
{Trigger={TripleInOrder,Right,Left,Triangle,400}    Duration=400   TrickSlot=SpGrind_R_L_Triangle }
{Trigger={TripleInOrder,Down,Up,Triangle,400}       Duration=400   TrickSlot=SpGrind_D_U_Triangle }
{Trigger={TripleInOrder,Down,Right,Triangle,400}    Duration=400   TrickSlot=SpGrind_D_R_Triangle }
{Trigger={TripleInOrder,Down,Left,Triangle,400}     Duration=400   TrickSlot=SpGrind_D_L_Triangle }
{Trigger={TripleInOrder,Left,Up,Triangle,400}       Duration=400   TrickSlot=SpGrind_L_U_Triangle }
{Trigger={TripleInOrder,Left,Right,Triangle,400}    Duration=400   TrickSlot=SpGrind_L_R_Triangle }
{Trigger={TripleInOrder,Left,Down,Triangle,400}     Duration=400   TrickSlot=SpGrind_L_D_Triangle }
//{Trigger={TripleInOrder,Right,Right,Triangle,400}   Duration=400   TrickSlot=SpGrind_R_R_Triangle }
]

// Note: These all now use the Template= Prefix= method of specifying which script to run.
// The old method using Scripts= will still work however.

// MickNote: All animations used by special grinds must be listed in the "specialanims" array
// so that the code can load the required animations for a skater's special tricks.
// Update:  This is no lopnger planned to be used in THUG, due to the trick editor
// allowing you to use multiple special tricks
// I'm leaving it in for now for illustration purposes in case we want to do something similar




Trick_ElbowSmash = { params={Name='Elbow Smash' IsSpecial} Template=Template2 Prefix="Trick_ElbowSmash2" specialanims=[ElbowSmash_Init, ElbowSmash_Idle, Elbowsmash_out]}



// THUG Special Grinds

Trick_Shortbus = { params={Name='Stupid Grind' IsSpecial} Template=Template3 Prefix="Trick_Shortbus2" specialanims=[Shortbus_Init, Shortbus_idle, Shortbus_out]}
Trick_RodneyGrind = { params={Name='Rodney Primo' IsSpecial} Template=Template3 Prefix="Trick_RodneyGrind2" specialanims=[RodneyGrind_Init, RodneyGrind_range, RodneyGrind_out]}
Trick_GrindNBarf = { params={Name='Grind N Barf' IsSpecial} Template=Template3 Prefix="Trick_GrindNBarf2" specialanims=[GrindNBarf_Init, GrindNBarf_range, GrindNBarf_out]}
Trick_FiftyFiftySwitcheroo = { params={Name='5050 Switcheroo' IsSpecial} Template=Template3 Prefix="Trick_FiftyFiftySwitcheroo2" specialanims=[FiftyFiftySwitcheroo_Init, FiftyFiftySwitcheroo_idle ]}
Trick_RowleyDarkSlideHandStand = { params={Name='Darkslide Handstand' IsSpecial} Template=Template3 Prefix="Trick_RowleyDarkSlideHandStand2" specialanims=[RowleyDarkSlideHandStand_Init, RowleyDarkSlideHandStand_range, RowleyDarkSlideHandStand_out ]}
Trick_PrimoHandStand = { params={Name='Primo Handstand' IsSpecial} Template=Template3 Prefix="Trick_PrimoHandStand2" specialanims=[PrimoHandStand_Init, PrimoHandStand_range, PrimoHandStand_out ]}
Trick_OneFootDarkSlide = { params={Name='One Foot Darkslide' IsSpecial} Template=Template2 Prefix="Trick_OneFootDarkslide2" specialanims=[OneFootDarkSlide_Init, OneFootDarkSlide_range, OneFootDarkSlide_out ]}
Trick_YeaRightSlide = { params={Name='Yeah Right Slide' IsSpecial} Template=Template2 Prefix="Trick_YeaRightSlide2" specialanims=[YeaRightSlide_Init, YeaRightSlide_range, YeaRightSlide_out ]}
Trick_HCNHDF = { params={Name='Crooks DarkSlide' IsSpecial} Template=Template2 Prefix="Trick_HCNHDF2" specialanims=[HCNHDF_Init, HCNHDF_range, HCNHDF_out ]}
Trick_FSNollie360FlipCrook = { params={Name='Nollie 360Flip Crook' IsSpecial} Template=Template2 Prefix="Trick_FSNollie360FlipCrook2" specialanims=[FSNollie360FlipCrook_Init, FSNollie360FlipCrook_range, FSNollie360FlipCrook_out ]}
Trick_MoonwalkGrind = { params={Name='Moonwalk Five-O' IsSpecial} Template=Template3 Prefix="Trick_MoonwalkGrind2" specialanims=[Moonwalkgrind_Init, MoonwalkGrind_idle, MoonwalkGrind_out ]}
Trick_Thinkaboutitgrind = { params={Name='Levitate Grind' IsSpecial} Template=Template3 Prefix="Trick_Thinkaboutitgrind2" specialanims=[Thinkaboutitgrind_Init, Thinkaboutitgrind_idle, Thinkaboutitgrind_out ]}
Trick_360ShovitNoseGrind = { params={Name='360 Shovit NoseGrind' IsSpecial} Template=Template2 Prefix="Trick_360ShovitNoseGrind2" specialanims=[_360ShovitNoseGrind_Init, _360ShovitNoseGrind_range _360ShovitNoseGrind_out ]}
Trick_Flames = { params={Name='Fire Fire Fire' Skater=Gene IsSpecial} Template=Template3 Prefix="Trick_Flames2" specialanims=[Flames_Init, Flames_Idle Flames_out ]}
Trick_BlastGrind = { params={Name='Fire Blaster' Skater=Iron_Man IsSpecial} Template=Template2 Prefix="Trick_BlastGrind2" specialanims=[BlastGrind_Init, BlastGrind_Idle Idle BlastGrind_out ]}
Trick_3DScaryGrind = { params={Name='Scary Grind' Skater=Creature IsSpecial} Template=Template2 Prefix="Trick_3DScaryGrind2" specialanims=[ _3DScaryGrind_Init, _3DScaryGrind_Range _3DScaryGrind_out ]}
Trick_CrookedSkull = { params={Name='Skull Grind' IsSpecial} Template=Template2 Prefix="Trick_CrookedSkull2" specialanims=[ CrookedSkull_Init, CrookedSkull_Idle CrookedSkull_out ]}







Trick_OneFootSmith = { params={Name='One Foot Smith' IsSpecial} Template=Template1 Prefix="Trick_OneFootSmith" specialanims=[SmithFS_Init, SmithFS_Range, Smith_Init, Smith_Range]}
Trick_FlipKickDad = { params={Name='Flip Kick Dad' IsSpecial} Template=Template2 Prefix="Trick_FlipKickDad2" specialanims=[FlipKickDad_Init, FlipKickDad]}
Trick_50FingerFlip ={ params={Name='5-0 Fingerlfip Nosegrind' IsSpecial} Template=Template2 Prefix="Trick_50Fingerflip2" specialanims=[TailGrindFingerFlip]}
Trick_SprayPaintGrind = { params={Name='Ghetto Tag Grind' IsSpecial} Template=Template2 Prefix="Trick_SprayPaintGrind2" specialanims=[SprayPaint_Init, SprayPaint_Range, SprayPaint_Out]}
Trick_DaffyBrokenGrind = { params={Name='Daffy Grind' IsSpecial} Template=Template2 Prefix="Trick_DaffyBrokenGrind2" specialanims=[DaffyBroken_Init, DaffyBroken_Range]}
Trick_GuitarSlide = { params={Name='Faction Guitar Slide' IsSpecial} Template=Template2 Prefix="Trick_Guitarslide2" specialanims=[Guitar_Init, Guitar_Idle]}

Trick_AmericanHeroGrind = { params={Name='American Tribute' IsSpecial} Template=Template2 Prefix="Trick_AmericanHero2" specialanims=[AmericanHeroGrind_Init, AmericanHeroGrind_Idle, AmericanHeroGrind_out]}
Trick_CrookedBigSpinFlip = { params={Name='Crook BigSpinFlip Crook' IsSpecial} Template=Template1 Prefix="Trick_CrookedBigSpin"   specialanims=[CrookBigSpinFlipCrook, FSCrooked_range, Init_FSCrooked]}
 
Trick_DoubleBluntSlide = { params={Name='Double Blunt Slide'} Template=Template2 Prefix="Trick_DoubleBluntSlide2"   specialanims=[DoubleBlunt_Init, DoubleBlunt_Idle]}

// { Trigger={TripleInOrder,Left,Right,Triangle,1000} Duration=1000   Scripts=HurricaneArray}
// { Trigger={TripleInOrder,Right,Left,Triangle,1000} Duration=1000   Scripts=DarkslideArray}
 Trick_Fandangle = { params={Name='Fandangle' IsSpecial} Template=Template1 Prefix="Trick_fandangle" specialanims=[fandangle_Init, fandangle_Range, Fandangle_Out]}
 Trick_Coffin = { params={Name='Coffin' IsSpecial} Template=Template1 Prefix="Trick_Coffin" specialanims=[CoffinGrind_Init, CoffinGrind_Range, CoffinGrind_Out]}
 Trick_RowleyDarkSlide = { params={Name='Rowley Darkslide' IsSpecial} Template=Template1 Prefix="Trick_RowleyDarkSlide" specialanims=[RowleyDarkSlide_InitRowleyDarkSlide_RangeRowleyDarkSlide_out]}
 Trick_BigHitter = { params={Name='Big Hitter II' IsSpecial} Template=Template1 Prefix="Trick_BigHitter" specialanims=[BigHitter_Init, BigHitter_Range, BigHitter_out]} 
 Trick_TailblockSlide = { params={Name='Tailblock Slide' IsSpecial} Template=Template1 Prefix="Trick_TailblockSlide" specialanims=[TailblockSlide_Init, TailblockSlide_Range, TailblockSlide_Init]} 

 
 //TapTrick_CrailSlide = { params={Name='Crail Slide' } Template=Template1 Prefix="Trick_CrailSlide" specialanims=[CrailSlide_Init, CrailSlide_Range, CrailSlide_Out]}
 //TapTrick_DarkSlide = { params={Name='Darkslide' } Template=Template1 Prefix="Trick_Darkslide" specialanims=[Darkslide_InitDarkslide_RangeDarkslide_Out]}
 //TapTrick_HangTenNoseGrind = { params={Name='Hang Ten Nosegrind' } Template=Template1 Prefix="Trick_HangTenNoseGrind" specialanims=[HangTenNoseGrind_Init, HangTenNoseGrind_Range, HangTenNoseGrind_Out]} 
 //TapTrick_GrindOverturn = { params={Name='5-0 Overturn' } Template=Template1 Prefix="Trick_GrindOverturn" specialanims=[GrindOverturn_Init, GrindOverturn_Range, GrindOverturn_Out]}
 //TapTrick_Salad = { params={Name='Salad Grind' } Template=Template1 Prefix="Trick_Salad" specialanims=[FSSaladGrind_Init, FSSaladGrind_range, BSSaladGrind_Init, BSSaladGrind_range]}
 //TapTrick_NosegrindPivot  = { params={Name='Nosegrind to Pivot' } Template=Template1 Prefix="Trick_NosegrindPivot" specialanims=[NosegrindPivot_Init, NosegrindPivot_Range, NosegrindPivot_Out]} 
 //TapTrick_NoseSlideLipSlide = { params={Name='Noseslide Lipslide' } Template=Template1 Prefix="Trick_NoseSlideLipSlide" specialanims=[FSNoseSlideLipSlide, BSBoardslide_range]}
 //TapTrick_Hurricane = { params={Name='Hurricane' } Template=Template1 Prefix="Trick_Hurricane" specialanims=[BSHurricaneGrind_Init, BSHurricaneGrind_Range, BSHurricaneGrind_Out, FSHurricaneGrind_Init, FSHurricaneGrind_Range, FSHurricaneGrind_Out]}


//RETIRED Tricks

//Trick_PaddleGrind = { params={Name='Paddle Out Grind' UnlockFlag=SKATER_UNLOCKED_SLATER IsSpecial} Template=Template1 Prefix="Trick_PaddleGrind"}
//Trick_MaulRollGrind = { params={Name='Dark Jedi Grind' UnlockFlag=SKATER_UNLOCKED_MAUL IsSpecial} Template=Template1 Prefix="Trick_MaulRollGrind"}
//Trick_Sobriety = { params={Name='Sobriety Grind' UnlockFlag=SKATER_UNLOCKED_DICK IsSpecial} Template=Template1 Prefix="Trick_Sobriety"}
//Trick_Drunkgrind = { params={Name='S.U.I. Grind' UnlockFlag=SKATER_UNLOCKED_BUM IsSpecial} Template=Template1 Prefix="Trick_DrunkGrind"}
//Trick_HulaHoop = { params={Name='Hula Hoop' skater=jenna IsSpecial} Template=Template2 Prefix="Trick_HulaHoop2"}
//Trick_QuickDraw = { params={Name='Quick Draw' skater=jango IsSpecial} Template=Template2 Prefix="Trick_QuickDraw2"}
//Trick_RockOutGrind = { params={Name='Headbangers Unite' skater=eddie IsSpecial} Template=Template2 Prefix="Trick_RockOutGrind2"}
//Trick_BballSlide = { params={Name='B-Ballin Slide' IsSpecial} Template=Template2 Prefix="Trick_BballSlide2"   specialanims=[BasketballSlide_Init, BasketballSlide_Idle, BasketballSlide_out]}
//Trick_BoomBox = { params={Name='Ghetto Blastin' OnlyWith=Muska IsSpecial} Template=Template1 Prefix="Trick_BoomBox" specialanims=[BoomBox_Init, BoomBox_Idle]}
//Trick_CrookedBigSpin = { params={Name='Crook BigSpin Crook' IsSpecial} Template=Template1 Prefix="Trick_CrookedBigSpin"  }
//Trick_CartwheelTo5050 = { params={Name='Cartwheel 50-50' IsSpecial} Template=Template2 Prefix="Trick_CartWheelto50502" specialanims=[CartwheelTo5050]}
//Trick_FeebleLayback = { params={Name='Layback Sparks' IsSpecial} Template=Template1 Prefix="Trick_LaidBack" specialanims=[FSFeebleLayback_Init, FSFeebleLayback_Range, FSFeebleLayback_Out]}
//Trick_FroggyGrind ={ params={Name='Froggy Grind' IsSpecial} Template=Template2 Prefix="Trick_FroggyGrind2" specialanims=[FroggyGrind_Init, FroggyGrind_Idle, FroggyGrind_Out]}
//Trick_HumanDart = { params={Name='Human Dart' IsSpecial} Template=Template1 Prefix="Trick_HumanDart" specialanims=[HumanDart_Init, HumanDart_Range, HumanDart_Out]}
//Trick_MPCGrind = { params={Name='Muska Beatz' IsSpecial} Template=Template2 Prefix="Trick_MPCGrind2" specialanims=[MPCGrind_Init, MPCGrind_Idle]}
//Trick_FalconSlide = { params={Name='Falcon Slide' IsSpecial} Template=Template2 Prefix="Trick_FalconSlide2" specialanims=[FalconSlide_Init, FalconSlide_Idle, FalconSlide_out]}
//Trick_RocketTailslide = { params={Name='Rocket Tailslide' IsSpecial} Template=Template1 Prefix="Trick_RocketTailslide" specialanims=[RocketFS_Init, RocketFS_Range, Rocket_Init, Rocket_Range]}
//Trick_Handstand5050 = { params={Name='Handstand 50-50' IsSpecial} Template=Template1 Prefix="Trick_Handstand5050" specialanims=[Handstand5050Grind_Init, Handstand5050Grind_Range, Handstand5050Grind_out]}

GrindTricks=
[
    { Trigger={TripleInOrder,a=Up,b=Up,Triangle,400}      Duration=1000    Template=Template1 Prefix="Trick_Nosebluntslide"}
    { Trigger={TripleInOrder,a=Down,b=Down,Triangle,400}  Duration=1000    Template=Template1 Prefix="Trick_Bluntslide"}
]

// These strings in these template arrays get appended to the specified prefix by the game code
// to generate the script name.
// Eg, if Prefix="Trick_Bluntslide" and a left,perp,fwd,goofy extra grind is done using Template1,
// the game code will run the script Trick_Bluntslide_BS
Template1=
[
	"_BS"	    ; Left,  Perp, Fwd, Goofy		  0
	"_FS"		; Right, Perp, Fwd, Goofy		  1
	"_BS"		; Left,  Par, Fwd, Goofy		  2
	"_FS"		; Right, Par, Fwd, Goofy		  3
	"_BS_180"	; Left,  Perp, Bwd, Goofy		  4
	"_FS_180"	; Right, Perp, Bwd, Goofy		  5
	"_BS_180"	; Left,  Par, Bwd, Goofy		  6
	"_FS_180"	; Right, Par, Bwd, Goofy		  7
	"_FS"		; Left,  Perp, Fwd, Reg			  8
	"_BS"		; Right, Perp, Fwd, Reg			  9
	"_FS"		; Left,  Par, Fwd, Reg			  10	
	"_BS"		; Right, Par, Fwd, Reg			  11
	"_FS_180"	; Left,  Perp, Bwd, Reg			  12
	"_BS_180"	; Right, Perp, Bwd, Reg			  13
	"_FS_180"	; Left,  Par, Bwd, Reg			  14
	"_BS_180"	; Right, Par, Bwd, Reg			  15
]

Template2=
[
	""	; Left,  Perp, Fwd, Goofy		  	0
	""	; Right, Perp, Fwd, Goofy		  	1
	""	; Left,  Par, Fwd, Goofy		  	2
	""	; Right, Par, Fwd, Goofy		  	3
	"_180"	; Left,  Perp, Bwd, Goofy		4
	"_180"	; Right, Perp, Bwd, Goofy		5
	"_180"	; Left,  Par, Bwd, Goofy		6
	"_180"	; Right, Par, Bwd, Goofy  		7
	""	; Left,  Perp, Fwd, Reg			  	8
	""	; Right, Perp, Fwd, Reg			  	9
	""	; Left,  Par, Fwd, Reg			  	10	
	""	; Right, Par, Fwd, Reg			  	11
	"_180"	; Left,  Perp, Bwd, Reg			12
	"_180"	; Right, Perp, Bwd, Reg			13
	"_180"	; Left,  Par, Bwd, Reg			14
	"_180"	; Right, Par, Bwd, Reg			15
]

Template3=
[
	""	; Left,  Perp, Fwd, Goofy		  0
	""	; Right, Perp, Fwd, Goofy		  1
	""	; Left,  Par, Fwd, Goofy		  2
	""	; Right, Par, Fwd, Goofy		  3
	""	; Left,  Perp, Bwd, Goofy		  4
	""	; Right, Perp, Bwd, Goofy		  5
	""	; Left,  Par, Bwd, Goofy		  6
	""	; Right, Par, Bwd, Goofy		  7
	""	; Left,  Perp, Fwd, Reg			  8
	""	; Right, Perp, Fwd, Reg			  9
	""	; Left,  Par, Fwd, Reg			  10	
	""	; Right, Par, Fwd, Reg			  11
	""	; Left,  Perp, Bwd, Reg			  12
	""	; Right, Perp, Bwd, Reg			  13
	""	; Left,  Par, Bwd, Reg			  14
	""	; Right, Par, Bwd, Reg			  15
]

script Bingo
	Playsound GoalDone
	Create_panel_message text="Bingo!"
	Goto Airborne
endscript

///// TESTING GRIND BUG
/*
script LPerFG
	Create_Panel_Message text= "Left, Perp, Fwd, Goofy"
endscript

script RPerFG
	Create_Panel_Message text= "Right, Perp, Fwd, Goofy"
endscript

script LParFG
	Create_Panel_Message text= "Left, Parallel, Fwd, Goofy"
endscript

script RParFG
	Create_Panel_Message text= "Right, Parallel, Fwd, Goofy"
endscript

script LPerBG
	Create_Panel_Message text= "Left, Perp, Backwards, Goofy"
endscript

script RPerBG
	Create_Panel_Message text= "Right, Perp, Backwards, Goofy"
endscript

script LParBG
	Create_Panel_Message text= "Left, Parallel, Backwards, Goofy"
endscript

script RParBG
	Create_Panel_Message text= "Right, Parallel, Backwards, Goofy"
endscript

script LPerFR
	Create_Panel_Message text= "Left, Perp, Fwd, Regular"
endscript

script RPerFR
	Create_Panel_Message text= "Right, Perp, Fwd, Regular"
endscript

script LParFR
	Create_Panel_Message text= "Left, Parallel, Fwd, Regular"
endscript

script RParFR
	Create_Panel_Message text= "Right, Parallel, Fwd, Regular"
endscript

script LPerBR
	Create_Panel_Message text= "Left, Perp, Backwards, Regular"
endscript

script RPerBR
	Create_Panel_Message text= "Right, Perp, Backwards, Regular"
endscript

script LParBR
	Create_Panel_Message text= "Left, Parallel, Backwards, Regular"
endscript

script RParBR
	Create_Panel_Message text= "Right, Parallel, Backwards, Regular"
endscript

; tricks with UP pressed

    [
		LPerFG      ; Left,  Perp, Fwd, Goofy		  0
		RPerFG		; Right, Perp, Fwd, Goofy		  1
		LParFG		; Left,  Par, Fwd, Goofy		  2		
		RParFG		; Right, Par, Fwd, Goofy		  3
		
		LPerBG	; Left,  Perp, Bwd, Goofy		  4		
		RPerBG	; Right, Perp, Bwd, Goofy		  5
		LParBG	; Left,  Par, Bwd, Goofy		  6
		RParBG	; Right, Par, Bwd, Goofy		  7
		
		LPerFR		; Left,  Perp, Fwd, Reg			  8
		RPerFR		; Right, Perp, Fwd, Reg			  9
		LParFR		; Left,  Par, Fwd, Reg			  10
		RParFR		; Right, Par, Fwd, Reg			  11
		
		LPerBR	; Left,  Perp, Bwd, Reg			  12
		RPerBR	; Right, Perp, Bwd, Reg			  13
		LParBR	; Left,  Par, Bwd, Reg			  14
		RParBR	; Right, Par, Bwd, Reg			  15
    ]

*/

GrindTrickList=
[
; the rail tricks are divided into 9 sets of 16 tricks
; each set is for one button direction, and all possible combinations of :

; - Side of rail   Left/Right (side of rail is based on looking along the rail in the direction of travel.)
; - Angle to rail Perpendicular/Parallel
; - Direction skater is facing Forward/Backwards, (based on direction of traven along the rail
; - Stance of skater on board Goofy/Regular (body facing left or right, based on orientation of board) 
;
; Note that the calculation of FS/BS is always (FS = Goofy^Left)
;
; Note there is a lot of duplication here.  The reason it is like this is that some tricks are renamed based on 
; wether they are FS or BS and which side of the rail they come from
; e.g. When skating goofy, a forwards boardslide from the right is actually a Lipslide, as 
; if requires the back trucks to come over the rail (in a BoardSlide, the front trucks come over) 

; tricks with no buttons pressed ; Side, Angle, Dir, Stance

    [
		Trick_BoardSlide_BS		; Left,  Perp, Fwd, Goofy		  0
		Trick_LipSlide_FS		; Right, Perp, Fwd, Goofy		  1
		
		Trick_5050_BS			; Left,  Par, Fwd, Goofy		  2
		Trick_5050_FS			; Right, Par, Fwd, Goofy		  3
		
		Trick_LipSlide_BS		; Left,  Perp, Bwd, Goofy		  4
		Trick_BoardSlide_FS		; Right, Perp, Bwd, Goofy		  5
		
		Trick_5050_FS_180		; Left,  Par, Bwd, Goofy		  6
		Trick_5050_BS_180		; Right, Par, Bwd, Goofy		  7
        
		Trick_LipSlide_FS		; Left,  Perp, Fwd, Reg			  8
		Trick_BoardSlide_BS		; Right, Perp, Fwd, Reg			  9
		
		Trick_5050_FS			; Left,  Par, Fwd, Reg			  10
		Trick_5050_BS			; Right, Par, Fwd, Reg			  11
		
		Trick_BoardSlide_FS 		; Left,  Perp, Bwd, Reg			  12
		Trick_LipSlide_BS		; Right, Perp, Bwd, Reg			  13
		
		Trick_5050_FS_180		; Left,  Par, Bwd, Reg			  14
		Trick_5050_BS_180		; Right, Par, Bwd, Reg			  15
    ]
    
; tricks with UP pressed

    [
		Trick_NoseGrind_BS      ; Left,  Perp, Fwd, Goofy		  0
		Trick_NoseGrind_FS		; Right, Perp, Fwd, Goofy		  1
		Trick_NoseGrind_BS		; Left,  Par, Fwd, Goofy		  2		
		Trick_NoseGrind_FS		; Right, Par, Fwd, Goofy		  3
		
		Trick_NoseGrind_BS_180	; Left,  Perp, Bwd, Goofy		  4		
		Trick_NoseGrind_FS_180	; Right, Perp, Bwd, Goofy		  5
		Trick_NoseGrind_BS_180	; Left,  Par, Bwd, Goofy		  6
		Trick_NoseGrind_FS_180	; Right, Par, Bwd, Goofy		  7
		
		Trick_NoseGrind_FS		; Left,  Perp, Fwd, Reg			  8
		Trick_NoseGrind_BS		; Right, Perp, Fwd, Reg			  9
		Trick_NoseGrind_FS		; Left,  Par, Fwd, Reg			  10
		Trick_NoseGrind_BS		; Right, Par, Fwd, Reg			  11
		
		Trick_NoseGrind_FS_180	; Left,  Perp, Bwd, Reg			  12
		Trick_NoseGrind_BS_180	; Right, Perp, Bwd, Reg			  13
		Trick_NoseGrind_FS_180	; Left,  Par, Bwd, Reg			  14
		Trick_NoseGrind_BS_180	; Right, Par, Bwd, Reg			  15
    ]
    
; tricks with DOWN pressed

    [
		Trick_5_0_BS	   		; Left,  Perp, Fwd, Goofy		  0
		Trick_5_0_FS			; Right, Perp, Fwd, Goofy		  1
		Trick_5_0_BS			; Left,  Par, Fwd, Goofy		  2
		Trick_5_0_FS			; Right, Par, Fwd, Goofy		  3
		
		Trick_5_0_BS_180		; Left,  Perp, Bwd, Goofy		  4
		Trick_5_0_FS_180		; Right, Perp, Bwd, Goofy		  5
		Trick_5_0_BS_180		; Left,  Par, Bwd, Goofy		  6
		Trick_5_0_FS_180		; Right, Par, Bwd, Goofy		  7
		
		Trick_5_0_FS			; Left,  Perp, Fwd, Reg			  8
		Trick_5_0_BS			; Right, Perp, Fwd, Reg			  9
		Trick_5_0_FS			; Left,  Par, Fwd, Reg			  10
		Trick_5_0_BS			; Right, Par, Fwd, Reg			  11
		
		Trick_5_0_FS_180		; Left,  Perp, Bwd, Reg			  12
		Trick_5_0_BS_180		; Right, Perp, Bwd, Reg			  13
		Trick_5_0_FS_180		; Left,  Par, Bwd, Reg			  14
		Trick_5_0_BS_180		; Right, Par, Bwd, Reg			  15
    ]
    
; tricks with LEFT pressed

    [
		Trick_BoardSlide_BS		; Left,  Perp, Fwd, Goofy		  0
		Trick_LipSlide_FS		; Right, Perp, Fwd, Goofy		  1
		
		Trick_Tailslide_BS		; Left,  Par, Fwd, Goofy		  2
		Trick_Noseslide_FS		; Right, Par, Fwd, Goofy		  3
		
		 Trick_LipSlide_BS		; Left,  Perp, Bwd, Goofy		  4
		Trick_BoardSlide_FS		; Right, Perp, Bwd, Goofy		  5
		
		Trick_Tailslide_BS_180	; Left,  Par, Bwd, Goofy		  6			  //
		Trick_Noseslide_FS_180	; Right, Par, Bwd, Goofy		  7			  //
		
		Trick_LipSlide_FS		; Left,  Perp, Fwd, Reg			  8
		Trick_BoardSlide_BS		; Right, Perp, Fwd, Reg			  9
		
		Trick_Tailslide_FS		; Left,  Par, Fwd, Reg			  10
		Trick_Noseslide_BS		; Right, Par, Fwd, Reg			  11
		
		Trick_BoardSlide_FS		; Left,  Perp, Bwd, Reg			  12
		Trick_LipSlide_BS		; Right, Perp, Bwd, Reg			  13
		
		Trick_TailSlide_FS_180	; Left,  Par, Bwd, Reg			  14		  //
		Trick_Noseslide_BS_180	; Right, Par, Bwd, Reg			  15		  //
    ]
    
; tricks with RIGHT pressed

    [
		Trick_BoardSlide_BS		; Left,  Perp, Fwd, Goofy		  0
		Trick_LipSlide_FS		; Right, Perp, Fwd, Goofy		  1
		
		Trick_Noseslide_BS		; Left,  Par, Fwd, Goofy		  2
		Trick_Tailslide_FS		; Right, Par, Fwd, Goofy		  3
		
		Trick_LipSlide_BS		; Left,  Perp, Bwd, Goofy		  4
		Trick_BoardSlide_FS		; Right, Perp, Bwd, Goofy		  5
		
		Trick_Noseslide_BS_180	; Left,  Par, Bwd, Goofy		  6				  ///
		Trick_Tailslide_FS_180	; Right, Par, Bwd, Goofy		  7				  ///
		
		Trick_LipSlide_FS		; Left,  Perp, Fwd, Reg			  8
		Trick_BoardSlide_BS		; Right, Perp, Fwd, Reg			  9
		
		Trick_Noseslide_FS		; Left,  Par, Fwd, Reg			  10
		Trick_Tailslide_BS		; Right, Par, Fwd, Reg			  11
		
		Trick_BoardSlide_FS		; Left,  Perp, Bwd, Reg			  12
		Trick_LipSlide_BS		; Right, Perp, Bwd, Reg			  13			 
		
		Trick_Noseslide_FS_180	; Left,  Par, Bwd, Reg			  14             ///
		Trick_Tailslide_BS_180	; Right, Par, Bwd, Reg			  15             ///
    ]
    
; tricks with UP-LEFT pressed

    [
		Trick_NGCrook_BS	    ; Left,  Perp, Fwd, Goofy		  0
		Trick_Crooked_FS		; Right, Perp, Fwd, Goofy		  1
		
		Trick_NGCrook_BS		; Left,  Par, Fwd, Goofy		  2
		Trick_Crooked_FS		; Right, Par, Fwd, Goofy		  3
		
		Trick_NGCrook_BS_180	; Left,  Perp, Bwd, Goofy		  4
		Trick_Crooked_FS_rot		; Right, Perp, Bwd, Goofy		5		 //Trick_Crooked_FS_180
        
		
		Trick_NGCrook_BS_180	; Left,  Par, Bwd, Goofy		  6
		Trick_Crooked_FS_180	; Right, Par, Bwd, Goofy		  7

		
		Trick_NGCrook_FS		; Left,  Perp, Fwd, Reg			  8
		Trick_Crooked_BS		; Right, Perp, Fwd, Reg			  9
		
		Trick_NGCrook_FS		; Left,  Par, Fwd, Reg			  10
		Trick_Crooked_BS		; Right, Par, Fwd, Reg			  11
		
		Trick_NGCrook_FS_rot	; Left,  Perp, Bwd, Reg			  12  //Trick_NGCrook_FS_180
		Trick_Crooked_BS_180	; Right, Perp, Bwd, Reg			  13
		
		Trick_NGCrook_FS_180	; Left,  Par, Bwd, Reg			  14
		Trick_Crooked_BS_180	; Right, Par, Bwd, Reg			  15
    ]
    
; tricks with UP-RIGHT pressed
    
    [
		Trick_Crooked_BS	    ; Left,  Perp, Fwd, Goofy		  0
		Trick_NGCRook_FS		; Right, Perp, Fwd, Goofy		  1
		Trick_Crooked_BS		; Left,  Par, Fwd, Goofy		  2
		Trick_NGCRook_FS		; Right, Par, Fwd, Goofy		  3
		
		Trick_Crooked_BS_180	; Left,  Perp, Bwd, Goofy		  4
		Trick_NGCRook_FS_rot	; Right, Perp, Bwd, Goofy		  5
		Trick_Crooked_BS_180	; Left,  Par, Bwd, Goofy		  6
		Trick_NGCRook_FS_180	; Right, Par, Bwd, Goofy		  7
		
		Trick_Crooked_FS		; Left,  Perp, Fwd, Reg			  8
		Trick_NGCrook_BS		; Right, Perp, Fwd, Reg			  9
		Trick_Crooked_FS		; Left,  Par, Fwd, Reg			  10
		Trick_NGCrook_BS		; Right, Par, Fwd, Reg			  11
		
		Trick_Crooked_FS_rot		; Left,  Perp, Bwd, Reg			  12
		Trick_NGCrook_BS_180		; Right, Perp, Bwd, Reg			  13
		Trick_Crooked_FS_180	; Left,  Par, Bwd, Reg			  14
		Trick_NGCrook_BS_180	; Right, Par, Bwd, Reg			  15
    ]
    
; tricks with DOWN-LEFT pressed

    [
		Trick_Smith_BS	    ; Left,  Perp, Fwd, Goofy		  0
		Trick_Feeble_FS		; Right, Perp, Fwd, Goofy		  1
		Trick_Smith_BS		; Left,  Par, Fwd, Goofy		  2
		Trick_Feeble_FS		; Right, Par, Fwd, Goofy		  3
		
		Trick_Smith_BS_180  ; Left,  Perp, Bwd, Goofy		  4
		Trick_Feeble_FS_rot	; Right, Perp, Bwd, Goofy		  5
		Trick_Smith_BS_180	; Left,  Par, Bwd, Goofy		  6
		Trick_Feeble_FS_180	; Right, Par, Bwd, Goofy		  7
		
		Trick_Smith_FS	    ; Left,  Perp, Fwd, Reg			  8
		Trick_Feeble_BS		; Right, Perp, Fwd, Reg			  9
		Trick_Smith_FS		; Left,  Par, Fwd, Reg			  10
		Trick_Feeble_BS		; Right, Par, Fwd, Reg			  11
		
		Trick_Smith_FS_rot	; Left,  Perp, Bwd, Reg			  12
		Trick_Feeble_BS_180	; Right, Perp, Bwd, Reg			  13
		Trick_Smith_FS_180	; Left,  Par, Bwd, Reg			  14
		Trick_Feeble_BS_180	; Right, Par, Bwd, Reg			  15
    ]
    
; tricks with DOWN-RIGHT pressed

    [
		Trick_Feeble_BS	    ; Left,  Perp, Fwd, Goofy		  0
		Trick_Smith_FS		; Right, Perp, Fwd, Goofy		  1
		Trick_Feeble_BS		; Left,  Par, Fwd, Goofy		  2
		Trick_Smith_FS		; Right, Par, Fwd, Goofy		  3
		
		Trick_Feeble_BS_180	; Left,  Perp, Bwd, Goofy		  4
		Trick_Smith_FS_rot	; Right, Perp, Bwd, Goofy		  5
		Trick_Feeble_BS_180	; Left,  Par, Bwd, Goofy		  6
		Trick_Smith_FS_180	; Right, Par, Bwd, Goofy		  7
		
		Trick_Feeble_FS		; Left,  Perp, Fwd, Reg			  8
		Trick_Smith_BS		; Right, Perp, Fwd, Reg			  9
		Trick_Feeble_FS		; Left,  Par, Fwd, Reg			  10
		Trick_Smith_BS		; Right, Par, Fwd, Reg			  11
		
		Trick_Feeble_FS_rot	; Left,  Perp, Bwd, Reg			  12
		Trick_Smith_BS_180	; Right, Perp, Bwd, Reg			  13
		Trick_Feeble_FS_180	; Left,  Par, Bwd, Reg			  14
		Trick_Smith_BS_180	; Right, Par, Bwd, Reg			  15
	]
]
