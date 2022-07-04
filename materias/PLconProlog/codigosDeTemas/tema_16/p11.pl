vuela(X)   <- pajaro(X), not anormal(X).
anormal(X) <- avestruz(X).
pajaro(X)  <- avestruz(X).
pajaro(X)  <- palomo(X).

%******************************************************************************
% § Sesión
%******************************************************************************

% ?- [p9].
% Yes
% 
% ?- abduce(vuela(animal_1),E).
% E = [not anormal(animal_1), avestruz(animal_1)] ;
% E = [not anormal(animal_1), palomo(animal_1)] ;
% No
