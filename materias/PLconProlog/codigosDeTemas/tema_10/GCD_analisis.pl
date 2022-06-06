% GCD_analisis.pl
% Árbol de análisis con gramáticas de cláusulas definidas.
% José A. Alonso Jiménez <https://jaalonso.github.io>
% Sevilla,  6-junio-2022
% ======================================================================

% oración(A,L,[]) se verifica si A es el árbol de análisis sintáctico de
% la oración L. Por ejemplo,
%    ?- oración(A,[el,gato,come,pescado],[]).
%    A = o(sn(art(el),n(gato)),sv(v(come),sn(n(pescado)))) 
%    
%    ?- phrase(oración(A),[el,gato,come,pescado]).
%    A = o(sn(art(el),n(gato)),sv(v(come),sn(n(pescado)))) 
oración(o(SN,SV))           -->  sintagma_nominal(SN), 
                                 sintagma_verbal(SV).
sintagma_nominal(sn(N))     -->  nombre(N).
sintagma_nominal(sn(Art,N)) -->  artículo(Art), 
                                 nombre(N).
sintagma_verbal(sv(V,SN))   -->  verbo(V), 
                                 sintagma_nominal(SN).
artículo(art(el))           -->  [el].
nombre(n(gato))             -->  [gato].
nombre(n(perro))            -->  [perro].
nombre(n(pescado))          -->  [pescado].
nombre(n(carne))            -->  [carne].
verbo(v(come))              -->  [come].

% Programa correspondiente a la GCD
%    ?- listing([oración,sintagma_nominal,sintagma_verbal,artículo,nombre,verbo]).
%    oración(o(SN, SV), A, B) :-
%        sintagma_nominal(SN, A, C),
%        sintagma_verbal(SV, C, B).
%    
%    sintagma_nominal(sn(N), A, B) :-
%        nombre(N, A, B).
%    sintagma_nominal(sn(Art, N), A, B) :-
%        artículo(Art, A, C),
%        nombre(N, C, B).
%    
%    sintagma_verbal(sv(V, SN), A, B) :-
%        verbo(V, A, C),
%        sintagma_nominal(SN, C, B).
%    
%    artículo(art(el), [el|A], A).
%    
%    nombre(n(gato), [gato|A], A).
%    nombre(n(perro), [perro|A], A).
%    nombre(n(pescado), [pescado|A], A).
%    nombre(n(carne), [carne|A], A).
%    
%    verbo(v(come), [come|A], A).
%    
%    true.
