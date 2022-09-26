{
  description = "hakyll-nix-template";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { flake-utils, nixpkgs, self }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        config = {};
        overlays = [ (import ./haskell-overlay.nix) ];
        pkgs = import nixpkgs { inherit config overlays system; };
      in rec {
        packages = with pkgs.myHaskellPackages; { inherit blog blog-nix; };

        defaultPackage = packages.blog-nix;

        apps.default = flake-utils.lib.mkApp {
          drv = packages.blog;
          exePath = "/bin/hakyll-site";
        };

        devShell = pkgs.myHaskellPackages.shellFor {
          packages = p: [ p.blog ];

          buildInputs = with pkgs.myHaskellPackages; [
            blog
            # Helpful tools for `nix develop` shells
            #ghcid                   # https://github.com/ndmitchell/ghcid
            #haskell-language-server # https://github.com/haskell/haskell-language-server
            # hlint                   # https://github.com/ndmitchell/hlint
            #ormolu                  # https://github.com/tweag/ormolu
          ];
        };
      }
    );
}
