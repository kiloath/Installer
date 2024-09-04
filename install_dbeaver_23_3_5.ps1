function Install {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    # 24版有權限問題, 故不採用
    $DownloadUrl = "https://github.com/dbeaver/dbeaver/releases/download/23.3.5/dbeaver-ce-23.3.5-win32.win32.x86_64.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "DBeaver"
    $Target = Join-Path $Directory "dbeaver-ce-23.3.5-win32.win32.x86_64.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = "$Directory\dbeaver"
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\dbeaver.lnk")
    $Shortcut.TargetPath = "$BinDir\dbeaver.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Install
# 建議訂選至工作列
