% meta_con_preguntas.pl
% Metaintérprete con preguntas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 8-junio-2022
% ======================================================================

% Operadores
% ==========

% `<-' es el `si' del nivel objeto 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
:- op(1000, xfy, &).

% Metaintérprete
% ==============

% prueba_p(+O) se verifica si el objetivo O se puede demostrar a partir
% de la BC objeto y las respuestas del usuario.
prueba_p(verdad).
prueba_p((A & B)) :-
   prueba_p(A),
   prueba_p(B).
prueba_p(G) :-
   preguntable(G),
   respuesta(G,si).
prueba_p(G) :-
   preguntable(G),
   no_preguntado(G),
   pregunta(G,Respuesta),
   assert(respuesta(G,Respuesta)),
   Respuesta=si.
prueba_p(A) :-
   (A <- B),
   prueba_p(B).

% respuesta(?O, ?Respuesta) se añade dinámicamente a la base de datos.
:- dynamic respuesta/2.

% no_preguntado(+O) es verdad si el objetivo O no se ha preguntado.
no_preguntado(O) :-
   \+ respuesta(O,_).   % negación como fallo.

% pregunta(+O, -Respuesta) pregunta O al usuario y éste responde la
% Respuesta.
pregunta(O,Respuesta) :-
   escribe_lista(['¿Es verdad ',O,'? (si/no)']),
   read(Respuesta).

% escribe_lista(+L) escribe cada uno de los elementos de la lista L.
escribe_lista([]) :- nl.
escribe_lista([X|L]) :-
   write(X),
   escribe_lista(L).

% Sesión
% ======

% ?- [i_electrica_con_preguntas, meta_con_preguntas].
% true.
% 
% ?- prueba_p(esta_encendida(L)).
% ¿Es verdad arriba(i2)? (si/no)
% |: si.
% ¿Es verdad arriba(i1)? (si/no)
% |: no.
% ¿Es verdad abajo(i2)? (si/no)
% |: no.
% ¿Es verdad arriba(i3)? (si/no)
% |: si.
% 
% L = l2 
% 
% ?- listing(respuesta).
% :- dynamic respuesta/2.
% 
% respuesta(arriba(i2), si).
% respuesta(arriba(i1), no).
% respuesta(abajo(i2), no).
% respuesta(arriba(i3), si).
% 
% true.
% 
% ?- retractall(respuesta(_,_)).
% true.
% 
% ?- prueba_p(esta_encendida(L)).
% ¿Es verdad arriba(i2)? (si/no)
% |: si.
% ¿Es verdad arriba(i1)? (si/no)
% |: si.
% 
% L = l1 
