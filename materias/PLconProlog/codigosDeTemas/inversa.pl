% inversa.pl
% Ejemplo de acumuladores: inversa de una lista.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

% inversa(+L1,-L2) se verifica si L2 es la lista inversa de L1. Por ejemplo,
%    ?- inversa([a,b,c],L).
%    L = [c, b, a]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Definición básica                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inversa_1([],[]).
inversa_1([X|L1],L2):-
   inversa_1(L1,L3),
   append(L3,[X],L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Definición con acumuladores                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

inversa_2(L1,L2):-
   inversa_2_aux(L1,[],L2).

inversa_2_aux([],L,L).
inversa_2_aux([X|L1],L3,L2):-
   inversa_2_aux(L1,[X|L3],L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Sesión                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- numlist(1,4000,_L1), time(inversa_1(_L1,_)).
% % 8,006,000 inferences, 0.428 CPU in 0.428 seconds (100% CPU, 18686454 Lips)
% true.
%
% ?- numlist(1,4000,_L1), time(inversa_2(_L1,_)).
% % 4,001 inferences, 0.001 CPU in 0.001 seconds (100% CPU, 5305472 Lips)
% true.
