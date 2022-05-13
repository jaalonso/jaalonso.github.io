% ejemplo_operadores.pl
% Ejemplo de definición de operadores.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 13-mayo-2022
% =============================================================================

:-op(800,xfx,estudian).
:-op(400,xfx,y).

juan y ana estudian lógica.

% Consultas
% =========

% ?- Quienes estudian lógica.
% Quienes = juan y ana.
%
% ?- juan y Otro estudian Algo.
% Otro = ana,
% Algo = lógica.
