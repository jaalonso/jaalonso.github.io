% diagnosticador_abductivo.pl
% Diagnosticador abductivo.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 4-julio-2022
% ======================================================================

diagnostico(Observacion,Diagnostico) :-
   abduce(Observacion,Diagnostico).

:- abolish(abducible,2).
abducible(fallo(_X)).

diagnostico_minimo(O,D) :-
   diagnostico(O,D),
   \+ ((diagnostico(O,D1),
        subconjunto_propio(D1,D))).

subconjunto_propio([],Ys):-
   Ys \= [].
subconjunto_propio([X|Xs],Ys):-
   select(Ys,X,Ys1),
   subconjunto_propio(Xs,Ys1).

