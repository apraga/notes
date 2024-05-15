#typography

Alternative à latex en beta début 2024 mais avec un client en ligne fonctionnel. Attention, pas plus de 100 fichiers dans la version gratuite.
Pas encore de version payant en mars 2024

# Astuces
Découper un document en plusieurs fichier 
```typst
#include "lol.typ"
```
Par contre, ce n'est pas du preprocessing. Donc si on veut définir des variables, il faut les mettre dans un fichier template.typ and faire 
```typst
#import "template.typ": *
```
Définir un style global 
```typst
#set figure(kind: table)
```
Pour les packages, il faut pra contre définir des fonctions
```typst
#let cooltable = tablex.with(stroke: red)
```

# Librairies

- Cetz: alternative à tikz
- fletcher : utilisé pendant la thèse pour des flowchart. Assez pratique
