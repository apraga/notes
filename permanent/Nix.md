#nix

- [[NixOS]]

## Configuration
-  Activer les flakes (experimental) ! Meilleure expérience utilisateur
### WSL2
changer /nix/store
Pour accéder à un lecteur US:, rajouter dans /etc/fstabl
``` {.bash org-language="sh"}
E: /mnt/e drvfs defaults,uid=1000,gid=1000,metadata 0 0
```
`metadata` est important car cela nous permet de changer les permissions ! Puis
```sh
mount --bind /mnt/e/nix /nix
```
## Utilisation (nix profile)
Chercher et installer un programme
```sh
nix profile search nixpkgs#zoxide
nix profile install nixpkgs#zoxide
```
NB: Avec nushell, Il faut parfois mettre des guillemets, ex:
```sh
nix profile install "nixpkgs#cabal-install"
```

Tout supprimer
``` {.bash org-language="sh"}
nix profile remove '.*'
```
### Améliorer la recherche de paquets
`nix-env` est lent. `nix search` avec les flakes ne fonctionne pas bien pour certains packages (récursif mais certains paquets désactivent l'évalution).
Meilleures solution :
-   search.nixos.org
-   `nix-index` : installer puis `nix-indx` puis chercher par nom de ficher. Ex: `nix-locate bin/R`

## Développer un package
- Le hash peut être calculé avec  `nix-prefetch-url --unpack https://...tar.gz`.  Ou bien, ne pas mettre de hash et copier le résultat de l'erreur !
### Débugger
Voir [Débugger un paquet nix](Débugger%20un%20paquet%20nix.md)
### Installer une seule dérivation
    nix-shell -p 'with import <nixpkgs>{}; callPackage pkgs/GenomeRef.nix {}'
Ne pas oublier {}
### Ajout d'un patch
```nix
	nixpkgs.overlays = [
      # Patch to avoid out-of-memory errors in nix
      (final: prev: {
        nix = prev.nix.overrideAttrs (old: {
          patches = (old.patches or []) ++ [./0001-don-t-read-outputs-into-memory-for-output-rewriting.patch ];
        });
      })
      ] ;
```

# Avertissements
Ne jamais modifier les fichiers dans /nix/store
# Langage
- [Python avec nix](Environnement%20Python%20avec%20nix.md)
- [Haskell avec Nix](Environnement%20Haskell%20avec%20Nix.md)
- [R avec Nix](Environnement%20R%20avec%20Nix.md)
## Vérifier les dépendences à l\'exécution

Il faut les mettre dans propagatedBuildInputs (buildInputs ne suffit
pas). On vérifie avec :
``` {.bash org-language="sh"}

$ nix-instantiate -E "with import <nixpkgs> {}; callPackage pkgs/hap-py.nix {}"
/nix/store/scbx1aiadh24qwwjhskp7jdqngsm31x7-hap.py.drv

$ nix-store -r /nix/store/scbx1aiadh24qwwjhskp7jdqngsm31x7-hap.py.drv
(...installation...)
/nix/store/kgxqmk7jdi91jwbrj4qz5q5c4qhh8qzb-hap.py

$ nix-store -q --references /nix/store/kgxqmk7jdi91jwbrj4qz5q5c4qhh8qzb-hap.py
```

Si le program en a besoin, wrapper le programme en rajoutant dans
nativeBuildInputs makeWrapper :
``` {.bash org-language="sh"}
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = with lib; with pkgs; ''
    wrapProgram $out/bin/test.sh\
      --prefix PATH : ${makeBinPath [ bcftools samtools]}
  '';
}
```

# Aide

## Paquet non trouvé \"attribute is missing\"

Ex: nix-shell -p rPackages.BSgenome~HsapiensUCSChs1~ error: attribute
\'BSgenome~HsapiensUCSChs1~\' missing

1.  Mettre à jour le channel
2.  Sinon attention à la différence entre le channel de l\'utiliser et
    du root. Par défaut, le channel de l\'utilisateur n\'est pas utilisé
    sauf si la configuration utilise \<stable\>. Le channel par défaut
    est nixpkgs (sinon nixos) !!
