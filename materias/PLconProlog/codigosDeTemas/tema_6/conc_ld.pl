% conc_ld.pl
% Concatenación con listas de diferencias.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

% conc(A,B,C) se verifica si C es la lista obtenida escribiendo los
% elementos de la lista B a continuación de los elementos de la lista
% A. Por ejemplo,
%    ?- conc([a,b],[b,d],C).
%    C = [a, b, b, d].

% 1ª definición
% =============

conc_1([],L,L).
conc_1([X|L1],L2,[X|L3]) :-
   conc_1(L1,L2,L3).

% 2ª definición (con lista de diferencia)
% =======================================

conc_ld(A-B,B-C,A-C).

% ?- conc_ld([a,b|RX]-RX,[c,d|RY]-RY,Z-[]).
% RX = [c, d],
% RY = [],
% Z = [a, b, c, d].
%
% ?- conc_ld([a,b|_RX]-_RX,[c,d|_RY]-_RY,Z-[]).
% Z = [a, b, c, d].


% Comparación de eficiencia
% =========================

% ?- time(conc_1([1,2,3,4,5,6,7],[8,9],L)).
% % 7 inferences, 0.000 CPU in 0.000 seconds (81% CPU, 275645 Lips)
% L = [1, 2, 3, 4, 5, 6, 7, 8, 9].
%
% ?- time(conc_ld([1,2,3,4,5,6,7|_X]-_X,[8,9|_Y]-_Y,L-[])).
% % 0 inferences, 0.000 CPU in 0.000 seconds (80% CPU, 0 Lips)
% L = [1, 2, 3, 4, 5, 6, 7, 8, 9].
