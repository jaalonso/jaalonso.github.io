% mejor.pl
% Mejor valor.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 31-mayo-2022
% ======================================================================

:- use_module(library(clpfd)).

% mejor(X) restringe los valores de X a su menor valor. Por ejemplo, 
%    ?- X in 1..6, Y #= X*(X-6), mejor(Y).
%    X = 3,
%    Y = -9 
%     
%    ?- X in 1..6, Y #= X*(6-X), mejor(Y).
%    X = 6,
%    Y = 0 

% 1ª definición
mejor(X) :-
   findall(X, indomain(X), L),
   member(Y, L),
   not((member(Z, L), Z < Y)),
   X #= Y.

% 2ª definición
mejor_2(X) :-
   labeling([min(X)],[X]).

