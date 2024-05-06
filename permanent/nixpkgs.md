#nix
# Nouveau paquet

https://github.com/NixOS/nixpkgs/blob/master/pkgs/README.md

## Bonnes pratiques
- Formatteur officiel (en cours d'adoption le 28 mars 2024, https://discourse.nixos.org/t/call-for-testing-nix-formatter/39179/5)
```sh
nix profile install nixpkgs#nixfmt-rfc-style
nixfmt package.nix
```
- éviter `rec` : `finalAttrs` plutôt https://nixos.org/manual/nixpkgs/unstable/#mkderivation-recursive-attributes
- Source
	- mettre`pname` en dur dans `fetchFromGithub` https://github.com/nix-community/nixpkgs-lint/issues/21
	- utiliser `hash` plutôt que `sha256` https://nixos.org/manual/nixpkgs/stable/#fetchurl
	- version = "unstable-YYYY-MM-DD" s'il n'y a pas de version
## Variables
- nativeBuildInput : si exécuté durant le build (ex: cmake)
- buildInputs : si utilisé à l'exécution ou ajouté dans la sortie (ex: zlib). Attention, il peut falloir ajouter aux 2 !
## Tests
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


[Débugger un paquet nix](Débugger%20un%20paquet%20nix.md)


# Astuces
## Problèmes de drivers graphiques
Utiliser nixGL https://github.com/nix-community/nixGL si l'on n'utilise pas nixos.
