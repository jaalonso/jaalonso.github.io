% GCD_genero.pl
% Concordancia de género en gramáticas de cláusulas definidas.
% José A. Alonso Jiménez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

oración             -->  sintagma_nominal, 
                         sintagma_verbal.
sintagma_nominal    -->  nombre(_).
sintagma_nominal    -->  artículo(G), 
                         nombre(G).
sintagma_verbal     -->  verbo, 
                         sintagma_nominal.
artículo(masculino) -->  [el].
artículo(femenino)  -->  [la].
nombre(masculino)   -->  [gato].
nombre(femenino)    -->  [gata].
nombre(masculino)   -->  [pescado].
verbo               -->  [come].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- phrase(oración,[el,gato,come,pescado]).
% Yes
% 
% ?- phrase(oración,[la,gato,come,pescado]).
% No
% 
% ?- phrase(oración,[la,gata,come,pescado]).
% Yes

% ?- listing([oración,sintagma_nominal,sintagma_verbal,artículo,nombre,verbo]).
% 
% oración(A, B) :-
%    sintagma_nominal(A, C),
%    sintagma_verbal(C, B).
% 
% sintagma_nominal(A, B) :-
%    nombre(C, A, B).
% sintagma_nominal(A, B) :-
%    artículo(C, A, D),
%    nombre(C, D, B).
% 
% sintagma_verbal(A, B) :-
%    verbo(A, C),
%    sintagma_nominal(C, B).
% 
% artículo(masculino, [el|A], A).
% artículo(femenino, [la|A], A).
% 
% nombre(masculino, [gato|A], A).
% nombre(femenino, [gata|A], A).
% nombre(masculino, [pescado|A], A).
% 
% verbo([come|A], A).
% 
% Yes
