---
title: Command-line tips
...

Here is a condensed view of programs I use to make life easier on the
command-line ordered by priority:

1.  *Change your shell* to
    [fish](https://fishshell.com/docs/current/tutorial.html). Enough
    said :)

2.  *Move around quickly* with
    [zoxide](https://github.com/ajeetdsouza/zoxide). It allows you to
    jump quickly to a directory with `z boo`{.verbatim} (instead of cd
    /home/user/misc/books).

3.  *Find files easily* with **`fd`{.verbatim}** as a remplacement for
    `find`{.verbatim}. Here is how I converted all the markdown files to
    org-mode :

    ``` {.bash org-language="sh"}
    fd md -x pandoc
    git mv {} {.}.org
    ```

4.  *A better sudo*: use **`doas`{.verbatim}** (from OpenBSD). The
    configuration is super easy, just write
    `/usr/local/etc/doas.conf`{.verbatim} (on FreeBSD) : \# Permit
    members of the wheel group to perform actions as root. permit nopass
    :wheel

5.  *Manage your ssh-keys* with
    [keychain](https://www.funtoo.org/Keychain). For fish shell, here\'s
    my configuration: \# Keychain for gpg and ssh. We have to set ssh
    and gpg. And GPG ID...

    ``` {.bash org-language="sh"}
    if status is-login keychain --quiet --agents
     ssh,gpg id_rsa 65DCD80B3BFE5B80
    end

      if test -f ~/.keychain/(hostname)-gpg-fish
          source ~/.keychain/(hostname)-gpg-fish
      end

      if test -f ~/.keychain/(hostname)-fish
          source ~/.keychain/(hostname)-fish
      end
    ```

6.  *capture videos* with **`Ffmpeg`{.verbatim}** like this

``` {.bash org-language="sh"}
ffmpeg -f x11grab -s 1280x800 -r 25 -i :0.0+nomouse -s hd720 -vcodec \
       libx264 -vpre lossless_ultrafast -an -threads 0 yourvideo.mkv
```

-   removes the mouse cursor from the capture:
    `-i :0.0+nomouse`{.verbatim}
-   enables multi-threading (if possible): `-threads 0`{.verbatim}
-   captures the screen: `-f x11grab`{.verbatim}
-   defines the size of the capture windows (here it is my entire
    screen): `-s 1280x800`{.verbatim}
-   sets the number of frames per seconds: `-r 25`{.verbatim}
-   sets the resolution: `-s hd720`{.verbatim}
-   no audio will be captured: `-an`{.verbatim}
-   using the H.264 encoding: `-vcodec libx264`{.verbatim}
-   these are settings for a fast encoding:
    `-vpre lossless_ultrafast`{.verbatim}
