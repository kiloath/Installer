Write-Host "= (01)/01 進度 git ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_git.ps1" -UseBasicParsing).Content | Invoke-Expression