% razonamiento_abductivo.pl
% Metaintérprete para razonamiento abductivo.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla,  4-julio-2022
% ======================================================================

:- op(1200,xfx,<-).

abduce(O,E) :-
   abduce(O,[],E).

abduce(true,E,E) :- !.
abduce((A,B),E0,E) :- !,
   abduce(A,E0,E1),
   abduce(B,E1,E).
abduce(A,E0,E) :-
   (A <- B),
   abduce(B,E0,E).
abduce(A,E,E) :-
   member(A,E).
abduce(A,E,[A|E]) :-
   \+ member(A,E),
   abducible(A).   

abducible(A) :-
   \+ (A <- _B).

% Sesión
% ======

% ?- [razonamiento_abductivo, p7].
% true.
% 
% ?- abduce(europeo(juan),E).
% E = [andaluz(juan)] ;
% E = [italiano(juan)] ;
% false.
