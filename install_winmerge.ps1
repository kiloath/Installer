function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://github.com/WinMerge/winmerge/releases/download/v2.16.32/WinMerge-2.16.32-x64-PerUser-Setup.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "winmerge"
    $Target = Join-Path $Directory "WinMerge-2.16.32-x64-PerUser-Setup.exe"
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 9815360)) {
        Write-Host "你已安裝最新版"
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
        &$Target /VERYSILENT /DIR=$Directory    
    }
}

Install
