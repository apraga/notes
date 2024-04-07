# Ajouter un nouveau paquet

Les nouveaux paquets sont dans pkg/by-name

<https://nixos.wiki/wiki/Nixpkgs/Contributing> 

1. Tester dans nixpkgs qu'il compile
``` sh
nix-build -A mypackage
```
2. Vérifier le formattage et la configuration de l'éditeur aec  editorconfig-checker et nixfmt (le second est nixfmt-rfc-style dans nixpkgs)
3. Tester les dépendances
``` {.bash org-language="sh"}
nix-shell -p nixpkgs-review --run "nixpkgs-review rev HEAD"
```

Regarder les variables d\'environement :

``` {.bash org-language="sh"}
env
```

# Débugger un paquet

``` {.bash org-language="sh"}
cd nixpkgs
mkdir lol
cd lol
nix-shell ../ -A kent
```

Le plus simple est d\'utiliser genericBuild avec les différentes phases,
exemple :

``` {.bash org-language="sh"}
phases="checkPhase installPhase" genericBuild
```

Liste des phases : unpackPhase patchPhase configurePhase buildPhase
checkPhase installPhase fixupPhase installCheckPhase distPhase

Voir : <https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages>

