-- sfpemit.ms
-- Screen Facing Poly Emit script generation script

nd = nsGetNode()
pos = nsGetPos nd
mode = nsGet "SFP_Effect"

nsOpen()
nsOutNCR "setpos pos=("
nsOutNCR (pos.x as String)
nsOutNCR ","
nsOutNCR (pos.y as String)
nsOutNCR ","
nsOutNCR ((-pos.z) as String)
nsOut ")"

width = nsGetWidth nd
height = nsGetHeight nd
nsOutNCR "setparticlesize sw="
nsOutNCR (width as String)
nsOutNCR " sh="
nsOut (height as String)

fn DumpColor corner color alph =
(
	nsOutNCR "setcolor corner="
	nsOutNCR ((corner as Integer) as String)
	nsOutNCR " er="
	nsOutNCR ((color.r as Integer) as String)
	nsOutNCR " eg="
	nsOutNCR ((color.g as Integer) as String)
	nsOutNCR " eb="
	nsOutNCR ((color.b as Integer) as String)
	nsOutNCR " ea="
	nsOut ((alph as Integer) as String)
)

if (mode == "Flat") then
(
	color = nsGet "Color"
	alph = nsGet "Alpha"
	DumpColor 0 color alph
)

else if (mode == "Shaded") then
(
	for i = 0 to 3 do
	(
		color = nsGet ("Corner" + (i as String))
		alph = nsGet ("Corner" + (i as String) + "A")
		DumpColor i color alph
	)
)

else if (mode == "Smooth") then
(
	color = nsGet "ColorInside"
	alph = nsGet "ColorInsideA"
	DumpColor 0 color alph
	
	color = nsGet "ColorOutside"
	alph = nsGet "ColorOutsideA"
	DumpColor 1 color alph
)

else if (mode == "Glow" or 
         mode == "Star" or
		 mode == "SmoothStar") then
(
	color = nsGet "Center"
	alph = nsGet "CenterA"
	DumpColor 0 color alph
	
	color = nsGet "Mid"
	alph = nsGet "MidA"
	DumpColor 1 color alph
	
	color = nsGet "Out"
	alph = nsGet "OutA"
	DumpColor 2 color alph
)

else if (mode == "Line" or
         mode == "Ribbon") then
(
	color = nsGet "Start"
	alph = nsGet "StartA"
	DumpColor 0 color alph
	
	color = nsGet "End"
	alph = nsGet "EndA"
	DumpColor 1 color alph	
)

else if (mode == "RibbonTrail") then
(
	color = nsGet "Color"
	alph = nsGet "Alpha"
	DumpColor 0 color alph
	
	nColors = nsGetColorSize "History"
	
	for i = 0 to nColors-1 do
	(
		color = nsGetColor "History" i
		cnum = i+1
		DumpColor cnum color color.a
	)
)

else if (mode == "SmoothRibbon" or
         mode == "GlowRibbonTrail") then
(
	color = nsGet "Color0"
	alph = nsGet "Alpha0"
	DumpColor 0 color alph
	
	color = nsGet "Color1"
	alph = nsGet "Alpha1"
	DumpColor 1 color alph
	
	color = nsGet "Color2"
	alph = nsGet "Alpha2"
	DumpColor 2 color alph
	
	color = nsGet "Color3"
	alph = nsGet "Alpha3"
	DumpColor 3 color alph
	
	nColors = nsGetColorSize "History"
	
	for i = 0 to nColors-1 do
	(
		color = nsGetColor "History" i
		cnum = i+4
		DumpColor cnum color color.a
	)
)

nsOut "emit num=1"

nsClose()
