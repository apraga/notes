---
title: Backup
tags: backup
---

# Nouvelle version : git-annex sur plusieurs dépôts + restic sur le cloud

Inconvénients de git-annex:

-   très très lent pour de multiples fichiers sur google drive/mega (\>
    6h pour copier la moitié de public)
-   archive mais ne fait pas de vraies sauvegardes
-   on ne peut pas accéder directement au fichier depuis le cloud (a
    minima, il faut le lien, qui pourrait être sur un dépôt git)
-   encryption=hybrid ne marche pas

Avantages

-   une seule interface pour tout gérer
-   permet de récupérer un seul fichier
-   un seul dépôt rend plus compliqué la gestion des différents
    emplacements de stockage (donées sensible)
-   un seul dépôt ne permet pas la sauvegarde des dossiers (restic ne
    suit pas les symlink !)
-   on pourrait sauvegarder le dépot avec restic par exemple (les
    symlink sont dans le dossier .git)

Conclusion

-   git-annex pour les disque durs locaux
-   sauvegarde avec restic sur google drive/mega
-   Attention, pour que restic prennent les symlink dans la sauvegarde,
    on fait plusieurs dépoots

  --------- -------- ----------- ----------------- ------------------------ ------------ ------
  Repo      Taille   Archivage                                              Sauvegarde   
            (Gb)     /annex      laptop:\~/annex   raspberry:/media/annex   drive        Mega
  papers             oui         oui               oui                                   
  public    8        oui         oui               oui                      oui          oui
  private   0.8      oui         oui               oui                      oui          oui
  data               oui         oui               oui                                   
                                                                                         
  --------- -------- ----------- ----------------- ------------------------ ------------ ------

NB: hubic n\'existe plus.

## Restic vs borg 

[Comparaison](https://www.reddit.com/r/BorgBackup/comments/v3bwfg/why_should_i_switch_from_restic_to_borg/)
Pas un audito mais le [créateur de la librairie crypto a regardé rapidement](https://words.filippo.io/restic-cryptography/)

Notes :

- restic supporte facilement les remote rclone !
- borg utilise plus de place 
- borg est plus mature

## Maintenance

Dans chaque dossier

``` nu
rsync -avz raspberry:Downloads/torrents private/

cd public ; git annex sync --content ; cd ..
cd private ; git annex sync --content ; cd ..
cd data ; git annex sync --content ; cd ..

$env.RESTIC_PASSWORD = (pass show Backup/restic-private)
restic -r rclone:gdrive:restic-private backup private
restic -r rclone:mega:restic-private backup private

$env.RESTIC_PASSWORD = (pass show Backup/restic-public)
restic -r rclone:gdrive:restic-public backup public
restic -r rclone:mega:restic-public backup public
```

## Configuration

### Papers

```sh
cd papers
git init
git annex init
git annex add
git annex initremote github-lfs type=git-lfs url=git@github.com:apraga/papers.git encryption=none
git lfs track "*.pdf"
git annex sync --content
```

Note: les articles sont sur sourcehut aussi mais sans lfs.

### Configuration des remote avec rclone (public + private)

Installer
<https://github.com/git-annex-remote-rclone/git-annex-remote-rclone>
(copier exécutable dans \$PATH)

```sh
cd public
git init
git annex init
git annex add
```

Suivre les indications pour ajouter un remote nommé mega de type Mega
(29)

```sh
rclone config
rclone lsd mega:
```

Créer un remote megaremote qui pointe vers le remote mega dans rclone.
Pas d\'encryption:

```sh
git annex initremote megaremote type=external externaltype=rclone target=mega prefix=annex-public chunk=50MiB encryption=none rclone_layout=lower
```

Pour googledrive, il faut un client id et un client secret selon les
consignes ici : <https://rclone.org/drive/#making-your-own-client-id>.
On encrypte mais avec la clé dans le dépôt git donc ne pas mettre les
dépôts n\'importe où !

```sh
git annex initremote gdriveremote type=external externaltype=rclone target=gdrive prefix=annex-private chunk=50MiB encryption=shared rclone_layout=lower
```

### Archivage local

Pour /annex (ZFS pool)

```sh
cd /annex
doas git clone ~/annex/private
doas git clone ~/annex/public
doas git clone ~/annex/data
doas git clone ~/annex/papers
doas chown -R alex private public/ papers/ data

cd private; git annex init
cd data ; git annex init ; cd ...
cd papers ; git annex init
```

Puis on ajoute les remote dans \~/annex

```sh
cd ~/annex
git remote add zfs /annex/private
cd data ; git remote add zfs /annex/data; cd ..
cd private ; git remote add zfs /annex/private; cd ..
cd public ; git remote add zfs /annex/public; cd ..
cd papers ; git remote add zfs /annex/papers; cd ..
```

On synchronize avec

    cd private
    git annex sync --content

Ne pas oublier de le faire dans l\'autre sens !

```sh
cd /annex/public
git annex add remote ~/annex/public
git annex sync --content
```

Idem pour private, data

### Sauvegarde restic sur google drive et mega

Cf configuration rclone puis

``` nu
cd ~/annex
$env.RESTIC_PASSWORD = (pass show Backup/restic-private)
restic -r rclone:gdrive:restic-private init
restic -r rclone:mega:restic-private init
restic -r rclone:gdrive:restic-private backup private
restic -r rclone:mega:restic-private backup private

$env.RESTIC_PASSWORD = (pass show Backup/restic-public)
restic -r rclone:gdrive:restic-public init
restic -r rclone:mega:restic-public init
restic -r rclone:gdrive:restic-public backup public
restic -r rclone:mega:restic-public backup public
```

# Ancienne version

-   google -\> to google drive (clear)
-   hubic -\> to Hubic and Mega(clear)
-   local config files -\> google and hubic (encrypted)
-   raspberry config files -\> google and hubic (encrypted)
-   local rtorrent -\> google and hubic (encrypted)
-   raspberry rtorrent -\> google and hubic (encrypted)

``` fish
#!/usr/local/bin/fish
# 3 steps procedure :
#   1. Backup from the pi using rsync
#   2. Encrypt cofig files (rasperry + local) using duplicity
#   2. Backup to the cloud using rsync
#
# Backup data either in clear or encrypted
# - google -> to google drive (clear)
# - hubic -> to Hubic and Mega(clear)
# - local config files -> google and hubic (encrypted)
# - raspberry config files -> google and hubic (encrypted)
# - local rtorrent -> google and hubic (encrypted)
# - raspberry rtorrent -> google and hubic (encrypted)
set root "/home/alex/backups"

# Duplicity needs a passphrase. Use pass "backup/duplicity"
set -x PASSPHRASE (cat /home/alex/.pass.txt)

# #------- Raspberry: backup -----
# Save books
# rclone sync pi:/media/books/ /media/books/
cd /home/alex/annex ; git annex sync

# Save torrents and config files(encrypted)
# Warning : --include implyies everything is excluded so we need /** at the end
# Don't forget the / in the folder too..
set tmp ~/backups/raspberry-tmp/
rclone sync --include "/home/alex/Downloads/torrents/**" \
    --include "/home/alex/Downloads/session/**" \
    --include "/usr/local/etc/**"  \
    --include "/etc/**"  \
    --include "/boot/loader.conf"  pi:/ $tmp
# Encrypt it
duplicity --allow-source-mismatch $tmp file:///home/alex/backups/raspberry

#------- Local backup (encrypted) ----------------
# 1. Create encrypted local version
#
# This requires setenv PASSPHRASE in doas.conf !!
# Due to permission, we need separate folder for doas command
doas duplicity --allow-source-mismatch --include /usr/local/etc/ --include /etc/ \
    --include /boot/loader.conf --exclude '**' \
    / file:///home/alex/backups/desktop/root

duplicity --allow-source-mismatch --include /home/alex/Downloads/torrents \
    --include /home/alex/Downloads/session \
    --exclude '**'  \
    /home/alex/Downloads file:///home/alex/backups/desktop/rtorrent

#------------ Backup all encnrypted and non encrypted
Puis on ajoute les remote dans ~/annex
#+begin_src sh
cd ~/annex
git remote add zfs /annex/private
cd data ; git remote add zfs /annex/data; cd ..
cd private ; git remote add zfs /annex/private; cd ..
cd public ; git remote add zfs /annex/public; cd ..
cd papers ; git remote add zfs /annex/papers; cd ..
```

#--- All

rclone -L sync --exclude \'Coopétition/\' --drive-import-formats .xlsx
\$root/google/ google: rclone -L sync \$root/google
backblaze:unixStorage rclone -L sync \$root/hubic hubic: rclone -L sync
\$root/hubic mega: On synchronize avec

    cd private
    git annex sync zfs --content

#--- Passphrase /usr/local/bin/pass git push Idem pour raspberry

Ne pas oubiler de le faire dans l\'autre sens !

```sh
cd /annex/public
git annex add remote ~/annex/public
git annex sync --content
```
