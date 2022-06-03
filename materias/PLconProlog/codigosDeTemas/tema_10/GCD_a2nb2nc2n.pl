% GCD_a2nb2nc2n.pl
% GCD con llamadas a Prolog.
% José A. Alonso Jiménez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

s              --> bloque_a(N), bloque_b(N), bloque_c(N), {par(N)}.
bloque_a(0)    --> [].
bloque_a(s(N)) --> [a],bloque_a(N).
bloque_b(0)    --> [].
bloque_b(s(N)) --> [b],bloque_b(N).
bloque_c(0)    --> [].
bloque_c(s(N)) --> [c],bloque_c(N).

par(0).
par(s(s(N))) :- par(N).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Sesión                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- s([a, a, b, b, c, c],[]).
% Yes
% ?- s([a, b, c],[]).
% No
% 
% ?- s(X,[]).
% X = [] ;
% X = [a, a, b, b, c, c] ;
% X = [a, a, a, a, b, b, b, b, c, c, c, c] ;
% X = [a, a, a, a, a, a, b, b, b, b, b, b, c, c, c, c, c, c] 
% Yes
