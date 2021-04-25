import Data.List (sort)

ordenaFichero :: FilePath -> FilePath -> IO ()
ordenaFichero f1 f2 = do
  cs <- readFile f1
  writeFile f2 ((unlines . sort . lines) cs)
