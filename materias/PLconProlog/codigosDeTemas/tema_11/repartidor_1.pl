% repartidor_1.pl
% Axiomatización del plano del robot repatidos.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 22-junio-2022
% ======================================================================

% vecina_izquierda(H1,H2) se verifica si la habitación H1 es la vecina
% izquierda de la habitación H2. Por ejemplo,
%    ?- vecina_izquierda(h105,h107).
%    true.
%    ?- vecina_izquierda(h106,h107).
%    false.
%    ?- vecina_izquierda(X,h107).
%    X = h105.
%    ?- vecina_izquierda(h105,X).
%    X = h107.
%    ?- vecina_izquierda(h106,X).
%    false.
vecina_izquierda(h101,h103).
vecina_izquierda(h103,h105).
vecina_izquierda(h105,h107).
vecina_izquierda(h107,h109).
vecina_izquierda(h109,h111).
vecina_izquierda(h131,h129).
vecina_izquierda(h129,h127).
vecina_izquierda(h127,h125).

% vecina_derecha(H1,H2) se verifica si la habitación H2 es la vecina
% derecha de la habitación H1. Por ejemplo,
%    ?- vecina_derecha(h105,X).
%    X = h103.
vecina_derecha(H1,H2) :- 
   vecina_izquierda(H2,H1).

% vecina(H1,H2) se verifica si la habitación H1 es vecina de la
% habitación H2. Por ejemplo,
%    ?- vecina(X,h105).
%    X = h107 ;
%    X = h103.
vecina(H1,H2) :-
   vecina_derecha(H1,H2).
vecina(H1,H2) :-
   vecina_izquierda(H1,H2).

% dos_a_la_derecha(H1,H2) se verifica si la habitación H1 está dos a la
% derecha de la habitación H2.  Por ejemplo,
%    ?- dos_a_la_derecha(X,h105).
%    X = h109 
dos_a_la_derecha(H1,H2) :-
   vecina_derecha(H1,H),
   vecina_derecha(H,H2).

% a_la_izquierda(H1,H2) se verifica si la habitación H1 está a la
% izquierda de la habitación H2. Por ejemplo, 
%    ?- a_la_izquierda(X,h105).
%    X = h103 ;
%    X = h101 ;
%    false.
a_la_izquierda(H1,H2) :-
   vecina_izquierda(H1,H2).
a_la_izquierda(H1,H2) :-
   vecina_izquierda(H1,H),
   a_la_izquierda(H,H2).
