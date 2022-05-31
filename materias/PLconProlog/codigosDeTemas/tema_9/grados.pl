% grados.pl
% Conversion de grados centígrados a Fahrenheit en LP y CLP.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 30-mayo-2022
% ======================================================================

:- use_module(library(clpr)).

% convierte_1(-C,+F) se verifica si C son los grados centígrados
% correspondientes a F grados Fahrenheit. Por ejemplo,
%    ?- convierte_1(C,95).
%    C = 35.
%    
%    ?- convierte_1(35,F).
%    ERROR: Arguments are not sufficiently instantiated
convierte_1(C,F) :-
   C is (F-32)*5/9.

% convierte_2(C,F) se verifica si C son los grados centígrados
% correspondientes a F grados Fahrenheit. Por ejemplo,
%    ?- convierte_2(C,95).
%    C = 35.0 
%    ?- convierte_2(35,F).
%    F = 95.0 
%    ?- convierte_2(C,F).
%    {F=32.0+1.7999999999999998*C}.
convierte_2(C,F) :-
   {C = (F-32)*5/9}.
