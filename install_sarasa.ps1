function Install {
    if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
    }
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
