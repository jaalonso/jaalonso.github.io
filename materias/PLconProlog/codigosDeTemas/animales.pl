% animales.pl
%==============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Base de conocimiento                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% * Base de reglas:
%   * R1: Si un animal es ungulado y tiene rayas negras, entonces es una cebra.
%   * R2: Si un animal rumia y es mamífero, entonces es ungulado.
%   * R3: Si un animal es mamífero y tiene pezuñas, entonces es ungulado.
%
% * Base de hechos:
%   * H1: El animal es mamífero.
%   * H2: El animal tiene pezuñas.
%   * H3: El animal tiene rayas negras.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Programa                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- dynamic rumia/0.

es_cebra :-
   es_ungulado,
   tiene_rayas_negras.

es_ungulado :-
   rumia,
   es_mamifero.

es_ungulado :-
   es_mamifero,
   tiene_pezuñas.

es_mamifero.
tiene_pezuñas.
tiene_rayas_negras.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Sesión                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- [animales].
% true.
%
% ?- es_cebra.
% true.
%
% ?- trace.
% true.
%
% [trace]  ?- es_cebra.
%    Call: (10) es_cebra ?
%    Call: (11) es_ungulado ?
%    Call: (12) rumia ?
%    Fail: (12) rumia ?
%    Redo: (11) es_ungulado ?
%    Call: (12) es_mamifero ?
%    Exit: (12) es_mamifero ?
%    Call: (12) tiene_pezuñas ?
%    Exit: (12) tiene_pezuñas ?
%    Exit: (11) es_ungulado ?
%    Call: (11) tiene_rayas_negras ?
%    Exit: (11) tiene_rayas_negras ?
%    Exit: (10) es_cebra ?
% true.
%
% [trace]  ?- nodebug.
% true.
%
% ?- es_cebra.
% true.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Demostración                                                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
    :- es_cebra.               es_cebra :-
                                 es_ungulado,
                                 tiene_rayas_negras.

    :- es_ungulado,            es_ungulado :-
       tiene_rayas_negras.        es_mamifero,
                                  tiene_pezuñas.

    :- es_mamifero,            es_mamifero.
       tiene_pezuñas,
       tiene_rayas_negras.

    :- tiene_pezuñas,          tiene_pezuñas.
       tiene_rayas_negras.

    :- tiene_rayas_negras.     tiene_rayas_negras.

    :-.
*/
