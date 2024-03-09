+++
title = "Command-line utilities"
date = 2024-02-20
+++


Here's a rewrite of an older post thanks to the awesome [list on github](https://github.com/agarrharr/awesome-cli-apps?tab=readme-ov-file). To complement this list, here's a curated version of productivity tools I use daily. 

The tools I cannot live without:

- *Shell*:  [fish](https://fishshell.com/docs/current/tutorial.html) is nice but if you want to lose POSIX compatibility, you should go all the way and embrace a new workflow. I use [nu shell](https://www.nushell.sh/) as a daily driver: it considers all data as table, allowing for powerful manipulation.
- *Move around quickly* with [zoxide](https://github.com/ajeetdsouza/zoxide). It allows you to
    jump quickly to a directory with `z boo` (instead of `cd /home/user/misc/books`). A must have
- *A better sudo*: use **`doas`** (from OpenBSD). The
    configuration is super easy, just write
    `/usr/local/etc/doas.conf` (on FreeBSD) : 
    ```
    # Permit members of the wheel group to perform actions as root. 
    permit nopass :wheel
    ``` 
- *Manage tasks* with [taskwarrior](https://taskwarrior.org/). More on that in a future post.
- *Write papers and report* with [typst](https://typst.app/). More on that in a future post.
- `ripgrep` is a modern `grep` but cross-platform and faster

Interesting tools you should try. Some of them are popular tools rewritten in rust

- *Terminal* : I use `alacritty` along with `zellij` (see below). `kitty` is a nice alternative if you don't need a multiplexer
- *Zellij* is a rewrite in rust of `tmux`. 2 things that I really like : shortcuts are saner and you can open an editor to copy history (`C-s` then `e`)
- *lazygit* makes working with command-line git easier. It is similar to `magit` in emacs, with less features but good enough for my use case
- *A easier `find`* with `fd` written in Rust. For example, convert all org files to markdown with 
```bash
       fd -e md -x pandoc {} -o {.}.md`
```
- *An easier `sed`* with `sd`. Example: replace `title:` by `title =` :
```bash
sd 'title:' 'title = '
```
- *Replacement for `ls`* wit `eza` (Rust)
- *Replacement for `cat`* wit `bat` (Rust)

Tools for the occasional use

For reference: [other tools written in Rust](https://github.com/sts10/rust-command-line-utilities?tab=readme-ov-file)
