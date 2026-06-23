// This file contains all the possible pedestrian profiles for THPS4.
// Each profile can be referenced by a pedestrian in a level's node array.

// ******************************************************************
// Name:  randomized_pedestrian_profile
// Desc:  This is a completely randomized pedestrian from
// all the accessible parts.  This is a purely naive randomization
// function;  It doesn't handle any kind of disqualification-handling
// ******************************************************************

randomized_pedestrian_profile =   random_male_profile
//randomized_pedestrian_profile =   random_female_profile

random_male_profile = {

	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }

}


random_female_profile = {
	ped_f_head = { randomized_desc_id }
	ped_f_torso = { randomized_desc_id }
	ped_f_legs = { randomized_desc_id }
	scale=(0.98,0.98,0.98)
}


//----------------------------SKATEBORAD PEDESTRIANS---------------

//-------------Ped with Skateboard-------------
Ped_Skateboard_a = {
	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }
	ped_board = {desc_id = #"Skateboard"}
}


//-----------For peds that need to stay consistent over multi-stage goals---------------
Ped_MultiStage_Skateboard_A = {
	ped_m_head = { random_index=0 }
	ped_m_torso = { random_index=1 }
	ped_m_legs = { random_index=2 }
	ped_board = {desc_id = #"Skateboard"}
}

Ped_MultiStage_Skateboard_B = {
	ped_m_head = { random_index=1 }
	ped_m_torso = { random_index=2 }
	ped_m_legs = { random_index=0 }
	ped_board = {desc_id = #"Skateboard"}
	body_shape=Fatman_scale_info

}

Ped_MultiStage_Skateboard_C = {
	ped_m_head = { random_index=2 }
	ped_m_torso = { random_index=0 }
	ped_m_legs = { random_index=1 }
	ped_board = {desc_id = #"Skateboard"}
}

Ped_MultiStage_A = {
	ped_m_head = { random_index=0 }
	ped_m_torso = { random_index=1 }
	ped_m_legs = { random_index=2 }
}

Ped_MultiStage_B = {
	ped_m_head = { random_index=1 }
	ped_m_torso = { random_index=2 }
	ped_m_legs = { random_index=0 }
}

Ped_MultiStage_C = {
	ped_m_head = { random_index=2 }
	ped_m_torso = { random_index=0 }
	ped_m_legs = { random_index=1 }
}

Ped_F_MultiStage_Skateboard_A = {
	ped_f_head = { random_index=0 }
	ped_f_torso = { random_index=1 }
	ped_f_legs = { random_index=2 }
	ped_board = {desc_id = #"Skateboard"}
}

Ped_F_MultiStage_Skateboard_B = {
	ped_f_head = { random_index=1 }
	ped_f_torso = { random_index=2 }
	ped_f_legs = { random_index=0 }
	ped_board = {desc_id = #"Skateboard"}
	body_shape=Fatman_scale_info

}

Ped_F_MultiStage_Skateboard_C = {
	ped_f_head = { random_index=2 }
	ped_f_torso = { random_index=0 }
	ped_f_legs = { random_index=1 }
	ped_board = {desc_id = #"Skateboard"}
}

Ped_F_MultiStage_A = {
	ped_f_head = { random_index=0 }
	ped_f_torso = { random_index=1 }
	ped_f_legs = { random_index=2 }
}

Ped_F_MultiStage_B = {
	ped_f_head = { random_index=1 }
	ped_f_torso = { random_index=2 }
	ped_f_legs = { random_index=0 }
}

Ped_F_MultiStage_C = {
	ped_f_head = { random_index=2 }
	ped_f_torso = { random_index=0 }
	ped_f_legs = { random_index=1 }
}

//-----------Kid with Skateboard---------------
Ped_Kid_Skateboard_a = {
	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }
	ped_board = {desc_id = #"Skateboard"}
	scale=(0.75,0.65,0.9)
	body_shape=stroller_scale_info

}
//---------------Pro Teamates------------
Ped_Skeezo = {
	ped_m_head = {desc_id = #"Ped_Skeezo_Head" }
	ped_m_torso = {desc_id = #"Torso_Wht_Tshirt_01" }
	ped_m_legs = {desc_id = #"Legs_Cargos_02" }
	ped_board = {desc_id = #"Skateboard"}
}
Ped_Ralphie = {
	ped_m_head = {desc_id = #"Ped_Ralph_Head" }
	ped_m_torso = {desc_id = #"Torso_Wht_Tshirt_03" }
	ped_m_legs = {desc_id = #"Legs_Jeans_03" }
	ped_board = {desc_id = #"Skateboard"}
}
Ped_Bender = {
	ped_m_head = {desc_id = #"Ped_Bender_Head" }
	ped_m_torso = {desc_id = #"Torso_Brn_Tshirt_02" }
	ped_m_legs = {desc_id = #"Legs_Jeans_05" }
	ped_board = {desc_id = #"Skateboard"}
}
Ped_Furlow = {

	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }

}
Ped_Kozar = {

	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }

}
Ped_Hough = {

	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }

}
Ped_Meat = {

	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }

}

// TEMP - to get theg ame running, this was missing, but should problably be something else.
Ped_Jordan = {

	ped_body = {desc_id = #"ped_jordan"}

}


//---------------------New Jersey-------------------

Ped_Eric = {
	ped_body = {desc_id = #"Eric"}
	ped_board = {desc_id = #"Skateboard"}
}
Ped_Bum_01 = {
	ped_body = {desc_id = #"Bum 01"}
}
Ped_Crackhead_01 = {
	ped_body = {desc_id = #"Crack Head"}
}
Ped_Drugdealer_01 = {
	ped_body = {desc_id = #"Drug dealer 01"}
	Stocky_scale_info
}
Ped_Drugdealer_02 = {
	ped_body = {desc_id = #"Drug dealer 02"}
	scale=(.9,1.13,.9)
}
Ped_Drugdealer_03 ={
	ped_body = {desc_id = #"Drug dealer 03"}
}
Ped_FactoryWorker_01 = {
	ped_body = {desc_id = #"Factory Worker 01"}
	body_shape=Fatman_scale_info
}
Ped_FactoryWorker_02 = {
	ped_body = {desc_id = #"Factory Worker 02"}
}
Ped_Security_Train  = {
	ped_body = {desc_id = #"Security Train"}
	body_shape=Fatman_scale_info

}
Ped_Street_Warrior_01  = {
	ped_body = {desc_id = #"Street Warrior 01"}
}
Ped_Street_Warrior_02  = {
	ped_body = {desc_id = #"Street Warrior 02"}
	ped_m_legs = { randomized_desc_id }
}
Ped_Street_Warrior_03  = {
	ped_body = {desc_id = #"Street Warrior 03"}
	ped_m_legs = { randomized_desc_id }
}
Ped_Tombstone = {
	ped_body = {desc_id = #"Tombstone"}
	scale=(1.1,0.9,0.9)
}


//---------------------Manhattan-------------------


Ped_Businesswoman_01 = {
	ped_body = {desc_id = #"Businesswoman 01"}
}
Ped_M_NYPD_01 = {
	ped_body = {desc_id = #"M_NYPD 01"}
	Stocky_scale_info

}
Ped_F_NYPD_01 = {
	ped_body = {desc_id = #"F_NYPD 01"}
}
Ped_Construction_Jhammer = {
	ped_m_head = { desc_id = #"Ped_Worker_Head01" }
	ped_m_torso = {desc_id = #"Ped_Worker_Torso" }
	ped_m_legs = { desc_id = #"Ped_Worker_Legs" }
	ped_board = {desc_id = #"Jackhammer"}
}
Ped_Construction_Manhole = {
	ped_m_head = { desc_id = #"Ped_Worker_Head02" }
	ped_m_torso = {desc_id = #"Ped_Worker_Torso" }
	ped_m_legs = { desc_id = #"Ped_Worker_Legs" }
}

Ped_Skater_NY1 = {
	ped_body = {desc_id = #"Skater_NY1"}
}
Ped_Skater_NY2 = {
	ped_body = {desc_id = #"Skater_NY2"}
}
Ped_Peralta = {
	ped_body = {desc_id = #"Ped_Peralta"}
}
Ped_Chef = {
	ped_body = {desc_id = #"Ped_Chef"}
}


//---------------------Tampa-------------------
Ped_BusinessMan_01 = {
	ped_body = {desc_id = #"BusinessMan 01"}
}


Ped_BusinessMan_02 = {
	ped_body = {desc_id = #"BusinessMan 02"}
	//  body_shape=Fatman_scale_info
}

Ped_BusinessMan_03 = {
	ped_body = {desc_id = #"BusinessMan 03"}
}


Ped_BlkKid_01 = {
	ped_body = {desc_id = #"BlkKid 01"}
	body_shape=kid1_scale_info
}

Ped_BlkKid_02 = {
	ped_body = {desc_id = #"BlkKid 02"}
	body_shape=kid1_scale_info
}

Ped_BlkKid_03 = {
	ped_body = {desc_id = #"BlkKid 03"}
	body_shape=kid3_scale_info
}

Ped_Trooper = {
	ped_body = {desc_id = #"Ped_Trooper"}
}

Ped_Todd = {
	ped_body = {desc_id = #"Ped_Todd"}
}

Ped_F_Dancer_01 = {
	ped_body = {desc_id = #"Dancer 01"}
}

Ped_F_Dancer_02 = {
	ped_body = {desc_id = #"Dancer 02"}
}
Ped_Clemens = {

	ped_m_head = {desc_id = #"Ped_Clemens_head"}
	ped_m_torso = {desc_id = #"Torso_Wht_Tshirt_03"}
	ped_m_legs = { randomized_desc_id }

}
Ped_AfroJim = {

	ped_m_head = {desc_id = #"Ped_AfroJim_head"}
	ped_m_torso = {desc_id = #"Torso_Wht_Tshirt_04"}
	ped_m_legs = { randomized_desc_id }

}


//Vancouver
Ped_Doorman_01 = {
	ped_body = {desc_id = #"Doorman 01"}
	Stocky_scale_info
}
Ped_Deskclerk_01 = {
	ped_body = {desc_id = #"Deskclerk 01"}
}
Ped_F_Deskclerk_01 = {
	ped_body = {desc_id = #"F_Deskclerk 01"}
}
Ped_Leafblower = {
	ped_body = {desc_id = #"Ped_Leafblower"}
	ped_board = {desc_id = #"Ped_Leafblower_Blower"}
}
//San Diego
Ped_Security_01 = {
	ped_m_head = {desc_id = #"Ped_Security_Head01"}
	ped_body = {desc_id = #"Ped_Security_Body"}
}
Ped_Security_02 = {
	ped_m_head = {desc_id = #"Ped_Security_Head02"}
	ped_body = {desc_id = #"Ped_Security_Body"}
}
Ped_Security_03 = {
	ped_m_head = {desc_id = #"Ped_Security_Head03"}
	ped_body = {desc_id = #"Ped_Security_Body"}
}
Ped_F_Security = {
	ped_body = {desc_id = #"Ped_F_Security"}
}

Ped_Gardener_01 = {
	ped_m_head = {desc_id = #"Ped_Gardener_Head01"}
	ped_body = {desc_id = #"Ped_Gardener_Body"}
}
Ped_Gardener_02 = {
	ped_m_head = {desc_id = #"Ped_Gardener_Head02"}
	ped_body = {desc_id = #"Ped_Gardener_Body"}
}
Ped_F_Gardener = {
	ped_body = {desc_id = #"Ped_F_Gardener"}
}
//Moscow
Ped_F_MCeleb = {
	ped_body = {desc_id = #"Ped_F_MCeleb"}
}
Ped_F_KGB = {
	ped_body = {desc_id = #"Ped_F_KGB"}
}
Ped_KGB_01 = {
	ped_m_head = {desc_id = #"Ped_KGB_Head01"}
	ped_body = {desc_id = #"Ped_KGB_Body"}
}
Ped_KGB_02 = {
	ped_m_head = {desc_id = #"Ped_KGB_Head02"}
	ped_body = {desc_id = #"Ped_KGB_Body"}
}
Ped_RGuard_01 = {
	ped_m_head = {desc_id = #"Ped_RGuard_Head01"}
	ped_body = {desc_id = #"Ped_RGuard_Body"}
	ped_board = {desc_id = #"Ped_RGuard_Gun"}
}
Ped_RGuard_02 = {
	ped_m_head = {desc_id = #"Ped_RGuard_Head02"}
	ped_body = {desc_id = #"Ped_RGuard_Body"}
	ped_board = {desc_id = #"Ped_RGuard_Gun"}
}
Ped_F_Babushka = {
	ped_f_head = {desc_id = #"Head_f_Bab_head"}
	ped_f_torso = {desc_id = #"Torso_f_bab_coat"}
	ped_f_legs = {desc_id = #"Legs_f_jeans01"}
}
Ped_Cameraman = {
	ped_body = {desc_id = #"Ped_Cameraman"}
	ped_board = {desc_id = #"Ped_CamMan_Camera"}
}
//Slam city Jam

Ped_Official_SC_01 = {
	ped_m_head = {desc_id = #"Head_OfficialA"}
	ped_body = {desc_id = #"Official SC 01"}
}

Ped_Official_SC_02 = {
	ped_m_head = {desc_id = #"Head_OfficialB"}
	ped_body = {desc_id = #"Official SC 01"}
}
Ped_Monsterped_A_01 = {
	ped_body = {desc_id = #"Monster Ped A 01"}
}
Ped_Monsterped_A_01B = {
	ped_body = {desc_id = #"Monster Ped A 01B"}
}

Ped_Monsterped_B_01 = {
	ped_body = {desc_id = #"Monster Ped B 01"}
}

Ped_Monsterped_C_01 = {
	ped_body = {desc_id = #"Monster Ped C 01"}
}

Ped_Monsterped_A_02 = {
	ped_body = {desc_id = #"Monster Ped A 02"}
}

Ped_Monsterped_B_02 = {
	ped_body = {desc_id = #"Monster Ped B 02"}
}

Ped_Monsterped_C_02 = {
	ped_body = {desc_id = #"Monster Ped C 02"}
}

Ped_Monsterped_A_03 = {
	ped_body = {desc_id = #"Monster Ped A 03"}
}

Ped_Monsterped_B_03 = {
	ped_body = {desc_id = #"Monster Ped B 03"}
}

Ped_Monsterped_C_03 = {
	ped_body = {desc_id = #"Monster Ped C 03"}
}

Ped_Monsterped_A_04 = {
	ped_body = {desc_id = #"Monster Ped A 04"}
}

Ped_Monsterped_B_04 = {
	ped_body = {desc_id = #"Monster Ped B 04"}
}

Ped_Monsterped_C_04 = {
	ped_body = {desc_id = #"Monster Ped C 04"}
}
Ped_QBert = {
	ped_body = {desc_id = #"Ped_QBert"}
}
Ped_Video = {
	ped_body = {desc_id = #"Ped_Video"}
}
Ped_Photo = {
	ped_body = {desc_id = #"Ped_Photo"}
}
Ped_SCJ_Worker = {
	ped_m_head = { desc_id = #"Ped_Worker_Head01" }
	ped_m_torso = {desc_id = #"Ped_Worker_Torso" }
	ped_m_legs = { desc_id = #"Ped_Worker_Legs" }
}
Ped_SCJ_Judge_01 = {

	ped_m_head = {desc_id = #"Head_Wht_01" }
	ped_m_torso = {desc_id = #"Torso_Wht_Judge" }
	ped_m_legs = {desc_id = #"Legs_Jeans_01" }

}
Ped_SCJ_Judge_02 = {

	ped_m_head = {desc_id = #"Head_Wht_02" }
	ped_m_torso = {desc_id = #"Torso_Wht_Judge" }
	ped_m_legs = {desc_id = #"Legs_Jeans_01" }

}
Ped_SCJ_Judge_03 = {

	ped_m_head = {desc_id = #"Head_Wht_03" }
	ped_m_torso = {desc_id = #"Torso_Wht_Judge" }
	ped_m_legs = {desc_id = #"Legs_Cargos_04" }

}
Ped_SCJ_Judge_04 = {

	ped_m_head = {desc_id = #"Head_JJagger" }
	ped_m_torso = {desc_id = #"Torso_Wht_Judge" }
	ped_m_legs = {desc_id = #"Legs_Jeans_01" }

}
Ped_SCJ_Judge_05 = {

	ped_m_head = {desc_id = #"KGutierez" }
	ped_m_torso = {desc_id = #"Torso_Wht_Judge" }
	ped_m_legs = {desc_id = #"Legs_Jeans_02" }

}
Ped_SCJ_Judge_06 = {

	ped_m_head = {desc_id = #"Head_CRausch" }
	ped_m_torso = {desc_id = #"Torso_Wht_Judge" }
	ped_m_legs = {desc_id = #"Legs_Cargos_01" }

}

//----------------Hawaii-----------------------------
Ped_Hula = {
	ped_body = {desc_id = #"Ped_Hula"}
}
Ped_Hula2 = {
	ped_body = {desc_id = #"Ped_Hula2"}
}
Ped_Bartender = {

	ped_m_head = {desc_id = #"Head_TBarber" }
	ped_m_torso = {desc_id = #"Torso_wht_hawaii" }
	ped_m_legs = {desc_id = #"Legs_Cargos_02" }
	ped_board = {desc_id = #"Ped_Bartender_Props" }
}
Ped_Film = {
	ped_body = {desc_id = #"Ped_Film"}
}
Ped_Bikini_1 = {
	ped_body = {desc_id = #"Ped_Bikini_1"}
}
Ped_Bikini_2 = {
	ped_body = {desc_id = #"Ped_Bikini_2"}
}
Ped_Bikini_3 = {
	ped_body = {desc_id = #"Ped_Bikini_3"}
}
Ped_Bride = {
	ped_body = {desc_id = #"Ped_Bride"}
}
Ped_Surfer = {
	ped_body = {desc_id = #"Ped_Surfer"}
}

//---------------Secret Level----------------------
Ped_KISS_Paul = {
	ped_body = {desc_id = #"Ped_KISS_Paul"}
	ped_board = {desc_id = #"Ped_KISS_Paul_Prop" }
}
Ped_KISS_Peter = {
	ped_body = {desc_id = #"Ped_KISS_Peter"}
}
Ped_KISS_Ace = {
	ped_body = {desc_id = #"Ped_KISS_Ace"}
	ped_board = {desc_id = #"Ped_KISS_Ace_Prop" }
}
Ped_KISS_Gene = {
	ped_body = {desc_id = #"Ped_KISS_Gene"}
	ped_board = {desc_id = #"Ped_KISS_Gene_Prop" }
}
Ped_Freak_Sledge = {

	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }
	ped_board = {desc_id = #"Ped_Freakshow_Sledge" }
}
Ped_Freak_Sword = {

	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }
	ped_board = {desc_id = #"Ped_Freakshow_Sword" }
}
Skate_KISS_Paul = {
	ped_body = {desc_id = #"Skate_KISS_Paul"}
}
Skate_KISS_Peter = {
	ped_body = {desc_id = #"Skate_KISS_Peter"}
}
Skate_KISS_Ace = {
	ped_body = {desc_id = #"Skate_KISS_Ace"}
}
//---------------Ped Pros----------------------
PedPro_Hawk = {
	ped_body = {desc_id = #"PedPro_Hawk"}
	ped_board = {desc_id = #"Skateboard"}
}
PedPro_Koston = {
	ped_body = {desc_id = #"PedPro_Koston"}
	ped_board = {desc_id = #"Skateboard"}
}
PedPro_Burnquist = {
	ped_body = {desc_id = #"PedPro_Burnquist"}
	ped_board = {desc_id = #"Skateboard"}
}
PedPro_Lasek = {
	ped_body = {desc_id = #"PedPro_Lasek"}
	ped_board = {desc_id = #"Skateboard"}
}
PedPro_Mullen = {
	ped_body = {desc_id = #"PedPro_Mullen"}
	ped_board = {desc_id = #"Skateboard"}
}
PedPro_Muska = {
	ped_body = {desc_id = #"PedPro_Muska"}
	ped_board = {desc_id = #"Skateboard"}
}
PedPro_Margera = {
	ped_body = {desc_id = #"PedPro_Margera"}
	ped_board = {desc_id = #"Skateboard"}
}
PedPro_Rodrigez = {
	ped_body = {desc_id = #"PedPro_Rodrigez"}
	ped_board = {desc_id = #"Skateboard"}
}
PedPro_Reynolds = {
	ped_body = {desc_id = #"PedPro_Reynolds"}
	ped_board = {desc_id = #"Skateboard"}
}
PedPro_Vallely = {
	ped_body = {desc_id = #"PedPro_Vallely"}
	ped_board = {desc_id = #"Skateboard"}
}

//----------------THPS4 Pedestrians-------------------------

//-PRO PEDESTRIANS-

pedpro_Hawk_profile = {
	ped_body = {desc_id = #"Hawk"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Burnquist_profile = {
	ped_body = {desc_id = #"Burnquist"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Caballero_profile = {
	ped_body = {desc_id = #"Caballero"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Campbell_profile = {
	ped_body = {desc_id = #"Campbell"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Koston_profile = {
	ped_body = {desc_id = #"Koston"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Glifberg_profile = {
	ped_body = {desc_id = #"Glifberg"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Lasek_profile = {
	ped_body = {desc_id = #"Lasek"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Margera_profile = {
	ped_body = {desc_id = #"Margera"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Mullen_profile = {
	ped_body = {desc_id = #"Mullen"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Muska_profile = {
	ped_body = {desc_id = #"Muska"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Reynolds_profile = {
	ped_body = {desc_id = #"Reynolds"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Rowley_profile = {
	ped_body = {desc_id = #"Rowley"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Steamer_profile = {
	ped_body = {desc_id = #"Steamer"}
	ped_board = {desc_id = #"Skateboard"}
}
pedpro_Thomas_profile = {
	ped_body = {desc_id = #"Thomas"}
	ped_board = {desc_id = #"Skateboard"}
}

pedpro_Neversoft_profile = {
	ped_body = {desc_id = #"Neversoft"}
	ped_board = {desc_id = #"Skateboard"}
}


//-------------------COLLEGE PEDESTRIANS----------------------------

//--------------------Frat Jacket-----------------
Ped_Fratjacket_a = {
	ped_m_head = { randomized_desc_id }
	ped_m_torso = { desc_id=#"Torso_Fratjacket01" }
	ped_m_legs = { randomized_desc_id }
}
//---------------------Frat Guy A-------------------
Ped_FratGuy_a = {
	ped_m_head = { desc_id=#"Head_Fratguy01" }
	ped_m_torso = { desc_id=#"Torso_Fratshirt01" }
	ped_m_legs = { desc_id=#"Legs03" }
	scale=(1.0,0.95,1.0)
	body_shape=fatpeda_scale_info
}
//----------------------Frat Guy B------------------
Ped_FratGuy_b = {
	ped_m_head = { desc_id=#"Head05" }
	ped_m_torso = { desc_id=#"Torso_Fratshirt01" }
	ped_m_legs = { desc_id=#"Legs03" }
	scale=(1.2,1.1,1.2)
}
//------------BasketBall02 with ball----------------
Ped_Basketball_b = {
	ped_body = {desc_id = #"BBall02"}
	ped_board = {desc_id = #"basketball"}
	scale=(0.9,1.1,1.0)
}//------------BasketBall Torso 1----------------
Ped_Basketball_c = {
	ped_m_head = { desc_id=#"Head_Bald01" }
	ped_m_torso = { desc_id=#"Torso_Bball01" }
	ped_m_legs = { desc_id=#"Legs03" }
	scale=(1.3,0.95,1.3)
}
//----------------BasketBall Torso 2------------------
Ped_Basketball_d = {
	ped_m_head = { desc_id=#"Head_Flattop01" }
	ped_m_torso = { desc_id=#"Torso_Bball02" }
	ped_m_legs = { desc_id=#"Legs01" }
}
//--------------------Tennis Torso 1---------------------
Ped_Tennis_a = {
	ped_m_head = { desc_id=#"Head_Headband01" }
	ped_m_torso = { desc_id=#"Torso_Tennis02" }
	ped_m_legs = { desc_id=#"Legs03" }
	ped_board = {desc_id = #"Tennis_Racket"}
}
//---------------TennisHead Torso 2------------------------
Ped_Tennis_b = {
	ped_m_head = { randomized_desc_id }
	ped_m_torso = { desc_id=#"Torso_Tennis01" }
	ped_m_legs = { desc_id=#"Legs03" }
	ped_board = {desc_id = #"Tennis_Racket"}
	body_shape = rowley_scale_info
}
//--------------------LONDON PEDESTRIANS-----------------------

//---------------Cop-----------------
Ped_London_cop_a = {
	ped_body = {desc_id = #"London_Cop"}
	ped_board = {desc_id = #"Bat_Cop"}
	ped_m_head = {desc_id = #"Hat_London_Cop"}
}
Ped_London_Bikecop_a = {
	ped_body = {desc_id = #"London_BikeCop"}
	ped_board = {desc_id = #"Bat_Cop"}
}

Ped_Protestor_a = {
	ped_body = {desc_id = #"Protestor01"}
	ped_board = {desc_id = #"Sign_Protest02"}


}
Ped_Protestor_b = {
	ped_m_head = { randomized_desc_id }
	ped_m_torso = { desc_id=#"Torso_Backpack01" }
	ped_m_legs = { randomized_desc_id }
	ped_board = {desc_id = #"Sign_Protest02"}
	body_shape=fatpeda_scale_info

}
Ped_Protestor_c = {
	ped_m_head = { randomized_desc_id }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }
	ped_board = {desc_id = #"Sign_Protest03"}

}
Ped_Skank_a = {


	ped_f_head = {desc_id = #"FSkank02"}
	ped_f_torso = { randomized_desc_id }
	ped_f_legs = { randomized_desc_id }
	body_shape = rowley_scale_info

}


Ped_Mechanic_a = {
	ped_body = {desc_id = #"Mechanic01"}
}
Ped_Fisherman_a = {
	ped_m_head = { desc_id=#"Head_Fisherman01" }
	ped_m_torso = { desc_id=#"Torso_Fisherman"  }
	ped_m_legs = { desc_id=#"Legs02"  }
	ped_board = {desc_id = #"Fishing_Pole"}
}

Ped_Kid_grommit_a = {
	ped_body = {desc_id = #"Grommet"}
	ped_board = {desc_id = #"Skateboard"}
	scale=(0.9,0.8,0.9)

}


Ped_Jogger_Female_a = {
	//ped_body = {desc_id = #"Jogger_Female"}

}




Ped_Kid_grommit_b = {
	ped_body = {desc_id = #"Grommet02"}
	ped_board = {desc_id = #"Skateboard"}
	scale=(0.9,0.8,0.9)
	body_shape=stroller_scale_info

}

Ped_DockWorker_a = {
	ped_m_head = { desc_id=#"Head_DockWorker01" }
	ped_m_torso = { desc_id=#"Torso_DockWorker01" }
	ped_m_legs = { desc_id=#"Legs_Jnk_Worker" }
}

Ped_DockWorker_b = {
	ped_m_head = { desc_id=#"Head_DockWorker02" }
	ped_m_torso = { desc_id=#"Torso_DockWorker02" }
	ped_m_legs = { desc_id=#"Legs_Jnk_Worker" }
}

Ped_DockWorker_c = {
	ped_m_head = { desc_id=#"Head_DockWorker03" }
	ped_m_torso = { desc_id=#"Torso_DockWorker01" }
	ped_m_legs = { desc_id=#"Legs_Jnk_Worker" }
}

Ped_Foreman_a = {
	ped_m_head = { desc_id=#"Head_Foreman01" }
	ped_m_torso = { desc_id=#"Torso_Foremen" }
	ped_m_legs = { desc_id=#"Legs_Jnk_Worker" }
}

Ped_Foreman_b = {
	ped_m_head = { desc_id=#"Head_Foreman02" }
	ped_m_torso = { desc_id=#"Torso_Foremen" }
	ped_m_legs = { desc_id=#"Legs_Jnk_Worker" }
}

Ped_DeliveryGuy = {
	ped_m_head = { desc_id=#"Head_DeliveryGuy" }
	ped_m_torso = { desc_id=#"Torso_DeliveryGuy" }
	ped_m_legs = { desc_id=#"Legs_Pants03" }
	body_shape = rowley_scale_info
}

Ped_Stroller_a = {
	ped_f_head = { desc_id = #"FLongHair01" }
	ped_f_torso = { desc_id = #"FShirtMom" }
	ped_f_legs = { desc_id = #"FShort02" }
	ped_board = { desc_id = #"Stroller"}
	scale=(0.9,1.0,1.0)
	body_shape=stroller_scale_info
}

Ped_Zooemployee_b = {
	ped_m_head = { desc_id=#"Head_Zooemployee" }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }
	body_shape=fatpeda_scale_info
}
Ped_Elephant_Trainer_a = {
	ped_body = {desc_id = #"Elephant_Trainer"}
	ped_board = { desc_id = #"Rifle"}
}
Ped_Liontamer_a = {
	ped_body = {desc_id = #"Liontamer"}
	ped_board = { desc_id = #"Rifle"}
}



Ped_Clown = {
	ped_body = {desc_id = #"Ped_Clown"}
	//  ped_board = { desc_id = #"Balloons"}
}





Ped_Rasta = {
	ped_m_torso = { desc_id = #"Torso_Rasta" }
	ped_m_legs = { desc_id = #"Legs_pants02" }

}

Ped_VanGuy = {
	ped_m_head = { desc_id = #"Head_VanGuy" }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { randomized_desc_id }

}

Ped_Mob_rifle = {
	ped_body = {desc_id = #"mafiaguy"}
	ped_board = { desc_id = #"Rifle"}
}
//KIDS
//Kid boy01
Ped_Kid_a = {
	ped_body = {desc_id = #"Kid01"}
	scale=(0.75,0.65,0.9)
	body_shape=stroller_scale_info

}

//Kid Girl
Ped_Girl = {
	ped_body = {desc_id = #"Kid03"}
	scale=(0.75,0.65,0.9)
	body_shape=stroller_scale_info
}

//Kid boy with Balloon01
Ped_Kid_Balloon_a = {
	ped_body = {desc_id = #"Kid02"}
	ped_board = { desc_id = #"Balloon"}
	scale=(0.6,0.5,0.7)
	body_shape=balloon_scale_info
}


sample_pedestrian_a = {
	ped_m_head = { desc_id=#"Head02" }
	ped_m_torso = { randomized_desc_id }
	ped_m_legs = { desc_id=#"Legs01" }
}



sample_pedestrian_b = {
	ped_m_head = { randomized_desc_id }
	ped_m_torso = { desc_id=#"Torso01" }
	ped_m_legs = { desc_id=#"Legs02" }
}

