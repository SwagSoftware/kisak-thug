This is a port of [thug1](https://github.com/thug1src/thug) to PC.

### Lore
The Tony Hawk Underground 1 source code has been publicly available for about 10-12 years. This however does not include the PC port that was developed by Beenox and released later. The port is quite rare, was only released in Australia, and did not sell well.

Therefore the source code only has PS2/Gamecube/XBox code.

### What is this Project
A port of the Source code To Windows(x86) + Dx9 + SDL(Input).

Like the PC/MAC ports, it's based on the XBox port, but changed to DirectX9.

This was done mainly with an IDA-minded approach to be 1:1 as possible.

### Status
#### Done
- Window Handling
- Dx9 (Minus Ped Models)
- SDL Gamepad Input

#### TODO
- CMake Project
- Audio SFX & Music
- Fix Ped Models not attempting to load in
- Fix NetPlay
- Unstub Additional Gfx features (particles, billboards, ...)
- Fix resolution code to not be hard-stuck at 640x480
- SDL Windowing Code
- Anything marked with "KISAKTODO" in the src

### Extra

I didn't realize there were others making a sourceport and found [TONYRE](https://github.com/cuckydev/TONYRE) that's further along. He seems to have pretty good tastes that would align with what I'd do.

Kisak-thug: [Video](https://streamable.com/n8t1dj)

(I don't know why the ped models don't attempt to load in, will probably fix that eventually).

### Windows Rant

Dx9 state debugging is very toxic in modern windows. 

![image](https://github.com/user-attachments/assets/094cbab7-4d2f-42ed-a858-2091e0dc74a3)

It's literally disabled in > Windows 7. 

If you mess anything up - Then you'll just get a nice driver crash with no help. NVIDIA does not publish symbols for their usermode drivers. (AMD I think does, but I've had 3 AMD GPU's fry on me in the past 3 years, NVIDIA hardware is just much better.)

(I had to debug this for a few days)
![image](https://github.com/user-attachments/assets/e01eac16-c9b0-4d5b-abf3-6f2e14e20ae2)

and it's threaded, so it won't actually crash at the right period in time. Turns out one of my pixel shader pointers was set to D3D assembly instead(whoops).

Then there's the state machine problem. My very first load-in looked like this: [Video](https://streamable.com/v55gwv)

Even fixing small things like the text alpha transparency requires a lot of raw state lookup. 
I use apitrace for this, it's one of the only tools that will interface with Dx9. Old versions of NSIGHT refuse to install on newer hardware, Newer tools like Renderdoc won't support it, etc. 
I am not a seasoned graphics programmer that can tell what D3DRS is wrong just by seeing a render.

Anyway, this project was fun but I think it would make more sense to combine efforts with TONYRE in the future.

