# Git-annex ?

On peut utiliser google drive & co comme des remotes.
**Mais** on ne peut pas préserver le layout donc on a un ensembe de fichiers nommés SHA-***
Inutile sans git-annex. Et si on perd le dépôt git, on perd l'architecture..
NB: infomaniak est compattble mais seulement dans la version payante... On ne peut donc pas utiliser git-annex. 

# Solution retenue :


- git annex sur seedhost. Fichiers binaires :
 wget https://dl.kyleam.com/git-annex/git-annex-10.20241202-linux-amd64.tar.gz- rclone sync pour mega
Et les rajouter dans le PATH
- mega pour sauvegarde sans pouvoir facilement lire les fichiesr
- exporttree dans un dossier local synchronisé à la mail par le client infomaniak
