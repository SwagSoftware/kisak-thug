// ProTricks.q
// This will contain the default trick mapping for all Pro Skaters in the game

// Hawk's trick mappings, mapping slots to tricks.
// Any slot preceded by "Sp" requires you to be special to pull the trick

// Note:  "Sp" tricks should not be assigned in this file.  For the
// trick editor to work correctly, specials for each pro must
// be listed in skater_profile.q

//   === SETS OF LIP TRICKS ===
VertLip =
{ 	Lip_TriangleUL = Trick_Invert
	Lip_TriangleUR = Trick_OneFootInvert
	Lip_TriangleDL = Trick_Blunt
	Lip_TriangleDR = Trick_BSFootplant
	Lip_TriangleL = Trick_Disaster
	Lip_TriangleR = Trick_Axlestall
	Lip_TriangleD = Trick_MuteInvert
	Lip_TriangleU =	Trick_Eggplant
}

StreetLip =
{ 	Lip_TriangleUL = Trick_Noseblunt
	Lip_TriangleUR = Trick_Disaster
	Lip_TriangleDL = Trick_Blunt
	Lip_TriangleDR = Trick_MuteInvert
	Lip_TriangleL = Trick_BSFootplant
	Lip_TriangleR = Trick_AxleStall
	Lip_TriangleD = Trick_RockToFakie
	Lip_TriangleU =	Trick_Nosepick
}

HawkLip =
{ 	Lip_TriangleUL = Trick_AndrectInvert
	Lip_TriangleUR = Trick_Switcheroo
	Lip_TriangleDL = Trick_GymnastPlant
	Lip_TriangleDR = Trick_OneFootInvert
	Lip_TriangleL = Trick_Invert
	Lip_TriangleR = Trick_BSFootplant
	Lip_TriangleD = Trick_MuteInvert
	Lip_TriangleU =	Trick_Noseblunt
}

//   === SETS OF GRAB TRICKS ===
AllAroundGrabs =
{	Air_CircleUL = Trick_Japan
	Air_CircleUR = Trick_SaranWrap
	Air_CircleDL = Trick_Benihana
	Air_CircleDR = Trick_IndyNosebone
	Air_CircleU = Trick_Nosegrab
	Air_CircleD = Trick_Airwalk
	Air_CircleR = Trick_Cannonball
	Air_CircleL = Trick_Melon

	//	Air_L_L_Circle = Trick_Stalefish
	//	Air_R_R_Circle = Trick_Benihana
	//	Air_U_U_Circle = Trick_Crail
	//	Air_D_D_Circle = Trick_Stiffy
}

StreetGrabs =
{	Air_CircleUL = Trick_Crossbone
	Air_CircleUR = Trick_Mute
	Air_CircleDL = Trick_Benihana
	Air_CircleDR = Trick_Airwalk
	Air_CircleU = Trick_Nosegrab
	Air_CircleD = Trick_Tailgrab
	Air_CircleR = Trick_Indy
	Air_CircleL = Trick_Melon

	//	Air_L_L_Circle = Trick_Benihana
	//	Air_R_R_Circle = Trick_FSShifty
	//	Air_U_U_Circle = Trick_Seatbelt
	//	Air_D_D_Circle = Trick_Tailgrab
}

VertGrabs =
{	Air_CircleUL = Trick_Japan
	Air_CircleUR = Trick_Madonna
	Air_CircleDL = Trick_SaranWrap
	Air_CircleDR = Trick_IndyNosebone
	Air_CircleU = Trick_Nosegrab
	Air_CircleD = Trick_Airwalk
	Air_CircleR = Trick_Cannonball
	Air_CircleL = Trick_Melon

	//	Air_L_L_Circle = Trick_Judo
	//	Air_R_R_Circle = Trick_Japan
	//	Air_U_U_Circle = Trick_Seatbelt
	//	Air_D_D_Circle = Trick_Madonna
}

//   === SETS OF FLIP TRICKS ===
VertFlips =
{   Air_SquareUL = Trick_Hardflip
	Air_SquareUR = Trick_180Varial
	Air_SquareDL = Trick_VarialKickflip
	Air_SquareDR = Trick_VarialHeelflip
	Air_SquareU = Trick_Fingerflip
	Air_SquareD = Trick_OllieNorth
	Air_SquareL = Trick_Kickflip
	Air_SquareR = Trick_Heelflip

	Air_D_D_Square = Trick_BackFootKickflip
	Air_U_U_Square = Trick_FFImpossible
}

FreestyleFlips =
{   Air_SquareUL = Trick_Hardflip
	Air_SquareUR = Trick_InwardHeelflip
	Air_SquareDL = Trick_VarialKickflip
	Air_SquareDR = Trick_VarialHeelflip
	Air_SquareU = Trick_Impossible
	Air_SquareD = Trick_PopShoveIt
	Air_SquareL = Trick_Kickflip
	Air_SquareR = Trick_Heelflip

	Air_U_U_Square = Trick_Fingerflip
	Air_D_D_Square = Trick_OllieAirwalk
}

StreetFlips =
{   Air_SquareUL = Trick_Hardflip
	Air_SquareUR = Trick_InwardHeelflip
	Air_SquareDL = Trick_VarialKickflip
	Air_SquareDR = Trick_VarialHeelflip
	Air_SquareU = Trick_FSShoveIt
	Air_SquareD = Trick_PopShoveIt
	Air_SquareL = Trick_Kickflip
	Air_SquareR = Trick_Heelflip

	Air_U_U_Square = Trick_Fingerflip
	Air_D_D_Square = Trick_OllieAirwalk
}

//   === SETS OF PRO DEFINITIONS ===

CaballeroTricks_default =
{	VertLip
	FreestyleFlips
	AllAroundGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Beanplant
}

CampbellTricks_default =
{	VertLip
	FreestyleFlips
	AllAroundGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

GlifbergTricks_default =
{	VertLip
	StreetFlips
	AllAroundGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

KostonTricks_default =
{	StreetLip
	StreetFlips
	StreetGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

LasekTricks_default =
{	VertLip
	VertFlips
	VertGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Fastplant
}

MargeraTricks_default =
{	StreetLip
	StreetFlips
	AllAroundGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Beanplant
}

MullenTricks_default =
{	StreetLip
	FreestyleFlips
	AllAroundGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Beanplant
}

MuskaTricks_default =
{	StreetLip
	StreetFlips
	StreetGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

ReynoldsTricks_default =
{	StreetLip
	StreetFlips
	StreetGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

RowleyTricks_default =
{	StreetLip
	StreetFlips
	StreetGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

SteamerTricks_default =
{	StreetLip
	FreestyleFlips
	AllAroundGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Beanplant
}

ThomasTricks_default =
{	StreetLip
	StreetFlips
	StreetGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

BurnquistTricks =

{   VertLip
	FreestyleFlips
	AllAroundGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Beanplant
}


SaariTricks_default =
{   StreetLip
	FreestyleFlips
	AllAroundGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Beanplant
}

VallelyTricks_default =
{	HawkLip
	FreestyleFlips
	AllAroundGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

RodriguezTricks_default =
{	StreetLip
	StreetFlips
	StreetGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Beanplant
}

DemonessTricks_default =
{	StreetLip
	StreetFlips
	StreetGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

WolverineTricks_default =
{	VertLip
	StreetFlips
	StreetGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

MaulTricks_default =
{	VertLip
	VertFlips
	VertGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Boneless
}

BumTricks_default =
{	VertLip
	StreetFlips
	VertGrabs
	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert
	JumpSlot = Trick_Beanplant
}


HawkTricks_default=
{
	//	Air_L_L_Circle = Trick_Benihana
	//	Air_R_R_Circle = Trick_Crossbone
	//	Air_U_U_Circle = Trick_Seatbelt
	//	Air_D_D_Circle = Trick_Tailgrab

	//	Air_L_L_Square = Trick_Varial
	//	Air_R_R_Square = Trick_Fingerflip
	Air_U_U_Square = Trick_SalFlip
	Air_D_D_Square = Trick_OllieNorth

	Air_SquareUL = Trick_Hardflip
	Air_SquareUR = Trick_InwardHeelflip
	Air_SquareDL = Trick_VarialKickflip
	Air_SquareDR = Trick_VarialHeelflip
	Air_SquareU = Trick_Impossible
	Air_SquareD = Trick_PopShoveIt
	Air_SquareL = Trick_Kickflip
	Air_SquareR = Trick_Heelflip

	Extra_SquareSquareL = DoubleKickflip

	Air_CircleUL = Trick_Japan
	Air_CircleUR = Trick_Madonna
	Air_CircleDL = Trick_Benihana
	Air_CircleDR = Trick_Airwalk
	Air_CircleU = Trick_Nosegrab
	Air_CircleD = Trick_Tailgrab
	Air_CircleR = Trick_Indy
	Air_CircleL = Trick_Melon

	HawkLip

	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert

	JumpSlot = Trick_Boneless
}

CustomTricks_default=
{
	Air_U_U_Square = Trick_SalFlip
	Air_D_D_Square = Trick_OllieNorth

	//Air_R_R_Square = Trick_FSFlip
	//Air_L_L_Square = Trick_BSFlip

	Air_SquareUL = Trick_Hardflip
	Air_SquareUR = Trick_InwardHeelflip
	Air_SquareDL = Trick_VarialKickflip
	Air_SquareDR = Trick_VarialHeelflip
	Air_SquareU = Trick_Impossible
	Air_SquareD = Trick_PopShoveIt
	Air_SquareL = Trick_Kickflip
	Air_SquareR = Trick_Heelflip

	Extra_SquareSquareL = DoubleKickflip

	Air_CircleUL = Trick_Japan
	Air_CircleUR = Trick_Madonna
	Air_CircleDL = Trick_Benihana
	Air_CircleDR = Trick_Airwalk
	Air_CircleU = Trick_Nosegrab
	Air_CircleD = Trick_Tailgrab
	Air_CircleR = Trick_Indy
	Air_CircleL = Trick_Melon

	HawkLip

	ExtraSlot1 = Trick_Revert
	ExtraSlot2 = Trick_Revert

	JumpSlot = Trick_Boneless
}

HawkTricks		= HawkTricks_default
CaballeroTricks = CaballeroTricks_default
CampbellTricks  = CampbellTricks_default
GlifbergTricks  = GlifbergTricks_default
KostonTricks    = KostonTricks_default
LasekTricks     = LasekTricks_default
MargeraTricks   = MargeraTricks_default
MullenTricks    = MullenTricks_default
MuskaTricks     = MuskaTricks_default
ReynoldsTricks  = ReynoldsTricks_default
RowleyTricks    = RowleyTricks_default
SteamerTricks   = SteamerTricks_default
ThomasTricks    = ThomasTricks_default
CustomTricks	= CustomTricks_default

SaariTricks		= SaariTricks_default
VallelyTricks   = VallelyTricks_default
RodriguezTricks = RodriguezTricks_default
DemonessTricks  = DemonessTricks_default
WolverineTricks = WolverineTricks_default
DarthMaulTricks = MaulTricks_default
SlaterTricks 	= HawkTricks_default
EyeballTricks 	= HawkTricks_default
BumTricks 		= BumTricks_default


