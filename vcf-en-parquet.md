# Conversion

Parquet est super rapide à requêter mais la conversion depuis un VCF n'est pas facile...
- polars"Quick and dirty": on sélectionne certains champs dans SAMPLES et on met dans une dataframe polars.
  Inconvénientil faut connaître le schéma à l'avance...
- Les méthodes les plus souples nécessitent Sparkvoir Glow (parquet) ou Hail (format maison) ou https://github.com/BigDataWUR/tomatula
- Noodlespas très adapté ... https://github.com/zaeleus/noodles/issues/173
- Oxbow ne coupe pas les colonnes

Le plus simple: un paquet python qui permet d'avoir une dataframe polars
https://github.com/abdenlab/VCFormer/tree/main/src/vcformer fait ça pour nous !
On pourrait recoder ça en rust avec noodles mais l'interface n'est pas facile...


# Performances

Très convaincu initialement mais c'est parce qu'on supprime le champ "INFO"... 
Sinon, pas plus léger qu'un vcf compressé
