# Learning Haskell

## Libraries

### [DONE]{.done .DONE} Shelly {#shelly}

### [TODO]{.todo .TODO} Xmonad {#xmonad}

1.  [TODO]{.todo .TODO} Récup de l\'écran

2.  [TODO]{.todo .TODO} Faire un projet cabal

## Concepts

### Functional dependencies

1.  [DONE]{.done .DONE} [An introduction to Haskell\'s
    kinds](https://www.youtube.com/watch?v=JleVecHAad4)

2.  [DONE]{.done .DONE} [Getting a little fancy with Haskell\'s
    kinds](https://www.youtube.com/watch?v=Qy_yxVkO8no)

### [TODO]{.todo .TODO} Backpack {#backpack}

1.  [TODO]{.todo .TODO} [Part
    1](http://blog.ezyang.com/2016/10/try-backpack-ghc-backpack/)

    1.  [TODO]{.todo .TODO}
        <https://sebfisch.github.io/haskell-regexp/regexp-play.pdf>

2.  [TODO]{.todo .TODO} [Part
    2](http://blog.ezyang.com/2017/01/try-backpack-cabal-packages/)

### [DONE]{.done .DONE} [Bifunctors](https://www.quora.com/What-are-some-practical-uses-of-bifunctors-in-Haskell/answer/James-Bowen-13) {#bifunctors}

## [Monday Morning Haskell - Reddit](https://www.reddit.com/r/haskell/comments/npxfba/ive_tried_to_learn_haskell_several_times_but_keep/h084wwa?utm_source=share&utm_medium=web2x&context=3)

### [DONE]{.done .DONE} Foundational building blocks {#foundational-building-blocks}

-   [x] Functor <https://mmhaskell.com/monads/functors>
-   [x] <https://mmhaskell.com/monads/applicatives>
-   [x] <https://mmhaskell.com/monads/tutorial>
-   [x] <https://mmhaskell.com/monads/reader-writer>
-   [x] <https://mmhaskell.com/monads/state>
-   [x] <https://mmhaskell.com/monads/transformers>
-   [ ] <https://mmhaskell.com/monads/laws>

### [TODO]{.todo .TODO} real-world example {#real-world-example}

-   [x] Database
-   [ ] API

### [TODO]{.todo .TODO} Relax for a few days and watch how interactive programs are being composed {#relax-for-a-few-days-and-watch-how-interactive-programs-are-being-composed}

### [TODO]{.todo .TODO} Get back to the real-world example and make it a complete Cabal project. {#get-back-to-the-real-world-example-and-make-it-a-complete-cabal-project.}

### [DONE]{.done .DONE} [Testing](https://mmhaskell.com/testing/test-driven-development) {#testing}

## Cabal vs stack

Stack: facile à utiliser mais parfois non à jour Cabal: utiliser avec
ghcup NB: Sous archlinux, le linking dynamique est utilisé par défaut et
ne semble pas marcher avec cabal. Par exemple, wreq ne trouve pas le
Prelude.. On peut installer ghc-static ou bien utiliser ghcup
(recommandé
[ici](https://github.com/haskell/haskell-ide-engine/issues/1647) )

-   [x] installer avec ghcup
-   [x] Tester sur getbook
-   [x] Tester sur askhistorians

# Livres

## KILL Learn Haskell for your greater good

50%

## STRT [Haskell programming from first principles](books.org::Haskell Programming From First Principles)

# Contributing

## GHC {#ghc category="ghc"}

### [TODO]{.todo .TODO} [20261](https://gitlab.haskell.org/ghc/ghc/-/issues/20261) {#section}

1.  WAIT Rebase

### [TODO]{.todo .TODO} Lire commentary {#lire-commentary}

### [DONE]{.done .DONE} STRT Lire <https://www.aosabook.org/en/ghc.html> {#strt-lire-httpswww.aosabook.orgenghc.html}

## Panopticum {#panopticum category="panopticum"}

[TODO]{.todo .TODO}
[Issues](https://foss.heptapod.net/bsdutils/panopticum/-/issues)

Faire les version faciles (refactoring prévu)

## [TODO]{.todo .TODO} Regarder pourquoi OPTION~RADIO~ ne passe pas (cf test) {#regarder-pourquoi-optionradio-ne-passe-pas-cf-test}

DEADLINE: \<2021-09-08 Wed> SCHEDULED: \<2021-09-07 Tue>

## Darcs

### [TODO]{.todo .TODO} --mirror {#mirror}

\[\[notmuch:id:shf0ni\$h6s\$1\@ciao.gmane.io\]\[Email from Ben Franksen:
Re: \[darcs-users\] Darcs equivalent of force-pushing and branching\]\]
[Issue](http://bugs.darcs.net/issue2683)

1.  [TODO]{.todo .TODO} Version interactive

    1.  Structure

        Apply.hs:
        [applyCmdCommon](~/code/darcs/src/Darcs/UI/Commands/Apply.hs::applyCmdCommon patchApplier patchProxy opts bundle repository = do)
        contient

        -   la liste interactives des patches créé par runSelection
            [runSelection](~/code/darcs/src/Darcs/UI/SelectChanges.hs::runSelection _ PSC { splitter = Just _ } =)
            -\>
            [runInvertibleSelection](/home/alex/code/darcs/src/Darcs/UI/SelectChanges.hs::runInvertibleSelection :: forall p wX wY .)

        -\>
        [textSelect](~/code/darcs/src/Darcs/UI/SelectChanges.hs::textSelect lps' pcs =)
        qui pose les questions à l\'utilisateur

        -   le merge qui contient la nouvelle stratégie du merge, appelé
            par

        applyPatches, instancié dans
        [standardApplyPatches](~/code/darcs/src/Darcs/UI/ApplyPatches.hs::standardApplyPatches :: (RepoPatch p, ApplyState p ~ Tree))
        -\>
        [mergeAndTest](~/code/darcs/src/Darcs/UI/ApplyPatches.hs::mergeAndTest :: (RepoPatch p, ApplyState p ~ Tree))
        qui contient l\'option mirroir

    2.  Rajouter une 2eme phase de sélection avec liste des patches à
        supprimer

    3.  Merge standard si tous les patches ne sont pas sélectionnés

    4.  -a/--all affecte les 2 phases ou non ?
