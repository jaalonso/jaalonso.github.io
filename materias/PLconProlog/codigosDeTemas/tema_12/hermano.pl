% hermano.pl
% BC de hermand para el metaintérprete con profundidad acotada.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 8-junio-2022
% ======================================================================

% Operadores
% ==========

% `<-' es el `si' del nivel objeto 
:- op(1200, xfx, <-).

% `&' es la conjunción en el nivel objeto 
:- op(1000, xfy, &).

% Base de conocimiento
% ====================

hermano(X,Y) <- hermano(Y,X).
hermano(b,a) <- verdad.

% No solución con el metaintérprete simple
% ========================================

% ?- [meta_simple].
% true.
% 
% ?- prueba(hermano(X,Y)).
% ERROR: Stack limit (1.0Gb) exceeded

% Solución con el metaintérprete con profundidad acotada
% ======================================================

% ?- [meta_pa].
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

% Ejemplo con call_with_depth_limit
% =================================

% ?- [meta_simple].
% true.
% 
% ?- call_with_depth_limit(prueba(hermano(X,Y)),1,R).
% R = depth_limit_exceeded.
% 
% ?- call_with_depth_limit(prueba(hermano(X,Y)),2,R).
% X = b,
% Y = a,
% R = 3 ;
% R = depth_limit_exceeded.
% 
% ?- call_with_depth_limit(prueba(hermano(X,Y)),3,R).
% X = a,
% Y = b,
% R = 4 ;
% X = b,
% Y = a,
% R = 4 ;
% false.
% 
% ?- call_with_depth_limit(prueba(hermano(X,Y)),4,R).
% X = b,
% Y = a,
% R = 5 ;
% X = a,
% Y = b,
% R = 5 ;
% X = b,
% Y = a,
% R = 4 ;
% false.
