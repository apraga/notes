# sherloxome
#bisonex #article 



# Specs


ScopePLOs computational biology 
Principevalidation de pipeline d'exome constit avec données 
- de patients de référence 
 données "de synthèses
  On propose un "wrapper" qui
- installe les dépendances
- télécharge les données
- génères des fastq
- calcule les performances
  sontraintesconfigurable, facile à utiliser, parallélisable sur cluster HPC
  Apport: pas de solution "tout en un" pour exome constit.

## Patients de référence

- GIAB
    - données de références
        - SNV sur 8 patients de références
        - régions difficiles
        - X et Y pour SNV HG002
    - données brutesbaid2020: tous les patients avec plusieurs séquenceurs et kits
- Dipcall (si données brutes exome disponible)

## Insertion de variants connus 

Variants
- soit "maison" définis dans un VCF
- soit sélection de clinvar
  Programmes
- varben
- bamsurgeons

## Données de synthèses

Même variants qu'au-dessus
  s Simuscope pour génération
- neat)


# Choix de technologie

Il faut pouvoir 
A. télécharge les données de manière reproductible
B. être facile à installer
C. être facile à utiliser 
D. pouvoir configurer les différenes stratégies (quel patients, quel algo) 
E. lancer plusieurs programmes en lignes de commands sur un cluster
F. figure avec les résutats
G. visibilité
H. maintenable

Choix possibles
1. rust: 
    1. scidataflow
    2. facile
    3. facile
    4. facile
    5. est faisable avec des scripts (bof) ou (hyperqueueok si fonctionne bien sur mésocentre
    1. vega_lite_4 fonctionne de pouvoir être affiché localement (sinon il faut héberger le CSV) et est interactif. Plotly est une option (non testés
    2. le point faible
    3. le point faible
1. julia
    1. datatoolkit.jl est trop lourd en pratique et je préfère l'approche de scidataflow. Datadeps.jl est une alternativs
    2. oui
    3. la CLI n'est pas le point fort de julia..
    4. oui
    5. oui
    6. oui
    7. petite communauté
    8. moyes
2. Nextflow
    1. bof
    2. oui mais un peu lourd avec nf-core
    3. oui mais moins qu'un cli
    4. oui
    5. oui
    6. oui mais pas de HTML avec makie
    7. oui
3. Python seul
    1. bof
    2. bof
    3. oui
    4. oui
    5. oui mais avec hyperqueue
    6. oui, plotly
    7. oui
    8. ous

Solution retenue: rust si hyperqueue fonctionne sur mésocentre

# Rssultats

Sarek avec plusieurs aligneurs ete appel de variants
Essayer de reproduire les résulats
