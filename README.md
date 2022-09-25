A blog with [Hakyll](https://jaspervdj.be/hakyll/) + [Nix](https://nixos.org), with the template from [rpearce template](https://github.com/rpearce/hakyll-nix-template).

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

# How to use it

Install dependancies and build the executable , and generate the site with

    nix run . build

Make it local :

    nix run . watch


# Structure
- [](blog) contains the rules for Hakyll to generate the static content
- [](posts) contains a list of post in org-mode. Blog posts need a date in their title !
- Nix configuration :
    - [](flake.nix) : create an application to run the blog
    - [](haskell-overlay.nix) : define a derivation to build the blog 
