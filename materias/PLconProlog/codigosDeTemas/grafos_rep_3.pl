% grafos-rep-3.pl
% Grafos: Representación 3.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 22-mayo-2022
% =============================================================================

:- module(grafos_rep_3,
          [adyacente/3, % +Grafo, -Nodo, -Nodo
           nodos/2,     % +Grafo, -Nodos
           nodo/2,      % +Grafo, -Nodo
           arcos/2      % +Frafo, -Arcos
          ]).

% Un grafo se representa mediante la definición del predicado grafo(G,L) que se
% verifica si G es el nombre del grafo y L es una lista de pares formado por
% cada uno de los nodos de G y la lista de sus nodos adyacentes. Por ejemplo, la
% representación del siguiente grafo
%        b
%      / | \
%     /  |  \
%    a   |   c
%        |  /
%        | /
%        |/
%        d
% es
grafo(g3,[[a,[b]],
          [b,[a,c,d]],
          [c,[b,d]],
          [d,[b,c]]]).

% adyacente(G,X,Y) se verifica si los nodos X e Y son adyacentes en el grafo
% G. Por ejemplo,
%    ?- adyacente(g3,d,X).
%    X = b ;
%    X = c.
adyacente(G,X,Y) :-
   grafo(G,L),
   member([X,L1],L),
   member(Y,L1).

% nodo(G,N) se verifica si N es un nodo de G. Por ejemplo,
%    ?- nodo(g3,N,).
%    N = a ;
%    N = b ;
%    N = c ;
%    N = d.
nodo(G,N) :-
   grafo(G,L),
   member([N,_],L).

% nodos(G,L) se verifica si L es la lista de los nodos del grafo G. Por ejemplo,
%    ?- nodos(g3,L).
%    L = [a, b, c, d].
nodos(G,L) :-
   setof(N,nodo(G,N),L).

% arcos(G,L) se verifica si L es la lista de los arcos del grafo G, de forma que
% el arco de extremo X e Y se represente por X-Y. Por ejemplo,
%    ?- arcos(g3,L).
%    L = [a-b, b-c, b-d, c-d].
arcos(G,L) :-
   grafo(G,L1),
   findall(X-Y,(member([X,LX],L1), member(Y,LX), X @=< Y),L).
