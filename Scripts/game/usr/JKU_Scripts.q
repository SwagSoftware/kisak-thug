script Veh_TaxiUS_TOD
endscript

script Veh_IsuzuTruck_TOD
endscript

script Veh_Lada_TOD
endscript

script Veh_SUV_TOD
endscript

script Veh_TransAm_TOD
endscript

script Gap_CarHop
	StartGap { GapID = <StartGapID> flags = PURE_AIR }
	EndGap { GapID = <EndGapID> text = "Car hop" score = 100 GapScript = <GapScript> }
endscript

script Veh_Generic_TOD
	Switch <current_tod>
		case morning
			ReplaceCarTextures {
				array = [
				   	{
						src="JKU_LightCircle_Transparent.png" dest="textures/cars/JKU_LightCircle_Transparent"
					}
					{
						src="JKU_HeadlightGlow_Transparent.png" dest="textures/cars/JKU_HeadlightGlow"
					}
					//{
					//	src="JKU_TaillightGlow_Transparent.png" dest="textures/cars/JKU_TaillightGlow"
					//}
				]
			}
		case day
			ReplaceCarTextures {
				array = [
					{
						src="JKU_LightCircle_Transparent.png" dest="textures/cars/JKU_LightCircle_Transparent"
					}
					{
						src="JKU_HeadlightGlow_Transparent.png" dest="textures/cars/JKU_HeadlightGlow_Transparent"
					}
					//{
					//	src="JKU_TaillightGlow_Transparent.png" dest="textures/cars/JKU_TaillightGlow_Transparent" in=car
					//}
				]
			}
		case evening
			ReplaceCarTextures {
				array = [
					{
						src="JKU_LightCircle_Transparent.png" dest="textures/cars/JKU_LightCircle_Transparent"
					}
					{
						src="JKU_HeadlightGlow_Transparent.png" dest="textures/cars/JKU_HeadlightGlow" 
					}					
					//{
					//	src="JKU_TaillightGlow_Transparent.png" dest="textures/cars/JKU_TaillightGlow"
					//}
				]
			}
		case night
			ReplaceCarTextures {
				array = [
					{
						src="JKU_LightCircle_Transparent.png" dest="textures/cars/JKU_LightCircle"
					}
					{
						src="JKU_HeadlightGlow_Transparent.png" dest="textures/cars/JKU_HeadlightGlow"
					}
					//{
					//	src="JKU_TaillightGlow_Transparent.png" dest="textures/cars/JKU_TaillightGlow"
					//}
				]
			}
		default
			printf"### no tod set ###"
	EndSwitch
endscript

script Cone_Contacts
		contacts = [
			( 6, 6, 17 )
			( 6, 6, -17 )			   
			( -6, 6, 17 )
			( -6, 6, -17 )
			( -6, 0, -12 )
		]
endscript


