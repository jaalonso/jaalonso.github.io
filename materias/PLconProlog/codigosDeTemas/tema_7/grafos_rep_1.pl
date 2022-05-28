% grafos_rep_1.pl
% Grafos: Representación 1.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 22-mayo-2022
% =============================================================================

% :- module(grafos_rep_1,
%           [adyacente/3, % +Grafo, -Nodo, -Nodo
%            nodos/2,     % +Grafo, -Nodos
%            nodo/2,      % +Grafo, -Nodo
%            arcos/2      % +Frafo, -Arcos
%           ]).

% Un grafo se representa mediante la definición de la relación conectado(G,X,Y)
% que se verifica si X e Y son dos nodos conectados en el grafo G. (Nota: Sólo
% se escribe un hecho por cada arco). Por ejemplo, conectado(g1,X,Y) es la
% representación del siguiente grafo
%        b
%      / | \
%     /  |  \
%    a   |   c
%        |  /
%        | /
%        |/
%        d
conectado(g1,a,b).
conectado(g1,b,c).
conectado(g1,b,d).
conectado(g1,c,d).

% adyacente(G,X,Y) se verifica si los nodos X e Y son adyacentes en el grafo
% G. (Nota: adyacente es la clausura simétrica de conectado). Por ejemplo,
%    ?- adyacente(g1,d,X).
%    X = b ;
%    X = c.
adyacente(G,X,Y) :-
   conectado(G,X,Y) ; conectado(G,Y,X).

% nodos(G,L) se verifica si L es la lista de los nodos del grafo G. Por ejemplo,
%    ?- nodos(g1,L).
%    L = [a, b, c, d].
nodos(G,L) :-
   setof(X,Y^(conectado(G,X,Y);conectado(G,Y,X)),L).

% nodo(G,N) se verifica si N es un nodo de G. Por ejemplo,
%    ?- nodo(g1,N).
%    N = a ;
%    N = b ;
%    N = c ;
%    N = d.
nodo(G,N) :-
   nodos(G,L),
   member(N,L).

% arcos(G,L) se verifica si L es la lista de los arcos del grafo G, de forma que
% el arco de extremo X e Y se represente por X-Y. Por ejemplo,
%    ?- arcos(g1,L).
%    L = [a-b, b-c, b-d, c-d].
arcos(G,L) :-
   setof(X-Y,conectado(G,X,Y),L).
