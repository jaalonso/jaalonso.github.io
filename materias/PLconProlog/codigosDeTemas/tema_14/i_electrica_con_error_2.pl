% Poole-98: inst-electrica-con-error-2.pl
% Ejemplo de depuración de respuestas ausentes.
% Ref.: Poole-98 p. 223
%========================================================================== 

% `<-' es el `si' del nivel objeto 
% (es un predicado infijo en el metanivel). 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% (es un símbolo de función infijo en el metanivel).
:- op(1000, xfy, &).

% esta_encendida(L) es verdad si la luz L está encendida.
esta_encendida(L) <-
    luz(L) &
    esta_bien(L) &
    tiene_corriente(L).

% tiene_corriente(D) es verdad si el dispositivo D tiene corriente.
tiene_corriente(D) <-
    conectado(D,D1) &
    tiene_corriente(D1).
tiene_corriente(entrada) <- verdad.

% conectado(D1,D2) es verdad si los dispositivos D1 y D2 está conectados
% (de forma que puede fluir la corriente eléctrica de D2 a D1). 
conectado(l1,c0) <- verdad.
conectado(c0,c1) <- arriba(i2).
conectado(c0,c2) <- abajo(i2) .
conectado(c1,c3) <- arriba(i1).
conectado(c2,c3) <- abajo(i1) .
conectado(l2,c4) <- verdad.   
conectado(c4,c3) <- arriba(i3).
conectado(e1,c3) <- verdad.
conectado(c3,c5) <- esta_bien(cc1).
conectado(e2,c6) <- verdad.
conectado(c6,c5) <- esta_bien(cc2).
conectado(c5,entrada) <- verdad.

% luz(L) es verdad si L es una luz.
luz(l1) <- verdad.
luz(l2) <- verdad.

% arriba(I) es verdad si el interruptor I está hacia arriba
% arriba(i2) <- verdad.   % cláusula ausente
arriba(i3) <- verdad.

% abajo(I) es verdad si el interruptor I está hacia abajo
abajo(i1) <- verdad.

% esta_bien(X) es verdad si la luz X está bien.
esta_bien(l1) <- verdad.
esta_bien(l2) <- verdad.

% esta_bien(X) es verdad si el cortacircuito X está bien.
esta_bien(cc1) <- verdad.
esta_bien(cc2) <- verdad.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sesión (Ejemplo 6.15 p. 225)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- ['i-electrica-con-error-2.pl'].
% i-electrica-con-error.pl compiled, 0.03 sec, 3,004 bytes.
% Yes
% 
% ?- ['meta-con-explicacion-2.pl'].
% meta-con-explicacion-2.pl compiled, 0.03 sec, 3,404 bytes.
% Yes
% 
% ?- prueba_con_como(esta_encendida(l1)).
% No
%
% ?- clause((esta_encendida(l1) <- B),_).
% B = luz(l1) & esta_bien(l1) & tiene_corriente(l1) ;
% No
% 
% ?- clause((tiene_corriente(l1) <- B),_).
% B = conectado(l1, _G375) & tiene_corriente(_G375) ;
% No
% 
% ?- clause((conectado(l1,C) <- B),_).
% C = c0
% B = verdad ;
% No
% 
% ?- clause((tiene_corriente(c0) <- B),_).
% B = conectado(c0, _G375) & tiene_corriente(_G375) ;
% No
% 
% ?- clause((conectado(c0,X) <- B),_).
% X = c1
% B = arriba(i2) ;
% X = c2
% B = abajo(i2) ;
% No


