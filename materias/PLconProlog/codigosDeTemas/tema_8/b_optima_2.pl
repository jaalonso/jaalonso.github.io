% b_optima_2.pl
% B�squeda �ptima
% Jos� A. Alonso Jim�nez <jalonso@cs.us.es>
% Sevilla, 30 de Noviembre de 2003
% =============================================================================

:- module(b_optima_2, [�ptima/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Relaciones dependientes del problema                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado-final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.
% 4. coste(E1,E2,C) que se verifica si C es el coste de ir del estado E1 al E2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � B�squeda �ptima                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Un NODO es un t�rmino de la forma C-[E_n,...,E_1] donde [E_n,...,E_1] es una
% lista de estados de forma que E_1 es el estado inicial y E_(i+1) es un
% sucesor de E_i y C es el coste de dicho camino.

% ABIERTOS es una lista de nodos.

% �ptima(?S)
%    se verifica si S es una soluci�n del problema mediante b�squeda �ptima; es
%    decir, S es la soluci�n obtenida por b�squeda �ptima a partir de [0-[E]],
%    donde E el estado inicial.
�ptima(S) :-
   estado_inicial(E),
   �ptima([0-[E]],S).

% �ptima(+Abiertos,?S)
%    se verifica si S es una soluci�n del problema a partir de la lista de
%    nodos Abiertos encontrada por b�squeda �ptima.
%    Procedimiento:
%    1. Si
%       1.1 C-[E|R] es el primer elemento de Abiertos y
%       1.2 E es un estado final,
%       entonces
%       1.3 S es la inversa de [E|R] y el coste de S es C.
%    2. Si
%       2.1 N es el mejor nodo de Abiertos y RAbiertos son los restantes;
%       2.1 Sucesores son los nodos sucesores de N (es decir, si N=C-[E|R],
%           entonces Sucesores son los nodos de la forma C1-[E1,E|R] donde E1
%           es un sucesor de E que no pertenece a [E|R] y C1 es la suma de C y
%           el coste de E a E1),
%       2.2 Abiertos1 es la lista obtenida a�adiendo Sucesores a continuaci�n
%           de RAbiertos y
%       2.3 Abiertos2 es la lista obtenida ordenando Abiertos1;
%       entonces
%       2.4 S es la soluci�n encontrada por b�squeda �ptima a partir de
%           Abiertos2.
�ptima([_C-[E|R]|_RA],S) :-
   estado_final(E),                       % 1.2
   reverse([E|R],S).                      % 1.3
�ptima([N|RAbiertos],S) :-
   expande(N,Sucesores),                  % 2.2
   append(RAbiertos,Sucesores,Abiertos1), % 2.3
   sort(Abiertos1,Abiertos2),             % 2.4
   �ptima(Abiertos2,S).                   % 2.5

% expande(+N,?Sucesores)
%    se verifica si Sucesores es la lista de sucesores del nodo N (es decir, si
%    N=C-[E|R], entonces Sucesores son los nodos de la forma C1-[E1,E|R] donde
%    E1 es un sucesor de E que no pertenece a [E|R] y C1 es la suma de C y el
%    coste de E a E1)
expande(C-[E|R],Sucesores) :-
   findall(C1-[E1,E|R],
           (sucesor(E,E1),
            not(member(E1,[E|R])),
            coste(E,E1,C2),
            C1 is C+C2),
           Sucesores).
