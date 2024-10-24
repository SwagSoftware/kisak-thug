This is a port of [thug1](https://github.com/thug1src/thug) to PC.

### Lore
The Tony Hawk Underground 1 source code has been publicly available for about 10-12 years. This however does not include the PC port that was developed by Beenox and released later. The port is quite rare, was only released in Australia/NZ, and did not sell well.

Therefore the source code only has PS2/Gamecube/XBox code.

### What is this Project
A port of the Source code To Windows(x86) + Dx9 + SDL(Input).

Like the PC/MAC ports, it's based on the XBox port, but changed to DirectX9.

This was initially done with an IDA-minded approach to be 1:1 as possible.


### How to build
1) make a `build` folder and open a terminal inside it
2) Run `CMAKE .. -G"Visual Studio 17 2022" -DCMAKE_GENERATOR_PLATFORM=WIN32` (This 32bit generator has to be on the cmdline, there is a bug in CMake+MSVC)
3) Open the resulting .sln in Visual Studio and build all.
4) Move your `Data/` Folder next to the .exe along with SDL2.dll from the SDL folder
5) You can now run the game.

### Status
#### Done
- Window Handling
- Dx9 (Not complete)
- SDL Gamepad Input
- Sound ( [TONYRE](https://github.com/cuckydev/TONYRE) )
- Music ( [TONYRE](https://github.com/cuckydev/TONYRE) )


#### TODO
- Fix NetPlay
- Unstub Additional Gfx features (particles, billboards, ...)
- Fix resolution code to not be hard-stuck at 640x480
- SDL Windowing Code
- Anything marked with "KISAKTODO" in the src
- Rip out music crc code and implement custom soundtracks
- XAUDIO environmental FX
- Fix consistent Texture Garbling
- See if we can adapt a bink decoder (The music and FMV's are in bink format)

### Extra

After I was already finished with the port and able to load into New Jersey, I found [TONYRE](https://github.com/cuckydev/TONYRE) This is another wip sourceport that I didn't know about that - seems to have propped up about a year ago(kisak-thug was long in the planning stage). However, his is quite different and doesn't discourage me from continuing the project. Blackops adapted their mini+SDL audio code, which we're using for now.

