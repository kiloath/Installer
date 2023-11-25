Write-Host "= (01)/04 進度 git,notepad++,winmerge,git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_vscode.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (02)/04 進度 notepad++,winmerge,git_setup ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_freecommanderxe.ps1" -UseBasicParsing).Content | Invoke-Expression
function setup {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "FreeCommanderXE"
    $Download_fav_Url = "https://github.com/kiloath/Installer/raw/main/assets/FreeCommander.fav.ini"
    $Download_fav_Local = "$Directory/Settings/FreeCommander.fav.ini"
    Invoke-WebRequest $Download_fav_Url -OutFile $Download_fav_Local -UseBasicParsing
}

setup