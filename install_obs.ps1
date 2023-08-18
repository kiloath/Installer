function Install {
    $DownloadFile = "OBS-Studio-30.2.3-Windows"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://cdn-fastly.obsproject.com/downloads/$DownloadFile.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "obs"
    $Target = Join-Path $Directory "$DownloadFile.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = Join-Path $Directory "bin\64bit"
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\obs.lnk")
    $Shortcut.TargetPath = "$BinDir\obs64.exe"
    $Shortcut.WorkingDirectory = $BinDir
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Write-Host "--- 安裝 OBS ---"
Install
Write-Host "--- 完成 OBS ---"