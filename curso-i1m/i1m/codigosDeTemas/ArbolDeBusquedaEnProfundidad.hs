-- ArbolDeBusquedaEnProfundidad.hs
-- Árbol de búsqueda en profundidad.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 20 de Noviembre de 2010
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Importaciones                                                      --
-- ---------------------------------------------------------------------

-- Nota: Seleccionar una implementación de cada uno de los siguientes
-- TAD: grafo y conjunto.

-- Implementaciones del TAD cola de prioridad.
-- import GrafoConVectorDeAdyacencia
import GrafoConMatrizDeAdyacencia   -- Graph

-- Implementaciones del TAD cola de conjuntos.
-- import ConjuntoConListasNoOrdenadasConDuplicados
-- import ConjuntoConListasNoOrdenadasSinDuplicados
import ConjuntoConListasOrdenadasSinDuplicados

import Data.Array

-- ---------------------------------------------------------------------
-- Ejemplo de grafo                                                   --
-- ---------------------------------------------------------------------

-- Ejemplo de grafo: g es el grafo
--       1
--      /|\
--     / | \
--    /  3  \
--    |  |  |
--    |  |  |
--    |  6  |
--    | /|  |
--    |/ |  |
--    2  5  |
--        \ |
--         \|
--          4
g = creaGrafo True (1,8) [(1,2,0),(1,3,0),(1,4,0), 
                          (3,6,0),(5,4,0),(6,2,0),
                          (6,5,0) ]

-- ---------------------------------------------------------------------
-- Tipo de dato de árboles de búsqueda                                --
-- ---------------------------------------------------------------------

data Arbol n = Nodo n [Arbol n]
    deriving Show

-- ---------------------------------------------------------------------
-- Árbol de búsqueda en profundidad                                   --
-- ---------------------------------------------------------------------

-- (arbolBusquedaEnProfundidad s g) es el árbol de la búsqueda en
-- profundidad en el grafo g desde el nodo s hasta las hojas. Por
-- ejemplo,
--    *Main> arbolBusquedaEnProfundidad 1 g
--    Nodo 1 [Nodo 3 [Nodo 6 [Nodo 5 [Nodo 4 []]]],
--            Nodo 2 []]
arbolBusquedaEnProfundidad :: (Num w,Ix n) => n -> Grafo n w -> Arbol n 
arbolBusquedaEnProfundidad s g = 
    head (snd (abep g (conjuntoVacio,[]) s))

abep::(Ix n,Num w) => Grafo n w -> (Conj n, [Arbol n]) -> n
                      -> (Conj n, [Arbol n])
abep g (vs,ts) n
    | enConj n vs = (vs,ts)
    | otherwise   = (vs',(Nodo n ts'):ts)
    where (vs',ts') = foldl (abep g)
                            (agregaConj n vs, [])
                            (adyacentes g n)

-- ---------------------------------------------------------------------
-- Bosque de búsqueda en profundidad                                  --
-- ---------------------------------------------------------------------

-- (bosque_bep g) es el bosque de todos los árboles de búsqueda en
-- profundidad en el grafo g. Por ejemplo,
--    *Main> bosque_bep g
--    [Nodo 8 [],
--     Nodo 7 [],
--     Nodo 1 [Nodo 3 [Nodo 6 [Nodo 5 [Nodo 4 []]]],
--             Nodo 2 []]]
bosque_bep :: (Num w,Ix n) => Grafo n w -> [Arbol n]
bosque_bep g = snd (foldl (abep g) (conjuntoVacio,[]) (nodos g))

-- ---------------------------------------------------------------------
-- Búsqueda en profundidad perezosa                                   --
-- ---------------------------------------------------------------------

-- (genera g v) es el el árbol de todos los caminos en el grafo g desde
-- el nodo v a las hojas. Por ejemplo, 
--    *Main> genera g 1
--    Nodo 1 [Nodo 2 [],
--            Nodo 3 [Nodo 6 [Nodo 2 [],
--                            Nodo 5 [Nodo 4 []]]],
--            Nodo 4 []]
genera :: (Num w,Ix n) => Grafo n w -> n -> Arbol n
genera g v = Nodo v (map (genera g) (adyacentes g v))

-- (poda ts) es la lista de árboles obtenida eliminando los nodos
-- visitados en la lista de árboles ts. Por ejemplo,
--    *Main> poda [genera g 1]
--    [Nodo 1 [Nodo 2 [],
--             Nodo 3 [Nodo 6 [Nodo 5 [Nodo 4 []]]]]]
poda :: Ix n => [Arbol n] -> [Arbol n]
poda ts   = snd (poda' conjuntoVacio ts)
  where
    poda' m [] = (m,[])
    poda' m ((Nodo v ts):us)
       | enConj v m  = poda' m us
       | otherwise   = (m'',(Nodo v as):bs)
       where (m', as) = poda' (agregaConj v m) ts
             (m'',bs) = poda' m' us

-- (bosque_bep' g) es el bosque de todos los árboles de búsqueda en
-- profundidad en el grafo g, mediante generación y poda. Por ejemplo, 
--    *Main> bosque_bep' g
--    [Nodo 1 [Nodo 2 [],
--             Nodo 3 [Nodo 6 [Nodo 5 [Nodo 4 []]]]],
--     Nodo 7 [],
--     Nodo 8 []]
bosque_bep' :: (Num w,Ix n) => Grafo n w -> [Arbol n]
bosque_bep' g = poda [genera g v | v <- nodos g]

-- (visitados_bep v g) es la lista de los nodos visitados en la búsqueda
-- en profundidad desde en nodo v hasta las hojas en el grafo g. Por
-- ejemplo,
--    *Main> visitados_bep 1 g
--    [1,2,3,6,5,4]
visitados_bep :: (Num w,Ix n) => n -> Grafo n w -> [n]
visitados_bep v g = preordenA (head (poda [genera g v]))

-- (preordenA t) es la lista del recorrido preorden del árbol t. Por
-- ejemplo, 
--    *Main> preordenA (Nodo 1 [Nodo 2 [],Nodo 3 [Nodo 6 [Nodo 5 [Nodo 4 []]]]])
--    [1,2,3,6,5,4]
preordenA :: Arbol n -> [n]
preordenA (Nodo v l) = v:(concat [preordenA t | t <- l])

{-
               


-- examples of evaluations and results 
-- 
-- ? bosque_bep g
-- [Nodo 8 [], Nodo 7 [], Nodo 1 [Nodo 3 [Nodo 6 [Nodo 5 [Nodo 4 []]]], Nodo 2 []]]
-- ? visitados_bep 1 g
-- [1, 2, 3, 6, 5, 4]
-- ? bosque_bep' g
-- [Nodo 1 [Nodo 2 [], Nodo 3 [Nodo 6 [Nodo 5 [Nodo 4 []]]]], Nodo 7 [], Nodo 8 []]

-}
