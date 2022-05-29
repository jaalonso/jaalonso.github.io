% b_escalada.pl
% Búsqueda en escalada
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

:- module(b_escalada, [escalada/1]).

% Relaciones dependientes del problema
% ====================================

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado_final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.
% 4. heuristica(E,H) que se verifica si H es la heurística del estado E.

% Búsqueda en escalada
% ====================

% Un NODO es un término de la forma H-[E_n,...,E_1] donde [E_n,...,E_1]
% es una lista de estados de forma que E_1 es el estado inicial y
% E_(i+1) es un sucesor de E_i y H es la heurística de E_n.

% escalada(?S) se verifica si S es una solución del problema mediante
% búsqueda en escalada. El procedimiento es
% + Sea E el estado inicial y H su heurística. La solución S es la
%   solución obtenida por búsqueda en escalada a partir de H-[E].
escalada(Sol) :-
   estado_inicial(E),
   heuristica(E,H),
   escalada(H-[E],Sol).

% escalada(+N,?S) se verifica si S es una solución del problema a partir
% del nodo N encontrada por búsqueda en escalada. El procedimiento es
% 1. Si
%         N=H-[E|R] y
%     1.1 E es un estado final,
%    entonces
%     1.2 S es la inversa de [E|R].
% 2. Si
%         N=H-[E|C] y
%     2.1 E1 es un sucesor de E con heurística H1 < H y E no tiene
%         sucesores con heurística menor que H1
%    entonces
%     2.2 S es la solución por escalada a partir de H1-[E1,E|R].
escalada(_H-[E|R],S) :-
   estado_final(E),          % 1.1
   reverse([E|R],S).         % 1.2
escalada(H-[E|R],S) :-
   mejor_sucesor(E,H,E1,H1), % 2.1
   escalada(H1-[E1,E|R],S).  % 2.2

mejor_sucesor(E,H,E1,H1) :-
   sucesor(E,E1),
   heuristica(E1,H1),
   H1 < H,
   not((sucesor(E,E2),
        heuristica(E2,H2),
        H2 < H1)).
