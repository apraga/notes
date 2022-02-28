## Forcer le téléchargement de la release sur github 
Par défaut USE_github n'utilise pas la version officielle, voir https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=261732 pour une discussion.

1. Enlever DISTVERSIONPREFIX=	v
2. +MASTER_SITES=	https://github.com/${GH_ACCOUNT}/${PORTNAME}/releases/download/v${DISTVERSION}/
3. Enlever -USE_GITHUB=	yes
4. USES=tar:xz
On vérifiee dans distinfo le résultat

## Vérifier avec portlint, formatter avec portfmt

## PR

-   Mettre le changlog dans URL
-   Ne pas utiliser PORTREVISION si DISTVERSION est incrémenté (car sert
    aux patches freebsd)
-   Cocher \"maintainer approval\" dans le patch (et pas
    maintainer-feedback !)

## Haskell

-   Tutorial:

<https://docs.freebsd.org/en/books/porters-handbook/special/#using-cabal>

-   \"when updating from something like 1.5.0.0 to 1.5.0.1 it is usually
    sufficient to just bump the PORTVERSION. No need to refresh the
    whole USE~CABAL~ in this case.\"
-   11.4 and 12.2 are enough (no need for aarch64)

1.  Git-annex
    \"When updating such ports I do this:

    -   Run make config and turn all options OFF.
    -   Regenerate common USE~CABAL~.
    -   See if things build.
    -   Then start enabling options one by one and adjust optionalized
        dependencies until it builds.

    So yes, hs-git-annex is quite cumbersome port in this regard.\"

## Python 
Plusieurs versions de python
Using "DEFAULT_VERSIONS=python=3.10" in "/usr/local/etc/poudriere.d/py310-make.conf" and adding "-z py310" to "poudriere testport"

	doas poudriere testport -z python38 -j 130Ramd64 -o deskutils/taskwarrior-tui^C

