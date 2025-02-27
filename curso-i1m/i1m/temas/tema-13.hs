import Data.List (sort)
import Data.Char (toUpper)

-- (muestraContenidoFichero f) muestra en pantalla el contenido del
-- fichero f. Por ejemplo, 
--   λ> muestraContenidoFichero "Ejemplo_1.txt"
--   Este fichero tiene tres lineas
--   esta es la segunda y
--   esta es la tercera.
muestraContenidoFichero :: FilePath -> IO ()
muestraContenidoFichero f = do
  cs <- readFile f
  putStrLn cs

-- (aMayucula f1 f2) lee el contenido del fichero f1 y escribe su
-- contenido en mayúscula en el fichero f2. Por ejemplo, 
--   λ> muestraContenidoFichero "Ejemplo_1.txt"
--   Este fichero tiene tres lineas
--   esta es la segunda y
--   esta es la tercera.
--   
--   λ> aMayuscula "Ejemplo_1.txt" "Ejemplo_3.txt"
--   λ> muestraContenidoFichero "Ejemplo_3.txt"
--   ESTE FICHERO TIENE TRES LINEAS
--   ESTA ES LA SEGUNDA Y
--   ESTA ES LA TERCERA.
aMayuscula f1 f2 = do
  contenido <- readFile f1
  writeFile f2 (map toUpper contenido)  

-- (ordenaFichero f1 f2) lee el contenido del fichero f1 y escribe su
-- contenido ordenado en el fichero f2. Por ejemplo, 
--   λ> muestraContenidoFichero "Ejemplo_4a.txt"
--   Juan Ramos
--   Ana Ruiz
--   Luis Garcia
--   Blanca Perez
--   
--   λ> ordenaFichero "Ejemplo_4a.txt" "Ejemplo_4b.txt"
--   λ> muestraContenidoFichero "Ejemplo_4b.txt"
--   Ana Ruiz
--   Blanca Perez
--   Juan Ramos
--   Luis Garcia
ordenaFichero :: FilePath -> FilePath -> IO ()
ordenaFichero f1 f2 = do
  cs <- readFile f1
  writeFile f2 ((unlines . sort . lines) cs)

-- (tablaCuadrados f n) escribe en el fichero f los cuadrados de los n
-- primeros números. Por ejemplo.
--    λ> tablaCuadrados "cuadrados.txt" 5
--    λ> muestraContenidoFichero "cuadrados.txt"
--    (1,1) (2,4) (3,9) (4,16) (5,25)
tablaCuadrados :: FilePath -> Int -> IO ()
tablaCuadrados f n =
  writeFile f (listaDeCuadrados n)

listaDeCuadrados :: Int -> String
listaDeCuadrados n =
  unwords (map show [(x,x*x) | x <- [1..n]])

-- (tablaCuadrados2 f n) escribe en el fichero f los cuadrados de los n
-- primeros números, uno por línea. Por ejemplo.
--    λ> tablaCuadrados2 "cuadrados.txt" 5
--    λ> muestraContenidoFichero "cuadrados.txt"
--    (1,1)
--    (2,4)
--    (3,9)
--    (4,16)
--    (5,25)
tablaCuadrados2 :: FilePath -> Int -> IO ()
tablaCuadrados2 f n =
  writeFile f (listaDeCuadrados2 n)

listaDeCuadrados2 :: Int -> String
listaDeCuadrados2 n =
  unlines (map show [(x,x*x) | x <- [1..n]])



