# Installation

## Gentoo
rust-bin n'est pas assez à jour pour polars (2024-03-28) donc on passe virtual/rust en testing

/etc/portage/packages.accept_keyword/rust:
virtual/rust ~amd64
dev-lang/rust-bin ~amd64

## Rustup
Autre solution.  Il faut rajouter rust-analyzer pour helix

    rustup component add rust-analyzer

# Librairies

Machine learning : https://github.com/rust-ml/linfa

# Développement
## Tester crates 
cargo test
cargo clippy
cargo test

# latest version
