function Install {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/doxygen/doxygen/releases/download/Release_1_9_8/doxygen-1.9.8.windows.x64.bin.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "doxygen"
    $Target = Join-Path $Directory "doxygen-1.9.8.windows.x64.bin.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = $Directory
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\doxygen -value "Open with doxywizard" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\*\shell\doxygen -Name "Icon" -Value "$BinDir\doxywizard.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\doxygen\command -value """$BinDir\doxywizard.exe"" ""%1""" -Force | Out-Null
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\doxywizard.lnk")
    $Shortcut.TargetPath = "$BinDir\doxywizard.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Install