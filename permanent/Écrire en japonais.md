#jap

On utilise ibus et anthy. Après installation, rajouter dans `.xinitrc`

```sh
export GTK~IMMODULE~=ibus
export XMODIFIERS=@im=ibus 
export QT~IMMODULE~=ibus
ibus-daemon -drx
```

Éditeur
- Emacs : Ne fonctionne pas ?? On peut changer set-input-method et mettre en japonaisEmacs: 
- Hélix : Fonctionne mais quelques soucis avec zellik
## Neovim
Japanese SKK est une possibilité mais en pratique, ne fonctionne pas bien pour les verbes (de mon expérience). Le plus simple  est d\'utiliser ibus et un terminal qui supporte ça (st par exemple).
Pour kitty, il faut démarry kitty avec
``` example
sh -c "GLFW_IM_MODULE=ibus kitty"
```
cf <https://github.com/kovidgoyal/kitty/issues/469>
