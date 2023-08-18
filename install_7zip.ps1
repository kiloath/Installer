function Install_7zr {
    if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $DownloadUrl = "https://www.7-zip.org/a/7zr.exe"
        $KiloathDir = Join-Path $HOME "KiloathApp"
        $Directory = Join-Path $KiloathDir "7-zip"
        $Target = Join-Path $Directory "7zr.exe"
        New-Item $Directory -Force -ItemType Directory | Out-Null
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
        $BinDir = $Directory
        $regexInstallPath = [regex]::Escape($BinDir)
        if (-Not ($env:Path -Match "$regexInstallPath")) {
            [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
            $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
        }
    }
}
function Install {
    Install_7zr
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://www.7-zip.org/a/7z2301-x64.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "7-zip"
    $Target = Join-Path $Directory "7z2301-x64.exe"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    $BinDir = $Directory
    Start-Process -FilePath "$Directory\7zr.exe" -ArgumentList "x $Target -o""$BinDir"" -y" | Out-Null
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\7zip -value "Open with 7-zip" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\*\shell\7zip -Name "Icon" -Value "$BinDir\7zFM.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\7zip\command -value """$BinDir\7zFM.exe"" ""%1""" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\7zip -value "Open with 7-zip" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\7zip -Name "Icon" -Value "$BinDir\7zFM.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\7zip\command -value """$BinDir\7zFM.exe"" ""%V""" -Force | Out-Null
}

Install

