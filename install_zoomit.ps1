function Install {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://download.sysinternals.com/files/ZoomIt.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "ZoomIt"
    $Target = Join-Path $Directory "ZoomIt.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = $Directory
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\ZoomIt.lnk")
    $Shortcut.TargetPath = "$BinDir\ZoomIt64.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Install
# 使用開機自動啟動