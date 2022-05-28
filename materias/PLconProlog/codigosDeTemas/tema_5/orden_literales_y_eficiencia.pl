% orden_literales_y_eficiencia.pl
% Influencia del orden de los literales en la eficiencia.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

crea(X) :-
   between(1, X, N),
   assertz(numero(N)),
   N = X,
   Y is X // 100,
   between(1, Y, M),
   M1 is M*100,
   assertz(multiplo_de_100(M1)),
   M = Y.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- crea(1000).
% true.
%
% ?- listing(numero).
% numero(1). numero(2). ... numero(1000).
% true.
%
% ?- listing(multiplo_de_100).
% multiplo_de_100(100). ... multiplo_de_100(1000).
% true.
%
% ?- time((numero(_N),multiplo_de_100(_N))).
% % 100 inferences, 0.000 CPU in 0.000 seconds (96% CPU, 7135721 Lips)
% true
%
% ?- time((multiplo_de_100(_N),numero(_N))).
% % 0 inferences, 0.000 CPU in 0.000 seconds (100% CPU, 0 Lips)
% true
