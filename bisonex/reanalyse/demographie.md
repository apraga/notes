# Démographie

## Clinique

### Extraction
Extraction de la clinique au format HPO depuis les compte-rendus extraits en texte
```checkpipeline -i data -o clinical.csv```

### Nettoyage
1. Nettoyage à la main en découpant les lignes avec des virgules (+ divers)
2. Regarder les données pour corriger les erreurs avec espaces etc :
`open clinical.csv | get Clinical | str downcase | uniq -c  | sort-by count`
3. On utilise un script Rust pour comparer les termes à la base de données HPO. Il faut télécharger localement la base et il faut la clinique dans ../data/clinical_nodup.csv.
Pour la base HPO, on va dans ~/code/hpo et il faut avoir téléchargé

data/
├── hp.obo
├── phenotype.hpoa
└── phenotype_to_genes.txt

```bash
cargo run --release  --example obo_to_bin data ontology.hpo
cp ontology.hpo ~/research/bisonex/code/hpo
cd /research/bisonex/code/hpo
cabal run --release cleanup
```
Le fichier de sortie est `clinical_corrected.csv` avec une nouvelle colonne correspondant à l'annotation corrigée (`Clinical_corr`).

On regarde ensuite manuellement les termes qui n'ont pas été retrouvés
```nu
open clinical_corrected.csv | where ($it.Clinical_corr | is-empty) | get Clinical | sort | uniq
```

### Catégories 
À partir de ../data/clinical_corrected.csv, on va regarder les parents dans la nomenclature HPO qui sont à une distance de 3 de la racine et le résultat est généré dans clinical_main.csv

```bash
cargo run --release --bin clinical_main
```
Puis on regarde les termes les plus courants et les catégories

```nu
open clinical_corrected.csv | get Clinical_corr | uniq -c | sort-by count | to csv
open clinical_main.csv | select major_parent len | sort-by len | to csv

```

### Graphe

Génération d'un fichier pour graphviz  (test.dot) partir de clinical_main.csv
```bash
cargo run --release --bin graph
dot -Tsvg test.dot | save test.svg -f
```

### Divers
NB: les dates ont été trouvées avec 
`rg "Report date: .*" data/* -o -I | lines | each {|e| $e | str replace "Report date: " "" } | save dates.txt`
et en regardant à la main des dates extrémales

Attention, certains patients sont en double:
```julia
using DataFramesMeta, CSV
d = CSV.read("clinical.csv", DataFrame)
d2 = @by d :Patient :ER :mysum = length(:ER)
ids = : ids = findall(nonunique(@select d2 :Patient))
d2[ids, :]

# 52 Duplicate patients
nrow(unique(d2[ids, :]))
# 911 patients
nrow(unique(@select d :Patient))
``` 

Si on veut supprimer les doublons, on les a directement. Mais on supprime l'un des doublons au hasard...
```julia
CSV.write("todelete.csv", d2[ids, [:ER]])
``` 
On enlève "ER " à lmain de ce fichier puis
```
rg  -v -f todelete.csv clinical.csv | save clinical_nodup.csv
```

### Résultats
Termes HPO les plus courants (>= 40)

```nu
open ../data/clinical_nodup.csv | get Clinical | uniq -c | sort-by count | where count >= 40 | to csv
```
 
## Résultats d'exomes


1178 exomes dont 586 négatifs
```nu
open ~/annex/data/centogene/variants/variants_centogene_final.csv | select "patient ID" "genomic (hg38)" | uniq | where "genomic (hg38)" == "negatif" | length
open ~/annex/data/centogene/variants/variants_centogene_final.csv | select "patient ID" "genomic (hg38)" | uniq | length 1178
```


1056 patients uniques avec exome 
```nu
open ~/annex/data/centogene/variants/variants_centogene_final.csv | get "patient ID" | uniq | length
```


247 données brutes
```nu
ls ~/annex/data/bisonex/call_variant/haplotypecaller/2* | length
```

562 variant uniques:
```nu
open ~/annex/data/centogene/variants/variants_centogene_final.csv | where coding != negatif | select "transcript (cento)" conudin g | uniq | length
```

Classification variant (attention, 4 variants en trop, on en enlève 1 partout.): TODO

Type variants

```nu
❯ open ~/annex/data/centogene/variants/variants_centogene_final.csv | get "genomic (hg38)" | uniq  -c | where value =~ ">" | length
❯ open ~/annex/data/centogene/variants/variants_centogene_final.csv | get "genomic (hg38)" | uniq  -c | where value =~ "del" | length
❯ open ~/annex/data/centogene/variants/variants_centogene_final.csv | get "genomic (hg38)" | uniq  -c | where value =~ "dup" | length
❯ open ~/annex/data/centogene/variants/variants_centogene_final.csv | get "genomic (hg38)" | uniq  -c | where value =~ "ins" | length
```

Zygosity
```nu
❯ open ~/annex/data/centogene/variants/variants_centogene_final.csv | select "genomic (hg38)" zygosity | uniq  | get zygosity | uniq -c | to csv
```

## Versions


`nix flake show`
git+file:///home/alex/code/bisonex
└───packages
    └───x86_64-linux
        ├───awscli2: package 'awscli2-2.11.20'
        ├───bcftools: package 'bcftools-1.17'
        ├───bedtools: package 'bedtools-2.31.0'
        ├───bwa: package 'bwa-unstable-2022-09-23'
        ├───default: package 'nextflow-22.10.6'
        ├───dos2unix: package 'dos2unix-7.4.4'
        ├───fastqc: package 'fastqc'
        ├───gatk: package 'gatk-4.4.0.0'
        ├───hap-py: package 'hap.py'
        ├───htslib: package 'htslib-1.17'
        ├───mosdepth: package 'mosdepth-0.3.3'
        ├───multiqc: package 'multiqc-1.15'
        ├───picard-tools: package 'picard-tools-3.0.0'
        ├───python: package 'python3-3.10.12-env'
        ├───r: package 'R-4.2.3-wrapper'
        ├───rtg-tools: package 'rtg-tools-3.12.1'
        ├───samtools: package 'samtools-1.17'
        ├───spip: package 'spip'
        ├───sratoolkit: package 'vcftools-0.1.16'
        ├───vcftools: package 'vcftools-0.1.16'
        └───vep: package 'perl5.36.0-ensembl-vep-110'
