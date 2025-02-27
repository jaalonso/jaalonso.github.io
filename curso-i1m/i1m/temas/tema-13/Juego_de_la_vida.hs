-- Juego_de_la_vida.hs
-- El juego de la vida,
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 5 de Mayo de 2015
-- ---------------------------------------------------------------------

import Data.List (nub)

type Pos = (Int,Int)

irA :: Pos -> IO ()
irA (x,y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

escribeEn :: Pos -> String -> IO ()
escribeEn p xs = do irA p
                    putStr xs

limpiaPantalla :: IO ()
limpiaPantalla = putStr "\ESC[2J"

ancho :: Int
ancho = 5

alto :: Int
alto = 5

type Tablero = [Pos]

ejTablero :: Tablero
ejTablero = [(4,2),(2,3),(4,3),(3,4),(4,4)]

-- vida 100000 ejTablero
vida :: Int -> Tablero -> IO ()
vida n t = do limpiaPantalla
              escribeTablero t
              espera n
              vida n (siguienteGeneracion t)

escribeTablero :: Tablero -> IO ()
escribeTablero t = sequence_ [escribeEn p "O" | p <- t]

espera :: Int -> IO ()
espera n = sequence_ [return () | _ <- [1..n]]

-- siguienteGeneracion ejTablero  =>  [(4,3),(3,4),(4,4),(3,2),(5,3)]
siguienteGeneracion :: Tablero -> Tablero
siguienteGeneracion t = supervivientes t ++ nacimientos t

-- (supervivientes t) es la listas de posiciciones de t que sobreviven;
-- i.e. posiciciones con 2 ó 3 vecinos vivos. Por ejemplo,
--    supervivientes ejTablero  =>  [(4,3),(3,4),(4,4)]
supervivientes :: Tablero -> [Pos]
supervivientes t = [p | p <- t, elem (nVecinosVivos t p) [2,3]]

-- nVecinosVivos ejTablero (3,3)  =>  5
-- nVecinosVivos ejTablero (3,4)  =>  3
nVecinosVivos :: Tablero -> Pos -> Int
nVecinosVivos t = length . filter (tieneVida t) . vecinos

-- vecinos (2,3)  =>  [(1,2),(2,2),(3,2),(1,3),(3,3),(1,4),(2,4),(3,4)]
-- vecinos (1,2)  =>  [(5,1),(1,1),(2,1),(5,2),(2,2),(5,3),(1,3),(2,3)]
-- vecinos (5,2)  =>  [(4,1),(5,1),(1,1),(4,2),(1,2),(4,3),(5,3),(1,3)]
-- vecinos (2,1)  =>  [(1,5),(2,5),(3,5),(1,1),(3,1),(1,2),(2,2),(3,2)]
-- vecinos (2,5)  =>  [(1,4),(2,4),(3,4),(1,5),(3,5),(1,1),(2,1),(3,1)]
-- vecinos (1,1)  =>  [(5,5),(1,5),(2,5),(5,1),(2,1),(5,2),(1,2),(2,2)]
-- vecinos (5,5)  =>  [(4,4),(5,4),(1,4),(4,5),(1,5),(4,1),(5,1),(1,1)]
vecinos :: Pos -> [Pos]
vecinos (x,y) = map modular [(x-1,y-1), (x,y-1), (x+1,y-1), 
                             (x-1,y),            (x+1,y), 
                             (x-1,y+1), (x,y+1), (x+1,y+1)] 

-- modular (6,3)  =>  (1,3)
-- modular (0,3)  =>  (5,3)
-- modular (3,6)  =>  (3,1)
-- modular (3,0)  =>  (3,5)
modular :: Pos -> Pos
modular (x,y) = (1 + (x-1) `mod` ancho, 
                 1 + (y-1) `mod` alto)

-- tieneVida ejTablero (1,1)  =>  False
-- tieneVida ejTablero (2,3)  =>  True
tieneVida :: Tablero -> Pos -> Bool
tieneVida t p = elem p t

-- (nacimientos t) es la lista de los nacimientos de tablero t; i.e. las
-- posiciones sin vida con 3 vecinos vivos. Por ejemplo, 
--    nacimientos ejTablero  =>  [(3,2),(5,3)]
-- Una definición ineficente es
nacimientos' :: Tablero -> [Pos]
nacimientos' t = [(x,y) | x <- [1..ancho],
                          y <- [1..alto],
                          noTieneVida t (x,y),
                          nVecinosVivos t (x,y) == 3]

-- noTieneVida ejTablero (1,1)  =>  True
-- noTieneVida ejTablero (2,3)  =>  False
noTieneVida :: Tablero -> Pos -> Bool
noTieneVida t p = not (tieneVida t p)

-- Una definición eficiente es
nacimientos :: Tablero -> [Pos]
nacimientos t = [p | p <- nub (concatMap vecinos t),
                     noTieneVida t p,
                     nVecinosVivos t p == 3]

