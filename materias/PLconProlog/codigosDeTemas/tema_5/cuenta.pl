% cuenta.pl
% Cuenta ocurrencias.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 18-mayo-2022
% =============================================================================

% cuenta(A,L,N) se verifica si N es el número de ocurrencias del átomo A
% en la lista L. Por ejemplo,
%    ?- cuenta(a,[a,b,a,a],N).
%    N = 3.
%
%    ?- cuenta(a,[a,b,X,Y],N).
%    N = 1.
cuenta(_,[],0) :- !.
cuenta(A,[B|L],N) :-
   A == B, !,
   cuenta(A,L,M),
   N is M+1.
cuenta(A,[_B|L],N) :-
   % A \== _B,
   cuenta(A,L,N).
