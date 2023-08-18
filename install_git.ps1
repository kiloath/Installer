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
    $DownloadUrl = "https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/PortableGit-2.41.0.3-64-bit.7z.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "git"
    $Target = Join-Path $Directory "PortableGit-2.41.0.3-64-bit.7z.exe"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    $BinDir = $Directory
    Start-Process -FilePath "7z.exe" -ArgumentList "x $Target -o""$BinDir"" -y" | Out-Null
	$BinDir = "$BinDir\bin"
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
}

Install