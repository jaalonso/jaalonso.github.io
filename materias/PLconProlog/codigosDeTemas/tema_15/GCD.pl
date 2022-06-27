% GCD.pl
% Gramática de cláusulas definidas.
% José A. Alonso Jiménez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

oración           -->  sintagma_nominal, sintagma_verbal.
sintagma_nominal  -->  nombre.
sintagma_nominal  -->  artículo, nombre.
sintagma_verbal   -->  verbo, sintagma_nominal.
artículo          -->  [el].
nombre            -->  [gato].
nombre            -->  [perro].
nombre            -->  [pescado].
nombre            -->  [carne].
verbo             -->  [come].

% Programa correspondiente a la gramática
% =======================================

% ?- listing([oración,sintagma_nominal,sintagma_verbal,artículo,nombre,verbo]).
% oración(A, B) :-
%     sintagma_nominal(A, C),
%     sintagma_verbal(C, B).
% 
% sintagma_nominal(A, B) :-
%     nombre(A, B).
% sintagma_nominal(A, B) :-
%     artículo(A, C),
%     nombre(C, B).
% 
% sintagma_verbal(A, B) :-
%     verbo(A, C),
%     sintagma_nominal(C, B).
% 
% artículo([el|A], A).
% 
% nombre([gato|A], A).
% nombre([perro|A], A).
% nombre([pescado|A], A).
% nombre([carne|A], A).
% 
% verbo([come|A], A).
% 
% true.

% Reconocimiento de oraciones
% ===========================

% ?- oración([el,gato,come,pescado],[]).
% true 
% ?- oración([el,come,pescado],[]).
% false.

% Completación de oraciones
% =========================

% ?- oración([el,gato,X,pescado],[]).
% X = come ;
% false.
% 
% ?- oración([X,gato,Y,pescado],[]).
% X = el,
% Y = come ;
% false.

% Generación de categorías gramaticales
% =====================================

% ?- sintagma_nominal(L,[]).
% L = [gato] ;
% L = [perro] 

% Cálculos con phrase/2
% =====================

% ?- phrase(oración,[el,gato,come,pescado]).
% true 
% ?- phrase(oración,[el,come,pescado]).
% false.
% 
% ?- phrase(oración,[el,gato,X,pescado]).
% X = come ;
% false.
% 
% ?- phrase(oración,[X,gato,Y,pescado]).
% X = el,
% Y = come ;
% false.
% 
% ?- phrase(sintagma_nominal,L).
% L = [gato] ;
% L = [perro] 




