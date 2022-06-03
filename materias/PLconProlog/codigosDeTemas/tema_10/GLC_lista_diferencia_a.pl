% GLC_lista_diferencia.pl
% Gramáticas libres de contexto mediante lista de diferencia.
% José A. Alonso Jiménez <jalonso@cs.us.es>
% Sevilla, 8 de Diciembre de 2003
% =============================================================================

o(A-B) :-
   sn(A-C),
   sv(C-B).

sn(A-B) :-
   n(A-B).
sn(A-B) :-
   a(A-C),
   n(C-B).

sv(A-B) :-
   v(A-C),
   sn(C-B).

a([e|A]-A).
n([g|A]-A).
n([p|A]-A).
v([c|A]-A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesion                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- o([e,g,c,p]-[]).
% Yes
% 
% ?- o([e,c,p]-[]).
% No
% 
% ?- trace([o,sn,sv,a,n,v]).
% %         o/1: [call, redo, exit, fail]
% %         sn/1: [call, redo, exit, fail]
% %         sv/1: [call, redo, exit, fail]
% %         a/1: [call, redo, exit, fail]
% %         n/1: [call, redo, exit, fail]
% %         v/1: [call, redo, exit, fail]
% 
% Yes
% ?- o([e,g,c,p]-[]).
%  T Call: (6) o([e, g, c, p]-[])
%  T Call: (7) sn([e, g, c, p]-_G390)
%  T Call: (8) n([e, g, c, p]-_G390)
%  T Fail: (8) n([e, g, c, p]-_G390)
%  T Redo: (7) sn([e, g, c, p]-_G390)
%  T Call: (8) a([e, g, c, p]-_G393)
%  T Exit: (8) a([e, g, c, p]-[g, c, p])
%  T Call: (8) n([g, c, p]-_G390)
%  T Exit: (8) n([g, c, p]-[c, p])
%  T Exit: (7) sn([e, g, c, p]-[c, p])
%  T Call: (7) sv([c, p]-[])
%  T Call: (8) v([c, p]-_G402)
%  T Exit: (8) v([c, p]-[p])
%  T Call: (8) sn([p]-[])
%  T Call: (9) n([p]-[])
%  T Exit: (9) n([p]-[])
%  T Exit: (8) sn([p]-[])
%  T Exit: (7) sv([c, p]-[])
%  T Exit: (6) o([e, g, c, p]-[])
% 
% Yes
% 
% ?- o([e,c,p]-[]).
%  T Call: (6) o([e, c, p]-[])
%  T Call: (7) sn([e, c, p]-_G354)
%  T Call: (8) n([e, c, p]-_G354)
%  T Fail: (8) n([e, c, p]-_G354)
%  T Redo: (7) sn([e, c, p]-_G354)
%  T Call: (8) a([e, c, p]-_G357)
%  T Exit: (8) a([e, c, p]-[c, p])
%  T Call: (8) n([c, p]-_G354)
%  T Fail: (8) n([c, p]-_G354)
%  T Fail: (8) a([e, c, p]-_G357)
%  T Fail: (7) sn([e, c, p]-_G354)
%  T Fail: (6) o([e, c, p]-[])
% 
% No
% 
% ?- time(o([e,g,c,p]-[])).
% % 9 inferences in 0.00 seconds (Infinite Lips)
% Yes
% ?- time(o([e,c,p]-[])).
% % 5 inferences in 0.00 seconds (Infinite Lips)
% No


