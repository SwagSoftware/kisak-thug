script SkipTrack
	SkipMusicTrack
endscript

script SetCDToMusic
	SetMusicMode 1
endscript

script SetCDToAmbience
	SetMusicMode 0
endscript

script PlaySongsRandomly
	SetRandomMode 1
endscript

script PlaySongsInOrder
	SetRandomMode 0
endscript

script set_sound_level_slider
	VerifyParam param=id func=set_sound_level_slider <...>
	SetVolumeFromValue id=<id> <whichParam>
endscript

script play_sound_on_sfx_volume_adjustment
    PlaySound HUD_specialtrickAA
endscript