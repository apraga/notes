#bibliographie #cli

[Guide](https://gist.github.com/avonmoll/e435f0e478fbdc6c1eee7557b221a7e2)

Pour ajouter un article,  il vaut mieux utiliser le DOI que l'url (éviter des problèmes sur le type d'article et de ne pas avoir la date )

Ajouter un pdf et un DOI
```sh
papis add ~/Downloads/vcfeval.pdf --from doi 10.1101/023754
```
Pour vérifier avant l'export bibtex
```sh
papis doctor --explain --check bibtex-type <QUERY>
```
Exporter en bibtex
```sh
papis export --all --format bibtex project:pterodactyl-migration > bibliography.bib
```
Voir la citation au format bibtex pour l'entrée "guix"
```
papis list --format '{doc[ref]}' guix
```
