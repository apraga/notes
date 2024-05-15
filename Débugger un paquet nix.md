#nix

## 1. Démarrer un shell. 
### Nixpkgs
```sh
cd nixpkgs
mkdir lol
cd lol
nix-shell ../ -A kent
```
### Paquet local
Sans flakes
```sh 
nix-shell -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'
```
Avec Flakes
```sh
nix develop .#my-package
```
## 2. Débug
Le plus simple est d'utiliser genericBuild avec les différentes phases,
exemple :
``` {.bash org-language="sh"}
phases="checkPhase installPhase" genericBuild
```

Liste des phases : unpackPhase patchPhase configurePhase buildPhase
checkPhase installPhase fixupPhase installCheckPhase distPhase
Puis 
``` nix
$ export out=~/tmpdev/bc-build/out
$ source $stdenv/setup
$ genericBuild
```
Pour faire une seule phase
``` nix
phases="buildPhase checkPhase" genericBuild
```

NB: on peut faire aussi
``` nix
[nix-shell]$ eval ${unpackPhase:-unpackPhase}
[nix-shell]$ cd source
[nix-shell]$ eval ${configurePhase:-configurePhase}
[nix-shell]$ eval ${buildPhase:-buildPhase}
```


## Ressources
- [Source](https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages)
- <https://nixos.wiki/wiki/Packaging/Tutorial> 
- [[nixpkgs]]

