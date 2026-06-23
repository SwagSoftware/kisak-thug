// playervehiclesounds.q
// Contains structures which define the sound setups available for player vehicles.

// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!

// global vehicle sound parameters used by the C-code
PlayerVehicleSoundGlobalParameters={
	idle_engine_effective_speed_factor=0.5
	effective_speed_lerp_rate=3
	effective_speed_adjust_up_rate=12
	effective_speed_adjust_down_rate=6
	gear_shift_min_vol_factor=0.3
	gear_shift_vol_adjustment_duration=200
	engine_rpm_lerp_rate=12
	engine_airborne_delay=0.04

	tire_slip_lerp_rate=10

	collision_cutoff_factor=0.1
	collision_mute_delay=800

	// sound checksums used in CAG car goals (as specific car sounds may not be loaded for the level)
	CAGEngineSound=CarLoop
	CAGTireSound=Vehicle_Tire_Loop
	CAGCollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }
}

// To obtain debug info on player controlled vehicle sounds, set the following flags in your personal q-file.
// DebugPlayerVehicleEngineSound=1
// DebugPlayerVehicleTireSound=1
// DebugPlayerVehicleCollisionSound=1

// Normally vehicle sound setups do not respond to qbr.  To have the vehicle sounds update their setup every frame (and thus respond to qbr), set this flag.
// DynamicPlayerVehicleSound=1

PlayerVehicleSounds={

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	Default={

		// looping sound to use for the engine
		EngineSound=carloop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=60
		MaxEnginePitch=120

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=50
				BottomRPM=60
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=10
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=75

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=40
				TopRPM=100
			}
			{
				DownshiftPoint=50
				UpshiftPoint=100
				BottomRPM=20
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	NJ_NasalRacer={

		// looping sound to use for the engine
		EngineSound=NJ_NasalRacer04

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=200
		MinEnginePitch=60
		MaxEnginePitch=120

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=40
				BottomRPM=10
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=20
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=60

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=35
				TopRPM=100
			}
			{
				DownshiftPoint=40
				UpshiftPoint=80
				BottomRPM=40
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	NY_JunkCar={

		// looping sound to use for the engine
		EngineSound=carloop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=60
		MaxEnginePitch=120

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=50
				BottomRPM=60
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=10
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=75

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=40
				TopRPM=100
			}
			{
				DownshiftPoint=50
				UpshiftPoint=100
				BottomRPM=20
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	NY_Car02={

		// looping sound to use for the engine
		EngineSound=carloop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=60
		MaxEnginePitch=120

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=50
				BottomRPM=60
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=10
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=75

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=40
				TopRPM=100
			}
			{
				DownshiftPoint=50
				UpshiftPoint=100
				BottomRPM=20
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	FL_PoliceCar={

		// looping sound to use for the engine
		EngineSound=carloop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=60
		MaxEnginePitch=110

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=40
				BottomRPM=30
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=25
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=60

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=40
				TopRPM=100
			}
			{
				DownshiftPoint=50
				UpshiftPoint=85
				BottomRPM=30
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	SD_Cart={

		// looping sound to use for the engine
		EngineSound=SD_CartLoop

		// volume and pitch used at min and max RPM values
		MinEngineVol=25
		MaxEngineVol=180
		MinEnginePitch=25
		MaxEnginePitch=75

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=35
				BottomRPM=0
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=600

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=100
		MaxTirePitch=130


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=180 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	HI_Car={

		// looping sound to use for the engine
		EngineSound=carloop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=60
		MaxEnginePitch=120

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=50
				BottomRPM=60
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=10
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=75

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=40
				TopRPM=100
			}
			{
				DownshiftPoint=50
				UpshiftPoint=100
				BottomRPM=20
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	VC_Limo={

		// looping sound to use for the engine
		EngineSound=carloop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=60
		MaxEnginePitch=110

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=40
				BottomRPM=20
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=20
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=75

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=30
				TopRPM=100
			}
			{
				DownshiftPoint=50
				UpshiftPoint=100
				BottomRPM=40
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	VC_LeafBlower={

		// looping sound to use for the engine
		EngineSound=VC_LeafBlowerEngineLoop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=70
		MaxEnginePitch=100

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=35
				BottomRPM=0
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	SJ_Blimp={

		// looping sound to use for the engine
		EngineSound=SJ_BlimpEngineLoop

		// volume and pitch used at min and max RPM values
		MinEngineVol=100
		MaxEngineVol=150
		MinEnginePitch=80
		MaxEnginePitch=120

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=25
				BottomRPM=0
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=15000

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=0 maxVel=0 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	RU_ForeignCar={

		// looping sound to use for the engine
		EngineSound=carloop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=60
		MaxEnginePitch=120

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=50
				BottomRPM=60
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=10
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=75

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=40
				TopRPM=100
			}
			{
				DownshiftPoint=50
				UpshiftPoint=100
				BottomRPM=20
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	SE_ATV={

		// looping sound to use for the engine
		EngineSound=carloop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=60
		MaxEnginePitch=120

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=50
				BottomRPM=60
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=10
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=75

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=40
				TopRPM=100
			}
			{
				DownshiftPoint=50
				UpshiftPoint=100
				BottomRPM=20
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	TestThreeGear={

		// looping sound to use for the engine
		EngineSound=carloop

		// volume and pitch used at min and max RPM values
		MinEngineVol=150
		MaxEngineVol=180
		MinEnginePitch=60
		MaxEnginePitch=120

		// min and max RPM values
		MinEngineRPM=0
		MaxEngineRPM=100

		// each gear will map a range of speeds onto a range between the min and max RPM values
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=50
				BottomRPM=60
				TopRPM=100
			}
			{
				// These two parameters control the range of velocities over which this gear will be active.
				// When the vehicle goes below this velocity, the gear shifts down.  Obviously, this needs to be somewhat lower than the previous gear's
				// UpshiftPoint, or the car will quickly switch back and forth between the two gears.
				DownshiftPoint=10
				// When the vehicle goes above this velocity, the gear shifts up.
				UpshiftPoint=75

				// While in this gear, the RPMs will run between these values.  When the velocity equals UpshiftPoint, the RPMs will equal TopRPM.  When
				// the velocity equals the lower gear's UpshiftPoint, the RPMs will equal BottomRPM.
				BottomRPM=40
				TopRPM=100
			}
			{
				DownshiftPoint=50
				UpshiftPoint=100
				BottomRPM=20
				TopRPM=100
			}
		]


		// looping sound to use for the tire squeals
		TireSound=Vehicle_Tire_Loop

		// tire slip velocity at which the max volume and pitch are used
		FullTireSlipVelocity=1500

		// volume and pitch range used as the tire slip velocity ranges between 0 and FullTireSlipVelocity
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100


		// sound structure used for body collision sounds
		CollideSound={ BonkMetal_11 minVol=100 maxVel=300 minPitch=80 maxPitch=120 }

		// collision speed at which the max volume and pitch are used
		FullCollision=5000
	}

	// DO NOT TOUCH WITHOUT TALKING TO DAVID, FIRST!
	TestSingleGear={

		EngineSound=Moto7000rpm01
		MinEngineRPM=0
		MaxEngineRPM=100
		MinEngineVol=50
		MaxEngineVol=100
		MinEnginePitch=50
		MaxEnginePitch=100
		Gears=[
			{
				DownshiftPoint=0
				UpshiftPoint=35
				BottomRPM=0
				TopRPM=100
			}
		]

		TireSound=Vehicle_Tire_Loop
		FullTireSlipVelocity=1500
		MinTireVol=0
		MaxTireVol=300
		MinTirePitch=80
		MaxTirePitch=100

		CollideSound={ BonkMetal_11 minVol=80 maxVel=100 }
		FullCollision=500
	}
}
