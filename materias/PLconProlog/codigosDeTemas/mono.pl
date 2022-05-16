% PD-99: mono.pl
% El mono y el pl�tano
% Bratko [86]  p. 49-53 y 78.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Enunciado                                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Un mono se encuentra en la puerta de una habitaci�n. En el centro de la
% habitaci�n hay un pl�tano colgado del techo. El mono est� hambriento y desea
% coger el pl�tano, pero no lo alcanza desde el suelo. En la ventana de la
% habitaci�n hay una silla que el mono puede usar. El mono puede realizar las
% siguientes acciones: pasear de un lugar a otro de la habitaci�n, empujar la
% silla de un lugar a otro de la habitaci�n (si est� en el mismo lugar que la
% silla), subirse en la silla (si est� en el mismo lugar que la silla) y coger
% el pl�tano (si est� encima de la silla en el centro de la habitaci�n). 
%
% Definir el predicado
%       solucion(E,S)
% de forma que S sea una sucesi�n de acciones que aplicadas al estado S
% permiten al mono coger el pl�tano. Por ejemplo,
%       ?- solucion(estado(puerta,suelo,ventana,sin),L).
%       L = [pasear(puerta, ventana), empujar(ventana, centro), subir, coger] ;
%       No
% donde 
%       estado(PM,EM,PS,X)
% significa que el mono se encuentra en la posici�n PM (puerta, centro o
% ventana) encima de EM (suelo o silla), la silla se encuentra en la posici�n
% PS (puerta, centro o ventana) y el mono tiene (X=con) o no (X=sin) el
% pl�tano. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Programa                                                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

solucion(estado(_,_,_,con),[]).
solucion(E1,[A|L]) :-
   movimiento(E1,A,E2),
   solucion(E2,L).
  
% movimiento(estado(PM1,EM1,PS1,X1),A,estado(PM2,EM2,PS2,X2)) :-
%       en el estado(PM1,EM1,PS1,X1) se puede aplicar la acci�n A y se pasa al
%       estado(PM2,EM2,PS2,X2) 
movimiento(estado(centro,silla,centro,sin),
           coger,
           estado(centro,silla,centro,con)).
movimiento(estado(X,suelo,X,U),
           subir,
           estado(X,silla,X,U)).
movimiento(estado(X1,suelo,X1,U),
           empujar(X1,X2),
           estado(X2,suelo,X2,U)).
movimiento(estado(X,suelo,Z,U),
           pasear(X,Z),
           estado(Z,suelo,Z,U)).

            
             
             
