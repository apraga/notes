# Varben

- Installer bedtools, samtools et bwa
- Code a du être converti en python3 (avec 2to3)
-  Validé sur chr20 et un test fournis (cf varben-journal.md) 

**Important**
- il faut enlever les "hardclip" du bam (cf varben-journal.md) )
- pour la conversion bam -> fastqc, il faut trier le bam avant (sinon on perd trop de read)


# Variants sanger sur  NA12878 bisonex

## Création du BAM
On utilise les données NA12878. Sampleesheet `na12878.csv`
```
patient,sample,fastq1,fastq2
2300346867_63118093,NA12878,/Work/Groups/bisonex/centogene/fastq/2300346867_63118093_NA12878/63118093_S260_R1_001.fastq.gz,/Work/
Groups/bisonex/centogene/fastq/2300346867_63118093_NA12878/63118093_S260_R2_001.fastq.gz
```
Pipeline
```bash
nextflow run main.nf -profile standard,helios --genome=GRCh38 --input=na12878.csv -with-report na12878.report -with-trace -bg
```
Il faut ensuite supprimer les hardclip pour varben

```bash 
cd out/preprocessing/recalibrated/2300346867_63118093-NA12878-GRCh38
samtools view -h 2300346867_63118093-NA12878-GRCh38.recal.bam | awk '$6 !~ /H/{print}' | samtools view -bS - > 2300346867_63118093-NA12878-GRCh38.recal.nohardclip.bam
```

On ajoute les génomes :
```bash
cd /Work/Users/apraga/exomevalidator
ln -s /Work/Groups/bisonex/data/fasta/GRCh38/bwa/* .
ln -s /Work/Groups/bisonex/data/fasta/GRCh38/GCA_000001405.15_GRCh38_full_analysis_set.fna .
ln -s /Work/Groups/bisonex/data/fasta/GRCh38/GCA_000001405.15_GRCh38_full_analysis_set.fna.fai 
``` 

## Préparation des variants

On utilise `../code/varben/tovarben.nu` pour formatter la liste de variants au format adéquat pour varben `sanger_variants.tsv`.

#### Attention aux duplications
Varben ne supporte pas les duplications en mode mutation (seulement variants structurels). Il faut les écrire sous forme d'insertion.
Ex:
g.169821134dup correspond à la duplication de T en position  169821134.
La notation VCF est correcte 169821133 G GT
Cela correspond à une insertion entre  169821133 et 169821134 d'un T, soit

    169821133 169821134 0.5 ins T

Il faut donc bien supprimer le premier nucléotide de la représentation VCF !

## Insertion des variants

Avec
```slurm

#!/bin/bash -l
# Fichier submission.SBATCH

#SBATCH --job-name="varben"
#SBATCH --output=%x.%J.out   ## %x=job name, %J=job id
#SBATCH --error=%x.%J.out
 # walltime (hh:mm::ss) max is 8 days
#SBATCH -t 4:00:00
#SBATCH --partition=smp
#SBATCH -c 1  ## request 16 cores (MAX is 32)
#SBATCH --mem=16G ## (MAX is 96G)
#SBATCH --mail-user=apraga@chu-besancon.fr
#SBATCH --mail-type=END,FAIL   # notify when job end/fail

module load nix
muteditor -r ../GCA_000001405.15_GRCh38_full_analysis_set.fna   --aligner bwa --alignerIndex ../GCA_000001405.15_GRCh38_full_analysis_set.fna  -o na12878-sanger -m ../sanger_varben.tsv  --mindepth 5 -b ../../bisonex/out/preprocessing/recalibrated/2300346867_63118093-NA12878-GRCh38/2300346867_63118093-NA12878-GRCh38.recal.nohardclip.bam
```
Dans exomevalidator/scripts, 
```bash
sbatch varben.slurm
```
59min temps écoulé, 3h50 de temps CPU (mais est-ce vraiment parallélisé). 
Un seul variant n'a pas été inséré car 0 read : SNV  chr21   43426167

## Conversion en fastq
On utilise initialement bam2fastq, mais après vérification auprès d'Alexis + internet, on passe à samtools fastq.

```
cd na12878-sanger/
cp edit.sorted.bam NA12878-sanger-GRCh38.bam
```

On utilise bam2fastq2.slurm avec 4 threads (~12min au lieu de 50 en séquentiel)

```slurm

#!/bin/bash -l
# Fichier submission.SBATCH

#SBATCH --job-name="bam2fastq"
#SBATCH --output=%x.%J.out   ## %x=job name, %J=job id
#SBATCH --error=%x.%J.out
 # walltime (hh:mm::ss) max is 8 days
#SBATCH -t 4:00:00
#SBATCH --partition=smp
#SBATCH -c 4  ## request 16 cores (MAX is 32)
#SBATCH --mem=24G ## (MAX is 96G)
#SBATCH --mail-user=apraga@chu-besancon.fr
#SBATCH --mail-type=END,FAIL   # notify when job end/fail

dir=na12878-sanger
prefix=NA12878-sanger-GRCh38
bam=$dir/$prefix.bam
sorted=$dir/${prefix}-sorted.bam
cores=4

samtools sort -n $bam -o $sorted -@ $cores
samtools fastq -1 $dir/${prefix}_R1_001.fastq -2 $dir/${prefix}_R2_001.fastq -0 /dev/null -s /dev/null -n -@ $cores $sorted
```


## Pipeline
Avec le samplesheet 
```sanger-varben.csv
patient,sample,fastq1,fastq2
NA12878,sanger-varben,/Work/Users/apraga/exomevalidator/scripts/na12878-sanger/NA12878-sanger-GRCh38_R1_001.fastq,/Work/Users/apraga/exomevalidator/scripts/na12878-sanger/NA12878-sanger-GRCh38_R2_001.fastq
```

On utilise un script slurm pour lancer nextflow sur helios (voir helios.md)

```slurm
#!/bin/bash -l
# Fichier submission.SBATCH

#SBATCH --job-name="bisonex-varben"
#SBATCH --output=%x.%J.out   ## %x=job name, %J=job id
#SBATCH --error=%x.%J.out
 # walltime (hh:mm::ss) max is 8 days
#SBATCH -t 24:00:00
#SBATCH --partition=smp
#SBATCH -c 1  ## request 16 cores (MAX is 32)
#SBATCH --mem=12G ## (MAX is 96G)
#SBATCH --mail-user=apraga@chu-besancon.fr
#SBATCH --mail-type=END,FAIL   # notify when job end/fail

module load nix/2.11.0

# Otherwise job fails as it cannot write to $HOME/.nextflow
export NXF_HOME=/Work/Users/apraga/.nextflow

# user.name must be forced (again... our fix does not seem to work in nix)
nextflow -Duser.name=apraga run main.nf -profile standard,helios --input=sanger-varben.csv --genome=GRCh38 -resume  8749b270-ca2c-4f72-82d9-69fff6563c56
```

# Comparaison
Pour variants sanger, génération d'un VCF pour utiliser rtg vcfeval. Cf [script nu](../code/varben/tovcf.nu)

vcfeval requiert un champ GT, ajouté par le script en fonction de la zygotie ( `--sample ALT`).

## Test sur chr1:

    Threshold  True-pos-baseline  True-pos-call  False-pos  False-neg  Precision  Sensitivity  F-measure
    ----------------------------------------------------------------------------------------------------
       94.000                  4              4       9508          7     0.0004       0.3636     0.0008
         None                 10             10     482190          1     0.0000       0.9091     0.0000

Le faux négatif est homozygote mais appelé par erreur hétérozygote. C'est surtout du à un faible nombre de read : 2/12 portent le variant

## Tous les variants

### Appel de variants
```bash 
rm -rf sanger-varben 
rtg vcfeval -b ~/research/bisonex/code/varben/sanger.vcf.gz -c ~/code/bisonex/out/call_variant/haplotype caller/NA12878-sanger-varben-GRCh38/NA12878-sanger-varben-GRCh38.haplotypecaller.vcf.gz -t genome/sdf -o sanger-varben --output-m ode=annotate
```
- 1 faux négatif qui n'a effectivement pas été inséré par varben par manque de reads  `zgrep FN sanger-varben/baseline.vcf.gz | zgrep -v FN_CA`
- 13 négatifs mais sur la zygosity (alors qu'ils ont été bien inséré ) `zgrep FN sanger-varben/baseline.vcf.gz | zgrep FN_CA`

### Filtre après l'appel de variants
Filtre sur la profondeur: une délétion est filtrée en plus car 21 reads seulements en  chr6    72622255

```nu
 let f = "../bisonex/out/call_variant/filter/NA12878-sanger-varben-GRCh38/NA12878-sanger-varben-GRCh38.filter.depth
.vcf"
bgzip $f ; tabix -p vcf $"($f).gz" ; rtg vcfeval -b ~/research/bisonex/code/varben/sanger.vcf.gz -c $"($f).gz" -t g
enome/sdf -o sanger-varben-filter-depth --output-mode=annotate
```

Filtre sur SNP: idem

```nu
let f = "../bisonex/out/call_variant/filter/NA12878-sanger-varben-GRCh38/NA12878-sanger-varben-GRCh38.filter.polymormphisms.vcf"
bgzip $f ; tabix -p vcf $"($f).gz" ; rtg vcfeval -b ~/research/bisonex/code/varben/sanger.vcf.gz -c $"($f).gz" -t genome/sdf -o sanger-varben-filter-snp --output-mode=annotate
```

### Filtre après annotation

Idem !!

```nu
let f = "../bisonex/out/annotate/filter/NA12878-sanger-varben-GRCh38/NA12878-sanger-varben-GRCh38.filtervep.vcf"
bgzip $f ; tabix -p vcf $"($f).gz" ; rtg vcfeval -b ~/research/bisonex/code/varben/sanger.vcf.gz -c $"($f).gz" -t genome/sdf -o sanger-varben-filter-vep --output-mode=annotate# TODO
```

## TODO
- lancer l'exécution depuis cli en Rust
- télécharger index du genome (.fnai + bwa)