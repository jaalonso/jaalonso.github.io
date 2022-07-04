no_vuela(X) <- mamifero(X), not mamifero_volador(X).
vuela(X)    <- vampiro(X), not vampiro_no_volador(X).
no_vuela(X) <- muerto(X), not muerto_volador(X).

mamifero(X)      <- vampiro(X).
vampiro(dracula) <- true.
muerto(dracula)  <- true.

mamifero_volador(X)   <- vampiro(X).
vampiro_no_volador(X) <- muerto(X).

:- abolish(abducible,1).
abducible(mamifero_volador(_)).
abducible(vampiro_no_volador(_)).
abducible(muerto_volador(_)).

%******************************************************************************
% § Sesión
%******************************************************************************

% ?- [p12].
% Yes
% 
% ?- abduce(vuela(X),E).
% No
% 
% ?- abduce(no_vuela(X),E).
% X = dracula
% E = [not muerto_volador(dracula)] ;
% No
