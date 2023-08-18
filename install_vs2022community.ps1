function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://aka.ms/vs/17/release/vs_community.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "vs2022community"
    $Target = Join-Path $Directory "vs_community.exe"
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(Get-Item $Target -ErrorAction SilentlyContinue) {
        Write-Host "你已下載, 不再重複下載, 執行安裝。"
        # return
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
        # Start-Process -FilePath "$Target" -ArgumentList "--layout $Directory\VSlayout --add Microsoft.VisualStudio.Workload.NativeDesktop; --includeRecommended --includeOptional --add Microsoft.VisualStudio.Component.VC.ATLMFC --add Microsoft.VisualStudio.Component.VC.CLI.Support --add Microsoft.VisualStudio.Component.VC.Llvm.Clang --lang en-US --lang zh-TW --passive" -wait
        $params = (
            "--layout $Directory\VSlayout " +
            "--add Microsoft.VisualStudio.Workload.ManagedDesktop;includeRecommended " +
            "--add Microsoft.VisualStudio.Workload.NetWeb;includeRecommended " +
            "--add Microsoft.VisualStudio.Workload.NativeDesktop;includeRecommended " + 
            "--add Microsoft.VisualStudio.Component.VC.ATLMFC " +
            "--add Microsoft.VisualStudio.Component.VC.CLI.Support " +
            "--add Microsoft.VisualStudio.Component.WinXP " +
            "--add Microsoft.VisualStudio.Component.VC.140 " +
            "--lang en-US --lang zh-TW --passive"
        )
        Start-Process -FilePath "$Target" `
        -ArgumentList $params `
        -wait
    }
    Start-Process -FilePath "$Directory\VSlayout\vs_setup.exe" -ArgumentList "--noWeb --wait --passive" -wait
    $BinDir = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin"
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
}

Write-Host "--- 安裝 Visual Studio 2022 Community ---"
Install
Write-Host "--- 安裝 Visual Studio 2022 Community ---"
