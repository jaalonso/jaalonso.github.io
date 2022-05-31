% fibonacci_clp.pl
% La función de Fibonacci en LP y CLP(R).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 31-mayo-2022
% ======================================================================

% La sucesión de Fibonacci está definida por
%       f(0) = 0
%       f(1) = 1
%       f(n) = f(n-1)+f(n-2), si n > 1.

% Definición en Prolog
% ====================

% fib_1(+N,-F) se verifica si F es el N-ésimo término de la sucesión de
% Fibonacci. Por ejemplo,
%    ?- fib_1(6,F).
%    F = 13 
%    
%    ?- fib_1(N,13).
%    ERROR: Arguments are not sufficiently instantiated
fib_1(N, F) :-
   ( N = 0, F = 1
   ; N = 1, F = 1
   ; N > 1,
     N1 is N - 1, fib_1(N1, F1),
     N2 is N - 2, fib_1(N2, F2),
     F is F1 + F2 ).

% Definición en Prolog con restricciones CLP(R)
% =============================================

:- use_module(library(clpr)).

% fib_2(N,F) se verifica si F es el N-ésimo término de la sucesión de
% Fibonacci. Por ejemplo,
%    ?- fib_2(6, F).
%    F = 13.0 
%    ?- fib_2(N,13).
%    N = 6.0 
%    ?- fib_2(N,4).
%    ERROR: Out of global stack
fib_2(N, F) :-
   ( {N = 0, F = 1}
   ; {N = 1, F = 1}
   ; {N > 1, F = F1 + F2, N1 = N- 1, N2 = N - 2},
     fib_2(N1, F1),
     fib_2(N2, F2) ).
   
% fib_3(+N,-F) se verifica si F es el N-ésimo término de la sucesión de
% Fibonacci. Por ejemplo,
%    ?- fib_3(6,F).
%    F = 13.0 
%    
%    ?- fib_3(N,13).
%    N = 6.0 
%    
%    ?- fib_3(N,4).
%    false.
fib_3(N, F) :-
   ( {N = 0, F = 1}
   ; {N = 1, F = 1}
   ; {N > 1, F = F1 + F2, N1 = N - 1, N2 = N - 2, F1 >= N1, F2 >= N2},
     fib_3(N1, F1),
     fib_3(N2, F2) ).
