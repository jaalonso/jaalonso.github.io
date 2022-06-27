% meta_con_explicacion_como.pl
% Metaintérprete con explicaciones de COMO.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 8-junio-2022
% ======================================================================

% `<-' es el `si' del nivel objeto 
% (es un predicado infijo en el metanivel). 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% (es un símbolo de función infijo en el metanivel).
:- op(1000, xfy, &).

% prueba_con_como(O) significa probar el objetivo O a partir de la BC objeto y
% navegar por su árbol de prueba mediante preguntas COMO.
prueba_con_como(O) :-
   prueba_con_demostracion(O,A),
   navega(A).

% prueba_con_demostracion(O,A) es verdad si A es un árbol de prueba del
% objetivo O.
prueba_con_demostracion(verdad,verdad).
prueba_con_demostracion((A & B),(AA & AB)) :-
   prueba_con_demostracion(A,AA),
   prueba_con_demostracion(B,AB).
prueba_con_demostracion(A,si(A,AB)) :-
   (A <- B),
   prueba_con_demostracion(B,AB).

% navega(A) significa que se está navegando en el árbol A.
navega(si(A,verdad)) :-
    escribe_lista([A,' es un hecho']).
navega(si(A,B)) :-
    B \== verdad,
    escribe_lista([A,' :-']),
    escribe_cuerpo(B,1,_),
    read(Orden),
    interpreta_orden(Orden,B).

% escribe_lista(L) escribe cada uno de los elementos de la lista L.
escribe_lista([]) :- nl.
escribe_lista([X|L]) :-
   write(X),
   escribe_lista(L).

% escribe_cuerpo(B,N1,N2) es verdad si B es un cuerpo que se va a escribir,
% N1 es el número de átomos antes de la llamada a B y N2 es el número de
% átomos después de la llamada a B.
% escribe_cuerpo(verdad,N,N).
escribe_cuerpo((A & B),N1,N3) :-
   escribe_cuerpo(A,N1,N2),
   escribe_cuerpo(B,N2,N3).
escribe_cuerpo(si(H,_),N,N1) :-
   escribe_lista(['   ',N,': ',H]),
   N1 is N+1.

% interpreta_orden(Orden,B) interpreta la Orden sobre el cuerpo B. 
interpreta_orden(N,B) :-
   integer(N),
   nth(B,N,E),
   navega(E).

% nth(E,N,A) es verdad si A es el N-ésimo elemento de la estructura E.
nth(A,1,A) :-
   \+ (A = (_,_)).
nth((A&_),1,A).
nth((_&B),N,E) :-
   N>1,
   N1 is N-1,
   nth(B,N1,E).

% Sesión
% ======

% ?- [i_electrica].
% true.
% 
% ?- prueba_con_como(esta_encendida(L)).
% esta_encendida(l2) :-
%    1: luz(l2)
%    2: esta_bien(l2)
%    3: tiene_corriente(l2)
% |: 3.
% tiene_corriente(l2) :-
%    1: conectado(l2, c4)
%    2: tiene_corriente(c4)
% |: 2.
% tiene_corriente(c4) :-
%    1: conectado(c4, c3)
%    2: tiene_corriente(c3)
% |: 1.
% conectado(c4, c3) :-
%    1: arriba(i3)
% |: 1.
% arriba(i3) es un hecho
% 
% L = l2




