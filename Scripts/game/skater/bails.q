// start autoduck documentation
// @DOC bails
// @module bails | None
// @subindex Scripting Database
// @index script | bails

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; BAILS SETUPS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                              
; anytime you bail and I want multiple possible outcomes
; I set the random bail here. These little scripts
; just redirects the skater to a particular bail script,
; based on what he's doing when he bails

// @script | DoingTrickBail | play random bail.  used when skater
// bails while doing a trick
script DoingTrickBail
// FOR PETE AND DEBUGGING
// Just uncomment the "Goto <bail>" line, and then paste in
// whichever bail you want to see from the list below it.
// Then, in the game, if you jump and do a trick as you hit ground,
// you will always play the bail specified by the goto.

	//Goto onefootbail
	//Goto Headfirstsplat
	// PASTE ONE ABOVE: Boardsplit NutSac FlailBail RollingBail BackwardsFall ManualBail NoseManualBail NutterBackward NutterForward FiftyFiftyFallBackward FiftyFiftyFallForward BackwardsFall RunOut BackwardFaceSlam Fallback Facesmash LandPartiallyOnBoard 
	If backwards
		GotoRandomScript [BackwardFaceSlam Shoulders] 
	else
		If SpeedLessThan 550
			If AirTimeLessThan 1 second
				Goto Runout
			endif
		endif
		If LandedFromVert
			GotoRandomScript [OneFootBail Boardsplit NutSac FlailBail RollingBail Kneeslide Faceplant LandPartiallyOnBoard Facesmash NoseManualBail ManualBail Hipper Spasmodic TailslideOut]			
;			GotoRandomScript [NutSac FlailBail RollingBail Kneeslide Faceplant LandPartiallyOnBoard Facesmash NoseManualBail ManualBail Hipper Spasmodic TailslideOut]			
		else
	;		LaunchPanelMessage Random (@"nice bail, idiot" @"sucker fool" @"Greedy mofo, aren't you?") 	
			GotoRandomScript [Faceplant LandPartiallyOnBoard Facesmash NoseManualBail ManualBail Hipper Spasmodic TailslideOut]			
		endif
	endif
endscript

// @script | YawBail | play bail animation when skater yaws too far left or right
script YawBail		
		//pulse_blur start = 150 speed =1
	if YawingLeft
		if Flipped
			GotoRandomScript [Boardsplit NutSac FlailBail RollingBail Splits Rolling AnkleBust1 AnkleBust2 AnkleBust3 Facesmash NoseManualBail Hipper Spasmodic Faceplant]
;			GotoRandomScript [NutSac FlailBail RollingBail Splits Rolling AnkleBust1 AnkleBust2 AnkleBust3 Facesmash NoseManualBail Hipper Spasmodic Faceplant]
		else
			GotoRandomScript [headsmack fallback shoulders]	
		endif
	else
		if Flipped
			GotoRandomScript [headsmack fallback shoulders]
		else
    		GotoRandomScript [OneFootBail Boardsplit NutSac FlailBail RollingBail Splits Rolling AnkleBust1 AnkleBust2 AnkleBust3 Facesmash NoseManualBail Hipper Spasmodic Faceplant TailslideOut]
;			GotoRandomScript [NutSac FlailBail RollingBail Splits Rolling AnkleBust1 AnkleBust2 AnkleBust3 Facesmash NoseManualBail Hipper Spasmodic Faceplant TailslideOut]
		endif			
	endif				  
endscript

                        
// @script | PitchBail | play bail animation when skater pitches too far up or down
script PitchBail
	if Not InSplitscreenGame 
		If GetGlobalFlag Flag=TAP_BUTTONS_EXPLAINED
			If not GetGlobalFlag Flag=RECOVERY_BUTTONS_EXPLAINED
				Create_Panel_Message {text="Tip: press \ml in the air to level out" 
				id=skater_hint style=skater_hint_style pos=(320,150) rgba=[32 75 102 100]}		
				SetGlobalFlag Flag=RECOVERY_BUTTONS_EXPLAINED
			endif
		endif	
	endif	    
	GotoRandomScript [HeadFirstSplat Neckbreaker] 
endscript


// @script | FiftyFiftyFall | bail animation - forward or back from 50-50
script FiftyFiftyFall
	Goto leghook //uncomment this for testing a specific rail bail  
	GotoRandomScript [Rolling FiftyFiftyFallForward FiftyFiftyFallBackward Hipper Spasmodic TailslideOut MissBackFoot] 
endscript

                        
// @script | Nutter | bail animation - nutter forward or back
script Nutter
	If Ledge									;no nutters on ledges
	;	LaunchConsoleMessage "Bad Ledge Dude"
		Goto FiftyFiftyFall  	
	else
		GotoRandomScript [NutterForward NutterBackward MissBackFoot LegHook] 
endif
endscript

// @script | BackwardsGrindBails | bail animation - from backwards grind
script BackwardsGrindBails
	GotoRandomScript [ Shoulders] //BackwardFaceSlam BackwardsFall
endscript

script MakeSkaterBail
	if not Skater:Driving
		if not Skater:Walking
			MakeSkaterGoto Spasmodic
		else
			MakeSkaterGoto WalkBailState
		endif
	endif
endscript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INDIVIDUAL BAILS DEFINES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
BAILSCRIPT=Kneeslide

script HeadSmack
GeneralBail {Anim1=HeadSmack NoBlending Anim2=HeadGetup IntoAirFrame=1 Friction=13 SmackAnim=Smackwallupright 
			BoardOffFrame=10 BoardVel=(0,0,0) BoardRotVel=(0,0,0) BoardSkaterVel = 0
			Sound=bail_knee1 FoleySound 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script OneFootBail
GeneralBail {Anim1=OneFootBail BoardOffFrame=150 NoBailBoard Anim2=OneFootGetup IntoAirFrame=1 Friction=14 SmackAnim=SmackWallFeet 
			Sound=bail_knee1 FoleySound 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script Kneeslide
GeneralBail {Anim1=KneeSlide Anim2=Kneeslide_resume IntoAirFrame=1 Friction=24 SmackAnim=SmackWallFeet 
            BoardOffFrame=0 BoardVel=(-100,0,50) BoardRotVel=(0,2,1) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script RollingBail
GeneralBail {Anim1=RollingBail Anim2=RollingGetup IntoAirFrame=1 Friction=13 SmackAnim=SmackWallFeet
            BoardOffFrame=0 BoardVel=(200,100,-50) BoardRotVel=(5,2,10) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script FlailBail
GeneralBail {Anim1=FlailBail Anim2=FlailGetup IntoAirFrame=1 Friction=0 SmackAnim=SmackWallFeet
            BoardOffFrame=0 BoardVel=(20,50,-200) BoardRotVel=(2,6,8) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script NutSac
//Currently using a random getup, but will want this to be the quicker getup if user presses x
GeneralBail {Anim1=Nutsac Anim2=Random(@NutsacGetup @NutsacGetupQUick) IntoAirFrame=1 Friction=25 SmackAnim=SmackWallFeet
            BoardOffFrame=50 BoardVel=(0,50,0) BoardRotVel=(0,0,0) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript


script Boardsplit
	GeneralBail {Anim1=Boardsplit IntoAirFrame=1 Friction=15 SmackAnim=SmackWallFeet
			BoardAlwaysOn
			UnrotateBoardFirst
            Sound=bail_knee1 FoleySound
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script Faceplant
GeneralBail {Anim1=Faceplant Anim2=Kneeslide_resume IntoAirFrame=1 Bloodframe=14 SmackAnim=SmackWallFeet 
            BoardOffFrame=0 BoardVel=(0,100,-300) BoardRotVel=(0,5,0) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script MissBackFoot
GeneralBail {Anim1=NSMissBackFoot Anim2=NSMissBackFoot_Resume IntoAirFrame=1 SmackAnim=SmackWallFeet 
            BoardOffFrame=24 BoardVel=(0,0,-100) BoardRotVel=(3,2,1) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript


script AnkleBust1 
GeneralBail {Anim1=NewAnkleBust Anim2=RailBailGetup IntoAirFrame=1 Friction=15 SmackAnim=SmackWallFeet 
            BoardOffFrame=1 BoardVel=(-100,50,-100) BoardRotVel=(5,5,10) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script AnkleBust2 
GeneralBail {Anim1=AnkleBust2 Anim2=GetUpTailslideOut IntoAirFrame=1 Friction=17 SmackAnim=SmackWallFeet 
            BoardOffFrame=1 BoardVel=(300,200,-100) BoardRotVel=(5,5,9) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound  
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script AnkleBust3 
GeneralBail {Anim1=AnkleBust3 Anim2=GetUpAnkleBust IntoAirFrame=1 Friction=17 SmackAnim=SmackWallFeet 
            BoardOffFrame=40 BoardVel=(0,60,0) BoardRotVel=(0,0,0) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound  
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script Splits
GeneralBail {Anim1=Splits Anim2=Kneeslide_resume IntoAirFrame=1 Friction=24 SmackAnim=SmackWallFeet 
            BoardOffFrame=1 BoardVel=(-30,20,50) BoardRotVel=(3,-1,0) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script Rolling
GeneralBail {Anim1=Rolling IntoAirFrame=1 Friction=15 SmackAnim=SmackWallFeet 
            BoardOffFrame=1 BoardVel=(-300,150,-100) BoardRotVel=(10,2,-2) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound NoBlending BoardEarlyOn 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script Shoulders
// Play when skater is facing backward
GeneralBail {Anim1=Shoulders NoBlending Anim2=GetUpForwards IntoAirFrame=20 Friction=15 SmackAnim=Smackwallupright 
            BoardOffFrame=1 BoardVel=(-100,50,-250) BoardRotVel=(10,2,-2) BoardSkaterVel = 1
			Sound=BoardBail01 FoleySound BloodFrame=20   
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script Hipper
// foward facing slide out anim
GeneralBail {Anim1=Hips Anim2=GetUpHips Friction=11 SmackAnim=SmackWallFeet 
            IntoAirFrame=20 //ForceFall xmove=200 moveframes=5 
			BoardOffFrame=1 BoardVel=(300,250,-150) BoardRotVel=(10,-3,3) BoardSkaterVel = 1
			Sound=Bail04 NoBlending FoleySound NoBlending Friction2=17 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript
 
script Spasmodic
// foward facing running anim
GeneralBail {Anim1=Spasmodic Anim2=GetUpSpasmodic IntoAirFrame=20 Friction=14 SmackAnim=SmackWallFeet 
            BoardOffFrame=1 BoardVel=(20,70,-200) BoardRotVel=(2,5,1) BoardSkaterVel = 0
			Sound=Bail04 FoleySound NoBlending Friction2=14 BloodFrame=48 // Commented out by Jim // HeavyFriction=1000 
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script TailslideOut
GeneralBail {Anim1=TailslideOut Anim2=GetUpTailslideOut BloodFrame=40 SmackAnim=SmackWall Sound=Bail04
            IntoAirFrame=30 // xmove=1000 moveframes=30
			BoardOffFrame=1 BoardVel=(-120,150,200) BoardRotVel=(5,0,5) BoardSkaterVel = 0
			FoleySound BonkSound
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

// @script | HeadFirstSplat | define head first splat bail params
script HeadFirstSplat
GeneralBail {Anim1=HeadFirstSplat BoardOffFrame=60 Anim2=GetUpBackwards IntoAirFrame=1 Friction=15 SmackAnim=SmackWallFeet 
			Sound=Bail04 FoleySound NoBlending 
			BoardOffFrame=1 BoardVel=(25,50,0) BoardRotVel=(0.5,3,2) BoardSkaterVel = 0
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript
                     
// @script | Neckbreaker | define neck breaker bail params
script Neckbreaker
GeneralBail {Anim1=Neckbreaker Anim2=GetUpFacing IntoAirFrame=1 Friction=15 SmackAnim=SmackWallFeet 
			Sound=Bail04 FoleySound NoBlending 
			BoardOffFrame=1 BoardVel=(25,150,0) BoardRotVel=(0.5,3,2) BoardSkaterVel = 0
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

// @script | NoseManualBail2 | define nose manual bail params
script NoseManualBail2
GeneralBail {Anim1=SlipForwards Anim2=GetUpForwards IntoAirFrame=20 Friction=15 SmackAnim=Smackwallupright 
            BoardOffFrame=1 BoardVel=(-60,150,100) BoardRotVel=(10,1,-2) BoardSkaterVel = 0
			Sound=BoardBail01 FoleySound BloodFrame=20  
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

// @script | LandPartiallyOnBoard | define land partially on board bail params
script LandPartiallyOnBoard
GeneralBail {Anim1=LandPartiallyOnBoard Anim2=GetUpForwards IntoAirFrame=1 Friction=15 SmackAnim=SmackWallFeet 
            BoardOffFrame=1 BoardVel=(-50,50,150) BoardRotVel=(-10,0,0) BoardSkaterVel = 1
			Sound=bail_knee1 FoleySound  
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

// @script | RunOut | define runout bail params
script RunOut
if SpeedLessThan 400
	GeneralBail {Anim1=RunOutQuick IntoAirFrame=1 Friction=11 BoardAlwaysOn BashOff NoBlood
                BoardAlwaysOn
				Sound=Bailrunoutflip NoScuff  
				GroundGoneBail=GroundGoneBail AnimFall1=RunOutDropIdle  AnimFall2=RunOutDrop }
else
	GeneralBail {Anim1=Runout IntoAirFrame=1 SmackAnim=SmackWallupright Friction=13 BoardAlwaysOn BashOff NoBlood
                BoardAlwaysOn
				Sound=Bailrunoutflip NoScuff  
				GroundGoneBail=GroundGoneBail AnimFall1=RunOutDropIdle  AnimFall2=RunOutDrop }
endif
endscript

; these next two bails are intended to work in instances where the character is
; grinding with his body twisted around, looking over his shoulder

// @script | BackwardFaceSlam | define bail animations for backward face slam -
// used when skater is grinding with his body twisted around, looking over his shoulder
script BackwardFaceSlam
Flip
GeneralBail {Anim1=BackwardFaceSlam Anim2=GetUpFacing IntoAirFrame=50 BloodFrame=25 SmackAnim=SmackWallFeet 
            BoardOffFrame=1 BoardVel=(0,150,0) BoardRotVel=(0,0,1) BoardSkaterVel = 1
			Sound=bail_backward1 FoleySound  			  	
			GroundGoneBail=GroundGoneBail AnimFall1=FeetFirstFallFront AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

// @script | BackwardsFall | define bail params for backwards fall -
// used when skater is grinding with his body twisted around, looking over his shoulder
script BackwardsFall
GeneralBail {Anim1=BackwardsTest Anim2=GetUpBackwards IntoAirFrame=62 BloodFrame=50 SmackAnim=SmackWallFeet  
            BoardOffFrame=1 BoardVel=(0,150,0) BoardRotVel=(0,3,1) BoardSkaterVel = 0.5
			Sound=boardbail02 HitBody FoleySound 
			GroundGoneBail=GroundGoneBail AnimFall1=FeetFirstFallFront AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

// @script | Fallback | define fallback bail params
script Fallback
GeneralBail {Anim1=Fallback NoBlending Anim2=Fallback_resume IntoAirFrame=20 BloodFrame=35 
            BoardOffFrame=1 BoardVel=(0,250,0) BoardRotVel=(0,2,5) BoardSkaterVel = 0
			Sound=Bail04 FoleySound  
			GroundGoneBail=GroundGoneBail AnimFall1=Fallback AnimFall2=BigDrop AnimFall3=GetUpFacing}
endscript

; bails for fifty fifty (i.e. parallel) type grinds

// @script | FiftyFiftyFallForward | define bail params for fifty fifty fall forward  script FiftyFiftyFallForward

script  LegHook
GeneralBail {Anim1=Railbail Anim2=GetUpFacing IntoAirFrame=27 ForceFall Friction=0 BloodFrame=50 SmackAnim=SmackWall Sound=Bail04
            BoardOffFrame=1 BoardVel=(-50,20,0) BoardRotVel=(0,1,-1) BoardSkaterVel = 1
			FoleySound FallBlendPeriod=0 SplatFriction=20
			GroundGoneBail=GroundGoneBail AnimFall1=RailBailFall AnimFall2=RailBailHitGround friction=0 AnimFall3=Railbailgetup}
endscript


script FiftyFiftyFallForward
GeneralBail {Anim1=FiftyFiftyFallForward Anim2=GetUpFacing IntoAirFrame=40 BloodFrame=50 SmackAnim=SmackWall Sound=Bail04
            BoardOffFrame=1 BoardVel=(0,0,0) BoardRotVel=(0,1,-1) BoardSkaterVel = 1
			FoleySound
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

// @script | FiftyFiftyFallBackward | define bail params for fifty fifty fall backward
script FiftyFiftyFallBackward
GeneralBail {Anim1=FiftyFiftyFallBackward Anim2=GetUpForwards IntoAirFrame=50 BloodFrame=50 SmackAnim=SmackWallFeet Sound=Bail04
            BoardOffFrame=1 BoardVel=(0,0,0) BoardRotVel=(0,-1,1) BoardSkaterVel = 1
//			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFallBack  AnimFall2=HeadFirstSplat  AnimFall3=GetUpBackwards }			
			FoleySound
			GroundGoneBail=GroundGoneBail AnimFall1=FeetFirstFallFront  AnimFall2=HeadFirstSplat  AnimFall3=GetUpBackwards }
endscript  

// @script | NutterForward | define bail params for nutter forward
script NutterForward
GeneralBail {Anim1=NutterFallForward Anim2=GetUpForwards IntoAirFrame=30 BloodFrame=50 SmackAnim=SmackWall Sound=Bail04
            BoardOffFrame=1 BoardVel=(20,0,0) BoardRotVel=(0,1,1) BoardSkaterVel = 1
			FoleySound BonkSound
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

// @script | NutterBackward | define bail params for nutter backward
script NutterBackward
GeneralBail {Anim1=NutterFallBackward Anim2=FaceSmash_resume IntoAirFrame=30 SmackAnim=SmackWallFeet Sound=Bail04
            BoardOffFrame=1 BoardVel=(-20,0,0) BoardRotVel=(1,3,1) BoardSkaterVel = 0
			FoleySound BonkSound
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script ManualBail
GeneralBail {Anim1=ManualBack Anim2=ManualGetup IntoAirFrame=30 Friction=15 SmackAnim=SmackWallFeet Sound=Bail04
            BoardOffFrame=10 BoardVel=(0,50,400) BoardRotVel=(0,0,0) BoardSkaterVel = 1
            GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFallBack AnimFall2=BigDrop AnimFall3=GetUpFacing}
endscript

script NoseManualBail
GeneralBail {Anim1=manualforwards Anim2=Manual_FGetup IntoAirFrame=30 Friction=10 SmackAnim=Smackwallupright Sound=BoardBail01
            BoardOffFrame=10 BoardVel=(0,50,-400) BoardRotVel=(0,0,0) BoardSkaterVel = 0
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript

script Facesmash
GeneralBail {Anim1=FaceFall Anim2=GetUpFacesmash SpeedBasedAnim1=FaceFallSmallHit SpeedBasedAnim2=FaceFallBigHit Speed=300 IntoAirFrame=30 Friction=5 Friction2=5 SmackAnim=Smackwallupright Sound=bodysmackA
            BoardOffFrame=1 BoardVel=(0,0,0) BoardRotVel=(0,0,0) BoardSkaterVel = 1
			GroundGoneBail=GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat AnimFall3=GetUpBackwards}
endscript


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BAILS MACRO SCRIPTS - General Bail
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
//DebugSoundFX = 1

// @script | GeneralBail |
// This is the uber bail script. It is called by most of the bails and makes
// the skater do his flailing, blood splurting, etc. There are a couple of other
// bail scripts (NoseManualBail, ManualBail, and FaceSmash), but eventually
// all bails should probably use this one script for consistency's sake
// @parmopt int | Friction | 18 | friction coeff
// @parmopt name | SmackAnim | 2 | smack animation
// @parmopt name | GroundGoneBail | | ground gone bail script name passed to setexception
// @parmopt name | sound | | sound to play
// @parm name | Anim1 | first animation.
// @parmopt name | BoardAlwaysOn |  | A flag to tell the bail to keep the animated board always on and not create the bouncy board 
// @parmopt int | BoardOffFrame | 5 | Frame number of animation at which to switch the animated board off and the bouncy board on 
// @parmopt vector | BoardVel | (0,0,0) | Intital velocity to give the bouncy board, x,y,z in inches/sec. 
// @parmopt vector | BoardRotVel | (0,0,0) | Initial rotational velocity on the bouncy board, x,y,z in radians/sec.
// @parmopt float | BoardSkaterVel | 1.0 | Percentage of skater's velocity to apply to the bail board. 1.0 is full; 0 is none.
// @parmopt int | xmove | 5 | During a rail bail, the distance to move the skater at the IntoAirFrame in the x direction. Can be negative
// @parmopt int | moveframes | 0 | During a rail bail, the time - in 1/60ths during which to apply the xmove.
// @parmopt name | ForceFall |  | Force the skater into the GroundGoneBail right at the intoairframe 
// @parmopt int | SplatFriction | 100 | Amount of RollingFriction to apply when skater hits the ground in the splat anim. Default is 100 - basically a full stop. 
 // @parmopt int | FallBlendPeriod | 0.3 | Amount to blend from Anim1 or Anim2 into the Falling anim
script GeneralBail Friction=18 friction2=20 HeavyFriction=100  
	
	// GJ:  there's some poly corruption here on certain bails
	// because the board gets too far from the skater's origin.
	// to fix this, we need to temporary change the bounding 
	// sphere here and restore it when we're done with the bail
	Obj_SetBoundingSphere 100

	// GJ:  on certain bails, the board needs to be rotated the 
	// correct way first (such as in the BoardSplit, or else the
	// skater will kick the board away from the camera)
	if GotParam UnrotateBoardFirst
	   	if BoardIsRotated
			BoardRotate
		endif
	endif
	
	if GotParam NoBailBoard
		NoBailBoard=1
	endif
	
	NollieOff
	PressureOff

	KillSpecial
	created_trick_cleanup
	SpawnClothingLandScript
	If Not GotParam NoScuff // if we're not scuffing, we probably shouldn't be yelling
		PlaySkaterStream type="bail"
	endif
	SetSkaterCamLerpReductionTimer time = 0      // This puts the camera LERP back to the default value
	InBail				;notify the SFX and net code
	LaunchStateChangeEvent State=Skater_InBail
	; we increase the collision radius during bails
	; as you are lying on the ground and we don't want
	; your feet going through the walls
	SetExtraPush radius = 48 speed = 100 rotate = 6
	TurnToFaceVelocity				;otherwise we shoot off at odd angles when landing this way			
	// by default spawn a script to track the board
	If Not GotParam BoardAlwaysOn
		Obj_Spawnscript BailBoardControl Params={BoardOffFrame=<BoardOffFrame> BoardVel=<BoardVel> BoardRotVel=<BoardRotVel> BoardSkaterVel=<BoardSkaterVel> NoBailBoard=<NoBailBoard>}
	endif

	SparksOff
	VibrateOff
	
	ClearExceptions    	
	DisablePlayerInput AllowCameraControl
	//WaitOneGameFrame				//this could be used to fix the display and clearpanel_bailed commands from triggering on the same frame
	BailSkaterTricks
	StopBalanceTrick
	SetException Ex=CarBail				Scr=CarBail    
	If GotParam	GroundGoneBail
		SetException	Ex=GroundGone			Scr=<GroundGoneBail> Params={<...>}	
	endif
	; if there are anims for smacking into walls
	; we set them up here
	If GotParam	SmackAnim 
		SetException Ex=FlailHitWall        Scr=BailSmack Params={SmackAnim=<SmackAnim>}
		SetException Ex=FlailLeft           Scr=BailSmack Params={SmackAnim=<SmackAnim>}
		SetException Ex=FlailRight          Scr=BailSmack Params={SmackAnim=<SmackAnim>}
	endif
	If InSlapGame
		SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail
	else
        if GameModeEquals is_firefight
			SetEventHandler Ex=SkaterCollideBail	Scr=Bail_FireFight_SkaterCollideBail
		endif
	endif
	
	If GotParam Sound
		//PlaySound <sound>
	else
		PlayBonkSound 
	endif
	If GotParam NoBlending
		PlayAnim Anim=<Anim1>	NoRestart Blendperiod=0.0
	else    
		PlayAnim Anim=<Anim1>	NoRestart Blendperiod=0.3
	endif
	If GotParam BashOff
	else	
		BashOn
	endif	
	if Not InSplitscreenGame 
		If not GetGlobalFlag Flag=TAP_BUTTONS_EXPLAINED
			Create_Panel_Message {text="Tip: tap buttons to get up faster" 
			id=skater_hint style=skater_hint_style pos=(320,150) rgba=[32 75 102 100]}		
			SetGlobalFlag Flag=TAP_BUTTONS_EXPLAINED
		endif
	endif		 
	; if we bailed while grinding, we want to stay on the rail until we hit it, then go to air physics
	; if we're not on a rail, skip this part.
	If OnRail
		WaitAnim frame <intoairframe>
		SetState Air    			; So that he falls off the rail & the rail physics don't continue
		move y = 2.0                ; Mick, move him up		
 
		Obj_SpawnScript FallOffRail params={xmove=<xmove> moveframes=<moveframes>} // script to move the skater variable distances and times
		Vibrate Actuator=1 Percent=100 Duration=.2
		Rotate y=RandomRange(1,20)
		If GotParam BonkSound
			PlayBonkSound
		endif
		if GotParam ForceFall		// Sometime the animators want to force the skater into a falling style bail right at the intoairframe
			Goto GroundGoneBail Params={<...>}
		endif	    
	endif
	WaitOnGround   
	; Do a check to see if we should start scuffing the skater
	If Not GotParam NoScuff
		if not GetGlobalFlag flag=BLOOD_OFF	
			Scuff_skater
		endif	
	endif
	; time to see if this bail should have blood
	if not GetGlobalFlag flag=BLOOD_OFF	
		If GotParam	BloodFrame
			WaitAnim	frame <bloodframe>
			Obj_Spawnscript BloodSmall
			Playsound Random (@hitblood01 @hitblood02 @hitblood03) 
		endif
	endif		
	Vibrate Actuator=1 Percent=100 Duration=.2
	SetRollingFriction <HeavyFriction>
	If GotParam HitBody
		Spawnscript Hitbody Params={<...>}
	endif	
	Wait 3	frames
	SetRollingFriction <friction>
	
	; do some checks to see if the skater is nearly stopped
	; if he is, just stop him
	WaitAnim 30 percent
	SpeedCheckStop 
	SetRollingFriction <friction2>	
	WaitAnim 50 percent
	SpeedCheckStop 
	BashOn			;this is only here for the benefit of the runout anims - only the end should be sped up 
	If GotParam BoardEarlyOn
		BoardRotate normal
		SwitchOnBoard
	endif	
	WaitAnim 75 percent
	SpeedCheckStop 	
	If GotParam FoleySound
		//Playsound Foleymove01 vol = 50
	endif
	WaitAnimFinished
	// Special case playback for a speedbased middle anim, left over from the old facesmash bail
	If GotParam SpeedBasedAnim1
		If SpeedGreaterThan <Speed>
			PlayAnim Anim=<SpeedBasedAnim2>
		else
			PlayAnim Anim=<SpeedBasedAnim1>
		endif
		Vibrate Actuator=1 Percent=100 Duration=.2
		Obj_Spawnscript BloodSmall
		//PlaySound headsmackb
		SetRollingFriction 20
		WaitAnimFinished
	endif			
		
	SpeedCheckStop 
	If GotParam Anim2
		PlayAnim Anim=<Anim2> Blendperiod=0.0
	endif
	SetRollingFriction 20
	SpeedCheckStop
	VibrateOff
	WaitAnim 20 frames fromend
	SwitchOnBoard
	If	GotParam BoardAlwaysOn
	else
		BoardRotate normal
	endif
	WaitAnimFinished
	Goto Baildone
endscript

script FallOffRail xmove=5 moveframes=0
	// Cheesy script created with Ken's blessing...
	// This script is spawned during a bail, and will move the skater a certain distance in the x axis (xmove)
	// over a certain number of frames (moveframes)
	// printstruct <...>
	movetime = ( <moveframes> * 1.0 )  // cast moveframes up to a float
	if (<moveframes> > 0)
		slicedmove = (<xmove> / <movetime> )  //figure out how much to move per frame	
		//printf "slicedmove = %t" t=<slicedmove>
		if not flipped
			// if the skater is "switch", then move him the opposite direction to always match the anim
			slicedmove = (<slicedmove> * -1.0)
		endif
		begin
			move x = <slicedmove>
			wait 1 frame
		repeat <moveframes>
	else
		move x = <xmove>
	endif
endscript

script Scuff_skater
	// pick a random spot - 0=kneeL 1=kneeR 2=elbowL 3=elbowlR   4 and above = do nothing 
	<scuffspot>=RandomRange(0,4)
	if (<scuffspot> >3)
		//A placeholder - sometimes we do nothing 
	else
    	If (<scuffspot> = 3) // right elbow
    		Scuff_DoReplacement src="CS_NH_scar_armR.png" scuffspot=<scuffspot>		
    	else
    		If (<scuffspot> = 2) // left elbow		
    			Scuff_DoReplacement src="CS_NH_scar_armL.png" scuffspot=<scuffspot>		
    		else
    			If (<scuffspot> = 1) // right knee
    				Scuff_DoReplacement src="CS_NH_scar_legR.png" src2="CS_NH_scuff_legR.png" scuffspot=<scuffspot>   
    			else  // left knee
    				Scuff_DoReplacement src="CS_NH_scar_legL.png" src2="CS_NH_scuff_legL.png" scuffspot=<scuffspot>  		 	
    			endif 
    		endif
    	endif
    endif         	 
endscript
		
        
script Scuff_DoReplacement leftknee=0 rightknee=0 rightelbow=0 leftelbow=0        
	// Since we bailed, take this spot and increase the tag associated with it
	GetTags
	switch <scuffspot>
	case 0 // left knee
		leftknee = ( <leftknee>	+ 1)
		bailcount = <leftknee>
	case 1 // right knee
		rightknee = ( <rightknee> + 1)
		bailcount = <rightknee>	
	case 2 // left elbow
		leftelbow = ( <leftelbow> + 1)
		bailcount = <leftelbow>	
	case 3 // right elbow
		rightelbow = ( <rightelbow>	+ 1)
		bailcount = <rightelbow>	
	endswitch
	// store the new values back on the skater
	SetTags leftknee = <leftknee> rightknee = <rightknee> leftelbow = <leftelbow> rightelbow = <rightelbow>

	if GetGlobalFlag flag=CHEAT_SUPER_BLOOD
		bailcount = (<bailcount> + 5)
	endif	                
        	
	if GotParam src2 //It's a knee...
		if (<bailcount> > 9)	
			Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_06"   					
		else    		
			if (<bailcount> > 7)	
				Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_05"   								
			else     			
				if (<bailcount> > 6)	
					Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_04"   					
					Obj_ReplaceTexture src=<src2> dest="textures/scuffs/CS_NH_scuff_05"   					
				else        
					if (<bailcount> > 5)	
						Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_03"   					
					else			
						if (<bailcount> > 4)	
							Obj_ReplaceTexture src=<src2> dest="textures/scuffs/CS_NH_scar_02"   					
						else		
							if (<bailcount> > 3)	
								Obj_ReplaceTexture src=<src2> dest="textures/scuffs/CS_NH_scuff_04"   					
								Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_01" 							
							else
								if (<bailcount> > 2)	
									Obj_ReplaceTexture src=<src2> dest="textures/scuffs/CS_NH_scuff_03"   					
								else
									if (<bailcount> > 1)
										Obj_ReplaceTexture src=<src2> dest="textures/scuffs/CS_NH_scuff_02"   					
									else
										Obj_ReplaceTexture src=<src2> dest="textures/scuffs/CS_NH_scuff_01"   					
									endif
								endif
							endif
						endif
					endif
				endif
			endif
		endif				
    else	 //It's an elbow
//        printf " -------------- about to replace ------------------"
//        printf "scuffspot=%f" f=<scuffspot>
        if (<bailcount> > 9)	
				Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_06"     			
		else			
			if (<bailcount> > 7)	
					Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_05"     				
			else		
				if (<bailcount> > 5)	
						Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_04"   					
				else
					if (<bailcount> > 3)	
						Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_03"   					
					else
						if (<bailcount> > 1)
						    Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_02"   					
						else
						    Obj_ReplaceTexture src=<src> dest="textures/scuffs/CS_NH_scar_01"   					
						endif
					endif
				endif
			endif
		endif
	endif						
endscript

script CleanUp_Scuffs
		Obj_ReplaceTexture src="CS_NH_scar_armR.png" dest="textures/scuffs/CS_NH_scar_armR"		
		Obj_ReplaceTexture src="CS_NH_scar_armL.png" dest="textures/scuffs/CS_NH_scar_armL"		
		Obj_ReplaceTexture src="CS_NH_scar_legR.png" dest="textures/scuffs/CS_NH_scar_legR"		
		Obj_ReplaceTexture src="CS_NH_scar_legL.png" dest="textures/scuffs/CS_NH_scar_legL"		
		Obj_ReplaceTexture src="CS_NH_scuff_legR.png" dest="textures/scuffs/CS_NH_scuff_legR"		
		Obj_ReplaceTexture src="CS_NH_scuff_legL.png" dest="textures/scuffs/CS_NH_scuff_legL"		
		Obj_ReplaceTexture src="CS_NN_board_trans01.png" dest="textures/scuffs/CS_NN_board_trans01"
		SetTags leftknee=0 rightknee=0 rightelbow=0 leftelbow=0 		
endscript

script CleanUp_Deck
		Obj_ReplaceTexture src="CS_NN_board_trans01.png" dest="textures/scuffs/CS_NN_board_trans01"		
		SetTags Boardscuff=0
endscript

script DoBoardScuff
	switch <boardscuff>
		case 10	
			Obj_ReplaceTexture src="CS_NN_board_trans01.png" dest="textures/scuffs/CS_NN_boardscuff_01"		
		case 20		
			Obj_ReplaceTexture src="CS_NN_board_trans01.png" dest="textures/scuffs/CS_NN_boardscuff_02"		
		case 30
			Obj_ReplaceTexture src="CS_NN_board_trans01.png" dest="textures/scuffs/CS_NN_boardscuff_03"		
		case 40
			Obj_ReplaceTexture src="CS_NN_board_trans01.png" dest="textures/scuffs/CS_NN_boardscuff_04"		
		default	
	endswitch
//	printf "Ready to scuff >>>>>>>>>>>>>>>>>>>>>>>>"
endscript

// @script | BailBoardControl | 
// this script is spawned during GeneralBail and will wait until
// the proper point in the bail and then turn the board off and turn on the bailboard
// @parmopt int | BoardOffFrame | 5 | number of frames to wait
script BailBoardControl BoardOffFrame=5
	Wait <BoardOffFrame> frames 
	SwitchOffBoard
	if not GotParam NoBailBoard
		CreateBailBoard vel=<Boardvel> rotvel=<boardrotvel> object_vel_factor=<BoardSkaterVel>
	endif
endscript


// @script | speedcheckstop | 
// this script is called at various points during the bail to see if 
// you are nearly stopped, and if so, stop you.
script speedcheckstop
	If SpeedLessThan 300
		SetRollingFriction 100
	endif
endscript

// @script | Hitbody |                         
// another spawned script to play a SFX at the right point in the anim
// @parmopt int | hitbodyframe | 15 | number of frames to wait before playing sound
script Hitbody hitbodyframe=15
	Wait <hitbodyframe> frames
	//Playsound Random (@Hitbody03 @HitBody04)
endscript 

                        
// @script | BailSmack |                         
// This is a utility script that gets called by the Bail Macros
// it makes the character react appropriately when he smacks into
// walls mid bail
// @parmopt name | SmackAnim | SmackWall | Animation to play upon hitting wall

script BailSmack SmackAnim=SmackWall
	If InSlapGame
		SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail    
	else
        if GameModeEquals is_firefight
			SetEventHandler Ex=SkaterCollideBail	Scr=Bail_FireFight_SkaterCollideBail
		endif
	endif
	TurntoFaceVelocity
	SwitchOffBoard
	SetRollingFriction 15
	PlayAnim Anim=<SmackAnim> BlendPeriod=0.1
	Obj_Spawnscript BloodTiny
	Vibrate Actuator=1 Percent=100 Duration=.2
	//PlaySound bodysmackA
	WaitAnimFinished
	If AnimEquals Smackwall
		PlayAnim Anim=GetUpFacesmash  BlendPeriod=0.1
	else
		if AnimEquals Smackwallupright
			PlayAnim Anim=GetUpBackwards  BlendPeriod=0.1
		else
			PlayAnim Anim=GetUpFacing   BlendPeriod=0.1
		endif
	endif					
	SetRollingFriction 15
	WaitAnim 80 percent
	SwitchOnBoard
	BoardRotate normal
	WaitAnimFinished
	Goto Baildone
endscript


 
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;OTHER BAIL MACRO SCRIPTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

// @script | GroundGoneBail | 
// FALLING OVER EDGE	FALLING OVER EDGE 	FALLING OVER EDGE 	FALLING OVER EDGE 	FALLING OVER EDGE  
// We use this next script for when you bail, and you
// fall off of an edge and go into the air.
// @parmopt name | AnimFall1 | HeadFirstFall | falling animation - will loop until
// skater hits ground
// @parmopt name | AnimFall2 | HeadFirstSplat | second animation once skater hits
// @parmopt name | AnimFall3 | | Third animation

script GroundGoneBail AnimFall1=HeadFirstFall AnimFall2=HeadFirstSplat SplatFriction=100 FallBlendPeriod=0.3
InBail				;notify the SFX and net code
ClearExceptions
If InSlapGame
	SetException Ex=SkaterCollideBail	Scr=SkaterCollideBail     
else
	if GameModeEquals is_firefight
		SetEventHandler Ex=SkaterCollideBail	Scr=Bail_FireFight_SkaterCollideBail
	endif
endif
DisablePlayerInput	AllowCameraControl
SetExtraPush radius = 48 speed = 100 rotate = 6
SwitchOffBoard
//SetRollingFriction <SplatFriction>
PlayAnim Anim=<AnimFall1> NoRestart  BlendPeriod=<FallBlendPeriod>
; a little loop until we hit the ground
begin
	If AnimFinished
		PlayAnim Anim=<AnimFall1> PingPong From=End To=20 Speed=.5 BlendPeriod=0.1
	endif	
	If OnGround
		break
	endif
	WaitOneGameFrame	
repeat
Vibrate Actuator=1 Percent=100 Duration=.2
If GotParam NoBlood
else
	Obj_Spawnscript BloodTiny
endif

SetRollingFriction <SplatFriction>
//SetRollingFriction 100
PlayAnim Anim=<AnimFall2>  NoRestart BlendPeriod=0.1
BashOn
If GotParam	AnimFall3
	WaitAnimFinished
	PlayAnim Anim=<AnimFall3>  NoRestart BlendPeriod=0.1
endif
WaitAnim 20 frames fromend
BoardRotate normal
SwitchOnBoard
WaitAnimFinished
Goto BailDone
endscript


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BAILDONE!	BAILDONE!	BAILDONE!	BAILDONE!	BAILDONE!	BAILDONE!	BAILDONE! 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

// @script | BailDone |      
// This script is called at the end of all bails in order to set the player back
// to being ready to skate, with all controls enabled, etc.
script BailDone

	// GJ:  (see note in GeneralBail)
	Obj_RestoreBoundingSphere
	
	ClearLipCombos
	NotifyBailDone
	SetExtraPush radius = 0
	SetRollingFriction default
	ClearTrickQueue
	ClearEventBuffer
	ClearManualTrick
	;DefaultCollision
	BashOff
	EnablePlayerInput
	NotInBail			;notify the SFX and net code
	ClearGapTricks
	KillExtraTricks
	SetSkaterCamLerpReductionTimer time = 0      // This puts the camera LERP back to the default value
	ClearSkaterFlags		//any temp flags should be reset
	LockVelocityDirection Off
	RestoreAutoKick
	CanBrakeOn
	;if (use_bike_physics)
		;Goto Motox_OnGroundAi
	;else
	if not Walking
		goto OnGroundAI
	endif	
endscript

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BLOOD SCRIPTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

script BloodOn size=1 radius=1 name="blood_01"    
	TextureSplat radius=randomrange(1,40) size=<size> bone=bone_head name=<name> lifetime=20    
endscript

script BloodOn_Down size=1 radius=1 name="blood_01"    
	TextureSplat radius=randomrange(10,300) size=<size> bone=bone_head name=<name> dropdown_length=100 dropdown_vertical lifetime=20    
endscript


// @script | BloodBig | large amounts of blood
script BloodBig
BloodOn <...> size=10.0 freq=2.0 rnd_radius = 12
Wait 2 frames
BloodOff <...>
BloodOn <...> size=7.0 freq=2.0 rnd_radius = 12
Wait 4 frames
BloodOff <...>
BloodOn <...> size=3.0 freq=0.8 rnd_radius = 12
Wait 3 frames
BloodOff <...>
endscript

// @script | BloodCar | bleed after hitting car
script BloodCar
	Wait 30 frames
	TextureSplat radius=2 size=20 bone=bone_head name="blood_01" lifetime=20    
endscript

script BloodJackAss
	if not GetGlobalFlag flag=BLOOD_OFF	
		Wait 30 frames
		printf "MAKING SOME BIG BLOOD..............."
		BloodOn_Down size=randomrange(8,15)
		BloodOn_Down size=randomrange(8,15)    
		Wait randomrange(1,8) frames
		BloodOn_Down <...> size=randomrange(6,12) 
		BloodOn_Down <...> size=randomrange(6,12)	
		Wait randomrange(1,8) frames
		BloodOn_Down <...> size=randomrange(4,8) 
		BloodOn_Down <...> size=randomrange(4,8)	
		Wait randomrange(1,8) frames
		BloodOn_Down size=randomrange(2,6)
	endif	
endscript


// @script | BloodSmall | small amounts of blood
script BloodSmall
	if not GetGlobalFlag flag=BLOOD_OFF
		if not GetGlobalFlag flag=CHEAT_SUPER_BLOOD
			If Onground
				Obj_Spawnscript BloodSplat
			endif
			Wait 14 frames
			BloodOn <...> size=randomrange(8,12) freq=2.0 rnd_radius = 36
			Wait randomrange(1,3) frames
			BloodOn <...> size=randomrange(6,10) freq=2.0 rnd_radius = 36
			Wait randomrange(1,3) frames
			BloodOn <...> size=randomrange(4,8) freq=0.8 rnd_radius = 36
			Wait randomrange(1,3) frames
			BloodOn size=randomrange(2,6)
		
		else
				Obj_Spawnscript BloodSplat
				Wait 14 frames
				Obj_Spawnscript BloodSplat
				TextureSplat radius=randomrange(20,40) size=RandomRange(30,40) bone=bone_head name="blood_01" lifetime=20		
				Wait 5 frame
				BloodOn <...> size=randomrange(15,20) 
				Wait 4 frame
				BloodOn <...> size=randomrange(10,15)
				Wait 4 frame		
				BloodOn <...> size=randomrange(10,15) 
				Wait 3 frames
				BloodOn size=randomrange(6,10)
				Wait 2 frame 
				BloodOn size=randomrange(6,10)
				Wait 1 frame 
				BloodOn size=randomrange(6,10)
		endif
	endif		
endscript

// @script | BloodTiny | tiny amount of blood
script BloodTiny
if not GetGlobalFlag flag=BLOOD_OFF
	Obj_Spawnscript BloodSplat
	BloodOn <...> size=5.0 freq=2.0 rnd_radius = 12
	Wait 4 frames
	BloodOff <...>
	BloodOn <...> size=2.0 freq=0.8 rnd_radius = 12
	Wait 3 frames
	BloodOff <...>
endif
endscript

// @script | BloodSuperTiny | a super tiny amount of blood
script BloodSuperTiny
Obj_Spawnscript BloodSplat
BloodOn <...> size=1.0 freq=2.0 rnd_radius = 12
Wait 4 frames
BloodOff <...>
BloodOn <...> size=.5 freq=0.8 rnd_radius = 12
Wait 3 frames
BloodOff <...>
endscript

// @script | BloodSplat | make a splat of blood (using particles)
Script BloodSplat
	if not GetGlobalFlag flag=BLOOD_OFF
		BloodParticlesOn name="blood_1.png" start_col=0xFF0000AA end_col=0x220000AA num=10 emit_w=2.0  emit_h=2.0 angle=10 size=2.0  bone=bone_head growth=1.5 time=.3  speed=250  grav=-900  life=.3
	endif
endscript

// @script | SwitchOnBoard | turn on board
script SwitchOnBoard
	// non-local clients will get the switch on/off atomic events from the server
	if not IsLocalSkater
		return
	endif

	/*
	if not GetGlobalFlag flag=CHEAT_INLINE
		SwitchOnAtomic board
	else
		SwitchOffBoard	
	endif
	*/
	
	if not IsBoardMissing
		SwitchOnAtomic Board
	else
		SwitchOffBoard
	endif

	// uncomment below to remove dynamic bail board upon animated board's reappearance
	Obj_GetId
	MangleChecksums a = BailBoard b = <objId>
	if ObjectExists id = <mangled_id>
		<mangled_id>:die
	endif
endscript


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BAILBOARD	BAILBOARD	BAILBOARD	BAILBOARD	BAILBOARD	BAILBOARD	BAILBOARD
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BailBoardComponents = [
	{
		component = suspend
	}
	{
		component = rigidbody
		coeff_friction = .7	 //from 0-1 .5 is default
		coeff_restitution = .15 //0-1, bounciness, .4 is default
		const_acc = -500 //inches/s/s gravity default -386.4  
		mass_over_moment = 0.007	 //default 0.003
		center_of_mass = ( 0, 3, 0 )
		spring_const = 10
		linear_velocity_sleep_point = 3
		angular_velocity_sleep_point = 0.1
		skater_collision_radius = 28
		skater_collision_application_radius = 8
		skater_collision_impulse_factor = 1.0
		contacts = [
			( 6, 7, 18 )
			( 6, 7, -18 )			   
			( -6, 7, 18 )
			( -6, 7, -18 )
			( 6, 0, 13 )
			( 6, 0, -13 )
			( -6, 0, 13 )
			( -6, 0, -13 )
		]
		directed_friction = [
			{ none }
			{ none }
			{ none }
			{ none }
			{ ( 1, 0, 0 ) }
			{ ( 1, 0, 0 ) }
			{ ( 1, 0, 0 ) }
			{ ( 1, 0, 0 ) }
		]
		SoundType=SkaterBoardWhenBail
	}
	{
		component = skeleton
		skeletonName = thps5_human
	}
	{
		component = model
	    UseModelLights
        // We are only specifying a model file here for platforms that don't support cloning
		model = "board_default/board_default.mdl"
	}
	{
		component = modellightupdate
	}
	{
		component = sound
	}
]

script CreateBailBoard vel = ( 0, 0, 0 ) rotvel = ( 0, 0, 0 ) object_vel_factor = 1
	Obj_GetId
	MangleChecksums a = BailBoard b = <objId>

	if ObjectExists id = <mangled_id>
		<mangled_id>:die
	endif
	
	Skeleton_SpawnCompositeObject <...> offset = ( 0, -3, 2 ) bone = Bone_Board_Root components = BailBoardComponents params = { name = <mangled_id> cloneFrom = <objId> geoms = [ board ] }
	<mangled_id>:RigidBody_IgnoreSkater 15 frames
	<mangled_id>:RigidBody_Wake
endscript

// @script | SwitchOffBoard | turn off board for maul character
script SwitchOffBoard
	SwitchOffAtomic Board
endscript

// @script | CleanUpSpecialItems | special items for maul and demoness
script CleanUpSpecialItems 
	SwitchOffAtomic special_item
	SwitchOnAtomic	special_item_2
endscript

script SkaterCollideBall
if InAir	
	InAirExceptions	
	Obj_Spawnscript CarSparks
	PlayAnim Anim=Boneless BlendPeriod=0.3
	SetTrickName "Scratchin the Ball!"
	SetTrickScore 400
	Display
	WaitAnimWhilstChecking AndManuals
	Goto Airborne
else	
	InBail				;notify the SFX and net code
	Obj_Spawnscript BloodCar
	//PlaySound bodysmackA
    goto NoseManualBail
    LaunchPanelMessage "Ball Busted!"
endif
endscript

script skater_play_bail_stream
	Obj_PlayStream <stream_checksum> vol=500
endscript

script skater_hint_style
	DoMorph time=0 scale=(0, 0)
    DoMorph time=.1 scale=(2.5, 2.5)
    DoMorph time=.1 scale=(.75, .75)   
	DoMorph time=.1 scale=(1.3, 1.3)
	DoMorph time=.1 scale=(1.1, 1.1)
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
	DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
    DoMorph time=.05 alpha=.6
    DoMorph time=.05 alpha=1
     	;Wait 2 seconds    
	DoMorph time=.1	scale=(2.5, 2.5)
	DoMorph time=.2	scale=(12.0, 0) alpha=0
	die
endscript

