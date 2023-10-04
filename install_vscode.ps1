function Install {
      # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
      $DownloadUrl = "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
      $KiloathDir = Join-Path $HOME "KiloathApp"
      $Directory = Join-Path $KiloathDir "VSCode"
      $Target = Join-Path $Directory "VSCodeUserSetup-x64-1.82.3.exe"
      # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
      if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 0)) {
          Write-Host "你已下載最新版"
      }
      else {
          New-Item $Directory -Force -ItemType Directory | Out-Null
          [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
          Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
      }
      &$Target -y
}

Install
