% GCD_lexicon_1.pl
% Separación de reglas y lexicón.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 6-junio-2022
% ======================================================================

% phrase(oración,L) se verifica si L es una oración de la siguiente
% gramática en la que se han separado las reglas del lexicón. Por ejemplo.
%    ?- phrase(oración,[el,gato,come,pescado]).
%    true 
%    ?- phrase(oración,[el,come,pescado]).
%    false.
%    
%    ?- phrase(oración,[el,gato,X,pescado]).
%    X = come ;
%    false.
%    
%    ?- phrase(oración,[X,gato,Y,pescado]).
%    X = el,
%    Y = come ;
%    false.
%    
%    ?- phrase(sintagma_nominal,L).
%    L = [gato] ;
%    L = [perro] ;
%    L = [pescado] ;
%    L = [carne] ;
%    L = [el,gato] 
% Las reglas son
oración           -->  sintagma_nominal, sintagma_verbal.
sintagma_nominal  -->  nombre.
sintagma_nominal  -->  artículo, nombre.
sintagma_verbal   -->  verbo, sintagma_nominal.
artículo          -->  [Palabra], {lex(Palabra,artículo)}.
nombre            -->  [Palabra], {lex(Palabra,nombre)}.
verbo             -->  [Palabra], {lex(Palabra,verbo)}.
% El lexicón es
lex(el,artículo).
lex(gato,nombre).
lex(perro,nombre).
lex(pescado,nombre).
lex(carne,nombre).
lex(come,verbo).


