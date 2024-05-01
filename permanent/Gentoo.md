---
title: Gentoo
date: 2024-04-28
tags: gentoo
---

Développer des ebuilds : [Gentoo packaging](Gentoo%20packaging.md)

# Astuces
## Wiki
[Créer une page sur son espace personnal](https://wiki.gentoo.org/index.php?title=User:Alexdarcy/Buku)
puis "move" pour la publier

## Police
Inspiration:  http://kev009.com/wp/2009/12/getting-beautiful-fonts-in-gentoo-linux/
J'ai juste utilisé eselect fontconfig + la configuration recommandée

## Portage avec git

 /etc/portage/repos.conf/gentoo.conf 
[DEFAULT]
main-repo = gentoo

[gentoo]
location = /var/db/repos/gentoo
sync-type = git
sync-uri = https://github.com/gentoo-mirror/gentoo
auto-sync = yes
sync-depth = 1

