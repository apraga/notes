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

## Live training
Annotation sur hypothes.is :  
- HTML >> PDF ( il faut une URL *stable* pour le PDF)
- De préférence : open access, accessble gratuitement (penser à pubmed)
Certains protocoles imposent des articles, pour d'autres, on doit trouver des articles 

Objectif : seulement pour maladies monogéniques

### Recherche
Recommandé : pubmed + gène
Astuce: "variant" ou "case"

NB: Pubmed, mastermind, litvar
- pubmed Chercher par gène + variant (protéine ou codant) ne fonctionne pas bien sur pubme
ex: GAA AND ("c.XXXdel")
- litvar marche un peu mieux pour codant mais pas top..


### Astuce pour annotation
On peut commenter des annotations (not. par les reviewers)
NB: les reviewers ne peuvent pas changer les annotation

### En pratique
On reçoit 2 protocoles: article info ou case-individual
NB: il y a des protocoles pour 1 seul gène, d'autres sont multi-gènes
Choix du protocol : on fait une liste de vœux pour les différens groupes

Annotation tags: certains sont obligatoires. Attention : camelcase

Il faut suivre le plus possible les inforamtions données par les auteurs de l'article
Surligner la partice qui fait référence au cas
Si dans supplementary, il y a u tag adapté. Donner le tableau/figure

Utiliser ID HPO, clinvar etc autant que possible
Pour les ID des variants : clingen *ou* clinvar. Syntax: ClinVarId:12222
**Si impossible, tag "unregistered variant"** (ex: author discrepency)
**S'il n'y a pas de variants**, tag "noevidence" ou "insufficientevidence" (si ce n'est pas un patient)

Si plusieurs variants dans plusieurs gènes: Section 'multiplegenevariants'
Mais les tags sont seulement pour le gène assigné

Posting : seulement au **bon** groupe et pas de manière publique. Format: markdown
Posting = sauvegarde

Comment savoir si quelqu'un est déjà en train d'annoter ? Le plugin hypothes.is montre les annotations sur cette URL -> si c'est dans notre groupe, on voit les annotations. Sinon, c'est dans un groupe 

Si un patient a déjà été rapporté dans une autre publi:  “previously published” or “additional information”


Objectif de la baseline annotation : annoter les variants d'un article avec ID clinvar pour le retrouver plus facilement
TODO: ajouter username hypothes.is sur ccdb.clinicalgenome.org -> ok
Hypothes.is : plutôt chrome
TODO: pour avoir un "protocol", il faut valider le training dans CCDB. On reçoit un mail -> attente

1 article / mois pour rester sur 
https://clinicalgenome.org/working-groups/clingen-community-curation-c3/baseline-annotators/

Contact : volunteer@clinicalgenome.org

