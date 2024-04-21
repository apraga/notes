```{=org}
#+filetags: personal haskell gentoo
```
Génerer l\'ebuild avec hackport

``` {.bash org-language="sh"}
hackport update
hackport merge diagrams-graphviz
```

Cela va générer le paquet dans dev-haskell (repo haskell) Tester
l\'installation

    emerge -1 diagrams-graphviz

Recommandations pour soumettre une pull request
<https://github.com/gentoo-haskell/gentoo-haskell/wiki/General-QA-tips>
