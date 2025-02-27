-- BEE_Reinas.hs
-- El problema de las n reinas mediante BEE.
-- Sevilla, 13 de mayo de 2020
-- ---------------------------------------------------------------------

import BusquedaEnEspaciosDeEstados
-- import I1M.BusquedaEnEspaciosDeEstados

-- El problema de las n reinas consiste en colocar n reinas en un
-- tablero cuadrado de dimensiones n por n de forma que no se encuentren
-- más de una en la misma línea: horizontal, vertical o diagonal.

-- Las posiciones de las reinas en el tablero se representan por su
-- columna y su fila.
type Columna  = Int
type Fila     = Int
type Posicion = (Columna, Fila

-- Una solución del problema de las n reinas es una lista de
-- posiciones. 
type Sol = [Posicion]

-- (valida sp p) se verifica si la posición p es válida respecto de la
-- solución parcial sp; es decir, la reina en la posición p no amenaza a
-- ninguna de las reinas de la sp (se supone que están en distintas
-- columnas). Por ejemplo, 
--    valida [(1,1)] (2,2)  ==  False
--    valida [(1,1)] (2,3)  ==  True
valida :: Sol -> Posicion -> Bool
valida solp (c, f) = and [segura s | s <- solp]
  where segura (c', f') = c' + f' /= c + f 
                          && c' - f' /= c - f 
                          && f' /= f
                          -- && c' /= c

-- Los estados del problema de las n reinas son ternas formadas por la
-- columna de la última reina colocada, el número de columnas del
-- tablero y la solución parcial de las reinas colocadas anteriormente. 
type Estado = (Columna, Columna, Sol)

-- (sucesores e) es la lista de los sucesores del estado e en el
-- problema de las n reinas. Por ejemplo,
--    λ> sucesores (1,4,[])
--    [(2,4,[(1,1)]),(2,4,[(1,2)]),(2,4,[(1,3)]),(2,4,[(1,4)])]
sucesores :: Estado -> [Estado]
sucesores (c, n, solp) =
  [ (c + 1, n, solp ++ [(c, r)])
  | r <- [1..n]
  , valida solp (c, r)]

-- (esFinal e) se verifica si e es un estado final del problema de las
-- n reinas. 
esFinal :: Estado -> Bool
esFinal (c,n,_) = c > n

-- (soluciones n) la lista de las soluciones del problema de las n
-- reinas, por búsqueda en espacio de estados. Por ejemplo,  
--    λ> soluciones 4
--    [[(1,2),(2,4),(3,1),(4,3)],
--     [(1,3),(2,1),(3,4),(4,2)]]
soluciones :: Columna -> [Sol]
soluciones n =
  [sols | (_,_,sols) <- buscaEE sucesores esFinal (1,n,[])]

-- (primeraSolucion n) es la primera solución del problema de las n reinas,
-- por búsqueda en espacio de estados. Por ejemplo,
--    λ> primeraSolucion 4
--    [(1,2),(2,4),(3,1),(4,3)]
--    λ> primeraSolucion 8
--    [(1,1),(2,5),(3,8),(4,6),(5,3),(6,7),(7,2),(8,4)]
primeraSolucion :: Columna -> Sol
primeraSolucion = head . soluciones

-- (nSoluciones n) es el número de soluciones del problema de las n
-- reinas, por búsqueda en espacio de estados. Por ejemplo,  
--    λ> nSoluciones 4
--    2
--    λ> nSoluciones 8
--    92
nSoluciones :: Columna -> Int
nSoluciones = length . soluciones

