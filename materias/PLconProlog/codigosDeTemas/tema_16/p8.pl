vuela(X)   <- pajaro(X), \+ anormal(X).
anormal(X) <- avestruz(X).
pajaro(X)  <- avestruz(X).
pajaro(X)  <- palomo(X).

% Sesión
% ======

% ?- [razonamiento_abductivo, p8].
% true.
% 
% ?- abduce(vuela(animal_1),E).
% E = [\+anormal(animal_1),avestruz(animal_1)] ;
% E = [\+anormal(animal_1),palomo(animal_1)] ;
% false.
