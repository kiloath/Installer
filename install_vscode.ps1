function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "VSCode"
    $Target = Join-Path $Directory "VSCode-win32-x64.exe"
	$BinDir = "$env:LOCALAPPDATA\Programs\Microsoft VS Code"
    $BinExe = "$BinDir\Code.exe"
	$AppName = "VSCode"

    # (3) 下載 - - - - - - - - - - - (3) 下載 - - - - - - - - - - - (3) 下載 - - - - - - - - - - -
    New-Item $Directory -Force -ItemType Directory | Out-Null
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
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

