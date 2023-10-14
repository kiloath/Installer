function Install {
      # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
      $DownloadUrl = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
      $KiloathDir = Join-Path $HOME "KiloathApp"
      $Directory = Join-Path $KiloathDir "rust"
      $Target = Join-Path $Directory "python-3.12.0-amd64.exe"
      # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
      if(Get-Item $Target -ErrorAction SilentlyContinue) {
          Write-Host "你已下載安裝"
      }
      else {
          New-Item $Directory -Force -ItemType Directory | Out-Null
          [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
          Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
      }
      &$Target /quiet PrependPath=1
}

Write-Host "--- 安裝 python ---"
Install
Write-Host "--- 安裝 python ---"
