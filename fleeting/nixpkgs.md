# Ajouter un nouveau paquet

https://github.com/NixOS/nixpkgs/blob/master/pkgs/README.md

- Formatteur officiel (en cours d'adoption le 28 mars 2024, https://discourse.nixos.org/t/call-for-testing-nix-formatter/39179/5)
```sh
nix profile install nixpkgs#nixfmt-rfc-style
nixfmt package.nix
```
Les nouveaux paquets sont dans pkg/by-name
Tester dans nixpkgs qu'il compile 
```
nix-build -A mypackage
```
Tester les dépendances 
```
nix-shell -p nixpkgs-review --run "nixpkgs-review rev HEAD"
 ```
Regarder les variables d\'environement :
```
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


# Astuces
## Problèes de driver
Utiliser nixGL https://github.com/nix-community/nixGL si l'on n'utilise pas nixos.
