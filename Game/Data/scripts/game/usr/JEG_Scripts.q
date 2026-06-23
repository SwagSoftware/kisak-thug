
script TestPedScript
	setTags obj_idle_state = "BHP"
	begin
		getTags
		Random (
			@
			//printf "Going to BHP State!"
			switch <obj_idle_state>
			case "RHP"
			Obj_CycleAnim anim = RHP_2_BHP

			case "BAX"
			Obj_CycleAnim anim = BAX_2_BHP
			case "LGH"
			Obj_CycleAnim anim = LGH_2_BHP  speed=.5

			endswitch
			Random(
				@Obj_CycleAnim  anim=BHP_Breathe
				@Obj_CycleAnim  anim=BHP_Breathe NumCycles=Random(@1 @2)
				@Obj_CycleAnim  anim=BHP_Scratch
				@Obj_CycleAnim  anim=BHP_Point
				@Obj_CycleAnim  anim=BHP_LookBack
				@//printf"Do Nothing"
			)
			setTags obj_idle_state = "BHP"


			@
			//printf "Going to RHP State!"
			switch <obj_idle_state>
			case "BHP"
			Random(
				@Obj_CycleAnim anim = BHP_2_RHP
				@Obj_CycleAnim anim = BHP_2_RHP_Chin
			)

			case "BAX"
			Obj_CycleAnim anim = RHP_2_BAX Backwards

			case "LGH"
			Obj_CycleAnim anim = RHP_2_LGH Backwards speed=.5
			endswitch
			Random(
				@Obj_CycleAnim  anim=RHP_Breathe  NumCycles=Random(@1 @2)
				@OBJ_Playstream KenHelp1
				Obj_CycleAnim  anim=RHP_TalkTest
				@Obj_CycleAnim  anim=RHP_FootTap  NumCycles=Random(@1 @2 @3)
				@Obj_CycleAnim  anim=RHP_Handsmack

			)
			setTags obj_idle_state = "RHP"


			@
			//printf "Going to BAX State!"
			switch <obj_idle_state>
			case "BHP"
			Obj_CycleAnim anim = BAX_2_BHP from=end to=start

			case "RHP"
			Obj_CycleAnim anim = RHP_2_BAX

			case "LGH"
			Obj_CycleAnim anim = BAX_2_LGH Backwards  speed=.7

			endswitch
			Random(
				@Obj_CycleAnim  anim=BAX_Breathe NumCycles=Random(@1 @2)
				@Obj_CycleAnim  anim=BAX_Nod NumCycles=Random(@1 @2)

			)
			setTags obj_idle_state = "BAX"

			@
			//printf "Going to LGH State!"
			switch <obj_idle_state>
			case "BHP"
			Obj_CycleAnim anim = LGH_2_BHP Backwards

			case "RHP"
			Obj_CycleAnim anim = RHP_2_LGH

			case "BAX"
			Obj_CycleAnim anim = BAX_2_LGH
			endswitch
			Random(
				@Obj_CycleAnim  anim=LGH_GutBuster NumCycles=Random(@1 @2)
				@Obj_CycleAnim  anim=LGH_KneeSlapper speed=.75
				Obj_CycleAnim  anim=LGH_GutBuster
				@Obj_CycleAnim  anim=LGH_Pointing
				Obj_CycleAnim  anim=LGH_GutBuster
				@Obj_CycleAnim  anim=LGH_Giggle
				Obj_CycleAnim  anim=LGH_GutBuster
				@Obj_CycleAnim  anim=LGH_Wave
				Obj_CycleAnim  anim=LGH_GutBuster
				@Obj_CycleAnim  anim=LGH_Wave
				Obj_CycleAnim  anim=LGH_GutBuster


			)
			setTags obj_idle_state = "LGH"

		)
	repeat
endscript

Script PED_Sitting
	setTags obj_idle_state = "STND"
	begin

		getTags

		Random (
			//SIT STATE------------------------------------------------

			@*4
			//printf "Going to SIT state"
			switch <obj_idle_state>
			case "STND"
			Obj_cycleAnim anim = PED_STND2SIT
			case "SITB"
			Obj_cycleAnim anim = PED_SIT2SITB Backwards
			case "SITBL"
			Obj_cycleAnim anim = PED_SITBL2SIT

			endswitch
			random(
				@Obj_cycleAnim anim=PED_SIT_Idle Numcycles=Random(@2 @3 @4 @5)
				@Obj_cycleAnim anim=PED_SIT_LookL
				@Obj_cycleAnim anim=PED_SIT_LookR
				@Obj_cycleAnim anim=PED_SIT_Tap Numcycles=Random(@1 @2 @3)
				//@printf"Do Nothing"
			)
			settags obj_idle_State = "SIT"

			//SITB STATE------------------------------------------------
			@*4
			//printf "Going to SITB state"
			switch <obj_idle_state>
			case "STND"
			Obj_cycleAnim anim=PED_STND2SIT
			Obj_cycleAnim anim=PED_SIT2SITB
			case "SIT"
			Obj_cycleAnim anim=PED_SIT2SITB
			case "SITBL"
			Obj_cycleAnim anim=PED_SITB2SITBL Backwards

			endswitch
			random(
				@Obj_cycleAnim anim=PED_SITB_Idle Numcycles=Random(@2 @3 @4 @5)
				@Obj_cycleAnim anim=PED_SITB_LookL
				@Obj_cycleAnim anim=PED_SITB_LookR
				//@printf"Do Nothing"
			)
			settags obj_idle_State = "SITB"

			//SITBL STATE------------------------------------------------
			@*4
			//printf "Going to SITBL state"
			switch <obj_idle_state>
			case "STND"
			Obj_cycleAnim anim=PED_STND2SIT
			Obj_cycleAnim anim=PED_SITBL2SIT Backwards
			case "SIT"
			Obj_cycleAnim anim=PED_SITBL2SIT Backwards
			case "SITB"
			Obj_cycleAnim anim=PED_SITB2SITBL

			endswitch
			random(
				@Obj_cycleAnim anim=PED_SITBL_Idle Numcycles=Random(@2 @3 @4 @5)
				@Obj_cycleAnim anim=PED_SITBL_LookL
				@Obj_cycleAnim anim=PED_SITBL_Tap
				@Obj_cycleAnim anim=PED_SITBL_Shake
				// @printf"Do Nothing"
			)
			settags obj_idle_State = "SITBL"


			//STAND STATE------------------------------------------------
			@
			//printf "Going to STAND state"
			switch <obj_idle_state>
			case "SIT"
			Obj_cycleAnim anim=PED_SIT2STND

			case "SITB"
			Obj_cycleAnim anim=PED_SIT2SITB Backwards
			Obj_cycleAnim anim=PED_SIT2STND
			case "SITBL"
			Obj_cycleAnim anim=PED_SITBL2SIT
			Obj_cycleAnim anim=PED_SIT2Stnd

			endswitch
			//printf"Standing"
			settags obj_idle_State = "STND"

		)
	repeat
endscript

