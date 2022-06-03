% GCD_lexicon_con_numero.pl
% Concordancia en número en GCD con llamadas.
% José A. Alonso Jiménez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Lexicón                                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Reglas                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

oración              -->  sintagma_nominal(N), sintagma_verbal(N).
sintagma_nominal(N)  -->  nombre(N).
sintagma_nominal(N)  -->  artículo(N), nombre(N).
sintagma_verbal(N)   -->  verbo(N), sintagma_nominal(_).
artículo(N)          -->  [Palabra], {lex(Palabra,artículo,N)}.
nombre(N)            -->  [Palabra], {lex(Palabra,nombre,N)}.
verbo(N)             -->  [Palabra], {lex(Palabra,verbo,N)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- oración([el,gato,come,pescado],[]).
% Yes
% ?- oración([los,gato,come,pescado],[]).
% No
% ?- oración([los,gatos,comen,pescado],[]).
% Yes

