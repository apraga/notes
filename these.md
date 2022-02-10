## Données
- [X] Labkey
- [ ] Excel Pierre
- [ ] DxCare Dijon
### Scripts
#### Vérifier que tous les PED ont bien éte exportés 
Attention à la regexp, le format est XXXX.Y ou XXX..Y

    awk -F, '{print $1}' mosaique.csv | sort | uniq > mosaique.sorted
    rg -Io "PED\d+\.\.?\d+" MUSTARD2/*.tsv | sort | uniq > tocompare.sorted
    
Tous les patients sont là avec 9  en plus

On compte le nombre de dossiers manquants (97) :

    find MUSTARD2/  -maxdepth 1 -type d | cut -d '/' -f 2 | sort | uniq > folders.sorted
    awk -F, '{print }' mosaique.csv | cut -d'.' -f 1 | sort | uniq > mosaique_nosuffix.sorted
    comm -3 mosaique_nosuffix.sorted folders.sorted | wc -l
