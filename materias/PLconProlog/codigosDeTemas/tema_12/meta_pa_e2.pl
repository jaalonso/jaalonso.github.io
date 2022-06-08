% RA-99: meta_pa_e2.pl
% Ejemplo para el metaintérprete con profundidad acotada.
%==============================================================================

% `<-' es el `si' del nivel objeto 
:- op(1200, xfx, <-).

% `&' es la conjunción en el nivel objeto 
:- op(1000, xfy, &).

hermano(X,Y) <- hermano(Y,X).
hermano(b,a) <- verdad.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesión                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- ['meta_pa.pl','meta_pa_e2.pl'].
% Yes
% 
% ?- prueba_pa(hermano(a,X),1).
% X = b ;
% No
% 
% ?- prueba_pa(hermano(X,Y),1).
% X = a  Y = b ;
% X = b  Y = a ;
% No
% 
% ?- prueba_pa(hermano(a,X),2).
% X = b ;
% No
% 
% ?- prueba_pa(hermano(a,X),3).
% X = b ;
% X = b ;
% No
% 
% ?- trace(prueba_pa).
%         prueba_pa/2: call redo exit fail
% Yes
% 
% ?- prueba_pa(hermano(a,X),3).
% T Call:  (  7) prueba_pa(hermano(a, _G230), 3)
% T Call:  (  8) prueba_pa(hermano(_G230, a), 2)
% T Call:  (  9) prueba_pa(hermano(a, _G230), 1)
% T Call:  ( 10) prueba_pa(hermano(_G230, a), 0)
% T Call:  ( 11) prueba_pa(hermano(a, _G230), -1)
% T Fail:  ( 11) prueba_pa(hermano(a, _G230), -1)
% T Call:  ( 11) prueba_pa(verdad, -1)
% T Exit:  ( 11) prueba_pa(verdad, -1)
% T Exit:  ( 10) prueba_pa(hermano(b, a), 0)
% T Exit:  (  9) prueba_pa(hermano(a, b), 1)
% T Exit:  (  8) prueba_pa(hermano(b, a), 2)
% T Exit:  (  7) prueba_pa(hermano(a, b), 3)
% 
% X = b ;
% T Redo:  ( 11) prueba_pa(verdad, -1)
% T Fail:  ( 11) prueba_pa(verdad, -1)
% T Fail:  ( 10) prueba_pa(hermano(_G230, a), 0)
% T Fail:  (  9) prueba_pa(hermano(a, _G230), 1)
% T Call:  (  9) prueba_pa(verdad, 1)
% T Exit:  (  9) prueba_pa(verdad, 1)
% T Exit:  (  8) prueba_pa(hermano(b, a), 2)
% T Exit:  (  7) prueba_pa(hermano(a, b), 3)
% 
% X = b ;
% T Redo:  (  9) prueba_pa(verdad, 1)
% T Fail:  (  9) prueba_pa(verdad, 1)
% T Fail:  (  8) prueba_pa(hermano(_G230, a), 2)
% T Fail:  (  7) prueba_pa(hermano(a, _G230), 3)
% 
% No
