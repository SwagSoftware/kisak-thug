@echo off
REM ===========================================================================
REM build_scripts.bat - Recompile the game's .q / .qn script sources to .qb.
REM
REM With loose script loading enabled (gs_file.cpp no longer mounts qb.pre), the
REM game reads .qb files from  Game\Data\scripts\ , which already holds the
REM .q / .qn SOURCES alongside the compiled .qb. This script builds the QComp
REM compiler once, then runs it over that tree with QComp's -all flag, which
REM recurses subdirectories and writes each <name>.qb next to its <name>.q -
REM i.e. exactly where qdir.txt expects it, so the paths stay correct and no
REM qb.pre rebuild is needed.
REM
REM   build_scripts.bat                 Recompile everything under scripts\
REM   build_scripts.bat scripts\game    Recompile just a subdirectory
REM
REM Edit the .q files in Game\Data\scripts\, run this, relaunch the game.
REM ===========================================================================
setlocal EnableExtensions

REM This script lives in-repo at kisak-thug\tools\ .
REM TOOLS = QComp source/build (this dir); REPO = the game repo root (one level up).
set "HERE=%~dp0"
if "%HERE:~-1%"=="\" set "HERE=%HERE:~0,-1%"
REM Resolve to clean absolute paths (no ..\) - QComp dislikes ..\ segments in PROJ_ROOT.
for %%I in ("%HERE%") do set "TOOLS=%%~fI"
for %%I in ("%HERE%\..") do set "REPO=%%~fI"

set "CMAKE=cmake"
where cmake >nul 2>nul || set "CMAKE=C:\Program Files\CMake\bin\cmake.exe"

REM QComp must be 32-bit (-A Win32): the shared game headers use 32-bit inline __asm.
set "QCOMP=%TOOLS%\build\src\Scripting\QComp\Release\QComp.exe"
if not exist "%QCOMP%" (
    echo [build_scripts] Building QComp compiler...
    if exist "%TOOLS%\build" rmdir /s /q "%TOOLS%\build"
    "%CMAKE%" -S "%TOOLS%" -B "%TOOLS%\build" -A Win32
    if errorlevel 1 ( echo [build_scripts] ERROR: cmake configure failed. & exit /b 1 )
    "%CMAKE%" --build "%TOOLS%\build" --target QComp --config Release
    if errorlevel 1 ( echo [build_scripts] ERROR: QComp build failed. & exit /b 1 )
)
if not exist "%QCOMP%" ( echo [build_scripts] ERROR: QComp.exe not found after build. & exit /b 1 )

set "DATA_DIR=%REPO%\Game\Data"
if not exist "%DATA_DIR%\scripts\qdir.txt" (
    echo [build_scripts] ERROR: "%DATA_DIR%\scripts\qdir.txt" not found.
    echo                 Make sure the game's Data\ folder with loose scripts is next to the exe.
    exit /b 1
)

REM --- which directory to compile (relative to PROJ_ROOT). Default = every source tree:
REM scripts\ (main qdir scripts) plus the loose decompiled Levels\ and Models\ .q that sit
REM next to their .qb (so editing a level/goal .q and rebuilding produces the loose .qb the
REM game loads under -loosescripts). Pass an explicit subdir to compile just that. ---
REM QComp requires PROJ_ROOT; its directory args are relative to it, and it writes each .qb
REM in place (next to the source .q) - keeping the qdir.txt / loose paths correct.
set "TARGET=%~1"
set "PROJ_ROOT=%DATA_DIR%"

if not "%TARGET%"=="" (
    echo [build_scripts] Compiling "%TARGET%" under "%DATA_DIR%" ...
    "%QCOMP%" -all -nomessageboxes "%TARGET%"
    if errorlevel 1 ( echo [build_scripts] ERROR: qcomp reported a failure. See "%DATA_DIR%\qcomp.log". & exit /b 1 )
) else (
    for %%D in (scripts Levels Models) do (
        if exist "%DATA_DIR%\%%D" (
            echo [build_scripts] Compiling "%%D" under "%DATA_DIR%" ...
            "%QCOMP%" -all -nomessageboxes "%%D"
            if errorlevel 1 ( echo [build_scripts] ERROR: qcomp reported a failure in "%%D". See "%DATA_DIR%\qcomp.log". & exit /b 1 )
        )
    )
)

echo [build_scripts] Done. Compiled files are listed in "%DATA_DIR%\qcomp.log".
endlocal
