import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

siteExe :: String
siteExe = "_build/hakyll-site"

-- This only works in Gentoo with packages installed globally
-- TODO: add a switch to use cabal (cabal build and cabal run) outside gentoo
-- Note: nix-build fails with some encoding issues (hGetConts).
-- Nix flakes builds several GHC version...
main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do
    want ["_site/index.html", "hut"]

    siteExe  %> \out -> do
      let src = ["src/Main.hs"]
      need src
      cmd_ "ghc --make -o" [out] src

    -- Shake cannot use directories
    "_site/index.html" %> \out ->  do
        need [siteExe]
        cmd_ siteExe "build"

    phony "clean" $ do
        putInfo "Cleaning site "
        cmd_ siteExe "clean"
        putInfo "Cleaning files in _build"
        removeFilesAfter "_build" ["//*"]

    phony "hut" $ do
        putInfo "Upload to blog hosted by sourcehut"
        need ["_build/site.tar.gz"]
        cmd_ "hut pages publish _build/site.tar.gz -d scut.srht.site"

    "_build/site.tar.gz" %> \out -> do
        cmd_ "tar cvzf " [out] "-C _site ."

  -- z option is important to avoid re-uploading everything
    phony "free" $ do
        putInfo "Upload to blog hosted by Free"
        cmd_ "ncftpput -z -f login.cfg -R . _site/*"
        cmd_ "ncftpput -z -f login.cfg -R . files/*"

    phony "watch" $ do
        putInfo "Generate site locally"
        cmd_ "_build/hakyll-site watch"
