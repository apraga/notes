```{=org}
#+filetags: personal
```
Gnuplot, Julia avec Makie ou Vega-lite ?

# Gnuplot

Avantages

-   cross-platform
-   rapide
-   adapté au format multi-colonnes (et non au format \"stacked\" avec
    une colonne pour le type et une pour la valeur)

Inconvénient

-   moche par défaut (mais ok avec une peu de customization)
-   ne fait pas de transformation de données
-   syntaxe peu lisible
-   peu adapté aux variables par catégories (voir
    <https://stackoverflow.com/questions/77385452/scatter-plot-with-3-categorical-variables-in-gnuplot>)

# Julia

Avantages

-   avec algebraofgraphics, on a une grammaire pour les visulation + la
    puissance de calcula
-   makie est très puissant, notamment pour la disposition
-   légendes possibles avec latex

Inconvénients

-   temps pour la première figure encore long avec 1.9 (10s ?)
-   algebraofgraphics est encore expérimental avec certaines
    visualisation non disponibles (ex: histogramme horizontal : voir
    <https://github.com/MakieOrg/AlgebraOfGraphics.jl/issues/355> =
    attente modification make)
-   makie est assez bas-inveau

À utiliser avec dataframesmeta

# Vega-lite

Avantages

-   Avec l\'interface via Julia, on génère rapidement une figure (plus )
-   utile pour les site web
-   permet la modification des données
-   milieu académique d\'une équipe qui travaille sur la visualisation
    de données

Inconvénients

-   la version \"native\" n\'est pas pratique pour automatiser la
    création de graphe
-   orienté statistiques donc affichage de fonctions (ex: sinus)
    possible mais un peu moins pratique
-   impossible pour le moment d\'avoir la même légene pour des lignes et
    point : <https://github.com/vega/vega-lite/issues/3797>
-   utilise d3 donc dans le navigateur
-   par défaut, les graphes sont très petit