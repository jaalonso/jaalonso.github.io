conc(A,B,C) :- A = [], C = B.
conc(A,B,C) :- A = [X|D], conc(D,B,E), C = [X|E].
