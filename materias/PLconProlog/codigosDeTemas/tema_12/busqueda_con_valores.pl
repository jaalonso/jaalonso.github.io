% busqueda_con_valores.pl
% Procedimiento general de búsqueda con valores
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 27-junio-2022
% ======================================================================

% Relaciones dependientes del problema
% ====================================

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado-final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.
% 4. coste(E1,E2,C) que se verifica si C es el coste de ir del estado E1 al E2.
% 5. heuristica(E,H) que se verifica si H es la heurística del estado E.

% Procedimiento general de búsqueda
% =================================

% Un NODO es un término V-[E_n,...,E_1] de forma que E_1 es el estado inicial,
% E_(i+1) es un sucesor de E_i y V es el valor de [E_n,...,E_1] según el
% procedimiento de búsqueda.
% 
% ABIERTOS es una lista de nodos (los nodos pendientes de analizar).

% busqueda(+M,?S) se verifica si S es una solución del problema mediante
% búsqueda según el método M. 
% Procedimiento:
% 1. Sea E el estado inicial y
% 2. sea V el valor del nodo [E]
% 3. La solución S es la obtenida por búsqueda en anchura con [[E]] como la
%    lista de abiertos.
busqueda(M,S) :-
   estado_inicial(E),      % 1
   valor(M,0-[],E,V),      % 2
   busqueda(M,[V-[E]],S).  % 3

% valor(+M,+N,+E,?V) se verifica si el valor (según el método M) de la
% extensión del nodo N con el estado E es V.  
:- discontiguous valor/3.

% busqueda(+M,+Abiertos,?S) se verifiica si S es una solución encontrada
% por búsqueda según el método M a partir de las listas de Abiertos. 
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
   Abiertos = [_-[E|C]|_],            % 1.1
   estado_final(E),                   % 1.2
   reverse([E|C],S).                  % 1.3
busqueda(M,Abiertos,S) :-
   selecciona(M,Abiertos,N,R),        % 2.1
   sucesores(M,N,Sucesores),          % 2.2
   expande(M,R,Sucesores,NAbiertos),  % 2.3
   busqueda(M,NAbiertos,S).           % 2.4

% selecciona(+M,+LN1,?N,?LN2) se verifica si N es un nodo de la lista
% LN1 y LN2 es la lista de los restantes nodos. 
selecciona(_M,[N|R],N,R).

% sucesores(+N,?L) se verifica si L es la lista de los sucesores del
% nodo N. 
sucesores(M,V-[E|C],L) :-
   findall(V1-[E1,E|C],
          (sucesor(E,E1),valor(M,V-[E|C],E1,V1)),
          L).

% expande(+M,+L1,+Sucesores,?L2) se verifica si L2 es la lista
% expandiendo (según el método M) la lista de nodos L1 con la lista de
% nodos Sucesores, ordenada por sus valores. 
expande(_M,L1,Sucesores,L2) :-
   append(Sucesores,L1,L3),
   sort(L3,L2).

% Búsqueda optimal
% ================

% valor(+M,+N,?V) se verifica si el valor (según el método M) del nodo N
% es V. 
valor(optimal,0-[],_E,0).
valor(optimal,V-[E|_C],E1,V1) :-
   coste(E,E1,V2),
   V1 is V+V2.

% Búsqueda por primero el mejor
% =============================

valor(primero_el_mejor,_N,E,V) :-
   heuristica(E,V).

% Búsqueda por A*
% ===============

valor(a_estrella,0-[],E,H+0) :-
   heuristica(E,H).
valor(a_estrella,_F+C-[E|_R],E1,F1+C1) :-
   coste(E,E1,C2),
   C1 is C+C2,
   heuristica(E1,H),
   F1 is C1+H.

% Sesión
% ======

% ?- [busqueda_con_valores, robot_repartidor].
% true.
% 
% ?- busqueda(optimal,S).
% S = [f103,f109,f119,f123,h123] 
% ?- busqueda(primero_el_mejor,S).
% S = [f103,f109,f119,f123,h123] 
% ?- busqueda(a_estrella,S).
% S = [f103,f109,f119,f123,h123] 
