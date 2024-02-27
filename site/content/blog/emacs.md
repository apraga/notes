+++
title = "Life in Emacs"
date = 2021-06-01
+++

Here is a small summary from my journey from vim to using Emacs for
(almost) everything. After using ViM for a few years, I wanted to try
Emacs. I can summarize months of trial and errors into this single
sentence :

> ViM users, use doom-emacs and profit

Now that I got that of the way, here are the following paths I've
tried. I've summarize as much as possible to avoid a long read :

1.  *Using pure emacs*: I've started a clean `.emacs.el` and
    discovered emacs mappings and some plugins.
2.  *Discovering evil* felt so good to be back to vim mapping after
    emacs
3.  [Using Purcell starter kit](https://github.com/purcell/emacs.d) is
    quite nice but...
4.  **Switching to doom emacs** This made my day/month/year. Start here
    !!

## Best plugins

I've put here plugins I deem essential for everyday use. I will not try
to convince you but install, play with it and you should be pleased :)
Also, the plugins in
[doom-emacs](https://github.com/hlissner/doom-emacs) are marked as
*(doom)*.

Start here :

-   [evil](https://github.com/emacs-evil/evil) (doom) : ViM emulation in
    Emacs. No life without it. See also
    [evil-collection](https://github.com/emacs-evil/evil-collection)
    (doom) for having vim mapping \"everywhere\"
-   [Org-mode](https://orgmode.org/worg/org-tutorials/org4beginners.html)
    (doom) : I use it to plan my shopping, tasks, studying, movies
    list+++ Numerous tutorials are availables online but here the
    official documentation (quick version)

Build on it :

-   [evil surround](https://github.com/emacs-evil/evil-surround) : port
    of Tim Pope's surround. Edit parenthesis, quotes, tags... Super
    useful when you need it.
-   [avy](https://github.com/abo-abo/avy) and
    [easymotion](https://github.com/PythonNut/evil-easymotion) (doom)
    allow you to jump easy everywhere (yes everwhere) on your screen.
    Replace *f* and */* in most cases. My favorite command is to jump
    multiple lines at once. Doom-emacs combine the two for a middle
    ground
-   [ivy](https://github.com/abo-abo/swiper) (doom) is your everyday
    completion helper to change buffer, run commands+++
-   [magit](https://magit.vc/) (doom) is a git helper. It was difficult
    for me to adopt it for other than just commit and push but your hard
    work will be rewarded
-   [company](https://company-mode.github.io/) (doom) do your completion
    in emacs. Can also complete filenames (C-x C-f in doom emacs)
-   [org-ref](https://github.com/jkitchin/org-ref) manage your bitex
    library with org-mode. Useful but not super intuitive. You can
    import books by ISBN ( which
    [biblio.el](https://github.com/cpitclaudel/biblio.el) does not do
    well)

Under test

-   [smartparens](https://github.com/Fuco1/smartparens) looks very
    powerful to manage nested brackets, parenthesis...

## Living in emacs

Here are a list of packages where tutorials can be found on the internet
(or in later posts)

-   Mail : `notmuch` is awesome (see [this
    post](posts/mail.org))
-   Navigation: `dired` (I've tried ranger but the default
    dired works better for me)
-   Facebook messenger : `irc` + `bitlbee`

## What I still do outside emacs

-   PDF: `pdf-tools` is nice but I prefer
    `zathura`, which is faster and more configurable
-   Music (+ video) : using `mpd` and `ncmpcpp`
-   Shell : `eshell` is nice but I prefer a "real" shell (using `nushell` at the moment).
    easier to deal with.

## Community list

Finally, [awesome-emacs](https://github.com/emacs-tw/awesome-emacs) is a
curated list of plugins by the community
