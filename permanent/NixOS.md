Installer nix. Par exemple, sous WSL: <https://github.com/nix-community/NixOS-WSL>
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

## Suivre avancement des branches (unrstable, stable...)

Plusieurs possibilités

1.  <https://nixpk.gs/pr-tracker.html?pr=188777>
2.  <https://status.nixos.org/>
3.  Simply clicking on a commit on GitHub shows branches and tags
    containing that commit.
