% RA-99: meta_pa_e.pl
% Ejemplo para el metaintérprete con profundidad acotada.
% Ref.: Poole-98 p. 209
%==============================================================================

% `<-' es el `si' del nivel objeto 
:- op(1200, xfx, <-).

% `&' es la conjunción en el nivel objeto 
:- op(1000, xfy, &).

numero(0) <- verdad.
numero(s(X)) <- numero(X).

lista(0,[]) <- verdad.
lista(s(X),[a|L]) <-
   numero(s(X)) &
   lista(X,L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- ['meta_pa.pl','meta_pa_e.pl'].
% meta_pa.pl compiled, 0.02 sec, 808 bytes.
% meta_pa_e.pl compiled, 0.01 sec, 0 bytes.
% Yes
% 
% ?- prueba_pa(numero(N), 3).
% N = 0 ;
% N = s(0) ;
% N = s(s(0)) ;
% N = s(s(s(0))) ;
% No
% 
% ?- prueba_pa(numero(s(s(0))),1).
% No
% 
% ?- prueba_pa(numero(s(s(0))),2).
% Yes
% 
% ?- prueba_pa(lista(N, L), 3).
% N = 0        L = [] ;
% N = s(0)     L = [a] ;
% N = s(s(0))  L = [a, a] ;
% No
% 
% ?- call_with_depth_limit(prueba(numero(N)),5,R).
% N = 0           R = 2 ;
% N = s(0)        R = 3 ;
% N = s(s(0))     R = 4 ;
% N = s(s(s(0)))  R = 5 ;
% N = _G343       R = depth_limit_exceeded 
% Yes
% 
% ?- call_with_depth_limit(prueba(numero(s(s(0)))),3,R).
% R = depth_limit_exceeded
% Yes
% 
% ?- call_with_depth_limit(prueba(numero(s(s(0)))),4,R).
% R = 4 
% Yes
