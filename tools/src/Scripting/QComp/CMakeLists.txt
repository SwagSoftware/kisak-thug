
FILE(GLOB QCOMP_SRCS "*.cpp")

source_group("Sources" FILES ${QCOMP_SRCS})
add_executable(QComp ${QCOMP_SRCS})
set_property(TARGET QComp PROPERTY CXX_STANDARD 17)
# LWSS: qcomp.cpp includes the game tree (<Gel/Scripting/tokens.h>, skiptoken.cpp), so it
# needs the Code/ dir on its include path. GAME_CODE_DIR is set in the top-level Tools CMake.
# GAME_CODE_DIR for the shared headers; the DirectX SDK include because the game's Defines.h
# unconditionally pulls in <d3d9.h>/<d3dx9shader.h> (header-only for the tool - never linked).
target_include_directories(QComp PRIVATE
	"${GAME_CODE_DIR}"
	"C:/Program Files (x86)/Microsoft DirectX SDK (June 2010)/Include")
# LWSS: the game headers gate their win32 paths (windows.h include, sint32/uint32 typedefs,
# the no-op Dbg_* macros) on __PLAT_WN32__ (no 'I'), NOT __PLAT_WIN32__. Without it the tool
# fell into GNU-varargs debug macros + undefined types. Add __PLAT_WN32__ so the shared
# headers compile the same way the game build sees them.
target_compile_definitions(QComp PRIVATE __INLINE_MEMGLOBALS__ __PLAT_TOOL__ __PLAT_WN32__)
INSTALL(TARGETS QComp)