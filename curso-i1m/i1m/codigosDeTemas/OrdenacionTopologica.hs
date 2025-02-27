-- OrdenacionTopologica.hs
-- Ordenación topológica
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 2 de Noviembre de 2010
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Librerías auxiliares                                               --
-- ---------------------------------------------------------------------

-- Nota: Elegir una implementación de los grafos.
import GrafoConVectorDeAdyacencia
-- import GrafoConMatrizDeAdyacencia

import Data.Array

-- ---------------------------------------------------------------------
-- Ejemplo de grafo                                                   --
-- ---------------------------------------------------------------------

-- g es el grafo
--    +---> 2 <---+
--    |           |
--    |           |
--    1 --> 3 --> 6 --> 5
--    |                 |
--    |                 |
--    +---> 4 <---------+
g = creaGrafo True (1,6) 
              [(1,2,0),(1,3,0),(1,4,0),(3,6,0),(5,4,0),(6,2,0),(6,5,0)]

-- (gradoEnt g n) es el grado de entrada del nodo n en el grafo g; es
-- decir, el número de aristas de g que llegan a n. Por ejemplo,
--    gradoEnt g 1  ==  0
--    gradoEnt g 2  ==  2
--    gradoEnt g 3  ==  1
gradoEnt :: (Ix a, Num p) => Grafo a p -> a -> Int
gradoEnt g n  = length [t | v <- nodos g, t <- adyacentes g v, n==t]

-- (ordenacionTopologica g) es una ordenación topológica del grafo
-- g. Por ejemplo, 
--    ordenacionTopologica g  ==  [1,3,6,5,4,2]
ordenacionTopologica g = ordTop [n | n <- nodos g , gradoEnt g n == 0] [] 
  where
    ordTop [] r    = r
    ordTop (c:cs) vis  
     | elem c vis = ordTop cs vis
     | otherwise  = ordTop cs (c:(ordTop (adyacentes g c) vis))

-- Ejemplo de ordenación de cursos

data Cursos = Matematicas  | Computabilidad | Lenguajes | Programacion |
              Concurrencia | Arquitectura   | Paralelismo
    deriving (Eq,Ord,Enum,Ix,Show)

gc = creaGrafo True (Matematicas,Paralelismo) 
               [(Matematicas,Computabilidad,1),
                (Lenguajes,Computabilidad,1),
                (Programacion,Lenguajes,1),
                (Programacion,Concurrencia,1),
                (Concurrencia,Paralelismo,1),
                (Arquitectura,Paralelismo,1)]

-- ghci> ordenacionTopologica gc
-- [Arquitectura,Programacion,Concurrencia,Paralelismo,Lenguajes,
--  Matematicas,Computabilidad]


