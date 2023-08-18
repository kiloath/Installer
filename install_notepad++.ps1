function Install {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.4/npp.8.5.4.portable.x64.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "Notepad++"
    $Target = Join-Path $Directory "npp.8.5.4.portable.x64.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = $Directory
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\Notepad++ -value "Open with Notepad++" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\*\shell\Notepad++ -Name "Icon" -Value "$BinDir\Notepad++.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\Notepad++\command -value """$BinDir\Notepad++.exe"" ""%1""" -Force | Out-Null
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\Notepad++.lnk")
    $Shortcut.TargetPath = "$BinDir\Notepad++.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()

}

Install
