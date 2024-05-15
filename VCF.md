#bioinfo
Générer un VCf minimal

    ##fileformat=VCFv4.2
    #CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample
    chr1	8516	rsXXX	C	T	247.71	.	.	.	.

Remplacer les espaces par des tabs si besoin puis indexer le fichier pour avoir les contig

    sed 's/\s\+/\t/g' sanger.vcf -i
    bgzip sanger.vcf
    tabix -p sanger.vcf.gz
    bcftools view sanger.vcf.gz

    
