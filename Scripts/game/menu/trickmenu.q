; trick_menu_total_width = trick_left_menu_width + trick_right_menu_width
trick_left_menu_width = 105
trick_right_menu_width = 225
trick_menu_total_width = 330

trick_menu_properties = {
	x=155.0 y=90.0 w=trick_menu_total_width h=336.0
    just_center_x
	just_center_y
}

trick_left_menu_properties = {
    x=0.0 y=30.0 w=150.0 h=400.0
    just_center_x
	just_center_y
	not_rounded
}

trick_right_menu_properties = {
    x=150.0 y=30.0 w=200.0 h=400.0
    just_center_x
	just_center_y
	not_rounded
	right_side_icon
}

; We use obscure ASCII characters to represent the direction buttons
; by cutting and pasting from the following list:
; ¡ = U
; ¢ = UR
; £ = R
; ¤ = DR
; ¥ = D
; ¦ = DL
; § = L
; ¨ = UL
; © = Square
; ª = Triangle
; « = Circle
; ¬ = X

ButtonCombos =
[
	{	desc = "¡ + «"			for=grabtricks	trickslot=Air_CircleU			}
	{	desc = "¢ + «"			for=grabtricks	trickslot=Air_CircleUR			}
	{	desc = "£ + «"			for=grabtricks	trickslot=Air_CircleR			}
	{	desc = "¤ + «"			for=grabtricks	trickslot=Air_CircleDR			}
	{	desc = "¥ + «"			for=grabtricks	trickslot=Air_CircleD			}
  	{	desc = "¦ + «"			for=grabtricks	trickslot=Air_CircleDL			}
  	{	desc = "§ + «"			for=grabtricks	trickslot=Air_CircleL			}
  	{	desc = "¨ + «"			for=grabtricks	trickslot=Air_CircleUL			}
  	{	desc = "¡¡ + «"			for=grabtricks	trickslot=Air_U_U_Circle		}
  	{	desc = "££ + «"			for=grabtricks	trickslot=Air_R_R_Circle		}
  	{	desc = "¥¥ + «"			for=grabtricks	trickslot=Air_D_D_Circle		}
  	{	desc = "§§ + «"			for=grabtricks	trickslot=Air_L_L_Circle		}

  	{	desc = "¡ + ©"			for=fliptricks	trickslot=Air_SquareU			}
  	{	desc = "¢ + ©"			for=fliptricks	trickslot=Air_SquareUR			}
  	{	desc = "£ + ©"			for=fliptricks	trickslot=Air_SquareR			}
  	{	desc = "¤ + ©"			for=fliptricks	trickslot=Air_SquareDR			}
  	{	desc = "¥ + ©"			for=fliptricks	trickslot=Air_SquareD			}
  	{	desc = "¦ + ©"			for=fliptricks	trickslot=Air_SquareDL			}
  	{	desc = "§ + ©"			for=fliptricks	trickslot=Air_SquareL			}
  	{	desc = "¨ + ©"			for=fliptricks	trickslot=Air_SquareUL			}
  	{	desc = "¡¡ + ©"			for=fliptricks	trickslot=Air_U_U_Square		}
  	{	desc = "££ + ©"			for=fliptricks	trickslot=Air_R_R_Square		}
  	{	desc = "¥¥ + ©"			for=fliptricks	trickslot=Air_D_D_Square		}
  	{	desc = "§§ + ©"			for=fliptricks	trickslot=Air_L_L_Square		}

  	{	desc = "¡ + ª"			for=liptricks	trickslot=Lip_TriangleU			}
  	{	desc = "¢ + ª"			for=liptricks	trickslot=Lip_TriangleUR		}
  	{	desc = "£ + ª"			for=liptricks	trickslot=Lip_TriangleR			}
  	{	desc = "¤ + ª"			for=liptricks	trickslot=Lip_TriangleDR		}
  	{	desc = "¥ + ª"			for=liptricks	trickslot=Lip_TriangleD			}
  	{	desc = "¦ + ª"			for=liptricks	trickslot=Lip_TriangleDL		}
  	{	desc = "§ + ª"			for=liptricks	trickslot=Lip_TriangleL			}
  	{	desc = "¨ + ª"			for=liptricks	trickslot=Lip_TriangleUL		}
]

SpecialCombos =
[
  	{	desc = "¥§ + «"			for=airtricks trickslot=SpAir_D_L_Circle 	}
  	{	desc = "¥£ + «"			for=airtricks trickslot=SpAir_D_R_Circle	}
  	{	desc = "¥¡ + «"			for=airtricks trickslot=SpAir_D_U_Circle	}
  	{	desc = "§¥ + «"			for=airtricks trickslot=SpAir_L_D_Circle	}
  	{	desc = "§£ + «"			for=airtricks trickslot=SpAir_L_R_Circle	}
  	{	desc = "§¡ + «"			for=airtricks trickslot=SpAir_L_U_Circle	}
  	{	desc = "£¥ + «"			for=airtricks trickslot=SpAir_R_D_Circle	}
  	{	desc = "£§ + «"			for=airtricks trickslot=SpAir_R_L_Circle	}
  	{	desc = "£¡ + «"			for=airtricks trickslot=SpAir_R_U_Circle	}
  	{	desc = "¡¥ + «"			for=airtricks trickslot=SpAir_U_D_Circle	}
  	{	desc = "¡§ + «"			for=airtricks trickslot=SpAir_U_L_Circle	}
  	{	desc = "¡£ + «"			for=airtricks trickslot=SpAir_U_R_Circle	}

  	{	desc = "¥§ + ©"			for=airtricks trickslot=SpAir_D_L_Square	}
  	{	desc = "¥£ + ©"			for=airtricks trickslot=SpAir_D_R_Square	}
  	{	desc = "¥¡ + ©"			for=airtricks trickslot=SpAir_D_U_Square	}
  	{	desc = "§¥ + ©"			for=airtricks trickslot=SpAir_L_D_Square	}
  	{	desc = "§£ + ©"			for=airtricks trickslot=SpAir_L_R_Square	}
  	{	desc = "§¡ + ©"			for=airtricks trickslot=SpAir_L_U_Square	}
  	{	desc = "£¥ + ©"			for=airtricks trickslot=SpAir_R_D_Square	}
  	{	desc = "£§ + ©"			for=airtricks trickslot=SpAir_R_L_Square	}
  	{	desc = "£¡ + ©"			for=airtricks trickslot=SpAir_R_U_Square	}
  	{	desc = "¡¥ + ©"			for=airtricks trickslot=SpAir_U_D_Square	}
  	{	desc = "¡§ + ©"			for=airtricks trickslot=SpAir_U_L_Square	}
  	{	desc = "¡£ + ©"			for=airtricks trickslot=SpAir_U_R_Square	}

  	{	desc = "¥§ + ª"			for=grindtricks trickslot=SpGrind_D_L_Triangle	}
  	{	desc = "¥£ + ª"			for=grindtricks trickslot=SpGrind_D_R_Triangle	}
  	{	desc = "¥¡ + ª"			for=grindtricks trickslot=SpGrind_D_U_Triangle	}
  	{	desc = "§¥ + ª"			for=grindtricks trickslot=SpGrind_L_D_Triangle	}
  	{	desc = "§£ + ª"			for=grindtricks trickslot=SpGrind_L_R_Triangle	}
  	{	desc = "§¡ + ª"			for=grindtricks trickslot=SpGrind_L_U_Triangle	}
  	{	desc = "£¥ + ª"			for=grindtricks trickslot=SpGrind_R_D_Triangle	}
  	{	desc = "£§ + ª"			for=grindtricks trickslot=SpGrind_R_L_Triangle	}
  	{	desc = "£¡ + ª"			for=grindtricks trickslot=SpGrind_R_U_Triangle	}
  	{	desc = "¡¥ + ª"			for=grindtricks trickslot=SpGrind_U_D_Triangle	}
  	{	desc = "¡§ + ª"			for=grindtricks trickslot=SpGrind_U_L_Triangle	}
  	{	desc = "¡£ + ª"			for=grindtricks trickslot=SpGrind_U_R_Triangle	}

  	{	desc = "¥§ + ª"			for=liptricks trickslot=SpLip_D_L_Triangle	}
  	{	desc = "¥£ + ª"			for=liptricks trickslot=SpLip_D_R_Triangle	}
  	{	desc = "¥¡ + ª"			for=liptricks trickslot=SpLip_D_U_Triangle	}
  	{	desc = "§¥ + ª"			for=liptricks trickslot=SpLip_L_D_Triangle	}
  	{	desc = "§£ + ª"			for=liptricks trickslot=SpLip_L_R_Triangle	}
  	{	desc = "§¡ + ª"			for=liptricks trickslot=SpLip_L_U_Triangle	}
  	{	desc = "£¥ + ª"			for=liptricks trickslot=SpLip_R_D_Triangle	}
  	{	desc = "£§ + ª"			for=liptricks trickslot=SpLip_R_L_Triangle	}
  	{	desc = "£¡ + ª"			for=liptricks trickslot=SpLip_R_U_Triangle	}
  	{	desc = "¡¥ + ª"			for=liptricks trickslot=SpLip_U_D_Triangle	}
  	{	desc = "¡§ + ª"			for=liptricks trickslot=SpLip_U_L_Triangle	}
  	{	desc = "¡£ + ª"			for=liptricks trickslot=SpLip_U_R_Triangle	}

  	{	desc = "¥§ + ª"			for=manualtricks trickslot=SpMan_D_L_Triangle	}
  	{	desc = "¥£ + ª"			for=manualtricks trickslot=SpMan_D_R_Triangle	}
  	{	desc = "¥¡ + ª"			for=manualtricks trickslot=SpMan_D_U_Triangle	}
  	{	desc = "§¥ + ª"			for=manualtricks trickslot=SpMan_L_D_Triangle	}
  	{	desc = "§£ + ª"			for=manualtricks trickslot=SpMan_L_R_Triangle	}
  	{	desc = "§¡ + ª"			for=manualtricks trickslot=SpMan_L_U_Triangle	}
  	{	desc = "£¥ + ª"			for=manualtricks trickslot=SpMan_R_D_Triangle	}
  	{	desc = "£§ + ª"			for=manualtricks trickslot=SpMan_R_L_Triangle	}
  	{	desc = "£¡ + ª"			for=manualtricks trickslot=SpMan_R_U_Triangle	}
  	{	desc = "¡¥ + ª"			for=manualtricks trickslot=SpMan_U_D_Triangle	}
  	{	desc = "¡§ + ª"			for=manualtricks trickslot=SpMan_U_L_Triangle	}
  	{	desc = "¡£ + ª"			for=manualtricks trickslot=SpMan_U_R_Triangle	}
]

// the following are wrappers around helper.q functions.
// we need this because the trick menu code is shared
// between the front end and the ingame, but the ingame
// doesn't use the same "helper_scanner" mechanism that
// the front end uses...  instead, it must call the
// helper functions manually.
script tm_helper_on_pre_trick_menu
	if InFrontEnd
	else
		helper_select_choose_back_centered
	endif
endscript

script tm_helper_on_trick_right_menu
	if InFrontEnd
	else
		helper_on_trick_right_menu
	endif
endscript

script tm_helper_on_trick_available_menu
	if InFrontEnd
	else
		helper_on_trick_available_menu
	endif
endscript

script tm_helper_on_special_trickname_menu
	if InFrontEnd
	else
		helper_on_special_trickname_menu
	endif
endscript

script tm_helper_on_available_specials_menu
	if InFrontEnd
	else
		helper_on_available_specials_menu
	endif
endscript

script tm_helper_on_available_trickslots_menu
	if InFrontEnd
	else
		helper_on_available_trickslots_menu
	endif
endscript

ShouldDisableReplays = 0

script disable_replays
	change ShouldDisableReplays = 1
endscript

script enable_replays
	change ShouldDisableReplays = 0
endscript

