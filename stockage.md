```{=org}
#+filetags: pc
```
Raspberry:

-   disque dur externe en ZFS monté sur /media
    -   torrents : books, music
    -   nzbget data dans nzbget, movies
    -   git-annex data dans data.git (besoin de cloner)

Fixe

-   1 disque FreeBSD en ZFS (zroot) dupliqué sur 2 disques
-   1 disque pour la musique en ZFS (data)
-   1 disque Gentoo

Git-annex

-   dépôt central sur le raspberry
-   2 remotes : disque Gentoo and disque FreeBSD