function Install {
    # (1) 參數設定
    $DownloadUrl = "https://github.com/PowerShell/PowerShell/releases/download/v7.3.7/PowerShell-7.3.7-win-x64.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "powershell"
    $Target = Join-Path $Directory "PowerShell-7.3.7-win-x64.zip"
    $BinDir = "$Directory"
    # (2) 需要7z來解壓縮
    <#
    if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
    }
    #>
    # (3) 是否已下載
    if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 107897062)) {
        Write-Host "你已下載最新版"
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
    }
    # (4) 解壓縮
    # Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$Directory"" -y" | Out-Null
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    # (5) 設定 Path
    <#
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
    #>
    # (6) 設定右鍵功能
    # (6.1) 檔案
    # 沒有
    # (6.2) 目錄
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\powershell7 -value "Powershell7" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\powershell7 -Name "Icon" -Value "$BinDir\pwsh.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\powershell7\command -value """$BinDir\pwsh.exe"" -WorkingDirectory ""%V"" -NoLogo -NoExit""" -Force | Out-Null
}

Install
