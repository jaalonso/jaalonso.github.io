% p_4_reinas.pl
% El problema de las 4 reinas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

% Descripción del problema
% ========================

% Colocar 4 reinas en un tablero rectangular de dimensiones 4 por 4 de
% forma que no se encuentren más de una en la misma línea: horizontal,
% vertical o diagonal.

% Representación de los estados
% =============================

% Un ESTADO es un átomo de la lista de números que representa las
% ordenadas de las respectivas reinas. Por ejemplo, [3,1] representa que
% se ha colocado las reinas (1,1) y (2,3).

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial([]).

% estado_final(?E) se verifica si E es un estado final.
estado_final(E) :-
   length(E,4).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1.
sucesor(E,[Y|E]) :-
   member(Y,[1,2,3,4]),
   not(member(Y,E)),
   no_ataca(Y,E).

% no_ataca(Y,E) se verifica si E=[Y_n,...,Y_1], entonces la reina
% colocada en (n+1,Y) no ataca a las colocadas en (1,Y_1),...,(n,Y_n).
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

% La solución es
%    ?- use_module(b_profundidad_sin_ciclos).
%    true.
%
%    ?- profundidad_sin_ciclos(S).
%    S = [[], [2], [4, 2], [1, 4, 2], [3, 1, 4, 2]]
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- profundidad_sin_ciclos(S).
%     T Call: estado_final([])
%     T Call: estado_final([1])
%     T Call: estado_final([3, 1])
%     T Call: estado_final([4, 1])
%     T Call: estado_final([2, 4, 1])
%     T Call: estado_final([2])
%     T Call: estado_final([4, 2])
%     T Call: estado_final([1, 4, 2])
%     T Call: estado_final([3, 1, 4, 2])
%    S = [[], [2], [4, 2], [1, 4, 2], [3, 1, 4, 2]]
%
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
%    true.

% Escritura de la solución
% ========================

% escribe_solucion(+S) escribe la solución S de forma gráfica. Por
% ejemplo,
%    ?- escribe_solucion([[], [2], [4, 2], [1, 4, 2], [3, 1, 4, 2]]).
%
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    true
escribe_solucion(S) :-
   reverse(S,[E|_]),
   format('~nSol: ~n'),
   escribe_estado(E).

% escribe_estado(+E) escribe el estado E de forma gráfica. Por ejemplo,
%    ?- escribe_estado([1, 4, 2]).
%     · R · ·
%     · · · R
%     R · · ·
%    true
escribe_estado(E) :-
   reverse(E,E1),
   escribe_lineas(E1).

% escribe_lineas(+L) escribe las línea de L de forma gráfica. Por
% ejemplo,
%    ?- escribe_lineas([2, 4, 1]).
%     · R · ·
%     · · · R
%     R · · ·
%    true
escribe_lineas([]).
escribe_lineas([Y|R]) :-
   escribe_linea(Y),
   escribe_lineas(R).

% escribe_linea(+Y) escribe la línea Y de forma gráfica. Por ejemplo,
%    ?- escribe_linea(2).
%     · R · ·
%    true
escribe_linea(Y) :-
   I is Y-1,
   escribe_puntos(I),
   write(' R'),
   D is 4-Y,
   escribe_puntos(D),
   nl.

% escribe_puntos(+N) escribe N puntos. Por ejemplo,
%    ?- escribe_puntos(3).
%     · · ·
%    true
escribe_puntos(0).
escribe_puntos(N) :-
   N > 0,
   write(' ·'),
   N1 is N-1,
   escribe_puntos(N1).

% Coste
% =====

% coste(+E1,+E2,?C) se verifica si el coste C de pasar del estado E1 al
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
% por colocar en el estado E.
heuristica_1(E,H) :-
   length(E,N),
   H is 4-N.

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

% lista_de_numeros_de_heuristica(?L)  se verifica si L es la lista de
% los números de heurísticas.
lista_de_numeros_de_heuristica([0,1,2]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria. Para las 4-reinas ningún
% procedimiento agota la memoria.
agotado(p_4_reinas,_) :- fail.

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P.
sin_solucion(p_4_reinas, [escalada, 0]).

% Experimentos
% ============

% Se usa el fichero experimentos.pl
%    ?- [experimentos].
%    true.

% Comparación de Procedimientos
%    ?- compara_procedimientos(p_4_reinas).
%
%    +---------------------------------------------------------------------------+
%    |                            Problema: p_4_reinas                           |
%    +---------------------------------------------------------------------------+
%
%    Procedimiento: profundidad_sin_ciclos
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    262 inferencias en 0.00 segundos y 1,104 bytes.
%
%    Procedimiento: profundidad_con_ciclos
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    293 inferencias en 0.00 segundos y 1,656 bytes.
%
%    Procedimiento: profundidad_con_cerrados
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    480 inferencias en 0.00 segundos y 5,088 bytes.
%
%    Procedimiento: profundidad_iterativa
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    1,127 inferencias en 0.00 segundos y 1,656 bytes.
%
%    Procedimiento: anchura
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    902 inferencias en 0.00 segundos y 10,488 bytes.
%
%    Procedimiento: anchura_con_cerrados
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    902 inferencias en 0.00 segundos y 9,768 bytes.
%
%    Procedimiento: optimal_exhaustiva
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    999 inferencias en 0.00 segundos y 1,936 bytes.
%
%    Procedimiento: optimal
%    Sol:
%     · · R ·
%     R · · ·
%     · · · R
%     · R · ·
%    Coste: 4
%    937 inferencias en 0.00 segundos y 12,696 bytes.
%
%    Procedimiento: escalada con heurística 0
%    Sin solución
%
%    Procedimiento: primero_el_mejor con heurística 0
%    Sol:
%     · · R ·
%     R · · ·
%     · · · R
%     · R · ·
%    Coste: 4
%    819 inferencias en 0.00 segundos y 11,160 bytes.
%
%    Procedimiento: a_estrella con heurística 0
%    Sol:
%     · · R ·
%     R · · ·
%     · · · R
%     · R · ·
%    Coste: 4
%    971 inferencias en 0.00 segundos y 14,904 bytes.
%
%    Procedimiento: escalada con heurística 1
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    700 inferencias en 0.00 segundos y 2,280 bytes.
%
%    Procedimiento: primero_el_mejor con heurística 1
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    552 inferencias en 0.00 segundos y 7,056 bytes.
%
%    Procedimiento: a_estrella con heurística 1
%    Sol:
%     · · R ·
%     R · · ·
%     · · · R
%     · R · ·
%    Coste: 4
%    1,022 inferencias en 0.00 segundos y 14,928 bytes.
%
%    Procedimiento: escalada con heurística 2
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    1,068 inferencias en 0.00 segundos y 3,680 bytes.
%
%    Procedimiento: primero_el_mejor con heurística 2
%    Sol:
%     · R · ·
%     · · · R
%     R · · ·
%     · · R ·
%    Coste: 4
%    681 inferencias en 0.00 segundos y 4,408 bytes.
%
%    Procedimiento: a_estrella con heurística 2
%    Sol:
%     · · R ·
%     R · · ·
%     · · · R
%     · R · ·
%    Coste: 4
%    1,027 inferencias en 0.00 segundos y 7,880 bytes.
%    true.

% Estadísticas
%    +---------------------------------------------------------------------------+
%    |                            Problema: p_4_reinas                           |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |   4 |          |       266 |   0.00 |      1,104 |
%    |profundidad_con_ciclos  |   4 |          |       400 |   0.00 |      2,312 |
%    |profundidad_con_cerrados|   4 |          |       688 |   0.00 |      6,424 |
%    |profundidad_iterativa   |   4 |          |     1,233 |   0.00 |      2,312 |
%    |anchura                 |   4 |          |     1,110 |   0.00 |     11,824 |
%    |anchura_con_cerrados    |   4 |          |     1,110 |   0.00 |     11,104 |
%    |optimal_exhaustiva      |   4 |          |     1,001 |   0.00 |      1,936 |
%    |optimal                 |   4 |          |     1,146 |   0.00 |    -50,552 |
%    |H=0, escalada           |     | Sin sol. |           |        |            |
%    |H=0, primero_el_mejor   |   4 |          |     1,028 |   0.00 |     12,496 |
%    |H=0, a_estrella         |   4 |          |     1,181 |   0.00 |     16,240 |
%    |H=1, escalada           |   4 |          |       807 |   0.00 |      2,936 |
%    |H=1, primero_el_mejor   |   4 |          |       552 |   0.00 |      7,056 |
%    |H=1, a_estrella         |   4 |          |     1,022 |   0.00 |    -49,152 |
%    |H=2, escalada           |   4 |          |     1,068 |   0.00 |      3,680 |
%    |H=2, primero_el_mejor   |   4 |          |       681 |   0.00 |      4,408 |
%    |H=2, a_estrella         |   4 |          |     1,027 |   0.00 |      7,880 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
