# Ebuild

Tester avec
```
pkgcheck scan
```
Commiter avec 
```
git commit -S -m "lol"
```


## Julia

### Test

- Figures thèse
- GTK (tutorial
```
> add Gtk
win = GtkWindow("My First Gtk.jl Program", 400, 200)

b = GtkButton("Click Me")
push!(win,b)

showall(win)
push!(win, b)
```
- DiscreteTime
```
using DiscreteMarkovChains

transition_matrix = [
0.0 1.0 0.0;
0.5 0.0 0.5;
0.0 1.0 0.0;
]
chain = DiscreteMarkovChain(transition_matrix)
is_absorbing(chain)
```

### Julia 1.10.0

Erreur avec ebuild install :
```
/var/tmp/portage/dev-lang/julia-1.10.0/work/julia-1.10.0/deps/tools/jldownload "/var/tmp/portage/dev-lang/julia-1.10.0/work/julia-1.10.0/deps/srccache/UnicodeData-13.0.0.txt" https://www.unicode.org/Public/13.0.0/ucd/UnicodeData.txt
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
Dload  Upload   Total   Spent    Left  Speed
0     0    0     0    0     0      0      0 --:--:--  0:00:04 --:--:--     0curl: (6) Could not resolve host: cache.julialang.org
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
Dload  Upload   Total   Spent    Left  Speed
0     0    0     0    0     0      0      0 --:--:--  0:00:04 --:--:--     0curl: (6) Could not resolve host: www.unicode.org
```
  Mais lancer la commande à la main fonctionne...  

```
Building HTML documentation.
/var/tmp/portage/dev-lang/julia-1.10.0/work/julia-1.10.0/usr/bin/julia --startup-file=no --color=yes /var/tmp/portage/dev-lang/julia-1.10.0/work/julia-1.10.0/doc/make.jl linkcheck= doctest= buildroot=/var/tmp/portage/dev-lang/julia-1.10.0/work/julia-1.10.0 texplatform= revise=
Installing known registries into `/var/tmp/portage/dev-lang/julia-1.10.0/work/julia-1.10.0/doc/deps`
┌ Warning: could not download https://pkg.julialang.org/registries
│   exception = RequestError: Could not resolve host: pkg.julialang.org while requesting https://pkg.julialang.org/registries
└ @ Pkg.Registry /var/tmp/portage/dev-lang/julia-1.10.0/work/julia-1.10.0/usr/share/julia/stdlib/v1.10/Pkg/src/Registry/Registry.jl:69
┌ Warning: could not download https://pkg.julialang.org/registries
│   exception = RequestError: Could not resolve host: pkg.julialang.org while requesting https://pkg.julialang.org/registries
└ @ Pkg.Registry /var/tmp/portage/dev-lang/julia-1.10.0/work/julia-1.10.0/usr/share/julia/stdlib/v1.10/Pkg/src/Registry/Registry.jl:69
Cloning registry from "https://github.com/JuliaRegistries/General.git"
ERROR: LoadError: failed to clone from https://github.com/JuliaRegistries/General.git, error: GitError(Code:ERROR, Class:OS, failed to connect to github.com: Network is unreachable)
```