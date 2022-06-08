% RA-99: meta_ampliado_e.pl
% Ejemplo del metaintérprete ampliado
%==============================================================================

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Operadores                                                                %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% `<-' es el `si' del nivel objeto 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% `;' es la disyunción en el nivel objeto 
:- op(1000, xfy, [&,;]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Ejemplo                                                                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vecino(X,Y) <- Y is X-1 ; Y is X+1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- ['meta_ampliado.pl'].
% Yes
% 
% ?- ['meta_ampliado_e.pl'].
% Yes
% 
% ?- prueba(vecino(2,3)).
% Yes
% 
% ?- prueba(vecino(3,2)).
% Yes
% 
% ?- trace.
% Yes
% 
% ?- prueba(vecino(2,3)).
%    Call:  (  8) prueba(vecino(2, 3)) ? 
%    Call:  (  9) predefinido(vecino(2, 3)) ? 
%    Fail:  (  9) predefinido(vecino(2, 3)) ? 
%    Redo:  (  8) prueba(vecino(2, 3)) ? 
%    Call:  (  9) vecino(2, 3)<-_L134 ? 
%    Exit:  (  9) vecino(2, 3)<-3 is 2-1;3 is 2+1 ? 
%    Call:  (  9) prueba( (3 is 2-1;3 is 2+1)) ? 
%    Call:  ( 10) prueba(3 is 2-1) ? 
%    Call:  ( 11) predefinido(3 is 2-1) ? 
%    Exit:  ( 11) predefinido(3 is 2-1) ? 
%  ^ Call:  ( 11) 3 is 2-1 ? 
%  ^ Fail:  ( 11) 3 is 2-1 ? 
%    Redo:  ( 10) prueba(3 is 2-1) ? 
%    Call:  ( 11) 3 is 2-1<-_L156 ? 
%    Fail:  ( 11) 3 is 2-1<-_L156 ? 
%    Fail:  ( 10) prueba(3 is 2-1) ? 
%    Redo:  (  9) prueba( (3 is 2-1;3 is 2+1)) ? 
%    Call:  ( 10) prueba(3 is 2+1) ? 
%    Call:  ( 11) predefinido(3 is 2+1) ? 
%    Exit:  ( 11) predefinido(3 is 2+1) ? 
%  ^ Call:  ( 11) 3 is 2+1 ? 
%  ^ Exit:  ( 11) 3 is 2+1 ? 
%    Exit:  ( 10) prueba(3 is 2+1) ? 
%    Exit:  (  9) prueba( (3 is 2-1;3 is 2+1)) ? 
%    Exit:  (  8) prueba(vecino(2, 3)) ? 
% Yes


