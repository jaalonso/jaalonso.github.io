-- Juego_de_la_vida.hs
-- El juego de la vida,
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 5 de Mayo de 2015
-- ---------------------------------------------------------------------

import Data.List (nub)
import System.Console.ANSI

-- Una posición es un par de enteros (x,y) donde es el número de fila e
-- y es el número de columna empezando en 0. 
type Pos = (Int,Int)

-- (irA p) mueve el cursor a la posición p.
irA :: Pos -> IO ()
irA (x,y) = setCursorPosition x y

-- (escribeEn p xs) escribe en la posición p la cadena xs.
escribeEn :: Pos -> String -> IO ()
escribeEn p xs = do
  irA p
  putStr xs

-- limpiaPantalla limpia la pantalla.
limpiaPantalla :: IO ()
limpiaPantalla = clearScreen

-- Un tablero es una lista de posiciones que indican donde se encuentran
-- las células vivas.
type Tablero = [Pos]

-- ejTablero es el tablero que usaremos en los ejemplos. Gráficamente,
--      0 1 2 3 4
--    0
--    1       X 
--    2   X   X
--    3     X X
--    4
ejTablero :: Tablero
ejTablero = [(1,3),(2,1),(2,3),(3,2),(3,3)]

-- ancho es la anchura del tablero (por defecto, 5).
ancho :: Int
ancho = 5

-- alto es la altura del tablero (por defecto, 5).
alto :: Int
alto = 5

-- (vida n t) simula el juego de la vida empezando en el tablero t y una
-- pausa de n entre cada generación. Por ejemplo,
--    vida (10^6) ejTablero
vida :: Int -> Tablero -> IO ()
vida = vida' 0 
  where
    vida' 21 _ _ = do
      escribeEn (4+alto,0) "Finalizado\n\n"
      return ()
    vida' g n t = do
      limpiaPantalla
      escribeTablero t
      escribeGeneracion g
      espera n
      vida' (g+1) n (siguienteGeneracion t)

-- (escribeTablero t) escribe el tablero t.
escribeTablero :: Tablero -> IO ()
escribeTablero t = sequence_ [escribeEn p "O" | p <- t]

-- (escribeGeneracion g) escribe el número dela generación.
escribeGeneracion :: Int -> IO ()
escribeGeneracion g = escribeEn (2+alto,0) ("Generacion " ++ show g)

-- (espera n) espera un tiempo proporcional a n.
espera :: Int -> IO ()
espera n = sequence_ [return () | _ <- [1..n]]

-- (siguienteGeneracion t) es la generación siguiente a la
-- correspondiente al tablero t. Por ejemplo,
--    λ> siguienteGeneracion ejTablero
--    [(2,3),(3,2),(3,3),(1,2),(2,4)]
--    λ> siguienteGeneracion it
--    [(3,2),(3,3),(2,4),(1,3),(3,4)]
siguienteGeneracion :: Tablero -> Tablero
siguienteGeneracion t = supervivientes t ++ nacimientos t

-- (supervivientes t) es la listas de posiciciones de t que sobreviven;
-- i.e. posiciciones con 2 ó 3 vecinos vivos. Por ejemplo,
--    λ> supervivientes ejTablero
--    [(2,3),(3,2),(3,3)]
supervivientes :: Tablero -> [Pos]
supervivientes t = [p | p <- t, elem (nVecinosVivos t p) [2,3]]

-- (nVecinosVivos t p) es el número de vecinos vivos de la posición p en
-- el tablero t. Por ejemplo,
--    nVecinosVivos ejTablero (2,2)  ==  5
--    nVecinosVivos ejTablero (3,2)  ==  3
nVecinosVivos :: Tablero -> Pos -> Int
nVecinosVivos t = length . filter (tieneVida t) . vecinos

-- (vecinos p) es la lista de los vecinos de p. Por ejemplo, 
--    vecinos (2,1)  ==  [(1,0),(1,1),(1,2),(2,0),(2,2),(3,0),(3,1),(3,2)]
--    vecinos (1,0)  ==  [(0,0),(0,1),(1,1),(2,0),(2,1)]
--    vecinos (1,4)  ==  [(0,3),(0,4),(1,3),(2,3),(2,4)]
--    vecinos (0,0)  ==  [(0,1),(1,0),(1,1)]
vecinos :: Pos -> [Pos]
vecinos (x,y) = [(x+a,y+b) | a <- [-1,0,1]
                           , b <- [-1,0,1]
                           , (a,b) /= (0,0)
                           , 0 <= x+a && x+a < ancho
                           , 0 <= y+b && y+b < alto]

-- (tieneVida t p) se verifica si en la posición p del tablero t hay una
-- célula viva. Por ejemplo,
--    tieneVida ejTablero (2,1)  ==  True
--    tieneVida ejTablero (0,0)  ==  False
tieneVida :: Tablero -> Pos -> Bool
tieneVida t p = elem p t

-- (nacimientos t) es la lista de los nacimientos de tablero t; i.e. las
-- posiciones sin vida con 3 vecinos vivos. Por ejemplo, 
--    nacimientos ejTablero   ==  [(1,2),(2,4)]
-- Una definición ineficente es
nacimientos' :: Tablero -> [Pos]
nacimientos' t = [(x,y) | x <- [1..ancho],
                          y <- [1..alto],
                          noTieneVida t (x,y),
                          nVecinosVivos t (x,y) == 3]

-- (noTieneVida t p) se verifica si en la posición p del tablero t no
-- hay una célula viva. Por ejemplo,
--    tieneVida ejTablero (2,1)  ==  False
--    tieneVida ejTablero (0,0)  ==  True
noTieneVida :: Tablero -> Pos -> Bool
noTieneVida t p = not (tieneVida t p)

-- Una definición eficiente es
nacimientos :: Tablero -> [Pos]
nacimientos t = [p | p <- nub (concatMap vecinos t),
                     noTieneVida t p,
                     nVecinosVivos t p == 3]

-- Función principal para la ejecución . Por ejemplo,
--    stack exec -- runhaskell Juego_de_la_vida_v4.hs 
main :: IO ()
main = do
  setTitle "El juego de la vida"
  vida (10^6) ejTablero
