-- ConjuntoConNumerosBinarios.hs
-- Implementación de conjunto de números enteros mediante números binarios.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla, 11 de Septiembre de 2010
-- ---------------------------------------------------------------------

module ConjuntoConNumerosBinarios
    (Conj,
     vacio,     -- Conj a                       
     esVacio,   -- Conj a -> Bool               
     pertenece, -- Eq a => a -> Conj a -> Bool  
     inserta,   -- Eq a => a -> Conj a -> Conj a
     elimina    -- Eq a => a -> Conj a -> Conj a
    ) where

-- Los conjuntos que sólo contienen números (de tipo Int) entre 0 y n-1,
-- se pueden representar como números binarios con n bits donde el bit i 
-- (0 <= i < n) es 1 syss el número i pertenece al conjunto. Por
-- ejemplo, 
--                       43210 
--    {3,4}     mediante 11000 en decimal es 24 
--    {1,2,3,4} mediante 11110 en decimal es 30
--    {1,2,4}   mediante 10110 en decimal es 22

-- Los conjuntos de números enteros como números binarios.
newtype Conj = Cj Int
    deriving Eq

-- (conj2Lista c) es la lista de los elementos del conjunto c. Por
-- ejemplo, 
--   conj2Lista (Cj 24)  ==  [3,4]
--   conj2Lista (Cj 30)  ==  [1,2,3,4]
--   conj2Lista (Cj 22)  ==  [1,2,4]
conj2Lista (Cj s) = c2l s 0
    where 
      c2l 0 _             = []
      c2l n i | odd n     = i : c2l (n `div` 2) (i+1)
              | otherwise = c2l (n `div` 2) (i+1)

-- Procedimiento de escritura de conjuntos.
instance Show Conj where
    showsPrec _ s cad = showConj (conj2Lista s) cad

showConj []     cad = showString "{}" cad
showConj (x:xs) cad = showChar '{' (shows x (showl xs cad))
     where showl []     cad = showChar '}' cad
           showl (x:xs) cad = showChar ',' (shows x (showl xs cad))

-- maxConj es el máximo número que puede pertenecer al conjunto. Depende
-- de la implementación de Haskell. Por ejemplo,
--    maxConj  ==  29
maxConj :: Int
maxConj = 
   truncate (logBase 2 (fromIntegral maxInt)) - 1
   where maxInt = maxBound::Int

-- Ejemplo de conjunto:
--    ghci> c1
--    {0,1,2,3,5,7,9}
c1 :: Conj
c1 = foldr inserta vacio [2,5,1,3,7,5,3,2,1,9,0]

-- vacio es el conjunto vacío. Por ejemplo,
--    ghci> vacio
--    {}
vacio :: Conj
vacio = Cj 0

-- (esVacio c) se verifica si c es el conjunto vacío. Por ejemplo, 
--    esVacio c1     ==  False
--    esVacio vacio  ==  True
esVacio :: Conj -> Bool
esVacio (Cj n) = n == 0

-- (pertenece x c) se verifica si x pertenece al conjunto c. Por ejemplo, 
--    c1              ==  {0,1,2,3,5,7,9}
--    pertenece 3 c1  ==  True
--    pertenece 4 c1  ==  False
pertenece :: Int -> Conj -> Bool
pertenece i (Cj s)
    | (i>=0) && (i<=maxConj) = odd (s `div` (2^i))
    | otherwise              = error ("pertenece: elemento ilegal =" ++ show i)

-- (inserta x c) es el conjunto obtenido añadiendo el elemento x al
-- conjunto c. Por ejemplo,
--    c1            ==  {0,1,2,3,5,7,9}
--    inserta 5 c1  ==  {0,1,2,3,5,7,9}
--    inserta 4 c1  ==  {0,1,2,3,4,5,7,9}
inserta i (Cj s)
    | (i>=0) && (i<=maxConj) = Cj (d'*e+m)
    | otherwise              = error ("inserta: elemento ilegal =" ++
                                      show i)
    where (d,m) = divMod s e
          e     = 2^i
          d'    = if odd d then d else d+1

-- (elimina x c) es el conjunto obtenido eliminando el elemento x
-- del conjunto c. Por ejemplo,
--    c1            ==  {0,1,2,3,5,7,9}
--    elimina 3 c1  ==  {0,1,2,5,7,9}
elimina i (Cj s)
    | (i>=0) && (i<=maxConj) = Cj (d'*e+m)
    | otherwise              = error ("elimina: elemento ilegal =" ++
                                      show i)
    where (d,m) = divMod s e
          e     = 2^i
          d'    = if odd d then d-1 else d
