function Install {
    if(-not$v) { '請設定參數$v';return }
    $Version = $v
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://mirror.twds.com.tw/videolan/vlc/$Version/win32/vlc-$Version-win32.zip"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/pbatard/rufus/releases/download/v$Version/rufus-${Version}p.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "Rufus"
    $Target = Join-Path $Directory "rufus-${Version}p.exe"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    $BinDir = $Directory
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\Rufus.lnk")
    $Shortcut.TargetPath = "$BinDir\rufus-${Version}p.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save() 
}

Write-Host "--- 安裝 Rufus ---"
Install
Write-Host "--- 完成 Rufus ---"