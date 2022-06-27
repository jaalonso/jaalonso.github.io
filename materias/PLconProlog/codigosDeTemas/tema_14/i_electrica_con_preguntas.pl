% i_electrica_con_preguntas.pl
% Ejemplo para el metaintérprete con preguntas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 8-junio-2022
% ======================================================================

% Operadores
% ==========

% `<-' es el `si' del nivel objeto 
% (es un predicado infijo en el metanivel). 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% (es un símbolo de función infijo en el metanivel).
:- op(1000, xfy, &).

% Base de conocimiento
% ====================

% luz(?L) se verifica si L es una luz.
luz(l1) <- verdad.
luz(l2) <- verdad.

% esta_bien(X) se verifica si la luz (o cortacircuito) X está bien.
esta_bien(l1) <- verdad.
esta_bien(l2) <- verdad.
esta_bien(cc1) <- verdad.
esta_bien(cc2) <- verdad.

% conectado(?D1,?D2) se verifica si los dispositivos D1 y D2 está
% conectados (de forma que puede fluir la corriente eléctrica de D2 a
% D1).
conectado(l1,c0) <- verdad.
conectado(c0,c1) <- arriba(i2).
conectado(c0,c2) <- abajo(i2).
conectado(c1,c3) <- arriba(i1).
conectado(c2,c3) <- abajo(i1).
conectado(l2,c4) <- verdad.
conectado(c4,c3) <- arriba(i3).
conectado(e1,c3) <- verdad.
conectado(c3,c5) <- esta_bien(cc1).
conectado(e2,c6) <- verdad.
conectado(c6,c5) <- esta_bien(cc2).
conectado(c5,entrada) <- verdad.

% tiene_corriente(?D) se verifica si el dispositivo D tiene corriente
tiene_corriente(D) <-
   conectado(D,D1) &
   tiene_corriente(D1).
tiene_corriente(entrada) <- verdad.

% esta_encendida(?L) se verifica si la luz L está encendida
esta_encendida(L) <-
    luz(L) &
    esta_bien(L) &
    tiene_corriente(L).

% arriba(I) es verdad si el interruptor I está hacia arriba
% abajo(I) es verdad si el interruptor I está hacia abajo
% Estos predicados son preguntables.
preguntable(arriba(_)).
preguntable(abajo(_)).

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

% Sesión (con explicaciones PORQUE)
% =================================

% ?- [meta_con_explicacion_porque, i_electrica_con_preguntas].
% Yes
% 
% ?- prueba_con_porque(esta_encendida(L)).
% ¿Es verdad arriba(i2)? (si/no/porque)
% |: porque.
% Se usa en:
%    conectado(c0, c1) <- 
%        arriba(i2).
% ¿Es verdad arriba(i2)? (si/no/porque)
% |: porque.
% Se usa en:
%    tiene_corriente(c0) <- 
%        conectado(c0, c1) &
%        tiene_corriente(c1).
% ¿Es verdad arriba(i2)? (si/no/porque)
% |: porque.
% Se usa en:
%    tiene_corriente(l1) <- 
%        conectado(l1, c0) &
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
%    conectado(c1, c3) <- 
%        arriba(i1).
% ¿Es verdad arriba(i1)? (si/no/porque)
% |: no.
% ¿Es verdad abajo(i2)? (si/no/porque)
% |: no.
% ¿Es verdad arriba(i3)? (si/no/porque)
% |: porque.
% Se usa en:
%    conectado(c4, c3) <- 
%        arriba(i3).
% ¿Es verdad arriba(i3)? (si/no/porque)
% |: si.
% 
% L = l2 ;
% 
% No

