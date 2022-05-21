% cuadrado_magico.pl
% Problema de los cuadrados mágicos.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Enunciado                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Colocar los números 1,2,3,4,5,6,7,8,9 en un cuadrado 3x3 de forma que todas
% las líneas (filas, columnas y diagonales) sumen igual.
%
% (Idea: Buscar los valores para las variables A,B,C,D,E,F,G,H,I
%    +---+---+---+
%    | A | B | C |
%    +---+---+---+
%    | D | E | F |
%    +---+---+---+
%    | G | H | I |
%    +---+---+---+
% tales que
%    {A,B,C,D,E,F,G,H,I} = {1,2,3,4,5,6,7,8,9},
%    A+B+C = 15,
%    D+E+F = 15,
%    G+H+I = 15,
%    A+D+G = 15,
%    B+E+H = 15,
%    C+F+I = 15,
%    A+E+I = 15,
%    C+E+G = 15.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Solución 1                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cuadrado_1([A,B,C,D,E,F,G,H,I]) :-
   permutation([1,2,3,4,5,6,7,8,9],[A,B,C,D,E,F,G,H,I]),
   A+B+C =:= 15,
   D+E+F =:= 15,
   G+H+I =:= 15,
   A+D+G =:= 15,
   B+E+H =:= 15,
   C+F+I =:= 15,
   A+E+I =:= 15,
   C+E+G =:= 15.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Solución 2                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cuadrado_2([A,B,C,D,E,F,G,H,I]) :-
   select(A,[1,2,3,4,5,6,7,8,9],L1),
   select(B,L1,L2),
   select(C,L2,L3),
   A+B+C =:= 15,
   select(D,L3,L4),
   select(G,L4,L5),
   A+D+G =:= 15,
   select(E,L5,L6),
   C+E+G =:= 15,
   select(I,L6,L7),
   A+E+I =:= 15,
   select(F,L7,[H]),
   C+F+I =:= 15,
   D+E+F =:= 15.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- cuadrado_1(L).
% L = [2, 7, 6, 9, 5, 1, 4, 3, 8] ;
% L = [2, 9, 4, 7, 5, 3, 6, 1, 8]
%
% ?- findall(_X,cuadrado_1(_X),_L),length(_L,N).
% N = 8.
%
% ?- cuadrado_2(L).
% L = [2, 7, 6, 9, 5, 1, 4, 3, 8] ;
% L = [2, 9, 4, 7, 5, 3, 6, 1, 8]
%
% ?- findall(_X,cuadrado_2(_X),_L),length(_L,N).
% N = 8.
%
% ?- setof(_X,cuadrado_1(_X),_L),setof(_X,cuadrado_2(_X),_L).
% true.
%
% ?- time(cuadrado_1(_X)).
% % 570,135 inferences, 0.053 CPU in 0.053 seconds (100% CPU, 10741694 Lips)
% true
%
% ?- time(cuadrado_2(_X)).
% % 1,104 inferences, 0.001 CPU in 0.001 seconds (99% CPU, 1692865 Lips)
% true
%
% ?- time(setof(_X,cuadrado_1(_X),_L)).
% % 2,999,645 inferences, 0.236 CPU in 0.236 seconds (100% CPU, 12690432 Lips)
% true.
%
% ?- time(setof(_X,cuadrado_2(_X),_L)).
% % 7,216 inferences, 0.005 CPU in 0.005 seconds (100% CPU, 1511635 Lips)
% true.
