function latest_version {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/fermyon/spin/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1].Trim('v')
    return $GitHubversion
}

function current_version {
    if (-not (Get-Command "spin.exe" -ErrorAction SilentlyContinue)) {
        return [System.Version]"0.0.0.0"
    }
    else {
        return $(spin.exe --version).Split()[2]
    }
}

function Install {
    $latest_version = latest_version
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://github.com/fermyon/spin/releases/download/v$latest_version/spin-v$latest_version-windows-amd64.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "spin"
    $Target = Join-Path $Directory "spin-v$latest_version-windows-amd64.zip"
    $BinDir = $Directory
     # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
     if(Get-Item $Target -ErrorAction SilentlyContinue) {
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
    # (5) 設定 Path- - - - - - - - - - - - (5) 設定 Path- - - - - - - - - - - - (5) 設定 Path- - - - - - - - - - - -
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
}

Write-Host "--- 安裝 spin ---"
Install
Write-Host "--- 完成 spin ---"
