% p_jarras.pl
% Problema de las jarras.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% =============================================================================

% Descripción del problema
% ========================

% + Se tienen dos jarras, una de 4 litros de capacidad y otra de 3.
% + Ninguna de ellas tiene marcas de medición.
% + Se tiene una bomba que permite llenar las jarras de agua.
% + ¿Cómo se puede lograr tener exactamente 2 litros de agua en la jarra
%   de 4 litros de capacidad?.

% Representación del problema
% ===========================

% Un ESTADO es un par de números. El primero es el contenido de la jarra de 4
% litros y el segundo el de la de 3 litros.

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial(0-0).

% estado_final(?E) se verifica si E es un estado final.
estado_final(2-_).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1.
sucesor(X-Y,4-Y) :-
   X < 4.
sucesor(X-Y,X-3) :-
   Y < 3.
sucesor(X-Y,0-Y) :-
   X > 0.
sucesor(X-Y,X-0) :-
   Y > 0.
sucesor(X1-Y1,4-Y2) :-
   X1 < 4,
   T is X1+Y1,
   T >= 4,
   Y2 is Y1-(4-X1).
sucesor(X1-Y1,X2-3) :-
   Y1 < 3,
   T is X1+Y1,
   T >= 3,
   X2 is X1-(3-Y1).
sucesor(X1-Y1,X2-0) :-
   Y1 > 0,
   X2 is X1+Y1,
   X2 < 4.
sucesor(X1-Y1,0-Y2) :-
   X1 > 0,
   Y2 is X1+Y1,
   Y2 < 3.

% Búsqueda en profundidad sin ciclos.
%******************************************************************************

% No se soluciona el problema por búsqueda en profundidad sin ciclos.
%    ?- [b_profundidad_sin_ciclos].
%    true.
%
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- profundidad_sin_ciclos(S).
%     T Call: estado_final(0-0)
%     T Call: estado_final(4-0)
%     T Call: estado_final(4-3)
%     T Call: estado_final(0-3)
%     T Call: estado_final(4-3)
%     T Call: estado_final(0-3)
%     ...
%
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
%    true.


% Búsqueda en profundidad con ciclos
% ==================================

% Solución del problema por búsqueda en profundidad con ciclos.
%    ?- [b_profundidad_con_ciclos].
%    true.
%
%    ?- profundidad_con_ciclos(S).
%    S = [0-0,4-0,4-3,0-3,3-0,3-3,4-2,0-2,2-0]

% Búsqueda en profundidad acotada
% ===============================

% Solución del problema mediante búsqueda en profundidad con cota 5.
%    ?- [b_profundidad_acotada].
%    true.
%
%    ?- profundidad_acotada(S,6).
%    S = [0-0,4-0,1-3,1-0,0-1,4-1,2-3]

% Búsqueda en anchura
% ===================

% Solución del problema mediante búsqueda en anchura.
%    ?- [b_anchura].
%    true.
%
%    ?- anchura(S).
%    S = [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- anchura(S).
%     T Call: estado_final(0-0)
%     T Call: estado_final(4-0)
%     T Call: estado_final(0-3)
%     T Call: estado_final(4-3)
%     T Call: estado_final(1-3)
%     T Call: estado_final(3-0)
%     T Call: estado_final(0-3)
%     T Call: estado_final(4-3)
%     T Call: estado_final(1-0)
%     T Call: estado_final(4-0)
%     T Call: estado_final(3-3)
%     T Call: estado_final(3-0)
%     T Call: estado_final(0-3)
%     T Call: estado_final(0-1)
%     T Call: estado_final(4-3)
%     T Call: estado_final(1-3)
%     T Call: estado_final(4-2)
%     T Call: estado_final(3-3)
%     T Call: estado_final(3-0)
%     T Call: estado_final(4-1)
%     T Call: estado_final(0-3)
%     T Call: estado_final(4-3)
%     T Call: estado_final(1-0)
%     T Call: estado_final(0-2)
%     T Call: estado_final(4-0)
%     T Call: estado_final(4-2)
%     T Call: estado_final(3-3)
%     T Call: estado_final(2-3)
%    S = [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
%    true.

% Búsqueda en anchura con cerrados
% ================================

% Solución del problema mediante búsqueda en anchura con cerrados.
%    ?- [b_anchura_con_cerrados].
%    true.
%
%    ?- anchura_con_cerrados(S).
%    S = [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- anchura_con_cerrados(S).
%     T Call: estado_final(0-0)
%     T Call: estado_final(4-0)
%     T Call: estado_final(0-3)
%     T Call: estado_final(4-3)
%     T Call: estado_final(1-3)
%     T Call: estado_final(3-0)
%     T Call: estado_final(1-0)
%     T Call: estado_final(3-3)
%     T Call: estado_final(0-1)
%     T Call: estado_final(4-2)
%     T Call: estado_final(4-1)
%     T Call: estado_final(0-2)
%     T Call: estado_final(2-3)
%    S = [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%
%    ?- trace(estado_final,-all).
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

% heuristica(+E,?H) la heurística H del estado E.
heuristica(_E,0).

% Problemas
% =========

% lista_de_numeros_de_heuristica(?L) se verifica si L es la lista de los
% números de heurísticas.
lista_de_numeros_de_heuristica([]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria.
agotado(p_jarras, profundidad_sin_ciclos).

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P.
sin_solucion(p_jarras, escalada).

% Experimentos
% ============

% Se usa el fichero experimentos.pl
%    ?- [experimentos].
%    true.

% Comparación de procedimientos de búsqueda
%    ?- compara_procedimientos(p_jarras).
%
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_jarras                            |
%    +---------------------------------------------------------------------------+
%
%    Procedimiento: profundidad_sin_ciclos
%    Agotado
%
%    Procedimiento: profundidad_con_ciclos
%    Sol: [0-0,4-0,4-3,0-3,3-0,3-3,4-2,0-2,2-0]
%    Coste: 8
%    130 inferencias en 0.00 segundos y 1,608 bytes.
%
%    Procedimiento: profundidad_con_cerrados
%    Sol: [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%    Coste: 6
%    347 inferencias en 0.00 segundos y 5,064 bytes.
%
%    Procedimiento: profundidad_iterativa
%    Sol: [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%    Coste: 6
%    2,168 inferencias en 0.00 segundos y 1,320 bytes.
%
%    Procedimiento: anchura
%    Sol: [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%    Coste: 6
%    1,290 inferencias en 0.00 segundos y 24,840 bytes.
%
%    Procedimiento: anchura_con_cerrados
%    Sol: [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%    Coste: 6
%    609 inferencias en 0.00 segundos y 8,424 bytes.
%
%    Procedimiento: optimal_exhaustiva
%    Sol: [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%    Coste: 6
%    12,147 inferencias en 0.00 segundos y 1,696 bytes.
%
%    Procedimiento: optimal
%    Sol: [0-0,0-3,3-0,3-3,4-2,0-2,2-0]
%    Coste: 6
%    2,606 inferencias en 0.00 segundos y 56,296 bytes.
%
%    Procedimiento: escalada
%    Sin solución
%
%    Procedimiento: primero_el_mejor
%    Sol: [0-0,4-0,1-3,1-0,0-1,4-1,2-3]
%    Coste: 6
%    480 inferencias en 0.00 segundos y 8,424 bytes.
%
%    Procedimiento: a_estrella
%    Sol: [0-0,0-3,3-0,3-3,4-2,0-2,2-0]
%    Coste: 6
%    2,585 inferencias en 0.00 segundos y 62,440 bytes.
%    true.

% Estadísticas
%    ?- estadistica(p_jarras).
%
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_jarras                            |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
%    |profundidad_con_ciclos  |   8 |          |       130 |   0.00 |      1,608 |
%    |profundidad_con_cerrados|   6 |          |       347 |   0.00 |      5,064 |
%    |profundidad_iterativa   |   6 |          |     2,168 |   0.00 |      1,320 |
%    |anchura                 |   6 |          |     1,290 |   0.00 |     24,840 |
%    |anchura_con_cerrados    |   6 |          |       609 |   0.00 |      8,424 |
%    |optimal_exhaustiva      |   6 |          |    12,147 |   0.00 |      1,696 |
%    |optimal                 |   6 |          |     2,606 |   0.00 |     56,296 |
%    |escalada                |     | Sin sol. |           |        |            |
%    |primero_el_mejor        |   6 |          |       480 |   0.00 |      8,424 |
%    |a_estrella              |   6 |          |     2,585 |   0.00 |     62,440 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
