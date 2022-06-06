% GCD_numero.pl
% Concordancia en número en gramáticas de cláusulas definidas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla,  6-junio-2022
% ======================================================================

% phrase(oración,L) se verifica si L es una oración de la gramática con
% concordancia en número. Por ejemplo,
%    ?- phrase(oración,[el,gato,come,pescado]).
%    true 
%    
%    ?- phrase(oración,[los,gato,come,pescado]).
%    false.
%    
%    ?- phrase(oración,[los,gatos,comen,pescado]).
%    true 
oración              -->  sintagma_nominal(N), sintagma_verbal(N).
sintagma_nominal(N)  -->  nombre(N).
sintagma_nominal(N)  -->  artículo(N), nombre(N).
sintagma_verbal(N)   -->  verbo(N), sintagma_nominal(_).
artículo(singular)   -->  [el].
artículo(plural)     -->  [los].
nombre(singular)     -->  [gato].
nombre(plural)       -->  [gatos].
nombre(singular)     -->  [perro].
nombre(plural)       -->  [perros].
nombre(singular)     -->  [pescado].
nombre(singular)     -->  [carne].
verbo(singular)      -->  [come].
verbo(plural)        -->  [comen].
