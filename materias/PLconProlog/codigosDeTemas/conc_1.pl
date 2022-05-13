% conc(A,B,C) se verifica si C es la lista obtenida escribiendo los
% elementos de la lista B a continuación de los elementos de la lista
% A. Por ejemplo,
%    ?- conc([a,b],[b,d],C).
%    C = [a, b, b, d] ;
%    false.
conc(A,B,C) :- A = [], C = B.
conc(A,B,C) :- A = [X|D], conc(D,B,E), C = [X|E].
