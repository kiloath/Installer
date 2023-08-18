function latest_version {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://github.com/conan-io/conan/releases/latest"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    $realTagUrl = $response.ResponseUri.OriginalString
    $GitHubversion = $realTagUrl.split('/')[-1].Trim('v')
    return [System.Version]$GitHubversion
}
function current_version {
    if (-not (Get-Command "conan.exe" -ErrorAction SilentlyContinue)) {
        return [System.Version]"0.0.0"
    }
    else {
        return [System.Version]$(conan --version).Split()[2]
    }
}

function Install {
    $latest_version = latest_version
    $current_version = current_version
    Write-Host "你的版本: $current_version, 最新版本: $latest_version"
    if ( $latest_version -gt $current_version)
    {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $DownloadUrl = "https://github.com/conan-io/conan/releases/download/$latest_version/conan-$latest_version-windows-x86_64.zip"
        $KiloathDir = Join-Path $HOME "KiloathApp"
        $Directory = Join-Path $KiloathDir "conan"
        $Target = Join-Path $Directory "conan-$latest_version-windows-x86_64.zip"
        New-Item $Directory -Force -ItemType Directory | Out-Null
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
        Expand-Archive -Path $Target -DestinationPath $Directory -Force
        $BinDir = $Directory
        $regexInstallPath = [regex]::Escape($BinDir)
        if (-Not ($env:Path -Match "$regexInstallPath")) {
            [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
            $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
        }
    }
}

Write-Host "--- 安裝 conan ---"
Install
Write-Host "--- 完成 conan ---"

