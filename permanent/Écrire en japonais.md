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
