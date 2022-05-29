% p_grafo.pl
% Problema del grafo.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

% Descripción del problema
% =========================

% El problema de búsqueda correspondiente al siguiente grafo:
%
%                                  a
%                                /   \
%                              b       c
%                             /  \    /  \
%                            d    e  f    g
%                          //    /  \  \
%                         h     i    j   k
%
% donde el estado inicial es a y los estados finales son f y j.
% [Nota: el arco entre d y h es bidireccional].

% Representación del problema
% ===========================

% Un ESTADO es un átomo de la lista [a,b,c,d,e,f,g,h,i,j,k].

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
sucesor(h,d).

% Búsqueda por profundidad sin ciclos
% ===================================

% No se encuentra la solución como se observa en
%    ?- [b_profundidad_sin_ciclos].
%    true.
%
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- profundidad_sin_ciclos(S).
%    T Call:  ( 10) estado_final(a)
%    T Call:  ( 11) estado_final(b)
%    T Call:  ( 12) estado_final(d)
%    T Call:  ( 13) estado_final(h)
%    T Call:  ( 14) estado_final(d)
%    T Call:  ( 15) estado_final(h)
%    ....
%    ERROR: Stack limit (1.0Gb) exceeded
%
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
%    true.

% Búsqueda en profundidad con ciclos
% ==================================

% La solución es
%    ?- [b_profundidad_con_ciclos].
%    true.
%
%    ?- profundidad_con_ciclos(S).
%    S = [a, b, e, j]
%
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- profundidad_con_ciclos(S).
%     T Call: estado_final(a)
%     T Call: estado_final(b)
%     T Call: estado_final(d)
%     T Call: estado_final(h)
%     T Call: estado_final(e)
%     T Call: estado_final(i)
%     T Call: estado_final(j)
%    S = [a, b, e, j]
%
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
%    true.

% Búsqueda en anchura
% ===================

% La solución es
%    ?- [b_anchura].
%    true.
%
%    ?- anchura(S).
%    S = [a, c, f]
%
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- anchura(S).
%     T Call: estado_final(a)
%     T Call: estado_final(b)
%     T Call: estado_final(c)
%     T Call: estado_final(d)
%     T Call: estado_final(e)
%     T Call: estado_final(f)
%    S = [a, c, f]
%
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
%    true.
%
%    ?- trace(anchura,+call).
%    %         anchura/1: [call]
%    %         anchura/2: [call]
%    true.
%
%    ?- anchura(S).
%     T Call: anchura(_216997166)
%     T Call: anchura([[a]], _216997166)
%     T Call: anchura([[b, a], [c, a]], _216997166)
%     T Call: anchura([[c, a], [d, b, a], [e, b, a]], _216997166)
%     T Call: anchura([[d, b, a], [e, b, a], [f, c, a], [g, c, a]], _216997166)
%     T Call: anchura([[e, b, a], [f, c, a], [g, c, a], [h, d, b, a]], _216997166)
%     T Call: anchura([[f, c, a], [g, c, a], [h, d, b, a], [i, e, b, a], [j, e, b|...]], _216997166)
%    S = [a, c, f]
%
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

% coste(+E1,+E2,?C) se verifica si el coste C de pasar del estado E1 al
% E2 es 1.
coste(_,_,1).

% Heurística
% ==========

% heuristica(+E,?H) se verifica si H es la heurística del estado E.
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

% lista_de_numeros_de_heuristica(?L) se verifica si L es la lista de los
% números de heurísticas.
lista_de_numeros_de_heuristica([]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria.
agotado(p_grafo,profundidad_sin_ciclos).

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P.
sin_solucion(_,_) :- fail.

% Experimentos
% ============

% Se carga el fichero experimentos.pl
%    ?- [experimentos].
%    true.

% Estadísticas
%    ?- estadistica(p_grafo).
%
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_grafo                             |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
%    |profundidad_con_ciclos  |   3 |          |        52 |   0.00 |        552 |
%    |profundidad_con_cerrados|   3 |          |       165 |   0.00 |      3,456 |
%    |profundidad_iterativa   |   2 |          |        70 |   0.00 |        408 |
%    |anchura                 |   2 |          |       160 |   0.00 |      3,504 |
%    |anchura_con_cerrados    |   2 |          |       160 |   0.00 |      3,264 |
%    |optimal_exhaustiva      |   2 |          |       267 |   0.00 |        592 |
%    |optimal                 |   2 |          |       175 |   0.00 |      4,256 |
%    |escalada                |   2 |          |        42 |   0.00 |        672 |
%    |primero_el_mejor        |   2 |          |        79 |   0.00 |      1,800 |
%    |a_estrella              |   2 |          |        81 |   0.00 |      2,096 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
