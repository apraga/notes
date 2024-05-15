# Performances

Statistiques pour tout le pipeline
- montrer le timeline report (à partir du trace report)
- regarder execution report  https://www.nextflow.io/docs/latest/tracing.html#execution-report

## BWA mem

Le plus simple est d'utiliser hyperfine pour lancer des runs successifs en faisant varier le numbre de threads.

Il est trop long de tester plusieurs fois chaque possibilité. Test sur 3 runs en séquentiel (50G mémoire)

      Time (mean ± σ):     13725.110 s ± 42.090 s    [User: 13870.522 s, System: 12.543 s]
      Range (min … max):   13677.219 s … 13756.226 s    3 runs

Donc un seul run par configuration avec une demande de 32 coeurs et 50G (en prod, 24 coeurs et 50G) de manière décroissante

    #!/bin/bash -l
    # Fichier submission.SBATCH
 
    #SBATCH --job-name="speedup-bwa"
    #SBATCH --output=%x.%J.out   ## %x=job name, %J=job id
    #SBATCH --error=%x.%J.out
     # walltime (hh:mm::ss) max is 8 days
    #SBATCH -t 24:00:00
    #SBATCH --partition=smp
    #SBATCH -c 32 ## request 16 cores (MAX is 32)
    #SBATCH --mem=50G ## (MAX is 96G)
    #SBATCH --mail-user=apraga@chu-besancon.fr
    #SBATCH --mail-type=END,FAIL   # notify when job end/fail 

    module load nix/2.11.0

    # Requires a working directory by nextflow
    cd /Work/Users/apraga/bisonex/work/8c/cf49fd4508404faa6986ca4b211e49
    INDEX=`find -L ./ -name "*.amb" | sed 's/\.amb$//'`
    # 1 run for each numbers of threads
    # JSON output is needed to have the stats for each run
    # Don't do all configuration and starts from the more expensive

    hyperfine  --export-json hyperfine.json -L threads 32,24,16,8,4,2,1 --runs 1 "bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t {threads} $INDEX k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz"

Note : il faut bien avoir le JSON en format de sortie pour avoir le temps de chaque run et pas seulement les statitistiques.
Note : penser à bien remplacer le nombre de threads !

Résultat dans research/bisonex/code/plot/speedup-bwa.json


    Benchmark 1: bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 32 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
      Time (abs ≡):        684.408 s               [User: 18007.678 s, System: 115.024 s]
 
    Benchmark 2: bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 24 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
      Time (abs ≡):        760.921 s               [User: 17606.845 s, System: 102.416 s]
 
    Benchmark 3: bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 16 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
      Time (abs ≡):        1115.368 s               [User: 17417.684 s, System: 115.360 s]
 
    Benchmark 4: bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 8 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
      Time (abs ≡):        2149.281 s               [User: 17083.367 s, System: 91.516 s]
 
    Benchmark 5: bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 4 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
      Time (abs ≡):        4262.605 s               [User: 16936.132 s, System: 177.830 s]
 
    Benchmark 6: bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 2 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
      Time (abs ≡):        8313.601 s               [User: 16411.816 s, System: 332.537 s]
 
    Benchmark 7: bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 1 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
      Time (abs ≡):        15049.006 s               [User: 15075.411 s, System: 134.121 s]
 
    Summary
      bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 32 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz ran
        1.11 times faster than bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 24 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
        1.63 times faster than bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 16 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
        3.14 times faster than bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 8 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
        6.23 times faster than bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 4 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
       12.15 times faster than bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 2 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz
       21.99 times faster than bwa mem -R '@RG\tID:sample\tSM:sample\tPL:ILLUMINA\tPM:Miseq\tCN:CHU_Minjoz\tLB:definition_to_add' -t 1 ./bwa/GCA_000001405.15_GRCh38_full_analysis_set.fna k12\:15b90d6813adf03787af0b2b90d708f1.fastq.gz k12\:9c41c3effaeead78e1becee8a49cb0ea.fastq.gz## Haplotypecaller

## Haplotypecaller

Pour haplotypecaller, il n'y a plus moyen de spécifier les threads avec la version 4... Est-ce vraiment parallélisé ?
PairHMM au moins est parallélisé avec OpenMP. On teste avec 

    #!/bin/bash -l
    # Fichier submission.SBATCH
 
    #SBATCH --job-name="speedup-haplo"
    #SBATCH --output=%x.%J.out   ## %x=job name, %J=job id
    #SBATCH --error=%x.%J.out
     # walltime (hh:mm::ss) max is 8 days
    #SBATCH -t 24:00:00
    #SBATCH --partition=smp
    #SBATCH -c 16 ## request 16 cores (MAX is 32)
    #SBATCH --mem=16G ## (MAX is 96G)
    #SBATCH --mail-user=apraga@chu-besancon.fr
    #SBATCH --mail-type=END,FAIL   # notify when job end/fail 

    module load nix/2.11.0

    cd /Work/Users/apraga/bisonex/work/d4/5b6f4963533a6319c3c67d4731e511
    hyperfine --export-json hyperfine-haplo -L threads 12,6,4,2,1 --runs 1 "gatk --java-options \"-Xmx13107M\" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2"

Résultat dans research/bisonex/code/plot/speedup-haplo.json


    Benchmark 1: gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 12)
      Time (abs ≡):        14428.832 s               [User: 14399.964 s, System: 213.747 s]
 
    Benchmark 2: gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 6)
      Time (abs ≡):        14164.462 s               [User: 14128.192 s, System: 198.870 s]
 
    Benchmark 3: gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 4)
      Time (abs ≡):        14215.604 s               [User: 14214.320 s, System: 216.795 s]
 
    Benchmark 4: gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 2)
      Time (abs ≡):        14308.381 s               [User: 14294.416 s, System: 213.043 s]
 
    Benchmark 5: gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 1)
      Time (abs ≡):        14136.094 s               [User: 14064.118 s, System: 175.672 s]
 
    Summary
      gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 1) ran
        1.00 times faster than gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 6)
        1.01 times faster than gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 4)
        1.01 times faster than gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 2)
        1.02 times faster than gatk --java-options "-Xmx13107M" HaplotypeCaller  --input HG001-HiSeq4000-Agilentv7-GRCh38.recal.bam  --output HG001-HiSeq4000-Agilentv7-GRCh38.haplotypecaller.vcf.gz  --reference GCA_000001405.15_GRCh38_full_analysis_set.fna  --dbsnp GCF_000001405.40.gz  --tmp-dir .  --max-mnp-distance 2 (threads = 12)# Reproductibilité
On utilise nix 23.05 dans un flake : les version ne bougent donc pas.
Liste des versions données par 

    nix profile list | awk '{print $4}' | awk -F '-' '{print "|" $2" | "$3}'

|    Logiciels    | Version validée |
|    ---          | ---             |
|        R        |          4.2.3  |
|       bwa       |       unstable  |
|    rtg-tools    |       ?s        |
|      gatk       |        4.4.0.0  |
|      spip       |                 |
|     awscli2     |        2.11.20  |
|     fastqc      |                 |
|     hap.py      |                 |
|     htslib      |           1.17  |
|     multiqc     |           1.15  |
|     picard      |         ?       |
|     python3     |        3.10.12  |
|     zoxide      |          0.9.2  |
|    bcftools     |           1.17  |
|    bedtools     |         2.31.0  |
|    dos2unix     |          7.4.4  |
|     ensembl     |  perl5.36.0 + ?
|    mosdepth     |          0.3.3  |
|    nextflow     |        22.10.6  |
|    samtools     |           1.17  |
|    spliceai     |          1.3.1  |
|    vcftools     |         0.1.16  |
|   ensembl       |   perl5.36.0    |
|   sratoolkit    |         2.11.3  |
