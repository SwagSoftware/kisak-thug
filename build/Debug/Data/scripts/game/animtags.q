// maybe these get merged as custom anim keys during the build process?

AnimTagTable = {

	Ped_M_Walk1 = {
		MovementSpeed=50.4692            // 53.83379 inches / 1.0666667 seconds
	}

	Ped_M_WalkTired = {
		MovementSpeed=45.1500            // 51.43985 inches / 1.6 seconds
	}

	Ped_M_Walk2 = {
		MovementSpeed=65.4019            // 69.73206" inches / 1.066667 seconds
	}

	Ped_M_Walk3 = {
		MovementSpeed=87.5720            // 81.73355" inches / 0.933334 seconds
	}

	Ped_M_Walk4 = {
		MovementSpeed=121.6565           // 97.32519" inches / 0.8 seconds
	}

	Ped_M_Run1 = {
		MovementSpeed=168.0276           // 112.01845" inches / 0.666667 seconds
	}

	Ped_M_Run2 = {
		MovementSpeed=221.2893           // 132.77359" inches / 0.6 seconds
	}

	WWalk = {
		MovementSpeed=59.624           // 63.6" inches / 0.6 seconds
	}

	WRunToSkate = {
		WalkToSkateTransition
	}

	JumpAirTo5050 = {
		WalkToSkateTransition
	}

	JumpAirToManual = {
		WalkToSkateTransition
	}

	JumpAirToAirIdle = {
		WalkToSkateTransition
	}
}

/*
script sample_movement_speed_script
	Skater:GetTags
	if GotParam animTags
		set_movement_speed <animTags>
	endif
endscript

script set_movement_speed
	printstruct <...>
	if GotParam MovementSpeed
	else
		printf "No Movement speed"
	endif
endscript
*/

