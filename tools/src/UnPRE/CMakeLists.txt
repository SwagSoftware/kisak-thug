# UnPRE: extractor (self-contained, no engine deps)
add_executable(UnPRE UnPRE.cpp)
set_property(TARGET UnPRE PROPERTY CXX_STANDARD 17)
set_property(TARGET UnPRE PROPERTY CXX_STANDARD_REQUIRED ON)

# PrePack: packer. Reuses the game's real LZSS encoder from MakePRE/lzss.cpp.
add_executable(PrePack PrePack.cpp ${CMAKE_CURRENT_SOURCE_DIR}/../MakePRE/lzss.cpp)
set_property(TARGET PrePack PROPERTY CXX_STANDARD 17)
set_property(TARGET PrePack PROPERTY CXX_STANDARD_REQUIRED ON)

if (MSVC)
    target_compile_definitions(UnPRE  PRIVATE _CRT_SECURE_NO_WARNINGS)
    target_compile_definitions(PrePack PRIVATE _CRT_SECURE_NO_WARNINGS)
endif()

INSTALL(TARGETS UnPRE PrePack)

# NOTE: PreExplorer (the GUI) is a C#/WinForms app built with the in-box .NET
# Framework compiler, not C++. CMake does not build it; run build_all.bat (or
# csc directly) to produce PreExplorer.exe. See README.md.
