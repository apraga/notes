---
theme: default
title: Bisonex
---

# BisonEx
## Un pipeline bioinformatique de ré-interprétation d’analyses constitutionnelles d’exome 

Alexis Praga 

18 avril 2024

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
---

## 1. Contexte : errance diagnostique

Objectif : nouveaux diagnostics
- ré-intérpréter données existantes <v-click> **disponibles depuis 2022** </v-click>
- ré-analyser données brutes : <v-click> **pipeline maison** </v-click> <v-click> (v0.1 par Dr. A. Overs) </v-click>

<!--
Errance = sans diag :  soit pas de cause génétique, soit limite technologique ou scientifique
- Intéressant de regarder les données déjà ré-analysées (ex: nouveaux gènes) -> ok
- Idéal = notre propre pipeline -> déjà développé
-->

---
---

## 1. Contexte : errance diagnostique

![](/img/ngs.svg)


<!--
Décrire figure puis dire où on se place
- non utilisable par un humain (volume trop important): nécessité d'un traitement bioinformatique
- détermine différence par rapport à une référence (= variants)
- filtre (millions candidations -> 1000 candidates)
- besoin d'un biologiste (> IA not. expérience)
-->

---
---

# 2. Reproductibilité

---
---

# 2. Portabilité

---
---

# 2. Performances

---
---

# 3. Validation

---
---

# 4. Réinterprétation : non-infériorité

---
---

# 4. Réinterprétation : nouveaux diagnostics

