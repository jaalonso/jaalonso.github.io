% nota(X,Y) se verifica si Y es la calificación correspondiente a la
% nota X; es decir, Y es suspenso si X es menor que 5, Y es aprobado si
% X es mayor o igual que 5 pero menor que 7, Y es notable si X es mayor
% que 7 pero menor que 9 e Y es sobresaliente si X es mayor que 9.
nota(X,suspenso)      :- X < 5.
nota(X,aprobado)      :- X >= 5, X < 7.
nota(X,notable)       :- X >= 7, X < 9.
nota(X,sobresaliente) :- X >= 9.

% ¿Cuál es la calificación correspondiente a un ~6~?:
%    ?- nota(6,Y).
%    Y = aprobado ;
%    false.
