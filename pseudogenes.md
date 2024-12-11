# Pseudogene
#auragen

On utilise Chameleolyzer avec les BED donnés par mail en hg38
Masking : ok

## Test 
Pour tester, HG002 a notamment  PMS2CL (pseudogenes de PMS2) -> PMS2 peut servir de test ? ou PSM2CL
STRC a aussi un pseudogene
https://pmc.ncbi.nlm.nih.gov/articles/PMC9706577/

### Données GIAB
[Source](https://github.com/genome-in-a-bottle/giab_data_indexes?tab=readme-ov-file)
Illumina 300x en génome 150bp... 
On prend plutôt en exome déjà, au format BAM
```bash
wget  ftp://ftp-trace.ncbi.nlm.nih.gov/ReferenceSamples/giab/data/AshkenazimTrio/HG002_NA24385_son/OsloUniversityHospital_Exome/151002_7001448_0359_AC7F6GANXX_Sample_HG002-EEogPU_v02-KIT-Av5_AGATGTAC_L008.posiSrt.markDup.bam
## Conversion fastq

stem=151002_7001448_0359_AC7F6GANXX_Sample_HG002-EEogPU_v02-KIT-Av5_AGATGTAC_L008.posiSrt.markDup
samtools sort -n "${stem}.bam" -o "${stem}.sorted.bam"
bedtools bamtofastq -i "${stem}.sorted.bam" -fq HG002-WES-GIAB_1.fastq -fq2 HG002-WES-GIAB_2.fastq
```
