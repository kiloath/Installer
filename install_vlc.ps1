function Install {
    if(-not$v) { '請設定參數$v';return }
    $Version = $v
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://mirror.twds.com.tw/videolan/vlc/$Version/win32/vlc-$Version-win32.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "vlc"
    $Target = Join-Path $Directory "vlc-$Version-win32.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    Expand-Archive -Path $Target -DestinationPath "$Directory\temp" -Force
    $BinDir = $(Get-ChildItem "$Directory\temp" | Select-Object -First 1).Name
    Copy-Item -Path "$Directory\temp\*" -Destination $Directory -Recurse -Force
    Remove-Item -Path "$Directory\temp" -Recurse -Force
    $BinDir = Join-Path $Directory $BinDir
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\vlc.lnk")
    $Shortcut.TargetPath = "$BinDir\vlc.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Write-Host "--- 安裝 VLC ---"
Install
Write-Host "--- 完成 VLC ---"