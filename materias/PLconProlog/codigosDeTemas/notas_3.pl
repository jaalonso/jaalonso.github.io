nota(X,Y) :-
   X < 5 -> Y = suspenso ;            % R1
   X < 7 -> Y = aprobado ;            % R2
   X < 9 -> Y = notable ;             % R3
   true  -> Y = sobresaliente.        % R4
