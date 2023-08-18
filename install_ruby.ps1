function Install {
    # (1) 參數設定
    $DownloadUrl = "https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.2.2-1/rubyinstaller-3.2.2-1-x64.7z"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "ruby"
    $Target = Join-Path $Directory "rubyinstaller-3.2.2-1-x64.7z"
    $BinDir = "$Directory\rubyinstaller-3.2.2-1-x64\bin"
    # (2) 需要7z來解壓縮
    # <#
    if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
    }
    # #>
    # (3) 是否已下載
    if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 13963258)) {
        Write-Host "你已下載最新版"
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
    }
    # (4) 解壓縮
    Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$Directory"" -y" | Out-Null
    # Expand-Archive -Path $Target -DestinationPath $Directory -Force
    # (5) 設定 Path
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
}

Install
