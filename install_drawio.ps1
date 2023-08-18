function Install {
    if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
    }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/jgraph/drawio-desktop/releases/download/v21.6.8/draw.io-21.6.8-windows-installer.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "DrawIO"
    $Target = Join-Path $Directory "draw.io-21.6.8-windows-installer.exe"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    $BinDir = $Directory
    Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$BinDir"" -y" | Out-Null
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\draw.io.lnk")
    $Shortcut.TargetPath = "$BinDir\draw.io.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()

}

Install
