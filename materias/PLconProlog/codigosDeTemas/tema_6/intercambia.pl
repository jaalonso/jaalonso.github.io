% intercambia.pl
% Ejemplo de uso de la unificaci�n.
% Jos� A. Alonso Jim�nez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

% intercambia(+T1,-T2) se verifica si T1 es un t�rmino con dos argumentos y T2
% es un t�rmino con el mismo s�mbolo de funci�n que T1 pero sus argumentos
% intercambiados. Por ejemplo,
%    ?- intercambia(opuesto(3,-3),T).
%    T = opuesto(-3, 3)

% 1� definici�n
intercambia_1(T1, T2):-
   functor(T1,F,2),
   functor(T2,F,2),
   arg(1,T1,X1),
   arg(2,T1,Y1),
   arg(1,T2,X2),
   arg(2,T2,Y2),
   X1 = Y2,
   X2 = Y1.

% 2� definici�n
intercambia_2(T1,T2) :-
   T1 =.. [F,X,Y],
   T2 =.. [F,Y,X].
