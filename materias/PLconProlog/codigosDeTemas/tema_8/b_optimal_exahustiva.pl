% b_optimal_exahustiva.pl
% Búsqueda del camino de menor coste (V1: Museo británico).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

:- module(b_optimal_exahustiva, [optimal_exhaustiva/1,
                                 coste_camino/2]).

% Relaciones dependientes del problema
% ====================================

% Se supone que se han definido
% 1. estado_inicial(E) que se verifica si E es el estado inicial.
% 2. estado-final(E) que se verifica si E es un estado final.
% 3. sucesor(E1,E2) que se verifica si E2 es un estado sucesor de E1.
% 4. coste(E1,E2,C) que se verifica si C es el coste de ir del estado E1 al E2.

% Búsqueda minimal mediante "museo británico"
% ===========================================

% optimal_exhaustiva(?S) se verifica si S es una solución minimal del
% problema. El procedimiento es
% + S es una solución del problema y no hay otra solución de menor coste.
optimal_exhaustiva(Sol) :-
   profundidad_con_ciclos(Sol),
   coste_camino(Sol,C),
   not((profundidad_con_ciclos(Sol1),
        coste_camino(Sol1,C1),
        C1 < C)).

% coste_camino(+C,?Co) se verifica si Co es el coste del camino C.
coste_camino([E2,E1],C) :-
   coste(E2,E1,C).
coste_camino([E2,E1|R],C) :-
   coste(E2,E1,C1),
   coste_camino([E1|R],C2),
   C is C1+C2.

%******************************************************************************
% § Búsqueda en profundidad en grafos
%******************************************************************************

:- [b_profundidad_con_ciclos].
