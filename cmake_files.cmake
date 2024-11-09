#This File Adds all the Code Files to the project and sets up Optional Folders for MSVC
#Then at the end, it adds the monolithic executable with ${BIN_NAME}

# Core
source_group("Core")
set(CORE_DEBUG
	"${SRC_DIR}/Core/Debug/Wn32/P_debug.cpp"
	"${SRC_DIR}/Core/Debug/Assert.cpp"
	"${SRC_DIR}/Core/Debug/Debug.cpp"
	"${SRC_DIR}/Core/Debug/log.cpp"
	"${SRC_DIR}/Core/Debug/Checks.h"
	"${SRC_DIR}/Core/Debug/Mem_stat.h"
	"${SRC_DIR}/Core/Debug/Messages.h"
	"${SRC_DIR}/Core/Debug/Module.h"
	"${SRC_DIR}/Core/Debug/Project.h"
	"${SRC_DIR}/Core/Debug/Signatrs.h"
)
source_group("Core/Debug" FILES ${CORE_DEBUG})

set(CORE_LIST
	"${SRC_DIR}/Core/List/Head.h"
	"${SRC_DIR}/Core/List/list.cpp"
	"${SRC_DIR}/Core/List/Node.h"
	"${SRC_DIR}/Core/List/Search.h"
)
source_group("Core/List" FILES ${CORE_LIST})

set(CORE_MATH
	"${SRC_DIR}/Core/Math/Geometry.cpp"
	"${SRC_DIR}/Core/Math/Geometry.h"
	"${SRC_DIR}/Core/Math/math.cpp"
	"${SRC_DIR}/Core/Math/math.h"
	"${SRC_DIR}/Core/Math/matrix.cpp"
	"${SRC_DIR}/Core/Math/matrix.h"
	"${SRC_DIR}/Core/Math/matrix.inl"
	"${SRC_DIR}/Core/Math/quat.h"
	"${SRC_DIR}/Core/Math/quat.inl"
	"${SRC_DIR}/Core/Math/rect.h"
	"${SRC_DIR}/Core/Math/rot90.cpp"
	"${SRC_DIR}/Core/Math/rot90.h"
	"${SRC_DIR}/Core/Math/slerp.cpp"
	"${SRC_DIR}/Core/Math/slerp.h"
	"${SRC_DIR}/Core/Math/vector.cpp"
	"${SRC_DIR}/Core/Math/vector.h"
	"${SRC_DIR}/Core/Math/vector.inl"
)
source_group("Core/Math" FILES ${CORE_MATH})

set(CORE_STRING
	"${SRC_DIR}/Core/String/CString.cpp"
	"${SRC_DIR}/Core/String/CString.h"
	"${SRC_DIR}/Core/String/stringutils.cpp"
	"${SRC_DIR}/Core/String/stringutils.h"
)
source_group("Core/String" FILES ${CORE_STRING})

set(CORE_SUPPORT
	"${SRC_DIR}/Core/Support/class.cpp"
	"${SRC_DIR}/Core/Support/class.h"
	"${SRC_DIR}/Core/Support/Lock.h"
	"${SRC_DIR}/Core/Support/Ref.h"
	"${SRC_DIR}/Core/Support/support.h"
)
source_group("Core/Support" FILES ${CORE_SUPPORT})

set(CORE_TASK
	"${SRC_DIR}/Core/Task/Hook.h"
	"${SRC_DIR}/Core/Task/List.h"
	"${SRC_DIR}/Core/Task/Stack.h"
	"${SRC_DIR}/Core/Task/Task.cpp"
	"${SRC_DIR}/Core/Task/Task.h"
	"${SRC_DIR}/Core/Task/Tlist.cpp"
	"${SRC_DIR}/Core/Task/Tstack.cpp"
)
source_group("Core/Task" FILES ${CORE_TASK})

set(CORE_THREAD
	"${SRC_DIR}/Core/Thread/wn32/t_thread.cpp"
	"${SRC_DIR}/Core/Thread/wn32/t_thread.h"
)
source_group("Core/Thread" FILES ${CORE_THREAD})

set(CORE
	"${SRC_DIR}/Core/compress.cpp"
	"${SRC_DIR}/Core/compress.h"
	"${SRC_DIR}/Core/crc.cpp"
	"${SRC_DIR}/Core/crc.h"
	"${SRC_DIR}/Core/Debug.h"
	"${SRC_DIR}/Core/Defines.h"
	"${SRC_DIR}/Core/Defines_IDA.h"
	"${SRC_DIR}/Core/DynamicTable.cpp"
	"${SRC_DIR}/Core/DynamicTable.h"
	"${SRC_DIR}/Core/flags.h"
	"${SRC_DIR}/Core/glue.h"
	"${SRC_DIR}/Core/HashTable.h"
	"${SRC_DIR}/Core/List.h"
	"${SRC_DIR}/Core/log.h"
	"${SRC_DIR}/Core/LookupTable.h"
	"${SRC_DIR}/Core/LookupTable.cpp"
	"${SRC_DIR}/Core/macros.h"
	"${SRC_DIR}/Core/allmath.h"
	"${SRC_DIR}/Core/singleton.h"
	"${SRC_DIR}/Core/StringHashTable.h"
	"${SRC_DIR}/Core/support.h"
	"${SRC_DIR}/Core/Task.h"
	"${SRC_DIR}/Core/thread.h"
	"${SRC_DIR}/Core/TimestampedFlag.h"
	"${SRC_DIR}/Core/Xbox_SSE.h"
)
source_group("Core" FILES ${CORE})

set(CORE_FILES ${CORE_DEBUG} ${CORE_LIST} ${CORE_MATH} ${CORE_STRING} ${CORE_SUPPORT} ${CORE_TASK} ${CORE_THREAD} ${CORE})

###########################################
# GEL (Game Engine Library)				  #				
###########################################

set(GEL_ASSMAN
	"${SRC_DIR}/Gel/AssMan/animasset.cpp"
	"${SRC_DIR}/Gel/AssMan/animasset.h"
	"${SRC_DIR}/Gel/AssMan/asset.cpp"
	"${SRC_DIR}/Gel/AssMan/asset.h"
	"${SRC_DIR}/Gel/AssMan/assettypes.h"
	"${SRC_DIR}/Gel/AssMan/AssMan.cpp"
	"${SRC_DIR}/Gel/AssMan/AssMan.h"
	"${SRC_DIR}/Gel/AssMan/cutsceneasset.cpp"
	"${SRC_DIR}/Gel/AssMan/cutsceneasset.h"
	"${SRC_DIR}/Gel/AssMan/NodeArrayAsset.cpp"
	"${SRC_DIR}/Gel/AssMan/NodeArrayAsset.h"
	"${SRC_DIR}/Gel/AssMan/refasset.cpp"
	"${SRC_DIR}/Gel/AssMan/refasset.h"
	"${SRC_DIR}/Gel/AssMan/skeletonasset.cpp"
	"${SRC_DIR}/Gel/AssMan/skeletonasset.h"
	"${SRC_DIR}/Gel/AssMan/skinasset.cpp"
	"${SRC_DIR}/Gel/AssMan/skinasset.h"
)
source_group("Gel/AssMan" FILES ${GEL_ASSMAN})

set(GEL_COLLISION
	"${SRC_DIR}/Gel/Collision/BatchTriColl.cpp"
	"${SRC_DIR}/Gel/Collision/BatchTriColl.h"
	"${SRC_DIR}/Gel/Collision/CollCache.cpp"
	"${SRC_DIR}/Gel/Collision/CollCache.h"
	"${SRC_DIR}/Gel/Collision/CollEnums.h"
	"${SRC_DIR}/Gel/Collision/Collision.cpp"
	"${SRC_DIR}/Gel/Collision/Collision.h"
	"${SRC_DIR}/Gel/Collision/CollTriData.cpp"
	"${SRC_DIR}/Gel/Collision/CollTriData.h"
	"${SRC_DIR}/Gel/Collision/MovCollMan.cpp"
	"${SRC_DIR}/Gel/Collision/MovCollMan.h"
)
source_group("Gel/Collision" FILES ${GEL_COLLISION})

set(GEL_COMPONENTS
	"${SRC_DIR}/Gel/Components/BouncyComponent.h"
	"${SRC_DIR}/Gel/Components/CameraComponent.cpp"
	"${SRC_DIR}/Gel/Components/CameraComponent.h"
	"${SRC_DIR}/Gel/Components/CameraLookAroundComponent.cpp"
	"${SRC_DIR}/Gel/Components/CameraLookAroundComponent.h"
	"${SRC_DIR}/Gel/Components/CameraUtil.cpp"
	"${SRC_DIR}/Gel/Components/CameraUtil.h"
	"${SRC_DIR}/Gel/Components/CollideAndDieComponent.cpp"
	"${SRC_DIR}/Gel/Components/CollideAndDieComponent.h"
	"${SRC_DIR}/Gel/Components/FloatingLabelComponent.cpp"
	"${SRC_DIR}/Gel/Components/FloatingLabelComponent.h"
#	"${SRC_DIR}/Gel/Components/GunslingerCameraLookAroundComponent.cpp"
#	"${SRC_DIR}/Gel/Components/GunslingerWalkCameraComponent.cpp"
#	"${SRC_DIR}/Gel/Components/GunslingerWalkComponent.cpp"
#	"${SRC_DIR}/Gel/Components/HorseCameraComponent.cpp"
#	"${SRC_DIR}/Gel/Components/HorseCameraComponent.h"
	"${SRC_DIR}/Gel/Components/HorseComponent.cpp"
	"${SRC_DIR}/Gel/Components/HorseComponent.h"
	"${SRC_DIR}/Gel/Components/InputComponent.cpp"
	"${SRC_DIR}/Gel/Components/InputComponent.h"
	"${SRC_DIR}/Gel/Components/ModelLightUpdateComponent.cpp"
	"${SRC_DIR}/Gel/Components/ModelLightUpdateComponent.h"
	"${SRC_DIR}/Gel/Components/MovableContactComponent.cpp"
	"${SRC_DIR}/Gel/Components/MovableContactComponent.h"
	"${SRC_DIR}/Gel/Components/NearComponent.cpp"
	"${SRC_DIR}/Gel/Components/NearComponent.h"
	"${SRC_DIR}/Gel/Components/NodeArrayComponent.cpp"
	"${SRC_DIR}/Gel/Components/NodeArrayComponent.h"
	"${SRC_DIR}/Gel/Components/ObjectHookManagerComponent.cpp"
	"${SRC_DIR}/Gel/Components/ObjectHookManagerComponent.h"
	"${SRC_DIR}/Gel/Components/ParticleComponent.cpp"
	"${SRC_DIR}/Gel/Components/ParticleComponent.h"
	"${SRC_DIR}/Gel/Components/PedLogicComponent.cpp"
	"${SRC_DIR}/Gel/Components/PedLogicComponent.h"
	"${SRC_DIR}/Gel/Components/ProximTriggerComponent.cpp"
	"${SRC_DIR}/Gel/Components/ProximTriggerComponent.h"
	"${SRC_DIR}/Gel/Components/RailManagerComponent.cpp"
	"${SRC_DIR}/Gel/Components/RailManagerComponent.h"
	"${SRC_DIR}/Gel/Components/RibbonComponent.cpp"
	"${SRC_DIR}/Gel/Components/RibbonComponent.h"
	"${SRC_DIR}/Gel/Components/RiderComponent.cpp"
	"${SRC_DIR}/Gel/Components/RiderComponent.h"
	"${SRC_DIR}/Gel/Components/SetDisplayMatrixComponent.cpp"
	"${SRC_DIR}/Gel/Components/SetDisplayMatrixComponent.h"
	"${SRC_DIR}/Gel/Components/SkaterCameraComponent.cpp"
	"${SRC_DIR}/Gel/Components/SkaterCameraComponent.h"
	"${SRC_DIR}/Gel/Components/SkitchComponent.cpp"
	"${SRC_DIR}/Gel/Components/SkitchComponent.h"
	"${SRC_DIR}/Gel/Components/StaticVehicleComponent.cpp"
	"${SRC_DIR}/Gel/Components/StaticVehicleComponent.h"
	"${SRC_DIR}/Gel/Components/StatsManagerComponent.cpp"
	"${SRC_DIR}/Gel/Components/StatsManagerComponent.h"
	"${SRC_DIR}/Gel/Components/StreamComponent.cpp"
	"${SRC_DIR}/Gel/Components/StreamComponent.h"
	"${SRC_DIR}/Gel/Components/SuspendComponent.cpp"
	"${SRC_DIR}/Gel/Components/SuspendComponent.h"
	"${SRC_DIR}/Gel/Components/TriggerComponent.cpp"
	"${SRC_DIR}/Gel/Components/TriggerComponent.h"
	"${SRC_DIR}/Gel/Components/VehicleSoundComponent.cpp"
	"${SRC_DIR}/Gel/Components/VehicleSoundComponent.h"
	"${SRC_DIR}/Gel/Components/VelocityComponent.cpp"
	"${SRC_DIR}/Gel/Components/VelocityComponent.h"
	"${SRC_DIR}/Gel/Components/VibrationComponent.cpp"
	"${SRC_DIR}/Gel/Components/VibrationComponent.h"
	"${SRC_DIR}/Gel/Components/WalkCameraComponent.cpp"
	"${SRC_DIR}/Gel/Components/WalkCameraComponent.h"
	"${SRC_DIR}/Gel/Components/WalkComponent.cpp"
	"${SRC_DIR}/Gel/Components/WalkComponent.h"
	"${SRC_DIR}/Gel/Components/WalkHangUtil.cpp"
	"${SRC_DIR}/Gel/Components/WalkLadderUtil.cpp"
	"${SRC_DIR}/Gel/Components/animationcomponent.cpp"
	"${SRC_DIR}/Gel/Components/animationcomponent.h"
	"${SRC_DIR}/Gel/Components/avoidcomponent.cpp"
	"${SRC_DIR}/Gel/Components/avoidcomponent.h"
	"${SRC_DIR}/Gel/Components/bouncycomponent.cpp"
	"${SRC_DIR}/Gel/Components/carphysicscomponent.cpp"
	"${SRC_DIR}/Gel/Components/carphysicscomponent.h"
	"${SRC_DIR}/Gel/Components/collisioncomponent.cpp"
	"${SRC_DIR}/Gel/Components/collisioncomponent.h"
	"${SRC_DIR}/Gel/Components/emptycomponent.cpp"
	"${SRC_DIR}/Gel/Components/emptycomponent.h"
	"${SRC_DIR}/Gel/Components/lockobjcomponent.cpp"
	"${SRC_DIR}/Gel/Components/lockobjcomponent.h"
	"${SRC_DIR}/Gel/Components/modelcomponent.cpp"
	"${SRC_DIR}/Gel/Components/modelcomponent.h"
	"${SRC_DIR}/Gel/Components/motioncomponent.cpp"
	"${SRC_DIR}/Gel/Components/motioncomponent.h"
	"${SRC_DIR}/Gel/Components/rigidbodycomponent.cpp"
	"${SRC_DIR}/Gel/Components/rigidbodycomponent.h"
	"${SRC_DIR}/Gel/Components/shadowcomponent.cpp"
	"${SRC_DIR}/Gel/Components/shadowcomponent.h"
	"${SRC_DIR}/Gel/Components/skeletoncomponent.cpp"
	"${SRC_DIR}/Gel/Components/skeletoncomponent.h"
	"${SRC_DIR}/Gel/Components/soundcomponent.cpp"
	"${SRC_DIR}/Gel/Components/soundcomponent.h"
	"${SRC_DIR}/Gel/Components/specialitemcomponent.cpp"
	"${SRC_DIR}/Gel/Components/specialitemcomponent.h"
	"${SRC_DIR}/Gel/Components/trickcomponent.cpp"
	"${SRC_DIR}/Gel/Components/trickcomponent.h"
	"${SRC_DIR}/Gel/Components/vehiclecameracomponent.cpp"
	"${SRC_DIR}/Gel/Components/vehiclecameracomponent.h"
	"${SRC_DIR}/Gel/Components/vehiclecomponent.cpp"
	"${SRC_DIR}/Gel/Components/vehiclecomponent.h"
	"${SRC_DIR}/Gel/Components/weaponcomponent.cpp"
	"${SRC_DIR}/Gel/Components/weaponcomponent.h"
)
source_group("Gel/Components" FILES ${GEL_COMPONENTS})

set(GEL_ENVIRONMENT
	"${SRC_DIR}/Gel/Environment/terrain.cpp"
	"${SRC_DIR}/Gel/Environment/terrain.h"
)
source_group("Gel/Environment" FILES ${GEL_ENVIRONMENT})

set(GEL_INPUT
	"${SRC_DIR}/Gel/Input/InpMan.cpp"
	"${SRC_DIR}/Gel/Input/inpserv.cpp"
)
source_group("Gel/Input" FILES ${GEL_INPUT})

set(GEL_MAINLOOP
	"${SRC_DIR}/Gel/MainLoop/Mainloop.cpp"
)
source_group("Gel/MainLoop" FILES ${GEL_MAINLOOP})

set(GEL_MODULE
	"${SRC_DIR}/Gel/Module/modman.cpp"
	"${SRC_DIR}/Gel/Module/module.cpp"
)
source_group("Gel/Module" FILES ${GEL_MODULE})

set(GEL_MOVIES
	"${SRC_DIR}/Gel/Movies/Movies.cpp"
	"${SRC_DIR}/Gel/Movies/Movies.h"
)
source_group("Gel/Movies" FILES ${GEL_MOVIES})

set(GEL_MUSIC_SDL
	"${SRC_DIR}/Gel/Music/SDL/miniaudio.cpp"	
	"${SRC_DIR}/Gel/Music/SDL/miniaudio.h"	
	"${SRC_DIR}/Gel/Music/SDL/p_music.cpp"	
	"${SRC_DIR}/Gel/Music/SDL/p_music.h"	
	"${SRC_DIR}/Gel/Music/SDL/usersoundtrack.cpp"	
	"${SRC_DIR}/Gel/Music/SDL/usersoundtrack.h"	
)
set(GEL_MUSIC_WIN32
	"${SRC_DIR}/Gel/Music/Win32/p_adpcmfilestream.cpp"	
	"${SRC_DIR}/Gel/Music/Win32/p_adpcmfilestream.h"	
	"${SRC_DIR}/Gel/Music/Win32/p_music.h"	
	"${SRC_DIR}/Gel/Music/Win32/p_soundtrack.cpp"	
	"${SRC_DIR}/Gel/Music/Win32/p_soundtrack.h"
	"${SRC_DIR}/Gel/Music/Win32/p_wmafilestream.cpp"
	"${SRC_DIR}/Gel/Music/Win32/p_wmafilestream.h"
	"${SRC_DIR}/Gel/Music/Win32/win32_music.cpp"
)
set(GEL_MUSIC
	"${SRC_DIR}/Gel/Music/music.cpp"
	"${SRC_DIR}/Gel/Music/music.h"
)
source_group("Gel/Music" FILES ${GEL_MUSIC})
source_group("Gel/Music/SDL" FILES ${GEL_MUSIC_SDL})
source_group("Gel/Music/Win32" FILES ${GEL_MUSIC_WIN32})

set(GEL_NET
	"${SRC_DIR}/Gel/Net/net.cpp"	
	"${SRC_DIR}/Gel/Net/net.h"	
	"${SRC_DIR}/Gel/Net/netconn.cpp"	
)
set(GEL_NET_APP
	"${SRC_DIR}/Gel/Net/App/netapp.cpp"
)
set(GEL_NET_CLIENT
	"${SRC_DIR}/Gel/Net/Client/netclnt.cpp"
	"${SRC_DIR}/Gel/Net/Client/netclnt.h"
)
set(GEL_NET_DISPATCH
	"${SRC_DIR}/Gel/Net/Dispatch/netdsptch.cpp"
)
set(GEL_NET_HANDLER
	"${SRC_DIR}/Gel/Net/Handler/nethndlr.cpp"
)
set(GEL_NET_SERVER
	"${SRC_DIR}/Gel/Net/Server/netserv.cpp"
	"${SRC_DIR}/Gel/Net/Server/netserv.h"
)

source_group("Gel/Net/App" FILES ${GEL_NET_APP})
source_group("Gel/Net/Client" FILES ${GEL_NET_CLIENT})
source_group("Gel/Net/Dispatch" FILES ${GEL_NET_DISPATCH})
source_group("Gel/Net/Handler" FILES ${GEL_NET_HANDLER})
source_group("Gel/Net/Server" FILES ${GEL_NET_SERVER})
source_group("Gel/Net" FILES ${GEL_NET})

set(GEL_OBJECT
	"${SRC_DIR}/Gel/Object/Event.cpp"
	"${SRC_DIR}/Gel/Object/ObjPtr.cpp"
	"${SRC_DIR}/Gel/Object/RefCounted.cpp"
	"${SRC_DIR}/Gel/Object/basecomponent.cpp"
	"${SRC_DIR}/Gel/Object/basecomponent.h"
	"${SRC_DIR}/Gel/Object/compositeobject.cpp"
	"${SRC_DIR}/Gel/Object/compositeobject.h"
	"${SRC_DIR}/Gel/Object/compositeobjectmanager.cpp"
	"${SRC_DIR}/Gel/Object/compositeobjectmanager.h"
	"${SRC_DIR}/Gel/Object/object.cpp"
	"${SRC_DIR}/Gel/Object/objman.cpp"
	"${SRC_DIR}/Gel/Object/objsearch.cpp"
	"${SRC_DIR}/Gel/Object/objtrack.cpp"
)
source_group("Gel/Object" FILES ${GEL_OBJECT})

set(GEL_PREFS
	"${SRC_DIR}/Gel/Prefs/Prefs.cpp"
	"${SRC_DIR}/Gel/Prefs/Prefs.h"
)
source_group("Gel/Prefs" FILES ${GEL_PREFS})

set(GEL_SCRIPTING
	"${SRC_DIR}/Gel/Scripting/array.cpp"
	"${SRC_DIR}/Gel/Scripting/array.h"
	"${SRC_DIR}/Gel/Scripting/checksum.cpp"
	"${SRC_DIR}/Gel/Scripting/checksum.h"
	"${SRC_DIR}/Gel/Scripting/component.cpp"
	"${SRC_DIR}/Gel/Scripting/component.h"
	"${SRC_DIR}/Gel/Scripting/debugger.cpp"
	"${SRC_DIR}/Gel/Scripting/debugger.h"
	"${SRC_DIR}/Gel/Scripting/eval.cpp"
	"${SRC_DIR}/Gel/Scripting/eval.h"
	"${SRC_DIR}/Gel/Scripting/file.cpp"
	"${SRC_DIR}/Gel/Scripting/file.h"
	"${SRC_DIR}/Gel/Scripting/init.cpp"
	"${SRC_DIR}/Gel/Scripting/init.h"
	"${SRC_DIR}/Gel/Scripting/parse.cpp"
	"${SRC_DIR}/Gel/Scripting/parse.h"
	"${SRC_DIR}/Gel/Scripting/script.cpp"
	"${SRC_DIR}/Gel/Scripting/script.h"
	"${SRC_DIR}/Gel/Scripting/scriptcache.cpp"
	"${SRC_DIR}/Gel/Scripting/scriptcache.h"
	"${SRC_DIR}/Gel/Scripting/scriptdefs.h"
	"${SRC_DIR}/Gel/Scripting/skiptoken.cpp"
	"${SRC_DIR}/Gel/Scripting/string.cpp"
	"${SRC_DIR}/Gel/Scripting/string.h"
	"${SRC_DIR}/Gel/Scripting/struct.cpp"
	"${SRC_DIR}/Gel/Scripting/struct.h"
	"${SRC_DIR}/Gel/Scripting/symboltable.cpp"
	"${SRC_DIR}/Gel/Scripting/symboltable.h"
	"${SRC_DIR}/Gel/Scripting/symboltype.cpp"
	"${SRC_DIR}/Gel/Scripting/symboltype.h"
	"${SRC_DIR}/Gel/Scripting/tokens.cpp"
	"${SRC_DIR}/Gel/Scripting/tokens.h"
	"${SRC_DIR}/Gel/Scripting/utils.cpp"
	"${SRC_DIR}/Gel/Scripting/utils.h"
	"${SRC_DIR}/Gel/Scripting/vecpair.cpp"
	"${SRC_DIR}/Gel/Scripting/vecpair.h"
	"${SRC_DIR}/Gel/Scripting/win32functions.cpp"
)
source_group("Gel/Scripting" FILES ${GEL_SCRIPTING})


set(GEL_SOUNDFX_SDL
	"${SRC_DIR}/Gel/SoundFX/SDL/ima.cpp"
	"${SRC_DIR}/Gel/SoundFX/SDL/ima.h"
	"${SRC_DIR}/Gel/SoundFX/SDL/miniaudio.h"
	"${SRC_DIR}/Gel/SoundFX/SDL/Mixer.cpp"
	"${SRC_DIR}/Gel/SoundFX/SDL/Mixer.h"
	"${SRC_DIR}/Gel/SoundFX/SDL/p_sfx.cpp"
	"${SRC_DIR}/Gel/SoundFX/SDL/p_sfx.h"
	"${SRC_DIR}/Gel/SoundFX/SDL/snd.cpp"
	"${SRC_DIR}/Gel/SoundFX/SDL/snd.h"
)
set(GEL_SOUNDFX_WIN32
	"${SRC_DIR}/Gel/SoundFX/Win32/p_sfx.h"
	"${SRC_DIR}/Gel/SoundFX/Win32/skate5fx.h"
	"${SRC_DIR}/Gel/SoundFX/Win32/win32_sfx.cpp"
)
set(GEL_SOUNDFX
	"${SRC_DIR}/Gel/SoundFX/soundfx.cpp"
	"${SRC_DIR}/Gel/SoundFX/soundfx.h"
)
source_group("Gel/SoundFX/SDL" FILES ${GEL_SOUNDFX_SDL})
source_group("Gel/SoundFX/Win32" FILES ${GEL_SOUNDFX_WIN32})
source_group("Gel/SoundFX" FILES ${GEL_SOUNDFX})

set(GEL
	"${SRC_DIR}/Gel/Event.h"
	"${SRC_DIR}/Gel/inpman.h"
	"${SRC_DIR}/Gel/mainloop.h"
	"${SRC_DIR}/Gel/modman.h"
	"${SRC_DIR}/Gel/module.h"
	"${SRC_DIR}/Gel/object.h"
	"${SRC_DIR}/Gel/objman.h"
	"${SRC_DIR}/Gel/ObjPtr.h"
	"${SRC_DIR}/Gel/objsearch.h"
	"${SRC_DIR}/Gel/objserv.h"
	"${SRC_DIR}/Gel/objtrack.h"
	"${SRC_DIR}/Gel/RefCounted.h"
)
source_group("Gel" FILES ${GEL})

set(GEL_FILES 
${GEL_ASSMAN} 
${GEL_COLLISION} 
${GEL_COMPONENTS} 
${GEL_ENVIRONMENT} 
${GEL_INPUT} 
${GEL_MAINLOOP} 
${GEL_MODULE} 
${GEL_MOVIES} 
${GEL_MUSIC_SDL}
${GEL_MUSIC_WIN32} 
${GEL_MUSIC} 
${GEL_NET} 
${GEL_NET_APP}
${GEL_NET_CLIENT} 
${GEL_NET_DISPATCH}
${GEL_NET_HANDLER} 
${GEL_NET_SERVER} 
${GEL_OBJECT}
${GEL_PREFS}
${GEL_SCRIPTING}
${GEL_SOUNDFX_SDL}
${GEL_SOUNDFX_WIN32}
${GEL_SOUNDFX}
${GEL}
)


###########################################
# Gfx									  #				
###########################################

set(GFX_2D
	"${SRC_DIR}/Gfx/2D/BlurEffect.cpp"
	"${SRC_DIR}/Gfx/2D/BlurEffect.h"
	"${SRC_DIR}/Gfx/2D/Element3d.cpp"
	"${SRC_DIR}/Gfx/2D/Element3d.h"
	"${SRC_DIR}/Gfx/2D/Menu2.cpp"
	"${SRC_DIR}/Gfx/2D/Menu2.h"
	"${SRC_DIR}/Gfx/2D/ScreenElemMan.cpp"
	"${SRC_DIR}/Gfx/2D/ScreenElemMan.h"
	"${SRC_DIR}/Gfx/2D/ScreenElement2.cpp"
	"${SRC_DIR}/Gfx/2D/ScreenElement2.h"
	"${SRC_DIR}/Gfx/2D/ScrollingMenu.cpp"
	"${SRC_DIR}/Gfx/2D/ScrollingMenu.h"
	"${SRC_DIR}/Gfx/2D/SpriteElement.cpp"
	"${SRC_DIR}/Gfx/2D/SpriteElement.h"
	"${SRC_DIR}/Gfx/2D/TextElement.cpp"
	"${SRC_DIR}/Gfx/2D/TextElement.h"
	"${SRC_DIR}/Gfx/2D/Window.cpp"
	"${SRC_DIR}/Gfx/2D/Window.h"
)
source_group("Gfx/2D" FILES ${GFX_2D})

set(GFX_DX9
	"${SRC_DIR}/Gfx/DX9/p_NxGeom.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxGeom.h"
	"${SRC_DIR}/Gfx/DX9/p_NxImposter.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxImposter.h"
	"${SRC_DIR}/Gfx/DX9/p_NxLight.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxLight.h"
	"${SRC_DIR}/Gfx/DX9/p_NxLightMan.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxLoadScreen.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxMesh.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxMesh.h"
	"${SRC_DIR}/Gfx/DX9/p_NxModel.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxModel.h"
	"${SRC_DIR}/Gfx/DX9/p_NxParticleRibbonTrail.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxParticleRibbonTrail.h"
	"${SRC_DIR}/Gfx/DX9/p_NxParticleShaded.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxParticleShaded.h"
	"${SRC_DIR}/Gfx/DX9/p_NxParticleStar.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxParticleStar.h"
	"${SRC_DIR}/Gfx/DX9/p_NxSprite.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxSprite.h"
	"${SRC_DIR}/Gfx/DX9/p_NxTextured3dPoly.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxTextured3dPoly.h"
	"${SRC_DIR}/Gfx/DX9/p_NxViewMan.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxViewport.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxViewport.h"
	"${SRC_DIR}/Gfx/DX9/p_NxWin2D.cpp"
	"${SRC_DIR}/Gfx/DX9/p_NxWin2D.h"
	"${SRC_DIR}/Gfx/DX9/p_gfxman.cpp"
	"${SRC_DIR}/Gfx/DX9/p_loadscreen.cpp"
	"${SRC_DIR}/Gfx/DX9/p_memview.cpp"
	"${SRC_DIR}/Gfx/DX9/p_memview.h"
	"${SRC_DIR}/Gfx/DX9/p_nx.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxfont.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxfont.h"
	"${SRC_DIR}/Gfx/DX9/p_nxfontman.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxmiscfx.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxnewparticle.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxnewparticle.h"
	"${SRC_DIR}/Gfx/DX9/p_nxnewparticlemgr.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxnewparticlemgr.h"
	"${SRC_DIR}/Gfx/DX9/p_nxparticle.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxparticle.h"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleflat.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleflat.h"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleglow.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleglow.h"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleglowribbontrail.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleglowribbontrail.h"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleline.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleline.h"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleribbon.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxparticleribbon.h"
	"${SRC_DIR}/Gfx/DX9/p_nxparticlesmooth.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxparticlesmooth.h"
	"${SRC_DIR}/Gfx/DX9/p_nxparticlesmoothribbon.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxparticlesmoothribbon.h"
	"${SRC_DIR}/Gfx/DX9/p_nxparticlesmoothstar.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxparticlesmoothstar.h"
	"${SRC_DIR}/Gfx/DX9/p_nxscene.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxscene.h"
	"${SRC_DIR}/Gfx/DX9/p_nxsector.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxsector.h"
	"${SRC_DIR}/Gfx/DX9/p_nxtexman.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxtexture.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxtexture.h"
	"${SRC_DIR}/Gfx/DX9/p_nxweather.cpp"
	"${SRC_DIR}/Gfx/DX9/p_nxweather.h"
)
source_group("Gfx/DX9" FILES ${GFX_DX9})

set(GFX_DX9_NX
	"${SRC_DIR}/Gfx/DX9/NX/BillboardScreenAlignedVS.h"
	"${SRC_DIR}/Gfx/DX9/NX/BillboardScreenAlignedVS.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/ParticleFlatVS.h"
	"${SRC_DIR}/Gfx/DX9/NX/ParticleFlatVS.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/ParticleNewFlatPointSpriteVS.h"
	"${SRC_DIR}/Gfx/DX9/NX/ParticleNewFlatPointSpriteVS.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/ParticleNewFlatVS.h"
	"${SRC_DIR}/Gfx/DX9/NX/ParticleNewFlatVS.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShader0.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShader0IVA.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShader1.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShader2.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShader3.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShader4.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShader5.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShaderBrighten.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShaderBrightenIVA.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShaderBumpWater.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShaderFocusBlur.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShaderFocusIntegrate.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShaderFocusLookupIntegrate.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShaderNULL.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShaderPointSprite.psh"
	"${SRC_DIR}/Gfx/DX9/NX/PixelShader_ShadowBuffer.psh"
	"${SRC_DIR}/Gfx/DX9/NX/ShadowBufferStaticGeomPS.psh"
	"${SRC_DIR}/Gfx/DX9/NX/ShadowBufferStaticGeomVS.h"
	"${SRC_DIR}/Gfx/DX9/NX/ShadowBufferStaticGeomVS.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_1Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_2Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_3Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_1Weight.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_1Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_1Weight_SBPassThru.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_1Weight_SBPassThru.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_1Weight_UVTransform.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_1Weight_UVTransform.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_2Weight.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_2Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_2Weight_SBPassThru.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_2Weight_SBPassThru.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_2Weight_UVTransform.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_2Weight_UVTransform.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_3Weight.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_3Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_3Weight_SBPassThru.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_3Weight_SBPassThru.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_3Weight_UVTransform.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_3Weight_UVTransform.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_4Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_4Weight_SBPassThru.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_Specular_1Weight.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_Specular_1Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_Specular_2Weight.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_Specular_2Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_Specular_3Weight.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_Specular_3Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVS_VXC_Specular_4Weight.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVertexShader0.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVertexShader1.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVertexShader_SBWrite.h"
	"${SRC_DIR}/Gfx/DX9/NX/WeightedMeshVertexShader_SBWrite.vsh"
	"${SRC_DIR}/Gfx/DX9/NX/anim.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/anim.h"
	"${SRC_DIR}/Gfx/DX9/NX/anim_vertdefs.h"
	"${SRC_DIR}/Gfx/DX9/NX/billboard.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/billboard.h"
	"${SRC_DIR}/Gfx/DX9/NX/chars.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/chars.h"
	"${SRC_DIR}/Gfx/DX9/NX/gamma.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/gamma.h"
	"${SRC_DIR}/Gfx/DX9/NX/grass.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/grass.h"
	"${SRC_DIR}/Gfx/DX9/NX/instance.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/instance.h"
	"${SRC_DIR}/Gfx/DX9/NX/material.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/material.h"
	"${SRC_DIR}/Gfx/DX9/NX/mesh.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/mesh.h"
	"${SRC_DIR}/Gfx/DX9/NX/mipmap.inl"
	"${SRC_DIR}/Gfx/DX9/NX/nx_init.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/nx_init.h"
	"${SRC_DIR}/Gfx/DX9/NX/occlude.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/occlude.h"
	"${SRC_DIR}/Gfx/DX9/NX/particles.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/particles.h"
	"${SRC_DIR}/Gfx/DX9/NX/render.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/render.h"
	"${SRC_DIR}/Gfx/DX9/NX/scene.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/scene.h"
	"${SRC_DIR}/Gfx/DX9/NX/screenfx.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/screenfx.h"
	"${SRC_DIR}/Gfx/DX9/NX/sprite.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/sprite.h"
	"${SRC_DIR}/Gfx/DX9/NX/swizzleformat.h"
	"${SRC_DIR}/Gfx/DX9/NX/texture.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/texture.h"
	"${SRC_DIR}/Gfx/DX9/NX/verlet.cpp"
	"${SRC_DIR}/Gfx/DX9/NX/verlet.h"
	"${SRC_DIR}/Gfx/DX9/NX/xbmemfnt.h"
)
source_group("Gfx/DX9/NX" FILES ${GFX_DX9_NX})

set(GFX_IMAGE
	"${SRC_DIR}/Gfx/Image/ImageBasic.h"
)
source_group("Gfx/Image" FILES ${GFX_IMAGE})

set(GFX
	"${SRC_DIR}/Gfx/AnimController.cpp"
	"${SRC_DIR}/Gfx/AnimController.h"
	"${SRC_DIR}/Gfx/BonedAnim.cpp"
	"${SRC_DIR}/Gfx/BonedAnim.h"
	"${SRC_DIR}/Gfx/BonedAnimTypes.h"
	"${SRC_DIR}/Gfx/CasUtils.cpp"
	"${SRC_DIR}/Gfx/CasUtils.h"
	"${SRC_DIR}/Gfx/CustomAnimKey.cpp"
	"${SRC_DIR}/Gfx/CustomAnimKey.h"
	"${SRC_DIR}/Gfx/FaceMassage.cpp"
	"${SRC_DIR}/Gfx/FaceMassage.h"
	"${SRC_DIR}/Gfx/FaceTexture.cpp"
	"${SRC_DIR}/Gfx/FaceTexture.h"
	"${SRC_DIR}/Gfx/ModelAppearance.cpp"
	"${SRC_DIR}/Gfx/ModelAppearance.h"
	"${SRC_DIR}/Gfx/ModelBuilder.cpp"
	"${SRC_DIR}/Gfx/ModelBuilder.h"
	"${SRC_DIR}/Gfx/NxAnimCache.cpp"
	"${SRC_DIR}/Gfx/NxAnimCache.h"
	"${SRC_DIR}/Gfx/NxFont.cpp"
	"${SRC_DIR}/Gfx/NxFont.h"
	"${SRC_DIR}/Gfx/NxFontMan.cpp"
	"${SRC_DIR}/Gfx/NxFontMan.h"
	"${SRC_DIR}/Gfx/NxGeom.cpp"
	"${SRC_DIR}/Gfx/NxGeom.h"
	"${SRC_DIR}/Gfx/NxHierarchy.h"
	"${SRC_DIR}/Gfx/NxImposter.cpp"
	"${SRC_DIR}/Gfx/NxImposter.h"
	"${SRC_DIR}/Gfx/NxLight.cpp"
	"${SRC_DIR}/Gfx/NxLight.h"
	"${SRC_DIR}/Gfx/NxLightMan.cpp"
	"${SRC_DIR}/Gfx/NxLightMan.h"
	"${SRC_DIR}/Gfx/NxLoadScreen.cpp"
	"${SRC_DIR}/Gfx/NxLoadScreen.h"
	"${SRC_DIR}/Gfx/NxMesh.cpp"
	"${SRC_DIR}/Gfx/NxMesh.h"
	"${SRC_DIR}/Gfx/NxMiscFX.cpp"
	"${SRC_DIR}/Gfx/NxMiscFX.h"
	"${SRC_DIR}/Gfx/NxModel.cpp"
	"${SRC_DIR}/Gfx/NxModel.h"
	"${SRC_DIR}/Gfx/NxNewParticle.cpp"
	"${SRC_DIR}/Gfx/NxNewParticle.h"
	"${SRC_DIR}/Gfx/NxNewParticleMgr.cpp"
	"${SRC_DIR}/Gfx/NxNewParticleMgr.h"
	"${SRC_DIR}/Gfx/NxQuickAnim.cpp"
	"${SRC_DIR}/Gfx/NxQuickAnim.h"
	"${SRC_DIR}/Gfx/NxScene.cpp"
	"${SRC_DIR}/Gfx/NxScene.h"
	"${SRC_DIR}/Gfx/NxSector.cpp"
	"${SRC_DIR}/Gfx/NxSector.h"
	"${SRC_DIR}/Gfx/NxSkinComponent.cpp"
	"${SRC_DIR}/Gfx/NxSkinComponent.h"
	"${SRC_DIR}/Gfx/NxSprite.cpp"
	"${SRC_DIR}/Gfx/NxSprite.h"
	"${SRC_DIR}/Gfx/NxTexMan.cpp"
	"${SRC_DIR}/Gfx/NxTexMan.h"
	"${SRC_DIR}/Gfx/NxTexture.cpp"
	"${SRC_DIR}/Gfx/NxTexture.h"
	"${SRC_DIR}/Gfx/NxTextured3dPoly.cpp"
	"${SRC_DIR}/Gfx/NxTextured3dPoly.h"
	"${SRC_DIR}/Gfx/NxViewMan.cpp"
	"${SRC_DIR}/Gfx/NxViewMan.h"
	"${SRC_DIR}/Gfx/NxViewport.cpp"
	"${SRC_DIR}/Gfx/NxViewport.h"
	"${SRC_DIR}/Gfx/NxWin2D.cpp"
	"${SRC_DIR}/Gfx/NxWin2D.h"
	"${SRC_DIR}/Gfx/Pose.h"
	"${SRC_DIR}/Gfx/Skeleton.cpp"
	"${SRC_DIR}/Gfx/Skeleton.h"
	"${SRC_DIR}/Gfx/baseanimcontroller.cpp"
	"${SRC_DIR}/Gfx/baseanimcontroller.h"
	"${SRC_DIR}/Gfx/bbox.cpp"
	"${SRC_DIR}/Gfx/bbox.h"
	"${SRC_DIR}/Gfx/blendchannel.cpp"
	"${SRC_DIR}/Gfx/blendchannel.h"
	"${SRC_DIR}/Gfx/camera.cpp"
	"${SRC_DIR}/Gfx/camera.h"
	"${SRC_DIR}/Gfx/debuggfx.cpp"
	"${SRC_DIR}/Gfx/debuggfx.h"
	"${SRC_DIR}/Gfx/gfxman.cpp"
	"${SRC_DIR}/Gfx/gfxman.h"
	"${SRC_DIR}/Gfx/gfxutils.cpp"
	"${SRC_DIR}/Gfx/gfxutils.h"
	"${SRC_DIR}/Gfx/nx.cpp"
	"${SRC_DIR}/Gfx/nx.h"
	"${SRC_DIR}/Gfx/nxflags.h"
	"${SRC_DIR}/Gfx/nxparticle.cpp"
	"${SRC_DIR}/Gfx/nxparticle.h"
	"${SRC_DIR}/Gfx/nxparticlemgr.cpp"
	"${SRC_DIR}/Gfx/nxparticlemgr.h"
	"${SRC_DIR}/Gfx/nxweather.cpp"
	"${SRC_DIR}/Gfx/nxweather.h"
	"${SRC_DIR}/Gfx/shadow.cpp"
	"${SRC_DIR}/Gfx/shadow.h"
	"${SRC_DIR}/Gfx/stdafx.h"
	"${SRC_DIR}/Gfx/subanimcontroller.cpp"
	"${SRC_DIR}/Gfx/subanimcontroller.h"
	"${SRC_DIR}/Gfx/vecfont.cpp"
	"${SRC_DIR}/Gfx/vecfont.h"
)
source_group("Gfx" FILES ${GFX})

set(GFX_FILES ${GFX} ${GFX_IMAGE} ${GFX_DX9_NX} ${GFX_DX9} ${GFX_2D})

###########################################
# Sk (Skate)							  #				
###########################################

set(SK_COMPONENTS
	"${SRC_DIR}/Sk/Components/EditorCameraComponent.cpp"
	"${SRC_DIR}/Sk/Components/EditorCameraComponent.h"
	"${SRC_DIR}/Sk/Components/GoalEditorComponent.cpp"
	"${SRC_DIR}/Sk/Components/GoalEditorComponent.h"
	"${SRC_DIR}/Sk/Components/ProjectileCollisionComponent.cpp"
	"${SRC_DIR}/Sk/Components/ProjectileCollisionComponent.h"
	"${SRC_DIR}/Sk/Components/RailEditorComponent.cpp"
	"${SRC_DIR}/Sk/Components/RailEditorComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterAdjustPhysicsComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterAdjustPhysicsComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterBalanceTrickComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterBalanceTrickComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterCleanupStateComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterCleanupStateComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterCorePhysicsComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterCorePhysicsComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterEndRunComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterEndRunComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterFinalizePhysicsComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterFinalizePhysicsComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterFlipAndRotateComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterFlipAndRotateComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterFloatingNameComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterFloatingNameComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterGapComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterGapComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterLocalNetLogicComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterLocalNetLogicComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterLoopingSoundComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterLoopingSoundComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterMatrixQueriesComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterMatrixQueriesComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterNonLocalNetLogicComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterNonLocalNetLogicComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterPhysicsControlComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterPhysicsControlComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterProximityComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterProximityComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterRotateComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterRotateComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterRunTimerComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterRunTimerComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterScoreComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterScoreComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterSoundComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterSoundComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterStancePanelComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterStancePanelComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterStateComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterStateComponent.h"
	"${SRC_DIR}/Sk/Components/SkaterStateHistoryComponent.cpp"
	"${SRC_DIR}/Sk/Components/SkaterStateHistoryComponent.h"
)
source_group("Sk/Components" FILES ${SK_COMPONENTS})

set(SK_ENGINE
	"${SRC_DIR}/Sk/Engine/RectFeeler.cpp"
	"${SRC_DIR}/Sk/Engine/RectFeeler.h"
	"${SRC_DIR}/Sk/Engine/SuperSector.cpp"
	"${SRC_DIR}/Sk/Engine/SuperSector.h"
	"${SRC_DIR}/Sk/Engine/contact.cpp"
	"${SRC_DIR}/Sk/Engine/contact.h"
	"${SRC_DIR}/Sk/Engine/feeler.cpp"
	"${SRC_DIR}/Sk/Engine/feeler.h"
	"${SRC_DIR}/Sk/Engine/sounds.cpp"
	"${SRC_DIR}/Sk/Engine/sounds.h"
)
source_group("Sk/Engine" FILES ${SK_ENGINE})

set(SK_GAMENET
	"${SRC_DIR}/Sk/GameNet/ExportMsg.h"
	"${SRC_DIR}/Sk/GameNet/GameHandler.cpp"
	"${SRC_DIR}/Sk/GameNet/GameMsg.h"
	"${SRC_DIR}/Sk/GameNet/GameNet.cpp"
	"${SRC_DIR}/Sk/GameNet/GameNet.h"
	"${SRC_DIR}/Sk/GameNet/Lobby.cpp"
	"${SRC_DIR}/Sk/GameNet/Lobby.h"
	"${SRC_DIR}/Sk/GameNet/Player.cpp"
	"${SRC_DIR}/Sk/GameNet/ServerList.cpp"
	"${SRC_DIR}/Sk/GameNet/scriptdebugger.h"
)
source_group("Sk/GameNet" FILES ${SK_GAMENET})

#set(SK_GAMENET_XBOX
#	"${SRC_DIR}/Sk/GameNet/Xbox/p_buddy.cpp"
#	"${SRC_DIR}/Sk/GameNet/Xbox/p_buddy.h"
#)
#source_group("Sk/GameNet/Xbox" FILES ${SK_GAMENET_XBOX})

set(SK_GAMENET_GAMESPYSLOP
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chat.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatASCII.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatCallbacks.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatCallbacks.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatChannel.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatChannel.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatCrypt.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatCrypt.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatHandlers.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatHandlers.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatMain.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatMain.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatSocket.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatSocket.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Chat/chatty/resource.h"
	
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsAssert.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsAssert.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsAvailable.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsAvailable.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsCommon.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsCore.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsCore.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsCrypt.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsCrypt.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsDebug.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsDebug.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsLargeInt.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsLargeInt.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsMemory.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsMemory.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsPlatform.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsPlatform.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsPlatformSocket.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsPlatformSocket.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsPlatformThread.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsPlatformThread.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsPlatformUtil.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsPlatformUtil.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsRC4.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsRC4.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsSHA1.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsSHA1.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsSoap.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsSoap.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/win32/gsSocketWin32.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsSSL.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsSSL.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsStringUtil.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsStringUtil.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsUdpEngine.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsUdpEngine.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsXML.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/gsXML.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/common/win32/Win32Common.c"
	
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttp.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpASCII.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpBuffer.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpBuffer.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpCallbacks.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpCallbacks.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpCommon.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpCommon.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpConnection.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpConnection.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpEncryption.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpEncryption.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpMain.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpMain.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpPost.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpPost.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpProcess.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/ghttp/ghttpProcess.h"
	
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Auth.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Auth.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Buffer.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Buffer.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Callback.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Callback.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Connection.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Connection.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Encode.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Encode.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Filter.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Filter.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Main.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Main.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Message.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Message.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Socket.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Socket.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Utility.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/gt2/gt2Utility.h"
	
	"${SRC_DIR}/Sk/GameNet/GameSpy/natneg/NATify.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/natneg/NATify.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/natneg/natneg.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/natneg/natneg.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/natneg/nninternal.h"
	
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peer.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerAscii.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerAutoMatch.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerAutoMatch.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerc/peerc.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerCallbacks.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerGlobalCallbacks.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerGlobalCallbacks.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerHost.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerHost.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerKeys.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerKeys.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerMain.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerMain.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerMangle.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerMangle.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerOperations.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerOperations.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerPing.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerPing.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerPlayers.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerPlayers.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerQR.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerQR.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerRooms.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerRooms.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerSB.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/Peer/peerSB.h"
	
	"${SRC_DIR}/Sk/GameNet/GameSpy/pinger/pinger.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/pinger/pingerMain.c"
	
	"${SRC_DIR}/Sk/GameNet/GameSpy/qr2/qr2.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/qr2/qr2.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/qr2/qr2regkeys.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/qr2/qr2regkeys.h"
	
	"${SRC_DIR}/Sk/GameNet/GameSpy/serverbrowsing/sb_ascii.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/serverbrowsing/sb_crypt.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/serverbrowsing/sb_crypt.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/serverbrowsing/sb_internal.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/serverbrowsing/sb_queryengine.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/serverbrowsing/sb_server.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/serverbrowsing/sb_serverbrowsing.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/serverbrowsing/sb_serverbrowsing.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/serverbrowsing/sb_serverlist.c"
	
	"${SRC_DIR}/Sk/GameNet/GameSpy/darray.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/darray.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/hashtable.h"
	"${SRC_DIR}/Sk/GameNet/GameSpy/hashtable.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/md5c.c"
	"${SRC_DIR}/Sk/GameNet/GameSpy/md5.h"
)
source_group("Sk/GameNet/GameSpy" FILES ${SK_GAMENET_GAMESPYSLOP})

set(SK_MODULES_FRONTEND
	"${SRC_DIR}/Sk/Modules/FrontEnd/FrontEnd.cpp"
	"${SRC_DIR}/Sk/Modules/FrontEnd/FrontEnd.h"
)
set(SK_MODULES_SKATE
	"${SRC_DIR}/Sk/Modules/Skate/BettingGuy.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/BettingGuy.h"
	"${SRC_DIR}/Sk/Modules/Skate/CATGoal.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/CATGoal.h"
	"${SRC_DIR}/Sk/Modules/Skate/CompetitionGoal.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/CompetitionGoal.h"
	"${SRC_DIR}/Sk/Modules/Skate/CreateATrick.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/CreateATrick.h"
	"${SRC_DIR}/Sk/Modules/Skate/FilmGoal.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/FilmGoal.h"
	"${SRC_DIR}/Sk/Modules/Skate/FindGapsGoal.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/FindGapsGoal.h"
	"${SRC_DIR}/Sk/Modules/Skate/GameFlow.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/GameFlow.h"
	"${SRC_DIR}/Sk/Modules/Skate/GameMode.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/GameMode.h"
	"${SRC_DIR}/Sk/Modules/Skate/Goal.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/Goal.h"
	"${SRC_DIR}/Sk/Modules/Skate/GoalManager.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/GoalManager.h"
	"${SRC_DIR}/Sk/Modules/Skate/GoalPed.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/GoalPed.h"
	"${SRC_DIR}/Sk/Modules/Skate/HorseGoal.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/HorseGoal.h"
	"${SRC_DIR}/Sk/Modules/Skate/Minigame.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/Minigame.h"
	"${SRC_DIR}/Sk/Modules/Skate/NetGoal.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/NetGoal.h"
	"${SRC_DIR}/Sk/Modules/Skate/RaceGoal.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/RaceGoal.h"
	"${SRC_DIR}/Sk/Modules/Skate/SkatetrisGoal.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/SkatetrisGoal.h"
	"${SRC_DIR}/Sk/Modules/Skate/VictoryCond.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/VictoryCond.h"
	"${SRC_DIR}/Sk/Modules/Skate/competition.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/competition.h"
	"${SRC_DIR}/Sk/Modules/Skate/horse.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/horse.h"
	"${SRC_DIR}/Sk/Modules/Skate/score.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/score.h"
	"${SRC_DIR}/Sk/Modules/Skate/skate.cpp"
	"${SRC_DIR}/Sk/Modules/Skate/skate.h"
	"${SRC_DIR}/Sk/Modules/Skate/skatenet.cpp"
)
set(SK_MODULES_VIEWER
	"${SRC_DIR}/Sk/Modules/Viewer/Viewer.cpp"
	"${SRC_DIR}/Sk/Modules/Viewer/Viewer.h"
)
source_group("Sk/Modules/FrontEnd" FILES ${SK_MODULES_FRONTEND})
source_group("Sk/Modules/Skate" FILES ${SK_MODULES_SKATE})
source_group("Sk/Modules/Viewer" FILES ${SK_MODULES_VIEWER})

set(SK_OBJECTS
	"${SRC_DIR}/Sk/Objects/FollowOb.h"
	"${SRC_DIR}/Sk/Objects/GameObj.cpp"
	"${SRC_DIR}/Sk/Objects/GameObj.h"
	"${SRC_DIR}/Sk/Objects/MovingObject.cpp"
	"${SRC_DIR}/Sk/Objects/MovingObject.h"
	"${SRC_DIR}/Sk/Objects/PathMan.cpp"
	"${SRC_DIR}/Sk/Objects/PathMan.h"
	"${SRC_DIR}/Sk/Objects/PathOb.cpp"
	"${SRC_DIR}/Sk/Objects/PathOb.h"
	"${SRC_DIR}/Sk/Objects/PlayerProfileManager.cpp"
	"${SRC_DIR}/Sk/Objects/PlayerProfileManager.h"
	"${SRC_DIR}/Sk/Objects/SkaterButton.cpp"
	"${SRC_DIR}/Sk/Objects/SkaterButton.h"
	"${SRC_DIR}/Sk/Objects/SkaterPad.h"
	"${SRC_DIR}/Sk/Objects/SkaterProfile.cpp"
	"${SRC_DIR}/Sk/Objects/SkaterProfile.h"
	"${SRC_DIR}/Sk/Objects/SkaterTricks.cpp"
	"${SRC_DIR}/Sk/Objects/SkaterTricks.h"
	"${SRC_DIR}/Sk/Objects/TrickObject.cpp"
	"${SRC_DIR}/Sk/Objects/TrickObject.h"
	"${SRC_DIR}/Sk/Objects/ViewerObj.cpp"
	"${SRC_DIR}/Sk/Objects/ViewerObj.h"
	"${SRC_DIR}/Sk/Objects/car.cpp"
	"${SRC_DIR}/Sk/Objects/car.h"
	"${SRC_DIR}/Sk/Objects/crown.cpp"
	"${SRC_DIR}/Sk/Objects/crown.h"
	"${SRC_DIR}/Sk/Objects/cutscenedetails.cpp"
	"${SRC_DIR}/Sk/Objects/cutscenedetails.h"
	"${SRC_DIR}/Sk/Objects/emitter.cpp"
	"${SRC_DIR}/Sk/Objects/emitter.h"
	"${SRC_DIR}/Sk/Objects/followob.cpp"
	"${SRC_DIR}/Sk/Objects/gap.cpp"
	"${SRC_DIR}/Sk/Objects/gap.h"
	"${SRC_DIR}/Sk/Objects/manual.cpp"
	"${SRC_DIR}/Sk/Objects/manual.h"
	"${SRC_DIR}/Sk/Objects/moviecam.cpp"
	"${SRC_DIR}/Sk/Objects/moviecam.h"
	"${SRC_DIR}/Sk/Objects/moviedetails.cpp"
	"${SRC_DIR}/Sk/Objects/moviedetails.h"
	"${SRC_DIR}/Sk/Objects/navigation.cpp"
	"${SRC_DIR}/Sk/Objects/navigation.h"
	"${SRC_DIR}/Sk/Objects/objecthook.cpp"
	"${SRC_DIR}/Sk/Objects/objecthook.h"
	"${SRC_DIR}/Sk/Objects/ped.cpp"
	"${SRC_DIR}/Sk/Objects/ped.h"
	"${SRC_DIR}/Sk/Objects/proxim.cpp"
	"${SRC_DIR}/Sk/Objects/proxim.h"
	"${SRC_DIR}/Sk/Objects/rail.cpp"
	"${SRC_DIR}/Sk/Objects/rail.h"
	"${SRC_DIR}/Sk/Objects/records.cpp"
	"${SRC_DIR}/Sk/Objects/records.h"
	"${SRC_DIR}/Sk/Objects/restart.cpp"
	"${SRC_DIR}/Sk/Objects/restart.h"
	"${SRC_DIR}/Sk/Objects/skater.cpp"
	"${SRC_DIR}/Sk/Objects/skater.h"
	"${SRC_DIR}/Sk/Objects/skatercam.cpp"
	"${SRC_DIR}/Sk/Objects/skatercam.h"
	"${SRC_DIR}/Sk/Objects/skatercareer.cpp"
	"${SRC_DIR}/Sk/Objects/skatercareer.h"
	"${SRC_DIR}/Sk/Objects/skaterflags.h"
	"${SRC_DIR}/Sk/Objects/skaterpad.cpp"
)
source_group("Sk/Objects" FILES ${SK_OBJECTS})

set(SK_PARKEDITOR
	"${SRC_DIR}/Sk/ParkEditor/EdRail.cpp"
	"${SRC_DIR}/Sk/ParkEditor/EdRail.h"
)
source_group("Sk/ParkEditor" FILES ${SK_PARKEDITOR})

set(SK_PARKEDITOR2
	"${SRC_DIR}/Sk/ParkEditor2/clipboard.cpp"
	"${SRC_DIR}/Sk/ParkEditor2/clipboard.h"
	"${SRC_DIR}/Sk/ParkEditor2/EdMap.cpp"
	"${SRC_DIR}/Sk/ParkEditor2/EdMap.h"
	"${SRC_DIR}/Sk/ParkEditor2/GapManager.cpp"
	"${SRC_DIR}/Sk/ParkEditor2/GapManager.h"
	"${SRC_DIR}/Sk/ParkEditor2/ParkEd.cpp"
	"${SRC_DIR}/Sk/ParkEditor2/ParkEd.h"
	"${SRC_DIR}/Sk/ParkEditor2/ParkGen.cpp"
	"${SRC_DIR}/Sk/ParkEditor2/ParkGen.h"
)
source_group("Sk/ParkEditor2" FILES ${SK_PARKEDITOR2})

set(SK_SCRIPTING
	"${SRC_DIR}/Sk/Scripting/cfuncs.cpp"
	"${SRC_DIR}/Sk/Scripting/cfuncs.h"
	"${SRC_DIR}/Sk/Scripting/ftables.h"
	"${SRC_DIR}/Sk/Scripting/ftables.cpp"
	"${SRC_DIR}/Sk/Scripting/gs_file.cpp"
	"${SRC_DIR}/Sk/Scripting/gs_file.h"
	"${SRC_DIR}/Sk/Scripting/gs_init.h"
	"${SRC_DIR}/Sk/Scripting/gs_init.cpp"
	"${SRC_DIR}/Sk/Scripting/mcfuncs.cpp"
	"${SRC_DIR}/Sk/Scripting/mcfuncs.h"
	"${SRC_DIR}/Sk/Scripting/nodearray.h"
	"${SRC_DIR}/Sk/Scripting/nodearray.cpp"
	"${SRC_DIR}/Sk/Scripting/skfuncs.cpp"
	"${SRC_DIR}/Sk/Scripting/skfuncs.h"
)
source_group("Sk/Scripting" FILES ${SK_SCRIPTING})

set(SK
	"${SRC_DIR}/Sk/heap_sizes.h"
	"${SRC_DIR}/Sk/language.h"
	"${SRC_DIR}/Sk/Main.cpp"
	"${SRC_DIR}/Sk/product_codes.h"
	"${SRC_DIR}/Sk/template.h"
)
source_group("Sk" FILES ${SK})

#set(SK_FILES ${SK_COMPONENTS} ${SK_ENGINE} ${SK_GAMENET} ${SK_GAMENET_XBOX} ${SK_GAMENET_GAMESPYSLOP} ${SK_MODULES_FRONTEND} ${SK_MODULES_SKATE} ${SK_MODULES_VIEWER} ${SK_OBJECTS} ${SK_PARKEDITOR} ${SK_PARKEDITOR2} ${SK_SCRIPTING} ${SK} )
set(SK_FILES ${SK_COMPONENTS} ${SK_ENGINE} ${SK_GAMENET} ${SK_GAMENET_GAMESPYSLOP} ${SK_MODULES_FRONTEND} ${SK_MODULES_SKATE} ${SK_MODULES_VIEWER} ${SK_OBJECTS} ${SK_PARKEDITOR} ${SK_PARKEDITOR2} ${SK_SCRIPTING} ${SK} )


###########################################
# Sys									  #				
###########################################

set(SYS_CONFIG
	"${SRC_DIR}/Sys/Config/config.cpp"
	"${SRC_DIR}/Sys/Config/config.h"
	"${SRC_DIR}/Sys/Config/Win32/p_config.cpp"
)
source_group("Sys/Config" FILES ${SYS_CONFIG})


set(SYS_FILE
	"${SRC_DIR}/Sys/File/AsyncFilesys.cpp"
	"${SRC_DIR}/Sys/File/AsyncFilesys.h"
	"${SRC_DIR}/Sys/File/AsyncTypes.h"
	"${SRC_DIR}/Sys/File/FileLibrary.h"
	"${SRC_DIR}/Sys/File/FileLibrary.cpp"
	"${SRC_DIR}/Sys/File/filesys.h"
	"${SRC_DIR}/Sys/File/memfile.h"
	"${SRC_DIR}/Sys/File/pip.h"
	"${SRC_DIR}/Sys/File/pip.cpp"
	"${SRC_DIR}/Sys/File/PRE.cpp"
	"${SRC_DIR}/Sys/File/PRE.h"
)
source_group("Sys/File" FILES ${SYS_FILE})

set(SYS_FILE_XBOX
	"${SRC_DIR}/Sys/File/XBox/p_AsyncFilesys.cpp"
	"${SRC_DIR}/Sys/File/XBox/p_AsyncFilesys.h"
	"${SRC_DIR}/Sys/File/XBox/p_filesys.cpp"
)
source_group("Sys/File/XBox" FILES ${SYS_FILE_XBOX})


set(SYS_MEM
	"${SRC_DIR}/Sys/Mem/CompactPool.cpp"
	"${SRC_DIR}/Sys/Mem/CompactPool.h"
	"${SRC_DIR}/Sys/Mem/PoolManager.cpp"
	"${SRC_DIR}/Sys/Mem/PoolManager.h"
	"${SRC_DIR}/Sys/Mem/Poolable.cpp"
	"${SRC_DIR}/Sys/Mem/Poolable.h"
	"${SRC_DIR}/Sys/Mem/alloc.cpp"
	"${SRC_DIR}/Sys/Mem/alloc.h"
	"${SRC_DIR}/Sys/Mem/handle.h"
	"${SRC_DIR}/Sys/Mem/heap.cpp"
	"${SRC_DIR}/Sys/Mem/heap.h"
	"${SRC_DIR}/Sys/Mem/memdbg.h"
	"${SRC_DIR}/Sys/Mem/memman.cpp"
	"${SRC_DIR}/Sys/Mem/memman.h"
	"${SRC_DIR}/Sys/Mem/memptr.h"
	"${SRC_DIR}/Sys/Mem/memtest.cpp"
	"${SRC_DIR}/Sys/Mem/memtest.h"
	"${SRC_DIR}/Sys/Mem/pile.cpp"
	"${SRC_DIR}/Sys/Mem/pile.h"
	"${SRC_DIR}/Sys/Mem/pool.cpp"
	"${SRC_DIR}/Sys/Mem/pool.h"
	"${SRC_DIR}/Sys/Mem/region.cpp"
	"${SRC_DIR}/Sys/Mem/region.h"
)
source_group("Sys/Mem" FILES ${SYS_MEM})

set(SYS_MEMCARD
	"${SRC_DIR}/Sys/MemCard/Win32/p_McMan.cpp"
)
source_group("Sys/MemCard/Win32" FILES ${SYS_MEMCARD})

set(SYS_REPLAY
	"${SRC_DIR}/Sys/Replay/replay.cpp"
	"${SRC_DIR}/Sys/Replay/replay.h"
)
source_group("Sys/Replay" FILES ${SYS_REPLAY})

set(SYS_SIO
	"${SRC_DIR}/Sys/SIO/keyboard.h"
)
source_group("Sys/SIO" FILES ${SYS_SIO})

set(SYS_SIO_WIN32
	"${SRC_DIR}/Sys/SIO/Win32/p_keyboard.cpp"
	"${SRC_DIR}/Sys/SIO/Win32/p_siodev.cpp"
	"${SRC_DIR}/Sys/SIO/Win32/p_sioman.cpp"
)	
source_group("Sys/SIO/Win32" FILES ${SYS_SIO_WIN32})

set(SYS_WIN32
	"${SRC_DIR}/Sys/Win32/p_timer.cpp"
	"${SRC_DIR}/Sys/Win32/WinMain.cpp"
)	
source_group("Sys/Win32" FILES ${SYS_WIN32})

set(SYS
	"${SRC_DIR}/Sys/demo.cpp"
	"${SRC_DIR}/Sys/demo.h"
	"${SRC_DIR}/Sys/McMan.h"
	"${SRC_DIR}/Sys/Profiler.cpp"
	"${SRC_DIR}/Sys/Profiler.h"
	"${SRC_DIR}/Sys/siodev.h"
	"${SRC_DIR}/Sys/sioman.h"
	"${SRC_DIR}/Sys/sys.cpp"
	"${SRC_DIR}/Sys/sys.h"
	"${SRC_DIR}/Sys/timer.cpp"
	"${SRC_DIR}/Sys/timer.h"
)
source_group("Sys" FILES ${SYS})

set(SYS_FILES ${SYS_CONFIG} ${SYS_FILE} ${SYS_FILE_XBOX} ${SYS_MEM} ${SYS_MEMCARD} ${SYS_REPLAY} ${SYS_SIO} ${SYS_SIO_WIN32} ${SYS_WIN32} ${SYS})

#Generate EXE
add_executable(${BIN_NAME} ${CORE_FILES} ${GEL_FILES} ${GFX_FILES} ${SK_FILES} ${SYS_FILES})