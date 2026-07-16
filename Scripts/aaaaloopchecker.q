// aaaaloopchecker.q

// Used by the infinite-loop detector.
// The name of this file is prefixed with aaaa because it needs to be loaded before any other
// q file. The q files get loaded on startup in alphabetical order.

// When the q files are loaded on startup, each script is checked to make sure it contains
// no infinite loops.
// However, some scripts may look bad to the detector even though we know they're OK,
// so those scripts can be listed here to tell the detector not to assert for them.
DoNotAssertForInfiniteLoopsInTheseScripts=
[
    Ped_Assert
    AVOIDSTATE_STOP
    Ped_RandomWaitAtNode01
]

// The presence of any of these commands within a begin-repeat loop
// indicates to the loop checker that the loop is not infinite.
BlockingFunctions=
[
    wait
    Obj_WaitAnimFinished
    Obj_WaitMove
    Obj_WaitRotate
    WaitAnimWalking
    WaitOneGameFrame
    WaitAnimFinished
    Obj_cycleAnim
    DoMorph
    GoalInit_PlayAnim
    fadein_fadeout
    WaitForEvent
	WaitWalkingFrame
	WaitAnimWalkingFrame
]

