// used to control minigames with a timer

minigame_timer_GenericParams={
	init = minigame_timer_init
	activate = minigame_timer_activate
	active = minigame_timer_active
	deactivate = minigame_timer_deactivate
	success = minigame_timer_success
	fail = minigame_timer_fail
	expire = minigame_timer_expire
	cash_limit = 500
	
	time=60
	
	minigame
}

script minigame_timer_init
endscript

script minigame_timer_activate
	minigame_activate goal_id=<goal_id>
endscript

script minigame_timer_active
endscript

script minigame_timer_deactivate
	minigame_deactivate goal_id=<goal_id>
endscript

script minigame_timer_success
endscript

script minigame_timer_fail
endscript

script minigame_timer_expire
	if GotParam expire_script
		SpawnScript <expire_script> <expire_script_params>
	endif
endscript

