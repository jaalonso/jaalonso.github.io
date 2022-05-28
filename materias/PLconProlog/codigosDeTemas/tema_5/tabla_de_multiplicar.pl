% crea_tabla añade los hechos producto(X,Y,Z) donde X e Y son números de
% 0 a 9 y Z es el producto de X e Y. Por ejemplo,
%    ?- crea_tabla.
%    true.
%
%    ?- listing(producto).
%    :- dynamic producto/3.
%
%    producto(0, 0, 0).
%    producto(0, 1, 0).
%    ...
%    producto(9, 8, 72).
%    producto(9, 9, 81).
%
%    true.
crea_tabla :-
   L = [0,1,2,3,4,5,6,7,8,9],
   member(X,L),
   member(Y,L),
   Z is X*Y,
   assert(producto(X,Y,Z)),
   fail.
crea_tabla.

% Determinar las descomposiciones de 6 en producto de dos números.
%    ?- producto(A,B,6).
%    A = 1,
%    B = 6 ;
%    A = 2,
%    B = 3 ;
%    A = 3,
%    B = 2 ;
%    A = 6,
%    B = 1.
