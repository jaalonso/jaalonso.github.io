% sumador_1.pl
% Circuito sumador.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 4-julio-2022
% ======================================================================

%          +----+
% X ----+->|    |S
%       |  |xor1|--+--+             
% Y --+-|->|    |  |  |             +----+
%     | |  +----+  |  +------------>|    |
%     | |       |  |                |xor2|---Suma
% Z --|-|-------+--|--------------->|    |
%     | |       |  |   +----+       +----+
%     | +-------|--|-->|    |A1
%     |         |  |   |and1|---+      
%     +---------|--|-->|    |   |   +----+      
%               |  |   +----+   +-->|    |
%               |  |                |or1 |---Acarreo
%               |  |   +----+   +-->|    |   
%               |  +-->|    |A2 |   +----+   
%               |      |and1|---+   
%               +----->|    |  
%                      +----+  

sumador(X,Y,Z,Acarreo,Suma) :-
   xor(X,Y,S),
   xor(Z,S,Suma),
   and(X,Y,A1),
   and(Z,S,A2),
   or(A1,A2,Acarreo).

and(1,1,1). 
and(1,0,0).
and(0,1,0).
and(0,0,0).

or(1,1,1).
or(1,0,1).
or(0,1,1).
or(0,0,0).

xor(1,0,1). 
xor(0,1,1). 
xor(1,1,0). 
xor(0,0,0).
          
tabla :-
   format('X Y Z A S~n'),
   tabla2.
tabla2 :-
   member(X,[0,1]),
   member(Y,[0,1]),
   member(Z,[0,1]),
   sumador(X,Y,Z,A,S),
   format('~a ~a ~a ~a ~a~n',[X,Y,Z,A,S]),
   fail.
tabla2.

% Sesión
% ======

% ?- tabla.
% X Y Z A S
% 0 0 0 0 0
% 0 0 1 0 1
% 0 1 0 0 1
% 0 1 1 1 0
% 1 0 0 0 1
% 1 0 1 1 0
% 1 1 0 1 0
% 1 1 1 1 1
% true.









