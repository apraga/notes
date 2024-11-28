# Nanopore

Base-calling : https://github.com/nanoporetech/dorado (GPU)
pipeline dédié https://github.com/epi2me-labs/wf-basecalling
Pipelines
- nanopore https://github.com/epi2me-labs/wf-human-variation
- nf-core https://github.com/nf-core/nanoseq

Visu ribbon/splithreader (igv marche maintenant)

## Test HG002
https://s3-us-west-2.amazonaws.com/human-pangenomics/NHGRI_UCSC_panel/HG002/hpp_HG002_NA24385_son_v1/nanopore/HG002_ucsc_Jan_2019_Guppy_3.0.fastq.gz
"unsheared DNA and LSK109 sequencing chemistry"

nf-core/nanoseq avec pip install
- 7h40 pour alignement sur 24 cœurs
- Impossible de redémarrer
- On déactive tous les checks
- sniffles plante car vieille version
-

