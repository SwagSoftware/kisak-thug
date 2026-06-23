; MULTIPLAYER MODES

; SetGameParameters
;	REQUIRED: initial_players (int) = max number of players for this game mode
;	OPTIONAL: configure_time_limit (flag) = time limit is configurable from options screen
;	OPTIONAL: configure_victory_conditions (flag) = victory conditions are configurable from options screen
;	OPTIONAL: time_or_goals (flag) = game ends if all terminal conditions have been met, or time is up

; SetScoringParameters
;	OPTIONAL: no_accumulate (flag) = score resets after each trick
;	OPTIONAL: no_degrade (flag) = score doesn't degrade in value

; SetVictoryConditions
;	OPTIONAL: none (flag) = time limit only
;	OPTIONAL: terminals (flag) =
;	OPTIONAL: target_score (int) = first person to X score wins (TERMINAL CONDITION)
;	OPTIONAL: best_combo (int) = how many combos to track

; TODO: maybe factor in a handicap?
; TODO: maybe factor in multiple end conditions
; TODO: num_goals (int) = zero means all have to be met, otherwise, it's the number of goals that need to be met
; TODO: sanity check that certain options don't conflict with each other
; this sanity check should be run in debug mode right before the game starts
; TODO: victory_count (int) = game ends when X terminal conditions are completed, or time is up
;		full_victory
;		steal_victory
;		victory_count = 1		; number of terminal conditions that need to be met, -1 for all of them

mode_info = [
	{	name = "Free Skate"
		checksum = freeskate
		definition = "mode_freeskate"
	}
	{	name = "2 Player Free Skate"
		checksum = freeskate2p
		definition = "mode_freeskate2p"
	}
	{	name = "Single Session"
		checksum = singlesession
		definition = "mode_singlesession"
	}
	{	name = "Trick Attack"
		checksum = trickattack
		definition = "mode_trickattack"
	}
	{	name = "Score Challenge"
		checksum = scorechallenge
		definition = "mode_scorechallenge"
	}
	{	name = "Combo Mambo"
		checksum = combomambo
		definition = "mode_combomambo"
	}
	{	name = "Graffiti"
		checksum = graffiti
		definition = "mode_graffiti"
	}
	{	name = "Slap!"
		checksum = slap
		definition = "mode_slap"
	}
	{	name = "King of the Hill"
		checksum = king
		definition = "mode_king"
	}
	{	name = "Horse"
		checksum = horse
		definition = "mode_horse"
	}
	{
		name = "Horse"
		checksum = nethorse
		definition = "mode_nethorse"
	}
	{	name = "Hamburger"
		checksum = hamburger
		definition = "mode_hamburger"
	}
	{	name = "Strip Skate"
		checksum = stripskate
		definition = "mode_stripskate"
	}
	{	name = "Career"
		checksum = career
		definition = "mode_career"
	}
	{
		name = "Net"
		checksum = net
		definition = "mode_net"
	}
	{	name = "Contest"
		checksum = contest
		definition = "mode_contest"
	}
	{	name = "Lobby"
		checksum = netlobby
		definition = "mode_netlobby"
	}
	{	name = "Trick Attack"
		checksum = nettrickattack
		definition = "mode_nettrickattack"
	}
	{	name = "Score Challenge"
		checksum = netscorechallenge
		definition = "mode_netscorechallenge"
	}
	{	name = "Combo Mambo"
		checksum = netcombomambo
		definition = "mode_netcombomambo"
	}
	{	name = "Graffiti"
		checksum = netgraffiti
		definition = "mode_netgraffiti"
	}
	{
		name = "Goal Attack"
		checksum = netgoalattack
		definition = "mode_netgoalattack"
	}
	{	name = "Slap!"
		checksum = netslap
		definition = "mode_netslap"
	}
	{	name = "King of the Hill"
		checksum = netking
		definition = "mode_netking"
	}
	{	name = "Capture the Flag"
		checksum = netctf
		definition = "mode_netctf"
	}
	{	name = "Skate Shop"
		checksum = skateshop
		definition = "mode_skateshop"
	}
	{	name = "Park Editor"
		checksum = parkeditor
		definition = "mode_parkeditor"
	}
	{	name = "Create Goals"
		checksum = creategoals
		definition = "mode_creategoals"
	}
	{	name = "FireFight"
		checksum = firefight
		definition = "mode_firefight"
	}
	{	name = "FireFight"
		checksum = netfirefight
		definition = "mode_netfirefight"
	}
]

mode_freeskate = {
	name=freeskate
	initial_players = 1
	max_players = 2
	time_limit_type = fixed
	default_time_limit = 0
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 0
	track_trick_score = 1
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	should_run_intro_camera = 1
	should_run_intro_camera_noncd = 1
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	is_score_challenge = 0;
	show_leader_messages = 0
	timer_beeps = 0
	num_teams = 0
	is_net = 0
	is_freeskate = 1
	is_creategoals = 0
}

mode_freeskate2p = {
	name=freeskate
	initial_players = 2
	max_players = 2
	time_limit_type = fixed
	default_time_limit = 0
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 0
	track_trick_score = 1
	degrade_score = 0
	is_lobby = 1
	is_frontend = 0
	screenmode = splitscreen
	should_run_intro_camera = 1
	should_run_intro_camera_noncd = 1
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 0
	num_teams = 0
	is_net = 0
	is_freeskate = 1
	is_creategoals = 0
}

mode_singlesession = {
	name=singlesession
	initial_players = 1
	max_players = 1
	time_limit_type = fixed
	default_time_limit = 120
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 1
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 0
}

mode_career = {
	name=career
	initial_players = 1
	max_players = 1
	time_limit_type = fixed
	default_time_limit = 120
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	should_run_intro_camera = 1
	should_run_intro_camera_noncd = 1
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 1
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 0
}

mode_creategoals = {
	name=creategoals
	initial_players = 1
	max_players = 1
	time_limit_type = fixed
	default_time_limit = 120
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	should_run_intro_camera = 1
	should_run_intro_camera_noncd = 1
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 1
}

mode_net = {
	name=net
	initial_players = 1
	max_players = 1
	time_limit_type = fixed
	default_time_limit = 120
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	should_run_intro_camera = 1
	should_run_intro_camera_noncd = 1
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

mode_trickattack = {
	name=trickattack
	initial_players = 2
	max_players = 2
	time_limit_type = config
	default_time_limit = 120
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = splitscreen
	victory_conditions = [
		{ type = highest_score }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 1
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 0
}

mode_nettrickattack = {
	name=nettrickattack
	initial_players = 1
	max_players = 8
	time_limit_type = config
	; the skater doesn't reset correctly.
	default_time_limit = 90
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	victory_conditions = [
		{ type = highest_score }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 1
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 1
	timer_beeps = 1
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

mode_scorechallenge = {
	name=scorechallenge
	initial_players = 2
	max_players = 2
	time_limit_type = config
	default_time_limit = 0
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = splitscreen
	victory_conditions = [
		{ type = target_score score=10000 }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 1
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 1
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 0
}

mode_netscorechallenge = {
	name=netscorechallenge
	initial_players = 1
	max_players = 8
	time_limit_type = config
	; the skater doesn't reset correctly.
	default_time_limit = 0
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	victory_conditions = [
		{ type = target_score score=10000 }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 1
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 1
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 1
	timer_beeps = 1
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

mode_combomambo = {
	name=combomambo
	initial_players = 2
	max_players = 2
	time_limit_type = config
	default_time_limit = 120
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 0
	track_best_combo = 1
	track_trick_score = 1
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = splitscreen
	victory_conditions = [
		{ type = highest_score }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 1
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 1
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 0
}

mode_netcombomambo = {
	name=netcombomambo
	initial_players = 1
	max_players = 8
	time_limit_type = config
	; the skater doesn't reset correctly.
	default_time_limit = 90
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 0
	track_best_combo = 1
	track_trick_score = 1
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	victory_conditions = [
		{ type = highest_score }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 1
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 1
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 1
	timer_beeps = 1
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

mode_graffiti = {
	name=graffiti
	initial_players = 2
	max_players = 2
	time_limit_type = config
	default_time_limit = 120
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = splitscreen
	victory_conditions = [
		{ type = highest_score }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 1
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 0
}

mode_netgraffiti = {
	name=netgraffiti
	initial_players = 1
	max_players = 8
	time_limit_type = config
	; the skater doesn't reset correctly.
	default_time_limit = 90
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	victory_conditions = [
		{ type = highest_score }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 1
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 1
	timer_beeps = 1
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

mode_netgoalattack = {
	name=netgoalattack
	initial_players = 1
	max_players = 8
	time_limit_type = config
	; the skater doesn't reset correctly.
	default_time_limit = 0
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 0
	track_trick_score = 1
	degrade_score = 1
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	victory_conditions = [
		{ type = complete_goals}
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 1
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 0
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

mode_slap = {
	name=slap
	initial_players = 2
	max_players = 2
	time_limit_type = config
	default_time_limit = 120
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 0
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = splitscreen
	victory_conditions = [
		{ type = highest_score }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 0
}

mode_netslap = {
	name=netslap
	initial_players = 1
	max_players = 8
	time_limit_type = config
	; the skater doesn't reset correctly.
	default_time_limit = 90
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 0
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	victory_conditions = [
		{ type = highest_score }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 1
	timer_beeps = 1
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

mode_firefight = {
	name=firefight
	initial_players = 2
	max_players = 2
	time_limit_type = config
	default_time_limit = 0
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 0
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = splitscreen
	victory_conditions = [
		{ type = last_man_standing }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 1
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 0
}

mode_netfirefight = {
	name=netfirefight
	initial_players = 1
	max_players = 8
	time_limit_type = config
	; the skater doesn't reset correctly.
	default_time_limit = 0
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 0
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	victory_conditions = [
		{ type = last_man_standing }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 1
	show_leader_messages = 0
	timer_beeps = 1
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

mode_netking = {
	name=netking
	initial_players = 1
	max_players = 8
	time_limit_type = config
	; the skater doesn't reset correctly.
	default_time_limit = 0
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 0
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	victory_conditions = [
		{ type = target_score score=10000 }	; 10 seconds worth of ms//2 minutes-worth of ms
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 1
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 1
	timer_beeps = 0
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

mode_king = {
	name=king
	initial_players = 2
	max_players = 2
	time_limit_type = config
	default_time_limit = 0
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 0
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = splitscreen
	victory_conditions = [
		{ type = target_score score=120000 }	; 2 minutes-worth of ms
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 1
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 0
	num_teams = 0
	is_net = 0
	is_freeskate = 0
	is_creategoals = 0
}

mode_netctf = {
	name=netctf
	initial_players = 1
	max_players = 8
	time_limit_type = config
	; the skater doesn't reset correctly.
	default_time_limit = 120
	victory_condition_type = config
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 0
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	victory_conditions = [
		;{ type = target_score score=5 }
		;{ type = highest_score }
	]
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_ctf = 1
	is_firefight = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	show_leader_messages = 1
	timer_beeps = 0
	num_teams = 0
	is_net = 1
	is_freeskate = 0
	is_creategoals = 0
}

targetScoreArray = [
	{ type = target_score score=10000 }	; 10 sec-worth of ms
]

highestScoreArray = [
	{ type = highest_score }
]

mode_netlobby = {
	name=netlobby
	initial_players = 1
	max_players = 8
	time_limit_type = fixed
	default_time_limit = 0
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 0
	track_trick_score = 1
	degrade_score = 0
	is_lobby = 1
	is_frontend = 0
	screenmode = single
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 0
	num_teams = 0
	is_freeskate = 0
	is_net = 1
	is_creategoals = 0
}

mode_skateshop = {
	name=skateshop
	initial_players = 2
	max_players = 2
	time_limit_type = fixed
	default_time_limit = 0
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 0
	track_trick_score = 0
	degrade_score = 0
	is_lobby = 0
	is_frontend = 1
	screenmode = single
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 0
	num_teams = 0
	is_freeskate = 0
	is_net = 0
	is_creategoals = 0
}

mode_parkeditor = {
	name=parkeditor
	initial_players = 1
	max_players = 0
	time_limit_type = fixed
	default_time_limit = 0
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 0
	track_trick_score = 1
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = single
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 1
	should_modulate_color = 0
	is_horse = 0
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 0
	num_teams = 0
	is_freeskate = 0
	is_net = 0
	is_creategoals = 1
}

mode_horse = {
	name=horse
	initial_players = 2
	max_players = 2
	time_limit_type = config
	default_time_limit = 10
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = horse
	//	screenmode = splitscreen
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 0
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 1
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 0
	num_teams = 0
	is_freeskate = 0
	is_net = 0
	is_creategoals = 0
}

mode_nethorse = {
	name=nethorse
	initial_players = 1
	max_players = 8
	time_limit_type = config
	default_time_limit = 10
	victory_condition_type = fixed
	score_frozen = 0
	accumulate_score = 1
	track_trick_score = 1
	degrade_score = 0
	is_lobby = 0
	is_frontend = 0
	screenmode = horse
	//	screenmode = splitscreen
	should_run_intro_camera = 0
	should_run_intro_camera_noncd = 0
	show_ranking_screen = 1
	stop_at_zero = 0
	is_career = 0
	is_singlesession = 0
	is_parkeditor = 0
	should_modulate_color = 0
	is_horse = 1
	is_king = 0
	is_trick_attack = 0
	is_score_challenge = 0
	is_combo_mambo = 0
	is_goal_attack = 0
	is_ctf = 0
	is_firefight = 0
	show_leader_messages = 0
	timer_beeps = 0
	num_teams = 0
	is_freeskate = 0
	is_net = 1
	is_creategoals = 0
}

script force_close_rankings
	printf "************************* FORCE CLOSING RANKINGS ******************************"
	speech_box_exit
	SetScreenElementProps {
		id=root_window
		event_handlers=[
			{pad_start			handle_start_pressed}
		]
		replace_handlers
	}

	SetButtonEventMappings unblock_menu_input
	if ObjectExists id=rankings_list_anchor
		RunScriptOnScreenElement id=current_menu_anchor menu_offscreen
		if GameIsOver
			if Not GotParam dont_retry
				do_backend_retry
			endif
		endif
	endif
endscript

script close_rankings
	printf "************************* CLOSING RANKINGS ******************************"
	speech_box_exit
	restore_start_key_binding

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
		SetScreenElementProps id=root_window tags={ menu_state=off }
	endif
	wait 1 frame

	if GameModeEquals is_singlesession
		create_pause_menu no_exit
	else
		if not GameModeEquals is_lobby
			if InSplitScreenGame
				create_end_run_menu
			else
				do_backend_retry
			endif
		endif
	endif

endscript

script wait_then_force_close_rankings
	wait 5 seconds
	force_close_rankings
	do_backend_retry
endscript

script wait_then_create_rankings

	begin
		if CalculateFinalScores
			break
		endif
		wait 1 gameframe
	repeat
	if InInternetMode
		if OnServer
			if InInternetMode
				ReportStats final
			endif
		endif
	endif
	create_rankings <...>
endscript

script create_rankings score_title_text="SCORE"
	printf "create_rankings"
	GoalManager_DeactivateAllGoals force_all
	GoalManager_UninitializeAllGoals
	GoalManager_SetCanStartGoal 0
	if InNetGame
		if Not IsObserving
			Skater:add_skater_to_world
			ExitSurveyorMode
		endif
	endif

	if ObjectExists id=current_menu_anchor
		DestroyScreenElement id=current_menu_anchor
	endif

	if ObjectExists id=edit_tricks_sub_menu_anchor
		DestroyScreenElement id=edit_tricks_sub_menu_anchor
	endif

	if ObjectExists id=dialog_box_anchor
		close_rankings
		return
	endif
	if ObjectExists id=quit_dialog_anchor
		close_rankings
		return
	endif

	if ObjectExists id=grunge_anchor
		DestroyScreenElement id=grunge_anchor
	endif

	if ObjectExists id=box_icon
		DestroyScreenElement id=box_icon
	endif

	if ObjectExists id=box_icon_2
		DestroyScreenElement id=box_icon_2
	endif

	if ScreenElementExists id=top_bar_anchor
		DestroyScreenElement id=top_bar_anchor
	endif

	if ScreenElementExists id=submenu_title_anchor
		DestroyScreenElement id=submenu_title_anchor
	endif

	pause_trick_text
	exit_pause_menu

	if InSplitScreenGame
		PauseGame
		pause_trick_text
		pause_menu_gradient on
	endif

	printf "****************** CREATING RANKINGS!!!! ********************"
	if IsAutoServing
		SpawnScript wait_then_force_close_rankings
	endif

	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	FormatText ChecksumName=off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])

	SetScreenElementLock id=root_window off

	// anchor for the whole fucking thing
	CreateScreenElement {
		type=ContainerElement
		parent=root_window
		id=rankings_anchor

		pos=(320, 340)
		dims=(640, 480)
	}
	AssignAlias id=rankings_anchor alias=current_menu_anchor

	// anchor for player list
	CreateScreenElement {
		type=ContainerElement
		parent=rankings_anchor
		id=player_list_anchor

		pos=(320, 240)
		dims=(640, 480)
	}


	// icon
	CreateScreenElement {
		type=SpriteElement
		parent=rankings_anchor
		z_priority=10
		texture=PA_goals
		pos=(92, 100)
		just=[center center]
		rgba=[127 102 0 128]
	}

	// rankings vmenu
	CreateScreenElement {
		type=VMenu
		parent=player_list_anchor
		id=player_list_menu

		font=small
		just=[left top]
		pos=(105, 100)
		internal_just=[left top]
		; regular_space_amount=21
	}

	// anchor for player vmenu title
	CreateScreenElement {
		type=ContainerElement
		parent=player_list_menu

		dims=(256, 21)
		not_focusable
	}
	CreateScreenElement {
		type=TextElement
		parent=<id>

		font=testtitle
		text="RANKINGS"
		pos=(100, 0)
		just=[center top]
		scale=1.3
		rgba=<off_rgba>
	}

	// bg for titles
	CreateScreenElement {
		type=SpriteElement
		parent=player_list_anchor

		texture=black
		pos=(94, 99)
		rgba=[0 0 0 90]
		scale=(116.08, 6.1)
		just=[left top]
		z_priority=-1
	}

	CreateScreenElement {
		type=SpriteElement
		parent=player_list_anchor

		texture=black
		pos=(94, 118)
		rgba=<on_rgba>
		scale=(116.08, .7)
		just=[left top]
		z_priority=20
	}

	CreateScreenElement {
		type=SpriteElement
		parent=player_list_anchor

		texture=black
		pos=(111, 98)
		rgba=<on_rgba>
		scale=(112.08, .6)
		just=[left top]
		z_priority=0
	}

	// container for rankings list
	CreateScreenElement {
		type=ContainerElement
		parent=rankings_anchor
		id=rankings_list_anchor

		dims=(640, 480)
		pos=(320, 240)
	}

	// rankings list vmenu
	CreateScreenElement {
		type=VMenu
		parent=rankings_list_anchor
		id=rankings_list_menu

		just=[left top]
		pos=(375, 100)
		internal_just=[left top]
		; regular_space_amount=21
	}

	// container for rankings menu title
	CreateScreenElement {
		type=ContainerElement
		parent=rankings_list_menu

		dims=(205, 21)
		not_focusable
	}
	// rankings menu title text
	CreateScreenElement {
		type=TextElement
		parent=<id>

		font=dialog
		text=<score_title_text>
		pos=(85, 0)
		just=[center top]
		rgba=<on_rgba>
		not_focusable
	}

	// steal the start key
	kill_start_key_binding

	FillRankingScreen

	// done button
	// anchor for done button (necessary?)
	CreateScreenElement {
		type=ContainerElement
		parent=rankings_anchor
		id=rankings_done_anchor

		dims=(640, 480)
		pos=(320, 240)
	}

	SetScreenElementLock id=player_list_menu on // forces it to update
	GetStackedScreenElementPos Y id=player_list_menu offset=(210, 20)
	SetScreenElementLock id=player_list_menu off  // just in case

	//center the rankins display vertically based on the number of entries
	DoScreenElementMorph id=rankings_anchor time=0 pos=((320,240) + (0,-.5)*((<pos>-(320,340)).(0,1)))

	SetScreenElementLock id=player_list_menu on // forces it to update
	GetStackedScreenElementPos Y id=player_list_menu offset=(210, 20)
	SetScreenElementLock id=player_list_menu off  // just in case
	create_speech_box text="Press \m0 to continue" pos=(320,400) pad_choose_script=close_rankings

	RunScriptOnScreenElement id=current_menu_anchor dialog_box_delay_input params={ delay_input_time=2000 }
	RunScriptOnScreenElement id=current_menu_anchor menu_onscreen

endscript

script player_menu_add_item font=small
	printf "player_menu_add_item"
	FormatText ChecksumName=on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i=(THEME_COLOR_PREFIXES[current_theme_prefix])
	SetScreenElementLock id=<parent> off

	if GotParam team_score
		<text_just> = [right top]
		<text_pos> = (230, 0)
		<container_dims> = (256, 24)

		<end_cap_scale> = (1, 5)
	else
		<text_just> = [left top]
		<text_pos> = (0, 0)
		<container_dims> = (256, 21)

		<end_cap_scale> = (1, 5.25)
	endif


	// container for this element
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>

		dims=<container_dims>
		not_focusable
	}
	<container_id> = <id>

	//grey bg
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>
		texture=black
		pos=(-10,0)
		rgba=[0 0 0 60]
		scale=(116.08, 6.1)
		just=[left top]

	}

	//white underline
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>
		texture=white2
		pos=(-10,20)
		rgba=[128 128 128 128]
		z_priority=10
		;scale=(116.08, 1)
		scale=(57.5, .2)
		just=[left top]

	}

	//black v line1
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>
		texture=black
		pos=(-10,0)
		rgba=[0 0 0 128]
		scale=(1, 6)
		z_priority=11
		just=[left top]

	}

	//black v line2
	CreateScreenElement {
		type=SpriteElement
		parent=<container_id>
		texture=black
		pos=(450,0)
		rgba=[0 0 0 128]
		scale=(1,6)
		z_priority=11
		just=[left top]

	}

	// text
	CreateScreenElement {
		type=TextElement
		parent=<container_id>
		z_priority=10
		font=<font>
		text=<text>
		pos=<text_pos>
		just=<text_just>
		rgba=[128 128 128 128]
	}

	// if we got the team score param, we need to add a bar
	if GotParam team_score
		//white underline
		CreateScreenElement {
			type=SpriteElement
			parent=<container_id>
			texture=white2
			pos=(-10,20)
			rgba=<on_rgba>
			;scale=(116.08, 1)
			scale=(57.5, .2)
			just=[left top]
			z_priority=11

		}
	endif

	SetScreenElementLock id=<parent> on

endscript

script score_menu_add_item
	if GotParam team_score
		<container_dims> = (205, 24)
	else
		<container_dims> = (205, 21)
	endif

	// container for element
	CreateScreenElement {
		type=ContainerElement
		parent=<parent>

		dims=<container_dims>
		not_focusable
	}
	<container_id> = <id>

	// text
	// the rgba for this text is used when no
	// team color is specified
	CreateScreenElement {
		type=TextElement
		parent=<container_id>
		z_priority=10
		font=dialog
		text=<text>
		pos=(85, 0)
		rgba=[128 128 128 128]
		just=[center top]
	}

endscript

