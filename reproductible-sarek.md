# Reproductible sarek
#bisonex #article 



# Spec

Objectifenvironnement reproductible autour de sarek en constit seul
1. bases de donnéesgénomes, annotation
2. dépendances logicielles nécessaires
Scope: JOSS


# Logiciels avec Paquets Nix

"cancelled" si déjà dans Nix
-  Contrôle qualité
    -  FastQC 
    -   fastp
-  Alignement
    -   BWA-mem
    -  BWA-mem2
    -   dragmap 
    -  sentieon BWA-mem (licence)
    -  GATK MarkDuplicates
-  Post-alignement
    -  GATK 
    -  Sentieon LocusCollector and Sentieon Dedup (licence)
-  Stats
    -  samtools stats
    -  mosdepth
-  Appel de variants
    -  ASCAT
    -  sNVkit
    -  DeepVariant
    -  freebayes
    -  GATK HaplotypeCaller
    -  Manta
    -  mpileup
    -  Sentieon Haplotyper (licence)
    -  Strelka2 
    -  TIDDIT
    -  cnvkit
-  Annotation
        -   SnpEff
    -  Ensembl VEP
    -  BCFtools annotate
-  MultiQC

[Sarek Workflow] 
