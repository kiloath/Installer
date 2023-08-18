function Setup {
    git config --global user.name Kiloath
    git config --global user.email kiloath@outlook.com
    git config --global http.sslVerify false
    git config --global core.quotepath false
    git config --global diff.tool winmerge
    git config --global difftool.prompt false
    cmd /c "git config --global difftool.winmerge.cmd `"\`"$HOME\KiloathApp\winmerge\WinMergeU.exe\`" //wl \`"`$LOCAL\`" \`"`$REMOTE\`""
    git config --global gui.encoding utf-8
    git config --global merge.tool winmerge
    git config --global mergetool.winmerge.prompt false
    git config --global mergetool.keepBackup false
    git config --global mergetool.winmerge trustExitCode false
    cmd /c "git config --global mergetool.winmerge.cmd `"\`"$HOME\KiloathApp\winmerge\WinMergeU.exe\`" //ub //fr //wl //wm //ar //dl \`"基底\`" //dm MERGE_HEAD //dr HEAD \`"`$BASE\`" \`"`$REMOTE\`" \`"`$LOCAL\`" //o \`"`$MERGED\`"`""
    cmd /c "git config --global core.editor `"\`"$HOME\KiloathApp\notepad++\notepad++.exe\`" -multiInst -notabbar -nosession -noPlugin`""
}

Write-Host "--- 設定 git ---"
Setup
Write-Host "--- 設定 git ---"
