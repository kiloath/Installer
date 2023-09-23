function Install {
      # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
      $DownloadUrl = "https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-msvc/rustup-init.exe"
      $KiloathDir = Join-Path $HOME "KiloathApp"
      $Directory = Join-Path $KiloathDir "rust"
      $Target = Join-Path $Directory "rustup-init.exe"
      # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
      if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 8594944)) {
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
