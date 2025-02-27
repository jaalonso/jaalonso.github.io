-- Grafo.hs
-- TAD de grafos.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 11 de Octubre de 2010
-- ---------------------------------------------------------------------

module Grafo
    (Grafo,
     creaGrafo,  -- (Ix v,Num p) => Bool -> (v,v) -> [(v,v,p)] -> Grafo v p
     adyacentes, -- (Ix v,Num p) => (Grafo v p) -> v -> [v]
     nodos,      -- (Ix v,Num p) => (Grafo v p) -> [v]
     aristasND,  -- (Ix v,Num p) => (Grafo v p) -> [(v,v,p)]
     aristasD,   -- (Ix v,Num p) => (Grafo v p) -> [(v,v,p)]
     aristaEn,   -- (Ix v,Num p) => (Grafo v p) -> (v,v) -> Bool
     peso        -- (Ix v,Num p) => v -> v -> (Grafo v p) -> p
    ) where

import Data.Array

-- (Grafo v p) es un grafo con vértices de tipo v y pesos de tipo p.
data Grafo v p = Undefined

-- (creaGrafo d cs as) es un grafo (dirigido si de es True y no dirigido
-- en caso contrario), con el par de cotas cs y listas de aristas as
-- (cada arista es un trío formado por los dos vértices y su peso). Por
-- ejemplo, 
--    creaGrafo False (1,5) [(1,2,12),(1,3,34),(1,5,78),
--                           (2,4,55),(2,5,32),
--                           (3,4,61),(3,5,44),
--                           (4,5,93)]
-- crea el grafo
--             12
--        1 -------- 2
--        | \78     /|
--        |  \   32/ |
--        |   \   /  |
--      34|     5    |55
--        |   /   \  |
--        |  /44   \ |
--        | /     93\|
--        3 -------- 4
--             61
creaGrafo :: (Ix v,Num p) => Bool -> (v,v) -> [(v,v,p)] -> (Grafo v p)
creaGrafo = undefined

-- (adyacentes g v) es la lista de los vértices adyacentes al nodo v en
-- el grafo g. 
adyacentes :: (Ix v,Num p) => (Grafo v p) -> v -> [v]
adyacentes = undefined

-- (nodos g) es la lista de todos los nodos del grafo g.
nodos :: (Ix v,Num p) => (Grafo v p) -> [v]
nodos = undefined

-- (aristasND g) es la lista de las aristas del grafo no dirigido g.
aristasND :: (Ix v,Num p) => (Grafo v p) -> [(v,v,p)]
aristasND = undefined

-- (aristasD g) es la lista de las aristas del grafo dirigido g.
aristasD :: (Ix v,Num p) => (Grafo v p) -> [(v,v,p)]
aristasD = undefined

-- (aristaEn g a) se verifica si a es una arista del grafo g.
aristaEn :: (Ix v,Num p) => (Grafo v p) -> (v,v) -> Bool
aristaEn = undefined

-- (peso v1 v2 g) es el peso de la arista que une los vértices v1 y v2
-- en el grafo g.
peso :: (Ix v,Num p) => v -> v -> (Grafo v p) -> p
peso = undefined

