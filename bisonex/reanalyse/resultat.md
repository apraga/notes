# Stratégies
Nouvelles entrées d'OMIM https://omim.org/search/advanced/entry
1.  soit nouveau gènes (coche "*") : pas de function associée
2.  soit nouvelle association sur ancien gènes (cocher "#") 
"Download as"

## Phénotypes
Depuis 2021/01/01

https://omim.org/search?index=entry&start=1&search=&sort=score+desc%2C+prefix_sort+desc&limit=10&prefix=%23&date_created_from=2021%2F01%2F01&date_created_to=&date_updated_from=&date_updated_to=

Avec helix on extrait les gènes

```bash
cd ~/research/bisonex/code/reanalaysis
sed 's/\t//g'  ~/Downloads/OMIM-Entry-Retrieval.tsv | save phenotypes-2021-01-01.tsv
```

On n'a des résultats que sur une correspondance partielle (\t$GENE)
```nu
open phenotypes-2021-01-01.tsv --raw | from tsv -n | each {|e| rg $"\t($e.column1)" ~/annex/data/bisonex/annotate/full} | str join | save phenotype-result.txt
```

## AFF3
Plusieurs matches pour [AFF3](https://www.omim.org/entry/619297). pLI à 1
Pour analyser tous les variants, on ajoute le nom de fichier pour chaque résultat et le tout est dans un TSV

```nu
 open phenotypes-2021-01-01.tsv --raw | from tsv -n | each {|e| rg -H --no-heading $"\t($e.column1)" ~/annex/data/bisonex/annotate/full }  | str join | save phenotype-result.tsv -f
```


2 candidats
- VOUS chr2:g.100104415G>A   https://mobidetails.iurc.montp.inserm.fr/MD/api/variant/577218/browser/ qq scores bioinfo en faveur, clinique colle partiellement (mais non spécifique). Déjà un VOUS sur autre gène
- (*) VOUS- chr2:g.99560401T>C NM_001386135.1:c.3155A>G  https://mobidetails.iurc.montp.inserm.fr/MD/api/variant/282096/browser/ -> Clinvar vous, spip élevé mais aucun des autres scores. Clinique lourde, overlap partiel (not. encéphalopathie). Exome rendu nég

Très peu probable
- (*) chr2:g.99707103C>T  https://mobidetails.iurc.montp.inserm.fr/MD/api/variant/577243/browser/ légère altération splice,. Clinique ne colle pas. Exome neg
- VOUS chr2:g.100006849G>T  NM_001386135.1:c.656C>A https://mobidetails.iurc.montp.inserm.fr/MD/api/variant/577248/browser/  -> éliminé sur la clinique car diabète + cause génétique retrouvée...
- https://mobidetails.iurc.montp.inserm.fr/MD/api/variant/453600/browser/
- chr2:g.99601569_99601571del https://mobidetails.iurc.montp.inserm.fr/MD/api/variant/115565/browser/
- chr2:g.99601569_99601571del CADD à 18  https://mobidetails.iurc.montp.inserm.fr/MD/api/variant/115565/browser/
- chr2:g.99593527C>T  https://mobidetails.iurc.montp.inserm.fr/MD/api/variant/577240/browser/

Paul : VOUS- pour les 2
Alexis a vérifié qu'ils sont bien dans les VCFs de centogène.

## Gènes récents

858 nouveaux gènes avec
https://omim.org/search?index=entry&start=1&search=&sort=score+desc%2C+prefix_sort+desc&limit=10&prefix=*&date_created_from=2021%2F01%2F01&date_created_to=&date_updated_from=&date_updated_to=

Pour filter avec seulement les pLI intéressantes
1. nettoyer le fichier omim (header footer) et renommer en OMIM-new-genes.tsv
Puis séparer le nom du gène en une nouvelle colonne
```nu
sd '; ' '\t' OMIM-new-genes.tsv
```
Et rajouter le header gene
2. télécharger scores pLI
```nu
wget https://storage.googleapis.com/gcp-public-data--gnomad/legacy/exac_browser/forweb_cleaned_exac_r03_march16_z_data_pLI_CNV-final.txt.gz
gunzip forweb_cleaned_exac_r03_march16_z_data_pLI_CNV-final.txt.gz 
mv forweb_cleaned_exac_r03_march16_z_data_pLI_CNV-final.txt forweb_cleaned_exac_r03_march16_z_data_pLI_CNV-final.tsv
 ```
On fait l'intersection en prenant seuls ceux avec pLI > 0.5

```nu
let omim = open OMIM-new-genes.tsv
let pli = open forweb_cleaned_exac_r03_march16_z_data_pLI_CNV-final.tsv | select gene pLI$omim | join $pli Gene gene | first
$omim | join $pli Gene gene  | where pLI > 0.5
```
On a 49 gènes mais pas forcément de clinique associée... On suit plutôt la méthode d'alexis (cf Clinical sypnosis)

Decipher ? pLI différentes de gnomAD car dépend du transcrit 

## Clinical synopsis
On cherche tous les synopsis créés après le 1er janvier 2021. Ce ne sont pas forcément des nouveaux gènes ni de nouveaux phénotypes

https://omim.org/search?index=entry&sort=score desc, prefix_sort desc&start=1&limit=200&cs_exists=true&date_created_from=2021/01/01&format=tsv

On utilise un script Rust pour fusionner tous les TSV du pipeline en un seul (voir code/reanalyse/README.md) avec les gènes correspondants :

		cargo run --release --bin candidates-phenotypes

Le fichier run_filtered.tsv contient l'intersection. On a 172 entités Omim et environ 3100 varians correspondants.

On filtre par gnomAD exome AF croissant.

Candidats en dominant

- SPEN: 
	- NM_015001.3:c.10709A>G  VOUS 62982227 avec exome neg
		- moitié scores bioinfo en faveur, non retrouvé dans gnomAD
		- zones relativement intolérante aux missense (decipher), en fin de gène sans hotspot
		- clinique : foetus avec malfo cardiaque, colle partielement
		- 1 clinvar VOUS
- LMNB2: 
	-  NM_032737.4:c.1634C>T	VOUS- ? qq score bionfo, pas de hotspot, clinique colle partiellement sur la DI, exome neg

On suit les conseils d'alexis filtrer si < 1% pour dominant, 5% pour récessif

Pause : on regarde les tronquants en groupant par ID cento pour éviter de faire plusieurs fois le même patient:w
Pas de tronquant intéressant dans SPEN
