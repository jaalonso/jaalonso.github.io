% fibonacci.pl
% Ejemplo de programación dinámica: Función de Fibonacci.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

% La sucesión de Fibonacci es 1, 1, 2, 3, 5, 8, ... y está definida por
%    fibonacci(1) = 1
%    fibonacci(2) = 1
%    fibonacci(n) = fibonacci(n-1) + fibonacci(n-2), si  n > 2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Definición básica                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fibonacci_1(1,1).
fibonacci_1(2,1).
fibonacci_1(N,F) :-
   N > 2,
   N1 is N-1,
   fibonacci_1(N1,F1),
   N2 is N-2,
   fibonacci_1(N2,F2),
   F is F1 + F2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Definición con programación dinámica                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- dynamic fibonacci_2/2.

fibonacci_2(1,1).
fibonacci_2(2,1).
fibonacci_2(N,F) :-
   N > 2,
   N1 is N-1,
   fibonacci_2(N1,F1),
   N2 is N-2,
   fibonacci_2(N2,F2),
   F is F1 + F2,
   asserta(fibonacci_2(N,F)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Definición con acumuladores                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fibonacci_3(N,F) :-
   fibonacci_3_aux(N,_,F).

fibonacci_3_aux(0,_,0).
fibonacci_3_aux(1,0,1).
fibonacci_3_aux(N,F1,F) :-
   N > 1,
   N1 is N-1,
   fibonacci_3_aux(N1,F2,F1),
   F is F1 + F2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- time(fibonacci_1(20,N)).
% % 27,055 inferences, 0.009 CPU in 0.009 seconds (100% CPU, 3061846 Lips)
% N = 6765
%
% ?- time(fibonacci_2(20,N)).
% ?- time(fibonacci_2(20,N)).
% % 89 inferences, 0.000 CPU in 0.000 seconds (98% CPU, 2150122 Lips)
% N = 6765
%
% ?- listing(fibonacci_2).
% fibonacci_2(20, 6765).
% fibonacci_2(19, 4181).
% ...
% fibonacci_2(4, 3).
% fibonacci_2(3, 2).
% fibonacci_2(1, 1).
% fibonacci_2(2, 1).
% fibonacci_2(A, B) :-
%    A>2,
%    C is A-1,
%    fibonacci_2(C, D),
%    E is A-2,
%    fibonacci_2(E, F),
%    B is D+F,
%    asserta(fibonacci_2(A, B)).
%
% ?- time(fibonacci_2(20,N)).
% 1 inferences in 0.00 seconds (Infinite Lips)
% N = 6765
% Yes
%
% ?- trace(fibonacci_3).
%         fibonacci_3/2: call redo exit fail
% Yes
%
% ?- trace(fibonacci_3_aux).
%         fibonacci_3_aux/3: call redo exit fail
% Yes
%
% ?- fibonacci_3(6,X).
% T Call:  (  8) fibonacci_3(6, _G107)
% T Call:  (  9) fibonacci_3_aux(6, _L140, _G107)
% T Call:  ( 10) fibonacci_3_aux(5, _L143, _L140)
% T Call:  ( 11) fibonacci_3_aux(4, _L157, _L143)
% T Call:  ( 12) fibonacci_3_aux(3, _L171, _L157)
% T Call:  ( 13) fibonacci_3_aux(2, _L185, _L171)
% T Call:  ( 14) fibonacci_3_aux(1, _L199, _L185)
% T Exit:  ( 14) fibonacci_3_aux(1, 0, 1)
% T Exit:  ( 13) fibonacci_3_aux(2, 1, 1)
% T Exit:  ( 12) fibonacci_3_aux(3, 1, 2)
% T Exit:  ( 11) fibonacci_3_aux(4, 2, 3)
% T Exit:  ( 10) fibonacci_3_aux(5, 3, 5)
% T Exit:  (  9) fibonacci_3_aux(6, 5, 8)
% T Exit:  (  8) fibonacci_3(6, 8)
% X = 8
% Yes
% ?- trace(fibonacci_3,-all).
% ?- trace(fibonacci_3_aux,-all).
%
% ?- time(fibonacci_3(20,N)).
% % 57 inferences, 0.000 CPU in 0.000 seconds (90% CPU, 1216000 Lips)
% N = 6765
