% generacion_de_grafos.pl
% Generación de grafos.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 23-mayo-2022
% =============================================================================

:- dynamic grafo/3.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Completo (K_n)                                                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% completo(+N,-G) se verifica si G es el grafo completo de orden N. Por ejemplo,
%    ?- completo(3,G).
%    G = [1-2, 1-3, 2-3].
%
%    ?- completo(4,G).
%    G = [1-2, 1-3, 1-4, 2-3, 2-4, 3-4].
completo(N,G) :-
   findall(X-Y,arco_completo(N,X,Y),G).

arco_completo(N,X,Y) :-
   N1 is N-1,
   between(1,N1,X),
   X1 is X+1,
   between(X1,N,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Grafo aleatorio                                                         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% aleatorio(+P,+N,-G) se verifica si G es un subgrafo de {1..N}x{1..N}, donde
% cada arco se ha  elegido con la probabilidad P (0 <= P <= 1). Por ejemplo,
%    ?- aleatorio(0,4,G).
%    G = [].
%
%    ?- aleatorio(1,4,G).
%    G = [1-2, 1-3, 1-4, 2-3, 2-4, 3-4].
%
%    ?- aleatorio(0.1,4,G).
%    G = [2-3].
%
%    ?- aleatorio(0.1,4,G).
%    G = [1-3, 1-4].
%    ?- aleatorio(0.8,4,G).
%    G = [1-2, 1-3, 1-4, 2-3, 2-4].
%
%    ?- aleatorio(0.8,4,G).
%    G = [1-3, 1-4, 2-3, 2-4].
aleatorio(P,N,G) :-
   findall(X-Y,(arco_completo(N,X,Y),probabilidad(Z),Z=<P),G).

% probabilidad(X) se verifica si X es un número probabilidad en el intervalo
% [0,1]. Por ejemplo,
%    ?- probabilidad(X).
%    X = 0.08.
%
%    ?- probabilidad(X).
%    X = 0.023.
probabilidad(X) :-
   Y is random(1000),
   X is Y/1000.

aleatorio_almacena(P,N) :-
   aleatorio(P,N,G),
   gensym(g,E),
   assertz(grafo(E,G)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Rueda (W_n)                                                             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%    0      0
%    |     / \
%    |    /   \
%    1   1 --- 2

% Ver dibujo en [Hortalá, Leach y Rodríguez, 1998, p. 264].

% rueda(+N,-G)
%    se verifica si G es el grafo de rueda de orden N. Por ejemplo,
%       ?- rueda(1,G).
%       G = [0-1]
%       ?- rueda(2,G).
%       G = [0-1, 0-2, 1-2]
%       ?- rueda(3,G).
%       G = [0-1, 0-2, 0-3, 1-2, 2-3, 3-1]
%       ?- rueda(4,G).
%       G = [0-1, 0-2, 0-3, 0-4, 1-2, 2-3, 3-4, 4-1]
%       ?- rueda(5,G).
%       G = [0-1, 0-2, 0-3, 0-4, 0-5, 1-2, 2-3, 3-4, 4-5, 5-1]
rueda(N,G) :-
   findall(X-Y,arco_rueda(N,X,Y),G).

arco_rueda(N,0,Y) :-
   between(1,N,Y).
arco_rueda(N,X,Y) :-
   N1 is N-1,
   between(1,N1,X),
   Y is X+1.
arco_rueda(N,N,1) :-
   N > 2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Generación de tipos de grafos                                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% grafo(+T,+N,-G) se verifica si G es el grafo de tipo T y orden N (además,
% almacena en memoria el grafo generado). Por ejemplo,
%    ?- grafo(rueda,4,G).
%    G = [0-1, 0-2, 0-3, 0-4, 1-2, 2-3, 3-4, 4-1]
%    ?- grafo(completo,4,G).
%    G = [1-2, 1-3, 1-4, 2-3, 2-4, 3-4]
grafo(T,N,G) :-
   O =.. [T,N,G],
   O,
   asserta(grafo(T,N,G)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Elementos de los grafos                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- dynamic nodos/3.

% nodos(+T,+N,-L)
%    se verifica si L es la lista de nodos del grafo G. Por ejemplo,
%       ?- nodos(completo,4,L).
%       L = [1, 2, 3, 4]
nodos(T,N,L) :-
   grafo(T,N,G),
   setof(X,Y^(member(X-Y,G) ; member(Y-X,G)),L),
   asserta(nodos(T,N,L)).
