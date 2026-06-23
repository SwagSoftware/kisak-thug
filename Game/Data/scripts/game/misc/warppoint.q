// warp to an adjacent level, or to a node within the current level

// start autoduck documentation
// @DOC warppoint
// @module warppoint | None
// @subindex Scripting Database
// @index script | warppoint

// @script | ChooseTeleportNode | This takes an array of nodes and creates an
// on-screen menu.  The skater is warped to the node selected in the menu
// @parm array | nodes | The array of nodes from which the user chooses
script ChooseTeleportNode
	PauseGame
	make_new_menu menu_title="Choose node" id=teleport_menu pad_choose_script=exit_start_menu

	// Define pad_back event
	SetScreenElementProps { id=main_menu event_handlers=[
			{pad_back       handle_start_pressed}
		]
		replace_handlers
	}

	AddWarpPointsToMenu nodes=<nodes>

	RunScriptOnScreenElement id=main_menu_anchor animate_in
endscript

script WarpSkater
	SpawnSkaterScript TeleportSkaterToNode params={<...>}
	UnPauseGame
	// Note: deboiuncing currently affects all skaters
	// should only affect the one that pressed the buttons....
	Debounce X time = 0.3       // debounce X, so we don't jump when exiting pause menu

	RunScriptOnScreenElement id=main_menu_anchor menu_offscreen
endscript


script WarpSkaterToNewLevel
	if ObjectExists id=main_menu_anchor
		RunScriptOnScreenElement id=main_menu_anchor menu_offscreen callback=WarpSkaterToNewLevel2 callback_params={<...>}
	else
		WarpSkaterToNewLevel2 <...>
	endif
endscript

script WarpSkaterToNewLevel2

	PauseGame
	make_new_menu menu_title="Warp to new level" id=warp_menu_anchor

	SetScreenElementProps { id=main_menu_anchor
		event_handlers=[
			{pad_back           exit_pause_menu}
		]
	}

	make_text_sub_menu_item text="Cancel" pad_choose_script=exit_pause_menu
	make_text_sub_menu_item text = <text> pad_choose_script=level_select_change_level pad_choose_params={level = <level>}

	RunScriptOnScreenElement id=main_menu_anchor animate_in
endscript
