% borra(L1,X,L2) se verifica si L2 es la lista obtenida eliminando los
% elementos de L1 unificables simultáneamente con X; por ejemplo,
%    ?- borra([a,b,a,c],a,L).
%    L = [b, c] ;
%    false.
%    ?- borra([a,Y,a,c],a,L).
%    Y = a
%    L = [c] ;
%    false.
%    ?- borra([a,Y,a,c],X,L).
%    Y = X, X = a,
%    L = [c] ;
%    false.

% Definición con not
borra_1([],_,[]).
borra_1([X|L1],Y,L2) :-
   X=Y,
   borra_1(L1,Y,L2).
borra_1([X|L1],Y,[X|L2]) :-
   not(X=Y),
   borra_1(L1,Y,L2).

% Definición con corte:
borra_2([],_,[]).
borra_2([X|L1],Y,L2) :-
   X=Y, !,
   borra_2(L1,Y,L2).
borra_2([X|L1],Y,[X|L2]) :-
   % not(X=Y),
   borra_2(L1,Y,L2).

% Definición con corte y simplificada
borra_3([],_,[]).
borra_3([X|L1],X,L2) :-
   !,
   borra_3(L1,X,L2).
borra_3([X|L1],Y,[X|L2]) :-
   % not(X=Y),
   borra_3(L1,Y,L2).

% ?- borra_1([a,b,a,c],a,L).
% L = [b, c] ;
% false.
%
% ?- borra_1([a,Y,a,c],a,L).
% Y = a,
% L = [c] ;
% false.
%
% ?- borra_1([a,Y,a,c],X,L).
% Y = X, X = a,
% L = [c]
% ?- borra_2([a,b,a,c],a,L).
% L = [b, c].
%
% ?- borra_2([a,Y,a,c],a,L).
% Y = a,
% L = [c].
%
% ?- borra_2([a,Y,a,c],X,L).
% Y = X, X = a,
% L = [c].
%
% ?- borra_3([a,b,a,c],a,L).
% L = [b, c].
%
% ?- borra_3([a,Y,a,c],a,L).
% Y = a,
% L = [c].
%
% ?- borra_3([a,Y,a,c],X,L).
% Y = X, X = a,
% L = [c].
