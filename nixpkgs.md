# Bonnes pratiques

- nixfmt
- commit: attention à bien respecter "$PACKAGE: init at $VERSION"
```sh
nix-shell -p nixpkgs-review --run "nixpkgs-review rev HEAD"
```


## Divers

- `install -Dm755` plutôt que `mkdir -p $out/bin ; cp ropebwt2 $out/bin`
- éviter `with lib`

# tester



## Cross-compilation 

aarch64-linux:
```sh
nix-build -A pkgsCross.aarch64-multiplatform.hello-cpp
```



# A lire Référence

https://github.com/NixOS/nixpkgs/blob/master/pkgs/README.md

# Astuce

Si gcc est écrit en dur dans un makefile et qu'il ne compile pas sur aarch64:
```nix
makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" ];
```
