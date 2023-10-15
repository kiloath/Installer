<# winget search oh-my-posh
New-Item -Path $PROFILE -Type File -ErrorAction SilentlyContinue
https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1
https://github.com/kiloath/Installer/raw/main/src/TortoiseGit.7z
notepad $PROFILE
$DownloadUrl = "https://github.com/kiloath/Installer/raw/main/assets/kiloath.comp.json"
$KiloathDir = Join-Path $HOME "KiloathApp"
$Directory = Join-Path $KiloathDir "powershell"
New-Item $Directory -Force -ItemType Directory | Out-Null
Invoke-WebRequest $DownloadUrl -OutFile $Target -UseBasicParsing
#>
$KiloathDir = Join-Path $HOME "KiloathApp"
$Directory = Join-Path $KiloathDir "powershell"
# $Download_Powershell_Profile_Url = "https://github.com/kiloath/Installer/raw/main/assets/powershell_profile.txt"
$Download_Powershell_Profile_Local = $Directory
# Invoke-WebRequest $Download_Powershell_Profile_Url -OutFile $Download_Powershell_Profile_Local -UseBasicParsing
$Powershell_Profile_Content = Get-Content $Download_Powershell_Profile_Local -raw
# Write-Host $Powershell_Profile_Content
$B = $Powershell_Profile_Content | Select-String -Pattern "#/m" -AllMatches -Context 0,2
$B.Matches.Length
$B.Matches | ForEach-Object {
    Write-Host $_
}
<# if($file = Get-Item $PROFILE -ErrorAction SilentlyContinue) {
}
else {
    $file = New-Item -Path $PROFILE -Type File
}
$Profile_Content = Get-Content $file -raw
Write-Host $profile_Content
#>