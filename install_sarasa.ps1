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
    $DownloadUrl = "https://github.com/be5invis/Sarasa-Gothic/releases/download/v0.41.6/sarasa-gothic-ttf-0.41.6.7z"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "sarasa"
    $Target = Join-Path $Directory "sarasa-gothic-ttf-0.41.6.7z"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    $BinDir = $Directory
    Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$BinDir"" sarasa-fixed-tc-regular.ttf -y" -Wait | Out-Null
    & "$BinDir\sarasa-fixed-tc-regular.ttf"
}

Install
# 自行安裝sarasa-fixed-tc-regular.ttf
