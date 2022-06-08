% vecino.pl
% Base de conocimiento para el metaintérprete ampliado.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla, 8-junio-2022
% ======================================================================

% Operadores
% ==========

% `<-' es el `si' del nivel objeto 
:- op(1100, xfx, <-).

% `&' es la conjunción en el nivel objeto 
% `;' es la disyunción en el nivel objeto 
:- op(1000, xfy, [&,;]).

% Base de conocimiento
% ====================

vecino(X,Y) <- Y is X-1 ; Y is X+1.

% Sesión
% ======

% ?- [meta_ampliado].
% true.
% 
% ?- prueba(vecino(2,3)).
% true 
% 
% ?- prueba(vecino(3,2)).
% true 
% 
% ?- trace.
% true.
% 
% [trace]  ?- prueba(vecino(2,3)).
%    Call: (10) prueba(vecino(2,3)) ? 
%    Call: (11) predefinido(vecino(2,3)) ? 
%    Fail: (11) predefinido(vecino(2,3)) ? 
%    Redo: (10) prueba(vecino(2,3)) ? 
%    Call: (11) vecino(2,3)<-_8892 ? 
%    Exit: (11) vecino(2,3)<-3 is 2-1;3 is 2+1 ? 
%    Call: (11) prueba((3 is 2-1;3 is 2+1)) ? 
%    Call: (12) prueba(3 is 2-1) ? 
%    Call: (13) predefinido(3 is 2-1) ? 
%    Exit: (13) predefinido(3 is 2-1) ? 
%    Call: (13) 3 is 2-1 ? 
%    Fail: (13) 3 is 2-1 ? 
%    Redo: (12) prueba(3 is 2-1) ? 
%    Call: (13) 3 is 2-1<-_9318 ? 
%    Fail: (13) 3 is 2-1<-_9362 ? 
%    Fail: (12) prueba(3 is 2-1) ? 
%    Redo: (11) prueba((3 is 2-1;3 is 2+1)) ? 
%    Call: (12) prueba(3 is 2+1) ? 
%    Call: (13) predefinido(3 is 2+1) ? 
%    Exit: (13) predefinido(3 is 2+1) ? 
%    Call: (13) 3 is 2+1 ? 
%    Exit: (13) 3 is 2+1 ? 
%    Exit: (12) prueba(3 is 2+1) ? 
%    Exit: (11) prueba((3 is 2-1;3 is 2+1)) ? 
%    Exit: (10) prueba(vecino(2,3)) ? 
% true 
