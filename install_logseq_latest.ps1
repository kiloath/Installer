function latest_version {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/logseq/logseq/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1]
    return $GitHubversion
}

function Install {
    $latest_version = latest_version
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://github.com/logseq/logseq/releases/download/$latest_version/Logseq-win-x64-$latest_version.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "logseq"
    $Target = Join-Path $Directory "Logseq-win-x64-$latest_version.zip"
    $BinDir = $Directory
     # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(Test-Path $Target) {
        Write-Host "你已下載最新版: v$latest_version"
        return
    }
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    # (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - -
    $BinExe = "$BinDir\logseq.exe"
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\logseq.lnk")
    $Shortcut.TargetPath = $BinExe
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Write-Host "--- 安裝 logseq ---"
Install
Write-Host "--- 完成 logseq ---"
