% reinas.pl
% Problema de las N reinas en CLP(FD).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 31-mayo-2022
% ======================================================================

:- use_module(library(clpfd)). 

% solución(N,L) se verifica si L es una solución del problema de las N
% reinas. Por ejemplo, 
%    ?- solución(4,L).
%    L = [2,4,1,3] ;
%    L = [3,1,4,2]
%    
%    ?- solución(8,L).
%    L = [1,5,8,6,3,7,2,4] ;
%    L = [1,6,8,3,7,4,2,5] 
%    
%    ?- findall(_S, solución(8, _S), _L), length(_L, N).
%    N = 92.
solución(N,L) :-             
   length(L,N),     % Hay N reinas
   L ins 1..N,      % Las ordenadas están en el intervalo 1..N
   all_distinct(L), % Las ordenadas son distintas (distintas filas)
   segura(L),       % No hay en más de una en las diagonales
   label(L).        % Buscar los valores de L

% segura(L) se verifica si las reinas colocadas en las ordenadas L no se
% atacan diagonalmente.  
segura([]).
segura([Y|L]) :-
   no_ataca(Y,L,1), 
   segura(L).

% no_ataca(Y,L,D) se verifica si Y es un número, L es una lista de
% números [n_1,...,n_m] y D es un número tales que las reinas colocada
% en la posición (x,Y) no ataca a las colocadas en las posiciones
% (x+d,n_1),..., (x+d+m,n_m). 
no_ataca(_Y,[],_).
no_ataca(Y1,[Y2|L],D) :-
   Y1-Y2 #\= D,
   Y2-Y1 #\= D,
   D1 is D+1,
   no_ataca(Y1,L,D1).
