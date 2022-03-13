# Vim et japonais
===============

Avec neovim \# Japanese SKK est une possibilité mais en pratique, ne
fonctionne pas bien pour les verbes (de mon expérience) Voir ci-dessous
pour les curieux. Le plus simple est d'utiliser ibus et un terminal qui
supporte ça (st par exemple). 

Pour kitty, il faut démarry kitty avec 

     sh -c "GLFW_IM_MODULE=ibus kitty"
cf https://github.com/kovidgoyal/kitty/issues/469

## Installation skk

Install eskk et un dictionnaire (ex: `pkg install ja-skk` Puis <c-j>
Nihonn <space> Il faut une majuscule pour avoir les kanjis ! Source:
<https://vi.stackexchange.com/questions/8733/can-i-write-japanese-skk-text-in-vim>
Et si le mot contient un mélange de kanji et d'hiragana, il faut
rebasculer en majuscule Ex: SuWanai NB: on peut utiliser ";". Ex:
;su;wanai

# Vimwiki
Créer un post-commit hook (.git/hooks/post-commit)

# Articles avec vim
vim-pandoc donne la complétion de la biblio avec C-x C-o
Il y a des conflits avec vim wiki
