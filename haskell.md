Astuces
=======

Compiler rapidement un script haskell:

`   stak script simple.hs --resolver lts-14.18`

On peut aussi le mettre dans le code source :

`   {- stack script `\
`    --resolver lts-14.18`\
`   -}`\
`   `

Learning Haskell
================

Libraries
---------

\- \[X\] Shelly - \[X\] Xmonad

` - Récup de l'écran`\
` - Faire un projet cabal`

Concepts
--------

\- \[X\] Functional dependencies

` - [X] `[`An`` ``introduction`` ``to`` ``Haskell's`` ``kinds`](https://www.youtube.com/watch?v=JleVecHAad4 "wikilink")` `\
` - [X] `[`Getting`` ``a`` ``little`` ``fancy`` ``with`` ``Haskell's`` ``kinds`](https://www.youtube.com/watch?v=Qy_yxVkO8no "wikilink")

\- \[ \] Backpack

` - [ ] `[`Part`` ``1`](http://blog.ezyang.com/2016/10/try-backpack-ghc-backpack/ "wikilink")\
` - [ ] `[`https://sebfisch.github.io/haskell-regexp/regexp-play.pdf`](https://sebfisch.github.io/haskell-regexp/regexp-play.pdf)\
` - [ ] `[`Part`` ``2`](http://blog.ezyang.com/2017/01/try-backpack-cabal-packages/ "wikilink")

\- \[X\]
[Bifunctors](https://www.quora.com/What-are-some-practical-uses-of-bifunctors-in-Haskell/answer/James-Bowen-13 "wikilink")

[Monday Morning Haskell - Reddit](https://www.reddit.com/r/haskell/comments/npxfba/ive_tried_to_learn_haskell_several_times_but_keep/h084wwa?utm_source=share&utm_medium=web2x&context=3 "wikilink")
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

\- \[ \] Foundational building blocks

` - [X] Functor `[`https://mmhaskell.com/monads/functors`](https://mmhaskell.com/monads/functors)\
` - [X] `[`https://mmhaskell.com/monads/applicatives`](https://mmhaskell.com/monads/applicatives)\
` - [X] `[`https://mmhaskell.com/monads/tutorial`](https://mmhaskell.com/monads/tutorial)\
` - [X] `[`https://mmhaskell.com/monads/reader-writer`](https://mmhaskell.com/monads/reader-writer)\
` - [X] `[`https://mmhaskell.com/monads/state`](https://mmhaskell.com/monads/state)\
` - [X] `[`https://mmhaskell.com/monads/transformers`](https://mmhaskell.com/monads/transformers)\
` - [ ]  `[`https://mmhaskell.com/monads/laws`](https://mmhaskell.com/monads/laws)\
` `

\- \[ \] real-world example

` - [X] Database`\
` - [ ] API`

\- \[ \] Relax for a few days and watch how interactive programs are
being composed - \[ \] Get back to the real-world example and make it a
complete Cabal project. - \[ \]
[Testing](https://mmhaskell.com/testing/test-driven-development)

Cabal vs stack
--------------

Stack: facile à utiliser mais parfois non à jour Cabal: utiliser avec
ghcup NB: Sous archlinux, le linking dynamique est utilisé par défaut et
ne semble pas marcher avec cabal. Par exemple, wreq ne trouve pas le
Prelude.. On peut installer ghc-static ou bien utiliser ghcup
(recommandé
[ici](https://github.com/haskell/haskell-ide-engine/issues/1647) )

\- \[X\] installer avec ghcup - \[X\] Tester sur getbook - \[X\] Tester
sur askhistorians

Livres
======

KILL Learn Haskell for your greater good
----------------------------------------

50%

STRT [Haskell programming from first principles](books.org::Haskell%20Programming%20From%20First%20Principles "wikilink")
-------------------------------------------------------------------------------------------------------------------------

Contributing
============

GHC
---

### - \[X\] [20261](https://gitlab.haskell.org/ghc/ghc/-/issues/20261)

1.  WAIT Rebase

### - \[X\] Lire commentary

### - \[X\] STRT Lire <https://www.aosabook.org/en/ghc.html>

Panopticum
----------

<span class="todo TODO">TODO</span>
[Issues](https://foss.heptapod.net/bsdutils/panopticum/-/issues)

Faire les version faciles (refactoring prévu)

- \[X\] Regarder pourquoi OPTION~RADIO~ ne passe pas (cf test)
--------------------------------------------------------------

DEADLINE: \<2021-09-08 Wed\> SCHEDULED: \<2021-09-07 Tue\>

Darcs
-----

### - \[X\] --mirror

\[\[notmuch:id:shf0ni\$h6s\$1\@ciao.gmane.io\]\[Email from Ben Franksen:
Re: \[darcs-users\] Darcs equivalent of force-pushing and branching\]\]
[Issue](http://bugs.darcs.net/issue2683)

1.  <span class="todo TODO">TODO</span> Version interactive
    1.  Structure
        Apply.hs:
        [applyCmdCommon](~/code/darcs/src/Darcs/UI/Commands/Apply.hs::applyCmdCommon%20patchApplier%20patchProxy%20opts%20bundle%20repository%20=%20do "wikilink")
        contient

        -   la liste interactives des patches créé par runSelection
            [runSelection](~/code/darcs/src/Darcs/UI/SelectChanges.hs::runSelection%20_%20PSC%20%7B%20splitter%20=%20Just%20_%20%7D%20= "wikilink")
            -\>
            [runInvertibleSelection](home/alex/code/darcs/src/Darcs/UI/SelectChanges.hs::runInvertibleSelection%20::%20forall%20p%20wX%20wY%20. "wikilink")

        -\>
        [textSelect](~/code/darcs/src/Darcs/UI/SelectChanges.hs::textSelect%20lps'%20pcs%20= "wikilink")
        qui pose les questions à l\'utilisateur

        -   le merge qui contient la nouvelle stratégie du merge, appelé
            par

        applyPatches, instancié dans
        [standardApplyPatches](~/code/darcs/src/Darcs/UI/ApplyPatches.hs::standardApplyPatches%20::%20(RepoPatch%20p,%20ApplyState%20p%20~%20Tree) "wikilink")
        -\>
        [mergeAndTest](~/code/darcs/src/Darcs/UI/ApplyPatches.hs::mergeAndTest%20::%20(RepoPatch%20p,%20ApplyState%20p%20~%20Tree) "wikilink")
        qui contient l\'option mirroir

    2.  Rajouter une 2eme phase de sélection avec liste des patches à
        supprimer
    3.  Merge standard si tous les patches ne sont pas sélectionnés
    4.  -a/--all affecte les 2 phases ou non ?
