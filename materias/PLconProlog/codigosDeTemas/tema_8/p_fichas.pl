% p_fichas.pl
% Problema de las fichas (Flach-94 p. 118).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

% Descripción del problema
% ========================

% Se considera un tablero con 7 cuadrados consecutivos. Inicialmente, en
% cada uno de los 3 primeros cuadrados hay una ficha blanca y en cada
% uno de los 3 últimos cuadrados hay una ficha verde. El objetivo
% consiste en tener las fichas verdes al principiocipio y las blancas al
% final.
%
% La situación inicial es
%    +---+---+---+---+---+---+---+
%    | B | B | B |   | V | V | V |
%    +---+---+---+---+---+---+---+
% y la final es
%    +---+---+---+---+---+---+---+
%    | V | V | V |   | B | B | B |
%    +---+---+---+---+---+---+---+
%
% Los movimientos permitidos consisten en desplazar una ficha al hueco
% saltando, como máximo, sobre otras dos.

% Representación del problema
% ===========================

% Un ESTADO es una lista de siete elementos representando cada una de
% las fichas (B=blanca, V=verde) y el hueco (H).

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial([b,b,b,h,v,v,v]).

% estado_final(?E) se verifica si E es un estado final.
estado_final([v,v,v,h,b,b,b]).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1. Por
% ejemplo,
%    ?- sucesor([v, v, v, h, b, b, b],E).
%    E = [v, v, h, v, b, b, b] ;
%    E = [v, h, v, v, b, b, b] ;
%    E = [h, v, v, v, b, b, b] ;
%    E = [v, v, v, b, h, b, b] ;
%    E = [v, v, v, b, b, h, b] ;
%    E = [v, v, v, b, b, b, h] ;
%    No
sucesor(E1,E2) :-
   descompone(I,[F,h],D,E1),
   compone(I,[h,F],D,E2).
sucesor(E1,E2) :-
   descompone(I,[F,G,h],D,E1),
   compone(I,[h,G,F],D,E2).
sucesor(E1,E2) :-
   descompone(I,[F,G,H,h],D,E1),
   compone(I,[h,G,H,F],D,E2).
sucesor(E1,E2) :-
   descompone(I,[h,F],D,E1),
   compone(I,[F,h],D,E2).
sucesor(E1,E2) :-
   descompone(I,[h,G,F],D,E1),
   compone(I,[F,G,h],D,E2).
sucesor(E1,E2) :-
   descompone(I,[h,G,H,F],D,E1),
   compone(I,[F,G,H,h],D,E2).

% descompone(?L1,?L2,?L3,+L4) se verifica si L4 es la concatenación de
% las listas L1, L2 y L3.
descompone(L1,L2,L3,L4) :-
   append(L12,L3,L4),
   append(L1,L2,L12).

% compone(+L1,+L2,+L3,?L4) se verifica si L4 es la concatenación de las
% listas L1, L2 y L3.
compone(L1,L2,L3,L4) :-
   append(L1,L2,L12),
   append(L12,L3,L4).

% Heurística
% ==========

% Se considera la heurística que para cada estado vale la suma de piezas
% blancas situadas a la izquierda de cada una de las piezas verdes. Por
% ejemplo, para el estado
%    +---+---+---+---+---+---+---+
%    | B | V | B |   | V | V | B |
%    +---+---+---+---+---+---+---+
% su valor es 1+2+2 = 5.

heuristica([v|R],H) :-
   heuristica(R,H).
heuristica([h|R],H) :-
   heuristica(R,H).
heuristica([b|R],H) :-
   heuristica(R,H1),
   verdes(R,N),
   H is N+H1.
heuristica([],0).

verdes([v|R],N) :-
   verdes(R,N1),
   N is N1+1.
verdes([h|R],N) :-
   verdes(R,N).
verdes([b|R],N) :-
   verdes(R,N).
verdes([],0).

% Coste
% =====

% coste(+E1,+E2,?C) se verifica si C es el coste de pasar del estado E1
% al E2 (siempre es 1).
coste(_E1,_E2,1).

% Heurística 2
% =============

% Nota: Se usarán dos heurísticas definidas por heurística_1 y
% heurística_2

% con_heuristica(+NH) redefine heuristica(E,H) como heuristica_NH(E,H).
con_heuristica(NH) :-
   abolish(heuristica,2),
   ( NH=0 -> assert(heuristica(E,H) :- heuristica_0(E,H))
   ; NH=1 -> assert(heuristica(E,H) :- heuristica_1(E,H))
   ; NH=2 -> assert(heuristica(E,H) :- heuristica_2(E,H))).

% heuristica_0(+E,?H) se verifica que la heurística H del estado E es
% 0.
heuristica_0(_E,0).

% heuristica_1(+E,?H) se verifica que la heurística H es la suma de
% piezas blancas situadas a la izquierda de cada una de las piezas
% verdes en el estado E.
heuristica_1([v|R],H) :-
   heuristica_1(R,H).
heuristica_1([h|R],H) :-
   heuristica_1(R,H).
heuristica_1([b|R],H) :-
   heuristica_1(R,H1),
   verdes(R,N),
   H is N+H1.
heuristica_1([],0).

% heuristica_2(+E,?H) se verifica que la heurística H es el número de
% piezas descolocadas ponderada por 3 si está en los lugares 1 ó 7, 2 si
% está en los lugares 2 ó 6 y 1 si están en los lugares 3 ó 5.
heuristica_2(E,H) :-
   estado_final(EF),
   heuristica_2(E,EF,[3,2,1,0,1,2,3],H).

% heuristica_2(+L1,+L2,+L3,?H) se verifica si
% + L1 y L2 son subestados de la misma longitud,
% + L3 es una lista de números de la misma longitud que L1 y
% + H es la suma de los elementos de L3 correspondientes a los índices
%   para los que la listas L1 y L2 tienen fichas distintas.
heuristica_2([X|R1],[Y|R2],[N|R3],H) :-
   heuristica_2(R1,R2,R3,H1),
   ( fichas_distintas(X,Y) -> H is N+H1
   ; otherwise             -> H is H1).
heuristica_2([],[],[],0).

% fichas_distintas(+X,+Y) se verifica si X e Y son dos fichas
% distintas.
fichas_distintas(X,Y) :-
   memberchk(X,[b,v]),
   memberchk(Y,[b,v]),
   X \= Y.

% Solución del problema por primero el mejor con la segunda heurística.
%    ?- [b_primero_mejor].
%    true.
%    
%    ?- set_prolog_flag(answer_write_options, [quoted(true), portray(true), max_depth(20)]).
%    true.
%    
%    ?- con_heuristica(2), primero_el_mejor(S).
%    S = [[b,b,b,h,v,v,v],
%         [b,b,b,v,v,h,v],
%         [b,b,h,v,v,b,v],
%         [h,b,b,v,v,b,v],
%         [v,b,b,h,v,b,v],
%         [v,b,b,v,v,b,h],
%         [v,b,b,v,v,h,b],
%         [v,b,h,v,v,b,b],
%         [v,b,v,v,h,b,b],
%         [v,h,v,v,b,b,b],
%         [v,v,v,h,b,b,b]] 

% Escritura de la solución
% ========================

% escribe_solucion(+S) escribe la solución.
escribe_solucion(S) :-
   format('~nSol: ~n'),
   escribe_lista(S).

escribe_lista([]).
escribe_lista([X|L]) :-
   write(X), nl,
   escribe_lista(L).

% Problemas
% =========

% lista_de_numeros_de_heuristica(?L) se verifica si L es la lista de los
% números de heurísticas. 
lista_de_numeros_de_heuristica([0,1,2]).

% agotado(+P,+Pr) se verifica si la resolución del problema P mediante
% el procedimiento Pr agota la memoria.
agotado(p_fichas, profundidad_sin_ciclos).
agotado(p_fichas, optimal_exhaustiva).
agotado(p_fichas, optimal).
agotado(p_fichas, [a_estrella, 0]).

% sin_solucion(+P,+Pr) se verifica si el procedimiento Pr no encuentra
% solución al problema P. 
sin_solucion(p_fichas,[escalada, _NH]).

% Experimentos
% ============

% se usa el fichero experimentos.pl

% ?- ['experimentos'].
% Yes

% Comparación de procedimientos
%    ?- compara_procedimientos(p_fichas).
%    
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_fichas                            |
%    +---------------------------------------------------------------------------+
%    
%    Procedimiento: profundidad_sin_ciclos
%    Agotado
%    
%    Procedimiento: profundidad_con_ciclos
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,b,h,b,v,v,v]
%    [b,h,b,b,v,v,v]
%    [b,v,b,b,h,v,v]
%    [b,v,b,h,b,v,v]
%    [b,v,h,b,b,v,v]
%    [b,h,v,b,b,v,v]
%    [h,b,v,b,b,v,v]
%    [v,b,h,b,b,v,v]
%    [v,h,b,b,b,v,v]
%    [v,b,b,h,b,v,v]
%    [h,b,b,v,b,v,v]
%    [b,h,b,v,b,v,v]
%    [b,b,h,v,b,v,v]
%    [b,b,v,h,b,v,v]
%    [b,b,v,b,h,v,v]
%    [b,b,v,b,v,h,v]
%    [b,b,v,h,v,b,v]
%    [b,b,h,v,v,b,v]
%    [b,h,b,v,v,b,v]
%    [h,b,b,v,v,b,v]
%    [v,b,b,h,v,b,v]
%    [v,b,h,b,v,b,v]
%    [v,h,b,b,v,b,v]
%    [h,v,b,b,v,b,v]
%    [b,v,h,b,v,b,v]
%    [b,h,v,b,v,b,v]
%    [b,v,v,b,h,b,v]
%    [b,v,v,h,b,b,v]
%    [b,v,h,v,b,b,v]
%    [b,h,v,v,b,b,v]
%    [h,b,v,v,b,b,v]
%    [v,b,h,v,b,b,v]
%    [v,h,b,v,b,b,v]
%    [h,v,b,v,b,b,v]
%    [v,v,b,h,b,b,v]
%    [v,v,h,b,b,b,v]
%    [v,h,v,b,b,b,v]
%    [v,b,v,h,b,b,v]
%    [v,b,v,b,h,b,v]
%    [v,b,v,b,b,h,v]
%    [v,b,v,b,b,v,h]
%    [v,b,v,b,h,v,b]
%    [v,b,v,h,b,v,b]
%    [v,b,h,v,b,v,b]
%    [v,h,b,v,b,v,b]
%    [h,v,b,v,b,v,b]
%    [b,v,h,v,b,v,b]
%    [b,h,v,v,b,v,b]
%    [b,v,v,h,b,v,b]
%    [h,v,v,b,b,v,b]
%    [v,h,v,b,b,v,b]
%    [v,v,h,b,b,v,b]
%    [v,v,b,h,b,v,b]
%    [v,v,b,b,h,v,b]
%    [v,h,b,b,v,v,b]
%    [h,v,b,b,v,v,b]
%    [b,v,h,b,v,v,b]
%    [b,h,v,b,v,v,b]
%    [h,b,v,b,v,v,b]
%    [v,b,h,b,v,v,b]
%    [v,b,b,h,v,v,b]
%    [h,b,b,v,v,v,b]
%    [b,h,b,v,v,v,b]
%    [b,v,b,h,v,v,b]
%    [b,v,b,v,h,v,b]
%    [b,v,b,v,v,h,b]
%    [b,v,h,v,v,b,b]
%    [b,h,v,v,v,b,b]
%    [h,b,v,v,v,b,b]
%    [v,b,h,v,v,b,b]
%    [v,h,b,v,v,b,b]
%    [h,v,b,v,v,b,b]
%    [v,v,b,h,v,b,b]
%    [v,v,h,b,v,b,b]
%    [v,h,v,b,v,b,b]
%    [v,b,v,h,v,b,b]
%    [v,b,v,v,h,b,b]
%    [v,h,v,v,b,b,b]
%    [h,v,v,v,b,b,b]
%    [v,v,h,v,b,b,b]
%    [v,v,v,h,b,b,b]
%    Coste: 81
%    40,136 inferencias en 0.01 segundos y 41,992 bytes.
%    
%    Procedimiento: profundidad_con_cerrados
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,b,h,b,v,v,v]
%    [b,b,v,b,h,v,v]
%    [b,b,v,h,b,v,v]
%    [b,b,h,v,b,v,v]
%    [b,h,b,v,b,v,v]
%    [b,v,b,h,b,v,v]
%    [b,v,h,b,b,v,v]
%    [b,v,v,b,b,h,v]
%    [b,v,v,b,h,b,v]
%    [b,v,h,b,v,b,v]
%    [h,v,b,b,v,b,v]
%    [v,h,b,b,v,b,v]
%    [v,b,h,b,v,b,v]
%    [h,b,v,b,v,b,v]
%    [b,b,v,h,v,b,v]
%    [b,b,h,v,v,b,v]
%    [b,h,b,v,v,b,v]
%    [b,v,b,v,h,b,v]
%    [b,v,h,v,b,b,v]
%    [b,h,v,v,b,b,v]
%    [h,b,v,v,b,b,v]
%    [v,b,h,v,b,b,v]
%    [v,h,b,v,b,b,v]
%    [v,v,b,h,b,b,v]
%    [v,v,b,b,b,h,v]
%    [v,v,b,b,b,v,h]
%    [v,v,b,b,h,v,b]
%    [v,v,h,b,b,v,b]
%    [v,h,v,b,b,v,b]
%    [v,b,v,h,b,v,b]
%    [v,b,h,v,b,v,b]
%    [v,h,b,v,b,v,b]
%    [h,v,b,v,b,v,b]
%    [b,v,h,v,b,v,b]
%    [b,h,v,v,b,v,b]
%    [b,b,v,v,h,v,b]
%    [b,b,v,h,v,v,b]
%    [b,h,v,b,v,v,b]
%    [b,v,h,b,v,v,b]
%    [b,v,b,h,v,v,b]
%    [b,h,b,v,v,v,b]
%    [h,b,b,v,v,v,b]
%    [v,b,b,h,v,v,b]
%    [v,b,h,b,v,v,b]
%    [v,b,v,b,v,h,b]
%    [v,b,v,h,v,b,b]
%    [v,b,h,v,v,b,b]
%    [v,h,b,v,v,b,b]
%    [h,v,b,v,v,b,b]
%    [b,v,h,v,v,b,b]
%    [b,v,v,h,v,b,b]
%    [h,v,v,b,v,b,b]
%    [v,v,h,b,v,b,b]
%    [v,v,v,b,h,b,b]
%    [v,v,v,h,b,b,b]
%    Coste: 55
%    21,229 inferencias en 0.01 segundos y 242,792 bytes.
%    
%    Procedimiento: profundidad_iterativa
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,h,b,b,v,v,v]
%    [b,v,b,b,h,v,v]
%    [b,v,h,b,b,v,v]
%    [b,v,v,b,b,h,v]
%    [b,v,v,b,b,v,h]
%    [b,v,v,h,b,v,b]
%    [h,v,v,b,b,v,b]
%    [v,v,h,b,b,v,b]
%    [v,v,v,b,b,h,b]
%    [v,v,v,h,b,b,b]
%    Coste: 10
%    15,384,328 inferencias en 1.77 segundos y 7,472 bytes.
%    
%    Procedimiento: anchura
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,h,b,b,v,v,v]
%    [b,v,b,b,h,v,v]
%    [b,v,h,b,b,v,v]
%    [b,v,v,b,b,h,v]
%    [b,v,v,b,b,v,h]
%    [b,v,v,h,b,v,b]
%    [h,v,v,b,b,v,b]
%    [v,v,h,b,b,v,b]
%    [v,v,v,b,b,h,b]
%    [v,v,v,h,b,b,b]
%    Coste: 10
%    233,057 inferencias en 0.03 segundos y 118,352 bytes.
%    
%    Procedimiento: anchura_con_cerrados
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,h,b,b,v,v,v]
%    [b,v,b,b,h,v,v]
%    [b,v,h,b,b,v,v]
%    [b,v,v,b,b,h,v]
%    [b,v,v,b,b,v,h]
%    [b,v,v,h,b,v,b]
%    [h,v,v,b,b,v,b]
%    [v,v,h,b,b,v,b]
%    [v,v,v,b,b,h,b]
%    [v,v,v,h,b,b,b]
%    Coste: 10
%    50,099 inferencias en 0.01 segundos y -246,136 bytes.
%    
%    Procedimiento: optimal_exhaustiva
%    Agotado
%    
%    Procedimiento: optimal
%    Agotado
%    
%    Procedimiento: escalada con heurística 0
%    Sin solución
%    
%    Procedimiento: primero_el_mejor con heurística 0
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,b,h,b,v,v,v]
%    [b,b,v,b,h,v,v]
%    [b,b,v,b,v,v,h]
%    [b,b,v,h,v,v,b]
%    [b,b,h,v,v,v,b]
%    [b,h,b,v,v,v,b]
%    [b,v,b,h,v,v,b]
%    [b,v,b,v,v,h,b]
%    [b,v,h,v,v,b,b]
%    [b,h,v,v,v,b,b]
%    [h,b,v,v,v,b,b]
%    [v,b,h,v,v,b,b]
%    [v,b,v,v,h,b,b]
%    [v,h,v,v,b,b,b]
%    [v,v,v,h,b,b,b]
%    Coste: 15
%    51,284 inferencias en 0.01 segundos y -137,320 bytes.
%    
%    Procedimiento: a_estrella con heurística 0
%    Agotado
%    
%    Procedimiento: escalada con heurística 1
%    Sin solución
%    
%    Procedimiento: primero_el_mejor con heurística 1
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,b,b,v,h,v,v]
%    [b,b,h,v,b,v,v]
%    [b,b,v,v,b,h,v]
%    [b,b,v,v,b,v,h]
%    [b,b,v,v,h,v,b]
%    [b,h,v,v,b,v,b]
%    [b,v,h,v,b,v,b]
%    [b,v,v,v,b,h,b]
%    [b,v,v,v,h,b,b]
%    [b,v,h,v,v,b,b]
%    [h,v,b,v,v,b,b]
%    [v,v,b,h,v,b,b]
%    [v,v,b,v,h,b,b]
%    [v,v,h,v,b,b,b]
%    [v,v,v,h,b,b,b]
%    Coste: 15
%    8,379 inferencias en 0.00 segundos y 93,000 bytes.
%    
%    Procedimiento: a_estrella con heurística 1
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,b,b,v,v,h,v]
%    [b,b,h,v,v,b,v]
%    [h,b,b,v,v,b,v]
%    [v,b,b,h,v,b,v]
%    [v,b,b,v,v,b,h]
%    [v,b,b,v,v,h,b]
%    [v,b,h,v,v,b,b]
%    [v,b,v,v,h,b,b]
%    [v,h,v,v,b,b,b]
%    [v,v,v,h,b,b,b]
%    Coste: 10
%    222,824 inferencias en 0.07 segundos y 1,949,504 bytes.
%    
%    Procedimiento: escalada con heurística 2
%    Sin solución
%    
%    Procedimiento: primero_el_mejor con heurística 2
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,b,b,v,v,h,v]
%    [b,b,h,v,v,b,v]
%    [h,b,b,v,v,b,v]
%    [v,b,b,h,v,b,v]
%    [v,b,b,v,v,b,h]
%    [v,b,b,v,v,h,b]
%    [v,b,h,v,v,b,b]
%    [v,b,v,v,h,b,b]
%    [v,h,v,v,b,b,b]
%    [v,v,v,h,b,b,b]
%    Coste: 10
%    6,805 inferencias en 0.00 segundos y 51,624 bytes.
%    
%    Procedimiento: a_estrella con heurística 2
%    Sol: 
%    [b,b,b,h,v,v,v]
%    [b,h,b,b,v,v,v]
%    [b,v,b,b,h,v,v]
%    [b,v,b,b,v,v,h]
%    [b,v,b,h,v,v,b]
%    [h,v,b,b,v,v,b]
%    [v,h,b,b,v,v,b]
%    [v,v,b,b,h,v,b]
%    [v,v,h,b,b,v,b]
%    [v,v,v,b,b,h,b]
%    [v,v,v,h,b,b,b]
%    Coste: 10
%    26,190 inferencias en 0.01 segundos y 301,344 bytes.
%    true.

% Estadísticas
%    ?- estadistica(p_fichas).
%    
%    +---------------------------------------------------------------------------+
%    |                             Problema: p_fichas                            |
%    +---------------------------------------------------------------------------+
%    | Procedimiento          |Coste|Comentario|Inferencias|Segundos|Bytes       |
%    +------------------------+-----+----------+-----------+--------+------------+
%    |profundidad_sin_ciclos  |     | Agotado  |           |        |            |
%    |profundidad_con_ciclos  |  81 |          |    39,927 |   0.01 |     40,656 |
%    |profundidad_con_cerrados|  55 |          |    21,122 |   0.00 |    448,152 |
%    |profundidad_iterativa   |  10 |          |15,384,222 |   1.77 |      6,816 |
%    |anchura                 |  10 |          |   232,950 |   0.04 | -1,867,720 |
%    |anchura_con_cerrados    |  10 |          |    49,992 |   0.01 |    251,760 |
%    |optimal_exhaustiva      |     | Agotado  |           |        |            |
%    |optimal                 |     | Agotado  |           |        |            |
%    |H=0, escalada           |     | Sin sol. |           |        |            |
%    |H=0, primero_el_mejor   |  15 |          |    51,176 |   0.01 |    345,552 |
%    |H=0, a_estrella         |     | Agotado  |           |        |            |
%    |H=1, escalada           |     | Sin sol. |           |        |            |
%    |H=1, primero_el_mejor   |  15 |          |     8,379 |   0.00 |     93,000 |
%    |H=1, a_estrella         |  10 |          |   222,715 |   0.07 |  2,554,576 |
%    |H=2, escalada           |     | Sin sol. |           |        |            |
%    |H=2, primero_el_mejor   |  10 |          |     6,804 |   0.00 |     51,624 |
%    |H=2, a_estrella         |  10 |          |    26,190 |   0.00 |    301,344 |
%    +------------------------+-----+----------+-----------+--------+------------+
%    true.
