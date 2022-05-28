% p_arbol.pl
% Árbol para búsqueda.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 24-mayo-2022
% =============================================================================

% Representación del problema
% ===========================

% Se considera el problema de búsqueda correspondiente al siguiente árbol:
%
%                                  a
%                                /   \
%                              b       c
%                             /  \    /  \
%                            d    e  f    g
%                          /     /  \  \
%                         h     i    j   k
%
% donde el estado inicial es a y los estados finales son f y j.

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial(a).

% estado_final(?E) se verifica si E es un estado final.
estado_final(f).
estado_final(j).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1.
sucesor(a,b).
sucesor(a,c).
sucesor(b,d).
sucesor(b,e).
sucesor(c,f).
sucesor(c,g).
sucesor(d,h).
sucesor(e,i).
sucesor(e,j).
sucesor(f,k).

% Búsqueda en profundidad sin ciclos
% ==================================

% Se usa el procedimiento de búsqueda en profundidad sin ciclos.
%    ?- use_module(b_profundidad_sin_ciclos).
%    true.

% El cálculo de la solución es
%    ?- profundidad_sin_ciclos(S).
%    S = [a, b, e, j]

% Para seguir la búsqueda se pone en traza la relación estado_final
%    ?- trace(estado_final,+call).
%         estado_final/1: [call]
%    true.

% El cálculo de la solución, usando la traza, es
%    ?- profundidad_sin_ciclos(S).
%     T Call: estado_final(a)
%     T Call: estado_final(b)
%     T Call: estado_final(d)
%     T Call: estado_final(h)
%     T Call: estado_final(e)
%     T Call: estado_final(i)
%     T Call: estado_final(j)
%    S = [a, b, e, j]

% Se quita la traza de la relación estado_final
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
%    true.

% Búsqueda en anchura
% ===================

% Se usará el procedimiento de búsqueda en anchura
%    ?- use_module(b_anchura).
%    true.

% El cálculo de la solución por búsqueda en anchura es
%    ?- anchura(S).
%    S = [a, c, f]

% Para seguir la búsqueda se pone en traza la relación anchura
%    ?- trace(anchura,+call).
%    %         anchura/1: [call]
%    %         anchura/2: [call]
%    true.

% El cálculo de la solución por búsqueda en anchura (con traza) es
%    ?- anchura(S).
%     T Call: anchura(_2034)
%     T Call: anchura([[a]], _2034)
%     T Call: anchura([[b, a], [c, a]], _2034)
%     T Call: anchura([[c, a], [d, b, a], [e, b, a]], _2034)
%     T Call: anchura([[d, b, a], [e, b, a], [f, c, a], [g, c, a]], _2034)
%     T Call: anchura([[e, b, a], [f, c, a], [g, c, a], [h, d, b, a]], _2034)
%     T Call: anchura([[f, c, a], [g, c, a], [h, d, b, a], [i, e, b, a], [j, e, b|...]], _2034)
%    S = [a, c, f]

% Se quita la traza de la relación anchura
%    ?- trace(anchura,-call).
%    %         anchura/1: Not tracing
%    %         anchura/2: Not tracing
%    true.

% Escritura de solución
% =====================

% escribe_solucion(+S) escribe la solución S.
escribe_solucion(S) :-
   format('~nSol: ~w~n',[S]).

% Coste
% =====

% coste(+E1,+E2,?C) se verifica si C es el coste de pasar del estado E1
% al E2 (por defecto, es 1).
coste(_,_,1).

% Heurística
% ==========

% heuristica(+E,?H) se verifica si la heurística del estado E es H.
heuristica(a,2).
heuristica(b,2).
heuristica(c,1).
heuristica(d,9).
heuristica(e,1).
heuristica(f,0).
heuristica(g,9).
heuristica(h,9).
heuristica(i,9).
heuristica(j,0).
heuristica(k,9).

% Problemas
% =========

% lista_de_numeros_de_heuristica(?L) se verifica si la lista de los
% números de heurísticas es L (por defecto, ninguna).
lista_de_numeros_de_heuristica([]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria (Para este problema ningún
% procedimiento agota la memoria).
agotado(_,_) :- fail.

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P.
sin_solucion(_,_) :- fail.

% Experimentos
% ============

% Se usa el módulo de experimentos
%    ?- [experimentos].
%    true.

% Comparación de procedimientos
%    ?- compara_procedimientos(p_arbol).
%
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_arbol                             |
%    +---------------------------------------------------------------------------+
%
%    Procedimiento: profundidad_sin_ciclos
%    Sol: [a,b,e,j]
%    Coste: 3
%    29 inferencias en 0.00 segundos y 120 bytes.
%
%    Procedimiento: profundidad_con_ciclos
%    Sol: [a,b,e,j]
%    Coste: 3
%    157 inferencias en 0.00 segundos y 1,208 bytes.
%
%    Procedimiento: profundidad_con_cerrados
%    Sol: [a,b,e,j]
%    Coste: 3
%    368 inferencias en 0.00 segundos y 4,792 bytes.
%
%    Procedimiento: profundidad_iterativa
%    Sol: [a,c,f]
%    Coste: 2
%    176 inferencias en 0.00 segundos y 1,064 bytes.
%
%    Procedimiento: anchura
%    Sol: [a,c,f]
%    Coste: 2
%    368 inferencias en 0.00 segundos y 4,840 bytes.
%
%    Procedimiento: anchura_con_cerrados
%    Sol: [a,c,f]
%    Coste: 2
%    368 inferencias en 0.00 segundos y 4,600 bytes.
%
%    Procedimiento: optimal_exhaustiva
%    Sol: [a,c,f]
%    Coste: 2
%    263 inferencias en 0.00 segundos y 592 bytes.
%
%    Procedimiento: optimal
%    Sol: [a,c,f]
%    Coste: 2
%    384 inferencias en 0.00 segundos y 5,592 bytes.
%
%    Procedimiento: escalada
%    Sol: [a,c,f]
%    Coste: 2
%    149 inferencias en 0.00 segundos y 1,328 bytes.
%
%    Procedimiento: primero_el_mejor
%    Sol: [a,c,f]
%    Coste: 2
%    288 inferencias en 0.00 segundos y 3,136 bytes.
%
%    Procedimiento: a_estrella
%    Sol: [a,c,f]
%    Coste: 2
%    291 inferencias en 0.00 segundos y 3,432 bytes.
%    true.

% Estadísticas
%    ?- estadistica(p_arbol).
%
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_arbol                             |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |   3 |          |        26 |   0.00 |        120 |
%    |profundidad_con_ciclos  |   3 |          |        50 |   0.00 |        552 |
%    |profundidad_con_cerrados|   3 |          |       160 |   0.00 |      3,456 |
%    |profundidad_iterativa   |   2 |          |        70 |   0.00 |        408 |
%    |anchura                 |   2 |          |       160 |   0.00 |      3,504 |
%    |anchura_con_cerrados    |   2 |          |       160 |   0.00 |      3,264 |
%    |optimal_exhaustiva      |   2 |          |       261 |   0.00 |        592 |
%    |optimal                 |   2 |          |       175 |   0.00 |      4,256 |
%    |escalada                |   2 |          |        42 |   0.00 |        672 |
%    |primero_el_mejor        |   2 |          |        79 |   0.00 |      1,800 |
%    |a_estrella              |   2 |          |        81 |   0.00 |      2,096 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
