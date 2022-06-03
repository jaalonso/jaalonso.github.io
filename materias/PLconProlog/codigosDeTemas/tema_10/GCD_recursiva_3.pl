% GCD_recursiva_3.pl
% Gramática de cláusulas definidas con reglas recursivas (3).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 3-junio-2022
% ======================================================================

oración           -->  oración_simple.
oración           -->  oración_simple, conjunción, oración.
oración_simple    -->  sintagma_nominal, sintagma_verbal.
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
% false.

