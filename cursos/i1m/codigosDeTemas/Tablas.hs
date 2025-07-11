-- Tablas.hs
-- El tipo predefinido de las tablas.
-- José A. Alonso Jiménez <jalonso@us.es>
-- Sevilla,  4 de Enero de 2011
-- ---------------------------------------------------------------------

-- Nota. Para usar las tablas hay que escribir al principio del
-- fichero 
import Data.Array

-- 2.7.1. Creación de matrices
-- ---------------------------

-- (f n) es un vector de n+1 elementos tal que su elemento n-ésimo
-- es n*n. Por ejemplo,
--    ghci> f 5
--    array (0,5) [(0,0),(1,1),(2,4),(3,9),(4,16),(5,25)]
f :: Int -> Array Int Int
f n = array (0,n) [(i,i^2) | i <- [0..n]]

-- v es un vector con 4 elementos de tipo carácter.
v :: Array Integer Char
v = array (1,4) [(3,'c'),(2,'a'), (1,'f'), (4,'e')]

-- m es la matriz con 2 filas y 3 columnas tal que el elemento de la
-- posición (i,j) es i*j.
m :: Array (Int, Int) Int
m = array ((1,1),(2,3)) [((i,j), (i*j)) | i<-[1..2],j<-[1..3]]

-- Nota. Una tabla está indefinida si algún índice está fuera de rango.
--    ghci> array (1,4) [(i , i*i) | i <- [1..4]]
--    array (1,4) [(1,1),(2,4),(3,9),(4,16)]
--    ghci> array (1,4) [(i , i*i) | i <- [1..5]]
--    array *** Exception: Error in array index
--    ghci> array (1,3) [(i , i*i) | i <- [1..5]]
--    array *** Exception: Error in array index
--    ghci> array (1,4) [(i , i*i) | i <- [1..3]]
--    array (1,4) [(1,1),(2,4),(3,9),(4,*** 
--    Exception: (Array.!): undefined array element

-- v!i es el elemento i-ésimo del vector v. Por ejemplo,
--    ghci> v
--    array (1,4) [(1,'f'),(2,'v),(3,'c'),(4,'e')]
--    ghci> v!3
--    'c'

-- m!(i,j) es el elemento (i,j) de la matriz m. Por ejemplo,
--    ghci> m!(2,1)
--    2

-- (fibs n) es el vector formado por los n primeros términos de la
-- sucesión de Fibonacci. Por ejemplo,
--    ghci> fibs 8
--    array (0,8) [(0,1),(1,1),(2,2),(3,3),(4,5),(5,8),(6,13),(7,21),(8,34)]
fibs :: Int -> Array Int Int
fibs n = a where 
    a = array (0,n) 
              ([(0,1),(1,1)] ++ 
               [(i,a!(i-1)+a!(i-2)) | i <- [2..n]])

-- (listArray (m,n) xs) es el vector de (longitud n)-m+1 cuyo elementos
-- son los de la lista xs. Por ejemplo,
--    ghci> listArray (2,5) "Roma"
--    array (2,5) [(2,'R'),(3,'o'),(4,'m'),(5,'a')]

-- (histograma r is) es el vector formado contando cuantas veces
-- aparecen los elementos del rango r en la lista de índices is. Por
-- ejemplo, 
--    ghci> histograma (0,5) [3,1,4,1,5,4,2,7]
--    array (0,5) [(0,0),(1,2),(2,1),(3,1),(4,2),(5,1)]
histograma :: (Ix a, Num b) => (a,a) -> [a] -> Array a b
histograma r is = 
    accumArray (+) 0 r [(i,1) | i <- is, inRange r i]

-- 2.7.2. Uso de las tablas
-- ------------------------

-- Ejemplo de tabla:
--    ghci> m
--    array ((1,1),(2,3)) 
--          [((1,1),1),((1,2),2),((1,3),3),((2,1),2),((2,2),4),((2,3),6)]

-- t!i es el elemento i de la tabla t. Por ejemplo,
--    ghci> m!(1,2)
--    2

-- (bounds t) es el rango de la tabla t. Por ejemplo,
--    ghci> bounds m
--    ((1,1),(2,3))

-- (indices t) es la lista de los índices de los elementos de la tabla
-- t. Por ejemplo,
--    ghci> indices m
--    [(1,1),(1,2),(1,3),(2,1),(2,2),(2,3)]

-- (elems t) es la lista de los elementos de la tabla t. Por ejemplo,
--    ghci> elems m
--    [1,2,3,2,4,6]

-- (assocs t) es la lista de asociaciones de los índices y los
-- elementos de la tabla t. Por ejemplo,
--    ghci> assocs m
--    [((1,1),1),((1,2),2),((1,3),3),((2,1),2),((2,2),4),((2,3),6)]

-- (t // ivs) es la tabla t asignándole a los índices de ivs sus
-- correspondientes valores. Por ejemplo,
--    ghci> m // [((1,1),4), ((2,2),8)]
--    array ((1,1),(2,3)) 
--          [((1,1),4),((1,2),2),((1,3),3),((2,1),2),((2,2),8),((2,3),6)]
--    ghci> m
--    array ((1,1),(2,3)) 
--          [((1,1),1),((1,2),2),((1,3),3),((2,1),2),((2,2),4),((2,3),6)]

-- (histograma_2 rango vs) es el vector formado contando cuantas veces
-- aparecen los elementos del rango en la lista xs. Por ejemplo,
--    ghci> histograma_2 (0,5) [3,1,4,1,5,4,2]
--    array (0,5) [(0,0),(1,2),(2,1),(3,1),(4,2),(5,1)]
histograma_2 (inf, sup) xs = 
    actualizaHist (array (inf,sup) [(i,0) | i <- [inf..sup]]) xs

actualizaHist t [] = t
actualizaHist t (x:xs) = actualizaHist (t // [(x, (t!x + 1))]) xs

-- (accum f t ivs) es la tabla obtenida sustituyendo cada elemento x de
-- t cuyo índice aparece en ivs con valor y por (f x y). Por ejemplo,
--    ghci> m
--    array ((1,1),(2,3)) 
--          [((1,1),1),((1,2),2),((1,3),3),((2,1),2),((2,2),4),((2,3),6)]
--    ghci> accum (+) m [((1,1), 4), ((2,2),8)]
--    array ((1,1),(2,3)) 
--          [((1,1),5),((1,2),2),((1,3),3),((2,1),2),((2,2),12),((2,3),6)]
--    ghci> m
--    array ((1,1),(2,3)) 
--          [((1,1),1),((1,2),2),((1,3),3),((2,1),2),((2,2),4),((2,3),6)]


