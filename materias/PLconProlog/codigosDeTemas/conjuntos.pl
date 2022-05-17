% conjuntos.pl
% Operaciones conjuntistas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 17-mayo-2022
% =============================================================================

% setof0(T,0,L) es como setof salvo en el caso en que ninguna instancia
% de T verifique O, en cuyo caso L es la lista vacía. Por ejemplo,
%    ?- setof0(X, (member(X,[c,a,b]),member(X,[c,b,d])), L).
%    L = [b, c].
%
%    ?- setof0(X, (member(X,[c,a,b]),member(X,[e,f])), L).
%    L = [].
setof0(X,O,L) :- setof(X,O,L), !.
setof0(_,_,[]).

% intersección(S,T,U) se verifica si U es la intersección de S y T. Por
% ejemplo,
%    ?- intersección([1,4,2],[2,3,4],U).
%    U = [2, 4].
intersección(S,T,U) :-
   setof0(X, (member(X,S), member(X,T)), U).

% unión(S,T,U) se verifica si U es la unión de S y T. Por ejemplo,
%    ?- unión([1,2,4],[2,3,4],U).
%    U = [1, 2, 3, 4].
unión(S,T,U) :-
   setof(X, (member(X,S); member(X,T)), U).

% diferencia(S,T,U) se verifica si U es la diferencia de los conjuntos
% de S y T. Por ejemplo,
%    ?- diferencia([5,1,2],[2,3,4],U).
%    U = [1, 5].
diferencia(S,T,U) :-
   setof0(X,(member(X,S),not(member(X,T))),U).

% subconjunto(-L1,+L2) se verifica si L1 es un subconjunto de L2. Por
% ejemplo,
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

% subconjuntos(X,L) se verifica si L es el conjunto de las subconjuntos
% de X. Por ejemplo, Por ejemplo,
%    ?- subconjuntos([a,b,c],L).
%    L = [[], [a], [a, b], [a, b, c], [a, c], [b], [b, c], [c]].
subconjuntos(X,L) :-
   setof(Y,subconjunto(Y,X),L).
