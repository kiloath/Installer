function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $Version = "2.16.0.0"
    $DownloadUrl = "https://download.tortoisegit.org/tgit/$Version/TortoiseGit-$Version-64bit.msi"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "TortoiseGit"
    $Target = Join-Path $Directory "TortoiseGit-$Version-64bit.msi"
    $BinDir = "$Directory\TortoiseGit"
    $BinExe = "$BinDir\Program Files\TortoiseGit\bin\TortoiseGitProc.exe"
    $AppName = "Tortoise"
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 22552576)) {
        Write-Host "你已下載最新版"
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
    }
    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    Start-Process -FilePath "msiexec" -ArgumentList "/a $Target /qn TARGETDIR=$BinDir"
    # (6) 設定目錄右鍵功能 - - - - - - - - (6) 設定目錄右鍵功能 - - - - - - - - (6) 設定目錄右鍵功能 - - - - - - - - - -
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -value "Kiloath $AppName" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -Name "Icon" -Value "$BinExe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName\command -value  """$BinExe"" /command:log /path:""%V""" -Force | Out-Null
}

Write-Host "--- 安裝 TortoiseGit ---"
Install
Write-Host "--- 完成 TortoiseGit ---"
