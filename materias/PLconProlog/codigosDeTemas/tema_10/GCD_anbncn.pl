% GCD_anbncn.pl
% GCD para un lenguaje formal a^nb^nc^n
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 6-junio-2022
% ======================================================================

% phrase(s,L) se verifica si L es una palabra del lenguaje
% a^nb^nc^n. Por ejemplo, 
%    ?- phrase(s,[a,a,b,b,c,c]).
%    true 
%    
%    ?- phrase(s,[a,a,b,b,b,c,c]).
%    false.
%    
%    ?- phrase(s,L).
%    L = [] ;
%    L = [a,b,c] ;
%    L = [a,a,b,b,c,c] ;
%    L = [a,a,a,b,b,b,c,c,c] 
s                --> bloque_a(N), bloque_b(N), bloque_c(N).
bloque_a(0)      --> [].
bloque_a(suc(N)) --> [a], bloque_a(N).
bloque_b(0)      --> [].
bloque_b(suc(N)) --> [b], bloque_b(N).
bloque_c(0)      --> [].
bloque_c(suc(N)) --> [c], bloque_c(N).
