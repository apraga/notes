#conference

# Contact

- Matthiew Croughan: nix enthusiasts
- Freek van Hemert (mairix: freekvh) PhD, worked at Philips, now started his own company for bioinformatics
- ?? (mairix: zolfa ?) : PhD in biophysics in Institut Curie
- Dominic Mills-Howells (DMills27) : nix enthousiast, left academia, "specializs in nix, haskell, rust, python"
- Nicola Brisotto : interested in bioinformatics

### Daniel Firth
- Contact après présentation FOSDEM Travaille sur Haskell en journée, intéressé pour contribuer en Haskell en bioinformatique
  - mise à jour des paquets bioinformatique sur hackage pour compiler avec dernière version GHC via Horizon Haskell (équivalent en nix de stack) [1] https://horizon-haskell.net [2] https://gitlab.horizon-haskell.net/package-sets/horizon-biohaskell
  - Cherche à contribuer à des projets
-  Présentation nextflow, nf-core, bionix Haskell : recommande Zuriach (conf informelle ) 2024. https://zfoh.ch/zurihac202, https://www.novadiscovery.com/ utilise haskell, https://github.com/BioHaskell/hPDB format PDB (protein data bank)
-  ngless : syntaxe pour définir un workflow
- Suggestions de projets
  - remplacement hap.py (intéressé)
  - nouveau format de fichier ?
  - nouveau site/BDD ?
- Moyennement interessé pour FOSDEM2025 bioinfo (va déjà présenter dans chambre haskell)
- Contact : Matrix

### Simon Tournier
Ingénieur de recherche en bioinformatique côté recherche.
Travaille avec Guix. Contact par mail :

    Au cas où tu serais passé à côté, du côté de Guix, il y a eu cette tentative : https://guixwl.org/
    L'idée était de mettre Guix au coeur et d'écrire au dessus un langage de "workflow".  Cela fonctionne mais difficile de lutter contre Snakemake, CWL, etc.
    Du coup, il y a une autre direction : https://hpc.guix.info/blog/2022/01/ccwl-for-concise-and-painless-cwl-workflows/
    Et Bistro (OCaml) ou Funflow (Haskell) sont aussi des approches intéressantes.
    Puis il y a des patches pour avoir Guix comme gestionnaire de paquets dans Snakemake (à la place de Conda).

    Pour finir, je pense que le plus viable est la génération d'image Docker (ou Singularity) avec Guix ou Nix.  Avec Guix, c'est "guix pack -f docker'.  Autrement dit, toute la partie "environnement logiciel" et sa reproductibilité (et surtout tracabilité) est gérée par Guix.

Contact: mail
