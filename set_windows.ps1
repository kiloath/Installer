reg.exe add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
reg.exe add HKCU\Software\Classes\CLSID\`{86ca1aa0-34aa-4e8b-a509-50c905bae2a2`}\InprocServer32 /ve /f
Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage
winget install -e --id gerardog.gsudo --source winget
# (Invoke-WebRequest "https://raw.githubusercontent.com/kiloath/Installer/main/install_vcbuildtools.ps1" -UseBasicParsing).Content | Invoke-Expression
shutdown /r /t 10