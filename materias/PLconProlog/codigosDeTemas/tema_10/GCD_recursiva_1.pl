% GCD_recursiva_1.pl
% Gramática de cláusulas definidas con reglas recursivas (1).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla,  3-junio-2022
% ======================================================================

% El objetivo es extender el ejemplo de GCD para aceptar oraciones
% como [el,gato,come,pescado,o,el,perro,come,pescado].

oración           -->  oración, conjunción, oración.
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
conjunción        -->  [y].
conjunción        -->  [o].

% Fallo en el reconocimiento de la oración
% ========================================

% ?- oración([el,gato,come,pescado,o,el,perro,come,pescado],[]).
% ERROR: Stack limit (1.0Gb) exceeded

% Programa correspondiente a oración
% ==================================

% ?- listing(oración).
% oración(A, B) :-
%     oración(A, C),
%     conjunción(C, D),
%     oración(D, B).
% oración(A, B) :-
%     sintagma_nominal(A, C),
%     sintagma_verbal(C, B).
% 
% true.

