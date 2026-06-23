Editor_Resources_Info={
	// If we are running out of memory on the park editor heap,
	// increase this value. If we are running out of memory in the
	// editor, but it's not on the editor heap, then decrease
	// this value
	// used to be 3.2M
	heap=3150000

	// Mess with these only if we run out of memory in a specific pool
	piece_pool=2100
	cursor_piece_pool=40
	in_railpoint_pool=1700
	in_railstring_pool=400
	out_railpoint_pool=4000
	out_railstring_pool=2000
	mappiece_pool=1700
	mapbucketentry_pool=3000
	// script components used by created node array
	max_components=23000

	// we can use all of main heap -EXCEPT- this much
	main_heap_pad=0
	park_heap_pad=85000
}

; =================================================
;
; NOTES:
; -big_riser_name and big_floor_name refer to 20X20X4 risers
; -riser names should be the same across all themes
;
; =================================================
Editor_Riser_Info = [
	// bottom-level, not touching surface
	{
		riser_name 		= Sk3Ed_Rd1b_10x10x4
		floor_name 		= Sk3Ed_Fd1_10x10
		big_riser_name 	= Sk3Ed_Rd1b_20x20x4
		big_floor_name 	= Sk3Ed_Fd1_20x20
	}
	// 	not bottom-level, not touching surface
	{
		riser_name 		= Sk3Ed_Rd1m_10x10x4
		floor_name 		= Sk3Ed_Fd1_10x10
		big_riser_name 	= Sk3Ed_Rd1m_20x20x4
		big_floor_name 	= Sk3Ed_Fd1_20x20
	}
	// not bottom-level, but just below surface
	{
		riser_name 		= Sk3Ed_Rd1t_10x10x4
		floor_name 		= Sk3Ed_F_10x10
		big_riser_name 	= Sk3Ed_Rd1t_20x20x4
		big_floor_name 	= Sk3Ed_F_20x20
	}
	// bottom-level riser, just below surface
	{
		riser_name 		= Sk3Ed_Rd1s_10x10x4
		floor_name 		= Sk3Ed_F_10x10
		big_riser_name 	= Sk3Ed_Rd1s_20x20x4
		big_floor_name 	= Sk3Ed_F_20x20
	}
	// top-level risers sitting on surface
	{
		riser_name 		= Sk3Ed_Ru1s_10x10x4
		floor_name 		= Sk3Ed_Fu1_10x10
		big_riser_name 	= Sk3Ed_Ru1s_20x20x4
		big_floor_name 	= Sk3Ed_Fu1_20x20
	}
	// risers sitting on surface, but not top-level
	{
		riser_name 		= Sk3Ed_Ru1b_10x10x4
		floor_name 		= Sk3Ed_Fu1_10x10
		big_riser_name 	= Sk3Ed_Ru1b_20x20x4
		big_floor_name 	= Sk3Ed_Fu1_20x20
	}
	// risers sitting above surface, not top-level
	{
		riser_name 		= Sk3Ed_Ru1m_10x10x4
		floor_name 		= Sk3Ed_Fu1_10x10
		big_riser_name 	= Sk3Ed_Ru1m_20x20x4
		big_floor_name 	= Sk3Ed_Fu1_20x20
	}
	// risers sitting above surface, top-level
	{
		riser_name 		= Sk3Ed_Ru1t_10x10x4
		floor_name 		= Sk3Ed_Fu1_10x10
		big_riser_name 	= Sk3Ed_Ru1t_20x20x4
		big_floor_name 	= Sk3Ed_Fu1_20x20
	}
]




; =================================================
;
; NOTES:
; -Piece names should be the same across all themes
;
; =================================================
/*
Editor_Pieces = [
//Restarts
	{
		name = Sk3Ed_RS_1p
		set = Restarts
		text_name='Player 1 Start'
		special_type=restart_1
	}
	{
		name = Sk3Ed_RS_Mp
		set = Restarts
		text_name='Player 2 Start'
		special_type=restart_multi
	}
	{
		name = Sk3Ed_Rs_Ho
		set = Restarts
		text_name='Horse Start'
		special_type=restart_horse
	}
	{
		name = Sk3Ed_Rs_KOTH
		set = Restarts
		text_name='King of the Hill Crown Start'
		special_type=king_of_hill
	}
//Gaps
	{
		name = Sk3Ed_GAP_01
		set = Gaps
		text_name='Gap Placement Piece'
		special_type=gap_placement
	}
//BigOb1
	{
		name = Sk3Ed_PB_SubHp01
		set = BigOb1
		text_name='Sub Halfpipe'
	}
	{
		name = Sk3Ed_PB_Hp01
		set = BigOb1
		text_name='Halfpipe'
	}
	{
		name = Sk3Ed_PB_Sul
		set = BigOb1
		text_name='S Bowl'
	}
	{
		name = Sk3Ed_MLo_01
		set = BigOb1
		text_name='Loop'
	}
	{
		name = Sk3Ed_PB_Stairs01
		set = BigOb1
		text_name='Bleachers'
	}
//BigOb2
	{
		name = Sk3Ed_PB_Nude
		set = BigOb2
		text_name='N Bowl'
	}
	{
		name = Sk3Ed_PB_Pool01
		set = BigOb2
		text_name='Rect Pool'
	}
	{
		name = Sk3Ed_PB_Pool02
		set = BigOb2
		text_name='Bowl'
	}
	{
		name = Sk3Ed_PB_Pool03
		set = BigOb2
		text_name='Clover Bowl'
	}
// BigOb3
	{
		name = Sk3Ed_MTra_01
		set = BigOb3
		text_name='Big'
	}
	{
		name = Sk3Ed_MTra_02
		set = BigOb3
		text_name='Small'
	}
//Funboxes
	{
		name = Sk3Ed_FB_Tok01
		set = Funboxes
		text_name='Tokyo mega'
	}
	{
		name = Sk3Ed_FB_Tok02
		set = Funboxes
		text_name='Tokyo low wall'
	}
	{
		name = Sk3Ed_FB_Rio01
		set = Funboxes
		text_name='Rio Quik box'
	}
	{
		name = Sk3Ed_FB_SI01
		set = Funboxes
		text_name='SI Multi Step'
	}
	{
		name = Sk3Ed_FB_SI02
		set = Funboxes
		text_name='SI Wall Box'
	}
	{
		name = Sk3Ed_FB_Sub01
		set = Funboxes
		text_name='Suburbia Rail box'
	}
	{
		name = Sk3Ed_FB_Sub02
		set = Funboxes
		text_name='Suburbia hump'
	}
	{
		name = Sk3Ed_FB_Sub03
		set = Funboxes
		text_name='Suburbia box'
	}
//Funboxes Generic
	{
		name = Sk3Ed_FB_30x30x4_01
		set = FunboxesG
		text_name='Low med'
	}
	{
		name = Sk3Ed_FB_30x30x4_02
		set = FunboxesG
		text_name='Low oct'
	}
	{
		name = Sk3Ed_FB_30x30x4_03
		set = FunboxesG
		text_name='Low long med'
	}
	{
		name = Sk3Ed_FB_30x30x4_04
		set = FunboxesG
		text_name='Low long oct'
	}
	{
		name = Sk3Ed_FB_30x30x8_01
		set = FunboxesG
		text_name='High med'
	}
	{
		name = Sk3Ed_FB_30x30x8_02
		set = FunboxesG
		text_name='High oct'
	}
	{
		name = Sk3Ed_FB_30x30x8_03
		set = FunboxesG
		text_name='High long med'
	}
	{
		name = Sk3Ed_FB_30x30x8_04
		set = FunboxesG
		text_name='High long oct'
	}
//Benches
	{
		name = Sk3Ed_Bs_01
		set = Benches
		text_name='Table'
	}
	{
		name = Sk3Ed_Bs_02
		set = Benches
		text_name='Table bench'
	}
	{
		name = Sk3Ed_Bs_03
		set = Benches
		text_name='Corner table'
	}
	{
		name = Sk3Ed_Bs_04
		set = Benches
		text_name='Corner table bench'
	}
	{
		name = Sk3Ed_Bs_05
		set = Benches
		text_name='Table on dumpster'
	}
	{
		name = Sk3Ed_Bp_01
		set = Benches
		text_name='Park bench'
	}
	{
		name = Sk3Ed_Bp_02
		set = Benches
		text_name='Corner park bench'
	}
//Walls
	{
		name = Sk3Ed_W_10x10x5
		set = Walls
		text_name='High'
	}
	{
		name = Sk3Ed_We_10x10x5
		set = Walls
		text_name='High end'
	}
	{
		name = Sk3Ed_W_10x10x2
		set = Walls
		text_name='Low connector'
	}
	{
		name = Sk3Ed_We_10x10x2
		set = Walls
		text_name='Low'
	}
//QPs
	{
		name = Sk3Ed_QPd_10x10x8
		set = QPs
		text_name='Low Short'
	}
	{
		name = Sk3Ed_QPd_20x10x8
		set = QPs
		text_name='Low Med'
	}
	{
		name = Sk3Ed_QPd_40x10x8
		set = QPs
		text_name='Low Long'
	}
	{
		name = Sk3Ed_QPdi_10x10x8
		set = QPs
		text_name='Low Inside Corner'
	}
	{
		name = Sk3Ed_QPdo_10x10x8
		set = QPs
		text_name='Low Outside Corner'
	}
	{
		name = Sk3Ed_QPd_10x10x12
		set = QPs
		text_name='High Short'
	}
	{
		name = Sk3Ed_QPd_20x10x12
		set = QPs
		text_name='High Med'
	}
	{
		name = Sk3Ed_QPd_40x10x12
		set = QPs
		text_name='High Long'
	}
	{
		name = Sk3Ed_QPdi_10x10x12
		set = QPs
		text_name='High Inside Corner'
	}
	{
		name = Sk3Ed_QPdo_10x10x12
		set = QPs
		text_name='High Outside Corner'
	}
	{
		name = Sk3Ed_QPdR_10x10x4
		set = QPs
		text_name='4ft rollin'
	}
	{
		name = Sk3Ed_QPdR_10x10x8
		set = QPs
		text_name='8ft rollin'
	}
	{
		name = Sk3Ed_QPdR_10x10x12
		set = QPs
		text_name='12ft rollin'
	}
	{
		name = Sk3Ed_QPdR_10x10x16
		set = QPs
		text_name='16ft rollin'
	}
//Railed QPs
	{
		name = Sk3Ed_QPdRA4_10x10x8
		set = QPRail
		text_name='Low QP Low rail'
	}
	{
		name = Sk3Ed_QPdRA8_10x10x8
		set = QPRail
		text_name='Low QP Med rail'
	}
	{
		name = Sk3Ed_QPdRA12_10x10x8
		set = QPRail
		text_name='Low QP High rail'
	}
	{
		name = Sk3Ed_QPdRAs4_10x10x8
		set = QPRail
		text_name='Low QP Low Side rail'
	}
	{
		name = Sk3Ed_QPdRAs8_10x10x8
		set = QPRail
		text_name='Low QP Med Side rail'
	}
	{
		name = Sk3Ed_QPdRAs12_10x10x8
		set = QPRail
		text_name='Low QP High Side rail'
	}
	{
		name = Sk3Ed_QPdRA4_10x10x12
		set = QPRail
		text_name='High QP Low rail'
	}
	{
		name = Sk3Ed_QPdRA8_10x10x12
		set = QPRail
		text_name='High QP Med rail'
	}
	{
		name = Sk3Ed_QPdRA12_10x10x12
		set = QPRail
		text_name='High QP High rail'
	}
	{
		name = Sk3Ed_QPdRAs4_10x10x12
		set = QPRail
		text_name='High QP Low Side rail'
	}
	{
		name = Sk3Ed_QPdRAs8_10x10x12
		set = QPRail
		text_name='High QP Med Side rail'
	}
	{
		name = Sk3Ed_QPdRAs12_10x10x12
		set = QPRail
		text_name='High QP High Side rail'
	}
//Pools
	{
		name = Sk3Ed_P_10x10x8
		set = Pools
		text_name='Short'
	}
	{
		name = Sk3Ed_P_20x10x8
		set = Pools
		text_name='Med'
	}
	{
		name = Sk3Ed_P_40x10x8
		set = Pools
		text_name='Long'
	}
	{
		name = Sk3Ed_Pi_10x10x8
		set = Pools
		text_name='Small Inside Corner'
	}
	{
		name = Sk3Ed_Pi_20x20x8
		set = Pools
		text_name='Large Inside Corner'
	}
	{
		name = Sk3Ed_Po_10x10x8
		set = Pools
		text_name='Outside Corner'
	}
	{
		name = Sk3Ed_Pdp_01
		set = Pools
		text_name='Diving platform'
	}
	{
		name = Sk3Ed_Pdb_01
		set = Pools
		text_name='Diving block'
	}
//Rails
	{
		name = Sk3Ed_RA_10x10x4
		set = Rails
		text_name='Low'
	}
	{
		name = Sk3Ed_RA_10x10x8
		set = Rails
		text_name='Med'
	}
	{
		name = Sk3Ed_RA_10x10x12
		set = Rails
		text_name='High'
	}
	{
		name = Sk3Ed_RA_10x10x4_8
		set = Rails
		text_name='Low to Med'
	}
	{
		name = Sk3Ed_RA_10x10x4_12
		set = Rails
		text_name='Low to High'
	}
	{
		name = Sk3Ed_RA_10x10x8_12
		set = Rails
		text_name='Med to High'
	}
	{
		name = Sk3Ed_RAi_10x10x4
		set = Rails
		text_name='Low tight corner'
	}
	{
		name = Sk3Ed_RAi_10x10x8
		set = Rails
		text_name='Med tight corner'
	}
	{
		name = Sk3Ed_RAi_10x10x12
		set = Rails
		text_name='High tight corner'
	}
	{
		name = Sk3Ed_RAi_20x20x4
		set = Rails
		text_name='Low corner'
	}
	{
		name = Sk3Ed_RAi_20x20x8
		set = Rails
		text_name='Med corner'
	}
	{
		name = Sk3Ed_RAi_20x20x12
		set = Rails
		text_name='High corner'
	}
; temp commented out.  I don't think we need these pieces...
;	{
;		name = Sk3Ed_RA_10x10x8_4
;		set = Rails
;		text_name='Med to Low'
;	}
;	{
;		name = Sk3Ed_RA_10x10x12_4
;		set = Rails
;		text_name='High to Low'
;	}
;	{
;		name = Sk3Ed_RA_10x10x12_8
;		set = Rails
;		text_name='High to Med'
;	}
; end of temp comment out...
//RailSide
	{
		name = Sk3Ed_RAs_10x10x4
		set = RailSide
		text_name='Low Side'
	}
	{
		name = Sk3Ed_RAs_10x10x8
		set = RailSide
		text_name='Med Side'
	}
	{
		name = Sk3Ed_RAs_10x10x12
		set = RailSide
		text_name='High Side'
	}
	{
		name = Sk3Ed_RAs_10x10x4_8
		set = RailSide
		text_name='Low to Med Side'
	}
	{
		name = Sk3Ed_RAs_10x10x4_12
		set = RailSide
		text_name='Low to High Side'
	}
	{
		name = Sk3Ed_RAs_10x10x8_12
		set = RailSide
		text_name='Med to High Side'
	}
	{
		name = Sk3Ed_RAs_10x10x8_4
		set = RailSide
		text_name='Med to Low Side'
	}
	{
		name = Sk3Ed_RAs_10x10x12_4
		set = RailSide
		text_name='High to Low Side'
	}
	{
		name = Sk3Ed_RAs_10x10x12_8
		set = RailSide
		text_name='High to Med Side'
	}
	{
		name = Sk3Ed_RAsi_10x10x4
		set = RailSide
		text_name='Low tight corner'
	}
	{
		name = Sk3Ed_RAsi_10x10x8
		set = RailSide
		text_name='Med tight corner'
	}
	{
		name = Sk3Ed_RAsi_10x10x12
		set = RailSide
		text_name='High tight corner'
	}
	{
		name = Sk3Ed_RAsi_20x20x4
		set = RailSide
		text_name='Low corner'
	}
	{
		name = Sk3Ed_RAsi_20x20x8
		set = RailSide
		text_name='Med corner'
	}
	{
		name = Sk3Ed_RAsi_20x20x12
		set = RailSide
		text_name='High corner'
	}
//Slopes
	{
		name = Sk3Ed_S_10x10x4
		set = Slopes
		text_name='Low'
	}
	{
		name = Sk3Ed_Si_10x10x4
		set = Slopes
		text_name='Low Inside Corner'
	}
	{
		name = Sk3Ed_Si2_10x10x4
		set = Slopes
		text_name='Low Inside Decked Corner'
	}
	{
		name = Sk3Ed_So_10x10x4
		set = Slopes
		text_name='Low Outside Pyramid Corner'
	}
	{
		name = Sk3Ed_So2_10x10x4
		set = Slopes
		text_name='Low Outside Corner'
	}
	{
		name = Sk3Ed_S_10x10x8
		set = Slopes
		text_name='High'
	}
	{
		name = Sk3Ed_Si_10x10x8
		set = Slopes
		text_name='High Inside Corner'
	}
	{
		name = Sk3Ed_Si2_10x10x8
		set = Slopes
		text_name='High Inside Decked Corner'
	}
	{
		name = Sk3Ed_So_10x10x8
		set = Slopes
		text_name='High Outside Pyramid Corner'
	}
	{
		name = Sk3Ed_So2_10x10x8
		set = Slopes
		text_name='High Outside Corner'
	}
	{
		name = Sk3Ed_S_10x20x4
		set = Slopes
		text_name='Low Long'
	}
	{
		name = Sk3Ed_Si_20x20x4
		set = Slopes
		text_name='Low Long Inside Corner'
	}
	{
		name = Sk3Ed_Si2_20x20x4
		set = Slopes
		text_name='Low Long Inside Decked Corner'
	}
	{
		name = Sk3Ed_So_20x20x4
		set = Slopes
		text_name='Low Long Outside Pyramid Corner'
	}
	{
		name = Sk3Ed_So2_20x20x4
		set = Slopes
		text_name='Low Long Outside Corner'
	}
	{
		name = Sk3Ed_S_10x20x8
		set = Slopes
		text_name='High Long'
	}
	{
		name = Sk3Ed_Si_20x20x8
		set = Slopes
		text_name='High Long Inside Corner'
	}
	{
		name = Sk3Ed_Si2_20x20x8
		set = Slopes
		text_name='High Long Inside Decked Corner'
	}
	{
		name = Sk3Ed_So_20x20x8
		set = Slopes
		text_name='High Long Outside Pyramid Corner'
	}
	{
		name = Sk3Ed_So2_20x20x8
		set = Slopes
		text_name='High Long Outside Corner'
	}
//Slopes with rails
	{
		name = Sk3Ed_SRA4_10x10x4
		set = SlopeRail
		text_name='Low Low Rail'
	}
	{
		name = Sk3Ed_SRA8_10x10x4
		set = SlopeRail
		text_name='Low Med Rail'
	}
	{
		name = Sk3Ed_SRA12_10x10x4
		set = SlopeRail
		text_name='Low High Rail'
	}
	{
		name = Sk3Ed_SRA4_10x10x8
		set = SlopeRail
		text_name='High Low Rail'
	}
	{
		name = Sk3Ed_SRA8_10x10x8
		set = SlopeRail
		text_name='High Med Rail'
	}
	{
		name = Sk3Ed_SRA12_10x10x8
		set = SlopeRail
		text_name='High High Rail'
	}
	{
		name = Sk3Ed_SRA4_10x20x4
		set = SlopeRail
		text_name='Low Long Low Rail'
	}
	{
		name = Sk3Ed_SRA8_10x20x4
		set = SlopeRail
		text_name='Low Long Med Rail'
	}
	{
		name = Sk3Ed_SRA12_10x20x4
		set = SlopeRail
		text_name='Low Long High Rail'
	}
	{
		name = Sk3Ed_SRA4_10x20x8
		set = SlopeRail
		text_name='High Long Low Rail'
	}
	{
		name = Sk3Ed_SRA8_10x20x8
		set = SlopeRail
		text_name='High Long Med Rail'
	}
	{
		name = Sk3Ed_SRA12_10x20x8
		set = SlopeRail
		text_name='High Long High Rail'
	}
//Stairs
	{
		name = Sk3Ed_ST_10x10x2
		set = Stairs
		text_name='Double'
	}
	{
		name = Sk3Ed_STi_10x10x2
		set = Stairs
		text_name='Double Inside Corner'
	}
	{
		name = Sk3Ed_STi2_10x10x2
		set = Stairs
		text_name='Double Inside Decked Corner'
	}
	{
		name = Sk3Ed_STo_10x10x2
		set = Stairs
		text_name='Double Outside Pyramid Corner'
	}
	{
		name = Sk3Ed_STo2_10x10x2
		set = Stairs
		text_name='Double Outside Corner'
	}
	{
		name = Sk3Ed_STio_10x10x2
		set = Stairs
		text_name='Double Inside/Outside Corner'
	}
	{
		name = Sk3Ed_ST_10x10x4
		set = Stairs
		text_name='Quad'
	}
	{
		name = Sk3Ed_STi_10x10x4
		set = Stairs
		text_name='Quad Inside Corner'
	}
	{
		name = Sk3Ed_STi2_10x10x4
		set = Stairs
		text_name='Quad Inside Decked Corner'
	}
	{
		name = Sk3Ed_STo_10x10x4
		set = Stairs
		text_name='Quad Outside Pyramid Corner'
	}
	{
		name = Sk3Ed_STo2_10x10x4
		set = Stairs
		text_name='Quad Outside Corner'
	}
	{
		name = Sk3Ed_STio_10x10x4
		set = Stairs
		text_name='Quad Inside/Outside Corner'
	}
//Stairs with rails
	{
		name = Sk3Ed_STRA4_10x10x2
		set = StairsRail
		text_name='Double Low Rail'
	}
	{
		name = Sk3Ed_STRA8_10x10x2
		set = StairsRail
		text_name='Double Med Rail'
	}
	{
		name = Sk3Ed_STRA12_10x10x2
		set = StairsRail
		text_name='Double High Rail'
	}
	{
		name = Sk3Ed_STRA4_10x10x4
		set = StairsRail
		text_name='Quad Low Rail'
	}
	{
		name = Sk3Ed_STRA8_10x10x4
		set = StairsRail
		text_name='Quad Med Rail'
	}
	{
		name = Sk3Ed_STRA12_10x10x4
		set = StairsRail
		text_name='Quad High Rail'
	}
//Greenery
	{
		name = Sk3Ed_Gt_20x20
		set = Greenery
		text_name='Tree planter'
	}
	{
		name = Sk3Ed_Gb_20x10
		set = Greenery
		text_name='Long bush planter'
	}
	{
		name = Sk3Ed_Gb_10x10
		set = Greenery
		text_name='Small bush planter'
	}
//Misc
	{
		name = Sk3Ed_Dumpster01
		set = Misc
		text_name='Dumpster'
	}
	{
		name = Sk3Ed_Dumpster02
		set = Misc
		text_name='Corner Dumpster'
	}
	{
		name = Sk3Ed_MFo_01
		set = Misc
		text_name='Fountain'
	}
	{
		name = Sk3Ed_MPu_20x20x8
	   	set = Misc
	   	text_name='Pungee Pit'
	}
	{
		name = Sk3Ed_MLa_20x20
	   	set = Misc
	   	text_name='Lava'
	}
	{
		name = Sk3Ed_MWa_20x20
	   	set = Misc
	   	text_name='Water'
	}
//	{
//		name =
//	}
//	{
//		name =
//	}
//	{
//		name =
//	}
]
*/



// How the save map array works:
//
// This array is used to allow maps saved with older versions of the piece set to remain loadable.
// When saving, for each piece in the map, the piece's name is looked up in the table below. The index
// of the entry is then written out to memory card/disk. When the file is loaded again, this table is
// used to map indices back to specific pieces.
//
// Rules:
// -When new pieces are added to the piece set, always put them in a new slot at the end of the array
// -When the name of a piece changes (but not its dimensions), replace the old name in the same slot
// -When a piece is removed from the piece set, replace its name with 'Sk3Ed_Dead'. *DON'T DELETE THE ENTRY*.
Editor_Save_Map = [
	Sk3Ed_QPd_10x10x8
	Sk3Ed_QPd_20x10x8
	Sk3Ed_QPd_40x10x8
	Sk3Ed_QPdi_10x10x8
	Sk3Ed_QPdo_10x10x8
	Sk3Ed_QPd_10x10x12
	Sk3Ed_QPd_20x10x12
	Sk3Ed_QPd_40x10x12
	Sk3Ed_QPdi_10x10x12
	Sk3Ed_QPdo_10x10x12
	Sk3Ed_P_10x10x8
	Sk3Ed_Pi_10x10x8
	Sk3Ed_Pi_20x20x8
	Sk3Ed_Po_10x10x8
	Sk3Ed_RA_10x10x4
	Sk3Ed_RA_10x10x8
	Sk3Ed_RA_10x10x12
	Sk3Ed_RA_10x10x4_8
	Sk3Ed_RA_10x10x4_12
	Sk3Ed_RA_10x10x8_4
	Sk3Ed_RA_10x10x8_12
	Sk3Ed_RA_10x10x12_4
	Sk3Ed_RA_10x10x12_8
	Sk3Ed_RAs_10x10x4
	Sk3Ed_RAs_10x10x8
	Sk3Ed_RAs_10x10x12
	Sk3Ed_RAs_10x10x4_8
	Sk3Ed_RAs_10x10x4_12
	Sk3Ed_RAs_10x10x8_4
	Sk3Ed_RAs_10x10x8_12
	Sk3Ed_RAs_10x10x12_4
	Sk3Ed_RAs_10x10x12_8
	Sk3Ed_S_10x10x4
	Sk3Ed_S_10x10x8
	Sk3Ed_Si_10x10x4
	Sk3Ed_So_10x10x4
	Sk3Ed_So2_10x10x4
	Sk3Ed_Si_10x10x8
	Sk3Ed_So_10x10x8
	Sk3Ed_So2_10x10x8
	Sk3Ed_S_10x20x4
	Sk3Ed_S_10x20x8
	Sk3Ed_Si_20x20x4
	Sk3Ed_So_20x20x4
	Sk3Ed_So2_20x20x4
	Sk3Ed_Si_20x20x8
	Sk3Ed_So_20x20x8
	Sk3Ed_So2_20x20x8
	Sk3Ed_ST_10x10x2
	Sk3Ed_ST_10x10x4
	Sk3Ed_STi_10x10x2
	Sk3Ed_STi2_10x10x2
	Sk3Ed_STo_10x10x2
	Sk3Ed_STo2_10x10x2
	Sk3Ed_STio_10x10x2
	Sk3Ed_STi_10x10x4
	Sk3Ed_STi2_10x10x4
	Sk3Ed_STo_10x10x4
	Sk3Ed_STo2_10x10x4
	Sk3Ed_STio_10x10x4
	Sk3Ed_Gt_20x20
	Sk3Ed_Si2_10x10x4
	Sk3Ed_Si2_10x10x8
	Sk3Ed_Si2_20x20x4
	Sk3Ed_Si2_20x20x8
	Sk3Ed_MPu_20x20x8
	Sk3Ed_QPdRA4_10x10x8
	Sk3Ed_QPdRA8_10x10x8
	Sk3Ed_QPdRA12_10x10x8
	Sk3Ed_QPdRAs4_10x10x8
	Sk3Ed_QPdRAs8_10x10x8
	Sk3Ed_QPdRAs12_10x10x8
	Sk3Ed_QPdRA4_10x10x12
	Sk3Ed_QPdRA8_10x10x12
	Sk3Ed_QPdRA12_10x10x12
	Sk3Ed_QPdRAs4_10x10x12
	Sk3Ed_QPdRAs8_10x10x12
	Sk3Ed_QPdRAs12_10x10x12
	Sk3Ed_SRA4_10x10x4
	Sk3Ed_SRA8_10x10x4
	Sk3Ed_SRA12_10x10x4
	Sk3Ed_SRA4_10x10x8
	Sk3Ed_SRA8_10x10x8
	Sk3Ed_SRA12_10x10x8
	Sk3Ed_SRA4_10x20x4
	Sk3Ed_SRA8_10x20x4
	Sk3Ed_SRA12_10x20x4
	Sk3Ed_SRA4_10x20x8
	Sk3Ed_SRA8_10x20x8
	Sk3Ed_SRA12_10x20x8
	Sk3Ed_STRA4_10x10x2
	Sk3Ed_STRA8_10x10x2
	Sk3Ed_STRA12_10x10x2
	Sk3Ed_STRA4_10x10x4
	Sk3Ed_STRA8_10x10x4
	Sk3Ed_STRA12_10x10x4
	Sk3Ed_P_20x10x8
	Sk3Ed_P_40x10x8
	Sk3Ed_MLa_20x20
	Sk3Ed_MWa_20x20
	Sk3Ed_GAP_01
	Sk3Ed_RS_1p
	Sk3Ed_RS_Mp
	Sk3Ed_Rs_Ho
	Sk3Ed_PB_Hp01
	Sk3Ed_PB_Pool01
	Sk3Ed_RAi_10x10x4
	Sk3Ed_RAi_10x10x8
	Sk3Ed_RAi_10x10x12
	Sk3Ed_RAi_20x20x4
	Sk3Ed_RAi_20x20x8
	Sk3Ed_RAi_20x20x12
	Sk3Ed_RAsi_10x10x4
	Sk3Ed_RAsi_10x10x8
	Sk3Ed_RAsi_10x10x12
	Sk3Ed_RAsi_20x20x4
	Sk3Ed_RAsi_20x20x8
	Sk3Ed_RAsi_20x20x12
	Sk3Ed_Gb_20x10
	Sk3Ed_Gb_10x10
	Sk3Ed_PB_Pool02
	Sk3Ed_PB_Stairs01
	Sk3Ed_PB_Pool03
	Sk3Ed_FB_30x30x4_01
	Sk3Ed_FB_30x30x4_02
	Sk3Ed_FB_30x30x4_03
	Sk3Ed_FB_30x30x4_04
	Sk3Ed_FB_30x30x8_01
	Sk3Ed_FB_30x30x8_02
	Sk3Ed_FB_30x30x8_03
	Sk3Ed_FB_30x30x8_04
	Sk3Ed_MFo_01
	Sk3Ed_W_10x10x5
	Sk3Ed_We_10x10x5
	Sk3Ed_W_10x10x2
	Sk3Ed_We_10x10x2
	Sk3Ed_Rs_KOTH
	Sk3Ed_PB_Sul
	Sk3Ed_QPdR_10x10x12
	Sk3Ed_QPdR_10x10x16
	Sk3Ed_MLo_01
	Sk3Ed_Pdp_01
	Sk3Ed_Pdb_01
	Sk3Ed_MTra_01
	Sk3Ed_MTra_02
	Sk3Ed_PB_Nude
	Sk3Ed_QPdR_10x10x4
	Sk3Ed_QPdR_10x10x8
	Sk3Ed_FB_Sub01
	Sk3Ed_FB_Sub02
	Sk3Ed_FB_Sub03
	Sk3Ed_FB_SI01
	Sk3Ed_FB_SI02
	Sk3Ed_Bs_01
	Sk3Ed_Bs_02
	Sk3Ed_Bs_03
	Sk3Ed_Bs_04
	Sk3Ed_Bs_05
	Sk3Ed_Bp_01
	Sk3Ed_Bp_02
	Sk3Ed_Dumpster01
	Sk3Ed_Dumpster02
	Sk3Ed_FB_Tok01
	Sk3Ed_FB_Tok02
	Sk3Ed_FB_Rio01
	Sk3Ed_PB_SubHp01
	Sk3Ed_Dead //was Sk3Ed_MTra_03
	Sk3Ed_Dead //was Sk3Ed_MTra_04
]







// NOTE TO DESIGNERS:
// To set the value for 'base_park_heap' and 'base_main_heap', bring up an empty park
// of the appropriate theme and shell size, then check the printf output
// window for the values to use. This is needed to calibrate the 'resources
// used' bar.
//
// shown_used_pct 	= (actual_used_pct + padding_pct - max_base_pct) / (1 - max_base_pct)
//					= (actual_used_pct + padding_pct - (base_pct + padding_pct)) / (1 - max_base_pct)
//					= (actual_used_pct - base_pct ) / (1 - max_base_pct)
Editor_Theme_Info=[
	{
		// theme 0, school
		pre_bsp=		"sk3ed_schlBSP.pre"
		pre_assets=		"sk3ed_schl.pre"
		bsp_file=		"Levels\sk3ed_schl\sk3ed_schl.bsp"
		bsp_sky_file=	"Levels\sk3ed_schl_sky\sk3ed_schl_sky.bsp"
		qb_file=		"Levels\sk3ed_schl\sk3ed_schl.qb"
		// how much of park editor heap is used for empty park
		base_park_heap=[723216 835984 941072 820048 868752]
		base_piece_pool=[358 438 519 429 414]
		shell_pieces=[
			// shell 0, smallest shell
			[
				Sk3Ed_Shell_Schl_Col_16x16_01
				Sk3Ed_Shell_Schl_16x16_Build01
				Sk3Ed_Shell_Schl_16x16_Build02
				Sk3Ed_Shell_Schl_16x16_Build03
				Sk3Ed_Shell_Schl_16x16_Build04
				Sk3Ed_Shell_Schl_16x16_Facade01
				Sk3Ed_Shell_Schl_16x16_Facade02
				Sk3Ed_Shell_Schl_16x16_Facade03
				Sk3Ed_Shell_Schl_16x16_Facade04
				Sk3Ed_Shell_Schl_16x16_Fence01
				Sk3Ed_Shell_Schl_16x16_Fence02
				Sk3Ed_Shell_Schl_16x16_Fence03
				Sk3Ed_Shell_Schl_16x16_Fence04
				Sk3Ed_Shell_Schl_16x16_Perip01
				Sk3Ed_Shell_Schl_16x16_Perip02
				Sk3Ed_Shell_Schl_16x16_Perip03
				Sk3Ed_Shell_Schl_16x16_Perip04
			]
			// shell 1
			[
				Sk3Ed_Shell_Schl_Col_24x24_01
				Sk3Ed_Shell_Schl_24x24_Build01
				Sk3Ed_Shell_Schl_24x24_Build02
				Sk3Ed_Shell_Schl_24x24_Build03
				Sk3Ed_Shell_Schl_24x24_Build04
				Sk3Ed_Shell_Schl_24x24_Facade01
				Sk3Ed_Shell_Schl_24x24_Facade02
				Sk3Ed_Shell_Schl_24x24_Facade03
				Sk3Ed_Shell_Schl_24x24_Facade04
				Sk3Ed_Shell_Schl_24x24_Fence01
				Sk3Ed_Shell_Schl_24x24_Fence02
				Sk3Ed_Shell_Schl_24x24_Fence03
				Sk3Ed_Shell_Schl_24x24_Fence04
				Sk3Ed_Shell_Schl_24x24_Perip01
				Sk3Ed_Shell_Schl_24x24_Perip02
				Sk3Ed_Shell_Schl_24x24_Perip03
				Sk3Ed_Shell_Schl_24x24_Perip04
			]
			// shell 2
			[
				Sk3Ed_Shell_Schl_Col_30x30_01
				Sk3Ed_Shell_Schl_30x30_Build01
				Sk3Ed_Shell_Schl_30x30_Build02
				Sk3Ed_Shell_Schl_30x30_Build03
				Sk3Ed_Shell_Schl_30x30_Build04
				Sk3Ed_Shell_Schl_30x30_Facade01
				Sk3Ed_Shell_Schl_30x30_Facade02
				Sk3Ed_Shell_Schl_30x30_Facade03
				Sk3Ed_Shell_Schl_30x30_Facade04
				Sk3Ed_Shell_Schl_30x30_Fence01
				Sk3Ed_Shell_Schl_30x30_Fence02
				Sk3Ed_Shell_Schl_30x30_Fence03
				Sk3Ed_Shell_Schl_30x30_Fence04
				Sk3Ed_Shell_Schl_30x30_Perip01
				Sk3Ed_Shell_Schl_30x30_Perip02
				Sk3Ed_Shell_Schl_30x30_Perip03
				Sk3Ed_Shell_Schl_30x30_Perip04
			]
			// shell 3
			[
				Sk3Ed_Shell_Schl_Col_30x18_01
				Sk3Ed_Shell_Schl_30x18_Build01
				Sk3Ed_Shell_Schl_30x18_Build02
				Sk3Ed_Shell_Schl_30x18_Build03
				Sk3Ed_Shell_Schl_30x18_Build04
				Sk3Ed_Shell_Schl_30x18_Facade01
				Sk3Ed_Shell_Schl_30x18_Facade02
				Sk3Ed_Shell_Schl_30x18_Facade03
				Sk3Ed_Shell_Schl_30x18_Facade04
				Sk3Ed_Shell_Schl_30x18_Fence01
				Sk3Ed_Shell_Schl_30x18_Fence02
				Sk3Ed_Shell_Schl_30x18_Fence03
				Sk3Ed_Shell_Schl_30x18_Fence04
				Sk3Ed_Shell_Schl_30x18_Perip01
				Sk3Ed_Shell_Schl_30x18_Perip02
				Sk3Ed_Shell_Schl_30x18_Perip03
				Sk3Ed_Shell_Schl_30x18_Perip04
			]
			// shell 3
			[
				Sk3Ed_Shell_Schl_Col_80x6_01
				Sk3Ed_Shell_Schl_80x6_Build01
				Sk3Ed_Shell_Schl_80x6_Build02
				Sk3Ed_Shell_Schl_80x6_Build03
				Sk3Ed_Shell_Schl_80x6_Build04
				Sk3Ed_Shell_Schl_80x6_Facade01
				Sk3Ed_Shell_Schl_80x6_Facade02
				Sk3Ed_Shell_Schl_80x6_Facade03
				Sk3Ed_Shell_Schl_80x6_Facade04
				Sk3Ed_Shell_Schl_80x6_Fence01
				Sk3Ed_Shell_Schl_80x6_Fence02
				Sk3Ed_Shell_Schl_80x6_Fence03
				Sk3Ed_Shell_Schl_80x6_Fence04
				Sk3Ed_Shell_Schl_80x6_Perip01
				Sk3Ed_Shell_Schl_80x6_Perip02
				Sk3Ed_Shell_Schl_80x6_Perip03
				Sk3Ed_Shell_Schl_80x6_Perip04
			]
		]
	}
	{
		// theme 1, indoor
		pre_bsp=		"sk3ed_indrBSP.pre"
		pre_assets=		"sk3ed_indr.pre"
		bsp_file=		"Levels\sk3ed_indr\sk3ed_indr.bsp"
		bsp_sky_file=	""
		qb_file=		"Levels\sk3ed_indr\sk3ed_indr.qb"
		// how much of park editor heap is used for empty park
		base_park_heap=[711952 814432 919440 808960 903600]
		base_piece_pool=[334 414 495 405 390]
		shell_pieces=[
			// shell 0, smallest shell
			[
				Sk3Ed_Shell_Indr_Col_16x16_01
				Sk3Ed_Shell_Indr_16X16_ExtFloor01
				Sk3Ed_Shell_Indr_16x16_Sparks01
				Sk3Ed_Shell_Indr_16x16_Sparkler01
				Sk3Ed_Shell_Indr_16x16_Wall01
				Sk3Ed_Shell_Indr_16x16_Wall02
				Sk3Ed_Shell_Indr_16x16_Wall03
				Sk3Ed_Shell_Indr_16x16_Wall04
				Sk3Ed_Shell_Indr_16x16_Fence01
				Sk3Ed_Shell_Indr_16x16_Corridor01
				Sk3Ed_Shell_Indr_16x16_Elevator01
				Sk3Ed_Shell_Indr_16x16_Lamp01
				Sk3Ed_Shell_Indr_16x16_Signs01
			]
			// shell 1
			[
				Sk3Ed_Shell_Indr_Col_24x24_01
				Sk3Ed_Shell_Indr_24X24_ExtFloor01
				Sk3Ed_Shell_Indr_24x24_Sparks01
				Sk3Ed_Shell_Indr_24x24_Sparkler01
				Sk3Ed_Shell_Indr_24x24_Wall01
				Sk3Ed_Shell_Indr_24x24_Wall02
				Sk3Ed_Shell_Indr_24x24_Wall03
				Sk3Ed_Shell_Indr_24x24_Wall04
				Sk3Ed_Shell_Indr_24x24_Fence01
				Sk3Ed_Shell_Indr_24x24_Corridor01
				Sk3Ed_Shell_Indr_24x24_Elevator01
				Sk3Ed_Shell_Indr_24x24_Sign01
				Sk3Ed_Shell_Indr_24x24_Lamp01
			]
			// shell 2
			[
				Sk3Ed_Shell_Indr_Col_30x30_01
				Sk3Ed_Shell_Indr_30X30_ExtFloor01
				Sk3Ed_Shell_Indr_30x30_Sparks01
				Sk3Ed_Shell_Indr_30x30_Sparkler01
				Sk3Ed_Shell_Indr_30x30_Wall01
				Sk3Ed_Shell_Indr_30x30_Wall02
				Sk3Ed_Shell_Indr_30x30_Wall03
				Sk3Ed_Shell_Indr_30x30_Wall04
				Sk3Ed_Shell_Indr_30x30_Lamp01
				Sk3Ed_Shell_Indr_30x30_Fence01
				Sk3Ed_Shell_Indr_30x30_Corridor01
				Sk3Ed_Shell_Indr_30x30_Elevator01
				Sk3Ed_Shell_Indr_30x30_Sign01
			]
			// shell 3
			[
				Sk3Ed_Shell_Indr_Col_30x18_01
				Sk3Ed_Shell_Indr_30X18_ExtFloor01
				Sk3Ed_Shell_Indr_30x18_Sparks01
				Sk3Ed_Shell_Indr_30x18_Sparkler01
				Sk3Ed_Shell_Indr_30x18_Wall01
				Sk3Ed_Shell_Indr_30x18_Wall02
				Sk3Ed_Shell_Indr_30x18_Wall03
				Sk3Ed_Shell_Indr_30x18_Wall04
				Sk3Ed_Shell_Indr_30x18_Fence01
				Sk3Ed_Shell_Indr_30x18_Corridor01
				Sk3Ed_Shell_Indr_30x18_Elevator01
				Sk3Ed_Shell_Indr_30x18_Sign01
				Sk3Ed_Shell_Indr_30x18_Lamp01
			]
			// shell 4
			[
				Sk3Ed_Shell_Indr_Col_80x6_01
				Sk3Ed_Shell_Indr_80X6_ExtFloor01
				Sk3Ed_Shell_Indr_80x6_Sparks01
				Sk3Ed_Shell_Indr_80x6_Sparkler01
				Sk3Ed_Shell_Indr_80x6_Wall01
				Sk3Ed_Shell_Indr_80x6_Wall02
				Sk3Ed_Shell_Indr_80x6_Wall03
				Sk3Ed_Shell_Indr_80x6_Wall04
				Sk3Ed_Shell_Indr_80x6_Lamp01
				Sk3Ed_Shell_Indr_80x6_Fence01
				Sk3Ed_Shell_Indr_80x6_Corridor01
				Sk3Ed_Shell_Indr_80x6_Elevator01
				Sk3Ed_Shell_Indr_80x6_Sign01
			]
		]
	}
	{
		// theme 2, beach
		pre_bsp=		"sk3ed_bchBSP.pre"
		pre_assets=		"sk3ed_bch.pre"
		bsp_file=		"Levels\sk3ed_bch\sk3ed_bch.bsp"
		bsp_sky_file=	"Levels\sk3ed_bch_sky\sk3ed_bch_sky.bsp"
		qb_file=		"Levels\sk3ed_bch\sk3ed_bch.qb"
		// how much of park editor heap is used for empty park
		base_park_heap=[1019456 1087648 1108464 1088464 988480]
		base_piece_pool=[357 437 515 430 410]
		shell_pieces=[
			// shell 0, smallest shell
			[
				Sk3Ed_Shell_Bch_Col_16x16_01
				Sk3Ed_Shell_Bch_Island01
				Sk3Ed_Shell_Bch_16x16_Floor01
				Sk3Ed_Shell_Bch_16x16_Floor02
				Sk3Ed_Shell_Bch_16x16_Planter01
				Sk3Ed_Shell_Bch_16x16_Barrier01
				Sk3Ed_Shell_Bch_16x16_Barrier_Reflection01
				Sk3Ed_Shell_Bch_16x16_PalmTree01
				Sk3Ed_Shell_Bch_16x16_PalmTree02
				Sk3Ed_Shell_Bch_16x16_PalmTree03
				Sk3Ed_Shell_Bch_16x16_PalmTree04
				Sk3Ed_Shell_Bch_30x30_ShortWall01
				Sk3Ed_Shell_Bch_30x30_Sand01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_High01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_Low01
				Sk3Ed_Shell_Bch_30x30_Reflection01
				Sk3Ed_Shell_Bch_30x30_Surf01
				Sk3Ed_Shell_Bch_30x30_Planter01
				Sk3Ed_Shell_Bch_30x30_Sidewalk01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_Reflection01
				Sk3Ed_Shell_Bch_30x30_PalmTree01
				Sk3Ed_Shell_Bch_30x30_PalmTree02
				Sk3Ed_Shell_Bch_30x30_PalmTree03
				Sk3Ed_Shell_Bch_30x30_Plaza01
				Sk3Ed_Shell_Bch_30x30_LowPalm01
				Sk3Ed_Shell_Bch_30x30_Storefront01
				Sk3Ed_Shell_Bch_30x30_HighRise01
				Sk3Ed_Shell_Bch_30x30_Hotel01
				Sk3Ed_Shell_Bch_30x30_SandPlaza01
				Sk3Ed_Shell_Bch_30x30_Volleyball01
				Sk3Ed_Shell_Bch_30x30_BeachTent01
				Sk3Ed_Shell_Bch_30x30_Umbrella01
				Sk3Ed_Shell_Bch_30x30_ShortLamp01
				Sk3Ed_Shell_Bch_30x30_GarbageCan01
			]
			// shell 1
			[
				Sk3Ed_Shell_Bch_Col_24x24_01
				Sk3Ed_Shell_Bch_Island01
				Sk3Ed_Shell_Bch_24x24_Floor01
				Sk3Ed_Shell_Bch_24x24_Floor02
				Sk3Ed_Shell_Bch_24x24_Planter01
				Sk3Ed_Shell_Bch_24x24_Barrier01
				Sk3Ed_Shell_Bch_24x24_Barrier_Reflection01
				Sk3Ed_Shell_Bch_24x24_PalmTree01
				Sk3Ed_Shell_Bch_24x24_PalmTree02
				Sk3Ed_Shell_Bch_24x24_PalmTree03
				Sk3Ed_Shell_Bch_24x24_PalmTree04
				Sk3Ed_Shell_Bch_30x30_ShortWall01
				Sk3Ed_Shell_Bch_30x30_Sand01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_High01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_Low01
				Sk3Ed_Shell_Bch_30x30_Reflection01
				Sk3Ed_Shell_Bch_30x30_Surf01
				Sk3Ed_Shell_Bch_30x30_Planter01
				Sk3Ed_Shell_Bch_30x30_Sidewalk01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_Reflection01
				Sk3Ed_Shell_Bch_30x30_PalmTree01
				Sk3Ed_Shell_Bch_30x30_PalmTree02
				Sk3Ed_Shell_Bch_30x30_PalmTree03
				Sk3Ed_Shell_Bch_30x30_Plaza01
				Sk3Ed_Shell_Bch_30x30_LowPalm01
				Sk3Ed_Shell_Bch_30x30_Storefront01
				Sk3Ed_Shell_Bch_30x30_HighRise01
				Sk3Ed_Shell_Bch_30x30_Hotel01
				Sk3Ed_Shell_Bch_30x30_SandPlaza01
				Sk3Ed_Shell_Bch_30x30_Volleyball01
				Sk3Ed_Shell_Bch_30x30_BeachTent01
				Sk3Ed_Shell_Bch_30x30_Umbrella01
				Sk3Ed_Shell_Bch_30x30_ShortLamp01
				Sk3Ed_Shell_Bch_30x30_GarbageCan01
			]
			// shell 2
			[
				Sk3Ed_Shell_Bch_Col_30x30_01
				Sk3Ed_Shell_Bch_Island01
				Sk3Ed_Shell_Bch_30x30_ShortWall01
				Sk3Ed_Shell_Bch_30x30_Sand01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_High01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_Low01
				Sk3Ed_Shell_Bch_30x30_Reflection01
				Sk3Ed_Shell_Bch_30x30_Surf01
				Sk3Ed_Shell_Bch_30x30_Planter01
				Sk3Ed_Shell_Bch_30x30_Sidewalk01
				Sk3Ed_Shell_Bch_30x30_Barrier01
				Sk3Ed_Shell_Bch_30x30_Barrier_Reflection01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_Reflection01
				Sk3Ed_Shell_Bch_30x30_PalmTree01
				Sk3Ed_Shell_Bch_30x30_PalmTree02
				Sk3Ed_Shell_Bch_30x30_PalmTree03
				Sk3Ed_Shell_Bch_30x30_Plaza01
				Sk3Ed_Shell_Bch_30x30_LowPalm01
				Sk3Ed_Shell_Bch_30x30_Storefront01
				Sk3Ed_Shell_Bch_30x30_HighRise01
				Sk3Ed_Shell_Bch_30x30_Hotel01
				Sk3Ed_Shell_Bch_30x30_SandPlaza01
				Sk3Ed_Shell_Bch_30x30_Volleyball01
				Sk3Ed_Shell_Bch_30x30_BeachTent01
				Sk3Ed_Shell_Bch_30x30_Umbrella01
				Sk3Ed_Shell_Bch_30x30_ShortLamp01
				Sk3Ed_Shell_Bch_30x30_GarbageCan01
			]
			// shell 3
			[
				Sk3Ed_Shell_Bch_Col_30x18_01
				Sk3Ed_Shell_Bch_Island01
				Sk3Ed_Shell_Bch_30x18_Floor01
				Sk3Ed_Shell_Bch_30x18_Floor02
				Sk3Ed_Shell_Bch_30x18_Planter01
				Sk3Ed_Shell_Bch_30x18_Barrier01
				Sk3Ed_Shell_Bch_30x18_Barrier_Reflection01
				Sk3Ed_Shell_Bch_30x18_PalmTree02
				Sk3Ed_Shell_Bch_30x18_PalmTree03
				Sk3Ed_Shell_Bch_30x30_ShortWall01
				Sk3Ed_Shell_Bch_30x30_Sand01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_High01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_Low01
				Sk3Ed_Shell_Bch_30x30_Reflection01
				Sk3Ed_Shell_Bch_30x30_Surf01
				Sk3Ed_Shell_Bch_30x30_Planter01
				Sk3Ed_Shell_Bch_30x30_Sidewalk01
				Sk3Ed_Shell_Bch_30x30_Barrier01
				Sk3Ed_Shell_Bch_30x30_Barrier_Reflection01
				Sk3Ed_Shell_Bch_30x30_StreetLamp_Reflection01
				Sk3Ed_Shell_Bch_30x30_PalmTree01
				Sk3Ed_Shell_Bch_30x30_PalmTree02
				Sk3Ed_Shell_Bch_30x30_PalmTree03
				Sk3Ed_Shell_Bch_30x30_Plaza01
				Sk3Ed_Shell_Bch_30x30_LowPalm01
				Sk3Ed_Shell_Bch_30x30_Storefront01
				Sk3Ed_Shell_Bch_30x30_HighRise01
				Sk3Ed_Shell_Bch_30x30_Hotel01
				Sk3Ed_Shell_Bch_30x30_SandPlaza01
				Sk3Ed_Shell_Bch_30x30_Volleyball01
				Sk3Ed_Shell_Bch_30x30_BeachTent01
				Sk3Ed_Shell_Bch_30x30_Umbrella01
				Sk3Ed_Shell_Bch_30x30_ShortLamp01
				Sk3Ed_Shell_Bch_30x30_GarbageCan01
			]
			// shell 3
			[
				Sk3Ed_Shell_Bch_Col_80x6_01
				Sk3Ed_Shell_Bch_Island01
				Sk3Ed_Shell_Bch_80x6_ShortWall01
				Sk3Ed_Shell_Bch_80x6_Sand01
				Sk3Ed_Shell_Bch_80x6_StreetLamp_High01
				Sk3Ed_Shell_Bch_80x6_StreetLamp_Low01
				Sk3Ed_Shell_Bch_80x6_Sidewalk01
				Sk3Ed_Shell_Bch_80x6_StreetLamp_Reflection01
				Sk3Ed_Shell_Bch_80x6_Plaza01
				Sk3Ed_Shell_Bch_80x6_Surf01
				Sk3Ed_Shell_Bch_80x6_HighRise01
				Sk3Ed_Shell_Bch_80x6_BeachTent01
				Sk3Ed_Shell_Bch_80x6_Umbrella01
				Sk3Ed_Shell_Bch_80x6_ShortLamp01
				Sk3Ed_Shell_Bch_80x6_SandPlaza01
				Sk3Ed_Shell_Bch_80x6_Planter01
				Sk3Ed_Shell_Bch_80x6_PalmTree01
				Sk3Ed_Shell_Bch_80x6_PalmTree02
				Sk3Ed_Shell_Bch_80x6_PalmTree03
				Sk3Ed_Shell_Bch_80x6_PalmTree04
				Sk3Ed_Shell_Bch_80x6_GarbageCan01
				Sk3Ed_Shell_Bch_80x6_Hotel01
				Sk3Ed_Shell_Bch_80x6_LowPalm01
				Sk3Ed_Shell_Bch_80x6_Storefront01
				Sk3Ed_Shell_Bch_80x6_Barrier01
				Sk3Ed_Shell_Bch_80x6_Barrier_Reflection01
				Sk3Ed_Shell_Bch_80x6_Reflection01
			]
		]
	}
]







Editor_Set_Names=[
	{
		set = Restarts
		name = 'Restarts'
		row_scale = 4.5
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = Gaps
		name = 'Gaps'
		row_scale = 4.5
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = BigOb1
		name = 'Big Objects 1'
		row_scale = 1.0
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.0
	}
	{
		set = BigOb2
		name = 'Big Objects 2'
		row_scale = 1.0
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.0
	}
	{
		set = BigOb3
		name = 'Trailers'
		row_scale = 2.2
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.0
	}
	{
		set = Funboxes
		name = 'Funboxes'
		row_scale = 1.2
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.0
	}
	{
		set = FunboxesG
		name = 'Funboxes - Generic'
		row_scale = 2.5
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.0
	}
	{
		set = Benches
		name = 'Benches / Tables'
		row_scale = 3.0
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = Walls
		name = 'Walls'
		row_scale = 6.0
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = QPs
		name = 'QPs'
		row_scale = 2.5
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = QPRail
		name = 'QPs with rails'
		row_scale = 2.5
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = Pools
		name = 'Pools'
		row_scale = 2.0
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.0
	}
	{
		set = Rails
		name = 'Rails'
		row_scale = 3.0
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = RailSide
		name = 'Side Rails'
		row_scale = 3.0
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = Slopes
		name = 'Slopes'
		row_scale = 3.2
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = SlopeRail
		name = 'Slopes with rails'
		row_scale = 2.5
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = Stairs
		name = 'Stairs'
		row_scale = 4.5
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = StairsRail
		name = 'Stairs with rails'
		row_scale = 3.0
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.5
	}
	{
		set = Greenery
		name = 'Vegetation'
		row_scale = 3.0
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.0
	}
	{
		set = Misc
		name = 'Misc'
		row_scale = 4.5
		// if piece selected, scale will be row_scale * selected_scale_mult
		selected_scale_mult = 1.0
	}
]






; Explanation of lighting system
;
; Lighting for each point consists of a certain amount of ambient light
; and a certain amount of light from invisible spotlights overhead.
;
; The formula is:
; ambient_const * color + falloff_const * Sum(1 / Square(Dist(p, spotlight(L))), L = 1 to total_lights)
;
; where:
; color = existing color for the point in (R,G,B,A)
; Dist(p, spotlight(L)) = distance from point to spotlight
;
; If you want NONE of the lighting in the park to come from spotlights (the
; whole park is evenly lit), use ambient_const = 1.0, falloff_const = 0.
; If you want ALL the lighting to come from spotlights (some areas are lit,
; some are pitch black), use ambient_const = 0, falloff_const = X.
;
; The light positions are in terms of park cell coordinates. The
; light will be positioned over the northwest corner of the cell
; given

Editor_Light_Info=[
	[

		// only one sche set up for new park editor
		{
			// 16 X 16
			ambient_const = 0.5
			ambient_rgb = (1.0,1.0,0.96)
			falloff_const = 160000.0
			falloff_rgb = (0.39,0.38,0.32)
			cursor_ambience=1.5
			pos=[
				(6,10,6)
				(6,10,-6)
				(-6,10,-6)
				(-6,10,6)
			]
		}


		// theme 0, school
		{
			// 16 X 16
			ambient_const = 1.0
			ambient_rgb = (1.0,1.0,0.96)
			falloff_const = 160000.0
			falloff_rgb = (0.39,0.38,0.32)
			cursor_ambience=1.5
			pos=[
				(4,10,4)
				(12,10,4)
				(4,10,12)
				(12,10,12)
			]
		}
		{
			// 24 X 24
			ambient_const = 1.0
			ambient_rgb = (1.0,1.0,0.96)
			falloff_const = 215000.0
			falloff_rgb = (0.39,0.38,0.32)
			cursor_ambience=1.5
			pos=[
				(6,12,6)
				(18,12,6)
				(6,12,18)
				(18,12,18)
			]
		}
		{
			// 30 X 30
			ambient_const = 1.0
			ambient_rgb = (1.0,1.0,0.96)
			falloff_const = 270000.0
			falloff_rgb = (0.39,0.38,0.32)
			cursor_ambience=1.5
			pos=[
				(8,12,8)
				(22,12,8)
				(8,12,22)
				(22,12,22)
			]
		}
		{
			// 30 X 18
			ambient_const = 1.0
			ambient_rgb = (1.0,1.0,0.96)
			falloff_const = 235000.0
			falloff_rgb = (0.39,0.38,0.32)
			cursor_ambience=1.5
			pos=[
				(5,12,8)
				(5,12,22)
				(13,12,8)
				(13,12,22)
			]
		}
		{
			// 80 X 6
			ambient_const = 1.0
			ambient_rgb = (1.0,1.0,0.96)
			falloff_const = 235000.0
			falloff_rgb = (0.39,0.38,0.32)
			cursor_ambience=1.5
			pos=[
				(3,12,5)
				(3,12,15)
				(3,12,25)
				(3,12,35)
				(3,12,45)
				(3,12,55)
				(3,12,65)
				(3,12,75)
			]
		}
	]
	[
		// theme 1, indoor
		{
			// 16 X 16
			ambient_const = 0.9
			ambient_rgb = (0.9,0.9,1.0)
			falloff_const = 90000.0
			falloff_rgb = (0.45,0.45,0.32)
			cursor_ambience=1.5
			pos=[
				(4,10,4)
				(12,10,4)
				(4,10,12)
				(12,10,12)
			]
		}
		{
			// 24 X 24
			ambient_const = 0.9
			ambient_rgb = (0.9,0.9,1.0)
			falloff_const = 160000.0
			falloff_rgb = (0.45,0.45,0.32)
			cursor_ambience=1.5
			pos=[
				(6,12,6)
				(18,12,6)
				(6,12,18)
				(18,12,18)
			]
		}
		{
			// 30 X 30
			ambient_const = 0.9
			ambient_rgb = (0.9,0.9,1.0)
			falloff_const = 200000.0
			falloff_rgb = (0.45,0.45,0.32)
			cursor_ambience=1.5
			pos=[
				(8,12,8)
				(22,12,8)
				(8,12,22)
				(22,12,22)
			]
		}
		{
			// 30 X 18
			ambient_const = 0.9
			ambient_rgb = (0.9,0.9,1.0)
			falloff_const = 150000.0
			falloff_rgb = (0.45,0.45,0.32)
			cursor_ambience=1.5
			pos=[
				(5,12,8)
				(5,12,22)
				(13,12,8)
				(13,12,22)
			]
		}
		{
			// 80 X 6
			ambient_const = 0.9
			ambient_rgb = (0.9,0.9,1.0)
			falloff_const = 120000.0
			falloff_rgb = (0.45,0.45,0.32)
			cursor_ambience=1.5
			pos=[
				(3,10,5)
				(3,10,15)
				(3,10,25)
				(3,10,35)
				(3,10,45)
				(3,10,55)
				(3,10,65)
				(3,10,75)
			]
		}
	]
	[
		// theme 2, beach
		{
			// 16 X 16
			ambient_const = 1.3
			ambient_rgb = (.96,.96,1.0)
			falloff_const = 150000.0
			falloff_rgb = (0.3,0.3,0.3)
			cursor_ambience=1.5
			pos=[
				(4,10,4)
				(12,10,4)
				(4,10,12)
				(12,10,12)
			]
		}
		{
			// 24 X 24
			ambient_const = 1.3
			ambient_rgb = (.96,.96,1.0)
			falloff_const = 200000.0
			falloff_rgb = (0.3,0.3,0.3)
			cursor_ambience=1.5
			pos=[
				(6,12,6)
				(18,12,6)
				(6,12,18)
				(18,12,18)
			]
		}
		{
			// 30 X 30
			ambient_const = 1.3
			ambient_rgb = (.96,.96,1.0)
			falloff_const = 250000.0
			falloff_rgb = (0.3,0.3,0.3)
			cursor_ambience=1.5
			pos=[
				(8,12,8)
				(22,12,8)
				(8,12,22)
				(22,12,22)
			]
		}
		{
			// 30 X 18
			ambient_const = 1.3
			ambient_rgb = (.96,.96,1.0)
			falloff_const = 220000.0
			falloff_rgb = (0.3,0.3,0.3)
			cursor_ambience=1.5
			pos=[
				(5,12,8)
				(5,12,22)
				(13,12,8)
				(13,12,22)
			]
		}
		{
			// 80 X 6
			ambient_const = 1.3
			ambient_rgb = (.96,.96,1.0)
			falloff_const = 220000.0
			falloff_rgb = (0.3,0.3,0.3)
			cursor_ambience=1.5
			pos=[
				(3,10,5)
				(3,10,15)
				(3,10,25)
				(3,10,35)
				(3,10,45)
				(3,10,55)
				(3,10,65)
				(3,10,75)
			]
		}
	]
]





