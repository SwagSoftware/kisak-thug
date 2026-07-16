-- MAXScript code to generate templates for particle system scripts
-- aml 5-6-01

nd = nsGetNode()

--nsOpen "ActivateAllParticleSystems"
--------------------------------------------- Start
--if (not nsGet "CreatedAtStart" == true) then
--(
--	nsOutNCR "// "
--)
--
--nsOutNCR "CreateParticleSystem name=Particle_UnNamed"
--
--if (nsGet "EmitScript" == "[UseParams]") then
--(
--	nsOutNCR (" emitscript=EmitScript" + nd.name)
--)
--else
--(
--	nsOutNCR " emitscript=<EmitScript>"
--)
--
--if (nsGet "UpdateScript" != "[None]" AND nsGet "UpdateScript" != "") then
--(
--	nsOutNCR " updatescript=<UpdateScript>"
--)
--
-- Strip texture extension
--tex = nsGet "Texture"
--pos = findstring tex "."
--if (pos != undefined) then
--(
--	tex = substring tex 1 (pos-1)
--)
--
--nsOutNCR (" texture=" + tex + " blendmode=<BlendMode> fix=<FixedAlpha>")
--
--if (not nsGet "Params" == "[None]") then
--(
--	nsOut " params=<Params>"
--)
--else
--(
--	nsOut ""
--)
--
--------------------------------------------- End
--nsClose()

nsOpen "LoadAllParticleTextures"
tex = nsGet "Texture"
pos = findstring tex "."
if (pos != undefined) then
(
	tex = substring tex 1 (pos-1)
)
nsOutOnce  ("LoadParticleTexture \"particles\\" + tex + "\"")

nsClose()

-- Create the emit script
-- We shouldn't generate a script if an alternate EmitScript is specified

if (nsGet "EmitScript" == "[UseParams]") then
(
	nsOpen("EmitScript" + nd.name)
	nsOut ("// Auto generated Emitter Script for " + nd.name)
	
	-- Write out the node's position
	pos  = nsGetPos(nd)
	posX = nsConvVal(pos.x) as String
	posY = nsConvVal(pos.y) as String
	posZ = nsConvVal(-pos.z) as String
	nsOutNCR ("setpos pos=")
	nsOut    ("(" + posX + "," + posY + "," + posZ + ")")

	nsOut ("setlife max=" + nsGet "LifetimeMax" as String)
	nsOut ("setanglespread spread=" + nsGet "AngleSpread" as String)
	nsOut ("setspeedrange min=" + nsGet "SpeedMin" as String + " max=" + nsGet "SpeedMax" as String)
	nsOut ("setemitrange width=" + nsGet "EmitWidth" as String + " height=" + nsGet "EmitHeight" as String)
	nsOutNCR "setforce force=("
	nsOutNCR (nsGet "Force_X" as String + ",")
	nsOutNCR (nsGet "Force_Y" as String + ",")
	nsOut    (nsGet "Force_Z" as String + ")")
	nsOutNCR "setemittarget target=("
	nsOutNCR (nsGet "EmitTarget_X" as String + ",")
	nsOutNCR (nsGet "EmitTarget_Y" as String + ",")
	nsOut    (nsGet "EmitTarget_Z" as String + ")")
	nsOut ("setparticlesize sw=" + nsGet "StartWidth" as String + " ew=" + nsGet "EndWidth" as String)

	c  = nsGet "StartRGB"
	ca = nsGet "StartAlpha"
	r  = (c.r as Integer) as String
	g  = (c.g as Integer) as String
	b  = (c.b as Integer) as String
	a  = (ca as Integer) as String
	nsOutNCR ("setcolor sr=" + r + " sg=" + g + " sb=" + b + " sa=" + a)
	if (nsGet "UseMidTime" == true) then
	(
		c  = nsGet "MidRGB"
		ca = nsGet "MidAlpha"
		r  = (c.r as Integer) as String
		g  = (c.g as Integer) as String
		b  = (c.b as Integer) as String
		a  = (ca as Integer) as String
		nsOutNCR (" mr=" + r + " mg=" + g + " mb=" + b + " ma=" + a)
	)
	c  = nsGet "EndRGB"
	ca  = nsGet "EndAlpha"
	r  = (c.r as Integer) as String
	g  = (c.g as Integer) as String
	b  = (c.b as Integer) as String
	a  = (ca as Integer) as String
	nsOutNCR (" er=" + r + " eg=" + g + " eb=" + b + " ea=" + a)
	if (nsGet "UseMidTime" == true) then
	(
		nsOut (" midtime=" + (nsGet "MidTime" as Integer) as String)
	)
	else
	(
		nsOut ""
	)
	
	nsOut ("Buildpath " as String)
	
	if (nsGet "UsePulseEmit" == true) then
	(
		nsOut "begin"
		if (nsGet "RandomEmitRate" == true) then
			(
				rndA = nsGetElement (nsGet "EmitRate1Rnd") 0
				rndB = nsGetElement (nsGet "EmitRate1Rnd") 1
				nsOut ("  emitrate rate=randomrange (" + rndA + "," + rndB + ")")
			)
			else
			(
				nsOut ("  emitrate rate=" + (nsGet "EmitRate1" as Integer) as String)
			)
		
		if (nsGet "RandomEmitWait" == true) then
			(
				rndA = nsGetElement (nsGet "EmitRate1DelayRnd") 0
				rndB = nsGetElement (nsGet "EmitRate1DelayRnd") 1
				nsOut ("  wait randomrange (" + rndA + "," + rndB + ") frames") 
			)
			else
			(
				nsOut ("  wait " + (nsGet "EmitRate1Delay" as Integer) as String + " frames")
			)
		
		if (nsGet "RandomEmitRate" == true) then
			(
				rndA = nsGetElement (nsGet "EmitRate2Rnd") 0
				rndB = nsGetElement (nsGet "EmitRate2Rnd") 1
				nsOut ("  emitrate rate=randomrange (" + rndA + "," + rndB + ")")
			)
			else
			(
				nsOut ("  emitrate rate=" + (nsGet "EmitRate2" as Integer) as String)
			)
		
		if (nsGet "RandomEmitWait" == true) then
			(
				rndA = nsGetElement (nsGet "EmitRate2DelayRnd") 0
				rndB = nsGetElement (nsGet "EmitRate2DelayRnd") 1
				nsOut ("  wait randomrange (" + rndA + "," + rndB + ") frames") 
			)
			else
			(
				nsOut ("  wait " + (nsGet "EmitRate2Delay" as Integer) as String + " frames")
			)
		nsOut "repeat"
	)
	else
	(
		nsOut ("emitrate rate=" + (nsGet "EmitRate" as Integer) as String)
	)
	
	nsClose()
)

-- Create the trigger script for the node we're being ran on
nsOpen()
nsOut "// Particle system creation script template v1"
nsOut ("// Node: " + nd.name)

nsOut "if not ParticleExists name=Particle_UnNamed"

nsOutNCR "CreateParticleSystem name=Particle_UnNamed"

if (nsGet "EmitScript" == "[UseParams]") then
(
	nsOutNCR (" emitscript=EmitScript" + nd.name)
)
else
(
	nsOutNCR " emitscript=<EmitScript>"
)

if (nsGet "UpdateScript" != "[None]" AND nsGet "UpdateScript" != "") then
(
	nsOutNCR " updatescript=<UpdateScript>"
)

-- Compute a default value for the Max Particles setting
-- Should only apply 

-- Strip texture extension
tex = nsGet "Texture"
pos = findstring tex "."
if (pos != undefined) then
(
	tex = substring tex 1 (pos-1)
)

nsOutNCR (" texture=" + tex + " blendmode=<BlendMode> fix=<FixedAlpha>")

if (nsGet "Params" != "") then
(
	nsOutNCR " params=<Params>"
)

nsOutNCR " type=<Type>"

nsOut " MaxStreams=<MaxStreams>"

--else
--(
--	nsOut ""
--)

nsOut "endif"

nsClose()
