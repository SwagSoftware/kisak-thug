Ed_Resources_Info={
	// If we are running out of memory on the park editor heap,
	// increase this value. If we are running out of memory in the
	// editor, but it's not on the editor heap, then decrease
	// this value
	// used to be 3.2M
	heap=900000

	// Mess with these only if we run out of memory in a specific pool
	in_railpoint_pool=3000
	in_railstring_pool=2400
	out_railpoint_pool=4000
	out_railstring_pool=2000

	// script components used by created node array
	// 81000=total size of component pool, defined in gel\scripting\init.cpp
	// 37230=components used at start of load_level script in levels.q
	max_components=43770 // 75000 - 31000 used by other things
	max_vectors=7721 // 9000 - 1279 used by other things

	// See the DMA_Usage structure also in this file.
	max_dma_pieces=3336

	// To calculate the mysterious main_heap_pad:
	// Measure the BottomUp free memory during editing of the park, using 'q dumpheaps exactvalues'
	// Add the frag and free to get the total free, and call this MHF(edit)
	// Now quit, and play the park, using just one player in free skate.
	// Measure the free mem again, but don't add in the frag, cos this is not utilizable yet.
	// Call this MHF(play)
	// The main_heap_pad is then MHF(edit)-MHF(play)+200000

	// TODO: Tweak the NGC & XBox values accordingly
	main_heap_pad =[ -595888 600000 -994112 ]    // [ PS2 NGC XBox]

	theme_pad=
	[
		0           // Suburbia, the biggest theme, hence no pad
		335872      // Rooftop
		897968      // Island
		485168      // Warehouse
		556016      // Prison
	]

	park_heap_pad=10000

	// This number indicates amount of memory used on main heap
	// (Ie, the value of usage_info.mMainHeapFree after calling GetResourceUsageInfo)
	// in an empty tiny park in suburbia. (Tiny = smallest size park possible)
	// First number is PS2, second GameCube, third X-box
	// The memory gauge will always indicate full when the main heap free has dropped to zero, but the
	// main_heap_base controls how full it indicates for a tiny park, and by convention a tiny park is chosen
	// to show an empty gauge.
	main_heap_base=[6581960 15311372 12997728]
	// Same as above but for the park heap
	park_heap_base=823728

	// component_use_base = components used when choosing test play of empty park - components used at start of load_level script
	component_use_base=1180 // used by park editor for empty park
	vector_use_base=1156 // used by park editor for empty park

	// for estimating whether or not it's safe to resize park
	floor_piece_size_main=1400
	floor_piece_size_park=200
}

// Indicates the contribution to dma usage for pieces that have wibbling on them.
// Regular pieces have a contribution of 1 piece, and do not need to be listed here.
// Pieces with wibbling effectively contribute more than one piece, so do need to be listed here.
// When changing/ading to these, ensure the max DMA usage in a 32x32 or 48x48 park
// is well under 600K
DMA_Usage=
{
	// These are the worst, with wibbling
	Sk3Ed_MLa_20x20=15       ; 2x2 lava
	Sk5ed_lava1square=15     ; 1x1 lava
	Sk3Ed_MWa_20x20=15	 	 ; 2x2 Water
	Sk5ed_Water1square=15	 ; 1x1 Water

	// wibbling, but less passes.  Will still crash if lower than 6
	Sk3Ed_Gb_10x10=6		; small bush planter
	Sk3Ed_Gt_20x20=15		; tree planter

	// Simpler, no wibble, but low polygon density means we have to count them as more
	// Actually all work fine at 1
	//	sk5ed_Grass1square=1
	//	sk5ed_Grass=1
	//	sk5ed_sand=1
	//	sk5ed_sand01=1


}

// This is the text that appears above the clipboard piece menu.
// Each piece has the same title.
// Note: Must restart park editor for any changes to this to take effect.
ClipboardTitle='Clipboard'

Ed_max_dim=40
Ed_default_inner_dim=24

Ed_piece_sets=[
	{
		name="Restarts"
		first=Sk3Ed_RS_1p
	}
	{
		name="Team Flags"
		first=Sk4Ed_Team_Blue
		no_gamecube
	}
	{
		name="Tools"
		first=Sk5Ed_Sel_01
	}
	{
		name="Clipboard"    // If this name changes, update parked.cpp, where a comparison with
		// the checksum of the name is done.
		clipboard_set
	}
	{
		name="Benches"
		first=Sk3Ed_Bs_01
	}
	{
		name="Big Pools"
		first=Sk3Ed_PB_Sul
	}
	{
		name="Buildings/Trailers"
		first=Sk3Ed_MTra_01
	}
	{
		name="Funboxes 1"
		first=Sk3Ed_FB_Tok01
	}
	{
		name="Funboxes Generic"
		first=Sk3Ed_FB_30x30x4_01
	}
	{
		name="Pipes/Tunnels"
		first=Sk3Ed_PB_SubHp01
	}
	{
		name="Kickers"
		first=Sk4Ed_SF2_TnAKicker01
	}
	{
		name="Walls"
		first=sk5ed_shortwall
	}
	{
		name="Quarter Pipes"
		first=Sk3Ed_QPd_10x10x8
	}
	{
		name="Pool Parts"
		first=Sk3Ed_P_10x10x8
	}
	{
		name="Rails"
		first=Sk3Ed_RAi_10x10x4
	}
	{
		name="Other Rails"
		first=Sk4Ed_SF2_TnAPipe01
	}
	{
		name="Slopes"
		first=Sk3Ed_S_10x10x4
	}
	{
		name="Stairs"
		first=Sk3Ed_ST_10x10x2
	}
	{
		name="Greenery"
		first=Sk3Ed_Gt_20x20
	}
	{
		name="Miscellaneous"
		first=Sk3Ed_Dumpster01
	}
	{
		name="Ground Pieces"
		first=Sk3Ed_MWa_20x20
	}
	{
		name="Floors"
		first=floor_wall_block1
		hidden
	}
]

Ed_standard_metapieces=[
	// Restarts
	{
		single=Sk3Ed_RS_1p
		text_name='Player 1 Start'
		special_type=restart_1
	}
	{
		single=Sk3Ed_RS_Mp
		text_name='Player 2 Start'
		special_type=restart_multi
	}
	{
		single=Sk3Ed_Rs_Ho
		text_name='Multiplayer / Horse Start'
		special_type=restart_horse
	}
	{
		single=Sk3Ed_Rs_KOTH
		text_name='King of the Hill Crown Start'
		special_type=king_of_hill
	}
	// Team flags/CTF
	{
		single=Sk4Ed_Team_Blue
		text_name='Blue Team / CTF Base'
		special_type=blue_flag
	}
	{
		single=Sk4Ed_Team_Red
		text_name='Red Team / CTF Base'
		special_type=red_flag
	}
	{
		single=Sk4Ed_Team_Green
		text_name='Green Team / CTF Base'
		special_type=green_flag
	}
	{
		single=Sk4Ed_Team_Yellow
		text_name='Yellow Team / CTF Base'
		special_type=yellow_flag
	}
	//Gaps
	{
		single=Sk5Ed_Sel_01
		text_name='Area Selection'
		special_type=area_selection
	}
	{
		single=Sk3Ed_GAP_01
		text_name='Gap Placement Piece'
		special_type=gap_placement
	}
	{
		single=Sk3Ed_RAi_10x10x4
		name=rail_placement
		text_name='Rail Placement'
		special_type=rail_placement
	}
	//Benches
	{
		single=Sk3Ed_Bs_01
		text_name='Table'
	}
	{
		single=Sk3Ed_Bs_02
		text_name='Table Bench'
	}
	{
		single=Sk3Ed_Bs_03
		text_name='Corner Table'
	}
	{
		single=Sk3Ed_Bs_04
		text_name='Corner Table Bench'
	}
	{
		single=Sk3Ed_Bs_05
		text_name='Table On Dumpster'
	}
	{
		single=Sk3Ed_Bp_01
		text_name='Park Bench'
	}
	{
		single=Sk3Ed_Bp_02
		text_name='Corner Park Bench'
	}
	{
		single=Sk4Ed_SF2_Bench
		text_name='Conc Bench'
	}
	{
		single=Sk4Ed_SF2_BusStop
		text_name='Bus Stop'
	}
	{
		single=Sk4Ed_Alc_CrustyBench
		text_name='Crusty Bench'
	}
	{
		single=Sk4Ed_Alc_Bench
		text_name='Alcatraz Bench'
	}
	{
		single=sk5ed_Alc_corner
		text_name='Alcatraz Corner'
	}
	{
		single=sk5ed_Alc_Bleachers
		text_name='Alcatraz Bleachers'
	}
	{
		single=Sk3Ed_PB_Stairs01
		text_name='Bleachers'
	}
	{
		single=sk5ed_sdBench
		text_name='SD Bench'
	}
	//Big Pools
	{
		single=Sk3Ed_PB_Sul
		text_name='S Bowl'
	}
	{
		single=Sk3Ed_PB_Nude
		text_name='N Bowl'
	}
	{
		single=Sk3Ed_PB_Pool01
		text_name='Rectangle Pool'
	}
	{
		single=Sk3Ed_PB_Pool02
		text_name='Bowl'
	}
	{
		single=Sk3Ed_PB_Pool03
		text_name='Clover Bowl'
	}
	{
		single=sk5ed_ShipPool
		text_name='Cruise Ship Pool'
	}
	// Buildings and Trailers
	{
		single=Sk3Ed_MTra_01
		text_name='RV'
	}
	{
		single=Sk3Ed_MTra_02
		text_name='Trailer'
	}
	{
		single=Sk4Ed_SF2_Bus
		text_name='Traincar'
	}
	{
		single=sk5ed_Smallhouse
		text_name='Small House'
	}
	{
		single=sk5ed_House_Ladder
		text_name='Big House'
	}
	{
		single=sk5ed_Rooftop
		text_name='SC2 Building'
	}
	{
		single=sk5ed_BigSkyscraper
		text_name='Big Skyscraper'
	}
	{
		single=sk5ed_hut
		text_name='Hut'
	}
	{
		single=sk5ed_Ghetto
		text_name='House Projects'
	}
	//Funboxes 1
	{
		single=Sk3Ed_FB_Tok01
		text_name='Tokyo Mega'
	}
	{
		single=Sk3Ed_FB_Tok02
		text_name='Tokyo Low Wall'
	}
	{
		single=Sk3Ed_FB_Rio01
		text_name='Rio Quiksilver Box'
	}
	{
		single=sk5ed_Tok_Big
		text_name='Tokyo Box'
	}
	{
		single=Sk3Ed_FB_SI01
		text_name='SI Multi Step'
	}
	{
		single=Sk3Ed_FB_SI02
		text_name='SI Wall Box'
	}
	{
		single=Sk3Ed_FB_Sub02
		text_name='Suburbia Hump'
	}
	{
		single=Sk3Ed_FB_Sub03
		text_name='Suburbia Box'
	}
	//Funboxes Generic
	{
		single=Sk3Ed_FB_30x30x4_01
		text_name='Low Med'
	}
	{
		single=Sk3Ed_FB_30x30x4_02
		text_name='Low Oct'
	}
	{
		single=Sk3Ed_FB_30x30x4_03
		text_name='Low Long Med'
	}
	{
		single=Sk3Ed_FB_30x30x4_04
		text_name='Low Long Oct'
	}
	{
		single=Sk3Ed_FB_30x30x8_01
		text_name='High Med'
	}
	{
		single=Sk3Ed_FB_30x30x8_02
		text_name='High Oct'
	}
	{
		single=Sk3Ed_FB_30x30x8_03
		text_name='High Long Med'
	}
	{
		single=Sk3Ed_FB_30x30x8_04
		text_name='High Long Oct'
	}
	//Pipes and Tunnels
	{
		single=Sk3Ed_PB_SubHp01
		text_name='Sub Halfpipe'
	}
	{
		single=sk5ed_fullpipe_qps
		text_name='Full Pipe Qps'
	}
	{
		single=sk5ed_fullpipe_walls
		text_name='Full Pipe Walls'
	}
	{
		single=Sk5Ed_HPTunnel_01
		text_name='HP Tunnel'
	}
	{
		single=Sk3Ed_MLo_01
		text_name='Loop'
	}
	{
		single=sk5ed_Underground
		text_name='Underground'
	}
	{
		single=sk5ed_UndergroundRailed
		text_name='Underground Railed'
	}
	{
		single=sk5ed_undergroundStraight
		text_name='Underground Straight'
	}
	{
		single=sk5ed_undergroundStraightRailed
		text_name='Underground Railed Straight'
	}
	{
		single=sk5ed_UndergroundCurved
		text_name='Underground Curved'
	}
	//Kickers
	{
		single=Sk4Ed_SF2_TnAKicker01
		text_name='Kicker 1'
	}
	{
		single=Sk4Ed_Alc_Kicker
		text_name='Kicker 2'
	}
	{
		single=sk5ed_Tightkicker
		text_name='Tight Kicker'
	}
	{
		single=sk5ed_KickerWall
		text_name='Kicker Wall'
	}
	{
		single=Sk5ED_BoobB_03
		text_name='Small Boob'
	}
	{
		single=Sk5ED_BoobB_02
		text_name='Medium Boob'
	}
	{
		single=Sk5ED_BoobB_01
		text_name='Big Boob'
	}
	//Walls
	{
		single=sk5ed_shortwall
		text_name='Lowest'
	}
	{
		single=Sk3Ed_W_10x10x2
		text_name='Low'
	}
	{
		single=Sk3Ed_W_10x10x5
		text_name='High'
	}
	{
		single=Sk5Ed_W_10x10x06_01
		text_name='Higher'
	}
	{
		single=Sk5Ed_W_10x10x06_02
		text_name='Highest'
	}
	{
		single=Sk5Ed_W_Slated_01
		text_name='Slanted'
	}
	{
		single=Sk5Ed_RA_10x10x15_04
		text_name='High With Rail'
	}
	{
		single=Sk5Ed_RA_10x10x15_03
		text_name='Higher With Rail'
	}
	{
		single=Sk5Ed_RA_10x10x15_02
		text_name='Highest With Rail'
	}
	{
		single=Sk5ed_LAcurve
		text_name='LA Curve'
	}
	{
		single=Sk5ed_LAstraight
		text_name='LA Straight Curb'
	}
	{
		single=Sk5Ed_SideWall
		text_name='Side Wall'
	}
	{
		single=Sk5Ed_BigSideWall
		text_name='Big Side Wall'
	}
	{
		single=Sk5Ed_90Wall
		text_name='90 Wall'
	}
	{
		single=sk5ed_curvedLedge
		text_name='Curved Ledge Short'
	}
	{
		single=sk5ed_curvedLedge01
		text_name='Curved Ledge Medium'
	}
	{
		single=sk5ed_curvedLedge02
		text_name='Curved Ledge High'
	}
	{
		single=sk5ed_curvedLedge03
		text_name='Curved Ledge Highest'
	}
	{
		single=sk5ed_curvedLedge04
		text_name='Curved Ledge Low'
	}
	{
		single=sk5ed_Shortwall01
		text_name='Short Wall'
	}
	{
		single=Sk3Ed_We_10x10x5
		text_name='High End'
	}
	{
		single=Sk3Ed_We_10x10x2
		text_name='Low Connector'
	}
	//QPs
	{
		single=Sk3Ed_QPd_10x10x8
		text_name='Low Short'
	}
	{
		multiple=[
			{Sk3Ed_QPd_10x10x8	[0 0 0]}
			{Sk3Ed_QPd_10x10x8	[1 0 0]}
		]
		name=Low_Med
		text_name='Low Med'
	}
	{
		multiple=[
			{Sk3Ed_QPd_10x10x8	[0 0 0]}
			{Sk3Ed_QPd_10x10x8	[1 0 0]}
			{Sk3Ed_QPd_10x10x8	[2 0 0]}
			{Sk3Ed_QPd_10x10x8	[3 0 0]}
		]
		name=Low_Long
		text_name='Low Long'
	}
	{
		multiple=[
			{Sk3Ed_Ru1b_10x10x4	[0 0 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[0 1 0]	riser}
			{Sk3Ed_Fu1_10x10 	[0 2 0]	riser}
			{Sk3Ed_QPd_10x10x8	[0 0 1]}
		]
		name=Low_Short_Deck
		text_name='Low Short Deck'
	}
	{
		multiple=[
			{Sk3Ed_Ru1b_10x10x4	[0 0 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[0 1 0]	riser}
			{Sk3Ed_Fu1_10x10 	[0 2 0]	riser}
			{Sk3Ed_Ru1b_10x10x4	[1 0 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[1 1 0]	riser}
			{Sk3Ed_Fu1_10x10 	[1 2 0]	riser}
			{Sk3Ed_QPd_10x10x8	[0 0 1]}
			{Sk3Ed_QPd_10x10x8	[1 0 1]}
		]
		name=Low_Med_Deck
		text_name='Low Med Deck'
	}
	{
		multiple=[
			{Sk3Ed_Ru1b_10x10x4	[0 0 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[0 1 0]	riser}
			{Sk3Ed_Fu1_10x10 	[0 2 0]	riser}
			{Sk3Ed_Ru1b_10x10x4	[1 0 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[1 1 0]	riser}
			{Sk3Ed_Fu1_10x10 	[1 2 0]	riser}
			{Sk3Ed_Ru1b_10x10x4	[2 0 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[2 1 0]	riser}
			{Sk3Ed_Fu1_10x10 	[2 2 0]	riser}
			{Sk3Ed_Ru1b_10x10x4	[3 0 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[3 1 0]	riser}
			{Sk3Ed_Fu1_10x10 	[3 2 0]	riser}
			{Sk3Ed_QPd_10x10x8	[0 0 1]}
			{Sk3Ed_QPd_10x10x8	[1 0 1]}
			{Sk3Ed_QPd_10x10x8	[2 0 1]}
			{Sk3Ed_QPd_10x10x8	[3 0 1]}
		]
		name=Low_Long_Deck
		text_name='Low Long Deck'
	}
	{
		single=Sk3Ed_QPi_10x10x8
		text_name='Low Inside Corner'
	}
	{
		single=Sk3Ed_QPo_10x10x8
		text_name='Low Outside Corner'
	}
	{
		single=Sk3Ed_QPdi_10x10x8
		text_name='Low Inside Corner Deck'
	}
	{
		single=Sk3Ed_QPdo_10x10x8
		text_name='Low Outside Corner Deck'
	}
	{
		single=Sk3Ed_QPd_10x10x12
		text_name='High Short'
	}
	{
		multiple=[
			{Sk3Ed_QPd_10x10x12	[0 0 0]}
			{Sk3Ed_QPd_10x10x12	[1 0 0]}
		]
		name=High_Med
		text_name='High Med'
	}
	{
		multiple=[
			{Sk3Ed_QPd_10x10x12	[0 0 0]}
			{Sk3Ed_QPd_10x10x12	[1 0 0]}
			{Sk3Ed_QPd_10x10x12	[2 0 0]}
			{Sk3Ed_QPd_10x10x12	[3 0 0]}
		]
		name=High_Long
		text_name='High Long'
	}
	{
		multiple=[
			{Sk3Ed_Ru1b_10x10x4	[0 0 0]	riser}
			{Sk3Ed_Ru1m_10x10x4	[0 1 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[0 2 0]	riser}
			{Sk3Ed_Fu1_10x10 	[0 3 0]	riser}
			{Sk3Ed_QPd_10x10x12	[0 0 1]}
		]
		name=High_Short_Deck
		text_name='High Short Deck'
	}
	{
		multiple=[
			{Sk3Ed_Ru1b_10x10x4	[0 0 0]	riser}
			{Sk3Ed_Ru1m_10x10x4	[0 1 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[0 2 0]	riser}
			{Sk3Ed_Fu1_10x10 	[0 3 0]	riser}
			{Sk3Ed_Ru1b_10x10x4	[1 0 0]	riser}
			{Sk3Ed_Ru1m_10x10x4	[1 1 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[1 2 0]	riser}
			{Sk3Ed_Fu1_10x10 	[1 3 0]	riser}
			{Sk3Ed_QPd_10x10x12	[0 0 1]}
			{Sk3Ed_QPd_10x10x12	[1 0 1]}
		]
		name=High_Med_Deck
		text_name='High Med Deck'
	}
	{
		multiple=[
			{Sk3Ed_Ru1b_10x10x4	[0 0 0]	riser}
			{Sk3Ed_Ru1m_10x10x4	[0 1 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[0 2 0]	riser}
			{Sk3Ed_Fu1_10x10 	[0 3 0]	riser}
			{Sk3Ed_Ru1b_10x10x4	[1 0 0]	riser}
			{Sk3Ed_Ru1m_10x10x4	[1 1 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[1 2 0]	riser}
			{Sk3Ed_Fu1_10x10 	[1 3 0]	riser}
			{Sk3Ed_Ru1b_10x10x4	[2 0 0]	riser}
			{Sk3Ed_Ru1m_10x10x4	[2 1 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[2 2 0]	riser}
			{Sk3Ed_Fu1_10x10 	[2 3 0]	riser}
			{Sk3Ed_Ru1b_10x10x4	[3 0 0]	riser}
			{Sk3Ed_Ru1m_10x10x4	[3 1 0]	riser}
			{Sk3Ed_Ru1t_10x10x4	[3 2 0]	riser}
			{Sk3Ed_Fu1_10x10 	[3 3 0]	riser}
			{Sk3Ed_QPd_10x10x12	[0 0 1]}
			{Sk3Ed_QPd_10x10x12	[1 0 1]}
			{Sk3Ed_QPd_10x10x12	[2 0 1]}
			{Sk3Ed_QPd_10x10x12	[3 0 1]}
		]
		name=High_Long_Deck
		text_name='High Long Deck'
	}
	{
		single=Sk3Ed_QPi_10x10x12
		text_name='High Inside Corner'
	}
	{
		single=Sk3Ed_QPo_10x10x12
		text_name='High Outside Corner'
	}
	{
		single=Sk3Ed_QPdi_10x10x12
		text_name='High Inside Corner Deck'
	}
	{
		single=Sk3Ed_QPdo_10x10x12
		text_name='High Outside Corner Deck'
	}
	{
		single=Sk3Ed_QPdR_10x10x4
		text_name='4ft Rollin'
	}
	{
		single=Sk3Ed_QPdR_10x10x8
		text_name='8ft Rollin'
	}
	{
		single=Sk3Ed_QPdR_10x10x12
		text_name='12ft Rollin'
	}
	{
		single=Sk3Ed_QPdR_10x10x16
		text_name='16ft Rollin'
	}
	{
		single=Sk4Ed_SF2_PierWedge
		text_name='SF QP Rail transfer'
	}
	{
		single=Sk4Ed_SF2_Big
		text_name='Mega Rollin'
	}
	{
		single=Sk4Ed_Sch_Spine
		text_name='School Spine'
	}
	{
		single=Sk5Ed_QPshortMid_01
		text_name='Short QP'
	}


	//Pools
	{
		single=Sk3Ed_P_10x10x8
		text_name='Short'
	}
	{
		multiple=[
			{Sk3Ed_P_10x10x8	[0 0 0]}
			{Sk3Ed_P_10x10x8	[1 0 0]}
		]
		name=Med
		text_name='Med'
	}
	{
		multiple=[
			{Sk3Ed_P_10x10x8	[0 0 0]}
			{Sk3Ed_P_10x10x8	[1 0 0]}
			{Sk3Ed_P_10x10x8	[2 0 0]}
			{Sk3Ed_P_10x10x8	[3 0 0]}
		]
		name=Long
		text_name='Long'
	}
	{
		single=Sk3Ed_Pi_10x10x8
		text_name='Small Inside Corner'
	}
	{
		single=Sk3Ed_Pi_20x20x8
		text_name='Large Inside Corner'
	}
	{
		single=Sk3Ed_Po_10x10x8
		text_name='Outside Corner'
	}
	{
		single=Sk3Ed_Pdp_01
		text_name='Diving Platform'
	}
	{
		single=Sk3Ed_Pdb_01
		text_name='Diving Block'
	}
	//Rails
	{
		single=Sk3Ed_RAi_10x10x4
		text_name='Low Tight Corner'
	}
	{
		single=Sk3Ed_RAi_10x10x8
		text_name='Med Tight Corner'
	}
	{
		single=Sk3Ed_RAi_10x10x12
		text_name='High Tight Corner'
	}
	{
		single=Sk3Ed_RAi_20x20x4
		text_name='Low Corner'
	}
	{
		single=Sk3Ed_RAi_20x20x8
		text_name='Med Corner'
	}
	{
		single=Sk3Ed_RAi_20x20x12
		text_name='High Corner'
	}
	{
		single=sk5ed_Railroad
		text_name='Railroad'
	}
	{
		single=sk5ed_Railroad90
		text_name='Railroad 90'
	}
	{
		single=sk5ed_Srail
		text_name='S Rail'
	}
	{
		single=sk5ed_Srailcenter
		text_name='S Rail Center'
	}
	{
		single=sk5ed_SDRail
		text_name='SD Rail'
	}

	//Other Rails
	{
		single=Sk4Ed_SF2_TnAPipe01
		text_name='3rd Piping 1'
	}
	{
		single=Sk4Ed_SF2_TnAPipe02
		text_name='3rd Piping 2'
	}
	{
		single=Sk4Ed_SF2_TnAPipe03
		text_name='3rd Piping 3'
	}
	{
		single=sk5ed_wavysmall
		text_name='Wavy Concrete'
	}
	{
		single=sk5ed_wavyconcretebig
		text_name='Wavy Concrete Big'
	}
	{
		single=sk5ed_curveconcrete
		text_name='Wavy Concrete Curved'
	}
	{
		single=sk5ed_upcurve
		text_name='Wavy Concrete Up'
	}
	{
		single=sk5ed_Swingrail
		text_name='Swing Rail'
	}
	{
		single=sk5ed_AP_Walkway
		text_name='AP Walkway'
	}
	{
		single=sk5ed_kink
		text_name='Kink'
	}
	//Slopes
	{
		single=Sk3Ed_S_10x10x4
		text_name='Low'
	}
	{
		single=Sk3Ed_Si_10x10x4
		text_name='Low Inside Corner'
	}
	{
		single=Sk3Ed_Si2_10x10x4
		text_name='Low Inside Decked Corner'
	}
	{
		single=Sk3Ed_So_10x10x4
		text_name='Low Outside Pyramid Corner'
	}
	{
		single=Sk3Ed_So2_10x10x4
		text_name='Low Outside Corner'
	}
	{
		single=Sk3Ed_S_10x10x8
		text_name='High'
	}
	{
		single=Sk3Ed_Si_10x10x8
		text_name='High Inside Corner'
	}
	{
		single=Sk3Ed_Si2_10x10x8
		text_name='High Inside Decked Corner'
	}
	{
		single=Sk3Ed_So_10x10x8
		text_name='High Outside Pyramid Corner'
	}
	{
		single=Sk3Ed_So2_10x10x8
		text_name='High Outside Corner'
	}
	{
		single=Sk3Ed_S_10x20x4
		text_name='Low Long'
	}
	{
		single=Sk3Ed_Si_20x20x4
		text_name='Low Long Inside Corner'
	}
	{
		single=Sk3Ed_Si2_20x20x4
		text_name='Low Long Inside Decked Corner'
	}
	{
		single=Sk3Ed_So_20x20x4
		text_name='Low Long Outside Pyramid Corner'
	}
	{
		single=Sk3Ed_So2_20x20x4
		text_name='Low Long Outside Corner'
	}
	{
		single=Sk3Ed_S_10x20x8
		text_name='High Long'
	}
	{
		single=Sk3Ed_Si_20x20x8
		text_name='High Long Inside Corner'
	}
	{
		single=Sk3Ed_Si2_20x20x8
		text_name='High Long Inside Decked Corner'
	}
	{
		single=Sk3Ed_So_20x20x8
		text_name='High Long Outside Pyramid Corner'
	}
	{
		single=Sk3Ed_So2_20x20x8
		text_name='High Long Outside Corner'
	}
	{
		single=sk5ed_45Launch
		text_name='45 Launch Ramp'
	}
	{
		single=sk5ed_45LaunchMed
		text_name='45 Launch Ramp Med'
	}
	{
		single=sk5ed_45LaunchLow
		text_name='45 Short Launch Ramp'
	}
	{
		single=sk5ed_45LaunchMed01
		text_name='45 Mid Launch Ramp'
	}
	{
		single=sk5ed_SlantedSmall
		text_name='Slanted Small Ramp'
	}
	{
		single=sk5ed_SlantedBig
		text_name='Slanted Big Ramp'
	}
	{
		single=sk5ed_SlantedTall01
		text_name='Slanted Tall Ramp'
	}
	{
		single=sk5ed_SlantedTall02
		text_name='Slanted Tall Corner Ramp'
	}
	{
		single=sk5ed_Test02
		text_name='Car Ramp'
	}
	//Stairs
	{
		single=Sk3Ed_ST_10x10x2
		text_name='Double'
	}
	{
		single=Sk3Ed_STi_10x10x2
		text_name='Double Inside Corner'
	}
	{
		single=Sk3Ed_STi2_10x10x2
		text_name='Double Inside Decked Corner'
	}
	{
		single=Sk3Ed_STo_10x10x2
		text_name='Double Outside Pyramid Corner'
	}
	{
		single=Sk3Ed_STo2_10x10x2
		text_name='Double Outside Corner'
	}
	{
		single=Sk3Ed_STio_10x10x2
		text_name='Double Inside/Outside Corner'
	}
	{
		single=Sk3Ed_ST_10x10x4
		text_name='Quad'
	}
	{
		single=Sk3Ed_STi_10x10x4
		text_name='Quad Inside Corner'
	}
	{
		single=Sk3Ed_STi2_10x10x4
		text_name='Quad Inside Decked Corner'
	}
	{
		single=Sk3Ed_STo_10x10x4
		text_name='Quad Outside Pyramid Corner'
	}
	{
		single=Sk3Ed_STo2_10x10x4
		text_name='Quad Outside Corner'
	}
	{
		single=Sk3Ed_STio_10x10x4
		text_name='Quad Inside/Outside Corner'
	}
	{
		single=Sk4Ed_Sch_BigStairs
		text_name='Big School Stair/Ramp'
	}
	{
		single=Sk5Ed_SF2_24Stair01
		text_name='24 Set'
	}
	//Greenery
	{
		single=Sk3Ed_Gt_20x20
		text_name='Tree Planter'
	}
	{
		single=Sk3Ed_Gb_20x10
		text_name='Long Bush Planter'
	}
	{
		single=Sk3Ed_Gb_10x10
		text_name='Small Bush Planter'
	}
	{
		single=Sk4Ed_SF2_Planter03
		text_name='Long Flower Planter'
	}
	{
		single=Sk4Ed_SF2_Planter01
		text_name='Short Flower Planter Blue'
	}
	{
		single=Sk4Ed_SF2_Planter02
		text_name='Short Flower Planter Pink'
	}
	{
		single=sk5ed_VCplanter_01
		text_name='VC Planter 1'
	}
	{
		single=sk5ed_VCplanter_02
		text_name='VC Planter 2'
	}
	{
		single=sk5ed_VCplanter_03
		text_name='VC Planter 3'
	}
	//Misc
	{
		single=Sk3Ed_Dumpster01
		text_name='Dumpster'
	}
	{
		single=Sk3Ed_Dumpster02
		text_name='Corner Dumpster'
	}
	{
		single=Sk3Ed_MFo_01
		text_name='Fountain'
	}
	{
		single=Sk4Ed_Sch_Fountain
		text_name='Flagpole fountain'
	}
	{
		single=Sk4Ed_Sch_Newsstands
		text_name='Newsstands 1'
	}
	{
		single=Sk4Ed_SF2_Newsstands
		text_name='Newsstands 2'
	}
	{
		single=Sk4Ed_SF2_TrashBox
		text_name='Trash Can'
	}
	{
		single=sk5ed_Billboard_Med
		text_name='Med Billboard'
	}
	{
		single=sk5ed_Billboard_big
		text_name='Big Billboard'
	}
	{
		single=sk5ed_Billboard_Med45
		text_name='Med Billboard 45'
	}
	{
		single=sk5ed_Billboard_big45
		text_name='Big Billboard 45'
	}
	{
		single=sk5ed_Tank
		text_name='Tank'
	}
	{
		single=sk5ed_freewaypole
		text_name='Freeway'
	}
	{
		single=sk5ed_freewaycurve
		text_name='Freeway Curve'
	}
	{
		single=sk5ed_curvedcurb
		text_name='Curved Curb'
	}
	{
		single=sk5ed_straightcurb
		text_name='Curb'
	}
	{
		single=sk5ed_bigtraffic
		text_name='Traffic Light 1'
	}
	{
		single=sk5ed_smalltraffic
		text_name='Traffic Light 2'
	}
	{
		single=sk5ed_straightcurbShort
		text_name='Curb Short'
	}
	{
		single=sk5ed_dock
		text_name='Dock'
	}
	{
		single=sk5ed_dockshort
		text_name='Dock Short'
	}
	{
		single=sk5ed_houseboat
		text_name='House Boat'
	}
	{
		single=sk5ed_tele01
		text_name='Telephone Pole 1'
	}
	{
		single=sk5ed_tele02
		text_name='Telephone Pole 2'
	}
	{
		single=sk5ed_Telewires
		text_name='Telephone Wires'
	}
	{
		single=sk5ed_Mailbox
		text_name='Mailbox'
	}
	{
		single=sk5ed_bbhoop
		text_name='Basketball Hoop'
	}
	{
		single=sk5ed_candy
		text_name='Candy Machine'
	}
	{
		single=sk5ed_heli
		text_name='Helicopter'
	}
	{
		single=sk5ed_NYlight
		text_name='NY Light'
	}
	{
		single=sk5ed_car
		text_name='Car'
	}
	//Ground
	{
		single=Sk3Ed_MWa_20x20
		text_name='Water'
	}
	{
		single=Sk5ed_Water1square
		text_name='Water 1 Square'
	}
	{
		single=Sk3Ed_MLa_20x20
		text_name='Lava'
	}
	{
		single=Sk5ed_lava1square
		text_name='Lava 1 Square'
	}
	{
		single=Sk3Ed_MPu_20x20x8
		text_name='Pungee Pit'
	}
	{
		single=sk5ed_Grass
		text_name='Grass'
	}
	{
		single=sk5ed_Grass1square
		text_name='Grass 1 Square'
	}
	{
		single=sk5ed_street
		text_name='Street'
	}
	{
		single=sk5ed_street_curve
		text_name='Curved street'
	}
	{
		single=sk5ed_sand
		text_name='Sand'
	}
	{
		single=sk5ed_sand01
		text_name='Sand 1 Square'
	}


	;{
	;	single=Sk4Ed_Fence_10x10
	;	text_name='Small fence'
	;}
	// riser
	// group 1 -- bottom level, not touching surface
	{
		multiple=[
			{Sk3Ed_Rd1b_10x10x4	[0 0 0]}
			{Sk3Ed_Fd1_10x10	[0 1 0]}
		]
		name=floor_wall_block1
		is_riser
	}
	{
		single=Sk3Ed_Rd1b_10x10x4
		name=wall_block1
		is_riser
		no_rails
	}
	{
		single=Sk3Ed_Fd1_10x10
		pos=[0 1 0]
		name=floor_block1
		is_riser
		no_rails
	}
	// group 2 -- not bottom level, not touching surface
	{
		multiple=[
			{Sk3Ed_Rd1m_10x10x4	[0 0 0]}
			{Sk3Ed_Fd1_10x10	[0 1 0]}
		]
		name=floor_wall_block2
		is_riser
	}
	{
		single=Sk3Ed_Rd1m_10x10x4
		name=wall_block2
		is_riser
		no_rails
	}
	{
		single=Sk3Ed_Fd1_10x10
		pos=[0 1 0]
		name=floor_block2
		is_riser
		no_rails
	}
	// group 3 -- not bottom level, just below surface
	{
		multiple=[
			{Sk3Ed_Rd1t_10x10x4	[0 0 0]}
			{Sk3Ed_F_10x10		[0 1 0]}
		]
		name=floor_wall_block3
		is_riser
	}
	{
		single=Sk3Ed_Rd1t_10x10x4
		name=wall_block3
		is_riser
		no_rails
	}
	{
		single=Sk3Ed_F_10x10
		pos=[0 1 0]
		name=floor_block3
		is_riser
		no_rails
	}
	// group 4 -- bottom level, just below surface
	{
		multiple=[
			{Sk3Ed_Rd1s_10x10x4	[0 0 0]}
			{Sk3Ed_F_10x10		[0 1 0]}
		]
		name=floor_wall_block4
		is_riser
	}
	{
		single=Sk3Ed_Rd1s_10x10x4
		name=wall_block4
		is_riser
		no_rails
	}
	{
		single=Sk3Ed_F_10x10
		pos=[0 1 0]
		name=floor_block4
		is_riser
		no_rails
	}
	// group 5 -- top level risers sitting on surface
	{
		multiple=[
			{Sk3Ed_Ru1s_10x10x4	[0 0 0]}
			{Sk3Ed_Fu1_10x10	[0 1 0]}
		]
		name=floor_wall_block5
		is_riser
	}
	{
		single=Sk3Ed_Ru1s_10x10x4
		name=wall_block5
		is_riser
		no_rails
	}
	{
		single=Sk3Ed_Fu1_10x10
		pos=[0 1 0]
		name=floor_block5
		is_riser
		no_rails
	}
	// group 6 -- risers sitting on surface, but not top level
	{
		multiple=[
			{Sk3Ed_Ru1b_10x10x4	[0 0 0]}
			{Sk3Ed_Fu1_10x10	[0 1 0]}
		]
		name=floor_wall_block6
		is_riser
	}
	{
		single=Sk3Ed_Ru1b_10x10x4
		name=wall_block6
		is_riser
		no_rails
	}
	{
		single=Sk3Ed_Fu1_10x10
		pos=[0 1 0]
		name=floor_block6
		is_riser
		no_rails
	}
	// group 7 -- risers sitting above surface, not top level
	{
		multiple=[
			{Sk3Ed_Ru1m_10x10x4	[0 0 0]}
			{Sk3Ed_Fu1_10x10	[0 1 0]}
		]
		name=floor_wall_block7
		is_riser
	}
	{
		single=Sk3Ed_Ru1m_10x10x4
		name=wall_block7
		is_riser
		no_rails
	}
	{
		single=Sk3Ed_Fu1_10x10
		pos=[0 1 0]
		name=floor_block7
		is_riser
		no_rails
	}
	// group 8 -- risers sitting above surface, top level
	{
		multiple=[
			{Sk3Ed_Ru1t_10x10x4	[0 0 0]}
			{Sk3Ed_Fu1_10x10	[0 1 0]}
		]
		name=floor_wall_block8
		is_riser
	}
	{
		single=Sk3Ed_Ru1t_10x10x4
		name=wall_block8
		is_riser
		no_rails
	}
	{
		single=Sk3Ed_Fu1_10x10
		pos=[0 1 0]
		name=floor_block8
		is_riser
		no_rails
	}
	{
		single=Sk4Ed_Fence_20x20
		text_name='Big fence'
	}
	;{
	;	single=Sk4Ed_Gap_10x10
	;}
]

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
// -When a piece is removed from the piece set, replace its name with 'Sk4Ed_Dead'. *DON'T DELETE THE ENTRY*.
Ed_Save_Map = [
	Sk3Ed_RS_1p
	Sk3Ed_RS_Mp
	Sk3Ed_Rs_Ho
	Sk3Ed_Rs_KOTH
	Sk3Ed_GAP_01
	Sk3Ed_PB_SubHp01
	Sk3Ed_PB_Sul
	Sk3Ed_MLo_01
	Sk3Ed_PB_Stairs01
	Sk3Ed_PB_Nude
	Sk3Ed_PB_Pool01
	Sk3Ed_PB_Pool02
	Sk3Ed_PB_Pool03
	Sk3Ed_MTra_01
	Sk3Ed_MTra_02
	Sk3Ed_FB_Tok01
	Sk3Ed_FB_Tok02
	Sk3Ed_FB_Rio01
	Sk3Ed_FB_SI01
	Sk3Ed_FB_SI02
	Sk3Ed_FB_Sub02
	Sk3Ed_FB_Sub03
	Sk3Ed_FB_30x30x4_01
	Sk3Ed_FB_30x30x4_02
	Sk3Ed_FB_30x30x4_03
	Sk3Ed_FB_30x30x4_04
	Sk3Ed_FB_30x30x8_01
	Sk3Ed_FB_30x30x8_02
	Sk3Ed_FB_30x30x8_03
	Sk3Ed_FB_30x30x8_04
	Sk3Ed_Bs_01
	Sk3Ed_Bs_02
	Sk3Ed_Bs_03
	Sk3Ed_Bs_04
	Sk3Ed_Bs_05
	Sk3Ed_Bp_01
	Sk3Ed_Bp_02
	Sk3Ed_W_10x10x5
	Sk3Ed_We_10x10x5
	Sk3Ed_W_10x10x2
	Sk3Ed_We_10x10x2
	Sk3Ed_QPd_10x10x8
	Low_Short_Deck
	Low_Med
	Low_Med_Deck
	Low_Long
	Low_Long_Deck
	Sk3Ed_QPdi_10x10x8
	Sk3Ed_QPdo_10x10x8
	Sk3Ed_QPd_10x10x12
	High_Short_Deck
	High_Med
	High_Med_Deck
	High_Long
	High_Long_Deck
	Sk3Ed_QPdi_10x10x12
	Sk3Ed_QPdo_10x10x12
	Sk3Ed_QPdR_10x10x4
	Sk3Ed_QPdR_10x10x8
	Sk3Ed_QPdR_10x10x12
	Sk3Ed_QPdR_10x10x16
	Low_QP_Low_rail
	Low_QP_Med_rail
	Low_QP_High_rail
	Low_QP_Low_side_rail
	Low_QP_Med_side_rail
	Low_QP_High_side_rail
	High_QP_Low_rail
	High_QP_Med_rail
	High_QP_High_rail
	High_QP_Low_side_rail
	High_QP_Med_side_rail
	High_QP_High_side_rail
	Sk3Ed_P_10x10x8
	Med
	Long
	Sk3Ed_Pi_10x10x8
	Sk3Ed_Pi_20x20x8
	Sk3Ed_Po_10x10x8
	Sk3Ed_Pdp_01
	Sk3Ed_Pdb_01
	Sk3Ed_RAi_10x10x4
	Sk3Ed_RAi_10x10x8
	Sk3Ed_RAi_10x10x12
	Sk3Ed_RAi_20x20x4
	Sk3Ed_RAi_20x20x8
	Sk3Ed_RAi_20x20x12
	Sk3Ed_S_10x10x4
	Sk3Ed_Si_10x10x4
	Sk3Ed_Si2_10x10x4
	Sk3Ed_So_10x10x4
	Sk3Ed_So2_10x10x4
	Sk3Ed_S_10x10x8
	Sk3Ed_Si_10x10x8
	Sk3Ed_Si2_10x10x8
	Sk3Ed_So_10x10x8
	Sk3Ed_So2_10x10x8
	Sk3Ed_S_10x20x4
	Sk3Ed_Si_20x20x4
	Sk3Ed_Si2_20x20x4
	Sk3Ed_So_20x20x4
	Sk3Ed_So2_20x20x4
	Sk3Ed_S_10x20x8
	Sk3Ed_Si_20x20x8
	Sk3Ed_Si2_20x20x8
	Sk3Ed_So_20x20x8
	Sk3Ed_So2_20x20x8
	Sk3Ed_ST_10x10x2
	Sk3Ed_STi_10x10x2
	Sk3Ed_STi2_10x10x2
	Sk3Ed_STo_10x10x2
	Sk3Ed_STo2_10x10x2
	Sk3Ed_STio_10x10x2
	Sk3Ed_ST_10x10x4
	Sk3Ed_STi_10x10x4
	Sk3Ed_STi2_10x10x4
	Sk3Ed_STo_10x10x4
	Sk3Ed_STo2_10x10x4
	Sk3Ed_STio_10x10x4
	Sk3Ed_Gt_20x20
	Sk3Ed_Gb_20x10
	Sk3Ed_Gb_10x10
	Sk4Ed_Fence_10x10
	Sk3Ed_Dumpster01
	Sk3Ed_Dumpster02
	Sk3Ed_MFo_01
	Sk3Ed_MPu_20x20x8
	Sk3Ed_MLa_20x20
	Sk3Ed_MWa_20x20
	floor_wall_block
	wall_block
	floor_block
	Sk4Ed_Sch_Fountain
	Sk4Ed_Sch_BigStairs
	Sk4Ed_Sch_Spine
	Sk4Ed_Sch_Newsstands
	Sk4Ed_SF2_Bench
	Sk4Ed_SF2_Big
	Sk4Ed_SF2_Bus
	Sk4Ed_SF2_BusStop
	Sk4Ed_SF2_Newsstands
	Sk4Ed_SF2_PierWedge
	Sk4Ed_SF2_Planter01
	Sk4Ed_SF2_Planter02
	Sk4Ed_SF2_Planter03
	Sk4Ed_SF2_TnAKicker01
	Sk4Ed_SF2_TnAPipe01
	Sk4Ed_SF2_TnAPipe02
	Sk4Ed_SF2_TnAPipe03
	Sk4Ed_SF2_TrashBox
	Sk4Ed_Alc_Kicker
	Sk4Ed_Alc_CrustyBench
	Sk4Ed_Alc_Bench
	Sk4Ed_Team_Blue
	Sk4Ed_Team_Red
	Sk4Ed_Team_Green
	Sk4Ed_Team_Yellow
	Sk3Ed_QPi_10x10x8
	Sk3Ed_QPo_10x10x8
	Sk3Ed_QPo_10x10x12
	Sk3Ed_QPi_10x10x12
	Sk5Ed_Sel_01
	Sk5Ed_HPTunnel_01
	Sk5Ed_QPshortMid_01
	Sk5Ed_W_10x10x06_01
	Sk5Ed_W_10x10x06_02
	Sk5Ed_RA_10x10x15_03
	Sk5Ed_RA_10x10x15_04
	Sk5ED_BoobB_01
	Sk5ED_BoobB_02
	Sk5ED_BoobB_03
	Sk5Ed_SF2_24Stair01
	Sk5Ed_Billboard_Big
	sk5ed_Billboard_big45
	sk5ed_Billboard_Med
	sk5ed_Billboard_Med45
	sk5ed_Railroad
	sk5ed_Railroad90
	sk5ed_fullpipe_walls
	sk5ed_fullpipe_qps
	sk3ed_AP_walkway
	sk5ed_LAcurve
	sk5ed_LAstraight
	sk5ed_ShipPool
	sk5ed_tok_big
	Sk5Ed_W_Slated_01
	sk5ed_Alc_corner
	sk5ed_Alc_Bleachers
	sk5ed_rooftop
	Sk5Ed_SideWall
	Sk5Ed_BigSideWall
	Sk5Ed_90Wall
	sk5ed_House_Ladder
	sk5ed_Swingrail
	sk5ed_Smallhouse
	sk5ed_dead //Ladder
	sk5ed_KickerWall
	sk5ed_Tightkicker
	sk5ed_Srail
	sk5ed_Srailcenter
	sk5ed_wavysmall
	sk5ed_wavyconcretebig
	sk5ed_curveconcrete
	sk5ed_upcurve
	sk5ed_kink
	sk5ed_curvedLedge
	sk5ed_curvedLedge01
	sk5ed_curvedLedge02
	sk5ed_curvedLedge03
	sk5ed_shortwall
	sk5ed_VCplanter_01
	sk5ed_VCplanter_02
	sk5ed_VCplanter_03
	sk5ed_Tank
	sk5ed_freewaypole
	sk5ed_freewaycurve
	sk5ed_BigSkyscraper
	sk5ed_curvedcurb
	sk5ed_straightcurb
	sk5ed_bigtraffic
	sk5ed_smalltraffic
	sk5ed_straightcurbShort
	sk5ed_dock
	sk5ed_dockshort
	sk5ed_hut
	sk5ed_houseboat
	sk5ed_Ghetto
	sk5ed_tele01
	sk5ed_tele02
	sk5ed_telewires
	sk5ed_street
	sk5ed_Grass
	sk5ed_mailbox
	Sk5ed_Water1square
	Sk5ed_lava1square
	sk5ed_45Launch
	sk5ed_45LaunchMed
	sk5ed_45LaunchLow
	sk5ed_45LaunchMed01
	sk5ed_SlantedBig
	sk5ed_SlantedSmall
	sk5ed_SlantedTall01
	sk5ed_SlantedTall02
	sk5ed_dead //underground
	sk5ed_UndergroundRailed
	sk5ed_undergroundStraightRailed
	sk5ed_UndergroundStraight
	sk5ed_UndergroundCurved
	sk5ed_dead //UndergroundDown
	sk5ed_dead //UndergroundDown01
	sk5ed_dead //UndergroundDown02
	sk5ed_DEAD //test01
	sk5ed_test02
	sk5ed_shortwall01
	sk5ed_Grass1square
	sk5ed_sdRail
	sk5ed_sdBench
	sk5ed_bbhoop
	sk5ed_sand
	sk5ed_candy
	sk5ed_car
	sk5ed_heli
	sk5ed_NYLight
	sk5ed_sand01
	sk5ed_street_curve

	// Added by Mick, 9/9/03, since they were missing, and their pieces woudl not save
	sk5ed_AP_Walkway		  // Other Rails:  AP Walkway
	Sk5Ed_RA_10x10x15_02	  // Walls:  Highest with rail
	sk5ed_curvedLedge04		  // Walls:  Curved Ledge Low
	sk5ed_Underground

]




Ed_Roadmask=[
	;[0 9 42 4]
]




;
; These are important -- don't delete
;

script EditorTrgGap0
	FireCustomParkGap gap_index=0
endscript

script EditorTrgGap1
	FireCustomParkGap gap_index=1
endscript

script EditorTrgGap2
	FireCustomParkGap gap_index=2
endscript

script EditorTrgGap3
	FireCustomParkGap gap_index=3
endscript

script EditorTrgGap4
	FireCustomParkGap gap_index=4
endscript

script EditorTrgGap5
	FireCustomParkGap gap_index=5
endscript

script EditorTrgGap6
	FireCustomParkGap gap_index=6
endscript

script EditorTrgGap7
	FireCustomParkGap gap_index=7
endscript

script EditorTrgGap8
	FireCustomParkGap gap_index=8
endscript

script EditorTrgGap9
	FireCustomParkGap gap_index=9
endscript

script EditorTrgGap10
	FireCustomParkGap gap_index=10
endscript

script EditorTrgGap11
	FireCustomParkGap gap_index=11
endscript

script EditorTrgGap12
	FireCustomParkGap gap_index=12
endscript

script EditorTrgGap13
	FireCustomParkGap gap_index=13
endscript

script EditorTrgGap14
	FireCustomParkGap gap_index=14
endscript

script EditorTrgGap15
	FireCustomParkGap gap_index=15
endscript

script EditorTrgGap16
	FireCustomParkGap gap_index=16
endscript

script EditorTrgGap17
	FireCustomParkGap gap_index=17
endscript

script EditorTrgGap18
	FireCustomParkGap gap_index=18
endscript

script EditorTrgGap19
	FireCustomParkGap gap_index=19
endscript

script EditorTrgGap20
	FireCustomParkGap gap_index=20
endscript

script EditorTrgGap21
	FireCustomParkGap gap_index=21
endscript

script EditorTrgGap22
	FireCustomParkGap gap_index=22
endscript

script EditorTrgGap23
	FireCustomParkGap gap_index=23
endscript

script EditorTrgGap24
	FireCustomParkGap gap_index=24
endscript

script EditorTrgGap25
	FireCustomParkGap gap_index=25
endscript

script EditorTrgGap26
	FireCustomParkGap gap_index=26
endscript

script EditorTrgGap27
	FireCustomParkGap gap_index=27
endscript

script EditorTrgGap28
	FireCustomParkGap gap_index=28
endscript

script EditorTrgGap29
	FireCustomParkGap gap_index=29
endscript

script EditorTrgGap30
	FireCustomParkGap gap_index=30
endscript

script EditorTrgGap31
	FireCustomParkGap gap_index=31
endscript



