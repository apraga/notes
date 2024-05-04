# Démarrer un projet

## Nix
[Environnement Haskell avec Nix](Environnement%20Haskell%20avec%20Nix.md)
## Script en un seul fichier (cabal)

`cabal run` sur le script suivant (ou chmod +x)

``` haskell
#!/usr/bin/env cabal
{- cabal:
build-depends: base
            , turtle
-}
{-# LANGUAGE OverloadedStrings #-}
import Turtle
main = echo "Hello World!"
```

## Script en un seul fichier (stack)

\`stack run\` sur le script suivant (ou chmod +x)

``` haskell
-- stack --resolver lts-6.25 script --package turtle
{-# LANGUAGE OverloadedStrings #-}
import Turtle
main = echo "Hello World!"
```

## Avec stack

``` {.bash org-language="sh"}
stack script simple.hs --resolver lts-14.18
```

# Data analysis

## Frames

### Minimal example

``` haskell
{-# LANGUAGE DataKinds, FlexibleContexts, QuasiQuotes, TemplateHaskell, TypeApplications,
TypeApplications#-}
import Lens.Micro.Extras
import qualified Data.Foldable as F
import Frames

-- Data set from http://vincentarelbundock.github.io/Rdatasets/datasets.html
tableTypes "TLeft" "data/prestige.csv"
tableTypes "TRight" "data/test.csv"

loadLeft :: IO (Frame TLeft)
loadLeft = inCoreAoS (readTable "data/prestige.csv")

loadRight :: IO (Frame TRight)
loadRight = inCoreAoS (readTable "data/test.csv")


main = do
  l <- loadLeft
  r <- loadRight
  -- Native way of showing a row
  print $ frameRow l 1
  -- List-style way of showing a row
  print $ take 2 $ F.toList l

  let t = innerJoin @'[ColType] l r
  print $ frameRow t 1

```

### Lire des fichiers tsv

    {-# LANGUAGE DataKinds, FlexibleContexts, QuasiQuotes, TemplateHaskell, TypeApplications, OverloadedStrings #-}
    module Main where

    import qualified Control.Foldl                 as L
    import qualified Data.Foldable as F
    import           Frames
    import Frames.TH (rowGen, RowGen(..))

    tableTypes' (rowGen "ml-100k/u.user")
                { rowTypeName = "U2"
                , columnNames = ["index", "age", "sex", "job", "id"]
                , separator = "\t"}

    loadRows :: IO (Frame U2)
    loadRows = inCoreAoS (readTableOpt u2Parser "ml-100k/u.user")

    main = do
      ms <- loadRows
      mapM_ print (F.toList  ms)

Il faut rajouter le parser \"u2Parser\" (cf
<https://github.com/acowley/Frames/issues/178>)

# Divers

## Cabal vs stack

Stack: facile à utiliser mais parfois non à jour Cabal: utiliser avec
ghcup NB: Sous archlinux, le linking dynamique est utilisé par défaut et
ne semble pas marcher avec cabal. Par exemple, wreq ne trouve pas le
Prelude.. On peut installer ghc-static ou bien utiliser ghcup
(recommandé
[ici](https://github.com/haskell/haskell-ide-engine/issues/1647) )

-   [x] installer avec ghcup - \[X\] Tester sur getbook - \[X\] Tester
    sur

askhistorians

# [TODO]{.todo .TODO} SQL {#sql id="87a191ea-a2aa-41f7-873d-a54676523a77"}

On utilise persistent. Pour se connecter à une base existante, il faut
connaître le type de colonnes (avec \`.schema\`, voir
[Sqlite3](id:6ffe3a57-b7b8-4334-8d49-f4586d2943ae)). Puis définir un
type.

**Important** on n\'a pas besoin de remplir les types de toutes les
colonnes. Seulement celles qui nous intéressent !! Exemple: pour
org-roam, on regarde la table files

``` sql
sqlite> .schema files
CREATE TABLE files (file UNIQUE PRIMARY KEY, title , hash NOT NULL, atime NOT NULL, mtime NOT NULL);
```

``` haskell
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE UndecidableInstances       #-}
{-# LANGUAGE DataKinds #-}

import qualified Database.Persist.TH as PTH
import Database.Persist (Entity(..))
import Database.Persist.Sql (toSqlKey)
import Data.Text
import Database.Persist.Sqlite
import Control.Monad.IO.Class
import Control.Monad.Logger

PTH.share [PTH.mkPersist PTH.sqlSettings, PTH.mkMigrate "migrateAll"] [PTH.persistLowerCase|
  File sql=files
    file Text
    Primary file
    title Text
    hask Text
    atime Text
    mtime Text
    deriving Show
|]

path =  "/home/alex/.emacs.d/.local/cache/org-roam.db"

main :: IO ()
main = runSqlite path $ do
    test <- selectList [] [LimitTo 1]
    liftIO $ print (test :: [Entity File])
```

Note: il faut définir une autre clé primaire, voir
<https://hackage.haskell.org/package/persistent-2.14.5.0/docs/Database-Persist-Quasi.html>

``` haskell
file Text
Primary file
```

Si la clé primaire est une chaîne de caractères

``` haskell
Id Text sql=id
```

Pour chercher par clé directement (toujours org-roam avec une clé en
chaine de caractère)

``` haskell
test <- get (NodeKey "1")
return $ (test :: Maybe Node)
```

# Emacs

Utiliser haskell-compile Si on utilise haskell-proces-cabal-build
(default `C-c c-c`{.verbatim}), il ne trouve pas le fichier .cabal
associé quand on éditer le code source
