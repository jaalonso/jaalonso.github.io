import Text.Printf

-- λ> tablaLogaritmos "z.txt" [1,3..20]
-- λ> muestraContenidoFichero "z.txt"
-- +----+----------------+
-- | n  | log(n)         |
-- +----+----------------+
-- |  1 | 0.000000000000 |
-- |  3 | 1.098612288668 |
-- |  5 | 1.609437912434 |
-- |  7 | 1.945910149055 |
-- |  9 | 2.197224577336 |
-- | 11 | 2.397895272798 |
-- | 13 | 2.564949357462 |
-- | 15 | 2.708050201102 |
-- | 17 | 2.833213344056 |
-- | 19 | 2.944438979166 |
-- +----+----------------+

tablaLogaritmos :: FilePath -> [Int] -> IO ()
tablaLogaritmos f ns = do
  writeFile f (tablaLogaritmosAux ns)

tablaLogaritmosAux :: [Int] -> String
tablaLogaritmosAux ns =
     linea
  ++ cabecera
  ++ linea
  ++ concat [printf "| %2d | %.12f |\n" n x
            | n <- ns
            , let x = log (fromIntegral n)
                    :: Double
            ]
  ++ linea

linea :: String
linea =
  "+----+----------------+\n"

cabecera :: String
cabecera =
  "| n  | log(n)         |\n"


muestraContenidoFichero :: FilePath -> IO ()
muestraContenidoFichero f = do
  cs <- readFile f
  putStrLn cs
