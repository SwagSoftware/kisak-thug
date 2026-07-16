// NEVERSOFT SECRET SKATERS SD

// There are two components to adding a new skater:

//-----------------------------------------------------
// (For CAS artists)
// The CAS artist is responsible for adding the CAS
// geometry/texture art assets and maintaining
// the iniskater scripts.  Basically, you will need to
// add a section to iniskater_team.q that represents
// the geometry/texture combination for this particular
// skater.  Each section should have 2
// structures defined:

//	XX_head_structure - the art assets which define this
//		skater.  If you copy and paste from another
//		structure, don't forget to change the texture
//		name ("CS_never_XX_01.png") and the flag (XX_skin).
//		"light_face, tan_face, dark_face" should be
//		defined accordingly.

//  XX_hair_exception - the "skullcap" hair texture that
//		gets swapped in when you replace the hair component.
//		Again, if you copy and paste from another structure,
//		don't forget to change the texture name and
//		the flag.

// After that, the CAS artist should add the name of the
// head_structure and the hair_exception to the TWO appropriate
// places in iniskater.q.
//-----------------------------------------------------

//-----------------------------------------------------
// (For team members)
// Each team member is responsible for maintaining his/her own
// info/appearance preferences.  Basically, look for your
// own name in the following list and edit the following:
// UNLOCK_WITH:  This is the name that the keyboard
//	control looks for to unlock your skater.  Note that it
//  doesn't necessarily have to be your name...  Kevin's
//  is "I'm a fatty!"
// DISPLAY_NAME:  This is the name that is displayed in
//  the front end and in-game
// STANCE: Choose between regular or goofy
// PUSHSTYLE: never_mongo, always_mongo, mongo_when_switch
// TRICKSTYLE: street, vert
// AGE: either your age, or -1 for "unknown"
// HOMETOWN: hometown
// APPEARANCE: To come up with your appearance, select
//  what you would like to look like using the CAS
//  system, then run the "PrintCurrentAppearance" script
//  somehow (either tie it to a user-select script, or
//  type "q PrintCurrentAppearance" in a DOS box.
//  For each element that gets printed out (head, shoes, etc.),
//  replace the existing entry with that data.
//  For example, if it says:
//		hair=
//		{
//			desc_id=#"Light Brown Slick"
//			h=45
//			S=0
//			v=20
//			use_default_hsv=0
//		}
//  then replace that entry in your section with:
//      hair				= { desc_id=#"Light Brown Slick" h = 45 s = 0 v = 20 use_default_hsv = 0 }
// STATS: For now, don't try to edit your stats or trick
//  mappings, as it might screw up the existing career (i.e.
//	any stat points that the custom skater had previously
//	accumulated would be nuked).  Alternatively, we
//	can reset the existing career and make the player
//	start over from scratch again.  Still TBD.
//-----------------------------------------------------

//-----------------------------------------------------
// (How to unlock the Neversoft skaters)
// On a PC build, the skaters are always unlocked.  Just
// type your name in the CAS name entry screen and he/she
// should automatically appear.
// On a CD build, you'll need to unlock the skaters first.
// To do this, type "WeEatDirt" (not case-sensitive) from
// the cheat menu.

