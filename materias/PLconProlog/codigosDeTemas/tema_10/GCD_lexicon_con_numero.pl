% GCD_lexicon_con_numero.pl
% Concordancia en número en GCD con llamadas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 6-junio-2022
% ======================================================================

% phrase(oración,L) se verifica si L es una oración de la siguiente
% gramática con concordancia en número en la que se han separado las
% reglas del lexicón. Por ejemplo. 
%    ?- phrase(oración,[el,gato,come,pescado]).
%    true 
%    
%    ?- phrase(oración,[los,gato,come,pescado]).
%    false.
%    
%    ?- phrase(oración,[los,gatos,comen,pescado]).
%    true 

% Las reglas son
oración             -->  sintagma_nominal(N), sintagma_verbal(N).
sintagma_nominal(N) -->  nombre(N).
sintagma_nominal(N) -->  artículo(N), nombre(N).
sintagma_verbal(N)  -->  verbo(N), sintagma_nominal(_).
artículo(N)         -->  [Palabra], {lex(Palabra,artículo,N)}.
nombre(N)           -->  [Palabra], {lex(Palabra,nombre,N)}.
verbo(N)            -->  [Palabra], {lex(Palabra,verbo,N)}.

% El lexicón es
lex(el,artículo,singular).
lex(los,artículo,plural).
lex(gato,nombre,singular).
lex(gatos,nombre,plural).
lex(perro,nombre,singular).
lex(perros,nombre,plural).
lex(pescado,nombre,singular).
lex(pescados,nombre,plural).
lex(carne,nombre,singular).
lex(carnes,nombre,plural).
lex(come,verbo,singular).
lex(comen,verbo,plural).
