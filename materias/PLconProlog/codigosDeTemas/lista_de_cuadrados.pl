% lista_de_cuadrados.pl
% Ejemplo de ineficiencia de añadir por el final.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

% lista_de_cuadrados(+N,?L) se verifica si L es la lista de los
% cuadrados de los números de 1 a N. Por ejemplo,
%     ?- lista_de_cuadrados(5,L).
%     L = [1, 4, 9, 16, 25]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Definición añadiendo por el final                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lista_de_cuadrados_1(1,[1]).
lista_de_cuadrados_1(N,L) :-
   N > 1,
   N1 is N-1,
   lista_de_cuadrados_1(N1,L1),
   M is N*N,
   append(L1,[M],L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Definición añadiendo por el principio                                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lista_de_cuadrados_2(N,L) :-
   lista_de_cuadrados_2_aux(N,L1),
   reverse(L1,L).

lista_de_cuadrados_2_aux(1,[1]).
lista_de_cuadrados_2_aux(N,[M|L]) :-
   N > 1,
   M is N*N,
   N1 is N-1,
   lista_de_cuadrados_2_aux(N1,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Definición conjuntista                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lista_de_cuadrados_3(N,L) :-
   findall(M,(between(1,N,X), M is X*X),L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- time(lista_de_cuadrados_1(10000,_L)).
% % 50,034,995 inferences, 2.903 CPU in 2.903 seconds (100% CPU, 17233369 Lips)
% true
%
% ?- time(lista_de_cuadrados_2(10000,_L)).
% % 39,999 inferences, 0.009 CPU in 0.009 seconds (100% CPU, 4550877 Lips)
% true
%
% ?- time(lista_de_cuadrados_3(10000,_L)).
% % 30,010 inferences, 0.007 CPU in 0.007 seconds (100% CPU, 4229420 Lips)
% true.
