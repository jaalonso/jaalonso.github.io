% GCD_genero_numero.pl
% Concordacia de género y número en GCD con llamadas.
% José A. Alonso Jiménez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

oración             --> sintagma_nominal(N),
                        verbo(N),
                        complemento.
complemento         --> [].
complemento         --> sintagma_nominal(_).
sintagma_nominal(N) --> nombre(_,N).
sintagma_nominal(N) --> determinante(G,N),
                        nombre(G,N).
verbo(N)            --> [P],{es_verbo(P,N)}.
nombre(G,N)         --> [P],{es_nombre(P,G,N)}.
determinante(G,N)   --> [P],{es_determinante(P,G,N)}.

es_nombre(profesor,masculino,singular).
es_nombre(profesores,masculino,plural).
es_nombre(profesora,femenino,singular).
es_nombre(profesoras,femenino,plural).
es_nombre(libro,masculino,singular).
es_nombre(libros,masculino,plural).

es_determinante(el,masculino,singular).
es_determinante(los,masculino,plural).
es_determinante(la,femenino,singular).
es_determinante(las,femenino,plural).
es_determinante(un,masculino,singular).
es_determinante(una,femenino,singular).
es_determinante(unos,masculino,plural).
es_determinante(unas,femenino,plural).

es_verbo(lee,singular).
es_verbo(leen,plural).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- phrase(oración,[la,profesora,lee,un,libro]).
% Yes
% ?- phrase(oración,[la,profesor,lee,un,libro]).
% No
% ?- phrase(oración,[los,profesores,leen,un,libro]).
% Yes
% ?- phrase(oración,[los,profesores,leen]).
% Yes
% ?- phrase(oración,[los,profesores,leen,libros]).
% Yes

% ?- listing([oración,complemento,sintagma_nominal,verbo,nombre,determinante]).
% 
% oración(A, B) :-
%    sintagma_nominal(C, A, D),
%    verbo(C, D, E),
%    complemento(E, B).
% 
% complemento(A, A).
% complemento(A, B) :-
%    sintagma_nominal(C, A, B).
% 
% sintagma_nominal(A, B, C) :-
%    nombre(D, A, B, C).
% sintagma_nominal(A, B, C) :-
%    determinante(D, A, B, E),
%    nombre(D, A, E, C).
% 
% verbo(A, B, C) :-
%    'C'(B, D, E),
%    es_verbo(D, A),
%    C=E.
% 
% nombre(A, B, C, D) :-
%    'C'(C, E, F),
%    es_nombre(E, A, B),
%    D=F.
% 
% determinante(A, B, C, D) :-
%    'C'(C, E, F),
%    es_determinante(E, A, B),
%    D=F.
% 
% Yes
