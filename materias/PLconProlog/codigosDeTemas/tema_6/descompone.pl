% descompone.pl
% Ejemplo de determinismo.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

% descompone(+E,-N1,-N2) se verifica si N1 y N2 son dos enteros no negativos
% tales que N1+N2=E. Por ejemplo,
%    ?- descompone_1(4,X,Y).
%    X = 0,
%    Y = 4 ;
%    X = 1,
%    Y = 3 ;
%    X = Y, Y = 2 ;
%    X = 3,
%    Y = 1 ;
%    X = 4,
%    Y = 0 ;
%    false.

% 1ª definición (no determinista)
descompone_1(E, N1, N2):-
   between(0, E, N1),
   between(0, E, N2),
   E =:= N1 + N2.

% 2ª definición (determinista)
descompone_2(E, N1, N2):-
   between(0, E, N1),
   N2 is E - N1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Comparación de eficiencia                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- time(setof(_N1+_N2,descompone_1(1000,_N1,_N2),_L)).
% % 2,006,017 inferences, 0.169 CPU in 0.169 seconds (100% CPU, 11848576 Lips)
% true.
%
% ?- time(setof(_N1+_N2,descompone_2(1000,_N1,_N2),_L)).
% % 3,016 inferences, 0.001 CPU in 0.001 seconds (100% CPU, 2107629 Lips)
% true.
