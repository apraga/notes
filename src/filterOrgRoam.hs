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
import qualified Data.Text as T
import Database.Persist.Sqlite
import Control.Monad.IO.Class
import Control.Monad.Logger
import Text.Pandoc.JSON
import System.FilePath (addExtension, dropExtension, makeRelative)
import System.Directory (getCurrentDirectory)

PTH.share [PTH.mkPersist PTH.sqlSettings, PTH.mkMigrate "migrateAll"] [PTH.persistLowerCase|
  Node sql=nodes
    Id T.Text sql=id
    file T.Text
    title T.Text
    deriving Show
|]

path =  "/home/alex/.emacs.d/.local/cache/org-roam.db"

unescape :: T.Text -> T.Text
unescape = T.replace "\"" ""

-- From "id:XXXX" search in org-roam database for path to file
-- If there is no id, just return the string unchanged
pathFromID :: T.Text -> IO (T.Text)
pathFromID id = runSqlite path $ do
    -- Get id and add (escaped) quote
    let s = T.concat ["\"", last (T.splitOn "id:" id), "\""]
    test <- get (NodeKey s)
    let res = case test of
                Just x -> unescape . nodeFile $ x
                Nothing -> id
    return res

-- Change link to HTML version for publishing it
-- Link is transformed from absolute to relative
-- And we add the root folder for publishing
-- FIXME this will not work locally...
htmlLink :: FilePath -> FilePath -> FilePath
htmlLink f pwd = "/" ++ makeRelative pwd (addExtension (dropExtension f) ".html")

-- Replace org-mode internal link to link to the full path of the file
replaceLink :: Inline -> IO (Inline)
replaceLink (Link attr xs t) = do
  p <- pathFromID (fst t)
  pwd <- getCurrentDirectory
  let p' = htmlLink (T.unpack p) pwd
  return $ Link attr xs (T.pack p', snd t)
replaceLink x = return x


main :: IO ()
main = toJSONFilter replaceLink
