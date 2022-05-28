% b_profundidad_acotada.pl
% Búsqueda en profundidad acotada.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

:- module(b_profundidad_acotada, [profundidad_acotada/2]).

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

% profundidad_acotada(?S,+Cota) se verifica si S es una solución del
% problema mediante búsqueda en profundidad en acotada con Cota.
profundidad_acotada(Sol,Cota) :-
   estado_inicial(E),
   profundidad_acotada([E],Sol,Cota).

% profundidad_acotada(+N,?S,+Cota) se verifica si S es una solución del
% problema a partir del nodo N (es decir S = [E1,...,En] donde E1 = E,
% En es un estado final y E_(i+1) es un sucesor de Ei), encontrada por
% búsqueda en profundidad acotada con Cota.
%
% Procedimiento:
% 1. Si el primer elemento de N es un estado final, entonces S es la
%    inversa de N.
% 2. Si N = [E|C], la Cota es positiva y E1 un sucesor de E que no ha
%    sido visitado (es decir, que no pertenece a C) y tal que existe una
%    solución, S, a partir de [E1,E|C] con Cota-1.
profundidad_acotada([E|C],Sol,_) :-
   estado_final(E),
   reverse([E|C],Sol).
profundidad_acotada([E|C],Sol,Cota) :-
   Cota > 0,
   sucesor(E,E1),
   not(member(E1,C)),
   NuevaCota is Cota-1,
   profundidad_acotada([E1,E|C],Sol,NuevaCota).
