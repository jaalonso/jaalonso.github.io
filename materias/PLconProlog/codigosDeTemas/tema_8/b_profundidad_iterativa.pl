% b_profundidad_iterativa.pl
% Búsqueda en profundidad acotada.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 26-mayo-2022
% ======================================================================

% Relaciones dependientes del problema
% ====================================

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado-final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.

% Búsqueda en profundidad iterativa
% =================================

% Un NODO es una lista de estados [E_n,...,E_1] de forma que E_1 es el
% estado inicial y E_(i+1) es un sucesor de E_i.

profundidad_iterativa(S) :-
   profundidad_iterativa(S,1).

profundidad_iterativa(S,Cota) :-
   profundidad_acotada(S,Cota).
profundidad_iterativa(S,Cota) :-
   Cota1 is Cota+1,
   profundidad_iterativa(S,Cota1).

:- use_module(b_profundidad_acotada).
