# 我在那裡?
* [我在這裡](https://kiloath.github.io/Installer/)
* [倉庫](https://github.com/kiloath/Installer)

## {1!} 我的最愛
* [零度解说](https://www.youtube.com/@零度解说)
* [PAPAYA 電腦教室](https://www.youtube.com/@papayaclass)
* [小友玩電腦](https://www.youtube.com/@youplaycomputer)

## {2!} 網路資源
* [Windows 自動安裝](https://schneegans.de/windows/unattend-generator/)

## {3!} 安裝指令
* 指令
  ```
  $ps='' # 請先設定命令
  irm -Uri https://gitlab.com/api/v4/projects/58360840/repository/files/$ps/raw | iex
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/$ps -useb).Content | iex
  ```

## {4!} Fortinet
* 匯出憑證
  ```
  $ps='export_crt.ps1'
  ```

## {5!} 初始
* set_windows.ps1 (All User, 需要權限, 執行完後會重開機)  
  (1) 關其他選項 (2) 關UAC, (3) 裝gsudo, (4) 移除 Cortana
  ```
  $ps='set_windows.ps1'
  ```

## {6!} 需要權限
* 需要權限
  ```
  $ps='install_vcbuildtools.ps1'          # Visual C++ 編譯環境安裝
  $ps='install_vs2022community.ps1'       # Visual Studio 2022 Community
  $ps='install_docker.ps1'                # docker
  $ps='install_rancherdesktop_latest.ps1' # Rancher Desktop
  ```

## {7!} 同捆包
* 同捆包  
  ```
  $ps='bundle_git_latest.ps1' # (1) git, (2) notepad++, (3) winmerge, (4) git_setup
  $ps='bundle_freecommanderxe.ps1' # (1) vscode, (2) freecommanderxe
  ```
* allinone_dev.ps1 (By User, 不需權限)  
  7zr,7zip,vcbuildtools,sarasa,notepad++,vscode,powershell7,git,tortoisegit,winmerge,rust,conan,net8sdk,nodejs,python
  ```
  $ps='allinone_dev.ps1'
  ```

## {8!} 我的工具箱
* (1) 我的最愛 (無需權限)
  ```
  $v='4.6';$ps='install_rufus.ps1'                # Rufus
  $v='24.8.2';$ps='install_libreoffice.ps1'       # LibreOffice
  $v='6.2.1.4610';$ps='install_sonarscanner.ps1'  # sonar-scanner cli
  $ps='install_anyburn_always.ps1'                # AnyBurn
  $ps='install_powershell7_latest.ps1'            # powershell 7
  $ps='install_powershell7_setup.ps1'             # powershell 7 客製
  $ps='install_7zr.ps1'
  $ps='install_7zip.ps1'
  $ps='install_git_latest.ps1'
  $ps='install_tortoisegit.ps1'
  $ps='install_freecommanderxe_always.ps1'
  $ps='install_powertoys.ps1'
  $ps='install_synologychat.ps1'
  $ps='install_dotnet-install.ps1'
  ```
* (2) 多媒體 (Portable)
  ```
  $ps='install_sharex_latest.ps1'        # 抓圖及錄桌面
  $ps='install_obs.ps1'                  # 專業錄桌面
  $ps='install_krita.ps1'                # 繪圖
  $ps='install_imageglass_latest.ps1'    # 秀圖
  $ps='install_drawio_latest.ps1'        # 向量流程圖
  $ps='install_shotcut_latest.ps1'       # 影像編輯
  $ps='install_shotcut_v22.ps1'          # 支援雙螢幕
  $ps='install_vidcoder_latest.ps1'      # 影片壓縮
  $ps='install_arctime.ps1'              # 字幕
  $v='3.0.21';$ps='install_vlc.ps1'      # 播放器
  $ps='install_notepad++_latest.ps1'     # 文字編輯器
  $ps='install_sarasa.ps1'               # 更紗黑體
  $ps='install_tiddlydesktop_latest.ps1' # TiddlyWiki 編輯器
  $ps='install_logseq_latest.ps1'        # logseq 編輯器
  $ps='install_vscode.ps1'               # Visual Studio Code
  $ps='install_paintnet.ps1'             # paint.net(我用krita)
  $ps='install_pyTranscriber_latest.ps1' # 影片轉字幕
  ```
* (2) 開發必備 (無需權限)
  ```
  $ps='install_conan_latest.ps1' # C++
  $ps='install_dbeaver_23_3_5.ps1' # 資料庫管理
  $ps='install_doxygen.ps1' # C++ 文件製作
  $ps='install_ruby.ps1' # Ruby
  $ps='install_net8sdk.ps1' # .Net 8
  $ps='install_nodejs.ps1' # Node JS
  $ps='install_spin_latest.ps1' # rust wasi
  ```
* (3) 生活必需品 (無需權限)
  ```
  $ps='install_sizer4.ps1'
  $ps='install_zoomit.ps1'
  ```
* (4) 執行安裝程式 (無需權限)
  ```
  $ps='install_winmerge_latest.ps1'
  $ps='install_rust.ps1'
  $v='3.13.0';$ps='install_python.ps1'
  ```
* (5) 執行安裝程式 (要權限)
  ```
  $ps='install_vcbuildtools.ps1'
  ```
* (6) 設定
  ```
  $ps='set_final.ps1'
  ```
* (7) 安裝 net8 desktop runtime
  ```
  (iwr https://raw.githubusercontent.com/dotnet/install-scripts/main/src/dotnet-install.ps1 -useb).Content -replace '\[string\]\$Runtime,','[string]$Runtime="windowsdesktop",' -replace '\[string\]\$Version="Latest"','[string]$Version="7.0.18"' | iex
  (iwr https://raw.githubusercontent.com/dotnet/install-scripts/main/src/dotnet-install.ps1 -useb).Content -replace '\[string\]\$Runtime,','[string]$Runtime="windowsdesktop",' | iex
  ```

## {9!} Dockerfile
* Dockerfile
  ```
  iwr -ou Dockerfile_spin https://raw.githubusercontent.com/kiloath/Installer/main/Dockerfile_spin -useb && docker build -t kospin -f Dockerfile_spin .
  ```

## {10!} Youtube
* (1) [install_notepad++](https://youtu.be/iOaF_fMTBmE)

## {11!} 小抄
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

## {12!} 參數
  ```
  (iwr https://raw.githubusercontent.com/kiloath/Installer/main/echo.ps1 -useb).Content -replace '\[string\]\$name.*','[string]$name="kiloath"' | iex
  ```

## {13!} HyperV
* Nested Virtualization
  ```
  Set-VMProcessor -VMName 'win' -ExposeVirtualizationExtensions $true
  ```
## {14!} Docker Prepare
* For Rancher/Docker Desktop
  ```
  dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
  dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
  * 請重啟電腦
  wsl --update
  ```
  
* For Windows Docker
  ```
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
  Enable-WindowsOptionalFeature -Online -FeatureName containers -All
  ```
## {15!} 遺產
* 執行install前, 先執行以下跳過SSL檢查。(都會有憑證所以不需要了)
  ```
  [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
  ```
