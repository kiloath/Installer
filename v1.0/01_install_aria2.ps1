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
$AppName = "aria2"
$RootDir = Join-Path $HOME $o
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#region 函式
function latest_version {
    $DownloadUrl = "https://github.com/aria2/aria2/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('-')[-1]
    return $GitHubversion
}
function current_version {
    try {
		$output = & "$RootDir\aria2c.exe" --version 2>$null
		return [System.Version]($output.Split()[2])
	}
	catch {
		return [System.Version]"0.0.0.0"
	}
}
#endregion 函式
function Install {
#region 前置作業
#endregion 前置作業
#region 檢查更新
    $latest_version = latest_version
    $current_version = current_version
    Write-Host "${AppName}: 你的版本: ${current_version}, 最新版本: ${latest_version}"
    if ( $latest_version -eq $current_version) {
        $msg=  "你的 ${AppName} 已是最新版本!"
		if (-not ($f -or $force)) {
			Write-Host "$msg 需使用 -f 或 -force 才會執行"
			return
		}
    }
#endregion 檢查更新
#region 參數設定
	$DownloadName = "aria2-${latest_version}-win-64bit-build1.zip"
	$DownloadUrl = "https://github.com/aria2/aria2/releases/download/release-${latest_version}/${DownloadName}"
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
        Invoke-WebRequest $DownloadUrl -OutFile $DownloadPath -UseBasicParsing
    }
#endregion 下載
#region 解壓縮
	Expand-Archive -Path $DownloadPath -DestinationPath $DownloadDir -Force
#endregion 解壓縮
#region 設定Path
    $regexInstallPath = [regex]::Escape($RootDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $RootDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $RootDir 
    }
#endregion 設定Path
#region 捷徑
#endregion 捷徑
#region 連結
	$LinkPath = Join-Path $RootDir "aria2c.exe"
    $BinPath = Join-Path $DownloadDir "aria2-$latest_version-win-64bit-build1\aria2c.exe"
	if (Test-Path $LinkPath) {
		Remove-Item $LinkPath -Force
	}
	New-Item -ItemType HardLink -Path $LinkPath -Target $BinPath
	# cmd /c mklink $LinkPath $BinPath
#endregion 連結
#region 右鍵功能
#endregion 右鍵功能
}

Write-Host "--- 安裝 $AppName ---"
Install
Write-Host "--- 完成 $AppName ---"