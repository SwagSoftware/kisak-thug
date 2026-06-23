;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; physics.q
;
; This contains a lot of constants that are mainly used
; to control the movement of the skater and the camera
;
; Units vary a bit, depending on what is most appropiate,
; but I've tried to stick to inches
;
; Speeds will be in inches per second  (ips)
;
; Things that are affected by stats are specified in the following way:
;
; thing_name = { (100, 200) stat = STATS_OLLIE, limit = 220 }
;
; "100" is the value with stats at 0
; "200" is the value with stats at 10
; "STATS_OLLIE" is the name of the stat that effects this value
; "limit = 220" is the maximum value of this stat, this would usually be used to
;  prevent the stat going too high when "special" (which boosts you to 13)
;  however, you can also set it to a value less than "high", if you want to cap
;  the stat before it reaches
; ("limit" is optional)


;use_bike_physics = 0


Skater_Default_Stats = 5.0                ; range of 0.0 to 10.0, and beyond!!!!
//Skater_Default_Stats = 13.0                ; range of 0.0 to 10.0, and beyond!!!!

///*********************************************************************

STATS_AIR = 0
STATS_RUN = 1
STATS_OLLIE = 2
STATS_SPEED = 3
STATS_SPIN = 4
STATS_FLIPSPEED = 5
STATS_SWITCH = 6
STATS_RAILBALANCE = 7
STATS_LIPBALANCE = 8
STATS_MANUAL = 9

standard_switch = (0.9,1.0)
no_switch = (1.0,1.0)
// Tweaks to the balancing physics due to difficulty settings
// These are currently used by grind, lip, and manual balance
LEAN_GRAVITY_DIFF = (0.001, 1.0)
LEAN_ACC_DIFF = (0.75, 1.0)

// ----------- original physics
// ----------- original physics
// ----------- original physics
// ----------- original physics
// ----------- original physics

skater_physics = {

	;
	; autoturn, auto-turn, auto turn, automatic turning
	;
	Physics_RunTimer_Duration			= { (3.0,4.0)	STATS_RUN	switch=no_switch }		; seconds of runtime allotted

	Skater_autoturn_speed         = 3.0         ; radians per second the skater will autoturn
	skater_autoturn_cancel_time   = 300 ; time we have to try to turn for before we cancel autoturn
	skater_autoturn_vert_angle    = 5         ; degrees from vert that we have to be in order to auto-turn

	Physics_Standing_Air_Friction		= 0.0000100 ; this is a ratio, multiplied by velocity squared
	Physics_Crouched_Air_Friction		= 0.0000020 ; x10 much less air friction if crouched


	Physics_Rolling_Friction =     0.00001           ; this is a constant decellaration applied when skating
	; essetially it's the friction that makes you stop
	; It's set realy really small, as you don't generally
	; want to stop
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Ken note: The friction is now settable using SetRollingFriction.
	; It defaults to Physics_Rolling_Friction in the skater's constructor,
	; and 'SetRollingFriction Default' will also reset it to Physics_Rolling_Friction

	Skater_Max_Standing_Kick_Speed_Stat = { (394,496) limit = 900   STATS_SPEED   switch = (.8,1.0)}          ; (355,496) the speed at which you stop kicking (when standing)
	Skater_Max_Crouched_Kick_Speed_Stat = { ( 532,675 ) limit = 900  STATS_SPEED    switch = (.8,1.0)}         ; (475, 675)
	Physics_Standing_Acceleration_Stat  = { (629,700)     STATS_SPEED             switch = standard_switch}      ; (600,700) general acceleration when standing
	Physics_Crouching_Acceleration_stat	= { (1057,1200)   STATS_SPEED             switch = standard_switch}      ; (1000,1200)or crouched
	Skater_Max_Speed_Stat               = { (757,900)     STATS_SPEED             switch = no_switch }           ; (700,900) heavy friction above this
	Skater_Max_Max_Speed_Stat           = { (957,1100)    STATS_SPEED  switch = no_switch }             ; (900,1100) absolute limit on velocity
	Skater_default_head_height      = 77            // inches to top of head, included deck

	Physics_Ground_Snap_Up = 13                        //   inches

	Physics_Air_Snap_Up = 15          ; (Was 15) inches we allow for slack when colliding with things when in the air
	; and moving upwards.  We will be snapped up by up to this distance
	///////////////////////////////////////////////////////////////////
	// If Physics_Ground_Snap_Down is slightly larger than
	// Skater_First_Forward_Collision_Height, we can manual off curbs
	// and not go into our air state when skating over them
	Physics_Ground_Snap_Down = 8.2                       // was 5, but needs to be big to handle going fast

	;Physics_Ground_Snap_Down_Skitching = 150.0           // much bigger when skitching, as we might go really fast
	;Physics_Ground_Snap_up_Skitching =    50.0           // much bigger when skitching, as we might go really fast

	Skater_First_Forward_Collision_Height = 8.1        // inches
	Skater_First_Forward_Collision_Length = 10         // inches

	// should be less than Skater_First_Forward_Collision_Height
	Skater_Min_Distance_To_Wall = 8.0                   // inches, was 10

	// the above are all related (note, 8.2 > 8.1 > 8.0)
	////////////////////////////////////////////////////////////////

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; spinning and turning

	Physics_Ground_Rotation = 1.8 	        ; radians per second, this defines your turning circle on the ground
	Physics_Ground_Sharp_Rotation = 3.6 	; radians per second, shapr turn (down held)

	Physics_Air_No_Rotate_Time   = 0100       ; (ms) time we don't rotate, to allow to tapping direction
	Physics_Air_Ramp_Rotate_Time = 0050 	  ; (ms) time over which we ramp to full speed

	spin_count_slop = 60                ; how close we have to be to a 180 for it to count


	; linear acceleration, note g is 32 f/s/s (or 32*12 = 384 inches/s/s)
	Physics_Air_Gravity      = -1350                ; was -1350 gravity when in air
	Physics_Ground_Gravity   = -1000                ; gravity when on ground (for sloped ground)
	Physics_Rail_Gravity   = -2000                  ; gravity on a rail
	Wall_Ride_Gravity = -969            ; This initial value calculated from TH2.


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Ground_stick_angle              = 30    ; angle between two faces beyond which we cannot stick to the ground
	Ground_stick_angle_forward      = 60    ; bigger when "forward" is held


	Physics_Brake_Acceleration	 = 900.0            ; The force due to braking (was 700 in THPS3, SP upped to 900)

	Physics_Air_Lean_stat  = { (1.0,1.0) STATS_SPIN switch = standard_switch}               ; lean speed in the air


	Physics_Air_Rotation_stat  = { (6.85,7.75) STATS_SPIN switch = standard_switch}               ; (6.5,7.75)spin speed in the air
	Physics_air_tap_turn_speed_stat = { (6.85,7.75) STATS_SPIN switch = standard_switch}               ; tap-turn speed

	Physics_Acid_Drop_Pop_Speed = 200						; The upward speed pop you are given at the start of an acid drop
	Physics_Transfer_Speed_Limit_Override_Drop_Rate = 0.5	; Speed limits drop by this fraction of the standard speed limits each second
	Physics_Transfer_Speed_Limit_Override_Max = 1.75		; Maximum factor of standard speed limits obtainable via transfers
}

/********* Removed with advent of CWalkComponent *************
// Walking version of the above
walk_physics = {


;
; autoturn, auto-turn, auto turn, automatic turning
;
    Skater_autoturn_speed         = 3.0         ; radians per second the skater will autoturn
    skater_autoturn_cancel_time   = 300 ; time we have to try to turn for before we cancel autoturn
    skater_autoturn_vert_angle    = 5         ; degrees from vert that we have to be in order to auto-turn

	Physics_Standing_Air_Friction		= 0.0000100 ; this is a ratio, multiplied by velocity squared
	Physics_Crouched_Air_Friction		= 0.0000020 ; x10 much less air friction if crouched


	Physics_Rolling_Friction =     0.00001           ; this is a constant decellaration applied when skating
                                                ; essetially it's the friction that makes you stop
                                                ; It's set realy really small, as you don't generally
                                                ; want to stop
                                                ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                ; Ken note: The friction is now settable using SetRollingFriction.
                                                ; It defaults to Physics_Rolling_Friction in the skater's constructor,
                                                ; and 'SetRollingFriction Default' will also reset it to Physics_Rolling_Friction

    Skater_Max_Standing_Kick_Speed_Stat = { (100,100) limit = 900   STATS_SPEED   switch = no_switch}          ; the speed at which you stop kicking (when standing)
    Skater_Max_Crouched_Kick_Speed_Stat = { ( 600,600 ) limit = 900  STATS_SPEED    switch = no_switch}

    Physics_Standing_Acceleration_Stat  = { (200,200)     STATS_SPEED             switch = no_switch}      ; general acceleration when standing

    Physics_Crouching_Acceleration_stat	= { (600,600)   STATS_SPEED             switch = no_switch}      ; or crouched
    Skater_Max_Speed_Stat               = { (800,800)     STATS_SPEED             switch = no_switch }           ; heavy friction above this
    Skater_Max_Max_Speed_Stat           = { (900,900)    STATS_SPEED  switch = no_switch }             ;absolute limit on velocity
    Skater_default_head_height      = 77            // inches to top of head, included deck

    Physics_Ground_Snap_Up = 13                        //   inches

    Physics_Air_Snap_Up = 15          ; (Was 15) inches we allow for slack when colliding with things when in the air
                                      ; and moving upwards.  We will be snapped up by up to this distance
    ///////////////////////////////////////////////////////////////////
    // If Physics_Ground_Snap_Down is slightly larger than
    // Skater_First_Forward_Collision_Height, we can manual off curbs
    // and not go into our air state when skating over them
    Physics_Ground_Snap_Down = 8.2                       // was 5, but needs to be big to handle going fast

    Physics_Ground_Snap_Down_Skitching = 150.0           // much bigger when skitching, as we might go really fast
    Physics_Ground_Snap_up_Skitching =    50.0           // much bigger when skitching, as we might go really fast

    Skater_First_Forward_Collision_Height = 12.1        // inches
    Skater_First_Forward_Collision_Length = 10         // inches

    // should be less than Skater_First_Forward_Collision_Height
    Skater_Min_Distance_To_Wall = 8.0                   // inches, was 10

    // the above are all related (note, 8.2 > 8.1 > 8.0)
    ////////////////////////////////////////////////////////////////

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; spinning and turning

    Physics_Ground_Rotation = 1.8 	        ; radians per second, this defines your turning circle on the ground
    Physics_Ground_Sharp_Rotation = 3.6 	; radians per second, shapr turn (down held)

    Physics_Air_No_Rotate_Time   = 0100       ; (ms) time we don't rotate, to allow to tapping direction
    Physics_Air_Ramp_Rotate_Time = 0050 	  ; (ms) time over which we ramp to full speed

    spin_count_slop = 60                ; how close we have to be to a 180 for it to count


    ; linear acceleration, note g is 32 f/s/s (or 32*12 = 384 inches/s/s)
    Physics_Air_Gravity      = -1350                ; was -1350 gravity when in air
    Physics_Ground_Gravity   = 0    ; -1000                ; gravity when on ground (for sloped ground)
    Physics_Rail_Gravity   = -2000                  ; gravity on a rail
    Wall_Ride_Gravity = -969            ; This initial value calculated from TH2.


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    Ground_stick_angle              = 30    ; angle between two faces beyond which we cannot stick to the ground
    Ground_stick_angle_forward      = 60    ; bigger when "forward" is held


    Physics_Brake_Acceleration	 = 900.0            ; The force due to braking (was 700 in THPS3, SP upped to 900)

	Physics_Air_Lean_stat  = { (1.0,1.0) STATS_SPIN switch = standard_switch}               ; lean speed in the air


	Physics_Air_Rotation_stat  = { (6.5,7.75) STATS_SPIN switch = standard_switch}               ; spin speed in the air
	Physics_air_tap_turn_speed_stat = { (6.5,7.75) STATS_SPIN switch = standard_switch}               ; tap-turn speed




}
*/

// skater physics ends here

// ----------------------------------   Motocorss follows
// ----------------------------------   Motocorss follows
// ----------------------------------   Motocorss follows
// ----------------------------------   Motocorss follows
// ----------------------------------   Motocorss follows
// ----------------------------------   Motocorss follows
// ----------------------------------   Motocorss follows
// ----------------------------------   Motocorss follows

/*

BIKE_TOP_SPEED = 2000

bike_physics = {

;
; autoturn, auto-turn, auto turn, automatic turning
;
    Skater_autoturn_speed         = 3.0         ; radians per second the skater will autoturn
    skater_autoturn_cancel_time   = 300 ; time we have to try to turn for before we cancel autoturn
    skater_autoturn_vert_angle    = 0         ; degrees from vert that we have to be in order to auto-turn

// Scott's values, way too high (500x the skateboard)
//	Physics_Standing_Air_Friction		= 0.0050 ; this is a ratio, multiplied by velocity squared
//	Physics_Crouched_Air_Friction		= 0.0000020 ; x10 much less air friction if crouched
//	Physics_Rolling_Friction =     0.00001           ; this is a constant decellaration applied when skating

// Mick's values, higher than the skatebaord, but not much
	Physics_Standing_Air_Friction		= 0.0000500 ; this is a ratio, multiplied by velocity squared
	Physics_Crouched_Air_Friction		= 0.0000020 ; x10 much less air friction if crouched
	Physics_Rolling_Friction =     0.000001           ; this is a constant decellaration applied when skating

// The original skateboard values
//    Physics_Standing_Air_Friction		= 0.0000100 ; this is a ratio, multiplied by velocity squared
//	Physics_Crouched_Air_Friction		= 0.0000020 ; x10 much less air friction if crouched
//	Physics_Rolling_Friction =     0.00050           ; this is a constant decellaration applied when skating
													; essetially it's the friction that makes you stop
													; It's set realy really small, as you don't generally
													; want to stop
													;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
													; Ken note: The friction is now settable using SetRollingFriction.
													; It defaults to Physics_Rolling_Friction in the skater's constructor,
													; and 'SetRollingFriction Default' will also reset it to Physics_Rolling_Friction


	Skater_Max_Standing_Kick_Speed_Stat = { (100,100) limit = 100   STATS_SPEED   switch = no_switch}          ; the speed at which you stop kicking (when standing)
	Skater_Max_Crouched_Kick_Speed_Stat = { (1500,1500 ) limit = 1500  STATS_SPEED    switch = no_switch}
	Physics_Standing_Acceleration_Stat  = { (0,0)     				STATS_SPEED         	switch = no_switch}      ; general acceleration when standing
	Physics_Crouching_Acceleration_stat	= { (2100,2100)   STATS_SPEED     	switch = no_switch}      ; or crouched
	Skater_Max_Speed_Stat               = { (1500,1500)     STATS_SPEED   	switch = no_switch }           ; heavy friction above this
	Skater_Max_Max_Speed_Stat           = { (1750,1750)      STATS_SPEED switch = no_switch }             ;absolute limit on velocity



	Skater_default_head_height      = 77            // inches to top of head, included deck

	Physics_Ground_Snap_Up = 32   //13                       //   inches

	Physics_Air_Snap_Up = 35  // 15          ; (Was 15) inches we allow for slack when colliding with things when in the air
									  ; and moving upwards.  We will be snapped up by up to this distance
	///////////////////////////////////////////////////////////////////
	// If Physics_Ground_Snap_Down is slightly larger than
	// Skater_First_Forward_Collision_Height, we can manual off curbs
	// and not go into our air state when skating over them
	Physics_Ground_Snap_Down = 28.2    // 8.2                   // was 5, but needs to be big to handle going fast

	Physics_Ground_Snap_Down_Skitching = 150.0           // much bigger when skitching, as we might go really fast
	Physics_Ground_Snap_up_Skitching =    50.0           // much bigger when skitching, as we might go really fast

	Skater_First_Forward_Collision_Height = 28.1 //8.1       // inches
	Skater_First_Forward_Collision_Length = 10         // inches

	// should be less than Skater_First_Forward_Collision_Height
	Skater_Min_Distance_To_Wall = 28.0       //8.0            // inches, was 10

	// the above are all related (note, 8.2 > 8.1 > 8.0)
	////////////////////////////////////////////////////////////////

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; spinning and turning

	Physics_Ground_Rotation = 1.8 	        ; radians per second, this defines your turning circle on the ground
	Physics_Ground_Sharp_Rotation = 3.6 	; radians per second, shapr turn (down held)

	Physics_Air_No_Rotate_Time   = 0100       ; (ms) time we don't rotate, to allow to tapping direction
	Physics_Air_Ramp_Rotate_Time = 0050 	  ; (ms) time over which we ramp to full speed

	spin_count_slop = 60                ; how close we have to be to a 180 for it to count


	; linear acceleration, note g is 32 f/s/s (or 32*12 = 384 inches/s/s)
	Physics_Air_Gravity      = -1550    // -1350                ; was -1350 gravity when in air
	Physics_Ground_Gravity   = -1000                ; gravity when on ground (for sloped ground)
	Physics_Rail_Gravity   = -2000                  ; gravity on a rail
	Wall_Ride_Gravity = -969            ; This initial value calculated from TH2.

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	Ground_stick_angle              = 15    ; angle between two faces beyond which we cannot stick to the ground
	Ground_stick_angle_forward      = 60    ; bigger when "forward" is held


	Physics_Brake_Acceleration	 = 1500     // 900.0            ; The force due to braking (was 700 in THPS3, SP upped to 900)

	Physics_Air_Lean_stat  = { (5.0,5.0) STATS_SPIN switch = no_switch}               ; lean speed in the air
	Physics_Air_Rotation_stat  = { (5,5) STATS_SPIN switch = no_switch}               ; spin speed in the air
	Physics_air_tap_turn_speed_stat = { (5,5) STATS_SPIN switch = no_switch}               ; tap-turn speed

	Physics_Acid_Drop_Pop_Speed = 200						; The upward speed pop you are given at the start of an acid drop
	Physics_Acid_Drop_Speed_Limit_Override_Duration = 5		; Number of seconds after an acid drop (not counting air time) that speed limits are overridden
}

*/

// ------------------------------------------- END
// ------------------------------------------- END
// ------------------------------------------- END
// ------------------------------------------- END
// ------------------------------------------- END

Skater_Flip_Speed_Stat              = { (1.16, 1.3) STATS_FLIPSPEED switch = standard_switch}    // (1.0, 1.3) speed multiplier for flip tricks

; speed of jump (upwards speed, basically governs the height)
; note, a "range" is the range specified by the range of stats, 0..10
; but generally the default stats are at 3
; so the smallest value will be bigger than the smallest value listed

; OLLIES STAT
Physics_Jump_Speed_Stat        = {(414.0,450.0) STATS_OLLIE switch = standard_switch}         ; (400.0,450.0) speed range for fully powered jumps
Physics_Jump_Speed_min_Stat    = {(350.0,350.0) STATS_OLLIE switch = standard_switch}       ;  (350.0,350.0) note no range on little jumps

; The Boneless versions of the above.
Physics_Boneless_Jump_Speed_Stat        = {(489.0,525.0) STATS_OLLIE switch = standard_switch}         ; (475.0,525.0) speed range for fully powered jumps
Physics_Boneless_Jump_Speed_min_Stat    = {(400.0,400.0) STATS_OLLIE switch = standard_switch}       ;  (400.0,400.0) note no range on little jumps

; AIR STAT (Air poly jumps)
Physics_Air_Jump_Speed_Stat        = {(275,275.0) STATS_AIR switch= standard_switch}     ; (275,275.0) 220 jumping onto an air polygon
Physics_Air_Jump_Speed_min_Stat    = {(100,100) STATS_AIR switch  = standard_switch}     ; note no range on little jumps

Physics_Boneless_Air_Jump_Speed_Stat        = {(264.0,325.0) STATS_AIR switch = standard_switch}     ;(240.0,325.0) jumping onto an air polygon
Physics_Boneless_Air_Jump_Speed_min_Stat    = {(200.0,200.0) STATS_AIR switch  = standard_switch}     ; jumping onto an air polygon



// test for spine physics
;Physics_Spine_Lean_stat  = { (3.0,3.0) STATS_SPIN switch = standard_switch}               ; lean speed in the air
Physics_Air_No_Lean_Time   = 0200       ; (ms) time we don't lean fornt back, to allow to tapping direction
Physics_Air_Ramp_Lean_Time = 0200 	    ; (ms) time over which we ramp to full speed

Spine_Max_Width             = 800       ; max width in inches of a spine

// speed at whcih we recover from missed vert
Physics_recover_rate_stat  = { (2.0,2.0) STATS_SPIN switch = standard_switch}               ; lean speed in the air


//Physics_Air_Lean_stat  = { (10.0,10.0) STATS_SPIN switch = standard_switch}               ; lean speed in the air
//Physics_Air_No_Lean_Time   = 0000       ; (ms) time we don't lean fornt back, to allow to tapping direction
//Physics_Air_Ramp_Lean_Time = 050 	    ; (ms) time over which we ramp to full speed



// Hang time directly affect gravity
// the numbers here are dividers, so 1.0 is no change to gravity, 2.0 is half gravity

// Physics_Air_hang_Stat  = { (1.0,1.0) STATS_HANGTIME switch = standard_switch}           ; Hang time in the air
// Physics_Vert_hang_Stat  = { (1.1,1.1) STATS_HANGTIME switch = standard_switch}           ; was 1.0 Hang time in the air for low stats in THPS4
Physics_Air_hang_Stat=1.0							; Hang time in the air
Physics_Vert_hang_Stat=1.1							; was 1.0 Hang time in the air for low stats in THPS4

Physics_Acid_Drop_Min_Air_Time = 0.25				; if the air time for an acid drop would be less than this, the acid drop is culled
Physics_Acid_Drop_Walking_On_Ground_Search_Distance = 100	; Distance forward acid drops are searched for when walking on the ground
Physics_Acid_Drop_Min_Land_Speed = 500				; if your speed is less than this after landing an acid drop, it is boosted to this

Physics_Wallplant_Min_Approach_Angle = 20			; minimum angle of approach which allows a wallplant
Physics_Disallow_Rewallplant_Duration = 1000		; milliseconds after a wallplant before another wallplant is allowed
Physics_Wallplant_Speed_Loss = 225					; amount of horizontal speed loss from a wallplant, unless...
Physics_Wallplant_Min_Exit_Speed = 200				; ...speed would fall below this value, inwhich case the horizontal speed is set to this
Physics_Wallplant_Vertical_Exit_Speed = 500			; vertical speed is set to this value after a wallplant
Physics_Wallplant_Disallow_Grind_Duration = 200     ; milliseconds after a wallplant during which you may not grind
Physics_Ignore_Ceilings_After_Wallplant_Duration = 200 ; milliseconds after a wallplant during which collisions with the skater's head are ignored
Physics_Min_Wallplant_Height = 24					; minimum height at which a wallplant is allowed
Physics_Wallplant_Distance_From_Wall = 27.6			; inches from wall that skater is placed directly after a wallplant
Physics_Wallplant_Duration = (0.16 * 1000)			; duration of a wallplant

Physics_Disallow_Rewallpush_Duration = 800			; milliseconds after a wallpush before another wallpush is allowed
Physics_Wallpush_Speed_Loss = 200					; amount of horizontal speed loss from a wallpush, unless...
Physics_Wallpush_Min_Exit_Speed = 100				; ...speed would fall below this value, inwhich case the horizontal speed is set to this
Physics_Wallpush_Vertical_Exit_Speed = 400			; vertical speed is set to this value after a wallpush

Physics_Point_Rail_Kick_Upward_Angle = 25			; angle above horizontal at which point rails kick skater

Physics_Time_Before_Free_Revert = 20				; time (seconds) it takes to earn free reverts within a combo

///*********************************************************************

Lip_side_hop_speed          = 10           // speed added when hopping back onto the ledge with L2/R2
Lip_side_jump_speed          = 200           // speed added to make us jump left or right from a lip trick
Lip_along_jump_speed         = 100           // speed added to make us jump along rail from a lip trick

Lip_held_jump_out_time      = 300           // milliseconds direction (left) must be held to have an effect
Lip_held_jump_along_time      = 300           // milliseconds direction must (up/down) be held to have an effect

skater_upright_sideways_speed   = -60.0           // degrees per second to drift upright at

physics_break_air_speed_scale = 0.75          // (was 0.5p) govens how much of the speed is translated into forward velocity
physics_break_air_up_scale = 0.75             // (was 1.0) govens how much of the speed is used for up component

Skater_Break_Vert_forward_tilt = 45             ; degrees skater tilts forwards when breaking vert

Skater_Vert_Allow_break_Time = 200       // milliseconds we can break vert after going into it...
Skater_vert_push_time = 130              // milliseconds we mush push "up" to break vert
Skater_vert_active_up_time  = 250        // milliseconds within which we released UP to consider it active


Rail_Speed_Boost        = 150                   ; speed boost when land on rail
Point_Rail_Speed_Boost  = 100



Skater_Drift_Upright_Speed = 0.3                ; not currently used

Physics_Vert_Push_Out = 3                       ; inches we move away from very face when jumping up
; This stops you hitting the top of a QP
; when you come back down




Physics_Heavy_Air_Friction		= 0.000100             ; this is a ratio, multiplied by velocity squared


Skater_Flip_Speed = 1.0             ; speed at which skater flips direction, if going backwards, in ips
; needs to be a noticable value, otherwise he will turn around
; when the speed is close to 0, and this looks crap

; Control tweaks and times
Skater_Late_Jump_Slop       = 333       ; time in milliseconds that we are allowed to late jump

Skater_max_tense_time       = 200       ; time in ms to maximum jump tension reached

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Camera distances
;; Camera Focal Lenght,  note in Skate, the Horizontal FOV was 80 degrees
;; and based on MarkB's math, focal length = 0.0018/tan(fov/2), however this seems not to work at all....

Skater_Cam_Horiz_FOV = 72.0			; For a 4:3 display
Skater_Cam_Behind = 14
Skater_Cam_Above  = 4.0
Skater_Cam_Tilt = 0.18    ; 0.14              ; 0.17 is about 10 degrees

;Skater_Cam_Slerp =  0.05                    ; general speed at which the camera cataches up
Skater_Cam_Slerp =  0.08                    ; general speed at which the camera cataches up
Skater_Cam_Vert_Air_Slerp =  0.025           ; slower in vert air

Hang_Run_Timer_Speed_Adjustment = 0.4		; when hanging or climbing, run timer speed is adjusted by this amount

//GJ:  Skater_Origin_Offset has been deprecated
//Skater_Origin_Offset    = 0.0


; Dave's test stuff.

Skater_Camera_Undefined				= { horiz_fov = 0.000, behind = 0.0, above = 0.0, tilt = 0.0, slerp = 0.0, vert_air_slerp = 0.0, vert_air_landed_slerp = 0.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.0, grind_zoom = 0.0, origin_offset = 0.0, name = "undefined" }
Skater_Camera_Standard_Medium		= { horiz_fov = 72.00, behind = 12.0, above = 4.3, tilt = 0.18, slerp = 0.04, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
Skater_Camera_Standard_Far			= { horiz_fov = 72.00, behind = 14.0, above = 6.0, tilt = 0.3, slerp = 0.08, vert_air_slerp = 0.025, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.6, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "far" }
Skater_Camera_Standard_Near			= { horiz_fov = 72.00, behind = 7.0, above = 2.0, tilt = 0.18, slerp = 0.08, vert_air_slerp = 0.025, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.9, lip_trick_zoom = 1.6, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "near" }
Skater_Camera_Standard_Medium_LTG	= { horiz_fov = 72.00, behind = 14.0, above = 2.0, tilt = 0.15, slerp = 0.08, vert_air_slerp = 0.025, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.6, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard ltg" }

Skater_Camera_2P_Vert_Medium		= { horiz_fov = 72.00, behind = 14.0, above = 4.3, tilt = 0.18, slerp = 0.04, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
Skater_Camera_2P_Vert_Far			= { horiz_fov = 72.00, behind = 22.0, above = 6.0, tilt = 0.3, slerp = 0.08, vert_air_slerp = 0.025, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.6, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "far" }
Skater_Camera_2P_Vert_Near			= { horiz_fov = 72.00, behind = 6, above = 2.0, tilt = 0.18, slerp = 0.08, vert_air_slerp = 0.025, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.9, lip_trick_zoom = 1.6, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "near" }
Skater_Camera_2P_Vert_Medium_LTG	= { horiz_fov = 72.00, behind = 14.0, above = 3.0, tilt = 0.15, slerp = 0.08, vert_air_slerp = 0.025, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.6, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard ltg" }

Skater_Camera_2P_Horiz_Medium		= { horiz_fov = 72.00, behind = 15.0, above = 3.5, tilt = 0.2, slerp = 0.08, vert_air_slerp = 0.025, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.6, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "far" }
Skater_Camera_2P_Horiz_Far			= { horiz_fov = 72.00, behind = 25.0, above = 3.5, tilt = 0.3, slerp = 0.04, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
Skater_Camera_2P_Horiz_Medium_LTG	= { horiz_fov = 72.00, behind = 15.0, above = 3.0, tilt = 0.15, slerp = 0.08, vert_air_slerp = 0.025, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.6, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard ltg" }
Skater_Camera_2P_Horiz_Near			= { horiz_fov = 72.00, behind = 8.0, above = 3.2, tilt = 0.18, slerp = 0.08, vert_air_slerp = 0.025, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 1.0, lip_trick_zoom = 1.6, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "near" }

;Skater_Camera_Replay_Front			= { horiz_fov = 72.00, behind = 18.0, above = 4.0, tilt = 0.2, slerp = 0.08, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
;Skater_Camera_Replay_Front_Zoom     = { horiz_fov = 72.00, behind = 10.0, above = 4.0, tilt = 0.3, slerp = 0.08, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.5, lip_trick_zoom = -1.5, lip_trick_tilt = 0.6, lip_trick_above = 0.8, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
;Skater_Camera_Replay_Left			= { horiz_fov = 72.00, behind = 18.0, above = 4.0, tilt = 0.2, slerp = 0.08, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
;Skater_Camera_Replay_Left_Zoom		= { horiz_fov = 72.00, behind = 10.0, above = 4.0, tilt = 0.3, slerp = 0.08, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
;Skater_Camera_Replay_Behind			= { horiz_fov = 72.00, behind = 18.0, above = 4.0, tilt = 0.2, slerp = 0.08, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
;Skater_Camera_Replay_Behind_Zoom	= { horiz_fov = 72.00, behind = 10.0, above = 4.0, tilt = 0.3, slerp = 0.08, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
;Skater_Camera_Replay_Right			= { horiz_fov = 72.00, behind = 18.0, above = 4.0, tilt = 0.2, slerp = 0.08, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }
;Skater_Camera_Replay_Right_Zoom	    = { horiz_fov = 72.00, behind = 10.0, above = 4.0, tilt = 0.3, slerp = 0.08, vert_air_slerp = 0.04, vert_air_landed_slerp = 0.375, lerp_xz = 0.25, lerp_y = 0.75, vert_air_lerp_xz = 1.0, vert_air_lerp_y = 1.0, zoom_lerp = 0.0625, big_air_trick_zoom = 0.7, lip_trick_zoom = 1.0, lip_trick_tilt = -0.8, lip_trick_above = 0.4, grind_zoom = 1.0, origin_offset = .2, name = "standard" }

Skater_Camera_Array				= [	Skater_Camera_Undefined,
	Skater_Camera_Standard_Near,
	Skater_Camera_Standard_Medium,
	Skater_Camera_Standard_Far,
	Skater_Camera_Standard_Medium_LTG,
	;Skater_Camera_Replay_Front,
	;Skater_Camera_Replay_Front_Zoom,
	;Skater_Camera_Replay_Left,
	;Skater_Camera_Replay_Left_Zoom,
	;Skater_Camera_Replay_Behind,
	;Skater_Camera_Replay_Behind_Zoom,
	;Skater_Camera_Replay_Right,
	;Skater_Camera_Replay_Right_Zoom,
]
Skater_Camera_2P_Vert_Array		= [	Skater_Camera_Undefined,
	Skater_Camera_2P_Vert_Near,
	Skater_Camera_2P_Vert_Medium,
	Skater_Camera_2P_Vert_Far,
	Skater_Camera_2P_Vert_Medium_LTG,
]

Skater_Camera_2P_Horiz_Array	= [	Skater_Camera_Undefined,
	Skater_Camera_2P_Horiz_Near,
	Skater_Camera_2P_Horiz_Medium,
	Skater_Camera_2P_Horiz_Far,
	Skater_Camera_2P_Horiz_Medium_LTG,
]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Colision distances


Skater_side_collide_height  = 16     ; Height we use for checking side collisions
Skater_side_collide_length  = 15     ; dist we use for checking side collisions
Skater_air_extra_side_col = 12      ; extra length of collision check in air, primarily so we snap to walls for wallrides


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Other constants
Normal_Lerp_Speed			= 0.1       ; fraction (0.0 .. 1.0) that we move towards our ideal normal
Normal_Lerp_Velocity_Scale = 250.0      ; velocity at which Normal Lerp is unchanged, increase to recover faster at high speeds

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Rail stuff

Rail_Max_Snap = 40.0                ; max distance to rail that we can snap to
Climb_Max_Snap = 90.0               ; max distance to rail that we can snap to when grabbing in air
Drop_To_Climb_Max_Snap = 36.0       ; max distance to rail that we can snap to when dropping to hang

Rail_jump_rerail_time = 300      	; time before we can get on a rail
Rail_minimum_rerail_time = 500      ; time before we can get on a rail
Rail_walk_rerail_time = 1000		; time before we can get on a rail if we switched to walk mode since the last rail

Rail_Corner_Leave_Angle = 50        ; if angle is > this, then leave the rail at a corner

Rail_Jump_Angle = 15                ; angle we jump to left or right of the rail
; (Note, currently fixed, but wantto make it variable
; based on L/R duration and pressure

Rail_Tolerance = 0.7

Rail_Bad_Ledge_Side_Dist = 5        ; Dist either side of the rail used to do the drop-down collision checks.
Rail_Bad_Ledge_Drop_Down_Dist = 3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; bouncing off wall stuff

Wall_Bounce_Angle_Multiplier = 1.1 ; 1.3   ; to make us bounce away from walls, our that we need to
; turn to be parallel to the wall is multiplied by this
; this has the effect that for shallow angles we stay
; fairly parallel to the wall
; but as we get more perpendicular, we tend to
; turn a lot more away from the wall (27 degrees for 1.3, at 90)

Wall_Bounce_Dont_Slow_Angle = 30   ; 15  ; we don't get slowed (or flail) if angle is below this value
; when we impact a wall.

Wall_Bounce_Dont_Flail_Speed = 100  ; Don't flail if speed below this, allow us to turn smoother in narrow places



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Wall_Non_Skatable_Angle  =   25      ; Angle from vertical that is deemed non-skatable

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Wall ride stuff
Wall_Ride_Min_Speed = 75            ; Minumum speed along wall to allow wallride.  Just ignore if below this (inches per second))
Wall_Ride_Max_Incident_Angle = 60   ; Incident angle that velocity makes with wall, above which a wall-ride is not done.
Wall_Ride_Max_Tilt = 68.5           ; Maximum tilt that the skater is allowed to have for a wall-ride to be done.
Wall_Ride_Upside_Down_Angle = 53    ; Maximum angle to the vertical that a wall can have before it is considered upside down.
Wall_Ride_Triangle_Window =0.333   ; Time in seconds within which triangle must have been pressed to trigger a wall-ride.
Wall_Ride_Delay = 0.666             ; Player cannot trigger another wallride until this much time has passed since the last.
Wall_Ride_Down_Collision_Check_Length = -10

;;; not used   Wall_Ride_Friction = 0.00001
Wall_Ride_Turn_Speed = 0.004         ; Rate at which skater turns to head towards the ground.
Wall_Ride_Jump_Out_Speed=40
Wall_Ride_Jump_Up_Speed=80			; was 60 prior to rewriting of jump code


///////////////////////////////////////////////////////////////
//  Autoturn when braking on steep slopes
// This effect only fires in when the speed if low enough, and the slope is speep enough
// so generally this will have no effect on QPs when you are skating up and down
// them normally, and should not affect slopes you can skate on normally....

Skater_max_sloped_turn_speed = 300.0       ; max speed at we we do this autoturn
Skater_max_sloped_turn_cosine = 0.5        ; cosine of slope of plane, smaller is steeper
Skater_Slow_Turn_on_slopes = 3.0            ;  Speed we turn at, radians per second


// For all balance tricks, if the control buttons have been held for longer than this time (in milliseconds)
// after the start of the trick, then they will have an effect on the balance.
// (Before, they would not have any effect until they were let go first)
//BalanceIgnoreButtonPeriod=1000
BalanceIgnoreButtonPeriod=0

// during this time period, don't let them accelerate in a direction that would make them fall
BalanceSafeButtonPeriod=1000

// Manual wobble parameters.

ManualParams=
{
	// Whenever a balance is initiated, the current value of the cheese gets added to the skater's lean.
	// The cheese then gets set to the value specified by 'Cheese' below.
	// The cheese then drops to zero over CheeseFrames game-frames while the grind is maintained.
	// The cheese gets reset to zero if a clearpanel_landed or clearpanel_bailed is done.
	// (Or anything that resets the grind tricks)
	Cheese              = { (700,700)  STATS_MANUAL switch = standard_switch }     ; 100
	CheeseFrames        = { (100,100)  STATS_MANUAL switch = standard_switch }

	// Gravity.  Set it high and you get "sucked" to the left or right
	// if it's too hight, then you'll just whip uncontrolably over as soon
	// as you drift out of the center regrion
	// set it too low, and the balance will tend to "stick" in odd positions
	// letting you sometimes go for a long time without adjusting
	// with a reasonable gravity, this "sticking" is limited to the middle (which is good)
	// Mick's value = .02
	Lean_Gravity_Stat   = { (.02,.02)  diff = LEAN_GRAVITY_DIFF STATS_MANUAL switch = standard_switch } ;(28,61) STATS_MANUAL }   ; 28,61

	// The instability multiplier (I) is calulated like:
	//
	// I = Base + (Rate * Time)
	//
	// where "Time" is the grind time in seconds
	//
	// This instability multiplier is applied to the gravity, and to the general leaning
	// and the higher it is, the higher gravity and leaning speed will be (hence more unstable)
	// Mick's value = .09
	Instable_Rate       = { (.099, .07)  STATS_MANUAL switch = standard_switch diff = (0.5, 2.0) }   ; (.11, .07) Bigger = Get unstable quicker
	Instable_Base       = { (1, 1) STATS_MANUAL switch = standard_switch}   ; base value used in instability

	// If the lean speed drops below Lean_Min_Speed it will get set to a random value between
	// -Lean_Rnd_Speed/2 and +Lean_Rnd_Speed/2.
	// This keeps the balance meter from getting stuck moving very slow
	Lean_Min_Speed      = { (5,5)   STATS_MANUAL switch = standard_switch}    ; if below this lean speed, then nudge
	Lean_Rnd_Speed      = { (20,20)  STATS_MANUAL switch = standard_switch}    ;  and nudge by this amount

	// The following two are not really useful as things stand
	Repeat_Min          = { (1.0,1.0)   STATS_MANUAL switch = standard_switch }     ; Minimum Initial value of lean dir
	Repeat_Multiplier   = { (0.25, 0.25) STATS_MANUAL switch = standard_switch}  ; multiplied by this

	// Lean_Repeat_Multiplier is used to scale your current lean angle when you
	// do a new grind in a combo
	// Mick set it to 0.9, so when you land, you get a moment
	// of reprise, as it will upright you 10%
	Lean_Repeat_Multiplier = { (0.8,0.8) STATS_MANUAL switch = standard_switch}  ; when landing, multiply current lean by this

	// Lean_Acc is the acceleration applied when you press left or right
	Lean_Acc 		    = { (10,10) diff = LEAN_ACC_DIFF STATS_MANUAL switch = standard_switch}

	// Lean_bail_angle is the lean angle above which the skater bails.
	Lean_Bail_Angle     = { (4000,4000) STATS_MANUAL switch = standard_switch}
}


SkitchParams=
{
	// Whenever a balance is initiated, the current value of the cheese gets added to the skater's lean.
	// The cheese then gets set to the value specified by 'Cheese' below.
	// The cheese then drops to zero over CheeseFrames game-frames while the grind is maintained.
	// The cheese gets reset to zero if a clearpanel_landed or clearpanel_bailed is done.
	// (Or anything that resets the grind tricks)
	Cheese              = { (700,700)   }     ; 100
	CheeseFrames        = { (1,1)   }

	// Gravity.  Set it high and you get "sucked" to the left or right
	// if it's too hight, then you'll just whip uncontrolably over as soon
	// as you drift out of the center regrion
	// set it too low, and the balance will tend to "stick" in odd positions
	// letting you sometimes go for a long time without adjusting
	// with a reasonable gravity, this "sticking" is limited to the middle (which is good)
	// Mick's value = .02
	Lean_Gravity_Stat   = { (.01,.01)  } ;(28,61) STATS_MANUAL }   ; 28,61

	// The instability multiplier (I) is calulated like:
	//
	// I = Base + (Rate * Time)
	//
	// where "Time" is the grind time in seconds
	//
	// This instability multiplier is applied to the gravity, and to the general leaning
	// and the higher it is, the higher gravity and leaning speed will be (hence more unstable)
	// Mick's value = .09
	Instable_Rate       = { (.04, .04)   }   ; Bigger = Get unstable quicker
	Instable_Base       = { (.5, .5)  } ;value used in instability

	// If the lean speed drops below Lean_Min_Speed it will get set to a random value between
	// -Lean_Rnd_Speed/2 and +Lean_Rnd_Speed/2.
	// This keeps the balance meter from getting stuck moving very slow
	Lean_Min_Speed      = { (5,5)   }    ; if below this lean speed, then nudge
	Lean_Rnd_Speed      = { (10,10)  }    ;  and nudge by this amount

	// The following two are not really useful as things stand
	Repeat_Min          = { (1.0,1.0)    }     ; Minimum Initial value of lean dir
	Repeat_Multiplier   = { (0.25, 0.25) }  ; multiplied by this

	// Lean_Repeat_Multiplier is used to scale your current lean angle when you
	// do a new grind in a combo
	// Mick set it to 0.9, so when you land, you get a moment
	// of reprise, as it will upright you 10%
	Lean_Repeat_Multiplier = { (0.8,0.8) }  ; when landing, multiply current lean by this

	// Lean_Acc is the acceleration applied when you press left or right
	Lean_Acc 		    = { (8,8)  }

	// Lean_bail_angle is the lean angle above which the skater bails.
	Lean_Bail_Angle     = { (4000,4000) }
}


GrindParams=
{
	// Whenever a balance is initiated, the current value of the cheese gets added to the skater's lean.
	// The cheese then gets set to the value specified by 'Cheese' below.
	// The cheese then drops to zero over CheeseFrames game-frames while the grind is maintained.
	// The cheese gets reset to zero if a clearpanel_landed or clearpanel_bailed is done.
	// (Or anything that resets the grind tricks)
	Cheese              = { (2500,2500)  STATS_RAILBALANCE switch = standard_switch}     ; 100
	CheeseFrames        = { (30,30)  STATS_RAILBALANCE switch = standard_switch}

	// Gravity.  Set it high and you get "sucked" to the left or right
	// if it's too hight, then you'll just whip uncontrolably over as soon
	// as you drift out of the center regrion
	// set it too low, and the balance will tend to "stick" in odd positions
	// letting you sometimes go for a long time without adjusting
	// with a reasonable gravity, this "sticking" is limited to the middle (which is good)
	// Mick's value = .02
	Lean_Gravity_Stat   = { (.02,.02)  diff = LEAN_GRAVITY_DIFF STATS_RAILBALANCE switch = standard_switch} ;(28,61) STATS_RAILBALANCE }   ; 28,61

	// The instability multiplier (I) is calulated like:
	//
	// I = Base + (Rate * Time)
	//
	// where "Time" is the grind time in seconds
	//
	// This instability multiplier is applied to the gravity, and to the general leaning
	// and the higher it is, the higher gravity and leaning speed will be (hence more unstable)
	// Mick's value = .09
	Instable_Rate       = { (.104, .09)  STATS_RAILBALANCE switch = standard_switch}   ; (.11, .09) Bigger = Get unstable quicker
	Instable_Base       = { (1, 1) STATS_RAILBALANCE switch = standard_switch}   ; base value used in instability

	// If the lean speed drops below Lean_Min_Speed it will get set to a random value between
	// 0 and +Lean_Rnd_Speed.
	// This keeps the balance meter from getting stuck moving very slow
	// SP: we dropped the Rnd_Speed down lower so that you get a little respite at the start fo your grind where
	// this stat doesn't start to throw you off so quickly
	Lean_Min_Speed      = { (5,5)   STATS_RAILBALANCE switch = standard_switch}    ; if below this lean speed, then nudge
	Lean_Rnd_Speed      = { (7.07,6)  limit = 6 STATS_RAILBALANCE switch = standard_switch}    ; (7.5,6) and nudge by this amount

	// multipler for lean speed when you start a grind
	// Setting the Multiplier low will cause, on a regrind, your speed to drop dramatically, giving you a chance to
	// maintain balance
	Repeat_Min          = { (1.0,1.0)   STATS_RAILBALANCE switch = standard_switch}     ; Minimum Initial value of lean dir
	Repeat_Multiplier   = { (0.31, 0.1) STATS_RAILBALANCE switch = standard_switch}  ; (0.4, 0.1) multiplied by this

	// Lean_Repeat_Multiplier is used to scale your current lean angle when you
	// do a new grind in a combo
	// Mick set it to 0.9, so when you land, you get a moment
	// of reprise, as it will upright you 10%
	Lean_Repeat_Multiplier = { (0.607,0.5) STATS_RAILBALANCE switch = standard_switch}  ; (0.65,0.5) when landing, multiply current lean by this

	// Lean_Acc is the acceleration applied when you press left or right
	Lean_Acc 		    = { (10,10)  diff = LEAN_ACC_DIFF STATS_RAILBALANCE switch = standard_switch}

	// Lean_bail_angle is the lean angle above which the skater bails.
	Lean_Bail_Angle     = { (4000,4000) STATS_RAILBALANCE switch = standard_switch}

	// This gets added to the grind time (hence increasing the instability) whenever the skater
	// jumps and lands back on the same rail in the same combo.
	// Note, this is time in seconds
	Same_Grind_Add_Time       = { (2,2)    STATS_RAILBALANCE switch = standard_switch}

	// This gets subtracted from the grind time (hence decreasing the instability) whenever the skater
	// jumps and lands on a different rail to the one he was on before. (in the same combo)
	//    New_Grind_Sub_Time       = { (4,4)    STATS_RAILBALANCE }
	// This value is acually negative or else you can endlessly go around Rio
	New_Grind_Sub_Time       = { (-.286,0)    STATS_RAILBALANCE switch = standard_switch}	// (-.4,0)
}

LipParams=
{
	// Whenever a balance is initiated, the current value of the cheese gets added to the skater's lean.
	// The cheese then gets set to the value specified by 'Cheese' below.
	// The cheese then drops to zero over CheeseFrames game-frames while the grind is maintained.
	// The cheese gets reset to zero if a clearpanel_landed or clearpanel_bailed is done.
	// (Or anything that resets the grind tricks)
	Cheese              = { (3000,1000)  STATS_LIPBALANCE switch = standard_switch}     ; 100
	CheeseFrames        = { (180,180)  STATS_LIPBALANCE switch = standard_switch}

	// Gravity.  Set it high and you get "sucked" to the left or right
	// if it's too hight, then you'll just whip uncontrolably over as soon
	// as you drift out of the center regrion
	// set it too low, and the balance will tend to "stick" in odd positions
	// letting you sometimes go for a long time without adjusting
	// with a reasonable gravity, this "sticking" is limited to the middle (which is good)
	// Mick's value = .02
	Lean_Gravity_Stat   = { (.02,.02)  diff = LEAN_GRAVITY_DIFF STATS_LIPBALANCE switch = standard_switch} ;(28,61) STATS_MANUAL }   ; 28,61

	// The instability multiplier (I) is calulated like:
	//
	// I = Base + (Rate * Time)
	//
	// where "Time" is the grind time in seconds
	//
	// This instability multiplier is applied to the gravity, and to the general leaning
	// and the higher it is, the higher gravity and leaning speed will be (hence more unstable)
	// Mick's value = .09
	Instable_Rate       = { (0.5,0.2 )  STATS_LIPBALANCE switch = standard_switch}   ; (0.857,0.5 ) (1.0,0.5 ) Bigger = Get unstable quicker
	Instable_Base       = { (1, 1) STATS_LIPBALANCE switch = standard_switch}   ; base value used in instability

	// If the lean speed drops below Lean_Min_Speed it will get set to a random value between
	// -Lean_Rnd_Speed/2 and +Lean_Rnd_Speed/2.
	// This keeps the balance meter from getting stuck moving very slow
	Lean_Min_Speed      = { (10,10)   STATS_LIPBALANCE switch = standard_switch}    ; if below this lean speed, then nudge
	Lean_Rnd_Speed      = { (20,20)  STATS_LIPBALANCE switch = standard_switch}    ;  and nudge by this amount

	// The following two are not really useful as things stand
	Repeat_Min          = { (1.0,1.0)   STATS_LIPBALANCE switch = standard_switch}     ; Minimum Initial value of lean dir
	Repeat_Multiplier   = { (1.0, 1.0) STATS_LIPBALANCE switch = standard_switch}  ; multiplied by this

	// Lean_Repeat_Multiplier is used to scale your current lean angle when you
	// do a new grind in a combo
	// Mick set it to 0.9, so when you land, you get a moment
	// of reprise, as it will upright you 10%
	Lean_Repeat_Multiplier = { (1.0, 1.0) STATS_LIPBALANCE switch = standard_switch}  ; when landing, multiply current lean by this

	// Lean_Acc is the acceleration applied when you press left or right
	Lean_Acc 		    = { (10,10)  diff = LEAN_ACC_DIFF STATS_LIPBALANCE switch = standard_switch}

	// Lean_bail_angle is the lean angle above which the skater bails.
	Lean_Bail_Angle     = { (4000,4000) STATS_LIPBALANCE switch = standard_switch}
}

DefaultWobbleParams=
{
	WobbleAmpA  = { (0.05,0.05) STATS_MANUAL } ; was .04 amplitudes get added together to make the range
	WobbleAmpB  = { (0.04,0.04) STATS_MANUAL } ; was .03
	WobbleK1    = { (0.0022,0.0022) STATS_MANUAL }  ; frequency 1
	WobbleK2    = { (0.0017,0.0017) STATS_MANUAL }	 ; frequency 2 - the more different from K1, the more randomness
	SpazFactor  = { (1.0,1.0) STATS_MANUAL }	 ; amount the Amps are multiplied by at the ends of the meter
}

/////////////////////////////////////////////////////////////////////////////////
// Button bashing

BashPeriod=400 ; The period in milliseconds during which bashes are counted.
BashSpeedupFactor=0.2  ; .12 The bigger this is, the faster the anim will speed up
BashMaxPercentSpeedup=100  ;60

/////////////////////////////////////////////////////////////////////////////////
// Parameters for the SkateInAble command.
// The collision check uses a line DownOffset below the skater, and 2*HorizOffset wide.
SkateInAble_HorizOffset = 30
SkateInAble_DownOffset = 7

// Parameters used by the SkateInAble command when used with the flag 'Lip'
// In this case, the collision check will be 'down' relative to the skater, which will be
// horizontal relative to the world because of the skater's wacky orientation when doing
// a lip trick.
// The direction of the collision check will be towards the skater, so that it detects whether
// the other side of the spine the skater might be on is skateinable.
// The down offset is just in case the skater's position is such that the collision check
// goes over the top of the spine. The bigger this value, the further down the check will be offset.
SkateInAble_LipHorizOffset = 24
SkateInAble_LipDownOffset = 7
// If the first check fails, another check is done, straight down. This is for when the
// skater is doing a lip trick on a high up rail with vert beneath.
SkateInAble_LipExtraCheckHorizOffset = 13
SkateInAble_LipExtraCheckDownOffset = 2400 ; 200 feet


/////////////////////////////////////////////////////////////////////////////////
// Lip trick parameters. (These current values are from TH2)
LipAllowAngle=15                // Normal angle from vert we must be to do a lip trick

LipAllowAngle_Override=60       // bigger window on some short rails specifically flagged as LIP_OVERRIDE

LipPlayerHorizontalAngle=47 ; Player must be within this angle of horizontal
LipRampVertAngle=68.5       ; The ramp is considered vertical if its angle is greater than this.

/////////////////////////////////////////////////////////////////////////////
// Carplant parameters
CarPlant_Forward_boost      =  400
CarPlant_Upward_boost       =  100
min_car_height_diff         =  60       // min dist skater can be below the top of the car to carplant it
min_car_height_downwards    = 30        // same, but applied when skater is moving downwards

////////////////////////////////////////////////////////////////////////
// Things to do with the special meter

NewSpecial = 1              ; 1 if you want the special meter to count up whilst doing a trick

///////////////////////////////////////////////////////////////////////////
// for pushing away from leanined into walls

Skate_min_wall_lean_push_speed  = 1000           ; min speed we must be at to be pushed away from walls
Skate_wall_lean_push_time       = 0.4           ; time it takes us to lean up to full length
Skate_wall_lean_push_length     = 35            ; full length of lean
Skate_wall_lean_push_height     = 30            ; height at whcih we do the lean check
; was 60 (shoulder height); halved by SP to fix problem with leaning into fences and rails.
/////////////////////////////////////////////////////////////////////////////////////////
// Skitching

Skitch_Max_Distance             = 120         ; (inches) must be closer than this to the skitch point
Skitch_Offset                   = 27        ; was 40 (inches) dist away from the vehicle for the origin of the skater (will be the dist to his hand)
//Skitch_Height                   = 0        ; (inches) standard height off ground for skitch points
skitch_suck_speed               = 200       ; (IPS) speed at which skater gets sucked to skitch point
skitch_speed_match              = 1.0       ; proportion of the speed of car that we match, for when we let go
skitch_hold_time                = 200       ; milliseconds we must hold skitch button before it takes effect

///////////////////////////////////////////////////////////////////////////////
// Some alternate physics type things for cheats

// old vars to simulate a snowboard
//SnowBoard_Friction = 0.04                // simple friction as a fraction of sideways velocity
//Snowboard_turn_multiplier = 1.5         // amount we speed up leaning when snowboarding

SnowBoard_Friction = 0.30                // simple friction as a fraction of sideways velocity
Snowboard_turn_multiplier = 2.0         // amount we speed up leaning when snowboarding

cess_turn_min_speed     =   40
cess_turn_cap_speed     =   500
cess_turn_multiplier    =   1.5
cess_Friction           =   0.06                // simple friction as a fraction of sideways velocity

Skater_cess_Flip_Speed = 10000.0             ; speed at which skater flips direction, if going backwards, in ips



slomo_speed =  0.5                      // speed we go at in slomo mode

Matrix_speed =  0.15                      // speed we go at in matrix mode

Sim_speed = 1.25                    // for twitchy players

Moon_gravity    = 0.5               // gravity multiplier, allied to air gravity in moon mode

rubber_acc          = 0.001           // acelleration towards the home position
rubber_friction     = 0.04           // simple multiplicative friction
rubber_limit        = 1000          // limit to velocity




///////////////////////////////////////////////////////////////////////////////
// Skater-Skater Collision values

InternetClientCollCoefficient = 180.0
InternetServerCollCoefficient = 120.0
InternetClientCollRadius = 120.0
InternetServerCollRadius = 94.0

LanClientCollCoefficient = 100.0
LanServerCollCoefficient = 55.0
LanClientCollRadius = 70.0
LanServerCollRadius = 70.0

ClientCollCoefficient = 20.0
ServerCollCoefficient = 20.0
ClientCollRadius = 70.0
ServerCollRadius = 70.0

DrivingRadiusBoostFactor = 0.1
DrivingCoefficientBoostFactor = 0.1


////////////////////////////////////////////////////////////////////////////////////////////////
// Skater-Ped collision distances
ped_push_dist = 24              // peds get pushed away from skater is they are within this radius
ped_push_skater_speed = 400     // speed below which this push takes effect, ramped to max at 0

////////////////////////////
// CWalkComponent tweakable constants

walk_camera_parameters = {
	matrix_slerp_rate = 0.02			// rate at which the camera's orientation rotates to behind the skater
	lookaround_slerp_rate = 0.04		// rate at which the camera's orientation rotates to target point when looking around
	run_slerp_factor = 1.75				// factor matrix_slerp_rate is multiplied by when running
	min_slerp_speed = 130               // target speed below which there is no slerping
	full_slerp_speed = 450
	dpad_min_slerp_speed = 50			// target speed below which there is no slerping when dpad is used
	dpad_full_slerp_speed = 150
	flush_slerp_factor = 12				// factor matrix_slerp_rate is multiplied during a flush request
	lock_angle = 135					// angle between the skater and the camera orientation beyond which the camera no longer lerps
	facing_control = 1.7				// speed of the walk camera's facing control
	control_slerp_factor = 1.3
}

walk_parameters = {

	// speed parameters
	walk_speed = 150					// top walking speed
	run_speed = 450						// top running speed
	combo_run_speed = 575				// top running speed when in a combo
	run_adjust_rate = 1					// rate at which run speed approaches standard run speed after leaving a combo
	;max_stand_speed = 0   				// speed below which walker is considered standing
	decel_factor = 4.5					// rate of walker's exponential deceleration
	low_speed_decel_factor = 13.5		// rate of walker's exponential deceleration at very low speeds (prevents slide-y stops)
	run_accel_rate = 1500				// rate of walker's linear acceleration when running
	walk_accel_rate = 350				// rate of walker's linear acceleration when walking
	walk_point = 0.85					// control magnitude fraction at which point we begin ramping up to running speed
	;drop_to_hang_point = 1.0			// control magnitude fraction below which we will drop when walking off a ledge
	stop_skidding_speed = 50			// speed at which you stop skidding if you already were skidding
	pegged_duration_for_skid = 0.2		// duration over which one must have had the controlled pegged for the skater to skid instead of just going to a stand

	// rotate to upright parameters
	rotate_upright_duration = 0.3		// duration over which the skater rotates to upright after transitioning from walking
	initial_vert_vel_boost = 80			// forward velocity kick given when transitioning from vert air
	lerp_upright_rate = 6				// rate of post-initial upright lerping; not used during transition from skating

	// dpad control parameters
	;forced_run_delay = 75				// delay in milliseconds before a forced run begins
	dpad_control_damping_factor = 1.3	// damping amount applied to the dpad's control angle when running
	;start_run_dpad_delay = 1000			// milliseconds after pressing the dpad before walker starts ramping speed up to a run
	;full_run_dpad_delay = 1700			// milliseconds after pressing the dpad at which point walker reaches full run speed

	// jump parameters; current jump height = 102
	jump_velocity = 600					// upward velocity gained from a maximal jump
	min_jump_factor = 0.9				// factor of jump_velocity used for a minimal "tap" jump
	gravity = 1750						// strength of gravity during walking air
	hold_time_for_max_jump = 300		// milliseconds jump button must be held to obtain maximal jump
	hang_jump_factor = 0.85				// factor of jump_velocity used when jumping out of a hang or ladder
	jump_horiz_speed = 250				// at launch your horizontal velocity is projected to your control direction and then min clamped to this
	jump_obstruction_check_height = 102	// distance up that jump obstructions are checked for
	jump_obstruction_check_back = 24	// distance back that a clear jump is checked for if standard jump is obstructed
	jump_obstruction_extra_control_suppression_delay = 0	// extra duration of teh control supression
	sticky_land_threshold_speed = 200	// if, at land, the horizontal velocity is less than this and there is no control magnitude, speed is zeroed

	// rotate parameters; at very low speeds, walker rotates to requested direction before gaining speed
	rotate_in_place_rate = 1200			// rate at which walker rotates
	max_rotate_in_place_speed = 125		// walker rotates in place when its speed is below this value
	max_rotate_in_place_angle = 20		// walker rotates in place when the input direction deviates from the current direction by more than this angle
	walk_rotate_factor = 0.5			// factor of rotate_in_place_rate used when walking

	// turn parameters; at higher speeds, walker turns to requested direction while walking forward
	max_pop_speed = 100					// below this speed, walker's ability to turn increases dramatically
	worse_turn_factor = 10				// rate at which walker turns at higher speeds
	worse_worse_turn_factor = 1         // worse_turn_factor lerps down to this as the angle between the control and current direction drops
	dpad_worse_turn_factor = 5			// rate at which walker turns at higher speeds when dpad is used
	dpad_worse_worse_turn_factor = 1    // dpad_worse_turn_factor lerps down to this as the angle between the control and current direction drops
	best_turn_factor = 25				// as speed drops below max_pop_speed, walker's turn factor approaches this value

	// in-air velocity control parameters
	jump_adjust_speed = 200				// maximum adjustment speed achievable during a jump
	jump_accel_factor = 12				// rate at which maximum adjustment speed is achieved

	// curb/stair interaction parameters
	snap_up_height = 24					// height of curb which walker can snap up (must be higher than feeler_height)
	snap_down_height = 24				// height of curb which walker can snap down without going into air mode
	max_unnoticed_ground_snap = 4		// snaps with magnitude less than this distance do not cause SnapUpEdge or SnapDownEdge events

	// wall interaction parameters; stand angle: 52.0; push angle: 56.9
	feeler_length = 18					// closest distance walker is allowed to come to walls
	feeler_height = 23					// height above ground at which walls are looked for (must be less than snap_up_height)
	push_feeler_length = 15				// when within this distance of a wall, walker is pushed away from wall (must be larger than feeler_length)
	push_strength = 30					// strength with which walker is pushed away from walls when within push_feeler_length

	// curb float parameters
	curb_float_lerp_up_rate = 54		// lerp rate which curb float height approaches its appropriate values
	curb_float_lerp_down_rate = 18		// lerp rate which curb float height approaches zero
	curb_float_feeler_length = 24		// distance forward curbs are searched for
	min_curb_height_adjust_vel = 50		// speed above which curb float height is always updated

	// ceiling interaction parameters
	walker_height = 70					// height of walker's head

	// skid parameters; 180 turns at high speeds cause the walker to skid
	min_skid_speed = 175				// 180 turns above this speed will cause walker to go into skid mode
	skid_accel = 1400					// strength of walker's deceleration when in skid mode
	max_reverse_angle = 45				// angles within this angle of 180 are considered sharp enough to induce skidding

	// wall-forced turns; when walking into wall at a shallow angle, the walker will slowly rotate to face along the plane of the wall
	wall_turn_factor = 5				// controls the rate at which the walker rotates
	wall_turn_speed_threshold = 20		// at velocities below this, the walker will not be rotated by walking into walls
	max_wall_turn_speed_threshold = 400	// wall turning is smoothly turned on between wall_turn_speed_threshold and this speed

	// analog tolerance parameters
	forward_tolerance = 15				// directions within this angle of up on the analog stick are taken as exactly directly up

	// stand position determination parameters
	stand_pos_search_depth = 18			// distance down that a standing position is looked for

	// hang parameters
	hang_move_speed = 110	          	// speed of lateral movement
	hang_move_lerp_rate = 6				// rate at which hang speed lerps to the input speed
	hang_move_cutoff = 20				// hang move speeds below this count as stopped
	hang_vert_control_tolerance = 45	// maximum angle from directly up/down which is interpreted as a pull up / drop down command
	hang_control_debounce_time = 0.5	// duration after grabbing a hang from air that up/down is debounced
	hang_hop_max_rail_angle = 45		// maximum angle a hopped to hang rail may be from perpendicular to facing
	hang_max_rail_ascent = 30       	// maximum angle of ascent a grabbed rail may have
	ledge_top_feeler_up = 6         	// inches up from a rail that a ledge top is searched for
	ledge_top_feeler_down = 6			// inches down from a rail that a ledge top is searched for
	ledge_front_feeler_forward = 12		// inches forward from a rail that a ledge front is searched for
	ledge_front_feeler_back = 12		// inches back from a rail that a ledge front is searched for
	hang_obstruction_feeler_side = 6    // inches to the side from the hang point that obstructions to the hang are searched for
	hang_obstruction_feeler_up = 6      // inches up from the hang point that obstructions to the hang are searched for
	pull_up_obstruction_height = 12		// inches up from the hang piont that the pull up horizontal obstruction test is done
	rehang_delay = (0.3 * 1000)			// milliseconds after leaving the hang state before you can grab a rail from the air
	hang_init_anim_feeler_height = 36	// height above the origin at which a wall is checked for to determine which initial hang animation to play
	hang_init_anim_feeler_length = 20	// length forward a wall is checked for to determine which initial hang animation to play
	hang_move_collision_up = 48			// length up from origin at which hang movement feelers start
	hang_move_collision_back = 8        // length back from origin at which hang movement feelers start
	hang_move_collision_side_length	= 18	// length to the side that hang movement feelers reach
	hang_move_collision_side_height	= 48	// height up and down that hang movement feelers reach
	hang_critical_point_vert_offset = 6	// vertical offset of critical point while hanging
	hang_critical_point_horiz_offset = -14	// horizontal offset of critical point while hanging
	drop_to_hang_speed_factor = 0.8		// speed below which the skater drops to a hang instead of walking off an edge

	// hop to hang parameters
	;lowest_hang_height = 92				// lowest rail autohopped to; shouldn't be larger than standard jump height; must be larger than hang_vert_origin_offset
	;max_hop_to_hang_height = 173		// maximum rail height which will be autohopped to; should equal standard jump height plus hang_vert_origin_offset
	;max_hop_to_hang_forward_reach = 48
	;max_hop_to_hang_forward_reach = 140
	;max_hop_to_hang_backward_reach = 24
	;max_hop_to_hang_backward_reach = 48
	hop_obstruction_feeler_up = 24      // inches above the ground that the hop obstruction check is done
	;hop_target_vert_vel = 100       	// hop to hang's target downward velocity
	;hop_delay = (0.2 * 1000)	       	// milliseconds one must push against a wall to generate a hop to hang
	;max_hop_to_movable_hang_vel = 10000 // maximum velocity in inches per second a movable object may have for us to hop to hang from it

	// jump low barrier parameters
	barrier_jump_highest_barrier = 72	// highest barrier which will generate a barrier jump
	barrier_jump_delay = (0 * 1000)		// milliseconds one must push against a wall to generate a barrier jump
	barrier_jump_min_clearance = 3		// a barrier jump will always clear a barrier by at least this distance
	;barrier_jump_max_angle = 10			// angle from directly perpenticular below which a barrier jump can occur
	barrier_jump_max_angle = 30			// angle from directly perpenticular below which a barrier jump can occur

	// ladder climb parameters
	max_horiz_snap_distance = 24		// maximum horizontal distance walker will snap to a ladder
	button_horiz_snap_distance = 48		// maximum horizontal distance walker will snap to a ladder when the ladder button is pressed
	max_vert_snap_distance = 24			// maximum vertical distance walker will snap to a ladder
	max_onto_ladder_angle = 60			// maximum angle from the climb facing one can be to climb onto a ladder
	ladder_move_speed = 125				// speed of movement on a ladder
	ladder_control_tolerance = 45		// maximum angle from directly up/down which is interpreted as ladder move control
	ladder_climb_offset = 4

	// acid drop special transition parameters
	acid_drop_jump_velocity = 400       // upwards velocity of autojump used to enter acid drops detected when on ground

	// wall jump parameters
	vert_wall_jump_speed = 600			// upwards velocity gained from a maximumal wall jump
	;horiz_wall_jump_speed = 200			// horizontal velocity gained from a wall jump
	horiz_wall_jump_speed = 0			// horizontal velocity gained from a wall jump
	;min_air_before_wallplant = 150		// milliseconds one must be in the air before wall jumps are checked for

	// run animation parameters
	max_slow_walk_speed = 120			// speed at which SpeedScale switches from WALK_SLOW to WALK_FAST
	max_fast_walk_speed = 250			// speed at which SpeedScale switches from WALK_FAST to RUN_SLOW
	max_slow_run_speed = 500			// speed at which SpeedScale switches from RUN_SLOW to RUN_FAST
	min_anim_run_speed = 50				// the minimum effective speed at which animations will run due to the effects of walking into walls

	// hang animation parameters
	hang_vert_origin_offset = 91    	// inches below the hang point of the hang animations' origin; must be less than lowest_hang_height
	hang_horiz_origin_offset = 1.5
	pull_up_offset_forward = 10.835		// inches forward between the walker's position at the end of the pull up animation and the stand animation
	pull_up_offset_up = 91				// inches up between the walker's position at the end of the pull up animation and the stand animation
	drop_to_hang_rotate_factor = 0.5	// factor of full drop to hang wait animation in which rotation to hang facing occurs
	hang_anim_wait_speed = 1.6			// the speed of all hang transition animations

	// ladder climb animation parameters
	ladder_top_offset_forward = 6.00362
	ladder_top_offset_up = 59.5972
	ladder_bottom_offset_forward = 23.9874
	ladder_bottom_offset_up = 13.0387
	ladder_anim_wait_speed = 1.5		// the speed of all ladder transition animations

	// hang animation parameters
	hang_move_animation_speed = 46.2	// movement speed correct for the animation played at standard speed

	// display offset parameters
	display_offset_restore_rate = 10	// rate at which display offset is restored to zero after leaving a hang
	max_cas_scaling = 0.2				// max scaling factor beyond one allowed by CAS
}

// The following values are applied to rail balance whenever
// "robot" is detected.  Which currently just consists of landing on a rail
// the second (and subsequent) time within the same combo
// we nudge the skater a bit, and also add a bit of time to his "rail_time"
// which makes him more unstable when trying to balance on longer rails later
//
// the "nudge" may have the effect of quickly destabalizing the "shuffle" move,
// which is rapildy moving between two close parallel rails.

robot_rail_nudge    = 400.0				// abs amount to nudge the player when he lands on a robot line
robot_rail_add_time = 1.0				// amount to add to time when detecting robot lines
robot_kick_in_count	= 10 				// effect kicks in AFTER this many grinds on a single rail segment.
