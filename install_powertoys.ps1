function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://github.com/microsoft/PowerToys/releases/download/v0.80.0/PowerToysUserSetup-0.80.0-x64.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "PowerToys"
    $Target = Join-Path $Directory "PowerToysUserSetup-0.80.0-x64.exe"
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if((Get-Item $Target -ErrorAction SilentlyContinue)) {
        Write-Host "你已下載最新版"
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
    }
    Start-Process -FilePath $Target -ArgumentList "--passive" -wait
}

Write-Host "--- 安裝 PowerToys ---"
Install
Write-Host "--- 完成 PowerToys ---"
