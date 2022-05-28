% orden_literales_y_respuesta.pl
% Influencia del orden de los literales en la respuesta.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 21-mayo-2022
% =============================================================================

siguiente(a,1).
siguiente(1,b).

sucesor_1(X,Y) :-
   siguiente(X,Y).
sucesor_1(X,Y) :-
   siguiente(X,Z),
   sucesor_1(Z,Y).

sucesor_2(X,Y) :-
   siguiente(X,Y).
sucesor_2(X,Y) :-
   sucesor_2(Z,Y),
   siguiente(X,Z).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% § Sesión                                                                  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- sucesor_1(X,Y).
% X = a
% Y = 1 ;
% X = 1
% Y = b ;
% X = a
% Y = b ;
% false.
%
% ?- sucesor_2(X,Y).
% X = a
% Y = 1 ;
% X = 1
% Y = b ;
% X = a
% Y = b ;
% ERROR: Stack limit (1.0Gb) exceeded
%
% ?- findall(X-Y,sucesor_1(X,Y),L).
% L = [a-1, 1-b, a-b].
%
% ?- findall(X-Y,sucesor_2(X,Y),L).a
% ERROR: Stack limit (1.0Gb) exceeded
