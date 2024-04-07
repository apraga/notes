```{=org}
#+filetags: cs
```
# Nixos

Installer nix. Par exemple, sous WSL:
<https://github.com/nix-community/NixOS-WSL>

Puis modifier /etc/nixos/configuration.nix.

## 1. Emacs nativecomp + flakes + WSL

Il faut rajouter un overlay. Cela va compiler emacs

``` {.bash org-language="sh"}
{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  nixos-wsl = import ./nixos-wsl;
in
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"

    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "nixos";
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker.enable = true;
  };

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Emacs28 with nativecomp
  services.emacs.package = pkgs.emacsNativeComp;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  environment.systemPackages = with pkgs; [
          emacsNativeComp
  ];
}
```

Puis installer avec

    nixos-rebuild switch

## 2. Ajouter des logiciels au niveau global

il sufit de modifier

    environment.systemPackages

et de lancer ensuite

``` {.bash org-language="sh"}
nix-os rebuild switch
```

NB: il manque man par défaut !. Doc officielle :
<https://nixos.org/manual/nixos/stable/>

## Suive avancement des branches (unrstable, stable...)

Plusieurs possibilités

1.  <https://nixpk.gs/pr-tracker.html?pr=188777>
2.  <https://status.nixos.org/>
3.  Simply clicking on a commit on GitHub shows branches and tags
    containing that commit.

# Nix {#nix-1}

Activer les flakes (experimental) ! Meilleure expérience utilisateur

## WSL2: changer /nix/store

Pour accéder à un lecteur US:, rajouter dans /etc/fstabl

``` {.bash org-language="sh"}
E: /mnt/e drvfs defaults,uid=1000,gid=1000,metadata 0 0
```

\`metadata\` est important car cela nous permet de changer les
permissions ! Puis

``` {.bash org-language="sh"}
mount --bind /mnt/e/nix /nix
```

## Recherche

\`nix-env\` est lent. \`nix search\` avec les flakes ne fonctionne pas
bien pour certains packages (récursif mais certains paquets désactivent
l'évalution) Meilleures solution :

-   search.nixos.org
-   \`nix-index\` : installer puis \`nix-indx\` puis chercher par nom de
    ficher. Ex: \`nix-locate bin/R\`

## Développer un package

### Hash

    nix-prefetch-url --unpack https://...tar.gz

Ou bien, ne pas mettre de hash et copier le résultat de l'erreur !

### Débugger

[Source](https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages)
<https://nixos.wiki/wiki/Packaging/Tutorial> Pour nixpkgs, voir
[*Débugger un paquet*]{.spurious-link target="*Débugger un paquet"} Sans
Flakes

``` nix
nix-shell -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'
```

Avec Flakes

``` nix
nix develop .#my-package
```

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

## Pour installer une seule dérivation

    nix-shell -p 'with import <nixpkgs>{}; callPackage pkgs/GenomeRef.nix {}'

Ne pas oublier {}

## Upgrade

Après avoir ajouté un channel:

nix.package = (import \<nixos-unstable-small\> {}).nix

## Patcher

    nixpkgs.overlays = [
      # Patch to avoid out-of-memory errors in nix
      (final: prev: {
        nix = prev.nix.overrideAttrs (old: {
          patches = (old.patches or []) ++ [./0001-don-t-read-outputs-into-memory-for-output-rewriting.patch ];
        });
      })
      ] ;

## Nix profile

(Il faut choisir entre nix profile et nix-env !) Cherche un programme,
l'installer Installer un programme

``` {.bash org-language="sh"}
nix profile search nixpkgs#zoxide
nix profile install nixpkgs#zoxide
```

Tout supprmier

``` {.bash org-language="sh"}
nix profile remove '.*'
```

### Avec nushell

Il faut parfois mettre des guillemets, ex:

    nix profile install "nixpkgs#cabal-install"
# Aide

## Paquet non trouvé \"attribute is missing\"

Ex: nix-shell -p rPackages.BSgenome~HsapiensUCSChs1~ error: attribute
\'BSgenome~HsapiensUCSChs1~\' missing

1.  Mettre à jour le channel
2.  Sinon attention à la différence entre le channel de l\'utiliser et
    du root. Par défaut, le channel de l\'utilisateur n\'est pas utilisé
    sauf si la configuration utilise \<stable\>. Le channel par défaut
    est nixpkgs (sinon nixos) !!

# Avertissements

Ne jamais modifier les fichiers dans /nix/store

# Langage

[Python Nix](id:f72cd4cf-c1ce-48ab-86df-50c0f2a850bd) [R
Nix](id:ca9c0bc4-c72a-41b9-934c-5858ed11e1eb) [Haskell
Nix](id:39c6a7a1-39ea-45f9-a647-6119b3f56837)

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
