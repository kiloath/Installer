function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://aka.ms/vs/17/release/vs_buildtools.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "vcbuildtools"
    $Target = Join-Path $Directory "vs_buildtools.exe"
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(Get-Item $Target -ErrorAction SilentlyContinue) {
        Write-Host "你己下載安裝"
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
        Start-Process -FilePath "$Target" -ArgumentList "--layout $Directory\VSlayout --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --lang en-US" -Wait        
    }
    &$Directory\VSlayout\vs_setup.exe --quiet
    $BinDir = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin"
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
}

Write-Host "--- 安裝 vcbuildtools ---"
Install
Write-Host "--- 完成 vcbuildtools, 實際上安裝程式在背景執行, 約5分鐘才完成, 可執行 'cmake --version' 來確認是否完成 ---"
