-- BEE_Mochila.hs
-- El problema de la mochila mediante BEE.
-- Sevilla, 13 de mayo de 2020
-- ---------------------------------------------------------------------

import BusquedaEnEspaciosDeEstados
-- import I1M.BusquedaEnEspaciosDeEstados

import Data.List (sort)

-- Se tiene una mochila de capacidad de peso p y una lista de n objetos
-- para colocar en la mochila. Cada objeto i tiene un peso p(i) y un
-- valor v(i). Considerando la posibilidad de colocar el mismo objeto
-- varias veces en la mochila, el problema consiste en determinar la
-- forma de colocar los objetos en la mochila sin sobrepasar la
-- capacidad de la mochila colocando el máximo valor posible.

-- Los pesos son número enteros
type Peso = Int

-- Los valores son números reales.
type Valor = Float

-- Los objetos son pares formado por un peso y un valor
type Objeto = (Peso,Valor)

-- Una solución del problema de la mochila es una lista de objetos.
type Sol = [Objeto]

-- Los estados del problema de la mochila son 5-tupla de la forma
-- (v,p,l,o,s) donde
-- + v es el valor de los objetos colocados,
-- + p es el peso de los objetos colocados,
-- + l es el límite de la capacidad de la mochila,
-- + o es la lista de los objetos no colocados (ordenados de forma
--   creciente según sus pesos) y
-- + s es la solución parcial.
type Estado = (Valor, Peso, Peso, [Objeto], Sol)

-- (sucesores e) es la lista de los sucesores del estado e en el
-- problema de la mochila.
--    λ> sucesores (0,0,8,[(2,3),(3,5),(4,6),(5,10)],[])
--    [(3.0,2,8,[(2,3.0),(3,5.0),(4,6.0),(5,10.0)],[(2,3.0)]),
--     (5.0,3,8,[(3,5.0),(4,6.0),(5,10.0)],[(3,5.0)]),
--     (6.0,4,8,[(4,6.0),(5,10.0)],[(4,6.0)]),
--     (10.0,5,8,[(5,10.0)],[(5,10.0)])]
--    λ> sucesores (3.0,2,8,[(2,3.0),(3,5.0),(4,6.0),(5,10.0)],[(2,3.0)])
--    [(6.0,4,8,[(2,3.0),(3,5.0),(4,6.0),(5,10.0)],[(2,3.0),(2,3.0)]),
--     (8.0,5,8,[(3,5.0),(4,6.0),(5,10.0)],[(3,5.0),(2,3.0)]),
--     (9.0,6,8,[(4,6.0),(5,10.0)],[(4,6.0),(2,3.0)]),
--     (13.0,7,8,[(5,10.0)],[(5,10.0),(2,3.0)])]
sucesores :: Estado -> [Estado]
sucesores (v, p, limite, objetos, solp) =
  [( v + v',
     p + p',
     limite,
     [o | o@(p'',_) <- objetos, p'' >= p'], 
     (p', v') : solp )
  | (p', v') <- objetos, 
    p + p' <= limite]

-- (esObjetivo e) se verifica si e es un estado final el problema de
-- la mochila.
esObjetivo :: Estado -> Bool
esObjetivo (_, p, limite, ((p',_):_), _) = p + p' > limite

-- (rellenos os l) es la lista de los pares (v,s) donde s es una forma
-- de rellenar la mochila usando los objetos de os con un límite de peso
-- l y v es el valor de s. Por ejemplo,
--    λ> rellenos [(2,3),(3,5),(4,6),(5,10)] 8
--    [(12.0,[(2,3.0),(2,3.0),(2,3.0),(2,3.0)]),
--     (11.0,[(3,5.0),(2,3.0),(2,3.0)]),
--     (12.0,[(4,6.0),(2,3.0),(2,3.0)]),
--     (13.0,[(3,5.0),(3,5.0),(2,3.0)]),
--     ( 9.0,[(4,6.0),(2,3.0)]),
--     (13.0,[(5,10.0),(2,3.0)]),
--     (10.0,[(3,5.0),(3,5.0)]),
--     (11.0,[(4,6.0),(3,5.0)]),
--     (15.0,[(5,10.0),(3,5.0)]),
--     (12.0,[(4,6.0),(4,6.0)]),
--     (10.0,[(5,10.0)])]
rellenos :: [Objeto] -> Peso -> [(Valor, Sol)]
rellenos os l = 
  [(v,sol) | (v,p,_,_,sol) <- buscaEE sucesores 
                                      esObjetivo  
                                      (0,0,l,sort os,[])]

-- (solucion os l) es la solución del problema de la mochila para
-- la lista de objetos os y el límite de capacidad l. Por ejemplo,
--    λ> solucion [(2,3),(3,5),(4,6),(5,10)] 8
--    (15.0,[(5,10.0),(3,5.0)])
--    λ> solucion [(2,3),(3,5),(5,6)] 10
--    (16.0,[(3,5.0),(3,5.0),(2,3.0),(2,3.0)])
--    λ> solucion [(8,15),(15,10),(3,6),(6,13),(2,4),(4,8),(5,6),(7,7)] 35
--    (75.0,[(6,13.0),(6,13.0),(6,13.0),(6,13.0),(6,13.0),(3,6.0),(2,4.0)])
--    λ> solucion [(2,2.8),(3,4.4),(5,6.1)] 10
--    (14.4,[(3,4.4),(3,4.4),(2,2.8),(2,2.8)])
solucion :: [Objeto] -> Peso -> (Valor, Sol)
solucion os l = maximum (rellenos os l) 



