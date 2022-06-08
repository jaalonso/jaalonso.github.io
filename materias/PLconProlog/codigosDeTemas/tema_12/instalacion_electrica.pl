% RA-99: instalacion-electrica.pl
% Axiomatización de la instalación eléctrica de la Figura 3.1 (p. 71).
% Ref.: Poole-98 p.71
%==============================================================================

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
conectado(c1,c3) <- arriba(i1).
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
%% Sesión                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- prueba(luz(l1)).
% Yes
%
% ?- prueba(luz(l6)).
% No
%
% ?- prueba(arriba(X)).
% X = i2 ;
% X = i3 ;
% No
%
% ?- prueba(conectado(l1,D)).
% D = c0 ;
% No
%
% ?- prueba(conectado(c0,D)).
% D = c1 ;
% No
%
% ?- prueba(conectado(c1,D)).
% No
%
% ?- prueba(conectado(D,c3)).
% D = c2 ;
% D = c4 ;
% D = e1 ;
% No
%
% ?- prueba(conectado(X,Y)).
% X = l1 Y = c0 ;
% X = c0 Y = c1 ;
% X = c2 Y = c3 ;
% X = l2 Y = c4 ;
% X = c4 Y = c3 ;
% X = e1 Y = c3 ;
% X = c3 Y = c5 ;
% X = e2 Y = c6 ;
% X = c6 Y = c5 ;
% X = c5 Y = entrada ;
% No 
% 
% ?- prueba(tiene_corriente(D)).
% D = c2 ;
% D = l2 ;
% D = c4 ;
% D = e1 ;
% D = c3 ;
% D = e2 ;
% D = c6 ;
% D = c5 ;
% D = entrada ;
% No
% 
% ?- prueba(esta_encendida(X)).
% X = l2 ;
% No
% 
% ?- trace(prueba).
%         prueba/1: call redo exit fail
% Yes
% 
% ?- prueba(esta_encendida(X)).
% T Call:  (  7) prueba(esta_encendida(_G229))
% T Call:  (  8) prueba( (luz(_G229)&esta_bien(_G229)&tiene_corriente(_G229)))
% T Call:  (  9) prueba(luz(_G229))
% T Call:  ( 10) prueba(verdad)
% T Exit:  ( 10) prueba(verdad)
% T Exit:  (  9) prueba(luz(l1))
% T Call:  (  9) prueba( (esta_bien(l1)&tiene_corriente(l1)))
% T Call:  ( 10) prueba(esta_bien(l1))
% T Call:  ( 11) prueba(verdad)
% T Exit:  ( 11) prueba(verdad)
% T Exit:  ( 10) prueba(esta_bien(l1))
% T Call:  ( 10) prueba(tiene_corriente(l1))
% T Call:  ( 11) prueba( (conectado(l1, _G335)&tiene_corriente(_G335)))
% T Call:  ( 12) prueba(conectado(l1, _G335))
% T Call:  ( 13) prueba(verdad)
% T Exit:  ( 13) prueba(verdad)
% T Exit:  ( 12) prueba(conectado(l1, c0))
% T Call:  ( 12) prueba(tiene_corriente(c0))
% T Call:  ( 13) prueba( (conectado(c0, _G343)&tiene_corriente(_G343)))
% T Call:  ( 14) prueba(conectado(c0, _G343))
% T Call:  ( 15) prueba(arriba(i2))
% T Call:  ( 16) prueba(verdad)
% T Exit:  ( 16) prueba(verdad)
% T Exit:  ( 15) prueba(arriba(i2))
% T Exit:  ( 14) prueba(conectado(c0, c1))
% T Call:  ( 14) prueba(tiene_corriente(c1))
% T Call:  ( 15) prueba( (conectado(c1, _G353)&tiene_corriente(_G353)))
% T Call:  ( 16) prueba(conectado(c1, _G353))
% T Call:  ( 17) prueba(arriba(i1))
% T Fail:  ( 17) prueba(arriba(i1))
% T Fail:  ( 16) prueba(conectado(c1, _G353))
% T Redo:  ( 15) prueba( (conectado(c1, _G353)&tiene_corriente(_G353)))
% T Fail:  ( 15) prueba( (conectado(c1, _G353)&tiene_corriente(_G353)))
% T Fail:  ( 14) prueba(tiene_corriente(c1))
% T Redo:  ( 16) prueba(verdad)
% T Fail:  ( 16) prueba(verdad)
% T Fail:  ( 15) prueba(arriba(i2))
% T Call:  ( 15) prueba(abajo(i2))
% T Fail:  ( 15) prueba(abajo(i2))
% T Fail:  ( 14) prueba(conectado(c0, _G343))
% T Redo:  ( 13) prueba( (conectado(c0, _G343)&tiene_corriente(_G343)))
% T Fail:  ( 13) prueba( (conectado(c0, _G343)&tiene_corriente(_G343)))
% T Fail:  ( 12) prueba(tiene_corriente(c0))
% T Redo:  ( 13) prueba(verdad)
% T Fail:  ( 13) prueba(verdad)
% T Fail:  ( 12) prueba(conectado(l1, _G335))
% T Redo:  ( 11) prueba( (conectado(l1, _G335)&tiene_corriente(_G335)))
% T Fail:  ( 11) prueba( (conectado(l1, _G335)&tiene_corriente(_G335)))
% T Fail:  ( 10) prueba(tiene_corriente(l1))
% T Redo:  ( 11) prueba(verdad)
% T Fail:  ( 11) prueba(verdad)
% T Fail:  ( 10) prueba(esta_bien(l1))
% T Redo:  (  9) prueba( (esta_bien(l1)&tiene_corriente(l1)))
% T Fail:  (  9) prueba( (esta_bien(l1)&tiene_corriente(l1)))
% T Redo:  ( 10) prueba(verdad)
% T Fail:  ( 10) prueba(verdad)
% T Call:  ( 10) prueba(verdad)
% T Exit:  ( 10) prueba(verdad)
% T Exit:  (  9) prueba(luz(l2))
% T Call:  (  9) prueba( (esta_bien(l2)&tiene_corriente(l2)))
% T Call:  ( 10) prueba(esta_bien(l2))
% T Call:  ( 11) prueba(verdad)
% T Exit:  ( 11) prueba(verdad)
% T Exit:  ( 10) prueba(esta_bien(l2))
% T Call:  ( 10) prueba(tiene_corriente(l2))
% T Call:  ( 11) prueba( (conectado(l2, _G335)&tiene_corriente(_G335)))
% T Call:  ( 12) prueba(conectado(l2, _G335))
% T Call:  ( 13) prueba(verdad)
% T Exit:  ( 13) prueba(verdad)
% T Exit:  ( 12) prueba(conectado(l2, c4))
% T Call:  ( 12) prueba(tiene_corriente(c4))
% T Call:  ( 13) prueba( (conectado(c4, _G343)&tiene_corriente(_G343)))
% T Call:  ( 14) prueba(conectado(c4, _G343))
% T Call:  ( 15) prueba(arriba(i3))
% T Call:  ( 16) prueba(verdad)
% T Exit:  ( 16) prueba(verdad)
% T Exit:  ( 15) prueba(arriba(i3))
% T Exit:  ( 14) prueba(conectado(c4, c3))
% T Call:  ( 14) prueba(tiene_corriente(c3))
% T Call:  ( 15) prueba( (conectado(c3, _G353)&tiene_corriente(_G353)))
% T Call:  ( 16) prueba(conectado(c3, _G353))
% T Call:  ( 17) prueba(esta_bien(cc1))
% T Call:  ( 18) prueba(verdad)
% T Exit:  ( 18) prueba(verdad)
% T Exit:  ( 17) prueba(esta_bien(cc1))
% T Exit:  ( 16) prueba(conectado(c3, c5))
% T Call:  ( 16) prueba(tiene_corriente(c5))
% T Call:  ( 17) prueba( (conectado(c5, _G363)&tiene_corriente(_G363)))
% T Call:  ( 18) prueba(conectado(c5, _G363))
% T Call:  ( 19) prueba(verdad)
% T Exit:  ( 19) prueba(verdad)
% T Exit:  ( 18) prueba(conectado(c5, entrada))
% T Call:  ( 18) prueba(tiene_corriente(entrada))
% T Call:  ( 19) prueba( (conectado(entrada, _G371)&tiene_corriente(_G371)))
% T Call:  ( 20) prueba(conectado(entrada, _G371))
% T Fail:  ( 20) prueba(conectado(entrada, _G371))
% T Redo:  ( 19) prueba( (conectado(entrada, _G371)&tiene_corriente(_G371)))
% T Fail:  ( 19) prueba( (conectado(entrada, _G371)&tiene_corriente(_G371)))
% T Call:  ( 19) prueba(verdad)
% T Exit:  ( 19) prueba(verdad)
% T Exit:  ( 18) prueba(tiene_corriente(entrada))
% T Exit:  ( 17) prueba( (conectado(c5, entrada)&tiene_corriente(entrada)))
% T Exit:  ( 16) prueba(tiene_corriente(c5))
% T Exit:  ( 15) prueba( (conectado(c3, c5)&tiene_corriente(c5)))
% T Exit:  ( 14) prueba(tiene_corriente(c3))
% T Exit:  ( 13) prueba( (conectado(c4, c3)&tiene_corriente(c3)))
% T Exit:  ( 12) prueba(tiene_corriente(c4))
% T Exit:  ( 11) prueba( (conectado(l2, c4)&tiene_corriente(c4)))
% T Exit:  ( 10) prueba(tiene_corriente(l2))
% T Exit:  (  9) prueba( (esta_bien(l2)&tiene_corriente(l2)))
% T Exit:  (  8) prueba( (luz(l2)&esta_bien(l2)&tiene_corriente(l2)))
% T Exit:  (  7) prueba(esta_encendida(l2))
% 
% X = l2 ;
% T Redo:  ( 19) prueba(verdad)
% T Fail:  ( 19) prueba(verdad)
% T Fail:  ( 18) prueba(tiene_corriente(entrada))
% T Redo:  ( 19) prueba(verdad)
% T Fail:  ( 19) prueba(verdad)
% T Fail:  ( 18) prueba(conectado(c5, _G363))
% T Redo:  ( 17) prueba( (conectado(c5, _G363)&tiene_corriente(_G363)))
% T Fail:  ( 17) prueba( (conectado(c5, _G363)&tiene_corriente(_G363)))
% T Fail:  ( 16) prueba(tiene_corriente(c5))
% T Redo:  ( 18) prueba(verdad)
% T Fail:  ( 18) prueba(verdad)
% T Fail:  ( 17) prueba(esta_bien(cc1))
% T Fail:  ( 16) prueba(conectado(c3, _G353))
% T Redo:  ( 15) prueba( (conectado(c3, _G353)&tiene_corriente(_G353)))
% T Fail:  ( 15) prueba( (conectado(c3, _G353)&tiene_corriente(_G353)))
% T Fail:  ( 14) prueba(tiene_corriente(c3))
% T Redo:  ( 16) prueba(verdad)
% T Fail:  ( 16) prueba(verdad)
% T Fail:  ( 15) prueba(arriba(i3))
% T Fail:  ( 14) prueba(conectado(c4, _G343))
% T Redo:  ( 13) prueba( (conectado(c4, _G343)&tiene_corriente(_G343)))
% T Fail:  ( 13) prueba( (conectado(c4, _G343)&tiene_corriente(_G343)))
% T Fail:  ( 12) prueba(tiene_corriente(c4))
% T Redo:  ( 13) prueba(verdad)
% T Fail:  ( 13) prueba(verdad)
% T Fail:  ( 12) prueba(conectado(l2, _G335))
% T Redo:  ( 11) prueba( (conectado(l2, _G335)&tiene_corriente(_G335)))
% T Fail:  ( 11) prueba( (conectado(l2, _G335)&tiene_corriente(_G335)))
% T Fail:  ( 10) prueba(tiene_corriente(l2))
% T Redo:  ( 11) prueba(verdad)
% T Fail:  ( 11) prueba(verdad)
% T Fail:  ( 10) prueba(esta_bien(l2))
% T Redo:  (  9) prueba( (esta_bien(l2)&tiene_corriente(l2)))
% T Fail:  (  9) prueba( (esta_bien(l2)&tiene_corriente(l2)))
% T Redo:  ( 10) prueba(verdad)
% T Fail:  ( 10) prueba(verdad)
% T Fail:  (  9) prueba(luz(_G229))
% T Redo:  (  8) prueba( (luz(_G229)&esta_bien(_G229)&tiene_corriente(_G229)))
% T Fail:  (  8) prueba( (luz(_G229)&esta_bien(_G229)&tiene_corriente(_G229)))
% T Fail:  (  7) prueba(esta_encendida(_G229))
% 
% No

% ?- trace([prueba,<-]).
%         prueba/1: call redo exit fail
%         <-/2: call redo exit fail
% 
% Yes
% ?- prueba(tiene_corriente(c5)).
% T Call:  (  7) prueba(tiene_corriente(c5))
% T Call:  (  8) tiene_corriente(c5)<-_L134
% T Exit:  (  8) tiene_corriente(c5)<-conectado(c5, _G317)&tiene_corriente(_G317)
% T Call:  (  8) prueba( (conectado(c5, _G317)&tiene_corriente(_G317)))
% T Call:  (  9) prueba(conectado(c5, _G317))
% T Call:  ( 10) conectado(c5, _G317)<-_L170
% T Exit:  ( 10) conectado(c5, entrada)<-verdad
% T Call:  ( 10) prueba(verdad)
% T Exit:  ( 10) prueba(verdad)
% T Exit:  (  9) prueba(conectado(c5, entrada))
% T Call:  (  9) prueba(tiene_corriente(entrada))
% T Call:  ( 10) tiene_corriente(entrada)<-_L191
% T Exit:  ( 10) tiene_corriente(entrada)<-conectado(entrada, _G325)&tiene_corriente(_G325)
% T Call:  ( 10) prueba( (conectado(entrada, _G325)&tiene_corriente(_G325)))
% T Call:  ( 11) prueba(conectado(entrada, _G325))
% T Call:  ( 12) conectado(entrada, _G325)<-_L227
% T Fail:  ( 12) conectado(entrada, _G325)<-_L227
% T Fail:  ( 11) prueba(conectado(entrada, _G325))
% T Redo:  ( 10) prueba( (conectado(entrada, _G325)&tiene_corriente(_G325)))
% T Call:  ( 11) conectado(entrada, _G325)&tiene_corriente(_G325)<-_L215
% T Fail:  ( 11) conectado(entrada, _G325)&tiene_corriente(_G325)<-_L215
% T Fail:  ( 10) prueba( (conectado(entrada, _G325)&tiene_corriente(_G325)))
% T Redo:  ( 10) tiene_corriente(entrada)<-_L191
% T Exit:  ( 10) tiene_corriente(entrada)<-verdad
% T Call:  ( 10) prueba(verdad)
% T Exit:  ( 10) prueba(verdad)
% T Exit:  (  9) prueba(tiene_corriente(entrada))
% T Exit:  (  8) prueba( (conectado(c5, entrada)&tiene_corriente(entrada)))
% T Exit:  (  7) prueba(tiene_corriente(c5))
% 
% Yes
