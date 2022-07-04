explica(A,E) :-
   explica(A,[],E).

explica(true,E,E) :- !.
explica((A,B),E0,E) :- !,
   explica(A,E0,E1),
   explica(B,E1,E).
explica(A,E0,E) :-
   prueba(A,E0,E).	
explica(A,E0,[defecto(Nombre)|E]) :-
   defecto(Nombre,(A:-B)),
   explica(B,E0,E),
   \+ contradiccion(Nombre,E),
   \+ contradiccion(A,E).

prueba(true,E,E) :- !.
prueba((A,B),E0,E) :- !,
   prueba(A,E0,E1),
   prueba(B,E1,E).
prueba(A,E0,[regla((A:-B))|E]) :-
   regla((A:-B)),
   prueba(B,E0,E).

contradiccion(\+ A,E) :- !,
   prueba(A,E,_E1).
contradiccion(A,E) :-
   prueba(\+ A,E,_E1).

% Sesión
% ======

% ?- [p6, razonamiento_por_defecto_con_nombres].
% true.
% 
% ?- explica(vuela(dracula),E).
% false.
% 
% ?- explica(\+ vuela(dracula),E).
% E = [defecto(muertos_no_vuelan(dracula)),
%      regla((muerto(dracula):-true))] ;
% false.
