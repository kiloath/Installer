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
$AppName = "git"
$RootDir = Join-Path $HOME $o
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#region 函式
function latest_version {
    $DownloadUrl = "https://github.com/git-for-windows/git/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1].Trim('v')
    return $GitHubversion
}
function current_version {
    try {
        $output = & "$RootDir\git.exe" --version 2>$null
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
        $msg = "你的 ${AppName} 已是最新版本!"
		if (-not ($f -or $force)) {
			Write-Host "$msg 需使用 -f 或 -force 才會執行"
			return
		}
    }
    $verParts = $latest_version.split('.')
    if ($verParts[4] -eq "1") {
        $version = $verParts[0] + '.' + $verParts[1] + '.' + $verParts[2]
    }
    else {
        $version = $verParts[0] + '.' + $verParts[1] + '.' + $verParts[2] + '.' + $verParts[4]
    }
#endregion 檢查更新
#region 參數設定
    $DownloadName = "PortableGit-$version-64-bit.7z.exe"
    $DownloadUrl = "https://github.com/git-for-windows/git/releases/download/v$latest_version/PortableGit-$version-64-bit.7z.exe"
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
    Start-Process -FilePath "$DownloadPath" -ArgumentList "-o$DownloadDir -y" -wait | Out-Null
#endregion 解壓縮
#region 設定Path
    $BinDir = Join-Path $DownloadDir "cmd"
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
#endregion 設定Path
#region 捷徑
#endregion 捷徑
#region 連結
#endregion 連結
#region 右鍵功能
#endregion 右鍵功能
}

Write-Host "--- 安裝 $AppName ---"
Install
Write-Host "--- 完成 $AppName ---"