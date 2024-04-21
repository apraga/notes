```{=org}
#+filetags: emacs
```
# Bibliographie annotée {#bibliographie-annotée id="2abb4210-0777-427c-8655-83306186c18c"}

3 possibilités d\'avoir une bibliographie annotée

## Avec citar:

Il faut un fichier bibtex contenant les citations. Lorsqu\'on insère une
citation, on peut créer une note (dans citar-notes-paths) pour cet
article avec \"entrée\" S\'il y a un asticle correspondant dans
citar-library-paths, on peut également l\'ouvrir. Exemple

``` org
\* Research1
- [cite:@saffari2001] Best review
- [cite:@adang200] First review
```

Inconvénient: pour chercher les notes, il faut un fichier org qui
regroupe les citations par catégories.

Configuration

``` {.commonlisp org-language="lisp"}
(after! citar
  (setq! citar-bibliography '("~/roam/research/biblio.bib" "~/roam/research/bisonex/thesis/biblio.bib")
         citar-library-paths '("~/papers/bisonex")
         citar-notes-paths '("~/roam/research/references")
         citar-org-roam-subdir "~/roam/research/references/")))
```

Dans le fichier, il faut

``` org
#+bibliography: memoire.bib
```

## Org-mode tangle

Voir
<https://cachestocaches.com/2020/3/org-mode-annotated-bibliography/>

## Org-mode directement avec org-bibtex

On récupère le bibtex avec notre function. Puis il faut couper le bloc
bibtex (d% avec evil) et le transformer en entrée \"org-mode\" avec
org-bibtex-yank Il faut exporter le tout en bibtex avec org-bibtex

+: formattage org-mode

# Dired

( pour voir les détails ) pour voir les infos git

# Latex export

Utiliser :booktabs t pour avoir des jolies tableaux. Apparement, il
suffit de rajouter le package dans les header

``` org
#+latex_header: \usepackage{booktabs}

#+ATTR_LATEX: :booktabs t
| Disease | Gene | Onset | Symptoms | MRI |
|---------+------+-------+----------+-----|
| lol     |      |       |          |     |
```

[Org-mode](id:ed20c9d9-423f-4430-8eb8-d22b3ba14980)
