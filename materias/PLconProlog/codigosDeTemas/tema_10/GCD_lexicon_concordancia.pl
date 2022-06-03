% GCD_lexicon_concordancia.pl
% Concordacia de género y número en GCD con llamadas.
% José A. Alonso Jiménez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Lexicón                                                                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Regla                                                                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

oración             --> sintagma_nominal(N), verbo(N), complemento.
complemento         --> [].
complemento         --> sintagma_nominal(_).
sintagma_nominal(N) --> nombre(_,N).
sintagma_nominal(N) --> determinante(G,N), nombre(G,N).
determinante(G,N)   --> [P],{lex(P,determinante,G,N)}.
nombre(G,N)         --> [P],{lex(P,nombre,G,N)}.
verbo(N)            --> [P],{lex(P,verbo,N)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- oración([la,profesora,lee,un,libro],[]).
% Yes
% ?- oración([la,profesor,lee,un,libro],[]).
% No
% ?- oración([los,profesores,leen,un,libro],[]).
% Yes
% ?- oración([los,profesores,leen],[]).
% Yes
% ?- oración([los,profesores,leen,libros],[]).
% Yes
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
