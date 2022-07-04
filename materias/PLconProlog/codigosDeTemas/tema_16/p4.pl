defecto((vuela(X) :- pajaro(X))).

regla((pajaro(X) :- avestruz(X))).
regla(((\+ vuela(X)) :- avestruz(X))).

regla((avestruz(animal_1) :- true)).
regla((pajaro(animal_2) :- true)).

% Sesión
% ======

% ?- [p4, razonamiento_por_defecto].
% true.
% 
% ?- explica(vuela(X),E).
% X = animal_2,
% E = [defecto((vuela(animal_2):-pajaro(animal_2))),regla((pajaro(animal_2):-true))] ;
% false.
% 
% ?- explica(\+ vuela(X),E).
% X = animal_1,
% E = [regla((\+vuela(animal_1):-avestruz(animal_1))),regla((avestruz(animal_1):-true))] ;
% false.

