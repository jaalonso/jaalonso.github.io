% pertenece.pl
% Relación de pertenencia.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 13-mayo-2022
% =============================================================================

% pertenece(X,L) se verifica si X es un elemento de la lista L. Por ejemplo,
%    ?- pertenece(b,[a,b,c]).
%    true ;
%    false.
%
%    ?- pertenece(d,[a,b,c]).
%    false.
%
%    ?- pertenece(X,[a,b,a]).
%    X = a ;
%    X = b ;
%    X = a ;
%    false.
%
%    ?- pertenece(a,L).
%    L = [a|_344] ;
%    L = [_1002, a|_1010] ;
%    L = [_1002, _1668, a|_1676] ;
%    L = [_1002, _1668, _2334, a|_2342]

% 1ª definición
pertenece(X,[X|L]).
pertenece(X,[Y|L]) :- pertenece(X,L).

% 2ª definición
pertenece_2(X,[X|_]).
pertenece_2(X,[_|L]) :- pertenece_2(X,L).

% 3ª definición
pertenece_3(X,[Y|L]) :- X=Y ; pertenece_3(X,L).
