% RA-99: i_electrica_con_error_1.pl
% Ejemplo de depuración de respuestas incorrectas
% Ref.: Poole-98 p. 223
%========================================================================== 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Operadores                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% `<-' es el `si' del nivel objeto 
% (es un predicado infijo en el metanivel). 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% (es un símbolo de función infijo en el metanivel).
:- op(1000, xfy, &).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Programa objeto                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% luz(?L) 
%    se verifica si L es una luz.
luz(l1) <- verdad.
luz(l2) <- verdad.

% abajo(?I) 
%    se verifica si el interruptor I está hacia abajo
abajo(i1) <- verdad.

% arriba(?I) 
%    se verifica si el interruptor I está hacia arriba
arriba(i2) <- verdad.
arriba(i3) <- verdad.

% esta_bien(X) 
%    se verifica si la luz (o cortacircuito) X está bien.
esta_bien(l1) <- verdad.
esta_bien(l2) <- verdad.
esta_bien(cc1) <- verdad.
esta_bien(cc2) <- verdad.

% conectado(?D1,?D2) 
%	  se verifica si los dispositivos D1 y D2 está conectados (de forma que
%    puede fluir la corriente eléctrica de D2 a D1). 
conectado(l1,c0) <- verdad.
conectado(c0,c1) <- arriba(i2).
conectado(c0,c2) <- abajo(i2).
conectado(c1,c3) <- arriba(i3).   % cláusula errónea
% conectado(c1,c3) <- arriba(i1).
conectado(c2,c3) <- abajo(i1).
conectado(l2,c4) <- verdad.
conectado(c4,c3) <- arriba(i3).
conectado(e1,c3) <- verdad.
conectado(c3,c5) <- esta_bien(cc1).
conectado(e2,c6) <- verdad.
conectado(c6,c5) <- esta_bien(cc2).
conectado(c5,entrada) <- verdad.

% tiene_corriente(?D) 
%    se verifica si el dispositivo D tiene corriente
tiene_corriente(D) <-
   conectado(D,D1) &
   tiene_corriente(D1).
tiene_corriente(entrada) <- verdad.

% esta_encendida(?L) 
%    se verifica si la luz L está encendida
esta_encendida(L) <-
    luz(L) &
    esta_bien(L) &
    tiene_corriente(L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sesión (Ejemplo 6.14 p. 223)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- [i_electrica_con_error_1, meta_con_explicacion_como].
% Yes
% 
% ?- prueba_con_como(esta_encendida(L)).
% esta_encendida(l1) :-
%    1: luz(l1)
%    2: esta_bien(l1)
%    3: tiene_corriente(l1)
% |: 3.
% tiene_corriente(l1) :-
%    1: conectado(l1, c0)
%    2: tiene_corriente(c0)
% |: 2.
% tiene_corriente(c0) :-
%    1: conectado(c0, c1)
%    2: tiene_corriente(c1)
% |: 2.
% tiene_corriente(c1) :-
%    1: conectado(c1, c3)
%    2: tiene_corriente(c3)
% |: 1.
% conectado(c1, c3) :-
%    1: arriba(i3)
% |: 


