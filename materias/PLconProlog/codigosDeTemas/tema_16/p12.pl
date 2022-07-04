% Abducción para programas generales
%==============================================================================

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
	not member(A,E),
	abducible(A),	
	not abduce_not(A,E,E).
abduce(not(A),E0,E) :-
	not member(A,E0),
	abduce_not(A,E0,E).


abduce_not((A,B),E0,E) :- !,
	abduce_not(A,E0,E);
	abduce_not(B,E0,E).
abduce_not(A,E0,E) :-
	setof(B,(A <- B),L),
	abduce_not_l(L,E0,E).
abduce_not(A,E,E) :-
	member(not(A),E).
abduce_not(A,E,[not(A)|E]) :-	
	not member(not(A),E),	
	abducible(A),	
	not abduce(A,E,E).
abduce_not(not(A),E0,E) :-
	not member(not(A),E0),
	abduce(A,E0,E).

abduce_not_l([],E,E).
abduce_not_l([B|R],E0,E) :-
	abduce_not(B,E0,E1),
	abduce_not_l(R,E1,E).

abducible(A) :-
	A \= not(_X),
	not (A <- _B).

