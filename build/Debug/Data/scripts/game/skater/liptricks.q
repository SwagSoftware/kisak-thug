LIPTRICK_DISPLAY_WAIT=15


DefaultLipTrick =	{Name='Nose Stall' Score=300 CopingHit=1 InitAnim=NoseTailStall_init Anim=NoseTailStall_range OutAnim=NoseTailStall_out BoardRotate RotateOnOllie FlipOnOllie ReleaseFrame=20 ComboLip ExtraTricks=LipTrickExtras }

Trick_Blunt = 		{Scr=LipMacro2 Params={Name='Blunt to Fakie' CopingHit=5 Score=500 InitAnim=BluntToFakie_init Anim=BluntToFakie_range OutAnim=BluntToFakie_out BoardRotate ExtraTricks=LipTrickExtras }}
Trick_MuteInvert = 	{Scr=LipMacro2 Params={Name='Invert' Score=500 InitAnim=MuteInvert_init Anim=MuteInvert_range OutAnim=MuteInvert_out NoOllie BoardRotate ExtraTricks=InvertExtras }}

Trick_Eggplant = 	{Scr=LipMacro2 Params={Name='Eggplant' Score=550 InitAnim=EggPlant_init Anim=EggPlant_range OutAnim=EggPlant_out NoOllie FlipAfter RevertBS ExtraTricks=InvertExtras}}
Trick_GymnastPlant = {Scr=LipMacro2 Params={Name='Gymnast Plant' Score=575 InitAnim=GymnastPlant_init Anim=GymnastPlant_range OutAnim=GymnastPlant_out NoOllie FlipAfter RevertBS ExtraTricks=InvertExtras}}

Trick_RockToFakie = {Scr=LipMacro2 Params={Name='Rock to Fakie' Score=500 CopingHit=1 InitAnim=FakieRockAndRoll_init Anim=FakieRockAndRoll_range OutAnim=FakieRockAndRoll_out BoardRotate ExtraTricks=LipTrickExtras}}
Trick_Disaster = 	{Scr=LipMacro2 Params={Name='Disaster' Score=600 CopingHit=20 InitAnim=Disaster_init Anim=Disaster_range OutAnim=Disaster_out FlipAfter RotateOnOllie ExtraTricks=LipTrickExtras}}

Trick_Invert = 		{Scr=LipMacro2 Params={Name='Varial Invert to Fakie' Score=450 InitAnim=Invert_init Anim=Invert_range OutAnim=Invert_out NoOllie BoardRotate RevertBS ExtraTricks=InvertExtras}}
Trick_OneFootInvert = {Scr=LipMacro2 Params={Name='One Foot Invert' Score=500 InitAnim=OneFootInvert_init Anim=OneFootInvert_range OutAnim=OneFootInvert_out NoOllie BoardRotate ReleaseFrame=30 RevertBS ExtraTricks=InvertExtras}}
Trick_BSFootplant = {Scr=LipMacro2 Params={Name='BS Boneless' Score=550 InitAnim=BSFootplant_init Anim=BSFootplant_range OutAnim=BSFootplant_out OllieOutAnim=BSFootplant_OllieOut FlipAfter UseBoneless ReleaseFrame=20 BailScript=FaceSmash RevertBS ExtraTricks=LipTrickExtras}}  //FlipAfter RotateOnOllie

Trick_AxleStall = 	{Scr=LipMacro2 Params={Name='Axle Stall' Score=400 CopingHit=8 InitAnim=AxleStall_init Anim=AxleStall_range OutAnim=AxleStall_out OllieOutAnim=AxleStall_OllieOut FlipAfter ExtraTricks=LipTrickExtras}}  //FlipAfter RotateOnOllie
Trick_Nosepick = 	{Scr=LipMacro2 Params={Name='FS Nosepick' Score=550 CopingHit=15 InitAnim=FSIndyNosepick_init Anim=FSIndyNosepick_range OutAnim=FSIndyNosepick_out FlipAfter RotateOnOllie ExtraTricks=LipTrickExtras }}
Trick_Noseblunt = 	{Scr=LipMacro2 Params={Name='FS Noseblunt' Score=550 CopingHit=20 InitAnim=FS180Noseblunt_init Anim=FS180Noseblunt_range OutAnim=FS180Noseblunt_out FlipAfter RotateOnOllie ExtraTricks=LipTrickExtras }}

Trick_AndrectInvert = {Scr=LipMacro2 Params={Name='Andrecht Invert' Score=550 InitAnim=AndrectInvert_init Anim=AndrectInvert_range OutAnim=AndrectInvert_out NoOllie FlipAfter BoardRotate ExtraTricks=InvertExtras ReleaseFrame=20}}
Trick_Switcheroo =   {Scr=LipMacro2 Params={Name='The Switcheroo' Score=600 InitAnim= Switcheroo_Init Anim=Switcheroo_range OutAnim=Switcheroo_Out NoOllie BoardRotate FlipAfter ExtraTricks=InvertExtras ReleaseFrame=30}}

Trick_Russian = 	{Scr=LipMacro2 Params={Name='Russian Boneless' Score=3000 InitAnim=BSFootplant_init PingPong Anim=Russian_Idle OutAnim=Russian_out OllieOutAnim=Russian_OllieOut FlipAfter UseBoneless ReleaseFrame=20 BailScript=FaceSmash RevertBS ExtraTricks=LipTrickExtras IsSpecial}}  //FlipAfter RotateOnOllie
Trick_HoHoSadplant = {Scr=LipMacro2 Params={Name='Ho Ho Sad Plant' Score=3500 InitAnim=HoHoSadPlant_Init PingPong Anim=HoHoSadPlant_Idle OutAnim=HoHoSadPlant_Out IsSpecial NoOllie }}  //BloodFrame=10

Trick_HeelflipFSInvert = 	{Scr=LipMacro2 Params={Name='Heelflip FS Invert' Score=3200 InitAnim=HeelflipFSInvert_init Anim=HeelflipFSInvert_range OutAnim=HeelflipFSInvert_out NoOllie IsSpecial FlipAfter RevertBS ExtraTricks=InvertExtras}}

//THUG LIPTRICKS
Trick_1990Invert = {Scr=LipMacro2 Params={Name='1990 Invert' Score=3500 InitAnim=_1990Invert_init Anim=_1990Invert_idle Idle OutAnim=_1990Invert_out NoOllie BoardRotate RevertBS NoOllie IsSpecial ExtraTricks=InvertExtras }}





//RETIRED TRICKS
//Trick_Summoner = 	{Scr=LipMacro2 Params={Name='The Summoner' UnlockFlag=SKATER_UNLOCKED_DEMONESS Score=5000 InitAnim=Summoner_Init Idle Anim=Summoner_Idle OutAnim=Summoner_out IsSpecial NoOllie }}  //BloodFrame=10
//Trick_Bonevert = 	{Scr=LipMacro2 Params={Name='Armed and Inverted' UnlockFlag=SKATER_UNLOCKED_SKATERX OnlyWith=skaterx Score=5000 InitAnim=XArm_Init Anim=XArm_Range OutAnim=XArm_Out IsSpecial FlipAfter BoardRotate NoOllie ExtraTricks=InvertExtras }}  //BloodFrame=10
//Trick_HTeethSweeper = {Scr=LipMacro2 Params={Name='The H Teeth Sweeper' Score=4000 InitAnim=HTeethSweeper_Init Anim=HTeethSweeper_Range OutAnim=HTeethSweeper_Out NoOllie IsSpecial BloodFrame=10}}
//Trick_BigSpinFliptoTail = {Scr=LipMacro2 Params={Name='Bigspin Flip to Tail' CopingHit=40 Score=3500 InitAnim=BigSpinFliptoTail_init Anim=BigSpinFliptoTail_range OutAnim=BigSpinFliptoTail_out FlipAfter RotateOnOllie IsSpecial RevertBS ExtraTricks=LipTrickExtras}}
// The Special Lip trick array and the slots that it is comprised off.
//Trick_BSNoseComply = {Scr=LipMacro2 Params={Name='BS Nose Comply' Score=3000 CopingHit=50 InitAnim=BSNoseComply_init Anim=BSNoseComply_range OutAnim=BSNoseComply_out RotateOnOllie FlipOnOllie IsSpecial RevertBS ExtraTricks=LipTrickExtras}}
//Trick_Burntwist = {Scr=LipMacro2 Params={Name='Burntwist' Score=3000 InitAnim=Burntwist_Init OutAnim=Burntwist NoOllie NoBalance RevertBS ReleaseFrame=40 ExtraTricks=InvertExtras IsSpecial}}
//Trick_DarkDisaster = {Scr=LipMacro2 Params={Name='Dark Disaster' Score=3000 InitAnim=DarkDisaster_init Anim=DarkDisaster_range OutAnim=DarkDisaster_out FlipAfter RotateOnOllie IsSpecial RevertBS ExtraTricks=LipTrickExtras}}
//Trick_OneFootBlunt = {Scr=LipMacro2 Params={Name='One Foot Blunt' Score=3000 CopingHit=1 InitAnim=OneFootBluntKickFlip_init Anim=OneFootBluntKickFlip_range OutAnim=OneFootBluntKickFlip_out BoardRotate ExtraTricks=LipTrickExtras IsSpecial ReleaseFrame=15}}








SpecialLipTricks=
[
	{Trigger={TripleInOrder,Up,Right,Triangle,1000}	  	TrickSlot=SpLip_U_R_Triangle }
	{Trigger={TripleInOrder,Up,Down,Triangle,1000}	  	TrickSlot=SpLip_U_D_Triangle }
	{Trigger={TripleInOrder,Up,Left,Triangle,1000}	  	TrickSlot=SpLip_U_L_Triangle }
	{Trigger={TripleInOrder,Right,Up,Triangle,1000}	  	TrickSlot=SpLip_R_U_Triangle }
	{Trigger={TripleInOrder,Right,Down,Triangle,1000}    TrickSlot=SpLip_R_D_Triangle }
	{Trigger={TripleInOrder,Right,Left,Triangle,1000}    TrickSlot=SpLip_R_L_Triangle }
	{Trigger={TripleInOrder,Down,Up,Triangle,1000}	  	TrickSlot=SpLip_D_U_Triangle }
	{Trigger={TripleInOrder,Down,Right,Triangle,1000}    TrickSlot=SpLip_D_R_Triangle }
	{Trigger={TripleInOrder,Down,Left,Triangle,1000}	  	TrickSlot=SpLip_D_L_Triangle }
	{Trigger={TripleInOrder,Left,Up,Triangle,1000}	  	TrickSlot=SpLip_L_U_Triangle }
	{Trigger={TripleInOrder,Left,Right,Triangle,1000}    TrickSlot=SpLip_L_R_Triangle }
	{Trigger={TripleInOrder,Left,Down,Triangle,1000}	  	TrickSlot=SpLip_L_D_Triangle }
	{Trigger={TripleInOrder,a=Up,b=Up,Triangle,1000}	  	TrickSlot=SpLip_U_U_Triangle }
]

LipTricks=
[

	{Trigger={Press,UpLeft,500}  	TrickSlot=Lip_TriangleUL }
	{Trigger={Press,UpRight,500}   	TrickSlot=Lip_TriangleUR }
	{Trigger={Press,DownLeft,500}  	TrickSlot=Lip_TriangleDL }
	{Trigger={Press,DownRight,500}  TrickSlot=Lip_TriangleDR }
	{Trigger={Press,Left,500}    	TrickSlot=Lip_TriangleL }
	{Trigger={Press,Right,500}    	TrickSlot=Lip_TriangleR }
	{Trigger={Press,Down,500}    	TrickSlot=Lip_TriangleD }
	{Trigger={Press,Up,500} 		TrickSlot=Lip_TriangleU }

	{Trigger={Press,Triangle,1000}  Scr=LipMacro2 Params=DefaultLipTrick }
]

ComboLipTricks =
[
	{Trigger={Press,UpLeft,500}  	TrickSlot=Lip_TriangleUL }
	{Trigger={Press,UpRight,500}   	TrickSlot=Lip_TriangleUR }
	{Trigger={Press,DownLeft,500}  	TrickSlot=Lip_TriangleDL }
	{Trigger={Press,DownRight,500}  TrickSlot=Lip_TriangleDR }
	{Trigger={Press,Left,500}    	TrickSlot=Lip_TriangleL }
	{Trigger={Press,Right,500}    	TrickSlot=Lip_TriangleR }
	{Trigger={Press,Down,500}    	TrickSlot=Lip_TriangleD }
	{Trigger={Press,Up,500} 		TrickSlot=Lip_TriangleU }
	{Trigger={Press,Triangle,500} 	DefaultLipTrick }
]

LipTrickExtras =
[
	{Trigger={InOrder,a=Circle,b=Circle,300}  		Trick_Axlestall }
	{Trigger={InOrder,Circle,Square,300}    	Trick_BSFootPlant }
	{Trigger={InOrder,a=Square,b=Square,300}   		Trick_Disaster }
	{Trigger={InOrder,Square,Circle,300}		Trick_RockToFakie}
	{Trigger={InOrder,a=Triangle,b=Triangle,300}   	Trick_Noseblunt }
	{Trigger={InOrder,Triangle,Square,300}		Trick_Nosepick}
	{Trigger={InOrder,Triangle,Circle,300}		Trick_Blunt}


]

InvertExtras =
[
	{Trigger={InOrder,a=Square,b=Square,300}    	Trick_OneFootInvert }
	{Trigger={InOrder,a=Triangle,b=Triangle,300}  	Trick_MuteInvert  }
	{Trigger={InOrder,a=Circle,b=Circle,300}   		Trick_GymnastPlant }
	{Trigger={InOrder,Circle,Square,300}   		Trick_Invert }
	{Trigger={InOrder,Square,Circle,300}		Trick_Eggplant }
	{Trigger={InOrder,Triangle,Circle,300}		Trick_AndrectInvert }
	//	{Trigger={InOrder,Triangle,Square,300}		Trick_Switcheroo }

]

AndrectExtras =
{Trigger={InOrder,Triangle,Triangle,500}   Trick_Switcheroo }

script LipMacro2
	//printstruct <...>
	SetSkaterCamLerpReductionTimer time = 10
	if BailIsOn
		SetState	Air
		Goto LipBail
	endif
	KillExtraTricks
	BailOff
	SetState Lip
	ClearExceptions
	ClearTrickQueue
	SetQueueTricks NoTricks

	// if rail balance is reversed, because the camera collided with a wall
	// and decided to move the other way, reverse the exceptions for bailing and rolling in
	if Obj_FlagSet FLAG_SKATER_LIPTRICK_CAM_REVERSED
		SetException Ex=OffMeterTop			Scr=LipOut Params={<...>}
		if SkateInAble Lip   //if we're on a spine, we want to be able to skate in on the far side
			SetException Ex=OffMeterBottom		Scr=LipOut Params={spine y=-24 <...>}
		else
			//	printf "This is not a spine!!!!!!!!!!!!!!!!!!!!!!!!"
			SetException Ex=OffMeterBottom		Scr=LipBail Params={<...>}
		endif
	else
		SetException Ex=OffMeterBottom			Scr=LipOut Params={<...>}
		if SkateInAble Lip   //if we're on a spine, we want to be able to skate in on the far side
			SetException Ex=OffMeterTop		Scr=LipOut Params={spine y=-24 <...>}
		else
			//	printf "This is not a spine!!!!!!!!!!!!!!!!!!!!!!!!"
			SetException Ex=OffMeterTop		Scr=LipBail Params={<...>}
		endif

	endif

	SetException Ex=SkaterCollideBail 	Scr=SkaterCollideBail
	SetEventHandler Ex=MadeOtherSkaterBail	Scr=MadeOtherSkaterBail_Called
	LaunchStateChangeEvent State=Skater_OnLip
	SetQueueTricks NoTricks
	// we don't want to be able to ollie out of handplants and other inverts
	If GotParam NoOllie
		SetException Ex=Ollied			Scr=LipOut Params={<...>}
	else
		SetException Ex=Ollied			Scr=OllieLipOut Params={<...>}
	endif
	GetTerrain
	If GotParam CopingHit
		Obj_SpawnScript CopingHit Params={<...>}
	endif
	SetTrickName <name>
	SetTrickScore <score>
	If GotParam BloodFrame
		Obj_SpawnScript LipBlood Params={<...>}
	endif
	// If we're coming from another lip trick then don't play init anims
	If Obj_FlagSet FLAG_SKATER_LIPCOMBO
		BlendPeriodOut 0.0
		if GotParam ComboLip //some tricks need to get flipped only if in a secondary combo
			Flip
			BoardRotate
		endif
		DoBalanceTrick ButtonA=right ButtonB=left Type=lip PlayRangeAnimBackwards
		// unless we're going from a standing up anim to an invert type anim
		// in which case we DO need the init to play
		If GotParam NoOllie
			If GotParam InitAnim
				If not GotParam Isextra
					// we are in a lipcombo, but this is the first invert (noOllie) type trick after the ollie
					// like nosestall > ollie > invert. So we need to play the init
					Playanim Anim=<InitAnim>
					WaitAnimFinished
				else
					// we're in a lipcombo, but we already did stall > ollie > invert, and now we're switching amongst inverts
					// so it's ok to blend, and don't play the init
					BlendPeriodOut 0.3
					Wait LIPTRICK_DISPLAY_WAIT frames
				endif
			else
				Wait LIPTRICK_DISPLAY_WAIT frames
			endif
		else
			If GotParam InitAnim
				// SP: the first time we slam back into a lip combo from the air, no blending - just snap
				// BUT, if we are in one already, and just switching up tricks, blending looks better
				If GotParam IsExtra
					BlendPeriodOut 0.2
				endif
				Playanim Anim=<InitAnim>
				WaitAnimFinished
			else
				Wait LIPTRICK_DISPLAY_WAIT frames
			endif
		endif
		If GotParam IsExtra
			LaunchExtraMessage
		endif
		PlayLipBalancingAnim <...>
		Display Blockspin
	else
		// code for the branching combos
		If GotParam IsExtra
			LaunchExtraMessage
			if GotParam NoOllie
				// if this is an invert, don't play the init anim, but put in a pause to halt cheesers
				PlayLipBalancingAnim <...>
				Display Blockspin
				Wait 40 frames
			else
				// branching lip combos like noseblunts and such
				Playanim Anim=<InitAnim>
				Display Blockspin
				WaitAnimFinished
				PlayLipBalancingAnim <...>
			endif
		else
			If GotParam InitAnim
				Playanim Anim=<InitAnim>
				Wait LIPTRICK_DISPLAY_WAIT frames
				Display Blockspin
				WaitAnimFinished
			endif
			PlayLipBalancingAnim <...>
		endif
	endif
	If GotParam IsSpecial
		LaunchSpecialMessage
	endif
	// Lip tricks can determine which Revert is played in the Landing script so that it all looks good
	If GotParam RevertFS
		Obj_SetFlag FLAG_SKATER_REVERTFS
	endif
	If GotParam RevertBS
		Obj_SetFlag FLAG_SKATER_REVERTBS
	endif
	If GotParam ExtraTricks
		SetExtraTricks tricks=<extratricks> ignore=<name>
	endif
	If Not GotParam NoBalance
		begin
			Tweaktrick 10
			//		If AnimEquals Russian_Idle
			//			If frameis 1
			//				PlayBonkSound
			//			endif
			//			If frameis 32
			//				PlayBonkSound
			//			endif
			//		endif
			Wait 1 Gameframe
		repeat
	else
		Goto LipOut Params={<...>}
	endif
	///////////////////////////////////////////
endscript

script PlayLipBalancingAnim
	If Not GotParam NoBalance
		DoBalanceTrick ButtonA=right ButtonB=left Type=lip PlayRangeAnimBackwards
		If GotParam PingPong
			Playanim Anim=<anim> pingpong   // this is for the Russian Boneless
		else
			Playanim Anim=<anim> wobble from=end To=Start
		endif
		If GotParam Idle
			Playanim Anim=<anim> cycle
		endif
	endif
endscript

Script CopingHit CopingHit=1
	//printstruct <...>
	Wait <CopingHit> Frames
	if ((<terrain> = 3) || (<terrain> = 4))
		PlaySound copinghit3_11 Random(@pitch=90 @pitch=100 @pitch=110) vol=80
	else
		PlayBonkSound
	endif
endscript



Script LipBlood
	Wait <Bloodframe> frames
	Obj_PlaySound Random(@BailSlap01 @BailSlap02 @BailSlap03)  //changed from bitchslap2 04/30/03 by David Rowe
	BloodParticlesOn name="breath.png" start_col=0xFFFFFFFF end_col=0x22FFFFFF num=2 emit_w=2.0  emit_h=2.0 angle=50 size=4.0  bone=head growth=2 time=.5  speed=250  grav=-1000  life=.5
	Obj_SpawnScript BloodSuperTiny
	Wait 1 frame
	//PlaySound headsmackB
endscript

//script FlameUp
//	fire BloodParticlesOn name="LA_DT_spray01_32.png" start_col=0xAA000099 end_col=0x0000FFFF num=150 emit_w=1.0  emit_h=1.0 angle=50 size=7.0  bone=bone_head growth=0 time=1  speed=50  grav=0  life=1
//	BloodParticlesOn name="breath.png" start_col=0x5500FFFF end_col=0x00000099 blend_mode = 0x48 num=40 emit_w=1.0  emit_h=1.0 angle=10 size=60.0  bone=bone_knee_r growth=0 time=1  speed=40  grav=0  life=1
//	BloodParticlesOn name="breath.png" start_col=0x55303030 end_col=0x00474747 num=50 emit_w=2.0  emit_h=2.0 angle=20 size=20.0  bone=bone_pelvis growth=1.5 time=2  speed=50  grav=0  life=1
//	smoke BloodParticlesOn name="LA_DT_spray01_32.png" start_col=0xFF303030 end_col=0x00474747 num=50 emit_w=2.0  emit_h=2.0 angle=30 size=10.0  bone=Bone_Board_Root growth=4 time=100  speed=50  grav=0  life=1
//endscript

// Called at the end of each lip trick script to put the skater back
// into the ground state.
script LipOut y=1
	// This clear exception is here to prevent the lip gap exploit. Basically, if I don't clear, you can fall
	// out of your lip trick, and then still ollie, and then catch the rail again which would reset your balance, thinking
	// it was a new rail...So holding triangle and tapping X rapidly you could wrack up 10 or more lip gaps
	ClearException Ollied
	// This is required, otherwise quitting the lip trick might end up causing
	// a 'lip balance trick done on ground' assertion to go off.
	ClearLipCombos
	StopBalanceTrick
	KillExtraTricks
	SetSkaterCamLerpReductionTimer time = 0
	// We set a flag for any future lip combos, and allow you to trigger them
	// if, on your way out of the lip trick you hit the ground, we're gonna call LipLand
	//If GotParam spine
	//	SetException Ex=Landed Scr=LipLand
	//else
	SetException Ex=Landed Scr=LipLand Params={<...>}
	//endif
	If GotParam OutAnim
		PlayAnim anim=<outanim> Blendperiod=0.0
		BlendPeriodOut 0.3
	else
		if GotParam	InitAnim
			PlayAnim anim=<initanim> backwards
		else
		endif
	endif
	If GotParam BoardRotate
		BoardRotateAfter
	endif
	if not GotParam spine //no waiting on spines - just go over, it looks better
		If GotParam ReleaseFrame
			WaitAnim <ReleaseFrame> frames fromend
		else
			WaitAnim 90 frames fromend
		endif
	endif
	//DisableDisplayFlip
	//...If GotParam FlipAfter
	//...	FlipAfter
	//...	BlendperiodOut 0
	//...endif
	//printf "moving the skater away.........."
	SetState Air
	Move z=1
	Move y=<y> // Push out a bit.
	if gotparam spine
		//	Rotate y=180
		Rotate z=180
		Flip
		SetTrickName "Spine Transfer"
		SetTrickScore TRANSFER_POINTS
		Display
	endif
	//WaitAnimFinished
	DoNextTrick
	NoRailTricks
	InAirExceptions
	SetException Ex=Landed Scr=LipLand Params={<...>}
	BlendPeriodOut 0
	//EnableDisplayFlip
	//FlipAfter
	//RotateAfter
	WaitAnimFinished
	SetException Ex=GroundGone Scr=GroundGone
	If OnGround
		LandSkaterTricks
		DoNextManualTrick
	else
		ClearManualTrick
	endif
	//DisableDisplayFlip
	//DisableDisplayFlip
	//goto Land Params={IgnoreAirTime}	//we always want to do the big leg compression thing
	//...FlipAfter
	//...RotateAfter
	If Inair
		If GotParam FlipAfter
		else
			FlipAfter
		endif
		RotateAfter
		SetLandedFromVert
		Goto Airborne
	else
		// just for safety, really, cause if we hit ground during this part of the trick we will goto to LipLand
		LandSkaterTricks
		Goto OnGroundAi
	endif
endscript

// Whenever we land, we need to clear the ability
// to do lip combos

script ClearLipCombos
	ClearAllowLipNoGrind
	Obj_ClearFlag FLAG_SKATER_LIPCOMBO
endscript


script LipLand
	OverrideCancelGround   // we could still revert at thi point, so don't cancel gaps
	ClearTrickQueue
	SetQueueTricks NoTricks
	Land ReturnBacktoLipLand
	//printf "LipLand ============================="
	//printstruct
	// This is only set up for the Nosestall. To make a Gymnastplant work
	// we add the flip and remove the flipafter
	//Flip
	//OnGroundExceptions_NoEndRun
	AllowRailTricks
	Rotate
	EnableDisplayFlip
	If GotParam FlipAfter
	else
		FlipAfter
	endif
	SetExtraTricks_Reverts
	WaitAnimFinished
	//DisableDisplayFlip
	SetLandedFromVert
	Goto Land
endscript



script LipBail
	// This is required, otherwise quitting the lip trick might end up causing
	// a 'lip balance trick done on ground' assertion to go off.
	StopBalanceTrick
	//printf "stopping balance"
	//AllowLipNoGrind
	Move z=1
	Move y=6 // Push out a bit.
	SetState Air
	If GotParam FlipOnOllie
		FlipAfter
	endif
	If GotParam RotateOnOllie
		RotateAfter
	endif
	If GotParam BailScript
		Goto <BailScript>
	else
		GotoRandomScript [Facesmash NoseManualBail ManualBail]
	endif
endscript



script OllieLipOut
	SetSkaterCamLerpReductionTimer time = 1
	//printstruct <...>
	// This is required, otherwise quitting the lip trick might end up causing
	// a 'lip balance trick done on ground' assertion to go off.
	StopBalanceTrick
	KillExtraTricks
	NoRailTricks
	Move z=1
	Move y=6 // Push out a bit.
	//Rotate x=45
	//SetState Ground
	If GotParam BoardRotate
		BoardRotateAfter
	endif
	If GotParam FlipOnOllie
		FlipAfter
	endif
	If GotParam RotateOnOllie
		RotateAfter
	endif
	SetLandedFromVert
	Rotate x=90							// instantly upright
	Rotate x=-45 //duration=.5 seconds		// aim back down into the ramp

	if  HandleLipOllieDirection         // Mick - handle pressing left or right after an ollie out
		//    printf "HandleLipOllieDirection returned true, so clearing lip combos"
		ClearLipCombos                  // no lip combos if we do this
		AllowRailTricks                 // but want to be able to grind again
		ResetLandedFromVert
	else
		//    printf "HandleLipOllieDirection returned false, so setting up lip combos"
		Obj_SpawnScript SetUpLipCombo		//set a timer to enable more combos but only after a certain amount of time
	endif

	If GotParam OllieOutAnim
		Ollie OutAnim=<OllieOutAnim> RotateAfter=yes FromLip
	else
		Ollie
	endif
endscript

script SetUpLipCombo
	wait .3 seconds
	Obj_SetFlag FLAG_SKATER_LIPCOMBO
	AllowRailtricks
	AllowLipNoGrind
	wait .3 seconds
	If Inair
		ClearAllowLipNoGrind
		Obj_ClearFlag FLAG_SKATER_LIPCOMBO
		NoRailTricks
	endif
endscript



// The C-code runs this script when it detects that a lip trick has been triggered, which
// happens when a regular rail is detected & triangle is pressed, and various angle conditions
// are met.
script LipTrick
	// Clear exceptions and trick queue.
	Clearexceptions
	SetException 	Ex=SkaterCollideBail	Scr=SkaterCollideBail
	ClearTrickQueue
	KillExtraTricks
	// Use the LipTricks array
	if Obj_FlagSet FLAG_SKATER_LIPCOMBO
		SetQueueTricks special=SpecialLipTricks ComboLipTricks
	else
		SetQueueTricks special=SpecialLipTricks LipTricks
		//	printf "queued up the liptricks............"
	endif
	UseGrindEvents
	// Wait one frame to allow the C-code to queue up any tricks
	Wait 2 Gameframe //when we moved to the component system, waiting 1 game frame no longer triggered a handplant...But 2 fixes this. Ken is investigating, this is a patch.
	// Do any lip trick triggered.
	DoNextTrick
	// No lip trick was triggered, so stop scanning the LipTricks array.
	Clearexceptions
	SetException 	Ex=SkaterCollideBail	Scr=SkaterCollideBail
	ClearTrickQueue
	SetQueueTricks NoTricks
	// Go back to normal ground physics.
	//printf "default lip trick coming up................."
	Goto LipMacro2 Params=DefaultLipTrick
endscript






/*
//////////////////////////////// OLD STUFF ///////////////////////////////////////

// An example lip trick script.
script LipMacro
// Stop scanning the LipTricks array.
clearexceptions
ClearTrickQueue
SetQueueTricks NoTricks
///////////////////////////////////////////
// For testing ...
SetException Ex=OffMeterTop		Scr=LipBail
SetException Ex=OffMeterBottom	Scr=LipBail
If GotParam InitAnim
	Playanim Anim=<InitAnim>
	WaitAnimFinished
endif
If Held Triangle
else
	Goto LipOut Params={<...>}
endif
SetTrickName <name>
SetTrickScore <score>
Display Blockspin
DoBalanceTrick ButtonA=right ButtonB=left Type=lip DoFlipCheck

playanim Anim=<anim> wobble
begin
If Held Triangle
	Tweaktrick 10
else
	Goto LipOutLonger
endif
WaitOneGameFrame
repeat
endscript

// Called at the end of each lip trick script to put the skater back
// into the ground state.
script LipOutLonger
// This is required, otherwise quitting the lip trick might end up causing
// a 'lip balance trick done on ground' assertion to go off.
StopBalanceTrick
//printf "stopping balance"
Move y=2 // Push out a bit.
Wait 50 frames
SetState Ground
CheckGapTricks
ClearGapTricks
ClearPanel_Landed
goto OnGroundAI
endscript

*/
