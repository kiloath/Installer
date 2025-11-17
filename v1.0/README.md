# 安裝說明
## 安裝方式
* 在powershell下執行
  * UTF-8 BOM編碼
```
>01_install_aria2.ps1
```
* 使用bat檔安裝
  * ANSI編碼
```
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy remotesigned -File 01_install_aria2.ps1 -f
PAUSE
```
## 必要安裝
* 01_install_aria2.ps1
* 02_install_7zip.ps1
## 參數
```
01_install_aria2.ps1 -h
```
## 經驗
* path有長度限制, 也不希望去太多地方找, 所以想集中在一個目錄下
    * SymbolicLink最方便, 但要權限, 所以不採用
    ```
    New-Item -ItemType SymbolicLink -Path $LinkPath -Target $BinPath
    ```
    * HardLink不用權限, 但遇到像git要相對路徑就無法使用
    ```
    New-Item -ItemType HardLink -Path $LinkPath -Target $BinPath
    ```
    * git改用cmd檔可行, 但遇到oh my posh不認, 所以不採用, 最後還是只能設path
    ```
    $LinkPath = Join-Path $RootDir "git.cmd"
        if (Test-Path $LinkPath) {
        Remove-Item $LinkPath -Force
    }
    $cmdContent = @"
    @echo off
    setlocal
    set GIT_HOME=%~dp0git
    "%GIT_HOME%\cmd\git.exe" %*
    "@
    Set-Content -Path $LinkPath -Value $cmdContent -Encoding ASCII
    ```
# scoop
## 安裝scoop
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```
* 因為不能用管理員身分安裝, 所以關閉UAC時會無法安裝, 加上-RunAsAdmin即可。
```
Invoke-RestMethod https://get.scoop.sh -OutFile install-scoop.ps1
.\install-scoop.ps1 -RunAsAdmin
```
  
