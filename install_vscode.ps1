function Install {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-archive"
	$KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "VSCode"
    $Target = Join-Path $Directory "VSCode-win32-x64.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = $Directory
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\VSCode -value "Open with Code" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\*\shell\VSCode -Name "Icon" -Value "$BinDir\Code.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\VSCode\command -value """$BinDir\Code.exe"" ""%1""" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\VSCode -value "Open with Code" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\VSCode -Name "Icon" -Value "$BinDir\Code.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\VSCode\command -value """$BinDir\Code.exe"" ""%V""" -Force | Out-Null
}

Install

