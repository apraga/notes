# Nanopore

Base-calling : https://github.com/nanoporetech/dorado (GPU)
pipeline dédié https://github.com/epi2me-labs/wf-basecalling
Pipelines
- nanopore https://github.com/epi2me-labs/wf-human-variation
- nf-core https://github.com/nf-core/nanoseq -> pas à jour depuis 2 ans

Visu ribbon/splithreader (igv marche maintenant)

## nf-core
### Test HG002 + pip
https://s3-us-west-2.amazonaws.com/human-pangenomics/NHGRI_UCSC_panel/HG002/hpp_HG002_NA24385_son_v1/nanopore/HG002_ucsc_Jan_2019_Guppy_3.0.fastq.gz
"unsheared DNA and LSK109 sequencing chemistry"

nf-core/nanoseq avec pip install
- 7h40 pour alignement sur 24 cœurs
- Impossible de redémarrer
- On déactive tous les checks
- sniffles plante car vieille version
Il faudrait mettre à jour

### HG002 et singularity
nextflow run nf-core/nanoseq --protocol DNA  -c test.conf -profile singularity  samplesheet.csv## Epi2me
avec

```process {
    executor = 'slurm'
    queue = 'smp'
    // Default parameters for nf-core
    withLabel:process_single {
        cpus          = 1
        memory        = 6.GB
        time          = 4.h
    }
    withLabel:process_low {
        cpus          = 6
        memory        = 12.GB
        time          = 12.h
    }
    withLabel:process_medium {
        cpus          = 24
        memory        = 32.GB
        time          = 24.h
    }
    withLabel:process_high {
        cpus          = 32
        memory        = 72.GB
        time          = 32.h
    }


}

params {

skip_demultiplexing = true
aligner = 'minimap2'
variant_caller = 'medaka'
structural_variant_caller = 'sniffles'
//skip_nanoplot = true
//skip_fusion_analysis = true
skip_quantification = true
call_variants = true
}
```
Il faut éditer le VCF à la main après SNIFFLES
https://github.com/nf-core/nanoseq/issues/276

### Test fournis + singularity (apptainer)
module load apptainer/1.1.8

Erreurs au téléchargement d'images singularity (race condition ? )https://github.com/epi2me-labs/wf-human-variation/issues/175:
On le fait à la main. On met le cache dans le workdir
```
export APPTAINER_CACHEDIR=/Work/Users/apraga/.apptainer
singularity pull  --name ontresearch-wf-human-variation-snp-sha17e686336bf6305f9c90b36bc52ff9dd1fa73ee9.img.pulling.1733051974218 docker://ontresearch/wf-human-variation-snp:sha17e686336bf6305f9c90b36bc52ff9dd1fa73ee9
singularity pull  --name ontresearch-wf-common-shad28e55140f75a68f59bbecc74e880aeab16ab158.img.pulling.1733052407874 docker://ontresearch/wf-common:shad28e55140f75a68f59bbecc74e880aeab16ab158```


export NXF_SINGULARITY_CACHEDIR=/Work/Users/apraga/.apptainer
nextflow run epi2me-labs/wf-human-variation --bam 'wf-human-variation-demo/demo.bam' --ref 'wf-human-variation-demo/demo.fasta' --bed 'wf-human-variation-demo/demo.bed' --sample_name 'DEMO' --snp --sv --mod --phased -profile singularity -c test.conf
