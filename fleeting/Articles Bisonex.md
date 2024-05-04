#bisonex #articles
# JOSS
Objectifs:
- fournir dépendences de sarek  *constit*
- fournir données de réference humaine (génome, dbsnp) avec scidataflow

##  Dépendences dans nix 
- [ ] Aligneur
	- [x] (BWA-mem/mem2 : déjà disponibles)
	- [x] (Sentieon : payant)
	- [ ]   Dragmap : PR soumis
- [x] mosdepth
- [ ] Appel de variants (constit !)
    - [x] (CNVkit : déjà disponible)
    - [ ]  [[Packaging DeepVariant]]
    - [x] (freebayes : déjà disponible)
    - [x] GATK HaplotypeCaller: fait
    - [x] (Manta : déjà disponible)
    - [x] (mpileup : déjà disponible dans samtools
    - [x] (Sentieon Haplotyper : payant)
    - [x] (Strelka2 : déjà disponible)
    - [ ] [[Packaging TIDDIT]]
- [ ] Annotation
	- [x] (snpeff : déjà disponible)
	- [ ]  vep : PR soumiss
- [ ] multiqc