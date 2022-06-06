% GCD_lexicon_concordancia.pl
% Concordacia de género y número en GCD con llamadas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 6-junio-2022
% ======================================================================

% phrase(oración,L) se verifica si L es una oración de la siguiente
% gramática (con concordancia en género y número) en la que se han
% separado las reglas del lexicón. Por ejemplo. 
%    ?- phrase(oración,[la,profesora,lee,un,libro]).
%    true.
%    
%    ?- phrase(oración,[la,profesor,lee,un,libro]).
%    false.
%    
%    ?- phrase(oración,[los,profesores,leen,un,libro]).
%    true.
%    
%    ?- phrase(oración,[los,profesores,leen]).
%    true 
%    
%    ?- phrase(oración,[los,profesores,leen,libros]).
%    true 

% Lexicón                                                                 %%
% =======

lex(el,determinante,masculino,singular).
lex(los,determinante,masculino,plural).
lex(la,determinante,femenino,singular).
lex(las,determinante,femenino,plural).
lex(un,determinante,masculino,singular).
lex(una,determinante,femenino,singular).
lex(unos,determinante,masculino,plural).
lex(unas,determinante,femenino,plural).

lex(profesor,nombre,masculino,singular).
lex(profesores,nombre,masculino,plural).
lex(profesora,nombre,femenino,singular).
lex(profesoras,nombre,femenino,plural).
lex(libro,nombre,masculino,singular).
lex(libros,nombre,masculino,plural).

lex(lee,verbo,singular).
lex(leen,verbo,plural).

% Reglas
% =====

oración             --> sintagma_nominal(N), verbo(N), complemento.
complemento         --> [].
complemento         --> sintagma_nominal(_).
sintagma_nominal(N) --> nombre(_,N).
sintagma_nominal(N) --> determinante(G,N), nombre(G,N).
determinante(G,N)   --> [P],{lex(P,determinante,G,N)}.
nombre(G,N)         --> [P],{lex(P,nombre,G,N)}.
verbo(N)            --> [P],{lex(P,verbo,N)}.
