% IA2-00: busqueda-general.pl
% Procedimiento general de búsqueda
%==============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Relaciones dependientes del problema                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado-final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.
% 4. coste(E1,E2,C) que se verifica si C es el coste de ir del estado E1 al E2.
% 5. heuristica(E,H) que se verifica si H es la heurística del estado E.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Procedimiento general de búsqueda                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Un NODO es una lista de estados [E_n,...,E_1] de forma que E_1 es el estado
% inicial y E_(i+1) es un sucesor de E_i.
%
% ABIERTOS es una lista de nodos (los nodos pendientes de analizar).

% busqueda(+M,?S)
%    se verifica si S es una solución del problema mediante búsqueda según el
%    método M.
% Procedimiento:
% 1. Sea E el estado inicial.
% 2. La solución S es la obtenida por búsqueda en anchura con [[E]] como la
%    lista de abiertos.
busqueda(M,S) :-
   estado_inicial(E),    % 1
   busqueda(M,[[E]],S).  % 2

% busqueda(+M,+Abiertos,?S)
%    se verifica si S es una solución encontrada por búsqueda según el método
%    M a partir de las listas de Abiertos.
% Procedimiento:
% 1. Si 
%     1.1. el primer elemento de Abiertos es [E|C] y
%     1.2. E es un estado final,
%    entonces
%     1.3 S es la inversa de [E|C].
% 2. Si
%     2.1. N es un nodo de Abiertos (seleccionado según el método M) y R son
%          los restantes nodos de Abiertos,
%     2.2. Sucesores es la lista de los sucesores del nodo N,
%     2.3. los nuevos abiertos, NAbiertos, es la lista obtenida expandiendo
%          (según el método M) R con los Sucesores
%    entonces
%     2.4. S es la solución obtenida por búsqueda (según el método M) con los
%          nuevos abiertos.
busqueda(_M,Abiertos,S) :-
   Abiertos = [[E|C]|_],              % 1.1
   estado_final(E),                   % 1.2
   reverse([E|C],S).                  % 1.3
busqueda(M,Abiertos,S) :-
   selecciona(M,Abiertos,N,R),        % 2.1
   % write(N), nl,
   sucesores(N,Sucesores),            % 2.2
   expande(M,R,Sucesores,NAbiertos),  % 2.3
   busqueda(M,NAbiertos,S).           % 2.4

% selecciona(+M,+LN1,?N,?LN2)
%    se verifica si N es un nodo de la lista LN1 y LN2 es la lista de los
%    restantes nodos.
:- discontiguous selecciona/4.

% sucesores(+N,?L) 
%    se verifica si L es la lista de los sucesores del nodo N.
sucesores([E|C],L) :-
   findall([E1,E|C],sucesor(E,E1),L).

% expande(+M,+L1,+Sucesores,?L2)
%    se verifica si L2 es la lista expandiendo (según el método M) la lista de
%    nodos L1 con la lista de nodos Sucesores.
:- discontiguous expande/4.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Búsqueda en anchura                                                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

selecciona(anchura,[N|R],N,R).

expande(anchura,L1,Sucesores,L2) :-
   append(L1,Sucesores,L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Búsqueda en profundidad                                                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

selecciona(profundidad,[N|R],N,R).

expande(profundidad,L1,Sucesores,L2) :-
   append(Sucesores,L1,L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Búsqueda optimal                                                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

selecciona(optimal,LN1,N,LN2) :-
   selecciona_con_valor(optimal,LN1,N,LN2).

selecciona_con_valor(M,LN1,N,LN2) :-
   member(N,LN1),
   valor(M,N,V),
   \+ (member(N1,LN1),
       valor(M,N1,V1),
       V1 < V),
   select(LN1,N,LN2).

% valor(+M,+N,?V)
%    se verifica si el valor (según el método M) del nodo N es V.
:- discontiguous valor/3. 
valor(optimal,N,V) :-
   coste_camino(N,V).

% coste_camino(+N,?V)
%    se verifica si V es el coste del nodo N.
coste_camino([_E],0).
coste_camino([E2,E1|R],V) :-
   coste(E2,E1,V1),
   coste_camino([E1|R],V2),
   V is V1+V2.

expande(optimal,L1,Sucesores,L2) :-
   append(Sucesores,L1,L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Búsqueda por primero el mejor                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

selecciona(primero_el_mejor,LN1,N,LN2) :-
   selecciona_con_valor(primero_el_mejor,LN1,N,LN2).

valor(primero_el_mejor,[E|_R],V) :-
   heuristica(E,V).

expande(primero_el_mejor,L1,Sucesores,L2) :-
   append(Sucesores,L1,L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Búsqueda por A*                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

selecciona(a_estrella,LN1,N,LN2) :-
   selecciona_con_valor(a_estrella,LN1,N,LN2).

valor(a_estrella,[E|R],V) :-
   coste_camino([E|R],V1),
   heuristica(E,V2),
   V is V1+V2.

expande(a_estrella,L1,Sucesores,L2) :-
   append(Sucesores,L1,L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- [busqueda, grafo].
% Yes
% 
% ?- busqueda(anchura,S).
% [f103]
% [fe, f103]
% [l2p3, f103]
% [f109, f103]
% [correo, fe, f103]
% [l2p1, l2p3, f103]
% [l2p4, l2p3, f103]
% [f111, f109, f103]
% [f119, f109, f103]
% [l3p2, l2p1, l2p3, f103]
% [l2p2, l2p1, l2p3, f103]
% [f109, l2p4, l2p3, f103]
% [almacén, f119, f109, f103]
% [f123, f119, f109, f103]
% [l3p3, l3p2, l2p1, l2p3, f103]
% [l3p1, l3p2, l2p1, l2p3, f103]
% [l2p4, l2p2, l2p1, l2p3, f103]
% [f111, f109, l2p4, l2p3, f103]
% [f119, f109, l2p4, l2p3, f103]
% 
% S = [f103, f109, f119, f123, h123] ;
% [h123, f123, f119, f109, f103]
% [f125, f123, f119, f109, f103]
% [l3p3, l3p1, l3p2, l2p1, l2p3, f103]
% [f109, l2p4, l2p2, l2p1, l2p3, f103]
% [almacén, f119, f109, l2p4, l2p3, f103]
% [f123, f119, f109, l2p4, l2p3, f103]
% [f111, f109, l2p4, l2p2, l2p1, l2p3, f103]
% [f119, f109, l2p4, l2p2, l2p1, l2p3, f103]
% 
% S = [f103, l2p3, l2p4, f109, f119, f123, h123] 
% Yes
% 
% ?- busqueda(profundidad,S).
% [f103]
% [fe, f103]
% [correo, fe, f103]
% [l2p3, f103]
% [l2p1, l2p3, f103]
% [l3p2, l2p1, l2p3, f103]
% [l3p3, l3p2, l2p1, l2p3, f103]
% [l3p1, l3p2, l2p1, l2p3, f103]
% [l3p3, l3p1, l3p2, l2p1, l2p3, f103]
% [l2p2, l2p1, l2p3, f103]
% [l2p4, l2p2, l2p1, l2p3, f103]
% [f109, l2p4, l2p2, l2p1, l2p3, f103]
% [f111, f109, l2p4, l2p2, l2p1, l2p3, f103]
% [f119, f109, l2p4, l2p2, l2p1, l2p3, f103]
% [almacén, f119, f109, l2p4, l2p2, l2p1, l2p3, f103]
% [f123, f119, f109, l2p4, l2p2, l2p1, l2p3, f103]
% 
% S = [f103, l2p3, l2p1, l2p2, l2p4, f109, f119, f123, h123] 
% Yes
% 
% ?- busqueda(optimal,S).
% [f103]
% [l2p3, f103]
% [l2p1, l2p3, f103]
% [fe, f103]
% [l3p2, l2p1, l2p3, f103]
% [l2p4, l2p3, f103]
% [f109, f103]
% [correo, fe, f103]
% [l2p2, l2p1, l2p3, f103]
% [l3p1, l3p2, l2p1, l2p3, f103]
% [f111, f109, f103]
% [l2p4, l2p2, l2p1, l2p3, f103]
% [l3p3, l3p2, l2p1, l2p3, f103]
% [f109, l2p4, l2p3, f103]
% [f111, f109, l2p4, l2p3, f103]
% [l3p3, l3p1, l3p2, l2p1, l2p3, f103]
% [f109, l2p4, l2p2, l2p1, l2p3, f103]
% [f111, f109, l2p4, l2p2, l2p1, l2p3, f103]
% [f119, f109, f103]
% [f119, f109, l2p4, l2p3, f103]
% [almacén, f119, f109, f103]
% [f123, f119, f109, f103]
% 
% S = [f103, f109, f119, f123, h123] 
% Yes
% 
% ?- busqueda(primero_el_mejor,S).
% [f103]
% [l2p3, f103]
% [l2p1, l2p3, f103]
% [l3p2, l2p1, l2p3, f103]
% [l3p1, l3p2, l2p1, l2p3, f103]
% [l3p3, l3p1, l3p2, l2p1, l2p3, f103]
% [l3p3, l3p2, l2p1, l2p3, f103]
% [l2p2, l2p1, l2p3, f103]
% [l2p4, l2p2, l2p1, l2p3, f103]
% [l2p4, l2p3, f103]
% [f109, l2p4, l2p3, f103]
% [f119, f109, l2p4, l2p3, f103]
% [f123, f119, f109, l2p4, l2p3, f103]
% 
% S = [f103, l2p3, l2p4, f109, f119, f123, h123] 
% Yes
% 
% ?- busqueda(a_estrella,S).
% [f103]
% [l2p3, f103]
% [l2p1, l2p3, f103]
% [l3p2, l2p1, l2p3, f103]
% [l3p1, l3p2, l2p1, l2p3, f103]
% [l3p3, l3p2, l2p1, l2p3, f103]
% [l2p2, l2p1, l2p3, f103]
% [l2p4, l2p3, f103]
% [fe, f103]
% [l2p4, l2p2, l2p1, l2p3, f103]
% [l3p3, l3p1, l3p2, l2p1, l2p3, f103]
% [f109, f103]
% [f119, f109, f103]
% [f123, f119, f109, f103]
% 
% S = [f103, f109, f119, f123, h123] 
% Yes

