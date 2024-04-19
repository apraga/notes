tags:: bisonex, validation

- [[Centogene config]]
-
- ## Variants manqués
- GABRA5 est le plus problématique car il faudrait vraiment baisser les seuils
- On vérifie que cela ne vient pas de l'alignement : GRCH38-noalt et GRCh37
- ```bash 
  
  bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add'     -t 24   /Work/Groups/bisonex/data/fasta/GRCh37/hg19.p13.plusMT.no_alt_analysis_set/hg19.p13.plusMT.no_alt_analysis_set.fa     63060439_S92_R1_001.fastq.gz 63060439_S92_R2_001.fastq.gz     | samtools sort  --threads 24 -o 2200519525-63060439-GRCh37.aligned.bam -
  bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add'     -t 24     /Work/Groups/bisonex/data/fasta/GRCh38-noalt/bwa/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna     63060439_S92_R1_001.fastq.gz 63060439_S92_R2_001.fastq.gz     | samtools sort  --threads 24 -o 2200519525-63060439-GRCh38-noalt.aligned.bam -
  
  
  samtools index 2200519525-63060439-GRCh37.aligned.bam
  samtools index 2200519525-63060439-GRCh38-noalt.aligned.bam
  samtools mpileup 2200519525-63060439-GRCh38-noalt.aligned.bam -r chr15:26869324-26869324 -Q 0
  [mpileup] 1 samples in 1 input files
  chr15   26869324        N       19      AaAaaTTATtTTttAattA     k:!k!!kFk!!kk!k!k!F
  samtools mpileup 2200519525-63060439-GRCh37.aligned.bam -r chr15:27114471-27114471 -Q 0
  [mpileup] 1 samples in 1 input files
  chr15   27114471        N       19      AaAaaTTATtTTttAattA     k:!k!!kFk!!kk!k!k!F
  ```
-
- Probablement un problème des fastq ? Argument en faveurs
	- pas eu ce problème sur les autres variants
	- bwa-mem semble signaler une erreur 
	  ```bash
	  [M::mem_process_seqs] Processed 734826 reads in 150.735 CPU sec, 6.449 real sec
	  [W::bseq_read] the 1st file has fewer sequences.
	  [W::bseq_read] the 1st file has fewer sequences.
	  [gzclose] buffer error
	  [bam_sort_core] merg
	  ```
- Effectivement : 
  ```bash
   du -hs *63060439*/*
  558M    2200519525_63060439/63060439_S92_R1_001.fastq.gz
  2.6G    2200519525_63060439/63060439_S92_R2_001.fastq.gz
  ```