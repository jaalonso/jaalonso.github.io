% razonamiento_abductivo_general.pl
% Abducción para programas generales
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
   abducible(A),   
   \+ abduce_not(A,E,E).
abduce(\+ A,E0,E) :-
   \+ member(A,E0),
   abduce_not(A,E0,E).

abduce_not((A,B),E0,E) :- !,
   abduce_not(A,E0,E);
   abduce_not(B,E0,E).
abduce_not(A,E0,E) :-
   setof(B,(A <- B),L),
   abduce_not_l(L,E0,E).
abduce_not(A,E,E) :-
   member(\+ A,E).
abduce_not(A,E,[\+ A|E]) :-   
   \+ member(\+ A,E),   
   abducible(A),   
   \+ abduce(A,E,E).
abduce_not(\+ A,E0,E) :-
   \+ member(\+ A,E0),
   abduce(A,E0,E).

abduce_not_l([],E,E).
abduce_not_l([B|R],E0,E) :-
   abduce_not(B,E0,E1),
   abduce_not_l(R,E1,E).

abducible(A) :-
   A \= (\+ _X),
   \+ (A <- _B).

% Sesión
% ======

% ?- [razonamiento_abductivo_general, p8].
% true.
% 
% ?- abduce(vuela(animal_1),E).
% E = [\+avestruz(animal_1),palomo(animal_1)] ;
% false.

