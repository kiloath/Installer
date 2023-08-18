function Install {
    $Version = "5.2.5"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://download.kde.org/stable/krita/$Version/krita-x64-$Version.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "Krita"
    $Target = Join-Path $Directory "krita-x64-$Version.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = Join-Path $Directory "krita-x64-$Version" "bin"
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\krita.lnk")
    $Shortcut.TargetPath = "$BinDir\krita.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Write-Host "--- 安裝 Krita ---"
Install
Write-Host "--- 完成 Krita ---"