-- SFPType
nd = nsGetNode()
LevelName = nsGetLevel()
type = nsGet "SFP_Effect"
emitscript = nsGetEmitScript()
texname = nsGetTexName nd
if (texname == undefined) then ( texname = "" )

nsOpen (LevelName + "SFPLoad")
if (texname != "") then
(
	nsOutOnce ("LoadSFPTexture levels/" + LevelName + "/sfp/" + texname)
)
nsClose()

nsOpen (LevelName + "SFPUnload")
if (texname != "") then
(
	nsOutOnce ("UnloadSFPTexture levels/" + LevelName + "/sfp/" + texname)
)
nsClose()

-- Dump out the script for this particular particle system
-- Emitscripts are generated through sfpemit.ms
nsOpen()

maxPart = nsGetMaxParticles()

if (nd.material != undefined) then
(
	alph = nsGetFixedAlpha nd.material 1
	BlendMode = nsGetBlendMode nd.material 1
)
else
(
	alph = ""
	BlendMode = ""
)

if (nd.material == undefined) then (matname = "") else (matname = nd.material.name)
pname = nsReplace (matname + "_" + type) " " "_"
if (pname == undefined) then (pname = "")

if (maxPart == -1) then (maxPart = 1)

nsOutNCR ("CreateParticleSystem name=" + pname + " max=" + maxPart as String)

if (BlendMode != "") then
(
	nsOutNCR (" blendmode=" + BlendMode  + " fix=" + alph as String + " type=" + type + " texture=" + texname)
)

if (emitscript != "") then
(
	nsOutNCR (" emitscript=" + emitscript)
)

if (type == "Glow" or
    type == "Star" or
	type == "SmoothStar" ) then
(
	seg = nsGet "Segments"
	nsOutNCR " segments="
	nsOutNCR (seg as String)

	split = nsGet "Split"
	nsOutNCR " split="
	nsOutNCR (split as String)
)

if (type == "Line" or
    type == "Ribbon") then
(
	hist = nsGet "History"
	nsOutNCR " history="
	nsOutNCR (hist as String)
)

if (type == "SmoothRibbon" or
    type == "RibbonTrial") then
(
	hist = nsGetColorSize "History"
	nsOutNCR " history="
	nsOutNCR (hist as String)
)

if (type == "GlowRibbonTrail") then
(
	hist = nsGetColorSize "History"
	nsOutNCR " history="
	nsOutNCR (hist as String)
	
	seg = nsGet "Segments"
	nsOutNCR " segments="
	nsOutNCR (seg as String)
	
	split = nsGet "Split"
	nsOutNCR " split="
	nsOutNCR (split as String)
)

nsOut ""

nsClose()
