# Elements of statistical learning 

# Introduction

exemple problème supervisé

* Spam : certains mots sont plus fréquents dans les mails classifiés spam
* PSA en fonction du poids de la prostate, Gleason etc : scatterplot mais non évident (données 1989)

* Reconnaissances chiffres sur image 16x16 bits normalisés

DNA microarray : pour une liste de gènes, on regarde la quantité d'ARN qui s'hybride par rapport à un échantillon vs une référence (par fluorescence, l'un est rouge l'autre vert). Avec plusieurs échantillons, on a donc une matrice. Quels gènes sont prédictifs -> aprentissage non supervisé

2. ## Overview of supervised learning

K-nearest neighbors  : pas d'hypothèse sur la distribution ("low bias") mais variabilité importante ("high variance").  
Moindres carrés : suppose que ce soit adapté ("high bias") mais stable ("low variance")
