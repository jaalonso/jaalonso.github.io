% maplist.pl
% Definición de maplist.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 18-mayo-2022
% =============================================================================

% maplist(P,L1,L2) se verifica si se cumple el predicado P sobre los
% sucesivos pares de elementos de las listas L1 y L2; por ejemplo,
%    ?- succ(2,X).
%    X = 3.
%
%    ?- succ(X,3).
%    X = 2.
%
%    ?- n_maplist(succ,[2,4],[3,5]).
%    true.
%
%    ?- n_maplist(succ,[0,4],[3,5]).
%    false.
%
%    ?- n_maplist(succ,[2,4],Y).
%    Y = [3, 5].
%
%    ?- n_maplist(succ,X,[3,5]).
%    X = [2, 4].
n_maplist(_,[],[]) :- !.
n_maplist(R,[X1|L1],[X2|L2]) :-
   apply(R,[X1,X2]),
   n_maplist(R,L1,L2).
