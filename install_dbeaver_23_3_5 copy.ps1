function Install {
    $DownloadFile = "krita-x64-5.2.3.zip"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://download.kde.org/stable/krita/5.2.3/$DownloadFile"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "krita"
    $Target = Join-Path $Directory $DowloadFile
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = Join-Path $Directory "bin"
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\krita.lnk")
    $Shortcut.TargetPath = "$BinDir\krita.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Install
# 建議訂選至工作列
