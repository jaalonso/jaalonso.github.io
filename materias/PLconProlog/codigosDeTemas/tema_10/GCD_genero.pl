% GCD_genero.pl
% Concordancia de género en gramáticas de cláusulas definidas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla,  6-junio-2022
% ======================================================================

% phrase(oración,L) se verifica si L es una oración de la gramática con
% concordancia de género. Por ejemplo,
%    ?- phrase(oración,[el,gato,come,pescado]).
%    true 
%    
%    ?- phrase(oración,[la,gato,come,pescado]).
%    false.
%    
%    ?- phrase(oración,[la,gata,come,pescado]).
%    true 
oración             -->  sintagma_nominal, sintagma_verbal.
sintagma_nominal    -->  nombre(_).
sintagma_nominal    -->  artículo(G), nombre(G).
sintagma_verbal     -->  verbo, sintagma_nominal.
artículo(masculino) -->  [el].
artículo(femenino)  -->  [la].
nombre(masculino)   -->  [gato].
nombre(femenino)    -->  [gata].
nombre(masculino)   -->  [pescado].
verbo               -->  [come].

% El programa correspondiente es
%    ?- listing([oración,sintagma_nominal,sintagma_verbal,artículo,nombre,verbo]).
%    oración(A, B) :-
%        sintagma_nominal(A, C),
%        sintagma_verbal(C, B).
%    
%    sintagma_nominal(A, B) :-
%        nombre(_, A, B).
%    sintagma_nominal(A, B) :-
%        artículo(G, A, C),
%        nombre(G, C, B).
%    
%    sintagma_verbal(A, B) :-
%        verbo(A, C),
%        sintagma_nominal(C, B).
%    
%    artículo(masculino, [el|A], A).
%    artículo(femenino, [la|A], A).
%    
%    nombre(masculino, [gato|A], A).
%    nombre(femenino, [gata|A], A).
%    nombre(masculino, [pescado|A], A).
%    
%    verbo([come|A], A).
%    
%    true.
