function latest_version {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/mltframework/shotcut/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1].Trim('v')
    return $GitHubversion
}

function Install {
    $latest_version = latest_version
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://github.com/ShareX/ShareX/releases/download/v$latest_version/ShareX-$latest_version-portable.zip"
    $DownloadUrl = "https://github.com/mltframework/shotcut/releases/download/v$latest_version/shotcut-win64-$($latest_version.replace('.','')).zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "Shotcut"
    $Target = Join-Path $Directory "shotcut-win64-$($latest_version.replace('.','')).zip"
    $BinDir = "$Directory\shotcut"
    $BinExe = "$BinDir\shotcut.exe"

     # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(Test-Path $Target) {
        Write-Host "你已下載最新版: v$latest_version"
        return
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    }
    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    # (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - -
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\shotcut.lnk")
    $Shortcut.TargetPath = "$BinExe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Write-Host "--- 安裝 Shotcut ---"
Install
Write-Host "--- 完成 Shotcut ---"
# v23之後Settings > Player > External Monitor被移除了, 但對我很重要所以不升級, v22.12.21版很好。
