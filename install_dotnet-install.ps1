function Install {
    Invoke-WebRequest "https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.ps1" -useb | Invoke-Expression
    [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User").TrimEnd(";") + ";" + "${env:LOCALAPPDATA}\Microsoft\dotnet", "User")
    $env:Path = $env:Path.TrimEnd(";") + ";${env:LOCALAPPDATA}\Microsoft\dotnet"
}

Write-Host "--- 安裝 dotnet-install ---"
Install
Write-Host "--- 完成 dotnet-install ---"
