Découper un document en plusieurs fichier

    #include "lol.typ"

Par contre, ce n'est pas du preprocessing. Donc si on veut définir des variables, il faut les mettre dans un fichier template.typ and faire 

    #import "template.typ": *

Définir un style global 

    #set figure(kind: table)

Pour les packages, il faut pra contre définir des fonctions

    #let cooltable = tablex.with(stroke: red)

## Cetz
Graphe avec box
```typst    
#import "@preview/cetz:0.2.1"

#cetz.canvas(
  {
    import cetz.draw: *
    import cetz.tree
     
    set-style(content: (padding: .1))
    tree.tree(
      parent-position: "center",
      grow: 1.5,
      spread: 1.5,
      draw-node: (node, ..) => {
        rect((rel: (-.5, -.5)), (rel: (1, 1)), fill: blue)
        content((rel: (-.5,-.5)), text(white, [#node.content]))
      },
      ([A], [B], [C], ([D], [E], [F]))
    )
  },
)
```
