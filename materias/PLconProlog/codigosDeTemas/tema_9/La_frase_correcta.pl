% La_frase_correcta.pl
% Problema de la frase correcta.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 2-junio-2022
% ======================================================================

% El enunciado del problema de la frase correcta es: "¿Cuál de las
% siguientes frases es la correcta? 
% 1. Todas las siguientes.
% 2. Ninguna de las siguientes.
% 3. Todas las anteriores.
% 4. Alguna de las anteriores.
% 5. Ninguna de las anteriores.
% 6. Ninguna de las anteriores."

% solución([A1,A2,A3,A4,A5,A6]) se verifica si Ai = 1 si la frase i del
% problema es correcta y Ai = 0 si la frase i del problema es
% incorrecta.

:- use_module(library(clpb)).

solución([A1,A2,A3,A4,A5,A6]) :-
   sat(A1 =:= A2*A3*A4*A5*A6),
   sat(A2 =:= ~(A2+A3+A4+A5+A6)),
   sat(A3 =:= A1*A2),
   sat(A4 =:= card([1,2,3],[A1,A2,A3])),
   sat(A5 =:= ~(A1+A2+A3+A4)),
   sat(A6 =:= ~(A1+A2+A3+A4+A5)).

% Cálculo de la solución
%    ?- solucion(L).
%    L = [0, 0, 0, 0, 1, 0].
% Por tanto, la verdadera es la 5ª.
