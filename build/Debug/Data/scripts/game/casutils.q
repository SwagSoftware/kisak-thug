; CASUTILS.Q
; Gary Jesdanun

; Utility functions for Create-a-Skater type stuff
; This file should contain the functions that
; the C-code will need to communicate with the
; artist-maintained script data.


; ---------------------------------------

script create_model_from_appearance

	// GJ:  Do NOT use the current skater profile
	// index at all while creating our model
	// (such as for doing disqualifications)
	LockCurrentSkaterProfileIndex 1

	ModelClearAllGeoms

	//	DebugPrintAppearance

	// the following loop through all the parts
	process_cas_command cas_command=ModelRunScript  			editable_list=master_editable_list target=disqualify_script
	process_cas_command cas_command=ModelAddGeom        		editable_list=master_editable_list
	process_cas_command cas_command=GeomReplaceTexture  		editable_list=master_editable_list

	// apply various scales here
	model_apply_scale

	// hide as necessary (for cheats)
	process_cas_command cas_command=model_hide_geom 	  		editable_list=master_editable_list

	// removes polys based on the accumulated poly removal flags
	ModelRemovePolys

	// applies the face texture from the face mapping interface
	// (temporary, until we can work out the correct pathway)
	model_apply_face_texture

	// do colors after the face texture has been replaced
	process_cas_command cas_command=GeomModulateColor   		editable_list=master_editable_list

	// x-box needs to allocate all the UV data once,
	// some time after the geoms are loaded in
	allocate_uv_matrix_params

	// do uv placement for decks, tattoos, etc.
	set_uv_from_appearance

	ModelFinalize

	// GJ:  Now we are free to access the current
	// skater profile index again...
	LockCurrentSkaterProfileIndex 0

endscript

script create_ped_model_from_appearance

	// this loops through less parts, in the hopes of making ped creation faster
	// GJ:  Do NOT use the current skater profile
	// index at all while creating our model
	// (such as for doing disqualifications)
	LockCurrentSkaterProfileIndex 1

	ModelClearAllGeoms

	// the following loop through all the parts
	//    process_cas_command cas_command=ModelRunScript  			editable_list=ped_editable_list target=disqualify_script
	process_cas_command cas_command=ModelAddGeom        		editable_list=ped_editable_list
	//    process_cas_command cas_command=GeomReplaceTexture  		editable_list=master_editable_list

	// apply various scales here
	model_apply_scale

	// hide as necessary (for cheats)
	//    process_cas_command cas_command=model_hide_geom 	  		editable_list=master_editable_list

	// removes polys based on the accumulated poly removal flags
	ModelRemovePolys

	// applies the face texture from the face mapping interface
	// (temporary, until we can work out the correct pathway)
	//	model_apply_face_texture

	// do colors after the face texture has been replaced
	process_cas_command cas_command=GeomModulateColor   		editable_list=ped_editable_list

	// x-box needs to allocate all the UV data once,
	// some time after the geoms are loaded in
	//	allocate_uv_matrix_params

	// do uv placement for decks, tattoos, etc.
	//	set_uv_from_appearance

	ModelFinalize

	// GJ:  Now we are free to access the current
	// skater profile index again...
	LockCurrentSkaterProfileIndex 0

endscript

script replace_cutscene_skater_from_appearance

	// GJ:  Do NOT use the current skater profile
	// index at all while creating our model
	// (such as for doing disqualifications)
	LockCurrentSkaterProfileIndex 1

	process_cas_command cas_command=GeomReplaceTexture editable_list=master_editable_list

	// applies the face texture from the face mapping interface
	// (temporary, until we can work out the correct pathway)
	model_apply_face_texture

	// do colors after the face texture has been replaced
	// (this is done in code, because the name of the cutscene skater's head geom
	// is different from the name of the skater's head geom
	// (even though there's some code in cutscenedetails.cpp
	// to color the hi-res cutscene head, we still need to do
	// this to apply the facial hair color)
	process_cas_command cas_command=GeomModulateColor   		editable_list=master_editable_list

	// GJ:  Now we are free to access the current
	// skater profile index again...
	LockCurrentSkaterProfileIndex 0

endscript

script model_apply_face_texture
	// GJ: applies the face texture here
	// (kind of hardcoded right now)
	ModelApplyFaceTexture src="CS_NSN_facemap.png"

endscript

script model_apply_scale

	<standard_scaling> = 1

	ModelResetScale

	;if not InNetGame
	// don't do it if you're playing jango or eddie
	if AppearanceAllowScalingCheat

		if GetGlobalFlag flag=CHEAT_KID
			ModelApplyBodyShape body_shape=kid_scale_info
			ModelApplyObjectScale body_shape=kid_scale_info
			<standard_scaling> = 0
		endif

		if GetGlobalFlag flag=CHEAT_BIGHEAD
			ModelApplyBodyShape body_shape=bighead_scale_info is_bighead_cheat
			ModelApplyObjectScale body_shape=bighead_scale_info
			<standard_scaling> = 0
		endif

		// gorilla must come last, because
		// it applies scales locally
		if GetGlobalFlag flag=CHEAT_GORILLA
			ModelApplyBodyShape body_shape=gorilla_scale_info
			ModelApplyObjectScale body_shape=gorilla_scale_info
			<standard_scaling> = 0
		endif
	endif
	;endif

	// standard scaling
	if ( <standard_scaling> = 1 )
		ModelApplyBodyShape
		ModelApplyObjectScale
		process_cas_command cas_command=ModelApplyBoneScale editable_list=master_scaling_list
	endif

	// apply the hoverboard afterwards,
	// so that it doesn't conflict
	// with regular scaling
	if GetGlobalFlag flag=CHEAT_HOVERBOARD
		ModelApplyBodyShape body_shape=hoverboard_scale_info
	endif

endscript

script model_hide_geom

	<invisible> = 0

	if not InNetGame
		if AppearanceAllowScalingCheat
			// handle cheats here first
			if GetGlobalFlag flag=CHEAT_INVISIBLE
				<invisible> = 1
			endif
		endif
	endif

	if ChecksumEquals a=<part> b=skater_m_head
		ModelHideGeom part=<part> <invisible>
		return
	endif

	if ChecksumEquals a=<part> b=skater_m_hair
		ModelHideGeom part=<part> <invisible>
		return
	endif

	if ChecksumEquals a=<part> b=skater_f_head
		ModelHideGeom part=<part> <invisible>
		return
	endif

	if ChecksumEquals a=<part> b=skater_f_hair
		ModelHideGeom part=<part> <invisible>
		return
	endif

	if ChecksumEquals a=<part> b=body
		ModelHideGeom part=<part> <invisible>
		return
	endif

endscript

script preload_model_from_appearance
	ModelClearAllGeoms

	process_cas_command cas_command=ModelAddGeom        		editable_list=master_editable_list
endscript

script color_model_from_appearance
	process_cas_command cas_command=GeomModulateColor   		editable_list=master_editable_list
endscript

script scale_model_from_appearance
	// apply various scales here
	model_apply_scale
endscript

script hide_model_from_appearance
	// hide as necessary (for cheats)
	process_cas_command cas_command=model_hide_geom 	  		editable_list=master_editable_list
endscript

script allocate_uv_matrix_params
	// x-box needs to allocate all the UV data once,
	// some time after the geoms are loaded in
	// (this is a separate pass from set_uv_from_appearance,
	// because the latter only operates when there
	// is a valid UV matrix, but the former needs to
	// happen on every material that could theoretically
	// modify its uvs)
	GetArraySize master_uv_list
	<index> = 0
	begin
		GeomAllocateUVMatrixParams (master_uv_list[<index>])
		<index> = ( <index> + 1 )
	repeat <array_size>
endscript

script set_uv_from_appearance
	// do uv placement for decks, tattoos, etc.
	GetArraySize master_uv_list
	<index> = 0
	begin
		GeomSetUVOffset (master_uv_list[<index>])
		<index> = ( <index> + 1 )
	repeat <array_size>
endscript

; ---------------------------------------

script process_cas_command editable_list=master_editable_list
	ForEachIn <editable_list> do=<cas_command> params=<...>
endscript

; ---------------------------------------

script preselect_random_parts
	PreSelectRandomPedMHeads num=<num_m_heads>
	PreSelectRandomPedMTorsos num=<num_m_torsos>
	PreSelectRandomPedMLegs num=<num_m_legs>
	PreSelectRandomPedFHeads num=<num_f_heads>
	PreSelectRandomPedFTorsos num=<num_f_torsos>
	PreSelectRandomPedFLegs num=<num_f_legs>
endscript

script PreSelectRandomPedMHeads num=3
	PreselectRandomPedestrians part=ped_m_head num=<num>
endscript

script PreSelectRandomPedMTorsos num=3
	PreselectRandomPedestrians part=ped_m_torso num=<num>
endscript

script PreSelectRandomPedMLegs num=3
	PreselectRandomPedestrians part=ped_m_legs num=<num>
endscript

script PreSelectRandomPedFHeads num=3
	PreselectRandomPedestrians part=ped_f_head num=<num>
endscript

script PreSelectRandomPedFTorsos num=3
	PreselectRandomPedestrians part=ped_f_torso num=<num>
endscript

script PreSelectRandomPedFLegs num=2
	PreselectRandomPedestrians part=ped_f_legs num=<num>
endscript


