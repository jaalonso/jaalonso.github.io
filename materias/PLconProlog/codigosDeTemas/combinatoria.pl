% combinatoria.pl
% Combinatoria.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

% subconjunto(-L1,+L2) se verifica si L1 es un subconjunto de L2. Por ejemplo,
%    ?- subconjunto(L,[a,b]).
%    L = [a, b] ;
%    L = [a] ;
%    L = [b] ;
%    L = [].
subconjunto([],[]).
subconjunto([X|L1],[X|L2]) :-
   subconjunto(L1,L2).
subconjunto(L1,[_|L2]) :-
   subconjunto(L1,L2).

% partes(+L1,-L2) se verifica si L2 es el conjunto de las partes de
% L1. Por ejemplo,
%    ?- partes([a,b,c],L).
%    L = [[a, b, c], [a, b], [a, c], [a], [b, c], [b], [c], []].
partes(L1,L2) :-
   findall(Y,subconjunto(Y,L1),L2).

% combinación(+L1,+N,-L2) se verifica si L2 es una combinación N-aria de
% L1. Por ejemplo,
%    ?- combinación([a,b,c],2,L).
%    L = [a, b] ;
%    L = [a, c] ;
%    L = [b, c] ;
%    false.

% 1ª definición
combinación_1(L1,N,L2) :-
   subconjunto(L2,L1),
   length(L2,N).

% 2ª definición
combinación_2(L1,N,L2) :-
   length(L2,N),
   subconjunto(L2,L1).

% Usaremos la 2ª definición
combinación(L1,N,L2) :-
   combinación_2(L1,N,L2).

% combinaciones(+L1,+N,-L2) se verifica si L2 es la lista de las
% combinaciones N-arias de L1. Por ejemplo,
%    ?- combinaciones([a,b,c],2,L).
%    L = [[a, b], [a, c], [b, c]].

% 1ª definición
combinaciones_1(L1,N,L2) :-
   findall(L,combinación_1(L1,N,L),L2).

% 2ª definición
combinaciones_2(L1,N,L2) :-
   findall(L,combinación_2(L1,N,L),L2).

% Usaremos la 2ª definición
combinaciones(L1,N,L2) :-
   combinaciones_2(L1,N,L2).

% Comparación de eficiencia:
%    ?- findall(_N,between(1,6,_N),_L1),
%       time(combinaciones_1(_L1,2,_L2)),
%       time(combinaciones_2(_L1,2,_L2)).
%    % 281 inferences, 0.000 CPU in 0.000 seconds (97% CPU, 1722690 Lips)
%    %  92 inferences, 0.000 CPU in 0.000 seconds (98% CPU, 1279893 Lips)
%    true.
%    ?- findall(_N,between(1,12,_N),_L1),
%       time(combinaciones_1(_L1,2,_L2)),
%       time(combinaciones_2(_L1,2,_L2)).
%    % 16,460 inferences, 0.005 CPU in 0.005 seconds (100% CPU, 3438484 Lips)
%    %    457 inferences, 0.000 CPU in 0.000 seconds (100% CPU, 5805165 Lips)
%    true.
%    ?- findall(_N,between(1,24,_N),_L1),
%       time(combinaciones_1(_L1,2,_L2)),
%       time(combinaciones_2(_L1,2,_L2)).
%    % 67,109,150 inferences, 6.973 CPU in 6.973 seconds (100% CPU, 9624607 Lips)
%    %      2,915 inferences, 0.001 CPU in 0.001 seconds (100% CPU, 5684777 Lips)
%    true.

% permutación(-L1,+L2) se verifica si L1 es una permutación de L2. Por
% ejemplo,
%    ?- permutación(L,[a,b,c]).
%    L = [a, b, c] ;
%    L = [b, a, c] ;
%    L = [b, c, a] ;
%    L = [a, c, b] ;
%    L = [c, a, b] ;
%    L = [c, b, a] ;
%    false.
permutación([],[]).
permutación([X|L1],L2) :-
   select(X,L2,L3),
   permutación(L1,L3).

% variación(+L1,+N,-L2) se verifica si L2 es una variación N-aria de
% L1. Por ejemplo,
%    ?- variación([a,b,c],2,L).
%    L = [a, b] ;
%    L = [a, c] ;
%    L = [b, a] ;
%    L = [b, c] ;
%    L = [c, a] ;
%    L = [c, b] ;
%    false.

% 1ª definición
variación_1(L1,N,L2) :-
   combinación(L1,N,L3),
   permutación(L2,L3).

% 2ª definición
variación_2(_,0,[]).
variación_2(L1,N,[X|L2]) :-
   N > 0,
   M is N-1,
   select(X,L1,L3),
   variación_2(L3,M,L2).

% variaciones(+L1,+N,-L2) se verifica si L2 es la lista de las
% variaciones N-arias de L1. Por ejemplo,
%    ?- variaciones([a,b,c],2,L).
%    L = [[a, b], [a, c], [b, c]] ;

% 1ª definición
variaciones_1(L1,N,L2) :-
   setof(L,variación_1(L1,N,L),L2).

% 2ª definición
variaciones_2(L1,N,L2) :-
   setof(L,variación_2(L1,N,L),L2).

% Comparación de eficiencia
%    ?- findall(_N,between(1,50,_N),_L1),
%       time(variaciones_1(_L1,2,_L2)),
%       time(variaciones_2(_L1,2,_L2)).
%    % 41,772 inferences, 0.008 CPU in 0.008 seconds (100% CPU, 5148280 Lips)
%    % 10,016 inferences, 0.003 CPU in 0.003 seconds (100% CPU, 3980846 Lips)
%    true.
%
%    ?- findall(_N,between(1,100,_N),_L1),
%       time(variaciones_1(_L1,2,_L2)),
%       time(variaciones_2(_L1,2,_L2)).
%    % 251,020 inferences, 0.055 CPU in 0.055 seconds (100% CPU, 4558285 Lips)
%    %  40,016 inferences, 0.007 CPU in 0.007 seconds (100% CPU, 5624430 Lips)
%    true.
%
%    ?- findall(_N,between(1,200,_N),_L1),
%       time(variaciones_1(_L1,2,_L2)),
%       time(variaciones_2(_L1,2,_L2)).
%    % 1,672,020 inferences, 0.133 CPU in 0.133 seconds (100% CPU, 12527802 Lips)
%    %   160,016 inferences, 0.026 CPU in 0.026 seconds (100% CPU, 6271738 Lips)
%    true.
%
%    ?- findall(_N,between(1,400,_N),_L1),
%       time(variaciones_1(_L1,2,_L2)),
%       time(variaciones_2(_L1,2,_L2)).
%    % 12,024,020 inferences, 0.845 CPU in 0.844 seconds (100% CPU, 14237961 Lips)
%    %    640,016 inferences, 0.096 CPU in 0.096 seconds (100% CPU, 6646804 Lips)
%    true.
