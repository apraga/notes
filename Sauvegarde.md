
Stratégie

-   git-annex pour les disque durs locaux (voir [Discussion sur git-annex](Git-annex.md) )
-   sauvegarde avec restic sur google drive/mega (voir [restic vs borg](Restic vs Borg))
-   Attention, pour que restic prennent les symlink dans la sauvegarde, on fait plusieurs dépoots

  --------- -------- ----------- ----------------- ------------------------ ------------ ------
  Repo      Taille   Archivage                                              Sauvegarde   
            (Gb)     /annex      laptop:\~/annex   raspberry:/media/annex   drive        Mega
  papers             oui         oui               oui                                   
  public    8        oui         oui               oui                      oui          oui
  private   0.8      oui         oui               oui                      oui          oui
  data               oui         oui               oui                                   
                                                                                         
  --------- -------- ----------- ----------------- ------------------------ ------------ ------

NB: hubic n\'existe plus.



## Maintenance

Dans chaque dossier

```nu
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

## Mots de passe
Stratégie : une partie est gérée par Pass mais on utilise maintenant proton

# Configuration
## Gentoo
Un dépôt git pour /etc/portage

## Freebsd
Voir [[Configuration freebsd]]