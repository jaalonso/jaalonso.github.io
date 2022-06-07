% pb_mentirosos.pl
% Problema de los mentirosos.
% Jos� A. Alonso Jim�nez <jalonso@us.es>
% Sevilla, 16 de Agosto de 2002
% =============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Enunciado                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% En una isla hay dos tribus, la de los veraces (que siempre dicen la verdad) y
% la de los mentirosos (que siempre mienten). Un viajero se encuentra con tres
% isle�os A, B y C y cada uno le dice una frase
%  * A dice "B y C son veraces syss C es veraz"
%  * B dice "Si A y B son veraces, entonces B y C son veraces y A es mentiroso"
%  * C dice "B es mentiroso syss A o B es veraz"
% Determinar a qu� tribu pertenecen A, B y C. [Burris-98 p. 72]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Representaci�n                                                          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Representaremos por a, b y c que A, B y C son veraces. Por tanto, -a, -b y -c
% representan que A, B y C son mentirosos.

:- ensure_loaded(sintaxis_semantica_prop).

ejemplo(mentirosos) :-
   modelos_conjunto([a <=> (b & c <=> c),
                     b <=> (a & c => b & c & -a),
                     c <=> (-b <=> a v b)],
                    L),
   L == [[ (a, 1), (b, 1), (c, 0)]] .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% � Sesi�n                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% :- time(verifica_modulo(pb_mentirosos)).
% 680 inferences in 0.00 seconds (Infinite Lips)

% Por tanto, A y B son veraces y C es mentiroso.
% LocalWords:  Burris
