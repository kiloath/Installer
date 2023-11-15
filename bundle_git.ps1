Write-Host "= (01)/04 進度 powershell7,git,notepad++,winmerge,git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_powershell7.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (01)/04 進度 git,notepad++,winmerge,git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_git.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (02)/04 進度 notepad++,winmerge,git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_notepad++.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (03)/04 進度 winmerge,git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_winmerge.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (04)/04 進度 git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_git_setup.ps1" -UseBasicParsing).Content | Invoke-Expression