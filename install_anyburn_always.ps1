function Install {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://www.anyburn.com/anyburn.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "AnyBurn"
    $Target = Join-Path $Directory "anyburn.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = Join-Path $Directory "AnyBurn(64-bit)"
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\AnyBurn.lnk")
    $Shortcut.TargetPath = "$BinDir\AnyBurn.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save() 
}

Write-Host "--- 安裝 AnyBurn ---"
Write-Host "我不會知道是否有新版, 所以總是安裝。"
Install
Write-Host "--- 完成 AnyBurn ---"