function latest_version {
    $DownloadUrl = "https://github.com/RandomEngy/VidCoder/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1].Trim('v')
    return $GitHubversion
}

function Install {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $latest_version = latest_version
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://github.com/RandomEngy/VidCoder/releases/download/v$latest_version/VidCoder-$latest_version-Portable.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "VidCoder"
    $Target = Join-Path $Directory "VidCoder-$latest_version-Portable.exe"
    $BinExe = $Target
    $AppName = "VidCoder"
      # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
      if(Get-Item $Target -ErrorAction SilentlyContinue) {
        Write-Host "你已下載最新版: v$latest_version"
        return
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
    }  
    # (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - -
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\$AppName.lnk")
    $Shortcut.TargetPath = $BinExe
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
    #>
}

Write-Host "--- 安裝 vidcoder ---"
Install
Write-Host "--- 完成 vidcoder ---"
