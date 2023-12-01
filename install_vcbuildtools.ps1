function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://aka.ms/vs/17/release/vs_buildtools.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "vcbuildtools"
    $Target = Join-Path $Directory "vs_buildtools.exe"
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(Get-Item $Target -ErrorAction SilentlyContinue) {
        Write-Host "你已下載, 不再重複下載, 執行安裝。"
        # return
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
        Start-Process -FilePath "$Target" -ArgumentList "--layout $Directory\VSlayout --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --lang en-US --passive" -wait
    }
    Start-Process -FilePath "$Directory\VSlayout\vs_setup.exe" -ArgumentList "--passive" -wait
    $BinDir = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin"
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
}

Write-Host "--- 安裝 vcbuildtools ---"
Install
Write-Host "--- 完成 vcbuildtools ---"
