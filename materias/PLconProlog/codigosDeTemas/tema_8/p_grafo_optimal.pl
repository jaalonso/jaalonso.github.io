% p_grafo_optimal.pl
% Grafo para experimentar la búsqueda optimal.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% =============================================================================

% Descripción del problema
% ========================

% Problema de búsqueda correspondiente al siguiente grafo:
%
%                                  A-----+
%                            (2) /       |
%                              /         |
%                             B          |
%                               \        |
%                            (3)  \      |(8)
%                                   \    |
%                                     C--+
%
% donde el estado inicial es A y el estado final es C.

% Representación del problema
% ===========================

% Un ESTADO es un átomo de la lista [a,b,c].

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial(a).

% estado_final(?E) se verifica si        E es un estado final.
estado_final(c).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1.
sucesor(E1,E2) :-
   arco(E1,E2).
sucesor(E1,E2) :-
   arco(E2,E1).

% arco(?E1,?E2) se verifica si existe un arco con extremos E1 y E2.
arco(a,b).
arco(a,c).
arco(b,c).

% Coste
% =====

coste(X,Y,C) :-
   coste_arco(X,Y,C);
   coste_arco(Y,X,C).

coste_arco(a,b,2).
coste_arco(a,c,8).
coste_arco(b,c,3).

% Escritura de solución
% =====================

% escribe_solucion(+S) escribe la solución S.
escribe_solucion(S) :-
   format('~nSol: ~w~n',[S]).

% Heurística
% ==========

% heuristica(+E,?H) se verifica si la heurística H del estado E. 
heuristica(a,4).
heuristica(b,2).
heuristica(c,0).

% Problemas
% =========

% lista_de_numeros_de_heuristica(?L) se verifica si L es la lista de los
% números de heurísticas. 
lista_de_numeros_de_heuristica([]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria. 
agotado(_,_) :- fail.

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P. 
sin_solucion(_,_) :- fail.

% Experimentos
% ============

% Se usa el fichero experimentos.pl
%    ?- [experimentos].
%    true.

% Comparación de procedimientos
%    ?- compara_procedimientos(p_grafo_optimal).
%    
%    +---------------------------------------------------------------------------+
%    |                         Problema: p_grafo_optimal                         |
%    +---------------------------------------------------------------------------+
%    
%    Procedimiento: profundidad_sin_ciclos
%    Sol: [a,b,c]
%    Coste: 5
%    19 inferencias en 0.00 segundos y 96 bytes.
%    
%    Procedimiento: profundidad_con_ciclos
%    Sol: [a,b,c]
%    Coste: 5
%    133 inferencias en 0.00 segundos y 1,064 bytes.
%    
%    Procedimiento: profundidad_con_cerrados
%    Sol: [a,c]
%    Coste: 8
%    277 inferencias en 0.00 segundos y 2,488 bytes.
%    
%    Procedimiento: profundidad_iterativa
%    Sol: [a,c]
%    Coste: 8
%    134 inferencias en 0.00 segundos y 920 bytes.
%    
%    Procedimiento: anchura
%    Sol: [a,c]
%    Coste: 8
%    276 inferencias en 0.00 segundos y 2,560 bytes.
%    
%    Procedimiento: anchura_con_cerrados
%    Sol: [a,c]
%    Coste: 8
%    276 inferencias en 0.00 segundos y 2,464 bytes.
%    
%    Procedimiento: optimal_exhaustiva
%    Sol: [a,b,c]
%    Coste: 5
%    127 inferencias en 0.00 segundos y 592 bytes.
%    
%    Procedimiento: optimal
%    Sol: [a,b,c]
%    Coste: 5
%    294 inferencias en 0.00 segundos y 2,928 bytes.
%    
%    Procedimiento: escalada
%    Sol: [a,c]
%    Coste: 8
%    145 inferencias en 0.00 segundos y 1,064 bytes.
%    
%    Procedimiento: primero_el_mejor
%    Sol: [a,c]
%    Coste: 8
%    256 inferencias en 0.00 segundos y 2,272 bytes.
%    
%    Procedimiento: a_estrella
%    Sol: [a,b,c]
%    Coste: 5
%    298 inferencias en 0.00 segundos y 3,264 bytes.
%    true.

% Estadísticas
%    ?- estadistica(p_grafo_optimal).
%    
%    +---------------------------------------------------------------------------+
%    |                         Problema: p_grafo_optimal                         |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |   5 |          |        16 |   0.00 |         96 |
%    |profundidad_con_ciclos  |   5 |          |        27 |   0.00 |        408 |
%    |profundidad_con_cerrados|   8 |          |        69 |   0.00 |      1,152 |
%    |profundidad_iterativa   |   8 |          |        28 |   0.00 |        264 |
%    |anchura                 |   8 |          |        68 |   0.00 |      1,224 |
%    |anchura_con_cerrados    |   8 |          |        68 |   0.00 |      1,128 |
%    |optimal_exhaustiva      |   5 |          |       125 |   0.00 |        592 |
%    |optimal                 |   5 |          |        85 |   0.00 |      1,592 |
%    |escalada                |   8 |          |        38 |   0.00 |        408 |
%    |primero_el_mejor        |   8 |          |        47 |   0.00 |        936 |
%    |a_estrella              |   5 |          |        88 |   0.00 |      1,928 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.

