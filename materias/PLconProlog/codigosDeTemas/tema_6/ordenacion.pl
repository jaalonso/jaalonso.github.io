% ordenacion.pl
% Algoritmos de ordenación.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

% Ordenación por generación y prueba
% ==================================

% ordenación(+L1,-L2) se verifica si L2 es la lista obtenida ordenando
% la lista L1 en orden creciente. Por ejemplo,
%    ?- ordenación([2,1,a,2,b,3],L).
%    L = [1, 2, 2, 3, a, b]
ordenación(L,L1) :-
   permutation(L,L1),
   ordenada(L1).

% ordenada(+L) se verifica si L es una lista ordenada (según el criterio
% de ordenación de Prolog @=<). Por ejemplo,
%    ?- ordenada([1,3,7]).
%    true
%
%    ?- ordenada([1,9,7]).
%    false.
%
%    ?- ordenada([7,3,1]).
%    false.
ordenada([]).
ordenada([_]).
ordenada([X,Y|L]) :-
   X @=< Y,
   ordenada([Y|L]).

% Ordenación por selección
% ========================

ordenación_por_selección(L1,[X|L2]) :-
   selecciona_menor(X,L1,L3),
   ordenación_por_selección(L3,L2).
ordenación_por_selección([],[]).

% seleccióna_menor(?X,+L1,?L2) se verifica si X es el menor elemento de
% la lista de números L1 y L2 son los restantes elementos. Por ejemplo,
%    ?- selecciona_menor(X,[4,1,3],L).
%    X = 1
%    L = [4, 3]
selecciona_menor(X,L1,L2) :-
   select(X,L1,L2),
   not((member(Y,L2), Y @< X)).

% Ordenación rápida
% =================

ordenación_rápida([],[]).
ordenación_rápida([X|R],Ordenada) :-
   divide(X,R,Menores,Mayores),
   ordenación_rápida(Menores,Menores_ord),
   ordenación_rápida(Mayores,Mayores_ord),
   append(Menores_ord,[X|Mayores_ord],Ordenada).

divide(_,[],[],[]).
divide(X,[Y|R],[Y|Menores],Mayores) :-
   Y @< X, !,
   divide(X,R,Menores,Mayores).
divide(X,[Y|R],Menores,[Y|Mayores]) :-
   % Y @>= X,
   divide(X,R,Menores,Mayores).

% Comparación de eficiencia
% =========================

% La comparación es
%    ?- time(ordenación([8,7,6,5,4,3,2,1],_L)).
%    % 427,048 inferences, 0.035 CPU in 0.035 seconds (100% CPU, 12095726 Lips)
%    true
%
%    ?- time(ordenación_por_selección([8,7,6,5,4,3,2,1],_L)).
%    % 366 inferences, 0.000 CPU in 0.000 seconds (97% CPU, 1868567 Lips)
%    true.
%
%    ?- time(ordenación_rápida([8,7,6,5,4,3,2,1],_L)).
%    % 115 inferences, 0.000 CPU in 0.000 seconds (91% CPU, 1901204 Lips)
%    true

% Estadísticas
% ============

% tiempo(+P,+N) calcula el tiempo de ordenar la lista
% [N,N-1,N-2,...,2,1] por el procedimiento P.
tiempo(Procedimiento,N) :-
   findall(X,between(1,N,X),L1),
   reverse(L1,L2),
   O =.. [Procedimiento,L2,_L3],
   time(O).

% +------+--------------------+-----------------------+----------------------+
% | N    | ordena             | ord_por_selección     | ordenación_rápida    |
% +------+--------------------+-----------------------+----------------------+
% |    1 |      10 inf 0.00 s |          9 inf 0.00 s |         3 inf 0.00 s |
% |    2 |      22 inf 0.00 s |         23 inf 0.00 s |        10 inf 0.00 s |
% |    4 |     256 inf 0.00 s |         80 inf 0.00 s |        33 inf 0.00 s |
% |    8 | 427,048 inf 0.03 s |        366 inf 0.00 s |       115 inf 0.00 s |
% |   16 |                    |      2,074 inf 0.00 s |       423 inf 0.00 s |
% |   32 |                    |     13,618 inf 0.00 s |     1,615 inf 0.00 s |
% |   64 |                    |     97,890 inf 0.01 s |     6,303 inf 0.00 s |
% |  128 |                    |    740,546 inf 0.08 s |    24,895 inf 0.01 s |
% |  256 |                    |  5,757,314 inf 0.34 s |    98,943 inf 0.03 s |
% |  512 |                    | 45,396,738 inf 2.58 s |   394,495 inf 0.04 s |
% | 1024 |                    |                       | 1,575,423 inf 0.16 s |
% +------+--------------------+-----------------------+----------------------+
