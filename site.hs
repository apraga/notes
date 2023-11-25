{-# LANGUAGE OverloadedStrings #-}
import  Hakyll
import qualified Text.Pandoc as Pandoc

--------------------------------------------------------------------------------
-- Important note :
-- Notes are in org-roam so managed outside hakelly because
-- 1. Hakyll does not manage org metadata.
-- 2. we have a custom filter to correct org-roam internal link
--------------------------------------------------------------------------------

notesTOC = [ "notes/medecine/bacteriologie.org"
           , "notes/medecine/hématologie.org"
           , "notes/medecine/virologie.org"]

main :: IO ()
main = hakyllWith config $ do
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

    match "notes/japonais.org" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= relativizeUrls

    match (fromList notesTOC) $ do
        route $ setExtension "html"
        compile $ pandocCompilerWith defaultHakyllReaderOptions withTOC
            >>= relativizeUrls

    -- Generate list of posts
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

    -- Generate list of notes
    create ["notes.html"] $ do
        route idRoute
        compile $ do
            notes' <- loadAll . fromList $ "notes/japonais.org" : notesTOC
            let archiveCtx =
                    listField "notes" postCtx (return notes') `mappend`
                    constField "title" "Notes"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/notes.html" archiveCtx
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

-- Let hakyll manage deployment
config = defaultConfiguration {
  deployCommand = "tar cvzf site.tar.gz -C _site . && hut pages publish site.tar.gz -d scut.srht.site"
  }

-- Generate table of contents
withTOC = defaultHakyllWriterOptions { Pandoc.writerTableOfContents = True
                                     , Pandoc.writerTOCDepth = 1
                                     , Pandoc.writerTemplate = Just tocTemplate
                                     }

-- from jaspervdj website
tocTemplate = either error id $ either (error . show) id $
  Pandoc.runPure $ Pandoc.runWithDefaultPartials $ Pandoc.compileTemplate "" "$toc$\n$body$"
