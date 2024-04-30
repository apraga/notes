---
title: Gestion bibliographie
date: 2024-04-28
tags: bibliographie
---

On a initialement utilisé [emacs avec citar](202404282230%20-%20Bibliographie%20avec%20emacs.md). 
Avec le changement à helix, on utilise [papis](202404282236%20-%20Bibliographie%20avec%20papis.md)

# Synchronisation des pdfs

On utilise git-annex. Il faut

-   git-annex
-   git-lfs
-   git-lfs
-   rclone

## Configuration

### Google drive

-   Create a rclone google drive remote
-   Copy the executable git-annex-remote-rclone here into \$PATH
<https://github.com/DanielDent/git-annex-remote-rclone>
-   Add a remote
```sh
git annex initremote gdrive type=external externaltype=rclone target=gdrive encryption=shared
```

### Git LFS

-   Create a git repo and set it up for git-lfs (apraga/papers) <https://git-lfs.github.com/>
-   Add a remote
```sh
git annex initremote lfstest type=git-lfs url=git@github.com:apraga/papers.git encryption=none
```
## Utilisation

```sh
git-annex init
git-annex enableremote lfs
git-annex enableremote gdrive
git-annex sync --content
```

Synchronisation: `git annex sync --content`
Copier les données depuis un remote
```sh
git annex get . --from gdrive
git annex copy . --to lfs
```


