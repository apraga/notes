```{=org}
#+filetags: cs
```
# Données locales (mustard etc)

Voir [*Architecture*]{.spurious-link target="Architecture"}.

# Articles/livres de recherche

Les données sont stockées sur

-   github avec LFS (non encrypté)
-   google drive

Le dépôt central est sur github.

## Configuration

    git clone git@github.com:apraga/recherche

On active les remote

``` {.bash org-language="sh"}
git annex enableremote lfs
```

Pour utiliser google drive, il faut configure sous rclone :

1.  Configurer rclone

    ``` {.bash org-language="sh"}
    rclone config
    n
    gdrive
    17
    ```

    Il faut récupérer les identifiants depuis
    <https://console.cloud.google.com/apis/credentials?project=rclone-344013>
    dans le projet \"annex\". Copier le client ID et client secret dans
    rclone. Puis

        1

    Puis faire \"entrée\" plusieurs fois, autorsire rclone sur le lien

2.  Télécharger l\'exécutable pour le plugin:

    ``` {.bash org-language="sh"}
    curl https://raw.githubusercontent.com/DanielDent/git-annex-remote-rclone/master/git-annex-remote-rclone > git-annex-remote-rclone
    chmod +x git-annex-remote-rclone
    doas mv git-annex-remote-rclone /usr/local/bin/
    ```

Puis activer le remote

    git annex enableremote gdrive

## Usage

``` {.bash org-language="sh"}
git annex addurl www.test.com/lol.pdf --file=papers/jean2022.pdf
git annex sync --content
```
