$setting_argv_Path = "$HOME\.vscode\argv.json"
if(!(Test-Path $setting_argv_Path)) {
    New-Item $setting_argv_Path -Force -ItemType "file" | Out-Null
}
$settings = Get-Content $setting_argv_Path -raw | ConvertFrom-Json
$settings.profiles.defaults | add-member -Name "locale" -Value "zh-tw" -MemberType NoteProperty -Force
$settings | ConvertTo-Json -Depth 32 | Set-Content $setting_argv_Path -Encoding "UTF8"