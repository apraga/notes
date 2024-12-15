# Nanopore

Base-calling : https://github.com/nanoporetech/dorado (GPU)
pipeline dédié https://github.com/epi2me-labs/wf-basecalling
Pipelines
- [nanopore](https://github.com/epi2me-labs/wf-human-variation) : à partir du uBAM. Recommandé par le développer de Madaka
- [nf-core](https://github.com/nf-core/nanoseq) -> pas à jour depuis 2 ans, appel de variant échoue par manque de mémoire à 150G...

Visu ribbon/splithreader (igv marche maintenant)

## Données HG002
- [source](https://s3-us-west-2.amazonaws.com/human-pangenomics/NHGRI_UCSC_panel/HG002/hpp_HG002_NA24385_son_v1/nanopore/HG002_ucsc_Jan_2019_Guppy_3.0.fastq.gz)
- "Shasta publication protocol (3 LSK109-based sequencing libraries per PromethION flow cell with 3 flow cells per individual),
with observed N50s (average) ~42 kb and 6x coverage per individual in 100kb+ reads.
[Source](https://s3-us-west-2.amazonaws.com/human-pangenomics/NHGRI_UCSC_panel/HG002/hpp_HG002_NA24385_son_v1/nanopore/Nanopore_README.txt)

## epi2me
### Test HG002 + singularity
Problème :  squashfs non trouvé... On utilise la dernière version de nextflow et du pipeline

- Erreur au téléchargement des images parfois, donc on copie l'adresse depuis le message d'erreur et on le télécharge à la main
- dans leur tutorial, ils partent du [.pod](https://labs.epi2me.io/giab-2023.05/) -> plutôt fastq pour nous
- Il faut un BAM en entrés donc `samtools import` [comme recommandé]()https://github.com/epi2me-labs/wf-human-variation/issues/75#issuecomment-1688305466)
```bash
samtools import -i HG002_ucsc_Jan_2019_Guppy_3.0.fastq.gz -o  HG002_ucsc_Jan_2019_Guppy_3.0.bam    ```
- Ne prend pas plusieurs échantillons
-  L'appel de variant nécessite **le modèle du base calling** (Guppy, qui est [deprecated](https://nanoporetech.com/document/Guppy-protocol) )
  - [liste](https://github.com/nanoporetech/rerio) mais gruppy 3.0 n'est pas listé (probablement trop vieux)
  - [modèles acceptés](#https://github.com/epi2me-labs/wf-human-variation/blob/42ffefba3fe4010818634478ec8851f1a03ee477/data/clair3_models.tsv#L37)
  - on choisit guppy	dna_r9.4.1_450bps_hac	r941_prom_sup_g5014 (promethion + guppy, difficie d'en dire plus)

- Configuration
```bash
process {
    executor = 'slurm'
    queue = 'smp'
    // Default parameters for nf-core
    withName: '.*minimap2.*' {
     //   queue = 'bigmem'
        cpus          = 32
        memory        = 128.GB
        time          = 32.h
    }
}

params {
  // overried minimap2 cpus as by default it sump ubam_map_threads      +  ubam_sort_threads       +  ubam_bam2fq_threads
  ubam_map_threads = 32
  ubam_sort_threads = 32
  ubam_bam2fq_threads = 32
  }
  ```


# nf-core -> appel de variant trop vieux
### Test HG002 + pip

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

Problème : 72Go ne suffit pas pour medaka avec 32Go. Utiliser la queue GPU ne semble pas activer le mode GPU.

39771        nf-NFCORE_NANOSEQ_NANOSEQ_SHORT_VARIANT_CALLING_M+         32        72G   00:14:39   07:48:48 OUT_OF_ME+
39775        nf-NFCORE_NANOSEQ_NANOSEQ_BEDTOOLS_UCSC_BIGWIG_BE+         24        32G   00:10:41   04:16:24 OUT_OF_ME+

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
