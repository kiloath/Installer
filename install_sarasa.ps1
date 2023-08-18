function latest_version {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/be5invis/Sarasa-Gothic/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1].Trim('v')
    return [System.Version]$GitHubversion
}
function Install {
    $latest_version = latest_version
    $DownloadUrl = "https://github.com/be5invis/Sarasa-Gothic/releases/download/v$latest_version/sarasa-gothic-ttf-unhinted-$latest_version.7z"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "sarasa"
    $Target = Join-Path $Directory "sarasa-gothic-ttf-unhinted-$latest_version.7z"
    if((Get-Item $Target -ErrorAction SilentlyContinue)) {
        Write-Host "你已下載安裝"
        return
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
    }
      # (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - -
      # <#
      if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
          (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
      }
      #>
      # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
      Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$Directory"" sarasa-fixed-tc-regular.ttf -y" -Wait | Out-Null
      # (8) 獨有設定 - - - - - - - - - - - - (8) 獨有設定 - - - - - - - - - - - - (8) 獨有設定 - - - - - - - - - - - - 
      New-Item "$Env:LocalAppData\Microsoft\Windows\Fonts\" -Force -ItemType Directory | Out-Null
      Copy-Item -Path "$Directory\sarasa-fixed-tc-regular.ttf" -Destination "$Env:LocalAppData\Microsoft\Windows\Fonts\" -Force
      New-ItemProperty -LiteralPath "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name "Sarasa Fixed TC (TrueType)" -Value "$Env:LocalAppData\Microsoft\Windows\Fonts\sarasa-fixed-tc-regular.ttf" -Force | Out-Null
}

Write-Host "--- 安裝 sarasa ---"
Install
Write-Host "--- 完成 sarasa ---"
