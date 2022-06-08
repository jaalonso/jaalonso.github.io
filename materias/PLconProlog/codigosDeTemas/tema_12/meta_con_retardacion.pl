% RA-99: meta_con_retardacion.pl
% Metaintérprete con retardación de objetivos.
% Ref.: Poole-98 p. 210.
%==============================================================================

% `<-' es el `si' del nivel objeto 
% (es un predicado infijo en el metanivel). 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% (es un símbolo de función infijo en el metanivel).
:- op(1000, xfy, &).

% prueba_r(O,R) 
%    se verifica si el objetivo O se puede demostrar a partir de la BC objeto y
%    los objetivos retardables en R.
prueba_r(O,R) :-
   prueba_r(O,[],R).

% prueba_r(O,R0,R1) 
%    se verifica si el objetivo O se puede demostrar a partir de la BC objeto y
%    los objetivos retardables en R1-R0, donde R0 es una cola de R1.
prueba_r(verdad,_R,_R).
prueba_r((A & B),R1,R3) :-
   prueba_r(A,R1,R2),
   prueba_r(B,R2,R3).
prueba_r(O,R,[O|R]) :-
   retardable(O).
prueba_r(O,R1,R2) :-
   (O <- C),
   prueba_r(C,R1,R2).


