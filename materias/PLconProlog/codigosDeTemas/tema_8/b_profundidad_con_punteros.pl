% b_profundidad_con_punteros.pl
% búsqueda en profundidad con punteros.
% Ref. Flach-94 p. 120
% ======================================================================

:- module(b_profundidad_con_punteros, [profundidad_con_punteros/1]).

% Relaciones dependientes del problema
% ====================================

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado-final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.

% Búsqueda en profundidad con punteros
% ====================================

% Un NODO es una lista de dos elementos [E_2,E_1] de forma que
% + E_2 es el estado inicial y E_1 es "inicial" o
% + E_2 es un sucesor del estado E_1.
%
% ABIERTOS es una lista de nodos (los nodos pendientes de analizar).
%
% CERRADOS es una lista de nodos (los nodos analizados).

% profundidad_con_punteros(?S) se verifica si S es una solución del
% problema mediante búsqueda en profundidad.. El procedimientoes
% 1. Sea E el estado inicial.
% 2. La solución S es la obtenida por búsqueda en profundidad con
%    [[E,inicial]] como la lista de abiertos y [] como la lista de
%    cerrados.
profundidad_con_punteros(S) :-
   estado_inicial(E),                              % 1
   profundidad_con_punteros([[E,inicial]],[ ],S).  % 2

% profundidad_con_punteros(+Abiertos,+Cerrados,?Solucion) se verifica si
% Solucion es la solución encontrada por búsqueda en profundidad a
% partir de las listas Abiertos y Cerrados. El procedimiento es
% 1. Si
%     1.1. el primer elemento de abiertos es [E,E1],
%     1.2. E es un estado final y
%     1.3. C es el camino hasta E construido según E1 y Cerrados.
%    entonces
%     1.4. S es la inversa de C.
% 2. Si
%     2.1. Abiertos es la lista [[E,E1]|R],
%     2.2. la lista de los sucesores de E que no están ni en Abiertos ni
%          en Cerrados es Sucesores,
%     2.3. los nuevos abiertos, NAbiertos, es la lista obtenida
%          añadiendo dichos Sucesores al principio de R y
%     2.4. los nuevos cerrados, NCerrados, es la lista obtenida
%          añadiendo [E,E1] a cerrados,
%    entonces
%     2.5. S es la solución obtenida por búsqueda en profundidad con los
%          nuevos abiertos y los nuevos cerrados.
profundidad_con_punteros(Abiertos,Cerrados,S) :-
   Abiertos = [[E,E1]|_],                           % 1.1
   estado_final(E),                                 % 1.2
   camino([E,E1],Cerrados,C),                       % 1.3
   reverse(C,S).                                    % 1.4
profundidad_con_punteros(Abiertos,Cerrados,S) :-
   Abiertos = [[E,E1]|R],                           % 2.1
   expande(Abiertos,Cerrados,Sucesores),            % 2.2
   append(Sucesores,R,NAbiertos),                   % 2.3
   NCerrados = [[E,E1]|Cerrados],                   % 2.4
   profundidad_con_punteros(NAbiertos,NCerrados,S). % 2.5

% expande(+Abiertos,+Cerrados,?Sucesores) se verifica si Sucesores es la
% lista de los sucesores del primer elemento de Abiertos que no
% pertenecen si a Abiertos ni a Cerrados.
expande(Abiertos,Cerrados,Sucesores) :-
   Abiertos = [[E,_]|_],
   findall([E1,E],
           (sucesor(E,E1),
            not(memberchk([E1,_],Abiertos)),
            not(memberchk([E1,_],Cerrados))),
           Sucesores).

% camino(+Nodo,+Cerrados,?C) se verifica si C es el camino hasta E
% construido según E1 y Cerrados.
camino([E,E1],Cerrados,[E|C1]) :-
   member([E1,E2],Cerrados),
   camino([E1,E2],Cerrados,C1).
camino([E,inicial],_,[E]).
