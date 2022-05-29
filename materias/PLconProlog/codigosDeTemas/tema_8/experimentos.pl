% experimentos.pl
% Comparación de procedimientos de búsqueda
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

% Procedimientos
% ==============

es_procedimiento(Pr) :-
   member(Pr,[profundidad_sin_ciclos,
              profundidad_con_ciclos,
              profundidad_con_cerrados,
              profundidad_iterativa,
              anchura,
              anchura_con_cerrados,
              optimal_exhaustiva,
              optimal]).
es_procedimiento(Pr) :-
   lista_de_numeros_de_heuristica([]),
   member(Pr,[escalada,
              primero_el_mejor,
              a_estrella]).
es_procedimiento([Pr,NH]) :-
   lista_de_numeros_de_heuristica(L),
   member(NH,L),
   member(Pr,[escalada,
              primero_el_mejor,
              a_estrella]).

con_procedimiento(profundidad_sin_ciclos) :-
   [b_profundidad_sin_ciclos].
con_procedimiento(profundidad_con_ciclos) :-
   [b_profundidad_con_ciclos].
con_procedimiento(profundidad_con_cerrados) :-
   [b_profundidad_con_cerrados].
con_procedimiento(profundidad_iterativa) :-
   [b_profundidad_iterativa].
con_procedimiento(anchura) :-
   [b_anchura].
con_procedimiento(anchura_con_cerrados) :-
   [b_anchura_con_cerrados].
con_procedimiento(anchura_con_punteros) :-
   [b_anchura_con_punteros].
con_procedimiento(escalada) :-
   [b_escalada].
con_procedimiento(primero_el_mejor) :-
   [b_primero_mejor].
con_procedimiento(optimal_exhaustiva) :-
   [b_optimal_exahustiva].
con_procedimiento(optimal) :-
   [b_optimal].
con_procedimiento(a_estrella) :-
   [b_a_estrella].

escribe_procedimiento([Pr,NH]) :- !,
   forma
   t('~nProcedimiento: ~w con heurística ~w',[Pr,NH]).
escribe_procedimiento(Pr) :-
   format('~nProcedimiento: ~w',Pr).

% solucion_del_problema(+Pr,?S,?I,?T,?E) se verifica si
% + Pr es un procedimiento;
% + S es la solución del problema;
% + I es el número de inferencias usados en la resolución del problema;
% + T es el tiempo utilizado (en segundos) y
% + E es el espacio usado (en bytes).
solucion_del_problema([Pr,NH],S,I,T,E) :- !,
   con_procedimiento(Pr),
   con_heuristica(NH),
   objetivo(Pr,O,S),
   tiempo(O,I,T,E).
solucion_del_problema(Pr,S,I,T,E) :-
   con_procedimiento(Pr),
   objetivo(Pr,O,S),
   tiempo(O,I,T,E).

objetivo(Pr,O,S) :-
   ( atomic(Pr)                    -> O =.. [Pr,S]
   ; Pr = [NPr,NH]                 -> O =.. [NPr,S,NH]).

tiempo(Objetivo) :-
   tiempo(Objetivo,InferenciasUsadas,TiempoUsado,GlobalUsado),
   format('~D inferencias en ~2f segundos y ~D bytes.~n',
          [InferenciasUsadas,TiempoUsado,GlobalUsado]).

tiempo(Objetivo,InferenciasUsadas,TiempoUsado,GlobalUsado) :-
   statistics(inferences, InferenciasInicial),
   statistics(cputime, TiempoInicial),
   statistics(globalused, GlobalInicial),
   ejecuta(Objetivo, Resultado),
   statistics(inferences, InferenciasFinal),
   statistics(cputime, TiempoFinal),
   statistics(globalused, GlobalFinal),
   TiempoUsado is TiempoFinal - TiempoInicial,
   InferenciasUsadas  is InferenciasFinal - InferenciasInicial,
   GlobalUsado is GlobalFinal - GlobalInicial,
   Resultado == sí.

ejecuta(Objetivo, sí) :-
   Objetivo, !.
ejecuta(_Objetivo, no).

% Comparación de procedimientos
% =============================

compara_procedimientos :-
   es_problema(P),
   compara_procedimientos(P),
   fail.
compara_procedimientos.

compara_procedimientos(P) :-
   atomic(P),
   escribe_problema(P), nl,
   con_problema(P),
   fail.
compara_procedimientos(P) :-
   atomic(P),
   es_procedimiento(Pr),
   escribe_procedimiento(Pr),
   ( agotado(P,Pr)      -> format('~nAgotado~n')
   ; sin_solucion(P,Pr) -> format('~nSin solución~n')
   ; otherwise
     -> solucion_del_problema(Pr,S,I,T,E),
        escribe_solucion(S),
        coste_camino_2(S,Co),
        format('Coste: ~w',Co),
        format('~n~D inferencias en ~2f segundos y ~D bytes.~n',
               [I,T,E])),
   fail.
compara_procedimientos(P) :-
   atomic(P).

compara_procedimientos(P-NEI) :-
   escribe_problema(P-NEI), nl,
   con_problema(P),
   con_estado_inicial(NEI),
   fail.
compara_procedimientos(P-NEI) :-
   es_procedimiento(Pr),
   escribe_procedimiento(Pr),
   ( agotado(P-NEI,Pr)      -> format('~nAgotado~n')
   ; sin_solucion(P-NEI,Pr) -> format('~nSin solución~n')
   ; otherwise
     -> solucion_del_problema(Pr,S,I,T,E),
        escribe_solucion(S),
        coste_camino_2(S,Co),
        format('Coste: ~w',Co),
        format('~n~D inferencias en ~2f segundos y ~D bytes.~n',
               [I,T,E])),
   fail.
compara_procedimientos(_P-_NEI).

% Estadística
% ===========

estadistica :-
   es_problema(P),
   estadistica(P),
   fail.
estadistica.

% estadistica(+P) se verifican todos los ejemplos y escribe las
% estadísticas en forma de tabla.
estadistica(P) :-
   atomic(P),
   escribe_problema(P),
   escribe_cabecera_en_estadistica,
   escribe_linea_en_estadistica,
   con_problema(P),
   fail.
estadistica(P) :-
   atomic(P),
   es_procedimiento(Pr),
   escribe_procedimiento_en_estadistica(Pr),
   ( agotado(P,Pr)
     -> escribe_comentario_en_estadistica('Agotado')
   ; sin_solucion(P,Pr)
     -> escribe_comentario_en_estadistica('Sin sol.')
   ; otherwise
     -> solucion_del_problema(Pr,S,I,T,E),
        coste_camino_2(S,Co),
        escribe_solucion_en_estadistica(Co,I,T,E)),
   fail.
estadistica(P) :-
   atomic(P),
   escribe_linea_en_estadistica, nl.

estadistica(P-NEI) :-
   con_problema(P),
   con_estado_inicial(NEI),
   escribe_problema(P-NEI),
   escribe_cabecera_en_estadistica,
   escribe_linea_en_estadistica,
   fail.
estadistica(P-NEI) :-
   es_procedimiento(Pr),
   escribe_procedimiento_en_estadistica(Pr),
   ( agotado(P-NEI,Pr)
     -> escribe_comentario_en_estadistica('Agotado')
   ; sin_solucion(P-NEI,Pr)
     -> escribe_comentario_en_estadistica('Sin sol.')
   ; otherwise
     -> solucion_del_problema(Pr,S,I,T,E),
        coste_camino_2(S,Co),
        escribe_solucion_en_estadistica(Co,I,T,E)),
   fail.
estadistica(_P-_NEI) :-
   escribe_linea_en_estadistica, nl.

escribe_linea_en_estadistica :-
   format('~n+~`-t~25++~`-t~6++~`-t~11++\c
           ~`-t~12++~`-t~9++~`-t~13++').

escribe_cabecera_en_estadistica :-
   format('~n| ~w~t~25+|~w~t~5+|~w~t~11+|\c
           ~w~t~12+|~w~t~8+|~w~t~13+|',
          ['Procedimiento','Coste','Comentario',
           'Inferencias','Segundos','Bytes']).

escribe_procedimiento_en_estadistica([Pr,NH]) :- !,
   format('~n|H=~w, ~w~t~25+|',[NH,Pr]).
escribe_procedimiento_en_estadistica(Pr) :-
   format('~n|~w~t~25+|',[Pr]).

escribe_solucion_en_estadistica(Co,I,T,E) :-
   integer(Co), !,
   format('~t~D~30| |~t~41| |~t~D~53| |~t~2f~62| |~t~D~75| |',
          [Co,I,T,E]).
escribe_solucion_en_estadistica(Co,I,T,E) :-
   % not(integer(Co)),
   format('~t~1f~30| |~t~41| |~t~D~53| |~t~2f~62| |~t~D~75| |',
          [Co,I,T,E]).

escribe_comentario_en_estadistica(Com) :-
   format('~t~30| | ~w~t~41| |~t~53| |~t~62| |~t~75| |',
          [Com]).

%******************************************************************************
% § Problemas
%******************************************************************************

% Pdte.: Pasar a fichero de problema.
es_problema(P) :-
   member(P,[  p_arbol
            , p_4_reinas 
            , p_8_reinas
            , p_grafo
            , p_bloques
            , p_jarras
            , p_paseo
            , p_viaje
            , p_grafo_optimal
            , p_rutas
            , p_fichas
            , p_8_puzzle-1
            , p_8_puzzle-2
            ]).

escribe_problema(P) :-
   atomic(P),
   format('~n+~`-t~76|+~n| ~tProblema: ~w~t~76||~n+~`-t~76|+',P).
escribe_problema(P-NEI) :-
   format('~n+~`-t~76|+~n| ~tProblema: ~w con estado inicial ~w~t~76||',
          [P,NEI]),
   format('~n+~`-t~76|+').

con_problema(P) :-
   flag('$load_silent',_,true),
   [P].

% coste_camino_2(+C,?Co) se verifica si Co es el coste del camino C.
coste_camino_2([_E],0).
coste_camino_2([E1,E2|R],C) :-
   coste_camino_2([E2|R],C1),
   coste(E2,E1,C2),
   C is C1+C2.

% :- ensure_loaded([b_a_estrella,
%                   b_anchura_con_cerrados,
%                   b_anchura_con_punteros,
%                   b_anchura,
%                   b_escalada,
%                   b_optimal_exahustiva,
%                   b_optimal,
%                   b_primero_mejor,
%                   b_profundidad_acotada,
%                   b_profundidad_con_cerrados,
%                   b_profundidad_con_ciclos,
%                   b_profundidad_con_punteros,
%                   b_profundidad_iterativa,
%                   b_profundidad_sin_ciclos,
%                   p_4_reinas,
%                   p_8_puzzle,
%                   p_8_reinas,
%                   p_arbol,
%                   p_bloques,
%                   p_fichas,
%                   p_grafo_nim,
%                   p_grafo_optimal,
%                   p_grafo,
%                   p_jarras,
%                   p_paseo,
%                   p_rutas,
%                   p_viaje]).

% Experimentos
% ============
% ?- [experimentos].
% true.
% 
% ?- estadistica.
% 
% +---------------------------------------------------------------------------+
% |                             Problema: p_arbol                             |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |   3 |          |        26 |   0.00 |        120 |
% |profundidad_con_ciclos  |   3 |          |        50 |   0.00 |        552 |
% |profundidad_con_cerrados|   3 |          |       160 |   0.00 |      3,456 |
% |profundidad_iterativa   |   2 |          |        70 |   0.00 |        408 |
% |anchura                 |   2 |          |       160 |   0.00 |      3,504 |
% |anchura_con_cerrados    |   2 |          |       160 |   0.00 |      3,264 |
% |optimal_exhaustiva      |   2 |          |       261 |   0.00 |        592 |
% |optimal                 |   2 |          |       175 |   0.00 |      4,256 |
% |escalada                |   2 |          |        42 |   0.00 |        672 |
% |primero_el_mejor        |   2 |          |        79 |   0.00 |      1,800 |
% |a_estrella              |   2 |          |        81 |   0.00 |      2,096 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                            Problema: p_4_reinas                           |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |   4 |          |       262 |   0.00 |      1,104 |
% |profundidad_con_ciclos  |   4 |          |       293 |   0.00 |      1,656 |
% |profundidad_con_cerrados|   4 |          |       480 |   0.00 |      5,088 |
% |profundidad_iterativa   |   4 |          |     1,127 |   0.00 |      1,656 |
% |anchura                 |   4 |          |       902 |   0.00 |     10,488 |
% |anchura_con_cerrados    |   4 |          |       902 |   0.00 |      9,768 |
% |optimal_exhaustiva      |   4 |          |       999 |   0.00 |      1,936 |
% |optimal                 |   4 |          |       937 |   0.00 |     12,696 |
% |H=0, escalada           |     | Sin sol. |           |        |            |
% |H=0, primero_el_mejor   |   4 |          |       819 |   0.00 |     11,160 |
% |H=0, a_estrella         |   4 |          |       971 |   0.00 |     14,904 |
% |H=1, escalada           |   4 |          |       700 |   0.00 |      2,280 |
% |H=1, primero_el_mejor   |   4 |          |       552 |   0.00 |      7,056 |
% |H=1, a_estrella         |   4 |          |     1,022 |   0.00 |     14,928 |
% |H=2, escalada           |   4 |          |     1,068 |   0.00 |      3,680 |
% |H=2, primero_el_mejor   |   4 |          |       681 |   0.00 |      4,408 |
% |H=2, a_estrella         |   4 |          |     1,027 |   0.00 |      7,880 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                            Problema: p_8_reinas                           |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |   8 |          |    10,218 |   0.00 |      3,696 |
% |profundidad_con_ciclos  |   8 |          |    10,568 |   0.00 |      4,728 |
% |profundidad_con_cerrados|   8 |          |    12,799 |   0.00 |     80,688 |
% |profundidad_iterativa   |   8 |          |   399,210 |   0.03 |      4,728 |
% |anchura                 |   8 |          | 1,028,935 |   0.12 |  4,297,744 |
% |anchura_con_cerrados    |   8 |          | 1,028,935 |   0.16 |  4,392,216 |
% |optimal_exhaustiva      |   8 |          |   206,836 |   0.02 |      5,200 |
% |optimal                 |   8 |          | 1,039,792 |   0.20 |  7,288,688 |
% |H=0, escalada           |     | Sin sol. |           |        |            |
% |H=0, primero_el_mejor   |   8 |          |   197,315 |   0.06 |  6,389,928 |
% |H=0, a_estrella         |   8 |          | 1,043,906 |   0.22 |  7,612,168 |
% |H=1, escalada           |   8 |          |    23,122 |   0.00 |      5,928 |
% |H=1, primero_el_mejor   |   8 |          |    14,898 |   0.00 |    165,840 |
% |H=1, a_estrella         |   8 |          | 1,050,077 |   0.23 |  7,608,808 |
% |H=2, escalada           |     | Sin sol. |           |        |            |
% |H=2, primero_el_mejor   |   8 |          |     5,046 |   0.00 |     25,048 |
% |H=2, a_estrella         |   8 |          |    24,931 |   0.00 |    191,336 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                             Problema: p_grafo                             |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
% |profundidad_con_ciclos  |   3 |          |        52 |   0.00 |        552 |
% |profundidad_con_cerrados|   3 |          |       165 |   0.00 |      3,456 |
% |profundidad_iterativa   |   2 |          |        70 |   0.00 |        408 |
% |anchura                 |   2 |          |       160 |   0.00 |      3,504 |
% |anchura_con_cerrados    |   2 |          |       160 |   0.00 |      3,264 |
% |optimal_exhaustiva      |   2 |          |       267 |   0.00 |        592 |
% |optimal                 |   2 |          |       175 |   0.00 |      4,256 |
% |escalada                |   2 |          |        42 |   0.00 |        672 |
% |primero_el_mejor        |   2 |          |        79 |   0.00 |      1,800 |
% |a_estrella              |   2 |          |        81 |   0.00 |      2,096 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                            Problema: p_bloques                            |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
% |profundidad_con_ciclos  |  58 |          |       405 |   0.00 |      7,056 |
% |profundidad_con_cerrados|  22 |          |       598 |   0.00 |     31,320 |
% |profundidad_iterativa   |   7 |          |       783 |   0.00 |      1,296 |
% |anchura                 |   7 |          |     1,573 |   0.00 |     58,752 |
% |anchura_con_cerrados    |   7 |          |     1,154 |   0.00 |     39,192 |
% |optimal_exhaustiva      |     | Agotado  |           |        |            |
% |optimal                 |   7 |          |     1,782 |   0.00 |     69,312 |
% |escalada                |     | Sin sol. |           |        |            |
% |primero_el_mejor        |   7 |          |       326 |   0.00 |     10,032 |
% |a_estrella              |   7 |          |     1,154 |   0.00 |     37,328 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                             Problema: p_jarras                            |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
% |profundidad_con_ciclos  |   8 |          |       130 |   0.00 |      1,608 |
% |profundidad_con_cerrados|   6 |          |       347 |   0.00 |      5,064 |
% |profundidad_iterativa   |   6 |          |     2,168 |   0.00 |      1,320 |
% |anchura                 |   6 |          |     1,290 |   0.00 |     24,840 |
% |anchura_con_cerrados    |   6 |          |       609 |   0.00 |      8,424 |
% |optimal_exhaustiva      |   6 |          |    12,147 |   0.00 |      1,696 |
% |optimal                 |   6 |          |     2,606 |   0.00 |     56,296 |
% |escalada                |     | Sin sol. |           |        |            |
% |primero_el_mejor        |   6 |          |       480 |   0.00 |      8,424 |
% |a_estrella              |   6 |          |     2,585 |   0.00 |     62,440 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                             Problema: p_paseo                             |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
% |profundidad_con_ciclos  |     | Agotado  |           |        |            |
% |profundidad_con_cerrados|     | Agotado  |           |        |            |
% |profundidad_iterativa   |   3 |          |       153 |   0.00 |        624 |
% |anchura                 |   3 |          |       180 |   0.00 |      3,720 |
% |anchura_con_cerrados    |   3 |          |       195 |   0.00 |      3,432 |
% |optimal_exhaustiva      |     | Agotado  |           |        |            |
% |optimal                 |   3 |          |       172 |   0.00 |      3,608 |
% |escalada                |   3 |          |        85 |   0.00 |      1,168 |
% |primero_el_mejor        |   3 |          |       118 |   0.00 |      2,440 |
% |a_estrella              |   3 |          |       117 |   0.00 |      2,824 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                             Problema: p_viaje                             |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |391.5 |          |        24 |   0.00 |        144 |
% |profundidad_con_ciclos  |391.5 |          |        43 |   0.00 |        696 |
% |profundidad_con_cerrados|363.5 |          |       168 |   0.00 |      2,592 |
% |profundidad_iterativa   |363.5 |          |       224 |   0.00 |        552 |
% |anchura                 |363.5 |          |       390 |   0.00 |      6,792 |
% |anchura_con_cerrados    |363.5 |          |       267 |   0.00 |      3,888 |
% |optimal_exhaustiva      |361.5 |          |     2,463 |   0.00 |      1,720 |
% |optimal                 |361.5 |          |     1,183 |   0.00 |     25,184 |
% |escalada                |361.5 |          |       201 |   0.00 |      2,128 |
% |primero_el_mejor        |361.5 |          |       198 |   0.00 |      3,448 |
% |a_estrella              |361.5 |          |       367 |   0.00 |      6,392 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                         Problema: p_grafo_optimal                         |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |   5 |          |        16 |   0.00 |         96 |
% |profundidad_con_ciclos  |   5 |          |        27 |   0.00 |        408 |
% |profundidad_con_cerrados|   8 |          |        69 |   0.00 |      1,152 |
% |profundidad_iterativa   |   8 |          |        28 |   0.00 |        264 |
% |anchura                 |   8 |          |        68 |   0.00 |      1,224 |
% |anchura_con_cerrados    |   8 |          |        68 |   0.00 |      1,128 |
% |optimal_exhaustiva      |   5 |          |       125 |   0.00 |        592 |
% |optimal                 |   5 |          |        85 |   0.00 |      1,592 |
% |escalada                |   8 |          |        38 |   0.00 |        408 |
% |primero_el_mejor        |   8 |          |        47 |   0.00 |        936 |
% |a_estrella              |   5 |          |        88 |   0.00 |      1,928 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                             Problema: p_rutas                             |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
% |profundidad_con_ciclos  |  56 |          |       116 |   0.00 |      1,920 |
% |profundidad_con_cerrados|  44 |          |       323 |   0.00 |      5,568 |
% |profundidad_iterativa   |  44 |          |       398 |   0.00 |        744 |
% |anchura                 |  44 |          |       622 |   0.00 |     11,832 |
% |anchura_con_cerrados    |  44 |          |       603 |   0.00 |      9,984 |
% |optimal_exhaustiva      |  31 |          |    26,341 |   0.00 |      1,960 |
% |optimal                 |  31 |          |     3,230 |   0.00 |     71,136 |
% |escalada                |     | Sin sol. |           |        |            |
% |primero_el_mejor        |  47 |          |       422 |   0.00 |      8,488 |
% |a_estrella              |  31 |          |     1,727 |   0.00 |     34,704 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                             Problema: p_fichas                            |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
% |profundidad_con_ciclos  |  81 |          |    39,927 |   0.01 |     40,656 |
% |profundidad_con_cerrados|  55 |          |    21,122 |   0.00 |    448,152 |
% |profundidad_iterativa   |  10 |          |15,384,222 |   1.87 |      6,816 |
% |anchura                 |  10 |          |   232,950 |   0.04 |  2,143,512 |
% |anchura_con_cerrados    |  10 |          |    49,992 |   0.01 |    251,760 |
% |optimal_exhaustiva      |     | Agotado  |           |        |            |
% |optimal                 |     | Agotado  |           |        |            |
% |H=0, escalada           |     | Sin sol. |           |        |            |
% |H=0, primero_el_mejor   |  15 |          |    51,176 |   0.01 |    345,552 |
% |H=0, a_estrella         |     | Agotado  |           |        |            |
% |H=1, escalada           |     | Sin sol. |           |        |            |
% |H=1, primero_el_mejor   |  15 |          |     8,379 |   0.00 |     93,000 |
% |H=1, a_estrella         |  10 |          |   222,715 |   0.07 |  5,970,656 |
% |H=2, escalada           |     | Sin sol. |           |        |            |
% |H=2, primero_el_mejor   |  10 |          |     6,804 |   0.00 |     51,624 |
% |H=2, a_estrella         |  10 |          |    26,190 |   0.00 |    301,344 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                 Problema: p_8_puzzle con estado inicial 1                 |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
% |profundidad_con_ciclos  |3,177|          |   435,097 |   0.31 |  1,812,960 |
% |profundidad_con_cerrados|     | Agotado  |           |        |            |
% |profundidad_iterativa   |   5 |          |    15,458 |   0.00 |      3,408 |
% |anchura                 |   5 |          |    15,636 |   0.00 |    118,440 |
% |anchura_con_cerrados    |   5 |          |    15,765 |   0.00 |    116,280 |
% |optimal_exhaustiva      |     | Agotado  |           |        |            |
% |optimal                 |   5 |          |    12,093 |   0.00 |    100,144 |
% |H=0, escalada           |     | Sin sol. |           |        |            |
% |H=0, primero_el_mejor   |     | Agotado  |           |        |            |
% |H=0, a_estrella         |   5 |          |    12,184 |   0.00 |    105,712 |
% |H=1, escalada           |     | Sin sol. |           |        |            |
% |H=1, primero_el_mejor   |   5 |          |     2,452 |   0.00 |     14,664 |
% |H=1, a_estrella         |   5 |          |     2,464 |   0.00 |     15,528 |
% |H=2, escalada           |   5 |          |    12,577 |   0.00 |      9,888 |
% |H=2, primero_el_mejor   |   5 |          |     6,705 |   0.00 |     12,856 |
% |H=2, a_estrella         |   5 |          |     6,715 |   0.00 |     13,584 |
% +------------------------+-----+----------+-----------+--------+------------+
% 
% +---------------------------------------------------------------------------+
% |                 Problema: p_8_puzzle con estado inicial 2                 |
% +---------------------------------------------------------------------------+
% | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
% +------------------------+-----+----------+-----------+--------+------------+
% |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
% |profundidad_con_ciclos  |  12 |          |     1,467 |   0.00 |      7,248 |
% |profundidad_con_cerrados|  12 |          |     3,964 |   0.00 |     29,904 |
% |profundidad_iterativa   |  12 |          |   881,235 |   0.11 |      7,248 |
% |anchura                 |  12 |          | 1,362,329 |   0.21 | 11,213,720 |
% |anchura_con_cerrados    |  12 |          | 1,112,410 |   0.32 |  6,032,736 |
% |optimal_exhaustiva      |     | Agotado  |           |        |            |
% |optimal                 |  12 |          | 2,053,679 |   0.56 | 15,389,200 |
% |H=0, escalada           |     | Sin sol. |           |        |            |
% |H=0, primero_el_mejor   |     | Agotado  |           |        |            |
% |H=0, a_estrella         |  12 |          | 2,058,606 |   0.61 | 15,773,952 |
% |H=1, escalada           |     | Sin sol. |           |        |            |
% |H=1, primero_el_mejor   |  54 |          |   277,352 |   0.08 |  9,610,968 |
% |H=1, a_estrella         |  12 |          |    56,827 |   0.01 |    686,808 |
% |H=2, escalada           |  12 |          |    25,953 |   0.00 |     21,400 |
% |H=2, primero_el_mejor   |  12 |          |    15,019 |   0.00 |     38,632 |
% |H=2, a_estrella         |  12 |          |    33,072 |   0.00 |     96,432 |
% +------------------------+-----+----------+-----------+--------+------------+
% true.
