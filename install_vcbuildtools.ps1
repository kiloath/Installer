function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://aka.ms/vs/17/release/vs_buildtools.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "vcbuildtools"
    $Target = Join-Path $Directory "vs_buildtools.exe"
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 3947312)) {
        Write-Host "你已安裝最新版"
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
        Start-Process -FilePath "$Target" -ArgumentList "--layout $Directory\VSlayout --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --lang en-US" -Wait        
    }
    &$Directory\VSlayout\vs_setup.exe
    $BinDir = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin"
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
}

Install
