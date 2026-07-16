// This gets called from Sk5Ed_Startup
script CreateRailEditor
CreateCompositeObject {
    Components=
    [
        {component = camera}
        {component = input controller=0}        
        {component = editorcamera min_height=20 min_radius=10 max_radius=1000 SimpleCollision /*AllowMovementThroughWalls*/}
        // Note: Best if the editorcamera component is created before the raileditor component,
        // otherwise the shadow will lag a frame.
        {component = raileditor}        
    ]
    // The rail editor is permanently in memory. Needs to be because when a park is created, it
    // is possible to quit the park and go into a level, then back to the park editor, and
    // the park being edited before will still be there. So the edited rails need to be there too.
    Params={Name=RailEditor permanent}
}
RailEditor:Hide
RailEditor:Suspend
endscript

script SwitchOnRailEditor
    RailEditor:SetEditingMode Mode=FreeRoaming
    
    Debounce X time=0.2 clear=1
    RailEditor:Unsuspend
    RailEditor:Unhide
    
    GetParkEditorCursorPos
    // Starts off with a height of 20 so that they don't accidentally place the first rail
    // point at ground level.
    RailEditor:EditorCam_Initialise position=<pos> cursor_height=20
    SetActiveCamera id=RailEditor
endscript

script SwitchOffRailEditor
    if RailEditor:GetEditedRailInfo CurrentRail
        if (<num_points> < 2)
            RailEditor:DeleteRail rail_id=<rail_id>
        endif
    endif
    
    RailEditor:Hide
    RailEditor:Suspend
    SetActiveCamera id=parked_cam
endscript



