@echo off
REM ===========================================================================
REM  install_shell.bat - add right-click menu entries for PRE tools.
REM
REM  Adds to the current user's registry (HKCU, no admin needed):
REM    * .pre / .prx files:  "Extract here", "Extract to <name>\",
REM                          "Open with PRE Explorer"
REM    * folders:            "Pack to .PRE"
REM
REM  Entries point at the .exe files sitting next to this script.
REM  Run uninstall_shell.bat to remove them.
REM ===========================================================================
setlocal
set "DIR=%~dp0"
if "%DIR:~-1%"=="\" set "DIR=%DIR:~0,-1%"

set "UNPRE=%DIR%\UnPRE.exe"
set "PREPACK=%DIR%\PrePack.exe"
set "GUI=%DIR%\PreExplorer.exe"

if not exist "%UNPRE%"  ( echo Missing UnPRE.exe next to this script.  & pause & exit /b 1 )
if not exist "%PREPACK%" ( echo Missing PrePack.exe next to this script. & pause & exit /b 1 )

echo Registering PRE tools from:
echo   %DIR%
echo.

REM --- associate a friendly ProgID with .pre and .prx -------------------------
reg add "HKCU\Software\Classes\.pre"  /ve /d "NeversoftPre" /f >nul
reg add "HKCU\Software\Classes\.prx"  /ve /d "NeversoftPre" /f >nul
reg add "HKCU\Software\Classes\NeversoftPre" /ve /d "Neversoft PRE archive" /f >nul

REM --- default action: open in the GUI explorer (double-click) ----------------
if exist "%GUI%" (
  reg add "HKCU\Software\Classes\NeversoftPre\shell" /ve /d "open" /f >nul
  reg add "HKCU\Software\Classes\NeversoftPre\shell\open\command" /ve /d "\"%GUI%\" \"%%1\"" /f >nul
  reg add "HKCU\Software\Classes\NeversoftPre\shell\open" /v MUIVerb /d "Open with PRE Explorer" /f >nul
)

REM --- "Extract here" (into a folder named after the archive, beside it) ------
reg add "HKCU\Software\Classes\NeversoftPre\shell\extracthere" /v MUIVerb /d "PRE: Extract here" /f >nul
reg add "HKCU\Software\Classes\NeversoftPre\shell\extracthere\command" /ve /d "\"%UNPRE%\" \"%%1\"" /f >nul

REM --- "Extract to chosen folder" via a small chooser ------------------------
REM    (uses UnPRE -o so output goes under <archive folder>\<name>\ explicitly)
reg add "HKCU\Software\Classes\NeversoftPre\shell\extractlist" /v MUIVerb /d "PRE: List contents (console)" /f >nul
reg add "HKCU\Software\Classes\NeversoftPre\shell\extractlist\command" /ve /d "cmd /k \"\"%UNPRE%\" --list \"%%1\"\"" /f >nul

REM --- folder background / folder right-click: "Pack to .PRE" -----------------
reg add "HKCU\Software\Classes\Directory\shell\packtopre" /v MUIVerb /d "Pack folder to .PRE" /f >nul
reg add "HKCU\Software\Classes\Directory\shell\packtopre\command" /ve /d "\"%PREPACK%\" \"%%1\"" /f >nul

echo Done. Right-click a .pre/.prx file or a folder to see the new entries.
echo (You may need to restart Explorer or sign out/in for icons to refresh.)
echo.
pause
