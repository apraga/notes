---
title: GPG
---

# Erreurs 

"gpg fails to write commit object"

```sh
GIT_TRACE=1 EDITOR="nvim" git commit -sS

22:39:12.392297 git.c:460               trace: built-in: git commit -sS
hint: Waiting for your editor to close the file... 22:39:12.448510 run-command.c:655       trace: run_command: GIT_INDEX_FILE=.git/index nvim /home/alex/code/guru/.git/COMMIT_EDITMSG
22:39:14.234635 run-command.c:655       trace: run_command: gpg --status-fd=2 -bsau 130315A4D85A4D58
error: gpg failed to sign the data
fatal: failed to write commit object
```

Solution: export GPG_TTY~=\$(tty)