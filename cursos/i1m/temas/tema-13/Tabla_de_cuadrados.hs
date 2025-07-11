import System.IO

tabla :: Int -> IO ()
tabla n = do
    a <- openFile "cuadrados.txt" WriteMode 
    mapM_ (hPrint a) [(x,x^2) | x <- [1..n]]
    hClose a



