% musicos_1.pl
% Problema de los músicos.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 31-mayo-2022
% ======================================================================

% Se sabe que
% 1. Una banda está compuesta por tres músicos de distintos paises y que
%    tocan distintos instrumentos. 
% 2. El pianista toca primero.
% 3. Juan toca el saxo y toca antes que el cubano.
% 4. Marcos es ruso y toca antes que el flautista.
% 5. Hay un músico coreano.
% 6. Un músico se llama Luis.
% 
% Determinar el nombre, el país y el instrumento que toca cada uno de
% los músicos de la banda.

:- use_module(library(clpfd)).

músicos(Juan, Marco, Luis, Cuba, Rusia, Corea, Piano, Saxo, Flauta) :-
   % dominios
   [Juan, Marco, Luis, Cuba, Rusia, Corea, Piano, Saxo, Flauta] ins 1..3,

   % todas distintas de la de los otros:
   all_distinct([Juan, Marco, Luis]),
   all_distinct([Cuba, Rusia, Corea]),
   all_distinct([Piano, Saxo, Flauta]),
   
   % restricciones;
   Piano #=1,       % 2
   Juan #= Saxo,    % 3a
   Juan #< Cuba,    % 3b
   Marco #= Rusia,  % 4a
   Marco #< Flauta, % 4b

   % instancia las variables de la lista a elementos de su dominio:
   label([Juan, Marco, Luis, Cuba, Rusia, Corea, Piano, Saxo, Flauta]).

% Solución
%    ?- músicos(Juan, Marco, Luis, Cuba, Rusia, Corea, Piano, Saxo, Flauta).
%    Juan = Corea, Corea = Saxo, Saxo = 2,
%    Marco = Rusia, Rusia = Piano, Piano = 1,
%    Luis = Cuba, Cuba = Flauta, Flauta = 3.

% La solución es
%    +---+--------+-------+-------------+
%    |   | Nombre | País  | Instrumento |
%    +---+--------+-------+-------------+
%    | 1 | Marco  | Rusia | Piano       |
%    | 2 | Juan   | Corea | Saxo        |
%    | 3 | Luis   | Cuba  | Flauta      |
%    +---+--------+-------+-------------+

