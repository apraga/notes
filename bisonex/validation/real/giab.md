# GIAB

## Données GIAB 

https://github.com/genome-in-a-bottle/giab_data_indexes

Pour HG002,3,4,5, on a seulement les BAM sur le FTP GIAB (cf tableau)
On a pu retrouver les fastq via  https://trace.ncbi.nlm.nih.gov/Traces/index.html?view=study&acc=SRP047086, en filtrant sur AssayType = WXS

SRR2962669	OSLO UNIVERSITY HOSPITAL	SRX1453593	Illumina HiSeq 2500	HG002_WES_OUS	PAIRED	Hybrid Selection	HG002	male	SRP047086	
SRR2962692	OSLO UNIVERSITY HOSPITAL	SRX1453614	Illumina HiSeq 2500	HG003_WES_OUS	PAIRED	Hybrid Selection	HG003	male	SRP047086	
SRR2962693	OSLO UNIVERSITY HOSPITAL	SRX1453615	Illumina HiSeq 2500	HG005_WES_OUS	PAIRED	Hybrid Selection	HG005	male	SRP047086	
SRR2962694	OSLO UNIVERSITY HOSPITAL	SRX1453616	Illumina HiSeq 2500	HG004_WES_OUS	PAIRED	Hybrid Selection	HG004	female	SRP047086	
Si on prend une expérience, on voit que la capture est Agilent SureSelect Human All Exon V5 kit https://www.ncbi.nlm.nih.gov/sra/SRX1453593

Avec ENA on a directement les FASTQ (non accessible facilement sur SRA).


| Patient | Données | Capture                        | BED       | Séquenceur |_Lien
| HG001   | Fastq   |_  Nextera Rapid Capture Exome  | ftp, hg19 |  HiSeq     | https://ftp.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/NA12878/Garvan_NA12878_HG001_HiSeq_Exome/
| HG002   | BAM     | ?                              | ?         | HiSeq      | https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/OsloUniversityHospital_Exome/
| HG003   | BAM     | ?                              | ?         | HiSeq      | https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG003_NA24149_father/OsloUniversityHospital_Exome/
| HG004   | BAM     | ?                              | ?         | HiSeq      | https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG004_NA24143_mother/OsloUniversityHospital_Exome/
| HG005   | BAM     | ?                              | ?         | HiSeq      | https://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/ChineseTrio/HG005_NA24631_son/OsloUniversityHospital_Exome/
| HG002_  | fastq   | Agilent SureSelect All Exon v5 | HiSeq2500 | https://www.ebi.ac.uk/ena/browser/view/SRX1453593
| HG003_  | fastq   | Agilent SureSelect All Exon v5 | HiSeq2500 | https://www.ebi.ac.uk/ena/browser/view/SRX1453614
| HG005_  | fastq   | Agilent SureSelect All Exon v5 | HiSeq2500 | https://www.ebi.ac.uk/ena/browser/view/SRX1453615
| HG004_  | fastq   | Agilent SureSelect All Exon v5 | HiSeq2500 | https://www.ebi.ac.uk/ena/browser/view/SRX1453616

Pas HG006 ni HG007

bcbio utilise le BED en hg19 et le converti en hg38 GIAB :  https://github.com/bcbio/bcbio_validation_workflows/blob/master/giab-exome/input/get_data.sh

### Autres
| HG001 | hg38 | HiSeq 4000   |      Agilent SureSelect v7      | SRX11061486 |         https://github.com/kevinblighe/agilent          |
| HG001 | hg38 | NovaSeq 6000 |      Agilent SureSelect v7      | SRX11061516 |         idem                                            |
| HG001 | hg19 |   HiSeq2000  |  SeqCap EZ Human Exome Lib v3.0 |  SRR1611178 | http://hgdownload.soe.ucsc.edu/gbdb/hg19/exomeProbesets/
| HG001 | hg19 |   HiSeq2000  |  SeqCap EZ Human Exome Lib v3.0 |  SRR1611179 |                          idem
| HG001 | hg19 |   HiSeq2500  |  SeqCap EZ Human Exome Lib v3.0 |  SRR1611183 |                          idem
| HG001 | hg19 |   HiSeq2500  |  SeqCap EZ Human Exome Lib v3.0 |  SRR1611184 |                          idem


Pour Agilent, on prend le fichier *Region.bed

https://emea.support.illumina.com/downloads/truseq-exome-product-files.html

Génome de référenec
[GRC38](https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.26_GRCh38/GRCh38_major_release_seqs_for_alignment_pipelines/GCA_000001405.15_GRCh38_full_analysis_set.fna.gz)

VCF de référence + bed
- [HG001](https://ftp-trace.ncbi.nih.gov/ReferenceSamples/giab/release/NA12878_HG001/latest/GRCh38/)

## Données Google (Baid et al 2020)
https://www.biorxiv.org/content/10.1101/2020.12.11.422022v1.full
Motivation: données de 2016 pour GIAB...

Patients: 

- HG002 à HG007
- NA12891-NA12892 

|            | Agilentv7 | IDT-xGen       | Truseq |
| HiSeq 4000 | 50x       | 50x, 75x, 100x | 50x 75x  | 
| Novaseq    | 50,75,100 | 50,75,100      | 50,75,100 | 

- (Nextera: mentionné mais données non disponibles)

Au total, 42 combinaison (séquenceur + capture avec 50x)

Disponible en téléchargement direct sur 
- https://console.cloud.google.com/storage/browser/brain-genomics-public/research/sequencing/fastq?pageState=(%22StorageObjectListTable%22:(%22f%22:%22%255B%255D%22))&prefix=&forceOnObjectsSortingFiltering=false
- via aws cli : aws s3 ls --no-sign-request s3://genomics-benchmark-datasets/google-brain/fastq/

Disponibilité des kit
- agilent = sur leur site (login nécessaire)
- idt : accès libre mais à nettoyer ttps://sfvideo.blob.core.windows.net/sitefinity/docs/default-source/supplementary-product-info/xgen-exome-hyb-panel-v2-targets-manifest-hg38.txt?sfvrsn=b6c0e207_2

    awk '{print $2"\t"$3"\t"$4}' xgen-exome-hyb-panel-v2-targets-manifest-hg38.txt | sed '/^^chr/d' > xgen-exome-hyb-panel-v2-targets-manifest-hg38.bed
- truseq : 
https://emea.support.illumina.com/content/dam/illumina-support/documents/downloads/productfiles/truseq/truseq-dna-exome/truseq-dna-exome-targeted-regions-manifest-v1-2-bed.zip



#### Choix de la couverture

Tests refait car moins bonnes performances en novaseq qu'en hiseq4000...
On calcule (cf scripts coverage dans exomevalidator) la couverture des BAM fournis par baid2020 pour gatk4. Pour agilent et truseq (les kit fournis), amélioration par rapport aux bed trouvés sur internet (sauf moyenne et médianne pour agilent). Idem pour bisonex -> ouf !

Résultat des tests

|                | >= 30x  | médiane | moyenne|
| Agilentv7 à 50x| 82.0%   | 63x     | 73.8
| Cento          | 96%     | 62-100%
| Idt 75x        | 86%     | 64x  | 76.6        |

Notes :
- Attention en utilisant mosdepth, il ne faut pas regarder les stats en global mais seulement par région si on restreint à un bed ! Avec le BED dans bisonex, multiqc + mosdepth donne 
- Exemple de commande
    mosdepth --by agilent-GRCh38.bed --fasta GCA_000001405.15_GRCh38_full_analysis_set.fna  HG001-HiSeq4000-Agilentv7-GRCh38-v2 HG001-HiSeq4000-Agilentv7-GRCh38.markedduplicates.bam
    nextflow run main.nf -profile standard,helios --input=hg001-hiseq400-idt-75x.csv --genome=GRCh38 -with-trace -with-report --capture=capture/xgen-exome-hyb-panel-v2-targets-manifest-hg38.bed  -bg


### Également sur NIST ?
Y ressemble suspicieusement : fourni par google, même séquenceur et kit. Par contre, la taille ne correspond pas exactement (50x à 1.4G au lieu de 3 ?)

https://trace.ncbi.nlm.nih.gov/Traces/?view=study&acc=SRP322567 
En filtran sur exome
https://trace.ncbi.nlm.nih.gov/Traces/study/?acc=SRP322567&f=assay_type_s%3An%3Awxs%3Ac&o=acc_s%3Aa
On peut télécharger les données dans "metadata" au format CSV

## Données @barbitoff2022
HG001 à 7 avec HiSeq4000 (sauf 1). Tout le monde en agilent sureselect v5 ou v7
BED file disponible en hg19 sur le github, qui contient tous les scripts.

Au final, on a plus de données avec Baid2020...

## Conversion des données bam en fast
bcbio convert le .bed 
https://github.com/bcbio/bcbio_validation_workflows/blob/master/giab-exome/input/get_data.sh

# Résultats

## NA12878
Command

```bash
hap.py giab/HG001_GRCh38_1_22_v4.2.1_benchmark.vcf.gz ~/code/bisonex/out/call_variant/haplotypecaller/2300346867_63118093-NA12878-GRCh38/2300346867_63118093-NA12878-GRCh38.haplotypecaller.vcf  --false-positive giab/HG001_GRCh38_1_2 2_v4.2.1_benchmark.bed --target-regions ~/code/bisonex/capture/Twist_Exome_Core_Covered_Targets_hg38.bed --reference genome/GCA_000001405.15_GRCh38_full_analysis_set.fna --engine=vcfeval --engine-vcfeval-template=genome/sdf -o na12878-bisonex-grch38
```
Résultat: ../../../code/data/na12878-bisonex-grch38
## Baid 2020
hap.py avec rtg eval 
Pour HG001 à HG007, les résultats sont générés avec exomevalidator (compare-exome permet d'avoir un.summary.csv pour tous les runs).

Ex pour HG001 hiseq4000 agilentsureselect v7 (BED en GRCH38)


Type,Filter,TRUTH.TOTAL,TRUTH.TP,TRUTH.FN,QUERY.TOTAL,QUERY.FP,QUERY.UNK,FP.gt,FP.al,METRIC.Recall,METRIC.Precision,METRIC.Frac_NA,METRIC.F1_Score,TRUTH.TOTAL.TiTv_ratio,QUERY.TOTAL.TiTv_ratio,TRUTH.TOTAL.het_hom_ratio,QUERY.TOTAL.het_hom_ratio,run
INDEL,ALL,549,489,60,899,62,340,17,9,0.89071,0.889088,0.378198,0.889898,,,1.86096256684492,2.271062271062271,HG001-HiSeq4000-Agilentv7-50x-GRCh38.haplotypecaller.summary
INDEL,PASS,549,489,60,899,62,340,17,9,0.89071,0.889088,0.378198,0.889898,,,1.86096256684492,2.271062271062271,HG001-HiSeq4000-Agilentv7-50x-GRCh38.haplotypecaller.summary
SNP,ALL,21973,21466,507,26288,562,4266,69,72,0.976926,0.97448,0.162279,0.975702,3.007110300820419,2.7840287769784173,1.5918102430965306,1.8152593227603944,HG001-HiSeq4000-Agilentv7-50x-GRCh38.haplotypecaller.summary

## Comparaison avec Baid2020 
figure
on utilise leur vcf. Avec plot/giab.pl, on compare avec bisonex.
Résultats assez surprenant car la répartition est différente, même pour bwa-mem + gatk.
2 différences 
1. C'est la version no_alt qui est utilisée 
ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for
_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz
2. haplotypecaller utilise -L pour restreindre à la zone de capture

Probablement lié au génome de référence mais on est meilleur en tout cas.
Avec le .bed fourni par baid2020 (agilent + idt), on a des résultats différents pour l'analyse par capture ou séquencer. Mais novaseq n'est pas moins bon 

Étude de l'impact de la couverture: ne semble pas améliorer (cf plots/coverage.jl)
Testé sur mean, median, >= 30.
