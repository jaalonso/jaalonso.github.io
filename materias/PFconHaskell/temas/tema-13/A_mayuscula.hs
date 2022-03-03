import Data.Char

aMayuscula f1 f2 = do
  contenido <- readFile f1
  writeFile f2 (map toUpper contenido)  
