% p_8_reinas.pl
% El problema de las 8 reinas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

% Descripción del problema
% ========================

% Colocar 8 reinas en un tablero rectangular de dimensiones 8 por 8 de
% forma que no se encuentren más de una en la misma línea: horizontal,
% vertical o diagonal.

% Representación del problema
% ===========================

% Un ESTADO es un átomo de la lista de números que representa las ordenadas de
% las respectivas reinas. Por ejemplo, [3,5] representa que se ha colocado las
% reinas (1,5) y (2,3).

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial([]).

% estado_final(?E) se verifica si E es un estado final.
estado_final(E) :-
   length(E,8).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1.
sucesor(E,[Y|E]) :-
   member(Y,[1,2,3,4,5,6,7,8]),
   not(member(Y,E)),
   no_ataca(Y,E).

% no_ataca(Y,E) se verifica si E = [Y_n,...,Y_1] y la reina colocada en
% (n+1,Y) no ataca a las colocadas en (1,Y_1),...,(n,Y_n).
no_ataca(Y,E) :-
   no_ataca(Y,E,1).
no_ataca(_,[],_).
no_ataca(Y,[Y1|L],D) :-
   Y1-Y =\= D,
   Y-Y1 =\= D,
   D1 is D+1,
   no_ataca(Y,L,D1).

% Búsqueda en profundidad sin ciclos
% ==================================

% Solución del problema por búsqueda en profundidad sin ciclos.
%    ?- [b_profundidad_sin_ciclos].
%    true.
%
%    ?- profundidad_sin_ciclos(S).
%    S = [[], [1], [5, 1], [8, 5, 1], [6, 8, 5, 1], [3, 6, 8|...], [7, 3|...], [2|...], [...|...]]
%
%    ?- set_prolog_flag(answer_write_options, [quoted(true), portray(true), max_depth(100)]).
%    true.
%
%    ?- |    profundidad_sin_ciclos(S).
%    S = [[],
%         [1],
%         [5,1],
%         [8,5,1],
%         [6,8,5,1],
%         [3,6,8,5,1],
%         [7,3,6,8,5,1],
%         [2,7,3,6,8,5,1],
%         [4,2,7,3,6,8,5,1]]

% Búsqueda en anchura
% ===================

% Solución del problema por búsqueda en anchura.
%    ?- [b_anchura].
%    true.
%
%    ?- anchura(S).
%    S = [[],
%         [1],
%         [5,1],
%         [8,5,1],
%         [6,8,5,1],
%         [3,6,8,5,1],
%         [7,3,6,8,5,1],
%         [2,7,3,6,8,5,1],
%         [4,2,7,3,6,8,5,1]]

% Escritura de la solución
% ========================

% escribe_solucion(+S) escribe la solución S de forma gráfica.
escribe_solucion(S) :-
   reverse(S,[E|_]),
   format('~nSol: ~n'),
   escribe_estado(E).

% escribe_estado(+E) escribe el estado E de forma gráfica. Por ejemplo.
%    ?- escribe_estado([4, 2, 7, 3, 6, 8, 5, 1]).
%     R · · · · · · ·
%     · · · · R · · ·
%     · · · · · · · R
%     · · · · · R · ·
%     · · R · · · · ·
%     · · · · · · R ·
%     · R · · · · · ·
%     · · · R · · · ·
%    true
escribe_estado(E) :-
   reverse(E,E1),
   escribe_lineas(E1).

% escribe_lineas(+L) escribe las línea de L de forma gráfica. Por
% ejemplo,
%    ?- escribe_lineas([1, 5, 8, 6, 3, 7, 2, 4]).
%     R · · · · · · ·
%     · · · · R · · ·
%     · · · · · · · R
%     · · · · · R · ·
%     · · R · · · · ·
%     · · · · · · R ·
%     · R · · · · · ·
%     · · · R · · · ·
%    true
escribe_lineas([]).
escribe_lineas([Y|R]) :-
   escribe_linea(Y),
   escribe_lineas(R).

% escribe_linea(+Y) escribe la línea Y de forma gráfica. Por ejemplo,
%    ?- escribe_linea(2).
%     · R · · · · · ·
%    true
escribe_linea(Y) :-
   I is Y-1,
   escribe_puntos(I),
   write(' R'),
   D is 8-Y,
   escribe_puntos(D),
   nl.

% escribe_puntos(+N) escribe N puntos. Por ejemplo,
%    ?- escribe_puntos(4).
%     · · · ·
%    true
escribe_puntos(0).
escribe_puntos(N) :-
   N > 0,
   write(' ·'),
   N1 is N-1,
   escribe_puntos(N1).

% Coste
% =====

% coste(+E1,+E2,?C) se verifica que el coste C de pasar del estado E1 al
% E2 es 1.
coste(_,_,1).

% Heurísticas
% ===========

% con_heuristica(+NH) redefine heuristica(E,H) como heuristica_NH(E,H).
con_heuristica(NH) :-
   abolish(heuristica,2),
   ( NH=0 -> assert(heuristica(E,H) :- heuristica_0(E,H))
   ; NH=1 -> assert(heuristica(E,H) :- heuristica_1(E,H))
   ; NH=2 -> assert(heuristica(E,H) :- heuristica_2(E,H))).

% heuristica_0(+E,?H) se verifica si la heurística H del estado E es 0.
heuristica_0(_E,0).

% heuristica_1(+E,?H) se verifica si H es el número de reinas que quedan
% por colocar en el estado E
heuristica_1(E,H) :-
   length(E,N),
   H is 8-N.

% heuristica_2(+E,?H) se verifica si H es el producto de las reinas que
% quedan por colocar en el estado E y el número de sucesores de E.
heuristica_2(E,H) :-
   length(E,N1),
   numero_de_sucesores(E,N2),
   H is (4-N1)*N2.

% numero_de_sucesores(+E,?N) se verifica si N es el número de sucesores
% del estado E.
numero_de_sucesores(E,N) :-
   findall(E1,sucesor(E,E1),L),
   length(L,N).

% Problemas
% =========

% lista_de_numeros_de_heuristica(?L) se verifica si L es la lista de los
% números de heurísticas.
lista_de_numeros_de_heuristica([0,1,2]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria.
agotado('p-8-reinas',_Pr) :- fail.

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P.
sin_solucion(p_8_reinas, [escalada, 0]).
sin_solucion(p_8_reinas, [escalada, 2]).

% Experimentos
% ============

% Se usa el fichero experimentos.pl
%    ?- [experimentos].
%    true.

% Estadísticas
%    ?-  estadistica(p_8_reinas).
%
%    +---------------------------------------------------------------------------+
%    |                            Problema: p_8_reinas                           |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |   8 |          |    10,218 |   0.00 |      3,696 |
%    |profundidad_con_ciclos  |   8 |          |    10,573 |   0.00 |      4,728 |
%    |profundidad_con_cerrados|   8 |          |    12,906 |   0.00 |     81,368 |
%    |profundidad_iterativa   |   8 |          |   399,215 |   0.04 |      4,728 |
%    |anchura                 |   8 |          | 1,028,935 |   0.11 |     23,776 |
%    |anchura_con_cerrados    |   8 |          | 1,029,042 |   0.16 |    813,928 |
%    |optimal_exhaustiva      |   8 |          |   206,838 |   0.02 |      5,200 |
%    |optimal                 |   8 |          | 1,039,900 |   0.20 |  1,909,040 |
%    |H=0, escalada           |     | Sin sol. |           |        |            |
%    |H=0, primero_el_mejor   |   8 |          |   197,423 |   0.06 |    482,312 |
%    |H=0, a_estrella         |   8 |          | 1,044,015 |   0.21 |    377,312 |
%    |H=1, escalada           |   8 |          |    23,128 |   0.00 |      5,928 |
%    |H=1, primero_el_mejor   |   8 |          |    14,898 |   0.00 |    165,840 |
%    |H=1, a_estrella         |   8 |          | 1,050,077 |   0.22 |    370,712 |
%    |H=2, escalada           |     | Sin sol. |           |        |            |
%    |H=2, primero_el_mejor   |   8 |          |     5,046 |   0.00 |     25,048 |
%    |H=2, a_estrella         |   8 |          |    24,931 |   0.00 |    191,336 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
