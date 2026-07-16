// netmenu.q
netmenu_str_players = 'Players'	;// in netmenu, the translations for num_players_info must match this word
netmenu_str_no_observers = 'No Observers' ; //in netmenu, the translation for "No Observers" in num_observers_info must match this
netmenu_str_observer= 'Observer' ; //in netmenu, the translation for the word "Observer" (** note: SINGULAR) in num_observers_info must match this
netmenu_str_observers = 'Observers' ; //in netmenu, the translation for the word "Observers" (** note: PLURAL) in num_observers_info must match this

// netoptions.cpp
netoptions_str_game_in_progress = 'GAME IN PROGRESS'
netoptions_str_auto_serve = 'Auto-Server'
netoptions_str_fcfs = '1st Come 1st Serve'
netoptions_str_story_goals = 'Story'
netoptions_str_user_goals = 'User'
netoptions_str_yes = 'Yes'
netoptions_str_no = 'No'

// player.cpp
player_str_king_abbreviation = 'K'	// 'K' is the abbreviation for King. Any translation should follow this pattern

// casmenu.q
cas_str_editskater = 'Edit Skater'
cas_str_createskater = 'Create Skater'
cas_str_pointsavailable = 'Points Available:'

// dialogbox.q
db_str_yes = 'yes'
db_str_no = 'no'
db_str_ok = 'ok'
db_str_cancel = 'cancel'
db_str_retry = 'retry'

// horse.q
; horse_str_defaultword = 'HORSE'				; UNSEEN
; horse_str_unknown = 'unknown'					; UNSEEN
horse_str_setscoreis = 'Set score is'
; horse_str_youarea = 'You are a'				; UNSEEN
horse_str_getstheletter = 'gets the letter'
horse_str_noscoreset = 'No score set'
horse_str_youtiedthetargetscore = 'You tied the target score'
horse_str_scoretobeat = 'Score to beat:'
horse_str_setscore = 'Set score'

; The following is used to build the string:  "Custom Skater is a horse!" or "Custom Skater is an ass!"
horse_str_isa = 'is a'
horse_str_isan = 'is an'

// trickmenu.q
; tm_str_unknown = 'Unknown'					; UNSEEN
tm_str_done = 'DONE'
tm_str_airtricks = 'Air Tricks'					; separator for special trick list
tm_str_grinds = 'Grinds'						; separator for special trick list
tm_str_manuals = 'Manuals'						; separator for special trick list
tm_str_liptricks = 'Lip Tricks'					; separator for special trick list

// keyboard.q
; kc_str_defaulttitle = 'default title'		; UNSEEN
; kc_str_defaultstring = 'default string'	; UNSEEN
kc_str_acceptchanges = 'ACCEPT CHANGES'
kc_str_spc = 'SPC'
kc_str_del = 'DEL'
; kc_str_notitle = 'NO TITLE'				; UNSEEN
kc_str_empty = '--EMPTY--'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mick_strings.q

// competition.cpp
comp_str_Judge1 = 'Judge 1'                         // judge in the competition
comp_str_Judge2 = 'Judge 2'
comp_str_Judge3 = 'Judge 3'
comp_str_Judge4 = 'Judge 4'
comp_str_Judge5 = 'Judge 5'

// skate.cpp

skate_str_secs = 'secs'                             // abbreviation for 'seconds'
skate_str_tricks = 'tricks'                         // as in "you did 3 tricks"
skate_str_points_tricks = '%s points in %d tricks'  // as in "1000 points in 3 tricks"

// soundoptions.cpp

soundopt_str_off  = 'off'           // as in "this music track is switched on, enabled"
soundopt_str_on   = 'on'            // as in "this music track is switched off, disabled"

ed_str_empty_park='Empty Park'
ed_str_unsaved_park='Unsaved Park'
ed_str_name='Name'
ed_str_score='Score'
ed_str_gap='Gap'
ed_str_please_wait='Please Wait...'
ed_str_full='Full'
ed_str_empty='None'
ed_str_raise_lower='¿/º Raise/Lower'
ed_str_change_piece='¼ Change Piece'
ed_str_place_piece='¬ Place Piece'
ed_str_erase='ª Erase'
ed_str_properties='¬ Properties'
ed_str_rotate_gap='©/« Rotate gap'
ed_str_erase_gap='ª Erase Gap'
ed_str_place_gap='¬ Place Gap'


//////////////////////////////////////////////
// Ken's strings, moved here from c code.
//////////////////////////////////////////////

// cfuncs.cpp
cfuncs_str_gold='GOLD'
cfuncs_str_silver='SIL'
cfuncs_str_bronze='BRZ'
cfuncs_str_goalsfornextlevel='%d goals for next level'
cfuncs_str_medalsfornextlevel='%d medals for next level'

// Note: Careful if adding any more characters to any of these mem card titles!
// The string is split into two lines with the line break coming after the :
// Each line must have no more than 16 chars (TRC requirement for PS2)
// So these strings must be no longer than 16 chars, and must end in a :
cfuncs_str_thugstoryskater='THUG Skater:'
cfuncs_str_thugnetsettings='THUG Net File:'
cfuncs_str_thugpark='THUG Park:'
cfuncs_str_thugtrick='THUG Trick:'
cfuncs_str_thuggoals='THUG Goals:'

// On the NGC, all the save types have the same name.
// This is because Nintendo required that we prefix all our save names with Tony Hawk's Underground, but
// when we tried to append the save type as well the text was too long for the IPL screen.
cfuncs_str_ngc_generic_save_name='Tony Hawk\'s Underground'

cfuncs_str_style='Style: %s'
cfuncs_str_stance='Stance: %s'

// memcardmenu.cpp
memcardmenu_str_skater='Skater'
memcardmenu_str_park='Park'
memcardmenu_str_replay='Replay'
memcardmenu_str_kb='%d KB'
memcardmenu_str_create_new='Create new'
memcardmenu_str_freespacekb='Free space: %d KB'
memcardmenu_str_freespaceunknown='Free space: Unknown'


