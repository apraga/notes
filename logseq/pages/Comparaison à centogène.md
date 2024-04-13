tags:: bisonex, validation

- ## Variants manqués
- GABRA5 est le plus problématique car il faudrait vraiment baisser les seuils
- On vérifie après alignement : 19 de profondeur (attention il faut -Q 0 pour correspondre)
- ```bash
  cd /Work/Users/apraga/bisonex/out/preprocessing/mapped/2200519525-63060439-GRCh38
  samtools mpileup 2200519525-63060439-GRCh38.aligned.bam -r chr15:26869324-26869324 -Q 0
  
  [mpileup] 1 samples in 1 input files
  chr15   26869324        N       19      AaAaaTTATtTTttAattA     k:!k!!kFk!!kk!k!k!F
  ```
- On essaie avec la version noalt : idem !
- ```bash
  cd /Work/Users/apraga/bisonex/work/2c/63779dffb657b13fcfd2f4f09da8e2
  mv bwa .bwa
  ln -s /Work/Projects/bisonex/data/fasta/GRCh38-noalt/bwa .
  mv 2200519525-63060439-GRCh38.aligned.bam  2200519525-63060439-GRCh38.aligned-grch38.bam
  bwa mem     -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add'     -t 24     bwa/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna     63060439_S92_R1_001.fastq.gz 63060439_S92_R2_001.fastq.gz     | samtools sort  --threads 24 -o 2200519525-63060439-GRCh38.aligned.bam -
  samtools mpileup 2200519525-63060439-GRCh38.aligned.bam -r chr15:26869324-26869324 -Q 0
  
  [mpileup] 1 samples in 1 input files
  chr15   26869324        N       19      AaAaaTTATtTTttAattA     k:!k!!kFk!!kk!k!k!F
  ```
- Dernier test : avec GRCh37 no alt. Il n'y a pas la version avec les index bwa sur le FTP ncbi donc on utilise
- ```bash
  cd /Work/Groups/bisonex/data/fasta/GRCh37/
  wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/analysisSet/hg19.p13.plusMT.no_alt_analysis_set.fa.gz_pipelines/GCA_000001405.14_GRCh37.p13_no_alt_analysis_set.fna.g
  wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/bigZips/analysisSet/hg19.p13.plusMT.no_alt_analysis_set.bwa_index.tar.gz
  
  z bisonex
  cd test/gabra5
  ln -s /Work/Groups/bisonex/data/fasta/GRCh37/hg19.p13.plusMT.no_alt_analysis_set .
  bwa mem     -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add'     -t 24     hg19.p13.plusMT.no_alt_analysis_set/hg19.p13.plusMT.no_alt_analysis_set.fa     63060439_S92_R1_001.fastq.gz 63060439_S92_R2_001.fastq.gz     | samtools sort  --threads 24 -o 2200519525-63060439-GRCh37.aligned.bam -
  ```
- Après liftover (27114471), pareils ... 
  ```bash
   samtools mpileup 2200519525-63060439-GRCh37.aligned.bam -r chr15:27114471-27114471 -Q 0
  [mpileup] 1 samples in 1 input files
  chr15   27114471        N       19      AaAaaTTATtTTttAattA     k:!k!!kFk!!kk!k!k!F
  ```
-
- TODO: markduplicates
- gatk MarkDuplicates --INPUT 2200519525-63060439-GRCh37.aligned.bam --OUTPUT 2200519525-63060439-GRCh37.markedup.bam --REFERENCE_SEQUENCE /Work/Groups/bisonex/data/fasta/GRCh37/hg19.p13.plusMT.no_alt_analysis_set.fa.gz  --METRICS_FILE metrics
-
- TODO: tested freebays (cf VCF cento)