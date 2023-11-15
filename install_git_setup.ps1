function Setup {
    git config --global diff.tool winmerge
    git config --global difftool.prompt false
    cmd /c "git config --global difftool.winmerge.cmd `"\`"$HOME\KiloathApp\winmerge\WinMergeU.exe\`" //wl \`"`$LOCAL\`" \`"`$REMOTE\`""
    git config --global gui.encoding utf-8
    git config --global merge.tool winmerge
    git config --global mergetool.winmerge.prompt false
    git config --global mergetool.keepBackup false
    git config --global mergetool.winmerge trustExitCode false
    C:\Users\WDAGUtilityAccount\AppData\Local\Programs\WinMerge\WinMergeU.exe                        /e /ub  /fr  /wl  /wm       /dl %bname     /dm %tname      /dr %yname  %base       %theirs         %mine /o %merged /ar
    cmd /c "git config --global mergetool.winmerge.cmd `"\`"$HOME\KiloathApp\winmerge\WinMergeU.exe\`" //ub //fr //wl //wm //ar //dl \`"基底\`" //dm MERGE_HEAD //dr HEAD \`"`$BASE\`" \`"`$REMOTE\`" \`"`$LOCAL\`" //o \`"`$MERGED\`"`""
    cmd /c "git config --global core.editor `"\`"$HOME\KiloathApp\notepad++\notepad++.exe\`" -multiInst -notabbar -nosession -noPlugin`""
}

Write-Host "--- 設定 git ---"
Setup
Write-Host "--- 設定 git ---"
