# Cabal2nix

Après avoir créé un fichier .cabal, mettre dans \`default.nix\`

``` {.bash org-language="sh"}
let
  pkgs = import <nixpkgs> { }; # pin the channel to ensure reproducibility!
in
pkgs.haskellPackages.developPackage {
  root = ./.;
}
```

L\'exécutable est généré par \`nix-build\`. Pour débugger avec ghci,

``` {.bash org-language="sh"}
nix-shell
$ ghci
ghci:> :l app/Main.hs
```
