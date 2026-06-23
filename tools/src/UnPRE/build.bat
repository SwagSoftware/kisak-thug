@echo off
REM Build UnPRE.exe with MSVC. Run from anywhere; needs Visual Studio installed.
setlocal
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -property installationPath`) do set "VSPATH=%%i"
if not defined VSPATH (
    echo Could not locate Visual Studio. Install the "Desktop development with C++" workload.
    exit /b 1
)
call "%VSPATH%\VC\Auxiliary\Build\vcvars64.bat" >nul
cl /nologo /std:c++17 /O2 /EHsc /D_CRT_SECURE_NO_WARNINGS ^
   "%~dp0UnPRE.cpp" /Fe:"%~dp0UnPRE.exe" /Fo:"%~dp0UnPRE.obj"
if errorlevel 1 ( echo Build FAILED & exit /b 1 )
del "%~dp0UnPRE.obj" >nul 2>&1
echo Built "%~dp0UnPRE.exe"
