function Install {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $DownloadUrl = "https://download.visualstudio.microsoft.com/download/pr/4ede0897-e03d-4d93-a50d-e06f2e430d9e/b5bd2605ce07ec7163d5b5b05dc2f1e0/dotnet-sdk-8.0.100-preview.7.23376.3-win-x64.zip"
    $KiloathDir = Join-Path $HOME "KiloathApp"
    $Directory = Join-Path $KiloathDir "net8sdk"
    $Target = Join-Path $Directory "dotnet-sdk-8.0.100-preview.7.23376.3-win-x64.zip"
    New-Item $Directory -Force -ItemType Directory | Out-Null
    Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
    Expand-Archive -Path $Target -DestinationPath $Directory -Force
    $BinDir = $Directory
    '$ENV:DOTNET_ROOT="D:\Portable\dotnet-sdk-8"' > $BinDir\net8sdk.ps1
    '$ENV:PATH = "D:\Portable\dotnet-sdk-8;$ENV:PATH"'  >> $BinDir\net8sdk.ps1
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\net8sdk -value ".NET8 DEV" -Force | Out-Null
    New-ItemProperty -LiteralPath HKCU:\SOFTWARE\Classes\Directory\shell\net8sdk -Name "Icon" -Value "$BinDir\dotnet.exe" -Force | Out-Null
    New-Item -Path HKCU:\SOFTWARE\Classes\Directory\shell\net8sdk\command -value """$Env:ProgramFiles\PowerShell\7\pwsh.exe"" -WorkingDirectory ""%V"" -NoLogo -NoExit -File ""$Directory\net8sdk.ps1""" -Force | Out-Null
}

Install
# 自行在Windows Terminal設定