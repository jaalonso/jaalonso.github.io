% RA-99: i_electrica_con_retardacion.pl
% Ejemplo con el metaintérprete con retardiación de objetivos.
% Ref.: Poole-98 p. 206.
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

:- style_check(-discontiguous).

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
%    esta_bien/1 es retardable.
retardable(esta_bien(_)).

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- [meta_con_retardacion, i_electrica_con_retardacion].
% Yes
% 
% ?- prueba_r(tiene_corriente(e1),R).
% R = [esta_bien(cc1)] ;
% No
% 
% ?- prueba_r(esta_encendida(l2),R).
% R = [esta_bien(cc1), esta_bien(l2)] ;
% No
% 
% ?- prueba_r((esta_encendida(l2)&tiene_corriente(e1)),R).
% R = [esta_bien(cc1), esta_bien(cc1), esta_bien(l2)] ;
% No
% 
% ?- trace.
% Yes

% ?- prueba_r(tiene_corriente(e1),[],D).
%    Call: ( 7) pr(tc(e1),[],_G371) ? 
%    Call: ( 8) retardable(tc(e1)) ? 
%    Fail: ( 8) retardable(tc(e1)) ? 
%    Redo: ( 7) pr(tc(e1),[],_G371) ? 
%    Call: ( 8) tc(e1)<-_L137 ? 
%    Exit: ( 8) tc(e1)<-con(e1,_G471)&tc(_G471) ? 
%    Call: ( 8) pr((con(e1,_G471)&tc(_G471)),[],_G371) ? 
%    Call: ( 9) pr(con(e1,_G471),[],_L165) ? 
%    Call: (10) retardable(con(e1,_G471)) ? 
%    Fail: (10) retardable(con(e1,_G471)) ? 
%    Redo: ( 9) pr(con(e1,_G471),[],_L165) ? 
%    Call: (10) con(e1,_G471)<-_L178 ? 
%    Exit: (10) con(e1,c3)<-verdad ? 
%    Call: (10) pr(verdad,[],_L165) ? 
%    Exit: (10) pr(verdad,[],[]) ? 
%    Exit: ( 9) pr(con(e1,c3),[],[]) ? 
%    Call: ( 9) pr(tc(c3),[],_G371) ? 
%    Call: (10) retardable(tc(c3)) ? 
%    Fail: (10) retardable(tc(c3)) ? 
%    Redo: ( 9) pr(tc(c3),[],_G371) ? 
%    Call: (10) tc(c3)<-_L214 ? 
%    Exit: (10) tc(c3)<-con(c3,_G479)&tc(_G479) ? 
%    Call: (10) pr((con(c3,_G479)&tc(_G479)),[],_G371) ? 
%    Call: (11) pr(con(c3,_G479),[],_L242) ? 
%    Call: (12) retardable(con(c3,_G479)) ? 
%    Fail: (12) retardable(con(c3,_G479)) ? 
%    Redo: (11) pr(con(c3,_G479),[],_L242) ? 
%    Call: (12) con(c3,_G479)<-_L255 ? 
%    Exit: (12) con(c3,c5)<-eb(cc1) ? 
%    Call: (12) pr(eb(cc1),[],_L242) ? 
%    Call: (13) retardable(eb(cc1)) ? 
%    Exit: (13) retardable(eb(cc1)) ? 
%    Exit: (12) pr(eb(cc1),[],[eb(cc1)]) ? 
%    Exit: (11) pr(con(c3,c5),[],[eb(cc1)]) ? 
%    Call: (11) pr(tc(c5),[eb(cc1)],_G371) ? 
%    Call: (12) retardable(tc(c5)) ? 
%    Fail: (12) retardable(tc(c5)) ? 
%    Redo: (11) pr(tc(c5),[eb(cc1)],_G371) ? 
%    Call: (12) tc(c5)<-_L291 ? 
%    Exit: (12) tc(c5)<-con(c5,_G492)&tc(_G492) ? 
%    Call: (12) pr((con(c5,_G492)&tc(_G492)),[eb(cc1)],_G371) ? 
%    Call: (13) pr(con(c5,_G492),[eb(cc1)],_L319) ? 
%    Call: (14) retardable(con(c5,_G492)) ? 
%    Fail: (14) retardable(con(c5,_G492)) ? 
%    Redo: (13) pr(con(c5,_G492),[eb(cc1)],_L319) ? 
%    Call: (14) con(c5,_G492)<-_L332 ? 
%    Exit: (14) con(c5,entrada)<-verdad ? 
%    Call: (14) pr(verdad,[eb(cc1)],_L319) ? 
%    Exit: (14) pr(verdad,[eb(cc1)],[eb(cc1)]) ? 
%    Exit: (13) pr(con(c5,entrada),[eb(cc1)],[eb(cc1)]) ? 
%    Call: (13) pr(tc(entrada),[eb(cc1)],_G371) ? 
%    Call: (14) retardable(tc(entrada)) ? 
%    Fail: (14) retardable(tc(entrada)) ? 
%    Redo: (13) pr(tc(entrada),[eb(cc1)],_G371) ? 
%    Call: (14) tc(entrada)<-_L357 ? 
%    Exit: (14) tc(entrada)<-con(entrada,_G500)&tc(_G500) ? 
%    Call: (14) pr((con(entrada,_G500)&tc(_G500)),[eb(cc1)],_G371) ? 
%    Call: (15) pr(con(entrada,_G500),[eb(cc1)],_L385) ? 
%    Call: (16) retardable(con(entrada,_G500)) ? 
%    Fail: (16) retardable(con(entrada,_G500)) ? 
%    Redo: (15) pr(con(entrada,_G500),[eb(cc1)],_L385) ? 
%    Call: (16) con(entrada,_G500)<-_L398 ? 
%    Fail: (16) con(entrada,_G500)<-_L398 ? 
%    Fail: (15) pr(con(entrada,_G500),[eb(cc1)],_L385) ? 
%    Redo: (14) pr((con(entrada,_G500)&tc(_G500)),[eb(cc1)],_G371) ? 
%    Call: (15) retardable((con(entrada,_G500)&tc(_G500))) ? 
%    Fail: (15) retardable((con(entrada,_G500)&tc(_G500))) ? 
%    Redo: (14) pr((con(entrada,_G500)&tc(_G500)),[eb(cc1)],_G371) ? 
%    Call: (15) con(entrada,_G500)&tc(_G500)<-_L383 ? 
%    Fail: (15) con(entrada,_G500)&tc(_G500)<-_L383 ? 
%    Fail: (14) pr((con(entrada,_G500)&tc(_G500)),[eb(cc1)],_G371) ? 
%    Redo: (14) tc(entrada)<-_L357 ? 
%    Exit: (14) tc(entrada)<-verdad ? 
%    Call: (14) pr(verdad,[eb(cc1)],_G371) ? 
%    Exit: (14) pr(verdad,[eb(cc1)],[eb(cc1)]) ? 
%    Exit: (13) pr(tc(entrada),[eb(cc1)],[eb(cc1)]) ? 
%    Exit: (12) pr((con(c5,entrada)&tc(entrada)),[eb(cc1)],[eb(cc1)]) ? 
%    Exit: (11) pr(tc(c5),[eb(cc1)],[eb(cc1)]) ? 
%    Exit: (10) pr((con(c3,c5)&tc(c5)),[],[eb(cc1)]) ? 
%    Exit: ( 9) pr(tc(c3),[],[eb(cc1)]) ? 
%    Exit: ( 8) pr((con(e1,c3)&tc(c3)),[],[eb(cc1)]) ? 
%    Exit: ( 7) pr(tc(e1),[],[eb(cc1)]) ? 
% D = [eb(cc1)] 
% Yes
