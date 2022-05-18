% concatena_atomos.pl
% Concatenación de átomos.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 18-mayo-2022
% =============================================================================

% concatena_átomos(A1,A2,A3) se verifica si A3 es la concatenación de
% los átomos A1 y A2. Por ejemplo,
%    ?- concatena_átomos(pi,ojo,X).
%    X = piojo.
concatena_átomos(A1,A2,A3) :-
   name(A1,L1),
   name(A2,L2),
   append(L1,L2,L3),
   name(A3,L3).
