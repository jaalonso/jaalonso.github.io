% meta_pa.pl
% Metaintérprete con profundidad acotada.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 8-junio-2022
% ======================================================================

% Operadores
% ==========

% `<-' es el `si' del nivel objeto 
:- op(1200, xfx, <-).

% `&' es la conjunción en el nivel objeto 
:- op(1000, xfy, &).

% Metaintérprete
% ==============

% prueba_pa(+O,+N) es verdad si el objetivo O se puede demostrar con
% profundidad N como máximo.
prueba_pa(verdad,_N).
prueba_pa((A & B),N) :-
   prueba_pa(A,N),
   prueba_pa(B,N).
prueba_pa(A,N) :-
   N >= 0,
   N1 is N-1,
   (A <- B),
   prueba_pa(B,N1).

% Sesión
% ======

% ?- [hermano].
% true.
% 
% ?- prueba_pa(hermano(a,X),1).
% X = b ;
% false.
% 
% ?- prueba_pa(hermano(X,Y),1).
% X = a,
% Y = b ;
% X = b,
% Y = a ;
% false.
% 
% ?- prueba_pa(hermano(a,X),2).
% X = b ;
% false.
% 
% ?- prueba_pa(hermano(a,X),3).
% X = b ;
% X = b ;
% false.
% 
% ?- trace(prueba_pa).
% true.
% 
% ?- prueba_pa(hermano(a,X),3).
%  T Call: prueba_pa(hermano(a,_82),3)
%  T Call: prueba_pa(hermano(_82,a),2)
%  T Call: prueba_pa(hermano(a,_82),1)
%  T Call: prueba_pa(hermano(_82,a),0)
%  T Call: prueba_pa(hermano(a,_82),-1)
%  T Fail: prueba_pa(hermano(a,_82),-1)
%  T Call: prueba_pa(verdad,-1)
%  T Exit: prueba_pa(verdad,-1)
%  T Exit: prueba_pa(hermano(b,a),0)
%  T Exit: prueba_pa(hermano(a,b),1)
%  T Exit: prueba_pa(hermano(b,a),2)
%  T Exit: prueba_pa(hermano(a,b),3)
% X = b ;
%  T Redo: prueba_pa(hermano(a,b),3)
%  T Redo: prueba_pa(hermano(b,a),2)
%  T Redo: prueba_pa(hermano(a,b),1)
%  T Redo: prueba_pa(hermano(b,a),0)
%  T Redo: prueba_pa(verdad,-1)
%  T Fail: prueba_pa(verdad,-1)
%  T Fail: prueba_pa(hermano(_82,a),0)
%  T Fail: prueba_pa(hermano(a,_82),1)
%  T Call: prueba_pa(verdad,1)
%  T Exit: prueba_pa(verdad,1)
%  T Exit: prueba_pa(hermano(b,a),2)
%  T Exit: prueba_pa(hermano(a,b),3)
% X = b ;
%  T Redo: prueba_pa(hermano(a,b),3)
%  T Redo: prueba_pa(hermano(b,a),2)
%  T Redo: prueba_pa(verdad,1)
%  T Fail: prueba_pa(verdad,1)
%  T Fail: prueba_pa(hermano(_82,a),2)
%  T Fail: prueba_pa(hermano(a,_82),3)
% false.

