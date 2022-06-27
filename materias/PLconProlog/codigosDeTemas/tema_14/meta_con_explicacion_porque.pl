% meta_con_explicacion_porque.pl
% Metaintérprete con explicaciones `por qué`.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla,  8-junio-2022
% ======================================================================

% `<-' es el `si' del nivel objeto 
% (es un predicado infijo en el metanivel). 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% (es un símbolo de función infijo en el metanivel).
:- op(1000, xfy, &).

% prueba_con_porque(O) significa probar el objetivo O, con las respuestas
% del usuario, permitiéndole preguntar PORQUE se le plantean preguntas.
prueba_con_porque(O) :-
   prueba_con_porque_aux(O,[]).

% prueba_con_porque_aux(O,Antecesores) si O es probable con la lista de
% Antecesores. 
% Pregunta al usuario y le permite preguntar "porque".
prueba_con_porque_aux(verdad,_).
prueba_con_porque_aux((A & B), Antecesores) :-
   prueba_con_porque_aux(A,Antecesores),
   prueba_con_porque_aux(B,Antecesores).
prueba_con_porque_aux(O,_) :-
   preguntable(O),
   respuesta(O,si).
prueba_con_porque_aux(O,Antecesores) :-
   preguntable(O),
   no_preguntado(O),
   pregunta(O,Respuesta,Antecesores),
   assert(respuesta(O,Respuesta)),
   Respuesta=si.
prueba_con_porque_aux(A,Antecesores) :-
   (A <- B),
   prueba_con_porque_aux(B,[(A <- B)|Antecesores]).

% respuesta(O,Respuesta) se añade dinámicamente a la base de datos.
:- dynamic respuesta/2.

% no_preguntado(O) es verdad si el objetivo G no se ha preguntado.
no_preguntado(G) :- \+ respuesta(G,_).   % negación como fallo.

% pregunta(O,Respuesta,Antecesores) pregunta al usuario, en el contexto
% dado por los Antecesores, la cuestión O y éste responde la Respuesta. 
pregunta(O,Respuesta,Antecesores) :-
   escribe_lista(['¿Es verdad ',O,'? (si/no/porque)']),
   read(Replica),
   interpreta(O,Respuesta,Replica,Antecesores).

% escribe_lista(L) escribe cada uno de los elementos de la lista L.
escribe_lista([]) :- nl.
escribe_lista([X|L]) :-
   write(X),
   escribe_lista(L).

% interpreta(O,Respuesta,Replica,Antecesores)
interpreta(_,Replica,Replica,_) :-
   Replica \== porque.
interpreta(O,Respuesta,porque,[Regla|Reglas]):-
   write('Se usa en:'), nl,
   escribe_regla(Regla),
   pregunta(O,Respuesta,Reglas).
interpreta(O,Respuesta,porque,[]):-
   write('Porque esa fue su pregunta!'), nl,
   pregunta(O,Respuesta,[]).

% escribe_regla(Regla).
escribe_regla((A <- B)) :-
   escribe_lista(['   ',A, ' <- ']),
   escribe_cuerpo(B).

% escribe_cuerpo(C).
escribe_cuerpo((A & B)) :-
   escribe_lista(['       ',A, ' &']),
   escribe_cuerpo(B).
escribe_cuerpo(A) :-
   \+ A = (_B & _C),
   escribe_lista(['       ',A,'.']).

% Sesión
% =====

% ?- [i_electrica_con_preguntas].
% true.
% 
% ?- prueba_con_porque(esta_encendida(L)).
% ¿Es verdad arriba(i2)? (si/no/porque)
% |: porque.
% Se usa en:
%    conectado(c0,c1) <- 
%        arriba(i2).
% ¿Es verdad arriba(i2)? (si/no/porque)
% |: porque.
% Se usa en:
%    tiene_corriente(c0) <- 
%        conectado(c0,c1) &
%        tiene_corriente(c1).
% ¿Es verdad arriba(i2)? (si/no/porque)
% |: porque.
% Se usa en:
%    tiene_corriente(l1) <- 
%        conectado(l1,c0) &
%        tiene_corriente(c0).
% ¿Es verdad arriba(i2)? (si/no/porque)
% |: porque.
% Se usa en:
%    esta_encendida(l1) <- 
%        luz(l1) &
%        esta_bien(l1) &
%        tiene_corriente(l1).
% ¿Es verdad arriba(i2)? (si/no/porque)
% |: porque.
% Porque esa fue su pregunta!
% ¿Es verdad arriba(i2)? (si/no/porque)
% |: si.
% ¿Es verdad arriba(i1)? (si/no/porque)
% |: porque.
% Se usa en:
%    conectado(c1,c3) <- 
%        arriba(i1).
% ¿Es verdad arriba(i1)? (si/no/porque)
% |: no.
% ¿Es verdad abajo(i2)? (si/no/porque)
% |: porque.
% Se usa en:
%    conectado(c0,c2) <- 
%        abajo(i2).
% ¿Es verdad abajo(i2)? (si/no/porque)
% |: si.
% ¿Es verdad abajo(i1)? (si/no/porque)
% |: si.
% 
% L = l1 
