// script allowing access to user controlled vehicles

script DrivingAi
	ClearAllWalkingExceptions
	ClearExceptions
	SetEventhandler Ex=Vehicle_BodyCollision Scr=Vehicle_BodyCollision
	SetEventHandler Ex=SkaterCollideBail Scr=DrivingCollisionLost
	SetEventHandler Ex=MadeOtherSkaterBail Scr=MadeOtherSkaterBailCar
	SetException Ex=RunHasEnded Scr=EndOfRun
	SetException Ex=GoalHasEnded Scr=Goal_EndOfRun
	Block
endscript

script ToggleUserControlledVehicleMode
	if not Skater:Driving
		
		if InNetGame
			Obj_GetId
			BroadcastEnterVehicle SkaterId=<ObjId> control_type=( <VehicleSetup>.control_type )
		endif
		
		Skater:BashOff
		Skater:NollieOff
		Skater:PressureOff
		Skater:LandSkaterTricks
		Skater:ResetSwitched
		Skater:ClearTrickQueues
		Skater:DestroyAllSpecialItems
		Skater:SparksOff
		Skater:VibrateOff
		Skater:StopBalanceTrick
		Skater:KillExtraTricks
		Skater:SetExtraTricks NoTricks
		
		createPlayerVehicle <...>
		Skater:PausePhysics
		Skater:SkaterLoopingSound_TurnOff
		Skater:TakeBoardFromSkater
		Skater:Obj_ShadowOff
		
		GoalManager_HideAllGoalPeds 1
		
		Skater:SetDriving
		Debounce X
		Debounce Square
		
		MakeSkaterGoto DrivingAi
		
	else
		Skater:GetCameraId
		if not GameIsPaused
			<CameraId>:UnPause
		endif
		SetActiveCamera Id = <CameraId>
		PlayerVehicle:Die
		PlayerVehicleCamera:Die
		Skater:UnsetDriving
		Skater:ReturnBoardToSkater
		Skater:Obj_ShadowOn ShadowType=Detailed
		Skater:ResetRigidBodyCollisionRadiusBoost
		
		GoalManager_HideAllGoalPeds 0
		
		Change driving_parked_car=0
	endif
endscript

script createPlayerVehicle vehicleSetup=defaultCarSetup
	if GotParam Exitable
		vehicleSetup=( <vehicleSetup> + { Exitable } )
	endif
	if GotParam edited_goal
		vehicleSetup=( <vehicleSetup> + { edited_goal } )
	endif
	if not ObjectExists id = PlayerVehicle
		CreateCompositeObject {
			components = [
				{
					component = skeleton
					skeletonName = car
				}
				{
					component = vehicle
				}
				{
					component = vehiclesound
				}
				{
					component = sound
				}
				{
					component = input
					player = 0
				}
				{
					component = model
					UseModelLights
				}
			]
			params = {
				name = PlayerVehicle
				<vehicleSetup>
			}
		}
		CreateCompositeObject {
			components = [
				{
					component = cameralookaround
				}
				{
					component = vehiclecamera
					subject = PlayerVehicle
					vehicleCameraSetup
				}
				{
					component = camera
				}
				{
					component = input
					player = 0
				}
			]
			params = { name = PlayerVehicleCamera }
		}
	endif
endscript

script NonLocalClientInVehicle
	MangleChecksums A=<SkaterId> B=NonLocalPlayerVehicle
	NonLocalPlayerVehicle=<mangled_id>
	
	if ObjectExists Id=<NonLocalPlayerVehicle>
		<NonLocalPlayerVehicle>:GetTags
		if not ( <control_type> = <current_control_type> )
			remove_car_from_non_local_skater SkaterId=<SkaterId>
		endif
	endif
	
	if not ObjectExists Id=<NonLocalPlayerVehicle>
		lock_car_to_non_local_skater SkaterId=<SkaterId> control_type=<control_type>
	endif
	
	GetVehicleSetup control_type=<control_type>
	if not StructureContains Structure=<VehicleSetup> make_skater_visible
		<SkaterId>:Hide
	else
		<SkaterId>:Obj_ShadowOff
		<SkaterId>:SwitchOffAtomic Board
	endif
endscript

script NonLocalClientExitVehicle
	remove_car_from_non_local_skater SkaterId=<SkaterId>
	<SkaterId>:UnHide
	<SkaterId>:Obj_ShadowOn ShadowType=Simple
	<SkaterId>:SwitchOnAtomic Board
endscript

script lock_car_to_non_local_skater
	MangleChecksums A=<SkaterId> B=NonLocalPlayerVehicle
	NonLocalPlayerVehicle=<mangled_id>

	GetVehicleSetup control_type=<control_type>
	
	// This check is to insure that there is zero chance of using the wrong car setup for a level.  The problem is that the control type for a non-local
	// driver is set via a net message, which could easily arrive later than the switch of his driving flag to true.
	GetCurrentLevel
	VehicleSetupLevel=( <VehicleSetup>.level )
	VehicleSetupAlternateLevel=( <VehicleSetup>.alternate_level )
	if not ( ( <Level> = <VehicleSetupLevel> ) || ( <Level> = <VehicleSetupAlternateLevel> ) )
		return
	endif
	
	CreateCompositeObject {
		components = [
			{
				component = staticvehicle
			}
			{
				component = skeleton
				skeletonName = car
			}
			{
				component = lockobj
			}
			{
				component = setdisplaymatrix
			}
			{
				component = model
				model = ( <VehicleSetup>.model )
				UseModelLights
			}
			{
				component = modellightupdate
			}
		]
		params = { Name = <NonLocalPlayerVehicle> }
	}
	
	<NonLocalPlayerVehicle>:Obj_LockToObject Id=<SkaterId> ( ( 0, 0, 0 ) - ( <VehicleSetup>.skater_pos ) )
	<NonLocalPlayerVehicle>:SetTags current_control_type=<control_type>
endscript

script remove_car_from_non_local_skater
	MangleChecksums A=<SkaterId> B=NonLocalPlayerVehicle
	NonLocalPlayerVehicle=<mangled_id>
	
	if ObjectExists id = <NonLocalPlayerVehicle>
		<NonLocalPlayerVehicle>:Die
	endif
endscript

script DrivingCollisionLost
	PlayerVehicle:Vehicle_LostCollision <...>
endscript

script GetVehicleSetup
	switch <control_type>
		case JunkerCar
			return VehicleSetup=TransCarSetup
		case RallyCar
			return VehicleSetup=CustomCarSetup
		case ImpalaCar
			return VehicleSetup=ImpalaCarSetup
		case TaxiCar
			return VehicleSetup=TaxiCarSetup
		case PoliceCar
			return VehicleSetup=PoliceCarSetup
		case SecurityCart
			return VehicleSetup=SecurityCartSetup
		case GardnersCart
			return VehicleSetup=GardnersCartSetup
		case ElCaminoCar
			return VehicleSetup=ElCaminoCarSetup
		case Blimp
			return VehicleSetup=BlimpSetup
		case LadaCar
			return VehicleSetup=LadaCarSetup
		case MiniBajaCar
			return VehicleSetup=MiniBajaCarSetup
		case LimoCar
			return VehicleSetup=LimoCarSetup
		case LeafBlower
			return VehicleSetup=LeafBlowerSetup
	endswitch
endscript

vehicleCameraSetup = {
	alignment_rate = 3.5
	offset_height =	55
	offset_distance = 240
	angle = 0
}

script Vehicle_BodyCollision
	Vibrate Actuator=1 Percent=( 50 + 50 * <Strength> ) Duration=( 0.1 + 0.1 * <Strength> )
endscript


artificial_collision_duration = 3.0

coll_forward_imp=150
coll_sideways_imp=100
coll_upwards_imp=300
coll_spin_rot=2
coll_flip_rot=3

//////////////////////////////////////
// universal car parameters

vehicle_physics_artificial_collision_duration=3
vehicle_physics_netcoll_forward_impulse=250
vehicle_physics_netcoll_sideways_impulse=100
vehicle_physics_netcoll_upwards_impulse=300
vehicle_physics_netcoll_spin_impulse=2
vehicle_physics_netcoll_flip_impulse=3

//////////////////////////////////////
// car setups

transCarSetup = {
	control_type						= JunkerCar
	model								= "veh\veh_transam\veh_transam.mdl"
	level								= Load_Sk5Ed_gameplay
	alternate_level						= 0
	sounds								= NJ_nasalracer
	skater_pos							= ( 0, 0, 0 )
	
	suspension_center_of_mass			= -22
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 36, 28, 140 )
												( -36, 28, 140 )
												( 36, 28, -44 )
										]
										[
												( 26, 48, 58 )
												( -26, 48, 58 )
												( 26, 48, 4 )
										]
	]
	
	engine = {
		drive_torque					= 400
		drag_torque						= 800
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											4
											3
											1.5
											0.65
											0
		]
	}
	
	all_wheels = {
		radius							= 13
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 28
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
		brake_torque					= 2000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -25.5
			steering					= left
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= -25.5
			steering					= right
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= -21
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -21
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}

customCarSetup = {
	control_type						= RallyCar
	model								= "veh\veh_custom\veh_custom.mdl"
	level								= Load_NJ
	alternate_level						= 0
	sounds								= NJ_nasalracer
	skater_pos							= ( 0, 0, 0 )
	
	suspension_center_of_mass			= -22
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 42, 24, 134 )
												( -42, 24, 134 )
												( 42, 24, -30 )
										]
										[
												( 22, 55, 54 )
												( -22, 55, 54 )
												( 22, 63, -26 )
										]
	]
	
	engine = {
		drive_torque					= 400
		drag_torque						= 800
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											4
											3
											1.5
											0.65
											0
		]
	}
	
	all_wheels = {
		radius							= 13
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 28
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
		brake_torque					= 2000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -25.7
			steering					= left
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= -25.7
			steering					= right
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= -25.7
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -25.7
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}

// get the debug boxes with q vehicle_sporty:vehicle_reset debug
// white out of contact
// green under grip
// black static grip
// yellow slipping
// red skidding
// blue handbrake skidding with throttle up
// purple handbrake skidding with throttle down

//  list of tweaks
// - time for the frigged handbrake frictions to wear off
// - non flat front shape
// - some way to slide past small gaps in walls
// - need a seperate draw offset to set droop
// - dampen the steering response
// - if sliding and get on throttle less throttle less brake too
// - sligt toe value or something to kep you from going straight when you break the wheels loose

/*
offroadCarSetup = {
	model								= "veh\veh_custom\veh_custom.mdl"
	;sounds								= TestThreeGear
		
	suspension_center_of_mass			= ( 0, -10, 0 )
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.7
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 10
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 42, 12, 80 )
												( -42, 12, 80 )
												( 42, 12, -80 )
										]
										[
												( 22, 38, 4 )
												( -22, 38, 4 )
												( 22, 46, -76 )
										]
	]
	
	engine = {
		drive_torque					= 550
		drag_torque						= 450
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											6
											3
											1.5
											0.65
											0
		]
	}
	
	all_wheels = {
		radius							= 13
		moment							= 3570
		
		spring_rate						= 100
		damping_rate					= 16
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
		brake_torque					= 2000
	}
	
	wheels = [
		{
			max_draw_y_offset			= 0
			steering					= left
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= 0
			steering					= right
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= 0
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= 0
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}
*/

///  Don't tweak any of the cars below this line unless you talk with jason first.

/*
SmallSportscarSetup = {
	model								= "veh\veh_smallsportscar\veh_smallsportscar.mdl"
	sounds								= HI_Car
	
	suspension_center_of_mass			= ( 0, -16, 0 )
	mass								= 2400
	moment_of_inertia					= ( 6000000, 5500000, 6000000 )	// xyz  how much the vehicle want to rotate on a particular axis.  the lower the number the more it rotates
	body_restitution					= 0.0  // bounce when you collide with soemthing
	body_friction						= 0.1  // how much you stick when you run into something
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.2
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 500000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 39.5, 0, 108 )
												( -39.5, 0, 108 )
												( 39.5, 0, -82 )
										]
										[
												( 35, 22, 26 )
												( -35, 22, 26 )
												( 35, 22, -34 )
										]
	]
	
	engine = {
		drive_torque					= 300
		drag_torque						= 300
		upshift_rpm						= 7500
		differential_ratio				= 5
		reverse_torque_ratio			= 0.75
		gear_ratios = [
											5
											3.5
											1.5
											0.75
											0
		]
	}
	
	all_wheels = {
		radius							= 11 // wheel and tire
		moment							= 3570 // higher this number the harder it is to get wheels turning
		
		spring_rate						= 350	// bump and rebound
		damping_rate					= 20	// higer more damping
		
		static_friction					= 2.0  // the higher the number the less static friction
		
		min_static_grip_velocity		= 2  // min and max are the range between when you have grip.  difference between how fast the car is moving and how fast the wheels want to turn
		max_static_grip_velocity		= 8
		min_dynamic_grip_velocity		= 18  // mph beyond here you are sliding
		
		handbrake_torque				= 3000
	}
	
	wheels = [ // up to 6 entries
		{
			max_draw_y_offset			= -25
			steering					= left
			drive						= no
			brake_torque				= 1050
			dynamic_friction			= 2.5
			handbrake_throttle_friction	= 2.5
			handbrake_locked_friction	= 4.5
		}
		{
			max_draw_y_offset			= -25
			steering					= right
			drive						= no
			brake_torque				= 1050
			dynamic_friction			= 2.5
			handbrake_throttle_friction	= 2.5
			handbrake_locked_friction	= 4.5
		}
		{
			max_draw_y_offset			= -21	// how far you draw the tire relative to the origin of the car 
			steering					= fixed	// fixed or left/right.  4ws should work
			drive						= yes	// is this a drive wheel or not.  4wd should work
			brake_torque				= 1300	// regular brake
			dynamic_friction			= 1.6	// the higher the number the harder it is to break the wheels loose
			handbrake_throttle_friction	= 1.6	// different front friction when the throttle is on to get a drift
			handbrake_locked_friction	= 1.6	// when the handbrake is locked increase front friction           
		}
		{
			max_draw_y_offset			= -21
			steering					= fixed
			drive						= yes
			brake_torque		   		= 1300
			dynamic_friction			= 1.6
			handbrake_throttle_friction	= 1.6
			handbrake_locked_friction	= 1.6
		}
	]
}
*/

BlimpSetup = {
	control_type						= Blimp
	model								= "veh\Veh_Blimp\Veh_Blimp.mdl"
	level								= Load_SE
	alternate_level						= 0
	sounds								= SJ_Blimp
	skater_pos							= ( 0, 0, 0 )
	
	suspension_center_of_mass			= -40
	mass								= 800
	moment_of_inertia					= ( 4000000, 8000000, 4000000 )	// xyz  how much the vehicle want to rotate on a particular axis.  the lower the number the more it rotates
	body_restitution					= 0.2  // bounce when you collide with soemthing
	body_friction						= 0.1  // how much you stick when you run into something
	body_wipeout_friction				= 0.4
	body_spring							= 270
	collision_control					= 0.2
	
	max_steering_angle					= 45
	
	constant_rotational_damping			= 0
	quadratic_rotational_damping		= 0.00001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 28, 30, 60 ) //fl rr, 
												( -28, 30, 60 )
												( 28, 30, -66 )
										]
										[
												( 18, 45, 30 )
												( -18, 45, 30 )
												( 18, 45, -30 )
										]
	]
	
	engine = {
		drive_torque					= 50
		drag_torque						= 5
		upshift_rpm						= 7500
		differential_ratio				= 5
		reverse_torque_ratio			= 1.5
		gear_ratios = [
											2.5
											0
		]
	}
	
	no_handbrake
	
	all_wheels = {
		radius							= 9 // wheel and tire
		moment							= 1000 // higher this number the harder it is to get wheels turning
		
		spring_rate						= 100	// bump and rebound
		damping_rate					= 35	// higer more damping
		
		static_friction					= 1.0  // the higher the number the less static friction
		
		min_static_grip_velocity		= 10  // min and max are the range between when you have grip.  difference between how fast the car is moving and how fast the wheels want to turn
		max_static_grip_velocity		= 11
		min_dynamic_grip_velocity		= 12  // mph beyond here you are sliding
		
		handbrake_torque				= 3000
	}
	
	wheels = [ // up to 6 entries
		{
			max_draw_y_offset			= 0
			steering					= left
			drive						= yes
			brake_torque				= 0
			dynamic_friction			= 0.8
			handbrake_throttle_friction	= 0
			handbrake_locked_friction	= 0
		}
		{
			max_draw_y_offset			= 0
			steering					= right
			drive						= yes
			brake_torque				= 0
			dynamic_friction			= 0.8
			handbrake_throttle_friction	= 0
			handbrake_locked_friction	= 0
		}
		{
			max_draw_y_offset			= 0	// how far you draw the tire relative to the origin of the car 
			steering					= fixed	// fixed or left/right.  4ws should work
			drive						= yes	// is this a drive wheel or not.  4wd should work
			brake_torque				= 500	// regular brake
			dynamic_friction			= 0.8	// the higher the number the harder it is to break the wheels loose
			handbrake_throttle_friction	= 0
			handbrake_locked_friction	= 0
		}
		{
			max_draw_y_offset			= 0
			steering					= fixed
			drive						= yes
			brake_torque		   		= 500
			dynamic_friction			= 0.8
			handbrake_throttle_friction	= 0
			handbrake_locked_friction	= 0
		}
	]
}

GardnersCartSetup = {
	control_type						= GardnersCart
	model								= "veh\Veh_SDKart_Gardens\Veh_SDKart_Gardens.mdl"
	level								= Load_SD
	alternate_level						= 0
	sounds								= SD_Cart
	
	make_skater_visible
	skater_pos							= ( -10.73, 1.00, 26.18 )
	skater_anim							= Ped_Driver_Turn_Range
	suspension_center_of_mass			= -24
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.7
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 18
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 0.5
	in_air_slerp_velocity_cutoff		= 350
	vert_correction

	colliders = [
										[
												( 25, 25, 58 ) //fl rr, 
												( -25, 25, 58 )
												( 25, 25, -60 )
										]
										[
												( 25, 48, 56 )
												( -25, 48, 56 )
												( 25, 48, 10 )
										]
	]
	
	engine = {
		drive_torque					= 350
		drag_torque						= 300
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											9
											6
											2.5
											0.75
											0
		]
	}
	
	all_wheels = {
		radius							= 9
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 40
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 20
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -12
			steering					= left
			drive						= yes
			brake_torque				= 2000
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3
			handbrake_locked_friction	= 3
		}
		{
			max_draw_y_offset			= -12
			steering					= right
			drive						= yes
			brake_torque				= 2000
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3
			handbrake_locked_friction	= 3
		}
   		{
			max_draw_y_offset			= -12
			steering					= fixed
			drive						= yes
			brake_torque				= 1000
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 2.0
			handbrake_locked_friction	= 2.0
		}
		{
			max_draw_y_offset			= -12
			steering					= fixed
			drive						= yes
			brake_torque		   		= 1000
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 2.0
			handbrake_locked_friction	= 2.0
		}
	]
}

SecurityCartSetup = {
	control_type						= SecurityCart
	model								= "veh\Veh_SDKart_Security\Veh_SDKart_Security.mdl"
	level								= Load_SD
	alternate_level						= 0
	sounds								= SD_Cart
	
	make_skater_visible
	skater_pos							= ( -10.81, 1.00, 26.18 )
	skater_anim							= Ped_Driver_Turn_Range
	suspension_center_of_mass			= -24
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.7
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 18
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 0.5
	in_air_slerp_velocity_cutoff		= 350
	vert_correction

	colliders = [
										[
												( 25, 25, 58 ) //fl rr, 
												( -25, 25, 58 )
												( 25, 25, -60 )
										]
										[
												( 25, 48, 56 )
												( -25, 48, 56 )
												( 25, 48, 10 )
										]
	]
	
	engine = {
		drive_torque					= 350
		drag_torque						= 300
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											9
											6
											2.5
											0.75
											0
		]
	}
	
	all_wheels = {
		radius							= 9
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 40
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 20
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -12
			steering					= left
			drive						= yes
			brake_torque				= 2000
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3
			handbrake_locked_friction	= 3
		}
		{
			max_draw_y_offset			= -12
			steering					= right
			drive						= yes
			brake_torque				= 2000
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3
			handbrake_locked_friction	= 3
		}
   		{
			max_draw_y_offset			= -12
			steering					= fixed
			drive						= yes
			brake_torque				= 1000
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 2.0
			handbrake_locked_friction	= 2.0
		}
		{
			max_draw_y_offset			= -12
			steering					= fixed
			drive						= yes
			brake_torque		   		= 1000
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 2.0
			handbrake_locked_friction	= 2.0
		}
	]
}

LeafBlowerSetup = {
	control_type						= LeafBlower
	model								= "veh\Veh_LeafBlower\Veh_LeafBlower.mdl"
	level								= Load_VC
	alternate_level						= 0
	sounds								= VC_LeafBlower
	
	make_skater_visible
	skater_pos							= ( -0.14, 18.00, 6.98 )
	skater_anim							= Ped_Driver_Turn_Range
	suspension_center_of_mass			= -30
	mass								= 800
	moment_of_inertia					= ( 4000000, 3000000, 4000000 )	// xyz  how much the vehicle want to rotate on a particular axis.  the lower the number the more it rotates
	body_restitution					= 0.2  // bounce when you collide with soemthing
	body_friction						= 0.1  // how much you stick when you run into something
	body_wipeout_friction				= 0.4
	body_spring							= 270
	collision_control					= 0.2
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 500000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 28, 70, 40 ) //fl rr, 
												( -28, 70, 40 )
												( 28, 70, -50 )
										]
										[
												( 28, 30, 50 )
												( -28, 30, 50 )
												( 28, 30, -55 )
										]
	]
	
	engine = {
		drive_torque					= 50
		drag_torque						= 50
		upshift_rpm						= 7500
		differential_ratio				= 5
		reverse_torque_ratio			= 1.5
		gear_ratios = [
											2.5
											0
		]
	}
	
	no_handbrake
	
	all_wheels = {
		moment							= 1000 // higher this number the harder it is to get wheels turning
		
		spring_rate						= 300	// bump and rebound
		damping_rate					= 35	// higer more damping
		
		static_friction					= 4.0  // the higher the number the less static friction
		
		min_static_grip_velocity		= 2  // min and max are the range between when you have grip.  difference between how fast the car is moving and how fast the wheels want to turn
		max_static_grip_velocity		= 8
		min_dynamic_grip_velocity		= 18  // mph beyond here you are sliding
		
		handbrake_torque				= 3000
	}
	
	wheels = [ // up to 6 entries
		{
			radius						= 15 // wheel and tire
			max_draw_y_offset			= -25
			steering					= left
			drive						= yes
			brake_torque				= 500
			dynamic_friction			= 4.0
			handbrake_throttle_friction	= 2.5
			handbrake_locked_friction	= 2.5
		}
		{
			radius						= 15 // wheel and tire
			max_draw_y_offset			= -25
			steering					= right
			drive						= yes
			brake_torque				= 500
			dynamic_friction			= 4.0
			handbrake_throttle_friction	= 2.5
			handbrake_locked_friction	= 2.5
		}
		{
			radius						= 11 // wheel and tire
			max_draw_y_offset			= -5	// how far you draw the tire relative to the origin of the car 
			steering					= fixed	// fixed or left/right.  4ws should work
			drive						= yes	// is this a drive wheel or not.  4wd should work
			brake_torque				= 500	// regular brake
			dynamic_friction			= 4.0	// the higher the number the harder it is to break the wheels loose
			handbrake_throttle_friction	= 1.5	// different front friction when the throttle is on to get a drift
			handbrake_locked_friction	= 1.5	// when the handbrake is locked increase front friction           
		}
		{
			radius						= 11 // wheel and tire
			max_draw_y_offset			= -5
			steering					= fixed
			drive						= yes
			brake_torque		   		= 500
			dynamic_friction			= 4.0
			handbrake_throttle_friction	= 1.5
			handbrake_locked_friction	= 1.5
		}
	]
}

/*
RCCarSetup = {
	model								= "veh\veh_rc\veh_rc.mdl"
	
	suspension_center_of_mass			= ( 0, -10, 0 )
	mass								= 2943
	moment_of_inertia					= ( 6000000, 6000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 15
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 42, 12, 92 )
												( -42, 12, 92 )
												( 42, 12, -80 )
										]
										[
												( 22, 42, 18 )
												( -22, 42, 18 )
												( 22, 52, -74 )
										]
	]
	
	engine = {
		drive_torque					= 400
		drag_torque						= 400
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											4
											3
											1.5
											0.75
											0
		]
	}
	
	all_wheels = {
		radius							= 13
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 28
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 20
		
		handbrake_torque				= 3000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -25.5
			steering					= left
			drive						= yes
			brake_torque				= 2000
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= -25.5
			steering					= right
			drive						= yes
			brake_torque				= 2000
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= -26
			steering					= fixed
			drive						= yes
			brake_torque				= 1000
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -26
			steering					= fixed
			drive						= yes
			brake_torque		   		= 1000
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}
*/

ImpalaCarSetup = {
	control_type						= ImpalaCar
	model								= "veh\veh_chevy_impala\veh_chevy_impala.mdl"
	level								= Load_NY
	alternate_level						= 0
	sounds								= NY_JunkCar
	skater_pos							= ( 0, 0, 0 )
	
	suspension_center_of_mass			= -20
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 39.5, 26, 126 )
												( -40.5, 26, 126 )
												( 39.5, 26, -60 )
										]
										[
												( 31, 46, 52 )
												( -31, 46, 52 )
												( 31, 42, -8 )
										]
	]
	
	engine = {
		drive_torque					= 400
		drag_torque						= 800
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											4
											3
											1.5
											0.65
											0
		]
	}
	
	all_wheels = {
		radius							= 13
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 28
		
		static_friction					= 3.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
		brake_torque					= 2000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -22.5
			steering					= left
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= -22.5
			steering					= right
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= -19.5
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -19.5
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}

/*
TaxiCarSetup = {
	control_type						= TaxiCar
	model								= "veh\ny\veh_cab_ny\veh_cab_ny.mdl"
	level								= 0
	alternate_level						= 0
	sounds								= NY_Car02
	skater_pos							= ( 0, 0, 0 )
	
	suspension_center_of_mass			= -22
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 34, 27, 155 )
												( -34, 27, 155 )
												( 34, 27, -58 )
										]
										[
												( 26, 55, 64 )
												( -26, 55, 64 )
												( 26, 55, 4 )
										]
	]
	
	
	engine = {
		drive_torque					= 400
		drag_torque						= 800
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											4
											3
											1.5
											0.65
											0
		]
	}
	
	all_wheels = {
		radius							= 13
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 28
		
		static_friction					= 3.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
		brake_torque					= 2000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -25.5
			steering					= left
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= -25.5
			steering					= right
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= -20
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -20
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}
*/

PoliceCarSetup = {
	control_type						= PoliceCar
	model								= "veh\fl\veh_policecar_fl\veh_policecar_fl.mdl"
	level								= Load_FL
	alternate_level						= 0
	sounds								= FL_PoliceCar
	skater_pos							= ( 0, 0, 0 )
	
	suspension_center_of_mass			= -24
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 33, 25, 150 )
												( -33, 25, 150 )
												( 33, 25, -65 )
										]
										[
												( 28, 55, 62 )
												( -28, 55, 62 )
												( 28, 55, -2 )
										]
	]
	
	engine = {
		drive_torque					= 400
		drag_torque						= 800
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											4
											3
											1.5
											0.65
											0
		]
	}
	
	all_wheels = {
		radius							= 13
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 28
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
		brake_torque					= 2000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -25.5
			steering					= left
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= -25.5
			steering					= right
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= -20
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -20
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}

ElCaminoCarSetup = {
	control_type						= ElCaminoCar
	model								= "veh\veh_camino\veh_camino.mdl"
	level								= Load_HI
	alternate_level						= 0
	sounds								= HI_Car
	skater_pos							= ( 0, 0, 0 )
	
	suspension_center_of_mass			= -22
	mass								= 2943
	moment_of_inertia					= ( 6000000, 6000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 36, 27, 151 )
												( -36, 27, 151 )
												( 36, 33, -58 )
										]
										[
												( 24, 53, 68 )
												( -24, 53, 68 )
												( 24, 53, 38 )
										]
	]
	
	engine = {
		drive_torque					= 400
		drag_torque						= 800
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											4
											3
											1.5
											0.65
											0
		]
	}
	
	all_wheels = {
		radius							= 13
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 28
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
		brake_torque					= 2000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -24.5
			steering					= left
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= -24.5
			steering					= right
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= -17
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -17
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}

LimoCarSetup = {
	control_type						= LimoCar
	model								= "veh\veh_limo\veh_limo.mdl"
	level								= Load_VC
	alternate_level						= 0
	sounds								= VC_Limo
	skater_pos							= ( 0, 0, 0 )
	
	suspension_center_of_mass			= -15
	mass								= 2943
	moment_of_inertia					= ( 6000000, 20000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 39.5, 25, 212 )
												( -39.5, 25, 212 )
												( 39.5, 25, -85 )
										]
										[
												( 27, 64, 115 )
												( -27, 64, 115 )
												( 27, 64, -28 )
										]
	]
	
	engine = {
		drive_torque					= 400
		drag_torque						= 800
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											4
											3
											1.5
											0.65
											0
		]
	}
	
	all_wheels = {
		radius							= 13
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 28
		
		// Dan: modified this value from cookie cutter to stop shudder due to the limo extremely long wheel base
		static_friction					= 2.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
		brake_torque					= 2000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -25.7
			steering					= left
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= -25.7
			steering					= right
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= -26
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -26
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}

MiniBajaCarSetup = {
	control_type						= MiniBajaCar
	model								= "veh\veh_minibaja\veh_minibaja.mdl"
	level								= Load_SE
	alternate_level						= Load_Sk5Ed_gameplay
	sounds								= SE_ATV
	
	make_skater_visible
	skater_pos							= ( -0.65, -2.00, 4.07 )
	skater_anim							= Ped_Baha_Drive
	
	suspension_center_of_mass			= -21
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.6
	body_friction						= 0.2
	body_wipeout_friction				= 0.7
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 25
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 0.5
	in_air_slerp_velocity_cutoff		= 350
	vert_correction
	
	colliders = [
										[
												( 37, 30, 41 )
												( -37, 30, 41 )
												( 37, 30, -36 )
										]
										[
												( 12, 64, 16 )
												( -12, 64, 16 )
												( 12, 64, -28 )
										]
	]
	
	engine = {
		drive_torque					= 550
		drag_torque						= 450
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											9
											6
											2.5
											0.75
											0
		]
	}
	
	all_wheels = {
		radius							= 14
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 16
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 20
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -20
			steering					= left
			drive						= yes
			brake_torque				= 2000
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3
			handbrake_locked_friction	= 3
		}
		{
			max_draw_y_offset			= -20
			steering					= right
			drive						= yes
			brake_torque				= 2000
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3
			handbrake_locked_friction	= 3
		}
   		{
			max_draw_y_offset			= -20
			steering					= fixed
			drive						= yes
			brake_torque				= 1000
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 1.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -20
			steering					= fixed
			drive						= yes
			brake_torque		   		= 1000
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 1.0
			handbrake_locked_friction	= 1.0
		}
	]
}

LadaCarSetup = {
	control_type						= LadaCar
	model								= "veh\veh_lada\veh_lada.mdl"
	level								= Load_RU
	alternate_level						= 0
	sounds								= RU_ForeignCar
	skater_pos							= ( 0, 0, 0 )
	
	suspension_center_of_mass			= -22
	mass								= 2943
	moment_of_inertia					= ( 6000000, 5000000, 6000000 )
	body_restitution					= 0.3
	body_friction						= 0.2
	body_wipeout_friction				= 0.4
	body_spring							= 1200
	collision_control					= 0.25
	
	max_steering_angle					= 30
	
	constant_rotational_damping			= 2000000
	quadratic_rotational_damping		= 0.0001
	
	in_air_slerp_strength				= 5
	in_air_slerp_time_delay				= 1
	in_air_slerp_velocity_cutoff		= 350
	
	colliders = [
										[
												( 29, 30, 118 )
												( -29, 30, 118 )
												( 29, 30, -44 )
										]
										[
												( 24, 56, 65 )
												( -24, 56, 65 )
												( 24, 56, 0 )
										]
	]
		
	engine = {
		drive_torque					= 400
		drag_torque						= 800
		upshift_rpm						= 5000
		differential_ratio				= 5
		reverse_torque_ratio			= 1
		gear_ratios = [
											4
											3
											1.5
											0.65
											0
		]
	}
	
	all_wheels = {
		radius							= 11
		moment							= 3570
		
		spring_rate						= 200
		damping_rate					= 28
		
		static_friction					= 4.0
		
		min_static_grip_velocity		= 8
		max_static_grip_velocity		= 12
		min_dynamic_grip_velocity		= 30
		
		handbrake_torque				= 3000
		brake_torque					= 2000
	}
	
	wheels = [
		{
			max_draw_y_offset			= -21
			steering					= left
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
		{
			max_draw_y_offset			= -21
			steering					= right
			drive						= yes
			dynamic_friction			= 2.8
			handbrake_throttle_friction	= 3.5
			handbrake_locked_friction	= 4.0
		}
   		{
			max_draw_y_offset			= -16
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
		{
			max_draw_y_offset			= -16
			steering					= fixed
			drive						= yes
			dynamic_friction			= 3.5
			handbrake_throttle_friction	= 3.0
			handbrake_locked_friction	= 1.0
		}
	]
}

defaultCarSetup=customCarSetup
