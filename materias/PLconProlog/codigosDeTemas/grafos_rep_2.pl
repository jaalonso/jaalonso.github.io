% grafos-rep-2.pl
% Grafos: Representación 2.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 22-mayo-2022
% =============================================================================

:- module(grafos_rep_2,
          [adyacente/3, % +Grafo, -Nodo, -Nodo
           nodos/2,     % +Grafo, -Nodos
           nodo/2,      % +Grafo, -Nodo
           arcos/2      % +Frafo, -Arcos
          ]).

% Un grafo se representa mediante la definición del predicado grafo(G,N,A) que
% se verifica si G es el nombre del grafo, N es la lista de nodos de G y A es la
% lista de arcos de N (cada uno representado mediante un término X-Y). Por
% ejemplo, la representación del siguiente grafo
%        b
%      / | \
%     /  |  \
%    a   |   c
%        |  /
%        | /
%        |/
%        d
% es
grafo(g2,[a,b,c,d],[a-b,b-c,b-d,c-d]).

% adyacente(G,X,Y) se verifica si los nodos X e Y son adyacentes en el grafo
% G. Por ejemplo,
%    ?- adyacente(g2,d,X).
%    X = b ;
%    X = c.
adyacente(G,X,Y) :-
   grafo(G,_,A),
   (member(X-Y,A) ; member(Y-X,A)).

% nodos(G,L) se verifica si L es la lista de los nodos del grafo G. Por ejemplo,
%    ?- nodos(g2,L).
%    L = [a, b, c, d].
nodos(G,L) :-
   grafo(G,L,_).

% nodo(N,G) se verifica si N es un nodo de G. Por ejemplo,
%    ?- nodo(N,g2).
%    N = a ;
%    N = b ;
%    N = c ;
%    N = d.
nodo(N,G) :-
   nodos(G,L),
   member(N,L).

% arcos(G,L) se verifica si L es la lista de los arcos del grafo G, de forma que
% el arco de extremo X e Y se represente por X-Y. Por ejemplo,
%    ?- arcos(g2,L).
%    L = [a-b, b-c, b-d, c-d].
arcos(G,L) :-
   grafo(G,_,L).
