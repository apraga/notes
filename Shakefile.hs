import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

siteExe = "_build/hakyll-site"
filterExe = "_build/filterOrgRoam"
args = "-s --css /css/default.css"

-- Notes are managed by pandoc manually to solve org-roam links (and Hakyll does not manage org metadata)

-- This only works in Gentoo with packages installed globally
-- TODO: add a switch to use cabal (cabal build and cabal run) outside gentoo
-- Note: nix-build fails with some encoding issues (hGetConts).
-- Nix flakes builds several GHC version...
main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do
    want ["archive", "hut"]

    "_site/notes/index.html" %> \out -> do
        let src = "notes/index.org"
        -- Only org roam notes (starting with the date)
        org <- getDirectoryFiles "" ["notes/medecine/20*.org", "notes/*japonais*.org"]
        let html = ["_site" </> n -<.> "html" | n <- org]
        need $ html ++ [filterExe]
        cmd "pandoc" src "--filter " filterExe args "-o" [out]

    "_site/notes//*.html" %> \out -> do
        let org = dropDirectory1 $ out -<.> "org"
        need [org]
        cmd "pandoc" [org] "--filter " filterExe args "-o" [out]

    siteExe  %> \out -> do
      cmd_ "ghc --make -o" [out] ["src/Main.hs"]

    filterExe  %> \out -> do
      cmd_ "ghc --make -o" [out] ["src/filterOrgRoam.hs"]

    -- Shake cannot use directories
    phony "build" $ do
        need [siteExe, filterExe ]
        cmd_ siteExe "build"

    phony "clean" $ do
        putInfo "Cleaning _site "
        cmd_ siteExe "clean"

    phony "cleanall" $ do
        need ["clean"]
        putInfo "Cleaning files in _build"
        removeFilesAfter "_build" ["//*"]

    phony "hut" $ do
        putInfo "Upload to blog hosted by sourcehut"
        need ["archive"]
        cmd_ "hut pages publish _build/site.tar.gz -d scut.srht.site"

    phony "archive" $ do
        need ["build", "_site/notes/index.html", "_site/notes/livres.html"]
        cmd_ "tar cvzf " ["_build/site.tar.gz"] "-C _site ."

  -- -- z option is important to avoid re-uploading everything
  --   phony "free" $ do
  --       putInfo "Upload to blog hosted by Free"
  --       cmd_ "ncftpput -z -f login.cfg -R . _site/*"
  --       cmd_ "ncftpput -z -f login.cfg -R . files/*"

  --   phony "watch" $ do
  --       putInfo "Generate site locally"
  --       cmd_ "_build/hakyll-site watch"
