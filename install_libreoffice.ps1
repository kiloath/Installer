function Install {
    if(-not$v) { '請設定參數$v';return }
    $Version = $v
    $DownloadPathName = "LibreOfficePortablePrevious_${Version}_MultilingualStandard.paf.exe"
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://download.documentfoundation.org/libreoffice/portable/$Version/$DownloadPathName"
    $RootDir = Join-Path $HOME "KiloathApp"
    $DownloadDir = Join-Path $RootDir "LibreOffice"
    $DownloadPath = Join-Path $DownloadDir $DownloadPathName
    $BinDir = Join-Path $DownloadDir "App\libreoffice\program\soffice.exe"
    $BinExe = Join-Path $BinDir "soffice.exe"
    $AppName = "LibreOffice"
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(Get-Item $DownloadPath -ErrorAction SilentlyContinue) {
        Write-Host "你已下載最新版, 不下載開始安裝: $DownloadFile"
    }
    else {
        New-Item $DownloadDir -Force -ItemType Directory | Out-Null
        & aria2c.exe `
		--file-allocation=none `
		-x 16 `
		-s 16 `
		-k 1M `
		-d $DownloadDir `
		$DownloadUrl    
    }

    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    Start-Process -wait -FilePath "$RootDir\7-zip\7z.exe" -ArgumentList "x $DownloadPath -o""$DownloadDir"" -y" | Out-Null
  
    # (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - -
    <#
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$RootDir\$AppName.lnk")
    $Shortcut.DownloadPathPath = $BinExe
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.DownloadPathPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
    #>
    # (8) 補充
    $Download_fav_Url = "https://github.com/kiloath/Installer/raw/main/assets/quickstart.exe"
    $Download_fav_Local = Join-Path $DownloadDir "App\libreoffice\program\quickstart.exe"
    # (3) 是否已下載quickstart.exe - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    If (-Not (Test-Path $Download_fav_Local)) {
        Invoke-WebRequest $Download_fav_Url -OutFile $Download_fav_Local -UseBasicParsing
    }
    
}

Write-Host "--- 安裝 LibreOffice ---"
Install
Write-Host "--- 完成 LibreOffice ---"
