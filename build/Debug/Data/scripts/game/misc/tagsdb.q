// \skate5\code\sk\scripting\cfuncs.cpp begin
// @DOC cfuncs
// @module cfuncs | None
// @subindex Scripting Database
// @index script | cfuncs
// @module cfuncs | None
// @subindex Scripting Database
// @index script | cfuncs


// @script | Wait | Waits for a period of time, where the time can be specified in various units. <nl>
// For example:  Wait 1200       By default, the units are milliseconds, so
// this will wait for 1.2 seconds <nl>
// Wait 2.1 seconds     This will wait for 2.1 seconds. <nl>
// Wait 60 frames       This will wait for 60 sixtieths of a second, regardless of the framerate. <nl>
// Wait 60 gameframes       This will wait for exactly 60 logic calls,
// so the actual time it takes will depend on the current framerate. <nl>
// In all the above, the units do not have to be plural, so one could type
// ‘Wait 1 second’ instead of ‘Wait 1 seconds’
// @parm float |  | number of units to wait
// @flag seconds | measure time in seconds
// @flag frames | measure time in frames
// @flag gameframes | measure time in gameframes


// @script | IsZero | added for testing if statements.  may be useful


// @script bool | CastToInteger | If a parameter with the passed name exists and is a float,
// this will cast it down to an integer.
// So for example, if x=3.141, after calling CastToInteger x, x will be 3.
// @uparmopt name | The name of the parameter to be cast down


// @script bool | IntegerEquals | Returns true if the two values equal
// @parmopt int | a | 1 | First value
// @parmopt int | b | 1 | Second value


// @script bool | ChecksumEquals | Returns true if two checksums are equal
// @parmopt name | a | 0 (checksum value) | First name
// @parmopt name | b | 0 (checksum value) | Second name


// @script bool | StringEquals | Returns true if two strings are equal
// @parm string | a | First string
// @parm string | b | Secnond string


// @script bool | ArrayContains | Returns true if the array contains an
// element equal to the variable. <nl>
// Example:  ArrayContains array=some_int_array contains=4 <nl>
// ArrayContains array=some_string_array contains="some_string"
// @parm array | array | The array to search
// @parm | contains | The element to search for.  Must match array type


// @script | GetArraySize | returns the number of elements in the specified structure
// @parm | array_size | return value for array size


// @script | SetArrayElement | Changes the value of an element of an array.
// @parm name | ArrayName | The name of the array in the current script's parameters whose
// value is to be changed.
// @parm int | Index | The index of the array element whose value is to be changed.
// @parm int | NewValue | The new value for the element. The type of this value must match the
// type of the array, so it is not necessarily an integer. If the type does not match that of
// the array it will assert.


// @script | AddParams | appends the given structure to the list of params
// @uparmopt {} | structure to append to params


// @script | RemoveComponent | removes a component from the script's list of params
// @uparm name | name of component to remove


// @script | KenTest1 | old test of ken's


// @script | KenTest2 | old test of Ken's


// @script | RemoveParameter | Removes the parameter with the given name. If no such parameter
// exists, it will do nothing.
// @uparmopt name | The name of the parameter to be removed


// @script | GetRandomValue | Chooses a random number in a specified range. The returned value can
// be selected to be either an integer or a floating point value.
// @parmopt name | name | 0 | The name to be given to the random value parameter. For example,
// name=foo will make the random number be assigned to a parameter called foo.
// @parmopt float | a | 0.0 | The first value in the range.
// @parmopt float | b | 0.0 | The second value in the range. The first value does not have to be smaller than the second.
// @parmopt int | Resolution | 1000 | The number of possible floating point values that could be returned.
// For example, if the range is a=1, b=2 and the resolution is set to 3, it will return either 1, 1.5 or 2
// @flag Integer | Return an integer value in the given range, inclusive of the end values.
// For example, if the range is a=1, b=3 it will return either 1, 2 or 3. Note that a and b need to be
// integers instead of floats in this case.


// @script | SetConfig | Allows various things in the config module to be changed at runtime.
// @parmopt name | Language | | Can be one of English, French or German
// @flag CD | Use CD for file loading
// @flag NotCD | Use host for file loading
// @flag GotExtraMemory | Switch on use of extra memory
// @flag NoExtraMemory | Switch off use of extra memory
// @flag Pal | Be in PAL mode
// @flag NTSC | Be in NTSC mode
// @parmopt int | FrameRate | | Frame rate to use, 50 or 60


// @script | PrintConfig | Prints the current system configuration, whether it is CD, PAL, etc.


// @script | German | Returns true if the current language is German


// @script | French | Returns true if the current language is French


// @script | English | Returns true if the current language is English


// @script | CustomSkaterFilenameDefined | Doesn't appear to be supported


// @script | GetCustomSkaterFilename | Gets the filename for the current CAS


// @script | SetCustomSkaterFilename | Sets the filename for the current CAS


// @script | EnableEvent | Enables event
// @parm name | id |
// @parm name | EventType |


// @script | DisableEvent | Disables event
// @parm name | id |
// @parm name | EventType |


// @script | EditingPark | Returns true of we're in the park editor


// @script | GetParkName | Gets the current park name


// @script | SetParkName | Sets the current park name


// @script | ParkEditorThemeWasSwitched | Check if theme changed


// @script | MenuIsShown | Checks array of names (pArray) is shown


// @script | SetFrontEndActive |


// @script | SetFrontEndInactive |


// @script | CreateDialogBox | Creates a dialog box with the specified parameters
// @parmopt string | Message | "No Message" | Message to show
// @flag Yes | pass in to create "yes" option
// @flag No | pass in to create "no" option
// @flag Ok | pass in to create "Ok" option
// @flag Cancel | pass in to create "Cancel" option
// @parmopt name | Default | Ok | the default option for this dialog
// @parmopt name | OkScript | | The name of the script to run if "Ok" is chosen
// @parmopt name | CancelScript | | The name of the script to run if "Cancel" is chosen
// @parmopt name | YesScript | | The name of the script to run if "Yes" is chosen
// @parmopt name | NoScript | | The name of the script to run if "No" is chosen


// @script | ForEachIn | For each member of the array, run the specified script
// @parm name | Do | The name of the script to run
// @uparm [] | The array on which to run
// @parmopt structure | Params | | any extra parameters that need to be
// merged onto each of those in the array


// @script | SizeOf |
// Puts the size (num elements in) of the passed array into a parameter called ArraySize
// @uparm [] | The array of which we're finding the size


// @script | GetElement | Retrieves the array element pointed to by "Index"
// and places it in the param called "Element"
// @uparm [] | the array
// @parmopt int | Index | 0 | The index value of the array element


// @script | GetNextArrayElement | Increments the value in Index and uses it to retrieve that
// element from the array, and puts it in Element
// If no Index parameter exists, it will retrieve the first element of the array, and
// create Index and set it to zero.
// If Index goes off the end of the array, it will remove the Index parameter and
// any existing Element parameter, and return false.
// Hence calling GetNextArrayElement repeatedly will cycle through the array elements.
// @uparm [] | the array


// @script | GetRandomArrayElement | Chooses a random element of the passed array, and
// puts it in Element. It will put the index of the chosen element into a parameter called Index.
// If the array is empty, it will remove any existing Element and Index parameter and return false.
// @uparm [] | the array


// @script | PermuteArray | Creates a new array equal to the passed array with its elements
// randomly permuted. The new array is put into a parameter named using the passed NewArrayName.
// @parm array | Array | The source array
// @parm name | NewArrayName | The name to be given to the new array parameter.
// @flag MakeNewFirstDifferFromOldLast | Makes the first element of the new array definitely
// be different from the old last element. This is so that the old permutation can be
// concatenated with the new and no consecutive elements will be the same.
// Could be useful for playing songs in a random order with no repeats.
// @flag PermuteSource | If this flag is specified then it will be the source array itself
// that will get permuted, no new array will get created.
// So the NewArrayName parameter is not required in this case, it will be ignored.


// @script | ApplyChangeGamma | This gets called whenever one of
// the color values in the gamma menu changes.
// Called from script in gamemenu.q


// @script | GotParam | Checks if the script was passed the specified parameter
// @uparm name | The name of the param to check for


// @script | ControllerDeboune |
// For example: <nl>
// Debounce X time = 2.0 <nl>
// This will ignore the X button until either the time has elapsed,
// or the X button has been released and subsequently re-pressed. <nl>
// This prevents the press of X from carrying over from one screen to
// the next, and removes the need to have a delay, whilst still allowing
// the user to actively X past things.
// @uparm name | the button
// @parmopt float | time | 1.0 |


// @script | ControllerPressed | returns true if the specified button is pressed
// @uparm name | the button to check
// @uparmopt 0 | controller index


// @script | GetAnalogueInfo | Reads the analogue sticks, ans returns the floats LeftX, LeftY, RightX and RightY.
// These each range from -1 to 1.
// @parmopt int | Controller | 0 | Controller index


// @script | SetSfxVolume | SetSfxVolume [100] <nl>
// Param: volumeLevel <nl>
// range: 0 to 100 (the main mixing volume, affecting all soundfx) <nl>
// default: 100 <nl> <nl>
// Notes: the volume is set to 100 on startup, and can only be modified with this command
// @uparmopt 100.0 | volume


// @script | SetMusicVolume |
// @uparmopt 100.0 | volume level


// @script | StopMusic |


// @script | PauseMusic |


// @script | PauseStream |
// @uparm 1 | 0 to unpause, 1 to pause


// @script | LoadMusicHeader | parameter is name of header/wad file (minus extension)
// Do this once on startup.
// Example:  LoadMusicHeader "music\music"
// @uparm "string" | name of header/wad file


// @script | LoadStreamHeader |
// @uparm "string" | name of header/wad file (minus extension)


// @script | StreamIsAvailable | only available in the skateshop
// @parm int | | which stream


// @script | AddMusicTrack | adds track to list - plays randomly during game <nl>
// Note: The songs that go into the data/music folder (and are added to the
// CD in them 'music' directory) as well as the ambient tracks in data/ambient
// (and in 'ambient' directory on CD) should have a filename of 8 characters
// or less, as otherwise the names get converted upon building a CD
// @uparmopt "string" | filename in quotes ( .wav file in data/music )
// @uparmopt name | filename
// @flag flag_perm | to add the song to the permanent soundtrack list on startup...
// otherwise track is a level-specific ambient type. <nl>


// @script | ChangeTrackState | Disables or enables one of the permanent music tracks.
// @uparmopt 0 | The index of the track
// @flag Off | Disable the specified track. If omitted, it will enable the track.


// @script | TrackEnabled | Returns true if the specified track in the permanent track list is enabled.
// @uparmopt 0 | The index of the track


// @script | ClearMusicTrackList |
// @flag FLAG_PERM | optionally add FLAG_PERM to clear
// the permanent list, otherwise clear level specific list


// @script | SkipMusicTrack |
// Play next track in the list ( or if in random mode, pick another random track )


// @script | SetMusicMode |
// Play music or ambient sounds?
// @uparm 1 | 1 for music on, 0 for music off/ ambience on


// @script | SetRandomMode |
// Play tracks in Random mode or play tracks in order.


// @script | PlayMovie | this function is no longer supported
// @uparm "string" | movie name


// @script | UnloadAnim |
// @parm name | descChecksum | asset name
// @parmopt name | refChecksum | 0 | skeleton name


// @script | LoadAsset |
// @parm string | name | asset name


// @script | LoadAnim | loads the specified animation
// @parm string | name | the file name of the animation
// @parm string | desc | description
// @flag async | load animation asynchronously
// returns true if a reference is generated.  false if a reference already exists


// @script | LoadSkeleton | loads the specified skeleton
// @parm string | name | the file name of the skeleton
// @parm string | desc | description


// @script | LoadSound |
// @uparm "string" | The name of the sound file
// @parmopt float | pitch | 100.0 |
// @parmopt float | volume | 100.0 |
// @parmopt float | dropoff | 0.0 |
// @flag PosUpdateWithDoppler | positional update with doppler


// @script | PlayStream |
// @uparm name | stream name
// @parmopt float | volume | 100.0 | volume in percent
// @parmopt float | pitch | 100.0 | pitch value
// @parmopt int | priority | 50 | priority; higher priority streams can stop lower priority streams.
// @parmopt name | id | 0 | control ID (used instead of stream name for script control purposes)


// @script | StopStream | stops current stream from playing
// @uparm name | stream name (or control ID, if one was supplied with PlayStream)


// @script | PlayTrack |
// @uparm "string" | filename in quotes (no extension, file should be a
// .wav file in data/music)
// @uparmopt 0 | The index of the track. For use if the name is not known.


// @script | PlayMusicStream | Plays a stereo stream through the music channel
// @uparm name | music stream name (in music.wad file)
// @parmopt float | volume | -1.0 | volume in percent; negative value uses music volume


// @script | PlaySound |
// @uparm name | sound name
// @parmopt float | volume | 100.0 |
// @parmopt float | pitch | 100.0 |


// @script | SetSfxReverb | 1st param: reverbLevel <nl>
// default 0 (will turn reverb off) <nl>
// range: 0 to 100 percent <nl>
// 2nd param: mode (see possible values in reverb.q) <nl>
// default is 0 (first value in reverb.q) <nl> <nl>
// Notes: 2nd param (mode) only matters if 1st param (reverbLevel) is
// above 0. On a script Cleanup command, the global reverb is turned off.
// @uparmopt 0.0 | Reverb (cannot be greater than 100)
// @uparmopt name | reverb mode


// @script | SetSfxDropoff | SetSfxDropoff [100] <nl>
// Param: dropoff distance (in feet) <nl>
// range: anything above zero <nl>
// default is 100 <nl> <nl>
// Notes: only affects positional soundfx. Also, the global
// dropoff distance is set back to 100 (or whatever you want me
// to set it to) on a script Cleanup command. That way, if somebody
// forgets to call SetSfxDropoff at the beginning of their level, it
// will always be this default instead of staying at whatever level
// the previously loaded level had it set to
// @uparm 1.0 | Dropoff distance


// @script bool | FakeLights | Adjust lighting for a node-based SceneLight.
// @parm name | id | The name of the node, if only one needs adjusting.
// @parm name | Prefix | The prefix of a set of nodes, if lots need adjusting.
// @parmopt integer | Time | 0 | The time period, in frames, over which the execution of the command
// will be spread so as not to use up too much CPU time in one frame.
// @parmopt float | inner_radius | none | The new radius of the light in inches
// @parmopt float | outer_radius | none | The new radius of the light in inches
// @parmopt float | percent | none | The new intensity percentage
// @parmopt integer | red | none | The new red component of the light color (also green, blue)


// @script | CenterCamera |  Center the camera on the rendered geometry, or an individual object
// @parmopt float | scale | 0.9 |
// @parmopt float | X | -45 | Angle to rotate about X
// @parmopt float | Y | 45 | Angle to rotate about Y
// @parmopt float | Z | 0 | Angle to rotate about X
// @parmopt	checksum | id | 0 | checksum of and individual object to center on
// Notes:  The Camera will be centered on the center of the bounding box
// of all exported geometry.  It will be moved back by the size of the diagonal
// of the bounding box, and rotated by the X,Y,Z angles


// @script | LoadTerrainSounds | Loads all the associated sounds for a terrain type of a level.
// @parm name | terrain | Name of terrain


// @script | Goto | jumps to the specified script
// @Uparm name | The name of the script
// @parmopt structure | Params | | parameter list to pass to the new script


// @script | GotoPreserveParams | This has the same effect as goto,
// except all the parameters that were passed to the current script
// will get passed to the new script
// @Uparm name | The name of the script to goto
// @parmopt structure | Params | | additional parameters to pass to script


// @script | GotoRandomScript | This will abort the current script
// and jump to a random one of the scripts specified in an array. <nl>
// For example: <nl>
// GotoRandomScript [ScriptA ScriptB ScriptC]
// @uparm [] | Array of scripts to choose from


// @script | PrintStruct | Prints the contents of the passed structure
// @uparm structure | The structure to print


// @script | FormatText | Fills in any % characters in the passed format string with the passed
// parameters, and assigns the new string to a parameter with the given name.
// For example:
// FormatText TextName=Line1 "Hello %f %b" f="Mum" b=23
// will create the string "Hello Mum 23" and assign it to Line1
// The name following the % must consist of a single character. This is to allow formatting to
// be used to append strings, eg "%sBlaa"
// If two % signs are used, then the name that follows may consist of more than one char,
// eg "%%foo blaa"
//
// Currently supported data types are integer, float, string, local string, vector and pair.
// If any of the parameters are missing it will give an error message and will not create the
// final string. It will not assert though.
//
// @parmopt name | TextName | | The name to be given to the new formatted string
// @parmopt name | ChecksumName | | If this is specified, the checksum of the formatted text
// will be calculated and added using ChecksumName as its name.
// @uparm string | The source format string
// @flag UseCommas | This will make it print any integer using commas to separate thousands for clarity.


// @script | Printf | Printf "Default printf text" Prints the passed
// text onto the EE0 output on the target manager.
// Printf can will also print the checksum name of any passed checksum, for example:
// printf blaa    // Will print: [Checksum] blaa
// @uparmopt "text" | some text to print
// @uparmopt 1 | an int to print
// @uparmopt name | checksum to print
// @flag UseCommas | This will make it print any integer using commas to separate thousands for clarity.


// @script | ScriptAssert |


// @script | SetHackFlag | Sets special hackflag
// @uparmopt 1 | integer flag (1 or 0)


// @script | HackFlagIsSet | Returns current value of hackflag


// @script | PreloadModel | Preloads model
// Example: PreloadModel name="ModelName" or name="levels/skateshop/thps4board_01/thps4board_01.mdl"
// @parm string | name | The model name


// @script | LoadLevelGeometry | Loads a bsp file. Assumes the current
// directory is \skate3\data, so a valid string would be "levels\aus\aus.bsp".
// Can also have an optional "Sky="xxx.bsp" parameter for loading the
// sky dome with a level file. The Level and Sky parameters are optional,
// but you must have at least one of them (So you can load just a sky,
// or just a level, if you want).
// @parmopt string | Sky | | .bsp file for sky dome
// @parmopt string | Level | | .bsp file for level
// @parmopt string | Pre_set | | load assets from PRE file


// @script | Create | creates an object node
// @flag links | pass in to perform action to nodes by links
// @flag currentlinks | pass in to perform action to nodes by links
// @parmopt name | name | | The name of the node
// @parmopt name | prefix | | Create with a prefix specified


// @script | Kill | kills an object node
// @flag links | pass in to perform action to nodes by links
// @flag currentlinks | pass in to perform action to nodes by links
// @parmopt name | name | | The name of the node
// @parmopt name | prefix | | kill with a prefix specified


// @script | Visible | make object visible
// @flag links | pass in to perform action to nodes by links
// @flag currentlinks | pass in to perform action to nodes by links
// @parmopt name | name | | The name of the node
// @parmopt name | prefix | | act on objects with specified prefix


// @script | Invisible | make object invisible
// @flag links | pass in to perform action to nodes by links
// @flag currentlinks | pass in to perform action to nodes by links
// @parmopt name | name | | The name of the node
// @parmopt name | prefix | | act on objects with specified prefix


// @script | Shatter | Shatter an object
// @parmopt float | area | 288.0 | the subdivision area above which
// polys will be recursively subdivided. Be careful with this
// parameter - making it too small will cause the buffer to
// overflow and assert. The units are square inches <nl>
// The default value may change
// @parmopt float | variance | 0.0 | the amount the velocity
// of each shard can be (randomly) above the supplied velocity.
// So a value of 1.0 would mean a shard could travel at twice the supplied <nl>
// velocity <nl> The default value may change.
// @parmopt float | spread | 1.0 | determines the degree to which the
// shards will fly apart. The way I figure this is to take the center
// of the bounding box for the object, and then move backwards (spread
// * velocity). This position is then used to figure the start velocity
// for each shard. So the lower the spread value, the less the start
// point moves back, and the more the shards will fly apart. (I can
// draw a diagram if this isn't clear). <nl>
// The default value may change
// @parmopt float | life | 4.0 | how long the shatter atomic will exist for
// (seconds) <nl> The default value may change
// @parmopt | bounce | -10,000 | Default value may change
// @parmopt | scale | 1.0 | Scaling factor for the shards
// @flag use_skater_vel | Use skater velocity to determine
// if object should shatter
// @parm | vel_x | default velocity of shard on x-axis (in inches per second)
// @parm | vel_y | default velocity of shard on y-axis (in inches per second)
// @parm | vel_z | default velocity of shard on z-axis (in inches per second)


// @script | ParseNodeArray | Parses the loaded node array


// @script | LoadNodeArray | Will load node array from the file specified
// @uparm "string" | File name to load


// @script | ReLoadNodeArray | Will reload the last node array you loaded,
// without parsing it, and without deleting anything.
// Note, this will load directly from the .qb, so there is NO NEED to rebuild the .pre files.
// Using this command by itself could be used if you are just altering
// stuff like trigger scripts.  However, as it does not respawn anything,
// you have the potential to mess things up.  Give it a go though, you can
// always just do a Select+Circle to make sure.


// @script | SetBackgroundColor | Sets the background color. Each component
// is in the range 0-255.  The alpha value currently is not used.
// @parmopt int | r | 0 | Red component
// @parmopt int | g | 0 | Green component
// @parmopt int | b | 0 | Blue component
// @parmopt int | alpha | 0 | Alpha value


// @script | SetBSPAmbientColor | Sets the ambient color for the BSP
// (The environment, or the non-moving objects).
// NOTE:  This should be set to 0,0,0, as any other setting will result
// in much slowdown.  However, you can set it temporarily if you
// want to try out effects quickly.
// @parmopt int | r | 0 | Red component
// @parmopt int | g | 0 | Green component
// @parmopt int | b | 0 | Blue component
// @parmopt int | alpha | 0 | Alpha value


// @script | SetDFFAmbientColor | Sets the ambient color for the DFFs
// (The skater, cars and suchlike.).
// @parmopt int | r | 0 | Red component
// @parmopt int | g | 0 | Green component
// @parmopt int | b | 0 | Blue component
// @parmopt int | alpha | 0 | Alpha value


// @script | SetDFFDirectColor | Sets the directional light color
// for the DFFs (The skater, cars and suchlike.).   (Note:  temporary,
// until we get a better lighting setup).
// @parmopt int | r | 0 | Red component
// @parmopt int | g | 0 | Green component
// @parmopt int | b | 0 | Blue component
// @parmopt int | alpha | 0 | Alpha value


// @script | SetDynamicLightModulationFactor | A value of 0.0 means no
// effect (light/dark polys have no effect).
// A value of 1.0 means the maximum possible effect from light/dark polys
// These values will stay set until changed, so designers will want to
// put these in their level startup scripts.
// @parm float | value |
// @parmopt flag | ambient | |
// @parmopt bool | directional | |


// @script | SetClippingDistances | Sets the clipping distances in inches.
// “Near” should generally be left at 12, “Far” should be whatever is
// appropriate for your level. Example:
// SetClippingDistances Near=12 Far=8000
// @parm float | Near |
// @parm float | Far |


// @script | SetTrivialFarZClip | Sets the Z clipping distance
// SetTrivialFarZClip on        --- to turn it on
// SetTrivialFarZClip off       --- to turn it off
// @flag on | Pass this in to set the trivial Z clipping
// distance to true or false


// @script | EnableFog |


// @script | DisableFog |


// @script | SetFodDistance | Sets the "near" distance (in inches)
// at which fogging will begin.  (Polys closer than the near distance
// will not be fogged.  Beyond the near distance, they will become
// increasingly fogged until they reach maximum fogging at the far
// clip distance -- see SetClippingDistances).
// @parm float | distance | distance in inches


// @script | SetFogExponent | Sets the fog exponent.  The exponent
// value determines the "spread" of the fog, or how far out you
// must go before you reach maximum fog.  This component of fog
// will probably change in the near future.
// @parm float | exponent | fog exponent


// @script | SetFogColor | Sets the color that will be used for
// atmospheric fogging.  Color components are in the range 0-255.
// The alpha component is in the range of 0-128.
// @parmopt int | r | 255 | red component
// @parmopt int | g | 255 | green component
// @parmopt int | b | 255 | blue component
// @parmopt int | a | 128 | alpha component (opacity of fog)


// @script | SetUVWibbleParams | Sets the UV wibble parameters of a sector
// @parm name | sector | name of sector
// @parm float | u_vel   | u velocity
// @parm float | u_amp   | u amplitude
// @parm float | u_freq  | u frequency
// @parm float | u_phase | u phase
// @parm float | v_vel   | v velocity
// @parm float | v_amp   | v amplitude
// @parm float | v_freq  | v frequency
// @parm float | v_phase | v phase


// @script | EnableExplicitUVWibble | Enables explicit setting of the UV wibble offsets.
// To set the offsets, call SetUVWibbleOffsets.
// @parm name | sector | name of sector


// @script | DisableExplicitUVWibble | Disables explicit setting of the UV wibble offsets.
// @parm name | sector | name of sector


// @script | SetUVWibbleOffsets | Sets the UV wibble offsets explicitly
// @parm name | sector | name of sector
// @parm float | u_off | u offset
// @parm float | v_off | v offset


// @script | SetPreference | sets the prefs to those specified in
// the params structure
// @parm name | field | the field id
// @parm structure | params |


// @script | PreferenceEquals | returns true if the actual preference value
// for the given field equals the test value
// @parm name | field | the field id
// @parm name | equals | test value


// @script | ResetCamera |


// @script | SetVolumeFromValue | sets the volume according to the slider
// @uparm sfxvol | the volume to set (either sfxvol or cdvol)
// @parm name | id | the slider id used to change the volume


// @script | GetValueFromVolume |
// @uparm sfxvol | the volume you're interested in (either sfxvol or cdvol)


// @script | SetSliderValue |
// @parm name | id | the slider id
// @parm int | value | value to assign to slider


// @script | SetIconTexture |
// @parm name | id | menuelement
// @parm string | texture | the texture name


// @script | SetMovementVelocity | Sets the movement (translational)
// speed of the camera in the viewer. The number is in terms of inches per second.
// @parmopt float | vel | 400 | velocity in inches per second


// @script | SetRotateVelocity | Sets the rotational speed of the
// camera in the viewer. The number is in terms of degrees per second.
// @parmopt float | vel | 120 | Rotational speed in degrees per second


// @script | OnReload |
// This is a script function that doesn't do anything, it is just used to indicate what should
// happen if the script gets reloaded at runtime. It needs to be the first


// @script | ResetEngine | resets the engine


// @script | ToggleMetrics | Toggle metrics - use before ToggleMemMetrics


// @script | ToggleNetMetrics |


// @script | ToggleVRAMViewer | Toggle VRAM viewer


// @script | DumpVRAMUsage | Spits out a file detailing VRAM usage
// separately for all four contexts


// @script | ToggleImageViewer | Brings up the image viewer for
// viewing the files named in the array. Will not work if there
// is not enough memory or VRAM to hold the images. <nl>
// Example: ToggleImageViewer images=["image1.bmp" ...]
// @parm array | images | Array of image names.


// @script | ToggleLightViewer | Toggle the light viewer


// @script | debugrendermode | currently unsupported


// @script | debugtoggletextureupload | currently unsupported


// @script | debugtoggletexturedraw | currently unsupported


// @script | debugtogglepointdraw | currently unsupported


// @script | debugrendertest1 | old function?  returns true if mbr_nsDebugTest1
// (check cfuncs.cpp) is set


// @script | debugrendertest2 | old function?  returns true if mbr_nsDebugTest2
// (check cfuncs.cpp) is set


// @script | ToggleViewMode | Debugging function to toggle the camera mode,
// switching between normal, free with fixed skater, and free with moving skater
// usually triggers with Select+X (See buttonscripts.q)


// @script | SetViewMode | Debugging function to toggle the camera mode,
// switching between normal, free with fixed skater, and free with moving skater
// usually triggers with Select+X (See buttonscripts.q)


// @script | ToggleMetricItem | ToggleMetricItem will turn on or off
// individual items in the metric display.
// The “item” parameter is one of: <nl>
// METRIC_TIME <nl>
// METRIC_ARENAUSAGE <nl>
// METRIC_TOTALPOLYS <nl>
// METRIC_POLYSPROC <nl>
// METRIC_VERTS <nl>
// METRIC_RESOURCEALLOCS <nl>
// METRIC_TEXTUREUPLOADS <nl>
// METRIC_VU1 <nl>
// METRIC_DMA1 <nl>
// METRIC_DMA2 <nl>
// METRIC_VBLANKS <nl>
// METRIC_DRAWTIME <nl>
// METRIC_IHANDLERTIME <nl>
// METRIC_SKYCACHE <nl>
// METRIC_VIDEOMODE <nl>
// METRIC_VRAMUSAGE <nl>
// METRIC_MEMUSED <nl>
// METRIC_MEMFREE <nl>
// METRIC_REGIONINFO <nl>
// @parmopt int | item | 0 |


// @script | ToggleMemMetrics | This will replace the PS2 specific
// metrics with a list of the all the memory heaps, together with
// the amount of fragmentation, and the amount of free memory. Note,
// you have to use ToggleMetrics to actually see the metrics before
// using ToggleMemMetrics <nl>
// See the online doc for a full explanation of the various heaps


// @script | KillAllTextureSplats | Destroys all exisiting texture splats


// @script | Cleanup | Destroys current world, texture dictionaries, objects and railnodes.
// @flag preserve_skaters | Set this to preserve the skaters


// @script | LoadQB | Loads the specified QB file.
// @uparm "data\scripts\ken.qb" | File name of the qb to load
// @uparmopt LevelSpecific | Whether this is the level specific script file


// @script | UnloadQB | Unloads the specified QB file.
// @uparm "data\scripts\ken.qb" | File name of the qb to unload


// @script | ToggleRenderMode |


// @script | DebugRenderIgnore |
// @parmopt int | ignore_1 | 0 | bitmask of face flags where we ignore this face if bit is 1
// @parmopt int | ignore_0 | 0 | bitmask of face flags where we ignore this face if bit is 0


// @script | SetVRAMPackContext | Currently, there are 4 possible
// contexts, 0 through 3, with 0 being the default. There is a script
// command SetVRAMPackContext which takes a number between 0 and 3.
// All packing handled by the intelligent packer will then only pack
// in blocks with a matching context.
// @uparmopt 0 | context number (int)


// @script | ScreenShot | save a screenshot with specified filename
// @parmopt string | filename | screen | place to save screenshot


// @script | DumpShots | dump memory card screenshots to PC


// @script | IfDebugOn | returns true if debug on


// @script | IfDebugOff | returns true if debug off


// @script | CD | returns true if CD present


// @script | NotCD | returns true if CD not present


// @script | Bootstrap | returns true if this is a bootstrap demo


// @script | CasArtist | returns true if cas_artist int is set anywhere


// @script | NotCasArtist | returns true if cas_artist int is not set


// @script | ClearFlag | clears a flag
// @uparm 1 | the flag to clear
// @parmopt name | name | | the name of the object
// @parmopt string | prefix | | prefix value


// @script | SendFlag | Sets a specified flag in a named object. All
// objects have a set of 32 flags. For example: <nl>
// SendFlag 14 name =TRG_Car03 ; no quotes <nl>
// This will search all the objects until it finds the one called
// TRG_Car03, and will then set its flag 14. The flag value must
// be between 0 and 31 inclusive. To aid readability, names should
// be used for the flags, and there is a file flags.q where the
// definitions should be put
// @uparm 1 | the flag to set
// @parmopt name | name | | the name of the object
// @parmopt string | prefix | | prefix value


// @script | QueryFlag | you can query a flag on an object (or several
// objects if using links parameter or prefix = "Something_" parameter
// instead of name = Something_Unique). In the case of one object,
// QueryFlag will return true or false depending on if the flag is set
// or not. In the case of several objects, the function will return true
// if any of the objects specified have that flag set, false otherwise
// @uparm 1 | the flag to query
// @parmopt name | name | | the name of the object
// @parmopt string | prefix | | prefix value


// @script | SendException | use the SendException command in the same
// way you would use the SendFlag command:  you can specify name=whatever_object
// or links or prefix="whatever_" (just like with SendFlag).
// @uparm Exception | the flag
// @parmopt name | name | | object name
// @parmopt string | prefix | | prefix value


// @script | IsAlive | Takes the same arguments as SendFlag etc... Returns
// true if the object currently exists
// @parm name | name | object name


// @script | MakeSkaterGoto |
// This will cause the main skater script to jump to the
// specified script. So a script triggered from a trigger poly
// can use this to force the main skater script to jump to a script.
// It will choose the skater that triggered the poly in that case. <nl>
// <nl>
// A script not associated with an object can also use this, in which
// case it will set the script of skater 0. <nl>
// <nl>
// The main skater script itself could also use it, but there would be
// no point since it can use Goto. <nl>
// <nl>
// This should be used with care, since making the skater jump to a
// script when he's in the middle of doing something could confuse him.
// Eg, forcing him to jump to OnGroundAI when he's on a rail will make
// an assert go off.
// @uparm name | Script name
// @parmopt structure | params | | parameters to be passed to new script


// @script | MakeSkaterGotoSub | interrupts whatever script the skater is doing,
// calls new script, and then returns to the original script.
// @uparm name | script to goto
// @parmopt structure | Params | | parameters to pass to new script
// @parmopt int | Skater | |


// @script | SpawnScript | This will create & run a new script which will
// run -in parallel- until it finishes, when it will die. The new script
// is not associated with any object. The calling script is not affected
// in any way. A typical use of a spawned script would be to play a sound,
// pause, play another sound, etc, for example when an object dies. This
// way the object itself can die straight away
// @uparm name | the name of the script to spawn
// @parmopt structure | Params | | Parameter structure to pass to new script
// @parmopt name | Id | | an id to assign to the spawned script, so it can
// be killed by KillSpawnedScript
// @flag NotSessionSpecific | This will cause the script to not get deleted when the current
// level (session) ends.


// @script | SpawnSound | This will create & run a new script which will
// run -in parallel- until it finishes, when it will die. The new script
// is not associated with any object. The calling script is not affected
// in any way. A typical use of a spawned script would be to play a sound,
// pause, play another sound, etc, for example when an object dies. This
// way the object itself can die straight away
//
// Note, this is the same as SpawnScript, except if the current script is
// attached to an object, then we do the same as Obj_SpawnScript
// So we get attached to the object
//
// @uparm name | the name of the script to spawn
// @parmopt structure | Params | | Parameter structure to pass to new script
// @parmopt name | Id | | an id to assign to the spawned script, so it can
// be killed by KillSpawnedScript


// @script | SpawnSkaterScript | This will create & run a new script
// on the skater which will run in parallel until it finishes, when it
// will die. The calling script is not affected in any way.
// @uparm name | the name of the script to call
// @parmopt structure | Params | | parameter list to pass to new script
// @parmopt name | Id | | an id to assign to the new script so it can
// be killed by KillSpawnedScript


// @script | KillSpawnedScript | can be passed a script name or an id
// @parmopt name | Name | | the name of the script
// @parmopt name | Id | | the id of the script


// @script | PauseSkaters | This will cause all skaters to freeze.
// They will continue where they left off when UnPauseSkaters is called.
// Note that this command will not pause any spawned scripts associated
// with the skaters, because otherwise it will pause the camera animation
// script too, which is where the command will probably be used most


// @script | UnPauseSkaters | opposite effect of PauseSkaters


// @script | PauseSkater | this pauses an individual skater
// @uparm 0 | skater id


// @script | UnPauseSkater | Unpauses an individual skater
// @uparm 0 | skater id


// @script | PauseGame | Similar to "PauseSkaters", it will pause
// the skaters, and everything else in the world, yet still allow
// you to launch messages and spawn new scripts


// @script | UnPauseGame |


// @script | PauseObjects |


// @script | UnpauseObjects |


// @script | PauseSpawnedScripts |


// @script | UnPauseSpawnedScripts |


// @script | PauseClock |


// @script | UnPauseClock |


// @script | ShowClock |


// @script | HideClock |


// @script | ResetClock |


// @script | PadsPluggedIn | Returns true if at least one pad is plugged in.


// @script | DoFlash | Doflash just draws a big poly over the viewport
// and then modulates the color and alpha of that poly over time. There
// is no support for Blendmodes yet. If you are doing a player specific
// flash remember to call it from a skater script so that it works in 2
// player splitscreen
// @parmopt float | duration | 0.0 |
// @parmopt string | texture | | texture name
// @parmopt float | z | 0.0 | z
// @flag fullscreen |
// @flag behind_panel |
// @flag additive |
// @flag subtractive |
// @parmopt int | skater | | for specifying skater when not in skater script
// @flag ignore_pause |
// @parm int | start_r | start red index
// @parm int | start_g | start green index
// @parm int | start_b | start blue index
// @parm int | start_a | start alpha value
// @parm int | end_r | end red index
// @parm int | end_g | end green index
// @parm int | end_b | end blue index
// @parm int | end_a | end alpha value


// @script | StartServer | Starts a server using the IP stored in
// the script variable LocalIP, which you also have to define. You
// can also define a script variable called ServerName to name your
// server (i.e. ServerName = “MyServer” with a max of 15 characters


// @script | LeaveServer |


// @script | FindServers | broadcast out to the local subnet for servers


// @script | JoinServer | Join the server in session at the given IP address and port
// @uparm "string" | ip address
// @uparm 1 | port


// @script | SetNetworkMode | sets the network mode
// @uparm 0 | mode


// @script | MemViewToggle |


// @script | LoadAndSetTexDict | obsolete function


// @script | LoadTexDictModel | obsolete function


// @script | ProfileTasks | profiles task for the number of frames specified
// @uparm 1 | number of frames


// @script | ToggleConsole | toggles console...


// @script | UseNetworkPreferences |


// @script | ConnectToInternet |


// @script | DisconnectFromInternet |


// @script | StopAllScripts | This will cause all scripts in existence
// to stop (including the one calling this function). This function may
// be useful later when doing cleanup type stuff. Note that though this
// command will stop all scripts in existence at the moment it is called,
// it won't prevent new scripts being run by the C-code


// @script | SetMenuElementText | sets the specified menu element
// @uparmopt "Blaa" | text to use for menu element - "Blaa" is the actual default


// @script | MakeTextMenuElementStatic |
// @uparm name | the id of the menu element


// @script | FirstTimeThisIsCalled | returns true the first time this is called


// @script | EnableActuators |
// @uparm 1 | 1 for enable - 0 for disable.  1 is the default


// @script | InNetGame | returns true if we're in a net game


// @script | IsObserving | You can now use the "IsObserving" script
// command to perform logic (ex. hide objects) if the player is
// Observing a network game.


// @script | SkatersAreReady | true if all skaters connected to the server
// are done loading


// @script | SetSlomo | sets slomo to specified value
// @uparmopt 0.0 | value


// @script | SetArenaSize | Obsolete function


// @script | SetParticleSysVisibility | no longer supported.


// @script | TogglePlayerNames |


// @script | SetCurrentGameType | sets the current game type


// @script | DumpNetMessageStats | displays all net message stats


// @script | SetServerMode | sets the server mode
// @flag off |


// @script | NotifyBailDone |


// @script | DisplayLoadingScreen | shows the loading screen
// @uparm "string" | name of the screen to display
// @uparmopt time | the amount of time to display loading bar (default is 0, meaning no loading bar)


// @script | HideLoadingScreen | hides the loading screen


// @script | EnterObserverMode | changes to observer mode (for net game)


// @script | ObserveNextSkater |


// @script | AllowPause |
// @flag off | do not allow pause


// @script | RefreshServerList | gets a new server list


// @script | StartServerList |


// @script | StopServerList |


// @script | FreeServerList |


// @script | PauseGameFlow | suspends gameflow - should only be called from
// gameflow.q


// @script | UnPauseGameFlow |


// @script | InFrontEnd | returns true if we are in the front end


// @script | InSplitScreenGame | returns true if we are in a split screen game


// @script | InMultiPlayerGame |


// @script | GameModeEquals | returns true if the current game mode matches
// the specified game mode
// @uparm name | game mode to check. More than one may be specified, eg GameModeEquals is_singlesession is_creategoals


// @script | OnServer | returns true if we are on a server


// @script | GetCurrentLevel | returns level=load_foun  (or whatever)
// so you can use it with LoadLevel, without going through LoadRequestedLevel


// @script | TogglePanel |
// @uparm 1 | panel state


// @script | RestartLevel | RestartLevel is just intended to be called
// when a level is restarted it does not actually restart the level,
// it just sets a few flags and does something with disabling the the
// viewer log that's only related to screenshot mode


// @script | ToggleScores | toggles game scores


// @script | XTriggered |


// @script | UsePad | sets the specified skater to use the pad
// @uparmopt 0 | skater id (default is 0)


// @script | IsTrue | Checks to see whether some global constant equals
// 1 or 0.  (If it's not defined anywhere, then it returns 0.) <nl>
// Usage: <nl>
// if IsTrue run_viewer <nl>
//    printf "I am in viewer mode" <nl>
// else <nl>
//    printf "I am in skateshop mode" <nl>
// endif <nl>
// if IsTrue test_balls <nl>
// where test_balls is defined in "yourname".q. <nl>
//    printf "I am testing my balls here" <nl>
// endif
// @uparm name | global constant to check


// @script | CreatePanels | creates panels for game


// @script | DeletePanel | Deletes the panel of skater 0.
// Used when quitting out of the records display screen in the options menu
// in the skateshop.
// The records display requires that a panel exists, so CreatePanels needs
// to be called. CreatePanels will keep creating panels if called repeatedly,
// so the records display deletes the panel on quitting out.


// @script | GameFlow |
// @uparm name | script name


// @script | JoinWithPassword | joins the server with the specified password
// @parm string | string | password string


// @script | TestNetworkSetup | tests network settings


// @script | SendChatMessage |
// @parm string | string | the message to send


// @script | InSlapGame | true if we are in a slap or netslap game


// @script | SetScreenMode | Sets the way the screen will be split up into separate
// viewports in the game. If there is more than one viewport, and multiple skaters
// are active, then each skater will get his own viewport
// @uparm One_Camera | the mode to use - one of the following: <nl>
// One_Camera <nl>
// Split_Vertical <nl>
// Split_Horizontal <nl>
// Split_Quarters


// @script | SetScreenModeFromGameMode | sets the appropriate screen mode based on the game mode


// @script | LoadPendingPlayers |


// @script | LaunchQueuedScripts |


// @script | HideMenu |


// @script | GetInitialsString | gets the initials string for the player


// @script | SetInitialsString | sets the initials string for the player
// @parm string | string | initials string


// @script | DumpMenuTree | Save menu tree out to file in text format


// @script | AttachToSkater | (DEPRACATED) Make the current script be running on the skater <nl>
// used for the gameflow, where we are not always sure if there is a skater there <nl>
// use this in place of SpawnSkaterScript in the gameflow <nl>
// if "AttachToSkater End" is called then will detatch it <nl>
// must be in mathcing pairs <nl>
// otherwise the gameflow gets messed up <nl>
// when the skater is deleted (as the gameflow gets stopped and deleted) <nl>
// @flag End |


// @script | TryCheatString |
// @parm string | string | cheat string to try


// @script | LevelIs | true if the level matches the specified level
// @uparm name | level name


// @script | StartNetworkLobby |


// @script | ObserversAllowed |


// @script | NumPlayersAllowed |
// @uparm name | number of players allowed


// @script | AutoDNS | true if auto DNS


// @script | UsingDefaultMasterServers | true if using the default master
// servers


// @script | UsingDHCP | true if using DHCP


// @script | InInternetMode |


// @script | EnteringNetGame | true if we're in a network game but not
// read to play


// @script | DeviceChosen | true if a device type has been chosen


// @script | GameIsOver | true if game is over


// @script | SetLevelName | gets the level name into the above static, so it can be used for the DumpHeaps memory profile dump


// @script | ResetPS2 | For testing the reset button handler when
// the Sony Network adapter is loaded


// @script | ResetHD | For testing the reset button handler when
// the Sony Network adapter is loaded


// @script | PAL | returns true if we're in PAL mode


// @script | Change | changes the symbol to the new value specified.  will do nothing
// if called on the following: a symbol that doesn't already exist, a script symbol, c-function
// or member function symbols <nl>
// should really only be called on strings, floats, and ints <nl>
// example: Change Foo=7
// @uparm name | the name of the symbol to change
// @uparm value | the value to assign to the symbol (make sure type is correct)


// @script | DumpScripts | Prints out the names of all the currently existing scripts.


// @script | TimeUp | true if time is up


// @script | LaunchViewer |


// @script | LaunchViewer |


// @script | SetViewerModel |


// @script | SetViewerAnim |


// @script | ScriptSetViewerLODDist |


// @script | AddRestartsToMenu | adds all restart points to the menu


// @script | ScriptRunScriptOnObject | allows you to access Obj_ type functions, from a global script


// @script | RunScriptOnComponentType |


// @script | Debounce | This will ignore the specified button
// until either the time has elapsed, or the button has been
// released and subsequently re-pressed.
// For X, this prevents the press of X from carrying over from one
// screen to the next, and removes the need to have a delay,
// whilst still allowing the user to actively X past things
// @uparm X | button name
// @parmopt float | time | 1.0 | time to wait (in seconds)
// @parmopt int | clear | 0 | if 1, then clear the current pressed and triggered states


// @script | SetStatOverride | Set a global stat override for debugging
// set it to 0 to use normal stats


// @script | ToggleRails | Toggle the debug display of rails on and off


// @script | ToggleRigidBodyDebug | Toggle the debug display of rigidbody characteristics


// @script | CheckForHoles | check the scene file for holes in geometry, and visually display them


// @script | OnXbox |


// @script | GotoXboxDashboard |


// @script | CreateParticleSystem | Creates a particle system.
// @parm name | name | the name of the particle system. (Should be Particle_UnNamed if created from a node)
// @parmopt int | max | 256 | maximum number of particles this system can display.
// @parmopt name | texture | | the name of the texture to apply. No name means use flat shaded.
// @parmopt name | emitscript | | the name of the script to call for emission.
// @parmopt name | updatescript | | the name of the script to call to update position etc.
// @parmopt name | blendmode | diffuse | The blendmode: blend/add/sub/modulate/brighten &
// fixblend/fixadd/fixsub/fixmodulate/fixbrighten & diffuse (no blend at all). Defaults to diffuse.
// @parmopt int | fix | 0 | Fixed alpha value. 128 is normal. Range is 0-255.
// @parmopt name | params | | Sets a parameter block for use with the created particle scripts.
// @parmopt name | type | flat | Sets the type of particle (flat/shaded/smooth/glow). Defaults to flat.
// @parmopt int | segments | 8 | The number of segments in a segmented particle, such as 'Glow'.
// @parmopt float | split | 0.5 | Sets the split point in a segmented particle. 0 = split at center. 1 means split at outer edge.
// @parmopt int | history | 1 | Number of history lists to keep. Minimum is 1 when using trail particle types.
// @parmopt int | perm | 0 | set to 1 if particle system stays between levels (like the skaters)
// update script to grab bone/node positions when attaching.
//
//


// @script | SetScript | Sets the emission script.
// @parm name | name | the name of the particle system.
// @parmopt name | emitscript | | the name of the script to call for emission.
// @parmopt name | updatescript | | the name of the script to call to update position etc.
// @parmopt name | params | | Sets a parameter block for use with the created particle scripts.


// @script | DestroyParticleSystem | Destroys a particle system.
// @parm name | name | the name of the particle system.
// @parmopt int | ifempty | 0 | Set this to 1 if you want the particle system to be destroyed only when empty.


// @script | EmptyParticleSystem | Empties the particle system immediately (sets number of particles to 0.
// @parm name | name | the name of the particle system.


// @script | ParticleExists | Returns whether the specified particle system exists
// @parm name | name | the name of the particle system.


// @script | StructureContains | true if the structure contains an element
// with the specified name
// @parm structure | structure | the structure to check
// @parm name | | the named param to look for


// @script | GetBonePosition | allows you to access Obj_ type functions, from a global script


// @script | ShouldEmitParticles | tests whether the specified particle system is active


// @script | ParticlesOn | turns on the specified particle system


// @script | ParticlesOff | turns off the specified particle system


// @script | MangleChecksums | adds 2 checksums together and returns the result in "mangled_id"
// @parm name | a | First checksum
// @parm name | b | Second checksum
// @parm name | mangled_id | The returned value for the mangled checksum


// @script | RotateVector | rotates a vector by the specified amount
// @parm float | x | X value of the vector to be rotated (also, the return value)
// @parm float | y | Y value of the vector to be rotated (also, the return value)
// @parm float | z | Z value of the vector to be rotated (also, the return value)
// @parm float | rx | Amount to rotate on X, in degrees
// @parm float | ry | Amount to rotate on Y, in degrees
// @parm float | rz | Amount to rotate on Z, in degrees


// @script | IsPS2 | Returns true if the current hardware is PS2 (proview/devkit/regular).


// @script | IsNGC | Returns true if the current hardware is GameCube.


// @script | IsXBOX | Returns true if the current hardware is Xbox.


// @script | IsWin32 | Returns true if the current hardware is Win32.


// @script | GetPlatform | Puts the name of the current platform as a checksum into a parameter
// called Platform. The value will be either ps2, xbox, ngc or win32
// Handy for use in script switch statements, rather than having to have nested if's


// @script | PushMemProfile | push an arbitarily named memory profile (Mick's use only)


// @script | PopMemProfile | pop a mem profile that was pushed (Mick's use only)


// @script | TogglePass | Toggle which passes are displayed


// @script | SetScreen | Sets default screen aspect ratio and camera
// @parm float | Aspect | aspect ratio, usually 16/9 (1.777777777) or 4/3 (1.3333333333)
// @parm float | Angle | screen angle in degrees usally 72, or 80 for 16:9


// @script | CreateIndexArray | creates an array of ints, where each element
// is equal to its own index
// @uparm 1 | size of array


// @script | GetRescaledTargetValue |
// @parm float | min |
// @parm float | max |
// @parm float | target |
// @parm float | result |


// @script | MenuIsSelected | Checks names in pArray to find selected


// @script | GetNodeName | Gets the node name of the object running this script, and puts
// it into a parameter called NodeName.
// If there is no such object, it will not add NodeName and will return false.


// @script | SetTesterScript | Sets and starts running the tester script. This is a script which
// will never die and will always be having its update function called every frame.
// Used for auto testing levels.
// SetTesterScript may be called more than once. Any new call will stop the current tester script
// and start the new one.
// If the tester script hits an endscript it still won't die, it will just stick on the endscript
// and not do anything. (This uses negligible processing time)
// @uparm name | The name of the script to run.


// @script | KillTesterScript | Kills any tester script that is running.
// Returns true if a tester script was running before, false otherwise.


// @script | MemPushContext |
// @uparm 1 | value


// @script | MemPopContext |


// @script | MemInitHeap |
// @parm name | name | the name of heap to create
// @parm int | size | the size of heap to create


// @script | MemDeleteHeap |
// @parm name | name | the name of heap to delete


// @script | AnalyzeHeap | analyzes specified heap
// @uparmopt BottomUpHeap | heap to analyze


// @script | PrintMemInfo | displays mem info about specified heap
// @uparmopt BottomUpHeap | which heap to print


// @script | DumpHeaps | prints out heap contents


// @script | LoadExecPS2 |
// @parm string | elf | elf file to load
// if this fails on a TOOL turn off SN profiling in main.cpp
// and check the media type in prepare_to_exit


// @script | UseUserSoundtrack | xbox only - uses a certain soundtrack
// @uparm 1 | the soundtrack number


// @script | UseStandardSoundtrack | xbox only - use the standard soundtrack


// @script | DisableReset | ngc only - disable the reset button. If the user presses reset when disabled, a screen will be displayed until it is enabled, and it will reset.


// @script | EnableReset | ngc only - enable the reset button. If reset was pressed while disabled, it will now reset.


// @script | ResetToIPL | ngc only - resets to IPL screen.


// @script | AutoRail |
// auto-generates rails based of the level's collidable geometry
// @parmopt float | min_rail_edge_angle | 30.0 |
// rails are created only on edges as least as sharp as this angle
// @parmopt float | max_rail_angle_of_assent | 45.0 |
// rails are created only on edges less steep than this angle
// @parmopt float | min_railset_length | 36.0 |
// autorail attempts to join contiguous edges together in order to determine the effective length of a curved rail;
// once this is done, rails shorter than this length in inches are dropped
// @parmopt float | min_edge_length | 0.0 |
// edges below this length in inches are not considered for rail creation, even if they could be part of a curved rail
// @parmopt float | max_corner_in_railset | 50.0 |
// maximum angle between two edges for them to be connected as a curved rail
// @parmopt float | connection_slop | 0.1 |
// slop distance allowed between rail endpoints below which those rails will be snapped togeather
// @parmopt float | farthest_degenerate_rail | 12.0 |
// auto-generated rails	within this distance in inches of an old rail will not be created
// @parmopt float | max_degenerate_rail_angle | 20.0 |
// if the angle between an auto-generated rail and a nearly old rail is below this angle, the auto-generated rail will not be created
// @parmopt float | max_low_curb_height | 8.0 |
// curbs below this height in inches are not given rails; controls the low-curb collision feeler length
// @parmopt float | vertical_feeler_length | 60.0 |
// length in inches of the vertical collision feeler
// @parmopt float | crossbar_feeler_length | 12.0 |
// length in inches of the crossbar collision feeler
// @parmopt float | crossbar_feeler_elevation | 12.0 |
// height in inches of the crossbar collision feeler
// @parmopt float | curb_feeler_angle_of_assent | 30.0	|
// low-curb collision feeler radiates from the rail at this angle above the bordering faces
// @parmopt float | feeler_increment | 36.0 |
// collision feelers are used at each step of this distance in inches along the rail
// @flag no_feelers |
// turns off the checking of the volume around rails by collision feelers
// otherwise this checking is done in order to insure that a rail is not cramped or on a low curb
// @flag no_vertical_feeler |
// turns off the collision feeler which radiates upward from the rail
// @flag no_crossbar_feeler |
// turns off the collision feeler which lies just above the rail and runs perpendicular to it
// @flag no_low_curb_feeler |
// turns off the collision feelers which radiate from the rail just above the bordering faces;
// these collision feelers are used to insure rails are not created on low curbs
// @flag overwrite |
// deletes old rails before auto-generating rails


// @script | SetActiveCamera |
// Sets the active camera to be the camera component of this object
// @parmopt checksum | id | 0 |
// @parmopt integer | viewport | 0 |
// @flag move |	  move the new camera to the position of the old camera


// @script | IsGrind |


// @end
// \skate5\code\sk\scripting\cfuncs.cpp end
// \skate5\code\sk\scripting\mcfuncs.cpp begin
// @DOC cfuncs
// @module cfuncs | None
// @subindex Scripting Database
// @index script | cfuncs
// @module cfuncs | None
// @subindex Scripting Database
// @index script | cfuncs


// @script | GetMostRecentSave | Finds the most recent save of the given type in the passed
// directory listing. Puts the result into a structure called MostRecentSave. Any existing
// parameter called MostRecentSave will be removed first. If there are no files, no MostRecentSave
// parameter will be created.
// @uparmopt [] | The directory listing. Must be an array of structures.
// @uparmopt name | The save type. If omitted it will return the most recent save of any type.


// @script | GetMemCardSpaceAvailable | Puts the amount of space left on the mem card
// into the parameter SpaceAvailable. Units are K for the PS2


// @script | GetMemCardSpaceRequired | Calculates the amount of space required to save the specified
// file type to the memory card, and puts it into the parameter SpaceRequired.
// Units are K for the PS2.
// @uparm name | The save type.


// @script | MemCardFileExists | returns true if the file already exists
// on the card
// @parm string | Name | the name of the file
// @parm name | type | the type of the file


// @script | DeleteMemCardFile | Deletes the specified file from the memory card
// @parmopt string | CardFileName | | The name of the file as stored on the memory card. If this is
// not specified then it is derived from UserFileName and Type
// @parmopt string | UserFileName | | The name of the file as it appears in the files menu
// @parm name | Type | The file type (NetworkSettings, OptionsAndPros, Cas, Park, Replay)


// @script | FormatCard | Formats the memory card


// @script | CardIsInSlot | returns true if the memory card is in the slot


// @script | CardIsFormatted | returns true if the memory card is formatted


// @script | SaveFailedDueToInsufficientSpace |


// @script | GetSummaryInfo	|


// @script | SaveToMemoryCard |


// @script | LoadFromMemoryCard | Load the specified file from the memory card
// @parm string | Name | The name of the file to load
// @parm name | Type | The type of the file (cas, network, park, etc.)


// @end
// \skate5\code\sk\scripting\mcfuncs.cpp end
// \skate5\code\sk\scripting\skfuncs.cpp begin
// @DOC skfuncs
// @module skfuncs | None
// @subindex Scripting Database
// @index script | skfuncs
// @module skfuncs | None
// @subindex Scripting Database
// @index script | skfuncs


// @script | CurrentSkaterIsPro | Checks if the current skater is pro


// @script | GetGoalsCompleted | Returns goals (competitions) completed


// @script | GetNextLevelRequirements | Gets number of goals needed for next level


// @script | UpdateCareerInfoMenu | Set the text in the career info menu


// @script | UpdateSliderInfoMenu | Set the text in the slider info menu


// @script | SetCurrentSkaterProfile |
// @uparmopt 0 | Skater profile index - must be 0 or 1


// @script | CurrentSkaterProfileIs | Checks if current skater profile is
// equal to index value passed in
// @uparmopt 0 | Index value - must be 0 or 1


// @script | AddSkaterProfile | Adds skater profile
// @parm name | name | The name of the profile


// @script | AddTemporaryProfile | Adds temporary skater profile
// (used for credits, to temporarily hijack the skater profile


// @script | RememberTemporaryProfile |


// @script | RestoreTemporaryProfile |


// @script | ClearTemporaryProfile |


// @script | GetTemporaryProfileInfo |


// @script | RememberTemporaryAppearance |


// @script | RestoreTemporaryAppearance |


// @script | SyncPlayer2Profile |


// @script | PreloadModels |


// @script | PreloadPedestrians |


// @script | PreselectRandomPedestrians |
// Example: PreselectRandomPedestrians part=ped_f_legs list=sch_ped_f_legs num=4


// @script | SetUIFromPreferences |
// @parmopt name | field | | field name
// @parmopt string | field | | field string
// @parmopt name | select_if | | check if this name equals the value of
// checksum in the field
// @parmopt name | menu_id | | the menu id to act on if the select_if is true
// @parmopt name | id | | the control id
// @flag mask_password | if set, all letters are replaced with stars


// @script | SetUIFromSkaterProfile |
// @parm name | field_id | the field id
// @parmopt name | select_if | |
// @parmopt name | menu_id | | the menu id
// @parmopt name | control_id | |
// @parmopt name | slider_id | |


// @script | SetPreferencesFromUI | changes field defined by string to value defined by field
// @parm string | string |
// @parm string | field |
// @parmopt name | level_checksum | |


// @script | ResetAllToDefaultStats |


// @script | ResetToDefaultProfile |


// @script | ResetAllToDefaultProfile |


// @script | ForEachSkaterName |


// @script | ForEachSkaterProfile |


// @script | GetSkaterProfileInfoByName | appends the skater profile info to the
// calling script's params. returns false if the specified profile can't be found
// @parm name | name | the name to search for


// @script | SetSkaterProfileInfoByName | appends the skater profile info to the
// calling script's params. returns false if the specified profile can't be found
// @parm name | name | the name to search for
// @parm structure | params | the params structure to append to the skater profile


// @script | ResetDefaultAppearance |
// @parm int | skater | the skater to reset


// @script | ResetDefaultTricks |
// @parm int | skater | the skater to reset


// @script | ResetDefaultStats |
// @parm int | skater | the skater to reset


// @script | RandomizeAppearance |
// @parm int | skater | the skater to randomize


// @script | PrintCurrentAppearance |
// @parm int | skater | the skater num


// @script | SetNeversoftSkater |
// @parm int | skater | the skater num
// @parm structure | appearance | current appearance structure
// @parm structure | info | current info structure


// @script | CurrentProfileIsLocked | returns true if this skater profile is locked
// @parm int | skater | the skater num


// @script | ResetSkaters | skip skaters to their restart points
// can specify either a node number or a node name
// the node number is ued by the "goto restart" menu
// @parmopt int | node_number | -1 | number of a node to skip the skater to
// @parmopt name | node_name |  | name of a node to skip the skater to


// @script | SetSkaterProfileInfo | Appends the structure to the specified skater
// profile info.  (Should only append the item if the item is of the same
// type)
// @parm int | player | the player slot to set
// @parm structure | params | the stuff to set


// @script | GetSkaterProfileInfo | Returns the skater profile info in the script params
// @parm int | player | the player slot to get
// @parm float | value | value


// @script | SetSkaterProfileProperty | Debugging function to set individual stats
// @parm int | stat | the stat to set
// @parm float | value | value


// @script | ToggleAlwaysSpecial | ToggleAlwaysSpecial (on/off) fixes the
// special meter to be always full. <nl>
// ToggleAlwaysSpecial         ; Toggle it (useful for puttin on a button) <nl>
// ToggleAlwaysSpecial on      ; Sets it on <nl>
// ToggleAlwaysSpecial off     ; Sets it off <nl>
// Note that when you set it on, the special meter is immediately full.
// However, when you turn it off, then the special meter will just decay
// normally, so it might not be immediately obvious that you switched it off.


// @script bool | SkaterSpeedGreaterThan | Check the skater speed, as if to have a ped
// not fall when the skater is stationary
// @parm float | speed | Speed to check against


// @script bool | SkaterSpeedLessThan | Check the skater speed, as if to have a ped
// not fall when the skater is stationary
// @parm float | speed | Speed to check against


// @script bool | SkaterLastScoreLandedGreaterThan | Detects last score to trigger if script.
// Example: if SkaterLastScoreLandedGreaterThan 2000 --do cool stuff-- endif
// @uparm 1 | Score (int)


// @script bool | SkaterLastScoreLandedLessThan | Detects last score to trigger if script.
// Example: if SkaterLastScoreLandedLessThan 2000 --do cool stuff-- endif
// @uparm 1 | Score (int)


// @script bool | AnySkaterTotalScoreGreaterThan | Checks if any skaters' score is greater than the score paramter
// Example: if AnySkaterTotalScoreGreaterThan 2000 --do cool stuff-- endif
// @uparm 1 | Score (int)


// @script bool | SkaterTotalScoreGreaterThan | Detects last score to trigger if script.
// Example: if SkaterTotalScoreGreaterThan 2000 --do cool stuff-- endif
// @uparm 1 | Score (int)


// @script bool | SkaterTotalScoreLessThan | Detects last score to trigger if script.
// Example: if SkaterTotalScoreLessThan 2000 --do cool stuff-- endif
// @uparm 1 | Score (int)


// @script bool | SkaterCurrentScorePotGreaterThan | Detects last score to trigger if script.
// Example: if SkaterCurrentScorePotGreaterThan 2000 --do cool stuff-- endif
// @uparm 1 | Score (int)


// @script bool | SkaterCurrentScorePotLessThan | Detects last score to trigger if script.
// Example: if SkaterCurrentScorePotLessThan 2000 --do cool stuff-- endif
// @uparm 1 | Score (int)


// @script | GoalGreaterThan | Counts the number of goals you have got.
// @uparm 1.0 | value to check


// @script | GoalsEqualTo | Counts the number of goals you have got.
// @uparm 1.0 | number of goals


// @script | MedalsGreaterThan |  Counts the number of medals you have got.  This
// is just the number of levels you have gotten a medal in, so it will be 0 - 3.
// @uparm 1.0 | number of medals


// @script | MedalsEqualTo |  Counts the number of medals you have got.  This
// is just the number of levels you have gotten a medal in, so it will be 0 - 3.
// @uparm 1.0 | number of medals


// @script | ToggleSkaterCamMode | Toggles the camera mode for a given skater
// @parm int | skater |


// @script | GetSkaterID | returns the id of the skater, so that you can run member functions on it from a global script
// @parm int | skater | Which skater's ID you want to grab
// The skater's id is returned in objID, check the script for examples


// @script | SetSkaterCamLerpReductionTimer |
// @parmopt float | time | 0.0 | time value


// @script | PlaySkaterCamAnim | Play a camera animation for a given skater <nl>
// Example usage:
// script play_photoguy_cam
//		TRG_G_TS_PhotoGuy:Obj_GetID
//		PlaySkaterCamAnim skater=0 name=G_TS_CameraStart targetID=objID targetOffset=(0,50,0) positionOffset=(-100, 50, -100)
//		; camera looks at a point 50 units above the photoguy, camera is fixed to a position 50 units above, 100 units behind, and 100 units to the left
// endscript
// @parmopt int | skater | 0 |
// @parmopt name | skaterId | | find the skater by id, rather than index
// @flag stop |
// @parm name | name | the name of the animation
// @flag loop | loop the animation
// @flag focus_skater |
// @flag play_hold |
// @parmopt int | skippable | | whether the movie is skippable
// @parmopt name | exitScript | | name of script to run when the movie finishes/is skipped through
// @parmopt structure | exitParams | | additional parameters to be passed to the exitScript
// @parmopt name | targetID | | m_id of the object to follow (not the node's name!  see example below)
// @parmopt vector | targetOffset | | offset from the specified targetID to look at (in local space, not world space)
// @parmopt vector | positionOffset | | overrides the camera position with the specified offset from the specified targetID


// @script | SetSkaterCamAnimSkippable | set the current anim for a given
// skater as skippable
// @parmopt int | skater | 0 | the skater
// @parmopt name | skaterId | | the id of the skater
// @parmopt int | name | | the name of the movie to set skippable (otherwise, it will use the currently-playing movie)
// @parmopt int | skippable | 0 | set to anything greater than 0 to set anim to skippable


// @script | SetSkaterCamAnimShouldPause | changes the pause mode of a skater cam.
// If the pause mode is set to false, the cam will play even if the game is paused
// @parmopt name | skaterId | | the id of the skater
// @parmopt int | skater | 0 | the skater index


// @script | GetCurrentSkaterCamAnimName | returns the name of the current skater cam (if any)


// @script | GetSkaterCamAnimParams | returns the params of the current skater cam


// @script | SkaterCamAnimFinished | returns true if the anim for the
// given skater is finished
// @parmopt int | skater | 0 | the skater
// @parmopt name | skaterId | | the id of the skater
// @parmopt int | cam | 1 | the camera number


// @script | SkaterCamAnimHeld | returns true if anim is held
// @parmopt int | skater | 0 | the skater
// @parmopt name | skater | | the id of the skater


// @script | KillSkaterCamAnim |
// @parmopt int | skater | 0 | the skater
// @parmopt name | skaterId | | the id of the skater
// @flag current | kill the current cam anim
// @flag all | kill all cam anims


// @script | ReloadSkaterCamAnim | undocumented


// @script | PlayCutscene | Play a cutscene


// @script | PlayMovingObjectAnim | Play an scene-based animation (earthquake, for instance)


// @script | SetMovingObjectAnimSkippable | set the current movie as skippable
// @parmopt int | name | | the name of the movie to set skippable (otherwise, it will use the currently-playing movie)
// @parmopt int | skippable | 0 | set to anything greater than 0 to set anim to skippable


// @script | SetMovingObjectAnimShouldPause | changes the pause mode of a skater cam.
// If the pause mode is set to false, the cam will play even if the game is paused


// @script | MovingObjectAnimFinished | returns true if the anim for the
// given skater is finished
// @parm int | skater | the skater
// @parmopt int | cam | 1 | the camera number


// @script | MovingObjectAnimHeld | returns true if anim is held
// @parm int | skater | the skater


// @script | KillMovingObjectAnim |
// @parmopt int | skater | 0 | the skater
// @flag current | kill the current cam anim
// @flag all | kill all cam anims


// @script | ReloadMovingObjectAnim | undocumented


// @script | SkaterDebugOn | sets debug to on


// @script | SkaterDebugOff | sets debug to off


// @script | VibrationIsOn | returns true if vibration for the specified
// player is on
// @uparm 0 | the player


// @script | VibrationOn | turns on vibration for the specified player
// @uparm 0 | player


// @script | VibrationOff | turns off vibration for the specified player
// @uparm 0 | the player


// @script | AutoKickIsOn | returns true if autokick is on for the specified skater
// @uparmopt 0 | skater


// @script | AutoKickOn | turns on autokick for the specified player
// @uparmopt 0 | the skater


// @script | AutoKickOff | turns off autokick for the specified player
// @uparmopt 0 | skater


// @script | SpinTapsAreOn | returns true if spin taps are on
// @uparmopt 0 | skater


// @script | SpinTapsOn | turns on spin taps for the specified skater
// @uparmopt 0 | skater


// @script | SpinTapsOff | turns off spin taps for the specified skater
// @uparmopt 0 | skater


// @script | GetCurrentProDisplayInfo |


// @script | SetPlayerAppearance | sets the player appearance
// @parmopt int | player | 0 | index of player whose appearance you want to edit
// @parmopt name | appearance_structure | | the name of the profile


// @script | SelectCurrentSkater | sets the current profile to the specified skater
// @parmopt name | name | | the name of the profile
// @uparmopt name | name of the profile


// @script | CareerStartLevel | Called at the start of the level, and whenever
// the level is restarted (by a retry, for example).  This will set the level
// number (unless you pass -1, in which case it uses the "current level"). This
// will store the values of the career goals, and the level flags, at the start
// of the level, so at the end of the level, we will be able to see if we have
// just got a particular goal, and play appropriate rewards. Currently you
// should not have to mess with this.  I've added appropriate CareerStartLevel
// commands in the level loading script in levels.q.  I've also added (in the
// C++ code) what amounts to "CareerStartLevel level = -1" to the "RestartLevel"
// function in skate.cpp.  This gets called whenever you restart a level (via
// a retry).
// @parm int | level | the level to start


// @script | CareerLevelIs | This is true if the current level number, as specified
// in the last call to CareerStartLevel, matches the value passed, for example: <nl>
// if CareerLevelIs 1 <nl>
//   printf "Foundry!" <nl>
// endif
// @uparm 1 | level to check


// @script | GetRecordText |
// @parmopt int | level | | level num (default is current level)


// @script | UpdateRecords |


// @script | CareerReset | Resets all the career info back to as if you've
// just started a new career.  Note that this also sets the current level
// to 0 (as you'd not have unlocked any levels).  So if you want to use
// this in the middle of playing a  level, then you'd better add a "StartLevel
// level = ???" to set the correct level. See ResetLevelGoals for more


// @script | SetGoal | Sets the goal to the "got" state.  All this does
// is set a flag, anything else, like playing sounds, should be done in script
// @parm int | goal | the goal num


// @script | UnSetGoal | Clears a particular goal flag
// @parm int | goal | goal flag to clear


// @script | GetGoal | Get the state of a goal.  Will be "true" if you have
// got the goal, either in this session, or in some previous session. For
// example: <nl>
// if GetGoal goal = GOAL_SKATE  ; if got SKATE, then do nothing here <nl>
// else <nl>
//   trigger skater letters <nl>
// endif <nl>
// The primary purpose of this function is the modify the functionality
// of the startup script, to stop things from being created, and to modify
// the intro camera.
// @parm int | goal | the goal to check


// @script | JustGotGoal | Is "true" if you got this goal in the current
// session (still valid if the session has just ended). For example: <nl>
// if JustGotoGoal goal = GOAL_SKATE <nl>
//  LaunchPanelMessage "Yay! You got the skate letters" <nl>
// endif
// The primary purpose if to play one-time congratulatory sequences at
// the end of the level, in the end-level script.  This flag will only
// be true during the session when you actually get the goal
// @parm int | goal | goal th check


// @script | SetFlag | similar to setgoal.  there are 32 flags per level,
// numbered 0 - 31.
// @parm int | flag | the flag to set


// @script | UnSetFlag | similar to unsetgoal.  there are 32 flags per level,
// numbered 0 - 31.
// @parm int | flag | the flag to unset
// @parmopt int | level | | level number


// @script | GetFlag | similar to GetGoal.  gets the state of the flag
// @parm int | flag | the flag to get
// @parmopt int | level | | the level number (for level specific flags).  if
// no level number is given, it will use the current level number


// @script | JustGotFlag | similar to the JustGotGoal command.  returns true
// if we just got this flag
// @parm int | flag | the flag to check


// @script | SetGlobalFlag | sets a global flag
// @parm int | flag | the global flag to set


// @script | UnSetGlobalFlag | unsets a global flag
// @parm int | flag | the flag to unset


// @script | GetGlobalFlag | gets a global flag
// @parm int | flag | the flag to get


// @script | ProfileEquals | tells us whether the skater matches the given
// criteria.  example: <nl>
// if ProfileEquals trickstyle=vert
// @parmopt name | trickstyle | | the trickstyle to check for
// @flag is_pro | check if this is a pro skater
// @flag is_custom | check if this is a custom skater
// @parmopt name | is_named | | check if the skater has the specified name
// @parmopt name | stance | | check for this stance
// @parmopt name | body_type | | check for this body type


// @script | IsCareerMode | returns true if the current game mode is
// career mode


// @script | ClearScoreGoals | clears all the score goals


// @script | SetScoreGoal | used to add a new score goal.  examples: <nl>
// SetScoreGoal  score = 1200000 goalscript = Got_SickScore goal=GOAL_SICKSCORE <nl>
// SetScoreGoal    score = 30000 goalscript = Got_HighScore goal=GOAL_HIGHSCORE
// @parm int | score | the score value for this goal
// @parm name | goalscript | the script to run
// @parm int | goal | goal number


// @script | EndRun | This command will end the current run (same as
// used by the "end run" selection in the pause menu)


// @script | ShouldEndRun | if "end run" was selected from the menu
// of the end conditions for this game mode have been met


// @script | InitializeSkaters |


// @script | EndRunSelected | true if "end run" was selected from the menu


// @script | AllSkatersAreIdle | true if all skaters are idle


// @script | FirstTrickStarted | should only be called in horse mode.


// @script | FirstTrickCompleted | should only be called in horse mode


// @script | CalculateFinalScores | final scores for all skaters on server


// @script | ReinsertSkaters | adds all skaters to the current world


// @script | UnhookSkaters | Unhook the skaters from the world, so it can be unloaded


// @script | ApplySplitScreenOptions | applies various split screen prefs -
// game type, time limit, etc.


// @script | StartCompetition |
// @parm float | gold |
// @parm float | silver |
// @parm float | bronze |
// @parm float | gold_score |
// @parm float | silver_score |
// @parm float | bronze_score |
// @parm float | bail |


// @script | StartCompetitionRun |


// @script | EndCompetitionRun |


// @script | IsTopJudge | true if the specified judge is the top judge
// @uparm 1 | judge num


// @script | PlaceIs | true if the comp place is equal to the specified place
// @uparm 1 | place


// @script | RoundIs | true if the round equals the specified round
// @uparm 1 | round


// @script | EndCompetition |


// @script | CompetitionEnded | true if the comp has ended


// @script | StartHorse |


// @script | EndHorse |


// @script | HorseEnded | true if horse has ended


// @script | HorseStatusEquals | pass in one or more of the flags to check status
// @flag GotLetter |
// @flag TieScore |
// @flag BeatScore |
// @flag Ended |
// @flag Idle |
// @flag NoScoreSet |
// @flag Terminator |


// @script | StartHorseRun |


// @script | EndHorseRun |


// @script | SwitchHorsePlayers | switches to the next valid player


// @parm name | whichString | the string to apply to
// @parmopt int | skater | 0 | the skater we're applying to (default is 0)


// @script | IsCurrentHorseSkater | true if the current horse skater
// is the same as the specified skater id
// @uparm 1 | skater id


// @script | ApplyToSkaterProfile |
// @parmopt int | skater | 0 | the skater we're applying to (default is 0)
// @parmopt name | field_id | | the field to change
// @parmopt name | slider_id | | if the value is specified in a slider
// @parmopt name | keyboard_id | | value specified in a string
// @parmopt name | value | | specific value (in the absence of slider or keyboard)


// @script | RefreshSkaterColors | this just synchs up the on-screen
// skater with the color in the skater profile, in case it's changed


// @script | RefreshSkaterScale | this just synchs up the on-screen
// skater with the scale in the skater profile, in case it's changed


// @script | RefreshSkaterVisibility | this just synchs up the on-screen
// skater with the hidegeoms in the skater profile, in case it's changed
// (such as in the invisible man cheat


// @script | AwardStatPoint | awards a stat point to the current skater
// @uparmopt 1 | increment value (can be negative)


// @script | ApplyStatChange | applies any stat changes to the current profile
// @parm int | inc_val | increment value
// @parm name | field_id | field to change


// @script | AwardSpecialTrickSlot | awards a new special trick slot to the
// current skater profile
// @flag all | award a trickslot to all profiles


// @script | UpdateSkaterStats |


// @script | UpdateInitials |


// @script | NewRecord | return true if the last call to UpdateRecords made
// there be a new record


// @script | TrickOffAllObjects |
// @uparmopt 0 | skater id (0 is default)


// @script | SetScoreDegredation |
// @uparm 1 | should degrade amount


// @script | SetScoreAccumulation |
// @uparm 1 | should accumulate amount


// @script | ResetScore |


// @script | UpdateScore |


// @script | ResetScoreDegradation | doesn't seem to do anything...


// @script | SkaterIsBraking | returns true if the local skater is braking


// @script | LocalSkaterExists | returns true if the local skater exists


// @script | InitSkaterModel | This will destroy the specified
// skater's model and replace it with the specified model or
// profile


// @script | RefreshSkaterModel | This will destroy the specified
// skater's model and replace it with the specified model or
// profile


// @script | RefreshPreviewModel | This will destroy the specified
//front-end only preview model and replace it with the specified model or
// profile


// @script | EditPlayerAppearance | This runs an object script on the specified
// appearance structure
// @parmopt int | player | 0 | index of player whose appearance you want to edit
// @parm name | target | name of script that gets run on the player's appearance
// @parmopt structure | targetParams | | extra parameters sent to the target script


// @script | GetCurrentSkaterProfileIndex | This returns the currently selected
// profile (either player 0 or player 1), presumably for use by other script functions
// @parm int | currentSkaterProfileIndex | index of currently selected profile (return value)


// @script | ResetScorePot | this will reset the local skater's current score pot.
// This currently just calls the Bail member func of the score object...


// @script | ScriptPrintSkaterStats | prints the specified skater's stats


// @script | PrintSkaterPosition | prints the local skater's current position


// @script | GetSkaterPosition | prints the local skater's current position


// @script | GetStatValue | this returns the specified stat value in
// the script's params as stat_value
// @uparm STATS_AIR | global int value of the stat (defined in physics.q)
// @parmopt name | skater | | the name of the profile you wish to get.  If you don't
// provide a name, the current skater's profile will be returned


// @script | GetNumStatPointsAvailable | returns the number in the scripts
// params as points_available
// @parm int | player | the player number to check


// @script | UnlockSkater | this makes locked characters accessible
// to the player
// @parm name | skater | the name of the locked character to unlock


// @script | FlushDeadObjects |
// flush any objects that are marked as dead
// used so we can be sure they have gone, so we can re-use the memory
// and also avoid fragmentation


// @script | BindTrickToKeyCombo | binds the given trick to the key combo
// @parm name | key_combo |
// @parm name | trick_checksum |
// @parmopt int | update_mappings | 1 | automatically update the trick mappings.
// This should only be 0 in a split screen game


// @script | GetKeyComboBoundToTrick | looks for any key combos that are currently
// associated with the specified trick.  The result is stored in current_key_combo
// @parm name | trick | trick to look for


// @script | UpdateTrickMappings | forces the trick mappings to update
// @parmopt int | skater | | the skater num
// @parmopt name | skaterId | | the id of the skater


// @script | GetConfigurableTricksFromType | returns an array of trick checksums
// which have the type specified.  The array is stored as ConfigurableTricks
// @parm name | type | the type to search for
// @flag special | search for special tricks of this type


// @script | TrickIsLocked | true if the trick is associated with a skater
// that is locked
// @parm name | trick | the trick name


// @script | GetTrickDisplayText | gets the text corresponding to this trick
// @parm name | trick | the trick name


// @script | GetSpecialTrickInfo | gets the special trick info for the slot
// specified
// @parm int | index | the special trick slot


// @script | GetTrickType | gets the type of the specified trick and returns
// the result in the trick_type param
// @parm name | trick | the name of the trick


// @script | GetIndexOfItemContaining | this will search through the given
// array (must be an array of structures) for the structure containing a param
// the index will be placed in the calling script's params (index)
// @parm array | array | the array to search
// @parmopt int | index | 0 | index to start at
// @parm name | name | name of the param to search for
// @parm name | value | value param should have for a match


// @script | GetLevelRecords | appends the records to the calling script's params


// @script | ResetComboRecords | resets the score object's combo records


// @script | GetNumberOfTrickOccurrences | returns the number of times
// the given trick appears in the skater's current score pot
// @parm string | TrickText | trick string to look for


// @script | GetNumSoundtracks | returns the number of soundtracks
// in the numSoundtracks param


// @script | BindControllerToSkater | remaps the given controller to the
// skater
// @parm int | controller | the controller number
// @parm int | skater_heap_index | the skater num


// @script | ControllerBoundToDifferentSkater |
// @parm int | controller |
// @parm int | skater |


// @script | GetKeyComboArrayFromTrickArray | returns an array of key combos (KeyCombos)
// that correspond to the passed trick array
// @parm array | tricks | array of trick names, eg [Trick_KickFlip Trick_HeelFlip]


// @script | FirstInputReceived | the game does not start checking for
// disconnected controllers until this is called


// @script | VibrateController |
// @parm int | port |
// @parm int | actuator |
// @parm int | percent |


// @script | LockCurrentSkaterProfileIndex |


// @script | SetSpecialTrickInfo |
// @parm int | slot |
// @parm name | trick_name |
// @parm name | key_combo |
// @flag update_mappings |


// @script | InterpolateParameters | This will scan through the structure A, and any parameters in it
// which have type int or float and such that the same named parameter exists in B and also has type int
// or float will have their value interpolated between the two values, and the parameter put into a
// returned structure named Interpolated.
// Note that the returned structure will only contain the parameters that were interpolated, so if
// structure A contained a string, that parameter will not get into Interpolated
// @parm structure | a | The first structure
// @parm structure | b | The second structure
// @parmopt float | Proportion | 0.0 | A value between 0 and 1. 0 means all of structure A and none of structure B,
// 1 means all of B and none of A. 0.5 will therefore be half way between the two.
// @parmopt array | Ignore | | An optional array of parameter names to ignore. Parameters whose type cannot
// be interpolated, such as strings, will automatically be ignored, but the Ignore array allows certain
// integer or float params to be ignored too.
// @parmopt array | Angles | | An optional array of parameters whose values are to be treated as angles.
// So when interpolating between 10 and 350 degrees for example, instead of simply interpolating from
// the number 10 to 350, it will go from 10 backwards through 0 and 359 to 350.


// @script | PlaySkaterStream | skater member func.
// @parm string | type | the stream type.
// @parmopt int | num_possible | 10 | the maximum number of streams to search for


// @end
// \skate5\code\sk\scripting\skfuncs.cpp end
// \skate5\code\sk\modules\FrontEnd\FrontEnd.cpp begin
// @DOC frontend
// @module frontend | None
// @subindex Scripting Database
// @index script | frontend
// @module frontend | None
// @subindex Scripting Database
// @index script | frontend


// @end
// \skate5\code\sk\modules\FrontEnd\FrontEnd.cpp end
// \skate5\code\sk\modules\Skate\GameMode.cpp begin
// @DOC gamemode
// @module gamemode | None
// @subindex Scripting Database
// @index script | gamemode
// @module gamemode | None
// @subindex Scripting Database
// @index script | gamemode


// @script | OverrideGameModeOptions |


// @end
// \skate5\code\sk\modules\Skate\GameMode.cpp end
// \skate5\code\sk\modules\Skate\Goal.cpp begin
// @DOC goal
// @module goal | None
// @subindex Scripting Database
// @index script | goal
// @module goal | None
// @subindex Scripting Database
// @index script | goal


// @end
// \skate5\code\sk\modules\Skate\Goal.cpp end
// \skate5\code\sk\modules\Skate\GoalManager.cpp begin
// @DOC goalmanager
// @module goalmanager | None
// @subindex Scripting Database
// @index script | goalmanager
// @module goalmanager | None
// @subindex Scripting Database
// @index script | goalmanager


// @script | GoalManager_AddGoal |
// @parm name | name | the goal id
// @parm structure | params | goal parameters


// @script | GoalManager_RemoveGoal |
// @parm name | name | the goal id


// @script | GoalManager_GetGoal | currently does nothing at all!
// @parm name | name | the goal id


// @script | GoalManager_EditGoal | this will append the given structure
// onto the goal's existing params structure
// @parm name | name | the goal id
// @parm structure | params | structure to append


// @script | GoalManager_ActivateGoal |
// @parm name | name | the goal id
// @flag dontAssert | pass this in if you don't want the goal manager
// to assert if it can't find the specified goal (not recommended)


// @script | GoalManager_DeactivateGoal |
// @parm name | name | the goal id


// @script | GoalManager_DeactivateGoal |


// @script | GoalManager_WinGoal |
// @parm name | name | the goal id


// @script | GoalManager_LoseGoal |
// @parm name | name | the goal id


// @script | GoalManager_RemoveAllGoals | this will completely destroy
// all the goals currently in existence...make sure you call GoalManager_LevelUnload
// first if you want to remember anything about the state of the goals before
// destroying them.


// @script | GoalManager_DeactivateAllGoals |


// @script | GoalManager_InitializeAllGoals |


// @script | GoalManager_InitializeAllSelectedGoals |


// @script | GoalManager_UpdateAllGoals | This forces the goal manager to run
// an update cycle.


// @script | GoalManager_HasActiveGoals | returns true if there is at least one
// active goal (excluding minigames and other goals that don't count towards the total)


// @script | GoalManager_GoalIsActive | returns true if the specified goal
// is currently active
// @parm name | name | the goal id


// @script | GoalManager_SetGoalTimer | resets the goal timer to it's inital
// value.
// @parm name | name | the goal id


// @script | GoalManager_PauseAllGoals |


// @script | GoalManager_UnPauseAllGoals |


// @script | GoalManager_SetGoalFlag | for setting the special goal flags
// @parm name | name | the goal id
// @uparm name | the name of the flag to set
// @uparm 1 | value to use


// @script | GoalManager_HasSeenGoal | returns true if the player has
// activated the specified goal at least once
// @parm name | name | the goal id


// @script | GoalManager_RestartLastGoal | this will restart the last goal
// It will fail silently if there is no goal to retry


// @script | GoalManager_CreateGoalFlag |
// @parm name | name | the goal id
// @parm name | flag | the name of the flag to create


// @script | GoalManager_AllFlagsSet |
// @parm name | name | the goal id


// @script | GoalManager_GoalFlagSet | true if a goal flag has been set
// @parm name | name | the goal id
// @parm name | flag | the name of the flag to check


// @script | GoalManager_CanRetryGoal | returns true if there is a goal
// to retry


// @script | GoalManager_GetGoalParams | this will append the goal's
// params onto the scripts params.  The goal manager scripts use this
// extensively to avoid passing large structures back and forth.
// @parm name | name | the goal id


// @script | GoalManager_CanStartGoal |
// @parm name | name | the goal id


// @script | GoalManager_NextRaceWaypoint |
// @parm name | name | the goal id


// @script | GoalManager_NextTourSpot |
// @parm name | name | the goal id


// @script | GoalManager_InitTrickObjects |
// @parm name | name | the goal id


// @script | GoalManager_CreateGoalName |
// @parm string | goal_type | the goal type


// @script | GoalManager_SetGraffitiMode |
// @uparmopt 1 | turn on or off with 1 or 0


// @script | GoalManager_GetNumToUnlock | returns the number of goal points
// needed to unlock this goal
// @parm name | name | the goal id


// @script | GoalManager_HasWonGoal | true if you've beat this goal
// @parm name | name | the goal id


// @script | GoalManager_GotCounterObject |
// @parm name | name | the goal id


// @script | GoalManager_CounterGoalDone | returns true if the counter goal
// is complete
// @parm name | name | the goal id


// @script | GoalManager_AddGoalPoint | adds one goal point


// @script | GoalManager_SpendGoalPoints |
// @uparm 1 | number to spend


// @script | GoalManager_HasGoalPoints |
// @uparm 1 | number to check for


// @script | GoalManager_GetNumberOfGoalPoints | places the number of
// goal points in a variable named "goal_points" in the script params


// @script | GoalManager_AddCash | gives the player more cash
// @uparm 1 | amount of cash to give


// @script | GoalManager_SpendCash | spends some of the player's cash
// @uparm 1 | amount to spend


// @script | GoalManager_GetCash | places the current player's cash amount
// in a parameter called "cash" in the script params


// @script | GoalManager_HasWonGoalWithProset |
// @uparm "string" | the proset_prefix you wanna check


// @script | GoalManager_GetProsetNotPrefix |
// @uparm "string" | the proset_prefix you wanna check


// @script | GoalManager_LevelLoad | called when the player enters a level.
// Loads data about goals seen, completed, etc. in a previous game


// @script | GoalManager_LevelUnload | called when the player leaves a level.
// Prompts the goal manager to save state data about all goals


// @script | GoalManager_NumGoalsBeatenInLevel | This will return the number
// of beaten goals in the scripts params as num_beaten
// @uparm 1 | level number
// @flag count_pro_specific_challenges | false by default


// @script | GoalManager_UnlockAllGoals | Unlocks all locked goals


// @script | GoalManager_CheckMinigameRecord | checks the current minigame
// value against the one stored in minigame_record in the goal params
// @parm name | name | the goal id
// @uparm 100 | the value you want to check against the current record


// @script | GoalManager_DeactivateCurrentGoal | Deactivates the currently
// active goal (this function cannot always be trusted).


// @script | GoalManager_SetStartTime | Records the start time of a combo
// (only used for the timedcombo miingame right now).
// @parm name | name | the goal id


// @script | GoalManager_UpdateComboTimer | Used for the timedcombo minigame
// @parm name | name | the goal id


// @script | GoalManager_SetStartHeight | used for the height minigame
// @parm name | name | the goal id


// @script | GoalManager_CheckHeightRecord | used for height minigame
// @parm name | name | the goal id


// @script | GoalManager_CheckDistanceRecord | used for height minigame
// @parm name | name | the goal id


// @script | GoalManager_PlayGoalStartStream | plays the intro vo for the goal
// @parm name | name | the goal id


// @script | GoalManager_PlayGoalWaitStream | plays the wait vo for the goal
// @parm name | name | the goal id


// @script | GoalManager_PlayGoalWinStream | plays the success vo for the goal
// @parm name | name | the goal ID


// @script | GoalManager_StopCurrentStream | stops any vo being played by
// the goal trigger
// @parm name | name | the goal ID


// @script | GoalManager_TurnPro | instantly turns you pro, unlocks all
// the pro goals, and runs the "you just turned pro" script


// @script | GoalManager_DeactivateAllMinigames |


// @script | GoalManager_InitializeAllMinigames |


// @script | GoalManager_PauseGoal | pauses an individual goal
// @parm name | name | the goal id


// @script | GoalManager_UnPauseGoal | unpauses an individual goal
// @parm name | name | the goal id


// @script | GoalManager_PauseCompetition | Pauses a competition
// @parm name | name | the goal id


// @script | GoalManager_UnPauseCompetition | The competition uses a secondary
// pause mechanism...this is for unpausing the comp between rounds
// @parm name | name | the goal id


// @script | GoalManager_UnBeatAllGoals | marks all goals as unbeaten and
// takes away any goal points you earned for beating them.  You have to
// reload the level to re-initialize the goals, however


// @script | GoalManager_AddViewGoalsList | adds the list of goals to the
// view goals menu.  This is called from one place within the create_view_Goals_menu
// script.


// @script | GoalManager_AddGoalChoices | Adds the list of available goals to the "Choose Goals" menu


// @script | GoalManager_GoalIsLocked | true if the goal is locked
// @parm name | name | the goal id


// @script | GoalManager_IsInCompetition | returns true if the player is
// in a competition


// @script | GoalManager_GetGoalAnimations | Gets the appropriate animations
// array from script.  It wil first search for an array specific to this goal and
// type, then for an array specific to this pro, then for the generic array
// @parm name | name | the goal id
// @parmopt string | type | | the goal state - wait, start, midgoal, or success


// @script | GoalManager_PlayGoalStream | plays the appropriate stream for this
// goal/pro.  The appropriate anim arrays must be setup in script for this to work
// @parm name | name | the goal id


// @script | GoalManager_EndRunCalled | returns true if the goal manager
// called endrun for this goal
// @parm name | name | the goal id


// @script | GoalManager_ClearEndRun | This will clear the skater's endrun exception
// as well as any others.  It's used by the combo goal, which needs to clear
// the exception if you bail.  In general, this function should not be used -
// clearing the endrun exception is not usually a good idea.
// @parm name | name | the goal id


// @script | GoalManager_FinishedEndOfRun | returns true if EndOfRun has
// finished
// @parm name | name | the goal id


// @script | GoalManager_StartedEndOfRun | this returns true if EndOfRun
// has started
// @parm name | name | the goal id


// @script | GoalManager_EndBetAttempt | call this to end a bet attempt.
// If the goal id does not match the current bet, the call will be ignored.
// @parm name | name | the goal id


// @script | GoalManager_StartBetAttempt | called by any minigame that is
// also used as a betting game
// @parm name | name | the goal id


// @script | GoalManager_WinBet | calling this will win the bet.
// The goal id is used to verify that the specified bet is in fact
// the active bet.  If it's not, the goal manager will ignore the call
// @parm name | name | the goal id


// @script | GoalManager_BetOffered | called once the betting guy makes
// an offer


// @script | GoalManager_BetRefused | called when the player declines a betting
// guy bet


// @script | GoalManager_MoveBettingGuyNow | this will force the betting guy to
// immediately move to a new, random betting game.  This is useful when the betting guy
// is created and you don't care where the skater is (otherwise the betting guy will avoid
// moving where the skater could see him).


// @script | GoalManager_BetAccepted | called when the player accepts a bet


// @script | GoalManager_BetIsActive | returns true if the bet is currently
// active - ie, the bet guy has offered the bet and the player accepted
// @parm name | name | the goal id


// @script | GoalManager_AddMinigameTime | adds the specified amount of time
// to the minigame.
// @parm name | name | the minigame id (usually goal_id)
// @uparm 1 | the amount of time to add in seconds


// @script | GoalManager_AddTempSpecialTrick | This is used only by the
// special goal.
// @parm name | name | the goal id


// @script | GoalManager_RemoveTempSpecialTrick | this is used only by the
// special goal.
// @parm name | name | the goal id


// @script | GoalManager_GetTrickFromKeyCombo | this will find the trick
// currently bound to the given key combo.  the trick name (checksum value) will
// be placed in the script params as trick_checksum.  The trick text
// will be placed in the params as trick_string.  If no trick is bound to the
// key combo, the function will return false
// @parm name | key_combo | the key combo to search for


// @script | GoalManager_UnlockGoal | unlocks the specified goal
// @parm name | name | the goal id


// @script | GoalManager_QuickStartGoal | starts a goal without going
// through the intro movie, etc.
// @parm name | name | the goal id
// @flag dontAssert | used by autotester


// @script | GoalManager_InitializeGoal | initialize the specified goal
// @parm name | name | the goal id


// @script | GoalManager_AddTime | adds the specified amount of time to the goal
// @parm name | name | the goal id
// @uparm 10 | time to add, in seconds


// @script | GoalManager_ReplaceTrickText | replaces the trick name and
// key combo with the appropriate text.  The key combo should be represented
// in the string by \k, and the text by \t
// @parmopt name | name | | the goal id
// @flag all | in place of a goal id - update all goals


// @script | GoalManager_UnlockProSpecificChallenges | called once, when you
// first get enough goals to unlock the pro challenge


// @script | GoalManager_ProSpecificChallengesUnlocked | true if the pro challenges
// have been unlocked


// @script | GoalManager_GetNumberCollected | returns the number of objects
// collected so far in this goal.  If the goal is not a counter goal, it just returns
// the number of flags set.  The value will be stored in the number_collected var.
// @parm name | name | the goal id


// @script | GoalManager_GetNumberOfFlags | returns the number of flags in this
// goal.  If there are no flags, it returns false
// @parm name | name | the goal id


// @script | GoalManager_IsPro | returns true if you're pro


// @script | GoalManager_ResetGoalFlags | resets all of the goals flags


// @script | GoalManager_ColorTrickObjects | colors all trick objects
// associated with this goal
// @parm name | name | the goal id
// @flag clear | pass this in if you want to clear the color
// @parmopt int | skater | 0 | the skater num


// @script | GoalManager_GetNumberOfTimesGoalStarted | gets the total number
// of times the player has lost this goal.  The number will be stored in
// the calling scripts params as times_lost
// @parm name | name | the goal id


// @script | GoalManager_GoalExists | returns true if the goal exists
// @parm name | name | the goal id


// @script | GoalManager_GetGoalAttemptInfo | grabs the number of times each
// goal has been lost, and stores all the data in your times_lost_info


// @script | GoalManager_SetCanStartGoal | tell the goal manager that it can
// or cannot start any new goals
// @parmopt int | | 1 | 0 to block new goals


// @script | GoalManager_SetEndRunType | one of the flags is required
// @parm name | name | the goal id
// @flag Goal_EndOfRun | use GoalEndOfRun
// @flag EndOfRun | use EndOfRun
// @flag none | don't use end of run


// @script | GoalManager_SetShouldDeactivateOnExpire |
// @uparm 1 | 0 for no, anything else for yes


// @script | GoalManager_GetActiveGoalId | returns the active goal's goal_id.
// Returns false if there are no active goals


// @script | GoalManager_AwardMinigameCash |
// @parm name | name | the goal id
// @uparm 25 | amount of cash to award


// @script | GoalManager_ResetCareer |


// @end
// \skate5\code\sk\modules\Skate\GoalManager.cpp end
// \skate5\code\sk\modules\Skate\skate.cpp begin
// @DOC skate
// @module skate | None
// @subindex Scripting Database
// @index script | skate
// @module skate | None
// @subindex Scripting Database
// @index script | skate


// @script | SetTimeLimit | sets the time limit
// @parmopt int | seconds | 120 | number of seconds for time limit


// @script | SetGameType | Sets the type of game to be played. Examples: <nl>
// SetGameType FreeSkate <nl>
// SetGameType SingleSession
// @uparm name | Game type


// @script | TestGameType | Tests if current game type is equal to the
// game type specified as the first parameter
// @uparm name | Game type


// @script | TestRequestedGameType |
// This is so that I can tell what the last value sent to SetGameType
// was, since SetGameType will not set the game type straight away,
// so TestGameType will not work.
// @uparm name | Game type


// @script | ChangeLevel |
// @parm string | level | The level to change to


// @script | LaunchLevel | launches currently requested level


// @script | RequestLevel |
// @uparm name | level to request


// @script | Retry | retry current level


// @script | LaunchGame |


// @script | InitSkaterHeaps |


// @script | ResetLevel | resets the level


// @end
// \skate5\code\sk\modules\Skate\skate.cpp end
// \skate5\code\sk\objects\MovingObject.cpp begin
// @DOC movingobject
// @module movingobject | None
// @subindex Scripting Database
// @index script | movingobject
// @module movingobject | None
// @subindex Scripting Database
// @index script | movingobject


// @script | Obj_LookAtObject |
// Returns true if the object will rotate itself to point in the required direction. Ie, if
// the object is already pointing the right way, the command will return false.
// @parmopt name | lockAxis | | can lock any two axes (LOCK_X, LOCK_Y, LOCK_Z)
// @parmopt float | time | vel/acceleration | in seconds
// @parmopt float | speed | 360  | angular velocity in degrees per second
// @parmopt float | acceleration | 0 | angular acceleration in degrees per second
// per second
// @parmopt name | name | | name of object
// @parmopt name | type | | type of object to look at - will look at closest if
// there are several in the world


// @script | Obj_Flip |


// @script | Obj_ObjectInRadius |
// @parmopt name | name | | use one of: name, prefix, or type
// @parmopt name | prefix | | use one of: name, prefix, or type
// @parmopt name | type | | use one of: name, prefix, or type
// (type values are skater, ped, car)
// @parm float | radius | radius in feet


// @script | Obj_ObjectInRect |
// @parmopt float | angle | 0 | in degrees - default is
// along the direction the object is facing
// @parmopt float | height | (height of object) |
// @parmopt float | distance | (length of object) | in feet -
// offset by half of the object in the direction determined by the angle
// @parmopt float | width | (width of object) | in feet
// @parmopt vector | offset | | in feet - the rectangle by default will be located
// sticking out of the XZ plane (or XY plane in Max coords ),
// rotated by number of degrees in angle parameter
// @flag debug | just a parameter to turn on debugging info,
// to quickly set up rectangles on an object.
// @parmopt name | name | | use one of: name, prefix, or type
// @parmopt name | prefix | | use one of: name, prefix, or type
// @parmopt name | type | | use one of: name, prefix, or type
// (type values are skater, ped, car)


// @script | Obj_ObjectNotInRect |
// @parmopt float | angle | 0 | in degrees - default is
// along the direction the object is facing
// @parmopt float | height | (height of object) |
// @parmopt float | distance | (length of object) | in feet -
// offset by half of the object in the direction determined by the angle
// @parmopt float | width | (width of object) | in feet
// @parmopt vector | offset | | in feet - the rectangle by default will be located
// sticking out of the XZ plane (or XY plane in Max coords ),
// rotated by number of degrees in angle parameter
// @flag debug | just a parameter to turn on debugging info,
// to quickly set up rectangles on an object.
// @parmopt name | name | | use one of: name, prefix, or type
// @parmopt name | prefix | | use one of: name, prefix, or type
// @parmopt name | type | | use one of: name, prefix, or type
// (type values are skater, ped, car)


// @script | Obj_SetBodyShape | Sets the body shape for this object
// @parm structure | body_shape | a list of per-bone scales (see scaling.q for format)


// @end
// \skate5\code\sk\objects\MovingObject.cpp end
// \skate5\code\sk\objects\ped.cpp begin
// @DOC ped
// @module ped | None
// @subindex Scripting Database
// @index script | ped
// @module ped | None
// @subindex Scripting Database
// @index script | ped


// @end
// \skate5\code\sk\objects\ped.cpp end
// \skate5\code\sk\objects\skater.cpp begin
// @DOC skater
// @module skater | None
// @subindex Scripting Database
// @index script | skater
// @module skater | None
// @subindex Scripting Database
// @index script | skater


// @script | MoveToRandomRestart | moves the skater to a random
// restart node


// @script | SkaterIsNamed | true if skater name matches specified name
// @uparm name | skater name


// @script | RemoveSkaterFromWorld |


// @script | AddSkaterToWorld |


// @script | KillSkater | Killskater will reset the skater
// to a node, and set his speed to 0. If this command is
// run from a node, and that node is linked to a restart
// node, then the skater will skip to that restart node,
// and the script in that restart node will be executed
// @parmopt name | Node | | name of node to jump to


// @script | SparksOn | turn sparks on
// @flag RailNotRequired |


// @script | SparksOff | turn sparks off


// @script | BloodOff | turn blood off
// @parm string | bone | bone name


// @script | Die | can't be called on the player


// @script | ShouldMongo | true if should mongo


// @script | SetCustomRestart |  Skater command to set the current position as the "custom restart point"
// and also to query or clear the status of this restart, based on:
// @flag set | set the restart
// @flag clear | clear the restart
// if no flags are passed, then it will return true if restart point is valid


// @script | SkipToCustomRestart |  Skater command to jump to previously set custom restart


// @script | GetStat |  Get a stat value in the float stat_value, so it can be used in a script expression
// @parm int | Stat | index of stat in stat array, see


// @script | GetScriptedStat |  Get a stat value in the float stat_value
// parameters are as used in physics.q
// and you would generally pass in a structure, like Skater_Max_Speed_Stat
// rather than the individual values


// @script | GetSkaterNumber | Gets the skater number, and puts it into a parameter called
// SkaterNumber


// @end
// \skate5\code\sk\objects\skater.cpp end
// \skate5\code\Gel\ASSMAN\AssMan.cpp begin
// @DOC Assman
// @module Assman | None
// @subindex Scripting Database
// @index script | Assman
// @module Assman | None
// @subindex Scripting Database
// @index script | Assman


// @end
// \skate5\code\Gel\ASSMAN\AssMan.cpp end
// \skate5\code\Gel\OBJECT\object.cpp begin
// @DOC object.cpp
// @module object.cpp | None
// @subindex Scripting Database
// @index script | object.cpp
// @module object | None
// @subindex Scripting Database
// @index script | object


// @script | Obj_GetId |


// @script | Obj_FlagSet | Check to see if a flag has been set.  Flags can
// be defined anywhere, but you should keep them in your personal scripts file.
// It is important that you prefix all flags with your initials to ensure that
// there are no conflicts with the other designers.
// <nl>Example 1:
// <nl>MJD_LAMP_GOT_BROKEN = 14
// <nl>MJD_LAMP_GOT_HIT = 15
// <nl>MJD_LAMP_GOT_DISABLED = 16
// <nl>if Obj_FlagSet 15
// <nl>    Obj_ClearFlag MJD_LAMP_GOT_HIT
// <nl>    WiggleProfusely
// <nl>endif
// <nl>Example 2:
// <nl>if Obj_FlagSet MJD_LAMP_GOT_HIT clear
// <nl>    WiggleProfusely
// <nl>endif
// <nl>Example 3:
// <nl>If Obj_FlagSet JKU_FLAG_PED_START  // JKU_FLAG_PED_START would be defined in JKU_Scripts.q
// <nl>     Printf “Yes”
// <nl>endif
// @flag all | Clear all flags
// @flag clear | Clear the flag
// @flag reset | I just added a 'reset' flag you can send in to clear
// the flag after checking it, if it's set


// @script | Obj_FlagNotSet | Check to see if a flag has not been set.


// @script | Obj_ClearFlag | Object member function which clears the specified flag or flags.
// <nl>There are 3 ways of using it, it can clear just one flag, or an array of flags,
// or all the flags.
// <nl>Example 1:
// <nl>Obj_ClearFlag JKU_FLAG_PED_START  // Set the flag to 0
// <nl>Example 2:
// <nl>Obj_ClearFlag [ JKU_FLAG_PED_START JKU_FLAG_PED_STOP ]  // Clears an array of flags
// <nl>Example 3:
// <nl>Obj_ClearFlag All  // Clears all the flags.
// @flag all | Clear all the flags


// @script | Obj_SetFlag | Sets the flag (or an array of flags) on an object.
// <nl>Same parameters as Obj_ClearFlag (except doesn't recognize the
// 'all' parameter).


// @script | Obj_KillSpawnedScript | Kills a spawned script.  Can be passeed a name or id.
// @parm name | name | Name of the script you want to spawn (no quotes)
// @parm name | id | id of the script you want to spawn (no quotes)


// @script | Obj_SpawnScript | Causes the object to run a script, in parallel
// to whatever script is running on the object.
// @flag ScriptName | Name of the script you want to spawn (no quotes)
// @parmopt name | Params | {} | Any parameters you want to pass to the script being
// spawned.  Must surround params in { }


// @script | Obj_SwitchScript | Causes the object to replace the current script
// attached to it with the script specified by ScriptName. <nl>
// Can use the pass params just like Obj_SpawnScript.
// @flag ScriptName | Name of the script you want to spawn (no quotes)


// @script | OnExceptionRun | run the specified script on exception
// @uparm name | script name to run
// can be called without a parameter to clear it
//		case 0x2c0c9e7b: // OnExceptionRun


// @end
// \skate5\code\Gel\OBJECT\object.cpp end
// \skate5\code\Gel\OBJECT\objtrack.cpp begin
// @DOC objtrack
// @module objtrack | None
// @subindex Scripting Database
// @index script | objtrack
// @module objtrack | None
// @subindex Scripting Database
// @index script | bails


// @script | LaunchEvent |
// @parm name | type | event type
// @parm structure | data |


// @end
// \skate5\code\Gel\OBJECT\objtrack.cpp end
// \skate5\code\Gfx\2D\ScreenElemMan.cpp begin
// @DOC ScreenElemMan
// @module ScreenElemMan | None
// @subindex Scripting Database
// @index script | ScreenElemMan
// @module ScreenElemMan | None
// @subindex Scripting Database
// @index script | ScreenElemMan


// @script | TextElementConcatenate | this will append the given string on the end of the
// current text element's string
// @parm name | id | the id of the element
// @uparm "string" | the string to append


// @script | TextElementBackspace | removes one character from the text element.  This will
// return false if the text element is already empty
// @parm name | id | the element id


// @script | GetTextElementString | this returns the current string for the specified
// text element.  The string is returned in the script's params (string).
// @parm name | id | the text element id


// @script | GetTextElementLength | returns the length of the specified text element
// in the scripts params (length)
// @parm name | id | the text element's id


// @script | MenuSelectedIndexIs | returns true if the selected item in the vmenu is
// the item specified.  Must be called with either an index, the "first" flag, or the "last" flag
// @uparmopt 1 | some index value (first item is index 0)
// @flag first | checks if the selected item is the first item
// @flag last | checks if the selected item is the last item


// @script | ScreenElementExists | returns true if the given screen element exists
// @parm name | id | the id to look for...supports compound id's


// @script | GetScreenElementProps | writes the props of the given screen element to the
// calling script's params
// @parm name | id | the id of the screen element
// @flag | dont_assert


// @end
// \skate5\code\Gfx\2D\ScreenElemMan.cpp end
// \skate5\code\Gfx\NxImposter.cpp begin
// @DOC nximposter
// @module nximposter | None
// @subindex Scripting Database
// @index script | nximposter
// @module nximposter | None
// @subindex Scripting Database
// @index script | nximposter


// @end
// \skate5\code\Gfx\NxImposter.cpp end
// \skate5\code\Gfx\NxLightMan.cpp begin
// @DOC NxLightMan
// @module NxLightMan | None
// @subindex Scripting Database
// @index script | NxLightMan
// @module NxLightMan | None
// @subindex Scripting Database
// @index script | NxLightMan


// @script | SetLightAmbientColor | Sets the global light ambient color
// @parm int | r | Red
// @parm int | g | Green
// @parm int | b | Blue


// @script | SetLightDirection | Sets the unit direction vector of a global light
// @parm int | index | Light number
// @parm vector | direction | Unit direction vector (overrides heading and pitch)
// @parm float | heading | Heading angle (in degrees)
// @parm float | pitch | Pitch angle (in degrees)


// @script | SetLightDiffuseColor | Sets the diffuse color of a global light
// @parm int | index | Light number
// @parm int | r | Red
// @parm int | g | Green
// @parm int | b | Blue


// @script | GetLightCurrentColor | Gets the rgb values for ambient and directional lights


// @script | DrawDirectionalLightLines | Draws two lines to represent the directional lights


// @end
// \skate5\code\Gfx\NxLightMan.cpp end
// \skate5\code\Gfx\NxLoadScreen.cpp begin
// @DOC NxLoadScreen
// @module NxLoadScreen | None
// @subindex Scripting Database
// @index script | NxLoadScreen
// @module NxLoadScreen | None
// @subindex Scripting Database
// @index script | NxLoadScreen


// @script | SetLoadingBarPos | Sets the position of the loading bar
// @parm int | x | X position of bar
// @parm int | y | Y position of bar


// @script | SetLoadingBarSize | Sets the size of the loading bar
// @parm int | width | Width of bar
// @parm int | height | Heigh of bar


// @script | SetLoadingBarStartColor | Sets the color of the left side of the loading bar
// @parm int | r | Red
// @parm int | g | Green
// @parm int | b | Blue


// @script | SetLoadingBarEndColor | Sets the color of the right side of the loading bar
// @parm int | r | Red
// @parm int | g | Green
// @parm int | b | Blue


// @script | SetLoadingBarBorder | Sets the size of the loading bar border
// @parm int | width | Width of bar border
// @parm int | height | Heigh of bar border


// @script | SetLoadingBarBorderColor | Sets the color of the loading bar border
// @parm int | r | Red
// @parm int | g | Green
// @parm int | b | Blue


// @end
// \skate5\code\Gfx\NxLoadScreen.cpp end
// \skate5\code\Gfx\NxTexMan.cpp begin
// @DOC nxtexman
// @module nxtexman | None
// @subindex Scripting Database
// @index script | nxtexman
// @module nxtexman | None
// @subindex Scripting Database
// @index script | nxtexman


// @script | LoadTexture | Loads a 2D sprite texture
// @parm string |  | path and name of texture
// @flag no_vram_alloc | won't allocate in vram


// @script | UnloadTexture | Unloads a 2D sprite texture
// @parm string |  | name of texture


// @script | AddTextureToVram | Puts 2D sprite texture into VRAM (so it is drawable)
// @parm string |  | name of texture


// @script | RemoveTextureFromVram | Removes 2D sprite texture from VRAM
// @parm string |  | name of texture
// @flag no_assert | won't assert on failure


// @script | OffsetTexture | Move texture (cropping the part that moves off and filling in the new parts with
// either the old edge or a supplied fill color)
// @parm name |  | name of texture
// @parm int | x_offset | x offset in pixels
// @parm int | y_offset | y offset in pixels
// @parmopt int | fill_r | 128 | fill color red component
// @parmopt int | fill_g | 128 | fill color green component
// @parmopt int | fill_b | 128 | fill color blue component
// @parmopt int | fill_a | 128 | fill color alpha component


// @script | AdjustTextureRegion | Stretches and shrinks a texture region from the start point to the end point
// @parm name |  | name of texture
// @parm int | xpos | X position of regiom
// @parm int | ypos | Y position of regiom
// @parm int | width | width of regiom
// @parm int | height | height of regiom
// @parm int | split_axis | axis where the split line crosses (0 = X, 1 = Y)
// @parm int | start_point | split line start point on axis
// @parm int | end_point | split line end point on axis


// @script | PullTextureToEdge | Pull texture from point along the axis by num_pixels (+ or - determines the direction)
// and crop anything going outside the texture border.
// @parm name |  | name of texture
// @parm int | point | pull point on axis
// @parm int | axis | axis to pull along (0 = X, 1 = Y)
// @parm int | num_pixels | number of pixels (+ or - determines the direction)


// @script | PushTextureToPoint | Push texture to point along the axis by num_pixels (+ or - determines the direction)
// and either stretch the edge line or fill it in with a fill color.
// @parm name |  | name of texture
// @parm int | point | pull point on axis
// @parm int | axis | axis to pull along (0 = X, 1 = Y)
// @parm int | num_pixels | number of pixels (+ or - determines the direction)
// @parmopt int | fill_r | 128 | fill color red component
// @parmopt int | fill_g | 128 | fill color green component
// @parmopt int | fill_b | 128 | fill color blue component
// @parmopt int | fill_a | 128 | fill color alpha component


// @script | CopyTexture | Copy 2D sprite texture into a new texture
// @parm name | src | name of texture
// @parm name | new | name of new texture


// @script | CombineTextures | Combine two textures
// @parm name | src | name of orig texture (and final texture if no new texture is supplied)
// @parm name | top | name of top additional texture
// @parmopt name | new | | name of new destination texture
// @parmopt flag | no_palette_gen | | use original palette (faster)


// @end
// \skate5\code\Gfx\NxTexMan.cpp end
// \skate5\code\Gfx\NxViewMan.cpp begin
// @DOC nxviewman
// @module nxviewman | None
// @subindex Scripting Database
// @index script | nxviewman
// @module nxviewman | None
// @subindex Scripting Database
// @index script | nxviewman


// @script | SetScreenMode | Sets the way the screen will be split up into separate
// viewports in the game. If there is more than one viewport, and multiple skaters
// are active, then each skater will get his own viewport
// @uparm One_Camera | the mode to use - one of the following: <nl>
// One_Camera <nl>
// Split_Vertical <nl>
// Split_Horizontal <nl>
// Split_Quarters


// @script | Set2DIn3DSpaceParams | Sets the parameters for the 2D Screen Elements in 3D space
// @parmopt float | noscale_distance | 100.0 | Distance at which the 3D scale is equal to 1.0 (in inches)
// @parmopt float | max_scale | 3.0 | Maximum 3D scale
// @parmopt float | min_scale | 0.0 | Minimum 3D scale


// @end
// \skate5\code\Gfx\NxViewMan.cpp end
// \skate5\code\Sys\FILE\ngc\p_pre.cpp begin
// @DOC pre
// @module pre | None
// @subindex Scripting Database
// @index script | pre
// @module pre | None
// @subindex Scripting Database
// @index script | pre


// @script | InPreFile |
// @uparm "string" | filename


// @script | LoadPreFile |
// @uparm "string" | filename
// @flag dont_assert |


// @script | UnloadPreFile |
// @flag BoardsPre |
// @flag dont_assert |
// @uparm "string" | filename


// @end
// \skate5\code\Sys\FILE\ngc\p_pre.cpp end
// \skate5\code\Sys\FILE\pip.cpp begin
// @DOC pip
// @module pip | None
// @subindex Scripting Database
// @index script | pip
// @module pip | None
// @subindex Scripting Database
// @index script | pip
// TODO
// Use Shrink to shrink the memory block to get rid of the 2048 padding at the end.
// (This will only be effective when the bottom-up heap is being used though)
// TODO but non-essential:
// Make Unload work if passed the pointer.
// Make GetFileSize work if passed the pointer.
// 11Dec02 JCB - Andre wanted me to use tolower() instead of strncmpi()


// @script | LoadPipPre |
// @uparm "string" | filename
// @parmopt name | heap | 0 (checksum value) | Which heap to use.
// Possible values are TopDown or BottomUp
// If no heap is specified it will use whatever the current heap is.


// @script | UnLoadPipPre |
// @uparm "string" | filename


// @script | DumpPipPreStatus | Prints the status of the currently loaded pre files.
// @flag ShowPreedFiles | Lists all the files contained within each pre, together with their usage value.
// @flag ShowUnPreedFiles | Lists all the files currently open which were not in a pre,
// so were individually opened.
// @flag ShowOnlyOpenFiles | When listing the files in each pre, only display those whose usage is
// greater than zero.


// @end
// \skate5\code\Sys\FILE\pip.cpp end
// \skate5\code\Sys\FILE\PRE.cpp begin
// @DOC pre
// @module pre | None
// @subindex Scripting Database
// @index script | pre
// @module pre | None
// @subindex Scripting Database
// @index script | pre


// @script | InPreFile |
// @uparm "string" | filename


// @script | LoadPreFile |
// @uparm "string" | filename
// @flag async | Load Asynchronously
// @flag dont_assert |
// @flag use_bottom_up_heap |


// @script | UnloadPreFile |
// @flag BoardsPre |
// @flag dont_assert |
// @uparm "string" | filename


// @script | IsLoadPreFinished | Returns true if Pre file has finished loading
// @uparm "string" | filename


// @script | AllLoadPreFinished | Returns true if all LoadPre commands have completed


// @script | WaitLoadPre | Waits for Pre file to finished loading
// @uparm "string" | filename


// @script | WaitAllLoadPre | Waits for all Pre files to finished loading


// @end
// \skate5\code\Sys\FILE\PRE.cpp end
//