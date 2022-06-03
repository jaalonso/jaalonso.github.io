% GCD_analisis.pl
% �rbol de an�lisis con gram�ticas de cl�usulas definidas.
% Jos� A. Alonso Jim�nez <jalonso@cs.us.es>
% Sevilla,  8 de Diciembre de 2003
% =============================================================================

oraci�n(o(SN,SV))           -->  sintagma_nominal(SN), 
                                 sintagma_verbal(SV).
sintagma_nominal(sn(N))     -->  nombre(N).
sintagma_nominal(sn(Art,N)) -->  art�culo(Art), 
                                 nombre(N).
sintagma_verbal(sv(V,SN))   -->  verbo(V), 
                                 sintagma_nominal(SN).
art�culo(art(el))           -->  [el].
nombre(n(gato))             -->  [gato].
nombre(n(perro))            -->  [perro].
nombre(n(pescado))          -->  [pescado].
nombre(n(carne))            -->  [carne].
verbo(v(come))              -->  [come].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sesi�n                                                                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ?- oraci�n(A,[el,gato,come,pescado],[]).
% A = o(sn(art(el), n(gato)), sv(v(come), sn(n(pescado)))) 
% Yes
% ?- phrase(oraci�n(A),[el,gato,come,pescado]).
% A = o(sn(art(el), n(gato)), sv(v(come), sn(n(pescado)))) 
% Yes
%  
% ?- listing([oraci�n,sintagma_nominal,sintagma_verbal,art�culo,nombre,verbo]).
% 
% oraci�n(o(A, B), C, D) :-
%    sintagma_nominal(A, C, E),
%    sintagma_verbal(B, E, D).
% 
% sintagma_nominal(sn(A), B, C) :-
%    nombre(A, B, C).
% sintagma_nominal(sn(A, B), C, D) :-
%    art�culo(A, C, E),
%    nombre(B, E, D).
% 
% sintagma_verbal(sv(A, B), C, D) :-
%    verbo(A, C, E),
%    sintagma_nominal(B, E, D).
% 
% art�culo(art(el), [el|A], A).
% 
% nombre(n(gato), [gato|A], A).
% nombre(n(perro), [perro|A], A).
% nombre(n(pescado), [pescado|A], A).
% nombre(n(carne), [carne|A], A).
% 
% verbo(v(come), [come|A], A).
% 
% Yes
% 
