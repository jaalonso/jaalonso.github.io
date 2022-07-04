% p7.pl
% Ejemplo para abducción.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla,  4-julio-2022
% ======================================================================

europeo(X) <- español(X).
español(X) <- andaluz(X).
europeo(X) <- italiano(X).

% Sesión
% ======

% ?- [razonamiento_abductivo, p7].
% true.
% 
% ?- abduce(europeo(juan),E).
% E = [andaluz(juan)] ;
% E = [italiano(juan)] ;
% false.

