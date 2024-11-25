

# Modèle

dans python-modules/MYPACKAGE/default.nix
```nix
{
config,
lib,
pkgs,
typeguard,
buildPythonPackage,
packaging,
pythonAtLeast,
fetchFromGitHub,
setuptools,
wheel,


ildPythonPackage rec {
pname = "tensorflow-addons";
version = "0.23.0";

disabled = pythonAtLeast "3.12";

src = fetchFromGitHub {
  owner = "tensorflow";
  repo = "addons";
  rev = "v${version}";
  sha256 = "sha256-2tIZsbB33JlSlvJ2QcE1s6l+G0NYt37V+nVII64qduQ=";
};

dependencies = [
  typeguard
  packaging
];

pyproject = true;
build-system = [
  setuptools
  wheel
];

```
Puis l'ajouter dans pkgs/top-level/python-packages.nix

# Forcer la version d'une dépendence

```nix
let
netaddr_0_8_0 = netaddr.overridePythonAttrs (oldAttrs: rec {
  version = "0.8.0";

  src = fetchPypi {
    pname = "netaddr";
    inherit version;
    hash = "sha256-1sxXx6B7HZ0ukXqos2rozmHDW6P80bg8oxxaDuK1okM=";
  };
});

```
