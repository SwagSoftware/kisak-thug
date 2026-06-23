// TODO:  maybe get this into a more readable format,
// and comment it...

// TODO:  need to create not flags, once on startup?
// what if it's not defined (as opposed to having a "None"?

script cas_handle_disqualifications

	cas_disq_remove_logo <...>			// for non-logoable items

	// GJ: Hats and helmets disqualify each other
	cas_disq_remove_hat <...>			// for helmets
	cas_disq_remove_helmet <...>		// for hats

	// GJ: Disqualifications often work in pairs
	// Backpack disqualifies sweatshirt,
	// and then sweatshirt disqualifies backpack
	cas_disq_remove_bulky_shirt <...>	// for certain backpacks
	cas_disq_remove_backpack <...>		// for certain shirts

	// Socks disqualify bare feet,
	// and then bare feet disqualifies shoes
	cas_disq_remove_footwear <...>		// for barefeet

	cas_disq_handle_weird_items <...>

	cas_disq_add_sleeves <...>

endscript

script cas_disq_add_sleeves

	// if you just changed your torso, add a new placeholder sleeve
	<just_changed_torso> = 0

	if ( ChecksumEquals a=<part> b=skater_m_torso )
		<just_changed_torso> = 1
	endif

	if ( ChecksumEquals a=<part> b=skater_f_torso )
		<just_changed_torso> = 1
	endif

	if ( <just_changed_torso> = 1 )
		GetActualCASOptionStruct part=<part> desc_id=<desc_id>

		EditPlayerAppearance {
			profile=<currentSkaterProfileIndex>
			target=SetPart
			targetParams={ part=sleeves desc_id=#"None" }
		}
	endif

endscript

script cas_disq_handle_weird_items
	// look up the actual struct using the part/desc_id combination
	GetActualCASOptionStruct part=<part> desc_id=<desc_id>

	// This removes some shirts,
	// when using dick or ollie
	if GotParam is_weird_head
		if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=skater_m_torso
			GetActualCASOptionStruct part=skater_m_torso desc_id=<desc_id>
			if GotParam not_with_weird_head
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=SetPart
					targetParams={ part=skater_m_torso desc_id=#"T-shirt" }
				}
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=SetPart
					targetParams={ part=sleeves desc_id=#"None" }
				}
			endif
		endif

		// Also, remove some of your headgear
		EditPlayerAppearance {
			profile=<currentSkaterProfileIndex>
			target=ClearPart
			targetParams={ part=hat }
		}
		EditPlayerAppearance {
			profile=<currentSkaterProfileIndex>
			target=ClearPart
			targetParams={ part=helmet }
		}
	endif

	// This removes some shirts,
	// when using paper bag
	if GotParam is_weird_hat
		if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=skater_m_torso
			GetActualCASOptionStruct part=skater_m_torso desc_id=<desc_id>
			if GotParam not_with_weird_hat
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=SetPart
					targetParams={ part=skater_m_torso desc_id=#"T-shirt" }
				}
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=SetPart
					targetParams={ part=sleeves desc_id=#"None" }
				}
			endif
		endif
		EditPlayerAppearance {
			profile=<currentSkaterProfileIndex>
			target=ClearPart
			targetParams={ part=helmet }
		}
	endif
endscript

script cas_disq_remove_footwear

	// look up the actual struct using the part/desc_id combination
	GetActualCASOptionStruct part=<part> desc_id=<desc_id>

	// remember the skater profile index
	GetCurrentSkaterProfileIndex

	// remove socks and shoes if you just chose bare feet
	if gotparam bare_feet
		EditPlayerAppearance {
			profile=<currentSkaterProfileIndex>
			target=ClearPart
			targetParams={ part=skater_m_socks }
		}
		EditPlayerAppearance {
			profile=<currentSkaterProfileIndex>
			target=ClearPart
			targetParams={ part=skater_f_socks }
		}
		EditPlayerAppearance {
			profile=<currentSkaterProfileIndex>
			target=ClearPart
			targetParams={ part=shoes }
		}
	endif

endscript

script cas_disq_remove_backpack

	// look up the actual struct using the part/desc_id combination
	GetActualCASOptionStruct part=<part> desc_id=<desc_id>

	// remember the skater profile index
	GetCurrentSkaterProfileIndex

	// This removes bulky shirts, if necessary...
	if GotParam not_with_backpack
		if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=skater_m_backpack
			GetActualCASOptionStruct part=skater_m_backpack desc_id=<desc_id>
			if GotParam is_backpack
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=ClearPart
					targetParams={ part=skater_m_backpack }
				}
			endif
		endif

		if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=skater_f_backpack
			GetActualCASOptionStruct part=skater_f_backpack desc_id=<desc_id>
			if GotParam is_backpack
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=ClearPart
					targetParams={ part=skater_f_backpack }
				}
			endif
		endif
	endif



endscript

script cas_disq_remove_bulky_shirt

	// look up the actual struct using the part/desc_id combination
	GetActualCASOptionStruct part=<part> desc_id=<desc_id>

	// remember the skater profile index
	GetCurrentSkaterProfileIndex

	// This removes bulky shirts, if necessary...
	if GotParam is_backpack
		if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=skater_m_torso
			GetActualCASOptionStruct part=skater_m_torso desc_id=<desc_id>
			if GotParam not_with_backpack
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=SetPart
					targetParams={ part=skater_m_torso desc_id=#"T-shirt" }
				}
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=SetPart
					targetParams={ part=sleeves desc_id=#"None" }
				}
			endif
		endif

		if GetPlayerAppearancePart player=<currentSkaterProfileIndex> part=skater_f_torso
			GetActualCASOptionStruct part=skater_f_torso desc_id=<desc_id>
			if GotParam not_with_backpack
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=SetPart
					targetParams={ part=skater_f_torso desc_id=#"T-shirt" }
				}
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=SetPart
					targetParams={ part=sleeves desc_id=#"None" }
				}
			endif
		endif
	endif


endscript

script cas_disq_remove_hat

	// look up the actual struct using the part/desc_id combination
	GetActualCASOptionStruct part=<part> desc_id=<desc_id>

	// remember the skater profile index
	GetCurrentSkaterProfileIndex

	// remove helmets
	if ( ChecksumEquals a=<part> b=helmet )
		if not gotParam null_item
			GetCurrentSkaterProfileIndex
			EditPlayerAppearance {
				profile=<currentSkaterProfileIndex>
				target=ClearPart
				targetParams={ part=hat }
			}
			EditPlayerAppearance {
				profile=<currentSkaterProfileIndex>
				target=ClearPart
				targetParams={ part=hat_logo }
			}
		endif
	endif

endscript

script cas_disq_remove_helmet

	// look up the actual struct using the part/desc_id combination
	GetActualCASOptionStruct part=<part> desc_id=<desc_id>

	// remember the skater profile index
	GetCurrentSkaterProfileIndex

	// remove hats
	if ( ChecksumEquals a=<part> b=hat )
		if not gotParam null_item
			GetCurrentSkaterProfileIndex
			EditPlayerAppearance {
				profile=<currentSkaterProfileIndex>
				target=ClearPart
				targetParams={ part=helmet }
			}
			EditPlayerAppearance {
				profile=<currentSkaterProfileIndex>
				target=ClearPart
				targetParams={ part=helmet_logo }
			}
		endif
	endif

endscript

script cas_disq_remove_logo

	// look up the actual struct using the part/desc_id combination
	GetActualCASOptionStruct part=<part> desc_id=<desc_id>

	// remember the skater profile index
	GetCurrentSkaterProfileIndex

	// remove shirt logos, if the new shirt doesn't support it
	if ( ( ChecksumEquals a=<part> b=skater_m_torso ) || ( ChecksumEquals a=<part> b=skater_f_torso ) )
		if not gotParam supports_logo
			GetCurrentSkaterProfileIndex
			EditPlayerAppearance {
				profile=<currentSkaterProfileIndex>
				target=ClearPart
				targetParams={ part=front_logo }
			}
			EditPlayerAppearance {
				profile=<currentSkaterProfileIndex>
				target=ClearPart
				targetParams={ part=back_logo }
			}
		else
			// it supports the front logo, but not the back one
			if gotParam no_back_logo
				EditPlayerAppearance {
					profile=<currentSkaterProfileIndex>
					target=ClearPart
					targetParams={ part=back_logo }
				}
			endif
		endif
	endif

	// remove hat logo, if the new hat doesn't support it
	if ( ChecksumEquals a=<part> b=hat )
		if not gotParam supports_logo
			EditPlayerAppearance {
				profile=<currentSkaterProfileIndex>
				target=ClearPart
				targetParams={ part=hat_logo }
			}
		endif
	endif

	// remove helmet logo, if the new hat doesn't support it
	if ( ChecksumEquals a=<part> b=helmet )
		if not gotParam supports_logo
			EditPlayerAppearance {
				profile=<currentSkaterProfileIndex>
				target=ClearPart
				targetParams={ part=helmet_logo }
			}
		endif
	endif

endscript

script cas_temp_disq_remove_head

	<should_remove_head> = 0

	if GotPart part=skater_m_head
		<head_part> = skater_m_head
		<should_remove_head> = 1
	endif

	if GotPart part=skater_f_head
		<head_part> = skater_f_head
		<should_remove_head> = 1
	endif

	if ( <should_remove_head> )
		GetPart part=<head_part>
		GetActualCASOptionStruct part=<head_part> desc_id=<desc_id>

		// get proper color
		<use_default_hsv> = 1
		GetPart part=<head_part>
		if ( <use_default_hsv> = 1 )
			if GotParam default_h
				<use_default_hsv> = 0
				<h> = <default_h>
				<s> = <default_s>
				<v> = <default_v>
				if not GotParam default_s
					script_assert "missing default_s parameter"
				endif
				if not GotParam default_v
					script_assert "missing default_v parameter"
				endif
			endif
		endif

		SetPart part=<head_part> desc_id=#"None" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
	endif

endscript

script cas_temp_disq_remove_socks
	ClearPart part=skater_m_socks
	ClearPart part=skater_f_socks
endscript

script cas_temp_disq_check_for_covered_socks

	<should_remove_socks> = 0

	if GotPart part=skater_m_socks
		<leg_part> = skater_m_legs
		<sock_part> = skater_m_socks
		<should_remove_socks> = 1
	endif

	if GotPart part=skater_f_socks
		<leg_part> = skater_f_legs
		<sock_part> = skater_f_socks
		<should_remove_socks> = 1
	endif

	if ( <should_remove_socks> )
		if GotPart part=<leg_part>
			GetPart part=<leg_part>
			GetActualCASOptionStruct part=<leg_part> desc_id=<desc_id>
			if GotParam covers_socks
				// also need to make sure we don't have bare feet
				GetPart part=shoes
				GetActualCASOptionStruct part=shoes desc_id=<desc_id>
				if Not GotParam bare_feet
					ClearPart part=<sock_part>
				endif
			endif
		endif
	endif

endscript

script cas_temp_disq_remove_accessories
	ClearPart part=accessories
endscript

script cas_temp_disq_force_big_kneepads

	<should_force_big_kneepads> = 0

	if GotPart part=skater_m_legs
		if PartGotFlag part=skater_m_legs flag=force_big_kneepads
			<should_force_big_kneepads> = 1
		endif
	endif

	if GotPart part=skater_f_legs
		if PartGotFlag part=skater_f_legs flag=force_big_kneepads
			<should_force_big_kneepads> = 1
		endif
	endif

	if ( <should_force_big_kneepads> )
		GetPart part=kneepads
		GetActualCASOptionStruct part=kneepads desc_id=<desc_id>

		// get proper color
		<use_default_hsv> = 1
		GetPart part=kneepads
		if ( <use_default_hsv> = 1 )
			if GotParam default_h
				<use_default_hsv> = 0
				<h> = <default_h>
				<s> = <default_s>
				<v> = <default_v>
				if not GotParam default_s
					script_assert "missing default_s parameter"
				endif
				if not GotParam default_v
					script_assert "missing default_v parameter"
				endif
			endif
		endif

		SetPart part=kneepads desc_id=#"Knee Pads Big" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
	endif

endscript

script cas_temp_disq_force_big_elbowpads

	<should_replace_elbowpads> = 0

	if GotPart part=skater_m_torso
		if PartGotFlag part=skater_m_torso flag=force_big_elbowpads
			<should_replace_elbowpads> = 1
		endif
	endif

	if GotPart part=skater_f_torso
		if PartGotFlag part=skater_f_torso flag=force_big_elbowpads
			<should_replace_elbowpads> = 1
		endif
	endif

	if GotPart part=accessories
		if PartGotFlag part=accessories flag=force_big_elbowpads
			<should_replace_elbowpads> = 1
		endif
	endif

	if ( <should_replace_elbowpads> )
		GetPart part=elbowpads

		if not GotParam desc_id
			script_assert "GetPart didn't return an appropriate value"
		endif

		// add the word " big" to the end of the name
		// to get the new desired part name...
		AppendSuffixToChecksum Base=<desc_id> SuffixString=" Big"

		GetActualCASOptionStruct part=elbowpads desc_id=<desc_id>

		// get proper color
		<use_default_hsv> = 1
		GetPart part=elbowpads
		if ( <use_default_hsv> = 1 )
			if GotParam default_h
				<use_default_hsv> = 0
				<h> = <default_h>
				<s> = <default_s>
				<v> = <default_v>
				if not GotParam default_s
					script_assert "missing default_s parameter"
				endif
				if not GotParam default_v
					script_assert "missing default_v parameter"
				endif
			endif
		endif

		// don't forget to preserve the color selection
		SetPart part=elbowpads desc_id=<appended_id> use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
	endif

endscript

script cas_temp_disq_remove_elbowpads

	<should_remove_elbowpads> = 0

	if GotPart part=skater_m_torso
		if PartGotFlag part=skater_m_torso flag=not_with_elbowpads
			<should_remove_elbowpads> = 1
		endif
	endif

	if GotPart part=skater_f_torso
		if PartGotFlag part=skater_f_torso flag=not_with_elbowpads
			<should_remove_elbowpads> = 1
		endif
	endif

	if GotPart part=accessories
		if PartGotFlag part=accessories flag=not_with_elbowpads
			<should_remove_elbowpads> = 1
		endif
	endif

	if ( <should_remove_elbowpads> )
		ClearPart part=elbowpads
	endif

endscript

script cas_temp_disq_remove_kneepads

	<should_remove_kneepads> = 0

	if GotPart part=skater_m_legs
		if PartGotFlag part=skater_m_legs flag=not_with_kneepads
			<should_remove_kneepads> = 1
		endif
	endif

	if GotPart part=skater_f_legs
		if PartGotFlag part=skater_f_legs flag=not_with_kneepads
			<should_remove_kneepads> = 1
		endif
	endif

	if ( <should_remove_kneepads> )
		ClearPart part=kneepads
	endif

endscript

script cas_temp_disq_replace_long_hair

	<should_replace_hair> = 0

	if GotPart part=skater_m_hair
		<hair_part>=skater_m_hair
		<should_replace_hair> = 1
	endif

	if GotPart part=skater_f_hair
		<hair_part>=skater_f_hair
		<should_replace_hair> = 1
	endif

	if ( <should_replace_hair> )
		GetPart part=<hair_part>
		GetActualCASOptionStruct part=<hair_part> desc_id=<desc_id>

		// get proper color
		<use_default_hsv> = 1
		GetPart part=<hair_part>
		if ( <use_default_hsv> = 1 )
			if GotParam default_h
				<use_default_hsv> = 0
				<h> = <default_h>
				<s> = <default_s>
				<v> = <default_v>
				if not GotParam default_s
					script_assert "missing default_s parameter"
				endif
				if not GotParam default_v
					script_assert "missing default_v parameter"
				endif
			endif
		endif

		if ChecksumEquals a=<hair_part> b=skater_m_hair
			if GotParam hair_type
				switch <male_hair_combo_type>
					case bald_hair_combo
						// set it to bald no matter what
						SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
					case buzzed_hair_combo
						switch <hair_type>
							case bald
								SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case buzzed
								SetPart part=<hair_part> desc_id=#"Buzzed" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case medium
								SetPart part=<hair_part> desc_id=#"Buzzed" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case long
								SetPart part=<hair_part> desc_id=#"Buzzed" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case ponytail
								SetPart part=<hair_part> desc_id=#"Buzzed" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case tall
								SetPart part=<hair_part> desc_id=#"Buzzed" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							default
								script_assert "Unrecognized hair type %s" hair_type=<hair_type>
						endswitch
					case basic_hair_combo
						switch <hair_type>
							case bald
								SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case buzzed
								SetPart part=<hair_part> desc_id=#"Hair_BuzzHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case medium
								SetPart part=<hair_part> desc_id=#"Hair_MediumHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case long
								SetPart part=<hair_part> desc_id=#"Hair_LongHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case ponytail
								SetPart part=<hair_part> desc_id=#"Hair_PonytailHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case tall
								SetPart part=<hair_part> desc_id=#"Hair_BuzzHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							default
								script_assert "Unrecognized hair type %s" hair_type=<hair_type>
						endswitch
					case medium_hair_combo
						switch <hair_type>
							case bald
								SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case buzzed
								SetPart part=<hair_part> desc_id=#"Hair_BuzzHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case medium
								SetPart part=<hair_part> desc_id=#"Hair_MediumHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case long
								SetPart part=<hair_part> desc_id=#"Hair_MediumHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case ponytail
								SetPart part=<hair_part> desc_id=#"Hair_BuzzHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case tall
								SetPart part=<hair_part> desc_id=#"Hair_BuzzHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							default
								script_assert "Unrecognized hair type %s" hair_type=<hair_type>
						endswitch
					case leavealone_hair_combo
						switch <hair_type>
							case bald
								// leave alone (need a nullscript or else the case isn't handled properly)
								SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case buzzed
								// leave alone (need a nullscript or else the case isn't handled properly)
								nullscript
							case medium
								// leave alone (need a nullscript or else the case isn't handled properly)
								nullscript
							case long
								SetPart part=<hair_part> desc_id=#"Buzzed" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case ponytail
								// leave alone (need a nullscript or else the case isn't handled properly)
								nullscript
							case tall
								SetPart part=<hair_part> desc_id=#"Buzzed" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							default
								script_assert "Unrecognized hair type %s" hair_type=<hair_type>
						endswitch
				endswitch
			endif
		endif

		// do something different for the female hairs
		if ChecksumEquals a=<hair_part> b=skater_f_hair
			if GotParam hair_type
				switch <female_hair_combo_type>
					case bald_hair_combo
						// set it to bald no matter what
						SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
					case leavealone_hair_combo
						switch <hair_type>
							case medium
								// leave alone (need a nullscript or else the case isn't handled properly)
								nullscript
							case long
								// leave alone (need a nullscript or else the case isn't handled properly)
								nullscript
							case ponytail
								// leave alone (need a nullscript or else the case isn't handled properly)
								nullscript
							case mohawk
								SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							default
								script_assert "Unrecognized hair type %s" hair_type=<hair_type>
						endswitch
					case medium_hair_combo
						// set it to the medium hat or bald
						switch <hair_type>
							case medium
								SetPart part=<hair_part> desc_id=#"Hair_MediumHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case long
								SetPart part=<hair_part> desc_id=#"Hair_MediumHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case ponytail
								SetPart part=<hair_part> desc_id=#"Hair_MediumHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case mohawk
								SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							default
								script_assert "Unrecognized hair type %s" hair_type=<hair_type>
						endswitch
					case basic_hair_combo
						switch <hair_type>
							case medium
								SetPart part=<hair_part> desc_id=#"Hair_MediumHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case long
								SetPart part=<hair_part> desc_id=#"Hair_LongHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case ponytail
								SetPart part=<hair_part> desc_id=#"Hair_PonytailHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case mohawk
								SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							default
								script_assert "Unrecognized hair type %s" hair_type=<hair_type>
						endswitch
					case ponytail_hair_combo
						switch <hair_type>
							case medium
								SetPart part=<hair_part> desc_id=#"Hair_MediumHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case long
								SetPart part=<hair_part> desc_id=#"Hair_MediumHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case ponytail
								SetPart part=<hair_part> desc_id=#"Hair_PonytailHAT" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							case mohawk
								SetPart part=<hair_part> desc_id=#"Bald" use_default_hsv=<use_default_hsv> h=<h> s=<s> v=<v>
							default
								script_assert "Unrecognized hair type %s" hair_type=<hair_type>
						endswitch
				endswitch
			endif
		endif
	endif
endscript


