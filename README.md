# 我在那裡?
* [我在這裡](https://kiloath.github.io/Installer/)
* [倉庫](https://github.com/kiloath/Installer)
# {1!} allinone
* allinone_a.ps1
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/allinone_a.ps1 -useb).Content | iex
  ```
# {1!} 我的工具箱
* (1) 我的最愛 (無需權限)
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_powershell7.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_7zip.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_sarasa.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_notepad++.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_git.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_tortoisegit.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_freecommanderxe.ps1 -useb).Content | iex

  ```
* (2) 開發必備 (無需權限)
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_vscode.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_conan.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_dbeaver.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_doxygen.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_ruby.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_net8sdk.ps1 -useb).Content | iex
  ```
* (3) 生活必需品 (無需權限)
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_drawio.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_paintnet.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_sharex.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_shotcut.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_sizer4.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_vidcoder.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_zoomit.ps1 -useb).Content | iex
  ```
* (4) 執行安裝程式 (無需權限)
  ```
   (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_winmerge.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_rust.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_python.ps1 -useb).Content | iex
  ```
* (5) 執行安裝程式 (要權限)
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_vcbuildtools.ps1 -useb).Content | iex
  ```
# {2!} Youtube
* (1) [install_notepad++](https://youtu.be/iOaF_fMTBmE)
# {3!} 小抄
  * windows 11 即時提權 (辧公室電腦)
    ```
    winget install gerardog.gsudo
    ```
  * windows 11 永久提權 (個人電腦)
    ```
    reg.exe add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
    ```
  * windows 11 關閉其他選項
    ```
    reg.exe add HKCU\Software\Classes\CLSID\`{86ca1aa0-34aa-4e8b-a509-50c905bae2a2`}\InprocServer32 /ve /f
    ```
  * 移除 Cortana
    ```
    Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage
    ```
  * git
  ```
  git config --global diff.tool winmerge
  git config --global difftoo.prompt false
  git config --global difftool.winmerge.path "$HOME\KiloathApp\winmerge\WinMergeU.exe"
  git config --global gui.encoding utf-8
  git config --global merge.tool winmerge
  git config --global mergetool.winmerge.prompt false
  git config --global mergetool.keepBackup false
  git config --global mergetool.winmerge trustExitCode false
  git config --global mergetool.winmerge.cmd "`"$HOME\KiloathApp\winmerge\WinMergeU.exe`" //ub //fr //wl //wm //ar //dl `"基底`" //dm MERGE_HEAD //dr HEAD `"`$BASE`" `"`$REMOTE`" `"`$LOCAL`" //o `"`$MERGED`""
  ```