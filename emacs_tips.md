Jump to and from function definition
====================================

M-. (xref-pop-marker-stack): jump to definition M-?
(xref-find-references): find all occurences M-, (xref-find-definitions):
q

SSH, FTP, sudo
==============

Use tramp With fish shell, sSh can hangs so I follewed [this
advice](https://github.com/oh-my-fish/theme-bobthefish/issues/148)
(TODO: send a mail about it) and set in \~/.config/fish/fish.config

    if test &quot;$TERM&quot; = &quot;dumb&quot;
        exec sh
    end

For faster access, set a bookmark to the folder \<3 Otherwise it\'s a
bit annoying to type

Eshell
======

C-c M-b pour completer un buffer (utile pour redirection)

    rga &quot;test&quot; lol.pdf &gt;

Grep + sed
==========

Search and edit with ripgrep directly in the result !

1.  search with ripgrep, for example with \`SPC s p\`
2.  Put the results in a buffer with \`C-c C-o\` (\`ivy-occur\`)
3.  Edit the buffer with \`i\` (\`ivy-wgrep-change-to-wgrep\`)

Calc
====

Embedded-mode : évalue formule sous le curseur

Mail with mbsync
================

! Got several \"duplicate ID\" after using a systemd service. It\'s due
to moving files (my version of archiving) and the naming scheme. We must
use the \"alternate\" naming scheme to avoid duplicates. Seems to work
NB: we should explain with gmail

Mbsync is really faster when fetching mails the first time.Afterwards,
I\'m not sure the gain is worth it

KILL Gnus
=========

KILL Global
-----------

A bit slow with imap Offline usage : notmuch does not work ... See
<https://ding.gnus.narkive.com/kJo5yKca/nnir-and-notmuch> We have to use
mairix

But works well with news !
<https://emacs.stackexchange.com/questions/38739/how-can-i-subscribe-to-se-rss-feed-using-gnus>
In the end, slower than notmuch inside emacs (start + search) but I
prefer it to read news. Trying it at the moment

KILL Mairix config
------------------

Mairixrc

    base=~/Mail/
    maildir=gmail/inbox:gmail/archive:free/inbox:free/archive:archive
    mformat=maildir
    database=~/.mairix/database
    mfolder=~/.mairix/mfolder

Warning: not recursive !

Follow the manual instruction. Important: do not answer \"no\" for
hidden folder (maildir++) !

    (setq user-mail-address#&quot;XX&quot;
          user-full-name#&quot;Alexis Praga&quot;)

    (setq gnus-select-method '(nnnil &quot;&quot;))
    (setq gnus-secondary-select-methods
          ;; Reading FSS feeds (not all of them works)
          '((nntp &quot;news.gwene.org&quot;)
    ;; Too slow, we prefer notmuch
             (nnmaildir &quot;free&quot;
                        (directory &quot;~/Mail/free/&quot;))
             (nnmaildir &quot;gmail&quot;
                        (directory &quot;~/Mail/gmail/&quot;)))))


    ;; Does not work
    ;;(setq nnir-search-engine 'notmuch)
    ;; This start a notmuch request but with the wrong arguments...
    ;; &quot;(push (cons 'nnmaildir 'notmuch) nnir-method-default-engines)
    ;;
    (setq message-send-mail-function 'message-send-mail-with-sendmail)
      (setq sendmail-program &quot;/usr/bin/msmtp&quot;)

    (setq mm-text-html-renderer 'gnus-w3m)
    (setq gnus-inhibit-images nil)

KILL What about sent mails
--------------------------

Initially, I wanted a copy in a maildir folder. It turns out it\'s
already on Gmail server in both all mail and sent mail. I\'m not sure
anymore to need a specific \"sent\" folder for gmail. So I only sync the
\"sent\" folder on my Free account

Post config en jap sur emacs
============================

Archlinux :

1.  installer le package \"mozc\" depuis emacs installer emacs-mozc
    aussi en activant le flag \'emacs~mozc~ = \"yes\"\' (sinon le
    \"helper\" n\'est pas trouvé)

Update : mozc is too slow in doom emacs =\> activate japanese instead

Torrents with emacs
===================

What works
----------

Nginx + URL

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

And for rtorrent

    network.scgi.open_port = 127.0.0.1:5000

And in emacs

    (setq mentor-rtorrent-external-rpc &quot;http://127.0.0.1:8000/RPC2&quot;)

More secure : with a socket
---------------------------

We create a group to be able to write the socket

    sudo groupadd rtorrent-socket
    sudo gpasswd -a alex rtorrent-socket
    sudo gpasswd -a nginx rtorrent-socket
    sudo chown -R nginx:rtorrent-socket /torrents/
    sudo chmod 775 -R /torrents/
    su - alex # To be able to start

Rtorrent : hack we need to change both ownership and permissions +
daemon mode

    # For use with emacs with the mentor package
    network.scgi.open_local = /torrents/rtorrent.sock

    # Change ownership to propergroup
    schedule2 = scgi_permission1, 0, 0, &quot;execute.nothrow=chown,alex:rtorrent-socket,/torrents/rtorrent.sock&quot;
    # Make SCGI socket group-writable and secure
    schedule2 = scgi_permission2, 2, 0, &quot;execute.nothrow=chmod,770,/torrents/rtorrent.sock&quot;

    system.daemon.set = true

Emacs

    (setq mentor-rtorrent-external-rpc &quot;/torrents/rtorrent.sock&quot;)

Update : it seems to work without nginx with a socket ??

Org mode
========

Export vers beamer : pour gérer des tableaux de grande taille :
---------------------------------------------------------------

  a   b
  --- ---
  a   b

Utiliser lulatex
----------------

; lualatex preview (setq org-latex-pdf-process \'(\"lualatex -shell-escape -interaction nonstopmode %f\" \"lualatex -shell-escape -interaction nonstopmode %f\")) (Attention à l\'ordrer)

Haskell
=======

Mode mal documenté (avec lsp) C-c C-l pour charger code dans ghci C-c
C-z si on perd le popup

Misc
====

yas-describe-tables to see snippets

Presentation
============

org mode -\> beamer
-------------------

org-mode -\> reveal.js
----------------------

    REVEAL_TRANS
    #+OPTIONS: toc:nil
    #+OPTIONS: reveal_width:2100 reveal_height:1000
    #+REVEAL_TRANS: nil
    \****** TODO DP 1
    \******  DP1
    \******  homme de 54 ans, tabagique au long cours et hypertendu depuis 12 ans (traitement par inhibiteur calcique), consulte
    \****** n médecin traitant pour un épisode isolé d'hématurie macroscopique totale, sans caillot. Il a pour autre antécédent une
    \****** pendicectomie dans l'enfance. L'hémogramme est le suivant : Hb 10,4 g/dL (VGM 78 µm3), GB 8 G/L, plaquettes 247

Puis SPC m e v b

Tramp
=====

SSH + sudo : /ssh:you\@remotehost%7Cdoas:: ou
/ssh:you\@remotehost%7Csudo::

Sauvegarder session :

<https://emacs.stackexchange.com/questions/26560/bookmarking-remote-directories-trampsudo>
(add-to-list \'tramp-default-proxies-alist \'(\"\\\\\`mydomain\\\\\'\"
\"\\\\\`root\\\\\'\" \"/sshx:user@%h:\"))

Useful shortcuts:
=================

-   C-x C-q in dired to edit the buffer as text \<3
-   C-x z to repeat last command, then z (like vim \".\")

Not so useful

-   C-x right/left arrow to switch buffer (I\'m not really using it)

Post sur facebook messenger inside emacs
========================================

Requirements

-   bitlbee
-   erc
-   bitlbee-facebook

Config

``` {.lisp}
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
