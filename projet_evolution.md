```{=org}
#+filetags: personal
```
À faire : SDL:

-   Lire une carte de hauteur et générer le terrain
-   Représenter les herbivores avec des sprites
-   vue isométrique
-   génération de terrain procédurale

Main:

-   Faire une liste d'herbivores

1.  Algorithme génétique très simple (OK)

Converger vers une string donnée à partir d'une string random. Une seule
mutation à chaque étape et on prend le pire charactère pour en générer
un autre aléatoire. Si la nouvelle string est meilleure, on la garde.
Convergence en \~2000 itérations

1.  Notes

Représenter les animaux. Idéalement, un squelette rassemble
l'information importante. Mais comment choisir le nombre de membres et
d'articulations ? Fonction de fitness Doit-elle être définie a priori ?
Peut-on utiliser ce que l'animal apprend au cours de sa vie ? En tout
cas, il faudra pouvoir supprimer des animaux qui n'arrivent pas à se
nourrir. Pour les herbivores, cela dépend clairement de son squelette.
Comment quantifier le rapport entre le squelette et la sphère
atteignable par l'animal ? Des liaisons pivots pourraient définir ces
sphères. Mais cela suppose que l'animal peut attraper (comment
quantifier ça ?) ou bien manquer directement avec le membre. Dans un
premier temps, on peut supper que c'est une sorte de grosse bactérie qui
absorbe l'herbe par la peau. Environnement Au début, on va avoir une
carte de hauteur d'herbe. On peut utiliser 3 hauteurs au début : désert,
praire et forêt, en supposant que la forêt est comestible.

Sélection On peut soit enlever tous les animaux dont la fonction de
fitness est inférieure à un seuil (risque d'extinction), soit enlèver
les n pires. Idéalement, il faudrait avoir les deux. On ne veut pas
d'extinction (à creuser?).

Reproduction Comment choisir le couple qui va se reproduire ? Une
approche réaliste consisterait à choisir l'animal célibataire le plus
proche. On suppose qu'ils sont asexués et qu'ils peuvent parcourir toute
la carte.