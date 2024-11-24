# bisonex
#bisonex #article 



# Articles

On sépare le travail en 2
1.[environnement reproductible autour de Sarek](#reproductible-sareknorgmd) = non spécifique à l'exome
2. [validation d'exome](#sherloxomemd) = exome seul


# Bases de données 

## Hébergement des données

Selon la licence, on pourrait toutes les hébergerau même endroit en théorie faisable mais trop de travail pour mettre à jour (clinvar notamment).
Par contre, il serait intéressant de regrouper les données de séquencage des patients de référence sur un site
Regarder si on peut uploader les données Google sur :
            -  ENA
        -  https://www.nature.com/sdata/policies/repositories
    -  https://elixir-europe.org/platforms/data/elixir-deposition-databases

## Annuaire

Plus simple à maintenir. 2 approches 
- avec un site existantles solutions ci-dessus n'ont pas tout. Regarder
-  https://www.re3data.org/
-  opencommon
-  madbot
    - sur un dépôt github selon la technologie retenue
        - scidataflowPR en attente. Le problème est que l'on ne peut pas télécharger une partie des données ni chercher par métadonnées
        - datatoolkit en juliail faut éditer un script donc pas très orienté en ligne de commande... Et les métadonnées sont un peu lourdes à écrire
        - git-annex: semble être le meilleur candidaton peut ajouter toutes les métadonnées que l'on veut et on peut utiliser de nombreux remotes. Il faut juste mettre sur le $WORK le dossier git-annex donc un peu plus de configuartion pour l'utilisateur..
          -> problèmee avec TLS2 pour clinvar, dbsnp. Non résolu https://git-annex.branchable.com/bugs/tls__58___peer_does_not_support_Extended_Main_Secret/
    - nixcomme le store n'est pas très adapté pour les données, ne semble pas pratique. Attente du retour de Bruno

