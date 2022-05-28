% p_bloques.pl
% Problema de los bloques.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% =============================================================================

% Descripción del problema
% ========================

% En una mesa hay una pila de bloques y sitio para otras dos pilas:
%             +---+
%             | C |
%             +---+
%             | A |
%             +---+
%             | B |
%             +---+    +---+    +---+
%
% Las operaciones que se pueden realizar son:
% - Mover el bloque situado en la cima de una pila a la mesa.
% - Mover un bloque de la mesa a la cima de una pila.
% - Mover un bloque situado en la cima de una pila a la cima de otra pila.
%
% El problema consiste en poner los bloques de la siguiente forma
%             +---+
%             | A |
%             +---+
%             | B |
%             +---+
%             | C |
%             +---+

% Representación del problema
% ===========================

% Un ESTADO es una lista de tres elementos, cada uno de los cuales es una lista
% con los elementos que la forman (el primero es la cima y el último es la
% base).

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial([[c,a,b],[],[]]).

% estado_final(?E) se verifica si E es un estado final.
estado_final(E) :-
   member([a,b,c],E).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1.
sucesor([[B|R],P2,P3],[R,[B|P2],P3]).
sucesor([[B|R],P2,P3],[R,P2,[B|P3]]).
sucesor([P1,[B|R],P3],[[B|P1],R,P3]).
sucesor([P1,[B|R],P3],[P1,R,[B|P3]]).
sucesor([P1,P2,[B|R]],[[B|P1],P2,R]).
sucesor([P1,P2,[B|R]],[P1,[B|P2],R]).

% Búsqueda en profundidad sin ciclos
% ==================================

% Con la búsqueda en profundidad sin ciclos no se encuentra solución.
%    ?- use_module(b_profundidad_sin_ciclos).
%    true.
%
%    ?- trace(estado_final,+call).
%    %         estado_final/1: [call]
%    true.
%
%    ?- profundidad_sin_ciclos(S).
%     T Call: estado_final([[c, a, b], [], []])
%     T Call: estado_final([[a, b], [c], []])
%     T Call: estado_final([[b], [a, c], []])
%     T Call: estado_final([[], [b, a, c], []])
%     T Call: estado_final([[b], [a, c], []])
%     T Call: estado_final([[], [b, a, c], []])
%     T Call: estado_final([[b], [a, c], []])
%     T Call: estado_final([[], [b, a, c], []])
%     T Call: estado_final([[b], [a, c], []])
%    ...
%
%    ?- trace(estado_final,-call).
%    %         estado_final/1: Not tracing
%    true.

% Búsqueda en profundidad con ciclos
% ==================================

% Solución del problema por búsqueda en profundidad con ciclos.
%    ?- use_module(b_profundidad_con_ciclos).
%    true.
%
%    ?- profundidad_con_ciclos(S).
%    S = [[[c,a,b], [],      []],
%         [[a,b],   [c],     []],
%         [[b],     [a,c],   []],
%         [[],      [b,a,c], []],
%         [[],      [a,c],   [b]],
%         [[a],     [c],     [b]],
%         [[],      [c],     [a,b]],
%         [[c],     [],      [a,b]],
%         [[a,c],   [],      [b]],
%         [[c],     [a],     [b]],
%         [[],      [c,a],   [b]],
%         [[],      [a],     [c,b]],
%         [[a],     [],      [c,b]],
%         [[c,a],   [],      [b]],
%         [[b,c,a], [],      []],
%         [[c,a],   [b],     []],
%         [[a],     [c,b],   []],
%         [[],      [a,c,b], []],
%         [[],      [c,b],   [a]],
%         [[c],     [b],     [a]],
%         [[],      [b],     [c,a]],
%         [[b],     [],      [c,a]],
%         [[c,b],   [],      [a]],
%         [[b],     [c],     [a]],
%         [[],      [b,c],   [a]],
%         [[],      [c],     [b,a]],
%         [[c],     [],      [b,a]],
%         [[b,c],   [],      [a]],
%         [[a,b,c], [],      []]]

% Búsqueda en profundidad acotada
% ===============================

% Solución del problema mediante búsqueda en profundidad con cota 5.
%    ?- use_module(b_profundidad_acotada).
%    true.
%
%    ?- profundidad_acotada(S,5).
%    S = [[[c,a,b], [],      []],
%         [[a,b],   [c],     []],
%         [[b],     [a,c],   []],
%         [[b],     [c],     [a]],
%         [[],      [b,c],   [a]],
%         [[],      [a,b,c], []]]

% Búsqueda en anchura
% ===================

% La solución del problema mediante búsqueda en anchura.
%    ?- use_module(b_anchura).
%    true.
%
%    ?- anchura(S).
%    S = [[[c,a,b], [],      []],
%         [[a,b],   [c],     []],
%         [[b],     [c],     [a]],
%         [[],      [b,c],   [a]],
%         [[],      [a,b,c], []]]

% Escritura de solución
% =====================

% escribe_solucion(+S) escribe la solución S. Por ejemplo,
%    ?- escribe_solucion([[[c,a,b],[],[]],[[a,b],[c],[]],[[b],[c],[a]]]).
%
%    Sol:
%      [c,a,b]    []         []
%      [a,b]      [c]        []
%      [b]        [c]        [a]
%    true.
escribe_solucion(S) :-
   format('~nSol:'),
   escribe_estados(S).

% escribe_solucion(+L) escribe la lista de estados L. Por ejemplo,
%    ?- escribe_estados([[[c,a,b],[],[]],[[],[a,b,c],[]],[[],[],[a,b,c]]]).
%
%      [c,a,b]    []         []
%      []         [a,b,c]    []
%      []         []         [a,b,c]
%    true.
escribe_estados([E|R]) :-
   escribe_estado(E),
   escribe_estados(R).
escribe_estados([]) :- nl.

% escribe_estado(+E) escribe el estado E. Por ejemplo.
%    ?- escribe_estado([[c, a, b], [], []]).
%
%      [c,a,b]    []         []
%    true.
escribe_estado([X,Y,Z]) :-
   format('~n  ~w~t~11+  ~w~t~11+  ~w~t~11+',[X,Y,Z]).

% Coste
% =====

% coste(+E1,+E2,?C) se verifica si el coste C de pasar del estado E1 al
% E2 es 1 es 1, 2 ó 3 según se mueva el cloque a, b ó c.
coste(E1,E2,C) :-
   bloque_movido(E1,E2,X),
   ( X = a -> C = 1
   ; X = b -> C = 2
   ; X = c -> C = 3).

% bloque_movido(+E1,+E2,?X) se verifica si X es el bloque movido al
% pasar del estado E1 al E2.
bloque_movido([[X|R]|_],[R|_],X).
bloque_movido([_|R1],[_|R2],X) :-
   bloque_movido(R1,R2,X).

% Heurística
% ==========

% heuristica(+E,?H) se verifica si la heurística H del estado E.
heuristica(E,H) :-
   ( memberchk([a,b,c],E) -> H=0
   ; memberchk([b,c],E)   -> H=1
   ; memberchk([c],E)     -> H=2
   ; otherwise            -> H=3).

% Problemas
% =========

% lista_de_numeros_de_heuristica(?L) se verifica si L es la lista de los
% números de heurísticas.
lista_de_numeros_de_heuristica([]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria.
agotado(p_bloques,profundidad_sin_ciclos).
agotado(p_bloques,optimal_exhaustiva).

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P.
sin_solucion(p_bloques,escalada).

% Experimentos
% ============

% Se usa el fichero experimentos.pl
% ?- [experimentos].
% Yes

% Comparación de procedimientos de búsqueda
%    ?- compara_procedimientos(p_bloques).
%
%    +---------------------------------------------------------------------------+
%    |                            Problema: p_bloques                            |
%    +---------------------------------------------------------------------------+
%
%    Procedimiento: profundidad_sin_ciclos
%    Agotado
%
%    Procedimiento: profundidad_con_ciclos
%    Sol:
%      [c,a,b]    []         []
%      [a,b]      [c]        []
%      [b]        [a,c]      []
%      []         [b,a,c]    []
%      []         [a,c]      [b]
%      [a]        [c]        [b]
%      []         [c]        [a,b]
%      [c]        []         [a,b]
%      [a,c]      []         [b]
%      [c]        [a]        [b]
%      []         [c,a]      [b]
%      []         [a]        [c,b]
%      [a]        []         [c,b]
%      [c,a]      []         [b]
%      [b,c,a]    []         []
%      [c,a]      [b]        []
%      [a]        [c,b]      []
%      []         [a,c,b]    []
%      []         [c,b]      [a]
%      [c]        [b]        [a]
%      []         [b]        [c,a]
%      [b]        []         [c,a]
%      [c,b]      []         [a]
%      [b]        [c]        [a]
%      []         [b,c]      [a]
%      []         [c]        [b,a]
%      [c]        []         [b,a]
%      [b,c]      []         [a]
%      [a,b,c]    []         []
%    Coste: 58
%    405 inferencias en 0.00 segundos y 7,056 bytes.
%
%    Procedimiento: profundidad_con_cerrados
%    Sol:
%      [c,a,b]    []         []
%      [a,b]      [c]        []
%      [b]        [a,c]      []
%      []         [a,c]      [b]
%      [a]        [c]        [b]
%      [c,a]      []         [b]
%      [c,a]      [b]        []
%      [a]        [c,b]      []
%      []         [c,b]      [a]
%      [c]        [b]        [a]
%      [b,c]      []         [a]
%      [a,b,c]    []         []
%    Coste: 22
%    598 inferencias en 0.00 segundos y 31,320 bytes.
%
%    Procedimiento: profundidad_iterativa
%    Sol:
%      [c,a,b]    []         []
%      [a,b]      [c]        []
%      [b]        [c]        [a]
%      []         [b,c]      [a]
%      []         [a,b,c]    []
%    Coste: 7
%    783 inferencias en 0.00 segundos y 1,296 bytes.
%
%    Procedimiento: anchura
%    Sol:
%      [c,a,b]    []         []
%      [a,b]      [c]        []
%      [b]        [c]        [a]
%      []         [b,c]      [a]
%      []         [a,b,c]    []
%    Coste: 7
%    1,573 inferencias en 0.00 segundos y 58,752 bytes.
%
%    Procedimiento: anchura_con_cerrados
%    Sol:
%      [c,a,b]    []         []
%      [a,b]      [c]        []
%      [b]        [c]        [a]
%      []         [b,c]      [a]
%      []         [a,b,c]    []
%    Coste: 7
%    1,154 inferencias en 0.00 segundos y 39,192 bytes.
%
%    Procedimiento: optimal_exhaustiva
%    Agotado
%
%    Procedimiento: optimal
%    Sol:
%      [c,a,b]    []         []
%      [a,b]      []         [c]
%      [b]        [a]        [c]
%      []         [a]        [b,c]
%      []         []         [a,b,c]
%    Coste: 7
%    1,782 inferencias en 0.00 segundos y 69,312 bytes.
%
%    Procedimiento: escalada
%    Sin solución
%
%    Procedimiento: primero_el_mejor
%    Sol:
%      [c,a,b]    []         []
%      [a,b]      []         [c]
%      [b]        [a]        [c]
%      []         [a]        [b,c]
%      []         []         [a,b,c]
%    Coste: 7
%    327 inferencias en 0.00 segundos y 10,032 bytes.
%
%    Procedimiento: a_estrella
%    Sol:
%      [c,a,b]    []         []
%      [a,b]      []         [c]
%      [b]        [a]        [c]
%      []         [a]        [b,c]
%      []         []         [a,b,c]
%    Coste: 7
%    1,154 inferencias en 0.00 segundos y 37,328 bytes.
%    true.

% Estadísticas
%    ?- estadistica(p_bloques).
%
%    +---------------------------------------------------------------------------+
%    |                            Problema: p_bloques                            |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
%    |profundidad_con_ciclos  |  58 |          |       405 |   0.00 |      7,056 |
%    |profundidad_con_cerrados|  22 |          |       598 |   0.00 |     31,320 |
%    |profundidad_iterativa   |   7 |          |       783 |   0.00 |      1,296 |
%    |anchura                 |   7 |          |     1,573 |   0.00 |     58,752 |
%    |anchura_con_cerrados    |   7 |          |     1,154 |   0.00 |     39,192 |
%    |optimal_exhaustiva      |     | Agotado  |           |        |            |
%    |optimal                 |   7 |          |     1,782 |   0.00 |     69,312 |
%    |escalada                |     | Sin sol. |           |        |            |
%    |primero_el_mejor        |   7 |          |       326 |   0.00 |     10,032 |
%    |a_estrella              |   7 |          |     1,154 |   0.00 |     37,328 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
