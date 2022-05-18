% apply.pl
% Definición de apply.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 18-mayo-2022
% =============================================================================

% apply(T,L) se verifica si es demostrable T después de aumentar el
% número de sus argumentos con los elementos de L; por ejemplo,
%    ?- plus(2,3,X).
%    X = 5.
%
%    ?- n_apply(plus,[2,3,X]).
%    X = 5.
%
%    ?- n_apply(plus(2),[3,X]).
%    X = 5.
%
%    ?- n_apply(plus(2,3),[X]).
%    X = 5.
%
%    ?- n_apply(append([1,2]),[X,[1,2,3,4,5]]).
%    X = [3, 4, 5].
n_apply(Término,Lista) :-
   Término =.. [Pred|Arg1],
   append(Arg1,Lista,Arg2),
   Átomo =.. [Pred|Arg2],
   Átomo.
