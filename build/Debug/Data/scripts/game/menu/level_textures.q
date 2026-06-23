script display_current_level_texture_values
	if ScreenElementExists id = texture_list
		DestroyScreenElement id = texture_list
	endif
	initials = ["cp" "dt" "hj" "as" "jow" "tw" "cw" "mls" "apm" "dm" "nsn" "cs" "ts" "tb" "tz" "jg"]
	FL = {cp = 2606608 dt = 0 hj = 0 as = 0 jow = 0 tw = 3150752 cw = 0 mls = 0 apm = 0 dm = 0 nsn = 0 cs = 0 ts = 0 tb = 0 tz = 308096 jg = 0}
	HI = {cp = 2077184 dt = 0 hj = 0 as = 0 jow = 0 tw = 2470144 cw = 0 mls = 0 apm = 0 dm = 0 nsn = 0 cs = 0 ts = 0 tb = 0 tz = 1417408 jg = 0}
	NJ = {cp = 0 dt = 3573472 hj = 1794784 as = 0 jow = 0 tw = 0 cw = 0 mls = 0 apm = 160256 dm = 0 nsn = 0 cs = 0 ts = 500064 tb = 0 tz = 0 jg = 14464}
	NY = {cp = 0 dt = 0 hj = 0 as = 0 jow = 969440 tw = 0 cw = 2515200 mls = 0 apm = 400672 dm = 0 nsn = 0 cs = 0 ts = 0 tb = 0 tz = 0 jg = 986944}
	RU = {cp = 0 dt = 0 hj = 0 as = 3511840 jow = 0 tw = 0 cw = 0 mls = 38848 apm = 0 dm = 0 nsn = 0 cs = 0 ts = 0 tb = 3130592 tz = 0 jg = 0}
	SD = {cp = 0 dt = 0 hj = 0 as = 0 jow = 2930624 tw = 0 cw = 0 mls = 0 apm = 0 dm = 0 nsn = 0 cs = 3600192 ts = 0 tb = 0 tz = 0 jg = 0}
	VC = {cp = 0 dt = 18432 hj = 10368 as = 0 jow = 0 tw = 0 cw = 32192 mls = 895296 apm = 2503712 dm = 0 nsn = 0 cs = 0 ts = 1911520 tb = 5248 tz = 0 jg = 0}
	def_lev = {cp = 0 dt = 63936 hj = 44672 as = 0 jow = 0 tw = 0 cw = 0 mls = 0 apm = 0 dm = 0 nsn = 0 cs = 0 ts = 0 tb = 0 tz = 0 jg = 0}
	if levelIs load_NJ
		if GotParam NJ
			level = <NJ>
		else
			return
		endif
	endif
	if levelIs load_NY
		if GotParam NY
			level = <NY>
		else
			return
		endif
	endif
	if levelIs load_FL
		if GotParam FL
			level = <FL>
		else
			return
		endif
	endif
	if levelIs load_SD
		if GotParam SD
			level = <SD>
		else
			return
		endif
	endif
	if levelIs load_HI
		if GotParam HI
			level = <HI>
		else
			return
		endif
	endif
	if levelIs load_VC
		if GotParam VC
			level = <VC>
		else
			return
		endif
	endif
	if levelIs load_RU
		if GotParam RU
			level = <RU>
		else
			return
		endif
	endif
	if levelIs load_AU
		if GotParam AU
			level = <AU>
		else
			return
		endif
	endif
	if levelIs load_default
		if GotParam def_lev
			level = <def_lev>
		else
			return
		endif
	endif
	if NOT GotParam level
		return
	endif
	SetScreenElementLock id = root_window off
	GetArraySize <initials>
	index = 0
	shift = 0
	begin
		FormatText checksumname = checksum "%i" i = (<initials>[<index>])
		if (&level.&checksum > 0)
			FormatText textname = text "%i = %t KB" i = (<initials>[<index>]) t = ((<level>.<checksum>) / 1024)
			CreateScreenElement {
				type = TextElement
				parent = tex_count_anchor
				pos = ((Pair(0,15) * &shift) + Pair(0,30))
				text = &text
				font = dialog
				rgba = [60 60 100 100]
				just = [left center]
				scale = 0.80
			}
			shift = (<shift> + 1)
		endif
		index = (<index> + 1)
	repeat &array_size
endscript

