% N_reinas.pl
% El problema de las N reinas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 23-mayo-2022
% =============================================================================

% Enunciado
% =========

% Colocar N reinas en un tablero cuadrado de dimensiones N por N de forma que
% no se encuentren más de una en la misma línea (horizontal, vertical o
% diagonal).

% 1ª solución
% ===========

% reinas_1(+N,-S) se verifica si S es una solución del problema de las N
% reinas. Por ejemplo,
%    ?- reinas_1(4,S).
%    S = [1-3, 2-1, 3-4, 4-2] ;
%    S = [1-2, 2-4, 3-1, 4-3] ;
%    false.
%
%    ?- reinas_1(8,S).
%    S = [1-4, 2-2, 3-7, 4-3, 5-6, 6-8, 7-5, 8-1]
%
%    ?- findall(S,reinas_1(8,S),_L), length(_L,N).
%    N = 92.
reinas_1(N,S) :-
   tablero(N,S),
   solución(N,S).

% tablero(N,L) se verifica si L es una lista de posiciones que representan las
% coordenadas de N reinas en el tablero. Por ejemplo,
%    ?- tablero(4,L).
%    L = [1-_8750, 2-_8738, 3-_8726, 4-_8714].
tablero(N,L) :-
  findall(X-_Y,between(1,N,X),L).

% solucion_1(+N,?L) se verifica si L es una lista de pares de números que
% representan las coordenadas de una solución del problema de las N reinas. Por
% ejemplo,
solución(_,[]).
solución(N,[X-Y|L]) :-
   solución(N,L),
   between(1,N,Y),
   no_ataca(X-Y,L).

% no_ataca(X-Y,L) se verifica si la reina en la posición X-Y no ataca a las
% reinas colocadas en las posiciones correspondientes a los elementos de la
% lista L.
no_ataca(_,[]).
no_ataca(X-Y,[X1-Y1|L]) :-
   X =\= X1,
   Y =\= Y1,
   X-X1 =\= Y-Y1,
   X-X1 =\= Y1-Y,
   no_ataca(X-Y,L).

% 2ª solución
% ===========

% reinas_2(+N,-S) se verifica si L es una lista de N números, [x(1),...,x(N)],
% de forma que si las reinas se colocan en las casillas (1, x(1)),...,(N, x(N)),
% entonces no se atacan entre sí. Por ejemplo,
%    ?- reinas_2(4,S).
%    S = [2, 4, 1, 3] ;
%    S = [3, 1, 4, 2] ;
%    false.
%
%    ?- reinas_2(8,S).
%    S = [1, 5, 8, 6, 3, 7, 2, 4]
%
%    ?- findall(S,reinas_2(8,S),_L), length(_L,N).
%    N = 92.
reinas_2(N,S) :-
   numlist(1,N,S1),
   permutation(S1,S),
   segura(S).

% segura(L) se verifica si L es una lista de números [x(1),...,x(m)] tal que las
% reinas colocadas en las posiciones (a,x(1)), ..., (a+m,x(m)) no se atacan
% entre sí. Por ejemplo,
%      ?- segura([3,4]).
%      No
%      ?- segura([2,4]).
%      Yes
segura([]).
segura([X|L]) :-
   segura(L),
   no_ataca(X,L,1).

% no_ataca(Y,L,D) se verifica si Y es un número, L es una lista de números
% [y(1),...,y(m)] y D es un número tales que las reinas colocada en la posición
% (X,Y) no ataca a las colocadas en las posiciones (X+D,y(1)),..., (X+D+m,y(m)).
no_ataca(_, [], _ ).
no_ataca(Y, [Y1|L], D) :-
   Y1-Y =\= D,
   Y-Y1 =\= D,
   D1 is D+1 ,
   no_ataca(Y, L, D1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3ª solución                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% reinas_3(+N,-S) se verifica si L es una lista de N números, [x(1),...,x(N)],
% de forma que si las reinas se colocan en las casillas (1, x(1)),...,(N, x(N)),
% entonces no se atacan entre sí. Por ejemplo,
%    ?- reinas_3(4,S).
%    S = [2, 4, 1, 3] ;
%    S = [3, 1, 4, 2] ;
%    false.
%
%    ?- reinas_3(8,S).
%    S = [1, 5, 8, 6, 3, 7, 2, 4]
%
%    ?- findall(S,reinas_3(8,S),_L), length(_L,N).
%    N = 92.
reinas_3(N,L) :-
   numlist(1,N,L1),
   A is -N+1,
   B is N-1,
   numlist(A,B,L2),
   M is 2*N,
   numlist(2,M,L3),
   reinas_3_aux(L,L1,L1,L2,L3).

% reinas_3_aux(?L,+Dx,+Dy,+Du,+Dv) se verifica si L es una permutación de los
% elementos de Dy de forma que si L es [y1,..., yn] y Dx es [1,..., n], entonces
% y(j) - j (1 ≤ j ≤ n) son elementos distintos de Du e y(j) + j (1 ≤ j ≤ n) son
% elementos distintos de Dv.
reinas_3_aux([],[],_Dy,_Du,_Dv).
reinas_3_aux([Y|Ys],[X|Dx1],Dy,Du,Dv) :-
   select(Y,Dy,Dy1),
   U is X-Y,
   select(U,Du,Du1),
   V is X+Y,
   select(V,Dv,Dv1),
   reinas_3_aux(Ys,Dx1,Dy1,Du1,Dv1).

% Comparación de eficiencia
% =========================

% La comparación es
%    ?- time((findall(S,reinas_1(8,S),_L), length(_L,N))).
%    % 203,186 inferences, 0.022 CPU in 0.022 seconds (100% CPU, 9263998 Lips)
%    N = 92.
%
%    ?- time((findall(S,reinas_2(8,S),_L), length(_L,N))).
%    % 1,249,646 inferences, 0.086 CPU in 0.086 seconds (100% CPU, 14476330 Lips)
%    N = 92.
%
%    ?- time((findall(S,reinas_3(8,S),_L), length(_L,N))).
%    % 120,599 inferences, 0.017 CPU in 0.017 seconds (100% CPU, 7170581 Lips)
%    N = 92.

%    ?- time((findall(S,reinas_1(4,S),_L), length(_L,N))).
%    % 426 inferences, 0.000 CPU in 0.000 seconds (98% CPU, 1504439 Lips)
%    N = 2.
%
%    ?- time((findall(S,reinas_1(6,S),_L), length(_L,N))).
%    % 8,757 inferences, 0.004 CPU in 0.004 seconds (100% CPU, 2148240 Lips)
%    N = 4.
%
%    ?- time((findall(S,reinas_1(8,S),_L), length(_L,N))).
%    % 203,185 inferences, 0.027 CPU in 0.027 seconds (100% CPU, 7543443 Lips)
%    N = 92.
%
%    ?- time((findall(S,reinas_1(10,S),_L), length(_L,N))).
%    % 5,476,690 inferences, 0.502 CPU in 0.502 seconds (100% CPU, 10901811 Lips)
%    N = 724.
%
%    ?- time((findall(S,reinas_1(12,S),_L), length(_L,N))).
%    % 187,685,446 inferences, 18.666 CPU in 18.667 seconds (100% CPU, 10055104 Lips)
%    N = 14200.
%
%    ?- time((findall(S,reinas_2(4,S),_L), length(_L,N))).
%    % 495 inferences, 0.000 CPU in 0.000 seconds (99% CPU, 6696791 Lips)
%    N = 2.
%
%    ?- time((findall(S,reinas_2(6,S),_L), length(_L,N))).
%    % 18,486 inferences, 0.005 CPU in 0.005 seconds (100% CPU, 3837058 Lips)
%    N = 4.
%
%    ?- time((findall(S,reinas_2(8,S),_L), length(_L,N))).
%    % 1,249,646 inferences, 0.085 CPU in 0.085 seconds (100% CPU, 14702932 Lips)
%    N = 92.
%
%    ?- time((findall(S,reinas_2(10,S),_L), length(_L,N))).
%    % 131,267,564 inferences, 8.572 CPU in 8.573 seconds (100% CPU, 15312722 Lips)
%    N = 724.
%
%    ?- time((findall(S,reinas_3(4,S),_L), length(_L,N))).
%    % 531 inferences, 0.000 CPU in 0.000 seconds (99% CPU, 1806337 Lips)
%    N = 2.
%
%    ?- time((findall(S,reinas_3(6,S),_L), length(_L,N))).
%    % 6,645 inferences, 0.003 CPU in 0.003 seconds (100% CPU, 2336999 Lips)
%    N = 4.
%
%    ?- time((findall(S,reinas_3(8,S),_L), length(_L,N))).
%    % 120,599 inferences, 0.018 CPU in 0.018 seconds (100% CPU, 6818365 Lips)
%    N = 92.
%
%    ?- time((findall(S,reinas_3(10,S),_L), length(_L,N))).
%    % 2,774,080 inferences, 0.239 CPU in 0.239 seconds (100% CPU, 11585014 Lips)
%    N = 724.
%
%    ?- time((findall(S,reinas_3(12,S),_L), length(_L,N))).
%    % 83,067,706 inferences, 7.032 CPU in 7.032 seconds (100% CPU, 11812005 Lips)
%    N = 14200.
