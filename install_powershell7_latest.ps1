function latest_version {
    $DownloadUrl = "https://github.com/PowerShell/PowerShell/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1].Trim('v')
    return $GitHubversion
}

function Install {
    $latest_version = latest_version
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://github.com/PowerShell/PowerShell/releases/download/v$latest_version/PowerShell-$latest_version-win-x64.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "powershell"
    $Target = Join-Path $Directory "PowerShell-$latest_version-win-x64.zip"
    $BinDir = "$Directory"
    $BinExe = "$BinDir\pwsh.exe"
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if((Get-Item $Target -ErrorAction SilentlyContinue)) {
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
    # (8) 獨有設定 - - - - - - - - - - - - (8) 獨有設定 - - - - - - - - - - - - (8) 獨有設定 - - - - - - - - - - - - 
    $settingPath = "$env:localappdata\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    $settings = Get-Content $settingPath -raw | ConvertFrom-Json
    if ($null -eq ($settings.profiles.list | Where-Object { $_.guid -eq "{762269d0-3dfa-44ab-ba67-00ee964b0dee}" })) {
        $BinExe = "$Directory\pwsh.exe".Replace('\', '\\')
        $newProfile = @"
        {
          "commandline": "\"$BinExe\" -NoLogo -NoExit",
          "guid": "{762269d0-3dfa-44ab-ba67-00ee964b0dee}",
          "hidden": false,
          "name": "Kiloath PowerShell",
          "icon": "$BinExe",
          "startingDirectory": null
        }
"@
        $settings.profiles.list += (ConvertFrom-Json -InputObject $newProfile)
        $settings.defaultProfile = "{762269d0-3dfa-44ab-ba67-00ee964b0dee}"
        $settings | ConvertTo-Json -Depth 32 | Set-Content $settingPath -Encoding "UTF8"
    }
}

Write-Host "--- 安裝 powershell7 ---"
IF (Test-Path variable:SSLCallback) {[System.Net.ServicePointManager]::ServerCertificateValidationCallback=$SSLCallback}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install
IF (Test-Path variable:SSLCallback) {[System.Net.ServicePointManager]::ServerCertificateValidationCallback={$true}}
Write-Host "--- 完成 powershell7 ---"
