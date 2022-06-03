% GCD_numero.pl
% Concordancia en n�mero en gram�ticas de cl�usulas definidas.
% Jos� A. Alonso Jim�nez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

oraci�n              -->  sintagma_nominal(N), 
                          sintagma_verbal(N).
sintagma_nominal(N)  -->  nombre(N).
sintagma_nominal(N)  -->  art�culo(N), 
                          nombre(N).
sintagma_verbal(N)   -->  verbo(N),
                          sintagma_nominal(_).
art�culo(singular)   -->  [el].
art�culo(plural)     -->  [los].
nombre(singular)     -->  [gato].
nombre(plural)       -->  [gatos].
nombre(singular)     -->  [perro].
nombre(plural)       -->  [perros].
nombre(singular)     -->  [pescado].
nombre(singular)     -->  [carne].
verbo(singular)      -->  [come].
verbo(plural)        -->  [comen].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesi�n                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- phrase(oraci�n,[el,gato,come,pescado]).
% Yes
% 
% ?- phrase(oraci�n,[los,gato,come,pescado]).
% No
% 
% ?- phrase(oraci�n,[los,gatos,comen,pescado]).
% Yes
