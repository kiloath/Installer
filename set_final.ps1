[Environment]::SetEnvironmentVariable("CARGO_HTTP_CHECK_REVOKE", "false","User")
[Environment]::SetEnvironmentVariable("NODE_TLS_REJECT_UNAUTHORIZED", "0","User")
npm config set strict-ssl false
git config --global http.sslVerify false
pip config set install.trusted-host "files.pythonhosted.org pypi.org"

git config --global diff.tool winmerge
git config --global difftoo.prompt false
git config --global difftool.winmerge.path "$HOME\KiloathApp\winmerge\WinMergeU.exe"
git config --global gui.encoding utf-8
git config --global merge.tool winmerge
git config --global mergetool.winmerge.prompt false
git config --global mergetool.keepBackup false
git config --global mergetool.winmerge trustExitCode false
git config --global mergetool.winmerge.cmd "`"$HOME\KiloathApp\winmerge\WinMergeU.exe`" //ub //fr //wl //wm //ar //dl `"基底`" //dm MERGE_HEAD //dr HEAD `"`$BASE`" `"`$REMOTE`" `"`$LOCAL`" //o `"`$MERGED`""