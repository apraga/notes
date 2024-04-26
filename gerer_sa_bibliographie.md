---
title: Gérer sa bibliographie
tags: bibliography research productivity
---

# Sync pdf with git-annex

## Requirements

-   git-annex
-   git-lfs
-   git-lfs
-   rclone

## Setup

### Google drive

-   Create a rclone google drive remote
-   Copy the executable git-annex-remote-rclone here into \$PATH

<https://github.com/DanielDent/git-annex-remote-rclone>

-   Add a remote

```{=html}
<!-- -->
```
    git annex initremote gdrive type=external externaltype=rclone target=gdrive encryption=shared

### Git LFS

-   Create a git repo and set it up for git-lfs (apraga/papers)

<https://git-lfs.github.com/>

-   Add a remote

        git annex initremote lfstest type=git-lfs url=git@github.com:apraga/papers.git encryption=none

### Emacs

Set citar-library-paths \'(\"\~/papers/bisonex\")

## Usage

### Clone the repo and get the data

``` {.bash org-language="sh"}
git-annex init
git-annex enableremote lfs
git-annex enableremote gdrive
git-annex sync --content
```

### Management

Show where files are

``` {.bash org-language="sh"}
git annex list
```

Synchronize content across remotes

    git annex sync --content

Copy data from or to a special remote

``` {.bash org-language="sh"}
git annex get . --from gdrive
git annex copy . --to lfs
```

### Open a pdf

Open files directly with citar-open-files if there are named as
\$key.pdf

# Annotated bibliography

## KILL V1

Instead of using citar and have notes scatter across multiple files, we
try a single org-file like [this
setup](http://www.cachestocaches.com/2020/3/org-mode-annotated-bibliography/)
The bib file is then generated with org-tangle

## V2: org-roam + citar

With SPC m @, you can

-   either create a org-roam note for a paper
-   open the pdf if it is store in citar-library-paths and is named
    according to the bibtex key
