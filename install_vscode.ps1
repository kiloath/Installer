function latest_version {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $DownloadFile = $realTagUrl.split('/')[-1]
    return $DownloadFile
}
function current_version {
    if (-not (Get-Command "code.exe" -ErrorAction SilentlyContinue)) {
        return [System.Version]"0.0.0"
    }
    else {
        return [System.Version]$(code --version | Select-Object -First 1)
    }
}
function Install {
    $DownloadFile = latest_version
    $latest_version = [System.Version]$DownloadFile.Split('-')[-1].Trim('.exe')
    $current_version = current_version
    
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "VSCode"
    $Target = Join-Path $Directory $DownloadFile
	# $BinDir = "$env:LOCALAPPDATA\Programs\Microsoft VS Code"
    # $BinExe = "$BinDir\Code.exe"
	# $AppName = "VSCode"

    # (3) 下載 - - - - - - - - - - - (3) 下載 - - - - - - - - - - - (3) 下載 - - - - - - - - - - -
     # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    Write-Host "你的版本: $current_version, 最新版本: $latest_version"
    if($latest_version -eq $current_version) {
        Write-Host "你的 Visual Studio Code 已是最新版本!"
        return
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    }
	# (4) 安裝 - - - - -
    Start-Process -FilePath $Target -ArgumentList "/VERYSILENT /MERGETASKS=!runcode" -wait
	# (6) 設定右鍵功能 - - - - - - - - - - (6) 設定右鍵功能 - - - - - - - - - - (6) 設定右鍵功能 - - - - - - - - - -
    # 6.1 檔案
    <#
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName -value "Kiloath $AppName" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\*\shell\$AppName -Name "Icon" -Value "$BinExe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName\command -value """$BinExe"" ""%1""" -Force | Out-Null
    # 6.2 目錄
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -value "Kiloath $AppName" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -Name "Icon" -Value "$BinExe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName\command -value """$BinExe"" ""%V""" -Force | Out-Null
    #>
}
function Setup {
    <#
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "FreeCommanderXE"
    $Target = Join-Path $Directory ".vscode.zip"
    $Download_fav_Url = "https://github.com/kiloath/Installer/raw/main/assets/.vscode.zip"
    Invoke-WebRequest $Download_fav_Url -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $HOME -Force
    #>
    <#
    $setting_argv_Path = "$HOME\.vscode\argv.json"
    $settings = Get-Content $setting_argv_Path -raw | ConvertFrom-Json
    $settings.profiles.defaults | add-member -Name "locale" -Value "zh-tw" -MemberType NoteProperty -Force
    $settings | ConvertTo-Json -Depth 32 | Set-Content $setting_argv_Path -Encoding "UTF8"

    $setting_argv_Path = "$HOME\.vscode\extensions\extensions.json"
    $settings = Get-Content $setting_argv_Path -raw | ConvertFrom-Json
    $settings.profiles.defaults | add-member -Name "locale" -Value "zh-tw" -MemberType NoteProperty -Force
    $settings | ConvertTo-Json -Depth 32 | Set-Content $setting_argv_Path -Encoding "UTF8"
    #>
}

Write-Host "--- 安裝 vscode ---"
Install
Setup
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
Write-Host "--- 完成 vscode ---"

