function get_URL {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://t.arctime.cn/ap2w64"
    $request = [System.Net.WebRequest]::Create($DownloadUrl)
    $response = $request.GetResponse()
    return $response.ResponseUri.OriginalString
}

function Install {
    $DownloadUrl = get_URL
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "arctime"
    $Target = Join-Path $Directory $($DownloadUrl.split('/')[-1])
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    # (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - -
    if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
    }
    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$Directory\temp"" -y" -wait | Out-Null
    $BinDir = $(Get-ChildItem "$Directory\temp" | Select-Object -First 1).Name
    Copy-Item -Path "$Directory\temp\*" -Destination $Directory -Recurse -Force
    Remove-Item -Path "$Directory\temp" -Recurse -Force
    $BinDir = Join-Path $Directory $BinDir
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\arctime.lnk")
    $Shortcut.TargetPath = "$BinDir\Arctime Pro.exe"
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
}

Write-Host "--- 安裝 Arctime ---"
Install
Write-Host "--- 完成 Arctime ---"