% criptoaritmetica.pl
% Problemas de criptoaritmética con CLP(FD).
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 31-mayo-2022
% ======================================================================

:- use_module(library(clpfd)).

% El problema DONAL+GERALD=ROBERT
% ===============================

% solución_1([D,O,N,A,L,D], [G,E,R,A,L,D], [R,O,B,E,R,T]) se verifica si
% cada una de las letras se sustituye por un dígito distinto de forma
% que DONALD+GERALD=ROBERT. Por ejemplo, 
%    ?- solución_1(L1,L2,L3).
%    L1 = [5,2,6,4,8,5],
%    L2 = [1,9,7,4,8,5],
%    L3 = [7,2,3,9,7,0] ;
%    false.
%    
%    ?- solución_1([D,O,N,A,L,D], [G,E,R,A,L,D], [R,O,B,E,R,T]).
%    D = 5,
%    O = 2,
%    N = 6,
%    A = 4,
%    L = 8,
%    G = 1,
%    E = 9,
%    R = 7,
%    B = 3,
%    T = 0 ;
%    false. 
solución_1([D,O,N,A,L,D], [G,E,R,A,L,D], [R,O,B,E,R,T])  :-
   Vars = [D,O,N,A,L,G,E,R,B,T],            % Las variables
   Vars ins 0..9,                            % Los valores son los dígitos
   all_distinct(Vars),                     % Los valores son distintos
   100000*D+10000*O+1000*N+100*A+10*L+D +   % Suma
   100000*G+10000*E+1000*R+100*A+10*L+D #=
   100000*R+10000*O+1000*B+100*E+10*R+T,
   labeling([min],Vars).

% Problema ABC + ABC + ABC = BBB
% ==============================

% solución_2([A,B,C],[A,B,C],[A,B,C],[B,B,B]) se verifica si cada una de
% las letras se sustituye por un dígito distinto de forma que
% ABC+ABC+ABC=BBB. Por ejemplo,  
%    ?- solución_2(L1,L2,L3,L4).
%    L1 = L2, L2 = L3, L3 = [1,4,8],
%    L4 = [4,4,4] .
%    ?- solución_2([A,B,C],[A,B,C],[A,B,C],[B,B,B]).
%    A = 1,
%    B = 4,
%    C = 8. 
solución_2([A,B,C],[A,B,C],[A,B,C],[B,B,B]) :-
   Vars = [A,B,C],      % Las variables
   Vars ins 0..9,        % Los valores son los dígitos
   all_distinct(Vars), % Los valores son distintos
   100*A+10*B+C +       % Suma
   100*A+10*B+C +   
   100*A+10*B+C #=
   100*B+10*B+B,
   label(Vars).

% El problema ABCDE * 4 = EDCBA
% =============================

% solución_3(A,B,C,D,E) se verifica si cada una de las letras se
% sustituye por un dígito distinto de forma que ABCDE * 4 = EDCBA. Por
% ejemplo,   
%    ?- solución_3(L).
%    L = [2,1,9,7,8] ;
%    false.
solución_3([A,B,C,D,E]) :-
   Vars = [A,B,C,D,E],
   Vars ins 0..9,                         % Los valores son los dígitos
   all_distinct(Vars),                  % Los valores son distintos
      (10000*A+1000*B+100*C+10*D+E) *  4
   #=  10000*E+1000*D+100*C+10*B+A,
   label(Vars).

% El problema CUATRO * 5 = VEINTE
% ===============================

% solución_4([C,U,A,T,R,O],[V,E,I,N,T,E]) se verifica si cada una de las
% letras se sustituye por un dígito distinto de forma que
% CUATRO * 5 = VEINTE. Por ejemplo,  
%    ?- solución_4(L1, L2).
%    L1 = [1,7,0,4,6,9],
%    L2 = [8,5,2,3,4,5] ;
%    false.
%    
%    ?- solución_4([C,U,A,T,R,O],[V,E,I,N,T,E]).
%    C = 1,
%    U = 7,
%    A = 0,
%    T = 4,
%    R = 6,
%    O = 9,
%    V = 8,
%    E = 5,
%    I = 2,
%    N = 3 ;
%    false.
solución_4([C,U,A,T,R,O],[V,E,I,N,T,E]) :-
   Vars = [C,U,A,T,R,O,V,E,I,N],
   Vars ins 0..9,                                 % Los valores son los dígitos
   all_distinct(Vars),                          % Los valores son distintos
      (100000*C+10000*U+1000*A+100*T+10*R+O) * 5
   #=  100000*V+10000*E+1000*I+100*N+10*T+E,
   label(Vars).

% El problema SEND + MORE = MONEY
% ===============================

% solución_5([S,E,N,D],[M,O,R,E],[M,O,N,E,Y]) se verifica si cada una de
% las letras se sustituye por un dígito distinto de forma que
% SEND+MORE=MONEY. Por ejemplo,
%    ?- solución_5(L1,L2,L3).
%    L1 = [9,5,6,7],
%    L2 = [1,0,8,5],
%    L3 = [1,0,6,5,2] ;
%    false.
%    
%    ?- solución_5([S,E,N,D],[M,O,R,E],[M,O,N,E,Y]).
%    S = 9,
%    E = 5,
%    N = 6,
%    D = 7,
%    M = 1,
%    O = 0,
%    R = 8,
%    Y = 2 ;
%    false.
solución_5([S,E,N,D],[M,O,R,E],[M,O,N,E,Y]) :-
   Vars = [S,E,N,D,M,O,R,Y],
   Vars ins 0..9,
   all_distinct(Vars),
           1000*S+100*E+10*N+D
         + 1000*M+100*O+10*R+E #=
   10000*M+1000*O+100*N+10*E+Y,
   M #\= 0,
   S #\= 0,
   label(Vars).

