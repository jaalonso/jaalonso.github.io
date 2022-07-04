no_vuela(X) <- mamifero(X), \+ mamifero_volador(X).
vuela(X)    <- vampiro(X), \+ vampiro_no_volador(X).
no_vuela(X) <- muerto(X), \+ muerto_volador(X).

mamifero(X)      <- vampiro(X).
vampiro(dracula) <- true.
muerto(dracula)  <- true.

mamifero_volador(X)   <- vampiro(X).
vampiro_no_volador(X) <- muerto(X).

:- abolish(abducible,1).
abducible(mamifero_volador(_)).
abducible(vampiro_no_volador(_)).
abducible(muerto_volador(_)).

% Sesión
% ======

% ?- [razonamiento_abductivo_general, p9].
% true.
% 
% ?- abduce(vuela(X),E).
% false.
% 
% ?- abduce(no_vuela(X),E).
% X = dracula,
% E = [\+muerto_volador(dracula)] ;
% false.
