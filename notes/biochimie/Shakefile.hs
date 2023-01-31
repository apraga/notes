import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do
    want ["docx"]

    phony "clean" $ do
        putInfo "Cleaning files in _build"
        removeFilesAfter "_build" ["//*"]

    phony "docx" $ do
        org <- getDirectoryFiles "" ["parametres//*.org"]
        need [ "_build" </> dropDirectory1 (c -<.> "docx") | c <- org ]

    "_build//*.docx" %> \out -> do
        let c = "parametres" </> dropDirectory1 out -<.> "org"
        cmd_ "pandoc" [c] "-o" [out]
