% conc_2.pl
% Concatenación de listas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 13-mayo-2022
% =============================================================================

% ---------------------------------------------------------------------
% Definir la relación
%    conc(L1,L2,L3)
% que se verifica si L3 es la lista obtenida escribiendo los elementos
% de la lista L2 a continuación de los elementos de L1. Por ejemplo, si
% L1 es [a,b] y L2 es [c,d], entonces L3 es [a,b,c,d].
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
%---------------------------------------------------------------------

conc([],L,L).
conc([X|L1],L2,[X|L3]) :-
	conc(L1,L2,L3).

% Consultas
% =========

% ?- conc([a,b],[c,d,e],L).
% L = [a, b, c, d, e].
%
% ?- conc([a,b],L,[a,b,c,d]).
% L = [c, d].
%
% ?- conc(L1,L2,[a,b]).
% L1 = [],
% L2 = [a, b] ;
% L1 = [a],
% L2 = [b] ;
% L1 = [a, b],
% L2 = [] ;
% false.
%
% ?- conc(L1,[b|L2],[a,b,c]).
% L1 = [a],
% L2 = [c] ;
% false.
%
% ?- conc(_,[b|_],[a,b,c]).
% true
%
% ?- conc(_,[b,c|_],[a,b,c,d]).
% true
%
% ?- conc(_,[b,d|_],[a,b,c,d]).
% false.
%
% ?- conc(_,[X],[b,a,c,d]).
% X = d ;
% false.
