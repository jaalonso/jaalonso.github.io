% Razonamiento_por_defecto.pl
% Razonamiento por defecto.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 30-junio-2022
% ======================================================================

% explica(A,E) se verifica si E es una explicación de A usando las
% reglas y los defectos. 
explica(A,E) :-
   explica(A,[],E).

% Metaintérprete para las reglas y los defectos.
explica(true,E,E) :- !.
explica((A,B),E0,E) :- !,
   explica(A,E0,E1),
   explica(B,E1,E).
explica(A,E0,E) :-
   prueba(A,E0,E).         
explica(A,E0,[defecto((A:-B))|E]) :-
   defecto((A:-B)),
   explica(B,E0,E),
   \+ contradiccion(A,E).

% Metaintérprete para las reglas.
prueba(true,E,E) :- !.
prueba((A,B),E0,E) :- !,
   prueba(A,E0,E1),
   prueba(B,E1,E).
prueba(A,E0,[regla((A:-B))|E]) :-
   regla((A:-B)),
   prueba(B,E0,E).

% contradiccion(A,E) se verifica si la explicación E es contradictoria
% con A.
contradiccion(\+ A,E) :- !,
   prueba(A,E,_E1).
contradiccion(A,E) :-
   prueba(\+ A,E,_E).

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

