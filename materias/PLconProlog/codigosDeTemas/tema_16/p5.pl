defecto(((\+ vuela(X))  :- mamifero(X))).
defecto((vuela(X)       :- vampiro(X))).
defecto(((\+ vuela(X))  :- muerto(X))).

regla((mamifero(X)      :- vampiro(X))).
regla((vampiro(dracula) :- true)).
regla((muerto(dracula)  :- true)).

% Sesión
% ======

% ?- [p5, razonamiento_por_defecto].
% true.
% 
% ?- explica(vuela(dracula),E).
% E = [defecto((vuela(dracula):-vampiro(dracula))),
%      regla((vampiro(dracula):-true))] ;
% false.
% 
% ?- explica(\+ vuela(dracula),E).
% E = [defecto((not vuela(dracula):-mamifero(dracula))),
%      regla((mamifero(dracula):-vampiro(dracula))),
%      regla((vampiro(dracula):-true))] ;
% E = [defecto((not vuela(dracula):-muerto(dracula))),
%      regla((muerto(dracula):-true))] ;
% false.
