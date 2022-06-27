% instalacion-electrica.pl
% Axiomatización de la instalación eléctrica.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 22-junio-2022
% ======================================================================


% luz(L) se verifica si L es una luz.
luz(l1).
luz(l2).

% abajo(I) se verifica si el interruptor I está hacia abajo
abajo(i1).

% arriba(I) se verifica si el interruptor I está hacia arriba
arriba(i2).
arriba(i3).

% esta_bien(X) se verifica si la luz X está bien.
esta_bien(l1).
esta_bien(l2).

% esta_bien(X) se verifica si el cortacircuito X está bien.
esta_bien(cc1).
esta_bien(cc2).

% conectado(D1,D2) se verifica si los dispositivos D1 y D2 está
% conectados (de forma que puede fluir la corriente eléctrica de D2 a
% D1).  
conectado(l1,c0).
conectado(c0,c1) :- arriba(i2).
conectado(c0,c2) :- abajo(i2).
conectado(c1,c3) :- arriba(i1).
conectado(c2,c3) :- abajo(i1).
conectado(l2,c4).
conectado(c4,c3) :- arriba(i3).
conectado(e1,c3).
conectado(c3,c5) :- esta_bien(cc1).
conectado(e2,c6).
conectado(c6,c5) :- esta_bien(cc2).
conectado(c5,entrada).

% tiene_corriente(D) se verifica si el dispositivo D tiene corriente.
tiene_corriente(D) :-
   conectado(D,D1),
   tiene_corriente(D1).
tiene_corriente(entrada).

% esta_encendida(L) se verifica si la luz L está encendida.
esta_encendida(L) :-
    luz(L),
    esta_bien(L),
    tiene_corriente(L).

% Sesión
% ======

% ?- luz(l1).
% true.
% 
% ?- luz(l6).
% false.
% 
% ?- arriba(X).
% X = i2 ;
% X = i3.
% 
% ?- conectado(l1,D).
% D = c0.
% 
% ?- conectado(c0,D).
% D = c1 ;
% false.
% 
% ?- conectado(c1,D).
% false.
% 
% ?- conectado(D,c3).
% D = c2 ;
% D = c4 ;
% D = e1.
% 
% ?- conectado(X,Y).
% X = l1,
% Y = c0 ;
% X = c0,
% Y = c1 ;
% X = c2,
% Y = c3 ;
% X = l2,
% Y = c4 ;
% X = c4,
% Y = c3 ;
% X = e1,
% Y = c3 ;
% X = c3,
% Y = c5 ;
% X = e2,
% Y = c6 ;
% X = c6,
% Y = c5 ;
% X = c5,
% Y = entrada.
% 
% ?- tiene_corriente(D).
% D = c2 ;
% D = l2 ;
% D = c4 ;
% D = e1 ;
% D = c3 ;
% D = e2 ;
% D = c6 ;
% D = c5 ;
% D = entrada.
% 
% ?- esta_encendida(X).
% X = l2.
