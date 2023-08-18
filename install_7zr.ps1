function Install {
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

Write-Host "--- 安裝 7zr ---"
Install
Write-Host "--- 完成 7zr ---"

