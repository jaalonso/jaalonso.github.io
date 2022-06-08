% RA-99: meta_con_explicacion_porque_e.pl
% Ejemplo con el metaintérprete con explicaciones "porque"
%========================================================================== 

% `<-' es el `si' del nivel objeto 
% (es un predicado infijo en el metanivel). 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% (es un símbolo de función infijo en el metanivel).
:- op(1000, xfy, &).

a   <- a1 & a2 & a3.
a1  <- a11 & a12.
a11 <- verdad.
a12 <- verdad.
a3  <- a31 & a32.
a31 <- verdad.
a32 <- verdad.

preguntable(a2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sesión
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- [meta_con_explicacion_porque, meta_con_explicacion_porque_e].
% 
% ?- trace(prueba_con_porque_aux,[call,exit]).
%         prueba_con_porque_aux/2: call exit
% Yes
% 
% ?- prueba_con_porque(a).
% Call: 8) prueba_cpa(a, [])
% Call: 9) prueba_cpa((a1&a2&a3), [(a<-a1&a2&a3)])
% Call:10) prueba_cpa(a1, [(a<-a1&a2&a3)])
% Call:11) prueba_cpa((a11&a12), [(a1<-a11&a12), (a<-a1&a2&a3)])
% Call:12) prueba_cpa(a11, [(a1<-a11&a12), (a<-a1&a2&a3)])
% Call:13) prueba_cpa(verdad, [(a11<-verdad), (a1<-a11&a12), (a<-a1&a2&a3)])
% Exit:13) prueba_cpa(verdad, [(a11<-verdad), (a1<-a11&a12), (a<-a1&a2&a3)])
% Exit:12) prueba_cpa(a11, [(a1<-a11&a12), (a<-a1&a2&a3)])
% Call:12) prueba_cpa(a12, [(a1<-a11&a12), (a<-a1&a2&a3)])
% Call:13) prueba_cpa(verdad, [(a12<-verdad), (a1<-a11&a12), (a<-a1&a2&a3)])
% Exit:13) prueba_cpa(verdad, [(a12<-verdad), (a1<-a11&a12), (a<-a1&a2&a3)])
% Exit:12) prueba_cpa(a12, [(a1<-a11&a12), (a<-a1&a2&a3)])
% Exit:11) prueba_cpa((a11&a12), [(a1<-a11&a12), (a<-a1&a2&a3)])
% Exit:10) prueba_cpa(a1, [(a<-a1&a2&a3)])
% Call:10) prueba_cpa((a2&a3), [(a<-a1&a2&a3)])
% Call:11) prueba_cpa(a2, [(a<-a1&a2&a3)])
% ¿Es verdad a2? (si/no/porque)
% |: porque.
% Se usa en:
%    a <- 
%        a1 &
%        a2 &
%        a3.
% ¿Es verdad a2? (si/no/porque)
% |: porque.
% Porque esa fue su pregunta!
% ¿Es verdad a2? (si/no/porque)
% |: si.
% Exit:11) prueba_cpa(a2, [(a<-a1&a2&a3)])
% Call:11) prueba_cpa(a3, [(a<-a1&a2&a3)])
% Call:12) prueba_cpa((a31&a32), [(a3<-a31&a32), (a<-a1&a2&a3)])
% Call:13) prueba_cpa(a31, [(a3<-a31&a32), (a<-a1&a2&a3)])
% Call:14) prueba_cpa(verdad, [(a31<-verdad), (a3<-a31&a32), (a<-a1&a2&a3)])
% Exit:14) prueba_cpa(verdad, [(a31<-verdad), (a3<-a31&a32), (a<-a1&a2&a3)])
% Exit:13) prueba_cpa(a31, [(a3<-a31&a32), (a<-a1&a2&a3)])
% Call:13) prueba_cpa(a32, [(a3<-a31&a32), (a<-a1&a2&a3)])
% Call:14) prueba_cpa(verdad, [(a32<-verdad), (a3<-a31&a32), (a<-a1&a2&a3)])
% Exit:14) prueba_cpa(verdad, [(a32<-verdad), (a3<-a31&a32), (a<-a1&a2&a3)])
% Exit:13) prueba_cpa(a32, [(a3<-a31&a32), (a<-a1&a2&a3)])
% Exit:12) prueba_cpa((a31&a32), [(a3<-a31&a32), (a<-a1&a2&a3)])
% Exit:11) prueba_cpa(a3, [(a<-a1&a2&a3)])
% Exit:10) prueba_cpa((a2&a3), [(a<-a1&a2&a3)])
% Exit: 9) prueba_cpa((a1&a2&a3), [(a<-a1&a2&a3)])
% Exit: 8) prueba_cpa(a, [])
% 
% Yes

% Nota: Ver el árbol en Jul-99 p. 9.
