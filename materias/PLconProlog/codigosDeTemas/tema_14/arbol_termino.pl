% arbol_termino.pl
% Árboles como términos.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 24-junio-2022
% ======================================================================

% termino_arbol(A,R,S) se verifica si A es el término que representa al
% árbol de raíz R y subárboles S. Por ejemplo, 
%    ?- termino_arbol(s(c(2),p(3,4)),R,S).
%    R = s,
%    S = [c(2),p(3,4)].
%    
%    ?- termino_arbol(A,s,[c(2),p(3,4)]).
%    A = s(c(2),p(3,4)).
termino_arbol(Arbol,Raiz,Subarboles) :-
   Arbol =.. [Raiz|Subarboles].

% termino_raiz(+A,?R) se verifica si R es la raíz del árbol representado
% por el término A. Por ejemplo,
%    ?- termino_raiz(s(c(2),p(3,4)),R).
%    R = s.
termino_raiz(Arbol,Raiz) :-
   termino_arbol(Arbol,Raiz,_).

% termino_subtermino(A,S) se verifica si S es un subárbol del árbol
% representado por el término A. Por ejemplo,
%    ?- termino_subtermino(s(c(2),p(3,4)),S).
%    S = c(2) ;
%    S = p(3,4).
termino_subtermino(Arbol,Subarbol) :-
   termino_arbol(Arbol,_,S),
   member(Subarbol,S).

% termino_arco(A,Arco) se verifica si Arco es un arco del árbol A. Por
% ejemplo, 
%    ?- termino_arco(s(c(2),p(3,4)),Arc).
%    Arc = s-c ;
%    Arc = s-p ;
%    Arc = c-2 ;
%    Arc = p-3 ;
%    Arc = p-4 ;
%    false.
termino_arco(Arbol,Raiz-SR) :-
   termino_raiz(Arbol,Raiz),
   termino_subtermino(Arbol,Subarbol),
   termino_raiz(Subarbol,SR).
termino_arco(Arbol,Arco) :-
   termino_subtermino(Arbol,Subarbol),
   termino_arco(Subarbol,Arco).

% termino_camino(A,C) se verifica si C es un camino en el árbol A. Por
% ejemplo, 
%    ?- termino_camino(s(c(2),p(3,4)),C).
%    C = [s,c] ;
%    C = [s,p] ;
%    C = [c,2] ;
%    C = [p,3] ;
%    C = [p,4] ;
%    C = [s,c,2] ;
%    C = [s,p,3] ;
%    C = [s,p,4] ;
%    false.
termino_camino(Arbol,[Nodo1,Nodo2]) :-
   termino_arco(Arbol,Nodo1-Nodo2).
termino_camino(Arbol,[Nodo1,Nodo2|Nodos]) :-
   termino_arco(Arbol,Nodo1-Nodo2),
   termino_camino(Arbol,[Nodo2|Nodos]).

% termino_escribe(A) escribe el árbol A. Por ejemplo,
%    ?- termino_escribe(s(c(2),p(3,4))).
%    ---------s---------c---------2
%              ---------p---------3
%                        ---------4
%    true 
%    
%    ?- termino_escribe(s(cuad(2),p(3,4))).
%    ---------s------cuad---------2
%              ---------p---------3
%                        ---------4
%    true 
termino_escribe(Arbol) :-
   termino_escribe(0,Arbol),
   nl.

termino_escribe(Pos,Arbol) :-
   termino_arbol(Arbol,Raiz,Subarboles),   
   termino_escribe_nodo(Pos,Pos2,Raiz),    
   termino_escribe_nodos(Pos2,Subarboles).         

termino_escribe_nodo(Principio,Fin,Nodo) :-
   name(Nodo,L),
   length(L,N),
   Fin is Principio+10,
   N1 is Fin-Principio-N,
   escribe_linea(N1),
   write(Nodo).

escribe_linea(0).
escribe_linea(N) :-
   N>0,
   N1 is N-1,
   write('-'),
   escribe_linea(N1).

termino_escribe_nodos(_Pos,[]).
termino_escribe_nodos(Pos,[Arbol]) :- !,
   termino_escribe(Pos,Arbol).
termino_escribe_nodos(Pos,[Arbol|Subarboles]) :-
   termino_escribe(Pos,Arbol),
   nl,tab(Pos),
   termino_escribe_nodos(Pos,Subarboles).

% termino_numero_de_caminos(A,N) se verifica si N es el número de
% caminos en el árbol A. Por ejemplo,
%    ?- termino_numero_de_caminos(s(c(2),p(3,4)),N).
%    N = 8.
termino_numero_de_caminos(A,N) :-
   findall(C,termino_camino(A,C),L),
   length(L,N).
