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
  -r       無功能
  -o       輸出目錄名稱
"@
    exit
}
$OutputEncoding = [System.Text.Encoding]::UTF8
$AppName = "obs"
$RootDir = Join-Path $HOME $o
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#region 函式
#endregion 函式
function Install {
#region 前置作業
#endregion 前置作業
#region 檢查更新
#endregion 檢查更新
#region 參數設定
    $DownloadName = "OBS-Studio-32.0.1-Windows-x64.zip"
    $DownloadUrl = "https://cdn-fastly.obsproject.com/downloads/${DownloadName}"
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
	Start-Process -wait -FilePath "$RootDir\7-zip\7z.exe" -ArgumentList "x $DownloadPath -o""$DownloadDir"" -y" | Out-Null
#endregion 解壓縮
#region 設定Path
#endregion 設定Path
#region 捷徑
	$BinDir = Join-Path $DownloadDir "bin\64bit"
	$BinExe = "$BinDir\obs64.exe"
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\$AppName.lnk")
    $Shortcut.TargetPath = $BinExe
	$Shortcut.WorkingDirectory = $BinDir
    $Shortcut.Save()
#endregion 捷徑
#region 連結
#endregion 連結
#region 右鍵功能
#endregion 右鍵功能
}

Write-Host "--- 安裝 $AppName ---"
Install
Write-Host "--- 完成 $AppName ---"