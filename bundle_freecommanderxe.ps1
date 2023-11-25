Write-Host "= (01)/02 進度 vscode,freecommanderxe ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_vscode.ps1" -UseBasicParsing).Content | Invoke-Expression
Write-Host "= (02)/02 進度 freecommanderxe ="
(Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_freecommanderxe.ps1" -UseBasicParsing).Content | Invoke-Expression
function setup {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "FreeCommanderXE"
    $Download_fav_Url = "https://github.com/kiloath/Installer/raw/main/assets/FreeCommander.fav.ini"
    $Download_fav_Local = "$Directory/Settings/FreeCommander.fav.ini"
    Invoke-WebRequest $Download_fav_Url -OutFile $Download_fav_Local -UseBasicParsing
    # (6) 設定右鍵功能 - - - - - - - - - - (6) 設定右鍵功能 - - - - - - - - - - (6) 設定右鍵功能 - - - - - - - - - -
    $AppName = "FreeCommander"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "FreeCommanderXE"
    $BinExe = "$Directory\FreeCommander.exe"
    # 6.1 檔案
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName -value "Kiloath $AppName" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\*\shell\$AppName -Name "Icon" -Value "$BinExe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName\command -value """$BinExe"" ""%V""" -Force | Out-Null
    # 6.2 目錄
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -value "Kiloath $AppName" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -Name "Icon" -Value "$BinExe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName\command -value """$BinExe"" ""%V""" -Force | Out-Null
}

setup