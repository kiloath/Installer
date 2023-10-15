$settingPath = "$env:localappdata\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$settings = Get-Content $settingPath -raw | ConvertFrom-Json


$font = @"
{
   "face": "CaskaydiaCove Nerd Font Mono"
}
"@
$settings.profiles.defaults | add-member -Name "font" -Value (ConvertFrom-Json -InputObject $font) -MemberType NoteProperty -Forc
$settings | ConvertTo-Json -Depth 32 | Set-Content $settingPath -Encoding "UTF8"

<#
"defaults": {
      "backgroundImage": "C:\\Users\\pthsu\\Pictures\\背景\\背景.jpg",
      "backgroundImageOpacity": 0.3,
      "font": {
        "face": "CaskaydiaCove Nerd Font Mono"
      }
#>