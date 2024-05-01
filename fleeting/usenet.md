```{=org}
#+filetags: cs
```
# Backbone

weaknews (30€ pour 1 an en promo black friday) =\> assez utile pour érie
(Elementary) Newdemon (10€ pour 6mois en promo black friday) =\> eu
utile ?

# Indexer

ZBgeek (5€ pour 6 mois) =\> plutôt utile NZBplanet (10€ pour 1 an) =\>
eu utile pour le moment DrunkenSlug (version gratuite) =\> limité 10 /
our mais complète bien Dognzb : redondant avec drunkenslug ? Cher à 20€
mois nzb.su : ont le monde diplomatique mais

# KILL Récupérer les magazines à la main

ur a.b.e-books.magazines =\> non disponible via tweknews et newsdemon

# NZBget

élécharge nzb

## Linux

oir ici pour installation :
\[<https://wiki.archlinux.org/index.php/NZBGet>\]\] En pratique, ça ne
arche pas avec systemd. On fait donc un home pour l\'utiliser nzbget, ui
va contenir la configuration et les fichiers. Le fichier systemd
ontiendra donc

xecStart=/usr/bin/nzbget -c /home/nzbget/nzbget.conf -D
xecStop=/usr/bin/nzbget -c /home/nzbget/nzbget.conf -Q
xecReload=/usr/bin/nzbget -c /home/nzbget/nzbget.conf -O

ettre \"media\" comme group au lieu de nzbget (cf Permissions)

e service est activé au démarrage de l\'ordinateur

## Freebsd

kg install nzbget On copie tout le dossier /usr/local/share/nzbget vers
usr/local/nzbget (config + website) On edit /usr/local/etc/rc.d/nzbget

+BEGIN~EXAMPLE~ command=/usr/local/bin/nzbget command~args~=\"-c
/usr/local/nzbget/nzbget.conf\" +END~EXAMPLE~

es téléchargement seront dans /usr/local/nzbget.

mportant: Umask = 0002 pour avoir l\'équivalent de chmod 775 (c\'est
\'inverse)

# NZBHydra2

ggrégateur d\'indexeur

# Permissions et dossiers

## Linux

Utiliser: nzbget, radarr *home/nzbget* : home de nzbget
/home/nzbget/dist : contient les fichiers téléchargés par nzbget
/home/media: dossier final (anime, séries, films, manga) Groupe media
contenant utilisateur nzbget, radarr. Tous les membres peuvent accéder à
/home/media Tous les membres du groupes peuvent accéder à
/home/nzbget/dist (fichiers téléchargés)

## Freebsd

zbget sera lancé comme root Pour les permissions on fait un groupe edia
qui contiendra sonarr. Les permissions de /usr/local/nzbget seront n 775
avec chrgroup media deuss /media sera donc accessible à toute le onde

# Sonarr pour série

## Linux

ichier systemd fourni (AUR) Ajouter utilisateur sonarr au groupe media
tiliser NZBHydra2 comme source d\'indexer

## Freebsd

c.d fourni

# Radarr pour filmes

## Linux

ichier systemd fourni (AUR) Ajouter utilisateur radarr au groupe media
tiliser NZBHydra2 comme source d\'indexer

# Bazarr pour sous-titres

## Linux

ichier systemd fourni (AUR) Ajouter utilisateur radarr au groupe media

## Freebsd

nstall manuellee

# Bitcoin

Coinbase pro : frais bas (10cts par transaction). Alimentation possible
par virement mais attention de bien mettre la référence Kraken : frais
trop elévés (5€ par transactions !)
