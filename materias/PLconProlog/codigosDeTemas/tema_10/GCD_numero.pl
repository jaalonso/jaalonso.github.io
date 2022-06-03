% GCD_numero.pl
% Concordancia en número en gramáticas de cláusulas definidas.
% José A. Alonso Jiménez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

oración              -->  sintagma_nominal(N), 
                          sintagma_verbal(N).
sintagma_nominal(N)  -->  nombre(N).
sintagma_nominal(N)  -->  artículo(N), 
                          nombre(N).
sintagma_verbal(N)   -->  verbo(N),
                          sintagma_nominal(_).
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- phrase(oración,[el,gato,come,pescado]).
% Yes
% 
% ?- phrase(oración,[los,gato,come,pescado]).
% No
% 
% ?- phrase(oración,[los,gatos,comen,pescado]).
% Yes
