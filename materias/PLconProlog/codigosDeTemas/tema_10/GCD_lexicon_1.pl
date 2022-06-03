% GCD_lexicon_1.pl
% Separaci�n de reglas y lexic�n.
% Jos� A. Alonso Jim�nez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Reglas                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

oraci�n           -->  sintagma_nominal, sintagma_verbal.
sintagma_nominal  -->  nombre.
sintagma_nominal  -->  art�culo, nombre.
sintagma_verbal   -->  verbo, sintagma_nominal.
art�culo          -->  [Palabra], {lex(Palabra,art�culo)}.
nombre            -->  [Palabra], {lex(Palabra,nombre)}.
verbo             -->  [Palabra], {lex(Palabra,verbo)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Lexic�n                                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lex(el,art�culo).
lex(gato,nombre).
lex(perro,nombre).
lex(pescado,nombre).
lex(carne,nombre).
lex(come,verbo).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Sesi�n                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- oraci�n([el,gato,come,pescado],[]).
% Yes
% ?- oraci�n([el,come,pescado],[]).
% No
% ?- oraci�n([el,gato,X,pescado],[]).
% X = come ;
% No
% ?- oraci�n([X,gato,Y,pescado],[]).
% X = el
% Y = come 
% Yes
% ?- sintagma_nominal(L,[]).
% L = [gato] ;
% L = [perro] 
% Yes


