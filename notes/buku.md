Ajouter un lien avec des tags
```bash
buku -a http://lol.html tag1,tag2
```

Idem avec titre
```bash
buku -a http://lol.html --title Test
```

Chercher par mot-clé
```bash
buku -s context
```

Ouvrir un lien
```bash
buku -s context
$ 1
```
où 1 est le numéro du résultat

Editer un bookmark
```bash
buku -w 320
```

Mettre à jour le titre
```bash
buku -u 320 --title "Nouveau titre"
```

Chercher par tag
```bash
buku neovim
```

Exporter en markdown
```bash
cd ~/.local/share/buku ; buku -e bookmarks.md; git add bookmarks.md; git commit -am "Save"; git push
```
