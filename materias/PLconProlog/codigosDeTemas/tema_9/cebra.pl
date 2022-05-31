% cebra.pl
% Problema de las 5 casas y la cebra.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 31-mayo-2022
% ======================================================================

% Rompecabeza de Lewis Carroll
% ============================
%
% Cinco hombres de distintas nacionalidades viven en las cinco primeras
% casas de una calle. Cada uno tiene una profesión, un animal favorito y
% una bebida favorita (todas distintas de la de los otros).
% 
% Sabemos que 
%  1. El inglés vive en la casa roja.
%  2. El español tiene un perro.
%  3. El japonés es pintor.
%  4. El italiano bebe té.
%  5. El Noruego vive en la primera casa de la izquierda.
%  6. El propietario de la casa verde bebe café.
%  7. La casa verde está a la derecha de la blanca.
%  8. El escultor cria caracoles.
%  9. El diplomático vive en la casa amarilla.
% 10. En la casa central beben leche.
% 11. La casa del noruego está al lado de la casa azul.
% 12. El violinista bebe zumo de fruta.
% 13. El zorro está en la casa vecina de la del médico.
% 14. El caballo está en la casa vecina de la del diplomático.
% 
% Determinar dónde está la cebra y quién bebe agua. 

:- use_module(library(clpfd)).

cebra(Cebra, Agua, S) :-
   % Variables:
   S = [Nacionalidad, Color, Profesión, Animal, Bebida],
   Nacionalidad = [Inglés, Español, Japones, Italiano, Noruego],
   Color = [Roja, Verde, Blanca, Amarilla, Azul],
   Profesión = [Pintor, Escultor, Diplomático, Violinista, Doctor],
   Animal = [Perro, Caracol, Zorro, Caballo, Cebra],
   Bebida = [Te, Cafe, Leche, Zumo, Agua],
   flatten(S, L),

   % especificamos los dominios (el valor de cada variable es el número de la
   % casa): 
   % Nacionalidad in 1..5,
   % Color in 1..5,
   % Profesión in 1..5,
   % Animal in 1..5,
   % Bebida in 1..5,
   L ins 1..5,
   
   % todas distintas de la de los otros:
   all_distinct(Nacionalidad),
   all_distinct(Color),
   all_distinct(Profesión),
   all_distinct(Animal),
   all_distinct(Bebida),

   % restricciones:
   Inglés = Roja,                                      % 1
   Español = Perro,                                    % 2
   Japones = Pintor,                                   % 3
   Italiano = Te,                                      % 4
   Noruego = 1,                                        % 5
   Verde = Cafe,                                       % 6
   Verde #= Blanca + 1,                                % 7
   Escultor = Caracol,                                 % 8
   Diplomático = Amarilla,                             % 9
   Leche = 3,                                          % 10
   vecino(Noruego, Azul),                              % 11
   Violinista = Zumo,                                  % 12
   vecino(Zorro, Doctor),                              % 13
   vecino(Caballo, Diplomático),                       % 14

   % instancia las variables de la lista a elementos de su dominio:
   label(L).

vecino(X,Y) :-
   (X #= Y+1) #\/ (X #= Y-1). 

% Cálculo de la solución
%    ?- cebra(Cebra, Agua, S).
%    Cebra = 5,
%    Agua = 1,
%    S = [[3,4,5,2,1],
%         [3,5,4,1,2],
%         [5,3,1,4,2],
%         [4,3,1,2,5],
%         [2,5,3,4,1]] ;
%    false.
 
% La solución es
%    +---+--------------+----------+-------------+---------+--------+
%    |   | Nacionalidad | Color    | Profesión   | Animal  | Bebida |
%    +---+--------------+----------+-------------+---------+--------+
%    | 1 | Noruego      | Amarilla | Diplomático | Zorro   | Agua   |
%    | 2 | Italiano     | Azul     | Doctor      | Caballo | Te     |
%    | 3 | Inglés       | Roja     | Escultor    | Caracol | Leche  |
%    | 4 | Espagnol     | Blanca   | Violinista  | Perro   | Zumo   |
%    | 5 | Japones      | Verde    | Pintor      | Cebra   | Cafe   |
%    +---+--------------+----------+-------------+---------+--------+
