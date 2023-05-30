{-# LANGUAGE OverloadedStrings #-}
import  Hakyll

--------------------------------------------------------------------------------
-- Important note :
-- Hakyll does not manage org metadata. We follow @nasyxx hack mentioned here
-- https://github.com/jaspervdj/hakyll/issues/700
-- with a slight modification in cleanRouteFromTemp
-- The idea is to generate in _temp the file with YAML metada on top on org metadat
-- Then a second pass is needed to generate actual HTML
--------------------------------------------------------------------------------

main :: IO ()
main = hakyll $ do
    match ("images/microbiologie/*") $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*.css" $ do
        route   idRoute
        compile compressCssCompiler

    match "about.org" $ do
        route  $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    match ("notes/index.org" .||. "notes/*japonais*.org") $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match ("notes/*microbio*.org" .||. "notes/medecine/202*.org") $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            -- >>= loadAndApplyTemplate "templates/post.html"    defaultContext
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    -- Don't forget to set the path to temporary files
    create ["notes/medecine.html"] $ do
        route idRoute
        compile $ do
            notes <- loadAll "notes/medecine/*"
            let notesCtx =
                    listField "notes" defaultContext (return notes) `mappend`
                    constField "title" "Notes"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/notes.html" notesCtx
                >>= loadAndApplyTemplate "templates/default.html" notesCtx
                >>= relativizeUrls


    -- Don't forget to set the path to temporary files
    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    -- Don't forget to set the path to temporary files
    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler

postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext
