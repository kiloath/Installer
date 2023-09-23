function Install {
      # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
      $DownloadUrl = "https://github.com/be5invis/Sarasa-Gothic/releases/download/v0.42.0/sarasa-gothic-ttf-unhinted-0.42.0.7z"
      $KiloathDir = Join-Path $HOME "KiloathApp"
      $Directory = Join-Path $KiloathDir "sarasa"
      $Target = Join-Path $Directory "sarasa-gothic-ttf-unhinted-0.42.0.7z"
      # (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - -
      # <#
      if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
          (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
      }
      #>
      # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
      if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 129722149)) {
          Write-Host "你已下載最新版"
      }
      else {
          New-Item $Directory -Force -ItemType Directory | Out-Null
          [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
          Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
      }
      # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
      Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$Directory"" sarasa-fixed-tc-regular.ttf -y" -Wait | Out-Null
      # (8) 獨有設定 - - - - - - - - - - - - (8) 獨有設定 - - - - - - - - - - - - (8) 獨有設定 - - - - - - - - - - - - 
      & "$Directory\sarasa-fixed-tc-regular.ttf"
}

Install
