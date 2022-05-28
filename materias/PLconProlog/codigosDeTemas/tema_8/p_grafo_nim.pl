% p_grafo_nim.pl
% Ejemplo para introducir la búsqueda en profundidad con cerrados.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 25-mayo-2022
% ======================================================================

% Descripción del problema
% ========================

% Problema de búsqueda correspondiente al siguiente grafo:
%
%                                  1
%                                /   \
%                              2       3
%                             /  \   /  \
%                            4     6      9
%                          /   \ /   \   /  \
%                         8    12      18    27
%                       /   \ /
%                     16    24
%
% donde el estado inicial es 1 el estado final es 27.

% Representación del problema
% ===========================

% Un ESTADO es un número.

% estado_inicial(?E) se verifica si E es el estado inicial.
estado_inicial(1).

% estado_final(?E) se verifica si E es un estado final.
estado_final(27).

% sucesor(+E1,?E2) se verifica si E2 es un sucesor del estado E1.
sucesor(X,Y) :-
   Y is 2*X,
   Y =< 27.
sucesor(X,Y) :-
   Y is 3*X,
   Y =< 27.

%******************************************************************************
% § Sesión
%******************************************************************************

% ?- ['p-grafo-nim.pl'].
% p-grafo-nim.pl compiled, 0.02 sec, 288 bytes.

% Yes
% ?- trace(estado_final,[+call]).
%         estado_final/1: call

% Yes
% ?- ['b-profundidad-sin-ciclos.pl'].
% b-profundidad-sin-ciclos.pl compiled, 0.02 sec, 0 bytes.

% Yes
% ?- profundidad_sin_ciclos(S).
% T Call:  (  9) estado_final(1)
% T Call:  ( 10) estado_final(2)
% T Call:  ( 11) estado_final(4)
% T Call:  ( 12) estado_final(8)
% T Call:  ( 13) estado_final(16)
% T Call:  ( 13) estado_final(24)
% T Call:  ( 12) estado_final(12)
% T Call:  ( 13) estado_final(24)
% T Call:  ( 11) estado_final(6)
% T Call:  ( 12) estado_final(12)
% T Call:  ( 13) estado_final(24)
% T Call:  ( 12) estado_final(18)
% T Call:  ( 10) estado_final(3)
% T Call:  ( 11) estado_final(6)
% T Call:  ( 12) estado_final(12)
% T Call:  ( 13) estado_final(24)
% T Call:  ( 12) estado_final(18)
% T Call:  ( 11) estado_final(9)
% T Call:  ( 12) estado_final(18)
% T Call:  ( 12) estado_final(27)

% S = [1, 3, 9, 27]


% Yes
% ?- ['b-profundidad-con-cerrados.pl'].
% b-profundidad-con-cerrados.pl compiled, 0.03 sec, 0 bytes.

% Yes
% ?- profundidad_con_cerrados(S).
% T Call:  (  9) estado_final(1)
% T Call:  ( 10) estado_final(2)
% T Call:  ( 11) estado_final(4)
% T Call:  ( 12) estado_final(8)
% T Call:  ( 13) estado_final(16)
% T Call:  ( 14) estado_final(24)
% T Call:  ( 15) estado_final(12)
% T Call:  ( 16) estado_final(6)
% T Call:  ( 17) estado_final(18)
% T Call:  ( 18) estado_final(3)
% T Call:  ( 19) estado_final(9)
% T Call:  ( 20) estado_final(27)

% S = [1, 3, 9, 27]


% Yes
