Write-Host "= (01)/04 進度 git,notepad++,winmerge,git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_git_latest.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (02)/04 進度 notepad++,winmerge,git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_notepad++_latest.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (03)/04 進度 winmerge,git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_winmerge_latest.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (04)/04 進度 git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_git_setup.ps1" -UseBasicParsing).Content | Invoke-Expression