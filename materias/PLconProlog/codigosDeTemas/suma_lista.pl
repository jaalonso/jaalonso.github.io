% suma_lista.pl
% Ejemplo de usuo de acumuladores.
% Jos� A. Alonso Jim�nez <Jose-Antonio.Alonso@cs.us.es>
% Sevilla,  5 de Enero de 2003
% =============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Definici�n b�sica                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sumalista_1([], 0).  
sumalista_1([X|R],S) :- 
   sumalista_1(R, S1), 
   S is S1 + X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Definici�n con acumuladores                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sumalista_2(L,S) :-
   sumalista_2_aux(L,0,S).

sumalista_2_aux([],Ac,Ac). 
sumalista_2_aux([X|Resto],Ac,Suma) :- 
   Nuevo_ac is Ac + X, 
   sumalista_2_aux(Resto,Nuevo_ac,Suma).
