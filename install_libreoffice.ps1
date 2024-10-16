function Install {
    if(-not$v) { '請設定參數$v';return }
    $Version = $v
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://download.documentfoundation.org/libreoffice/portable/$Version/LibreOfficePortable_${Version}_MultilingualStandard.paf.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "LibreOffice"
    $Target = Join-Path $Directory "LibreOfficePortable_${Version}_MultilingualStandard.paf.exe"
    # (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - -
    # <#
    if (-not (Get-Command "7z.exe" -ErrorAction SilentlyContinue)) {
        Invoke-RestMethod -Uri https://gitlab.com/api/v4/projects/58360840/repository/files/install_7zip.ps1/raw | Invoke-Expression
    }
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "User")

    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(Get-Item $Target -ErrorAction SilentlyContinue) {
        Write-Host "你已下載最新版, 不下載開始安裝: $DownloadFile"
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
    }

    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    Start-Process -wait -FilePath "7z" -ArgumentList "x $Target -o""$Directory"" -y" | Out-Null
  
    # (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - -
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Write-Host "--- 安裝 LibreOffice ---"
Install
Write-Host "--- 完成 LibreOffice ---"
