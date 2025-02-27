-- BusquedaEnEspaciosDeEstados.hs
-- Búsqueda en espacios de estados.
-- Sevilla, 13 de mayo de 2020
-- ---------------------------------------------------------------------

module BusquedaEnEspaciosDeEstados (buscaEE) where

-- ---------------------------------------------------------------------
-- Importaciones                                                      --
-- ---------------------------------------------------------------------

-- Nota: Hay que elegir una implementación de las pilas.
import PilaConListas
-- import PilaConTipoDeDatoAlgebraico
-- import I1M.Pilas

-- ---------------------------------------------------------------------
-- Descripción de los problemas de espacios de estados                --
-- ---------------------------------------------------------------------

-- Las características de los problemas de espacios de estados son:
-- + un conjunto de las posibles situaciones o nodos que constituye
--   el espacio de estados; estos son las potenciales soluciones que se
--   necesitan explorar;
-- + un conjunto de movimientos de un nodo a otros nodos, llamados los
--   sucesores del nodo; 
-- + un nodo inicial;
-- + un nodo objetivo, que es la solución.

-- Nota: Se supone que el grafo implícito de espacios de estados es
-- acíclico. 

-- (buscaEE s o e) es la lista de soluciones del problema de espacio de
-- estado definido por la función sucesores (s), el objetivo (o) y el
-- estado inicial (e).
buscaEE :: (nodo -> [nodo]) -- sucesores
        -> (nodo -> Bool)   -- esFinal
        -> nodo             -- nodo actual
        -> [nodo]           -- soluciones
buscaEE sucesores esFinal x = busca' (apila x vacia) where
  busca' p  
    | esVacia p        = [] 
    | esFinal (cima p) = cima p : busca' (desapila p)
    | otherwise        = busca' (foldr apila (desapila p) (sucesores (cima p)))
