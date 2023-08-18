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
    $DownloadUrl = "https://github.com/kiloath/Installer/raw/main/src/TortoiseGit.7z"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "TortoiseGit"
    $Target = Join-Path $Directory "TortoiseGit.7z"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    $BinDir = $Directory
    Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$BinDir"" -y" | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\VSCode -value "TortoiseGit Log" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\VSCode -Name "Icon" -Value "$BinDir\TortoiseGitProc.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\VSCode\command -value """$BinDir\TortoiseGitProc.exe"" /command:log /path:""%V""" -Force | Out-Null
}

Install
# 我只用Log功能比gitk好用