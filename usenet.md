Backbone
--------

Tweaknews (30€ pour 1 an en promo black friday) =\> assez utile pour
série (Elementary) Newdemon (10€ pour 6mois en promo black friday) =\>
peu utile ?

Indexer
-------

NZBgeek (5€ pour 6 mois) =\> plutôt utile NZBplanet (10€ pour 1 an) =\>
peu utile pour le moment DrunkenSlug (version gratuite) =\> limité 10 /
jour mais complète bien Dognzb : redondant avec drunkenslug ? Cher à 20€
/mois nzb.su : ont le monde diplomatique mais

KILL Récupérer les magazines à la main
--------------------------------------

Sur a.b.e-books.magazines =\> non disponible via tweknews et newsdemon

NZBget
------

Télécharge nzb

### Linux

Voir ici pour installation :
<https://wiki.archlinux.org/index.php/NZBGet> En pratique, ça ne marche
pas avec systemd. On fait donc un home pour l\'utiliser nzbget, qui va
contenir la configuration et les fichiers. Le fichier systemd contiendra
donc

ExecStart=/usr/bin/nzbget -c /home/nzbget/nzbget.conf -D
ExecStop=/usr/bin/nzbget -c /home/nzbget/nzbget.conf -Q
ExecReload=/usr/bin/nzbget -c /home/nzbget/nzbget.conf -O

Mettre \"media\" comme group au lieu de nzbget (cf Permissions)

Le service est activé au démarrage de l\'ordinateur

### Freebsd

pkg install nzbget On copie tout le dossier /usr/local/share/nzbget vers
/usr/local/nzbget (config + website) On edit /usr/local/etc/rc.d/nzbget

``` {.shell}
command=/usr/local/bin/nzbget
command_args="-c /usr/local/nzbget/nzbget.conf"
```

Les téléchargement seront dans /usr/local/nzbget.

Important: Umask = 0002 pour avoir l\'équivalent de chmod 775 (c\'est
l\'inverse)

NZBHydra2
---------

Aggrégateur d\'indexeur

Permissions et dossiers
-----------------------

### Linux

-   Utiliser: nzbget, radarr
-   *home/nzbget* : home de nzbget
-   /home/nzbget/dist : contient les fichiers téléchargés par nzbget
-   /home/media: dossier final (anime, séries, films, manga)
-   Groupe media contenant utilisateur nzbget, radarr. Tous les membres
    peuvent accéder à /home/media Tous les membres du groupes peuvent
    accéder à /home/nzbget/dist (fichiers téléchargés)

### Freebsd

Nzbget sera lancé comme root Pour les permissions on fait un groupe
media qui contiendra sonarr. Les permissions de /usr/local/nzbget seront
en 775 avec chrgroup media deuss /media sera donc accessible à toute le
monde

Sonarr pour série
-----------------

### Linux

Fichier systemd fourni (AUR) Ajouter utilisateur sonarr au groupe media
Utiliser NZBHydra2 comme source d\'indexer

### Freebsd

rc.d fourni

Radarr pour filmes
------------------

### Linux

Fichier systemd fourni (AUR) Ajouter utilisateur radarr au groupe media
Utiliser NZBHydra2 comme source d\'indexer

Bazarr pour sous-titres
-----------------------

### Linux

Fichier systemd fourni (AUR) Ajouter utilisateur radarr au groupe media

### Freebsd

Install manuellee

Bitcoin
-------

-   Coinbase pro : frais bas (10cts par transaction). Alimentation
    possible par virement mais attention de bien mettre la référence
-   Kraken : frais trop elévés (5€ par transactions !)
