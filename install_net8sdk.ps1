function Install {
    # (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - - (1) 參數設定 - - - - - - - - - - - -
    $DownloadUrl = "https://download.visualstudio.microsoft.com/download/pr/577fe112-f607-4ab3-abbc-8be20c643c29/b51011ff804ad47051bd9d81c6e737c0/dotnet-sdk-8.0.100-rc.1.23463.5-win-x64.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "net8sdk"
    $Target = Join-Path $Directory "dotnet-sdk-8.0.100-rc.1.23463.5-win-x64.zip"
    $BinDir = "$Directory"
    $BinExe = "$BinDir\dotnet.exe"
    # (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - - (2) 需要7z來解壓縮 - - - - - - - - -
    <#
    if (-not (Get-Command "7zr.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1" -UseBasicParsing).Content | Invoke-Expression
    }
    #>
    # (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - - (3) 是否已下載 - - - - - - - - - - -
    if(($file = Get-Item $Target -ErrorAction SilentlyContinue) -And ($file.Length -eq 282422497)) {
        Write-Host "你已下載最新版"
    }
    else {
        New-Item $Directory -Force -ItemType Directory | Out-Null
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing        
    }
    # (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - - (4) 解壓縮 - - - - - - - - - - - - -
    # Start-Process -FilePath "7zr.exe" -ArgumentList "x $Target -o""$Directory"" -y" | Out-Null
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    # (5) 設定 Path- - - - - - - - - - - - (5) 設定 Path- - - - - - - - - - - - (5) 設定 Path- - - - - - - - - - - -
    <#
    $regexInstallPath = [regex]::Escape($BinDir)
    if (-Not ($env:Path -Match "$regexInstallPath")) {
        [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + $BinDir, "User")
        $env:Path = $env:Path.TrimEnd(";") + ";" + $BinDir
    }
    #>
    # (6) 設定右鍵功能 - - - - - - - - - - (6) 設定右鍵功能 - - - - - - - - - - (6) 設定右鍵功能 - - - - - - - - - -
    # 6.1 檔案
    <#
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName -value "Kiloath $AppName" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\*\shell\$AppName -Name "Icon" -Value "$BinExe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\*\shell\$AppName\command -value """$BinExe"" ""%1""" -Force | Out-Null
    #>
    # 6.2 目錄
    <#
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -value "Kiloath $AppName" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\$AppName -Name "Icon" -Value "$BinExe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\$AppName\command -value """$KiloathDir\powershell\pwsh.exe"" -WorkingDirectory ""%V"" -NoLogo -NoExit -File ""$Directory\net8sdk.ps1""" -Force | Out-Null
    #>
    # (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - - (7) 捷徑 - - - - - - - - - - - - - -
    <#
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut("$KiloathDir\$AppName.lnk")
    $Shortcut.TargetPath = $BinExe
    $Shortcut.Save()
    $Shortcut = $WshShell.CreateShortcut("$([Environment]::GetFolderPath('Desktop'))\KiloathApp.lnk")
    $Shortcut.TargetPath = Join-Path $HOME "KiloathApp"
    $Shortcut.Save()
    #>
    # (8) 獨有設定 - - - - - - - - - - - - (8) 獨有設定 - - - - - - - - - - - - (8) 獨有設定 - - - - - - - - - - - - 
    '$ENV:DOTNET_ROOT="' + $BinDir + '"' > $BinDir\net8sdk.ps1
    '$ENV:PATH="' + $BinDir + ';$ENV:PATH"'  >> $BinDir\net8sdk.ps1
    if (-not (Get-Item "$KiloathDir\powershell\pwsh.exe" -ErrorAction SilentlyContinue)) {
        (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_powershell7.ps1" -UseBasicParsing).Content | Invoke-Expression
    }

    $settingPath = "$env:localappdata\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    $settings = Get-Content $settingPath -raw | ConvertFrom-Json
    if ($null -eq ($settings.profiles.list | Where-Object { $_.guid -eq "{8cc13171-dc35-4986-9d2a-209ca72fb476}" })) {
        $commandline = """$KiloathDir\powershell\pwsh.exe"" -NoLogo -NoExit -File ""$Directory\net8sdk.ps1""".Replace('\', '\\').Replace('"','\"')
        $BinExe = $BinExe.Replace('\', '\\')
        $newProfile = @"
        {
          "commandline": "$commandline",
          "guid": "{8cc13171-dc35-4986-9d2a-209ca72fb476}",
          "hidden": false,
          "name": "Kiloath Net8",
          "icon": "$BinExe",
          "startingDirectory": null
        }
"@
        $settings.profiles.list += (ConvertFrom-Json -InputObject $newProfile)
        $settings | ConvertTo-Json -Depth 32 | Set-Content $settingPath -Encoding "UTF8"
    }
}

Write-Host "--- 安裝 net8sdk ---"
Install
Write-Host "--- 完成 net8sdk ---"
