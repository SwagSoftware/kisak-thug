@echo off
REM ===========================================================================
REM  build_all.bat - build all three PRE tools into this folder:
REM    UnPRE.exe       (extractor, C++/MSVC)
REM    PrePack.exe     (packer,    C++/MSVC)
REM    PreExplorer.exe (GUI,       C#/in-box .NET Framework compiler)
REM ===========================================================================
setlocal
set "DIR=%~dp0"
if "%DIR:~-1%"=="\" set "DIR=%DIR:~0,-1%"

REM --- locate MSVC -----------------------------------------------------------
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -property installationPath 2^>nul`) do set "VSPATH=%%i"
if not defined VSPATH (
    echo ERROR: Visual Studio with the C++ workload was not found.
    pause & exit /b 1
)
call "%VSPATH%\VC\Auxiliary\Build\vcvars64.bat" >nul

echo Building UnPRE.exe ...
cl /nologo /std:c++17 /O2 /EHsc /D_CRT_SECURE_NO_WARNINGS "%DIR%\UnPRE.cpp" /Fe:"%DIR%\UnPRE.exe" /Fo:"%DIR%\\" || goto :fail

echo Building PrePack.exe ...
cl /nologo /std:c++17 /O2 /EHsc /D_CRT_SECURE_NO_WARNINGS "%DIR%\PrePack.cpp" "%DIR%\..\MakePRE\lzss.cpp" /Fe:"%DIR%\PrePack.exe" /Fo:"%DIR%\\" || goto :fail

REM --- locate the in-box C# compiler -----------------------------------------
set "CSC="
for /f "delims=" %%c in ('dir /b /s "%WINDIR%\Microsoft.NET\Framework64\v4.0.30319\csc.exe" 2^>nul') do set "CSC=%%c"
if not defined CSC (
    echo WARNING: .NET Framework csc.exe not found; skipping the GUI build.
    goto :cleanup
)
echo Building PreExplorer.exe ...
"%CSC%" /nologo /target:winexe /optimize+ /out:"%DIR%\PreExplorer.exe" /reference:System.Windows.Forms.dll /reference:System.Drawing.dll "%DIR%\PreExplorer.cs" || goto :fail

:cleanup
del "%DIR%\*.obj" >nul 2>&1
echo.
echo Build complete. Executables are in:
echo   %DIR%
echo.
pause
exit /b 0

:fail
echo.
echo BUILD FAILED.
del "%DIR%\*.obj" >nul 2>&1
pause
exit /b 1
