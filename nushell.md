# Utilisation
Lister nom de colonnes

    open lol.csv | columns

# Intégration

## Emacs et tramp

Pour forcer tramp à utiliser bash

    SHELL="/bin/bash" ~/.emacs.d/bin/doom env

## Python avec virtual env

Installer virtualenv, exemple avec \`emerge virtualenv\` puis

    virtualenv myenv
    overlay use myenv/bin/activate.nu
    pip install osmnx

# Exemples de scripts

## Pandoc sur une liste de fichier

org -\> markdown

``` nu
ls *.org  | each {|e| pandoc $e.name -o $"($e.name | path parse | get stem).md"}
```

## Lister tous les IDs des csv et faire l'intersection avec les ID des pdfs

``` nu
ls excel = (ls S:genetique\commun\Centogene_variants\excel | get name | path basename | path parse | get stem | parse "{id}_{s}" | get id)
let patho = (open patho.csv | get id)
$excel | append $patho | uniq -d
```

## Génerer une liste de fastq en les groupant par nom de dossier

List all fastq, then generate a column containing the file and dirname.
Groupy by directory, extract record values input a table. Filter folders
with less than 2 files. Concatenante the files and save the result into
a txt file (.csv does not work)

``` {.bash org-language="sh"}
ls fastq/*/*.fastq.gz | select name | insert dir { $in.name | path dirname }  | group-by dir  | values | where ($in | length) > 1 | each { $in.name | str join ',' } | save input.txt
```

Version plus évoluée:

``` {.bash org-language="sh"}
def annotate [] { insert dir { $in.name | path dirname | path basename }  | insert file { $in.name | path basename } | insert id { $in.name | patientID }}
def patientID [] { path basename | split row '_R' | first }
def toCSV [d] { $d.name | insert 0 ($d.dir | first) | insert 1 ($d.id | first) | str join ',' }

ls fastq/*/*.fastq.gz | select name | annotate  | group-by dir | values | where ($in | length) > 1 | each { toCSV $in } | save -f input.txt

```

Générer une liste de tâches à partir d'un alphabet et d'un index

    
    seq char E Z | enumerate | each {|it| t add pro:seedbox.seedhost $"Ajouter ancient torrents ($it.item)" $"wait:+($it.index + 1)d" $"sched:+($it.index + 1)d" }
