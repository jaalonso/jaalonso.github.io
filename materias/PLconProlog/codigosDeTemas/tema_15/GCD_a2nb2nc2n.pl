% GCD_a2nb2nc2n.pl
% GCD con llamadas a Prolog.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 6-junio-2022
% ======================================================================

% phrase(s,L) se verifica si L es una palabra del lenguaje
% a^nb^nc^n, con n un número par. Por ejemplo, 
%    ?- phrase(s, [a, a, b, b, c, c]).
%    true 
%    
%    ?- phrase(s, [a, b, c]).
%    false.
%    
%    ?- phrase(s, L).
%    L = [] ;
%    L = [a,a,b,b,c,c] ;
%    L = [a,a,a,a,b,b,b,b,c,c,c,c] 
s              --> bloque_a(N), bloque_b(N), bloque_c(N), {par(N)}.
bloque_a(0)    --> [].
bloque_a(s(N)) --> [a],bloque_a(N).
bloque_b(0)    --> [].
bloque_b(s(N)) --> [b],bloque_b(N).
bloque_c(0)    --> [].
bloque_c(s(N)) --> [c],bloque_c(N).

par(0).
par(s(s(N))) :- par(N).
