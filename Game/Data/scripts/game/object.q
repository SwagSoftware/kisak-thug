// script functions for objects:

// start autoduck documentation
// @DOC object
// @module object | None
// @subindex Scripting Database
// @index script | object

DefaultMovingObjectSuspendDistance = 80         // distance in feet

X_AXIS = 1
Y_AXIS = 2
Z_AXIS = 4
// combinations of more than one axis:
XY_AXIS = 3
XZ_AXIS = 5
YZ_AXIS = 6

// bouncy object orientations (when the object comes to rest):
BOUNCEOBJ_REST_TOP_OR_BOTTOM = 1
BOUNCEOBJ_REST_ANY_SIDE = 2
BOUNCEOBJ_REST_TRAFFIC_CONE = 3

GameObjExceptions =
[
	SkaterLanded		// skater landed...
	SkaterBailed		// skater bailed...
	SkaterInRadius		// skater entered inner radius
	SkaterOutOfRadius	// skater exited outer radius
	AnySkaterInRadius	// Any skater (local & remote) inner radius
]

CarExceptions =
[
	SkaterInRadius		// skater entered inner radius
	SkaterOutOfRadius	// skater exited outer radius
]

BouncyObjExceptions =
[
	SkaterInRadius		// skater entered inner radius
	SkaterOutOfRadius	// skater exited outer radius
	Bounce				// somebody triggered us to bounce...
	DoneBouncing		// object has come to rest
]

script Obj_WaitPlayerDist interval = 3
	begin
		if Obj_ObjectInRadius radius = <radius> type = skater
			break
		else
			wait <interval> gameframes
		endif
	repeat
endscript

// @script | Obj_CycleAnim | Basically an Obj_PlayAnim and Obj_WaitForAnimFinished in one script.
// Also has the NumCycles param that allows you set how many times you want the anim to cycle.
// Can use any params Obj_PlayAnim can use.
// @parm name | anim | Name of anim as defined in allanims.qn (no quotes)
// @parmopt name | NumCycles | 1 | Number of times you want the animation to cycle.

script Obj_CycleAnim numCycles = 1
	begin
		Obj_PlayAnim <...>
		Obj_WaitAnimFinished
	repeat <numCycles>
endscript

// @script | GetGap | Way to start and end a gap immediately
// Takes all the same params as StartGap and EndGap combined.
// @parmopt name | Flags | |
// @parmopt name | Score | |
// @parmopt name | Text | |
// @parmopt name | GapScript | |
// @parmopt name | TrickText | |
// @parmopt name | TrickScript | |

script GetGap
	StartGap GapID = GetGap_DefaultID Flags = <Flags> TrickText = <TrickText> TrickScript = <TrickScript>
	EndGap GapID = GetGap_DefaultID Score = <Score> Text = <Text> GapScript = <GapScript>
endscript

script EmptyScript
endscript

// if you want to call a script after the ped has jumped out of the
// way, send in the parameter scriptToCallWhenFinished = NameOfScript
// Default is EmptyScript (which does nothing)
// script Ped_CheckForAvoidSkater scriptToCallWhenFinished = EmptyScript myAvoidSkater = DefaultAvoidSkater
// goto EmptyScript	//temporarily disable this functionality as I checked in new exception stuff
//which will break it.
// Obj_KillSpawnedScript name = Ped_CheckForAvoidSkater_NoStore
// Obj_KillSpawnedScript name = Ped_CheckForAvoidSkater // kill previously spawned vergins of this
// begin
// 	if Obj_ObjectInRadius type = skater radius = 20
// 		begin
// 			wait 3 gameframes
// 			if Obj_ObjectInRadius type = skater radius = 8
// 				Obj_SwitchScript DoAvoidSkaterStuff params = { scriptToCallWhenFinished = <scriptToCallWhenFinished> myAvoidSkater = <myAvoidSkater> }
// 				goto EmptyScript
// 			endif
// 			wait 2 gameframes
// 			if Obj_ObjectNotInRadius type = skater radius = 25
// 				break
// 			endif
// 		repeat
// 	endif
// 	wait 15 gameframes
// repeat
// endscript


//script Ped_CheckForAvoidSkater_NoStore scriptToCallWhenFinished = EmptyScript myAvoidSkater = DefaultAvoidSkater
//Obj_KillSpawnedScript name = Ped_CheckForAvoidSkater
//Obj_KillSpawnedScript name = Ped_CheckForAvoidSkater_NoStore // kill previously spawned vergins of this
//begin
//	if Obj_ObjectInRadius type = skater radius = 20
//	begin
//		wait 4 gamegrames
//		if Obj_ObjectInRadius type = skater radius = 8
//			Obj_SwitchScript DoAvoidSkaterStuff_NoStore params = { scriptToCallWhenFinished = <scriptToCallWhenFinished> myAvoidSkater = <myAvoidSkater> }
//			goto EmptyScript
//		endif
//	repeat
//	endif
//	wait 15 gameframes
//repeat
//endscript


//script DoAvoidSkaterStuff
//Obj_StorePos
//Obj_StoreNode
//DoAvoidSkaterStuff_NoStore scriptToCallWhenFinished = <scriptToCallWhenFinished> myAvoidSkater = <myAvoidSkater>
//endscript

script DefaultAvoidSkater
	AvoidSkater
endscript

/*
script DoAvoidSkaterStuff_NoStore
Obj_StopMovingAndRotating
<myAvoidSkater>
obj_spawnscript Ped_CheckForAvoidSkater_NoStore params = { scriptToCallWhenFinished = <scriptToCallWhenFinished> myAvoidSkater = <myAvoidSkater> }
Obj_LookAtPosStored time = 0.5
Obj_WaitRotate
Obj_MoveToPosStored speed = 2.5 //mph
//Obj_PlayAnim Anim=IdletoWalk
//Obj_WaitAnimFinished
Obj_PlayAnim Anim=Walk1 Cycle
Obj_WaitMove
Obj_PlayAnim Anim=Idle
obj_spawnscript Ped_CheckForAvoidSkater params = { scriptToCallWhenFinished = <scriptToCallWhenFinished> myAvoidSkater = <myAvoidSkater> }
goto <scriptToCallWhenFinished>
endscript
*/
