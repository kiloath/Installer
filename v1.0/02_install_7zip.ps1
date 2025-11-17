param(
	[switch]$h,
	[switch]$f,
	[switch]$force,
	[switch]$r,
	[string]$o = "KiloathAPP"
)
if ($h) {
    Write-Output @"
可用參數:
  -h       顯示此說明
  -f       不重新下載, 重新安裝
  -force   重新下載, 重新安裝
  -r       註冊檔案總管右鍵功能
  -o       輸出目錄名稱
"@
    exit
}
$OutputEncoding = [System.Text.Encoding]::UTF8
$AppName = "7-zip"
$RootDir = Join-Path $HOME $o
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#region 函式
#endregion 函式
function Install {
#region 前置作業
    $7zrDir = Join-Path $RootDir "7zr.exe"
    if(-not (Test-Path $7zrDir)) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $7zrUrl = "https://www.7-zip.org/a/7zr.exe"
        Invoke-WebRequest $7zrUrl -OutFile $7zrDir -UseBasicParsing
    }
#endregion 前置作業
#region 檢查更新
	$latest_version = "2501"
#endregion 檢查更新
#region 參數設定
	$DownloadName = "7z$latest_version-x64.exe"
    $DownloadUrl = "https://www.7-zip.org/a/${DownloadName}"
    $DownloadDir = Join-Path $RootDir $AppName
    $DownloadPath = Join-Path $DownloadDir $DownloadName
#endregion 參數設定
#region 下載
    if((Test-Path $DownloadPath) -and (-not $force)) {
		$msg = "你已下載: $DownloadName。"
		if(-not $f) {
			Write-Host "$msg 結束安裝"
			return 
		}
		else {
			Write-Host "$msg 不下載, 再次安裝"
		}
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
#endregion 下載
#region 解壓縮
    Start-Process -wait -FilePath $7zrDir -ArgumentList "x $DownloadPath -o""$DownloadDir"" -y" | Out-Null
#endregion 解壓縮
#region 設定Path
#endregion 設定Path
#region 捷徑
#endregion 捷徑
#region 連結
#endregion 連結
#region 右鍵功能
	if($r) {
		Write-Host "註冊右鍵功能。"
		$BinPath = Join-Path $DownloadDir "7zFM.exe"
		# 檔案
		New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName -value "Portable $AppName" -Force | Out-Null
		New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\*\shell\$AppName -Name "Icon" -Value "$BinPath" -Force | Out-Null
		New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName\command -value """$BinPath"" ""%1""" -Force | Out-Null
		# 目錄
		New-Item -Path HKCU:\SOFTWARE\Classes\DownloadDir\shell\$AppName -value "Portable $AppName" -Force | Out-Null
		New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\DownloadDir\shell\$AppName -Name "Icon" -Value "$BinPath" -Force | Out-Null
		New-Item -Path HKCU:\SOFTWARE\Classes\DownloadDir\shell\$AppName\command -value """$BinPath"" ""%V""" -Force | Out-Null
	}
#endregion 右鍵功能
}

Write-Host "--- 安裝 $AppName ---"
Install
Write-Host "--- 完成 $AppName ---"