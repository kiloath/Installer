Start-Process -FilePath "code" -ArgumentList "--install-extension MS-CEINTL.vscode-language-pack-zh-hant" -wait
$setting_argv_Path = "$HOME\.vscode\argv.json"
if(Test-Path $setting_argv_Path) {
    $settings = (Get-Content $setting_argv_Path -raw) -replace '\s*//.*' | ConvertFrom-Json
}
else {
    New-Item $setting_argv_Path -Force -ItemType "file" | Out-Null
    $settings = @{}
}
$settings | add-member -Name "locale" -Value "zh-tw" -MemberType NoteProperty -Force
$settings | ConvertTo-Json -Depth 32 | Set-Content $setting_argv_Path -Encoding "UTF8"
