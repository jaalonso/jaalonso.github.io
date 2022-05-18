% suma_segura.pl
% Suma segura.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 18-mayo-2022
% =============================================================================

% suma_segura(X,Y,Z) se verifica si X e Y son enteros y Z es la suma de
% X e Y. Por ejemplo,
%    ?- suma_segura(2,3,X).
%    X = 5.
%
%    ?- suma_segura(7,a,X).
%    false.
%
%    ?- X is 7 + a.
%    ERROR: Arithmetic: `a/0' is not a function
suma_segura(X,Y,Z) :-
   number(X),
   number(Y),
   Z is X+Y.
