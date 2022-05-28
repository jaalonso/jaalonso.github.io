% b_a_estrella.pl
% A* (Versión 1: Variación de minimal).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

:- module(b_a_estrella, [a_estrella/1]).

% Relaciones dependientes del problema
% =====================================

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado-final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.
% 4. coste(E1,E2,C) que se verifica si C es el coste de ir del estado E1
%    al E2.
% 5. heuristica(E,H) que se verifica si H es la heurística del estado E.

% Procedimiento A*
% ================

% Un NODO es un término de la forma F/C-[E_n,...,E_1] donde
% [E_n,...,E_1] es una lista de estados de forma que E_1 es el estado
% inicial y E_(i+1) es un sucesor de E_i, C es el coste de dicho camino
% y F es la suma de C y la heurística de E_n.

% ABIERTOS es una lista de nodos.

% a_estrella(?S) se verifica si S es una solución del problema mediante
% A*. El procedimiento es
% + Sea E el estado inicial y H su heurística. La solución S es la
%   solución obtenida por A* a partir de [H/0-[E]].
a_estrella(S) :-
   estado_inicial(E),
   heuristica(E,H),
   a_estrella([H/0-[E]],S).

% a_estrella(+Abiertos,?S) se verifica si S es una solución del problema
% a partir de Abiertos mediante A*. El procedimiento es
% 1. Si
%         _-[E|C] es el mejor nodo de Abiertos y
%     1.1 E es un estado final,
%    entonces
%     1.2 S es la inversa de [E|C].
% 2. Si
%         N es el mejor nodo de Abiertos y R son los restantes;
%     2.1 Sucesores son los sucesores de E que no están en su camino,
%     2.2 NAbiertos1 es la lista obtenida añadiendo Sucesores a
%         continuación de R y
%     2.3 NAbiertos2 es la lista obtenida ordenando NAbiertos1;
%    entonces
%     2.4 S es la solución encontrada por búsqueda minimal a partir de
%         Nodos2 y Co es su coste.
a_estrella([_-[E|C]|_],S) :-
        estado_final(E),                % 1.1
        reverse([E|C],S).               % 1.2
a_estrella([N|R],S) :-
        expande(N,Sucesores),           % 2.1
        append(R,Sucesores,NAbiertos1), % 2.2
        sort(NAbiertos1,NAbiertos2),    % 2.3
        a_estrella(NAbiertos2,S).       % 2.4

% expande(+N,?Sucs) se verifica si Sucs es la lista de sucesores del
% nodo N que no han sido visitados (es decir, los sucesores del primer
% elemento de N que no pertenecen al resto de N).
expande(_/C-[E|R],Sucs) :-
   findall(F1/C1-[E1,E|R],
           (sucesor(E,E1),
            not(member(E1,R)),
            coste(E,E1,C2),
            C1 is C+C2,
            heuristica(E1,H1),
            F1 is C1+H1),
           Sucs).
