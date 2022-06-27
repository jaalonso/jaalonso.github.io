% robot_reartidor.pl
% Grafo de búsqueda del robot repartidor.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 27-junio-2022
% ======================================================================

% Lenguaje
% ========

% f103    = en frente la habitación 103.
% fe      = en frente la escalera
% correo  = en el correo
% l2p3    = en la puerta 3 del laboratorio 2
% almacén = en el almacén
% h123    = en la habitación 123

% Estado inicial 
% ==============

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial(f103).

% Estados finales
% ===============

% estado_final(?E) se verifica si E es un estado final.
estado_final(h123).

% Sucesores
% =========

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1. 
sucesor(f103,fe). 
sucesor(f103,l2p3). 
sucesor(f103,f109). 
sucesor(fe,correo). 
sucesor(f109,f111). 
sucesor(f109,f119). 
sucesor(f119,almacén). 
sucesor(f119,f123). 
sucesor(f123,h123). 
sucesor(f123,f125). 
sucesor(l2p1,l3p2). 
sucesor(l2p1,l2p2). 
sucesor(l2p2,l2p4). 
sucesor(l2p3,l2p1). 
sucesor(l2p3,l2p4). 
sucesor(l2p4,f109). 
sucesor(l3p2,l3p3). 
sucesor(l3p2,l3p1). 
sucesor(l3p1,l3p3).

% Coste                                                                     %%
% =====

% coste(+E1,+E2,?C) se verifica si C es el coste de ir del estado E1 al
% E2. 
coste(E1,E2,C) :-
   posicion(E1,X1,Y1),
   posicion(E2,X2,Y2),
   C is abs(X1-X2)+abs(Y1-Y2).

% posicion(E,X,Y) se verifica si la posición del estado E es (X,Y). 
posicion(correo,17,43).
posicion(fe,23,43).
posicion(f103,31,43).
posicion(f109,43,43).
posicion(f111,47,43).
posicion(f119,42,58).
posicion(f123,33,58).
posicion(f125,29,58).
posicion(h123,33,62).
posicion(l2p1,33,49).
posicion(l2p2,39,49).
posicion(l2p3,32,46).
posicion(l2p4,39,46).
posicion(l3p1,34,55).
posicion(l3p2,33,52).
posicion(l3p3,39,52).
posicion(almacén,45,62).

% Heurística
% ==========

% heuristica(+E,?H) se verifica si H es la heurística del estado E.
heuristica(E,H) :-
   posicion(E,X,Y),
   estado_final(E1),
   posicion(E1,X1,Y1),
   H is abs(X-X1)+abs(Y-Y1).

% Sesión
% ======

% ?- [busqueda, robot_repartidor].
% true.
% 
% ?- busqueda(anchura,S).
% [f103]
% [fe,f103]
% [l2p3,f103]
% [f109,f103]
% [correo,fe,f103]
% [l2p1,l2p3,f103]
% [l2p4,l2p3,f103]
% [f111,f109,f103]
% [f119,f109,f103]
% [l3p2,l2p1,l2p3,f103]
% [l2p2,l2p1,l2p3,f103]
% [f109,l2p4,l2p3,f103]
% [almacén,f119,f109,f103]
% [f123,f119,f109,f103]
% [l3p3,l3p2,l2p1,l2p3,f103]
% [l3p1,l3p2,l2p1,l2p3,f103]
% [l2p4,l2p2,l2p1,l2p3,f103]
% [f111,f109,l2p4,l2p3,f103]
% [f119,f109,l2p4,l2p3,f103]
% S = [f103,f109,f119,f123,h123] 
% 
% ?- busqueda(profundidad,S).
% [f103]
% [fe,f103]
% [correo,fe,f103]
% [l2p3,f103]
% [l2p1,l2p3,f103]
% [l3p2,l2p1,l2p3,f103]
% [l3p3,l3p2,l2p1,l2p3,f103]
% [l3p1,l3p2,l2p1,l2p3,f103]
% [l3p3,l3p1,l3p2,l2p1,l2p3,f103]
% [l2p2,l2p1,l2p3,f103]
% [l2p4,l2p2,l2p1,l2p3,f103]
% [f109,l2p4,l2p2,l2p1,l2p3,f103]
% [f111,f109,l2p4,l2p2,l2p1,l2p3,f103]
% [f119,f109,l2p4,l2p2,l2p1,l2p3,f103]
% [almacén,f119,f109,l2p4,l2p2,l2p1,l2p3,f103]
% [f123,f119,f109,l2p4,l2p2,l2p1,l2p3,f103]
% S = [f103,l2p3,l2p1,l2p2,l2p4,f109,f119,f123,h123] ;
% [h123,f123,f119,f109,l2p4,l2p2,l2p1,l2p3,f103]
% [f125,f123,f119,f109,l2p4,l2p2,l2p1,l2p3,f103]
% [l2p4,l2p3,f103]
% [f109,l2p4,l2p3,f103]
% [f111,f109,l2p4,l2p3,f103]
% [f119,f109,l2p4,l2p3,f103]
% [almacén,f119,f109,l2p4,l2p3,f103]
% [f123,f119,f109,l2p4,l2p3,f103]
% S = [f103,l2p3,l2p4,f109,f119,f123,h123] 
% 
% ?- busqueda(optimal,S).
% [f103]
% [l2p3,f103]
% [l2p1,l2p3,f103]
% [fe,f103]
% [l3p2,l2p1,l2p3,f103]
% [l2p4,l2p3,f103]
% [f109,f103]
% [correo,fe,f103]
% [l2p2,l2p1,l2p3,f103]
% [l3p1,l3p2,l2p1,l2p3,f103]
% [f111,f109,f103]
% [l2p4,l2p2,l2p1,l2p3,f103]
% [l3p3,l3p2,l2p1,l2p3,f103]
% [f109,l2p4,l2p3,f103]
% [f111,f109,l2p4,l2p3,f103]
% [l3p3,l3p1,l3p2,l2p1,l2p3,f103]
% [f109,l2p4,l2p2,l2p1,l2p3,f103]
% [f111,f109,l2p4,l2p2,l2p1,l2p3,f103]
% [f119,f109,f103]
% [f119,f109,l2p4,l2p3,f103]
% [almacén,f119,f109,f103]
% [f123,f119,f109,f103]
% S = [f103,f109,f119,f123,h123] ;
% [f119,f109,l2p4,l2p2,l2p1,l2p3,f103]
% [h123,f123,f119,f109,f103]
% [f125,f123,f119,f109,f103]
% [almacén,f119,f109,l2p4,l2p3,f103]
% [f123,f119,f109,l2p4,l2p3,f103]
% S = [f103,l2p3,l2p4,f109,f119,f123,h123] 
% 
% ?- busqueda(primero_el_mejor,S).
% [f103]
% [l2p3,f103]
% [l2p1,l2p3,f103]
% [l3p2,l2p1,l2p3,f103]
% [l3p1,l3p2,l2p1,l2p3,f103]
% [l3p3,l3p1,l3p2,l2p1,l2p3,f103]
% [l3p3,l3p2,l2p1,l2p3,f103]
% [l2p2,l2p1,l2p3,f103]
% [l2p4,l2p2,l2p1,l2p3,f103]
% [l2p4,l2p3,f103]
% [f109,l2p4,l2p3,f103]
% [f119,f109,l2p4,l2p3,f103]
% [f123,f119,f109,l2p4,l2p3,f103]
% S = [f103,l2p3,l2p4,f109,f119,f123,h123] 
% 
% ?- busqueda(a_estrella,S).
% [f103]
% [l2p3,f103]
% [l2p1,l2p3,f103]
% [l3p2,l2p1,l2p3,f103]
% [l3p1,l3p2,l2p1,l2p3,f103]
% [l3p3,l3p2,l2p1,l2p3,f103]
% [l2p2,l2p1,l2p3,f103]
% [l2p4,l2p3,f103]
% [fe,f103]
% [l2p4,l2p2,l2p1,l2p3,f103]
% [l3p3,l3p1,l3p2,l2p1,l2p3,f103]
% [f109,f103]
% [f119,f109,f103]
% [f123,f119,f109,f103]
% S = [f103,f109,f119,f123,h123] 
