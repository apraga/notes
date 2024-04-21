# Comparaison avec cento

On utilise `code/reanalysis/compare-cento.jl` qui extrait les varians (non négatifs) de `~/annex/data/centogene/variants/variants_centogene_final.csv` et les cherche dans les TSV correspnodant à la sortie du pipeline dans `~/annex/data/bisonex/annotate/full/`
```nu
cd code/reanalysis
julia --project=.. compare-to-cento.jl  | str join | save compare-to-cento.txt -f
```
153 négatifs
```nu
rg "not in list" compare-to-cento.txt | rg "^6" | wc -l
```
94 retrouvés
```nu
rg -v "not in list" compare-to-cento.txt | rg Found | wc -l
```

Types de variants : 7 del, 4 dup,  1 ins et reste SNV
❯ rg found compare-to-cento.txt -i | rg "del" | wc -l
❯ rg found compare-to-cento.txt -i | rg "dup" | wc -l
❯ rg found compare-to-cento.txt -i | rg "ins" | wc -l

4 échecs
```nu
❯ rg -v "not in list" compare-to-cento.txt | rg FAILED
FAILED to find chr17:g.7884996C>T CHD3
FAILED to find chr10:g.102230760del PITX3
FAILED to find chr15:g.26869324A>T  GABRA5
FAILED to find chr11:g.14358800C>A RRAS2
```

"Au total, 4 variants non retrouvés sur 121 positifs, tous VOUS"
NB: Mail 1: erreur :   NM_001372044.2:c.3727dup est bien retrouvé alors que dit initialement que non.


- CHD3 : "une horreur à désigner"
- PITX3 : "riche en GC avec un homopolymère de 7G au niveau de la del" 
- GABRA5 : "pas particulièremnt difficile"

Pourquoi sont-ils filtrés ? Notre seuil : 30 reads et 10 porteurs
- CHD3: pas assez de reads (22)  : `GT:AD:DP:GQ:PL  0/1:5,22:27:43:507,0,43`
- PITX3 : pas assez de reads avec la variation (8) : attention à la représentation car homopolymère, il est en fait en  102230753 `GT:AD:DP:GQ:PL  0/1:26,8:34:99:146,0,671`
- GABRA5 : pas assez de reads (15) et pas assez avec variation (6)  `GT:AD:DP:GQ:PL  0/1:9,6:15:99:103,0,213`
- RRAS2: pas assez de reads mais un seuil à 29 suffirait ! ` GT:AD:DP:GQ:PL  0/1:15,14:29:99:310,0,331`


## Profondeur

On extrait les positions et ID avec ~/research/code/bisonex/reanalysis/depth.nu
Les positions au format bed sont convertie en hg19 avec liftover.
Puis on requête les VCF pour avoir la profondeur et les reads porteur avec
` bcftools query -f '%CHROM %POS %REF %ALT %DP [ %AD ]\n' XXX.fboth.pass.vcf.gz chr17:7788314-7788314`

CHROM POS REF ALT DEPTH AD
chr10 103990510 CG C 45  24,8
chr17 7788314 C T 29  5,21
chr15 27114471 A T 78  34,42
chr11 14380346 C A 29  15,14

## Au final

- GABRA5 était du à un FASTQ incomplet : on le retrouve bien en sortie.
- Les 3 autres variants devraient pouvoir être rattrapés en diminuant un peu les filtres
