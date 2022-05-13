% factorial.pl
% Definición del factorial.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 13-mayo-2022
% =============================================================================

% factorial(X,Y) se verifica si Y es el factorial de X. Por ejemplo,

factorial(1,1).
factorial(X,Y) :-
   X > 1,
   A is X - 1,
   factorial(A,B),
   Y is X * B.
