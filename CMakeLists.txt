cmake_minimum_required(VERSION 3.16)
project(KisakThug)

set(BIN_NAME "KisakThug")
set(SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Code")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_GENERATOR_PLATFORM "WIN32")

include(cmake_files.cmake)

target_compile_definitions(KisakThug PUBLIC WIN32)
target_compile_definitions(KisakThug PUBLIC _DEBUG)
target_compile_definitions(KisakThug PUBLIC _CONSOLE)
target_compile_definitions(KisakThug PUBLIC __PLAT_WN32__)
target_compile_definitions(KisakThug PUBLIC _CRT_SECURE_NO_WARNINGS)
target_compile_definitions(KisakThug PUBLIC _WINSOCK_NO_DEPRECATED_NO_WARNINGS)
target_compile_definitions(KisakThug PUBLIC GSI_NO_THREADS)
target_compile_definitions(KisakThug PUBLIC KISAK_ORIGINAL_ALLOCATOR)

target_include_directories(KisakThug PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/Code")
target_include_directories(KisakThug PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/Code/Sk")
target_include_directories(KisakThug PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/SDL2/include")
target_include_directories(KisakThug PUBLIC "C:\\Program Files (x86)\\Microsoft DirectX SDK (June 2010)\\Include")

target_link_directories(KisakThug PUBLIC "C:\\Program Files (x86)\\Microsoft DirectX SDK (June 2010)\\Lib\\x86")
target_link_directories(KisakThug PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}/SDL2")

set(MSVC_WARNING_DISABLES
 "/wd\"4065\""
 ) #Switch statement with no cases (Used Legitimately)

set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT /O2 /MP /W3 ${MSVC_WARNING_DISABLES} /permissive")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd /Od /MP /W3 ${MSVC_WARNING_DISABLES} /permissive")

set_property(TARGET KisakThug PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

target_link_libraries(KisakThug PUBLIC dinput8.lib dsound.lib dxguid.lib d3dx9d.lib XInput.lib d3d9.lib SDL2.lib Winmm.lib Shlwapi.lib)
target_link_options(KisakThug PRIVATE /machine:x86)
set_target_properties(KisakThug PROPERTIES WIN32_EXECUTABLE TRUE)