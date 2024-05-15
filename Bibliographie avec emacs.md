#emacs #bibliographie

Note: on utilise maintenant papis en ligne de commande. Sauvegardé pour raisons historiques.

On utilise citar
- définir 
```lisp
(setq citar-library-paths \'(\"\~/papers/bisonex\"))
```
Pour ouvrir les pdfs,  citar-open-files va les ouvrir s'ils sont només $key.pdf.

Pour annotater la bibliographie, on a testé un seul fichier org-mode, [comme ceci](http://www.cachestocaches.com/2020/3/org-mode-annotated-bibliography/)
Le fichier .bib est généré avec `org-tangle`

Dans un second temps, org-roam + citar.  `SPC m @` permet
- de créer une note org-roam
- d'ouvrir le pdf (s'il est dans citar-library-paths et nommé $key.pdf)



