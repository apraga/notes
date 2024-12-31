# Pseudogene
#auragen

On utilise Chameleolyzer avec les BED donnés par mail en hg38
Il faut renommer les chromsomes avant

```bash
#!/bin/sh
# Convert chromosome from refseq to chr
url="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_assembly_report.txt"
curl $url > assembly_report.txt
# Prepare sed commnands: skip comment and "na".
# Use fix and patch too
awk -F "\t" '
/^[^#]/ && $7 != "na" {
print "s/>"$7"/>"$10"/";
}' assembly_report.txt | tr -d $'\r' > mapping_from_refseq.sed
sed -i -f mapping_from_refseq.sed GCF_000001405.40_GRCh38.p14_genomic.fna
```

Soit

```bash
  wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz
  gunzip https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz

  bash rename_chr.sh
  bwa index GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fnaz
  samtools faidx GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna
```

## Test

Pour tester, HG002 a notamment  PMS2CL (pseudogenes de PMS2) -> PMS2 peut servir de test ? ou PSM2CL
STRC a aussi un pseudogene
https://pmc.ncbi.nlm.nih.gov/articles/PMC9706577/

### HG002

### Préparation

On prend le BAM en hg19 recommandé par Chaméleolyser
[Source](https://github.com/genome-in-a-bottle/giab_data_indexes?tab=readme-ov-file)
Illumina 300x en génome 150bp...
On prend plutôt en exome déjà, au format BAM

```bash
wget ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/OsloUniversityHospital_Exome/151002_7001448_0359_AC7F6GANXX_Sample_HG002-EEogPU_v02-KIT-Av5_AGATGTAC_L008.posiSrt.markDup.bam
md5sum
```
On vérifie le MD5 : c80f0cab24bfaa504393457b8f7191fa

Conversion fastq
```bash
stem=151002_7001448_0359_AC7F6GANXX_Sample_HG002-EEogPU_v02-KIT-Av5_AGATGTAC_L008.posiSrt.markDup
samtools sort -n "${stem}.bam" -o "${stem}.sorted.bam"
bedtools bamtofastq -i "${stem}.sorted.bam" -fq HG002-WES-GIAB_1.fastq -fq2 HG002-WES-GIAB_2.fastq
```

Problème sur le BAM généré par markduplicates tronqué, on essaie avec satmools: idem
```bash
bam=151002_7001448_0359_AC7F6GANXX_Sample_HG002-EEogPU_v02-KIT-Av5_AGATGTAC_L008.posiSrt.markDup.bam
samtools collate -u -O $bam |  samtools fastq -1 HG002-WES-GIAB_1.fastq -2 HG002-WES-GIAB_2.fastq -0 /dev/null -s /dev/null -n
```

Alignement
```bash
bwa mem -t 24 GCA_000001405.15_GRCh38_full_analysis_set.fna HG002-WES-GIAB_1.fastq HG002-WES-GIAB_2.fastq | samtools sort -@8 -o HG002.bam -
```
Haplotypecaller a besoin d'un sample !
```bash
mv HG002.bam HG002_notag.bam
samtools addreplacerg -r ID:HG002 -r SM:HG002 HG002_notag.bam -o HG002.bam
```
Si le BAM n'est pas indexé, markduplicate fait un BAM corrompu..

```bash
```
### Appel de variants
On réessaye avec le script Perl initial, en modifiant juste le chemin
des BED. Il faut mettre le chemin complet, pas relatif
```bash
perl Chameleolyser.pl --GenerateMaskedAlignmentAndVcf --WORKING_DIR=/Work/Users/apraga/Chameleolyser/work/ --SAMPLE_NAME=HG002 --ALIGNMENT_FP=/Work/Users/apraga/Chameleolyser/HG002.bam
```

### HG002 chr20
Même BAM que précédemment, mais on ne garde que chr20

samtools index HG002.bam
samtools view HG002.bam chr20 -o HG002_chr20.bam

perl Chameleolyser.pl --GenerateMaskedAlignmentAndVcf --WORKING_DIR=/Work/Users/apraga/Chameleolyser/work/ --SAMPLE_NAME=HG002_chr20 --ALIGNMENT_FP=/Work/Users/apraga/Chameleolyser/HG002_chr20.bam
