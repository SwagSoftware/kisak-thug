/*
script Baseball_start
	// printstruct <...>
	SkaterInit ReturnControl NoAnims  	//just reinitalize the skater, to be safe
	TurnOffSpecialItem
	SwitchOnBoard
	ClearExceptions
	ClearTrickQueues
//	SetQueueTricks Baseball_abort	
	SetRollingFriction 10000
  
	Obj_MoveToNode Name = TRG_MG_BaseBall_Batter orient	
	SetState Lip
	If Flipped
		flip
	endif
		
	SetTags direction=none swing=none	
	Playanim Anim=Ped_MLB_Idle Cycle
	DoNextTrick
	Wait 1 second
	DoNextTrick
	Goto Baseball_ready
endscript

//Ped_TP_Idle Ped_TP_SkaterStandingHit Ped_TP_SkaterIdle

script Baseball_ready
	printf "ready to play ball................................."
	SetTags direction=none swing=none	
	printf <swing>
	
	SetQueueTricks Baseball_swings
	
	Playanim Anim=Ped_MLB_Idle Cycle
	begin
        if IsXbox      
			if Held Circle
				SpawnScript ALC_MG_EndGame
				MakeSkaterGoto SkaterInit
				Break
			Endif
		else	// GameCube or PS2 version
			if IsNGC
				if Held Square
					SpawnScript ALC_MG_EndGame
					MakeSkaterGoto SkaterInit
					Break
				Endif
			else	// PS2 version
				if Held triangle
					printf "in here"
					SpawnScript ALC_MG_EndGame
					MakeSkaterGoto SkaterInit
					Break
				Endif
			endif	
		endif	
		DoNextTrick
		Wait 1 gameframe
	repeat
endscript

Baseball_abort = [
    {Trigger={Press,Square,100}   				Baseball_abort_script}	    ]


Baseball_Swings = [
    {Trigger={Press,X,100}   				Scr=Swing Params={direction=up 		anim=Ped_MLB_Hit }}	        
//	{Trigger={AirTrickLogic,X,Up,500}   		Scr=Swing Params={direction=up 		anim=Ped_TP_SkaterStandingHit }}	    
//	{Trigger={AirTrickLogic,X,Down,500}    	Scr=Swing Params={direction=down 	anim=Ped_TP_SkaterStandingHit }}
//    {Trigger={AirTrickLogic,X,Right,500}  		Scr=Swing Params={direction=right 	anim=Ped_TP_SkaterStandingHit }}
//    {Trigger={AirTrickLogic,X,Left,500}    	Scr=Swing Params={direction=left 	anim=Ped_TP_SkaterStandingHit }}
]			

Script Swing
	PlayAnim Anim=<anim>
	SetTags BB_direction=<direction>
//	printf <direction>
	SetQueueTricks NoTricks
	SetTags swing=strike
	Wait .1 seconds
	SetTags swing=foul
//		GetTags
//		printf <swing>	
	Wait .18 seconds
	SetTags swing=hit
	PlaySound ArmWhoosh01 vol=40 pitch=120		
		GetTags
//		printf <swing>
	Wait .2 seconds 
	SetTags swing=strike
		GetTags
//		printf <swing>  	
	WaitAnimFinished
	Goto Baseball_ready
endscript	 

Script Baseball_abort_script
	Goto SkaterInit
endscript		 

*/