winget install -e --id JanDeDobbeleer.OhMyPosh --source winget
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

$KiloathDir = Join-Path $HOME "KiloathApp"
$Directory = Join-Path $KiloathDir "powershell"
$Download_Powershell_Profile_Url = "https://github.com/kiloath/Installer/raw/main/assets/powershell_profile.txt"
$Download_Powershell_Profile_Local = Join-Path $Directory "powershell_profile.txt"
Invoke-WebRequest $Download_Powershell_Profile_Url -OutFile $Download_Powershell_Profile_Local -UseBasicParsing
$Powershell_Profile_Content = Get-Content $Download_Powershell_Profile_Local -raw

if (-not (Get-Item $PROFILE -ErrorAction SilentlyContinue)) {
    New-Item -Path $PROFILE -Type File -Force
}
$PROFILE_CONTENT = Get-Content $PROFILE -raw
$MatchInfo = $PROFILE_CONTENT | Select-String -Pattern ".*# kiloath #(.|`n)*# kiloath #.*`n?" -AllMatches

$MatchInfo.Matches | ForEach-Object  {
    if( $_ -ne $null) {
        $PROFILE_CONTENT = $PROFILE_CONTENT.Replace($_.Value,"")
    }
}
$PROFILE_CONTENT | Set-Content $PROFILE -Encoding "UTF8"
Add-Content $PROFILE $Powershell_Profile_Content

$env:POSH_THEMES_PATH = [System.Environment]::GetEnvironmentVariable("POSH_THEMES_PATH","User")
$Download_kiloath_omp_json_Url = "https://github.com/kiloath/Installer/raw/main/assets/kiloath.omp.json"
$Download_kiloath_omp_json_Local = "$env:POSH_THEMES_PATH\kiloath.omp.json"
Invoke-WebRequest $Download_kiloath_omp_json_Url -OutFile $Download_kiloath_omp_json_Local -UseBasicParsing

# gsudo {oh-my-posh font install CascadiaCode;exit}
& oh-my-posh font install CascadiaCode

$settingPath = "$env:localappdata\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$settings = Get-Content $settingPath -raw | ConvertFrom-Json
$font = @"
{
   "face": "CaskaydiaCove Nerd Font Mono"
}
"@
$settings.profiles.defaults | add-member -Name "font" -Value (ConvertFrom-Json -InputObject $font) -MemberType NoteProperty -Force
$settings | ConvertTo-Json -Depth 32 | Set-Content $settingPath -Encoding "UTF8"