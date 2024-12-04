# Git-annex ?

On peut utiliser google drive & co comme des remotes.
**Mais** on ne peut pas préserver le layout donc on a un ensembe de fichiers nommés SHA-***
Inutile sans git-annex. Et si on perd le dépôt git, on perd l'architecture..
NB: infomaniak est compattble mais seulement dans la version payante... On ne peut donc pas utiliser git-annex. 

# Solution retenue :


1. git annex sur seedhost. Fichiers binaires :
 wget https://dl.kyleam.com/git-annex/git-annex-10.20241202-linux-amd64.tar.gz- rclone sync pour mega
Et les rajouter dans le PATH
On a tout dessus. 
2. mega et google drive comme "special remote" pour sauvegarde (mais perte des noms de fichier et de l'architecture)
```
git annex initremote mega type=external externaltype=rclone-builtin encryption=none rcloneremotename=mega rcloneprefix=git-annex-content rclonelayout=nodir3. 
```
3.  exporttree dans un dossier local synchronisé avec Infomaniakà la mail par le client infomaniak

```bash
git annex initremote myremote type=directory directory=/mnt/myremote \
    exporttree=yes encryption=none
git annex export master --to myremote
```
4. Les dépôts git sont super importants : sur github, sourcehut et codeberg
