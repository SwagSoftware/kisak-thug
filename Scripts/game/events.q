
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Event debug flags 

// if set, for each handled event a single-frame debug line is drawn connecting the source and the target
display_event_arrows=0

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Utility functions for registering/clearing event listeners and firing/broadcasting events

// Mick:  SetExceptionHandler and SetEventHandler now operate at the script level
// and SetEventHandler is now a CFunc, which takes the parameters directly, rather
// than via the SetProps command (which is more oriented towards objects)
// SetExceptionHandler is implemented via SetEventHandler, just passing in the "Exception" flag

// @script | SetExceptionHandler | register this script to listen for the given event and switch to the given script in response to the event
// @parm name | Ex | the name of the event listened for
// @parm script | Scr | the script to be run in response to the event
// @parmopt name | Group | the name of this event listeners group; used to identify which listeners to clear when clearing listener groups
// @parmopt structure | Params | this structure is added to the parameter list of the script
script SetExceptionHandler  Group=Default
	if GotParam Params
		SetEventHandler Ex=<Ex> Scr=<Scr> Group=<Group> params=<Params> Exception
	else
		SetEventHandler Ex=<Ex> Scr=<Scr> Group=<Group> Exception
	endif
endscript

                 
// @script | ClearExceptionGroup | clears all event listeners of a given group
// @uparm name | name of the event listener group to clear
script ClearExceptionGroup
	ClearEventHandlerGroup <...>
	ClearOnExceptionRun
endscript

// @script | BroadcastEvent | broadcasts an event to all registered listeners
// @parm name | Type | name of the event
// @parm structure | Data | this structure is added to the parameter list of scripts which are run in response to the event
script BroadcastEvent
	LaunchEvent <...> Broadcast
endscript

script SetException Group=Default
	SetExceptionHandler <...>
endscript

script ClearExceptions
	ClearEventHandlerGroup Default
	ClearOnExceptionRun
endscript

script ClearException
	ClearEventHandler <...>
	ClearOnExceptionRun
endscript

script ClearAllExceptionGroups
	ClearEventHandlerGroup all_groups 
	ClearOnExceptionRun
endscript

script ClearOnExceptionRun
	OnExceptionRun
endscript

script ClearOnExitRun
	OnExitRun
endscript

script  Obj_SetException
    SetException <...>
endscript

script Obj_ClearException
    ClearException <...>
endscript

script Obj_ClearExceptions
    ClearExceptions <...>
endscript

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Utilitiy scripts which manage the launching of events when the skater changes state.
//
// Any possible change in the skater's state is marked by a call to LaunchStateChangeEvent.  If this marks a true state change, an event if launched to
// signal the exiting of the previous state and another to signal the entering of the new state.  Also, the exit event of any substates which the skater
// is in are launched.

// upon entering the given state, launch the associated event
StateToEntryEventMapping={
	Skater_InAir=SkaterEnterAir
	Skater_InBail=SkaterEnterBail
	Skater_OnRail=SkaterEnterRail
	Skater_Skitching=SkaterEnterSkitch
	Skater_InManual=SkaterEnterManual
	Skater_InRevert=SkaterEnterRevert
	Skater_OnGround=SkaterEnterGround
	Skater_OnWall=SkaterEnterWall
	Skater_InWallplant=SkaterEnterWallplant
	Skater_InRevert=SkaterEnterRevert
	Skater_OnLip=SkaterEnterLip
	Skater_EndOfRun=SkaterEnterEndOfRun
	Skater_OnLadder=SkaterEnterLadder
	Skater_InHang=SkaterEnterHang
}

// upon exiting the given state, launch the associated event
StateToExitEventMapping={
	Skater_InAir=SkaterExitAir
	Skater_InBail=SkaterExitBail
	Skater_OnRail=SkaterExitRail
	Skater_Skitching=SkaterExitSkitch
	Skater_InManual=SkaterExitManual
	Skater_InRevert=SkaterExitRevert
	Skater_OnGround=SkaterExitGround
	Skater_OnWall=SkaterExitWall
	Skater_InWallplant=SkaterExitWallplant
	Skater_InRevert=SkaterExitRevert
	Skater_OnLip=SkaterExitLip
	Skater_EndOfRun=SkaterExitEndOfRun
	Skater_OnLadder=SkaterExitLadder
	Skater_InHang=SkaterExitHang
}

// upon entering the given substate, launch the associated event
SubStateToEntryEventMapping={
	Flip=SkaterEnterFlip
	Grab=SkaterEnterGrab
	Transfer=SkaterEnterTransfer
	AcidDrop=SkaterEnterAcidDrop
}

// upon exiting the given substate, launch the associated event
SubStateToExitEventMapping={
	Flip=SkaterExitFlip
	Grab=SkaterExitGrab
	Transfer=SkaterExitTransfer
	AcidDrop=SkaterExitAcidDrop
}

// upon setting to the given state, do not exit the associated list of substates
StateToSubStateExitEventMask={
	Skater_None=[  ]
	Skater_InAir=[ SkaterExitTransfer SkaterExitAcidDrop ]
	Skater_InBail=[   ]
	Skater_OnRail=[   ]
	Skater_Skitching=[   ]
	Skater_InManual=[   ]
	Skater_InRevert=[   ]
	Skater_OnGround=[   ]
	Skater_OnWall=[   ]
	Skater_InWallplant=[   ]
	Skater_InRevert=[   ]
	Skater_OnLip=[   ]
	Skater_EndOfRun=[   ]
	Skater_OnLadder=[   ]
	Skater_InHang=[   ]
}

// @script | LaunchStateChangeEvent |
// @parm name | State | object's new state
script LaunchStateChangeEvent
	// Printf "--*- LaunchStateChangeEvent"
	// PrintStruct <...>
	
	// grab the previous state
	NewState=<State>
	GetTags
	
	// launch any registered end substate events
	LaunchAllSubStateExitEvents NewState=<NewState>
	
	// if its the same as the new state, we're done
	if (<NewState> = <State>)
		return
	endif

	// fire the previous state's exit event
	if GotParam StateExitEvent
		LaunchEvent Broadcast Type=<StateExitEvent>
	endif
	
	// fire the new state's entry event
	LaunchEvent Broadcast Type=( StateToEntryEventMapping.<NewState> )
	
	// store the new exit event and state
	SetTags StateExitEvent=( StateToExitEventMapping.<NewState> ) State=<NewState>
endscript

// @script | LaunchSubStateEnterEvent | launch an event signaling the entering of a substate; if LaunchStateChangeEvent is called with a new core state,
// the substate's exit svent will be launched
// @parm name | SubState | identifier of the substate being entered
script LaunchSubStateEntryEvent
	// Printf "--*- LaunchSubStateEnterEvent"
	// PrintStruct <...>

	// fire the substate's entry event
	LaunchEvent Broadcast Type=( SubStateToEntryEventMapping.<SubState> )
	
	// store the substate's exit event; we will call this upon a core state change unless a call to LaunchSubStateEndEvent clears it
	GetTags
	NewExitEvent=( SubStateToExitEventMapping.<SubState> )
	SubStateExitEventList=( <SubStateExitEventList> + { <NewExitEvent> } )
	SetTags SubStateExitEventList=<SubStateExitEventList>
endscript

// @script | LaunchSubStateEndEvent | launch an event signaling the ending of a substate; this removes the event from the list of events launched
// by a core state change
// @parm name | EndEvent | event to launch signaling the end of this substate
script LaunchSubStateExitEvent
	// Printf "--*- LaunchSubStateExitEvent"
	// PrintStruct <...>

	// fire the substate's exit event
	LaunchEvent Broadcast Type=( SubStateToExitEventMapping.<SubState> )
	
	// remove the end event from the list of events launched by a core state change
	GetTags
	SubStateExitEventList=( <SubStateExitEventList> - ( SubStateToExitEventMapping.<SubState> ) )
	SetTags SubStateExitEventList=<SubStateExitEventList>
endscript

// only called by SkaterInit
script InitializeStateChangeEvent
	// Printf "--*- InitializeStateChangeEvent"
	// PrintStruct <...>

	GetTags
	if GotParam StateExitEvent
		LaunchAllSubStateExitEvents NewState=Skater_None
		LaunchEvent Broadcast Type=<StateExitEvent>
	endif
	SetProps Remove_Tags=[ StateExitEvent ]
	SetTags State=Skater_None SubStateExitEventList={   }
endscript

// not to be called externally
script LaunchAllSubStateExitEvents
	// Printf "--*- LaunchAllSubStateExitEvents"
	// PrintStruct <...>

	GetTags
	if not GotParam SubStateExitEventList
		return
	endif
	
	MaskedSubStateExitEventList=( <SubStateExitEventList> - ( StateToSubStateExitEventMask.<NewState> ) )
	LaunchEvent Broadcast Type=<MaskedSubStateExitEventList>
	
	SubStateExitEventList=( <SubStateExitEventList> - <MaskedSubStateExitEventList> )
    SetTags SubStateExitEventList=<SubStateExitEventList>
endscript

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Debug tools for skater's broadcasted events.
		 
script SkaterEventDebug
	KillSpawnedScript Name=TestEventListener
	SpawnScript TestEventListener
endscript
		 
script TestEventListener
	SetEventHandler Ex=SkaterEnterAir Scr=ReportEvent Params={ EventName=SkaterEnterAir }
	SetEventHandler Ex=SkaterExitAir Scr=ReportEvent Params={ EventName=SkaterExitAir }
	SetEventHandler Ex=SkaterEnterGround Scr=ReportEvent Params={ EventName=SkaterEnterGround }
	SetEventHandler Ex=SkaterExitGround Scr=ReportEvent Params={ EventName=SkaterExitGround }
	SetEventHandler Ex=SkaterEnterBail Scr=ReportEvent Params={ EventName=SkaterEnterBail }
	SetEventHandler Ex=SkaterExitBail Scr=ReportEvent Params={ EventName=SkaterExitBail }
	SetEventHandler Ex=SkaterEnterRail Scr=ReportEvent Params={ EventName=SkaterEnterRail }
	SetEventHandler Ex=SkaterExitRail Scr=ReportEvent Params={ EventName=SkaterExitRail }
	SetEventHandler Ex=SkaterEnterSkitch Scr=ReportEvent Params={ EventName=SkaterEnterSkitch }
	SetEventHandler Ex=SkaterExitSkitch Scr=ReportEvent Params={ EventName=SkaterExitSkitch }
	SetEventHandler Ex=SkaterEnterManual Scr=ReportEvent Params={ EventName=SkaterEnterManual }
	SetEventHandler Ex=SkaterExitManual Scr=ReportEvent Params={ EventName=SkaterExitManual }
	SetEventHandler Ex=SkaterEnterWall Scr=ReportEvent Params={ EventName=SkaterEnterWall }
	SetEventHandler Ex=SkaterExitWall Scr=ReportEvent Params={ EventName=SkaterExitWall }
	SetEventHandler Ex=SkaterEnterWallplant Scr=ReportEvent Params={ EventName=SkaterEnterWallplant }
	SetEventHandler Ex=SkaterExitWallplant Scr=ReportEvent Params={ EventName=SkaterExitWallplant }
	SetEventHandler Ex=SkaterEnterRevert Scr=ReportEvent Params={ EventName=SkaterEnterRevert }
	SetEventHandler Ex=SkaterExitRevert Scr=ReportEvent Params={ EventName=SkaterExitRevert }
	SetEventHandler Ex=SkaterEnterLip Scr=ReportEvent Params={ EventName=SkaterEnterLip }
	SetEventHandler Ex=SkaterExitLip Scr=ReportEvent Params={ EventName=SkaterExitLip }
	SetEventHandler Ex=SkaterEnterLadder Scr=ReportEvent Params={ EventName=SkaterEnterLadder }
	SetEventHandler Ex=SkaterExitLadder Scr=ReportEvent Params={ EventName=SkaterExitLadder }
	SetEventHandler Ex=SkaterEnterHang Scr=ReportEvent Params={ EventName=SkaterEnterHang }
	SetEventHandler Ex=SkaterExitHang Scr=ReportEvent Params={ EventName=SkaterExitHang }
	SetEventHandler Ex=SkaterEnterEndOfRun Scr=ReportEvent Params={ EventName=SkaterEnterEndOfRun }
	SetEventHandler Ex=SkaterExitEndOfRun Scr=ReportEvent Params={ EventName=SkaterExitEndOfRun }

	SetEventHandler Ex=SkaterEnterFlip Scr=ReportEvent Params={ EventName=SkaterEnterFlip }
	SetEventHandler Ex=SkaterExitFlip Scr=ReportEvent Params={ EventName=SkaterExitFlip }
	SetEventHandler Ex=SkaterEnterGrab Scr=ReportEvent Params={ EventName=SkaterEnterGrab }
	SetEventHandler Ex=SkaterExitGrab Scr=ReportEvent Params={ EventName=SkaterExitGrab }
	SetEventHandler Ex=SkaterEnterTransfer Scr=ReportEvent Params={ EventName=SkaterEnterTransfer }
	SetEventHandler Ex=SkaterExitTransfer Scr=ReportEvent Params={ EventName=SkaterExitTransfer }
	SetEventHandler Ex=SkaterEnterAcidDrop Scr=ReportEvent Params={ EventName=SkaterEnterAcidDrop }
	SetEventHandler Ex=SkaterExitAcidDrop Scr=ReportEvent Params={ EventName=SkaterExitAcidDrop }
	
	SetEventHandler Ex=SkaterLanded Scr=ReportEvent Params={ EventName=SkaterLanded }
	SetEventHandler Ex=SkaterBailed Scr=ReportEvent Params={ EventName=SkaterBailed }
	SetEventHandler Ex=SkaterTrickDisplayed Scr=ReportEvent Params={ EventName=SkaterTrickDisplayed }
	SetEventHandler Ex=SkaterSpinDisplayed Scr=ReportEvent Params={ EventName=SkaterSpinDisplayed }
	SetEventHandler Ex=SkaterEnterCombo Scr=ReportEvent Params={ EventName=SkaterEnterCombo }
	SetEventHandler Ex=SkaterExitCombo Scr=ReportEvent Params={ EventName=SkaterExitCombo }
	
	SetEventHandler Ex=SkaterJump Scr=ReportEvent Params={ EventName=SkaterJump }
	SetEventHandler Ex=SkaterOffEdge Scr=ReportEvent Params={ EventName=SkaterOffEdge }
	SetEventHandler Ex=SkaterWallplant Scr=ReportEvent Params={ EventName=SkaterWallplant }
	SetEventHandler Ex=SkaterWallpush Scr=ReportEvent Params={ EventName=SkaterWallpush }
	SetEventHandler Ex=SkaterPointRail Scr=ReportEvent Params={ EventName=SkaterPointRail }
	
	SetEventHandler Ex=SkaterEnterSkating Scr=ReportEvent Params={ EventName=SkaterEnterSkating }
	SetEventHandler Ex=SkaterExitSkating Scr=ReportEvent Params={ EventName=SkaterExitSkating }
	SetEventHandler Ex=SkaterEnterWalking Scr=ReportEvent Params={ EventName=SkaterEnterWalking }
	SetEventHandler Ex=SkaterExitWalking Scr=ReportEvent Params={ EventName=SkaterExitWalking }
	SetEventHandler Ex=SkaterEnterNollie Scr=ReportEvent Params={ EventName=SkaterEnterNollie }
	SetEventHandler Ex=SkaterExitNollie Scr=ReportEvent Params={ EventName=SkaterExitNollie }
	SetEventHandler Ex=SkaterEnterPressure Scr=ReportEvent Params={ EventName=SkaterEnterPressure }
	SetEventHandler Ex=SkaterExitPressure Scr=ReportEvent Params={ EventName=SkaterExitPressure }
	SetEventHandler Ex=SkaterEnterVertAir Scr=ReportEvent Params={ EventName=SkaterEnterVertAir }
	SetEventHandler Ex=SkaterExitVertAir Scr=ReportEvent Params={ EventName=SkaterExitVertAir }
	SetEventHandler Ex=SkaterEnterSpecial Scr=ReportEvent Params={ EventName=SkaterEnterSpecial }
	SetEventHandler Ex=SkaterExitSpecial Scr=ReportEvent Params={ EventName=SkaterExitSpecial }
	
	Block
endscript

script ReportEvent
	printf "=++ Event: %a" a=<EventName>
endscript

