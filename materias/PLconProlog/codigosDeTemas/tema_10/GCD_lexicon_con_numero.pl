% GCD_lexicon_con_numero.pl
% Concordancia en n�mero en GCD con llamadas.
% Jos� A. Alonso Jim�nez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Lexic�n                                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lex(el,art�culo,singular).
lex(los,art�culo,plural).
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
%% � Reglas                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

oraci�n              -->  sintagma_nominal(N), sintagma_verbal(N).
sintagma_nominal(N)  -->  nombre(N).
sintagma_nominal(N)  -->  art�culo(N), nombre(N).
sintagma_verbal(N)   -->  verbo(N), sintagma_nominal(_).
art�culo(N)          -->  [Palabra], {lex(Palabra,art�culo,N)}.
nombre(N)            -->  [Palabra], {lex(Palabra,nombre,N)}.
verbo(N)             -->  [Palabra], {lex(Palabra,verbo,N)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesi�n                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- oraci�n([el,gato,come,pescado],[]).
% Yes
% ?- oraci�n([los,gato,come,pescado],[]).
% No
% ?- oraci�n([los,gatos,comen,pescado],[]).
% Yes

