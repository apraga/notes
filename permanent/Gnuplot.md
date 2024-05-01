#plot

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
