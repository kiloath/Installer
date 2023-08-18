function Install {
    # (1) 參數設定
    $DownloadUrl = "https://download.visualstudio.microsoft.com/download/pr/577fe112-f607-4ab3-abbc-8be20c643c29/b51011ff804ad47051bd9d81c6e737c0/dotnet-sdk-8.0.100-rc.1.23463.5-win-x64.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "net8sdk"
    $Target = Join-Path $Directory "dotnet-sdk-8.0.100-rc.1.23463.5-win-x64.zip"
    $BinDir = $Directory
    # (2) 需要7z來解壓縮
    <#
    if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
    }
    #>
    # (3) 是否已下載
    if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 282422497)) {
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
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\net8sdk -value ".NET8 開發環境" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\net8sdk -Name "Icon" -Value "$BinDir\dotnet.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\net8sdk\command -value """$KiloathDir\powershell\pwsh.exe"" -WorkingDirectory ""%V"" -NoLogo -NoExit -File ""$Directory\net8sdk.ps1""" -Force | Out-Null
    # (7) 獨有設定
    '$ENV:DOTNET_ROOT="' + $BinDir + '"' > $BinDir\net8sdk.ps1
    '$ENV:PATH="' + $BinDir + ';$ENV:PATH"'  >> $BinDir\net8sdk.ps1
    if (-not (Get-Item "$KiloathDir\powershell\pwsh.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_powershell7.ps1" -UseBasicParsing).Content | Invoke-Expression
    }
}

Install
