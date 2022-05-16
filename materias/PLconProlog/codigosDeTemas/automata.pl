% automata.pl
% Autómata no-determinista.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 16-mayo-2022
% ======================================================================

% ----------------------------------------------------------------------
% Ejercicio 1. Consideremos el autómata representado por
%
%         a
%        ____
%       |    |
%       |    .       a
%       |--  e1 ------------> e2
%       |    .  .           / |
%       |____|    \       /   |
%         b         \   /     |
%                     \       | b
%                  /    \     |
%                /        \   |
%              .            \ .
%            e4 <-----------  e3
%                    b
%
% siendo e3 el estado final. Representar el autómata utilizando las
% siguientes relaciones:
% (1) final(S) que se verifica si X es el estado final.
% (2) trans(E1,X,E2) que se verifica si se puede pasar del estado E1 al
%     estado E2 usando la letra X.
% (3) nulo(E1,E2) que se verifica si se puede pasar del estado E1 al
%     estado E2 mediante un movimiento nulo.
% ----------------------------------------------------------------------

final(e3).

trans(e1,a,e1).
trans(e1,a,e2).
trans(e1,b,e1).
trans(e2,b,e3).
trans(e3,b,e4).

nulo(e2,e4).
nulo(e3,e1).

% ----------------------------------------------------------------------
% Ejercicio 2. Definir la relación
%    acepta(E,L)
% que se verifique si el autómata, a partir del estado E, acepta la
% lista L. Por ejemplo,
%    ?- acepta(e1,[a,a,a,b]).
%    true ;
%    false.
%
%    ?- acepta(e2,[a,a,a,b]).
%    false.
% ----------------------------------------------------------------------

acepta(E,[]) :-
   final(E).
acepta(E,[X|L]) :-
   trans(E,X,E1),
   acepta(E1,L).
acepta(E,L) :-
   nulo(E,E1),
   acepta(E1,L).

% ----------------------------------------------------------------------
% Ejercicio 3. Determinar los estados a partir de los cuales el autómata
% acepta la lista [a,b].
% ----------------------------------------------------------------------

% ?- acepta(E,[a,b]).
% E = e1 ;
% E = e3 ;
% false.

% ----------------------------------------------------------------------
% Ejercicio 4. Determinar las palabras de longitud 3 aceptadas por el
% autómata a partir del estado e1.
% ----------------------------------------------------------------------

% ?- acepta(e1,[X,Y,Z]).
% X = Y, Y = a,
% Z = b ;
% X = Z, Z = b,
% Y = a ;
% false.

% ----------------------------------------------------------------------
% Ejercicio 5. Definir la relación
%    acepta_acotada(S,L,N)
% que se verifique si el autómata, a partir del estado S, acepta la
% lista L y la longitud de L es N.
% ----------------------------------------------------------------------

acepta_acotada(S,[],0) :-
   final(S).

acepta_acotada(S,[X|L],N) :-
   N > 0,
   trans(S,X,E1),
   M is N -1,
   acepta_acotada(E1,L,M).

acepta_acotada(S,L,N) :-
   N > 0,
   nulo(S,E1),
   acepta_acotada(E1,L,N).

% ----------------------------------------------------------------------
% Ejercicio 6. Buscar las cadenas aceptadas a partir de e1 con longitud
% 3.
% ----------------------------------------------------------------------

% ?- acepta_acotada(e1,L,3).
% L = [a, a, b] ;
% L = [b, a, b] ;
% false.

% ----------------------------------------------------------------------
% Ejercicio 7. Definir la relación
%    acepta_acotada_2(S,L,N)
% que se verifique si el autómata, a partir del estado S, acepta la
% lista L y la longitud de L es menor o igual que N.
% ----------------------------------------------------------------------

acepta_acotada_2(S,[],_N) :-
   final(S).

acepta_acotada_2(S,[X|L],N) :-
   N > 0,
   trans(S,X,E1),
   M is N-1,
   acepta_acotada_2(E1,L,M).

acepta_acotada_2(S,L,N) :-
   N > 0,
   nulo(S,E1),
   acepta_acotada_2(E1,L,N).

% ----------------------------------------------------------------------
% Ejercicio 8. Buscar las cadenas aceptadas a partir de e1 con longitud
% menor o igual a 3.
% ----------------------------------------------------------------------

% ?- acepta_acotada_2(e1,L,3).
% L = [a, a, b] ;
% L = [a, b] ;
% L = [b, a, b] ;
% false.
