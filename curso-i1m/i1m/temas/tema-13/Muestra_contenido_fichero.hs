-- λ> muestraContenidoFichero "Ejemplo_1.txt"
-- Este fichero tiene tres líneas
-- esta es la segunda y
-- esta es la tercera.
-- 
muestraContenidoFichero :: FilePath -> IO ()
muestraContenidoFichero f = do
  cs <- readFile f
  putStrLn cs
