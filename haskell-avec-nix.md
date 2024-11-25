
# Cabal2nix


Après avoir créé un fichier .cabal, mettre dans `default.nix`

```nix
let
pkgs = import <nixpkgs> { }; # pin the channel to ensure reproducibility!

gs.haskellPackages.developPackage {
root = ./.;

```

L'exécutable est généré par `nix-build`. Pour débugger avec ghci,

```
nix-shell
$ ghci
ghci:> :l app/Main.hs
```
