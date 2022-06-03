% GCD_recursiva_2.pl
% Gramática de cláusulas definidas con reglas recursivas (2).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 3-junio-2022
% ======================================================================

oración           -->  sintagma_nominal, sintagma_verbal.
oración           -->  oración, conjunción, oración.
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

% Reconocimiento de oraciones
% ===========================

% ?- oración([el,gato,come,pescado,o,el,perro,come,pescado],[]).
% true 
% 
% ?- oración([un,gato,come],[]).
% ERROR: Stack limit (1.0Gb) exceeded

