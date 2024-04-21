```{=org}
#+filetags: nix
```
# Projet en Python

Instructions simples ici :
<https://nixos.wiki/wiki/Python#Package_and_development_shell_for_a_python_project>

Il faut donc setup.py:

``` python
#!/usr/bin/env python

from setuptools import setup, find_packages

setup(name='demo-flask-vuejs-rest',
      version='1.0',
      # Modules to import from other scripts:
      packages=find_packages(),
      # Executables
      scripts=["web_interface.py"],
     )
```

Et 2 fichiers .nix, le premier pour les dépendances

``` {.bash org-language="sh"}
{ lib, python3Packages }:
with python3Packages;
buildPythonApplication {
  pname = "demo-flask-vuejs-rest";
  version = "1.0";

  propagatedBuildInputs = [ flask ];

  src = ./.;
}
```

et le défaut

    { pkgs ? import <nixpkgs> {} }:
    pkgs.callPackage ./derivation.nix {}

Il ne reste plus qu'à le construire

    nix-build
    result/bin/lol.py

# Python libraries

On package l'exécutable python avec les libraries. Mettre dans
`default.nix`{.verbatim}

``` nix
with (import <nixpkgs> {});
let
  my-python-packages = python-packages: with python-packages; [
    pandas
    requests
    # other python packages you want
  ];
in
python3.withPackages my-python-packages
```

Puis

``` {.bash org-language="sh"}
nix-build default.nix
result/bin/python
>>> import pandas
```

Si on veut juste un shell, mettre dans `shell.nix`{.verbatim}

``` {.bash org-language="sh"}
{ pkgs ? import <nixpkgs> {} }:
let
  my-python-packages = ps: with ps; [
    pandas
    pysam
    # other python packages
  ];
  my-python = pkgs.python3.withPackages my-python-packages;
in my-python.env

```
