:- dynamic anormal/1.

pajaro(animal_1).
vuela(X) :-
   pajaro(X),
   \+ anormal(X).

% Sesión
% ======

% ?- vuela(animal_1).
% true.
% 

% Explicación
% ===========

/*
                     vuela(animal_1) 
                           | 
                     pajaro(animal_1),
                     not anormal(animal_1)  
                           |
                     not anormal(animal_1)  
                           |
                    +------+-------+
                    |              |
        anormal((animal_1),       {}
        !,                        Respuesta = {}
        fail
         |
        Fallo
*/

