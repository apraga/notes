# Test couverture

```test.config                                                                                                                     
## [required] fasta reference file from which reads will be sampled
ref = ../genome/GCA_000001405.15_GRCh38_full_analysis_set.fna
                                                                                                                      
## [required] a model file generated by "seqToProfile" utility
profile = na12878-bisonex-grch38.model
                                                                                                                      
## [optional] files defining the variations (indel, SNV and CNV) to simulate
variation = ./variations.txt
                                                                                                                      
## [optional] file defining target regions for sequencing. If the argument is not specified, sequencing data of all chromosomes defined in the reference will be produced.
target = ./test.bed
                                                                                                                      
## [required] popolation names (comma-separated).
name = test
                                                                                                                      
## [required] output directory
output = ./simuscop
                                                                                                                      
## [optional] sequence layout, should be "SE" for single end or "PE" for paired-end (default: "SE")
layout = PE
                                                                                                                      
## [optional] the number of threads to use (default: 1)
threads = 2
                                                                                                                      
## [optional] print the intermediate information, should be 0 or 1 (default: 1)
verbose = 1
                                                                                                                      
## [required] sequencing coverage
coverage = 100
                                                                                                                      
## [optional] insert size for paired end sequencing (default: 350, only effective when the "layout" is set to "PE")
insertSize = 200
```

    ../result/bin/simuRead test.config
    bwa mem ../GCA_000001405.15_GRCh38_full_analysis_set.fna simuscop/test_1.fq simuscop/test_2.fq | samtools sort -o test.sorted.bam -

Sur le premier intervalle du bed Twist exome core, simuscop fait une "gaussienne" sur l'exon. Les données Cento ont un trou au milieu de l'exon entre 2 pics...


## Comparaison de variant : sanger sur NA12878



["filter", "haplotypecaller"] | each {|e| rsync -avz $"meso:/Work/Users/apraga/bisonex/run-simuscop/out/call_variant/($e)/NA12878-sanger-simuscop-GRCh38" $"out/call_variant/($e)/" }
rtg vcfeval -b ~/research/bisonex/code/varben/sanger.vcf.gz -c ~/code/bisonex/out/call_variant/haplotypecaller/NA12878-sanger-simuscop-GRCh38/NA12878-sanger-simuscop-GRCh38.haplotypecaller.vcf.gz -t genome/sdf -o sanger-simuscop --output-mode=annotate