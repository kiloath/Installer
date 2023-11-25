function latest_version {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1]
    # return $GitHubversion
    return $GitHubversion
}
function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "VSCode"
    $Target = Join-Path $Directory latest_version
	$BinDir = "$env:LOCALAPPDATA\Programs\Microsoft VS Code"
    $BinExe = "$BinDir\Code.exe"
	$AppName = "VSCode"

    # (3) 下載 - - - - - - - - - - - (3) 下載 - - - - - - - - - - - (3) 下載 - - - - - - - - - - -
     # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
     if(Get-Item $Target -ErrorAction SilentlyContinue) {
        Write-Host "你的 Visual Studio Code 已是最新版本!"
        return
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    }
	# (4) 安裝 - - - - -
    Start-Process -FilePath "$Directory\VSCode-win32-x64.exe" -ArgumentList "/VERYSILENT /MERGETASKS=!runcode" -wait
	# (6) 設定右鍵功能 - - - - - - - - - - (6) 設定右鍵功能 - - - - - - - - - - (6) 設定右鍵功能 - - - - - - - - - -
    # 6.1 檔案
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName -value "Kiloath $AppName" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\*\shell\$AppName -Name "Icon" -Value "$BinExe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName\command -value """$BinExe"" ""%1""" -Force | Out-Null
    # 6.2 目錄
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -value "Kiloath $AppName" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -Name "Icon" -Value "$BinExe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName\command -value """$BinExe"" ""%V""" -Force | Out-Null
}

Write-Host "--- 安裝 vscode ---"
Install
Write-Host "--- 完成 vscode ---"

