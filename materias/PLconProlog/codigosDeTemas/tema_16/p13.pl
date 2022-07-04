% diagnóstico de circuito
%==============================================================================

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

sumador(X,Y,Z,Acarreo,Suma) <-
        xorg(xor1,X,Y,S),
        xorg(xor2,Z,S,Suma),
        andg(and1,X,Y,A1),
        andg(and2,Z,S,A2),
        org(or1,A1,A2,Acarreo).

xorg(_N,X,Y,Z) <- xor(X,Y,Z).
xorg(N,1,1,1) <- fallo(N=f1).
xorg(N,0,0,1) <- fallo(N=f1).
xorg(N,1,0,0) <- fallo(N=f0).
xorg(N,0,1,0) <- fallo(N=f0).

andg(_N,X,Y,Z) <- and(X,Y,Z).
andg(N,0,0,1) <- fallo(N=f1).
andg(N,1,0,1) <- fallo(N=f1).
andg(N,0,1,1) <- fallo(N=f1).
andg(N,1,1,0) <- fallo(N=f0).

org(_N,X,Y,Z) <- or(X,Y,Z).
org(N,0,0,1) <- fallo(N=f1).
org(N,1,0,0) <- fallo(N=f0).
org(N,0,1,0) <- fallo(N=f0).
org(N,1,1,0) <- fallo(N=f0).

xor(1,0,1) <- true.
xor(0,1,1) <- true.
xor(1,1,0) <- true.
xor(0,0,0) <- true.

and(1,1,1) <- true.
and(1,0,0) <- true.
and(0,1,0) <- true.
and(0,0,0) <- true.

or(1,1,1) <- true.
or(1,0,1) <- true.
or(0,1,1) <- true.
or(0,0,0) <- true.

%******************************************************************************
% § Sesión
%******************************************************************************

% ?- [p14].
% Yes
%
% ?- diagnostico(sumador(0,0,1,1,0),D).
% D = [fallo(or1 = f1), fallo(xor2 = f0)] ;
% D = [fallo(and2 = f1), fallo(xor2 = f0)] ;
% D = [fallo(and1 = f1), fallo(xor2 = f0)] ;
% D = [fallo(and2 = f1), fallo(and1 = f1), fallo(xor2 = f0)] ;
% D = [fallo(xor1 = f1)] ;
% D = [fallo(or1 = f1), fallo(and2 = f0), fallo(xor1 = f1)] ;
% D = [fallo(and1 = f1), fallo(xor1 = f1)] ;
% D = [fallo(and2 = f0), fallo(and1 = f1), fallo(xor1 = f1)] ;
% No
% 
% ?- diagnostico_minimo(sumador(0,0,1,1,0),D).
% D = [fallo(or1 = f1), fallo(xor2 = f0)] ;
% D = [fallo(and2 = f1), fallo(xor2 = f0)] ;
% D = [fallo(and1 = f1), fallo(xor2 = f0)] ;
% D = [fallo(xor1 = f1)] ;
% No


