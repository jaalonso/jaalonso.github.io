% concatena-1.pl
% Concatenación de listas.
% Ref.: Bratko-86 p. 68-69.
%==============================================================================

%******************************************************************************
% Enunciado
%******************************************************************************

% Definir el predicado
%      conc(L1,L2,L3)
% de forma que si L1 y L2 son listas, entonces L3 es la lista obtenida
% escribiendo los elementos de L2 a continuación de los elementos de
% L1. Por ejemplo, si L1 es [a,b] y L2 es [c,d], entonces L3 es
% [a,b,c,d].
%
% Utilizar el programa para responder a las siguientes cuestiones:
% (1) ¿Cuál es el resultado de concatenar las listas [a,b] y [c,d,e]?
% (2) ¿Qué lista hay que añadirle al lista [a,b] para obtener
%     [a,b,c,d]?.
% (3) ¿Qué listas hay que concatenar para obtener [a,b]?.
% (4) ¿Pertenece b a la lista [a,b,c]?.
% (6) ¿Es [b,c] una sublista de [a,b,c,d]?.
% (7) ¿Es [b,d] una sublista de [a,b,c,d]?.
% (8) ¿Cuál es el último elemento de [b,a,c,d]?.
%
% Construir el árbol de deducción correspondiente a la pregunta
% conc(L1,L2,[a,b]).

%******************************************************************************
% Programa
%******************************************************************************

% conc(?L1,?L2,?L3) :-
% 	L3 es la lista obtenida añadiendo L2 a continuación de L1.
conc([],L,L).
conc([X|L1],L2,[X|L3]) :-
	conc(L1,L2,L3).

%******************************************************************************
% Sesión
%******************************************************************************

% ?- conc([a,b],[c,d,e],L).
% L = [a, b, c, d, e] ;
%
% ?- conc([a,b],L,[a,b,c,d]).
% L = [c, d] ;
%
% ?- conc(L1,L2,[a,b]).
% L1 = []
% L2 = [a, b] ;
% L1 = [a]
% L2 = [b] ;
% L1 = [a, b]
% L2 = [] ;
%
% ?- conc(L1,[b|L2],[a,b,c]).
% L1 = [a]
% L2 = [c] ;
%
% ?- conc(_,[b|_],[a,b,c]).
% Yes
%
% ?- conc(_,[b,c|_],[a,b,c,d]).
% Yes
%
% ?- conc(_,[b,d|_],[a,b,c,d]).
% No
%
% ?- conc(_,[X],[b,a,c,d]).
% X = d ;
