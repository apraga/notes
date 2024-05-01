#éditeur

# Astuces

## Evil

Sortir du mode \"insert\" en bepo : \"gq\" après un espace (important )

## Accent issues when pasting from clipboard (Windows)

C-x RET x (set-selection-coding-system) and choose utf-16-le

## Jump to and from function definition

M-. (xref-pop-marker-stack): jump to definition M-?
(xref-find-references): find all occurences M-, (xref-find-definitions):
q

## Override completion

C-j pour ne pas utiliser le premier résultat

# SSH, FTP, sudo

`SPC f f`{.verbatim} then

``` {.bash org-language="sh"}
/protocol:user@host:/file.txt
```

For SSH (with an alias)

``` {.bash org-language="sh"}
/ssh:myalias:
```

Without an alias

``` {.bash org-language="sh"}
/ssh:john@myhost:/home/john/
```

## With fish shell

ssh can hang so I follewed [this
advice](https://github.com/oh-my-fish/theme-bobthefish/issues/148) ) and
set in \~/.config/fish/fish.config

``` example
if test &quot;$TERM&quot; = &quot;dumb&quot;
    exec sh
end
```

For faster access, set a bookmark to the folder \<3 Otherwise it\'s a
bit annoying to type

# Eshell

C-c M-b pour completer un buffer (utile pour redirection)

``` example
rga &quot;test&quot; lol.pdf &gt;
```

# Grep + sed

Search and edit with ripgrep directly in the result !

1.  search with ripgrep, for example with \`SPC s p\`
2.  Put the results in a buffer with \`C-c C-o\` (\`ivy-occur\`)
3.  Edit the buffer with \`i\` (\`ivy-wgrep-change-to-wgrep\`)

# Calc

Embedded-mode : évalue formule sous le curseur

# Mail with mbsync

! Got several \"duplicate ID\" after using a systemd service. It\'s due
to moving files (my version of archiving) and the naming scheme. We must
use the \"alternate\" naming scheme to avoid duplicates. Seems to work
NB: we should explain with gmail

Mbsync is really faster when fetching mails the first time.Afterwards,
I\'m not sure the gain is worth it

# Écrire en japonais {#post-config-en-jap-sur-emacs}

mozc is too slow in doom emacs =\> activate japanese instead

# Torrents with emacs

## What works

Nginx + URL

``` example
server {
    listen       8000;
    server_name  localhost;

    access_log  /var/log/nginx/rtorrent_access.log;
    error_log  /var/log/nginx/rtorrent_error.log;

    location /RPC2 {
        root /torrents;
        # auth_basic &quot;Restricted&quot;;
        # auth_basic_user_file /etc/nginx/.htpasswd;
        scgi_pass   127.0.0.1:5000;
        # scgi_pass   unix:/torrents/rtorrent.sock;
        include     scgi_params;
    }
```

And for rtorrent

``` example
network.scgi.open_port = 127.0.0.1:5000
```

And in emacs

``` example
(setq mentor-rtorrent-external-rpc &quot;http://127.0.0.1:8000/RPC2&quot;)
```

## More secure : with a socket

We create a group to be able to write the socket

``` example
sudo groupadd rtorrent-socket
sudo gpasswd -a alex rtorrent-socket
sudo gpasswd -a nginx rtorrent-socket
sudo chown -R nginx:rtorrent-socket /torrents/
sudo chmod 775 -R /torrents/
su - alex # To be able to start
```

Rtorrent : hack we need to change both ownership and permissions +
daemon mode

``` example
# For use with emacs with the mentor package
network.scgi.open_local = /torrents/rtorrent.sock

# Change ownership to propergroup
schedule2 = scgi_permission1, 0, 0, &quot;execute.nothrow=chown,alex:rtorrent-socket,/torrents/rtorrent.sock&quot;
# Make SCGI socket group-writable and secure
schedule2 = scgi_permission2, 2, 0, &quot;execute.nothrow=chmod,770,/torrents/rtorrent.sock&quot;

system.daemon.set = true
```

Emacs

``` example
(setq mentor-rtorrent-external-rpc &quot;/torrents/rtorrent.sock&quot;)
```

Update : it seems to work without nginx with a socket ??

# Org mode

## Wrap selection into an org-block

org-insert-structure-template C-c C-, s

## Latex :

Bibliography: Ajouter dans le header

``` org
#+bibliography: memoire.bib
```

Glossaries: Avec latexmk, il faut une configuration spéciale dans
.latexmkrc

``` {.bash org-language="sh"}
add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
$clean_ext .= " acr acn alg glo gls glg";

sub makeglossaries {
     my ($base_name, $path) = fileparse( $_[0] );
     my @args = ( "-q", "-d", $path, $base_name );
     if ($silent) { unshift @args, "-q"; }
     return system "makeglossaries", "-d", $path, $base_name;
 }

```

## lulatex {#utiliser-lulatex}

; lualatex preview (setq org-latex-pdf-process \'(\"lualatex
-shell-escape -interaction nonstopmode %f\" \"lualatex -shell-escape
-interaction nonstopmode %f\")) (Attention à l\'ordrer)

## Org-roam
Transformer un titre en noeud SPC m I ou org-id-create

Gérer plusieurs dossiers (privé + public)

1.  Plusieurs dossier avec .dirs.el (cf documentation officielle)
2.  Faire des liens symbolique dans un dossier `roam` et utiliser des
    tags + des capture pour chaque

# Haskell

Mode mal documenté (avec lsp) C-c C-l pour charger code dans ghci C-c
C-z si on perd le popup

# Misc

yas-describe-tables to see snippets

# Presentation

## org mode -\> beamer

## org-mode -\> reveal.js

``` example
REVEAL_TRANS
#+OPTIONS: toc:nil
#+OPTIONS: reveal_width:2100 reveal_height:1000
#+REVEAL_TRANS: nil
\****** TODO DP 1
\******  DP1
\******  homme de 54 ans, tabagique au long cours et hypertendu depuis 12 ans (traitement par inhibiteur calcique), consulte
\****** n médecin traitant pour un épisode isolé d'hématurie macroscopique totale, sans caillot. Il a pour autre antécédent une
\****** pendicectomie dans l'enfance. L'hémogramme est le suivant : Hb 10,4 g/dL (VGM 78 µm3), GB 8 G/L, plaquettes 247
```

Puis SPC m e v b

# Tramp

SSH + sudo : /<ssh:you@remotehost%7Cdoas>:: ou
/<ssh:you@remotehost%7Csudo>::

Sauvegarder session :

<https://emacs.stackexchange.com/questions/26560/bookmarking-remote-directories-trampsudo>
(add-to-list \'tramp-default-proxies-alist \'(\"\\\\\`mydomain\\\\\'\"
\"\\\\\`root\\\\\'\" \"/sshx:user@%h:\"))

## Difficulté avec projectile

Il faut les executabs sur la machirne distance (fd et rg) Pour nix, on
peut éditer le bashrc distant et ajouter

``` {.commonlisp org-language="lisp"}
(after! tramp
      (add-to-list 'tramp-remote-path 'tramp-own-remote-path))
```

En cas de couleur \"intempestive\", on peut forcer fd à ne pas utiliser
de couleurs:

(setq projectile-git-fd-args \"-0 -H --color=never --type file --exclude
.git --strip-cwd-prefix\")

Puis vider le cache avec SPC p i

# Useful shortcuts (doom emacs) {#useful-shortcuts id="57421762-b8ef-46dd-9145-5152551b81c3"}

-   SPC c d jump to definition
-   C-o to go back after jumping
-   C-x C-q in dired to edit the buffer as text \<3

# Useful shortcut (vanilla emacs )

-   C-x z to repeat last command, then z (like vim \".\")

Not so useful

-   C-x right/left arrow to switch buffer (I\'m not really using it)

# Post sur facebook messenger inside emacs

Requirements

-   bitlbee
-   erc
-   bitlbee-facebook

Config

``` {.commonlisp org-language="lisp"}
  ;; ---- ERC
;; A helper function to auto-start bitlbee
(defun bitlbee-start ()
  (interactive)
  (erc :server "localhost" :port 6667 :nick "alex" :password "sharingan"))

;; Here we start ERC at boot, with the password here for minimal coding
(use-package! erc
  ;; Bitlbee by default
  :commands (bitlbee-start)
  :config
  ;; Autojoin must be done inside bitlbee directly
  (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
)
```

LISP

Result

M-x bitlbee-start start bitlbee. You need to follow these instuctions
<https://wiki.bitlbee.org/HowtoFacebookMQTT> \> account add facebook
\<email\> \<password\> \> account facebook on \> fbjoin facebook
\<index\> \<channel\> The index is given either by fbchats facebook or
must be copying manually from facebook

If you want to autojoin a channel, it must be done in bitlbee direcly
channel blabla set auto~join~ true NB the config file are most likely in
/var/lib/bitlbee/\$USER.xml

# IRC

Doom-emacs utilise circe, à démarrer avec `=irc` (et non circe)

# Emacs et EDITOR

EDITOR=\"emacsclient -c\" Ne pas utiliser l\'option -n
