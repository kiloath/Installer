# 我在那裡?
* [我在這裡](https://kiloath.github.io/Installer/)
* [倉庫](https://github.com/kiloath/Installer)
# {1!} 初始
* set_windows.ps1 (All User, 需要權限, 執行完後會重開機)  
  (1) 關其他選項 (2) 關UAC, (3) 裝gsudo, (4) 移除 Cortana
   ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/set_windows.ps1 -useb).Content | iex
  ```
# {2!} Visual C++ 編譯環境安裝 (需要權限)
* vcbuildtools
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_vcbuildtools.ps1 -useb).Content | iex
  ```
# {2!} 同捆包
* git 同捆包  
(1) git, (2) notepad++, (3) winmerge, (4) git_setup
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/bundle_git_latest.ps1 -useb).Content | iex
  ```
* freecommanderxe 同捆包  
(1) vscode, (2) freecommanderxe
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/bundle_freecommanderxe.ps1 -useb).Content | iex
  ```
* allinone_dev.ps1 (By User, 不需權限)  
  7zr,7zip,vcbuildtools,sarasa,notepad++,vscode,powershell7,git,tortoisegit,winmerge,rust,conan,net8sdk,nodejs,python
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/allinone_dev.ps1 -useb).Content | iex
  ```
# {3!} 我的工具箱
* (1) 我的最愛 (無需權限)
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_powershell7.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_7zr.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_7zip.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_sarasa.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_notepad++_latest.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_git_latest.ps1 -useb).Content | iex
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
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_nodejs.ps1 -useb).Content | iex
  ```
* (3) 生活必需品 (無需權限)
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_drawio_latest.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_paintnet.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_sharex_latest.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_shotcut.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_sizer4.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_vidcoder.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_zoomit.ps1 -useb).Content | iex
  ```
* (4) 執行安裝程式 (無需權限)
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_winmerge_latest.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_rust.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_python.ps1 -useb).Content | iex
  ```
* (5) 執行安裝程式 (要權限)
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/install_vcbuildtools.ps1 -useb).Content | iex
  ```
* (6) 設定
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/set_powershell7.ps1 -useb).Content | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/set_final.ps1 -useb).Content | iex
  ```
# {4!} Youtube
* (1) [install_notepad++](https://youtu.be/iOaF_fMTBmE)
# {5!} 小抄
* tls
  ```
  yarn config set "strict-ssl" false
  curl -k https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore --output .gitignore
  ```
* docker
  ```
  RUN pip config set install.trusted-host "files.pythonhosted.org pypi.org"
  RUN pip install -r requirements.txt
  ENV NODE_TLS_REJECT_UNAUTHORIZED 0
  RUN yarn config set "strict-ssl" false 
  RUN npm config set strict-ssl false
  ```