% b_anchura_con_cerrados.pl
% Búsqueda en anchura con cerrados.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

:- module(b_anchura_con_cerrados, [anchura_con_cerrados/1]).

% Relaciones dependientes del problema
% ====================================

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado-final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.

% Búsqueda en anchura con cerrados
% ================================

% Un NODO es una lista de estados [E_n,...,E_1] de forma que E_1 es el
% estado inicial y E_(i+1) es un sucesor de E_i.
%
% ABIERTOS es una lista de nodos (los nodos pendientes de analizar).
%
% CERRADOS es una lista de estados (los estados analizados).

% anchura_con_cerrados(?S) se verifica si S es una solución del problema
% mediante búsqueda en anchura. El procedimientoes
% 1. Sea E el estado inicial.
% 2. La solución S es la obtenida por búsqueda en anchura con [[E]] como la
%    lista de abiertos y [] como la lista de cerrados.
anchura_con_cerrados(S) :-
   estado_inicial(E),                              % 1
   anchura_con_cerrados([[E]],[ ],S).              % 2

% anchura_con_cerrados(+Abiertos,+Cerrados,?Solucion) se verifica si
% Solucion es la solucion encontrada por búsqueda en anchura a partir de
% las listas Abiertos y Cerrados. El procedimiento es
% 1. Si
%     1.1. el primer elemento de Abiertos es [E|C] y
%     1.2. E es un estado final,
%    entonces
%     1.3 S es la inversa de [E|C].
% 2. Si
%     2.1. Abiertos es la lista [[E|_]|R],
%     2.2. la lista de los sucesores de E que no están ni en Abiertos ni en
%          Cerrados es Sucesores,
%     2.3. los nuevos abiertos, NAbiertos, es la lista obtenida añadiendo
%          dichos Sucesores a continuación de R y
%     2.4. los nuevos cerrados, NCerrados, es la lista obtenida añadiendo E a
%          Cerrados,
%    entonces
%     2.5. S es la solución obtenida por búsqueda en anchura con los nuevos
%          abiertos y los nuevos cerrados.
anchura_con_cerrados(Abiertos,_,S) :-
   Abiertos = [[E|C]|_],                           % 1.1
   estado_final(E),                                % 1.2
   reverse([E|C],S).                               % 1.3
anchura_con_cerrados(Abiertos,Cerrados,S) :-
   Abiertos = [[E|_]|R],                           % 2.1
   expande(Abiertos,Cerrados,Sucesores),           % 2.2
   append(R,Sucesores,NAbiertos),                  % 2.3
   NCerrados = [E|Cerrados],                       % 2.4
   anchura_con_cerrados(NAbiertos,NCerrados,S).    % 2.5

% expande(+Abiertos,+Cerrados,?Sucesores)  se verifica si ucesores es la
% lista de los sucesores del primer elemento de Abiertos que no
% pertenecen si a Abiertos ni a Cerrados.
expande(Abiertos,Cerrados,Sucesores) :-
   Abiertos = [[E|C]|_],
   findall([E1,E|C],
           (sucesor(E,E1),
            not(memberchk([E1|_],Abiertos)),
            not(memberchk(E1,Cerrados))),
           Sucesores).
