## Formation

[Training materials](https://www.clinicalgenome.org/curation-activities/baseline-annotation/baseline-annotation-training-materials/)

### Clingen Allele Registry 
ID unique pour un variant (ex: CA34043)
- pour les curator, permet d'enregistrer les variants
- permet une conversion facilement avec d'autres versions du génome
- pour les autre, évite les alias, permet de jongler entre les types de coordonnées
- 910 million 
- source: dbSNP, exap, gnomad, myvariant.info, COSMIC, Clinvar + utilisateur
- recherche par HGVS, pmid, ID clinvar, gnomad (hg19)
- un variant a la liste vers toutes ces sources

Si variant non présent, facile de l'ajouter. Il y a des outils pour compléter les informations manquantes (ex: transrcript

Limites 
- pas de variants avec des breakpoints incertains
- pas variants > 10kb
- suppose que le variant est identique en génomique et sur les transcrit -> **pas les variants d'épissage**
- attention aux indel : la base de données ne gère pas les haplotypes donc 1 haplotype = 1 nouveau variant...
