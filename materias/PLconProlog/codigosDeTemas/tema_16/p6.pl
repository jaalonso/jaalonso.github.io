defecto(mamiferos_no_vuelan(X),(\+ vuela(X)   :- mamifero(X))).
defecto(vampiros_vuelan(X),    (vuela(X)       :- vampiro(X))).
defecto(muertos_no_vuelan(X),  (\+ vuela(X)   :- muerto(X))).

regla((mamifero(X)      :- vampiro(X))).
regla((vampiro(dracula) :- true)).
regla((muerto(dracula)  :- true)).

regla((\+ mamiferos_no_vuelan(X) :- vampiro(X))).
regla((\+ vampiros_vuelan(X)     :- muerto(X))).

% Sesión
% ======

% ?- [p6, razonamiento_por_defecto_con_nombres].
% true.
% 
% ?- explica(vuela(dracula),E).
% false.
% 
% ?- explica(\+ vuela(dracula),E).
% E = [defecto(muertos_no_vuelan(dracula)),
%      regla((muerto(dracula):-true))] ;
% false.
