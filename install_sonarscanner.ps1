function Install {
    if(-not$v) { '請設定參數$v';return }
    $Version = $v #6.2.1.4610
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$Version-windows-x64.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "sonar-scanner"
    $Target = Join-Path $Directory "sonar-scanner-cli-$Version-windows-x64.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
}

Write-Host "--- 安裝 sonar-scanner ---"
Install
Write-Host "--- 完成 sonar-scanner ---"