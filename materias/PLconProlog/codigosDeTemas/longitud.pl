% longitud.pl
% Ejemplo de iteraci�n.
% Jos� A. Alonso Jim�nez <Jose-Antonio.Alonso@cs.us.es>
% Sevilla,  5 de Enero de 2003
% =============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Definici�n recursiva                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

longitud_1([],0).
longitud_1([_|L],N):-
   longitud_1(L,N1),
   N is N1 +1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Definici�n iterativa (con acumulador)                                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

longitud_2(L,N):-
   longitud_2_aux(L,0,N).

longitud_2_aux([],N,N).
longitud_2_aux([_|L],N,Long):-
   N1 is N+1,
   longitud_2_aux(L,N1,Long).

