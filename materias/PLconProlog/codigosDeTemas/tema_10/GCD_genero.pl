% GCD_genero.pl
% Concordancia de g�nero en gram�ticas de cl�usulas definidas.
% Jos� A. Alonso Jim�nez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

oraci�n             -->  sintagma_nominal, 
                         sintagma_verbal.
sintagma_nominal    -->  nombre(_).
sintagma_nominal    -->  art�culo(G), 
                         nombre(G).
sintagma_verbal     -->  verbo, 
                         sintagma_nominal.
art�culo(masculino) -->  [el].
art�culo(femenino)  -->  [la].
nombre(masculino)   -->  [gato].
nombre(femenino)    -->  [gata].
nombre(masculino)   -->  [pescado].
verbo               -->  [come].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesi�n                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- phrase(oraci�n,[el,gato,come,pescado]).
% Yes
% 
% ?- phrase(oraci�n,[la,gato,come,pescado]).
% No
% 
% ?- phrase(oraci�n,[la,gata,come,pescado]).
% Yes

% ?- listing([oraci�n,sintagma_nominal,sintagma_verbal,art�culo,nombre,verbo]).
% 
% oraci�n(A, B) :-
%    sintagma_nominal(A, C),
%    sintagma_verbal(C, B).
% 
% sintagma_nominal(A, B) :-
%    nombre(C, A, B).
% sintagma_nominal(A, B) :-
%    art�culo(C, A, D),
%    nombre(C, D, B).
% 
% sintagma_verbal(A, B) :-
%    verbo(A, C),
%    sintagma_nominal(C, B).
% 
% art�culo(masculino, [el|A], A).
% art�culo(femenino, [la|A], A).
% 
% nombre(masculino, [gato|A], A).
% nombre(femenino, [gata|A], A).
% nombre(masculino, [pescado|A], A).
% 
% verbo([come|A], A).
% 
% Yes
