% meta_con_explicacion_arbol.pl
% Metaintérprete con explicaciones: con árbol de prueba.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 8-junio-2022
% ======================================================================

% `<-' es el `si' del nivel objeto 
% (es un predicado infijo en el metanivel). 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% (es un símbolo de función infijo en el metanivel).
:- op(1000, xfy, &).

% prueba_con_demostracion(G,T) es verdad si T es un árbol de prueba del
% objetivo G.
prueba_con_demostracion(verdad,verdad).
prueba_con_demostracion((A & B),(TA & TB)) :-
   prueba_con_demostracion(A,TA),
   prueba_con_demostracion(B,TB).
prueba_con_demostracion(H,si(H,TB)) :-
   (H <- B),
   prueba_con_demostracion(B,TB).

% Sesión
% ======

% ?- [i_electrica].
% true.
%
% ?- prueba_con_demostracion(esta_encendida(L),T).
% L = l2
% T = si(esta_encendida(l2),
%         (si(luz(l2), verdad) &
%          si(esta_bien(l2), verdad) &
%          si(tiene_corriente(l2),
%              (si(conectado(l2, c4), verdad) &
%               si(tiene_corriente(c4),
%                   (si(conectado(c4, c3),
%                        si(arriba(i3), verdad)) & 
%                    si(tiene_corriente(c3),
%                        (si(conectado(c3, c5),
%                             si(esta_bien(cc1), verdad)) &
%                         si(tiene_corriente(c5),
%                             (si(conectado(c5, entrada), verdad) &
%                             si(tiene_corriente(entrada), verdad))))))))))) ;
% 
% false.

