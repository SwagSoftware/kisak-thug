cmake_minimum_required(VERSION 3.20)
project(KisakThugTools CXX)

# Path to the game source tree (the tools share headers like <Gel/Scripting/tokens.h>).
# This dir now lives in-repo at kisak-thug/tools/, so the repo's Code is one level up.
set(GAME_CODE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../Code")

file (GLOB TOOLS_COMMON "src/common/*.cpp")
set(TOOLS_COMMON_SRCS ${TOOLS_COMMON})
add_subdirectory(src/MakePRE)
add_subdirectory(src/UnPRE)
add_subdirectory(src/Scripting)
