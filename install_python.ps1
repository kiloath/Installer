function Install {
    if(-not$v) { '請設定參數$v';return }
    $Version = $v
      # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
      $DownloadUrl = "https://www.python.org/ftp/python/$Version/python-$Version-amd64.exe"
      $KiloathDir = Join-Path $HOME "KiloathApp"
      $Directory = Join-Path $KiloathDir "python"
      $Target = Join-Path $Directory "python-$Version-amd64.exe"
      # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
      if(Test-Path $Target) {
        Write-Host "你已下載此版本, 請刪除重新執行或自行安裝: $Target"
        return
    }
      else {
          New-Item $Directory -Force -ItemType Directory | Out-Null
          [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
          Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
      }
      &$Target /quiet /passive PrependPath=1
}

Write-Host "--- 安裝 python ---"
Install
Write-Host "--- 安裝 python ---"
