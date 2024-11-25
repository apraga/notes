
De même que R, il faut packager R avec les librairies

```nix
with (import <nixpkgs> {});
let
  my-r-packages = rWrapper.override{packages = with rPackages; [
plotly
  ];};
in
my-r-packages
```
