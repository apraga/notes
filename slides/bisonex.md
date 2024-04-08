---
theme: academic
layout: cover
coverAuthor: [Alexis Praga]
title: Bisonex
coverDate: [18 avril 2024]


---

# BisonEx
## Un pipeline bioinformatique de ré-interprétation d’analyses constitutionnelles d’exome 

CHU Minjoz, Besançon
<!--
Remercier jury + public
-->

---
---

## Plan
1. Contexte
2. Reproductibilité, portabilité et performance
3. Validation
4. Réinterprétation

---
---

## 1. Contexte

- Consultations de maladies rares (Centre de Génétique Humaine)
- _Exome_ souvent prescrit après un premier bilan
    - 1% de l'ADN
    - rendement diagnostic 32% 
    - sous-traité à un laboratoire privé accrédité

<!--
Maladise rares par opposition aux cancers
Depuis 2017, bilan "débrouillage" : ACPA/caryotype

1% = codant pour des protéines => rôle important et d'ailleur rendement diagnostic intéressant (mais dépend des malades)

-->

---
layout: image-right
image: /img/ngs.svg
backgroundSize: 90%
---

## 1. Contexte : 

Patients en errance diagnostique
- ré-intérpréter données existantes <v-click> **disponibles depuis 2022** </v-click>
- ré-analyser données brutes : <v-click> **pipeline maison** </v-click> <v-click> (v0.1 par Dr. A. Overs) </v-click>

<!--
Errance = sans diag :  soit pas de cause génétique, soit limite technologique ou scientifique
- Intéressant de regarder les données déjà ré-analysées (ex: nouveaux gènes) -> ok
- Idéal = notre propre pipeline -> déjà développé


Décrire figure puis dire où on se place
- non utilisable par un humain (volume trop important): nécessité d'un traitement bioinformatique
- détermine différence par rapport à une référence (= variants)
- filtre (millions candidations -> 1000 candidates)
- besoin d'un biologiste (> IA not. expérience)
-->


---
layout: image-right
image: /img/dependencies.svg
backgroundSize: 95%
---
## 2. Reproductibilité : Nix

Comment assurer au COFRAC des résultats reproductibles ?

<br/>
<v-click>

**Nix**

</v-click>

<v-clicks every="1">

1. bloque la version de tous les logiciels
2. quelque soit l'ordinateur (Linux +/- OSX)

</v-clicks>

<!--
- pour avoir une expérience reproductible, il faut déjà un environnement logiciel qui le soit !

1.  SH-GTA-16: version définie de tous les logiciels et une mise à jour implique une requalification
 pas de mise à jour sauvage !

2. en cas de panne, on veut retrouver exactement le même environnement

nix répond à cette problématique (exactement)
-->

---
layout: image-right
image: /img/pullrequests.svg
backgroundSize: 85%
---
## 2. Reproductibilité: Nix

Contributions de cette thèse :
- 6 logiciels importants
- 5 déjà utilisable par la communauté (nixpkgs)

<!--
packaging = incorporer ces logiciels dans nix. 
On a un outil d'annotation, 2 outils important pour comparer les résultats à des réference
un outil de score d'épissage, un outil de qualité

open-source
utilisable via un dépôt commun (nixpkgs)

à noter le délai...
-->

---
layout: image-right
image: /img/executors.png
backgroundSize: 85%
---

## 2. Portabilité : Nextflow

<v-clicks every="1">

- Maîtrise des risques liés au matériel
- Exécution sur de multiple architecture (super-calculateur...)

</v-clicks>

<!--
principe: définir chaque bloc de calcul dans un langage qui est indépendant de l'architecture.

En pratique, cela permet de répondre en partie au  SH-GTA-16 
"en cas d’incident perturbant l’exécution du pipeline ou le
transfert des fichiers ainsi que des procédures de récupération/sauvegarde des
données en cas de perte." 
-> restart automatique depuis le dernier "bloc" exécuté

Et permet de s'exécuter sur de nombreuses architectures !
-->

---
layout: image-right
image: /img/speedup.svg
backgroundSize: 85%
---

## 2. Performances

- Mésocentre de Franche-Comté
- Parallélisation de l'alignement
- 1 patient = 5h de calcul
- 20 patients/jour

<!--
Application de nextflow sur supercalculateur 

2 étapes les plus coûteuses = alignement, appel de variant
alignement = trivialement parallélisable
appel de variant = exploitation du processeur mais parallélisation non faite pour le moment

Pour donner une idée, 12h de calcul sur un portable
-->

---
---

## 3. Validation  

- Données de patients de référence : Genome In A Bottle Consortium
- *In silico*

---
---
## 3. Validation : patient NA12878

<!--
Ici séquencage + pipeline
-->

---
---
## 3. Validation : patients GIAB

<!--
Ici pipeline seul
-->


---
---
## 3. Validation : in silico

<!--
Ici pipeline seul
-->
---
---

## 4. Réinterprétation : non-infériorité

---
---

## 4. Réinterprétation : nouveaux diagnostics

