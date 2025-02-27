import System.IO
import Data.Char

aMayuscula2 f1 f2 = do
  a1 <- openFile f1 ReadMode
  a2 <- openFile f2 WriteMode
  contenido <- hGetContents a1
  hPutStr a2 (map toUpper contenido)  
  hClose a1
  hClose a2
