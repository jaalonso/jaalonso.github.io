% grafo_SLD.pl
% Grafos de resolución SLD.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-junio-2022
% ======================================================================

% Los programas lógicos se pueden definir usando el operador <-. Por
% ejemplo, 

:- op(1200,xfx,<-).

suma(s(X),Y,s(Z)) <- [suma(X,Y,Z)].
suma(0,Y,Y) <- [].

alumno(A,P) <- [estudia(A,C), enseña(P,C)].
estudia(ana,ia) <- [].
estudia(ana,pl) <- [].
estudia(eva,ra) <- [].
enseña(jose_a,ia) <- [].
enseña(jose_a,ra) <- [].
enseña(rafael,pl) <- [].

hermano(a,b) <- [].
hermano(b,c) <- [].
hermano(X,Y) <-
   [hermano(X,Z),
    hermano(Z,Y)].

% arco(Xs,Ys) se verifica si Ys es la lista de objetivos obtenida
% aplicándole al primer objetivo de Xs una regla del programa lógico
% definido por el operador <-. Por ejemplo,
%    ?- arco([alumno(A,jose_a)],Xs).
%    Xs = [estudia(A,_6944),enseña(jose_a,_6944)].
%    
%    ?- arco([estudia(A,_C),enseña(jose_a,_C)],Xs).
%    A = ana,
%    Xs = [enseña(jose_a,ia)] ;
%    A = ana,
%    Xs = [enseña(jose_a,pl)] ;
%    A = eva,
%    Xs = [enseña(jose_a,ra)].
%    
%    ?- arco([enseña(jose_a,ia)],Xs).
%    Xs = [].
%    
%    ?- arco([suma(X,Y,s(s(0)))],Xs).
%    X = s(_67111562),
%    Xs = [suma(_67111562,Y,s(0))] ;
%    X = 0,
%    Y = s(s(0)),
%    Xs = [].
%    
%    ?- arco([suma(X,Y,s(0))],Xs).
%    X = s(_67113946),
%    Xs = [suma(_67113946,Y,0)] ;
%    X = 0,
%    Y = s(0),
%    Xs = [].
%    
%    ?- arco([suma(X,Y,0)],Xs).
%    X = Y, Y = 0,
%    Xs = [].
arco([A|As],L) :-
   (A <- Cuerpo),
   append(Cuerpo,As,L).

% hoja(Xs) se verifica si Xs es la lista vacía de objetivos.
hoja([]).

% camino_hasta_hoja(N,C) se verifica si C es un camino en el grafo
% definido por arco/2 desde el nodo N hasta una hoja. Por ejemplo, 
%    ?- camino_hasta_hoja([alumno(A,jose_a)],_).
%    A = ana ;
%    A = eva ;
%    false.
%    
%    ?- camino_hasta_hoja([suma(X,Y,s(s(0)))],_).
%    X = s(s(0)),
%    Y = 0 ;
%    X = Y, Y = s(0) ;
%    X = 0,
%    Y = s(s(0)) ;
%    false.
camino_hasta_hoja(Hoja,[Hoja]) :-
   hoja(Hoja).
camino_hasta_hoja(Nodo1,[Nodo1|Nodos]) :-
   arco(Nodo1,Nodo2),
   camino_hasta_hoja(Nodo2,Nodos).
