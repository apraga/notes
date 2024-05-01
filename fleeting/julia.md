```{=org}
#+filetags: personal julia
```
# Tester un paquet localement

    $ julia
    julia> ]
    (@v1.9) pkg> develop /home/alex/code/XAMScissors.jl

Puis il suffit d\'utiliser le paquet. En cas de changement, la
precompilation sera refait à chaque fois

    julia> using XAMScissors

# DataFramesMeta {#dataframesmeta id="48ee3cbb-8129-490c-a91a-a317d7ff44c3"}

Supprimer une liste de colonnes

``` julia
@select d $(Not([:"Stade d'avancement analyse", :"Mnémo analyse", :"Unité", :"Anomalie"]))
```

Filtrer selon des valeurs dans une liste

``` julia
@subset d (in.(:"Code analyse", Ref(["GMQKIT", "GMQDAT", "GMQDOS", "GMQRAT"]))
```

Négation

``` julia
@subset d .!(in.(:"Code analyse", Ref(["GMQKIT", "GMQDAT", "GMQDOS", "GMQRAT"])))
```
