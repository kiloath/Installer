function latest_version {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/git-for-windows/git/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1].Trim('v')
    #$verParts = $GitHubversion.split('.')
    #$version = $verParts[0]+'.'+$verParts[1]+'.'+$verParts[2]+'.'+$verParts[4]
    return $GitHubversion
}

function current_version {
    if (-not (Get-Command "git.exe" -ErrorAction SilentlyContinue)) {
        return [System.Version]"0.0.0.0"
    }
    else {
        #$verParts = $(git --version).Split()[2].split('.')
        #$version = $verParts[0]+'.'+$verParts[1]+'.'+$verParts[2]+'.'+$verParts[4]
        return $(git --version).Split()[2]
    }
}

function Install {
    $latest_version = latest_version
    $latest_version = latest_version
    $current_version = current_version
    Write-Host "git: 你的版本: $current_version, 最新版本: $latest_version"
    if ( $latest_version -eq $current_version) {
        Write-Host "你的 git 已是新版本"
        return
    }
    $verParts = $latest_version.split('.')
    $version = $verParts[0] + '.' + $verParts[1] + '.' + $verParts[2] + '.' + $verParts[4]
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://github.com/git-for-windows/git/releases/download/v$latest_version/PortableGit-$version-64-bit.7z.exe"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "git"
    $Target = Join-Path $Directory "PortableGit-$version-64-bit.7z.exe"
    $BinDir = Join-Path $Directory "cmd"
    # (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - -
    if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
    }
    # (3) 下載 - - - - - - - - - - - - - - (3) 下載 - - - - - - - - - - - - - -(3) 下載 - - - - - - - - - - - - - -
    New-Item $Directory -Force -ItemType Directory | Out-Null
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$Directory"" -y" -wait | Out-Null
    # (5) 設定 Path- - - - - - - - - - - - (5) 設定 Path- - - - - - - - - - - - (5) 設定 Path- - - - - - - - - - - -
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
}

Write-Host "--- 安裝 git ---"
Install
Write-Host "--- 完成 git ---"
