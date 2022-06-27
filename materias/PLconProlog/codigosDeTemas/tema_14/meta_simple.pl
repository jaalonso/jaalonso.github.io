% meta_simple.pl
% Metaintérprete simple.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 7-junio-2022
% ======================================================================

% Operadores
% ==========

% `<-' es el `si' del nivel objeto 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
:- op(1000, xfy, &).

% Metaintérprete
% ==============

% prueba(+O)  se verifica si el objetivo O se puede demostrar.
prueba(verdad).
prueba((A & B)) :-
   prueba(A),
   prueba(B).
prueba(A) :-
   (A <- B),
   prueba(B).

% Sesión
% ======

% ?- [i_electrica].
% true.
% 
% ?- prueba(luz(l1)).
% true 
% 
% ?- prueba(luz(l6)).
% false.
% 
% ?- prueba(arriba(X)).
% X = i2 ;
% X = i3 ;
% false.
% 
% ?- prueba(conectado(l1,D)).
% D = c0 ;
% false.
% 
% ?- prueba(conectado(c0,D)).
% D = c1 ;
% false.
% 
% ?- prueba(conectado(c1,D)).
% false.
% 
% ?- prueba(conectado(D,c3)).
% D = c2 ;
% D = c4 ;
% D = e1 ;
% false.
% 
% ?- prueba(conectado(X,Y)).
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
% Y = entrada ;
% false.
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
% false.
% 
% ?- prueba(esta_encendida(X)).
% X = l2 ;
% false.
% 
% ?- trace(prueba).
% true.
% 
% ?- prueba(esta_encendida(X)).
%  T Call: prueba(esta_encendida(_1512))
%  T Call: prueba((luz(_1512)&esta_bien(_1512)&tiene_corriente(_1512)))
%  T Call: prueba(luz(_1512))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(luz(l1))
%  T Call: prueba((esta_bien(l1)&tiene_corriente(l1)))
%  T Call: prueba(esta_bien(l1))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(esta_bien(l1))
%  T Call: prueba(tiene_corriente(l1))
%  T Call: prueba((conectado(l1,_7854)&tiene_corriente(_7854)))
%  T Call: prueba(conectado(l1,_7854))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(conectado(l1,c0))
%  T Call: prueba(tiene_corriente(c0))
%  T Call: prueba((conectado(c0,_10890)&tiene_corriente(_10890)))
%  T Call: prueba(conectado(c0,_10890))
%  T Call: prueba(arriba(i2))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(arriba(i2))
%  T Exit: prueba(conectado(c0,c1))
%  T Call: prueba(tiene_corriente(c1))
%  T Call: prueba((conectado(c1,_14890)&tiene_corriente(_14890)))
%  T Call: prueba(conectado(c1,_14890))
%  T Call: prueba(arriba(i1))
%  T Fail: prueba(arriba(i1))
%  T Fail: prueba(conectado(c1,_14890))
%  T Fail: prueba((conectado(c1,_14890)&tiene_corriente(_14890)))
%  T Fail: prueba(tiene_corriente(c1))
%  T Redo: prueba(conectado(c0,c1))
%  T Redo: prueba(arriba(i2))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(arriba(i2))
%  T Call: prueba(abajo(i2))
%  T Fail: prueba(abajo(i2))
%  T Fail: prueba(conectado(c0,_10890))
%  T Fail: prueba((conectado(c0,_10890)&tiene_corriente(_10890)))
%  T Fail: prueba(tiene_corriente(c0))
%  T Redo: prueba(conectado(l1,c0))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(conectado(l1,_7854))
%  T Fail: prueba((conectado(l1,_7854)&tiene_corriente(_7854)))
%  T Fail: prueba(tiene_corriente(l1))
%  T Redo: prueba(esta_bien(l1))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(esta_bien(l1))
%  T Fail: prueba((esta_bien(l1)&tiene_corriente(l1)))
%  T Redo: prueba(luz(l1))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(luz(l2))
%  T Call: prueba((esta_bien(l2)&tiene_corriente(l2)))
%  T Call: prueba(esta_bien(l2))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(esta_bien(l2))
%  T Call: prueba(tiene_corriente(l2))
%  T Call: prueba((conectado(l2,_22608)&tiene_corriente(_22608)))
%  T Call: prueba(conectado(l2,_22608))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(conectado(l2,c4))
%  T Call: prueba(tiene_corriente(c4))
%  T Call: prueba((conectado(c4,_25644)&tiene_corriente(_25644)))
%  T Call: prueba(conectado(c4,_25644))
%  T Call: prueba(arriba(i3))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(arriba(i3))
%  T Exit: prueba(conectado(c4,c3))
%  T Call: prueba(tiene_corriente(c3))
%  T Call: prueba((conectado(c3,_29644)&tiene_corriente(_29644)))
%  T Call: prueba(conectado(c3,_29644))
%  T Call: prueba(esta_bien(cc1))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(esta_bien(cc1))
%  T Exit: prueba(conectado(c3,c5))
%  T Call: prueba(tiene_corriente(c5))
%  T Call: prueba((conectado(c5,_3770)&tiene_corriente(_3770)))
%  T Call: prueba(conectado(c5,_3770))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(conectado(c5,entrada))
%  T Call: prueba(tiene_corriente(entrada))
%  T Call: prueba((conectado(entrada,_6806)&tiene_corriente(_6806)))
%  T Call: prueba(conectado(entrada,_6806))
%  T Fail: prueba(conectado(entrada,_6806))
%  T Fail: prueba((conectado(entrada,_6806)&tiene_corriente(_6806)))
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(tiene_corriente(entrada))
%  T Exit: prueba((conectado(c5,entrada)&tiene_corriente(entrada)))
%  T Exit: prueba(tiene_corriente(c5))
%  T Exit: prueba((conectado(c3,c5)&tiene_corriente(c5)))
%  T Exit: prueba(tiene_corriente(c3))
%  T Exit: prueba((conectado(c4,c3)&tiene_corriente(c3)))
%  T Exit: prueba(tiene_corriente(c4))
%  T Exit: prueba((conectado(l2,c4)&tiene_corriente(c4)))
%  T Exit: prueba(tiene_corriente(l2))
%  T Exit: prueba((esta_bien(l2)&tiene_corriente(l2)))
%  T Exit: prueba((luz(l2)&esta_bien(l2)&tiene_corriente(l2)))
%  T Exit: prueba(esta_encendida(l2))
% X = l2 ;
%  T Redo: prueba(esta_encendida(l2))
%  T Redo: prueba((luz(l2)&esta_bien(l2)&tiene_corriente(l2)))
%  T Redo: prueba((esta_bien(l2)&tiene_corriente(l2)))
%  T Redo: prueba(tiene_corriente(l2))
%  T Redo: prueba((conectado(l2,c4)&tiene_corriente(c4)))
%  T Redo: prueba(tiene_corriente(c4))
%  T Redo: prueba((conectado(c4,c3)&tiene_corriente(c3)))
%  T Redo: prueba(tiene_corriente(c3))
%  T Redo: prueba((conectado(c3,c5)&tiene_corriente(c5)))
%  T Redo: prueba(tiene_corriente(c5))
%  T Redo: prueba((conectado(c5,entrada)&tiene_corriente(entrada)))
%  T Redo: prueba(tiene_corriente(entrada))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(tiene_corriente(entrada))
%  T Redo: prueba(conectado(c5,entrada))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(conectado(c5,_3770))
%  T Fail: prueba((conectado(c5,_3770)&tiene_corriente(_3770)))
%  T Fail: prueba(tiene_corriente(c5))
%  T Redo: prueba(conectado(c3,c5))
%  T Redo: prueba(esta_bien(cc1))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(esta_bien(cc1))
%  T Fail: prueba(conectado(c3,_2278))
%  T Fail: prueba((conectado(c3,_2278)&tiene_corriente(_2278)))
%  T Fail: prueba(tiene_corriente(c3))
%  T Redo: prueba(conectado(c4,c3))
%  T Redo: prueba(arriba(i3))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(arriba(i3))
%  T Fail: prueba(conectado(c4,_1618))
%  T Fail: prueba((conectado(c4,_1618)&tiene_corriente(_1618)))
%  T Fail: prueba(tiene_corriente(c4))
%  T Redo: prueba(conectado(l2,c4))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(conectado(l2,_1090))
%  T Fail: prueba((conectado(l2,_1090)&tiene_corriente(_1090)))
%  T Fail: prueba(tiene_corriente(l2))
%  T Redo: prueba(esta_bien(l2))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(esta_bien(l2))
%  T Fail: prueba((esta_bien(l2)&tiene_corriente(l2)))
%  T Redo: prueba(luz(l2))
%  T Redo: prueba(verdad)
%  T Fail: prueba(verdad)
%  T Fail: prueba(luz(_10))
%  T Fail: prueba((luz(_10)&esta_bien(_10)&tiene_corriente(_10)))
%  T Fail: prueba(esta_encendida(_10))
% false.
% 
% ?- maplist(trace,[prueba,<-]).
% true.
% 
% ?- prueba(tiene_corriente(c5)).
%  T Call: prueba(tiene_corriente(c5))
%  T Call: tiene_corriente(c5)<-_888
%  T Exit: tiene_corriente(c5)<-conectado(c5,_1438)&tiene_corriente(_1438)
%  T Call: prueba((conectado(c5,_1438)&tiene_corriente(_1438)))
%  T Call: prueba(conectado(c5,_1438))
%  T Call: conectado(c5,_1438)<-_2972
%  T Exit: conectado(c5,entrada)<-verdad
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(conectado(c5,entrada))
%  T Call: prueba(tiene_corriente(entrada))
%  T Call: tiene_corriente(entrada)<-_5860
%  T Exit: tiene_corriente(entrada)<-conectado(entrada,_6410)&tiene_corriente(_6410)
%  T Call: prueba((conectado(entrada,_6410)&tiene_corriente(_6410)))
%  T Call: prueba(conectado(entrada,_6410))
%  T Call: conectado(entrada,_6410)<-_7944
%  T Fail: conectado(entrada,_6410)<-_7944
%  T Fail: prueba(conectado(entrada,_6410))
%  T Call: conectado(entrada,_6410)&tiene_corriente(_6410)<-_8548
%  T Fail: conectado(entrada,_6410)&tiene_corriente(_6410)<-_8548
%  T Fail: prueba((conectado(entrada,_6410)&tiene_corriente(_6410)))
%  T Redo: tiene_corriente(entrada)<-conectado(entrada,_6410)&tiene_corriente(_6410)
%  T Exit: tiene_corriente(entrada)<-verdad
%  T Call: prueba(verdad)
%  T Exit: prueba(verdad)
%  T Exit: prueba(tiene_corriente(entrada))
%  T Exit: prueba((conectado(c5,entrada)&tiene_corriente(entrada)))
%  T Exit: prueba(tiene_corriente(c5))
% true 

% No solución con la BC de hermandad
% ==================================

% ?- [hermano].
% true.
% 
% ?- prueba(hermano(X,Y)).
% ERROR: Stack limit (1.0Gb) exceeded

% Comentario
% ==========

% Ver el predicado call_with_depth_limit/3 de SWI Prolog
%
% call_with_depth_limit(+Goal, +Limit, -Result)
%     If  Goal can be proven  without recursion deeper than Limit  levels,
%     call_with_depth_limit/3 succeeds,  binding  Result  to  the  deepest
%     recursion  level  used  during the  proof.    Otherwise,  Result  is
%     unified  with depth_limit_exceeded  if the limit was exceeded  during
%     the  proof,  or the  entire predicate  fails if  Goal fails  without
%     exceeding Limit.
% 
%     The  depth-limit is guarded by the internal machinery.   This differ
%     from  the  depth  computed  based  on a  theoretical  model.     For
%     example,  true/0  is  translated  into an  inlined  virtual  machine
%     instruction.   Also, repeat/0 is not implemented as below, but  as a
%     non-deterministic foreign predicate.
% 
%     repeat.
%     repeat :-
%             repeat.
% 
%     As  a  result, call_with_depth_limit/3 may  still loop  inifitly  on
%     programs  that should  theoretically finish  in finite time.    This
%     problem  can be cured by  using Prolog equivalents to such  built-in
%     predicates.
% 
%     This   predicate  may  be   used  for  theorem-provers  to   realise
%     techniques  like iterrative  deepening.   It  was implemented  after
%     discussion with Steve Moyle smoyle@ermine.ox.ac.uk.

% Ejemplo con call_with_depth_limit
% =================================

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
