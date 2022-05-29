% p_paseo.pl
% Problema del paseo.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% =============================================================================

% Descripción del problema
% ========================

% Una persona puede moverse en línea recta dando cada vez un paso hacia
% la derecha o hacia la izquierda. Podemos representarlo mediante su
% posición X. El valor inicial de X es 0. El problema consiste en llegar
% a la posición -3.

% Representación del problema
% ===========================

% Un ESTADO es un número entero que representa su posición.

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial(0).

% estado_final(?E) se verifica si E es un estado final.
estado_final(-3).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1.
sucesor(E1,E2) :-
   E2 is E1+1.
sucesor(E1,E2) :-
   E2 is E1-1.

% Búsqueda en profundidad sin ciclos
% ==================================

% No se resuelve el problema mediante búsqueda en profundidad siin ciclos.
%    ?- [b_profundidad_sin_ciclos].
%    true.
%
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- profundidad_sin_ciclos(S).
%     T Call: estado_final(0)
%     T Call: estado_final(1)
%     T Call: estado_final(2)
%     T Call: estado_final(3)
%     T Call: estado_final(4)
%     T Call: estado_final(5)
%     ...
%
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
%    true.

% Búsqueda en profundidad acotada
% ===============================

% Solución del problema usando búsqueda en profundidad acotada con cota
% 5.
%    ?- use_module(b_profundidad_acotada).
%    true.
%
%    ?- profundidad_acotada(S,5).
%    S = [0, -1, -2, -3]
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- profundidad_acotada(S,5).
%     T Call: estado_final(0)
%     T Call: estado_final(1)
%     T Call: estado_final(2)
%     T Call: estado_final(3)
%     T Call: estado_final(4)
%     T Call: estado_final(5)
%     T Call: estado_final(-1)
%     T Call: estado_final(-2)
%     T Call: estado_final(-3)
%    S = [0, -1, -2, -3]
%
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
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

% heuristica(+E,?H) se verifica si la heurística H del estado E.
heuristica(E,H) :-
   H is abs(-3 - E).

% Problemas
% =========

% lista_de_numeros_de_heuristica(?L) se verifica si L es la lista de los
% números de heurísticas.
lista_de_numeros_de_heuristica([]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria.
agotado(p_paseo, profundidad_sin_ciclos).
agotado(p_paseo, profundidad_con_ciclos).
agotado(p_paseo, profundidad_con_cerrados).
agotado(p_paseo, optimal_exhaustiva).

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P.
sin_solucion(_,_) :- fail.

% Experimentos
% ============

% Se usa el fichero experimentos.pl
% ?- [experimentos].
% Yes

% Comparación de procedimientos
%    ?- [experimentos].
%    true.
%
%    ?- compara_procedimientos(p_paseo).
%
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_paseo                             |
%    +---------------------------------------------------------------------------+
%
%    Procedimiento: profundidad_sin_ciclos
%    Agotado
%
%    Procedimiento: profundidad_con_ciclos
%    Agotado
%
%    Procedimiento: profundidad_con_cerrados
%    Agotado
%
%    Procedimiento: profundidad_iterativa
%    Sol: [0,-1,-2,-3]
%    Coste: 3
%    153 inferencias en 0.00 segundos y 624 bytes.
%
%    Procedimiento: anchura
%    Sol: [0,-1,-2,-3]
%    Coste: 3
%    388 inferencias en 0.00 segundos y 5,056 bytes.
%
%    Procedimiento: anchura_con_cerrados
%    Sol: [0,-1,-2,-3]
%    Coste: 3
%    403 inferencias en 0.00 segundos y 4,768 bytes.
%
%    Procedimiento: optimal_exhaustiva
%    Agotado
%
%    Procedimiento: optimal
%    Sol: [0,-1,-2,-3]
%    Coste: 3
%    381 inferencias en 0.00 segundos y 4,944 bytes.
%
%    Procedimiento: escalada
%    Sol: [0,-1,-2,-3]
%    Coste: 3
%    192 inferencias en 0.00 segundos y 1,824 bytes.
%
%    Procedimiento: primero_el_mejor
%    Sol: [0,-1,-2,-3]
%    Coste: 3
%    327 inferencias en 0.00 segundos y 3,776 bytes.
%
%    Procedimiento: a_estrella
%    Sol: [0,-1,-2,-3]
%    Coste: 3
%    327 inferencias en 0.00 segundos y 4,160 bytes.
%    true.

% Estadísticas
%    ?- estadistica(p_paseo).
%
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_paseo                             |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
%    |profundidad_con_ciclos  |     | Agotado  |           |        |            |
%    |profundidad_con_cerrados|     | Agotado  |           |        |            |
%    |profundidad_iterativa   |   3 |          |       153 |   0.00 |        624 |
%    |anchura                 |   3 |          |       180 |   0.00 |      3,720 |
%    |anchura_con_cerrados    |   3 |          |       195 |   0.00 |      3,432 |
%    |optimal_exhaustiva      |     | Agotado  |           |        |            |
%    |optimal                 |   3 |          |       172 |   0.00 |      3,608 |
%    |escalada                |   3 |          |        85 |   0.00 |      1,168 |
%    |primero_el_mejor        |   3 |          |       118 |   0.00 |      2,440 |
%    |a_estrella              |   3 |          |       117 |   0.00 |      2,824 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
