## Outils
- Texte -> HPO : clinphen http://bejerano.stanford.edu/clinphen/
- Phenotype (HPO) -> liste de gènes:  AMELIE https://amelie.stanford.edu/ 
- Texte OU PHO -> gènes : phen2gene https://phen2gene.wglab.org/

## Data mining
Modèles tensorflow pour Named Entity Recognition : https://github.com/guillaumegenthial/tf_ner
(date de 3 ans, f1 = 91 donc efficace)

# Algorithmes
## Similarité entre 2 phénoptypes :
Un patent est défini par un ensemble de concepts. On le représente par un vecteur dans l'espace de ces concepts
Les coordonées sont données par le TF-IDF pour un concept
avec TF = fréquence du concept pour ce patient = nb d'occurence dans le corpus pour ce patients / nb de concepts
IDF = fréquence inverse du document = nb de patient / nb de patients avec ce concept

La distance entre 2 patients est le cosinus entre les vecteur (produit scalaire / produit des normes)
