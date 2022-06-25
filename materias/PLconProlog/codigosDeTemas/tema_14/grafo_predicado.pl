% grafo_predicado.pl
% Grafos generados por un predicado.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-junio-2022
% ======================================================================

% Representación del grafo 
%       s
%      / \
%     /   \
%    c     p
%    |    / \
%    2    3  4
arco(s,c).
arco(s,p).
arco(c,2).
arco(p,3).
arco(p,4).

% camino(C) se verifica si C es un camino en el grafo definido por
% arco/2. Por ejemplo,
%    ?- camino(C).
%    C = [s,c] ;
%    C = [s,p] ;
%    C = [c,2] ;
%    C = [p,3] ;
%    C = [p,4] ;
%    C = [s,c,2] ;
%    C = [s,p,3] ;
%    C = [s,p,4] ;
%    false.
camino([Nodo1,Nodo2]) :-
   arco(Nodo1,Nodo2).
camino([Nodo1,Nodo2|Nodos]) :-
   arco(Nodo1,Nodo2),
   camino([Nodo2|Nodos]).

% hoja(N) se verifica si N es una hoja del grafo definido por
% arco/2. Por ejemplo,
%    ?- hoja(3).
%    true.
%    
%    ?- hoja(s).
%    false.
hoja(N) :-
   not(arco(N,_)).

% camino_hasta_hoja(N,C) se verifica si C es un camino en el grafo
% definido por arco/2 desde el nodo N hasta una hoja. Por ejemplo,
%    ?- camino_hasta_hoja(s,C).
%    C = [s,c,2] ;
%    C = [s,p,3] ;
%    C = [s,p,4] ;
%    false.
camino_hasta_hoja(Hoja,[Hoja]) :-
   hoja(Hoja).
camino_hasta_hoja(Nodo1,[Nodo1|Nodos]) :-
   arco(Nodo1,Nodo2),
   camino_hasta_hoja(Nodo2,Nodos).


