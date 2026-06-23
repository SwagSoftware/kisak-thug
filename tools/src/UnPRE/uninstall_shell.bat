@echo off
REM ===========================================================================
REM  uninstall_shell.bat - remove the right-click menu entries added by
REM  install_shell.bat. Leaves no trace in HKCU.
REM ===========================================================================
setlocal

echo Removing PRE tool shell entries...

reg delete "HKCU\Software\Classes\NeversoftPre" /f >nul 2>&1
reg delete "HKCU\Software\Classes\Directory\shell\packtopre" /f >nul 2>&1

REM Only clear the .pre/.prx default if it still points at our ProgID.
for %%X in (.pre .prx) do (
  for /f "tokens=2,*" %%A in ('reg query "HKCU\Software\Classes\%%X" /ve 2^>nul ^| find "REG_SZ"') do (
    if /i "%%B"=="NeversoftPre" reg delete "HKCU\Software\Classes\%%X" /f >nul 2>&1
  )
)

echo Done.
echo.
pause
