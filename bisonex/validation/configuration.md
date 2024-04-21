# Configuration
## Choix du kit de capture
Dans les compte-rendu, "Twist Human Core Exome Plus"
On utilise la version en ligne  https://www.twistbioscience.com/resources/data-files/ngs-human-core-exome-panel-bed-file , qui n'est pas "plus"

Le problème est que cela ne couvre pas un variant rendu et confirmé en Sanger... Plusieurs possibilités
- la version Plus n'est pas disponible en ligne mais la contient -> possible
- le kit a été mis à jour (2021 ?) -> possible
- c'est un problème lié à hg38 -> non, idem en hg19 (et il a l'air lifté du hg38)

En comparant avec le BAM, il y a clairement des endroits manquants et ce n'est pas le meilleur... En terme de couverture, oui.

### Vérification de la qualité

#### Couverture
Source:  https://www.twistbioscience.com/resources/technical-resources?twist-pick=-1&products=-1&sub-products=-1&application=411&year=-1

- hg38_exome_comp_spikein_v2.0.2_targets_sorted.re_annotated.bed
- hg38_exome_v2.0.2_targets_sorted_validated.re_annotated.bed
- Twist_Comprehensive_Exome_Covered_Targets_hg38.bed
- Twist_Exome_Core_Covered_Targets_hg38.bed
- Twist_Exome_RefSeq_targets_hg38.bed

```slurm
#!/bin/bash -l
# Fichier submission.SBATCH

#SBATCH --job-name="mosdepth"
#SBATCH --output=%x.%J.out   ## %x=job name, %J=job id
#SBATCH --error=%x.%J.out
 # walltime (hh:mm::ss) max is 8 days
#SBATCH -t 4:00:00
#SBATCH --partition=smp
#SBATCH -c 4  ## request 16 cores (MAX is 32)
#SBATCH --mem=12G ## (MAX is 96G)
#SBATCH --mail-user=apraga@chu-besancon.fr
#SBATCH --mail-type=END,FAIL   # notify when job end/fail

module load nix/2.11.0
# JULIA_HISTORY=.julia julia mosdepth.jl

bam=out/preprocessing/recalibrated/2300346867_63118093-NA12878-GRCh38/2300346867_63118093-NA12878-GRCh38.recal.bam

mkdir test-capture
mosdepth -b capture/hg38_exome_comp_spikein_v2.0.2_targets_sorted.re_annotated.bed test-capture/na12878-hg38_exome_comp_spikein_v2.0 $bam
mosdepth -b capture/hg38_exome_v2.0.2_targets_sorted_validated.re_annotated.bed test-capture/na12878-hg38_exome_v2.0.2 $bam
mosdepth -b capture/Twist_Comprehensive_Exome_Covered_Targets_hg38.bed test-capture/na12878-Twist_Comprehensive_Exome $bam
mosdepth -b capture/Twist_Exome_Core_Covered_Targets_hg38.bed test-capture/na12878-Twist_Exome_Core $bam
mosdepth -b capture/Twist_Exome_RefSeq_targets_hg38.bed test-capture/na12878-Twist_Exome $bam
```
Résultat:

Sample Name	≥ 30X	Median	Mean Cov.
na12878-Twist_Comprehensive_Exome	96.0%	66.0X	69.4X
na12878-Twist_Exome	96.0%	66.0X	69.3X
na12878-Twist_Exome_Core	97.0%	66.0X	69.4X
na12878-hg38_exome_comp_spikein_v2.0	94.0%	65.0X	68.2X
na12878-hg38_exome_v2.0.2	95.0%	65.0X	67.4X

Twist Exome Core a les meilleurs résultats mais il y a des zones qui devraient être couvertes mais qui ne le sont pas. 


### Par rapport au bam
On utilise [bamtocov](https://github.com/telatin/bamtocov) pour générer un fichier de captuer à partir du bam. (NB: covtobam ne fait pas l'union non plus des intervalles...)
Mais cela donne les couvertures par position alors que covtobed donne l'union des positions >= seuil (pourtant bamtocov est plus récent). On prend le second

```bash
conda create --name bamtocov-env
conda activate bamtocov-env
conda install -y -c bioconda bamtocov

bamtocov 2300346867_63118093-NA12878-GRCh38.recal.bam | awk '$4 >= 30' > coverage_gt30.bed
```
On fusionne les intervalles consécutifs
```bash
bedtools merge -i coverage_gt30.bed > coverage_gt30_merged.bed
```
On regarde s'il existe des régions dans notre BAM qui ne sont pas dans les différents kit de capture: option -v de bedtools.
En calculant le nombre d'intervalles absents du kit et la taille totale des absences:


```nu
[Twist_Comprehensive_Exome_Covered_Targets_hg38.bed Twist_Exome_Core_Covered_Targets_hg38.bed Twist_Exome_RefSeq_ta
rgets_hg38.bed hg38_exome_comp_spikein_v2.0.2_targets_sorted.re_annotated.bed hg38_exome_v2.0.2_targets_sorted_valida
ted.re_annotated.bed] | each {|e| print $e; bedtools intersect -v -a coverage_gt30_merged.bed -b $e | awk  'BEGIN{SUM
=0}{SUM+=$3-$2}END{print SUM}' }

Twist_Comprehensive_Exome_Covered_Targets_hg38.bed
9817186
Twist_Exome_Core_Covered_Targets_hg38.bed
15407667
Twist_Exome_RefSeq_targets_hg38.bed
9715995
hg38_exome_comp_spikein_v2.0.2_targets_sorted.re_annotated.bed
9479802
hg38_exome_v2.0.2_targets_sorted_validated.re_annotated.bed
10820313
```

```nu
[Twist_Comprehensive_Exome_Covered_Targets_hg38.bed Twist_Exome_Core_Covered_Targets_hg38.bed Twist_Exome_RefSeq_ta
rgets_hg38.bed hg38_exome_comp_spikein_v2.0.2_targets_sorted.re_annotated.bed hg38_exome_v2.0.2_targets_sorted_valida
ted.re_annotated.bed] | each {|e| print $e; bedtools intersect -v -a coverage_gt30_merged.bed -b $e | wc -l }
Twist_Comprehensive_Exome_Covered_Targets_hg38.bed
95582
Twist_Exome_Core_Covered_Targets_hg38.bed
114651
Twist_Exome_RefSeq_targets_hg38.bed
95271
hg38_exome_comp_spikein_v2.0.2_targets_sorted.re_annotated.bed
93839
hg38_exome_v2.0.2_targets_sorted_validated.re_annotated.bed
97634
```

Selon ces mesures, le meilleur est donc Twist Exome 2.0 plus Comprehensive Exome Spike-in... 
