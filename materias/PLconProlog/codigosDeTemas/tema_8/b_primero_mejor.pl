% b_primero_mejor.pl
% Búsqueda por primero el mejor.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

:- module(b_primero_mejor, [primero_el_mejor/1]).

% Relaciones dependientes del problema
% ====================================

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado-final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.
% 4. heuristica(E,H) que se verifica si H es la heurística del estado E.

% Búsqueda por primero el mejor
% =============================

% Un NODO es un término H-[E_n,...,E_1] de forma que E_1 es el estado
% inicial, E_(i+1) es un sucesor de E_i y H es la heurística de E_n.
%
% ABIERTOS es una lista de nodos (los nodos pendientes de analizar).
%
% CERRADOS es una lista de estados (los estados analizados).

% primero_el_mejor(?S) se verifica si S es una solución del problema
% mediante búsqueda por primero el mejor. El procedimiento es
% 1. Sea E el estado inicial y
% 2. H la heurística de E.
% 3. La solución S es la obtenida por búsqueda por primero el mejor con
%    [H-[E]] como la lista de abiertos y [] como la lista de cerrados.
primero_el_mejor(S) :-
   estado_inicial(E),               % 1
   heuristica(E,H),                 % 2
   primero_el_mejor([H-[E]],[ ],S). % 3

% primero_el_mejor(+Abiertos,+Cerrados,?Solucion) se verifica si
% Solucion es la solución encontrada por búsqueda por primero el mejor a
% partir de las listas Abiertos y Cerrados. El procedimiento es
% 1. Si
%     1.1. el primer elemento de Abiertos es _-[E|C] y
%     1.2. E es un estado final,
%    entonces
%     1.3 S es la inversa de [E|C].
% 2. Si
%     2.1. Abiertos es la lista [_-[E|_]|R],
%     2.2. la lista de los sucesores de E que no están ni en Abiertos ni en
%          Cerrados es Sucesores,
%     2.3. los nuevos abiertos, NAbiertos1, es la lista obtenida añadiendo
%          dichos Sucesores a continuación de R,
%     2.4. la lista ordenada de los nuevos abiertos es NAbiertos y
%     2.5. los nuevos cerrados, NCerrados, es la lista obtenida añadiendo E a
%          Cerrados,
%    entonces
%     2.6. S es la solución obtenida por búsqueda primero el mejor con los
%          nuevos abiertos y los nuevos cerrados.
primero_el_mejor(Abiertos,_,S) :-
        Abiertos = [_-[E|C]|_],                  % 1.1
        estado_final(E),                         % 1.2
        reverse([E|C],S).                        % 1.3
primero_el_mejor(Abiertos,Cerrados,S) :-
        Abiertos = [_-[E|_]|R],                  % 2.1
        expande(Abiertos,Cerrados,Sucesores),    % 2.2
        append(R,Sucesores,NAbiertos1),          % 2.3
        sort(NAbiertos1,NAbiertos),              % 2.4
        NCerrados = [E|Cerrados],                % 2.5
        primero_el_mejor(NAbiertos,NCerrados,S). % 2.6

% expande(+Abiertos,+Cerrados,?Sucesores) se verifica si Sucesores es la
% lista de los sucesores del primer elemento de Abiertos que no
% pertenecen si a Abiertos ni a Cerrados.
expande(Abiertos,Cerrados,Sucesores) :-
   Abiertos = [_-[E|C]|_],
   findall(H1-[E1,E|C],
           (sucesor(E,E1),
            not(memberchk(_-[E1|_],Abiertos)),
            not(memberchk(E1,Cerrados)),
            heuristica(E1,H1)),
           Sucesores).
