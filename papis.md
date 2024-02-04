Guide
https://gist.github.com/avonmoll/e435f0e478fbdc6c1eee7557b221a7e2

Ajouter un pdf et un DOI
 p add ~/Downloads/vcfeval.pdf --from doi 10.1101/023754

Il vaut mieux utiliser le DOI que l'url (éviter des problèmes sur le type d'article et de ne pas avoir la date )

Pour vérifier avant l'export bibtex

  papis doctor --explain --check bibtex-type <QUERY>
