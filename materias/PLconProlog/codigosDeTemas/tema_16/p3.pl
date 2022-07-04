:- dynamic anormal/1.

pajaro(animal_1).
avestruz(animal_1).
vuela(X) :- 
   pajaro(X),
   \+ anormal(X).
anormal(X) :- avestruz(X).

% Sesión
% ======

% ?- vuela(animal_1).
% false.

% Árbol de computación
% ====================

/*
                               vuela(animal_1)
                                      |
                               pajaro(animal_1),
                               not anormal(animal_1)
                                      |
                               not anormal(animal_1)
                                      |
                               +------+-------+
                               |              /
                    anormal(animal_1),
                    !,
                    fail
                      |
                    avestruz(animal_1),
                    !,
                    fail.
                      |
                    !,
                    fail
                      |
                    fail
                      |
                    Fallo  
*/
