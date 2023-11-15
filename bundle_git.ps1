Write-Host "= (01)/02 進度 git,notepad++,winmerge ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_git.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (02)/02 進度 notepad++,winmerge ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_notepad++.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (03)/03 進度 winmerge ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_winmerge.ps1" -UseBasicParsing).Content | Invoke-Expression