-- GrafoConPunteros.hs
-- Representación de los grafos mediante punteros.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 11 de Octubre de 2010
-- ---------------------------------------------------------------------

import qualified Grafo

data Grafo v p = Vertice v [((Grafo v p),p)] 

-- El grafo 
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
-- se representa por
grafoP = v1
     where 
       v1 = Vertice 1 [(v2,12),(v3,34),(v5,78)]
       v2 = Vertice 2 [(v1,12),(v4,55),(v5,32)]
       v3 = Vertice 3 [(v1,34),(v4,61),(v5,44)]
       v4 = Vertice 4 [(v2,55),(v3,61),(v5,93)]
       v5 = Vertice 5 [(v1,78),(v2,32),(v3,44),(v4,93)]
