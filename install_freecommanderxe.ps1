function Install {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://freecommander.com/downloads/FreeCommanderXE-32-public_portable.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "FreeCommanderXE"
    $Target = Join-Path $Directory "FreeCommanderXE-32-public_portable.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = $Directory
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\FreeCommander.lnk")
    $Shortcut.TargetPath = "$BinDir\FreeCommander.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save() 
}
function setup {
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "FreeCommanderXE"
    $Download_fav_Url = "https://github.com/kiloath/Installer/raw/main/assets/FreeCommander.fav.ini"
    $Download_fav_Local = "$Directory/settings/FreeCommander.fav.ini"
    Invoke-WebRequest $Download_fav_Url -OutFile $Download_fav_Local -UseBasicParsing
}

# Install
# 建議訂選至工作列
setup