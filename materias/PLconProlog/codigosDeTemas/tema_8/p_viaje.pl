% p_viaje.pl
% problema del viaje en andalucía
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% =============================================================================

% Descripción de problema
% =======================

% + Nos encontramos en una capital andaluza (p.e. Sevilla)
% + Desamos ir a otra capital andaluza (p.e. Almería)
% + La línea de autobuses sólo tiene viajes de cada capital a sus
%   vecinas.

% Un esquema del mapa de Andalucía es:
%   HU --- SE --- CO --- JA
%      \   |  \   |  \   |
%        \ |    \ |    \ |
%          CA --- MA --- GR --- AL

% Representación del problema
% ===========================

% Un ESTADO es un elemento de la lista [almeria, cadiz, cordoba,
% granada, huelva, jaen, malaga, sevilla].

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial(sevilla).

% estado_final(?E) se verifica si E es un estado final.
estado_final(almería).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1.
sucesor(E1,E2) :-
   ( conectado(E1,E2) ; conectado(E2,E1) ).

% conectado(?E1,?E2) se verifica si E1 y E2 están conectados.
conectado(huelva,sevilla).
conectado(huelva,cádiz).
conectado(sevilla,córdoba).
conectado(sevilla,málaga).
conectado(sevilla,cádiz).
conectado(córdoba,jaén).
conectado(córdoba,granada).
conectado(córdoba,málaga).
conectado(cádiz,málaga).
conectado(málaga,granada).
conectado(jaén,granada).
conectado(granada,almería).

% Búsqueda en profundidad con ciclos
% ==================================

% Solución del problema por búsqueda en profundidad con ciclos.
%    ?- use_module(b_profundidad_con_ciclos).
%    true.
%    
%    ?- profundidad_con_ciclos(S).
%    S = [sevilla, córdoba, jaén, granada, almería] 

% Búsqueda en anchura
% ===================

% Solución del problema mediante búsqueda en anchura.
%    ?- use_module(b_anchura).
%    true.
%    
%    ?- anchura(S).
%    S = [sevilla, córdoba, granada, almería] 

% Coste
% =====

% coste(+E1,+E2,?C) se verifica si C es la distancia entre E1 y E2.
coste(E1,E2,C) :-
   coordenadas(E1,P1),
   coordenadas(E2,P2),
   distancia(P1,P2,C).

% coordenadas(E,C) se verifica si C son las coordenadas de E según la
% siguiente tabla: 
%    +---------+-------+-------+
%    | almería | 409.5 |  93   |
%    | cádiz   |  63   |  57   |
%    | córdoba | 198   | 207   |
%    | granada | 309   | 127.5 |
%    | huelva  |   3   | 139.5 |
%    | jaén    | 295.5 | 192   |
%    | málaga  | 232.5 |  75   |
%    | sevilla |  90   | 153   |
%    +---------+-------+-------+
coordenadas(almería, [409.5,  93  ]).
coordenadas(cádiz,   [ 63  ,  57  ]).
coordenadas(córdoba, [198  , 207  ]).
coordenadas(granada, [309  , 127.5]).
coordenadas(huelva,  [  3  , 139.5]).
coordenadas(jaén,    [295.5, 192  ]).
coordenadas(málaga,  [232.5,  75  ]).
coordenadas(sevilla, [ 90  , 153  ]).

% distancia([X1,Y1],[X2,Y2],D) se verifica si D es la distancia entre
% los puntos [X1,Y1] y [X2,Y2]. 
distancia([X1,Y1],[X2,Y2],D) :-
   D is sqrt((X1-X2)**2+(Y1-Y2)**2).

% Búsqueda minimal exhaustiva
% ===========================

% Solución del problema mediante búsqueda minimal exhaustiva. 
%    ?- use_module(b_optimal_exahustiva).
%    true.
%    
%    ?- optimal_exhaustiva(S), coste_camino(S,C).
%    S = [sevilla, málaga, granada, almería],
%    C = 361.48952882676883 

% Búsqueda optimal
% ================

% Solución del problema mediante búsqueda optimal.
%    ?- use_module(b_optimal).
%    true.
%    
%    ?- optimal(S), coste_camino(S,Co).
%    S = [sevilla, málaga, granada, almería],
%    Co = 361.48952882676883 

% Heurística
% ==========

% heuristica(E,H) se verifica si H es la heurística de E.
heuristica(E,H) :-
   estado_final(E1),
   coste(E,E1,H).

% Escalada
% ========

% Solución del problema mediante búsqueda en escalada.
%    ?- use_module(b_escalada).
%    true.
%    
%    ?- escalada(S).
%    S = [sevilla, málaga, granada, almería] 
%    ?- trace(escalada,+call).
%    %         b_escalada:escalada/1: [call]
%    %         b_escalada:escalada/2: [call]
%    true.
%    
%    ?- escalada(S).
%     T Call: b_escalada:escalada(_76)
%     T Call: b_escalada:escalada(325.08498888752155-[sevilla], _76)
%     T Call: b_escalada:escalada(177.91290003819284-[málaga, sevilla], _76)
%     T Call: b_escalada:escalada(106.25676449054902-[granada, málaga, sevilla], _76)
%     T Call: b_escalada:escalada(0.0-[almería, granada, málaga, sevilla], _76)
%    S = [sevilla, málaga, granada, almería] 
%    
%    ?- trace(escalada,-call).
%    %         b_escalada:escalada/1: Not tracing
%    %         b_escalada:escalada/2: Not tracing
%    true.

% Escritura de solución
% =====================

% escribe_solucion(+S) escribe la solución S.
escribe_solucion(S) :-
   format('~nSol: ~w~n',[S]).

% Problemas
% =========

% lista_de_numeros_de_heuristica(?L) se verifica si L es la lista de los
% números de heurísticas. 
lista_de_numeros_de_heuristica([]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria.
agotado(p_viaje,_) :- fail.

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P. 
sin_solucion(p_viaje,_) :- fail.

% Experimentos
% ============

% Se usa el fichero experimentos.pl
%    ?- [experimentos].
%    true.

% Comparación de procedimientos
%    ?- compara_procedimientos(p_viaje).
%    
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_viaje                             |
%    +---------------------------------------------------------------------------+
%    
%    Procedimiento: profundidad_sin_ciclos
%    Sol: [sevilla,córdoba,jaén,granada,almería]
%    Coste: 391.54918146974836
%    27 inferencias en 0.00 segundos y 144 bytes.
%    
%    Procedimiento: profundidad_con_ciclos
%    Sol: [sevilla,córdoba,jaén,granada,almería]
%    Coste: 391.54918146974836
%    43 inferencias en 0.00 segundos y 696 bytes.
%    
%    Procedimiento: profundidad_con_cerrados
%    Sol: [sevilla,córdoba,granada,almería]
%    Coste: 363.537398328421
%    376 inferencias en 0.00 segundos y 3,928 bytes.
%    
%    Procedimiento: profundidad_iterativa
%    Sol: [sevilla,córdoba,granada,almería]
%    Coste: 363.537398328421
%    330 inferencias en 0.00 segundos y 1,208 bytes.
%    
%    Procedimiento: anchura
%    Sol: [sevilla,córdoba,granada,almería]
%    Coste: 363.537398328421
%    598 inferencias en 0.00 segundos y 8,128 bytes.
%    
%    Procedimiento: anchura_con_cerrados
%    Sol: [sevilla,córdoba,granada,almería]
%    Coste: 363.537398328421
%    475 inferencias en 0.00 segundos y 5,224 bytes.
%    
%    Procedimiento: optimal_exhaustiva
%    Sol: [sevilla,málaga,granada,almería]
%    Coste: 361.48952882676883
%    2,463 inferencias en 0.00 segundos y 1,720 bytes.
%    
%    Procedimiento: optimal
%    Sol: [sevilla,málaga,granada,almería]
%    Coste: 361.48952882676883
%    1,183 inferencias en 0.00 segundos y 25,184 bytes.
%    
%    Procedimiento: escalada
%    Sol: [sevilla,málaga,granada,almería]
%    Coste: 361.48952882676883
%    201 inferencias en 0.00 segundos y 2,128 bytes.
%    
%    Procedimiento: primero_el_mejor
%    Sol: [sevilla,málaga,granada,almería]
%    Coste: 361.48952882676883
%    407 inferencias en 0.00 segundos y 4,784 bytes.
%    
%    Procedimiento: a_estrella
%    Sol: [sevilla,málaga,granada,almería]
%    Coste: 361.48952882676883
%    577 inferencias en 0.00 segundos y 7,728 bytes.
%    true.

% Estadísticas
%    ?- estadistica(p_viaje).
%    
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_viaje                             |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |391.5 |          |        24 |   0.00 |        144 |
%    |profundidad_con_ciclos  |391.5 |          |        43 |   0.00 |        696 |
%    |profundidad_con_cerrados|363.5 |          |       168 |   0.00 |      2,592 |
%    |profundidad_iterativa   |363.5 |          |       224 |   0.00 |        552 |
%    |anchura                 |363.5 |          |       390 |   0.00 |      6,792 |
%    |anchura_con_cerrados    |363.5 |          |       267 |   0.00 |      3,888 |
%    |optimal_exhaustiva      |361.5 |          |     2,463 |   0.00 |      1,720 |
%    |optimal                 |361.5 |          |     1,183 |   0.00 |     25,184 |
%    |escalada                |361.5 |          |       201 |   0.00 |      2,128 |
%    |primero_el_mejor        |361.5 |          |       198 |   0.00 |      3,448 |
%    |a_estrella              |361.5 |          |       367 |   0.00 |      6,392 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
