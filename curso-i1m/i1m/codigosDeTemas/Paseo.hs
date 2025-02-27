-- Paseo.hs
-- El problea del paseo.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 14 de Abril de 2015
-- ---------------------------------------------------------------------

import I1M.BusquedaEnEspaciosDeEstados
import I1M.BusquedaPrimeroElMejor

-- ---------------------------------------------------------------------
-- § El problema del paseo                                            --
-- ---------------------------------------------------------------------

-- Una persona puede moverse en línea recta dando cada vez un paso
-- hacia la derecha o hacia la izquierda. Podemos representarlo
-- mediante su posición X. El valor inicial de X es 0. El problema
-- consiste en llegar a la posición -3.  

type Posicion = Int

inicial :: Posicion
inicial = 0

final :: Posicion
final = -3

data Nodos = N [Posicion] deriving (Eq, Show)

-- (sucesores n) es la lista de sucesores del nodo n. Por ejemplo,
--    sucesores (N [0])     ==  [N [1,0],N [-1,0]]
--    sucesores (N [1,0])   ==  [N [2,1,0]]
--    sucesores (N [-1,0])  ==  [N [-2,-1,0]]
sucesores :: Nodos -> [Nodos]
sucesores (N (n@(p:ps))) = 
    [N (p+d:n) | d <- [1,-1], p+d `notElem` ps]

-- (esFinal n) se verifica si n es un nodo final.
esFinal :: Nodos -> Bool
esFinal (N (p:_)) = p == final

-- Búsqueda en profundidad
-- =======================

-- (buscaEE_P) es la lista de las soluciones del problema del paseo por
-- búsqueda en profundidad. 
buscaEE_P = buscaEE sucesores
                    esFinal        
                    (N [inicial])

-- Nota. Al buscar una solución con
--    ghci> head buscaEE_P
--    C-c C-cInterrupted.
-- hay que pararlo porque no la encuentra al meterse en una rama
-- infinita. Se puede resolver cambiando el orden de los sucesores

buscaEE_P2 = buscaEE (reverse . sucesores)
                     esFinal        
                     (N [inicial])

-- Ahora sí encuentra la solución
--    ghci> head buscaEE_P2
--    N [-3,-2,-1,0]

-- Búsqueda por primero el mejor
-- =============================

-- (distancia x y) es la distancia entre las posiciones x e y. Por ejemplo,
--    distancia    2    5  ==  3
--    distancia (-2)    5  ==  7
--    distancia    2 (-5)  ==  7
--    distancia (-2) (-5)  ==  3
--    distancia    5    2  ==  3
distancia :: Posicion -> Posicion -> Int
distancia x y = abs (x - y)

-- (heuristica p) la distancia de p al estado final. Por ejemplo,
--    heuristica inicial  ==  3
heuristica :: Posicion  -> Int
heuristica p = distancia p final

-- Un nodo es menor o igual que otro si tiene una heurística menor o
-- igual. 
instance Ord Nodos where 
    N (p1:_) <= N (p2:_) = heuristica p1 <= heuristica p2

-- (buscaPM_P) es la lista de las soluciones del problema del paseo por
-- búsqueda primero el mejor. Por ejemplo,
--    head buscaPM_P  ==  N [-3,-2,-1,0]
buscaPM_P = buscaPM sucesores      
                    esFinal        
                    (N [inicial])

