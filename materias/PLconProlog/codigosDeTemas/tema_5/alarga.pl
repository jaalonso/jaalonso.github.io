% alarga.pl
% Alargamiento de figuras geométricas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 18-mayo-2022
% =============================================================================

% alarga(+F1,+N,-F2) se verifica si F1 y F2 son figuras geométricas del
% mismo tipo y el tamaño de la F1 es el de la F2 multiplicado por N,
% donde las figuras geométricas se representan como términos en los que
% el functor indica el tipo de figura y los argumentos su tamaño. Por
% ejemplo,
%    ?- alarga(triángulo(3,4,5),2,F).
%    F = triángulo(6, 8, 10).
%
%    ?- alarga(cuadrado(3),2,F).
%    F = cuadrado(6).
alarga(Figura1,Factor,Figura2) :-
   Figura1 =.. [Tipo|Arg1],
   multiplica_lista(Arg1,Factor,Arg2),
   Figura2 =.. [Tipo|Arg2].

multiplica_lista([],_,[]).
multiplica_lista([X1|L1],F,[X2|L2]) :-
   X2 is X1*F,
   multiplica_lista(L1,F,L2).
